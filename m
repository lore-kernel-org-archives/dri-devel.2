Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D370860A2616
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 12:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=BSsu+/b0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1115610E693;
	Fri, 13 Nov 2026 12:21:02 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazon11011027.outbound.protection.outlook.com [40.107.74.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E2FB10E1CD
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 12:20:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dr4CuPIYxcMJWFibrnRrexfxknx28fbXcaCleHxa89vRhyVYcF7xYkZgulqx4t71s85eydcMI610HeMO4+sViNDvCfGQ7LxMHCuNWNwRGNo8EByZlGWbZimLH3yL3hVGcpXSMyizHwlfJtBThgPDqnnXaBEyMwWRqRcWWU+7HM2t9JrZhpn95giTK6xK4e4//lZaTmo5iKVbZcm4WK0ozYyQEQe6mNM/J0gSyhDNazdMeTEVxwPvC+eoJNYigZNR0EW7hSP2VxM6OZXRtJK/k7m6l4Mo64hAdcUswap7mAWxFH5HfjC9bVq6baHrZaQMsLZv92iJdjJzarofm3LghA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GF0gUSmpVByUcL3GPpEjFxc3VktAEg9UZFT1nUXOgPU=;
 b=LBHQrsAs7qL9fzDwr+GY3Fi7b5JKrIwtf9KLey9jqhWNs7QlDwaif6sA1u5JklZErf2EJ6AB9b/6lT8oX3dEKRvR22Eg2wWAMmaSAGf5tLuTbquGtAF8OEeAak1vTUUU7ro9Hq1GwtA7kAugZoHgsfVpv60wVz4Ukjs7XT8BnUh5C6wCbzH++8XLTcBa43GoUbEzXP1nlKP12AdBuWohoUHAvGXW9jrudwjdE+xe2WE/wTWeRYE8fGUDcFiiXaq8bSDDBpfN7p6ONGVg6a2lTHvD2zuv3VigQwM3YPgR7e2OVJZwIePvz/i+ukWNKjACKAUi7fi0MeMeRZhmfoSnkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GF0gUSmpVByUcL3GPpEjFxc3VktAEg9UZFT1nUXOgPU=;
 b=BSsu+/b0paKtm6GNtCC5yEE+cjKv6CUGG9k+VWpraBTNt4hfS3ofsUCPhiTDTQjiZKKB123Ii6imyX7wiuAL9yvQAvHGYqDxP5B9bEA6AT0djBrK6pIL/FVlJ+1T63K6pReAR6IR7ongBu2Ot/azf6dkGDXbyAxpiBzFhZAcyQ8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY4PR01MB14799.jpnprd01.prod.outlook.com
 (2603:1096:405:25e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 12:20:46 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 12:20:46 +0000
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
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v10 01/12] dt-bindings: display: renesas,
 rzg2l-du: Add support for RZ/G3E SoC
Date: Fri, 13 Nov 2026 13:19:57 +0100
Message-ID: <bf9febcd2b5dba93605ef1affbf48cfa83c27600.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
References: <cover.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0038.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::21) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|TY4PR01MB14799:EE_
X-MS-Office365-Filtering-Correlation-Id: a7dacc6b-42e6-4c96-f013-08df41808b97
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|52116014|366016|23010399003|18002099003|22082099003|6133799003|261009223027099003|3023799007|11063799006|260925022911599003|260925021311599003|56012099006|260925021911599003|5023799004|10067099003|261102123227099003|261022105027099003|261026140227099003|261028144727099003|261022075727099003|261021121427099003|261026121527099003|261021123027099003|38350700014;
X-Microsoft-Antispam-Message-Info: 0E1pY8UsQEmX1f/r2Xr8AForxS/BQj6Epf6vQOjWK4abQcrc4iU1JlAFxvcvqnpWZ+wh/RDAn7lHKiw0zULD9H1eMTpjQZIkZRD/MRU0/2goUNn57XUaWAo/4nsp3oc77IvR1cBj2490cL6hWKZAfpMsp5oMqOSf/82XsxLUwXH++fZz/7v0MYAx4NSLlF04nI0KmGTX0aSWp1UGzxlo1PocoL/2gpr7I+UEk3d8VOREeMve5T13ZMV2S9AgfihF6+EiYt6mS/HLTP10tzO3TTgTKmAcct/31j2I3LZ2dpyGvx3tKnkldlVQZh8egV1PxzbTmIyWxVnheZINSWUbMAEPlQiiAE2ep1G4pPFTC24cHQyks3iu+9pGuHFtPO4YPJtfC3vhesOE8sS4CoY9vhuu5ED0o6c8m0IJJqQmp/EDNnOP0fuA/bYDuw/C3I0oOCbU4T35e83E+xPSwLSsQWagSkBSbkM+cicvifeXdcs5Wvnbv7aBAjSOD/DeFaot35ZEnSGMxX0+/dadbWQTNNGI1yPaD2VDhB7GjcIeGCHRndqpekCdUdlqeBNT+1RZtKvJ4e6rIJ9Q6Q2d6pKvn8ibwlwqoifoja9KIHhkvWVJGrIPJszja9KqU07KGUjrTmefvsR1X0Abda9MVpPVf23cPP9XC0V0dIgcVV7q+KQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSOPR01MB295138.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(23010399003)(18002099003)(22082099003)(6133799003)(261009223027099003)(3023799007)(11063799006)(260925022911599003)(260925021311599003)(56012099006)(260925021911599003)(5023799004)(10067099003)(261102123227099003)(261022105027099003)(261026140227099003)(261028144727099003)(261022075727099003)(261021121427099003)(261026121527099003)(261021123027099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7nON+KAwbNrn4PuVw6MhopKKfuzpvMOKCe8BqK8r/ykquy6v70fSOtU0MxD6?=
 =?us-ascii?Q?+aL7j0AmWjao1+AQq7ml/OY6hJixVpZ0+PmPzg+DOA/IB5Jy5S2j9r83z/G4?=
 =?us-ascii?Q?Oi2NWpAaUjXeR58JO55zIiNX74uehTkrF9FdY6Qpy5mfPUWMh0EDHjVqhpLG?=
 =?us-ascii?Q?Sosi5oGG2VfoMXEDdoFEiL3Nun+DrHkfhzezR7/NZNvpBePMVY+BrgrUnGKU?=
 =?us-ascii?Q?UAE+e/5vYjVQHuQhGcMoAXKAi1KOFF3fxS5ANwoiJ11Tzf5Dcque/vED4lXx?=
 =?us-ascii?Q?x167pMvn9PSt600jey8fE7Ve4UL14D1/Lq8Tf7+c7GiiszZQVMcxNK7zOUPJ?=
 =?us-ascii?Q?UkRtLR4V4mgTJldUYvnXmt+APpEu0cSxnq/S0LL8rVIUpjtCWgeyT+qyj6SX?=
 =?us-ascii?Q?k9n+ke+LOJWa4X9XpF2h+3o1WvPnDl6ng5dZ3RVA8QnEv+Xioh0+oRxkGET5?=
 =?us-ascii?Q?eQy0fy4ZhY3zZjHPrtJsjmEvpLPKUnw2PN82/4ufK3TC6ZouvzJZ3JLj6aZQ?=
 =?us-ascii?Q?8GQjUkLaXt2+usqoYO3joI+mrIbOzLzEfmWsdVINRS3DYkFc7UQ7KArT/ZBY?=
 =?us-ascii?Q?ljTVcP39WEaDyUoruRHSdA6bS0AkfPmZZFUDLYpRP8FOqCToJw2ER1JUE9oC?=
 =?us-ascii?Q?zwzOd74TIACmt3yXR6gOD0jvl7WQbQiJoFNyJfgO4RQCzBdsFfshCiAYBdzT?=
 =?us-ascii?Q?HQfIRtoOuIebYXcAFtCjlBiSGUOWwuQio0ETkOqgKSxYkVe+S5GGk4bIxfC0?=
 =?us-ascii?Q?38nk+1TSBp6qjDLJcVUQ3KUsIfui0aenJgudfDLz5DL4eRQZ/HzDggNhQWEk?=
 =?us-ascii?Q?cHOqNW0mzqc9ONpuzoPqoce9q9xZfFFxdCIqG4nLM0Sr0BOyF5AaW43E3u69?=
 =?us-ascii?Q?tvgADeenkMwulDy+g367sajOHtPShWT+W8dMP1kkTl/YQlX1A5QkuTYyhI2h?=
 =?us-ascii?Q?/IpDMy320SRV6qF58U/TtXazvGIM+9HTEOx5jE2S5OQtZhT5ggQn4thX4plM?=
 =?us-ascii?Q?DSlcan3lxzGrsmuYIj+2zlu7E+QdPQGejdO2Ee3Mtcpt1VOSamzF/6rK8ssV?=
 =?us-ascii?Q?IXARNvzdMu1d/Et+Tn6bjFp4eBrr98vd5RXJyy107iWe4ttYXTamBEYwCUe3?=
 =?us-ascii?Q?EHwICuo5Z7CRrrfZ0q18ukEfeOBNgW0fxv7DgoEVIgyHXhutwgIF8CpQa0Gq?=
 =?us-ascii?Q?C8VtoTeV/urKmo/bhayS94t58Yama3iAhhE3jQZsVTr2sWhOHwte1PFKplgJ?=
 =?us-ascii?Q?7ooXgRZbZ13qSZ4YbafH8Ko5QYrw0YJCC5O4lew+qAAfeNvT3YVxt64hoknJ?=
 =?us-ascii?Q?Y4rNW6zIwBxdKQ5cxsKsK6gfAD4FFw4do3yN1qMFngwG+17lxOx7XbNqda4X?=
 =?us-ascii?Q?1KotmtzKwcsRH2vfQ4808e0s/TPjzsBFz1NFQlOsAzXmmhWRT2i9gZ3KAEUJ?=
 =?us-ascii?Q?DuE6WwVpkh/meWB1tfvjxc0/GHKIOZ4ULD5+ixYFYIW1RxTCG4Q8CEnJebVu?=
 =?us-ascii?Q?grEO6ULUUf/LL2Oq9S2pkclFnzes/YRyAbVAAwqNnKA9av1hlhW84T3KCV4M?=
 =?us-ascii?Q?yIYxrFmXJ+Qmkm6ddsffV8p5AjXg8kMTS/PSpM0ZGTaVRiFkbHaHiMQIt8IQ?=
 =?us-ascii?Q?e5mvNBhXE3u6MI2avEptCuW30c3KWDyFt5gloUFBsx1dZcas8fsbFkhnTiku?=
 =?us-ascii?Q?xAxO3pi0crGIN99ru2D/LC3HAvU/aTsf365c72aupJyikibsTXfARO8tyzoY?=
 =?us-ascii?Q?/Ai53ogEtyIYp0LJOlAy7DVwmEUo5YM5qGgoeUkn1C/dk4rcYDef?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7dacc6b-42e6-4c96-f013-08df41808b97
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 12:20:46.6484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYSo/T6zO0416t//AnH/ggDOxMeIEfwcLTAEYPNe5ASJ5RT8QECo5AbiilfJ010JzyTXZC5YIcoQFLZUZ7jc/G+1FF4JY8/OvGSsee7vBI7giNgX1WeTGxMGlTnfNy5/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14799
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

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
v9->v10:
 - Collected Krzysztof's tag.

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

