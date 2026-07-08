Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 001ADC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:24:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2038B10E618;
	Wed,  8 Jul 2026 16:24:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oZYDAMvO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3B6E10F1DD
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 16:24:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5506843722
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 16:24:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1800D1F000E9;
 Wed,  8 Jul 2026 16:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783527850;
 bh=KR2Z9besoANxMAp1S0HVjrQhhjSaqCo4+KAiLftT2cg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oZYDAMvOdKL/NGh2Xig9ZziBEm/YOT/a+CnBTnqaKFoRYxZLsGLwIXuPd8uwuRYEZ
 VkLaXH80fuZBAwL+38+ANNgXD3ZJ9hd2cG24nwrftJ8MI1FbjGV38xchYzzkPSM4Qn
 KaLTuUUTLgtpdbMCVvqebADVCQRiuROt6f2/0NbNSDGyxt+E9Dnwn4sqWCvFjxDLEy
 FTTHnpfZA4ulyCggoEjz3Yre5J2mQS5SrFDkxyoxEizLgdxzzcmVQZvlOlBwu5lsM3
 IO5aBWvwyaBMS90/QKon/uN5qp5/JRufUf30yrxJSb4T7BTftve7tygHOcRQrNTlYI
 1iH44VqRP7EbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 7/8] drm/atomic: Allow filling a commit with
 pristine object states
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260708-drm-reset-state-flag-v1-7-c37dc985485d@kernel.org>
References: <20260708-drm-reset-state-flag-v1-0-c37dc985485d@kernel.org>
 <20260708-drm-reset-state-flag-v1-7-c37dc985485d@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 16:24:09 +0000
Message-Id: <20260708162410.1800D1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Unchecked calls to the `atomic_create_state` hook on CRTCs, pl=
anes, and connectors will cause a kernel panic on drivers that do not imple=
ment them.
- [High] The function fails to reset private objects (`drm_private_obj`), r=
esulting in an incomplete and inconsistent baseline state.
- [Medium] The locking order for `connection_mutex` in `drm_atomic_commit_f=
ill_with_defaults` is inverted relative to the established DRM locking orde=
r.
--

--- Patch [7]: [PATCH RFC 7/8] drm/atomic: Allow filling a commit with pris=
tine object states ---
commit e9e433a7ce1a444bdbe24747a11cf419bea31b2b
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic: Allow filling a commit with pristine object states

This patch creates drm_atomic_commit_fill_with_defaults() to iterate over
all CRTCs, planes, connectors, and color operations in the device and insert
a fresh default state for each one. This brings the device back to a known
baseline before applying userspace property changes.

> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 79971d4b56a49..0c1a02d0e871d 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c

[ ... ]

> @@ -1610,6 +1610,118 @@ drm_atomic_get_new_bridge_state(const struct drm_=
atomic_commit *state,
>  }
>  EXPORT_SYMBOL(drm_atomic_get_new_bridge_state);
> =20
> +/**
> + * drm_atomic_commit_fill_with_defaults - populate a commit with pristin=
e states

[ ... ]

> +int drm_atomic_commit_fill_with_defaults(struct drm_atomic_commit *commi=
t)
> +{
> +	struct drm_device *dev =3D commit->dev;
> +	struct drm_mode_config *config =3D &dev->mode_config;
> +	struct drm_crtc *crtc;
> +	struct drm_plane *plane;
> +	struct drm_connector *connector;
> +	struct drm_connector_list_iter conn_iter;
> +	struct drm_colorop *colorop;
> +	int ret;
> +
> +	WARN_ON(!commit->acquire_ctx);
> +
> +	drm_for_each_crtc(crtc, dev) {
> +		struct drm_crtc_state *crtc_state;
> +
> +		ret =3D drm_modeset_lock(&crtc->mutex, commit->acquire_ctx);
> +		if (ret)
> +			return ret;
> +
> +		crtc_state =3D crtc->funcs->atomic_create_state(crtc);

[Severity: Critical]
Is it safe to call atomic_create_state without checking if the function poi=
nter
exists?

Some drivers (like i915) might rely on the reset callback instead and leave
atomic_create_state unimplemented. Could this unconditional call lead to a =
NULL
pointer dereference here, as well as in the plane and connector loops below?

> +		if (IS_ERR(crtc_state))
> +			return PTR_ERR(crtc_state);
> +
> +		ret =3D drm_atomic_commit_set_crtc_state(commit, crtc, crtc_state);
> +		if (ret) {
> +			crtc->funcs->atomic_destroy_state(crtc, crtc_state);
> +			return ret;
> +		}
> +	}

[ ... ]

> +	drm_connector_list_iter_begin(dev, &conn_iter);
> +	drm_for_each_connector_iter(connector, &conn_iter) {
> +		struct drm_connector_state *connector_state;
> +
> +		ret =3D drm_modeset_lock(&config->connection_mutex, commit->acquire_ct=
x);

[Severity: Medium]
Does acquiring connection_mutex here invert the standard DRM locking order?

The established canonical sequence (such as in drm_modeset_lock_all_ctx)
typically acquires connection_mutex before the CRTC and plane locks. Since =
the
CRTC and plane locks were already acquired in the loops above, could acquir=
ing
connection_mutex now result in unnecessary transaction backoffs and retries?

> +		if (ret) {
> +			drm_connector_list_iter_end(&conn_iter);
> +			return ret;
> +		}
> +
> +		connector_state =3D connector->funcs->atomic_create_state(connector);
> +		if (IS_ERR(connector_state)) {

[ ... ]

> +	drm_for_each_colorop(colorop, dev) {
> +		struct drm_colorop_state *colorop_state;
> +
> +		colorop_state =3D drm_atomic_helper_colorop_create_state(colorop);
> +		if (IS_ERR(colorop_state))
> +			return PTR_ERR(colorop_state);
> +
> +		drm_modeset_lock_assert_held(&colorop->plane->mutex);
> +
> +		ret =3D drm_atomic_commit_set_colorop_state(commit, colorop, colorop_s=
tate);
> +		if (ret) {
> +			drm_colorop_atomic_destroy_state(colorop, colorop_state);
> +			return ret;
> +		}
> +	}
> +

[Severity: High]
Should this function also iterate over and reset private objects
(drm_private_obj) before returning?

Modern DRM features like DP MST topologies, DisplayPort tunnels, and global
bandwidth allocators maintain their state in private objects. If these are
omitted from the reset, could it leave the topology or bandwidth state
inconsistent with the newly reset hardware baseline?

> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_atomic_commit_fill_with_defaults);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-drm-reset-=
state-flag-v1-0-c37dc985485d@kernel.org?part=3D7
