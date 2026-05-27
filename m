Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBAE5CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 21:05:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BB4010EA1A;
	Wed, 27 May 2026 21:05:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Veh7pocW";
	dkim-atps=neutral
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com
 [209.85.167.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 357D510EA1A
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 21:05:13 +0000 (UTC)
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-5a8cb92f26aso13130580e87.1
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 14:05:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779915911; cv=none;
 d=google.com; s=arc-20240605;
 b=FAAsHqOkRQ+HPHj7Wqv7L92A0KASY3rbwnQtBoTyWNHCGzbwsEPyAKqNYdi+DH4YyK
 6m4xhC9yunJzNqPrUE/EzZ4Hz5JMpLnAeCIB0+T1ZvIr9ryQPGhMi7FL8Gmiae8p7VDG
 QflnLXpznMd7faJbBV1WWMUJ44ubUksuTHPcjXRmWBXst5gZuKml4d6O9Lvd7yZkWCkZ
 CIHMGJMW4WpIJ3lbMToqHeBq3Vrz9M+r3hKJ2PBaDzAX+vMUpVsQTgH/l+rRtsG3LSgO
 4AsPtaj6LD9sm8x2B3E0pb4W4ZoGrqC/086mad+o1sVrNts57KnZgq0uBfqUJfZxSUm3
 DroQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=klhpPa38J0whnw5RO/BZGOXxuOqg7LvqNeDQIX9ReEM=;
 fh=JC/6s10ijwnRL+F4eSwajir3mZ7azL8EBGqv7yDsedU=;
 b=fpReD8SPZD4TkKJPtF5tC+BWBxODS9eporToSj13E7+jcfUQOtB1f8ovveSu5CDZdh
 eKmiZDKVe4C0bvzXdgbSr1BzV/F+L5Z5VT0JKDhCmff2bYbbv9XE6bxAVbFru9OHxSUo
 vsQaN0TaexU3CwBG6plv/VTJQ8S13QQE0gLpyvJhdInEwDS1mIYL6Hp+M9zE/OzKeBMi
 beqatchiEhbSv4YEoybC1gnqFSXlSCJK9bih6C1XOZaV2kMytHjgCALrLtIPhjf86hIf
 EQP+a4JA4ZAj/BYWQUH3Aqemkh+N5t06oYv58X9/Jtga7vsl66tHBUE5M68iltAKLHw9
 9AIA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779915911; x=1780520711;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=klhpPa38J0whnw5RO/BZGOXxuOqg7LvqNeDQIX9ReEM=;
 b=Veh7pocWtaOUdl/h2Z7pnKq5dfWCeCsL4rwLGRlrPIYiVnZkFMyyRwc8z3PjkoJnup
 inoLB6mVVRYfsKJVZJqRSTyn29dMqlY90nuHYPMNy+vY3bY88BWpjlCzjWvAwMx9rjhO
 udDtw0rSy9qcyRmcHuHXHDQJAzclBR4JHQifk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779915911; x=1780520711;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=klhpPa38J0whnw5RO/BZGOXxuOqg7LvqNeDQIX9ReEM=;
 b=sTvZWGprmFrjnCh5OQtBP343hdHZW0o1duTv81DCZihQHJ0GWXL39HMB06V3QPwQo0
 vwrsYxlVnvIIC68Lr7C0/DxJnBfQk4vzphdyxjtUsIEzAcNR8M64cSzvg78VDnjSMIgj
 R+7yQtLfPHUoRr1960srYKkU1/f7FkwMb296T8dYhU9SLoZxVUM57l2VytxMzKEb/iqY
 Bnfi7gZ9q/Ve39XtDXr3QQdPRswqnIz416SVXzDUhA3O96kM9UTM/5+PwVp45XGUWfBp
 1dG6T+xgRr9HGJq/72QADiUmQ0c1QlEnNaunjMcyFzC0ej0i02qR6UaUbNWh+AyQPM9F
 QGOA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9u0jW77KhJ1R6C+y9cjc9vjTqgjKZePltqbZTZRjcE0M2Cjqmn9+62J26yiUgoSyo3hJqGWoYBHO8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyS9Sq5nZudYmA8kopBpFM6K7+d+Vtt7BKCdF3IwCze6ndRLMvx
 9M1H8petgJ7/js5DfL2+oj5SjloTKgyekh4RTVzRiK4po1ZW3u86UMAKnJZaJtnVXbsB4DSymB8
 GcdjE1Uoc3KVGBk0TS6vlpV35DpTExBIhpXWu2pyi
X-Gm-Gg: Acq92OGMAnGaxvI+GCaqbYaVidf4ZqGHkKX9FDPXQmulu6JJpksVzmV9CaXvlPxR0PQ
 vXjMU0uDUPSrd2SjGpzNHu2kVar+CBj/1rELn9FitKSDDwIesVx9grHZ0EBYgFBCBV6Bcoj8SLO
 q7oCV77K+8OIP3q5YMmDxQSD/yCn7IGZpqTH2nJg6LhnLFUWIe+yXiTzL1LiFhPXtSqE8w3yWwy
 bBFzoKEF6QJXk5iDbBMnEmU8jHCV3VbKOYqyVNFHS3bLgckImOeQaGDbA3yASfwbIaLwVM+8OCO
 PeQsWDZiDZJ0YbWWvA==
X-Received: by 2002:a05:6512:65dc:10b0:5a4:1902:3d17 with SMTP id
 2adb3069b0e04-5aa3239b51emr5764637e87.12.1779915911516; Wed, 27 May 2026
 14:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260326094308.1161335-1-wenst@chromium.org>
 <20260326094308.1161335-4-wenst@chromium.org>
 <fa11e295-c3a2-4baf-a7d6-a290a4255ca6@sirena.org.uk>
In-Reply-To: <fa11e295-c3a2-4baf-a7d6-a290a4255ca6@sirena.org.uk>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 27 May 2026 23:04:59 +0200
X-Gm-Features: AVHnY4LEGpZKQecMkzAfBGdO7O4dM-_0AAlkjrus41LuLxUrwJWQv5-AV3HxcEY
Message-ID: <CAGXv+5GC_fxarWMgsAyZ2553codJg4U9A7KChjZpmiQp2NGSjQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm/exynos: Drop exynos_drm_gem.size field
To: Mark Brown <broonie@kernel.org>, Inki Dae <inki.dae@samsung.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Aishwarya.TCV@arm.com, 
 Arnd Bergmann <arnd@kernel.org>
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

On Wed, May 27, 2026 at 7:19=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Thu, Mar 26, 2026 at 05:43:05PM +0800, Chen-Yu Tsai wrote:
> > A size field is already included in the base GEM object, and is
> > initialized through drm_gem_object_init() with the same value.
> >
> > Drop the field in the subclass to save some space. More changes to
> > make exynos_drm_gem a subclass of drm_gem_dma_object will follow.
>
> I'm seeing warnings on arm multi_v7_defconfig which also show up in
> other CI which seem to be due to this commit, the type of the size field
> is different so the format specifiers need updating or casts adding:

I posted a fix for this one and a half months ago when the culprit
patch was queued up and I got a report about this from the bots.

Inki hasn't picked up my fix yet. Arnd posted the same fix today.

And it seems the exynos-drm-next stuff was only merged into drm-next
yesterday, now causing the warnings to pop up all over.


ChenYu



> CC [M]  drivers/gpu/drm/exynos/exynos_drm_gem.o
> CC [M]  drivers/gpu/drm/nouveau/nvkm/subdev/acr/ga102.o
> In file included from ../drivers/gpu/drm/exynos/exynos_drm_gem.c:16:
> ../drivers/gpu/drm/exynos/exynos_drm_gem.c: In function 'exynos_drm_alloc=
_buf':
> ../drivers/gpu/drm/exynos/exynos_drm_gem.c:69:49: warning: format '%lx' e=
xpects argument of type 'long unsigned int', but argument 6 has type 'size_=
t' {aka 'unsigned int'} [-Wformat=3D]
> 69 |         DRM_DEV_DEBUG_KMS(drm_dev_dma_dev(dev), "dma_addr(0x%lx), si=
ze(0x%lx)\n",
>       |                                                 ^~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~
> 70 |                         (unsigned long)exynos_gem->dma_addr, exynos_=
gem->base.size);
>       |                                                              ~~~~=
~~~~~~~~~~~~~~~~~
>       |                                                                  =
            |
>       |                                                                  =
            size_t {aka unsigned int}
> ../include/drm/drm_print.h:563:39: note: in definition of macro 'drm_dev_=
dbg'
> 563 |         __drm_dev_dbg(NULL, dev, cat, fmt, ##__VA_ARGS__)
>       |                                       ^~~
> ../drivers/gpu/drm/exynos/exynos_drm_gem.c:69:9: note: in expansion of ma=
cro 'DRM_DEV_DEBUG_KMS'
> 69 |         DRM_DEV_DEBUG_KMS(drm_dev_dma_dev(dev), "dma_addr(0x%lx), si=
ze(0x%lx)\n",
>       |         ^~~~~~~~~~~~~~~~~
> ../drivers/gpu/drm/exynos/exynos_drm_gem.c:69:76: note: format string is =
defined here
> 69 |         DRM_DEV_DEBUG_KMS(drm_dev_dma_dev(dev), "dma_addr(0x%lx), si=
ze(0x%lx)\n",
>       |                                                                  =
        ~~^
>       |                                                                  =
          |
>       |                                                                  =
          long unsigned int
>       |                                                                  =
        %x
> ../drivers/gpu/drm/exynos/exynos_drm_gem.c: In function 'exynos_drm_free_=
buf':
> ../drivers/gpu/drm/exynos/exynos_drm_gem.c:83:37: warning: format '%lx' e=
xpects argument of type 'long unsigned int', but argument 6 has type 'size_=
t' {aka 'unsigned int'} [-Wformat=3D]
> 83 |         DRM_DEV_DEBUG_KMS(dev->dev, "dma_addr(0x%lx), size(0x%lx)\n"=
,
>       |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
> 84 |                         (unsigned long)exynos_gem->dma_addr, exynos_=
gem->base.size);
>       |                                                              ~~~~=
~~~~~~~~~~~~~~~~~
>       |                                                                  =
            |
>       |                                                                  =
            size_t {aka unsigned int}
> ../include/drm/drm_print.h:563:39: note: in definition of macro 'drm_dev_=
dbg'
> 563 |         __drm_dev_dbg(NULL, dev, cat, fmt, ##__VA_ARGS__)
>       |                                       ^~~
> ../drivers/gpu/drm/exynos/exynos_drm_gem.c:83:9: note: in expansion of ma=
cro 'DRM_DEV_DEBUG_KMS'
> 83 |         DRM_DEV_DEBUG_KMS(dev->dev, "dma_addr(0x%lx), size(0x%lx)\n"=
,
>       |         ^~~~~~~~~~~~~~~~~
> ../drivers/gpu/drm/exynos/exynos_drm_gem.c:83:64: note: format string is =
defined here
> 83 |         DRM_DEV_DEBUG_KMS(dev->dev, "dma_addr(0x%lx), size(0x%lx)\n"=
,
>       |                                                              ~~^
>       |                                                                |
>       |                                                                lo=
ng unsigned int
>       |                                                              %x
> CC [M]  drivers/gpu/drm/rockchip/rockchip_drm_vop.o
> CC [M]  drivers/gpu/drm/exynos/exynos_drm_plane.o
