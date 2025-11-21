Includes = { "buttonstate.fxh" }

VertexStruct VS_OUTPUT
{
    float4  vPosition : PDX_POSITION;
    float2  vTexCoord : TEXCOORD0;
};

VertexShader =
{
    MainCode VertexShader
    [[
        VS_OUTPUT main( const VS_INPUT v )
        {
            VS_OUTPUT o;
            o.vPosition = mul( WorldViewProjectionMatrix, float4( v.vPosition.xyz, 1 ) );
            o.vTexCoord = v.vTexCoord;
            return o;
        }
    ]]
};

PixelShader =
{
    Samplers =
    {
        MapTexture =
        {
            Index     = 0
            MagFilter = "Linear"
            MinFilter = "Linear"
            MipFilter = "Linear"
            AddressU  = "Clamp"
            AddressV  = "Clamp"
        }
    }

    MainCode PixelShaderFlip
    [[
        float4 main( VS_OUTPUT v ) : PDX_COLOR
        {
            const float DURATION = 0.35f;
            float t     = saturate( (Time - AnimationTime) / DURATION );
            float angle = t * 3.14159265f;
            float c     = abs( cos( angle ) );

            float2 uv = v.vTexCoord;
            float uCenter = uv.x - 0.5f;
            float halfVisible = 0.5f * c;

            if (abs(uCenter) > halfVisible)
                return float4(0,0,0,0);

            float uUnfold = uCenter / max(c, 1e-5f);
            float atlasU;

            if (cos(angle) >= 0.0f) {
                atlasU = (uUnfold + 0.5f) * 0.5f;
            } else {
                float uLocal = (uUnfold + 0.5f);
                atlasU = (1.0f - uLocal) * 0.5f + 0.5f;
            }

            float2 atlasUV = float2( atlasU, uv.y );
            float4 col = tex2D( MapTexture, atlasUV );

            float shade = 0.35f + 0.65f * c;
            col.rgb *= shade;

            float edgeWidth = 0.02f;
            float edge = saturate( (halfVisible - abs(uCenter)) / max(edgeWidth, 1e-5f) );
            col.a *= edge;

            col *= Color;

            return col;
        }
    ]]
};

Effect Default { VertexShader = "VertexShader" PixelShader = "PixelShaderFlip" }
Effect Over    { VertexShader = "VertexShader" PixelShader = "PixelShaderFlip" }
Effect Down    { VertexShader = "VertexShader" PixelShader = "PixelShaderFlip" }
Effect Disable { VertexShader = "VertexShader" PixelShader = "PixelShaderFlip" }
