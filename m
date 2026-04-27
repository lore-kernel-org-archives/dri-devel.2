Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3096FF886B
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 16:01:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE18110E805;
	Mon, 27 Apr 2026 16:01:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="jyDRr6A/";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jyDRr6A/";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013007.outbound.protection.outlook.com
 [40.107.162.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6822A10E802
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 16:00:53 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=fZpVFVXiCUKR7JgrzneN4QhtRPDXx31R9GfGWsqTTcx6lwgmX+bR9/TBemZWIHSUSkWv7Hwpqjl9UE0Iz5jg9/HiHcvCp2FbA15mVK1SGg152eLgTUd9EEnYZICgZg7YX5htxv2A1+8YphzWdK/bFB3GqTyTzrtuMLWuUe+Ri7Q/cfDYyyAvZ/uy96eDMlMZDZ1dhUMNAPsUWhlu+7iNBwcfymp3dwpJyuA+YI/KkusLDrVv0s+ClIFfEp5dNH65S+Rmmt2aP1diry6reqbCwfo1ORMfZE2xj6IHZvVHqbSRExjKJp1syOBFYG1JpiJaPyV52jeGcHAGnuM5OcBgjQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOgi+ZJbq/S74xpF8ICNHoTTGD77qD7m5bUIyI6ODpY=;
 b=Ze+pMfRBSlEi7aff9UaYuerCV3XDiu1vBrXIQTfI73INySVC+h818c5QFVMtnfxv0CkNI6Jf1db6t6A5dTmyFLGYKCOLBX/cn0uKJydeTs0IaglKrdSJYrYLnGk3nP/Pklx85AxgBKN0TkhtA8CpV9bDV28hN9uNOQlz7x2yrSDrHjssV0NGgKP/ZKJDLMmK3RPxes1Fo6nVNxS2x08cCXY33qBHpFShs+mY+UbPiMwBipkHDppaL5MA3AmFl5POGs9pAmVX31Nbi8aBB8UElTIjXw+mt/X7KUiLD78Gezd5hW7Zl0WYqUZS4k55WxwfusMKKAI5RiMdvvCv96S7Rw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOgi+ZJbq/S74xpF8ICNHoTTGD77qD7m5bUIyI6ODpY=;
 b=jyDRr6A/toEcr2arju0zlLs2i/71zlMS64QCIijzC3o99J55iLN8+CbPhtFrSmG1jA+sH7kltPV2F/G4YL6CP3PAOjCaEsEfxKmm2A5uWNGrChw6WoZrqa80CHERCqUJLW3IHyqh1PROzCP5uAwAiU12h3fAsM/0g5ui3UqSLa8=
Received: from DUZP191CA0068.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::29)
 by AS8PR08MB8490.eurprd08.prod.outlook.com (2603:10a6:20b:567::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 16:00:46 +0000
Received: from DU6PEPF0000B622.eurprd02.prod.outlook.com
 (2603:10a6:10:4fa:cafe::52) by DUZP191CA0068.outlook.office365.com
 (2603:10a6:10:4fa::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 16:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000B622.mail.protection.outlook.com (10.167.8.139) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Mon, 27 Apr 2026 16:00:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8/zMi8uTp0/vgXQ8d2REv0Q0lSvH1UXb9pjrPIeQDvETSslXmGhE4as/7zLwlTO6a609zu31ght5v/SrRFcY0dA5QD4KhKN8ei7u1g5YsivaxX7OIQx0AMYehlK4vSQfTXKvMu1q3HRsBjEJobHXk/jPiOEfB6KbTed3iJ0N+N6RMpvrWNsHxlhL1+aRtiXDgQG8CzEJ8jJjr2+Ju/C1AdtZAYnK2w8b8e+xO5zpla/46h1xO6sb4RLzh2dd8+rytEOQS+9VxYol2CVr2oGlvc+bbtFM+IddYESg+u8X51cu3FRW0TaJ0WmyUWBCbL0vJ+q32iJxDKoKQMSYKoYGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOgi+ZJbq/S74xpF8ICNHoTTGD77qD7m5bUIyI6ODpY=;
 b=DMw7j+FCiWYFU0RBD//kpAADaU9kKqTVmrKS9iDF+CRby6c87op6TD4rJCQ5fIWRuvl2VNVq8WN9hL5lijxKGOfyabuVhG6v3GFGTNaE1XIB2ILmMLsrKEnVCKqY66DE65EOCaKDvdbcqrcjX9D9bcBtXVdKAIxc+d3ZwVBoT7bAagA3t8gdHi5UzY82O7K7TY8gLvHfTym7it8IWFTgX/6U5zC4VbIEHz3vzUtl01yHdCGHsS/x9ZQ6g6qnFIM3jZbpCcbglw7G4lbqtDyISF5cWVZh28/PoRbKuJ9ZapQLppnjaQcpCFFOR431KazEpdkt/9M0xSvD+Yk/R57m4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOgi+ZJbq/S74xpF8ICNHoTTGD77qD7m5bUIyI6ODpY=;
 b=jyDRr6A/toEcr2arju0zlLs2i/71zlMS64QCIijzC3o99J55iLN8+CbPhtFrSmG1jA+sH7kltPV2F/G4YL6CP3PAOjCaEsEfxKmm2A5uWNGrChw6WoZrqa80CHERCqUJLW3IHyqh1PROzCP5uAwAiU12h3fAsM/0g5ui3UqSLa8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DB9PR08MB7721.eurprd08.prod.outlook.com
 (2603:10a6:10:390::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 15:59:44 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%6]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 15:59:44 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/8] drm/panthor: Split register definitions by components
Date: Mon, 27 Apr 2026 16:59:28 +0100
Message-ID: <20260427155934.416502-3-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427155934.416502-1-karunika.choo@arm.com>
References: <20260427155934.416502-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0089.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::6) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DB9PR08MB7721:EE_|DU6PEPF0000B622:EE_|AS8PR08MB8490:EE_
X-MS-Office365-Filtering-Correlation-Id: b1add4d7-0fd2-4c95-9412-08dea47624d1
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info-Original: FuTI6TOtt348haxXohil2GnIqgcbbXWjsCHIEyRHqW3AxU9Ex880sA79+iRAz+8derxSy5LtYpEQlMJaX4IsQPBCdSZh0PjiWGdvr0mjtjc7hYXGYUHReYlBV1rkIp5lapLYTLo/H9xYWAHlnm2nlivhx0YfxRZHtdoZSLu6c0trTZMOrgjVQtgdp+JGoXXFG728VFIR8MKhdMaBEbnoZe2vIKwc88hzoTJkqcZm/w6JZGsmLB70yab4puPesKsTcf7u1ntGHR3CmNG4gyeIHdgFgSjW6OSOdW/9guwdnSQKRH6vAs2vRnF/VTQaTjCXPfufMZuiKw3na2crl9s2lsv4Pq5ZR4fx7//hamqDO7eLnJ1v6pUbTmMXWKrS9OFPKd2NZriucoOpYWxWllPwvRS9+CTcdwIhlK38w6lsXWZGitEW6R0qBs6s94tULTi8O2zh4gz2sZ2r18n8JQmWgq7jzxDW2v2fY/TADEYfDPZxzuqGCZ/ov1dFLvgMjrSd/UP6So0LR5Of/3aVxHzWlTylKKnMSqpqkwDNE4pgIADdVwnoW+vhWbXcD4EKyTvAX5vxb49MwtzAKbzeSwcpp2ZLVHELN3V8KHWBSrrtPVhAh2wslZbfemrK4yuhkXdVhphcewbHGybur1nPew1oATCzhu+jaDas/Ur3yoSi0crFrA0wYCbmy3GQyKcSK6GZj/okLqsVva5ufYs0y2HKiZTpxwW1cm7lWc6pd+QKRZ8=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: pOcDSVmcgo2joBeIIpHy8qg0/xpbbg9AyAUoJwQ3RWfW5UczMbkiWYYbg3m4ZyCBRW8NshrXWpgz8StyjRBT4H8Olyv0nK8pj5AL3efg0jBhf6UDIAU1mLo4hP6W2kyROej0p9laWT3BuFupw6Vi3zsJD2q9a9lOOhrqfizlKLKYRk0odOboVHsdSf/yzgtSpYfdNcWoZry2LCU01iOBqWVRiTzuImDxBKYUBwzczH0O6DGtbA1KNszxUNdsdJodV+8CAfgf822C0IPQ620EKQM+MslxcWmh83DA5V51dkvrSspKUyTHCfNjiUlKitK8GE3VRfe39JsxUOPC+TJBIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7721
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF0000B622.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f3310a75-cbea-41f0-7530-08dea475ff78
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|14060799003|36860700016|35042699022|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: j/Afpv+CAzpcLh/D2hmxKgMM+WTggEbqdXRo1URfLG7pNo4B3tk1olwZ0icjZ5zrqW7PYK7CW9ewf7ZT+k7fEWUHEm+fn97rGkpNdWDi3vjjfaEcdiUqzJ2OOZr05p+pwoqV0TW96dEN6s6UtolTKru6BL+vbECxMpQ02Lh6BVnd5XqbRHQQETEkGAZ51f8891Fe94IlKOGMd5o2JtE/xdjg3kQ5zbTSVHBMaflGbdQffJFaWjHlfrcMzQ4JU5tey1S+8mnxSQrPT9bin+BNwWrdEIb9nZd8giW+psjpSgpq7hFPIUqBChcIEvgArZO4wO76bktjylX3yjkLaFvI644pYWHa9bBDAdcKGcbBgMlYIGGOrjEqpz+EllkJremk8O0lHZFRLSYgohdimt6O06gSwpErKSZQR2/j+Yhx7pcXiRbbjqVfgz8RtQck5WfWItxClmh1BM6vjYr4Dos51ALzhe/FLHgSnc97qDg5SSE19LRpMXf05ujZSjdtjMexQV7DPKnlUTE1EV6El02mOFGvcST6U+zm5cdlgsRtvIDNzjdWP9B6CEooVMhCDqG5b+DBuO1rq6R84ACjalrvgFAwV4oveCt9Py2fIvRBgj6Z+Ei7Pc1STcanhq7jxqaKv0Z8lYv37j5XLRYKsEOD2jZM3VHWrWnYBrHPZY2QL5MZ+Wj9oht40uFO2F5genKt16HcifPiIbLLYpJTDN8rqT85yn5JVw++QvlOBx0y+E9+Mdk18pah2DOjraK99Iez9rNpvacMJC1tVOji1H7uPg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(14060799003)(36860700016)(35042699022)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OLyEBdXp3B6p68ymqsTTvH1IedVEp4yDqOHw2X/2kuTmrI0LfOme4wwLR1GOmcH4T3igzpV3J7H4B5R4geC0Co2H7G29IGA9gi0rkiURwmxxWEiir+Iwrdip98sePr6XYSXBJqMbldG0NcmdVh2z4d115gdLJO4zGsZ3PynHXeNUYMRGHXaQBShCc4qmz5KTnd9kCTh91/qycZxCdxhlYXS/+ECy5Aqi71hq8o79A/aJK5jx0J4DpeHyDvdwRZXhsOUaxFuBFaFZYN8BirjR44bjEATYMPzfD/pxMqXlSID4vJDVCfHSj0WAfgX3gmhBkhsehqvylZ+SL4exO0V7MrfczHdTvK24S+OuCsJttQP35w8g1xxMNQ+n/sz4wajZiVZldb/M67IeyhxwRl5KIsCcbx20IgqOWdPwpSnXyQaVCBPl+jEKtP3MVVg+ZLJt
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 16:00:46.2787 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1add4d7-0fd2-4c95-9412-08dea47624d1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B622.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8490
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

Split the panthor register definitions into per-component headers for
the GPU, MMU, firmware, power and generic hardware registers.

This makes the register layout easier to follow and prepares the driver
for component-local iomem mappings by grouping definitions with the code
that owns them. The old monolithic panthor_regs.h header can then be
dropped.

No functional change intended.

v3:
- Pick up Ack from Boris and R-bs from Liviu and Steve
v2:
- Merge GPU_ID definitions into panthor_gpu_regs.h
- deleted panthor_hw_regs.h

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Acked-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_device.c   |   3 +-
 drivers/gpu/drm/panthor/panthor_drv.c      |   2 +-
 drivers/gpu/drm/panthor/panthor_fw.c       |   2 +-
 drivers/gpu/drm/panthor/panthor_fw_regs.h  |  30 +++
 drivers/gpu/drm/panthor/panthor_gpu.c      |   2 +-
 drivers/gpu/drm/panthor/panthor_gpu_regs.h | 120 +++++++++
 drivers/gpu/drm/panthor/panthor_heap.c     |   2 +-
 drivers/gpu/drm/panthor/panthor_hw.c       |   3 +-
 drivers/gpu/drm/panthor/panthor_hw.h       |   2 +-
 drivers/gpu/drm/panthor/panthor_mmu.c      |   3 +-
 drivers/gpu/drm/panthor/panthor_mmu_regs.h |  70 +++++
 drivers/gpu/drm/panthor/panthor_pwr.c      |   3 +-
 drivers/gpu/drm/panthor/panthor_pwr_regs.h |  83 ++++++
 drivers/gpu/drm/panthor/panthor_regs.h     | 291 ---------------------
 drivers/gpu/drm/panthor/panthor_sched.c    |   3 +-
 15 files changed, 318 insertions(+), 301 deletions(-)
 create mode 100644 drivers/gpu/drm/panthor/panthor_fw_regs.h
 create mode 100644 drivers/gpu/drm/panthor/panthor_gpu_regs.h
 create mode 100644 drivers/gpu/drm/panthor/panthor_mmu_regs.h
 create mode 100644 drivers/gpu/drm/panthor/panthor_pwr_regs.h
 delete mode 100644 drivers/gpu/drm/panthor/panthor_regs.h

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index d62017b73409..f876b13492ae 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -19,12 +19,13 @@
 #include "panthor_devfreq.h"
 #include "panthor_device.h"
 #include "panthor_fw.h"
+#include "panthor_fw_regs.h"
 #include "panthor_gem.h"
 #include "panthor_gpu.h"
+#include "panthor_gpu_regs.h"
 #include "panthor_hw.h"
 #include "panthor_mmu.h"
 #include "panthor_pwr.h"
-#include "panthor_regs.h"
 #include "panthor_sched.h"
 
 static int panthor_gpu_coherency_init(struct panthor_device *ptdev)
diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 4f926c861fba..e63210b01e6e 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -34,9 +34,9 @@
 #include "panthor_fw.h"
 #include "panthor_gem.h"
 #include "panthor_gpu.h"
+#include "panthor_gpu_regs.h"
 #include "panthor_heap.h"
 #include "panthor_mmu.h"
-#include "panthor_regs.h"
 #include "panthor_sched.h"
 
 /**
diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 69a19751a314..4704275b9c8f 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -20,11 +20,11 @@
 
 #include "panthor_device.h"
 #include "panthor_fw.h"
+#include "panthor_fw_regs.h"
 #include "panthor_gem.h"
 #include "panthor_gpu.h"
 #include "panthor_hw.h"
 #include "panthor_mmu.h"
-#include "panthor_regs.h"
 #include "panthor_sched.h"
 #include "panthor_trace.h"
 
diff --git a/drivers/gpu/drm/panthor/panthor_fw_regs.h b/drivers/gpu/drm/panthor/panthor_fw_regs.h
new file mode 100644
index 000000000000..d523d41e18dd
--- /dev/null
+++ b/drivers/gpu/drm/panthor/panthor_fw_regs.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#ifndef __PANTHOR_FW_REGS_H__
+#define __PANTHOR_FW_REGS_H__
+
+#define MCU_CONTROL					0x700
+#define   MCU_CONTROL_ENABLE				1
+#define   MCU_CONTROL_AUTO				2
+#define   MCU_CONTROL_DISABLE				0
+
+#define MCU_STATUS					0x704
+#define   MCU_STATUS_DISABLED				0
+#define   MCU_STATUS_ENABLED				1
+#define   MCU_STATUS_HALT				2
+#define   MCU_STATUS_FATAL				3
+
+#define JOB_INT_RAWSTAT					0x1000
+#define JOB_INT_CLEAR					0x1004
+#define JOB_INT_MASK					0x1008
+#define JOB_INT_STAT					0x100c
+#define   JOB_INT_GLOBAL_IF				BIT(31)
+#define   JOB_INT_CSG_IF(x)				BIT(x)
+
+#define CSF_GPU_LATEST_FLUSH_ID				0x10000
+
+#define CSF_DOORBELL(i)					(0x80000 + ((i) * 0x10000))
+#define CSF_GLB_DOORBELL_ID				0
+
+#endif /* __PANTHOR_FW_REGS_H__ */
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index bdb72cebccb3..fecc30747acf 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -19,8 +19,8 @@
 
 #include "panthor_device.h"
 #include "panthor_gpu.h"
+#include "panthor_gpu_regs.h"
 #include "panthor_hw.h"
-#include "panthor_regs.h"
 
 #define CREATE_TRACE_POINTS
 #include "panthor_trace.h"
diff --git a/drivers/gpu/drm/panthor/panthor_gpu_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
new file mode 100644
index 000000000000..75474b7d7341
--- /dev/null
+++ b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
@@ -0,0 +1,120 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#ifndef __PANTHOR_GPU_REGS_H__
+#define __PANTHOR_GPU_REGS_H__
+
+#define GPU_ID						0x0
+#define   GPU_ARCH_MAJOR(x)				((x) >> 28)
+#define   GPU_ARCH_MINOR(x)				(((x) & GENMASK(27, 24)) >> 24)
+#define   GPU_ARCH_REV(x)				(((x) & GENMASK(23, 20)) >> 20)
+#define   GPU_PROD_MAJOR(x)				(((x) & GENMASK(19, 16)) >> 16)
+#define   GPU_VER_MAJOR(x)				(((x) & GENMASK(15, 12)) >> 12)
+#define   GPU_VER_MINOR(x)				(((x) & GENMASK(11, 4)) >> 4)
+#define   GPU_VER_STATUS(x)				((x) & GENMASK(3, 0))
+
+#define GPU_L2_FEATURES					0x4
+#define  GPU_L2_FEATURES_LINE_SIZE(x)			(1 << ((x) & GENMASK(7, 0)))
+
+#define GPU_CORE_FEATURES				0x8
+
+#define GPU_TILER_FEATURES				0xC
+#define GPU_MEM_FEATURES				0x10
+#define   GROUPS_L2_COHERENT				BIT(0)
+
+#define GPU_MMU_FEATURES				0x14
+#define  GPU_MMU_FEATURES_VA_BITS(x)			((x) & GENMASK(7, 0))
+#define  GPU_MMU_FEATURES_PA_BITS(x)			(((x) >> 8) & GENMASK(7, 0))
+#define GPU_AS_PRESENT					0x18
+#define GPU_CSF_ID					0x1C
+
+#define GPU_INT_RAWSTAT					0x20
+#define GPU_INT_CLEAR					0x24
+#define GPU_INT_MASK					0x28
+#define GPU_INT_STAT					0x2c
+#define   GPU_IRQ_FAULT					BIT(0)
+#define   GPU_IRQ_PROTM_FAULT				BIT(1)
+#define   GPU_IRQ_RESET_COMPLETED			BIT(8)
+#define   GPU_IRQ_POWER_CHANGED				BIT(9)
+#define   GPU_IRQ_POWER_CHANGED_ALL			BIT(10)
+#define   GPU_IRQ_CLEAN_CACHES_COMPLETED		BIT(17)
+#define   GPU_IRQ_DOORBELL_MIRROR			BIT(18)
+#define   GPU_IRQ_MCU_STATUS_CHANGED			BIT(19)
+#define GPU_CMD						0x30
+#define   GPU_CMD_DEF(type, payload)			((type) | ((payload) << 8))
+#define   GPU_SOFT_RESET				GPU_CMD_DEF(1, 1)
+#define   GPU_HARD_RESET				GPU_CMD_DEF(1, 2)
+#define   CACHE_CLEAN					BIT(0)
+#define   CACHE_INV					BIT(1)
+#define   GPU_FLUSH_CACHES(l2, lsc, oth)		\
+	  GPU_CMD_DEF(4, ((l2) << 0) | ((lsc) << 4) | ((oth) << 8))
+
+#define GPU_STATUS					0x34
+#define   GPU_STATUS_ACTIVE				BIT(0)
+#define   GPU_STATUS_PWR_ACTIVE				BIT(1)
+#define   GPU_STATUS_PAGE_FAULT				BIT(4)
+#define   GPU_STATUS_PROTM_ACTIVE			BIT(7)
+#define   GPU_STATUS_DBG_ENABLED			BIT(8)
+
+#define GPU_FAULT_STATUS				0x3C
+#define GPU_FAULT_ADDR					0x40
+#define GPU_L2_CONFIG					0x48
+#define   GPU_L2_CONFIG_ASN_HASH_ENABLE			BIT(24)
+
+#define GPU_PWR_KEY					0x50
+#define  GPU_PWR_KEY_UNLOCK				0x2968A819
+#define GPU_PWR_OVERRIDE0				0x54
+#define GPU_PWR_OVERRIDE1				0x58
+
+#define GPU_FEATURES					0x60
+#define   GPU_FEATURES_RAY_INTERSECTION			BIT(2)
+#define   GPU_FEATURES_RAY_TRAVERSAL			BIT(5)
+
+#define GPU_TIMESTAMP_OFFSET				0x88
+#define GPU_CYCLE_COUNT					0x90
+#define GPU_TIMESTAMP					0x98
+
+#define GPU_THREAD_MAX_THREADS				0xA0
+#define GPU_THREAD_MAX_WORKGROUP_SIZE			0xA4
+#define GPU_THREAD_MAX_BARRIER_SIZE			0xA8
+#define GPU_THREAD_FEATURES				0xAC
+
+#define GPU_TEXTURE_FEATURES(n)				(0xB0 + ((n) * 4))
+
+#define GPU_SHADER_PRESENT				0x100
+#define GPU_TILER_PRESENT				0x110
+#define GPU_L2_PRESENT					0x120
+
+#define SHADER_READY					0x140
+#define TILER_READY					0x150
+#define L2_READY					0x160
+
+#define SHADER_PWRON					0x180
+#define TILER_PWRON					0x190
+#define L2_PWRON					0x1A0
+
+#define SHADER_PWROFF					0x1C0
+#define TILER_PWROFF					0x1D0
+#define L2_PWROFF					0x1E0
+
+#define SHADER_PWRTRANS					0x200
+#define TILER_PWRTRANS					0x210
+#define L2_PWRTRANS					0x220
+
+#define SHADER_PWRACTIVE				0x240
+#define TILER_PWRACTIVE					0x250
+#define L2_PWRACTIVE					0x260
+
+#define GPU_REVID					0x280
+
+#define GPU_ASN_HASH(n)					(0x2C0 + ((n) * 4))
+
+#define GPU_COHERENCY_FEATURES				0x300
+#define GPU_COHERENCY_PROT_BIT(name)			BIT(GPU_COHERENCY_  ## name)
+
+#define GPU_COHERENCY_PROTOCOL				0x304
+#define   GPU_COHERENCY_ACE_LITE			0
+#define   GPU_COHERENCY_ACE				1
+#define   GPU_COHERENCY_NONE				31
+
+#endif /* __PANTHOR_GPU_REGS_H__ */
diff --git a/drivers/gpu/drm/panthor/panthor_heap.c b/drivers/gpu/drm/panthor/panthor_heap.c
index 1ee30dc7066f..99311abdf1e9 100644
--- a/drivers/gpu/drm/panthor/panthor_heap.c
+++ b/drivers/gpu/drm/panthor/panthor_heap.c
@@ -9,9 +9,9 @@
 
 #include "panthor_device.h"
 #include "panthor_gem.h"
+#include "panthor_gpu_regs.h"
 #include "panthor_heap.h"
 #include "panthor_mmu.h"
-#include "panthor_regs.h"
 
 /*
  * The GPU heap context is an opaque structure used by the GPU to track the
diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index 9309d0938212..9431f16d950f 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -8,9 +8,10 @@
 
 #include "panthor_device.h"
 #include "panthor_gpu.h"
+#include "panthor_gpu_regs.h"
 #include "panthor_hw.h"
 #include "panthor_pwr.h"
-#include "panthor_regs.h"
+#include "panthor_pwr_regs.h"
 
 #define GPU_PROD_ID_MAKE(arch_major, prod_major) \
 	(((arch_major) << 24) | (prod_major))
diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
index 2c28aea82841..f797663893b2 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.h
+++ b/drivers/gpu/drm/panthor/panthor_hw.h
@@ -5,7 +5,7 @@
 #define __PANTHOR_HW_H__
 
 #include "panthor_device.h"
-#include "panthor_regs.h"
+#include "panthor_gpu_regs.h"
 
 /**
  * struct panthor_hw_ops - HW operations that are specific to a GPU
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 6a8ac2239b9c..853f5ebfe5c6 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -33,9 +33,10 @@
 #include "panthor_device.h"
 #include "panthor_gem.h"
 #include "panthor_gpu.h"
+#include "panthor_gpu_regs.h"
 #include "panthor_heap.h"
 #include "panthor_mmu.h"
-#include "panthor_regs.h"
+#include "panthor_mmu_regs.h"
 #include "panthor_sched.h"
 
 #define MAX_AS_SLOTS			32
diff --git a/drivers/gpu/drm/panthor/panthor_mmu_regs.h b/drivers/gpu/drm/panthor/panthor_mmu_regs.h
new file mode 100644
index 000000000000..cc9cf603cec6
--- /dev/null
+++ b/drivers/gpu/drm/panthor/panthor_mmu_regs.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#ifndef __PANTHOR_MMU_REGS_H__
+#define __PANTHOR_MMU_REGS_H__
+
+/* MMU regs */
+#define MMU_INT_RAWSTAT					0x2000
+#define MMU_INT_CLEAR					0x2004
+#define MMU_INT_MASK					0x2008
+#define MMU_INT_STAT					0x200c
+
+/* AS_COMMAND register commands */
+
+#define MMU_BASE					0x2400
+#define MMU_AS_SHIFT					6
+#define MMU_AS(as)					(MMU_BASE + ((as) << MMU_AS_SHIFT))
+
+#define AS_TRANSTAB(as)					(MMU_AS(as) + 0x0)
+#define AS_MEMATTR(as)					(MMU_AS(as) + 0x8)
+#define   AS_MEMATTR_AARCH64_INNER_ALLOC_IMPL		(2 << 2)
+#define   AS_MEMATTR_AARCH64_INNER_ALLOC_EXPL(w, r)	((3 << 2) | \
+							 ((w) ? BIT(0) : 0) | \
+							 ((r) ? BIT(1) : 0))
+#define   AS_MEMATTR_AARCH64_SH_MIDGARD_INNER		(0 << 4)
+#define   AS_MEMATTR_AARCH64_SH_CPU_INNER		(1 << 4)
+#define   AS_MEMATTR_AARCH64_SH_CPU_INNER_SHADER_COH	(2 << 4)
+#define   AS_MEMATTR_AARCH64_SHARED			(0 << 6)
+#define   AS_MEMATTR_AARCH64_INNER_OUTER_NC		(1 << 6)
+#define   AS_MEMATTR_AARCH64_INNER_OUTER_WB		(2 << 6)
+#define   AS_MEMATTR_AARCH64_FAULT			(3 << 6)
+#define AS_LOCKADDR(as)					(MMU_AS(as) + 0x10)
+#define AS_COMMAND(as)					(MMU_AS(as) + 0x18)
+#define   AS_COMMAND_NOP				0
+#define   AS_COMMAND_UPDATE				1
+#define   AS_COMMAND_LOCK				2
+#define   AS_COMMAND_UNLOCK				3
+#define   AS_COMMAND_FLUSH_PT				4
+#define   AS_COMMAND_FLUSH_MEM				5
+#define   AS_LOCK_REGION_MIN_SIZE			(1ULL << 15)
+#define AS_FAULTSTATUS(as)				(MMU_AS(as) + 0x1C)
+#define  AS_FAULTSTATUS_ACCESS_TYPE_MASK		(0x3 << 8)
+#define  AS_FAULTSTATUS_ACCESS_TYPE_ATOMIC		(0x0 << 8)
+#define  AS_FAULTSTATUS_ACCESS_TYPE_EX			(0x1 << 8)
+#define  AS_FAULTSTATUS_ACCESS_TYPE_READ		(0x2 << 8)
+#define  AS_FAULTSTATUS_ACCESS_TYPE_WRITE		(0x3 << 8)
+#define AS_FAULTADDRESS(as)				(MMU_AS(as) + 0x20)
+#define AS_STATUS(as)					(MMU_AS(as) + 0x28)
+#define   AS_STATUS_AS_ACTIVE				BIT(0)
+#define AS_TRANSCFG(as)					(MMU_AS(as) + 0x30)
+#define   AS_TRANSCFG_ADRMODE_UNMAPPED			(1 << 0)
+#define   AS_TRANSCFG_ADRMODE_IDENTITY			(2 << 0)
+#define   AS_TRANSCFG_ADRMODE_AARCH64_4K		(6 << 0)
+#define   AS_TRANSCFG_ADRMODE_AARCH64_64K		(8 << 0)
+#define   AS_TRANSCFG_INA_BITS(x)			((x) << 6)
+#define   AS_TRANSCFG_OUTA_BITS(x)			((x) << 14)
+#define   AS_TRANSCFG_SL_CONCAT				BIT(22)
+#define   AS_TRANSCFG_PTW_MEMATTR_NC			(1 << 24)
+#define   AS_TRANSCFG_PTW_MEMATTR_WB			(2 << 24)
+#define   AS_TRANSCFG_PTW_SH_NS				(0 << 28)
+#define   AS_TRANSCFG_PTW_SH_OS				(2 << 28)
+#define   AS_TRANSCFG_PTW_SH_IS				(3 << 28)
+#define   AS_TRANSCFG_PTW_RA				BIT(30)
+#define   AS_TRANSCFG_DISABLE_HIER_AP			BIT(33)
+#define   AS_TRANSCFG_DISABLE_AF_FAULT			BIT(34)
+#define   AS_TRANSCFG_WXN				BIT(35)
+#define   AS_TRANSCFG_XREADABLE				BIT(36)
+#define AS_FAULTEXTRA(as)				(MMU_AS(as) + 0x38)
+
+#endif /* __PANTHOR_MMU_REGS_H__ */
diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
index b77c85ad733a..306592ff2227 100644
--- a/drivers/gpu/drm/panthor/panthor_pwr.c
+++ b/drivers/gpu/drm/panthor/panthor_pwr.c
@@ -11,9 +11,10 @@
 #include <drm/drm_print.h>
 
 #include "panthor_device.h"
+#include "panthor_gpu_regs.h"
 #include "panthor_hw.h"
 #include "panthor_pwr.h"
-#include "panthor_regs.h"
+#include "panthor_pwr_regs.h"
 
 #define PWR_INTERRUPTS_MASK \
 	(PWR_IRQ_POWER_CHANGED_SINGLE | \
diff --git a/drivers/gpu/drm/panthor/panthor_pwr_regs.h b/drivers/gpu/drm/panthor/panthor_pwr_regs.h
new file mode 100644
index 000000000000..ad3e446971db
--- /dev/null
+++ b/drivers/gpu/drm/panthor/panthor_pwr_regs.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#ifndef __PANTHOR_PWR_REGS_H__
+#define __PANTHOR_PWR_REGS_H__
+
+#define PWR_CONTROL_BASE				0x800
+#define PWR_CTRL_REG(x)					(PWR_CONTROL_BASE + (x))
+
+#define PWR_INT_RAWSTAT					PWR_CTRL_REG(0x0)
+#define PWR_INT_CLEAR					PWR_CTRL_REG(0x4)
+#define PWR_INT_MASK					PWR_CTRL_REG(0x8)
+#define PWR_INT_STAT					PWR_CTRL_REG(0xc)
+#define   PWR_IRQ_POWER_CHANGED_SINGLE			BIT(0)
+#define   PWR_IRQ_POWER_CHANGED_ALL			BIT(1)
+#define   PWR_IRQ_DELEGATION_CHANGED			BIT(2)
+#define   PWR_IRQ_RESET_COMPLETED			BIT(3)
+#define   PWR_IRQ_RETRACT_COMPLETED			BIT(4)
+#define   PWR_IRQ_INSPECT_COMPLETED			BIT(5)
+#define   PWR_IRQ_COMMAND_NOT_ALLOWED			BIT(30)
+#define   PWR_IRQ_COMMAND_INVALID			BIT(31)
+
+#define PWR_STATUS					PWR_CTRL_REG(0x20)
+#define   PWR_STATUS_ALLOW_L2				BIT_U64(0)
+#define   PWR_STATUS_ALLOW_TILER			BIT_U64(1)
+#define   PWR_STATUS_ALLOW_SHADER			BIT_U64(8)
+#define   PWR_STATUS_ALLOW_BASE				BIT_U64(14)
+#define   PWR_STATUS_ALLOW_STACK			BIT_U64(15)
+#define   PWR_STATUS_DOMAIN_ALLOWED(x)			BIT_U64(x)
+#define   PWR_STATUS_DELEGATED_L2			BIT_U64(16)
+#define   PWR_STATUS_DELEGATED_TILER			BIT_U64(17)
+#define   PWR_STATUS_DELEGATED_SHADER			BIT_U64(24)
+#define   PWR_STATUS_DELEGATED_BASE			BIT_U64(30)
+#define   PWR_STATUS_DELEGATED_STACK			BIT_U64(31)
+#define   PWR_STATUS_DELEGATED_SHIFT			16
+#define   PWR_STATUS_DOMAIN_DELEGATED(x)		BIT_U64((x) + PWR_STATUS_DELEGATED_SHIFT)
+#define   PWR_STATUS_ALLOW_SOFT_RESET			BIT_U64(33)
+#define   PWR_STATUS_ALLOW_FAST_RESET			BIT_U64(34)
+#define   PWR_STATUS_POWER_PENDING			BIT_U64(41)
+#define   PWR_STATUS_RESET_PENDING			BIT_U64(42)
+#define   PWR_STATUS_RETRACT_PENDING			BIT_U64(43)
+#define   PWR_STATUS_INSPECT_PENDING			BIT_U64(44)
+
+#define PWR_COMMAND					PWR_CTRL_REG(0x28)
+#define   PWR_COMMAND_POWER_UP				0x10
+#define   PWR_COMMAND_POWER_DOWN			0x11
+#define   PWR_COMMAND_DELEGATE				0x20
+#define   PWR_COMMAND_RETRACT				0x21
+#define   PWR_COMMAND_RESET_SOFT			0x31
+#define   PWR_COMMAND_RESET_FAST			0x32
+#define   PWR_COMMAND_INSPECT				0xF0
+#define   PWR_COMMAND_DOMAIN_L2				0
+#define   PWR_COMMAND_DOMAIN_TILER			1
+#define   PWR_COMMAND_DOMAIN_SHADER			8
+#define   PWR_COMMAND_DOMAIN_BASE			14
+#define   PWR_COMMAND_DOMAIN_STACK			15
+#define   PWR_COMMAND_SUBDOMAIN_RTU			BIT(0)
+#define   PWR_COMMAND_DEF(cmd, domain, subdomain)	\
+	(((subdomain) << 16) | ((domain) << 8) | (cmd))
+
+#define PWR_CMDARG					PWR_CTRL_REG(0x30)
+
+#define PWR_L2_PRESENT					PWR_CTRL_REG(0x100)
+#define PWR_L2_READY					PWR_CTRL_REG(0x108)
+#define PWR_L2_PWRTRANS					PWR_CTRL_REG(0x110)
+#define PWR_L2_PWRACTIVE				PWR_CTRL_REG(0x118)
+#define PWR_TILER_PRESENT				PWR_CTRL_REG(0x140)
+#define PWR_TILER_READY					PWR_CTRL_REG(0x148)
+#define PWR_TILER_PWRTRANS				PWR_CTRL_REG(0x150)
+#define PWR_TILER_PWRACTIVE				PWR_CTRL_REG(0x158)
+#define PWR_SHADER_PRESENT				PWR_CTRL_REG(0x200)
+#define PWR_SHADER_READY				PWR_CTRL_REG(0x208)
+#define PWR_SHADER_PWRTRANS				PWR_CTRL_REG(0x210)
+#define PWR_SHADER_PWRACTIVE				PWR_CTRL_REG(0x218)
+#define PWR_BASE_PRESENT				PWR_CTRL_REG(0x380)
+#define PWR_BASE_READY					PWR_CTRL_REG(0x388)
+#define PWR_BASE_PWRTRANS				PWR_CTRL_REG(0x390)
+#define PWR_BASE_PWRACTIVE				PWR_CTRL_REG(0x398)
+#define PWR_STACK_PRESENT				PWR_CTRL_REG(0x3c0)
+#define PWR_STACK_READY					PWR_CTRL_REG(0x3c8)
+#define PWR_STACK_PWRTRANS				PWR_CTRL_REG(0x3d0)
+
+#endif /* __PANTHOR_PWR_REGS_H__ */
diff --git a/drivers/gpu/drm/panthor/panthor_regs.h b/drivers/gpu/drm/panthor/panthor_regs.h
deleted file mode 100644
index 08bf06c452d6..000000000000
--- a/drivers/gpu/drm/panthor/panthor_regs.h
+++ /dev/null
@@ -1,291 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 or MIT */
-/* Copyright 2018 Marty E. Plummer <hanetzer@startmail.com> */
-/* Copyright 2019 Linaro, Ltd, Rob Herring <robh@kernel.org> */
-/* Copyright 2023 Collabora ltd. */
-/*
- * Register definitions based on mali_kbase_gpu_regmap.h and
- * mali_kbase_gpu_regmap_csf.h
- * (C) COPYRIGHT 2010-2022 ARM Limited. All rights reserved.
- */
-#ifndef __PANTHOR_REGS_H__
-#define __PANTHOR_REGS_H__
-
-#define GPU_ID						0x0
-#define   GPU_ARCH_MAJOR(x)				((x) >> 28)
-#define   GPU_ARCH_MINOR(x)				(((x) & GENMASK(27, 24)) >> 24)
-#define   GPU_ARCH_REV(x)				(((x) & GENMASK(23, 20)) >> 20)
-#define   GPU_PROD_MAJOR(x)				(((x) & GENMASK(19, 16)) >> 16)
-#define   GPU_VER_MAJOR(x)				(((x) & GENMASK(15, 12)) >> 12)
-#define   GPU_VER_MINOR(x)				(((x) & GENMASK(11, 4)) >> 4)
-#define   GPU_VER_STATUS(x)				((x) & GENMASK(3, 0))
-
-#define GPU_L2_FEATURES					0x4
-#define  GPU_L2_FEATURES_LINE_SIZE(x)			(1 << ((x) & GENMASK(7, 0)))
-
-#define GPU_CORE_FEATURES				0x8
-
-#define GPU_TILER_FEATURES				0xC
-#define GPU_MEM_FEATURES				0x10
-#define   GROUPS_L2_COHERENT				BIT(0)
-
-#define GPU_MMU_FEATURES				0x14
-#define  GPU_MMU_FEATURES_VA_BITS(x)			((x) & GENMASK(7, 0))
-#define  GPU_MMU_FEATURES_PA_BITS(x)			(((x) >> 8) & GENMASK(7, 0))
-#define GPU_AS_PRESENT					0x18
-#define GPU_CSF_ID					0x1C
-
-#define GPU_INT_RAWSTAT					0x20
-#define GPU_INT_CLEAR					0x24
-#define GPU_INT_MASK					0x28
-#define GPU_INT_STAT					0x2c
-#define   GPU_IRQ_FAULT					BIT(0)
-#define   GPU_IRQ_PROTM_FAULT				BIT(1)
-#define   GPU_IRQ_RESET_COMPLETED			BIT(8)
-#define   GPU_IRQ_POWER_CHANGED				BIT(9)
-#define   GPU_IRQ_POWER_CHANGED_ALL			BIT(10)
-#define   GPU_IRQ_CLEAN_CACHES_COMPLETED		BIT(17)
-#define   GPU_IRQ_DOORBELL_MIRROR			BIT(18)
-#define   GPU_IRQ_MCU_STATUS_CHANGED			BIT(19)
-#define GPU_CMD						0x30
-#define   GPU_CMD_DEF(type, payload)			((type) | ((payload) << 8))
-#define   GPU_SOFT_RESET				GPU_CMD_DEF(1, 1)
-#define   GPU_HARD_RESET				GPU_CMD_DEF(1, 2)
-#define   CACHE_CLEAN					BIT(0)
-#define   CACHE_INV					BIT(1)
-#define   GPU_FLUSH_CACHES(l2, lsc, oth)		\
-	  GPU_CMD_DEF(4, ((l2) << 0) | ((lsc) << 4) | ((oth) << 8))
-
-#define GPU_STATUS					0x34
-#define   GPU_STATUS_ACTIVE				BIT(0)
-#define   GPU_STATUS_PWR_ACTIVE				BIT(1)
-#define   GPU_STATUS_PAGE_FAULT				BIT(4)
-#define   GPU_STATUS_PROTM_ACTIVE			BIT(7)
-#define   GPU_STATUS_DBG_ENABLED			BIT(8)
-
-#define GPU_FAULT_STATUS				0x3C
-#define GPU_FAULT_ADDR					0x40
-#define GPU_L2_CONFIG					0x48
-#define   GPU_L2_CONFIG_ASN_HASH_ENABLE			BIT(24)
-
-#define GPU_PWR_KEY					0x50
-#define  GPU_PWR_KEY_UNLOCK				0x2968A819
-#define GPU_PWR_OVERRIDE0				0x54
-#define GPU_PWR_OVERRIDE1				0x58
-
-#define GPU_FEATURES					0x60
-#define   GPU_FEATURES_RAY_INTERSECTION			BIT(2)
-#define   GPU_FEATURES_RAY_TRAVERSAL			BIT(5)
-
-#define GPU_TIMESTAMP_OFFSET				0x88
-#define GPU_CYCLE_COUNT					0x90
-#define GPU_TIMESTAMP					0x98
-
-#define GPU_THREAD_MAX_THREADS				0xA0
-#define GPU_THREAD_MAX_WORKGROUP_SIZE			0xA4
-#define GPU_THREAD_MAX_BARRIER_SIZE			0xA8
-#define GPU_THREAD_FEATURES				0xAC
-
-#define GPU_TEXTURE_FEATURES(n)				(0xB0 + ((n) * 4))
-
-#define GPU_SHADER_PRESENT				0x100
-#define GPU_TILER_PRESENT				0x110
-#define GPU_L2_PRESENT					0x120
-
-#define SHADER_READY					0x140
-#define TILER_READY					0x150
-#define L2_READY					0x160
-
-#define SHADER_PWRON					0x180
-#define TILER_PWRON					0x190
-#define L2_PWRON					0x1A0
-
-#define SHADER_PWROFF					0x1C0
-#define TILER_PWROFF					0x1D0
-#define L2_PWROFF					0x1E0
-
-#define SHADER_PWRTRANS					0x200
-#define TILER_PWRTRANS					0x210
-#define L2_PWRTRANS					0x220
-
-#define SHADER_PWRACTIVE				0x240
-#define TILER_PWRACTIVE					0x250
-#define L2_PWRACTIVE					0x260
-
-#define GPU_REVID					0x280
-
-#define GPU_ASN_HASH(n)					(0x2C0 + ((n) * 4))
-
-#define GPU_COHERENCY_FEATURES				0x300
-#define GPU_COHERENCY_PROT_BIT(name)			BIT(GPU_COHERENCY_  ## name)
-
-#define GPU_COHERENCY_PROTOCOL				0x304
-#define   GPU_COHERENCY_ACE_LITE			0
-#define   GPU_COHERENCY_ACE				1
-#define   GPU_COHERENCY_NONE				31
-
-#define MCU_CONTROL					0x700
-#define MCU_CONTROL_ENABLE				1
-#define MCU_CONTROL_AUTO				2
-#define MCU_CONTROL_DISABLE				0
-
-#define MCU_STATUS					0x704
-#define MCU_STATUS_DISABLED				0
-#define MCU_STATUS_ENABLED				1
-#define MCU_STATUS_HALT					2
-#define MCU_STATUS_FATAL				3
-
-/* Job Control regs */
-#define JOB_INT_RAWSTAT					0x1000
-#define JOB_INT_CLEAR					0x1004
-#define JOB_INT_MASK					0x1008
-#define JOB_INT_STAT					0x100c
-#define   JOB_INT_GLOBAL_IF				BIT(31)
-#define   JOB_INT_CSG_IF(x)				BIT(x)
-
-/* MMU regs */
-#define MMU_INT_RAWSTAT					0x2000
-#define MMU_INT_CLEAR					0x2004
-#define MMU_INT_MASK					0x2008
-#define MMU_INT_STAT					0x200c
-
-/* AS_COMMAND register commands */
-
-#define MMU_BASE					0x2400
-#define MMU_AS_SHIFT					6
-#define MMU_AS(as)					(MMU_BASE + ((as) << MMU_AS_SHIFT))
-
-#define AS_TRANSTAB(as)					(MMU_AS(as) + 0x0)
-#define AS_MEMATTR(as)					(MMU_AS(as) + 0x8)
-#define   AS_MEMATTR_AARCH64_INNER_ALLOC_IMPL		(2 << 2)
-#define   AS_MEMATTR_AARCH64_INNER_ALLOC_EXPL(w, r)	((3 << 2) | \
-							 ((w) ? BIT(0) : 0) | \
-							 ((r) ? BIT(1) : 0))
-#define   AS_MEMATTR_AARCH64_SH_MIDGARD_INNER		(0 << 4)
-#define   AS_MEMATTR_AARCH64_SH_CPU_INNER		(1 << 4)
-#define   AS_MEMATTR_AARCH64_SH_CPU_INNER_SHADER_COH	(2 << 4)
-#define   AS_MEMATTR_AARCH64_SHARED			(0 << 6)
-#define   AS_MEMATTR_AARCH64_INNER_OUTER_NC		(1 << 6)
-#define   AS_MEMATTR_AARCH64_INNER_OUTER_WB		(2 << 6)
-#define   AS_MEMATTR_AARCH64_FAULT			(3 << 6)
-#define AS_LOCKADDR(as)					(MMU_AS(as) + 0x10)
-#define AS_COMMAND(as)					(MMU_AS(as) + 0x18)
-#define   AS_COMMAND_NOP				0
-#define   AS_COMMAND_UPDATE				1
-#define   AS_COMMAND_LOCK				2
-#define   AS_COMMAND_UNLOCK				3
-#define   AS_COMMAND_FLUSH_PT				4
-#define   AS_COMMAND_FLUSH_MEM				5
-#define   AS_LOCK_REGION_MIN_SIZE			(1ULL << 15)
-#define AS_FAULTSTATUS(as)				(MMU_AS(as) + 0x1C)
-#define  AS_FAULTSTATUS_ACCESS_TYPE_MASK		(0x3 << 8)
-#define  AS_FAULTSTATUS_ACCESS_TYPE_ATOMIC		(0x0 << 8)
-#define  AS_FAULTSTATUS_ACCESS_TYPE_EX			(0x1 << 8)
-#define  AS_FAULTSTATUS_ACCESS_TYPE_READ		(0x2 << 8)
-#define  AS_FAULTSTATUS_ACCESS_TYPE_WRITE		(0x3 << 8)
-#define AS_FAULTADDRESS(as)				(MMU_AS(as) + 0x20)
-#define AS_STATUS(as)					(MMU_AS(as) + 0x28)
-#define   AS_STATUS_AS_ACTIVE				BIT(0)
-#define AS_TRANSCFG(as)					(MMU_AS(as) + 0x30)
-#define   AS_TRANSCFG_ADRMODE_UNMAPPED			(1 << 0)
-#define   AS_TRANSCFG_ADRMODE_IDENTITY			(2 << 0)
-#define   AS_TRANSCFG_ADRMODE_AARCH64_4K		(6 << 0)
-#define   AS_TRANSCFG_ADRMODE_AARCH64_64K		(8 << 0)
-#define   AS_TRANSCFG_INA_BITS(x)			((x) << 6)
-#define   AS_TRANSCFG_OUTA_BITS(x)			((x) << 14)
-#define   AS_TRANSCFG_SL_CONCAT				BIT(22)
-#define   AS_TRANSCFG_PTW_MEMATTR_NC			(1 << 24)
-#define   AS_TRANSCFG_PTW_MEMATTR_WB			(2 << 24)
-#define   AS_TRANSCFG_PTW_SH_NS				(0 << 28)
-#define   AS_TRANSCFG_PTW_SH_OS				(2 << 28)
-#define   AS_TRANSCFG_PTW_SH_IS				(3 << 28)
-#define   AS_TRANSCFG_PTW_RA				BIT(30)
-#define   AS_TRANSCFG_DISABLE_HIER_AP			BIT(33)
-#define   AS_TRANSCFG_DISABLE_AF_FAULT			BIT(34)
-#define   AS_TRANSCFG_WXN				BIT(35)
-#define   AS_TRANSCFG_XREADABLE				BIT(36)
-#define AS_FAULTEXTRA(as)				(MMU_AS(as) + 0x38)
-
-#define CSF_GPU_LATEST_FLUSH_ID				0x10000
-
-#define CSF_DOORBELL(i)					(0x80000 + ((i) * 0x10000))
-#define CSF_GLB_DOORBELL_ID				0
-
-/* PWR Control registers */
-
-#define PWR_CONTROL_BASE				0x800
-#define PWR_CTRL_REG(x)					(PWR_CONTROL_BASE + (x))
-
-#define PWR_INT_RAWSTAT					PWR_CTRL_REG(0x0)
-#define PWR_INT_CLEAR					PWR_CTRL_REG(0x4)
-#define PWR_INT_MASK					PWR_CTRL_REG(0x8)
-#define PWR_INT_STAT					PWR_CTRL_REG(0xc)
-#define   PWR_IRQ_POWER_CHANGED_SINGLE			BIT(0)
-#define   PWR_IRQ_POWER_CHANGED_ALL			BIT(1)
-#define   PWR_IRQ_DELEGATION_CHANGED			BIT(2)
-#define   PWR_IRQ_RESET_COMPLETED			BIT(3)
-#define   PWR_IRQ_RETRACT_COMPLETED			BIT(4)
-#define   PWR_IRQ_INSPECT_COMPLETED			BIT(5)
-#define   PWR_IRQ_COMMAND_NOT_ALLOWED			BIT(30)
-#define   PWR_IRQ_COMMAND_INVALID			BIT(31)
-
-#define PWR_STATUS					PWR_CTRL_REG(0x20)
-#define   PWR_STATUS_ALLOW_L2				BIT_U64(0)
-#define   PWR_STATUS_ALLOW_TILER			BIT_U64(1)
-#define   PWR_STATUS_ALLOW_SHADER			BIT_U64(8)
-#define   PWR_STATUS_ALLOW_BASE				BIT_U64(14)
-#define   PWR_STATUS_ALLOW_STACK			BIT_U64(15)
-#define   PWR_STATUS_DOMAIN_ALLOWED(x)			BIT_U64(x)
-#define   PWR_STATUS_DELEGATED_L2			BIT_U64(16)
-#define   PWR_STATUS_DELEGATED_TILER			BIT_U64(17)
-#define   PWR_STATUS_DELEGATED_SHADER			BIT_U64(24)
-#define   PWR_STATUS_DELEGATED_BASE			BIT_U64(30)
-#define   PWR_STATUS_DELEGATED_STACK			BIT_U64(31)
-#define   PWR_STATUS_DELEGATED_SHIFT			16
-#define   PWR_STATUS_DOMAIN_DELEGATED(x)		BIT_U64((x) + PWR_STATUS_DELEGATED_SHIFT)
-#define   PWR_STATUS_ALLOW_SOFT_RESET			BIT_U64(33)
-#define   PWR_STATUS_ALLOW_FAST_RESET			BIT_U64(34)
-#define   PWR_STATUS_POWER_PENDING			BIT_U64(41)
-#define   PWR_STATUS_RESET_PENDING			BIT_U64(42)
-#define   PWR_STATUS_RETRACT_PENDING			BIT_U64(43)
-#define   PWR_STATUS_INSPECT_PENDING			BIT_U64(44)
-
-#define PWR_COMMAND					PWR_CTRL_REG(0x28)
-#define   PWR_COMMAND_POWER_UP				0x10
-#define   PWR_COMMAND_POWER_DOWN			0x11
-#define   PWR_COMMAND_DELEGATE				0x20
-#define   PWR_COMMAND_RETRACT				0x21
-#define   PWR_COMMAND_RESET_SOFT			0x31
-#define   PWR_COMMAND_RESET_FAST			0x32
-#define   PWR_COMMAND_INSPECT				0xF0
-#define   PWR_COMMAND_DOMAIN_L2				0
-#define   PWR_COMMAND_DOMAIN_TILER			1
-#define   PWR_COMMAND_DOMAIN_SHADER			8
-#define   PWR_COMMAND_DOMAIN_BASE			14
-#define   PWR_COMMAND_DOMAIN_STACK			15
-#define   PWR_COMMAND_SUBDOMAIN_RTU			BIT(0)
-#define   PWR_COMMAND_DEF(cmd, domain, subdomain)	\
-	(((subdomain) << 16) | ((domain) << 8) | (cmd))
-
-#define PWR_CMDARG					PWR_CTRL_REG(0x30)
-
-#define PWR_L2_PRESENT					PWR_CTRL_REG(0x100)
-#define PWR_L2_READY					PWR_CTRL_REG(0x108)
-#define PWR_L2_PWRTRANS					PWR_CTRL_REG(0x110)
-#define PWR_L2_PWRACTIVE				PWR_CTRL_REG(0x118)
-#define PWR_TILER_PRESENT				PWR_CTRL_REG(0x140)
-#define PWR_TILER_READY					PWR_CTRL_REG(0x148)
-#define PWR_TILER_PWRTRANS				PWR_CTRL_REG(0x150)
-#define PWR_TILER_PWRACTIVE				PWR_CTRL_REG(0x158)
-#define PWR_SHADER_PRESENT				PWR_CTRL_REG(0x200)
-#define PWR_SHADER_READY				PWR_CTRL_REG(0x208)
-#define PWR_SHADER_PWRTRANS				PWR_CTRL_REG(0x210)
-#define PWR_SHADER_PWRACTIVE				PWR_CTRL_REG(0x218)
-#define PWR_BASE_PRESENT				PWR_CTRL_REG(0x380)
-#define PWR_BASE_READY					PWR_CTRL_REG(0x388)
-#define PWR_BASE_PWRTRANS				PWR_CTRL_REG(0x390)
-#define PWR_BASE_PWRACTIVE				PWR_CTRL_REG(0x398)
-#define PWR_STACK_PRESENT				PWR_CTRL_REG(0x3c0)
-#define PWR_STACK_READY					PWR_CTRL_REG(0x3c8)
-#define PWR_STACK_PWRTRANS				PWR_CTRL_REG(0x3d0)
-
-#endif
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 55660d9056ed..530e1f0254b1 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -28,11 +28,12 @@
 #include "panthor_devfreq.h"
 #include "panthor_device.h"
 #include "panthor_fw.h"
+#include "panthor_fw_regs.h"
 #include "panthor_gem.h"
 #include "panthor_gpu.h"
+#include "panthor_gpu_regs.h"
 #include "panthor_heap.h"
 #include "panthor_mmu.h"
-#include "panthor_regs.h"
 #include "panthor_sched.h"
 
 /**
-- 
2.43.0

