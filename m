Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C93C5AD5A
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 20:01:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 902CF10E5AB;
	Sun,  9 Aug 2026 20:01:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="S7mqP3b6";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LBFCIaGQ";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C06B710E5AB
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 20:01:30 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hJ80T18K7zKncP;
 Sun, 09 Aug 2026 22:01:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1786305689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XVP4E3N5OOYT+HqQ/+FFQYq0rub4J6LXRpa+4ZAiLSE=;
 b=S7mqP3b6mXnbCHN4yv3cTeclN9cbzjioy3V5TPTgT7bGWiPj8SnRlJc7ln3FG4+vcQ66gE
 kEvUe2184uCHrxiI+CeMfHfj14eenWD/8FWVVEi6uCFEUvpjkvnfv2nfOGzEIh+pRklRdc
 ApU8a5EovVfKgovuuDXw377Zdjdzqn8iuhXx6CD2fhY1edP6RXmHXxjMikVd9bWn9Ff2vz
 fofbYiojLKqPp5SAemzVAIzduMc2OXu9sacRrV9OWWLd3577RPApHEHlrkOwl0Vlp6K/84
 H3BMPQAtjG6YZQz5m+DN4GDJEID68xga7v83pV+PU/msCkLlxrRG5qWUGGLAKg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=LBFCIaGQ;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1786305687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XVP4E3N5OOYT+HqQ/+FFQYq0rub4J6LXRpa+4ZAiLSE=;
 b=LBFCIaGQ7jYSVY71W/HVWdSrxK9bmPk+N9CSSryB4V6+rangU6YWNZDmZAFvIxc82q0oT0
 5+ZIPPwS/j1/x9miZoFWddMBQBFAoRjWGdPDQemw4ShwOs2SPzR+g1NR2i1RTQ1N0+qClL
 ZT4BsC2+FUeG+dz5HA9pyM3Qg47k5Mvp+0EaNAKqqRB1MKmHlFrS2lf3Tq0myStcHgWUbT
 3jt7qxjvSCGhah08mvMkl1frf+rVlsslVMAtEM2oE0eby3OvaRkgSQbs7asvsRtKALNkg5
 Kc4tF+TwjU23FrkTMymrgGzuFp4AE4z1mEIJ8geah8wU2sOPSBxncMhx5D/+dQ==
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 David Airlie <airlied@gmail.com>, Jessica Zhang <jesszhan0024@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org
Subject: [PATCH 2/4] drm/panel: ilitek-ili9882t: Make enable GPIO optional
Date: Sun,  9 Aug 2026 21:58:51 +0200
Message-ID: <20260809200107.842945-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260809200107.842945-1-marek.vasut+renesas@mailbox.org>
References: <20260809200107.842945-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: r4niqxu4in13ypauckkbmqpiuapagc7c
X-MBO-RS-ID: 23bb4397981dbe2c482
X-Rspamd-Queue-Id: 4hJ80T18K7zKncP
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

The enable GPIO may not be accessible on the panel, make it optional.
This is the case on 10" Raspberry Pi Touch Display 2.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Jessica Zhang <jesszhan0024@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: devicetree@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/gpu/drm/panel/panel-ilitek-ili9882t.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
index 6d07fe901357e..219d048cb883f 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
@@ -787,7 +787,7 @@ static int ili9882t_add(struct ili9882t *ili)
 	if (IS_ERR(ili->pp1800))
 		return PTR_ERR(ili->pp1800);
 
-	ili->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
+	ili->enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
 	if (IS_ERR(ili->enable_gpio)) {
 		dev_err(dev, "cannot get enable-gpios %ld\n",
 			PTR_ERR(ili->enable_gpio));
-- 
2.53.0

