Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82165C3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 18:13:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF86310EA99;
	Wed, 14 Oct 2026 18:13:19 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36A6F10EA99
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 18:13:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0730542E67
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 18:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40D41F000C4;
 Wed, 14 Oct 2026 18:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792001592;
 bh=GE7SEpwPmItTXjMDGhWZcLpVvZ8BNak182sKs9tHtWE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lCYlCX6x1LQiIc/TUNSBlB6GpQv7cbVstihIbJXFUo+VS3L5y5V9tNIti+LcLCqtH
 hhNYM0dBuTGTE/L6Ptt3Mkg+ndvgXjsU3RmNFXGex6FoE2gHQ4Adqx+HMo5hHnAd8f
 Rxl85ha2I8aQVamgSVRG6501/jGJfzBfYw0WXgCZ5F+pO9q3SIzQu1+bA/MqO6/9K1
 +iPzhSZaGDFzckC1gLeZxbXlHxgJ4CXOvkJlCt0QRABJIgwAeYvJrBczzqvmQPDt53
 w8SF9MwfyRZLot+FyErtI8HxbOGrN7aAMCsKMz7Mh4Oo9rLEExydjKCkj1CGgn2gTM
 nTIzYC41sWhiA==
Message-ID: <sashiko-outbox-171678@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 70/75] drm/nouveau: Convert to atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-70-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-70-586c9c026823@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 18:13:12 +0000
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
- [High] drm/nouveau: Assigning ERR_PTR to connector->state causes panic in=
 cleanup
- [High] drm/nouveau: Invalid kfree of embedded connector state on non-atom=
ic devices
- [Medium] drm/nouveau: MST connectors lose DRM properties on initialization
--

commit 5c80f0bbb55c00fa7eb36613e602205469912331
Author: Maxime Ripard <mripard@kernel.org>

drm/nouveau: Convert to atomic_create_state

The nouveau connector reset implementation creates a custom state
subclass, but only initializes a pristine state and sets
driver-specific defaults without resetting any hardware. This is
equivalent to what atomic_create_state expects. Convert to it.

> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/no=
uveau/dispnv50/disp.c
> index e91130f93db67..39a23d0e9be56 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
[ ... ]
> @@ -1281,8 +1281,11 @@ nv50_mstc_new(struct nv50_mstm *mstm, struct drm_d=
p_mst_port *port,
> =20
>  	drm_connector_helper_add(&mstc->connector, &nv50_mstc_help);
> =20
> -	mstc->connector.funcs->reset(&mstc->connector);
> -	nouveau_conn_attach_properties(&mstc->connector);
> +	mstc->connector.state =3D mstc->connector.funcs->atomic_create_state(&m=
stc->connector);

[Severity: Medium]
Will dropping this call to nouveau_conn_attach_properties() cause MST
connectors to silently lose access to their DRM properties?

Before this patch, MST connectors would get properties like underscan_prope=
rty,
scaling_mode_property, dithering_mode, and vibrant_hue registered here.
Without this call, userspace compositors might lose access to these standard
digital output properties.

[Severity: High]
If atomic_create_state() returns an error pointer, this assigns it directly
to mstc->connector.state.

> +	if (IS_ERR(mstc->connector.state)) {
> +		drm_connector_cleanup(&mstc->connector);

Could passing this error pointer to drm_connector_cleanup() result in a ker=
nel
panic?

If we take this error path, drm_connector_cleanup() checks if connector->st=
ate
is set (which is true for ERR_PTR), and calls atomic_destroy_state().
This passes the error pointer down to nouveau_conn_atomic_destroy_state(),
which will dereference the invalid pointer and panic.

> +		return PTR_ERR(mstc->connector.state);
> +	}
> =20
>  	drm_for_each_crtc(crtc, dev) {
>  		if (!(mstm->outp->dcb->heads & drm_crtc_mask(crtc)))
> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/dr=
m/nouveau/nouveau_connector.c
> index cc3caf8de64b0..59c8091c67967 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
[ ... ]
> @@ -242,21 +242,17 @@ nouveau_conn_atomic_duplicate_state(struct drm_conn=
ector *connector)
>  	return &asyc->state;
>  }
> =20
> -void
> -nouveau_conn_reset(struct drm_connector *connector)
> +struct drm_connector_state *
> +nouveau_conn_atomic_create_state(struct drm_connector *connector)
>  {
>  	struct nouveau_connector *nv_connector =3D nouveau_connector(connector);
>  	struct nouveau_conn_atom *asyc;
> =20
>  	if (drm_drv_uses_atomic_modeset(connector->dev)) {
>  		if (WARN_ON(!(asyc =3D kzalloc_obj(*asyc))))
> -			return;
> +			return ERR_PTR(-ENOMEM);
> =20
> -		if (connector->state)
> -			nouveau_conn_atomic_destroy_state(connector,
> -							  connector->state);
> -
> -		__drm_atomic_helper_connector_reset(connector, &asyc->state);
> +		__drm_atomic_helper_connector_state_init(&asyc->state, connector);
>  	} else {
>  		asyc =3D &nv_connector->properties_state;
>  	}

[Severity: High]
On older non-atomic hardware (pre-NV50), this returns a pointer to the
statically embedded nv_connector->properties_state.

The caller nouveau_connector_create() now unconditionally assigns this retu=
rned
pointer to connector->state. When the connector is later destroyed or reset,
drm_connector_cleanup() will invoke nouveau_conn_atomic_destroy_state(),
which unconditionally calls kfree() on the state pointer.

Can calling kfree() on this statically embedded struct pointer cause memory
corruption and a kernel panic?

[ ... ]
> @@ -1521,7 +1519,12 @@ nouveau_connector_create(struct drm_device *dev, i=
nt index)
>  		}
>  	}
> =20
> -	connector->funcs->reset(connector);
> +	connector->state =3D connector->funcs->atomic_create_state(connector);
> +	if (IS_ERR(connector->state)) {
> +		ret =3D PTR_ERR(connector->state);
> +		goto drm_conn_err;

[Severity: High]
Similar to the issue in nv50_mstc_new(), if atomic_create_state() fails,
the error pointer is assigned to connector->state.

The goto drm_conn_err path calls drm_connector_cleanup(), which will attemp=
t to
clean up the state using the error pointer.

Does this lead to a panic during the error path cleanup?

> +	}
> +
>  	nouveau_conn_attach_properties(connector);
> =20
>  	/* Default scaling mode */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014-drm-no-mor=
e-connector-reset-v1-0-586c9c026823@kernel.org?part=3D70
