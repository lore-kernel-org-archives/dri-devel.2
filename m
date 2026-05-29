Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE5CCD4F54
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 13:51:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15CA810E37B;
	Fri, 29 May 2026 13:51:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jnLBcOyj";
	dkim-atps=neutral
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com
 [209.85.217.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EA1810E37B
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 13:51:11 +0000 (UTC)
Received: by mail-vs1-f54.google.com with SMTP id
 ada2fe7eead31-6314d2e31d6so4788232137.0
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 06:51:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780062670; cv=none;
 d=google.com; s=arc-20240605;
 b=Ecgn40WAqi3+OEG5hENKVjuWNrTv+/0NvyggPQR6MQxwcdrytsTn1le7Z3u3WGg3c2
 azOXXhAbXkqtDOq1sPUlUDXl4LWSJj73UAJVUqAOtIlGyMNrHMTU56+tY5iTANMfgNQI
 mbkub2eDvMORyCdzeyCqLiE4LLNtzduZC4qpav1wi2g+6iFdtYvcpojqn1+u24Xbljc3
 FcMKJ0puO+shwxliio/JBs3ki4qQ/awbXiPZ6OZoKyfbP2snxQXEvGPSvKM6SaW3wetk
 13sDuqEWgHsVEuV5/1+5SuzwnLvbf9diHcR4dxQ50jmXLtFvXs5rNtajPQv7aQ/NBgkH
 Fd1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LOcRuPJ9cZVqNSppauK5QHxQ5QLMrIqs5Mz4GmASRBo=;
 fh=B2OeH1gMQ6qfShcqdiKKNl7jyblwp2x2dnJl8mKJqkA=;
 b=T8PGygM+ukaV2ujhM8jC9vxT8AGwfmZ7WTdCQoUnkBU7bYUNWkopq6MZ0LGQ+RKey5
 IS1RDkytx8i8nttqXWXkh9M0tERiMHpqA5WkOOjJlHCvPg6XmJGGoJia/Pui7bUP1FQC
 EmspE/8qfxf/ZKoZ+RxequjzLE/uCA+XNnKnfYShyyaWT0W6/x8yl2Eh+d0F91Akhi6M
 maCH86hx85xZ7AYZ4uhl2EKD2A4SQslW3e/oLGm5lO9fFk6JZZcsaj2cqvP6pnO2Ol0V
 Bam9KkydQhfgHYl+zJJg8hg/TpvZqOLqKCooDUKYtlxDBAXrSMa8Q1lYdN/VByLn5ZqM
 2uzg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780062670; x=1780667470; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LOcRuPJ9cZVqNSppauK5QHxQ5QLMrIqs5Mz4GmASRBo=;
 b=jnLBcOyjGYU76Xd4MOKVAK71AQxAjZZqYpLaP4vUxStmY39DKmG70Z/uJZqKidAgN3
 ZTJue9NaX6yLH+XnWyHFX50WIRxqIa3IJj5mkDJ7yuRHhnRnBKKc81R3pUpc25osDVFw
 r1vXgGHVHePeJdaONYBG40WhEe/cbVd2+H5Zl07EvShEiECeI1L3bX+XiiHAnNzA2W5s
 4xt4oHj+cmI4GpP9C/9AxTb39GSZ/l4NPSRo8H8x6QtDsH/somEUh2HFRuu4IjSRMCWU
 I92v368vfCi41wMmoocGIIoPd07F5mwfGtHnkJSW3UtB0ePPPcLzdLYWfBT709Wgvao6
 KROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780062670; x=1780667470;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LOcRuPJ9cZVqNSppauK5QHxQ5QLMrIqs5Mz4GmASRBo=;
 b=LQUl5RZuIYicTNkKGuirfgvUrMU1ddXs7RUE64z0ms+7XvQJcIKWWEXoBJWGhGj28v
 0pR8noxUe2yoVkc6EqURoLniiHDAgrl4SnO7sEaB/pTy98Ajkn63SNeuGDLiKqyqkati
 xu17ZIk5qrdRxeRn/4eCXSw3RvuQ0QMeFIxwUlTBiAWI5C8zBHbaN1LUTm2COB6qOTuf
 pF0phASX4Xj159FVCa3h2AjrLC8VOkD5X062f2JFq2/aAy1aCa230yUWf5s75+1iW1Rb
 y0rbNkMvy1oNLwvLK44Zl6uv8dSOHT+yvEF/IPEAUGgWdIdpKzUpTLKh3FUshOH9Z9IF
 6fAg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9OiaD3uiAR4Tr3v8BSYfkyFeDlJ7JbrTrx6Z3Ex6G/gmZKGKF6jIx/V3MpQMwYEFWJSvsqsjXviRw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxRMg3djWFKVlMT7qg8s7DrkjlnQJIqqYthNcn+c+XyPLcI82yg
 zyz9Hmrijruvq80Tndg7QxY1oXoTs2/V6g9jUBgMYueYgBGpCu/CZcYZQsd/xCvEdjcrwCPA+lI
 w4m/gkRlGuaqO4Xq53heKUHwkm7EFPz8=
X-Gm-Gg: Acq92OEiSRf5S4ZrucyYYRsvwi2OKb+3iJrXppeNQuQCgmqpKl5rBmfDv1B8tKMyc0O
 xJaQxh7ZBBg0y1Z+WmPh4EHk8lKpuB9KYG/s5VvZ0kUYBX13jmpOE3jtcy20m+PPxWIdrUTF+rw
 LI/IxKsXfuxCcRAPijZqhA3erYWxocVfLAW5scm2zjwWCpYgm8hKNmNc/a/HvvO5haa6t0/pI8a
 6y6OPDI8sPNTwAk2Oxcn6sNJDSzci1E8HjUQmko3W04wN674DfkoGWpTTJH+ZDm0loRiZF1yaRd
 nF9XnWT2Bjzr9LwIldErc7tSlRaMmZg2WF/6sbG402YkAqoB
X-Received: by 2002:a05:6102:800c:b0:605:ead:8f38 with SMTP id
 ada2fe7eead31-6bf4be6e18amr1045034137.29.1780062670483; Fri, 29 May 2026
 06:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260521143624.56906-1-inki.dae@samsung.com>
 <CAPM=9twLzSJh-rHpNf-JOPBmzFnFevc6v-gu6kWfLCTPeyWLFQ@mail.gmail.com>
In-Reply-To: <CAPM=9twLzSJh-rHpNf-JOPBmzFnFevc6v-gu6kWfLCTPeyWLFQ@mail.gmail.com>
From: Inki Dae <daeinki@gmail.com>
Date: Fri, 29 May 2026 22:50:34 +0900
X-Gm-Features: AVHnY4LajPaJPAl6-cQaV5Ud2YXIRPGXwgLe4juQy96j3uayJT0aLKT5BuRsq0c
Message-ID: <CAAQKjZMxtiWv65t1W_YAtwPQdawkDhKVfgywQ83fXTx9mD3tjg@mail.gmail.com>
Subject: Re: [GIT PULL] exynos-drm-next
To: Dave Airlie <airlied@gmail.com>
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

Hi Dave,

2026=EB=85=84 5=EC=9B=94 26=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 10:01, =
Dave Airlie <airlied@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Fri, 22 May 2026 at 00:36, Inki Dae <inki.dae@samsung.com> wrote:
> >
> > Hi Dave and Daniel,
> >
> >     This PR brings a cleanup and modernization series for Exynos DRM,
> >     focused on fbdev emulation and DMA/GEM internals.
> >
> > Major changes are:
> >     - migrate fbdev allocation to DRM client buffers,
> >     - switch fbdev geometry calculations to DRM format helpers with tig=
hter checks,
> >     - fix screen_buffer handling to match fb_info semantics,
> >     - adopt DRM core DMA tracking and remove redundant Exynos-side code=
.
> >
> > Please kindly let me know if there is any problem.
>
> Hi Inki,
>
> In file included from
> /home/airlied/devel/kernel/dim/src/drivers/gpu/drm/exynos/exynos_drm_gem.=
c:16:
> /home/airlied/devel/kernel/dim/src/drivers/gpu/drm/exynos/exynos_drm_gem.=
c:
> In function =E2=80=98exynos_drm_alloc_buf=E2=80=99:
> /home/airlied/devel/kernel/dim/src/drivers/gpu/drm/exynos/exynos_drm_gem.=
c:69:49:
> warning: format =E2=80=98%lx=E2=80=99 expects argument of type =E2=80=98l=
ong unsigned int=E2=80=99,
> but argument 6 has type =E2=80=98size_t=E2=80=99 {aka =E2=80=98unsigned i=
nt=E2=80=99} [-Wformat=3D]
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
> note: in definition of macro =E2=80=98drm_dev_dbg=E2=80=99
>   563 |         __drm_dev_dbg(NULL, dev, cat, fmt, ##__VA_ARGS__)
>       |                                       ^~~
> /home/airlied/devel/kernel/dim/src/drivers/gpu/drm/exynos/exynos_drm_gem.=
c:69:9:
> note: in expansion of macro =E2=80=98DRM_DEV_DEBUG_KMS=E2=80=99
>    69 |         DRM_DEV_DEBUG_KMS(drm_dev_dma_dev(dev),
> "dma_addr(0x%lx), size(0x%lx)\n",
>       |         ^~~~~~~~~~~~~~~~~
> /home/airlied/devel/kernel/dim/src/drivers/gpu/drm/exynos/exynos_drm_gem.=
c:69:76:
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
> /home/airlied/devel/kernel/dim/src/drivers/gpu/drm/exynos/exynos_drm_gem.=
c:
> In function =E2=80=98exynos_drm_free_buf=E2=80=99:
> /home/airlied/devel/kernel/dim/src/drivers/gpu/drm/exynos/exynos_drm_gem.=
c:83:37:
> warning: format =E2=80=98%lx=E2=80=99 expects argument of type =E2=80=98l=
ong unsigned int=E2=80=99,
> but argument 6 has type =E2=80=98size_t=E2=80=99 {aka =E2=80=98unsigned i=
nt=E2=80=99} [-Wformat=3D]
>    83 |         DRM_DEV_DEBUG_KMS(dev->dev, "dma_addr(0x%lx), size(0x%lx)=
\n",
>       |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
>    84 |                         (unsigned long)exynos_gem->dma_addr,
> exynos_gem->base.size);
>       |
> ~~~~~~~~~~~~~~~~~~~~~
>       |
>               |
>       |
>               size_t {aka unsigned int}
> /home/airlied/devel/kernel/dim/src/include/drm/drm_print.h:563:39:
> note: in definition of macro =E2=80=98drm_dev_dbg=E2=80=99
>   563 |         __drm_dev_dbg(NULL, dev, cat, fmt, ##__VA_ARGS__)
>       |                                       ^~~
> /home/airlied/devel/kernel/dim/src/drivers/gpu/drm/exynos/exynos_drm_gem.=
c:83:9:
> note: in expansion of macro =E2=80=98DRM_DEV_DEBUG_KMS=E2=80=99
>    83 |         DRM_DEV_DEBUG_KMS(dev->dev, "dma_addr(0x%lx), size(0x%lx)=
\n",
>       |         ^~~~~~~~~~~~~~~~~
> /home/airlied/devel/kernel/dim/src/drivers/gpu/drm/exynos/exynos_drm_gem.=
c:83:64:
> note: format string is defined here
>    83 |         DRM_DEV_DEBUG_KMS(dev->dev, "dma_addr(0x%lx), size(0x%lx)=
\n",
>       |                                                              ~~^
>       |                                                                |
>       |
> long unsigned int
>       |                                                              %x
>
>
> Can you fix this up in a follow on PR?

Sorry for the delayed response. I realized that I had missed the
relevant patch. I will take the necessary action to make sure this
does not cause any problems.

Thanks,
Inki Dae


>
> Dave.
>
