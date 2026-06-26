Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 700D8C43211
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 15:05:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF2C210E3D6;
	Fri, 26 Jun 2026 15:05:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="dfU9ntf5";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3F1610E3D6
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 15:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782486316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dQWoBG3cdhdrXUGK8cjuSemvsRSH2KT/hQo0wNib96o=;
 b=dfU9ntf5VCw2uQpEIlX3yxWsHBXKkdctYP9boMfsXSD7lUE4lRBGTqCeh2mBRwh0nxa1Rs
 CxPrf1mw9fJDbFZAYsCrkZg4KrmeOu7oGZT9Oq3/m4anIwwWXyyubwdIAlGTcjDQAta7/D
 De8D06nLkneZ27FcIo0PQoEA73TKDyg=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-gljsFpwJPTifXSzKkd3oEg-1; Fri, 26 Jun 2026 11:05:14 -0400
X-MC-Unique: gljsFpwJPTifXSzKkd3oEg-1
X-Mimecast-MFC-AGG-ID: gljsFpwJPTifXSzKkd3oEg_1782486314
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-800292c6be0so15495227b3.1
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 08:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782486314; x=1783091114;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dQWoBG3cdhdrXUGK8cjuSemvsRSH2KT/hQo0wNib96o=;
 b=mrtb9r2LOPyH3JZI/G0lDky6E0FFu6Aky4PttrDBXjJptXVj6p4vsnde3IJhgLr+13
 DTbIegJI+5C0z4U0STLK0CKrCdgYUSz97/+PWUBFKNv4GLBuQRYJ4jPRPRaUcCKAq1Ls
 hHZMdKiun5ZN0BwnjbfKuYrsfHXtzFsCcJj4EENha8Nl6c/49W2GRs64PZ+CcR/K69dJ
 xQXLEtgV36ubgfVjDgF8JVaEU+IrlVQ41dcUzduUaU3Niy8n2FeCkcVqIi4VFicESvKM
 5E5iRx9qwgRnB5oXhK82jYQ+5sMebby1FBBV8Kia2LalOZr5UuyMLnnGv9Qlbw/O9uNn
 DtCw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpZ8thkpLpUytfKyMjNFabJyc3aWgBwyNULYnCNFqLXp9xdvDABiBgBog+/OTYItMGs/+M22YFqrZQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzS0K/Q54pA4JNK9DcU6jX0GRkBp7ysAapLlopNhLAPaQTqQthZ
 ug15LnIvnERtoTFk2I3pQQ62xw7FC6fpuiXlpHTfQxcIZPxMvtMUw3y+vK1MvRCyn4b+W0K7CRv
 K4AOxD1eIhCeoDc8sCIN9LTp54low5QZ8UXsJLOTTR4XH/DFF9EcgURbBeHc9ZSYOiZxIgs4Wgr
 Dl8U3Tb3lukoO4nNKi0XW3HTcmde9yZwiPq1ahL0Okjhhb
X-Gm-Gg: AfdE7cloz96LMwhpWNZ3o6VYY4IuHqz+NU00SXQu//JbHBsM/awOn/8hYf4kWn1UMKk
 XRrnTD2M1FW8EXjXYx40cJSVLwES+KIJVK01xSd2V26kkEthOWATj7t680tdudPMsUkeheWYFmN
 CWXtfSFQXRD8IyISscgO+SvyV/r58cNxt5DnAwG5N0UiKDaClit917pXt0+SBDQHl3
X-Received: by 2002:a05:690c:4881:b0:80c:cad:c4e6 with SMTP id
 00721157ae682-80c0cadc8fbmr18141897b3.32.1782486313740; 
 Fri, 26 Jun 2026 08:05:13 -0700 (PDT)
X-Received: by 2002:a05:690c:4881:b0:80c:cad:c4e6 with SMTP id
 00721157ae682-80c0cadc8fbmr18140727b3.32.1782486313097; Fri, 26 Jun 2026
 08:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260626-drm_refcount_wiring-v1-0-cca1a7b3bdef@redhat.com>
 <20260626-drm_refcount_wiring-v1-5-cca1a7b3bdef@redhat.com>
 <20260626-ivory-tarantula-of-valor-af0e2a@houat>
In-Reply-To: <20260626-ivory-tarantula-of-valor-af0e2a@houat>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 26 Jun 2026 17:05:00 +0200
X-Gm-Features: AVVi8CfUWw7MSpxfIbgb0qtM7cCP9XXdSgcc1xFYb1Fq3hJmdhiO9Zy5mZXSYcU
Message-ID: <CADSE00Jy9-BR9e-Dg-S4_fiLnjWjXfTq3c6OO8PxTM=gQyA7xw@mail.gmail.com>
Subject: Re: [PATCH 5/5] drm: release panel reference after panel bridge
 creation
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
X-Mimecast-MFC-PROC-ID: tnI21KXjE0npMiGAEsXxQOD5XedxOjGZ3o8mBh-KihI_1782486314
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

On Fri, Jun 26, 2026 at 3:00=E2=80=AFPM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> On Fri, Jun 26, 2026 at 02:03:27PM +0200, Albert Esteve wrote:
> > of_drm_find_panel() and drm_of_find_panel_or_bridge() now return a
> > counted reference. In drivers that immediately wrap the panel in a
> > bridge via devm_drm_panel_bridge_add() or equivalent, the bridge
> > acquires its own reference, so the caller's lookup reference must be
> > released right afterwards.
> >
> > Also handle the cases where a panel is found but cannot be used,
> > dropping the reference immediately in those paths.
> >
> > Assisted-by: Claude:claude-opus-4-6
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
>
> drm_of_find_panel_or_bridge() does indeed return a refcounted pointer
> now, but afaik the doc wasn't updated to reflect that.

True, I'll fix that in the next version.

>
> More importantly, I feel like with both of_drm_find_panel and
> drm_of_find_panel_or_bridge we update a path that is considered legacy
> anyway now, and we should rather focus on providing a safe alternative.

Oh, I missed that this code path is considered legacy.

>
> But none of the functions you updated are unsafe, so it won't be more
> unsafe, or provide any illusion of safety to the caller. Idk.
>
> Either way, this should all be on its way out if Luca creates a bridge
> for every panel, and we'll consolidate on bridges only, so maybe it's
> not such a big deal to merge this patch.

I see. Given what you wrote, I think it'd make sense to correct them
while this code isn't completely dead.

BR,
Albert.

>
> Maxime

