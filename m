Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D92ECD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 01:01:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66D0110E427;
	Tue, 26 May 2026 01:01:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y0lI66Tb";
	dkim-atps=neutral
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5ABD10E427
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 01:01:19 +0000 (UTC)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-8bc3ef10cc4so137079206d6.1
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 18:01:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779757279; cv=none;
 d=google.com; s=arc-20240605;
 b=JEh1Ctoaq96naA4HRWov7V97bwJvZRTt5U9K05QWSn55akgK7lL8yfvCb6Q6uuE+Na
 Yy/mbSmyaU4xdtmI4rUjXU6NQcszLxbDTGBDRLImuQto64udtnsozBqn1p8QF8Ar8Ari
 G6M3hfO3n+Bsl785vOdiHJbDUOo0eDGjLk/dMA0CeQAFKZihEUZGEDn/CCQqsgtCXmRl
 Nc/IIp3S8cYH+AEHKbrx7zu6KFEgsIlyVHYlC6d5/EYpsDVaTiy4t7z+9sKyniyWc6ZV
 xYM/la2ccHzsizZs2/6eL8EPQKeAM85RTKMtt7looY1ZU9/Hm/jdjENxATa37okyDW+f
 r+eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WkoDOmIQ5Hj2yranYHm7ebfBS7cyHn6dxBl0N9prozU=;
 fh=S2me9wrktfMQS8G7/2vDFMXCpISpg614ljtiyzvVXq4=;
 b=IvwJ6QibLlptjfzAuBIBaL7EELU+feDihg8AzIg6OF9SuL964EAg/BZZwnSmIoyJ+8
 UK35JoJYvcKKehFDKP2ImBtLP77FPeuxPENWz4RMFS3mJzaPA8gw0nP53ViHih3463GC
 D2CPJBlFaX6zn61ISR+oO+lsWn/i0cgzBSJPRrHKBrpFBm7D7CqYWJIQHdp0fMD6Wonr
 zF9V40Qyxyd7zM78/t5kZ2gPNopvtF5Au1Qqs5+fmJs6NJsJQ1Tc/PTSF42trGEV5fMZ
 2H8iUSgIKllMdwtuJCU1c4KA8urgutLI1gCKva4Vv/WzsPL3u5u0k8bh0D+D1Lg6x8te
 SY2Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779757279; x=1780362079; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WkoDOmIQ5Hj2yranYHm7ebfBS7cyHn6dxBl0N9prozU=;
 b=Y0lI66TbRZfz6I5gm7iBttp6TZB45pVH5PAOYFgp97jcga5gnUKDAWQYR2jdBLNK2W
 p6rGEmLXsbfgGK76eIXEhucjJy/TYVbNGXdPkvActAwUhbd2gM/0XjdUzM4y3e0v1jjd
 BfZCKMEuyQZnzBomZ2/xpQKsidedl/78TJQlEsYh/evr/QtQKOQq4ktvZ7pDVpSq5Ehj
 5nCK2Keyl39ozkiwkSmgb5gxwr02gEv77SaMcr9GBJTKY7YYxIuGLe32h1UmZC5Gx9PO
 j0+ebuL1pdpbjk++GPhllbcTrgsgVDeXt5F9qvOcJrlnEv7tck2YyA0ROffsQeH+h1JV
 F8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779757279; x=1780362079;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WkoDOmIQ5Hj2yranYHm7ebfBS7cyHn6dxBl0N9prozU=;
 b=bKEgUSmbvlc8ngoE0thfJvGsxJWuXStU+uKigd6IETfy+rSFJpmeKONgiiWdGexaOm
 hDuN/7aDo4cwHE/DG1+n1TBduNHm2feREo/HuF+9+rgFrM2mVGOF+0P3hs2bgM5OjObE
 xxLJLIIKG/IUDyvEeD6rWjgPDrdeeDvlk3c6LWbv9TVpLepCWpRohF9VcWFLLYy771Ul
 GBZG8pmEfNgwLU9nj8df3Kmcap1lxZFo5zR1hyr3XzVE18NVApBO/8/cjhREEB58Jf6X
 WIcRdyykHrIg/q7Y9R5xFaM45HbP1kMLt+0Ei2gTo94o/vFOqXf0N6fuTZZp/Xms/i8A
 Zi4A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+xFWysjkLlWhCLSiNGrJgXpedvIOK90Ku3vSgPASmX1ZBbRTYKJun2yxVG3Ubaz3KnrdMv1QPPx2A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyY65JlbNvfA6muML+XHRBMMhxdTuHnkp+VUDQqzK84JlPm6aHC
 /IxhdY4cPD/92TF6Y85z/afsgCbbKSTLLNniVW9RCe/EnEU5xgL5yotK8LuW9m1S2BD9ETYF2mn
 22+pX1q8msbX7wdjiAqdhExYiu3/WRkU=
X-Gm-Gg: Acq92OGYz7EeL0xgB6+1LsKJEDK+BP3AnHic3AJMSfY38/yWAo6pfmOb1yjKWhaUV4v
 elUSWNOAbUkCm7K+85zCnSzItE6Wif16V5ggCX7ljWRM0RW8C69KgzJV1IyPP0/aCTOkv2cBm0H
 ojQMWXcq1Zu+l20KQ8/vSYXQpuRBP/xZqGFlVdhwRLRA+HzLVmkyNOE811VlKN1XhriMcTLr5yl
 N0AKA6yG+7T3cDZrd/ziE3x0PKCU+FI2YtS/juYGuqhIwKB1AUTRwXTvR+fGgX5+f5Aa/BbS9O7
 rC7UyVccxKoWf/NjEUtGCRbgIduop+GsP0L5888bz4EZ43dXglKSr/ktLt7UxzkrcxI=
X-Received: by 2002:ad4:5cce:0:b0:8a0:7c8:409b with SMTP id
 6a1803df08f44-8cc7b5c7ab0mr282601246d6.33.1779757278711; Mon, 25 May 2026
 18:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260521143624.56906-1-inki.dae@samsung.com>
In-Reply-To: <20260521143624.56906-1-inki.dae@samsung.com>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 26 May 2026 11:01:07 +1000
X-Gm-Features: AVHnY4L_jkvbJSgFydFCJJxizdKRbh_UeuepOxjo5-N1eR69ce0-W7oMKRR46qM
Message-ID: <CAPM=9twLzSJh-rHpNf-JOPBmzFnFevc6v-gu6kWfLCTPeyWLFQ@mail.gmail.com>
Subject: Re: [GIT PULL] exynos-drm-next
To: Inki Dae <inki.dae@samsung.com>
Cc: airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
 linux-samsung-soc@vger.kernel.org
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

On Fri, 22 May 2026 at 00:36, Inki Dae <inki.dae@samsung.com> wrote:
>
> Hi Dave and Daniel,
>
>     This PR brings a cleanup and modernization series for Exynos DRM,
>     focused on fbdev emulation and DMA/GEM internals.
>
> Major changes are:
>     - migrate fbdev allocation to DRM client buffers,
>     - switch fbdev geometry calculations to DRM format helpers with tight=
er checks,
>     - fix screen_buffer handling to match fb_info semantics,
>     - adopt DRM core DMA tracking and remove redundant Exynos-side code.
>
> Please kindly let me know if there is any problem.

Hi Inki,

In file included from
/home/airlied/devel/kernel/dim/src/drivers/gpu/drm/exynos/exynos_drm_gem.c:=
16:
/home/airlied/devel/kernel/dim/src/drivers/gpu/drm/exynos/exynos_drm_gem.c:
In function =E2=80=98exynos_drm_alloc_buf=E2=80=99:
/home/airlied/devel/kernel/dim/src/drivers/gpu/drm/exynos/exynos_drm_gem.c:=
69:49:
warning: format =E2=80=98%lx=E2=80=99 expects argument of type =E2=80=98lon=
g unsigned int=E2=80=99,
but argument 6 has type =E2=80=98size_t=E2=80=99 {aka =E2=80=98unsigned int=
=E2=80=99} [-Wformat=3D]
   69 |         DRM_DEV_DEBUG_KMS(drm_dev_dma_dev(dev),
"dma_addr(0x%lx), size(0x%lx)\n",
      |
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   70 |                         (unsigned long)exynos_gem->dma_addr,
exynos_gem->base.size);
      |
~~~~~~~~~~~~~~~~~~~~~
      |
              |
      |
              size_t {aka unsigned int}
/home/airlied/devel/kernel/dim/src/include/drm/drm_print.h:563:39:
note: in definition of macro =E2=80=98drm_dev_dbg=E2=80=99
  563 |         __drm_dev_dbg(NULL, dev, cat, fmt, ##__VA_ARGS__)
      |                                       ^~~
/home/airlied/devel/kernel/dim/src/drivers/gpu/drm/exynos/exynos_drm_gem.c:=
69:9:
note: in expansion of macro =E2=80=98DRM_DEV_DEBUG_KMS=E2=80=99
   69 |         DRM_DEV_DEBUG_KMS(drm_dev_dma_dev(dev),
"dma_addr(0x%lx), size(0x%lx)\n",
      |         ^~~~~~~~~~~~~~~~~
/home/airlied/devel/kernel/dim/src/drivers/gpu/drm/exynos/exynos_drm_gem.c:=
69:76:
note: format string is defined here
   69 |         DRM_DEV_DEBUG_KMS(drm_dev_dma_dev(dev),
"dma_addr(0x%lx), size(0x%lx)\n",
      |
          ~~^
      |
            |
      |
            long unsigned int
      |
          %x
/home/airlied/devel/kernel/dim/src/drivers/gpu/drm/exynos/exynos_drm_gem.c:
In function =E2=80=98exynos_drm_free_buf=E2=80=99:
/home/airlied/devel/kernel/dim/src/drivers/gpu/drm/exynos/exynos_drm_gem.c:=
83:37:
warning: format =E2=80=98%lx=E2=80=99 expects argument of type =E2=80=98lon=
g unsigned int=E2=80=99,
but argument 6 has type =E2=80=98size_t=E2=80=99 {aka =E2=80=98unsigned int=
=E2=80=99} [-Wformat=3D]
   83 |         DRM_DEV_DEBUG_KMS(dev->dev, "dma_addr(0x%lx), size(0x%lx)\n=
",
      |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
   84 |                         (unsigned long)exynos_gem->dma_addr,
exynos_gem->base.size);
      |
~~~~~~~~~~~~~~~~~~~~~
      |
              |
      |
              size_t {aka unsigned int}
/home/airlied/devel/kernel/dim/src/include/drm/drm_print.h:563:39:
note: in definition of macro =E2=80=98drm_dev_dbg=E2=80=99
  563 |         __drm_dev_dbg(NULL, dev, cat, fmt, ##__VA_ARGS__)
      |                                       ^~~
/home/airlied/devel/kernel/dim/src/drivers/gpu/drm/exynos/exynos_drm_gem.c:=
83:9:
note: in expansion of macro =E2=80=98DRM_DEV_DEBUG_KMS=E2=80=99
   83 |         DRM_DEV_DEBUG_KMS(dev->dev, "dma_addr(0x%lx), size(0x%lx)\n=
",
      |         ^~~~~~~~~~~~~~~~~
/home/airlied/devel/kernel/dim/src/drivers/gpu/drm/exynos/exynos_drm_gem.c:=
83:64:
note: format string is defined here
   83 |         DRM_DEV_DEBUG_KMS(dev->dev, "dma_addr(0x%lx), size(0x%lx)\n=
",
      |                                                              ~~^
      |                                                                |
      |
long unsigned int
      |                                                              %x


Can you fix this up in a follow on PR?

Dave.
