Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160F6C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:31:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 516B610E1DE;
	Wed, 26 Aug 2026 17:31:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kgILLvo0";
	dkim-atps=neutral
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com
 [209.85.167.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7512410E1DE
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 17:31:00 +0000 (UTC)
Received: by mail-lf1-f43.google.com with SMTP id
 2adb3069b0e04-5aec201b582so1243807e87.1
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 10:31:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787765458; cv=none;
 d=google.com; s=arc-20260327;
 b=lrEFetCveLB9EBTVfAjFljZ19smEgPOO3uLbXXloEf4zW2bcrKORKnfSXXM9wUcUR6
 i8g7twDf4ffA6QBz751VvL2CyIAQJdE/TiOpy4GSJkYP4eYl8+NNMXZgykFAKSOrf5ve
 74i7BzSVeSQ6TuPrWitFJBX1vtaeKN01gS9AIAmvbUOEaJTg0CcgjJDC7gu9iJSCYONm
 bibYUaAA563QLfGoL2o6zqLM8iTSUzBhYwyxihvjhBXwogLS+OOud6qQMzvy7hlMDwZv
 Y2IxCS3GJe/zNy8cT0hxUaocnu6DiBrzhoPEFr73hymsT3dN1aMRUnp45Xy88J2ULGun
 7LhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aepQBBl1ZVrjONLqFCXAT39woE5BLBq6aJtCXC3NyuA=;
 fh=o4bCI48V39wcbbWonNM0AfWRyA5V3SmQ3o8ITZWL3hk=;
 b=NH7aoTc2LaMDQFDQIZTUe0nPx1XQcIJRUHRWzmGTfUWkavV63PIlkTDzabG3SyNDNE
 FyvrRH/qm+e6DAyznIlzC52TplKUW8Ot+Iy3YiFPK13/UjQ3+ybfiYlFTjXwtf9NN4hr
 YTQvC+DYMzixbrm/JQchGE5tX2EPipFo0qUGfrBUKMPDCH8n1leGdb6UIcFTOpDVqc+t
 /NJNrNh8/LyT/hZ7+xxQ26je5VPkb3TPv2SgwJlxk1m89+QKOe2hFgx1trekz3pxFHRa
 TawzpdNIfIw9F+hDDf9FsMpmI1RDzkXUiKlzG29HUhE7QCC1GoZAfklnvsuI7VBG7Nkv
 4oWA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787765458; x=1788370258; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aepQBBl1ZVrjONLqFCXAT39woE5BLBq6aJtCXC3NyuA=;
 b=kgILLvo0+Ofs5LcOZnHRS+FL2G0nhYFeUaYl5iV4qQdGiaL/bRaEKGhJr/9tnJrLCJ
 XfeQGC2RYvVco45M6E4Z6pwyqOvEjUqqGIs6UrecIxxJ2j2ayTtOT27V3AB4ZNLWGsxT
 Zo+gWfXHJ9vlsAid7RLDjZMazSx1MfyyplTE1O5Knh5xf6P9FfggrFJivMmclHuz4Lbf
 YPV9cCOEQokzaRYcMLF3p0Fp3BkCZP8+w876tlsCeLAQLt2+VHpg/ZnuU9itZYnTXSVD
 ITeGynBTzvSPVeAyZmu/YqjcuZhwbLMiT+BYYuuo1qaLoLnGXFalbdNFWsYkKczlEnfV
 Zu7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787765458; x=1788370258;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aepQBBl1ZVrjONLqFCXAT39woE5BLBq6aJtCXC3NyuA=;
 b=nlEbasvPVFOkBYv2P0RG0+UTIfjcYisSC8Xh5Db13r7o8muSCgDoWzLIMETckLICS8
 njOYwm+68ohUxXtmtVZFViIL8Tx5ftJBqocs4F/GNN2+gpJgY7QKGnn3q13YGvugWs2X
 L+B7CDBfF/7cfXyiBQVkDzXoQX4cRFKyEZ2CJ7esdFw/pUMqs03VzKZHKXoKsidDvJva
 FeA8TM5XrrXHNgrEhuHAysDOwU3PyDQTexA0GsGtVTK+oXhq6lws+NcuGgey4vzaRRP3
 nTFBlFrzClwP0uEb3wROqsKxi2wzbZ9eIMwg0D/S21MxJGGP105WY9QrjKinAZHheDof
 egbg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrWkIv2gZwmB1RgGOrCzdnvYEQXe2bq+qrIftX4wvCfjWyVZX56stPf0WQfeklXxjM1bPWWGqk4vQw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lAHRJC1exUMw3fGaNpHfUC+2N+Ctx0iXE6Gz8B/YYKdMEwH6nB
 OjRN9HBJNyAIwfZlkGRO/NByF0En/CWiyFlDG2jt3JWb50upkIKfnqc//35yWrhmyq16YsGvQK1
 ByyHYG7tPO3Kf4JjP51zm7XoNgJJ76Ak=
X-Gm-Gg: AR+sD101qb8N7aGX/tjf+a5C6Imb80unsFOKLgUEC+WhLMHlp+TBXy+zM/Uib8QBzM3
 8yWKMAqIBdHDbV3odkLcRTV54ITInq8OX8ADg9ROq4t8kRiXyO10AJMRA37FVBpAkNYafOdevgP
 KK/+T+mQVEJRzrE9JGG0O9FNnLH7pno8unQch8Y9aHqELYtBpXQ1OHNWRrOjZPb9Gbh5d9N+Bfq
 HPVxutqWkBu+VKdDOreHKVkEXba6Dpc3xmd3PV6c4wyxF8unImdTL0jNBbL5l/VpJ8yw4cH225c
 rAClqmmr6sk4hnva7RHqLqzONHzR1dw5/MQjArW0Irs6jCOOq+BUfLLKSsU+C0fHDmcONNwLc9Y
 NsvyLE4a04bAw1Vzg4TLHPuHS5PAb7w==
X-Received: by 2002:a05:6512:ace:b0:5b4:a9e1:b8a4 with SMTP id
 2adb3069b0e04-5b4a9e1baf0mr2342711e87.25.1787765458127; Wed, 26 Aug 2026
 10:30:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260814-rp6-panel-v1-0-111c1aeccf0f@gmail.com>
 <20260814-rp6-panel-v1-3-111c1aeccf0f@gmail.com>
 <007e73a9-8220-46bb-89c6-2354740392c8@linaro.org>
In-Reply-To: <007e73a9-8220-46bb-89c6-2354740392c8@linaro.org>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Wed, 26 Aug 2026 12:30:45 -0500
X-Gm-Features: AcwNN1V4UisMbD-bFUDbYmUeDVAuB_RlKd5IteIsWY5CDvuDkOAStLPqNpNdF9M
Message-ID: <CALHNRZ9rKk3jkR9-sfVUyWgPOn=Prqwus+TRsj5A6H+Ze4AgZg@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm/panel: visionox-vtdr6130: Modularize panel config
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
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

On Wed, Aug 26, 2026 at 4:53=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> On 8/14/26 20:17, Aaron Kling via B4 Relay wrote:
> > From: Aaron Kling <webgeek1234@gmail.com>
> >
> > The vtdr6130 is a DDIC, a common chip that is used by multiple panels.
> > Prepare the driver for more panels.
> >
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> >   drivers/gpu/drm/panel/panel-visionox-vtdr6130.c | 95 ++++++++++++++++=
+--------
> >   1 file changed, 65 insertions(+), 30 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c b/drivers/=
gpu/drm/panel/panel-visionox-vtdr6130.c
> > index b66d6c7128c75..805c9846c2a0b 100644
> > --- a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
> > +++ b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
> > @@ -19,11 +19,28 @@
> >
> >   struct visionox_vtdr6130 {
> >       struct drm_panel panel;
> > -     struct drm_dsc_config dsc;
> > +     struct drm_connector *connector;
>
> Why ? connector is unused in this patch.

I forgot to strip this when removing multiple mode support. Will fix.

> >       struct mipi_dsi_device *dsi;
> >       struct gpio_desc *reset_gpio;
> >       struct regulator_bulk_data *supplies;
> >       enum drm_panel_orientation orientation;
> > +     struct visionox_vtdr6130_desc *desc;
> > +};
> > +
> > +struct visionox_vtdr6130_desc {
> > +     unsigned int width_mm;
> > +     unsigned int height_mm;
> > +
> > +     unsigned int bpc;
> > +     unsigned int lanes;
> > +     unsigned long mode_flags;
> > +     enum mipi_dsi_pixel_format format;
> > +
> > +     const struct drm_display_mode *modes;
> > +     unsigned int num_modes;
> > +     int (*init_sequence)(struct visionox_vtdr6130 *ctx);
> > +
> > +     struct drm_dsc_config dsc;
> >   };
> >
> >   static const struct regulator_bulk_data visionox_vtdr6130_supplies[] =
=3D {
> > @@ -162,7 +179,7 @@ static int visionox_vtdr6130_prepare(struct drm_pan=
el *panel)
> >
> >       visionox_vtdr6130_reset(ctx);
> >
> > -     ret =3D visionox_vtdr6130_on(ctx);
> > +     ret =3D ctx->desc->init_sequence(ctx);
> >       if (ret < 0) {
> >               gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> >               regulator_bulk_disable(ARRAY_SIZE(visionox_vtdr6130_suppl=
ies),
> > @@ -187,34 +204,58 @@ static int visionox_vtdr6130_unprepare(struct drm=
_panel *panel)
> >       return 0;
> >   }
> >
> > -static const struct drm_display_mode visionox_vtdr6130_mode =3D {
> > -     .clock =3D (1080 + 20 + 2 + 20) * (2400 + 20 + 2 + 18) * 144 / 10=
00,
> > -     .hdisplay =3D 1080,
> > -     .hsync_start =3D 1080 + 20,
> > -     .hsync_end =3D 1080 + 20 + 2,
> > -     .htotal =3D 1080 + 20 + 2 + 20,
> > -     .vdisplay =3D 2400,
> > -     .vsync_start =3D 2400 + 20,
> > -     .vsync_end =3D 2400 + 20 + 2,
> > -     .vtotal =3D 2400 + 20 + 2 + 18,
> > +static const struct drm_display_mode visionox_vtdr6130_modes[] =3D {
> > +     {
> > +             .clock =3D (1080 + 20 + 2 + 20) * (2400 + 20 + 2 + 18) * =
144 / 1000,
> > +             .hdisplay =3D 1080,
> > +             .hsync_start =3D 1080 + 20,
> > +             .hsync_end =3D 1080 + 20 + 2,
> > +             .htotal =3D 1080 + 20 + 2 + 20,
> > +             .vdisplay =3D 2400,
> > +             .vsync_start =3D 2400 + 20,
> > +             .vsync_end =3D 2400 + 20 + 2,
> > +             .vtotal =3D 2400 + 20 + 2 + 18,
> > +     },
> > +};
> > +
> > +static struct visionox_vtdr6130_desc visionox_vtdr6130_panel_desc =3D =
{
> > +     .modes =3D visionox_vtdr6130_modes,
> > +     .num_modes =3D ARRAY_SIZE(visionox_vtdr6130_modes),
> >       .width_mm =3D 71,
> >       .height_mm =3D 157,
>
> Why did you move the width/height out of the mode ?
>
> Leave it in the mode, since you don't even use the same mode for the Retr=
oid 6 panel

It was moved to support multiple modes, because duplicating the
dimensions across modes is wasteful. This can be deferred to when
multiple modes are supported.

But on that note, has anything happened with implementing the atomic
changes which were going to be a better way to handle multiple modes?
If not, is the handling you asked to be removed from the icna35xx
change [0] still a hard block? Because that does work now to support
multiple modes and I'm currently carrying downstream changes across
several panel drivers to support those. And I'd really like to
eliminate as many downstream changes as I can.

> > +     .bpc =3D 8,
> > +     .lanes =3D 4,
> > +     .format =3D MIPI_DSI_FMT_RGB888,
> > +     .mode_flags =3D MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_NO_EOT_PACKET=
 |
> > +                   MIPI_DSI_CLOCK_NON_CONTINUOUS,
> > +     .init_sequence =3D visionox_vtdr6130_on,
> > +     .dsc =3D {
> > +             .dsc_version_major =3D 0x1,
> > +             .dsc_version_minor =3D 0x2,
> > +             .slice_height =3D 40,
> > +             .slice_width =3D 540,
> > +             .slice_count =3D 2,
> > +             .bits_per_component =3D 8,
> > +             .bits_per_pixel =3D 8 << 4,
> > +             .block_pred_enable =3D true,
> > +     },
> >   };
> >
> >   static int visionox_vtdr6130_get_modes(struct drm_panel *panel,
> >                                      struct drm_connector *connector)
> >   {
> > +     struct visionox_vtdr6130 *ctx =3D to_visionox_vtdr6130(panel);
> >       struct drm_display_mode *mode;
> >
> > -     mode =3D drm_mode_duplicate(connector->dev, &visionox_vtdr6130_mo=
de);
> > +     mode =3D drm_mode_duplicate(connector->dev, ctx->desc->modes);
> >       if (!mode)
> >               return -ENOMEM;
> >
> >       drm_mode_set_name(mode);
> >
> >       mode->type =3D DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
> > -     connector->display_info.width_mm =3D mode->width_mm;
> > -     connector->display_info.height_mm =3D mode->height_mm;
> > +     connector->display_info.width_mm =3D ctx->desc->width_mm;
> > +     connector->display_info.height_mm =3D ctx->desc->height_mm;
>
> Drop this change, take them from the mode.

Ack.

> >       drm_mode_probed_add(connector, mode);
> >
> >       return 1;
> > @@ -284,23 +325,17 @@ static int visionox_vtdr6130_probe(struct mipi_ds=
i_device *dsi)
> >               return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
> >                                    "Failed to get reset-gpios\n");
> >
> > +     ctx->desc =3D (struct visionox_vtdr6130_desc *)of_device_get_matc=
h_data(dev);
> > +     if (!ctx->desc)
> > +             return -ENODEV;
> > +
> >       ctx->dsi =3D dsi;
> >       mipi_dsi_set_drvdata(dsi, ctx);
> >
> > -     ctx->dsc.dsc_version_major =3D 0x1;
> > -     ctx->dsc.dsc_version_minor =3D 0x2;
> > -     ctx->dsc.slice_height =3D 40;
> > -     ctx->dsc.slice_width =3D 540;
> > -     ctx->dsc.slice_count =3D 2;
> > -     ctx->dsc.bits_per_component =3D 8;
> > -     ctx->dsc.bits_per_pixel =3D 8 << 4;
> > -     ctx->dsc.block_pred_enable =3D true;
> > -
> > -     dsi->dsc =3D &ctx->dsc;
> > -     dsi->lanes =3D 4;
> > -     dsi->format =3D MIPI_DSI_FMT_RGB888;
> > -     dsi->mode_flags =3D MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_NO_EOT_PA=
CKET |
> > -                       MIPI_DSI_CLOCK_NON_CONTINUOUS;
> > +     dsi->dsc =3D &ctx->desc->dsc;
> > +     dsi->lanes =3D ctx->desc->lanes;
> > +     dsi->format =3D ctx->desc->format;
> > +     dsi->mode_flags =3D ctx->desc->mode_flags;
> >       ctx->panel.prepare_prev_first =3D true;
> >
> >       ret =3D drm_of_get_panel_orientation(dev->of_node, &ctx->orientat=
ion);
> > @@ -322,7 +357,7 @@ static int visionox_vtdr6130_probe(struct mipi_dsi_=
device *dsi)
> >   }
> >
> >   static const struct of_device_id visionox_vtdr6130_of_match[] =3D {
> > -     { .compatible =3D "visionox,vtdr6130" },
> > +     { .compatible =3D "visionox,vtdr6130", .data =3D &visionox_vtdr61=
30_panel_desc },
> >       { /* sentinel */ }
> >   };
> >   MODULE_DEVICE_TABLE(of, visionox_vtdr6130_of_match);
> >
>
> Thanks,
> Neil
>

Aaron

[0] https://lore.kernel.org/dri-devel/6dd8f137-a4df-4602-9536-b73abff5e7d1@=
linaro.org/
