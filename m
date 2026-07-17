Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82034C44514
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:26:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD8F210E44E;
	Fri, 17 Jul 2026 11:26:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="hbuaHMNf";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9242010E44E
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 11:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784287579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vXe76W/8pIhJ+QV+npP2Pr4GqXg7ylW2+hZyFUAZkxo=;
 b=hbuaHMNfVh/BTlEUtqw2qc88EQ5YrQJttUseyY/ZW5fbk68bM7/2J47/ytW8GSVyPUZu+F
 utec4FzXZOTpv9YvNnvpNMNs41+i7FmLqC4iNgxM2JMow75DMd0/6Zsji/ErK4zVNYS+sw
 LlikvaofhxxezrDsxgYQkKZPYSY57v0=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-wqjS7WmFM2i_Jd9SmtXopQ-1; Fri, 17 Jul 2026 07:26:18 -0400
X-MC-Unique: wqjS7WmFM2i_Jd9SmtXopQ-1
X-Mimecast-MFC-AGG-ID: wqjS7WmFM2i_Jd9SmtXopQ_1784287578
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-668432d53c5so97639d50.1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 04:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784287578; x=1784892378;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vXe76W/8pIhJ+QV+npP2Pr4GqXg7ylW2+hZyFUAZkxo=;
 b=stqBEYurb5jXi2lLFK4DnKgKQi0oJGf9PsW/rO+8OZxq5CdB9oC1/EhzhYkh/RZmPq
 mC30uDCxlKjSxB84y9aA6xsEiz8NWPwfNQmWfFs0BQpH2YSAhqaaa8N9H8Sspp8Dqos2
 q5nP8LEMRcv8a8zvWCubkgYWVdm4D/W2LjPvlQBmy++dIEAAmyPFDcwPKV7ukEeNRxuz
 1vgFsgjr59Nf8V6Boiqh5BcLMeMTFvja4ZM8n6NjLsuWepmMH3i2O2+sYZm0EiipYwRT
 cXKCveF7EKij2jQiPCghD2jT7a6gm7/BFOxzsZc5ABiHzRGb0NbGEzOyxaK4nzXElZNj
 zrug==
X-Forwarded-Encrypted: i=1;
 AHgh+RqgmasYvYDAZ7TLsCuxQcrjqO7USxCxMLpi/Yx838magZR4Ke6FCCu8K94+0FKpkAQhE6zo8albk9U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw/ebaP6gODpwR7mgADj5K1SXS8NjfpOwdPyi30uSqX5pCQjbtv
 7vRpLzZx3Uj2UfD7GgybQocWmwPlcU6IUnF/w59Va7FM4V1h9qOySKgLEhXJWFhcXhbTYxK4gjs
 ZThX2pbeXk8CZLexVXEJp7ai0wJzq5lBQNRf59yIJUIk6+fSQpGD45o5RK0Stl8sznYVPiu9eKd
 5iGxx/qwZ0pl4GWy29E83Jamhrb4RMaByzLrAW+ISmUpoR
X-Gm-Gg: AfdE7cnzmexP4yg7yDlKoBvSkB8+nL9IBGBm3jKCau03gDZTqMIaeBt1Rcr7yF0peCC
 LLohXfdQ9i2UMEKKRG9zs/gxvo56hjtKJFF1CMYcdYptXrTYwEIUt3G7C+wudYSbqVLIUsT4QHv
 jux/WAmiRP9glDnOHX/bn2/6eBLYyhpoWCNZ7j6oMh82Chl/RoSnjI8XcJ
X-Received: by 2002:a05:690e:43cb:b0:668:43ce:50e4 with SMTP id
 956f58d0204a3-66843ce511emr36174d50.53.1784287577984; 
 Fri, 17 Jul 2026 04:26:17 -0700 (PDT)
X-Received: by 2002:a05:690e:43cb:b0:668:43ce:50e4 with SMTP id
 956f58d0204a3-66843ce511emr36162d50.53.1784287577611; Fri, 17 Jul 2026
 04:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260713-drm_refcount_wiring-v2-0-d3bb61f4bd4d@redhat.com>
 <20260713-drm_refcount_wiring-v2-5-d3bb61f4bd4d@redhat.com>
 <20260717-heavenly-peach-guan-82f0f1@houat>
In-Reply-To: <20260717-heavenly-peach-guan-82f0f1@houat>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 17 Jul 2026 13:26:06 +0200
X-Gm-Features: AUfX_my0X2LQ6M_jKeRcxy0r6pG-sYFIFgqEmiZmXcdV57T8jjudIQuMMnSFyJg
Message-ID: <CADSE00+7=2ph4kRQLc7_MFbp_SSt3eYz-bBxWcfCj6_oFPjwFA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] drm: release panel reference after panel bridge
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
X-Mimecast-MFC-PROC-ID: RB7clPF2HyCdqchUBUaEnx_FOHdtjTJ_uS-TvzYkjUk_1784287578
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

On Fri, Jul 17, 2026 at 10:56=E2=80=AFAM Maxime Ripard <mripard@kernel.org>=
 wrote:
>
> On Mon, Jul 13, 2026 at 01:53:08PM +0200, Albert Esteve wrote:
> > Update a second batch of drivers calling of_drm_find_panel() or
> > drm_of_find_panel_or_bridge() to release the lookup reference after
> > wrapping the panel in a bridge.
>
> I would have expected this to be squashed of patch 3, any reason it's in
> a separate patch?

My intention was to make the series easier to review. Patch 3
contained the initial set of callers mostly found via the Coccinelle
script (simpler to address generally), and patch 5 includes the rest.
Including all the changes plus the core API update in a single commit
felt like too much.

That said, I am happy to squash this for the next version (fewer
patches to track).




>
> > Also handle the cases where a panel is found but cannot be used,
> > dropping the reference immediately in those paths.

