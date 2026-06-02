Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A51FCD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 07:16:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEF2910EC86;
	Tue,  2 Jun 2026 07:16:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aNG0beap";
	dkim-atps=neutral
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F43C10EC7B
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 07:16:32 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id
 46e09a7af769-7e6b571750bso1801686a34.1
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 00:16:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780384591; cv=none;
 d=google.com; s=arc-20240605;
 b=bkOsz6F4Zm79TKxUaBZQ8KKPK1X7xEeuObEljYLt0EejAahsyW3x4ZIsLULo18hmv+
 /JOKMLa/5BX/bGNCVpzp9WGXSzc1pM4HNFptlWWmBKuTvlehmEBi7AOpX2tRmv/SEqTJ
 GAxtBhnImizRGRz9oHKd3Lhctk95kJ2yGZnpPREZsV0I2PkJXlNmNruKj0wn6WVKqTNZ
 n3aVTUNwAEYOfokWVAV+PGE/8tqkiK6XDQZEHkikbssu7WK68JCgbtxO/ivPetYAmK3u
 zyj2DCTD9wjd3hr+jneqfrBogupEIeA0PCYTL+5R6sao79rQrb/71A7mRy2cVHUEPzbI
 4h1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6QljEUOAK4GhDaCOum5n6uKCL9G0xte2SQqS3q0iDCI=;
 fh=hiwIcrYYK/iBogAjt+EAt48QdBjy9n5Z+f4eUoiV4vI=;
 b=LBTWK1pvAwtjGCmEYrby8HQu44mejptfg6ykwyDQE1iZehr+HVibCl6RyJtie7YbVg
 umEsao6W65I5LimM9FvzV1S3ZdXbIWaApxtdYCjtvKobFmBTno5c1/LsRoWW0wzdolpZ
 Ywwc3sq9XoR/Q2DhoIWcrmAe7cp+CAVdg/u7Qrg4/riTJ62GNgS5eNuZuVg3XKvYfD8e
 i/TLx8Q2cqX5dlgU7aXxQmyvUzSwXdm8atZiejXkv9txmi9aYs/uY/LfLzRDCZ2pXF3p
 mGC21FA9Q3FLcqMzs/WC058E8ZrR/I8UswVEsqCK7Tc5sP19n3Lpayv8f0qkGJ7Dfzkp
 g2UQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780384591; x=1780989391; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6QljEUOAK4GhDaCOum5n6uKCL9G0xte2SQqS3q0iDCI=;
 b=aNG0beapdmeE1Q5MwVIUOGYRJUOKpMeh4DlfFjYdAwhVVF1MChGYxpaIFYOaeYlYzj
 XDxcufVeF4JWZPFPl107Aw6bOG0EvoJX5KBrJaxN05s1ofTrFqTCn131rKXQM2RU07k1
 7ZLEIgXCn+P6IQq5DJz/apv/HBW4cjHWuCUf7HS5RMmhno4SiX41ggMbyf1sSBdDyiQ3
 i723M7RKmPme0udyyZ/jsdTKzX2ZS1ACDIeZmU+yGJ/+op1tSL4FxMl9YjOY9EVxE6u0
 nIryEejPsH7SaTIh2yQKZxBR3s5XSlZk05YvHY1G96vdTtjW2fyg7gTUPrJtY9tfrXlS
 Q2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780384591; x=1780989391;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6QljEUOAK4GhDaCOum5n6uKCL9G0xte2SQqS3q0iDCI=;
 b=oD2soHAXJC9GWcAQ/YHcTrtMsXr2J35TMc8KoSgufS4A7/oQIAppsRg9pjMFKRZvHw
 bV4pWSM+JSyIHQKPz0CTJorH3lbBqA3s2bZ1kT9bPTnjmJV+i2NHLPBRWMB5hZCJkKEp
 OAVFNk2fL/DlF8Z7iMliAVu2NYj4VGQ5uxk8yU1s5deX33n7ZwUYdPJwuBZLaLonGGYu
 GQiwSZV97/ViTBuEXpg7Uu+0m7zFbwr9ekEtjXzAWP7iRnKSJh9hZSo7qXFgmsmNTBcG
 m1pv7CJxRPwcDr78ICW/dJ0X6fBGI4FpgjvYBvLAjWLo14J8oBnhjgfTQ9NgW5klLHcA
 n/ww==
X-Forwarded-Encrypted: i=1;
 AFNElJ99LcSFpoT21b3P+kuz0ZcPr0Mlturck1/AiQ4T5I/REgY75PEE/ikCW34Va1k2bjwn7BQncZQcxtE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwF1F+5tJkToSO9kMNJx2J5sg3FLQWPg7nUFZiyTsWxLi7XRsj6
 s077ne9h/N7z4i2xV4xpPxZWxmKttRv9m5d5FBA0703YXhHxqmnUtaAXDpBWUezxaR47F/Hyf3w
 6fkaqHdi3WjaOkZlBUwWRmLjKfmwMk0s=
X-Gm-Gg: Acq92OGygDNffX3vIOYfRfwgFN5hPIxytbGX8wnupj59qyBKtMbLr6Ez6g39fnW5aCQ
 5Usayq30StKIP04AShLGIV9fT5lPAzmbhrRIvzGKagtT5KImVCOPPpHSqUIZJgntTgNZvlgdDkS
 3bCpCNbBl86DF2bzNd748kaTfiqYzKrpz260rVfZiSdvi0dbOm0CrlQPJeqBnOb8yvqaMXKU7Zl
 noJD24XeEYjzox/hoRtiO/ykKCT5zyyQcb8wo+Qereg3h9U+uXm/hGrcGx+pO62pvceX79rMv1G
 9WC1mmLbMOr7RlEIE4mt
X-Received: by 2002:a05:6830:4194:b0:7e5:68d0:462d with SMTP id
 46e09a7af769-7e6a1e20025mr8818586a34.19.1780384591168; Tue, 02 Jun 2026
 00:16:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260601-lima-alloc-fix-v1-1-16d3f3b7b780@axis.com>
In-Reply-To: <20260601-lima-alloc-fix-v1-1-16d3f3b7b780@axis.com>
From: Qiang Yu <yuq825@gmail.com>
Date: Tue, 2 Jun 2026 15:16:19 +0800
X-Gm-Features: AVHnY4JMWdde9M5jvz91Ix9Ornc_9nS90uFwDWQRw6lHLBiqcEwZUx95HD6BJaU
Message-ID: <CAKGbVbt6NtBOrnE-ijV2cWLdFcHZTK7tqL6Wxoz9FTS5Sz5H2g@mail.gmail.com>
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

On Mon, Jun 1, 2026 at 8:04=E2=80=AFPM Henrik Grimler <henrik.grimler@axis.=
com> wrote:
>
> lima_vm_create() is currently run before va_start and va_end are set up,
> meaning they are both 0. lima_vm_create() runs drm_mm_init() with them
> as arguments for the allocator, and if DRM_DEBUG_MM is enabled the
> DRM_MM_BUG_ON check in drm_mm_init then fires, as seen here on
> exynos4412-odroid-u2:
>
> [    1.736297] ------------[ cut here ]------------
> [    1.740370] kernel BUG at drivers/gpu/drm/drm_mm.c:931!
> [    1.745574] Internal error: Oops - BUG: 0 [#1] SMP ARM
> [    1.750697] Modules linked in:
> [    1.753734] CPU: 0 UID: 0 PID: 41 Comm: kworker/u16:1 Not tainted 7.0.=
10-postmarketos-exynos4 #11 PREEMPT
> [    1.763372] Hardware name: Samsung Exynos (Flattened Device Tree)
> [    1.769446] Workqueue: events_unbound deferred_probe_work_func
> [    1.775261] PC is at drm_mm_init+0x9c/0xa4
> [    1.779339] LR is at lima_vm_create+0x144/0x17c
> [ ... ]
>
> Fix the issue by moving the lima_vm_create() call after va_start and
> va_end are set up.
>
> Fixes: a1d2a6339961 ("drm/lima: driver for ARM Mali4xx GPUs")
> Signed-off-by: Henrik Grimler <henrik.grimler@axis.com>
> ---
> This is a low priority fix and can wait for v7.2, it does not cause
> any real issues as far as I have seen: drm_mm_init() is re-run some
> seconds after first run with correct parameters.

Reviewed-by: Qiang Yu <yuq825@gmail.com>

drm mm in the empty_vm is not used at all, so no issue caused by it.
drm mm of a real per app vm matters but they are initialized properly
after va_start/end set. In fact only the PDE page matters in empty_vm,
I should only create it instead of the full lima_vm.

> ---
>  drivers/gpu/drm/lima/lima_device.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/lima/lima_device.c b/drivers/gpu/drm/lima/li=
ma_device.c
> index 0bf7105c8748..7c873e62c16d 100644
> --- a/drivers/gpu/drm/lima/lima_device.c
> +++ b/drivers/gpu/drm/lima/lima_device.c
> @@ -368,12 +368,6 @@ int lima_device_init(struct lima_device *ldev)
>         if (err)
>                 goto err_out0;
>
> -       ldev->empty_vm =3D lima_vm_create(ldev);
> -       if (!ldev->empty_vm) {
> -               err =3D -ENOMEM;
> -               goto err_out1;
> -       }
> -
>         ldev->va_start =3D 0;
>         if (ldev->id =3D=3D lima_gpu_mali450) {
>                 ldev->va_end =3D LIMA_VA_RESERVE_START;
> @@ -387,6 +381,12 @@ int lima_device_init(struct lima_device *ldev)
>         } else
>                 ldev->va_end =3D LIMA_VA_RESERVE_END;
>
> +       ldev->empty_vm =3D lima_vm_create(ldev);
> +       if (!ldev->empty_vm) {
> +               err =3D -ENOMEM;
> +               goto err_out1;
> +       }
> +
>         ldev->iomem =3D devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(ldev->iomem)) {
>                 dev_err(ldev->dev, "fail to ioremap iomem\n");
>
> ---
> base-commit: c453c60fdba437f69209e027b418c4a24143605a
> change-id: 20260529-lima-alloc-fix-2cd5408f6493
>
> Best regards,
> --
> Henrik Grimler <henrik.grimler@axis.com>
>
