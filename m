Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7906CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 21:03:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 115D110EA13;
	Wed, 27 May 2026 21:03:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lgxk+bCw";
	dkim-atps=neutral
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D15310EA13
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 21:03:16 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-5a8dc2606a0so12179943e87.2
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 14:03:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779915794; cv=none;
 d=google.com; s=arc-20240605;
 b=Avy5tztCp+gRdlGIeEPAwGXz6OpeBo7K3OMZXN0WobLJcMeYnimGBHk8ihCNnJSeRe
 F4PbclTNg5gcDO37BfkMOkDbyTt34OGKy2uGgLWuo0dFmNcJOkursLBnXA9yskUNqb+F
 qMRxtMiGtmyPSxEqMm9uDdiaa3tli51ikUxjEee4Ch0bXCeaVlVSu7ssdpCYpLuI9DX0
 ws0x6tluPTZKsUE8o4Kpzk1JAUWjU8xPTJvtcMg7KPzsYn4gU4Zk93BPkxSTyefuaP6w
 SqvNHuVCvm2KTjPrk56w6nHbXdRo6S1m16ENamdTwDOp0fKTf/H87q93VvxtGo8Pq8hs
 dZEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VM4t7RohIYKOVlucu8IYIFbInmIydQz2ONIivwoDCeU=;
 fh=0l319tX+hp0Fjf4Zc+kLGbfJCtj0Q9B2J2wF/81WY7I=;
 b=VdDEKHjmddzRsKpLLF2KGlvBx+mp3jIKAa2XS4YF294zOCegNH6EjmYHSs5XuTiFjQ
 b5Q4zO/NjJ4X5XuPW9/DO+D7AO3yG0kRYz9+uEV6hxtCelQlNoj+r0FcDDqmHMxJ8LKd
 5gGpKTSIG5vdfFAfuxpbOoQuUswHoW/YcrZ4jXAOhW0IMZsf0jy9GLbfS/n+X27R6Hhy
 vP3YMmhxjikY68VtIl6l7trEyOY4DgzjREaI5lDZaME/2xwQFJ0VnXccwvgdgRmzavby
 XRnvRulonmr6eKK4eWw7Bp/ms92xgBo+JV94DXe2vd3N8vIt8QwKabQz4y59RkijryY1
 TF0Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779915794; x=1780520594;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VM4t7RohIYKOVlucu8IYIFbInmIydQz2ONIivwoDCeU=;
 b=lgxk+bCwJeE4qMXXQ8VGyGUB/0uS6xry7AF+cRnSYT/b4E+GXpD6C6DUiCj+N94vbI
 8UX+l6PhWn2ANbz6Re8KrVAZNdw9HaeFhiC7TWWS0gv7lMANftMGBkIvzUJhAgizO9qp
 Bs5aZDANUdTO2DcMl9KalJgoqjqgz+qd1sbvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779915794; x=1780520594;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VM4t7RohIYKOVlucu8IYIFbInmIydQz2ONIivwoDCeU=;
 b=cdOhYAlPjywIiaeVgwhJfWZbuEXykkBRkj9qsi8RMSTSfnRk1vEiQfCfNN5Zoy1acH
 UKKqtcvdFM1mr5VvptMMS63J3Hfs2UeaSbBv9jaqpdhUiC4Wr1ZRFYzJ9DL9JfiKG0mL
 jrPaGZsY9rOvaP/G6Vae/TIEeALqca2uXFCz4Y0jr5KZmZ/Fs/5/V/EuJY4/raMDKLyj
 k/87JItxATo7TJbT582aYEIOgKA6LbQSk1NRzJwnMHcggd81Lew37MY5p86VPfLJB6zN
 WinIcmFis48jA45EanlYuhPDTGCbe+9lcB14LXhjSxbD59luPZhtvy8SNYK6sROf11u+
 rUAA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/84Cd0sp1j/Z7O6Ba6OTrIV4drpqov4ztpEsXfuTg6I+q2eRxsOtWQPBcFtHzKNmb8zCHkeu4RtP0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YygWqA3nXtRoE2Gy6zA1baV+ply/Y+OeWBp+SbpS7FjoLMaZ46R
 NKB7cHQeLW4eIwfuMJlJDpozURdX1DdtR5Hd3pFitj94rdV5nU7ArrzcM7btMqqwpsLXEfEHlNA
 7LJRcnyHW4zSCH5167GPjGvNhFOBw/L6UYXzwAjj8
X-Gm-Gg: Acq92OHBGZGcXQbqKHiE05dqMHSvBY9dGVic3qkTCA31CtYnjHg20ldRpVoLItn/H2k
 YmufjX1SddMrE0424veUCN01jHj6cORN4xEDhtuJSAPhd+302R0Phd18yGGKGKb+yTnEP/VLu+S
 hpfAVC+7tPpVo1ENE/uN6uWdC9xwecKP2Tvxd/TOb7ACTM9B/Jf084I2LdLIsIGDrE6SWHxXNgz
 7X5lxow8gcl8GipGCm2IzmiwC0I2p9Z3apCs7wVR9vIh1mZBE1qhtji7f36sAAc31by1I95CqR0
 b8B8tuaERo1o6m/sUw==
X-Received: by 2002:a05:6512:1243:b0:5aa:116c:4127 with SMTP id
 2adb3069b0e04-5aa323a9065mr8608773e87.41.1779915794436; Wed, 27 May 2026
 14:03:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260527194525.45762-1-arnd@kernel.org>
In-Reply-To: <20260527194525.45762-1-arnd@kernel.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 27 May 2026 23:03:03 +0200
X-Gm-Features: AVHnY4LRzDDBlNjN91IVgQeLtIl2oIQHuVQ0PjzTLkjbwtceKRBrVHRW4l0ArGU
Message-ID: <CAGXv+5HvJiTkLJMZ13w0OHwgp+nPBftGAC-15nhJ3R=vOPWpUg@mail.gmail.com>
Subject: Re: [PATCH] drm/exynos: fix size_t format string
To: Arnd Bergmann <arnd@kernel.org>, Inki Dae <inki.dae@samsung.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Krzysztof Kozlowski <krzk@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Arnd Bergmann <arnd@arndb.de>, Alim Akhtar <alim.akhtar@samsung.com>,
 dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
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

On Wed, May 27, 2026 at 9:45=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The exynos_gem->base.size argument is a size_t rather than an
> unsigned long, so adapt the printk() format string accordingly:
>
> In file included from drivers/gpu/drm/exynos/exynos_drm_gem.c:16:
> drivers/gpu/drm/exynos/exynos_drm_gem.c: In function 'exynos_drm_alloc_bu=
f':
> drivers/gpu/drm/exynos/exynos_drm_gem.c:69:49: error: format '%lx' expect=
s argument of type 'long unsigned int', but argument 6 has type 'size_t' {a=
ka 'unsigned int'} [-Werror=3Dformat=3D]
>    69 |         DRM_DEV_DEBUG_KMS(drm_dev_dma_dev(dev), "dma_addr(0x%lx),=
 size(0x%lx)\n",
>       |                                                 ^~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~
>    70 |                         (unsigned long)exynos_gem->dma_addr, exyn=
os_gem->base.size);
>       |                                                              ~~~~=
~~~~~~~~~~~~~~~~~
>       |                                                                  =
            |
>       |                                                                  =
            size_t {aka unsigned int}
>
> The dma_addr in the same line is already printed using a cast
> to unsigned long, so change that similarly to use the correct
> %pad format.
>
> Fixes: 11e898373fba ("drm/exynos: Drop exynos_drm_gem.size field")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I posted the same patch [1] one and a half months ago when the culprit
patch was queued up and I got a report about this from the bots.

Inki hasn't picked up my fix yet.

And it seems the exynos-drm-next stuff was only merged into drm-next
yesterday, now causing the warnings to pop up all over.

ChenYu

[1] https://lore.kernel.org/all/20260408064936.1342321-1-wenst@chromium.org=
/

> ---
>  drivers/gpu/drm/exynos/exynos_drm_gem.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.c b/drivers/gpu/drm/ex=
ynos/exynos_drm_gem.c
> index 297a93b087cd..8e357f2beb9e 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_gem.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_gem.c
> @@ -66,8 +66,8 @@ static int exynos_drm_alloc_buf(struct exynos_drm_gem *=
exynos_gem, bool kvmap)
>         if (kvmap)
>                 exynos_gem->kvaddr =3D exynos_gem->cookie;
>
> -       DRM_DEV_DEBUG_KMS(drm_dev_dma_dev(dev), "dma_addr(0x%lx), size(0x=
%lx)\n",
> -                       (unsigned long)exynos_gem->dma_addr, exynos_gem->=
base.size);
> +       DRM_DEV_DEBUG_KMS(drm_dev_dma_dev(dev), "dma_addr(%pad), size(0x%=
zx)\n",
> +                         &exynos_gem->dma_addr, exynos_gem->base.size);
>         return 0;
>  }
>
> @@ -80,8 +80,8 @@ static void exynos_drm_free_buf(struct exynos_drm_gem *=
exynos_gem)
>                 return;
>         }
>
> -       DRM_DEV_DEBUG_KMS(dev->dev, "dma_addr(0x%lx), size(0x%lx)\n",
> -                       (unsigned long)exynos_gem->dma_addr, exynos_gem->=
base.size);
> +       DRM_DEV_DEBUG_KMS(dev->dev, "dma_addr(0x%pad), size(0x%zx)\n",
> +                         &exynos_gem->dma_addr, exynos_gem->base.size);
>
>         dma_free_attrs(drm_dev_dma_dev(dev), exynos_gem->base.size, exyno=
s_gem->cookie,
>                         (dma_addr_t)exynos_gem->dma_addr,
> --
> 2.39.5
>
