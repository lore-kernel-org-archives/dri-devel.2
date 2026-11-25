Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B427606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=alessandro.zini@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=erNPrA3h
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06402112106;
	Thu, 26 Nov 2026 08:09:36 +0000 (UTC)
X-Greylist: delayed 601 seconds by postgrey-1.36 at gabe;
 Wed, 25 Nov 2026 10:37:34 UTC
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8A0810E0BF
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 10:37:34 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 20261125102731edbf9f68340002073a
 for <dri-devel@lists.freedesktop.org>;
 Wed, 25 Nov 2026 11:27:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alessandro.zini@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=TM1ZXV+pZoDHqfR9xCDgo0xwUmHUJWJgxll9qgsqzgA=;
 b=erNPrA3h+YmaySWBY/xROvYldf0EsClbrWgI0YK/E52f3XofRbF+psmhab4lHT+aBUNWym
 T2ecR5AYtOIHlajlVJm0cAb3fUi6snmO8ydj5L9SRibOpYGccFw8T3Ho0npTIzkursiNIwaU
 rP2PCSRfSJ2BngKZCRU8h4CAxjNvhsEc2/v5NKEieXow+ga4QEY4b+nsGF/slU/9qPQXPiqt
 em517uUwAvNFVhrXS/MMBk8Ufy2S6ynbPq+6BxICwGKMJdluOrmayeUsQHaDuP1yPGPPBUSf
 egQWJADGDW2qAV8xa0l8a7vJDK7mDbVk/0CJp6+VUY+2WVJ7PcR5Eamw==;
From: Alessandro Zini <alessandro.zini@siemens.com>
To: neil.armstrong@linaro.org, jesszhan0024@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, thierry.reding@gmail.com,
 sam@ravnborg.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, Wang Yang <yang.wang-wy@siemens.com>,
 Alessandro Zini <alessandro.zini@siemens.com>
Subject: [PATCH 3/3] drm/panel: simple: Add support for Goworld ILI6150H6 panel
Date: Wed, 25 Nov 2026 11:27:00 +0100
Message-ID: <20261125102700.126248-4-alessandro.zini@siemens.com>
In-Reply-To: <20261125102700.126248-1-alessandro.zini@siemens.com>
References: <20261125102700.126248-1-alessandro.zini@siemens.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1327013:519-21489:flowmailer
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:08:59 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wang Yang <yang.wang-wy@siemens.com>

Add display timing and panel descriptor for the Goworld ILI6150H6 LCD
panel.
Register the panel in the of_device_id table with the compatible string
"goworld,ili6150h6".

Signed-off-by: Wang Yang <yang.wang-wy@siemens.com>
Signed-off-by: Alessandro Zini <alessandro.zini@siemens.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 32 ++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 33d954f3ee289..9beba399119cc 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2543,6 +2543,35 @@ static const struct panel_desc giantplus_gpm940b0 = {
 	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE,
 };
 
+static const struct display_timing goworld_ili6150h6_timing = {
+	.pixelclock = { 44900000, 51200000, 63000000 },
+	.hactive = { 1024, 1024, 1024 },
+	.hfront_porch = { 16, 160, 216 },
+	.hback_porch = { 160, 160, 160 },
+	.hsync_len = { 1, 1, 256 },
+	.vactive = { 600, 600, 600 },
+	.vfront_porch = { 1, 12, 127 },
+	.vback_porch = { 23, 23, 23 },
+	.vsync_len = { 1, 3, 20 },
+	.flags = DISPLAY_FLAGS_DE_HIGH,
+};
+
+static const struct panel_desc goworld_ili6150h6 = {
+	.timings = &goworld_ili6150h6_timing,
+	.num_timings = 1,
+	.bpc = 8,
+	.size = {
+		.width = 154,
+		.height = 85,
+	},
+	.delay = {
+		.enable = 25,
+		.disable = 25,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
 static const struct display_timing hannstar_hsd070pww1_timing = {
 	.pixelclock = { 64300000, 71100000, 82000000 },
 	.hactive = { 1280, 1280, 1280 },
@@ -5921,6 +5950,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "giantplus,gpm940b0",
 		.data = &giantplus_gpm940b0,
+	}, {
+		.compatible = "goworld,ili6150h6",
+		.data = &goworld_ili6150h6,
 	}, {
 		.compatible = "hannstar,hsd070pww1",
 		.data = &hannstar_hsd070pww1,
-- 
2.56.1

