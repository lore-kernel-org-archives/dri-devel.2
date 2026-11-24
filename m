Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E4E606A326
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:01:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6568710F52C;
	Tue, 24 Nov 2026 12:01:24 +0000 (UTC)
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazon11022084.outbound.protection.outlook.com [40.107.75.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7DC310F529
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:01:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qnJFsCc2ZT5mw2NeaRBuONPoP+BY4MP3QxhyqeMZRwxXrezaDs/Un+o+91G8kl2IkHQ8UU1j9LVagPXruA3WB/l0UzWjd7EzBqNkuGTuofR9yZFvzNgmeC8o6Qy4A9OK54BzvNnapovAxBaON2DiL2rPNkZoHIpWMNl05yhXsA3ofPRKvjh/XCVH7Eq3m2X+K0lEyk9IRMJ97XcRVTBIW4MVFQo8nGJ6/vyrtLmmIqT8RDdfhX6N3KjC9wQ6VAHgGE71C5ZoEzfUBbjEi1ktQQ0vo4CiL91eT3glfGeHmfxWi/oLyy+C5xMnnf8HY/WGtkAF4Y5OWByoDpzhbH4CGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++zMZ68yy/WiSeK/nrJoBCtpDmFpvZ4ygxM7WvpF9e0=;
 b=zBMwg4rtyPiRtt8wBVkzBdLDf20k5/eDiWcMk1Kb0cjzVeINo72vSB9221oLiWiqO0kcNfYtAupt3EuAo3/9jBXzb/GkpNQZYKjRyp5PUpFcXqZ/x72vE6keqD7ryzXecut8NePdBqj6kaQs3KavYp7065lj3xhrlFy7/0wzAwpBmRMjDO8QWgIWw8NYbrhmNEN/3CunPQo/RT7Mwhk6yRIOsJMqsGS9T7ylyc41J92eHH8oy+CAL0/ZifBSjQ43GXxXyuJQIj2edo+Qo7/lAOV8XvEBEi/q638Hnj6ubPeFtXHfLke+qZcZc9dAVLFMy9MsT86RB7p33Y+xuY4V0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=bootlin.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:300:2d::24) by SEZPR06MB5560.apcprd06.prod.outlook.com
 (2603:1096:101:ca::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Tue, 24 Nov
 2026 12:01:17 +0000
Received: from TY2PEPF0000AB86.apcprd03.prod.outlook.com
 (2603:1096:300:2d:cafe::99) by PS2PR01CA0012.outlook.office365.com
 (2603:1096:300:2d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.5 via Frontend Transport; Tue, 24
 Nov 2026 12:01:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB86.mail.protection.outlook.com (10.167.253.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 12:01:15 +0000
Received: from localhost.localdomain (unknown [172.16.66.33])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id BC269427EFD6;
 Tue, 24 Nov 2026 20:01:14 +0800 (CST)
From: Luo Liu <Luo.Liu@cixtech.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, luca.ceresoli@bootlin.com, wuyi.shen@cixtech.com,
 cix-kernel-upstream@cixtech.com
Subject: [PATCH v3 1/5] dt-bindings: display: add CIX Sky1 DisplayPort
 transmitter
Date: Tue, 24 Nov 2026 20:01:10 +0800
Message-Id: <20261124120114.3273161-2-Luo.Liu@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261124120114.3273161-1-Luo.Liu@cixtech.com>
References: <20261124120114.3273161-1-Luo.Liu@cixtech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB86:EE_|SEZPR06MB5560:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 38766865-bcc8-4878-1cfd-08df4a22a4b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|42112799006|1800799024|36860700016|23010399003|7416014|376014|18002099003|22082099003|261009221227099003|261009223027099003|3023799007|56012099006|261102123227099003|261021121427099003|261026121527099003|261026140227099003|261021135927099003|261028144727099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info: 9dhIiJc/0ldTz9bVuaDfAxnpfUTj9CuI9arVcutptrKRnxrcHrCDnKM/mvgX9WWsJN31X1Gy7yLMQxxK5hfHa/UjN65mDxQ/iE1mlq2MI1jIUH4hjxwvRzkfqQJ3WSi1cQXosudCosZ6xdQAK5sGTaXYoFWH16via+KKjfXKR657hH2C2w/SYF2w0Ddkf7xUwRc156hPnUBLIkI+DKQXlwuvN9tMcH3g9fjQzpa+mD7xQ2pytI4EbrxXE0C+lEwIl1aumQl6xvJu/rF6vNRAjHTpIJai2KqIdndRmu5yxd6zmqSQ5uPVULMNniIryMasq4Uzb0KGpbADgbnKx7fxknFnDPRCuXEXkcV66jRRS5Hbj0OBUhLRp+g7TLeD5CCqBrt/q9i2Sd7Vod+HBSpBU986luwHxHpCi4L7DLCjvKdo4bHsEpUb09nFFKOGM73tfJ3lBMzhdfmrjOMGv7VAK5dZhpgvmSoNZ8wUMKcXcakZG78yZHv0ITafsZa1300+CT53thdr0OuNi/8WAygC9bdf1tun/mSfoyjVjxdE5ysahtwJbDbh0UQjzdyu+ElvHQaEpy7ji//oHQ9U2MnS3yejhJJ33fGziym4Q9DcXjqINgIBcukIypXGY2ZpgjA/JflII/mtIlNFR71/WD09JA==
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(42112799006)(1800799024)(36860700016)(23010399003)(7416014)(376014)(18002099003)(22082099003)(261009221227099003)(261009223027099003)(3023799007)(56012099006)(261102123227099003)(261021121427099003)(261026121527099003)(261026140227099003)(261021135927099003)(261028144727099003)(261022105027099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jLDAJI3AFaOXrWuQy+R5u+3Y7oaA+C1UCt+v+/rvOVnNo5fiF9ac/1p2j6M3L8n4sVHPEfraTbizOPoEAuDRK+TxsRJ3BkOcBjPDVBYy6pIiRiI0STAaNCfYNjkqypEs93uye61cRN/n+BbZH1cY5hmdexjhC0DOx+3/u8vPG99kcTn0YIEVi67xgq878f+G4bqAyW7yH7YJxYynsiYCekeO8Ed6EsyF0dmr2A322MNTX5hBarOKU//h/LuWz5HCs6lV+vEHiL0SN9oyQJPOCwTK3cihhgisaHoFBxgz0APJjL3MUV5Cie9nYnQ0fRrEyntQixPcASH/scB4aofbMHO5285PwQHXyE/gFKghDGTbCjGNI3gOpOyFQoGx4Bf8vYa/70/yv8fSt9E380uE5MPL8krmlE0Nc+uuZXxNWja+Mqb1ppDKJzkh8/bUWpJj
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 12:01:15.8872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38766865-bcc8-4878-1cfd-08df4a22a4b5
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF0000AB86.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5560
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a binding for the Trilinear DisplayPort transmitter integrated on
CIX Sky1. The USB-C and the native DP/eDP transmitters use different
RCSU video-adapter register offsets and bit layouts, so each has its own
compatible.

The transmitter takes its video stream from the display pipeline through
a single graph port and drives the link through a generic PHY.

Signed-off-by: Luo Liu <Luo.Liu@cixtech.com>
---
 .../bindings/display/cix,sky1-dp.yaml         | 102 ++++++++++++++++++
 MAINTAINERS                                   |  12 +++
 2 files changed, 114 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/cix,sky1-dp.yaml

diff --git a/Documentation/devicetree/bindings/display/cix,sky1-dp.yaml b/Documentation/devicetree/bindings/display/cix,sky1-dp.yaml
new file mode 100644
index 000000000000..bc3c0a3a815f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/cix,sky1-dp.yaml
@@ -0,0 +1,102 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/cix,sky1-dp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: CIX Sky1 Trilinear DisplayPort Transmitter
+
+maintainers:
+  - Luo Liu <Luo.Liu@cixtech.com>
+
+description:
+  Trilinear DisplayPort transmitter on CIX Sky1. The transmitter takes its
+  video stream from the display pipeline through a single graph port and
+  drives the link through a generic PHY.
+
+  The USB-C transmitters and the native DP/eDP transmitter use different
+  RCSU video-adapter register offsets and bit layouts, so each has its own
+  compatible: "cix,sky1-usbdp" for the USB-C transmitters and "cix,sky1-dp"
+  for the native DP/eDP one.
+
+properties:
+  compatible:
+    enum:
+      - cix,sky1-usbdp
+      - cix,sky1-dp
+
+  reg:
+    items:
+      - description: DisplayPort transmitter registers.
+      - description: RCSU video adapter registers used for link setup.
+
+  reg-names:
+    items:
+      - const: dp
+      - const: rcsu
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: APB clock of the controller.
+      - description: Video clock of stream 0.
+      - description: Video clock of stream 1.
+
+  clock-names:
+    items:
+      - const: apb
+      - const: vid0
+      - const: vid1
+
+  resets:
+    maxItems: 1
+    description: DisplayPort controller reset.
+
+  phys:
+    maxItems: 1
+    description: DisplayPort PHY the controller transmits through.
+
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description:
+      Video input from the Mali D71 display pipeline (Komeda) that drives
+      this controller. The link to the sink is through phys (USB-C combo PHY
+      or the native DP PHY), not a second OF graph port on the DPTX.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+  - phys
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    dp0: dp@14064000 {
+        compatible = "cix,sky1-usbdp";
+        reg = <0x14064000 0x4000>,
+              <0x14050000 0x400>;
+        reg-names = "dp", "rcsu";
+        interrupts = <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&dpc0_apb>, <&dpc0_vid0>, <&dpc0_vid1>;
+        clock-names = "apb", "vid0", "vid1";
+        resets = <&dpc0_rst>;
+        phys = <&usbc0_dp_phy>;
+
+        port {
+            dp0_0_in: endpoint {
+                remote-endpoint = <&dpu0_pipe0_out>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065..75122afe495e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6522,6 +6522,18 @@ M:	Satish Kharat <satishkh@cisco.com>
 S:	Supported
 F:	drivers/infiniband/hw/usnic/
 
+CIX SKY1 DISPLAYPORT TRANSMITTER DRIVER
+M:	Luo Liu <Luo.Liu@cixtech.com>
+M:	Wuyi Shen <wuyi.shen@cixtech.com>
+R:	CIX Linux Kernel Upstream Group <cix-kernel-upstream@cixtech.com>
+L:	devicetree@vger.kernel.org
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/cix,sky1-dp.yaml
+F:	drivers/gpu/drm/bridge/trilinear/
+F:	drivers/gpu/drm/cix/dptx/
+F:	include/drm/bridge/dptx.h
+
 CLANG CONTEXT ANALYSIS
 M:	Marco Elver <elver@google.com>
 R:	Bart Van Assche <bvanassche@acm.org>
-- 
2.25.1

