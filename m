Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77978CDE000
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 17:37:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70F4E10E234;
	Thu, 25 Jun 2026 17:37:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b3KPhaw4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C430210F367
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 17:37:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 73CA641911;
 Thu, 25 Jun 2026 17:37:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231A51F000E9;
 Thu, 25 Jun 2026 17:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782409035;
 bh=aYmxcP1oezn1ulEbdwWgQWPNv5O8WQCMRXO63T/poX8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=b3KPhaw4G5cfDjMLmmnXoMKUrsD810CqeqXMhxpH/dc/8cfn3BNNB+Ma4hYsdWJmX
 V9uk5Oikvk2f4k9OBFZOfljtrGDw8YNgllSZLbCGxbRQm+z+6sXEafqN8LJ9TgrxDb
 uCzft9Pow9N3IfZQSTz42Eb41FqigRvOejld/MeRvKbQwY2x4zgojlHNiYCBtjfl95
 GtHdpmTChkNDejxu9AhB/ea7miZ61J6gak7WkPoYD7To70fxZiq08cb/hF1xdHicot
 yK8ebcpfLLto7Hm2RV4r6nEiDDol9mh10pLSIpFD1l9QQH2ZPmMwcjYkD+WfTToWfj
 eO/ebVZTLuG0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] drm: renesas: rz-du: Add support for RZ/G3L LVDS
 encoder
To: Biju <biju.das.au@gmail.com>
Cc: dri-devel@lists.freedesktop.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260625172359.292631-3-biju.das.jz@bp.renesas.com>
References: <20260625172359.292631-1-biju.das.jz@bp.renesas.com>
 <20260625172359.292631-3-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 17:37:14 +0000
Message-Id: <20260625173715.231A51F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Defensive early returns in atomic_enable lead to fatal hardware ac=
cesses and PM usage underflows in atomic_disable.
- [Low] The DRM_RZG3L_LVDS tristate bypasses COMPILE_TEST because it is def=
ined as `def_tristate DRM_RZG2L_DU`.
- [Low] The drm_bridge_funcs structure uses a non-existent field atomic_cre=
ate_state.
--

commit a2b7ae8085ac6654454a6b3e2051bf293a87e7b9
Author: Biju Das <biju.das.jz@bp.renesas.com>

    drm: renesas: rz-du: Add support for RZ/G3L LVDS encoder

    Add support for the RZ/G3L LVDS encoder driver. It operates in single-l=
ink
    mode with 4 lanes (Data) + 1 lane (Clock) and supports pixel clock rates
    from 25 to 87 MHz.

> diff --git a/drivers/gpu/drm/renesas/rz-du/Kconfig b/drivers/gpu/drm/rene=
sas/rz-du/Kconfig
> index 7f2ef7137ae53..0dbe86bd65d09 100644
> --- a/drivers/gpu/drm/renesas/rz-du/Kconfig
> +++ b/drivers/gpu/drm/renesas/rz-du/Kconfig
> @@ -26,3 +26,16 @@ config DRM_RZG2L_MIPI_DSI
[ ... ]
> +config DRM_RZG3L_USE_LVDS
> +	bool "RZ/G3L DU LVDS Encoder Support"
> +	depends on DRM_BRIDGE && OF
> +	depends on DRM_RZG2L_DU || COMPILE_TEST
> +	default DRM_RZG2L_DU
> +	help
> +	  Enable support for the RZ/G3L Display Unit embedded LVDS encoder.
> +
> +config DRM_RZG3L_LVDS
> +	def_tristate DRM_RZG2L_DU

[Severity: Low]
Does this hardcoded default bypass the COMPILE_TEST intent?

If DRM_RZG2L_DU is disabled (such as during cross-compilation testing), this
evaluates to 'n' even if COMPILE_TEST and DRM_RZG3L_USE_LVDS are enabled.
This could prevent the module from being built for test coverage.

> +	depends on DRM_RZG3L_USE_LVDS
> +	select DRM_KMS_HELPER
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c b/drivers/gpu/drm=
/renesas/rz-du/rzg3l_lvds.c
> new file mode 100644
> index 0000000000000..d8325de658c18
> --- /dev/null
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c
> @@ -0,0 +1,282 @@
[ ... ]
> +static void rzg3l_lvds_atomic_enable(struct drm_bridge *bridge,
> +				     struct drm_atomic_commit *state)
> +{
> +	struct rzg3l_lvds *lvds =3D bridge_to_rzg3l_lvds(bridge);
> +	const struct drm_bridge_state *bridge_state;
> +	u32 fmt;
> +
> +	/* Get the LVDS format from the bridge state. */
> +	bridge_state =3D drm_atomic_get_new_bridge_state(state, bridge);
> +	if (WARN_ON(!bridge_state))
> +		return;

[ ... ]

> +	if (WARN_ON(pm_runtime_get_sync(lvds->dev) < 0))
> +		return;

[Severity: High]
If these defensive WARN_ON checks trigger and the function returns early,
could it lead to issues during teardown?

Since the DRM core considers the bridge enabled, rzg3l_lvds_atomic_disable()
will eventually be called. This function unconditionally touches memory-map=
ped
registers and drops the PM reference:

rzg3l_lvds_atomic_disable()
{
	...
	regmap_update_bits(lvds->regmap, LVDS_CMN, LVDS_CMN_PHY_RESET, 0);
	...
	pm_runtime_put(lvds->dev);
}

Accessing registers of an unpowered hardware block and dropping an
unincremented PM reference could cause a synchronous external abort or
PM usage counter underflow.

[ ... ]

> +static const struct drm_bridge_funcs rzg3l_lvds_bridge_ops =3D {
> +	.attach =3D rzg3l_lvds_attach,
> +	.atomic_duplicate_state =3D drm_atomic_helper_bridge_duplicate_state,
> +	.atomic_destroy_state =3D drm_atomic_helper_bridge_destroy_state,
> +	.atomic_create_state =3D drm_atomic_helper_bridge_create_state,

[Severity: Low]
Is the atomic_create_state function available in the current codebase?

The drm_bridge_funcs structure doesn't seem to have an atomic_create_state
member, and drm_atomic_helper_bridge_create_state doesn't appear to exist.
Would it be more appropriate to use .atomic_reset and
drm_atomic_helper_bridge_reset instead?

> +	.atomic_enable =3D rzg3l_lvds_atomic_enable,
> +	.atomic_disable =3D rzg3l_lvds_atomic_disable,
> +	.mode_valid =3D rzg3l_lvds_bridge_mode_valid,
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625172359.2926=
31-1-biju.das.jz@bp.renesas.com?part=3D2
