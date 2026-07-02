Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E331CC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 14:56:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31A9710E455;
	Thu,  2 Jul 2026 14:56:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mechasystems.com header.i=@mechasystems.com header.b="lU7+TRth";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E52210E455
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 14:56:56 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-37f7a5a217fso1623105a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 07:56:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783004216; cv=none;
 d=google.com; s=arc-20260327;
 b=R/qHn7wLK8GJMofpa6fLclQUTzK7naujPYo+/K+OJ9FZgy+GYgE7WOzjxg3ss6FTYO
 giYDRIcNSiUd3Xk8OrCmv/PbPPxDbn7359gR3OeaVtzqBhW5pnaXY7Wd2f3CW2ZiwiC7
 9sqTDqzhgz3KBhLsncpoJzrVe8WYPG5A2Aisd4Zbn2UY4ix9PN0WLAkx2U7WX+dnEbkx
 Sjwa0W6OJm0MYKp2+oO5OX+PKC/5XAwl+TiSabxaLgZUv/Jp9v3Z/30QSuJbOSq+mhTb
 CxXbm+J3/xwwvIO7tLAJn5vzM94xTZHuAfTjnarL+8QlCMmY0NgpWDmBw9VKA8hLSf3Q
 9u8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=JHkjhNKJER8sAB9/1Vki9x5X0XUDAJyIWw5fzOAe7Xc=;
 fh=35vpW5YY5u/Ar++SpfKdvMIv96PIEo4xamQojqOaGa0=;
 b=Q62kVxHmVf8PcWlr8fhHyVN3F7mfgtHQwhtyGhMypKsfrNJ8+vfUYB9InEPxhXUW8c
 drbQjY6wCQXJh0RbozaJbZDHNJbu0d2ZpR6bqel2LKQpffVbyixgKTPKbgWFbnr5P/GL
 7WofoIxSrNzgi6Sg/DY8IeuuNjDMWJ7TawYOoYJQRapzmlN9QnIxiSWM3gHwrGzXRjt3
 YGzFpbvf6DzCrxipjrPqgsClCiGPVml8l94xREkNMlILQxckdXyMh4qM51cDbQq9T29J
 jtMULRUdwAh1xyko4IkS+x9/cZvVYYORmyFxxXobeonuNm3XC0AhNtrPklaimPNFYzPy
 FTuw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mechasystems.com; s=google; t=1783004216; x=1783609016;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JHkjhNKJER8sAB9/1Vki9x5X0XUDAJyIWw5fzOAe7Xc=;
 b=lU7+TRthZz8H5Oi5/vHAMO5DMvkkwsD715em9OigEz80yvwK5R9ZYFSc8vos3m9Qr3
 E/cU3tu/rs4nXLFACscoy539ENW2M7fZUEzeJmBSDYS9vqQgfaOqj9hdlJIWje4ss52M
 Fi6JWcyhvD5F1aEA9RJUMIs4EKRSk8/a09dQ4lZJkdZsLhqsz4SLPLOIKJA7v2dyK9H8
 qXcq/w6WMp//Fs8TIvy8RpA0nHYX82h+zLHF7ICfeUlqcy/ubGyZgWvTj5pWN8Mpk7io
 ovXhw9+/RrxnRZ67zt92uVn9CTzqNZB/zMF1NMlWvzeplyFqa38LBlwa3i3leUeZ78O7
 2JZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783004216; x=1783609016;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JHkjhNKJER8sAB9/1Vki9x5X0XUDAJyIWw5fzOAe7Xc=;
 b=YqOwu9aJI00yMHNdfimwBO1HAocJF64Gs0X+9cQUXoEqgGJ1gJ7dwRFlMIRhYbQXuv
 RjAvVEaAfgDnc+7dn0PIv9FJTpifCj/KUdCsG6bXszO5yRbFLzrVQ5Cz1dnRf3QFoIm7
 w8jYfIzDSFdZhQjUnvl1Fwf9jhFwcFMTQ7j/PcjwS7JpNATm1jTIzcd7DELZWv+ixDG+
 Ors4T0BtG1/18Fu6AAHeSp21FG2j6vyqzmfSKO8Ciw/4+L0YDZhH3/C3kE5vdEJywkID
 8ITND8XGW0nIf+DNMH3mKJnD/Jol4NFdT1cjVDO0+TWBA+qIphbV5w7gRxZkdtrucECA
 8CyQ==
X-Gm-Message-State: AOJu0YxRaI6h3uSzb+pOmBXnWjD9LO5OrENkK5fTzHKZphhGt61k09x7
 riRmabbA0dqxXdHz5iY5gyy8fmYLFArS8wBEY9O4YiJzpu4aQ8wzjlCAO/quZk1YTSChV38l0o5
 Q3Y1RWMxNHQmu/eDuCEalR+MRu2E+huXE0+96ozlXTkv7NlhfeCq9Cc8=
X-Gm-Gg: AfdE7clLdgcGxLacKC2H90hR4DdzNY1XoOTfrFITChHOYG1wCdv6XE8aYRibb6axCHi
 JAtgfWhQ2318fAQIhbxLt5LgcbN6VUopcpURXFuk39noCOetbAju9UUVokY1GC+lIz0+aYqK0lY
 GNLwxBB8Bk25DOBsI80PfJ0hWng+q8oH2P+UDOR+ZAosKldKW61hpD1K0N/EpNJbuNkrU5jbJ6E
 H/y5vD1YtL5xFoQW/DJhdBeLcTLeyefFSkOxUGJI2PMXUM2wHzAhHg4ffb3YXCDX/ubkS0V
X-Received: by 2002:a05:6a21:3a83:b0:3bf:63af:85d with SMTP id
 adf61e73a8af0-3bff40a528emr7452735637.18.1783004215639; Thu, 02 Jul 2026
 07:56:55 -0700 (PDT)
MIME-Version: 1.0
From: Advait Dhamorikar <advaitd@mechasystems.com>
Date: Thu, 2 Jul 2026 20:26:44 +0530
X-Gm-Features: AVVi8CdrbPmqZHpEyIuAPX2PkM2XbR8i9SzzA2jTyPb_3KNw5_HOoaEHXWdNuVo
Message-ID: <CAAPs2HR3mqy_duZS1q3eb1OH3tnPuDa0-h6GQYuc8FuTZmYXSA@mail.gmail.com>
Subject: drm/bridge: samsung-dsim: questions about command mode enable
 sequencing
To: dri-devel@lists.freedesktop.org
Cc: inki.dae@samsung.com, jagan@amarulasolutions.com, m.szyprowski@samsung.com,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
 mwalle@kernel.org, frieder.schrempf@kontron.de, linux-kernel@vger.kernel.org
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

Hi all,

I'm working on bringing up a command-mode MIPI DSI panel (CH13726A)
on an i.MX8MP using the samsung-dsim bridge, and I'm seeing what
appears to be a timing-dependent issue during the enable sequence.
I'm hoping someone familiar with the DSIM hardware can clarify
whether my understanding is correct.

Using the upstream driver without any changes causes my panel to come
up only once every 5-6 boots. While I know command mode does not yet
support TE IRQ synchronization for my setup, I expected the panel to
at least come
up every boot even without VSYNC synchronization.

Immediately before samsung_dsim_set_display_enable(), a working boot
shows:

    STATUS   = 0x8010010f
    FIFOCTRL = 0x0155551f

while a failing boot consistently shows:

    STATUS   = 0x8010040f
    FIFOCTRL = 0x0155541f

From the register definitions, my understanding is that the working
case indicates the clock lane is in STOP state (LP11) before
enabling video output, while the failing case indicates the controller
has already left STOP state and the HS clock is already active. The
FIFO contents also differ between the two cases.

To experiment with this, I added a loop that waits until the
controller reports

    (status & 0xf) == 0xf &&
    (status & DSIM_STOP_STATE_CLK)

before proceeding with the remainder of
samsung_dsim_set_display_enable(). Waiting for this condition
significantly improves the success rate of panel initialization.

Noticing that samsung_dsim_set_display_enable() sets the
DSIM_MAIN_STAND_BY bit, I also tried toggling that bit. Surprisingly,
doing so causes the panel to initialize almost every time, although it
often initially displays a white, purple or green screen before
eventually rendering the framebuffer correctly.

The following hack, combined with the polling loop above, increases
the panel bring-up success rate and makes it work almost always:

    reg |= DSIM_MAIN_STAND_BY;
    samsung_dsim_write(dsi, DSIM_MDRESOL_REG, reg);
    msleep(20);

    reg &= ~DSIM_MAIN_STAND_BY;
    samsung_dsim_write(dsi, DSIM_MDRESOL_REG, reg);
    msleep(20);

    reg |= DSIM_MAIN_STAND_BY;
    samsung_dsim_write(dsi, DSIM_MDRESOL_REG, reg);
    msleep(20);

    timeout = 10000;

    do {
            reg = samsung_dsim_read(dsi, DSIM_STATUS_REG);

            if ((reg & 0xf) == 0xf &&
                (reg & DSIM_STOP_STATE_CLK))
                    break;

            usleep_range(1000, 1500);
    } while (--timeout);

This is obviously just an experiment and not something I'd propose
upstream. I was only trying to understand the hardware behavior.

What surprised me is that toggling DSIM_MAIN_STAND_BY appears to make
the panel initialize much more reliably than simply setting the bit
once. This made me wonder whether toggling DSIM_MAIN_STAND_BY causes
the DSIM to restart or resynchronize some internal state machine, or
perhaps flush or reinitialize some internals, rather than merely
enabling video output as I originally assumed.

My main question is: what hardware event is expected before
samsung_dsim_set_display_enable() is called so that the display
can start up normally every time?

Is there already an expected synchronization point in the enable
sequence that I should be waiting for instead of polling
DSIM_STATUS_REG, or does this behavior suggest that I'm
misunderstanding the intended initialization sequence?

Thanks for your time and consideration.

Best regards,
Advait
