Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB6BE937E3
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 14:31:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34A5C10E2C5;
	Sun, 12 Apr 2026 14:31:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="c+infyzx";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="c+infyzx";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013067.outbound.protection.outlook.com
 [52.101.83.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D277310E2C7
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 14:31:14 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ai01MaaOnfxIbj8nZFqOB8ii/6CEbOOm2bkjbJ3BITahYj8NiV9ui0IVSW2eA/TkG9D0tjRl+dOObuXdJnSInr/ea0Il6+80wfNTxBxBZ4Zp8n99OhkYddTVUtajjXvamEjl25uft8+kyWfDOQzEQ0GzDHPC32nEndJbX5gRQUCfQWYVqzylyT/M9CjYejIJMrGblg1DWkGAy9IwyxE4y5ly15EQfL7IxYh9kHzWqCxN8Uu4biSBm365jhz5+jb8g6HXYCUHKkdU88k5v1X9WPUNLuA3Z7Cvwfeh7Tia3psTJEsfgPfwconI60HMR818QDwfiqJzIaSN7s6kYAN+OQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/53Kp7pKbIhn7K5g6ri0rdUK1vbnEHQ5CwWG+nNPfQs=;
 b=AFQPCAfp7HboQA93eNddXIIfy2Ra8ZUMGDcybSinC4VJoXLns5U1BaOhuvb4am4KXDJF3OPceJpVtzbWbuwA5QRWls+q6l43CMVL+zw+tHV6MNSFJX2nBK6YG06W+8sI5CC9w3R6ui2COE7zBpk2G6TIkPshNqHcDyO2MypPgbDdKiIzqsJuA/2UqtFGKNJeMx542pWWHWZbUdQmhzLIvAFEFabNNkUN2HaCDIVvQSjHk2OvKJhPYCTGAQTgrJ0aSRQW2HjHbvE5InWJwUgaQ7KoXtY0sV6qwiJoHvJnpoG6EbaRy/BEiqs9lnt8OY+9tN3tkFKDyWn2xyx7+AQk2w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/53Kp7pKbIhn7K5g6ri0rdUK1vbnEHQ5CwWG+nNPfQs=;
 b=c+infyzxx+rOmo9xfTEL+1CsymtSSF5f3IS11WYI+yXjcVFm5bVFx1PeeFAmtfeVFK31GpLMGwuqB8tTed9/lPdqWZlhDdyBBvF1gUPJgdxcFd2Ad6LXVsG6jMhoYgDb2R/klNsPW5K0bRw40HknjQk3rbuipdomXUtuemzBKNg=
Received: from DU2P251CA0021.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::24)
 by PAWPR08MB9637.eurprd08.prod.outlook.com (2603:10a6:102:2e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Sun, 12 Apr
 2026 14:31:07 +0000
Received: from DU6PEPF00009527.eurprd02.prod.outlook.com
 (2603:10a6:10:230:cafe::17) by DU2P251CA0021.outlook.office365.com
 (2603:10a6:10:230::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.47 via Frontend Transport; Sun,
 12 Apr 2026 14:31:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF00009527.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17 via
 Frontend Transport; Sun, 12 Apr 2026 14:31:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6boD1UIH4uawambj0hftHsQN+te2iseYvPgzyopTvR38OO9dZ4Hk0cs69NRXT9E1sMvA/+nrI5iFR+gySIk+AmkstjKtAQTFP/1NRzBcCWeAlPQb6x821ponRRmz2gdWtFhwegPftNYHiNH49K1o0YUH6ZYuLQriOf4G/1GCMCF1T3srHELJoRzYRVD6BhMmuTwVTrUMENdVuATc7Oqiyw82cgXFSrUxI3VAkjhyiAQUn5yCy6YrsikPp6pYf0g4T2rf/l4OOHT7cvHQv40HjVLM5F5pLgvtQHdUj5y/IBiw8brpEAA4GciJWTB+Helm2KJQ0hTcgu+hn6VcpI8Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/53Kp7pKbIhn7K5g6ri0rdUK1vbnEHQ5CwWG+nNPfQs=;
 b=s31QEsMEsfFz9dLb2H1OqnDREX+lKCT/xE438L/lqmbMZxTyfruaLc8EJcQSanbPA7KBJFS2x4+TERMG/cCMb/QFv1tp6rWEMWSe7B1IjfJ4y/1/7EZqDEYM3WYc5JGhn3cvd8YVwyhSzrND+oj+KkLWnDBEXe630P41sDxDtgixs4PO93g7zCDpATyjUeoiNqxCm+aqoDmzRoV39KmSye9SnaLemkQjnhudPFo1rDouFjg9/HsYPVOVlZh+5BQ2vy0jrz8ztFNTe7T8hxLw/weOyLirla8nvjJFneg4VPx/GcJaVTdILdA2qpux08elfzc34B4RUFEe8osZMAMtvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/53Kp7pKbIhn7K5g6ri0rdUK1vbnEHQ5CwWG+nNPfQs=;
 b=c+infyzxx+rOmo9xfTEL+1CsymtSSF5f3IS11WYI+yXjcVFm5bVFx1PeeFAmtfeVFK31GpLMGwuqB8tTed9/lPdqWZlhDdyBBvF1gUPJgdxcFd2Ad6LXVsG6jMhoYgDb2R/klNsPW5K0bRw40HknjQk3rbuipdomXUtuemzBKNg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DB9PR08MB6556.eurprd08.prod.outlook.com
 (2603:10a6:10:261::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Sun, 12 Apr
 2026 14:30:05 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%6]) with mapi id 15.20.9769.046; Sun, 12 Apr 2026
 14:30:05 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] drm/panthor: Use a local iomem base for GPU registers
Date: Sun, 12 Apr 2026 15:29:48 +0100
Message-ID: <20260412142951.2309135-6-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260412142951.2309135-1-karunika.choo@arm.com>
References: <20260412142951.2309135-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0450.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:398::9) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DB9PR08MB6556:EE_|DU6PEPF00009527:EE_|PAWPR08MB9637:EE_
X-MS-Office365-Filtering-Correlation-Id: ffd12fbb-5db8-4d28-cfce-08de98a0226b
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info-Original: UlWBnbjdbbIfjeRxapcXD640jpt3rHbSmGf4lzp9pFdne4WwDiyN5+QhVrfbknRbNrwcha5SQGYw9QRdNvPORBqGPIw1dTP5mRMGuIRrrMaq17fuqToRW2pA1WI8J6e+oFv0m5bX8p4CgCb+DrAViogjmdzMvDaJmNmmzKl97ceTJZUMxSOMz2LlBMqvskoaKs3JQvrCKmPCI6JqEsGMCvBZzgotZB0Q/Q/hXsHYuyQq+8fZLG/fkSEXa0tAq/QLqQkxLTpvkeH2LmIonJ3js6cUDdtgZp6U6YgA4RUvFAwDHNcMmY8fVfi6A+QPKPS5u4/lfvg3VmYsihtMgzduIaed6ipZlWQm1T4YHdcXaJ7764htPXNuhmubanaPBO2IPNFLybs1YX06uOBnvkyCFPVbXPgJXStQhR56o/O3StEV8H1VDEUT1EAVvWlg6WrssshgFsKEnTtkJq2ss5ZzfTOfxluCqoKLPcJ0KNfLv/t3mqzrMWwUIcL64NdyeznGxx3rI9pCI5j3otNksVLDBllJqLUTtxxZ64r6naQ5d3mMpyxN7gmQkxAQbqaAGMG0zQ40ujRnbCE1A5nCk6ciGLy8ZPz8zcpiQEKHW6tfftwiSetZR0Us3lHJy5c2xfCi4HCKm5osmrQgP8BP1VOT0SPQVV5nL5e+ELppYZNNznlOsW2f+tKXGZU6b89JB4ludXLtqXkkg/wLICqFx38b0ru4dcrq58F+Eq3wvg4ha4o=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: giMcK24qQmRydYqUvlYzxvDguf81d1DD3P8CeCJeVqBtOepB2b4dog2MsxRs6QWfAv+zD9jtrYMAFyKfTCguCUXeZiq2ohzmJSjQtChjJjJ26txiMFhFG31IzRu391SpBNZ5zX+oA2ibQsDYngpaWXv3D+2HMpHqa356khpUw3tjUwaNWyPEtWAZMnJa9JJQeOfj3ppK0rtDAOBFaxSf9WWuIe3CpZRb8nIEIOrwAZQaXGwB428kMuxue9UTaaKoYN5bLZlOL7I7gghkFLREvBvNtUAuSW+2AJPfmrw6kMWFPXMqAEQvjC1mSpNgeDxxyCfi53JQhIFWvx/vgbg2vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6556
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF00009527.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e9ac5ef5-3852-4718-d91e-08de989ffd4d
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|35042699022|14060799003|376014|82310400026|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: eXzVtq7HHlpxz8I21tRm058anPIMkdVZxDdMY7x6atIR0wp/qNgcJRRxrV6qmnj0545ThneMEGtsU0ff7/hcbnbbyE+Wqy7r/rjwloKmXWOAox/75rpO5nUAp27ZqeIzV+hwb4y8WsVoPklWihA/ogx+kyg4BYm8ibomv1JDVN+HonJzgziGW44g+7CCzez5EMagEsTletZXhxEDQXJd7qNfjv5Tggaexc4p9IhKkWMUH9T6YEnPBheYTkU/7bWdvb9N+qHy2i+NvhhbplljA/wSKomUu5iQgcfwoN2cl+9pU/rZGBjsoufGwfTX4p3dr/rUIAHltUqSQB/ENsmzmpR9yR+arcSUaW3LBo9XK7nmxfH+05fcqrS2mrzdd6EN/TqB+5vnfKOtTuOwWuOVIm9JhJuZbmwCbEkiDoxOzmDMzskQo6CioJjbzfWXS3lxQBz3B2DPwWGqw8t5bJ4tl3pSq+N0CwUAADQVMhoruOeqOMKXnFTi2M7qmsWpbvkCxO84/j7c9MYJn8CEaIwnR24c78HydC2EmG/A9tLyzhNzyVRRbRxxsdAsDWiMu1C4EY+GBzFvZHvW9YqwibbyPbm/P9T0Ohd7GFY9Q6hOS5aaQLlok11oam42Twena8Ra4BYJbyhVJ6ucdD04gguCmnV4yttDLl4EUaD6nUiBPhbb96866qXpBRURkOW8ugGKskhd7Iyf7+TGhX16LtH5d8dyVu4K7uhyPfeuZpUmzqrz/7s/zcEmSinacAtcgdv0
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(35042699022)(14060799003)(376014)(82310400026)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /nyuTURn4MRy0h7+LioeITtRprhpOh4edF5eD9KIv+lnee3MGDAVr0ilS+Wqs73JnR03FfQMfzaEybWk3+1v2EdmC1dwBqboVAHb57Z9kxeoTlcrBvxG3T4WrwnwNW+dfpJ/9PCK8sosEzitel/tS2i2Lo+z6IkAGYeBfz+Wl1H8trSw5GKBQtNK7X8/H+Zt/m6myilACfzsFLh0JOD2prMkOYXRrCK3TVsq80VrmUvXevF6rU112ZSgXgcpisKG2OT2oVhctc/xSpcRxzAoRhttiCBM+DYz3zmLgPeIQA8bdodJaGnIBOuETjWhL517H1DqDOypX/flcFp8NzardqtfXKfS5pWQAupV+S/cropYxEZ/0GEu2j5c5v9uhResI/PHU6GaioPvNGh1b0TKVDcwm+/8k0lf7o6GxcHkmd0KOri+X9jdtRb9uHuQhinz
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2026 14:31:07.1786 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd12fbb-5db8-4d28-cfce-08de98a0226b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009527.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9637
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
to use the IRQ-local base provided by the common IRQ helpers. Update
panthor_gpu_info_init() to also use a local iomem offset for GPU
features and capability.

This is a refactoring only and does not change behaviour.

v2:
- Update panthor_gpu_info_init() to use block-local iomem pointer.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_gpu.c      | 61 +++++++++++++---------
 drivers/gpu/drm/panthor/panthor_gpu_regs.h |  4 --
 drivers/gpu/drm/panthor/panthor_hw.c       | 38 +++++++-------
 3 files changed, 56 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index f00f3d9be240..e52c5675981f 100644
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
@@ -203,10 +210,11 @@ int panthor_gpu_block_power_off(struct panthor_device *ptdev,
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
@@ -215,9 +223,9 @@ int panthor_gpu_block_power_off(struct panthor_device *ptdev,
 		return ret;
 	}
 
-	gpu_write64(ptdev->iomem, pwroff_reg, mask);
+	gpu_write64(gpu->iomem, pwroff_reg, mask);
 
-	ret = gpu_read64_relaxed_poll_timeout(ptdev->iomem, pwrtrans_reg, val,
+	ret = gpu_read64_relaxed_poll_timeout(gpu->iomem, pwrtrans_reg, val,
 					      !(mask & val), 100, timeout_us);
 	if (ret) {
 		drm_err(&ptdev->base,
@@ -246,10 +254,11 @@ int panthor_gpu_block_power_on(struct panthor_device *ptdev,
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
@@ -258,9 +267,9 @@ int panthor_gpu_block_power_on(struct panthor_device *ptdev,
 		return ret;
 	}
 
-	gpu_write64(ptdev->iomem, pwron_reg, mask);
+	gpu_write64(gpu->iomem, pwron_reg, mask);
 
-	ret = gpu_read64_relaxed_poll_timeout(ptdev->iomem, rdy_reg, val,
+	ret = gpu_read64_relaxed_poll_timeout(gpu->iomem, rdy_reg, val,
 					      (mask & val) == val,
 					      100, timeout_us);
 	if (ret) {
@@ -319,6 +328,7 @@ int panthor_gpu_l2_power_on(struct panthor_device *ptdev)
 int panthor_gpu_flush_caches(struct panthor_device *ptdev,
 			     u32 l2, u32 lsc, u32 other)
 {
+	struct panthor_gpu *gpu = ptdev->gpu;
 	unsigned long flags;
 	int ret = 0;
 
@@ -328,7 +338,7 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
 	spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
 	if (!(ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED)) {
 		ptdev->gpu->pending_reqs |= GPU_IRQ_CLEAN_CACHES_COMPLETED;
-		gpu_write(ptdev->iomem, GPU_CMD, GPU_FLUSH_CACHES(l2, lsc, other));
+		gpu_write(gpu->iomem, GPU_CMD, GPU_FLUSH_CACHES(l2, lsc, other));
 	} else {
 		ret = -EIO;
 	}
@@ -342,7 +352,7 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
 				msecs_to_jiffies(100))) {
 		spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
 		if ((ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED) != 0 &&
-		    !(gpu_read(ptdev->iomem, GPU_INT_RAWSTAT) & GPU_IRQ_CLEAN_CACHES_COMPLETED))
+		    !(gpu_read(gpu->irq.iomem, INT_RAWSTAT) & GPU_IRQ_CLEAN_CACHES_COMPLETED))
 			ret = -ETIMEDOUT;
 		else
 			ptdev->gpu->pending_reqs &= ~GPU_IRQ_CLEAN_CACHES_COMPLETED;
@@ -365,6 +375,7 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
  */
 int panthor_gpu_soft_reset(struct panthor_device *ptdev)
 {
+	struct panthor_gpu *gpu = ptdev->gpu;
 	bool timedout = false;
 	unsigned long flags;
 
@@ -372,8 +383,8 @@ int panthor_gpu_soft_reset(struct panthor_device *ptdev)
 	if (!drm_WARN_ON(&ptdev->base,
 			 ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED)) {
 		ptdev->gpu->pending_reqs |= GPU_IRQ_RESET_COMPLETED;
-		gpu_write(ptdev->iomem, GPU_INT_CLEAR, GPU_IRQ_RESET_COMPLETED);
-		gpu_write(ptdev->iomem, GPU_CMD, GPU_SOFT_RESET);
+		gpu_write(gpu->irq.iomem, INT_CLEAR, GPU_IRQ_RESET_COMPLETED);
+		gpu_write(gpu->iomem, GPU_CMD, GPU_SOFT_RESET);
 	}
 	spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
 
@@ -382,7 +393,7 @@ int panthor_gpu_soft_reset(struct panthor_device *ptdev)
 				msecs_to_jiffies(100))) {
 		spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
 		if ((ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED) != 0 &&
-		    !(gpu_read(ptdev->iomem, GPU_INT_RAWSTAT) & GPU_IRQ_RESET_COMPLETED))
+		    !(gpu_read(gpu->irq.iomem, INT_RAWSTAT) & GPU_IRQ_RESET_COMPLETED))
 			timedout = true;
 		else
 			ptdev->gpu->pending_reqs &= ~GPU_IRQ_RESET_COMPLETED;
@@ -431,17 +442,17 @@ void panthor_gpu_resume(struct panthor_device *ptdev)
 
 u64 panthor_gpu_get_timestamp(struct panthor_device *ptdev)
 {
-	return gpu_read64_counter(ptdev->iomem, GPU_TIMESTAMP);
+	return gpu_read64_counter(ptdev->gpu->iomem, GPU_TIMESTAMP);
 }
 
 u64 panthor_gpu_get_timestamp_offset(struct panthor_device *ptdev)
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
@@ -460,7 +471,7 @@ int panthor_gpu_coherency_init(struct panthor_device *ptdev)
 	/* Check if the ACE-Lite coherency protocol is actually supported by the GPU.
 	 * ACE protocol has never been supported for command stream frontend GPUs.
 	 */
-	if ((gpu_read(ptdev->iomem, GPU_COHERENCY_FEATURES) &
+	if ((gpu_read(ptdev->gpu->iomem, GPU_COHERENCY_FEATURES) &
 		      GPU_COHERENCY_PROT_BIT(ACE_LITE))) {
 		ptdev->gpu_info.selected_coherency = GPU_COHERENCY_ACE_LITE;
 		return 0;
diff --git a/drivers/gpu/drm/panthor/panthor_gpu_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
index 3f60c45985a7..4c5b953796e4 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
@@ -31,10 +31,6 @@
 #define GPU_CSF_ID					0x1C
 
 #define GPU_INT_BASE					0x20
-#define GPU_INT_RAWSTAT					0x20
-#define GPU_INT_CLEAR					0x24
-#define GPU_INT_MASK					0x28
-#define GPU_INT_STAT					0x2c
 #define   GPU_IRQ_FAULT					BIT(0)
 #define   GPU_IRQ_PROTM_FAULT				BIT(1)
 #define   GPU_IRQ_RESET_COMPLETED			BIT(8)
diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index 9431f16d950f..80aa151d5936 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -195,28 +195,30 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)
 {
 	unsigned int i;
 
-	ptdev->gpu_info.csf_id = gpu_read(ptdev->iomem, GPU_CSF_ID);
-	ptdev->gpu_info.gpu_rev = gpu_read(ptdev->iomem, GPU_REVID);
-	ptdev->gpu_info.core_features = gpu_read(ptdev->iomem, GPU_CORE_FEATURES);
-	ptdev->gpu_info.l2_features = gpu_read(ptdev->iomem, GPU_L2_FEATURES);
-	ptdev->gpu_info.tiler_features = gpu_read(ptdev->iomem, GPU_TILER_FEATURES);
-	ptdev->gpu_info.mem_features = gpu_read(ptdev->iomem, GPU_MEM_FEATURES);
-	ptdev->gpu_info.mmu_features = gpu_read(ptdev->iomem, GPU_MMU_FEATURES);
-	ptdev->gpu_info.thread_features = gpu_read(ptdev->iomem, GPU_THREAD_FEATURES);
-	ptdev->gpu_info.max_threads = gpu_read(ptdev->iomem, GPU_THREAD_MAX_THREADS);
+	void __iomem *gpu_iomem = ptdev->iomem + GPU_CONTROL_BASE;
+
+	ptdev->gpu_info.csf_id = gpu_read(gpu_iomem, GPU_CSF_ID);
+	ptdev->gpu_info.gpu_rev = gpu_read(gpu_iomem, GPU_REVID);
+	ptdev->gpu_info.core_features = gpu_read(gpu_iomem, GPU_CORE_FEATURES);
+	ptdev->gpu_info.l2_features = gpu_read(gpu_iomem, GPU_L2_FEATURES);
+	ptdev->gpu_info.tiler_features = gpu_read(gpu_iomem, GPU_TILER_FEATURES);
+	ptdev->gpu_info.mem_features = gpu_read(gpu_iomem, GPU_MEM_FEATURES);
+	ptdev->gpu_info.mmu_features = gpu_read(gpu_iomem, GPU_MMU_FEATURES);
+	ptdev->gpu_info.thread_features = gpu_read(gpu_iomem, GPU_THREAD_FEATURES);
+	ptdev->gpu_info.max_threads = gpu_read(gpu_iomem, GPU_THREAD_MAX_THREADS);
 	ptdev->gpu_info.thread_max_workgroup_size =
-		gpu_read(ptdev->iomem, GPU_THREAD_MAX_WORKGROUP_SIZE);
+		gpu_read(gpu_iomem, GPU_THREAD_MAX_WORKGROUP_SIZE);
 	ptdev->gpu_info.thread_max_barrier_size =
-		gpu_read(ptdev->iomem, GPU_THREAD_MAX_BARRIER_SIZE);
-	ptdev->gpu_info.coherency_features = gpu_read(ptdev->iomem, GPU_COHERENCY_FEATURES);
+		gpu_read(gpu_iomem, GPU_THREAD_MAX_BARRIER_SIZE);
+	ptdev->gpu_info.coherency_features = gpu_read(gpu_iomem, GPU_COHERENCY_FEATURES);
 	for (i = 0; i < 4; i++)
 		ptdev->gpu_info.texture_features[i] =
-			gpu_read(ptdev->iomem, GPU_TEXTURE_FEATURES(i));
+			gpu_read(gpu_iomem, GPU_TEXTURE_FEATURES(i));
 
-	ptdev->gpu_info.as_present = gpu_read(ptdev->iomem, GPU_AS_PRESENT);
+	ptdev->gpu_info.as_present = gpu_read(gpu_iomem, GPU_AS_PRESENT);
 
 	/* Introduced in arch 11.x */
-	ptdev->gpu_info.gpu_features = gpu_read64(ptdev->iomem, GPU_FEATURES);
+	ptdev->gpu_info.gpu_features = gpu_read64(gpu_iomem, GPU_FEATURES);
 
 	if (panthor_hw_has_pwr_ctrl(ptdev)) {
 		/* Introduced in arch 14.x */
@@ -224,9 +226,9 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)
 		ptdev->gpu_info.tiler_present = gpu_read64(ptdev->iomem, PWR_TILER_PRESENT);
 		ptdev->gpu_info.shader_present = gpu_read64(ptdev->iomem, PWR_SHADER_PRESENT);
 	} else {
-		ptdev->gpu_info.shader_present = gpu_read64(ptdev->iomem, GPU_SHADER_PRESENT);
-		ptdev->gpu_info.tiler_present = gpu_read64(ptdev->iomem, GPU_TILER_PRESENT);
-		ptdev->gpu_info.l2_present = gpu_read64(ptdev->iomem, GPU_L2_PRESENT);
+		ptdev->gpu_info.shader_present = gpu_read64(gpu_iomem, GPU_SHADER_PRESENT);
+		ptdev->gpu_info.tiler_present = gpu_read64(gpu_iomem, GPU_TILER_PRESENT);
+		ptdev->gpu_info.l2_present = gpu_read64(gpu_iomem, GPU_L2_PRESENT);
 	}
 
 	return overload_shader_present(ptdev);
-- 
2.43.0

