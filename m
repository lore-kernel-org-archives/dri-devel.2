Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEAE3C88E56
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 10:26:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E66A510E709;
	Sun, 13 Sep 2026 10:26:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hZGxXJrd";
	dkim-atps=neutral
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C7FD10E709
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 10:26:19 +0000 (UTC)
Received: by mail-pz2-f12.google.com with SMTP id
 d2e1a72fcca58-85469e211a3so797176b3a.2
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 03:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789295179; x=1789899979; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5H60KqbS+ROq5wCtUl6A8wMpEemlazNnMi16ohCbfuQ=;
 b=hZGxXJrdZzey0Bh/fLoyLtx5rJZlgmzk3eQ/2Ido3cFGTSaTMm/9SY0fsXqmWMmmmz
 QdYH70uJHKyODOAXPtkIJDjBsg0v2Fz1fRtqStOih6flxH3Uqn4WIWNAPi/ILUXWytMB
 WGeTRKAvBdLNUDHo2/a1MsGpqzVPL3QiLtvtwWAgr0Ta9AuRzACr00K9rBPjP/6aEsiw
 pWTnI3cH1oP254oIIWjcqo7UAlJ/3/t+MICkFkxCDl9Vdrl1UztFc465NwgrW6XzB7LP
 fTyLytpOtWR04yHrsJkyVmaPtqDIGcpIAO+kQSNbRbt5ts2ZkrUfQVmggIIs1TUpPl7+
 /oqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789295179; x=1789899979;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5H60KqbS+ROq5wCtUl6A8wMpEemlazNnMi16ohCbfuQ=;
 b=EAuxp2gGXC6vJenzBoshzur8n72FfFe3FCyEZ5mN0uY+4cGvAiWV7mG7RaQJ5CAlkX
 f4NqsU33GIYQ9l3r0kBJGRDRMVGYAG5gQ0vYDAxPUL7mtQoHsDQ5mqG4rU8+33lM0UOI
 jOP9yPIKps2RPx0PvlVwBmcZ+1dkOTpuP1D3eGNL0jMIIWSC+xMspAkECOd8Wd82KSxS
 p8FRiSyLjU2M+v+s2CMexsi0l5m0CWsq4LBo4E6TyBYlEfk+IVIAc615dhyrpSSxbrna
 pJCoH5SPkEk9H04+7O1cJSx4sKSgIG+wDWNnf5wBRSo+Pj4czlTxC5tA5Ayf0sip1GK5
 /RZA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwckst0LFmq7nYfIQmI3ApJE6LtFobKIamNz+00Slls4nGZWXTwMYGqzzC/qDn+ElTO6dz3RSg6fSc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nfk4P3dBqmp334j7hcI1TtVkZR5KtnUoEjqoAG7AHy51AoSskr
 gdLq1zqilukSi0se9BndIwBtXM/Zjx/gjkKFJdHNStw3xHr22Xs0h9gr
X-Gm-Gg: AYBFou0fCL/jhB+xpqWXLJMO/xnhgeaiQj6mNeC/dgWzsBJNXHd3dSY+pRjU+FbmHno
 od86oLkvU6TDTRwUn0353yz5XN8PlDn2p0phdGpsP3RpeIGKm436yRKcl4narvgL1D+vt9GV3b0
 Impx8FnaBqDN7fOs86sR1o7DMCHSL807ixqQts5ekAunJFKRqJ2S3NKSQQqD9DN+VBXSkT7Mvvl
 VjOpGxanNJSQeH1deUeFeRzs10cioMgY6Ue2W1oncSJB3nIclQAttXDFyvqCeyPRDuxndBomXor
 m6iF2+o9y3K5zAzNsbk7QCmVdat+6GbAzCH4IHI4p1NMucb5XWyqWpPl3zFpB+wJvcfNxXeXR0F
 GxGCI8avDe2nOrGK7tOHOXuqB/NXiH/jpbeUb4QHhgaYDQ2/BVGH728GxiW/5vzxcROntvL1ImD
 PKD5r9f5H3kAaVhImmb3pdkCphR4GtBuPhVH3j4COoZCWp+FnxWSJdbQ==
X-Received: by 2002:a05:6a00:3d01:b0:85c:2d83:bbf1 with SMTP id
 d2e1a72fcca58-86ccb44e113mr10352414b3a.20.1789295178771; 
 Sun, 13 Sep 2026 03:26:18 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86b29cbb760sm3126567b3a.46.2026.09.13.03.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 03:26:18 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Linus Walleij <linusw@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/panel: ilitek-ili9881c: fix panel cleanup on attach
 failure
Date: Sun, 13 Sep 2026 18:26:08 +0800
Message-ID: <20260913102608.1526916-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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

ili9881c_dsi_probe() registers the panel with drm_panel_add() before
attaching the DSI device. If mipi_dsi_attach() fails, probe returns the
error without removing the panel registration.

Since the remove callback is not called after a failed probe, the
panel remains registered and keeps an additional reference after the
devm-managed allocation is released, leaking the panel registration
and its reference.

Use devm_drm_panel_add() so that the panel registration is
automatically removed both on probe failure and on driver teardown.
Remove the now redundant drm_panel_remove() from the remove callback.

This issue was found by manual code inspection.

Fixes: 26aec25593c2 ("drm/panel: Add Ilitek ILI9881c panel driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
index c3d5ab67121d..1a52f92e2963 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
@@ -2594,7 +2594,9 @@ static int ili9881c_dsi_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return ret;
 
-	drm_panel_add(&ctx->panel);
+	ret = devm_drm_panel_add(&dsi->dev, &ctx->panel);
+	if (ret)
+		return dev_err_probe(&dsi->dev, ret, "Failed to add panel\n")
 
 	dsi->mode_flags = ctx->desc->mode_flags;
 	dsi->format = MIPI_DSI_FMT_RGB888;
@@ -2605,10 +2607,7 @@ static int ili9881c_dsi_probe(struct mipi_dsi_device *dsi)
 
 static void ili9881c_dsi_remove(struct mipi_dsi_device *dsi)
 {
-	struct ili9881c *ctx = mipi_dsi_get_drvdata(dsi);
-
 	mipi_dsi_detach(dsi);
-	drm_panel_remove(&ctx->panel);
 }
 
 static const struct ili9881c_desc lhr050h41_desc = {
-- 
2.43.0

