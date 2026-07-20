Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B76BC44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 13:09:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39F7110E126;
	Mon, 20 Jul 2026 13:09:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WgjlWrrG";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57E6C10E126
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 13:09:48 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-47640541585so5074886f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784552987; x=1785157787; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=E8mYPhXUmZpNbn2oVo3k+YKafzsgCsS1GE9LMv7AFBw=;
 b=WgjlWrrGJlLZbUBRYuTHXf/6WnUpyHqdyM0Ydx5z8VILmnlRzNaZq71kNRWVnIZug9
 XZO6wGu5pqrmkzqo5M9ZM0Ei3pa01MGcmVEXIs5D+ZBlYaWy9SFY4B3szHclSi4HGLAK
 wrNY9Bxki5DfbS4Rg6AJIahi7h39tUitcg2isXHR4Gq5Q9LVWm4BmVYbm2yxF2bwksJR
 Ef5MRPOaY/qUp8kOoim/+rRe6chl4S4MYNr5gMCP6mPTHgzDvYVW8MbrNoKpGvr2m9Eo
 Kgr/wxd5cBI9Q0BNBf51T0FNypa8l90llSgNQegm4lnyFaOYh37k56NH4/v+Pp4wAaj/
 Nt/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784552987; x=1785157787;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E8mYPhXUmZpNbn2oVo3k+YKafzsgCsS1GE9LMv7AFBw=;
 b=K4wr703A1hEMjHlT+cNCCRdUAW2sKu0Swhwfo8LVd7ZKzGD/wROlRyF0wR93/Xtutl
 0rCoFUyKKoDAg0PfU9DH981W041e8S5KRZE19eAWeA6gtAmurxxa+1xecbLOgRspXrqf
 QhyuB9tFO9s1NQYI3AXoZ/oRgg05zQZk3iYt7G/rYbL9qkarrC9W/tZDTU4rayVa1DSd
 9m7i7ppX56dWYjPtkdxCpgyVU+9YTQP5z1n65e382YkGdc99l+9bCkdJSObWqvfoADAu
 KasWwipYZrbED5VRfo4rcza/dbgbXXR2tC2PGVlm+4r/WCNmjmz3dcbSGWLkkf68aUwk
 DvIg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqK4Xnion9JJkzPKER5ZsA8yB2GlKEjXgPXebWJkJx6arH6IpQE9V3NQLbrC2GJp4Jmve2HuQ7D2Hs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YynznQYfru1jEoo/G46WczaOp524Wil4H4xdiuOWDpKG96/GHfZ
 Pc3Mljz+d4nfQNlRxE1R9godymG0QauXJkYZzF2mlA+4mB0mgtLPLDPkKeN9CkDEiaI=
X-Gm-Gg: AR+sD121ODJeD4LH9AAfjIFZh71Hv5dqGhw7UXtS11Rt5SqYzOi4ouOxXOu835Y5aSz
 19z6vNZudN55EJeHlwab53wdi5p2DIx2elC0DOm1pU47w2AWDpU0M7i53IE/Oqh75DKc6Z7vLvN
 1tLLmvZm6Yxxv3mte4NjAIzuFPUsP3Px97gs8uvPXYEvF8Q4e3Ub0cGI/SaMTK/znAmDbiz5KmK
 Hltl9DYiK5yhZqEtHhKv6PJgSOxvdFAp5DKsLkm1wbHiHq8mf7qMZHyokkHT4mMMY5WRJ6qD/X/
 ZTciVOzROoWW5kseXZjsklay7uz/cXwb0MyjnmOpBb1YVn9Uofx+krCci4mYrFQ2BCk07VG6Y8A
 n56WzBZ9rWm4ialNtJNDinEo8TJrVeBXyqHaM3tOeb7I7dZz40C7u8yxC6SSI4qATzoW26Bg6Q5
 okeKvctXYWtOEXyn84tRwDhr4=
X-Received: by 2002:a05:6000:25fe:b0:46e:c978:7ddc with SMTP id
 ffacd0b85a97d-47f62316b85mr16082343f8f.24.1784552986541; 
 Mon, 20 Jul 2026 06:09:46 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ec7ea1sm30767434f8f.24.2026.07.20.06.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 06:09:46 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Inki Dae <inki.dae@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
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
 Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Yannick Fertre <yannick.fertre@foss.st.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Philippe Cornu <philippe.cornu@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Jyri Sarha <jyri.sarha@iki.fi>, Jingoo Han <jingoohan1@gmail.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Alison Wang <alison.wang@nxp.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Alain Volmat <alain.volmat@foss.st.com>,
 Raphael Gallais-Pou <rgallaispou@gmail.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Albert Esteve <aesteve@redhat.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev,
 linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 0/4] drm/panel: refcounting panel lookups and references
Date: Mon, 20 Jul 2026 15:09:38 +0200
Message-Id: <178455228150.789946.15332957012612566281.b4-ty@b4>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717-drm_refcount_wiring-v3-0-023900c32e01@redhat.com>
References: <20260717-drm_refcount_wiring-v3-0-023900c32e01@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Fri, 17 Jul 2026 16:02:03 +0200, Albert Esteve wrote:
> The drm_panel subsystem provides kref-based reference counting [1]
> (drm_panel_get/put) but almost nothing in the tree actually uses it.
> This results in a systemic use-after-free pattern throughout the codebase.
> 
> This series aims to close all those issues.
> 
> Patches 1-2: fix the infrastructure. drm_panel_add/remove now keep
> a counted reference for the list entry. drm_panel_bridge_add_typed()
> now holds a counted reference for the lifetime of the panel_bridge.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/4] drm/panel: have drm_panel_add/remove manage a list reference
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/b619d9d2af33db01ea237e3546e9d55595e94ea0
[2/4] drm/bridge/panel: hold a reference to the wrapped panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/34069e04d338a333561b64a2da055bd16bfba39b
[3/4] drm/panel: of_drm_find_panel() return a counted reference
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/738ff709f7cf82a41cbd9f6b8f9b1f236ce26610
[4/4] drm/panel: find_panel_by_fwnode() return a counted reference
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/d857b8ce04a7ed4b36a11db16968ab1652ed702a

-- 
Neil
