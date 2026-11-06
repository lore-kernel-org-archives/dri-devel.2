Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C97606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kKHX8zE+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88C51112D86;
	Fri,  6 Nov 2026 13:40:05 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 681A9112D86
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:39:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7E08160204
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:39:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1DD1F0089F;
 Fri,  6 Nov 2026 13:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793972398;
 bh=+FgvCjzC9w+XAuRnLxUOS2b6KRjzy5hoAEh3CUk/Lhw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kKHX8zE+iB/5pZzVRAZMBd7lc/Qa5KMTUai26+DpC6aDwlCxZQgnfFqTm8rKA2XRF
 Ijfkjw+HBROEhV7TA1oWMYu1dxGiE0Uw2SU6DdfvDuM4wu4pAXaCV0b7OI9KsKorAS
 s20JRwWRp5UoM6IAkH0ne2bFKIStx9nw95SkRVieHqXyPIMwsXk8ESctZKNo6D8Eh0
 rpp+pVCzOCaKAuWZLHfZvcUcFGPaCy1Et6jdEfcpyYLKMlEJjqNXI1TXyOpkBrn9hT
 oYJsL3MXLCEYeBZ1AbTbA7u1Ojw+TiPas4JusF92JrJiP9ewG2GKdBFaF9WuCMxCwu
 vkol3TLvZZQZA==
Message-ID: <sashiko-outbox-201483@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 02/39] drm/bridge-helper: Don't unlock the connection
 mutex after a backoff
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261106-drm-state-readout-v8-2-cbe78624e1bc@kernel.org>
References: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
 <20261106-drm-state-readout-v8-2-cbe78624e1bc@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 13:39:57 +0000
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
- [Medium] drm/bridge-helper: connection_mutex dropped in
  drm_bridge_helper_reset_crtc()
- [Low] drm/bridge-helper: inaccurate backoff description in commit
  message
--

commit 9e2a98821e3fc25f6def63b07ed345888ea3f8d2
Author: Maxime Ripard <mripard@kernel.org>

drm/bridge-helper: Don't unlock the connection mutex after a backoff

This commit stops drm_bridge_helper_reset_crtc() from unlocking
connection_mutex on exit, re-acquires connection_mutex after
drm_atomic_get_connector_for_encoder(), and validates the connector's
best_encoder and crtc before resetting the CRTC.

> If either of those functions detects a deadlock, it backs off and drops
> every lock held by the context, including the connection mutex taken by
> drm_bridge_helper_reset_crtc() itself. The function however still
> unlocked the connection mutex unconditionally on its way out, unlocking
> a mutex it wasn't holding anymore.
>=20
> The callers already have to release the context locks through
> drm_modeset_drop_locks() and to handle the -EDEADLK error, so we can
> leave the connection mutex release to them. We still need to take it
> back after drm_atomic_get_connector_for_encoder() returns, since it may
> have backed off, before looking at the connector state.

[Severity: Low]
Is this description of how connection_mutex gets dropped accurate?

Neither drm_atomic_get_connector_for_encoder() nor
drm_atomic_helper_reset_crtc() calls drm_modeset_backoff() on -EDEADLK;
drm_modeset_lock() only records ctx->contended and returns -EDEADLK for
the caller to back off.  Instead, as the new code comment notes,
drm_atomic_get_connector_for_encoder() unconditionally calls
drm_modeset_unlock(&dev->mode_config.connection_mutex) on its normal exit
path, which is why connection_mutex was already unlocked at the old
goto out label and why it must be re-acquired before inspecting
connector->state.

> diff --git a/drivers/gpu/drm/drm_bridge_helper.c b/drivers/gpu/drm/drm_br=
idge_helper.c
> index 0a3c8fee66b32..2efa4e1bc4b71 100644
> --- a/drivers/gpu/drm/drm_bridge_helper.c
> +++ b/drivers/gpu/drm/drm_bridge_helper.c
[ ... ]
> @@ -33,26 +37,45 @@ int drm_bridge_helper_reset_crtc(struct drm_bridge *b=
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
> +	 * drm_atomic_get_connector_for_encoder() drops the connection
> +	 * mutex on its way out, whether or not it was held through @ctx,
> +	 * so we need to take it back before looking at the connector
> +	 * state.
> +	 */
> +	ret =3D drm_modeset_lock(&dev->mode_config.connection_mutex, ctx);
> +	if (ret)
> +		return ret;
> +
> +	if (!connector->state)
> +		return -EINVAL;
> =20
> -	if (!connector->state) {
> -		ret =3D -EINVAL;
> -		goto out;
> -	}
> +	/*
> +	 * A concurrent atomic commit may have run while the connection
> +	 * mutex was released above, and re-routed the connector to
> +	 * another encoder or CRTC. Make sure the connector is still
> +	 * tied to our encoder before resetting anything.
> +	 */
> +	if (connector->state->best_encoder !=3D encoder)
> +		return -EINVAL;

[Severity: Medium]
Why lock connection_mutex before drm_atomic_get_connector_for_encoder()
if that helper immediately unlocks it on exit?

drivers/gpu/drm/drm_atomic.c:drm_atomic_get_connector_for_encoder() {
	ret =3D drm_modeset_lock(&dev->mode_config.connection_mutex, ctx);
	if (ret)
		return ERR_PTR(ret);
	...
	drm_modeset_unlock(&dev->mode_config.connection_mutex);

	return out_connector;
}

Because drm_atomic_get_connector_for_encoder() drops connection_mutex
unconditionally, the first drm_modeset_lock() in
drm_bridge_helper_reset_crtc() is immediately undone.  If connection_mutex
was already held in ctx on entry (for example, slow-locked via
drm_modeset_backoff() after the second drm_modeset_lock() returned
-EDEADLK), drm_atomic_get_connector_for_encoder() drops that slow-locked
mutex and removes it from ctx->locked, so the second drm_modeset_lock()
acquires it again on the normal path and can hit -EDEADLK again.

Dropping and re-acquiring connection_mutex also opens a window where a
concurrent atomic commit can move encoder to a different connector,
causing the connector->state->best_encoder !=3D encoder check to fail with
-EINVAL even though encoder is still active on the new connector.  If
drm_atomic_get_connector_for_encoder() leaves connection_mutex locked in
ctx for the caller to drop via drm_modeset_drop_locks(), connection_mutex
stays held across the lookup without a second lock acquisition or race
window.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-drm-state-=
readout-v8-0-cbe78624e1bc@kernel.org?part=3D2
