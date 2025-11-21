Includes = { "buttonstate.fxh" }

VertexStruct VS_OUTPUT
{
    float4  vPosition : PDX_POSITION;
    float2  vTexCoord : TEXCOORD0;
};

VertexShader =
{
    MainCode VS
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
            Index=0 MagFilter="Linear" MinFilter="Linear" MipFilter="Linear"
            AddressU="Clamp" AddressV="Clamp"
        }
        MaskTexture =
        {
            Index=1 MagFilter="Linear" MinFilter="Linear" MipFilter="Linear"
            AddressU="Clamp" AddressV="Clamp"
        }
    }

    MainCode PS
    [[
        float4 main( VS_OUTPUT v ) : PDX_COLOR
        {
            const float DURATION = 0.35f;
            float p     = saturate( (Time - AnimationTime) / DURATION );
            float angle = p * 3.14159265f;
            float c     = abs( cos(angle) );

            float2 uv = v.vTexCoord; 
            float uCenter = uv.x - 0.5f;
            float halfVisible = 0.5f * c;
            if (abs(uCenter) > halfVisible)
                return float4(0,0,0,0);

            float uUnfold = uCenter / max(c, 1e-5f);

            float useBack = step(1.5707963f, angle);
            float uFront  = uUnfold + 0.5f;
            float uBack   = 1.0f - uFront;

            float2 uvFront = float2(uFront, uv.y);
            float2 uvBack  = float2(uBack,  uv.y);

            float4 colFront = tex2D( MapTexture,  uvFront );
            float4 colBack  = tex2D( MaskTexture, uvBack  );

            float4 col = lerp(colFront, colBack, useBack);

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

Effect Default { VertexShader="VS" PixelShader="PS" }
Effect Over    { VertexShader="VS" PixelShader="PS" }
Effect Down    { VertexShader="VS" PixelShader="PS" }
Effect Disable { VertexShader="VS" PixelShader="PS" }
