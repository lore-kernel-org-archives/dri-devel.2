Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F542C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 19:04:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9A6E10E122;
	Mon, 20 Jul 2026 19:04:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NLwdmr9G";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA20110E18E
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 11:53:04 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-47f785467faso516522f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 04:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784548383; x=1785153183; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7plU2/kVmQSn+LOCEtFWHQX2WddsHW3wUI2HcoGLNVg=;
 b=NLwdmr9GDgjM7M1bDSFPZEOnlmeFOLGRPchhw6ghGyNjnhNYUvTrmnX9G63tfuw4tX
 2xEBnm6VWBHmQpKJUyOlnxQyE3+ScgV6zjDoBLC5Yne9WoMlFixtPob+2HBevhxUX35+
 Dw+pTfAowzWi2iWGiCtSf+KqA9gV6+Pk3mhk0nQngnipe28tXR9huzCZpjlaPfO01A5y
 kLMrrxWpk5cwMO9ObYiNpilSrhmqUeoLcuTp7azZqa2ozoamMwzsY0UGIWOd/5EHXGcO
 hedH2Alo5ACck9JGPxosMbzKVslGPTNGEmKYMSjnUTkOUxP3A6BFqVgtD4K6KOaGkQ+H
 PPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784548383; x=1785153183;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7plU2/kVmQSn+LOCEtFWHQX2WddsHW3wUI2HcoGLNVg=;
 b=iX63yYyk3KBsdW7xju7pJYzQl5oTbDTFfAGZMZhnIUPUoUZ+K1s6EEbiWgiqk+q30r
 vV4A+wey7qp2wR/69wnLG1G9Si23GxrX2VtKeL7QMKHS81v2Ce0YoKpcLfRkT/FYsgbP
 d+PXXExymNV2iWYsf7VY4m5SR3lackkrX3HJjE3PEu4nsLShIkoD0ofa050hOQ03a9II
 q5UqKhimgxeDQoVdcT9EUmE/P1DZF0CnAiBzWov3XsHBVSsQUDME1QEx9l3jvDR944JE
 tcLrmEt39a7PBTpKfMrCG3zaxyhVy1F2u5bUF+vLzXMi4bYkrzVb60OOMQRmeJM16e+g
 iJeg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro7XfeaU1FPirpPZxo2ggnh3S3DzAT/kkpp2cMeTQ4uyhAG1mMs+j81mSR64ztbMR79nnd1bHbOj5Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxfkC/oTu0ihNT/xX2dw+Q/Z8qVVgwasLXQqA+DbS7k3FAGI83S
 txZJDiZoEI9ygmO/tHPNdlM2Y0Dxsl7n0QcZx0DiVxDy4rl7ZlpVULvA
X-Gm-Gg: AR+sD11S9vJOg9EeNszDWL/NmdoMo0HnObhOib7RNwohEB7bqfkDUxb0UtAxCBA5CMl
 JZxXZMEklQy24MxDih6/npjZm42Ys0QiXFyAoI1RnItwcZpM4VjOMMNmlZMVdWu4YZZ2vpW8/FC
 sIsn1QbuJ9qYmanLkiU9ZN2kAr8tKVyDmc3O5e7TiFQKh8Rm/SA+96+4acHJk3qaDY9CcNGUxSW
 w7lyPs8JkYHHVCngfhvQq1jlQelYXv4W7ERhSEkF4G+oNIVxkJ1QYcz+JTy0eIwnlhtcA3gifF/
 az7GKl9LElVu/XmZbDla69FKp5gyiM/UmQy8ObxPEUflRUOvlVq74LTcvXpiziiDRX+eoXYvK1d
 xKxJGcx6hRIJrQz/GB66Yr+FIi4htOoGZsbTkKmYv4c4ZqqovFdjI3KyQEkA1dLXr2uQR0FzkXW
 abTdDnTJdBTus=
X-Received: by 2002:a05:6000:2613:b0:47f:7114:7d6c with SMTP id
 ffacd0b85a97d-47f71147deamr7069056f8f.44.1784548383122; 
 Mon, 20 Jul 2026 04:53:03 -0700 (PDT)
Received: from fedora ([2a02:2f0a:7305:1100:2d17:dc4a:b635:9a95])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ec7ea1sm30204633f8f.24.2026.07.20.04.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 04:53:02 -0700 (PDT)
From: Robert-Andrei Mercea <robertandreimercea@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Robert-Andrei Mercea <robertandreimercea@gmail.com>
Subject: [PATCH] drm/panel: osd101t2587: migrate to newer mipi_dsi* functions
Date: Mon, 20 Jul 2026 14:51:26 +0300
Message-ID: <20260720115126.666363-1-robertandreimercea@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 20 Jul 2026 19:03:49 +0000
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

Migrate osd101t2587-53ts panel driver from deprecated mipi_dsi*
functions to their *_multi variants for improved error handling, as
specified in the GPU subsystem TODO list.

Link: https://docs.kernel.org/gpu/todo.html#transition-away-from-using-deprecated-mipi-dsi-functions

Signed-off-by: Robert-Andrei Mercea <robertandreimercea@gmail.com>
---
 drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c b/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
index 2334b77f348c..63ae9dc5712f 100644
--- a/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
+++ b/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
@@ -32,11 +32,11 @@ static inline struct osd101t2587_panel *ti_osd_panel(struct drm_panel *panel)
 static int osd101t2587_panel_disable(struct drm_panel *panel)
 {
 	struct osd101t2587_panel *osd101t2587 = ti_osd_panel(panel);
-	int ret;
+	struct mipi_dsi_multi_context ctx = { .dsi = osd101t2587->dsi };
 
-	ret = mipi_dsi_shutdown_peripheral(osd101t2587->dsi);
+	mipi_dsi_shutdown_peripheral_multi(&ctx);
 
-	return ret;
+	return ctx.accum_err;
 }
 
 static int osd101t2587_panel_unprepare(struct drm_panel *panel)
@@ -58,13 +58,11 @@ static int osd101t2587_panel_prepare(struct drm_panel *panel)
 static int osd101t2587_panel_enable(struct drm_panel *panel)
 {
 	struct osd101t2587_panel *osd101t2587 = ti_osd_panel(panel);
-	int ret;
+	struct mipi_dsi_multi_context ctx = { .dsi = osd101t2587->dsi };
 
-	ret = mipi_dsi_turn_on_peripheral(osd101t2587->dsi);
-	if (ret)
-		return ret;
+	mipi_dsi_turn_on_peripheral_multi(&ctx);
 
-	return ret;
+	return ctx.accum_err;
 }
 
 static const struct drm_display_mode default_mode_osd101t2587 = {
-- 
2.55.0

