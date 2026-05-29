Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29DCCD4F54
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 14:09:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60E0610FFB3;
	Fri, 29 May 2026 14:09:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h0Zq+UQy";
	dkim-atps=neutral
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com
 [209.85.221.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52F3810FFB3
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 14:09:02 +0000 (UTC)
Received: by mail-vk1-f181.google.com with SMTP id
 71dfb90a1353d-59b074ec7ceso106876e0c.1
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 07:09:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780063741; cv=none;
 d=google.com; s=arc-20240605;
 b=CPdckkEsp1fpJwHESIsDxkOjsZ28kinPslCfe8eZ2WXipz1aMtLzhSueq6h91Qe8/k
 gQnLLhPKm6VE0a/BXLgPOE3f5NIgWB4weMm9vbP+foM9PzmEgSWZD1P76wu1VWrNFbRV
 xkSYrzo5DI2zu8sHqqrzW24hLN8o91elwmbIpM+5IecegXbuVsh93t0p472dfh743h2s
 NcCXMEMh/iQNWf7IKJpQ62GmnbMo3a2y+U2h47UnLu91PQ8JPvyGALbBnDFxhuamy1ME
 Ge/E4A6Ugsxy+0xuCElloBMzwAAKf8FCfaEHlQHAJKWctqo5Vvhh5vgmWfdBrGnbyDfu
 o8zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FKQQSeQjkRReUr6YFC2bWAXDEPfRaFYHezUzVYoDBqw=;
 fh=BXwjwFyRcd6gyXeHCka4kAe6H+soKnMxApPr9/4PGyE=;
 b=HO6Fjzm+8xPDcvs3ilG63UBULCwq2q9MoprkYcPr7U61QzoNBkQfuV2AV+DxCVtVKf
 k92ChtsapYbFZwarZ8M9nB/tQbQYijD0sFm8veA6a+nyqbF3ZBfy45TieUE7Da4AG96g
 t+tv+VkQixcYu3AOkQJyFvGm015OY2HUSFh2seV+7+W1lOg0ZoUqkD8tyDytOxMdCZuI
 AYH15Jfjw2sh2hKzvNUFzvCf9e/dY7bPD2fGlkilaOoRDD+oVHC/pK68pUZNttAn8lgs
 7d4j6QkrctLmGjWRxSkFm8hSQl9EGMP13Eify/2XMH35P7VMuGeilA/Vvn/uTsV0Viuv
 1uSw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780063741; x=1780668541; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FKQQSeQjkRReUr6YFC2bWAXDEPfRaFYHezUzVYoDBqw=;
 b=h0Zq+UQyKmtp3nKEyVfERlnZTjdNfujucSGpuDuRVImd3SLyDEAh/oJasjBVm6nQDQ
 5HKRLmMwUfxg3joypiIoLpPUgCWI8A7gpvb8atM2ic+eHTaGvF5wrGy2CPITCtN8Sfp9
 U0Onh5qAEErReiJM4NnvNLT2QM2IJM2HQ2i8/W390f0dvndy3wCQRhYFMOJ2rImfMA5V
 QeCChbkeafCF/ZYq+4fXosw/dcpTPEOPG0wfqtvtNaMWRO8W/b1wdJ5BXHpc1AHNjZ9d
 g9Dj0qi/sFrPvZCXX+leW8FFDlwGR74hEsfk6yNzGI4Dr2hh+jUt5uLVrfO4jdfpiqGi
 Bc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780063741; x=1780668541;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FKQQSeQjkRReUr6YFC2bWAXDEPfRaFYHezUzVYoDBqw=;
 b=Eg2K1Z/KunR56K5QzoAE0ExsJbi/JWRo/8HMZT4o60KqkWYInGYFkQVqYx+nUVXNfD
 S0u2J272vXf1iKaQAJKsX66PlWlEc2Uzp1RsybS3iH5yrl5JIvuwbJEQap9LB+5KI9Li
 UsTcXi5GR3lE5S3nkpj+c5McfA+6AHXRr+J1M6P4H9DPWu3o4nkHlCdH55zlTGjZiOOI
 WSwdbNys8HDaoj0AXGnwO/SnFZDRTXxyhh5b9Bp4GOUtL9O881vwwGFkdCNN+XPulFnw
 d6oJTWfe63R/T+oIymz4CTn4N9Y6KUh/Lm/lbPI0SBxVXUrqETa9aoh0/oH22cpirN8y
 Fx1g==
X-Forwarded-Encrypted: i=1;
 AFNElJ94Y4K8phhhdCGV3E/2FsxjUUgqQzA7gR5RKmYakR6kU2UTzIyn/3CBmfDTSXX9CWQ17FY665yAU3Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwdpSXJnoiN6tjfC4Q+JyLAdGjie1WmNsmSxmRlRAB9XUro9DIr
 w3dE07rq5HI5tYlDIyCad/ozwjQefA2sn73uulQPrKFr7/+Nx27LSs8WW5nPmLfhtVhAP+m1wlq
 hJl9BUjJC8hIUv+PIShguMW5Mj10Oi4Y=
X-Gm-Gg: Acq92OEQ22rFO0cjHqeYM7OQ8vhQhRHmN6w4dU/eB+x8Z/U72LetouOBveJBza/6kw0
 n+wP3SoikP9LeV7jePEY1aiNM8g7Zm+okSKfr/Z67UL+j8Ee7rxvbC2+1RSNW1zJujsQnQrx3zl
 MxPt45oIYbjO2Sd68ZDNS9TFuZHtke2DVvDCUqtS+LmJdxIFFUuwoFo1meavMmZ2x4LWwyBSK8D
 JXWX38EXgpFrxMacrgVv2uO1OW+/OUqF9vy+SQEUzCSsQgRsrD8qkcN3o7Tvd2fDip6J1IrhMnJ
 mRK+FN+E/Ko2JK/S98RXBlJkAy17wr3uDeWa5jNRuic0rWuplHYVlAlkm48=
X-Received: by 2002:a05:6122:3102:b0:56c:ce8a:b07a with SMTP id
 71dfb90a1353d-599f2482c7emr1099623e0c.7.1780063740711; Fri, 29 May 2026
 07:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260521143624.56906-1-inki.dae@samsung.com>
 <CAPM=9twLzSJh-rHpNf-JOPBmzFnFevc6v-gu6kWfLCTPeyWLFQ@mail.gmail.com>
 <ahfv4Ox5mFZ5TPCi@phenom.ffwll.local>
In-Reply-To: <ahfv4Ox5mFZ5TPCi@phenom.ffwll.local>
From: Inki Dae <daeinki@gmail.com>
Date: Fri, 29 May 2026 23:08:24 +0900
X-Gm-Features: AVHnY4J6q80BjsvOs3e02zPCftWZaBjf3RrxpMJFV7vnSDrj-oxU7SK2s6bFheM
Message-ID: <CAAQKjZOpVCh==G8H7RUpGKDiU2hOdtoz+f-HfC3zwVbTBAbayQ@mail.gmail.com>
Subject: Re: [GIT PULL] exynos-drm-next
To: Simona Vetter <simona.vetter@ffwll.ch>
Cc: Dave Airlie <airlied@gmail.com>, airlied@linux.ie, daniel@ffwll.ch, 
 dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

2026=EB=85=84 5=EC=9B=94 28=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 4:34, S=
imona Vetter <simona.vetter@ffwll.ch>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue, May 26, 2026 at 11:01:07AM +1000, Dave Airlie wrote:
> > On Fri, 22 May 2026 at 00:36, Inki Dae <inki.dae@samsung.com> wrote:
> > >
> > > Hi Dave and Daniel,
> > >
> > >     This PR brings a cleanup and modernization series for Exynos DRM,
> > >     focused on fbdev emulation and DMA/GEM internals.
> > >
> > > Major changes are:
> > >     - migrate fbdev allocation to DRM client buffers,
> > >     - switch fbdev geometry calculations to DRM format helpers with t=
ighter checks,
> > >     - fix screen_buffer handling to match fb_info semantics,
> > >     - adopt DRM core DMA tracking and remove redundant Exynos-side co=
de.
> > >
> > > Please kindly let me know if there is any problem.
> >
> > Hi Inki,
> >
> > In file included from
> > /home/airlied/devel/kernel/dim/src/drivers/gpu/drm/exynos/exynos_drm_ge=
m.c:16:
> > /home/airlied/devel/kernel/dim/src/drivers/gpu/drm/exynos/exynos_drm_ge=
m.c:
> > In function =E2=80=98exynos_drm_alloc_buf=E2=80=99:
> > /home/airlied/devel/kernel/dim/src/drivers/gpu/drm/exynos/exynos_drm_ge=
m.c:69:49:
> > warning: format =E2=80=98%lx=E2=80=99 expects argument of type =E2=80=
=98long unsigned int=E2=80=99,
> > but argument 6 has type =E2=80=98size_t=E2=80=99 {aka =E2=80=98unsigned=
 int=E2=80=99} [-Wformat=3D]
> >    69 |         DRM_DEV_DEBUG_KMS(drm_dev_dma_dev(dev),
> > "dma_addr(0x%lx), size(0x%lx)\n",
> >       |
> > ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    70 |                         (unsigned long)exynos_gem->dma_addr,
> > exynos_gem->base.size);
> >       |
> > ~~~~~~~~~~~~~~~~~~~~~
> >       |
> >               |
> >       |
> >               size_t {aka unsigned int}
> > /home/airlied/devel/kernel/dim/src/include/drm/drm_print.h:563:39:
> > note: in definition of macro =E2=80=98drm_dev_dbg=E2=80=99
> >   563 |         __drm_dev_dbg(NULL, dev, cat, fmt, ##__VA_ARGS__)
> >       |                                       ^~~
> > /home/airlied/devel/kernel/dim/src/drivers/gpu/drm/exynos/exynos_drm_ge=
m.c:69:9:
> > note: in expansion of macro =E2=80=98DRM_DEV_DEBUG_KMS=E2=80=99
> >    69 |         DRM_DEV_DEBUG_KMS(drm_dev_dma_dev(dev),
> > "dma_addr(0x%lx), size(0x%lx)\n",
> >       |         ^~~~~~~~~~~~~~~~~
> > /home/airlied/devel/kernel/dim/src/drivers/gpu/drm/exynos/exynos_drm_ge=
m.c:69:76:
> > note: format string is defined here
> >    69 |         DRM_DEV_DEBUG_KMS(drm_dev_dma_dev(dev),
> > "dma_addr(0x%lx), size(0x%lx)\n",
> >       |
> >           ~~^
> >       |
> >             |
> >       |
> >             long unsigned int
> >       |
> >           %x
> > /home/airlied/devel/kernel/dim/src/drivers/gpu/drm/exynos/exynos_drm_ge=
m.c:
> > In function =E2=80=98exynos_drm_free_buf=E2=80=99:
> > /home/airlied/devel/kernel/dim/src/drivers/gpu/drm/exynos/exynos_drm_ge=
m.c:83:37:
> > warning: format =E2=80=98%lx=E2=80=99 expects argument of type =E2=80=
=98long unsigned int=E2=80=99,
> > but argument 6 has type =E2=80=98size_t=E2=80=99 {aka =E2=80=98unsigned=
 int=E2=80=99} [-Wformat=3D]
> >    83 |         DRM_DEV_DEBUG_KMS(dev->dev, "dma_addr(0x%lx), size(0x%l=
x)\n",
> >       |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
> >    84 |                         (unsigned long)exynos_gem->dma_addr,
> > exynos_gem->base.size);
> >       |
> > ~~~~~~~~~~~~~~~~~~~~~
> >       |
> >               |
> >       |
> >               size_t {aka unsigned int}
> > /home/airlied/devel/kernel/dim/src/include/drm/drm_print.h:563:39:
> > note: in definition of macro =E2=80=98drm_dev_dbg=E2=80=99
> >   563 |         __drm_dev_dbg(NULL, dev, cat, fmt, ##__VA_ARGS__)
> >       |                                       ^~~
> > /home/airlied/devel/kernel/dim/src/drivers/gpu/drm/exynos/exynos_drm_ge=
m.c:83:9:
> > note: in expansion of macro =E2=80=98DRM_DEV_DEBUG_KMS=E2=80=99
> >    83 |         DRM_DEV_DEBUG_KMS(dev->dev, "dma_addr(0x%lx), size(0x%l=
x)\n",
> >       |         ^~~~~~~~~~~~~~~~~
> > /home/airlied/devel/kernel/dim/src/drivers/gpu/drm/exynos/exynos_drm_ge=
m.c:83:64:
> > note: format string is defined here
> >    83 |         DRM_DEV_DEBUG_KMS(dev->dev, "dma_addr(0x%lx), size(0x%l=
x)\n",
> >       |                                                              ~~=
^
> >       |                                                                =
|
> >       |
> > long unsigned int
> >       |                                                              %x
> >
> >
> > Can you fix this up in a follow on PR?
>
> Uh, you've pushed this already and it kinda broke my workflow. I've
> applied the fixup from Arnd to sort this out. Apparently there was also a
> fixup by the original author, but that never landed in the right trees.


It looks like the same patch, commit
3470274dca4887e2b56684bd6a482097318d95a5, has already been merged.
Due to my oversight, Arnd Bergmann=E2=80=99s patch was merged instead of th=
e
original patch from Chen-Yu Tsai. I suspect that there may have been
an issue, and Arnd addressed it quickly, which resulted in his patch
being merged.

I had actually prepared Chen-Yu Tsai=E2=80=99s patch, but I appear to have
missed it while moving the patches to the next branch.

I sincerely apologize again for wasting your time.

Thanks,
Inki Dae

>
> Cheers, Sima
> --
> Simona Vetter
> Software Engineer
> http://blog.ffwll.ch
>
