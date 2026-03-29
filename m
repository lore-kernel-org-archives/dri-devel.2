Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF0EF3D5F4
	for <dri-devel@archiver.kernel.org>; Sun, 29 Mar 2026 07:51:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A0BB10E4FC;
	Sun, 29 Mar 2026 07:51:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Z65+i2fc";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013071.outbound.protection.outlook.com [52.101.72.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB99C10E4FC
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 07:51:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFe9FUObxyrGrkzPgkNxOCK+PuCki5NQq4T5tug7yi8vDhX2yTIEZH9V0rhWGB61F8FdhZb/mXHETd4kw8gdgGDpCJ8HbHHDQ/JIZVWWh2EamXMv42D/o22x3ddFBWZA0NubJoxgGrCYi48tgjdb6/N34z8yZzKURX5/SOw9iy0EUsssrlRoLV4Nq6z0EP30TgiKrxywXs3Fr3RMDoYBuMsvi6+bQ1IsPTAbiIMGstwX6oCupLJxz8z2XjhTqwwdkqguQDWHpLiMjjCetbnIUWQb6oUkpuEJodv+Iy7G3mwxN9ZE4LG8ZGrB2xN0O61r+tp3mdwgtTIrCnqOE7Ppgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5KgrqEztQRSRMLyiMm+6euNw2USy9pjtlYX3nBrBMI=;
 b=HY6teQzYFliAxRYqideRJmAQsicS6mDJhPAGZPKScrOljscub31EYITdK1E4PgjAhd6fHKXhouCZl1h9CuLG+G+gso2YoO1JHLndm5ugky4QFxdhRGJflVA6z3F9SSgtPuVHYvwpQkHpViDhxjtck9Myk80Zd9hARPF4pF44BXTfWGTkjP2TXYuMw7+Ecsjj9KPwKGA4I9OVKipeDxJhJJO+Dw1e+Bg2LVIWZWIpBsA4ZddWcqsrOJjHNo+U0zm+mnTb32trvt6BAxJprsl2bEUR0FMSIF318fqS4no1KEZGcsKjqnztdnyWGKt7/jkFm+rlaJCh4wZ2NwMI187i1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5KgrqEztQRSRMLyiMm+6euNw2USy9pjtlYX3nBrBMI=;
 b=Z65+i2fcjxXwALNEdvje6HO9AL6xlnaDErakVd0NdCSkEDU/2fvF6U1Q9+kp2fTzVAPsCImw0hXrtzsfqahg69ek3d15eylc6UNlJFe0Hd5+YqP7w37fiZTBF2UHNKkho+FDYfM9Qus9DR/avuFGflLJ7kNisG7NGLGRdlLtZcgnSKgyCL5Uy7zfP/q5gPyveF4SBBXfpjnHFzZfj7xW/b2MPAl2/q3VvlOswDOk8AkWk6jGNOaMmILx+ibnPisKptsNVLVkyQ8YmhIfn2w31PQ3WkzNZ+CMehq33/doczGpRXNBLzdX2V8cCy18VSmqf88VKPT+kAo0CDPjKQlwGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7051.eurprd04.prod.outlook.com (2603:10a6:10:fd::20)
 by AS8PR04MB9093.eurprd04.prod.outlook.com (2603:10a6:20b:444::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.25; Sun, 29 Mar
 2026 07:50:59 +0000
Received: from DB8PR04MB7051.eurprd04.prod.outlook.com
 ([fe80::a5a4:c92e:b316:aba0]) by DB8PR04MB7051.eurprd04.prod.outlook.com
 ([fe80::a5a4:c92e:b316:aba0%5]) with mapi id 15.20.9745.025; Sun, 29 Mar 2026
 07:50:59 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Sun, 29 Mar 2026 15:51:54 +0800
Subject: [PATCH] dt-bindings: display: bridge: ldb: Require reg property
 only for i.MX6SX/8MP LDBs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260329-fsl_ldb_schema_fix-v1-1-351372754bc0@nxp.com>
X-B4-Tracking: v=1; b=H4sIABrayGkC/x2MSQqAMAwAv1JytlCrCPoVkdIl0YAbDYgg/t3ic
 QZmHhDMjAKDeiDjxcLHXqCuFMTF7zNqToXBGtuZxvaaZHVrCk7igpt3xLduCU0dWxuIGijhmbH
 ofzpO7/sBX3wa8WQAAAA=
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>
Cc: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, 
 Marco Felsch <m.felsch@pengutronix.de>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Liu Ying <victor.liu@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: MA0PR01CA0109.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::8) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7051:EE_|AS8PR04MB9093:EE_
X-MS-Office365-Filtering-Correlation-Id: cd4d4d1c-1a11-48ef-94c0-08de8d67e7cd
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|7416014|52116014|1800799024|366016|921020|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: yetF5pKLS06O+teviDg1iY++wT2d7t+JjRNPRe84TJM4q6FhRzT8ZsyetRUXtPG4BgqjjpKo7I/ID4a1d/AJ59sYTYRgfqIwaR4XYR6mRcnTPDRhpqGsR53R0eO4LGlvhQ8LXrGfdZ+JqthIefKsZsruQmWaa7oVHF1RbL765n8UBA5siUag6lr/VxwdnD58q0pjLykHfZ5AshIwCZ0RaIYRoLMR3sjLQvHOjETpZzNaZhfs3dEIKq2bR76l5Rfd+Sq3mEzOm/SUddu44SVQRhBPaNia0aVhldZcxzSH+h//iv+Y6tPzyXrduMmyCMmZFnL246ax6AG828xmNOh+pqLSIzaMpt+jQSKQzzY7+BPiqwpHU+eDmwk3UC5qgOwC0t7Jy/ur6FBVQrFJYsdFV7ajsmX2BjBSSOvvriS5emVTk4w/NanPfHO6xTJnPLv0ZAeKAZomkCini17CaJJJr33S2qZewSn0+hHuR9KPj3zUh4aEUcb5U80+cumyoVyKOTEElCVVjsIMMpMOWLSgC4w2bF4nfZyar20VAOgDy4c1TKdAoFvKo61NeYuZmyE0PkxtbqFbxOXZvK2dJnxsR1LYhlgAxX2D8bqynBVcVkewSqOiLleBuqpaZPYc+prfPuvZu1ORzg5kH9J/3vbUz+YQsrJ8e14upWpjF2fVM7IAH4hdLoS1MgrkHDwH2boZ6UjiCXvDEaifcCOJ/OxiR4SX9/uOGhuM6OH8zObg+6mgqgWN+JPu3gUcfWn/IjAPXcHeL1j2Oaj8Ea9VrJG+RD7cRm+bMoUHwfaNT+J92iFnmpzUXOlSxvWZW9HwcD35
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR04MB7051.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(1800799024)(366016)(921020)(38350700014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmtrMnNVcndCMFl5bFpPTS9YbmhuVU9NNm9DN2JmdlkzK0kvV3dnQVRVNUVJ?=
 =?utf-8?B?TExSRi9yT1Z6TmRvbGo3dkhSV2FIaDBTV3FUdEJ2MnViUWNIeGtQVGU3MHRl?=
 =?utf-8?B?Mzl4R2x2N2xoMmYvUThobjdiVWFVSEZiRUlvOWU2Uitua1hQTGd1UmFuMXh5?=
 =?utf-8?B?MjlML2Jjc3RWd2daRWh3d1RCUDBGV2FYYjVtZnJmYkFLTFVXenVCT0N1MnBB?=
 =?utf-8?B?ekpaZXdBekxSbTJmTGZFekMrMXpiSzZFdW1RaHNYR0hXd2laZkVKS2wxbDZp?=
 =?utf-8?B?cVQwaVoyOE5pa0lPRElOSDl2eVZvVjczUWhSbS9hOHZ1ZlgyRVFBWVB2MjY4?=
 =?utf-8?B?Q0Fvdlp4emgvTzFqZjJsTDNIWVFob3F2eTA4R1ZJTmx6TXR1UHFGbFF0cGVL?=
 =?utf-8?B?dWQzbldRb0tTYTVTU2tqUkIwQXJTeXhIcDNMdGNOeEc2cTZsZ29XSFNCc3l6?=
 =?utf-8?B?b1Q2dVhOVUtKQ3pQK1FKK2o2eGoyQnNHZkIvd2NsMDFDamxRWGphMkhWaCs4?=
 =?utf-8?B?UGdyeExrdlp6QUxBU2k3K3lwWGFqeTJTZTRYU0VhT1JPbVdZdUo2V2NFZldm?=
 =?utf-8?B?OENEZnBwVTVMaGxHZ1JwZUN2bVRRODJYcXVNUlRVSkljcEtLcnBZWnFSeGJX?=
 =?utf-8?B?bDNBL29yVDlnZlVrUS9qOWRXWlAvaFh4VTJmNWIzTTdlNE1oeTF1UUNkUHRQ?=
 =?utf-8?B?ZU9JQ0VJMG5wSFNSaVlWYVhkaXpiVC8vZlZvS2I3Sk9aQ2VkdGZFNlpWUzJQ?=
 =?utf-8?B?T2dFaVpEK2FHNU5SYXdQdzRMbTNJNE93SVhUWXhQNiswc0N1MEFNdWxxZFpr?=
 =?utf-8?B?RktPNjMwMXh6dTNTVUtRcnMrQWI5T0JnY0h3cnhhYWQ0dHIrYWVna2FOQllC?=
 =?utf-8?B?VDJBZG51cytnbDY4M1ZPdG9NVGhXdjZVSFdOc1BvM1JJSW83NDA3Q3daWm5O?=
 =?utf-8?B?NjE5UXFCY0xFVmliQjlMZkx2ZHJoZkpCMzgwUDZaSTJQNzVNUDVpc0g2MTE2?=
 =?utf-8?B?Q1NJMG5ML2tvWWdjNFpBVFFBd2lENTFDMllIamRpaTc5RUV2clMycXdEQk0v?=
 =?utf-8?B?bVpwUUw0dXNXK0N4Q3ZjSy91SUFjZnFxR0lLeTdENnpCMDN3SGhwNXV0Z2Fo?=
 =?utf-8?B?UDR4akphRFlzOHZwemJrUk1qbnNNV3lxNHYxbmIzeWczUTVhczdXVDM4SEVz?=
 =?utf-8?B?ZmppSSsyMVVwc3Bla3ZQd0dtdDU2ak1KclVCZUlFM2FFeks1R0NSdFNRVEoz?=
 =?utf-8?B?TWJKWHd0L2p5ZkJSUzVzRGZsMnVZRnpRc2ZBSUxiVk1ZZ2M4eDBaYXJ3WkNY?=
 =?utf-8?B?Y0xkVGpWMkV6cFpuRUdORThIV251SWNGdDMyUnlrMUlpM2NWQzhraFBhTFlO?=
 =?utf-8?B?YkJYT0wvWHFiSndEUll5UnMyeXRXSDBOK05MUnczQWhnVlozM1RFSGtrVnNF?=
 =?utf-8?B?bjdBSUdkcU9zTEI0Nm5KVVM5azlUdnFaK28vQjRIK2pKUFVhNjdzSDRmNjBI?=
 =?utf-8?B?WEh2RnFXRW1XaVRoNzJjUU9WK1hia2ZjK0xpK0RTMWUxUWhoOEhsdmI5cVUz?=
 =?utf-8?B?MWNzc0ptMld0MXhxVEZ4V2tuTjRia0ZDRjFWUVZPVUgwTnFvRyszcFdLZ0Uw?=
 =?utf-8?B?UGI4V3k0Tm9qMVd4N29DcjEyRndHRlRLVjVQQmdtaTUwQ2NldXRPc3l2Smp0?=
 =?utf-8?B?MmhENjQrSmpqZ25WUmkwRnd1Q1NDdUtwK3pGRk8xWDZxUUxIaHJiRWtVdENB?=
 =?utf-8?B?cnV4ZVV1UDZmUjVvbmkyaHdUbXg3Sms2b2lLNjYwcVFyZFU0YWF3d3pRMy8y?=
 =?utf-8?B?V0pzZGJUTUlEMmRZNDB3cS92a05RckZ4NTZoVng4ZUhKRFEvdGtjMHFYOExY?=
 =?utf-8?B?TnF6VnNtaTZ2T0ZzTU9xdEJyTHUrbHBNVUx5SUxkSFF2UzFid3UvNUNGYm1z?=
 =?utf-8?B?bXAyQStxK3dpclFkdWtrUW1Qa3JjMVZiVXNYNCt1OVhJdWZGNFlVeE9yL3B2?=
 =?utf-8?B?TUdjMmRRUUYvaTByZnZIbjNsc3puVmw5cVl1QU5jNEY4UWduM1NoQldPMTVo?=
 =?utf-8?B?TEFhb2hEYlBnL3NTOU9IUmdSUm1nSTNhKzJRQm5pNG5RcjUxKzNmYkltSGdn?=
 =?utf-8?B?RnBteklaREZtMEtveUtHdjlxK0xXbHhISW1LRnBLUWZ3SUUvcDBraFBXWk5x?=
 =?utf-8?B?emFqMlR2RUpwYXVEa1FickRaVUlJam9ZUUQ0V3N2RHNvM0lJZmFZWmlPdWZs?=
 =?utf-8?B?Q09pVmdXMi9mcVZweUhLL3VNMUE4OUp2ZGVTWGZHT04xTTYwemU1bUI1UEZo?=
 =?utf-8?B?Rmp4N2FoREVvVGMyWG1aQXlnTU13YitQaXI3VStLYThaSHplaEZQdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4d4d1c-1a11-48ef-94c0-08de8d67e7cd
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2026 07:50:59.1110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCMHbBIBYr/sTDV+tJ0cyCANegyxIEGlUCegEcrorJ7cbZS1VzAya9b2xLsAJxg8eW7mF4ScSWPyIqk8vpltfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9093
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

LDB's parent device could be a syscon which doesn't allow a reg property
to be present in it's child devices, e.g., NXP i.MX93 Media blk-ctrl
has a child device NXP i.MX93 Parallel Display Format Configuration(PDFC)
without a reg property(LDB is also a child device of the Media blk-ctrl).
To make the LDB schema be able to describe LDBs without the reg property
like i.MX93 LDB, require the reg property only for i.MX6SX/8MP LDBs.

Fixes: 8aa2f0ac08d3 ("dt-bindings: display: bridge: ldb: Add check for reg and reg-names")
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
 .../bindings/display/bridge/fsl,ldb.yaml           | 23 ++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml b/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
index 7f380879fffd..5f6dc2b11d7b 100644
--- a/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
@@ -28,6 +28,7 @@ properties:
     const: ldb
 
   reg:
+    minItems: 1
     maxItems: 2
 
   reg-names:
@@ -68,7 +69,6 @@ required:
   - compatible
   - clocks
   - ports
-  - reg
 
 allOf:
   - if:
@@ -83,12 +83,23 @@ allOf:
         ports:
           properties:
             port@2: false
+
   - if:
-      not:
-        properties:
-          compatible:
-            contains:
-              const: fsl,imx6sx-ldb
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx6sx-ldb
+              - fsl,imx8mp-ldb
+    then:
+      required:
+        - reg
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx8mp-ldb
     then:
       required:
         - reg-names

---
base-commit: 3b058d1aeeeff27a7289529c4944291613b364e9
change-id: 20260329-fsl_ldb_schema_fix-4fe01c42bff3

Best regards,
-- 
Liu Ying <victor.liu@nxp.com>

