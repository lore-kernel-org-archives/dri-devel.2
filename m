Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA92CCA5FC1
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 02:24:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0B8010E106;
	Thu,  1 Oct 2026 02:24:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LbPY+ZU5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2AAD10E106
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 02:24:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 671A14005C;
 Thu,  1 Oct 2026 02:24:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2913F1F000FF;
 Thu,  1 Oct 2026 02:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790821497;
 bh=bpxHN+x1Jlear0VlwX3c3kRTKqI1LQHVCeos2yD7xpI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LbPY+ZU5nkL9kCacPo64wQsXWDW4dpuDKTKFEvwMznDIRRhUw6pZuT76/HOq1Ii1k
 PRdhKoBfzJ1qMUoWgXq1hDaXqUvEh6X6MhENB3xt85Z9mxJ6pS3W0AypqczNiDsdCE
 RAKsDu7IuwKWThKxZw2W5kSaqFX05kybQnGkwIqu+m8M/Tb5u6He+21Xu2DnbxlZsp
 M/lrr82rfE4KIi5Cuk/rm+91SolqFS+EaEDVWz8xj7h/Z02PR5FOam9mXgm5mKNAzL
 lygnZcxTRR5+YSHSevB2tOhYT7UtlBP00CGYtR3E/Yeo8IA5W4J+OLsFPMDiL3INn+
 blkTsi0tX3IbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC] drm/amd/display: Disable CRTC on MST connector
 unregister
To: "David Medina" <b2amedina@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260930-amd-mst-teardown-v1-1-16a39ebdd4de@gmail.com>
References: <20260930-amd-mst-teardown-v1-1-16a39ebdd4de@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 02:24:56 +0000
Message-Id: <20261001022457.2913F1F000FF@smtp.kernel.org>
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
- [High] drm/amd: TOCTOU race and UAF from lockless crtc read
- [Medium] drm/amd: incomplete CRTC disable leaks planes and FBs
--

commit fad621ba901c426d67d64397ce2dc5fd953430db
Author: David Medina <b2amedina@gmail.com>

drm/amd/display: Disable CRTC on MST connector unregister

This commit forces a modeset that disables the CRTC when an MST connector is
unregistered. This prevents an encoder conflict during subsequent re-plugs.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 045a7f88b7546..24b1460687393 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -227,6 +228,7 @@ amdgpu_dm_mst_connector_early_unregister(struct drm_c=
onnector *connector)
>  	struct amdgpu_dm_connector *root =3D aconnector->mst_root;
>  	struct dc_link *dc_link =3D aconnector->dc_link;
>  	struct dc_sink *dc_sink =3D aconnector->dc_sink;
> +	struct drm_crtc *crtc =3D connector->state ? connector->state->crtc : N=
ULL;

[Severity: High]
Does amdgpu_dm_mst_connector_early_unregister() in
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c read
connector->state->crtc locklessly before locks are acquired?

If a concurrent modeset occurs when hot-unplugging an MST display, the
captured crtc pointer may be stale. When drm_atomic_get_crtc_state() later
locks and disables this CRTC, could it now belong to another display or have
been freed, leading to a use-after-free or unintended display teardown?

[ ... ]
> +	if (crtc) {
> +		struct drm_atomic_commit *state;
> +		struct drm_connector_state *conn_state;
> +		struct drm_crtc_state *crtc_state;
> +		struct drm_modeset_acquire_ctx ctx;
> +		int ret;
> +
> +		drm_modeset_acquire_init(&ctx, 0);
> +retry:
> +		state =3D drm_atomic_commit_alloc(connector->dev);
> +		if (!state)
> +			goto out;
> +		state->acquire_ctx =3D &ctx;
> +
> +		crtc_state =3D drm_atomic_get_crtc_state(state, crtc);
> +		ret =3D PTR_ERR_OR_ZERO(crtc_state);
> +		if (!ret)
> +			crtc_state->active =3D false;
> +		if (!ret)
> +			ret =3D drm_atomic_set_mode_prop_for_crtc(crtc_state, NULL);
> +		if (!ret) {
> +			conn_state =3D drm_atomic_get_connector_state(state, connector);
> +			ret =3D PTR_ERR_OR_ZERO(conn_state);
> +		}
> +		if (!ret)
> +			ret =3D drm_atomic_set_crtc_for_connector(conn_state, NULL);
> +		if (!ret)
> +			ret =3D drm_atomic_commit(state);

[Severity: Medium]
Is amdgpu_dm_mst_connector_early_unregister() missing the step to detach the
affected planes from the disabled CRTC before committing the atomic state?

The DRM core atomic helpers require that planes attached to a disabled CRTC
have their framebuffers detached.

If drm_atomic_helper_check_modeset() automatically adds the planes to the
state, won't drm_atomic_helper_check_planes() reject the commit because the
planes still have framebuffers?

If these checks are bypassed, could this leak planes and framebuffers
indefinitely when an active MST connector is unplugged?

> +
> +		drm_atomic_commit_put(state);
> +		if (ret =3D=3D -EDEADLK) {
> +			drm_modeset_backoff(&ctx);
> +			goto retry;

[Severity: High]
If a deadlock occurs and we drop locks to backoff, should the crtc pointer
be re-read safely under lock after jumping back to the retry label?

By reusing the pointer read locklessly earlier in the function, the retry
loop might operate on a stale pointer if the state changed during the
backoff.

> +		}
> +		if (ret)
> +			drm_err(connector->dev,
> +				"DM_MST: failed to disable CRTC for removed connector %s (%d)\n",
> +				connector->name, ret);
> +out:
> +		drm_modeset_drop_locks(&ctx);
> +		drm_modeset_acquire_fini(&ctx);
> +	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-amd-mst-te=
ardown-v1-1-16a39ebdd4de@gmail.com?part=3D1
