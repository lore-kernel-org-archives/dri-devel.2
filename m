Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C181C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 11:29:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9C2410E411;
	Sun, 12 Jul 2026 11:29:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YrgdK+nk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JhLEwJbz";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D34E810E42F
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 11:29:52 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66CAcAl32288195
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 11:29:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=NJqKheitt0CbJtV6HD5tfRQh
 VctqIRlGE8KiPOVCuY4=; b=YrgdK+nk+ilyfj9si/Aw10u2AiG+SHly7TF3/A5Y
 54ZSLK8fCB+rPt49q0lq5G6Sto1EqNE2DMruG3x6mbqZstWzxLv/+mSCRYiv/wqL
 Sawftbz4/KSw2DcFk4+n3lx3Hj8KLl5GG3R/0CwGhPSDTaXAI9wKYJRkOC0NNIpW
 mgQbyjGE+LsTlXhbzJILs9pEX4PIuYGab14gQcYhWdi+kwmVS9F6ynIQ5XdlA5Kt
 WOIFuVMBPSDq6AXQwh2NVruJ6ioD3j5NSndgaEC6uFnhkKlRi4VlujkDqWVFktyA
 eUtLs4ia/7DRgJVY/getj7Pc1CfEUjTe4Kfvsh580hdz4Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbe912pt3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 11:29:51 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1a9764f0so32383191cf.1
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 04:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783855791; x=1784460591;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NJqKheitt0CbJtV6HD5tfRQhVctqIRlGE8KiPOVCuY4=;
 b=JhLEwJbznOUAFcIFrT+MBGTD4mAoB4PkxZguQkzLr7B4HT23S/qbxxzNS55Se6bwty
 H1z/ry9SUU8u8JB8G9d5ClW6WR5/+T8xnfk0tZzPAY6Ka36k7WaCa90B+vqYTk+idbIK
 5xbggZ0EMYQp0ib1G4CBJTWG713u1yhYC53PUhvEZi554l2prODcuK6+yruSLoeHCDyp
 Zf9FN20nNFprtqD8RaBwYoytxkdsQXrX7/udA/2I8N4FmwpTa3ppVafX34CqA6sYKdML
 +ByW5K6kep7mtV3BhBkyWnezx2Om5sazz3U5FPkOzz00HuoAcAGUqlfD//2ltCF9lGk8
 TpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783855791; x=1784460591;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NJqKheitt0CbJtV6HD5tfRQhVctqIRlGE8KiPOVCuY4=;
 b=nkGO5iKiZgWTaXrvXLXIz58GstbmBUl7689VGSVGBGSUw+Pm7I7fgSb06X6aaWLYdb
 UjORMnDDKVY58wycaPUc3t8O+sHw79PQrbVcJ8XOb/KtWvOh5mWnoSXx3qYmbbGqhGgD
 mCL6i5gVP/Bk/4sAkNfoIaH8Btj9RYvrpbeJsB+thGkAz9GIw+5iyThVGpbFGC9WCc6n
 V+a6eqpmdqt/rksMFyZBIQpQSqErRGb07QEV2lAr3d4Lq/gnkkO9Y7TA5XLe4r6yzBIW
 nrwkLtO08Jq7hmm2lr4JxZglGqr7HhacOizM1tyNsSkQqcArYEJWX7PclXVVuEjlFhUM
 8c7g==
X-Forwarded-Encrypted: i=1;
 AHgh+RplBp7igeTCSQgvpTbiHiMJ0VYYv+uFjfiND29GX68fvdZx8xKtjYLRLdYhpULB53uCJy5a8xLM38Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyBetK7mwia4a5jEFD8ohoLLRSJl4wNk/psVbavCVGG/fjY5I+x
 N3mngAq2RB2Q2S75RgTlTlosvoxEiM+xhEbCXvFZ67oLJKf1L3F3mgLdKXNvn1Nr0BWkszxlDQl
 VW/gTik5JJEB1S6aIHKfHxfvC7hGQdXXkM1TE/utFifuBR1pvNzBWPHJ5hom69F8kuS2hgYM=
X-Gm-Gg: AfdE7cmVxdwnkft5dKJGbAOtGX89Sw1J4TgVggA6PgY8bJ1dOnC/5co6x3EtyRm+eGl
 Lzd7dzWCaAL9I4wbkopCqFnHXhMOExK5UpuZE+ttUXhdSXKPp90tM2DzBps/96mxRQxSzbtoiGC
 /O/aR30cMTo/+qEZ9E22abfeNDI/nduaOzm1WYmPZ6VxmXdTiFy1oN/gVe0qNbdH7Ro9++O1Tmy
 RJuylNfsgpZfwZFIXgKKydXIrFZkeEMShn3Di+YS6fa6z/pIjSgdWKRPmHksaliOLwKzYQzQ5eu
 6P8ySm3zP6/muF5LVm5UCv4swM3Hpc6ajmHXsdZyCTxcrz/mAsnRH60D+zLeYcd8i9Xvxsg2m4j
 a+qhnzZyfhqplNhM04I6yDaWUcaqefCd/dwuy9r855+692x3edFy6AxgjHqC3iLKCT9mr2VQe34
 DTz4xmdxv7mZw2b4PV0OCOF+6J
X-Received: by 2002:a05:622a:1e18:b0:51c:2075:afd5 with SMTP id
 d75a77b69052e-51cbf3953eamr52652911cf.72.1783855791104; 
 Sun, 12 Jul 2026 04:29:51 -0700 (PDT)
X-Received: by 2002:a05:622a:1e18:b0:51c:2075:afd5 with SMTP id
 d75a77b69052e-51cbf3953eamr52652671cf.72.1783855790642; 
 Sun, 12 Jul 2026 04:29:50 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b01caa66c0sm2061980e87.63.2026.07.12.04.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 04:29:48 -0700 (PDT)
Date: Sun, 12 Jul 2026 14:29:46 +0300
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
Subject: Re: [PATCH RESEND v5 04/25] drm/msm/dp: use stream_id to change
 offsets in dp_catalog
Message-ID: <bwfue53sy36k2alsozqyaqcibgx4kd5pvocpudx6lwdtn6bqka@nmd3lse72s4c>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
 <20260629-msm-dp-mst-v5-4-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-msm-dp-mst-v5-4-2ed6aee1867a@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=TbymcxQh c=1 sm=1 tr=0 ts=6a537aaf cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=DasGs9TxgNvWK3_s-EwA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDExOSBTYWx0ZWRfX7BpKv/VHuUVw
 j+kdHcrmb4v8NsEYx5AXTj8jnjL0UugMDooGv1wFRihoicwL4EzonhrbYKJUUaC18rKaZci0Hsg
 QFxmW1adX/+FsC5o0+RGVSDcRdskZ78=
X-Proofpoint-GUID: YZf4ES_WbsrMG_6couQCM4taIZ3DVu_T
X-Proofpoint-ORIG-GUID: YZf4ES_WbsrMG_6couQCM4taIZ3DVu_T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDExOSBTYWx0ZWRfX9dhbGATZObXP
 pzLkzYB1+E/NAmx/iCQAXlqhxXI4O8U8dvBTamAIK7CP6gV8Ksii6aG7QjYrqBQpfngC8fPBiEE
 OkkzXTlqVa8esDasKzI7B0J6kMpo6xjaM5CO0yBe/AS79mbefPig0NRZE2B+Z2G9rWCeAQC1Fyu
 +MKhMC/r+KxlrU13vGmvVF5aYln9M6tgutjR6uv8RJdDJHotk2UY6++wzVSd0gw7RwYJIOaleUJ
 g8JVP3uwepXunpFCHVB+GPTfV8tX912ziDhvxZlFEuu56I8u9AZpD4FmKqj71DQ4IJsEi+6Hp65
 u35Yx7jngFPVUCuRhw0RpJLBvlxSUCLosPjRGfJ7t78e/h50ZbXu332cZzvTN8nctsDSpA9Zqov
 SPEJEa6OzUMzad6IvXGvV7t0POAK1wsZj7fzLOb2dLzOHRANWue+oVAmUBDZ/Vmj8+OwfROonnP
 UbrA1ziPUMrLv2GXuDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120119
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

On Mon, Jun 29, 2026 at 10:14:25PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> In the DP MST architecture, stream 1 shares the same link clock as
> stream 0 but uses different register offsets within the same link
> register space. Use the dp_panel's stream_id to select the correct
> register offsets for stream 1 in dp_catalog. Also add stream 1
> register defines.
> 
> Streams 2 and 3 are not covered here, as they use separate link clocks
> and require separate handling.

I think, this is no longer true. I see them being handled here.

> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 78 ++++++++++++++++++++++++------
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |  4 +-
>  drivers/gpu/drm/msm/dp/dp_display.c | 24 +++++++++-
>  drivers/gpu/drm/msm/dp/dp_panel.c   | 94 ++++++++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/msm/dp/dp_panel.h   |  4 ++
>  drivers/gpu/drm/msm/dp/dp_reg.h     | 44 +++++++++++++++++
>  6 files changed, 229 insertions(+), 19 deletions(-)
> 
> @@ -397,7 +442,8 @@ static void msm_dp_ctrl_config_ctrl_streams(struct msm_dp_ctrl_private *ctrl,
>  	/*
>  	 * RMW: Called from atomic_enable(). Serialized by the DRM atomic framework.
>  	 */
> -	config = msm_dp_read_link(ctrl, REG_DP_CONFIGURATION_CTRL);
> +	if (msm_dp_panel->stream_id == DP_STREAM_0)
> +		config = msm_dp_read_link(ctrl, REG_DP_CONFIGURATION_CTRL);

Why is it being done only for stream 0?

>  
>  	if (msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420)
>  		config |= DP_CONFIGURATION_CTRL_RGB_YUV; /* YUV420 */
> @@ -412,7 +458,7 @@ static void msm_dp_ctrl_config_ctrl_streams(struct msm_dp_ctrl_private *ctrl,
>  
>  	drm_dbg_dp(ctrl->drm_dev, "stream DP_CONFIGURATION_CTRL=0x%x\n", config);
>  
> -	msm_dp_write_link(ctrl, REG_DP_CONFIGURATION_CTRL, config);
> +	msm_dp_write_stream_link(ctrl, msm_dp_panel->stream_id, REG_DP_CONFIGURATION_CTRL, config);
>  }
>  
>  static void msm_dp_ctrl_config_ctrl_link(struct msm_dp_ctrl_private *ctrl,
> @@ -2514,7 +2560,7 @@ static void msm_dp_ctrl_config_msa(struct msm_dp_ctrl_private *ctrl,
>  		nvid = temp;
>  	}
>  
> -	if (is_ycbcr_420)
> +	if (panel->msm_dp_mode.out_fmt_is_yuv_420)

Unrelated change.

>  		mvid /= 2;
>  
>  	if (link_rate_hbr2 == rate)
> @@ -2524,8 +2570,8 @@ static void msm_dp_ctrl_config_msa(struct msm_dp_ctrl_private *ctrl,
>  		nvid *= 3;
>  
>  	drm_dbg_dp(ctrl->drm_dev, "mvid=0x%x, nvid=0x%x\n", mvid, nvid);
> -	msm_dp_write_link(ctrl, REG_DP_SOFTWARE_MVID, mvid);
> -	msm_dp_write_link(ctrl, REG_DP_SOFTWARE_NVID, nvid);
> +	msm_dp_write_stream_link(ctrl, panel->stream_id, REG_DP_SOFTWARE_MVID, mvid);
> +	msm_dp_write_stream_link(ctrl, panel->stream_id, REG_DP_SOFTWARE_NVID, nvid);
>  }
>  
>  int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl,
> @@ -2597,14 +2643,14 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
>  
>  	msm_dp_ctrl_lane_mapping(ctrl);
>  	msm_dp_setup_peripheral_flush(ctrl);
> -	msm_dp_ctrl_config_ctrl_link(ctrl, panel);
> +	if (panel->stream_id == DP_STREAM_0)
> +		msm_dp_ctrl_config_ctrl_link(ctrl, panel);

Why is it only done for stream 0? Split all unrelated changes.

>  
>  	msm_dp_ctrl_configure_source_params(ctrl, panel);
>  
>  	msm_dp_ctrl_config_msa(ctrl,
> -		ctrl->link->link_params.rate,
> -		pixel_rate_orig,
> -		panel->msm_dp_mode.out_fmt_is_yuv_420);
> +		panel, ctrl->link->link_params.rate,
> +		pixel_rate_orig);
>  
>  	msm_dp_panel_clear_dsc_dto(panel);
>  
> diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
> index 3689642b7fc0..310e5a1cc934 100644
> --- a/drivers/gpu/drm/msm/dp/dp_reg.h
> +++ b/drivers/gpu/drm/msm/dp/dp_reg.h
> @@ -332,6 +332,50 @@
>  #define DP_TPG_VIDEO_CONFIG_BPP_8BIT		(0x00000001)
>  #define DP_TPG_VIDEO_CONFIG_RGB			(0x00000004)
>  
> +#define REG_DP1_CONFIGURATION_CTRL		(0x00000400)
> +#define REG_DP1_SOFTWARE_MVID			(0x00000414)
> +#define REG_DP1_SOFTWARE_NVID			(0x00000418)
> +#define REG_DP1_TOTAL_HOR_VER			(0x0000041C)

lowercase hex. Also are there no registers from the same register space?

> +#define REG_DP1_START_HOR_VER_FROM_SYNC		(0x00000420)
> +#define REG_DP1_HSYNC_VSYNC_WIDTH_POLARITY	(0x00000424)
> +#define REG_DP1_ACTIVE_HOR_VER			(0x00000428)
> +#define REG_DP1_MISC1_MISC0			(0x0000042C)
> +#define MMSS_DP1_GENERIC0_0			(0x00000490)
> +#define MMSS_DP1_GENERIC0_1			(0x00000494)
> +#define MMSS_DP1_GENERIC0_2			(0x00000498)
> +#define MMSS_DP1_GENERIC0_3			(0x0000049C)
> +#define MMSS_DP1_GENERIC0_4			(0x000004A0)
> +#define MMSS_DP1_GENERIC0_5			(0x000004A4)
> +#define MMSS_DP1_GENERIC0_6			(0x000004A8)
> +#define MMSS_DP1_GENERIC0_7			(0x000004AC)
> +#define MMSS_DP1_GENERIC0_8			(0x000004B0)
> +#define MMSS_DP1_GENERIC0_9			(0x000004B4)
> +#define MMSS_DP1_SDP_CFG			(0x000004E0)
> +#define MMSS_DP1_SDP_CFG2			(0x000004E4)
> +#define MMSS_DP1_SDP_CFG3			(0x000004E8)
> +
> +#define REG_DP_MSTLINK_CONFIGURATION_CTRL	(0x00000034)
> +#define REG_MSTLINK_SOFTWARE_MVID		(0x00000040)
> +#define REG_MSTLINK_SOFTWARE_NVID		(0x00000044)

Why are they not REG_DP_MSTLINK?

> +#define REG_DP_MSTLINK_TOTAL_HOR_VER		(0x00000048)
> +#define REG_DP_MSTLINK_START_HOR_VER_FROM_SYNC	(0x0000004C)
> +#define REG_DP_MSTLINK_HSYNC_VSYNC_WIDTH_POLARITY	(0x00000050)
> +#define REG_DP_MSTLINK_ACTIVE_HOR_VER		(0x00000054)
> +#define REG_DP_MSTLINK_MISC1_MISC0		(0x00000058)
> +#define MMSS_DP_MSTLINK_GENERIC0_0		(0x000000BC)
> +#define MMSS_DP_MSTLINK_GENERIC0_1		(0x000000C0)
> +#define MMSS_DP_MSTLINK_GENERIC0_2		(0x000000C4)
> +#define MMSS_DP_MSTLINK_GENERIC0_3		(0x000000C8)
> +#define MMSS_DP_MSTLINK_GENERIC0_4		(0x000000CC)
> +#define MMSS_DP_MSTLINK_GENERIC0_5		(0x000000D0)
> +#define MMSS_DP_MSTLINK_GENERIC0_6		(0x000000D4)
> +#define MMSS_DP_MSTLINK_GENERIC0_7		(0x000000D8)
> +#define MMSS_DP_MSTLINK_GENERIC0_8		(0x000000DC)
> +#define MMSS_DP_MSTLINK_GENERIC0_9		(0x000000E0)
> +#define MMSS_DP_MSTLINK_SDP_CFG			(0x0000010c)
> +#define MMSS_DP_MSTLINK_SDP_CFG2		(0x0000011c)
> +#define MMSS_DP_MSTLINK_SDP_CFG3		(0x00000114)
> +
>  #define MMSS_DP_ASYNC_FIFO_CONFIG		(0x00000088)
>  
>  #define REG_DP_PHY_AUX_INTERRUPT_CLEAR          (0x0000004C)
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
