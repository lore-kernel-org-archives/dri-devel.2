Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A877C43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 15:59:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C00DD10E0A1;
	Sat,  4 Jul 2026 15:59:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YaUqvtqa";
	dkim-atps=neutral
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com
 [209.85.217.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C5B010E0A1
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 15:59:36 +0000 (UTC)
Received: by mail-vs1-f46.google.com with SMTP id
 ada2fe7eead31-728f9ecd56aso401933137.3
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 08:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783180775; x=1783785575;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N1R3rt/4wDSz6ky8/jCAaXyakWl+HrmHiLRPTOSMmGs=;
 b=YaUqvtqaunFkR/YrRWDVox7tOi43hiymLhyhxjJGpdgQudNXkDwp5Nk90J94512vbZ
 BCs6LuqV3hWjTLxDuWHSinEB8AxY68KLh9kCgUxvxvhy7gYxZpuuri92foCTsiEGvK4T
 FfGlfQnwd8ZqFtmHe6WPl4OMn0eXDDAoyM/TU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783180775; x=1783785575;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N1R3rt/4wDSz6ky8/jCAaXyakWl+HrmHiLRPTOSMmGs=;
 b=DSFJq5tsU+ysU9q8Yrt23NaglYFa2g2CCnxIjyLP16r359hWNOfR6VdD9ZFN/T0GBe
 bCwPnxgrSUKLkIrpydOKGVTm/caU/5ZL3z34aXQkGKBUgVUFGYZKmxel5Rxpng2VpsVz
 3vV9PJhliaflyxy4z775Z6Sx6DcnGXa9k/TPLOKEJPWteUMH7PDHSIcSNzI8kp3F5SOo
 hSd75dbUTB839qTp8is9MqiXRbaaIJ87qsQ4h77fLkuR6TpA5jSSZ+AguK6PzpG2iVGu
 Y7PqGwSa90hPDj8RZF/IAVzn4bxXNCO4/6NbkIv9k2qnu9c42UIXfXbaqI9HcqJl+1Yp
 199A==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro04hdWN3VbI1QV2dNYehZanXLL3fEfZ2fUoJ5LzrYlsnSUkLk8kvrmENe50U9GJMyD5oqMKW8JyB8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxbmLEmXsBx3jQOzPGlZlQC3aJoGvW6UeMJFY+klcNHQgA4CxPq
 rCGwyraqZM/7NvKDSqgblqLkEa/sE790dg1lItsN5AgNMUy4vRfWf5tc7cdY+UdYCP5nVyjXVRH
 YnnY=
X-Gm-Gg: AfdE7cl8kzt6DCW9syge8WAl+DjdOdgM0MwVWwWoOcZcCcb0E0W9eTVWpPBirhHTeDb
 GxBVo3RT3DrOGemdZSVJNyp5mqWYtVlIpZ5R1xm0rnfP2KOStU5Dx4PBl/OTWX0y1Sw33djulsN
 BEjjKysipF3ic6Iecb24Kj2f7gcRS8ticOSjdk8v8FbOxRg1f6Bn7QG1k8/xusUUxic6lyCU9Ce
 wqBXK289fByt6U7HghzHP4eRfNf2pUPZRW3AAFulnQY7eq2lGKoa6z75jzl9ec6Ihj2cSSTTyMG
 H8qfG/6Gd+jxRnnDaOYGcZpVUhKhRGayg6B9NRzWPgnu7y5ul2f9NVGGIq1SGMb9Zh4q+Wlwbnm
 2m+KBC/Ei/6qcGdzS8b/WNRSqdMgJAQY6JufhejY1WZiM9VqlrdWWLujPhZMhUQu0lgCVViyMeI
 rxHuv5aE8A5ap8gyDARjTtxzAHicTUZtTtvwN4/dSL1Temxb8x/8qlVsM=
X-Received: by 2002:a05:6102:5785:b0:738:bf0f:d0c7 with SMTP id
 ada2fe7eead31-7427e914db2mr1226608137.25.1783180775165; 
 Sat, 04 Jul 2026 08:59:35 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com.
 [209.85.221.179]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-73e19f40debsm3744983137.1.2026.07.04.08.59.32
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jul 2026 08:59:32 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id
 71dfb90a1353d-5bdf96b3faaso282360e0c.2
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 08:59:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RqPuDLFl01RVNWCfvcyBq3pLews9C1PW3s0VT3NrNy26Z9gVP0z7EmiZtRV6UD0LaUVc7krEFPGD28=@lists.freedesktop.org
X-Received: by 2002:a05:6102:f11:b0:737:e354:4092 with SMTP id
 ada2fe7eead31-7427c5b06bemr1234835137.11.1783180771360; Sat, 04 Jul 2026
 08:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260701125624.199786-1-nico.antinori.7@gmail.com>
In-Reply-To: <20260701125624.199786-1-nico.antinori.7@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Sat, 4 Jul 2026 08:59:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VKKb1Xy2Y7D1Lv8DXhaG1_zHZqTk2Q74oT-YKGd5CCiQ@mail.gmail.com>
X-Gm-Features: AVVi8CfBBMKu3dPyXgaGhFyCaXc25ycyy4xGhUFDgvYjFsxPnZhgmorMhD1_OrA
Message-ID: <CAD=FV=VKKb1Xy2Y7D1Lv8DXhaG1_zHZqTk2Q74oT-YKGd5CCiQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: novatek-nt37801: Use mipi_dsi_*_multi()
 functions
To: =?UTF-8?Q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Brigham Campbell <me@brighamcampbell.com>, 
 David Airlie <airlied@gmail.com>, Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
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

On Wed, Jul 1, 2026 at 5:56=E2=80=AFAM Nicol=C3=A1s Antinori
<nico.antinori.7@gmail.com> wrote:
>
> Replace mipi_dsi_* functions with their non-deprecated mipi_dsi_*_multi
> counterparts. This change reduces error-checking boilerplate and improves
> readability.
>
> Signed-off-by: Nicol=C3=A1s Antinori <nico.antinori.7@gmail.com>
> ---
> Note: I Compile-tested this patch since I don't own the panel to test it.
>
>  drivers/gpu/drm/panel/panel-novatek-nt37801.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt37801.c b/drivers/gpu/=
drm/panel/panel-novatek-nt37801.c
> index d6a37d7e0cc6..daa356bbc182 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt37801.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt37801.c
> @@ -128,7 +128,8 @@ static int novatek_nt37801_off(struct novatek_nt37801=
 *ctx)
>  static int novatek_nt37801_prepare(struct drm_panel *panel)
>  {
>         struct novatek_nt37801 *ctx =3D to_novatek_nt37801(panel);
> -       struct device *dev =3D &ctx->dsi->dev;
> +       struct mipi_dsi_device *dsi =3D ctx->dsi;
> +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi };
>         struct drm_dsc_picture_parameter_set pps;
>         int ret;
>
> @@ -145,15 +146,10 @@ static int novatek_nt37801_prepare(struct drm_panel=
 *panel)
>
>         drm_dsc_pps_payload_pack(&pps, &ctx->dsc);
>
> -       ret =3D mipi_dsi_picture_parameter_set(ctx->dsi, &pps);
> -       if (ret < 0) {
> -               dev_err(panel->dev, "failed to transmit PPS: %d\n", ret);
> -               goto err;
> -       }
> -
> -       ret =3D mipi_dsi_compression_mode(ctx->dsi, true);
> -       if (ret < 0) {
> -               dev_err(dev, "failed to enable compression mode: %d\n", r=
et);
> +       mipi_dsi_picture_parameter_set_multi(&dsi_ctx, &pps);
> +       mipi_dsi_compression_mode_multi(&dsi_ctx, true);
> +       if (dsi_ctx.accum_err) {
> +               ret =3D dsi_ctx.accum_err;
>                 goto err;
>         }

Sure, this looks pretty good.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

For bonus points, I think you could change novatek_nt37801_on() to
return "void" and take a "struct mipi_dsi_multi_context". Since
drm_dsc_pps_payload_pack() is harmless, the function can now just be:

  novatek_nt37801_on(&dsi_ctx);
  drm_dsc_pps_payload_pack(&pps, &ctx->dsc);
  mipi_dsi_picture_parameter_set_multi(&dsi_ctx, &pps);
  mipi_dsi_compression_mode_multi(&dsi_ctx, true);
  if (dsi_ctx.accum_err) {
    ...
  }
