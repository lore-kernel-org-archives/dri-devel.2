Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E86FCA5FBE
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 13:18:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 824DB10F3B7;
	Wed, 30 Sep 2026 13:18:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FJPtWyJ9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SejPHgQj";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3633510F3B7
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 13:18:16 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UB7hIM2584061
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 13:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 b0XeiQBP16z/6q+80+PDDqmE4avHoAxEAHZJWQwfonY=; b=FJPtWyJ9lC84jmAy
 UdE8XPWuqaWr2Fs+U2eV8/QCyFXkZEBEVvgg0H7WKZvOLg4nYDohqPiVKw/dXDoF
 nVSN0pnff8rHlByEHm4vYplfJFXllLmBEmLzm1RcwOXfQPAIQfb3vpbLjoLJjRVM
 cFoml/4I9e9UUcBZvJgDa7FzYuKPIEJ64OTk9oK8rcxO+QdEVu4Q9qeIaXmqbGIi
 /xE2Nqd04rBEHrO9ojho/gFx4CiIxU4Vr5SMhcjdGcgOGvxe/42gGr/HFFdH2pJf
 +YzvVeHhRSVr61YrwFbO907pkSBvulS30Lro23POfcrw+paLp2rrYS//3jTEtkJH
 yKqCIg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0rhek0g2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 13:18:15 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3a4a053dcadso2060308a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 06:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790774294; x=1791379094;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=b0XeiQBP16z/6q+80+PDDqmE4avHoAxEAHZJWQwfonY=;
 b=SejPHgQjsEU6b0aBI+7y0jbSNiGBteayVc8H+Y8t9/GZrNDIHMqBjGpbySP7Y4zSzI
 LEFNIczhak4V9ScvRGPm6heJve47eiDL762ACZVtVTAxgP5gedFP2zeBMawBrR/K/Hx6
 RNN+uvXoTnF9/VAZ4jwShOccdgrnEVRf2156oPgAvNBAN9NMsEZrgH5VaWfU+APXztt3
 guF5rYaCBzxJSpHUcYaaZnVOVlNDBENRbwduPEXL1LsD4VPG/ypwlriItrRYb92UtIYQ
 fADknXrTkzQqQOr8UKPFXTtYJtSZmJ+JXAGoHB5yveYxK2mKhi2+w6CCkJNUXUx1YRSB
 FY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790774294; x=1791379094;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b0XeiQBP16z/6q+80+PDDqmE4avHoAxEAHZJWQwfonY=;
 b=v2JHbeB0cb2wIwW6d9vLzVKySaeJFpHSPDvZYRkOGRz7U6Rb/laL7TA5hC5khg5o1N
 72EWcLnuRDalk/EtfB0hvYU+F3Y71K3bT1d4690/4YssEOZC08auS2H0PlOBquJN8QbC
 IYY4a4NYyOepAIZuhLvufDnlcok4dhdMD3Zdmc+Klr6Q9oiHKyv346ovbE3W+iSyOu7b
 tzvVwhZ4kjDf4133TyfY5Ns9DQ4653od7u3pVCN3WpB0+b2bPsUeg9nXuhMZ8aX6yDcg
 FRfscTVZFDx/iydIoZ8BSBP9M/0Zm5XDy3ba5ENynhsyzscjt3NE5FqUnnyXg6SpIhy9
 ULfQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzkavF1VGkruOEmqVk81r77ahGmRnb5tMjy5RDBtZv/rC8u8/hR6fHwPSPooTY6uGPJYLN2FVF6eJc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kQu5/bWIHBQJlxgUgpEhqqGCr9RmLUIgzkQrPvRKRdP+cNGanU
 tjFTPRfgILoGR2I4ldAGPY1FZkeutGbkJINw1WKXQWuSGnwApQ2R/vRN+eMkQ/WOK6s6Wc2sLij
 IMvhJ2GKp77u11Xa1ny+fgW+b0XbfIwBbUpTXk5U35bijBTQDxPTAGKIR9LAUVUF5y+tsJfQ=
X-Gm-Gg: AYBFou1u1HOQC3CFF4s7oqVQA8B/eL6fdExlOiZU02QMH/l/4g6GNGgMaOxfJotSnb7
 xYoWmJ7hDAnfc+vGHjXuaftR89yLNujQgFf6MZSmdUjmIT4IYrQrp8LbBqUW41bhhOzRzHwmkTN
 5efuaMm4lk0a2L5ytWVtbnTZSVUTP/+fa1U69VGIdE/0Ajvstq879zVE1QGW06DQh6U6zDF4RBb
 nt2q3qsk0m558hZIXi9NIxjo296IRFwND39h66Hs6hiqhwBA+tDqo1ulgwBlKCCD5VumchQNC4d
 D9/XmOx8/kaothbYcWM4/+vxVDAsPgoznhbbrLbuYsVxVZ4OE/XDlmLxK+QWFSS0a/G7AXuUhF0
 stELcnpblRHCQC7GQ1bxhKC/P
X-Received: by 2002:a17:90a:e7c7:b0:3a2:af98:3c58 with SMTP id
 98e67ed59e1d1-3a4d059c0cbmr1474826a91.0.1790774293622; 
 Wed, 30 Sep 2026 06:18:13 -0700 (PDT)
X-Received: by 2002:a17:90a:e7c7:b0:3a2:af98:3c58 with SMTP id
 98e67ed59e1d1-3a4d059c0cbmr1474784a91.0.1790774293087; 
 Wed, 30 Sep 2026 06:18:13 -0700 (PDT)
Received: from [10.204.104.211] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4e697008asm389132a91.3.2026.09.30.06.18.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 06:18:12 -0700 (PDT)
Message-ID: <d6cb8aa3-1360-47cf-9ec2-e2403974bbed@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 18:48:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH msm-next] drm/msm/a8xx: report the GMEM size of the active
 slices
To: Rahul Pon <theflyingrahul@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260930111711.1160-1-theflyingrahul@gmail.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20260930111711.1160-1-theflyingrahul@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: FcA5VT8RW7uq2U6tvvz3oOIoW0f2wLx-
X-Proofpoint-ORIG-GUID: FcA5VT8RW7uq2U6tvvz3oOIoW0f2wLx-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA1MiBTYWx0ZWRfXzuGya8H5HT20
 gXqIpEjTxb5jSb7HRrk669YPb7YSWFZjf4JM65H5vJyS0AE5naOTzbWpU11MN0+vkCFC9VA1O0O
 8fmTY8Ndh6Axf0nJm/jBIETrgn2kGLGLrbr4hwU26ODIS5fQxOjhp6YB8uQ3oZlTXV0pTrbcfnN
 7Gr6BWHTbQqbDFPTBat7jZPvyXajHQwqiwY9yvd9u8pIBwjM3ebZgMN/5W9fXmz2AZZuSHenwbp
 NKsiExyfjQ/eBCCWZjeWl3BFDNQn1M6kTtvwdvnmShcrBC+XtLO8YHaEbK/X6HWjd2fxX0/iqmR
 3qH0/smpMndL8cg1hPuMEDgiYPa1c5DViLtwR970yg9cLQ/31mMxGqL+1GVINGFO9+q/Np5nTwQ
 joJ66J1prkTKjmSpNo2CxknHo+aQWwINYYP/LHmql7RfYyKhESKQNlq8f7e+FhxXc4YpvbQYA2n
 iYC4cUphkdSfRiVg9yA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA1MiBTYWx0ZWRfX3k4K75L2QOw0
 JeHFJTg2v3979LKxTOkfyviZCI7In4j1wqsZ0mXWhLv+P0lDGad9iJ4ifs4YruMyMKjRnFvPMNE
 GNgR/7fGOTcztLMniCNUPkqUTHm9ak0=
X-Authority-Analysis: v=2.4 cv=Tu1zFzXh c=1 sm=1 tr=0 ts=6abd0c17 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=Yh4zZjHgJ5e_gT9T_1AA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300052
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



On 9/30/2026 4:47 PM, Rahul Pon wrote:
> A8xx GPUs split GMEM evenly between their slices, and parts can have
> slices fused off: a8xx_gpu_get_slice_info() reads the active slice mask
> and folds the slice count into the chip ID. The GMEM size reported to
> userspace (MSM_PARAM_GMEM_SIZE) is still the catalog value for all
> slices.
> 
> On an HP OmniBook 5 (Snapdragon X2 Elite, Mahua), the Adreno X2-85 runs
> 3 of 4 slices (chip ID 0x44070031) and the kernel reports 21 MB of GMEM.

This commit text is incorrect, but the fix is valid. Please use this series
for Mahua GPU support:

https://lore.kernel.org/lkml/20260925-mahua-gpu-v1-0-0fa0bfd8d315@oss.qualcomm.com/

> Mesa sizes its tiles and places its CCU caches at the top of that range,
> past the end of the GMEM that exists, and GPU-rendered output is visibly
> corrupted: noise bands and block garbage, across the whole desktop with
> GNOME Shell. Rendering without GMEM (FD_MESA_DEBUG=sysmem) is clean;
> disabling UBWC, LRZ or compressed scanout is not.
> 
> Qualcomm's downstream driver reports GMEM for the active slices on this
> GPU: gen8_get_gmem_size() in KGSL returns
> gmem_size / GEN8_1_0_NUM_PHYSICAL_SLICES * active slices, 15.75 MB here.
> Do the same when reading the slice mask. The GMEM protection and UCHE
> setup still cover the full range, as in KGSL.
> 
> Fixes: 288a93200892 ("drm/msm/adreno: Introduce A8x GPU Support")
> Assisted-by: LLM
> Signed-off-by: Rahul Pon <theflyingrahul@gmail.com>
> ---
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c   | 4 ++++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 3 ++-
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h | 2 ++
>  3 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> index add93c1fa039..9b95d9b3826a 100644
> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> @@ -112,6 +112,10 @@ void a8xx_gpu_get_slice_info(struct msm_gpu *gpu)
>  	/* Chip ID depends on the number of slices available. So update it */
>  	adreno_gpu->chip_id |= FIELD_PREP(GENMASK(7, 4), hweight32(slice_mask));
>  
> +	/* GMEM is split evenly between slices: report the active share */
> +	adreno_gpu->gmem = adreno_gpu->info->gmem / info->max_slices *
> +			   hweight32(slice_mask);

Please add '()' to improve readability. And it would be easier on eyes, if you
don't break the line.

Also, reword the commit text to exclude mentioning Mahua. We don't a partial slice SKU
commercialized yet.

With above updates:
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

Thanks,
-Akhil.

> +
>  	/* Update the gpu-name to reflect the slice config: */
>  	const char *name = devm_kasprintf(dev, GFP_KERNEL,
>  			"%"ADRENO_CHIPID_FMT,
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index 5832dc25d6bf..dadfe4c69438 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -379,7 +379,7 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
>  		*value = adreno_gpu->info->revn;
>  		return 0;
>  	case MSM_PARAM_GMEM_SIZE:
> -		*value = adreno_gpu->info->gmem;
> +		*value = adreno_gpu->gmem;
>  		return 0;
>  	case MSM_PARAM_GMEM_BASE:
>  		if (adreno_gpu->info->family >= ADRENO_6XX_GEN3)
> @@ -1205,6 +1205,7 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>  	adreno_gpu->funcs = funcs;
>  	adreno_gpu->info = config->info;
>  	adreno_gpu->chip_id = config->chip_id;
> +	adreno_gpu->gmem = config->info->gmem;
>  
>  	gpu->allow_relocs = config->info->family < ADRENO_6XX_GEN1;
>  	gpu->pdev = pdev;
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> index 114a40f79ef3..8e6a88103610 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> @@ -204,6 +204,8 @@ struct adreno_gpu {
>  	struct msm_gpu base;
>  	const struct adreno_info *info;
>  	uint32_t chip_id;
> +	/* GMEM size available to userspace, see a8xx_gpu_get_slice_info(): */
> +	uint32_t gmem;
>  	uint16_t speedbin;
>  	const struct adreno_gpu_funcs *funcs;
>  
> 
> base-commit: d33622598496c8994c35ba0a8a913de064dfc1a4

