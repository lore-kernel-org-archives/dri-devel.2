Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63ACC982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 07:21:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9FA910E865;
	Tue, 22 Sep 2026 07:21:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Yj//uerr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17E5610E84D;
 Tue, 22 Sep 2026 07:21:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A39DE4062A;
 Tue, 22 Sep 2026 07:21:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DF01F000FF;
 Tue, 22 Sep 2026 07:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790061671;
 bh=cDUjakSfivK+j3JucGQ7wVw8vSSD4PLZiCTaXb0dxUM=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=Yj//uerrbeF4Ys7qx8ZI8YzzWlRDE8at8TXIqg9uv5i4ceMCPMe/6H+JCN3ZZqdFD
 0f25wSTn4teqlR365pHl5gXfFwYak+T2L8wee9QbPpaGzelEoLA0pWaftWNMlbjsHV
 I9G59NNpP7udHX9GCShylNPH96SOVCgY4KW1oLCsqtHsVuIsUeMWHu5R2Bj9vr9dq8
 u6omfkXKsIgYfRo7XNCsXaaVsUFLVztKqbH3jYDt5AsM/QcepJZn6eIv5nQ+Bag5DX
 lISmdhnFevrbBzJoDCZCvmohfCidvKLBviYh+vXIJjIFYCuCYQetih7Q8le0GBPTAA
 emaAcziTBDjsQ==
Message-ID: <c2064b9839029b05f17bd66d4642ccc9@kernel.org>
Date: Tue, 22 Sep 2026 07:21:07 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v3 16/19] drm/bridge: ssd2825: don't create a panel_bridge
In-Reply-To: <20260916-drm-bridge-every-panel-v3-16-83afb4f1a707@bootlin.com>
References: <20260916-drm-bridge-every-panel-v3-16-83afb4f1a707@bootlin.com>
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

On Wed, 16 Sep 2026 15:45:40 +0200, Luca Ceresoli wrote:
> Now a panel_bridge is automatically created for every drm_panel and the
> panel-bridge API is just a deprecated wrapper to access it.
> 
> Update and simplify the code by just getting a reference to the
> already-existing bridge using of_drm_get_bridge_by_endpoint().
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
