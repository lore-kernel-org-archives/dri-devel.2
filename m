Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A21C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:59:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9105B10E340;
	Mon,  6 Jul 2026 08:59:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Axhgdy3T";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Upb0sR3i";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0991B10E340
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 08:59:23 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66641sUm3614842
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 08:59:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ERl4wTZyWv1vQsjv06YEWQxA6mOQp5u853Smknj5ows=; b=Axhgdy3TrH2DtrJ8
 weETRVwRSctUP3G+Iqa7U//pwX5JnIoG6vEPa5wrZuq0Wy3hmcKd6l8MXeOQj8bu
 WdMq9zkrIgNO66vIBa1vGQF1hlRBin/sFhk5w+wzn8LYN0PL0rD3yWNukq3C2IPI
 CG10qet/6xYlsfT0CyRbbPB5ZfRaXXfThWM7mQ7BnF31txQMtZ6dI/Chd51ZZIRM
 pILhbWV6PNLv3b9rQ8Fdm8Bia+o9612oGW/zVoCNVSAloq7tuMnCDl3YqDTjvPa0
 6vEmuQfc43TMpZTsNxr0OrpJdtW9A+Gv/k31WFpv8Dw/2MVHGEVdiWp3CziEmTEV
 twlSKA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6srvnfx4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 08:59:22 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c21be5bb4so20914811cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 01:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783328362; x=1783933162;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ERl4wTZyWv1vQsjv06YEWQxA6mOQp5u853Smknj5ows=;
 b=Upb0sR3i7hgVQ4FI2gHWYX7VuWAOqBmB6ns0Zot7ZlJWFgsjSVopC3Kwi4zWffiJMn
 YIXHJLyLff9mY78f90JIHnUzL//YqvBL/yTi5JmDG0Ti1KyrCuOv+/pTdt5UvTmSv40C
 Zk+LKX1V+dU9+4s6SEiclwRpfvtA9+kd27hOVWHS96lh6GEqsdVEKEAdKxy2/g6cGGZP
 M+wOi7ObwEzNwJ++oob8ucyXLI5pLob3r/Zx3PvIdgYsmon8ONE2kaTfy9OGIga8qVEJ
 n5AquHp1cOGA3eW7li5Lgrm1hBiZSrx9zoIdAV8PG+Kh1THAHQe3Xdj6p7qWF7GJSnq8
 bx0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783328362; x=1783933162;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ERl4wTZyWv1vQsjv06YEWQxA6mOQp5u853Smknj5ows=;
 b=dVsKQmSUi3TbSp1NmUBDk1lYF9uXAQ0zhwgZKHc0FKcCXG5N19yAie8eglcKQR7tOu
 XXBC3kZHeh3V4Vfm7B9svylGJkJ7Iuvb9DfHw1T7iKwtNKiiXn54lOi0KOfm0nAcgDOF
 kGF8/pqP2WwZxDReLjgrivvll45sSPwSFtO4a79ivCUSKz7AmPVkAHJI2x2c3YTwW6rW
 +29kahmAUtndaZ+mHb5cJssUanBTq2q/5fMTMYrOz8qJirwl7yfQc5qTJW0uCyUHnuqF
 PZWkrPEnF7fx5yiZaeGkOSTi3eRxfdtdeqTtucs/aMDn0PzpF5cDyS5tIdBWZf3byGkb
 KQUQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqxHC1rwl5ke11fY49qFkxU01bZfcV9ZxHGjhWOpE2aj9ALyorjd+o/FojuFyLcmYU7T8jYe5y+z4c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzofpmCmV7Wil7Tj8PfwuL3MH617GDYHC2+/lCcZ2kdrXLoWwLS
 WI2IyD1BRbZA7CSqWzJlYIpXDNMk/Dz9TcsB+Mjr/HsfD7+7gNCAmgH5Lakl0AGDdOqPQOgp67Z
 ptJzgfjcusPpjCOulZkGAogo6852i6xMfmwA6Z2ATd2dpwRhwDfv+GYfGFoLVSUeXEIQfVRI=
X-Gm-Gg: AfdE7cmxJcoMQ/kFiLWxgV9eKqGHVsHO+zHAW/v2DiwvEUBJmMhuXFjIka+fs4J5F+I
 t3LHbRSZShSRIc7VmYYqq+XW2G9jWAwzWPMAYGHlKF1ttbe2fu6Qeg7XshwbiCn4w/6cn0GptNC
 whMLp8XkFgV6fb1x+9Jhkm4ribgfjTjnV1DIX544Ya2CH8mWHWL6VVXKzrH/VK9624whN7Htjm+
 vLypsjVl++/VrKQPiwPcVACvfcSY+Rr5m7zhw9WB3M1gXmCLiDfDEtuAXWdjq8jJi9SnhMHeICI
 FvimKIHt5k65c9eP9tIHr0Zh1GNB7AsOeGESvHsq/ekde+MrMpHzr0aBnSf+aZlmy2r2+kw/New
 iSla5OkqkItEC14DySpsK4noZXI8UahzHpgk=
X-Received: by 2002:a05:620a:4405:b0:92b:7420:bd58 with SMTP id
 af79cd13be357-92e99e0f65bmr827906685a.0.1783328362379; 
 Mon, 06 Jul 2026 01:59:22 -0700 (PDT)
X-Received: by 2002:a05:620a:4405:b0:92b:7420:bd58 with SMTP id
 af79cd13be357-92e99e0f65bmr827904985a.0.1783328361880; 
 Mon, 06 Jul 2026 01:59:21 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c12b60550desm702417466b.7.2026.07.06.01.59.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 01:59:21 -0700 (PDT)
Message-ID: <f1d1db6e-068d-4b31-b53a-02bdac9d945e@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 10:59:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] drm/msm/a6xx: Add Adreno 722 support
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
 <20260705-eliza-gpu-v1-3-c9f1354dbd29@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260705-eliza-gpu-v1-3-c9f1354dbd29@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TcamcxQh c=1 sm=1 tr=0 ts=6a4b6e6a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=ErYzCqf3RjAp607u9I4A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: F_W8sJEtyJOMoo0P4g0RPaMNw13PrdZp
X-Proofpoint-GUID: F_W8sJEtyJOMoo0P4g0RPaMNw13PrdZp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA5MCBTYWx0ZWRfXwkU01y5qUYd9
 GYKH9h+VZWVYwaQg2sdz/ZWc8crXNI8pRtunZXj1e8UkyFSeluGiXeBFoFkJ6zZCZ3vZnJHk87T
 12v0aCBGwQZV56sSLAyyMgzLOLf3bpi8nNcYGJyRpGhNG9oFSNBK6n3rMEc0acY5a4mG6k/z66B
 MBf73Btj9OPHg5dGYik4X7nWuYljShjSLQCQ2OwC3hwGucHQpZhJxGbreP4D1PYZCoO9JLsozFO
 5BA/Lutk7VQuG0TEu29PAOOiiBev18aH6bQ2tzcZpJkAMP2cdOxA01cSle4kAukLU4xoCZlFLYU
 qEYG0StNIaYnl8C+1rit96v6QKQ2G6xs5jbYlJh5+Cn0FhZrPYdY3czFbjshN6Fz89HZI6ajIeA
 Gud1R+hKuYu30mvaEvr/3+72of7R9Fs8+P4Hveoh9ljPF7AFFPCgCASoK+xNzEhfIUczs6RNRiZ
 kbp+75zr0a8cma4ZpuQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA5MCBTYWx0ZWRfXzP2HMzfqxkvc
 DC5ib55MP5ykv8UjD7ZD3eUpVf2ODTZkQdmuv8YPLkIP5rEmZnbtju1ftLErcuox4IfKt56jEYb
 7eRIXKWZTJ2ORivRUFBSL1yuGecnxhU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060090
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

On 7/5/26 10:14 AM, Akhil P Oommen wrote:
> From: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
> 
> Add support for Adreno A722, a member of the GEN1 A7xx family. It is
> derived from A730 and shares the same IP-level configurations: HWCG
> registers, protected registers, GBIF CX registers and gmu_cgc_mode.
> Major differences include lower cache/core counts, 1MB GMEM, no
> Concurrent Binning & LPAC support. Some of the peripheral blocks like
> RSCC are from A740 that resulted in updates to RSC layout.
> 
> Add a new entry to the catalog to describe the usual configuration and
> few additional fixup mainly due to missing CB/LPAC features and updated
> RSC layout.
> 
> Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

[...]

> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -710,7 +710,8 @@ static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
>  	gmu_write_rscc(gmu, REG_A6XX_RSCC_HIDDEN_TCS_CMD0_DATA + 2, 0);
>  	gmu_write_rscc(gmu, REG_A6XX_RSCC_HIDDEN_TCS_CMD0_ADDR + 2, 0);
>  	gmu_write_rscc(gmu, REG_A6XX_RSCC_HIDDEN_TCS_CMD0_DATA + 4,
> -		       adreno_is_a740_family(adreno_gpu) ? 0x80000021 : 0x80000000);
> +		       (adreno_is_a740_family(adreno_gpu) ||
> +			adreno_is_a722(adreno_gpu)) ? 0x80000021 : 0x80000000);

This is a discrepancy vs kgsl (did you look at gen7_14 instead of
gen7_17? did you test this on device?)

[...]

>  	/* The second spin of A7xx GPUs messed with some register offsets.. */
> -	if (adreno_is_a740_family(adreno_gpu))
> +	if (adreno_is_a740_family(adreno_gpu) || adreno_is_a722(adreno_gpu))
>  		seqmem0_drv0_reg = REG_A7XX_RSCC_SEQ_MEM_0_DRV0_A740;

Likewise

[...]

>  	/* The second spin of A7xx GPUs messed with some register offsets.. */
> -	if (adreno_is_a740_family(adreno_gpu) || adreno_is_a8xx(adreno_gpu))
> +	if (adreno_is_a740_family(adreno_gpu) || adreno_is_a722(adreno_gpu) ||
> +	    adreno_is_a8xx(adreno_gpu))
>  		seqmem_off = 4;

Likewise

>  
>  	/* Make sure there are no outstanding RPMh votes */
> @@ -1100,7 +1104,8 @@ static void a6xx_gmu_rpmh_off(struct a6xx_gmu *gmu)
>  	gmu_poll_timeout_rscc(gmu, REG_A6XX_RSCC_TCS3_DRV0_STATUS + seqmem_off,
>  		val, (val & 1), 100, 1000);
>  
> -	if (!adreno_is_a740_family(adreno_gpu) && !adreno_is_a8xx(adreno_gpu))
> +	if (!adreno_is_a740_family(adreno_gpu) && !adreno_is_a722(adreno_gpu) &&
> +	    !adreno_is_a8xx(adreno_gpu))
>  		return;

Likewise

You also need to if-out concurrent binning for this SKU

Konrad
