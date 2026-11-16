Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C6D60A380E
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aoSWhf/I
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F2E010EF38;
	Mon, 16 Nov 2026 10:53:19 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCD3210EF48
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:53:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D2F6B612E1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:53:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3521F000D4;
 Mon, 16 Nov 2026 10:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794826392;
 bh=uNRTHpClDcGJT9VuJMizGjX30rswfzGw31U6AwA3Q/U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aoSWhf/Ir2Q7dnPlrfvF/Xim5EbNdJoNOo8MO3ie7OCiO753NseyI1VXs6E/ToGPA
 hdKIt/WLDfrjfF+3Gwr/sexagclYGpghhwZh6UmBspkOy/VNLWqUt0icVnn2PZvV8j
 oQtY0pBNMX+5mjTJ2KBqftG5ZfsTUVyX631PfzSDd+aSqSSY28mNp4b83ExJjztdHV
 KC/QSI8zX/xN7d5/m8axZvRaICw25d6eH9EjULmTDAAnQfNM94g1TpMqUXpXHmOE6j
 R83QvJ8K+TtUXuHCr2KvhbmLZlH+DLon/hjrMZ/QGP8+C2PGwmOaYpFstXdz20IKBr
 4PbkgPlo/KkLQ==
Message-ID: <sashiko-outbox-216789@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 39/64] drm/tests: drm_atomic_test: Switch to
 drm_mode_config_create_initial_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261116-drm-no-more-config-reset-v2-39-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
 <20261116-drm-no-more-config-reset-v2-39-0bb471f4d1e0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 10:53:12 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/tests: misplaced fixup hunk in
  drm_atomic_test_init_drm_components()
--

commit 4a8e39a2143161f4693081f0e4cf620a298d8f3a
Author: Maxime Ripard <mripard@kernel.org>

drm/tests: drm_atomic_test: Switch to drm_mode_config_create_initial_state

This commit switches create_device() in drm_atomic_test.c from
drm_mode_config_reset() to drm_mode_config_create_initial_state(), and
updates error handling in drm_atomic_test_init_drm_components() in
drm_atomic_commit_test.c.

> diff --git a/drivers/gpu/drm/tests/drm_atomic_commit_test.c b/drivers/gpu=
/drm/tests/drm_atomic_commit_test.c
> index 97f60ce68b3e4..a02859a0d8bf3 100644
> --- a/drivers/gpu/drm/tests/drm_atomic_commit_test.c
> +++ b/drivers/gpu/drm/tests/drm_atomic_commit_test.c
> @@ -135,8 +135,7 @@ drm_atomic_test_init_drm_components(struct kunit *tes=
t, bool has_connectors)
> =20
>  done:
>  	ret =3D drm_mode_config_create_initial_state(drm);
> -	if (ret)
> -		return ERR_PTR(ret);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> =20
>  	return priv;
>  }

[Severity: Low]
Should this hunk be squashed into the earlier commit "drm/tests:
drm_atomic_state_test: Switch to drm_mode_config_create_initial_state"?

That commit converted drm_atomic_test_init_drm_components() to return
ERR_PTR(ret), even though callers such as
drm_test_check_connector_changed_modeset() only check
KUNIT_ASSERT_NOT_NULL(test, priv) and would dereference an error pointer
at that point in the series.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-drm-no-mor=
e-config-reset-v2-0-0bb471f4d1e0@kernel.org?part=3D39
