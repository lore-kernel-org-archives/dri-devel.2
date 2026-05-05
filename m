Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4FEFF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 13:47:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C6F710E113;
	Tue,  5 May 2026 13:47:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qRT5X4uP";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B601110E113
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 13:47:17 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-43d73422431so4971038f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 06:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777988836; x=1778593636; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WngZ1i7b+AeASB3S8rstycFmmHOgCBJxwXtpf2QN6jA=;
 b=qRT5X4uPJfFUj3hnpIB5sFa3xrZHhiGkIinLvn606KBEZrHn7lAXqhUZgA0hIIGnbN
 TN2ycWVafFUW47VQUvAU6DZH5O8OUhRisXLry7C1sWvqsA7ff6oLVcD2di+uoLI22ckD
 JVojgOyq7oGbkWJeeC6ddsNN2/Cm4RXegZZSWUzi/ksVoiMEgQGykIgMXD0XofqAIds5
 Es2tu82l8t1wrQtqF9N7NlWKno0rUqvV++5QC1KC5nQMQENmN3Rd98RRzLrMbfZaVmUL
 zoNKnsHxwXm7XPCnHO6kHfwsYyOaHss78JA/L74PjCc9SgVAIjgWezafQJb8pJX5J46P
 jMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777988836; x=1778593636;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WngZ1i7b+AeASB3S8rstycFmmHOgCBJxwXtpf2QN6jA=;
 b=Qu60IRM7U2S8WZwcJc3/fZglsAr76QAxtNij6L+MJSW/y7tr6AhgroliGAxfKSvNrW
 mb2d4PgBHvtZMo9DVHyMXkTC4slkEV3GUn0xMvglqnOp0TEq3y6eASGemfqieuB0SOnl
 7mB+3WnWiZACFSDqaZZa9XqjbItQLt4rju2KltuMz/JI50yIrXG2gOK+PWjhzJIEGl8X
 fWZu4QthtTAe3DSgbBRAbY/ZhUZq/aGJAKPZbLgVW6WYg1zG3gI/vyZbUTXL4bJClv6R
 zueIGWcQZ0TO48eg5ApIiDMRrPQKqXoaXUwK1WiCdDt0GHKw8+gGmaRT71Bd4NwEXRZC
 KqXg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/M/jLREnPPbpPWYAlvC4XC2PpfZ7AIRNwM7E7aJ9DdBmfE6ie99ODChj24Bx+4zdu7KWg5dzwKXC8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxz2RigyICnzqcv+nR+4DPclExwLUM7x26Pi6vWGqE3tt8L6xnh
 lgvhi460Vy8wuoD2Sw249m9F16zi64042Z5ju5dTFFvDQfikSAojCKXv
X-Gm-Gg: AeBDiestLew4FbvTvYZ7rF1yv9JpzqUrjwVE7f/uLxr275Q+dGKDhVkqwvDnivkIUzS
 FeQlOMGYLkhhTAHYiq2S48Q5UxEL2VRM3LrQ5hK0cpqq54jRyoGkoJMGMjJhpyZhXUlHsP6s/E9
 l1hOCZrnsEtZ8lqLNCtAbGIfO16SuZth5fGLLiqTjuM3042RghcSaB1i1QEnkvUBXw5SN9Xachd
 SZrdD1wNLT+zyNyRn1Xf0wChOBVA9FMXFUcE0ayWha8t6AaeCtycGZZmiGnHA7pA/rhHPna+eJV
 oiJWCbC8jtd6P4s/6ajHT+NvnGU0TqDBBrnSSeu6Ac60Pp9/bBpfOYnCRXWZEL1v3zV9V0sSiKw
 UepYC1WSTH81QWFZi3E14zYQRxNobpJeEfc3z6KU1fZm3rsvo+ohBl+1FkQ+iq4CChUhkx/zDjK
 ilb3vF6W3lLN5Wa1CwbJ8PMY25yMuPR4WJvB43vvcuyuJCXWwv1n/F
X-Received: by 2002:a05:600c:859a:b0:48a:525b:e157 with SMTP id
 5b1f17b1804b1-48a9865f870mr168311235e9.13.1777988835944; 
 Tue, 05 May 2026 06:47:15 -0700 (PDT)
Received: from vitor-nb (dsl-113-208.bl27.telepac.pt. [176.79.113.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eb694fcsm375814145e9.3.2026.05.05.06.47.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 06:47:15 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Vitor Soares <vitor.soares@toradex.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, stable@vger.kernel.org
Subject: [PATCH v5] drm/bridge: cdns-dsi: Replace deprecated
 UNIVERSAL_DEV_PM_OPS()
Date: Tue,  5 May 2026 14:47:05 +0100
Message-ID: <20260505134705.188661-2-ivitro@gmail.com>
X-Mailer: git-send-email 2.53.0
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

From: Vitor Soares <vitor.soares@toradex.com>

The deprecated UNIVERSAL_DEV_PM_OPS() macro uses the provided callbacks
for both runtime PM and system sleep. This causes the DSI clocks to be
disabled twice: once during runtime suspend and again during system
suspend, resulting in a WARN message from the clock framework when
attempting to disable already-disabled clocks.

[   84.384540] clk:231:5 already disabled
[   84.388314] WARNING: CPU: 2 PID: 531 at /drivers/clk/clk.c:1181 clk_core_disable+0xa4/0xac
...
[   84.579183] Call trace:
[   84.581624]  clk_core_disable+0xa4/0xac
[   84.585457]  clk_disable+0x30/0x4c
[   84.588857]  cdns_dsi_suspend+0x20/0x58 [cdns_dsi]
[   84.593651]  pm_generic_suspend+0x2c/0x44
[   84.597661]  ti_sci_pd_suspend+0xbc/0x15c
[   84.601670]  dpm_run_callback+0x8c/0x14c
[   84.605588]  __device_suspend+0x1a0/0x56c
[   84.609594]  dpm_suspend+0x17c/0x21c
[   84.613165]  dpm_suspend_start+0xa0/0xa8
[   84.617083]  suspend_devices_and_enter+0x12c/0x634
[   84.621872]  pm_suspend+0x1fc/0x368

To address this issue, replace UNIVERSAL_DEV_PM_OPS() with
RUNTIME_PM_OPS(). Bridge and panel drivers should only deal with runtime
PM, as the DRM framework manages system-wide power transitions through
the bridge enable() and disable() hooks.

Link: https://lore.kernel.org/all/fbde0659-78f3-46e4-98cf-d832f765a18b@ideasonboard.com/
Cc: stable@vger.kernel.org # 6.1.x
Fixes: e19233955d9e ("drm/bridge: Add Cadence DSI driver")
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
v4 -> v5
 - Fix commit message to use RUNTIME_PM_OPS() instead of SET_RUNTIME_PM_OPS()
 - Explain that bridge and panel drivers should only deal with runtime PM

v3 -> v4
 - Add Reviewed-by from Tomi Valkeinen
 - Rebase on top of drm-misc-fixes
 - Verified issue still present on the current mainline

v2 -> v3
 - Fix warning: 'cdns_dsi_suspend' defined but not used [-Wunused-function]
 - Fix warning: 'cdns_dsi_resume' defined but not used [-Wunused-function]

v1 -> v2
 - Rely only on SET_RUNTIME_PM_OPS() for the PM.

 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index 0dd85e26248c..e07a9892df4e 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -1230,7 +1230,7 @@ static const struct mipi_dsi_host_ops cdns_dsi_ops = {
 	.transfer = cdns_dsi_transfer,
 };
 
-static int __maybe_unused cdns_dsi_resume(struct device *dev)
+static int cdns_dsi_resume(struct device *dev)
 {
 	struct cdns_dsi *dsi = dev_get_drvdata(dev);
 
@@ -1241,7 +1241,7 @@ static int __maybe_unused cdns_dsi_resume(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused cdns_dsi_suspend(struct device *dev)
+static int cdns_dsi_suspend(struct device *dev)
 {
 	struct cdns_dsi *dsi = dev_get_drvdata(dev);
 
@@ -1251,8 +1251,9 @@ static int __maybe_unused cdns_dsi_suspend(struct device *dev)
 	return 0;
 }
 
-static UNIVERSAL_DEV_PM_OPS(cdns_dsi_pm_ops, cdns_dsi_suspend, cdns_dsi_resume,
-			    NULL);
+static const struct dev_pm_ops cdns_dsi_pm_ops = {
+	RUNTIME_PM_OPS(cdns_dsi_suspend, cdns_dsi_resume, NULL)
+};
 
 static int cdns_dsi_drm_probe(struct platform_device *pdev)
 {
@@ -1399,7 +1400,7 @@ static struct platform_driver cdns_dsi_platform_driver = {
 	.driver = {
 		.name   = "cdns-dsi",
 		.of_match_table = cdns_dsi_of_match,
-		.pm = &cdns_dsi_pm_ops,
+		.pm = pm_ptr(&cdns_dsi_pm_ops),
 	},
 };
 module_platform_driver(cdns_dsi_platform_driver);
-- 
2.53.0

