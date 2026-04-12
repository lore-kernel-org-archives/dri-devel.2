Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABBE4E937E5
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 14:31:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 585CB10E2CB;
	Sun, 12 Apr 2026 14:31:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="RD1ut4oC";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RD1ut4oC";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012042.outbound.protection.outlook.com [52.101.66.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F01710E2CB
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 14:31:17 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=mUOd9uVEGlVRRBBGt5yc2JkrmXSrodbHENvZiwX7OwsVe5P0uG9w79GsjNevYF+uquL8boco9XwU4vg2R6xcafBfTWHauyGQOFIm69JAYYR1PYPZ/wj6n/eGSvcyfVraFtG7zBM06Cx9n4P1L9MawbN8aeSqvXReAW/K76Poq6SiA+E3XJoz90zSY9/9K+AFV2sOxKEDcJkIHwnJKKz7uxHn5URBufYExqCsf1YbktpNMWspZ5iIASsWWac7nfY3m8yssDQoeILNbJwm8VuLVIYG7cyBnMB01XUewULldpuBQmE/Y4NKy1Gf0BGTa1zodk6JvKsMfJICFvDRo53lkA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drMwdcSc1hmNLbMkYOsCSgIv7xGW8Zg7mide7eikJZk=;
 b=X+GbRH4hNGsKyvxDEaDluBo//9xhN5X0t8yoXANilFiYXryDefaiwn4yws3K5Sa+a1uaAWFzUk6IQK8aVoNLoF7ptT0kueUUQVllcyBxyxtVbvBLqmOXttaXkDLZMAOK7KiVUctVHlYtzf4ow6b/F+aS/C4T0HudqKi689wM1WvMHDw3qoMI34TjMi5qxoZ8/hD4I53Izj7wcx+JGiPgCLhGivgssXqphBJeMkz5aeH9eWxvv8kf+RIXDGRhww//fat1KfV71MQLUg0A8lfB0QVuYYnJW2+7gki1z5Q1TqGiBGneID9V9d8torxvcU5L6fwXPgf8PKIQNLeVGVv7iQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drMwdcSc1hmNLbMkYOsCSgIv7xGW8Zg7mide7eikJZk=;
 b=RD1ut4oCg0i18K61zg9+uCF49z+G+UFFbt1+X7F6/X03LKClzh0eAhFcUVq6pz5AjXsnAcIEdGsWQuzEnywaNzg5EQ+6x2hPi84OwwIi2Z/qBshRZ41EnH+J5YfAUMQwjuYRU4AJOVg+C4EebY9sWturMoI0s0sKoyInRbrNGAU=
Received: from DU6P191CA0040.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::15)
 by GV2PR08MB8390.eurprd08.prod.outlook.com (2603:10a6:150:bc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.46; Sun, 12 Apr
 2026 14:31:12 +0000
Received: from DB5PEPF00014B9F.eurprd02.prod.outlook.com
 (2603:10a6:10:53f:cafe::9d) by DU6P191CA0040.outlook.office365.com
 (2603:10a6:10:53f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Sun,
 12 Apr 2026 14:31:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B9F.mail.protection.outlook.com (10.167.8.169) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Sun, 12 Apr 2026 14:31:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jER4qbo0QWuf8OABeGGQJNEGHsjhPBKWTzpfTkM641Sw++HJI6atF9Kt9mju5i+Vt6DvFgJ0O6/0S/HaU8KEvlD7Qhblw+tmtl2ncjNfYIuOGYDIpPBNvOn64UjxJNB0qmlyOIkjW9wp3wUW0MGsccOkpTCgw+xVSCqXy2HCe7y3InvnDplk59gwG2vmrnOT0ZT2LSnQYTcjuZ+6U+vy5EPD+i2auulkKo5Q6hi9sS/e5f9U+BZ/xGCfBS/b2ImeKcpOZKjqRDx5U900P2Mk9LLk//BVBwk9F8BUvffO5OVsTuUOIvmFrJ0DBB6XpCo3tcU4J5HPP532msJmohImhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drMwdcSc1hmNLbMkYOsCSgIv7xGW8Zg7mide7eikJZk=;
 b=KKwcGQ14kGAd0YJYt9v7P2DUaKIlkutt5KCUGpstyLI2UMTtibBof1sX29S6HZBslmHsXx8UZhWRlwU3Q4fLlD8VHEzyjaiC/KYVE204UmVoIdnLVFLxTxOeYMNgxGdOyPhL9ku5gTIdM0ZJzbb/w1FON9qfKVqH+gxcbgngCrl7EEgFfOR+5gZn2EGlp21BhVJmusFMQtXMtHrZI8BRbyrAhBV2ozPs+26EYQCauWDClz5/ay88bq/cCLIivtogVvpMYkCxlzl329HTeOJ8MM2c2SPBh5rMGqT40Fj8CNaErLLC3Z1Ns7UILoquFpFOBAqM/Zavr9fG6o55hnZUWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drMwdcSc1hmNLbMkYOsCSgIv7xGW8Zg7mide7eikJZk=;
 b=RD1ut4oCg0i18K61zg9+uCF49z+G+UFFbt1+X7F6/X03LKClzh0eAhFcUVq6pz5AjXsnAcIEdGsWQuzEnywaNzg5EQ+6x2hPi84OwwIi2Z/qBshRZ41EnH+J5YfAUMQwjuYRU4AJOVg+C4EebY9sWturMoI0s0sKoyInRbrNGAU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DB9PR08MB6556.eurprd08.prod.outlook.com
 (2603:10a6:10:261::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Sun, 12 Apr
 2026 14:30:09 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%6]) with mapi id 15.20.9769.046; Sun, 12 Apr 2026
 14:30:09 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] drm/panthor: Use a local iomem base for MMU AS
 registers
Date: Sun, 12 Apr 2026 15:29:51 +0100
Message-ID: <20260412142951.2309135-9-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260412142951.2309135-1-karunika.choo@arm.com>
References: <20260412142951.2309135-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0227.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:372::14) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DB9PR08MB6556:EE_|DB5PEPF00014B9F:EE_|GV2PR08MB8390:EE_
X-MS-Office365-Filtering-Correlation-Id: 519622dd-b07e-4035-da25-08de98a024dd
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info-Original: k/hwxwMVquSPNUCF6VGrwlAT31yRj1v81Rgu1whGSDkLLjFoX0khv5bAnTJ378KzzUDIunagztjUOJIatNF2xsjLow5tRn4snn1yXUp72WVxP3+/Y3GQw9pesZZyx4w/I3h1amyS2/qClgBDuHmj2kU+9yKqBU98GPvm11neUBOvb5PbB0CPJpEF5wfrOTBVr/rOphNFD4EnRHByWrBB05K7lExNcb7eWqyStmCQQ1x2ZF1WYhGVp1GXGXgYRJYNfsny+uYXZARvqy+V7DHM0ARpNgSuCPq4QqQZ/wt0Ly2CmQmX0YI3JL5xY4O172bSYdNtnb/MuVadkbKUn19NB31vVNs5rkfSWWb+txwuGX4EMkdjZkcUenfntqowuGRyc31uAwrDA/NLod9+WRKo75QigdBc1VPfjyni9X8uDx7XcT7nfmui2CL3GA/LNq5gaJzd+os3VnEhAUpGFad7A8ekEquDwpWQIjDqQq8XB7yf1nFtBbJhLZQV08r44HAAZiih2a+5vBr+rHtSXTGZa2FHHSapfka2vFmG3azfbgDu5vCdkRz9pbfVkZZsYgklHVDbvNVzgAyW4Qujv1kPHkGLVzWhWfdz+m6agFj7uO9TeP24EmBJVzzvrxWcnL/6w7myZHqkN+xt3BrjTy8nX3R80VQksJCgRMO1h1t6wRMRfZQSMgy0j+fR+CYmLlO6NlfMXnvhRkuYnSBS+JECtI3LqVfdKL/TCcFD86BLoJo=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: CXZtWyOqofXdsdzYnZI5eIQspCCznUrYH2m2cneWOq1Gb51Bw8fGrVyWwnjRc7DwT1GnJemfjuZtZkPxDvveyodUvvPXpDT931KvslkgoSPEbwKe6sc2aBwBUq/p14vRnAeydAV2J7z5qOOnOQygnYWUvztA2Mr0Qi4/yY+RFfy1L34tDx4RdMS7ZNA2PdzLr7ysEuPMCiXWjw//QBf2up/EWQpdiUoKDj6Dz9aLeyd8JTSVgUitJR98WVaxjjsYcxrKfVRTgG9uXXIf+V15kK8b6LApnSc3C95JGcTGErGfy/aAGE6xsekD4myZ1y2vmADCbGgPvamxQCHjbSOk5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6556
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5PEPF00014B9F.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0b664c8f-4129-4062-80f7-08de989fff9e
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|35042699022|82310400026|1800799024|376014|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 4ZUup/+8twUmh1fpcwHnB3kLSKhVELac9nwiCW3pBCTtNFKf6PvLAuy214iUCjt+NJK06TOJwcB5WxeTHRVW09mzPvrpSkt0QVjHD4xbtp70tuLqdgUmckl6jYOq0xGwooC9vKltfh9ws9XkS+pnLLvquK/crFrCpb8qGZMabyXSGPvZy5G+nom+BWO9hCg0bjAZBykCIifg2Yfs5ycWNIgj6ys0fgWobzY37G6C/FKRiR1atI3+sRdcg+h7HnYVGvvFWqUf927GFzQ2hYdg6C93bRdXU52YAguwWM7Pyh/TV9Sbf9J13eLM6uNS8pqjfVVG+eM61dfSEFwQr17MoGHGFnnBKlbOuE2Xr4rMB36jbp8N7vBk4RfiZ3JqTwFCddR8DGOnOdBEPEd6zG6nvs4LVpDwgOqaVvzGqv9pPZ2sqS/08W+cHi9WhpwYI5MocwqLAXReR07rs02sRNb0Khxh+oD/sIdO91RFYrnVHfz4matXRorBwYKNZXJTs+7ULrusPUi5waXzrdinOP4GWMokUC7R3zNfUOWlvYGx6S7kLipay5yCxCs1c2Eg7axUS2xlA3ymunXKlWNUW7qV7F1kAAe8Cr2fBHg89aytzSMrLxzFcTtRtvFfVZM4nHZlgRE2KJchxXhic8A0PyykDVZ8q6xlDMN52iOKaMvStcWNcSZ+AyRqeXPYeXjr/1vkKmaDZA4ZERJz9LaIiK7Yeqz91WZbuFP+7zRTaLZ+G2vMWkZoJ9s3N9ZAfgcHxb6LRpDDObhr8YmPcUUjKb6F4A==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(35042699022)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: C7eosb8gRLx7HgBpQIyxoqIkpdHiBjdejmfFGIrAztq1u0s/do0LVrNtiD3uOLTFa9/NJXQdTo6zpiWsIysUTzNodymdxdXy3e9wNFwTxcAaNQtQJaFo/q9BqCKM6XmmTLz935ckvnhI+k3+vPXoDQhHGEioWxE6d72N7k8RECWCrQBYsf67YVqWMu7yJYvYyL/jeqVCHe/ZVaBz0kzcIBLS4sFuYnkLQ3ioNHtZ2XgQbWCYoozawkeRa1TSsu1v7hex1FgKJ+S/wMlfSBNstmoiiCEmEa7JL2Iaq7VRbYOwWhmIhG9197LatefKzY5Vr2NM4OaAVy8jFhsU0oEuzHHlZVGNL2MtPKET5bL2IatFw7xKHhXwPniIaroNt7Sr2AV4F3ksCdbvUAwdmWtcz9t4XgxQuahbxgN/2vaKGIYEyO+grcOJBFWRnT/RIDKc
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2026 14:31:11.2771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 519622dd-b07e-4035-da25-08de98a024dd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8390
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

Add an MMU_AS_CONTROL local iomem pointer to struct panthor_mmu and
switch AS register accesses to that base.

Interrupt accesses remain routed through the IRQ-local iomem base, while
the MMU register definitions are adjusted so AS registers are expressed
relative to the local MMU AS window. This completes the conversion away
from using the global device mapping for MMU AS register accesses.

No functional change intended.

v2:
- Pick up Ack from Boris.

Acked-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c      | 35 ++++++++++++++--------
 drivers/gpu/drm/panthor/panthor_mmu_regs.h | 10 ++-----
 2 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 501dc0ea3ae7..b2d0d28be2e0 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -55,6 +55,9 @@ struct panthor_as_slot {
  * struct panthor_mmu - MMU related data
  */
 struct panthor_mmu {
+	/** @iomem: CPU mapping of MMU_AS_CONTROL iomem region */
+	void __iomem *iomem;
+
 	/** @irq: The MMU irq. */
 	struct panthor_irq irq;
 
@@ -517,13 +520,14 @@ static void free_pt(void *cookie, void *data, size_t size)
 
 static int wait_ready(struct panthor_device *ptdev, u32 as_nr)
 {
+	struct panthor_mmu *mmu = ptdev->mmu;
 	int ret;
 	u32 val;
 
 	/* Wait for the MMU status to indicate there is no active command, in
 	 * case one is pending.
 	 */
-	ret = gpu_read_relaxed_poll_timeout_atomic(ptdev->iomem, AS_STATUS(as_nr), val,
+	ret = gpu_read_relaxed_poll_timeout_atomic(mmu->iomem, AS_STATUS(as_nr), val,
 						   !(val & AS_STATUS_AS_ACTIVE), 10, 100000);
 
 	if (ret) {
@@ -541,7 +545,7 @@ static int as_send_cmd_and_wait(struct panthor_device *ptdev, u32 as_nr, u32 cmd
 	/* write AS_COMMAND when MMU is ready to accept another command */
 	status = wait_ready(ptdev, as_nr);
 	if (!status) {
-		gpu_write(ptdev->iomem, AS_COMMAND(as_nr), cmd);
+		gpu_write(ptdev->mmu->iomem, AS_COMMAND(as_nr), cmd);
 		status = wait_ready(ptdev, as_nr);
 	}
 
@@ -589,12 +593,14 @@ PANTHOR_IRQ_HANDLER(mmu, panthor_mmu_irq_handler);
 static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 as_nr,
 				 u64 transtab, u64 transcfg, u64 memattr)
 {
+	struct panthor_mmu *mmu = ptdev->mmu;
+
 	panthor_mmu_irq_enable_events(&ptdev->mmu->irq,
 				      panthor_mmu_as_fault_mask(ptdev, as_nr));
 
-	gpu_write64(ptdev->iomem, AS_TRANSTAB(as_nr), transtab);
-	gpu_write64(ptdev->iomem, AS_MEMATTR(as_nr), memattr);
-	gpu_write64(ptdev->iomem, AS_TRANSCFG(as_nr), transcfg);
+	gpu_write64(mmu->iomem, AS_TRANSTAB(as_nr), transtab);
+	gpu_write64(mmu->iomem, AS_MEMATTR(as_nr), memattr);
+	gpu_write64(mmu->iomem, AS_TRANSCFG(as_nr), transcfg);
 
 	return as_send_cmd_and_wait(ptdev, as_nr, AS_COMMAND_UPDATE);
 }
@@ -602,6 +608,7 @@ static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 as_nr,
 static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr,
 				  bool recycle_slot)
 {
+	struct panthor_mmu *mmu = ptdev->mmu;
 	struct panthor_vm *vm = ptdev->mmu->as.slots[as_nr].vm;
 	int ret;
 
@@ -629,9 +636,9 @@ static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr,
 	if (recycle_slot)
 		return 0;
 
-	gpu_write64(ptdev->iomem, AS_TRANSTAB(as_nr), 0);
-	gpu_write64(ptdev->iomem, AS_MEMATTR(as_nr), 0);
-	gpu_write64(ptdev->iomem, AS_TRANSCFG(as_nr), AS_TRANSCFG_ADRMODE_UNMAPPED);
+	gpu_write64(mmu->iomem, AS_TRANSTAB(as_nr), 0);
+	gpu_write64(mmu->iomem, AS_MEMATTR(as_nr), 0);
+	gpu_write64(mmu->iomem, AS_TRANSCFG(as_nr), AS_TRANSCFG_ADRMODE_UNMAPPED);
 
 	return as_send_cmd_and_wait(ptdev, as_nr, AS_COMMAND_UPDATE);
 }
@@ -784,7 +791,7 @@ int panthor_vm_active(struct panthor_vm *vm)
 	 */
 	fault_mask = panthor_mmu_as_fault_mask(ptdev, as);
 	if (ptdev->mmu->as.faulty_mask & fault_mask) {
-		gpu_write(ptdev->iomem, MMU_INT_CLEAR, fault_mask);
+		gpu_write(ptdev->mmu->irq.iomem, INT_CLEAR, fault_mask);
 		ptdev->mmu->as.faulty_mask &= ~fault_mask;
 	}
 
@@ -1712,7 +1719,7 @@ static int panthor_vm_lock_region(struct panthor_vm *vm, u64 start, u64 size)
 	mutex_lock(&ptdev->mmu->as.slots_lock);
 	if (vm->as.id >= 0 && size) {
 		/* Lock the region that needs to be updated */
-		gpu_write64(ptdev->iomem, AS_LOCKADDR(vm->as.id),
+		gpu_write64(ptdev->mmu->iomem, AS_LOCKADDR(vm->as.id),
 			    pack_region_range(ptdev, &start, &size));
 
 		/* If the lock succeeded, update the locked_region info. */
@@ -1761,6 +1768,7 @@ static void panthor_vm_unlock_region(struct panthor_vm *vm)
 
 static void panthor_mmu_irq_handler(struct panthor_device *ptdev, u32 status)
 {
+	struct panthor_mmu *mmu = ptdev->mmu;
 	bool has_unhandled_faults = false;
 
 	status = panthor_mmu_fault_mask(ptdev, status);
@@ -1773,8 +1781,8 @@ static void panthor_mmu_irq_handler(struct panthor_device *ptdev, u32 status)
 		u32 access_type;
 		u32 source_id;
 
-		fault_status = gpu_read(ptdev->iomem, AS_FAULTSTATUS(as));
-		addr = gpu_read64(ptdev->iomem, AS_FAULTADDRESS(as));
+		fault_status = gpu_read(mmu->iomem, AS_FAULTSTATUS(as));
+		addr = gpu_read64(mmu->iomem, AS_FAULTADDRESS(as));
 
 		/* decode the fault status */
 		exception_type = fault_status & 0xFF;
@@ -1805,7 +1813,7 @@ static void panthor_mmu_irq_handler(struct panthor_device *ptdev, u32 status)
 		 * Note that COMPLETED irqs are never cleared, but this is fine
 		 * because they are always masked.
 		 */
-		gpu_write(ptdev->iomem, MMU_INT_CLEAR, mask);
+		gpu_write(mmu->irq.iomem, INT_CLEAR, mask);
 
 		if (ptdev->mmu->as.slots[as].vm)
 			ptdev->mmu->as.slots[as].vm->unhandled_fault = true;
@@ -3222,6 +3230,7 @@ int panthor_mmu_init(struct panthor_device *ptdev)
 	if (ret)
 		return ret;
 
+	mmu->iomem = ptdev->iomem + MMU_AS_BASE;
 	ptdev->mmu = mmu;
 
 	irq = platform_get_irq_byname(to_platform_device(ptdev->base.dev), "mmu");
diff --git a/drivers/gpu/drm/panthor/panthor_mmu_regs.h b/drivers/gpu/drm/panthor/panthor_mmu_regs.h
index de460042651d..4e32ab931949 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_mmu_regs.h
@@ -8,16 +8,12 @@
 
 #define MMU_INT_BASE					0x2000
 
-#define MMU_INT_RAWSTAT					0x2000
-#define MMU_INT_CLEAR					0x2004
-#define MMU_INT_MASK					0x2008
-#define MMU_INT_STAT					0x200c
-
 /* AS_COMMAND register commands */
 
-#define MMU_BASE					0x2400
+#define MMU_AS_BASE					0x2400
+
 #define MMU_AS_SHIFT					6
-#define MMU_AS(as)					(MMU_BASE + ((as) << MMU_AS_SHIFT))
+#define MMU_AS(as)					((as) << MMU_AS_SHIFT)
 
 #define AS_TRANSTAB(as)					(MMU_AS(as) + 0x0)
 #define AS_MEMATTR(as)					(MMU_AS(as) + 0x8)
-- 
2.43.0

