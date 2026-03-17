Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 611D7FD706B
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 10:36:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93A6E10E4EE;
	Tue, 17 Mar 2026 10:36:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SGtllZZh";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YZuzbV6H";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E452210E4DC
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 10:36:38 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62HA3K6c2072268
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 10:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 q80od46YfGjJbx+buL1XTCWGGPAhw78PvjTfETNu0/w=; b=SGtllZZhdUjTSRdg
 vUvB3C3qPLqtS0gCc9ND3pdqZKLbAZxN+B25Q/6Ar2tE595EW5i2RPVB9NUtxyP0
 qoWtxM1BNGxopbOHQfRO+80Eo3ATOotrKsM/ZAqBXAhqtrivAO1lEVWIXON1kmXs
 pXQdaH+BUixPZVfM3R6jd/YKFz1R0gKVPwNimtPQzLSPEHF5nW1lz/Cx1qBZf0ak
 L9Og6XPLmjkVJSY12DII93XKGwaeKESWpOfU3B9CA6BiRyGtKkz3cCmTIBZcYSd0
 3urkHEfsnLMD6EuUU8Qc0nYzDD44p+koEayc8OXXh3jMYtmTG+H8wWiWLpK8gG8l
 /psARQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cy4v6r3m1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 10:36:38 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2aeb90532f6so66451905ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 03:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773743798; x=1774348598;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q80od46YfGjJbx+buL1XTCWGGPAhw78PvjTfETNu0/w=;
 b=YZuzbV6H1I1ozQQcFO8OsSqYYU1UUHKI//c4z7/fbR366JFG7i/MwQJxOpWzGeqYqU
 SWxPQTWTL4Vis9BGLP9kRBmMHAVCBsiqBesZYSieDc9MU7y5vnKMH/0ve6U4i+nfLcOi
 KCPqSMWIps9OtszGw6zjHteArwN1SqmRT44FBCyayPvZLWAsqrKGGstZrxrX2ZiY/W+Y
 fuCQCIVSWhJvjhRjsLiINq1a1m7f8byTpi2jxks5liQpGevT9cCM1X9QSps8TZnM455l
 KIXijRO+hXk5rKCCbIY3p6SVU/yVjcfOfEDtG1R3v9zcln6YgqMYOe0K10R8yDwWt6CY
 zglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773743798; x=1774348598;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q80od46YfGjJbx+buL1XTCWGGPAhw78PvjTfETNu0/w=;
 b=IVq+8hLZ9/iMQPnixxHQb3cv/859PdLL5Vf/YB6zwZGYGn9LiIXq6xeSXk9LYngJLV
 liKVmHzSZZADWiy1UVJU9kRY7eLACH83Iwjl+usnvJmiq3u9uIIq7dUv99p2APVcldsB
 qj4kK/QbsAQr+Oa5OmAQFxSNhdxRscsSVrkiARi5nTkbfZGV1mMsZCVVYBRFSIf4IZnM
 XxhfWBgeBBADawVwF2xp89/1sPLA/BqCnLyzmre0Wnl67gNtnp8ssbqV6sKBmtCrBoUl
 OmXiu3HJ6zi6EaSXPKtQFZz3luC+XYtqzIFm/FjqMwBBvfyw/vPr3sMhD+SQrV8It8V9
 4gbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg+KaOJ1KnBMVV3SNS3nxPQ/nXN0H5A5mP97ZujsNTTflZH6fLLFeRiK5HACOi6yWLHdJn4v0M0yE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxNtjGCINUn3UqmZjxcgrdbrlN8JZtbFiDtpNK4ccv8oc/dHdqD
 87vV0nim/Aa49mbhXpfjOf6kshbvZylpRswB1H6/g1DHj5aQRru1+zdKTWLmfIbCC1wCXd+Lbty
 ptCT5Ely6EN+Yfq+AOtqY80iG3OzugYuRzkbmoJqxZdeaWOUIieQ2HH+dy3NEuzDLUdx6lmc=
X-Gm-Gg: ATEYQzzwt6PGc+z5tNsZ4GFnPbNaLs8/2WbqLebyB6l8LOFaG8YgfjbTIBgmqqHUCTZ
 8Eohu412NlI8eF42aF4/Mz5ZYoXHPkWJjkUOW/yHQjZLgegt1VcXIg4LI90AfHv1wLlZMGG342o
 PZFGy+jjKfkllS5F4aZxqepOOkhvC+wMWGa9lFWXZVhFWqk4f5Z7pqhAjrQTdoNowrOnT7K3Ehq
 NdfhbuS1NaDVSHuRtIzzYGIUTfMvcXp/qHDybFHW1fVPCuZJ9Auql+4co2zDliuIOFHzh9sw8mv
 b4f4VVhfilcs4dcOFtsw/CefyPCP5UVQ38Iapi5uXm7LA86BEGY+v0TBqOdi6cm1GnZ/BZcmG31
 7EQ21NQrJ+F+nMVQVmfA3eEWZNOhDjMOD8X1fnIanSSxoFF9j
X-Received: by 2002:a17:902:e5ca:b0:2b0:4f82:74d0 with SMTP id
 d9443c01a7336-2b04f827743mr78199175ad.46.1773743797576; 
 Tue, 17 Mar 2026 03:36:37 -0700 (PDT)
X-Received: by 2002:a17:902:e5ca:b0:2b0:4f82:74d0 with SMTP id
 d9443c01a7336-2b04f827743mr78198715ad.46.1773743796964; 
 Tue, 17 Mar 2026 03:36:36 -0700 (PDT)
Received: from [10.204.79.61] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06b74c672sm5745445ad.66.2026.03.17.03.36.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 03:36:36 -0700 (PDT)
Message-ID: <8b58adfb-ed3f-4c2a-ac4a-da5ef1bd8dba@oss.qualcomm.com>
Date: Tue, 17 Mar 2026 16:06:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/msm: default separate_gpu_kms to auto selection
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260317-separate_gpu_kms-v2-1-b027ca97b9fe@oss.qualcomm.com>
Content-Language: en-US
From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
In-Reply-To: <20260317-separate_gpu_kms-v2-1-b027ca97b9fe@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: I7sjmmgAXTDKo60GjDJYVJsQzuuStAgD
X-Authority-Analysis: v=2.4 cv=Aa683nXG c=1 sm=1 tr=0 ts=69b92eb6 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Dfr3oJRqEVbvJVnc6jwA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: I7sjmmgAXTDKo60GjDJYVJsQzuuStAgD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDA5MyBTYWx0ZWRfX6mKJiySJHjgG
 VsnwyRTHjbTrVWchAtmJIrkuxzSGS5UWHnwoeVfixMOkvsHPHtB9dmvz9RIsaWqkIkgXsGY+zat
 zR/WjEvG/H0vTxaR5rSbzrBmhW2q9uCvLlTznAn5MalKznzkXiGWZ9XGdFCrRaAI4TMGbgQB10+
 W57eVkGkeJFN2MVGqEeeHFt/NbgHOswQPTHqsxosW1FlfLUtbuGU4O8xE9q26IYDwW8sSnPn8Km
 yb/dZ87INLNEcC4shrTDR1qZiBNqj54UYnV4XZpRXFZqoGIu9Wc3Q9K683oHr1tpILk3uMOMfIU
 w7LZXL0rFps4z3BYEa/R5HjGoAKjiynfDLeF7rMC+4A1vox98ExITD90azSh5dewzk7cGlOifbH
 JBrYLqLTb9M8OkWu1GOSvzxBJ/79gtYZNHjOu2fRJ76NN0bvymYA3Lk8NLU4iD0CpsaDenxa9Am
 3MMtOzn7SVD86JF5fog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170093
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



On 3/17/2026 3:57 PM, Mahadevan P wrote:
> On platforms with multiple display subsystems, such as SA8775P, the GPU
> binds to the first display subsystem that probes. This implicit binding
> prevents subsequent display subsystems from probing successfully,
> breaking multi-display support.
> 
> Use the tristate separate_gpu_kms module parameter with the default
> value set to auto (-1). In auto mode, the driver selects the binding
> behavior based on the number of GPUs and display subsystems. This allows
> display subsystems to probe independently when required, while
> preserving the existing single-card behavior on simpler systems.
> 
> The separate_gpu_kms module parameter has the following semantics:
> 
>    -1 (auto, default):
>       Select the binding mode based on hardware topology. If exactly one
>       GPU and one display subsystem are present, bind them together to
>       form a single DRM device. Otherwise, expose the GPU and display
>       subsystems as separate DRM devices.
> 
>     0:
>       Always bind the GPU and display together to form a single DRM
>       device.
> 
>     1:
>       Always expose the GPU and display subsystems as separate DRM
>       devices.
> 
> This ensures correct probing on multi-display platforms without
> affecting single-display, single-GPU systems.
> 
> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> ---
> Changes in v2:
> - EDITME: describe what is new in this series revision.
> - EDITME: use bulletpoints and terse descriptions.
> - Link to v1: https://lore.kernel.org/r/20260223-seperate_gpu_kms-v1-1-e8231e7f1685@oss.qualcomm.com

 From coverletter this got added from b4 will make sure will be posted 
properly with subsequent patches.

> ---
> Depends on:
>    https://lore.kernel.org/lkml/20260124-adreno-module-table-v1-1-9c2dbb2638b4@oss.qualcomm.com/
> 
>    When separate_gpu_kms is enabled, the GPU and display drivers are
>    probed independently. In this configuration, the Adreno GPU driver
>    may no longer be loaded implicitly via the display subsystem.
> 
>    The referenced patch adds a MODULE_DEVICE_TABLE() entry for the
>    Adreno GPU device, ensuring proper module autoloading based on
>    device tree matching. This is required to guarantee that the GPU
>    driver is loaded correctly when GPU and display probing are
>    decoupled.
> 
> Changes in v2:
> 
>      - Drop dependency on Lemans dual-DPU device tree changes as this patch
>        works independently (Dmitry)
>      - Switch separate_gpu_kms to tristate and default to auto mode (Rob)
>      - Rename msm_gpu_no_components() to msm_separate_gpu_kms_components() for clarity
>      - Link to v1: https://lore.kernel.org/r/20260223-seperate_gpu_kms-v1-1-e8231e7f1685@oss.qualcomm.com
> ---
>   drivers/gpu/drm/msm/adreno/adreno_device.c |  2 +-
>   drivers/gpu/drm/msm/msm_drv.c              | 52 ++++++++++++++++++++++++++----
>   drivers/gpu/drm/msm/msm_drv.h              |  4 ++-
>   drivers/gpu/drm/msm/msm_mdss.c             | 15 +++++++++
>   4 files changed, 64 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> index 4edfe80c5be7..e40648c05797 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> @@ -272,7 +272,7 @@ static const struct component_ops a3xx_ops = {
>   static int adreno_probe(struct platform_device *pdev)
>   {
>   	if (of_device_is_compatible(pdev->dev.of_node, "amd,imageon") ||
> -	    msm_gpu_no_components())
> +	    msm_separate_gpu_kms_components())
>   		return msm_gpu_probe(pdev, &a3xx_ops);
>   
>   	return component_add(&pdev->dev, &a3xx_ops);
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index e5ab1e28851d..575d1aea7927 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -54,16 +54,54 @@ static bool modeset = true;
>   MODULE_PARM_DESC(modeset, "Use kernel modesetting [KMS] (1=on (default), 0=disable)");
>   module_param(modeset, bool, 0600);
>   
> -static bool separate_gpu_kms;
> -MODULE_PARM_DESC(separate_gpu_drm, "Use separate DRM device for the GPU (0=single DRM device for both GPU and display (default), 1=two DRM devices)");
> -module_param(separate_gpu_kms, bool, 0400);
> +/*
> + * separate_gpu_kms (tristate):
> + *   -1 (default): decide automatically based on hardware topology. Split devices
> + *                 if there is more than one GPU or more than one display master.
> + *    0: force single DRM device (bind display + GPU)
> + *    1: force separate DRM devices
> + */
> +static int separate_gpu_kms = -1;
> +MODULE_PARM_DESC(separate_gpu_kms,
> +		 "Use separate DRM device for the GPU (-1=auto (default), 0=single DRM device, 1=separate DRM devices)");
> +module_param(separate_gpu_kms, int, 0400);
>   
>   DECLARE_FAULT_ATTR(fail_gem_alloc);
>   DECLARE_FAULT_ATTR(fail_gem_iova);
>   
> -bool msm_gpu_no_components(void)
> +static const struct of_device_id msm_gpu_match[];
> +static int msm_count_gpus(void)
> +{
> +	struct device_node *np;
> +	int count = 0;
> +
> +	for_each_matching_node(np, msm_gpu_match) {
> +		if (of_device_is_available(np) && adreno_has_gpu(np))
> +			count++;
> +	}
> +
> +	return count;
> +}
> +
> +static bool msm_separate_gpu_kms_auto(void)
> +{
> +	int gpus = msm_count_gpus();
> +	int mdss = msm_mdss_count_masters();
> +
> +	if (gpus <= 0 || mdss <= 0)
> +		return false;
> +
> +	/* If exactly one GPU and one display subsystem single card */
> +	return (gpus > 1) || (mdss > 1);
> +}
> +
> +bool msm_separate_gpu_kms_components(void)
>   {
> -	return separate_gpu_kms;
> +	if (separate_gpu_kms == 1)
> +		return true;
> +	if (separate_gpu_kms == 0)
> +		return false;
> +	return msm_separate_gpu_kms_auto();
>   }
>   
>   static int msm_drm_uninit(struct device *dev, const struct component_ops *gpu_ops)
> @@ -1030,7 +1068,7 @@ static int add_gpu_components(struct device *dev,
>   static int msm_drm_bind(struct device *dev)
>   {
>   	return msm_drm_init(dev,
> -			    msm_gpu_no_components() ?
> +			    msm_separate_gpu_kms_components() ?
>   				    &msm_kms_driver :
>   				    &msm_driver,
>   			    NULL);
> @@ -1069,7 +1107,7 @@ int msm_drv_probe(struct device *master_dev,
>   			return ret;
>   	}
>   
> -	if (!msm_gpu_no_components()) {
> +	if (!msm_separate_gpu_kms_components()) {
>   		ret = add_gpu_components(master_dev, &match);
>   		if (ret)
>   			return ret;
> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> index 6d847d593f1a..64a5ad35f7a2 100644
> --- a/drivers/gpu/drm/msm/msm_drv.h
> +++ b/drivers/gpu/drm/msm/msm_drv.h
> @@ -555,6 +555,8 @@ void msm_kms_shutdown(struct platform_device *pdev);
>   
>   bool msm_disp_drv_should_bind(struct device *dev, bool dpu_driver);
>   
> -bool msm_gpu_no_components(void);
> +bool msm_separate_gpu_kms_components(void);
> +
> +int msm_mdss_count_masters(void);
>   
>   #endif /* __MSM_DRV_H__ */
> diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
> index 9047e8d9ee89..00e3ac7dab3a 100644
> --- a/drivers/gpu/drm/msm/msm_mdss.c
> +++ b/drivers/gpu/drm/msm/msm_mdss.c
> @@ -73,6 +73,21 @@ static int msm_mdss_parse_data_bus_icc_path(struct device *dev,
>   	return 0;
>   }
>   
> +static const struct of_device_id mdss_dt_match[];
> +
> +int msm_mdss_count_masters(void)
> +{
> +	struct device_node *np;
> +	int count = 0;
> +
> +	for_each_matching_node(np, mdss_dt_match) {
> +		if (of_device_is_available(np))
> +			count++;
> +	}
> +
> +	return count;
> +}
> +
>   static void msm_mdss_irq(struct irq_desc *desc)
>   {
>   	struct msm_mdss *msm_mdss = irq_desc_get_handler_data(desc);
> 
> ---
> base-commit: b84a0ebe421ca56995ff78b66307667b62b3a900
> change-id: 20260316-separate_gpu_kms-04d2cf4d91e2
> 
> Best regards,
