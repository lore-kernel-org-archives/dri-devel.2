Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9FAACA5FA5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:31:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31E2910E035;
	Thu,  1 Oct 2026 08:31:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="sagW3Htt";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BB9710E035
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 08:31:50 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id B50A01A109B;
 Thu,  1 Oct 2026 08:31:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 81B8260341;
 Thu,  1 Oct 2026 08:31:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5F0F4103290C1; 
 Thu,  1 Oct 2026 10:31:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790843506; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=RiIDTpci/0UJ3NCrt48cxrs7UcRvkm9TcGYKchYj198=;
 b=sagW3Htt5YQwsJod0ppAZZLVo/HIbh2Wh1p3vMtfEqB4XzuMaoD5AyK9Xuqhjsglex+M6K
 d6GboCZyFgqJlMZx/6YAQ/YGbVbRnzF/QRgBYMIxDkxucLFdgQTFK7kiSTyH2OcmiZydOt
 cccMEa+DX6efu2rnGF1NSYK75PUxwZe91djO9sMyVvwWqi1k3ZSaKvhvSSfS4AyzCGrV8Z
 lzPuYHAJ/x6OL2dxv2lcoAoKWQvoySk7ekWG2AyInjDdfcaHesnl6/y18kaAcliFte1w5R
 U/SEZR0ZuELcN7FNSCQ3LXdMRk/6JwXjyWiJuEMWoEEcGGJtD4zg1voBIxS/MA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Oct 2026 10:31:37 +0200
Message-Id: <DLTD1D4TV8ZX.2PNM1B670T8UK@bootlin.com>
Subject: Re: [PATCH v2 5/7] drm/vc4: dpi: stop using deprecated
 drmm_of_get_bridge()
Cc: "Arnd Bergmann" <arnd@kernel.org>, "Doug Anderson"
 <dianders@chromium.org>, "Hui Pu" <Hui.Pu@gehealthcare.com>, "Ian Ray"
 <ian.ray@gehealthcare.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <dri-devel@lists.freedesktop.org>,
 <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>
To: "Paul Cercueil" <paul.cercueil@bootlin.com>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Frank Li"
 <Frank.Li@nxp.com>, "Sascha Hauer" <s.hauer@pengutronix.de>, "Pengutronix
 Kernel Team" <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>,
 "Icenowy Zheng" <zhengxingda@iscas.ac.cn>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Dave Stevenson"
 <dave.stevenson@raspberrypi.com>, =?utf-8?q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>, "Raspberry Pi Kernel Maintenance"
 <kernel-list@raspberrypi.com>, "Geert Uytterhoeven"
 <geert+renesas@glider.be>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20260929-drm-fix-of_get_bridge-build-regression-v2-0-6da431d8f180@bootlin.com>
 <20260929-drm-fix-of_get_bridge-build-regression-v2-5-6da431d8f180@bootlin.com>
 <accaa9f4ad05ef73071e5cfb5368fcbdd394d3ab.camel@bootlin.com>
In-Reply-To: <accaa9f4ad05ef73071e5cfb5368fcbdd394d3ab.camel@bootlin.com>
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

Hi Paul,

On Thu Oct 1, 2026 at 10:22 AM CEST, Paul Cercueil wrote:

>> -/* Sets up the next link in the display chain, whether it's a panel or
>> - * a bridge.
>> - */
>
> The first part of the comment is not wrong, I would keep "Sets up the nex=
t link
> in the display chain".

OK, I will do it in v3. This patch is not a fix, so not urgent.

>> =C2=A0static int vc4_dpi_init_bridge(struct vc4_dpi *dpi)
>> =C2=A0{
>> -	struct drm_device *drm =3D dpi->encoder.base.dev;
>> =C2=A0	struct device *dev =3D &dpi->pdev->dev;
>> -	struct drm_bridge *bridge;
>>
>> -	bridge =3D drmm_of_get_bridge(drm, dev->of_node, 0, 0);
>> +	struct drm_bridge *bridge __free(drm_bridge_put) =3D
>> +		of_drm_get_bridge_by_endpoint(dev->of_node, 0, 0);
>> =C2=A0	if (IS_ERR(bridge)) {
>> =C2=A0		/* If nothing was connected in the DT, that's not an
>> =C2=A0		 * error.
>
> It could make sense to go the extra mile and just move that code back int=
o the
> caller function, I don't see much benefit in having it in a static functi=
on
> here.

Why not. If no one objects I'll do it as an additional patch in v3.

Cheers,
Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
