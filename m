Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F365CCD6E51
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 13:42:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6735110FF5C;
	Fri, 29 May 2026 13:42:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WShJZDmS";
	dkim-atps=neutral
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com
 [209.85.217.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E05E610FF5C
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 13:42:10 +0000 (UTC)
Received: by mail-vs1-f52.google.com with SMTP id
 ada2fe7eead31-6c449ac3588so92157137.3
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 06:42:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780062130; cv=none;
 d=google.com; s=arc-20240605;
 b=iE5b0QpvdpGMmUI1ffMNhIMDYiCzfIMvU9kmOCXsB6nFewzwmDPlQzSnfTyKvDpNce
 pB/9zD9QlGHvcUaetdM686pEVsrG/8dHrxgRfmRUo/ZILGBY/XdAkTB90Rujg7FU9wfG
 K99NXwuIlWznXYVdHMAHuT1I/ixyMH6kSgyQ+BwD8GAhLJVXpp1LFU2iRJct/zPws4GZ
 hNE9FIkQZH+GRIBQ0LCbOAEkxcgb7B85T6Ky8MHJj1Om9vWCo+jKyMs26N9MuUcw1+Tk
 qH9f3azqzUgcK+nCMZ0I0vHkYZXCe58r/TIa87m7WCdE3YK0hMkTfYjX6j8z0G9NExYw
 xL0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=foZUSSCn3mw3igbjhG/ByovMp3TLwfr7Tn+8SY7PdHU=;
 fh=qmVSLiFdbluHEDZadNK2IEoDgD6laL4dhsBrnUvF4Jk=;
 b=hdsYn64HPj+uoh+1H+GyoTTaF1uOyRNaXmPxnB/FdKWR2U/g4upGVujllbsW4YZlRY
 vqObkbza8tLCHownNaUFc3FBu7cayOEc8lQomqY5Jv2jt9Fld2329xHPbkG+dJEWqveS
 CugwutmLMnINr9axSk2vZxyfLxfNAgH02/nYnSYzZE5dbIU7y8CF2Af1u1UGz2SjzxX0
 wuLHiyx5uGoSMWPmOB/bMo4mfS1NuPuFm4AJEiziOo64WMiG4BrcxelKDUNBYe40k/rD
 0kbikaHoPxKnLVXo9MuXAUzPZ0iobuDS8YDn69Y0UODEYshsf+Sswo/f/mssT6ZuMqzQ
 1uVA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780062130; x=1780666930; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=foZUSSCn3mw3igbjhG/ByovMp3TLwfr7Tn+8SY7PdHU=;
 b=WShJZDmS9gBZfkXYXwkTwCWv9YpG6whfXkxcDYymhpCieYP6aiGck7YNMKMIfnTQce
 BhVCReh5k0ow2XzhWkeiTk0YxBE3b7okZe6P0LMAfiOmCoHozXdtXUMwGY+iArQ/T2Jq
 +KCcn68wfpr5/236h+G/Ngmm66AbTDbFGfYfB3eW3/c4oAaDtMtqA2ZMVbsmCWNcs8hS
 FXLer20YCgaowYp3H7kYlwi/mvklGw791fbYJmgqwM2SQE7iQWmok5M5elOB4LXzu3IK
 RRuCiI2wlsu9gUFG5lraE/i0wks4ydIbNG/a8hC4q2ekjOeRD3a2mhEGeJGkdSwntPfq
 Ng/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780062130; x=1780666930;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=foZUSSCn3mw3igbjhG/ByovMp3TLwfr7Tn+8SY7PdHU=;
 b=QgwaEm97a3QWSWRBEP4UI3qjOV99ICzrdqHR9FI+vxNpdyemKL6Wwww4gNpSy0kQeS
 vkeCWX7JJVH/UAhbMz7ALCrxR93ZSERlsHqTiDt07fRhTL9QJhGHjWXMFrHI80uNjxta
 sleYvgOIz2Y8ZlbN4IPGIoJJkCktKIWjajAJsAUe7nK93Xs6H2N8gLMsugF4imKu0eMs
 Uu3RJFvy/nt1ioVlkGLiROROTBMyC//E5hhpjY0lRVY6VeZ2eaSbNM2A6bVao8Fc7Y+C
 MpFfuppYradG7TObG+9PggYQAnUuG0Z7x+e3ht7W4LQuUGogeNdQwDT+Xuix6SQbxUfn
 jc8A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8fRkLr9nUmxIcgCL+SU7I5E6orLgK1zzAwG3R8STApCkj95+5dwCZYZ+bmgKF53G13ycCjFWFGDnc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx+jI85JYQ32OT/Xze7oM47u0EXdSo2FC4gb4Nrl351Lb9q/8jz
 4i/LXDTgpjvJ19T8P9e0gZ40ES7j/hXPCJaQZ9HfTkKmCMZpxnxJwhSOQClLr/UJlpIjEOB5Nm0
 WKhhBNtySB8lkyojrp2oziv3Sycp7tJw=
X-Gm-Gg: Acq92OGRioGTO9a8mYFulbhJLGmrvcuKGGVP286AqKtlKMvmltxIHSYd/f9WSyTeOTO
 x1D9GqhKmboua5doO/wSeBuga/Tl1d5zjy0y/zmYzDMBvX0y5WWcA8+UX8+vjHaYg759YnI82Mo
 zoxFC5EkgLw+UriR0o/cuSwdI6u4NFjJpJv4+UseLsoeJeF1scQVHNVKvk0mxjy6m073eC02Mv5
 LSUnfxLYY7fPkUpLwhv6TuNVbUxu+XLsLImzpVqAytFHzaM6DBY3so30Mxe4TyhiBgxDgDsxAKj
 BdLHod3OjMZ/znhx9Z3VS+Tn/BuRKkEezBR+mmDKc5TeFA/t
X-Received: by 2002:a05:6102:3746:b0:636:c0c:4d91 with SMTP id
 ada2fe7eead31-6bf41448d48mr1182976137.28.1780062129815; Fri, 29 May 2026
 06:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260527194525.45762-1-arnd@kernel.org>
 <CAGXv+5HvJiTkLJMZ13w0OHwgp+nPBftGAC-15nhJ3R=vOPWpUg@mail.gmail.com>
In-Reply-To: <CAGXv+5HvJiTkLJMZ13w0OHwgp+nPBftGAC-15nhJ3R=vOPWpUg@mail.gmail.com>
From: Inki Dae <daeinki@gmail.com>
Date: Fri, 29 May 2026 22:41:34 +0900
X-Gm-Features: AVHnY4JvF7WCaYgOFVyNLTbyQStc4V3bgFlseC90wq5uN90mEmMwAwiliM8N3JY
Message-ID: <CAAQKjZNoGC_9ratL7+FjNiQk+MkOE7p=yg5ECQA+ih1trGw8cA@mail.gmail.com>
Subject: Re: [PATCH] drm/exynos: fix size_t format string
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, Arnd Bergmann <arnd@arndb.de>, 
 Alim Akhtar <alim.akhtar@samsung.com>, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
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

2026=EB=85=84 5=EC=9B=94 28=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 6:05, C=
hen-Yu Tsai <wenst@chromium.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Wed, May 27, 2026 at 9:45=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> w=
rote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The exynos_gem->base.size argument is a size_t rather than an
> > unsigned long, so adapt the printk() format string accordingly:
> >
> > In file included from drivers/gpu/drm/exynos/exynos_drm_gem.c:16:
> > drivers/gpu/drm/exynos/exynos_drm_gem.c: In function 'exynos_drm_alloc_=
buf':
> > drivers/gpu/drm/exynos/exynos_drm_gem.c:69:49: error: format '%lx' expe=
cts argument of type 'long unsigned int', but argument 6 has type 'size_t' =
{aka 'unsigned int'} [-Werror=3Dformat=3D]
> >    69 |         DRM_DEV_DEBUG_KMS(drm_dev_dma_dev(dev), "dma_addr(0x%lx=
), size(0x%lx)\n",
> >       |                                                 ^~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~
> >    70 |                         (unsigned long)exynos_gem->dma_addr, ex=
ynos_gem->base.size);
> >       |                                                              ~~=
~~~~~~~~~~~~~~~~~~~
> >       |                                                                =
              |
> >       |                                                                =
              size_t {aka unsigned int}
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

Really sorry for this. I missed your patch.

Thanks,
inki Dae

>
> And it seems the exynos-drm-next stuff was only merged into drm-next
> yesterday, now causing the warnings to pop up all over.
>
> ChenYu
>
> [1] https://lore.kernel.org/all/20260408064936.1342321-1-wenst@chromium.o=
rg/
>
> > ---
> >  drivers/gpu/drm/exynos/exynos_drm_gem.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.c b/drivers/gpu/drm/=
exynos/exynos_drm_gem.c
> > index 297a93b087cd..8e357f2beb9e 100644
> > --- a/drivers/gpu/drm/exynos/exynos_drm_gem.c
> > +++ b/drivers/gpu/drm/exynos/exynos_drm_gem.c
> > @@ -66,8 +66,8 @@ static int exynos_drm_alloc_buf(struct exynos_drm_gem=
 *exynos_gem, bool kvmap)
> >         if (kvmap)
> >                 exynos_gem->kvaddr =3D exynos_gem->cookie;
> >
> > -       DRM_DEV_DEBUG_KMS(drm_dev_dma_dev(dev), "dma_addr(0x%lx), size(=
0x%lx)\n",
> > -                       (unsigned long)exynos_gem->dma_addr, exynos_gem=
->base.size);
> > +       DRM_DEV_DEBUG_KMS(drm_dev_dma_dev(dev), "dma_addr(%pad), size(0=
x%zx)\n",
> > +                         &exynos_gem->dma_addr, exynos_gem->base.size)=
;
> >         return 0;
> >  }
> >
> > @@ -80,8 +80,8 @@ static void exynos_drm_free_buf(struct exynos_drm_gem=
 *exynos_gem)
> >                 return;
> >         }
> >
> > -       DRM_DEV_DEBUG_KMS(dev->dev, "dma_addr(0x%lx), size(0x%lx)\n",
> > -                       (unsigned long)exynos_gem->dma_addr, exynos_gem=
->base.size);
> > +       DRM_DEV_DEBUG_KMS(dev->dev, "dma_addr(0x%pad), size(0x%zx)\n",
> > +                         &exynos_gem->dma_addr, exynos_gem->base.size)=
;
> >
> >         dma_free_attrs(drm_dev_dma_dev(dev), exynos_gem->base.size, exy=
nos_gem->cookie,
> >                         (dma_addr_t)exynos_gem->dma_addr,
> > --
> > 2.39.5
> >
>
