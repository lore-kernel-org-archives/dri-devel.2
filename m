Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61CF8CD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 14:10:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81EA310F16B;
	Thu,  7 May 2026 14:10:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="npjLD5L3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zk3rL4Rr";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2C7210F16B
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 14:10:06 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647ADTSh026485
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 14:10:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 n32FPL48jUWDBVk1qxVmjMmAGF0l1K/hWXAEUvGcTKU=; b=npjLD5L3SZAAgp8l
 buIRqV9iUN9RJe9Nq08o60OQkFcl6vsEIaHtoIETwfVcC+UZc2ohLdbtuns3YQJx
 535SWxeJ01+j140Scg7B0nHXotnLlu3f+2tior//teHYDs14phCCFs0aZSqGcBdZ
 Vb8SHt9V0NEWJEb+tDgn9vo1wShDFQkD7d1OG9MyO+sMUaraJqnBE1dvyqJdksA7
 X/1SMITIgKhnH6W5qxytUPuEHVS8SdNJchMS3YUOg73ldQyu6e20zBfY08LHTGEo
 L8dvuC+YTS52PMG4u8IaOlkk+i/k47s+zDq4yb2wo9kuUwtVa44FGDspBVzTubMY
 XO86gw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0k1t28gd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 14:10:05 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3653e382405so997050a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 07:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778163004; x=1778767804;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n32FPL48jUWDBVk1qxVmjMmAGF0l1K/hWXAEUvGcTKU=;
 b=Zk3rL4RrBEdGUUPWsCxAd28QlfbJbUv8Y5p8+Ow7Zhvp0/nzD3o6hjGh1bMJ9Z/elH
 CqnQwH1JvRqoRZMBJH+uo6oL9NK6uansDZ7TN4SMqMgsNvqELMGcygSu8+aDtASWRKLH
 W4xpGaaiNIZsXOHztkzU4b8GtbCH6Bsz6uyN+zJisfwou3PM0n0GWXpSFUlpeLwmc6Va
 Lxbgz+D4i+MVufMoZr6JmKa4XO/IATHhukBp+OAFFIdn/0WrovNoQ/np3LESMGTqs3Ch
 HvrSVYQbxwg0vPWYfUVeBy+yms39LbOQvV5BEPNi7QuBHgnAMzvTl7+6aaciU5RFePyI
 xhZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778163004; x=1778767804;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n32FPL48jUWDBVk1qxVmjMmAGF0l1K/hWXAEUvGcTKU=;
 b=num3cr6+ikmtIi1BgxDFol3a6Xc92HAgP+gO/mynLxe4JiSOKY78xJSCLG6j95qXDS
 JJ0qzhgkSIrdA0/Om6ofK+qvVH15Cd8Jx+DbCRfDUNRms/4b/6W048vSasE+vI1ONEEy
 rhDvzztMmUAMdHV0ONvmrehvAP2kQez4UvdxLrqLQphD5ot/TNsmVl9cU0hpbcoCwfUy
 wDASNRF1Ip8gLKcRWgr4g38WASGAO1sDdWwJAQzI8MHmnR18Im1uEKJaGW4gyEbe4a7s
 5X8Z427jggavxWQTEjx8OrwTT1wzg4OaYJnaA8r4BlNDkY22xPnD0163EfqsYRScJkc6
 MT8w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8mJ/pjX5/2bPxPMoZaD7FTmbeFG72VppsWc3oQvYV+g5+MA6c69TkRGib/vXUSoKNGCUvRQkRYpFY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzgz4zifXaq/SAn+V/sFPTbJomGkNYg2gsqVEgDr93Iw9zaz57P
 Uki8nMSXbWD7FTDjdRCBEijnnnb9S3MgL485VQa0c6PsFQ4zWOucPxQd7U1cnNh4mGNz8v48/7R
 uO6djW02bQcouQvWWM18gFL5u0kkhR+3bmz6iML1kMeXR0nqhi4xoMQAC0zQYk4UC8A6nnyfGDG
 0K2xg=
X-Gm-Gg: AeBDiesiA4N/0v77O8FJg/RjAO8+Q5csN4eJDp9sOAyybLEEao6lJMlYpKj/aawq12l
 YyT6M8zARNQPlXj8hQ7stakyvif1MBpcSghx4Q5E/hAzReGeGKuGWVyZIKdOnNWcdqPjHfVbEiw
 2NbEMHELS4XTfP8i/OAtPiU6RQDhVoxVsbMiegejbpKeHCw4eNylMK47bYZLa9s9kAKO7zuhwr0
 rjsJBGrAeRzstVVAAOABpWY3qq7Urw/Xa5539HYv8u6FRvGRfo0W1VFdZd4FrVm3Ky9bSqWqZmL
 uyrctifInq0OFEBQQlCyc1lhf5/4umcJoWLkv+ZkMRUu9i/eSNqNKSzVqaAKO5ctyp/8lJfuXhi
 J0J04hHCrf/paZ4Ro/IQJ5BzopGhsQiBtdWLnlEruCUET8XNkSlHuBzg=
X-Received: by 2002:a17:90a:1c88:b0:365:d9e2:7511 with SMTP id
 98e67ed59e1d1-365d9e27b9emr3785125a91.25.1778163004504; 
 Thu, 07 May 2026 07:10:04 -0700 (PDT)
X-Received: by 2002:a17:90a:1c88:b0:365:d9e2:7511 with SMTP id
 98e67ed59e1d1-365d9e27b9emr3785084a91.25.1778163004032; 
 Thu, 07 May 2026 07:10:04 -0700 (PDT)
Received: from [10.206.103.12] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-365b4fb5e7esm6536089a91.15.2026.05.07.07.09.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 07:10:03 -0700 (PDT)
Message-ID: <89fbbbb0-1a0a-4ba5-ae49-7a19aa50e638@oss.qualcomm.com>
Date: Thu, 7 May 2026 19:39:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/29] drm/msm/adreno: use new helper to set
 ubwc_swizzle
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260507-ubwc-rework-v4-0-c19593d20c1d@oss.qualcomm.com>
 <20260507-ubwc-rework-v4-13-c19593d20c1d@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260507-ubwc-rework-v4-13-c19593d20c1d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EoPiaycA c=1 sm=1 tr=0 ts=69fc9d3d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=BTchm6ImzknZz8NDhdQA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: E3_3UX2nUi_svELg5J-_OD8RLFNhSKI7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE0MSBTYWx0ZWRfXxYt1L8pZbBYt
 Y5pIpWpFCz3H0iMBHW+CUOyKOsbLxPfg3J7b0hSKXfATUV45uB4KtTPgcyRvyXfckLXrCEmRGq6
 R+og1+8vEXjjtbDrd8mymlNWsC5qyWVx0PAx6zTbRkHPZk0kT3g+mn55iEGIjWuHY4bnj12NY+G
 Qo5DCZgiepJn5yGIgLNdWrJwLApZTWnVN4VQO39PeNmEr9nptgsIysHATx4f8hhYTA8gBB+a7xu
 ANGPQLIyZqFwQSzf6N/hurtOZPjKKPk8JZKh2IB/MF3DEOIMQ/PP3wVLCxtKAH7XUts4c7hWCXt
 X+ANVR0RUg6G4vr2cLdAsrMNE7+6cdzqdMRnh3BLaINQCF37lmlVqd6v/2rfK3ubO6zhQJ32ic1
 /OoY+asPFGZKqaXYCMwRhALUYajS/ux0fORIWZfdn7d25xtRkg+Rph33IeK7NhNadWvK5Hp90Yp
 GvuSxdg8z6Aj7aaMK0g==
X-Proofpoint-GUID: E3_3UX2nUi_svELg5J-_OD8RLFNhSKI7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070141
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

On 5/7/2026 6:33 PM, Dmitry Baryshkov wrote:
> Use freshly defined helper instead of using the raw value from the
> database.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil

> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 2 +-
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c   | 4 ++--
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 76c681614416..5c17565b0499 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -745,7 +745,7 @@ static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
>  	BUG_ON(cfg->highest_bank_bit < 13);
>  	u32 hbb = cfg->highest_bank_bit - 13;
>  	bool rgb565_predicator = cfg->ubwc_enc_version >= UBWC_4_0;
> -	u32 level2_swizzling_dis = !(cfg->ubwc_swizzle & UBWC_SWIZZLE_ENABLE_LVL2);
> +	u32 level2_swizzling_dis = !(qcom_ubwc_swizzle(cfg) & UBWC_SWIZZLE_ENABLE_LVL2);
>  	bool ubwc_mode = qcom_ubwc_get_ubwc_mode(cfg);
>  	bool amsbc = cfg->ubwc_enc_version >= UBWC_3_0;
>  	bool min_acc_len_64b;
> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> index 1923f904d37d..53def136e0fc 100644
> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> @@ -275,8 +275,8 @@ static void a8xx_set_ubwc_config(struct msm_gpu *gpu)
>  {
>  	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
>  	const struct qcom_ubwc_cfg_data *cfg = adreno_gpu->ubwc_config;
> -	u32 level2_swizzling_dis = !(cfg->ubwc_swizzle & UBWC_SWIZZLE_ENABLE_LVL2);
> -	u32 level3_swizzling_dis = !(cfg->ubwc_swizzle & UBWC_SWIZZLE_ENABLE_LVL3);
> +	u32 level2_swizzling_dis = !(qcom_ubwc_swizzle(cfg) & UBWC_SWIZZLE_ENABLE_LVL2);
> +	u32 level3_swizzling_dis = !(qcom_ubwc_swizzle(cfg) & UBWC_SWIZZLE_ENABLE_LVL3);
>  	bool rgba8888_lossless = false, fp16compoptdis = false;
>  	bool yuvnotcomptofc = false, min_acc_len_64b = false;
>  	bool rgb565_predicator = false, amsbc = false;
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index bf1572156b0b..d26985c88115 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -430,7 +430,7 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
>  		*value = adreno_gpu->has_ray_tracing;
>  		return 0;
>  	case MSM_PARAM_UBWC_SWIZZLE:
> -		*value = adreno_gpu->ubwc_config->ubwc_swizzle;
> +		*value = qcom_ubwc_swizzle(adreno_gpu->ubwc_config);
>  		return 0;
>  	case MSM_PARAM_MACROTILE_MODE:
>  		*value = qcom_ubwc_macrotile_mode(adreno_gpu->ubwc_config);
> 

