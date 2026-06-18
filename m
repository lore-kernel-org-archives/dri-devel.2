Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BDECD98F8
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 13:39:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59A2810E32A;
	Thu, 18 Jun 2026 13:39:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="PUOZ5Di9";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A560810E32A
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 13:38:58 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 075174E42FA3;
 Thu, 18 Jun 2026 13:38:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C21505FF03;
 Thu, 18 Jun 2026 13:38:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E90E5106C8181; 
 Thu, 18 Jun 2026 15:38:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1781789933; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=q17Yakrk0jyin/K7MigNcOnMz+6gtRbwepNdHP9jFKM=;
 b=PUOZ5Di9LG9HfrQqQCFFBVq94tgu/N/628JI3wjlG+04IUEZ/TDfwfWPiCYIYoY01Ml/zT
 u6fzfs/sOXhZCzpGZcGWKrttnj2hg362abIuU+SlEEsUQGe8DjkMXc8FOQFe+vm08MjMCD
 q4ik5cK5VDldEGCZCpBmhx07jaHCoG868HTUDceg1cGMzWrhvEOeO+nri9uBQ9XxJlsEEd
 kFcTWnviop36LYp6WwxAMULWvuPB1A6oFC1kNXA6jr27XI08XezUNwOxPYoBipe1i/JzdI
 5yYVYBawm+zEtwTD77BtUYcO3v4DG3A1Zq8nGdrWLS8BS2P5ZVV6JJvam6Mhog==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Jun 2026 15:38:33 +0200
Message-Id: <DJC7T6B6DCZI.3F29YF2M1ZCAF@bootlin.com>
Subject: Re: [PATCH v2 00/78] drm/bridge: Convert all reset users to
 create_state
Cc: "Dmitry Baryshkov" <lumag@kernel.org>,
 <dri-devel@lists.freedesktop.org>, "Laurent Pinchart"
 <laurent.pinchart+renesas@ideasonboard.com>, "Jagan Teki"
 <jagan@amarulasolutions.com>, "Liu Ying" <victor.liu@nxp.com>, "Frank Li"
 <Frank.Li@nxp.com>, "Sascha Hauer" <s.hauer@pengutronix.de>, "Pengutronix
 Kernel Team" <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>,
 <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>, "Andy Yan"
 <andy.yan@rock-chips.com>, "Phong LE" <ple@baylibre.com>, "Douglas
 Anderson" <dianders@chromium.org>, "Inki Dae" <inki.dae@samsung.com>,
 "Marek Szyprowski" <m.szyprowski@samsung.com>, "Philipp Zabel"
 <p.zabel@pengutronix.de>, "Paul Cercueil" <paul@crapouillou.net>,
 <linux-mips@vger.kernel.org>, "Chun-Kuang Hu" <chunkuang.hu@kernel.org>,
 "Matthias Brugger" <matthias.bgg@gmail.com>, "AngeloGioacchino Del Regno"
 <angelogioacchino.delregno@collabora.com>,
 <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 "Kevin Hilman" <khilman@baylibre.com>, "Jerome Brunet"
 <jbrunet@baylibre.com>, "Martin Blumenstingl"
 <martin.blumenstingl@googlemail.com>, <linux-amlogic@lists.infradead.org>,
 "Tomi Valkeinen" <tomi.valkeinen+renesas@ideasonboard.com>, "Geert
 Uytterhoeven" <geert+renesas@glider.be>, "Magnus Damm"
 <magnus.damm@gmail.com>, "Kieran Bingham"
 <kieran.bingham+renesas@ideasonboard.com>,
 <linux-renesas-soc@vger.kernel.org>, "Biju Das"
 <biju.das.jz@bp.renesas.com>, "Heiko Stuebner" <heiko@sntech.de>, "Sandy
 Huang" <hjc@rock-chips.com>, <linux-rockchip@lists.infradead.org>, "Yannick
 Fertre" <yannick.fertre@foss.st.com>, "Raphael Gallais-Pou"
 <raphael.gallais-pou@foss.st.com>, "Philippe Cornu"
 <philippe.cornu@foss.st.com>, "Maxime Coquelin"
 <mcoquelin.stm32@gmail.com>, "Alexandre Torgue"
 <alexandre.torgue@foss.st.com>, <linux-stm32@st-md-mailman.stormreply.com>,
 "Jyri Sarha" <jyri.sarha@iki.fi>, "Tomi Valkeinen"
 <tomi.valkeinen@ideasonboard.com>, "Dave Stevenson"
 <dave.stevenson@raspberrypi.com>, =?utf-8?q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>, "Raspberry Pi Kernel Maintenance"
 <kernel-list@raspberrypi.com>, "Icenowy Zheng" <zhengxingda@iscas.ac.cn>,
 "Michal Simek" <michal.simek@amd.com>
To: "Maxime Ripard" <mripard@kernel.org>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.21.0
References: <20260608-drm-no-more-bridge-reset-v2-0-0a91018bf886@kernel.org>
 <20260618-terrestrial-abiding-tamarin-01befc@houat>
In-Reply-To: <20260618-terrestrial-abiding-tamarin-01befc@houat>
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

Hi Maxime,

On Thu Jun 18, 2026 at 1:20 PM CEST, Maxime Ripard wrote:
> Hi,
>
> On Mon, Jun 08, 2026 at 04:35:42PM +0200, Maxime Ripard wrote:
>> Hi,
>>
>> All the bridges use reset to create a blank state only and don't use it
>> to reset the hardware at all. This is what the new atomic_create_state
>> is exactly supposed to be doing, so we can convert all existing bridge
>> users to it, and remove the reset hook and helpers.
>>
>> Let me know what you think,
>> Maxime
>>
>> Signed-off-by: Maxime Ripard <mripard@kernel.org>
>
> FTR, Thomas on IRC yesterday[1] added
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>
> Unless another review shows up, I intend to merge this tomorrow

Did you have a look at my questions for patches 7 and 8?

I was planning to review the following patches but that would be based on
what I asked there.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
