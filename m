Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A04C61DE2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 09:38:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB15710E7B1;
	Mon, 31 Aug 2026 09:38:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KJzammed";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B62EA10E7B3
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 09:38:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 901EE434FE;
 Mon, 31 Aug 2026 09:38:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B901F00A3D;
 Mon, 31 Aug 2026 09:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788169105;
 bh=RWvMErnCTB1MdNIcKQQQxgfwNLPtHHGcci8iVwyKK/M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KJzammed+sVEY38DxGlbx3smQohPYPlTBbUuTewaSb1tNzgO29OCGZ41Dhh/GIdNQ
 5E3I99quQKzhB8nqCJISHhVtIgx5BoqqzCxug70xApEhCXVitmVnQ5hSozaevkgVlu
 f4eYnyGt2z97BPC4DBeSYHU66Ja4Fv1FuAXepwZHktGG/6VuSihvpMY1HVtWx4m8bR
 IIuELPFSA/rIZ6I4m4Gryy2tkYlVlm9vfJzqs1u8QzbL3uUsB6j77AuPZ1xb7TnQee
 GiFEFsuMYQfag7yyBtqxRgNLY1hH4jCnyMW6p58JqJ34avYJ7jctjJ+2fmEO8q+bcc
 jdrvSvCx9ggyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/fourcc: Add Apple Interchange layout format modifier
To: "James Calligeros" <jcalligeros99@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831-apple-interchange-modifier-v1-1-5d6e27f9f308@gmail.com>
References: <20260831-apple-interchange-modifier-v1-1-5d6e27f9f308@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 09:38:24 +0000
Message-Id: <20260831093825.47B901F00A3D@smtp.kernel.org>
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
- [Low] Typo in the UAPI documentation comment for `DRM_FORMAT_MOD_APPLE_IN=
TERCHANGE`: 'Unlinke' instead of 'Unlike'.
--

commit 8d891b8a7418ccf3a3ab6fe8fbc786ff834638af
Author: James Calligeros <jcalligeros99@gmail.com>

drm/fourcc: Add Apple Interchange layout format modifier

This commit introduces the DRM_FORMAT_MOD_APPLE_INTERCHANGE format modifier
for Apple platforms. It describes the format as a compressed framebuffer
layout used for sharing buffers between hardware blocks.

> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index a103fdc0b3a36..aa51c116cd7dc 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -1626,6 +1626,26 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 mo=
difier)
>  #define DRM_FORMAT_MOD_APPLE_GPU_TILED fourcc_mod_code(APPLE, 1)
>  #define DRM_FORMAT_MOD_APPLE_GPU_TILED_COMPRESSED fourcc_mod_code(APPLE,=
 2)
> =20
> +/*
> + * Apple Interchange layout
> + *
> + * Apple Interchange is a compressed framebuffer format used exclusively=
 for
> + * sharing buffers between hardware blocks (GPU, display controller, vid=
eo
> + * codecs) on Apple platforms. It is similar to and uses the same compre=
ssion
> + * scheme as GPU_TILED_COMPRESSED. There is no known uncompressed variant
> + * of Apple Interchange.
> + *
> + * Unlinke the GPU layouts, tile size is not dependent on bit depth. RGB

[Severity: Low]
This isn't a bug, but is this a typo (Unlinke instead of Unlike) in the new=
ly
added UAPI documentation block?

> + * images and the chroma components of YUV images use 16x16 tiles. The
> + * luma component of YUV images uses 32x32 tiles. Compression tiles
> + * are once again 16x16 with 8 bytes of metadata per compression subtile.
> + *
> + * AGX has limited support for Apple Interchange. It cannot be used for =
Z/S
> + * buffers or array images, for example. It is intended for scanout buff=
er
> + * sharing only.
> + */
> +#define DRM_FORMAT_MOD_APPLE_INTERCHANGE fourcc_mod_code(APPLE, 3)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-apple-inte=
rchange-modifier-v1-1-5d6e27f9f308@gmail.com?part=3D1
