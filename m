Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E2A606A881
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VFzPJYlF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51B1A10EF41;
	Mon, 16 Nov 2026 10:55:37 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAAF410EF4D
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:55:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A0AC74012B
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:55:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD291F000C5;
 Mon, 16 Nov 2026 10:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794826530;
 bh=//uSG//TNZsArgExQlhnfqZG3cpeY6UO8Gx0T5czSyI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VFzPJYlFCczF/FzmjA9o7FfA0R5yb9WA1WGbWOvPZtd4Sy2P9M1hN2mrF0f1Fsjnm
 KRIv6Y7S2IzsVf03DUFyIYN6MsuLNO++OxsMm+v8w2KBjoYxOy38xzw3Ot3drECIqW
 /SX1q85ys1ByMhJ5bzoDLgUHh9GHWeCWmiqdccvJm001bXfGIe50hdTAEwVqbtBOKA
 g8P2klcKqs3NQUTpb8SS2hxxSDxLdgG4mG5dcAiY+MLQQ/8B+/rMn2HQyLq38YUoOd
 T852CzwD7muQUkLFQfay8ySuhNg7xGMh85dCZqU3KgBc5vDkW10rV+xT22gih82Hi4
 cPVwWmGht3eIg==
Message-ID: <sashiko-outbox-216798@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 38/64] drm/tests: drm_atomic_state_test: Switch to
 drm_mode_config_create_initial_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261116-drm-no-more-config-reset-v2-38-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
 <20261116-drm-no-more-config-reset-v2-38-0bb471f4d1e0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 10:55:29 +0000
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
- [Medium] drm/tests: ERR_PTR dereference after
  drm_atomic_test_init_drm_components()
- [Low] drm/tests: commit subject uses stale drm_atomic_state_test
  prefix
--

commit 764d6a07d978e1acc8e6005af10238d412ddeb08
Author: Maxime Ripard <mripard@kernel.org>

drm/tests: drm_atomic_state_test: Switch to drm_mode_config_create_initial_=
state

This commit switches drm_atomic_test_init_drm_components() from
drm_mode_config_reset() to drm_mode_config_create_initial_state() for
initial KMS state creation.

> drm/tests: drm_atomic_state_test: Switch to drm_mode_config_create_initia=
l_state

[Severity: Low]
This isn't a bug, but 5164f7e7ff8e ("drm: Rename struct drm_atomic_state
to drm_atomic_commit") renamed this test file to
drm_atomic_commit_test.c, so the subject prefix still refers to the old
name.

> diff --git a/drivers/gpu/drm/tests/drm_atomic_commit_test.c b/drivers/gpu=
/drm/tests/drm_atomic_commit_test.c
> index 6ccb001f6264b..97f60ce68b3e4 100644
> --- a/drivers/gpu/drm/tests/drm_atomic_commit_test.c
> +++ b/drivers/gpu/drm/tests/drm_atomic_commit_test.c
> @@ -134,7 +134,9 @@ drm_atomic_test_init_drm_components(struct kunit *tes=
t, bool has_connectors)
>  	}
> =20
>  done:
> -	drm_mode_config_reset(drm);
> +	ret =3D drm_mode_config_create_initial_state(drm);
> +	if (ret)
> +		return ERR_PTR(ret);
> =20
>  	return priv;
>  }

[Severity: Medium]
Can returning ERR_PTR(ret) here lead to an error pointer dereference in
the callers?

Every earlier step in drm_atomic_test_init_drm_components() aborts via
KUNIT_ASSERT_*, and the callers only check KUNIT_ASSERT_NOT_NULL(test,
priv) before passing priv to set_up_atomic_state(), which dereferences
priv->crtc:

drivers/gpu/drm/tests/drm_atomic_commit_test.c:drm_test_check_connector_cha=
nged_modeset() {
	...
	priv =3D drm_atomic_test_init_drm_components(test, true);
	KUNIT_ASSERT_NOT_NULL(test, priv);

	/* First, do a modeset to set the connector */
	ret =3D set_up_atomic_state(test, priv, &priv->connectors[0], &ctx);
	...
}

Using KUNIT_ASSERT_EQ(test, ret, 0) here matches the rest of the helper,
and it looks like that change was accidentally squashed into the
following commit "drm/tests: drm_atomic_test: Switch to
drm_mode_config_create_initial_state".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-drm-no-mor=
e-config-reset-v2-0-0bb471f4d1e0@kernel.org?part=3D38
