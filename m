Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1087C5AD5A
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 20:01:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F16F610E5AF;
	Sun,  9 Aug 2026 20:01:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="D3x2+ciV";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="La4lTdeO";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC73710E5AF
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 20:01:34 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hJ80Y3GbJzKmyp;
 Sun, 09 Aug 2026 22:01:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1786305693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dhlf3mlfPirGLWKv8khqrATyXrv0u7vMVfkjwdVaUec=;
 b=D3x2+ciVj9DRQmdNDpE5OwHGGUYQc/db7znGlmIce1M+SUTYrUeDjBdrzL8BcpQR+g7QfC
 LXyXBu23ia5Jy6hI3sZPpi2sYWwsWYs82bO1r8AmgI9Fl6U3i9BIcPuzYeIrc8/gTef5H6
 ikEBtLZYt4iDmopkc2tv57TXmnOeR8TI9uNL6fSmgdiq2VUJRtsbcTC1BnJJPwBCQBPlfB
 wL5y1nvpP8WvYIdH79CJLIlHbakCB04yyma5mvEyOXyNdo9F3T7K+jSgVJV0/1jn8S+QUm
 WeeM8kVthyvCpMG4XQz1hfRIaPLtES1eN27iSk/aEECwqghfbLUXVK+uyw0lFg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=La4lTdeO;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1786305691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dhlf3mlfPirGLWKv8khqrATyXrv0u7vMVfkjwdVaUec=;
 b=La4lTdeOsvbNSTcyMFihcExDoayi3o7oQDPw9ysIAVNkhJXpc1IZOgP9CC2LpB8v7mTx2o
 hs3jkAyGt65xZlH2/TVUtQ8tAn69W0UvdXOYxKfe9jz8n4ET4Mo0RrwitUJLnfZibQSdXp
 E450/EBXGthlmCWGYKjMU6/BPLiSUIaLopuxsr78zLKSEtE09Zw5XjLmvSNFKgYWGiheey
 VXDBCJonC7tjFfZfaWEtYLm0aow6kmOBOlrmyIOswSqi3WF6r8oy8JW2I/OMUxpjUgbTqG
 Ea1Ld0X0MzjeIKbXxILrOfqL4fYN4emYldQ6NwPsiDIh8dnHqQiYEoTWPDMJ3w==
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
Subject: [PATCH 3/4] drm/panel: ilitek-ili9882t: Set prepare_prev_first
Date: Sun,  9 Aug 2026 21:58:52 +0200
Message-ID: <20260809200107.842945-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260809200107.842945-1-marek.vasut+renesas@mailbox.org>
References: <20260809200107.842945-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: kug9u6g4rwdra5dpnq6fjomgjd4ap44a
X-MBO-RS-ID: 6a86ff7b6e4387b22aa
X-Rspamd-Queue-Id: 4hJ80Y3GbJzKmyp
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

Sending DSI commands from the prepare() callback requires DSI link to be
up at that point. For DSI hosts is guaranteed only if the panel driver
sets the .prepare_prev_first flag. Set it to let these panels work with
the DSI hosts which don't power on the link in their .mode_set callback.

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
 drivers/gpu/drm/panel/panel-ilitek-ili9882t.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
index 219d048cb883f..24e72ad0d29a1 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
@@ -808,6 +808,7 @@ static int ili9882t_add(struct ili9882t *ili)
 
 	ili->base.funcs = &ili9882t_funcs;
 	ili->base.dev = &ili->dsi->dev;
+	ili->base.prepare_prev_first = true;
 
 	drm_panel_add(&ili->base);
 
-- 
2.53.0

