Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9040CC43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 15:12:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDF6910F66F;
	Fri, 26 Jun 2026 15:12:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="IucztFzk";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6AAC10F66F
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 15:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782486727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gNWd65/LlS1S7z+e2JXdypKHFrBZo/8VRicT21AfZoc=;
 b=IucztFzkThIEwOajAhn+zqBfJ+suPv8RGKGssYWDwzdr0BSp0vnPP3ftsf2Gt+aE72xgXp
 +mvnYvC1WxPjQH/1O0Ng7MSfUljHI5ukMrHCtOahfWnZF9jxS7dEb3FEZW4kz03y1o01lG
 obCYAlOckTf2RuBpW6st8jTakSMFPKw=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-rJ1a3RmzOiuH8JqtANBHfg-1; Fri, 26 Jun 2026 11:11:55 -0400
X-MC-Unique: rJ1a3RmzOiuH8JqtANBHfg-1
X-Mimecast-MFC-AGG-ID: rJ1a3RmzOiuH8JqtANBHfg_1782486714
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-7fd85d01ed0so21866247b3.1
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 08:11:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782486714; x=1783091514;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gNWd65/LlS1S7z+e2JXdypKHFrBZo/8VRicT21AfZoc=;
 b=WQi/qP2HzLLFQAoo4a4s2gb0vrt3y/zHFn9wbbehMIsIZT6RtrdQbHnzb4DDfjrm+t
 wirt61lrdpS2MVqcmD72Zkh+RQP46fjOvF4vIw/drR71A0S8dHmLkS+1bi8s8Oh6OZHK
 zw/cNmZ9DiQv8Uy7ub4pW8cTO3p7qHUK3xTNxbav/XQ8bLSnmDeWlGKe60WFCe1ok3Aq
 44/McQ04kwmQERN6T9MC1D3oJNIUQMzVDXuvMqAnw6xQebctohreOi3OP/tF6cq6RKMl
 nswM+Q9wnZ8TqYZBcIlsifjMMkiyLSV6N/uLEM/Uq6wWJqahvlz0p1jwFjdFMPy5myHn
 U2Tw==
X-Forwarded-Encrypted: i=1;
 AHgh+RryO7sODrciAWDRuXhcVxpw0hQAAImV1+1UyuDe1RjzjBunOyLO3vOlmSx1p8PWnbeOFQAZzSzGkZY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxFSbR76EQqXJqSlEdAAanI4UWnRZTKjnXKxDvw6VSEOKXzj0Vr
 zZagJftIyjtu5zuwApTgbr95F9z6sbXMuPAqxe08jhogZvATNvDBiNXh64XFM6HqoiI/1A/DlUl
 aWS3KMeoDVp0fIW7N2iSu0YuABJVCZcAkZkHdiqZftPEYR4eM5xn05VbvnW1zWA1Of8WPcigxph
 ta7qFq+HPZTH9aHspzD/1EVamVcyHTHKwTpTR0+nWpzC8U
X-Gm-Gg: AfdE7clXXP31jS6UYrMMf+aM+D6bYzsAoNv8+QwC4AtWlb2HpmsrJY5HM3USzl+dZEN
 fBGod5JUBdOPp6N2YcccqanjDgpY9Wv5QQ32+An3w1CWCPCltHVyejCuBDgmLZZGe8q0Y3k5FmY
 ihFx72gVQ0P/ReTme7XQlOfM9y93RmT2BaI4WELTIHW/H94WX0jecRxncjPjBPVlT5
X-Received: by 2002:a05:690c:6804:b0:7fc:cbe1:746d with SMTP id
 00721157ae682-80c73fe6f4bmr9719607b3.42.1782486714005; 
 Fri, 26 Jun 2026 08:11:54 -0700 (PDT)
X-Received: by 2002:a05:690c:6804:b0:7fc:cbe1:746d with SMTP id
 00721157ae682-80c73fe6f4bmr9718797b3.42.1782486713496; Fri, 26 Jun 2026
 08:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260626-drm_refcount_wiring-v1-0-cca1a7b3bdef@redhat.com>
 <20260626-drm_refcount_wiring-v1-3-cca1a7b3bdef@redhat.com>
 <20260626-successful-badger-from-neptune-ae2bc6@houat>
In-Reply-To: <20260626-successful-badger-from-neptune-ae2bc6@houat>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 26 Jun 2026 17:11:42 +0200
X-Gm-Features: AVVi8CdeJARTOKb4ohxfJd8a69EdpRugjimEtA7qtwxmMR2cbKOdWmwQblTZgKI
Message-ID: <CADSE00LO98u6aDwvjijO_hAaMBXSGXaWPuFWiveQi_RWQ0MTVA@mail.gmail.com>
Subject: Re: [PATCH 3/5] drm/panel: make *find_panel*() return a counted
 reference
To: Maxime Ripard <mripard@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
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
 Mikko Perttunen <mperttunen@nvidia.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev, 
 linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: S1cBFCZVUPBajgXCwJfJh3XGr9BH5y02G4UQ28Y5XWA_1782486714
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

On Fri, Jun 26, 2026 at 2:50=E2=80=AFPM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> On Fri, Jun 26, 2026 at 02:03:25PM +0200, Albert Esteve wrote:
> > Callers of of_drm_find_panel() receive a pointer with no reference
> > held, creating a window where the panel device can be unregistered
> > and freed between the lookup and first use (e.g., drm_panel_prepare()).
> >
> > find_panel_by_fwnode() is the fwnode counterpart of of_drm_find_panel()=
.
> > drm_panel_add_follower() worked around the missing panel kref by callin=
g
> > get_device() on the panel's underlying struct device. However, get_devi=
ce()
> > only prevents the device kobject from being freed. It does not prevent =
the
> > panel's kzalloc()'d container memory from being released when the kref
> > reaches zero.
> >
> > Fix both lookup functions by acquiring a reference with drm_panel_get()
> > before returning, under panel_lock. Callers are now responsible for cal=
ling
> > drm_panel_put() when they no longer need the pointer.
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  drivers/gpu/drm/drm_panel.c | 22 +++++++++++++++++-----
> >  1 file changed, 17 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> > index 545fe93dc28fe..a00ae98ed0956 100644
> > --- a/drivers/gpu/drm/drm_panel.c
> > +++ b/drivers/gpu/drm/drm_panel.c
> > @@ -458,14 +458,17 @@ EXPORT_SYMBOL(__devm_drm_panel_alloc);
> >
> >  #ifdef CONFIG_OF
> >  /**
> > - * of_drm_find_panel - look up a panel using a device tree node
> > + * of_drm_find_panel - look up and reference a panel by device tree no=
de
> >   * @np: device tree node of the panel
> >   *
> >   * Searches the set of registered panels for one that matches the give=
n device
> > - * tree node. If a matching panel is found, return a pointer to it.
> > + * tree node. If a matching panel is found, the panel's reference coun=
t is
> > + * incremented before returning a pointer to it. The caller must call
> > + * drm_panel_put() when it no longer needs the panel pointer.
> >   *
> > - * Return: A pointer to the panel registered for the specified device =
tree
> > - * node or an ERR_PTR() if no panel matching the device tree node can =
be found.
> > + * Return: A reference-counted pointer to the panel registered for the=
 specified
> > + * device tree node or an ERR_PTR() if no panel matching the device tr=
ee node
> > + * can be found.
> >   *
> >   * Possible error codes returned by this function:
> >   *
> > @@ -484,6 +487,7 @@ struct drm_panel *of_drm_find_panel(const struct de=
vice_node *np)
> >
> >       list_for_each_entry(panel, &panel_list, list) {
> >               if (panel->dev->of_node =3D=3D np) {
> > +                     drm_panel_get(panel);
> >                       mutex_unlock(&panel_lock);
> >                       return panel;
> >               }
> > @@ -538,7 +542,13 @@ int of_drm_get_panel_orientation(const struct devi=
ce_node *np,
> >  EXPORT_SYMBOL(of_drm_get_panel_orientation);
> >  #endif
> >
> > -/* Find panel by fwnode. This should be identical to of_drm_find_panel=
(). */
> > +/*
> > + * Find panel by fwnode, returning a counted reference.
> > + *
> > + * Behaves identically to of_drm_find_panel(). On success the returned
> > + * pointer has been passed through drm_panel_get(); the caller must ca=
ll
> > + * drm_panel_put() when done with it.
> > + */
> >  static struct drm_panel *find_panel_by_fwnode(const struct fwnode_hand=
le *fwnode)
> >  {
> >       struct drm_panel *panel;
> > @@ -550,6 +560,7 @@ static struct drm_panel *find_panel_by_fwnode(const=
 struct fwnode_handle *fwnode
> >
> >       list_for_each_entry(panel, &panel_list, list) {
> >               if (dev_fwnode(panel->dev) =3D=3D fwnode) {
> > +                     drm_panel_get(panel);
> >                       mutex_unlock(&panel_lock);
> >                       return panel;
> >               }
>
> This part should probably be in a separate patch

Yes. This is another place where I hesitated on organization, as it is
very similar to of_drm_find_panel() fix. But find_panel_by_fwnode() is
much more self-contained (it is declared static to begin with). So it
makes sense to split them. I will do so in the next version.

>
> > @@ -686,6 +697,7 @@ void drm_panel_remove_follower(struct drm_panel_fol=
lower *follower)
> >       mutex_unlock(&panel->follower_lock);
> >
> >       put_device(panel->dev);
> > +     drm_panel_put(panel);
> >  }
> >  EXPORT_SYMBOL(drm_panel_remove_follower);
>
> together with this one?
>
> Maxime

