Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08BA606A323
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 17:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=srazc7DB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01654112C46;
	Fri, 27 Nov 2026 17:06:01 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18851112C46
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 17:05:54 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id AC388C2AC4C;
 Fri, 27 Nov 2026 17:06:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B647D6049C;
 Fri, 27 Nov 2026 17:05:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BE5AD11E90D96; Fri, 27 Nov 2026 18:05:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795799147; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=epMG1oEJxcH1Mz0PZ5IoUhFZrQxUMuiU/tJZjWFh0u4=;
 b=srazc7DBq+otogBqeRV2y6653RuMxbb9ubD4FxMA+QGTENZLTZ5v0QZeaSpaa69NZodljs
 3ZGDU86Vg3KoSyAhh8ms5OMM1iU4fADwX859ddG5BLg4TGWJhkWbr1j6VoVaUUyRinj+EJ
 cm5lRiRFqis1QkgaMf4HGoEVOKWgIRDLCfZFr/QffKrooUYMvN7wJBwjz4DZDaOjCAG++D
 rMomtzBXfoAzRCbGzFkxnh9sJPcaUcR/gKsZFdNZ0xAgdwMXUoy3VPOLIaUkIgh4r7uToU
 V+O7Dk9CkhAt9VS44Qihl9v9gX1xrrrwoort34F3iiBiG1qkxpHTYkHjaZEyRw==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Nov 2026 18:05:27 +0100
Message-Id: <DN65NU9ZTJQH.1GRA0TZTLGY0I@bootlin.com>
Subject: Re: [PATCH v3 0/4] drm/komeda: Use the bridge connector
Cc: "Ayan Halder" <Ayan.Halder@arm.com>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Kory Maincent"
 <kory.maincent@bootlin.com>, "Luca Ceresoli" <luca.ceresoli@bootlin.com>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <linux-kernel@vger.kernel.org>, <cix-kernel-upstream@cixtech.com>,
 <Wuyi.Shen@cixtech.com>
To: "Luo Liu" <Luo.Liu@cixtech.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Liviu Dudau"
 <liviu.dudau@arm.com>, "Russell King" <linux@armlinux.org.uk>,
 <dri-devel@lists.freedesktop.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20261124094119.3220267-1-Luo.Liu@cixtech.com>
In-Reply-To: <20261124094119.3220267-1-Luo.Liu@cixtech.com>
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Luo,

On Tue Nov 24, 2026 at 10:41 AM CET, Luo Liu wrote:
> The first patch converts komeda to the new DRM bridge model. Bridges
> following that model no longer create a connector themselves, so the
> display driver attaches them with DRM_BRIDGE_ATTACH_NO_CONNECTOR and
> creates one connector for the whole chain with
> drm_bridge_connector_init().
>
> The second patch fixes the teardown path that the conversion exposes.
> drm_bridge_connector_init() creates the connector with
> drmm_connector_init(), which provides no ->destroy hook and leaves the
> cleanup to a managed action. The drm_mode_config_cleanup() call in
> komeda_kms_detach(), and in the komeda_kms_attach() error paths, drops
> the connector references directly, so drm_connector_free() ends up
> calling the NULL ->destroy pointer.
>
> Switching to drmm_mode_config_init() lets the core release the mode
> configuration after the connector cleanup actions have run. The komeda
> private objects are then finalized by walking the pipelines instead of
> mode_config.privobj_list, which also holds the bridges that the encoder
> cleanup releases.
>
> The third patch fixes a latent interrupt race found in review. The IRQ
> is still registered after komeda_kms_detach(), and the
> komeda_kms_attach() error path, clear drm->dev_private, so a shared
> interrupt can reach komeda_kms_irq_handler() and dereference a NULL
> mdev. It is independent of the conversion.
>
> The fourth patch fixes the tda998x bridge, which accepts the
> connector-less attach flag but keeps using its own connector. In that
> mode the connector is never initialised, so the bridge reads an empty
> display_info and ELD and stays in DVI mode without sending hotplug
> events. Use the connector provided to the detect and EDID read
> operations, report hotplug through drm_bridge_hpd_notify() and
> advertise interlaced mode support through the bridge.
>
> Changes in v3:
> - Add a fix for the tda998x bridge, which accepts
>   DRM_BRIDGE_ATTACH_NO_CONNECTOR but keeps using its own connector.

There are two v3 series you've sent the same day. Which is the right one to
review?

Please reply to one of them saying "ignore this series, it was sent by
mistake" or similar.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
