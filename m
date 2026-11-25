Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED32606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=alessandro.zini@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=VdHVFlvm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55C501120DB;
	Thu, 26 Nov 2026 08:09:02 +0000 (UTC)
X-Greylist: delayed 602 seconds by postgrey-1.36 at gabe;
 Wed, 25 Nov 2026 10:29:55 UTC
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85EFE10FB06
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 10:29:55 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 2026112510195163cecdbf3400020763
 for <dri-devel@lists.freedesktop.org>;
 Wed, 25 Nov 2026 11:19:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alessandro.zini@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=P/qDb93psmYu3KOkMzDXsv4Tt820FhpXDB93gJkIxRo=;
 b=VdHVFlvmptoJBl8kFclQTPJVqz3lFkwBHmleZQHxH259bD+Nu1G1DlRxcGwmfukZNI6xF6
 9cTdmyh88nf7A5See8uN3VHxIdTe1cciwnYiSzvu8HUsNqN77EMDhYvnmzo9JcFksrnzw4Au
 pCe85Zm77HV2eodV3347MtnA4wyNjLrHPd5TL/z+zP+fP7e+GgYvpswv3/9fYZaV66is5cv5
 SR0cQCmsFEmlOaAGT1sMoByhqspWD20MO2aRErawz6Kb94dTy0T2+liiMRROItLnGM6GXCQA
 zNu8Z9zRNf33FXK3u3dt6CyHoDU9kvE0eoc2tQKrPmfXdUg58GJpvUyA==;
From: Alessandro Zini <alessandro.zini@siemens.com>
To: neil.armstrong@linaro.org, jesszhan0024@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, thierry.reding@gmail.com,
 sam@ravnborg.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, Andrej Valek <andrej.v@skyrain.eu>,
 Alessandro Zini <alessandro.zini@siemens.com>
Subject: [PATCH 3/3] drm/panel: simple: Add support for Techshine TS-P0700031A
 panel
Date: Wed, 25 Nov 2026 11:19:36 +0100
Message-ID: <20261125101936.103094-4-alessandro.zini@siemens.com>
In-Reply-To: <20261125101936.103094-1-alessandro.zini@siemens.com>
References: <20261125101936.103094-1-alessandro.zini@siemens.com>
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

From: Andrej Valek <andrej.v@skyrain.eu>

Add display timing and panel descriptor for the Techshine TS-P0700031A
LCD panel.
Register the panel in the of_device_id table with the compatible string
"techshine,ts-p0700031a".

Signed-off-by: Andrej Valek <andrej.v@skyrain.eu>
Signed-off-by: Alessandro Zini <alessandro.zini@siemens.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 32 ++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 33d954f3ee289..8eda4f74bc44f 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -4827,6 +4827,35 @@ static const struct panel_desc tsd_tst043015cmhx = {
 	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE,
 };
 
+static const struct display_timing techshine_ts_p0700031a_timing = {
+	.pixelclock = { 44900000, 51200000, 63000000 },
+	.hactive = { 1024, 1024, 1024 },
+	.hfront_porch = { 16, 160, 216 },
+	.hback_porch = { 160, 160, 160 },
+	.hsync_len = { 1, 1, 256 },
+	.vactive = { 600, 600, 600 },
+	.vfront_porch = { 1, 12, 127 },
+	.vback_porch = { 23, 23, 23 },
+	.vsync_len = { 1, 1, 128 },
+	.flags = DISPLAY_FLAGS_DE_HIGH,
+};
+
+static const struct panel_desc techshine_ts_p0700031a = {
+	.timings = &techshine_ts_p0700031a_timing,
+	.num_timings = 1,
+	.bpc = 8,
+	.size = {
+		.width = 165,
+		.height = 105,
+	},
+	.delay = {
+		.enable = 25,
+		.disable = 25,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
 static const struct drm_display_mode tfc_s9700rtwv43tr_01b_mode = {
 	.clock = 30000,
 	.hdisplay = 800,
@@ -6179,6 +6208,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "team-source-display,tst043015cmhx",
 		.data = &tsd_tst043015cmhx,
+	}, {
+		.compatible = "techshine,ts-p0700031a",
+		.data = &techshine_ts_p0700031a,
 	}, {
 		.compatible = "tfc,s9700rtwv43tr-01b",
 		.data = &tfc_s9700rtwv43tr_01b,
-- 
2.56.1

