Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B942CD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 11:43:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC8E410E5CD;
	Wed, 13 May 2026 11:43:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cgAn+non";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g2lLWfJp";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC7DE10E5D1
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:43:27 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DAVKil3430141
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=UkyD0xKerVbIAXiG43DrA/Ry
 ShtWpfl8ICPJ8+orXi4=; b=cgAn+nonSupl25K6PuR0ewknE+ofnZJWgdmKZ/Jb
 iHdhmrQrYP7Vl0/v1t1KyknpDE17DH/XzY8Ln4cpET73ID0JzPe0UTzqxQb+aLvH
 RjZ7vlYCYn2SsOo5o8VUEbixY5ytJv1Ro04C9BpLNT/XXWlgCJ7HhibYzecYgooq
 1UzKARO8Phqd79cFHV4JK/OpNAndQC/7evMX+WNuzQgDJHoip8qsQnm0Z6P1kJCR
 jfG/b6EjPGsVaKqs3ocFnjDhtmQAi8XsUJXx7CJ7Bfh5QM+ZZXboXC2SL3EpQk9K
 XmGZZFG3dyts0SOqGLbWqGo7qlhM8ZVGuS/1PmSPNk8Usg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4qmcg860-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:43:26 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-514cbe73d00so60325181cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 04:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778672606; x=1779277406;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UkyD0xKerVbIAXiG43DrA/RyShtWpfl8ICPJ8+orXi4=;
 b=g2lLWfJpWWU/yp54452X+/CWlmlZwYyzl44yv80sF0JW6NV4tn2tjcrqDgs3y7uwYY
 dYjRhv+92PJsQyMgHCGa9jAUPUTjd8WdaJsarfHt+x+3a5eTCz8t+7kp8F5nOe38KTjp
 t1lqG2qSRNBgx1gyzg939IckKK+txYEtCONorQQzt42W01bdttYmWx3TdXCc67DIkSQx
 gQolVdHslrScwIDrB+PdKYuBuGxX5hrtsML6w7Zht1m0JRMULigWozFtGKFS/2WYJGP5
 vwRPxVaruCIKL62Bvtw19QAtkwUpeHlajWIOCX+9ciCgHBsq61vcxXeGbfKEQFz21B3J
 TOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778672606; x=1779277406;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UkyD0xKerVbIAXiG43DrA/RyShtWpfl8ICPJ8+orXi4=;
 b=RFLqVGtMNzDiOk/LgFtoLCEBlWVEbtasRqGV4Tm9juCjVi5v3BNznHamwY+SnUZkP5
 kFlRwUX4BB+kA+DmrXq4zhZBNzOlQwTB9f2OBDVt6twCj+zKXbajw8EDvt4XcygsJS1P
 ecZEBEmc+NRDrcm0tjhw+EP8sCYxxFprLbqxztU5h7WzO4Y9PFC1Z9hWs+si309CttOU
 wkRD4XssZUOFckh6tEetaE0C/ynaJGKPUZa6gL7pVSYtCYAJzFu0jtxV3Ziyy64+nxLT
 h2ahUWDp8CVu2TYMWboERD29elKyb6UfKDwnoNdJV8qYBUJvzJQxIETOFH3Jj1N6ECiF
 9Kdg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/XsHHUaWFm1pYQFm7mcflTA+bqii088pecIS0h4kbb/YE6pZo3loI2SPrjX7c2Z4hej8oJOyY1teg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzEIUXwj0jy9JiUBdoIrDqcfkaFCMhYv0puNYQnOyMdm1A6XnKZ
 vpxOi8Opfw2ONo2RqrI9nG2Kx4T5mUm+67ngvTxG+1GRoykX67Kee/jGVu1NVT9xzRbH7vDUcyt
 vwVBBFyAswoaemd6EoD3NRzNJDe9uJMgvky72CK1nLN8UIDCAQWahu5UbfAmZJ8zVWTpFUtI=
X-Gm-Gg: Acq92OHEBNDlui6ll/0mw2TC0jCqpsmcpq/unTMBrgIKz55KimKblC0MskC5Up3qo94
 H1BkGVFpyDeV2A1FRTo5Uc9JUwvIaD+SJvNM2+C9aeIGEAq8lk/FCbTwpccA5iz6V7Aj0MKZVZX
 gOyfNgoCbbXmTM6KR17TOhWQF5zMgYnxAm+9baRo8j2XHY4BZCz33xW7rc9GDqux2ql5duEnLbQ
 N/paNz0TfzWUAIkFrYt/ebzmMPOnxFJ08l8DOM9zWFv4WNqwUdbNiPS3B6asdkcE+6sIZnsuq/s
 RJuFuc9aXWYnMm7rb6KQJiezk/MFvaWuuFgzZR8OdOEpfs8yNlhErkp0AQyo0KA+IFWsxHxNYah
 7CDGAmzSuhZuwY3wCkQvCUsPgv8Z83VmDMeFaffBHBRHdXTnbM2e76bjBjsZApmGh65bj0ivPiH
 ZFxt39DnC3WZOmuLT5UrxFWMbAUaJaGBoPsD0=
X-Received: by 2002:ac8:588e:0:b0:50e:5de8:6458 with SMTP id
 d75a77b69052e-5162f63c521mr36966281cf.57.1778672605973; 
 Wed, 13 May 2026 04:43:25 -0700 (PDT)
X-Received: by 2002:ac8:588e:0:b0:50e:5de8:6458 with SMTP id
 d75a77b69052e-5162f63c521mr36965821cf.57.1778672605393; 
 Wed, 13 May 2026 04:43:25 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-393f625bd3bsm41131021fa.34.2026.05.13.04.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 04:43:24 -0700 (PDT)
Date: Wed, 13 May 2026 14:43:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
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
Subject: Re: [PATCH RFT 4/5] drm/msm: Always use component model for
 standalone GPU
Message-ID: <pbvoyojew67yeo2cr4n7msem242ytlh2qqtrxli2q3tv7e3iao@myqtn5w57paz>
References: <20260513-gmu-sync-state-fix-v1-0-6e33e6aa9b4f@oss.qualcomm.com>
 <20260513-gmu-sync-state-fix-v1-4-6e33e6aa9b4f@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513-gmu-sync-state-fix-v1-4-6e33e6aa9b4f@oss.qualcomm.com>
X-Proofpoint-GUID: 4jlRKMiJBwW3W7Dt-62jknNEamEPMfS0
X-Authority-Analysis: v=2.4 cv=Hu5G3UTS c=1 sm=1 tr=0 ts=6a0463de cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=hS7WgQE5nrJr_MMTOVAA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDEyMiBTYWx0ZWRfX2G5VTzaH7q3y
 JQCjUWjwl5Q5SY+vO0yb6dyWksYYV/BRckOs8nIGJpuVcfeWeEqzjPR3zufD6VvS1cP91FfyH4N
 DNDbSAUrCeM4veiwKVyLpKGDdmG0gmfCth+di9y3zEceH2tDdIfrV7OCUPOXSH1DkZS4UCn69Mn
 YnasDTvWrbQCsXvx90k1b+krAgiGYzMSLiWGFHgPd3Owl0KWZnBpGCcaMU1pTu2pvzPFbf9vqP8
 1uvG0pPDmp/hwaGkrZyXphL/DiMoPAhU78cKrPnDr045pAI30fyMAbP7hNO66O4/dWDP5+Bo+2t
 IANANOYnXAfshXaLFRIOOmzPXzG/QSrVp0u6fLZK1mQAJyrzKMqMZS75M4WP6EI29KkIBbpHvXA
 L9uJl7Mn2QJHO859z/hvueUKRFE6rskY/3TJAKfGDpFHO6NVhdfsGiYl4k5cw6Htcow4wJS4fp9
 QLTLmnSyfDgBf9rwOkA==
X-Proofpoint-ORIG-GUID: 4jlRKMiJBwW3W7Dt-62jknNEamEPMfS0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130122
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

On Wed, May 13, 2026 at 02:22:59AM +0530, Akhil P Oommen wrote:
> When separate_gpu_kms=1 (or the device is compatible with "amd,imageon"),
> msm_gpu_no_components() evaluates true and adreno_probe() bypasses the
> component framework by calling msm_gpu_probe() directly. In this case,
> we skip creating components and directly bind the GPU.
> 
> That shortcut makes it impossible to add a second sibling on the GPU
> master without introducing ad-hoc plumbing. To prepare for adding the
> GMU as a peer component on this master, turn the GPU pdev into both a
> component master and the sole component of itself in this path. A follow
> up patch will introduce GMU as a component device.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_device.c | 20 ++++++++++++-----
>  drivers/gpu/drm/msm/msm_drv.c              | 35 +++++++++++++++++++++++++-----
>  drivers/gpu/drm/msm/msm_drv.h              |  6 ++---
>  3 files changed, 45 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> index 66953e551d86..67686424f3a1 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> @@ -271,18 +271,26 @@ static const struct component_ops a3xx_ops = {
>  
>  static int adreno_probe(struct platform_device *pdev)
>  {
> -	if (msm_gpu_use_separate_drm_dev(pdev))
> -		return msm_gpu_probe(pdev, &a3xx_ops);
> +	int ret;
>  
> -	return component_add(&pdev->dev, &a3xx_ops);
> +	if (msm_gpu_use_separate_drm_dev(pdev)) {
> +		ret = msm_gpu_probe(pdev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = component_add(&pdev->dev, &a3xx_ops);
> +	if (ret && msm_gpu_use_separate_drm_dev(pdev))
> +		msm_gpu_remove(pdev);

What about making it more clear:

	if (!msm_gpu_use_separate_drm_dev(pdev))
		return component_add(&pdev->dev, &a3xx_ops);

	ret = msm_gpu_probe(pdev);
	if (ret)
		return ret;

	ret = component_add(&pdev->dev, &a3xx_ops);

	if (ret)
		msm_gpu_remove(pdev);

	return ret;

However with this patch in place, maybe it's easier to use the main
msm_drv_probe()? It would need some fixes to handle !kms case as the
GPU-only, but it looks very similar to your new functions.


> +
> +	return ret;
>  }
>  
>  static void adreno_remove(struct platform_device *pdev)
>  {
> +	component_del(&pdev->dev, &a3xx_ops);
>  	if (msm_gpu_use_separate_drm_dev(pdev))
> -		msm_gpu_remove(pdev, &a3xx_ops);
> -	else
> -		component_del(&pdev->dev, &a3xx_ops);
> +		msm_gpu_remove(pdev);
>  }
>  
>  static void adreno_shutdown(struct platform_device *pdev)
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index b61deafd02c3..af5aa7ff6179 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -1097,10 +1097,25 @@ int msm_drv_probe(struct device *master_dev,
>  	return 0;
>  }
>  
> -int msm_gpu_probe(struct platform_device *pdev,
> -		  const struct component_ops *ops)
> +static int msm_gpu_drm_bind(struct device *dev)
> +{
> +	return msm_drm_init(dev, &msm_gpu_driver, NULL);

With this patch in place, we can remove the ops argument from
msm_drm_init() and msm_drm_uninit().

> +}
> +
> +static void msm_gpu_drm_unbind(struct device *dev)
> +{
> +	msm_drm_uninit(dev, NULL);
> +}
> +
> +static const struct component_master_ops msm_gpu_drm_ops = {
> +	.bind = msm_gpu_drm_bind,
> +	.unbind = msm_gpu_drm_unbind,
> +};
> +
> +int msm_gpu_probe(struct platform_device *pdev)
>  {
>  	struct msm_drm_private *priv;
> +	struct component_match *match = NULL;
>  	int ret;
>  
>  	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> @@ -1116,13 +1131,21 @@ int msm_gpu_probe(struct platform_device *pdev,
>  	if (ret)
>  		return ret;
>  
> -	return msm_drm_init(&pdev->dev, &msm_gpu_driver, ops);
> +	/*
> +	 * The GPU pdev acts as both the component master and the sole
> +	 * component (added by adreno_probe()). Future patches add the
> +	 * GMU node as a second component on this same master.
> +	 */
> +	drm_of_component_match_add(&pdev->dev, &match,
> +				   component_compare_of, pdev->dev.of_node);
> +
> +	return component_master_add_with_match(&pdev->dev, &msm_gpu_drm_ops,
> +					       match);
>  }
>  
> -void msm_gpu_remove(struct platform_device *pdev,
> -		    const struct component_ops *ops)
> +void msm_gpu_remove(struct platform_device *pdev)
>  {
> -	msm_drm_uninit(&pdev->dev, ops);
> +	component_master_del(&pdev->dev, &msm_gpu_drm_ops);
>  }
>  
>  static int __init msm_drm_register(void)
> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> index 6fcb696ceb7c..6264ff27496f 100644
> --- a/drivers/gpu/drm/msm/msm_drv.h
> +++ b/drivers/gpu/drm/msm/msm_drv.h
> @@ -544,10 +544,8 @@ extern const struct component_master_ops msm_drm_ops;
>  int msm_kms_pm_prepare(struct device *dev);
>  void msm_kms_pm_complete(struct device *dev);
>  
> -int msm_gpu_probe(struct platform_device *pdev,
> -		  const struct component_ops *ops);
> -void msm_gpu_remove(struct platform_device *pdev,
> -		    const struct component_ops *ops);
> +int msm_gpu_probe(struct platform_device *pdev);
> +void msm_gpu_remove(struct platform_device *pdev);
>  int msm_drv_probe(struct device *dev,
>  	int (*kms_init)(struct drm_device *dev),
>  	struct msm_kms *kms);
> 
> -- 
> 2.51.0
> 

-- 
With best wishes
Dmitry
