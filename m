Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D46D35168
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 10:02:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12A2610E628;
	Wed,  1 Apr 2026 10:02:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cDexLiIe";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IZ73KCnA";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4436610E3A6
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 10:02:56 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6314SIUu3364203
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Apr 2026 10:02:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eS40vc51JlECGN/gZPmIK/gLtGZq9a75bp6sZnyVgUk=; b=cDexLiIeLbjHatZ+
 bkAYrPQJmCLck7Kwj5I54BHOw5AplIwWGckzdKJM2drGcLU7SaqHAW7llq8vaHWK
 4T4KcZeaNlsHHolv7hfsXBzC61fvEaMV9kng1mfbJeaijsp+fUrmSzrCHKeBIihI
 Zq58a4WoRPdi7XjU6cvWDn/kefFaqqmoEs0jJhkmRyIGMNhmSo5eXjK/jtn1OqY6
 Vn8j4Z6CbF/0aNHPTolXUzsFVvb8JTKE8pMphhuGZ120EQvDR6cBfTA+r8Iboc4R
 KfHLOFrB12TgnFb58K2fWAeIZ0CSgrnKAiq0prfeowRII2yMCJWVsLEagbbbO3Rn
 5PVI5A==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8nddjstp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 10:02:55 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-60531938f46so252808137.0
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 03:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775037775; x=1775642575;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eS40vc51JlECGN/gZPmIK/gLtGZq9a75bp6sZnyVgUk=;
 b=IZ73KCnAL+SlQj+rlTp+DGhCSBZ7y0H5F9DlAs4fDjZT/+Ao2gmgTAFf1ZX70h8xjs
 JqZrOTXmUMNXqJvOBmtMTCqldN9KrEN4e4seRqx0VQV84NoiUy0XOYEh3M1gY4jLoH/e
 3DRWyG2oIIv2vDsbSfQmhxsvwBHOqtgbP5NZsWKnfeVV9S/sGcDZ5EFqSPOgcA216KzI
 OHDYrb2kbuKVbgbFcuWNhQnHXFsjC9oBJMdjXCuNuE6spmEAlyq+MBaeOFyzFToqI+2V
 +gxtKcYbMRxxTGTFKijP/XpXDljEDksv2uXSMNO9zgKlSYcboT7IVsR81tEFNBq9uwkp
 AYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775037775; x=1775642575;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eS40vc51JlECGN/gZPmIK/gLtGZq9a75bp6sZnyVgUk=;
 b=BwA0NHAJpAa8gbdvnmFNvRNkYcmmeSY50X7IL0IICoUMqtMF6QtzH1oK4sd/SEqDbn
 vNjYoH7te6/R3+DdOXHBt9yiOLPBSaENv97aZqgumLR3a4J43zNoHWcPcQqHg57yv/cd
 csgP9WOYYsIOQP+fcSApdkDv+cNwT1OfjLe/JRNm8zWboqVeUuHl90GQuf8NqqXjb5s4
 W1Nt1wdCoe/LuiXPDIgB5G43I8JYqoAUIf6vAnpeAnqENW9wv5h8d4sV9eGapLQ3rXYE
 0KVjKmTaWkEPI2m7y3YIT4Pv0vb2+FoKLOc6zhCCRezaBr9uNDevx3A6c2rat04qPN1d
 gl4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9BI1gqmAZuw9PEAq4U3grUmuTuV74KShgLWliEH06bQ9Z6Yng9rGEcE3QB3RzaCFkrHk0ZGhKLHc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyMQPQruk8FsoDXJOyuzxB1e3bxsQu+wYLBrysw+VtUvWr11mhz
 gmmZ8WOaZyRfKxdh2gwINN3MTzOBfcE1aRTKCcePE0UnUc7ToxsRiTP855vo9vAmkA7sRE3Sd7W
 sScOMVY2CWaVNw/Y1kK1QzQHqziKy5QOlwBV1ngnwSKGNuMGHMzigoaHXyg2w4mFZ8Mhp+6A=
X-Gm-Gg: ATEYQzxrGleXM9vt3ob0KVXOEVl1v02K5ZQMQku32rJO6Jx6xngvBUuLyQDJjjPKfqO
 oBbTvM7ZO2v3bIrwos4qhzqIIgwD3K5huAF4g9ICbX1VjQa5tmWjJFyv5BnsNt9xdZ/+r919H1X
 o9IVvhu+zlEqIAVGX0vDPSpdRb0hFBmKbutNAZ/peDOgO6qBmpqBVOohGtr7eAXWh51A3wpAIq2
 GXZQf8TUqrhdHhl0+QooQEQO2O5lEp4OKKpE/0tOB7SyLJBLgwKJ2yMoiM51xJJO6nd1XXiSRkk
 esuQF85ZXBIw+db3Bjt1jOiVhGLRBoLqza6ylPr9bsVCnTo4slA47oZBeMZ05pqoRUDHe0kTyj1
 3YF8Nv0iF8gmDITy3vLWfnQMCmkVmCl83ORsYYRJNOfMxwciCz8bMgkgvUvMzcCoQ8/cgxHQABR
 5d5uY=
X-Received: by 2002:a05:6102:30aa:b0:5ff:2425:a0e7 with SMTP id
 ada2fe7eead31-60568225cdamr336231137.6.1775037774343; 
 Wed, 01 Apr 2026 03:02:54 -0700 (PDT)
X-Received: by 2002:a05:6102:30aa:b0:5ff:2425:a0e7 with SMTP id
 ada2fe7eead31-60568225cdamr336207137.6.1775037773868; 
 Wed, 01 Apr 2026 03:02:53 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-66b7275ff49sm3976479a12.6.2026.04.01.03.02.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 03:02:52 -0700 (PDT)
Message-ID: <6da36e75-effb-4e3e-a2f9-c0f3ebdbcc21@oss.qualcomm.com>
Date: Wed, 1 Apr 2026 12:02:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] drm/msm/adreno: add Adreno 810 GPU support
To: Alexander Koskovich <akoskovich@pm.me>,
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
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Luca Weiss <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260331-adreno-810-v1-0-725801dbb12b@pm.me>
 <20260331-adreno-810-v1-5-725801dbb12b@pm.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260331-adreno-810-v1-5-725801dbb12b@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ZfUQ98VA c=1 sm=1 tr=0 ts=69cced4f cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=N7jHRINKHDCQWMt9xiQA:9 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: XTDWNPV03agMmv4BCmH8v-Uy3MATqNOd
X-Proofpoint-ORIG-GUID: XTDWNPV03agMmv4BCmH8v-Uy3MATqNOd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA5MSBTYWx0ZWRfX9qrtLPS5lvOI
 6eK5/NTQyHeGQe1ZxzSiTpNiPlxacG7pZYWwPvfKVW3dNO1xdMRQA7ctfu7LbSOjUvflqG8BUsS
 TuRbpFrZu+HlXwhS3AcPNG841FVGsCcI0CdXdfC8UFOytpNB+3A4bDMA2rp2CZgjy/CXXmo63RE
 /5JEm0czWzDejbSRopxPQSoZkKVO1ZWQeq2pDxX4fjnI8rK9goFlkPqmTFmAE1TdY0/iiu4BDf5
 BI3Pe8bIOJF/X+7rONG+e/SO4mlOU+5J9c+bJCuxN/WwY1x0su63QmdZ8+n10o+70KWH1yWWAMi
 jlAr1E3JhjO8BHXdIu05wbr1WCsD7KZHj6+hTsJRNVwhIMCpxg7zaQ/PprCKee7S0ZyRWsBJ0K4
 lEEkjsd7dqcMk9Qm6b0Lvn6RKTHRaJpb3/2MvTgzX4AUfKrBzA/tjNbDKEEUBFHr5ve0NgMjlgt
 IBbxSI7RMDYoleLniYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010091
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

On 4/1/26 4:17 AM, Alexander Koskovich wrote:
> Add catalog entry and register configuration for the Adreno 810
> found in Qualcomm SM7635 (Milos) based devices.
> 
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 271 ++++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h   |   5 +
>  2 files changed, 276 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> index 550ff3a9b82e..0d7d9c86205e 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> @@ -1799,6 +1799,240 @@ static const struct adreno_reglist_pipe x285_dyn_pwrup_reglist_regs[] = {
>  };
>  DECLARE_ADRENO_REGLIST_PIPE_LIST(x285_dyn_pwrup_reglist);
>  
> +static const struct adreno_reglist_pipe a810_nonctxt_regs[] = {
> +	{ REG_A8XX_CP_SMMU_STREAM_ID_LPAC, 0x00000101, BIT(PIPE_NONE) },
> +	{ REG_A8XX_GRAS_DBG_ECO_CNTL, 0x00f80800, BIT(PIPE_BV) | BIT(PIPE_BR) },
> +	{ REG_A6XX_PC_AUTO_VERTEX_STRIDE, 0x00000001, BIT(PIPE_BV) | BIT(PIPE_BR) },
> +	{ REG_A8XX_PC_VIS_STREAM_CNTL, 0x10010000, BIT(PIPE_BV) | BIT(PIPE_BR) },
> +	{ REG_A8XX_PC_CONTEXT_SWITCH_STABILIZE_CNTL_1, 0x00000002, BIT(PIPE_BV) | BIT(PIPE_BR) },
> +	{ REG_A8XX_PC_CHICKEN_BITS_1, 0x00000003, BIT(PIPE_BR) },
> +	{ REG_A8XX_PC_CHICKEN_BITS_1, 0x00000023, BIT(PIPE_BV) }, /* Avoid partial waves at VFD */
> +	{ REG_A8XX_PC_CHICKEN_BITS_2, 0x00000200, BIT(PIPE_BV) | BIT(PIPE_BR) },
> +	{ REG_A8XX_PC_CHICKEN_BITS_3, 0x00500000, BIT(PIPE_BV) | BIT(PIPE_BR) },
> +	{ REG_A8XX_PC_CHICKEN_BITS_4, 0x00500050, BIT(PIPE_BV) | BIT(PIPE_BR) },
> +	{ REG_A7XX_RB_CCU_CNTL, 0x00000068, BIT(PIPE_BR) },
> +	{ REG_A8XX_RB_RESOLVE_PREFETCH_CNTL, 0x00000007, BIT(PIPE_BR) },
> +	{ REG_A8XX_RB_CMP_DBG_ECO_CNTL, 0x00004000, BIT(PIPE_BR) },
> +	{ REG_A8XX_RBBM_NC_MODE_CNTL, 0x00000001, BIT(PIPE_NONE) },
> +	{ REG_A8XX_RBBM_SLICE_NC_MODE_CNTL, 0x00000001, BIT(PIPE_NONE) },
> +	{ REG_A8XX_RBBM_WAIT_IDLE_CLOCKS_CNTL, 0x00000030, BIT(PIPE_NONE) },
> +	{ REG_A8XX_RBBM_WAIT_IDLE_CLOCKS_CNTL2, 0x00000030, BIT(PIPE_NONE) },
> +	{ REG_A8XX_UCHE_GBIF_GX_CONFIG, 0x010240e0, BIT(PIPE_NONE) },
> +	{ REG_A8XX_RBBM_GBIF_CLIENT_QOS_CNTL, 0x22122212, BIT(PIPE_NONE) },
> +	{ REG_A8XX_RBBM_CGC_P2S_CNTL, 0x00000040, BIT(PIPE_NONE) },
> +	/*
> +	 * BIT(22): Disable PS out of order retire
> +	 * BIT(23): Enable half wave mode and MM instruction src&dst is half precision
> +	 */
> +	{ REG_A7XX_SP_CHICKEN_BITS_2, BIT(22) | BIT(23), BIT(PIPE_NONE) },
> +	{ REG_A7XX_SP_CHICKEN_BITS_3, 0x00300000, BIT(PIPE_NONE) },
> +	{ REG_A6XX_SP_PERFCTR_SHADER_MASK, 0x0000003f, BIT(PIPE_NONE) },
> +	{ REG_A7XX_SP_HLSQ_TIMEOUT_THRESHOLD_DP, 0x00000080, BIT(PIPE_NONE) },
> +	{ REG_A7XX_SP_READ_SEL, 0x0001ff00, BIT(PIPE_NONE) },
> +	{ REG_A6XX_TPL1_DBG_ECO_CNTL, 0x10000000, BIT(PIPE_NONE) },
> +	/* BIT(26): Disable final clamp for bicubic filtering */
> +	{ REG_A6XX_TPL1_DBG_ECO_CNTL1, 0x04000720, BIT(PIPE_NONE) },
> +	{ REG_A6XX_UCHE_MODE_CNTL, 0x80080000, BIT(PIPE_NONE) },
> +	{ REG_A8XX_UCHE_CCHE_MODE_CNTL, 0x00001000, BIT(PIPE_NONE) },
> +	{ REG_A8XX_UCHE_CCHE_CACHE_WAYS, 0x00000800, BIT(PIPE_NONE) },
> +	{ REG_A8XX_UCHE_CACHE_WAYS, 0x00080000, BIT(PIPE_NONE) },
> +	{ REG_A8XX_UCHE_VARB_IDLE_TIMEOUT, 0x00000020, BIT(PIPE_NONE) },
> +	{ REG_A7XX_VFD_DBG_ECO_CNTL, 0x00008000, BIT(PIPE_BV) | BIT(PIPE_BR) },
> +	{ REG_A8XX_VFD_CB_BV_THRESHOLD, 0x00500050, BIT(PIPE_BV) | BIT(PIPE_BR) },
> +	{ REG_A8XX_VFD_CB_BR_THRESHOLD, 0x00600060, BIT(PIPE_BV) | BIT(PIPE_BR) },
> +	{ REG_A8XX_VFD_CB_BUSY_REQ_CNT, 0x00200020, BIT(PIPE_BV) | BIT(PIPE_BR) },
> +	{ REG_A8XX_VFD_CB_LP_REQ_CNT, 0x00100020, BIT(PIPE_BV) | BIT(PIPE_BR) },
> +	{ REG_A8XX_VPC_FLATSHADE_MODE_CNTL, 0x00000001, BIT(PIPE_BV) | BIT(PIPE_BR) },
> +	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0x00900000, BIT(PIPE_BR) },
> +	{ },

I may be on an older tag or something, but:

$ diff /tmp/downstream.txt /tmp/upstream.txt
24a25
> { GEN7_SP_READ_SEL, 0x0001ff00, BIT(PIPE_NONE) },
27,28c28,29
< { GEN8_TPL1_DBG_ECO_CNTL1, 0x04000724, BIT(PIPE_NONE) },
< { GEN8_UCHE_MODE_CNTL, 0x00020000, BIT(PIPE_NONE) },
---
> { GEN8_TPL1_DBG_ECO_CNTL1, 0x04000720, BIT(PIPE_NONE) },
> { GEN8_UCHE_MODE_CNTL, 0x80080000, BIT(PIPE_NONE) },
31,32c32
< /* Disable write slow pointer in data phase queue */
< { GEN8_UCHE_HW_DBG_CNTL, BIT(8), BIT(PIPE_NONE) },
---
> { GEN8_UCHE_CACHE_WAYS, 0x00080000, BIT(PIPE_NONE) },


> +};
> +
> +static const u32 a810_protect_regs[] = {

$ diff /tmp/downstream.txt /tmp/upstream.txt

< A6XX_PROTECT_NORDWR(0x0ae00, 0x0),
< A6XX_PROTECT_NORDWR(0x0ae02, 0x4),
---
> A6XX_PROTECT_NORDWR(0x0ae00, 0x6),

-> the difference is that

SP_DBG_ECO_CNTL and SP_ADDR_MODE_CNTL are not protected

that might have been a part of the ^ difference

Also it may be that the better name for this table is a830_protect_regs[]


The other tables, I'm lost. Akhil, please take a look.


Konrad
