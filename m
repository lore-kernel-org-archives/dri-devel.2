Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A70606A336
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 12:39:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 575EE11238A;
	Thu, 19 Nov 2026 12:39:01 +0000 (UTC)
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11023136.outbound.protection.outlook.com
 [40.107.44.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09316112388
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 12:39:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dr/26OclQZn34nYOA2+miGC+fV3XMxrHfIW8MK0ODANmYfvADDE2O7d8HyPP5mblLLi5O/Vz+/uIJ4zD9I3FIimeU+bZIYD1T2m5PXbSFs/Dv93Jjv57ddkCH+eH2kziDNGh3klvYK2fSYb3ES2IgnfyL015SKq74VFh4v2RSjnkjaO8TkXUbIzANl70UW4D1N5j/VuyB+qa4dO/tMPWiO+lNV7LR4NpSAFbd8XVsiIthSJXAkbeuavnrw5xbcEFijDRU5GGcdlOndTkSbkhp6vcJzK3AW+gD6U5qv7E3Qej8CasDZNq5hINk0xYchR9kjy9RGoQVaiGwgw8Z/3myQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WaphXpdje15vPuPpOc/TXe+1Dbcdmx1kaXbu77EgDj4=;
 b=PE91I6yRg464f0SIaipN+Mfz/gwhLE+lohj4WEP2eta77jGjghgiV4G8XZg8ypFNMLxszzxm2tpDqnmpG+RtdomoRDRHkT1FUUXHTo20d6eW2QEuBJYNyJ28WTQT8//S9fZmV0fZBQODwJ4EhklbWqpDyaY+qtChrI2/xRbe7KUPxe361xNHX5Xp5ZVD1ToGGxMC7mDjfxG9lHkhiVbphs4P72Sm72/ZqOTy8g0xbIU5JS/+lqKIl0XPakSZc2DhVNmlbb/O1TNJ4/muydqXNx22wzymHnpeAdJT/kLbonxipgsFl+kOsaCIZtIVGhxxueyl1LAMTt6ZWZGoNxZoxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from JH0PR01CA0187.apcprd01.prod.exchangelabs.com
 (2603:1096:990:75::22) by SEYPR06MB7000.apcprd06.prod.outlook.com
 (2603:1096:101:1e3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.1; Thu, 19 Nov
 2026 12:38:53 +0000
Received: from SG2PEPF000B66CC.apcprd03.prod.outlook.com
 (2603:1096:990:75:cafe::8d) by JH0PR01CA0187.outlook.office365.com
 (2603:1096:990:75::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Thu,
 19 Nov 2026 12:38:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CC.mail.protection.outlook.com (10.167.240.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 12:38:52 +0000
Received: from cix (unknown [172.16.66.176])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 52B9E40920E2;
 Thu, 19 Nov 2026 20:38:51 +0800 (CST)
From: Cunyuan Liu <cunyuan.liu@cixtech.com>
To: boris.brezillon@collabora.com, steven.price@arm.com, liviu.dudau@arm.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 gary.yang@cixtech.com, fugang.duan@cixtech.com,
 daniel.almeida@collabora.com, aliceryhl@google.com, p.zabel@pengutronix.de,
 daniel@fooishbar.org
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 robin.wang@cixtech.com, cunyuan.liu@cixtech.com
Subject: [PATCH v3 3/7] dt-bindings: gpu: arm,
 mali-valhall-csf: Add system-cache policies
Date: Thu, 19 Nov 2026 20:38:46 +0800
Message-ID: <20261119123850.2994625-4-cunyuan.liu@cixtech.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119123850.2994625-1-cunyuan.liu@cixtech.com>
References: <20261119123850.2994625-1-cunyuan.liu@cixtech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CC:EE_|SEYPR06MB7000:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9284e03d-b6eb-487f-dedc-08df463a11cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|82310400026|36860700016|921020|10067099003|56012099006|261026121527099003|261022105027099003|261021121427099003|261009223027099003|261102123227099003|261026140227099003|261028144727099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: HsCuf7GMgP7cB+L4k5x+H+4SE8fLWPFi4qFjBwwA78FIbx2xM4TxLdXWE6fvOSytYowKbliBu8UHgoPo/AZ018sUgmNkL0wIHekF2IVHVYzWgCstwrDQ8LcHAfX/romUuiPQT+FEEQalmdyoCr3qJrNA1TEJ4VC1rfoHcK2lVLTxs30G7YFkqXxc3Rwpsr6bBEVBs2ksgx5NrLFlIBn+grqNgtUs6kS/9/W4xVqWu2OE3jifWX37SINqdmDaCoBQzbzb8NmS2uj87rnTwoiKoCHOUGP1mZXXcFRCpOdn2txjJzt9Ny+mcbaqAU2hESz7AIZOKK3lAXCCxhmiJVeuO8+y14S8Wym9go/NXcaws8qWmsGftwq4K8BVYuvdb3v8a7MimIeu+BRnBxuQkwduRrLcYqRvf9FlakZGrx6EsHpxPeGbRJNnGIPtIPQy9keDXtUMD4y828UFSW7qu7qglxz/yGMcMHzGqegBXDffmn1GdQnSYf/RcVI+mlsiSmjXqjkEqYW/WPD9JDutuFeDGb/HjdsjBw3nRCybXZO43xQT9xWot0pEjDysPGFLFN3lRnyuaPapupSvyCQujlf2arX8HLepp9tCGVy5wPz3Pm32WNLHcvlqUW15FClP0RuhmviKZiZxYoRew7x8i1m2ZkrDYOLnDJNE+zOJCzYhhmlkvr5krvJMqsw5lrkPfrQ6WSr4wES0+rwt4zV7oUwB3Zvsy/JhonhflU9hz5bC/EGokhQgmXwlkLHMiYEyKA+s
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(82310400026)(36860700016)(921020)(10067099003)(56012099006)(261026121527099003)(261022105027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261026140227099003)(261028144727099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5W6l28nhQvZZpSnyKe/Lbb3pYlX5L7N5NeExZ+Ny76d4+EhE5voFzZvI0MBF84yDjD/BYJjrhZ47rFNRJIIvCr5E7iBBiB2FK+L39/eDVmjUf5afyEKL38bDgHWtK0WODRS3RmzzkVzy6GKMReJsJxQOfCwpb+sbWmFAu/EXv1OSRISTJ/pmZ9rQPygSCu1Uz0FSrGY5ypK0AO2644GVEJ0vDG5y/ZPkta9YtRE+ZshYf5yd5xaOJZudQKVLJ0J7QM4OOICvy76aF2isIi4alwQ9ymJn1lt+EDyGJwTK7Elv0KwN70gz2AFyL1QDK35HUUBcyADwQQI3doJuV0p8byPlPOE2DVZBOWimGJjr6kEK4KVOqNNrAmF3HpXBC6ueecPf+EfjZ1c54I0QgQHlQ+Co/yimDmxZYQE46Vz1mKURshl2AvHvFkI1ibg2I4EY
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 12:38:52.2551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9284e03d-b6eb-487f-dedc-08df463a11cf
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66CC.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB7000
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

Describe system-cache allocation policies for Mali GPUs with SYSC_ALLOC
registers. The policy depends on how the GPU is integrated with the rest
of the system and belongs in DT rather than a platform table in the driver.

Use entries containing a source ID and separate read and write policies.
When the property is present, omitted sources use L2 allocation. Without
the property, the driver leaves the register settings unchanged.

Signed-off-by: Cunyuan Liu <cunyuan.liu@cixtech.com>
---
 .../bindings/gpu/arm,mali-valhall-csf.yaml    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
index 8eccd4338a2b..4d50427edd87 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
@@ -97,6 +97,30 @@ properties:
 
   dma-coherent: true
 
+  arm,sysc-alloc:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    minItems: 1
+    maxItems: 32
+    items:
+      items:
+        - description: GPU internal source ID
+          minimum: 0
+          maximum: 31
+        - description: Read allocation policy
+          enum: [0, 2, 3, 4, 5]
+        - description: Write allocation policy
+          enum: [0, 2, 3, 4, 5]
+    description:
+      System-cache allocation policies for GPU architecture 11.0.3 and later.
+      Each entry contains a source ID, a read policy and a write policy.
+      Source IDs must be unique. Reserved source IDs and access directions
+      not supported by the GPU must use zero policies. Policy values are
+      0 for L2 allocation, 2 for never allocate, 3 for always allocate,
+      4 for partial allocation and 5 for L2 partial allocation. When present,
+      all source policies start at zero and the listed entries override them.
+      Omitted sources therefore use L2 allocation. If absent, the register
+      defaults are preserved.
+
 required:
   - compatible
   - reg
-- 
2.53.0

