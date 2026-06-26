Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6AF9C43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:12:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24D7A10E199;
	Fri, 26 Jun 2026 13:12:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="jI6VoJVV";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BA9F10F0D1
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 13:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782479517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VKNTFsC75BNMcJnQI4eMzMtTvr9UpO3oOorJIEMb0vQ=;
 b=jI6VoJVVtkx59s1FKLHPCJDYoDRqIQUvTCUo2Ol3WsdTkhw88n8AkxHqjWh+PRstyoIbMm
 GvAioRmAlArx23xpBoGJdbmHE6AuKPoVryRhyTP2F9Iaasl3Tfl+4xjWKJJIrWZdIA0X2C
 oIdEJsiT/W4k6d1DeDnWhVF5c9bgelk=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-2rTe0k0DPY-dpj8qBTI-tA-1; Fri, 26 Jun 2026 09:11:54 -0400
X-MC-Unique: 2rTe0k0DPY-dpj8qBTI-tA-1
X-Mimecast-MFC-AGG-ID: 2rTe0k0DPY-dpj8qBTI-tA_1782479513
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-8003dfff66dso18517027b3.1
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 06:11:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782479513; x=1783084313;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VKNTFsC75BNMcJnQI4eMzMtTvr9UpO3oOorJIEMb0vQ=;
 b=lXFOB1wmlVPny8JyLywEp48woS5JzAowCIjszN6nJ0MPF7/xpPyhSw2ASoU2dI6zoo
 WA2rZHDJ61tdTSAmhkKvQgx7kDLbtlWZU/cXLMVmmEth7fhm80tybM/VBdoPTSM+SbRJ
 s321y98SaNUo/gHQS8IgE2JdmfSUO003rsj2vs3GYMk6S2QSvMq6vdaEc69OWsjtlN6A
 TkU26DnYFF1tQsx1aA2RMdcxeTon/wEPdQzC+KhGoi49kimLXpYurtVzyKntSBLqIfsh
 XZPVvxp184+SAQdGGowGFZQ99SVT/0Azyn61uDSatymBDQ0rUAT56huZYhJNgjvaGlhj
 Q6dg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpAIwFE0nqynncpvt6/irPUuCBNgPIvk0w20qGb8npx2kwPqd0h6FO8hteouQRTzDdZpMpYw+4kz9c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxnLY0Wl8gre45/3W9qM9ahRwRM8IP9+oLAqeqjT2W0VNbV8vnf
 9rUmzoRuqqN2Q50mgmcwKnOh7LeJsK0WvjVpShchXeWdncupXI5e5HzuUJlKIn86ERfyZbH/c1Q
 0lVxMABLo6c7a6BbsS6qT9geXUAalZT2QVGeOsifRlPQxIDyJqi8W9qVdB+B6NsEXDVN1tWRMPK
 YCVvkyLliDuzeGQb5OrrSWT0LDJMWfZZiCscbuaq/NEZ+F
X-Gm-Gg: AfdE7cna7Y1PSjAjX2H7f4n4kgMuCejaFSOLo7Mg7yoAbNJRhZyPqCD7Lp4lKPrkA55
 IgZmGPuEITGXo7PwJXJur3Ipstx5HdMEZiRb5a03z4Qa6615wLNATyptYNstQuSqrTTNeqKOukq
 x7vOvmzRff9L6oRNBYywVo7TVsJDB5ct0LMwJLR3nC865UaDVaQjneghBUwf7brVb/
X-Received: by 2002:a05:690c:2601:b0:80b:ef0a:7aad with SMTP id
 00721157ae682-80bef0a8585mr15809367b3.31.1782479513410; 
 Fri, 26 Jun 2026 06:11:53 -0700 (PDT)
X-Received: by 2002:a05:690c:2601:b0:80b:ef0a:7aad with SMTP id
 00721157ae682-80bef0a8585mr15808937b3.31.1782479512984; Fri, 26 Jun 2026
 06:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260626-drm_refcount_wiring-v1-0-cca1a7b3bdef@redhat.com>
 <20260626-drm_refcount_wiring-v1-4-cca1a7b3bdef@redhat.com>
 <20260626-manipulative-rainbow-rhino-d73b65@houat>
In-Reply-To: <20260626-manipulative-rainbow-rhino-d73b65@houat>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 26 Jun 2026 15:11:41 +0200
X-Gm-Features: AVVi8CcW-L7vrM5Bm_e3_mA7DiL0CVsM1LDa8FwSzsOcNktoquvN-pr6tbwgp5U
Message-ID: <CADSE00+1m1ASzJzefO2bLuMYAJa3kSmW4py7Qng70VnZSUv0sg@mail.gmail.com>
Subject: Re: [PATCH 4/5] drm/bridge: release panel reference on all lookup
 exit paths
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
X-Mimecast-MFC-PROC-ID: iC14dF4C4SMecXQcQ9Unza7mng8f8HCZ5a-mySRBrw8_1782479513
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

On Fri, Jun 26, 2026 at 2:53=E2=80=AFPM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> On Fri, Jun 26, 2026 at 02:03:26PM +0200, Albert Esteve wrote:
> > of_drm_find_panel() and drm_of_find_panel_or_bridge() now return a
> > counted reference that the caller must release with drm_panel_put().
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
>
> I think this one should be either split into one patch per driver, or
> merged with the of_drm_find_panel patch. I'm still not quite sure which
> would be the best, maybe the latter?

I have spent some time myself thinking about how to approach this.
Initially I thought about doing one patch per driver as you suggested,
but since there are many similar fixes that are mostly one-liners, In
the end I decided that grouping them would make the review easier and
result in a less inflated series. Maybe merging with of_drm_find_panel
patch makes sense to avoid having one patch introducing a transient
reference leak (even if it is fixed right after and is bisectable).
But that will also create a giant patch (harder to review?). Another
option could be to merge patches 4 and 5, which basically update all
callers, and keep the API update separated. Either way, I am happy
with whatever you decide is better. I will take note of this for v2.

>
> Maxime

