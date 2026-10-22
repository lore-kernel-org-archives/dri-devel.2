Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02CB606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L1oPN6Ze
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FF8211239D;
	Thu, 22 Oct 2026 07:35:26 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F92B11239D;
 Thu, 22 Oct 2026 07:35:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8FF2160018;
 Thu, 22 Oct 2026 07:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A111F000C1;
 Thu, 22 Oct 2026 07:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792654519;
 bh=W6zJ7ce4UShFmUnUWUK6Mt3/sfEHNY4k0QbGhS0WnpU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=L1oPN6ZeKMQLxxIivncGKNNKjUjeCQTKPHfILdEtqqhUqMHfLm8pv0B0HAUIaItsQ
 hhWtwHhNVS5pTdi7XxoVO3tL1DVJHCYsJUtP1qiaapb2scp6vNjkybvogUJUAHJJCC
 ZO02wIyOINeil9iw+axkeaJcwedKk6nEfvHkXzzK1ioXpfvfItuBkSOTw53tuhWQje
 V2xNw6RbRkd+NLU03bwS8xJ6qoszGNimYSJW5xoqMw7rl1SH3ojrd0Wc46cVDnxPuf
 L0lc2VAriZn5IOE7S+7rw1h5azqqOfS0UhVsiE899vQn7QYbmHPQFlzJ3zaics3CIt
 TJn5mtzGvhXNw==
Date: Thu, 22 Oct 2026 09:35:14 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Leo Li <sunpeng.li@amd.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 Harry Wentland <harry.wentland@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 66/75] drm/amdgpu: dm: Convert to atomic_create_state
Message-ID: <atm70iyECxY3aCV7@houat>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-66-586c9c026823@kernel.org>
 <a94849ae-f553-4752-a236-746fa89e23fa@amd.com>
 <atdbcaZo2YO54YY7@houat>
 <141dad9e-6868-42e7-836e-d14e1ba78fe9@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="qeszo3vqv6fthtex"
Content-Disposition: inline
In-Reply-To: <141dad9e-6868-42e7-836e-d14e1ba78fe9@amd.com>
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--qeszo3vqv6fthtex
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 66/75] drm/amdgpu: dm: Convert to atomic_create_state
MIME-Version: 1.0

On Tue, Oct 20, 2026 at 12:11:56PM -0400, Leo Li wrote:
> Thanks for cleaning up all the drivers, are these all part of the
> DRM_MODE_ATOMIC_RESET effort?

Somewhat, yes. It actually originated from the state readout work I've
been doing, but it's now a dependency to enable DRM_MODE_ATOMIC_RESET
indeed.

> > On Mon, Oct 19, 2026 at 12:38:47PM -0400, Leo Li wrote:
> >>> @@ -736,11 +736,11 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topol=
ogy_mgr *mgr,
> >>> =20
> >>>  	/*
> >>>  	 * Initialize connector state before adding the connectror to drm a=
nd
> >>>  	 * framebuffer lists
> >>>  	 */
> >>> -	amdgpu_dm_connector_funcs_reset(connector);
> >>
> >> I'm actually not sure why there was a state reset here.
> >> amdgpu_dm_connector_init_helper() is called earlier in this func and
> >> that already did a reset.
> >=20
> > Yeah, it's something sashiko flagged too and I removed that call (and
> > updated the comment).
> >=20
> >>> +	connector->state =3D amdgpu_dm_connector_atomic_create_state(connec=
tor);
> >>
> >> That asside, looks like this can overwrite the alloc'd state from
> >> init_helper() without freeing. So to keep the previous behavior and
> >> avoid regressing, perhaps we can do this:
> >>
> >> 	conn_state =3D amdgpu_dm_connector_atomic_create_state(connector);
> >> 	if (!IS_ERR(conn_state)) {
> >> 		if (connector->state)
> >> 			connector->funcs->atomic_destroy_state(connector, connector->state);
> >> 		connector->state =3D conn_state;
> >> 	}
> >=20
> > If we are to handle errors properly and remain equivalent, then
> > something like the following would be more accurate I guess?
> >=20
> > if (connector->state) {
> >     connector->funcs->atomic_destroy_state(connector, connector->state);
> >     connector->state =3D NULL;
> > }
> >=20
> > conn_state =3D amdgpu_dm_connector_atomic_create_state(connector);
> > if (IS_ERR(conn_state))
> >     return NULL;
> >=20
> > connector->state =3D conn_state;
> >=20
> > Would you prefer that, or should I remove the call to create_state
> > entirely because it's redundant?
>=20
> My preference would be to copy existing behavior, and keep the scope of t=
his
> series to just dropping the reset hook. Dropping the redundant create_sta=
te and
> handling associated testing/regressions can be a followup.
>=20
> In my parsing of the old reset behavior, we don't return a NULL connector=
 on
> error. Rather, we keep the existing connector->state and return the conne=
ctor as
> is. The rest of reset() only runs if state was alloc'd successfully. My p=
revious
> snippet should copy this.

Ack. I'll use your earlier suggestion then

Maxime

--qeszo3vqv6fthtex
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCatm8sQAKCRAnX84Zoj2+
dilNAX9iMVVgVGGpB0WupXHjfbSIB5/QBI7GxpcCMyFlTfSXp7xkiMZbbUNpzgTh
DF+TossBfj7OTSVtdP+/o4w0Gtd5Em6Q/wWu/f0Q97ZFXMEcSHssuCeAKgNQGkaz
9HEX8dtgAQ==
=pyvX
-----END PGP SIGNATURE-----

--qeszo3vqv6fthtex--
