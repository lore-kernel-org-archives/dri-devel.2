Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01935C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 15:37:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CCE010E974;
	Mon, 29 Jun 2026 15:37:43 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E22D610E9A2
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 15:37:42 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-697cee2eb6dso3307522a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782747461; x=1783352261;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3PSkrSvBcOj2Vfr1tOG9HdESUGrp+uU5X3MHl1xNqsM=;
 b=KjzN/I8jFiH+BPd3HeJJ+CN6r6FWke+8CSer8R2Mz8XqRXIrTqdLk1w0e0PViwaTEW
 ZQ7yYZl76bEIN+ltcBnrM5YX4DeUglNpaiHEemZW80UBUsjKCnq20tFHJWh7Rq/66dLt
 ihMWa44ByS6TWB4Z8av8QWllczfORq/0PdD7OHYsbKvJImaJou2Is7rIb8W+p8s18awz
 4lPVf0Hii0kn4ZsTQlGL7qJnld2VjPQNYgfRfzJRfsSjca8Q2Zr53FyBSYdJF7NPvOx4
 qjW9vgaxU/QOeLOTLgGrDTLMQDziGECnZjPhcu36VpOCL22GqsCsNTp7nDvfo63t6YKC
 1ckw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpffy2UXKYpM4g4Q69gcx1V26j2P4rUrKuU/e2H9NCTKEgEajdnk5vcV8avgQoKM35nHeI04ubx570=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw8UNI73MzcVHQw3cVC7ZCLWtFUMZS7ZnQZgzNHXrzNys3/vxEL
 +XVy8O9/ed/FciaAhAB6WUvb/VIIJhtVMlKj9NOSHhkh3NyGaVKzrXrySN/AyNVx34M=
X-Gm-Gg: AfdE7ck4s7XxrzqRl9QKE//Sh+pY8R7jKyn9lDj1dgbw4KGzx6fqIgLYaRhmxRpxGxp
 aJdiZwlBD/nvtZ0KkpAKXMo452PWtyNN/Kuw5FjJJAGxxi4gKSDN2CQTpr7W8PGg2UvFy44ZZKl
 X5neeCfxqSMcZBWQIdBjgQWDmcxgLRjJOrfyDdfWOiLijt6R4MmuEXhuRF0tJYYJh4eG5SzGTw2
 bbQ3/2pQSIKaznqzJz2nQVbUxe64RYhaMWppn/2hLZwtxqHd2bupcZg0lwmgrrtBJyvdy8u//Hq
 mnQJtTIKNUdM6EM9h45npdCyJrGXJdZnfOF1rNZ1p3M1Noy+YcfgxpgQSUTpi9KobRWj8tsyL10
 Y1fNtFrocPHWnu1HAIV+9muw7AzmrsKfjsVO7tnjb8BDvAYV5EU1KsxBIPmQ+z96x+oozsUmh/n
 tP5qxwewTJapwXQxaD6ZevDftrZqWVESHL8cSQL0fhcWe4M8fBiw==
X-Received: by 2002:a05:6402:2744:b0:698:6746:23d3 with SMTP id
 4fb4d7f45d1cf-69867462551mr1925152a12.20.1782747461024; 
 Mon, 29 Jun 2026 08:37:41 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com.
 [209.85.221.45]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-697f3aece6dsm7241680a12.12.2026.06.29.08.37.40
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2026 08:37:40 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-46ee68c3b7aso2973688f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:37:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Rp73qQjOC5Cr+dyV7XwXiCAsG8/Bo4IrgfbE5lsaYakjTnwAj66bow7CY0pnPmCZ1m9Hj8nqy28brU=@lists.freedesktop.org
X-Received: by 2002:a17:907:3c8b:b0:c12:f84:85d4 with SMTP id
 a640c23a62f3a-c120f8487bamr796791266b.24.1782746977928; Mon, 29 Jun 2026
 08:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260629135917.1308621-1-arnd@kernel.org>
In-Reply-To: <20260629135917.1308621-1-arnd@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Jun 2026 17:29:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXhsM4JzArRuB=A46N-Ogbn2Fans+PVJVA-hEytFq=DeQ@mail.gmail.com>
X-Gm-Features: AVVi8CfSSg4DcoB7CGCYddSfqoWpUaOwYUjpkorP-3LR7U8E7vJ9ucbePhiZLD8
Message-ID: <CAMuHMdXhsM4JzArRuB=A46N-Ogbn2Fans+PVJVA-hEytFq=DeQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC] gpiolib: introduce gpio_name() helper
To: Arnd Bergmann <arnd@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, 
 Marcel Holtmann <marcel@holtmann.org>, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Andy Shevchenko <andy@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Ulf Hansson <ulfh@kernel.org>, linux-bluetooth@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-i2c@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-pm@vger.kernel.org, linux-usb@vger.kernel.org
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

Hi Arnd,

On Mon, 29 Jun 2026 at 15:59, Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Most remaining users of desc_to_gpio() only call it for printing debug
> information.
>
> Replace this with a new gpiod_name() helper that returns the
> gpio_desc->name string after checking the gpio_desc pointer.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch!

> Not sure if this the way we want to take this, or if the gpio name is
> an appropriate replacement in debug printk.
>
> Since most of the callers of desc_to_gpio() and gpio_to_desc() are
> otherwise in drivers that already depend on CONFIG_GPIOLIB_LEGACY and
> include linux/gpio/legacy.h, only a handful of instances remain that
> are otherwise in files that otherwise only use the descriptor interfaces:

> --- a/drivers/gpio/gpio-aggregator.c
> +++ b/drivers/gpio/gpio-aggregator.c
> @@ -758,8 +758,8 @@ int gpiochip_fwd_desc_add(struct gpiochip_fwd *fwd, struct gpio_desc *desc,
>
>         fwd->descs[offset] = desc;
>
> -       dev_dbg(chip->parent, "%u => gpio %d irq %d\n", offset,
> -               desc_to_gpio(desc), gpiod_to_irq(desc));
> +       dev_dbg(chip->parent, "%u => gpio %s irq %d\n", offset,
> +               gpiod_name(desc), gpiod_to_irq(desc));
>
>         return 0;
>  }

Before, this printed:

    gpio-aggregator gpio-aggregator.1: 0 => gpio 589 irq 188
    gpio-aggregator gpio-aggregator.1: 1 => gpio 590 irq 189

After, this prints:

    gpio-aggregator gpio-aggregator.1: 0 => gpio (null) irq 188
    gpio-aggregator gpio-aggregator.1: 1 => gpio (null) irq 189

Same results for instantiation using sysfs or configfs[1], although
the latter does have optional support for specifying the name.

[1] Documentation/admin-guide/gpio/gpio-aggregator.rst

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
