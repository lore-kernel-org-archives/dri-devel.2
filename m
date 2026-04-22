Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 830CFF94CB8
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 00:07:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB8DB10E24A;
	Wed, 22 Apr 2026 00:07:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pscRoS5m";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z6LeHJsH";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D00BF10E24A
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 00:07:39 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63LIaAh63083117
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 00:07:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ClrHDpExnXUz9Tj4jHcXswWQ
 +f763M3nUQfd5faWuqE=; b=pscRoS5mKpok6mcdKxFDeFGFQdk/7/KBcnirCvBc
 0SI5ta2M3YPfQjtIbqyX8AcvR1H1HeSSu/VAJhy7+NKNQUFeGcP2npWDwioh8JrZ
 d0VMEjosCRXKREY/qm+3FEM2CtqzAvA+Svd9y1cIby/R7p3LP44UhtSszwNjNV2o
 yvsgtjKWTuUbqDZQTcb4vmk4VRXAGsztigOhT9d8HZFD4qaKFwprAN3TTivndgz4
 RUc1bsuPpxoviqewkH3mE050ygprVefIYhe6zvQezi6GFWWeDJz31l784pRG7jWP
 dohMTey3FfxAIKBjpuLrmNFrf9+TedrxUWoh4AryhG44/g==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenmgvh5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 00:07:39 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-60ff08dfb37so2502463137.3
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 17:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776816458; x=1777421258;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ClrHDpExnXUz9Tj4jHcXswWQ+f763M3nUQfd5faWuqE=;
 b=Z6LeHJsH+1Ii/36flCrp9bs8Do5dWGZm39ZpK/65fO9PMtJjws/1x9Vwv9K3Evx5/U
 Dfns0eLNhIXK+zBMBS66V/U0e0BIlNZPCzjV+KybGEf/dNGSMXPC4k0v7kZMnMxBc3Mj
 OgE725PPP9X8Ti8V9vvzIqLC9l+lc9LnFtOCnNG8YJ98kUL2rls6RuZkSkOEld0HjdEA
 dF5408QI9X9JGbCAFOXvsy6h6Kec3vF/dDAM6bpj8U7xveU0hBde5uc0uX57LPXLIlXk
 Kkk3ylpTB4vcoTdn4IPdVlIBc6Ns88xgIviaeMX877vz4KPfx18S4foo2LNuWnQh8UQf
 FrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776816458; x=1777421258;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ClrHDpExnXUz9Tj4jHcXswWQ+f763M3nUQfd5faWuqE=;
 b=jOu1eY7J/sHRK/KPVPvA6pnuTycuWqE9k/orNFcwoKWC5ivpSdlgZXSIipe93Qs7w5
 WYOsIwRh1cIXO8KwtXvQeAKCMqDLUM8lrYbrjXdCQ86rZqLIeGN/Wgtc5vB1xHAnE9Ie
 BD7uhLLfvS7wxlYTudH5niCKJaPjaGXiZZt318sMEZh3NmGQSpmFMZs22kk77gfrtGou
 Wut1bZszSaAjBw8jv0DAX2WEU7RkRXXEtyx1R+MsEXpeUEVwy6SUNkWlBjwpcnD5dHTu
 eecm1NMVFd/ko1ZPsJVirCQwDcuMxLdxDzX4qcoCqda6Vvt7MXIv1tzrNpCoF5LTMOyv
 XAHw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9wQqYZrYdqOUBLEuky5QH50RQcAWvURj4j6sILv/MOLvUN9U6eAnFs0QP0EUOFC8p68z5FaSseylg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwP0i3QIC2h0GuvGlpZqBYiqjSOdZEVXqbkpLC3m85FXe8SRfAl
 66b2CVtm/37pdnK7C2CjHo6g0WitjTyfPn9ZJpnETMxYlK8PoDKXOuG5evNY8zZJYJOPOnhvxwg
 TfvhQgzDQWS1kPapUuoRg9EBWPX5hXWoS1dujOANesa+uaFi85adopTfXg7UyOMJsgCfwGSo=
X-Gm-Gg: AeBDievkn0T9L0t6rUJck0GmDEOBQ8n8U93gRs8wykEUOI+xnCiW6UjoUzxZcHBFO1C
 IRBIAVttttyPd9CxXAjadhu4OPd2GnzhN9qAexw0CKzQVPLhejTL5vRP2IllRvFAPvkj/UG8t6Y
 I1IAGxXLmPoBeQktdUbx121cpzEkQR+pY1eRrBZD6iHNNwO/TSOxHFYFRSLLNiLrkZ1uS/Trmrf
 bb/1v951KIwMH4dPvA3iUuAOrk1C2TKTOM1b1UyiEf32MZEus4vkkjAj0miWdU1kWPBy9CEo8Dj
 zNA2hMDTGPon8ehxAUCjYQDntGq91cKK7vDsOHa0G12FdZJ2qd5uwbfcH7Rt3+6z81v2uiVb7TS
 g9DZw05YpVD7oFc27XCQwe21aFkLOHaF3NSU+gLTPAUwv25BzKd/aC9GYSoPhRiyt9Z8ELew2Yg
 v8ajM1aBrbtOMK3aDB16OwRrU1+biUiswms6zmhYPO5TN9MQ==
X-Received: by 2002:a05:6102:6c9:b0:607:f24a:1bef with SMTP id
 ada2fe7eead31-616f60b3913mr8703375137.13.1776816458215; 
 Tue, 21 Apr 2026 17:07:38 -0700 (PDT)
X-Received: by 2002:a05:6102:6c9:b0:607:f24a:1bef with SMTP id
 ada2fe7eead31-616f60b3913mr8703358137.13.1776816457732; 
 Tue, 21 Apr 2026 17:07:37 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38ecb713becsm35930181fa.28.2026.04.21.17.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 17:07:35 -0700 (PDT)
Date: Wed, 22 Apr 2026 03:07:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 4/6] drm/msm: fbdev: Calculate buffer geometry with
 format helpers
Message-ID: <kywf5seogl4dmh6msqcmfyxdxyg7i5y2jyr2z6fcbu7qrpemhy@nemrwv3lyg7i>
References: <20260421125733.209568-1-tzimmermann@suse.de>
 <20260421125733.209568-5-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421125733.209568-5-tzimmermann@suse.de>
X-Proofpoint-GUID: D9Vgn8pZelKa9A-ZmgToVpW-F6ZaDCGt
X-Proofpoint-ORIG-GUID: D9Vgn8pZelKa9A-ZmgToVpW-F6ZaDCGt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDIzOSBTYWx0ZWRfX19D3k+QwTg9h
 Vl+kX3al/7PKNIIB3GkjwA3PtQLw+uT0Oo+d6EPhyUIIbPpvMqmUVGItxMOXR+pJNy+qXQ36NNj
 vdYjyexQUIv7hRaxbgWU+D8+3khxflNgMEkCD8IW6Y+2Vx4KiSx2PlNJwsY7SjrBtCfoK5iGmjO
 5O/t8gv4V/NjmzTwa+dGwb+PkbAu4+DXqxEHbykl1m7T/vltXXesfBNSCqU0QTnt9D727V8BIuq
 DPdR38I8NJriv4X6Pvlop3ayY0/60bI9o57ErSw24NXx5xVck/jCoFSetcKZQne+JD1/GctBqZ+
 SStkuxr8oOXLqeMsFqpT4AfmRAcTXz5Y2r2E0QKciYFzi8s1znvlWpKAq20OFu6VhmRauVSktwy
 vBOP0e27PfEJxdB56Nixw5sKNLh52chvDkNsKrX0vp0pHzYvzfGVFWwbZmuHX1EQbB7qDPEYf9i
 U2GSfe887bRw6oDVuAA==
X-Authority-Analysis: v=2.4 cv=Xd65Co55 c=1 sm=1 tr=0 ts=69e8114b cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=X6xMinCX8PrUbKJZ2cQA:9
 a=CjuIK1q_8ugA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604210239
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

On Tue, Apr 21, 2026 at 02:51:17PM +0200, Thomas Zimmermann wrote:
> Replace the geometry and size calculation in msm's fbdev emulation
> with DRM format helpers. This consists of a 4CC lookup from the fbdev
> parameters, format lookup, pitch calculation and size calculation.
> Then allocate the GEM buffer object for the framebuffer memory from
> the calculated size.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/msm/msm_drv.h   |  7 -------
>  drivers/gpu/drm/msm/msm_fbdev.c | 26 ++++++++++++--------------
>  2 files changed, 12 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> index b3173fa4d222..00c50d7437d6 100644
> --- a/drivers/gpu/drm/msm/msm_drv.h
> +++ b/drivers/gpu/drm/msm/msm_drv.h
> @@ -509,13 +509,6 @@ void msm_hrtimer_work_init(struct msm_hrtimer_work *work,
>  #define DBG(fmt, ...) DRM_DEBUG_DRIVER(fmt"\n", ##__VA_ARGS__)
>  #define VERB(fmt, ...) if (0) DRM_DEBUG_DRIVER(fmt"\n", ##__VA_ARGS__)
>  
> -static inline int align_pitch(int width, int bpp)
> -{
> -	int bytespp = (bpp + 7) / 8;
> -	/* adreno needs pitch aligned to 32 pixels: */
> -	return bytespp * ALIGN(width, 32);
> -}
> -
>  /* for the generated headers: */
>  #define INVALID_IDX(idx) ({BUG(); 0;})
>  #define fui(x)                ({BUG(); 0;})
> diff --git a/drivers/gpu/drm/msm/msm_fbdev.c b/drivers/gpu/drm/msm/msm_fbdev.c
> index 1eb0368a6d07..5532c5779f17 100644
> --- a/drivers/gpu/drm/msm/msm_fbdev.c
> +++ b/drivers/gpu/drm/msm/msm_fbdev.c
> @@ -95,23 +95,25 @@ int msm_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
>  	struct fb_info *fbi = helper->info;
>  	struct drm_mode_fb_cmd2 mode_cmd = { };
>  	struct drm_framebuffer *fb = NULL;
> +	const struct drm_format_info *format;
> +	u32 fourcc, pitch;
> +	u64 size;
>  	struct drm_gem_object *bo;
>  	uint64_t paddr;
> -	uint32_t format;
> -	int ret, pitch;
> -	int size;
> -
> -	format = drm_mode_legacy_fb_format(sizes->surface_bpp, sizes->surface_depth);
> +	int ret;
>  
>  	DBG("create fbdev: %dx%d@%d (%dx%d)", sizes->surface_width,
>  			sizes->surface_height, sizes->surface_bpp,
>  			sizes->fb_width, sizes->fb_height);
>  
> -	pitch = align_pitch(sizes->surface_width, sizes->surface_bpp);
> +	fourcc = drm_mode_legacy_fb_format(sizes->surface_bpp, sizes->surface_depth);
> +	format = drm_get_format_info(dev, fourcc, DRM_FORMAT_MOD_LINEAR);
> +	/* adreno needs pitch aligned to 32 pixels: */
> +	pitch = drm_format_info_min_pitch(format, 0, ALIGN(sizes->surface_width, 32));
> +	size = ALIGN(pitch * sizes->surface_height, PAGE_SIZE);

Hmm, why do we need to align the size to the PAGE_SIZE? I might be
missing a point, but it would be nice to mention it in the commit
message.

Other than that, LGTM.

-- 
With best wishes
Dmitry
