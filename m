Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58D6CD5BB1
	for <dri-devel@archiver.kernel.org>; Sun, 24 May 2026 16:37:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 269D810E36F;
	Sun, 24 May 2026 16:37:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VXHGadT0";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38EE910E36F
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 16:37:24 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2bc763e2ba8so44436505ad.3
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 09:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779640644; x=1780245444; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Bbs8ogJDyCawp6DJ+gyS+VxxLyhjXWQ/w4tp1r61OM=;
 b=VXHGadT0MFoRNF440izhJCoxuXMn8Xc5p8Hy7/P0ar0t1+NsF3KYgnT+3WqoSTXyhp
 HCa7+JMfV1sFmRmIr1eNwcyG7awz1JxN7hUmd7u+63iPomWZ6QCdr+TNod+EwJsZRys3
 N0kNZiBUiqQrqOuzqCdIDq0HFH7AXAPFAwC/A+wCZzXncNaIyepHg/+1oKFFWH8ejHvq
 u+SY+PmboX7CT4HVABYF1O0kRqDrUlt0ZBaQnpPFSshyz3snxZITIOo+/Pcg8OpluPMo
 3SUgcNSPS01k0DCnevcW7AtG5sfL/pD42mCNFTwQ1oq6SKuxW9EwRNaLKW14DwnEWeJQ
 nWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779640644; x=1780245444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3Bbs8ogJDyCawp6DJ+gyS+VxxLyhjXWQ/w4tp1r61OM=;
 b=GB8JkDB2HhYM4rRRpyLphzeycG8fSXlbqeMira9vMltygk55EE0Xr6ASdcJv+p4dO9
 gjmn6G9Lw5Dj8Tbto5OQ1h6pFtGFNEQSJapnPkEFvXy09tHScJ9KfH1ttk9GB1OSIGrk
 izkaYnOu6S7Jj1vP3vMYxxhtD2lLebmv8fVPAkJcz2417b6oMd0UmTIZ4P/FhlSzc8e4
 CDARPUj1XGrh56nRNdkX0w04KP5XNF5uq6J22+dN+LvxwGFrBuY1EoxrvkHKoEfq0JRt
 zBUJrZQWoqaE2sgnHa0NizpW/I4DBFB8tWWUHUQbCFOeJA3/U3P3ic0jprrEMzuGARpi
 jgnQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/FfYVfDIiOcQgQOCsRKlXgCRcOi20cyl8Qzj+WlxP7cIqV/tIgPSe0o0rB6PYwdt65c8SqDKK6KI8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyxg52JFrQW0D8MY0ls27Kv2SAnLbeaMgQ+GofA/FLZycVVouzx
 l+1gt4K4R5ahhBc1rVNhv/GhkKEn6cdzwzQzRJXGSrLlJv08SZiSVv4=
X-Gm-Gg: Acq92OEPCfCHzJfzFMMYSaxnqZJRfxAsAqn0OXR9GxJElRG52arfYxOv5cZEhNvUDpk
 1VEBPqcQ7a+gyeAvxaSg3ubXZkAPHbt4BXq8gxSSbktpQIn6UxNSXu5SqsUqecpo+DIPS5dRtWz
 UtIokoWUMfYoWVHIUg8KAzOd/k2CKjS2aA83lxQ1gM5SgVjIwhONv8WdS85IYmRaTXtm1F1+CRc
 040dF7sUA9eEUwTuVgtibDeOvwe74RFUbjey8/q+uXNftIdY4F72LRogmlBxZbXsGBCVeC3ziUl
 EZvuibYsFwhee1vjTBpE3xB8XV8cM2yeBhMDv+iYYqPvgRMNVGt7iNwcFAjKej7VanS1zSzRzM2
 7yVZavqC1rOCRJrf90S+SRtc82aj05vJ1/ka0vizfVlSxmkPm5pbqcBD7gQqkpacS1P9CqACrI4
 sbTA/9kgVhtvG+07xXlnjlKeIQuuF+yFiGPCG/HsVytRr7wdIXxr0JMrmqFGs/8fhqUZzi5okAk
 D78PqYJZw==
X-Received: by 2002:a17:902:e548:b0:2bc:ac76:c1d3 with SMTP id
 d9443c01a7336-2beb0770aebmr131579575ad.29.1779640643652; 
 Sun, 24 May 2026 09:37:23 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb58b309bsm73017325ad.51.2026.05.24.09.37.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 24 May 2026 09:37:22 -0700 (PDT)
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
Subject: [PATCH 1/2] drm/panel: boe-bf060y8m-aj0: use devm_drm_panel_add()
Date: Mon, 25 May 2026 01:36:32 +0900
Message-ID: <f7407c121909b6da415d4b91f62669ea250a42de.1779640137.git.mhun512@gmail.com>
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

boe_bf060y8m_aj0_probe() adds the panel before attaching the DSI
device. If mipi_dsi_attach() fails, probe returns with the panel still
registered.

drm-misc-next has devm_drm_panel_add(), so use it to register the panel
with devres-managed cleanup. This removes the need for open-coded
drm_panel_remove() handling on later probe failures and on the remove
path.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: a19125a28112 ("drm/panel: Add BOE BF060Y8M-AJ0 5.99" AMOLED panel driver")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c b/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
index 84c21c62a4..a6d765b402 100644
--- a/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
+++ b/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
@@ -357,7 +357,9 @@ static int boe_bf060y8m_aj0_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(dev, PTR_ERR(boe->panel.backlight),
 				     "Failed to create backlight\n");
 
-	drm_panel_add(&boe->panel);
+	ret = devm_drm_panel_add(dev, &boe->panel);
+	if (ret)
+		return ret;
 
 	ret = mipi_dsi_attach(dsi);
 	if (ret < 0) {
@@ -376,8 +378,6 @@ static void boe_bf060y8m_aj0_remove(struct mipi_dsi_device *dsi)
 	ret = mipi_dsi_detach(dsi);
 	if (ret < 0)
 		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
-	drm_panel_remove(&boe->panel);
 }
 
 static const struct of_device_id boe_bf060y8m_aj0_of_match[] = {
-- 
2.47.1

