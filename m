Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF86C43602
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:38:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A721010EDFE;
	Tue,  7 Jul 2026 15:38:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DdwIjaXw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 221EB10EDFE
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:38:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 64C1C6138A
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:38:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67921F00A3A;
 Tue,  7 Jul 2026 15:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783438714;
 bh=lv7G77OAYUkrzIXw8ZDa2+yCsUz+RYVyzM6232wwiQ8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DdwIjaXwtcpFkEJEMHdwBzX7/FA3CMmY4zLrDOv5BLmQIlXWNA0z/M48AGldlDrPu
 gmU/tj6TDdQvIMQcbyiPc+FZI1lJ5/kZ2+L9sHBJohX6LVkSSA6Ky9QLA3AM/Qacv0
 TcFuqafrsxquwC5j7uuqTUG+ChGB9tc9Xpk6JETEB14tPO7YbRIfJ6JgWSd10zdPLs
 34wGRiuAVm5aaQ+UB1wNIhusT3796ZhDK2qnslE7ux0q2g/NfcyakVf28sLmXQyord
 gdk5RkhbH28k+XCItuueEKamgqij8Yvx/mS6bjOTNJNimvJUbaD/RDjYQi/81tg/9M
 VBAxGAA4TGDZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/37] drm/bridge: microchip-lvds: Add atomic bridge
 state handlers
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707-drm-all-atomic-bridges-v2-13-21d03cbca446@kernel.org>
References: <20260707-drm-all-atomic-bridges-v2-0-21d03cbca446@kernel.org>
 <20260707-drm-all-atomic-bridges-v2-13-21d03cbca446@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 15:38:33 +0000
Message-Id: <20260707153833.E67921F00A3A@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] Missing `.remove` hook for `drm_bridge_remove` causes a use-af=
ter-free upon module unload or device unbind.
- [High] Sleeping function usleep_range() is called from an atomic commit p=
ath.
- [High] Incorrect masking of the WPKEY password truncates the unlock key, =
preventing hardware configuration.
--

--- Patch [13]: [PATCH v2 13/37] drm/bridge: microchip-lvds: Add atomic bri=
dge state handlers ---
commit 489328dd1eddcba7ecc56ad3f142d3a6ed0da2f5
Author: Maxime Ripard <mripard@kernel.org>
drm/bridge: microchip-lvds: Add atomic bridge state handlers

The microchip-lvds bridge doesn't implement any enable or disable
callbacks, but is still missing the atomic state handlers. In order to
remove the legacy bridge callback support from the DRM bridge core, add
them.

> diff --git a/drivers/gpu/drm/bridge/microchip-lvds.c b/drivers/gpu/drm/br=
idge/microchip-lvds.c
> index 5fb8633f43c5c..dd4ffc9f4df3f 100644
> --- a/drivers/gpu/drm/bridge/microchip-lvds.c
> +++ b/drivers/gpu/drm/bridge/microchip-lvds.c
> @@ -167,6 +167,9 @@ static void mchp_lvds_atomic_disable(struct drm_bridg=
e *bridge,
>  }
> =20
>  static const struct drm_bridge_funcs mchp_lvds_bridge_funcs =3D {
> +	.atomic_create_state =3D drm_atomic_helper_bridge_create_state,
> +	.atomic_destroy_state =3D drm_atomic_helper_bridge_destroy_state,
> +	.atomic_duplicate_state =3D drm_atomic_helper_bridge_duplicate_state,
>  	.attach =3D mchp_lvds_attach,
>  	.atomic_enable =3D mchp_lvds_atomic_enable,

[Severity: High]
This isn't a bug introduced by this patch, but does the atomic enable path
safely handle sleeping functions?

The subsystem guide states that bridge atomic enable callbacks run in
atomic context. However, mchp_lvds_atomic_enable() calls
lvds_serialiser_on(), which has a hardware polling loop using usleep_range(=
):

drivers/gpu/drm/bridge/microchip-lvds.c:lvds_serialiser_on() {
	...
	usleep_range(1000, 2000);
	...
}

Can this cause kernel warnings or potential deadlocks during the atomic
commit path?

>  	.atomic_disable =3D mchp_lvds_atomic_disable,
>  };

[Severity: High]
This is a pre-existing issue, but is the WPKEY password being truncated
during initialization?

In lvds_serialiser_on(), the password is masked directly without shifting:

drivers/gpu/drm/bridge/microchip-lvds.c:lvds_serialiser_on() {
	...
	lvds_writel(lvds, LVDSC_WPMR, (LVDSC_WPMR_WPKEY_PSSWD &
				       LVDSC_WPMR_WPKEY_MASK));
	...
}

If LVDSC_WPMR_WPKEY_PSSWD is 0x4C5644 and LVDSC_WPMR_WPKEY_MASK is
GENMASK(31, 8) (0xFFFFFF00), the lower byte 'D' (0x44) gets truncated to
0x00.=20

Does this prevent the write protection from being unlocked, causing
subsequent LVDS configuration writes to be ignored by the hardware?

[Severity: Critical]
This is also a pre-existing issue, but does the driver leave the bridge
registered on unload?

The bridge is registered globally in mchp_lvds_probe() using
drm_bridge_add(), but the platform driver lacks a .remove callback:

drivers/gpu/drm/bridge/microchip-lvds.c:mchp_lvds_driver {
	.probe =3D mchp_lvds_probe,
	.driver =3D {
		.name =3D "microchip-lvds",
		.of_match_table =3D mchp_lvds_dt_ids,
	},
};

Since drm_bridge_remove() is never called to unlink the bridge, and the
mchp_lvds structure is freed automatically by devres, could this lead to a
use-after-free the next time the DRM core traverses the global bridge list?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-drm-all-at=
omic-bridges-v2-0-21d03cbca446@kernel.org?part=3D13
