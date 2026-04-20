Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE5BF588DE
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 14:13:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDCC110E1EA;
	Mon, 20 Apr 2026 14:13:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=tomeuvizoso-net.20251104.gappssmtp.com header.i=@tomeuvizoso-net.20251104.gappssmtp.com header.b="a7ZeRmoG";
	dkim-atps=neutral
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 090AA10E1EA
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 14:13:13 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-12c8ccc7755so1198639c88.0
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 07:13:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776694393; cv=none;
 d=google.com; s=arc-20240605;
 b=AqWfaTyB7l7cl15b334787uPNJz7KwqZc9YrWa3yzNVqc6U7C/Ri0gLBulo7xHnUZw
 usjl6KT/M1KobGV1sI71NdnCykXOGj2j6KTJk/wgjk79SKVvfIvYjfvRfXOEz7cgfrXP
 gx1mvIl+3xsIGW6REJ0JacVi5ka4r3I9SsjdCvHlfA60wLTqc064qeeHzphscDqI+qPd
 SeOvQSDNpz3aRVQrtBrt2D//TkPi0nai94lpsoHkgmIXXtb77ThSqSDyxgBlpG83iPSL
 BheSYPlcGovhlqOuBUMdSzL9V1Xu9HWrFR93AicnGXJaFRW4asG7AeSjvGjpyptKFPtX
 J+Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RY55dkbCNBUBL969VO5sT1O2XMpsnPH2PC4wwUHFnnE=;
 fh=DSTQUuMBfLBNALBwElP07GC/p+5NWXI1DwbWJiQJz1o=;
 b=JGE2x7Y0BGdm68UIWFqtHj1vKaTHVXkFFx8frWPhLKigNHM+JsNettgvzPuzgwSYx0
 QBHUJVLdGtJhEE6SufRLVapHM4NNMFZoCt9Ihvoft7XbTeQAiNN1TZOry+NdCiSp/hil
 Ih4fbXqT1mQ3MsuKwHxbR7kN8mE5LBRevEOlw+bFgrOmE6h8wl4zKcPjbJvzkEvYBhLU
 6CGhRy1MR7e9/njJu76792FBSTNgUZ4WsVD7gE3xKAg5yt4I5WT107U4ILtNb1kTMCOB
 m1aYmW4vFXhtoEK/2Hx3lVOMTZA+MLZtiRwYloTc7gtMlC7rLFYY62z/E2CTQKt5n5d4
 FKvQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tomeuvizoso-net.20251104.gappssmtp.com; s=20251104; t=1776694393;
 x=1777299193; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RY55dkbCNBUBL969VO5sT1O2XMpsnPH2PC4wwUHFnnE=;
 b=a7ZeRmoGbGFEdD7KnCWoxNkcMIEY+qzJWkp+wn864+HuLVT+aofrNfUiJcPululYla
 02bjxrDilblrjBv5YeITTViFhUI/+EA9niTxxHD4nhg+hXyR2nMd2dc5qkYKWZxGfNXf
 mfuvlCPY3NpJootBBIZyl9EUBQBBGgPZSk54w35VErM+qc+jBn3zrVmeo/2H9hgE0CYE
 s7mf1YmLl639VIPiEuNdtuUKBN85pxYI3YRPJDQ9rDSAORUNVCGNeTBwNJGGTWQ4R2Ad
 KOudI/L/gU/hhkDR3zVrEgmU3RtjocThuhudFaZZsuB4tLgpxLZBF7B5/imDy70nQc5a
 2xNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776694393; x=1777299193;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RY55dkbCNBUBL969VO5sT1O2XMpsnPH2PC4wwUHFnnE=;
 b=FQiY3B06pDbISK8FQfDEFZCJ6/oTobWEhpmyX3c1OOvuzoiljM4bhEDV0ziqnx/9PL
 eJck6Lwx/fHEPtSP2z11Ye01kLTaoT0xYjg7rEV82Mzbn+4sUa7F1jEaaE5LBAXZKH7E
 C4rwM5TTliy6/k5YAUhrzXQ1oG5Gi0zkN8fGjzDoUkWhFWLkH9KxlpfFMlCQaUeJkujB
 A4Yla9AT5v+7tn6PGM7odT5OnhZUPu4/1jfvhzsHqoV0UurIFE8wsxeZIoJWpxVxCFl6
 vLr8LjOCAGVROudrwMFjOci3QaKRAMr71tQDB549K1Osfv1MlCpz8V3LfgIO7Cd9Vw4+
 Myfw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/vYtSqWFiYeBZbqoRHYBZuT90rmibORPK035S5BHvn88USE2H/o06vqG6mkC8dsRO6Zhg2RZui3C0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzDh5Ryr+vd3EgWRTk+T3csdx2TJI49X1yXb//prBxUf0OxP5lU
 vr9oFLIn0g+kwlvvXJdO5+Ap4v0btkL+sHjC9ulyYmeS5HYTMkbviNP/vyIvEMc8WbGqT49hSNA
 8ME/bJZt4EuxfCZfZO3A+y4cy9XrpOzS798AnO5c8XA==
X-Gm-Gg: AeBDiesylm8nmwYeMuLE7Re7yN5AKZjB9K6SfNIvHLr/H++DGwqbLtsnOgZM+j1gQvj
 IoJY/FeCyGOqYKz2E6xnTMbuqwwMBIzY1RG1018Fouc7/nOtPLWpqOXbp99sqFu7FEdrC/UDfBk
 aGhVLvnHjSZmmifjuLF2hsnLgTAVmb9zj9NDN7sfc+GXHDHlGvj9LYSREvNYzOYwGz1fCGNxsNh
 FdybxyogFhCeS6hRybxJ+r1qadb95sabESa7od9WscXS3sw33pSIJWwRGun+0FOpurceUZGlFr1
 C2FJbKm+f6DAZ9v+
X-Received: by 2002:a05:7022:2602:b0:128:d23d:81a2 with SMTP id
 a92af1059eb24-12c73f9ae5cmr6646930c88.29.1776694393074; Mon, 20 Apr 2026
 07:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776581974.git.gye976@gmail.com>
 <c0ebf83b345721701b22d8f5bc41c52c0ecf5e16.1776581974.git.gye976@gmail.com>
In-Reply-To: <c0ebf83b345721701b22d8f5bc41c52c0ecf5e16.1776581974.git.gye976@gmail.com>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Mon, 20 Apr 2026 16:12:59 +0200
X-Gm-Features: AQROBzDs4_XjqT-9GndbRM_zOc4QlFRBoosVudK8gwq0qmMTzSwHuryuZaTsSJc
Message-ID: <CAPsqS2Q_p+_+XDstWworSL=Bdg=ENtDxaVTcxpchF4qm4WwWEw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] accel/rocket: Fix prep_bo ioctl leaking positive
 return from dma_resv_wait_timeout()
To: Gyeyoung Baek <gye976@gmail.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Oded Gabbay <ogabbay@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
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

On Sun, Apr 19, 2026 at 9:19=E2=80=AFAM Gyeyoung Baek <gye976@gmail.com> wr=
ote:
>
> dma_resv_wait_timeout() returns a positive 'remaining jiffies' value
> on success, 0 on timeout, and -errno on failure.
>
> rocket_ioctl_prep_bo() returns this 'long' result from an int-typed
> ioctl handler, so positive values reach userspace as bogus errors.
> Explicitly set ret to 0 on the success path.
>
> Fixes: 525ad89dd904 ("accel/rocket: Add IOCTLs for synchronizing memory a=
ccesses")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gyeyoung Baek <gye976@gmail.com>

Reviewed-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>

Thanks!

Tomeu

> ---
>  drivers/accel/rocket/rocket_gem.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/accel/rocket/rocket_gem.c b/drivers/accel/rocket/roc=
ket_gem.c
> index b6a385d2e..c80847192 100644
> --- a/drivers/accel/rocket/rocket_gem.c
> +++ b/drivers/accel/rocket/rocket_gem.c
> @@ -145,6 +145,8 @@ int rocket_ioctl_prep_bo(struct drm_device *dev, void=
 *data, struct drm_file *fi
>         ret =3D dma_resv_wait_timeout(gem_obj->resv, DMA_RESV_USAGE_WRITE=
, true, timeout);
>         if (!ret)
>                 ret =3D timeout ? -ETIMEDOUT : -EBUSY;
> +       else if (ret > 0)
> +               ret =3D 0;
>
>         shmem_obj =3D &to_rocket_bo(gem_obj)->base;
>
> --
> 2.43.0
>
