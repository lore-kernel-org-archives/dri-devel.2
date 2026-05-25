Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8B0CD5BC8
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 09:32:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A08F110E048;
	Mon, 25 May 2026 09:32:12 +0000 (UTC)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com
 [209.85.217.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1C0010E048
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 09:32:10 +0000 (UTC)
Received: by mail-vs1-f53.google.com with SMTP id
 ada2fe7eead31-6312970d9e3so7085816137.2
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 02:32:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779701530; x=1780306330;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6rWcIUH/SvbVRnVZe/oNltSq1THolH7A9MSmV5+ZKew=;
 b=OSM4g62vBlS1005yL3qdt6ArrQLZyQ2x7a807zJG26R4CDadGhvwLOqUjABHSOSkbY
 013wYXGmji0gIM9K7uXB6+iyYruvSFQvCxqV6mXx+2rgqZPIo6f8R1307P50PQKXtUa/
 X/fl7dfaVHicIXxFAWYIzSzarbUWA5VnuyNw7+ztrz/MW0AJF6q1UV0bYOjnEWpRGnTL
 /I7tal1b1W7gsHojST0lbh3x67LjCa9pSQcYkiikACBwN0A1Kb5r68Q86q6Uiyotdlix
 VxuPYc/jW17+kz7Ups1zMkCP+R5Yvh8VDq1V42HU9f4yJ/eVKirFYTdnB2DoyFjZsPN+
 v4sQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+wGLoV4DlJKM26b/0n6K3nJ+JOdjQEBQ576mlyoaBaFH3aCSHYiJCAvZfKeOFNbeaIHO4W0ESRWH0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxV6UFWtEH1uCsCBxkxNC3NIsuQba+LC6priRhvDBsXg7dMIiW2
 JFKyi8JuRY2wf6ED7YW/ITMg8cS/Q/+d/IdBCYE38fYPb6M3bmU98weav0v/HOGp
X-Gm-Gg: Acq92OHbgXbtCHynTN2qQeRuhvtBHgb15/Kt3Zp6vjubsrqSXByPaVKLVRbKUkdgSa3
 TQuUgHh3+l7RSMWV1uy65US9MGph4+SthUcZyJYoJbCJPD+aq0e+KuYt/iyD7OvoJvvQm7QuoGY
 pq/p698eq6iUcQ8yM3sKzX2z087LhJOHFfIctldXawSFql9CU9SOt5UgeANmN/h7MIIGLx5vidZ
 ec1LeGDePJCnqZyyhaHMBSRb8A238D2yGhCrA3pRLXIzqiwTDESQBKJjgtLP4NNveZ6sv6LM+tu
 k3pGDcD/Id2K912wiRMhkRMOeIE6niwIVsxSx9b5IaQ6BEm8BvB33iINF9ZmBrUPYvMA2sbntJ9
 ZVBbFoU+xqSQ1kiYpEce7bcWsf7D/o1NSKwMhcmAQVqzHBk/DxPvwvNceeBzDGkUNnc60GhJ56r
 FYWwSH0G0PIUE+d4BbkEazwJ3DzAkYWpw0k80zCfiCNuUq6mNuIV6+QQRsUPHh
X-Received: by 2002:a05:6102:4b1c:b0:650:94b2:b209 with SMTP id
 ada2fe7eead31-67c70e65631mr8156790137.4.1779701529658; 
 Mon, 25 May 2026 02:32:09 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com.
 [209.85.222.53]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-96173baf56bsm9334310241.13.2026.05.25.02.32.08
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2026 02:32:08 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id
 a1e0cc1a2514c-9568159ee07so6741921241.1
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 02:32:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ8KbFnmM9jmGWdmMQ0SC4wMK6BQL/Ml3dIAOawogDtzl1rs5skX4zLGpACdex14PxDO/oR41B6B3HU=@lists.freedesktop.org
X-Received: by 2002:a05:6102:3f4c:b0:5ff:f4ae:a154 with SMTP id
 ada2fe7eead31-67c70e6750amr7086176137.1.1779701528081; Mon, 25 May 2026
 02:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260522123019.211059-1-tzimmermann@suse.de>
 <20260522123019.211059-4-tzimmermann@suse.de>
In-Reply-To: <20260522123019.211059-4-tzimmermann@suse.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 25 May 2026 11:31:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXKF=fSZLqQiOuxDvygBDVSZKD+CQ3Rj+R4E_rYrz-WtA@mail.gmail.com>
X-Gm-Features: AVHnY4KfFcrlo4zm05PN319uvgzumHDBn_61S2KqpCQpRdYnyThN8ALdwa-6KzM
Message-ID: <CAMuHMdXKF=fSZLqQiOuxDvygBDVSZKD+CQ3Rj+R4E_rYrz-WtA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] fbdev: Wrap fbcon updates from vga-switcheroo in
 helper
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: deller@gmx.de, simona@ffwll.ch, airlied@gmail.com, lukas@wunner.de, 
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
 chleroy@kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
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

Hi Thomas,

On Fri, 22 May 2026 at 15:11, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Handle console remapping in fbcon in fb_switch_output(). Vga-switcheroo
> invokes this functionality before switching physical outputs to a new
> graphics device. Open-coding fbcon state in vga-switcheroo exposed fbdev
> implementation details.
>
> Vga-switcheroo is used for switching physical outputs among graphics
> hardware. This functionality is only supported by DRM drivers. A later
> update will further move fb_switch_output() into DRM's fbdev emulation;
> thus fully decoupling vga-switcheroo from fbdev.
>
> v2:
> - use '#if defined' (Helge)
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks for your patch, which is now commit 91458b3f2a84bc7b ("fbdev:
Wrap fbcon updates from vga-switcheroo in helper") in fbdev/for-next.

> --- a/drivers/gpu/vga/vga_switcheroo.c
> +++ b/drivers/gpu/vga/vga_switcheroo.c
> @@ -31,11 +31,9 @@
>  #define pr_fmt(fmt) "vga_switcheroo: " fmt
>
>  #include <linux/apple-gmux.h>
> -#include <linux/console.h>
>  #include <linux/debugfs.h>
>  #include <linux/fb.h>
>  #include <linux/fs.h>
> -#include <linux/fbcon.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/pm_domain.h>
> @@ -735,8 +733,10 @@ static int vga_switchto_stage2(struct vga_switcheroo_client *new_client)
>         if (!active->driver_power_control)
>                 set_audio_state(active->id, VGA_SWITCHEROO_OFF);
>
> +#if defined(CONFIG_FB)
>         if (new_client->fb_info)
> -               fbcon_remap_all(new_client->fb_info);
> +               fb_switch_outputs(new_client->fb_info);
> +#endif

What if CONFIG_FB is modular?
CONFIG_VGA_SWITCHEROO is bool.

>
>         mutex_lock(&vgasr_priv.mux_hw_lock);
>         ret = vgasr_priv.handler->switchto(new_client->id);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
