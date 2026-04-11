Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E64F3ED59
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 17:23:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCF1D10EA64;
	Sat, 11 Apr 2026 17:23:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="b/wIHT7i";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EHYvje3k";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 387F210EA64
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 17:23:15 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B4320x2736597
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 17:23:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=u6kPVbXNnQQwRrBlwHiRqi+h
 dgEu8F6PUX4I0bxwbO4=; b=b/wIHT7iOygcOhWXCW+PsQJ2NKRtBEMMntWVzFZQ
 iC9EjZJ4etULvFH0MRQmleUi/ewkr8A7s3Ci2SIqMjQwLvH6SZYCiKZUvrkinU5v
 EMZd1AQz2OSLs3rmjID04WlOxEmVzAsE/VusaFoL8eglaaWCaA9X5UfVkUh3vUsC
 IhQNKpeYJPA7EmAfDt9VKBPiEUJHFSiRQ1ADAs54vxBZ36tKDVyegXVrsUJ2r9/y
 KyIzlWyY7R9jX7B2aOBlp3jssEEJvMXD313pfTH5SMVtMvDexp8Yyvm/J1l55Wzx
 3ZkqfORcuaJ6X1VzLm4fdEcgXwy3OsneKGoBb9Ijef/08Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfexcs42m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 17:23:14 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b781542c1so62468531cf.1
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 10:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775928193; x=1776532993;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=u6kPVbXNnQQwRrBlwHiRqi+hdgEu8F6PUX4I0bxwbO4=;
 b=EHYvje3ke9LLh0J6jzqZ9Jux8HuctD0EzkvpjDMZf7fsPd/84/wK8DQ0UWc9C5tvbE
 e9GDAZ8Yn2adFUPS+OEFAFsTlneqI2U0kwgR/ApXbjs4ncwvNCpPKQBGLaYeaGFS20r7
 7hd/f7gsLhvSBiF1jO5GSb0tiL7HRsSoK5DhvohYHfZ1bX1SUi0BjkmqwiBq8BRl3h+4
 mue+1YmG5IjCzSAgIWeehzdGcL7FlcJq75jxLGhFEl+ufMOMPkOmBmrB2fbfTPdD6OCs
 tv0W64QlF4dkavm+G6bacfrDvFbpHgPYpk84jD0+QJW+ksLo7fZDVka0InpOR/WddWbv
 NqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775928193; x=1776532993;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u6kPVbXNnQQwRrBlwHiRqi+hdgEu8F6PUX4I0bxwbO4=;
 b=jd7RLR389L5By2OdUhFXBN7nv94NQXprpIJNmOgSQW/N8PFrdB/xS+Eil+s/zWOx3E
 jn0HEcrCD6DQX42b4coDRNm90sUthafxeHzKOrnT5K0jFmZ4qzXnRdyWVXsLhPTFVTtY
 d0KMXu3Jeg2Z8g7O4z8A+nkur6wMfGpqZmsKpwCz+UBZaTrOR3utPiXPOu4R+lZ/zViY
 E1d/fTsk6JLePzZvCgDNwal5vms0Q8VYQeuTeme9aO5wR9LiJD2YZjde77Sc7vp0Yi49
 IyoDh/fq9I9EqKImd54L9aDrq25I0FYlEQAj0/9Q/+Ryxb9LBaQ0SKa5wG3jYdL34c/u
 2Wxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUS7drtbvzIzUDPoaI1lCekrjVTHZ6EVSlKmHTw82DHc3XPjLVy31dD9QjJnLudwCyO8m5xSXPweBg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxK6Flj5zrhYdCxqBvgwwLEJ5il85SRdOs1tx3nbNmRd2v0t/Nv
 F5g1d869wi/a3VQGpkLM4Gcoa1c+nRMB/lCMSUrhXWwlfTAyrJFtCYwpkwi61FJXWsGQF7Dbw/k
 fPa7KCNhaOam7vperNSaPYHXNzOt4uAgWZACsoUey+idECSlCNZShV/LsYyZlr7tRRmteZIY=
X-Gm-Gg: AeBDievjexbg5Pq3kWXQFzt2XTfGTmxcKaR928aN8YoymfKN7UF9reAsq40qugzbEeo
 OHvO2a3XviUiRBdfnbJWiLCrO4wMU2mmu9AdtZL7xg65a+E4cIj+8escitK9AfMsPFcTNwyBOYJ
 Xe/MDXgZmNwgIzlmgqhQR+jB72TDgwClIt6gv1L9OuEGz57GE6o9Za9pBDPFzh8Q2OGSPo2UnRG
 oW+5d8eHbry3ekAdQ+SZ5eFaSyHuTOUm4umtF/xZcj/Op/laZDdpgps2HE3il6g4xUj+1nST47Z
 5pu2kfAX6GOob74DjkC4E+rFodvfxCR4NgwZ7V/eWnFCMwUkEQGSrAOlmZaK0fXtxWU4UyhzoBm
 jZRiOy41XBJeUaXAL/B/7Gk7amsHU41anr0zBPTJ6/Q3KYcOwfIZi2gT/B3lW0rp6cMJQMW+9kD
 Vi4KseXaIPhbSPyPBNJuCqbNMCdvaaJaJ7Ht4=
X-Received: by 2002:a05:622a:24c:b0:50b:4c64:4730 with SMTP id
 d75a77b69052e-50dd5abce85mr112321231cf.15.1775928193492; 
 Sat, 11 Apr 2026 10:23:13 -0700 (PDT)
X-Received: by 2002:a05:622a:24c:b0:50b:4c64:4730 with SMTP id
 d75a77b69052e-50dd5abce85mr112320951cf.15.1775928193027; 
 Sat, 11 Apr 2026 10:23:13 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e4957eb1esm13440051fa.35.2026.04.11.10.23.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 10:23:10 -0700 (PDT)
Date: Sat, 11 Apr 2026 20:23:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v4 02/39] drm/msm/dp: drop deprecated .mode_set() and use
 .atomic_enable
Message-ID: <lavty23n26lx6rqsmue3nljvsgrpwiyarkwosmqcqqgogqmybm@pgid7zsnpqk7>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-2-b20518dea8de@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-msm-dp-mst-v4-2-b20518dea8de@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDE1MyBTYWx0ZWRfX+/lVwEWOGTMK
 K21clsJZVrJjGOocaiL4rcs2D6rqDBQegmXC7+uQvXrkn0YiYk0U5bAuJJ88W3U3eVGuXc4Pn6e
 uaPrHzivYIg9/UfR7DM7y/9gyDjWLIXXKqfv4h35b0AoR72TdoE1D3eNvX+XL6DV09/CUOQgslq
 feRPDU/kbX612tIWb0PubJosCMzazzHMvHZk7PiAqQGD7ybMulLXFvCE6NEZinI4mIPCi8vue7O
 QzR43FTl0QXGrwuJbSknPBckuULxNN1kwTldZAwndyqgivtuQidVGlO9nZLgDpIqeLA/UauMp+B
 pkPjBRGccj88RSvNHSWGV9auUUS/enofk+rxW/Bbc6lp9gvXxAnGJ7Mi1A8wmaCkDcUcyfacea9
 oJlxFQ/I5ePFIjcPTtc7aQBHOppfpyzRtBVhMlF9kuO3t4JDjXdXQM/FxS8IHccD9uDkuvg1sZk
 rDenXBp2ozncb9cdcFQ==
X-Proofpoint-GUID: 1I6KSZusqVak4wbw8SJi6R7u4gsK2WTX
X-Authority-Analysis: v=2.4 cv=MqliLWae c=1 sm=1 tr=0 ts=69da8382 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=xvVyhEcr_FJfiUna9c4A:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 1I6KSZusqVak4wbw8SJi6R7u4gsK2WTX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110153
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

On Fri, Apr 10, 2026 at 05:33:37PM +0800, Yongxing Mou wrote:
> The bridge .mode_set() callback is deprecated. Remove it and move all
> mode setup logic to .atomic_enable(), where the adjusted_mode is
> available from the atomic CRTC state.
> 
> Drop msm_dp_mode from msm_dp_display_private and store the mode directly
> in the panel, as it was only used as a temporary cache. Both changes are
> limited to msm_dp_display_set_mode and are kept in a single patch.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 81 ++++++++++++++-----------------------
>  drivers/gpu/drm/msm/dp/dp_drm.c     |  2 -
>  drivers/gpu/drm/msm/dp/dp_drm.h     |  3 --
>  3 files changed, 31 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index e28cc1bbb5b1..e9f0b96c3ebd 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -63,7 +63,6 @@ struct msm_dp_display_private {
>  	struct msm_dp_panel   *panel;
>  	struct msm_dp_ctrl    *ctrl;
>  
> -	struct msm_dp_display_mode msm_dp_mode;
>  	struct msm_dp msm_dp_display;
>  
>  	/* wait for audio signaling */
> @@ -593,16 +592,33 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
>  }
>  
>  static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
> -			       struct msm_dp_display_mode *mode)
> +				   const struct drm_display_mode *adjusted_mode,
> +				   struct msm_dp_panel *msm_dp_panel)
>  {
>  	struct msm_dp_display_private *dp;
> +	u32 bpp;
>  
>  	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>  
> -	drm_mode_copy(&dp->panel->msm_dp_mode.drm_mode, &mode->drm_mode);
> -	dp->panel->msm_dp_mode.bpp = mode->bpp;
> -	dp->panel->msm_dp_mode.out_fmt_is_yuv_420 = mode->out_fmt_is_yuv_420;
> -	msm_dp_panel_init_panel_info(dp->panel);
> +	drm_mode_copy(&msm_dp_panel->msm_dp_mode.drm_mode, adjusted_mode);
> +	if (msm_dp_display_check_video_test(msm_dp_display))
> +		bpp = msm_dp_display_get_test_bpp(msm_dp_display);
> +	else
> +		bpp = msm_dp_panel->connector->display_info.bpc * 3;
> +
> +	msm_dp_panel->msm_dp_mode.bpp = bpp ? bpp : 24; /* Default bpp */
> +	msm_dp_panel->msm_dp_mode.v_active_low =
> +		!!(adjusted_mode->flags & DRM_MODE_FLAG_NVSYNC);
> +	msm_dp_panel->msm_dp_mode.h_active_low =
> +		!!(adjusted_mode->flags & DRM_MODE_FLAG_NHSYNC);
> +	msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420 =
> +		drm_mode_is_420_only(&msm_dp_panel->connector->display_info, adjusted_mode) &&
> +		msm_dp_panel->vsc_sdp_supported;

We need to stop poking into the msm_dp_panel internals. would you mind
changing the code to pass the mode to msm_dp_panel_init_panel_info()? It
can be the next patch in the series.

Nevertheless,

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


> +	msm_dp_panel_init_panel_info(msm_dp_panel);
> +
> +	/* populate wide_bus_support to different layers */
> +	dp->ctrl->wide_bus_en =
> +		msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420 ? false : dp->wide_bus_supported;
>  	return 0;
>  }
>  
> @@ -1305,7 +1321,7 @@ bool msm_dp_wide_bus_available(const struct msm_dp *msm_dp_display)
>  
>  	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>  
> -	if (dp->msm_dp_mode.out_fmt_is_yuv_420)
> +	if (dp->panel->msm_dp_mode.out_fmt_is_yuv_420)
>  		return false;
>  
>  	return dp->wide_bus_supported;
> @@ -1361,15 +1377,19 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
>  {
>  	struct msm_dp_bridge *msm_dp_bridge = to_dp_bridge(drm_bridge);
>  	struct msm_dp *dp = msm_dp_bridge->msm_dp_display;
> +	struct drm_crtc *crtc;
> +	struct drm_crtc_state *crtc_state;
>  	int rc = 0;
>  	struct msm_dp_display_private *msm_dp_display;
>  	bool force_link_train = false;
>  
>  	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
> -	if (!msm_dp_display->msm_dp_mode.drm_mode.clock) {
> -		DRM_ERROR("invalid params\n");
> +
> +	crtc = drm_atomic_get_new_crtc_for_encoder(state,
> +						   drm_bridge->encoder);
> +	if (!crtc)
>  		return;
> -	}
> +	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
>  
>  	if (dp->is_edp)
>  		msm_dp_hpd_plug_handle(msm_dp_display);
> @@ -1382,7 +1402,7 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
>  	if (msm_dp_display->link->sink_count == 0)
>  		return;
>  
> -	rc = msm_dp_display_set_mode(dp, &msm_dp_display->msm_dp_mode);
> +	rc = msm_dp_display_set_mode(dp, &crtc_state->adjusted_mode, msm_dp_display->panel);
>  	if (rc) {
>  		DRM_ERROR("Failed to perform a mode set, rc=%d\n", rc);
>  		return;
> @@ -1440,45 +1460,6 @@ void msm_dp_bridge_atomic_post_disable(struct drm_bridge *drm_bridge,
>  	pm_runtime_put_sync(&dp->pdev->dev);
>  }
>  
> -void msm_dp_bridge_mode_set(struct drm_bridge *drm_bridge,
> -			const struct drm_display_mode *mode,
> -			const struct drm_display_mode *adjusted_mode)
> -{
> -	struct msm_dp_bridge *msm_dp_bridge = to_dp_bridge(drm_bridge);
> -	struct msm_dp *dp = msm_dp_bridge->msm_dp_display;
> -	struct msm_dp_display_private *msm_dp_display;
> -	struct msm_dp_panel *msm_dp_panel;
> -
> -	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
> -	msm_dp_panel = msm_dp_display->panel;
> -
> -	memset(&msm_dp_display->msm_dp_mode, 0x0, sizeof(struct msm_dp_display_mode));
> -
> -	if (msm_dp_display_check_video_test(dp))
> -		msm_dp_display->msm_dp_mode.bpp = msm_dp_display_get_test_bpp(dp);
> -	else /* Default num_components per pixel = 3 */
> -		msm_dp_display->msm_dp_mode.bpp = dp->connector->display_info.bpc * 3;
> -
> -	if (!msm_dp_display->msm_dp_mode.bpp)
> -		msm_dp_display->msm_dp_mode.bpp = 24; /* Default bpp */
> -
> -	drm_mode_copy(&msm_dp_display->msm_dp_mode.drm_mode, adjusted_mode);
> -
> -	msm_dp_display->msm_dp_mode.v_active_low =
> -		!!(msm_dp_display->msm_dp_mode.drm_mode.flags & DRM_MODE_FLAG_NVSYNC);
> -
> -	msm_dp_display->msm_dp_mode.h_active_low =
> -		!!(msm_dp_display->msm_dp_mode.drm_mode.flags & DRM_MODE_FLAG_NHSYNC);
> -
> -	msm_dp_display->msm_dp_mode.out_fmt_is_yuv_420 =
> -		drm_mode_is_420_only(&dp->connector->display_info, adjusted_mode) &&
> -		msm_dp_panel->vsc_sdp_supported;
> -
> -	/* populate wide_bus_support to different layers */
> -	msm_dp_display->ctrl->wide_bus_en =
> -		msm_dp_display->msm_dp_mode.out_fmt_is_yuv_420 ? false : msm_dp_display->wide_bus_supported;
> -}
> -
>  void msm_dp_bridge_hpd_enable(struct drm_bridge *bridge)
>  {
>  	struct msm_dp_bridge *msm_dp_bridge = to_dp_bridge(bridge);
> diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
> index 8dc0dabd275c..af3d3e3a2d84 100644
> --- a/drivers/gpu/drm/msm/dp/dp_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_drm.c
> @@ -56,7 +56,6 @@ static const struct drm_bridge_funcs msm_dp_bridge_ops = {
>  	.atomic_enable          = msm_dp_bridge_atomic_enable,
>  	.atomic_disable         = msm_dp_bridge_atomic_disable,
>  	.atomic_post_disable    = msm_dp_bridge_atomic_post_disable,
> -	.mode_set     = msm_dp_bridge_mode_set,
>  	.mode_valid   = msm_dp_bridge_mode_valid,
>  	.get_modes    = msm_dp_bridge_get_modes,
>  	.detect       = msm_dp_bridge_detect,
> @@ -233,7 +232,6 @@ static const struct drm_bridge_funcs msm_edp_bridge_ops = {
>  	.atomic_enable = msm_edp_bridge_atomic_enable,
>  	.atomic_disable = msm_edp_bridge_atomic_disable,
>  	.atomic_post_disable = msm_edp_bridge_atomic_post_disable,
> -	.mode_set = msm_dp_bridge_mode_set,
>  	.mode_valid = msm_edp_bridge_mode_valid,
>  	.atomic_reset = drm_atomic_helper_bridge_reset,
>  	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
> diff --git a/drivers/gpu/drm/msm/dp/dp_drm.h b/drivers/gpu/drm/msm/dp/dp_drm.h
> index 6c0426803d78..6d4cbb9f3918 100644
> --- a/drivers/gpu/drm/msm/dp/dp_drm.h
> +++ b/drivers/gpu/drm/msm/dp/dp_drm.h
> @@ -36,9 +36,6 @@ void msm_dp_bridge_atomic_post_disable(struct drm_bridge *drm_bridge,
>  enum drm_mode_status msm_dp_bridge_mode_valid(struct drm_bridge *bridge,
>  					  const struct drm_display_info *info,
>  					  const struct drm_display_mode *mode);
> -void msm_dp_bridge_mode_set(struct drm_bridge *drm_bridge,
> -			const struct drm_display_mode *mode,
> -			const struct drm_display_mode *adjusted_mode);
>  void msm_dp_bridge_hpd_enable(struct drm_bridge *bridge);
>  void msm_dp_bridge_hpd_disable(struct drm_bridge *bridge);
>  void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
