Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA37C4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 11:47:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4467510F2BB;
	Thu, 16 Jul 2026 11:47:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="FpUz4L+o";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EAE510F2BB
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 11:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784202472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UAIX8vflpEyEoElDzYTggPPmyd+hUNgJkFp1xG3W/a0=;
 b=FpUz4L+ofRnmCKbWTj/bpK7Aq3hMpeIF/EwEDe2FKCddcXBMhAJ0+bHNazVGWGddXD4WNQ
 asliUihUH1aqB4oIBmLpasx0jQjhMauq2L+819feYWm67sFkMmOW1ilzLR0eRSAY2W6g4v
 0itZqzkZws9Ubka7NRaSRhc0EFxeMg4=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-n8oyUhshOrqBoHgl8LX5nw-1; Thu, 16 Jul 2026 07:47:49 -0400
X-MC-Unique: n8oyUhshOrqBoHgl8LX5nw-1
X-Mimecast-MFC-AGG-ID: n8oyUhshOrqBoHgl8LX5nw_1784202469
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-81e6bb29581so32483687b3.2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 04:47:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784202468; x=1784807268;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UAIX8vflpEyEoElDzYTggPPmyd+hUNgJkFp1xG3W/a0=;
 b=g8wDh0u5Og2katTTSQr1PXrouN932Jt26sKTXbF9uju9s37n8ZsmD9l/I1zQvpzNW0
 4EwgWPq0w7VRPbA71t7kr0WBxaFWv/ryo2KAYbfJyErYIbZE5lKkpPV6Ll/0mtgIBRzM
 JVc/Gw3wrZxsYIYv4cIhik6m6Ov3T+nYD4ydUWDuKPhZdFFxV3M43nraYA9M2KgOgx82
 VU056jtKc2u43fAvJZVMTrPNA4unAoa9slLghpIOONl/4AHv/SjmE91dWjw/BDoKlKZf
 UuuSkd6F23ur6pc6drUtN3XtuN1FqN7GZFM4hr3Ek7hx/GbEjBVhFla+iUHrqWcKIuZh
 lpEg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro2IjSi0RQW431n82kkFn2Vgrx0L/dmO2kVzKUyNQRk2ivgW37ndBuevJG+xWQ4IIHpAvCm6KjvpIs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxUBKCYyVccCFtvDlwSTQMHFEZE6AM830Q0O5HSZbskocxMDvs2
 qg4dW04a9C4IO1bt65/SKAnFyzw0/6WRnX6VkGHT8xFjote/641okd+qmRWXSk6iF717zB5nRtz
 WlhQ2qw4kf78JBfBeTB9br1gZxzowPadBPFJ72ZN1n5CIMnnERTQ/F27YS9VLbobJK6hA0R94ps
 2udtbbubJNh419qh0quzUzASvwbb0Am4i19wG76VGHOPYF
X-Gm-Gg: AfdE7cki6oz0GfLQsaai4RjaJsxIn9uBd7tKUlVy2q9RzYgpNtiJFKGYc9dxr0pcMYu
 bvIhInKich5o+ZobcachI92CgUivJFocf0I6xFF7FUq1Jx16kFnw+pk+UL848vbu2WUEyv/HyYX
 CcDGYEAgT3qZjxaYlAnYTIA9mVV6R9Ao7HeemnUabRHVBufRg4b3/FcfJI
X-Received: by 2002:a05:690c:6a89:b0:81e:c898:bc51 with SMTP id
 00721157ae682-81ecfb77678mr53197667b3.70.1784202468629; 
 Thu, 16 Jul 2026 04:47:48 -0700 (PDT)
X-Received: by 2002:a05:690c:6a89:b0:81e:c898:bc51 with SMTP id
 00721157ae682-81ecfb77678mr53196867b3.70.1784202468141; Thu, 16 Jul 2026
 04:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260713-drm_refcount_wiring-v2-0-d3bb61f4bd4d@redhat.com>
 <20260713-drm_refcount_wiring-v2-3-d3bb61f4bd4d@redhat.com>
 <hm3gW14-QtmZmT6DKePecw@nvidia.com>
In-Reply-To: <hm3gW14-QtmZmT6DKePecw@nvidia.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 16 Jul 2026 13:47:37 +0200
X-Gm-Features: AUfX_mzB2JkO-VIACloxhbX7HbPpRRw8TGetupyA1jCWwziSfKUaXthnbS4hOYU
Message-ID: <CADSE00Lsr9gsW6HEFrrc6Aq+ecN5mN9Kev_mf5XKjKjAk44-GA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] drm/panel: of_drm_find_panel() return a counted
 reference
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Paul Cercueil <paul@crapouillou.net>, 
 Linus Walleij <linusw@kernel.org>, Marek Vasut <marex@denx.de>,
 Stefan Agner <stefan@agner.ch>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, 
 Biju Das <biju.das.jz@bp.renesas.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Yannick Fertre <yannick.fertre@foss.st.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Philippe Cornu <philippe.cornu@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Jyri Sarha <jyri.sarha@iki.fi>, 
 Jingoo Han <jingoohan1@gmail.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Alison Wang <alison.wang@nxp.com>, Paul Kocialkowski <paulk@sys-base.io>, 
 Alain Volmat <alain.volmat@foss.st.com>,
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-sunxi@lists.linux.dev, linux-samsung-soc@vger.kernel.org, 
 linux-tegra@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lg8xa1xYiuythI2oO_McQTI8e-IxbhtkMKMOgjC6XOU_1784202469
X-Mimecast-Originator: redhat.com
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

On Wed, Jul 15, 2026 at 9:14=E2=80=AFAM Mikko Perttunen <mperttunen@nvidia.=
com> wrote:
>
> On Monday, July 13, 2026 8:53=E2=80=AFPM Albert Esteve wrote:
> > Callers of of_drm_find_panel() receive a pointer with no reference
> > held, creating a window where the panel device can be unregistered
> > and freed between the lookup and first use (e.g., drm_panel_prepare()).
> >
> > Fix the lookup function by acquiring a reference with drm_panel_get()
> > before returning, under panel_lock. Callers are now responsible for
> > calling drm_panel_put() when they no longer need the pointer.
> >
> > For bridge drivers that immediately wrap the panel in a panel_bridge
> > (which acquires its own reference), release the lookup reference right
> > after the bridge creation call.
> >
> > For analogix-anx6345, which stores the panel for direct use, release
> > the reference in the i2c remove path.
> >
> > For platform drivers using analogix_dp_core with a component lifecycle
> > (exynos_dp, rockchip analogix_dp), release the lookup reference in the
> > platform remove() function. The panel_bridge created during bind() hold=
s
> > a separate reference that devm cleanup releases after remove() returns.
> >
> > Also fix devm_drm_of_get_bridge() and drmm_of_get_bridge() in
> > bridge/panel.c itself: both call drm_of_find_panel_or_bridge() and
> > then pass the panel to devm/drmm_panel_bridge_add(), which acquires
> > its own reference via drm_panel_bridge_add_typed(). The lookup
> > reference was never released; add drm_panel_put() after each bridge
> > creation call.
> >
> > Assisted-by: Claude:claude-opus-4-6
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  drivers/gpu/drm/bridge/analogix/analogix-anx6345.c |  3 +++
> >  drivers/gpu/drm/bridge/panel.c                     |  8 ++++++--
> >  drivers/gpu/drm/drm_of.c                           |  3 ++-
> >  drivers/gpu/drm/drm_panel.c                        | 12 ++++++++----
> >  drivers/gpu/drm/exynos/exynos_dp.c                 | 10 ++++++++++
> >  drivers/gpu/drm/exynos/exynos_drm_dpi.c            |  3 +++
> >  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c          | 18 ++++++++++++++=
++++
> >  drivers/gpu/drm/logicvc/logicvc_interface.c        | 12 ++++++++++++
> >  drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    | 11 +++++++++++
> >  drivers/gpu/drm/sti/sti_dvo.c                      |  3 +++
> >  drivers/gpu/drm/stm/lvds.c                         |  3 +++
> >  drivers/gpu/drm/sun4i/sun4i_lvds.c                 | 13 +++++++++++++
> >  drivers/gpu/drm/sun4i/sun4i_rgb.c                  | 13 +++++++++++++
> >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c             |  2 ++
> >  drivers/gpu/drm/tegra/dsi.c                        |  1 +
> >  drivers/gpu/drm/tegra/output.c                     |  3 +++
> >  16 files changed, 111 insertions(+), 7 deletions(-)
> >
> > ...
> > diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
> > index 7f25c50621c94..57a016f47434d 100644
> > --- a/drivers/gpu/drm/tegra/dsi.c
> > +++ b/drivers/gpu/drm/tegra/dsi.c
> > @@ -1516,6 +1516,7 @@ static int tegra_dsi_host_detach(struct mipi_dsi_=
host *host,
> >       struct tegra_output *output =3D &dsi->output;
> >
> >       if (output->panel && &device->dev =3D=3D output->panel->dev) {
> > +             drm_panel_put(output->panel);
> >               output->panel =3D NULL;
> >
> >               if (output->connector.dev)
> > diff --git a/drivers/gpu/drm/tegra/output.c b/drivers/gpu/drm/tegra/out=
put.c
> > index 49e4f63a5550d..90db39dbdd332 100644
> > --- a/drivers/gpu/drm/tegra/output.c
> > +++ b/drivers/gpu/drm/tegra/output.c
> > @@ -195,6 +195,9 @@ int tegra_output_probe(struct tegra_output *output)
> >
> >  void tegra_output_remove(struct tegra_output *output)
> >  {
> > +     if (output->panel)
> > +             drm_panel_put(output->panel);
> > +
> >       if (output->hpd_gpio)
> >               free_irq(output->hpd_irq, output);
> >
> >
>
> tegra_output_probe's error cleanup paths need to be updated to clean up
> the refcount. Also, it can technically call drm_of_find_panel_or_bridge
> and then overwrite that value with of_drm_find_panel. While there's
> already a WARN_ON for that case, I think it would be good to fix the
> refcounting there as well for consistency.

Agreed. I really missed those. I am doing another general check in
case I missed similar cases.

>
> As a note, the tegra-dsi code also uses tegra_output and can overwrite
> the panel field with its own -- but in those cases tegra_output should
> never populate the panel and we've been talking about removing that
> code path anyway, so the dsi code can continue to assume that
> tegra_output_probe doesn't populate a panel.

Thanks. I will add a note before of_drm_find_panel() in tegra/dsi.c to clar=
ify.

BR,
Albert

>
> Cheers
> Mikko
>
> > --
> > 2.54.0
> >
> >
>
>
>
>

