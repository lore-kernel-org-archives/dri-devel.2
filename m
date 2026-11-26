Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD09606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 19:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Y6vxztZ7;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gYvg2RX3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACFDD10EA47;
	Thu, 26 Nov 2026 19:26:49 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CD9110EA47
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 19:26:38 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQGcE5w596877
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 19:26:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RSbO/8C3j8RIVBHNdX+Dlhj+7Zj2tOE/srOubQ38wfA=; b=Y6vxztZ7S8v5heaq
 gLEDsIR0PNNktgZKZ+zUllJa3BnwCokbTyCKp35pawsJD7jUZLLCMflHewAhKqJS
 7BqPortcbmF9YLDvciYxtaqgpAHWcnSRq5DRVOfTQtmaNRR4fRR0Q5UKGz/Q7SmM
 5/wRD3IXwhdzsCJruxhIWegfLpDS/r/AAPsww0i6WTLTnYm6mRbHbE0LiQRtcCFr
 GDHMfZ0DfQkMD01mm2hmRHQObVww2sm4DEBmwNuH3d61LU2qBOIO1KE50Xdy6/aV
 SlT1DPOfnUdcv3VV6llZXD93nxzDYvizSLpaG6aMy2Nrkqi2//sHlhMrI3tf6/GC
 Vyt1Ew==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6rf90fa9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 19:26:37 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1b55f4f3bb8so4276742c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795721197; x=1796325997;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RSbO/8C3j8RIVBHNdX+Dlhj+7Zj2tOE/srOubQ38wfA=;
 b=gYvg2RX3Q9ABkX698Hc04iS25sIEyXLAkdFMO2czrwrxt7hIZSGRKzukra663SFCLg
 wrUh4aLGvhxE8sy9ukPHiFxyA2FaNM0r2ZlGCkEvYFcHsLhn77BCCuOuVE9MUAFkkdeI
 xRMkjZMXGrbNSlPhKRgQ0g8qC3SxzARbrdGISfqRtz9j6ITDLkmozJ5ZpTyJi6PL31nw
 pNPC7wrirfooPx0uOLdexUzcrw4NxgALnHhRVbrG8ILqu+Gy1U/GQPBreILO6jQXQr5Q
 LPL/MsY7tVzS26j1ieSqbJIGBkwoFrjcHNAs6+nZDN+SlFDrJM35HINergcFrHpbYp89
 JkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795721197; x=1796325997;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RSbO/8C3j8RIVBHNdX+Dlhj+7Zj2tOE/srOubQ38wfA=;
 b=13o6tytaPIzQbKoGip478WvugZpUYQzscC9q9ANF1VaIwv/nCnJgPidzAQFBaIQc0Z
 bfSybP1gKg6lGFDmJW8jKcskh6txD5o3p2lAeTUU8AhAfkeDvMnT19A13ZnevWdkumu8
 u55Z/LtRES0T+3kFCd0VpNgzq6WxU1FVcQBL4OZfQt82ogFPCnp6KIP3ngpkxuxQSjBa
 MohMmMvG9JRXAtLqO19ZguC+C4K2mMQP0gB03qvZwEeynIRyoGi4Izt7/Rzk+zxWXQ08
 jUzY7losEwCd8pYw9n+kSoUfLXSr9Tv41zItN7N6em4+w6QYPYX4U8FwjWi9zMAMeEbk
 O+1Q==
X-Forwarded-Encrypted: i=1;
 AL+hErG6d9VRnr/90OgK75NYFMxQ40scaHY9fRGSj+xXLOLz3Q+Axvgo/zBcRy9YNRfWBFTyAuMzC50F7yc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/GcG0cN92c8hyX+EjrCrr8yvRh2i8WLOTMJcpD7uRIaiIkGEL3
 AxputKSGhEoBEP/Dgz6GRt9g01LBiAL4VdfeX1STl0Sbwk+nrQLfpFJhXhyeEk72rTjFr1OEE81
 hEdY2B26A1Qayr79/6UPPLEy9bWFZJgmxTpzRiBirUutcP8fgBtqaMTiYnqLT7ABs+wzppeA=
X-Gm-Gg: AZFdTZfHv4rW/6SWU/cYa13aCjfIkJWjievIigZYXxL8cQmc9jYdWruaB7TZ8ObWOBF
 Dr9rKkNdIgRSG7kz4vqm1fh36U+bOI6DvexGx43ufaTUbUrxVIh9JDysVYaDMrTgA8fkMRVOEP5
 XztAbgMXyqYP5ZGcuJH8/SVrAz5xT1TyZ5j3Cw2MPqyWqlAi16mThOfb74U4M/SxI09z/VZtEyH
 hsUMw5WEpSADv+55ViJrvXKPL4tsj8lcapiIRJ+95uhbXV/7e16dQOtYh+TCt+ZGKZmigyFjM6P
 VZIDKXHmxheW4AkR32jsvKRy50odP/NV9OM6VZkZvutulIRUusBUX/Y3ICor8/mmi3RPDy8lBf+
 dBm2C/wOioqv4Zur8+5ZuZzMx4fVm5m0aT6NeD7xOQ5p6bvKg9vdZmLMp83CJ2G25DpItPBrjzw
 ==
X-Received: by 2002:a05:701b:2051:20b0:1b2:4998:a0df with SMTP id
 a92af1059eb24-1b5568fa273mr22224577c88.35.1795721197174; 
 Thu, 26 Nov 2026 11:26:37 -0800 (PST)
X-Received: by 2002:a05:701b:2051:20b0:1b2:4998:a0df with SMTP id
 a92af1059eb24-1b5568fa273mr22224548c88.35.1795721196695; 
 Thu, 26 Nov 2026 11:26:36 -0800 (PST)
Received: from [10.204.104.211] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566fdce48sm69877832eec.14.2026.11.26.11.26.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 11:26:36 -0800 (PST)
Message-ID: <83e49e4a-0e31-4802-bbcd-7e0c178b6ac0@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 00:56:31 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] drm/msm/a6xx: Add IFPC tables for Adreno 640/680
To: Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20261030-topic-a6xx_ifpc-v1-0-6992841a9a32@oss.qualcomm.com>
 <20261030-topic-a6xx_ifpc-v1-6-6992841a9a32@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20261030-topic-a6xx_ifpc-v1-6-6992841a9a32@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: XjhwbcJiYiVuzhKlrkesbccvMxma7fnv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA3NiBTYWx0ZWRfX8jD4Oay2NNV5
 533k9WWaMBtbw5mwaTFxGP+GSBSvXw5dEu9niFus7agCBHCSg73LuRZKWmsXcCEVAOtt/ftI49H
 tdY6rzcsNP35875Nj+lIGn1qKGunmxXm8X0vZzPdDG1eJMwAdsKvfAVZm0FH7mwx/PN7TcNqnR/
 9Mo/JH4udAIW2soK/AvpSQaCTZa9RoNYKEnvJ8SUHYkaTSlJgrXyQzkr85hvKyvKaV2toPIPxYx
 bZzz56I4facw95kOpZsvwfkOEtOhdyT9u24emVEw39XNjPcwspbCg3zMYWA4I6doyknxrh50zac
 9tphekEKA9Ku97cVt6Eiz97+/RozLHdHSFlOie5Ti6YTlSa3hsp6wlOd6vuLVDMPHy8M5dzVjAz
 5uZsYafm5CIjgIQdFOS6P8JWAiAzhOJ6GyaXMwLS6PK2MceSS1cEY8WQVojUWTZWbNbbnCOEq8H
 AIg1qsz1sxLBUtZAobQ==
X-Authority-Analysis: v=2.4 cv=cpkOAF4i c=1 sm=1 tr=0 ts=6b0887ed cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=PhAf4g791m7IZrnnNEMA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA3NiBTYWx0ZWRfX6lj9/AxUX4BC
 eiRgpswlUjJdZBl1Lm5iTvePJHyk3KbbYVRwXeD9FKwFZEVXx4sQTttacO8rM6phaS61zJERxhA
 RLA5HMXUx5axzMmx6NVDH+ic+55uYy8=
X-Proofpoint-GUID: XjhwbcJiYiVuzhKlrkesbccvMxma7fnv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_04,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260076
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
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/30/2026 3:34 PM, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Fill out the register tables to enable IFPC on these SKUs.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil

> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 47 +++++++++++++++++++++++++++++--
>  1 file changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> index 5e1d91a73a4e..89829fa8f4f4 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> @@ -814,6 +814,43 @@ static const u32 a630_pwrup_reglist_regs[] = {
>  
>  DECLARE_ADRENO_REGLIST_LIST(a630_pwrup_reglist);
>  
> +static const u32 a640_pwrup_reglist_regs[] = {
> +	REG_A6XX_VSC_ADDR_MODE_CNTL,
> +	REG_A6XX_GRAS_ADDR_MODE_CNTL,
> +	REG_A6XX_RB_ADDR_MODE_CNTL,
> +	REG_A6XX_PC_ADDR_MODE_CNTL,
> +	REG_A6XX_HLSQ_ADDR_MODE_CNTL,
> +	REG_A6XX_VFD_ADDR_MODE_CNTL,
> +	REG_A6XX_VPC_ADDR_MODE_CNTL,
> +	REG_A6XX_UCHE_ADDR_MODE_CNTL,
> +	REG_A6XX_SP_ADDR_MODE_CNTL,
> +	REG_A6XX_TPL1_ADDR_MODE_CNTL,
> +	REG_A6XX_UCHE_WRITE_RANGE_MAX,
> +	REG_A6XX_UCHE_WRITE_RANGE_MAX + 1,
> +	REG_A6XX_UCHE_TRAP_BASE,
> +	REG_A6XX_UCHE_TRAP_BASE + 1,
> +	REG_A6XX_UCHE_WRITE_THRU_BASE,
> +	REG_A6XX_UCHE_WRITE_THRU_BASE + 1,
> +	REG_A6XX_UCHE_GMEM_RANGE_MIN,
> +	REG_A6XX_UCHE_GMEM_RANGE_MIN + 1,
> +	REG_A6XX_UCHE_GMEM_RANGE_MAX,
> +	REG_A6XX_UCHE_GMEM_RANGE_MAX + 1,
> +	REG_A6XX_UCHE_FILTER_CNTL,
> +	REG_A6XX_UCHE_CACHE_WAYS,
> +	REG_A6XX_UCHE_MODE_CNTL,
> +	REG_A6XX_RB_NC_MODE_CNTL,
> +	REG_A6XX_TPL1_NC_MODE_CNTL,
> +	REG_A6XX_SP_NC_MODE_CNTL,
> +	REG_A6XX_PC_DBG_ECO_CNTL,
> +	REG_A6XX_RB_CONTEXT_SWITCH_GMEM_SAVE_RESTORE_ENABLE,
> +	REG_A6XX_UCHE_GBIF_GX_CONFIG,
> +	REG_A6XX_UCHE_CLIENT_PF,
> +	REG_A6XX_RBBM_GBIF_CLIENT_QOS_CNTL,
> +	REG_A6XX_RBBM_PERFCTR_CNTL,
> +};
> +
> +DECLARE_ADRENO_REGLIST_LIST(a640_pwrup_reglist);
> +
>  static const struct adreno_info a6xx_gpus[] = {
>  	{
>  		.chip_ids = ADRENO_CHIP_IDS(0x06010000),
> @@ -1115,7 +1152,8 @@ static const struct adreno_info a6xx_gpus[] = {
>  		},
>  		.gmem = SZ_1M,
>  		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
> -			  ADRENO_QUIRK_4GB_VA,
> +			  ADRENO_QUIRK_4GB_VA |
> +			  ADRENO_QUIRK_IFPC,
>  		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
>  		.funcs = &a6xx_gpu_funcs,
>  		.zapfw = "a640_zap.mdt",
> @@ -1124,6 +1162,8 @@ static const struct adreno_info a6xx_gpus[] = {
>  			.protect = &a630_protect,
>  			.gmu_cgc_mode = 0x00020202,
>  			.prim_fifo_threshold = 0x00180000,
> +			.ifpc_reglist = &a630_ifpc_reglist,
> +			.pwrup_reglist = &a640_pwrup_reglist,
>  		},
>  		.speedbins = ADRENO_SPEEDBINS(
>  			{ 0, 0 },
> @@ -1238,7 +1278,8 @@ static const struct adreno_info a6xx_gpus[] = {
>  		},
>  		.gmem = SZ_2M,
>  		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
> -			  ADRENO_QUIRK_4GB_VA,
> +			  ADRENO_QUIRK_4GB_VA |
> +			  ADRENO_QUIRK_IFPC,
>  		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
>  		.funcs = &a6xx_gpu_funcs,
>  		.zapfw = "a640_zap.mdt",
> @@ -1247,6 +1288,8 @@ static const struct adreno_info a6xx_gpus[] = {
>  			.protect = &a630_protect,
>  			.gmu_cgc_mode = 0x00020202,
>  			.prim_fifo_threshold = 0x00200200,
> +			.ifpc_reglist = &a630_ifpc_reglist,
> +			.pwrup_reglist = &a640_pwrup_reglist,
>  		},
>  	}, {
>  		.chip_ids = ADRENO_CHIP_IDS(0x06090000),
> 

