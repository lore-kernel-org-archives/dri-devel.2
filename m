Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B87C55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 13:59:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3BFC10EA69;
	Tue,  4 Aug 2026 13:59:07 +0000 (UTC)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com
 [209.85.221.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C904910E190
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 13:59:05 +0000 (UTC)
Received: by mail-vk1-f180.google.com with SMTP id
 71dfb90a1353d-5c276bd3692so3158450e0c.3
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 06:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785851945; x=1786456745;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jMZGg3Hr90Da/te9ZK4e2PlgcVa8qZPpj3G51Zmu8Ic=;
 b=svrsYUYO27uLxPO4yQtYaOn1UFF1Cu1Uf2d2DfHUZLniOcASfPO7FMlWNpZlBMxc+Z
 3sVGK1c4NLV8kDm6JUGlzdN7lddVHU+TatZjNXWQBRm6GT5rMELJHYSVo+t/zvgt3aFq
 POMAihtxxeEWCR8CqlNqlYYIjpxZdzmQUVByMB0nM1mpsY0z1cF8o998UR670y6B8UWi
 KQL7JGYHARmfuDWPLUMGjvFmJ4dqTxyd+EKTo3ENPFoVnmUxLpx/QlgcIgyP07f7NWiR
 nuobXedwIoVFc6h6jD+rLPQmHMkE0euqz9Fe4EgD+OuFpodGwSt4MP/WTT3s11XH6rYo
 7OPQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpAXqQNcwtbVyW87LlC1kwgyDLTPYqnXowsibjAL39yEbfVOVmSVPUqH6W02+3y+1NmK1lQ2qY82OU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz+mWyJ68McJrHKOpq1Jwk+Or3hsdK/aC+19eFwqrlFpg0j+rT/
 sJshnMB1jteZJxj3EtJD2J8DPAF4Hlh323D7iMevn7j5mFgzKUhksii8AQ1eKlfJ
X-Gm-Gg: AR+sD131NGyTjQ/Y91zrLoP7CfWa3H9inDT2sdq4PNzCPCMygWj22QkVKKMWSOTWSSP
 HpOcXuZKrIFVrQ0E6LiGrK72aGo72Bu0NjkwER45mkCdG51WGxyUUHmxsADn5axfazcp+PiOx1P
 2K5SoejBki1Xx64NExbTzRBWjoeMGSWcn2TDpBKT7l2fAdPiIgK8vHRPvRf+zft5CdVFCiX3jiW
 DA7o4lpcO2sv/P3nNf+Q5bw98M2Kz9fHjhbUcoY2R/AjGWub9RjjNxNCzHAKk8rO4w21a60OF5z
 qZzgf8dTF9+CORUbqnH2YK81qgHFoXplrux9tJX5VIuDQQwULGmPCfH9hPzBYXrLZdL3YxkRTJ4
 0l4aXiLdbmPOELJOVNstb0wQydXmGS4fcOKagT2e9lcajy/MKI7WEM7UBQtrZCKKSD3d8EVyVEE
 nxx6kAm5Dy7ARbF4QzLC/J8yVj/XDNqTQEh/Zw7acg72u0nfojMwHuMY7WFNyq+Csnnivcw7qz9
 CLxUI3V4RWLqVE25hKG0qgiA5eYcQ==
X-Received: by 2002:a05:6122:3291:b0:5c2:c115:ef56 with SMTP id
 71dfb90a1353d-5c3878da5dcmr5295463e0c.11.1785851944505; 
 Tue, 04 Aug 2026 06:59:04 -0700 (PDT)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com.
 [209.85.221.175]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c3d08b1e28sm463814e0c.10.2026.08.04.06.59.03
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2026 06:59:03 -0700 (PDT)
Received: by mail-vk1-f175.google.com with SMTP id
 71dfb90a1353d-5c276bd3692so3158420e0c.3
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 06:59:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RprsjOlbl7F8H6ehpa/0VafH7PdjgMZwjrCw4Bv8dqS2axRoeS9AxO8MkejCmPaJlv60We543Ct/os=@lists.freedesktop.org
X-Received: by 2002:a05:6122:178a:b0:5bd:ea6e:52f4 with SMTP id
 71dfb90a1353d-5c3878da56dmr4433506e0c.10.1785851943093; Tue, 04 Aug 2026
 06:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260731215043.30392-1-maximpedraza@gmail.com>
In-Reply-To: <20260731215043.30392-1-maximpedraza@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 4 Aug 2026 15:58:51 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVrmpZibxnP5k8wCr_Jpx2WzAe1bcUt9k_hWrreDs_-Eg@mail.gmail.com>
X-Gm-Features: AUfX_mxuzkKCO3FqjKUxMjQ1O7E0RvhlBOsj8RUg6kF0tqsdz7CSmr5lOxZ_jd0
Message-ID: <CAMuHMdVrmpZibxnP5k8wCr_Jpx2WzAe1bcUt9k_hWrreDs_-Eg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Boot logo supplied by the device tree
To: Max Pedraza <maximpedraza@gmail.com>
Cc: Helge Deller <deller@gmx.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>,
 linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
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

Hi Max,

On Fri, 31 Jul 2026 at 23:56, Max Pedraza <maximpedraza@gmail.com> wrote:
> Embedded products routinely need their own boot logo. Today the only way to
> get one is to replace one of the logo_*_clut224.ppm files in the kernel
> source tree, which bakes the image into the kernel image. Two products that
> share a board support package but differ in branding therefore need two
> kernel builds, and rebranding an existing product means rebuilding and
> requalifying a kernel for what is purely a cosmetic change.
>
> This series lets the logo be described by the device tree instead: a node
> compatible with "linux,boot-logo-clut224" supplies the image in the same
> paletted format the built-in CLUT224 logos already use, and the kernel
> prefers it over the built-in ones when it is present and enabled. If the
> node is absent or disabled, nothing changes.
>
> The image can come from the node itself (patches 1-2) or from a reserved
> memory region the bootloader filled in (patches 4-5), because the image and
> its placement are independent axes of variation. One board sold to several
> customers wants several device trees differing in the logo. One customer
> with several products built on that board, with different panels, wants the
> same logo placed differently on each: there the image belongs in a shared
> binary and only the placement belongs in the device tree. Patch 3 adds that
> placement.
>
> We have been carrying a cruder version of this downstream on an AM335x
> product since 2020, across a handful of board revisions, and it has removed
> a real maintenance burden for us. This is an attempt to find out whether
> something along these lines is wanted upstream, and if so in what shape --
> hence RFC.

Thanks for your series!

> I am aware of the contentious part: a bitmap is not hardware, and the device
> tree is not an obvious place to put one. The argument for it is that the
> logo identifies the board in the same way the model property does, it is
> available before any filesystem is mounted, and it is per board rather than
> per kernel. The argument against is presumably that this is policy and
> belongs in userspace or in the bootloader. I would rather hear that
> explicitly than keep the patch downstream on a guess, and if the concept is
> rejected I would still like to know whether a smaller subset -- say the
> placement properties driven from the fbcon command line, without any image
> in the device tree -- would be worth submitting separately.

The standard location for configuration that is not hardware
description is under /chosen...

IIRC, real Open Firmware used to have some logo configuration, too...
Yep, /options/oem-logo on CHRP LongTrail[1].
And it's even documented[2], but fixed to 64x64 monochrome.

[1] http://g33rt.be/migrated/Linux/PPC/DeviceTree.html
[2] https://www.djc.id.au/2008/IEEE1275-1994.pdf

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
