Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D88606A33A
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 03:32:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 295C510EFD7;
	Wed, 25 Nov 2026 03:32:55 +0000 (UTC)
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazon11022143.outbound.protection.outlook.com [40.107.75.143])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB7BA10EC4C
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 03:32:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nAPeDAhtnZLjqaT8S1E63V/TDbQifvA3udSIZ97hT6BgyeQfwPQJlAIn8DmRmTtbOPw8LZ1Y0IfwyFCyQlCaRnRfMy+VZ7JKfP3tXXMfnUBg8Wy4AP4eM4l2gqhxi6mNScw8x7zFuicYMFCCO5EcdLUvgwOnriIqrCK/CLkJHoAuciS0RwtEuYcazG4D+AdPpOHbMg5G/0weYiEQglmk/AbNlgIMx+PJel54VvArK1dXmNHsFRTc5+vrCKcBDar9mktiMeKHsqnurR0qOUWAdnH0LymvSbhuaLCipz/mTXS57q82YgC05Rta96UZCroW6I7pEsPAiNoc9bqezR7AHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkPfqORTmkog2In+HEspCJLoIytiSh+HXkzENmEv9/U=;
 b=dvhxANsFeIsDcG+aGNssuceeRiLC8Be6v6ETZEvg7rYlYCznGekA4wOQN2xugSwOkkHq8inb3TZU0ASA0+lmpT9EvhFSISppVhFrlzxkm0Z/+jmgKKqCcm77LwncR3pMHEbLdQRrfR0xHGvoy5BeneoiSouc3KVA6OIZJRfa4xeCMyz9nvmy3Jd7IWwkyBBlaow/Ob6VBmz04l8PoYQzF59ZLeu94oim5bL/HlMOqbPEm+qUzU6SMhw8anylOlaaLxur+QavtJuwqmNfbJW/UUpBQCtAgJVrwY0n3Fg0wWwK6kDGpNMJgJLt/y+5fDzkjmHUtKzOLTdFK5CHNLgmeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=bootlin.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYZPR03CA0002.apcprd03.prod.outlook.com (2603:1096:405:1d1::19)
 by KUXPR06MB8440.apcprd06.prod.outlook.com (2603:1096:d10:7f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Wed, 25 Nov
 2026 03:32:42 +0000
Received: from TY2PEPF0000AB86.apcprd03.prod.outlook.com
 (2603:1096:405:1d1:cafe::8d) by TYZPR03CA0002.outlook.office365.com
 (2603:1096:405:1d1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Wed, 25
 Nov 2026 03:32:42 +0000
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
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 03:32:41 +0000
Received: from localhost.localdomain (unknown [172.16.66.33])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 23305427EFDA;
 Wed, 25 Nov 2026 11:32:39 +0800 (CST)
From: Luo Liu <Luo.Liu@cixtech.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, luca.ceresoli@bootlin.com, wuyi.shen@cixtech.com,
 cix-kernel-upstream@cixtech.com
Subject: [PATCH v4 1/5] dt-bindings: display: add CIX Sky1 DisplayPort
 transmitter
Date: Wed, 25 Nov 2026 11:32:34 +0800
Message-Id: <20261125033238.3436046-2-Luo.Liu@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261125033238.3436046-1-Luo.Liu@cixtech.com>
References: <20261125033238.3436046-1-Luo.Liu@cixtech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB86:EE_|KUXPR06MB8440:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 93b1f552-b151-4424-ece5-08df4aa4c2f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|7416014|376014|42112799006|36860700016|23010399003|261009223027099003|261009221227099003|18002099003|22082099003|3023799007|261028144727099003|261022105027099003|261102123227099003|261026140227099003|261021121427099003|261021135927099003|261026121527099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 1zN4Qguw9W5lfrPvqXAZsNHO84DtkLcYlMpcYmH2g385AZHZMBAgtYDZt7AXF9v+8DehHEbvY2ktRZnf+D6LZXc/kcCoOqtrcvrsFXSIxzKriqvL3t4HjI7HlQdct5Xj668Eagmoq1Yv0jsIYXUjw2fziqu69dC/KPNsEpKeqDIx+I3AMDpPltKc4k88u6KD7Hxc5vVzKpHBqgmBd2dHa0K3k/4uTB7PFNOvCnC/DLW13huZDwtL8p3KnqhHZUVEfpANOngDEiDpCbbKJTMb+UOV1MD+k5kX5tXGJC5ZBJ7btYbQpI5d+dt71y5vVzXC42sIgdh161AqYXjykrqJiGKQgAv7EBkgJZg7D/G0Ps6Bl4eIL6gF3z1s+9Ploo3o/13aqAIYP2KnyeqVgodl1YE2cbsNfugnvsIfWCxEFNvRWc9gJzrkhvOzG6TK3jFiIaxEd+nwAvqt0S27zcyuVfCoV1d0gwmwtiIaZcYPQPerO5oOzzayJSGkqjBRnCFrMv9n9gT0gqkbk44ucHYyt+ktO/tu6xyCUbMLHDI0AF9kKZHom3z/++oASqf5qJBG2XvF/eLJCIH6FuF80uSPa5BasNbFAdk311w4PyA8Itd/2g3WYm60FjAz2484m55P3ar4iabrwsTUOrGvZVfllQ==
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(42112799006)(36860700016)(23010399003)(261009223027099003)(261009221227099003)(18002099003)(22082099003)(3023799007)(261028144727099003)(261022105027099003)(261102123227099003)(261026140227099003)(261021121427099003)(261021135927099003)(261026121527099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ujDrUPbwyh2arelZB8r4qsKAKoHq1H6yKM4jnUot8QHKJczowwz/C+rXe7Xi0Ce6XXihaKLds5ningCDYyxCox9wU8TBKUdSt9KwfWEyCXRuMhiRrVLB9U0YdONlW8gLgBhMi8ZVQTTh49l446hJDHqbvrdQ7YouAZssHIFTWh57GkDt1YwvmNw49RWObvlOISXypnEeJb0d4xvdgYlI2z3kuy6a/tTY0/BQ4rjVHav9f6d5U+AUys86B9gv0O3EPT9soy5RVz5qZc8BqYMRXBjc1NYr5CydfgC9lB78mWurYwE0ZKun0rJlgfI3p5wviHIzKZ3yr334ZzAoSs77XR1Ty0BOB5dcRMDczI5Pwsm5ACLPlTrm5hwf4jFbTDBBhJR1Dc4yWCpHR2fisbyhP6epJPV01vwuONpzwi2rKX0pVABo4wvMrMJDlaID36jJ
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 03:32:41.2528 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b1f552-b151-4424-ece5-08df4aa4c2f2
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF0000AB86.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR06MB8440
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
index 000000000000..5095d5daf51a
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
+description: |
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
+  interrupts:
+    maxItems: 1
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
+  - clocks
+  - clock-names
+  - interrupts
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
+        clocks = <&dpc0_apb>, <&dpc0_vid0>, <&dpc0_vid1>;
+        clock-names = "apb", "vid0", "vid1";
+        interrupts = <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>;
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
index 93abbb315065..468aa1ef6eb7 100644
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
+F:	include/drm/bridge/trilinear_dp.h
+
 CLANG CONTEXT ANALYSIS
 M:	Marco Elver <elver@google.com>
 R:	Bart Van Assche <bvanassche@acm.org>
-- 
2.25.1

