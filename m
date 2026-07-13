Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07788C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 22:36:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C21A10EB31;
	Mon, 13 Jul 2026 22:36:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="FlOzoUeo";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010070.outbound.protection.outlook.com [52.101.69.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06EFF10E396
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 08:26:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sx0Xrxl8mOrPfBgRIT+snOQSeVNZAgs7FcLRJmnfQAkEGbwZVKKDOFi0slUqedKKaTRJQfcMNnE/hy4s59Q+//+1Swlf9Ru/gZ2yUuN/gtKcnOe5rMnQ2Zt3DkXkh/X0ta3t/bEfmhLADXx3W9J7cDSC1f/5fOxGVgPAjlmuG6yaNoI7mMSCUPplvCbxnuzbq8aU2u2jEE/d668mA6oefI4XEd691WuFhy/Fz0VLvQg9M6HYzNeAmfgg7rNgoJzQgKAomA7RDUpE/UvRB5cq0n5KkDnsKPwSYYxI66Zj1bu1vfxyPPuvT5rULe2Q9ACPd61eqWHrqz9P/BBORmCaQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDbPGFkjVQgm+tObTRIF6hIjRNt6ymswZbRSqHn+g8o=;
 b=ofpw5ZVM10FAxAj+42bNlzkjElDLvx5jLEqb5UVHBY4SJ8yL8aAdMzlNrY0GUzIJ45pMpoehrzFlSZ+kcGPLEd+lvzYenrlnCDOVKwpQyzossX4Q+tF7XI92mMZBH6vRRAho1heBo6ehpxjV3En89GIVUC4CPwDc0YMJmhIaziELSWkx6g7Xw/Zn8UpJbyXIodk8Dw4TXddzjjTfC1hZVGX995uCzISuUxshlCyKf0JnXzdhlHl5I4HsHlss++lXTB3tuh801fBPOekFag3scGwjPKuXkGAinvJoczJ7ZaEyloVwlAxu6v7AQzl1LF/xHQGbPjKWUUPOME8/t28C3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDbPGFkjVQgm+tObTRIF6hIjRNt6ymswZbRSqHn+g8o=;
 b=FlOzoUeoJE7FcXh2AAj/vpjXzMO97ew4oOzY2Ibuoc2G+jC0NysycDh/BAZcMX/nc5dcx/kCcm3en27aQ0raz1xAWI+tOs/8hxR/eWvJWe/MEpos68RIlb9c/Qsax7wmJp3m+reffVO7YcB2ydcpnM744qzk9OejvIeP8aeJmfcSWoih3cSutXCNiliiNtxeCI3fdYuIQNkbXW1TNbqiwElqzMwuQWroUxdQ/za/GZi6VpIBmSgd5+n+iWNwEXzQxPX/1IsiXyva863PFqRqG3dyEGJuhuhKdHjrMeTdK4KM1s7z87AbrUr8zDwoqE6M97PG0+doeGXU6fbRYsyfxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by GV1PR03MB8613.eurprd03.prod.outlook.com (2603:10a6:150:97::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 08:26:50 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 08:26:49 +0000
From: Wojciech Dubowik <wojciech.dubowik@mt.com>
To: linux-kernel@vger.kernel.org
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 1/2] dt-bindings: display: sn65dsi83: Add output data-lanes
Date: Mon, 13 Jul 2026 10:26:19 +0200
Message-ID: <20260713082622.52985-2-wojciech.dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260713082622.52985-1-wojciech.dubowik@mt.com>
References: <20260713082622.52985-1-wojciech.dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7P220CA0077.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:259::8)
 To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|GV1PR03MB8613:EE_
X-MS-Office365-Filtering-Correlation-Id: dcf92063-f048-43bf-83f6-08dee0b87c1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|19092799006|1800799024|3023799007|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 1WgcY9uE4qrKk1FzAMkB34QALFifVV9qghZP26JnAbNds+/msamV/0u1D594bMRU3+LDfA56nzoE3qi0Ihs5JnbJct72P+Yi5rwY3DLHzdOubpDIjSOfG2BxIxmi/WnueZ03PdyfSfx7NGPr9M/yZ0wcA8zvNTNmF8Squw+hloW6QUBibaLkazyhO5pncDvDELPqRM4Dwe+qAfUwVvBHmEZ1cRpgbhl6U+22cWJjA2mlE2UI4ZlFDwODDJ27qwCSjxOCQE8meG04YnHjJmyuWqSbTTU8/IcreBNIPBLA4WJFXN2O63hgX/9ZvXu3wXGzTs0hsGmb9WMjORujJa3GcEQTtBPkV8BivZXVpdjww243F9mkpKx3/3oe2s6KEGysYBlQCJOQWgRf5heu3fOhqjGwXLeucv4dd1ncrlXtODdWVD73WH+2VOkPywie5+jIoVLzDVSKPGm3OcZ3GAgqv1aJArPKHDCcE3h1KlNPuUQjW0iLqM+kwR06BKoLQlmFtCm5+cz+cdZ/k5HNB0Z8YmjpjcB9T0e280hq6d7lvtZvtMtj59o/NnorrwnGgL+OTFWIkodmx2YKGmhaxQfd9ttiKw1ZzI8yz4MEjX3w/XBr43kg80hDuYE76e6H7nnrLWeLAcvy3bNsflLcYa1LV7U5Ig4xTUFEEyvdMcTrOQg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(19092799006)(1800799024)(3023799007)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5/hq2ebq9BQM73+bonjMBLF6yPyHmWnek6SJxqoJLqHyQ+nz9DvVVkeAcS40?=
 =?us-ascii?Q?kbDINwf4B3JMoyjkkgYpJIntvgsux8xXVQeBV1wfgeixudnwdZs7ozJKSB81?=
 =?us-ascii?Q?W0D35GkyKJimymUDQKQ2xjdNVyFt/6DVjktvnEdVcjFXdMreF5LlADjDP635?=
 =?us-ascii?Q?eaL7jtmm41uXOTJug+pD++izYinEz9DUnn1nvzOMQXgMPtoUKLw2BHHvkzCi?=
 =?us-ascii?Q?34bmgjch3fKuRPoeXdYn9FvFoJl56JPlw6jZqUhFjbvZGQ+1RvqS5U++ZFLD?=
 =?us-ascii?Q?O939Yae30+qsXddPO2JcoWrSMxNynYK3Y6RvH8APRz2L8fNmnpvtiNvlZebV?=
 =?us-ascii?Q?aSmGAaouOuWj1pprHfkCsdrMDNDJuvevNgAGXOt+HkJfVk86MVbnjE0M5hK6?=
 =?us-ascii?Q?bXG78MthmZBSIBt2pMdJe3U9iS9Efluw/AtJjAxdSCNI9HJOKUFhOIX/Ae7K?=
 =?us-ascii?Q?WyrJ4sYI2qoQu0BZLqHEzLrke+1+S8OQX2eVUDz90lHo49RQzjcg2eW5CUG7?=
 =?us-ascii?Q?SW38wRLuutHt5yTSac5yGYLEmKupbMjUWJvth5KKWHdUycLteaWGbTVKQmAC?=
 =?us-ascii?Q?/sG8tg2OmZcC/fi36gJRuwJTYTR1JpWPmxjTi6eL8Ct3XFwRQmw1gPGYZy+C?=
 =?us-ascii?Q?0cCgdWPbxp8v9eY9Wt8FBOwuprRYws95aQwWpUOxWloZxcsjmipctozL5xOQ?=
 =?us-ascii?Q?27TmAww6sKY+Qp6udo7WkixMKahuPujZg+I4DGoWV6x5KliWNV4Y3o8Jnd62?=
 =?us-ascii?Q?+Glfejm5mwl5JdBAP5BqFDNoaAIaRVyXlZ27DID1dd1iRSKpp4ft91Sbw6AC?=
 =?us-ascii?Q?rLZpVWXAbpC/YQUwhhZRtpIyrSOdjJ4K5gXS05KxHTDNQfUzw7jMOKtXf9uY?=
 =?us-ascii?Q?3CSE3nxlGvRz3ECWaRP31S2l1wLikei5oCQeZdh7A8jsRTciLZxTOZNOK3W8?=
 =?us-ascii?Q?srtKTMUHGELoQskoHkzUB7o1gTE8k0ngqbm8+YdC+WwY17m7T6++X8oNtRhy?=
 =?us-ascii?Q?qD/1c41hZXaMNOHWqScR72KhIFMeTjQ3J9bMnW4MI6Eu4wlUiy8+uiivy4JN?=
 =?us-ascii?Q?HhMAAHAMZZf8whlahXaedePP03DMCko7rUtlSnhMpYX0os1NNLuRr7MciZYB?=
 =?us-ascii?Q?8XCqFH4KzesP+zD83LajvX8+/S30J3JIyhXnb5zC/DyhR1XqhoEzWSPSF4yN?=
 =?us-ascii?Q?NzdWDXvVtWdzorP2+eAzzgTMvXoAf86sKuDTm+MlBkINIl5Wt/Io0/y4qahs?=
 =?us-ascii?Q?Ms9Q0OGz2vNEukF1LoeFpu5zU7ANB76y/dsCIHTHcYLzqdZQfkFMPo/YFCRu?=
 =?us-ascii?Q?o+Cgva3OJq74solRgC9C2YQlvm5+PP+rn2YB/gJSXBpC+UdUZ6si6cSXk5Xv?=
 =?us-ascii?Q?hkxfy6vx50ofhD5GByTIA2ubrhdvbwecs2oSUKx0y7ZO47ffWOqC2Y0Zr2kN?=
 =?us-ascii?Q?N0Po40l84lEee31WEMea9Id/E/QksKVgX+5xNYF/LgcPS8+t6H7gGNh//PSD?=
 =?us-ascii?Q?TQpqVBLMzGEVOZ4Wf2TRFCOCJREKfi7iq1FJaGhQFCZV7MqT5RS98uyViVCw?=
 =?us-ascii?Q?JQP8iF3k2NaLNg+sZY3QZTigYW/yyjq2cjUGQMD/hNRWwWzkx5wrSFtgNZ+s?=
 =?us-ascii?Q?vLpk+QOxpj+7FX4H/bs2bhXN7z+qOrcd2dZ7PgdrWNZP41wcLuaQ6LjeVv0R?=
 =?us-ascii?Q?jgLab1njNcSPRbQfq+75cYkaWyisfFD9bQNzT+sutk3HNJ4uc/WqyKqKWGJ9?=
 =?us-ascii?Q?2v4D213UWg=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf92063-f048-43bf-83f6-08dee0b87c1f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 08:26:49.6316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+5YT0374svS8B2X/51HIy8Rrf0DpzFfY/7tPRA8qPmk5xBFCwWz/kX+L0pwJU+5lc0tcJQdeNBjFJqJv41QCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB8613
X-Mailman-Approved-At: Mon, 13 Jul 2026 22:35:59 +0000
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

From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>

Add an optional output lvds data lanes property with
two allowed values. The array <1 2 3 4> for standard
layout and <4 3 2 1> for reversed lvds output lanes.
The latter informs the driver that reverse lvds config
option has to be set in config register for the respective
output channel.

Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
 .../bindings/display/bridge/ti,sn65dsi83.yaml | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
index e69b6343a8eb..2693c0273f9a 100644
--- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
@@ -86,10 +86,62 @@ properties:
         description: Video port for LVDS Channel-A output (panel or bridge).
         $ref: '#/$defs/lvds-port'
 
+        properties:
+          endpoint:
+            $ref: /schemas/media/video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              data-lanes:
+                $ref: /schemas/types.yaml#/definitions/uint32-array
+                description: |
+                  Array of physical LVDS data lane indexes
+                oneOf:
+                  - items:
+                      - const: 1
+                      - const: 2
+                      - const: 3
+                      - const: 4
+                    description: |
+                      This is the default layout
+                  - items:
+                      - const: 4
+                      - const: 3
+                      - const: 2
+                      - const: 1
+                    description: |
+                      This is the reversed layout
+
       port@3:
         description: Video port for LVDS Channel-B output (panel or bridge).
         $ref: '#/$defs/lvds-port'
 
+        properties:
+          endpoint:
+            $ref: /schemas/media/video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              data-lanes:
+                $ref: /schemas/types.yaml#/definitions/uint32-array
+                description: |
+                  Array of physical LVDS data lane indexes
+                oneOf:
+                  - items:
+                      - const: 1
+                      - const: 2
+                      - const: 3
+                      - const: 4
+                    description: |
+                      This is the default layout
+                  - items:
+                      - const: 4
+                      - const: 3
+                      - const: 2
+                      - const: 1
+                    description: |
+                      This is the reversed layout
+
     required:
       - port@0
       - port@2
-- 
2.47.3

