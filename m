Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C6CF436A4
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 13:34:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8028710EA1D;
	Fri, 17 Apr 2026 13:34:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SuUQ3+Ep";
	dkim-atps=neutral
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CC9E10EA0F
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 13:34:55 +0000 (UTC)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-124a7216c9cso30408c88.0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 06:34:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776432894; cv=none;
 d=google.com; s=arc-20240605;
 b=iYPTYSyQj6KwxIEAeX0vpxhXiw1P+/C1JWFazG4/lIKEBF1NCDuzOoh7ySBGjU83Tq
 1/b4ma4NE5TBkZp8yGj+nCcRvaHr5+Rl/NZRmomoYTIvR8BKlZd7hzREV7sSh4HYu/ky
 AHlM16fcRtTZpsy1hgwmX311XmyJMDiKq4weL/WQ224xZS4Nb76gxkX6FBRP2cmhsIuA
 p4tdC51W3lttwpRF/j1KV/v1OdniPpjvovIPpWR+wtLBu1fASyruEQNERapcuDiSXdBb
 zBz9/99eHYW6IuM/ajSIhEzYtXB5zchDz1SJBulTQFZuLWb2QcsVM/MaOD/sqj0f1D0z
 KLfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=H5SQjdAFcyv8NdqIsfRQOzzA0lu5rNy+ZmGTAor1otU=;
 fh=YzV4BPyDf6KQ1zhAlcAEhV957Kmp1mWQWlW93f1owZA=;
 b=cVlCCQe8UtTdknQPnNBoRxVaRZYlmuLWGPn/U/+elbg9UHAyCg2/oA0VwE4U8UxFWQ
 t5Jx0Xjm8W2nz63wHVr2fckb/Oia8rg2rCwwCaXZ3PajDNvCtCDdfZn6k5/2UHgDs61o
 Xde4OJM9vsxn9r2913Y4gf5ggF1Plp4Dv04oZClTZr8+4od4/o1R0X8JhwgxonbWrlKJ
 pIsnxIC3XQmjVVUs208GYPE4xOA6r5m3D5YwB2MTsfnMCBMvFZPDouWiGe3LmDb0AEdu
 GqAK8ougQ5flGgz+LUSpvaSsTulSP918MkDVblf3955qEydx4T1VyMCkO/49WtA7Hhhz
 kaZw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776432894; x=1777037694; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H5SQjdAFcyv8NdqIsfRQOzzA0lu5rNy+ZmGTAor1otU=;
 b=SuUQ3+Epprzx87ktui4oWAwGtBml/z7LXmDoLB2Crhz5DnYFDnMMsdTpLO5hBxdT5i
 z4l4SpfTzgfG/DQh0bDnHSvuMNQKUBmtkq0lZXCUoMXaSkrBvxBvdaaAqqM/DqZGWnUT
 GUWdVGrF74goxAAc59PJbf2PtDq/HjVYsP1rXbqUFyxT32at0c9I0T2z7cC38HwDObNl
 BvlviT5rc4CICSvTvSBZsbhl+OdCUKbPCJua7yTwSp9GywHNU5sePbKqC5dNXv/hczqN
 oimpXm3/Tw4xIvjBUoEZEL1UVDMpWxGUtCWNZAmzj0rSPQGkoIy5K9/qCQWVUtbcFp1S
 7TuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776432894; x=1777037694;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H5SQjdAFcyv8NdqIsfRQOzzA0lu5rNy+ZmGTAor1otU=;
 b=lDa4ZYbEDthf4outY51q68hvLtQbvFgFjsNdR903HYt4vSOl9y8J0dFr0FlR9J1UqA
 c91erw7U58hM3uuwU3UY6/gyE3JNr6l9ktrOlzJX8Zlb0O2gL0vp6PY35lpvfvzXkUEz
 EPjiVpDKJ5TNL9+it9O3DFQdM/QoEAZgO13qREIvgClCyta+/7ibttCqQJQvm8cRMWkq
 DQYNACa9Jmvsz1vmhIY+KNhaIyH2lZWoMTgoxbSD2ilOLJj6hWeT/p9xXoJ345mPUKvM
 A4tF+v5bYGpk6zhgmgBOLwn9I9edmC00JBlfxt9JcLTMhtei7mLo0ljupOawej72xLHJ
 qmuQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Z3lTGX9tm5tbGAs0XA+k6L2h+rco0mGhG2vtZQg+AM2KgSLOWMUFOm1kV6OCAgjfEOc5F11q/PXo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz7P/WZNK6728Axri2BKpLA96+jeF0CI+CNJg96NkomsTERqiBP
 mdknKgeIvBk+EOsRroIZKfVj7pHR9dZPif/zDdSLRBXB3GB6qe94orkHH7qj1JfB8aLzXCsxxHL
 LNeSoJhRHXJRLOdxf2jGKzFtiK90mqrc=
X-Gm-Gg: AeBDietOHkp9yOxDfMwbzn8oGu9uBYfuN4SA9X0ztKAgRIrwEgWePlkbb6iAyGrgLLj
 +P1wHY5aNxkm8+INbcsvOmLRe18PYvfab1M/EOFa82CtkY5VkB//R8VdNFdjSoqmZwtP6FDsiwJ
 rlpxiS8+ce0+PGeIDANkKJyFQ+yM0D0ucKe5UVl7i3bHj2ZPoUVnwn0QPeHlVCBojkw7oeam2OE
 1V1EEHKMwKy5z8eCrLQs4ycDqboJcO/gG3h+xB7XFY51upDTmD+rRWd7A+IWWFBYlmNNswLAdgW
 aM5v6rHasQCVSUApvaNLuNcLGCvso+nrh2mlX6ZzIB55BgtWKMEqLjy/RO1okhswYY3u978SXxd
 +6XoS
X-Received: by 2002:a05:7022:928:b0:12c:33dd:fa0b with SMTP id
 a92af1059eb24-12c73f69c12mr560921c88.2.1776432894188; Fri, 17 Apr 2026
 06:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <CADnq5_Prw=X66ByOAutSV_jFCJ7guuRSMPWnEqttr+xe_j_Y4g@mail.gmail.com>
 <20260415221350.1178094-1-werner@verivus.com>
In-Reply-To: <20260415221350.1178094-1-werner@verivus.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 17 Apr 2026 09:34:41 -0400
X-Gm-Features: AQROBzBNKLgUz5j7LnoNFi5Ad4rOoyX0l8ZAuNVWt5YQYXWOh6GE9S_RYf361NE
Message-ID: <CADnq5_M4Rr2ifOoCrvLqiqj9H6tRgKOY3Tn6NqyUB3YziicqZw@mail.gmail.com>
Subject: Re: [PATCH v3] drm/radeon: fix integer overflow in
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

Applied.  Thanks!

On Wed, Apr 15, 2026 at 6:14=E2=80=AFPM Werner Kasselman <werner@verivus.ai=
> wrote:
>
> radeon_align_pitch() has the same kind of overflow issue as the old
> amdgpu helper: both the alignment round-up add and the final
> 'aligned * cpp' calculation can overflow signed int.
>
> If that wraps, radeon_mode_dumb_create() can end up returning an
> invalid pitch or creating a zero-sized dumb buffer.
>
> Fix this by using check_add_overflow() for the alignment round-up and
> check_mul_overflow() for the final pitch calculation, returning 0 on
> overflow. Also reject zero pitch and size in
> radeon_mode_dumb_create().
>
> Found via AST-based call-graph analysis using sqry.
>
> Fixes: ff72145badb8 ("drm: dumb scanout create/mmap for intel/radeon (v3)=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Werner Kasselman <werner@verivus.com>
> ---
> v3:
> - Squash this fix with the earlier zero pitch/size validation change.
> - Use overflow helpers for both the alignment round-up and final
>   pitch calculation.
>
>  drivers/gpu/drm/radeon/radeon_gem.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon=
/radeon_gem.c
> index 20fc87409f2e..8ce180e22d1d 100644
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
> @@ -826,9 +828,12 @@ int radeon_align_pitch(struct radeon_device *rdev, i=
nt width, int cpp, bool tile
>                 break;
>         }
>
> -       aligned +=3D pitch_mask;
> +       if (check_add_overflow(aligned, pitch_mask, &aligned))
> +               return 0;
>         aligned &=3D ~pitch_mask;
> -       return aligned * cpp;
> +       if (check_mul_overflow(aligned, cpp, &pitch))
> +               return 0;
> +       return pitch;
>  }
>
>  int radeon_mode_dumb_create(struct drm_file *file_priv,
> @@ -842,8 +847,12 @@ int radeon_mode_dumb_create(struct drm_file *file_pr=
iv,
>
>         args->pitch =3D radeon_align_pitch(rdev, args->width,
>                                          DIV_ROUND_UP(args->bpp, 8), 0);
> +       if (!args->pitch)
> +               return -EINVAL;
>         args->size =3D (u64)args->pitch * args->height;
>         args->size =3D ALIGN(args->size, PAGE_SIZE);
> +       if (!args->size)
> +               return -EINVAL;
>
>         r =3D radeon_gem_object_create(rdev, args->size, 0,
>                                      RADEON_GEM_DOMAIN_VRAM, 0,
> --
> 2.43.0
