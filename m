Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBC0C55174
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 14:49:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 762F810E061;
	Sat,  8 Aug 2026 14:49:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DyFtR9oP";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5C5F10E061
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 14:49:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9CF7A43674;
 Sat,  8 Aug 2026 14:49:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558F21F000E9;
 Sat,  8 Aug 2026 14:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786200578;
 bh=0ZStcWDxWQuBCzN1ruf/UDx0zlbk7o6usuSOu1ep2/w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DyFtR9oPuKWsgKqYtDqhnpT3B+eLQEUJf04EFyhlqecxU7Jda7yRgCtHeEFqf9xSD
 NwHKsEmAkqYCuXOzesZe/CTr7bpk5f9tASP6uLmb00q9ejGuxNf+YEVj2Cn1SwHcwD
 xGQuu7qGIpMY39k0YBn0KEsuS1sdnalgkmOHB+M7D9RK3ceRSpEG41dI4SPP1MwahV
 HoSvH9BFzaZ5UbR846PmqRkQfH053P2zJa5djtipt8fbvSk4rlyeiOw0sBrOwi1sUI
 h74Rr42Te3KZC4P1fTVe9lPZ4NfEjaQGa/402k9NoQ6Hneb+f8ZIeQ2JRvhCEZqAum
 awya1hJTdmFuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fbdev: clps711x-fb: Remove unreachable
 unregister_framebuffer() call
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260808144114.77505-1-kmehltretter@gmail.com>
References: <20260808144114.77505-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 14:49:37 +0000
Message-Id: <20260808144938.558F21F000E9@smtp.kernel.org>
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
- [High] Mixing manual framebuffer_release() with devm_lcd_device_register(=
) creates a Use-After-Free vulnerability on module remove and probe error p=
aths.
--

--- Patch [1]: [PATCH] fbdev: clps711x-fb: Remove unreachable unregister_fr=
amebuffer() call ---
commit e41c02db93213803fd7424c13289c71da7816b02
Author: Karl Mehltretter <kmehltretter@gmail.com>

    fbdev: clps711x-fb: Remove unreachable unregister_framebuffer() call

This commit removes an unreachable unregister_framebuffer() call in
clps711x_fb_probe(). The code previously jumped to an unwind label on
failure or returned immediately on success.

> diff --git a/drivers/video/fbdev/clps711x-fb.c b/drivers/video/fbdev/clps=
711x-fb.c
> index 7a7db7100499e..6789773b22fbe 100644
> --- a/drivers/video/fbdev/clps711x-fb.c
> +++ b/drivers/video/fbdev/clps711x-fb.c
> @@ -329,8 +329,6 @@ static int clps711x_fb_probe(struct platform_device *=
pdev)
> =20
>  	return 0;
> =20
> -	unregister_framebuffer(info);
> -
>  out_fb_dealloc_cmap:
>  	regmap_update_bits(cfb->syscon, SYSCON_OFFSET, SYSCON1_LCDEN, 0);
>  	fb_dealloc_cmap(&info->cmap);

[Severity: High]
This is a pre-existing issue, but does mixing manual framebuffer_release()
with devm_lcd_device_register() create a use-after-free vulnerability on
probe error paths and module removal?

Because the LCD device is registered using devm_lcd_device_register(), its
unregistration is deferred to the devres cleanup phase. This cleanup execut=
es
after clps711x_fb_probe() returns an error, or after clps711x_fb_remove()
finishes.

However, the driver manually frees the info structure and its private data =
cfb
via framebuffer_release() just below this unwind label:

drivers/video/fbdev/clps711x-fb.c:clps711x_fb_probe() {
    ...
out_fb_release:
        framebuffer_release(info);

        return ret;
}

During the window between framebuffer_release() and devres cleanup, the LCD
device remains fully visible in sysfs.

Could a concurrent sysfs read of lcd_power trigger a use-after-free by
accessing the already freed cfb pointer in clps711x_lcd_get_power()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808144114.7750=
5-1-kmehltretter@gmail.com?part=3D1
