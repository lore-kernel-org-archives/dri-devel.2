Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F17C88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 13:11:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1904E10EE3C;
	Mon, 14 Sep 2026 13:11:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="mGpxWB/r";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="anh7omxj";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D467C10EC37
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 09:08:21 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hjzpD1v4gzMl0T;
 Mon, 14 Sep 2026 11:08:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789376900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=CfVqz/R/L8IGGasN30DxQaoQqmCHuzPNM55eeMck95k=;
 b=mGpxWB/rrH8pXYP10kwYBKsZFZnqX5bnxSXNSbDF5MsKcOEQHhy1DHz1Tlz+jtzgDsYleI
 Czc20Ykuno6z8FFqDBH1hbUJOFAidyjpnM0YgsVpxq5JHaY6qOWkfoYDNeCcLyxqdyPBQY
 kNmcrQstV6MzVh/wyzTbS6MyMTMozJTQB3eJEROhDDQU/pyugAVHvvhw833XorL2i4450e
 MK5gIouaB6CsgET/ijpI4Eu136Lk3KH4JaxtHAe77b9nFPOz++5oLjWVq7f1+ob3ceWvdi
 LItQfGqcN7Eh9QSJG1+cv3cK3F3MSQMshj/OqttSrI4UujsnUW8iOxGPWM0HHQ==
From: Manuel Ebner <manuelebnerli@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789376898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=CfVqz/R/L8IGGasN30DxQaoQqmCHuzPNM55eeMck95k=;
 b=anh7omxjH2bBK1vPxt6IR4EuE1oOAB8FinZ+phLrzDeiSRPI40DI2nAyLloQDCCjLUKJjZ
 huxBqlH8FwA9JCNpOxSGRodY/uNsLprsMSXP1w1YbMYRFLuEpw3thEpxtb5rE3XkPXI0oZ
 HefvRS6WDX+8ZGJqRL+zFFcHMD2fPC7op1x4ozE7S8/4GdZKQV/8XeL4H4tt5ejVkxVG7B
 GjDc4UcxnTNTXdgd/J1Odi7md7i6SV2dApf6qzEp89Wp4ZQZ09dRCqHTAFHXesV83SF/yC
 3AAtnMFll3bosVCEO6YEIXymgq1U+QCXbKLGMd6IMd3qp17/DImJsjnO3eZwMw==
To: Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH] staging: fbtft: sort includes
Date: Mon, 14 Sep 2026 11:07:32 +0200
Message-ID: <20260914090732.9712-2-manuelebnerli@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: mszu8b47r5u15fnncfnj9yrxfetzw144
X-MBO-RS-ID: aafc4ef70c6fc470198
X-Mailman-Approved-At: Mon, 14 Sep 2026 13:10:56 +0000
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

Sort header files alphabetically.

Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
 drivers/staging/fbtft/fb_ili9320.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ili9320.c b/drivers/staging/fbtft/fb_ili9320.c
index 050fc2367..0f98267a7 100644
--- a/drivers/staging/fbtft/fb_ili9320.c
+++ b/drivers/staging/fbtft/fb_ili9320.c
@@ -5,11 +5,11 @@
  * Copyright (C) 2013 Noralf Tronnes
  */
 
-#include <linux/module.h>
-#include <linux/kernel.h>
+#include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/spi/spi.h>
-#include <linux/delay.h>
 
 #include "fbtft.h"
 
-- 
2.55.0

