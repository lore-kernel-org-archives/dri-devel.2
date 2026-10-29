Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485BC606A321
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 08:10:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A907911207C;
	Thu, 29 Oct 2026 08:10:06 +0000 (UTC)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com
 [209.85.221.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9528311207C
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:10:05 +0000 (UTC)
Received: by mail-vk1-f173.google.com with SMTP id
 71dfb90a1353d-5eac319a6c2so1974570e0c.0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 01:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793261404; x=1793866204;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=j1N3C4wGR9ui6A1aTKEotaU/WbKyfzJohGbZeH+69Ss=;
 b=gnO17u9iIlsJBimy2c9aaYY70m4wCTOw38oYR8Evpr454lDjYnGpo9qGO6kNKKaxO0
 uUXmKNCK9HzL6Qz1Z0ZTk+PXV/B0A8TqdO1ezDhk11nURueiqLui67kpCMcurBAARhu4
 U+8mHlHOGNCAYI061mE0YpA3n0MYEXCqkPrCwqa5ABxj7vms0XQC33x9p4DOs+OSgK5z
 blZ3wVJvKpMrTEzReJPoVa2Lb8H9aRSgfr1M6pPaUxDYHUVSAtdS3lC8NxTgFvTvdGHv
 m8NnrQp1uVAxtBTnVKr0/XtsK9KExgv8g7HkVc+02mv9BLGBZr6iPWRPWzVh2Q1YLWPa
 qXyA==
X-Forwarded-Encrypted: i=1;
 AKwUvByoUnfw5K3CPolWVUGshnB9BJj3I3r1a3kk/mV9NAeWGDAxt2FZ7KBOKdmeYY3Jm9/6GZi0MtgECy4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ5VpzjQ3Jp2ADPSJoVam17dp+3iX5kcu2yu7BNcux5dqwLMyxj
 KwvlzPDVvefcpx2Jwa5e9mB1Dhu8n5LhZmbz9kT1A61JG4BDuXc1l0MvMWJ0pJGa
X-Gm-Gg: AYBFou0lqiW/61wnqFVtijCpLJTyqIrNk+vTgtzzBCKwvp5FxT7+tJzFgs2uknnb7Jt
 +JAVebExvcDTle59Ade44P9F7QmZa2upvU7j4GAdbnII/lJ+s/K01+Rzz1qEt1tnG7hiX5Q77b6
 gZC0n5bqoAyY37XeOI8IgNN7cOYGUCG10xWMD1SnKeWTBgb2cCWwz95ZXpJHR+3BoDOAPFR3I+U
 DgsbU5N+u5PimbK2AT8fu5XywyyQYWiexzEIMvCrNnV0rZ6CirSfBi/7dzViDxEqk9LdeTIyfuj
 yflQYC5D1dESREMfZZeIAQFZYIk7R0jenGmoAMexPQ2SeAtJ/ZRHf8+hV417ban2bHPttDbAAIL
 37ZlUERkwAL4ALMmZaSXLQNw4xhQ1i2yK1873sV9R1OQr2iUoN6b/fU0pf3GfYkxahcrqb5q22x
 OkZyrwDP6GWHyYeavJ3E32vMSDXgTd2+qygGaxBBRB8ZnEWa6Iilg973qhoM813Ha5ErHcoNPc+
 6O3EFDh/RrKYXMH6J0Xrh7t2lePe5TrIhrPNStOAFTjocEwzjqh3LntwheTKOSV/shTE0Ost9ZZ
 e4dk+hFTWZ+RH5fc598G+179RWuOyh03xhPP4rO7DruigFUdLa2Dea31PR8KQylT13TyQZoH5ap
 nBcXV8kd7DSrU
X-Received: by 2002:a05:6122:1804:b0:5ea:c6c8:7985 with SMTP id
 71dfb90a1353d-5ec4caa70c3mr2277759e0c.3.1793261404241; 
 Thu, 29 Oct 2026 01:10:04 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com.
 [209.85.222.52]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5ec4f5cebbbsm4719361e0c.0.2026.10.29.01.10.02
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 01:10:02 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id
 a1e0cc1a2514c-990fbae94f5so1769924241.3
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 01:10:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBzNJxw2zyv2K35gwXZAjrimMYolKhVb+L4CeZGCpPFRrMpR4BOGp6INYuuA1B01I3qKNlnthPWw+ho=@lists.freedesktop.org
X-Received: by 2002:a05:6102:3eca:b0:7c3:f07c:f49c with SMTP id
 ada2fe7eead31-7d03a503c53mr2112556137.11.1793261402712; Thu, 29 Oct 2026
 01:10:02 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027160914.3787276-1-bestswngs@gmail.com>
In-Reply-To: <20261027160914.3787276-1-bestswngs@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 29 Oct 2026 09:09:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUBAFGH-YoF5iTSXuX=tFjXXQhXYyxnT=-XJ6qEGym7PQ@mail.gmail.com>
X-Gm-Features: AclHuK98HJBR5jB_yT7cph-_YLUIP8WBWM3UvHpqvO4YtLNQFtBwwRQ_iZsfTT4
Message-ID: <CAMuHMdUBAFGH-YoF5iTSXuX=tFjXXQhXYyxnT=-XJ6qEGym7PQ@mail.gmail.com>
Subject: Re: [PATCH v3] fbdev: vfb: Validate framebuffer geometry and memory
 size
To: Weiming Shi <bestswngs@gmail.com>
Cc: Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 co+b0df61d49532b2ee@bugs.sh, Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Weiming,

On Tue, 27 Oct 2026 at 17:16, Weiming Shi <bestswngs@gmail.com> wrote:
> FBIOPUT_VSCREENINFO can supply a virtual width large enough to
> overflow get_line_length()'s int multiplication and bypass the
> video-memory limit, allowing fbcon to write past the framebuffer. The
> offset additions can also wrap, while an excessive videomemorysize
> module parameter can be truncated when PAGE_ALIGN() is assigned to
> unsigned int.
>
> Cap framebuffer geometry at 8192 x 8192 and video memory at 512 MiB,
> keeping the stride, framebuffer-size, and generic fbdev drawing
> calculations within their destination types.
>
> KASAN reports:
>
>   BUG: KASAN: vmalloc-out-of-bounds in sys_fillrect
>     drivers/video/fbdev/core/sysfillrect.c:24
>   Write of size 8 at addr ffa0000001671000 by task poc/198
>   sys_fillrect
>     drivers/video/fbdev/core/sysfillrect.c:24
>   bit_clear_margins
>     drivers/video/fbdev/core/bitblit.c:247
>   fbcon_clear_margins.constprop.0
>     drivers/video/fbdev/core/fbcon.c:1410
>   fbcon_switch
>     drivers/video/fbdev/core/fbcon.c:2261
>   redraw_screen
>     drivers/tty/vt/vt.c:994
>   fbcon_modechanged
>     drivers/video/fbdev/core/fbcon.c:2693
>   fbcon_update_vcs
>     drivers/video/fbdev/core/fbcon.c:2732
>
> Cc: stable@vger.kernel.org
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: <co+b0df61d49532b2ee@bugs.sh>
> Suggested-by: Helge Deller <deller@gmx.de>
> Assisted-by: LLM
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

Thanks for your patch, which is now commit f93dd31db3e23e61 ("fbdev:
vfb: Validate framebuffer geometry and memory size") in fbdev/for-next.

> --- a/drivers/video/fbdev/vfb.c
> +++ b/drivers/video/fbdev/vfb.c
> @@ -31,6 +31,9 @@
>       */
>
>  #define VIDEOMEMSIZE   (1*1024*1024)   /* 1 MB */
> +#define MAX_VIDEOMEMSIZE       (512UL * 1024 * 1024)

Is there any point in having a larger limit than 256 MiB
(i.e. MAX_XRES * MAX_YRES * 32 bpp)?

> +#define MAX_XRES               8192U
> +#define MAX_YRES               8192U
>
>  static void *videomemory;
>  static u_long videomemorysize = VIDEOMEMSIZE;
> @@ -142,6 +145,10 @@ static int vfb_check_var(struct fb_var_screeninfo *var,
>                 var->xres = 1;
>         if (!var->yres)
>                 var->yres = 1;
> +       var->xres = min(var->xres, MAX_XRES);
> +       var->yres = min(var->yres, MAX_YRES);
> +       var->xres_virtual = min(var->xres_virtual, MAX_XRES);
> +       var->yres_virtual = min(var->yres_virtual, MAX_YRES);

This violates fbdev API rounding rules:
  1. If a value doesn't fit, it must be rounded up by the driver,
  2. If a value is too large, -EINVAL must be returned.

>         if (var->xres > var->xres_virtual)
>                 var->xres_virtual = var->xres;
>         if (var->yres > var->yres_virtual)
> @@ -159,6 +166,9 @@ static int vfb_check_var(struct fb_var_screeninfo *var,
>         else
>                 return -EINVAL;
>
> +       var->xoffset = min(var->xoffset, MAX_XRES - var->xres);
> +       var->yoffset = min(var->yoffset, MAX_YRES - var->yres);

Likewise.

> +
>         if (var->xres_virtual < var->xoffset + var->xres)
>                 var->xres_virtual = var->xoffset + var->xres;
>         if (var->yres_virtual < var->yoffset + var->yres)
> @@ -434,9 +444,12 @@ static int __init vfb_setup(char *options)
>  static int vfb_probe(struct platform_device *dev)
>  {
>         struct fb_info *info;
> -       unsigned int size = PAGE_ALIGN(videomemorysize);
> +       unsigned int size;
>         int retval = -ENOMEM;
>
> +       videomemorysize = min(videomemorysize, MAX_VIDEOMEMSIZE);
> +       size = PAGE_ALIGN(videomemorysize);

Perhaps return -EINVAL, too?

> +
>         /*
>          * For real video cards we use ioremap.
>          */

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
