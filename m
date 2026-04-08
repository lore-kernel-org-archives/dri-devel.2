Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A1C1073C8B
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 10:39:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD18710E5FB;
	Wed,  8 Apr 2026 10:39:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="wtfwO3sl";
	dkim-atps=neutral
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazon11011058.outbound.protection.outlook.com [52.101.125.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D536610E5FB
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 10:39:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DSw3iaZ0KwzkiCjJmmsfA3eVU2aKzjXKP3rp5ut6khyuHVoOxiG5+HYJo5uhtUTAKHJd8TV+H2tAUzr85eC5oyr9auKWB3HM6Cgog6fmZ320yk6LCzCWYw01H/g8UrrTJ60sgPUEP9X8Z9lRcWwOcpNwOlnJXdgK9ds2jya7ayr5YX8nFFKDN+4Vhy7iuZDIutMb0fmd4YOj92CQsapL342naETmJEg59KYw6wAqmKOOdSWxb1wayi7xXbo3wr9uzBQ0Iq2/vUadICvDW6dWV0SsOF8oC4bc5Lr6H9LUxOmSsfkIewlTRpD2cV7b5G4CfvM/NjPymKzYKJBda8LaBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=po27t1b9T5hydykhtUgSJKryjM+e2e4wivlvHhZnbtw=;
 b=sHyZYTGYWpjpOBxX1SGOqoBOu4DaWSx9XZuzIR/S/MCO6Gl5/UsgoLC+wdet+zk2ASk9DTIofEUnCDSXlb50yGDWGyK10kpnzqMFoxtRHGYv8RiNKgB6tprpRioPOZUxXF52Whx5Kd7THMWspHWNME0t+xRYvLTkWHCaZ4p6rg10QdvAJq1d5kQSHO/gZso71zmpgEnax8tnt3vtZrfY0oIVdkqzgPPMNXJYdt1StreWYeAazps+zFLQDOcTQPu8ZkY+4eYA064Ow1/ZcBzeDZ3Km4TWSllXfCDjcHKTR3ezeCD3R0/pD3np17BVPhtP/zU8+cuQ9W5xiIMaTvE1CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=po27t1b9T5hydykhtUgSJKryjM+e2e4wivlvHhZnbtw=;
 b=wtfwO3slTdL4Vuz9b7cbY1J+0hVruGq3X9jOtfyNVYmomCAdLfOadlEgB+zHHSmFcKUNBEGSwB7q77BdOYESWyDhwQsUIfZmRjiixYbS5ZNboF8lm0j72boGFpR+1RRWzPIgV1Y6yZV8hxR1w2X6cZUVZPaQt4qYvqaOWd+AGo8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OS7PR01MB13668.jpnprd01.prod.outlook.com (2603:1096:604:35d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Wed, 8 Apr
 2026 10:39:17 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9769.017; Wed, 8 Apr 2026
 10:39:17 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: tomm.merciai@gmail.com, geert@linux-m68k.org,
 laurent.pinchart@ideasonboard.com
Cc: linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v6 11/21] dt-bindings: display: bridge: renesas,
 dsi: Add support for RZ/G3E SoC
Date: Wed,  8 Apr 2026 12:36:56 +0200
Message-ID: <0beed64c1cbdb6383bc5da5da3e4b2956ffce5e8.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
References: <cover.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::8) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OS7PR01MB13668:EE_
X-MS-Office365-Filtering-Correlation-Id: 47e0b722-810a-496a-4ecc-08de955b15db
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|52116014|376014|18002099003|38350700014|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: fkrv7eue+hQeOF9hJjqp0tH255W4mc+gunUMqeJQ0dIlS3JjzYHZFBUhzlfugEt462CkZBE1AY5dKO2wN01wsaEK7y/9bwb/l5l5q60iCUoamPfl+QVFYsLYkrvqQWQsPSBwmLWQ0OTHvJEsk4oEPLZ6cBFzuLgQtHbrArdaUr4PM0mhAauL/oSchk304khhBOvnlPmEtZO5XU22G2MsIqvMnqWz2JykLw8QurtadqKkIygYCexl4B3vXqT/331h+2g5LrBJdBylEjjdTGgtB3HXGWJPhDd9jhH2EYJRlO60JeRBGIev+Dwb253NQ76v0bZRpqzqRZJYLNLthoAoovPqpgemaBp3EWlkXPIJhQ2EeFZwJGjxTGfQVz8l68DsKd8mPblrTD8i8G62DGnGJa8f/apQDKvvFOJE7aFXGXHriBC1IBLWbgUl89JvyKOdZc+qKlT6WsGKN2FUMB+sx7ZUY0y4fzU4yWQoyh9On1BbfQfWejFcRit389yyONoTT73RlQyvhgnLVGO9eVBeGAebVBHYuCl2LSMvNjyN+eNbzr7ZLAsi4n17ToY75I6HGbXQWbPjXDeKc3Y5XtrC5w/JjNatT8UVlAPBFcNoVoFfym/UQ2dqmmISPTbT7yCW/2xji7xJ10jq+FvUfcEAhbRXVnEApYI5Kng8Xh/zyAE68vaf/NbmCfXe5CF4D7w8Dz0SdyA3T/id8AAZy2UUsKS4JXKh127hKq7SanGm409tQD0+4+JUHSVp1+/YSCMqdZm6S3BfBImLXyQxtzfL5N1SnitgGQpGpZF+IxQxg+0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB11947.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(18002099003)(38350700014)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/M/bdCAgOTdOWOJe2szWuCYbjnaq7zoc62XUf+n3Q5Xe348/E5PPdaUBucHt?=
 =?us-ascii?Q?AodbQkexfWcnZ7NwJi5K2QqkO/n7IlPyQOLhsCATuH9Vv5Lscqn4PWLL52ts?=
 =?us-ascii?Q?jgCt/+7NKx2Rm3/dYY/gbK/QFmmr2+XhW0poZpxDs0VINN5Z161ftrtDeZZw?=
 =?us-ascii?Q?p2jUDlfkiZxBdz9nmXLNvW/MgaNjQMOLbVMnysq0LsKyRQqH5jkX3uHHN3yZ?=
 =?us-ascii?Q?FLR0QAxGq7QyHtqCs/eC3Zb53oIfYmsrYPuJWIK6v1TLjOZAVodp7S67gWl+?=
 =?us-ascii?Q?HKugr5VXLSLM2/YjQZcpauy+6ioF4XGJLH9VNgizgjzulbiX7CgCGE/zB0w1?=
 =?us-ascii?Q?OrLTv0Wc2iOKwrQzamojqvkhKD3mKS4WN/Yd42wc+Rtp9xfiuhI9Y8sAs/6k?=
 =?us-ascii?Q?OalaYTNGKKF64EZMtlSLyXg8CbUTJ9uHsDdJeDUJWdsnEBImN0pdC9ZnI4VO?=
 =?us-ascii?Q?rvyAhMkan735tJVHN6Hb32tDqhEQ+QwtYlDVuMieioS7gRP87WRn9eKLuNo7?=
 =?us-ascii?Q?oARN4EzDLgRuXWeY3XNCPgr3L80kBWETsqlyEOyxhK3jq7a2TEBub2d1GgiB?=
 =?us-ascii?Q?eUS+92zm4BbsWVWlNcgRm5NKeWj/hRxGzCsMvTluxLnNycbSaIUojAiaUa+X?=
 =?us-ascii?Q?vEki+wvwSE2Y6rOr2FE5MA1SLluezJe1Z6RhxougLqBECyIeT68IrEWhDNSG?=
 =?us-ascii?Q?n0gLdO58W35MdebEBVprTFgAhJAmu/Wfsnq1SimCM8p5+h57DkLe6f6RGr3O?=
 =?us-ascii?Q?gh1hHjC3wlT7MYPiEpBzcaCTxoR+8NwojCXwOhg4zyIWJOGGACi2zpIVwoWQ?=
 =?us-ascii?Q?GXLohdx6EXdULHAK5ssDZBk+8R6ALc47+Ji7ITqvJeZlObyoOiNw/HUGtrkq?=
 =?us-ascii?Q?EIrzXY2A09XIbnFMiGj/chkStp74o9Sj+mi6WMXedn3VaUI+HE1yR8SSY7PO?=
 =?us-ascii?Q?9gQgV8z15tqAD2w6nK9gBv+I0mJTOR+YcEhRxceRx/F/M/hr48e/c2YwKA/W?=
 =?us-ascii?Q?0Q/xiyB+s1XoIetWbqU9zBdze95JgD95oLfRJ1RdCyi/gNrdY1cS9xOjwy3n?=
 =?us-ascii?Q?Dq4qK7uLNX57If7nTYhAp6OP+iDDduw09ZP0WiOZB1j0/CVVEACX+uqyAhDg?=
 =?us-ascii?Q?m+dd7K0hqHWyvu9LtKiVlW5kPDhrF5CDx/bCj+rJEsy+gn42SNO2KdlPMt1e?=
 =?us-ascii?Q?WwKcrg7JKHWks+ZqJjVhC6Rfjz3qDiDVcGlG1aUnWisA8c/aIAY+D5CxVynS?=
 =?us-ascii?Q?qtP+/gEL2OEcit3erzsUYywMbjrIOY/1X564auAwYBoZg91X4WgU3Pxhflq0?=
 =?us-ascii?Q?ZEuSClyWEU7ovUVnzbPQXHZm+s8mjDulyezOM6SSv1DDgGDPiFwAKARIESqj?=
 =?us-ascii?Q?QpsRynbgQRC2wWuUMtu3VLL24FB2VRS/2KTTFoRjgCrV+OMtCiRI9+QcpIKn?=
 =?us-ascii?Q?hMMIKpTWQjr9bJKDWfdNIDBfOPIdRQ8pcFSX6+X+hsyjOj0JMXh742CMp4wg?=
 =?us-ascii?Q?TJi1f5cxKqWtNPVROVZcBMsTAqF4L5LPIha1N+8GO98vbFjxxkJdR1e6DXo3?=
 =?us-ascii?Q?6jQxHb4La94TLbF3DqswKSqo2GVvAyBAn5zBeio0nDcJXcBp799Dx7GMS1eR?=
 =?us-ascii?Q?Fvau5tJBhO8AdZHhAMMEUJ+OkpAbRYlhWdrzrXnLDkywsL+WjT68/ETN/Ko/?=
 =?us-ascii?Q?flMG2RHFmY6alfLlKmTcqAvhbMUr99UcGp5ttBa/b6Z8r5L1BNq56NDaXSzn?=
 =?us-ascii?Q?4xEuBZXeNXZP6m/zDzUY2MRZhwQxPSNGBYjcMk5BRUDvLSHLrUqs?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e0b722-810a-496a-4ecc-08de955b15db
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 10:39:17.5954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lm6o5e9FiPfSuK5cA7SyDdaU6mva2g08n5HAajPGYdhmXYYAEyhCYOBusSH78okVj3ircsZMSmzybYWUHiflAak8hc7oRF0AhD6LBdAYgYDK0kIa2cF02hoSMRDs7lT/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB13668
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

The MIPI DSI interface on the RZ/G3E SoC is nearly identical to that of
the RZ/V2H(P) SoC, except that this have 2 input port and can use vclk1
or vclk2 as DSI Video clock, depending on the selected port.

To accommodate these differences, a SoC-specific
`renesas,r9a09g047-mipi-dsi` compatible string has been added for the
RZ/G3E SoC.

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
v5->v6:
 - No changes.

v4->v5:
 - Collected tag.

v3->v4:
 - No changes.

v2->v3:
 - No changes.

v1->v2:
 - Removed oneOf from clocks property, which is no sufficient to
   differentiate between RZ/G3E, RZ/V2H(P) and RZ/G2L.
   In particular both RZ/G3E and RZ/G2L have 6 clocks with different
   meanings.
 - Use the already exist vclk instead of vclk1 for RZ/G3E DSI bindings.
 - Updated the allOf section accordingly.

 .../bindings/display/bridge/renesas,dsi.yaml  | 144 +++++++++++++-----
 1 file changed, 109 insertions(+), 35 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/renesas,dsi.yaml b/Documentation/devicetree/bindings/display/bridge/renesas,dsi.yaml
index c20625b8425e..00ef279129fd 100644
--- a/Documentation/devicetree/bindings/display/bridge/renesas,dsi.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/renesas,dsi.yaml
@@ -28,6 +28,7 @@ properties:
           - const: renesas,r9a09g057-mipi-dsi
 
       - enum:
+          - renesas,r9a09g047-mipi-dsi # RZ/G3E
           - renesas,r9a09g057-mipi-dsi # RZ/V2H(P)
 
   reg:
@@ -54,20 +55,8 @@ properties:
       - const: debug
 
   clocks:
-    oneOf:
-      - items:
-          - description: DSI D-PHY PLL multiplied clock
-          - description: DSI D-PHY system clock
-          - description: DSI AXI bus clock
-          - description: DSI Register access clock
-          - description: DSI Video clock
-          - description: DSI D-PHY Escape mode transmit clock
-      - items:
-          - description: DSI D-PHY PLL reference clock
-          - description: DSI AXI bus clock
-          - description: DSI Register access clock
-          - description: DSI Video clock
-          - description: DSI D-PHY Escape mode transmit clock
+    minItems: 5
+    maxItems: 6
 
   clock-names:
     oneOf:
@@ -78,12 +67,14 @@ properties:
           - const: pclk
           - const: vclk
           - const: lpclk
-      - items:
+      - minItems: 5
+        items:
           - const: pllrefclk
           - const: aclk
           - const: pclk
           - const: vclk
           - const: lpclk
+          - const: vclk2
 
   resets:
     oneOf:
@@ -136,13 +127,6 @@ properties:
                   - const: 3
                   - const: 4
 
-            required:
-              - data-lanes
-
-    required:
-      - port@0
-      - port@1
-
 required:
   - compatible
   - reg
@@ -164,33 +148,123 @@ allOf:
       properties:
         compatible:
           contains:
-            const: renesas,r9a09g057-mipi-dsi
+            const: renesas,r9a09g047-mipi-dsi
     then:
       properties:
-        clocks:
-          maxItems: 5
+        ports:
+          properties:
+            port@0:
+              description: DSI input port 0
+            port@1:
+              description: DSI input port 1
+              properties:
+                endpoint:
+                  properties:
+                    data-lanes: false
+            port@2:
+              description: DSI output port
+              properties:
+                endpoint:
+                  $ref: /schemas/media/video-interfaces.yaml#
+                  unevaluatedProperties: false
+
+                  properties:
+                    data-lanes:
+                      description: array of physical DSI data lane indexes.
+                      minItems: 1
+                      items:
+                        - const: 1
+                        - const: 2
+                        - const: 3
+                        - const: 4
+                  required:
+                    - data-lanes
+
+          required:
+            - port@0
+            - port@1
+            - port@2
+    else:
+      properties:
+        ports:
+          properties:
+            port@0: true
+            port@1:
+              properties:
+                endpoint:
+                  properties:
+                    data-lanes: true
+                  required:
+                    - data-lanes
+
+          required:
+            - port@0
+            - port@1
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,rzg2l-mipi-dsi
+    then:
+      properties:
+        clocks:
+          items:
+            - description: DSI D-PHY PLL multiplied clock
+            - description: DSI D-PHY system clock
+            - description: DSI AXI bus clock
+            - description: DSI Register access clock
+            - description: DSI Video clock
+            - description: DSI D-PHY Escape mode transmit clock
         clock-names:
-          maxItems: 5
+          minItems: 6
+        resets:
+          minItems: 3
+        reset-names:
+          minItems: 3
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g047-mipi-dsi
+    then:
+      properties:
+        clocks:
+          items:
+            - description: DSI D-PHY PLL reference clock
+            - description: DSI AXI bus clock
+            - description: DSI Register access clock
+            - description: DSI Video clock
+            - description: DSI D-PHY Escape mode transmit clock
+            - description: DSI Video clock (2nd input clock)
+        clock-names:
+          minItems: 6
         resets:
           maxItems: 2
-
         reset-names:
           maxItems: 2
-    else:
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g057-mipi-dsi
+    then:
       properties:
         clocks:
-          minItems: 6
-
+          items:
+            - description: DSI D-PHY PLL reference clock
+            - description: DSI AXI bus clock
+            - description: DSI Register access clock
+            - description: DSI Video clock
+            - description: DSI D-PHY Escape mode transmit clock
         clock-names:
-          minItems: 6
-
+          maxItems: 5
         resets:
-          minItems: 3
-
+          maxItems: 2
         reset-names:
-          minItems: 3
+          maxItems: 2
 
 examples:
   - |
-- 
2.43.0

