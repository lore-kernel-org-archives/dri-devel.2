Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A59C982D8
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 22:49:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9334610E2A2;
	Sun, 20 Sep 2026 22:49:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ahTYXpCH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABEC510E2A2
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 22:49:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 95B9A40831;
 Sun, 20 Sep 2026 22:49:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80DC91F000FF;
 Sun, 20 Sep 2026 22:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789944555;
 bh=6VNHUz/mKqYKFo+tObu04b8nZC1YCccRQBtdvelA5jw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ahTYXpCHzq9SF9NDyYq1tsKIIfy9DP0rOvz7+KkWkm6V/LPigIE9hYwfqvyda6iIw
 t9r40tnxT2IA9OR/NhdvtquBSdWLTgGFSSoJqa8TyQ9FFZot/iuYD2wKUnPhaZwI6A
 BqU3iHvAw9p3qjA5n8+4VFff5ua4peMer8GKdfUeUAsi5koe63Ib6sV8YjDn5BLLUp
 8SHFnupRN//u8pobpKj3YRB7E/1WCZ1caDTm+htDsIL1c5uG26I/L97IFVLt3eitLx
 Kb4B9uC6y3QdFPiqzrx/HOvTFEki+YPvOSHPbmcsUOTM1wuBBzc3rh/mE+Nxo9kV0t
 AwSStqRrcd75w==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 21 Sep 2026 00:48:20 +0200
Subject: [PATCH v3 14/18] misc: sram: Enable runtime PM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-ux500-power-domains-v7-1-v3-14-9352be6b86b1@kernel.org>
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
In-Reply-To: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Mark Brown <broonie@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Lee Jones <lee@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 dmaengine@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.3
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

Enable runtime PM for generic SRAM devices after probe has initialized
the SRAM mappings and partitions.

This lets SRAM devices with attached power domains be managed through
runtime PM references from their consumers.

Assisted-by: LLM
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/misc/sram.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index c8990e83a65a..7f19dca7b818 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -13,6 +13,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/mfd/syscon.h>
@@ -425,6 +426,10 @@ static int sram_probe(struct platform_device *pdev)
 			goto err_free_partitions;
 	}
 
+	ret = devm_pm_runtime_set_active_enabled(&pdev->dev);
+	if (ret)
+		goto err_free_partitions;
+
 	if (sram->pool)
 		dev_dbg(sram->dev, "SRAM pool: %zu KiB @ 0x%p\n",
 			gen_pool_size(sram->pool) / 1024, sram->virt_base);

-- 
2.55.0

