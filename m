Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F5FC43602
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 14:34:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30F4710E24A;
	Fri,  3 Jul 2026 14:34:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gr8DXkkO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bDnzyRIE";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6404610E24A
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 14:34:34 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663B1Noc3134736
 for <dri-devel@lists.freedesktop.org>; Fri, 3 Jul 2026 14:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=F0aBhZc9WF+rFPlDXqAf/XhE
 72xCrYOeF47F21xku7w=; b=Gr8DXkkONkkq7N+aZz/zMERdhhLMnmXhh8Vg1ZTS
 bFCB3Tc4v/DBDvqjmU8d2yUGAEfebpaGuyysZ0KQVfulJFjDyruCzhsh71U/ay5m
 3io55qCtOgZcGNHA4iFjf1aCg+5AKnaOFrAWO9iIvUx6g+cWtc9LfnqOjggtwqNu
 wpoGFOT7PVUmPTtL+/QeojnKRB7OjFT3t+xxRMA7XnQUvGehcLW58NY8Y5vSWF4A
 OqAx8yxPgrEBo3MuLbVBkxXjCgDYoU5QnBl1ZKSKsamr+LzkaHsyQM6z8h0akRaW
 D9MF2t+ue2Eh5YRsBWMXIIFGZYnNUX5dR9nUqngMLHsOWA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f65qcjfue-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 14:34:33 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7382fc429f6so710080137.2
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 07:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783089272; x=1783694072;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F0aBhZc9WF+rFPlDXqAf/XhE72xCrYOeF47F21xku7w=;
 b=bDnzyRIElVvcAvbYXgXlnMlkYzib82iVdZ3pjFyj2vRsINFgDOIWQdSwuovG8m3kXw
 qi3z6mYAFHf9q7B4vtnF5ZMSittNBj+00f5Uuu4KosZWdcJH0+Nng6Ij618U21hCvuJb
 ggRoz5er02srRk5YuqCgewql0lbq03l8JsmnNChcPH/MAattnC8w/Zxi7s86gJnfdSqU
 35ZV2ZcPQ9hhy1x5ASbBLSLxEUxPiFcMpaA11TKyBpv3KwOwuNF+q+aqQ8KQGV4xif/R
 cLamgOdByPBWK1uKHHPWgtRtRAQKL0H3S5Z1ZkQsTJCfiWHM4181QeDRM7FesB6YCoOe
 ebtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783089272; x=1783694072;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F0aBhZc9WF+rFPlDXqAf/XhE72xCrYOeF47F21xku7w=;
 b=WEb85opfeCCrty91Insi+gqkf1TLBrDdxTmsv/MLmkTofF+uVXBxY+pkIWR3EV3RQa
 yu6dYgaLymh3b4PgtmhMMxI3hRc0fSfwL2Q+PMcEH+aw/YT0QgwjoDue8u/SUsjgYUiL
 CnDfwYzbklEy+cVFq7l6XYarFGrrlfaBcERSkcmtMM+Fi01SL9Nlh//BALiVbXYEAiGy
 ur9iT6acrQjsMJZ5528Dj8lHoyzw7nYcLDisMoOKthj6l8lSCV/XUFPKEVsLk/rfCfnw
 In5LGMmHEGaCXFoC6yyTUSx+FcN9NhD8H9B7YHlW//kWYh1t22vsN32f6UDljsOXHS3t
 qQPg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoZtmwi36xm32mk8aOhpqxUeMPRgyUIBdtffWR+pA3C0MB2FHwaes8gBcuCaVxPyANSvCMbFMWgEYc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwOPAT1xZJ6pCkAdaNBx5xns/O7QnTzdhX0G5FzTJLhVpAI1G5s
 khc1ke8E82T6k2YsTbWZRegUwTu2s0cJhOrl3au/ADp88EHIRsnQTbPjwpTBIZntaVsmg1hIu3k
 SchcLjd9QKDA9K1VzzuE3jX+JWRHyFzIvDz9UwHtwe7RJMDuppIiJezkVDJ7MzJ4Zp61lTrI=
X-Gm-Gg: AfdE7ckxo7cfHR98USJW9I2giuiveX37pmBGcl5rkyX7Mp+SpnPKqUG36AwCdALRTlk
 lNeTWqcZG9yeRuZWwirBJ28qVtCCS8dbxY1gk5QH+04lMypa8//LRlxc8+b/BUfeWZUbasCFiP/
 d/8nqh2PP4JIXt5hF/7s0DYNkT2BvJ5HWYE33N02vjN7mHcEhEU6Da/7vKMBd3fBEzgrDx/vIdD
 P7HdufJP3WENZgvBtALumzsxShJwJms4+0i2OqCzYlEU9RB+2e29Ico22yoXpd+c3/Mivfv7YA8
 Vmvz00YatGDCI7/M5ys4Bhw/i9kYV/Jc/9W37Bi1VSoXyN8V2pyDgC4RYt3uc5YYun4nfkueEe6
 1UuztA5aG2R/lM8607FHV50JDxxS4V7/G+KQAdOIK8LDJ16h6jr0cCnm2yFiYFT+eUBZnMEvGcB
 bhOV+5AYL7fxPd5jNeXsI7MpkA
X-Received: by 2002:a05:6102:5349:b0:739:977f:c1ba with SMTP id
 ada2fe7eead31-741f650d784mr116916137.2.1783089272586; 
 Fri, 03 Jul 2026 07:34:32 -0700 (PDT)
X-Received: by 2002:a05:6102:5349:b0:739:977f:c1ba with SMTP id
 ada2fe7eead31-741f650d784mr116889137.2.1783089271966; 
 Fri, 03 Jul 2026 07:34:31 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aed13c8b5bsm526521e87.80.2026.07.03.07.34.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 07:34:30 -0700 (PDT)
Date: Fri, 3 Jul 2026 17:34:28 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Daniel Stone <daniels@collabora.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v8 04/39] drm/connector: Add HDMI 2.0 scrambler
 infrastructure
Message-ID: <tjsidlnvswo2rdhqa6jybxrnb47lxgmxdlfrfbasuh67wjbqoy@3a45n3zawvnf>
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
 <20260702-dw-hdmi-qp-scramb-v8-4-d79890d00b6a@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702-dw-hdmi-qp-scramb-v8-4-d79890d00b6a@collabora.com>
X-Proofpoint-GUID: 2tSg7rN60BeuuO9w74s7Q_giArucLjMo
X-Authority-Analysis: v=2.4 cv=Bb7oFLt2 c=1 sm=1 tr=0 ts=6a47c879 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=QX4gbG5DAAAA:8
 a=GwlrSY-_3Y_gmMEHsFMA:9 a=CjuIK1q_8ugA:10 a=gYDTvv6II1OnSo0itH1n:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: 2tSg7rN60BeuuO9w74s7Q_giArucLjMo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE0NCBTYWx0ZWRfX/JmkF5mkkLcW
 ih0DxFK4FqUrZ5UX4WFWfMBd0C1TlrBJWjVpEFo4Ygi7Py9Dr57CQkiJijr2eQ9VrkAYdtbPGdm
 uBpSbN6QOfhdWFjyBbLE42FJ+af2+XhSwnFKPiMwXEwBbrNcx1PirVLEUoNoQdUViUS3DKZVVpO
 JpUTlRq4SMpitTO+8ZehSuxXK4z9FjoSSX9i0kKT7HgGhqs/ouc0XIKFr5Nxslf70+8E4F30bYp
 2B9zkq1UMpoI3LIWjRYgA4DyEV5ebpbNJBQe5BpX+OVH5eg/3WqqzOO+Y/rqdm+3+dugHn9Bq8J
 R6EQsiBTm7RLSJ7tOKCWsNdS/cwe7/uN6gDNVHLeWJ62M/iKApl0kR+jni4r46O3GSPrF5ivfbf
 Q5pBQNmW9O3ilD5LsdvRe4+3CtJmHOVtdAchdZQ1IFKL5WFBwxsU89HIG5C65of8ZfMnrlXUOCd
 Z/3MHeVCJPbibUet9Sw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE0NCBTYWx0ZWRfX7iFlPPjI5YxF
 kowOZY0ai41/+HGFR7tem13TXVS7T4U8oiAtHjSgIYTzGwM46OuG5Xr7vrX1KxxukzN/kWWX1oz
 PhA2dArGafiPhiVDIwjo6UKRCgwbYXI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030144
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

On Thu, Jul 02, 2026 at 05:46:17PM +0300, Cristian Ciocaltea wrote:
> Add the connector-level infrastructure to support HDMI 2.0 scrambling:
> 
> - A scrambler_supported flag to indicate whether the source supports the
>   scrambling capability, in which case the newly introduced
>   .scrambler_{enable|disable}() callbacks in drm_connector_hdmi_funcs
>   are mandatory

Do we need a flag? What would it mean if the flag is set, but the
callbacks are not? Can we drop the flag and use the presence of the
callbacks as a way to identify that scrambler is enabled?

> - A scrambler_needed flag to be managed by the hdmi state helpers based
>   on the negotiated TMDS character rate and the source/sink scrambling
>   capabilities
> - A scrambler_enabled flag to track whether scrambling is currently
>   active
> - A delayed work item (scdc_work) with an associated callback (scdc_cb)
>   to monitor sink-side scrambling status and retry the setup if the sink
>   resets it
> 
> These are intended to be used by SCDC scrambling helpers to coordinate
> scrambling setup and teardown between the source driver and the DRM
> core.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/drm_connector.c | 26 ++++++++++++--
>  include/drm/drm_connector.h     | 77 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 100 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index c7ce6b7bd8b0..deecfc582f09 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -220,6 +220,19 @@ void drm_connector_free_work_fn(struct work_struct *work)
>  	}
>  }
>  
> +static void drm_connector_hdmi_scdc_work(struct work_struct *work)
> +{
> +	struct drm_connector *connector;
> +	struct drm_connector_hdmi *hdmi;
> +
> +	hdmi = container_of(to_delayed_work(work), struct drm_connector_hdmi,
> +			    scdc_work);
> +	connector = container_of(hdmi, struct drm_connector, hdmi);
> +
> +	if (hdmi->scdc_cb)
> +		hdmi->scdc_cb(connector);
> +}
> +
>  static int drm_connector_init_only(struct drm_device *dev,
>  				   struct drm_connector *connector,
>  				   const struct drm_connector_funcs *funcs,
> @@ -285,6 +298,7 @@ static int drm_connector_init_only(struct drm_device *dev,
>  	mutex_init(&connector->edid_override_mutex);
>  	mutex_init(&connector->hdmi.infoframes.lock);
>  	mutex_init(&connector->hdmi_audio.lock);
> +	INIT_DELAYED_WORK(&connector->hdmi.scdc_work, drm_connector_hdmi_scdc_work);
>  	connector->edid_blob_ptr = NULL;
>  	connector->epoch_counter = 0;
>  	connector->tile_blob_ptr = NULL;
> @@ -624,12 +638,18 @@ int drmm_connector_hdmi_init_with_caps(struct drm_device *dev,
>  	 * inferred limit with the actual controller capability. A value of
>  	 * zero keeps the default limit inferred from supported_hdmi_ver.
>  	 */

Here we need to check that the driver doesn't set only one callback of
the pair.

> -	if (caps->supported_hdmi_ver >= HDMI_VERSION_2_0)
> +	if (caps->supported_hdmi_ver >= HDMI_VERSION_2_0) {
> +		if (!hdmi_funcs->scrambler_enable ||
> +		    !hdmi_funcs->scrambler_disable)
> +			return -EINVAL;
> +
> +		connector->hdmi.scrambler_supported = true;
>  		connector->hdmi.max_tmds_char_rate = HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ;
> -	else if (caps->supported_hdmi_ver >= HDMI_VERSION_1_3)
> +	} else if (caps->supported_hdmi_ver >= HDMI_VERSION_1_3) {
>  		connector->hdmi.max_tmds_char_rate = HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ;
> -	else if (caps->supported_hdmi_ver >= HDMI_VERSION_1_0)
> +	} else if (caps->supported_hdmi_ver >= HDMI_VERSION_1_0) {
>  		connector->hdmi.max_tmds_char_rate = HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ;
> +	}
>  
>  	if (caps->max_tmds_char_rate) {
>  		if (caps->max_tmds_char_rate > connector->hdmi.max_tmds_char_rate)
> +
> +	/** @scdc_cb: Callback to be invoked as part of @scdc_work.
> +	 *
> +	 * Currently used to monitor sink-side scrambling status and retry
> +	 * setup if the sink resets it.
> +	 *
> +	 * This is assigned by the framework when making use of
> +	 * drm_connector_hdmi_enable_scrambling() helper.

No such helper. Also, please explain in the commit message, why do we
need to keep it configurable. Why the default is not enough?

> +	 */
> +	void (*scdc_cb)(struct drm_connector *connector);
> +
>  	/**
>  	 * @funcs: HDMI connector Control Functions
>  	 */
> 
> -- 
> 2.54.0
> 

-- 
With best wishes
Dmitry
