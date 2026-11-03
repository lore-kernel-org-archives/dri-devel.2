Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFE0606D82E
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=mpQ/H7qb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BC9F10E7D6;
	Tue,  3 Nov 2026 11:22:45 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEFEC10E7D6
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 11:22:39 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id A9A674E413E1;
 Tue,  3 Nov 2026 11:22:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 685516046C;
 Tue,  3 Nov 2026 11:22:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B9B9810328267; Tue,  3 Nov 2026 12:22:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793704951; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Im2hD/3RPp585O4FNz8w013aAEGmolE3drO5PuJAwxI=;
 b=mpQ/H7qbmCeJCsVUAv6mUbCuYfblkczMBNsSOQkUfNvgj759C8FjqB4FV+lT4PATF1vIUq
 4gSGLJ7S4Z1H1wvRqHsb06gyBkHzGz7wj+bDgDmcQRQxL2sGXlkc1MQzoRlJzc0Vm+a+jF
 rjEQ0zpOfvj8qLHi8CkxQ4RXb1VnIxD0LlikBV+nmA0Ljnt5KAiJTjxCTOrnigwxkYdp5W
 2MYcQ6l4aAQpcWbPswrjdU1w2f+KW7/ZSvWbRyetHOSdeqBPXSuqMwTMfXn9JVL0sC27ow
 OUPAfqhTxi4k2zVBP86GI1wEXclSlyrSARiuc9aZ9sjKDntfL09dICGY9ZwscA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Fabio Estevam <festevam@gmail.com>, Robert Chiras <robert.chiras@nxp.com>, 
 Sam Ravnborg <sam@ravnborg.org>, imx@lists.linux.dev, 
 Esben Haabendal <esben@geanix.com>
Cc: Frank.Li@kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, 
 "Oliver F. Brown" <oliver.brown@oss.nxp.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Liu Ying <victor.liu@nxp.com>
In-Reply-To: <20261027-nwl-dsi-fixes-v5-0-b6d1d3d2d356@geanix.com>
References: <20261027-nwl-dsi-fixes-v5-0-b6d1d3d2d356@geanix.com>
Subject: Re: (subset) [PATCH v5 0/4] drm/bridge: nwl-dsi: Various fixes
Message-Id: <179370494317.651381.10938572686386767972.b4-ty@b4>
Date: Tue, 03 Nov 2026 12:22:23 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Tue, 27 Oct 2026 11:33:48 +0100, Esben Haabendal wrote:
> This series brings a few patches fixing horizontal sync timing, EOTP packet
> behavior and hsync/vsync polarity selection when using DCSS endpoint, as
> well as a small fix to properly handle if/when nwl_dsi_mode_set() fails.
> 
> The 3rd commit ("Correct auto-insert EOTP behavior") is taken directly from
> NXP vendor tree, so I have kept Author unchanged, although I have modified
> the commit message. Let me know if I should change Author for that.
> 
> [...]

Applied, thanks!

[1/4] drm/bridge: nwl-dsi: Cleanup endpoint mux control selection
      commit: 8dad0ebd822f54102aadc6ca4f0f8777112d175d
[2/4] drm/bridge: nwl-dsi: Limit LCDIF specific sync override
      commit: 54a88d9afcca66221d14f438d0960472984968ec

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


