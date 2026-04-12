Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10340E937E4
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 14:31:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36FFF10E04D;
	Sun, 12 Apr 2026 14:31:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Kce/nNao";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Kce/nNao";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013045.outbound.protection.outlook.com
 [52.101.83.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7187810E2C3
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 14:31:11 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=J6BlO4RM5Gne/sLrw4w6AYcn+REkFBohdt13Df7YWVHSi5+Tcvve70GQvOgmvu5ndRYEDVQyrqfJYMeppR8EOd0xqFG7eiXd9QrvfLJ+YKsFdS714GiZTg96EXJjWYL+vxjmUD8O0EJVxcZVhgBi6B8GEZEYeFkGlQxJHx20+6VhpBuTuwPjxxDfLO2Q03U/ix/KEYeHgs3JSgmMojM2+gEHJlmqmusl8QOR8Y7KG7Gk9zrSdOZkOLq7hjKlAM5XDNd2l7IKs62lLAOYXfmKnh+dmG59gyK5JiZlgAKZtWiU56eXj6oObkepyUsDrfkIW0eKACGRq67ZQivfBa/l6A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdqvkE+0i7uq7t7NNB5IJw/3cM6WFKcfub+nkdOVaBY=;
 b=nfc7Ru3A9ojGxQtbJ5jLB+7bFx6I+6eS+sf2KNuMAvaysxhLDcX7Fsl34OlQrYV1e2+kGbFr99KwmUhkoGk44h7tQeMTNBFS3PSPdrSEwTMCSOHlBa/ZCTMKYTCS+DjUhN8eVjTzcUAOeYW9nMo+3gbb2hW+XVQi5Q0zLePOnxFaTkFGqqkouUrolNanqHKxIv3uqniqU3p+1S4NJB9Dgxz1KBmST4t/KyO/4uJTt0cn3mQXPnYp2/Dpj1Sfa8fovryuG5wM/TuouPKeMZuAiavVeLFbdVARaUCcGchosMVc0OGtVhKL5kRH7gN2VNrVGbmfk4W/VRQh2d2JCTw9Wg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdqvkE+0i7uq7t7NNB5IJw/3cM6WFKcfub+nkdOVaBY=;
 b=Kce/nNao8GC0UtmpYBo5r+w4lmdmewE62dveMlwGlE36d66JaKkywRlv+iU1JzgV77g50nfUDWAi4Q/3Afh00HdhNWDGMVHI2bIFJRX18sDulNJdZoxOU/V/VsFZLTyBpkLdTFKDLcfR8iQ8YCoz0tmXzs+VOqWGrwXUBDP+YDg=
Received: from CWLP265CA0492.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18a::8)
 by DU0PR08MB9419.eurprd08.prod.outlook.com (2603:10a6:10:422::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Sun, 12 Apr
 2026 14:31:05 +0000
Received: from AM3PEPF0000A78F.eurprd04.prod.outlook.com
 (2603:10a6:400:18a:cafe::48) by CWLP265CA0492.outlook.office365.com
 (2603:10a6:400:18a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.47 via Frontend Transport; Sun,
 12 Apr 2026 14:31:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A78F.mail.protection.outlook.com (10.167.16.118) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Sun, 12 Apr 2026 14:31:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHIEyfIWFYogjsNE35vBsy5htw9xDgEuzth5bbuG2DSsSjv/xxC5T7bPlQmnpS5Kzi/3WLS7Rw7h7434A2TLVYyqEDGLBjcP9JCaeSuB6nAKWp2IB5+yL9x5JZFs2in6X5PoOlX2KRhb/xNgPbIMJV332KAU6XFOtLfhU3Yy3zbmGsuVZhizO5FApSKp7IJy1OPInSDyHwTzd3GwpAs9eqYbZDuSApOO/Dki1bFdjg2UCRhgCeycss42deNCIYm/zP3TJukWtzhKlFkExjU1ao20iwJu0GRvJN7J9x1gHzByURXbbtCROoTcdZjuLyQEr4jPiM/7280wjsuxXSPewQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdqvkE+0i7uq7t7NNB5IJw/3cM6WFKcfub+nkdOVaBY=;
 b=TCJ7HKGGcQ2PJt1neC0UdgJ8RsspPT68VvrDROks4fZnjWNsR43++eGrLgi23lySXLnAe4ZI1TsrCvlXYYbVmUD8w4azMMHatdGLYVi2Rmmr4pVqv/USkox9e+LrbiEncOR7zBl1kEZcIdH+spc3VMTGoqYV69HCkH5HjGfsYQJMJX3tsrPoslBkNrTRI8OhCH0sd0FQtTHqmd0C08iL/H9H7iwyaXKqNCmk/T6LaodQonbOGmxFdcNfwJ1/qqBPh7HYJkZxpIPxGTNZVC0NPKmrs4f+xG+ao6T9ddYbWE723IeXeL+zxHdix7p4CIRTnWlVdFcYd8syKhb1rDsH1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdqvkE+0i7uq7t7NNB5IJw/3cM6WFKcfub+nkdOVaBY=;
 b=Kce/nNao8GC0UtmpYBo5r+w4lmdmewE62dveMlwGlE36d66JaKkywRlv+iU1JzgV77g50nfUDWAi4Q/3Afh00HdhNWDGMVHI2bIFJRX18sDulNJdZoxOU/V/VsFZLTyBpkLdTFKDLcfR8iQ8YCoz0tmXzs+VOqWGrwXUBDP+YDg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DB9PR08MB6556.eurprd08.prod.outlook.com
 (2603:10a6:10:261::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Sun, 12 Apr
 2026 14:30:02 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%6]) with mapi id 15.20.9769.046; Sun, 12 Apr 2026
 14:30:02 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] drm/panthor: Replace cross-component register accesses
 with helpers
Date: Sun, 12 Apr 2026 15:29:46 +0100
Message-ID: <20260412142951.2309135-4-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260412142951.2309135-1-karunika.choo@arm.com>
References: <20260412142951.2309135-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P195CA0009.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:b6::14) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DB9PR08MB6556:EE_|AM3PEPF0000A78F:EE_|DU0PR08MB9419:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c877ceb-d006-4624-b015-08de98a0211e
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info-Original: 4pND6fUbujBved/OV+WJc66XdMDaJ9J0V/oYuNnZcIPbHeOGiiSv2M4rJvT0ar3X8ViSvo9PCSWHK4+agR5UrEe+qUtbKwYWASKWpYaq0BRFy+2racubpVipFtY+UHSV+Gxp6RJ39NQbYYvrLnu5ghkrJJhzOKqhyLk2SamPGQnKAs0LHNZmfZRcHyJaQIdc2YNNyZsKMCkHkvINZujdlRSkGHe4VErVNQtSCSNqqush2Wg43Vt1asP4qSjRxyc7/nIhXhyR/i4LFAGqxwcKgs8EOyOrrNOF2VqplNWq0yUjmLf1DYUts72esUDm7kr63tE7a4dzQ+4BxkExY5Xw3mtGF5OCQ5SloM1deobgfB3U1cW0amDr/fXu9XOuLAQ922/VIBI3V0aexXQ82dKgHOi2ntRTGpIGnO10IHhgqpglCOyGtXlBePpYE+T+Tw5ugmGDZtCPYTg+aPtbdLQzzRtWUlK1NFnUkeMHG/fcykXFaA6hnepLrVQDgSdSdh8zv2egqyifKHUdw62bDmvmPrY9Nidz12VRraj/1WGooj6snwKY1XfmhsetFxqgkNtJSgBlGfiwNbbRB07/p+nthchddjzwMzLrVu+Qp0A3oqzb54bapbdxPDF6HwntwsjhasyqgRNSoDchgmD3liWJBPa1u3eSpFa97J7I/pGA45VMHxr02IbRso/PShcyX28QyUy7Qe4sSWn/luN3QhyLZ3Oexa7M/Z3ulf6AI+h/1cM=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: RrECsnhxsFLIQ4pLdvWv51v3/SdP2ccZ7KIHzS4TIp4trjSshFZD1lM7CAfw/6lqce/37Thw/HsusoAw5yGYVtf/iCZukkGQqJ4FZOe/z51pz+NU26w4bgqUcKGQ5rbMIJCgwrQvJ55R8iTE5sjtctZNXPqyLyLAJ8wY3kkHtnnPZmT+tBeRrNdj47kxhQcX56lKxVvAtgj6eBV19t2X6Y/SaPrkMp5+wV6bIw6EPS90le3oRRCgVBjPZHYyrWA5hZ2hTtKnjmWGQaRMlGZECN2nwaAyEmtZXEoo52uamsNZdm6/UJHhhGVueaeehm5A3m7nFyUOoDPutVTcuNnrgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6556
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF0000A78F.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c1e2e2da-c44a-4caf-8f4d-08de989ffbc0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|14060799003|82310400026|1800799024|376014|35042699022|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: qvK7YeoBIijYw9834bZK+9fPj1fry8c7tMsubSUxGFeHgVm1xWQ6f/SiX3d41QhL1SlmuaqsKea/O4eT48kmOEyy5+goChMJI4yZvR+zCkU4UX/RrBDnP9QBfHS6eckX1dlyzuMgjOCMeYJ6F7ZlnywqEikJ4OBXBze4ULUGdzMS3surFRegUBMfsAbvJgBS+L1MZOKWyIuZ+HzyXXNjPGnnL8bdTHlTkqADWm6gnT98V0LgP/UCzBtsBJffHFi0otuozPO6tvxHWMOP/QmrBVmp0e7fY4DsfK8swWcyZJ5BxB3X3wJST7LVU06YkKQf/UH5HCzfB0aHxTI8LsOmkV4XtNfeSwbU93FSAZEv7l9yfOEVg0pD/xXdPRl1nJ1MHa9nlYC+Iv0MuSkTeZd0wlf6wRxWPAO7Vjh1iZ9wFWqi+h3Dis2bnTQNCOqzglJq0E/MJxA/UBhNvcCxW7W6Kyc0rvunJczE7+IUeoOiJI2o8kdQD0XNOLcdLJFvAsc/l+BTvXIJlX9cplr9VYJLyekO1cuQW812wL03Q4SO5MPg//h5dWCBIVoas1VV1+Ktlfs4yWChmt8AGGhbNkTWGEI5uHJfDiwImd56NtNM+lczxctFfGe005dDEjj8kBFjIJC+epNCJNgqMSZcjd5pas7hR32LfBNhn2cCzp5k1uCVrPI+MAd2Ff6ImYEFqTpG35KZY/PMaVkHsYvDtBi2442yU6nNOw5sHtyJW/0NqX3BXzcbtlS0aFsUMwI+pLNG8CoU3I6UU4ToQU8fFUG79w==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(14060799003)(82310400026)(1800799024)(376014)(35042699022)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ldMs/zF+gq118O8vHc/fVHz+buMT5voyKMx6mhhC5SbaEq/q2A/0bn4s+hMowM7jFAszCV4kE9m+oSDAiQU5LY7//EK5f1jrUcViC63mEgmtlU/iaPLhK+nTmLOFZpe306TE2GLPkKKnWsJ9YO9nIoQkFtJrExZvzzTAtywLG56yUQE7haav8RvIcAMzapcP3W9CrtkyL3yVQLcoLpH0D8DtN/HpZfoiVkur5eU1N2Zq02LhPQUAouH3RMAT7HoR30Crcq3a5JEc4Tg/zxXiw9XelOkuh+H9KU1r7pzOocWhEdihUp53GEzgWmMHwWjtzwBiXAB+rhFBxlzLpCJ+tnLI6bKVb7rucv/QUxj8LV/jCmP2mockDwb+q8j8X5fEESrOs8+2MLWE46TiadmRu4hEDEaAXIa8W49cwCW6V34Jr1awUZHADZlydt8u2b1j
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2026 14:31:04.9944 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c877ceb-d006-4624-b015-08de98a0211e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A78F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9419
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

Stop reaching into other components' registers directly and route those
operations through the component that owns them.

Move the timestamp/coherency helpers into panthor_gpu, add a doorbell
helper, and update call sites accordingly. This keeps register knowledge
local to each block and avoids spreading cross-component register
accesses across the driver.

This is a preparatory cleanup for using per-component iomem bases.

v2:
- Fix incorrect spelling of timestamp helpers
- Fix unintended trailing backslash

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_device.c | 27 ----------------
 drivers/gpu/drm/panthor/panthor_drv.c    |  7 ++---
 drivers/gpu/drm/panthor/panthor_fw.c     | 13 +++++---
 drivers/gpu/drm/panthor/panthor_fw.h     |  1 +
 drivers/gpu/drm/panthor/panthor_gpu.c    | 40 ++++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_gpu.h    |  6 ++++
 drivers/gpu/drm/panthor/panthor_pwr.c    |  2 +-
 drivers/gpu/drm/panthor/panthor_sched.c  |  2 +-
 8 files changed, 61 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index f876b13492ae..bd417d6ae8c0 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -22,38 +22,11 @@
 #include "panthor_fw_regs.h"
 #include "panthor_gem.h"
 #include "panthor_gpu.h"
-#include "panthor_gpu_regs.h"
 #include "panthor_hw.h"
 #include "panthor_mmu.h"
 #include "panthor_pwr.h"
 #include "panthor_sched.h"
 
-static int panthor_gpu_coherency_init(struct panthor_device *ptdev)
-{
-	BUILD_BUG_ON(GPU_COHERENCY_NONE != DRM_PANTHOR_GPU_COHERENCY_NONE);
-	BUILD_BUG_ON(GPU_COHERENCY_ACE_LITE != DRM_PANTHOR_GPU_COHERENCY_ACE_LITE);
-	BUILD_BUG_ON(GPU_COHERENCY_ACE != DRM_PANTHOR_GPU_COHERENCY_ACE);
-
-	/* Start with no coherency, and update it if the device is flagged coherent. */
-	ptdev->gpu_info.selected_coherency = GPU_COHERENCY_NONE;
-	ptdev->coherent = device_get_dma_attr(ptdev->base.dev) == DEV_DMA_COHERENT;
-
-	if (!ptdev->coherent)
-		return 0;
-
-	/* Check if the ACE-Lite coherency protocol is actually supported by the GPU.
-	 * ACE protocol has never been supported for command stream frontend GPUs.
-	 */
-	if ((gpu_read(ptdev->iomem, GPU_COHERENCY_FEATURES) &
-		      GPU_COHERENCY_PROT_BIT(ACE_LITE))) {
-		ptdev->gpu_info.selected_coherency = GPU_COHERENCY_ACE_LITE;
-		return 0;
-	}
-
-	drm_err(&ptdev->base, "Coherency not supported by the device");
-	return -ENOTSUPP;
-}
-
 static int panthor_clk_init(struct panthor_device *ptdev)
 {
 	ptdev->clks.core = devm_clk_get(ptdev->base.dev, NULL);
diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index e63210b01e6e..66996c9147c2 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -34,7 +34,6 @@
 #include "panthor_fw.h"
 #include "panthor_gem.h"
 #include "panthor_gpu.h"
-#include "panthor_gpu_regs.h"
 #include "panthor_heap.h"
 #include "panthor_mmu.h"
 #include "panthor_sched.h"
@@ -839,7 +838,7 @@ static int panthor_query_timestamp_info(struct panthor_device *ptdev,
 	}
 
 	if (flags & DRM_PANTHOR_TIMESTAMP_GPU_OFFSET)
-		arg->timestamp_offset = gpu_read64(ptdev->iomem, GPU_TIMESTAMP_OFFSET);
+		arg->timestamp_offset = panthor_gpu_get_timestamp_offset(ptdev);
 	else
 		arg->timestamp_offset = 0;
 
@@ -854,7 +853,7 @@ static int panthor_query_timestamp_info(struct panthor_device *ptdev,
 		query_start_time = 0;
 
 	if (flags & DRM_PANTHOR_TIMESTAMP_GPU)
-		arg->current_timestamp = gpu_read64_counter(ptdev->iomem, GPU_TIMESTAMP);
+		arg->current_timestamp = panthor_gpu_get_timestamp(ptdev);
 	else
 		arg->current_timestamp = 0;
 
@@ -870,7 +869,7 @@ static int panthor_query_timestamp_info(struct panthor_device *ptdev,
 	}
 
 	if (flags & DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT)
-		arg->cycle_count = gpu_read64_counter(ptdev->iomem, GPU_CYCLE_COUNT);
+		arg->cycle_count = panthor_gpu_get_cycle_count(ptdev);
 	else
 		arg->cycle_count = 0;
 
diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 4704275b9c8f..4a0c23e987b6 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -1054,7 +1054,7 @@ static void panthor_fw_init_global_iface(struct panthor_device *ptdev)
 			       GLB_CFG_POWEROFF_TIMER |
 			       GLB_CFG_PROGRESS_TIMER);
 
-	gpu_write(ptdev->iomem, CSF_DOORBELL(CSF_GLB_DOORBELL_ID), 1);
+	panthor_fw_ring_doorbell(ptdev, CSF_GLB_DOORBELL_ID);
 
 	/* Kick the watchdog. */
 	mod_delayed_work(ptdev->reset.wq, &ptdev->fw->watchdog.ping_work,
@@ -1156,7 +1156,7 @@ static void panthor_fw_halt_mcu(struct panthor_device *ptdev)
 	else
 		panthor_fw_update_reqs(glb_iface, req, GLB_HALT, GLB_HALT);
 
-	gpu_write(ptdev->iomem, CSF_DOORBELL(CSF_GLB_DOORBELL_ID), 1);
+	panthor_fw_ring_doorbell(ptdev, CSF_GLB_DOORBELL_ID);
 }
 
 static bool panthor_fw_wait_mcu_halted(struct panthor_device *ptdev)
@@ -1400,6 +1400,11 @@ int panthor_fw_csg_wait_acks(struct panthor_device *ptdev, u32 csg_slot,
 	return ret;
 }
 
+void panthor_fw_ring_doorbell(struct panthor_device *ptdev, u32 doorbell_id)
+{
+	gpu_write(ptdev->iomem, CSF_DOORBELL(doorbell_id), 1);
+}
+
 /**
  * panthor_fw_ring_csg_doorbells() - Ring command stream group doorbells.
  * @ptdev: Device.
@@ -1414,7 +1419,7 @@ void panthor_fw_ring_csg_doorbells(struct panthor_device *ptdev, u32 csg_mask)
 	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
 
 	panthor_fw_toggle_reqs(glb_iface, doorbell_req, doorbell_ack, csg_mask);
-	gpu_write(ptdev->iomem, CSF_DOORBELL(CSF_GLB_DOORBELL_ID), 1);
+	panthor_fw_ring_doorbell(ptdev, CSF_GLB_DOORBELL_ID);
 }
 
 static void panthor_fw_ping_work(struct work_struct *work)
@@ -1429,7 +1434,7 @@ static void panthor_fw_ping_work(struct work_struct *work)
 		return;
 
 	panthor_fw_toggle_reqs(glb_iface, req, ack, GLB_PING);
-	gpu_write(ptdev->iomem, CSF_DOORBELL(CSF_GLB_DOORBELL_ID), 1);
+	panthor_fw_ring_doorbell(ptdev, CSF_GLB_DOORBELL_ID);
 
 	ret = panthor_fw_glb_wait_acks(ptdev, GLB_PING, &acked, 100);
 	if (ret) {
diff --git a/drivers/gpu/drm/panthor/panthor_fw.h b/drivers/gpu/drm/panthor/panthor_fw.h
index fbdc21469ba3..a99a9b6f4825 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.h
+++ b/drivers/gpu/drm/panthor/panthor_fw.h
@@ -500,6 +500,7 @@ int panthor_fw_csg_wait_acks(struct panthor_device *ptdev, u32 csg_id, u32 req_m
 int panthor_fw_glb_wait_acks(struct panthor_device *ptdev, u32 req_mask, u32 *acked,
 			     u32 timeout_ms);
 
+void panthor_fw_ring_doorbell(struct panthor_device *ptdev, u32 doorbell_id);
 void panthor_fw_ring_csg_doorbells(struct panthor_device *ptdev, u32 csg_slot);
 
 struct panthor_kernel_bo *
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index fecc30747acf..747ac332be64 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -427,3 +427,43 @@ void panthor_gpu_resume(struct panthor_device *ptdev)
 	panthor_hw_l2_power_on(ptdev);
 }
 
+u64 panthor_gpu_get_timestamp(struct panthor_device *ptdev)
+{
+	return gpu_read64_counter(ptdev->iomem, GPU_TIMESTAMP);
+}
+
+u64 panthor_gpu_get_timestamp_offset(struct panthor_device *ptdev)
+{
+	return gpu_read64(ptdev->iomem, GPU_TIMESTAMP_OFFSET);
+}
+
+u64 panthor_gpu_get_cycle_count(struct panthor_device *ptdev)
+{
+	return gpu_read64_counter(ptdev->iomem, GPU_CYCLE_COUNT);
+}
+
+int panthor_gpu_coherency_init(struct panthor_device *ptdev)
+{
+	BUILD_BUG_ON(GPU_COHERENCY_NONE != DRM_PANTHOR_GPU_COHERENCY_NONE);
+	BUILD_BUG_ON(GPU_COHERENCY_ACE_LITE != DRM_PANTHOR_GPU_COHERENCY_ACE_LITE);
+	BUILD_BUG_ON(GPU_COHERENCY_ACE != DRM_PANTHOR_GPU_COHERENCY_ACE);
+
+	/* Start with no coherency, and update it if the device is flagged coherent. */
+	ptdev->gpu_info.selected_coherency = GPU_COHERENCY_NONE;
+	ptdev->coherent = device_get_dma_attr(ptdev->base.dev) == DEV_DMA_COHERENT;
+
+	if (!ptdev->coherent)
+		return 0;
+
+	/* Check if the ACE-Lite coherency protocol is actually supported by the GPU.
+	 * ACE protocol has never been supported for command stream frontend GPUs.
+	 */
+	if ((gpu_read(ptdev->iomem, GPU_COHERENCY_FEATURES) &
+		      GPU_COHERENCY_PROT_BIT(ACE_LITE))) {
+		ptdev->gpu_info.selected_coherency = GPU_COHERENCY_ACE_LITE;
+		return 0;
+	}
+
+	drm_err(&ptdev->base, "Coherency not supported by the device");
+	return -ENOTSUPP;
+}
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.h b/drivers/gpu/drm/panthor/panthor_gpu.h
index 12c263a39928..f615feb05609 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.h
+++ b/drivers/gpu/drm/panthor/panthor_gpu.h
@@ -54,4 +54,10 @@ int panthor_gpu_soft_reset(struct panthor_device *ptdev);
 void panthor_gpu_power_changed_off(struct panthor_device *ptdev);
 int panthor_gpu_power_changed_on(struct panthor_device *ptdev);
 
+u64 panthor_gpu_get_timestamp(struct panthor_device *ptdev);
+u64 panthor_gpu_get_timestamp_offset(struct panthor_device *ptdev);
+u64 panthor_gpu_get_cycle_count(struct panthor_device *ptdev);
+
+int panthor_gpu_coherency_init(struct panthor_device *ptdev);
+
 #endif
diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
index 306592ff2227..aafb0c5c7d23 100644
--- a/drivers/gpu/drm/panthor/panthor_pwr.c
+++ b/drivers/gpu/drm/panthor/panthor_pwr.c
@@ -199,7 +199,7 @@ static int panthor_pwr_domain_wait_transition(struct panthor_device *ptdev, u32
 
 static void panthor_pwr_debug_info_show(struct panthor_device *ptdev)
 {
-	drm_info(&ptdev->base, "GPU_FEATURES:    0x%016llx", gpu_read64(ptdev->iomem, GPU_FEATURES));
+	drm_info(&ptdev->base, "GPU_FEATURES:    0x%016llx", ptdev->gpu_info.gpu_features);
 	drm_info(&ptdev->base, "PWR_STATUS:      0x%016llx", gpu_read64(ptdev->iomem, PWR_STATUS));
 	drm_info(&ptdev->base, "L2_PRESENT:      0x%016llx", gpu_read64(ptdev->iomem, PWR_L2_PRESENT));
 	drm_info(&ptdev->base, "L2_PWRTRANS:     0x%016llx", gpu_read64(ptdev->iomem, PWR_L2_PWRTRANS));
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 70b8a22b3ed7..60e7b4e20a13 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -3373,7 +3373,7 @@ queue_run_job(struct drm_sched_job *sched_job)
 		if (resume_tick)
 			sched_resume_tick(ptdev);
 
-		gpu_write(ptdev->iomem, CSF_DOORBELL(queue->doorbell_id), 1);
+		panthor_fw_ring_doorbell(ptdev, queue->doorbell_id);
 		if (!sched->pm.has_ref &&
 		    !(group->blocked_queues & BIT(job->queue_idx))) {
 			pm_runtime_get(ptdev->base.dev);
-- 
2.43.0

