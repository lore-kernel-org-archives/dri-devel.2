Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0FF8C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:48:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07B1010EE5F;
	Tue, 22 Sep 2026 20:48:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="TV2O0CIC";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TV2O0CIC";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013009.outbound.protection.outlook.com [52.101.72.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6817610EE5D
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:47:57 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=koJX6TUghNWxIwJIz3qzSzO7oD0beBP22ssnahK5oXVe9OvPw8OWKswKGhsvqymycD9rdgESleYbT0aRjrI5c3elYMkC/eSFRlNcbNEQfq9X8aDkIzcieZwL2i429iTBenUVUhbSFtiz+gylisXv+xmnRd42p7xlxNL8qTQUH8ldiSvXcuPRChG7lJ0ONCkhFC7YY7ZhQOyFUSrwKLsb+oO4T6bjeJqBFHL8H0LBklXL1VlFJKtJUQV4MTwIzMpd//nCVfvodmQ7vKO2ANWT2S8Q5SAecx2ro/SIQ94VX/pTpYRgLTUyjvdeVjYTjuCa7b5SKV0gW/wgSPSw39C6jw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72XUu9qvcNAiKJ34JJWY5us9GNWTuLBsPfjcSZWzwZw=;
 b=IxSHXBO0ssXktu73XpLBaiJe9C0TcMXS2vcGR2kyzgkxuIKUzDTmtY9txtuPflgbxem0jBVdKgXHTAF8Tg+bz60MG0o702dA3RGs+sBc3VUk8+e74gbXYlF80YB/JsPJuXmyG6AttQMCmKVvvsyJLNPT7at4dd08Y4YDk+AjG+I6Y8KJT90LPTrRvPccAzeMUukOg2JRzh24W3qhqvJwn0nLDAOXdCYxEtvwJtEQRbsMp8Ptb/okpuhbAwR9MJPt13KcGqZ57gZz7f4vrO57nBraEgD/7kiUrS8sEpfIykT0AxXN4pruP0FJiaiDqGmp1cPzMjmEWN9yn7WhzzLfrw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72XUu9qvcNAiKJ34JJWY5us9GNWTuLBsPfjcSZWzwZw=;
 b=TV2O0CICv2k0/dqqw6wq8osylF7fQ9TxM7LvLcnvf797bknPy3KsshUGsowGadYFYiUpT7NQXPH1BqtnthPZ4ZURsqqV+QIjOJ5BbugKFGesQc9W0PotqMh+0MU2wjM/bSXimjxouPlpf8E04jkjr0m3abftKG3Q23wrPUNyX88=
Received: from WA2P291CA0027.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1f::18)
 by MI9PR08MB384524.eurprd08.prod.outlook.com (2603:10a6:290:bd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 20:47:53 +0000
Received: from WA1PEPF000099CC.eurprd04.prod.outlook.com
 (2603:10a6:1d0:1f:cafe::3c) by WA2P291CA0027.outlook.office365.com
 (2603:10a6:1d0:1f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 20:47:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 WA1PEPF000099CC.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Tue, 22 Sep 2026 20:47:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ztla3sPigBJ6+Ecir9NFdXJ35QU8O3t7zfqcr3NeJU3sJy+QPuWv/ZTrbp1ef/sX0iikFNRtw7RjpRbra5KXGHJgfr1KC8ZzNJebO8tNIXda9hkZRxuFTMQ6/m4vPYGd7yDxa1SAn+4/M3AI4xNYgb2VYItZcyv+LeI0gShG7LI6ClmyaFvNW2NY4ToNxFd17yuNkf2Lcaj4iTy+wT2pnfYHOSwJVw62Oa7RyUaxB88o2nv3/eMSZZ6RpWTMbtI2OkCS/TdInDlhrMabawCGSnRZ2t9hlvHQ3bVai5PPTVKUFwxAVHPtPCZ/JSbjqOfRInLZ2F2W1kTVmCDjooFPTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72XUu9qvcNAiKJ34JJWY5us9GNWTuLBsPfjcSZWzwZw=;
 b=cEtFhUoNPiB4YnGq5dLr6GLqV0qRvkFKBKH51ZMmysn64hOoCdiduIo1ohe3NAL/ydi9Qtj67j7ft3QavX1GQzIv223xY0gzJqkhWXa7Dxxz+EBXPu/OPGH9m2f/Crdpp6pu/DaKPUh9WgVDkWIKWIVTDoLwDzCtMUh0BN4yCLHdjlM8r5XX1VpSjAiEovtwR/Wsn41e4qdisYuacz/AVqJbH+QwPywFcApSUQZerCAgVYtWoAGrMA2ASFx3acaTccwlenn+pyb5jPacJjo2Zaf5WdCN+cHMPpFcyHKAR5L51/dY2HWw2CG6ve8ZSRGKn8awcP7gN0PsEMd7K1rHvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72XUu9qvcNAiKJ34JJWY5us9GNWTuLBsPfjcSZWzwZw=;
 b=TV2O0CICv2k0/dqqw6wq8osylF7fQ9TxM7LvLcnvf797bknPy3KsshUGsowGadYFYiUpT7NQXPH1BqtnthPZ4ZURsqqV+QIjOJ5BbugKFGesQc9W0PotqMh+0MU2wjM/bSXimjxouPlpf8E04jkjr0m3abftKG3Q23wrPUNyX88=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by GV1PR08MB8743.eurprd08.prod.outlook.com
 (2603:10a6:150:87::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 20:47:20 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%3]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 20:47:20 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v1 21/27] drm/panthor: Request AW to yield GPU access on idle
Date: Tue, 22 Sep 2026 21:45:15 +0100
Message-ID: <20260922204535.2850094-22-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922204535.2850094-1-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0082.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:349::16) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|GV1PR08MB8743:EE_|WA1PEPF000099CC:EE_|MI9PR08MB384524:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e8088d1-b5d5-4e6e-6a49-08df18eac5b8
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original: 59zFqj8BqaT+xgP5Tx6UCCX2Pgvt3tjj4PwIYwVqYY4MvVrsEOfhHLYRAmr6FquTboEDOnr4lJpVWvzBU3uXf+BKkAk6KbRmB7B7p0oUrti1r+G2Wci6+xAnUE4JpcV6/QF5UoNw3G1wGtbxRN4UGdQVlJZKi77y46ZEt5z9aQ12MFtMGdbxD3ekMsdVUlQc2IMCfBwS//xUMD4DHccrTr0ciEaSDIm1cWPRnBhm/VjfXeZtmw8h982lLAoFn6EXaib7yIEH2zC9E7ayBnA2+k2RYFZpK8AtW0GK7M8BTjperAnTBAVDQoUYPCTr6mb+GJ3dFvat6grnLHH+/9M+Kyp7XMRgubzYJhfYzRYYk0Bz9JARDP8Z1J76SYo39RfoNQ3nnWIoTNukYRlP8pGNa5BQBpHuQeu08wzjxwLv4805aIqMY4z/f46av8aCntbsvmtPpVB/kHaVB6trPVx72hr853P3fsLZHLxL3E4+x44MNiAq4/EuoawBKey6f6CYTbLeWGapomv5egQYXycK12TFLxHiHCCcbgP4EECS1Ht5dli5zzphS9ZbKzk0wjbjKOODK0ttGWG6qGALiV7ENFwtqW44xDXTaqql3q7AdlSJnLIgefxc8jn5fSoo9jRrXSqohkkKXMfm9YQtMtN2KmgZz2lAjHZrhLLBIxMqdww=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: JDhNK98Pko2xuW3ynsycJ74to5aXOHElVj0P3UtxWu5KKEQUHPnsL1/n7HTf0B/lBrtuXI069S072YqD8H0NYZ79xysa+JnD6NjC6YyOvNcYfvaGQc411LdTlYS7VdlaWH8O2l52bhffrzivmC4QkunYbJN90Ox7waq0Q10GuLy52ObemGY152Z8Sin1Bq94PbLA2LKp44nUH0sZtvy4W/JH7ZDwQNx/zFiK0UzupPDreGL4FL7cyPPirxPXsiUtwrMKHTh9+VwnKxPuUpENChLcmeKdisur5dn6nY4u84Ee/MADWrE4+YQJhHRzRtRQpNM1xelTW8r4AW4Xsvv0KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8743
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: WA1PEPF000099CC.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: dc94089f-ce0e-4e8a-9a39-08df18eab204
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|14060799003|376014|82310400026|36860700016|23010399003|35042699022|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: IuoKtCUJhFmQ53Kn0tyVLk4IeLxwGkqVPEY3/mm2xu87BfEyajYWOXvMfe00u3xMiF8hLDGN4m5EA70NuHt+A3t3aedr8XUdc1qsM+lg/LwkUTMSoj2XR/n0NCeX/pzkJIQMowYPZm3axDWpoHGJzbUzeXCwhpVT6lF9HaiY3XnoohE1WHQzukC/1kEx8gn9ONf5U4hD6qlivPHPZs9A8+cEzv01+yXGS74RFLO0jGKLqeZUx3Ua1UohKIk5Jq1F3lzVtKen3wh0uFnyMAxV09CRaCTq/DXLGYKFc524Je9BBnVEJm2E0Xjis2soRAI/PSoixGQd0Y0hetqJK+1vbiWy4p1xigHomVRewUUjI11aX9Q9+wdeQZzy3KDFYBbAz1TvS5BYNE1Qk8f2fej+NdohzEpb1Kt6WjhXKcdrrkj3EObZvSTKiXNhmSY0Msfc+/7hzxI9qIRE5cfUfVRB+wuj9UvOIhUKRwLtjR1tlOMmVukZThXaSIi7WZloscen3kCjv0eRL2MPqx+94WT2e3ts/SAXvVAbMa6xaGrgCLDRryS+wChnjGPHrEl/BK2ushebyPctUZKYh9StIrAKsCvaX6zKq7+RYUy66twhGh0A6Y8ApqWxQ1R5Uug5BebQBFAHtcNPxKomYa1RNog3yqeKOzOkzHqzv3hEW3Z0oAqAmNkqgq67FGhAE5rBX5HN2xGFAfe9JVRftJDef3V0RA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(14060799003)(376014)(82310400026)(36860700016)(23010399003)(35042699022)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uGJK7wfDN14+/FRh9CXvv7XPgQ6SVeppx5rNAW6tTx9/TvoPSuh6FNj9+NTSaoWVB+9TtCwDHuVaevxq1mCMSJsPtXhNMa0wnHT96bzDA9gvLZI0JxCDMeMm/tzfPYvAt6qNKpxtLbQxHvNM7qtmetJ2q6v3Kab8hVHB8WGqcin0qbqdaa5cfT67qWneWEC754HUAKUjYwFaVk1Wx+g/uednCv4BT5c8GPeio9HcE3Bf5F2P76HUd0A2U6XJRAWu91JrfyRC735Ruu2gLyRI7wQQ+89utTXvCw3mgeuaWrflxEo1wW7qMkrlgw85jNaz+EXFC5VCAtaIqgoUjE015sy9ssuVR6WZHXlgqL5jOE2qnkzpoRU0kUITomK8eX4bKxLAPGDqdpeG57d1Jr1HiUWQDmrw88OYTXQsDA/WHsNnpm+fpyWfF+OrfCEmQc9K
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 20:47:52.6725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e8088d1-b5d5-4e6e-6a49-08df18eac5b8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: WA1PEPF000099CC.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR08MB384524
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

v15 GPU introduces a YIELD_IDLE command/interrupt to signal an access
window to relinquish GPU access as soon as it is idle. With FW v2, the
GPU is immediately yielded when it detects the GPU is idle and the
YIELD_IDLE interrupt is raised.

For latency and CPU scheduling reasons, we want to avoid constantly
yielding the GPU the moment it goes idle when there is only a singular
access window requesting access. As such, we only send YIELD_IDLE when:

- The GPU is granted to an access window and there are other access
  windows requesting GPU access.
- A new GPU_REQUEST was received and the currently active access window
  was the singular requesting AW.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 .../panthor/arbitration/panthor_arbitration.h    |  1 +
 .../arbitration/panthor_arbitration_drv.c        | 10 ++++++++++
 .../arbitration/panthor_arbitration_sched.c      | 16 +++++++++++++++-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
index 53d64abb50379..c0e93f940fccb 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
@@ -75,6 +75,7 @@ int panthor_arbitration_on_grant(struct panthor_arbitration *adev, u8 aw_id);
 int panthor_arbitration_on_stop(struct panthor_arbitration *adev, u8 aw_id);
 int panthor_arbitration_on_close(struct panthor_arbitration *adev, u8 aw_id);
 
+int panthor_arbitration_notify_yield_idle(struct panthor_arbitration *adev, u8 aw_id);
 int panthor_arbitration_notify_err(struct panthor_arbitration *adev, u8 aw_id);
 
 #endif
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
index 3cdf03f3f4879..058fe39cbc002 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
@@ -298,6 +298,16 @@ int panthor_arbitration_on_close(struct panthor_arbitration *adev, u8 aw_id)
 	return panthor_partition_control_close_window(adev->pc[idx]);
 }
 
+int panthor_arbitration_notify_yield_idle(struct panthor_arbitration *adev, u8 aw_id)
+{
+	int idx = to_assigned_sched_idx(adev, aw_id);
+
+	if (idx < 0)
+		return idx;
+
+	return panthor_partition_control_yield_idle(adev->pc[idx]);
+}
+
 int panthor_arbitration_notify_err(struct panthor_arbitration *adev, u8 aw_id)
 {
 	int idx = to_assigned_sched_idx(adev, aw_id);
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c
index df0785a80442c..df58fcc56e375 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c
@@ -347,6 +347,10 @@ static int arb_sched_next_locked(struct panthor_arbitration_sched *sched)
 
 	arb_sched_grant_locked(sched);
 
+	if (sched->phase == ARB_SCHED_PHASE_GRANTED &&
+	    !kfifo_is_empty(&sched->queue))
+		panthor_arbitration_notify_yield_idle(to_adev(sched), aw_id);
+
 	wake_up_all(&sched->waitqueue);
 
 	return 0;
@@ -475,8 +479,18 @@ int panthor_arbitration_sched_on_request(struct panthor_arbitration_sched *sched
 	 * Grant timer for the current AW has previously expired, request it to
 	 * yield the GPU.
 	 */
-	if (sched->grant_previously_expired)
+	if (sched->grant_previously_expired) {
 		arb_sched_request_stop_locked(sched);
+		return 0;
+	}
+
+	/*
+	 * GPU was previously granted to a lone requesting AW, YIELD_IDLE was
+	 * not sent to it. Send YIELD_IDLE to it now that multiple AWs are
+	 * requesting for the GPU.
+	 */
+	if (sched->phase == ARB_SCHED_PHASE_GRANTED && kfifo_len(&sched->queue) == 1)
+		panthor_arbitration_notify_yield_idle(to_adev(sched), sched->active_aw_id);
 
 	return 0;
 }
-- 
2.43.0

