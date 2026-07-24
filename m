Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B21C4453D
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 04:17:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B37A210E4B5;
	Fri, 24 Jul 2026 04:17:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sZiF4QOa";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA03010E4B5
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 04:17:51 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49548e01d02so47915e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 21:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784866670; x=1785471470; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=a0VuahsdN36ECKorNPoSkLonNsIPTCrvqxrDox7fYRY=;
 b=sZiF4QOaSAtb6tJmwUKjcoJH5+zaw5CNoYr2cJyw3LlFGOpvUQ9RWNGi25SkI0IimG
 QyFVg/lBwLPZXo4vO/QVzzCeq2eMKmesRiLLpNQGflkTfU3BYZEpbx7Gs/hRbpNTConX
 jWWfD489i83gvQSDHQaz7ZlpiQvTl9jGrg9aLPo+mkMlXXR/JJJk0zQ0mTh0wuwI5Qnz
 XbPEzVt2zg2nKh7rDmNgYpPc/OAa9vjemRyd80X5J29gvAqjN2Pxj4rbKKN+2ZlJHlOp
 btyi+0Z5Cmx3WmG7efjZNzHZ7j5tXUK65SJf9833cdfvomXVYQrzuM8HwwOaVgv7dn3o
 uuSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784866670; x=1785471470;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a0VuahsdN36ECKorNPoSkLonNsIPTCrvqxrDox7fYRY=;
 b=d6b9MYraDC5Vo6qV2P3BzWcm333NcPrVLVj6jkYU6TjmEzRpTQwvrs4r0n78NMZ/aw
 bgvECuO8q6K6UlUXcMPqdiB9bHALXFE6Dod9q7HPXVSKS1txokgbHPK1m1EVou0oJc5J
 +6x5SXHaCom3ARnjAq1Nfj5m3+urepHKBvdLYQPz1nw4zbTRbauQwC1Lk0y/H3Cp4CFG
 wIXGV8+pq5oZQk4H0PySA7qIOsxMQfJD41/8NWov6Xq4amCbr57W3gTqsDB8zAe5fzin
 AHIrUDaDT/6WIEOVDnuNMSjMp4WKF1IPZLdTS4dqPN/JaonHCVo5NQDTe5aCEHiaV8eC
 uGDg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpsA2VCNK3fIEN1wNA6ehvqJqHV7Cb2K1zvyMT6SwyP8nl+pmk+TJtX+QkO+c3T1iYHke1iqR3sE7U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwHG3HaONn/VqRg5suiOz2VscCku321UsWjlng38mk/f7DjnqDn
 IcuHO5Q/WZfJKIv8yHo79mcZvZYOERFe07RlDgUqKq+puq+zZ0IpVHvl
X-Gm-Gg: AR+sD13Vilh7nhvAHhKT2erm6l1MB8AfRaVGnznsUoZpSZz01sIkTzPtWgTE+qqBjN2
 Y/MRR5nN6ndT4YwyLe6MyIGPXsR1Gxra2d/dGaZk1U22V8jflNdWvjy5MLWNSVPdhhzOKgqjpil
 GR7TDyAzCZU61guvSMLfSmuOpd9e30ZzbSPdUofxjgiJSsdfqEUGQiCusuyC9eaZHC0eRgGjusj
 9WOZttbKvCNdQ+P9CmxVD3EDnYiDquiBTcuRX3nipSjjsnnSDw6UlF3q64VHyk3/qLFYaLfGP0w
 Ru6seerkW4sEDD2jJUwIBTAh9d7tpkiMdVf8ahfxsVyBA9X5/GunKX5Dnrzz7aIPFJUWmXAxScx
 UTS+nH6IbyHHSqrb6QBrplKoLD6FqLt+UyjI3JPalBxLkGYd8aixi0Gz7Laxhr+AmXZL13N3mP1
 zF/gEA4tBI4sFiyBM+TOGzJOvQRNcrGp5slQgJQR/KLpkgFseiHKu9wmewmTj0Ig==
X-Received: by 2002:a05:600c:c05a:b0:495:49da:e15a with SMTP id
 5b1f17b1804b1-49573d083c6mr65959185e9.30.1784866669838; 
 Thu, 23 Jul 2026 21:17:49 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957af79365sm48162655e9.9.2026.07.23.21.17.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 21:17:49 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: neil.armstrong@linaro.org,
	mitltlatltl@gmail.com
Cc: jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, David Carlier <devnexen@gmail.com>
Subject: [PATCH] drm/panel: novatek-nt36536: Fix panel double-remove on attach
 failure
Date: Fri, 24 Jul 2026 05:17:46 +0100
Message-ID: <20260724041746.12887-1-devnexen@gmail.com>
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

The DSI attach error path calls drm_panel_remove() by hand even though
the panel was registered with devm_drm_panel_add(), which already
arranges for drm_panel_remove() to run on driver detach. When
mipi_dsi_attach() fails the panel is therefore removed twice: once
directly and once again while devres unwinds.

drm_panel_add() takes a reference and drm_panel_remove() drops one, so
the extra removal releases the last reference early and frees the panel
container. The put registered by devm_drm_panel_alloc() then operates on
freed memory, resulting in a use-after-free and a reference-count
underflow when a DSI host rejects the requested configuration during
probe.

Drop the manual drm_panel_remove() and let the managed cleanup handle
it, matching the other dual-DSI panel drivers.

Fixes: 75a5dbd1f4f7 ("drm/panel: Add Novatek NT36536 panel driver")
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/gpu/drm/panel/panel-novatek-nt36536.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36536.c b/drivers/gpu/drm/panel/panel-novatek-nt36536.c
index 2a82b54880c3..8bd125650168 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36536.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36536.c
@@ -429,11 +429,9 @@ static int novatek_probe(struct mipi_dsi_device *dsi)
 		ctx->dsi[i]->mode_flags = desc->mode_flags;
 		ctx->dsi[i]->dsc = &ctx->dsc;
 		ret = devm_mipi_dsi_attach(dev, ctx->dsi[i]);
-		if (ret < 0) {
-			drm_panel_remove(&ctx->panel);
+		if (ret < 0)
 			return dev_err_probe(dev, ret,
 					     "Failed to attach to DSI host\n");
-		}
 	}
 
 	if (desc->has_dcs_backlight) {
-- 
2.53.0

