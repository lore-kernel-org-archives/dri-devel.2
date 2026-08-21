Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95CB4C5DF87
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 10:30:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAEAF10E27A;
	Fri, 21 Aug 2026 10:30:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="fkXBuNoj";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64E2910E27A
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 10:30:30 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id D1B95593;
 Fri, 21 Aug 2026 12:29:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1787308147;
 bh=5vVv7c1yXzqyttDt71hcpdNDJ5wPlE0tPpgsFNRa2JY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=fkXBuNojcqqPn6+pYsoJaAwB+sW2cTu9lRK5YHKkRft8MQyV5da5Sh75ekuJG2txm
 10U3KJHpy2YJvTFAfeHCBBKMITo72HN2ZJ9H3iDex4nKTF0xZqJut/CRu/IKl0ZiW+
 Pjd9niUs3bX1sqdnLvTq73mHzAyyzfU6DXvj8Ar8=
Message-ID: <9e5bae91-b72f-4c71-9bea-ccafdf9747a3@ideasonboard.com>
Date: Fri, 21 Aug 2026 13:30:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] drm: bridge: cdns-mhdp8546: Add no-hpd property
To: Yashas D <y-d@ti.com>
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, luca.ceresoli@bootlin.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 r-ravikumar@ti.com, sjakhade@cadence.com, yamonkar@cadence.com,
 u-kumar1@ti.com, devarsht@ti.com, s-jain1@ti.com, d-mittal@ti.com,
 b-padhi@ti.com, andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 rfoss@kernel.org, airlied@gmail.com, simona@ffwll.ch, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260802153825.1570435-1-y-d@ti.com>
 <20260802153825.1570435-3-y-d@ti.com>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20260802153825.1570435-3-y-d@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi,

On 02/08/2026 18:38, Yashas D wrote:
> From: Rahul T R <r-ravikumar@ti.com>
> 
> Add a 'no-hpd' boolean property to support boards where the HPD line
> cannot be used for hotplug detection due to hardware limitations.
> 
> On TI J721S2 EVMs, the DP0 HPD resistor is not populated from factory
> (DNI), so the HPD signal is not physically connected to SoC pin AA24
> by default which makes HPD unavailable but AA24 must be in DP0_HPD
> mux mode for the MHDP firmware to operate.
> 
> When this property is set, the driver uses auxiliary channel (AUX) DPCD
> reads to detect monitor presence instead of hardware HPD signals. The
> DRM framework polls the connection status via the .detect() callback,
> providing hotplug detection without requiring the HPD pin.
> 
> Valid use cases:
> - HPD pin not routed to connector on PCB
> - HPD signal muxed with another function on SoC
> - Hardware designs where HPD cannot reliably detect monitor presence
> 
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>
> Signed-off-by: Yashas D <y-d@ti.com>
> ---
>   .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 79 +++++++++++++++++--
>   .../drm/bridge/cadence/cdns-mhdp8546-core.h   |  1 +
>   2 files changed, 72 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> index 504a3186ebb3..ae9bbec855f3 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> @@ -53,6 +53,8 @@
>   #include "cdns-mhdp8546-hdcp.h"
>   #include "cdns-mhdp8546-j721e.h"
>   
> +static int cdns_mhdp_update_link_status(struct cdns_mhdp_device *mhdp);
> +
>   static void cdns_mhdp_bridge_hpd_enable(struct drm_bridge *bridge)
>   {
>   	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
> @@ -698,7 +700,9 @@ static int cdns_mhdp_fw_activate(const struct firmware *fw,
>   	 * MHDP_HW_STOPPED happens only due to driver removal when
>   	 * bridge should already be detached.
>   	 */
> -	cdns_mhdp_bridge_hpd_enable(&mhdp->bridge);
> +
> +	if (!mhdp->no_hpd)
> +		cdns_mhdp_bridge_hpd_enable(&mhdp->bridge);
>   
>   	spin_unlock(&mhdp->start_lock);
>   
> @@ -739,7 +743,13 @@ static void cdns_mhdp_fw_cb(const struct firmware *fw, void *context)
>   	spin_lock(&mhdp->start_lock);
>   	bridge_attached = mhdp->bridge_attached;
>   	spin_unlock(&mhdp->start_lock);
> -	if (bridge_attached)
> +
> +	if (!bridge_attached)
> +		return;
> +
> +	if (mhdp->no_hpd)
> +		cdns_mhdp_update_link_status(mhdp);
> +	else
>   		drm_bridge_hpd_notify(&mhdp->bridge, cdns_mhdp_detect(mhdp));
>   }
>   
> @@ -788,9 +798,14 @@ static ssize_t cdns_mhdp_transfer(struct drm_dp_aux *aux,
>   		ret = cdns_mhdp_dpcd_read(mhdp, msg->address,
>   					  msg->buffer, msg->size);
>   		if (ret) {
> -			dev_dbg(mhdp->dev,
> -				"Failed to read DPCD addr %u\n",
> -				msg->address);
> +			if (mhdp->no_hpd)
> +				dev_dbg(mhdp->dev,
> +					"Failed to read DPCD addr %u\n",
> +					msg->address);
> +			else
> +				dev_err(mhdp->dev,
> +					"Failed to read DPCD addr %u\n",
> +					msg->address);

Is this intentional? Earlier dev_dbg was used. Now the "normal" case is 
dev_err. I think we can keep it as dev_dbg.

  Tomi

