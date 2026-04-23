Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83ED6F99340
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 07:22:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1BAA10E03C;
	Thu, 23 Apr 2026 07:22:16 +0000 (UTC)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com
 [209.85.217.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7F8F10E03C
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 07:22:15 +0000 (UTC)
Received: by mail-vs1-f51.google.com with SMTP id
 ada2fe7eead31-60591ade110so4326947137.1
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 00:22:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776928934; x=1777533734;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ogvygskie7zIIQ16XGTtOId1La+S1Rf8wP528DIfndM=;
 b=FgSTxF1yd1MqHXt2jEqHf3Lc7emptMR7qRWw7OTJC/sVIoCU7MiX5qfsA6eOHQ7Uca
 waEyekTkw87IeOEuinYW+yWZCpjufnv+U0ZBK4ckHtQWVwZuC450MsFP7ZIEcug2IOGc
 ckDZapilcw6SY7UBw65GBic4PhJLGbJcQnjaTqVhldMLMJyCC6ZVWZxLu43Bu8Oer26t
 MhX4cLY4DhaDzLY9bAhbPhQrUP6FsaukBZWORvcM22JwpXNfUeb5rDvBqH/YswjlEymb
 e2z8sxNIMHcQ7D5sJgS8diRtBIz8OHLUWOnrbgGcKGbUH3NVFQ8fNVKYHnOOMqMtP4Pg
 IVRg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/YFx00Wu90h/hCYh1Kstjb3RB/1eTEXblAUvjmzAPs4aPrErfnG8Ot1j2lN1cr5zkIg2TdoiieKN0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyVBwKU2Qkzwt0LjzLmBpHpew3zx/5PzV0XPEDq/EHyCrOKAz5J
 E/cF4t7+IrdPoL/Rhw4D+bK22e+JxGQbfOAAAeV4porRFIhuFfk0Z3pmGfqTE3StqoM=
X-Gm-Gg: AeBDietVST7Ew67CGA/mcNlLtxuARhsG+tJKyMjvdYMu3xh6pIqqzxYdY1moAteD7/l
 wuKpt4zx1vLSQcnfWdvn25gAnT/jdevltfLrM9AeBFripmNnxpzovm4mGRLO0nq8eBlYLyTUMQH
 ctdtD6nvdHETtw83hJT/Y70Zo5JOvEvL7jOQIyXzDRKSgIjN2gUWkBEDYmKq2ryhGhkd50wKWRq
 ywP80QbW+FXVXiZsaOfv/biwULIq7r7V91JKnYpwRQAvH/XIiJHm1qYEM5BWssOhR9MQ0FdWYru
 Q2V6BeasXg1+AvERzH//MtUAOeZihlAcOJzO004NtJ/U8rBpIpTbTKtufdYfS0mAaiW95ZE/Zd6
 PNEMr4E0WO6gZgD+RWE6NpiT9hkgZWHe1faA627QuMrYrUfInTLrU0uYdV1NTHnVTrHHMa2Cxll
 PCfanz//lIujjxk2hsePUkPLWGD7e+dyGS3XsyUTHaLjmRKIc/Uzg1dwwEKhLiTihIkFSxrVs=
X-Received: by 2002:a05:6102:8095:b0:609:af4a:380 with SMTP id
 ada2fe7eead31-616f53abed9mr13860524137.11.1776928934355; 
 Thu, 23 Apr 2026 00:22:14 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com.
 [209.85.222.45]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-95890937da7sm8839928241.1.2026.04.23.00.22.14
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 00:22:14 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id
 a1e0cc1a2514c-9539d9f1675so4094751241.2
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 00:22:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ8W5aBmmaCMXpkeLB/L2yc5Jolovg9xFkLlhk0l41l/+tgu/zTuCvEVoE6tvytP9ZO0t1IRJFnCNKI=@lists.freedesktop.org
X-Received: by 2002:a05:6102:160d:b0:607:a3cb:4573 with SMTP id
 ada2fe7eead31-616f7d6405dmr12594944137.26.1776928933991; Thu, 23 Apr 2026
 00:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260420134424.77494-1-amit.barzilai22@gmail.com>
In-Reply-To: <20260420134424.77494-1-amit.barzilai22@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 23 Apr 2026 09:22:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWhpD5vjfzsYieVOrio0chQAU=s0z5rX8AKTon3S=v-OA@mail.gmail.com>
X-Gm-Features: AQROBzBQyIzuck49gUq_0zIao92xxorffLSB_x1afAEZiGdBIOmNXPBtNdhrmqo
Message-ID: <CAMuHMdWhpD5vjfzsYieVOrio0chQAU=s0z5rX8AKTon3S=v-OA@mail.gmail.com>
Subject: Re: [PATCH 0/3] fbdev: Request memory regions in platform drivers
To: Amit Barzilai <amit.barzilai22@gmail.com>
Cc: deller@gmx.de, thomas.zimmermann@suse.de, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org
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

Hi Amit,

On Mon, 20 Apr 2026 at 17:23, Amit Barzilai <amit.barzilai22@gmail.com> wrote:
> Several fbdev platform drivers call ioremap() on their hardware MMIO
> without first claiming the range via request_mem_region(). This leaves
> the kernel resource tree (/proc/iomem) with no record of the mapping,
> allowing another driver to silently map the same registers.
>
> This series fixes three platform_device drivers by switching to helpers
> that combine resource claiming and ioremap in a single managed call.
> cobalt_lcdfb and clps711x-fb are converted to
> devm_platform_get_and_ioremap_resource(); goldfishfb is converted to
> devm_ioremap_resource(), which also lets us drop the manual iounmap()
> calls from the error path and remove function.
>
> For clps711x-fb, resource 1 (the framebuffer range) already used
> devm_platform_get_and_ioremap_resource() correctly; this series makes
> resource 0 (the MMIO control registers) consistent with it.
>
> This is part of the ongoing effort described in
> Documentation/drm/todo.rst ("Request memory regions in all fbdev
> drivers").

This file does not seem to exist?
Was it hallucinated by Claude:claude-sonnet-4-6?

> Amit Barzilai (3):
>   fbdev: cobalt_lcdfb: Request memory region
>   fbdev: clps711x-fb: Request memory region for MMIO
>   fbdev: goldfishfb: Request memory region

Thanks for your series, which is now commit d2386d9e3eb4c12f ("fbdev:
cobalt_lcdfb: Request memory region") and a40c0e815962b1f6 ("fbdev:
clps711x-fb: Request memory region for MMIO") in fbdev/for-next.

Have you tested this series?  I have to ask, because adding
seemingly-innocent request_mem_region() calls without testing the
result is a recurring source of broken drivers.

Thanks!

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
