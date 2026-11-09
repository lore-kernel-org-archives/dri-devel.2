Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67686606A326
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 10:30:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94ACD10E5D1;
	Mon,  9 Nov 2026 10:30:19 +0000 (UTC)
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazon11022091.outbound.protection.outlook.com [40.107.75.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B52B310E5D1
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 10:30:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jhvAM/8Jv96SHiW8BvuMi/17SGwHaUYitPIpTZKWouhCR9oymh1pKg0ta8kxQwzygi9GpGviCdYyz/Dwr6GHYKS3I9HAKiMRlYG38WuQK1ZSv89Outiu+qgCknFQcOCDp0NzVXE0qe5a5/UpYmfHDrT8uOkUUY0Xy1yCJhAX1mvb5jfXxTXtk4sOvZKJ7dm9SjVA4BcC8JR1xu2W4lJEgL3ITbhs70j9k68mJjROszji7F0aQjA1r3wfo//0qsLBe5+WTAp3X95tyeBe8XslvptA/SUdKm4T9e+4DvPHIqPbkRvENjzbgUpAcF55kSl8eFjgtxbUA1kYjuw99ysXrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmrOExhgeDcJmUo2FuYvYlpYC/SJWWPXKEAH7LdIv9Y=;
 b=dQGGFBgIwaPIiuhIVH4WqIP/pbne0nfBj7Lx+Gpr8vpN2asslliWAjU75lnUE4HInJxJpQQUAVgNDuDGf/EWokuwt9lWrODNuLHxgrCwYwcQ+FGgbPjeSBn5h5Cy4m3YqAXN0XiszSgHwVP78Glq8mp35BgB6q17yK8fCkoLS5LPH0YPpI8/4PfAq5Rtwr2kpkCf2K8wh7FJwrSOvcV8gWwY22zczins/Yf8ZUjxeOnP3iw7oRehpecKUqOLR8R+Q4FRrX7/H8a+O7muPezUy9s0BzNZVurKJDs4ZqqAVjv+LZSflOhyKzoSWKXs7Z3E8uU9WfR+HWAPFd+PvKA8WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR02CA0046.apcprd02.prod.outlook.com (2603:1096:4:196::15)
 by TYZPR06MB7314.apcprd06.prod.outlook.com (2603:1096:405:a1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.6; Mon, 9 Nov 2026
 10:30:11 +0000
Received: from SG2PEPF000B66CE.apcprd03.prod.outlook.com
 (2603:1096:4:196:cafe::5b) by SI2PR02CA0046.outlook.office365.com
 (2603:1096:4:196::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Mon, 9
 Nov 2026 10:30:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CE.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 10:30:11 +0000
Received: from localhost.localdomain (unknown [172.16.64.56])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id A7CAC4102E73;
 Mon,  9 Nov 2026 18:30:10 +0800 (CST)
From: Luo Liu <Luo.Liu@cixtech.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 Luo.Liu@cixtech.com, wuyi.shen@cixtech.com, cix-kernel-upstream@cixtech.com
Subject: [PATCH 1/2] dt-bindings: display: add CIX Sky1 DisplayPort transmitter
Date: Mon,  9 Nov 2026 18:30:09 +0800
Message-Id: <20261109103010.110911-2-Luo.Liu@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261109103010.110911-1-Luo.Liu@cixtech.com>
References: <20261109103010.110911-1-Luo.Liu@cixtech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CE:EE_|TYZPR06MB7314:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d49b1f03-1c87-4248-739a-08df3e4c6f4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|42112799006|56012099006|261021121427099003|261021135927099003|261022105027099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: mC01mKT2REqePu6tgqU+Y5nz4fa0+OMwX5PttRdBs9ANdGR1puv1hii5a+pdTBr7eihj6P3xX8K0Q3DFyaaxBYWBcp4zEkAh91/bTB2pr/J6Xnk/X7PBQHOMP56R7Bv45Im34kujpQfesHSq9lZAQqeRTu0loGHl5n6OEi3fcFmVCx7KbRwBHp1okMLgyLbAg0qJM6dSHb4qeKxDpB1a/oYqHfhWyFy0567b6Wzdvap+EhRtbYlW1XTSVvBSG2Gn/xV9rsbN00+wU5taouqsSWlworfZ9z46XMKzdocaTfRVAY/kv7O6ItgmL3Cr6WBX9XTnSexkf78g5hUr25aY2JVh0Stqyqh8IzcWsSFpcZZL43mQiVrsZsFBha9kpQMMFv7gX1ZUxUd0iqUERgxexI7uZCagmQdRjJVRcxkaFMGzJNfkNRnZSexu7MQ9rHmXjFgGJ+tyIe6+MhY6QZ9CCPAUj9RedNNdZLuveq2znCd56U0qrr4PxB3PC7XnDEj6vIkc0W4dwcOg/N1dnc00Q+naMhTCxaY91hrIGucJwizt5n/Jo/WXQs5KnjFkC5M/JOHDQ4NwWP8WPju20dL/IMie7OkgRfw63JnrBm0e1gx7RaXGlBe36+vehchX0yh6QazijttzQUk8UuPep6zoGA==
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(42112799006)(56012099006)(261021121427099003)(261021135927099003)(261022105027099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UhlhiohSF4X3pdUpDdj6eD5cBFI0Sb4h50amaZZlPnOUeL/uNJ7T/cDOrHNL87zXbFvBUaf+GK14beq1y4TwT1ZgsVSzsbiswuypitr2/4m/P6m+vCRJIbgHUKleu8jWyRh4D5INuJKZHlY4y5PmL5vH2LYut7AlSCou5G/E9p8Ok2c/bOVB0twuPsOupgo+3ydvwq/TwQupb2BOcuwS3FBXrDQ6rYv+0Bo9kghVGc7YwkW9E2wT7ae2WlV/QnqLkEp96oY841XA6x4RzxsdMWrSDCUs3jpE/qVO9D5kPH8Q5W292qp8GEb92WmeRi45ZsLMT2NdrFF9+xjnf9Y+fpjOhNuIvmJQOmO2Ecj4xTgFowkatgjevRb4WnpeA2odLoKNwOWlocyz59CEjBzJHKGfVzW9ZQDeILM/emLt1xt4DymV6Sbaa63FBFeBn3PF
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 10:30:11.3786 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d49b1f03-1c87-4248-739a-08df3e4c6f4d
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66CE.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7314
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

The controller is described as a DRM bridge whose video input is linked
through the OF graph, and the DisplayPort PHY is referenced through the
generic PHY framework. The RCSU adapter port, the video stream and the
maximum link rate are described by "cix,adapter-port", "cix,stream-id"
and "cix,dp-max-rate".

Signed-off-by: Luo Liu <Luo.Liu@cixtech.com>
---
 .../bindings/display/cix,sky1-dptx.yaml       | 108 ++++++++++++++++++
 MAINTAINERS                                   |   8 ++
 2 files changed, 116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/cix,sky1-dptx.yaml

diff --git a/Documentation/devicetree/bindings/display/cix,sky1-dptx.yaml b/Documentation/devicetree/bindings/display/cix,sky1-dptx.yaml
new file mode 100644
index 000000000000..9087b5edd9f0
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/cix,sky1-dptx.yaml
@@ -0,0 +1,108 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/cix,sky1-dptx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: CIX Sky1 Trilinear DisplayPort Transmitter
+
+maintainers:
+  - Luo Liu <Luo.Liu@cixtech.com>
+
+description:
+  DisplayPort transmitter controller based on the Trilinear DP IP on CIX Sky1.
+
+properties:
+  compatible:
+    const: cix,sky1-dptx
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
+      Video input from the display pipeline that drives this controller.
+
+  cix,adapter-port:
+    description:
+      RCSU video adapter port of this transmitter. Sky1 numbers its five
+      transmitters from 1 to 5. Port 3 is the native DP/eDP output.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 5
+
+  cix,dp-max-rate:
+    description:
+      Maximum link rate the board is wired for, in units of 10 kbit/s.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [162000, 270000, 540000, 810000]
+    default: 810000
+
+  cix,stream-id:
+    description:
+      Index of the video stream this controller uses. Sky1 has two streams,
+      numbered 0 and 1.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 1
+    default: 0
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+  - cix,adapter-port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    dp0: dp@14064000 {
+        compatible = "cix,sky1-dptx";
+        reg = <0x14064000 0x4000>,
+              <0x14050000 0x400>;
+        reg-names = "dp", "rcsu";
+        interrupts = <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clk 0>, <&clk 1>, <&clk 2>;
+        clock-names = "apb", "vid0", "vid1";
+        resets = <&rst 0>;
+        cix,adapter-port = <1>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065..7d5283d83022 100644
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
+F:	Documentation/devicetree/bindings/display/cix,sky1-dptx.yaml
+
 CLANG CONTEXT ANALYSIS
 M:	Marco Elver <elver@google.com>
 R:	Bart Van Assche <bvanassche@acm.org>
-- 
2.25.1

