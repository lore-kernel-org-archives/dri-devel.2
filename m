Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A475F3ED5C
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 00:07:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5456010E267;
	Sun, 12 Apr 2026 00:07:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dd6ytraz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y+xQdaCg";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2106610E267
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 00:07:57 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63BB3ZU1456284
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 00:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=61pis85xYux4db1AOderVe8V
 3hNhtxgvOnRxs24pQLc=; b=dd6ytrazfHKcXWqXnzg5e2SUmbI9ayLneRhzijeF
 7fkLJkNjP1a04EpFhGaJLdwyRy+jTm0U+6l2hNaVLjzERShgKruaqO9Bg4Dr7A8O
 5ZmkF4Qi9tYSc42JQr2PHHWpYauIUHUSXRQJu//HmBRV42z9i65rnGHCXrkqdAXe
 V/c27k6DW0xqiTiIn99ZryvUkPCk7S/RvMcQTiIoPB34zSjrWXwkpNqUkG5oX6f0
 Pj+1Q43XgefLfdB7J24xgumJPo5EygyFgbe+pCc67nsy3SfBs8q/NkrO/9jpsGOs
 XkGtt4lu39q4hixoTyMiJwMEHTJ84b1LnsMijE9e5WjyTg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfffhsgvk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 00:07:56 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50d6bf346adso65756011cf.1
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 17:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775952475; x=1776557275;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=61pis85xYux4db1AOderVe8V3hNhtxgvOnRxs24pQLc=;
 b=Y+xQdaCgS1PFSfGWtybT+pi0WzYSIFebh1vPS3tra92My93Bv3BgC3g6JiRSO231Xt
 A7VxNcGWwnYHjfffzgZMjY2XbeMtR6935T44RIk8y/2JjHurUqg4pm81bwWUtjRvoMad
 dhyiwPRSU2F0LXhdnmyOd8P/OkVsndtpjHP+p39QL5iLjs9shkwS0CeBt9BmB//yFkPm
 /K3spHFNLhjLyggKAHm8TqAYnIA4HQcJShEC6/Urx8Hvphknl5xWHEMqPWwDr3JIYTCb
 dw+25yurTOzwRvJXPdeuWZNxH6xAsPU+Sc0fITZDblZKWkRH6gKJ10Tw0iSoIQeFsYt4
 GTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775952475; x=1776557275;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=61pis85xYux4db1AOderVe8V3hNhtxgvOnRxs24pQLc=;
 b=FpKtlsijMjmC0PhtkAlqis6arOzGv4LoQwusW+6cJ5zGnF8Dx4WY2aGP+WCgosyAfJ
 a5duDt0MwWhL5K7eZd2/Ds3MF3RFKSMBsVlqq8LLBeUsR/AcfIbx+NmhHfXBFY+BtxDy
 Q8b0S1Mi+UJJzxI32+c8YZqnqVgA5o9eWGxvYEdKFLBatWK/v1pDrVV/BzfF90Dxw9yX
 oXeNsQmEbQ6JspJ6AJdx2LBEnwhUtUVdv7aE3HYWS56oFqgnbpHiE8s2Nuk+pgR7wrjh
 wf8sgsnBTyXupfWBXbbFUlqG9svmgmenQ4uPW9C6nL3aNO5PqvFWKbhkpAS9mHDTt6XH
 LljQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpPRp6ic9Xvis19pzQIZb3Bzd1PmvqWT+mP2X48pvaCBzM9kACsduztCClvSYh9RdPkbBaqJb3f2k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw05EQfkB6w304xFVYK+NrDggF3P5b4jN0Hy3asoKHU1FVQVV95
 lScy74I0sRZjETVXTQjA/YphJ9UwAAvEogXN5B0lmY43p9GVEIfAbfkn5i8u9ClAPEaGRHMQGWT
 /NXbZsSQsiwm5pdJqH4Qe2dQu885GRYbQnrs5r29bbwskEfzLsTld8/DlgCZs59KJJjY8IhA=
X-Gm-Gg: AeBDietHTcM1G4aePYD3Qv8G1NGQPaR3zT1vQF4yS6Kjjp4uTwg5qteA08UvUPUk3Y4
 JkPwauHU8+M5v7U46y3XNReJ5B5WiusHXQk5m+uUXBzdpbu1gGwA59YcY++YhR8p8Yb1jkM2Z/2
 DYVcterEJs61nDaFKH1QwXyRbz67BFqBp+O91QR2sThbc0leoX4ES9JAdt1ekH2pIAbpoj1CHN0
 DfUSvHNiw8StAVG7S6bf+V6YGQ8CCMgdvPHppveydzvENbUxIU90RlZvSgZwnbMuT4N0ff/ufVd
 3g/P73almeqPpSqiYCjKgzbvMT23RY617FBB0VWk9QUAfQdeZKa0kMsGKCUncxOQSOcgMA5vNnA
 uDfOriJian9DI1nHo2ohCkwDFPPFUeO5PYbZTIfyFHR1b/r5zEeAJoYn6t8hw8+YtbF73yJrY1n
 dbjL0Q0+iShMyXsXVHDypsTPc5Bireu/S7Ecc=
X-Received: by 2002:a05:622a:1f86:b0:50d:f05a:9eb9 with SMTP id
 d75a77b69052e-50df05addebmr27415241cf.36.1775952475373; 
 Sat, 11 Apr 2026 17:07:55 -0700 (PDT)
X-Received: by 2002:a05:622a:1f86:b0:50d:f05a:9eb9 with SMTP id
 d75a77b69052e-50df05addebmr27414861cf.36.1775952474835; 
 Sat, 11 Apr 2026 17:07:54 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eeee12fesm1655842e87.40.2026.04.11.17.07.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 17:07:53 -0700 (PDT)
Date: Sun, 12 Apr 2026 03:07:52 +0300
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
Subject: Re: [PATCH v4 26/39] drm/msm/dp: abstract out the dp_display stream
 helpers to accept a panel
Message-ID: <xvhrwq6j3bfxd5ya3wrzmjenxbb5t5qhit3nc2r3ssh7to3sqq@qefwpzhiroip>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-26-b20518dea8de@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-msm-dp-mst-v4-26-b20518dea8de@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDIyMSBTYWx0ZWRfX740tO7GyLXZ3
 fZYp1qBObIaBXxBGmRt7A/3BFN9xh1eal9B7WErDZmaNQqhmtkntOkhXdgfwZXTWsUPkuKVmdoi
 x4Qzixr3w3m34W1zbPWycIN7KGBJxZm1jt3HBJ++b8ER9TYBrfLgwW4UdYRsNo1DtqvCeaplk4U
 5AO9PQtoRIvKnbWYdUpERESAOtQlL07FcMZHjG4l9KVV2uuIIg8E/jNQnZ+eWENvryngs97apPC
 AnwAcBPpYNkK3e0FsG/5U3OjpfI9BTV10mL8CmZ2Rt76FmhhYJnfZXKiSm4nnVLh8nlARADoNGY
 Bj/BcGlyVbQ6JhPsxtjVlk2AtxaHy+9WJgOMXXEBbQXsliyxZiDgoIXT/3DPOUwJeyyUfsJFZpt
 GOU3/bu5tqbV5j8aNtYB3/55BlOwcaFLWF/oSUV5VtAdwfEtYDAzzCnCjJ3ldb0r5HXLfdMPtOl
 2iRUR6X8pZEjIHUzEKQ==
X-Proofpoint-ORIG-GUID: 9z2d4GbK_IKVDPT6j2p_YS0TyumUgd_p
X-Authority-Analysis: v=2.4 cv=FOkrAeos c=1 sm=1 tr=0 ts=69dae25c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=8K8LDW8wUMBAfiAu:21 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=INMUEtwSgdcI4kMDNXEA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 9z2d4GbK_IKVDPT6j2p_YS0TyumUgd_p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_07,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110221
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

On Fri, Apr 10, 2026 at 05:34:01PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> Currently the dp_display bridge helpers, in particular the
> dp_display_enable()/dp_display_disable() use the cached panel.
> To be able to re-use these helpers for MST use-case abstract the
> helpers to use the panel which is passed in to them.

This commit is doing more than just passing the panel. Please move
relevant parts to the previos one and write a proper commit message for
the rest of the changes.

> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 117 ++++++++++++++++++++++++------------
>  drivers/gpu/drm/msm/dp/dp_display.h |  12 ++++
>  2 files changed, 91 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 88a078e53dc1..33d8539afee7 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -635,12 +635,14 @@ static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
>  	return 0;
>  }
>  
> -static int msm_dp_display_prepare(struct msm_dp_display_private *dp)
> +int msm_dp_display_prepare(struct msm_dp *msm_dp_display)
>  {
> -	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
> +	struct msm_dp_display_private *dp;
>  	int rc = 0;
>  	bool force_link_train = false;
>  
> +	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
> +
>  	drm_dbg_dp(dp->drm_dev, "sink_count=%d\n", dp->link->sink_count);
>  
>  	if (msm_dp_display->is_edp)
> @@ -680,7 +682,7 @@ static int msm_dp_display_enable(struct msm_dp_display_private *dp,
>  		return 0;
>  	}
>  
> -	rc = msm_dp_ctrl_on_stream(dp->ctrl, dp->panel);
> +	rc = msm_dp_ctrl_on_stream(dp->ctrl, msm_dp_panel);
>  	if (!rc)
>  		msm_dp_display->power_on = true;
>  
> @@ -738,18 +740,6 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp,
>  
>  	msm_dp_ctrl_off_pixel_clk(dp->ctrl, msm_dp_panel->stream_id);
>  
> -	/* dongle is still connected but sinks are disconnected */
> -	if (dp->link->sink_count == 0)
> -		msm_dp_link_psm_config(dp->link, &msm_dp_panel->link_info, true);
> -
> -	msm_dp_ctrl_off_link(dp->ctrl);
> -
> -	if (dp->link->sink_count == 0)
> -		/* re-init the PHY so that we can listen to Dongle disconnect */
> -		msm_dp_ctrl_reinit_phy(dp->ctrl);
> -	else
> -		msm_dp_display_host_phy_exit(dp);
> -
>  	msm_dp_display->power_on = false;
>  
>  	drm_dbg_dp(dp->drm_dev, "sink count: %d\n", dp->link->sink_count);
> @@ -1495,76 +1485,116 @@ int msm_dp_modeset_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
>  	return 0;
>  }
>  
> -void msm_dp_display_atomic_prepare(struct msm_dp *msm_dp_display,
> -				   struct drm_atomic_state *state)
> +int msm_dp_display_set_mode_helper(struct msm_dp *msm_dp_display,
> +				   struct drm_atomic_state *state,
> +				   struct drm_encoder *drm_encoder,
> +				   struct msm_dp_panel *msm_dp_panel)
>  {
>  	struct drm_crtc *crtc;
>  	struct drm_crtc_state *crtc_state;
> +
> +	crtc = drm_atomic_get_new_crtc_for_encoder(state, drm_encoder);
> +	if (!crtc)
> +		return 0;
> +	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
> +
> +	return msm_dp_display_set_mode(msm_dp_display, &crtc_state->adjusted_mode, msm_dp_panel);
> +}
> +
> +void msm_dp_display_atomic_prepare(struct msm_dp *msm_dp_display,
> +				   struct drm_atomic_state *state)
> +{
>  	int rc = 0;
>  	struct msm_dp_display_private *dp;
>  
>  	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>  
> -	crtc = drm_atomic_get_new_crtc_for_encoder(state,
> -						   msm_dp_display->bridge->encoder);
> -	if (!crtc)
> -		return;
> -	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
> -
> -	rc = msm_dp_display_set_mode(msm_dp_display, &crtc_state->adjusted_mode, dp->panel);
> +	rc = msm_dp_display_set_mode_helper(msm_dp_display, state,
> +					    msm_dp_display->bridge->encoder, dp->panel);
>  	if (rc) {
>  		DRM_ERROR("Failed to perform a mode set, rc=%d\n", rc);
>  		return;
>  	}
>  
> -	rc = msm_dp_display_prepare(dp);
> +	rc = msm_dp_display_prepare(msm_dp_display);
>  	if (rc)
>  		DRM_ERROR("DP display prepare failed, rc=%d\n", rc);
>  }
>  
> -void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display)
> +void msm_dp_display_enable_helper(struct msm_dp *msm_dp_display, struct msm_dp_panel *msm_dp_panel)
>  {
>  	struct msm_dp_display_private *dp;
>  	int rc = 0;
>  
>  	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>  
> -	msm_dp_display_set_stream_info(msm_dp_display, dp->panel, 0, 0, 0, 0);
> -
> -	rc = msm_dp_display_enable(dp, dp->panel);
> +	rc = msm_dp_display_enable(dp, msm_dp_panel);
>  	if (rc)
>  		DRM_ERROR("DP display enable failed, rc=%d\n", rc);
>  
>  	rc = msm_dp_display_post_enable(msm_dp_display);
>  	if (rc) {
>  		DRM_ERROR("DP display post enable failed, rc=%d\n", rc);
> -		msm_dp_display_disable(dp, dp->panel);
> +		msm_dp_display_disable(dp, msm_dp_panel);
>  	}
>  
>  	drm_dbg_dp(msm_dp_display->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
>  }
>  
> -void msm_dp_display_atomic_disable(struct msm_dp *msm_dp_display)
> +void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display)
>  {
>  	struct msm_dp_display_private *dp;
>  
>  	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>  
> -	msm_dp_ctrl_push_idle(dp->ctrl, dp->panel);
> +	msm_dp_display_set_stream_info(msm_dp_display, dp->panel, 0, 0, 0, 0);
> +
> +	msm_dp_display_enable_helper(msm_dp_display, dp->panel);
> +}
> +
> +void msm_dp_display_disable_helper(struct msm_dp *msm_dp_display,
> +				   struct msm_dp_panel *msm_dp_panel)
> +{
> +	struct msm_dp_display_private *dp;
> +
> +	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
> +
> +	msm_dp_ctrl_push_idle(dp->ctrl, msm_dp_panel);
>  	msm_dp_ctrl_mst_stream_channel_slot_setup(dp->ctrl);
>  	msm_dp_ctrl_mst_send_act(dp->ctrl);
>  }
>  
> -static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
> +void msm_dp_display_atomic_disable(struct msm_dp *msm_dp_display)
>  {
> -	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
> +	struct msm_dp_display_private *dp;
>  
> -	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
> +	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
> +
> +	msm_dp_display_disable_helper(msm_dp_display, dp->panel);
> +}
> +
> +void msm_dp_display_unprepare(struct msm_dp *msm_dp_display)
> +{
> +	struct msm_dp_display_private *dp;
> +
> +	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>  
> -	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
> +	/* dongle is still connected but sinks are disconnected */
> +	if (dp->link->sink_count == 0)
> +		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
> +
> +	msm_dp_ctrl_off_link(dp->ctrl);
> +
> +	/* re-init the PHY so that we can listen to Dongle disconnect */
> +	if (dp->link->sink_count == 0)
> +		msm_dp_ctrl_reinit_phy(dp->ctrl);
> +	else
> +		msm_dp_display_host_phy_exit(dp);
> +
> +	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
>  }
>  
> -void msm_dp_display_atomic_post_disable(struct msm_dp *dp)
> +void msm_dp_display_atomic_post_disable_helper(struct msm_dp *dp, struct msm_dp_panel *msm_dp_panel)
>  {
>  	struct msm_dp_display_private *msm_dp_display;
>  
> @@ -1575,7 +1605,18 @@ void msm_dp_display_atomic_post_disable(struct msm_dp *dp)
>  
>  	msm_dp_display_audio_notify_disable(msm_dp_display);
>  
> -	msm_dp_display_disable(msm_dp_display, msm_dp_display->panel);
> +	msm_dp_display_disable(msm_dp_display, msm_dp_panel);
> +
> +	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", dp->connector_type);
> +}
> +
> +void msm_dp_display_atomic_post_disable(struct msm_dp *msm_dp_display)
> +{
> +	struct msm_dp_display_private *dp;
> +
> +	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
> +
> +	msm_dp_display_atomic_post_disable_helper(msm_dp_display, dp->panel);
>  
>  	msm_dp_display_unprepare(msm_dp_display);
>  }
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
> index 0ccdddb223c8..0ede5505be58 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.h
> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
> @@ -46,5 +46,17 @@ enum drm_mode_status msm_dp_display_mode_valid(struct msm_dp *dp,
>  int msm_dp_display_set_stream_info(struct msm_dp *msm_dp_display, struct msm_dp_panel *panel,
>  				   enum msm_dp_stream_id stream_id,
>  				   u32 start_slot, u32 num_slots, u32 pbn);
> +void msm_dp_display_enable_helper(struct msm_dp *msm_dp_display,
> +				  struct msm_dp_panel *msm_dp_panel);
> +void msm_dp_display_disable_helper(struct msm_dp *msm_dp_display,
> +				   struct msm_dp_panel *msm_dp_panel);
> +void msm_dp_display_atomic_post_disable_helper(struct msm_dp *msm_dp_display,
> +					       struct msm_dp_panel *msm_dp_panel);
> +int msm_dp_display_set_mode_helper(struct msm_dp *msm_dp_display,
> +				   struct drm_atomic_state *state,
> +				   struct drm_encoder *drm_encoder,
> +				   struct msm_dp_panel *msm_dp_panel);
> +int msm_dp_display_prepare(struct msm_dp *msm_dp_display);
> +void msm_dp_display_unprepare(struct msm_dp *dp);
>  
>  #endif /* _DP_DISPLAY_H_ */
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
