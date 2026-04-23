Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DE3FDEE47
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 20:06:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0D2A10F239;
	Thu, 23 Apr 2026 20:06:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N8YrvEym";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D091210F239
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 20:06:38 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so87148525e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 13:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776974797; x=1777579597; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6o8bMAHlpjyh3M9xmgw9hNhMm4y74iIizZKcNnRu+9s=;
 b=N8YrvEymIm6l/wq3TKa+GEq7UENgTRXolPV8cD3MEmZW/OGdleLpEteetnVc5AWZpg
 jo1aATHWmCnuXHCi7dxPczAdZbp67xvX3haZAYZw8U7UhixZ12Epl7DR2xjwIEeLuO0L
 EUVx2wlLhnDh1tbUrAaplsAXgDyQhelf3LqAURCS9uwSb28ax7PE048lFDnaXuvxidxH
 OROTESjMjohWW3ta6qxRtuCA+sCtqHr13aD2IRah1uU+Irf17IymtBY8cdFVw5gZHHKT
 d37sy7oeu1ShNRzF0dZ3FixJBR11qIDWoz5oNSp5JJLeyiN0U5LRunhx1lV7il7Nd7Jt
 HZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776974797; x=1777579597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6o8bMAHlpjyh3M9xmgw9hNhMm4y74iIizZKcNnRu+9s=;
 b=OEAjUSu52V1tycNujMA9iNXctNnJVmrDaAsq1zVhIM2x9ePZByFfC+0g9RVhYERN8K
 Ohz5nJBefNtXFWJw9OoKDAYoNdAM7e9qzbEN0GQBzoKUeYTvTsO9Yv4iEGGRUVuwbkzZ
 flmZnzDQ48hFFXwBGloNESVWyWSOIUG365J/Lm281Y4M/3UJkzS47MOM6ESpssn1oS8m
 TPI3TEWxtxfowGn3OSzAGG4rKWG/qCj5tWFr3STBTXKMeEjLYPwcqJ+6DQOL5scs+PPZ
 iiTtzY6swSQzxg+aY6TLlb+HX2dkUQWdzKnYqqwhAa11S0PKKxleSWRONYhTK8knqrss
 bCWg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/d30NZhIDePOJBV0Lti/S5XEfcMhFi0qOTYUEEAqWMWM3uk6flYynuoksk5tSsIcGuxO2qB4XDj4E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw1LexAHQBDitSNbpWRYFEUu1UCOHZVfgE7hsWHJk3Z73u70Aq6
 cOG5bbMJ4PqUI1StDG0XEOLB3WBQadJ++wpxwwCNU3hMCDNeR8gqUfKo
X-Gm-Gg: AeBDievp/06uK+j458WTCUZd3bsUMIrOHSoVlAHe32Wo/Yt2lDalbFyNB60ZkBdpf9m
 GJ64bBBWkb2M2/LomP2Y/MhAAT3qwCRyDwAaNhIs/IB7eTdU5gOQpFa4HQ0lyfaeVPeAVi0/+Jn
 H9fic+ac5w0zgGt5F2DeJM9kK5nvuHQFRwrGia4UGiwtfkg48zHD185eD686YJv5A1QVDsuIcG1
 YU29/Rlr99vjsznpx0CULyYFjMIzau+95aMl1aRanwr+l/xqr+zbY1wPUl2mjoVlNox/WPFg3hx
 xLtfRer/0mMMeHGVtKga90TOXCoJBJsueL1KIzqBZ3/USjA6Fn7n4Ege3iI3Ipd8K3jwo8ZZdMl
 Bgz/KDPBiUtIl8o9H5FOYoaT9lr4N4gsZKv2rFwWJvwlxiBQ08OaQH7awpQ0DR6iaU/tvX8L8k5
 96hGLtLbHRbuZl1+rbRRga5lZ6nWfEG/MemyJlrik631sUPYea7UP2kGfk4Dh4LcqzxHVCYcc=
X-Received: by 2002:a05:600c:c10e:b0:488:9439:880d with SMTP id
 5b1f17b1804b1-488fb792c69mr299890125e9.29.1776974797287; 
 Thu, 23 Apr 2026 13:06:37 -0700 (PDT)
Received: from osama.. ([2a02:908:1b6:8980:5f44:38d2:bccf:b54f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb75ab25sm167658815e9.11.2026.04.23.13.06.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 13:06:36 -0700 (PDT)
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
 Simona Vetter <simona@ffwll.ch>, Archit Taneja <architt@codeaurora.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 3/3] drm/bridge: megachips: remove bridge when irq request
 fails
Date: Thu, 23 Apr 2026 22:06:21 +0200
Message-ID: <20260423200622.325076-3-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423200622.325076-1-osama.abdelkader@gmail.com>
References: <20260423200622.325076-1-osama.abdelkader@gmail.com>
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

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
Fixes: a68ee76f4a28 ("drm/bridge: megachips-stdpxxxx-ge-b850v3-fw: Fix bridge initialization")
Cc: stable@vger.kernel.org
---
v3: add Fixes and Cc tags
v2: IRQ failure path only (explicit drm_bridge_remove)
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

