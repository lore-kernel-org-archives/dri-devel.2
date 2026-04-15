Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE52F4198E
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 11:04:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38CDA10E1F6;
	Wed, 15 Apr 2026 11:04:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DwAAGQeU";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010060.outbound.protection.outlook.com [52.101.56.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC79C10E1F6
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 11:04:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDR6xNcgV5uRUTd/Idylb7BWB+bELTqWSmPSmCOZm+4Kn47PoJWPldKdNCXQeKzX8tZegDboFGAeuDgf5Ne+md47nWbw0UvfDIgkQDlHINskg/nBQiyYxvQGZM2g9UoakwKRJ0Y96WJVoez53YjWZ0CPgQudzOfCoksvouKmgzrRCeDhi4GG+GRB/BSRBiJ1bCq7H2amSuLSj1yHe+oMe7puDSLw8qbNIe8Cf9TPZPRiv7GJz0/r0bUmLsWJ3BWRZHX3W/1Xn2YbocCVoQfG3LD7b9REI3qMPZ1YyCTGRu+jm+/0aGXa6YxWjmhTUQJPrVjKk4Pqowmq2LmAfBUdxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAAKTBFbQHIVsGK4ozRLR5YPW8kNgbxFHKNk1KShpbI=;
 b=SpII9qurV8lZ+dEMxE7DhpaYRdlSSRB90gki00OaN/fL/dZdoI/41BEWNb/OpcvCr3lmTqm+9dm9ap8IFKIvMpcdrL0HRwSaXFIseVE+xIv0vkGuLWWKXgFdWH/6J0mhzuxyShHtuK1UOyoIAzx+arVyO04e/aLoB69pDvozktw/gnAejrn4kBwCH+2Q56hlrP3YKSuHdKYFUH7FMasI4bMkMAjo2haW2Eh2X2leQYwllaDfuIuwuxBcE0bAb+rwjAiztr6zo4H1zbxidloSjapfEiot61opybD1FE8m2bqHiQuk+VHSYgBanMtyyF13Ar9JK+rWOldvrJ/s+XHYmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAAKTBFbQHIVsGK4ozRLR5YPW8kNgbxFHKNk1KShpbI=;
 b=DwAAGQeUEWlEBgpZEGX3eCEQctaN3w+KuwHN0AsWvS4YCK1r0NyWhfAjZwD9N9fW1lCAwMSZpZuHsk0iAEk/mi2sihCfEBTp+JMVLj46LQrHxIFgcaib5Gn7AOGrI+oftgj/AjFlWklBK6jL0urkc0u4IgT11e3Kw32zTQgHG4k=
Received: from BY3PR03CA0013.namprd03.prod.outlook.com (2603:10b6:a03:39a::18)
 by SA1PR10MB6519.namprd10.prod.outlook.com (2603:10b6:806:2b1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 11:04:16 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::9c) by BY3PR03CA0013.outlook.office365.com
 (2603:10b6:a03:39a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Wed,
 15 Apr 2026 11:04:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 11:04:15 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 06:04:15 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 06:04:14 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Apr 2026 06:04:14 -0500
Received: from a0512632.dhcp.ti.com (a0512632.dhcp.ti.com [172.24.233.20])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63FB49382077152;
 Wed, 15 Apr 2026 06:04:10 -0500
From: Swamil Jain <s-jain1@ti.com>
To: <jyri.sarha@iki.fi>, <tomi.valkeinen@ideasonboard.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <devarsht@ti.com>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <praneeth@ti.com>, <vigneshr@ti.com>,
 <s-jain1@ti.com>
Subject: [PATCH v4] dt-bindings: display: ti,
 am65x-dss: Fix AM62L DSS reg and clock constraints
Date: Wed, 15 Apr 2026 16:34:09 +0530
Message-ID: <20260415110409.2577633-1-s-jain1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|SA1PR10MB6519:EE_
X-MS-Office365-Filtering-Correlation-Id: d7fdd2ba-2bac-46bc-2515-08de9adebbdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|82310400026|36860700016|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ZqduviPV6F+mRPfKcrg4dxIh0vjbK5KDzrVECujKYRmP3AQ18pWTan6k5g0Zgn2tLQPxQJwIzyucCJzzkHViMouaz65MeDglzch6NSTzO8i9ynnN/4UuGvVH/TU8XH7hLsxpJBjWGMk/63CEOHIk1t67moImotmGy9B6MEj8oWhedEJ8/ZG1/YJf22diE6g7CFV1PXSrAmTuTxS5HA358gsdihzjsdX4dRl9r8Wr6KPg2zGKGQj646fifoEGoBmbVrchPbnwPUxQNChDNQRNpmrifFey6wgkuRWG6hztsRt2ZuzD8xwNXZXiQ4t+RIuSJezgQpQTT1qkbpyZyMonfHgGo6GF5YIivlwOq2crYeOl2NujTzZDgT49W/spx3tw4zwlydKXaBtzXtNmwNjxlDyGb2WFHwgtRRVmcK/AQxvOpVy/XiASUoMZ/1Gu4ZEoW5lRiRvjhG4FkUY5vyqP0avHFAeCiHmtW0vOnQ1AQ1ugHtF2NRscm6niU2dU3zX+CaRl3eHo/yDTZmNL1Peo55VUBJYFBvkecoFdiw6fOLjalb34T4u2ZDD4YjR++6ykcxyCN3F7UlGx0gfGVfLzRKay22V2on+lpOVTTaXViQXuXa273wyD/PA5AitcTRAKIBXxzHaiG+7i0iwKNRi9cW0XnteLRAfCzOi2oVSez0UzHkdi6FhoQ7AL0amlS9W7qBmyHuGzHYowxirzteDTBqIyrfs55QBV5/UocY1oIVlQghkZQaludiO1Lou4uR6ffNTCbj5pPZk37mRHzPjQmSOeDdFv5aLXCpg3GD1mLZhWNOdckpkuXTt3at47xOdN6eWwiN4ICyXAN1xgCJL31Q==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700016)(921020)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QrEKDeGkQGlGAoGQ3MC+XohDLB8ZwIiYgPs2D1lH3Vg792tfE5r/+npDlf5JSOl8WF4g7AvnspSQ184b1jnrJwH/1vVtUv5rURhGudkQ+BQkVeWBma88uiipmcTdqUHPEqc4HNIy2DIK02Phnwq+/ZDSJUlPObln/qvu0XjXfjyzzKPa2xJxO8ypyWjX88NimD5RVMxstN181VNipA8czBXtbTsqHYpj10sTUCjNmaBIM+BXaLydnu4WTINp32ZRVcKYIqi10ANJYpGrXQ8fDdTwH2jyW6uqjnxszOVrbIBbEkT7bxLi2nfLbEok8KkIGOLF55eOiilDhcpe64tBFICTkkweLQABXXtO6Vtabxj5znwKqbwsI/DV5yLQ+PakjX4Tp1IlGr4e690kHjzdEpxm3CIfudGd5R5nSS0A14UUQvLmQuoa/Aa4qa4zdnzI
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 11:04:15.7157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7fdd2ba-2bac-46bc-2515-08de9adebbdd
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6519
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

The AM62L DSS [1] support incorrectly used the same register and
clock constraints as AM65x, but AM62L has a single video port

Fix this by adding conditional constraints that properly define the
register regions and clocks for AM62L DSS (single video port) versus
other AM65x variants (dual video port).

[1]: Section 12.7 (Display Subsystem and Peripherals)
Link : https://www.ti.com/lit/pdf/sprujb4

Fixes: cb8d4323302c ("dt-bindings: display: ti,am65x-dss: Add support for AM62L DSS")
Cc: stable@vger.kernel.org
Signed-off-by: Swamil Jain <s-jain1@ti.com>
---
Validated the changes with some examples:
https://gist.github.com/swamiljain/79f30568c9ece89f5a20218f52647486

Changelog:
v3->v4:
- Add reg-names constraint
- Re-order constraints to make it consistent with the properties order

Link to v3:
https://lore.kernel.org/all/20260410105955.843868-1-s-jain1@ti.com/

v2->v3:
- Reduce redundancy and use constraints suggested by maintainers
- Remove blank line between the tags

Link to v2:
https://lore.kernel.org/all/20260129150601.185882-1-s-jain1@ti.com/

v1->v2:
- Remove oneOf from top level constraints, it makes bindings redundant
- Remove minItems from top level constraints
- "dma-coherent" property shouldn't be changed in v1 itself
- Add description for reg-names, clock and clock-names
- Add constraints specific to AM62L and for other SoCs within allOf
  check

Link to v1:
https://lore.kernel.org/all/20251224133150.2266524-1-s-jain1@ti.com/
---
 .../bindings/display/ti/ti,am65x-dss.yaml     | 70 ++++++++++++++-----
 1 file changed, 52 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
index 38fcee91211e..49a007cbcd3a 100644
--- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
+++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
@@ -36,34 +36,50 @@ properties:
   reg:
     description:
       Addresses to each DSS memory region described in the SoC's TRM.
-    items:
-      - description: common DSS register area
-      - description: VIDL1 light video plane
-      - description: VID video plane
-      - description: OVR1 overlay manager for vp1
-      - description: OVR2 overlay manager for vp2
-      - description: VP1 video port 1
-      - description: VP2 video port 2
-      - description: common1 DSS register area
+    oneOf:
+      - items:
+          - description: common DSS register area
+          - description: VIDL1 light video plane
+          - description: VID video plane
+          - description: OVR1 overlay manager for vp1
+          - description: OVR2 overlay manager for vp2
+          - description: VP1 video port 1
+          - description: VP2 video port 2
+          - description: common1 DSS register area
+      - items:
+          - description: common DSS register area
+          - description: VIDL1 light video plane
+          - description: OVR1 overlay manager for vp1
+          - description: VP1 video port 1
+          - description: common1 DSS register area
 
   reg-names:
-    items:
-      - const: common
-      - const: vidl1
-      - const: vid
-      - const: ovr1
-      - const: ovr2
-      - const: vp1
-      - const: vp2
-      - const: common1
+    oneOf:
+      - items:
+          - const: common
+          - const: vidl1
+          - const: vid
+          - const: ovr1
+          - const: ovr2
+          - const: vp1
+          - const: vp2
+          - const: common1
+      - items:
+          - const: common
+          - const: vidl1
+          - const: ovr1
+          - const: vp1
+          - const: common1
 
   clocks:
+    minItems: 2
     items:
       - description: fck DSS functional clock
       - description: vp1 Video Port 1 pixel clock
       - description: vp2 Video Port 2 pixel clock
 
   clock-names:
+    minItems: 2
     items:
       - const: fck
       - const: vp1
@@ -179,6 +195,24 @@ allOf:
         ports:
           properties:
             port@1: false
+        reg:
+          maxItems: 5
+        reg-names:
+          maxItems: 5
+        clocks:
+          maxItems: 2
+        clock-names:
+          maxItems: 2
+    else:
+      properties:
+        reg:
+          minItems: 8
+        reg-names:
+          minItems: 8
+        clocks:
+          minItems: 3
+        clock-names:
+          minItems: 3
 
   - if:
       properties:
