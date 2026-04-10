Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C6CF459F9
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 16:48:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9111410E9C1;
	Fri, 10 Apr 2026 16:48:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="o6RIitUl";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="o6RIitUl";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013021.outbound.protection.outlook.com
 [40.107.162.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFDD110E9BD
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 16:48:06 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=k6DaKOCz3SpzABRN06xteO9ZZEcfoW+Ps6Jv/Au/KKcgBJmejqCBArMZwHLmXsiA720vUhju5ak0oH2+utG5jjYJZILSVMJoNHel25AFcuYsLtV1rZUtvMJpy8xiaTIx3Us0XJ5j2lJsTN8v1+rL3CvKakn73DSYTozUPInCv8+f9UytS0pfoUV5Jh6pmiPqkgqMlBKYt/JFNZ4eCjQyffOcgq4OevXR+0chMdrcnEECPxHAx1xL4XfScBbCvgaPC4lH9gqx1OVy8fmm6ZJTHL7Ix5ASO2m3CXOM7PbJvEjY69AFVmy9c1x2fxblsELQYfy4dP16kAHGuFet7fxgJQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//HhOCsBUAv83Shtkht7qz9fclG4rEjj8Hv/WhRyewg=;
 b=bBSCYGumtqhRqfKX8WXTGgiUEXnOGsnIOZN9vqtUOmA0gRsYlKN+ttJJwUKPZAq2HWz4D+JTJ42Gm4+PFBPdLYB//0zvj+nyQH08LtaG8gcFpr5/Qz5Qixc0k0yvTfTw1GdNLGwL3DHF+29UpmwnLb7954TdssLpvmBPKI5A6zqowOCNFVpSSo8eoK8iszDYLmeqAY5fMaYHVumPA7dO/Plwds8lr1vRzceXqbzTdYQC3elMi9mnSAbE7KXBOa1W9+zmwXwnk/B9HbCKnAON3kmBY0zFQSYShRJkq/3q9TofDoKO9JoKw8Nph2bKpK7vYNyHjSGC+TH45DZLBmF5XQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//HhOCsBUAv83Shtkht7qz9fclG4rEjj8Hv/WhRyewg=;
 b=o6RIitUl+tbJnOL316ejfTETzYhk0dqIXyycHJYRyI/EmX9S+3bRw6VjDbRzEZy1VEmrzx+rgpR/EwZ8gTe4qBhKd4WF1GLhTjZcuycA2F6KoHoy3G8eUwHVtOlS3RK9w2CPyvhystYGskCykOx/ArFL/H4zbbxcVnK8x611LFo=
Received: from DUZP191CA0045.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::12)
 by AS8PR08MB8039.eurprd08.prod.outlook.com (2603:10a6:20b:549::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Fri, 10 Apr
 2026 16:47:57 +0000
Received: from DB1PEPF000509FB.eurprd03.prod.outlook.com
 (2603:10a6:10:4f8:cafe::55) by DUZP191CA0045.outlook.office365.com
 (2603:10a6:10:4f8::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.43 via Frontend Transport; Fri,
 10 Apr 2026 16:47:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509FB.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Fri, 10 Apr 2026 16:47:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EDCo/sbjxrL95THA1VDg2ZwlwwBRV1HD3t7J6VbjVh8G87hTmt2i96+s6pIEEYIrGhLeymmi3g2xFLZmCpFeXG8JNJvkyVsP2ox2nron/cSqz2nGARlmE1oTjkLzQ42/pdxoOZD2aOOPi7VxEFZmo8Tfovwhw6j9RiYBeY5Cxlg35NUfmjb+29YRGvsEK16Q9YGjrgazGRVIpvh7Ib7z6oaRT7xOC4zE6KqGV1WXAfOFxQL2cJBsjZ/3pRCjY2N338/nL5/mIqEbjqMt5+u8ae4bPcJSV1GajssUtHvGxgLwQK1Nph5LivxK1lLTOYk7RmDOBmAD6b/gyPpzgnYFNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//HhOCsBUAv83Shtkht7qz9fclG4rEjj8Hv/WhRyewg=;
 b=uixih+aotcdjYUUIjDgSKDwVu5QDy3RE2BfgkZ8XjpMr4yUD08gWmmjkjYHkhhrCU9am1ZzEyfMM777p8Yz+k1stv4kjb8uDI+BGm4BYN/naKZfu75nG/oOv9byXwjM5wqqIM4jCaE7VXvA4+VAcmAdD9IIydE3h1/SE/mRz3VGllTy+JjSXBrEO5CnzNaTl6ltip9FCPPQOWINemCaZ8itItPZAoplkUfiVT58hnrk7ZSr1QFo+ByewYswtqljPICmbtYoQxvxBu+tK58Ti6WS6nMll6KbPP+8Fyf0VL+E6QVBxkiHAAztji6L7TomWwAKWowChNHkoixLRHraONg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//HhOCsBUAv83Shtkht7qz9fclG4rEjj8Hv/WhRyewg=;
 b=o6RIitUl+tbJnOL316ejfTETzYhk0dqIXyycHJYRyI/EmX9S+3bRw6VjDbRzEZy1VEmrzx+rgpR/EwZ8gTe4qBhKd4WF1GLhTjZcuycA2F6KoHoy3G8eUwHVtOlS3RK9w2CPyvhystYGskCykOx/ArFL/H4zbbxcVnK8x611LFo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by AS8PR08MB10172.eurprd08.prod.outlook.com
 (2603:10a6:20b:628::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.44; Fri, 10 Apr
 2026 16:46:54 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%6]) with mapi id 15.20.9769.016; Fri, 10 Apr 2026
 16:46:54 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] drm/panthor: Use a local iomem base for MMU AS registers
Date: Fri, 10 Apr 2026 17:46:37 +0100
Message-ID: <20260410164637.549145-9-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410164637.549145-1-karunika.choo@arm.com>
References: <20260410164637.549145-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0230.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::6) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|AS8PR08MB10172:EE_|DB1PEPF000509FB:EE_|AS8PR08MB8039:EE_
X-MS-Office365-Filtering-Correlation-Id: 5caf022c-042f-44bc-0e2b-08de9720eb11
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info-Original: RhWewsRTV/B8S4b0aroSIgkTU5zKG6aI2jGPLsb1P8x9RTX7WiV715Ansh2m7KbbQQHeLLw6toJmVkwMyFFkoc/ZI6/4Re/g4GpyoXvwOWPG+INsMM8nuyJPBTtKFNy7aB5UYtfQLPhCf3FtEFd2Xevm/h2ybL25OOWBxFo8GXHktxl3k/ibmStS7flQnFQ18xvzchZdSVhXvmEvtEfrLBZPQ6VN8NbO8l07fqcCNCcG7ZRJR8EIzTW0L0hMNXmndV2HH0lajNd61kaBUZqEhVzFpeoC37rcbf2VXFp4kRezz9vDhaMnC0FAAeeE/GMc8TkzlJ1LgzpGdonyAhmPmtBHFtCWjVCd60GOjRl8Pu4e8nIomxgQGqidKDub1E3S3Ivh1nrWNwMWfCx72MlZYXrQ9QyXP7ik5NevMyFPHWwssVsy9zTIJ6sM06mXN/6lassBLFIgfDmetiTLbj45SqE5uSvl/VztPAVKYL7EzjsGMaD7JN5075hJ/Gh+6sdiD6jgRGo0llX6MDybm4iZfiVN+IRc1GS7LdL347+1K7QCNPyHaeviHButsslhfOk0gRKniVu/oES/lX9ezVssmSJ5Dw0Z90Fa3xQSvFReVPiW9ATWLFmOTg6s/a/EcarNv0gh4lnNkISobfR3lXP6qPvdH9cE+w+X4zyUBLzJ/weCc0OFZhG4GSNqxMnA7aAuX2nu/DAV9xOlYjDSGy0EcRW6rU45poTfLWAKgIVzkpU=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: PBPzTMNlQ5ecVrXUODy6lghjRUn/XFJa0IerxxssZcyhpNSDuXqMN/1iLnAC9vqkKEkUyNHz/ddW9prPoSIzxNJvhGmKBWcYc4vY98yPULh9Q4C2GunyVH7OWrcRwUku76bFd/VMIBXkyAj8E9P91BpHeRx5DxVJV6ggHBjfeaAQkmdfp2Fgxe1Vqrpq+LZ1gi9mZzS3JMvFAZSKLrA+7vC6WuBoorkjHDOidI1+FBsWshEQCsadWK1asOf8WWUdPrJqeOwNtIkjQRftUsBz06sfnJomwQHGxVa5ESOwGvWKzOFWhxT23aclsXAOhrtjDLT+TPhNMukm9X5+e/sUig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10172
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509FB.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: aa5a8338-ff75-4df7-43f5-08de9720c455
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|1800799024|82310400026|376014|36860700016|14060799003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: YfTJoD2tFjcYwn4r9Nk9wv/5CRfEdkIp+AWyj3nL5HAP97BalRspZxR1tdAOsqLn3Et4vOhe0twHKr442zfAF5N2gT/lxt5s0DmRgm48Ryt+PP42o74TrYEdbALXpgvcQAL5QRImiow0A+0SAlw5Eca+UW/FXY70HE12J2YfOVIzh++7Z+QLsRf2w21dAhqnIKdQSHcBF64IagyjFQ0UdVT71ByTCS8gmaKbZ6gJyVfO5UKkjikFacimfUrxYs32xSCLdT2afZ4rAT5szlIZCmUX8pEi9BCg+VBsz0O2eCemkJzIp4Kxhejda1Wl4T0DvJgAhF8ILdSWijoZBGUfPOYM0pU817Lv83DnukpYhXKRdzwpxXMBXkrRjjaL3Q1GB7FYyb3RVXU+jTvSjV7k11f5xNN4yjJydqFTVOSip89WbQedEzxnTf9sxXvRcd13RA2rguH9w6IN+RC/MBc4dqOrcPpI1d1bpqmdR6US3wyrFjM963EPP0SaPjniKxBz2GhtRgNNRmhGQb4o2nfJsnZGuppjaatZ4GI73kd3c5N29pWGPuEOXUjwmwllySy546Bb34Nl6pekq/ymI+WC+CF3UUiA4YgumyqsTVrEj9pDUHS8SSbDJGBVqrNxvrTRyLaDAduqQRc9nToj4ydLv6ECVapEIWcKgVEwRuu7vZ5aa/nDnh/JklfLRhmqPL2C6JYeargv7YPQTHulNyiX7t9wEYMf46Hb/q3kWV1skGX18OwfVcGOEPl42IUI4VyjdSTUoGhwf3/JYEqbrriK1Q==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(1800799024)(82310400026)(376014)(36860700016)(14060799003)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sK3Y2BV4tmMD2fTDbJaJq/BQxAh9p90LDN53JD1uHGcYlNfsqEnIstoXr3+iw7S61ZXA+kL6r4jnEEhqUeFRSiRWsYwLlm9spB+n6oYKczRkcAFNpAmSKKZ/L5e9xLCQm/0LmEg6Ghk1A0r0tugrDKNzYx61xUXM8mSXgAjAHtelv67URXfcD87cUTSExrFz+M3/q9VoeaVgYqgxa6sGbhHwabuP2wRlxT6jSputBY5VQgpJ9kmE5XLmjfp2v2XbQHmFn1eCaamBa4VVqPtI1FPI0mkSc/ccE0+1zodZYN8HKE+h9LZHHiGeUiZ5zgq91w+V8l6SgMhIMA9LOrP9MDzxGnqMmVPp+dTSGQpbQUbCJ93zQSUzabqPMRVYQHx1yCpcUXpX74KKNvcXmkRrog+BxfK/yNVWZDRo6U/r+XamTerBgG4M4u3blw+x70yU
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 16:47:57.0497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5caf022c-042f-44bc-0e2b-08de9720eb11
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509FB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8039
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

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c      | 35 ++++++++++++++--------
 drivers/gpu/drm/panthor/panthor_mmu_regs.h | 10 ++-----
 2 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index b8665e447d95..0767e148369d 100644
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

