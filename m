Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81096F88089
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 07:20:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBE7510E81D;
	Thu, 16 Apr 2026 07:20:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lGmqoMnB";
	dkim-atps=neutral
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com
 [209.85.167.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD00E10E81D
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 07:20:05 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id
 2adb3069b0e04-5a0fc5e2c59so7352763e87.1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 00:20:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776324004; cv=none;
 d=google.com; s=arc-20240605;
 b=Xhk6LfZn3O2BxZZNdBI5/zbjLRbL3iuipBv9lLaqfWsYD+AvAybHVtkbCW4rvRpDXM
 FVGJ/mieAhV/MP7SNfB1Me9fZSnC22181ZADK1/o2Ak1T0FmXz/xz2R1nwaW82RbVzB/
 4kuzexo1/Cm8FpcrjW8U5VpwFch3Nt1LpqqXEwfpz1RsplDk5j5eVRWuldQDdd5WYZTU
 7zHAwXIrXlzPPzJ6h4vnWnilY9zqAH0BlvKnZ+GglXhaepMv6dTSuM/vGhOo2t533cE0
 KZkniz6Kt5mVk1p7B1nvMvWtUDQ2a0KSwSFtFzA2ao2aMMfowoBCUKqNBJcz7ECuNyUO
 u0UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=12LljQo9v9VqYtlqMKjlKnyqUso1P6vImLmY4jcnOd0=;
 fh=2eddvM6Qhmn83bOCyLAqVOrhDvrvqw1fYjR3SYiupYI=;
 b=P4QWe8IsvKom/hJIsMqYrTajkfFJnkviNBQJiuYP7qFkYJcozivA74fJ06hOEhfjEw
 3tFCHar6tmGoH2EjNB9fdTUWNhVaCC48varOUm0+kVj5R9xaTl9bnb5JLq0GMVKDrzej
 YKcocBWtn165yXOcGFwvUORyxuW/V1gBSvKUUbZbjHzUqUPwFFksWjIxIru4IFoHoPfO
 thGG40UHXqlIVm3gkc4fDWNztcFB1b5TAm9dulRnjf+F3n06wbZuujsKv4i3Lskh+Epo
 ItDcwH3Bf45d1V1GsJOL4X4fq8tcNLbk9qK4WhumfFJ6KSxYS/J5ui1OfkZqTCOmWajj
 f4xg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776324004; x=1776928804; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=12LljQo9v9VqYtlqMKjlKnyqUso1P6vImLmY4jcnOd0=;
 b=lGmqoMnBTbXuHXbZg/CgiegcBXkFFYk26H1GZDBM4tH3TnUL1Qaq+WmzWWlhJ2AP/V
 +axHj1Potk2O8BXdOfmA+5Ed4NbpHqgJaF2yQ6vfU/KdlHwzRyAmSwM9bAd51B2uYSZq
 mnuHt1eGivOlas4VuyZL7ViABMuesjZ3+4L/UjGq7bhZOMUkDF2U6CMbAONhQ8Wbf4m9
 ATYG82o3DiwpYNe8sclTZGV7FZJq3oHBiyZ/WewqYACqZwie9KfYx0px03tXE6ALMJDh
 HnU9kG/CuMpkcFoP6xG09CnCWrypd+rW8ZhpeyFl/qaKNNbN4gXjcwFELIBZAaU+/FNG
 cEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776324004; x=1776928804;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=12LljQo9v9VqYtlqMKjlKnyqUso1P6vImLmY4jcnOd0=;
 b=sRUi1IpedsB3ELZTfZIXYlv1uZatfhJhsAt8Pw7ZV4u3m76UXogjrO/QFQdMySfX/r
 YXPd9kVzdgGBwz24fLGPirGto5SZG3vWzjqHd4DuipjM5zTWm/vxxpX9G3f1VvmQ8snj
 KoPCKSp0AdBEiHoQgRY+S+3F13yS4PvGtDGVcW8FgP6/u9edaN0+k1KpiER2TTdgd8cg
 EzQasj0E7H7ILiP+pTZRwkyvizcV9yaPsYJKAyVX2J+ls1QXe/nnWGrj114cHJYoYCiQ
 +AqK4+BaERtgKsOHuMOz+aIhzeKsC7jz3Rqjk9hpziA7rtlFIzqCJmR5VQUS7TgSQXRk
 Y46A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/J5oX8maxpwDCloW2/h0acYwzn3B7PbpF2cJ1cnVUb65WNeMoyOfKjaklU8771iWRjU2Js2hfgjTU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzBNBkvmAdSPmL55Tx+6tAbGK+QnXILamXv0HhyRdaquTEGbP4o
 A+HnW9XqTr77EYfoqfJtf5OwfCAMlVWSjfw8/xWTMBhspefdCArHjR8j1Fm/jPUQYxVWxF+MMo9
 AwYJbCY0nQ1KEYFvZ4F4Tj8c6JgbniGI=
X-Gm-Gg: AeBDies7Q5XECRmMTRivp5+iWqUEe6e2IN2jk2uL0P9tGGfjuL3tYTK+TK0g9qV5hhZ
 srzIwDLWUMP+wmqag6ILRimJlzycZUENE73VFots95KYO+bkwTNlwls1LgYa+OK58EqRn7AZLt/
 fbhp91qs7v0vEMyPp6cg3w0VQytjHYYjm/EVONcWYcNOGgvO/qFHcB8xdI3v4/K87MKbt5UO9cG
 tVaqtia4Q9OWX+V6bCN4tyld6zRWOf2OgQz9uNHIiOpO1ce54vcCp33AnwOwcvivg1fG4HSqtf6
 3BKdeRUMi/71hdAPnlYOPAbyNsmXHtPot6rZ7OMhY0KIrH0Ah09BP6UCJVRNtRjv+RFCeEs3b3g
 OXP0=
X-Received: by 2002:a05:6512:39c4:b0:5a3:e5f3:daec with SMTP id
 2adb3069b0e04-5a3efb2b6b1mr7853655e87.21.1776324003467; Thu, 16 Apr 2026
 00:20:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260408-ch13726a-v4-0-9bb1a9b8f329@gmail.com>
 <20260408-ch13726a-v4-2-9bb1a9b8f329@gmail.com>
 <63870098-5e70-44af-ba18-1fd726b5ef5a@linaro.org>
In-Reply-To: <63870098-5e70-44af-ba18-1fd726b5ef5a@linaro.org>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Thu, 16 Apr 2026 02:19:50 -0500
X-Gm-Features: AQROBzBj4-wwk9SE6AzOnvYO989LEw_EOowIk1wGyD260q_kQYqxrhnGdkEhtIk
Message-ID: <CALHNRZ-aEmzSWwMNbs2TR_18uvEaBQVK3fy-S5r5-fhnN9Gq+A@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] drm/panel: Add panel driver for ChipWealth
 CH13726A based panels
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Teguh Sobirin <teguh@sobir.in>
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

On Mon, Apr 13, 2026 at 4:17=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> On 4/8/26 07:32, Aaron Kling via B4 Relay wrote:
> > From: Teguh Sobirin <teguh@sobir.in>
> >
> > This is used by the AYN Thor for the bottom panel.
> >
> > Signed-off-by: Teguh Sobirin <teguh@sobir.in>
> > Co-developed-by: Aaron Kling <webgeek1234@gmail.com>
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> >   drivers/gpu/drm/panel/Kconfig                     |  11 +
> >   drivers/gpu/drm/panel/Makefile                    |   1 +
> >   drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c | 339 +++++++++++++=
+++++++++
> >   3 files changed, 351 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kcon=
fig
> > index d6863b28ddc559..e2c00f08f4507d 100644
> > --- a/drivers/gpu/drm/panel/Kconfig
> > +++ b/drivers/gpu/drm/panel/Kconfig
> > @@ -105,6 +105,17 @@ config DRM_PANEL_BOE_TV101WUM_LL2
> >         Say Y here if you want to support for BOE TV101WUM-LL2
> >         WUXGA PANEL DSI Video Mode panel
> >
> > +config DRM_PANEL_CHIPWEALTH_CH13726A
> > +     tristate "CHIPWEALTH CH13726A-based DSI panel"
> > +     depends on OF
> > +     depends on DRM_MIPI_DSI
> > +     depends on BACKLIGHT_CLASS_DEVICE
> > +     select DRM_DISPLAY_DP_HELPER
> > +     select DRM_DISPLAY_HELPER
> > +     help
> > +       Say Y here if you want to enable support for ChipWealth
> > +       CH13726A-based display panels.
> > +
> >   config DRM_PANEL_EBBG_FT8719
> >       tristate "EBBG FT8719 panel driver"
> >       depends on OF
> > diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Mak=
efile
> > index a4291dc3905bed..343d283d1620fb 100644
> > --- a/drivers/gpu/drm/panel/Makefile
> > +++ b/drivers/gpu/drm/panel/Makefile
> > @@ -9,6 +9,7 @@ obj-$(CONFIG_DRM_PANEL_BOE_TD4320) +=3D panel-boe-td432=
0.o
> >   obj-$(CONFIG_DRM_PANEL_BOE_TH101MB31UIG002_28A) +=3D panel-boe-th101m=
b31ig002-28a.o
> >   obj-$(CONFIG_DRM_PANEL_BOE_TV101WUM_LL2) +=3D panel-boe-tv101wum-ll2.=
o
> >   obj-$(CONFIG_DRM_PANEL_BOE_TV101WUM_NL6) +=3D panel-boe-tv101wum-nl6.=
o
> > +obj-$(CONFIG_DRM_PANEL_CHIPWEALTH_CH13726A) +=3D panel-chipwealth-ch13=
726a.o
> >   obj-$(CONFIG_DRM_PANEL_DSI_CM) +=3D panel-dsi-cm.o
> >   obj-$(CONFIG_DRM_PANEL_LVDS) +=3D panel-lvds.o
> >   obj-$(CONFIG_DRM_PANEL_SIMPLE) +=3D panel-simple.o
> > diff --git a/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c b/driver=
s/gpu/drm/panel/panel-chipwealth-ch13726a.c
> > new file mode 100644
> > index 00000000000000..48a5e20e07c487
> > --- /dev/null
> > +++ b/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c
> > @@ -0,0 +1,339 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * ChipWealth CH13726A MIPI-DSI panel driver
> > + * Copyright (c) 2024, Teguh Sobirin <teguh@sobir.in>.
> > + */
> > +
> > +#include <linux/backlight.h>
> > +#include <linux/delay.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/regulator/consumer.h>
> > +
> > +#include <drm/drm_mipi_dsi.h>
> > +#include <drm/drm_modes.h>
> > +#include <drm/drm_panel.h>
> > +
> > +#include <video/mipi_display.h>
> > +
> > +struct ch13726a_panel {
> > +     struct drm_panel panel;
> > +     struct mipi_dsi_device *dsi;
> > +     struct regulator_bulk_data supplies[4];
> > +     struct gpio_desc *reset_gpio;
> > +     struct ch13726a_desc *desc;
> > +     enum drm_panel_orientation orientation;
> > +     bool prepared;
>
> Drop this, it's handled by the panel core now.
Ack.
>
> > +};
> > +
> > +struct ch13726a_desc {
> > +     unsigned int width_mm;
> > +     unsigned int height_mm;
> > +     unsigned int bpc;
> > +
> > +     const struct drm_display_mode *modes;
> > +     unsigned int num_modes;
> > +};
> > +
> > +static inline struct ch13726a_panel *to_ch13726a_panel(struct drm_pane=
l *panel)
> > +{
> > +     return container_of(panel, struct ch13726a_panel, panel);
> > +}
> > +
> > +static void ch13726a_reset(struct ch13726a_panel *ctx)
> > +{
> > +     gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> > +     usleep_range(10000, 11000);
> > +     gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> > +     usleep_range(10000, 11000);
> > +     gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> > +     usleep_range(10000, 11000);
> > +}
> > +
> > +static int ch13726a_on(struct ch13726a_panel *ctx)
> > +{
> > +     struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D ctx->dsi };
> > +
> > +     ctx->dsi->mode_flags |=3D MIPI_DSI_MODE_LPM;
> > +
> > +     mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf0, 0x50);
> > +     mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb9, 0x00);
> > +
> > +     mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> > +
> > +     mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> > +
> > +     return dsi_ctx.accum_err;
> > +}
> > +
> > +static int ch13726a_disable(struct drm_panel *panel)
> > +{
> > +     struct ch13726a_panel *ctx =3D to_ch13726a_panel(panel);
> > +     struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D ctx->dsi };
> > +
> > +     ctx->dsi->mode_flags &=3D ~MIPI_DSI_MODE_LPM;
> > +
> > +     mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> > +     mipi_dsi_msleep(&dsi_ctx, 50);
> > +     mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> > +
> > +     return dsi_ctx.accum_err;
> > +}
> > +
> > +static int ch13726a_prepare(struct drm_panel *panel)
> > +{
> > +     struct ch13726a_panel *ctx =3D to_ch13726a_panel(panel);
> > +     struct device *dev =3D &ctx->dsi->dev;
> > +     int ret;
> > +
> > +     if (ctx->prepared)
> > +             return 0;
> > +
> > +     ret =3D regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->sup=
plies);
> > +     if (ret < 0) {
> > +             dev_err(dev, "Failed to enable regulators: %d\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     ch13726a_reset(ctx);
> > +
> > +     ret =3D ch13726a_on(ctx);
> > +     if (ret < 0) {
> > +             dev_err(dev, "Failed to initialize panel: %d\n", ret);
> > +             gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> > +             regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->su=
pplies);
> > +             return ret;
> > +     }
> > +
> > +     msleep(28);
> > +
> > +     ctx->prepared =3D true;
> > +
> > +     return 0;
> > +}
> > +
> > +static int ch13726a_unprepare(struct drm_panel *panel)
> > +{
> > +     struct ch13726a_panel *ctx =3D to_ch13726a_panel(panel);
> > +
> > +     if (!ctx->prepared)
> > +             return 0;
> > +
> > +     gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> > +     regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
> > +
> > +     ctx->prepared =3D false;
> > +     return 0;
> > +}
> > +
> > +static const struct drm_display_mode thor_bottom_modes[] =3D {
> > +     {
> > +             /* 120Hz */
> > +             .clock =3D (1080 + 28 + 4 + 36) * (1240 + 16 + 4 + 8) * 1=
20 / 1000,
> > +             .hdisplay =3D 1080,
> > +             .hsync_start =3D 1080 + 28,
> > +             .hsync_end =3D 1080 + 28 + 4,
> > +             .htotal =3D 1080 + 28 + 4 + 36,
> > +             .vdisplay =3D 1240,
> > +             .vsync_start =3D 1240 + 16,
> > +             .vsync_end =3D 1240 + 16 + 4,
> > +             .vtotal =3D 1240 + 16 + 4 + 8,
> > +     },
> > +     {
> > +             /* 60Hz */
> > +             .clock =3D (1080 + 28 + 4 + 36) * (1240 + 16 + 4 + 8) * 6=
0 / 1000,
> > +             .hdisplay =3D 1080,
> > +             .hsync_start =3D 1080 + 28,
> > +             .hsync_end =3D 1080 + 28 + 4,
> > +             .htotal =3D 1080 + 28 + 4 + 36,
> > +             .vdisplay =3D 1240,
> > +             .vsync_start =3D 1240 + 16,
> > +             .vsync_end =3D 1240 + 16 + 4,
> > +             .vtotal =3D 1240 + 16 + 4 + 8,
> > +     }
> > +};
> > +
> > +static struct ch13726a_desc thor_bottom_desc =3D {
> > +     .modes =3D thor_bottom_modes,
> > +     .num_modes =3D ARRAY_SIZE(thor_bottom_modes),
> > +     .width_mm =3D 65,
> > +     .height_mm =3D 75,
> > +     .bpc =3D 8,
> > +};
> > +
> > +static int ch13726a_get_modes(struct drm_panel *panel,
> > +                                     struct drm_connector *connector)
> > +{
> > +     struct ch13726a_panel *ctx =3D to_ch13726a_panel(panel);
> > +
> > +     for (uint8_t i =3D 0; i < ctx->desc->num_modes; i++) {
> > +             const struct drm_display_mode *m =3D &ctx->desc->modes[i]=
;
> > +             struct drm_display_mode *mode;
> > +
> > +             mode =3D drm_mode_duplicate(connector->dev, m);
> > +             if (!mode) {
> > +                     dev_err(&ctx->dsi->dev, "failed to add mode %ux%u=
@%u\n",
> > +                             m->hdisplay, m->vdisplay, drm_mode_vrefre=
sh(m));
> > +                     return -ENOMEM;
> > +             }
>
> Can you use drm_connector_helper_get_modes_fixed instead ?

Per the description for that function, it only works if there's a
single mode. This panel supports two modes, 60hz and 120hz.
>
> > +
> > +             mode->type =3D DRM_MODE_TYPE_DRIVER;
> > +             if (i =3D=3D 0)
> > +                     mode->type |=3D DRM_MODE_TYPE_PREFERRED;
> > +
> > +             drm_mode_set_name(mode);
> > +             drm_mode_probed_add(connector, mode);
> > +     }
> > +
> > +     connector->display_info.width_mm =3D ctx->desc->width_mm;
> > +     connector->display_info.height_mm =3D ctx->desc->height_mm;
> > +     connector->display_info.bpc =3D ctx->desc->bpc;
> > +
> > +     return ctx->desc->num_modes;
> > +}
> > +
> > +static enum drm_panel_orientation ch13726a_get_orientation(struct drm_=
panel *panel)
> > +{
> > +     struct ch13726a_panel *ctx =3D to_ch13726a_panel(panel);
> > +
> > +     return ctx->orientation;
> > +}
> > +
> > +static const struct drm_panel_funcs ch13726a_panel_funcs =3D {
> > +     .prepare =3D ch13726a_prepare,
> > +     .unprepare =3D ch13726a_unprepare,
> > +     .disable =3D ch13726a_disable,
> > +     .get_modes =3D ch13726a_get_modes,
> > +     .get_orientation =3D ch13726a_get_orientation,
> > +};
> > +
> > +static int ch13726a_bl_update_status(struct backlight_device *bl)
> > +{
> > +     struct mipi_dsi_device *dsi =3D bl_get_data(bl);
> > +     u16 brightness =3D backlight_get_brightness(bl);
> > +     int ret;
> > +
> > +     dsi->mode_flags &=3D ~MIPI_DSI_MODE_LPM;
> > +
> > +     ret =3D mipi_dsi_dcs_set_display_brightness(dsi, brightness);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     dsi->mode_flags |=3D MIPI_DSI_MODE_LPM;
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct backlight_ops ch13726a_bl_ops =3D {
> > +     .update_status =3D ch13726a_bl_update_status,
> > +};
> > +
> > +static struct backlight_device *
> > +ch13726a_create_backlight(struct mipi_dsi_device *dsi)
> > +{
> > +     struct device *dev =3D &dsi->dev;
> > +     const struct backlight_properties props =3D {
> > +             .type =3D BACKLIGHT_RAW,
> > +             .brightness =3D 255,
> > +             .max_brightness =3D 255,
> > +     };
> > +
> > +     return devm_backlight_device_register(dev, dev_name(dev), dev, ds=
i,
> > +                                           &ch13726a_bl_ops, &props);
> > +}
> > +
> > +static int ch13726a_probe(struct mipi_dsi_device *dsi)
> > +{
> > +     struct device *dev =3D &dsi->dev;
> > +     struct ch13726a_panel *ctx;
> > +     int ret;
> > +
> > +     ctx =3D devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> > +     if (!ctx)
> > +             return -ENOMEM;
> > +
> > +     ctx->desc =3D (struct ch13726a_desc *)of_device_get_match_data(de=
v);
> > +     if (!ctx->desc)
> > +             return -ENODEV;
> > +
> > +     ctx->supplies[0].supply =3D "vdd1v2";
> > +     ctx->supplies[1].supply =3D "vddio";
> > +     ctx->supplies[2].supply =3D "vdd";
> > +     ctx->supplies[3].supply =3D "avdd";
> > +
> > +     ret =3D devm_regulator_bulk_get(dev, ARRAY_SIZE(ctx->supplies),
> > +                                   ctx->supplies);
> > +     if (ret < 0)
> > +             return dev_err_probe(dev, ret, "Failed to get regulators\=
n");
> > +
> Can you switch to devm_regulator_bulk_get_const ?

Looks like I can.
>
> > +     ctx->reset_gpio =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> > +     if (IS_ERR(ctx->reset_gpio))
> > +             return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
> > +                                  "Failed to get reset-gpios\n");
> > +
> > +     ret =3D of_drm_get_panel_orientation(dev->of_node, &ctx->orientat=
ion);
> > +     if (ret < 0) {
> > +             dev_err(dev, "%pOF: failed to get orientation %d\n", dev-=
>of_node, ret);
> > +             return ret;
> > +     }
> > +
> > +     ctx->dsi =3D dsi;
> > +     mipi_dsi_set_drvdata(dsi, ctx);
> > +
> > +     dsi->lanes =3D 4;
> > +     dsi->format =3D MIPI_DSI_FMT_RGB888;
> > +     dsi->mode_flags =3D MIPI_DSI_MODE_VIDEO |
> > +                       MIPI_DSI_CLOCK_NON_CONTINUOUS;
> > +
> > +     drm_panel_init(&ctx->panel, dev, &ch13726a_panel_funcs,
> > +                    DRM_MODE_CONNECTOR_DSI);
>
> Please use devm_drm_panel_alloc() instead.

Ack
>
> > +     ctx->panel.prepare_prev_first =3D true;
> > +
> > +     ctx->panel.backlight =3D ch13726a_create_backlight(dsi);
> > +     if (IS_ERR(ctx->panel.backlight))
> > +             return dev_err_probe(dev, PTR_ERR(ctx->panel.backlight),
> > +                                  "Failed to create backlight\n");
> > +
> > +     drm_panel_add(&ctx->panel);
> > +
> > +     ret =3D mipi_dsi_attach(dsi);
> > +     if (ret < 0) {
> > +             dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
> > +             drm_panel_remove(&ctx->panel);
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void ch13726a_remove(struct mipi_dsi_device *dsi)
> > +{
> > +     struct ch13726a_panel *ctx =3D mipi_dsi_get_drvdata(dsi);
> > +     int ret;
> > +
> > +     ret =3D mipi_dsi_detach(dsi);
> > +     if (ret < 0)
> > +             dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n"=
, ret);
> > +
> > +     drm_panel_remove(&ctx->panel);
> > +}
> > +
> > +static const struct of_device_id ch13726a_of_match[] =3D {
> > +     { .compatible =3D "ayntec,thor-panel-bottom", .data =3D &thor_bot=
tom_desc },
> > +     { /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, ch13726a_of_match);
> > +
> > +static struct mipi_dsi_driver ch13726a_driver =3D {
> > +     .probe =3D ch13726a_probe,
> > +     .remove =3D ch13726a_remove,
> > +     .driver =3D {
> > +             .name =3D "panel-ch13726a-amoled",
> > +             .of_match_table =3D ch13726a_of_match,
> > +     },
> > +};
> > +module_mipi_dsi_driver(ch13726a_driver);
> > +
> > +MODULE_DESCRIPTION("DRM driver for CH13726A DSI panels");
> > +MODULE_LICENSE("GPL");
> >
>
Aaron
