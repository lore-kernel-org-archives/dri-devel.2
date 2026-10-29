Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC55606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KoddgYq5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51E1E10FFFD;
	Thu, 29 Oct 2026 07:51:09 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E719E10FFFD
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:51:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6671060202
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:51:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012FB1F031E9;
 Thu, 29 Oct 2026 07:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793260262;
 bh=KjFir83tc/7G4VS0vQ8TfSvqTD55DkqR9YnYOZXoZ7c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KoddgYq5tTDi0Enn7f2SP/DGQBiDxeolGd8F8Sd+Gu7x/0ZYNGNcN1x6QaC4WjOvP
 /mpEFNBLu50SWosYBWMqbglkfmf7P7G2hKNFJ1TrnWaBiVl6Gjn9vowWLWrh/nWGc6
 duRt2q3n1Bii78IhyB7Oo07n+J+e1oWLEjldLFgpIq5smuSSe0qaRLyjV+ePg3dXBX
 dY5evnBqv55QdnzWvaS7GEX0dO3y+s5hp0efqdINbnda2LqUUXwyTSUD9Wnq8J58ys
 Opuf1tVFh8qyPmHzbSiyTRKEiegjLs3CDAp9SVwdmBCVbsJ/AxruxoztUEbaXp/wim
 doIygc3IuxkGw==
Message-ID: <sashiko-outbox-188907@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/34] drm/bridge-helper: Don't unlock the connection
 mutex after a backoff
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261029-drm-state-readout-v7-1-25e5163d75c3@kernel.org>
References: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
 <20261029-drm-state-readout-v7-1-25e5163d75c3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 07:51:01 +0000
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
- [High] drm/bridge-helper: lock drop and NULL deref in drm_bridge_helper_r=
eset_crtc()
--

commit 110ed6cb32b618d9ec32a80d2d60952c2bc006ae
Author: Maxime Ripard <mripard@kernel.org>

drm/bridge-helper: Don't unlock the connection mutex after a backoff

This commit removes the unconditional connection_mutex unlock in
drm_bridge_helper_reset_crtc() and re-acquires connection_mutex after calli=
ng
drm_atomic_get_connector_for_encoder(), leaving lock release to the caller =
via
drm_modeset_drop_locks() or drm_modeset_backoff().

> diff --git a/drivers/gpu/drm/drm_bridge_helper.c b/drivers/gpu/drm/drm_br=
idge_helper.c
> index 0a3c8fee66b32..6998e7c41d30e 100644
> --- a/drivers/gpu/drm/drm_bridge_helper.c
> +++ b/drivers/gpu/drm/drm_bridge_helper.c

[ ... ]

> @@ -33,26 +37,33 @@ int drm_bridge_helper_reset_crtc(struct drm_bridge *b=
ridge,
>  	struct drm_crtc *crtc;
>  	int ret;
> =20
> +	/*
> +	 * Every lock taken with @ctx is released either by a backoff or
> +	 * by the caller through drm_modeset_drop_locks(), so we must not
> +	 * unlock the connection mutex ourselves.
> +	 */
>  	ret =3D drm_modeset_lock(&dev->mode_config.connection_mutex, ctx);
>  	if (ret)
>  		return ret;
> =20
>  	connector =3D drm_atomic_get_connector_for_encoder(encoder, ctx);
> -	if (IS_ERR(connector)) {
> -		ret =3D PTR_ERR(connector);
> -		goto out;
> -	}
> +	if (IS_ERR(connector))
> +		return PTR_ERR(connector);
> +
> +	/*
> +	 * drm_atomic_get_connector_for_encoder() may have backed off,
> +	 * releasing the connection mutex in the process. Take it back
> +	 * before looking at the connector state.
> +	 */
> +	ret =3D drm_modeset_lock(&dev->mode_config.connection_mutex, ctx);
> +	if (ret)
> +		return ret;
> =20
> -	if (!connector->state) {
> -		ret =3D -EINVAL;
> -		goto out;
> -	}
> +	if (!connector->state)
> +		return -EINVAL;
> =20
>  	crtc =3D connector->state->crtc;
> -	ret =3D drm_atomic_helper_reset_crtc(crtc, ctx);
> =20
> -out:
> -	drm_modeset_unlock(&dev->mode_config.connection_mutex);
> -	return ret;
> +	return drm_atomic_helper_reset_crtc(crtc, ctx);

[Severity: High]
Does drm_atomic_get_connector_for_encoder() actually back off on deadlock, =
or
does it unconditionally unlock connection_mutex before returning?

Looking at drivers/gpu/drm/drm_atomic.c:drm_atomic_get_connector_for_encode=
r(),
neither it nor drm_atomic_helper_reset_crtc() calls drm_modeset_backoff().
Instead, drm_atomic_get_connector_for_encoder() acquires connection_mutex
(which succeeds as a no-op via -EALREADY when already held in ctx) and then
unconditionally drops it at the end of the function:

drivers/gpu/drm/drm_atomic.c:drm_atomic_get_connector_for_encoder() {
	ret =3D drm_modeset_lock(&dev->mode_config.connection_mutex, ctx);
	if (ret)
		return ERR_PTR(ret);

	drm_connector_list_iter_begin(dev, &conn_iter);
	drm_for_each_connector_iter(connector, &conn_iter) {
		if (!connector->state)
			continue;

		if (encoder =3D=3D connector->state->best_encoder) {
			out_connector =3D connector;
			break;
		}
	}
	drm_connector_list_iter_end(&conn_iter);
	drm_modeset_unlock(&dev->mode_config.connection_mutex);

	return out_connector;
}

Because drm_atomic_get_connector_for_encoder() drops both the connector list
iterator reference and connection_mutex before returning, there is an unloc=
ked
window before drm_bridge_helper_reset_crtc() re-acquires connection_mutex. =
Also,
if drm_atomic_get_connector_for_encoder() finds no matching connector and
returns ERR_PTR(-EINVAL), connection_mutex has already been unlocked even if
the caller held it in ctx.

If a concurrent modeset or atomic commit runs during that unlocked window (=
for
example, while sn65dsi83_reset_work() -> sn65dsi83_reset_pipe() ->
drm_bridge_helper_reset_crtc() is executing) and disables the connector or
reassigns it to another encoder, connector->state remains non-NULL while
connector->state->best_encoder and connector->state->crtc can become NULL or
point to a different pipeline.

When drm_bridge_helper_reset_crtc() re-locks connection_mutex, it only chec=
ks
if (!connector->state) and neither re-verifies connector->state->best_encod=
er
=3D=3D encoder nor checks that crtc is non-NULL before calling
drm_atomic_helper_reset_crtc(crtc, ctx):

drivers/gpu/drm/drm_atomic_helper.c:drm_atomic_helper_reset_crtc() {
	...
	state =3D drm_atomic_commit_alloc(crtc->dev);
	if (!state)
		return -ENOMEM;
	...
}

Can this race cause a NULL pointer dereference on crtc->dev in
drm_atomic_helper_reset_crtc(), or reset the wrong CRTC?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-drm-state-=
readout-v7-0-25e5163d75c3@kernel.org?part=3D1
