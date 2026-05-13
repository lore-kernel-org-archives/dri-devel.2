Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED52CD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 21:09:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEDC910F06E;
	Wed, 13 May 2026 21:09:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="B9sJPLiO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IueEuEGB";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A50C710F06F
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 21:09:42 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DGuIfj3995530
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 21:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jkhJMB3p3x9g/m7z4wc6rLzCh+cUSNcjou/V/e/uRck=; b=B9sJPLiOytiZis+i
 OD6Ce6a43XJnEe+NBuX6cguSEihH9ZeJNQ7Wd6kQwSIkbpAnC8FkJSqp7Qxuwr0A
 BY74u6GiTGdx2wJJ2Uestj+AIaF8uv0yTVWNmxbDs8V9kcZXR0Oc8Aj12bxndB8N
 aACvfqhYwkxxUap/+OnPoo3VxsSofvwQocrkmKnVHqwIw5gtBtudt3b2HZjG1NU7
 yjZxHIzJ2ci/wTYhJSOwdr5caWDefzjQn5VYjGxZao+68XGM7G49KZ11/qoiU676
 cBrlVFRagE+DHblBk3uY3fdVPdd1avgB1m/qyA23VFm1uFxDcsebZo0I1IYNSGds
 hUplFg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4w8us01h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 21:09:41 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3662668b825so441149a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 14:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778706580; x=1779311380;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jkhJMB3p3x9g/m7z4wc6rLzCh+cUSNcjou/V/e/uRck=;
 b=IueEuEGBxsaiITSnf2QvZlsCueYcbuaSMrQnp/XLGwkE8tJe7PAn6z5nu7kllxNEAA
 BqPbbYW/ea/cbdp9z/bddUO2v/YCJdyi6wRYWTBfTrn7sP2krSF8bvISqYbiotMHi7Xx
 wE1IANLXsROV2wxlY8GGE9IoeWR4LiRLcwVyeqEufxM7ij2spI0mH8QWkMP90GN8C9LE
 49XnsTI2+0+mJLJuFu5/5idLPuNRxPy7g6m8fiy1YQ1ZkhdUWF3V45Z0XAwhW16Cr9co
 PAU/GmJBsDBelRZMlnLLwx3bXMNO3OMFz/0tYDVlgHHh1pqOq0ApI8Yizpp0yucIVxtm
 BOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778706580; x=1779311380;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jkhJMB3p3x9g/m7z4wc6rLzCh+cUSNcjou/V/e/uRck=;
 b=tPz6GRj0NcbULjPcHfVv55+ZHksapUSuS89z5FR4Q4krRHH1r0xEcuIvkt1F1dwwmz
 fOh1xFhtWbsakvgbcqFxbDQXXZQxEkToyyizNMvfKU8+MOhD7VU5fNvcx1sEFNYf3c2K
 Wxw7jUyZnQYqKCS1Zn+xcZkuC4STVs2yVuzgEAGcbRxyJCwhs6Af0O+3QE1AC4ly/pj9
 jXWKa/yMcbSInsZJMLGL7AVysXwVhiJKolG9dZS9cWclAnHzBrvbqLplct5pN5l7ZEeP
 E+LF5Q14eCOeKNB2k5ZJQkdNhlS4J7juRdry7xNtntUS4O0g3ZOnB2DdZ3QSuuAdKET7
 +CZQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9WGswh2WPSl1BbLMnTr4CeU1FTbMcFCItiV3BHfSF1y4z0qGnYUlwQ+Y7QtYbtJQY4tbFNBReKSLQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzVJyzfp3OgLIxP8Kfn3S0Jh4HHoHIYzlzwYaNOQnYAY7iFOPgk
 EI0u5B3hkkxPN//6mhsksw4StmYpAwLBpPhvOWKtBUPnw+nxkR9bNlfFe7BEtJfZKMJssT9YRtv
 n9UdbRI1CdgJm/gPTw/4p+mno0dPKs7+CeJFZKN/iAkEMTIZANhyy1XLTZSQgSfMzXIv6wnI=
X-Gm-Gg: Acq92OEfe23aL1o5OTaP9vQgmXWypr3BksBdj17K83yAkU6XlQ6B6MLkzPDghQvvUaX
 qKEawPGpEpaRrUVsozwaN1CkgxraQ+7/vktZKUPLfY56KLUWoRhQQt9YmIByNvfjQsEMRjkAwnt
 lNg4p4RkB2DeforPiaWlZsTNc2iJql0ihISVugiIuibu7gkfYGmi3wD0pVfTGL8McF/ZMLvTzjj
 owXtt2wVlpNjX0VUNm3MOub5D3wYNK5F4ywyEDDFGpjyXqwuxyyOvVS1+jLC2MGSr/TsAANG6qd
 G4oqQS0pfChoyI6a26eUcz1qP4wSc9E5FcThEWgw4moxO2zMMamweQhvphfa/BxWFNpBcj5VOvg
 q1MbBxsCqh4oPzryx4mKDVeEBUnLjKbn/bSkcNhi1jGCTg2dxPN1JwHo=
X-Received: by 2002:a17:90b:3f83:b0:35b:9b77:d7c with SMTP id
 98e67ed59e1d1-368f7993ccbmr4800523a91.14.1778706580521; 
 Wed, 13 May 2026 14:09:40 -0700 (PDT)
X-Received: by 2002:a17:90b:3f83:b0:35b:9b77:d7c with SMTP id
 98e67ed59e1d1-368f7993ccbmr4800494a91.14.1778706580063; 
 Wed, 13 May 2026 14:09:40 -0700 (PDT)
Received: from [192.168.1.6] ([106.222.229.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-368edf6738bsm4863172a91.8.2026.05.13.14.09.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 14:09:39 -0700 (PDT)
Message-ID: <f94bebb3-8d33-446c-b9c4-b0c40850aea5@oss.qualcomm.com>
Date: Thu, 14 May 2026 02:39:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT 4/5] drm/msm: Always use component model for
 standalone GPU
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260513-gmu-sync-state-fix-v1-0-6e33e6aa9b4f@oss.qualcomm.com>
 <20260513-gmu-sync-state-fix-v1-4-6e33e6aa9b4f@oss.qualcomm.com>
 <pbvoyojew67yeo2cr4n7msem242ytlh2qqtrxli2q3tv7e3iao@myqtn5w57paz>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <pbvoyojew67yeo2cr4n7msem242ytlh2qqtrxli2q3tv7e3iao@myqtn5w57paz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=WP1PmHsR c=1 sm=1 tr=0 ts=6a04e895 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nm1BsBjGsf7C+PoY3QnOXg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=QCrFGBqe7VSYUZ7klbgA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: Hea_ytqYTWKHaRO7LVWo3WtcYs3dH_P-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDIwOSBTYWx0ZWRfX5q3294llYJSv
 32wj56g4+0xVvv3MNWEaPqqC6Bczw+b3VOhVGHXbl36U4qufqgST2/ISOiG0z8CEZokYa4TUgu9
 e1QdiWX0wrYGJL5324mtB0biDaFPZhzrCdQUpOBLg9VR8Gg5lSzfIQplnnlAIoJj/xXrGJBhi0a
 FbHSg9uBKfyz1kXcc7SBh4mx6HQVeIbrWdy5IrrXHx4XLpTw/K3LUAwv2Ueo3ai58J19MudnOon
 +pJ8sdFNcARV6EQRhnc4Vl5PkQe74JB/EhCnxmsmhVfWKBNjViNKHPxahwrTLZlFXUx4anHS9vJ
 Lh3XexGfESXJhbKbNe9qNE7Eg/zqi4ZsW9/EwPFKyuIaHt9b5yhWuBgoxiLf7OV9B5HLMltLDmy
 zUBcvXSkS27qn5iNSGCipeSD72tRmBWbmq5AOYvRFmihiQXtZ3OXFT07OqlcIGq7Xh0AxXEFjLf
 GA8PALT7Om/qn1Wy9UA==
X-Proofpoint-ORIG-GUID: Hea_ytqYTWKHaRO7LVWo3WtcYs3dH_P-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 bulkscore=0 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130209
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

On 5/13/2026 5:13 PM, Dmitry Baryshkov wrote:
> On Wed, May 13, 2026 at 02:22:59AM +0530, Akhil P Oommen wrote:
>> When separate_gpu_kms=1 (or the device is compatible with "amd,imageon"),
>> msm_gpu_no_components() evaluates true and adreno_probe() bypasses the
>> component framework by calling msm_gpu_probe() directly. In this case,
>> we skip creating components and directly bind the GPU.
>>
>> That shortcut makes it impossible to add a second sibling on the GPU
>> master without introducing ad-hoc plumbing. To prepare for adding the
>> GMU as a peer component on this master, turn the GPU pdev into both a
>> component master and the sole component of itself in this path. A follow
>> up patch will introduce GMU as a component device.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>  drivers/gpu/drm/msm/adreno/adreno_device.c | 20 ++++++++++++-----
>>  drivers/gpu/drm/msm/msm_drv.c              | 35 +++++++++++++++++++++++++-----
>>  drivers/gpu/drm/msm/msm_drv.h              |  6 ++---
>>  3 files changed, 45 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
>> index 66953e551d86..67686424f3a1 100644
>> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
>> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
>> @@ -271,18 +271,26 @@ static const struct component_ops a3xx_ops = {
>>  
>>  static int adreno_probe(struct platform_device *pdev)
>>  {
>> -	if (msm_gpu_use_separate_drm_dev(pdev))
>> -		return msm_gpu_probe(pdev, &a3xx_ops);
>> +	int ret;
>>  
>> -	return component_add(&pdev->dev, &a3xx_ops);
>> +	if (msm_gpu_use_separate_drm_dev(pdev)) {
>> +		ret = msm_gpu_probe(pdev);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	ret = component_add(&pdev->dev, &a3xx_ops);
>> +	if (ret && msm_gpu_use_separate_drm_dev(pdev))
>> +		msm_gpu_remove(pdev);
> 
> What about making it more clear:
> 
> 	if (!msm_gpu_use_separate_drm_dev(pdev))
> 		return component_add(&pdev->dev, &a3xx_ops);
> 
> 	ret = msm_gpu_probe(pdev);
> 	if (ret)
> 		return ret;
> 
> 	ret = component_add(&pdev->dev, &a3xx_ops);
> 
> 	if (ret)
> 		msm_gpu_remove(pdev);
> 
> 	return ret;

Ack. this is more readable.

> 
> However with this patch in place, maybe it's easier to use the main
> msm_drv_probe()? It would need some fixes to handle !kms case as the
> GPU-only, but it looks very similar to your new functions.
>

Agree. Will do this in a separate patch in the next rev.

> 
>> +
>> +	return ret;
>>  }
>>  
>>  static void adreno_remove(struct platform_device *pdev)
>>  {
>> +	component_del(&pdev->dev, &a3xx_ops);
>>  	if (msm_gpu_use_separate_drm_dev(pdev))
>> -		msm_gpu_remove(pdev, &a3xx_ops);
>> -	else
>> -		component_del(&pdev->dev, &a3xx_ops);
>> +		msm_gpu_remove(pdev);
>>  }
>>  
>>  static void adreno_shutdown(struct platform_device *pdev)
>> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
>> index b61deafd02c3..af5aa7ff6179 100644
>> --- a/drivers/gpu/drm/msm/msm_drv.c
>> +++ b/drivers/gpu/drm/msm/msm_drv.c
>> @@ -1097,10 +1097,25 @@ int msm_drv_probe(struct device *master_dev,
>>  	return 0;
>>  }
>>  
>> -int msm_gpu_probe(struct platform_device *pdev,
>> -		  const struct component_ops *ops)
>> +static int msm_gpu_drm_bind(struct device *dev)
>> +{
>> +	return msm_drm_init(dev, &msm_gpu_driver, NULL);
> 
> With this patch in place, we can remove the ops argument from
> msm_drm_init() and msm_drm_uninit().

I didn't notice this. Will drop the unused arg. Thanks.

-Akhil.

> 
>> +}
>> +
>> +static void msm_gpu_drm_unbind(struct device *dev)
>> +{
>> +	msm_drm_uninit(dev, NULL);
>> +}
>> +
>> +static const struct component_master_ops msm_gpu_drm_ops = {
>> +	.bind = msm_gpu_drm_bind,
>> +	.unbind = msm_gpu_drm_unbind,
>> +};
>> +
>> +int msm_gpu_probe(struct platform_device *pdev)
>>  {
>>  	struct msm_drm_private *priv;
>> +	struct component_match *match = NULL;
>>  	int ret;
>>  
>>  	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>> @@ -1116,13 +1131,21 @@ int msm_gpu_probe(struct platform_device *pdev,
>>  	if (ret)
>>  		return ret;
>>  
>> -	return msm_drm_init(&pdev->dev, &msm_gpu_driver, ops);
>> +	/*
>> +	 * The GPU pdev acts as both the component master and the sole
>> +	 * component (added by adreno_probe()). Future patches add the
>> +	 * GMU node as a second component on this same master.
>> +	 */
>> +	drm_of_component_match_add(&pdev->dev, &match,
>> +				   component_compare_of, pdev->dev.of_node);
>> +
>> +	return component_master_add_with_match(&pdev->dev, &msm_gpu_drm_ops,
>> +					       match);
>>  }
>>  
>> -void msm_gpu_remove(struct platform_device *pdev,
>> -		    const struct component_ops *ops)
>> +void msm_gpu_remove(struct platform_device *pdev)
>>  {
>> -	msm_drm_uninit(&pdev->dev, ops);
>> +	component_master_del(&pdev->dev, &msm_gpu_drm_ops);
>>  }
>>  
>>  static int __init msm_drm_register(void)
>> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
>> index 6fcb696ceb7c..6264ff27496f 100644
>> --- a/drivers/gpu/drm/msm/msm_drv.h
>> +++ b/drivers/gpu/drm/msm/msm_drv.h
>> @@ -544,10 +544,8 @@ extern const struct component_master_ops msm_drm_ops;
>>  int msm_kms_pm_prepare(struct device *dev);
>>  void msm_kms_pm_complete(struct device *dev);
>>  
>> -int msm_gpu_probe(struct platform_device *pdev,
>> -		  const struct component_ops *ops);
>> -void msm_gpu_remove(struct platform_device *pdev,
>> -		    const struct component_ops *ops);
>> +int msm_gpu_probe(struct platform_device *pdev);
>> +void msm_gpu_remove(struct platform_device *pdev);
>>  int msm_drv_probe(struct device *dev,
>>  	int (*kms_init)(struct drm_device *dev),
>>  	struct msm_kms *kms);
>>
>> -- 
>> 2.51.0
>>
> 

