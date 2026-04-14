Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B3BF9D0ED
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 17:55:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4F5910E05B;
	Tue, 14 Apr 2026 17:55:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j15Juv6L";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC5C810E641
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 17:55:24 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso71971135e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 10:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776189323; x=1776794123; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WEPxx9A5sVf7Qa7xqxDP7r+0ORunjQzMoxjAyInlaIs=;
 b=j15Juv6LzWKRhwOFrWK9gqCeMBvp6LaLnlGdShv6qpKDgnfy0Dyy0kF5xYKY6HUwu2
 VLt2AjWNwQwUdASnED1hXfzpJAiqgPp2ElOT/kFP2ZyhKLzTLeSFx14CBeeXrGvCCgJh
 bSyDZlkw67GwanVNybIzXBc7L4BLxUmZCMvrH5L1t5t88ZtlQkPf93wbaTS7HP2Hhk6g
 3GYGz9EHyReMH/XQjjJTZaT/eKX+De1qGimGzkExbaHQyOmfDdhY8U8MRxgYcyOHCelg
 H/WX2U7QYvy5pQMa6w0s6zaYo1yq6JVxRFoxsI4pVWzr85Dt5sKNFlYr7ZjYUMhhiG+m
 OAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776189323; x=1776794123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WEPxx9A5sVf7Qa7xqxDP7r+0ORunjQzMoxjAyInlaIs=;
 b=dMqrkYFN7uBdG21Q2gNkPI1yoc1t/iJMvlb03Cbz81DfbhIEJBvNI4UWjQz70EIld3
 CZkH48VHH6soZjURBRstkgb9S7tgZHIuOAlndLmp27rZTc6Y7eJlTCBhXIRPpIevWRu2
 FhwYwYZGgcSlPPubjOGpRXDbBZo3F4WEwZaO3SABSXy6KnF/6WEU7ZmvOxEm/9Kd+0T4
 7Tj66sdDikGGpfPXQjY3C4uZYS5nvVZnJiXN4X/QJhdUSuWvXyWCAa++H8TrgtRy03JW
 Li+on6UT5tUqqECQOFOzzGARbtJIHTp6jE0EbLJkrCUooVdmxjc/ZlRJJnuBg0bUHgeY
 7jAg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8qE9OlaChIclDfgoDA6AvKkfqP8JCzr5u3Zt99HEXQTJCD+DBTv/bSm6L1FZBCAcUhootpN+OO5k0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw6O4SDfSnqi2nR24u2mH6xGx0PkYbTEGl7JvTEnDsU3GLhqdqq
 29iWN83vc1DFy+27CH/VppDSN+aT30rxOsMKubmanf9NPZMahIugXVQI
X-Gm-Gg: AeBDiesJ/RHGXBDUzqdM9x45okjbyn6t9wYjUdaF8Gik1S7XBssVNWUKRiSsncp6hsG
 17AWuoasCXKzTk6t99CVZFNTrEXgdXzjxWQBA1tngwt2G4jjYJYPARvTvOW+4+6RnfGWYRJtqxh
 UOhqQOPsNu4c/Dkpueasg/e2OGyb5QFHsMHDCWbFQRSjqL8RLbVPTVHrd9/DjhNdGC0aUQvmITQ
 6Ze2ErhLeltVtw/fSE4JlKZXqEFk9R7wg3TOEDO0pCTriFMzWkxMGYhaUj/ydbKPZNdCW9tQ7cD
 9XcsJJ+wDXr7EBddYP0aVlv6GgyHTVfy9ylvD+hcQs3kGD6PdwqK8ffo2rEbvJaP6NCWvolGvqw
 FOUnFUw6bGU2FTNGZLDLxdPnLG0KG1gsa9Zj4bSh7aSesUHa0YMBUZxKP0XHXA89c6WIi1EIhkP
 Bm+axq+2J87UaUQu7jBlaC2/mB6VQH/RIPnxZyQrPRjL9SO7dmL8m+sVtfwWu0
X-Received: by 2002:a05:600c:19cd:b0:485:17a7:b9c7 with SMTP id
 5b1f17b1804b1-488d67e3671mr252438805e9.10.1776189323227; 
 Tue, 14 Apr 2026 10:55:23 -0700 (PDT)
Received: from osama.. ([2a02:908:1b6:8980:cb49:f403:bb20:cc84])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ede1df12sm150436425e9.4.2026.04.14.10.55.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 10:55:22 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: luca.ceresoli@bootlin.com, Peter Senna Tschudin <peter.senna@gmail.com>,
 Ian Ray <ian.ray@ge.com>, Martyn Welch <martyn.welch@collabora.co.uk>,
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
Subject: [PATCH v2 3/3] drm/bridge: megachips: remove bridge when irq request
 fails
Date: Tue, 14 Apr 2026 19:54:16 +0200
Message-ID: <20260414175417.144625-4-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260414175417.144625-1-osama.abdelkader@gmail.com>
References: <20260414175417.144625-1-osama.abdelkader@gmail.com>
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

If devm_request_threaded_irq() fails after drm_bridge_add(), remove the
bridge before returning.

Keep drm_bridge_add() rather than devm_drm_bridge_add(): registration is
tied to the STDP4028 device while ge_b850v3_register() may complete from
either I2C probe; devm would not unwind the bridge if the other client's
probe fails.

v2: IRQ failure path only (explicit drm_bridge_remove)

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 .../drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
index c9e6505cbd88..2d02cc69f237 100644
--- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
+++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
@@ -251,7 +251,6 @@ static void ge_b850v3_lvds_remove(void)
 		goto out;
 
 	drm_bridge_remove(&ge_b850v3_lvds_ptr->bridge);
-
 	ge_b850v3_lvds_ptr = NULL;
 out:
 	mutex_unlock(&ge_b850v3_lvds_dev_mutex);
@@ -261,6 +260,7 @@ static int ge_b850v3_register(void)
 {
 	struct i2c_client *stdp4028_i2c = ge_b850v3_lvds_ptr->stdp4028_i2c;
 	struct device *dev = &stdp4028_i2c->dev;
+	int ret;
 
 	/* drm bridge initialization */
 	ge_b850v3_lvds_ptr->bridge.ops = DRM_BRIDGE_OP_DETECT |
@@ -277,11 +277,15 @@ static int ge_b850v3_register(void)
 	if (!stdp4028_i2c->irq)
 		return 0;
 
-	return devm_request_threaded_irq(&stdp4028_i2c->dev,
-			stdp4028_i2c->irq, NULL,
-			ge_b850v3_lvds_irq_handler,
-			IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
-			"ge-b850v3-lvds-dp", ge_b850v3_lvds_ptr);
+	ret = devm_request_threaded_irq(&stdp4028_i2c->dev,
+					stdp4028_i2c->irq, NULL,
+					ge_b850v3_lvds_irq_handler,
+					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					"ge-b850v3-lvds-dp", ge_b850v3_lvds_ptr);
+	if (ret)
+		drm_bridge_remove(&ge_b850v3_lvds_ptr->bridge);
+
+	return ret;
 }
 
 static int stdp4028_ge_b850v3_fw_probe(struct i2c_client *stdp4028_i2c)
-- 
2.43.0

