Shader "MyShader/RiverTexture"
{
	Properties
	{
		_MainColor("MainColor",Color) = (0.3,0,0,1)
		_MainTex("MainTexture",2D) = "white"{}
		_ScrollXSpeed("ScrollXSpeed",Range(0,1)) = 0.1
		_ScrollYSpeed("ScrollYSpeed",Range(0,1)) = 0.1
	}
	SubShader
	{
		Tags { "RenderType" = "Opaque"}
		LOD 200

		CGPROGRAM

		#pragma surface surf Lambert 

		sampler2D _MainTex;
		float4 _MainColor;
		float _ScrollXSpeed;
		float _ScrollYSpeed;

		struct Input
		{
			float2 uv_MainTex;
		};

		void surf(Input IN,inout SurfaceOutput o)
		{
			fixed2 scrolledUV = IN.uv_MainTex;//缓存使用的贴图的UV坐标
			fixed XScrollValue = _ScrollXSpeed * _Time;//按指定速度 增加X和Y方向的值
			fixed YScrollValue = _ScrollYSpeed * _Time;

			scrolledUV += fixed2(XScrollValue,YScrollValue);//将新的XY值 增加给原来的UV坐标

			half4 c = tex2D(_MainTex,scrolledUV);//获取指定坐标的颜色
			o.Albedo = c.rgb;//指定输出的RGB值
			o.Alpha = c.a;//指定输出的ALPHA 通道值
		}

		ENDCG
	}
	FallBack"Diffuse"
}
