Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3475C606A886
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 18:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=glISu5jm;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UhSY2Gjd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AF8F10FD2A;
	Wed, 11 Nov 2026 18:16:34 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BBFB10FD2A
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 18:16:23 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABHtTJp2980855
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 18:16:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=REvih3wAsG/3Y8nmSLavA6sF
 WJivHfgQW3aPqY6xVOc=; b=glISu5jmcoB4td6nZz5qG/2jm/qi4dD5Rm/9nSsa
 /I0Gl1GenJw0gJ0xFGG58LM2hwKHwHJYnsp1mOl7Imy5Wmr5+Sj3759L7ygtlwP1
 kKiIHi/sWbDtQz/DNgL9bnNJlOQWYwZQYUTix+NhFXbkDl5d7MLlNPku/BSlpKHw
 vvEvz8erB0bQP5V+CVfQIbrJ2ChUzhYDQE6SqVkGCRNGt3tQ577rEL1GABb3rc0u
 Y9OgQkxts7fON1oYYDRihHuGEGPb0E4ER1zYUCcXE+Lj027hU0I/ksXWRSH0XyCw
 8/DYX8de6VRdE7t1U0ztcqK+WKh8V2VGqOFG6HLzkXNJBg==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvksmakbs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 18:16:22 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5ead18311ebso1055850e0c.3
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 10:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794420981; x=1795025781;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=REvih3wAsG/3Y8nmSLavA6sFWJivHfgQW3aPqY6xVOc=;
 b=UhSY2GjdYdFNsLCcOYSN8+05OJH3nLOV80Ind1g21n+jltJteJE2jewia+57BlM0vC
 uSAOoVG7+EmoHMc0FBWJUlbgiCirz1lkvAuuKVraJXwMR74+Pu8QprvdhpD+WJFW9r/S
 3bBmLnvX+LUKdtTqag6SlvnjxPWVMDZPpXYXeXoB2wjZA99g+LuJIrUTmET94TfpGQBq
 rDikBVZ+Et7oZ8k0Jy5U+rMZu1eYRwqg90RR2TWyubVTfIP8eq/rmY7wtBQQA2NAS5E9
 BKiLhuYEYJ+AVUex4GK4RGFCBaJUOeU3TD1u1YJCkvFbExnsq81wX9fUQEz2FbfV9sUT
 VxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794420981; x=1795025781;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=REvih3wAsG/3Y8nmSLavA6sFWJivHfgQW3aPqY6xVOc=;
 b=HngvPvRWlvzWFn+fR5ckBfWYA6YZMaQ33LpVn/sXpU0+X8Ey6RS8gxmAiui6qH0S7H
 D8dY49VNYIbdD4NelKruHFUeZ6SULSw5BLcxrY+l07kt6skkftUqWUk/QL7nblEgFtvj
 a9H+52apiOc08a3S7jy37YUd2h6tGMN4uOIMyF8m8TrPGC5YzHdryAYga72AXJvI2wYZ
 ynsDAgX9qA+KMgRmQHQltzpdWNTEHhVBqA1l8K5/XIDqkttjX1HGulD4YB9xVxhEMKwv
 /UrNR6EQi2iVUnhDtmtm6K8Jw0ngf5PsSMb4NiHScdlhJ5rONBHEGJLZNxIqYETqU0FP
 Pv8Q==
X-Forwarded-Encrypted: i=1;
 AL+hErEWjyZm4W4n5X3dMsZ7mdcInhr8Abl2N+SxB7MoqsNoN0joN71xm5tOQU3FvuWS/1f94GzNxeg9sAw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+rj1S7jAL5lUx9aNwkgpRNPnpB+8fXS+mt5w0ppsi7goy0kgiT
 h4GUP+jNLMaDjQ0gG4p8Jk4Fd+mFjKocOIG92NHSxDfGCkCjjz4ILfqpbRpXPiVdETWnhIAWH9c
 7WcRKXm0XHPFnihkeJe/OiEukK/PO+H6t9m9tg52EClOSBG4z9g1icPvXEIiWEJIJyYde7CA=
X-Gm-Gg: AYBFou0KE5qYRsMzxUTiaNOgNq2/bLOU4T/31+Z7oGPx9lIMbhpXLrU0SjKGMbvRqEY
 HXmtq5TlUTw5g/0XZycn0t0Eb9kkEDmS1b7cUr6LUuzc5rXjr2abJVKPqTRvGUu960weNNCDLOX
 PiUrCru9A9MM8zDeBTPzN5HD+7awWDRhXXEiE/N1/Gt8CdQl/0AcPHo4Rhg/VhGIoYZ803cx7JV
 yxDvQRXvip1e6oW+Yy2Dj1U8iIy1M7KOFVl7JBlSSOaD3cVtt2ne3qsrULk9JRXCEbNAO6p35yk
 dzwarFZh1thl72K0JawCH9IZ0tGs0J9pF6xxn0yzUoJKY0oizJfYPQrmAmmHJZbv3dZhyWHZU9P
 60Eu+raHDr+9uIQZEz/lMQ/XsU0bP2iBUHxO1KMyhSjnkBxKmV7ISuu3srPnVVPe/0cWEZmn+Yh
 cVWH/cJzhPOmH+1fh7JD2OQnTzUUi/oM3+IwuXF5zEnZxC/e/fPH8rn2uIB1bLdA==
X-Received: by 2002:a05:6122:e253:b0:5e9:7a1a:5ad5 with SMTP id
 71dfb90a1353d-5ee1c46bab6mr1148666e0c.20.1794420981198; 
 Wed, 11 Nov 2026 10:16:21 -0800 (PST)
X-Received: by 2002:a05:6122:e253:b0:5e9:7a1a:5ad5 with SMTP id
 71dfb90a1353d-5ee1c46bab6mr1148604e0c.20.1794420980694; 
 Wed, 11 Nov 2026 10:16:20 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae1bdb2c94sm625101fa.26.2026.11.11.10.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 10:16:19 -0800 (PST)
Date: Wed, 11 Nov 2026 20:16:16 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Del Regno <angelogioacchino.delregno@somainline.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Mahadevan <quic_mahap@quicinc.com>,
 Richard Acayan <mailingradian@gmail.com>,
 Danila Tikhonov <danila@mainlining.org>, Robert Foss <rfoss@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: msm8996-oneplus: Disable
 disconnected DSI
Message-ID: <7gqjjq7v5krgibjxqelyjwmrfygfnbsvyfubgbpkshkvgdftxr@dwm3rdpoqbnb>
References: <20261111-display-msm-of-graph-v2-0-fdf8fd97f49d@oss.qualcomm.com>
 <20261111-display-msm-of-graph-v2-2-fdf8fd97f49d@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111-display-msm-of-graph-v2-2-fdf8fd97f49d@oss.qualcomm.com>
X-Proofpoint-GUID: -FHpvnxNyC0K9qVIOapWFpRusBcezEPU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3MiBTYWx0ZWRfX9SqPvCeYn11c
 fWCsdL/WycZHvNRO8bsX+1XBw/816xNkjKiMQ+0wowkPVQXTDcy0bPTv8qfIAYWoLyPhNQQT4U4
 M4AhimeCFBp/owunns6d9sL/5Jn5vm5sT18COPLMMReWux454+mvHuyFgudYEuEiP0J2PqRC31g
 EvSOYF1C/l7fI87pEZbcKw6eMbD+dz411r97CPlosGX7orxacL6GohNKm8bwz0Ud1nE9oSxC6Ne
 dPCgSmVMHr3waQPwhz5Wr7GfKzRiitftdoQav9wBppeSsL31Yz75paNQj6LWhmczy+XAMrL/nex
 hM9lWGjede8VpKFZOM0m6naGE3VXDKSKPvXbZgE/m4khMMuRm+4aWXNZd68RP4Pq+u5+Wm3KW7F
 7WfdWJEQBtZ0eVycENB7JnS9cssOORpCj2Q0tfN9+iJA9nym3lbPmivCUCXD6oSkhloVgkcTkoK
 YQb5AhNJy/aoKptk/bw==
X-Proofpoint-ORIG-GUID: -FHpvnxNyC0K9qVIOapWFpRusBcezEPU
X-Authority-Analysis: v=2.4 cv=O9isLx9W c=1 sm=1 tr=0 ts=6af4b0f6 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=PrdBiiE1VpZ4eXJVCeEA:9 a=CjuIK1q_8ugA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3MiBTYWx0ZWRfX1VDhvGOaW84r
 OavkZy8Fg/r/Vj/Oido0OQ05UwpGqfWjd2r5KaBfjjDueg0nJhbljevJoEuiGV/5sGxjnRqGkJa
 C0VbzhoqOM6MUCIhEmPp1nQyV/MOZj8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110072
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 06:45:01PM +0100, Krzysztof Kozlowski wrote:
> MDSS DSI and DSI PHY are useless, when nothing is attached (no panel
> description in DTS), thus should be disabled in DTS.  Linux MSM DRM
> drivers will also fail the probe.

I don't think they will fail the probe. Nothing will be registered, no
bridge will be attached to the DSI host, which means that the component
device will not be constructed / bound.

> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi
> index 7a3f8afae22d..9c2cef11e7a9 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi
> @@ -189,7 +189,6 @@ &mdss {
>  &mdss_dsi0 {
>  	vdda-supply = <&vreg_l2a_1p25>;
>  	vcca-supply = <&vreg_l22a_3p0>;
> -	status = "okay";
>  };
>  
>  &mdss_dsi0_out {
> @@ -198,7 +197,6 @@ &mdss_dsi0_out {
>  
>  &mdss_dsi0_phy {
>  	vcca-supply = <&vreg_l28a_0p925>;
> -	status = "okay";
>  };
>  
>  &mmcc {
> 
> -- 
> 2.53.0
> 

-- 
With best wishes
Dmitry
