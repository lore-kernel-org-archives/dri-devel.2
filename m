Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3EE2C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 16:07:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 061D210E219;
	Tue, 30 Jun 2026 16:07:29 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E359410E219
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 16:07:27 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-37df72c9984so2204874a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 09:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782835647; x=1783440447;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vqnNDF5VKQ+E0vRBcJ/LtO+JWbWwBxQUs2IGvWvjH/Q=;
 b=lgwps7EzSYGgfmd1CaTTWSgCOiOb2d2bbDH8Y+6hZPdLY2VYb0cu/R2mg4tJMjwXxo
 3HijjZOJct80zXyceFwGf05itsIr6/Fmq6pdB0CTU/jMQvVSzNZZHE9F8rxtRixYPSMe
 sPhbNp4H5YOLMLOcvP1A0IxU+zyrc83/mSCeCx8+DtXOWF1a5tInzXjybyu5fCxDUwRZ
 afvbajZjZ+nFBpy+hJ4II8VlQNUwf9vKQbjkIorn+TA/4L5b0nytxerNaCOoMEmhA6TB
 fdN66c2UKrLJ1zMnx0gy0ifFF0b+zRiOmGk0GkT+VJGki7Ibr6xLKcKsWvB3K9uaqPBI
 tFWw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoP8d7dsN3A7OnhfwtJHVVYXLUL+WiGAjmI8NCeuOu/OWyDGfVq+rgbkqAa2NDUpZI/uA4sUih+2eI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwXZ1El3SpWAVi8RbrToQlziHepKPG9I2NeNwh7muM8/kRO0M/b
 5rZ6tsXRqaO121vEU2AGUrbj8tlrfnxK+HZ4U2X3WMD8QMpGcFRBmNfyxcs3fcx8oSQ=
X-Gm-Gg: AfdE7cm73jn9e+IhvoRSKOgUCBZq/Rydw73YsJQRGvO2Z7VrsqoPvXZLLEej43qTOKt
 j2V2lKHx3CUy2MirO7CRTfmhL2R4mH9XAOYp/59gqKIM0OiAQVEb7xU47kB56s5epkyZuCJ0wDV
 /vySRaN3l/dTuOHX1DSxbNXm6AAwU8WEx6BjqUlOe+CJx0iLgKjtpMnWAMUpA9u6rRRmutbZS7a
 x+Geb7U5n8fhnYWtovAuWanfsX8A+9JVDR1/obBddsAI5XLehLWyxzcdvCTScwZsvr0yvAzfmaj
 6yXjNHYf1+OETVVMbMwsTsjMHEXfNb5Xb9vdYLmtTcSSCItFNtjQlAdnnrqpwN30v9s8MOzR38Y
 txjzDOwlZOYNafW/+I7LCHQj1MYylioW0VFVa6YyuRRdhKt+UjslIKVmkUUX0F12oqiRlcGwSsv
 yuuhoklgumlCok/ukdAwelQaf27OAIpY647mMiqEbSN2N0mYaE
X-Received: by 2002:a17:90b:4d85:b0:380:8bba:f8ae with SMTP id
 98e67ed59e1d1-3808bbafcebmr959754a91.4.1782835647298; 
 Tue, 30 Jun 2026 09:07:27 -0700 (PDT)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com.
 [74.125.82.53]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3809645185dsm122484a91.15.2026.06.30.09.07.26
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 09:07:27 -0700 (PDT)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-13b2b08a553so2221442c88.0
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 09:07:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ8lusxKpLIy2gFrw/Vh2eZTdTBKYZdqXLxFEirKlqW5wi9W00eZbRsjjULyXqaP8gdEHsX4SRqkj6w=@lists.freedesktop.org
X-Received: by 2002:a05:6102:598c:b0:738:9dd5:9b03 with SMTP id
 ada2fe7eead31-73a38838db6mr1792608137.20.1782835280090; Tue, 30 Jun 2026
 09:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260629135917.1308621-1-arnd@kernel.org>
 <CAMuHMdXhsM4JzArRuB=A46N-Ogbn2Fans+PVJVA-hEytFq=DeQ@mail.gmail.com>
 <ff4d7043-1929-4fa1-ba5e-f28403ad6fcc@app.fastmail.com>
In-Reply-To: <ff4d7043-1929-4fa1-ba5e-f28403ad6fcc@app.fastmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Jun 2026 18:01:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWhv8i6tkmOJU_ee9LAV7mMcQHe9FXgqTHCjGiEMWvn8Q@mail.gmail.com>
X-Gm-Features: AVVi8Cc-rLKbwzFvmIKs2_rpHMNLxVULzvudUQINxHMw-KOr8IArAqRSnLCM1D8
Message-ID: <CAMuHMdWhv8i6tkmOJU_ee9LAV7mMcQHe9FXgqTHCjGiEMWvn8Q@mail.gmail.com>
Subject: Re: [PATCH] [RFC] gpiolib: introduce gpio_name() helper
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, Andy Shevchenko <andy@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ulf Hansson <ulfh@kernel.org>, 
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 dri-devel@lists.freedesktop.org, 
 linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-input@vger.kernel.org, 
 "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, 
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

On Mon, 29 Jun 2026 at 19:54, Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Jun 29, 2026, at 17:29, Geert Uytterhoeven wrote:
> > On Mon, 29 Jun 2026 at 15:59, Arnd Bergmann <arnd@kernel.org> wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>
> >> Most remaining users of desc_to_gpio() only call it for printing debug
> >> information.
> >>
> >> Replace this with a new gpiod_name() helper that returns the
> >> gpio_desc->name string after checking the gpio_desc pointer.
> >>
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

> >> --- a/drivers/gpio/gpio-aggregator.c
> >> +++ b/drivers/gpio/gpio-aggregator.c
> >> @@ -758,8 +758,8 @@ int gpiochip_fwd_desc_add(struct gpiochip_fwd *fwd, struct gpio_desc *desc,
> >>
> >>         fwd->descs[offset] = desc;
> >>
> >> -       dev_dbg(chip->parent, "%u => gpio %d irq %d\n", offset,
> >> -               desc_to_gpio(desc), gpiod_to_irq(desc));
> >> +       dev_dbg(chip->parent, "%u => gpio %s irq %d\n", offset,
> >> +               gpiod_name(desc), gpiod_to_irq(desc));
> >>
> >>         return 0;
> >>  }
> >
> > Before, this printed:
> >
> >     gpio-aggregator gpio-aggregator.1: 0 => gpio 589 irq 188
> >     gpio-aggregator gpio-aggregator.1: 1 => gpio 590 irq 189
> >
> > After, this prints:
> >
> >     gpio-aggregator gpio-aggregator.1: 0 => gpio (null) irq 188
> >     gpio-aggregator gpio-aggregator.1: 1 => gpio (null) irq 189
> >
> > Same results for instantiation using sysfs or configfs[1], although
> > the latter does have optional support for specifying the name.
>
> I wonder how many of the other instances have the same problem
> then. Would it be appropriate for gpiochip_fwd_desc_add() to set
> a name itself to address this one?

I don't think it would be appropriate for the GPIO aggregator to set
that name.  What we want to print here (for debugging) is the physical
GPIO that an aggregator's GPIO is mapped to, not some consumer or line
name (which is not guaranteed to be unique).
E.g. "<chip-name>.<offset>" would be fine.  As gpiod_name() can only
return a fixed string or an existing string, it can't return such a
formatted string, though. And consumers don't have access to chip info?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
