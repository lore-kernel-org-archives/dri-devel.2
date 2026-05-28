Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BACCD5BD1
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 07:26:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6136210ED03;
	Thu, 28 May 2026 07:26:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="Rpp64L+g";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C885210ED03
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 07:26:18 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49068493267so28832035e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 00:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1779953177; x=1780557977; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:mail-followup-to:message-id:subject:cc:to
 :from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3Okm57YHWqP6DudQxxBoKKLC7I9Qfb5iqn9tysYDvME=;
 b=Rpp64L+glQKn45fb6xo6WRuCdZYimZCqmsiHrB0dhxA3x+lFCHCWx59vEYN2Z+KjWf
 0Q8K9tVRB/PAHLRwdIoaT2SOnqw+enGhtlVifNG2FLJ1gB2Pme1QRv7z5k+RYCdHPRsG
 hal8O1ZDigfTorWOWdIZNF0XSuK01oiTZGqrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779953177; x=1780557977;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:mail-followup-to:message-id:subject:cc:to
 :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Okm57YHWqP6DudQxxBoKKLC7I9Qfb5iqn9tysYDvME=;
 b=JnT34Z3s3FZOTqeiJK7l3Ex9mGKUJ5Ae94Usby+s+/+oA6xCLx0Gwl1LeKQhP0x4V1
 nOxWc4HvLk+IByJQZH3BohFmtgNZSPwvYhaWfqHgNDmlPaPZn7qE2Q3OpXhHxNz5xqvI
 OYga2XqlEdiL4ryxwQevACGjpSZQY4F8ESD1B7VOtjW6WIYn/XSjRncWNjyPLRRZQaBZ
 cq2jb1N1t2yQ+aLv61BQsjWdnehSNadbQ8BOLZIk2BlL2OaCtu7JbaCRUEXxRQmtjy30
 FF4yBy7DwKmFIJgCkKOLwsOe92UoxlHGxDMyHWnTjGu8uD46ZB9a9VcPgyfl7I7/64DT
 Px4A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+8C4ULEx2RPZ5nA0VU6CPAEePV4yxVLzEw0+RFwmqazpBcO1/+Hl6xpSlYqVHh6R4aWdI3DRRR3ds=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwK+Iv5nt/sPdrcWI/KaYByJHRSe+k0utI3tuqxpYPnjnw0yXq8
 a6K0C7E4QLaZUf1Jr6CEQrjAfyh7pAoRz1XskDIREcbKm6kuez3egcpyZkKUDWZxKzw=
X-Gm-Gg: Acq92OHFCc/b5fC56SMXdiRYRdpeVEjzHGDuFr4rvrbPN/eRnSG8ZBOmk0n7fgby5S/
 cjnbJW0e/Vw19CmUibUKl86xhP3hEPJEKyX8fClKCeQEBvgxFLxaYmiNFJUXqB/84Qmzr5osfUE
 /7x5RAmmdNTTTVWGhqNSb4859XRksF4MKgyogkb7ruWDppYKkpj8ooLGMIbddDFMrrP8LmgjEJa
 DeGwblZMvE4QsBgK19izxWTbLNTcfJGpxUgNRCCHINLUSb9sG8FherleoKvkPqFC8mlp4mtTnva
 TGbQLu/NaergJH0OdBrblFuccijVZabzQ2tvm4OWMYE3/Uu2IzgbVNQTKUTZDYncyG8eAdvBtrc
 PT+j0w7yrCQRSawa6cbPNGewCTLJYCmxhBwFe5u0ezbPLSK6TwfsXy8o6vQZjy78P+X601Cs45G
 m6vwShOqjFGv31E0v3p7z/QpwsLvl3bDFD8/chzoA2IcFkz6diztoRs5yJ
X-Received: by 2002:a05:600c:4510:b0:48f:e230:72fc with SMTP id
 5b1f17b1804b1-490428ee268mr403369655e9.33.1779953177104; 
 Thu, 28 May 2026 00:26:17 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909235f98bsm30377995e9.1.2026.05.28.00.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 00:26:16 -0700 (PDT)
Date: Thu, 28 May 2026 09:26:14 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Inki Dae <inki.dae@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
 Alim Akhtar <alim.akhtar@samsung.com>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/exynos: fix size_t format string
Message-ID: <ahfuFv4_-bd47r4w@phenom.ffwll.local>
Mail-Followup-To: Chen-Yu Tsai <wenst@chromium.org>,
 Arnd Bergmann <arnd@kernel.org>, Inki Dae <inki.dae@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260527194525.45762-1-arnd@kernel.org>
 <CAGXv+5HvJiTkLJMZ13w0OHwgp+nPBftGAC-15nhJ3R=vOPWpUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5HvJiTkLJMZ13w0OHwgp+nPBftGAC-15nhJ3R=vOPWpUg@mail.gmail.com>
X-Operating-System: Linux phenom 6.19.10+deb14-amd64 
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

On Wed, May 27, 2026 at 11:03:03PM +0200, Chen-Yu Tsai wrote:
> On Wed, May 27, 2026 at 9:45 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The exynos_gem->base.size argument is a size_t rather than an
> > unsigned long, so adapt the printk() format string accordingly:
> >
> > In file included from drivers/gpu/drm/exynos/exynos_drm_gem.c:16:
> > drivers/gpu/drm/exynos/exynos_drm_gem.c: In function 'exynos_drm_alloc_buf':
> > drivers/gpu/drm/exynos/exynos_drm_gem.c:69:49: error: format '%lx' expects argument of type 'long unsigned int', but argument 6 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
> >    69 |         DRM_DEV_DEBUG_KMS(drm_dev_dma_dev(dev), "dma_addr(0x%lx), size(0x%lx)\n",
> >       |                                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    70 |                         (unsigned long)exynos_gem->dma_addr, exynos_gem->base.size);
> >       |                                                              ~~~~~~~~~~~~~~~~~~~~~
> >       |                                                                              |
> >       |                                                                              size_t {aka unsigned int}
> >
> > The dma_addr in the same line is already printed using a cast
> > to unsigned long, so change that similarly to use the correct
> > %pad format.
> >
> > Fixes: 11e898373fba ("drm/exynos: Drop exynos_drm_gem.size field")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> I posted the same patch [1] one and a half months ago when the culprit
> patch was queued up and I got a report about this from the bots.
> 
> Inki hasn't picked up my fix yet.
> 
> And it seems the exynos-drm-next stuff was only merged into drm-next
> yesterday, now causing the warnings to pop up all over.

Yeah that's some pretty bad fail for exynos and I guess also for Dave for
not compile-testing on 32bit before pushing drm-next out. I've noticed it
just this morning trying to do some stuff.

Picked up Arnd's patch as the first one that I've found (after I've typed
it myself already, but hey let's at least give some credit).

Cheers, Sima
> 
> ChenYu
> 
> [1] https://lore.kernel.org/all/20260408064936.1342321-1-wenst@chromium.org/
> 
> > ---
> >  drivers/gpu/drm/exynos/exynos_drm_gem.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.c b/drivers/gpu/drm/exynos/exynos_drm_gem.c
> > index 297a93b087cd..8e357f2beb9e 100644
> > --- a/drivers/gpu/drm/exynos/exynos_drm_gem.c
> > +++ b/drivers/gpu/drm/exynos/exynos_drm_gem.c
> > @@ -66,8 +66,8 @@ static int exynos_drm_alloc_buf(struct exynos_drm_gem *exynos_gem, bool kvmap)
> >         if (kvmap)
> >                 exynos_gem->kvaddr = exynos_gem->cookie;
> >
> > -       DRM_DEV_DEBUG_KMS(drm_dev_dma_dev(dev), "dma_addr(0x%lx), size(0x%lx)\n",
> > -                       (unsigned long)exynos_gem->dma_addr, exynos_gem->base.size);
> > +       DRM_DEV_DEBUG_KMS(drm_dev_dma_dev(dev), "dma_addr(%pad), size(0x%zx)\n",
> > +                         &exynos_gem->dma_addr, exynos_gem->base.size);
> >         return 0;
> >  }
> >
> > @@ -80,8 +80,8 @@ static void exynos_drm_free_buf(struct exynos_drm_gem *exynos_gem)
> >                 return;
> >         }
> >
> > -       DRM_DEV_DEBUG_KMS(dev->dev, "dma_addr(0x%lx), size(0x%lx)\n",
> > -                       (unsigned long)exynos_gem->dma_addr, exynos_gem->base.size);
> > +       DRM_DEV_DEBUG_KMS(dev->dev, "dma_addr(0x%pad), size(0x%zx)\n",
> > +                         &exynos_gem->dma_addr, exynos_gem->base.size);
> >
> >         dma_free_attrs(drm_dev_dma_dev(dev), exynos_gem->base.size, exynos_gem->cookie,
> >                         (dma_addr_t)exynos_gem->dma_addr,
> > --
> > 2.39.5
> >

-- 
Simona Vetter
Software Engineer
http://blog.ffwll.ch
