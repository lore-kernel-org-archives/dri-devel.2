Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67D0C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 18:51:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0638910E4CE;
	Sun, 12 Jul 2026 18:51:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TRR8HmmJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a0dYkYD7";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D053910E07B
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 18:51:19 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66CGtJjH3109808
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 18:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=6ybGwtJxVoLsGbIz4zDAwjLE
 aQt50o/EbJNH6JOGvd4=; b=TRR8HmmJX+i/jSBB8G4/ReM24LTc4ysv9nXZ+pQA
 GAnavZiebdVBerzCbALUcG5Rm9p7X16IZOtuUxl8HfIynTyq6p8SwFcNXSDEdrhq
 syu/JMin2pWL8atekGFp150cGACaEBoGQb6X1MJT9FxIp/t3H50LHz0i+XMqYvlV
 byRbHDD1gWllwqU0j5CQrJ3l5teUNt4NSJZAkYiadUtquCHMQ/IlkYk5mfUkpst5
 MoWOU+BNDqiIn3qOwVjE7Ig6VyRyAe2DxSWBncEZk4xP5K1dDa/Y3HnTsqXnjyYV
 BZtKP0ynBjFV46WjGPsCxFzlFhyvY1K3Ti9vRRXzWdKCTA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbeamucfs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 18:51:18 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8dc607c8a54so52875116d6.2
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 11:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783882274; x=1784487074;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6ybGwtJxVoLsGbIz4zDAwjLEaQt50o/EbJNH6JOGvd4=;
 b=a0dYkYD75TNsSE4nH06lx8tQBzF58X46XOowks7NdYM87lNSDJ6EcjhD8HMo/ArhmC
 jGGrVIhLXmSOhrXiyoxvQhoh5vt1b0/FI7nrtFidYhiyOwz5ofSx5txHda8DPPGFK1Jg
 EnJl361UZPNSgd15Co2zotmEQwx2fcxXIEXucwRhVUvgV8KnvS9j6Uq/3bIupqjUDAK4
 W5nISIJzflx7poo4j+o57vZtaoCZmO3GYMiRVFXcalEZfJo12kw3gqBoU4RiuCCpfR7H
 iQapmJWxsoD2lM3wj/OYdTj21ZTgwf1W0nahiUqyVINI9wqvrKrcwx0YxQH+eYbAcVKG
 B0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783882274; x=1784487074;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6ybGwtJxVoLsGbIz4zDAwjLEaQt50o/EbJNH6JOGvd4=;
 b=a8Loqk7csOZt0h98BEZD/OWm+pgbI4SIludyDjo3pR9WrG64cnFISAdSyuFSyhATKe
 gZN+skQ4AQ9GhSlCUdMHVH67G7nPUwRFMuzCygjYHrpMFvBJimtNf0+WMaycQy/B5Yfz
 QnQIPsUoCeWy2hm9RYNrvJfLhHvQcv8jrTHFEEX+mDFkxoVkVbR5Yp5Vf/qtr3KMCNLP
 trOLkSP0k11xEWcY/y1qVQQ+9Tx9ctz3kYJuiYg0s3rJtmriWSwplxVfferw+cLgZl+y
 m+PnQYmT0MQR/km2dqp6xFf/uCDNDIrx8sr7KUrsgNT6d8HgGR9NehK6dfug++ToEO+5
 /wPw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoXu7eiTpoSwFMFDEwPRqzEfvQYjQqKobaWqBBjePTPDmkNFnigfKcgV+0fIrxVAdodayCU4NXdRd0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YybFoUKRNHFko/kjUgNOt2UvmuQw5qMuBeOYHQCCtnBBWBJEInK
 qINadWxHjxfSFIaRjvCx52A4Lqm0FuoB3ERpdiopmzniB7g2NAo0vIXgAFVztMgjFkzXWzPh03q
 Z0V76zrGZfffFvSNmyS4IRkgJaHvfo7gZsBfK2Sb6sb9SXntvwRubE3OPP+RXuzBMC8h6PKs=
X-Gm-Gg: AfdE7cnJrpg6AdR95Dx3Y55FtRsnXb0gYDDyMLf65c+nicyOdRkGFjF7DgTUv9Bd0Wq
 fQCKCYlsxsKTh5A+w0G6CSmcuZXZ4tV6B54xmi07xeOmWXBzTRuPEpQp1csFYwkT2WSp7lq0QtH
 SuiSofivOLSQMy8zz05vOffukPgnQXu+tWMFTtLLaCUTd0utYPUrLZmEqmtGtCJkFYIShQg3tPE
 knlwV1TjpUtuW+wZklZKWuL8HSk0JA9zIbo74JqhIWpWfgwm2dEgKk9TT/pH8NukNi6m5xcJVqp
 Q7NBxutnKMLSmuqNfaxsPYMkd+3N8a6QC/pzD8aCEsg/Jjc1+pFH0TyWkPm/YxVlOqQGnx4Ykqy
 8dU4T0D77m8M9vZoYiZcautNbPE3o50JsSNTRoYdNSmAxlyyC4c+tUqb0xaTjsI36na7NFZ9tLI
 RIkATdlCC5NFiCysaNyO0LwYok
X-Received: by 2002:ad4:5c64:0:b0:8db:dd:4d85 with SMTP id
 6a1803df08f44-903ffc6200amr71608356d6.26.1783882273871; 
 Sun, 12 Jul 2026 11:51:13 -0700 (PDT)
X-Received: by 2002:ad4:5c64:0:b0:8db:dd:4d85 with SMTP id
 6a1803df08f44-903ffc6200amr71608106d6.26.1783882273348; 
 Sun, 12 Jul 2026 11:51:13 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b01caaf468sm2232344e87.68.2026.07.12.11.51.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 11:51:10 -0700 (PDT)
Date: Sun, 12 Jul 2026 21:51:07 +0300
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
Subject: Re: [PATCH RESEND v5 13/25] drm/msm/dp: replace power_on with
 active_stream_cnt for dp_display
Message-ID: <mys3u23vp6oi46djrj7lgp2bpmdlzaa6trmcmcprk7ws26ffx2@jzxkindvhuu7>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
 <20260629-msm-dp-mst-v5-13-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-msm-dp-mst-v5-13-2ed6aee1867a@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDIwMiBTYWx0ZWRfX5Lt6qM7QPW/U
 9h2FUMNYhIequX3R+EYU/5IwNBgyCadkLUinTu8JLFlbC495hWT8R+V55cOr3DymZjfV6cssgSX
 RWoG4C0hXThyvSEPewmeGMxqsUFR2yo=
X-Proofpoint-GUID: qaRpdQdc1-LGUEDNHeD5emKlyy33MDiP
X-Proofpoint-ORIG-GUID: qaRpdQdc1-LGUEDNHeD5emKlyy33MDiP
X-Authority-Analysis: v=2.4 cv=dJSWXuZb c=1 sm=1 tr=0 ts=6a53e226 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=h03MF1EKYocQkuxwdUYA:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDIwMiBTYWx0ZWRfX5Cp8fE7aCJVQ
 mliB6OjLUY4PDbZ8oQXXPUYegbDmM9nf7wAg9vD/Tu4sojfPi8qPyPWnrgqAYNaYzSMgDJaTvUu
 f4gHywOuf6IjiALcJUY7E61++Ey7tnl0kWNqGT5d1rMBSQJO/Ja+nWe6OkCnX6tU4thRQqZe+BZ
 CXIWzMZBV8EFyuLjDKNiUXztMEQ8DtwtcRllXcIhHR6G5lo2vF3rG2HUBQPidwV3YDnnwDQyZKN
 owWJ3Cyp7UXWcp6arllAxyEnp9uX5prTcvn+6DsxDfucU7ys/VVLnJWJV46RQ+A/mvXckiwRdcU
 X05v0gGsKrfh/btN2LtglLK3ndTBqCtgN25Jb6UlnZZ0cx/3+K/a/gKBT+baSWRKWrK+0h68KkG
 zHIDnAM82CTPEuKXM0AJtZV9DEcWPpvWAyCcAiBF7zaXrV6sUq+9njg3izmFGmAFO/BBvvoKSR7
 xGiSnupwSJgnrfBqAsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120202
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

On Mon, Jun 29, 2026 at 10:14:34PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> For DP MST, the link clock and power domain resources stay on until
> both streams have been disabled OR we receive hotplug. Introduce an
> active_stream_cnt to track the number of active streams and necessary
> state handling. Replace the power_on variable with active_stream_cnt
> as power_on boolean works only for a single stream.

Last two phrases are redundat. Drop the "Introduce..." one.

> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_audio.c   |  2 +-
>  drivers/gpu/drm/msm/dp/dp_display.c | 28 +++++++++++++++++-----------
>  drivers/gpu/drm/msm/dp/dp_display.h |  2 +-
>  3 files changed, 19 insertions(+), 13 deletions(-)
> 
> @@ -670,14 +670,10 @@ static int msm_dp_display_enable(struct msm_dp_display_private *dp,
>  	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
>  
>  	drm_dbg_dp(dp->drm_dev, "sink_count=%d\n", dp->link->sink_count);
> -	if (msm_dp_display->power_on) {
> -		drm_dbg_dp(dp->drm_dev, "Link already setup, return\n");
> -		return 0;
> -	}
>  
>  	rc = msm_dp_ctrl_on_stream(dp->ctrl, msm_dp_panel, msm_dp_display->mst_active);
> -	if (!rc)
> -		msm_dp_display->power_on = true;
> +
> +	msm_dp_display->active_stream_cnt++;

Current power_on prevents from calling msm_dp_ctrl_on_stream() several
times. How is it prevented after the change?

>  
>  	return rc;
>  }
> @@ -726,14 +722,14 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp,
>  {
>  	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
>  
> -	if (!msm_dp_display->power_on)
> +	if (!msm_dp_display->active_stream_cnt)
>  		return 0;
>  
>  	msm_dp_panel_disable_vsc_sdp(msm_dp_panel);
>  
>  	msm_dp_ctrl_off_pixel_clk(dp->ctrl, msm_dp_panel->stream_id);
>  
> -	msm_dp_display->power_on = false;
> +	msm_dp_display->active_stream_cnt--;
>  
>  	drm_dbg_dp(dp->drm_dev, "sink count: %d\n", dp->link->sink_count);
>  	return 0;
> @@ -850,10 +846,10 @@ void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp)
>  	 * if we are reading registers we need the link clocks to be on
>  	 * however till DP cable is connected this will not happen as we
>  	 * do not know the resolution to power up with. Hence check the
> -	 * power_on status before dumping DP registers to avoid crash due
> +	 * active_stream_cnt status before dumping DP registers to avoid crash due
>  	 * to unclocked access
>  	 */
> -	if (!dp->power_on)
> +	if (!dp->active_stream_cnt)
>  		return;
>  
>  	msm_disp_snapshot_add_block(disp_state, msm_dp_display->ahb_len,
> @@ -1535,6 +1531,11 @@ void msm_dp_display_disable_helper(struct msm_dp *msm_dp_display,
>  
>  	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>  
> +	if (!msm_dp_display->active_stream_cnt) {
> +		drm_dbg_dp(dp->drm_dev, "no active streams\n");
> +		return;
> +	}

If you get here, there was at least one active stream, wasn't it?

> +
>  	msm_dp_ctrl_push_vcpf(dp->ctrl, msm_dp_panel);
>  	msm_dp_ctrl_mst_stream_channel_slot_setup(dp->ctrl);
>  	msm_dp_ctrl_mst_send_act(dp->ctrl, msm_dp_panel);
> @@ -1555,6 +1556,11 @@ void msm_dp_display_unprepare(struct msm_dp *msm_dp_display)
>  
>  	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>  
> +	if (msm_dp_display->active_stream_cnt) {
> +		drm_dbg_dp(dp->drm_dev, "stream still active, return\n");
> +		return;

Why?

General comment. You are not just replacing power_on with
active_stream_cnt. You are also introducing sequence changes, but it is
not covered in the cover letter. It's not clear, why those changes are
legitimage or why they are required.

> +	}
> +
>  	/* dongle is still connected but sinks are disconnected */
>  	if (dp->link->sink_count == 0)
>  		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
> index 55ffa22bb233..75dc40261723 100644
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
