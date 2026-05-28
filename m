Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F20CD6E4C
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 15:07:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E67D910F349;
	Thu, 28 May 2026 15:07:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="r/8WXy2t";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="r/8WXy2t";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011048.outbound.protection.outlook.com [52.101.70.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E06A410F320
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 15:07:19 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Aa4d6l6yRhI7ryldnykR7UjEKfL9yLKFJUK26LfNxS/CPyaJYPje3nJf/rB/UARjsZJDEbFMs64d5abSfJriOJIjV7jJvFTJRrIp/ImGr3Kc8W56DihdyVrBRS32gzVAWl2/Va9+4m+A3lIFg6lJw1CPFtswQXhziGg5//vOgwhlUFi0sTozzy4MRPOwB7DuLgI0aFH6V5UuJzxld18qbD9qlBioswB9LWg/C5nK6xepPpFLnhhoY/HOLlBhBfsohugMC/95crGeZ9fSDuQv9O7xUZoH/5RbY+WEwNG0Iovaz40y1Zvv58iQKD9zvsSC/mpcOOnZodMGYZq2iLHzHg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIIgXhdn+z5O1hAbaPaHsxkD75dO4Et/9niSDGQcR4o=;
 b=xB683i8ncl62maN6tORs7mlhNWPaegBbog6n0djttYmWa5UF0/LFtH+9nB6Wv0IQvnCF+38875Mp8vw4jlyRrJraepLbakV9C3qOyuDPpr/NVkXv/Ko4TKX++S3GNgyvQurA4g4x+jWxUVkus4JHS+CwlnXE9P2WpsYVPVVDQUQE+4QPl/4B+RxOr41yKzWZbZ2eLiI0oXQwt+m0GKPkpgB3FcQo/lfKN24wm80e4LIKwt17P3VByT4fJni9Oh13LdGNirqqCjEKDTwyzkBueyk+2r8NPKHwmRKqfW9WUxKWRjbewXqs2lvmvp1Jveu0VHTXIQwGLAHf5fkpaJgAig==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIIgXhdn+z5O1hAbaPaHsxkD75dO4Et/9niSDGQcR4o=;
 b=r/8WXy2tBy8JMO4KhPpzkDg16Whdn4gGWlcg95B0n7JKpteptPe95pj75FMooiBsxV3Y3ESBkl7BLHvhketk9lVAdoZMhhZQVd6nf+Fp18ZxjcLCS2GBKWDoWJHg4aCQMVvicu1IuYPCAV6o37tPqgzvttSOVcERf0lpu8AQzBM=
Received: from AS4PR10CA0019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5d8::19)
 by VI1PR08MB10242.eurprd08.prod.outlook.com (2603:10a6:800:1be::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 28 May
 2026 15:07:14 +0000
Received: from AMS1EPF00000042.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d8:cafe::49) by AS4PR10CA0019.outlook.office365.com
 (2603:10a6:20b:5d8::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 15:07:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000042.mail.protection.outlook.com (10.167.16.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Thu, 28 May 2026 15:07:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eVNq/U/Ka4xdZ0N8SjpGVJsPlNo7D2buTLb5czxT6rc5aBEV+b8jqCLVXr3QhK1/vh0YHkid7Ed+6FAYpMz8OBFiMbIEZLXXqqbwuxbRRVaCh+BTaFNtfmS7Uzsma4FPSA/S3t5Se3WKoNnUXjVm2b5yFA5quonkUGagS6+cr6ys6X6vwQxzaLScma0XNtB7KDoSVGRw4ggZgdMJ44R7UE5Db0sjivVeFD6vjNDdXFU7jMOaXpWeN8/GqrCE4olGu80+fCxm3GrLfFZTrao1I1OZ3H3yb5hBaulepyoiobSCqos7hCMgz7C/hkcF+ngunJWlgT0JKruJtsAh3eSd5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIIgXhdn+z5O1hAbaPaHsxkD75dO4Et/9niSDGQcR4o=;
 b=K16iEtxc2/lYbGYUW39PvRR7NykmGngRi1OdtAOxQQDTtIxgfr3A9S7UqprDECwgSY06I016ImpZMjaXfnFXtEOxqRWdqD9jw8zMgWWpkENlU0vnIfk9qpcECSdF5xQhBWbIHRMEMBo3tIaHJcseN7fn0JVPUrbQliOPPORA4seZ1lymSzgr9nVVUunn/r1PgY9bYZu879K4ke+QLlsqEoPY5LT2uROsVOhcx1ixvTPLApNa1PP5pbDkuD6CCMAkLtbz1U/bsfNjApoNl9bf0/RGQeljeoHsaV2Nj1TGBGkTFYj1Y80ejH48V6NjZqHFX9e93fyTrLf66HquqzgyrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIIgXhdn+z5O1hAbaPaHsxkD75dO4Et/9niSDGQcR4o=;
 b=r/8WXy2tBy8JMO4KhPpzkDg16Whdn4gGWlcg95B0n7JKpteptPe95pj75FMooiBsxV3Y3ESBkl7BLHvhketk9lVAdoZMhhZQVd6nf+Fp18ZxjcLCS2GBKWDoWJHg4aCQMVvicu1IuYPCAV6o37tPqgzvttSOVcERf0lpu8AQzBM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DU2PR08MB10015.eurprd08.prod.outlook.com
 (2603:10a6:10:49f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 15:06:09 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 15:06:09 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 12/18] drm/panthor: Add AM_RESOURCE_GROUP support
Date: Thu, 28 May 2026 16:05:40 +0100
Message-ID: <20260528150546.3168527-13-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528150546.3168527-1-karunika.choo@arm.com>
References: <20260528150546.3168527-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0639.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::6) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DU2PR08MB10015:EE_|AMS1EPF00000042:EE_|VI1PR08MB10242:EE_
X-MS-Office365-Filtering-Correlation-Id: bf7f8bb2-e555-44a4-2393-08debccacd1c
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original: j6lDOHG1NCDSmTKKnK1mIlk9SuuOMDDPc5/xp+fI70BKEyUTCqSZxUPxszKHkxISOp6Mvk+kwvLzNR+rEHUb5tB97UZTKx6R3NqLpqV6kBPXbz+WTfcfFjmq9ftEPEALCC32e4NAbI8XAiKH1jNQvtKTcS1YfXGzJszKjPi/XL3VBqIEo6tbf63AlqaShj8Uzs3gvevcTkJ6DFCfurFBabn2RboMz4YBqMpPf38USZOHOsGvXGh09HM6/zvXuxoGTRn7CTOGxqM/42i5YVNX6K/IwEiH7fCXupVFXgpIrSF2xwZRX+jmTwIqywjt2pEXy7I8VNQOX0escPC51tXHCc72FJFeSVG6ROgcFGmkVCrrxhPP8YXSortt835HCwKI1C5E/40OnsNTuG40kCDFduYYId5zU6KYqTiGrG4E9z8rN8jaEb7pLO4sKTXFUDXB3pQvVpbdEdwCqc9we+rL6yOiMtsOB9L/Iqioeq7pLLzc8o+n+D0yt7znfzsjrVyDhMF2ZNIuc7OpfoQhjklKeeQ9xUrrGyrYUsa0QDnmdW/j4wayGu74cQY33fSckrU+PifCH0X/nxiWMEPJuUAaFT4Hqaxhp4PQyZpXqLIhydPXJEWSf9WHpZ+1xRkeeDnvIroZm6p+6F0zpT3eSv4TZZDCnpfKybtyv6eHL7lvLaFj64XSAmpIL1JP3YSeE9nq
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: rri8Q+dOagj87b2T6lQ07VJ5UkaMrz7umJ71hvpUK0atuM8tx7fDcqyTQpsni0U90qh/rWfNMH93v65PfdEsza5nf+3jmG0BuJiPFPLp2/LrlG9LVLilProAd3zgesJrPJlKl+BLonlNIjVVVE3P1/d0fuplFJZzEXiUGbPNzRZk21aZohvnjMMDIyu/p4lg5oRucZ675zeWPQv3iLTazk8GC6DsLY8MzcO9/k6uvDHnJxSc7ct7bx+MAOtIQvqAnht6y+qxPsxBczr84reSKAu0R1Uvb1ZaUtrN9LBTaOPixq/ApRrh84nQuNYT1tR/RPpd+c6tdcRgjwHl332Dxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10015
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF00000042.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 53f8eedf-eda4-416c-4fdf-08debccaa696
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|82310400026|1800799024|14060799003|36860700016|376014|56012099006|22082099003|11063799006|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: bXWQtvGB0QnY6QGBKGamsJnYrJnPqFGZLVuL3AOzQ7svVnmqjSLSlmHMLAgCfljR+ih+Ixn7Zg1YE7krYiFMsQAt6rR23EDU2Wq4jJu4jM++SQD9HLDiVGG7DND7hEFwH/oNafFCQyTUAGkKFp/s3jq7adJZgAsaYQFZdDC8K+OVw1Ev+yzjJnaKMEX3QlNsVUyrf6+o/z8LjIUeKp2KzjWFM6qkcHDwSizgQBeWcuL6A1huOAlFwnLem++LqPBz//L59aQH0gMoHRhhVlxcJpIhKBW/J/hFfJzIph6TJYNqPwqhQC3UMBkRw+94JRlk4ueEZGRhH6DPL6lauWEEs9CgcZahYhoQqBhsuKoxYrcXe0xhMAiyuB6cBO/w+dUod9MzlWP51whWSfC56iShOuAhnopr5NBQt+jrJ4tFLrYbYN8ijJ+lRQBRZIFDtMirdagFDjdvC6OO6TXGzYgsO+w4w2VRbh1EerddNS8ZUmUdIbua1BKXn+D7ITrsE/2Z0/vFCcZa9MzajSWAqJkcpj9NICjyIbwqb2iRBdboTk3u7HnsiQsVgkJ3U6bN6MNUtcfUGg3XhicO56RwT7r84GTzByyJkvuDDpmn5dkMtMP0P7Ha1kXB3VjE//5kFFHNWUQBdpNeAgIpZmfY2HMJsaUg82qISxBUgQOCg3tm3jb6WRWxP7CUiglM+fv5OBSMPS1LGIhF/1fyZBpulWCXs/0bQf+iZ84i2A1h2Tztza0=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(82310400026)(1800799024)(14060799003)(36860700016)(376014)(56012099006)(22082099003)(11063799006)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: f8jMaRMLJiG564kNI5x4eW6C5ZMKHZbWjxikVbzQuDyjhIufHRdpMx2KmzCGmMM1T8lO/hvjq9nByf1ekGFKQG8f8xWC1UWwgn2flK/fyHhx/haAo7FtcNEsSmAUE5fBF/LbFWhBakh3tObcOaOCP/s4D8cIvu+gUnrvQUnJ4U+fTlB4hW6TyA2B7YM0XyjTd4/IK11n0a0x4oKJrLFz9PHAw2VU5/oYKIjvlWpnnE3MM6g1ld0s1UryVz59FHzr+LvGBNqnUbyePaBsjOsBzpJIeQNV6SXQRd8OgPHhPWWVtZbyBQ1Dj4IAWCZcucFqgaCai5kNm5QTvl2DgVPrQhtukg3DsQ7sDsUxZkfEyX6HyY7121UWi6+aP6ke5im7wmD+Ryx2KP6oMOpqWUQr15Zg0V7fduKM9qnz+KqyhDafOX6OGqhCyDS9+QV4IfAI
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 15:07:14.2769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7f8bb2-e555-44a4-2393-08debccacd1c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000042.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10242
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

Add resource-group probing for the arbitration device, including MMIO
resources, IRQ handling, per-AW AM message helpers, handshake
negotiation, and retry work for deferred outgoing messages.

Hook resource groups into arbitration init, teardown, and runtime PM.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/arbitration/Makefile  |   3 +-
 .../panthor/arbitration/panthor_arbitration.h |   5 +
 .../arbitration/panthor_arbitration_drv.c     |  17 ++
 .../arbitration/panthor_resource_group.c      | 288 ++++++++++++++++++
 .../arbitration/panthor_resource_group.h      |  20 ++
 5 files changed, 332 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c
 create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_resource_group.h

diff --git a/drivers/gpu/drm/panthor/arbitration/Makefile b/drivers/gpu/drm/panthor/arbitration/Makefile
index 5d5b2b8d84bc..0ea5b70d524a 100644
--- a/drivers/gpu/drm/panthor/arbitration/Makefile
+++ b/drivers/gpu/drm/panthor/arbitration/Makefile
@@ -4,7 +4,8 @@
 obj-$(CONFIG_DRM_PANTHOR_ARBITRATION) += panthor_arbitration.o
 panthor_arbitration-y := \
 	panthor_arbitration_drv.o \
-	panthor_partition_control.o
+	panthor_partition_control.o \
+	panthor_resource_group.o
 
 INCLUDES = \
 	-I$(src)/..
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
index 5e35ae8463c4..38c8f8674a02 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
@@ -6,8 +6,10 @@
 
 struct device;
 struct panthor_partition_control;
+struct panthor_resource_group;
 
 #define AM_ARB_MAX_PC_COUNT			1
+#define AM_ARB_MAX_RG_COUNT			1
 #define AM_ARB_MAX_AW_COUNT			16
 
 /**
@@ -19,6 +21,9 @@ struct panthor_arbitration {
 
 	/** @pc: Pointer array to partition control data */
 	struct panthor_partition_control *pc[AM_ARB_MAX_PC_COUNT];
+
+	/** @rg: Pointer array to resource group data */
+	struct panthor_resource_group *rg[AM_ARB_MAX_RG_COUNT];
 };
 
 #endif
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
index 07a566168e6a..ac395b89b483 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
@@ -10,6 +10,7 @@
 
 #include "panthor_arbitration.h"
 #include "panthor_partition_control.h"
+#include "panthor_resource_group.h"
 
 #define PANTHOR_PM_AUTOSUSPEND_DELAY_MS 100
 
@@ -22,6 +23,10 @@ static int panthor_arbitration_runtime_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
+	ret = panthor_resource_group_suspend(adev);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -30,6 +35,10 @@ static int panthor_arbitration_runtime_resume(struct device *dev)
 	struct panthor_arbitration *adev = dev_get_drvdata(dev);
 	int ret = 0;
 
+	ret = panthor_resource_group_resume(adev);
+	if (ret)
+		return ret;
+
 	ret = panthor_partition_control_resume(adev);
 	if (ret)
 		return ret;
@@ -66,6 +75,10 @@ static int panthor_arbitration_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_out;
 
+	ret = panthor_resource_group_init(adev);
+	if (ret)
+		goto err_term_partition;
+
 	pm_runtime_set_autosuspend_delay(dev, PANTHOR_PM_AUTOSUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(dev);
 
@@ -73,6 +86,9 @@ static int panthor_arbitration_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_term_partition:
+	panthor_partition_control_term(adev);
+
 err_out:
 	pm_runtime_put_noidle(dev);
 	return ret;
@@ -90,6 +106,7 @@ static void panthor_arbitration_remove(struct platform_device *pdev)
 	if (ret < 0)
 		goto out_suspended;
 
+	panthor_resource_group_term(adev);
 	panthor_partition_control_term(adev);
 
 	pm_runtime_put_noidle(adev->dev);
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c b/drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c
new file mode 100644
index 000000000000..cd1ad0532766
--- /dev/null
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c
@@ -0,0 +1,288 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#include <linux/iopoll.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+
+#include "panthor_am_msg.h"
+#include "panthor_arbitration.h"
+#include "panthor_device_io.h"
+#include "panthor_resource_group.h"
+
+#define AM_RG_IRQ_RAWSTAT			0x80
+#define AM_RG_IRQ_CLEAR				0x84
+#define AM_RG_IRQ_MASK				0x88
+#define AM_RG_IRQ_STATUS			0x8C
+#define   AM_RG_MESSAGE_MASK			GENMASK(15, 0)
+
+#define AM_RG_AW_MESSAGE(n)			(0x100 + (n) * 0x20)
+
+struct rg_aw_data {
+	/** @msg: Messaging data */
+	struct panthor_am_msg msg;
+};
+
+struct panthor_resource_group {
+	/** @dev: Device pointer */
+	struct device *dev;
+
+	/** @name: Resource name */
+	char *name;
+
+	/** @iomem: CPU mapping of the partition control IOMEM region */
+	void __iomem *iomem;
+
+	/** @irq: IRQ number */
+	int irq;
+
+	/** @aw_data: Data for each access window */
+	struct rg_aw_data aw_data[AM_ARB_MAX_AW_COUNT];
+
+	/** @wq: Resource group workqueue */
+	struct workqueue_struct *wq;
+
+	/** @msg_retry_work: Work to retry sending pending messages */
+	struct work_struct msg_retry_work;
+};
+
+static void rg_retry_messages(struct work_struct *work)
+{
+	struct panthor_resource_group *rg = container_of(
+		work, struct panthor_resource_group, msg_retry_work);
+	bool retry = false;
+
+	for (u8 aw_id = 0; aw_id < AM_ARB_MAX_AW_COUNT; aw_id++) {
+		struct panthor_am_msg *msg = &rg->aw_data[aw_id].msg;
+		int ret;
+
+		ret = panthor_am_msg_retry(msg);
+		if (ret == -EBUSY || ret == -EAGAIN)
+			retry = true;
+
+		if (ret == -EINVAL)
+			dev_warn(rg->dev, "AW%u send FIFO unexpectedy empty", aw_id);
+	}
+
+	if (retry)
+		queue_work(rg->wq, &rg->msg_retry_work);
+}
+
+static void rg_send_msg(struct panthor_resource_group *rg, u8 aw_id,
+			u64 message)
+{
+	int ret;
+
+	ret = panthor_am_msg_send(&rg->aw_data[aw_id].msg, message);
+	if (ret == -ENOMEM)
+		dev_err(rg->dev, "AW%u send FIFO is full", aw_id);
+
+	if (ret == -EBUSY) {
+		dev_dbg(rg->dev, "AW%u has pending messages, scheduling retry work", aw_id);
+		queue_work(rg->wq, &rg->msg_retry_work);
+	}
+}
+
+static void rg_respond_to_handshake(struct panthor_resource_group *rg,
+				    u8 aw_id, u64 message)
+{
+	struct rg_aw_data *aw_data = &rg->aw_data[aw_id];
+	bool acked = AM_MSG_ACK_GET(message);
+	u8 version = AM_MSG_VERSION_GET(message);
+	int ret;
+
+	ret = panthor_am_msg_version_validate(&aw_data->msg, version);
+	if (ret == -EOPNOTSUPP)
+		dev_warn(rg->dev,
+			 "AW%u protocol version less than minimum supported (%u < %u)",
+			 aw_id, version, AM_MSG_MIN_SUPPORTED_VERSION);
+
+	if (!acked) {
+		/* AW initiated the handshake, reply with supported version */
+		u64 reply = ARB_VM_INIT_MAKE(1, aw_data->msg.version);
+
+		rg_send_msg(rg, aw_id, reply);
+	}
+}
+
+static void rg_handshake_init(struct panthor_resource_group *rg)
+{
+	for (u8 aw_id = 0; aw_id < AM_ARB_MAX_AW_COUNT; aw_id++) {
+		u64 message = ARB_VM_INIT_MAKE(0, AM_MSG_CURRENT_VERSION);
+
+		rg_send_msg(rg, aw_id, message);
+	}
+}
+
+static void rg_handle_message(struct panthor_resource_group *rg, u8 aw_id,
+			      u64 message)
+{
+	u8 msg_id = AM_MSG_ID_GET(message);
+	if (!msg_id)
+		return;
+
+	switch (msg_id) {
+	case VM_ARB_INIT:
+		rg_respond_to_handshake(rg, aw_id, message);
+		break;
+	case VM_ARB_GPU_REQUEST:
+		/* TODO: on_request */
+		break;
+	case VM_ARB_GPU_STOPPED:
+		/* TODO: on_idle */
+		break;
+	default:
+		dev_warn(rg->dev, "Invalid message (0x%llx)", message);
+		break;
+	}
+}
+
+static irqreturn_t rg_irq_raw_handler(int irq, void *data)
+{
+	struct panthor_resource_group *rg = data;
+	unsigned long message_mask;
+	u32 status;
+	u8 aw_id;
+
+	status = gpu_read(rg->iomem, AM_RG_IRQ_STATUS);
+	if (!status)
+		return IRQ_NONE;
+
+	message_mask = status;
+	for_each_set_bit(aw_id, &message_mask, AM_ARB_MAX_AW_COUNT) {
+		u64 message = panthor_am_msg_read(&rg->aw_data[aw_id].msg);
+
+		rg_handle_message(rg, aw_id, message);
+	}
+
+	gpu_write(rg->iomem, AM_RG_IRQ_CLEAR, status);
+
+	return IRQ_HANDLED;
+}
+
+static void rg_irq_suspend(struct panthor_resource_group *rg)
+{
+	gpu_write(rg->iomem, AM_RG_IRQ_MASK, 0);
+}
+
+static void rg_irq_resume(struct panthor_resource_group *rg)
+{
+	gpu_write(rg->iomem, AM_RG_IRQ_MASK, AM_RG_MESSAGE_MASK);
+}
+
+int panthor_resource_group_suspend(struct panthor_arbitration *adev)
+{
+	for (int i = 0; i < AM_ARB_MAX_RG_COUNT; i++) {
+		struct panthor_resource_group *rg = adev->rg[i];
+
+		if (!rg)
+			continue;
+
+		rg_irq_suspend(rg);
+	}
+
+	return 0;
+}
+
+int panthor_resource_group_resume(struct panthor_arbitration *adev)
+{
+	for (int i = 0; i < AM_ARB_MAX_RG_COUNT; i++) {
+		struct panthor_resource_group *rg = adev->rg[i];
+
+		if (!rg)
+			continue;
+
+		rg_irq_resume(rg);
+	}
+
+	return 0;
+}
+
+void panthor_resource_group_term(struct panthor_arbitration *adev)
+{
+	for (int i = 0; i < AM_ARB_MAX_RG_COUNT; i++) {
+		struct panthor_resource_group *rg = adev->rg[i];
+
+		if (!rg)
+			continue;
+
+		disable_work_sync(&rg->msg_retry_work);
+		rg_irq_suspend(rg);
+	}
+}
+
+static int resource_group_init(struct panthor_arbitration *adev, int i)
+{
+	struct device *dev = adev->dev;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct panthor_resource_group *rg;
+	struct resource *res;
+	void __iomem *iomem;
+	char *name;
+	int ret = 0;
+	int irq;
+
+	name = devm_kasprintf(dev, GFP_KERNEL, "rg%d", i);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
+	if (!res) {
+		devm_kfree(dev, name);
+		return -ENODEV;
+	}
+
+	iomem = devm_ioremap_resource(dev, res);
+	if (IS_ERR(iomem)) {
+		dev_err(dev, "%s: Failed to ioremap", name);
+		return PTR_ERR(iomem);
+	}
+
+	rg = devm_kzalloc(dev, sizeof(*rg), GFP_KERNEL);
+	if (!rg)
+		return -ENOMEM;
+
+	rg->dev = dev;
+	rg->iomem = iomem;
+
+	rg->wq = devm_alloc_ordered_workqueue(dev, "panthor-%s-wq", 0, name);
+	if (!rg->wq)
+		return -ENOMEM;
+
+	INIT_WORK(&rg->msg_retry_work, rg_retry_messages);
+
+	for (int i = 0; i < AM_ARB_MAX_AW_COUNT; i++)
+		panthor_am_msg_init(&rg->aw_data[i].msg,
+				    rg->iomem + AM_RG_AW_MESSAGE(i));
+
+	adev->rg[i] = rg;
+
+	irq = platform_get_irq_byname(pdev, name);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_irq(
+		dev, irq, rg_irq_raw_handler, IRQF_SHARED,
+		devm_kasprintf(dev, GFP_KERNEL, "panthor-%s-irq", name), rg);
+	if (ret)
+		return ret;
+
+	rg_irq_resume(rg);
+
+	rg_handshake_init(rg);
+
+	return 0;
+}
+
+int panthor_resource_group_init(struct panthor_arbitration *adev)
+{
+	for (int i = 0; i < AM_ARB_MAX_RG_COUNT; i++) {
+		int ret = resource_group_init(adev, i);
+		if (ret == -ENODEV)
+			continue;
+
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_resource_group.h b/drivers/gpu/drm/panthor/arbitration/panthor_resource_group.h
new file mode 100644
index 000000000000..b8633abdd8eb
--- /dev/null
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_resource_group.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#ifndef __PANTHOR_RESOURCE_GROUP_H__
+#define __PANTHOR_RESOURCE_GROUP_H__
+
+#include <linux/types.h>
+
+struct device;
+struct panthor_arbitration;
+
+int panthor_resource_group_init(struct panthor_arbitration *adev);
+
+void panthor_resource_group_term(struct panthor_arbitration *adev);
+
+int panthor_resource_group_suspend(struct panthor_arbitration *adev);
+
+int panthor_resource_group_resume(struct panthor_arbitration *adev);
+
+#endif
-- 
2.43.0

