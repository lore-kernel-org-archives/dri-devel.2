Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8513EC5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 20:45:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A046E10EF2B;
	Fri, 14 Aug 2026 20:45:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="c/WSDUaz";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 390D810F6CD
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 20:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786740342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VxShuxNWjK6vy6fFi45+c1RKfCy31uup4sL6awRsGyk=;
 b=c/WSDUazj6QQpcPy8c4JI80hYH2oXZqBKb2/oc37y4Qwzx7/Hmal+i5Tu0AX6jX6v+mC6/
 xztDAf5CWZKX0nZfE38lIJWWTmKjqQcABgRiMbsQRqAGUjO762wScJrt3/9haqqyhkDxqn
 Mt5vVu+3YlZVdh+0rCBu02iHMgcfVnk=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-Vxwoyt_9O3evRGYHbuyt8A-1; Fri, 14 Aug 2026 16:45:34 -0400
X-MC-Unique: Vxwoyt_9O3evRGYHbuyt8A-1
X-Mimecast-MFC-AGG-ID: Vxwoyt_9O3evRGYHbuyt8A_1786740333
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2d02df2bf09so15369805ad.0
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 13:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786740333; x=1787345133;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VxShuxNWjK6vy6fFi45+c1RKfCy31uup4sL6awRsGyk=;
 b=F9DItlE2TkQjil0i/ewcIOXPxcRzD0XgsInrc15zKX1ivr4mguYeD4F/zBGhV06vTH
 HyUzA2cgogsKRk7rLcp1ejJ0MqG+mYnq273Whpb1wvnYRpHdGKsUMCnFU0+T32ClC8oM
 jeq7tJsl/BGm696ovCQBzN4G/9NOFEjdZxRSTOoszAx3Fix4W2CmFlRuclHlwoLWvkkN
 ULv6WNULF1msorTNH6SRjl09N9231c1OjMAdHUGZctP0hrRMKRIEzFrLxRo5Nyg0i+1H
 Bk2xLrr3/hWzp71nrRmJRgTYqnTWAqoyGiG7+ZW6k0GyBiLZp69Qk9yRqaLs+adJ6AbI
 pOhA==
X-Gm-Message-State: AOJu0YzN1xPdZlsvVZ1bvyh5mTuRnUMz1w+FJI/HKmj3ZPtIm8UG3KVs
 eA2XLk16s0x0WX2Kp9BJqANnZIvSJkHn+mcNFGIuihWKvA9F/3e/DzWkjC7nPV9eyJuIOZpzaPU
 iCc+P8gDf+dipMTEsaxAypcv2zNhWuTl6fleX8UKxU3/FyHA0sK3HcuIOfGeQ8BqN3dMjbWeC+S
 jf+5lcsvnZ7kbW4PtsZTu6KpH2OrvMJ588ozaTA/blqckVBKJsERGu
X-Gm-Gg: AR+sD13J8KhaYJO16VMkuJAKAy8bUule5tN8Ss4gBNxky23wtJguZV6C9T8zlq2mCH4
 fRG45if2AXYV806vpeHApu6qVV2siCuejBByLRGs37MBPuWZM8CzwG6RZV+FeaArG/QviA+xG31
 O2CG0n0cAfo5mDrxpt5jKzoYiFnrgpG+h3xIYf50IyzHjCJYPy98z0oe6BsyuVWuDoTKR67yFUT
 kx38B6cTtPLxxa9
X-Received: by 2002:a17:90b:3889:b0:381:11eb:d78e with SMTP id
 98e67ed59e1d1-3933b8ace11mr8972414a91.14.1786740333053; 
 Fri, 14 Aug 2026 13:45:33 -0700 (PDT)
X-Received: by 2002:a17:90b:3889:b0:381:11eb:d78e with SMTP id
 98e67ed59e1d1-3933b8ace11mr8972357a91.14.1786740332584; Fri, 14 Aug 2026
 13:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260814194542.781955-1-lyude@redhat.com>
In-Reply-To: <20260814194542.781955-1-lyude@redhat.com>
From: David Airlie <airlied@redhat.com>
Date: Sat, 15 Aug 2026 06:45:21 +1000
X-Gm-Features: AUfX_my66rtVpLJbBZVMgZwZu3oFOTX2t4ug31ZdJulSxidKcPEsvPNIyHxdcEw
Message-ID: <CAMwc25pWnT2ScvkhvB3QZ5A5SbB9JrsnyV9HncqpeiGOzQ5bTA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] drm/nouveau: GSP runtime PM fixes
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Timur Tabi <ttabi@nvidia.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Ben Skeggs <bskeggs@nvidia.com>, 
 Kees Cook <kees@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 David Airlie <airlied@gmail.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>, 
 Mel Henning <mhenning@darkrefraction.com>, Danilo Krummrich <dakr@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EM3qszG8RV_xTXTglXAoWFUhRzV6fieDmSS6ZQE0Dac_1786740333
X-Mimecast-Originator: redhat.com
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

On Sat, Aug 15, 2026 at 5:45=E2=80=AFAM Lyude Paul <lyude@redhat.com> wrote=
:
>
> Runtime suspend/resume has been notoriously flakey since we started
> using the R570 GSP firmware, and possibly was also flakey for some time
> when we introduced GSP support initially.
>
> These fixes get runtime PM to be dramatically more stable then it was
> before. Unfortunately even with this patch series, there are still some
> remaining issues that need to be fixed. These likely stem from the
> currently different code path that we need to take with these fixes in
> order to get suspend/resume working.
>
> While we're making progress in understanding what exactly we're doing
> differently from OpenRM that makes this the case, it will likely take us
> a while before we actually have things working well enough to copy what
> OpenRM does. Taking precisely the same path that OpenRM takes however,
> will require some additional work - and at the very least these fixes do
> appear to get suspend/resume and runtime PM working the vast majority of
> the time.
>
> Thanks for nvidia for providing context into what all of these various
> flags and settings do!

While I did not expect the ending to be make the magic sleep magicer,
I appreciate I introduced the magic sleep and got to the same point in
trying to explain it, and failed for it to make any sense.

For the series:

Reviewed-by: Dave Airlie <airlied@redhat.com>

>
> Previous version of this patch series:
>
>   https://patchwork.freedesktop.org/series/169457/
>
> Patch-wide changes:
> * Add magic sleep, this seems to get things stable - but boy I wish I
>   could figure out why.
>
> Lyude Paul (4):
>   Revert "nouveau/gsp: fix suspend/resume regression on r570 firmware"
>   drm/nouveau/gsp/r570: Set GcOff =3D 0 in fbsr
>   drm/nouveau/gsp/r570: Enable S/R Display workaround in GSP
>   drm/nouveau/gsp: Increase delay for magic sleep in r535_gsp_fini()
>
>  drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fbsr.c    | 2 +-
>  drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c     | 8 ++++++--
>  drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c    | 8 ++++----
>  drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c     | 3 ++-
>  .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h    | 8 ++++++++
>  drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h           | 2 +-
>  6 files changed, 22 insertions(+), 9 deletions(-)
>
>
> base-commit: f29ab62f7ed55eae7b246bb535ede56d3b338674
> --
> 2.55.0
>

