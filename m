Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C155CDB479
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 08:51:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CB2310E059;
	Wed, 24 Jun 2026 08:51:24 +0000 (UTC)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com
 [209.85.221.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8513C10EE1C
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 08:51:16 +0000 (UTC)
Received: by mail-vk1-f171.google.com with SMTP id
 71dfb90a1353d-5bbc6c99c3aso549102e0c.3
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 01:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782291075; x=1782895875;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BqytCPnwBH27Ys1F84xwvi9+7+D3fwtua39hc9A5h9k=;
 b=aJ0HL6iHLtxkWl7xy2CGOrtmeeRP+mL92hWFVHDhUGFgrBIA4HXGQfZj8KY9lZnAq8
 5uLkNqbj0pXk1XjkM1QUUIwtarrChSAKlwjHGUu+MrP2e1ouaylcEzHnDpBy+ZTkWeT8
 qy7BcQ+y/LgmH3uiOtegsbOpgq+2jkBUqxzwq6fmR6yIxwFY3ss0I5ypgl0YOtn62STD
 urbXcD8BmEpsbxvAbEAro09+ah6LP88dGkLJvV2nEkmgiKBB01YA8vvRbSu3T7CUoYbQ
 nNFQwWpHgi2rHnnYHDoPy1272A/lVz1UqXjpIh+/KBSUXbhu7qv8KfeDHotd86MHfnWr
 pSzw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9CP52JPnW4+vYkBBLgU/npnLVE3cItsJd+P3atfG9fueyiB/8hlCE4ztvpmancRYRtjVhEo+kkb0g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy9T4vspt91OJZHzjBv1HgnEMbEgabt9aHJlA+fXrW8f/mKN/LD
 d3lxbpP5i794WO50j/nSR/AvqRnn/F4D9xM1iQn/O+6jsSmwshQbt8NBXQmro8hX
X-Gm-Gg: AfdE7cmRq0PVZ380pGvXyL1DXgIeg0h7tdb/f/z0XoxLCY7cmHNzmbq/4U3ItdhYo5R
 522pQRjk2+rcpXcCe3BMMyoQisMht9ONSMOylqMcfuO5zovegadroILfLGIUDP8ciVbxURggmyU
 jYgla9Ou1EjIiOT7Ytx/y0+LyCu/6nDGxsIWm86aISHeLJt6v5iW729yNG1piZ3nIsxVf0AXtJE
 9XPUwtRzjrWVzypE8eqh/ziuhIoBX6dq3ONUQZ70u417ybvgv4xwEyFPTxJlM+6+sC85rYxkLGY
 ZnPtaycPjH3oCAhPrGAG3UVpdkuvwZoy7o264yOH70fRgHXRKsX7PO//f3ADi/JM6JiVEO3vuEk
 sNRN00Dwcx+WT41b7KVI7RAgTXeyH/NZS68K544wduTbvsFyZpgEbgS1rp2tn9uDQh2KrzuRoaR
 9dHmk/EcCWSJ/7GQJCvUNckfdWYnV69e6vqt7oMQOgGXTL6RzBoA==
X-Received: by 2002:a05:6122:341c:b0:5bb:d0ab:5ed3 with SMTP id
 71dfb90a1353d-5bc3eda793cmr1103751e0c.1.1782291075426; 
 Wed, 24 Jun 2026 01:51:15 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com.
 [209.85.217.47]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5bbfbab451bsm10185260e0c.18.2026.06.24.01.51.13
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 01:51:14 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id
 ada2fe7eead31-6ca94e539f9so446053137.2
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 01:51:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/M+snZWt/YazvWuak9vT9pTQP97sC4Yh5QYwhGxRUSdJlO0XuqwRPxkQWir3UBhQEpKxDgIRfPbU4=@lists.freedesktop.org
X-Received: by 2002:a05:6102:1628:b0:726:cd42:d039 with SMTP id
 ada2fe7eead31-7311593bc40mr980150137.24.1782291073707; Wed, 24 Jun 2026
 01:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260622064915.767194-1-haoxiang_li2024@163.com>
In-Reply-To: <20260622064915.767194-1-haoxiang_li2024@163.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Jun 2026 10:51:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUSVacMR2Lb-VwkeZMrS=wKz9y+XtF=nAOCuSLbDs-HdQ@mail.gmail.com>
X-Gm-Features: AVVi8CdAnFBD23v1TZLF1N6maP__8rBsA0F0VCuhXPs6KKGubkqUcrjbf5oJASY
Message-ID: <CAMuHMdUSVacMR2Lb-VwkeZMrS=wKz9y+XtF=nAOCuSLbDs-HdQ@mail.gmail.com>
Subject: Re: [PATCH] video: hpfb: Unregister DIO driver on init failure
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: deller@gmx.de, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Philip Blundell <philb@gnu.org>, Kars de Jong <jongk@linux-m68k.org>, 
 linux-m68k <linux-m68k@lists.linux-m68k.org>
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

Hi Haoxiang,

CC hp300

On Tue, 23 Jun 2026 at 06:41, Haoxiang Li <haoxiang_li2024@163.com> wrote:
> hpfb_init() registers the DIO driver via dio_register_driver().
> If a later error occurs, the function returns directly without
> unregistering the DIO driver. Unregister the DIO driver before
> returning from these error paths.
>
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

Thanks for your patch, which is now commit d6c3e2402523ce01 ("fbdev:
hpfb: Unregister DIO driver on init failure") in fbdev/for-next

> --- a/drivers/video/fbdev/hpfb.c
> +++ b/drivers/video/fbdev/hpfb.c
> @@ -407,10 +407,13 @@ static int __init hpfb_init(void)

As per the comment out-of-context above, this driver supports devices
on two types of buses:

        /* Topcats can be on the internal IO bus or real DIO devices.
         * The internal variant sits at 0x560000; it has primary
         * and secondary ID registers just like the DIO version.
         * So we merge the two detection routines.

>         err = copy_from_kernel_nofault(&i, (unsigned char *)INTFBVADDR + DIO_IDOFF, 1);
>
>         if (!err && (i == DIO_ID_FBUFFER) && topcat_sid_ok(sid = DIO_SECID(INTFBVADDR))) {
> -               if (!request_mem_region(INTFBPADDR, DIO_DEVSIZE, "Internal Topcat"))
> +               if (!request_mem_region(INTFBPADDR, DIO_DEVSIZE, "Internal Topcat")) {
> +                       dio_unregister_driver(&hpfb_driver);
>                         return -EBUSY;
> +               }
>                 printk(KERN_INFO "Internal Topcat found (secondary id %02x)\n", sid);
>                 if (hpfb_init_one(INTFBPADDR, INTFBVADDR)) {
> +                       dio_unregister_driver(&hpfb_driver);
>                         return -ENOMEM;
>                 }
>         }

Hence if the detection or initialization on the internal bus fails,
other devices on the DIO bus must not be force-unbound.

This is also the reason why any error returned by
copy_from_kernel_nofault() is not considered fatal.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
