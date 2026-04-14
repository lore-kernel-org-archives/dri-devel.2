Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52046F9D0EC
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 18:05:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A800810E011;
	Tue, 14 Apr 2026 18:05:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UWaa0U2N";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBE6110E011
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 18:05:23 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so56326645e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 11:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776189922; x=1776794722; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fXXwUnGdo3Yx9sP3zR3t7iA+9QFee9LB/bN9Dc41ll8=;
 b=UWaa0U2NIGKOf+vE8ya8aoTp3cwOQHQShYT0NS2ZCe1lEaTWS5sRvlmRUoXO+xwjte
 rYQ0SiFLvsE9gy6Vl670MnTBAiIDfTlpIpUiPnVLxYduTV2fGv0nD+7vQY5zkHDj+D9S
 vFrJPEILfJDTTndGBmXwy8qwDG5V84l7YEfOrbqS4vPR6J2GLD4O82OFdcUDwy3NIbV1
 CwfGKhn4DH3YnY2U89rT6BPy7SddDmC2/yc9YyG0di77RQBVUNAfmeBKdrQMDRdtdIOm
 l4kDpTindwb11tmFxaZju8TfcdXLs5sEiNrLQxoaqmU6aNgrfmscss3Y0w/oBYcHExoP
 j6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776189922; x=1776794722;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fXXwUnGdo3Yx9sP3zR3t7iA+9QFee9LB/bN9Dc41ll8=;
 b=KnDwPwW7Vvuo8tIDy/3yiLdg0R6vVgErIfUxyNzK7WkVdrUXGvUJr7Cm7MTHOju6Ri
 iAYPnWywP1BoP1DyOdnlRvUEDT9n49dcCW08A+b+KzqNZWFxyV4kZjReZYenSlVFJWYX
 WO4heF5YJ3gf/Alq/bpgERTSVV9mwvnHUClxYIdGwopiJwSq/fDYadfCtmlZcEgb4Apm
 YZS2K1IG0q6uZSvf0C8o6JutwpbduISqmA1IBMEnGnv4CrckM4NwJGJAGdJh64ZUYWR1
 rRje4vQi2epyrgM7gt6tJNRhtURsnja5mxU2Mcc+Y40+P/Rqy2kh7TppooKJKBn9Ucz/
 RiUQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9WxyNhgN8pgGBqwdHiC+UPAfhZkAOiRdMv/Lc3qiiLOG1T+NK/3gNGFI0iHErEOAPyWEtc9xx94xs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzNIx3zOvmneioWtXx656LL0lGPasrC/GnL9p3RMMGwSDpx0DlR
 6sJmCU8kFwN3ed8dQfDP9Ijw493M0S+HbOr2kt4BW4D9R5NI6MDsH9zu
X-Gm-Gg: AeBDiet9qxtAX7sBoZDisoIl0LKQ0fdSn5Wp9XdUynKpD0fo8e3lt6WFXpdB6UU2VQW
 1OecdSJxcrr/bHX3OBuYtAOft9S9Q7onSCkX7/e5w7+IhTytTodp+MM1/+UJ3JGNa5WwXboG5Ds
 leG923RlJgKtLw4ARtYWUlhG5A/AloBT8wv0b/Tj+a+RJV0whqUwYgrwxuxJUvkW4lyefGEnYae
 CYVLcgP8DD6nP/dlVg1SYn4Rrorax7Yrjhlat8P3OEVQfkDZMA70naFqG5+s6AZ5aJWJzv0S4/N
 ZtaOBnkcry5g/EI9XdiF1g4WBgOfp0rbbaq6LNeZIhC6RW2VrBg29mAuDAYLj8+XHgDCoKCDEyO
 UQFbD/AHsJV0CraNYRlHmYPP/bzojr7kgbsPqAT+OI+Ky2SsyOePxIX2HCgcXts6hwEJGztLGdO
 rUZX+SMs2L6dIXE0F4tMB2o7hs7Pmhpe0tBlC79B05E3pC15QKWfP/e5i6qhFL
X-Received: by 2002:a05:600c:8b38:b0:488:be58:bb77 with SMTP id
 5b1f17b1804b1-488d6890ee3mr231361435e9.30.1776189922119; 
 Tue, 14 Apr 2026 11:05:22 -0700 (PDT)
Received: from osama.. ([2a02:908:1b6:8980:cb49:f403:bb20:cc84])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d6ffd3880sm28095884f8f.7.2026.04.14.11.05.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 11:05:21 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: luca.ceresoli@bootlin.com, Jagan Teki <jagan@amarulasolutions.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH v2] drm/bridge: chipone-icn6211: use devm_drm_bridge_add
Date: Tue, 14 Apr 2026 20:05:17 +0200
Message-ID: <20260414180518.160801-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Use devm_drm_bridge_add() so the bridge is released if probe fails after
registration, and drop drm_bridge_remove() from DSI remove.

v2: devm_drm_bridge_add instead of drm_bridge_add + manual remove paths

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/bridge/chipone-icn6211.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/bridge/chipone-icn6211.c
index 5bee10c64265..4bc98c45f65f 100644
--- a/drivers/gpu/drm/bridge/chipone-icn6211.c
+++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
@@ -5,6 +5,7 @@
  */
 
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_bridge.h>
 #include <drm/drm_of.h>
 #include <drm/drm_print.h>
 #include <drm/drm_mipi_dsi.h>
@@ -730,12 +731,11 @@ static int chipone_dsi_probe(struct mipi_dsi_device *dsi)
 
 	mipi_dsi_set_drvdata(dsi, icn);
 
-	drm_bridge_add(&icn->bridge);
-
-	ret = chipone_dsi_attach(icn);
+	ret = devm_drm_bridge_add(dev, &icn->bridge);
 	if (ret)
-		drm_bridge_remove(&icn->bridge);
+		return ret;
 
+	ret = chipone_dsi_attach(icn);
 	return ret;
 }
 
@@ -758,20 +758,17 @@ static int chipone_i2c_probe(struct i2c_client *client)
 	dev_set_drvdata(dev, icn);
 	i2c_set_clientdata(client, icn);
 
-	drm_bridge_add(&icn->bridge);
+	ret = devm_drm_bridge_add(dev, &icn->bridge);
+	if (ret)
+		return ret;
 
 	ret = chipone_dsi_host_attach(icn);
-	if (ret)
-		drm_bridge_remove(&icn->bridge);
 	return ret;
 }
 
 static void chipone_dsi_remove(struct mipi_dsi_device *dsi)
 {
-	struct chipone *icn = mipi_dsi_get_drvdata(dsi);
-
 	mipi_dsi_detach(dsi);
-	drm_bridge_remove(&icn->bridge);
 }
 
 static const struct of_device_id chipone_of_match[] = {
-- 
2.43.0

