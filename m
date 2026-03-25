Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E51FEA803
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 04:34:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B7B910E193;
	Wed, 25 Mar 2026 04:34:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UxXtUFqX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="InKjl/Eo";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA76910E193
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 04:34:25 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OJOaWQ1862769
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 04:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=EHUp7/16YUMBtKGES+yYYqc2
 0LzNJsKIcI6vCitDSoc=; b=UxXtUFqX1/6g2nxsMa/K3D44muLA4QP/qfif7ikK
 0PfGqXPH2DkXPdFnv2JwH9dBZrMi+CJqXZ0Fx5kAQPk9xIyNvrptcTe2T39UgZRD
 PqQ9HCtVYJnygYaIfjzbz/TXWLO5j1HuJqsSRgROj20zluZNW1VYdXF495ZZnzmo
 kQW5B/W7yOkgLxG3oM1WyUL0pFOI4P4e6nmddPEUOF8OeK5190ahq1G2S+KRAZLx
 FjtOUwxDpHveFbF9HNRmUu11f7KytW5gnm2N/GHuedbMnGAxOs/bt4U7Z2UpMdLK
 7xeadyqyfvYZQ6/nJzG5hnrxVaUQfMPYQJzdZGp34rGkDA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d40rasdtd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 04:34:24 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50917996cfaso133432381cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 21:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774413264; x=1775018064;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EHUp7/16YUMBtKGES+yYYqc20LzNJsKIcI6vCitDSoc=;
 b=InKjl/EoNM7YfzTElXvU+y/j/AHx2Jcil+6cUI6MOSMHHw39OLvUwkuGf2xp/V1fO/
 OhW0lCgkUElb7vnF89hNDXki/6vPfSQ8TW6RYkss8UjhPEtk1fn3Cjy9FqI80t9YdNsj
 vcDKY0VScROF7O+jGYSZCD4lNK+zyzmGdQeY8NQcY1yHFA/sCMq6WHXuQiBqlhjQH7Up
 3+OfA07jtgUzkbOAhx0KDnN09GTgFz6GRYnzvjXHetsuHzcgkRE/MVirPAbYfyzfulOa
 jf5Hn8q5Jd7BOYWb8Gxi8LWHo90B4fSMF4PrGeSQgg8NBTVrFlgIlJ8K1u/vBgzPnTt8
 ca6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774413264; x=1775018064;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EHUp7/16YUMBtKGES+yYYqc20LzNJsKIcI6vCitDSoc=;
 b=kPXTKv1tAvZX94MTaqYWn5xB0cIGB7U9Ij91mGrPz3LIP/UYourD94v08Ta8Sew+Jt
 1rqYHO41V5eebvREFMbKIHVFQIVG1TTtMIY/h2qIaHJVydVmrFbSkn/HEDrYFMgyPRQF
 uBg6awRR80hH5dRgnqLuG7umzG3FOqAmABHi7UnT6ff8F/79HzIK4PjOnf011SbNc+gX
 07IxPgRJYoMv3Wo1z3VxRkZua5WFF1xuCyDy1CgXwFNYlPrQnAA1wsYCLPGDC83aRb5Q
 w+ON7eGaz5MbSEk14I1tSsNZ+2g0UGjt5fTFIUcJKaZGk33rLUSl6wWf7etvYHa6bp67
 o9ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1882Y6CRhJX17umJpIqEwYsbjpPAt2oGxjjgILan31VBObP7YW0kxrpr0mRJ97izNjM+izFHdOw8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzBLwn/8c+9/7mpbaMPhmnHLuvtGSAK0uZgZ7Le8maEozETQpnq
 OWp6jq1zw4k/Ybp/u16bLoRCwuitZWPUKp3z9LtkAGEm5MGH33Ye6SPfqogGholuS0oRGvD1A6c
 Y28QQSUGMR6qwxdHR2cRajzwPXMh/wM1VwCC44AvkaZVX0WkFtgi6aA/zdVzGqat7qSNHaLo=
X-Gm-Gg: ATEYQzwW1fuDGvLJcexADe4JKcAoNhEkHAWYB/P6Wgv5COkVQI2E8q8hu0VBzM61g/b
 XyT/ITQkm60tanh6QS2EQkx4HxujXpt3I01et0wbL340Ujq94OLcssmKQEqRLGkIf9Kf6B9YGBn
 LI7WfRv7Z4osf1pgnHYufnYFYshdpFHBqrBcRKfXKGf1TlPEQ/L3Ts4EK6MNp7B7x/t9z/3bcCx
 cpOmjP7e/6qzqN+DUTT4lt/gpM2gKEJW0oJEnXT0bNGYcaxGKdkSzK28Dw8G9LVH7QUcWEc8/Dk
 CVuzkDo9pygeR7pegpxFlgOKJamGsVCJgM+XohgKOn7WH2Vit/g57MPo9P9UAHo6Ry42nPV4cia
 KnY7jjPPzaxlGlBg4+kXy8JNl7qSXZDVcEFLT7JAIeOAo/yecJyr+HZzexzcO3LSaoYvtmlQkb/
 d0s4O0G6XTd/p40i9bQCkD1jzk2G2YHKL6b84=
X-Received: by 2002:a05:622a:4ce:b0:509:1987:7626 with SMTP id
 d75a77b69052e-50b80ed53b8mr28888471cf.68.1774413263899; 
 Tue, 24 Mar 2026 21:34:23 -0700 (PDT)
X-Received: by 2002:a05:622a:4ce:b0:509:1987:7626 with SMTP id
 d75a77b69052e-50b80ed53b8mr28888091cf.68.1774413263409; 
 Tue, 24 Mar 2026 21:34:23 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a285207500sm3648167e87.41.2026.03.24.21.34.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 21:34:21 -0700 (PDT)
Date: Wed, 25 Mar 2026 06:34:18 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org, andersson@kernel.org,
 konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
 dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org,
 elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jjohnson@kernel.org, mathieu.poirier@linaro.org,
 trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
 pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
 tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
 srinivas.kandagatla@oss.qualcomm.com,
 amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
 op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
 skare@qti.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH 10/14] drm/msm: Switch to generic PAS TZ APIs
Message-ID: <v4ffww2r4ljqqbmvsc5jcr4ztqjbpfb42xryjeuz4abqiwup3a@2gfeelhjzzz4>
References: <20260306105027.290375-1-sumit.garg@kernel.org>
 <20260306105027.290375-11-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306105027.290375-11-sumit.garg@kernel.org>
X-Authority-Analysis: v=2.4 cv=Jvr8bc4C c=1 sm=1 tr=0 ts=69c365d0 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=kPJGyq6PTXsXdZOMel8A:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: 8TEbB6ehb4_9TkHcIxjRnFbq0fx7WcBl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAyOCBTYWx0ZWRfX60gpbatsv09S
 EY9iZLElNQK6ZDDJco6u4QcQjygOylL5XFDT+DsWYBW8dYR9v9YcjkHD1ju37CmqWMU6t8Nk0Fs
 BdamZ4GHXpyV/7AHSRQTTK0w3D07Y6AOwLkeNRg62sXer4mCSqYcx6BH8bKt3tzmF8jLA0roMop
 Uyu7pcLxDu0xqczFcX8bs+Ui794k0+j52d9+ugt7KynI+O+WmH3TAvGs/QLSxpJNbCt0amhyTKf
 DcVuEWp5q/KPLnLmoVtGHZr2Dx+/JHqq4VRLqs2uAFTotX2QY2IYluU9f4NDKCYJ+ZSraErOgh9
 M2Cv+bh0dUe4OT9IZT9+k0T3X+NZpkRrLPLP/KwfbUYVL3HflWN0paFEenOFV2ePttnDch3l9Wm
 kzAcQKNZuZv+WW7/F7QZkFrWFHtYZDDN/KyhSbMW1iExM+vordxBFqCNSchyMydZ2oF9TGsIl5q
 UMwmT6msOggb6JoILqg==
X-Proofpoint-GUID: 8TEbB6ehb4_9TkHcIxjRnFbq0fx7WcBl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250028
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

On Fri, Mar 06, 2026 at 04:20:23PM +0530, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch drm/msm client drivers over to generic PAS TZ APIs. Generic PAS
> TZ service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |  4 ++--
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 11 ++++++-----
>  2 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> index ef9fd6171af7..3283852f9a14 100644
> --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> @@ -5,7 +5,7 @@
>  #include <linux/kernel.h>
>  #include <linux/types.h>
>  #include <linux/cpumask.h>
> -#include <linux/firmware/qcom/qcom_scm.h>
> +#include <linux/firmware/qcom/qcom_pas.h>

Missing `select QCOM_PAS`.


>  #include <linux/pm_opp.h>
>  #include <linux/nvmem-consumer.h>
>  #include <linux/slab.h>
> @@ -653,7 +653,7 @@ static int a5xx_zap_shader_resume(struct msm_gpu *gpu)
>  	if (adreno_is_a506(adreno_gpu))
>  		return 0;
>  
> -	ret = qcom_scm_set_remote_state(SCM_GPU_ZAP_SHADER_RESUME, GPU_PAS_ID);
> +	ret = qcom_pas_set_remote_state(SCM_GPU_ZAP_SHADER_RESUME, GPU_PAS_ID);
>  	if (ret)
>  		DRM_ERROR("%s: zap-shader resume failed: %d\n",
>  			gpu->name, ret);

-- 
With best wishes
Dmitry
