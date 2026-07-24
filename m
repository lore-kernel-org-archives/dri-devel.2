Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 328B5C531D0
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 07:16:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3765710E2AC;
	Mon, 27 Jul 2026 07:16:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hNxg1vlm";
	dkim-atps=neutral
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3228C10F2E1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 10:08:25 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-84e0688b859so104688b3a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 03:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784887705; x=1785492505; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=i0F3yBArKcXYT+DEWXeSbqqrZfyglayU3IMutIRKDs8=;
 b=hNxg1vlmDvWyi2skWh2CZtxUU6HUGjToLd5lDyUG8LeJUiEWVncVDbI1sPRcdFrsco
 w6QB0eH9tNtvwjURIKipM7VY3QnCfAwnG5yPDKM6c+7NSlWI8hhKjrpHAUd9VJ9cWEWO
 vlRQrqy5wGnGfeid635SS4ttgxU6aTsA377l/d9NwN24fifwvhDoZywsdUwN1NR8Rqs2
 L8ZIAZaoBK5TmoAmpERuq+kXNVRKx+/6ZlrZrGk1bg2y3CJ5jxSiKswI7VqgD7Gdhx4w
 vDBetHRCLCtwNWv9AWnv1MYLR5KaFZZ5wdz8oOj9qO1ST/6UYoXUywDFqayrKdPE6svp
 75Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784887705; x=1785492505;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i0F3yBArKcXYT+DEWXeSbqqrZfyglayU3IMutIRKDs8=;
 b=mLLjMoJ/gCHkFW49iu/d2VPcSaxFTjMbDg+bS8Y3znmmZcp+YRX1vBwqZwJsgbeQcP
 0EmB5A3dFuuRZ/ut/K/rh0mJQUA2fpPJQYzXbpjvvgENk6Ems/WE+oFrxIPTV5mBAd+e
 KuHcC4NEXSDczbEccZEa6zb3PKkFitbRfXpM9+QO6xlasMp6FwwSAfdIMahI4caKc3bZ
 A3QRiI53PRJy3i8MzyOapIBC/i81f4F3gDdx9ba73qKQMMLlT3czkka+ADS1I1k4FNRy
 FlXZNY3D0agKjHH3P55PmNiSnJlBOwxC5kt2WXwDko+DYEplf5uoam7Bx5rN5mk5ERx9
 SMcw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpaC6mauiBabkcbX0fIxpljoHjRzQGO5naszEHZehb+MI19Uf2YAoXEE6jF7xC7PCvrLmJGjIITN9E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzUzRkGcNnkJM+QzF3k6BfhC3CvWjXj4SY2uWgz1yJ2rT6C59zT
 lCzMEnXr1rH/1i+74Y+pc2dAfeZQJTGC8NtCbtZjnQNMGJ8XdPcsjFhT
X-Gm-Gg: AR+sD13QRRbn0isRLIhAycQdZ+uO43e1hSv63JqlByk/SlmUU0s/Q2RiQZKzavDyaGz
 8eEV453aaY9CErhH6o6xqItBXPGYTrAKVLpJprOyGCEvPAtuwQqoLRn3z6MPIElE8Xhix6wPfSX
 GtakBpTU1vRH02E1XmV50AngzLiqHC3Qt/jK66FccROjFQVuy6fMCW1o6y4pSlkcnh+2ALZmPAW
 kCV0mehiEVF8wJrqWPV7wAnwBbell+K5glMyq/ERWoQYVofRN5ZInFjVARkHLceWg24RrzoucZA
 VPPt2bEud96shvYPQKqd6/pTli4oVkdcgcipaDZoRj5DqzETLBknsK0ubETymiQIrG5MM+hX2ze
 V93NxdLSQljhgDffDoh/kEqkZXjUMMakw0+66ZvblBiaoGehqmRQ2NEPhnpSh/7CvYQJplyCLFH
 tgpfxEMuNXBvDmTpc05SAOp6ufxTxX9fHvjtCI7Z93MgxCsbhC6DPwIFW1e4FF7GhFkfcfM9jCV
 gB4NjlqxwTF5Z47PJUnwQ==
X-Received: by 2002:a05:6a00:299a:b0:848:8027:cac with SMTP id
 d2e1a72fcca58-84e2b8988b8mr7358998b3a.23.1784887704633; 
 Fri, 24 Jul 2026 03:08:24 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e175cdc21sm4405335b3a.47.2026.07.24.03.08.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 03:08:24 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 1/2] drm/bridge: adv7511: Reorder power_on() and power_off()
Date: Fri, 24 Jul 2026 17:08:02 +0700
Message-ID: <20260724100803.50169-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 27 Jul 2026 07:16:35 +0000
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

From: bui duc phuc <phucduc.bui@gmail.com>

Move the power_on function block below the power_off function block
to prepare for the following patch.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 48 ++++++++++----------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index 02f8f7e78a16..d98a8f7afc7f 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -302,6 +302,30 @@ static void adv7511_set_link_config(struct adv7511 *adv7511,
 	adv7511->rgb = config->input_colorspace == HDMI_COLORSPACE_RGB;
 }
 
+static void __adv7511_power_off(struct adv7511 *adv7511)
+{
+	/* TODO: setup additional power down modes */
+	if (adv7511->info->hpd_override_enable)
+		regmap_update_bits(adv7511->regmap, ADV7511_REG_POWER2,
+				   ADV7535_REG_POWER2_HPD_OVERRIDE, 0);
+
+	regmap_update_bits(adv7511->regmap, ADV7511_REG_POWER,
+			   ADV7511_POWER_POWER_DOWN,
+			   ADV7511_POWER_POWER_DOWN);
+	regmap_update_bits(adv7511->regmap,
+			   ADV7511_REG_INT_ENABLE(1),
+			   ADV7511_INT1_DDC_ERROR, 0);
+	regcache_mark_dirty(adv7511->regmap);
+}
+
+static void adv7511_power_off(struct adv7511 *adv7511)
+{
+	__adv7511_power_off(adv7511);
+	if (adv7511->info->has_dsi)
+		adv7533_dsi_power_off(adv7511);
+	adv7511->powered = false;
+}
+
 static void __adv7511_power_on(struct adv7511 *adv7511)
 {
 	adv7511->current_edid_segment = -1;
@@ -355,30 +379,6 @@ static void adv7511_power_on(struct adv7511 *adv7511)
 	adv7511->powered = true;
 }
 
-static void __adv7511_power_off(struct adv7511 *adv7511)
-{
-	/* TODO: setup additional power down modes */
-	if (adv7511->info->hpd_override_enable)
-		regmap_update_bits(adv7511->regmap, ADV7511_REG_POWER2,
-				   ADV7535_REG_POWER2_HPD_OVERRIDE, 0);
-
-	regmap_update_bits(adv7511->regmap, ADV7511_REG_POWER,
-			   ADV7511_POWER_POWER_DOWN,
-			   ADV7511_POWER_POWER_DOWN);
-	regmap_update_bits(adv7511->regmap,
-			   ADV7511_REG_INT_ENABLE(1),
-			   ADV7511_INT1_DDC_ERROR, 0);
-	regcache_mark_dirty(adv7511->regmap);
-}
-
-static void adv7511_power_off(struct adv7511 *adv7511)
-{
-	__adv7511_power_off(adv7511);
-	if (adv7511->info->has_dsi)
-		adv7533_dsi_power_off(adv7511);
-	adv7511->powered = false;
-}
-
 /* -----------------------------------------------------------------------------
  * Interrupt and hotplug detection
  */
-- 
2.43.0

