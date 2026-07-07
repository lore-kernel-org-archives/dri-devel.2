Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC78C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:57:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFF3F10EE42;
	Tue,  7 Jul 2026 15:57:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ExGnBKRZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E4D710EE3D
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:57:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 077CE409C5
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:57:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B537F1F000E9;
 Tue,  7 Jul 2026 15:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783439839;
 bh=wJNV5g6knAtOX6eQ1Ny5bubfzJM2ul/xwFvFYepnQpA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ExGnBKRZdxIBlKlZ9TSpSiASH2159mCN3N+5mOocSoUhRI0QNII3yaDeSJnCxV0cy
 Og+aBWPSq/9/wFk0JDUSvUyjsrr4zmHdb5VQ0+8FtzAquqIArgy+m0eGVcWcXTJ8xi
 XgRL3W9/jjbW6S3xmTTI0Y55tNY0iBz++C6gpNwjM3DsjV+lfHgHHLhpXYkxWemfmj
 wY0ECYvdkY0xyogQeTpwFX5K5rsztIaOiDpQMPas/xWI4V1aFp2ugMoGio89SoNh8+
 mkVMmU+/eEpvbNaXZFGWMR0LpMxdy54nM6YgWdiDI9cd/LAc5B+SEY5qbaoDSMBGnh
 NucEnIOm3kMOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 18/37] drm/bridge: sil-sii8620: Add atomic bridge
 state handlers
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707-drm-all-atomic-bridges-v2-18-21d03cbca446@kernel.org>
References: <20260707-drm-all-atomic-bridges-v2-0-21d03cbca446@kernel.org>
 <20260707-drm-all-atomic-bridges-v2-18-21d03cbca446@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 15:57:19 +0000
Message-Id: <20260707155719.B537F1F000E9@smtp.kernel.org>
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
- [High] The `sii8620_mode_fixup` callback mutates persistent driver state =
(`ctx->use_packed_pixel`), violating the atomic check phase contract.
- [High] `drm_bridge_attach` ignores the return value of `drm_atomic_privat=
e_obj_init`, and `drm_atomic_private_obj_init` fails to roll back on error,=
 leading to a corrupted private object list and a subsequent NULL pointer d=
ereference.
--

--- Patch [18]: [PATCH v2 18/37] drm/bridge: sil-sii8620: Add atomic bridge=
 state handlers ---
commit b25b0389a6c4219ff91245a5da61562f89c23dda
Author: Maxime Ripard <mripard@kernel.org>

drm/bridge: sil-sii8620: Add atomic bridge state handlers

The sil-sii8620 bridge doesn't implement any enable or disable
callbacks, but is still missing the atomic state handlers.
In order to remove the legacy bridge callback support from the DRM
bridge core, add them.

> diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridg=
e/sil-sii8620.c
> index 982306eb4f0a7..22c81b38b41e8 100644
> --- a/drivers/gpu/drm/bridge/sil-sii8620.c
> +++ b/drivers/gpu/drm/bridge/sil-sii8620.c

[ ... ]

> @@ -2280,6 +2281,9 @@ static bool sii8620_mode_fixup(struct drm_bridge *b=
ridge,
>  }
> =20
>  static const struct drm_bridge_funcs sii8620_bridge_funcs =3D {
> +	.atomic_create_state =3D drm_atomic_helper_bridge_create_state,
> +	.atomic_destroy_state =3D drm_atomic_helper_bridge_destroy_state,
> +	.atomic_duplicate_state =3D drm_atomic_helper_bridge_duplicate_state,
>  	.attach =3D sii8620_attach,
>  	.detach =3D sii8620_detach,
>  	.mode_fixup =3D sii8620_mode_fixup,

[Severity: High]
This isn't a bug introduced by this patch, but doesn't sii8620_mode_fixup()
mutate persistent driver state by assigning ctx->use_packed_pixel?

If userspace submits a DRM_MODE_ATOMIC_TEST_ONLY commit with a mode requiri=
ng
a different pixel packing, drm_atomic_helper_check_modeset() will call
drm_atomic_bridge_chain_check(), invoking this callback:

drivers/gpu/drm/bridge/sil-sii8620.c:sii8620_mode_fixup() {
	...
	ctx->use_packed_pixel =3D sii8620_is_packing_required(ctx, adjusted_mode);
	...
}

Will this cause the driver's global state to be modified during a test-only
commit, leading to a subsequent modeset or asynchronous interrupt programmi=
ng
the hardware using the test-only pixel packing value?

[Severity: High]
This is also a pre-existing issue, but by adding atomic bridge state handle=
rs,
does this bridge now expose an error handling bug in the DRM core?

Looking at drm_bridge_attach() in drivers/gpu/drm/drm_bridge.c, it ignores
the return value of drm_atomic_private_obj_init():

drivers/gpu/drm/drm_bridge.c:drm_bridge_attach() {
	...
	if (drm_bridge_is_atomic(bridge))
		drm_atomic_private_obj_init(bridge->dev, &bridge->base,
					    &drm_bridge_priv_state_funcs);

	return 0;
}

If memory allocation fails in atomic_create_state,
drm_atomic_private_obj_init() returns an error but fails to clean up:

drivers/gpu/drm/drm_atomic.c:drm_atomic_private_obj_init() {
	...
	list_add_tail(&obj->head, &dev->mode_config.privobj_list);

	state =3D obj->funcs->atomic_create_state(obj);
	if (IS_ERR(state))
		return PTR_ERR(state);
	...
}

Will this leave obj->head in dev->mode_config.privobj_list with a NULL
obj->state?

If so, could this cause a kernel oops later if drm_state_dump() (e.g. via
debugfs) iterates privobj_list and calls
drm_atomic_private_obj_print_state() which dereferences the NULL state
via state->obj?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-drm-all-at=
omic-bridges-v2-0-21d03cbca446@kernel.org?part=3D18
