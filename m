Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C63C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 00:41:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E69210E510;
	Mon, 13 Jul 2026 00:41:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oJ/sV9Av";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VmTQHTCF";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FEA810E510
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 00:41:04 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66CNUDlY3768760
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 00:41:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=GUvutyOUs+GCmsdemuu4iFoI
 ay/WrjQfjnsdsXNUmPo=; b=oJ/sV9Av0yytbPPHNsyJuXtIR6E1XIhBb0Jda2W3
 w3Rc9pksRBn2m6V/6PMPaDUo2Plyr6lNH0WkmH2zgEp4XqqOMC8t7GydzPvEVibH
 898FP9v65TExKh8qSG0Tcn/MHfnIyr5HfHG62Icrs7J7eIE+xYGRmOI/fwPtzke5
 EL2olGYheL2c9EXeT0B+2skNs1+yFD8DlCcTPkURyNheteDm+YMPWIM+lEaxLg/f
 a1OzfBGbEVLZY+zXxmkqzbbRTDHdmrUPgIuMdkabLOZCpkoBROrleVgZIHSZy0cr
 VgFxEwfD+sd6aqTocflRp/VF0/jmTNZ886szgv362JNXqg==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbf483pd8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 00:41:03 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5c0fd6e8385so114466e0c.0
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 17:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783903263; x=1784508063;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GUvutyOUs+GCmsdemuu4iFoIay/WrjQfjnsdsXNUmPo=;
 b=VmTQHTCFrJ9UGFJOPWpJkV9LQzBw1Ud746/8hfOfTziLtwDFwIezUXs9pujEnl3Klo
 rJQnitlP/gjfR3dXE8c8yhYIZQBh41MoNmRBGOxdQPZhH3x96GGmb1ZPhCShlXGBeglD
 AGE2FduUQDJGfOjX13RXzR+OBmnyAm4L1i+bu7bvX2mCLcCDt7YIi2lg0DzHfNPWD3PH
 DOTDvBQC/KesUDn9VMWSMl+C4hhJKV5DxaVNNf6Ae8RLsO+jMRy/pnn5M8iCAt45k7YM
 lxv98mFqzu5e886pu8ghZIjTP/fiuyxB92/fYjDJFuxYUYRgkbzdsPCT8AKVU5ssgVpS
 Sw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783903263; x=1784508063;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GUvutyOUs+GCmsdemuu4iFoIay/WrjQfjnsdsXNUmPo=;
 b=KrWelULrAKDvXYIZHXVXiOQHwYFp25xU8ndvDnvmpJNxmadhSnCdRbHXJN/NjCmmqi
 xlwHmzvpQQCCuR4wqdKVl69LZJPlhOLOUDXskD6GtAvWB33ROMeMTj//BaCrtQ/5ixaz
 CExnRcaJEiggvUF6TMksWtAeUYvcKVa836nJ3FVr3dWvEx4jIIZg4Kl4+o3ooHcu58XZ
 WIHVExqVTHefME+7XwpyI8idk03jD8qH9+E+JDeTsvg4lEkOfPyTrlHH9Ywz5l0sG0DH
 +sq9nEvVXfjr5W2LIh2sOElTvhEXNjNoEklNN0imKnD2xSmHrShGXl/+XERZxGR3acBM
 hiJg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpq+Gcgfy0qeLQ/aXVUNdI8CaonKW3zLCcgrTc+7CbShOEdqGeV2zmRdxp37g3SELhwHp7zWa4+9AY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyAEdZ7nZibxa7M4uYKD4tQcJH5+X7LLR0QKejLs4wEGdlGLnzf
 VM9Wi6feAeid4XoNsizIbOIhlojElAQtRqgVkP4ct08X4mjdVgpnN8RX8QasFq8jnfTRNmDYYt8
 G2ZwMeDFgI9il199ewkbHXZ981jmUSXggv6L2rjFUz2HxzyTPrfwC2adDirm7dxBw1bvS8lk=
X-Gm-Gg: AfdE7cmnzD0rOaGgU5mBtI+51uQ3wzp8dFKiIJ6WuKC8JEZ3ANTJVVveBOvHvLhqWIv
 pa49Bc90D5EGlm9jQXb72ytCEbw7JxKH4dP0gs7AtgRCZS2qzgQ83KGQWDDUoBqxVKB9vMrG8sZ
 sUQkJFb+w2BAHd/lkEP2FnzZT1FEVCU1bNl/HRFGHOYLtyIXVn7z7eVYAsMov9EFIsI4lZqFHoS
 XsecV/Yic3WRy8fEtZ3FSADJrYKhL6j7uvaP+yDARqF1E7KyC/zKEtPcXSCW5v+Meia7MF25xMM
 Ewq547WQE7+TIVYFl5sEw7ViTxLjKfxTajceAasif/ULLA0R77sb6RnAl63QAhn3ds99kCcJ3ao
 6xs7Fjbj+/aIFrOIMK+fVUh3p/LP+hC+eNsEE0nSJUjB+V3yUlzjyZrueh+5BZJrTuvsWqF3OJx
 mPoMwl/EGN2VK0wLIy5YaOK7NF
X-Received: by 2002:a05:6122:46a6:b0:5bd:81fc:ebe9 with SMTP id
 71dfb90a1353d-5bfbed60862mr4254392e0c.0.1783903262633; 
 Sun, 12 Jul 2026 17:41:02 -0700 (PDT)
X-Received: by 2002:a05:6122:46a6:b0:5bd:81fc:ebe9 with SMTP id
 71dfb90a1353d-5bfbed60862mr4254382e0c.0.1783903262132; 
 Sun, 12 Jul 2026 17:41:02 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39c84b9382esm23519261fa.29.2026.07.12.17.40.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 17:40:59 -0700 (PDT)
Date: Mon, 13 Jul 2026 03:40:56 +0300
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
Subject: Re: [PATCH RESEND v5 23/25] drm/msm/dp: add dp_mst_drm to manage DP
 MST encoder operations
Message-ID: <z3eqtcsn43bjlnyqarrclyuukg54wzl2pmtd4sosr6ske4scqq@vrdyrare46hr>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
 <20260629-msm-dp-mst-v5-23-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-msm-dp-mst-v5-23-2ed6aee1867a@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDAwNCBTYWx0ZWRfX1PuXN7E3ILez
 4/hF+MEk/Ie6mmBqqeQqEByzZRiNkTmXNCsEox+1+AQdtsHIySGaCpOwHfrqXTMNzEUXHzSpUuL
 tgaT/0+1Ht/2eHVBgEnLzSHlCZ+6F4Q=
X-Authority-Analysis: v=2.4 cv=OsJ/DS/t c=1 sm=1 tr=0 ts=6a54341f cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=Qa1uvHET9vThtx77QJEA:9 a=CjuIK1q_8ugA:10
 a=hhpmQAJR8DioWGSBphRh:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDAwNCBTYWx0ZWRfX4OD2hiz6ixUK
 qViRy7sxpgWltWkpRsH/4yzXjCO8IjHIU2CcFA6pfAwwa4qzcAnsptijpV9lCOqksxWxG2XJLGN
 ZktJUPuS3dBD71OXXM7bkFxLZ/VB22+51HDZhzbqkkKqTQFzRHh/EdS+u5mkkla0SIBZDmX/Z+8
 Pr3GubF0X1tM3KJs0xTJ1FnK2kNZw6Uvv615jQb1ctQru//izIUZQp4UKroVTE8fOVRT0eqpm1h
 A0i03zcF6hxFED8WJ4vQjfZ6n7IzcGh8YRpfHLyfXK8CuVGMFA85nj8gbK7KHS45C6sx/bABs9y
 u/kDXPdcJgMVI391NbnW3WYL0Dftwg4ayVvPFl28NdAwG7dmOQKnK/R9seUumsLTjoIYENUOCVr
 S9rWaTuW2vSAb4KcOGPgdyyr6Ab9t9pTrjQLQXvw4zySee3MyIj622b8u2qqTvdSt3lxKWriJuc
 t2q6mv+8NpJrQncvsgg==
X-Proofpoint-GUID: GXX59Zql6YF2jAa5qCIhXg2hy3iOerL8
X-Proofpoint-ORIG-GUID: GXX59Zql6YF2jAa5qCIhXg2hy3iOerL8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_08,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130004
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

On Mon, Jun 29, 2026 at 10:14:44PM +0800, Yongxing Mou wrote:
> drm/msm/dp: introduce dp_mst_drm for MST stream management

duplicate subject?

> 
> Add a dp_mst_drm layer to manage DP MST streams with a clear ownership
> model between encoder, panel and connector.
> 
> Each MST stream is represented by a dedicated drm_encoder. At modeset
> initialization time, one (encoder, dp_panel) pair is created per
> stream_id and remains fixed for the lifetime of the driver. The
> dp_panel thus carries a stable stream context, including stream_id
> and pixel mapping.
> 
> MST connectors are created and destroyed dynamically on hotplug and
> are attached to a dp_panel through atomic routing. During an atomic
> commit, connectors are associated with encoders via
> atomic_best_encoder(), forming a temporary binding for the duration
> of the commit.

This doesnt't seem to be true any longer.

> 
> Encoder helper callbacks drive the MST stream lifecycle, including
> timeslot allocation, link enable/disable and payload programming.
> 
> A per-MST-instance lock serializes operations on shared link state
> across multiple streams.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c |   6 +
>  drivers/gpu/drm/msm/dp/dp_display.c     |   9 ++
>  drivers/gpu/drm/msm/dp/dp_display.h     |   2 +
>  drivers/gpu/drm/msm/dp/dp_mst_drm.c     | 245 ++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/msm_drv.h           |   7 +
>  5 files changed, 269 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index b32ecd5b0777..ac5dc844fead 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -696,6 +696,12 @@ static int _dpu_kms_initialize_displayport(struct drm_device *dev,
>  					DPU_ERROR("encoder init failed for dp mst display\n");
>  					return PTR_ERR(encoder);
>  				}
> +
> +				rc = msm_dp_mst_attach_encoder(priv->kms->dp[i], encoder);
> +				if (rc) {
> +					DPU_ERROR("dp_mst attach_encoder failed, rc = %d\n", rc);
> +					return rc;
> +				}

Reoder, this should be a part of the patch, adding the encoder.

>  			}
>  		}
>  	}
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index fc9c1e3e57ab..6eac390af2e0 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -601,6 +601,15 @@ struct msm_dp_panel *msm_dp_display_get_panel(struct msm_dp *msm_dp_display,
>  	return dp_panel;
>  }
>  
> +void msm_dp_display_set_link_info(struct msm_dp *msm_dp_display,
> +				  struct msm_dp_link_info *dst)
> +{
> +	struct msm_dp_display_private *dp =
> +		container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
> +
> +	memcpy(dst, &dp->panel->link_info, sizeof(*dst));
> +}
> +
>  static void msm_dp_display_deinit_sub_modules(struct msm_dp_display_private *dp)
>  {
>  	msm_dp_audio_put(dp->audio);
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
> index a185819ec57e..fb6bdd372b52 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.h
> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
> @@ -63,4 +63,6 @@ void msm_dp_display_unprepare(struct msm_dp *dp);
>  
>  struct msm_dp_panel *msm_dp_display_get_panel(struct msm_dp *msm_dp_display,
>  					      enum msm_dp_stream_id stream_id);
> +void msm_dp_display_set_link_info(struct msm_dp *msm_dp_display,
> +				  struct msm_dp_link_info *dst);
>  #endif /* _DP_DISPLAY_H_ */
> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> index 78b8dffe111b..6a77fdef85e9 100644
> --- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> @@ -4,18 +4,259 @@
>   */
>  
>  #include <drm/drm_edid.h>
> +#include <drm/drm_fixed.h>
> +#include <drm/drm_atomic_helper.h>
>  #include <drm/display/drm_dp_mst_helper.h>
>  
>  #include "dp_mst_drm.h"
>  #include "dp_panel.h"
> +#include "dpu_encoder.h"
> +
> +#define to_dp_mst_connector(x) \
> +		container_of((x), struct msm_dp_mst_connector, connector)
> +
> +struct msm_dp_mst_encoder {
> +	struct drm_encoder *enc;
> +	int stream_id;
> +	struct msm_dp_panel *dp_panel;
> +};
> +
> +struct msm_dp_mst_connector {
> +	struct drm_connector connector;
> +	struct drm_dp_mst_port *mst_port;
> +	struct msm_dp_mst *dp_mst;
> +};
> +

Extra empty line.

>  
>  struct msm_dp_mst {
>  	struct drm_dp_mst_topology_mgr mst_mgr;
> +	struct msm_dp_mst_encoder mst_encoders[DP_STREAM_MAX];
>  	struct msm_dp *msm_dp;
>  	struct drm_dp_aux *dp_aux;
>  	u32 max_streams;
> +	struct mutex mst_lock;
> +	struct msm_dp_link_info link_info;
>  };
>  
> +static struct msm_dp_panel *msm_dp_mst_panel_from_encoder(struct msm_dp_mst *mst,
> +							  struct drm_encoder *enc)
> +{
> +	int i;
> +
> +	for (i = 0; i < mst->max_streams; i++) {
> +		if (mst->mst_encoders[i].enc == enc)
> +			return mst->mst_encoders[i].dp_panel;
> +	}
> +	return NULL;
> +}
> +
> +static void msm_dp_mst_update_timeslots(struct msm_dp_mst *mst,
> +					struct msm_dp_panel *panel,
> +					struct drm_dp_mst_atomic_payload *payload)
> +{
> +	if (payload->vc_start_slot < 0)
> +		msm_dp_display_set_stream_info(mst->msm_dp, panel, 1, 0, 0);
> +	else
> +		msm_dp_display_set_stream_info(mst->msm_dp, panel,
> +					       payload->vc_start_slot,
> +					       payload->time_slots, payload->pbn);

Can you pass payload as is? Then you don't need a wrapping function.

> +
> +	drm_dbg_kms(mst->msm_dp->drm_dev,
> +		    "[MST] stream:%u timeslots vc_start:%d slots:%d pbn:%d\n",
> +		    panel->stream_id, payload->vc_start_slot,
> +		    payload->time_slots, payload->pbn);
> +}
> +
> +static void msm_dp_mst_stream_enable(struct drm_encoder *encoder,
> +				     struct drm_atomic_commit *state)
> +{
> +	struct drm_connector *connector =
> +		drm_atomic_get_new_connector_for_encoder(state, encoder);
> +	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(connector);
> +	struct msm_dp_mst *mst = mst_conn->dp_mst;
> +	struct msm_dp *dp_display = mst->msm_dp;
> +	struct msm_dp_panel *panel = msm_dp_mst_panel_from_encoder(mst, encoder);
> +	struct drm_dp_mst_port *port = mst_conn->mst_port;
> +	struct drm_dp_mst_topology_state *mst_state =
> +		drm_atomic_get_new_mst_topology_state(state, &mst->mst_mgr);
> +	struct drm_dp_mst_atomic_payload *payload =
> +		drm_atomic_get_mst_payload_state(mst_state, port);
> +	int rc;
> +
> +	panel->connector = connector;

The connector should be _get before assigning.

> +
> +	guard(mutex)(&mst->mst_lock);
> +
> +	rc = msm_dp_display_set_mode_helper(dp_display, state, encoder, panel);
> +	if (rc) {
> +		drm_err(dp_display->drm_dev,
> +			"[MST] stream:%u set_mode failed rc=%d\n", panel->stream_id, rc);
> +		goto out;
> +	}
> +
> +	rc = msm_dp_display_prepare_link(dp_display);
> +	if (rc) {
> +		drm_err(dp_display->drm_dev,
> +			"[MST] stream:%u prepare_link failed rc=%d\n", panel->stream_id, rc);
> +		msm_dp_display_unprepare(dp_display);
> +		goto out;
> +	}
> +
> +	drm_dp_mst_update_slots(mst_state, DP_CAP_ANSI_8B10B);
> +
> +	rc = drm_dp_add_payload_part1(&mst->mst_mgr, mst_state, payload);
> +	if (rc) {
> +		drm_err(dp_display->drm_dev,
> +			"[MST] payload allocation failure for conn:%d\n", connector->base.id);
> +		msm_dp_display_unprepare(dp_display);
> +		goto out;
> +	}
> +
> +	msm_dp_mst_update_timeslots(mst, panel, payload);
> +
> +	msm_dp_display_enable_helper(dp_display, panel);
> +
> +	drm_dp_check_act_status(&mst->mst_mgr);
> +
> +	drm_dp_add_payload_part2(&mst->mst_mgr, payload);
> +
> +out:
> +	drm_connector_get(connector);
> +}
> +
> +static void msm_dp_mst_stream_disable(struct drm_encoder *encoder,
> +				      struct drm_atomic_commit *state)
> +{
> +	struct drm_connector *connector = drm_atomic_get_old_connector_for_encoder(state, encoder);
> +	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(connector);
> +	struct msm_dp_mst *mst = mst_conn->dp_mst;
> +	struct msm_dp_panel *panel = msm_dp_mst_panel_from_encoder(mst, encoder);
> +	struct drm_dp_mst_topology_state *old_mst_state =
> +		drm_atomic_get_old_mst_topology_state(state, &mst->mst_mgr);
> +	struct drm_dp_mst_topology_state *new_mst_state =
> +		drm_atomic_get_new_mst_topology_state(state, &mst->mst_mgr);
> +	struct drm_dp_mst_atomic_payload *old_payload =
> +		drm_atomic_get_mst_payload_state(old_mst_state, mst_conn->mst_port);
> +	struct drm_dp_mst_atomic_payload *new_payload =
> +		drm_atomic_get_mst_payload_state(new_mst_state, mst_conn->mst_port);
> +
> +	guard(mutex)(&mst->mst_lock);
> +
> +	drm_dp_remove_payload_part1(&mst->mst_mgr, new_mst_state, new_payload);
> +
> +	drm_dp_remove_payload_part2(&mst->mst_mgr, new_mst_state, old_payload, new_payload);
> +
> +	msm_dp_mst_update_timeslots(mst, panel, new_payload);
> +
> +	msm_dp_display_disable_helper(mst->msm_dp, panel);
> +
> +	drm_dp_check_act_status(&mst->mst_mgr);
> +}
> +
> +static void msm_dp_mst_stream_post_disable(struct drm_encoder *encoder,
> +					   struct drm_atomic_commit *state)
> +{
> +	struct drm_connector *connector = drm_atomic_get_old_connector_for_encoder(state, encoder);
> +	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(connector);
> +	struct msm_dp_mst *mst = mst_conn->dp_mst;
> +	struct msm_dp_panel *panel = msm_dp_mst_panel_from_encoder(mst, encoder);
> +
> +	guard(mutex)(&mst->mst_lock);
> +
> +	msm_dp_display_atomic_post_disable_helper(mst->msm_dp, panel);
> +
> +	if (!mst->msm_dp->mst_active)
> +		msm_dp_display_unprepare(mst->msm_dp);
> +
> +	panel->connector = NULL;
> +
> +	drm_connector_put(connector);
> +}
> +
> +static int msm_dp_mst_enc_atomic_check(struct drm_encoder *enc,
> +				       struct drm_crtc_state *crtc_state,
> +				       struct drm_connector_state *conn_state)
> +{
> +	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(conn_state->connector);
> +	struct msm_dp_mst *mst = mst_conn->dp_mst;
> +	struct drm_dp_mst_topology_state *mst_state;
> +	int bpp, pbn, slots;
> +
> +	if (!conn_state->crtc)
> +		return 0;
> +
> +	if (!drm_atomic_crtc_needs_modeset(crtc_state) || !crtc_state->active)
> +		return 0;
> +
> +	bpp = (conn_state->connector->display_info.bpc * 3) ?: 24; /* fallback: assume 8bpc */
> +	pbn = drm_dp_calc_pbn_mode(crtc_state->mode.clock, bpp << 4);
> +
> +	mst_state = drm_atomic_get_mst_topology_state(crtc_state->state, &mst->mst_mgr);
> +	if (IS_ERR(mst_state))
> +		return PTR_ERR(mst_state);
> +
> +	if (!dfixed_trunc(mst_state->pbn_div)) {
> +		mst_state->pbn_div =
> +			drm_dp_get_vc_payload_bw(mst->link_info.rate,
> +						 mst->link_info.num_lanes);
> +	}
> +
> +	slots = drm_dp_atomic_find_time_slots(crtc_state->state, &mst->mst_mgr,
> +					      mst_conn->mst_port, pbn);
> +	if (slots < 0)
> +		return slots;
> +
> +	return 0;
> +}
> +
> +static void msm_dp_mst_enc_atomic_enable(struct drm_encoder *enc,
> +					 struct drm_atomic_commit *state)
> +{
> +	msm_dp_mst_stream_enable(enc, state);
> +	dpu_encoder_phys_enable(enc, state);

Looking at this, no, squashing the bridge and the encoder was not a good
idea, excuse me. The encoder is an internal implement of the DPU layer
and we should leave it there as is. DPU can use DP functions, but not
other way around.

> +}
> +
> +static void msm_dp_mst_enc_atomic_disable(struct drm_encoder *enc,
> +					  struct drm_atomic_commit *state)
> +{
> +	msm_dp_mst_stream_disable(enc, state);
> +	dpu_encoder_phys_disable(enc, state);
> +	msm_dp_mst_stream_post_disable(enc, state);
> +}
> +
> +static const struct drm_encoder_helper_funcs msm_dp_mst_encoder_helper_funcs = {
> +	.atomic_check    = msm_dp_mst_enc_atomic_check,
> +	.atomic_mode_set = dpu_encoder_atomic_mode_set,
> +	.atomic_enable   = msm_dp_mst_enc_atomic_enable,
> +	.atomic_disable  = msm_dp_mst_enc_atomic_disable,
> +};
> +
> +int msm_dp_mst_attach_encoder(struct msm_dp *dp_display, struct drm_encoder *encoder)
> +{
> +	struct msm_dp_mst *mst = dp_display->msm_dp_mst;
> +	struct msm_dp_panel *dp_panel;
> +	int i;
> +
> +	for (i = 0; i < mst->max_streams; i++) {
> +		if (!mst->mst_encoders[i].enc)
> +			break;
> +	}
> +
> +	dp_panel = msm_dp_display_get_panel(dp_display, i);
> +	if (!dp_panel) {
> +		drm_err(dp_display->drm_dev,
> +			"[MST] failed to allocate panel for stream %d\n", i);
> +		return -ENOMEM;
> +	}
> +
> +	mst->mst_encoders[i].enc = encoder;
> +	mst->mst_encoders[i].stream_id = i;
> +	mst->mst_encoders[i].dp_panel = dp_panel;
> +	drm_encoder_helper_add(encoder, &msm_dp_mst_encoder_helper_funcs);
> +
> +	return 0;
> +}
> +
>  int msm_dp_mst_display_set_mgr_state(struct msm_dp *dp_display, bool state)
>  {
>  	struct msm_dp_mst *mst = dp_display->msm_dp_mst;
> @@ -27,6 +268,9 @@ int msm_dp_mst_display_set_mgr_state(struct msm_dp *dp_display, bool state)
>  			"[MST] failed to set topology mgr state to %d rc:%d\n", state, rc);
>  	}
>  
> +	if (state)

Why?

> +		msm_dp_display_set_link_info(dp_display, &mst->link_info);
> +
>  	drm_dbg_kms(dp_display->drm_dev, "[MST] set_mgr_state state:%d\n", state);
>  	return rc;
>  }
> @@ -55,6 +299,7 @@ int msm_dp_mst_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_au
>  		return ret;
>  	}
>  
> +	mutex_init(&mst->mst_lock);
>  	dp_display->msm_dp_mst = mst;
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> index f71200a790f3..854dd08eede2 100644
> --- a/drivers/gpu/drm/msm/msm_drv.h
> +++ b/drivers/gpu/drm/msm/msm_drv.h
> @@ -358,6 +358,8 @@ bool msm_dp_needs_periph_flush(const struct msm_dp *dp_display,
>  bool msm_dp_wide_bus_available(const struct msm_dp *dp_display);
>  int msm_dp_get_mst_max_stream(struct msm_dp *dp_display);
>  int msm_dp_mst_register(struct msm_dp *dp_display);
> +int msm_dp_mst_attach_encoder(struct msm_dp *dp_display, struct drm_encoder *encoder);
> +
>  #else
>  static inline int __init msm_dp_register(void)
>  {
> @@ -384,6 +386,11 @@ static inline int msm_dp_mst_register(struct msm_dp *dp_display)
>  	return -EINVAL;
>  }
>  
> +static inline int msm_dp_mst_attach_encoder(struct msm_dp *dp_display, struct drm_encoder *encoder)
> +{
> +	return -EINVAL;
> +}
> +
>  static inline void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp_display)
>  {
>  }
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
