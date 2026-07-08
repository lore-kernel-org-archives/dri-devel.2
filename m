Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D539EC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:16:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D5AE10E60F;
	Wed,  8 Jul 2026 16:16:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Vnln1uGa";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B340A10E60F
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 16:16:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7CC7641282
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 16:16:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324601F00A3A;
 Wed,  8 Jul 2026 16:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783527393;
 bh=8DKsGbUWaGYIXZC5ncJVLjSAaHRnEznIi3E3/SmsDFk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Vnln1uGaSCtAvxACDjA6LNJHWxzXngJ29yp9ignwotMHngaOT8TKKAi98fWYd5TC9
 RyW42SZHbWGUYE3idUTkrqjtgq/Yny5379tHu9mVmGzkqq1N23ErTQnauoXA7NcL+i
 MfTthY64h938Bu6mVtv+PU92yAfKiyMuYS5C09LblvFY5gd/eKyL/PRpXpB7RaR5Ca
 XJglKwWdXdwu25Ewnq4t6KIR90Cuu46ck28/xOfNnLGU0hzgXB/la+BZ4XKKYWyBS9
 RKu8ZN0TaAVq4JNRCrHpVV+QL+QxEaNnVihIIKCcQ4goJTOYd/8l5zUNdkWc7a0G1V
 LFqWHLbQdINag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 1/8] drm/atomic: colorop: Rename state to
 state_to_destroy
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260708-drm-reset-state-flag-v1-1-c37dc985485d@kernel.org>
References: <20260708-drm-reset-state-flag-v1-0-c37dc985485d@kernel.org>
 <20260708-drm-reset-state-flag-v1-1-c37dc985485d@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 16:16:32 +0000
Message-Id: <20260708161633.324601F00A3A@smtp.kernel.org>
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
- [Low] Incomplete rename of the `state` field to `state_to_destroy` in `st=
ruct __drm_colorops_state` causes a compilation failure.
--

--- Patch [1]: [PATCH RFC 1/8] drm/atomic: colorop: Rename state to state_t=
o_destroy ---
commit d09bd0c6257ce0056d0f8ea064c0723f0d09039a
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic: colorop: Rename state to state_to_destroy

This patch renames the state field to state_to_destroy in the
__drm_colorops_state structure to better describe its purpose and match
other atomic state tracking structures.

> diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
> --- a/include/drm/drm_atomic.h
> +++ b/include/drm/drm_atomic.h
> @@ -159,7 +159,23 @@ struct drm_crtc_commit {
> =20
>  struct __drm_colorops_state {
>  	struct drm_colorop *ptr;
> -	struct drm_colorop_state *state, *old_state, *new_state;
> +
> +	/**
> +	 * @state_to_destroy:

[ ... ]

> +	struct drm_colorop_state *state_to_destroy;
> +
> +	struct drm_colorop_state *old_state, *new_state;
>  };

[Severity: Low]
Does this incomplete rename cause a compilation failure?

In drivers/gpu/drm/drm_atomic.c:drm_atomic_get_colorop_state(), the code
still attempts to assign to the old field name:

	state->colorops[index].state =3D colorop_state;
	state->colorops[index].ptr =3D colorop;
	state->colorops[index].old_state =3D colorop->state;

Should this be updated to state_to_destroy as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-drm-reset-=
state-flag-v1-0-c37dc985485d@kernel.org?part=3D1
