Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 333C0CD13D3
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 18:33:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B29F10F410;
	Thu, 30 Apr 2026 18:33:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VIgptaJs";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012045.outbound.protection.outlook.com [52.101.53.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29E6310F3DB
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 18:33:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZj0NgtD8kGifuxGyykjAQNDQ0azTy6I8SwL7RExBtEVEffW40Bhsqra3ryggpvaOWKdX+fGBQzleEIG+Kk8H1g9fB/RRX82bB/uG8Pe1fFeJnL0js040dVywo4xpY/kVHlnoeesPXYhdzeLt6AUvIF9u6ddnbMEpwAf1e0sFfTUYjzepgTKmYZdwLREzh0p6SEbHj2DyaH0wUOO38VOEROb3FnRf4GbE3pot2jrIfeKtRhS/P+fZRsy9hiAYfVxt18JTUFhsBaPYAm15RBhOP7CfzCY6N1A7RPWskzcGLhuYEj9R2nQiaq4oPvsnvxC94gQOHkNiF/9I68SbqWVOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERxNfYZCnP/NREDFq1h/C39zNTLhHfJ8j8jGO6YGxKg=;
 b=dgBnS5hDYEYXLBz1PpyWV9RG6vVV0KjsljKhJPyP53IwS45MMximDMx24CtS+T8RBzBvD55mdEQSp64wbf8AQUCYZG07a586Ldw9tzkz11x4NrpNLLFyrZxnyycFCIUhrZxMlDRHhXDtymzRqfY0Fh3NBa/lmmVfWTn1lEsEYiS3UmfL1QJG+d1Cixnjr7arkkaXa5VkC2aKBP+4F8Dz8JI6wJ/lqA/8YqTQQHeNMUf/oMWz1a0Bz8IVpoZhaIk14BQf0RqAKe2fMchjs3FAWDW10nHmMYLMbcpYgJpntHWL/TqZE5sujTpoNazUGYMhVwcFMFff3TUrVe5Q3LPFiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERxNfYZCnP/NREDFq1h/C39zNTLhHfJ8j8jGO6YGxKg=;
 b=VIgptaJsYjxJdmGFUUWJeiXiOVmpftg1Y/3C986havGOmnkzZ6ifc9RQDl9cR9Tu6jNRJgVMMxqRqTS0EsNYQmfQyh6FSe1JbCDFooGq8UHXyz5U5wVHIqBP4tskvKr/rVwSQXHZP8uaAfxLwgsnftQKHOj40EchDaUL3NTBFv4=
Received: from BY5PR16CA0012.namprd16.prod.outlook.com (2603:10b6:a03:1a0::25)
 by EAYPR10MB997927.namprd10.prod.outlook.com (2603:10b6:303:2d4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Thu, 30 Apr
 2026 18:33:45 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::31) by BY5PR16CA0012.outlook.office365.com
 (2603:10b6:a03:1a0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.31 via Frontend Transport; Thu,
 30 Apr 2026 18:33:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.22 via Frontend Transport; Thu, 30 Apr 2026 18:33:44 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 13:33:41 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 13:33:39 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Apr 2026 13:33:39 -0500
Received: from localhost (ti.dhcp.ti.com [172.24.233.157] (may be forged))
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63UIXcff1698518;
 Thu, 30 Apr 2026 13:33:38 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, "Bjorn
 Andersson" <bjorn.andersson@oss.qualcomm.com>,
 <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <s-jain1@ti.com>, <s-wang12@ti.com>, 
 <r-donadkar@ti.com>, <r-sharma3@ti.com>, <devarsht@ti.com>, <afd@ti.com>
Subject: [PATCH 2/6] dt-bindings/display: Add Solomon SSD16xx e-paper
 controller binding
Date: Fri, 1 May 2026 00:03:07 +0530
Message-ID: <20260430183311.2978142-3-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260430183311.2978142-1-devarsht@ti.com>
References: <20260430183311.2978142-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|EAYPR10MB997927:EE_
X-MS-Office365-Filtering-Correlation-Id: 0959f1b9-ba4d-483e-867a-08dea6e702c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|7416014|376014|22082099003|18002099003|921020|56012099003;
X-Microsoft-Antispam-Message-Info: SOQQCVxBS+jwu77ucoBJTJKB+KEjsepgBcvT61nbaYY6v7n7T4W99j/KL9DbcBY5WyDOl0PEPUB+XVt22BDelAX1qDoI7T0cvDmI4PBOTXIKv9M8Zeuedlj51fwH8Y6c/pWcF0yo2FSnDNLJZXR+jN2zNmZ4CvGBLBnNSd3vYLwp+qzSOXGRU0/+EmQsbK0iwf4xKo/mtMj9AQGgBfgYk5lGXjlbvsdt6XJXTzRrEFjnsp7OsRkKAS3otMEGdbUdAFwsuMka9THP0W6OFzS7N1iH9yyxOozTOuP2CI983ivCLm7zeJ7aHYbXhzBmov6gFkLy1oat6zkXRcD5oMdHkss1225zEGW6OfSQgmI1rUpWuBy1eNGF30oinNpZSOgqFrnU4KzkWjwFG93hQXYVsNB4Nj8I9rTgmvHsxvfzE4tD3X4kAyLVTJq5AgNPILDoc+J/a9kZ6jT3ch2jnDv6/9FuBwRzbaSFtLaY3oJDOQeDpSgW8HvTO6HkwpcW0VDfrDiJP+P7t6T6we/xXB0qJWFEezp7GWarv5sxTQCn7r1RqzqC8cZsFHktFY4CEDYnts5nZ2HxysWZqWml+wlrV3aZHGFdyBYtrgnGttFP6YeOX8OPQ3EUuARZ1dJ5j+T8WBxJiNN/UCvwaUOfgwbDmB+pu8SFu+vR3uoSSsQR0EWKevZoHYaLZsu+V+yGWxZ48wbbcal9UMkg9pKafNoKhlerxS4aZM41UZwuPO+T4IM=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(7416014)(376014)(22082099003)(18002099003)(921020)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: U/kq/G2B88g0qpQGYyyJ15lXXTjqt+0ybh3YREN6ouVABcKPR0mCAUfOezuGHHeLmFDxYe0GImnx80eTnh9lVCruW1k+jVNVGX9x2STQS+OWk3YF/W1Ty8YS0UTFl3jDGYBTthAZZuQR21DcusFIePSPU1SDVBuvDYR3a7wePhENZaxBd7gfqgKL9m+ngT6c6pKAM3Gu3ryhqE5ddcxZ6XOHCRyPt5xKeroJuK7KW1w5qAe2UV7BhKdtpyBzNLRyVnvlQBPnU9VED9ZuE+yg5o6tAVzPwJzklcKdC/gdwOb9hf/4aRzVQFZnzZF5vc05T4oV13w4YqZK3FBSuKZ33F1vOm649NEr3bmWGDG8qlDULwHAJJjz/KymEHC/7BrvCaiIQqzWyWN25WWz1XUE22Ir26+MoYshRfmjHbFd1QRKwO6y7ZNebUlI+XfVGBgn
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 18:33:44.6295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0959f1b9-ba4d-483e-867a-08dea6e702c9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR10MB997927
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

Add device tree binding for the Solomon Systech SSD16xx family of e-Paper
display controllers (SSD1683 [1], SSD1673 [3], SSD1680 [4], SSD1681 [5]).

The binding covers the 4-wire SPI interface with required GPIO pins for
reset (active-low), busy status (active-high), and data/command selection.
The spi-max-frequency is capped at 20 MHz per the SSD1683 datasheet [1]
which is also the maximum supported frequency amongst the family.

An optional rotation property allows static display orientation to be
configured from device tree.

The data/command selection GPIO pin is also kept as optional since various
SSD16XX controllers such as SSD1683 [1] support 3-wire mode too with
data/command selection bit transmitted as first bit before sending the data
sequence.

The first supported compatible is for Gooddisplay GDEY042T81 which is 4.2",
400x300 resolution black/white e-paper display using SSD1683 controller.

Links:
[1] : https://www.crystalfontz.com/controllers/SolomonSystech/SSD1683
[2] : https://files.seeedstudio.com/wiki/Other_Display/42-epaper/GDEY042T81.pdf
[3] : https://www.crystalfontz.com/controllers/SolomonSystech/SSD1673
[4] : https://www.crystalfontz.com/controllers/SolomonSystech/SSD1680
[5] : https://www.crystalfontz.com/controllers/SolomonSystech/SSD1681

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
 .../bindings/display/solomon,ssd16xx.yaml     | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd16xx.yaml

diff --git a/Documentation/devicetree/bindings/display/solomon,ssd16xx.yaml b/Documentation/devicetree/bindings/display/solomon,ssd16xx.yaml
new file mode 100644
index 000000000000..2433ddb859d6
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/solomon,ssd16xx.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/solomon,ssd16xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Solomon Systech SSD16xx controller based e-paper display panels
+
+maintainers:
+  - Devarsh Thakkar <devarsht@ti.com>
+
+description:
+  The SSD16xx family includes e-paper display controllers (SSD1680, SSD1681,
+  SSD1673, SSD1683) with integrated gate driver, source driver and timing controller.
+  Different panels use these controllers in monochrome or 3-color configurations.
+  The controller uses a 4-wire SPI interface and requires GPIO pins for reset,
+  busy status, and data/command control with a 3-wire mode also available
+  where D/C bit is transmitted along the SPI data line before sending actual data.
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - gooddisplay,gdey042t81  # 4.2" 400x300 monochrome (SSD1683 controller)
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 20000000
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the RSTB (reset) pin. Active low.
+
+  busy-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the BUSY pin. Active high when the controller is
+      busy updating the display.
+
+  dc-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the D/C (Data/Command) pin. Low for command, high
+      for data.
+
+  rotation:
+    enum: [0, 90, 180, 270]
+    description:
+      Display rotation in degrees counter clockwise (0,90,180,270)
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - busy-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        display@0 {
+            compatible = "gooddisplay,gdey042t81";
+            reg = <0>;
+            spi-max-frequency = <2000000>;
+            reset-gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
+            busy-gpios = <&gpio1 18 GPIO_ACTIVE_HIGH>;
+            dc-gpios = <&gpio1 19 GPIO_ACTIVE_HIGH>;
+        };
+    };
-- 
2.39.1

