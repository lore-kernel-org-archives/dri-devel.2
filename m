Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C56EC5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 02:54:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80E8B10E0BF;
	Fri, 14 Aug 2026 02:54:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XoQu1Oe7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 524D210E0BF
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 02:54:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1D1E043D6F
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 02:54:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46F01F000E9;
 Fri, 14 Aug 2026 02:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786676088;
 bh=tQVe++chaZH9l2HL0nsUFyd1FoXgj9ctpFpfsFYE6Jo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XoQu1Oe7nP7gJou4QxNtpHScU/JIkLX710TDjFG+swsFmQ0TKXjLmDiy0FvAPugp+
 O4B1xWs8R8Wsk1nXLhkKD6DKf6I71Hb5PwMta6vWoPPsv6kowPFGrTDgopEQ1WMHly
 Rgz0Uy0PPIOwEiJ8w4q5NjEocebpQA0+SY57JMzByVejdehI6CijQ+0QTcQAyHL+a9
 U0vwgjUJzYj9r/3Cc81fQRKnHoVplFzg4YLeuQU3IiCi5lP1cpCXJWIh6gW02Z88LB
 VkkXl4+oUcn+M7i4GtQS+CXL2F7fbpy8S8g0TUJADZ8vb4Q55vUZw9PgtQWJ/sOnt6
 LutT3H6uj7h8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 74/78] drm/atomic-state-helper: Remove
 drm_atomic_helper_bridge_reset()
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260608-drm-no-more-bridge-reset-v2-74-0a91018bf886@kernel.org>
References: <20260608-drm-no-more-bridge-reset-v2-74-0a91018bf886@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 02:54:46 +0000
Message-Id: <20260814025447.D46F01F000E9@smtp.kernel.org>
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

New issues:
- [Medium] The commit message claims all drivers have been converted to `at=
omic_create_state`, but two Cadence bridge drivers were missed.
- [Low] Kernel-doc references to `drm_atomic_helper_bridge_reset()` were le=
ft intact despite the function being removed.

Pre-existing issues:
- [High] cdns_dsi_bridge_atomic_reset() fails to initialize the private obj=
ect pointer in the state structure, which can lead to a NULL pointer derefe=
rence.
--

--- Patch [74]: [PATCH v2 74/78] drm/atomic-state-helper: Remove drm_atomic=
_helper_bridge_reset() ---
commit 5bf80d9ba302438fec05db1d7bd3c9f1680d8cd3
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic-state-helper: Remove drm_atomic_helper_bridge_reset()

All drivers have been converted to the atomic_create_state callback
and its drm_atomic_helper_bridge_create_state() helper. Remove the
deprecated drm_atomic_helper_bridge_reset().

> All drivers have been converted to the atomic_create_state callback
> and its drm_atomic_helper_bridge_create_state() helper.

[Severity: Medium]
Are all drivers fully converted? Code inspection shows two Cadence bridge
drivers (cdns-dsi-core.c and cdns-mhdp8546-core.c) still assign .atomic_res=
et
instead of being converted to the new callback.

> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/=
drm_atomic_state_helper.c
> index 268cff1faad66..db42c3823b12a 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
[ ... ]
> @@ -905,22 +905,6 @@ void __drm_atomic_helper_bridge_state_init(struct dr=
m_bridge_state *state,
>  }
>  EXPORT_SYMBOL(__drm_atomic_helper_bridge_state_init);
> =20
> -/**
> - * drm_atomic_helper_bridge_reset() - Allocate and initialize a bridge s=
tate
> - *				      to its default
> - * @bridge: the bridge this state refers to
> - *
> - * Allocates the bridge state and initializes it to default values. This=
 helper
> - * is meant to be used as a bridge &drm_bridge_funcs.atomic_reset hook f=
or
> - * bridges that don't subclass the bridge state.
> - */
> -struct drm_bridge_state *
> -drm_atomic_helper_bridge_reset(struct drm_bridge *bridge)
> -{
> -	return drm_atomic_helper_bridge_create_state(bridge);
> -}
> -EXPORT_SYMBOL(drm_atomic_helper_bridge_reset);
> -

[Severity: Low]
Are there still kernel-doc references to drm_atomic_helper_bridge_reset()
that need to be updated?

For example, struct drm_bridge_funcs in include/drm/drm_bridge.h and
drm_atomic_helper_bridge_destroy_state() in
drivers/gpu/drm/drm_atomic_state_helper.c still refer to this removed funct=
ion.


While reviewing this refactoring, I noticed a pre-existing issue in one of =
the
Cadence bridge drivers that hasn't been converted yet:

drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c:cdns_dsi_bridge_atomic_reset=
() {
	struct cdns_dsi_bridge_state *dsi_state;

	dsi_state =3D kzalloc_obj(*dsi_state);
	if (!dsi_state)
		return ERR_PTR(-ENOMEM);

	memset(dsi_state, 0, sizeof(*dsi_state));
	dsi_state->base.bridge =3D bridge;

	return &dsi_state->base;
}

[Severity: High]
This isn't a bug introduced by this patch, but could this fail to initialize
the private object pointer (state->base.base.obj) and leave it uninitialized
(null)?

Since it does not call __drm_atomic_helper_bridge_state_init() like the core
helpers do, could this lead to a null pointer dereference when attempting to
print the private object state later (for example, on a mode commit failure
or debugfs read)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-drm-no-mor=
e-bridge-reset-v2-0-0a91018bf886@kernel.org?part=3D74
