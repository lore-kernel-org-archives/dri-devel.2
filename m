Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF41CC982D8
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 14:47:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F102210F386;
	Fri, 18 Sep 2026 14:47:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cltDtIfH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F71910F386
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 14:47:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3A49840349
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 14:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74FC1F000FF;
 Fri, 18 Sep 2026 14:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789742836;
 bh=v0CjmNtYSsD0oWFQkZmAEmCsM2N9Pn91jX2iJj02Lsw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cltDtIfHHjcRPZhI7bS6Mykr5OIz0TQnu+COv5RUiK55MiK9rCHqcnSlKJeZj6RZi
 71jVNS4XyxZs+Gvo/Tnq1vkDSRg6G+FaKFVEAuRMSmXOmmCaAOUunXtPqNYBqO8U8/
 AeI0xDierL7T2n7cTEXxBfIgDneEHnCfndvr4zIV2b69Bfcv5EdszTcLFfYbLc9UtN
 Rqh4VySqAY3bGu7akBDa430d9Kp7FHsYuOU/3C8VlK+1Zv/JfLzgdHeV41n9kcXgvi
 sm9mPY90qDSapQAm3ospCcQe6X/9v15+c9xe+ybKTjUXmVceCYdZ8M0XFP6X8FjLAY
 sKgGH15vmjeKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/13] drm/atomic: Allow filling a commit with
 pristine object states
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260918-drm-reset-state-flag-v4-10-5ad106370f05@kernel.org>
References: <20260918-drm-reset-state-flag-v4-0-5ad106370f05@kernel.org>
 <20260918-drm-reset-state-flag-v4-10-5ad106370f05@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 14:47:15 +0000
Message-Id: <20260918144715.E74FC1F000FF@smtp.kernel.org>
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
- [High] drm/atomic: deadlock on NULL acquire_ctx in drm_atomic_commit_fill=
_with_defaults
- [Medium] drm/atomic: lock inversion in drm_atomic_commit_fill_with_defaul=
ts
--

commit 955de6594c45c6a520389d6b2f5a51cb5ce03d61
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic: Allow filling a commit with pristine object states

This commit adds drm_atomic_commit_fill_with_defaults() to iterate over all
CRTCs, planes, connectors, and color operations in the device. It inserts a
fresh default state for each one into the atomic commit. This is intended to
be used with the upcoming DRM_MODE_ATOMIC_RESET flag to bring the device
back to a known baseline.

> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 7a77051096c91..b039edaa3271f 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c

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
> +	drm_WARN_ON(dev, !commit->acquire_ctx);
> +
> +	/*
> +	 * Private objects are ignored because none have userspace
> +	 * properties we might want to reset. atomic_check

[ ... ]

> +	drm_for_each_plane(plane, dev) {
> +		struct drm_plane_state *plane_state;
> +
> +		ret =3D drm_modeset_lock(&plane->mutex, commit->acquire_ctx);

[Severity: Medium]
Does the locking order starting here create a lock inversion against standa=
rd
paths?

The standard DRM top-down locking hierarchy typically locks the
connection_mutex first, then CRTCs, and finally planes (as seen in
drm_modeset_lock_all_ctx).

However, drm_atomic_commit_fill_with_defaults() iterates and locks objects
in the reverse order (planes -> CRTCs -> connection_mutex). If userspace
invokes the DRM_MODE_ATOMIC_RESET flag while concurrent atomic operations
are running, could this inefficient locking cause ww_mutex to abort
transactions with -EDEADLK and retry, leading to unnecessary contention and
performance penalties?

[ ... ]

> +	drm_connector_list_iter_begin(dev, &conn_iter);
> +	drm_for_each_connector_iter(connector, &conn_iter) {
> +		struct drm_connector_state *connector_state;
> +
> +		ret =3D drm_modeset_lock(&config->connection_mutex, commit->acquire_ct=
x);

[Severity: High]
Can this loop cause a hard deadlock if commit->acquire_ctx is NULL?

Earlier in the function, drm_WARN_ON(dev, !commit->acquire_ctx) detects a
missing acquire context, but execution is allowed to continue. When we reach
this loop, drm_modeset_lock() is called for every connector.

If commit->acquire_ctx is NULL, the first iteration will successfully acqui=
re
the underlying mutex, but the second iteration will attempt to recursively
lock the same connection_mutex without a ww_mutex context and block
indefinitely. Should the drm_WARN_ON() above be accompanied by an early
return to prevent this unrecoverable multi-connector deadlock?

> +		if (ret) {
> +			drm_connector_list_iter_end(&conn_iter);
> +			return ret;
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-drm-reset-=
state-flag-v4-0-5ad106370f05@kernel.org?part=3D10
