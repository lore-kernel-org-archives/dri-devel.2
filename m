Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF78CD342C
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 10:42:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB87E10E3D6;
	Mon,  4 May 2026 10:41:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Rj4twQRh";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64DE010E3D6
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 10:41:58 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 24D094E42BBC;
 Mon,  4 May 2026 10:41:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E70CA5FD5F;
 Mon,  4 May 2026 10:41:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A3B6111AD2606; 
 Mon,  4 May 2026 12:41:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777891316; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=2b4xIfU6RSAbgUS8o0/TbhikoBinIeCxRWGG69VRvVk=;
 b=Rj4twQRh2aEGDvkdmDmysuv/+N4cK5wQwz6NcMSZehRQI5TaD4zWfOHecGshRtdYKUDOxs
 5Recsqj2RKgYcYGIhTpSwiYDkb2T9tBXCCkQFwu8ewWOBYWNhtI0QJQU5s2IpP/5qbB6vm
 CrfwZu+n5Cm7uwG5gde0bs9gRCscSeqSCSz4fH9nSshEia83wO+K/YyX616JRHtLasjNKG
 NJuZe3ihIdd2n2O1bYsrr3vT8QZQ/06nrt2zfRV6NGKRmq8HLCIUEWC9N69I4cjvk+2cxy
 gygciSkfT7J1Wl7nunyEow7jQ8hYHkepQ6FJE3ik/xAqKrtVGzWpFn8j2zPbQg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Max Krummenacher <max.krummenacher@toradex.com>, max.oss.09@gmail.com
Cc: Adrien Grassein <adrien.grassein@gmail.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, David Airlie <airlied@gmail.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250728150059.2642055-1-max.oss.09@gmail.com>
References: <20250728150059.2642055-1-max.oss.09@gmail.com>
Subject: Re: [PATCH] drm/bridge: lontium-lt8912b: Do not generate HFP
Message-Id: <177789131143.337587.6135540351214362378.b4-ty@b4>
Date: Mon, 04 May 2026 12:41:51 +0200
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


On Mon, 28 Jul 2025 17:00:50 +0200, max.oss.09@gmail.com wrote:
> The datasheet of lontium-lt8912b doesn't require blanking during
> the HFP period. Thus use LP during HFP.
> 
> Tested with a samsung-dsim (i.MX8 MM) and a tc358768 DPI to DSI bridge
> as the DSI host.
> 
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: lontium-lt8912b: Do not generate HFP
      commit: 9a56caf49525e8a0ee349fb69db101d018a95a66

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>

