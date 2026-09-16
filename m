Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC3BC982CD
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:05:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6BAF10E97E;
	Thu, 17 Sep 2026 07:05:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="kyZFW2ZO";
	dkim-atps=neutral
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com
 [209.85.128.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF1F710E09F
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 21:43:24 +0000 (UTC)
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-86162c086f8so790487b3.1
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 14:43:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789595003; cv=none;
 d=google.com; s=arc-20260327;
 b=C/LfNraO55MwyuB1A9c/zO85jSbSpDyjcVuwHmcSJ/pSiiMhYaDf6zU2gvS4aVqsLX
 by+tTGPlxbMyzsjqrIUTFQt3h9F/8+UkzL850MmxLS3wbf4lRQZ02+nybdxQ5pfWKjkL
 SzJlnvabecnSpV014GczcnQigYRW5wlviek2iFxrdKRAF+D7acaWH8X87Qa7bB4YEtd5
 3kuEaB3c+bQoKj2Xv0WzetQl/c08CkK452uVWz9CJlcHuOXG4BrzjfxB+VjKHZfMah+M
 DDDcGVKCuytN+PUxuK1OLJI9iut7oqvXKt1QPfqiXNQcDP7C/TQ7t2ZYCM22e7eN7PeR
 iXeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XcwxAB43YdszLPV10ZP5iQsr+p0JEvwgv6jHK+rlABU=;
 fh=1OwIzntrVtmK/hr5SSRdldaUTh3BIaJ7s4eVrYivD2E=;
 b=ChgU94EuSWpZMSFcLEF3bxCWngj+VWgzAc9NTo3a+pZW9UbHJyH3jkf98okhHv+9XX
 /cCAasCQSeuzkNXptU2OknTEZyD1HIvPqVEgR77OLXb8nxvg3neOnKcD4E+CuDiPx10N
 4LlLK54vHZfJgHruJApeZ5YaalKW6di8+0BiixSvRR8wgUOFlemigMuoqSKoBGBkjnTG
 TBhPC2eW0ak+iq7wHP25tUGoCsprq+zvtIMRn5H+1EfULFLsMnRjnmvOWZa/V3l+GFR4
 EKpipt7s1QHM9z+kQDSJHu3/SwFNID7dxWMK1ELx+M/OEVUIdKraZb5D/0UFoLzQQ7rN
 DoQg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1789595003;
 x=1790199803; darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XcwxAB43YdszLPV10ZP5iQsr+p0JEvwgv6jHK+rlABU=;
 b=kyZFW2ZOIxGgQ6+neWeFzPq3KajdBpZzNGNUJBK7ZceXIzOcnGE1Jw8lg2iL4QVoqO
 tqpDIujuZns4LUYo76RvSQ516Obaa20muTmhy+/J8yXawNjp0MShGJzvEUElX2iz3DXQ
 UD9UDexyPpiTGP92S3rm+6mxC66fdbnUioMxoCZoAcT37kMjz+cz14gVZkYQ8M5f8BeV
 aaAnQtws32CYxwVfN6yqpuh4K1+Aed0E+8ourkEcyPx+yBPyoq2+eBZZgZfhvvXn5GD0
 iRmTnusKXjYfOySU5+tzYUQyKj/6ZBCIGp5AghHRq6VKLEsE25kKjDQ3u6BIPMS7gOIg
 gTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789595003; x=1790199803;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XcwxAB43YdszLPV10ZP5iQsr+p0JEvwgv6jHK+rlABU=;
 b=cDLE8mKORG1TfAofnQZIpS1iuPPD1BwVyKF2OuuDPQqdXiYQq9Ar+/TkBBgp6aE686
 leEdfYr9td7cS1E5ajUDFHQYuewy6+WHovRQz342NWFGgM4L7pm+ZwDDZv8FRzofWzCI
 atLnJYBczO/9PbtUbI3b9N0NV0g5GLVJQjdHUJoO4K2QWKQaJX60bhvXNq9UFKh1Z85k
 2iTCxqjKl+jBSWjSL1C4ov0i7fxSY0Hl5cEap9piAR7kCdMiUKP8PNxel1iuZOe46LZ7
 dnAwHvXrRKYQn1jS9sr6zFMo7jPDmTMkc7kaWs8WOSGF4iWNe/4fkveRDJqsNs9JBysx
 zjaw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzY3b4swazHvxLT2iZnX3Zr3C3ywKlnIR75J3yJ+XnfD9CyJyOKOtZu4ABL+DlXLBCjjhUHCWbJ2fI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m8pmzChifSanvaV0GiIlN6X0+NjoQSkSafhDHEIu+zdClqlxKW
 Ju1GK4H3ka6VlUNDChbj1X5xfcrsrRrrzF2lANRvfe7OlG9PEsBWtqHiickFh+D6MD5RJ2Fs30O
 hwO0SJ1zXDYD6M9+nQ3EC6mLkqWct2AQbRiyR5Stl
X-Gm-Gg: AYBFou1nCNWMJ4U9U+bdn0IYUQWdZFtNtJZnSv2JT/dtMYY+iyu+xiXDeWjekGWOqIJ
 /xRYD/MrHBIs2Tl+YWIYp1gmFcK36EyWvQ36zI/2WnbFUJedlF3zNQx6+V0QkA/nhvQkIar5Ne2
 Ksst3g6t9uKGvCvVRuqvZWrKXVr18uBk2MSsOGh6V8cJBAgKtzHPfjDiR58t8hBiQVZnOwz2PP7
 mPgZab0fu46QOBYNv2eq6oStQWw61GgEsZO5KVgB3Jd1JCW53fA7WjXzyTj6g6qfvOJXqHIXMV1
 xgZ7uQTaEXK9wQDJ4MK+k6arI4EVdyEPzuuzVQCWxPlWc1My+vop5XdHHQxO7ur0nDNrT8HLM/H
 Aq54B0r1FCw==
X-Received: by 2002:a05:690c:7:b0:873:5c7b:c12d with SMTP id
 00721157ae682-8944596a1a4mr2540477b3.21.1789595003466; Wed, 16 Sep 2026
 14:43:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1788284852.git.sean@starlabs.systems>
 <apfz3lf1RIfAkKYS@google.com>
 <CABtds-0w2b0P6SGoAZGHJe-4usmG6B8SUP1ufRQyp0+9UFcF3g@mail.gmail.com>
In-Reply-To: <CABtds-0w2b0P6SGoAZGHJe-4usmG6B8SUP1ufRQyp0+9UFcF3g@mail.gmail.com>
From: Sean Rhodes <sean@starlabs.systems>
Date: Wed, 16 Sep 2026 22:43:10 +0100
X-Gm-Features: AcwNN1U8ZB3podUdFXiPZ834VqBifCusJKONnKfdetS9jbEaRFfMhwBYCh_JS1c
Message-ID: <CABtds-2srRmKDvNj7g_0C2w8L72WczLsA+Vc_Yg3KC4gvSJyqw@mail.gmail.com>
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
X-Mailman-Approved-At: Thu, 17 Sep 2026 07:04:01 +0000
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

How about patch 1 and 4?

Thanks

Sean

On Wed, 2 Sept 2026 at 11:01, Sean Rhodes <sean@starlabs.systems> wrote:
>
> Thank you :)
>
> On Wed, 2 Sept 2026 at 11:01, Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> >
> > On Tue, Sep 01, 2026 at 06:48:01PM +0100, Sean Rhodes wrote:
> > > Move the firmware attributes class helper out of platform/x86, rename the
> > > coreboot-table firmware driver directory from google to coreboot, and add a
> > > coreboot CFR firmware attributes driver.
> > >
> > > Changes in v14:
> > > - Rebase on current upstream master after Linux 7.3-rc1, preserving the
> > >   intervening coreboot table bounds and CBMEM no-map changes.
> > > - Drop the standalone include-order cleanup. Replace the affected relative
> > >   includes directly in the firmware attributes helper move, as requested by
> > >   Tzung-Bi.
> > > - Split the DRM coreboot framebuffer dependency update from the firmware
> > >   directory and Kconfig rename so it can receive a DRM Acked-by separately.
> > > - Keep the CFR driver and its runtime behavior unchanged from v13.
> > >
> > > [...]
> >
> > Applied to
> >
> >     https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-firmware-next
> >
> > [2/5] firmware: Rename google firmware directory to coreboot
> >       commit: 44e33a5aaa2de3f5cf2701d6f4b0a7c63d4fe602
> >
> > Also created an immutable branch "ib-coreboot-rename-7.4"[1] for patch 3
> > and patch 5 which build-time depend on it.
> >
> > Thanks!
> >
> > [1] https://lore.kernel.org/all/apfyaxKEEJz20wRC@google.com
