Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BD0C5AD2C
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 06:07:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C74E10E0D9;
	Sun,  9 Aug 2026 06:07:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nRIoj6KL";
	dkim-atps=neutral
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com
 [209.85.167.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D318110E0DC
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 06:07:05 +0000 (UTC)
Received: by mail-lf1-f42.google.com with SMTP id
 2adb3069b0e04-5b15c6fb864so534920e87.1
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 23:07:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786255624; cv=none;
 d=google.com; s=arc-20260327;
 b=XBBxFJV1ZOOopk5HbaTzkIH4q378TNBx5V4VH7Eplkfch1wxyUgN9lWz1pcHGnWcP1
 a6WUGuy1djMBMKiHOC9kEoC7RCoaD14pkQ2euXVz1em9tbYkC4C9mG8J3H3VMKDJw3rX
 DGwlWXIC0Ck6Gy4ujdNmUsC1HH17qrNhCCKPnvSztWsnmdkCG4kP/XMTSTCQ7wIOM63w
 oO13XKdeFGWqRPnPtjyz+LQnfk+CSdP1V1ikIt0AnAaUwvmhN9IYoEADMM+SJ0NdFOAN
 htVU2fzGewIfmv0qN28hlrv0uItb08LoTDvAeJDk0hv9XG2iYf4ApxF7ZuclLRs0jdgU
 Bcng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YpmkqxittInrChlb+wwaxzd9ar8fv5VvkAor8BQUeUM=;
 fh=ZhQqGQI0irpxGcxffaHosCPRzD7m1lm9BiV5CAnMnyo=;
 b=BI4DSZOEiudL9RKwj5ynZq445kh6anvkrjBnhkzOmAsHJIDxjA2XkAs0kGzYTGCeY+
 jG72/SdX5Vz9SJZXl0VNrebVJkcVikvTt2J8Kam3sCUaniFM53fxEIuXG17JqJtn4XP8
 ji4H1fUTa/JGtnAypP0ryEvK23A6h2xpcrH/7HX+VcsZmW6OhJ98Tfq5q6tUk7Hl8LVv
 kza0JMU7JShiR4V4XDFOpPSupBRKVpm2dF6dYs0SJWC6yaDY5zmUQ3NU1p06H4ljs9Zd
 s4yodlFEbYhzYZUHgzA/zSDOdJnxT5O5wSanr+W8SShEYKNRnJdSAWKQvm+jHPWQK72o
 pIeA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786255624; x=1786860424; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YpmkqxittInrChlb+wwaxzd9ar8fv5VvkAor8BQUeUM=;
 b=nRIoj6KLON7ayIl9ULLDYWsOHhOIEMvSELDybw/sasYdAmDKB/n01i2bEmdB4BWwoj
 xmqoKuj9McA3Jf7faGjAlrnKxChhjXrbDkr3G9sfd4HGAan+tlY4bZgNp2IDCmwEks3j
 jbuLRO6LM7Tg7Dz4Q5DodPSVF8RhsBdbwLfuFy8rTI52Sz2KETutvT29hZz2VJklmJqY
 ueqn3QLjplSLU7U7gNZvgg6SvpoX6sCIWOv4ltXUIs2PajxO1Hwc88lmLyy4dkIQUauM
 IanUJhMIubADeYYrS/1drkWM+KUBBBzJHkVwGddQ+H9vqkB5SPEUv7AG5KcyXFLm20c+
 mcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786255624; x=1786860424;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YpmkqxittInrChlb+wwaxzd9ar8fv5VvkAor8BQUeUM=;
 b=kKCdWFEq6gYhXYsYiY1Tw7yuSpC+gD+RgztXfZp5YB6QmafBPsMkD3fDoKrG9IiWOe
 1YOkUJeRAxjGESEFsoAWP5SSc8vZVsiV9yau4Gjc3oqJIzN93cwdh7pvLk1fAKUtRWGP
 EAGT2iu9OqsVsCz7GLm28GjR+E0MuR8m8h/yvWStl+dvwKx610IEQm92S7cgx6O40cOl
 Cel5HuWlb+LA4eyxRv4UzERLfVZDr5bJUL/add2DK0nhdOETC7LKK4KpLkDpnIQUtctY
 KdoarId+lReid3ptAVC5rks+86hIClkLE5kuY1ExPMGfF1AQ/hTbp3FzZ7S2Vk2osnbT
 RntQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp3HxGMIJdvYd9J7w5ULg9G0a9EBg8hfC4TRaGt/e970E0+QgcDGHEzGeuAiQoiUP2qBOHHnVpeSlQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+0A7GVcLhD9BXAfYIN9MDkdke8isgOYPN02LkPuUhcqCx22rc
 DgTczZMC5SI3KmsqPwTmz9zcpALpF1fbX9oZbdUL8tHdLKX0HhZDbXorT5veGyv+0QrWE8M9qsp
 F+FRFg94uqATD/qfA2bz8uVsAicfcb/8=
X-Gm-Gg: AR+sD121XXF6V969zjBRuuh5lG0K6dw5GwDSFNpuoBGTbZ9xlzwgdrnHyunW4FXsUUG
 ER96m9h1CJD8f26v1K0tm+TrFPf8XM/rMDHLanURzzGW+i8EFRkEI6hv9WM7XArUqp6BjJAIHNd
 XEB9a/xCHoMhrUF4Lvtv1rlPqmHOQrVUt3NvmnHuMOyJBW+aUIRBsXJfvuojm12fsH1AEDxnaai
 ZuyChd+AHQUxuPOsvKtkh0aZ6Be6Tsf1CMgY2VOtNwoKL0q6DGOlH019Z+mFSCnIxRanKjonPuK
 fRLhTX+R4DDcu0KcWck1UOz+AAeA8axBJBaBZPSV/KR1f2RKJxl11r1lmlh+OB1wJoQQAbjkb2b
 /DIPRdoZrChHTSJsWDSb29eFLyRwL8A==
X-Received: by 2002:a05:6512:68c:b0:5b1:5f7e:1ca2 with SMTP id
 2adb3069b0e04-5b30b770f9amr1464459e87.32.1786255623565; Sat, 08 Aug 2026
 23:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260725-tegra-coherent-wc-v1-1-dfdcc929c21b@gmail.com>
 <67fe34eebafe657b3221ac39838440b294c60444.camel@lynxeye.de>
In-Reply-To: <67fe34eebafe657b3221ac39838440b294c60444.camel@lynxeye.de>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Sun, 9 Aug 2026 01:06:51 -0500
X-Gm-Features: AUfX_mx8KQxE55mPFvf4bCdi1Ci4tN_R-8PURcVW83QA94nVGU1-lMotJniGcXI
Message-ID: <CALHNRZ9Jg=NQ-i5G8q4vdOgwgUUKDAdi0+VXUnHU2Ctpo74YAw@mail.gmail.com>
Subject: Re: [PATCH RFC] drm/nouveau: Use write-combined maps for coherent on
 Tegra
To: dev@lynxeye.de
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Faith Ekstrand <faith.ekstrand@collabora.com>
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

On Tue, Jul 28, 2026 at 3:38=E2=80=AFAM Lucas Stach <dev@lynxeye.de> wrote:
>
> Am Samstag, dem 25.07.2026 um 18:28 -0500 schrieb Aaron Kling via B4
> Relay:
> > From: Faith Ekstrand <faith.ekstrand@collabora.com>
> >
> > On Tegra devices, uncached maps traslate to device memory, causing
> > unaligned accesses by userspace resulting in a SIGBUS. Instead, use
> > write-combined maps to ensure proper access.
> >
> This is not only an issue on Tegra. All ARM64 platforms translate
> uncached to device memory, which does not support unaligned access. So
> the issue could happen in the same way when connecting a discrete GPU
> to a ARM64 platform with PCIe support.
>
> I would argue that there is no downside to always using write combined
> memory for coherent buffers. You gain potentially faster writes while
> the only issue is that writes may get delayed visibility at the device
> side. However, I don't think anyone uses coherent buffers to modify the
> content from the CPU side while the device is operating on the buffer.
> For all regular use-case the memory barrier in FIRE_RING() will make
> sure that the buffered writes are visible to the device before the
> commands using the buffer are made visible to the device.

Should I send a new revision that sets write combined for all coherent
then? I only have Tegra devices to verify this on, so I can't attest
to how this affects discrete cards.

Aaron

> Regards,
> Lucas
>
> > Signed-off-by: Faith Ekstrand <faith.ekstrand@collabora.com>
> > Co-developed-by: Aaron Kling <webgeek1234@gmail.com>
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> > This patch is marked RFC because there is not complete confidence that
> > the change is correct. Without this change, nouveau can easily hit
> > sigbus errors in Android UI rendering via nvk or running vulkan deqp
> > tests on Tegra. Changing coherent maps to use write-combined stops the
> > crashing, but it is unknown what the performance impact is, if any.
> > ---
> >  drivers/gpu/drm/nouveau/nouveau_sgdma.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_sgdma.c b/drivers/gpu/drm/=
nouveau/nouveau_sgdma.c
> > index fa3b4ebf38a83..10f6ef1c541bd 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_sgdma.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_sgdma.c
> > @@ -72,9 +72,12 @@ nouveau_sgdma_create_ttm(struct ttm_buffer_object *b=
o, uint32_t page_flags)
> >       struct nouveau_sgdma_be *nvbe;
> >       enum ttm_caching caching;
> >
> > -     if (nvbo->force_coherent)
> > -             caching =3D ttm_uncached;
> > -     else if (drm->agp.bridge)
> > +     if (nvbo->force_coherent) {
> > +             if (drm->client.device.info.platform =3D=3D NV_DEVICE_INF=
O_V0_SOC)
> > +                     caching =3D ttm_write_combined;
> > +             else
> > +                     caching =3D ttm_uncached;
> > +     } else if (drm->agp.bridge)
> >               caching =3D ttm_write_combined;
> >       else
> >               caching =3D ttm_cached;
> >
> > ---
> > base-commit: 1a1757b76427f6201bfe0bf1bea9f7574f332a93
> > change-id: 20260725-tegra-coherent-wc-19941d1a5a60
> >
> > Best regards,
