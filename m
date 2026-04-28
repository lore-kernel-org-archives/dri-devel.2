Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0193FF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 12:38:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E0A110E865;
	Tue, 28 Apr 2026 12:38:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eE0IdpUo";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MIXtx9/D";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87C2C10E865
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 12:38:32 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63SA2q8q984943
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 12:38:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=IgHL9+K1Yx+1ojCGhO4CLldT
 N1xaEUCJGfLjuyuMNp0=; b=eE0IdpUoZVbtLFkJmhaL51E79FPijtjtgTZk3hB/
 +xyXFCfEwQBrzcXJ5Mt35WHeXvJ1NfGlyQKKOsudm8jrCtd0GoJzDW1iItrSyBDN
 AEK3U0TwEsD8ktK0O80mcAxd8oGsie4lXej1A5c1jwsy8NiUX/qu8N213wolB0k1
 6BRbeTv6YRRLE2ZJW21ULv8gFghSvWLtTMekT5RW2S/usVKKRdDRFRYmtWxbCYJI
 woC/aaJfSqiWkzfdoMTo62Vau3fzijrMw5/OFr7qsqPOGDL4DVoqn2HERuNEpblI
 i+nNXncHAr0DqnYteUPiFdfVpPuUXD8VUUbXKR3QjMujyw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dttt2rk4c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 12:38:31 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8aca14d1faaso86497746d6.3
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 05:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777379911; x=1777984711;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IgHL9+K1Yx+1ojCGhO4CLldTN1xaEUCJGfLjuyuMNp0=;
 b=MIXtx9/DxD+MGhO21J6PjB86MDI94H1GTsjrm+UjRB+k5HrnL+Q2gH2gfLHNMiH96t
 0wtPKqu6Qo9Z+b8HTiSiMdq4T8F46xt4jfEeHBwOE9f5x/R2qArt3+WKp63qBi+jGrJ+
 djUp5/7oMfGKruZMGaIRWt7cg6jsuLRwOHBFsyH29Qs8Su1DLrm+0jHzdOp48hB/MEd4
 c71qr+YpFpH2M7nCtdHpLjDCIAt6d7XypfDJ0ai/nPKllVIvW9WMsnA+p2Hcwxp6ZdwL
 CE7O5ofQPeKspbXuopsVeKv1sXYsW0dPjX30xXhwoJbOr2Rrz8LXhUUSutURWJQx6BSY
 pgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777379911; x=1777984711;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IgHL9+K1Yx+1ojCGhO4CLldTN1xaEUCJGfLjuyuMNp0=;
 b=naEMV/Iax+5hq6y1xkNaa5FfZVb1gAF+Z2Tgdw6svjfOavC7N3OtFzuePFX8JAXKpj
 kM8y8SzWbxpxLAxlDGXkUqpJ8yru/2x4BxVxtD9IaowjqstG+GuZsMMn/Dapb5uVv7yr
 VKQJLqUfgAEOPoPk5Rxlz9yLooV0n6U/McQXLaIBTIAIVI9LxFcDgmVebffASjnA4K+1
 qsBI3INt3NK5VpeprF4glfQ3MJ0jEBzX5Q3oZvNAeRGAOJARV0FYWKDk/XK7gEtJgP+O
 zjNgMObh1jrHRhp9HGJmZ0PoPxeygyesN7DvY0Fmul4Fyt6+Njn4gLERzN4tjNtNrJY4
 ZQTA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Ie7qQmJFJVa5edsuSGt8wIFnRRbXE5q1MjI6djobZU/JjeZ9+i7i96JN6LrJQmQ8LtmfkqsnzsEU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywie7A9YXcyV1E9ziGWdrECeizuA7VCiS6BXqbDRfhNIg01HNQn
 dRSndTWWsJPY0scRqEt453A5HuEADE159lMh5zLfxirwm2Nw6EDxVowTQr7tRF39Xo0UfR0BfFn
 q8Y1MpWQf4x6//u5Bd+F3t0h89Odvy1w7A63SeOMAFkhGDLyD9UFi42Y8xXnNBHYK8I0J0N4=
X-Gm-Gg: AeBDietgyOtNoqOYF9P3wQ+dTH8aGdBdcNhNLgw5kRuS0sGydjQLSC0Q57fVqTONzr3
 H4KY/yq9WU2mcj6ZMPu5sbq7ox3sg+wz9Ovdc5q2dF768CAVWh+Fc/2/3ml8Bo539R7Y7KpgFwx
 fFAfapi4eS3VtKRZqTImrLOX117qnph0XxLceiCbn5JEWfEpRrhTfe8Ly1iHugXBVDwxYwd89jl
 quw9EWVO/eDnJWh77W/2LLw1c+Q+atKSNSR98ZYnfKrUOW8DtzYkKKn9BygnBCSUMbXn2jw+W2e
 TX4JRhr98iDx/FCyKZrEPTygNXO3mqMyPCdubUw57x++wQl+cXFJS/Vw4fBvZmvcE7xRPz5k5V4
 xN3yjzmkaHR/bKpmX6ODvVyFRbVCG/TRH9ngbbaOQ/okjzwIDC9DFsExkcvs/XvyVI/2wYGw2l+
 J0ZnGKrfVRCOSQDSWDdI6LDAjdKXL2cBrvO6Gr2C9QCktQaQ==
X-Received: by 2002:a05:622a:a11:b0:50e:61c1:685f with SMTP id
 d75a77b69052e-5100e1f7748mr40176021cf.50.1777379910782; 
 Tue, 28 Apr 2026 05:38:30 -0700 (PDT)
X-Received: by 2002:a05:622a:a11:b0:50e:61c1:685f with SMTP id
 d75a77b69052e-5100e1f7748mr40175411cf.50.1777379910267; 
 Tue, 28 Apr 2026 05:38:30 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a7463f5f4bsm596170e87.49.2026.04.28.05.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 05:38:29 -0700 (PDT)
Date: Tue, 28 Apr 2026 15:38:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Christian Hewitt <christianshewitt@gmail.com>,
 Diederik de Haas <diederik@cknow-tech.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/13] drm: bridge: dw_hdmi: Use delayed_work to
 debounce hotplug event
Message-ID: <go5i5iiwra426hydnvc5thhgtknv3fa7ti35q3et6frroxag2n@tfbfiyjmtzkk>
References: <20260403185303.80748-1-jonas@kwiboo.se>
 <20260403185303.80748-10-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403185303.80748-10-jonas@kwiboo.se>
X-Authority-Analysis: v=2.4 cv=HbIkiCE8 c=1 sm=1 tr=0 ts=69f0aa47 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=pekZB1wqKdmBCcXpRF0A:9
 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: d4nm5pZDq6TCTMR1ezAkbut1HXlv-Yhe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDExNyBTYWx0ZWRfXz5FE9pYr/4T5
 BEHgX1fw4D+0049KCxNiGevW/ThnJPg5SH9t/3wo+ix8LtOYjwcDFh5Q3rGR+KkN9kr+OEtIPmh
 p54jjQ/mKOY0ohqHih8r0+g8xV7aY+tSPzbi16c3OgkBMG7eP6D/Eb3EsoJ77ScDpVs/+PBsAq8
 RBnp7LN7sjigl+YEcY3sZWJcTgsRRW3TpMkaU8PTlBPkAk6jCIXt7vyR3kJKn3AGclJxnOnz6Zn
 4Zmv+me3VaasTzXtXmztjiUBId4OWzm7VAQgqKyg8IkLS0REtwLcPTNN8NPxdhfIBsmSW5KIy1s
 5KrshMoPFVXMqwnqYqDRg5RRhqRacuWsEw/5etknbWlHAPKhkHNmmE7RMZ1OslQuq/dqo4tOZNv
 dwBbTEKeiGD9Ig6o1tzb+iarCNyL/y8fAPJA8SCvxhPNF7yOcItn58t+J3L3xRyhghzzjA7+lWj
 WpwOy7ZEVyWMIBPcvpg==
X-Proofpoint-GUID: d4nm5pZDq6TCTMR1ezAkbut1HXlv-Yhe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_03,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280117
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

On Fri, Apr 03, 2026 at 06:52:55PM +0000, Jonas Karlman wrote:
> HDMI Specification Version 1.4b chapter 8.5 mentions:
> 
>   An HDMI Sink shall not assert high voltage level on its Hot Plug
>   Detect pin when the E-EDID is not available for reading.
> 
>   A Source may use a high voltage level Hot Plug Detect signal to
>   initiate the reading of E-EDID data.
> 
>   An HDMI Sink shall indicate any change to the contents of the E-EDID
>   by driving a low voltage level pulse on the Hot Plug Detect pin. This
>   pulse shall be at least 100 msec.
> 
> Use a work queue to debounce reacting on HPD events to better handle a
> HPD low voltage level pulse when a sink changes the EDID.
> 
> The 1100 msec hotplug debounce timeout was arbitrarily picked to match
> other drivers using same const, and testing using a Raspberry Pi Monitor
> seem to use a 200-300 msec pulse when going from standby to power on
> state.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v3: New patch
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 24 +++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index f3f8144ae98e..4d079b689b3b 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -51,6 +51,8 @@
>  
>  #define HDMI14_MAX_TMDSCLK	340000000
>  
> +#define HOTPLUG_DEBOUNCE_MS	1100
> +
>  static const u16 csc_coeff_default[3][4] = {
>  	{ 0x2000, 0x0000, 0x0000, 0x0000 },
>  	{ 0x0000, 0x2000, 0x0000, 0x0000 },
> @@ -192,6 +194,7 @@ struct dw_hdmi {
>  	hdmi_codec_plugged_cb plugged_cb;
>  	struct device *codec_dev;
>  	enum drm_connector_status last_connector_result;
> +	struct delayed_work hpd_work;
>  };
>  
>  const struct dw_hdmi_plat_data *dw_hdmi_to_plat_data(struct dw_hdmi *hdmi)
> @@ -2528,6 +2531,7 @@ static void dw_hdmi_connector_force(struct drm_connector *connector)
>  
>  	mutex_lock(&hdmi->mutex);
>  	hdmi->force = connector->force;
> +	hdmi->last_connector_result = connector->status;
>  	dw_hdmi_update_phy_mask(hdmi);
>  	mutex_unlock(&hdmi->mutex);
>  }
> @@ -3046,6 +3050,16 @@ void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense)
>  }
>  EXPORT_SYMBOL_GPL(dw_hdmi_setup_rx_sense);
>  
> +static void dw_hdmi_hpd_work(struct work_struct *work)
> +{
> +	struct dw_hdmi *hdmi = container_of(work, struct dw_hdmi, hpd_work.work);
> +
> +	if (hdmi->bridge.dev) {
> +		drm_helper_hpd_irq_event(hdmi->bridge.dev);

Nit: please consider this for the followup cleanup. The
drm_helper_hpd_irq_event() is not very effective: we already know which
bridge (and thus connector) caused the HPD event.

Moreover, the call should be redundant as drm_bridge_hpd_notify will
call the registered callback, which normally would be
drm_bridge_connector_hpd_cb(). Internally, this function calls
drm_kms_helper_connector_hotplug_event().

> +		drm_bridge_hpd_notify(&hdmi->bridge, hdmi->last_connector_result);
> +	}
> +}
> +
>  static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
>  {
>  	struct dw_hdmi *hdmi = dev_id;
> @@ -3097,10 +3111,8 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
>  			status == connector_status_connected ?
>  			"plugin" : "plugout");
>  
> -		if (hdmi->bridge.dev) {
> -			drm_helper_hpd_irq_event(hdmi->bridge.dev);
> -			drm_bridge_hpd_notify(&hdmi->bridge, status);
> -		}
> +		mod_delayed_work(system_percpu_wq, &hdmi->hpd_work,
> +				 msecs_to_jiffies(HOTPLUG_DEBOUNCE_MS));
>  	}
>  
>  	hdmi_writeb(hdmi, intr_stat, HDMI_IH_PHY_STAT0);
> @@ -3420,6 +3432,8 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
>  		goto err_res;
>  	}
>  
> +	INIT_DELAYED_WORK(&hdmi->hpd_work, dw_hdmi_hpd_work);
> +
>  	ret = devm_request_threaded_irq(dev, irq, dw_hdmi_hardirq,
>  					dw_hdmi_irq, IRQF_SHARED,
>  					dev_name(dev), hdmi);
> @@ -3552,6 +3566,8 @@ EXPORT_SYMBOL_GPL(dw_hdmi_probe);
>  
>  void dw_hdmi_remove(struct dw_hdmi *hdmi)
>  {
> +	disable_delayed_work_sync(&hdmi->hpd_work);
> +
>  	drm_bridge_remove(&hdmi->bridge);
>  
>  	if (hdmi->audio && !IS_ERR(hdmi->audio))
> -- 
> 2.53.0
> 

-- 
With best wishes
Dmitry
