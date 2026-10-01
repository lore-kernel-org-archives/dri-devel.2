Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11408CA5FD2
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 12:56:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AD0710F673;
	Thu,  1 Oct 2026 12:56:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lRMAZrB3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD0F010F687
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 12:56:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6113960A52;
 Thu,  1 Oct 2026 12:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA98C1F00898;
 Thu,  1 Oct 2026 12:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790859383;
 bh=GBYbsLvB8sQfIkbUWlfdS6QGz1L1TQBtYqemXDZYJho=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lRMAZrB3dpxGXtZto9MJS0L9uo8GAQoeOYbzxe1vH92VpWBBAcyG7DfqmHQNbHe3+
 7V06mwCmrIh2kglngJZLWnreNCkdI/Qd/UyY/40alnpqRMhSFKZmTloLUVs8JppFq7
 wjrraf5qgRO/z+1STDv/y+nn3kAJGatb4sbyPkFgUyWOzmKDk8NI7nt9l9WLUpzqTW
 rzAGvucDItpLjMc+r9t4OvL4bQZdkWgMiBdhqi55qq2/KQVZRnVPK2ZiW+LZJ94UeC
 XW9ZWlShj+c62kbwsGUkGye9jfKDG/jIRomQ07F2dmKiO8KPZakdsPzTBhN6K0Yqpd
 0wV+mliPXWbeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 06/24] drm/display: bridge-connector: add APIs to
 add/remove the connector dynamically
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: Frank.Li@kernel.org, dri-devel@lists.freedesktop.org, imx@lists.linux.dev
In-Reply-To: <20261001-drm-bridge-hotplug-v2-6-8e34986dcb68@bootlin.com>
References: <20261001-drm-bridge-hotplug-v2-0-8e34986dcb68@bootlin.com>
 <20261001-drm-bridge-hotplug-v2-6-8e34986dcb68@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 12:56:22 +0000
Message-Id: <20261001125622.CA98C1F00898@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/display: UAF in CEC unregister due to decoupled lifetimes
- [Medium] drm/display: memory leak in drm_bridge_connector_init() error pa=
ths
--

commit 53e1c33d3e43a19a4088655af78ef18e7e7c5200
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/display: bridge-connector: add APIs to add/remove the connector dynamic=
ally

This commit changes bridge connector allocation to use standard non-managed
allocations (kzalloc_obj) instead of drmm_kzalloc(), and introduces
dynamic add/remove functions, to prepare for bridge hotplug.

> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu=
/drm/display/drm_bridge_connector.c
> index 1c222e27767d4..2a0065208fb8a 100644
> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
> @@ -285,6 +285,7 @@ static void drm_bridge_connector_dynconn_destroy(stru=
ct drm_connector *connector
> =20
>  	drm_connector_cleanup(connector);
>  	drm_bridge_connector_put_bridges(bridge_connector);
> +	kfree(bridge_connector);
>  }

[Severity: High]
Can this cause a use-after-free during device teardown?

During initialization, the connector may register drmm managed cleanup
actions on the parent drm_device (such as calling
drmm_connector_hdmi_cec_notifier_register() inside
drm_bridge_connector_initialize()).

If a dynamic bridge connector is hot-removed, this function will call
kfree() on bridge_connector while those drmm actions are still queued on
the drm_device.

When the parent drm_device is later torn down, could those managed actions
execute and access the already freed connector memory?

[ ... ]

> @@ -1184,7 +1185,7 @@ struct drm_connector *drm_bridge_connector_init(str=
uct drm_device *drm,
>  	struct drm_connector *connector;
>  	int ret;
> =20
> -	bridge_connector =3D drmm_kzalloc(drm, sizeof(*bridge_connector), GFP_K=
ERNEL);
> +	bridge_connector =3D kzalloc_obj(*bridge_connector);
>  	if (!bridge_connector)
>  		return ERR_PTR(-ENOMEM);
> =20

[Severity: Medium]
Since bridge_connector is now allocated with kzalloc_obj() instead of
drmm_kzalloc(), does this leak bridge_connector if the subsequent call to
drm_bridge_connector_initialize() fails and returns an error pointer?

[ ... ]

> @@ -1199,3 +1200,24 @@ struct drm_connector *drm_bridge_connector_init(st=
ruct drm_device *drm,
>  	return connector;
>  }
>  EXPORT_SYMBOL_GPL(drm_bridge_connector_init);
> +
> +struct drm_connector *drm_bridge_connector_dynamic_add(struct drm_device=
 *drm,
> +						       struct drm_encoder *encoder)
> +{
> +	struct drm_bridge_connector *bridge_connector;
> +
> +	bridge_connector =3D kzalloc_obj(*bridge_connector);
> +	if (!bridge_connector)
> +		return ERR_PTR(-ENOMEM);
> +
> +	return drm_bridge_connector_initialize(bridge_connector, drm, encoder);
> +}

[Severity: Medium]
Similarly here, if drm_bridge_connector_initialize() returns an error, will
it leak the bridge_connector allocation instead of freeing it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-drm-bridge=
-hotplug-v2-0-8e34986dcb68@bootlin.com?part=3D6
