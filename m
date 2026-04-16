Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65D4F43841
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 07:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 368F310E846;
	Thu, 16 Apr 2026 07:39:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d3cFzX1+";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63C6010E831
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 07:39:32 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-35da9c0c007so6638020a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 00:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776325171; x=1776929971; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kd33L34PL49HjLxsixOFb8JXjhyLJWELYvYdT4Ym4XY=;
 b=d3cFzX1++gatbvgKJu8f8nEofdA2/6NYUjH2/QvVj4vna2CB3YD6hk2/QV+wryG4cj
 C/UJy2Uo5yPu2LzO8KSrjcCT8f6P6BkkJrH3YihXWQwipplXjmyh+Ao3OTqE70blyWq0
 gCNmgj/1+YA4k66Sq+FfIdQoGGRM39uzgMtNmpSemT1xxcrRRvgfkB3CJCmg41I6WrVb
 5JBwAoC3wvxwuKXBDhaJxL1IOc1pKzR7MMuxLYAPZTeqSfUTnETgbGSokG3+geLwbARw
 zblQAVsax6FJgcmDsSyW730I7jotMVMIoLvpO4iZTuiBz6Vt1IUA5bpHZ+gYH7mDkjId
 0Vjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776325171; x=1776929971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Kd33L34PL49HjLxsixOFb8JXjhyLJWELYvYdT4Ym4XY=;
 b=kW6E5IGqNwFh5GCrfeb/qHJExLK5XreF0sjr3AiWvU56A4g4lKdmJvP3EDtzBUNly/
 +BQIXjTu5jpngp7ypb7ch72fnc8O+Gj8qRoVL7YJ+imlrzI/1MOA7I8V8i2qJRBHhw4x
 w3VxOI5m9nXxdtEhAnfjsBK4/bPzy5A3NAyylgTSQl6loYorKgqxQmprjv5idAxByESB
 9aNE/SPRUgpL4KZ3JjdWIJmS3+S8DWrGgQiFHsBgfIuVolfMaJOIZ8lo9NYoj1ULoQGC
 4Ct3raTWNYvNKrxUME83MZsCnMG1TF6xrtrrX+8334OB9Ih3aDoLsiWCXrspqqAsiX/2
 Z0rg==
X-Gm-Message-State: AOJu0YwucVJDvEKLnqcoMJHKqcOH3phcRqfsHNisO/Ujoq9mw6xP9RIp
 XJjJPOUmlwrPXtgeZEoI7ccN+FQLa8sENxFcZ2u9I/DADYvUfBTcKrqWfKliA7/O
X-Gm-Gg: AeBDiesjxDnN9pHw4kMI2C0mDvvqZDZMTTzmRl5+Lt0PXqskexU6OhX0Fql6emVvkXs
 yW4MXt7EGcrpSQjHNq2Hatdw+dXPCy5CXdu8mgnJ6sJGb1jiojiw349Ty9MYXX3ID2S+sFY1asa
 hOZWeOo/qBDBPZG0fjJC5eOUPJK51fjbrvkF4JJJJYcWSPUOz8GKikevSOMvLRoWo4fb07fFMCT
 XHOXR2meJkrpajcdW23f25tJFh3kSmxthoVh+U9AQQZ+NK2O98kngL+JwYAX6IPlIKJ8RBf0OQK
 WbowEhGIHg/yxCbPtax71F8GFOQmz02ni8i+rE9giDpDVh3k9IPToBWY1p+P1fVaHb1/u7paIYu
 J8+2Zv7N8bJCCz8DFnSN9q1H+l7T2No27m8aKmsn3YVK8oNHjNhfdowTYhqSBUcSGIG5UQcG/K+
 cquzWDE+YGsk2Ws+5a/oPeMzpmqOdOA+8+Au810FHKx2iR53YRMszlb00=
X-Received: by 2002:a17:90b:1d8a:b0:35e:3e86:e2d3 with SMTP id
 98e67ed59e1d1-35e42777a47mr26140311a91.10.1776325170954; 
 Thu, 16 Apr 2026 00:39:30 -0700 (PDT)
Received: from fedoraemon.neon-universe.ts.net
 ([2406:7400:11d:a9dc:9a14:72eb:1a60:868a])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36132d9d228sm1735245a91.10.2026.04.16.00.39.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 00:39:30 -0700 (PDT)
From: Avinal Kumar <avinal.xlvii@gmail.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 neil.armstrong@linaro.org, dianders@chromium.org
Cc: lumag@kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Subject: [PATCH v4 1/2] drm/mipi-dsi: add mipi_dsi_shutdown_peripheral_multi
Date: Thu, 16 Apr 2026 13:07:21 +0530
Message-ID: <20260416073722.719036-2-avinal.xlvii@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416073722.719036-1-avinal.xlvii@gmail.com>
References: <20260416073722.719036-1-avinal.xlvii@gmail.com>
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

Add mipi_dsi_shutdown_peripheral_multi function and mark
mipi_dsi_shutdown_peripheral function as deprecated.

Signed-off-by: Avinal Kumar <avinal.xlvii@gmail.com>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 28 ++++++++++++++++++++++++++++
 include/drm/drm_mipi_dsi.h     |  1 +
 2 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 0390e14d3157..911e7ca5b9d5 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -587,6 +587,9 @@ EXPORT_SYMBOL(mipi_dsi_create_packet);
  * mipi_dsi_shutdown_peripheral() - sends a Shutdown Peripheral command
  * @dsi: DSI peripheral device
  *
+ * This function is deprecated. Use mipi_dsi_shutdown_peripheral_multi()
+ * instead.
+ *
  * Return: 0 on success or a negative error code on failure.
  */
 int mipi_dsi_shutdown_peripheral(struct mipi_dsi_device *dsi)
@@ -1980,6 +1983,31 @@ void mipi_dsi_dcs_set_tear_scanline_multi(struct mipi_dsi_multi_context *ctx,
 }
 EXPORT_SYMBOL(mipi_dsi_dcs_set_tear_scanline_multi);
 
+/**
+ * mipi_dsi_shutdown_peripheral_multi() - sends a Shutdown Peripheral command
+ * @ctx: Context for multiple DSI transactions
+ *
+ * Like mipi_dsi_shutdown_peripheral() but deals with errors in a way that
+ * makes it convenient to make serial calls in a row.
+ */
+void mipi_dsi_shutdown_peripheral_multi(struct mipi_dsi_multi_context *ctx)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct device *dev = &dsi->dev;
+	int ret;
+
+	if (ctx->accum_err)
+		return;
+
+	ret = mipi_dsi_shutdown_peripheral(dsi);
+	if (ret < 0) {
+		ctx->accum_err = ret;
+		dev_err(dev, "Failed to shutdown peripheral: %d\n",
+			ctx->accum_err);
+	}
+}
+EXPORT_SYMBOL(mipi_dsi_shutdown_peripheral_multi);
+
 static int mipi_dsi_drv_probe(struct device *dev)
 {
 	struct mipi_dsi_driver *drv = to_mipi_dsi_driver(dev->driver);
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 2ab651a36115..b429acde4f71 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -393,6 +393,7 @@ void mipi_dsi_dcs_set_page_address_multi(struct mipi_dsi_multi_context *ctx,
 void mipi_dsi_dcs_set_tear_scanline_multi(struct mipi_dsi_multi_context *ctx,
 					  u16 scanline);
 void mipi_dsi_dcs_set_tear_off_multi(struct mipi_dsi_multi_context *ctx);
+void mipi_dsi_shutdown_peripheral_multi(struct mipi_dsi_multi_context *ctx);
 
 /**
  * mipi_dsi_generic_write_seq_multi - transmit data using a generic write packet
-- 
2.53.0

