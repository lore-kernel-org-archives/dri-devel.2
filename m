Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3D1606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 21:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jt+7an0D
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2609010E480;
	Sun,  1 Nov 2026 21:25:20 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA8A910E47D
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 21:25:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7239C41068;
 Sun,  1 Nov 2026 21:25:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537CA1F000C1;
 Sun,  1 Nov 2026 21:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793568310;
 bh=RzyFOrpIsCiM4ZgTKvzzRSVs5Ku4gtmX/tafw+J41nE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Jt+7an0Drh8dL410RJ39tivJI1L2RAbfIp7yU6zn5o2FdznHXreoH285wvXzN4ISM
 mMS0RptModKAY5uBDWLKR29C0hqlDVqFinqzixsE+pxIGM4dgry++VZxxGdWH7BG9z
 X+LYAHLwQ9hImzFSYemWLg5nDCbRJfjgY7uhnXBUko7M88xPYX6jKM9keHOy9UlzLJ
 BXrWh7t0VvfKd4XVwzDuUXZMPTGr39+gzbRZBKGfnW0STeOLCIihIz25KHJFMlE2kq
 B3hHhFOSRtt/zhzsnE89xzpecpTK0Em8i5fT5upcO3FUvQPyDrH2lbGhOP4z3pR7Dy
 uL5Ou0GMREcvg==
From: Vladimir Zapolskiy <vz@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
Subject: [PATCH 1/2] drm/panel: visionox-r66451: Send the brightness value MSB
 first
Date: Sun,  1 Nov 2026 23:24:57 +0200
Message-ID: <20261101212458.2431191-2-vz@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261101212458.2431191-1-vz@kernel.org>
References: <20261101212458.2431191-1-vz@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The panel expects to get two bytes of the DCS Set Display Brightness
command with the most significant byte first, and it uses the lower
12 bits of the value, use mipi_dsi_dcs_set_display_brightness_large()
to correct the programmed brightness values.

Tested on the SM8350-HDK display card, the display brightness increases
gradually with:

  for v in $(seq 16 16 4095); do sleep 0.1; \
    echo $v > /sys/class/backlight/ae94000.dsi.0/brightness; \
  done

while without the change the display is dark during all writes.

Fixes: a6dfab2738fc ("drm/panel: Add driver for Visionox r66451 panel")
Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>
---
 drivers/gpu/drm/panel/panel-visionox-r66451.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-visionox-r66451.c b/drivers/gpu/drm/panel/panel-visionox-r66451.c
index 1efb139bb711..4f28bd3b6080 100644
--- a/drivers/gpu/drm/panel/panel-visionox-r66451.c
+++ b/drivers/gpu/drm/panel/panel-visionox-r66451.c
@@ -227,7 +227,7 @@ static int visionox_r66451_bl_update_status(struct backlight_device *bl)
 	struct mipi_dsi_device *dsi = bl_get_data(bl);
 	u16 brightness = backlight_get_brightness(bl);
 
-	return mipi_dsi_dcs_set_display_brightness(dsi, brightness);
+	return mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
 }
 
 static const struct backlight_ops visionox_r66451_bl_ops = {
-- 
2.51.0

