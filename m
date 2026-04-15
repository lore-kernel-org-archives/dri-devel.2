Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8386F419A0
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 12:59:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE6DE10E6DA;
	Wed, 15 Apr 2026 12:59:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aadVevOC";
	dkim-atps=neutral
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CCE610E6DA
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 12:59:19 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-12736a0147cso505799c88.1
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 05:59:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776257958; cv=none;
 d=google.com; s=arc-20240605;
 b=R83kWN61YUGzShIyQLlorBfgT3p7cxeS7VHS1dshbdd1RoKXzrxrCE6FkhwADXyqNG
 XFeagBZff0jADNwEXFVspi+36mNoiRYp2pmAihwDmAXdrF+sFRCIxQRJS1PQUTwa0urj
 dtUQK1o0dhva14aWo2jMv5S401w61F08sTieA5U2aCI7s2RZzS1kFjgNc8CYmJVioZ6a
 Gr/5ekGQLYGsQP2EXxwEYZA7fDPCHyXPiC6tdbK+vRqd7pwBXjWPqbce+r4xJuZMPqbA
 bgyRcgf17ClFt467YWY15YtUjIDP7PNzNcazzShY21Z1U8RkpqwhICdMvd0dumZ2s6sh
 JuYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YbAg75inuAX6qfe171ed5cAQ3ilGhu1WuPU93+xAM3I=;
 fh=nGmgvWRGv+/+RkB58zGsnDm7BIxVJhwwTbQ34TJuFLw=;
 b=fm53FXPiF059MvpW9nLYtK6Z7baDnB0hpfOjO90p1nyHvoRjfDmOidQEoASLfXPk/u
 qlZyphIswmyThaAtr2Pg7kUzja6kwPClm3pRBiQiubR8JlWG+5znzeM9CVFK9EC2dyNl
 6+Ci7y7LPeE+ZR3JNwndcJV8Q9DZcxC/4kMdGePRIPyQ1pyO+JppXIzuiZZyAK8FBf8H
 /qHOrYcXLBUvVVXd4tCnMWfwD2INfu65u778JRXwyyd1NRF3pElajmruGeyjr6cgfv8K
 aMhcskizwik57eum8wFOMpQvkZANUbEH3QcZOkcEs3ELJh0KVx5WTdP9cvgpCyH1ypC4
 aYMA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776257958; x=1776862758; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YbAg75inuAX6qfe171ed5cAQ3ilGhu1WuPU93+xAM3I=;
 b=aadVevOCeOwdfmbXK7v5CfA4evDlzDcqOZ755Sok2EvmVOFv5OHs5QpYCTS+6cxvpR
 7rNvvTEQwlHNgluAvHjkIJ6vpaVer2KTd13rRoFkZ3SWfUvDySJ1RUeddsTZGxnScsue
 RK/wBwGVoMm6rHujzWuczz/528cZchfFpC3ipIxHAQu2oXCrGHY1PEl5hndpNJjx2dzB
 duzNaGtSqMn512CbQ+tfEkPnEQFEY9dtsfTHwBstzkKU/YlTRFmoAMHsTUGL7+Wi+4ey
 WaLXFYDHJhsnvrCTM0yQZltqGARMyO/Q+YYuA9qNryNTtHjz/yCYLUwbEFroaSofJHf9
 MrgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776257958; x=1776862758;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YbAg75inuAX6qfe171ed5cAQ3ilGhu1WuPU93+xAM3I=;
 b=jiM9kU4rBem04qqwb+hRCVufQQxtuJY4A0JLipPFlOiZBLKCseUIE4vcyNuYKGcDxT
 dhIatnIWBVi1aerOtQdhP6kLbUNsTb2uvq6vDJwujUaoQ1OLJLunHfS3NTCP5x8dCG/1
 hJNvV2aEHuR9FknLaqARPNrjrmAtbS+g9zaOGohsOaqP3aR6ahUthEaVM7dvWl4t5ZPQ
 V4ClNJQ4kjga5txTOIsO7IJ+dbkADF0V+alpWjwaCrKVQIWKp9LotlHZy4DY5rnMduSh
 LtztCQ3S9/ukj5iN5fzpzpOo7CWahv9zM4SZfNIHk4LCACRWFZ1iAv+nFu/mOW0xAPux
 wHkA==
X-Forwarded-Encrypted: i=1;
 AFNElJ99RRiAIK5tk0pDKtGjR2vM9bSl4g18cesnNAhhtpsY9COcqH9esF7utDm4U3mOTS9tAbfdBOw8+zg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzQ/RFZjc61gi73cf+/CDLDB5rKq/n0nz1ZRdzim2DW4SMr2p7z
 I0d4rIWqgpa36jfQqWGiijREVLIWoA6BwtMFLl6EOu7t2E/w7zcNtujz0bb4R25INsleRS3x2Ik
 M4k1j9INlM0FEqu50s+gspJZwolrpDUU=
X-Gm-Gg: AeBDieuyCP0BgipcqKPyZj6rXAHYq9hN0qBHMr/YkwdazzleDUjt9lp7EOeJ8JFHLty
 3sf7t5Xt3S6TxtAP8HZ6gmMxsywFPTpnXvj0Ern2tC0H8aDGARLX0j1ytbuCCe8lJMTCqnUgRXW
 e+JyFohNKxlQXQCT9kQr1hjfwO3fxLZrVMnUWqBkPIeZ2XxlEkCmPEx+aiq7KrxdZ8bM4FqzqQj
 bkoutHfNtnYmTmio1QwprAZP21OLs8/l1poN4WjffQAluHhausW7JfJSCpAPh0ZGKQYa6Cdc5yG
 NtnqcCXlQ1c+hc+87zL6dVFUU4QmGzsmezBRo6tzjkvUXWyZF4fdhetuP8UNFg3w2FjmJg==
X-Received: by 2002:a05:7022:618c:b0:127:332d:63e with SMTP id
 a92af1059eb24-12c5d4d0c7dmr506525c88.5.1776257958465; Wed, 15 Apr 2026
 05:59:18 -0700 (PDT)
MIME-Version: 1.0
References: <CADnq5_OVN+uCioTWNeuHkGpkUU-VhEio_uMEBMVur6-hWXwtug@mail.gmail.com>
 <20260414211437.154315-1-werner@verivus.com>
In-Reply-To: <20260414211437.154315-1-werner@verivus.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 15 Apr 2026 08:59:06 -0400
X-Gm-Features: AQROBzAeYix9JIhJ4gNGCdBtQrUS7rMQvoooy6xeRQZh2Q7drV282ZxpZgFSuFU
Message-ID: <CADnq5_Prw=X66ByOAutSV_jFCJ7guuRSMPWnEqttr+xe_j_Y4g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/radeon: fix integer overflow in
 radeon_align_pitch()
To: Werner Kasselman <werner@verivus.ai>
Cc: "alexander.deucher@amd.com" <alexander.deucher@amd.com>, 
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "airlied@gmail.com" <airlied@gmail.com>, 
 "simona@ffwll.ch" <simona@ffwll.ch>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "stable@vger.kernel.org" <stable@vger.kernel.org>
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

Can you squash this with the previous radeon patch?  I only applied
the amdgpu patch at this point.

Alex

On Tue, Apr 14, 2026 at 5:14=E2=80=AFPM Werner Kasselman <werner@verivus.ai=
> wrote:
>
> radeon_align_pitch() has the same kind of overflow issue as the old
> amdgpu helper: the alignment round-up add and the final 'aligned * cpp'
> calculation can overflow signed int.
>
> If that wraps to 0, radeon_mode_dumb_create() can end up with an invalid
> pitch value from DRM_IOCTL_MODE_CREATE_DUMB.
>
> Fix this by using check_add_overflow() for the alignment round-up and
> check_mul_overflow() for the final pitch calculation, returning 0 on
> overflow.
>
> Found via AST-based call-graph analysis using sqry.
>
> Fixes: ff72145badb8 ("drm: dumb scanout create/mmap for intel/radeon (v3)=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Werner Kasselman <werner@verivus.com>
> ---
> v2:
> - Use overflow helpers like amdgpu.
> - Drop the stale zero pitch/size change from the original submission.
> - Fix the changelog wording around reachability.
>
>  drivers/gpu/drm/radeon/radeon_gem.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon=
/radeon_gem.c
> index 2cd179fef347..8ce180e22d1d 100644
> --- a/drivers/gpu/drm/radeon/radeon_gem.c
> +++ b/drivers/gpu/drm/radeon/radeon_gem.c
> @@ -28,6 +28,7 @@
>
>  #include <linux/debugfs.h>
>  #include <linux/iosys-map.h>
> +#include <linux/overflow.h>
>  #include <linux/pci.h>
>
>  #include <drm/drm_device.h>
> @@ -812,6 +813,7 @@ int radeon_align_pitch(struct radeon_device *rdev, in=
t width, int cpp, bool tile
>         int aligned =3D width;
>         int align_large =3D (ASIC_IS_AVIVO(rdev)) || tiled;
>         int pitch_mask =3D 0;
> +       int pitch;
>
>         switch (cpp) {
>         case 1:
> @@ -826,14 +828,12 @@ int radeon_align_pitch(struct radeon_device *rdev, =
int width, int cpp, bool tile
>                 break;
>         }
>
> -       aligned +=3D pitch_mask;
> +       if (check_add_overflow(aligned, pitch_mask, &aligned))
> +               return 0;
>         aligned &=3D ~pitch_mask;
> -
> -       /* Guard against integer overflow in aligned * cpp. */
> -       if (aligned > INT_MAX / (cpp ? cpp : 1) || aligned <=3D 0)
> +       if (check_mul_overflow(aligned, cpp, &pitch))
>                 return 0;
> -
> -       return aligned * cpp;
> +       return pitch;
>  }
>
>  int radeon_mode_dumb_create(struct drm_file *file_priv,
> --
> 2.43.0
