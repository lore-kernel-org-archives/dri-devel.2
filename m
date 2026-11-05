Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5979F606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HXWEeqIC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AC2811228A;
	Thu,  5 Nov 2026 09:20:09 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEB3511228A
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 09:20:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 815FF43505;
 Thu,  5 Nov 2026 09:20:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB6F1F000C1;
 Thu,  5 Nov 2026 09:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793870402;
 bh=Am3QrGt9J1BXg1JMK+BzEuczmdG7rtFs7K9iWdQ7yrU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HXWEeqICAbyIUW2sbOe81rF71xTTAPe/mHauUVXIc02mny45TkXHUQhDaHDKl/1JU
 DWqW/FdzGP7NiZLSqkwhJDYlCgPhKr73VqB3W7sit/J0Zgxnn3bdkaJuj1ml+L7ALm
 Xtn8bwyp3NU9/VtDtxihb6iIsml3SEHFCl6gkd74FUcF6VxPAbS1jhc2BQoAblIBwQ
 volP70WU+swoy1iSO+4aavLtmDktPpVD/W8k8xBPVCQRj0CzYwnCGJnTrcHwcg2cGJ
 gfzbSTRWicjkGOh66sjBQCK/VQJzrJCAu44Qtsk0hQEgDQ7o117s22xBHzr+hpR/pU
 SCLCDkqrIZ+8Q==
Message-ID: <sashiko-outbox-198756@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/mediatek: Validate gamma_lut size
To: "Fei Shao" <fshao@chromium.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261105091054.3993611-1-fshao@chromium.org>
References: <20261105091054.3993611-1-fshao@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 09:20:01 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/mediatek: NULL pointer dereference in mtk_crtc_atomic_check()
--

commit 9fd51aa9fb3e494d751bd1b62a30a2b909f46ef6
Author: Fei Shao <fshao@chromium.org>

drm/mediatek: Validate gamma_lut size

This commit adds mtk_crtc_atomic_check() to validate that any non-NULL
gamma_lut blob matches the hardware LUT size of the CRTC's DDP components,
preventing out-of-bounds reads in mtk_gamma_set() and mtk_aal_gamma_set().

> diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediat=
ek/mtk_crtc.c
> index 2920f3198ef6a..fd9b51fd00eaa 100644
> --- a/drivers/gpu/drm/mediatek/mtk_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
> @@ -880,6 +880,26 @@ static void mtk_crtc_atomic_flush(struct drm_crtc *c=
rtc,
>  	mtk_crtc_update_config(mtk_crtc, !!mtk_crtc->event);
>  }
> =20
> +static int mtk_crtc_atomic_check(struct drm_crtc *crtc, struct drm_atomi=
c_commit *state)
> +{
> +	struct mtk_crtc *mtk_crtc =3D to_mtk_crtc(crtc);
> +	struct drm_crtc_state *crtc_state =3D drm_atomic_get_new_crtc_state(sta=
te, crtc);
> +	struct drm_property_blob *gamma_lut =3D crtc_state->gamma_lut;
> +	unsigned int lut_size;
> +	int i;
> +
> +	if (!gamma_lut)
> +		return 0;
> +
> +	for (i =3D 0; i < mtk_crtc->ddp_comp_nr; i++) {
> +		lut_size =3D mtk_ddp_gamma_get_lut_size(mtk_crtc->ddp_comp[i]);
> +		if (lut_size && gamma_lut->length !=3D lut_size * sizeof(struct drm_co=
lor_lut))
> +			return -EINVAL;
> +	}

[Severity: High]
Can mtk_crtc->ddp_comp[i] be NULL here when conn_routes is used?

In mtk_crtc_create(), when conn_routes is non-NULL, mtk_crtc->ddp_comp is
allocated with path_len + 1 entries and mtk_crtc->ddp_comp_nr is incremented
at the end:

drivers/gpu/drm/mediatek/mtk_crtc.c:mtk_crtc_create() {
	...
	if (conn_routes) {
		...
		mtk_crtc->num_conn_routes =3D num_conn_routes;
		mtk_crtc->conn_routes =3D conn_routes;

		/* increase ddp_comp_nr at the end of mtk_crtc_create */
		mtk_crtc->ddp_comp_nr++;
	}
}

The last slot in mtk_crtc->ddp_comp[mtk_crtc->ddp_comp_nr - 1] remains NULL
until mtk_crtc_update_output() populates it during mtk_crtc_atomic_enable().

Because mtk_crtc_atomic_check() runs during the atomic check phase before
mtk_crtc_atomic_enable() (for example on the initial modeset, a
DRM_MODE_ATOMIC_TEST_ONLY commit, or when setting GAMMA_LUT while the CRTC =
is
disabled), passing a valid gamma_lut blob will reach the final iteration of
the loop and pass NULL to mtk_ddp_gamma_get_lut_size():

drivers/gpu/drm/mediatek/mtk_ddp_comp.h:mtk_ddp_gamma_get_lut_size() {
	if (comp->funcs && comp->funcs->gamma_get_lut_size)
		return comp->funcs->gamma_get_lut_size(comp->dev);

	return 0;
}

Unlike mtk_ddp_comp_mode_valid(), which checks if comp is non-NULL before
dereferencing comp->funcs, mtk_ddp_gamma_get_lut_size() dereferences comp
unconditionally. Should mtk_ddp_gamma_get_lut_size() or
mtk_crtc_atomic_check() guard against a NULL comp pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105091054.3993=
611-1-fshao@chromium.org?part=3D1
