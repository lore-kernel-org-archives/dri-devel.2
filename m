Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F18B0D58CBF
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 21:34:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4677E10E4CE;
	Mon, 23 Mar 2026 21:34:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AgP2qOHK";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M9tGI1lh";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB5AB10E443
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 21:34:49 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NHqZC42971858
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 21:34:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=XL/mxvhwSK84ExUEbd63Igwq
 6w+EmRFKM9+Ygja1XaI=; b=AgP2qOHKIk4ZqiC0l+oS4vFqYFzVwQmqLBwWVE0h
 N9Tz7hpYt9IjDIjpinWgOPiezehmvzg+qUMjI3qs/O4ZK0eoztUfkFOzoBOYG75R
 b7MVGzuBwW7wTQJQU4kXcDTigJ7LMk4G+tfBi1iF5t2lcJhSKNYI2Abk8Maraafo
 WR/aZFHChAw/NNDvS5vvVeWkx7AAgaorfI1B+5I74tICBEJbKAw/+cZKPFVenaXI
 vMKMXzDoh4SKRExz3FcMILwXjLf1Nts/sTjZtNNMlI4OZ+Rdz7LzHaNOXdPc8sQP
 6psdI6/RRZFwA+dI9HhNyTAArjlm018s5FccjbLTdYh3tA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d31jc2tpb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 21:34:49 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50937cf66b5so157922151cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 14:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774301688; x=1774906488;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XL/mxvhwSK84ExUEbd63Igwq6w+EmRFKM9+Ygja1XaI=;
 b=M9tGI1lhTyME7YChXj5ZkDm8bxGbNOp7W7V5IxUP1e4+/enXbVPi8BEUqHclYdnV4g
 K5wVsCM4gY2MZ0VRGycW3/EgIXD0ebu4LtRdKr/0pJDVm8CVM6EFz8n4PxviVMqqfbj4
 buYelLHniB8yhW+rYklTdebK2zH0M2jCd4XlyF7+2r0hqArItuWQtDvjC8V/FFMrq7EE
 /dYlWfcILe0bsuDc31XAojWDp447rL/LXhn1sNNJBSkPQffPv0fefTYcj2tMeBu6V27u
 06nGYCjx2NGnPwM93310Kn4Q5JjC9Ly48BDPtKBDQ4U83ZAKPtOkcJS5vujvjbT1cwy1
 tNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774301688; x=1774906488;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XL/mxvhwSK84ExUEbd63Igwq6w+EmRFKM9+Ygja1XaI=;
 b=nE5VXHQQ4Sue+UYQrjsk+cj5irpFPudWzYkRXNGUIbKsAJ2l/RAPhjx6qc6bvNSF5F
 Yc99B/nrPGvd4eN9bG2WxA5OTJXMgcyrVfp8gmp3NNrN2SxiJHDxKXnYiDe1teKE8FqM
 eHzdkYoXW4qhYg3JlQbgHgA5FJY2rs3wwKQadaQD0ImYF/brk7kc/y6CjFqNY/5AN1Rh
 R9FyVNEzEARvxX4FDY/qo/zaal0C2y60X8jmb3aZOQAtNQIOQQajIHcQMXAIVTpROwLC
 v/8n1VZooFiOS++2pnZVwIlC/kE2+Hrb6fcUraLU1mirlfY/M1qdb6Ni3MARw195jki8
 OUcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMVlECT3ffWMeadLjEe+lfjdTrZxUHSGT+D9+NtJF2JdJPPuXndvS8XI/tw5fJRoMJhzsE8C9R+QM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy5R8itK9gKQEKKbhNNnDK0xh7iuZgc+FCL16PZbHDjvVsiCiqO
 m9XBVW3HfLMyr5jhk6lu+0oZZNboORNofppT3DL7/UM3KN1XJX8VBDcgreTN+Ze2HsRXep2r6RD
 EjGv90zp0frTN6Z7KcD/JfQpisnct7QWmhAoUHhFBEPqEt9raQ0XeYEDdehaZJDZ/0fvW11Q=
X-Gm-Gg: ATEYQzwH1EAZ3QzRj1d9NCWKle5g7fHVrVL9k/S2yfBmR6feCGPFB06TKcd5PPYY4MN
 RzNIqI2llB8shsCv157mC/nsjIK7QI6x+SaDub/8L6GM1HvzCOEgIn2gmm02jOa0c+ajvMfHcKp
 RxeIdHcmI9sJN5ecK6qciMYuThjp2xljz0IciTrIGNGoJZNJgN4F3+1AY8fFDxgA7YsIDwyZOFj
 /kz1BGyjlq5cP3x8fHgK0Cfy7KFRdxVlSCO8T6NGdCVVjl3BBMkcSNAZEmAsKOUoYH99OpuT7WS
 9ibu+jg6ergY/g83tSiotuyTj0NXR2411JtLynJiU6/RxBRkLnDBFmSXjBXDngnVe3byLesEZaM
 ZbPDKXBLEU/tMVhBY/qpaO6BwXY7d74y67dP4vvqwizI8xk8Cgo2Wc8EgqE0UBozGV3SHgO5a5l
 UXSN6PdvfgTA7y07DeTXwvt78pl4HqxcwDvBM=
X-Received: by 2002:a05:622a:1a92:b0:509:1ffc:c538 with SMTP id
 d75a77b69052e-50b3740caadmr226535261cf.19.1774301688148; 
 Mon, 23 Mar 2026 14:34:48 -0700 (PDT)
X-Received: by 2002:a05:622a:1a92:b0:509:1ffc:c538 with SMTP id
 d75a77b69052e-50b3740caadmr226534841cf.19.1774301687708; 
 Mon, 23 Mar 2026 14:34:47 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2967f8693sm82220e87.19.2026.03.23.14.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 14:34:46 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:34:43 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/16] drm/msm/a6xx: Add SKU detection support for X2-85
Message-ID: <x6b2miikgofuhfnrgnuf47mrrcbz2fkvht25dilo33teafcsax@v5f5j2g2wuxp>
References: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
 <20260324-a8xx-gpu-batch2-v1-12-fc95b8d9c017@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324-a8xx-gpu-batch2-v1-12-fc95b8d9c017@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=fKc0HJae c=1 sm=1 tr=0 ts=69c1b1f9 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=K4oKIo9cefoP7Fos7hIA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: Uk3V4F28PSVZksLIBUBFvL190hasyPPW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE2MCBTYWx0ZWRfX+/PPepdNka+H
 POcuDKCJpobVq1m4TQujd3K9N6CmvXkOw0PD5uis9i1RSIEHC/yhzGpS3RpdLgBJfdfxBE+8vTr
 DMSuzm2zZ2RkfC7te0qmELBI+4Alxa6IR5OwQvtMBmZhwmClLdj97hjminMEfhWo9pF3V7TUfpE
 EMRFP4QQ1rl5RJ2acMGcLvV8Z7w05G9MOfT2PFBb/BlQNIr9DxK4+UfRpg4WTleJeIZg5YY4kKt
 HuycMYHsK+vhf6nEpePzi8fTvhBOkmkzm5ut01tkNFuQ6V/vgAGIoJ1acWjdA4ao9NsdV7svFQ1
 bseySBmDvPNi+HlOnwaD7RLr1qKZ3S7O0lsmPPSFs/oz2FOppLUrm7fC1qsJftUFwlXZBVUHrwm
 sRvjJnrr2boI9uD+uxE1gm07ZzIBOUM8KxpPpCMqrTp6xDJM3HOCnP+za//hRKhC2/YAaod4PiG
 P4gVDMmxg0mHw+bOn/A==
X-Proofpoint-ORIG-GUID: Uk3V4F28PSVZksLIBUBFvL190hasyPPW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_05,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230160
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

On Tue, Mar 24, 2026 at 01:42:24AM +0530, Akhil P Oommen wrote:
> Adreno X2-85 series present in Glymur chipset supports a new mechanism
> for SKU detection. A new CX_MISC register exposes the combined (or
> final) speedbin value from both HW fuse register and the Soft Fuse
> register.
> 
> Implement this new SKU detection along with a new quirk to identify the
> GPUs that has SOFT SKU support. Also, enable this quirk for Adreno X2-85

SOFT SKU -> Soft fuse?

> and add its SKU table to the catalog.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c         |  6 ++++
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c     |  9 +++++-
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c         | 41 ++++++++++++++++++++++-----
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c       |  5 ----
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h       |  1 +
>  drivers/gpu/drm/msm/registers/adreno/a6xx.xml |  4 +++
>  6 files changed, 53 insertions(+), 13 deletions(-)
> 
> @@ -1213,10 +1212,6 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>  			devm_pm_opp_set_clkname(dev, "core");
>  	}
>  
> -	if (adreno_read_speedbin(dev, &speedbin) || !speedbin)
> -		speedbin = 0xffff;
> -	adreno_gpu->speedbin = (uint16_t) (0xffff & speedbin);
> -

You have removed this from the generic code and then added it to a5xx
and a6xx+. Wouldn't this cause a change on a2xx - a4xx?

>  	gpu_name = devm_kasprintf(dev, GFP_KERNEL, "%"ADRENO_CHIPID_FMT,
>  			ADRENO_CHIPID_ARGS(config->chip_id));
>  	if (!gpu_name)

-- 
With best wishes
Dmitry
