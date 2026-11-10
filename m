Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9D6606A326
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H2alI/3Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 871F010E918;
	Tue, 10 Nov 2026 07:29:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B81610E93D
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 07:29:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BA3554344D;
 Tue, 10 Nov 2026 07:29:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7029E1F0089F;
 Tue, 10 Nov 2026 07:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794295776;
 bh=xpl0LjS7LhtRMXNLXM+cJihqCPPIxFiA6oajkk8mVKA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=H2alI/3YJw8pvoH1FxGaxP4DxhXhA2BzIuvZgPorq1nVhkYzOV/o0iSuLKLpThMA4
 q9aPdDFFYDKFVtahjWIKUPtn9XwpynMAcB7CAi8DE9L/jFz722BbhCUss4my8/Lyrg
 ov5esf9akitA2orsuy4hALaRSWZixgOy/SnvHbHCGBlrAy4fgDWEEgFlp9IskJnrKO
 TFyX1tF2khqMvYRg3+gKPrMOooacvaPxdQ022f8L1QQueMGtcfU6SqE2YF5CW2Qwwz
 LyhZ616sw9PCVRUBodrqs8mDaF+wUe4fK1H8m8hUnhIKA9EazMmIs3YtTd7CHb4sNj
 KGvTM1nKJD2hw==
Message-ID: <sashiko-outbox-206493@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/bridge: Fail an unsatisfiable bus format
 negotiation with -EINVAL
To: "Arun Iyengar" <aiyengar1990@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110-drm-bridge-busfmt-einval-v1-1-c0494bd23264@gmail.com>
References: <20261110-drm-bridge-busfmt-einval-v1-1-c0494bd23264@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 07:29:35 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/bridge: drm_test_bridge_rgb_yuv_no_path() fails due to
  -ENOTSUPP change
- [Low] drm/bridge: missing Fixes: trailer on commit fixing -ENOTSUPP
  leak
--

commit 13f296e3d34a65b76d6c2d283252f11982c4fa06
Author: Arun Iyengar <aiyengar1990@gmail.com>

> drm/bridge: Fail an unsatisfiable bus format negotiation with -EINVAL
>
> drm_atomic_bridge_chain_select_bus_fmts() reports that no chain of bus
> formats fits with -ENOTSUPP, and drm_atomic_bridge_chain_check() passes
> that straight back through drm_atomic_helper_check_modeset() to the
> atomic and legacy modeset ioctls. -ENOTSUPP (524) is a kernel-internal
> code that userspace does not know; for a configuration the hardware
> cannot do the atomic API returns -EINVAL. Since the connector "color
> format" property makes the negotiation fail for any requested format a
> bridge chain cannot output, userspace now hits this routinely: a DW DP
> connector asked for YCbCr 4:2:0 on a sink without 4:2:0 support gets
> here with no matching format and would fail the atomic commit with
> errno 524, where an HDMI connector asked for the same returns EINVAL
> from the HDMI state helper.
>
> Return -EINVAL when the negotiation finds no chain, with a debug
> message naming the encoder.
>
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>

[Severity: Low]
Since this fixes leaking -ENOTSUPP to userspace during bus format
negotiation, should it include a Fixes: tag?

  Fixes: f32df58acc68 ("drm/bridge: Add the necessary bits to support bus f=
ormat negotiation")

> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 8ae2f9b1db442..6a97b579c604c 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -1437,6 +1437,17 @@ int drm_atomic_bridge_chain_check(struct drm_bridg=
e *bridge,
> =20
>  	ret =3D drm_atomic_bridge_chain_select_bus_fmts(bridge, crtc_state,
>  						      conn_state);
> +	/*
> +	 * -ENOTSUPP is the internal "no bus format chain" code of the
> +	 * negotiation. It is not a valid userspace error code; an atomic
> +	 * check that cannot be satisfied fails with -EINVAL.
> +	 */
> +	if (ret =3D=3D -ENOTSUPP) {
> +		drm_dbg_atomic(bridge->dev,
> +			       "[ENCODER:%d:%s] no bus format chain found\n",
> +			       bridge->encoder->base.id, bridge->encoder->name);
> +		return -EINVAL;
> +	}
>  	if (ret)
>  		return ret;

[Severity: Medium]
Does drm_test_bridge_rgb_yuv_no_path() also need to be updated to expect
-EINVAL?

drivers/gpu/drm/tests/drm_bridge_test.c:drm_test_bridge_rgb_yuv_no_path() {
    ...
	ret =3D drm_atomic_commit(state);
	if (ret =3D=3D -EDEADLK) {
		drm_modeset_backoff(&ctx);
		goto retry_commit;
	}
	KUNIT_EXPECT_EQ(test, ret, -ENOTSUPP);
    ...
}

Because drm_atomic_commit() calls into drm_atomic_bridge_chain_check(), this
KUnit test now receives -EINVAL when no valid bridge bus format path exists
and fails the -ENOTSUPP assertion.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-drm-bridge=
-busfmt-einval-v1-1-c0494bd23264@gmail.com?part=3D1
