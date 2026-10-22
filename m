Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D08606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Piw1fZ9c
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99D4D11260E;
	Thu, 22 Oct 2026 12:56:02 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C1EA1125EB
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:55:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7BE7560A79
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:55:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB0C1F000C4;
 Thu, 22 Oct 2026 12:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792673754;
 bh=/k05RzpeCKNewLeOgVzW7didIn6Qme+VuFkQvLWGFq8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Piw1fZ9cnU4snG4Dbo/NYV/vmVW9fSFJnnNfzx9ApUSXct1Yig7WfsOsWvbF0o+e2
 DTuXPnRwpr+SOTrt+FIbGRNI7w/Pqz4Jq4LW8P46OdCfLBTOnMNxDmvkMjwvRpjFQs
 7jbnzbFZOCEE5T0jmqAwiJn0binYbEGrnCe9+SkU9awdRMcAyl6w7LqNme8P3WHqsx
 zfWF4Jej+ZUNlRKmrAjuXZHDlJcCNcpgqkB+cFaOAkEvRLLz5JCEhw+wvv+u9tj6rA
 EXuTOd/vy4yY1jl8gN86/osl83FFCecmKwj+9RsxiVaxvillnTHuOTmU1v//dGOSlJ
 B9fTgAeCOV0dw==
Message-ID: <sashiko-outbox-181514@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 56/59] drm/nouveau: Convert to atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-56-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
 <20261022-drm-no-more-connector-reset-v2-56-0b7e4e85b1e8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 12:55:53 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] drm/nouveau: invalid free via nouveau_conn_atomic_create_state=
() on pre-NV50
- [High] drm/nouveau: missing nvif teardown on error in nouveau_connector_c=
reate()
- [Medium] drm/nouveau: memory leak of mstc on error in nv50_mstc_new()
--

commit 37ea1f2bbde92fcd5731b31085bba035feef8a42
Author: Maxime Ripard <mripard@kernel.org>

drm/nouveau: Convert to atomic_create_state

This commit converts the nouveau connector implementation from using the
reset callback to using the atomic_create_state callback for initializing
connector state.

> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/no=
uveau/dispnv50/disp.c
> index e91130f93db67..947d0ff4ba029 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
[ ... ]
> @@ -1281,7 +1282,13 @@ nv50_mstc_new(struct nv50_mstm *mstm, struct drm_d=
p_mst_port *port,
> =20
>  	drm_connector_helper_add(&mstc->connector, &nv50_mstc_help);
> =20
> -	mstc->connector.funcs->reset(&mstc->connector);
> +	conn_state =3D mstc->connector.funcs->atomic_create_state(&mstc->connec=
tor);
> +	if (IS_ERR(conn_state)) {
> +		drm_connector_cleanup(&mstc->connector);
> +		return PTR_ERR(conn_state);
> +	}

[Severity: Medium]
Earlier in nv50_mstc_new(), mstc and *pmstc are allocated with
kzalloc_obj(*mstc), and the error path for drm_connector_dynamic_init()
frees *pmstc and resets it to NULL:

	if (!(mstc =3D *pmstc =3D kzalloc_obj(*mstc)))
		return -ENOMEM;
	mstc->mstm =3D mstm;
	mstc->port =3D port;

	ret =3D drm_connector_dynamic_init(dev, &mstc->connector, &nv50_mstc,
					 DRM_MODE_CONNECTOR_DisplayPort, NULL);
	if (ret) {
		kfree(*pmstc);
		*pmstc =3D NULL;
		return ret;
	}

When atomic_create_state() fails here, drm_connector_cleanup() only cleans
up the embedded drm_connector and zeroes mstc->connector, while the caller
nv50_mstm_add_connector() discards mstc on a non-zero return.

Does this error path leak mstc and leave a dangling pointer in *pmstc?

> +	mstc->connector.state =3D conn_state;
> +
>  	nouveau_conn_attach_properties(&mstc->connector);
> =20
>  	drm_for_each_crtc(crtc, dev) {
> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/dr=
m/nouveau/nouveau_connector.c
> index cc3caf8de64b0..e4ab9849de4d4 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
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
> @@ -278,6 +274,8 @@ nouveau_conn_reset(struct drm_connector *connector)
>  			break;
>  		}
>  	}
> +
> +	return &asyc->state;
>  }

[Severity: Critical]
On pre-nv50 display hardware (where disp->disp.object.oclass < NV50_DISP),
nv04_display_create() clears DRIVER_ATOMIC and uses
nouveau_mode_config_funcs without an atomic_commit callback, so
drm_drv_uses_atomic_modeset(connector->dev) is false.

Previously, nouveau_conn_reset() only called
__drm_atomic_helper_connector_reset() in the atomic branch, leaving
connector->state as NULL on pre-nv50 while initializing the embedded
nv_connector->properties_state in place.

With this change, nouveau_conn_atomic_create_state() returns
&nv_connector->properties_state.state, and nouveau_connector_create()
unconditionally assigns it to connector->state.

When nouveau_display_create() subsequently calls drm_mode_config_reset(),
drm_mode_config_connector_reset_with_create_state() sees the non-NULL
connector->state and passes it to nouveau_conn_atomic_destroy_state():

drivers/gpu/drm/nouveau/nouveau_connector.c:nouveau_conn_atomic_destroy_sta=
te() {
	struct nouveau_conn_atom *asyc =3D nouveau_conn_atom(state);
	__drm_atomic_helper_connector_destroy_state(&asyc->state);
	kfree(asyc);
}

The same destruction happens in drm_connector_cleanup(), and having
connector->state non-NULL on a non-atomic driver also causes helpers such
as drm_connector_get_encoder() to inspect connector->state->best_encoder
instead of connector->encoder.

Won't returning &nv_connector->properties_state.state and assigning it to
connector->state on pre-nv50 hardware pass an interior pointer of
struct nouveau_connector to kfree() and break legacy encoder lookups?

[ ... ]
> @@ -1521,7 +1520,13 @@ nouveau_connector_create(struct drm_device *dev, i=
nt index)
>  		}
>  	}
> =20
> -	connector->funcs->reset(connector);
> +	conn_state =3D connector->funcs->atomic_create_state(connector);
> +	if (IS_ERR(conn_state)) {
> +		ret =3D PTR_ERR(conn_state);
> +		goto drm_conn_err;
> +	}

[Severity: High]
Before reaching atomic_create_state() in nouveau_connector_create(),
nv_connector->conn, nv_connector->hpd, and nv_connector->irq may already be
constructed via nvif_conn_ctor() and nvif_conn_event_ctor():

	if (nvif_object_constructed(&nv_connector->conn.object)) {
		ret =3D nvif_conn_event_ctor(&nv_connector->conn, "kmsHotplug",
					   nouveau_connector_hotplug,
					   NVIF_CONN_EVENT_V0_PLUG | NVIF_CONN_EVENT_V0_UNPLUG,
					   &nv_connector->hpd);
		if (ret =3D=3D 0)
			connector->polled =3D DRM_CONNECTOR_POLL_HPD;

		if (nv_connector->aux.transfer) {
			ret =3D nvif_conn_event_ctor(&nv_connector->conn, "kmsDpIrq",
						   nouveau_connector_irq, NVIF_CONN_EVENT_V0_IRQ,
						   &nv_connector->irq);
			if (ret) {
				nvif_event_dtor(&nv_connector->hpd);
				nvif_conn_dtor(&nv_connector->conn);
				goto drm_conn_err;
			}
		}
	}

However, the drm_conn_err label only cleans up connector and frees
nv_connector:

drm_conn_err:
	drm_connector_cleanup(connector);
	kfree(nv_connector);
	return ERR_PTR(ret);

If atomic_create_state() fails and jumps to drm_conn_err without calling
nvif_event_dtor(&nv_connector->irq), nvif_event_dtor(&nv_connector->hpd),
and nvif_conn_dtor(&nv_connector->conn), can this leak those nvif objects
and leave active events referencing freed nv_connector memory?

> +	connector->state =3D conn_state;
> +
>  	nouveau_conn_attach_properties(connector);
> =20
>  	/* Default scaling mode */
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-drm-no-mor=
e-connector-reset-v2-0-0b7e4e85b1e8@kernel.org?part=3D56
