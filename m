Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D7AED3514A
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 07:49:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A892910EC14;
	Wed,  1 Apr 2026 07:49:06 +0000 (UTC)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com
 [209.85.221.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96D3B10EC14
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 07:49:05 +0000 (UTC)
Received: by mail-vk1-f174.google.com with SMTP id
 71dfb90a1353d-56a86f0a23bso5428504e0c.0
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 00:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775029744; x=1775634544;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QViiKnClzREegw/7Mfy/6jKSPqR75a0GyutQdyIknIY=;
 b=BmhTuU4Ru+VXDITLlW6AaZ+X6Y7oz337Tkn24V74mkWFroQLdjZZQVxe2rt9+E9GZ2
 8bxjUaZibWf6OvXmdsR4p4nr92yCYHhZ0lmMbQ7oNJ7WfyAuQdF2YOdrwJnQXz0MiVV8
 b3mB3QV3zyM9MeQ3SjfQlkPz1BkIRDenscunZy8ksD2pF3ZeD9JH0TrwHfjACvM8ZPh5
 /Soy63YyW/y1fm5QXtFYNSXg990AW5YzZxVFb/yv98eGUDcsEmdjVr9+DM9Mau+uENJl
 dwJJQ6X4AxoeOz/hVZy6CM51UUtiuY2QCeD/trayuMoyngo/cxxf6bJaVDUOb8BzmOaR
 aDiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvhbvxJLJB06y1tdsNJx0lVKPwcoEVTJq1Q+VUnljB9dDJpievyJOhm71eTIFgGmWbMxKPhEyWbGs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwN74pLpXPialDtsi6Mv/f1KM5Abu5+xx9UlftgLrwdJm8n8Ppb
 ZyWRa+ugbbhPshIIwWdDOrHl+/GfIPH5v6nuQh/G93KHHF/ePu3dee4DsSv4l8tk
X-Gm-Gg: ATEYQzzyowsWiqumhcRS6ximoS9BjOyVC4Afe3/JZKYCvLo7uU1c38jQkY5rGVDOy/q
 zXqZquivwNRf/MsUjGwm5c09j8PDwBLBVQ2q3pjNLuVllstCGd4yw4Me6mQB2kQAfCdX/vFfNsZ
 aV9XjQ3nK6FNL8pOr4wOMZ/2n/kEubRPF9mLkVDOaKb2RixAy8/7uf3g6H2MLVY8oNIrelG1PmM
 7u57VlZm4Mb2LGUiPhqPNdWjzLm2t163Qbdee+fTk3wAZZdPWFyQLKBmn13O+Ed1kkYnCpP5Ba2
 ewBHCthWeNoRDJUEgUc2dEaHZ86I76NV2+pgAJYkSLlUQfzdOo0cuFR1dgzLnyjDS8tA4yzAN5o
 5NnXenPr2dVMmq0ZELlckVzrwAXOS2tWipq/MH1drWWFtYd9XAycYWqZlQfSI8X10Unv8uAxFRT
 eRvCuqfO45K1j2EVOeaLIyq47n5zn9zib2gqook8kFJjPBPjHiv7tFmZSNnCpM
X-Received: by 2002:a05:6122:3214:b0:56b:7d4d:4d11 with SMTP id
 71dfb90a1353d-56d8a7dbf8cmr1238606e0c.1.1775029744305; 
 Wed, 01 Apr 2026 00:49:04 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com.
 [209.85.217.48]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-56d589fa657sm15235309e0c.11.2026.04.01.00.49.03
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 00:49:03 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id
 ada2fe7eead31-604f1bfed92so5001887137.0
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 00:49:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWFzT03iPJ5+ugLva8lRKXDAgfFrH6GPnTguid213O9xqf45mlGiJ2VEntHiejTKTOueODalB2sN3w=@lists.freedesktop.org
X-Received: by 2002:a05:6102:390e:b0:604:dfe1:39a7 with SMTP id
 ada2fe7eead31-60567e18859mr845568137.11.1775029743600; Wed, 01 Apr 2026
 00:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260327130431.59481-1-tzimmermann@suse.de>
 <20260327130431.59481-5-tzimmermann@suse.de>
In-Reply-To: <20260327130431.59481-5-tzimmermann@suse.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 1 Apr 2026 09:48:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX1vUuKq-Q1-zA5tC5+LWap4osFJMqQ5pRJ373z++KQLQ@mail.gmail.com>
X-Gm-Features: AQROBzAbUUOUvvD9qjb80We-Rv00f545IFsCToqLfb7seW_x9Ac2xM40zkpv4T4
Message-ID: <CAMuHMdX1vUuKq-Q1-zA5tC5+LWap4osFJMqQ5pRJ373z++KQLQ@mail.gmail.com>
Subject: Re: [PATCH 04/10] lib/fonts: Clean up Makefile
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: deller@gmx.de, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
 simona@ffwll.ch, sam@ravnborg.org, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org
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

On Fri, 27 Mar 2026 at 14:05, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Simplify the Makefile. Drop font-obj-y and sort the fonts by dictionary
> order. Done in preparation for supporting optional font rotation.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks for your patch, which is now commit 3f90ea78f5fe9495
("lib/fonts: Clean up Makefile") in fbdev/for-next.

> --- a/lib/fonts/Makefile
> +++ b/lib/fonts/Makefile
> @@ -1,23 +1,22 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Font handling
>
> -font-objs := fonts.o
> +font-y := fonts.o
>
> -font-objs-$(CONFIG_FONT_SUN8x16)   += font_sun8x16.o
> -font-objs-$(CONFIG_FONT_SUN12x22)  += font_sun12x22.o
> -font-objs-$(CONFIG_FONT_8x8)       += font_8x8.o
> -font-objs-$(CONFIG_FONT_8x16)      += font_8x16.o
> -font-objs-$(CONFIG_FONT_6x11)      += font_6x11.o
> -font-objs-$(CONFIG_FONT_7x14)      += font_7x14.o
> -font-objs-$(CONFIG_FONT_10x18)     += font_10x18.o
> -font-objs-$(CONFIG_FONT_PEARL_8x8) += font_pearl_8x8.o
> -font-objs-$(CONFIG_FONT_ACORN_8x8) += font_acorn_8x8.o
> -font-objs-$(CONFIG_FONT_MINI_4x6)  += font_mini_4x6.o
> -font-objs-$(CONFIG_FONT_6x10)      += font_6x10.o
> -font-objs-$(CONFIG_FONT_TER10x18)  += font_ter10x18.o
> -font-objs-$(CONFIG_FONT_TER16x32)  += font_ter16x32.o
> -font-objs-$(CONFIG_FONT_6x8)       += font_6x8.o
> +# Built-in fonts
> +font-$(CONFIG_FONT_10x18)     += font_10x18.o
> +font-$(CONFIG_FONT_6x10)      += font_6x10.o
> +font-$(CONFIG_FONT_6x11)      += font_6x11.o
> +font-$(CONFIG_FONT_6x8)       += font_6x8.o
> +font-$(CONFIG_FONT_7x14)      += font_7x14.o
> +font-$(CONFIG_FONT_8x16)      += font_8x16.o
> +font-$(CONFIG_FONT_8x8)       += font_8x8.o

Please sort the anonymous entries by increasing font size.

> +font-$(CONFIG_FONT_ACORN_8x8) += font_acorn_8x8.o
> +font-$(CONFIG_FONT_MINI_4x6)  += font_mini_4x6.o
> +font-$(CONFIG_FONT_PEARL_8x8) += font_pearl_8x8.o
> +font-$(CONFIG_FONT_SUN12x22)  += font_sun12x22.o
> +font-$(CONFIG_FONT_SUN8x16)   += font_sun8x16.o
> +font-$(CONFIG_FONT_TER10x18)  += font_ter10x18.o
> +font-$(CONFIG_FONT_TER16x32)  += font_ter16x32.o
>
> -font-objs += $(font-objs-y)
> -
> -obj-$(CONFIG_FONT_SUPPORT)         += font.o
> +obj-$(CONFIG_FONT_SUPPORT) += font.o

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
