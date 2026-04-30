Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F07CD13DA
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 19:50:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CA6810E180;
	Thu, 30 Apr 2026 19:50:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hPLPhGvZ";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4652110E180
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 19:50:25 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-488ff90d6c7so12670955e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 12:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777578624; x=1778183424; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xV2RUgdcgAI6HubmbhhtbLRAwJ2b8LARLx9dBYFOMRs=;
 b=hPLPhGvZ9X3/HQI+IRpuBDKGb4kb+Ux1DuetKbjlWSHN6c6OujepmwCfPuzYtAeirD
 cTVpE2YgUYYbNlSG+Te3v3t5xqQ52nFlfZeEtQeUdOFxTJL+/QeuJyJsfEBtviZA9ZZf
 g8ZzNgSf1VqdnXwhx52uWeYnYeSwnflTo0sX71t19Br7rfIrg7OlFSE2sEYPV8uqOCs6
 jzqch7ApXm/VINU/C41aBSkmGcAnxaXarZe3LUWqprgS5TtmTdAKWa0K0UYauWVq+as8
 x4WyXBKrt1alAw97HyxN0yDyrCaTXpSAWbYrwykYnBFsAmp22wJYJVm8EKzGEThOSuyA
 vuhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777578624; x=1778183424;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xV2RUgdcgAI6HubmbhhtbLRAwJ2b8LARLx9dBYFOMRs=;
 b=f084y/+vmSTnUYUKsQ4sBhTYaRwFc4u0r7ZqwHXYxcHgShmxzL8RFn2B/OqXBqitRF
 lpdgYHcVStK9xYr95pi1mouu2eAyWnAVUpnvfqDs9pvTFG2A45qgUnb14cmZEBVI9d67
 m2PjbRpE2FnUdZ8Of7a8DCVjGR4fsdBAJcNabYy9xwTlKePDSobdBc7FPy3TnrqBiwbs
 peOsQBgaIkie7955BwRI4ZuhzGQFSDJX11T4xl+vXl0PG11ueQeKgpJoWRoooc1eRXRy
 30/r3wy1BfH2o4mcUDVw2pWFFwrpOUc3yB8r3XBG/GY6dbEeI45Fhsji9SHjVzQnHS27
 IP2Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9BODyb0wCTmfSnkutiMF8lsSKHwUveJbJ/7RoT4lHL5g624NmIk7gDtgUvb3oFscS9S44AhIgsvas=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxQQgRddSMpMrRgnfHVBSqg6xNyglU5NSfLswf/V4lxHdG0jgZU
 TPqrSca8h8kFEnAwh3DFtlNrOg5QrGz8SVxTJi38B0mOTxOrOfvEKTBS
X-Gm-Gg: AeBDieseM5l504wWCpwGIQ/oUkrhtKU10dY6nuz/tXA1e23FfiCSCzWqxpqJj9C7KA+
 1iyXsY0FS586DfAYsx/OTi7LmbUpjqUMrdLmB9C0KrPL4TkL0ix+L5/XqyzdWzdvzlV8dRk7puK
 RVdUnyYMh6oTl6TqZzyUPMMlEQvu2BidFYD5K/U+pDuhUofl6otHv/c2NKfYXkTYquALG58TATQ
 Nq9UNyoc939FCY8igzYahqY8n9AFwAF5UumyAESb85TQwnDSvWXy8RV+X2dobiUcGf4ql2gLm90
 c7Tk77+PFOJ4bhr5kAwpsH1O8Odgkz1gN9aNG/WtSqTebovsYFxkDZ7pMFMTKfVRsMZjE88rgCL
 MTFQZjExeo7DTh0e/eoZ1/haSRPQir3uZeS8QokP93pDtSOYNkS6cBxV9ZiNknMcOLVMqIQ80UN
 ogO/rpKZnhkhZTndH3/oUU9ig+5fjiK/99ZpiEwh31HtauJrV1i/5Bzb09a9WE1jRrG3BQESg=
X-Received: by 2002:a05:600c:a14:b0:486:f634:ef1 with SMTP id
 5b1f17b1804b1-48a844525c5mr68630135e9.17.1777578623521; 
 Thu, 30 Apr 2026 12:50:23 -0700 (PDT)
Received: from osama.. ([2a02:908:1b6:8980:55a4:d495:8d6f:1416])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eb75fc1sm3109615e9.7.2026.04.30.12.50.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 12:50:22 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: luca.ceresoli@bootlin.com, Jagan Teki <jagan@amarulasolutions.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Marek Vasut <marex@denx.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 1/2] drm/bridge: chipone-icn6211: use devm_drm_bridge_add
 in i2c probe
Date: Thu, 30 Apr 2026 21:49:42 +0200
Message-ID: <20260430194944.78119-1-osama.abdelkader@gmail.com>
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

Use devm_drm_bridge_add() so the bridge is released if probe
fails after registration, and drop drm_bridge_remove() in chipone_i2c_probe.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
Fixes: 8dde6f7452a1 ("drm: bridge: icn6211: Add I2C configuration support")
Cc: stable@vger.kernel.org
---
v4: refresh the patch
v3: split the patch into two, one for i2c probe (bugfix) and one for dsi probe,
    and add Fixes and Cc tags
v2: devm_drm_bridge_add instead of drm_bridge_add
---

 drivers/gpu/drm/bridge/chipone-icn6211.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/bridge/chipone-icn6211.c
index 814713c5bea9..553a1df4688d 100644
--- a/drivers/gpu/drm/bridge/chipone-icn6211.c
+++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
@@ -758,7 +758,9 @@ static int chipone_i2c_probe(struct i2c_client *client)
 	dev_set_drvdata(dev, icn);
 	i2c_set_clientdata(client, icn);
 
-	drm_bridge_add(&icn->bridge);
+	ret = devm_drm_bridge_add(dev, &icn->bridge);
+	if (ret)
+		return ret;
 
 	return chipone_dsi_host_attach(icn);
 }
-- 
2.43.0

