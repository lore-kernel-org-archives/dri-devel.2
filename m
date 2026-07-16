Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C04EC4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 23:32:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B21410E27C;
	Thu, 16 Jul 2026 23:32:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YTnZOuWL";
	dkim-atps=neutral
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com
 [209.85.222.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 278C210E27C
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 23:32:08 +0000 (UTC)
Received: by mail-ua1-f43.google.com with SMTP id
 a1e0cc1a2514c-976ea28c65fso928149241.1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 16:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784244727; x=1784849527;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zLPcGROx6r4Ql2LZvjT2uthnM8rQT31Fs1fwJJQsahA=;
 b=YTnZOuWLtSnWBRcM10eTid+FNXQl28jTKt6vdD2ot8HWbohO7N1fJ/9sxVBkFnrqcC
 SnGkWS3uKQgnk81OuuDW/pC/jhcf6LrnDrTSXpLvnaF4Vy4iHpeaGFP98VEPxdCm/w1+
 pRU/SSJwqDFqakqMs4QsqoJLLZUqHnPiSNfD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784244727; x=1784849527;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zLPcGROx6r4Ql2LZvjT2uthnM8rQT31Fs1fwJJQsahA=;
 b=MNjTq0YagQdu+vg+jTryr2nJ0mAcmti75tnDIO6OtxAYfmmVxWp0JutqytnZbs6pom
 Apt2/VsLqCagbFu2LkiPGd8Zw4W0rYwWIGn4wsTsZNU5rr+p+j7ii66JdcJQSRk4TUW2
 1GetE2Tv3bb5i8YybqGrjf1hF7re/Mf6XO+FM0hNtc9zaA+wtz91js/ed/J2Js/WD+Eu
 ay/Xm3MLE2MkQuL76uGWC6l5vA1UVqAleYcfaI2yG2GJre/uV+pxdOD7HDFoLRVZVYnb
 lbz+meAazGl+1x5zyunv6EzlpXN/mbC7Opl5TrjtdxkPZcNZmYUTthbIzUz7bMD2Q4Z/
 02Dw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqCEJfbZ5DXIzIvChqh8hRx0srzipZGquqk3v8Pf1AOrNDP9s4Kqci63xsGe3jCGg5H0U19ek6qTeM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwPrtmazFyyYfTHyljW/ik0jOAeWA/4jpKBeHH2BE+f+cn6ZB6b
 ncUAHxQkLHjC30rxN8ziONiJQFoG6Ii7SUYTBRtww1xzbTxAMvdl2KayYShyb0SMo3tYRS0Oqs8
 63Io=
X-Gm-Gg: AfdE7ckEiF1IBto7/EvTxqfZJ42QQgLQd95/XSpg7NCiSICMOXjB56VQ6uYXAkUTPT4
 K9JdLIOKIO5DipLU0DS2QJCXytRx+sdlwLH5R/lwKrA1WtJBSvA4/1v4+3hYlD2Vi5mRFJSCGop
 hbZKZ6HCg1hcchYWOhb2bwb9u+pb1Haix12awPUdxuL7dBn8qGifjT/9oNwNkyZg3uZ5NRxm/70
 AZoN5eUtu4+PT3n9ZWqYnBKcwWH91d5HPtga+7LsA8jbdpg0QcyXb/XkUuRtke3ci8MxAIwrAY0
 CgrVcohxR+eihHPunsCbCojW252KzfXYuEt8bMdOFiBJYhSoRX/4okLNKqzOWYabqLJvGb6hyCK
 sLtAe9aA2bfvS3EqLnnnTOXq98+p7zP80gmENtnbgivIXBiQCbPUKT5759cIdI62evityn/NZDZ
 S2CikDMKGoe49BrF5byMtlZv2UZfX1xo07lQ695GT3
X-Received: by 2002:a05:6102:3f44:b0:745:4d20:6b1a with SMTP id
 ada2fe7eead31-747534366a9mr85680137.6.1784244726559; 
 Thu, 16 Jul 2026 16:32:06 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com.
 [209.85.222.47]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-744d6e38b3bsm14333936137.10.2026.07.16.16.32.05
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2026 16:32:06 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id
 a1e0cc1a2514c-97622cc1f40so3310598241.3
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 16:32:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RoajY/YmLjtmWfrzU2I6MT9tXkEPbndBsWRHT1WLGl+p949E3OU3EYGyqTgjH1o/0i2aM5bXthwFMY=@lists.freedesktop.org
X-Received: by 2002:a05:6102:f97:b0:726:8813:2078 with SMTP id
 ada2fe7eead31-747534c957bmr77108137.11.1784244724359; Thu, 16 Jul 2026
 16:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <allWpYxgHfpKughy@michalis-linux>
In-Reply-To: <allWpYxgHfpKughy@michalis-linux>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 16 Jul 2026 16:31:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wez4s5gUPXN=DuHvHAk4esBMGfh4Rj=ww72UK7VUbOzw@mail.gmail.com>
X-Gm-Features: AUfX_mxxxJXk5I8m-ZZQr9cRqWgMjtpJT8Kb5OTIhT3xwiokl-qk5Z3zwYYvf7s
Message-ID: <CAD=FV=Wez4s5gUPXN=DuHvHAk4esBMGfh4Rj=ww72UK7VUbOzw@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: ilitek-ili9805: Use _multi variants
To: Michail Tatas <michail.tatas@gmail.com>
Cc: michael@amarulasolutions.com, neil.armstrong@linaro.org, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, simona@ffwll.ch, jesszhan0024@gmail.com, 
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

Hi,

On Thu, Jul 16, 2026 at 3:09=E2=80=AFPM Michail Tatas <michail.tatas@gmail.=
com> wrote:
>
> @@ -159,36 +159,23 @@ static int ili9805_power_off(struct ili9805 *ctx)
>
>  static int ili9805_activate(struct ili9805 *ctx)
>  {
> -       struct mipi_dsi_device *dsi =3D ctx->dsi;
> -       struct device *dev =3D &dsi->dev;
> -       int i, ret;
> +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D ctx->dsi };
> +       int i;
>
>         for (i =3D 0; i < ctx->desc->init_length; i++) {
>                 const struct ili9805_instr *instr =3D &ctx->desc->init[i]=
;
>
> -               ret =3D mipi_dsi_dcs_write_buffer(ctx->dsi, instr->data, =
instr->len);
> -               if (ret < 0)
> -                       return ret;
> +               mipi_dsi_dcs_write_buffer_multi(&dsi_ctx, instr->data, in=
str->len);
>
>                 if (instr->delay > 0)
> -                       msleep(instr->delay);
> -       }

What you've done is an improvement, but it's not all the way there.
Specifically, we'd really want to get rid of the whole "struct
ili9805_instr" type and instead each panel should have an init
function. The "struct ili9805_desc" should have a pointer to the init
function instead of a pointer to the init data.

For details, you can see a preivous email about this [1], which then
has further links if you want to dig into details. You can see that
Chintan eventually implemented this in commit a89d9a327d06
("drm/panel: novatek-nt36672a: Inline panel init sequences").

If landing this patch without cleaning up the init sequences is really
important to you, I could be convinced. However, the init sequences
aren't all that big and it would be nice if you could clean it up all
at once. It could be one patch or two.

[1] http://lore.kernel.org/r/CAD=3DFV=3DUCyfjiqcpYCM5ePz-auX4g=3Di_+i78ivvv=
yA8R1XtAKzg@mail.gmail.com


> @@ -211,25 +198,13 @@ static int ili9805_prepare(struct drm_panel *panel)
>
>  static int ili9805_deactivate(struct ili9805 *ctx)
>  {
> -       struct mipi_dsi_device *dsi =3D ctx->dsi;
> -       struct device *dev =3D &dsi->dev;
> -       int ret;
> -
> -       ret =3D mipi_dsi_dcs_set_display_off(ctx->dsi);
> -       if (ret < 0) {
> -               dev_err(dev, "Failed to set display OFF (%d)\n", ret);
> -               return ret;
> -       }
> +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D ctx->dsi };
>
> -       usleep_range(5000, 10000);
> -
> -       ret =3D mipi_dsi_dcs_enter_sleep_mode(ctx->dsi);
> -       if (ret < 0) {
> -               dev_err(dev, "Failed to enter sleep mode (%d)\n", ret);
> -               return ret;
> -       }
> +       mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> +       mipi_dsi_usleep_range(&dsi_ctx, 5000, 10000);
> +       mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
>
> -       return 0;
> +       return dsi_ctx.accum_err;

Nobody looks at the return code of this function. Since you're
touching it anyway, can you change ili9805_deactivate() to return
"void"? I wouldn't object if you made ili9805_power_off() return
"void" in the same patch too, even though it's a bit unrelated to the
rest of the patch.

-Doug
