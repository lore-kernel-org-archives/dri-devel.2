Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CF4606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 06:46:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 198CC10E00C;
	Tue, 17 Nov 2026 06:46:01 +0000 (UTC)
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11023124.outbound.protection.outlook.com [52.101.127.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F11DC10E00C
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 06:45:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUa3u+Q/D6z6wgFonkKxcoerOkkdc5wh+TgvUq6KEErX5koUjF9MPXemrAYY418wBxeJ5kWG0EViHf/LPQrwfa+88Q8ljLUKzO3i/DxogDivFxB274dl1mx6cWSEARg0Yx62itvlVutMPFs67QbLyMRlWijsJUuagqHauHUAlq2l5KKykVWC0A09UP1495rLhF0hJOh3HuadSk2eswnw3XQieUdDFejpMCybcTlWBHmMKXDocYqfbMgmQKz/ttkuADoANOIFwgxOWIACx5kz+exTprqLEZW12HrlO7Ojl4YcHgwODqQyt2keTuYn5hetdRqhiINHEoqeKkcGQNJ+Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25Ko08uJ2oaZ6RdGr4pw+6a6N3d7d4Pf7+rWmh7ePzw=;
 b=UL72f8/P7a9tD19pguA/aElooVXCRfH9erY1as0OjwsA1UMDwAx16qSgCyEj+XSxVPYPVFFfyesP+opV9jy5pNpJDIJmol1LCfFdbmjTw53nIQKZMUnw50fiM3A1H9vcnQdhIltUXlmBdYo4v9u8HxoUfKKqF5mmYZYRePVylr0k79gee5pMpVUwGIvVq/xJcxSHTyfJWwsZRBs9tmXhPzlrMu+jGmXq4rn0mmqtY+XN9JZj5r4vEzlov6sJgn+jG5dVEdW9kMNeMBQonxksrPk8afzIh/kPP5Mwdl7J8mLO4YgHfacXQrTsmn6gxC3uEtgkhCIrpMR2QnYUisuZCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR02CA0072.apcprd02.prod.outlook.com (2603:1096:300:5a::36)
 by KL1PR0601MB5677.apcprd06.prod.outlook.com (2603:1096:820:9d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.8; Tue, 17 Nov
 2026 06:45:55 +0000
Received: from TY2PEPF0000AB86.apcprd03.prod.outlook.com
 (2603:1096:300:5a:cafe::83) by PS2PR02CA0072.outlook.office365.com
 (2603:1096:300:5a::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 06:45:55 +0000
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
 15.21.639.5 via Frontend Transport; Tue, 17 Nov 2026 06:45:54 +0000
Received: from localhost.localdomain (unknown [172.16.66.33])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id B99D4427EFC6;
 Tue, 17 Nov 2026 14:45:52 +0800 (CST)
From: Luo Liu <Luo.Liu@cixtech.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 Luo.Liu@cixtech.com, wuyi.shen@cixtech.com, cix-kernel-upstream@cixtech.com
Subject: [PATCH v2 1/2] dt-bindings: display: add CIX Sky1 DisplayPort
 transmitter
Date: Tue, 17 Nov 2026 14:45:51 +0800
Message-Id: <20261117064552.85256-2-Luo.Liu@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261117064552.85256-1-Luo.Liu@cixtech.com>
References: <20261117064552.85256-1-Luo.Liu@cixtech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB86:EE_|KL1PR0601MB5677:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d64cc436-7a7f-4168-4174-08df44766d92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|42112799006|23010399003|6133799003|261009223027099003|22082099003|18002099003|3023799007|261026121527099003|261026140227099003|261021135927099003|261028144727099003|261102123227099003|261022105027099003|261021121427099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: yWhdrX4I0B7ElS85WazSfxPL/v76BB/BcWb4uokkXF5heRECAsAlgWwD71twlzdJTqRWVP0cNsiveLAIDUbuLuds8fnBb9tpZf+l06Z7knhRK0DbZVFwTQiwLwzkIaURSdBfQ1KktWM0wMvOlT54eHr4rQrMuce0/I64zi57lyqed8RiKpc6x0T5zCWFpEAvCoNb3U+esthp6Ulla4FWcR0A7y5VR2x91haPuzU6/ZYDJL0THgv3EVx0IIj9c2YYAp5/cLxrpHaqEop2O2/YkMA0SrATW4EE/T+QXfu6sv5btSPLo/rxEIabKd9TK1tlnHoaj2H0gemOcCjXHybzpVQ48zmgulNGzSQGEdRNL+08coTqaiOAkqW6vhkfUkmgg0C5RQPhhqr84TjP56GhAw5Zu96+eENXtgF3yW8FDgEpvrGcYi465WiFT/7fa+d8QQHRYFTCqkGYy444XbxT2egun77M0pH80OxhFUuRo1JLlHNtwptshedGG4QjTzmJ+gOlSWpANnq1LRM1qnl6YmShIoPrMsHjhaMKgUdb+fGBPetK2Te6KbQPY3ZzdwnbOY9r9gTytbx0oN7heCGQ4CvUvfV7kLdiNe7mceQ/H0fIJ4oCEDEtP8yvp43Ak1UukgizDNL3CvQpkoXo67RyJA==
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(42112799006)(23010399003)(6133799003)(261009223027099003)(22082099003)(18002099003)(3023799007)(261026121527099003)(261026140227099003)(261021135927099003)(261028144727099003)(261102123227099003)(261022105027099003)(261021121427099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9mnB/br/LCu440e+zN4k3MDoLlM3ADyYI88EzK+w7Q3AC8fSmv7Y3OLoJaJL7ZHgE3IvCzQ0labFhp/lGOI/dANbhGealqNDzKkLFavXJ60nH0IVC7eWiqGsSyUDW2bdFgL5Zei7CM8AzPMOrce7igLrYNv2jrTPRaB81kVCIdmnGUqqaDCTO4okbRQ3NNqTFAS5c1++kX5O4X5ZHYsrIw7iRsVN5GZQBYNfPtNwfrB8BbFc/565uey8oo+eWPLF+4hEW2kVLo3k3BVA/B8529VxV/dpNIf52O5mQdnbovJQ4a+dSiwKx3MH2UMGqiITtK8+o3s1H2JBovVjj6ePKuKeaLanuINFW7efgfyDSKEbCChURc2Gac0m0e+hI3PEuvT2Js/agTpzMQ8EhSbFWlonf6MjeGJ4qWa9Pkw8SztTlin8TmyusyFjzIffDR1D
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 06:45:54.2782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d64cc436-7a7f-4168-4174-08df44766d92
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF0000AB86.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5677
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

Document the CIX Sky1 DisplayPort transmitter. Each instance sits
between one of the SoC display pipelines and a DisplayPort PHY, and
exposes the DP register block together with the RCSU block used for the
link setup.

The USB-C transmitters and the native DP/eDP transmitter use different
RCSU layouts, described by "cix,sky1-usbdp" and "cix,sky1-dp". The
controller is a DRM bridge. Its video input is linked through the OF
graph, and the DisplayPort PHY is referenced through the generic PHY
framework.

Signed-off-by: Luo Liu <Luo.Liu@cixtech.com>
---
 .../bindings/display/cix,sky1-dp.yaml         | 99 +++++++++++++++++++
 MAINTAINERS                                   |  8 ++
 2 files changed, 107 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/cix,sky1-dp.yaml

diff --git a/Documentation/devicetree/bindings/display/cix,sky1-dp.yaml b/Documentation/devicetree/bindings/display/cix,sky1-dp.yaml
new file mode 100644
index 000000000000..ec6d02989b58
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/cix,sky1-dp.yaml
@@ -0,0 +1,99 @@
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
+  Trilinear DisplayPort transmitter on CIX Sky1. The USB-C transmitters
+  and the native DP/eDP transmitter use different RCSU video-adapter
+  register offsets and bit layouts, so each has its own compatible.
+
+properties:
+  compatible:
+    oneOf:
+      - description: USB-C DisplayPort transmitter
+        const: cix,sky1-usbdp
+      - description: Native DP/eDP transmitter
+        const: cix,sky1-dp
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
index 93abbb315065..e3557e931c94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6522,6 +6522,14 @@ M:	Satish Kharat <satishkh@cisco.com>
 S:	Supported
 F:	drivers/infiniband/hw/usnic/
 
+CIX SKY1 DISPLAYPORT TRANSMITTER DRIVER
+M:	Luo Liu <Luo.Liu@cixtech.com>
+M:	Wuyi Shen <wuyi.shen@cixtech.com>
+R:	CIX Linux Kernel Upstream Group <cix-kernel-upstream@cixtech.com>
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/cix,sky1-dp.yaml
+
 CLANG CONTEXT ANALYSIS
 M:	Marco Elver <elver@google.com>
 R:	Bart Van Assche <bvanassche@acm.org>
