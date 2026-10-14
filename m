Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C6B4CC6B2D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:52:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B440A10E1A4;
	Wed, 14 Oct 2026 17:52:33 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A60910E1A4
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:52:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 00B3443B38
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:52:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77781F000C5;
 Wed, 14 Oct 2026 17:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792000346;
 bh=Cw+1B6R3dL4p08TJA4/jwk9+u6PAJCcfQDpAr6jggQ0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iCX10piYbq4/nqQUiie5PBpUEkrN8KJTDy1UBgQFVahIBMsVvMeL6iW9NAkdcOqnl
 ZGK6KqPRT/AJok1bXndSZ9uFwKZ582Gtl624AwQcMnQZHd7V0Xgv1vRWvvD5h3yTVL
 ugYU3ZkKuqYZuPKnjsd8v7o0Autni7QnKLoMBR3ghjPcijMfC6sft4J3uz3tFqkkY1
 XkL32UCsYsH+FpgY2F5dWCklvmiruKpr5Qb5LNHRvNcAmSIjZVFSZQR8km4SkC/w/U
 tDPGRg/AiodXpd6gx8XA4lcP+tZzG+b/tgU5LduJcZXujaA8rNC+H9G5HoeePzNwX6
 3KcSEq3EfvHMw==
Message-ID: <sashiko-outbox-171618@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/75] drm/amdgpu: dm: Switch to
 drm_atomic_helper_connector_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-4-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-4-586c9c026823@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 17:52:26 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] drm/amdgpu: tests store ERR_PTR in connector->state leading to c=
leanup crash
- [Low] drm: WARN_ON triggered during test connector init due to missing at=
omic hooks
--

commit 4e29a193c910088812846e00f2f613afc6ebffa4
Author: Maxime Ripard <mripard@kernel.org>

drm/amdgpu: dm: Switch to drm_atomic_helper_connector_create_state

The amdgpu: dm connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook. Switch to
drm_atomic_helper_connector_create_state() instead.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_te=
st.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c
> index 29a513dab9cd8..e47b4dd210b8d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c

[ ... ]

> @@ -654,8 +654,9 @@ static void dm_test_crtc_set_crc_source_dprx_no_conne=
ctor(struct kunit *test)
>  						 DRM_MODE_CONNECTOR_WRITEBACK), 0);
>  	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test,
>  			dm_test_crc_connector_cleanup, wb_conn), 0);
> -	drm_atomic_helper_connector_reset(wb_conn);
> -	KUNIT_ASSERT_NOT_NULL(test, wb_conn->state);
> +
> +	wb_conn->state =3D drm_atomic_helper_connector_create_state(wb_conn);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, wb_conn->state);

[Severity: Medium]
Can this assignment introduce a regression by causing a crash in the deferr=
ed
KUnit cleanup path if memory allocation fails?

In dm_test_crtc_set_crc_source_dprx_no_connector(), if
drm_atomic_helper_connector_create_state() fails, it returns ERR_PTR(-ENOME=
M).
Because it's directly assigned to wb_conn->state, the assertion
KUNIT_ASSERT_NOT_ERR_OR_NULL(test, wb_conn->state) will fail, aborting the
test.

This test abortion jumps to KUnit's deferred cleanup routines. The previous=
ly
registered cleanup action dm_test_crc_connector_cleanup() invokes
drm_connector_cleanup(wb_conn).

Since wb_conn->state contains ERR_PTR(-ENOMEM), which is not NULL,
drm_connector_cleanup() will consider it a valid pointer and pass it to
drm_atomic_helper_connector_destroy_state(). This will blindly dereference
the error pointer, leading to an invalid memory access.

Should the return value be validated in a local variable before being assig=
ned
to wb_conn->state to ensure it remains NULL on failure?

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helper=
s_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_te=
st.c
> index 51c3995de76d2..a369a3cbd4afa 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c

[ ... ]

> @@ -4106,7 +4106,7 @@ static void dm_test_is_dp_sink_present_queries_link=
_service(struct kunit *test)
>   * device pointer, so build a real one here.
>   */
>  static const struct drm_connector_funcs dm_test_connector_funcs =3D {
> -	.reset =3D drm_atomic_helper_connector_reset,
> +	.atomic_create_state =3D drm_atomic_helper_connector_create_state,
>  };

[Severity: Low]
Will this missing hook introduce a regression by triggering a kernel warning
during test connector initialization?

The KUnit test allocates a DRM device with the DRIVER_ATOMIC feature flag.
When dm_test_alloc_real_connector() initializes the connector using
drmm_connector_init(), it calls into drm_connector_init_only().

Because dm_test_connector_funcs omits both the .atomic_destroy_state and
.atomic_duplicate_state hooks, this explicitly violates the core DRM check:

WARN_ON(drm_drv_uses_atomic_modeset(dev) &&
        (!funcs->atomic_destroy_state || !funcs->atomic_duplicate_state))

This causes a warning to fire unconditionally during KUnit test execution.
Should we add the required hooks to satisfy the API contract for this
test connector?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014-drm-no-mor=
e-connector-reset-v1-0-586c9c026823@kernel.org?part=3D4
