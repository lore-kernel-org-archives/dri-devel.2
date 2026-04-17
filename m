Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23FD4F8E4AD
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 06:19:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81CA310E955;
	Fri, 17 Apr 2026 06:19:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JMlhfLfP";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E1D610E957
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 06:19:09 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2a9296b3926so1757285ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 23:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776406748; x=1777011548; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=51ANuS+IBW0WksB7NRSMxwOMBhRVSyM31rcxOrdTixs=;
 b=JMlhfLfPWW6J0UmagByxaubPVldsvFltIPRBb7kINKdiuU7ALQ92gaMovpHHtfhCrD
 9ae19Wk2x5rlNxUzxArm2w7xGih6AGWY8vJOrE+FFjDSDHjFoXSCvjCcMpLJ+nk8fsLN
 qTyDYF8S8A5gTmd8hpZpWUIqnpTO3oQnO3x2JIxmVrafcINtZmkcp5o2RPfvPh8mPgzc
 dSwL8e4mQpIKxQ8V2+eBWrYLzIIQ7mByLtwus0RJSLbxcF1rwaZrsZeeVEYrciR2RlAx
 30cs4SIepkFYQMu6S4YvSvjHidOVy5+28PH6nbcRAVjOUTmwi61Gsl1q9M8+M4X+iDyb
 mhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776406748; x=1777011548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=51ANuS+IBW0WksB7NRSMxwOMBhRVSyM31rcxOrdTixs=;
 b=iLgBFjd8iAv98N/u0oFXUwtp+Kx7LKkmjVDRL5MpnMVX8485qA4EB8RM8aZ6+nKq40
 V6lRZDyybQRDXiKWKsBSLqcSXHHUiZeOOpL1jQIxprtf/Q0ls2D8fBFVH8pIhchX2vZt
 tzQ7B/xmDWftiqvz1Px6YEZy9lhiaOZYGk0brsGnEqBVv5Q1PgF1LmDOlNoAW2SHRw2Y
 xU/f8b/geRHzJZ9xxihIMfL+KESvPmmybtY3WoDj5UhhYtgA8YI/F77jEH8kT/czIbQB
 i4qxoPJ34+WSagou4jr5Fqt5QaeNM+UCXfTHccE4O9j3lrJbQCZqit64yxS6E7uQFDcj
 lS1Q==
X-Gm-Message-State: AOJu0YzZxBa0FXVqVSeuieaaYl76Hj331cQGJ0mBQi6sFrl6yMjGi1ys
 NQPBA1YsCaIeWxjNWFCrLq9dTYkHSgp7BjY0efGs5NzYIsqJZg3Ujywp7z80HmVN
X-Gm-Gg: AeBDiesxsEpvzFQODpwJ761S0OaJYM51gur/r+cf4IjLoq3WlfsdWetdwWfTPiFORyV
 RBeWTVjEbSQ/E6JHj/JAzAv799zETkFZpOUrep953tE6eZ0uLuNt1HFaeza+8ix/AsMswX77lmz
 CtQmVNsaflMsET4fiOZnkdMufhiMWx26UroCoLUEhb0SM2KGIyGo77CjTG43ADzP6QI2KOqF5j6
 oCUwY5HSJ0yvJWKcQfx6DilaDugJCCivWPXevGVyk8dnEdMK7mIZebh1YmXsEfIZVZd6MYKd5pO
 wy9kwqzZC+TAMDVQ2UVzibPgBkCRliqc2vqM/a6Z53+gGOMiU34Pb1lCNPfqtR0k1UFxJd6FJU4
 UzZKl6czfvH+Kq0yPtsh35xGrcoSU7OFNB3LPTvCHHiNXytR720E2HiHCUtUNL93qfnJsx79JPQ
 2Gbbh0jZccXgVVp9WjUeImXs5j+Y/ghL1k3Cj9CdSWqEJx0jnDpy2j3NV1WEhsIJdSgg==
X-Received: by 2002:a17:902:cec6:b0:2b2:49a7:a5ca with SMTP id
 d9443c01a7336-2b5f9e8f561mr15384865ad.5.1776406747608; 
 Thu, 16 Apr 2026 23:19:07 -0700 (PDT)
Received: from fedoraemon.neon-universe.ts.net
 ([2406:7400:11d:a9dc:9a14:72eb:1a60:868a])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab40786sm9046225ad.79.2026.04.16.23.19.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 23:19:07 -0700 (PDT)
From: Avinal Kumar <avinal.xlvii@gmail.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 neil.armstrong@linaro.org, dianders@chromium.org
Cc: lumag@kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Subject: [PATCH v5 1/2] drm/mipi-dsi: add mipi_dsi_shutdown_peripheral_multi
Date: Fri, 17 Apr 2026 11:48:41 +0530
Message-ID: <20260417061842.66631-2-avinal.xlvii@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417061842.66631-1-avinal.xlvii@gmail.com>
References: <20260417061842.66631-1-avinal.xlvii@gmail.com>
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
index 0390e14d3157..3ac1dd5ad640 100644
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
+ * makes it convenient to make several calls in a row.
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

