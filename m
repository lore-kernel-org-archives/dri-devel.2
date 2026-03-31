Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B454FF60D8
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 07:24:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF90510E8A6;
	Tue, 31 Mar 2026 07:24:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="SOssxE5s";
	dkim-atps=neutral
Received: from mail-m49221.qiye.163.com (mail-m49221.qiye.163.com
 [45.254.49.221])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B524610E8A6
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 07:24:18 +0000 (UTC)
Received: from [172.16.12.43] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 38f46a9a4;
 Tue, 31 Mar 2026 15:24:13 +0800 (GMT+08:00)
Message-ID: <26af9f46-a831-425f-89b8-c6e66a937b26@rock-chips.com>
Date: Tue, 31 Mar 2026 15:24:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/10] drm/bridge: dw-hdmi: move next_bridge lookup to
 attach time
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Marek Vasut <marex@denx.de>,
 Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Liu Ying <victor.liu@nxp.com>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@kernel.org>
Cc: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Adam Ford <aford173@gmail.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 Daniel Scally <dan.scally@ideasonboard.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@denx.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Gilles Talis <gilles.talis@gmail.com>,
 =?UTF-8?B?R29yYW4gUmHEkWVub3ZpxIc=?= <goran.radni@gmail.com>,
 Heiko Schocher <hs@denx.de>, Josua Mayer <josua@solid-run.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Marco Felsch <m.felsch@pengutronix.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Peng Fan <peng.fan@nxp.com>,
 Richard Hu <richard.hu@technexion.com>, Shengjiu Wang
 <shengjiu.wang@nxp.com>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Vitor Soares <vitor.soares@toradex.com>
References: <20260330-drm-lcdif-dbanc-v2-0-c7f2af536a24@bootlin.com>
 <20260330-drm-lcdif-dbanc-v2-7-c7f2af536a24@bootlin.com>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <20260330-drm-lcdif-dbanc-v2-7-c7f2af536a24@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9d42c7556e03a3kunmef6e2820a6aebe
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUJKH1ZOGhlOQkxDTR9MQkxWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUJNS0
 pVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
 b=SOssxE5suj5ZNsuWbIy+7Xf44htCzfzHoDzFo/VhGeZ+2K2xJGxUp8Qe/bk2B8eeiRFXXBBjPNj8WGF+reXTb9bNrmGb5iZazSq4V85svyX1U9z5f0KkZDL5q3Kxd/kAD5cnNbus1AYR/PEaEH/yFB5mvdB3LEdTvO34OpXgMcc=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=maTtoLZ6eXqdqKa68USyYKNJj/9x0MED6DQWvxrTcj8=;
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

On 3/31/2026 3:25 AM, Luca Ceresoli wrote:
> This driver looks up the next_bridge at probe time and stores it in
> hdmi->bridge.next_bridge, but only uses the stored value when attaching,
> and only in the DRM_BRIDGE_ATTACH_NO_CONNECTOR case.
> 
> This will be problematic with an upcoming change, adding an hdmi-connector
> using a device tree overlay when not present. That change is in turn
> necessary to migrate the i.MX LCDIF driver to the bridge-connector.
> 
> The problem is that, adding the hdmi-connector via an overlay, devlink
> considers hdmi-connector a consumer of the dw-hdmi device, generating a
> chicken-egg problem:
> 
>   * hdmi-connector probe won't be tried until dw-hdmi is probed (devlink)
>   * dw-hdmi probe will defer until it finds the next_bridge (the
>     hdmi-connector wrapper bridge)
> 
> In preparation for those changes, move the next_bridge lookup from probe to
> attach, when it is actually used. This allows dw-hdmi to probe, so that the
> hdmi-connector can probe as well.
> 
> Also avoid storing the pointer in hdmi->bridge.next_bridge: the value is
> computed when needed, thus a local variable is enough.
> 
> Finally, this also allows to slightly improve the code by not doing any DT
> lookup in the !DRM_BRIDGE_ATTACH_NO_CONNECTOR case.
> 
> Tested-by: Martyn Welch <martyn.welch@collabora.com>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com> # TQMa8MPxL/MBa8MPxL
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> ---
> 
> Changes in v2:
> - Fix returned error codes
> - Added missing cleanup.h include
> ---
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 45 +++++++++++--------------------
>   1 file changed, 16 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index ab1a6a8783cd..f4a1ebb79716 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -6,6 +6,8 @@
>    * Copyright (C) 2011-2013 Freescale Semiconductor, Inc.
>    * Copyright (C) 2010, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>    */
> +
> +#include <linux/cleanup.h>
>   #include <linux/clk.h>
>   #include <linux/delay.h>
>   #include <linux/err.h>
> @@ -2914,9 +2916,20 @@ static int dw_hdmi_bridge_attach(struct drm_bridge *bridge,
>   	if (WARN_ON((flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR) && !hdmi->plat_data->output_port))
>   		return -EINVAL;
>   
> -	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
> -		return drm_bridge_attach(encoder, hdmi->bridge.next_bridge,
> -					 bridge, flags);
> +	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR) {
> +		struct device_node *remote __free(device_node) =
> +			of_graph_get_remote_node(hdmi->dev->of_node,
> +						 hdmi->plat_data->output_port, -1);
> +		if (!remote)
> +			return -ENODEV;
> +
> +		struct drm_bridge *next_bridge __free(drm_bridge_put) =
> +			of_drm_find_and_get_bridge(remote);
> +		if (!next_bridge)
> +			return -EPROBE_DEFER;
> +
> +		return drm_bridge_attach(encoder, next_bridge, bridge, flags);
> +	}
>   
>   	return dw_hdmi_connector_create(hdmi);
>   }
> @@ -3307,28 +3320,6 @@ static void dw_hdmi_init_hw(struct dw_hdmi *hdmi)
>    * Probe/remove API, used from platforms based on the DRM bridge API.
>    */
>   
> -static int dw_hdmi_parse_dt(struct dw_hdmi *hdmi)
> -{
> -	struct device_node *remote;
> -
> -	if (!hdmi->plat_data->output_port)
> -		return 0;
> -
> -
> -	remote = of_graph_get_remote_node(hdmi->dev->of_node,
> -					  hdmi->plat_data->output_port,
> -					  -1);
> -	if (!remote)
> -		return -ENODEV;
> -
> -	hdmi->bridge.next_bridge = of_drm_find_and_get_bridge(remote);
> -	of_node_put(remote);
> -	if (!hdmi->bridge.next_bridge)
> -		return -EPROBE_DEFER;
> -
> -	return 0;
> -}
> -
>   bool dw_hdmi_bus_fmt_is_420(struct dw_hdmi *hdmi)
>   {
>   	return hdmi_bus_fmt_is_yuv420(hdmi->hdmi_data.enc_out_bus_format);
> @@ -3373,10 +3364,6 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
>   	mutex_init(&hdmi->cec_notifier_mutex);
>   	spin_lock_init(&hdmi->audio_lock);
>   
> -	ret = dw_hdmi_parse_dt(hdmi);
> -	if (ret < 0)
> -		return ERR_PTR(ret);
> -
>   	ddc_node = of_parse_phandle(np, "ddc-i2c-bus", 0);
>   	if (ddc_node) {
>   		hdmi->ddc = of_get_i2c_adapter_by_node(ddc_node);
> 

Tested-by: Damon Ding <damon.ding@rock-chips.com> (on rk3399)

Best regards,
Damon

