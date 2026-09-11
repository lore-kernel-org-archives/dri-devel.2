Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD473C88E45
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 07:36:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E887B10F4FE;
	Fri, 11 Sep 2026 07:36:50 +0000 (UTC)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com
 [209.85.222.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54D8810F4FE
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 07:36:49 +0000 (UTC)
Received: by mail-ua1-f52.google.com with SMTP id
 a1e0cc1a2514c-97c441e66f0so446487241.1
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 00:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789112208; x=1789717008;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fbsARpw/dJVoneGGfEjuF+GfyjF53s/yH8EH4RLlPOA=;
 b=jbKanZxsowFqXgwpNcYn4IR5bV0esSFjUOPuwa97hLS8edYYpYCgsRlZEyj1PMfBJB
 pe0TwcYDPcAt+p14k8XbsE28dYJeexvPWWrxElaoE0Wj9Hp2w7wnGhdi8/3LvFUHXLDq
 lW2A2jcY8jkHKEDtCofqztg/gDNMRhKErrpRUuJvGS5zf3k0bud/ajm9pk1GGVJhQzsS
 DV6hCfCJUhsma8uHYfJf6LDUgspgW+rEleQHBqG3/8ctobGZwof0CpeEpn8ztbWkUW/F
 B8XzkL3EEVySgQJnFy87RX0RzKhLANBfse4A8Zmfx3kM2uIFe7r1wuyhW1Wuq8OYDY4S
 Lm1w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwnWOcowGQNkrQTxr6eOtf/iimIsoO5KgcD12UcFBqBN/HYTaIvdIwO8qaUoo1dJsoKK4OxmWQDq0k=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nfhVHZ5XbrKoyqu+GUplAWmQIeJdKQxrpVzi7a7lh2nChQ8MKv
 GLMs55GnoTnDSJ45b+RUBxdS5beWBu3D83H2F+FFzOm3injm4xdrrDAqftib//Vs
X-Gm-Gg: AYBFou0Ku84WIRKEMt5ZCTxY2pC+5C6ZoKdolP051yFjf9G0WM92ASbjjMPpDiCxu81
 1awj6xrVmgu+jm6Tcg/PAHZP/xLzMnk3pg4UX9WbXVFwjzuyUrHbjzyxuydaqI+aEwlEAXEUKSx
 lKyQ6WOcRXUILkQUhoH72K03aYPYHXWuLL1d9aekQE0NtQ1DQGwCObCFJhyUFiDPccklFJbQaWM
 ZPvVMnA8Hun++RTaPMC+ePmzfX2V+WbT4f4he8EZzub0dKB2HspuFwyZGnt0kswuuKYODaQAf+J
 LhbuHY2tpv6iTFMO7MF0ONyx8lOQlb9LR0HXANkaWOObtlCn58i0IuFXYtPWX0FiBPP+w+dUAp0
 nzV4sLPQ5GLfO9oBVtn4nx/n5WIsNKTtyW+BH7Rm47JJWOqs43KllfAea6VwoG7PNhTrbsy3ray
 XPUSRZf0iwJHff5o1TlIZ1xlOFR4NW3iYD3IvovHP2lQ9t4mTblaw3SYf/iyBrjeKrB0RKXXptH
 16N0cS8MYL42mFsa2S5674KEXi9eDPYFEd2
X-Received: by 2002:a05:6102:5713:b0:792:8470:9589 with SMTP id
 ada2fe7eead31-792a8cbdb10mr3171537137.6.1789112208005; 
 Fri, 11 Sep 2026 00:36:48 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com.
 [209.85.222.46]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-982b9ed8ca1sm1947096241.4.2026.09.11.00.36.47
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2026 00:36:47 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id
 a1e0cc1a2514c-97c7afa485bso506447241.3
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 00:36:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvByd6cmLdSlUpxmaji4PoZj/jLQQ4hqt+qqhOg1wCT+n703GvNyrzH52O6UKl4wG8NeOSOFU/6L+T34=@lists.freedesktop.org
X-Received: by 2002:a05:6102:148a:b0:77f:fb50:8820 with SMTP id
 ada2fe7eead31-792acdd6139mr3532430137.11.1789112207336; Fri, 11 Sep 2026
 00:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260827093948.2825531-1-lilinmao@kylinos.cn>
 <e4a2ba2e-c533-04d8-0795-e3d43caf47b9@gmail.com>
 <CAN5rfbSh9ZoUkReAqv9rHYowqKcZFa-Svy6LP-MHvqfBVhjdBQ@mail.gmail.com>
 <4f3c7184-1b5c-4074-b8a1-49261833df8f@gmail.com>
 <CAMuHMdWoZBGyH=WeiTG4QCNC4hr_+pC4QQb-wjK0afZgMUy1Fw@mail.gmail.com>
 <f2656a6f-0bc4-2afe-1a1a-f8ce1167e090@gmail.com>
In-Reply-To: <f2656a6f-0bc4-2afe-1a1a-f8ce1167e090@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 11 Sep 2026 09:36:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUBn5yjXA25zOjUbtOjeY105AwJnP+tvJjRH5Y-qzfjVA@mail.gmail.com>
X-Gm-Features: AcwNN1VMa2RNewNSKr2wzj3QZMXOaBYMFGdqezh5M0Od6lwZNKFjHs8IMjeEn6M
Message-ID: <CAMuHMdUBn5yjXA25zOjUbtOjeY105AwJnP+tvJjRH5Y-qzfjVA@mail.gmail.com>
Subject: Re: [PATCH] fbdev: atafb: Restrict SuperBlitter to supported formats
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: =?UTF-8?B?TWlybyBLcm9ww6HEjWVr?= <miro.kropacek@gmail.com>, 
 Linmao Li <lilinmao@kylinos.cn>, deller@gmx.de, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Fri, 11 Sept 2026 at 06:53, Michael Schmitz <schmitzmic@gmail.com> wrote:
> Am 08.09.2026 um 19:18 schrieb Geert Uytterhoeven:
> >>> Unless I overlooked something, the fill also looks wrong on paper: the
> >>> first line is filled with a repeated byte and then with repeated
> >>> 32-bit words of the same value, which cannot reproduce a 3-byte pixel
> >>> pattern unless all three bytes are equal.
> >>
> >> You're correct - we'd need a memset24() to account for that. Without
> >
> > Unless the frame buffer would be using a DIRECT_COLOR visual (which
> > is not the case), then you could draw pixels in the 16 console colors
> > by replicating the color index in all 3 bytes ;-)
>
> Sorry, I don't get that - are the console colors chosen judiciously to
> allow for that?

Sorry, I don't remember if we still do that.

> >> hardware support this is an academic exercise that I don't have time for :-)
> >
> > True. And as this code is used only to fill the first line (the blitter
> > replicates it into the other lines), the performance difference between
> > a simple byte loop and a true memset24() won't be that large.
>
> I wasn't worried about performance as the blitter takes care of most of
> the work (though we may schedule away from svblit_fillrect() while the
> blitter is active). Getting the 'simple byte loop' right is more
> important. My sample code got everything wrong in fact.
>
> There's a reason why we don't work with 24 bit sized objects usually,
> and probably a reason why 24 bpp was never implemented for the
> SuperVidel :-)

Yeah, 24bpp is tricky.  And in this case we don't even have to deal with a
different endianness ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
