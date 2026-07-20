Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E1B8C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 21:06:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD44810E184;
	Mon, 20 Jul 2026 21:06:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CBd7xwOI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90D3F10E184
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 21:06:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4BEB94022E;
 Mon, 20 Jul 2026 21:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042F81F000E9;
 Mon, 20 Jul 2026 21:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784581570;
 bh=pEFwnVsL+Aph7QkIbeWkPLnwuLleApp3ck8PgeNS/H8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CBd7xwOIJCZX8lacsBHb1PqcyR2DLg7AYX56xdDmm2HpxmfKEVElvkDVRiEDPLo3i
 eM4kRqTppZQeeYTn28uQOJYnRc5+xvNYzlVi2cL6lh2+1ebnydF7dFDJ4eeZoYdwjj
 vwD0jP3D/qi0yvkBvnirsZEfnPN0LY55zOOJEsS+AOeoDB8MHZNkGU0Amt6/P89el0
 8HLgRCVuGiu1mpI1qjMRyAjpS9CJ96f1/yu7IWrDZGPFrxvsaGLLnKgJVXdKRsPCOk
 IrFF6WOm++mHQ1k8QwFaV0JMUTPVVJqxz82biw36GJdrGCXePRuKED5ZTkdaFQIo6t
 /GlMWxHcVkOdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] drm/nouveau/kms/nv50-: Add .blend_modes to
 nv50_wndw_func
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260720205541.257781-2-lyude@redhat.com>
References: <20260720205541.257781-1-lyude@redhat.com>
 <20260720205541.257781-2-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 21:06:09 +0000
Message-Id: <20260720210610.042F81F000E9@smtp.kernel.org>
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
- [Medium] Pre-Volta primary planes (base507c, base827c, base907c) expose a=
lpha formats but are missing `.blend_modes` assignments, leaving the DRM co=
re warning unfixed for these architectures.
--

--- Patch [1]: [PATCH v2 1/3] drm/nouveau/kms/nv50-: Add .blend_modes to nv=
50_wndw_func ---
commit 742edbbf0331352f33ff9e6b7929be21b191145a
Author: Lyude Paul <lyude@redhat.com>
Subject: drm/nouveau/kms/nv50-: Add .blend_modes to nv50_wndw_func

At the moment, we currently (incorrectly) only expose a blend property on
the plane if we have a nv50_wndw_func->blend_set function for the given
wndw type. But we need to expose a blend property for all types of planes
that can display color formats with an alpha channel.

Prepare for doing this by introducing a way of looking up the supported
blend modes for a type of wndw by introducing .blend_modes, which describes
all possible blending modes nouveau currently supports for a type of wndw.

> diff --git a/drivers/gpu/drm/nouveau/dispnv50/wndw.h b/drivers/gpu/drm/no=
uveau/dispnv50/wndw.h
> index 90d100514bef2..81af5c3369d4c 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/wndw.h
> +++ b/drivers/gpu/drm/nouveau/dispnv50/wndw.h
[ ... ]
> @@ -74,6 +76,7 @@ struct nv50_wndw_func {
>  	int (*image_clr)(struct nv50_wndw *);
>  	int (*scale_set)(struct nv50_wndw *, struct nv50_wndw_atom *);
>  	int (*blend_set)(struct nv50_wndw *, struct nv50_wndw_atom *);
> +	unsigned int blend_modes;

[Severity: Medium]
Does this patch miss setting .blend_modes for pre-Volta primary planes?

Looking at base507c, base827c, and base907c in the driver, they expose alpha
formats but don't seem to have .blend_modes assignments added in this patch.

For example, in drivers/gpu/drm/nouveau/dispnv50/base507c.c:

static const struct nv50_wndw_func
base507c =3D {
	.acquire =3D base507c_acquire,
	.release =3D base507c_release,
	...
	.image_clr =3D base507c_image_clr,
	.update =3D base507c_update,
};

Without setting .blend_modes for these architectures, will they still trigg=
er
the DRM core warning "[PLANE:%d:%s] pixel format with alpha exposed but ble=
nd
mode not setup" during display initialization on Tesla through Pascal hardw=
are?

> =20
>  	int (*update)(struct nv50_wndw *, u32 *interlock);
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720205541.2577=
81-1-lyude@redhat.com?part=3D1
