Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 921C9CC6B16
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 07:31:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D02410E049;
	Thu,  2 Apr 2026 07:31:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="lOIces2p";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C6C810E049
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 07:31:01 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 22F341A30E5;
 Thu,  2 Apr 2026 07:30:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D49CD5FDEB;
 Thu,  2 Apr 2026 07:30:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C2188104502A6; 
 Thu,  2 Apr 2026 09:30:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1775115056; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=mg5DRpO1I9IqFL1uCpjacL1h8jGxnPseFHkiTvt8JGg=;
 b=lOIces2p65XZz1GzTxchohBGLhitrJz1Myv8zRLJM1v6cIfed1WNrgMEJXqF3MbP88hDoR
 KqtNcnSwaaCUoEoZGF30CL7bUv9jXEd2fMK0phlo4H2vZBGYVQ/bpHjHui3GWkBWQyYG68
 ijXqB2tMRuBEsnMuY5MJUchw90gufWormGbWF+EoyqaqrM20LefjoVMUjOjyh6wU63XWzv
 aaVEv8xLr7LctY2kG0TGdzhYkCmen7GK5U2FK0TjXTPnShz4J0aErMdVBVuzSPmlwBMGHw
 ybAIQv531K0SvBsw2H0oOPPVUtEpHZ2jgUKFAXil/tYBte54Dru/mRMZba4m2w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Apr 2026 09:30:38 +0200
Message-Id: <DHIHRIPV0BD1.1117AH7B5HKKL@bootlin.com>
Subject: Re: [PATCH v2 08/10] drm/bridge: imx8mp-hdmi-tx: add an
 hdmi-connector when missing using a DT overlay at boot time
Cc: "Damon Ding" <damon.ding@rock-chips.com>, "Kory Maincent (TI.com)"
 <kory.maincent@bootlin.com>, =?utf-8?q?Herv=C3=A9_Codina?=
 <herve.codina@bootlin.com>, "Hui Pu" <Hui.Pu@gehealthcare.com>, "Ian Ray"
 <ian.ray@gehealthcare.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <dri-devel@lists.freedesktop.org>,
 <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, "Adam Ford"
 <aford173@gmail.com>, "Alexander Stein" <alexander.stein@ew.tq-group.com>,
 "Christopher Obbard" <christopher.obbard@linaro.org>, "Daniel Scally"
 <dan.scally@ideasonboard.com>, "Emanuele Ghidoli"
 <emanuele.ghidoli@toradex.com>, "Fabio Estevam" <festevam@denx.de>,
 "Francesco Dolcini" <francesco.dolcini@toradex.com>, "Frieder Schrempf"
 <frieder.schrempf@kontron.de>, "Gilles Talis" <gilles.talis@gmail.com>,
 =?utf-8?q?Goran_Ra=C4=91enovi=C4=87?= <goran.radni@gmail.com>, "Heiko
 Schocher" <hs@denx.de>, "Josua Mayer" <josua@solid-run.com>, "Kieran
 Bingham" <kieran.bingham@ideasonboard.com>, "Marco Felsch"
 <m.felsch@pengutronix.de>, "Martyn Welch" <martyn.welch@collabora.com>,
 "Oleksij Rempel" <o.rempel@pengutronix.de>, "Peng Fan" <peng.fan@nxp.com>,
 "Richard Hu" <richard.hu@technexion.com>, "Shengjiu Wang"
 <shengjiu.wang@nxp.com>, "Stefan Eichenberger"
 <stefan.eichenberger@toradex.com>, "Vitor Soares"
 <vitor.soares@toradex.com>
To: "Liu Ying" <victor.liu@nxp.com>, "Marek Vasut" <marex@denx.de>, "Stefan
 Agner" <stefan@agner.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Frank Li"
 <Frank.Li@nxp.com>, "Sascha Hauer" <s.hauer@pengutronix.de>, "Pengutronix
 Kernel Team" <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>,
 "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Rob
 Herring" <robh@kernel.org>, "Saravana Kannan" <saravanak@kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20260330-drm-lcdif-dbanc-v2-0-c7f2af536a24@bootlin.com>
 <20260330-drm-lcdif-dbanc-v2-8-c7f2af536a24@bootlin.com>
 <167408cb-2ae8-4863-b8aa-6af7961dd133@nxp.com>
In-Reply-To: <167408cb-2ae8-4863-b8aa-6af7961dd133@nxp.com>
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

Hello Liu,

On Thu Apr 2, 2026 at 6:05 AM CEST, Liu Ying wrote:
> Hi Luca,
>
> On Mon, Mar 30, 2026 at 09:25:49PM +0200, Luca Ceresoli wrote:
>
> [...]
>
>> Changes in v2:
>> - don't apply the overlay if the SoC is not i.MX8MP
>> - build unconditionally, but depend on DRM_IMX_LCDIF
>> - remove useless error check
>> - add missing cleanup.h and init.h includes, remove unneeded includes
>> - avoid dtc warnings on overlay
>> - fix typo in Kconfig help text
>> - not added the Tested-bys because the code has changed
>> - split the 'plat_data->output_port =3D 1' line to a separate patch
>
> v2 also changes commit mesg.

Good to see someone looks at the changelog! :)

Im updating the v2 changelog in v3 to mention this.

>> +	return of_overlay_fdt_apply(dtbo_start, dtbo_size, &ovcs_id, NULL);
>
> Kernel doc of of_overlay_fdt_apply() says:
>
>  * On error return, the changeset may be partially applied.  This is espe=
cially
>  * likely if an OF_OVERLAY_POST_APPLY notifier returns an error.  In this=
 case
>  * the caller should call of_overlay_remove() with the value in *@ret_ovc=
s_id.
>
> Need a bailout?

Indeed! I mistakenly removed it in v2, re-adding it in v3.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
