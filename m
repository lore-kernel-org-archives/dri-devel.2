Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2C8606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 13:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OqRxxaaE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B2B910E1CA;
	Tue, 20 Oct 2026 13:08:33 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00D6310E090;
 Tue, 20 Oct 2026 13:08:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0025E605ED;
 Tue, 20 Oct 2026 13:08:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F261F000D1;
 Tue, 20 Oct 2026 13:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792501705;
 bh=OSgUkLdqSq3/bzGi+Gve/lD7nzClyWs7jmZ8yDoG6dE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=OqRxxaaEm8z1fO8DL3JTVmqTPlYArvdUAKRQFxBqt/v0/mcEmtYuh9XaehJE2+2NE
 3HUL94KMSUJjE8wJSLmSiwdhpKq4K1kMAxu+IcerYQfH5UqDIoVlklVc3fRt9x7ktB
 oiCv7asLflDHMLWUcGw3Us6bT5SEJtPOVjGmjJPRueGxu2f94EofROmdcDo0217IM5
 v0gl3s/oWYldNPymt2EwULkETtdhvqddsUTbd7v5G1HBBuX8qpUX1EVmVQ4Z+cwrus
 a1GB0yW/1eVvXi6b7Hnl0Zq3ZbciwkdHEss6//TE6aNQiBoBEEG+YOiqy6RUQeNrig
 kGD2kfLhtDw3Q==
Date: Tue, 20 Oct 2026 15:08:21 +0200
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
Message-ID: <atdbcaZo2YO54YY7@houat>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-66-586c9c026823@kernel.org>
 <a94849ae-f553-4752-a236-746fa89e23fa@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="75prl2vo3e7hc5z2"
Content-Disposition: inline
In-Reply-To: <a94849ae-f553-4752-a236-746fa89e23fa@amd.com>
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--75prl2vo3e7hc5z2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 66/75] drm/amdgpu: dm: Convert to atomic_create_state
MIME-Version: 1.0

Hi Leo,

Thanks for reviewing this

On Mon, Oct 19, 2026 at 12:38:47PM -0400, Leo Li wrote:
> > @@ -736,11 +736,11 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topolog=
y_mgr *mgr,
> > =20
> >  	/*
> >  	 * Initialize connector state before adding the connectror to drm and
> >  	 * framebuffer lists
> >  	 */
> > -	amdgpu_dm_connector_funcs_reset(connector);
>=20
> I'm actually not sure why there was a state reset here.
> amdgpu_dm_connector_init_helper() is called earlier in this func and
> that already did a reset.

Yeah, it's something sashiko flagged too and I removed that call (and
updated the comment).

> > +	connector->state =3D amdgpu_dm_connector_atomic_create_state(connecto=
r);
>=20
> That asside, looks like this can overwrite the alloc'd state from
> init_helper() without freeing. So to keep the previous behavior and
> avoid regressing, perhaps we can do this:
>=20
> 	conn_state =3D amdgpu_dm_connector_atomic_create_state(connector);
> 	if (!IS_ERR(conn_state)) {
> 		if (connector->state)
> 			connector->funcs->atomic_destroy_state(connector, connector->state);
> 		connector->state =3D conn_state;
> 	}

If we are to handle errors properly and remain equivalent, then
something like the following would be more accurate I guess?

if (connector->state) {
    connector->funcs->atomic_destroy_state(connector, connector->state);
    connector->state =3D NULL;
}

conn_state =3D amdgpu_dm_connector_atomic_create_state(connector);
if (IS_ERR(conn_state))
    return NULL;

connector->state =3D conn_state;

Would you prefer that, or should I remove the call to create_state
entirely because it's redundant?

> >  	/*
> >  	 * Some of the properties below require access to state, like bpc.
> >  	 * Allocate some default initial connector state with our reset helpe=
r.
> >  	 */
> > -	if (wbcon->base.base.funcs->reset)
> > -		wbcon->base.base.funcs->reset(&wbcon->base.base);
> > +	if (!wbcon->base.base.state &&
> > +	    wbcon->base.base.funcs->atomic_create_state) {
> > +		struct drm_connector_state *conn_state;
> > +
> > +		conn_state =3D amdgpu_dm_connector_atomic_create_state(&wbcon->base.=
base);
>=20
> Nit: functionally the same, but would
> `wbcon->base.base.funcs->atomic_create_state(&wbcon->base.base);` be
> clearer?

Totally, I'll fix it
Thanks!
Maxime

--75prl2vo3e7hc5z2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCatdnwAAKCRAnX84Zoj2+
duUMAYCOzmKKO1IbwCLcpAY6paJtyFigJiy11qnZfmTPwlRj/y2qMjHgOx8N90eS
mgwJEEEBgNWwPIwO3lQbAvrmQVbAZ7PFyqEbKxNP1evmVlnqtQVuAK2Sm0Mjtxo9
6yZDj8DqAQ==
=9243
-----END PGP SIGNATURE-----

--75prl2vo3e7hc5z2--
