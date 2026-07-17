Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D788C44516
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 22:59:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E3A110E2E5;
	Fri, 17 Jul 2026 22:59:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FOWTOFN/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A5FC10E2E5
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 22:59:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 49E3E60A94;
 Fri, 17 Jul 2026 22:59:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F7D1F000E9;
 Fri, 17 Jul 2026 22:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784329188;
 bh=hHpDbipTg+2rfvc8FlMPTgHKR3oES9LmR4wEw2LwaN8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FOWTOFN/Lvp1TTmdpfiAOks1VyvQCyVWE8CSt9xlbiEJu/bv8gIgNIHNqDk47ASEb
 e1o8xTavzn30P3X4gvOuKiDP24nYbvweYj9Odzb8wd0PWL/WozXMrfqYfmKNQjDdGo
 TKI0CuVwpNVYHsqY8GUt27He8axbu+OlhVXkV4W9AVA93PeuX35m89+Ic04TDh56RS
 h5riIXWa9Kp5i5gMeXohD2vUdXMCbIb1bmAJ7z7bPYITqdt1l/4LVHLMtCHe/SDHla
 YxHATogG2qTWtq+DmGssF04gIGs20XimwpqVMG7R83S2nIvHaoR36kXwfGoZ3mg2m6
 WxwIk0IjCbbxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/nouveau/kms/nv50-: Unconditionally create
 blend_mode prop for wndws
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260717224743.1335833-1-lyude@redhat.com>
References: <20260717224743.1335833-1-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 22:59:47 +0000
Message-Id: <20260717225947.D6F7D1F000E9@smtp.kernel.org>
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
- [High] Unconditionally advertising DRM_MODE_BLEND_PIXEL_NONE for planes l=
acking a blend_set function misrepresents hardware capabilities and causes =
an invalid default state.
--

--- Patch [1]: [PATCH] drm/nouveau/kms/nv50-: Unconditionally create blend_=
mode prop for wndws ---
commit 65d6020658fcfef6b7934d20f776a5e3e0b49e2b
Author: Lyude Paul <lyude@redhat.com>

drm/nouveau/kms/nv50-: Unconditionally create blend_mode prop for wndws

This commit unconditionally calls drm_plane_create_blend_mode_property()
for all window types, including cursors, to prevent a warning when a
pixel format with alpha is exposed but the blend mode is not set up.

> diff --git a/drivers/gpu/drm/nouveau/dispnv50/wndw.c b/drivers/gpu/drm/no=
uveau/dispnv50/wndw.c
> --- a/drivers/gpu/drm/nouveau/dispnv50/wndw.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/wndw.c
> @@ -860,6 +860,7 @@ nv50_wndw_new_(const struct nv50_wndw_func *func, str=
uct drm_device *dev,
>  	struct nv50_disp *disp =3D nv50_disp(dev);
>  	struct nv50_wndw *wndw;
>  	const u64 *format_modifiers;
> +	unsigned int blend_modes =3D BIT(DRM_MODE_BLEND_PIXEL_NONE);
>  	int nformat;
>  	int ret;

[ ... ]

> @@ -922,6 +918,10 @@ nv50_wndw_new_(const struct nv50_wndw_func *func, st=
ruct drm_device *dev,
>  			return ret;
>  	}
> =20
> +	ret =3D drm_plane_create_blend_mode_property(&wndw->plane, blend_modes);
> +	if (ret)
> +		return ret;

[Severity: High]
Does this cause a UAPI mismatch by exposing only DRM_MODE_BLEND_PIXEL_NONE
for cursor planes or other planes lacking a blend_set function?

In the DRM core, __drm_atomic_helper_plane_state_init() hardcodes the
default plane_state->pixel_blend_mode to DRM_MODE_BLEND_PREMULTI.

If nv50_wndw_new_() initializes blend_modes to only allow PIXEL_NONE, the
resulting property state will contain a default value (PREMULTI) that is
not part of its valid enum list.

Could this cause strict compositors like Weston to crash or fail
initialization when they validate the property values against the allowed
dictionary?

Will this also cause userspace to falsely assume the hardware cursor lacks
alpha blending support?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717224743.1335=
833-1-lyude@redhat.com?part=3D1
