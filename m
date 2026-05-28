Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888D4CD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 15:46:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA03C10F3C9;
	Thu, 28 May 2026 15:46:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="R0mlm6TV";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66CC810E27F
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 15:46:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779983187; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GHWMHdoWNcU15l0hvRveP46RyYdqPgCNIeJOJbgJI9JBobYiofMCMQDP9tkyRw47bS6196r8P9gujSO6cNJ9Ac5kv/bPGASHU7fkljblkRp5xGqhzxVFEPJvBplRIblIb4HnGhMU1zkIXRKyOlTy8syLsNSciYqlZYJrNnrZGdg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779983187;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=TdX9/bZga6Qg6ao7lAnopeSLFZmhgNqsCFRMGQo40M0=; 
 b=hnRAzfqXviyjhZIjxpBSmwxqGkCfShiXtPnNYqedxGvcMfnf2fvfm9L00qulOPvmRbankDXGxKrmhNds05DPIqHJVOPhitigUxdoObfdeZRi2AXap80Tcxqq4s4Jgja7nsUTW8KIao9gayS/yaqATsbLz2nRRej1dIwvOkRhUcc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779983187; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=TdX9/bZga6Qg6ao7lAnopeSLFZmhgNqsCFRMGQo40M0=;
 b=R0mlm6TVO+9eUKq9MnKnKU3dLEa/hEkLVmVw68chR+YqDd8tvgRJEpMlFBM5I/5b
 c6+TcHKMz7YIBp1eqtoYItnX8cbubTExtEOZ+GY+weuPi7GZAMLommCqfp7gb4Fd1hy
 09jBTk09vbl4tp4nh1BvU45oHlAvHghEBJXyExbE=
Received: by mx.zohomail.com with SMTPS id 1779983186292414.93444418879574;
 Thu, 28 May 2026 08:46:26 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Peter Chen <hzpeterchen@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Yubing Zhang <yubing.zhang@rock-chips.com>,
 Frank Wang <frank.wang@rock-chips.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Amit Sunil Dhamne <amitsd@google.com>, Dragan Simic <dsimic@manjaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Diederik de Haas <didi.debian@cknow.org>,
 Peter Robinson <pbrobinson@gmail.com>, Hugh Cole-Baker <sigmaris@gmail.com>,
 dri-devel@lists.freedesktop.org, Chaoyi Chen <kernel@airkyi.com>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 dri-devel@lists.freedesktop.org, Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: Re: [PATCH v15 2/9] drm/bridge: aux: Add
 drm_aux_bridge_register_from_node()
Date: Thu, 28 May 2026 17:46:15 +0200
Message-ID: <zQEH3WYtRMCn07SWaZMzgQ@collabora.com>
In-Reply-To: <20260304094152.92-3-kernel@airkyi.com>
References: <20260304094152.92-1-kernel@airkyi.com>
 <20260304094152.92-3-kernel@airkyi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

On Wednesday, 4 March 2026 10:41:45 Central European Summer Time Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> The drm_aux_bridge_register() uses the device->of_node as the
> bridge->of_node.
> 
> This patch adds drm_aux_bridge_register_from_node() to allow
> specifying the of_node corresponding to the bridge.
> 
> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> 
> (no changes since v11)
> ---
> 
>  drivers/gpu/drm/bridge/aux-bridge.c | 24 ++++++++++++++++++++++--
>  include/drm/bridge/aux-bridge.h     |  6 ++++++
>  2 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/aux-bridge.c b/drivers/gpu/drm/bridge/aux-bridge.c
> index b3e4cdff61d6..52dff4601c2d 100644
> --- a/drivers/gpu/drm/bridge/aux-bridge.c
> +++ b/drivers/gpu/drm/bridge/aux-bridge.c
> @@ -35,6 +35,7 @@ static void drm_aux_bridge_unregister_adev(void *_adev)
>  /**
>   * drm_aux_bridge_register - Create a simple bridge device to link the chain

Function name needs to be changed here as well. You can validate
kernel doc strings for a single file with:

  ./tools/docs/kernel-doc -v -none drivers/gpu/drm/bridge/aux-bridge.c

With that fixed:

Reviewed-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Kind regards,
Nicolas Frattaroli

>   * @parent: device instance providing this bridge
> + * @np: device node pointer corresponding to this bridge instance
>   *
>   * Creates a simple DRM bridge that doesn't implement any drm_bridge
>   * operations. Such bridges merely fill a place in the bridge chain linking
> @@ -42,7 +43,7 @@ static void drm_aux_bridge_unregister_adev(void *_adev)
>   *
>   * Return: zero on success, negative error code on failure
>   */
> -int drm_aux_bridge_register(struct device *parent)
> +int drm_aux_bridge_register_from_node(struct device *parent, struct device_node *np)
>  {
>  	struct auxiliary_device *adev;
>  	int ret;
> @@ -62,7 +63,10 @@ int drm_aux_bridge_register(struct device *parent)
>  	adev->dev.parent = parent;
>  	adev->dev.release = drm_aux_bridge_release;
>  
> -	device_set_of_node_from_dev(&adev->dev, parent);
> +	if (np)
> +		device_set_node(&adev->dev, of_fwnode_handle(np));
> +	else
> +		device_set_of_node_from_dev(&adev->dev, parent);
>  
>  	ret = auxiliary_device_init(adev);
>  	if (ret) {
> @@ -80,6 +84,22 @@ int drm_aux_bridge_register(struct device *parent)
>  
>  	return devm_add_action_or_reset(parent, drm_aux_bridge_unregister_adev, adev);
>  }
> +EXPORT_SYMBOL_GPL(drm_aux_bridge_register_from_node);
> +
> +/**
> + * drm_aux_bridge_register - Create a simple bridge device to link the chain
> + * @parent: device instance providing this bridge
> + *
> + * Creates a simple DRM bridge that doesn't implement any drm_bridge
> + * operations. Such bridges merely fill a place in the bridge chain linking
> + * surrounding DRM bridges.
> + *
> + * Return: zero on success, negative error code on failure
> + */
> +int drm_aux_bridge_register(struct device *parent)
> +{
> +	return drm_aux_bridge_register_from_node(parent, NULL);
> +}
>  EXPORT_SYMBOL_GPL(drm_aux_bridge_register);
>  
>  struct drm_aux_bridge_data {
> diff --git a/include/drm/bridge/aux-bridge.h b/include/drm/bridge/aux-bridge.h
> index c2f5a855512f..7dd1f17a1354 100644
> --- a/include/drm/bridge/aux-bridge.h
> +++ b/include/drm/bridge/aux-bridge.h
> @@ -13,11 +13,17 @@ struct auxiliary_device;
>  
>  #if IS_ENABLED(CONFIG_DRM_AUX_BRIDGE)
>  int drm_aux_bridge_register(struct device *parent);
> +int drm_aux_bridge_register_from_node(struct device *parent, struct device_node *np);
>  #else
>  static inline int drm_aux_bridge_register(struct device *parent)
>  {
>  	return 0;
>  }
> +
> +static inline int drm_aux_bridge_register_from_node(struct device *parent, struct device_node *np)
> +{
> +	return 0;
> +}
>  #endif
>  
>  #if IS_ENABLED(CONFIG_DRM_AUX_HPD_BRIDGE)
> 




