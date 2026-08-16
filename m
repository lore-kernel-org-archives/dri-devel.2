Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB23C5B572
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 17:07:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAD5B10E1D0;
	Sun, 16 Aug 2026 17:07:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SX91Ybo2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F5CE10E1D0
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 17:07:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A828242A44;
 Sun, 16 Aug 2026 17:07:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5E11F000E9;
 Sun, 16 Aug 2026 17:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786900040;
 bh=T+F35ZvnhQQz2dsfbi4z0m0WwCn3aXK7LZYTXCE+kng=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SX91Ybo2JetjTkvD4FXB3riOK/t6ziyOz3Ik5eDugh+6/KIXtXob3sOQciQxVmv8Y
 8JKjcIbIti2OxqAXSEBBe5RnhhENqID+aLXemGQ2ThBEcuO2TgUyBqVSj3HSinxf88
 oB+fmAXPFW3grBryAsgkm8mmnxA+hOStXpJrWuKO9L3KWrOhKV+O9OgYWP1ZaH38gn
 /ZVcU/y0x5QqZgc5MDxfSETsbVMrm1O4kuGyFx0f+bLZ2uV999IMMxw4bF+lj4nLYL
 L0bfpC2ktmIS79LufmMfMQAfQ55KS635Xs1oi4fzsjA6Cjqo1wTFNIZkr371GQpAcy
 /u+GnXdoFI5pA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/gem: Handle shadow plane state allocation failure
To: "Triet Hoang" <triet.hoang.dev@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260816165852.44558-1-triet.hoang.dev@gmail.com>
References: <20260816165852.44558-1-triet.hoang.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 17:07:19 +0000
Message-Id: <20260816170720.6A5E11F000E9@smtp.kernel.org>
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
- [High] Returning early on allocation failure in `drm_gem_reset_shadow_pla=
ne` leaves the old plane state intact, violating DRM atomic reset semantics=
 and causing state desynchronization.
--

--- Patch [1]: [PATCH] drm/gem: Handle shadow plane state allocation failur=
e ---
commit 0d95f6bd3cf4e9b3b32636265a7263dcbf12db13
Author: Triet Hoang <triet.hoang.dev@gmail.com>

drm/gem: Handle shadow plane state allocation failure

Allocate the new shadow plane state before destroying the existing
state, so that an allocation failure leaves the current state intact.

> diff --git a/drivers/gpu/drm/drm_gem_atomic_helper.c b/drivers/gpu/drm/dr=
m_gem_atomic_helper.c
> --- a/drivers/gpu/drm/drm_gem_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_gem_atomic_helper.c
> @@ -308,14 +308,16 @@ EXPORT_SYMBOL(__drm_gem_reset_shadow_plane);
>   */
>  void drm_gem_reset_shadow_plane(struct drm_plane *plane)
>  {
> -	struct drm_shadow_plane_state *shadow_plane_state;
> +	struct drm_shadow_plane_state *shadow_plane_state =3D kzalloc_obj(*shad=
ow_plane_state);
> +
> +	if (!shadow_plane_state)
> +		return;

[Severity: High]
Does returning early here violate DRM atomic reset semantics?

The .reset hook must completely clear the software state to mirror the hard=
ware
reset (which defaults to disabled). By returning early on allocation failur=
e,
the old plane->state is left intact.

Could this cause the plane's software state to become desynchronized from b=
oth
the hardware and other DRM objects (like CRTCs, which will have their state
cleared)?

Subsequent atomic commits might then operate on this broken software state
(e.g., a plane pointing to a disabled CRTC), causing validation failures
or crashes.

> =20
>  	if (plane->state) {
>  		drm_gem_destroy_shadow_plane_state(plane, plane->state);
>  		plane->state =3D NULL; /* must be set to NULL here */
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260816165852.4455=
8-1-triet.hoang.dev@gmail.com?part=3D1
