Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42BD5CD5BD5
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 07:33:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BCDC10ED30;
	Thu, 28 May 2026 07:33:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="dlcFFsso";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40DDD10ED30
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 07:33:57 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so130892285e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 00:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1779953636; x=1780558436; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HaYzHO++GhEFXQR1JkiMJsWACEcNpxKT9x8Fc4Oq/Ck=;
 b=dlcFFssonXgvRn+4zHfmbLxq9Mla5EOtsH0Fnjns04VopqGW9/EdI6PymGqD5SSznz
 r4DiiwuVP36yZ2+ECdFGrzjtv+xKQCqddrP4zk6OSlYQWos9HxR2Fd3hXRbS1I+9VPxD
 mzTceJCCV/q65VQLJwbHutinv+3bLXENUTTgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779953636; x=1780558436;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HaYzHO++GhEFXQR1JkiMJsWACEcNpxKT9x8Fc4Oq/Ck=;
 b=LuiiansBJPxWjH9gm+nSMBp2qDykmvlPj9qNAVbxFZcbbMdjdy7pR6aFaR4Rv43hH3
 E5zp6SbRG+2dYiQArdsPqLbu0s9LU+Sf/KnXazsWH8Vl1dVxVMZwjy0K1vALwFoAYUJO
 Y8bNvPe+K1cyQpZw7H5lWZb0vm6kyOJj66ZazcZBy5UH1k1LkBTUzOFX09OeruI7yaLG
 ZZMy98gBthpMMafIQ5DdvtoGlozCNbs/Xqr5kNks74XAgFDsF2TWCE+yH86pEaZNuIkU
 Q12nqKFEfCbBWVfRr2dEjBj4DiurtpNRnNAK/LXUSiSil++uPlkwtHxIpCj3v4g/4Mfn
 WwUw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8YKy2NG3huV6CSio9v/SQE73CKOkZ7Si744jj37dNjrUwOc5+1wyd4BzIlKbFnVv+TdyLsERvdJ1s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YysMgDx5YcP1HejI5NCx1bJMJEv96ucaayagVzxhMqxK7rynFz+
 0pP7J2UUJKmZRAQckC4aE9+z6Y+FlnTCI+Mp8piBZDFtDUVvFmW8lR+uwI2ch55U5kve1zcCm7u
 vfv2WaZY=
X-Gm-Gg: Acq92OG8PiXUnSMAsjMwCNTXSZnYbY9McyldkF4SuAY5s06uTOdpYZ4qIx06CKGEwyY
 9EqjFe89Nr1skWAtn6ukffrKkWtZ201FepvURM1Y8e3NmG8n35T82JltzRZlBN3d4JZOlU5E9ug
 lBKB0MnkG64tnE5WPYsjb/CHBlJMGkvsiIYXXIIpQKgXT5qQVB4E5qhuiySy2kQrj0NP+btA1/r
 mWgexIZ2727rV9pRXq6a+AVnE8QZ+Bat/yfgs4hB6IrejE9eevkIlzHp+/NfbDIOPThtMUYKf++
 mDwx3xEyfZF1rHAq7Jy7dfLUxQhmSicAn1vKKbumYBgufrEAhJ3H10HjaZq8yxIO44ECcBOq5RT
 1ZBeHtnOeanKX6/l8FzvI60jqDy7LS8iOhSCdwI8yXYuyhgWW6JTDIfQe+5rswIt9t/SOSoUjdl
 gRGeZJRdesyjdLSpMDqJBmvdxAIHcy/JpvKAhw5eChErzF+U9w42CnaaPL
X-Received: by 2002:a05:600c:674a:b0:490:5057:f5f7 with SMTP id
 5b1f17b1804b1-49050580a91mr371954875e9.11.1779953635635; 
 Thu, 28 May 2026 00:33:55 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4908b8aa05esm11520965e9.13.2026.05.28.00.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 00:33:54 -0700 (PDT)
Date: Thu, 28 May 2026 09:33:52 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Dave Airlie <airlied@gmail.com>
Cc: Inki Dae <inki.dae@samsung.com>, airlied@linux.ie, daniel@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [GIT PULL] exynos-drm-next
Message-ID: <ahfv4Ox5mFZ5TPCi@phenom.ffwll.local>
References: <20260521143624.56906-1-inki.dae@samsung.com>
 <CAPM=9twLzSJh-rHpNf-JOPBmzFnFevc6v-gu6kWfLCTPeyWLFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPM=9twLzSJh-rHpNf-JOPBmzFnFevc6v-gu6kWfLCTPeyWLFQ@mail.gmail.com>
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

On Tue, May 26, 2026 at 11:01:07AM +1000, Dave Airlie wrote:
> On Fri, 22 May 2026 at 00:36, Inki Dae <inki.dae@samsung.com> wrote:
> >
> > Hi Dave and Daniel,
> >
> >     This PR brings a cleanup and modernization series for Exynos DRM,
> >     focused on fbdev emulation and DMA/GEM internals.
> >
> > Major changes are:
> >     - migrate fbdev allocation to DRM client buffers,
> >     - switch fbdev geometry calculations to DRM format helpers with tighter checks,
> >     - fix screen_buffer handling to match fb_info semantics,
> >     - adopt DRM core DMA tracking and remove redundant Exynos-side code.
> >
> > Please kindly let me know if there is any problem.
> 
> Hi Inki,
> 
> In file included from
> /home/airlied/devel/kernel/dim/src/drivers/gpu/drm/exynos/exynos_drm_gem.c:16:
> /home/airlied/devel/kernel/dim/src/drivers/gpu/drm/exynos/exynos_drm_gem.c:
> In function ‘exynos_drm_alloc_buf’:
> /home/airlied/devel/kernel/dim/src/drivers/gpu/drm/exynos/exynos_drm_gem.c:69:49:
> warning: format ‘%lx’ expects argument of type ‘long unsigned int’,
> but argument 6 has type ‘size_t’ {aka ‘unsigned int’} [-Wformat=]
>    69 |         DRM_DEV_DEBUG_KMS(drm_dev_dma_dev(dev),
> "dma_addr(0x%lx), size(0x%lx)\n",
>       |
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    70 |                         (unsigned long)exynos_gem->dma_addr,
> exynos_gem->base.size);
>       |
> ~~~~~~~~~~~~~~~~~~~~~
>       |
>               |
>       |
>               size_t {aka unsigned int}
> /home/airlied/devel/kernel/dim/src/include/drm/drm_print.h:563:39:
> note: in definition of macro ‘drm_dev_dbg’
>   563 |         __drm_dev_dbg(NULL, dev, cat, fmt, ##__VA_ARGS__)
>       |                                       ^~~
> /home/airlied/devel/kernel/dim/src/drivers/gpu/drm/exynos/exynos_drm_gem.c:69:9:
> note: in expansion of macro ‘DRM_DEV_DEBUG_KMS’
>    69 |         DRM_DEV_DEBUG_KMS(drm_dev_dma_dev(dev),
> "dma_addr(0x%lx), size(0x%lx)\n",
>       |         ^~~~~~~~~~~~~~~~~
> /home/airlied/devel/kernel/dim/src/drivers/gpu/drm/exynos/exynos_drm_gem.c:69:76:
> note: format string is defined here
>    69 |         DRM_DEV_DEBUG_KMS(drm_dev_dma_dev(dev),
> "dma_addr(0x%lx), size(0x%lx)\n",
>       |
>           ~~^
>       |
>             |
>       |
>             long unsigned int
>       |
>           %x
> /home/airlied/devel/kernel/dim/src/drivers/gpu/drm/exynos/exynos_drm_gem.c:
> In function ‘exynos_drm_free_buf’:
> /home/airlied/devel/kernel/dim/src/drivers/gpu/drm/exynos/exynos_drm_gem.c:83:37:
> warning: format ‘%lx’ expects argument of type ‘long unsigned int’,
> but argument 6 has type ‘size_t’ {aka ‘unsigned int’} [-Wformat=]
>    83 |         DRM_DEV_DEBUG_KMS(dev->dev, "dma_addr(0x%lx), size(0x%lx)\n",
>       |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    84 |                         (unsigned long)exynos_gem->dma_addr,
> exynos_gem->base.size);
>       |
> ~~~~~~~~~~~~~~~~~~~~~
>       |
>               |
>       |
>               size_t {aka unsigned int}
> /home/airlied/devel/kernel/dim/src/include/drm/drm_print.h:563:39:
> note: in definition of macro ‘drm_dev_dbg’
>   563 |         __drm_dev_dbg(NULL, dev, cat, fmt, ##__VA_ARGS__)
>       |                                       ^~~
> /home/airlied/devel/kernel/dim/src/drivers/gpu/drm/exynos/exynos_drm_gem.c:83:9:
> note: in expansion of macro ‘DRM_DEV_DEBUG_KMS’
>    83 |         DRM_DEV_DEBUG_KMS(dev->dev, "dma_addr(0x%lx), size(0x%lx)\n",
>       |         ^~~~~~~~~~~~~~~~~
> /home/airlied/devel/kernel/dim/src/drivers/gpu/drm/exynos/exynos_drm_gem.c:83:64:
> note: format string is defined here
>    83 |         DRM_DEV_DEBUG_KMS(dev->dev, "dma_addr(0x%lx), size(0x%lx)\n",
>       |                                                              ~~^
>       |                                                                |
>       |
> long unsigned int
>       |                                                              %x
> 
> 
> Can you fix this up in a follow on PR?

Uh, you've pushed this already and it kinda broke my workflow. I've
applied the fixup from Arnd to sort this out. Apparently there was also a
fixup by the original author, but that never landed in the right trees.

Cheers, Sima
-- 
Simona Vetter
Software Engineer
http://blog.ffwll.ch
