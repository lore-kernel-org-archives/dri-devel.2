Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0FBC624D4
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 16:14:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A5E210E032;
	Wed,  2 Sep 2026 16:14:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="xYZ0O0nn";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9595F10E032
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 16:14:17 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 437861A195F;
 Wed,  2 Sep 2026 16:14:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 14F106053C;
 Wed,  2 Sep 2026 16:14:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8D60F11C79A58; 
 Wed,  2 Sep 2026 18:14:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788365651; h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=A0csWIqGOewpZKchd0iw7mpPiYpYawh6k/Q+FjJLlmc=;
 b=xYZ0O0nnR55u59mUc55xCDmzi0nrO6/HZ7cP7O6W+rmH/QeShjyT9/j/GFGVQcauW1W2Wz
 W6bpBcgzjgiq/AFq9fOiRSwyXExvT8h1LfF77pEOe9Y9+pucpUzeeKFic5pbDn4Dw9nJ4n
 yCnUdF5SkaLtZA3lB1VqA2bWcVGUO58QM6fwILE7Tdh4RkxR1hCefMVbsPFv2XDJDb47pt
 0gqAT9hGglxuXPxr70hl35OpkrjHEn9hu8KZ4ZLpdcqgfbdfsnWPfQI3sw5YsMcEbmq/52
 R4nOC64//tjEyvUMfZbd/C3VKGJaaCY7bUxq+5MCP7CM2/pTeMcLZWiL09wtnA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Artur Weber <aweber.kernel@gmail.com>, David Heidelberg <david@ixit.cz>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Yedaya Katsman <yedaya.ka@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Osama Abdelkader <osama.abdelkader@gmail.com>
In-Reply-To: <20260812144426.62074-1-osama.abdelkader@gmail.com>
References: <20260812144426.62074-1-osama.abdelkader@gmail.com>
Subject: Re: [PATCH v4 2/6] drm/panel: Use managed helpers in Samsung
 panels
Message-Id: <178836564734.768820.7845356788129681721.b4-ty@b4>
Date: Wed, 02 Sep 2026 18:14:07 +0200
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
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>


On Wed, 12 Aug 2026 16:44:21 +0200, Osama Abdelkader wrote:
> Use the managed MIPI DSI attach and panel add helpers in Samsung panel
> drivers and drop the corresponding manual detach and panel remove calls
> from remove paths. Also, switch to devm_backlight_device_register in
> s6e3ha2 and s6e63j0x03.

Applied, thanks!

[2/6] drm/panel: Use managed helpers in Samsung panels
      commit: 180acca3b7f0248634c0a504486e22eb3e12e28a

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


