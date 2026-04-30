Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2844CD13DA
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 19:50:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 191DA10F43C;
	Thu, 30 Apr 2026 19:50:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OoroPBpw";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45BA010F43C
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 19:50:28 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so21668565e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 12:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777578627; x=1778183427; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sehIK1ss/UfV25ulny1ykipeeUWFbqMuTXJbr9AoQZc=;
 b=OoroPBpwcnFEBOFoSjJxSfVqW8k46vwGQRzEEATKzPGtfqCCCk9Um2RPw9J0Tid3L2
 7GtTHnG1kYUIO9IuMoF3CRKueX0ykun3R1buRJXuVaxFR0k1uwEHwqIL4mJVxjNge5G0
 QdVQuYy5+6DgZgkA1NWHYgG9COvdjAj/WL+mkVcec5EOtXLUaJrvz4hkBn6Pwb3tmDWZ
 qHlVcjH1/l2709ftqUepGTYkZaf7zyvl5/qnxrDUhEjdpCdYHv9v5tkDXaAS4de6iJNl
 hLT4vpVVrrMnArSAYcg6QJi9NRJvVDHAABSS6rIYVbQwZ56pYCKYJdoyBKal0D9dFDCr
 S8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777578627; x=1778183427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sehIK1ss/UfV25ulny1ykipeeUWFbqMuTXJbr9AoQZc=;
 b=egLitpWgMBNuxF+ukIyyvfh0B9XA4PDyp4YQv2MaMCOr+5i4WC/IFdSlmEaCu8tXkD
 LFh46R5AvddlstanMdR+QMhaB+9izEthX2ZdP0Ven1YM/jpwNar2W93ZxxIbvmXYpRA9
 xz4ICpww2f95NrkyyK95GaenWfavuboqHGdsukY3mzBDu2UMjOLdRb2S5rdpCXbq5GnP
 yZdnvGhVF8kgtcCyS2+kEdaUOESINS2MoL8/ybQ5eWKqCy8+y7fXskiuUdL323SRExBu
 QCRiaGT2wV5cUpce8SVSusbGY+gN24Lt2J0NI4JSVKGrB/3vXr9h81Yt2x6kKhTw1Ulp
 ibCw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+1GPCo+X5GSQW/8gcXfWvCyREiMgYUt7k/wDZX1jMJjwf95HaljlYe2Vw8LpYmnr7giVbqmv+So1c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx6yYqixLqKI9zO7QZK+ZDWYU4Tib145ndfT/wAnEffEj2mZc44
 s/ThjY+45MNweZkatlMJVYWVuj9u1BiKVqZcecuFzZJVpErjKZKmqyytTZQG8iC4ze4=
X-Gm-Gg: AeBDiesdxsiWHZBkvUmsfImk8mLEyYJVIQe2dooB4H/w9JsZ8i6rDQTBgqLev2pOd9V
 IiBuUf7fvbmCKqRqwB8Yz2pQXWmVSsFgaE7FKk5YDAKVxIn5a9J/4osu2d1j0zPsDhx/ZElunur
 CcBM3UE1Xp8DuRSdt0lCL+OIa2pbmFkR5XtB6J+bQRxMkMUWRsbKlfnFOJAcTEsItF1O7JnuBqQ
 Px2zH28J1m1ZicupjBVd4+IRUP2e+5SGrvp4axPCK6r4nvi+6nMRrI1vgyESnU9CuSImV0Vo/Jv
 CbFa8DQrMcbxMx5EawwhTxMHnWGebOAXxBqo4ZpYErXEaKt8M+EK2S+EMEwrJQFj/GoIf7+d6Tq
 p9LfkrsuemoBnMkXl3bdrr4uAtVyY/3gHO8+mX4WviULM6nneeXGYYBpLaWYAUfRthf7WO5b97F
 4zqB1U+tIZyjdGhvJxAL8NKCwSLtwsxtKuvE2z01n1JGI5VlAFBg8hmNB4W+0jo7gPiWfe0ZI=
X-Received: by 2002:a05:600c:699b:b0:488:ab26:8fe0 with SMTP id
 5b1f17b1804b1-48a8446d81emr76044935e9.15.1777578626573; 
 Thu, 30 Apr 2026 12:50:26 -0700 (PDT)
Received: from osama.. ([2a02:908:1b6:8980:55a4:d495:8d6f:1416])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eb75fc1sm3109615e9.7.2026.04.30.12.50.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 12:50:26 -0700 (PDT)
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
Subject: [PATCH v4 2/2] drm/bridge: chipone-icn6211: use devm_drm_bridge_add
 in dsi probe
Date: Thu, 30 Apr 2026 21:49:43 +0200
Message-ID: <20260430194944.78119-2-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430194944.78119-1-osama.abdelkader@gmail.com>
References: <20260430194944.78119-1-osama.abdelkader@gmail.com>
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
registration, and drop drm_bridge_remove() in chipone_dsi_probe.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
v4: drop drm_bridge_remove() in chipone_dsi_remove()
v3: split the patch into two, one for i2c probe (bugfix) and one for dsi probe
v2: devm_drm_bridge_add instead of drm_bridge_add
---

 drivers/gpu/drm/bridge/chipone-icn6211.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/bridge/chipone-icn6211.c
index 553a1df4688d..b12cd2690474 100644
--- a/drivers/gpu/drm/bridge/chipone-icn6211.c
+++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
@@ -730,13 +730,11 @@ static int chipone_dsi_probe(struct mipi_dsi_device *dsi)
 
 	mipi_dsi_set_drvdata(dsi, icn);
 
-	drm_bridge_add(&icn->bridge);
-
-	ret = chipone_dsi_attach(icn);
+	ret = devm_drm_bridge_add(dev, &icn->bridge);
 	if (ret)
-		drm_bridge_remove(&icn->bridge);
+		return ret;
 
-	return ret;
+	return chipone_dsi_attach(icn);
 }
 
 static int chipone_i2c_probe(struct i2c_client *client)
@@ -767,10 +765,7 @@ static int chipone_i2c_probe(struct i2c_client *client)
 
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

