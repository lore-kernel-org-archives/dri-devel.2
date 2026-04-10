Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28978F364DB
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 11:00:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8028B10E1C2;
	Fri, 10 Apr 2026 11:00:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZKCNEXPu";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012022.outbound.protection.outlook.com [40.107.209.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3630110E1C2
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 11:00:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4XhsjMadVweyDc4sa8Jb3iytwV1OTFVGTUfZC44Vak1B/PoaPbzK8Wg6veZSHVPvOcs+/MlYWgttZ/u8fH7zObtlTCAHl3mOyhwqLP4QIlu9iScTVailcIIeH+NucGjgoWhKkp2iG/5rsHVTMWgTtXQoSEuaM9SzcWT/9Glgbsk7xaK7zG8Y7mY6u6kML24JzMyU4eu/eOb5pJ1RocJEtbGUjgEtiSmylhmjW6e0T0auLJK50068MSXW/2MUHwIQbvghyO0gXVPT/o4zawlMcVCOiMZbJtDvcJ6mo5pUyemoAUdYBdO0abV8r4TyLGvKquXQEdi4esGX2btIEH1Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76TBCdQc6wDeqXL/sQ/LdhTyeQ9IBTVx4ZtJI93D2tA=;
 b=EYbLLa991DoMJQxyEdphqFxLsVj6u/Zh8FyvpmW7tm4hPbGtsiSJE3HCb6ybb04zVH7rdbD2uCU+Tg7Pz2UzSoStWKGJw02x1PG3Pzu3HtwSGixksCSRcA27kTRJ+p2C5yXgMh2s2nesCZ1TB17jL9NwVRuzi553ggb6XKovbGIp3uhofeJm6cigahNa4SZHDJqvh3qHGgA5sHc+HjzcKfsexjnovQAnQefQEdlDppuqHdR2PAUEiHprbUfvU7w1Qn2eMQdIhHyHYffpIO16/bhFR9WlbWz2cLWDtu0QSkDWOeer4w3Vig6YdUMPSvQS8AugfkG8G92gqP0M7dtMRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76TBCdQc6wDeqXL/sQ/LdhTyeQ9IBTVx4ZtJI93D2tA=;
 b=ZKCNEXPubw7s7sllmpRHvIFDFgS76U2Sq43iLMtDHDqxYNGQPWIfB1rsL4h6pn+oXHvjLcz+hgpuupl7gAhtoe0mmY9IZbNrIrHhk0sEqr5BlyjC+O/d3W0y2i1FLK9366AC5GCVFF0/jXP4iKc+ZyotBbwqdTCouYaeZI6vP+o=
Received: from DS0PR17CA0005.namprd17.prod.outlook.com (2603:10b6:8:191::6) by
 MW4PR10MB5678.namprd10.prod.outlook.com (2603:10b6:303:18c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Fri, 10 Apr
 2026 11:00:04 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:8:191:cafe::46) by DS0PR17CA0005.outlook.office365.com
 (2603:10b6:8:191::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.42 via Frontend Transport; Fri,
 10 Apr 2026 10:59:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 10 Apr 2026 11:00:01 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Apr
 2026 06:00:01 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Apr
 2026 06:00:00 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 10 Apr 2026 06:00:00 -0500
Received: from a0512632.dhcp.ti.com (a0512632.dhcp.ti.com [172.24.233.20])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63AAxtgt076591;
 Fri, 10 Apr 2026 05:59:56 -0500
From: Swamil Jain <s-jain1@ti.com>
To: <jyri.sarha@iki.fi>, <tomi.valkeinen@ideasonboard.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <devarsht@ti.com>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <praneeth@ti.com>, <vigneshr@ti.com>,
 <s-jain1@ti.com>
Subject: [PATCH v3] dt-bindings: display: ti,
 am65x-dss: Fix AM62L DSS reg and clock constraints
Date: Fri, 10 Apr 2026 16:29:55 +0530
Message-ID: <20260410105955.843868-1-s-jain1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|MW4PR10MB5678:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e994545-fc57-49bc-e7dd-08de96f05032
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|7416014|18002099003|921020|56012099003;
X-Microsoft-Antispam-Message-Info: OEqORimkKuCaN0ZB6bcAxoxZfOqOzToEdW10eff8j3J6uY140PXCfIzCx9q5yvzFrRRgmhM4ISmxP2LWyCNlcik5lgH4fF1yJYwzbfACnJanbpsNjrt2Khi2UwJ5kF7Bt+DfddqRKoZuEzVlOKBY7r3HTN7BHIySImJXKILk6IYx1zKXolWQrVTOR1phrLrYkexmzcUF98mBGoqjjonvNq4p2GAeVZeE47NtXueiE5IZSGNWLoRwK2RX47gcf+QWL5jOssxiMbdHQQvwKmr+1Ps9rTXYXBEgE/8Q9YpTypImOCsyZvL7h7DiFIPmt0rY/kTzoaHNYTsolfXmGcXyrLNTZAHcJw2hPdmKtgxCeaKnrbN8Bo4gSoK7i95Vq3v/Dn5A7WaXag1OpuhA4GFAMuzULqhL5glV4aj1tyRkJBGQs9hM6NC/BAdQG3A5L2UyJTw8qrrgwC5l/nHr1OLKnEi+I6EG0uhaH22IIodKYpXUpEONzjvJJbDphFoGJG+YUfq6DBguWLMW+v8tLQrgyhF6WsUhfAnSFCEGhtYgFI0pQCpq2Q/a9XwjeOqYy1C399Wevag5DzctnMR4S2lduZvPPNzGbah8LQmDtVvTQioE9RLDEDwT1a7jCJ6vzcmm/grh5/g1NH7BtIuN6kIkclkidO8loZzLDyKPlO4i3v3X1olwocxwABN2rf3cR9uAFTAMji7cf/Qk3GE5HB+tmnJ+Sn34h+/KurJWGEUXAhQXtQUiYqv0UeSziY+KWtDppEuqrmLQyQ8PmWqG0TwKMA==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(7416014)(18002099003)(921020)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pWr1c16momkvhKmQ/bzTs//s6UqngclQRR6nPBHW2BbqENixg98hbve4zQl1OrcEFk+glKeQB7fGB0yTCLPbinigfv4J9IHrB0AV0bXyoCkA61G+yU607dicGmBJYxcOTJzoHHEMNV/EhiOoIhxiE9crRHqPJ7FH/s42viYcCsF0CIquAUn8kIGEk0U6ODHxiUW2E05Nv1bANAdjHEQwzG/clTnqBtKfUBGh2XJcaPhFU3WupNCIUkTUNGARHktG9wOgX2kjGg15mcF8691g7xZw/7YVrss1/KrdwQLo3tdgLqc+qJO8PAD3IBPI3S39IK3Sr4N5oypxwCGMNF9tWilek4FO2fkWN2Db1jp2ms15OR/nbQaqEeJvgwbiO+zGRgMnQLlWoSilChQoft6STWHiwiM91c292+G9UUakBn4CgThe5ILE0tNpfHMgtu/m
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 11:00:01.4112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e994545-fc57-49bc-e7dd-08de96f05032
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5678
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
 .../bindings/display/ti/ti,am65x-dss.yaml     | 66 ++++++++++++++-----
 1 file changed, 48 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
index 38fcee91211e..d8a05bf62c2f 100644
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
@@ -179,6 +195,20 @@ allOf:
         ports:
           properties:
             port@1: false
+        clock-names:
+          maxItems: 2
+        clocks:
+          maxItems: 2
+        reg:
+          maxItems: 5
+    else:
+      properties:
+        clock-names:
+          minItems: 3
+        clocks:
+          minItems: 3
+        reg:
+          minItems: 8
 
   - if:
       properties:
