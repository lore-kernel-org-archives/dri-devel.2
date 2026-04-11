Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F5C5F3ED50
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 17:34:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B076910E20D;
	Sat, 11 Apr 2026 17:34:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aFPTL1ei";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g1R5lksC";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40FD110E1FE
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 17:34:52 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B7uZNU3336122
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 17:34:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=3Njx8/fv7Km3RsqCz552LOpr
 aHFxUNpjkpMwbhw0bmo=; b=aFPTL1einZDvazwJd5nJLpTWoyNW11KNet5H2lBN
 2sUMo8FAkoGWwia0XPOveF8YnzfqIn0MX1U/XeQk0tVr/ur2O5O8nQATzJ+QWG5F
 4Gh9LG1TWi1m1+ATg45ihK2w6EnYcevlVmgRqnjpOVuC9Y4t2JsOXYUOFFyVFbyF
 SP+FeehycvxAzkNt3kXcAv4Q3AMdJBKVwagM+fByP+Psw8Q0GOKp4d7ooyPju7Jg
 WxCI/v8gT8KebS6/Wl333Dt66Wb2Ov5hc78tvbZJj3/0ZGC2njqP4T8v6eevzgz6
 fn3Ibsaj0YPqQe81ddfFULobqdGcbrktaH0ExVLLMKm29g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfjbp8t12-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 17:34:51 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b4ca7e7c2so61898801cf.3
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 10:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775928891; x=1776533691;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3Njx8/fv7Km3RsqCz552LOpraHFxUNpjkpMwbhw0bmo=;
 b=g1R5lksCCHNHMEd/4hhy4wneJAe+HTiq6FaMLzETELWDI6k4q0tgNcNQdYLPx4jb1Q
 EADgBmYMClkaaxuBX0avKpkrGIwH8yan8uNK/viCQ6dC3IZTKUcRh7/99bS7fGsKVEhh
 qKViTqcUi64m0TLg8sgvNnybMhJve12clmNveP6+75We0S6HVQm29KO9KwZaVQfB5SSh
 GZYmPToxQUDBxUD/gxAwqSTJOP3100fG9WMx16ewHe9GPSLD1xTGjtBeG58QI2wxU1Wt
 MEP4KnaR/ov8FIhrmkPYfl3gSWFSFvJhXVqHlaKDgr8doyUpKG3Rferqu+VbZoJF+psh
 nSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775928891; x=1776533691;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Njx8/fv7Km3RsqCz552LOpraHFxUNpjkpMwbhw0bmo=;
 b=oqw/2Ma9f016pdzwLI13pIkLWKEvtyCbItjGxSiW9wKUj3eNerjcDdWtFGndb6ZaB0
 ZN3cWupx/VkVUtUZbTh0e7W0wHudDubdCeMmCETIJ86WOFZn4Mh3zVaC5rQmmkeYilgH
 5c6pY+JN9ztK9LCYjPUwIevNKZcagq3A/T9NiyuPyg39TFORGIr/ez+Iide+Uv4BAMP0
 BE264d4kqqUFmsCI5mTkLcdWll18AK4qP4HAqXPiCtmkRhUI01Xxh4qDLVgL2WWIZOz0
 8hBh4dPOJ19O9ssFXYeVkIkPt589O0MrUFgh/eMEdo4hrkNr/2A4ROfltRdsWab+hwCK
 CG+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5G6DHWLmTjT0TnR/m3HEeRtuvyptjVfCAj6GcZ5ycK6UDzKxsd+Lvdr8t6I/t6Fx2dK9Mnee2zGM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzdPdQwYIoR6p+ibijvojMUX8l7qVC8XXjv/Sjs8CfIj0vOp5Rk
 U9ys6iYHOQgD3Uuo6IChdyCkVUvdmFmIDcbEvkXpdLIlB+UjZbepbBsUDwrnN+PsXHQ5+6eSUb5
 /2+FQjnW9d3YG2A3XxBtqYQyu7Lgxjntzealtmwvn805+7DdokewoHUry8w98X8TOzIHBlDo=
X-Gm-Gg: AeBDieuhSX7iVaMBjeGIG//9Gzq/+egTVKmyORID2DiS8g1cM4CqVKEvWsbe3GP6Hir
 8ev+PyK0jGbMS8ElHv+zldwp2O7+Q69ROfAqG9Y3IfB0QFt7owbi+aj2lb76Nb6BQtqRageiULc
 V6AVoF8IgBjUsf2l+ejyUI77jzG/33Ga8DbV3KgQCLvMvwC5zAYRtluOKH3lEeH9jGWLxreJVWK
 c4ZLYFViPGQv7CaD4/doN20f9kQ4K3161agCXYLz0BISYSGB1Ylx3c9I0LDB9vXh3fXTkxbIkmx
 2cMFN2CgtkFP/FhVJHzunHQmR1pnIA8TCGRG8CQTCuOX1YZqm1NP6Bfhi+BjXoIM5c4w+BC82MX
 7ePDe3dTGvfFbB0Gu184YfL3632ZfDHBviNDilg4hwO333/XGIjp3ZZPQSPcJFbB/ByzX3ohcaw
 ENwvtHq3te/cGavX8vEw1V+B8ZFk9RkEQuInY=
X-Received: by 2002:ac8:7fcf:0:b0:50d:a8f5:d519 with SMTP id
 d75a77b69052e-50dd5b608d0mr117468131cf.14.1775928890720; 
 Sat, 11 Apr 2026 10:34:50 -0700 (PDT)
X-Received: by 2002:ac8:7fcf:0:b0:50d:a8f5:d519 with SMTP id
 d75a77b69052e-50dd5b608d0mr117467771cf.14.1775928890304; 
 Sat, 11 Apr 2026 10:34:50 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eeee11f6sm1524462e87.44.2026.04.11.10.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 10:34:49 -0700 (PDT)
Date: Sat, 11 Apr 2026 20:34:46 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/39] drm/msm/dp: splite msm_dp_ctrl_config_ctrl()
 into link parts and stream parts
Message-ID: <omw63f7fbqiuw2t266dq5drk7rz2kohydpvbbhcrbfiehb7lzh@aucqhfaliams>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-5-b20518dea8de@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-msm-dp-mst-v4-5-b20518dea8de@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=PuijqQM3 c=1 sm=1 tr=0 ts=69da863b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=lIPaWChcOsILjI9_6t8A:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: sLlidzFrrXPgXOPaUxhoMkppEcOYMQhx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDE1NCBTYWx0ZWRfX5XSYS9UlGxzj
 Y4djlUtVMP6YQlwHMxTFPNzBt2U5kXhheCphW1l0TxBfV362BEcoqZXQKFyFBpGCrYpGx+FzSIL
 qcXs22fatHaEGXWq1HnqhizMavxPQ5xtxy1VS59Q7RYLJKU8xC2bUKBAymgy9rymSHZse/NAfbZ
 lPNl/uD2I2Poyso0Pu9wUd9Okn4mkINWLzsS6uqReRph2aXMr5HFt0t/molIueOw9PauPtqHq1c
 1TA4FZiwQKZz4HI4hI4742K4Wu0roWUV7itwPZXqeEZY+Ko1Ft9kQTcgso9XCoqC2YBR5r770nw
 ET/nf7kgxYpRPWv95bMwcJlIZX8P1QiecXcMFQ5zhTqe8yZwzMv6ANHM5/9bvKuRl3mXJZS9pHV
 zSwXIqy4xTe5pRmxMy8xqk7vKyADAdwncvt3cZaBW1yceO5wGxUZyniFGQoSkdsyeitQDpKdvQh
 1YKf9nPyBnzZEg+N3sg==
X-Proofpoint-GUID: sLlidzFrrXPgXOPaUxhoMkppEcOYMQhx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110154
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

On Fri, Apr 10, 2026 at 05:33:40PM +0800, Yongxing Mou wrote:
> The DP_CONFIGURATION_CTRL register contains both link-level and
> stream-specific fields. Currently, msm_dp_ctrl_config_ctrl() configures
> all of them together. Separates the configuration into link parts and
> streams part for support MST.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 43 ++++++++++++++++++++++++++--------------
>  1 file changed, 28 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index 476346e3ac19..85315467b5d0 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -388,26 +388,41 @@ void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl)
>  	drm_dbg_dp(ctrl->drm_dev, "mainlink off\n");
>  }
>  
> -static void msm_dp_ctrl_config_ctrl(struct msm_dp_ctrl_private *ctrl)
> +static void msm_dp_ctrl_config_ctrl_streams(struct msm_dp_ctrl_private *ctrl,
> +					    struct msm_dp_panel *msm_dp_panel)
>  {
>  	u32 config = 0, tbd;
> +
> +	config = msm_dp_read_link(ctrl, REG_DP_CONFIGURATION_CTRL);
> +
> +	if (msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420)
> +		config |= DP_CONFIGURATION_CTRL_RGB_YUV; /* YUV420 */
> +
> +	tbd = msm_dp_link_get_test_bits_depth(ctrl->link,
> +					      msm_dp_panel->msm_dp_mode.bpp);
> +
> +	config |= tbd << DP_CONFIGURATION_CTRL_BPC_SHIFT;
> +
> +	if (msm_dp_panel->psr_cap.version)
> +		config |= DP_CONFIGURATION_CTRL_SEND_VSC;
> +
> +	drm_dbg_dp(ctrl->drm_dev, "stream DP_CONFIGURATION_CTRL=0x%x\n", config);
> +
> +	msm_dp_write_link(ctrl, REG_DP_CONFIGURATION_CTRL, config);

You have an RMW cycle here. Please document what prevents it from racing
with the concurrent msm_dp_ctrl_config_ctrl_link().

> +}
> +
> +static void msm_dp_ctrl_config_ctrl_link(struct msm_dp_ctrl_private *ctrl)
> +{
> +	u32 config = 0;
>  	const u8 *dpcd = ctrl->panel->dpcd;
>  
>  	/* Default-> LSCLK DIV: 1/4 LCLK  */
>  	config |= (2 << DP_CONFIGURATION_CTRL_LSCLK_DIV_SHIFT);
>  
> -	if (ctrl->panel->msm_dp_mode.out_fmt_is_yuv_420)
> -		config |= DP_CONFIGURATION_CTRL_RGB_YUV; /* YUV420 */
> -
>  	/* Scrambler reset enable */
>  	if (drm_dp_alternate_scrambler_reset_cap(dpcd))
>  		config |= DP_CONFIGURATION_CTRL_ASSR;
>  
> -	tbd = msm_dp_link_get_test_bits_depth(ctrl->link,
> -			ctrl->panel->msm_dp_mode.bpp);
> -
> -	config |= tbd << DP_CONFIGURATION_CTRL_BPC_SHIFT;
> -
>  	/* Num of Lanes */
>  	config |= ((ctrl->link->link_params.num_lanes - 1)
>  			<< DP_CONFIGURATION_CTRL_NUM_OF_LANES_SHIFT);
> @@ -421,10 +436,7 @@ static void msm_dp_ctrl_config_ctrl(struct msm_dp_ctrl_private *ctrl)
>  	config |= DP_CONFIGURATION_CTRL_STATIC_DYNAMIC_CN;
>  	config |= DP_CONFIGURATION_CTRL_SYNC_ASYNC_CLK;
>  
> -	if (ctrl->panel->psr_cap.version)
> -		config |= DP_CONFIGURATION_CTRL_SEND_VSC;
> -
> -	drm_dbg_dp(ctrl->drm_dev, "DP_CONFIGURATION_CTRL=0x%x\n", config);
> +	drm_dbg_dp(ctrl->drm_dev, "link DP_CONFIGURATION_CTRL=0x%x\n", config);
>  
>  	msm_dp_write_link(ctrl, REG_DP_CONFIGURATION_CTRL, config);
>  }
> @@ -450,7 +462,8 @@ static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl
>  	msm_dp_ctrl_lane_mapping(ctrl);
>  	msm_dp_setup_peripheral_flush(ctrl);
>  
> -	msm_dp_ctrl_config_ctrl(ctrl);
> +	msm_dp_ctrl_config_ctrl_link(ctrl);
> +	msm_dp_ctrl_config_ctrl_streams(ctrl, ctrl->panel);
>  
>  	test_bits_depth = msm_dp_link_get_test_bits_depth(ctrl->link, ctrl->panel->msm_dp_mode.bpp);
>  	colorimetry_cfg = msm_dp_link_get_colorimetry_config(ctrl->link);
> @@ -1628,7 +1641,7 @@ static int msm_dp_ctrl_link_train(struct msm_dp_ctrl_private *ctrl,
>  	u8 assr;
>  	struct msm_dp_link_info link_info = {0};
>  
> -	msm_dp_ctrl_config_ctrl(ctrl);
> +	msm_dp_ctrl_config_ctrl_link(ctrl);
>  
>  	link_info.num_lanes = ctrl->link->link_params.num_lanes;
>  	link_info.rate = ctrl->link->link_params.rate;
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
