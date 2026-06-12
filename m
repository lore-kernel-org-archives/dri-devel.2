Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45DD8CD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 13:12:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F1CF10F530;
	Fri, 12 Jun 2026 13:12:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="PbGQSTw+";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B42C10F530
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 13:12:24 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id E918C4E42E5A;
 Fri, 12 Jun 2026 13:12:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B323F60012;
 Fri, 12 Jun 2026 13:12:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E79E3106C869D; 
 Fri, 12 Jun 2026 15:12:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1781269940; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Ugqk3paBNtkUpmNS8tCEk8xcfM99gRQHykB1GGB9Lao=;
 b=PbGQSTw+ZvVX1pFyLyVPEK3/vY1XM2NFXQyVjT3m3DmbXPwBOM0500DUhvgto0fxv7s51P
 ImghhWxXuM/T8KfimbSYI7lz58OYKRaaN6nF2kjm0sonGdmIRFidiSgJhAWrZeSz1JuRA3
 TILMuJmf3cEkky7ZairznuK2GLJSUQNdQSJUMlK0zFHt3nQNA2w4emEj1HHjYgrncwlM9h
 E61Qh3gdfPvoxd+5ENAVWTzko/DLed7oUf6W4s+rsbuz2V7Fm6coWhVynzuqe8trFTYH9C
 NyWLBB1HTqHWZoiMy16JIecyPXfvFWG8Pc8Ps2fkFkjlHFGweWzzto7L2oSpUQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Jun 2026 15:12:09 +0200
Message-Id: <DJ73HOYATZN9.1FQ8X1O2QHKEW@bootlin.com>
Subject: Re: [PATCH 04/37] drm/display: bridge-connector: store the
 drm_device pointer
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Inki Dae"
 <inki.dae@samsung.com>, "Jagan Teki" <jagan@amarulasolutions.com>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>, "Marek Vasut" <marex@denx.de>,
 "Stefan Agner" <stefan@agner.ch>, "Frank Li" <Frank.Li@nxp.com>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, "Pengutronix Kernel Team"
 <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>, "Hui Pu"
 <Hui.Pu@gehealthcare.com>, "Ian Ray" <ian.ray@gehealthcare.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>
To: "Maxime Ripard" <mripard@kernel.org>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.21.0
References: <20260519-drm-bridge-hotplug-v1-0-45e2bdb3dfb4@bootlin.com>
 <20260519-drm-bridge-hotplug-v1-4-45e2bdb3dfb4@bootlin.com>
 <20260608-imposing-umber-tuatara-62daba@houat>
In-Reply-To: <20260608-imposing-umber-tuatara-62daba@houat>
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

On Mon Jun 8, 2026 at 1:34 PM CEST, Maxime Ripard wrote:
> Hi,
>
> On Tue, May 19, 2026 at 12:37:21PM +0200, Luca Ceresoli wrote:
>> Currently the struct drm_device pointer is only needed during the initia=
l
>> drm_bridge_connector_init() and in drm_bridge_connector_handle_hpd() whi=
ch
>> gets it from the struct drm_connector.
>>
>> This will be insufficient when introducing bridge hotplugging, because:
>>
>>  * some of the actions in drm_bridge_connector_init() will have to be
>>    performed later on, when a bridge is hot(un)plugged
>>  * the connector will be removed and re-added based on hotplug events,
>>    so the drm_connector might just not exist or its content be cleared
>>
>> Store the drm_device pointer in struct drm_bridge_connector for any late=
r
>> needs. Also convert drm_bridge_connector_handle_hpd() to use the newly
>> stored value.
>>
>> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>
> This is already accessible as drm_connector->dev and drm_bridge->dev. I
> think it would be great to list why this is different, and how it is
> different (ie, when it's set, unset).

With hotplug the drm_connector will be created dynamically, so it cannot be
used.

The drm_bridge->dev maybe.

But we have a pointer to the encoder, which is supposed to be always
present, so I'll try using next for v2.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
