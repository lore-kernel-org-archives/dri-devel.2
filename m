Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6378CA5FEF
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:17:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0467710E192;
	Sun,  4 Oct 2026 16:17:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Las41ME1";
	dkim-atps=neutral
Received: from mail-yx2-f38.google.com (mail-yx2-f38.google.com
 [74.125.224.166])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6787E10E192
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 16:17:52 +0000 (UTC)
Received: by mail-yx2-f38.google.com with SMTP id
 956f58d0204a3-6768036283dso560967d50.0
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 09:17:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791130671; cv=none;
 d=google.com; s=arc-20260327;
 b=YBumdIqUYDhvDNfOxmk5GXBXSvv+OQoVF/Xw5np3fm7Uio+MGpMor03PFamk0huL+V
 SxNdF3EFx1nWMLsDXQmkLvG9tx+Tt9UJMI0RITEBkruL/suNvIjoakqfjb779TFiBZJg
 ItHhWWZCgJ0matGLCRbFh+cCHFH4c5NLMgZQkpfrUL5YVuDEzY9c4dwazovoEJ3vRDyY
 3WJbcz7e0DNwYqivuCUhqCfs+YC7hkC9Js6QqoajO05vqirRLwCLZAIspDJqMansdX7C
 veB8sbNjhD/Z68FWN2kkUhOhjnNQgh75eQhK6DH48G6Bw5UNQt5H+2fYfqWBFJo4lXmC
 mquQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/tchJIk+lKINiAanpGCL5WbtkLidxV2OcRDCiQWNgmo=;
 fh=CXWMrIYqruRLwOMDS8wnQgSPEXGT+97Y7U7NOJGFq8w=;
 b=VaxCInMWygnRmSIn0n14uyXHn+VyIPd3Pg4eZZ4JSOc9Gl8g3TraCnmiKOKRUc8iHK
 OeGKsEea3D3DtTVjW+YGQWDYqanbDC5fDfI5tCMqXCMM85BQAnvnOXUvrdnL/xzbbEPM
 O+i9pDAQjVM7W5GCWOZUZrsLFfyjGtCmeHdimkmz9AEMS1FHVpJvWkGp+7OnnkSf7P/d
 vRvzHacz/Dwu1nvjG2I7MvtDzyO4BDy8tvT0aZwkfsMg+y+4tYWt9vYsYWowsg0nWc8i
 8nkpcd+73PDEiCVxGl6PbcwW2WQNY8/+S7G76M0uxhxEjgNBrZEebAeK+0Hx64/+rQTK
 VCIQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791130671; x=1791735471;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/tchJIk+lKINiAanpGCL5WbtkLidxV2OcRDCiQWNgmo=;
 b=Las41ME1qFd1+3HfciH0RicqOuKJWAwbQVERAvEhQGfy4KYPSVqZxrI7Ru+0JLdFAV
 rfay5Q2EJaaPn09IKubUyjlHz6gbLj5WJepF5EjjFVQHULvaw9Q8FsynAWXrJJi9cPgn
 lLphtwUHW05Byd2PqUS8tRLNLdV/XrRxLDWmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791130671; x=1791735471;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/tchJIk+lKINiAanpGCL5WbtkLidxV2OcRDCiQWNgmo=;
 b=0ZWf55pj1CUegYmxvYusfh1Q5NscieWhkp8MYDj/B+DpZvGw8Nzs3iSMvPj0ScI9rs
 h1tG7fFlF3RWv51z6e7S9OGA+Uy9TyMIvF6+acG0hc/qpGD9vFAcDX+ueXLphdEPB+pU
 aygQ3e0+DRwur96F5LLNxgTPjkRO6XbyV6zvSqgEikYO3Rj/pd4jiacPF5kY1ld0gfni
 FdDhBbjRt0GyJpODL93NSs7hl0Pyi1D/lMFG08mF5omGqT+G85J05VU2zFEZ290Cx5jr
 TvG85b1D9ltSfKhox/yq8mukrSazPAQ+dVaWh7cI6FlOhWh0C3kKM0k0+jEkN/VChkt+
 wb3w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxnkwQuMP8TBmIUm5MYUkcT8TbX0wJtO+h3/glEFYDtlzWrzshJcuKkEbeVMw2Cp2LCsXKue4CXhww=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK9YedlrQk1V4+GN+4LGQfOdehYQH7fjiJ3VH9MhrbiEqP84bAB
 tk+I0trtIvA/h8sF++BNHhQqT71i847E5Gxvb240KckQmG8835CbQI1XBeR03UVI9AdsuSTu07L
 NEgq2t5RaTSPA6LspJzKIYNhHu2/JUXMpotMGra4D
X-Gm-Gg: AYBFou2D9hFBJm1tOpI0t0G5cE6fi1SU98wHmvHzqfjatxWpl9tQtmj50f5hxJDS19G
 xYpgmNCAGruMoj/Ol6q5K/6FgxbSu56WBdHCu8GhVYh1Qy8ymNgSbnlazH680RKzFDyaARDTiP6
 kU/XiLIingfZJimliSIiv3zkxH1kCd0bD7XXxlBQZVHqnYvSyB0rJZAr5IDcrR697PiNBHwh+rG
 e+KED97xCZfbYMyoo+prp6ToyR39atzx63R0jklCiWyaDQvZXVwp71/jt27sHNMMWUzThusx4S4
 tXCNGOLlHuygkcEsayQu91llHtYURa70Mn+Vq1Fs7r8kHqFwKZnPv61h
X-Received: by 2002:a05:690e:168a:b0:677:af43:e268 with SMTP id
 956f58d0204a3-677af43ef66mr2978859d50.113.1791130670771; Sun, 04 Oct 2026
 09:17:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260803135249.2898083-1-wenst@chromium.org>
In-Reply-To: <20260803135249.2898083-1-wenst@chromium.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Sun, 4 Oct 2026 18:17:38 +0200
X-Gm-Features: AclHuK8AbiOI1d3O1oMAtq-YB9tfgZCN1siOUfw9uTtQBVIHV68l-lLxUKSjvHc
Message-ID: <CAGXv+5FS7gLB7-koaPKMqjtMPjOSWguW9NN_tS+8Wi2GTSHYEQ@mail.gmail.com>
Subject: Re: [PATCH] drm/exynos: Set supported modifiers during plane init
To: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
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

Hi,

On Mon, Aug 3, 2026 at 3:52=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> wr=
ote:
>
> The exynos driver currently checks the modifier in a helper called by
> the plane atomic check helper callback. This check only concerns whether
> the selected plane supports the tiled format or not. This is tied to
> the plane's hardware capability.
>
> Turns out the tiled support was added around the same time modifiers
> were being plumbed through DRM planes. The latter provided a way to
> describe per-plane modifier support.
>
> Add a field to the hardware plane capability struct to allow adding
> an optional list of supported modifiers. This is passed to
> drm_universal_plane_init(). This also allows the core to generate
> and pass to userspace a list of supported modifiers for each plane.
>
> EXYNOS_DRM_PLANE_CAP_TILE and the existing helper are removed, as the
> check is now down by the DRM atomic check.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Any chance someone could take a look at this? This drops some redundant
code.

> ---
>  drivers/gpu/drm/exynos/exynos_drm_drv.h   |  2 +-
>  drivers/gpu/drm/exynos/exynos_drm_plane.c | 30 +----------------------
>  drivers/gpu/drm/exynos/exynos_mixer.c     |  8 +++++-
>  3 files changed, 9 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.h b/drivers/gpu/drm/ex=
ynos/exynos_drm_drv.h
> index b126cd129944..ab0edb826261 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_drv.h
> +++ b/drivers/gpu/drm/exynos/exynos_drm_drv.h
> @@ -92,7 +92,6 @@ struct exynos_drm_plane {
>  #define EXYNOS_DRM_PLANE_CAP_DOUBLE    (1 << 0)
>  #define EXYNOS_DRM_PLANE_CAP_SCALE     (1 << 1)
>  #define EXYNOS_DRM_PLANE_CAP_ZPOS      (1 << 2)
> -#define EXYNOS_DRM_PLANE_CAP_TILE      (1 << 3)
>  #define EXYNOS_DRM_PLANE_CAP_PIX_BLEND (1 << 4)
>  #define EXYNOS_DRM_PLANE_CAP_WIN_BLEND (1 << 5)
>
> @@ -112,6 +111,7 @@ struct exynos_drm_plane_config {
>         const uint32_t *pixel_formats;
>         unsigned int num_pixel_formats;
>         unsigned int capabilities;
> +       const uint64_t *modifiers;
>  };
>
>  /*
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_plane.c b/drivers/gpu/drm/=
exynos/exynos_drm_plane.c
> index 5c04ef87e400..31f5f0941154 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_plane.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_plane.c
> @@ -174,30 +174,6 @@ static struct drm_plane_funcs exynos_plane_funcs =3D=
 {
>         .atomic_destroy_state =3D exynos_drm_plane_destroy_state,
>  };
>
> -static int
> -exynos_drm_plane_check_format(const struct exynos_drm_plane_config *conf=
ig,
> -                             struct exynos_drm_plane_state *state)
> -{
> -       struct drm_framebuffer *fb =3D state->base.fb;
> -       struct drm_device *dev =3D fb->dev;
> -
> -       switch (fb->modifier) {
> -       case DRM_FORMAT_MOD_SAMSUNG_64_32_TILE:
> -               if (!(config->capabilities & EXYNOS_DRM_PLANE_CAP_TILE))
> -                       return -ENOTSUPP;
> -               break;
> -
> -       case DRM_FORMAT_MOD_LINEAR:
> -               break;
> -
> -       default:
> -               DRM_DEV_ERROR(dev->dev, "unsupported pixel format modifie=
r");
> -               return -ENOTSUPP;
> -       }
> -
> -       return 0;
> -}
> -
>  static int
>  exynos_drm_plane_check_size(const struct exynos_drm_plane_config *config=
,
>                             struct exynos_drm_plane_state *state)
> @@ -245,10 +221,6 @@ static int exynos_plane_atomic_check(struct drm_plan=
e *plane,
>         /* translate state into exynos_state */
>         exynos_plane_mode_set(exynos_state);
>
> -       ret =3D exynos_drm_plane_check_format(exynos_plane->config, exyno=
s_state);
> -       if (ret)
> -               return ret;
> -
>         ret =3D exynos_drm_plane_check_size(exynos_plane->config, exynos_=
state);
>         return ret;
>  }
> @@ -312,7 +284,7 @@ int exynos_plane_init(struct drm_device *dev,
>                                        &exynos_plane_funcs,
>                                        config->pixel_formats,
>                                        config->num_pixel_formats,
> -                                      NULL, config->type, NULL);
> +                                      config->modifiers, config->type, N=
ULL);
>         if (err) {
>                 DRM_DEV_ERROR(dev->dev, "failed to initialize plane\n");
>                 return err;
> diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exyn=
os/exynos_mixer.c
> index 69dea5049309..d74e605a452b 100644
> --- a/drivers/gpu/drm/exynos/exynos_mixer.c
> +++ b/drivers/gpu/drm/exynos/exynos_mixer.c
> @@ -93,6 +93,12 @@ static const uint32_t vp_formats[] =3D {
>         DRM_FORMAT_NV21,
>  };
>
> +static const uint64_t vp_modifiers[] =3D {
> +       DRM_FORMAT_MOD_LINEAR,
> +       DRM_FORMAT_MOD_SAMSUNG_64_32_TILE,
> +       DRM_FORMAT_MOD_INVALID
> +};
> +
>  struct mixer_context {
>         struct platform_device *pdev;
>         struct device           *dev;
> @@ -148,8 +154,8 @@ static const struct exynos_drm_plane_config plane_con=
figs[MIXER_WIN_NR] =3D {
>                 .num_pixel_formats =3D ARRAY_SIZE(vp_formats),
>                 .capabilities =3D EXYNOS_DRM_PLANE_CAP_SCALE |
>                                 EXYNOS_DRM_PLANE_CAP_ZPOS |
> -                               EXYNOS_DRM_PLANE_CAP_TILE |
>                                 EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
> +               .modifiers =3D vp_modifiers,
>         },
>  };
>
> --
> 2.55.0.571.g244d577d93-goog
>
