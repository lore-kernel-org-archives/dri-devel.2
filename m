Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FEE3C79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 09:15:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D62CB10F036;
	Wed,  9 Sep 2026 09:15:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="kyvXj7KG";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10E2510F036
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 09:15:38 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 841D91A1A52;
 Wed,  9 Sep 2026 09:15:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 557E060448;
 Wed,  9 Sep 2026 09:15:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 62D6711C7AF75; 
 Wed,  9 Sep 2026 11:15:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788945335; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Be9teADg7Yx/fENXWg5y5jLFgv5ZSSIpuEqGiq03lCw=;
 b=kyvXj7KG8eWIRinyWnysk6EGxzkgWFKQ0d+sTkM2Mm6daaVeadIMazmqvW6LteYPu4zNUw
 S6v32JXbMU0ZLqTMz7V1UFfzC7u9F2SpzNQ9iYnUwKK5dRnhDOcziOxxg2CBhLZ/f8kW/S
 to86epEqkDEgYJKg2fJ+zlG7HMZl9+c4Lm2YTHlqJf6QLgV7xzSakHiIr7pHk6J+jv/YHP
 OYQZPEuZBTNDO/Og/xAU7kHJ2IVw6OJftF3jdWv+JG4qmyv8OgvrNPqrPR55daKQGuEh/Y
 1MSRO5Uc46+poXDvFYIpcUORqASk5eyc5o+pEy4bei2WdxgWa1UEzQ1Uz12YdQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, 
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 Leonardo Costa <leoreis.costa@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 tomi.valkeinen@ideasonboard.com, francesco@dolcini.it, 
 leonardo.costa@toradex.com, stable@vger.kernel.org
In-Reply-To: <20260706132440.1594239-1-leoreis.costa@gmail.com>
References: <20260706132440.1594239-1-leoreis.costa@gmail.com>
Subject: Re: [PATCH RESEND] drm/bridge: tc358768: Enforce input bus flags
 via atomic_check
Message-Id: <178894533018.1178686.9521893040126546313.b4-ty@b4>
Date: Wed, 09 Sep 2026 11:15:30 +0200
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


On Mon, 06 Jul 2026 10:24:17 -0300, Leonardo Costa wrote:
> The tc358768 declares static bridge timings requiring pixel data to be
> sampled on the positive clock edge.
> 
> However, the DRM core default propagation simply copies the output-side
> bus flags, coming from the next bridge, connector or panel, to the
> input side. If the propagated flags are incompatible with the bridge
> ones, the data is wrongly sampled, typically resulting in visual
> artifacts on the panel.
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: tc358768: Enforce input bus flags via atomic_check
      commit: ed761e0693950fcb4f6b0f60387a3961b972adf3

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


