Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8654FD35151
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 08:55:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D91F710ECAC;
	Wed,  1 Apr 2026 08:55:31 +0000 (UTC)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com
 [209.85.217.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3F0D10ECAC
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 08:55:30 +0000 (UTC)
Received: by mail-vs1-f50.google.com with SMTP id
 ada2fe7eead31-60567e76830so446587137.0
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 01:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775033730; x=1775638530;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JovjSUZC1lNxdv0gpf2LIekR3ONpuaO8xMZDQYnx+qs=;
 b=R/lRuUUiee82vxEr+7EVEOgBfDpWZRdUM7HVOFB4a4/EjWE6/a6piwA7Q5RvLP8mJo
 uAo4csSZ8BcwO4oW/D2Q5JzFyxhaL0pVzvIZr7StU3fAgYvJJmF8q2y2Pi1qL8qL9ywf
 HZ+wQyoaEaZUCRBZFQOyRpZEiSjsoewK79QRpZTuik1poAYAHg63iJfWMnSSBUeT0HRl
 FU9dtGKHS668TR+5B8ADOdYalw9qyxIpaDPq5olcpFVmNCzlBycFotPFjrxtIrl43eRj
 zYv+0FQq7tvqgGeJTVIzRSKJAgDjur6TZ/GPlzcNSmmbl2gHkpm2bUTHoU9+R1vdM9W3
 ISZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0P3Bp+VIBETSTRlGckaS5sNWJaSXXNFw9po4cP7ruAknLBZlRfZNOklQU6li7ABiKZGnCU8eHxi0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwkCo0Zkju92FnEioUeXoFlBACuEueH5Q0tO0e8AlO+Mw8JPab/
 ZUGOyAeBRwVFt3IrtgSlSAZfzmhC9k3ZPOlDYxWkrKYZFEbeCV2+T6lr4pQKzGj1
X-Gm-Gg: ATEYQzy7tgI2R2oaAh/BeLsVcpIGi0Zw5UGhVCjObtXBIFXezbOR7bj6qmlyYjmyt/E
 HSax1Yxym/L3tfjjEt8SSsUEGxMeAPrRlm/UhGkHwe1bKJ2TdtUZFocvgURRZXPVylkaFvlogNp
 7VjH0tqeGKE5SSFs5IuuvcIunmOWxZheH4xEUXBhlXPekaHk0RIJ3EteLQIWTtqMLSTMc2UyGgO
 6mINL5xroqEsKRkvnEeogtUFdfx7XKznZd1YKy0h07nV9xRuQb9aydIYigXCfk9dwRtdR6r9RHD
 mXpVHgzO+iZn5leUvcl0BVkvJuwLHTWFMoT27j1Qr7PdblznN0s1nnsgQCCDwH3Lssb6Ry4/01j
 pKlnLVrn3aK0uLWxR5Inx9kvm6vXMSc9XwUcR9MyeigMDeIRTWfloPnGKi/akyShxeTbCRoJjSY
 3tRgSUkAaikCyJ2ZYS0WYudowDyJQU7hKoSio8VtmNqu7cMLWX41V2Yqd4JHCs
X-Received: by 2002:a05:6102:4a82:b0:605:19ce:9ccf with SMTP id
 ada2fe7eead31-60567e8794emr1091834137.13.1775033729658; 
 Wed, 01 Apr 2026 01:55:29 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com.
 [209.85.222.42]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-9539e4420d9sm13287580241.8.2026.04.01.01.55.28
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 01:55:28 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id
 a1e0cc1a2514c-951a0e3cdabso3672412241.1
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 01:55:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVkE58Y8hN9kS6dio57/KZP0qB1qZicGn0dDTyphV/iJV7pFEpRf1G3pfM5fiS/E2HmyF0gZy+G7/U=@lists.freedesktop.org
X-Received: by 2002:a05:6102:14a5:b0:5ff:d434:b507 with SMTP id
 ada2fe7eead31-6056811633cmr1013502137.17.1775033728220; Wed, 01 Apr 2026
 01:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260401083242.214492-1-tzimmermann@suse.de>
In-Reply-To: <20260401083242.214492-1-tzimmermann@suse.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 1 Apr 2026 10:55:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX5B6LpZ5ffaOc0Et0PK+G=_c8yD5K8JynRwu5T8rHfsw@mail.gmail.com>
X-Gm-Features: AQROBzAaKXfPphxAx92Ddhxtbq8urMrWt59bUWKyg2D17bALeZWDk-W7fhNxXrk
Message-ID: <CAMuHMdX5B6LpZ5ffaOc0Et0PK+G=_c8yD5K8JynRwu5T8rHfsw@mail.gmail.com>
Subject: Re: [PATCH] arch/sh: Drop CONFIG_FIRMWARE_EDID from defconfig files
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
 arnd@arndb.de, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, 
 Linux ARM <linux-arm-kernel@lists.infradead.org>, 
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-mips@vger.kernel.org
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

CC arm/mips/ppc, as you sent similar patches for these arches.

On Wed, 1 Apr 2026 at 10:40, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> CONFIG_FIRMWARE_EDID=y depends on X86 or EFI_GENERIC_STUB. Neither is
> true here, so drop the lines from the defconfig files.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks for your patch!

Upon first look, your changes match the (current) dependencies
of FIRMWARE_EDID.  The dependency on X86 was added in commit
7e35fc7ab433683f ("video: Make CONFIG_FIRMWARE_EDID generally
available") in v6.17-rc1.
However, CONFIG_FIRMWARE_EDID also protects fb_firmware_edid(),
which seems to extract the EDID from the PCI ROM, and is thus not
x86-specific?  That function is only ever called by three fbdev drivers
(i810, nv, savagefb), though.

I assume none of these work on SuperH, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
