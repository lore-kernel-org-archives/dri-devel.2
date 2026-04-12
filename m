Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BF6F3ED67
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 00:11:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 314B810E26A;
	Sun, 12 Apr 2026 00:11:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cSub15ed";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M97MbprP";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BEA210E269
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 00:11:05 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63BKeUxf1212272
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 00:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=PfCuThIzy1DAWtkxvSufJcbv
 iZnleEUkWpVjjUK8iQE=; b=cSub15edOvLTnuYDadP4533Gg5Weom5FOCJtX1bo
 MMp6HubsEYMgtXUfYkQV7qYknKX2ByHH+3dRU+1sw6X8mwZ0M5HpJGHwPMSLsXsd
 xtmVcEKemNznzej61XcSvOJcmQWkQRv5lZKNyWSDA/AKRBGD3M8P0nV9eHV8U1XS
 HjqdXytozpzA4pKN7RSXHrR7AaaMZt+pGKIosFLkUSztm50spMrXxOFusSI9nZcX
 LC24mT8zeg7f7mY+xq4knKc1+XAkPDFTVTFDL9IetPeT9Zc/BpLLw+/h8BXY0sKU
 1bGkfLktdu9B0t6cnq0AHS9I0+h1VLk+kgBnjiGSpU7bZg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfewksj27-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 00:11:04 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b34223670so128797891cf.0
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 17:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775952664; x=1776557464;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PfCuThIzy1DAWtkxvSufJcbviZnleEUkWpVjjUK8iQE=;
 b=M97MbprPVbF/WuM9613aUmzD+nrUGHmM2uDloArij8zwPn66YfrC0xPhV5zgWOqIgB
 lPnJBgG6ELbMzuqYZnSta8z/jFlX1gQwiMqYKNb9RdRpbokuCRYeBa+nMHkYEHZCiOku
 UWba1PLDIiwMgjd0A1eesGwAZv1ypvBbComz8OWg+gwB8RZFxXoKzsTskq9V1qznriHW
 R/Twdrz/KAvxOTGHSkOoQIpGej0QuOGYoA2AULGKngRvQqqvsL85WJ0znIGWNi0PELE6
 7GOoZt7nAFquxyLj1J6XZSkofAOTWZk15ctUMHePfQzPiZrt6gc3+IZAwvSmXMuMa912
 59VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775952664; x=1776557464;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PfCuThIzy1DAWtkxvSufJcbviZnleEUkWpVjjUK8iQE=;
 b=V5fEwEQjQs2NTVn//u/gd5w03vBsD2SQ7YPoXkcxQin/TlQ0RBkHZWfsnx5l/Swdbj
 MpgCAEwuuT2nyMn1e2pni2bRsZ5cOnrV7umaBOss8DIvnb4usj2p5a7JWuOqRQJemJnQ
 of9Ih5TfgE4jT8jtNYWAHdX6RJ4JtDM8CN6ivO7dBmRQbECa9ymGAfr/k4/UPb9GkFfT
 xBUvSE5X0Z9wtbvM/fJ5Ycg87QXBanVE2uHz2740kTUpJkRjmFOTXrmJTdxFzDO3j22T
 9DmlLV3Dhra9RoNf83i9JaMdyBxpAV57ZsbUciqIA5YDOsX+VK8+DdTaMGbmFwqAObfE
 4BTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvMBxxI+b74hTWZwTptgwsvfPyW+7k4S2SWhLu6FJVhWSNtPnAufMVqwu+2mPFdG4wwETqJNbKY38=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzs62QOLqlLRBg7FrhU/emoEIcHPakY5+57THqn8585p3Vu5uk0
 wmR8U0dnRQY/xGdQNYCJkIiaEEHo2Pw5VIhocAv1+DRUD3M7vf4URPBBEH5QpCNDwYqNsrzqQnP
 IwlneoRYDy/BZLO7bKg2HWlvAND34D1gIl21HXe7h7hNUtCWHamcOLBoWU10irUkWJxmrFVQ=
X-Gm-Gg: AeBDiev55YUX7ey2z1cAdXm4rqtzZTVJIOjaMqVDKhzmHd9Z4XxQ6Slt0yYb/v3QL9t
 4Wui0j6hlgUqcU9dAJqBdGnSZzA2TeVzwJXXa2kIRNHBwv/NDZI5ZnVEKXHAo7kM+TJDGlT+FHf
 d+whaWhd8kNiXRflDg8TW2ZdcW3Y/DJp39mPJIo11Ng+lHI248XkFsDm56R1AmTQH3t7d8K/9Uv
 +pz/rladzTaLieFiykW8noaoeflbsbgaG3ZDY3pgJsQVVxByUHQ+RBqEkzICrF1Yvy5Tmmrk3Xq
 gVrj2VrJfil5RttTj5RcVwH583nt9iFd+qrsCZPmRGq5NWDxC8h7v5mJ0e+iuaO4ez4XbP7va4K
 zG4KzczaSqiSlDaglDg3pwq/EJxelKchV0I9O2W38dHZz0nNfzYEEy7jwrJUflWYeud3v7FsaGS
 eA/d4dZk8MN/8fztuUjy/EByUK/eL1xgafF4I=
X-Received: by 2002:ac8:7e88:0:b0:50d:71fe:85aa with SMTP id
 d75a77b69052e-50dd5bd942bmr132960051cf.16.1775952664375; 
 Sat, 11 Apr 2026 17:11:04 -0700 (PDT)
X-Received: by 2002:ac8:7e88:0:b0:50d:71fe:85aa with SMTP id
 d75a77b69052e-50dd5bd942bmr132959801cf.16.1775952663921; 
 Sat, 11 Apr 2026 17:11:03 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eee8d9e4sm1672409e87.27.2026.04.11.17.11.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 17:11:02 -0700 (PDT)
Date: Sun, 12 Apr 2026 03:11:01 +0300
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
Subject: Re: [PATCH v4 27/39] drm/msm/dp: replace power_on with
 active_stream_cnt for dp_display
Message-ID: <ezm6cz4lfzrh2a7ohwdc73qbn7gblqjhwtwcp72ds7u6cmizrx@qvh7vu6kis2k>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-27-b20518dea8de@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-msm-dp-mst-v4-27-b20518dea8de@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=bcFbluPB c=1 sm=1 tr=0 ts=69dae319 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=bNG_VgKFK3iIsOFNL9IA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDIyMSBTYWx0ZWRfX7UIoUWw7LRnh
 z/uES6qYWB+6jf1Dz1+TJloJ0+XajJWI0bYEkif+xKbFAQqq3fMXZ7hLGNlMfL8MQQEdbJzjmVc
 9+xPg0a94dvmik5kLhfooS+ZR2EuCnQXxwwZVNNd1agE3PiI5sKlI6c72xM9/WPb2XusS9Xri2+
 /LhyKtNOU6rdKWBIdxxZPjMmqDN37wY24nV+unhUTVVf+dN3aNHjIUrPUPf9ttbyJJavmO952vT
 WVMFa/ZHqMXj+mDeav39MqASh1jfzx/QWNeCZj1KLlplIBk/ANIi5yAbXaOTgZsE01yXjNeuqkc
 D04hjT6omXz/Q6Xd3z+8N8zb3pxp5MeWqa5ivOggD3AQ3x+33DzSzbGV6beYtetoIgoI2NzPN+y
 HiHcpdDAFBTClbZ+TqdKYtQThZp+6+aCdKyB2SBfhPVVgjy0KkVI7ZygfZwVxnJ1nuBaMslPlTJ
 D8LKaU+EZ1fMEllFWlw==
X-Proofpoint-ORIG-GUID: 8fj2zIPomWIDnrlH9-vEbTFwj1VmiReE
X-Proofpoint-GUID: 8fj2zIPomWIDnrlH9-vEbTFwj1VmiReE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_07,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604110221
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

On Fri, Apr 10, 2026 at 05:34:02PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> For DP MST, the link clock and power domain resources stay on until
> both streams have been disabled OR we receive hotplug. Introduce an
> active_stream_cnt to track the number of active streams and necessary
> state handling. Replace the power_on variable with active_stream_cnt
> as power_on boolean works only for a single stream.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_audio.c   |  2 +-
>  drivers/gpu/drm/msm/dp/dp_display.c | 38 +++++++++++++++++++------------------
>  drivers/gpu/drm/msm/dp/dp_display.h |  2 +-
>  3 files changed, 22 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_audio.c b/drivers/gpu/drm/msm/dp/dp_audio.c
> index 41018e82efa1..035e230201fd 100644
> --- a/drivers/gpu/drm/msm/dp/dp_audio.c
> +++ b/drivers/gpu/drm/msm/dp/dp_audio.c
> @@ -284,7 +284,7 @@ int msm_dp_audio_prepare(struct drm_bridge *bridge,
>  	 * such cases check for connection status and bail out if not
>  	 * connected.
>  	 */
> -	if (!msm_dp_display->power_on) {
> +	if (!msm_dp_display->active_stream_cnt) {
>  		rc = -EINVAL;
>  		goto end;
>  	}
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 33d8539afee7..e6ecbb3a688e 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -657,15 +657,15 @@ int msm_dp_display_prepare(struct msm_dp *msm_dp_display)
>  	if (dp->link->sink_count == 0)
>  		return rc;
>  
> -	if (!msm_dp_display->power_on) {
> +	if (!msm_dp_display->active_stream_cnt) {

Okay, I'm now being lost between the names. When is prepare being
called? Is it still part of the atomic_enable()? Or atomic_pre_enable()?

>  		msm_dp_display_host_phy_init(dp);
>  		force_link_train = true;
> -	}
>  
> -	rc = msm_dp_ctrl_on_link(dp->ctrl, msm_dp_display->mst_active);
> -	if (rc)
> -		DRM_ERROR("Failed link training (rc=%d)\n", rc);
> -	// TODO: schedule drm_connector_set_link_status_property()
> +		rc = msm_dp_ctrl_on_link(dp->ctrl, msm_dp_display->mst_active);
> +		if (rc)
> +			DRM_ERROR("Failed link training (rc=%d)\n", rc);
> +		// TODO: schedule drm_connector_set_link_status_property()
> +	}

Again, this more than the scope of the commit message.

>  
>  	return msm_dp_ctrl_prepare_stream_on(dp->ctrl, force_link_train);
>  }
> @@ -674,18 +674,12 @@ static int msm_dp_display_enable(struct msm_dp_display_private *dp,
>  				 struct msm_dp_panel *msm_dp_panel)
>  {
>  	int rc = 0;
> -	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
>  
>  	drm_dbg_dp(dp->drm_dev, "sink_count=%d\n", dp->link->sink_count);
> -	if (msm_dp_display->power_on) {
> -		drm_dbg_dp(dp->drm_dev, "Link already setup, return\n");
> -		return 0;
> -	}
>  
>  	rc = msm_dp_ctrl_on_stream(dp->ctrl, msm_dp_panel);
> -	if (!rc)
> -		msm_dp_display->power_on = true;
>  
> +	dp->msm_dp_display.active_stream_cnt++;
>  	return rc;
>  }
>  
> @@ -731,16 +725,14 @@ static void msm_dp_display_audio_notify_disable(struct msm_dp_display_private *d
>  static int msm_dp_display_disable(struct msm_dp_display_private *dp,
>  				  struct msm_dp_panel *msm_dp_panel)
>  {
> -	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
> -
> -	if (!msm_dp_display->power_on)
> +	if (!dp->msm_dp_display.active_stream_cnt)
>  		return 0;
>  
>  	msm_dp_panel_disable_vsc_sdp(msm_dp_panel);
>  
>  	msm_dp_ctrl_off_pixel_clk(dp->ctrl, msm_dp_panel->stream_id);
>  
> -	msm_dp_display->power_on = false;
> +	dp->msm_dp_display.active_stream_cnt--;
>  
>  	drm_dbg_dp(dp->drm_dev, "sink count: %d\n", dp->link->sink_count);
>  	return 0;
> @@ -876,7 +868,7 @@ void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp)
>  	 * power_on status before dumping DP registers to avoid crash due
>  	 * to unclocked access
>  	 */
> -	if (!dp->power_on)
> +	if (!dp->active_stream_cnt)
>  		return;
>  
>  	msm_disp_snapshot_add_block(disp_state, msm_dp_display->ahb_len,
> @@ -1559,6 +1551,11 @@ void msm_dp_display_disable_helper(struct msm_dp *msm_dp_display,
>  
>  	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>  
> +	if (!msm_dp_display->active_stream_cnt) {
> +		drm_dbg_dp(dp->drm_dev, "no active streams\n");
> +		return;
> +	}
> +
>  	msm_dp_ctrl_push_idle(dp->ctrl, msm_dp_panel);
>  	msm_dp_ctrl_mst_stream_channel_slot_setup(dp->ctrl);
>  	msm_dp_ctrl_mst_send_act(dp->ctrl);
> @@ -1579,6 +1576,11 @@ void msm_dp_display_unprepare(struct msm_dp *msm_dp_display)
>  
>  	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>  
> +	if (msm_dp_display->active_stream_cnt) {
> +		drm_dbg_dp(dp->drm_dev, "stream still active, return\n");
> +		return;
> +	}
> +
>  	/* dongle is still connected but sinks are disconnected */
>  	if (dp->link->sink_count == 0)
>  		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
> index 0ede5505be58..2548f67cd441 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.h
> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
> @@ -18,7 +18,7 @@ struct msm_dp {
>  	struct drm_bridge *next_bridge;
>  	struct drm_bridge *bridge;
>  	bool audio_enabled;
> -	bool power_on;
> +	u32 active_stream_cnt;
>  	bool mst_active;
>  	unsigned int connector_type;
>  	bool is_edp;
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
