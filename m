Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 665EACD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 17:00:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6AB410EE02;
	Thu, 18 Jun 2026 17:00:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fClnu5g5";
	dkim-atps=neutral
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com
 [209.85.221.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46CB910EE02
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 17:00:35 +0000 (UTC)
Received: by mail-vk1-f171.google.com with SMTP id
 71dfb90a1353d-59ecd51117dso979211e0c.1
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 10:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781802034; x=1782406834;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZcqBl9MGo5keDsaGunZf7Kbn8uQHXFUIROLGD7+Cdxs=;
 b=fClnu5g5MSwjouRk1oIPVCMZvZmsZ9WjIIm9zp28jJRIEPNzZ4KUxwbL4ehqXUALmN
 KoysRUxC7gAYTotZNB5UH5YPaWvwmrkWEbuCfocyIzRbwf73aohVej4Oql018xfyjKHt
 Y0Q3QVQIxeGMeM70LomTxuwBZi00xcL5KlmsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781802034; x=1782406834;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZcqBl9MGo5keDsaGunZf7Kbn8uQHXFUIROLGD7+Cdxs=;
 b=P73wWqxakCfrWCc9fbnw6nr0lVKzqyODjlyuMpUO3DoeMPapIFRt56uoA43750PrsF
 fpygZwblGGzaVwXWDsuH95zhxZMngB7IPrQ6Azyua+qR93V4Lb5BXMCFIMeIjCMXmqD3
 X0aWDrGMzsdtN4ZC9H2ITP7VZe2G9bclRvTWIVolBUQUTx1XAoLMqL1RcKrrNc0OpKDi
 Ct4QBCDwVcXrMvzoLSB7lCHAHxUKkk1a2EMIz2XZeIiA+KwWeaR8ukSDJ55QgPpEwrTB
 rQQQ84SxgecH4u+/M1pIpJReW8PaesU2Vp6s2Nv6KqJWZMg69/fnmPlzSEdTsjUHXEk+
 Rf0w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/rfdVrzS00QX/wSJkCmxpHlI1uc4a+eFggGxKuZEL7VCapGGV+hmMFjZCENEpDA1wcxrutfEXNyZA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzHmJN9lmKB4k0Wu/jFJzLB41axZ2cFRY1wgpbTX5gwkiQwzeHm
 LqMG8+qCmD2ljk5ZwNTEQGIbyjIuNGn5AnONz99Dyyb0jjDcIc0Rk+f0yMgTSQB8tYKQVWRO2jP
 pTr4=
X-Gm-Gg: AfdE7ckV0WRzX8kC9FoDEZVuOxfFOWap63mLRAP8L8fxTYWxDkNn18AIeLb8lq9jlAJ
 Bct0hyukHd/aYJXaG/K++9Ak4epzOSEAZPesK7f/yGphJGOBme5+PfLIVFUblrEWsOIM6PxmflD
 x9jbejcCCnKy+YcAlUYRtZkIFfRxpbNRxvpK3KYwg3nG+Byifwzvw4H9R/YQnIPB1EVoj3vhwYM
 pYKfvhK1xZzYh2aEOPIQIfZlkJjl70Xo+8E+kCgMOjD2rHYU0J4iOb7nyMBdmpM2TfREXFi5X0U
 hSpyOAbnDtzJR2fXTWKBBfs9JFNwV2Tej0GUem4JgKPTrUrncF3jvA6A3elkmRboDAf0qRcOuKL
 twMPYhqrNbQgzA1SmqUB5Ah//AnZqYytpt9RqW/inQ2fp59vNPliqd97hPuTZqphboPRiVbQ3Ff
 TtpQLSpKG+WA9Lkdg/rQ2r+rfV9+gsX8XvEwRr2d9crLli7hGI3dhR46k=
X-Received: by 2002:a05:6122:c92:b0:56f:696a:4fec with SMTP id
 71dfb90a1353d-5bbd2a62c29mr1978268e0c.5.1781802033548; 
 Thu, 18 Jun 2026 10:00:33 -0700 (PDT)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com.
 [209.85.221.181]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5bbea3b46f6sm72056e0c.14.2026.06.18.10.00.31
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 10:00:31 -0700 (PDT)
Received: by mail-vk1-f181.google.com with SMTP id
 71dfb90a1353d-5bbe617d624so267607e0c.0
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 10:00:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ8cjiS2+nVvrT/PRvz8GguJuIFk98lJ9+HTsrouxrQqD2nMHQC7Px35NakoUmtOtQpUVhT3YOwKFI8=@lists.freedesktop.org
X-Received: by 2002:a05:6122:630c:10b0:5a2:497:328e with SMTP id
 71dfb90a1353d-5bbd2b3cf4bmr1469561e0c.6.1781802030784; Thu, 18 Jun 2026
 10:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260605-topic-sm8650-ayaneo-pocket-s2-r63419-v7-0-b84b6da84293@linaro.org>
 <20260605-topic-sm8650-ayaneo-pocket-s2-r63419-v7-2-b84b6da84293@linaro.org>
In-Reply-To: <20260605-topic-sm8650-ayaneo-pocket-s2-r63419-v7-2-b84b6da84293@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 18 Jun 2026 10:00:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W5FgXGznH1+SA74WOfAUXaAggaJi=ds8udqZ69K3i=Ow@mail.gmail.com>
X-Gm-Features: AVVi8Ce_ut-32lQvTeJIIrgccY3EJcV-YqwYkYCDQTO3z8hfvNAAO1n3hS3X_Xs
Message-ID: <CAD=FV=W5FgXGznH1+SA74WOfAUXaAggaJi=ds8udqZ69K3i=Ow@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] drm: panel: add support for the Renesas R63419
 based dual-DSI video mode Display Panels
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 KancyJoe <kancy2333@outlook.com>
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

On Fri, Jun 5, 2026 at 7:51=E2=80=AFAM Neil Armstrong <neil.armstrong@linar=
o.org> wrote:
>
> From: KancyJoe <kancy2333@outlook.com>
>
> Implement support for the Renesas 63419 based dual-DSI video mode
> Display Panels found in the Ayaneo gaming handled devices.
>
> Signed-off-by: KancyJoe <kancy2333@outlook.com>

I notice "Kancy Joe" has a space in the source files, but not in the
signoff. I guess Signed-off-by isn't necessarily required to be real
names these days, but still seems odd...


> +/*
> + * Helper to switch between DSI links, so we share a single dsi_ctx
> + * for both links, so in case of an error all writes & sleep for
> + * both links are ignored.
> + */
> +static inline void dsi_link_switch(struct renesas_r63419_panel *ctx,
> +                                  struct mipi_dsi_multi_context *dsi_ctx=
,
> +                                  unsigned int link)
> +{
> +       dsi_ctx->dsi =3D ctx->dsi[link];
> +}
> +
> +static int renesas_r63419_on(struct renesas_r63419_panel *ctx)
> +{
> +       struct mipi_dsi_multi_context dsi_ctx =3D { 0 };
> +
> +       /* Panel registers are loaded from DDIC Non Volatile Memory */
> +
> +       dsi_link_switch(ctx, &dsi_ctx, 0);
> +       mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> +       dsi_link_switch(ctx, &dsi_ctx, 1);
> +       mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);

Instead of dsi_link_switch(), can't you use the mipi_dsi_dual()
function? I think it would be:

mipi_dsi_dual(mipi_dsi_dcs_exit_sleep_mode_multi, dsi_ctx,
ctx->dsi[0], ctx->dsi[1]);


> +static int renesas_r63419_disable(struct drm_panel *panel)
> +{
> +       struct renesas_r63419_panel *ctx =3D to_renesas_r63419_panel(pane=
l);
> +       struct mipi_dsi_multi_context dsi_ctx =3D { 0 };
> +
> +       dsi_link_switch(ctx, &dsi_ctx, 0);
> +       mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> +       dsi_link_switch(ctx, &dsi_ctx, 1);
> +       mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> +       mipi_dsi_msleep(&dsi_ctx, 50);
> +
> +       dsi_link_switch(ctx, &dsi_ctx, 0);
> +       mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> +       dsi_link_switch(ctx, &dsi_ctx, 1);
> +       mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> +       mipi_dsi_msleep(&dsi_ctx, 120);
> +
> +       return dsi_ctx.accum_err;

I'm not sure we've been terribly consistent, but should the above be
"return 0"? I'm not actually sure there's any benefit to a panel's
disable() function returning an error to begin with.
drm_panel_disable() doesn't return an error, so all this does is skip
setting "panel->enabled" to false and make it harder for the system to
recover.


> +static int renesas_r63419_prepare(struct drm_panel *panel)
> +{
> +       struct renesas_r63419_panel *ctx =3D to_renesas_r63419_panel(pane=
l);
> +       int ret;
> +
> +       ret =3D regulator_bulk_enable(ARRAY_SIZE(renesas_r63419_vdd_suppl=
ies),
> +                                   ctx->vdd_supplies);
> +       if (ret < 0)
> +               return ret;
> +
> +       usleep_range(1000, 2000);
> +
> +       ret =3D regulator_bulk_enable(ARRAY_SIZE(renesas_r63419_vcc_suppl=
ies),
> +                                   ctx->vcc_supplies);
> +       if (ret < 0) {
> +               regulator_bulk_disable(ARRAY_SIZE(renesas_r63419_vdd_supp=
lies),
> +                                      ctx->vdd_supplies);
> +               return ret;
> +       }
> +
> +       usleep_range(1000, 2000);
> +
> +       gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> +
> +       usleep_range(3000, 4000);
> +
> +       ret =3D renesas_r63419_on(ctx);
> +       if (ret < 0) {
> +               dev_err(panel->dev, "Failed to initialize panel: %d\n", r=
et);
> +
> +               /* Power off sequence from the r63419 datasheet */
> +               regulator_bulk_disable(ARRAY_SIZE(renesas_r63419_vcc_supp=
lies),
> +                                      ctx->vcc_supplies);
> +               regulator_bulk_disable(ARRAY_SIZE(renesas_r63419_vdd_supp=
lies),
> +                                      ctx->vdd_supplies);
> +
> +               gpiod_set_value_cansleep(ctx->reset_gpio, 1);

To make de-init opposite to init, shouldn't the reset come before you
turn the regulators off? Depending on the design of the panel, I'd
imagine this could prevent back-powering some logic?

I'd also expect vdd supplies to be turned off first?


> +static int renesas_r63419_unprepare(struct drm_panel *panel)
> +{
> +       struct renesas_r63419_panel *ctx =3D to_renesas_r63419_panel(pane=
l);
> +
> +       /* Power off sequence from the r63419 datasheet */
> +       regulator_bulk_disable(ARRAY_SIZE(renesas_r63419_vcc_supplies), c=
tx->vcc_supplies);
> +       regulator_bulk_disable(ARRAY_SIZE(renesas_r63419_vdd_supplies), c=
tx->vdd_supplies);
> +
> +       gpiod_set_value_cansleep(ctx->reset_gpio, 1);

Similar: shouldn't the reset come before the regulators to make
power-off the opposite of init.


> +static int renesas_r63419_get_modes(struct drm_panel *panel,
> +                                   struct drm_connector *connector)
> +{
> +       struct renesas_r63419_panel *ctx =3D to_renesas_r63419_panel(pane=
l);
> +       const struct drm_display_mode *mode =3D ctx->desc->mode;
> +
> +       drm_connector_set_panel_orientation(connector, ctx->orientation);

IIRC, the above was a workaround that caused a warning splat. Is your
panel used on a system that actually needs it? Could your DRM driver
be fixed rather than persisting this hack? For context, see commit
47bef230225b ("drm/panel: panel-edp: Implement .get_orientation
callback")


> +static int renesas_r63419_probe(struct mipi_dsi_device *dsi)
> +{
> +       struct mipi_dsi_device_info info =3D { };
> +       struct device *dev =3D &dsi->dev;
> +       struct renesas_r63419_panel *ctx;
> +       struct device_node *dsi1_node;
> +       struct mipi_dsi_host *dsi1_host;
> +       int ret, i;
> +
> +       ctx =3D devm_drm_panel_alloc(dev, struct renesas_r63419_panel, pa=
nel,
> +                                  &renesas_r63419_panel_funcs, DRM_MODE_=
CONNECTOR_DSI);
> +       if (IS_ERR(ctx))
> +               return PTR_ERR(ctx);
> +
> +       ctx->desc =3D of_device_get_match_data(dev);
> +       if (!ctx->desc)
> +               return dev_err_probe(dev, -ENODEV,
> +                                    "Failed to get panel description\n")=
;
> +
> +       ret =3D devm_regulator_bulk_get_const(&dsi->dev,
> +                                           ARRAY_SIZE(renesas_r63419_vdd=
_supplies),
> +                                           renesas_r63419_vdd_supplies, =
&ctx->vdd_supplies);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret =3D devm_regulator_bulk_get_const(&dsi->dev,
> +                                           ARRAY_SIZE(renesas_r63419_vcc=
_supplies),
> +                                           renesas_r63419_vcc_supplies, =
&ctx->vcc_supplies);
> +       if (ret < 0)
> +               return ret;

It seems like both sets of supplies are always enabled / disabled
together with no delay between them. Do you truly need two lists, or
can this be combined to one list of regulators. That would simplify a
bunch of logic.


> +       ctx->reset_gpio =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +       if (IS_ERR(ctx->reset_gpio))
> +               return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
> +                                    "Failed to get reset gpio\n");
> +
> +       /* Get second DSI host */
> +       dsi1_node =3D of_graph_get_remote_node(dsi->dev.of_node, 1, -1);
> +       if (!dsi1_node)
> +               return dev_err_probe(dev, -ENODEV,
> +                                    "Failed to get remote node for secon=
d DSI\n");
> +
> +       dsi1_host =3D of_find_mipi_dsi_host_by_node(dsi1_node);
> +       of_node_put(dsi1_node);
> +       if (!dsi1_host)
> +               return dev_err_probe(dev, -EPROBE_DEFER,
> +                                    "Failed to find second DSI host\n");
> +
> +       /* Copy current DSI info, do not provide OF node since no driver =
needs to be attached */
> +       strscpy(info.type, dsi->name, sizeof(info.type));

Can't you use the two-argument form of strscpy()?

FWIW, I also notice that the Sashiko AI bot had some comments. Did you
already look all of those over and decide they don't need fixing? I
have a vague recollection that there's no need to worry about someone
calling disable() and then enable() without going through the
unprepare() / prepare(). If my memory is correct, I guess that would
be nice to document... I didn't analyze some of the other claims that
the AI bot had.


-Doug
