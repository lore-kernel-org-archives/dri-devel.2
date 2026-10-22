Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB2E606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 15:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=iuxeV4ST
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3B50112730;
	Thu, 22 Oct 2026 15:31:39 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CFF3112759
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 15:31:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=obO7iUO3P4c6YzJ9RXfmJwLXlpHHZ5/ds8OSNEOf4vwRtAfEJspj1BpTCYO870dX+U0A/CWB4M8YK9pIq4e2z6urRxywBhU2Z12XcUMzBMi50euKo/+sU5k09fr9z9IAzzRlR8zmypf73BabQ0mhKysnoonoQ+Q4oOfAgVXX9KxUY8bsAxca3cbjjoM1P6IfTSQHhsA50DbCLGcjGbhQTPQfchJcDvNX6G00AaPARidXWeO0tFCtfUDZsUvaIcdu4HUXcJxkSXEHGpHjXozk+xl32N1Cc0LU9W3JnmMpCePZYlsB/6pXdV1iqxsSXHlf2ObW8Tnl48MdNa2FZnYoCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjlQ4ylDTBzz0mmFZjJUZEaoqsQqBjrnvyo+xddykRI=;
 b=luHhtDcWtoNcSsT6/Rc7nZZCn/V0K6U03VzJfOpDFgANyroXjjBQfFg1tufqi4X1ZSo0OAiZ3Ho7ENrOkVoEEbr1FWlrTNbtXVisEYq510pw0r/Fi40gNdQ4lrR5nyinbPVyGZFbrjXBbQmnFTImAck8tffIllWJjbt7wFka4SspG6QaUKCQj/5nc20mrIm4BQwt8DddUqilZBW7oDwrDK0PL1wcWyEvMyo+pT/o9jEVBM20Pf9GkqoO14lQ7qIR22ctj8VGn5BiGKm/Du7VJNMVSDVPLgStFGI/1b96Z1ZvLDYCs8rGx2PrKy8kWbD3QIkXTymLagZsmquxzYGZIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=axis.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjlQ4ylDTBzz0mmFZjJUZEaoqsQqBjrnvyo+xddykRI=;
 b=iuxeV4STYztMBWkIsKvSzzFalhpYU+jWK9lI+VBO0/KbKB0abjL077RpxCDJnxotRgfqk+eBdXjbhpHX2uYMVyBOs+mMWpRlbngv4ViWSUuf2xw9ry4VRuPYkwBjVBMLK58cXqd9ORCjxZ3D/D6Q3LfK6uF/O6RyVa5tRqMHXe8=
Received: from MA2P292CA0013.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250:1::6) by
 GV1PR02MB10810.eurprd02.prod.outlook.com (2603:10a6:150:161::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 15:31:25 +0000
Received: from MAD0EPF000008B9.eurprd04.prod.outlook.com
 (2603:10a6:250:1:cafe::4e) by MA2P292CA0013.outlook.office365.com
 (2603:10a6:250:1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.17 via Frontend Transport; Thu,
 22 Oct 2026 15:31:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 MAD0EPF000008B9.mail.protection.outlook.com (10.167.241.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 15:31:23 +0000
Received: from se-mail11w.axis.com (10.20.40.11) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Thu, 22 Oct
 2026 17:31:21 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 22 Oct 2026 17:31:20 +0200
Received: from pc51726-2243.se.axis.com (pc51726-2243.se.axis.com
 [10.88.125.62])
 by se-intmail01x.se.axis.com (Postfix) with ESMTP id ED9423C5E;
 Thu, 22 Oct 2026 17:31:20 +0200 (CEST)
Received: by pc51726-2243.se.axis.com (Postfix, from userid 15273)
 id E752A602FE58; Thu, 22 Oct 2026 17:31:20 +0200 (CEST)
From: Lars Rask <lars.rask@axis.com>
Date: Thu, 22 Oct 2026 17:31:06 +0200
Subject: [PATCH 2/2] dt-bindings: display: sitronix,st75156: add example
 for SPI
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261022-add_st75156_support-v1-2-582525a39a39@axis.com>
References: <20261022-add_st75156_support-v1-0-582525a39a39@axis.com>
In-Reply-To: <20261022-add_st75156_support-v1-0-582525a39a39@axis.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <kernel@axis.com>, Lars Rask
 <lars.rask@axis.com>
X-Mailer: b4 0.14.3
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008B9:EE_|GV1PR02MB10810:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d7e1474-a9e7-40b0-979d-08df30518761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|23010399003|261009221227099003|261009223327099003|261009221727099003|261009223027099003|261009220027099003|10067099003|56012099006|3023799007|261021121427099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: t5lIPDEOZUCI3U6BVjOOIL0XHOdFQNEBQofxTYprJWvL1RcZM5LyGSZ5eofixracOZNdRJpksrNf4xtpae23ycP9NvvmD96bp708pHMIHYHuVK0CFpIG83999QF8MEcBPRdT+RV6bhUeHUQhdJGWjaRD3uUHA30PP8VPK+qNWQ/E9vuyn08lpFFEOn5XC5AP9/oopjHC3yUQTlu2FMCBqJxh0I5YnJpX1hUYD2tJUOtP+YOH2Y/lhYpAHXevmyVIPNnB4IlJgJ/vIonfmiwfegXKnV1AEZ7y6iXG60P1nvIQ/7cq4TfUJ01e2HcyIHoHqqkxaLa0N48/AlIN1IpkBZIkIcTriZw2Y7Keirh/MDgOU7fuyzPyBmZYtYsGE4yso7U8OJYeNY9oZIdDbO4jImIZkaEjItV8MBB3SIDzv7WSW1WHODLH1h5dwnvOcnt8mgWs1rhppYqMYZLWMLArtxLB9DFqotJbrrHNKcyS8+x4UDukD7orIhlUXjis7aoKLR6JvoyacY1IofrjZG0NjcEqiGxkJpxZdbuhEYEfSeAZvUyZ4Oatg47t1muAM9cDa1UohDnCGrYU6pldg36LRBFz2NJ+3Z5ihnLMYPA1dxWTVhWPNW4FmlPwk5F+lMoNU+1e1p6gz4bQSch6iaKNPg==
X-Forefront-Antispam-Report: CIP:195.60.68.100; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.axis.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(23010399003)(261009221227099003)(261009223327099003)(261009221727099003)(261009223027099003)(261009220027099003)(10067099003)(56012099006)(3023799007)(261021121427099003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: D4441GyAOtEq+YfP/ArZd0lNN9EoGMn+GF43oUnpn2QyKDxrOKa6+Fl3OXBULhAR8ZEUFYieKjSjaoehn4ZwDd8rMZb6z5WrhunDNrddCas9chxWRz/OaGF+tnxRp8zjtRtlBHxsbHIqiEnnEW+Mu/oKpyxn2QWJ10Wkyb+ZIia2IepdoaJN0dj0v9wBXvz/eLIrv24JKdIRxnPXs3LWduMTAAa8DfHCtTVMAGHUcDjCItx19ZBNgXUlA1gtNnl9tm+jTkRSSkAmQBxN87xwqhkVFwMGTkTP6KFGRfPF4OKNt7ha033unQFEJ5K4v8SNc72PMxtC5Lds0qWyRw0cfvffYtuWZSXdJKVLlKtieYGLQFRrYGkCoZVrs96aRu1iJRFT17tBhYI4uMNC9aa1JFIn3ccoFLP7dajKNMeMdjOpb0wifNt5NdL90XcbLQZ0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 15:31:23.0846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7e1474-a9e7-40b0-979d-08df30518761
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af; Ip=[195.60.68.100];
 Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008B9.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB10810
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Lars Rask <lars.rask@axis.com>

Add example for using st75156 with SPI.

Signed-off-by: Lars Rask <lars.rask@axis.com>
---
 .../bindings/display/sitronix,st75156.yaml         | 67 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 68 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sitronix,st75156.yaml b/Documentation/devicetree/bindings/display/sitronix,st75156.yaml
new file mode 100644
index 000000000000..a3897ddc5e38
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sitronix,st75156.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/sitronix,st75156.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sitronix ST75156 Display Controller
+
+maintainers:
+  - Marcus Folkesson <marcus.folkesson@gmail.com>
+
+description:
+  Sitronix ST75156 is a monochrome dot matrix LCD panel used in SPI 4-wire mode.
+
+allOf:
+  - $ref: panel/panel-common.yaml#
+
+properties:
+  compatible:
+    const: sitronix,st75156
+
+  reg:
+    maxItems: 1
+
+  reset-gpios: true
+  width-mm: true
+  height-mm: true
+  panel-timing: true
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - width-mm
+  - height-mm
+  - panel-timing
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      display@0 {
+        compatible = "sitronix,st75156";
+        reg = <0>;
+        reset-gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
+        width-mm = <37>;
+        height-mm = <27>;
+
+        panel-timing {
+          hactive = <128>;
+          vactive = <96>;
+          hback-porch = <0>;
+          vback-porch = <0>;
+          clock-frequency = <0>;
+          hfront-porch = <0>;
+          hsync-len = <0>;
+          vfront-porch = <0>;
+          vsync-len = <0>;
+        };
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 8014b9f8253e..9219916d8876 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8432,6 +8432,7 @@ F:	drivers/gpu/drm/sitronix/st7586.c
 DRM DRIVER FOR SITRONIX ST7571 PANELS
 M:	Marcus Folkesson <marcus.folkesson@gmail.com>
 S:	Maintained
+F:	Documentation/devicetree/bindings/display/sitronix,st75156.yaml
 F:	Documentation/devicetree/bindings/display/sitronix,st7567.yaml
 F:	Documentation/devicetree/bindings/display/sitronix,st7571.yaml
 F:	drivers/gpu/drm/sitronix/st7571-i2c.c

-- 
2.43.0

