Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8FE606A338
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=ujQJ6xHm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EFDB10E0D7;
	Fri, 23 Oct 2026 16:48:57 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010025.outbound.protection.outlook.com [52.101.228.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35A4B10E5BE
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:48:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yw1lHbRVo64y2/VZCINFINljxT/x00A2Wz+7NNhq0XmL+mokGIhPjw3uhnHv7hM0mK1mxx4g6qYqrXtT6vk0EOk2LSJKdTEdZ3zaWBVTydfscs8KQvMNCxWXw2cDVP8rlxxNrXMClQBEE1Hgi9CXklMapPtsEZuzdMZe0ha1jZA1M6gGy7HxBvCZ3+KsTNv7jh8jBiOLnI9PQ6I1iXGFLw1yhZrWklw0wmBmXPsgTCtuG2ysZbxtiSxTYPUFCW9DTXWOnLhqcqAEt11PpNAJS5RGvWPf7zCqA2QbJGorOJ9F2jvEt5k+cNFHbVHFw74JtaIQqfENZN77clgrviom7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mido/t2iCAhYwCN3Wj/AmQ11xt80nMrtClrCwlMTglw=;
 b=pOyRnmaeXwsoFKdxLnnZPG4hriVtrgP72UDGodFBMwPEgwAkdP7F8NCf0L74iCv7I7QLd8elSvdseCBnf2D5pax261pbIAeGaYjexeCtE0+6zJfrrf1ilKcfHjb/S+pzfAzgHdIny2ji+AgAdfzgm60spB9Gv/NQCAd0UYzG9XJcUlzZBRYTiqE+3dFgibjZYk1nB53krdDmbywmS/fbB4OC75eQzP2tmfEra4NuAGeNeeQb96bkK5/4m1gjOYYCb374SCWaeBAnhUnwJXgR1V03HLKikoKDxrd2ikvQjumQIbfQLqPPZ7PERaoUXAHu+hmTG3CqtTBdPo2umRDg0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mido/t2iCAhYwCN3Wj/AmQ11xt80nMrtClrCwlMTglw=;
 b=ujQJ6xHm6TOOp6CYGmMhVPBz3Vgu9mcPAw/yVR9iWEjGHU38GS/6nmnh3gHh13OYVs07qVZscfIOuBZSBZtBAIILnNa1JHY1blRDbhLw+JCq2tmBFpzsyTrf9dcsDnjeGLiBXE7kEqx8iVh3zMFaD4clopr6BLglepGZ/e1Lp0E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by OS3PR01MB9415.jpnprd01.prod.outlook.com (2603:1096:604:1c6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 16:48:41 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 16:48:41 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: tomm.merciai@gmail.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
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
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v9 01/10] dt-bindings: display: renesas,
 rzg2l-du: Add support for RZ/G3E SoC
Date: Fri, 23 Oct 2026 18:47:34 +0200
Message-ID: <0b55aa2974382cf6f3a278f4c5f64f0af403bb95.1792770965.git.tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1792770965.git.tommaso.merciai.xr@bp.renesas.com>
References: <cover.1792770965.git.tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::15) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|OS3PR01MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c8204a5-0454-4eca-1597-08df31257e2e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|366016|23010399003|1800799024|261009223027099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|260925021911599003|260925022911599003|260925021311599003|10067099003|56012099006|3023799007|6133799003|18002099003|22082099003|5023799004|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info: ePLIxauk3fnDNaZBlpADhTjLOv/tp0cyKGMP1rTfODIY+O9oggIcLooIGJz2JhjcrR53B0JyyTbZ84ZiAawg8TBaynhU65MXXwF6UVqlQNi0kmznu0tpnvI9qEwiwUZLKVbUxGDYNfi/eH2Pc/QuYhZf/9DXK3yA0R8ajwq6fEcvlBbPNqY+XoFuEI8wtPKqv11MpjH7IIn8OibVbYuHwJtymbPFligs6s4MyngUL+nw7LqWtUJOd3FjzcTUhrxsvKBE1/emVmgdBA1UTzSAonG0uiEDA6iUuftjN9fUonx3uSAwrpiuLxQy5Pvx+vb8S6Z7EQzNKlRLRiCu9gnD9otLdq28kiSA3BUawDc5MQcCRL6nOMN8tI/PM6SYkWE+P8B1OjTt8uOMvuShHaUjUrFUGYg8mYUn2bhDMZQAkzSsLyVkCaC+l+PGWe6YPWTcXQHEGeePc8wwkFESHHOJPHzm2AgAfwkTGUI8uhjW93DDnG2TrVgsqmrLZOwCaHPFEFp8wrt+qY2ULc1uYWyTAnSGSiTg2EJm7S6i3udeGnF242bzbx8hScVnnvn+0KuSprUx7FPXzCMyg3qz0TLHs1XqY68MagjLnIQNe4Wy6TWs5Zzpt9wt/dZrqweCeWLOt4FV4bDJsxnoqCTZ50ujKIt1ikcoNNKKWW8/oC1SzVk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYRPR01MB13588.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(366016)(23010399003)(1800799024)(261009223027099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(260925021911599003)(260925022911599003)(260925021311599003)(10067099003)(56012099006)(3023799007)(6133799003)(18002099003)(22082099003)(5023799004)(11063799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VspgHQxJiUXAG3jKeCOLi955WC5UPaYoBR9NDtGpn/uj1tuXYoBhAJn896w2?=
 =?us-ascii?Q?/frDRmK4mB8sRmXKFFa5FZkA2JfFUolk95K+APTiBGl4XEE4VvErewyHj+CL?=
 =?us-ascii?Q?y3omcYBRbOQUz3nAYvhY2SBOCQ89zBJUUfvGacKyx7rAU8SHfVAoO6bzFw2L?=
 =?us-ascii?Q?aORZG2rWUarTyK5XGV7HkbDrN88Dl0IvIGMAhEPXLg7YLzQkJoi3Za8Pjf+5?=
 =?us-ascii?Q?H98qlZBV3DZeIyrZ6l3JAxAs/6OEkKvn/W/2LwFn+dALs374DIRVJ+Zv9c7a?=
 =?us-ascii?Q?HJyeBesgZSLKB4FY8aL4eoxQqHzsAsOZg9aZAkgMAhdpRO+MS8IOxxN03quj?=
 =?us-ascii?Q?+zuEaTCJI+0aaaeJqTweAUy0TTiph/xHV3J8qXZyhXilh9aIiNAPMWuUanNF?=
 =?us-ascii?Q?8ZRNsgPrDwZ5ZVkLFBRX8CUKEAHeDIiY6/dSvjFVY0faNACCNLLq+C2ix2Dd?=
 =?us-ascii?Q?yJgM9GsBKnU9c6l3VVg3yLzBHtS0KeeAKbBnT9ab/Une6tI1opKaZv2yFDUk?=
 =?us-ascii?Q?XLSlU3yzI39lFBIjzS/nAvufUyrNgzmFbwWD0wH+T5A6Yd/GNFVYZvUdgOSX?=
 =?us-ascii?Q?jUiMJOX+c6TlqbVafV5cnG+xQ1kGlO4M9tYtLBVvWGoSWqJKqsKH4zGWTvpy?=
 =?us-ascii?Q?8Fs+sosDR0iqx1hD0HBMqAbnkYUPw8R5QLdUX8/oB86aVC1hafqqK21m4aoD?=
 =?us-ascii?Q?t8oDaYPhVnQMTpr7MeowKIwAptUnVQCZNjY0IzWM1LMgFS0UYM24Ct8XKWVK?=
 =?us-ascii?Q?0HAYGUGWLwFKFMWykc7luWy5Rm7nlZgM0SP2M5YoYZKx4pMkzKCkJqJfuJOK?=
 =?us-ascii?Q?0gYWmQGarrP5BKY7sG0KZ/82NY9k4B1zDLB5zXxOwMUB8rUHPciy9choyj82?=
 =?us-ascii?Q?d9EmKiT+uqGCOCvGjmPVzdDWH4RhBrwNezyq6Vp5mP5RJkKLNAiZo815vVkc?=
 =?us-ascii?Q?fsN+XAvLY/bgGaExb6RLT66AV2ftl9MHfV1Pmfbh5OaoYX2Bt00IbaM0VcqC?=
 =?us-ascii?Q?cqBNqFrI/Qw5nQNNBXOmZ0B02ZIUz/UCU8lWJ1CyRYJp5rJ7UiqBr7zoHbhb?=
 =?us-ascii?Q?tj6GK6+bB+KVMwK/lgfRJ5J4HZ54aqqS/NhLbYRQ6o8Zr/mHoUEh3Fy9gfpx?=
 =?us-ascii?Q?Qldwip+lshkFZM6YygBTwUY9oSaAN1oNO4x+Dvi/fOEeunkKYLfN9j/0+79x?=
 =?us-ascii?Q?rmp+hGcuH+/03Bl6LYrcbp9cRDjCeG2Mr3UgpWNVZCb9gl/oZ+mVP78HJP5P?=
 =?us-ascii?Q?CTMz9PUIz/oSoic0L3xlM0GBbVkaru6Rpm7CLMDFGw6bHt7pLtpW4JYmZFF/?=
 =?us-ascii?Q?TsIS8mnC18HzW9/4rz6tW7xOT0oIpyzpNg22Guvwa/l5RB/aUr/u4HJYVw31?=
 =?us-ascii?Q?rc/cdvQz1huCZgzwjkKMALjSS8SYnHrSt/SM64HBdqJN4znjycRK9DHmpfFz?=
 =?us-ascii?Q?J2r6bENLYm3PPskdCsM9+vjC2OZ9hHJJ/IxIprnSByBOUwThr5fYtf7QKo03?=
 =?us-ascii?Q?tcoy9PkTd1gg7b6krdx6F0Xswm3QLXLq88pKZe5EyYZH8yWi+P0Y4XFJQ+oQ?=
 =?us-ascii?Q?aJ92O+doTJWCU5O1FuEG/Hg7W19ksfig+SPOa8aFIqg6K+Cwa4P5jrBzkaZl?=
 =?us-ascii?Q?//zLcji+JXmrLlus+2W2IIP2HHqqw6mYCzDxO3NqHE6tvWgP028tSYt+rwUS?=
 =?us-ascii?Q?MZIjCGIYdMCj1/W4gwEpwlcUXuq+IqL2WQ/QcFb5cQwLfwcH/FSGtHlfnISD?=
 =?us-ascii?Q?CjojC2g9U0TTu0eHceTlBRjgNYIfCgG9aH/Eq578UZizuOlGlTVM?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8204a5-0454-4eca-1597-08df31257e2e
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 16:48:41.3689 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJEl8j43x4x/G65uv0wg5CMF0Q/832wQfXUboIp4+Q3gjheOjqj4M4JyMmQDkxCkbT+YvFF31FIYebVsRGbaR/InemeG4c94zw8Ve6IoZWqAHJlHAzQQcS7Gmu0k1dNH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9415
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The RZ/G3E Soc has 2 LCD controller (LCDC), contain a Frame Compression
Processor (FCPVD), a Video Signal Processor (VSPD), Video Signal
Processor (VSPD), and Display Unit (DU).

 - LCDC0 supports DSI and LVDS (single or dual-channel) outputs.
 - LCDC1 supports DSI, LVDS (single-channel), and RGB outputs.

Add new SoC-specific compatible string 'renesas,r9a09g047-du'.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
v8->v9:
 - Step back to v5 + added refusal of port3 for others SoCs.
 - Adjusted order and ports description.
   [v5] https://patchwork.kernel.org/project/linux-renesas-soc/patch/ca022fdbba5236c36e0cb3095db4c31e8e0cb1b8.1770996493.git.tommaso.merciai.xr@bp.renesas.com/

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

 .../bindings/display/renesas,rzg2l-du.yaml    | 28 ++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
index 5c9b15a09dee..14315b2898e1 100644
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
@@ -66,7 +67,7 @@ properties:
       model-dependent. Each port shall have a single endpoint.
 
     patternProperties:
-      "^port@[0-2]$":
+      "^port@[0-3]$":
         $ref: /schemas/graph.yaml#/properties/port
         unevaluatedProperties: false
 
@@ -110,6 +111,7 @@ allOf:
               description: DPI
             port@1: false
             port@2: false
+            port@3: false
 
           required:
             - port@0
@@ -127,6 +129,7 @@ allOf:
             port@1:
               description: DPI
             port@2: false
+            port@3: false
 
           required:
             - port@0
@@ -146,11 +149,33 @@ allOf:
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
+        ports:
+          properties:
+            port@0:
+              description: DSI
+            port@1:
+              description: DPAD
+            port@2:
+              description: LVDS 0
+            port@3:
+              description: LVDS 1
+
+          required:
+            - port@0
+            - port@3
   - if:
       properties:
         compatible:
@@ -164,6 +189,7 @@ allOf:
               description: DSI
             port@1: false
             port@2: false
+            port@3: false
 
           required:
             - port@0
-- 
2.54.0

