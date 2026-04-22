Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E11CF94CC2
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 03:41:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DECD10E1AD;
	Wed, 22 Apr 2026 03:41:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aW8U178A";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EuTfqE8Q";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C898B10E02C
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 03:41:21 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63LIZkrP3377480
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 03:41:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=MMug9LqgfVUt6SjvE7w1lQYp
 otHgvj76086AHDBtW40=; b=aW8U178Avbx8lafqkfk52PCJTETxSIZwJu+uVMp3
 SJu6LLsQpHNMCYWAUTylbZFxI9dldZNjl+IVyDClvzmKq2w/Iq47VpOnBiS91XiQ
 y0Bn9DWieq3gUavus8+MOsEzFEijThAz8oOz2cpY5mUxxo1szOfNh0+VGU1G60GT
 O456hp5gWd7w59W42tTu8Zo+TBc8PEr+HzHEnrUWQDDXoHp3MCMvI2wpFMs4NDKj
 vmYRpZPHfzoqeVBIRiqYGEte3uZcLv/YljOuGMIwZd+Idp7yceFBLWxaDtVN1Xdd
 hcSl8jBAjjx6qWRq7tY4nhK0PTygKW2+iP+TutlV0+cSpw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpeng1gym-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 03:41:20 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50d8dac6233so84465031cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 20:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776829280; x=1777434080;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MMug9LqgfVUt6SjvE7w1lQYpotHgvj76086AHDBtW40=;
 b=EuTfqE8Q/Mv/j8F5QTUVuf1EoDY111LF1O73nanQfNSIbbjE0VfjeHAZxqyiY+lKyP
 LQYpTgkakFxaoqM9VKwRO6O4jZHfca6fSNcc+PzDHW374yzQL4tejCUkLP73T9paKZtd
 AzwVAgmKdXTos8UYtf1kbnUWCMQQIytZRGJglEguSy8/daENlRPHEzNdmFXTYH+hLfd0
 YqDnWH9WxJOTKzVzk0fgw5qHqJHoaVNt/UG9PiC6rD6obazI/YbfUWS07Cstg60IBVQc
 gZKch4VWQeS27AxiZU8K0jAvYI79kLnjDTDUOe2EHrGDOGMCDy0R3jqrE6JLaxNIpeWi
 jBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776829280; x=1777434080;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MMug9LqgfVUt6SjvE7w1lQYpotHgvj76086AHDBtW40=;
 b=d1xLHanhAC6/KTi9DF7RWBoSWlFJykN0bit40j8V6PVGKMXxHG4Y9o9rPHVfwiTawg
 RUG9FgYE0zzS4mqMD/S/2GjHeOeWhdnMdC6HWH/QgQJWjazKaBQ01jtKGM+5uJex496g
 BfsJOiYxbrI0hXERMUjT9TD0pUe9Xboo3Ryw342rLiPGY4yFrV3zfvGNf7VIn+a3vi1V
 mnrn3ann18cTbV/sns3MJ0MxTlSf7gL6gI0XrQE5YLXjoVgKBs6xpxLAKyShFItx/xhs
 0jx8BEOZs7sYvwmYERKg6NNw7x7fOA+fukDVKrfm2s2oqPZzunNA8J3T1VN7+BHbPQg6
 wWxQ==
X-Gm-Message-State: AOJu0YwTWr6QyiEnieoXUWsDWB99KBzNhXBLMIQCIKoafRayhE25XMRP
 /X5Z7wk7d1SBJVtwFN4JcPf+N+282741lqLOlYnS2GrRqnoxyLe3bS7GeqqTi7ErkFHbbniRB3/
 ZgsGEFm5dHE38Aqj6HcVuxeZX9ch194ZE2bU9iLwCwNkcu1k8lFM389VgagovSbBjyRwZeS8=
X-Gm-Gg: AeBDievzrSc3yJ21Jn1ur38sqR5f/RmOG+qIkxRa9DNapvP7trQFdalvfsy51r3HypH
 rqihb+bG5zqjhPIX3sfbGCK7wuk2M/XRmbuRUQc7jO525bT4Nohv9qCEcK2u5jY24W66F9XkHG/
 d3CPyiHL+IiHeZdzLq1zorN7GvXqf8AyaXFlwOKh19pj4qWkrHO5RfAjb8NGkyCXUwjc8Ji1RRV
 Jv/J1girpKQsIxdOwjJ8d1jrMpWC0Si1vA1ahrkiqSY5TfRM9voSPpv55Zy1kPdB4fYlSYXZj8V
 HwKYxxFgbtSUEH8kDsG+AMzdmiIOCC2P0kNase/x0TNegXofPgHRz/V1d1jO5U//gfEyNOz73oK
 4JsL9mjApKf9xMTDUB6oCEU2Mxe3jq+RJRFGgC9bjjXnJZ+yfcMui5mohmZhAjzPOnJiS3ngYDI
 /WSxU97+fXviKmmoCfzDuWYC05/dYyPbuHFi/R2NNkRdP5lg==
X-Received: by 2002:a05:622a:258b:b0:50e:89e9:2728 with SMTP id
 d75a77b69052e-50e89e92bcbmr154258151cf.19.1776829280329; 
 Tue, 21 Apr 2026 20:41:20 -0700 (PDT)
X-Received: by 2002:a05:622a:258b:b0:50e:89e9:2728 with SMTP id
 d75a77b69052e-50e89e92bcbmr154257801cf.19.1776829279860; 
 Tue, 21 Apr 2026 20:41:19 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185bc1f6sm4044337e87.20.2026.04.21.20.41.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 20:41:17 -0700 (PDT)
Date: Wed, 22 Apr 2026 06:41:14 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 13/13] drm/msm: Add PERFCNTR_CONFIG ioctl
Message-ID: <a3nvz2coifdazaoyssm7xtxmyiusvofxu5f2p44kvrgvpa7hbc@jmj6gyttetcr>
References: <20260420222621.417276-1-robin.clark@oss.qualcomm.com>
 <20260420222621.417276-14-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420222621.417276-14-robin.clark@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=CNUamxrD c=1 sm=1 tr=0 ts=69e84360 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=4q_80zGUEmdwlJpOyfQA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: KOz3m65sWTRnCEfRW_Ovu5HpG-B1m_QM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDAzNCBTYWx0ZWRfX8dvhDEw60oqK
 WLsuW0sh73UPJT5oavxCfsuf0plcEiDzjaWf2A7I4uihr7lIohRq5Ks+rA2ogINNAYfu/CMdnxp
 7q+VrPli27YgzwwHt67L4KJMPT7P8OG3ydBRokz+sybXhmWUCPAXh3vOYAfVbRqm+EU64i4nEJU
 GM1JS+V4svDng6Am+PzNQWlUxESxGTLAgA099qTX8YFFnUOhC5vu+QHOji4e5WduZt16ZZ/m2hN
 cof0P7uwUJ1mI/jwkQkb29HvfeaJHBjYK6zdEM1a4uc5CUQMxndQN5BbJojyI0PvS9qMHPAB5eN
 ocDcQa2hgq2fHaV5TOyoEYiqyGXe/cBQlMFbwONsfELPZcjhi8FI81jPyn2Nq9v/h/kSgZ6RXP8
 PrPKDS81BQbTNmNST0hm6fSG7RA5ovDjoe5tikqIGgvIDAISXj6atobTajZ6Lkr2pl9zvHhwhQ2
 QPG1onvAUFHT33rhr4A==
X-Proofpoint-ORIG-GUID: KOz3m65sWTRnCEfRW_Ovu5HpG-B1m_QM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220034
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

On Mon, Apr 20, 2026 at 03:25:35PM -0700, Rob Clark wrote:
> Add new UABI and implementation of PERFCNTR_CONFIG ioctl.
> 
> A bit more work is required to configure the pwrup_reglist for the GMU
> to restore SELect regs on exist of IFPC, before we can stop disabling
> IFPC while global counter collection.  This will follow in a later
> commit, but will be transparent to userspace.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/msm_drv.c      |   1 +
>  drivers/gpu/drm/msm/msm_drv.h      |   2 +
>  drivers/gpu/drm/msm/msm_perfcntr.c | 489 +++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/msm_perfcntr.h |  54 ++++
>  include/uapi/drm/msm_drm.h         |  41 +++
>  5 files changed, 587 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 3066547f319b..0a7fc06113e0 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -801,6 +801,7 @@ static const struct drm_ioctl_desc msm_ioctls[] = {
>  	DRM_IOCTL_DEF_DRV(MSM_SUBMITQUEUE_CLOSE, msm_ioctl_submitqueue_close, DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(MSM_SUBMITQUEUE_QUERY, msm_ioctl_submitqueue_query, DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(MSM_VM_BIND,      msm_ioctl_vm_bind,      DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(MSM_PERFCNTR_CONFIG,   msm_ioctl_perfcntr_config,    DRM_RENDER_ALLOW),
>  };
>  
>  static void msm_show_fdinfo(struct drm_printer *p, struct drm_file *file)


Should we also increase MSM_VERSION_MINOR?

-- 
With best wishes
Dmitry
