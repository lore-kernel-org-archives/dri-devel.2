Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45953CD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 15:07:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9531F10F339;
	Thu, 28 May 2026 15:07:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="boHqnTWR";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="boHqnTWR";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013035.outbound.protection.outlook.com
 [52.101.83.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41BD710F32D
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 15:07:15 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=vxbZ/Y3f1qzMRUjU/CgkQMyNC4FUMYzK6WBE6IRL9Noy/S1zokTQIyXNqtOssnkdQA6R70XumyREivwKcwzs0PLYFj8/RrqeIooY16JW8Und6p2hlHUWXDuamvT9Jn/LAfIKAI1RNVhARhZT25DwvK4Oc5vBue1BqAFJP09ex8SvnCDXVEjYwvFjckEhN3LMbc66Tb65TB5h0pfJnM2Qrc2jZ6jjV2lF9BaXNPck3lmr0bhtzNxJTizVW4IpPN2Qsqx0RIBH8qhB1kScZ8rZECBsZT683+CvGKilX7j4fl3ukoS+Cd5FVFv84gTyl+ycTLx0PYBsbCWjp6Bnv1tvng==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=it8tT5J8c9zU7HbJtk2+sJYs94lgrOvlespGby71dbQ=;
 b=RUdzSS9Wgdusggo1LjDqMKLGEIxeprF1tulZmfNB4X0Q8VdP7wRDac/DI8coCIMtDsk+qDe56KgwBji/OYNWyfTENgRSGBOk2eyIfeZDF+fztHu2A8yUTmTtkSi0tB9eC9hVyuayIGeIrf74hMiUMbv8yPQZUvtKV5PAPmq/9M90j1g1qjUufIlZsJu7TVscuAVZw50Zemq0egmJaDcrzbhc5F/rAjXOQ8lgQM1Em4YJ3K7q4mFim0kuYzFV5YVoHjQk2hJk2E6jrWFAOFgE8moT60pFsqkzKDs1DB7GM1i3Idp1e4TlmT8vkjJLxwf+xSIUyZvSRtLT1L3qttPbLg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=it8tT5J8c9zU7HbJtk2+sJYs94lgrOvlespGby71dbQ=;
 b=boHqnTWRo2z+d5UKKEh8/ysySI8GT67a6buytM37KnAlb7Dwk/ENdr47UbvupNlXAU0l5ZsapF+EHiDzGPWYxSBDy70Onbide/0dYWtqlUinu06HERbm3RYTgIVnYHm9Wi2nTZCWzZsuKY3LulPD0n8GvEkXhhlvRVd+Kr1CFT4=
Received: from DUZPR01CA0155.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::11) by GV1PR08MB10908.eurprd08.prod.outlook.com
 (2603:10a6:150:1f5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Thu, 28 May
 2026 15:07:08 +0000
Received: from DB1PEPF000509F5.eurprd02.prod.outlook.com
 (2603:10a6:10:4bd:cafe::79) by DUZPR01CA0155.outlook.office365.com
 (2603:10a6:10:4bd::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.14 via Frontend Transport; Thu, 28
 May 2026 15:07:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F5.mail.protection.outlook.com (10.167.242.151) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Thu, 28 May 2026 15:07:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JgMt7eblqxEj8VrJJqFxbmfYPH0pSpEdxuwWMIJMwxEY4wj9+J8z/S5kLmg7OL/XcBJE4OAY5rxNu/BMsKG6MCH6fVbztEJrVf0VGXFH/BSuWvzqjr6iEpFp7S1EaQMFcPZEeNZnVYBtJBSVtZ9fcs2VBRX7gtqwL1pXfBuuNuAKVeFuMO5lE0SCZXjOzDeU92LsmhLx8gQXn/dtr5vAnTbcR4mH45/KmtSj0ZG7Y5cMRscBDr2TtB132Wq6CfhWGujWVkjtLwmAw3nZNXf/81rjMr2KJACmOrKo4Uw8wr9PfeaLn2puorbNOgWnjkgM34ujcfHWNSjwsZuN8VhJwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=it8tT5J8c9zU7HbJtk2+sJYs94lgrOvlespGby71dbQ=;
 b=IJLIma9SCKt5Ws/VgMWWtDH2S7tpl5A+GHUuNlRrUXls1ohkEZ/WoV7yvFMAZ41FMiDEKkGJcU4DxCFJ95gTrncb1yTwfusE7kcjpxqshqHGvKc6GQclKjwy25yxmvet4bJje1L668DVmAZRFBVLyi61Jl/9CWd+svGiJNXVX4ovCfvzKzsqlgdJOdtTd8NeZ+awbH37FbGEczed6zfH24kPr71YD/bqMymM7e4+iKPFQvWOr461BVr5WzQVVHCJzz+8vcJApphiy6Pj7qpjoicXeqhJN8vNjNhlagL1OPN3faq4pwnmxwNhmPpEeEdJViHmpDSy1K1X3UNWubprCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=it8tT5J8c9zU7HbJtk2+sJYs94lgrOvlespGby71dbQ=;
 b=boHqnTWRo2z+d5UKKEh8/ysySI8GT67a6buytM37KnAlb7Dwk/ENdr47UbvupNlXAU0l5ZsapF+EHiDzGPWYxSBDy70Onbide/0dYWtqlUinu06HERbm3RYTgIVnYHm9Wi2nTZCWzZsuKY3LulPD0n8GvEkXhhlvRVd+Kr1CFT4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DU2PR08MB10015.eurprd08.prod.outlook.com
 (2603:10a6:10:49f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 15:06:03 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 15:06:01 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 06/18] drm/panthor: Derive MMU AS register addresses from
 base and stride
Date: Thu, 28 May 2026 16:05:34 +0100
Message-ID: <20260528150546.3168527-7-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528150546.3168527-1-karunika.choo@arm.com>
References: <20260528150546.3168527-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0068.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2de::14) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DU2PR08MB10015:EE_|DB1PEPF000509F5:EE_|GV1PR08MB10908:EE_
X-MS-Office365-Filtering-Correlation-Id: 0af7514f-d87c-45f0-bd44-08debccac82b
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original: j4yaiuO7qGpzgrrE/lpwdpBQKXKkh1Pnw/qQBE6YaXI0ApPtlPV8DuT88x4+6NbUlLvVlGol2U9jTf4jwfgnY9rLYLh0NBG57e3kTK1ZPhu8h8ppfZdZElCOWX8mGhr/Kd8JtFazC5NkLU0oShkMqW6CEL6Dw1aroUXs9bdXBsMvB+wWzdY8B1FSGLsYn5pV3jUHDx85FdaYQOom6fFVo7ZF0/33INJAUVZt3aaM4zPjO88Sl+pmneXz5yP8SkLMn9pBCKtiT5XvUZ+EQkacu+rMCKGQIfsOr/TTJlPcq3WKfAXXnhx9vky3se68Kf3eHzddrnJ3xM1LuXSD/zoqcOJKSY3nnBwBSlYO+xJUQZg9Yn0sItm/v+oCsx/SZeYyrx1Xcykc1eJQ5F+KLc7eO3x5+mkZe9cskowtIU3a3ihF1Hu0blqUBMRz0ChhXvixy7+lopdGumQOkvEbmYOgQFr1XBsyq5TGYmmn1mC74QHGPVxCdO8DGs7Ls64aOkzcu86Io0lmFKJ6zVRHO6agtXmuDmxuMh2G4GXK0dwyayrl818J3atoSWF8dfARJYJ9OVzuTq2zsIgc0dNIjYQQ/Fh0nc1sgEuyUgKMlKWDHws9dcbD3bweYJzKv8jTsFym+rY6PV9yGEx1Kif1bITMxISctHJrf1Y3NmesQNtGkEr48BhIrLEENSZcQTOvmfuT
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: nsboRWAtkbiyKi/ZzxcZGyWx9jlr+6R/T1fnMc841nqnDucGEwxXPXaNid5wlkWcZVqMgM5aAAShUSs+KsmbQaXpfuTUUgNN4y6zk5skR573lMbr6/+2EbVPHCtvdQbzS6EuPvH5BVlQCOAUObNytimr3IBWmqfCtcLDK7Sq+PIQWJ24RZ1jip4rbgNd/gJfOK3CBYMAo9QX49x8zbJoS8nyBU8beGr+63Je+JfxKsk9kKMBI5saEweNRMZwrlSPpgIzrlgbz8EbvV5itiEXR8O5gJfetrXaLZm/Jk55HoCYFwZRygtWZ0os4jbilNR/GjmyVYsxrjWWklPjEGS5Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10015
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509F5.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 01de8ad6-4d7e-479e-8a73-08debccaa1b3
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|376014|14060799003|1800799024|82310400026|36860700016|11063799006|3023799007|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZTm3wn40vPxJN1uSCcCavwEfGw6DCb8rSiLAFzwtRslxSrFog7oKDcw32Ouwbxg+LNIgCsu3C1ApTXm6C5tJTYptq2eJMFZeVQIyOFR9TE2E8+hj1Kr48OaUx4i3nw/E4we/Um8oI/y2bPlq1lsREG9l4aQYpOGF712ld8JlBp4pfOKoYlmQwZRrM5p1hvoY//cfOTG/0KmvBMCwwEmrY+8yhA4uAYi4mhMrhgkKbieLzhx0SSjrbwsBX44NbZg+CwBhKU0a0ap0fFwQ0ElJrJMe48tjP0N8Fk4sdN97A7SC26K/b22euaHQKXegjcbyqS30WFUjy7fOWTvv6SGyRbVEltM76yFGgevt40PxAyIcgCHl8PA1SYbd3izgcWg9uI2CQMyulIpgyzYmw+14JoBpmHyf343ymGFXL3HSsSjTJIYs/Iq8V6cxkpNKTXMvsi6Xa45KQm7SpYoW2NNX2A6ELj+59gQoFmxD7Ar7IUscJmyKTgpi/FRW0aRR39CKIzCymXRsMk4A6oowbNvLAGMW+QlaWZksKpFieFCh2VdmV8Q7T6QoOsyQZyrxU0z7pqrfjOeG2ewbgAVqQoXMhhboIdRvQ22AcCl7+4WSlJxKmhI/FpZwfr2pHV49HcrL9KM7Mct/zGLfoSigVxF2q+xoD09X56DWIwppqYr1w+V4qL/NmweEFcA6r2NYDzvnhBCWVOcJs4ZE5rygztjHEGIgQiD6TjA25tlT0T8ZI60=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(376014)(14060799003)(1800799024)(82310400026)(36860700016)(11063799006)(3023799007)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: //aBTQU0SSY3AcrCj3pKI5iECUtuyNCHVvng/5OPm4vWnMofg4io4LIxOPF8rbI4aUWjkyvUzUPApYpZdwDF6o5QnuKRETcc7WoUhW2vHyixm9nb9sIVj8e+FNz34kuvfisZSybU3lp/Z+wcT+J7HJ6w7DzQOcpu2LA4+KzccVp0AYhKgeYvI6UoSoLFhpp7mxN6zFuj1aE24tOKK9toUVGivRoduNCZ84RubtqHve1GFcTVV6UVHpWVNhfDXR2nBuJEPWCJBSGPCho8i4RcDmXdZgGX8dNGfAVNdtH7RLErAS3bMEsPV26jF8zFTAOZ9hj0eLdBfSSRcW8Tt8YXR2YT2IzKirDPvPejCLr16ytYtSyVxjf0pZzvfgRwHL1hjsOHnbidLaAm78QMSxFOIr5Fp99eDqFJqvOfh/dK9h/dKhSyLNn2wzPxV17rVZW5
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 15:07:05.9839 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af7514f-d87c-45f0-bd44-08debccac82b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F5.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10908
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

Move the MMU address-space register layout into the hardware description
by storing the MMU_AS base offset and per-AS stride in the Panthor HW
map.

Use those values to compute the iomem pointer for each AS slot and make
the MMU AS register definitions relative to the per-slot register window
instead of hard-coding the slot offset in every register macro.

This prepares the MMU code for GPUs where the MMU AS register region is
not at a fixed offset while keeping the existing register accesses
scoped to a single AS window.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_hw.c       |  8 +++++
 drivers/gpu/drm/panthor/panthor_hw.h       |  8 +++++
 drivers/gpu/drm/panthor/panthor_mmu.c      | 35 ++++++++++++++--------
 drivers/gpu/drm/panthor/panthor_mmu_regs.h | 23 ++++++--------
 4 files changed, 47 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index 1f7fab4caf4d..e677f1a8f488 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -41,6 +41,10 @@ static struct panthor_hw panthor_hw_arch_v10 = {
 	.map = {
 		.gpu_control_base = 0x0,
 		.mcu_control_base = 0x700,
+		.mmu_as = {
+			.base = 0x2400,
+			.stride = 0x40,
+		},
 	},
 };
 
@@ -54,6 +58,10 @@ static struct panthor_hw panthor_hw_arch_v14 = {
 		.gpu_control_base = 0x0,
 		.pwr_control_base = 0x800,
 		.mcu_control_base = 0x700,
+		.mmu_as = {
+			.base = 0x2400,
+			.stride = 0x40,
+		},
 	},
 };
 
diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
index 58673a427bc9..0ae11b78c77e 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.h
+++ b/drivers/gpu/drm/panthor/panthor_hw.h
@@ -38,6 +38,14 @@ struct panthor_hw_regmap {
 
 	/** @mcu_control_base: MCU_CONTROL base address */
 	u32 mcu_control_base;
+
+	struct {
+		/** @mmu_as.base: MMU_AS base address */
+		u32 base;
+
+		/** @mmu_as.stride: Stride between subsequent MMU_AS register blocks */
+		u32 stride;
+	} mmu_as;
 };
 
 /**
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 48127313332f..9a64f977d28c 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -36,6 +36,7 @@
 #include "panthor_gpu.h"
 #include "panthor_gpu_regs.h"
 #include "panthor_heap.h"
+#include "panthor_hw.h"
 #include "panthor_mmu.h"
 #include "panthor_mmu_regs.h"
 #include "panthor_sched.h"
@@ -57,7 +58,7 @@ struct panthor_as_slot {
  */
 struct panthor_mmu {
 	/** @iomem: CPU mapping of MMU_AS_CONTROL iomem region */
-	void __iomem *iomem;
+	void __iomem *iomem[MAX_AS_SLOTS];
 
 	/** @irq: The MMU irq. */
 	struct panthor_irq irq;
@@ -528,7 +529,7 @@ static int wait_ready(struct panthor_device *ptdev, u32 as_nr)
 	/* Wait for the MMU status to indicate there is no active command, in
 	 * case one is pending.
 	 */
-	ret = gpu_read_relaxed_poll_timeout_atomic(mmu->iomem, AS_STATUS(as_nr), val,
+	ret = gpu_read_relaxed_poll_timeout_atomic(mmu->iomem[as_nr], AS_STATUS, val,
 						   !(val & AS_STATUS_AS_ACTIVE), 10, 100000);
 
 	if (ret) {
@@ -546,7 +547,7 @@ static int as_send_cmd_and_wait(struct panthor_device *ptdev, u32 as_nr, u32 cmd
 	/* write AS_COMMAND when MMU is ready to accept another command */
 	status = wait_ready(ptdev, as_nr);
 	if (!status) {
-		gpu_write(ptdev->mmu->iomem, AS_COMMAND(as_nr), cmd);
+		gpu_write(ptdev->mmu->iomem[as_nr], AS_COMMAND, cmd);
 		status = wait_ready(ptdev, as_nr);
 	}
 
@@ -599,9 +600,9 @@ static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 as_nr,
 	panthor_mmu_irq_enable_events(&ptdev->mmu->irq,
 				      panthor_mmu_as_fault_mask(ptdev, as_nr));
 
-	gpu_write64(mmu->iomem, AS_TRANSTAB(as_nr), transtab);
-	gpu_write64(mmu->iomem, AS_MEMATTR(as_nr), memattr);
-	gpu_write64(mmu->iomem, AS_TRANSCFG(as_nr), transcfg);
+	gpu_write64(mmu->iomem[as_nr], AS_TRANSTAB, transtab);
+	gpu_write64(mmu->iomem[as_nr], AS_MEMATTR, memattr);
+	gpu_write64(mmu->iomem[as_nr], AS_TRANSCFG, transcfg);
 
 	return as_send_cmd_and_wait(ptdev, as_nr, AS_COMMAND_UPDATE);
 }
@@ -637,9 +638,9 @@ static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr,
 	if (recycle_slot)
 		return 0;
 
-	gpu_write64(mmu->iomem, AS_TRANSTAB(as_nr), 0);
-	gpu_write64(mmu->iomem, AS_MEMATTR(as_nr), 0);
-	gpu_write64(mmu->iomem, AS_TRANSCFG(as_nr), AS_TRANSCFG_ADRMODE_UNMAPPED);
+	gpu_write64(mmu->iomem[as_nr], AS_TRANSTAB, 0);
+	gpu_write64(mmu->iomem[as_nr], AS_MEMATTR, 0);
+	gpu_write64(mmu->iomem[as_nr], AS_TRANSCFG, AS_TRANSCFG_ADRMODE_UNMAPPED);
 
 	return as_send_cmd_and_wait(ptdev, as_nr, AS_COMMAND_UPDATE);
 }
@@ -1739,7 +1740,7 @@ static int panthor_vm_lock_region(struct panthor_vm *vm, u64 start, u64 size)
 	mutex_lock(&ptdev->mmu->as.slots_lock);
 	if (vm->as.id >= 0 && size) {
 		/* Lock the region that needs to be updated */
-		gpu_write64(ptdev->mmu->iomem, AS_LOCKADDR(vm->as.id),
+		gpu_write64(ptdev->mmu->iomem[vm->as.id], AS_LOCKADDR,
 			    pack_region_range(ptdev, &start, &size));
 
 		/* If the lock succeeded, update the locked_region info. */
@@ -1801,8 +1802,8 @@ static void panthor_mmu_irq_handler(struct panthor_device *ptdev, u32 status)
 		u32 access_type;
 		u32 source_id;
 
-		fault_status = gpu_read(mmu->iomem, AS_FAULTSTATUS(as));
-		addr = gpu_read64(mmu->iomem, AS_FAULTADDRESS(as));
+		fault_status = gpu_read(mmu->iomem[as], AS_FAULTSTATUS);
+		addr = gpu_read64(mmu->iomem[as], AS_FAULTADDRESS);
 
 		/* decode the fault status */
 		exception_type = fault_status & 0xFF;
@@ -3237,8 +3238,11 @@ static void panthor_mmu_release_wq(struct drm_device *ddev, void *res)
 int panthor_mmu_init(struct panthor_device *ptdev)
 {
 	u32 va_bits = GPU_MMU_FEATURES_VA_BITS(ptdev->gpu_info.mmu_features);
+	unsigned long as_present_mask = ptdev->gpu_info.as_present;
+	struct panthor_hw_regmap *regmap = &ptdev->hw->map;
 	struct panthor_mmu *mmu;
 	int ret, irq;
+	u32 as_id;
 
 	mmu = drmm_kzalloc(&ptdev->base, sizeof(*mmu), GFP_KERNEL);
 	if (!mmu)
@@ -3255,7 +3259,12 @@ int panthor_mmu_init(struct panthor_device *ptdev)
 	if (ret)
 		return ret;
 
-	mmu->iomem = ptdev->iomem + MMU_AS_BASE;
+	for_each_set_bit(as_id, &as_present_mask, MAX_AS_SLOTS) {
+		u64 offset = regmap->mmu_as.base + (regmap->mmu_as.stride * as_id);
+
+		mmu->iomem[as_id] = ptdev->iomem + offset;
+	}
+
 	ptdev->mmu = mmu;
 
 	irq = platform_get_irq_byname(to_platform_device(ptdev->base.dev), "mmu");
diff --git a/drivers/gpu/drm/panthor/panthor_mmu_regs.h b/drivers/gpu/drm/panthor/panthor_mmu_regs.h
index 4e32ab931949..9d3747601e69 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_mmu_regs.h
@@ -10,13 +10,8 @@
 
 /* AS_COMMAND register commands */
 
-#define MMU_AS_BASE					0x2400
-
-#define MMU_AS_SHIFT					6
-#define MMU_AS(as)					((as) << MMU_AS_SHIFT)
-
-#define AS_TRANSTAB(as)					(MMU_AS(as) + 0x0)
-#define AS_MEMATTR(as)					(MMU_AS(as) + 0x8)
+#define AS_TRANSTAB					0x0
+#define AS_MEMATTR					0x8
 #define   AS_MEMATTR_AARCH64_INNER_ALLOC_IMPL		(2 << 2)
 #define   AS_MEMATTR_AARCH64_INNER_ALLOC_EXPL(w, r)	((3 << 2) | \
 							 ((w) ? BIT(0) : 0) | \
@@ -28,8 +23,8 @@
 #define   AS_MEMATTR_AARCH64_INNER_OUTER_NC		(1 << 6)
 #define   AS_MEMATTR_AARCH64_INNER_OUTER_WB		(2 << 6)
 #define   AS_MEMATTR_AARCH64_FAULT			(3 << 6)
-#define AS_LOCKADDR(as)					(MMU_AS(as) + 0x10)
-#define AS_COMMAND(as)					(MMU_AS(as) + 0x18)
+#define AS_LOCKADDR					0x10
+#define AS_COMMAND					0x18
 #define   AS_COMMAND_NOP				0
 #define   AS_COMMAND_UPDATE				1
 #define   AS_COMMAND_LOCK				2
@@ -37,16 +32,16 @@
 #define   AS_COMMAND_FLUSH_PT				4
 #define   AS_COMMAND_FLUSH_MEM				5
 #define   AS_LOCK_REGION_MIN_SIZE			(1ULL << 15)
-#define AS_FAULTSTATUS(as)				(MMU_AS(as) + 0x1C)
+#define AS_FAULTSTATUS					0x1C
 #define  AS_FAULTSTATUS_ACCESS_TYPE_MASK		(0x3 << 8)
 #define  AS_FAULTSTATUS_ACCESS_TYPE_ATOMIC		(0x0 << 8)
 #define  AS_FAULTSTATUS_ACCESS_TYPE_EX			(0x1 << 8)
 #define  AS_FAULTSTATUS_ACCESS_TYPE_READ		(0x2 << 8)
 #define  AS_FAULTSTATUS_ACCESS_TYPE_WRITE		(0x3 << 8)
-#define AS_FAULTADDRESS(as)				(MMU_AS(as) + 0x20)
-#define AS_STATUS(as)					(MMU_AS(as) + 0x28)
+#define AS_FAULTADDRESS					0x20
+#define AS_STATUS					0x28
 #define   AS_STATUS_AS_ACTIVE				BIT(0)
-#define AS_TRANSCFG(as)					(MMU_AS(as) + 0x30)
+#define AS_TRANSCFG					0x30
 #define   AS_TRANSCFG_ADRMODE_UNMAPPED			(1 << 0)
 #define   AS_TRANSCFG_ADRMODE_IDENTITY			(2 << 0)
 #define   AS_TRANSCFG_ADRMODE_AARCH64_4K		(6 << 0)
@@ -64,6 +59,6 @@
 #define   AS_TRANSCFG_DISABLE_AF_FAULT			BIT(34)
 #define   AS_TRANSCFG_WXN				BIT(35)
 #define   AS_TRANSCFG_XREADABLE				BIT(36)
-#define AS_FAULTEXTRA(as)				(MMU_AS(as) + 0x38)
+#define AS_FAULTEXTRA					0x38
 
 #endif /* __PANTHOR_MMU_REGS_H__ */
-- 
2.43.0

