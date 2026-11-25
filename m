Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708A6606A688
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X2DIDqel
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C71A310FECD;
	Wed, 25 Nov 2026 18:15:19 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BB5110FECD
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:15:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 87D2A62911;
 Wed, 25 Nov 2026 18:15:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A801F000C0;
 Wed, 25 Nov 2026 18:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795630512;
 bh=9lB/xFWL4Pzo0WnzIskfHv5oUIqZaZ2B8c0og2Lfn70=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=X2DIDqeljQ3868RIgDSLwUc0q2Ps46ZFiwQ4GCP7Zp1AVYjAa+Q3GpTCN9YDiyzGS
 +QGRC1jufIYFKYOEoxbe4zKsFkkiORIJy6+fQXkVLubsVUr0ADINRJfjp+pJ7H+3U7
 1Eeb3N4hb99qLVJ9Iw4l6I+ubP19DahGCmsLjYxBSgob0qFdZNM+mqLI3t+6Aur10/
 nN5y4hbdYbRueINBT+thvE3o4+Bi1A/d83FBQ6UqsDsX8lADUtRlhmloEiN2eFswhu
 jM8xlaCTCfsQE6BBiZ0iy5ALLMj1J1YD/z2Gr4OwPymh6Sye42ktjP4f06stdsl8TS
 1fxuCxZM5Oo+w==
Message-ID: <sashiko-outbox-233939@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 25/32] drm/bridge: samsung-dsim: implement
 .get_next_bridge
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20261125-drm-bridge-hotplug-v4-25-822722850492@bootlin.com>
References: <20261125-drm-bridge-hotplug-v4-0-822722850492@bootlin.com>
 <20261125-drm-bridge-hotplug-v4-25-822722850492@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 18:15:11 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/bridge: samsung-dsim: next_bridge set after
  drm_bridge_add()
--

commit 1b84a9a9872c3d15595f65a9e6b8efef31c355b5
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/bridge: samsung-dsim: implement .get_next_bridge

This commit implements the .get_next_bridge callback and sets
DRM_BRIDGE_OP_GET_NEXT_BRIDGE in the samsung-dsim bridge driver.

> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/brid=
ge/samsung-dsim.c
> index 480e568dd2c9d..a00902871b79e 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -1821,6 +1821,13 @@ static void samsung_dsim_mode_set(struct drm_bridg=
e *bridge,
>  	drm_mode_copy(&dsi->mode, adjusted_mode);
>  }
> =20
> +static struct drm_bridge *samsung_dsim_get_next_bridge(struct drm_bridge=
 *bridge)
> +{
> +	struct samsung_dsim *dsi =3D bridge_to_dsi(bridge);
> +
> +	return dsi->bridge.next_bridge ? drm_bridge_get(dsi->bridge.next_bridge=
) : ERR_PTR(-ENODEV);
> +}

[Severity: Medium]
Can samsung_dsim_get_next_bridge() observe dsi->bridge.next_bridge as NULL
when drm_bridge_add() notifies listeners?

In samsung_dsim_host_attach(), drm_bridge_add(&dsi->bridge) is called
before dsi->bridge.next_bridge is assigned:

drivers/gpu/drm/bridge/samsung-dsim.c:samsung_dsim_host_attach() {
	...
	drm_bridge_add(&dsi->bridge);

	if (!(device->mode_flags & MIPI_DSI_MODE_VIDEO)) {
		ret =3D samsung_dsim_register_te_irq(dsi, &device->dev);
		if (ret)
			goto err_remove_bridge;
	}

	// The next bridge can be used by host_ops->attach
	dsi->bridge.next_bridge =3D drm_bridge_get(next_bridge);
	...
}

Because drm_bridge_add() publishes &dsi->bridge on bridge_list and
synchronously emits DRM_BRIDGE_ADDED, a hotplug handler such as
drm_hotplug_helper_bridge_notif() runs before dsi->bridge.next_bridge is
populated.  Calling drm_bridge_get_next() from that notification returns
ERR_PTR(-ENODEV), and drm_hotplug_helper_try_complete() ->
drm_bridge_attach() -> samsung_dsim_attach() passes NULL to
drm_bridge_attach(), failing with -EINVAL and logging a DRM_ERROR().

Assigning dsi->bridge.next_bridge before calling drm_bridge_add() (and
cleaning it up on error) would ensure it is valid as soon as the bridge is
published.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-drm-bridge=
-hotplug-v4-0-822722850492@bootlin.com?part=3D25
