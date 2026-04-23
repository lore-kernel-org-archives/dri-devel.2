Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC12FDEE47
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 20:05:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7B2510E37C;
	Thu, 23 Apr 2026 20:05:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MZEJohO1";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A44C10E37C
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 20:05:52 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-488d2079582so82644675e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 13:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776974751; x=1777579551; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L0yq3naw4P7KBF3HnI/5iYacHkrIr5+a/lmsEJuzBgA=;
 b=MZEJohO1vBdSiXakefKYoKuFH2edKFRmPgGvaU7vJuFXasPTmYT1Q2ft6rR0QQtv8c
 xLYRvD9Frmki+iPtBS7qJw9pqemZcZOpm3iKJTDu6E8gJlbdu73Ka4qd4K/jByy1KkN6
 29BC/5HBYOwa0d32kLKQjV8aJFNSr8yf0wTg4/W3hOFyVaVSkd/HyyLdPJbOCYxcUq2N
 vK68re9cGM1LTE8dg8ChcJNmZx61iIwyuNZvc8BRBFU1C9LhucPy/al57b/AwNX/Yqx2
 SkYOkhudX7/ZYR+9C/Kq8HvPodR+Brbd9nmyLPZHqf4FCL0Ttb7Tm424+so6xVoHaya5
 rEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776974751; x=1777579551;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L0yq3naw4P7KBF3HnI/5iYacHkrIr5+a/lmsEJuzBgA=;
 b=TaJSLzrR++DR3GZbPGllVdibl2il1couZbJIpnIV0nW5vM/Nj5ZMJcInkonfQLiJu/
 O2LoClM9l9pIU1qdo8Ipi4lkMhLzBTlvKoVpebx/fN/K1jzW9R1dOphpf3c2OOMVFZP1
 bH1EbrTaZUifuOUnqj9T2Fkcf9ojqvBCVcAPnm4GXMsypBNMbLtZDaatGnX7dNXFD5WZ
 WVZCi4SwYqc5SSN64bzpRJjnjthCf6r260VD1+XINWlECBdrnz1LJywhTz7HeKoKpCW1
 7Dncp8YDsu9NdOL+wIp16IhM1Guj9Q5Y6GZ9FSA+I1F9k5otXvv3ZFC6vP9JOWGE3RB+
 tdDQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+m17Oj5jHatWmolac4p0txpZRUBnxsJLj9yzi1BL7SK6CLlHciqqjWKvuG9X+6LKxJYQdKEnfCKOQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzsjd+B+vcOprUchbLU1d6Hgwpj4ofUmcLqXqsyjfg0uMexuImX
 JO1/E03nn+8uDicABxnLSMiM0/MjntzCCmKOhFQ9lSyDFMRvG0rdtPG7
X-Gm-Gg: AeBDieuWxQGVvnNz+i2ClBPWVYzX2a6n1WZmM+n56Mom0Kd8bFS+rDQY4/W0w72C5Wk
 7azR+RGI8ftICy+v/WXpkwUmCGxLzb+ElUpUM4Ot7KRkdbzGTOOC4SDTHctH8pt/DV14Ur2ynbb
 lI+t6AKzCRC/aI8YhybxU0xEuRrDtgM9zKOO1UBWYs0xmyX5yntFAGUiJWqSBimLoH/RghRTu2J
 YxdMqTBVCFY72gbOs2Tbtap4Qu6sxHwnrvZjB4MYRchhvcoxTZ0glkwyHiqHO8+8aC1dC0lam+a
 CTLnUO/mQBH+YFpayZZqLchZf84xK45YTk5zB/yuW+RsAvOYBEsGoOpvO4LBxF7HLSp88TwiTCL
 qlVdfmtTNBR+zznbyFgffLi5MFxcMAJ38vVqYJQBPe3B0gzIO9DDBbG3m6kNlqsgNnc+u1wUcqy
 7uxuqnE+IynaNRTFFtl1ve7sYRlp0uYw2NLpF6ZddPZEcmRjy++TvYEmu6wkXGhmRTKCLdtP4=
X-Received: by 2002:a05:600c:c177:b0:488:a82f:bba9 with SMTP id
 5b1f17b1804b1-488fb7804f3mr383647975e9.22.1776974750505; 
 Thu, 23 Apr 2026 13:05:50 -0700 (PDT)
Received: from osama.. ([2a02:908:1b6:8980:5f44:38d2:bccf:b54f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb135asm59683343f8f.6.2026.04.23.13.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 13:05:49 -0700 (PDT)
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
Subject: [PATCH v3 1/2] drm/bridge: chipone-icn6211: use devm_drm_bridge_add
 in i2c probe
Date: Thu, 23 Apr 2026 22:05:46 +0200
Message-ID: <20260423200546.324187-1-osama.abdelkader@gmail.com>
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
registration, and drop drm_bridge_remove() in chipone_i2c_probe.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
Fixes: 8dde6f7452a1 ("drm: bridge: icn6211: Add I2C configuration support")
Cc: stable@vger.kernel.org
---
v3: split the patch into two, one for i2c probe (bugfix) and one for dsi probe,
    and add Fixes and Cc tags
v2: devm_drm_bridge_add instead of drm_bridge_add
---

 drivers/gpu/drm/bridge/chipone-icn6211.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/bridge/chipone-icn6211.c
index 5bee10c64265..4d76e1bd5e78 100644
--- a/drivers/gpu/drm/bridge/chipone-icn6211.c
+++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
@@ -758,12 +758,12 @@ static int chipone_i2c_probe(struct i2c_client *client)
 	dev_set_drvdata(dev, icn);
 	i2c_set_clientdata(client, icn);
 
-	drm_bridge_add(&icn->bridge);
-
-	ret = chipone_dsi_host_attach(icn);
+	ret = devm_drm_bridge_add(dev, &icn->bridge);
 	if (ret)
-		drm_bridge_remove(&icn->bridge);
-	return ret;
+		return ret;
+
+	return chipone_dsi_host_attach(icn);
+
 }
 
 static void chipone_dsi_remove(struct mipi_dsi_device *dsi)
-- 
2.43.0

