Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D28FC43602
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:28:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D723710E4FC;
	Tue,  7 Jul 2026 15:28:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lniLoYXK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7583B10E4FC
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:28:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D76B760018
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:28:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ECC21F000E9;
 Tue,  7 Jul 2026 15:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783438137;
 bh=AMK3JkYGPaMyDti1/nCUzTAaREXC0uUyuHsysQuikpY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lniLoYXKH+zM9p+gSljrS8+vuclbgcC6xdXdspcaa+2Uy8COxgDpJo9WQ//SxvnwC
 UyKieKlOAtSxVlxBBXGS+wQxebw/GgQvCg34kwR8OVnr7uFX5rRZv1ytSAn/M7VYKf
 wTsDKZwRDBCB10Lmq3aQ5w5IF+1HD+soNRg16ndHKuNdKkRQN0STmzaIY6GVuQxoSL
 /IQdE8pKU4+gughjD4cJvMBk8BwDNkbCK8v04K1+rmnhtWB1DRZaK/3udlmQIVrBy1
 1nxZh/PFXaFTAF1GtH0sWdjhVckjPeVki9Lv97LUUhDDO+0UnyYVZ/d/BSX2jQjNtU
 IZlghf+23wHLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/37] drm/bridge: analogix-anx6345: Switch to atomic
 bridge callbacks
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707-drm-all-atomic-bridges-v2-2-21d03cbca446@kernel.org>
References: <20260707-drm-all-atomic-bridges-v2-0-21d03cbca446@kernel.org>
 <20260707-drm-all-atomic-bridges-v2-2-21d03cbca446@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 15:28:56 +0000
Message-Id: <20260707152857.6ECC21F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] The panel is enabled before it is prepared (powered on) in the bri=
dge enable sequence, violating the DRM panel API contracts and causing pote=
ntial hardware issues.
- [High] Bridge `atomic_enable` and `atomic_disable` callbacks invoke sleep=
ing functions, violating atomic context constraints.
--

--- Patch [2]: [PATCH v2 02/37] drm/bridge: analogix-anx6345: Switch to ato=
mic bridge callbacks ---
commit c3398824f07e9152c87164f9494fed0231949fb3
Author: Maxime Ripard <mripard@kernel.org>

drm/bridge: analogix-anx6345: Switch to atomic bridge callbacks
   =20
The analogix-anx6345 bridge uses the legacy non-atomic enable and
disable bridge callbacks.
   =20
In order to remove the legacy bridge callback support from the DRM
bridge core, switch to their atomic counterparts and add the bridge
atomic state handlers.

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c b/drivers=
/gpu/drm/bridge/analogix/analogix-anx6345.c
> index f3fe47b12edca..eba5c6dcb5ada 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
[ ... ]
> @@ -580,7 +581,8 @@ static void anx6345_bridge_disable(struct drm_bridge =
*bridge)
>  		anx6345_poweroff(anx6345);
>  }
> =20
> -static void anx6345_bridge_enable(struct drm_bridge *bridge)
> +static void anx6345_bridge_enable(struct drm_bridge *bridge,
> +				  struct drm_atomic_commit *commit)
>  {
>  	struct anx6345 *anx6345 =3D bridge_to_anx6345(bridge);
>  	int err;
> @@ -600,11 +602,14 @@ static void anx6345_bridge_enable(struct drm_bridge=
 *bridge)

[Severity: High]
This is a pre-existing issue, but does this function enable the panel before
it is prepared?

In anx6345_bridge_enable(), we have:

	if (anx6345->panel)
		drm_panel_enable(anx6345->panel);

	err =3D anx6345_start(anx6345);

And anx6345_start() eventually calls anx6345_poweron() which prepares the
panel:

	if (anx6345->panel)
		drm_panel_prepare(anx6345->panel);

On a secondary modeset (after the device has been disabled),
anx6345->powered is false. anx6345_bridge_enable() calls drm_panel_enable()
which turns on the backlight. It then calls anx6345_start() which invokes
anx6345_poweron() and drm_panel_prepare() to power on the LCD logic.

Could this inverted enable -> prepare sequence turn on the backlight while
the panel power is off, potentially causing latch-up and physically damaging
the LCD logic on some displays?

>  }
> =20
>  static const struct drm_bridge_funcs anx6345_bridge_funcs =3D {
> +	.atomic_create_state =3D drm_atomic_helper_bridge_create_state,
> +	.atomic_destroy_state =3D drm_atomic_helper_bridge_destroy_state,
> +	.atomic_duplicate_state =3D drm_atomic_helper_bridge_duplicate_state,
>  	.attach =3D anx6345_bridge_attach,
>  	.detach =3D anx6345_bridge_detach,
>  	.mode_valid =3D anx6345_bridge_mode_valid,
> -	.disable =3D anx6345_bridge_disable,
> -	.enable =3D anx6345_bridge_enable,
> +	.atomic_disable =3D anx6345_bridge_disable,
> +	.atomic_enable =3D anx6345_bridge_enable,

[Severity: High]
This is a pre-existing issue, but does mapping these callbacks to atomic
contexts conflict with the sleeping functions they invoke?

The bridge atomic_enable and atomic_disable callbacks execute in the context
of atomic commits (e.g., drm_atomic_helper_commit_tail), where sleeping is
forbidden.

However, anx6345_bridge_enable() and anx6345_bridge_disable() invoke
hardware sequencing functions like anx6345_start(), anx6345_poweron(), and
anx6345_poweroff().

For example, anx6345_start() contains:

	usleep_range(10000, 15000);

And anx6345_poweron() contains:

	gpiod_set_value_cansleep(anx6345->gpiod_reset, 1);
	usleep_range(1000, 2000);

Could calling these sleeping functions from the atomic context cause kernel
panics or BUG warnings (scheduling while atomic)?

>  };
> =20
>  static void unregister_i2c_dummy_clients(struct anx6345 *anx6345)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-drm-all-at=
omic-bridges-v2-0-21d03cbca446@kernel.org?part=3D2
