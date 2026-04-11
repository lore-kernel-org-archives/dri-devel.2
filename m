Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 550C1F45A18
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 02:19:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69A2510E03D;
	Sat, 11 Apr 2026 02:19:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OPlQbhoY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TIcPTJXI";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4399110E03D
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 02:19:55 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63AIipfA4147286
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 02:19:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gu/teDD23fbBDqFsqXo8me0HScED9ySD1rAeh3K6Hoc=; b=OPlQbhoYxHsfB80l
 LtswwCJZ06ZS4yDA67ORpWXqiNdDCT7+vCLHYBF8eX8DuJyaw+WUeKM7U3hgEF7U
 lYNhxfzFAMp4mg71Ng1lCT7lz218ld59cUIfO9F0/9q3IC6CZjRDdqnZgxR1s3dg
 AoNx1drI2YYzVAxkWfuhnVoUIXzNp/nd8NwN0gtHue3Kocq64TBscLbKcaWupfUB
 +XMX7invrlqHOVs9mgoitG8Kfh8kp66OC5Q+IOEA4ZGUEjSt+VvUzszwy9AiTVDS
 G1rQBNuLZ6cfJbdsFXi8KFPBG25Yc5QbXG7x97rqGcghk6jS1KRiZ0xi77XXLn98
 b8L5IQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deudgkg41-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 02:19:54 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-82c646e980bso1568578b3a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 19:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775873993; x=1776478793;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gu/teDD23fbBDqFsqXo8me0HScED9ySD1rAeh3K6Hoc=;
 b=TIcPTJXItIU2BrwL3BWqJ1fSxogesuRwArngk9DT5oqi+greZbT25hkpa7lnUeoNKI
 p8IJldoywgTS+tTT7NfE4G58mJEtv3zfQCvBtn2f2vlIGoAoLoRc9O7dUFzMbp38tN4/
 +jWxQWi4dwpcyOFMvfziiv8nt+fDwkPf1cKQKpzbkZ51TJn47ct0qcipLhpOGfqLEj0K
 Y89lWBG0d7G1KVg/oRcEl4xN02mKu2Xdr3ysEgZ6PMFWWd6rYPRkO6fdsjq15SEo+ok9
 aCwW+BbCBCjd+NSVrOR6mhdVwmELABANoLrcF7h705fhf10jq2bVouJibsNQ7qS5B2lg
 kzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775873993; x=1776478793;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gu/teDD23fbBDqFsqXo8me0HScED9ySD1rAeh3K6Hoc=;
 b=rLMwGUlHSSUzZHfESE7AGwR2pkAPjxTm8UoeTE4mbCz+FJvNJ7RQQubuVKXcafqPjB
 w8AlJ2ByeccqGWXkJzYFppqNZpd3a8M6E4r6niqyvISwrX77Er9iVO5ZZqJN3jeNEdqe
 meJchusqtfg1gJbDEDhQizEATuhx7eaDg5pIlZqqxAzg72KmKTCBkTe2xR0Ukkm21Iq5
 PwyAzIdLys1TuxNZ/K9FNGxyRH4ooyKkkLETlOUoCRddxjnNYE2kKSxYf9n4labqd1lp
 g+Wf0PY6xatR23ncvg1iZ96VWznRHuh1lPFSNrkv/yH43/VHeD+NNayb5kWwxC5kNfz6
 wowQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4/qoQfAY2G+Tonsuf5sLe3XThO+/3CioEnm4aNpmiOhxnsjnhHAyWMs5vvx7NArIwbD3W8WdIwKw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxzjohu2/sZYOvM2g3j+b9x7T4yq52M/0NjFnSsu10pxh25IPDH
 SUJbDyOHLQp1y5PAY/l3ZFamyVMqs2ibS7n1Xhpq/1/TpGPQn7GJzmoYAI/v63QWCAUWm1BwiLs
 EA2TeUssDiErVVuJdfJ0IgIiy0lRRnmCk7Kx5fXRLVtCR7b885nthDfm6S2XOncL7qQu3rzE=
X-Gm-Gg: AeBDiestTTK4MMqzcaCqSla6WYWQSTIW18UBBJ+zeJ072TdsgFSusa0vT9EHoKWRk7G
 OVIYkaIjTN3OZXW+vW9f+FVasMa0K2XV8GD5HrGDB2/UZUz4Oi5wsT47BltLcH61j6buRZfVOho
 LFjLU05AqfKrmeSxGjPbQ3Ae/JsNM2BsX07ssRxh0cj395gPQS6miVv66ig+L/o+H6zq5Uk2jcJ
 HTvpVmjY+PoqGAmG3x+ZZfUiwoQENYKoYGnP6F1LRT23CZys0WBkCpoB4m1WCC2vWd9aTt2q0sv
 1sVlfq2LodCKHgfg3YROcTJ1sQiifq3I2kK+CtKitQTt56+MhEkx5UlPqEJEBrjSYDbeL+D1jA/
 1KfPSMgzexJKzPyjqFPgrsJsvZXFH20KKdbLO9Z1arSgeEs5v6S/raagy2zdXiDS4TDn/cOCJF2
 3qv4ZJO5z0hg==
X-Received: by 2002:a05:6a00:2411:b0:82c:d6d3:3190 with SMTP id
 d2e1a72fcca58-82f0c250e58mr5670312b3a.38.1775873993470; 
 Fri, 10 Apr 2026 19:19:53 -0700 (PDT)
X-Received: by 2002:a05:6a00:2411:b0:82c:d6d3:3190 with SMTP id
 d2e1a72fcca58-82f0c250e58mr5670271b3a.38.1775873992848; 
 Fri, 10 Apr 2026 19:19:52 -0700 (PDT)
Received: from [10.133.33.83] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f0c4b251esm4053702b3a.37.2026.04.10.19.19.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2026 19:19:52 -0700 (PDT)
Message-ID: <31e75026-f22e-4bb1-9589-317408081d10@oss.qualcomm.com>
Date: Sat, 11 Apr 2026 10:19:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/17] drm/msm/a6xx: Add soft fuse detection support
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
 <20260327-a8xx-gpu-batch2-v2-12-2b53c38d2101@oss.qualcomm.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <20260327-a8xx-gpu-batch2-v2-12-2b53c38d2101@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: sSHufx61qBfClaJhcQYweEFhMPACPzn6
X-Proofpoint-GUID: sSHufx61qBfClaJhcQYweEFhMPACPzn6
X-Authority-Analysis: v=2.4 cv=H/brBeYi c=1 sm=1 tr=0 ts=69d9afca cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=_Z3VJ0DL17_MYGaqnVMA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDAxNiBTYWx0ZWRfX6dUEJZh8Uq6n
 CF5aqkpEVsKG3QFmNO//p1Lwev5ad3f8qDFX3cvBcMa1NkMRtNZ5uLh0fkkYKKEfegeM1kahdkl
 46LsAR6zwgJqxdCy8/0FxKMN8jbxGwEgzkDBOdEnFEeKwuuZtV7cy+2RwKgRCqm4NappP0VEuiC
 EYkWMK55BElql16qTtNvFQW7CPKbjpMfwhzM22VXT32aYELT0DGeDkAPaQGrDxPTXeXednQ88Jz
 DLbIe8n+SzUJAAUQwlnps3310s0yiTCsX7XpT6JjMm46BdwpTb7hvIs0YUjZW7JYjTZCX2i08ew
 1fq7MDgx8tXjjECfZeqLo0OUbCUCTWSuMWV20LL3eO1rVD7zoPx48O/8TujqW2qWpGN8898E5Rd
 PPEzymTOs4BrTUjUUABb2KxnllEpvmrRYkJSV93hkksU21ZZD16LfMwwBuY1gKC6ZS+M5uEkuMj
 Vo/rhUkuaGJKtEkpqOw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_07,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110016
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



On 3/27/2026 8:14 AM, Akhil P Oommen wrote:
> Recent chipsets like Glymur supports a new mechanism for SKU detection.
> A new CX_MISC register exposes the combined (or final) speedbin value
> from both HW fuse register and the Soft Fuse register. Implement this new
> SKU detection along with a new quirk to identify the GPUs that has soft
> fuse support.
> 
> There is a side effect of this patch on A4x and older series. The
> speedbin field in the MSM_PARAM_CHIPID will be 0 instead of 0xffff. This
> should be okay as Mesa correctly handles it. Speedbin was not even a
> thing when those GPUs' support were added.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/msm/adreno/a5xx_gpu.c         |  6 ++++
>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c         | 41 ++++++++++++++++++++++-----
>   drivers/gpu/drm/msm/adreno/adreno_gpu.c       |  5 ----
>   drivers/gpu/drm/msm/adreno/adreno_gpu.h       |  1 +
>   drivers/gpu/drm/msm/registers/adreno/a6xx.xml |  4 +++
>   5 files changed, 45 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> index 79a441e91fa1..d7ed3225f635 100644
> --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> @@ -1731,6 +1731,7 @@ static struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
>   	struct adreno_gpu *adreno_gpu;
>   	struct msm_gpu *gpu;
>   	unsigned int nr_rings;
> +	u32 speedbin;
>   	int ret;
>   
>   	a5xx_gpu = kzalloc(sizeof(*a5xx_gpu), GFP_KERNEL);
> @@ -1757,6 +1758,11 @@ static struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
>   		return ERR_PTR(ret);
>   	}
>   
> +	/* Set the speedbin value that is passed to userspace */
> +	if (adreno_read_speedbin(&pdev->dev, &speedbin) || !speedbin)
> +		speedbin = 0xffff;
> +	adreno_gpu->speedbin = (uint16_t) (0xffff & speedbin);
> +
>   	msm_mmu_set_fault_handler(to_msm_vm(gpu->vm)->mmu, gpu,
>   				  a5xx_fault_handler);
>   
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 5cddfc03828f..fb9662b946d0 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -2546,13 +2546,33 @@ static u32 fuse_to_supp_hw(const struct adreno_info *info, u32 fuse)
>   	return UINT_MAX;
>   }
>   
> -static int a6xx_set_supported_hw(struct device *dev, const struct adreno_info *info)
> +static int a6xx_read_speedbin(struct device *dev, struct a6xx_gpu *a6xx_gpu,
> +		const struct adreno_info *info, u32 *speedbin)
> +{
> +	int ret;
> +
> +	/* Use speedbin fuse if present. Otherwise, fallback to softfuse */
> +	ret = adreno_read_speedbin(dev, speedbin);
> +	if (ret != -ENOENT)
> +		return ret;
> +
> +	if (info->quirks & ADRENO_QUIRK_SOFTFUSE) {
> +		*speedbin = a6xx_llc_read(a6xx_gpu, REG_A8XX_CX_MISC_SW_FUSE_FREQ_LIMIT_STATUS);

a6xx_llc_read accesses the a6xx_gpu->llcc_mmio without check the 
validation of the a6xx_gpu->llcc_mmio. If the llcc_mmio is invalid, the 
subsequent readl() in a6xx_llc_read() will crash with a kernel oops.

Thanks,
Jie

> +		*speedbin = A8XX_CX_MISC_SW_FUSE_FREQ_LIMIT_STATUS_FINALFREQLIMIT(*speedbin);
> +		return 0;
> +	}
> +
> +	return -ENOENT;
> +}
> +
> +static int a6xx_set_supported_hw(struct device *dev, struct a6xx_gpu *a6xx_gpu,
> +		const struct adreno_info *info)
>   {
>   	u32 supp_hw;
>   	u32 speedbin;
>   	int ret;
>   
> -	ret = adreno_read_speedbin(dev, &speedbin);
> +	ret = a6xx_read_speedbin(dev, a6xx_gpu, info, &speedbin);
>   	/*
>   	 * -ENOENT means that the platform doesn't support speedbin which is
>   	 * fine
> @@ -2586,11 +2606,13 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
>   	struct msm_drm_private *priv = dev->dev_private;
>   	struct platform_device *pdev = priv->gpu_pdev;
>   	struct adreno_platform_config *config = pdev->dev.platform_data;
> +	const struct adreno_info *info = config->info;
>   	struct device_node *node;
>   	struct a6xx_gpu *a6xx_gpu;
>   	struct adreno_gpu *adreno_gpu;
>   	struct msm_gpu *gpu;
>   	extern int enable_preemption;
> +	u32 speedbin;
>   	bool is_a7xx;
>   	int ret, nr_rings = 1;
>   
> @@ -2613,14 +2635,14 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
>   	adreno_gpu->gmu_is_wrapper = of_device_is_compatible(node, "qcom,adreno-gmu-wrapper");
>   
>   	adreno_gpu->base.hw_apriv =
> -		!!(config->info->quirks & ADRENO_QUIRK_HAS_HW_APRIV);
> +		!!(info->quirks & ADRENO_QUIRK_HAS_HW_APRIV);
>   
>   	/* gpu->info only gets assigned in adreno_gpu_init(). A8x is included intentionally */
> -	is_a7xx = config->info->family >= ADRENO_7XX_GEN1;
> +	is_a7xx = info->family >= ADRENO_7XX_GEN1;
>   
>   	a6xx_llc_slices_init(pdev, a6xx_gpu, is_a7xx);
>   
> -	ret = a6xx_set_supported_hw(&pdev->dev, config->info);
> +	ret = a6xx_set_supported_hw(&pdev->dev, a6xx_gpu, info);
>   	if (ret) {
>   		a6xx_llc_slices_destroy(a6xx_gpu);
>   		kfree(a6xx_gpu);
> @@ -2628,15 +2650,20 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
>   	}
>   
>   	if ((enable_preemption == 1) || (enable_preemption == -1 &&
> -	    (config->info->quirks & ADRENO_QUIRK_PREEMPTION)))
> +	    (info->quirks & ADRENO_QUIRK_PREEMPTION)))
>   		nr_rings = 4;
>   
> -	ret = adreno_gpu_init(dev, pdev, adreno_gpu, config->info->funcs, nr_rings);
> +	ret = adreno_gpu_init(dev, pdev, adreno_gpu, info->funcs, nr_rings);
>   	if (ret) {
>   		a6xx_destroy(&(a6xx_gpu->base.base));
>   		return ERR_PTR(ret);
>   	}
>   
> +	/* Set the speedbin value that is passed to userspace */
> +	if (a6xx_read_speedbin(&pdev->dev, a6xx_gpu, info, &speedbin) || !speedbin)
> +		speedbin = 0xffff;
> +	adreno_gpu->speedbin = (uint16_t) (0xffff & speedbin);
> +
>   	/*
>   	 * For now only clamp to idle freq for devices where this is known not
>   	 * to cause power supply issues:
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index 8475802fdde2..f6c39aed50f2 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -1185,7 +1185,6 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>   	struct msm_gpu_config adreno_gpu_config  = { 0 };
>   	struct msm_gpu *gpu = &adreno_gpu->base;
>   	const char *gpu_name;
> -	u32 speedbin;
>   	int ret;
>   
>   	adreno_gpu->funcs = funcs;
> @@ -1214,10 +1213,6 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>   			devm_pm_opp_set_clkname(dev, "core");
>   	}
>   
> -	if (adreno_read_speedbin(dev, &speedbin) || !speedbin)
> -		speedbin = 0xffff;
> -	adreno_gpu->speedbin = (uint16_t) (0xffff & speedbin);
> -
>   	gpu_name = devm_kasprintf(dev, GFP_KERNEL, "%"ADRENO_CHIPID_FMT,
>   			ADRENO_CHIPID_ARGS(config->chip_id));
>   	if (!gpu_name)
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> index 29097e6b4253..044ed4d49aa7 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> @@ -63,6 +63,7 @@ enum adreno_family {
>   #define ADRENO_QUIRK_PREEMPTION			BIT(5)
>   #define ADRENO_QUIRK_4GB_VA			BIT(6)
>   #define ADRENO_QUIRK_IFPC			BIT(7)
> +#define ADRENO_QUIRK_SOFTFUSE			BIT(8)
>   
>   /* Helper for formating the chip_id in the way that userspace tools like
>    * crashdec expect.
> diff --git a/drivers/gpu/drm/msm/registers/adreno/a6xx.xml b/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
> index 3941e7510754..2309870f5031 100644
> --- a/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
> +++ b/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
> @@ -5016,6 +5016,10 @@ by a particular renderpass/blit.
>   		<bitfield pos="1" name="LPAC" type="boolean"/>
>   		<bitfield pos="2" name="RAYTRACING" type="boolean"/>
>   	</reg32>
> +	<reg32 offset="0x0405" name="CX_MISC_SW_FUSE_FREQ_LIMIT_STATUS" variants="A8XX-">
> +		<bitfield high="8" low="0" name="FINALFREQLIMIT"/>
> +		<bitfield pos="24" name="SOFTSKUDISABLED" type="boolean"/>
> +	</reg32>
>   </domain>
>   
>   </database>
> 

