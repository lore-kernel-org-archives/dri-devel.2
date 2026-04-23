Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6673AFDEE3F
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 20:06:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9EE710E396;
	Thu, 23 Apr 2026 20:06:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lFWKduR0";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1F6410E396
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 20:06:08 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so90424115e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 13:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776974767; x=1777579567; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HpqVbCOfb49tloiiXQzQRUfJweaRdlqFCYtMfaiIiMY=;
 b=lFWKduR0FpIll+KylQ4Y8TmljBFKg54eLldlAmZkE3SVI5zpCeGn7kaHjeZa5iPMmf
 gl3OlPd0Q06GL0MCRbv9vSDRaCHl+0D4+khkDzJQvuwiE/sOqV+yx08WlTdnTt81Drkg
 3AleeWX0MazFeEFn+SLflVY3sC9Qgsf1tP/j5RAEzEipHRVzSXnqtjPS1HyuV135wPfC
 5H7zaIWpAMYzHX+KQo9JNxG/SnbT3hNGCm8JfS0nImDstgvPIjexaJjEcujIRetOy5RI
 rtAMLZo0dwBmlh6j4yMSWUXugckISxO/hnrjJsRxZ3SmdJ6S7RQQSBnC1SF4AEjto9xR
 4kpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776974767; x=1777579567;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HpqVbCOfb49tloiiXQzQRUfJweaRdlqFCYtMfaiIiMY=;
 b=R/1s9+aJlWLzog+U7o0EfylrXYJHXcBn+o5QHabvKNFc0Hz5U1TZDEITHvRf7uIb1d
 n3jD23CBWzrwhgbZjNUq6TFdyuIYQc9Cn4nic3kbG8yHa1KmWjvSUgJJ4gHSj2Oixc4D
 RBGxUxASpNjPti02FCwEWcjvPLO53krMcsh5v5TuZpwKcVtUrKO9ZJByJbZdDGvzDs3r
 8o0MzH3DYtaUAoAkEcDhRLn2bPsqmFWzhlnknBvelIULCmvzc/TUE4wUCnZ/K8KF+dpZ
 ovs1oMGR/d/wExkxKzzXMOb7whAfNCT9JkZxlhqEyAIBMH6cgdMouyoxKe0LQOXrc7QB
 109A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8DUualQAFC4U6aE9vKPnQrESGlvJ/KK+uOfwd4WSv6NNYdl4K9jmS0Nbmt8jI9WZ7i0lFNhW/icCM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxjXOwnLvSArw61IoK3XjaCg898jF5ZpnnuXnZqb4Mu/YyTMyK
 2NeNEWVUszDapb0qm2GDrTZSMGMCZmQzxo9uO3u9DOBB1Dy00BTf7iux
X-Gm-Gg: AeBDieskbv7oy+l5b13WLPDKI961rQ1XJVZFqlPDHCgxx06mohXLl5/3UM+EWIZ2yFT
 s4cGQOes559PCr7E+686yQONXhVUd9vIDdYRF45m2XvALgZn15JTIrZTGnb9zzfpjDY5tnOflON
 CesT6d2oGQGj1Gmgw7UetES4qp7WXpApELNkt6oLJcsugV8IH6iRoSyOJeTMJIxfISii0M2Xw66
 oI9QXDaM/PycLmsF/bbNoECFBbuw2MOhDjBlUm6APv7v1ODKAL5PxizOxTt2dWkSz7imbQSx+U/
 trKYJ/IyqAQGJvZMwDnajS1bdVN2SYIM3yJLlwDYqVLAG8hy2pkHxIzqFxjco6Yz9vMi+g29Cex
 w9U/I9/62Ku7HrdwrmMdIirMNsUWHhNu/44gc+zoIo3Wi8kvepWVzy8PK1ISqIQA+oEUs92+ZcA
 NVJbHezeDSc8mQcUv0+1ikfMfzeBp2avRnrEoFiRXSMZ2TXU0Xd3ibue9T36f90VmzC72fkxy2O
 9QUEcrJJg==
X-Received: by 2002:a05:600c:4509:b0:489:e126:b757 with SMTP id
 5b1f17b1804b1-489e126ba91mr231631365e9.25.1776974767267; 
 Thu, 23 Apr 2026 13:06:07 -0700 (PDT)
Received: from osama.. ([2a02:908:1b6:8980:5f44:38d2:bccf:b54f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc10019bsm552934705e9.4.2026.04.23.13.06.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 13:06:06 -0700 (PDT)
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
Subject: [PATCH v3 2/2] drm/bridge: chipone-icn6211: use devm_drm_bridge_add
 in dsi probe
Date: Thu, 23 Apr 2026 22:06:03 +0200
Message-ID: <20260423200604.324615-1-osama.abdelkader@gmail.com>
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
registration, and drop drm_bridge_remove() in chipone_dsi_probe.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
v3: split the patch into two, one for i2c probe (bugfix) and one for dsi probe
v2: devm_drm_bridge_add instead of drm_bridge_add
---
 drivers/gpu/drm/bridge/chipone-icn6211.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/bridge/chipone-icn6211.c
index 4d76e1bd5e78..f53e64129ebe 100644
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
-- 
2.43.0

