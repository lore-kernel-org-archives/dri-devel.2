Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A4B606A323
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 16:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=SAq8W9JE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4FDA10E181;
	Tue, 20 Oct 2026 16:52:36 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6489D10E274
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 16:52:30 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 2EA404E41294;
 Tue, 20 Oct 2026 16:52:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 023E460393;
 Tue, 20 Oct 2026 16:52:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CE0F910328C52; 
 Tue, 20 Oct 2026 18:52:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1792515143; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=v7xkHl3uAJvD4/78sgLN77kYpieA8BRah0ZBUP6Shl0=;
 b=SAq8W9JEdMZVH+u7Z0hsckBD2XtVfIZAtGxGb7CU6htgMi2KduNM9WCDCoW4pMKR3Qwd/I
 fghA5CB7bb22DmIat5VmrCiz2NQemh05J5q9zoB7DwOFEG9EFuS6mwOz5NfqgBgKdm8qKF
 q7ZRaLyxJkWk8fVoK/rgvFCcnCOFEajig2aFliuJFX7vsA5/0nis1oRJWnGpe0lz3sskPX
 yK8Lv3Cqp+dnzk6L79DDkzityxIqjxDWaXG+HqCX+yAe6Lf0SwADHTgPhpgvLgG/EeibHR
 SK+2K3YX+SNS3t57WWKlr/gSP+CiEF2uT+5w3/aFsDpeJWon5/w4eripxL7ibA==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v8 04/14] drm/bridge: it6505: unregister DP AUX adapter
 on bridge detach
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Hermes Wu <hermes.wu@ite.com.tw>, Allen Chen <allen.chen@ite.com.tw>, 
 Pin-yen Lin <treapking@chromium.org>, Chen-Yu Tsai <wenst@chromium.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <ae0941be8fb5e20a309f2e30b5e2d8818168aa38.1790552614.git.daniel@makrotopia.org>
References: <cover.1790552614.git.daniel@makrotopia.org>
 <ae0941be8fb5e20a309f2e30b5e2d8818168aa38.1790552614.git.daniel@makrotopia.org>
Date: Tue, 20 Oct 2026 18:51:39 +0200
Message-Id: <179251509976.78870.2847307917157375162.b4-review@b4>
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

Hello Daniel,

> The DP AUX adapter is registered in .attach() but only unregistered
> in i2c remove(). Unbinding and rebinding the DRM device while the
> i2c driver stays bound registers the adapter a second time, which
> fails. Also unregister it in .detach() and on the .attach() error
> path, which so far leaked the registration. remove() keeps its call,
> which waits for in-flight AUX device users before devres frees the
> regmap; drm_dp_aux_unregister() does nothing for an adapter that is
> already unregistered.

The drm_dp_aux_unregister() docs don't say it is idempotent, so is it fair
to assume it is and always will?

I think it would be much cleaner if user drivers took case of calling it at
the appropriate times, not more.

A flag similar to it6505->extcon_state used in patch 3 could allow that?

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

