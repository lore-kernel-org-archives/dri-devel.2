Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E3AC43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 23:42:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6059110E28E;
	Sat, 11 Jul 2026 23:42:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lui8bE16";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08F7810E28E
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 23:42:36 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-4720d22c94aso1637140f8f.1
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 16:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783813354; x=1784418154; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DD8ngpZmt3sRDOk6LigSkTSJKrQed+P69f515uIeFdw=;
 b=lui8bE16BPAeHMJ+H0ffw/Z/kNl0qLtCoHA8H7ht6zKeb90RSohGa44U1kMtTQUgBu
 dKsMkA3dXsELQ9fjEbSgvC+koVc8Fj7ACfqh9Xa92I3IWq0AWwmMsLjA4FrSa2WQVsVc
 WHSiOW8QElNBNDf69nIcVEGAeBUmdfmLllI6kUYImkILlKpiayOErXFuCsLI5akUp2DN
 IQxNhqe0PnMFLmNtHZLbY9l3gme9th1e5NHazSmJqOZi9KX/69rb2EBLFAJoqMQlOqS6
 Swrn/uhsfO21wPuHRCbISenVjNchP/+yzX/bDhjPO8SmETDtzM3Iv1Og1O7bLEZKsKrG
 aEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783813354; x=1784418154;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DD8ngpZmt3sRDOk6LigSkTSJKrQed+P69f515uIeFdw=;
 b=rMx+gIG5S/mMPwk7pGvgSYaSqUVavrvpGHlkPv8eWD1LyFQfiA6cL8kgodwZxiQBMq
 RUGIke3xetZyzeZDUGmjqchQPzx6oymvBeezgpVyGPF5Ghu1HHBL8lNEIWLyIgUkKjHW
 SgdcmYId/14M0GvzevITAVPmGfXcq+11zZ3UZ+Js9V4vq4qwMMUbwV2MuAv4eIHS0Ol8
 9cEZ5/Z3hh1uge09yKBvgbYTd5LuO4lE4OOUeC2uccDaMq2lM8kwJBvjay9aCce6c5Mg
 ueRbE7rt3jsgqTLe9uZSGOOjFHxFC5mdplZcUX5z4MPaTuh4nU+my+OxZUq25k5xiA7J
 T2fQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqWEwZiCWmMQxSDZQYcbpsC+n7Ds5Djix22jvHlBAvZUHbl1aGfA7QyHsI8HjCPa8ayESwS+wubSLo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzD97LZ4l0KE/FKttzRZjjjqe9tDq+I6sOcbwmFFqgp7pE/UtWJ
 lO+fhabHOBBis9rLOZh8TKgIdcZam6gxcTCdo8IvTb8o9ajomb54xeYi
X-Gm-Gg: AfdE7cnfmp29fEzcArhrHUJxPV9L7Kgm0aSp4lZGs5s67j/fhKt6Um5D3ZfMaahj/eH
 XX8v0BHpnO9XtVCYt6XEuFr2I5g/q3zm2CGc5Y8bFim2KY5YMbi8Wiw7KmV37/vOASRLR3euby6
 O8rdAzjYnQU6z6pyP/UjKSXjgBw9WMNnubmLHNZYD7vAeVGBy/647nKor/3C+MoZhiQbL8CWVwQ
 24tV3GBht7l3sMfFSKjMwTsPNsemPKB+UfPLFuOKun8P26afg15yV5xPm+TnJjhKB3DyUxCP3ky
 zPjdNGvA7kyLJpeRm/LzZcsQzSiDKw6AJfwGHZNFzwDHTwXmK8s0vx4tocVULc+nU5TAcDAIVEt
 PPOnB1ZGW65KguRJ7OhCXiXpIFqL1jX/SPSpFrGkkbLE3Qd/J5Y7LG7w+8jnhwEvb3/PDRQSnN/
 gWnndHhS4uL8C9UHtgsPfCc1RnJ8PKwIXs50lX+uwC90kUaSC5l2E/Zh+NwJGXJw5dmzL/aOlBJ
 O8+
X-Received: by 2002:a05:6000:2008:b0:47d:dfc6:b27e with SMTP id
 ffacd0b85a97d-47f2dcf8a00mr4044740f8f.31.1783813354222; 
 Sat, 11 Jul 2026 16:42:34 -0700 (PDT)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d843csm71751908f8f.14.2026.07.11.16.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2026 16:42:33 -0700 (PDT)
From: Julian Braha <julianbraha@gmail.com>
To: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: david@ixit.cz, arnd@arndb.de, jesszhan0024@gmail.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Julian Braha <julianbraha@gmail.com>
Subject: [PATCH] drm/panel: fix unmet dependency bug for
 DRM_PANEL_HIMAX_HX83121A
Date: Sun, 12 Jul 2026 00:42:30 +0100
Message-ID: <20260711234230.2236041-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Currently, DRM_PANEL_HIMAX_HX83121A selects DRM_DISPLAY_DSC_HELPER
without also ensuring DRM_DISPLAY_HELPER is enabled, causing an unmet
dependency:

WARNING: unmet direct dependencies detected for DRM_DISPLAY_DSC_HELPER
  Depends on [n]: HAS_IOMEM [=y] && DRM [=m] && DRM_DISPLAY_HELPER [=n]
  Selected by [m]:
  - DRM_PANEL_HIMAX_HX83121A [=m] && HAS_IOMEM [=y] && DRM [=m] && DRM_PANEL [=y] && OF [=y] && DRM_MIPI_DSI [=y] && BACKLIGHT_CLASS_DEVICE [=m]
  - DRM_PANEL_ILITEK_ILI9882T [=m] && HAS_IOMEM [=y] && DRM [=m] && DRM_PANEL [=y] && OF [=y] && DRM_MIPI_DSI [=y] && BACKLIGHT_CLASS_DEVICE [=m]

Many other DRM_PANEL_* options select DRM_DISPLAY_HELPER when selecting
DRM_DISPLAY_DSC_HELPER, let's do the same here.

This unmet dependency bug was found by kconfirm, a static analysis tool
for Kconfig.

Fixes: defab7b01e08 ("drm/panel: hx83121a: select DRM_DISPLAY_DSC_HELPER")
Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 drivers/gpu/drm/panel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index cfbfb371bc67..06bfcef35a72 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -253,6 +253,7 @@ config DRM_PANEL_HIMAX_HX83121A
 	depends on OF
 	depends on DRM_MIPI_DSI
 	depends on BACKLIGHT_CLASS_DEVICE
+	select DRM_DISPLAY_HELPER
 	select DRM_DISPLAY_DSC_HELPER
 	select DRM_KMS_HELPER
 	help
-- 
2.54.0

