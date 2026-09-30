Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A2DCA5FC4
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 18:05:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8698F10E5E3;
	Wed, 30 Sep 2026 18:05:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="B7bPf8VI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EZE7jB+s";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D957910E5E3
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 18:05:24 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UHebJ71198524
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 18:05:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=H/daFQ4eGR9SxKZQYumOcM+1
 gprzJRcbFZIEUlbLCvc=; b=B7bPf8VIh6J9xRP5uLUOI75qqF2EOAv4pW9rfGx9
 8tCB1+HRZ63xQibjgL5DFNnwzQZVcS9gzIPbVKuLzU/d6WZsse2PILQnKLncI4Y8
 st8SbJBSIzUq0018f6ZaihIl5k0zH0xHdZI9Rbx4OoZh0dNo0ZKMgpab8OoQnJT/
 Abdh9MEd1gFcZL39cU+EGutWi1AYZ9qRSjD4n4Djd9j0jvZds7FzHXiud0enqfA+
 gqMnROPHsfE3HJPng7RDkMUbNMfpJ86GtlTJjprFRFoB4HoQ7x7fo6Z0H1pm6AWC
 rdfL/WEn5Sdbm3NEfOrehFAEnpeb2vfqr0ITL5J/1zfJIw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h136tham7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 18:05:24 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-97c7e1d8bbeso476065241.1
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 11:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790791523; x=1791396323;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=H/daFQ4eGR9SxKZQYumOcM+1gprzJRcbFZIEUlbLCvc=;
 b=EZE7jB+slX3CVvcMsZxWrfhwcSjDwJ0L685yN04KWkHhJd14Y8JUluG4FyF9yYPu9Q
 cFRJJfls+EqLNcDqT8TKXKN0nREzgJBWVA9JfB+Zcro02mDoMkR0KDJPeOfZyWOcZS26
 wUbTGHHqeoEsasKOYxuIPCFBIh0/dEy3yQBOFyLyB/VRFmxbsoiUiZ7+ViYKyJViT4SB
 sBUZw8Abs446YvB/IZUAWpf3VyFKj0C1G7/1UVsufXBAar3yNNnMjwmFhsNE6ISk9dsh
 N7TiqdDjweFYr8QD0Q83AOIr0UwpYCBIweOc6y5FTwfXFPHnWaku/HrqQaJaYZSPkg+b
 HT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790791523; x=1791396323;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H/daFQ4eGR9SxKZQYumOcM+1gprzJRcbFZIEUlbLCvc=;
 b=AhQH66ye68I4/pkdvf3MrQHDDgw+uApUaueR8I90/DL8E00RrqbSlTjGdgbrqKLI8A
 nuLjNFFA+/Ci3YnzXgHsJKgE9yW0Jf/VIWiv3L2XKG0tDFptKePdGZERyu8AnJmOdzsI
 6wJ1s4SNa42JkT1np8bVmAh28ay0rUrdx45rOAUDGlpkbgW4OBC3XPM74xvSigDi+tJq
 Iu99S1nbgCLigmgpoDvugS5e1On7MFoQNbRdCNN/0wCmMrhbhYLW/wTVxwq8ZyVPaOIX
 n69YiZ548mpg8j/QWVJyTXG5hG5zNGTyjGerLXTYVZpFLkTQ1FOCydXrPV96QAsugg8z
 zYlg==
X-Forwarded-Encrypted: i=1;
 AKwUvByQ4l+Cr9zHZ6cEioZAxWZ370Czq5X8yFgtblIrzov6PVrUDS/BA/dytsL8x8XQeyEazjCQWgv7bcc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLCEvLKOP4oKcOQbGnuPArCMhjR5fgPUko/7k3KhBuxnm3h0XZV
 ywbxDnvuUz/dRAHf4fUgOqHoIP9sijmFvpQ9nFj4bd/rywVxR3NQ39LfLMRBg2ZaY2RxoExUvVQ
 OPcJgXNulg4LD8aPsq6eYTb6zZyU1+j1lS51de/aanKYbtf5xF/pF/xhIbdLfvNeENTgWEzg=
X-Gm-Gg: AYBFou2i2u/EohIsYD1fE7nET6YuOdOX7OplY2WsaEwdQ79xE081sPrOJmEQgjTtB2C
 fzFzcjL5p3LnF9cS7v4rV9uN4EWO0DuxD9Gs1IAzBMALn0pu6HFAC9xyjAqXRG5v86TxENDw9X7
 OOhyCC28Z2OS7VhcFvkkoN8mt5kbBrWU/syvzHka6S4bRqBfaXz9wyxx8P/arf2uTl9Vhj0sBkn
 C4eZzo2zvC4A/iv2EAQFIbE5rtzKehwFBJJBVYRMpCrTtlj0FM8SNB0k+4YKydwtohd9HONREPY
 1PhxMouAqlJmKTk9nO+s7k2cP6QZczk7EARlZ8XlkoATePvLnx9xT1Zr+ONLAZ26vxHuhyPzYcW
 PONZ/SeUa0lTF1ihijkcVE2DNqAvHggqhjTa1yC9RI2Osda3EDI38jFYY4Xy1LsbSQPrGundZdE
 sYVWmcSA8CPQMG
X-Received: by 2002:a05:6102:2ad0:b0:7b4:eb1d:d1e9 with SMTP id
 ada2fe7eead31-7be61e96e98mr567995137.5.1790791523118; 
 Wed, 30 Sep 2026 11:05:23 -0700 (PDT)
X-Received: by 2002:a05:6102:2ad0:b0:7b4:eb1d:d1e9 with SMTP id
 ada2fe7eead31-7be61e96e98mr567973137.5.1790791522440; 
 Wed, 30 Sep 2026 11:05:22 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a7839d26b0sm426811fa.5.2026.09.30.11.05.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 11:05:21 -0700 (PDT)
Date: Wed, 30 Sep 2026 21:05:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xilin Wu <sophon@radxa.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 09/13] drm/msm/dp: Track output bit depth in bridge
 atomic state
Message-ID: <bwnubezloh6442xm3t6soho4npktvgd52g6bpzcqygghx5gu5b@whfcbf664ps7>
References: <20260930-msm-dp-hdr10-v1-0-dbbf8b2b42bc@radxa.com>
 <20260930-msm-dp-hdr10-v1-9-dbbf8b2b42bc@radxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930-msm-dp-hdr10-v1-9-dbbf8b2b42bc@radxa.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA3MyBTYWx0ZWRfXxCkQvoUXcM17
 XalCrltHeRE/oOQllRBS4YZU3YszFv4FDR9QCRAaGZhg6NZURO7Lf/OqflYSCFzaAtSTjZNQTfi
 Ho9o7Vh/PL4/XBz2dyCFzhajjLY4Gvs=
X-Authority-Analysis: v=2.4 cv=aPFlOr9m c=1 sm=1 tr=0 ts=6abd4f64 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=ksxQWNrZAAAA:8
 a=M2bzw9_zRUdtQjVNecQA:9 a=CjuIK1q_8ugA:10 a=1WsBpfsz9X-RYQiigVTh:22
 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-ORIG-GUID: wtuIxgj2xkxD-ROyIN9tRPFAR1VP-4iT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA3MyBTYWx0ZWRfX9WpzF0j3WMvW
 0GHsJlG4Bhz2TWVlX/aqE9DZVLlLdAkwHl0yGW8FGyOuAb2MVcVIGxv7bCZM2j/1wfaWKDDnel7
 N1rqtzKQm8mhH/VLGlLsR3BbGaFzdax1P4Ep16nnyVJ+gM77UK3e3y/bhLPJm1cBx7ZnnGJ2+Ic
 1uZBLYwn0V1N3Jf6QRGJ7Wl+nsdp3MKLJxqO0epB106SgWG7rVcW9G+zGmapv6SPZ1QWOjtaKcn
 NxnCc6hn9wpqPFEmmTt68ePiykMjp/zmEDwINTXiNoLbaYdPNjxjp+44r3af8Hl1suJ2qpVcl2O
 rlGmeb0DoWeV8sAQ/Wl/Zy1VP6hYNfwQ50dMEdI29+8GObYGr+sY0n6+i0m8DljMASFLUoMC6Vp
 8wegyw1qRhcuR1uB86VbOij1W2dQ1lCK1ElvBgZRqNZqIX4Frftv1M27e5uBlseDqplNkw5A/zU
 A9EtAhBJLmEzc9X1m7A==
X-Proofpoint-GUID: wtuIxgj2xkxD-ROyIN9tRPFAR1VP-4iT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300073
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

On Wed, Sep 30, 2026 at 08:41:53PM +0800, Xilin Wu wrote:
> Expose max bpc on DP and eDP and select a supported component depth from
> the new connector state. Keep the result in a private bridge state so
> TEST_ONLY atomic commits do not modify the running stream. Force a modeset
> when max bpc changes to apply the new depth to the stream.
> 
> Read cached capabilities under the plugged lock and defer the bandwidth
> check if they are not yet valid. Recheck the selected depth against the
> trained link before enabling video, including the reduced pixel rate of
> YUV420. Retain support for 6 bpc SDR panels.
> 
> Retain the generic bridge helper's missing-state guard in the custom
> duplicate callback. Initial state allocation can fail at bridge attach;
> return NULL in that case so atomic state acquisition reports -ENOMEM
> instead of copying from a NULL pointer.
> 
> Assisted-by: LLM
> Signed-off-by: Xilin Wu <sophon@radxa.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 15 +++++++
>  drivers/gpu/drm/msm/dp/dp_display.c | 39 ++++++++++++++++--
>  drivers/gpu/drm/msm/dp/dp_display.h |  6 +++
>  drivers/gpu/drm/msm/dp/dp_drm.c     | 81 +++++++++++++++++++++++++++++++++----
>  drivers/gpu/drm/msm/dp/dp_drm.h     |  7 ++++
>  drivers/gpu/drm/msm/dp/dp_panel.c   |  5 ---
>  drivers/gpu/drm/msm/dp/dp_utils.c   | 20 +++++++++
>  drivers/gpu/drm/msm/dp/dp_utils.h   |  4 ++
>  8 files changed, 162 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index 16c9165b5f31..f41924e75854 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -23,6 +23,7 @@
>  
>  #include "dp_reg.h"
>  #include "dp_ctrl.h"
> +#include "dp_utils.h"
>  #include "dp_link.h"
>  
>  #define POLLING_SLEEP_US			1000
> @@ -2620,6 +2621,20 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
>  
>  	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
>  
> +	/* Link training may have reduced the available bandwidth. */
> +	if (!panel->video_test) {
> +		u32 clock = panel->msm_dp_mode.drm_mode.clock;
> +
> +		if (panel->msm_dp_mode.out_fmt_is_yuv_420)
> +			clock /= 2;
> +		ret = msm_dp_utils_select_bpp(panel->msm_dp_mode.bpp / 3, 10,
> +					      clock, ctrl->link->link_params.rate,
> +					      ctrl->link->link_params.num_lanes);

This doesn't feel correct. Yes, we can lower num_lanes (or rate), but
then it would mean that the caps that we checked in atomic_check() might
no longer match the actual hardware. How do other DP drivers handle the
case? We have a "golden standard" of i915, amdgpu and nouveau, which we
probably should refer to and follow.

> +		if (ret < 0)
> +			return ret;
> +		panel->msm_dp_mode.bpp = ret;
> +	}
> +
>  	pixel_rate_orig = panel->msm_dp_mode.drm_mode.clock;
>  	pixel_rate = pixel_rate_orig;
>  

-- 
With best wishes
Dmitry
