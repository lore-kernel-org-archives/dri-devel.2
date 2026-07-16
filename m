Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252E0C4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:31:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EECD10F316;
	Thu, 16 Jul 2026 13:31:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VfljxeEM";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A085C10E37B
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 13:31:48 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-3856d4015e0so943146a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 06:31:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784208708; cv=none;
 d=google.com; s=arc-20260327;
 b=pfY+F+avNmJqQfn58vdVyrNV3Yz+CD4gVqQvEf3udQl+E1DGsL+Alvssqx2y5dZC0g
 PTuF9ICiRm52vcEShLFRNgum5aQ6WOGgLwduB4sRWCO/zJoMAFMqBOdalQdPeDgIxvf6
 zFAeojpGFzB9gPLtuZCk8wbVlMvk1PrivATxCgjThJ06pnv6vyWleoN63m4ERwteIN9/
 GNCXR1kCHvAZ8m2g4xwbjljJAWi6RYtvw+YRiATCewHRGWaZBA+YrsE+NbI7lmbv6hpA
 1NH4Re9JRm7l60bc47aHVLR/GGF+0TxFc1BbKGZy19rEoQQwvX7aI1WlkijbUwQKl2Ww
 qvTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=L9EPVrSfRLnUJCuiMGZiYyO4X0gEsxu1t+W0Qw5ky7o=;
 fh=Db04f20BTCy7du9yH2HBCUNd55niM/pGvXBoNEIOzYQ=;
 b=ELHYQjEKMKxTP2uOrnOAKoz7k3z5pfmC7dag5ZARZlIxYmQRMt650pBKhkTYnPDjEB
 NvzQeNN4H9HQRlm+8y4dbYq/ITZN+vNhy33G+5cINJAR1e1BYpTBD+vIGDjkSLrHh1nh
 +p4ntYBVTv+xfdSb+8D2E2Yi5aXy81F4/iiTFTWAVOTtyoOLeKMixhPuA0u0lblmh+IG
 YKjEp0tb/jIevMHVIKOksegvoyAG9Ktex3L0a1brIZcwMJ9kLhKO+eSlDUKO7ZweoMU3
 9yfAREy/2DZlqouACTc/WoFkDGdMvN9CYRIVoYIiugpuM0YalBO7LnsAxtoptS4tZy1T
 DFgw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784208708; x=1784813508; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L9EPVrSfRLnUJCuiMGZiYyO4X0gEsxu1t+W0Qw5ky7o=;
 b=VfljxeEMRE68lcQDSUA7fgqnLvIuB5HZiJrPcx7cOm8do6phBBUalMTwOcslAuItK2
 mOYueflO1h/nZdtw5l390BkT+ij/5T35vgar2ij7V9yvC0yu2EHw9jXp8TX9eWZzcLzn
 04L6724MDpQ5/a1E7HIFsyqPznDCH9uLGPVbm1xGV/h9u+GnUrsGC//s4S8pOUAx4uyN
 GkqfrvNZ5hai81z3CbCp80hsfWU9lFvYPk3p5K+tFnGT4pNhXBeb156W80PJrGhYQ+FV
 Fkvj9zIcYFOp8fzfPP5kGl81VV3haUhtwkGs+hhMuGrpbIUkdmJ7Ej2KvWWbXFGNB80L
 lYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784208708; x=1784813508;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L9EPVrSfRLnUJCuiMGZiYyO4X0gEsxu1t+W0Qw5ky7o=;
 b=g/hZdQDhaI7thBcjGjsxrvuRF1U0ZJN3rug0uWMpYu2nLQ1wVnHZrybDgdkw133z2h
 6PGlFv805bScqI7os8afv3dfu4lhAxibTxLLQDbeWpcwl64P63bKxssQCA3UuKO15X6P
 tgYmaeOykno6Fcp2lS/yO6xabjanhbYSIRbgBYDHbCHfZYwPK0gzsK20fLEypodPLRM0
 76MNYxnM8OiAFBW1U773DCAqKyk/AZ5lNwWNYOY4eBSagRzhQbzAex0KvLvsyoBeKl/y
 pBw1fSVlqKGoCOyLEkMFWZkRLojmDaabxpLdJF/2fBBmQ4koX1n0J3RO/n9yyUEy/Xov
 5rUg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoqKZvOfJXsV3oILrv07KmxTtz4FLQrcxio6GdwCnSqDgr6jRPxq3uC7SzdwZc6jHUMoZR1/0MQqBk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzxABc+7GA9JyFRUwJ6cZkqTW/0Jf0RefBkwf6FsM7IqcoPPnV6
 X9SBYqs1Ja3G7rj3Hu+Jp2EbwYeLoYzPn9tK9KHlsV1yKS3LB3RGo6K3exJmzwKBO0kscOcCHhI
 Z2MposvqArTGdicpVyp7aKxSz7oeCOXo=
X-Gm-Gg: AfdE7ckKFj1+roEzP406M+11U7TqZLyMl3nCXBr3ZIF9FBlKy7WaVTNgt+ZocOW3flq
 vowv8OaXh1fM9bYN7JAfVEh2WDYmxAF/p7Y+Ir/PeKMJGLEv1+UPfsSr2XVYYLICZjQB8S1cY2S
 9dtcq8Jkex2ch2hErVpX0MeysOBax9IPCeS92GZ88UKgYSy3X/p7NK0DJOkrLInJc1gyJ7Wn16p
 0MEg21jKsNk0LVPq8AZq/7GJYmn7OX4saY0bk3kl5w8xWab3OYrT9/L/2jZNevhoo7cj1zuuvr0
 DFiUTRBSrl337CHblrx5pB6iNkkNc1oIZxXpqbq6xoMiBFsm
X-Received: by 2002:a17:90b:564c:b0:37f:eda5:516f with SMTP id
 98e67ed59e1d1-38dc760604fmr16112285a91.0.1784208707925; Thu, 16 Jul 2026
 06:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260716123646.1933293-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20260716123646.1933293-2-u.kleine-koenig@baylibre.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Jul 2026 09:31:35 -0400
X-Gm-Features: AUfX_mw91-WulFiTIn96-pWiC0oRVioqeCJ6cIWsVesGEKRmY4KxYzLzHLTYcMw
Message-ID: <CADnq5_Ov7t1LQh908G69vRRGkB+mHAMaKss3_zdAYno3ALKB3w@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Only define radeon_acpi_vfct_match when
 actually used
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Mario Limonciello <mario.limonciello@amd.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Applied.  Thanks!

On Thu, Jul 16, 2026 at 9:04=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> This fixes the build failure
>
> drivers/gpu/drm/radeon/radeon_bios.c:614:12: error: =E2=80=98radeon_acpi_=
vfct_match=E2=80=99 defined but not used [-Werror=3Dunused-function]
>   614 | static int radeon_acpi_vfct_match(struct radeon_device *rdev,
>       |            ^~~~~~~~~~~~~~~~~~~~~~
>
> for builds with CONFIG_ACPI unset.
>
> Fixes: 33a18ecd2fbf ("drm/radeon: Fix VFCT bus number matching with soft =
filter")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
> Hello,
>
> 33a18ecd2fbf is currently in next via
>
>         https://gitlab.freedesktop.org/agd5f/linux.git drm-next
>
> .
>
> Best regards
> Uwe
>
>  drivers/gpu/drm/radeon/radeon_bios.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeo=
n/radeon_bios.c
> index cc10880af096..cd7a5d458157 100644
> --- a/drivers/gpu/drm/radeon/radeon_bios.c
> +++ b/drivers/gpu/drm/radeon/radeon_bios.c
> @@ -596,6 +596,7 @@ static bool radeon_read_disabled_bios(struct radeon_d=
evice *rdev)
>                 return legacy_read_disabled_bios(rdev);
>  }
>
> +#ifdef CONFIG_ACPI
>  /**
>   * radeon_acpi_vfct_match() - Check if a VFCT entry matches the device
>   * @rdev: Radeon device
> @@ -635,7 +636,6 @@ static int radeon_acpi_vfct_match(struct radeon_devic=
e *rdev,
>         return 0;
>  }
>
> -#ifdef CONFIG_ACPI
>  static bool radeon_acpi_vfct_bios(struct radeon_device *rdev)
>  {
>         struct acpi_table_header *hdr;
>
> base-commit: 33a18ecd2fbf6bcbf803836e94eb31c26f4c7f41
> --
> 2.55.0.11.g153666a7d9bb
>
