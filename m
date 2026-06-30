Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C70C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 06:25:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C997B10E176;
	Tue, 30 Jun 2026 06:25:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hg4vkinK";
	dkim-atps=neutral
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com
 [209.85.210.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66E4B10E176
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 06:25:19 +0000 (UTC)
Received: by mail-ot1-f54.google.com with SMTP id
 46e09a7af769-7e93cd4e64bso3090271a34.2
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 23:25:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782800718; cv=none;
 d=google.com; s=arc-20260327;
 b=Lb8O3/CcQSnlrUrnQ4H3uTCooCOW2KnDbUZ6Gwiyry+/AH0cd4NLli95iDWN7VHzpA
 KXd+j/w8UxQNij6rNZ3pG+zAwbQNZG3M+wqFI4MmItEEbTfA+0k7FFG4UxXjZAtcuPGk
 iTz989MopRphygW9Ce657eLwYREsxumXoMnSMXmeL7+wckqo+UX3yvnsS46PrfSfm4i0
 1AsWfPwpMNJdRAXdHoZD5B6JOA7M9+lutSM7NdNJVqDm6jsY1/zSqTSI8HRmcUPOe3S+
 uGa6Hbw/DfIw47qsjZYlLyEP8eJsFV34qyvEfhvmDo3I2udFyyup10WmqtNrih7z196m
 spRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pZZE9+o7hc6DdRG9AbRlJ9+v4rQT+RFk76oPmbGAKdk=;
 fh=XZgh3/XgsFgGI47amhedUUDl0qZ3PjhxOkHiHWa5i7c=;
 b=fcRHVjvn+gEBt42rSpRt5BtogumbU7/CiYa+0Z8NCBLboFgr3t1Q1oLm46ht28uBKT
 j7mQNoT3piH7YYI/qDS+pLEf6RpwWrGYzF8DCuBPneZvTInxTJaj8mig1YSaFu517E4S
 QkW1zUf/AdLsgBcWXZime9rRR0w1qp2FCAR0JGqAW2dU5mN9nQIaXVTOt4dj6Q6FXvAw
 zHXWVbF5o9HHeOJgaToKH59tFTk02NHo7BCYzcgLJXNEz0oEjdlGuH1hTGf04vLRepzC
 +Akuz5ipBEHsWkA1TQG07b2fRyQUPS5eRIvwmPhdfcH3FTIvONlIFgwi7sxOy1s1it7Y
 OnHA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782800718; x=1783405518; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pZZE9+o7hc6DdRG9AbRlJ9+v4rQT+RFk76oPmbGAKdk=;
 b=hg4vkinKhqpIrtOBtbXCib1xOWzbessTjJxjgbIEELCmkWRkXJ15TszRY9U83PaEYs
 s5DuBkfwSuZyG4pS8oHmNWNseh72ilT/4ySWe/aF2ETQcuZWLhe6zgltSZ5kyawYgnqq
 2H9Aa6OGdB9aJjsFBnz6AH0eNK5u6lEsOQotE7jDRHU/JKdDVLnucoXXY4tILMxQJHtd
 neh1KP9AO9DfmGC53DB5ZKgpLIDpP2bgBABksPcP6cHjSDVH8GCo76xHbaSFVmAkdaAK
 BHDlrDB1aVNH/2FzucTySJ09X3ytLzMeDoaeY+z3S7zazlFPSwrHKQ5YnbQ7/M7GtrS8
 TnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782800718; x=1783405518;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pZZE9+o7hc6DdRG9AbRlJ9+v4rQT+RFk76oPmbGAKdk=;
 b=Ulf8BWgRKoCHdxL5FnYhty6k0p1t4JxOiKDDUxDy+IziYaUjfS8x2NRs2uXXGX0SVA
 XwcLRuYcI15CIaZq+cGZf6CvVBYGhxZd5PC3LeNakuA8OZMn7/QYXmnnncbdvxGnt9fM
 2jVguoLTkJ5kMW3MPO9EncgJyStQOY5RqPjV7M59oKg0mPSAAUA2p3aiE/witS5lXbWn
 qjWcsD2VHzPY9BB2nw7J6TuQk/+D+BpOrnM4qRcZvQ1gQkxss9T27dLUd2uP4/m+uyCJ
 znk/2sGoew4+kgT0uRzCc7q6FHvI8Sm4niNrcT5OCrGSe7y8Va9WJpzuDYqvzk1dXX1k
 voQg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8bxYUBcQbMK2njTN6hY1QqoZP0xiDszxBktRGslk54ZGXL3wgVl1se22fcCcwqcwy0AdXOT9yfoT4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxijZMCxwSnOxme003iuXuepcEKT/pCDz6Hetg+Adg43t6I2HAu
 qfLslYAYOTxUDJcskHes+ZFiEJV2GC+lOTJ1FFaGbUkotBc6uRigpbLou3UVK0/xVTkIgo5pssu
 +DvVTyUGyNAFzJQdL+g7iq9ekeB9nslI=
X-Gm-Gg: AfdE7ckBm4JXLtxHXkOuqplakVUkDirK1NVt/jjLRQ0NDGhU0nx1tqbPUQBebWthdqD
 hIj3PWYuQj2N2gUyp9o+X3gxg2uHA7nd60oCMzB9+amrdznusuKSyXVPuUlbH3CwjYg2prR9sZY
 AryokdBr264OJH1IZgg1gganTbH/+uIhb8gd9aMABHROFcZe6gMsWPInFInmRJdJXQzfbuqqSOA
 fZ6dJs6BGt0PVEKoFxdN7zW87eq6dDDwFWNIJFZ8d2sXKWue6CuK7FEeyHOCqkWolBbr6Ty
X-Received: by 2002:a05:6830:b15:b0:7e6:ef1d:4aeb with SMTP id
 46e09a7af769-7e9ec724aadmr2488848a34.15.1782800718376; Mon, 29 Jun 2026
 23:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260601-lima-alloc-fix-v1-1-16d3f3b7b780@axis.com>
 <CAKGbVbt6NtBOrnE-ijV2cWLdFcHZTK7tqL6Wxoz9FTS5Sz5H2g@mail.gmail.com>
In-Reply-To: <CAKGbVbt6NtBOrnE-ijV2cWLdFcHZTK7tqL6Wxoz9FTS5Sz5H2g@mail.gmail.com>
From: Qiang Yu <yuq825@gmail.com>
Date: Tue, 30 Jun 2026 14:25:06 +0800
X-Gm-Features: AVVi8Cdqfd6FV3N7-J0Pn4yz-PNReDW8OjbwiJqooEAomfZU32iDqCm6ZR_lbIQ
Message-ID: <CAKGbVbtxGOw1WQcmV-_1aWQpHGZp6yvDPcyVBYYCRF7z8UGwhg@mail.gmail.com>
Subject: Re: [PATCH] drm/lima: call drm_mm_init() with a valid allocation range
To: Henrik Grimler <henrik.grimler@axis.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Eric Anholt <eric@anholt.net>, Erico Nunes <nunes.erico@gmail.com>,
 Marek Vasut <marex@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Andreas Baierl <ichgeh@imkreisrum.de>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, Rob Herring <robh@kerrnel.org>, 
 dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org, 
 lima@lists.freedesktop.org, linux-kernel@vger.kernel.org, kernel@axis.com
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

applied to drm-misc-next

On Tue, Jun 2, 2026 at 3:16=E2=80=AFPM Qiang Yu <yuq825@gmail.com> wrote:
>
> On Mon, Jun 1, 2026 at 8:04=E2=80=AFPM Henrik Grimler <henrik.grimler@axi=
s.com> wrote:
> >
> > lima_vm_create() is currently run before va_start and va_end are set up=
,
> > meaning they are both 0. lima_vm_create() runs drm_mm_init() with them
> > as arguments for the allocator, and if DRM_DEBUG_MM is enabled the
> > DRM_MM_BUG_ON check in drm_mm_init then fires, as seen here on
> > exynos4412-odroid-u2:
> >
> > [    1.736297] ------------[ cut here ]------------
> > [    1.740370] kernel BUG at drivers/gpu/drm/drm_mm.c:931!
> > [    1.745574] Internal error: Oops - BUG: 0 [#1] SMP ARM
> > [    1.750697] Modules linked in:
> > [    1.753734] CPU: 0 UID: 0 PID: 41 Comm: kworker/u16:1 Not tainted 7.=
0.10-postmarketos-exynos4 #11 PREEMPT
> > [    1.763372] Hardware name: Samsung Exynos (Flattened Device Tree)
> > [    1.769446] Workqueue: events_unbound deferred_probe_work_func
> > [    1.775261] PC is at drm_mm_init+0x9c/0xa4
> > [    1.779339] LR is at lima_vm_create+0x144/0x17c
> > [ ... ]
> >
> > Fix the issue by moving the lima_vm_create() call after va_start and
> > va_end are set up.
> >
> > Fixes: a1d2a6339961 ("drm/lima: driver for ARM Mali4xx GPUs")
> > Signed-off-by: Henrik Grimler <henrik.grimler@axis.com>
> > ---
> > This is a low priority fix and can wait for v7.2, it does not cause
> > any real issues as far as I have seen: drm_mm_init() is re-run some
> > seconds after first run with correct parameters.
>
> Reviewed-by: Qiang Yu <yuq825@gmail.com>
>
> drm mm in the empty_vm is not used at all, so no issue caused by it.
> drm mm of a real per app vm matters but they are initialized properly
> after va_start/end set. In fact only the PDE page matters in empty_vm,
> I should only create it instead of the full lima_vm.
>
> > ---
> >  drivers/gpu/drm/lima/lima_device.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/lima/lima_device.c b/drivers/gpu/drm/lima/=
lima_device.c
> > index 0bf7105c8748..7c873e62c16d 100644
> > --- a/drivers/gpu/drm/lima/lima_device.c
> > +++ b/drivers/gpu/drm/lima/lima_device.c
> > @@ -368,12 +368,6 @@ int lima_device_init(struct lima_device *ldev)
> >         if (err)
> >                 goto err_out0;
> >
> > -       ldev->empty_vm =3D lima_vm_create(ldev);
> > -       if (!ldev->empty_vm) {
> > -               err =3D -ENOMEM;
> > -               goto err_out1;
> > -       }
> > -
> >         ldev->va_start =3D 0;
> >         if (ldev->id =3D=3D lima_gpu_mali450) {
> >                 ldev->va_end =3D LIMA_VA_RESERVE_START;
> > @@ -387,6 +381,12 @@ int lima_device_init(struct lima_device *ldev)
> >         } else
> >                 ldev->va_end =3D LIMA_VA_RESERVE_END;
> >
> > +       ldev->empty_vm =3D lima_vm_create(ldev);
> > +       if (!ldev->empty_vm) {
> > +               err =3D -ENOMEM;
> > +               goto err_out1;
> > +       }
> > +
> >         ldev->iomem =3D devm_platform_ioremap_resource(pdev, 0);
> >         if (IS_ERR(ldev->iomem)) {
> >                 dev_err(ldev->dev, "fail to ioremap iomem\n");
> >
> > ---
> > base-commit: c453c60fdba437f69209e027b418c4a24143605a
> > change-id: 20260529-lima-alloc-fix-2cd5408f6493
> >
> > Best regards,
> > --
> > Henrik Grimler <henrik.grimler@axis.com>
> >
