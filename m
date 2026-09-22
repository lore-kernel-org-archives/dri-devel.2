Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAF0C982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:23:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3598D10E477;
	Tue, 22 Sep 2026 08:23:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="u2EoGzb0";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A36C10E477
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 08:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=jhl12w2BK3T73bfh332u/N28Aqr0VzNZAxke4cgagwM=; b=u2EoGzb0ti7/TwOnyh9MQVstlN
 w0Pg4/YOo2FcGHfMzDj6DJWTLAZl/q6wfb0gQBuemkKb1j0eeW+WYstTYzTZ6EoAxsccNubqQJUZN
 +EareNsxJgvta6aTnqHlYNGYQ7C3eiT2vi9mBsUwMy++Rd5ky9sTpJAoeHrfvRv2Tdpzcd7STIENx
 qSKtdU4j3clbqQeFKrx0t6PTBYYSXYjWGzr5u0CaUp+ZTrI5ngCU9xUwss//eYPvorO28GHHAVxC1
 dHDdKIt8PuB9naKPeh9/KaHsg4R0I1BlucAmJM3BYHEO3lnkZ28rRXo9h86iKeESOIYIqjw9nbcN9
 C7eDjFYw==;
From: Heiko Stuebner <heiko@sntech.de>
To: Damon Ding <damon.ding@rock-chips.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Paul Cercueil <paul@crapouillou.net>,
 Paul Kocialkowski <paulk@sys-base.io>, Linus Walleij <linusw@kernel.org>,
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Sean Paul <sean@poorly.run>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Albert Esteve <aesteve@redhat.com>, Anusha Srivatsa <asrivats@redhat.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-mips@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, asahi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v3 19/19] drm/bridge: analogix_dp: don't create a
 panel_bridge
Date: Tue, 22 Sep 2026 10:22:37 +0200
Message-ID: <1889588.TLkxdtWsSY@phil>
In-Reply-To: <DLLOZYM6YWJ3.6Q0LRD1WABGW@bootlin.com>
References: <20260916-drm-bridge-every-panel-v3-0-83afb4f1a707@bootlin.com>
 <975a4d45-9a61-4858-b498-8bc0a1e44746@rock-chips.com>
 <DLLOZYM6YWJ3.6Q0LRD1WABGW@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Hi Luca,

Am Dienstag, 22. September 2026, 10:12:41 Mitteleurop=C3=A4ische Sommerzeit=
 schrieb Luca Ceresoli:
> On Mon Sep 21, 2026 at 5:07 AM CEST, Damon Ding wrote:
> > On 9/16/2026 9:45 PM, Luca Ceresoli wrote:

[...]

> >> @@ -163,18 +161,6 @@ static int exynos_dp_probe(struct platform_device=
 *pdev)
> >>   	 */
> >>   	platform_set_drvdata(pdev, dp);
> >>
> >> -	/* This is for the backward compatibility. */
> >> -	np =3D of_parse_phandle(dev->of_node, "panel", 0);
> >> -	if (np) {
> >> -		dp->plat_data.panel =3D of_drm_find_panel(np);
> >> -
> >> -		of_node_put(np);
> >> -		if (IS_ERR(dp->plat_data.panel))
> >> -			return PTR_ERR(dp->plat_data.panel);
> >> -
> >> -		goto out;
> >> -	}
> >> -
> >
> > TIP: In my WIP v3 patch series, I use of_drm_find_panel() together with
> > devm_drm_panel_bridge_add() to maintain this backward compatibility. But
> > I also think this old approach should be deprecated now. Shall we add
> > some notes in the commit message to mention the deprecation of this met=
hod?
>=20
> What is the "WIP v3" series exactly? Do you have a link (to v2 in case v3
> is not yet public)?

https://lore.kernel.org/linux-rockchip/20260804081717.741404-1-damon.ding@r=
ock-chips.com/
is the series in question.


Heiko


