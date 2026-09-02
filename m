Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941D8C624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:33:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9375610F3F9;
	Thu,  3 Sep 2026 07:33:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="Z2l2tWKa";
	dkim-atps=neutral
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com
 [74.125.224.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E4F110F0E5
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 10:02:03 +0000 (UTC)
Received: by mail-yx1-f47.google.com with SMTP id
 956f58d0204a3-66d116f0de8so890311d50.0
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 03:02:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788343322; cv=none;
 d=google.com; s=arc-20260327;
 b=OyYfSTo0cabdBOM3S6Hlyws0HADouvsR4Lf1CCT/xAmileDyO0oFg7cIWm3A8zL4Mi
 hh73aRanNryyo89mbJkYwLXIzZKbKjFhsViJwuYi+6N6pTF14YwsX8D9cYHtDZyTdjdL
 4yAGZ22UPgvkRjRQ5/Nwiaqq19w8OZoVQO7qbnNsOnCbRwU6F/O0GjIYuLyVLDCc30tf
 7NrKFd5VzPp5zYD3zdhXoAQ2S+1TIhf5aiyp6KpUoeZIo0NZ+o0CUrcmmPNmdC2X34GD
 vXjroIk1qKnslMZilCGexN+WPRl9CpACeiN9dbs25DhGcTUlAiP4H5XZnvjbRmd3AuXq
 5iOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7Yl5QmRxyNgI9FkGfHWferAKBRopNrYR4eAo0FssY70=;
 fh=bgWKJbaQTWbSZgqbZ3Q7AqX4wo65GcRVulvq180M+i8=;
 b=jMtpJx5SDJjeLjx/oNc40+Cjie3gmme390gg3qQkXm0oCfatsWl2nCIgFnWXVAKZR3
 CfjW8mrU2EAC4za65QVZP27FB2VfqFe/CHmIoXbnFcKnt7oZGUZnnSa9zX/fcVaS/qxv
 jiIrZD97bEPVhR0OK6/v76YGT+OFy0RTBO+mB3qrDFvANH5RIPBMrlWuDZYIo2eibQmF
 5i3BEDT+xJ0yxynhXnqUcmxNsGqpA20KmWQkzMSRCQYWrtSc7eAOhiXiTb54I1WoSa3m
 fZODem2z703aVrNuLRQGJdA2lIPrqbEugBz640Y+r/31b9Wtbd1LXEgfQEBebX3b1FTg
 wGyw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1788343322;
 x=1788948122; darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7Yl5QmRxyNgI9FkGfHWferAKBRopNrYR4eAo0FssY70=;
 b=Z2l2tWKalEP0KZCcMdIS2AQP8EVL/RIF/1NeeMWw0DpNFJOCDmnSziWPuUxZbBqmyL
 eWPe58aUVpfK4MxGz0t6ElcERmlFOe+8a8RJCEd9iZQzDZlr98krN4i0ardVOTtrsXxO
 PCxOWMU2BrXWn1ixGGTb0wukJE0gzq/jjoSx20v7AVSrso7OJssS4Op2bEWk1mUi+TFY
 nrsN99vZsLur4pufnD5deT724WJVQbCgkXK/4PSP6orUtJf6dc3SieKUZ+UOmigvpdPJ
 ZvQp9a0Q2fJXUMT3Xc87oKc0XEgll14zYJ88+Tl8HZgpa3E9jkU6AaMwCj9+I1wcOlDD
 zxCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788343322; x=1788948122;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7Yl5QmRxyNgI9FkGfHWferAKBRopNrYR4eAo0FssY70=;
 b=Zo/k30Y+THyeKFRtdt1I4XTOmYAHqULGPgv5iVmIjR+7sCLBmq+dSaZ8YL0aeffKMQ
 gHvT4epnnke/dQB1MXpWbWFVKF4aD1VF7FddK4IhpKLwc1wVIIoYcDEoI91Xe/w1/igl
 NPdtXE+islTtYdk7rOF9jJGoyxll48s83hdW0aua7Pn1V0nP02s8f6xwFmkmZFRd+uQT
 5UBipqlk+7EG6S+IKM2HjLJDxCtBwwWjajl7UQCTNQv51VMx+rEfjDTXrLPxqMNhiZn3
 8CyG4i1Re3gfY7ybD/5Fp2lh3NorrFKrYOYziM2yBcnyrWLKupr/d36M+fJCH1SWSTby
 O1iw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxZn7H9Iu/qEfHis7AIaHxEu2ZY5FaUxzWlAqoTurLXWJL5ko+5Kr/aJuYcrbcH6uxQ0of6q5pQRD0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ly2y3CqnaBhSjFo+GCBY6me8h30bQdXWDJ3Wu8aZMqRDrQhps3
 8pOduE2bD+cJNVP85r0tIhie4GVQOmLMdFXb60AfE+HNGd8hgiAFLXPp+5UZtARKkOFztySDSIL
 yFI70cqeymD4mBdXK2a0PAURdLhaoH2tCY3OTrHuN
X-Gm-Gg: AYBFou3Q2gJ+rJBWxOon7BlVR1w4gcgaOdPlDd/qg8SRpnyRMa8TgrMsjVrS/DOMxFd
 7VzJTVssLYh60qdY7nBjoyirfGl5IOLdn/cBPY09ByX+9G8AtZHk+CAPlqqHZSWdXX/zAXTBypB
 t4EL5pGIDaJ6r42Vj/WNAK2qFLhhSz2C98hlAAvrz7Cu51XfcuhiRK+odZ0mrB75igMDPNIKQCo
 arSxwdElSlycqpfGwfCcxMXunn1C41XsOSl11g0mdWD8OxJG7ITn38/cfDAb/4Ijg1z0ZP0TvrS
 9fUQyGzD5zrNWPq43AUTXxrBJORGj9/UlT23DRZbf9xQK4crgdCQDFHAZjRw+3ds3VixHdC31KI
 g
X-Received: by 2002:a05:690e:1514:b0:66f:7c64:9d47 with SMTP id
 956f58d0204a3-66f9bd4991dmr1118782d50.23.1788343321975; Wed, 02 Sep 2026
 03:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1788284852.git.sean@starlabs.systems>
 <apfz3lf1RIfAkKYS@google.com>
In-Reply-To: <apfz3lf1RIfAkKYS@google.com>
From: Sean Rhodes <sean@starlabs.systems>
Date: Wed, 2 Sep 2026 11:01:50 +0100
X-Gm-Features: AcwNN1XY2WlZI7b41cj9pFZjq4mCyoo_3nH6T_KZHZYXfCYS3mXFpBitd3ECMtg
Message-ID: <CABtds-0w2b0P6SGoAZGHJe-4usmG6B8SUP1ufRQyp0+9UFcF3g@mail.gmail.com>
Subject: Re: (subset) [PATCH v14 0/5] coreboot CFR firmware attributes
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: linux-kernel@vger.kernel.org, Hans de Goede <hansg@kernel.org>, 
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones" <luke@ljones.dev>, 
 Denis Benato <denis.benato@linux.dev>, Prasanth Ksr <prasanth.ksr@dell.com>, 
 Jorge Lopez <jorge.lopez2@hp.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Joshua Grisham <josh@joshuagrisham.com>, 
 Will Deacon <will@kernel.org>, Douglas Anderson <dianders@chromium.org>, 
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 Chen-Yu Tsai <wenst@chromium.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 Brian Norris <briannorris@chromium.org>, Julius Werner <jwerner@chromium.org>, 
 Javier Martinez Canillas <javierm@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, 
 Titouan Ameline de Cadeville <titouan.ameline@gmail.com>, 
 Laxman Acharya Padhya <acharyalaxman8848@gmail.com>,
 Yidi Lin <yidilin@google.com>, 
 Kees Cook <kees@kernel.org>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, 
 chrome-platform@lists.linux.dev, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Bjorn Andersson <andersson@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>,
 Eric Biggers <ebiggers@kernel.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, Michal Simek <michal.simek@amd.com>, 
 Sven Peter <sven@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Linus Walleij <linusw@kernel.org>, Drew Fustini <fustini@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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

Thank you :)

On Wed, 2 Sept 2026 at 11:01, Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> On Tue, Sep 01, 2026 at 06:48:01PM +0100, Sean Rhodes wrote:
> > Move the firmware attributes class helper out of platform/x86, rename the
> > coreboot-table firmware driver directory from google to coreboot, and add a
> > coreboot CFR firmware attributes driver.
> >
> > Changes in v14:
> > - Rebase on current upstream master after Linux 7.3-rc1, preserving the
> >   intervening coreboot table bounds and CBMEM no-map changes.
> > - Drop the standalone include-order cleanup. Replace the affected relative
> >   includes directly in the firmware attributes helper move, as requested by
> >   Tzung-Bi.
> > - Split the DRM coreboot framebuffer dependency update from the firmware
> >   directory and Kconfig rename so it can receive a DRM Acked-by separately.
> > - Keep the CFR driver and its runtime behavior unchanged from v13.
> >
> > [...]
>
> Applied to
>
>     https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-firmware-next
>
> [2/5] firmware: Rename google firmware directory to coreboot
>       commit: 44e33a5aaa2de3f5cf2701d6f4b0a7c63d4fe602
>
> Also created an immutable branch "ib-coreboot-rename-7.4"[1] for patch 3
> and patch 5 which build-time depend on it.
>
> Thanks!
>
> [1] https://lore.kernel.org/all/apfyaxKEEJz20wRC@google.com
