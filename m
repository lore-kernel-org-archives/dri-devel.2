Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079A1C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 16:26:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68D5710E75F;
	Mon, 21 Sep 2026 16:26:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Uf8jwXSk";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42F2710E3C8
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 16:26:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B181A60142;
 Mon, 21 Sep 2026 16:26:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FEAF1F000FF;
 Mon, 21 Sep 2026 16:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790007967;
 bh=mm0nxLn5nBLz/tc19LZTdSIzjIIZ2VHyNTC6cezL0gU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Uf8jwXSkpTzPZ4AdnBsZhcJtJbJJ3vnM+yGCBgrehiPcV2PvgJEzk/Je6T4KwO2Cu
 HKKpfACJ2HuC8zDIx2j3kZE+qJQg2EcpGwq8fZdvjMj4NfEiT5WikVeqVD5IJvEhwT
 x7kiZhzZFM7PFlnuEA5S+J/rUoNGjUxlNLBasEndiEQ8Hj3QQxtxWZviecBDnpQiMc
 0+qZSX/aHmTixmaULrY4G5+lcfaZm+nfe6U2DoNEBcF9/pfZ7k/r5QTy7fITR7kx4j
 oS1A/OOPI7+B7lb7cqI9hLiwoKjROeOZMpN5mhwaxNVVcmYnpr2v8e40fZDyvq2lZk
 YmobIBBhboUDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 22/25] drm/tests: hdmi: Add "Game Mode" VRR tests
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260921-vrr-limiter-uapi-v1-22-2fcd7d011646@collabora.com>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-22-2fcd7d011646@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 16:26:06 +0000
Message-Id: <20260921162607.3FEAF1F000FF@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] drm/tests: test_edid_hdmi_vrr defined as static const in header
--

commit 77a0520912816fb52f18f64df569bc989ec9d0ad
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

drm/tests: hdmi: Add "Game Mode" VRR tests

This commit adds kunit tests to verify "Game Mode" VRR functionality
in the DRM HDMI state helper. It checks successful VRR validation on
capable sinks, failure on incapable sinks, and proper behavior of
flush and vsync helpers updating the cur_vtotal values.

> diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers=
/gpu/drm/tests/drm_hdmi_state_helper_test.c
> index b2e347863a776..1486c16c2f78e 100644
> --- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
> +++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
[ ... ]
> +static void drm_test_check_hdmi_vrr(struct kunit *test)
> +{
[ ... ]
> +	ret =3D drm_atomic_commit(state);
> +	if (ret =3D=3D -EDEADLK) {
> +		drm_atomic_commit_clear(state);
> +		ret =3D drm_modeset_backoff(&ctx);
> +		if (!ret)
> +			goto retry_crtc_state;
> +	}
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	crtc_state =3D drm_atomic_get_new_crtc_state(state, crtc);
> +	KUNIT_ASSERT_NOT_NULL(test, crtc_state);

[Severity: Medium]
This is a pre-existing issue in these testing patterns, but if these
assertions fail, does the function return immediately and leak the modeset
ww_mutex locks?

Since the local drm_modeset_acquire_ctx ctx locks are not automatically
managed, returning early skips calling drm_modeset_drop_locks(&ctx) and
drm_modeset_acquire_fini(&ctx). This could leave dangling lock list nodes
pointing to out-of-scope stack memory.

This pattern also appears in drm_test_check_hdmi_vrr_sink_fail() and
drm_test_check_hdmi_vrr_flush_vsync() where early exits on assertion failur=
es
bypass the cleanup block at the end of the functions.

> +
> +	KUNIT_EXPECT_GE(test, crtc_state->vrr_state.base_vtotal, preferred->crt=
c_vtotal);
> +	KUNIT_EXPECT_GE(test, crtc_state->vrr_state.max_vtotal, preferred->crtc=
_vtotal);
> +
> +	drm_modeset_drop_locks(&ctx);
> +	drm_modeset_acquire_fini(&ctx);
> +}
[ ... ]
> diff --git a/drivers/gpu/drm/tests/drm_kunit_edid.h b/drivers/gpu/drm/tes=
ts/drm_kunit_edid.h
> index 28b4df93a5554..10175c9e1b2ee 100644
> --- a/drivers/gpu/drm/tests/drm_kunit_edid.h
> +++ b/drivers/gpu/drm/tests/drm_kunit_edid.h
[ ... ]
> + * EDID conformity: PASS
> + */
> +static const unsigned char test_edid_hdmi_vrr[] =3D {
> +	0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x31, 0xd8, 0x43, 0x00,

[Severity: Low]
Does this definition cause the 256-byte array to be duplicated in every
translation unit that includes drm_kunit_edid.h?

It might also trigger -Wunused-const-variable compiler warnings if a file
includes the header but does not reference test_edid_hdmi_vrr. Should this =
be
declared as extern const here with its definition placed in a .c file,
similar to the other EDID arrays?

> +	0x00, 0x00, 0x00, 0x00, 0x01, 0x24, 0x01, 0x03, 0x80, 0x60, 0x36, 0x78,
> +	0x0f, 0xee, 0x91, 0xa3, 0x54, 0x4c, 0x99, 0x26, 0x0f, 0x50, 0x54, 0x20,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-vrr-limite=
r-uapi-v1-0-2fcd7d011646@collabora.com?part=3D22
