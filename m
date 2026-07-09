Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B57C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 12:20:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4823810F585;
	Thu,  9 Jul 2026 12:20:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EfXWCBea";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 295B010F585
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:20:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A13C16001A
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:20:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0F31F000E9;
 Thu,  9 Jul 2026 12:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783599651;
 bh=vZTsp41HjC805G9v/zmz46Rq9P3TG2L3iteOrHH/7uU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EfXWCBea1DUpxFQQNNeSQ+54qOm1oAQWS8Gagrl97WWoUSwKNuDzWMhLeYHQf+qQF
 tPmqlkgMgSKgLLsCsRM33gkJU6rSG458kjMK5LANvzk5DgZ8tPqhiTkmq364peY/M6
 d005avQfM8skZtEyKMGioBxEFHbmvAoCgmf1Tkp+Zay65/FlyZ6ypNuLI1F2f3Xq4s
 FVk6Az/lq0JaiusjSDkKM9cIeVtYbnus9ekjWeYCYT38qY8Ahrj6hzUUy0VjoQTZjk
 ERRPovviNP8gAAacmqAUSJDvsqEEttULDiwAClz/DvE2jS5zhQxp5DKCKa0I6sOSca
 UKsc/OhGVDkdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 35/60] drm/vboxvideo: Convert to atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-35-302d986fe5f0@kernel.org>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
 <20260709-drm-no-more-plane-reset-v1-35-302d986fe5f0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 12:20:50 +0000
Message-Id: <20260709122051.2E0F31F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] The driver acquires a mutex in plane atomic update and disable cal=
lbacks, which execute in atomic context where sleeping is forbidden.
--

--- Patch [35]: [PATCH 35/60] drm/vboxvideo: Convert to atomic_create_state=
 ---
commit b805e15405279473a42dd26a1b3da549e8eee553
Author: Maxime Ripard <mripard@kernel.org>

drm/vboxvideo: Convert to atomic_create_state

The plane only initializes a pristine state in its reset hook
using drm_atomic_helper_plane_reset(), which is equivalent to what
atomic_create_state expects. Convert to it.

> diff --git a/drivers/gpu/drm/vboxvideo/vbox_mode.c b/drivers/gpu/drm/vbox=
video/vbox_mode.c
> index 8e4e5fc9d3c5a..a30e9265ecb17 100644
> --- a/drivers/gpu/drm/vboxvideo/vbox_mode.c
> +++ b/drivers/gpu/drm/vboxvideo/vbox_mode.c
> @@ -498,7 +498,7 @@ static const struct drm_plane_funcs vbox_primary_plan=
e_funcs =3D {
>  	.update_plane	=3D drm_atomic_helper_update_plane,
>  	.disable_plane	=3D drm_atomic_helper_disable_plane,
>  	.destroy	=3D drm_plane_helper_destroy,
> -	.reset		=3D drm_atomic_helper_plane_reset,
> +	.atomic_create_state =3D drm_atomic_helper_plane_create_state,

[Severity: High]
This isn't a bug introduced by this patch, but does this driver sleep in
atomic context during plane updates?

Looking at other functions in this file, the atomic update and disable
callbacks appear to acquire a mutex:

drivers/gpu/drm/vboxvideo/vbox_mode.c:vbox_primary_atomic_update() {
    ...
    mutex_lock(&vbox->hw_mutex);
    ...
}

Similarly, vbox_cursor_atomic_update() and vbox_cursor_atomic_disable()
also call mutex_lock(&vbox->hw_mutex), and vbox_primary_atomic_disable()
calls vbox_crtc_set_base_and_mode() which acquires the same mutex.

Since the DRM core executes plane atomic update and disable callbacks in an
atomic context where sleeping functions are forbidden, could this cause
kernel warnings about sleeping in an invalid context, or potential deadlocks
during non-blocking commits?

>  	.atomic_duplicate_state =3D drm_atomic_helper_plane_duplicate_state,
>  	.atomic_destroy_state =3D drm_atomic_helper_plane_destroy_state,
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-drm-no-mor=
e-plane-reset-v1-0-302d986fe5f0@kernel.org?part=3D35
