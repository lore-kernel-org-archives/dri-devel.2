Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9BBF459F7
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 16:48:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A98A10E9BA;
	Fri, 10 Apr 2026 16:48:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="MUJe92vL";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MUJe92vL";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013065.outbound.protection.outlook.com
 [40.107.162.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07D1A10E9BE
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 16:48:02 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=mO2kJD4QvFjWBgnYLlW4R//G4ZyySPxEpGs/5X31VRuuaxXA2yppaHBW+O26uz/l0YrD7e2I5o+O8cLfYtdHSwmSHRQ7VloVNn9xo/Er4BZk1ogGF2Ws/nhYnTfWRici0GTaacili4gze/7slq/BDRsqxJ6DblKxWdYWjMM42IJ5U2NJ/S0V07PTKRANE7DT+JyoJ5kAwLAAPoXv0ENuyUkN1Pz43nSXIYjCkbR3Asuo9v7egq/udQVUH/qsYPn+X8AMVLGX3gGNaKv0cDPlRKW4mVCvOGhvAAn2YPUKii/fTW0adgYrz9QC4F3NPs4VDx919fxeQcONZd0KwLKVBg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umjF7Ghi4oMvidkP76WW3i36pgvl5mDPJN6sO2rpafU=;
 b=HofjV/Ay2nGavPmbe4H2P+qVvyx4la56XMsuck8vIEZyxN1nrqCAzAWWVAf/tWu0QH6Wm/wTjZDC5zgLwPYRCOIQZjcOrkmSbl/RR0WNipXYIR6JNt7s7R+baRqjUUJo81dv0+LrsULz+4O77ifZG12EBZb7uCdEZS+4hF0WF1ixICZdANKhH9MszHLjwPAmEoUc61HhtBEGLmPJ5KyUAGMHZZxEnsWQiq9GRnKFUwkKRvOrWe9/0JOhRGy3UQv8k1gXHgeXUzL/W0OM6yfyH+gV+2xwHOvOYNJcLnc2TdocY9RTiW52I/LPQXRR4kCTANF0KFhwqPDD2klOHnE8pA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umjF7Ghi4oMvidkP76WW3i36pgvl5mDPJN6sO2rpafU=;
 b=MUJe92vLbJ6B2RfmXlg74zymg8t+ulrjvvu18dj6spSt0UQm/8aG9FUI8NDgx8DAFWZHG0vM3eFpe0voe0xFuwVFrYZAgrD2OaWrWnV2AkYfWJpZNrCpC/w5pSJsn3PBsW0pk/t7rpZgO4X/bBXZ05l3HLNeQhY33jhCUlgzKe4=
Received: from CWLP265CA0519.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18c::9)
 by DB9PR08MB10378.eurprd08.prod.outlook.com (2603:10a6:10:3da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.44; Fri, 10 Apr
 2026 16:47:56 +0000
Received: from AM2PEPF0001C714.eurprd05.prod.outlook.com
 (2603:10a6:400:18c:cafe::18) by CWLP265CA0519.outlook.office365.com
 (2603:10a6:400:18c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.43 via Frontend Transport; Fri,
 10 Apr 2026 16:47:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM2PEPF0001C714.mail.protection.outlook.com (10.167.16.184) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Fri, 10 Apr 2026 16:47:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ealeEYqCR0GnoSe+xG+hqHtMOIuGpH1G8xynpF2jpBNHFOS++mwM28NfCP/aZ9fJUbBFiMgGjw/L47COT0D5khuGTBSLIyPlrP972RoVEPqcTlPGKx8d/HCYBak4FRZ6OuViu77RP/+aM+JvWC2roxVYuYdWdsSvJ6MWhsq9NxGsNI6w63GhEbWVrsgPsI3TeniEJqmyJOkTvSs5tY8hFmUw/jRb8wlPIUiqYdDtL1kdyzvO/HYKdkZlJ1sEm6O4nuX5DbwdJNSHN1kBdU0b8GOhWlFjnt72FDZTmrB+3CWImz5rki58fggepeSnyZnH3O8jBNUA1gtftoqJaT0p3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umjF7Ghi4oMvidkP76WW3i36pgvl5mDPJN6sO2rpafU=;
 b=DfdbJBfR7lmMi8Sd6ucxn8A2a/f9N3FjyNsF5X//Um8R7RzlAtRD/En3GRkzxRlAEaEvZCHGrzTAVfNBOk5kuqJVfXbsha8YDvUMTipx7BVApMBpUEwt1wwsEsHC4FexnHmpj3cUhw3Ey9tcBdZ1+LN+aJoLVFwZkRcbcsVKcU2qbzriq4D7jjZR/CAVLWu3GF/ZcnI2ldaK3Jamnl2DR1sLKJGfvaeqfoNURWF97OAaR0SSAZYoS4hN/1fEbjOgcm+kIha8hkDkbJm9LsqVwxeKABCyjaUqGG/i7vEWrxtGzHqQWqXCiBQ/aovI5Wrqrgx60XskMcbk97wE/IapUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umjF7Ghi4oMvidkP76WW3i36pgvl5mDPJN6sO2rpafU=;
 b=MUJe92vLbJ6B2RfmXlg74zymg8t+ulrjvvu18dj6spSt0UQm/8aG9FUI8NDgx8DAFWZHG0vM3eFpe0voe0xFuwVFrYZAgrD2OaWrWnV2AkYfWJpZNrCpC/w5pSJsn3PBsW0pk/t7rpZgO4X/bBXZ05l3HLNeQhY33jhCUlgzKe4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by AS8PR08MB9624.eurprd08.prod.outlook.com
 (2603:10a6:20b:617::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 10 Apr
 2026 16:46:52 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%6]) with mapi id 15.20.9769.016; Fri, 10 Apr 2026
 16:46:48 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] drm/panthor: Use a local iomem base for GPU registers
Date: Fri, 10 Apr 2026 17:46:34 +0100
Message-ID: <20260410164637.549145-6-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410164637.549145-1-karunika.choo@arm.com>
References: <20260410164637.549145-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P265CA0005.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::13) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|AS8PR08MB9624:EE_|AM2PEPF0001C714:EE_|DB9PR08MB10378:EE_
X-MS-Office365-Filtering-Correlation-Id: 023304c5-990c-4b8e-f62a-08de9720ea4c
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info-Original: TkHPQEyRvzgl+fvt5wEufGxdA7b26pjNI+jnVG+mmJ/v9i/JDGUKPjzVYv0sPiYMv20dCCLjhvNc4lfFov/nlbW//IBZA3YtiZ6vSgJy2YCEgF1Dh3h+Q8UO/PUdRrri/iHPBKHIE1CKN5VQOAJvTW2t4ZIyR17KF7NxI8jr1FuvhkNPE3PYRSgbCtXKfw34zW0xmw3spobJ7SjYhl1tfaIBbS4O7cd2omIGp/sJimJrd+Nh0/mYJO7z/BtRHcsaZeV5yZRHz+mRCmUdQgqt6rFfFBF7tr+O6g2uq3CqblnCfQ66wz9aCjIcbyJrsOOjW2JrrSnpdOTFixWhOZYsSMHJCu/aig4d0H6zN1hQyrW+mxi3QjTXfKz+Vx5kvFAr1dkIcS8dAiomJPPRIWzPBgy8sw5mcoDPtawFA3lr0RuCL0t2KgsoqJ+bkYRfS0rUPmzzVfeT3ho503tuMChmK+xyLSw5zTQMmMUWqzS5MoEuJ7oUiWtHoeuL8RccVqdd1ExFdDyPQ+FXiv7pdAZ02d/XPa5RwWJU5+rGDBKG2aQVvtX9mWFZ8bbovYV/WVq9oq4YPEU94tU3T66PPpQqch4u/9GeGdhtX1IadG9uJSBJDV0WdZakVSA0CquHAVdloabj2ZpmcopGYzsbadEBP5KT3Nj4OJAlDcG5k/2BwRacaSYTblkS+1zm2z+0bTo8mnW65+h8+W8963oR31o/0JdtuXmZmHgM6FUhORx1/Tw=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: lzhTxWbVjjRWXdd0SVrd6MOTm2T420Ayj8Kk2a2o1ic1VOw62MDhz7fY99scNQ0+rgE4idYbX5Z86Mi1Ib8FWL/KQuzKUOEVkDEXzkX4w9nRinNXFoo8GBI0BovBxj5VHU+O5HBM0SFW0lpZrbo7KF0/QNL088VKqh8TDlCFNTpuKK9JW6S7dNNqRuQSb/7mF4/EX7YpflNLSUFVF9lTdgB841MGhC0p6dg1uf+JYWUBtD3lbrrLsS3vy8RYlyuTpVI2WHVkkkutO4UMZ20Py4q+4rorKm2JIGhXIPZoo+bbkrBwdJ3/tGJfZ9eYLhap8/D4PeVYQXYa2ae0oOAl2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9624
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM2PEPF0001C714.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0f698002-3318-4e37-4f9a-08de9720c1dd
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|1800799024|35042699022|82310400026|376014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: vvDKViLD5JyAJVOMdEMbrMpk0IjeKAgpAC5es6RWDTMmeGPsNGYUTIenPclRVPmaU8ra5pxKSkAFydxgJdUAkeGlaX87QThztJUOT4TlOzIuZdCd+GrOt6YjrPbuDiPR2s9efWYwOPiWrXIee+bajzm/qqvFbx+/Mg4OP6GmGc70c5pcCxBVo2JM/8qvz8CcHIR14IB42GgAXaxJocOYpeuW71JI4STB6qfFxOOF+eZuV731Jd8rp1eAvAVgBSdZ70Im6F3Zr5FzGDTtJE3L6kyXBoPqNRe0Nq8RSkJcv0vu3X99sDMugpOzMbJAiA0/aD36JaovJk9aqECNkAcI6bTYxiPsN+uzeikxZ/jJnZlS11tWQQKt3pzW37eUAt+ACB5Bl1bJDhlQW7XznLVQwGada4Vwl1qtOgvNyOMzvN+xs1X+YRKrZvFi8hWHlH5SuYAF4r7IgRfn7ZKeAawWr3cSVaOhH2SX8jrIGPG5D4gxzV3IJ4KfVk2kt/PjKs1lCCusClSwZuATYsCdh64h1L1FU0Q1wzVhgX9cPdPRRT+i8jyzsyT+w3IVtnr3C38kgBuIbsWm+hjms+QqGH2Qxumx9NCXIlnq0W6yn7BFWItrX6IWrRRMhP0OJEB4RipIt5IGGrSlOSSFjHHxNPuVgDfnZneeybB5n50Vn2OkdxrfGErj4j0ggfbFvjrxAyYkslKvIjQvDzhT0l2/e5sicrgXa5g7LwtaEGSj/CnsvlUhUEq5VtKeWhRR4VSrWwyH74QEMqibFZhqIjNaMz3lqg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(1800799024)(35042699022)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DB3w54y1ZQ0b+rsx/tdXCl7nUQHjESTYjCmmdkqca2Zw8nnLcOYFBC+Tl2R0GHIhMlmgi7BTBBitLVI25Xk51gXZF5MuaGMTit3ouUg6s2RMKsOqgAp6YJUoVKrU+I3KJB6VAyXEjOoUuyWvje1u132LVPjYTKYxMMQUU7FWaFpIB8gWHjESgFs9GhlH+LS75cJAVnnAsHozvGsENCiClaasf6r/9uBFiy8t+xOke6Dx3/+6R+1spbvmyUwVphyyJ7Jhz65WF9PlpuXR25Qc4H0pKuU1DS/ds/1hoKc8V93xx6b+W4lGrX8uDu/mgqNFbOtz6Gb8VEsZYriBOYqgY6CEWn6fCFDXky0vmLniVqELYKNAQ8Fu36QAIbpfiESsfN2lekP7zMXW5H4ZphpcCHo71ZkIa99r3eU5s1uzmw8D4cjzh855ceM2AN/Bwoko
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 16:47:55.7820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 023304c5-990c-4b8e-f62a-08de9720ea4c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C714.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB10378
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

Add a GPU_CONTROL-local iomem pointer to struct panthor_gpu and use it
for GPU register accesses.

This limits GPU register accesses to the GPU block instead of using the
device-wide MMIO mapping directly. Interrupt register accesses continue
to use the IRQ-local base provided by the common IRQ helpers.

This is a refactoring only and does not change behaviour.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_gpu.c      | 61 +++++++++++++---------
 drivers/gpu/drm/panthor/panthor_gpu_regs.h |  6 +--
 2 files changed, 38 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index 3ddce35ed8b5..abd94de5d15d 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -29,6 +29,9 @@
  * struct panthor_gpu - GPU block management data.
  */
 struct panthor_gpu {
+	/** @iomem: CPU mapping of GPU_CONTROL iomem region */
+	void __iomem *iomem;
+
 	/** @irq: GPU irq. */
 	struct panthor_irq irq;
 
@@ -56,12 +59,13 @@ struct panthor_gpu {
 
 static void panthor_gpu_coherency_set(struct panthor_device *ptdev)
 {
-	gpu_write(ptdev->iomem, GPU_COHERENCY_PROTOCOL,
+	gpu_write(ptdev->gpu->iomem, GPU_COHERENCY_PROTOCOL,
 		  ptdev->gpu_info.selected_coherency);
 }
 
 static void panthor_gpu_l2_config_set(struct panthor_device *ptdev)
 {
+	struct panthor_gpu *gpu = ptdev->gpu;
 	const struct panthor_soc_data *data = ptdev->soc_data;
 	u32 l2_config;
 	u32 i;
@@ -75,26 +79,28 @@ static void panthor_gpu_l2_config_set(struct panthor_device *ptdev)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(data->asn_hash); i++)
-		gpu_write(ptdev->iomem, GPU_ASN_HASH(i), data->asn_hash[i]);
+		gpu_write(gpu->iomem, GPU_ASN_HASH(i), data->asn_hash[i]);
 
-	l2_config = gpu_read(ptdev->iomem, GPU_L2_CONFIG);
+	l2_config = gpu_read(gpu->iomem, GPU_L2_CONFIG);
 	l2_config |= GPU_L2_CONFIG_ASN_HASH_ENABLE;
-	gpu_write(ptdev->iomem, GPU_L2_CONFIG, l2_config);
+	gpu_write(gpu->iomem, GPU_L2_CONFIG, l2_config);
 }
 
 static void panthor_gpu_irq_handler(struct panthor_device *ptdev, u32 status)
 {
-	gpu_write(ptdev->iomem, GPU_INT_CLEAR, status);
+	struct panthor_gpu *gpu = ptdev->gpu;
+
+	gpu_write(gpu->irq.iomem, INT_CLEAR, status);
 
 	if (tracepoint_enabled(gpu_power_status) && (status & GPU_POWER_INTERRUPTS_MASK))
 		trace_gpu_power_status(ptdev->base.dev,
-				       gpu_read64(ptdev->iomem, SHADER_READY),
-				       gpu_read64(ptdev->iomem, TILER_READY),
-				       gpu_read64(ptdev->iomem, L2_READY));
+				       gpu_read64(gpu->iomem, SHADER_READY),
+				       gpu_read64(gpu->iomem, TILER_READY),
+				       gpu_read64(gpu->iomem, L2_READY));
 
 	if (status & GPU_IRQ_FAULT) {
-		u32 fault_status = gpu_read(ptdev->iomem, GPU_FAULT_STATUS);
-		u64 address = gpu_read64(ptdev->iomem, GPU_FAULT_ADDR);
+		u32 fault_status = gpu_read(gpu->iomem, GPU_FAULT_STATUS);
+		u64 address = gpu_read64(gpu->iomem, GPU_FAULT_ADDR);
 
 		drm_warn(&ptdev->base, "GPU Fault 0x%08x (%s) at 0x%016llx\n",
 			 fault_status, panthor_exception_name(ptdev, fault_status & 0xFF),
@@ -147,6 +153,7 @@ int panthor_gpu_init(struct panthor_device *ptdev)
 	if (!gpu)
 		return -ENOMEM;
 
+	gpu->iomem = ptdev->iomem + GPU_CONTROL_BASE;
 	spin_lock_init(&gpu->reqs_lock);
 	init_waitqueue_head(&gpu->reqs_acked);
 	mutex_init(&gpu->cache_flush_lock);
@@ -202,10 +209,11 @@ int panthor_gpu_block_power_off(struct panthor_device *ptdev,
 				u32 pwroff_reg, u32 pwrtrans_reg,
 				u64 mask, u32 timeout_us)
 {
+	struct panthor_gpu *gpu = ptdev->gpu;
 	u32 val;
 	int ret;
 
-	ret = gpu_read64_relaxed_poll_timeout(ptdev->iomem, pwrtrans_reg, val,
+	ret = gpu_read64_relaxed_poll_timeout(gpu->iomem, pwrtrans_reg, val,
 					      !(mask & val), 100, timeout_us);
 	if (ret) {
 		drm_err(&ptdev->base,
@@ -214,9 +222,9 @@ int panthor_gpu_block_power_off(struct panthor_device *ptdev,
 		return ret;
 	}
 
-	gpu_write64(ptdev->iomem, pwroff_reg, mask);
+	gpu_write64(gpu->iomem, pwroff_reg, mask);
 
-	ret = gpu_read64_relaxed_poll_timeout(ptdev->iomem, pwrtrans_reg, val,
+	ret = gpu_read64_relaxed_poll_timeout(gpu->iomem, pwrtrans_reg, val,
 					      !(mask & val), 100, timeout_us);
 	if (ret) {
 		drm_err(&ptdev->base,
@@ -245,10 +253,11 @@ int panthor_gpu_block_power_on(struct panthor_device *ptdev,
 			       u32 pwron_reg, u32 pwrtrans_reg,
 			       u32 rdy_reg, u64 mask, u32 timeout_us)
 {
+	struct panthor_gpu *gpu = ptdev->gpu;
 	u32 val;
 	int ret;
 
-	ret = gpu_read64_relaxed_poll_timeout(ptdev->iomem, pwrtrans_reg, val,
+	ret = gpu_read64_relaxed_poll_timeout(gpu->iomem, pwrtrans_reg, val,
 					      !(mask & val), 100, timeout_us);
 	if (ret) {
 		drm_err(&ptdev->base,
@@ -257,9 +266,9 @@ int panthor_gpu_block_power_on(struct panthor_device *ptdev,
 		return ret;
 	}
 
-	gpu_write64(ptdev->iomem, pwron_reg, mask);
+	gpu_write64(gpu->iomem, pwron_reg, mask);
 
-	ret = gpu_read64_relaxed_poll_timeout(ptdev->iomem, rdy_reg, val,
+	ret = gpu_read64_relaxed_poll_timeout(gpu->iomem, rdy_reg, val,
 					      (mask & val) == val,
 					      100, timeout_us);
 	if (ret) {
@@ -318,6 +327,7 @@ int panthor_gpu_l2_power_on(struct panthor_device *ptdev)
 int panthor_gpu_flush_caches(struct panthor_device *ptdev,
 			     u32 l2, u32 lsc, u32 other)
 {
+	struct panthor_gpu *gpu = ptdev->gpu;
 	unsigned long flags;
 	int ret = 0;
 
@@ -327,7 +337,7 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
 	spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
 	if (!(ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED)) {
 		ptdev->gpu->pending_reqs |= GPU_IRQ_CLEAN_CACHES_COMPLETED;
-		gpu_write(ptdev->iomem, GPU_CMD, GPU_FLUSH_CACHES(l2, lsc, other));
+		gpu_write(gpu->iomem, GPU_CMD, GPU_FLUSH_CACHES(l2, lsc, other));
 	} else {
 		ret = -EIO;
 	}
@@ -341,7 +351,7 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
 				msecs_to_jiffies(100))) {
 		spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
 		if ((ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED) != 0 &&
-		    !(gpu_read(ptdev->iomem, GPU_INT_RAWSTAT) & GPU_IRQ_CLEAN_CACHES_COMPLETED))
+		    !(gpu_read(gpu->irq.iomem, INT_RAWSTAT) & GPU_IRQ_CLEAN_CACHES_COMPLETED))
 			ret = -ETIMEDOUT;
 		else
 			ptdev->gpu->pending_reqs &= ~GPU_IRQ_CLEAN_CACHES_COMPLETED;
@@ -364,6 +374,7 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
  */
 int panthor_gpu_soft_reset(struct panthor_device *ptdev)
 {
+	struct panthor_gpu *gpu = ptdev->gpu;
 	bool timedout = false;
 	unsigned long flags;
 
@@ -371,8 +382,8 @@ int panthor_gpu_soft_reset(struct panthor_device *ptdev)
 	if (!drm_WARN_ON(&ptdev->base,
 			 ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED)) {
 		ptdev->gpu->pending_reqs |= GPU_IRQ_RESET_COMPLETED;
-		gpu_write(ptdev->iomem, GPU_INT_CLEAR, GPU_IRQ_RESET_COMPLETED);
-		gpu_write(ptdev->iomem, GPU_CMD, GPU_SOFT_RESET);
+		gpu_write(gpu->irq.iomem, INT_CLEAR, GPU_IRQ_RESET_COMPLETED);
+		gpu_write(gpu->iomem, GPU_CMD, GPU_SOFT_RESET);
 	}
 	spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
 
@@ -381,7 +392,7 @@ int panthor_gpu_soft_reset(struct panthor_device *ptdev)
 				msecs_to_jiffies(100))) {
 		spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
 		if ((ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED) != 0 &&
-		    !(gpu_read(ptdev->iomem, GPU_INT_RAWSTAT) & GPU_IRQ_RESET_COMPLETED))
+		    !(gpu_read(gpu->irq.iomem, INT_RAWSTAT) & GPU_IRQ_RESET_COMPLETED))
 			timedout = true;
 		else
 			ptdev->gpu->pending_reqs &= ~GPU_IRQ_RESET_COMPLETED;
@@ -430,17 +441,17 @@ void panthor_gpu_resume(struct panthor_device *ptdev)
 
 u64 panthor_gpu_get_timestap(struct panthor_device *ptdev)
 {
-	return gpu_read64_counter(ptdev->iomem, GPU_TIMESTAMP);
+	return gpu_read64_counter(ptdev->gpu->iomem, GPU_TIMESTAMP);
 }
 
 u64 panthor_gpu_get_timestap_offset(struct panthor_device *ptdev)
 {
-	return gpu_read64(ptdev->iomem, GPU_TIMESTAMP_OFFSET);
+	return gpu_read64(ptdev->gpu->iomem, GPU_TIMESTAMP_OFFSET);
 }
 
 u64 panthor_gpu_get_cycle_count(struct panthor_device *ptdev)
 {
-	return gpu_read64_counter(ptdev->iomem, GPU_CYCLE_COUNT);
+	return gpu_read64_counter(ptdev->gpu->iomem, GPU_CYCLE_COUNT);
 }
 
 int panthor_gpu_coherency_init(struct panthor_device *ptdev)
@@ -459,7 +470,7 @@ int panthor_gpu_coherency_init(struct panthor_device *ptdev)
 	/* Check if the ACE-Lite coherency protocol is actually supported by the GPU.
 	 * ACE protocol has never been supported for command stream frontend GPUs.
 	 */
-	if ((gpu_read(ptdev->iomem, GPU_COHERENCY_FEATURES) &
+	if ((gpu_read(ptdev->gpu->iomem, GPU_COHERENCY_FEATURES) &
 		      GPU_COHERENCY_PROT_BIT(ACE_LITE))) {
 		ptdev->gpu_info.selected_coherency = GPU_COHERENCY_ACE_LITE;
 		return 0;
diff --git a/drivers/gpu/drm/panthor/panthor_gpu_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
index d7cf5165e987..f64e7661f765 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
@@ -4,6 +4,8 @@
 #ifndef __PANTHOR_GPU_REGS_H__
 #define __PANTHOR_GPU_REGS_H__
 
+#define GPU_CONTROL_BASE				0x0
+
 #define GPU_L2_FEATURES					0x4
 #define  GPU_L2_FEATURES_LINE_SIZE(x)			(1 << ((x) & GENMASK(7, 0)))
 
@@ -20,10 +22,6 @@
 #define GPU_CSF_ID					0x1C
 
 #define GPU_INT_BASE					0x20
-#define GPU_INT_RAWSTAT					0x20
-#define GPU_INT_CLEAR					0x24
-#define GPU_INT_MASK					0x28
-#define GPU_INT_STAT					0x2c
 #define   GPU_IRQ_FAULT					BIT(0)
 #define   GPU_IRQ_PROTM_FAULT				BIT(1)
 #define   GPU_IRQ_RESET_COMPLETED			BIT(8)
-- 
2.43.0

