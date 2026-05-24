Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C362ACD5BB1
	for <dri-devel@archiver.kernel.org>; Sun, 24 May 2026 16:37:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A44A10E374;
	Sun, 24 May 2026 16:37:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="knlOkAYL";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9334710E374
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 16:37:29 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2baca4df358so54924495ad.2
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 09:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779640649; x=1780245449; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G0HUvMlBgBGQWslCXm5T/VCz5F81Ghf/XcT+I734BSU=;
 b=knlOkAYLNoande8NR0mN23adryNyblnW4smxvXLgjxeCmdEkqYgd9t+PLiWPv+mxR/
 V3aCkJo3irkg2k79uk4IzYbgFL+2AFE22k2Uusk7HpPGNcxkkeVVhtfSajQ26CEx3qCp
 ZPsX1UHg3xjViaRHGnBYC3Ndz6VPA/YpeOFq5wDZdKhv4t116UPao2qk/Ddu1KAM8Fby
 t6iMeUE1lHzFJmwY8QgAO1qGsrc5fA1KHj6GrtfZA8ZECNaLfIjPqhAvMG9SkqsGZT6p
 QyauLeYzMCPjfi+G5Qi3LtzuqY1UtwZ+7FtHJ5aLPXyUCu4JJFMXYCS9FbilNXLwoRQF
 4kow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779640649; x=1780245449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G0HUvMlBgBGQWslCXm5T/VCz5F81Ghf/XcT+I734BSU=;
 b=bcGPtbuBXLP9LMIonnnUAXPRMVSWU58pup9MKjcRGWAvLucTySmg0mxvIhK3NI/wPt
 s3MFd4hz30lkEiMWlvUvfOiPbeNH8jivNn4o95kAD92D+gZOaPeNRfXCPAhq/Sse3bOw
 kI0CaEG/ZKBKfQW0VIa0rekRL7IEUTTLz88PA9fLF5IigLwS41agd8rdTp1Ol0GD5cDW
 uzK6PAat0HXYPv2793oCBTXbWphlaNP7f6ILX/k/WtOEX8dwNqQl4KTuqxu4m+zSMB6O
 kdHCGRPtDH22MV16WQjojHaB4MMrV+Jsu2xHD4Gzy9C1jXJEy/y3dSE7oJkBzT9TEU0Q
 qAgA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Shgbyq72jGywydGrdWaaRvpbxKGLYsLLPw9/vApMi0zFWC/boEhuTHI4bayI+Od0MfH5jMTZdGjw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxgi07/Y6GmX587+wwSz5j1Rr68zX8vJLJ0MxdxAwgI571yKSls
 X/Tp+z+IV/KMqmWjmOAP0JYqsUqoGVUJd1ZjQjP7pmeBkgZewMYxhi4=
X-Gm-Gg: Acq92OEiqJlMnbDcSKe4yTzqkoievQfGc5Dq9aVpFupUmiEiN1dzEupSXPOZ5kU/f4U
 gISL52z+QFhOgXKZad6r3F+HYG6RTDDJccl+4cOiO5dhAfa2fafX+v2hXbKuIthatemzsHFKf3D
 0kc8iJJ9OYvkP2JVZFtrWPq/kbgXlyYHycebM38CGi9PKHLe6d+pi454aosskNo7Z0/lPojkAVw
 MkAmp8GH9QO2d2asmN8RagrYOIwDzbGkurubg77dWNDoazSRje7tH/jCyRtPUH473CTGj0n0ZVC
 /NSJg/x579FsboGqeZzlg9y2HLR01vTDgtsXqamtdCPnYGtUUvH954OoQ3224LFsvjsNSv7aeES
 v8MLt/D1zXXPx4LzFxwwJkcrx7beP6uv552Dtsk78lmqtrT9W2IhWbNWktXQuDv5LUL3lgwmQcr
 BE/Vu9V9erZtfsc4v+yulrshpWVs34SZ4+ffuEG20ehnvRMMsvpJoveIXXJR1C0k+kddA58X/ew
 B43LW3fRw==
X-Received: by 2002:a17:902:d4c4:b0:2b2:4d78:eec2 with SMTP id
 d9443c01a7336-2beb0711965mr114609995ad.18.1779640649048; 
 Sun, 24 May 2026 09:37:29 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb58b309bsm73017325ad.51.2026.05.24.09.37.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 24 May 2026 09:37:28 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jianhua Lu <lujianhua000@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Myeonghun Pak <mhun512@gmail.com>,
 stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Subject: [PATCH 2/2] drm/panel: novatek-nt36523: use devm_drm_panel_add()
Date: Mon, 25 May 2026 01:36:33 +0900
Message-ID: <c6fe4a162692b4df5525353dbdac5b88eda91a79.1779640137.git.mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1779640137.git.mhun512@gmail.com>
References: <cover.1779640137.git.mhun512@gmail.com>
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

nt36523_probe() adds the DRM panel before attaching the DSI devices. If
one of the devm_mipi_dsi_attach() calls fails, probe returns with the
panel still registered.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 0993234a0045 ("drm/panel: Add driver for Novatek NT36523")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/gpu/drm/panel/panel-novatek-nt36523.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36523.c b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
index 226d91daf8..f6592b01df 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36523.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
@@ -1047,13 +1047,6 @@ static int nt36523_unprepare(struct drm_panel *panel)
 	return 0;
 }
 
-static void nt36523_remove(struct mipi_dsi_device *dsi)
-{
-	struct panel_info *pinfo = mipi_dsi_get_drvdata(dsi);
-
-	drm_panel_remove(&pinfo->panel);
-}
-
 static int nt36523_get_modes(struct drm_panel *panel,
 			       struct drm_connector *connector)
 {
@@ -1225,7 +1218,9 @@ static int nt36523_probe(struct mipi_dsi_device *dsi)
 			return dev_err_probe(dev, ret, "Failed to get backlight\n");
 	}
 
-	drm_panel_add(&pinfo->panel);
+	ret = devm_drm_panel_add(dev, &pinfo->panel);
+	if (ret)
+		return ret;
 
 	for (i = 0; i < DSI_NUM_MIN + pinfo->desc->is_dual_dsi; i++) {
 		pinfo->dsi[i]->lanes = pinfo->desc->lanes;
@@ -1259,7 +1254,6 @@ MODULE_DEVICE_TABLE(of, nt36523_of_match);
 
 static struct mipi_dsi_driver nt36523_driver = {
 	.probe = nt36523_probe,
-	.remove = nt36523_remove,
 	.driver = {
 		.name = "panel-novatek-nt36523",
 		.of_match_table = nt36523_of_match,
-- 
2.47.1

