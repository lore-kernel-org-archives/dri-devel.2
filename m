Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9F2CD98CE
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 12:56:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C0F110EA14;
	Fri, 12 Jun 2026 12:56:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="08oWSqoR";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D4A610EA14
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 12:56:41 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 58A311A38E3;
 Fri, 12 Jun 2026 12:56:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 2103B60012;
 Fri, 12 Jun 2026 12:56:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 08CF4106C8A54; 
 Fri, 12 Jun 2026 14:56:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1781268998; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=QWgaATuoAKFQpxfZIkw0EI47Xu+CY02gQbwSENrgRrc=;
 b=08oWSqoRpdjvs/baLaFBFKfqQKGcttUE+15yalrO+7G0oIcDfFlazuHuTuPalT8w6tUXHl
 H2M3D8KcQljoSCY/vWa/Co/s1CCAeQt8UrpDYp5zeCjSWsjpc6c+DN1zbn6owZT3T9Mj5d
 yolr65EuEGx5SLMIBHHfxQYy2fW10HLDXOx0wHG9be2QkY8S//pZVyBqDxsGWAw4Ul8DN5
 Hwe3IibqJeY8JRcRiVYY0lwW1NDbOnSrdNzsT2Abtl8pWxp6UsCP+hXDf4bMMN/axupjkR
 5dZWc0DJlQJRJvnIYPtGjtugZCd5vYk9wG2+LP4uECWVV5P7q5CjGPcmLINjUQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Jun 2026 14:56:24 +0200
Message-Id: <DJ735MTNMYD1.3LPNV404V8PIU@bootlin.com>
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
Subject: Re: [PATCH 05/37] drm/display: bridge-connector: split code
 creating the connector to a subfunction
X-Mailer: aerc 0.21.0
References: <20260519-drm-bridge-hotplug-v1-0-45e2bdb3dfb4@bootlin.com>
 <20260519-drm-bridge-hotplug-v1-5-45e2bdb3dfb4@bootlin.com>
 <20260608-mindful-heavy-frigatebird-be9faf@houat>
In-Reply-To: <20260608-mindful-heavy-frigatebird-be9faf@houat>
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

On Mon Jun 8, 2026 at 1:40 PM CEST, Maxime Ripard wrote:
> On Tue, May 19, 2026 at 12:37:22PM +0200, Luca Ceresoli wrote:
>> In preparation to introduce bridge hotplug, split out from
>> drm_bridge_connector_init() the code adding the drm_connector into a
>> dedicated function. This will be needed to be able to add (and re-add) t=
he
>> connector from different code paths.
>
> Same story here, explaining what you need later on that calls for that
> change would be nice.

Here's a more verbose version:

    Currently drm_bridge_connector_init() does two things:

     * allocate and initialize the drm_bridge_connector
       (which embeds a drm_connector)
     * initialize and register the embedded drm_connector

    For bridge hotplug we need to separate these two actions:

     * the drm_connector needs to be added and removed at any time based on
       hotplug events
     * the drm_bridge_connector is designated to create and remove the
       drm_connector, so it must be persistent for the card lifetime

    As the lifetimes of drm_bridge_connector and drm_connector become
    different, we need to create them in different moments.

    In preparation to support that, split out from
    drm_bridge_connector_init() the code adding the drm_connector into a
    dedicated function. No functional changes, just moving code around for
    now. A future commit will make the drm_connector be created based on
    hotplug events.

Looks good?

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
