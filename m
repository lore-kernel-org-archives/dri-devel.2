Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBC3606D801
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 15:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ae81fKfR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46FB011227A;
	Fri,  6 Nov 2026 15:20:36 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C0E711227A
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 15:20:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3DD92609FF
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 15:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF50D1F0089F;
 Fri,  6 Nov 2026 15:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793978429;
 bh=M/fqV4W1+IZUyFKk4nX/yMbqIJk863Xp8MhooiP3nwk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ae81fKfRUT1s/3pqWhi0nGMXpFILFaI/f0cTUjc2pEVDqEjHm53wH1X0823GH3c6L
 TFTCWOUoIZcPnDFDD9k4cy8wvYTE3pjaW0gMCEc8Qgo+DdpsV16ZPKYY5/SLUwr1Kc
 yu7V1NZ+3sr6/XSX7jn1W5k2ZBUSUt0Vya2LotCwo07jHTweeBHqECK7ytxPwdeD3o
 oRbOkwlR1LOzFm5oWsaFJxSjYaa7aXEIRLaFWuPRD3ht/7ZP8pbiGe2tZ/UFAYP3sh
 1rq///bSFVK7blUd8ohCo3Q/f1304sHqaWVrlQKrWCqciZfspo7tSB6mflanvEQIpV
 e6jVb2o+rKpXA==
Message-ID: <sashiko-outbox-201664@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 5/7] drm/tests: atomic: Add tests for
 drm_atomic_commit_fill_with_defaults()
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261106-drm-reset-state-flag-v8-5-50fd046b705f@kernel.org>
References: <20261106-drm-reset-state-flag-v8-0-50fd046b705f@kernel.org>
 <20261106-drm-reset-state-flag-v8-5-50fd046b705f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 15:20:28 +0000
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/tests: commit message does not match added tests in
  drm_atomic_test.c
--

commit 7731bb22d966b9a3d8a35a7cc0ac3d23e9fd7680
Author: Maxime Ripard <mripard@kernel.org>

> drm/tests: atomic: Add tests for drm_atomic_commit_fill_with_defaults()
>
> drm_atomic_commit_fill_with_defaults() is used by the
> DRM_MODE_ATOMIC_RESET flag to bring all objects back to their pristine
> state. However, it has no dedicated test coverage.
>
> Add two tests that verify the reset cycle. The first enables a CRTC,
> plane, and connector, then calls drm_atomic_commit_fill_with_defaults()
> and verifies all objects return to their disabled state: CRTC inactive,
> plane disabled with no framebuffer, and connector unbound. The second
> goes further and commits the default-filled state to verify the
> init -> enable -> reset -> commit sequence completes without errors.
>
> Suggested-by: Daniel Stone <daniel@fooishbar.org>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

[Severity: Low]
Does the commit message match the tests added in
drm_atomic_fill_with_defaults_tests?

The commit message describes two tests, whereas the patch adds four:
drm_test_check_fill_with_defaults(),
drm_test_check_fill_with_defaults_commit(),
drm_test_check_fill_with_defaults_color_mgmt(), and
drm_test_check_fill_with_defaults_no_modeset().  Also, as noted in the
test comments, drm_test_check_fill_with_defaults() only enables the CRTC
and connector via drm_kunit_helper_enable_crtc_connector() and does not
enable the plane with a framebuffer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-drm-reset-=
state-flag-v8-0-50fd046b705f@kernel.org?part=3D5
