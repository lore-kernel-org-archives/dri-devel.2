Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8027C982D8
	for <dri-devel@archiver.kernel.org>; Sat, 19 Sep 2026 18:10:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C5DC10E130;
	Sat, 19 Sep 2026 18:10:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q/7NYrKP";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71D9410E130
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 18:10:04 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e721b5503so17134225e9.0
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 11:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789841403; x=1790446203; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TYG31FNdE+jTjB9/DDoxQaNK7idCKtZmhwSMIq4k/44=;
 b=Q/7NYrKPKNK/f4g51cEEVRi/yKRnXHxqhJfvCk99splDQi4BC56E3UIjxFv9uYIUIx
 Dmia/8u4IDpKDXRMCdPpu3oIlyad+b4u9QyUIhMabNGpt+2IZR1si2V5K1o1KM6yYLUO
 9VA/pOwcgcM51keqWnsujb4nvYfhAVhrl8LpOgYBNnu0FLr609TfcNSr9zhKPG0XWaUE
 N/YBKvcVSUYktNYZGsTtzK/3qwDpNoTt0p6p7ca/xK5CrNey1un8Wv/Nl2NeiLfCPQp/
 DDvavi33xhJARYh0uJqy4T+mNIsskmHp2QTYwowy/hnG+aFqGVEmUXFC6wWo+zw06F47
 HdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789841403; x=1790446203;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TYG31FNdE+jTjB9/DDoxQaNK7idCKtZmhwSMIq4k/44=;
 b=0laPzaDy94VhGQDOCiKTwBhDZkwtUcZT8HcUQoJqsbWPTBfZOIMyyX/e7YY4CHemIb
 qwnTs9q4yPhrRJ6lFlJrSRqM6QUaEJdxBcfjv20shpGzsM67HxxQbK3vbwbniCRDKSqd
 V/+lZ2f51yHNfc1tvAmrybuAcZB6z3br7BfpeimYXjrVS17klBbePSAaQ+KSuF0OuY8S
 BztKqHn3Jnz9h6luEzdDM587zwho+KK/v9eiloVyK0fK25yJ/yYFhIgEALxPUkuqvfCx
 EKSNU4gOjRoaVB/2GgYYxwK0TUkP6QDCvhfph77030FiWaSY0HoAYgyc5YHRGDaYukcl
 Zk6A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzVdXHiVngodJiTwdbg2CrEK5F0ulvNIqAExJWKgRwWzSLOX7pLz7Q1GyDXh5Syhm4m7hx8leYP0Vo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kjVlsmC2hz2x+3c6p/GWF6/Dpb1v4i1FKR83Rtc0z0COAOPpEe
 9NsifdteHsFpvnbLiAnp5ihM4CXeJTwcR/pMKmppKlM28a2qb7ltetpH
X-Gm-Gg: AYBFou1NBE3b1OoI4LXwX+5s73qZm9/oKUA3naO9RooZgkAQv/wxoPKjYC14ZtKVOwG
 NU89izIO7MqBdbMP+Vx4RuE0TAqrukygwpc3WFhp3RgNZBoxE0hSRWku/osEgzHTE0ITE/jYH05
 BxGBiK9/VneON9MIjTLyXoLm+9BwIPlTWtYnmOtX5NPDQhm7nKyaCA0NYVlFctLn/IPXlDVivQh
 1Eb0wPQVxxxHTNDUHWY6L9fcM36q7Vy8bKBRMiYWGo2aW0YkVSvasgxa0wjMemhz3RXYa/4dVj4
 vKZdCsxOZtQWddhWghLnx0PCyY7AXkI6BdzD/0WxqtH2VCj6X92EhNbEchq3hKgI+VaLZ1IWWB5
 7ioLnHP9IKyMwrtyNCMX0J6w/8CpQShpTf3P6uvHQUTiP0v83/Q8lv0PQPt5tclYkL6uz6PyZEI
 wVqLBnkLXbO15iQtyLQ+n5wJAa0EY/gE7Re5uzWDebDyjb4IFXvP8Nnsn7A9B89k4MOT0W+ExrB
 P8F3QfqhWWisC0gA7YJevK4kl8FOVLKDjvSDyAnSUdjg8ZY/Fz0
X-Received: by 2002:a05:600c:8518:b0:49d:28c4:b304 with SMTP id
 5b1f17b1804b1-49fc5741563mr88035205e9.29.1789841402488; 
 Sat, 19 Sep 2026 11:10:02 -0700 (PDT)
Received: from fedora ([202.47.63.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fcd074336sm88631595e9.8.2026.09.19.11.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 11:10:02 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Muhammad Bilal <meatuni001@gmail.com>, stable@vger.kernel.org,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>,
 dri-devel@lists.freedesktop.org (open list:DRM PANEL DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/panel: tdo-tl070wsh30: Remove panel on attach failure
Date: Sat, 19 Sep 2026 23:09:44 +0500
Message-ID: <20260919180945.249571-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
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

tdo_tl070wsh30_panel_add() calls drm_panel_add() to link the panel
into the global panel_list before tdo_tl070wsh30_panel_probe() calls
mipi_dsi_attach(). The panel object itself is allocated with
devm_drm_panel_alloc(), which only arranges for an automatic
drm_panel_put() (via devm_add_action_or_reset()) when the DSI device
is torn down; unlike devm_drm_panel_add(), it does not call
drm_panel_remove() for you.

If mipi_dsi_attach() fails, probe() returns the error directly:

	return mipi_dsi_attach(dsi);

Once probe() returns an error, the driver core releases devres
resources for the device, which drops the allocation's own
reference. But drm_panel_add() had already taken its own reference
and linked panel->list into the global panel_list, and nothing
undoes that. The panel is left registered in panel_list pointing at
a device that failed to bind, where it can still be found and
dereferenced by later lookups/iterations such as
of_drm_find_panel() or find_panel_by_fwnode().

Call drm_panel_remove() when mipi_dsi_attach() fails, mirroring what
tdo_tl070wsh30_panel_remove() already does on the normal teardown
path, and matching the pattern used by other MIPI-DSI panel drivers
that pair a manual drm_panel_add() with mipi_dsi_attach().

Fixes: cf40c6600592 ("drm: panel: add TDO tl070wsh30 panel driver")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
index fa961abdd2d7..32f2dd2bcee7 100644
--- a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
+++ b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
@@ -179,7 +179,11 @@ static int tdo_tl070wsh30_panel_probe(struct mipi_dsi_device *dsi)
 	if (err < 0)
 		return err;
 
-	return mipi_dsi_attach(dsi);
+	err = mipi_dsi_attach(dsi);
+	if (err < 0)
+		drm_panel_remove(&tdo_tl070wsh30->base);
+
+	return err;
 }
 
 static void tdo_tl070wsh30_panel_remove(struct mipi_dsi_device *dsi)
-- 
2.55.0

