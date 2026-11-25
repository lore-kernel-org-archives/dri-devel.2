Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0371606A68B
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CmfZWSg3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E4FC10FECB;
	Wed, 25 Nov 2026 18:14:30 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7F7210FEC9
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:14:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5C85162869;
 Wed, 25 Nov 2026 18:14:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9301F000D3;
 Wed, 25 Nov 2026 18:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795630462;
 bh=2k9mIGpiUoz/+tRof37PRM5uwmQ6bYmt9mVDu/ksd5Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CmfZWSg3NKt8pFao81aFw6IYUFwJWpGdBC2awkMsdHrMu4Iv523cPt/NiYRX0pJBw
 rjHDCbStnFqgz1/P1BnVEKth7/xJYBQFn9dJGw05MSvXW43wVU7Vi7ylZdl7rm/d5A
 teR1tmyWHBpFrrlxh8AK0qEkfoLVl6tNd5hM28fKX2lN7hc02W4ieN5KFmX1/YAc8F
 G2d6KJF7mwHB+gt2hoabWFXlnlc82Dpmas5YPpl1VZgNCwfkPdXfEg/0MvFa/yPCwX
 jZMpRTTnviKB9g5k80BLtMrBzTjK4I6FMj1qGU55uDSdbOrlFWQf2yHahUnomeXxo0
 QX0oLN8x5FzPg==
Message-ID: <sashiko-outbox-233932@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 23/32] drm/bridge: ti-sn65dsi83: implement
 .get_next_bridge
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20261125-drm-bridge-hotplug-v4-23-822722850492@bootlin.com>
References: <20261125-drm-bridge-hotplug-v4-0-822722850492@bootlin.com>
 <20261125-drm-bridge-hotplug-v4-23-822722850492@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 18:14:21 +0000
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
- [High] drm/bridge: ti-sn65dsi83: use-after-free in
  sn65dsi83_get_next_bridge()
--

commit 07f44b5de19c58e65f65432a2a999004dd04f3ae
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/bridge: ti-sn65dsi83: implement .get_next_bridge

This commit implements the .get_next_bridge callback for the ti-sn65dsi83
bridge driver to return a reference to ctx->panel_bridge.

> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi83.c
> index 77ef1613c5f51..9e9cf0dda92d8 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -295,6 +295,13 @@ static struct sn65dsi83 *bridge_to_sn65dsi83(struct =
drm_bridge *bridge)
>  	return container_of(bridge, struct sn65dsi83, bridge);
>  }
> =20
> +static struct drm_bridge *sn65dsi83_get_next_bridge(struct drm_bridge *b=
ridge)
> +{
> +	struct sn65dsi83 *ctx =3D bridge_to_sn65dsi83(bridge);
> +
> +	return ctx->panel_bridge ? drm_bridge_get(ctx->panel_bridge) : ERR_PTR(=
-ENODEV);
> +}

[Severity: High]
Can sn65dsi83_get_next_bridge() cause a use-after-free on
ctx->panel_bridge?

sn65dsi83_parse_dt() acquires ctx->panel_bridge via
devm_drm_of_get_bridge() -> drm_of_find_panel_or_bridge():

drivers/gpu/drm/drm_panel.c:drm_of_find_panel_or_bridge() {
	...
	if (bridge) {
		...
		*bridge =3D of_drm_find_bridge(remote);
		if (*bridge)
			return 0;
	}
	...
}

When the remote DT node is a non-panel bridge, of_drm_find_bridge() drops
the bridge reference before returning, so ctx->panel_bridge holds no
reference.  If the downstream bridge is later removed and freed while
sn65dsi83 stays bound, drm_bridge_get(ctx->panel_bridge) increments the
refcount on freed memory and returns a dangling pointer.

Even when the remote node is a drm_panel, devm_drm_panel_bridge_add() is
registered on ctx->dev after devm_drm_bridge_alloc(), so on unbind devres
puts ctx->panel_bridge before ctx->bridge is destroyed without clearing
ctx->panel_bridge; a concurrent holder of ctx->bridge calling
drm_bridge_get_next() can then access ctx->panel_bridge after its
reference was dropped.  Acquiring the downstream bridge with
of_drm_get_bridge_by_endpoint() and storing it in ctx->bridge.next_bridge
(or releasing it in a bridge .destroy callback) would keep the reference
alive for the lifetime of ctx->bridge.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-drm-bridge=
-hotplug-v4-0-822722850492@bootlin.com?part=3D23
