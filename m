Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F69FCD4F52
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 08:32:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC5A410EB54;
	Tue, 19 May 2026 08:32:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="pccyd7ig";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25B9B10EB54
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 08:32:53 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id DA0F71A3621;
 Tue, 19 May 2026 08:32:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id AA6E5606E9;
 Tue, 19 May 2026 08:32:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5E83A11AF8B81; 
 Tue, 19 May 2026 10:32:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779179570; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=VlqOUs/HlxKHLGHUE043tCFwBQNWXwKu63vYHdIURK8=;
 b=pccyd7igbtHf6/xloNwwoUnJHRjSHf7XHOburEAzTu/CG4FaFGuZ7RhzXaNC6tSn+tO9YO
 rah5eg1k9zTVvxmv5+71dTeR0ky4PY4VZuIe4VfEX3gunRiKpkY9MLj9Vf0cEg5m4E0DTe
 2CNL89hvU+mz6m08r/oUgE3jHlVU8qjzxHeFf0R05H/uRb9nsK/exUl8AkI7AFHVvmXtNt
 FCbOdHS+VEh3NvEkGGeHNFeBRCUCc/Bg/A1prjtU4aTvV/fkchLe7msklZx+NGLjMv/ucD
 at4uzn9D5D7veKTVDm2KGOgzOpc9tS545rcLTKKS5xc7D/2NeIwn2YUgcqnECw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Marek Vasut <marex@denx.de>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20260430194944.78119-1-osama.abdelkader@gmail.com>
References: <20260430194944.78119-1-osama.abdelkader@gmail.com>
Subject: Re: (subset) [PATCH v4 1/2] drm/bridge: chipone-icn6211: use
 devm_drm_bridge_add in i2c probe
Message-Id: <177917956604.84587.1196053606706642578.b4-ty@b4>
Date: Tue, 19 May 2026 10:32:46 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
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


On Thu, 30 Apr 2026 21:49:42 +0200, Osama Abdelkader wrote:
> Use devm_drm_bridge_add() so the bridge is released if probe
> fails after registration, and drop drm_bridge_remove() in chipone_i2c_probe.

Applied, thanks!

[1/2] drm/bridge: chipone-icn6211: use devm_drm_bridge_add in i2c probe
      commit: 73d01051e8040c0b1de7fd26b3b8d0c2ffa6895c

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


