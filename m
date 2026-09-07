Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FF8C79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 08:39:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46A948928D;
	Mon,  7 Sep 2026 08:39:05 +0000 (UTC)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com
 [209.85.221.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF9A28928D
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 08:39:03 +0000 (UTC)
Received: by mail-vk1-f171.google.com with SMTP id
 71dfb90a1353d-5c6559620e3so1367538e0c.1
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 01:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788770343; x=1789375143;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2br8BvQg9DJFd3H4ITYFtxQrEUyvo1i3TJw/l6L1bw4=;
 b=jtjgTX9G1z0Ep6WvpWzs26leMzVi+XFx548a29AXj57H5745cZsjBOC6kXfl5rNGgU
 KTQsRoRkEs1vkz1CNkP6i32rMWwu+LyX1vAf/AgvOGYZSX0Irr3ZrlYnG2TUnfcrwNNp
 90cRaDAlE3PgC9pb30E5ooYblQ+pwsp63u6Ti9GqvbMtiMKLW7D27A/QMFAMt8U4QlYF
 vDVrgGbfGYHnoIJcS2eFupoEgQFMPBn71HjO3gybL8wvH72s5jf0yx/odjgVi4E/+6VY
 cpGuQ8gigHD8tGEbKz22l3jJr0jMFaWr2GBTeadBtl28LK36qtRnArvBcPJvuQ/MYuut
 YYVg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy6Bp8mH0rWTuS458KxgBFWORowcSUXyUT64XAVYJb94RZJD94huW6eFPL1sO4RO0hpVywWpF/jkmI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kKhqOYjBRzdPCf/hsJeL/v9f90DHDZ/arPU6la12hklyctvgDi
 IJ6y0zmJuLce/nb9qDeJeAWnHjlJ/yoMZ5wYx1BpTmc+p3fkmLBeodVnLTcSucS5
X-Gm-Gg: AYBFou3cC103UKh/Je/q4AOkURORgJXmBuIWqDdikHT3GZbZV/Up+0yXlLovVeZ7XBO
 +ZS3KfQ3RoI5mFUMqleV6OT5ojrsyn8gXzsxUzS9l0dkO15O9Kh7zchkxgIqhaLsLps/sn2HVQl
 B9Fq55GtIf0p3MwpvkPB7qf7MKaezked6CDybnivmefAEiNKSqTxExJREm/sJ1c4e5qPIAWv4L4
 R7dQ/x6u/GXUrgKHvLzWrqF08iEdxp23KnFtohFDhxMTyA3GjHxlE/rPr/Mf55QLRnXnO4zE090
 un+o8YxcYgNc/aJNAZ3kAcYyjshGhc6ZjkhcjDXK3X2W6D4oRbbTYvsJ15T/2tfr3mAzXIaRpJx
 6ydHwVvM1QPKwJ8AHtGBBklqUYxP5fh7kGRVA1V4mhy00Gmxfj9APtclJnRRIzvImlbQkGfrQfK
 Ua4KFTIFWFlw483AqOc67vIbgrPssZe8qMjdQZLJezbMIWaqzJkYuNMo+153zxw18S1KTSJ55vS
 O/QUW2lviYgcQ4fBv3/KQCmwX+LN242pAiX
X-Received: by 2002:a05:6122:2909:b0:5bf:a181:d46d with SMTP id
 71dfb90a1353d-5c7ed4201ddmr8953964e0c.3.1788770342439; 
 Mon, 07 Sep 2026 01:39:02 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com.
 [209.85.217.43]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c7ec35d85fsm7503243e0c.12.2026.09.07.01.39.00
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 01:39:00 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id
 ada2fe7eead31-782c22fbb1cso901021137.1
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 01:39:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBySoPKKeKFhkg1zte7Un6Eg82KtO+L5poF4e0I55Xe1uxZ5V7GZp4s9BKd/zRLr9220euIGdTgK4ik=@lists.freedesktop.org
X-Received: by 2002:a05:6102:6d6:b0:737:783d:1916 with SMTP id
 ada2fe7eead31-78a4aa56803mr7111444137.11.1788770340448; Mon, 07 Sep 2026
 01:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260827093948.2825531-1-lilinmao@kylinos.cn>
 <e4a2ba2e-c533-04d8-0795-e3d43caf47b9@gmail.com>
In-Reply-To: <e4a2ba2e-c533-04d8-0795-e3d43caf47b9@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 7 Sep 2026 10:38:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVOc-_hgWvu84EW7tyQx6WzPtabnBUJ1T0uoxa1QZA94Q@mail.gmail.com>
X-Gm-Features: AcwNN1Wp_1PImUP-cNgneasiw6HMISUs78c56UfOAI5vNGTS0l_4VrpE9irLY4c
Message-ID: <CAMuHMdVOc-_hgWvu84EW7tyQx6WzPtabnBUJ1T0uoxa1QZA94Q@mail.gmail.com>
Subject: Re: [PATCH] fbdev: atafb: Restrict SuperBlitter to supported formats
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: Linmao Li <lilinmao@kylinos.cn>, deller@gmx.de, linux-fbdev@vger.kernel.org,
 miro.kropacek@gmail.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi Michael,

CC linux-m68k

On Sun, 6 Sept 2026 at 03:49, Michael Schmitz <schmitzmic@gmail.com> wrote:
> Am 27.08.2026 um 21:39 schrieb Linmao Li:
> > The SuperBlitter operations derive an integer byte count per pixel.  The
> > accelerated fill path handles only one-, two- and four-byte pixels.
> > However, the operations are currently installed for every external
> > framebuffer in SuperVidel RAM, including planar 1/2/4/8-bpp and 24-bpp
> > truecolor modes accepted by the external video parser.
> >
> > For 1/2/4-bpp modes, the byte count becomes zero, so accelerated copies do
> > nothing and fills fall through to 32-bit stores.  Planar 8-bpp uses an
> > incompatible memory layout.  For 24-bpp modes, fills also use 32-bit stores
> > despite advancing addresses by three bytes per pixel.  These cases can
> > corrupt the framebuffer beyond the requested rectangle.
>
> I believe 24 bpp mode can be rescued using something like this (entirely
> untested):
>
> --- a/drivers/video/fbdev/atafb.c
> +++ b/drivers/video/fbdev/atafb.c
> @@ -2463,6 +2463,11 @@ static void svblit_fillrect(struct fb_info *info,
>          case 2:
>                  memset16((u16 *)line, pix, rect->width);
>                  break;
> +       case 3:
> +               memset(line, pix, ((rect->width * bytespp) % 4));
> +               line += ((rect->width * bytespp) % 4);
> +               memset32((u32 *)line, pix, (rect->width * bytespp) / 4);

This uses unaligned writes for the largest part.
You can avoid that by doing the memset32() first.

> +               break;
>          default:
>                  memset32((u32 *)line, pix, rect->width);
>                  break;
>
> Can't test this on hardware, and would need Miro to confirm it works as
> intended.
>
> >
> > Enable the SuperBlitter operations only for the layouts they implement:
> > 8-bpp packed pixels and 16/32-bpp truecolor.  Keep the existing software
> > operations for all other external formats.
> >
> > Fixes: d463633d63e6 ("fbdev: atafb: Add support for SuperVidel's SuperBlitter")
> > Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> > ---
> >  drivers/video/fbdev/atafb.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
> > index 5bca34c45cef3..c3011b61a94b9 100644
> > --- a/drivers/video/fbdev/atafb.c
> > +++ b/drivers/video/fbdev/atafb.c
> > @@ -3360,7 +3360,11 @@ static int __init atafb_probe(struct platform_device *pdev)
> >               memset (screen_base, 0, external_len);
> >
> >               /* framebuffer in SV RAM: enable the SuperBlitter */
> > -             if (external_addr >= 0xa0000000) {
> > +             if (external_addr >= 0xa0000000 &&
> > +                 ((external_pmode == FB_TYPE_PACKED_PIXELS &&
> > +                   external_depth == 8) ||
> > +                  (external_pmode == -1 &&
> > +                   (external_depth == 16 || external_depth == 32)))) {
> >                       svblit_regs = ioremap(SVBLIT_REGS_PHYS, 0x100);
> >                       if (svblit_regs) {
> >                               svblit_fw = svblit_rd(SVBLIT_VERSION) & 0x1ff;
> >
>
> Otherwise, LGTM.
>
> @Geert: can you remember if pixel format or bit depth of an external
> framebuffer can be changed at runtime using fbset??

I am no Atari expert, but IIRC all external framebuffers rely on
being fully set-up before Linux boots?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
