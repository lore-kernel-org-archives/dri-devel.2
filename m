Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD80606A321
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 04:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XF4mM7Jp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7957E10E1DB;
	Mon,  9 Nov 2026 04:08:30 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1BC310E1DB
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 04:08:23 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-6a642495d81so648351a12.2
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 20:08:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794197302; cv=none;
 d=google.com; s=arc-20260327;
 b=FBa7tcSJHd3L2ABwfqdLbbJVmF//L8Ar8DzHYvJ8jbgRF0AmKm0fJzA7660adeoPl/
 lH4dDOEKfUWGPCnZDD3YJ8XFmNY2YHTWa/JT8Zy2aVsFCEgQD5Gvn2yMWj3JgGkrxHnl
 ECn4/aakucU/GcbKyv0R7L0AJyA+IUiP9T2IairU4FE0/JA5PT7roazQx17RCf87HIGF
 HrQE3FPYjn/xXSensi23WlNJ1GKctjDeMPTqUjA9I7tS14rvLCuA+9exjWvVxFdoP894
 RSCRoFnnOTGe2qs7UrA1MHfcCZfet8jIzI2qNhT76u8a1IVdl+5H4W0trdO5XUtzDgvA
 jdZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VmgZV3Ha8SXRM5atMh4jHdaSdi8ER/Gp97TobHog/vw=;
 fh=AcqgG7NNH0OcpUWEhyCvztmM5TyTvfHYd93kAN2PvbA=;
 b=ZbGtCSTZymAFcf8aY+mlBOKTY217moLX+h84QShddQy02zUKstPhyMcBxl7GPKII0l
 TXcT4uK35pnw4ikAsp39d367GBbtW0bfCAY5u2bIcjYeCz4aO2ztGUqpG4dhWPeW68nh
 QyIryDfuDZdGAVWXVrs5h48UGHFvHGJU74VFtoS28nGHAH1unq7EjWfjxClqr8omV46K
 GCneO8WtzyDbKEKp7u3ua4baeYH11G6hRCfDTxdg7nUPUsnqc590YJ5iZc4zFT32aR8q
 DtHfqWX7lYxwI+KXp2mHTtWN2f6WpK6iMtL+5UzQQoea2u9oB3ih5ppysVe23nWKq9I7
 Yt5w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794197302; x=1794802102; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VmgZV3Ha8SXRM5atMh4jHdaSdi8ER/Gp97TobHog/vw=;
 b=XF4mM7JpT3ffQmA4CSqzx9RRPxJXy1zWoVmjpHawcinzQqllYb0oEMU7rH9vFaQtNp
 ZP0GU9fbvYZjggAxH5P28GpvSmF/RmW+IGCzF02FPlVR0Xw7TXosNuIJHsQjHrVgpych
 QDDXik0RbTWBXvRHv8eAnAKoyxh+UdUmEzwHsoOdUtYFIfQRFYTEwDS94cM+1bBBg1Py
 HyRxrdICLQmmRxZLeHIyG+/3VzNxR9APke0+q//r9WiWtU31inqjNTKgBpNM5KGVrNVl
 nM5iKnu7MS7bl4u+eDHw5bI0Au6jmHTLJxWb54kqNNyiN3wTI0iRbMpBdep5LLjnJ/7N
 Frag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794197302; x=1794802102;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VmgZV3Ha8SXRM5atMh4jHdaSdi8ER/Gp97TobHog/vw=;
 b=u9VjByIWhuoF3HNeMynJ4/KgqFlYTT7uCW9wUYEdW8w/6d6gd6AVZu6qo3TgLPXAWK
 BLumjBVOk9IDvszzwoKls8Tuajnk4gCsTPzm+WyAfuugXfYq7ykIshs7uVtWVdV9rvZZ
 lfPqm9wkp/agIuBVgOrxJqwSk+o9T5WnyE6kppXQbaoqgrDvNsskNthpSAue5Id1Vsyw
 NHCvq48k9lQja9yWB8Blbs0aZq+GVSXq+WdbTVTybggvf3jVfJe1m365k8UlTp1hWIHr
 mMZeACsgRy+qCLnI720fuUKkvYvu6J1tXJdGUtbvQTHgtfu6/JFHv6PBHua3r3Rb0qv7
 sQ/w==
X-Forwarded-Encrypted: i=1;
 AL+hErF+Z2+uWdrgsq2ho9LddGZ8BDSHGFYOtVnSTLTknZKgyMNW8N30HQKbu7/geTA1hkhqVYjJOcbMsQs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z98XRTl/Q5RrJHC8CfxTyqff2+7addiXMemR7fwAkvijC8NHbEM
 iFRUhRTrMOt0pYLNvcbkTQhFewcRHblAyCFUQSEdkDg2PHPN3s6iHfMD2+7kp38EvnNvXtYWB4O
 MB2THTl4U68RR1DUYeCio7giq1I7jccU=
X-Gm-Gg: AYBFou3gyNQ5tqYy4SAjIHMYAtTAo7EK+wKlUjQQT4tJKU1bqgpoSb8sn6iatDzg+Pp
 U7wAsTliAGGKNbjijmQVfISsthjnFqn7AOrSVLmvSpFaxesD6e0XByh3pW46Sg5EfuWopmciR8g
 Cm2o02b+mLxKzBMNa8+10C971TqCzGxyCi3auykcdO92hPlvjn39GyuLX7CCuTogcMJhgm2AbY1
 qvyyXvm6JFvuVuGo7vAPfshh7wdD7j2YREvYL5620UHkVdWn3aPuxDKgWa9Np6rg8wGj6Ro2Szp
 MFz+kfTxBCCxdnjQrX+NhjuSV0AVNtvIlYY0e1rujOLUtQzEZW6s4qkoFeZvXNZL9FImCrR4ZJp
 ZlaS7DY/6uPvLrNBYWAFx7W0fj1xRLWRZtAhOWtgi8D4FXJix/0yOL1pDZ0z6lw+6WkU=
X-Received: by 2002:a05:6402:274d:b0:6b5:76be:62e0 with SMTP id
 4fb4d7f45d1cf-6b722480872mr1993578a12.35.1794197302011; Sun, 08 Nov 2026
 20:08:22 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260803135249.2898083-1-wenst@chromium.org>
In-Reply-To: <20260803135249.2898083-1-wenst@chromium.org>
From: Inki Dae <daeinki@gmail.com>
Date: Mon, 9 Nov 2026 13:07:45 +0900
X-Gm-Features: AclHuK_ZmjCHtFzSMtsaBOPEyrbrKGy7XikpiPUkajiV_K7VOdZCVHHguZRFD24
Message-ID: <CAAQKjZP+W0_gByaDAv8DrtxFgSDdtw4AMd-=tA_Pr8gL30z1iA@mail.gmail.com>
Subject: Re: [PATCH] drm/exynos: Set supported modifiers during plane init
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
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
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Sorry for late review,

2026=EB=85=84 8=EC=9B=94 3=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 11:22, C=
hen-Yu Tsai <wenst@chromium.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
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

The VP plane advertises the tiled modifier for both NV12 and NV21, but
framebuffer_check() accepts it only for NV12[1]. Could you add a
format_mod_supported callback to restrict that combination? For
example, the callback could check that the modifier is present in
plane->modifiers, then reject DRM_FORMAT_MOD_SAMSUNG_64_32_TILE when
the format is not NV12:
static bool exynos_plane_format_mod_supported(struct drm_plane *plane,
                                              u32 format, u64 modifier)
{
        unsigned int i;

        for (i =3D 0; i < plane->modifier_count; i++)
        if (plane->modifiers[i] =3D=3D modifier)
                break;

        if (i =3D=3D plane->modifier_count)
                return false;

       return modifier !=3D DRM_FORMAT_MOD_SAMSUNG_64_32_TILE ||
                 format =3D=3D DRM_FORMAT_NV12;
}

This can be assigned to exynos_plane_funcs.format_mod_supported.
Checking the modifier list matters here because DRM delegates that
validation to the callback when one is present.

Thanks,
Inki Dae


[1] in drm_framebuffers.c
static int framebuffer_check(struct drm_device *dev,
    const struct drm_format_info *info,
    const struct drm_mode_fb_cmd2 *r)
{
...
        /* modifier specific checks: */
        switch (r->modifier[i]) {
        case DRM_FORMAT_MOD_SAMSUNG_64_32_TILE:
               /* NOTE: the pitch restriction may be lifted later if it tur=
ns
                * out that no hw has this restriction:
                */
                if (r->pixel_format !=3D DRM_FORMAT_NV12 ||
                         width % 128 || height % 32 ||
                          r->pitches[i] % 128) {
                       drm_dbg_kms(dev, "bad modifier data for plane %d\n",=
 i);
                       return -EINVAL;
        }
...

>         },
>  };
>
> --
> 2.55.0.571.g244d577d93-goog
>
>
