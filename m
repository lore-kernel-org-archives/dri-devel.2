Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B24C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 06:59:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E90210EBC0;
	Tue, 22 Sep 2026 06:59:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iVem6NK5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9200F10EBBA;
 Tue, 22 Sep 2026 06:59:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D36866020F;
 Tue, 22 Sep 2026 06:59:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09AD1F00893;
 Tue, 22 Sep 2026 06:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790060386;
 bh=fWS6VemCJQZVIwP1tf2Y6qbGjMYyL6clHJEnGhczC3U=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=iVem6NK51SNQhuNU9/3VNzRt45Nh3hNfislWZtoOmfE7THXCD16zsAGGUJgyOvFt3
 wdVD0fsrMS30UjrIMWvrKGGrljlPWS1gvpZkoQdsI4LQXmrxXcI4N3FY1DVJmb9dos
 mZZqj+HRrg/38SaP7uFPmaDFMG/vuTnQ2niRfpcJGsnMtUme52+dU/Uhc0H3g8gxnN
 LClGSi9TVUnwnihRHh/2BhAl0BENTLXhQ7LaucgwzwSe8KJhqox1Td+JU+pskfqrdF
 b+/tQn8QyMXE1vyTktB6dkSUcqcYHR0zXRjWPFjHNZf1iW3+3GcQZz5+ywLVPz/YJ4
 z8N+D4jV4n2yg==
Message-ID: <b55e64b4e64d9d39c2417b9713623697@kernel.org>
Date: Tue, 22 Sep 2026 06:59:43 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v3 11/19] drm/mcde: dsi: remove unused includes
In-Reply-To: <20260916-drm-bridge-every-panel-v3-11-83afb4f1a707@bootlin.com>
References: <20260916-drm-bridge-every-panel-v3-11-83afb4f1a707@bootlin.com>
Cc: asahi@lists.linux.dev, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-tegra@vger.kernel.org, "Albert
 Esteve" <aesteve@redhat.com>, "Andrzej Hajda" <andrzej.hajda@intel.com>,
 "Anusha
 Srivatsa" <asrivats@redhat.com>, "David Airlie" <airlied@gmail.com>, "Dmitry
 Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>,
 "Fabio Estevam" <festevam@gmail.com>, "Frank
 Li" <Frank.Li@nxp.com>, "Hui Pu" <Hui.Pu@gehealthcare.com>,
 "Ian Ray" <ian.ray@gehealthcare.com>, "Inki
 Dae" <inki.dae@samsung.com>, "Jagan Teki" <jagan@amarulasolutions.com>, "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, "Jessica Zhang" <jesszhan0024@gmail.com>,
 "Jonas
 Karlman" <jonas@kwiboo.se>, "Jonathan Corbet" <corbet@lwn.net>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>,
 "Laurentiu Palcu" <laurentiu.palcu@oss.nxp.com>, "Linus
 Walleij" <linusw@kernel.org>, "Lucas Stach" <l.stach@pengutronix.de>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Marek Szyprowski" <m.szyprowski@samsung.com>, "Maxime
 Ripard" <mripard@kernel.org>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Paul
 Cercueil" <paul@crapouillou.net>, "Paul Kocialkowski" <paulk@sys-base.io>,
 "Pengutronix
 Kernel Team" <kernel@pengutronix.de>, "Randy Dunlap" <rdunlap@infradead.org>,
 "Robert
 Foss" <rfoss@kernel.org>, "Sascha Hauer" <s.hauer@pengutronix.de>, "Sean
 Paul" <sean@poorly.run>, "Shuah Khan" <skhan@linuxfoundation.org>, "Simona
 Vetter" <simona@ffwll.ch>, "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
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

On Wed, 16 Sep 2026 15:45:35 +0200, Luca Ceresoli wrote:
> The helpers are included but unused.
> 
> However symbols from drm_atomic_helper.h are used, and were previously
> available as a side effect of drm_atomic_helper.h including
> drm_atomic_state_helper.h. Add drm_atomic_state_helper.h.
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
