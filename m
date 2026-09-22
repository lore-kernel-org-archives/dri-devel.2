Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0095C982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:08:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF4E310E612;
	Tue, 22 Sep 2026 08:08:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="FGUyk9MH";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F22EE10E612
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 08:08:02 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 767EA4E40ED6;
 Tue, 22 Sep 2026 08:08:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 468C860580;
 Tue, 22 Sep 2026 08:08:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4056C1032925B; 
 Tue, 22 Sep 2026 10:07:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790064477; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=zcp8tcZsfdsmxUcen5sJupr/nyZnxY5fTXf1NQWKnsw=;
 b=FGUyk9MHJzJ0m0z8YAThEo2DOBHDLTsuC25rLZr2qIfJay2Q0I+gVCvTxsv2nvY/dDnJb9
 IgXAUJLDLFyWtCu0gq4m+hX3dLL+xecsNJ8WJa5QPeWS1Zy6AUoS89OPdFALC8X5Qo/SYt
 P+8Axb3+Z77DYvypZw+Bo1A5RcA0P5rB/gomubC1yCw1+sui5hmFk5wLv6D9zSGNbH/9I3
 BDo6gZcaNWSmUaB3MSGwrUc50FkG95rYvnEytrHx7tFcZXjfqgUddfJurME6kZVkekBte7
 SOpxzk5wN3ckVBb+KRlg6NycfNY3+6MfShb4b9lHPUZw9BG8DyTys0vA4UWL/w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 10:07:36 +0200
Message-Id: <DLLOW2ROGP6L.3GTVT76VYPGAU@bootlin.com>
Subject: Re: [PATCH v3 19/19] drm/bridge: analogix_dp: don't create a
 panel_bridge
Cc: "Albert Esteve" <aesteve@redhat.com>, "Anusha Srivatsa"
 <asrivats@redhat.com>, "Dmitry Baryshkov"
 <dmitry.baryshkov@oss.qualcomm.com>, "Hui Pu" <Hui.Pu@gehealthcare.com>,
 "Ian Ray" <ian.ray@gehealthcare.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <imx@lists.linux.dev>,
 <linux-arm-kernel@lists.infradead.org>, <linux-mips@vger.kernel.org>,
 <linux-rockchip@lists.infradead.org>,
 <linux-stm32@st-md-mailman.stormreply.com>, <asahi@lists.linux.dev>,
 <linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
 <linux-tegra@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-samsung-soc@vger.kernel.org>, "Heiko Stuebner" <heiko@sntech.de>
To: "Damon Ding" <damon.ding@rock-chips.com>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>, "Andrzej Hajda" <andrzej.hajda@intel.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>, "Robert Foss"
 <rfoss@kernel.org>, "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,
 "Jonas Karlman" <jonas@kwiboo.se>, "Jernej Skrabec"
 <jernej.skrabec@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Jessica Zhang"
 <jesszhan0024@gmail.com>, "Laurentiu Palcu" <laurentiu.palcu@oss.nxp.com>,
 "Lucas Stach" <l.stach@pengutronix.de>, "Frank Li" <Frank.Li@nxp.com>,
 "Sascha Hauer" <s.hauer@pengutronix.de>, "Pengutronix Kernel Team"
 <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>, "Paul
 Cercueil" <paul@crapouillou.net>, "Paul Kocialkowski" <paulk@sys-base.io>,
 "Linus Walleij" <linusw@kernel.org>, "Inki Dae" <inki.dae@samsung.com>,
 "Jagan Teki" <jagan@amarulasolutions.com>, "Marek Szyprowski"
 <m.szyprowski@samsung.com>, "Sean Paul" <sean@poorly.run>, "Jonathan
 Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "Randy
 Dunlap" <rdunlap@infradead.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20260916-drm-bridge-every-panel-v3-0-83afb4f1a707@bootlin.com>
 <20260916-drm-bridge-every-panel-v3-19-83afb4f1a707@bootlin.com>
 <975a4d45-9a61-4858-b498-8bc0a1e44746@rock-chips.com>
 <96882735-091f-49c6-a47b-5da8be711818@rock-chips.com>
In-Reply-To: <96882735-091f-49c6-a47b-5da8be711818@rock-chips.com>
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Damon,

On Mon Sep 21, 2026 at 8:34 AM CEST, Damon Ding wrote:
> On 9/21/2026 11:07 AM, Damon Ding wrote:
>> Hi Luca,
>>
>> On 9/16/2026 9:45 PM, Luca Ceresoli wrote:
>>> Now a panel_bridge is automatically created for every drm_panel and the
>>> panel-bridge API is just a deprecated wrapper to access it.
>>>
>>> Update and simplify the code by just getting a reference to the
>>> already-existing bridge using of_drm_get_bridge_by_endpoint().
>>>
>>> As of_drm_get_bridge_by_endpoint() returns a refcounted bridge, take ca=
re
>>> of putting the bridge reference. This is not easily done in the remove
>>> path
>>> due to the different probe paths of the user drivers, so add a devm
>>> action
>>> to ensure the reference is put only when it was taken.
>>>
>>> Assisted-by: opencode:deepseek-v4-flash-0731
>>> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>>> ---
>>> =C2=A0 drivers/gpu/drm/bridge/analogix/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 -
>>> =C2=A0 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 40 ++++++++=
++++
>>> +---------
>>> =C2=A0 drivers/gpu/drm/exynos/exynos_dp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 36 +
>>> +-----------------
>>> =C2=A0 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c=C2=A0=C2=A0=C2=
=A0 |=C2=A0 9 -----
>>> =C2=A0 include/drm/bridge/analogix_dp.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 1 -
>>> =C2=A0 5 files changed, 25 insertions(+), 62 deletions(-)
>>>
>
> [snip]
>
>>> @@ -488,14 +487,6 @@ static void rockchip_dp_remove(struct
>>> platform_device *pdev)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct rockchip_dp_device *dp =3D platfo=
rm_get_drvdata(pdev);
>
> The above unused &rockchip_dp_device could be also remved.

Ah, indeed!

I guess I can keep your review tags if applying this patch with only this
line removed. Correct?

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
