Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC8AFFEEF2D
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 14:41:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C5DB10E440;
	Tue,  7 Apr 2026 14:41:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lVB4M4ZF";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF5B210E43F
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 14:41:54 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-43cfbd17589so4056362f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 07:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775572913; x=1776177713; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aBvRjjOb926xFV+H1FqZpjuC1zFML4FZaPUVcq0/XXk=;
 b=lVB4M4ZFNDY8tAPBkmUO7LezS/l3mheTG8l8diyraIbILlta9OEQV0JlZEfr1A3rS7
 teJuIk6b1DVXxGWIP9zy1QoR7qMtqtbWzQ+Y0mB0XGOor4Ca0eBU98bi5UuSnYad+TQr
 ek3FoIICuLIxGYmNDabdzRveXk2KBNWyqBSJiYvpbbSuANKpIFPMsHBdIWPLve4TNE2O
 uQWTFwSErdIXZzcx4LT8gwi4M76T+LyINko14CnDZExcxAa1mLgZkAltV06hUeASmHRn
 OMlnYr1rKsuj3rYtO9Nu+GOOdL5PR0D9kkgeVeyVH+riIMJclvfaCgZxjYEgRcqW1zFx
 /wbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775572913; x=1776177713;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aBvRjjOb926xFV+H1FqZpjuC1zFML4FZaPUVcq0/XXk=;
 b=UW3r7ZQMerWFH9wdBnhmZjC5k+UaFTxCWJu1Ml86HqkPC+MEVDfstHooI/QQ1AZ/sd
 mkkxYxLLjqygEEZN8nWpPjie9FSvhKIyq7TYTGcEUAY/gxB7hub11+Xba42T6CmtT2yd
 NnL7MZ4MJTyECYaF40US8RaAjhqmxeGO448LOo08aNvc6TuwtbBBRS/NUDXRoHhDWS6r
 kHJg20L802YQ/7gdR8nDbc9qy8g8yKUmWQUWV1EkvxrxrecOuV/aDPmQdk51NwS6KsaU
 4qmka7wwwdhIvh35lTLZPvLMmyfA9LSWPP1SCCrdV2PYoF8q84THbEzbg+KDqg1O2+Hr
 bxWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxSGclcbN9GDKV0VTZ2+ZpcNuGdTfRYd/+dVR6Hq3s5nYUIrdNOqW1eOCIMyMnPirpOBm1FE+mGqE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyVHGHdeIHiESRfRKcYXDIsnuB2rgf9I41XzYuBkfmU1ht3F8j+
 a6kzRcQsoQX1LCc8QTXpMGCUwA/9OIVUcies/mf1nrp+3S4xTRNhHkr7
X-Gm-Gg: AeBDievww1VLXFRVI6He4z/UtDLAWoEH8ugIE7zyDeMfC1l7VdxAwcuwBqnhpjuCK/t
 Ze25ja3MJAaBge4qpGfW0irwDqWxhVYI4VxKJ4Lakg+usTrscYIp2lhsnzmZWIOTFRz5oXAuy9i
 pTTncjyxA671EEUz613bwqzgVLsDZrFjDbOEYMmoFeDv9asLS46K/ug489T/DS41jyzJygsJMtn
 HSoe2zNKeiRoOlCGJeVmkrAL0BinxFscTzJNGvvN1+c39sofZlVeq019lczU4+btG6aFxz51Bvc
 HVvRMSrcCy/anO04Wlaf0iBPeLueMSQrooX6Y3+AUBr5tDhtdjuV8ud7TcXHU7YznZTeEKL2N8S
 FSJ6309nI2m8Ldk6SZ/9kkflythOSao/ZadU88vdP5EC4l9isqCg2D1dROCIviD9JlJ/AHnKUBy
 yUW1DUfyz9Gn8CoE+LCcSi7c8ogLQ8YymbrUnFC2A=
X-Received: by 2002:a5d:4445:0:b0:43d:4a43:53db with SMTP id
 ffacd0b85a97d-43d4a4355afmr3472891f8f.26.1775572913195; 
 Tue, 07 Apr 2026 07:41:53 -0700 (PDT)
Received: from vitor-nb (dsl-43-224.bl27.telepac.pt. [176.79.43.224])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4e5890sm49990292f8f.31.2026.04.07.07.41.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 07:41:52 -0700 (PDT)
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
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v4] drm/bridge: cdns-dsi: Replace deprecated
 UNIVERSAL_DEV_PM_OPS()
Date: Tue,  7 Apr 2026 15:41:41 +0100
Message-ID: <20260407144142.1420354-2-ivitro@gmail.com>
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
SET_RUNTIME_PM_OPS(), enabling suspend/resume handling through the
_enable()/_disable() hooks managed by the DRM framework for both
runtime and system-wide PM.

Cc: stable@vger.kernel.org # 6.1.x
Fixes: e19233955d9e ("drm/bridge: Add Cadence DSI driver")
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
v3 -> v4
 - Add Reviewed-by from Tomi Valkeinen
 - Rebase on top of drm-misc-fixes
 - Verified issue still present on current mainline

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

