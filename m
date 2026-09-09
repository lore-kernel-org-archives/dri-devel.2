Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7DAC79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 15:18:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69B4410E1BD;
	Wed,  9 Sep 2026 15:18:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="q1l8UyG/";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0296510E1BD
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 15:18:14 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 0BE921A1A65;
 Wed,  9 Sep 2026 15:18:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C7BCF60448;
 Wed,  9 Sep 2026 15:18:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E950E11C7AF57; 
 Wed,  9 Sep 2026 17:18:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788967091; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=1PCBbAvhCAgCgY+6h0CZ532jsXluV759Iw7EiPk//jc=;
 b=q1l8UyG/4i2A1VqF6jsr24XAGtNTldS2doiPZJVGJC7X/2lsIWTMx1PNu0Ph79uYVyjrl6
 jZDIaZNBtMLurEdYZ278cgt8aHoCU63TtuUD1UWG7OxbOknWxfmw56NheSp2q77PzMzXNB
 +pbU1F+2Rg3J5HTQ/NJvmwE/VWZWAQxH2YgRnAhgOO1e5KrZcR74g8VAVGD4r3gaGuXMuq
 i9f4ye9wZXvwx3FTOXo4+jMyvW90gmfj68KbMCyaYP8+4TmusKmCF2Sjik+y5r96Ka5M/Z
 E3oyzPWc+CCtDmWDi165mXyKnX2h61p3P+xK19+XyUi2U1MzWUheT5VYpjEd9g==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Linus Walleij <linusw@kernel.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, Marek Vasut <marex@denx.de>, 
 Dmitry Baryshkov <lumag@kernel.org>, Esben Haabendal <esben@geanix.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260831-ti-sn65dsi83-fixes-v5-0-e712765d6c4f@geanix.com>
References: <20260831-ti-sn65dsi83-fixes-v5-0-e712765d6c4f@geanix.com>
Subject: Re: (subset) [PATCH v5 0/2] drm/bridge: ti-sn65dsi83: Various
 fixes
Message-Id: <178896708574.1558311.11016151891645500704.b4-ty@b4>
Date: Wed, 09 Sep 2026 17:18:05 +0200
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


On Mon, 31 Aug 2026 14:21:31 +0200, Esben Haabendal wrote:
> This small series adds support for using SN65DSI84 in single-link mode with
> output to LVDS channel B, and provides a fix for an error-handling
> regression in sn65dsi83_reset_pipe()/sn65dsi83_reset_work().

Applied, thanks!

[1/2] drm/bridge: ti-sn65dsi83: Fix error handling in sn65dsi83_reset_work()
      commit: 4600b4d1a9ee730d03ddac5ce409cd2730ce8c0c

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


