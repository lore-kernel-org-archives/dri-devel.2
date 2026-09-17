Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093FFC982CF
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 10:53:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 383E610ED77;
	Thu, 17 Sep 2026 10:53:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YT0DGLGJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6AC110ED77
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 10:53:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EBEE5600D4;
 Thu, 17 Sep 2026 10:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84BFF1F00898;
 Thu, 17 Sep 2026 10:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789642403;
 bh=YWWV5jqTsc/1mskUMHkAlj7gAcCn3N6PQ8ErHBQnJnE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YT0DGLGJadex/jeTuT6UtBq40I3Ket5QSsamgGkVxn8Pgeo+hngVLaRI+b0x26XGA
 uRxAy5hgeABxhv9b1wGN3BJHw9RUHE7/j4FKxQYJGxXHYvHKz4PiqXF48pbstzlQ40
 +CnZY/Y4s6w6PiDIcRxE7WchSEXoFotQFoyD77re8/fmbQG/dRNCz+vFCNWgUKj/wz
 5045WAsIHHfTps8EEd9lw3oZzm+mc9iECX0LnYjo8IGeU1rTCB2LlsH5N7UabVYQuR
 4OeH8nugixKrkK8vOHlll1W5LQ4+IHjAW5tbWCA4WiN0U4J7EAAsqz5q9ibjU/kklw
 6W822OSj/quSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND] drm/fourcc: Add Apple Interchange layout format
 modifier
To: "James Calligeros" <jcalligeros99@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260917-apple-interchange-modifier-v1-1-875294689c48@gmail.com>
References: <20260917-apple-interchange-modifier-v1-1-875294689c48@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 10:53:23 +0000
Message-Id: <20260917105323.84BFF1F00898@smtp.kernel.org>
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
- [Low] drm/fourcc: typo 'Unlinke' instead of 'Unlike' in UAPI comment
--

commit 5f845c0015bd5ad4e49e23a58d6607e8d2cac4d3
Author: James Calligeros <jcalligeros99@gmail.com>

drm/fourcc: Add Apple Interchange layout format modifier

This commit adds a format modifier for the Apple Interchange layout to allow
buffer exchange between Apple hardware blocks.

> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
[ ... ]
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
There is a typo in the documentation comment for
DRM_FORMAT_MOD_APPLE_INTERCHANGE here. Unlinke should be Unlike.

> + * images and the chroma components of YUV images use 16x16 tiles. The
> + * luma component of YUV images uses 32x32 tiles. Compression tiles
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-apple-inte=
rchange-modifier-v1-1-875294689c48@gmail.com?part=3D1
