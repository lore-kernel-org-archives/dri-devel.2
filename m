Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69389606A33F
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:33:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1D2710EE46;
	Tue, 10 Nov 2026 08:33:35 +0000 (UTC)
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazon11022086.outbound.protection.outlook.com [52.101.126.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AC7310E898
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 12:09:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pOA0ba/p4Vi9fqbAoIjgwgsR7jraPHhDq1snkSPAkuEVGNpNxqONJcuTqZdj0v8VJtipmXAVCm0u3VWBwj+wsp+0arOdfdbJVYM1WoIPalsRw4JKVE9PNdCjeirLgiipqBf5m3GAdQ7det8fPCJuQoa0XvsvZpJ6ER3O24lDJ0Lui7UcaMLP185DwJQLt51EqFD6vK6rDFXfsSZGVqQVbS/Jz2sNkeeR41Nwi5+aVKHLqYE1xvu8A+3K8oCBajM0gY9KQYxI0Zjqgi9qR2WZgZALJGotk1O5dSizsPG+g0K8iMJYokQCbeLzMfACpDAqSugcw4jaEzZuyiP6KRURpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4+pWU1nb58F5dsMvOA4RjP527RUqPlN/xdLexEiAcs=;
 b=aDwrPEqmRfoyYk2PFM3AvnoSsxZZfZF43jJKCFe7cMmIUmyMieQI/kH64nPkHikBgZ2FpUZxbFpPyLi1216E2E8El2aFTiT04o4Rvy3ncIK8xu8pzc2se0Dy3Cn0KJtJId91HYJ8UNouBsyPlntt010bzE6F3uBK/mMNMx3k2W/LUB0RSsMpicXo41Mg0zcv1xQDCA9DeDuTWj/Jw4I77DiR2PR6bQz74M8zU0VKfaRwNMKymPsAeYfEJp7hNMTSVuBOBKXBakIKOLIt6+9BkqqADDKNmhiPJY7cK5pj77rs/NQ9aALUhtQrDOKX9DSbPllfQSHHANgB6HSOI618RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR04CA0216.apcprd04.prod.outlook.com (2603:1096:4:187::18)
 by JH0PR06MB7179.apcprd06.prod.outlook.com (2603:1096:990:9f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Mon, 9 Nov 2026
 12:09:04 +0000
Received: from OSA0EPF000000C6.apcprd02.prod.outlook.com
 (2603:1096:4:187:cafe::34) by SG2PR04CA0216.outlook.office365.com
 (2603:1096:4:187::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 12:09:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C6.mail.protection.outlook.com (10.167.240.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 12:09:03 +0000
Received: from cix (unknown [172.16.64.42])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 3D1474102E75;
 Mon,  9 Nov 2026 20:09:02 +0800 (CST)
From: Cunyuan Liu <cunyuan.liu@cixtech.com>
To: boris.brezillon@collabora.com, steven.price@arm.com, liviu.dudau@arm.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 gary.yang@cixtech.com, fugang.duan@cixtech.com
Cc: daniel.almeida@collabora.com, aliceryhl@google.com, p.zabel@pengutronix.de,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 robin.wang@cixtech.com, cunyuan.liu@cixtech.com,
 Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/3] dt-bindings: gpu: Add CIX Sky1 Mali support
Date: Mon,  9 Nov 2026 20:08:59 +0800
Message-ID: <20261109120902.125242-2-cunyuan.liu@cixtech.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109120902.125242-1-cunyuan.liu@cixtech.com>
References: <20261109120902.125242-1-cunyuan.liu@cixtech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C6:EE_|JH0PR06MB7179:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f6674c06-1f7a-4a55-43af-08df3e5a3f71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|23010399003|82310400026|36860700016|261021121427099003|261028144727099003|56012099006|261026140227099003|261009223027099003|261022105027099003|261102123227099003|261026121527099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: stcez+NTsNBt12hQurTBf7Tf2H2T3cFNarzs50MzE3xeRLWrob1mAoyvy2uQrDWuiiuQ8xic/uEdypTitmWbVu8hcX//uFB7jVkJGVyWxa6vPMI58/nby1GOlKRZq1Wq9HcLTdgNg1fnEa7/3bRiSI7IRyRA0jwLtuzfsN+H6QXh0eOkm0vFCiQdZfwVywPK1OX4MGZWAyfpBaeLinCCSsLwgB/ALlUvWM6E//40+PgFI8J2ZDjsYLg2s/KI+Z/wdPnr/wFQSTdW6/wMtvxP8iK7VMULY+JcYRswGhgMkHNiNiydiYBipuxce2s8kuyzZIGOYTpAxzrBVQVI3jHFSzJWAZ3DfEMxPUgUk4MXMOtr6tqRQMe7WJ8dZQqpzukZfSELnUYh+HULrxLU4Xk41dZeLAVNl4G+Am7XTJB20/fNFrl73UeSuXZPaoXMt3GUy+gshPoxEASAnW3yTA/ROxt/lma4URCZxQjP+MVZcHdP7nt0KgNaosggE9CqPeI8wmlL8lm33tm0SKQcV2zHMVxB5sQjhjgD6G239qZ0Fsz7kvwp8mOBG8eJL1+8F1wnaa2AuennIzgmy/E+S1de4JRuhseNxx64egIfUZrpIHR/qjVyl1UenINBfIZoV6nZ78vBD/StqtKuB8FwqjxEsqvD3IQGtoOUmrBovE899YYC7HCj56KWS0RJH7mpDqFFyGr3JbzONn4kBCUT/yNOeg==
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(261021121427099003)(261028144727099003)(56012099006)(261026140227099003)(261009223027099003)(261022105027099003)(261102123227099003)(261026121527099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vCmT5b9vuSy4qybGEHMG1Ao1U8cxhAze5QfuQOj52iNAQ71xCvNqJXUKSFlSRn6ejfgfeQAkWf6AeDaObrXTkoeeIn/Qji+N0evvgxFSh/1RFtVhyeuD1UzVItvzpqAhlGn8LJIf7fwJfB8ryy2uisraq54g3H40Hyp4Q030yQ7rg49pi3PCpBjIzWI9XU8hj+yTW4Kq6mARrGJ2QCP4QlnHwK20/uFIvS4Q9qQQdAjS26Dfwf3G+P8Q+9vmcvHUAxJq01EIxm63Irf5ThI6Vn6oRH3Ndzlbl+d1zrUO5O4JdTeNtzo+7N/1Q6QbLtOX62FGSSgI/eNIG/950CWaQwLVtsa1Nir+Tf9VtUqOzRlZTMRhUxo+jYznKVdb5/Oihufhx25vCCvzHz0vJoNpwhy/SxagG7UpdnF+PPvo6qHvkbXfUgm/GRAukf9AUdVt
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:09:03.9651 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6674c06-1f7a-4a55-43af-08df3e5a3f71
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: OSA0EPF000000C6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7179
X-Mailman-Approved-At: Tue, 10 Nov 2026 08:33:28 +0000
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

Describe the Mali CSF GPU on CIX Sky1. It uses core and stacks clocks,
an external reset and a GPU power domain.

Add the compatible string, resource requirements and an example.

Signed-off-by: Cunyuan Liu <cunyuan.liu@cixtech.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/gpu/arm,mali-valhall-csf.yaml    | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
index 8eccd4338a2b..a93acc6d91ec 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
@@ -18,6 +18,7 @@ properties:
     oneOf:
       - items:
           - enum:
+              - cix,sky1-mali
               - mediatek,mt8196-mali
               - nxp,imx95-mali            # G310
               - rockchip,rk3588-mali
@@ -51,6 +52,9 @@ properties:
           - stacks
       - const: stacks
 
+  resets:
+    maxItems: 1
+
   nvmem-cells:
     items:
       - description: bitmask of functional shader cores
@@ -146,6 +150,34 @@ allOf:
         - nvmem-cells
         - nvmem-cell-names
         - power-domains
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: cix,sky1-mali
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+            - const: core
+            - const: stacks
+        power-domains:
+          maxItems: 1
+        power-domain-names: false
+        mali-supply: false
+        sram-supply: false
+        nvmem-cells: false
+        nvmem-cell-names: false
+      required:
+        - clock-names
+        - resets
+        - power-domains
+    else:
+      properties:
+        resets: false
 
 examples:
   - |
@@ -196,4 +228,23 @@ examples:
         power-domains = <&gpufreq>;
     };
 
+  - |
+    #include <dt-bindings/clock/cix,sky1.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/reset/cix,sky1-s5-system-control.h>
+
+    gpu@15010000 {
+        compatible = "cix,sky1-mali", "arm,mali-valhall-csf";
+        reg = <0x15010000 0x480000>;
+        interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "job", "mmu", "gpu";
+        clocks = <&scmi_clk CLK_TREE_GPU_CLK_CORE>,
+                 <&scmi_clk CLK_TREE_GPU_CLK_STACKS>;
+        clock-names = "core", "stacks";
+        resets = <&s5_syscon SKY1_GPU_RESET_N>;
+        power-domains = <&smc_devpd 21>;
+    };
+
 ...
-- 
2.53.0

