Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDCCC61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:22:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13BAF10E4E3;
	Fri, 28 Aug 2026 12:22:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="i+68iXRj";
	dkim-atps=neutral
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazon11011059.outbound.protection.outlook.com [40.107.74.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A418010E4E3
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 12:21:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTERU4Cxjb4I2IMEIctnrVIgAeqPCauLCDiPrqEb+DseDnPrbpE52z9C88+wwizd31hl+7mNttDfl9DC3WpQ3rSZYBWHDoDtj82MFiUh4vqpnTRPdgOiyqPCKODKzHkNHyJk+kzpM32lF5/gDlhyS3a9Z2rMaNQGHn3sU/4zg7SfK1r/6OmGikQY3RRgtf/7TtK/TBfEXQeRu+w13zg5V9q3fnbW54x3bL3356oTGacoXOa3EAsI9CfxnpBF0If9c63qAux2vrsbLLkV1blIjirVmDFWqb35fXuiI0Lfk34c9coGX4leo3ZSJbF6/xh/AkHvuQlfqZYWnSDc2EQmUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gi4RNILlnRMDEfo+Swmc+dDSHL0kNiDUXvlMIkyauTw=;
 b=EBUmstrwb2ReXlv0cpwcaHCrksI+XIVPqCFTldOgeo4RE5rrL3vof3dfTBPvP5ykxpZCVg9Q3qAzAwKsQZM5Z6plJf1iOPVeBtYh4ylOBK8mypL8ZcO/w3M4g70we7T7WEhq36Rr4vGOUADla+42BU5vTA31gbNPC+CL75LbSBQQqWu70C2/qe+5LmAEUgvSfLVPHUZqOZzKJ4VNgBh5doZVA3c+8QkoEFJawYHArqhp2iaDatTy2JevRM899jwYVsDQj5eZDMWnI2Ke99GoAuTB/YbN7HD3lPqweivL13MRHQgIpF6oiUkF1LkmdC9nDnCHXVo+SUy/JZOJgL5qeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gi4RNILlnRMDEfo+Swmc+dDSHL0kNiDUXvlMIkyauTw=;
 b=i+68iXRjtifmtHf9Wk/2da8YHx7RcvtBrPxYLpS2GPQQjZ3QFu5NRnAJTspUCsbNNEyTMyuJKZ5GpDwaUHXvnJD9GnarUBm0bHyOtDaed92HVJlKKXZlBVDOS61oNHObKmhjqGHClXvZthhdvT8oHuWb7lyuujPAMAwK2HgpcAU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TY6PR01MB17444.jpnprd01.prod.outlook.com (2603:1096:405:360::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 12:21:58 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 12:21:58 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: tomm.merciai@gmail.com
Cc: linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v8 1/9] dt-bindings: display: renesas,
 rzg2l-du: Document RZ/G3E SoC
Date: Fri, 28 Aug 2026 14:21:04 +0200
Message-ID: <20260828122113.1426778-2-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260828122113.1426778-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260828122113.1426778-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0311.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::16) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|TY6PR01MB17444:EE_
X-MS-Office365-Filtering-Correlation-Id: 571f9688-7a69-4c43-7a0f-08df04fef4b6
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|52116014|376014|1800799024|366016|22082099003|18002099003|5023799004|56012099006|11063799006|3023799007|6133799003|10067099003|38350700014;
X-Microsoft-Antispam-Message-Info: 9+o8VAMYtWq6EqU/L/fA/t/TiJd3WFNM3cjeLeiPXX5e8WbFbzcZzMPx72bF8ic+4tGT2Z4bXEaJmb/oum7Owci00nGXjyks9uAgXY23dbNx1w1tuhaH/zGctuvR+2StfhZpo/gVB0Q5DMqgYK6rg+NyyLYlH3jVvOisDYfwscOXxhvRi8wird3+HGUrryOLKn6AqB4DialD5zW4q3XeLckd9QkzQLvTAI3KBfODPGJHjHRjW3OLckt9qCXcRnRp+PLgIXkMhLQRkxoiW+59lZ4JLO1LJpoCyF/8orGmAqqJsyV70eaEaoWf/2hXNPfLa7fpucjKbAN16NeqrvNvuhFZsqI9kfaTFL++5qLkKTgTUzoCwez14JRNBqPTQcD1Mw1FrYnNn7U5OuvJamVjj7tXdDmTqtkRQG8o9oFByGKvW+qVwZ6Cn4QscH4nA7SHKIZyljYPiCUStLwytGybDziiCg1nc2do1ZyfuACWAvvNlHTadzYMBZ6TCbtIQjpIZO/dTq+YGWl0F1uQSfKMEWdRT7tNoGrWAXqxTZ39nhlOvMWKkfiTH+xsuCLjrcjdtYlOFn4iTpKouYmRkDy4xpdEAHq/5E1/qjkuggHit6kw0jSJCI5n4XxFa3s4OF1Sfu4m5nWQ4LNlKHRhQj5hCrBXhbjINU/AKHYRvXd/heM6NVd8cvNBXQqWF2KwhsSfgHsPJlwqRY0IVgX12xk+Jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYRPR01MB13588.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(52116014)(376014)(1800799024)(366016)(22082099003)(18002099003)(5023799004)(56012099006)(11063799006)(3023799007)(6133799003)(10067099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0Io1cS7ulq2l3PjEcSXZrdgThW5Bfg01PvlWVrcsv6w94EG8iUNdhzPraWSq?=
 =?us-ascii?Q?jRR3liGhcXZy+DkfrjF9i0bhpvyn4XV1Nc4dMevoPr/yievOH0T1be774lgG?=
 =?us-ascii?Q?Z85pCoMboNlWblL4wLNeJW8qrOZg4wQJjWK58pGtHtgQmj09xVnn96URCZaG?=
 =?us-ascii?Q?OeSr/IWHx5KoNEQtdJtPdAQShQ5v5RUVNK/MXLPZc14CeW/p3ZesmVEtNUmr?=
 =?us-ascii?Q?MJgGSAx21Wx8DyKiODAdA/Zslg96SJLY+5tg+HRmdYYdvcHLKp+gvFaVscd3?=
 =?us-ascii?Q?J8QSpSRbACqt7E4UnZ2HM9TeWjeMhVoaN75NuSO3a+c03gIcreRCuinzGhI1?=
 =?us-ascii?Q?oxw0YP5Ol1Wdk5mOrOhUw63h62h1a3mnF+LfFuMEFDZ9IFDxfe7gKDR92W1J?=
 =?us-ascii?Q?HpMloYSZs2jc+NFIhtFYbFA4VenRFuyC1q/TCpe1rXzQhPPQ2aX6dgTt9Acw?=
 =?us-ascii?Q?lSDWYeuZuB9LFQYK18qlXnyrQF8L/hVHHeVM74zLaQnQPyajOjiHXUJR3Qp8?=
 =?us-ascii?Q?FwxnB3pqoTzy19HiDSrSWPIFAlL6o1zHVF6Rw8lWDkwVLXCR6hAjqIP8Xh/6?=
 =?us-ascii?Q?hUqGbPY0RMiojcndHYVz3kg7UL5GRPLRthJLFTy7aXZTUqtkKhW+RCWzOx2p?=
 =?us-ascii?Q?bC9oFCgTazzXgtlVIz0XQqsTiyl/wZoVpJaa8vn3eaBbf1k/auNpb6ET876F?=
 =?us-ascii?Q?5in9Lt+daF/qfLnCrl3zyuAg/ZsVTzHnNwcJZDJkW+hdVccpeATS6I5uGs9u?=
 =?us-ascii?Q?tUj8WVBMZjerbXchEs5tM20xDw/dBI+VSodJLuGoLwxNGWJ80xsJlu1zS6N9?=
 =?us-ascii?Q?nUofAA6LthvsLtI9O82L85srghwcUPqiQl+zVnxv9ub1hemH4wM5AZz7RCM3?=
 =?us-ascii?Q?22mM1IXb/3Qq+6gCXrZR/OejVRWuQUVPpzyo/ElaI5N/z797Es59/oQ/xPAq?=
 =?us-ascii?Q?B5RkB4lEzzRADPacP6BEEIWFcpyXQh6u9jZZfftbwLeqJuMXQfQPGmVw7BdS?=
 =?us-ascii?Q?oObC0gpd0Dr7/zGaCTAVmdkdmgUGWgo6+Q7VsxccPT4OQC3DaI80ecbuhE17?=
 =?us-ascii?Q?co3T4yPb3ULroVO+urOjg2kM1MoVibMkQpEvnoi22+wdm4/mABA/NaUU+YsU?=
 =?us-ascii?Q?akB19uZaoAotFRaXg9+9yyKBbcmFxV2pgDnFiV/MsW05H1GLGevIQyGgmcdx?=
 =?us-ascii?Q?+f60Qnp+wbQ6IijvnEWbCqXXe9CwmpvsCS5GdXcJ/vn9vddhzPDydBiz67QA?=
 =?us-ascii?Q?LYuTicshacjMS7iLp43yZSovoJvD/Rn+wNaCZF4Fvd3Edg3ir5rTxVhU7Sqz?=
 =?us-ascii?Q?bEcNotZ3sjUaod44mb9To1qsqD4SFNcHmE70sKnpFs/agQaFT7oduKvqBvq9?=
 =?us-ascii?Q?FzCFYZDLdA2nEf2rZOc0FPIGtSQ2sbQ5XW97WKlyKL2lDJJx40gqeQkHM4oc?=
 =?us-ascii?Q?PPS+799+k10EC+by8jCXI8dmi7s5Xf/NJJ/ndymjXNTB5HpH2JMbbAWauAwn?=
 =?us-ascii?Q?mc43FxgJZIBib2FAxuJ4z2pF/qiKkbWP6g64+JFbiweDi91It1ds9Y5thB69?=
 =?us-ascii?Q?1mNUfuuZmE3LrSL6xOjTenUYIMQlo2Deu1rOkzCx81d0lcRWOB5zAIIpAoPX?=
 =?us-ascii?Q?TAI/RApu61MaFrg8E7TT1jOUAcbqSFyqHibVzlILtU9NWGavQcgwhwFcsjbp?=
 =?us-ascii?Q?Nu3X5u5ObGNG3UbRbarSYgoJQxQ684tqH+aAAqKRAJFcuGslJSYHcMiJmlkD?=
 =?us-ascii?Q?wWxsP2/kJgpmycxvpNhNYnYGJrq34Tpo1H5WVfOGBiiX5oDc8qko?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 571f9688-7a69-4c43-7a0f-08df04fef4b6
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 12:21:58.7008 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MRn3u9z/9BH3xIPqOslNxb9kcwOxv2iEUWJpSoipJSqgxTxiA5rGSfaTVF8EIemujHY9BpKEadICnNNYqhNuulIpDwaiAfJaWC8ejHhECE8j9jVcc+A/ARS0qcZcU9Lf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6PR01MB17444
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

The RZ/G3E Soc has 2 LCD controller (LCDC), contain a Frame Compression
Processor (FCPVD), a Video Signal Processor (VSPD), Video Signal
Processor (VSPD), and Display Unit (DU).

 - LCDC0 supports DSI and LVDS (single or dual-channel) outputs.
 - LCDC1 supports DSI, LVDS (single-channel), and RGB outputs.

Add new SoC-specific compatible string 'renesas,r9a09g047-du'.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
v7->v8:
 - Rebased on top of RZ/G3L du support [1]
 - Modelled using ports/port instead of port/ep.
   [1] https://lore.kernel.org/all/20260826174854.199139-1-biju.das.jz@bp.renesas.com/
 - Improved commit msg and commit body.

v6->v7:
 - Rebased on top of [1]
   [1] https://lore.kernel.org/all/20260429170012.366537-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
 - Use single DRM device aggregating both DU instances (1 DU dt node),
   modelling single port for each DU0, DU1 and multiple endpoints for
   outputs.

v5->v6:
 - Extend patternProperties from "^port@[0-1]$" to "^port@[0-3]$" and
   explicitly disable port@2 and port@3 for existing SoCs that do not expose
   them.
 - Reworked ports numbering + improved/fixed ports descriptions in the
   bindings documentation.
 - Improved commit body.

v4->v5:
 - Dropped renesas,id property and updated bindings
   accordingly.

v2->v3:
 - No changes.

v2->v3:
 - No changes.

v1->v2:
 - Use single compatible string instead of multiple compatible strings
   for the two DU instances, leveraging a 'renesas,id' property to
   differentiate between DU0 and DU1.
 - Updated commit message accordingly.

 .../bindings/display/renesas,rzg2l-du.yaml    | 95 ++++++++++++++++++-
 1 file changed, 91 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
index 5c9b15a09dee..d44c7c0add8d 100644
--- a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
+++ b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
@@ -21,6 +21,7 @@ properties:
           - renesas,r9a07g043u-du # RZ/G2UL
           - renesas,r9a07g044-du # RZ/G2{L,LC}
           - renesas,r9a08g046-du # RZ/G3L
+          - renesas,r9a09g047-du # RZ/G3E
           - renesas,r9a09g057-du # RZ/V2H(P)
           - renesas,r9a09g077-du # RZ/T2H
       - items:
@@ -35,25 +36,51 @@ properties:
           - const: renesas,r9a09g077-du # RZ/T2H fallback
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: du.0
+      - const: du.1
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    items:
+      - const: du.0
+      - const: du.1
 
   clocks:
+    minItems: 3
     items:
       - description: Main clock
       - description: Register access clock
       - description: Video clock
+      - description: Main clock for DU1
+      - description: Register access clock for DU1
+      - description: Video clock for DU1
 
   clock-names:
+    minItems: 3
     items:
       - const: aclk
       - const: pclk
       - const: vclk
+      - const: aclk1
+      - const: pclk1
+      - const: vclk1
 
   resets:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: resetn
+      - const: resetn1
 
   power-domains:
     maxItems: 1
@@ -66,7 +93,7 @@ properties:
       model-dependent. Each port shall have a single endpoint.
 
     patternProperties:
-      "^port@[0-2]$":
+      "^port@[0-3]$":
         $ref: /schemas/graph.yaml#/properties/port
         unevaluatedProperties: false
 
@@ -110,6 +137,7 @@ allOf:
               description: DPI
             port@1: false
             port@2: false
+            port@3: false
 
           required:
             - port@0
@@ -127,6 +155,7 @@ allOf:
             port@1:
               description: DPI
             port@2: false
+            port@3: false
 
           required:
             - port@0
@@ -146,11 +175,68 @@ allOf:
               description: DPI
             port@2:
               description: LVDS
+            port@3: false
 
           required:
             - port@0
             - port@1
             - port@2
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g047-du
+    then:
+      properties:
+        reg:
+          minItems: 2
+        interrupts:
+          minItems: 2
+        clocks:
+          minItems: 6
+        clock-names:
+          minItems: 6
+        resets:
+          minItems: 2
+        renesas,vsps:
+          minItems: 2
+          maxItems: 2
+        ports:
+          properties:
+            port@0:
+              description: DSI
+            port@1:
+              description: DPI
+            port@2:
+              description: LVDS channel 0
+            port@3:
+              description: LVDS channel 1
+
+          required:
+            - port@0
+            - port@1
+            - port@2
+            - port@3
+
+      required:
+        - reg-names
+        - interrupt-names
+        - reset-names
+    else:
+      properties:
+        reg:
+          maxItems: 1
+        reg-names: false
+        interrupts:
+          maxItems: 1
+        interrupt-names: false
+        clocks:
+          maxItems: 3
+        clock-names:
+          maxItems: 3
+        resets:
+          maxItems: 1
+        reset-names: false
   - if:
       properties:
         compatible:
@@ -164,6 +250,7 @@ allOf:
               description: DSI
             port@1: false
             port@2: false
+            port@3: false
 
           required:
             - port@0
-- 
2.54.0

