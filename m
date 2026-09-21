Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2517FC982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 16:26:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83A3610E167;
	Mon, 21 Sep 2026 16:26:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Jp4QAiSk";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C3AD10E167
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 16:26:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 503D060142;
 Mon, 21 Sep 2026 16:26:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07631F000FF;
 Mon, 21 Sep 2026 16:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790007961;
 bh=DZbGAuYEq202IzEUvdKYCHri1+CW9zj+ViqbOc1SIfk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Jp4QAiSk/BKmybKqMqjsbftOqprDntA8BqjXIK7H1KGE2lIA168wJkYab3sHl/VEE
 Nqag9PyPMX+jlzHoGy8L3SiIQpwOcpV+ImAwhXgUjwNsFe/tTk0LJMpNlF/laMFutL
 TtlZYs55/EYS7jiGU6cHKsREfa0zcAbw76h8JUBFv3vZIwriQsYfGTRCmnWVs/Vk06
 gvw0HIYIpBKb5lCGxtDEy6TcFePR0FWNKDvSAUpKHDcajut0zb9iy0W4yQhmiuE8XK
 P0+VGdMqO059Qft8gQQ8iMsJu+2m7fOWT29ZionnNeq54r06i0z4P60mYWiJ1Fdr68
 m2aHNpDfpNiCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 24/25] drm/tests: hdmi: Add Quick Media Switching tests
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260921-vrr-limiter-uapi-v1-24-2fcd7d011646@collabora.com>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-24-2fcd7d011646@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 16:26:00 +0000
Message-Id: <20260921162600.D07631F000FF@smtp.kernel.org>
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
- [Medium] drm/tests: incorrect atomic backoff jump causes loss of CRTC tes=
t state
--

commit 45b02bdee8c1daea9d271ea9c59930edf078ec24
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

drm/tests: hdmi: Add Quick Media Switching tests

This commit adds KUnit tests to validate the HDMI Quick Media Switching
(QMS) functionality in the HDMI state helpers. The tests verify that the
QMS TFR min and max flags are respected.

> diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers=
/gpu/drm/tests/drm_hdmi_state_helper_test.c
> index e2d98280ea237..961a4b48afd86 100644
> --- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
> +++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
[ ... ]
> +retry_crtc_state:
> +	crtc_state =3D drm_atomic_get_crtc_state(state, crtc);
> +	if (PTR_ERR(crtc_state) =3D=3D -EDEADLK) {
> +		drm_atomic_commit_clear(state);
> +		ret =3D drm_modeset_backoff(&ctx);
> +		if (!ret)
> +			goto retry_crtc_state;
> +	}
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
> +
> +	crtc_state->vrr_enabled =3D true;
> +	crtc_state->vrr_state.vrr_min_n =3D 48000;
> +	crtc_state->vrr_state.vrr_min_d =3D 1001;
> +	/* Equivalent fraction, as an added hurdle */
> +	crtc_state->vrr_state.vrr_max_n =3D 48000 * 2;
> +	crtc_state->vrr_state.vrr_max_d =3D 1001 * 2;
> +
> +retry_conn_state:
> +	conn_state =3D drm_atomic_get_connector_state(state, conn);
> +	if (PTR_ERR(conn_state) =3D=3D -EDEADLK) {
> +		drm_atomic_commit_clear(state);
> +		ret =3D drm_modeset_backoff(&ctx);
> +		if (!ret)
> +			goto retry_conn_state;

[Severity: Medium]
If drm_atomic_get_connector_state() returns -EDEADLK,
drm_atomic_commit_clear() is called. This clears the previously acquired
crtc_state from the atomic transaction.

Because the code jumps back to retry_conn_state instead of retry_crtc_state,
the test does not re-acquire the CRTC state and loses the vrr_enabled and
vrr_state changes.

Could this cause the test to commit an incomplete atomic state? Should this
instead goto retry_crtc_state?

This same pattern appears in the other tests introduced in this patch:
- drm_test_check_hdmi_vrr_qms_fail()
- drm_test_check_hdmi_vrr_qms_nonfixed_fail()
- drm_test_check_hdmi_vrr_qms_tfr_min()
- drm_test_check_hdmi_vrr_qms_no_tfr_max_fail()
- drm_test_check_hdmi_vrr_qms_tfr_max()

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-vrr-limite=
r-uapi-v1-0-2fcd7d011646@collabora.com?part=3D24
