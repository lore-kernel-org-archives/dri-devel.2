Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C198C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:35:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99C1310EDFC;
	Tue,  7 Jul 2026 15:35:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="a7rgeW9A";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 765C410EDFC
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:35:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 39A9142B68
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0EA1F000E9;
 Tue,  7 Jul 2026 15:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783438549;
 bh=HaMy4yJupZA9Ss0YIx3n3Ev8b72RKCQcfJltACUl2VE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=a7rgeW9Ai9ywjoWczQkWXfpIOZavxLAXXwMOuGsQ2cTHw1OEb9mgFld0V5tmrSwyV
 6fFWlW7RQbCBEOb/zRnv9m0lKij3AN0iojC71Dji51YQCEa0bcRQ8BeRTLsbDQPhqE
 7fRWckRFpFSMbawyxJIUyvKYWb4LiL5r+LWVXQ9NKULEZUy50WQyQZhUl7Ff0wIR5L
 wFB772cdoxfK56epNNIhOywC2+deAHUa7zV5cP+Xgy/WAIlMt13lMFwmoUwmPct9Ar
 /JXNxAi2VNa/sPFagonertYEhAV0NtOk7LTVw+b3aXD1cuv5eNqK0IlVCKjr8f6u2g
 05XFwUIdsHe1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/37] drm/bridge: megachips-stdpxxxx-ge-b850v3-fw:
 Add atomic bridge state handlers
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707-drm-all-atomic-bridges-v2-12-21d03cbca446@kernel.org>
References: <20260707-drm-all-atomic-bridges-v2-0-21d03cbca446@kernel.org>
 <20260707-drm-all-atomic-bridges-v2-12-21d03cbca446@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 15:35:48 +0000
Message-Id: <20260707153548.EF0EA1F000E9@smtp.kernel.org>
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
- [High] The IRQ handler dereferences a global pointer that is set to NULL =
on partial device unbind, leading to a race condition and a guaranteed kern=
el crash if an interrupt fires.
- [High] Unbinding and rebinding either of the I2C drivers permanently brea=
ks the bridge.
--

--- Patch [12]: [PATCH v2 12/37] drm/bridge: megachips-stdpxxxx-ge-b850v3-f=
w: Add atomic bridge state handlers ---
commit a14f762105b409d757000a124c825edac22d569b
Author: Maxime Ripard <mripard@kernel.org>

drm/bridge: megachips-stdpxxxx-ge-b850v3-fw: Add atomic bridge state handle=
rs

The megachips-stdpxxxx-ge-b850v3-fw bridge doesn't implement any enable
or disable callbacks, but is still missing the atomic state handlers.
In order to remove the legacy bridge callback support from the DRM
bridge core, add them.

> diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c b/d=
rivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> index 2d02cc69f2374..25ff0a0acc934 100644
> --- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> +++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> @@ -214,6 +214,9 @@ static int ge_b850v3_lvds_attach(struct drm_bridge *b=
ridge,
>  }
> =20
>  static const struct drm_bridge_funcs ge_b850v3_lvds_funcs =3D {
> +	.atomic_create_state =3D drm_atomic_helper_bridge_create_state,
> +	.atomic_destroy_state =3D drm_atomic_helper_bridge_destroy_state,
> +	.atomic_duplicate_state =3D drm_atomic_helper_bridge_duplicate_state,
>  	.attach =3D ge_b850v3_lvds_attach,
>  	.detect =3D ge_b850v3_lvds_bridge_detect,
>  	.edid_read =3D ge_b850v3_lvds_edid_read,
>  };

[Severity: High]
This is a pre-existing issue, but unbinding and rebinding either of the I2C
drivers appears to permanently break the bridge.

When either device unbinds, ge_b850v3_lvds_remove() clears the global
ge_b850v3_lvds_ptr:

drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c:ge_b850v3_lvds_rem=
ove() {
    ...
    ge_b850v3_lvds_ptr =3D NULL;
    ...
}

If the unbound device is rebound, ge_b850v3_lvds_init() allocates a new str=
uct:

drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c:ge_b850v3_lvds_ini=
t() {
    ...
    ge_b850v3_lvds_ptr =3D devm_drm_bridge_alloc(dev, struct ge_b850v3_lvds,
                                               bridge, &ge_b850v3_lvds_func=
s);
    ...
}

Because the other device's probe function does not run again, the new struc=
t=20
never receives the i2c_client pointer for the other device. Does this cause=
 the=20
initialization check in stdp2690_ge_b850v3_fw_probe() to fail and prevent=20
the bridge from registering?

drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c:stdp2690_ge_b850v3=
_fw_probe() {
    ...
    /* Only register after both bridges are probed */
    if (!ge_b850v3_lvds_ptr->stdp4028_i2c)
        return 0;
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but could this logic also introd=
uce
a race condition leading to a NULL pointer dereference?

Because the IRQ is managed via devm_request_threaded_irq() on stdp4028, it=
=20
remains active until devres cleanup runs. If the interrupt fires after=20
ge_b850v3_lvds_remove() sets ge_b850v3_lvds_ptr to NULL, the IRQ handler=20
unconditionally dereferences the NULL pointer:

drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c:ge_b850v3_lvds_irq=
_handler() {
    struct i2c_client *stdp4028_i2c =3D ge_b850v3_lvds_ptr->stdp4028_i2c;
    ...
}

Could this lead to a kernel panic if an interrupt occurs during or after an=
=20
unbind?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-drm-all-at=
omic-bridges-v2-0-21d03cbca446@kernel.org?part=3D12
