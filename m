Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1FDCD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 06:59:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF32710ECB6;
	Wed,  6 May 2026 06:59:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JP8c8gCo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABA4C10ECB6
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 06:59:17 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4977B4095B
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 06:59:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C367C2BCB8
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 06:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778050757;
 bh=mzEIRikL4KeVeSatrSKuHX7MkAVxwP8TiLE+X+winn4=;
 h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
 b=JP8c8gCoQr7HNTiu4HBZDCn15GBTEcbjITWYn8q2z7CX8cIOidOQ4Y1cU5WZ1zzvM
 twKk81tVwbqO0I4zWKuorvxH5PfU7R4lQUM09T/bui1zResy1WmxziSfgQ8RmHbD8z
 ClVitxc/146ubQKmk43UaFY9Tvl1I+pfezBzSTKG755iRqTmgeg6g3rBqDwsv4V7w2
 pOTQv4/ZqeQpahgBHNWg3zw9WVnWy8S+QWranE616j6XibL92DUmlfbNuXRifPJiD2
 8n6/tqcj6qHXGLIn13vD7R9eEc3GK+cVBn/CXUmdGL4K0LnoD8uUouamJDSvTdEdZx
 FXSh39oq6cswg==
Received: by mail-lj1-f177.google.com with SMTP id
 38308e7fff4ca-3938d17d6c5so32758881fa.1
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 23:59:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ+G0aOjOLQ/xCd82jls2DxjaGBhQzipdTN6PSbnFo+IuAuxy4OD4TWnolR52Ci/gUY+hP8QteEaSCM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyFw073K6RmtrMexFNf7feNfl58Xt2VqKJIAkI+4yrbX8PfciGr
 0qeH5RYlu6c9Qof5ckpitHZb2+WblOW8T4lg4TjVdaFxa5Dq9t22PacbymCD7DAIziFTRxVpcBx
 mqeXvxI6qpJ8A6KIHH2qbEBITbNFk8bg=
X-Received: by 2002:a05:651c:4105:b0:383:7f85:8eef with SMTP id
 38308e7fff4ca-393c4322c46mr5819051fa.29.1778050755563; Tue, 05 May 2026
 23:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260423094452.32665-1-tzimmermann@suse.de>
 <20260423094452.32665-6-tzimmermann@suse.de>
In-Reply-To: <20260423094452.32665-6-tzimmermann@suse.de>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 6 May 2026 14:59:02 +0800
X-Gmail-Original-Message-ID: <CAGb2v647JoUuNC_SLkm+wuBRAG=mTJJMu64cnFQHiY7w0of5-g@mail.gmail.com>
X-Gm-Features: AVHnY4JlVYdDeg3_jd87Ba7znQvGv9Y-bpIBk7Ufd1RBDiuOlf3UDCo4TI4b6Gs
Message-ID: <CAGb2v647JoUuNC_SLkm+wuBRAG=mTJJMu64cnFQHiY7w0of5-g@mail.gmail.com>
Subject: Re: [PATCH 5/5] drm/exynos: Make exynos_drm_framebuffer_init() an
 internal interface
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: inki.dae@samsung.com, sw0312.kim@samsung.com, kyungmin.park@samsung.com, 
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
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
Reply-To: wens@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Thu, Apr 23, 2026 at 5:45=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> The only caller of exynos_drm_framebuffer_init() is the helper
> exynos_user_fb_create() from the same source file. Declare the
> former as static.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_fb.c | 2 +-
>  drivers/gpu/drm/exynos/exynos_drm_fb.h | 7 -------
>  2 files changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fb.c b/drivers/gpu/drm/exy=
nos/exynos_drm_fb.c
> index ab0e0c74ec47..66dec2b7a5de 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_fb.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_fb.c
> @@ -55,7 +55,7 @@ static const struct drm_framebuffer_funcs exynos_drm_fb=
_funcs =3D {
>         .create_handle  =3D drm_gem_fb_create_handle,
>  };
>
> -struct drm_framebuffer *
> +static struct drm_framebuffer *
>  exynos_drm_framebuffer_init(struct drm_device *dev,
>                             const struct drm_format_info *info,
>                             const struct drm_mode_fb_cmd2 *mode_cmd,
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fb.h b/drivers/gpu/drm/exy=
nos/exynos_drm_fb.h
> index fdc6cb40cc9c..aeb6f29eb167 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_fb.h
> +++ b/drivers/gpu/drm/exynos/exynos_drm_fb.h
> @@ -12,13 +12,6 @@
>
>  #include "exynos_drm_gem.h"

Nit: you could move the include statement to exynos_drm_fb.c as well.

> -struct drm_framebuffer *
> -exynos_drm_framebuffer_init(struct drm_device *dev,
> -                           const struct drm_format_info *info,
> -                           const struct drm_mode_fb_cmd2 *mode_cmd,
> -                           struct exynos_drm_gem **exynos_gem,
> -                           int count);
> -
>  dma_addr_t exynos_drm_fb_dma_addr(struct drm_framebuffer *fb, int index)=
;
>
>  void exynos_drm_mode_config_init(struct drm_device *dev);
> --
> 2.53.0
>
