Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD8AFD5F79
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 10:39:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D60910E5E4;
	Wed,  8 Apr 2026 10:39:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="JRVu6xbr";
	dkim-atps=neutral
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazon11011046.outbound.protection.outlook.com [52.101.125.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3BD810E5E4
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 10:39:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCtYdipgTyq1ss+eghNPe91iYkBziIp7h94HZ+2WHe4oQ4asfHUBDAZp5nyXtGh2PTox2CZ2Ln7y8/hhEicjOeXy73ADBJsw+SaKtDXuWgqpNemaeGdFZVNm8sQEQvaOWPl+QZ49viQMk/sntSSwwxPFfHjFDVhKQfu+EwaRwqn+CfWJNluGXUVAU7NngfNzCHpzB0lsn41HqOHJ8zRqKvgoHPl6DekCZSg+iOqvh34WpyNN9idEuwNrMu7OeAz8en6EIroHta+wHieWxY5qjpbidT8mcEwPThqgVAy8M/WUKfKXPR+lhGdvAXUREgYeV+2vrP/jpecWq7vcoR6yFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8icGvVvB2VaNfxDqlj3BUZOxeYPRPFXc/OATIqaPpc=;
 b=Ja3UHBTyuOMUsdmgC445Szibt/5zky7ZJex7QYJIit3UXH/FczLXKNrLJn0IFwOUV5zAcO3HDV+SzCcxVtgszs34asipCrF5fHH+2rtllLbWcGScpD+WexoAgrxUGo9PmSF8gh8SutMM34hNDpc+GINwYBiyC5f0IiY7xzVYMgH2gOeGljXdXvya/UnpP4mM2tBa9bhbYXqaDfnY0bwmfwLGhbfvwOxAEKBN4tr3Q0i4s+FTu/LCWDU2/gSQw+S/2jcTUo6Sf8sN7QCmR3ztllAGWzf/+jOQsHeiL01Dd3IDlhsGYvpFfsfgkEBcJJo0Et7EbsmmXYms53oj2DUX8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8icGvVvB2VaNfxDqlj3BUZOxeYPRPFXc/OATIqaPpc=;
 b=JRVu6xbrjamttR5KBzIJfnzxgTP2eZEKMDZO/G1YcJO4ybMHkXwzZzCnpoLNbK6aj4nF/BUY+dIZ8jGVpc328o3UgbVUHHzZGNSCaYmIVdyHsQbTCBKqz62jHhxmCEtN83Fh5/vRl+eQyrH8+NtImdqAmAo+buQoTZbXAtKXMb0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OS7PR01MB13668.jpnprd01.prod.outlook.com (2603:1096:604:35d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Wed, 8 Apr
 2026 10:39:09 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9769.017; Wed, 8 Apr 2026
 10:39:09 +0000
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
Subject: [PATCH v6 10/21] dt-bindings: display: renesas,
 rzg2l-du: Add support for RZ/G3E SoC
Date: Wed,  8 Apr 2026 12:36:55 +0200
Message-ID: <8f814f22ff62dcde6153260e2c8c29a5415c9a89.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: e23c8099-0b00-418f-e451-08de955b1109
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|52116014|376014|18002099003|38350700014|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: SAg9MuaX87bYDBrJs9+UsITMqpgYBp8licr5qhxgi29jIWslZB+wpCNJsTf89IgsKWZ6kl5xQalyR5q4yVMwyV55OpT8Zgyyds2WmIXQDKS+qSDpsg06AaWEApnNBiYP2b6QUOLhcx1BQUZrXa5wUXV0/rZwMnLwf47w8wWz7ppRV6L8izE7UlvuevJADDy8T8DoyogCusRosbO/7NDx2I/tQTEfDI14sbccAEPrl/bYfHSbCWj22UFVIHEcaucw1Jux+HH1ibn9yjqkEyD9DmSP+692/1cbVTxHXq3Xw2z3cv0LL3lAEMxWuxrT/fMwjVnCBCDMhEatPf2NsYY9UaiytjrYrJrHP5CW+S8z2vrVGyANNywebtGuAkc9E+x0zs919btTC9F2ICS3H5ytCQ6kMxlnbCBd/xmBnyNaW+WNwKj+etQPFyVUhZvfdRMeUqMmvXEu7Pf5YBshtLyzmjJw/Ie1vM1q4fkByiGZEmoTdHSn4ZCK5QiOcIRQ/L5YW63sBDc3xwnX5B4Kz+IjCkDMkBHN+qPMLpZfc8pY4lywWuw1JR5jR/jQzjwrSI7Bz4qCyhD/ELjdyEh5TTqVoRet1GKGpz/0C2QUytZ5SmjzkIkotfyvhqvplyecvqR4r3hh2M0Sus2t0ICbdHrdxgnMKhDgan2tBTsLB0NQVPnFX1rKfez72y+ofqkpmV9AAayYCy5v6cOVLjTQuRguVjOTk16cB73Y6pHA3MPhlDYtFur1/XDxvUL3rJlRJOWTQOgMHUtWlbZUr+6EEWEWVP5V5eL0Ngixb/dtQR1K1F8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB11947.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(18002099003)(38350700014)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xJIDRJKmp9SVlIFP28I+dMTVLV6r3Ar7ujcIgANbxetskzHk+Cbd82NFNSt6?=
 =?us-ascii?Q?F6PVyShbV1NcndajbTY/bfEk4b9BMoiTojwy0CJdD2yaCr1Q2w8dSFsOXT3l?=
 =?us-ascii?Q?+eJl4HuFWr6bikE+lXtgOuz9H4RgUEDZZRt0ngP8hEb8cxf1+Q+o6d9swFr5?=
 =?us-ascii?Q?gln9gKgjtBvXc9ANQrwAH/NejXcwiKsEsQ+4Ed7lZYCttRyc5PVltcskb6Mf?=
 =?us-ascii?Q?VnRJwyJrHjNz++ywvWXWMBFdG2N6n4Sc6A3LijGIUopZt8auDI6QQTSCNsTq?=
 =?us-ascii?Q?nbPUeeGqBJApIPZ6E7p8BnWJ/anrsmdDzbeh5+rpY/PMu+x9Pf+8pC8ljCUk?=
 =?us-ascii?Q?3643M9N1Bglw9v/S5ZckekjHQA8nEX4dAFgrIi+9q7WafQCJhGP1MqDX5EUs?=
 =?us-ascii?Q?pkqOpEdiOCkmOIZTKTCRBqP4vl7fSp1basYc4yCvQDvgJX9Lc8Yhb6f/EDbW?=
 =?us-ascii?Q?P2MYrn5xL3F0pVfxnE1zYO7EHiH4ASnCyXR4jtYzSvGn6PeM8pLtxnw9x2Hr?=
 =?us-ascii?Q?f0m7l/vkmtzegf1upwd90FCup0m3KaQ5uyGeHA+eTHygQErIfsQwUsuGNT7t?=
 =?us-ascii?Q?oqFHl8WPU70XHniJd0fbdOQWlFCVkNxRrhxxNVf++W0No2wP1UyDglhPItnH?=
 =?us-ascii?Q?wUGmLqmTtTJphfplbELFdQqpKA4G81wBRSNihRFUmO/WqwOVlbAEWnzfESez?=
 =?us-ascii?Q?4ub5gepQOMJ+nxkgWX66LdDdF9eO8uJHayUgTXEael0Lh6/onkfbLF+x2iXo?=
 =?us-ascii?Q?4/wfOYG+Q9tlNDSv3rh5YEPxkQQlg9ZrATh9EuFFaqoi4zmVFrywWDH3jlzO?=
 =?us-ascii?Q?dKG0vIktSFCWM65ZdO2l+6MsYGCZQ8DxHLyhQf1OEnVhp3PmNeL2HudFSuVN?=
 =?us-ascii?Q?VXUMh/8EUDBVSMttpFhiAfg3qLDFeIkkwirDyZIgDq/I1p7GTRf3PQ2InI0S?=
 =?us-ascii?Q?+YHnluH4f4Qt7pzcxlNVyzZR2OJQtP9+nHzRJl3M7TAA238aarCnAyWQKoOh?=
 =?us-ascii?Q?e1sX8kVbsQn3TafXm9JLzIV2LVidI0j+ozID1pvuv+Y7weRLeKzmRZ5wFU4a?=
 =?us-ascii?Q?tT28IaUJ/bTOhX1gMs7ltFhSr5XPp1kUwc1/01wRUwLkf1oB+xI2J/ZXlvEq?=
 =?us-ascii?Q?RHOYeIKL8g4f9FyMFs/2Qs+g2V6wv4hXOtVebsvbkN/QKiaDOA2SFLTo2Bha?=
 =?us-ascii?Q?C+oVqRa4/rXwvd/59YQZTk2fLCDlq+bLSYXv6x4AhiTq6zMg+YRhMbp6KvEz?=
 =?us-ascii?Q?e8zlKHCgkIetAmLgi8mqMlRunXgfZKI2EdH580Vh7Tq6Fx5XiHnpKzqU4cPg?=
 =?us-ascii?Q?B0Hudvepf7nPhLX+zmRNsFt34A6a9p77RPCW5NSWKob9DcdaZAHl+dtxEtVq?=
 =?us-ascii?Q?PDuBpTYOkbaKMANaNJnuh45s62SaDBOz5L6oJv1ZTjldYRExMFBkbE8GlY7Y?=
 =?us-ascii?Q?WAsDWqnHB40mRMQWxPexuZKPL1mkYkfvNFReA94Mx067keSwPHXsFKQf4ms/?=
 =?us-ascii?Q?QBV2tOHhzpZHGGGkrjaeT/ZwL68pqtXTPDetXHGxac+2qp2TDqXBT9ZFteH2?=
 =?us-ascii?Q?72T5yZyVsCupIfU/9PPB88j0Qwt5YhUOyvH/TOfF2UbZcfJlTYTKjE6NgnPv?=
 =?us-ascii?Q?R/quPgf6o9k1Y504lR3OrCEgwDhVB2+o+eMQECmo8MAw1Ecfg3GR8rEnrh2p?=
 =?us-ascii?Q?eGg/+TDyZASfxzCTEVqBH9ejbH4oQV+/ttyRc5GGGAWtZa4Uhs/jiRQn8Vqj?=
 =?us-ascii?Q?7B6CGnBXBu/dj0RVqqHuC6WqpmiqqjEwr3Ob1WjQgwl2/eTRlef7?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e23c8099-0b00-418f-e451-08de955b1109
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 10:39:09.6973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQpEMf+aUL/xsCZGcnfGC9Vr84DcaPXGE3VuFO4sUax+Tkp6rPcrGshVmOsGHJHjVDUgGmS/aSyh+2Uk2QVJ7q8gD5hIgq9hw80YDJZfHwe2RgjPpFZ7CMAOQBtdlvSF
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

The RZ/G3E SoC has 2 LCD controllers (LCDC), each containing a Frame
Compression Processor (FCPVD), a Video Signal Processor (VSPD), and a
Display Unit (DU).

 - LCDC0 supports DSI and LVDS (single or dual-channel) outputs.
 - LCDC1 supports DSI, LVDS (single-channel), and RGB outputs.

Add a new SoC-specific compatible string 'renesas,r9a09g047-du'.

Extend patternProperties from "^port@[0-1]$" to "^port@[0-3]$" to
allow up to four output ports, and explicitly disable port@2 and port@3
for existing SoCs that do not expose them.

Describe the four output ports of the RZ/G3E DU:

 - port@0: DSI (available on both LCDC instances)
 - port@1: DPAD / parallel RGB (LCDC1 only)
 - port@2: LVDS channel 0 (LCDC0 only)
 - port@3: LVDS channel 1 (available on both LCDC instances)

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
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

 .../bindings/display/renesas,rzg2l-du.yaml    | 30 ++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
index 5add3b832eab..32da0b5ec88c 100644
--- a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
+++ b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
@@ -20,6 +20,7 @@ properties:
       - enum:
           - renesas,r9a07g043u-du # RZ/G2UL
           - renesas,r9a07g044-du # RZ/G2{L,LC}
+          - renesas,r9a09g047-du # RZ/G3E
           - renesas,r9a09g057-du # RZ/V2H(P)
       - items:
           - enum:
@@ -61,7 +62,7 @@ properties:
       model-dependent. Each port shall have a single endpoint.
 
     patternProperties:
-      "^port@[0-1]$":
+      "^port@[0-3]$":
         $ref: /schemas/graph.yaml#/properties/port
         unevaluatedProperties: false
 
@@ -103,6 +104,8 @@ allOf:
             port@0:
               description: DPI
             port@1: false
+            port@2: false
+            port@3: false
 
           required:
             - port@0
@@ -119,6 +122,8 @@ allOf:
               description: DSI
             port@1:
               description: DPI
+            port@2: false
+            port@3: false
 
           required:
             - port@0
@@ -135,9 +140,32 @@ allOf:
             port@0:
               description: DSI
             port@1: false
+            port@2: false
+            port@3: false
 
           required:
             - port@0
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g047-du
+    then:
+      properties:
+        ports:
+          properties:
+            port@0:
+              description: DSI
+            port@1:
+              description: DPAD
+            port@2:
+              description: LVDS, Channel 0
+            port@3:
+              description: LVDS, Channel 1
+
+          required:
+            - port@0
+            - port@3
 
 examples:
   # RZ/G2L DU
-- 
2.43.0

