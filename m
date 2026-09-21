Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19192C982EA
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 01:49:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 260EF10E08B;
	Mon, 21 Sep 2026 01:49:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="IHIK46gf";
	dkim-atps=neutral
X-Greylist: delayed 304 seconds by postgrey-1.36 at gabe;
 Mon, 21 Sep 2026 01:49:03 UTC
Received: from mail-m81231.netease.com (mail-m81231.netease.com [47.88.81.231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0882410E08B;
 Mon, 21 Sep 2026 01:49:02 +0000 (UTC)
Received: from [172.16.12.90] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4e7d76d60;
 Mon, 21 Sep 2026 09:43:53 +0800 (GMT+08:00)
Message-ID: <5d20a638-25e6-43c4-92d4-769795274441@rock-chips.com>
Date: Mon, 21 Sep 2026 09:43:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/8] drm/connector: report out-of-band IRQ_HPD events
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Adrien Grassein <adrien.grassein@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Pengyu Luo <mitltlatltl@gmail.com>,
 Nikita Travkin <nikita@trvn.ru>, Yongxing Mou
 <yongxing.mou@oss.qualcomm.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Francesco Dolcini <francesco@dolcini.it>, Abel Vesa <abelvesa@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
References: <20260920-hpd-irq-events-v5-0-ff1de0090c72@oss.qualcomm.com>
 <20260920-hpd-irq-events-v5-1-ff1de0090c72@oss.qualcomm.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <20260920-hpd-irq-events-v5-1-ff1de0090c72@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa0c1a2485f03a7kunm0e7abd9d1180559
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTRoeVk8ZQx9NTEpMHh5KTFYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQkxVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=IHIK46gfMRLJpRNrWeplzBntM+mO0RdmckEzCJNEBZ+F7opFtoPfxGPbo7cUe+BNtDB904Wyj1Cl6Lse5LGtEGit5lwvmYrqwnoUFXOMQko3cRBdaGXj7wDU3+nl09MRfVGCZySt7RKk1nrKXx/oIoSDik4DuX0kPk7gYhWku9U=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=zst6fN7pWmc5OUBu4zIIe1VCiSN25Y4xHpm/CHEdYtQ=;
 h=date:mime-version:subject:message-id:from;
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

Hi Dmitry,

On 9/20/2026 11:01 PM, Dmitry Baryshkov wrote:
> The DisplayPort standard defines a special kind of events called IRQ.
> These events are used to notify DP Source about the events on the Sink
> side. It is extremely important for DP MST handling, where the MST
> events are reported through this IRQ.
> 
> In case of the USB-C DP AltMode there is no actual HPD pulse, but the
> events are reported through the bits in the AltMode VDOs.
> 
> Rename drm_connector_oob_hotplug_event() to drm_connector_dp_oob_status()
> and extend its interface to report IRQ events to the DisplayPort Sink
> drivers.
> 
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/drm_connector.c          | 20 ++++++++++++--------
>  drivers/usb/typec/altmodes/displayport.c | 23 +++++++++++++++--------
>  include/drm/drm_connector.h              | 21 +++++++++++++++++++--
>  3 files changed, 46 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index 8b4baed060f3..5d4945ea1e95 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -3672,20 +3672,24 @@ struct drm_connector *drm_connector_find_by_fwnode(struct fwnode_handle *fwnode)
>  }
>  
>  /**
> - * drm_connector_oob_hotplug_event - Report out-of-band hotplug event to connector
> + * drm_connector_dp_oob_status - Report out-of-band hotplug event to DisplayPort connector
>   * @connector_fwnode: fwnode_handle to report the event on
>   * @status: hot plug detect logical state
> + * @event: additional event reported by the sink without changing the HPD state
> + * (or in addition to such a change).
>   *
> - * On some hardware a hotplug event notification may come from outside the display
> - * driver / device. An example of this is some USB Type-C setups where the hardware
> - * muxes the DisplayPort data and aux-lines but does not pass the altmode HPD
> - * status bit to the GPU's DP HPD pin.
> + * In some cases when DisplayPort signals are being routed through the USB
> + * Type-C port the hotplug event notifications come from outside of the display
> + * driver / device. In this case hardware muxes the DisplayPort data and
> + * AUX-lines but does not pass the altmode HPD status bit to the GPU's DP HPD
> + * pin.
>   *
>   * This function can be used to report these out-of-band events after obtaining
>   * a drm_connector reference through calling drm_connector_find_by_fwnode().
>   */
> -void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode,
> -				     enum drm_connector_status status)
> +void drm_connector_dp_oob_status(struct fwnode_handle *connector_fwnode,
> +				 enum drm_connector_status status,
> +				 enum drm_connector_dp_event event)
>  {
>  	struct drm_connector *connector;
>  
> @@ -3698,7 +3702,7 @@ void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode,
>  
>  	drm_connector_put(connector);
>  }
> -EXPORT_SYMBOL(drm_connector_oob_hotplug_event);
> +EXPORT_SYMBOL(drm_connector_dp_oob_status);
>  
>  /**
>   * drm_connector_get_color_format - Return connector color format of @conn_state
> diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
> index 51c92dd887ab..344a13c2a296 100644
> --- a/drivers/usb/typec/altmodes/displayport.c
> +++ b/drivers/usb/typec/altmodes/displayport.c
> @@ -187,9 +187,11 @@ static int dp_altmode_status_update(struct dp_altmode *dp)
>  				dp->pending_irq_hpd = true;
>  		}
>  	} else {
> -		drm_connector_oob_hotplug_event(dp->connector_fwnode,
> +		drm_connector_dp_oob_status(dp->connector_fwnode,
>  						hpd ? connector_status_connected :
> -						      connector_status_disconnected);
> +						      connector_status_disconnected,
> +						(hpd && irq_hpd) ? DRM_CONNECTOR_DP_IRQ_HPD :
> +								   DRM_CONNECTOR_NO_EXTRA_STATUS);

The CI is complaining about the alignment issue here. 
I think this needs to be fixed?

>  		dp->hpd = hpd;
>  		sysfs_notify(&dp->alt->dev.kobj, "displayport", "hpd");
>  		if (hpd && irq_hpd) {
> @@ -211,8 +213,11 @@ static int dp_altmode_configured(struct dp_altmode *dp)
>  	 * configuration is complete to signal HPD.
>  	 */
>  	if (dp->pending_hpd) {
> -		drm_connector_oob_hotplug_event(dp->connector_fwnode,
> -						connector_status_connected);
> +		drm_connector_dp_oob_status(dp->connector_fwnode,
> +						connector_status_connected,
> +						dp->pending_irq_hpd ?
> +						DRM_CONNECTOR_DP_IRQ_HPD :
> +						DRM_CONNECTOR_NO_EXTRA_STATUS);
>  		sysfs_notify(&dp->alt->dev.kobj, "displayport", "hpd");
>  		dp->pending_hpd = false;
>  		if (dp->pending_irq_hpd) {
> @@ -396,8 +401,9 @@ static int dp_altmode_vdm(struct typec_altmode *alt,
>  			dp->data.status = 0;
>  			dp->data.conf = 0;
>  			if (dp->hpd) {
> -				drm_connector_oob_hotplug_event(dp->connector_fwnode,
> -								connector_status_disconnected);
> +				drm_connector_dp_oob_status(dp->connector_fwnode,
> +								connector_status_disconnected,
> +								DRM_CONNECTOR_NO_EXTRA_STATUS);
>  				dp->hpd = false;
>  				sysfs_notify(&dp->alt->dev.kobj, "displayport", "hpd");
>  			}
> @@ -844,8 +850,9 @@ void dp_altmode_remove(struct typec_altmode *alt)
>  	typec_altmode_put_plug(dp->plug_prime);
>  
>  	if (dp->connector_fwnode) {
> -		drm_connector_oob_hotplug_event(dp->connector_fwnode,
> -						connector_status_disconnected);
> +		drm_connector_dp_oob_status(dp->connector_fwnode,
> +						connector_status_disconnected,
> +						DRM_CONNECTOR_NO_EXTRA_STATUS);
>  
>  		fwnode_handle_put(dp->connector_fwnode);
>  	}
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index c61345e6fb08..906aaefca7e1 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -91,6 +91,22 @@ enum drm_connector_status {
>  	connector_status_unknown = 3,
>  };
>  
> +/**
> + * enum drm_connector_dp_event - additional events sent by the sink /
> + * display together or in replacement of the HPD status changes.
> + */
> +enum drm_connector_dp_event {
> +	/**
> +	 * @DRM_CONNECTOR_NO_EXTRA_STATUS: No additional status reported.
> +	 */
> +	DRM_CONNECTOR_NO_EXTRA_STATUS,
> +	/**
> +	 * @DRM_CONNECTOR_DP_IRQ_HPD: DisplayPort Sink has sent the
> +	 * IRQ_HPD (either by the HPD short pulse or via the AltMode event).
> +	 */
> +	DRM_CONNECTOR_DP_IRQ_HPD,
> +};
> +
>  /**
>   * enum drm_connector_registration_state - userspace registration status for
>   * a &drm_connector
> @@ -2703,8 +2719,9 @@ drm_connector_is_unregistered(struct drm_connector *connector)
>  		DRM_CONNECTOR_UNREGISTERED;
>  }
>  
> -void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode,
> -				     enum drm_connector_status status);
> +void drm_connector_dp_oob_status(struct fwnode_handle *connector_fwnode,
> +				 enum drm_connector_status status,
> +				 enum drm_connector_dp_event event);
>  enum drm_connector_color_format
>  drm_connector_get_color_format(const struct drm_connector_state *conn_state);
>  const char *drm_get_connector_type_name(unsigned int connector_type);
> 

-- 
Best, 
Chaoyi
