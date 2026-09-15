Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD26EC88E7F
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:00:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1742A10FC01;
	Tue, 15 Sep 2026 15:00:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M99QbR1h";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96AAB10FC01
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 15:00:07 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4858bc96fabso2337803f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 08:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789484406; x=1790089206; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bJdJD3QqQwQMMkyFiv3mcDmZ+uwdZyV40+weLnHsOGM=;
 b=M99QbR1hnKuO79QS6GS1Wob/6R79r/YRFwwfPsGVjVyQ31FTJYiy6ByzX16EO8oK/D
 4QIRVsv/ZKoGvVbR6cOLtE/aVrSM4e/TTQXvX7M9S3lUKL34mYXYaFJmtpHfS0IU53Wz
 ZsK4OZxwrTY3SLPh7Dknk+wXXO8x4XUGhz/feCOvQl4m9TCmW+V6I6BYUmECEySDO6G2
 wPwV57pIuH5Aq9boHSccT0x8iyAiUh5BFTnyhiw1lZfClT7JC32n/i6xZBHCPo3nu64B
 7xBhGAzeh+xmoIJGXZCe8s4959NWvKPTwHVX4WW8qZBgOtKZKQ94PG9+6WZFXNqGs3Yk
 pT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789484406; x=1790089206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bJdJD3QqQwQMMkyFiv3mcDmZ+uwdZyV40+weLnHsOGM=;
 b=ENrvS4WraVPDCXT1pyaMkYmBy1g8W1aKcWfqmlEQhWq14lgFPlYzExXnM5zJgtQHut
 ECyymcKrJK0g+/8s2CR3WnC5DB81oSqdDZyrbGN8fzcQJ0WljOFF7fPrF5HnZEtTX/43
 NOxlbBYwlZsHzosS6nxBwnl8NnP2Jb5fAjt+syW4qValytvcTUzRVu4W2DtX5+0Z4saG
 ySRyFX/QHSqYpW/a0NRfG2CK2A9UFbx1q2mhyJXSQpB+Sm1q1SHMk+UZkZaV+cvKeSNe
 QH00Z1plm2ghc21iBjXQiDWDeXC3Z39IdwCwcFR742unHHsgLGUxSvchgw56EUFtukXO
 f4WA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw9MN3Xcp9RDpjpEW1RwBr38eU0NOYvfvuQwywIvSBQ8UldAv71z6S+pvDMTkRAs9fR6Krohldo/Mw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mLqoFecy1+Zpzj34TB5lzBKIHgbazC/0pTQPkLck/dZSMyNLD/
 aPGiHXt5gz4xLLG9oJWTXTYEUWXjbbbN/nT5vdu7LHJCEVoMkdQcXRby
X-Gm-Gg: AYBFou3N3cZjUtpIi0wkbWOH3VhRrTzEgewthLVw/+bKv2cO+LbDDeA0YG/B9vhXgTn
 v1C9/ziB3kKYqV7wrLlKsPS8tAL5y0GNLmdo9tl7mit9Ng2Vd+GAi+2HvFnjcu7HLMXQh0l/e0V
 Q5cnMLkH76imsh6pxXLAxZxX0uqLrYXfz2AwoEUp95+qKJ4G3VvauEgTXWaQYO870ahEMv9SIki
 Pe+lIkk7d2NPN4063FI4JFZpceWNpSrhqpEcsO/2G9WjAulFrxI9Wy6bIKLvq/yeMvB5dbAcBAd
 1IDftbZ15MOhA1yq6lTmLsUnU/XIMQCHiUGwYu4wzLDWdrCkF8m6nkVoqn4RBzwDu6fAv8D9BFy
 6PxPga1KdrqvA8yP5Oj2KyFbG6ZrR7df0LP7qIaK3kvsiALy/H3yLWgE1yfh8eM5rgoLZHxvEbf
 2HIJQ70icuPlOvuO8gof0SBW260fvURF4Ii3TrUEVbpviNVAqctyjiEl9kz6o0ygJSDP3HveYww
 CI0Pi4l3meCZ1nJOGDiOVvzsc0SNj6Zzg==
X-Received: by 2002:a05:6000:41f1:b0:487:882:5de3 with SMTP id
 ffacd0b85a97d-487088261f9mr3482941f8f.25.1789484405865; 
 Tue, 15 Sep 2026 08:00:05 -0700 (PDT)
Received: from osama.. ([156.223.70.89]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48707e00133sm5081128f8f.11.2026.09.15.08.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 08:00:05 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: luca.ceresoli@bootlin.com, Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH v5 4/4] drm/panel: simple: Use managed helpers in panel-simple
Date: Tue, 15 Sep 2026 16:59:31 +0200
Message-ID: <20260915145935.60397-5-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915145935.60397-1-osama.abdelkader@gmail.com>
References: <20260915145935.60397-1-osama.abdelkader@gmail.com>
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

Use the managed panel add helper in panel-simple and drop the manual
panel remove call from the remove path.

Keep the MIPI DSI attach and detach manual, since panel-simple's
remove callback also unprepares/disables the panel and releases the
DDC adapter; deferring the detach to devm would run it after that
cleanup instead of before, changing the teardown order.

Suggested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index c95964ba25a9..02d21dde5766 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -737,7 +737,9 @@ static struct panel_simple *panel_simple_probe(struct device *dev)
 		goto disable_pm_runtime;
 	}
 
-	drm_panel_add(&panel->base);
+	err = devm_drm_panel_add(dev, &panel->base);
+	if (err)
+		goto disable_pm_runtime;
 
 	return panel;
 
@@ -785,7 +787,6 @@ static void panel_simple_remove(struct device *dev)
 {
 	struct panel_simple *panel = dev_get_drvdata(dev);
 
-	drm_panel_remove(&panel->base);
 	panel_simple_shutdown(dev);
 
 	pm_runtime_dont_use_autosuspend(dev);
@@ -6540,7 +6541,6 @@ static int panel_simple_dsi_probe(struct mipi_dsi_device *dsi)
 {
 	const struct panel_desc_dsi *desc;
 	struct panel_simple *panel;
-	int err;
 
 	panel = panel_simple_probe(&dsi->dev);
 	if (IS_ERR(panel))
@@ -6551,14 +6551,7 @@ static int panel_simple_dsi_probe(struct mipi_dsi_device *dsi)
 	dsi->format = desc->format;
 	dsi->lanes = desc->lanes;
 
-	err = mipi_dsi_attach(dsi);
-	if (err) {
-		struct panel_simple *panel = mipi_dsi_get_drvdata(dsi);
-
-		drm_panel_remove(&panel->base);
-	}
-
-	return err;
+	return mipi_dsi_attach(dsi);
 }
 
 static void panel_simple_dsi_remove(struct mipi_dsi_device *dsi)
-- 
2.43.0

