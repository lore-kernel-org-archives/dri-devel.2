Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0D3606B9BF
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 23:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4ItbNvjn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37D4510E46D;
	Wed, 18 Nov 2026 23:32:47 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010008.outbound.protection.outlook.com [52.101.201.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50D7810E46D
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 23:32:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lgaTxgAgC47PvFh9ipQOmHdz69slJKmMzh3w/BImDtkI5fqp4YPdElL/E5lorWPVXgrlqS6lAGr6BKUoexbOzKCtdKMOaAYujudgsF4Fw4B5YwatFxpUTewt0LovIgeEbzQuvA40PCY5nMux7lPCW1xLhDV6aj+5qaK1MI5u5FitrfQmELUmRQ9X4vyqivCap7tQtH5m77ufNXrAFuG19f3GLjnTxGmeMV0BoUT1giKi/BLbo0Z1g5CKC6Jea9HnuSEA15ZY0SVTpRCIuf91Jdu31dCQ5zzKWWj1ADFEk27T57n7W+CHz6qvc1QhK4v56DBNxiqdI9Q+FZeyzAy3lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMeR6NDUiz18N+Bo2DvJOVGkvlTFuB6dauhlohGe6GI=;
 b=wPLUyLHC9MtVApaEdhpf3l73XalGH2TE7GDodU3d8p17E1qbhb1H2J34GJhPjV7SwyPEGB6YriNauyB8J0WVvcGZ29WWyWMT8dzOsB9k7X8fVbWFYTMkCBTpQGiiKtrkr6wLYFz4jtMumE6TIrvYA16ObIJqNgbOoXFf3Z5DBEpQByR+eUJzmFma121FTRGZc7ZL/aej+1vHUb2wfIloCF7sLY8MiM8x0t5uowsuLNEJ97o4YcSiATXtPwusjOo4deeUbx/YolxMKC6N01cMttk5vIW44DhwHU5/l2wveyA1nULKOC0Ly7iUW9AHwS7urSZHtmG/zsFUvlPURfoS9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMeR6NDUiz18N+Bo2DvJOVGkvlTFuB6dauhlohGe6GI=;
 b=4ItbNvjnwiPdu9WUJqKsOlHwrPWpDlI1Bhil4KF3C3FHlJ5UbI+DY5y1Yi0ljZkVAVT7FH2WxUtl89M0wM4iDsNap/HvKjQv2Y8oGTrX9GYXlv5wt4CMSCzyo9yCPsKn1Nsp1gxaJYxVu8fBmrksdluLYlqOcQyXDpQ7+AwWWIA=
Received: from BL1PR13CA0083.namprd13.prod.outlook.com (2603:10b6:208:2b8::28)
 by DS7PR12MB8323.namprd12.prod.outlook.com (2603:10b6:8:da::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.14; Wed, 18 Nov 2026 23:32:32 +0000
Received: from IA0PEPF0000003C.namprd03.prod.outlook.com
 (2603:10b6:208:2b8:cafe::3f) by BL1PR13CA0083.outlook.office365.com
 (2603:10b6:208:2b8::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.8 via Frontend Transport; Wed, 18
 Nov 2026 23:32:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 IA0PEPF0000003C.mail.protection.outlook.com (10.167.249.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 23:32:32 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 17:32:29 -0600
Received: from xsjgregoryw50.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via
 Frontend Transport; Wed, 18 Nov 2026 17:32:28 -0600
From: Gregory Williams <gregory.williams@amd.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 11/15] dt-bindings: soc: xilinx: Add Versal AI Engine DT
 binding
Date: Wed, 18 Nov 2026 15:32:07 -0800
Message-ID: <20261118233211.4121361-12-gregory.williams@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118233211.4121361-1-gregory.williams@amd.com>
References: <20261118233211.4121361-1-gregory.williams@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003C:EE_|DS7PR12MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: 71174006-f00d-49ba-a19c-08df45cc37bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|261022075727099003|261102123227099003|261026121527099003|261028144727099003|56012099006|11063799006|261026140227099003|10067099003|261022105027099003|261021121427099003|261009223027099003|22082099003|18002099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: QZDtI8lXDvxX9zdXX6xeiYKN2pcukiz+dNHomft0GadG2MWZ0IfGAkXEa5daXash7/lJlbYq+igFlCdN9So3cdnLWQ2KqRFNNCtrS0DolGRGvHcDdctlRp3vVakfxG+TIi+PIDk0/oaS561Pb4N8nOhfFeTxG/PScgbpku+Sd84XnFX9m1YlQ8I5Yfpob9cRKJ+CGOKY+svl68V7fHtv98e3eL+Rx2v0S/1yCbi4z+c6K+sUiImNV+HTJ81OoLxFVaA8ZRCkoev93U8xU5b0oW6PcIWqmwlIB5jUR3HpYXZaLTKZ3uPUFz+RagXl2m/VgnOuY+CYe+Ms/k6tL3SJgWYlfxyjadwTDfZ+0V2gfqrFHQTa/a8nqOUxSJivRvdz1yGJYpx4p8ZtgOWAerWo2a+49QzM39QzmMRfpCFK1A77at2Fa3h9KYz5OBWbVNJpZ5ao2KNtmDSuiGnjve4hBt0jGqoa6TG/HCwn1QO6KghNS9lpAR4Ao/vEz4ofPNDsmyEGTv3YmaGtS/eq+3Cq50H7ZviOmc6ltXkgqM+VmdztLJZKWtBIr4ygZ3FH6qfUYwgXytvdkAk/dOKmHDWoYEV96OmIOe0aGpYgtxOXc8d2S8BZFJF3Hxr/ie2lkU4MzE0pGYb8xbRFD/SzNSbceg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(261022075727099003)(261102123227099003)(261026121527099003)(261028144727099003)(56012099006)(11063799006)(261026140227099003)(10067099003)(261022105027099003)(261021121427099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(13003099007)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LuYvtbEVt9fhXXt52ql6EPe0wsoVnGuf3S9OFDNl4DAkmkFC7SMsXY4k40E6I4hx7OtLmGPw8VK2pTqAZZgELIYFYwofYmkLqgX/YnRBTPGNGnm7uSrcHWBLhPxu54tqHSf8RCpV61xMOyrLRAjD3YjEH/QEkWkOqOmguVJ+gyuqmrPkJq0ZuH621qneluXFJ0F52foSBkv8RCjyVYrH4/h4+m0zVLqiq4HpEZUeYRaPfVIAebukwQSeFWdL6/i3/QqAM4ZPD9WJg+V7BEMezb0f31yhtdd3xmX5DmbW5aFoJrnubd0lmqC0DNquOzs8yPKTnbQb6yea8EnagGwFaQPWRjWM+GHftAjzRD+SsZGH+AlTnYGJL3TbdLFAXI+yIvc+E3vqMbWtVm7arJdNKlOnX8HnT/9y87QsF6z8+fdlI3vbr+WAzWkBEpWUi9xQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 23:32:32.0497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71174006-f00d-49ba-a19c-08df45cc37bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF0000003C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8323
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add documentation to describe Versal AI Engine device tree bindings. AI
Engine is a tile array based processor with many cores and local memory
cache. Data routing between the cores is done through internal switches,
interface tiles are used to connect to external sources such as memory
or PL. Configuration registers of the device are accessed through a
memory mapped AXI address space.

Signed-off-by: Gregory Williams <gregory.williams@amd.com>
---
 .../bindings/soc/xilinx/xlnx,ai-engine.yaml   | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/xilinx/xlnx,ai-engine.yaml

diff --git a/Documentation/devicetree/bindings/soc/xilinx/xlnx,ai-engine.yaml b/Documentation/devicetree/bindings/soc/xilinx/xlnx,ai-engine.yaml
new file mode 100644
index 000000000000..6c97b5f0fb03
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/xilinx/xlnx,ai-engine.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright(C) 2026 Advanced Micro Devices, Inc. All rights reserved.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/xilinx/xlnx,ai-engine.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMD AI Engine for Versal SoCs
+
+maintainers:
+  - Gregory Williams <gregory.williams@amd.com>
+
+description:
+  The AMD AI Engine is a tile processor with many cores (up to 400) that
+  can run in parallel with some devices containing local cache (memory tiles).
+  The data routing between cores is configured through internal switches, and
+  shim tiles interface with external interconnect, such as memory or PL.
+
+properties:
+  compatible:
+    enum:
+      - xlnx,versal2-aieml
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: aclk0
+
+  xlnx,firmware-device-id:
+    description:
+      Device identifier as defined by Versal firmware interface. This value is
+      passed unchanged to firmware calls.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - xlnx,firmware-device-id
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      ai_engine: ai-engine@20000000000 {
+        compatible = "xlnx,versal2-aieml";
+        reg = <0x200 0x00 0x01 0x00>;
+        clocks = <&aclk0>;
+        clock-names = "aclk0";
+        xlnx,firmware-device-id = <0x18224072>;
+      };
+    };
-- 
2.34.1

