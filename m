Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AC4C5DF7D
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:32:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1061410E0AE;
	Tue, 18 Aug 2026 11:32:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OUjMg+XC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31C3910E0AE
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 11:32:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 10FC4601DE;
 Tue, 18 Aug 2026 11:32:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BEE1F00A3A;
 Tue, 18 Aug 2026 11:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787052758;
 bh=zQfVQHqfKk/sEsNHsGIrowezH9lDw3CxWEt0xhODO6s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OUjMg+XCsPCZwOlSZQk9/LwPdLFD2E/MbEwCdIGRbXWmBnZk+9mmuWxLEYIoYoQQ/
 Y89VemZ94FMmeaV8QHqsTZ7xzLC3aI/SooSualz742OFVj9yBMTNfAV7k0y3WpO02p
 QNUnzHST4SbQySz7ufnENtiEHVE3BNu5uovwh8EbvMGhAW5NeAaX5KWaUG/4BQgsfG
 AcQdpP1P8QaqbPnnUBiRPdNSDURIJWrJCXWaVG25JV0iV4MYDWQomY1BTNxxJh9gmG
 7J8R0iCmrs/8RD3/3XBFUuUDFtmXNh8/c3VkFQtF0H3HHpL1/sdcp0enReSIxKzZeo
 WIgzRsbx0Ybeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] video: fbdev: via: refactor strcpy and viafb_name
To: "Ajith P V" <ajithpv.linux@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260818111722.471340-1-ajithpv.linux@gmail.com>
References: <20260818111722.471340-1-ajithpv.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 11:32:37 +0000
Message-Id: <20260818113238.90BEE1F00A3A@smtp.kernel.org>
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
- [Critical] Struct memory copy corrupts `bl_curve_mutex` state inside the =
allocated secondary framebuffer structure.
--

--- Patch [1]: [PATCH v4] video: fbdev: via: refactor strcpy and viafb_name=
 ---
commit 89ff079954842cbfcf9a3daa9bead9f4e5a2902d
Author: Ajith P V <ajithpv.linux@gmail.com>

video: fbdev: via: refactor strcpy and viafb_name

Eliminate the single-use file-scope variable viafb_name and pass the
"Via" string literal directly to strcpy().

> diff --git a/drivers/video/fbdev/via/viafbdev.c b/drivers/video/fbdev/via=
/viafbdev.c
> index 80f95dac32c8c..dd9374e8ad098 100644
> --- a/drivers/video/fbdev/via/viafbdev.c
> +++ b/drivers/video/fbdev/via/viafbdev.c
> @@ -16,7 +16,6 @@
>  #define _MASTER_FILE
>  #include "global.h"
> =20
> -static char *viafb_name =3D "Via";
>  static u32 pseudo_pal[17];
> =20
>  /* video mode */

[ ... ]

[Severity: Critical]
This is a pre-existing issue, but does this struct memory copy cause a
regression by corrupting the bl_curve_mutex state inside the allocated
secondary framebuffer structure?

drivers/video/fbdev/via/viafbdev.c:via_fb_pci_probe() {
    ...
		viaparinfo->iga_path =3D IGA1;
		viaparinfo1->iga_path =3D IGA2;
		memcpy(viafbinfo1, viafbinfo, sizeof(struct fb_info));
		viafbinfo1->par =3D viaparinfo1;
    ...
}

During dual framebuffer initialization, viafbinfo1 is allocated using
framebuffer_alloc(), which properly initializes bl_curve_mutex.

This memcpy() performs a bitwise copy of a struct fb_info over another,
which blindly overwrites the initialized mutex with the bitwise state of
viafbinfo's mutex.

Because a mutex contains a self-referencing list head for its wait list,
would viafbinfo1's wait list pointers now incorrectly point to viafbinfo's
wait list?

When backlight support is enabled, an unprivileged user space program
can trigger concurrent reads or writes to /sys/class/graphics/fb1/bl_curve,
which attempts to take viafbinfo1->bl_curve_mutex.

Could modifying this corrupted wait list cause severe list corruption across
both framebuffers or a kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818111722.4713=
40-1-ajithpv.linux@gmail.com?part=3D1
