Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8DF606A32D
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 13:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yh/6GoTj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EFEE10E115;
	Sat, 14 Nov 2026 13:57:55 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0514910E115
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 13:57:50 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-6b596569640so4236318a12.1
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 05:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794664668; x=1795269468; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=I1BkrDs+HovYsgHM3nZ2gQpbCc0PGvvE+im9VACCnKE=;
 b=yh/6GoTjIFewUbd55bGTZwr5D0VdVGXLaBhwD5J4nZa8X/3sYDWev6JK23e9O7b920
 f+uUr8COX39o0AveUrWNE60iXJ0W+NRhY/TqJhwZ65VpwsWfeP5PIt0qdk1V9ozLF+SM
 OmQSP6bMhv13p0PZMn+JllXB19spHlywptr4/W46zYf581Z2eQ7DTWPLsQUqUR3r70CT
 bh5wpxEBSNTEh+YLOjJGhir2L4p23u1wBfIdiFoHNcMLYVOJhRwN2v4lDclFrMgBUzOd
 xLeuI79Oz4XvcEaoC50Q9WXh/9AV1/jyJCA/5+98q34WBQoGoWPCnv+sCvkS+csQ2uTC
 iTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794664668; x=1795269468;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I1BkrDs+HovYsgHM3nZ2gQpbCc0PGvvE+im9VACCnKE=;
 b=Ib0FAJQSdhvFhQuZWOJNPkrdb9HVHwrKp7lJk2reRZlzSRgsOIY59MkPP57qrQKQcu
 fIqxe2CD8AhwkgU0fmBRhIKC6y2X+YqpwSYu4nQJJMMVbcmGI9GyyGbPygftLD6/P184
 Y7eAM+ICe7fs897XS1df15+YI8yRt+mmNJS3q0R1y70FLSUFIN+u37nfg2DgJ0rMLYbc
 LBLbBHR8Rd3o4hod2Fg7R1Q/0Z4VGTFRvk0eVpP8XPf+o5/kmXHJW2vdm0zsPdw+WNx7
 dKWomoZLM0lKWD1Q4JQid5upukmY/6Y9QjHj9zTEAn/iAW7fC+jqeHrO6id+WP/wcVdV
 WZqQ==
X-Gm-Message-State: APuU4Z/7M9Qw5dmXRHJv4xjs4FY6Zhv7NQm1iN1TE/HrtBdkB4vQbb15
 yZc7k+vc6lV68D8iJydsBzHIVqoeWkINNvNiJDa98i5wABLyM4dY1PZV
X-Gm-Gg: AYBFou2vcIaoTZE/d375wytCVxHt7aLwCQoPIYuu8J0c63SlmvSCC6RFNBh8n1gyODq
 PKmTCHK0FYj9fOX+tyVTEEVCxDiu+seg1JJoAreaGdGOxayiWz3LDtcPU8VC2PgkPDHjYxBKA0m
 i7kRHnx0Uw2QYhyAD7QE5S9Bnm3REsGT5zpYSVVGlP7WH/t6BsUrF+ir6BPEsqJgsSU2ZhVFo4V
 8/+BxFTudqLJlLnUkicGteSUrimW4TgNSzMH4TreT82z/nUyQVjBJ5yOwHRLJMDdhLsR7bc1kYv
 qfiI6JtQBvL+J0ZZpbnt2vr9s7eF/2OagZrtEAlWMIHWOz25ZNb05fxFv11RS00tQwvEOXq52bn
 uZhFjn4EYGZoYv0u0/a6EW09EqSYpjTVNBmh4ApVyESo16N997Wzc46RX+caUgHPaL4198jOW+Q
 eGiouiadGlnXJQ1798pNjLQEX86aHo9bcWfymhKsRZqWyRp8GpzvxdsT5KHTqc1E/yr1p+Nr7Yq
 v3ZDihr/32eJLtxY6INJvNgWsNMfa3f/ltGtwdxi7KENd7pib6g0m7wEyxQmNQgtUuk1PUyOJUG
 itIVe9LmrXyfgLnSpU5M8amsjmx2uHBXB2m68hLQwo0LWzHjCzcFBoC2uWsc/BDNEipvFlIAyez
 lnQgoCrdK/Q==
X-Received: by 2002:a05:6402:5412:b0:6b7:d189:6041 with SMTP id
 4fb4d7f45d1cf-6b7d18963c2mr3488558a12.2.1794664668038; 
 Sat, 14 Nov 2026 05:57:48 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b7c23db711sm2231929a12.24.2026.11.14.05.57.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 05:57:46 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] drm/panel: panel-lg-ld070wx3: Add support for
 get_orientation() op
Date: Sat, 14 Nov 2026 15:57:17 +0200
Message-ID: <20261114135717.142047-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement the get_orientation() operation using a standard helper. The
Nvidia Tegra Note 7, which uses this panel, has it mounted with a
180-degree rotation, making this change essential for the device correct
work.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpu/drm/panel/panel-lg-ld070wx3.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-lg-ld070wx3.c b/drivers/gpu/drm/panel/panel-lg-ld070wx3.c
index 0280addb6500d..eed1dc1e1bc31 100644
--- a/drivers/gpu/drm/panel/panel-lg-ld070wx3.c
+++ b/drivers/gpu/drm/panel/panel-lg-ld070wx3.c
@@ -11,6 +11,7 @@
 #include <video/mipi_display.h>
 
 #include <drm/drm_mipi_dsi.h>
+#include <drm/drm_of.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_probe_helper.h>
@@ -24,6 +25,7 @@ struct lg_ld070wx3 {
 	struct mipi_dsi_device *dsi;
 
 	struct regulator_bulk_data *supplies;
+	enum drm_panel_orientation orientation;
 };
 
 static inline struct lg_ld070wx3 *to_lg_ld070wx3(struct drm_panel *panel)
@@ -110,10 +112,18 @@ static int lg_ld070wx3_get_modes(struct drm_panel *panel,
 	return drm_connector_helper_get_modes_fixed(connector, &lg_ld070wx3_mode);
 }
 
+static enum drm_panel_orientation lg_ld070wx3_get_orientation(struct drm_panel *panel)
+{
+	struct lg_ld070wx3 *priv = to_lg_ld070wx3(panel);
+
+	return priv->orientation;
+}
+
 static const struct drm_panel_funcs lg_ld070wx3_panel_funcs = {
 	.prepare = lg_ld070wx3_prepare,
 	.unprepare = lg_ld070wx3_unprepare,
 	.get_modes = lg_ld070wx3_get_modes,
+	.get_orientation = lg_ld070wx3_get_orientation,
 };
 
 static int lg_ld070wx3_probe(struct mipi_dsi_device *dsi)
@@ -133,6 +143,10 @@ static int lg_ld070wx3_probe(struct mipi_dsi_device *dsi)
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "failed to get supplies\n");
 
+	ret = drm_of_get_panel_orientation(dev->of_node, &priv->orientation);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get orientation\n");
+
 	priv->dsi = dsi;
 	mipi_dsi_set_drvdata(dsi, priv);
 
-- 
2.53.0

