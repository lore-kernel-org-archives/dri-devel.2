Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3498AC44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 14:36:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E70310EA6E;
	Tue, 21 Jul 2026 14:36:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sKVsJLIF";
	dkim-atps=neutral
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A98E810EA6E
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 14:36:21 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-848643382fcso12456156b3a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 07:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784644581; x=1785249381; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UMT648ai00+XnGVVa+iznQI+riy4WK01QoUhmpZLpkI=;
 b=sKVsJLIFi45RMQniNXzsYgxEQPRuY1ksQRsF9Y6hpD+Ws2BDK7knznaGQpEG0PCIsn
 PcW6xBFQ/ofEV0j4R9ziiRYLfOivKIHDOPT65fxZpS0TYI4GsYWdQA7ZRffNo3YucJ+q
 rFHymkgcGMsKUC+20IVe16uPKzCXk1GKupu18dGsWDZaow37BAbjox67PCVeepo1/vK8
 z1I4R68PwRfzNGKTfkWtstaE2wDojP33uup1wEOg04o1Ci8DaDG/e5LpHPejMPoNV5ae
 tdjdJQrAcD+PdoAANX59+9WQwnECHEPwuAu9Mw9J5PKT4LvLmaF/5dHL8SbGjXP8ETFy
 SBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784644581; x=1785249381;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UMT648ai00+XnGVVa+iznQI+riy4WK01QoUhmpZLpkI=;
 b=SUbH/nd8ZL2mPXK7chn6nVET300fbw45GuwAdydxeUda0172IOlWL7YjgxnCW0yzdg
 +PY04jkY+Rg2O5vYspL5BJPd9TvH0wZYaJrGhEldHsTngynakrLlOD4h5vVyh6cwxdvx
 9RP1IoJgK/9r7deWfzjRULFErcv68UeKzis+mrt0FIn5abzk1SzuKg78oe6d5DlbSf11
 qAAEzkaZWLAkC5lNiX0Zx9KwAnBmkSBPn9GddTKZ1uRpF8aJSq9l2tRN+j3rx8Z+1VhJ
 K5r2oBtNs00G2gFQL2unvBDnKJEAxoU67U0bciJvNPdFDuToueGpy71iOodnB0SCRMnm
 mtag==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro+cZWMm2LSWJ8KePnBSisdTkgmbG7m3Ed0KCD+S6M+NRBIwGbTw8ie2PgLzVk4HeEZGwSXUSpGTqc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YySGQzX9Pa8U117XmjyLT/8vqwWqgm2HeutklrtdEzUe2ahelbK
 DmyPF6DWdUgmnYxfr/Pg+5/NtA15lA1ieFW7hsOY/LyNfIB2cKpeFs0=
X-Gm-Gg: AfdE7cm7VieoVZVkFXN3fpsT4lpNCA+YwrRliBMvo2g64Uh2tv4GDR6QERIuDiEhn3g
 8T2JoVsJT4MLByhocTqwadsz9GgKM3hFHsF7Twp6KdT7mHM+4FmUlfPs3/Hzc8V/RfifdNX3ZKy
 0Gl4z4a1mIxQK6AlZQtXog6qZphYIJL3PlrLuAb/8aFoK91rLjTZ3Kmh/rvXVBF3GMb0/IlMDaZ
 MkbMmfza1UB/dDeoV/S7xF2Sw/JHJSDxNe4xblAwJAWTLHGPlgJBCNkIIIO3dONKiMwHoTsvd4u
 tvbeTm+oNlFLcwvOPhY/ABlHXJdguNtWcU3j8LL2BmaMdcD46Vw+DBci6gNMxCZP1s+RrxkTREz
 tpVmqadMVkyBb4Zo3nS6sZTdMz5/opFuAKRuHwzIjPpZQ3ABkom4U5zGmz9B3oKFdn4o5fySEy3
 DxqfIUBB+nUYq7Fe9vWO7p/pTEFXY+Wtcs/glgw3xZ3DvpkwdviFArvH61JK37BB/qhiSOElURE
 P12J9eLmELvuLLlrNIvvDoD0p18fbHye75+pY9Y
X-Received: by 2002:a05:6a20:cc0b:b0:3c3:6b6e:8ba0 with SMTP id
 adf61e73a8af0-3c3ad66a4ccmr20423394637.11.1784644580980; 
 Tue, 21 Jul 2026 07:36:20 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cb517aad770sm5955114a12.2.2026.07.21.07.36.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jul 2026 07:36:20 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Xin Ji <xji@analogixsemi.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Myeonghun Pak <mhun512@gmail.com>,
 Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] drm/bridge: anx7625: stop IRQ work before teardown
Date: Tue, 21 Jul 2026 23:35:59 +0900
Message-Id: <20260721143559.27322-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

The HPD interrupt remains active until devres releases it after the
driver's remove callback returns. Its handler queues work that accesses
the Type-C port and DRM bridge, but remove unregisters those objects
before destroying the workqueue. An interrupt can therefore race with
teardown and queue work that accesses released objects.

Disable the interrupt first to synchronize with the handler, then destroy
the workqueue to drain work queued before the interrupt was disabled. This
ensures that no HPD work remains before unregistering its consumers.

Fixes: 8bdfc5dae4e3 ("drm/bridge: anx7625: Add anx7625 MIPI DSI/DPI to DP")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index fffcd6154..d6071839f 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -2973,13 +2973,15 @@ static void anx7625_i2c_remove(struct i2c_client *client)
 {
 	struct anx7625_data *platform = i2c_get_clientdata(client);
 
+	if (platform->pdata.intp_irq) {
+		disable_irq(platform->pdata.intp_irq);
+		destroy_workqueue(platform->workqueue);
+	}
+
 	anx7625_typec_unregister(platform);
 
 	drm_bridge_remove(&platform->bridge);
 
-	if (platform->pdata.intp_irq)
-		destroy_workqueue(platform->workqueue);
-
 	if (platform->hdcp_workqueue) {
 		cancel_delayed_work(&platform->hdcp_work);
 		destroy_workqueue(platform->hdcp_workqueue);
-- 
2.47.1
