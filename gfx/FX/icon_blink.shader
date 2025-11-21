Includes = {
	"buttonstate.fxh"
}

PixelShader =
{
	Samplers =
	{
		MapTexture =
		{
			Index = 0
			MagFilter = "Linear"
			MinFilter = "Linear"
			MipFilter = "None"
			AddressU = "Clamp"
			AddressV = "Clamp"
		}
	}
}

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
		    VS_OUTPUT Out;
		    Out.vPosition  = mul( WorldViewProjectionMatrix, float4( v.vPosition.xyz, 1 ) );
		    Out.vTexCoord  = v.vTexCoord + Offset;
		    return Out;
		}
	]]
}

PixelShader =
{
	MainCode PixelShaderUp
	[[
		float4 main( VS_OUTPUT v ) : PDX_COLOR
		{
		    float4 OutColor = tex2D( MapTexture, v.vTexCoord );

			if (OutColor.a < 0.01f)
			{
				return float4(0,0,0,0);
			}

			float tBorder  = Time * 4.0f;
			float tCenter  = Time * 10.0f;

			float glow = 0.5f + 0.5f * sin( tBorder );

			float flicker = 0.3f + 0.7f * abs( sin( tCenter ) );

			float2 uv = v.vTexCoord;

			float2 distToEdge;
			distToEdge.x = min(uv.x, 1.0f - uv.x);
			distToEdge.y = min(uv.y, 1.0f - uv.y);
			float distMin = min(distToEdge.x, distToEdge.y);

			float outer = 0.07f;
			float inner = 0.14f;

			float borderMask  = saturate( (outer - distMin) / (outer - inner) );
			float centerMask  = 1.0f - borderMask;

			float3 borderColorBase = OutColor.rgb;
			float3 borderGlowColor = float3(1.0f, 0.9f, 0.5f);
			float3 borderColor = lerp(borderColorBase, borderGlowColor, glow);
			borderColor *= (1.0f + 0.6f * glow);

			float3 centerColor = OutColor.rgb * (0.5f + 1.5f * flicker);

			OutColor.rgb = borderColor * borderMask + centerColor * centerMask;

			OutColor *= Color;
		    return OutColor;
		}
	]]
}

BlendState BlendState
{
	BlendEnable = yes
	SourceBlend = "src_alpha"
	DestBlend   = "inv_src_alpha"
}

Effect Up
{
	VertexShader = "VertexShader"
	PixelShader = "PixelShaderUp"
}

Effect Down
{
	VertexShader = "VertexShader"
	PixelShader = "PixelShaderUp"
}

Effect Disable
{
	VertexShader = "VertexShader"
	PixelShader = "PixelShaderUp"
}

Effect Over
{
	VertexShader = "VertexShader"
	PixelShader = "PixelShaderUp"
}
