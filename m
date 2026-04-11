Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D174F3ED50
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 18:57:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E152610E218;
	Sat, 11 Apr 2026 18:57:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jcu7kLXT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G2LFQa/G";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF89C10E20A
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 18:57:20 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63BGbVfw1127817
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 18:57:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=85AJ+PtbhQtD31fE8g9VZOBw
 qviQ452IKAr9YcKM+ow=; b=jcu7kLXTf2K+ih1CxS23GYIROdQYN2rwUIQcbl4M
 b4GaagzavWBUWQNCkT5JgJuQEiygTl3yE/BjV4vjtpB2qMELNhMsB5sVCplvU4zh
 jAKN2j3czxthRt12nPWjMxbi6wQZeI3y5MpyGbeSjew05mJ6rsc9sIUVRewACJqV
 v9wFd8K4Rw3WHjBaqITm2pj6Wh20567tu1xPWJy0BQ4UZU/SA//BU72Qr9bT+/Sd
 Mba0+bCSDQ4KwVCpgl+6O5h8WMFEdaMtaIQ0NHd78ybmMQXcLO7MYkdfVlc+X4uv
 L483iO3MWFvHksN2R73t/VVA0wAmD49GWlpCoG0ci8miCg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfffhs6dr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 18:57:20 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50d826ed6f9so71394881cf.1
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 11:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775933839; x=1776538639;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=85AJ+PtbhQtD31fE8g9VZOBwqviQ452IKAr9YcKM+ow=;
 b=G2LFQa/G67Nsv7Hgx7NIxamb8yHueBagkckSQNaD8Ph19roVDMaKjSFIInFlx+gCWL
 lBhjkH+f54WMZPGWsfwomZSwO9nT/n0sLD2NfFf0QuEcwAGstxV21KdayCqDsPYzk4hK
 4o4xhxv0mv6Bc03zpyl14I6APuzPcPW3YVNl067raNrO5qMufQ1AFpVleT+D6PXzxvvI
 cQxItZNR/gIo6BiWp3vAoiFoT9XnaHS2uDjtPOCInB3N9GFMkwqvYzUr6wRUEd5GLWRl
 O9bU7fcnY0LZm8XpBPpmK5H9FFtKt/XELbmAUvVbq6/yuJb0CiHHNcnnuCs10OQP+pxb
 4swA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775933839; x=1776538639;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=85AJ+PtbhQtD31fE8g9VZOBwqviQ452IKAr9YcKM+ow=;
 b=CcBLZNqOXCuoFa4GAXP0EgLL7L8jAcrit5XTGZLPWRUdEVsHNDT6kSLNT0gDQvEaYK
 ESo23X15uo1jgU8TKEFfe4wbUNpp4uiuAhcnouowZohz7ZxuQy+1A9KhkGr+964Ci395
 PN3BhjPFKIL/908foOS4YaaIL7ap39rFeoE9vkjMEXQrsft8yYIE5AjsE+v76kfoOLtH
 SmkEVHpwcAATskhdSbWGXwO7A9Pyn7nwEXkf0rQ51sxXQRh7jGexbWgR6WfQcdPqLIZZ
 Zj3URZrEaqTKfISaxYn+HmZlmd1XOSEGTFJCcPLKNB05osOS6hTlpwUVonolLYNMUQoH
 AZ1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoOzbwqW3B74SKwJD3lgOV5mF2XPl4ZH7HpwL6O/GIjyWHxHRLoiK1O5n7rdPSSF7FUkftomsSuB4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw2Q0elSO/8V5YbE1WWlrrrE+GptqlAEvvILXj2Qhb2pUpXnu3w
 GAGA097kAOp2kzXFh+rWzTSJvEo1X2UDR2GoIKZ2m8ZcUE8QpD4QlfQodMZ4Z+olBb5hg86rCVd
 ptsxIqtJQCeuy6aHMInychDL1Hc84Y8HEe5py3NAfN7/Uy1vgsnvQD3V5y8yprVvKusbFR2g=
X-Gm-Gg: AeBDieuujvPLt4t0Q/DkbApdYtA5G8gJnHPJLzGKt+KSsWIXOJO7lk/68KMwzgv51tz
 V/7GzkpvHElWwBc3KyHHH24y24WuzjzEDFto+NeIQnKPVRbIObcVAGCrueJPabt6dvWSK2lBkBm
 ODdy4xCjC108gwIqlBncE97y0nX6JF2TRCQi6bWdas8qnB2LBq38PsOkEsU5C/xrs+DUoo/NH3F
 f3TvOLUXj/DtivqtBkMaHV9H/x9CN1F5rSdv11N6blZ/qfPgsgjR/LkNfaBWcWnxT8Se47/GrEK
 S3/TAegwdcHriOBrfs1qU4Bm0lmH+PobuouA98ZeRDY+Jijl5vASArfF9sDgXytwIlzucnM5TM6
 wcxFiGKXBmtcQ+aVG8486EAFGYwddrTVnrcymNAlSvE+VWm22wyUx7WTcGqGHaPe7SGfGVecWw1
 9m7kC7yF96IBgeqd7GK79Nt2OJqjaf55xgK98=
X-Received: by 2002:a05:622a:3d4:b0:50b:292d:94e3 with SMTP id
 d75a77b69052e-50dc1b9a1f4mr162905851cf.42.1775933839095; 
 Sat, 11 Apr 2026 11:57:19 -0700 (PDT)
X-Received: by 2002:a05:622a:3d4:b0:50b:292d:94e3 with SMTP id
 d75a77b69052e-50dc1b9a1f4mr162905711cf.42.1775933838613; 
 Sat, 11 Apr 2026 11:57:18 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e49546655sm13187071fa.20.2026.04.11.11.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 11:57:17 -0700 (PDT)
Date: Sat, 11 Apr 2026 21:57:15 +0300
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
Subject: Re: [PATCH v4 18/39] drm/msm/dp: add support to send ACT packets for
 MST
Message-ID: <6jkqen322yklhb4zzoj2kcgwayhcqm3mhnbrkgimr7zubwewao@gmuopu6uxakq>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-18-b20518dea8de@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-msm-dp-mst-v4-18-b20518dea8de@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDE2OSBTYWx0ZWRfX8LAIUnBDzI/d
 NQJWUKnBZbQB7yNSxF0mUz8KDO1IOgC+lEVb8OFYLcROSS9I6aS8hfSUphMp5cc1tjK3D3a+RhE
 UX60Enj30bOINrbtB/RMs/xrvoBFlFzdfelZS8DIaWS3ZUwhUSW9mZjSklaaFLr0IPb0qt9dIi2
 r8tqJOReN+In2rPW4XS9iisdgCUKExEXy4EN8GfmxJy6xeZMv6jMsZRPwgQrdnUY/HRiWRhnmnZ
 skrb5h1tyWiHgnfvVAJCYY8JMPf7bgTXmxGgP+o4oSFLDT2Kv75JeeziSGoIsBr+VmC6pkQKZxw
 E9/OmU2eb8S770L9MSGtZmjgvKd9Xle+0PGbuBfTyzthTFbA1i3Y2wprLFYI2qPnYLnQ+5Uu+9n
 P+5l/OgARvKS9OlK0H0LXk8mh2Gg3xk8z13zX3scX1NJqnx+A9VUcrjUlU0IMggSYscBd/I+qCc
 BPTGVIulTmuRiJ99kow==
X-Proofpoint-ORIG-GUID: yXJr5zqNJSD0MvtpNRnBtddS6cqKnSRG
X-Authority-Analysis: v=2.4 cv=FOkrAeos c=1 sm=1 tr=0 ts=69da9990 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=xirQvcjanROXNmDBG14A:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: yXJr5zqNJSD0MvtpNRnBtddS6cqKnSRG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110169
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

On Fri, Apr 10, 2026 at 05:33:53PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> Whenever virtual channel slot allocation changes, the DP
> source must send the action control trigger sequence to notify
> the sink about the same. This would be applicable during the
> start and stop of the pixel stream. Add the infrastructure
> to be able to send ACT packets for the DP controller when
> operating in MST mode.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 43 +++++++++++++++++++++++++++++++++++--
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |  3 ++-
>  drivers/gpu/drm/msm/dp/dp_display.c |  3 ++-
>  drivers/gpu/drm/msm/dp/dp_display.h |  1 +
>  drivers/gpu/drm/msm/dp/dp_reg.h     |  2 ++
>  5 files changed, 48 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index 1109b2df21be..6f25145ef214 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -143,6 +143,7 @@ struct msm_dp_ctrl_private {
>  	bool core_clks_on;
>  	bool link_clks_on;
>  	bool stream_clks_on[DP_STREAM_MAX];
> +	bool mst_active;
>  };
>  
>  static inline u32 msm_dp_read_ahb(const struct msm_dp_ctrl_private *ctrl, u32 offset)
> @@ -228,6 +229,32 @@ static int msm_dp_aux_link_configure(struct drm_dp_aux *aux,
>  	return err;
>  }
>  
> +int msm_dp_ctrl_mst_send_act(struct msm_dp_ctrl *msm_dp_ctrl)
> +{
> +	struct msm_dp_ctrl_private *ctrl;
> +	bool act_complete;
> +
> +	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
> +
> +	if (!ctrl->mst_active)
> +		return 0;
> +
> +	msm_dp_write_link(ctrl, 0, REG_DP_MST_ACT, 0x1);
> +	/* make sure ACT signal is performed */
> +	wmb();
> +
> +	msleep(20); /* needs 1 frame time */

20 ms is 50fps. What if we have 30 or 25 fps?

> +
> +	act_complete = msm_dp_read_link(ctrl, 0, REG_DP_MST_ACT);
> +

Nit: drop empty line.

> +	if (!act_complete) {
> +		drm_dbg_dp(ctrl->drm_dev, "MST ACT trigger complete failed\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * NOTE: resetting DP controller will also clear any pending HPD related interrupts
>   */
> @@ -2081,6 +2108,10 @@ static int msm_dp_ctrl_link_maintenance(struct msm_dp_ctrl_private *ctrl)
>  
>  	msm_dp_write_link(ctrl, 0, REG_DP_STATE_CTRL, DP_STATE_CTRL_SEND_VIDEO);
>  
> +	ret = msm_dp_ctrl_mst_send_act(&ctrl->msm_dp_ctrl);
> +	if (ret)
> +		return ret;
> +
>  	ret = msm_dp_ctrl_wait4video_ready(ctrl);
>  end:
>  	return ret;
> @@ -2277,7 +2308,7 @@ static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl
>  	msm_dp_ctrl_off_pixel_clk(&ctrl->msm_dp_ctrl, ctrl->panel->stream_id);
>  	msm_dp_ctrl_off_link(&ctrl->msm_dp_ctrl);
>  
> -	ret = msm_dp_ctrl_on_link(&ctrl->msm_dp_ctrl);
> +	ret = msm_dp_ctrl_on_link(&ctrl->msm_dp_ctrl, false);
>  	if (ret) {
>  		DRM_ERROR("failed to enable DP link controller\n");
>  		return ret;
> @@ -2357,7 +2388,7 @@ static bool msm_dp_ctrl_channel_eq_ok(struct msm_dp_ctrl_private *ctrl)
>  	return drm_dp_channel_eq_ok(link_status, num_lanes);
>  }
>  
> -int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl)
> +int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl, bool mst_active)
>  {
>  	int rc = 0;
>  	struct msm_dp_ctrl_private *ctrl;
> @@ -2375,6 +2406,7 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl)
>  
>  	rate = ctrl->panel->link_info.rate;
>  	pixel_rate = ctrl->panel->msm_dp_mode.drm_mode.clock;
> +	ctrl->mst_active = mst_active;

Should it be set to active only when you actually activate the MST?

>  
>  	msm_dp_ctrl_core_clk_enable(&ctrl->msm_dp_ctrl);
>  
> @@ -2654,6 +2686,10 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
>  
>  	msm_dp_write_link(ctrl, 0, REG_DP_STATE_CTRL, DP_STATE_CTRL_SEND_VIDEO);
>  

I'd rather have the `if mst_active` here rather than in the function.

> +	ret = msm_dp_ctrl_mst_send_act(msm_dp_ctrl);
> +	if (ret)
> +		return ret;
> +
>  	ret = msm_dp_ctrl_wait4video_ready(ctrl);
>  	if (ret)
>  		return ret;
> @@ -2693,6 +2729,8 @@ void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl)
>  
>  	msm_dp_ctrl_reset(&ctrl->msm_dp_ctrl);
>  
> +	ctrl->mst_active = false;
> +
>  	dev_pm_opp_set_rate(ctrl->dev, 0);
>  	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
>  
> @@ -2876,6 +2914,7 @@ struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev, struct msm_dp_link *link
>  	ctrl->link_base = link_base;
>  	ctrl->mst2link_base = mst2link_base;
>  	ctrl->mst3link_base = mst3link_base;
> +	ctrl->mst_active = false;
>  
>  	ret = msm_dp_ctrl_clk_init(&ctrl->msm_dp_ctrl, max_stream);
>  	if (ret) {
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
> index e72d501ac1ce..f82fd96e412a 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
> @@ -16,7 +16,7 @@ struct msm_dp_ctrl {
>  
>  struct phy;
>  
> -int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl);
> +int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl, bool mst_active);
>  int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *msm_dp_panel);
>  int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train);
>  void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl);
> @@ -51,4 +51,5 @@ void msm_dp_ctrl_disable_irq(struct msm_dp_ctrl *msm_dp_ctrl);
>  
>  void msm_dp_ctrl_reinit_phy(struct msm_dp_ctrl *msm_dp_ctrl);
>  int msm_dp_ctrl_get_stream_cnt(struct msm_dp_ctrl *dp_ctrl);
> +int msm_dp_ctrl_mst_send_act(struct msm_dp_ctrl *msm_dp_ctrl);
>  #endif /* _DP_CTRL_H_ */
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index a924fbd825f7..80bb5fc4003f 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -660,7 +660,7 @@ static int msm_dp_display_prepare(struct msm_dp_display_private *dp)
>  		force_link_train = true;
>  	}
>  
> -	rc = msm_dp_ctrl_on_link(dp->ctrl);
> +	rc = msm_dp_ctrl_on_link(dp->ctrl, msm_dp_display->mst_active);
>  	if (rc)
>  		DRM_ERROR("Failed link training (rc=%d)\n", rc);
>  	// TODO: schedule drm_connector_set_link_status_property()
> @@ -1547,6 +1547,7 @@ void msm_dp_display_atomic_disable(struct msm_dp *dp)
>  	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
>  
>  	msm_dp_ctrl_push_idle(msm_dp_display->ctrl);
> +	msm_dp_ctrl_mst_send_act(msm_dp_display->ctrl);
>  }
>  
>  static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
> index b0cfdf215970..fdbe6e4871d9 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.h
> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
> @@ -19,6 +19,7 @@ struct msm_dp {
>  	struct drm_bridge *bridge;
>  	bool audio_enabled;
>  	bool power_on;
> +	bool mst_active;
>  	unsigned int connector_type;
>  	bool is_edp;
>  
> diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
> index 1c2d3d8d029d..237325d52dbd 100644
> --- a/drivers/gpu/drm/msm/dp/dp_reg.h
> +++ b/drivers/gpu/drm/msm/dp/dp_reg.h
> @@ -156,6 +156,8 @@
>  #define DP_CONFIGURATION_CTRL_BPC_SHIFT		(0x08)
>  #define DP_CONFIGURATION_CTRL_LSCLK_DIV_SHIFT	(0x0D)
>  
> +#define REG_DP_MST_ACT				(0x00000500)
> +
>  #define REG_DP_SOFTWARE_MVID			(0x00000010)
>  #define REG_DP_SOFTWARE_NVID			(0x00000018)
>  #define REG_DP_TOTAL_HOR_VER			(0x0000001C)
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
