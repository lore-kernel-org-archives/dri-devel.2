Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F374DC44520
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 21:59:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41FE089238;
	Mon, 20 Jul 2026 21:59:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HMoRAd+K";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3154689238
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 21:59:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ECD5740296;
 Mon, 20 Jul 2026 21:59:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB641F000E9;
 Mon, 20 Jul 2026 21:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784584775;
 bh=lXvSOnYhDxBahA0TqnKTinZ19kdbj/E10gdGQclt4KA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HMoRAd+KIjVO/pF0f+EBpPTrZQL7VJ/BGvafxXl3FPNdloOy2W+MaMiNq68I7R+XU
 5P7bjZDsxpJ81RLqnzYQ9Shdtdxhm+1E+zrRQZDtWnNUTTnr0M1lCZ04oqAZIjySsi
 ab9Xv/eSnmegxLI+s9WzusgvX47pF45p+02DL6Otq+o1Zu3skYFlVk8E67xBOt4cJy
 mp7Iqom0cOLV74lJz5GeeimSktxNw3jIGGBhlNyGD+RIp8hEevMSiM/u8MdglIT1w3
 yQeXloL7CJfKTITyf74rKTbHiQ6xGM5q/ESgtixq3Gt4iSl5mBVjuqXlEQc7o/lZhm
 5Rn0+K8JM76dQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] drm/nouveau/kms/nv50-: Add .blend_modes to
 nv50_wndw_func
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260720215058.398210-2-lyude@redhat.com>
References: <20260720215058.398210-1-lyude@redhat.com>
 <20260720215058.398210-2-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 21:59:35 +0000
Message-Id: <20260720215935.AFB641F000E9@smtp.kernel.org>
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
- [Low] The macro `WNDW_BLEND_MODES` is defined as a bitwise OR of multiple=
 values without enclosing parentheses, creating a latent bug due to operato=
r precedence.
--

--- Patch [1]: [PATCH v3 1/3] drm/nouveau/kms/nv50-: Add .blend_modes to nv=
50_wndw_func ---
commit d67d01315e1f18573429becf6e45ab97a7ea2324
Author: Lyude Paul <lyude@redhat.com>

drm/nouveau/kms/nv50-: Add .blend_modes to nv50_wndw_func

This commit adds a .blend_modes field to the nv50_wndw_func struct and
various display structures. This introduces a way to look up supported
blend modes for different types of windows to expose a blend property
for all planes that can display color formats with an alpha channel.

[ ... ]
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/wndw.h b/drivers/gpu/drm/no=
uveau/dispnv50/wndw.h
> index 90d100514bef2..81af5c3369d4c 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/wndw.h
> +++ b/drivers/gpu/drm/nouveau/dispnv50/wndw.h
[ ... ]
> @@ -139,4 +142,11 @@ int wndwca7e_new(struct nouveau_drm *, enum drm_plan=
e_type, int, s32,
> =20
>  int nv50_wndw_new(struct nouveau_drm *, enum drm_plane_type, int index,
>  		  struct nv50_wndw **);
> +
> +/* A set of blend modes supported by all wndws */
> +#define WNDW_BLEND_MODES               \
> +	  BIT(DRM_MODE_BLEND_COVERAGE) \
> +	| BIT(DRM_MODE_BLEND_PREMULTI) \
> +	| BIT(DRM_MODE_BLEND_PIXEL_NONE)

[Severity: Low]
Does this multi-token macro need to be enclosed in parentheses?

If WNDW_BLEND_MODES is later used in an expression with operators that have
higher precedence than bitwise OR (such as flags & WNDW_BLEND_MODES),
it will evaluate incorrectly. Enclosing the entire expression in
parentheses would prevent future operator precedence issues.

> +
>  #endif
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720215058.3982=
10-1-lyude@redhat.com?part=3D1
