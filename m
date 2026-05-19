Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C93CD4F57
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 08:55:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0DCB10E39B;
	Tue, 19 May 2026 08:55:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="e/9BRLYo";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 286D110E39B
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 08:55:23 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 9FECA4E42CF0;
 Tue, 19 May 2026 08:55:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 66119606E9;
 Tue, 19 May 2026 08:55:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0AD6B11AF8B8F; 
 Tue, 19 May 2026 10:55:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779180920; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=XXqocNQlMTY8aRunaEJUBXO8xIg0vOs7JDa287pGveE=;
 b=e/9BRLYoYMCFKJvDfiotI+g3jFSa/st4jOph+GdrryiYfogmJzsSk97q/Y2p0B1Q/3s20q
 /68UrIZX5aqAbIewOuaD/8mh6i7LBS8m9+7PYR9K6pBs+Q4SPJn7jCouZnrjTPrC6/9nh9
 ijFvJ4Q+uY7o/UH9VKtwITvQ5ZfBvgj5+J4J/cMvv2C9PiYUgBa9itCAKYQluGYmjCkjVF
 OA4LF/6IxxwsbCtJGpuoXdddkXHcLB9/J+yBVzN/6Y6R7ohTIDh/ARw54K1YOC5PqcBgDy
 Gs+j3NzVj+ofdJLUaGypzFQgrU3IgRlaNoRQweMbTSiSrmYmOslBs2fyTnmNxA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Peter Senna Tschudin <peter.senna@gmail.com>, Ian Ray <ian.ray@ge.com>, 
 Martyn Welch <martyn.welch@collabora.co.uk>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Archit Taneja <architt@codeaurora.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20260430195700.80317-1-osama.abdelkader@gmail.com>
References: <20260430195700.80317-1-osama.abdelkader@gmail.com>
Subject: Re: [PATCH v4 3/3] drm/bridge: megachips: remove bridge when irq
 request fails
Message-Id: <177918091379.250715.361254713159943739.b4-ty@b4>
Date: Tue, 19 May 2026 10:55:13 +0200
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


On Thu, 30 Apr 2026 21:56:59 +0200, Osama Abdelkader wrote:
> If devm_request_threaded_irq() fails after drm_bridge_add(), remove the
> bridge before returning.
> 
> Keep drm_bridge_add() rather than devm_drm_bridge_add(): registration is
> tied to the STDP4028 device while ge_b850v3_register() may complete from
> either I2C probe; devm would not unwind the bridge if the other client's
> probe fails.
> 
> [...]

Applied, thanks!

[3/3] drm/bridge: megachips: remove bridge when irq request fails
      commit: d45d5c819f2cd0b6b5d76a194a537a5f4aeefecb

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


