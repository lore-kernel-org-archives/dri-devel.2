Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAE2CC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 06:52:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80F5F1125D5;
	Fri, 16 Oct 2026 06:52:34 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89EF41125E6
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 06:52:28 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 35FFDC6220F;
 Fri, 16 Oct 2026 06:53:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6FC8E6075D;
 Fri, 16 Oct 2026 06:52:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A223710328C6D; 
 Fri, 16 Oct 2026 08:52:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1792133545; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=WlHkJSy/ba8HvsmnfL4B23mq4zTFKgnNgEDVV0rE7SQ=;
 b=MmHOg1dxGfArn2jR4L+4z8N69tqpP0MmBy4sJp2si7LmksA8mvQGFkkq7FnBXFMzwVNRfY
 61RAPOkOfKFPSN8kXzWbAFLaK8DSItnbpMvT2nYKPNBaA9In3XZ1MJa1xiTGKZOwsmnpTo
 RwG5fjDdQ41hdpSJ26d7UxkYhqpeCT0+6r9bq0WNajqFtq3xZuQ2t+D0Jy3TLIOvNztrqk
 WOOLef/mwNkpOT0OIT/iQCYdxkWGEhAZivYtWilhTFOxrBXbvAhyFzeBiZ7KpeBQLppTrc
 vX0CU1whmU+hccR/PLhek5yNVtm0R4FAC9chMmopkn24+iGIXocbkvMbH/BuZQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261001-bridge-alloc-conv-v1-0-f0a1fe040a86@collabora.com>
References: <20261001-bridge-alloc-conv-v1-0-f0a1fe040a86@collabora.com>
Subject: Re: [PATCH 0/2] drm: devm_drm_bridge_alloc() conversion and
 cleanup
Message-Id: <179213353665.3058528.14437637653539699061.b4-ty@b4>
Date: Fri, 16 Oct 2026 08:52:16 +0200
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


On Thu, 01 Oct 2026 11:25:10 +0300, Cristian Ciocaltea wrote:
> Bridge drivers are expected to allocate their private data via
> devm_drm_bridge_alloc(), which also initializes the embedded struct
> drm_bridge, including its funcs pointer.  Most drivers were converted by
> commit 9c399719cfb9 ("drm: convert many bridge drivers from
> devm_kzalloc() to devm_drm_bridge_alloc() API"), but a couple of
> leftovers remain.
> 
> [...]

Applied, thanks!

[1/2] drm/rockchip: rk3066_hdmi: Convert to devm_drm_bridge_alloc() API
      commit: 5c0cdbee4fa4a621f871d6dc825e759db08a1a4a
[2/2] drm/bridge: lontium-lt8713sx: Drop redundant bridge funcs assignment
      commit: 382c1e8ba409d1611cd256dccebdfa828c832bb1

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


