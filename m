Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F8C7FB44CA
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 07:45:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDFB710F372;
	Fri, 24 Apr 2026 07:44:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NOI0T/Uw";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E423610E289
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 12:59:46 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2ab232cc803so31934985ad.3
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 05:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776949186; x=1777553986; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h4xTgfPHnZOuEf34ciUHWfIJSfN8PmhCOELy+FIP1y8=;
 b=NOI0T/UwPpvxF2DgLgKAAOEQwf11W4pcbzjtcdTs601J0vm1modrFL06RujqoaqGDn
 qVOEsNkyeWecjEXFbuDbdaFEuCJSNs4qmhiimtg2lcnmJlpDaj9x0KV9pMVtQ50lbDuP
 wToGCLIBCLxv4cDFPezCDLIU2IJ8HkJ3TSTtaSS6Bk+OQW5Xm1IvZrGJ0DGBTyu9FGIj
 MqKfn9U/lrWZZrOeIIRm0GOCrqupmJ8STKV9xenmSKyFRpoEM1YuLuLa5y0OszmbPM/S
 aXxL78LK2EcS7/kgjribVmGWQPsWz5V3KIFdgS8P+O/dZmhJQgHAhsPXQJxXHXFxMDTf
 U/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776949186; x=1777553986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h4xTgfPHnZOuEf34ciUHWfIJSfN8PmhCOELy+FIP1y8=;
 b=ok8TURFhrh0H8bnpqNJpOVvw0Xhd8iNDk751tSNszA1tQplNTZ3JEEuBxSMce9jhsK
 xF48P36wvD8kMtiocTxRKKg8puN1nmpTXTJDypIM5LFfdVOUjDSVtiWJyaA54OvggDDo
 59RaNeIximMnJDC+eLB8m/CwPB2EJSswAXIbaedH3eElZm+zMFJF6/Nqg4eU36M01dK2
 9Zi+Jrxqwn331qRFKrAquNdy1ATnS935gAlSjANy+DnuOFy4IBlO7NpP4Y4SuNvD1H3U
 iJoeWQk3VfTISLCxOgPllXhK8SwE56AfkpZj6t9Jvz+8BL5zPH4wlGO+ysa5NoVva3IS
 Y7WQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+TFObNqaXGOIAhNrPKZsaKIxOI5Z4zRLIehXV4Tkewmd6wDJ4mJB6QYToPb51w/mS0Kf9O+n9GI7k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyDpgJmzNWUHFaogOTdcNHSeqah7Hjxqrnhtm7ql425hVYT8KhE
 jRV6SCIBlPIEnxuDYmwsnkynrWFSvzruA0O8MhrfOf6edpfcd/fTamE=
X-Gm-Gg: AeBDievN/DTgyeqMQLu0i4OGudvfr3Q+MmIUXpUhhZfa6OkCB6LniDgwRTxYwfJU/Ar
 ny+SeKGgGvX5pJAccpmYQgmJKE87NBeyYNfT6YfFsUW4AhNruBSK+XmMEcjmpeiOHnjOp+w6/Iv
 L09GvlWZ7kgg/NcquCKxEcrTXOjBi/RgCqVeqpIXmgr6C5kv9L/9dgmP7l2sZPH5sQcO32GGfwF
 vZwpVrP3rQnoKTtmprAQAKUwZ1/hGnLeHzxG5mgvedC700L5VlNDU7rUbtXQvfpIq7BcBuTQOfg
 0EPmHDGIergUkcIkgFvat1yf0R/+4Uina6RAZfhNqlqqtR31PINb6/x2hw+5799dq7aHTPOIEJD
 3GN4+Q8Jrz6xuoVS91iIg64zST0vvvRbqF/7w2LYUpBf0XJwZVk3nMq4ZvQexUjfqyzFvjmXJ3R
 4oUMDzMaE8dLM9sblReA6mYlDV01uaxaIWkr4idOcoWuA7sFocQUDpzd4J7aujUs5P+PhyFdCDu
 rQrmwadvw==
X-Received: by 2002:a17:903:883:b0:2b2:9f45:2266 with SMTP id
 d9443c01a7336-2b5f9f8302dmr206653135ad.21.1776949186451; 
 Thu, 23 Apr 2026 05:59:46 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab28e35sm193499065ad.64.2026.04.23.05.59.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 05:59:45 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Myeonghun Pak <mhun512@gmail.com>
Subject: [PATCH v2 3/3] drm/panel: lg-sw43408: use devm_drm_panel_add()
Date: Thu, 23 Apr 2026 21:59:22 +0900
Message-ID: <20260423125922.57428-4-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260423125922.57428-1-mhun512@gmail.com>
References: <20260423125922.57428-1-mhun512@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 24 Apr 2026 07:44:43 +0000
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

Replace drm_panel_add()/drm_panel_remove() with devm_drm_panel_add()
now that drm-misc-next provides it. This keeps panel deregistration tied
to the device lifetime and removes the manual cleanup from the remove
callback.

Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/gpu/drm/panel/panel-lg-sw43408.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-lg-sw43408.c b/drivers/gpu/drm/panel/panel-lg-sw43408.c
index 293826c500..8969f57b89 100644
--- a/drivers/gpu/drm/panel/panel-lg-sw43408.c
+++ b/drivers/gpu/drm/panel/panel-lg-sw43408.c
@@ -254,8 +254,11 @@ static int sw43408_add(struct sw43408_panel *ctx)
 
 	ctx->base.prepare_prev_first = true;
 
-	drm_panel_add(&ctx->base);
-	return ret;
+	ret = devm_drm_panel_add(dev, &ctx->base);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to add panel\n");
+
+	return 0;
 }
 
 static int sw43408_probe(struct mipi_dsi_device *dsi)
@@ -299,14 +302,11 @@ static int sw43408_probe(struct mipi_dsi_device *dsi)
 
 static void sw43408_remove(struct mipi_dsi_device *dsi)
 {
-	struct sw43408_panel *ctx = mipi_dsi_get_drvdata(dsi);
 	int ret;
 
 	ret = mipi_dsi_detach(dsi);
 	if (ret < 0)
 		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
-
-	drm_panel_remove(&ctx->base);
 }
 
 static struct mipi_dsi_driver sw43408_driver = {
-- 
2.47.1

