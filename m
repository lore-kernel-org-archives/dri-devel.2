Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1E6C88E63
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 21:23:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58F6710EA33;
	Sun, 13 Sep 2026 21:23:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TLTv41Jo";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jWGnsYf8";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F29F10EA28
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 21:23:50 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68DJxYoN2631351
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 21:23:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=nan6vW69SNnTd1biCzCJThnP
 a0herBJ+hscih9u1lQg=; b=TLTv41JoK/Z4UhBpy7AOa1L/WQFXSqKMhutIlbFu
 V7pCdgXAu5yzrOrJfpwB/7dqSEmRz4BIJBusXtD+FaBEgj8XEkH8W0fc9m5AAIil
 xmzRTasENQiqk4s2pQA+b0ny5ol8exT7/9Ool5sUM1Ad1FxADHaHzY8jUJD4Wuy4
 b9BQtmeJKVm+DHzYsyHc2apliJEy8gRL4MMrMl8+ZP2goo6f+CwQnH+u0RJMunmh
 lx92zpgly5Wd22278ZsKFUb7YgoytFPAvLSnP/0EKd4XHBYgE1iwuXZRsqqQum+3
 obiBRC6M8dz7kCtU7xspmnAZG2Eu98iSB6m1bGZEv4EF7Q==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9c4636-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 21:23:49 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-9806535f8ffso3065409241.1
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 14:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789334628; x=1789939428;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nan6vW69SNnTd1biCzCJThnPa0herBJ+hscih9u1lQg=;
 b=jWGnsYf8Mqo6/TSKMi6L/WjK7WiJNek6Jq/8d1I/89GvI1CGf6MJFhEuXO8ltBxdOZ
 greM0BQu5MkG6hOaUi2ues+eZ+fNB6/8Gn6tSLQzNEj6sSu3oKb6NBXxqpyakPXxT1qS
 Myqyqd7C5tfkrhM85/M5UcxTtX/7ZD5UnTLXtDJknivxs+oX+GFITTZlC1yECH3pzXWO
 GwMrKcC6U0pnZhcXju+VRoN6mteK9HYEllOopOcpwwhPVnkQairfpJKe3+0cVWrU9/+3
 YpbHz0/Y1MyWXg6cZtk2IXqhbg/6tzhMzNGass0b2W7QAfUNMFaZmuT6Ee2+mi/0EzUF
 jEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789334628; x=1789939428;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nan6vW69SNnTd1biCzCJThnPa0herBJ+hscih9u1lQg=;
 b=iJ7VldKol9hse4j8yPueFFPSTnACenRgSfN4JnP6KHYR03K8wjQUZwHFmHbPtpPvvU
 AkEc9ONbS7zyVAB9/HCSgmze6eb65Dy3zUluUJqBaojJV3NY4cuMAzTaKgI583sdeOcj
 M01Tm275ex/B6tHtKgFPrv1r4JvKwVAxOBTA/duwPG2ctETLSzAP7VPsPeN/ITv4mz4o
 qx18KGwy9rYXwLqa/leX7lwzuJfFfiJ93kcY7LWMTvrdms+bA2ATCHpZ6mxS2wXjK3lt
 1yViC1JW0Bsp6ZUMsHAXvzBmqvB1NylUTJESrtVaYo2DKocwRtqdbMGY9+JDGnODqLAA
 SjOg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwlIGhznrgTdQ8k8BwF89D0rHQhpEWVBEe50nLSXml6js4g/Wv+pvhCRsqSOb3yNRFsxONcp0/POAg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nO6wt2Dak+S2OTNi3dnen5JF7wBiF1fFTBxzBmie1HMMpxxO/G
 MnD7owgvKn4WHh1jQpwstKYapMlqvO3veAao99dBnogfENsNAuPpQ4/1sJWwx2oaHCZgPn7kEez
 QUcAVPEn9XtlhbvAL6WbFZt64m80Zvy1UlNZoJbgrhY4zWUfjVi9mr/B2Lz3wPNKdoXrENT4=
X-Gm-Gg: AYBFou2lnNJ0FW6TqWABe5YB+Yjy0xNotipzxZlsOYlVwQRXKau5kLdJseGTECDdVPa
 1MbEre9DnWJXBnnBf6Qx38wKTn600p4FsRd4d0zeSDS0r7d9a01kItxM/7b1G5mty82B0mupsLR
 8adLyarU+MQKEFMznL837+B2d+4H/B3naosHvaL7S9+GIqdGOEdh0ok3ubuxbGREBLe7Ls6SIU1
 XE2lCfRViH8LMvB4BC7jHPj18DvRHZP8qipujWzbu4SrAcn8lcWiZsaOTekEmEbi4e7UAjdLeQJ
 PeZ+VRlxaaQxujfsQaV4Yhmr9yNI7cgsv/FOK+s0dflUYDmCThGPbvKr/Thwf7iHbkowl7LeBGs
 OnSgdPsfwYrglOpA3VKiupZ2XYAsqokF+2zDhEAWnEd2qDlfbg6uGSSmfCWOS0XqCgXPgt9OAis
 WWdozeFxb6zFaS
X-Received: by 2002:a05:6102:66c2:b0:785:6b42:b7b0 with SMTP id
 ada2fe7eead31-7988f46e546mr871118137.4.1789334628441; 
 Sun, 13 Sep 2026 14:23:48 -0700 (PDT)
X-Received: by 2002:a05:6102:66c2:b0:785:6b42:b7b0 with SMTP id
 ada2fe7eead31-7988f46e546mr871104137.4.1789334627921; 
 Sun, 13 Sep 2026 14:23:47 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a0456f70sm2032965e87.17.2026.09.13.14.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 14:23:46 -0700 (PDT)
Date: Mon, 14 Sep 2026 00:23:44 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: William Bright <william.bright@imd-tec.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dp: fix link bandwidth check when wide bus is
 enabled
Message-ID: <cixxkgc25p36wchfusuucqsauaahd5w7xfvdoqrfmoghenvgmw@ukirdl7l3nqj>
References: <20260812-msm-dp-link-bw-v1-1-b0e3ce1190be@imd-tec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812-msm-dp-link-bw-v1-1-b0e3ce1190be@imd-tec.com>
X-Proofpoint-ORIG-GUID: EfSEIvBaEex21o8h9E3FZmNSdi63W-yC
X-Proofpoint-GUID: EfSEIvBaEex21o8h9E3FZmNSdi63W-yC
X-Authority-Analysis: v=2.4 cv=c5Y+0h9l c=1 sm=1 tr=0 ts=6aa71465 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=gNcS5RXMAAAA:8
 a=EUspDBNiAAAA:8 a=v9oLtqcirEpa13wbMwwA:9 a=CjuIK1q_8ugA:10
 a=TOPH6uDL9cOC6tEoww4z:22 a=VeqYHxXNbGx7SVBbL1V1:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDMwNCBTYWx0ZWRfX2s28WknRlJ2E
 UB6EvexcDrJBTE7+JU2+siCZwPNs3K5pb7VlupdCHKxjHtrfGco8sCxDNbrRMhYHEkowXpGC6ra
 UdwVjPG0D2Epu6b0vGYfM1rHl6XRYBWaoeUfgMRcRn9euZRsYrMeQ3PcA+SPIUCAv5NXHE+qF/I
 AR+9TpJC6yFsVPbmvYN144CvMPiokbm5quEDY/8oKQm9yfu5GLgUGEu61zdTnXGW6hkV1yc/U/n
 7vH8JabNH5bKpXyXLodJLEFqlHi3R4mmZUDuZ80DyZFMJ/F0DCEe4ecViypjDIFrb2bJZIZZ16K
 KuGjLM71QBcmclpPnXkUNJ17pXBTspf+XjnwQmKM9GfEMJQcgL3jkKLjlc9PkLeyMJwrgKsc/TC
 R5mdEqcfh5BfYAO+1JwBX7OpXmsGdmi/gqxZZNdYQMaCoNsc3TdJvdEN3toR0GYDxaw3Elt/q9B
 XYg/umd/tS7oqBWhSKw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDMwNCBTYWx0ZWRfX23oyIPo5vKqI
 K3ip65Ku2IXawLGztQiA7PhRcwSu23gMVQq++CCB8ElaNPBT+FNaBCwSpcCSHF+SzzlWZHpXTZM
 s0wKlB8+EPSs68blDSIZY9qmC9DGhI8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_07,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130304
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

On Wed, Aug 12, 2026 at 11:05:52AM +0100, William Bright wrote:
> msm_dp_display_mode_valid() halves the pixel clock when either YUV420 or
> wide bus is in use, then uses that halved value both for the controller
> pixel clock limit and for the DP link bandwidth check.
> 
> Only YUV420 halves the data crossing the link. Wide bus widens the
> internal DPU to DP interface to two pixels per clock, halving the
> controller clock. Every pixel is still transmitted, so the link
> bandwidth requirement remains.
> 
> As a result, modes needing up to twice the available link bandwidth pass
> validation. On the IMDT QCS8550 SBC (rev5 with CYPD6125), where DP runs
> over USB-C alt mode where only two lanes are available, 3840x2160@60 was
> accepted despite needing 9.6 Gbps against the 8.64 Gbps the link can
> carry.
> 
> Use a separate link pixel clock that is only halved for YUV420 for the
> bandwidth calculation, leaving the wide bus halving to apply solely to
> the controller pixel clock limit. With this, 4k@60 is correctly rejected
> and 4k@30 selected instead.
> 
> Fixes: df9cf852ca30 ("drm/msm/dp: account for widebus and yuv420 during mode validation")
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: William Bright <william.bright@imd-tec.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index bc646d172abe..b2d6cb82a146 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -756,6 +756,7 @@ enum drm_mode_status msm_dp_display_mode_valid(struct msm_dp *dp,
>  	struct msm_dp_link_info *link_info;
>  	u32 mode_rate_khz = 0, supported_rate_khz = 0, mode_bpp = 0;
>  	int mode_pclk_khz = mode->clock;
> +	int link_pclk_khz;
>  	bool is_yuv_420;
>  
>  	if (!dp || !mode_pclk_khz || !dp->connector) {
> @@ -775,6 +776,13 @@ enum drm_mode_status msm_dp_display_mode_valid(struct msm_dp *dp,
>  	if (is_yuv_420 && !msm_dp_display->panel->vsc_sdp_supported)
>  		return MODE_NO_420;
>  
> +	/*
> +	 * Only YUV 420 actually halves the link bandwidth, as wide bus only
> +	 * halves the pixel clock within the SoC, while the link bandwidth
> +	 * requirement remains the same.
> +	 */

When using Claude coding agents please ask them to trim the comments,
which are better suitable for the commit messages. This one is
completely redundant as it duplicates the code and adds no extra
information. I'll drop it while applying.

Otherwise LGTM


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



> +	link_pclk_khz = is_yuv_420 ? mode_pclk_khz / 2 : mode_pclk_khz;
> +
>  	if (is_yuv_420 || msm_dp_display->wide_bus_supported)
>  		mode_pclk_khz /= 2;
>  
> @@ -786,9 +794,9 @@ enum drm_mode_status msm_dp_display_mode_valid(struct msm_dp *dp,
>  		mode_bpp = default_bpp;
>  
>  	mode_bpp = msm_dp_panel_get_mode_bpp(msm_dp_display->panel,
> -			mode_bpp, mode_pclk_khz);
> +			mode_bpp, link_pclk_khz);
>  
> -	mode_rate_khz = mode_pclk_khz * mode_bpp;
> +	mode_rate_khz = link_pclk_khz * mode_bpp;
>  	supported_rate_khz = link_info->num_lanes * link_info->rate * 8;
>  
>  	if (mode_rate_khz > supported_rate_khz)
> 
> ---
> base-commit: 140b13475302601368c0cf4e193e66126a49feb3
> change-id: 20260812-msm-dp-link-bw-99255c870bc4
> 
> Best regards,
> --  
> William Bright <william.bright@imd-tec.com>
> 

-- 
With best wishes
Dmitry
