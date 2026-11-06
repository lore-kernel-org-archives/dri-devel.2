Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D01606A32D
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AEGiSU0N
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96831112D77;
	Fri,  6 Nov 2026 13:34:05 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A771B112D77
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:33:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8FB91414CC
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:33:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5645A1F0089F;
 Fri,  6 Nov 2026 13:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793972038;
 bh=S8RZhKW/lZXevVcyiSsA5fPmdstOiMKNYbHyXpaH3hA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AEGiSU0N5wVTkH26YQ1YSYrDf+hs8evkxpQLsfHAuR4s69s2b2Pnga9kOjzGlzznO
 I7nIR72nFx5zFkpQgnunwOU7mDrt2Gwag4A6kq2X6KNLOgfcbzz+G1uclbWP+f+d6z
 36wZX/loDIB5Qq0r0BpfYDAPOqVOPUH1X5NZfeoFHksnrUDL+By/19dFP5oiSMyt7+
 vu/j9vZjVRUUw5Lnv4nOAErtnrrOXjG5Zs2L6/oXwwEoI3P3QlTaK9I9jabSc6sbu0
 MAguFhV5ca1LhgGuGPSQAEISyCOXvP/mfggJ7CWcltN6E+g1YkgC7fYw5ODeTw/bft
 OdZTa08VDwbhA==
Message-ID: <sashiko-outbox-201477@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 16/39] drm/atomic_sro: Add function to install state
 into drm objects
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261106-drm-state-readout-v8-16-cbe78624e1bc@kernel.org>
References: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
 <20261106-drm-state-readout-v8-16-cbe78624e1bc@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 13:33:57 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/atomic_sro: bad private_objs loop bound in
  drm_atomic_sro_install_state()
- [Medium] drm/atomic_sro: premature state destruction in
  drm_atomic_sro_install_state()
--

commit 9bc3fe0d50e4075338d8a443036b9d7e790c5ea0
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic_sro: Add function to install state into drm objects

This commit adds drm_atomic_sro_install_state() to install readout states
into DRM objects and introduces the optional atomic_sro_install_state hook
for planes, CRTCs, connectors, and private objects.

> diff --git a/drivers/gpu/drm/drm_atomic_state_readout.c b/drivers/gpu/drm=
/drm_atomic_state_readout.c
> index 07ddc315b13d9..de0f27186bea9 100644
> --- a/drivers/gpu/drm/drm_atomic_state_readout.c
> +++ b/drivers/gpu/drm/drm_atomic_state_readout.c

[ ... ]

> @@ -581,3 +582,145 @@ void drm_atomic_sro_set_private_obj_state(struct dr=
m_atomic_sro_state *state,
>  		       obj_state, state);
>  }
>  EXPORT_SYMBOL(drm_atomic_sro_set_private_obj_state);
> +
> +/**
> + * drm_atomic_sro_install_state - install readout state into DRM objects
> + * @state: SRO state to install
> + *
> + * Takes a &struct drm_atomic_sro_state built by
> + * &drm_mode_config_helper_funcs.atomic_sro_build_state and installs its
> + * contents as the current state of each DRM object (setting
> + * &drm_crtc.state, &drm_plane.state, &drm_connector.state and
> + * &drm_private_obj.state).
> + *
> + * For each object, the optional atomic_sro_install_state hook is
> + * called before the state pointer is updated, allowing drivers to
> + * perform any needed action.
> + */
> +void drm_atomic_sro_install_state(struct drm_atomic_sro_state *state)
> +{
> +	unsigned int i;
> +
> +	for (i =3D 0; i <=3D state->max_connector_index; i++) {
> +		const struct drm_connector_funcs *conn_funcs;
> +		struct drm_connector_state *conn_state;
> +		struct drm_connector *conn;
> +
> +		conn =3D state->connectors[i].ptr;
> +		if (!conn)
> +			continue;
> +
> +		conn_funcs =3D conn->funcs;
> +		if (!conn_funcs)
> +			continue;
> +
> +		if (conn->state) {
> +			conn_funcs->atomic_destroy_state(conn, conn->state);
> +			conn->state =3D NULL;
> +		}
> +
> +		conn_state =3D state->connectors[i].state;
> +		if (!conn_state)
> +			continue;
> +
> +		if (conn_funcs->atomic_sro_install_state)
> +			conn_funcs->atomic_sro_install_state(conn, conn_state);
> +
> +		conn->state =3D conn_state;
> +		state->connectors[i].state =3D NULL;
> +		state->connectors[i].ptr =3D NULL;
> +		drm_connector_put(conn);
> +	}

[Severity: Medium]
Does destroying conn->state (and crtc->state, plane->state, and obj->state
in the loops below) before checking whether the new state pointer in the
SRO container is non-NULL leave the object with a NULL state pointer?

If state->connectors[i].state is NULL, the old state has already been
destroyed and nulled when the loop continues, leaving the KMS object
without a state and causing NULL pointer dereferences in later
atomic_duplicate_state() calls.  It also leaves the object's state pointer
NULL while atomic_sro_install_state() runs.

[ ... ]

> +	for (i =3D 0; i < count_private_obj(state->dev); i++) {
> +		const struct drm_private_state_funcs *obj_funcs;
> +		struct drm_private_state *obj_state;
> +		struct drm_private_obj *obj;
> +
> +		obj =3D state->private_objs[i].ptr;
> +		if (!obj)
> +			continue;
> +
> +		obj_funcs =3D obj->funcs;
> +		if (!obj_funcs)
> +			continue;
> +
> +		if (obj->state) {
> +			obj_funcs->atomic_destroy_state(obj, obj->state);
> +			obj->state =3D NULL;
> +		}
> +
> +		obj_state =3D state->private_objs[i].state;
> +		if (!obj_state)
> +			continue;
> +
> +		if (obj_funcs->atomic_sro_install_state)
> +			obj_funcs->atomic_sro_install_state(obj, obj_state);
> +
> +		obj->state =3D obj_state;
> +		state->private_objs[i].state =3D NULL;
> +		state->private_objs[i].ptr =3D NULL;
> +	}
> +	state->num_private_objs =3D 0;
> +}

[Severity: Medium]
Should this loop bound be state->num_private_objs instead of
count_private_obj(state->dev)?

drm_atomic_sro_state_init() allocates state->private_objs for the count at
allocation time, and drm_atomic_sro_set_private_obj_state() populates up to
state->num_private_objs entries.  Bounding the loop by
count_private_obj(state->dev) re-walks dev->mode_config.privobj_list on
every iteration, scans unpopulated slots, and reads past the end of
state->private_objs if a private object was added after
drm_atomic_sro_state_alloc().  In addition, zeroing state->num_private_objs
at the end prevents drm_atomic_sro_state_free() from freeing any
obj_state skipped by an early continue.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-drm-state-=
readout-v8-0-cbe78624e1bc@kernel.org?part=3D16
