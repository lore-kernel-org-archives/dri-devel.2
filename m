Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA2C8C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 13:24:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0659110E228;
	Wed,  1 Jul 2026 13:24:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QxZd/CQz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00D6010E228
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 13:24:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 295466001D;
 Wed,  1 Jul 2026 13:24:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4101F000E9;
 Wed,  1 Jul 2026 13:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782912239;
 bh=hxINaZdd5WNwb91hB9QG/kg8hx5cJOCzkdcNNFjjjR4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QxZd/CQzMdz6MxM9ZsfTVu+HKVQS74iWR8Kx9A5iEofAnuRF401ng/V+PeEsAeZ3p
 TWZdZhdvFKXeiRzx1w1IUDsep517PIzfT7rab/ufbwqog51EUdFvDa8UsKWBTIb+u8
 T3fXjFhiiQ5+8aAOnHXjcc7sCSu+t3KoatS1TBfYOw4yCkQMX+elKydzRAcpb+LboF
 N+vZ7GuoIpqG7UPqfRasXsHifj+7GjmCAsK9/5pzSQ0tOX3JWh7AQ1metYldDEyzBY
 pmOwYg2IJrOj9+wOqwkDu/3BGxeGgSHmTfrAAA1UYN9Z6WGb6Hk3yfdtZa0khR5kjZ
 23G0SGY1X9Ekw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915/display: Handle struct
 drm_plane_state.ignore_damage_clips
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260701130929.234695-1-tzimmermann@suse.de>
References: <20260701130929.234695-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 13:23:59 +0000
Message-Id: <20260701132359.BE4101F000E9@smtp.kernel.org>
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
- [High] drm_atomic_helper_check_plane_damage() is placed too late in the a=
tomic check pipeline and conditionally bypassed, breaking the damage clippi=
ng contract during modesets.
--

commit 5c79bcf5010895b431b3c2135c7b80a5163d8e9f
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/i915/display: Handle struct drm_plane_state.ignore_damage_clips

This commit introduces a call to drm_atomic_helper_check_plane_damage() in
intel_psr2_sel_fetch_update() to selectively ignore damage clipping in cert=
ain
framebuffer changes.

> diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i=
915/display/intel_psr.c
> index 92af21d823a37..5a155f60110fb 100644
> --- a/drivers/gpu/drm/i915/display/intel_psr.c
> +++ b/drivers/gpu/drm/i915/display/intel_psr.c
[ ... ]
> @@ -2949,6 +2949,9 @@ int intel_psr2_sel_fetch_update(struct intel_atomic=
_state *state,
>  		src =3D drm_plane_state_src(&new_plane_state->uapi);
>  		drm_rect_fp_to_int(&src, &src);
> =20
> +		/* Prepare plane-damage state before using it */
> +		drm_atomic_helper_check_plane_damage(&state->base, &new_plane_state->u=
api);
> +
>  		if (!drm_atomic_helper_damage_merged(&old_plane_state->uapi,

[Severity: High]
Is this call to drm_atomic_helper_check_plane_damage() placed too late in t=
he
atomic check pipeline?

By placing it here in intel_psr2_sel_fetch_update() (which runs during the =
CRTC
check phase), intel_plane_atomic_check() has already run and called
intel_plane_copy_uapi_plane_damage(). That means new_plane_state->damage was
already calculated using the unsanitized fb_damage_clips before this check
could clear them during a full modeset.

Additionally, this loop selectively skips planes on non-PSR2 CRTCs or planes
with changed visibility (e.g. via the continue statements earlier in the lo=
op).
Doesn't this mean the damage state is left unsanitized for those skipped
planes, potentially causing visual corruption when restricted clip rectangl=
es
are used instead of updating the full plane?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701130929.2346=
95-1-tzimmermann@suse.de?part=3D1
