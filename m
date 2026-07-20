Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20FB5C44520
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 21:15:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F62910E1AA;
	Mon, 20 Jul 2026 21:15:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IdcCc+rw";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 008F010E1AA
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 21:15:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 926414178B;
 Mon, 20 Jul 2026 21:15:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA811F000E9;
 Mon, 20 Jul 2026 21:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784582103;
 bh=h7q43ByePqEC65OO/7Rtc/3DHZu4JhISMa2EGf0rI28=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IdcCc+rwU/sfVUcJ3AgA3d3ri6u+hHFhl/28UlCYbcDuMar2zSwfEmxX7Z+Ojnf4a
 M6syJaWtbDKwRPkhHli4voxqNYPIh0769vVdSYbWc26pcr8Qvr/2fyAAdEphNQzTAS
 JqYyL7kRuf8WVatLe8SaaIfnJZNRNJfQVWfqiOfJ11OkUrS8S3ow3ylT0dGpJ05p2L
 hedDhdNcie6PYwKi635+4dR8qn4ynasBXOWvJPpFZPi/7pHRiiJKV8OJWvtfbWDnKX
 2jtiDRCWGw3n+W3bebfROtor0Vrt0OP6DrYIXMRU0BmvkvaAIg+dwZXRujVjVTYFx3
 bEg7mGNt34MpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] drm/nouveau/kms/nv50-: Unconditionally create
 blend_mode prop for wndws
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260720205541.257781-4-lyude@redhat.com>
References: <20260720205541.257781-1-lyude@redhat.com>
 <20260720205541.257781-4-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 21:15:02 +0000
Message-Id: <20260720211503.4BA811F000E9@smtp.kernel.org>
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
- [Medium] The patch introduces a conditional check that contradicts its co=
mmit message and results in an incomplete fix for a DRM core WARN_ON. While=
 claiming to 'unconditionally create blend_mode prop for wndws', the code l=
imits this to planes where `func->blend_modes` is non-zero. Older primary p=
lanes (e.g., `base507c`) expose alpha formats but lack `.blend_modes` initi=
alization, meaning they will still trigger the warning.
--

--- Patch [3]: [PATCH v2 3/3] drm/nouveau/kms/nv50-: Unconditionally create=
 blend_mode prop for wndws ---
commit d890a1a203754ff1359f8cdacfa01e033bb7b8f3
Author: Lyude Paul <lyude@redhat.com>
drm/nouveau/kms/nv50-: Unconditionally create blend_mode prop for wndws

This patch attempts to resolve a DRM core validation warning by ensuring the
blend_mode property is created for all window types that expose color forma=
ts
with an alpha channel, even if they lack a blend_set function.

> diff --git a/drivers/gpu/drm/nouveau/dispnv50/wndw.c b/drivers/gpu/drm/no=
uveau/dispnv50/wndw.c
> index 0f331f47bded8..84b9a16bdb8ab 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/wndw.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/wndw.c

[ ... ]

> @@ -944,6 +937,17 @@ nv50_wndw_new_(const struct nv50_wndw_func *func, st=
ruct drm_device *dev,
>  			return ret;
>  	}
> =20
> +	/*
> +	 * DRM requires that we have a blend mode property for any type of plan=
e that exposes color
> +	 * formats with an alpha channel. So do this, even if we don't actually=
 have control for the
> +	 * blend property hooked up with blend_set.
> +	 */
> +	if (func->blend_modes) {

[Severity: Medium]
Does this conditional check contradict the commit message? The commit states
the blend_mode property is created unconditionally for all types of wndws.

However, for older primary planes like base507c, the nv50_wndw_func definit=
ion
does not initialize .blend_modes:

static const struct nv50_wndw_func
base507c =3D {
	.acquire =3D base507c_acquire,
	.release =3D base507c_release,
	.sema_set =3D base507c_sema_set,
	...

Since func->blend_modes evaluates to 0 here, the property creation is skipp=
ed.

Because base507c_format exposes formats with an alpha channel (such as
DRM_FORMAT_ARGB8888), won't skipping the property creation here leave the i=
ssue
unfixed and cause the DRM core validation WARN_ON to still trigger?

> +		ret =3D drm_plane_create_blend_mode_property(&wndw->plane, func->blend=
_modes);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720205541.2577=
81-1-lyude@redhat.com?part=3D3
