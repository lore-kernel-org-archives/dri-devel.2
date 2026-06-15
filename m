Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA740CD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 14:08:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D38D10E447;
	Mon, 15 Jun 2026 14:08:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NXIArCpD";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C39110E447
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 14:08:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8E50A600AB;
 Mon, 15 Jun 2026 14:08:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7461F000E9;
 Mon, 15 Jun 2026 14:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781532512;
 bh=bVOsiOixoyCbDfwV2bqqpcMsT7K6jzq3/3DZrJCSRm0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NXIArCpDC//moPgngxLYUraiZ5D/tMmfBOB4wfDxphmvwGv1mqePg7saH7Wh0eZFJ
 NEd+Ph+I4I9+J+e5NrEDUaDiWc38kldPfB3RJp/FOBnHljfrNaqqQ6/ok79Sojt1Dx
 edsUuJ3u3yJjGDBRFA8k2OlaT+hidfk14+RExiB46CDWOtsKcwZd8WQt+ihtntOGGm
 xhmR5V49fn1LTcb7CIRl5324VGp7RhSl8dWguytJ/3CPx3arp8xISSnbL6kmizJfox
 yCt3QZjKQ4YCOApbzB04rSuPRNBNBQpewAIndXXQRc9tzDjvtw4ROfJts79frrlzHP
 zFuOKDQWjDgpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH resend] drm: uapi: Add macro for chipset specific event
 ID region
To: "Bence Csokas" <bence.csokas@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260615135238.564424-1-bence.csokas@arm.com>
References: <20260615135238.564424-1-bence.csokas@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 14:08:31 +0000
Message-Id: <20260615140832.1C7461F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Missing parameter documentation for `_v` in the kernel-doc of `DRM_=
EVENT_VENDOR_SPECIFIC` macro.
- [Low] The chipset-specific event DRM_NOUVEAU_EVENT_NVIF was not converted=
 to use the new DRM_EVENT_VENDOR_SPECIFIC macro.
--

commit cc8100201e0dfb32c2f9528073691e1aff91810c
Author: Bence Csokas <bence.csokas@arm.com>

drm: uapi: Add macro for chipset specific event ID region

This commit introduces the DRM_EVENT_VENDOR_SPECIFIC macro to UAPI. It also
updates several drivers to use this macro instead of hardcoded event IDs.

>     uapi/drm/drm.h states:
>    =20
>         Event types 0 - 0x7fffffff are generic DRM events, 0x80000000 and
>         up are chipset specific.
>    =20
>     However, this distinction was not put in the code. To elevate the con=
tract
>     between the generic DRM framework and the driver from the comment to =
code,
>     put this in a macro for clarity and convenience.

[Severity: Low]
This isn't a bug, but it looks like include/uapi/drm/nouveau_drm.h was
missed during this refactoring. Should DRM_NOUVEAU_EVENT_NVIF also be
updated to use the new macro?

include/uapi/drm/nouveau_drm.h:
#define DRM_NOUVEAU_EVENT_NVIF                                       0x8000=
0000

> diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
> index 27cc159c1d275..aa745e643ef48 100644
> --- a/include/uapi/drm/drm.h
> +++ b/include/uapi/drm/drm.h
> @@ -1419,6 +1419,14 @@ struct drm_event {
>   * The event payload is a struct drm_event_crtc_sequence.
>   */
>  #define DRM_EVENT_CRTC_SEQUENCE	0x03
> +/**
> + * DRM_EVENT_VENDOR_SPECIFIC - vendor/chipset specific event
> + *
> + * These event IDs are reserved for chipset and driver specific events.
> + *
> + * Refer to the chipset driver's header for details and payload struct.
> + */
> +#define DRM_EVENT_VENDOR_SPECIFIC(_v) ((_v) | 0x80000000)

[Severity: Low]
This isn't a bug, but should the _v parameter be documented here? Missing
the @_v: description in the kernel-doc block might trigger a warning
during documentation generation.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615135238.5644=
24-1-bence.csokas@arm.com?part=3D1
