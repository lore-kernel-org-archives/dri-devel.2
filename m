Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FFCC79FAD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 08:12:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5ECE10EFAF;
	Wed,  9 Sep 2026 08:12:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k+wfndW5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D40C10EFAF
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 08:12:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1F89D443E1;
 Wed,  9 Sep 2026 08:12:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7D4BC2BD00;
 Wed,  9 Sep 2026 08:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1788941525;
 bh=41BQKxDxN/7eDAHTWoqU0llnPuNVgxHvylXeUu0jJ+E=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=k+wfndW5Gk6RaUuQJ16O5eg/R3AQPijDjP6jein4S+YcnqnyWwpISC0o7iRhWoR/Y
 TCamSJyOB7kD75wMrnQ8hxEYd6/OVYFPuGw2RYEUXSkBGqla5ILvNEoCE73H8u59ZF
 DrPrZXN2KN0B65Zb9wfB+6Xmq3fOxK2lOD9Y32jk2IkeB0yBivDzyFdYxh2jq3/C9t
 36y3QJTgi9DdqnSEwYFYlMmmaM90Ta9xnGcLpvTvsY+y0vBG59HygVbTGJcI5ALUhm
 8TZKDHRN6IaMfO/bQ9aHXfYa/fJv/fOzlyWMngpTDN3hw5hjboCYwk3eUd2qfvtDYT
 iOlptGFTPgUEg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id D4944C79FBD;
 Wed,  9 Sep 2026 08:12:04 +0000 (UTC)
From: Joel Selvaraj via B4 Relay <devnull+foss.joelselvaraj.com@kernel.org>
Date: Wed, 09 Sep 2026 01:12:02 -0700
Subject: [PATCH 4/4] drm/panel: ebbg-ft8719: update Joel Selvaraj's email
 address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-update-email-address-v1-4-94a240f9469e@joelselvaraj.com>
References: <20260909-update-email-address-v1-0-94a240f9469e@joelselvaraj.com>
In-Reply-To: <20260909-update-email-address-v1-0-94a240f9469e@joelselvaraj.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Joel Selvaraj <foss@joelselvaraj.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788941524; l=1165;
 i=foss@joelselvaraj.com; s=20260909; h=from:subject:message-id;
 bh=vsAeeSW3w+ssvIy6gSDQz4fsGrrch3NZw9153qCisHI=;
 b=tt3Ct6OmTKkCdgyfIorTs6yKB7jYvq4ymidkt9KLqpjcins4+v5pPR2dYqnRxHSfVt+UIZ7sg
 BRK4cliA86gB1WM23XgL7ah9gnKg+jKcUSHHjUHT0QMK4yrhKa5sduy
X-Developer-Key: i=foss@joelselvaraj.com; a=ed25519;
 pk=UUJ1v4UQJ/nljqj3NjsWt5H4mphWQ7etpQ4Z7JiR2yo=
X-Endpoint-Received: by B4 Relay for foss@joelselvaraj.com/20260909 with
 auth_id=1018
X-Original-From: Joel Selvaraj <foss@joelselvaraj.com>
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
Reply-To: foss@joelselvaraj.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Joel Selvaraj <foss@joelselvaraj.com>

My jsfamily.in address is no longer active, switch to my current one.

Signed-off-by: Joel Selvaraj <foss@joelselvaraj.com>
---
 drivers/gpu/drm/panel/panel-ebbg-ft8719.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-ebbg-ft8719.c b/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
index fb9f9f42be4f2..5ee8b52962847 100644
--- a/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
+++ b/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2022 Joel Selvaraj <jo@jsfamily.in>
+ * Copyright (c) 2022 Joel Selvaraj <foss@joelselvaraj.com>
  * Generated with linux-mdss-dsi-panel-driver-generator from vendor device tree:
  * Copyright (c) 2013, The Linux Foundation. All rights reserved.
  */
@@ -242,6 +242,6 @@ static struct mipi_dsi_driver ebbg_ft8719_driver = {
 };
 module_mipi_dsi_driver(ebbg_ft8719_driver);
 
-MODULE_AUTHOR("Joel Selvaraj <jo@jsfamily.in>");
+MODULE_AUTHOR("Joel Selvaraj <foss@joelselvaraj.com>");
 MODULE_DESCRIPTION("DRM driver for EBBG FT8719 video dsi panel");
 MODULE_LICENSE("GPL v2");

-- 
2.55.0


