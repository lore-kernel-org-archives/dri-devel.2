Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7460AC5B572
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:18:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFCC310E41E;
	Wed, 12 Aug 2026 13:18:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nA6PHKdO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46CDB10E41E
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 13:18:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 852D060A92
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 13:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098131F000E9;
 Wed, 12 Aug 2026 13:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786540708;
 bh=vwmu1S9XfrKmMFMExf3sFkkmx1PTsUJVYarD6uX0aF0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nA6PHKdOc+0Jb/GgKazc3hFZzLzOYUiMeqjkJE/M5BrKr4J4HZDeu4yNjBG8dAEqk
 QwF0I2G7uTTkZJ+c7x1vfrP3X10t19piqJjPl61Q3RU43YJDLSC0I4CiXS+LJihCFm
 B5Bsa/REOF8piX2XUyeykXhjcTd8/G1YSRG2FKH2Yb4niEohs8GWstsi61oSs57wDG
 ErvxqFjhg9/FEI7ut4J+UJhJ2yeXt8/VFiRT8npIbCk8xIeQpiXUBmXL+Oo9KwusWl
 B6/ALCtXzMPgoOm6XQ/AqzbHdcGQ7/mLootuU55fM0F8Chx9S7KqxJeiJK824KRhGM
 ZAF0HsdFKU3qQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 8/9] drm/atomic: Allow filling a commit with
 pristine object states
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260812-drm-reset-state-flag-v2-8-e96ce13317dd@kernel.org>
References: <20260812-drm-reset-state-flag-v2-0-e96ce13317dd@kernel.org>
 <20260812-drm-reset-state-flag-v2-8-e96ce13317dd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 13:18:27 +0000
Message-Id: <20260812131828.098131F000E9@smtp.kernel.org>
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
- [High] Missing lock acquisition for `colorop->plane->mutex` before access=
ing and modifying colorop state.
- [Low] Grammar error in code comment ('there' instead of 'their').
--

--- Patch [8]: [PATCH RFC v2 8/9] drm/atomic: Allow filling a commit with p=
ristine object states ---
commit be70167a2a5eebe655b84ef35f7fed5d15989a8f
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic: Allow filling a commit with pristine object states

This commit introduces drm_atomic_commit_fill_with_defaults() to populate
an atomic commit with pristine initial states for all display objects. It
uses atomic_create_state() hooks to provide a fresh default state for
reset operations.

> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index d8251447e44a5..d5ac10dd3148e 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
[ ... ]
> +int drm_atomic_commit_fill_with_defaults(struct drm_atomic_commit *commi=
t)
> +{
[ ... ]
> +	/*
> +	 * Private objects are ignored because none have userspace
> +	 * properties we might want to reset. atomic_check
> +	 * implementations will derive or infer there private obj state
                                                 ^^^^^
[Severity: Low]
This isn't a bug, but there's a grammatical error here. Should "there" be
"their"?

> +	 * from the state that will end up being committed anyway.
> +	 */
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

[Severity: High]
Does this loop need to acquire the lock before asserting it is held?

Unlike the loops for planes, CRTCs, and connectors below which explicitly
call drm_modeset_lock(), this colorop loop calls
drm_modeset_lock_assert_held() on colorop->plane->mutex without acquiring
it first.=20

Will this cause a lockdep assertion failure and leave colorop->state
unprotected against concurrent modifications?

> +		if (ret) {
> +			drm_colorop_atomic_destroy_state(colorop, colorop_state);
> +			return ret;
> +		}
> +	}
> +
> +	drm_for_each_plane(plane, dev) {
> +		struct drm_plane_state *plane_state;
> +
> +		ret =3D drm_modeset_lock(&plane->mutex, commit->acquire_ctx);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-drm-reset-=
state-flag-v2-0-e96ce13317dd@kernel.org?part=3D8
