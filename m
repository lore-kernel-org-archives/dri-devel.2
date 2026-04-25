Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAFEFF885C
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 12:17:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32BAF10E41F;
	Sat, 25 Apr 2026 12:17:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gk3vtrNQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q6Q8qywE";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01FC110E208
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 12:17:39 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63P3a2sM625042
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 12:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=npr90gwsT5NmHlfS0yD/bLI3
 6eTJwhU1xjIXKSB/J18=; b=Gk3vtrNQjbbVlhzmPlbhxBpronK6iqfLEVQYwPPe
 Eu8dKttQeDXem680XaryEfUimz9i+LVgttnHImlUbq3YUdi+aC+0B/zwkk3C2u53
 4fUUh5b0LHgWBHgGgzuMaaBxHo8eahUBRAtmep25rO7HMn18Sp97lB8EFNKnVmox
 Vywmoyf1LPtzB2wGkQ0eWqRMJugcqz2mIISJ6jTGo5oksQWjRbE9/Gp12VP1nvVm
 /zTjjUygWlJ6ZNNlOs2fT0BPgRqQA4G8Sa7qV2MRmaiZiVqmfQS6nQzyWbM03/vc
 3EQvG27k15piB4TQGxNO/Q8VtMIulszXJG84cr9ertSMHQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drnu2ruuu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 12:17:39 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50edf0245b0so1315281cf.1
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 05:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777119458; x=1777724258;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=npr90gwsT5NmHlfS0yD/bLI36eTJwhU1xjIXKSB/J18=;
 b=Q6Q8qywEOLu7ERRv32brjPMDOB5nc49Em9nQnMs8gq9A45nu5xlOcJJ0lOUc0J+/4u
 yQF7S5UfXqOt6Q9slPtvhqDxY4544CvWE1KrHgfppxG6J4wWwg8HIupk1mW1fGg8dBvc
 yuvpc9erCM0hJVouVKiR2ShTpHzC9q/9qh0tnVnGYdHWJBj5XL9NRjWI4XIrELZlYN4B
 ZkcMxT7um8EGR4TiS01jFwOsEdVHo9y+wfwtssnmc0AdR1Hi0JG+Xu/rqyrSPW5SEcvl
 azMc9HKzXgnwNj+lHXu2EZltToYfKq7ZMejiey0QGMWTwJ3EjjYLISu6umvLqEjeNf9G
 0jyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777119458; x=1777724258;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=npr90gwsT5NmHlfS0yD/bLI36eTJwhU1xjIXKSB/J18=;
 b=dtGUYVm4oQOQgX7TputViUWHRuCbK2m7hkfW5gqjlFP7ILgUhOTBo+/4E6dxnaiCeF
 2PZ4Bl/I56vKURQl+lCSl3vTWkfcTytRM2yEvE4tvXLnvX24fwnS1UR8PdHst4WkFU7R
 ZOP8a0EAPHfn8QCl+E6+lW334sPG3oUZte9faLu4qqTs+vS9D9fG8AOr+kvee27pj327
 46nhBh0p+XE7RVThZ4M6JwCiR1KSVEwbiZtnA3ibtGGaeQ7ZRWhB9zAjJr+joD288rz1
 ZNh1nUigBB5Fhif41d4WRdt3iK45WerAtrGlB7GyXudR2nrxg+843YdrB4QTC5Vy7mgI
 WaIg==
X-Gm-Message-State: AOJu0Yy7VPUvFrm+wlSij/9xeB3y2Z4tsqQrXMSFw5PKHE/wLY4BsE8L
 5aTWMZiIXPc98A2Z9lthXdS8lMbpnUwgQAyjqqJwvpQ3xkDSpNo4UOUoB4eBphh+ex9Zth6m452
 kmIcjOTdJk9mqOFqzsCTwcxskl/ij7Om0Ga9IUSobTdY0gb4SDa7CeprBHd3gW2oZOULR6HA=
X-Gm-Gg: AeBDietO1dJca5dxXuRS41lWxxVw2UQHE0xxdYCe4C2fdsFeM6VUIKIQyaLShOOJBpt
 kYUJZgKGy0Ogt6X5GUwHhRqVtbAnNA7/4RIJaFS5biUFjY0374bhc1hCUNxL6bT+mpxDLT8fnXv
 2fCUnVuGCDlB1KrkEctFTL4SmhTy29+aSALOtQhCVqcWot8jB0cbTNh5FwOLsmUL+Ssl5nvC7l/
 mB9sAPWVgrX7XuaD1r91PP5R9yNMS0A8LTYnhxswMweFtwjoy0GEjj/69JukVOqabv/9oofsVOC
 Awy4rLUWvAIAghkRKVkHjmCBZyLcJ1RaF0W3EWezIMgZOM+j44uS9v79q599E2zBFGevabWsphA
 3vjBjgFGkqyKsksaKf2EOrGmKNvp0C7f9ndLCrCQtGL1FCocrKYJ0Ran6HYmVUSum+7EZdEgm36
 Mwp2XIhmO63FRCt7MI+oM/4xm1Qbm/pmu4KRKBW/zR14iKhQ==
X-Received: by 2002:a05:622a:2509:b0:50e:defb:9dd8 with SMTP id
 d75a77b69052e-50edefba3b8mr340804751cf.6.1777119458474; 
 Sat, 25 Apr 2026 05:17:38 -0700 (PDT)
X-Received: by 2002:a05:622a:2509:b0:50e:defb:9dd8 with SMTP id
 d75a77b69052e-50edefba3b8mr340804061cf.6.1777119457678; 
 Sat, 25 Apr 2026 05:17:37 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a63296adb0sm2218995e87.6.2026.04.25.05.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 05:17:36 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:17:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v3 4/8] DRM: Add support for client and driver indicating
 support for luminance
Message-ID: <5trcw3bcadvk2ltmat5axlezuznylsgm5xr7dmo66o5ijcrpdz@fhv7yhmlklub>
References: <20260424220953.167058-1-mario.limonciello@amd.com>
 <20260424220953.167058-5-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424220953.167058-5-mario.limonciello@amd.com>
X-Proofpoint-GUID: KRGLzrpJYNZTYUlmT3IrrQ3kwn6a597S
X-Authority-Analysis: v=2.4 cv=cbriaHDM c=1 sm=1 tr=0 ts=69ecb0e3 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=ws1xHSm7LW_IKOyM:21 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=zd2uoN0lAAAA:8 a=sgUbT2v92nCVnnKm-eoA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: KRGLzrpJYNZTYUlmT3IrrQ3kwn6a597S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI1MDEyNCBTYWx0ZWRfX9E5Xmbo/YweL
 NhZr4qR0QQW1zc01TSNL4u6iQd6r4UbKex9TD6nrtK191OcWY1BCCAY5IpqDsbLXrgJt7UL/3GQ
 cI1PRXIOP4uKzpGVaujNXCcm7VtW5FIsckKRuxATKwURZk4VAjrbrpQm5dJCYY+vv7sjOsyNrmC
 9r9OMbIn+xKvWWvpNbP/lIFx7LZuLqc3npYi/EqaPfpL29iOMxvyPxUAYuE7OPFfR1iiD3A5MOv
 mtbeNV96Ss+qBu7gfQZeomGlJRvAE/M24UTwsBtqBRmdmGsLT2FDZ0nVe3gZl8fNAy6bLqZWSSg
 hnmlvJMU09xUgOWrdQNyNkNUUUWPnB+NcmMjYmSsjaFOI1D1X+xSHgJX/g6ygRpvqv0szBk/ydc
 ndtvSeyt6LzFqOfr/Oop+AQAmqaDcljMmsGt0GHHF9/qy9bnJZuCeeeO1P7Yd9qN9y+THw76tdp
 GfOqrSoXurqYxkuGoCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-25_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604250124
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

On Fri, Apr 24, 2026 at 05:09:49PM -0500, Mario Limonciello wrote:
> The legacy backlight control interface can only be disabled when both
> the client and driver have agreed that the luminance can be set during
> a modeset. Add capability for the client to register and for the driver
> to indicate support.

Please describe, why do we need DRM_CLIENT_CAP_LUMINANCE.

> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/drm_atomic_uapi.c | 24 ++++++++++++++++++++++++
>  drivers/gpu/drm/drm_connector.c   |  4 ++--
>  drivers/gpu/drm/drm_ioctl.c       | 10 ++++++++++
>  include/drm/drm_connector.h       |  5 +++++
>  include/drm/drm_drv.h             |  7 +++++++
>  include/drm/drm_file.h            |  8 ++++++++
>  include/uapi/drm/drm.h            | 10 ++++++++++
>  7 files changed, 66 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
> index 27cc159c1d275..b5e6d940f2816 100644
> --- a/include/uapi/drm/drm.h
> +++ b/include/uapi/drm/drm.h
> @@ -921,6 +921,16 @@ struct drm_get_cap {
>   */
>  #define DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE	7
>  
> +/**
> + * DRM_CLIENT_CAP_LUMINANCE
> + *
> + * If set to 1, legacy sysfs interface for controlling backlight brightness will
> + * be disabled.  The client will include luminance values as part of the modeset.

I don't think this is accurate (anymore?). The sysfs doesn't seem to be
disabled. Rather the DRM updates it internally. Which might mean that we
don't need an extra client cap.

> +
> + * This capability is supported starting in kernel 7.2
> + */
> +#define DRM_CLIENT_CAP_LUMINANCE		8
> +
>  /* DRM_IOCTL_SET_CLIENT_CAP ioctl argument type */
>  struct drm_set_client_cap {
>  	__u64 capability;
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
