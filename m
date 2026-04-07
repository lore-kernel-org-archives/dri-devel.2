Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BA7FF5138
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 20:04:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1EBB10E10B;
	Tue,  7 Apr 2026 20:04:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jgGlEcP5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C23Erjml";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD59C10E10B
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 20:04:43 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637DIBHo3402359
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Apr 2026 20:04:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0Vjxvuw/FF1VPBI4n/D+FS0MDHLJtFBAmtaqwcmoPPA=; b=jgGlEcP5NRD1MUzj
 fVQuWsKJMV2SC+hWqG9FVSd/ir552grlW5p0aBLX62duRB3Eic31aWKespOiaJdM
 DzOOINccltoFOqSVh2wkwX3WC4MCuvyHvsgh3uXttgbvmw+1ebmxdHarUOgqbffH
 X8sVInGlKsXOXFfOVP6agwGAsIQufRMAIQIUnabr2MhwTZRKbOW/GG1NsqTEK6DN
 0b82mg1MGsrXiLRgFLOUnAku907W7XnggeWY4fhqpAbVxfvAl7GcBV8ZvX9AkYVq
 Z0byi9yy0Uv8YkCCwRV4PbxqfrY+cTiAY1ajNA7qUtcpk9PhVsH9NQ7a3wfSdVXK
 DZEiMA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrhve5d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 20:04:42 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b24308165dso137987005ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 13:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775592282; x=1776197082;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0Vjxvuw/FF1VPBI4n/D+FS0MDHLJtFBAmtaqwcmoPPA=;
 b=C23Erjml7X2yWgEbZetxcWP4qY9e7oGGMmHKVS27ubIBwSTqqcu04hKqtA6mmx5gMC
 8EaWMKV06ZT3VMt3uykVxOfTkBfUq007XiM9xRSRojCWtzya+1vwpPlbExUmvpDPlMK4
 gvWkdJY1CqjpDC3wi8mZoimAxrJhw3oKR/ReU5qRe6zjFdeqaapEcJGI9H2xgRGbQoiA
 nrjif6TF4v1D7ZsGfITBa5aQg5uEjzcs+ch4C9CV0t007w9CnynRdNvX9mgVPWD+jKRg
 qLa37WWkxPJL0TwvZq3f/J920a/4ctmM8dNyt1/g8h4YKWvgdt6ZLy45pgs+43AM8x+8
 i38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775592282; x=1776197082;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0Vjxvuw/FF1VPBI4n/D+FS0MDHLJtFBAmtaqwcmoPPA=;
 b=hzn/l3f9er+X9/4J6p/BmZNGxMRFGoxcpDI9XdKg1RSzQxXdqNX+AQVcTrkN5DosPi
 rmd7Ck4PAqAyoV81CGeXGWvT3BZTsNaNJhQSTjw2uGZUfqy7BQYke3BQjE1w5lrgkPZ4
 wa5lF2QzqHsVut79hEGG3nQjSVJoTsrOIn9/dWwu+WH5AbtNN668v1JWHndZmsU1fzpZ
 BzP6kI951OWd+nZe3wmgoNVV/mGgqwMgYJ2Hlf0EPKx99x/pGwaJkIaFPhXd+NXf4Kpd
 cgzY+n60XrSZvPXvnIBLQ0nlAqF6yV9qcg7+N5qIZ9Hu/kZZ1yzxwUALKjP8XnCCwhg0
 z9xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrumf7MxGQc7jnnXyCvswnCQADBviNAysdOqgl9VhDIB6WjHvOMD7udI5K6NoG6p4BtAjQAJJlINA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzMe9PxF4ilbSnz2QKH9NJLUULXUsTnzU/V6sJeybUJySmOeF57
 pIFYqpA59hEfdIM9Ul8OxQky6cEm7tSeZ4ThTisx/xhjiuTknvH3bO2AZxDhLEJgNnn86WoJY1f
 JPfjoLV3HWBBBw9XUR+McIr4rGHL8boaybuZgPHXPj4fvhp9p/oDC+cZUB2x28d3Xneieya4=
X-Gm-Gg: AeBDietoMjZjfkIQ43QttlyuG+imutZXjPXEzmbxsyqP3mX+QA1IgRjeXLlQF0CDOML
 9D8K3KIPZRHS2lJyE1uf1kuIERoBOUWxoILldvG1Eba9op9kDK5a4fDY0pu57JL8WID6O7Ygmjo
 ibMR++hOrKiFOI4Iaqi47Htt0WFWY7zu2Obo3JgwdVJx5fbKdRp6pUpMXyptA9Fq1RC5G/i2jiK
 6fC32LKC75BaStdBdUr3Zfje0dgAhl1APk3wtuJpCtAyj+Cg+T/InBNi1issvhpBG83rvHAMXaU
 ygXZ2THzGpcBLtDt8eY88W8gmG+9LeWp8snLHFdvt2qIlW2xjWnqlx6RsjWnKBbtMzCzhh69vOm
 MQ2jWv3m2IFsJWInvCuawvactESo51EEVCGR+nZj2tQ1H+Q==
X-Received: by 2002:a17:902:d2c8:b0:2b2:523f:50d with SMTP id
 d9443c01a7336-2b281802cacmr192447485ad.29.1775592281540; 
 Tue, 07 Apr 2026 13:04:41 -0700 (PDT)
X-Received: by 2002:a17:902:d2c8:b0:2b2:523f:50d with SMTP id
 d9443c01a7336-2b281802cacmr192446915ad.29.1775592280993; 
 Tue, 07 Apr 2026 13:04:40 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.229.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749cbce2sm178975185ad.79.2026.04.07.13.04.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 13:04:40 -0700 (PDT)
Message-ID: <c9ce392d-d1f8-421c-aff0-ef3b7d737df0@oss.qualcomm.com>
Date: Wed, 8 Apr 2026 01:34:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 3/6] drm/msm/adreno: set cx_misc_mmio regardless of
 if platform has LLCC
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Luca Weiss <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
References: <20260402-adreno-810-v2-0-ce337ca87a9e@pm.me>
 <20260402-adreno-810-v2-3-ce337ca87a9e@pm.me>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260402-adreno-810-v2-3-ce337ca87a9e@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE4MiBTYWx0ZWRfX8frRM7W5KdgY
 POV9bXfq9ihpQyq9hp9al5aoBbyL0or+q9ItEPEMEr+RBHiMPKmWkQQbZrDq+Stohi9qWb0Abr7
 9CEblW3MKfSqkl+lRXQ032DTf+9nBFZOJ8tedSBnqscNKB7HfP+xLBjc8MKP5i7DVz2SjEgFgNj
 yk6gTS9SK9JRFwKxKRrxYKc2FvQVkNJ5NJoI2qDj2ek38uKzZ1bO9ajyhX7PVDMvUbrcJQJs2nO
 bH/u5PzssPSwFzojWe4KV1wLICISirZUBYF3e/lzJ40xqfwRbZVMH71qRW4u+6vfUUuwT1yURnp
 CtHF5blFqE32b98rv/vPtrpIjR0u2VpuPVGdWuPSBbg/g34AFsWTIz5CMFgxMEr0VVngy/Murr7
 Gc7+ualUabmyH2SAidCOOeu/NFTjJ5qlgN6MMQfT0eUIRKVn//qK5UdHoCt+5BpXdyr5HRbdZjy
 CMWNsW+cz8HMASIlDEQ==
X-Proofpoint-GUID: UTSqBHSaq1lNce9IpHvc2E1z_Gs-j1_u
X-Authority-Analysis: v=2.4 cv=XPUAjwhE c=1 sm=1 tr=0 ts=69d5635a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=oIjhDLspr5RTlLLUpj0f1A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=zzMsImXSMt5mrjmxLFkA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: UTSqBHSaq1lNce9IpHvc2E1z_Gs-j1_u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_04,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070182
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 4/3/2026 4:39 AM, Alexander Koskovich wrote:
> Platforms without a LLCC (e.g. milos) still need to be able to read and
> write to the cx_mem region. Previously if LLCC slices were unavailable
> the cx_misc_mmio mapping was overwritten with ERR_PTR, causing a crash
> when the GMU later accessed cx_mem.
> 
> Move the cx_misc_mmio mapping out of a6xx_llc_slices_init() into
> a6xx_gpu_init() so that cx_mem mapping is independent of LLCC.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 38 ++++++++++++++++-------------------
>  1 file changed, 17 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 9847f83b92af..d691ad1f88b3 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -2039,7 +2039,7 @@ static void a6xx_llc_activate(struct a6xx_gpu *a6xx_gpu)
>  	struct msm_gpu *gpu = &adreno_gpu->base;
>  	u32 cntl1_regval = 0;
>  
> -	if (IS_ERR(a6xx_gpu->cx_misc_mmio))
> +	if (IS_ERR_OR_NULL(a6xx_gpu->llc_slice) && IS_ERR_OR_NULL(a6xx_gpu->htw_llc_slice))
>  		return;
>  
>  	if (!llcc_slice_activate(a6xx_gpu->llc_slice)) {
> @@ -2098,7 +2098,7 @@ static void a7xx_llc_activate(struct a6xx_gpu *a6xx_gpu)
>  	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
>  	struct msm_gpu *gpu = &adreno_gpu->base;
>  
> -	if (IS_ERR(a6xx_gpu->cx_misc_mmio))
> +	if (IS_ERR_OR_NULL(a6xx_gpu->llc_slice) && IS_ERR_OR_NULL(a6xx_gpu->htw_llc_slice))
>  		return;
>  
>  	if (!llcc_slice_activate(a6xx_gpu->llc_slice)) {
> @@ -2135,31 +2135,12 @@ static void a6xx_llc_slices_destroy(struct a6xx_gpu *a6xx_gpu)
>  static void a6xx_llc_slices_init(struct platform_device *pdev,
>  		struct a6xx_gpu *a6xx_gpu, bool is_a7xx)
>  {
> -	struct device_node *phandle;
> -
>  	/* No LLCC on non-RPMh (and by extension, non-GMU) SoCs */
>  	if (adreno_has_gmu_wrapper(&a6xx_gpu->base))
>  		return;
>  
> -	/*
> -	 * There is a different programming path for A6xx targets with an
> -	 * mmu500 attached, so detect if that is the case
> -	 */
> -	phandle = of_parse_phandle(pdev->dev.of_node, "iommus", 0);
> -	a6xx_gpu->have_mmu500 = (phandle &&
> -		of_device_is_compatible(phandle, "arm,mmu-500"));
> -	of_node_put(phandle);
> -
> -	if (is_a7xx || !a6xx_gpu->have_mmu500)
> -		a6xx_gpu->cx_misc_mmio = msm_ioremap(pdev, "cx_mem");
> -	else
> -		a6xx_gpu->cx_misc_mmio = NULL;
> -
>  	a6xx_gpu->llc_slice = llcc_slice_getd(LLCC_GPU);
>  	a6xx_gpu->htw_llc_slice = llcc_slice_getd(LLCC_GPUHTW);
> -
> -	if (IS_ERR_OR_NULL(a6xx_gpu->llc_slice) && IS_ERR_OR_NULL(a6xx_gpu->htw_llc_slice))
> -		a6xx_gpu->cx_misc_mmio = ERR_PTR(-EINVAL);
>  }
>  
>  #define GBIF_CLIENT_HALT_MASK		BIT(0)
> @@ -2621,6 +2602,7 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
>  	struct platform_device *pdev = priv->gpu_pdev;
>  	struct adreno_platform_config *config = pdev->dev.platform_data;
>  	const struct adreno_info *info = config->info;
> +	struct device_node *phandle;
>  	struct device_node *node;
>  	struct a6xx_gpu *a6xx_gpu;
>  	struct adreno_gpu *adreno_gpu;
> @@ -2656,6 +2638,20 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
>  
>  	a6xx_llc_slices_init(pdev, a6xx_gpu, is_a7xx);
>  
> +	/*
> +	 * There is a different programming path for A6xx targets with an
> +	 * mmu500 attached, so detect if that is the case
> +	 */
> +	phandle = of_parse_phandle(pdev->dev.of_node, "iommus", 0);
> +	a6xx_gpu->have_mmu500 = (phandle &&
> +		of_device_is_compatible(phandle, "arm,mmu-500"));
> +	of_node_put(phandle);
> +
> +	if (is_a7xx || !a6xx_gpu->have_mmu500)

Instead of this check, I feel it is better to just add a
WARN_ONCE(a6xx_gpu->cx_misc_mmio) in the a6xx_cx_misc_* io accessors.
Then "a6xx_gpu->have_mmu500" init can be moved to the llc_init(). But
that is outside the scope of this series.

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil

> +		a6xx_gpu->cx_misc_mmio = msm_ioremap(pdev, "cx_mem");
> +	else
> +		a6xx_gpu->cx_misc_mmio = NULL;
> +
>  	ret = a6xx_set_supported_hw(&pdev->dev, a6xx_gpu, info);
>  	if (ret) {
>  		a6xx_llc_slices_destroy(a6xx_gpu);
> 

