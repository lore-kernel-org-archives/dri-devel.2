Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F1BC98308
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:47:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14EA710EE58;
	Tue, 22 Sep 2026 20:47:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="iKH9ZYcx";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="iKH9ZYcx";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013046.outbound.protection.outlook.com
 [52.101.83.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DADEB10EE54
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:47:48 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ReUu0KE1GGWZ9it7r7TVcVieUHYqlrJCos7n0vdcAztvAeNJTBiE9cG6hBQ0SgP2cX1RbU6mOP3NlMmchSkBIE99DQyk5UOPlfje1zaiaMtoer3ZMZ+vS63VF+MC3z5U7IihSBmXLCeGGGjqpPPDNvnoPOch80OQ6VEfl/qzNdeTm3fVsFnvXL5TYb9KtwBJo3I4vzQmqmhNB9kBkvdtr/IrcwljUFcyC2pgTmq3TlI3Kgyeya1JY2eNWzFSPukrHrQTuk7m72LqqM/llTA2UrFjkJtyorCfK5xBrlz+x3/xq9IS8grzBOgsae/csmniDxNj5S3qGgF9PpaEDaSHWw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqsaEfMmghbnjFeL209tFfTFzsYvUTuuxY8TFLKTwVg=;
 b=F0o/a99Bsnnc7TvXC0urMZ30JgI0MmF/WOGM+qnnRc+8x4ImfL0ph3P0pG58iRBNDntTQveJ7HO75sePrYrY+gXRme3zzxX4Tl1vO+44OL1iWoCtVGtfKyPcEG+kRZkwMxRIrz6cGo7jkm4KkEdXHzYA4p0Do1pNs9RBGCScnOpz3lwf39hpDKMp4DDnvSWkrScYiASNZsaokKwTaggRcPdbwGm4ZJPSGZJ6zTxUYaRibxI19GmINiKABgi+/PEgN8+L6D0a4z+4AJ/P9nQ2JdVb4v94re0wbPb7If6ltQTThRamu4oRMTeypK9qE9r1QUnjeWIzImnXxo8RzRZ2HQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqsaEfMmghbnjFeL209tFfTFzsYvUTuuxY8TFLKTwVg=;
 b=iKH9ZYcxdwAS7sDJwIWAmwa63KWXixAEUSuLYX7Cy0x00aZ7d2ATYTvA7XVARa+tgPivZYdEI9ZzbMThWblAku22f+3OoIA0WO7WIuuX5iIJ/hM/4tLDPFFZT/WJ7rAAVAknWvVJtfhRZp0WU4A2wl3iVVp3dECeaBrn3JQtz6E=
Received: from DU2PR04CA0326.eurprd04.prod.outlook.com (2603:10a6:10:2b5::31)
 by AS8PR08MB8369.eurprd08.prod.outlook.com (2603:10a6:20b:56c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 20:47:38 +0000
Received: from DU2PEPF00028D0A.eurprd03.prod.outlook.com
 (2603:10a6:10:2b5:cafe::16) by DU2PR04CA0326.outlook.office365.com
 (2603:10a6:10:2b5::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Tue,
 22 Sep 2026 20:47:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D0A.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Tue, 22 Sep 2026 20:47:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IL/p3aFYGQjjfdjEJ9z+B0ZEsGPuLzTiutsJaTtBYYw9asWBlyzAvl8VO80dJtN0nxLdSHd38gFvIpfBhY9z9O+1oSf+K4Wj+aeKdyTmvBu+IROFcip43FJnhrxVN7w0+jav0ljoGgHvEMDQdcWvz+16SYGyb+6j41sdWWSEo4HuQMEM1ykAgIF6qNtGeBLnkm9CK0t+EYg4H6LEqQm2aoRjxgdTmmeUVb0iIp1/cNrdb3RFssMK2+yqzc/QQthCn8Lc7I1mI76Y/PJDtwJYzHL9IRLVoWoe+RQ3RgxOpDoaxgFxHChL3+IWlcpI26qSx36AVz75UZzTQuhcItPTEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqsaEfMmghbnjFeL209tFfTFzsYvUTuuxY8TFLKTwVg=;
 b=UI0z/oPMHQdUu7QQZInPlGsFsx0x+93/6oaSOHWSrBc1eXozl1TDDuRY2XpZci5MrJBpHQRxM7edECR4f9HP2htOeYoTdZAvIe+PnUQDHDCPlt0+UGdrLgh34gQdrvqnBnYOWUB7ppGbYJ5bJ0xT6gXhAhhDpLgyjpqBJ3mGa+VnutJ4akXkxtp8JLpEBykSm7lwZ71e/z1RkcqU1Xne/1y211EZX1d6w1BywYqLGjkDv+cSDcCZnD3ocZibFwZJVDKpuTDQVY/KIeTcCY6T6yA6Lot+OwlE0YCKjkrPoSDHol/XvsWEdxVTxI0xB8SY/Zci6ESkO3qDC8s7bRFbJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqsaEfMmghbnjFeL209tFfTFzsYvUTuuxY8TFLKTwVg=;
 b=iKH9ZYcxdwAS7sDJwIWAmwa63KWXixAEUSuLYX7Cy0x00aZ7d2ATYTvA7XVARa+tgPivZYdEI9ZzbMThWblAku22f+3OoIA0WO7WIuuX5iIJ/hM/4tLDPFFZT/WJ7rAAVAknWvVJtfhRZp0WU4A2wl3iVVp3dECeaBrn3JQtz6E=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by GV1PR08MB8743.eurprd08.prod.outlook.com
 (2603:10a6:150:87::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 20:47:04 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%3]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 20:47:04 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v1 16/27] drm/panthor: Add arbitration scheduler
Date: Tue, 22 Sep 2026 21:45:10 +0100
Message-ID: <20260922204535.2850094-17-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922204535.2850094-1-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0019.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2df::15) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|GV1PR08MB8743:EE_|DU2PEPF00028D0A:EE_|AS8PR08MB8369:EE_
X-MS-Office365-Filtering-Correlation-Id: e435f10a-f9e0-4eca-a58c-08df18eabd2a
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|3023799007|5023799004|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original: j4SvLczSoMaOpn9nAqsToqZ3wOW71+qDww3P80wvkb9ynnnx5z8irja8p5qO1DP+MJQklbtxGUnEPeU8uZ6kvRjfVTYSnDAlivRXZfKS3vhycEX79VfYvexmurwOyTHgpa6x+K8pRRt9pqxM7PSex+m3X7NGNV5oWqyJe4dNf8x3WQCs7nKtPtBuSfVPUt6O4QH0PeCcjQgJX6SaQ0U8xxjIUWB3p/uFHn4ruIQ8dd472aWWep7EYyYQtT5vs3Xw6k7WZ8+musKDeUaHRWHrrzUMmJ66IOrmsIq5NDgq9w6YfzoJUA4LXPfhiy3npA5AlD0S0tLnGNSCQbDJTAJZPRNRd45j9AWdScXbLmn1iwcJBJFNXVtS8+IkJGCPTDkHrSNxqMI4Dk/zT8vo92/ctOBnLnnljFwKTJFMLEiM75wmsic0LktJI6w2B6mNDFYX+UZh5dPdJkn0lnjsBSAWDYRcNqEXDewHjp4Y9cutOOD4qq5Ij3+8CwmAGydB6B8+L/g1X7HtQQ4nI81aekegWaDXJ9BiUt+j1A6+KIxg7nkVUpllL67GXhs7/m4cqTCKESTToYrtbHm30RFlAahfMbEcG4uLb1vWr94+Ll5Oyp2plQOTByWD1uWiDv/R52RB
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(3023799007)(5023799004)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: 5p+42ZB6G+gJvhjYoMDNVGoxKazG+vcecETRGqpWeqKNC0HLpSiMY8GE4lRkASVJ8yJFzul66BnTsPak+5ppgipKz+Rdi0tQx/UrAJsPQh9IWF6z+Bm5OH/tZpZazgJsjfNhHnBBqllW7MI0hlBJEf3Zm2ZjvQJJerMGlvHSzb1NOjJAfJQwD+8by7hYPUd8wq4IzEc5ptObXgPqILPlN2stwW+bD2V2kCEhqxvfdWHXuqrxuJVBdj5mbwDDczuuiVCF01AliW7uPlpMmUJdsn7oWMsomnIBLEdMitMwYutaYE6PH5CPWkbMkWUopTLUPam/BC1zh7rYqiVZLqRNeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8743
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D0A.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6aa0d34c-b2b3-436f-f396-08df18eaa8d2
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|14060799003|36860700016|82310400026|1800799024|35042699022|23010399003|10067099003|5023799004|6133799003|3023799007|56012099006|11063799006|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: 7J1asU8Xo2qQjr3f841RzF3yE2taD0ZuVI6D4cqx9tQ+I3DMi3BbB7MKu9Kaa+EDLaMM4WPqfF2Gc70gLlXNzU0pHbKDs6YDAHqHE1O1Fcv10If19+NWm96Au/QuWjnq+W4n1+1fxGu8feLngArBqsP9wk+4vZJJzBUX+ZKRIvV5o0epdiTw0c/2YVkU0V0cLzHvJq8DkZ1VHBUEiodbUo2oGh18v70n4hDy1H9FD1AlMmFg6Yor9ZiIjjn7qA/aK6QznF2O51KZ75VdMcccbvDzZmGUBLXOineq0vrHjftVbwleBCVPhveyXB1psNsz4LDq3I+rJkBjSoEbDHPqSyj08VjVuPqSRojMaQU/AVyxUyqjVEWVv2Q3xqkROhexU4OtLyDipf+v1GTl4ZK+luxQzFOg8ECnYXbOYNygVIVAxadlBFW6VRw8vB0tLDgDLTc5g2F5wq5weamTXLMVEO5aJXYM8aSkL6v6FhA7VeQILTEqCJUL7iTKNYg4Ae7GuQbWRtCZ3/WjV6jhRYK6LrL+gRdWkIMJDwEUJIV+ZoJxYaVy0XZ6Y6NK8AC1QZacljqzRVG7hZh07cTjmLCuGKfPWNFut32rllsJwnVX+oSnzH8GknHUKsgkWcBgjSVeK/QBbyaWn60uOFHs1c2qeg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(14060799003)(36860700016)(82310400026)(1800799024)(35042699022)(23010399003)(10067099003)(5023799004)(6133799003)(3023799007)(56012099006)(11063799006)(22082099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vPx9X0zITKrybse59QyZy1EX4DU1O18pPP29e8q5YJX7geZrdRFbOjKrGJW4ndBY+azB/LRo+P97RqMZR13tWc6ZWJbfk7iDUuX5VonmdML04g4tilWmU/vsk+LWczNVCqQAqBk0Haz3C93dFNFr7IB4oDs5oNe48Int0DScXbkoatwcS+Eu1nuFlmkcrDNi9jgZKeF7NKKugoVWopEI5hmgO+JlJlMs1SKfA661ZxEVyfM+L/nniYW0QnPVkj3XY44uaH1/WQ/WfqzGOkoinlbPsEbgiU8eAs93qRJDpeUwjLXHUoAKGv35UZ0mHqNtbw4obfeEsXJ8Irwrc3YjlJLGVinIB+VZoz0enTAAJtr7K+0skSOcWZjFGWwa6mdL6FLfy37p9F5bG49euewParR654Rlz09rMzQJ9hASUmf+6EgM32dKzBcGltZcyy+Y
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 20:47:38.3815 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e435f10a-f9e0-4eca-a58c-08df18eabd2a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D0A.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8369
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

Add a per-partition arbitration scheduler that queues access-window GPU
requests, grants the active window, asks it to stop when its lease
expires, and force-closes it if it does not yield in time.

An uncontended access window can retain access even after its timeslice
expires.

Track grant, stop and close deadlines with hrtimers so scheduler
progress remains bounded.

Use scheduler reset work to recover from unrecoverable arbitration
errors and stale timeout state.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v1:
- Move grant, stop and close operations from workqueues into IRQ-safe
  paths. Retains work for scheduler recovery.
- Add closing phase and timer to ensure CLOSE_WINDOW completes in due
  time, otherwise enter recovery handling.
- Rename "grant_timeout_us" to "request_timeout" and "yield_timeout_us"
  to "yield_timeout". Both units are now in milliseconds.
- Add ABI documentation

 .../testing/sysfs-driver-panthor-arbitration  |  18 +
 MAINTAINERS                                   |   1 +
 drivers/gpu/drm/panthor/arbitration/Makefile  |   1 +
 .../panthor/arbitration/panthor_arbitration.h |  12 +
 .../arbitration/panthor_arbitration_drv.c     |  47 +-
 .../arbitration/panthor_arbitration_sched.c   | 729 ++++++++++++++++++
 .../arbitration/panthor_arbitration_sched.h   |  39 +
 7 files changed, 843 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-panthor-arbitration
 create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c
 create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.h

diff --git a/Documentation/ABI/testing/sysfs-driver-panthor-arbitration b/Documentation/ABI/testing/sysfs-driver-panthor-arbitration
new file mode 100644
index 0000000000000..fbd21270a2412
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-panthor-arbitration
@@ -0,0 +1,18 @@
+What:		/sys/module/panthor_arbitration/parameters/request_timeout
+Date:		September 2026
+KernelVersion:	7.2.0
+Contact:	Arm Ltd.
+Description:
+		Controls how long, in milliseconds, the arbitration scheduler
+		allows an access window to keep the GPU before asking it to
+		yield when another access window is waiting.
+
+What:		/sys/module/panthor_arbitration/parameters/yield_timeout
+Date:		September 2026
+KernelVersion:	7.2.0
+Contact:	Arm Ltd.
+Description:
+		Controls how long, in milliseconds, the arbitration scheduler
+		waits for an access window to yield the GPU after a stop request.
+		If the timeout expires, the scheduler force-closes the access
+		window.
diff --git a/MAINTAINERS b/MAINTAINERS
index 377156650580c..af7da4c08bf8a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2324,6 +2324,7 @@ M:	Liviu Dudau <liviu.dudau@arm.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/ABI/testing/sysfs-driver-panthor-arbitration
 F:	Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-*.yaml
 F:	Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
 F:	drivers/gpu/drm/ci/xfails/panthor*
diff --git a/drivers/gpu/drm/panthor/arbitration/Makefile b/drivers/gpu/drm/panthor/arbitration/Makefile
index 2d2684321d978..22ed68948fee3 100644
--- a/drivers/gpu/drm/panthor/arbitration/Makefile
+++ b/drivers/gpu/drm/panthor/arbitration/Makefile
@@ -4,6 +4,7 @@
 obj-$(CONFIG_DRM_PANTHOR_ARBITRATION) += panthor_arbitration.o
 panthor_arbitration-y := \
 	panthor_arbitration_drv.o \
+	panthor_arbitration_sched.o \
 	panthor_partition_control.o \
 	panthor_resource_group.o
 
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
index dfeab1b078d06..eeae8219b2894 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
@@ -6,8 +6,10 @@
 
 #include <linux/ioport.h>
 #include <linux/fwnode.h>
+#include <linux/types.h>
 
 struct device;
+struct panthor_arbitration_sched;
 struct panthor_partition_control;
 struct panthor_resource_group;
 
@@ -31,15 +33,25 @@ struct panthor_arbitration {
 	/** @dev: Device pointer */
 	struct device *dev;
 
+	/** @tearing_down: Driver remove in progress */
+	bool tearing_down;
+
 	/** @pc: Pointer array to partition control data */
 	struct panthor_partition_control *pc[AM_ARB_MAX_PC_COUNT];
 
 	/** @rg: Pointer array to resource group data */
 	struct panthor_resource_group *rg[AM_ARB_MAX_RG_COUNT];
+
+	/** @sched: Pointer to scheduler data. 1 sched per partition */
+	struct panthor_arbitration_sched *sched[AM_ARB_MAX_PC_COUNT];
 };
 
 int panthor_arbitration_parse_resource(struct device *dev,
 				       const struct fwnode_handle *child,
 				       struct panthor_arbitration_resource *res);
 
+int panthor_arbitration_on_grant(struct panthor_arbitration *adev, u8 aw_id);
+int panthor_arbitration_on_stop(struct panthor_arbitration *adev, u8 aw_id);
+int panthor_arbitration_on_close(struct panthor_arbitration *adev, u8 aw_id);
+
 #endif
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
index a1068a2c78f1a..2d0c8d95f1abd 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
@@ -11,6 +11,7 @@
 #include <linux/of.h>
 
 #include "panthor_arbitration.h"
+#include "panthor_arbitration_sched.h"
 #include "panthor_partition_control.h"
 #include "panthor_resource_group.h"
 
@@ -56,6 +57,13 @@ static int panthor_arbitration_runtime_suspend(struct device *dev)
 	struct panthor_arbitration *adev = dev_get_drvdata(dev);
 	int ret = 0;
 
+	if (adev->tearing_down)
+		return 0;
+
+	ret = panthor_arbitration_sched_suspend(adev);
+	if (ret)
+		return ret;
+
 	ret = panthor_resource_group_suspend(adev);
 	if (ret)
 		return ret;
@@ -80,6 +88,26 @@ static int panthor_arbitration_runtime_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	ret = panthor_arbitration_sched_resume(adev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/* Arbiter to AW events */
+int panthor_arbitration_on_grant(struct panthor_arbitration *adev, u8 aw_id)
+{
+	return 0;
+}
+
+int panthor_arbitration_on_stop(struct panthor_arbitration *adev, u8 aw_id)
+{
+	return 0;
+}
+
+int panthor_arbitration_on_close(struct panthor_arbitration *adev, u8 aw_id)
+{
 	return 0;
 }
 
@@ -116,6 +144,10 @@ static int panthor_arbitration_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_term_rg;
 
+	ret = panthor_arbitration_sched_init(adev);
+	if (ret)
+		goto err_term_sched;
+
 	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
 	if (ret)
 		goto err_depopulate;
@@ -129,6 +161,8 @@ static int panthor_arbitration_probe(struct platform_device *pdev)
 
 err_depopulate:
 	of_platform_depopulate(dev);
+err_term_sched:
+	panthor_arbitration_sched_term(adev);
 err_term_rg:
 	panthor_resource_group_cancel_work(adev);
 	panthor_resource_group_term(adev);
@@ -151,15 +185,20 @@ static void panthor_arbitration_remove(struct platform_device *pdev)
 		dev_warn(adev->dev, "failed to resume during remove: %d", ret);
 
 	of_platform_depopulate(adev->dev);
-	panthor_resource_group_cancel_work(adev);
 
 	if (ret >= 0) {
+		adev->tearing_down = true;
+
+		panthor_arbitration_sched_term(adev);
+		panthor_resource_group_cancel_work(adev);
 		panthor_resource_group_term(adev);
 		panthor_partition_control_term(adev);
-		pm_runtime_put_noidle(adev->dev);
+		pm_runtime_put_sync_suspend(adev->dev);
+	} else {
+		panthor_arbitration_sched_cancel(adev);
+		panthor_resource_group_cancel_work(adev);
+		pm_runtime_set_suspended(adev->dev);
 	}
-
-	pm_runtime_set_suspended(adev->dev);
 }
 
 static const struct dev_pm_ops panthor_arbitration_pm_ops = {
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c
new file mode 100644
index 0000000000000..41f06af92ce0c
--- /dev/null
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c
@@ -0,0 +1,729 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#include <linux/bits.h>
+#include <linux/device.h>
+#include <linux/kfifo.h>
+#include <linux/moduleparam.h>
+#include <linux/time.h>
+#include <linux/types.h>
+
+#include "panthor_arbitration.h"
+#include "panthor_arbitration_sched.h"
+#include "panthor_resource_group.h"
+
+static u64 request_timeout = 1 * MSEC_PER_SEC;
+static u64 yield_timeout = 1 * MSEC_PER_SEC;
+
+module_param(request_timeout, ullong, 0644);
+MODULE_PARM_DESC(request_timeout, "Time the GPU will be granted to the AW in milliseconds.");
+
+module_param(yield_timeout, ullong, 0644);
+MODULE_PARM_DESC(yield_timeout, "Time, in milliseconds, within which the AW must yield the GPU.");
+
+enum arbitration_sched_phase {
+	ARB_SCHED_PHASE_IDLE = 0,
+	ARB_SCHED_PHASE_GRANTING,
+	ARB_SCHED_PHASE_GRANTED,
+	ARB_SCHED_PHASE_STOPPING,
+	ARB_SCHED_PHASE_CLOSING,
+	ARB_SCHED_PHASE_LOST,
+};
+
+struct panthor_arbitration_timer {
+	/** @timer: High-resolution timer */
+	struct hrtimer timer;
+
+	/** @epoch: The lease generation for which the timer was triggered */
+	u32 epoch;
+};
+
+struct panthor_arbitration_work {
+	/** @work: Work struct */
+	struct work_struct work;
+
+	/** @aw_id: Window for which the work was queued */
+	u8 aw_id;
+
+	/** @epoch: The lease generation for which the work was queued */
+	u32 epoch;
+};
+
+struct panthor_arbitration_sched {
+	/** @dev: Device pointer */
+	struct device *dev;
+
+	/** @name: Scheduler name */
+	char *name;
+
+	/** @waitqueue: Event wait queue. Not IRQ safe */
+	wait_queue_head_t waitqueue;
+
+	/** @lock: Protects scheduler state */
+	spinlock_t lock;
+
+	/** @queue: Pending request FIFO */
+	DECLARE_KFIFO(queue, u8, 16);
+
+	/** @queued_mask: Mask of currently queued AWs */
+	DECLARE_BITMAP(queued_mask, AM_ARB_MAX_AW_COUNT);
+
+	/** @active_aw_id: Currently active AW. Can be -1 */
+	s8 active_aw_id;
+
+	/** @phase: Current scheduling phase */
+	enum arbitration_sched_phase phase;
+
+	/** @epoch: Current active lease generation */
+	u32 epoch;
+
+	/** @wq: Scheduler workqueue to dispatch events */
+	struct workqueue_struct *wq;
+
+	/** @reset_work: Work to reset the scheduler */
+	struct panthor_arbitration_work reset_work;
+
+	/** @grant_timer: Timer to indicate grant window has lapsed */
+	struct panthor_arbitration_timer grant_timer;
+
+	/** @stop_timer: Timer to indicate yield window has lapsed */
+	struct panthor_arbitration_timer stop_timer;
+
+	/** @close_timer: Timer to indicate close window has lapsed */
+	struct panthor_arbitration_timer close_timer;
+
+	/** @disabled: Scheduler disabled. No further scheduling can happen */
+	u32 disabled;
+
+	/**
+	 * @grant_previously_expired: Grant period previously expired but was
+	 * not asked to stop
+	 */
+	bool grant_previously_expired;
+};
+
+static int arb_sched_on_stopped_locked(struct panthor_arbitration_sched *sched, u8 aw_id);
+
+static inline struct panthor_arbitration *
+to_adev(struct panthor_arbitration_sched *sched)
+{
+	return dev_get_drvdata(sched->dev);
+}
+
+static inline struct panthor_arbitration_work *to_work(struct work_struct *w)
+{
+	return container_of(w, struct panthor_arbitration_work, work);
+}
+
+static bool arb_sched_phase_reached(struct panthor_arbitration_sched *sched,
+				    enum arbitration_sched_phase phase)
+{
+	guard(spinlock_irqsave)(&sched->lock);
+
+	return sched->phase == phase;
+}
+
+/* This method is not IRQ safe as it sleeps. */
+static int arb_sched_wait_phase(struct panthor_arbitration_sched *sched,
+				enum arbitration_sched_phase phase,
+				u64 timeout_ms)
+{
+	if (!wait_event_timeout(
+		    sched->waitqueue, arb_sched_phase_reached(sched, phase),
+		    msecs_to_jiffies(timeout_ms))) {
+
+		if (!arb_sched_phase_reached(sched, phase))
+			return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static void arb_sched_queue_work(struct panthor_arbitration_sched *sched,
+				 struct panthor_arbitration_work *work)
+{
+	lockdep_assert_held(&sched->lock);
+
+	work->aw_id = sched->active_aw_id;
+	work->epoch = sched->epoch;
+	queue_work(sched->wq, &work->work);
+}
+
+static int __arb_sched_stop_locked(struct panthor_arbitration_sched *sched)
+{
+	int ret;
+
+	lockdep_assert_held(&sched->lock);
+
+	ret = panthor_arbitration_on_stop(to_adev(sched), sched->active_aw_id);
+	if (ret) {
+		dev_err(sched->dev, "%s: Failed to send yield to AW%u",
+			sched->name, sched->active_aw_id);
+
+		arb_sched_queue_work(sched, &sched->reset_work);
+	}
+
+	return ret;
+}
+
+static void arb_sched_stop_locked(struct panthor_arbitration_sched *sched)
+{
+	int ret;
+
+	lockdep_assert_held(&sched->lock);
+
+	ret = __arb_sched_stop_locked(sched);
+	if (!ret) {
+		if (sched->phase != ARB_SCHED_PHASE_STOPPING) {
+			dev_warn(sched->dev, "%s: Stop ACKED when not yielding",
+				 sched->name);
+			return;
+		}
+
+		sched->stop_timer.epoch = sched->epoch;
+		hrtimer_start(&sched->stop_timer.timer,
+			      ms_to_ktime(yield_timeout), HRTIMER_MODE_REL);
+	}
+}
+
+static void arb_sched_grant_locked(struct panthor_arbitration_sched *sched)
+{
+	int ret;
+
+	lockdep_assert_held(&sched->lock);
+
+	ret = panthor_arbitration_on_grant(to_adev(sched), sched->active_aw_id);
+	if (!ret) {
+		if (sched->phase != ARB_SCHED_PHASE_GRANTING) {
+			dev_warn(sched->dev, "%s: Grant ACKED when not granting",
+				 sched->name);
+			return;
+		}
+
+		if (sched->disabled) {
+			sched->phase = ARB_SCHED_PHASE_STOPPING;
+			arb_sched_stop_locked(sched);
+		} else {
+			sched->phase = ARB_SCHED_PHASE_GRANTED;
+
+			sched->grant_timer.epoch = sched->epoch;
+			hrtimer_start(&sched->grant_timer.timer,
+				      ms_to_ktime(request_timeout),
+				      HRTIMER_MODE_REL);
+		}
+
+		wake_up_all(&sched->waitqueue);
+	} else if (ret < 0) {
+		dev_err(sched->dev, "%s: Failed to grant access to AW%u",
+			sched->name, sched->active_aw_id);
+
+		arb_sched_queue_work(sched, &sched->reset_work);
+	}
+}
+
+static int __arb_sched_close_locked(struct panthor_arbitration_sched *sched)
+{
+	int ret;
+
+	lockdep_assert_held(&sched->lock);
+
+	ret = panthor_arbitration_on_close(to_adev(sched), sched->active_aw_id);
+	if (ret < 0) {
+		dev_err(sched->dev, "%s: Failed to close AW%u", sched->name,
+			sched->active_aw_id);
+
+		arb_sched_queue_work(sched, &sched->reset_work);
+	}
+
+	return ret;
+}
+
+static void arb_sched_close_locked(struct panthor_arbitration_sched *sched)
+{
+	int ret;
+
+	lockdep_assert_held(&sched->lock);
+
+	ret = __arb_sched_close_locked(sched);
+	if (!ret) {
+		sched->close_timer.epoch = sched->epoch;
+		hrtimer_start(&sched->close_timer.timer,
+			      ms_to_ktime(yield_timeout), HRTIMER_MODE_REL);
+	} else if (ret > 0) {
+		/*
+		 * Window alread closed. We need to manually transition the
+		 * phase back to IDLE.
+		 */
+		arb_sched_on_stopped_locked(sched, sched->active_aw_id);
+	}
+}
+
+static void arb_sched_request_stop_locked(struct panthor_arbitration_sched *sched)
+{
+	lockdep_assert_held(&sched->lock);
+
+	if (sched->phase != ARB_SCHED_PHASE_GRANTED)
+		return;
+
+	if (sched->active_aw_id < 0)
+		return;
+
+	/*
+	 * In the event of a single requesting AW, let it continue to
+	 * lease the GPU until another request comes in.
+	 */
+	if (!sched->disabled && kfifo_is_empty(&sched->queue)) {
+		sched->grant_previously_expired = true;
+		return;
+	}
+
+	sched->phase = ARB_SCHED_PHASE_STOPPING;
+	arb_sched_stop_locked(sched);
+
+	wake_up_all(&sched->waitqueue);
+}
+
+static void arb_sched_request_stop(struct panthor_arbitration_sched *sched)
+{
+	guard(spinlock_irqsave)(&sched->lock);
+
+	arb_sched_request_stop_locked(sched);
+}
+
+static void arb_sched_force_close_locked(struct panthor_arbitration_sched *sched)
+{
+	lockdep_assert_held(&sched->lock);
+
+	if (sched->phase == ARB_SCHED_PHASE_IDLE)
+		return;
+
+	if (sched->active_aw_id < 0)
+		return;
+
+	sched->phase = ARB_SCHED_PHASE_LOST;
+
+	arb_sched_close_locked(sched);
+
+	wake_up_all(&sched->waitqueue);
+}
+
+static void arb_sched_force_close(struct panthor_arbitration_sched *sched)
+{
+	scoped_guard(spinlock_irqsave, &sched->lock)
+		arb_sched_force_close_locked(sched);
+
+	arb_sched_wait_phase(sched, ARB_SCHED_PHASE_IDLE,
+			     request_timeout + yield_timeout);
+}
+
+static int arb_sched_next_locked(struct panthor_arbitration_sched *sched)
+{
+	u8 aw_id;
+
+	lockdep_assert_held(&sched->lock);
+
+	if (sched->disabled)
+		return 0;
+
+	/* already have a running aw */
+	if (sched->active_aw_id >= 0)
+		return 0;
+
+	/* nothing to schedule */
+	if (kfifo_is_empty(&sched->queue))
+		return 0;
+
+	if (!kfifo_get(&sched->queue, &aw_id)) {
+		dev_warn(sched->dev, "%s: queue unexpectedly empty",
+				sched->name);
+		return -EINVAL;
+	}
+
+	clear_bit(aw_id, sched->queued_mask);
+
+	sched->active_aw_id = aw_id;
+	sched->epoch++;
+	sched->phase = ARB_SCHED_PHASE_GRANTING;
+
+	arb_sched_grant_locked(sched);
+
+	wake_up_all(&sched->waitqueue);
+
+	return 0;
+}
+
+static int arb_sched_next(struct panthor_arbitration_sched *sched)
+{
+	guard(spinlock_irqsave)(&sched->lock);
+
+	return arb_sched_next_locked(sched);
+}
+
+static void arb_sched_reset_work(struct work_struct *work)
+{
+	struct panthor_arbitration_work *w = to_work(work);
+	struct panthor_arbitration_sched *sched =
+		container_of(w, struct panthor_arbitration_sched, reset_work);
+
+	guard(spinlock_irqsave)(&sched->lock);
+	if (sched->epoch != w->epoch)
+		return;
+
+	if (sched->active_aw_id != w->aw_id)
+		return;
+
+	dev_warn(sched->dev, "%s: scheduler reset. active_aw=%u",
+			sched->name, sched->active_aw_id);
+
+	arb_sched_force_close_locked(sched);
+}
+
+static enum hrtimer_restart
+panthor_arbitration_sched_on_stop_timeout(struct hrtimer *timer)
+{
+	struct panthor_arbitration_timer *atmr = container_of(
+		timer, struct panthor_arbitration_timer, timer);
+	struct panthor_arbitration_sched *sched = container_of(
+		atmr, struct panthor_arbitration_sched, stop_timer);
+
+	guard(spinlock_irqsave)(&sched->lock);
+
+	if (sched->epoch != atmr->epoch ||
+	    sched->phase != ARB_SCHED_PHASE_STOPPING)
+		return HRTIMER_NORESTART;
+
+	dev_warn(sched->dev,
+		 "%s: AW%d failed to stop in time. Force closing...",
+		 sched->name, sched->active_aw_id);
+	arb_sched_force_close_locked(sched);
+
+	return HRTIMER_NORESTART;
+}
+
+static enum hrtimer_restart
+panthor_arbitration_sched_on_grant_timeout(struct hrtimer *timer)
+{
+	struct panthor_arbitration_timer *atmr = container_of(
+		timer, struct panthor_arbitration_timer, timer);
+	struct panthor_arbitration_sched *sched = container_of(
+		atmr, struct panthor_arbitration_sched, grant_timer);
+
+	guard(spinlock_irqsave)(&sched->lock);
+
+	if (sched->epoch != atmr->epoch)
+		return HRTIMER_NORESTART;
+
+	arb_sched_request_stop_locked(sched);
+
+	return HRTIMER_NORESTART;
+}
+
+static enum hrtimer_restart
+panthor_arbitration_sched_on_close_timeout(struct hrtimer *timer)
+{
+	struct panthor_arbitration_timer *atmr = container_of(
+		timer, struct panthor_arbitration_timer, timer);
+	struct panthor_arbitration_sched *sched = container_of(
+		atmr, struct panthor_arbitration_sched, close_timer);
+
+	guard(spinlock_irqsave)(&sched->lock);
+
+	if (sched->epoch != atmr->epoch)
+		return HRTIMER_NORESTART;
+
+	if (sched->phase != ARB_SCHED_PHASE_CLOSING &&
+	    sched->phase != ARB_SCHED_PHASE_LOST)
+		return HRTIMER_NORESTART;
+
+	dev_warn(sched->dev,
+		 "%s: AW%d failed to close in time. Resetting scheduler...",
+		 sched->name, sched->active_aw_id);
+
+	arb_sched_queue_work(sched, &sched->reset_work);
+
+	return HRTIMER_NORESTART;
+}
+
+int panthor_arbitration_sched_on_request(struct panthor_arbitration_sched *sched, u8 aw_id)
+{
+	guard(spinlock_irqsave)(&sched->lock);
+
+	if (aw_id >= AM_ARB_MAX_AW_COUNT)
+		return -EINVAL;
+
+	if (test_bit(aw_id, sched->queued_mask) ||
+	    (sched->active_aw_id == aw_id &&
+	     sched->phase != ARB_SCHED_PHASE_STOPPING)) {
+		dev_warn(sched->dev, "%s: AW%u already in request queue.",
+			 sched->name, aw_id);
+		return -EEXIST;
+	}
+
+	/* Always put onto queue */
+	if (!kfifo_put(&sched->queue, aw_id)) {
+		dev_err(sched->dev, "%s: request queue unexpectedly full",
+			sched->name);
+		return -ENOSPC;
+	}
+	set_bit(aw_id, sched->queued_mask);
+
+	/* No active AW, schedule next AW */
+	if (sched->active_aw_id < 0)
+		return arb_sched_next_locked(sched);
+
+	/*
+	 * Grant timer for the current AW has previously expired, request it to
+	 * yield the GPU.
+	 */
+	if (sched->grant_previously_expired)
+		arb_sched_request_stop_locked(sched);
+
+	return 0;
+}
+
+int panthor_arbitration_sched_on_idle(struct panthor_arbitration_sched *sched, u8 aw_id)
+{
+	guard(spinlock_irqsave)(&sched->lock);
+
+	if (aw_id >= AM_ARB_MAX_AW_COUNT)
+		return -EINVAL;
+
+	if (sched->active_aw_id != aw_id)
+		return 0;
+
+	if (sched->phase != ARB_SCHED_PHASE_GRANTED &&
+	    sched->phase != ARB_SCHED_PHASE_STOPPING)
+		return 0;
+
+	sched->phase = ARB_SCHED_PHASE_CLOSING;
+	arb_sched_close_locked(sched);
+
+	return 0;
+}
+
+static int arb_sched_on_stopped_locked(struct panthor_arbitration_sched *sched, u8 aw_id)
+{
+	if (aw_id >= AM_ARB_MAX_AW_COUNT)
+		return -EINVAL;
+
+	if (sched->phase == ARB_SCHED_PHASE_IDLE)
+		return 0;
+
+	if (sched->active_aw_id != aw_id)
+		return 0;
+
+	/* retire old lease */
+	sched->epoch++;
+
+	sched->grant_previously_expired = false;
+	sched->active_aw_id = -1;
+	sched->phase = ARB_SCHED_PHASE_IDLE;
+
+	wake_up_all(&sched->waitqueue);
+
+	return arb_sched_next_locked(sched);
+}
+
+int panthor_arbitration_sched_on_stopped(struct panthor_arbitration_sched *sched, u8 aw_id)
+{
+	guard(spinlock_irqsave)(&sched->lock);
+
+	return arb_sched_on_stopped_locked(sched, aw_id);
+}
+
+static void arbitration_sched_disable_work(struct panthor_arbitration_sched *sched)
+{
+	disable_work_sync(&sched->reset_work.work);
+}
+
+void panthor_arbitration_sched_cancel(struct panthor_arbitration *adev)
+{
+	for (int i = 0; i < AM_ARB_MAX_PC_COUNT; i++) {
+		struct panthor_arbitration_sched *sched = adev->sched[i];
+
+		if (!sched)
+			continue;
+
+		panthor_arbitration_sched_disable_set(sched, ARB_SCHED_DISABLE_PM);
+		hrtimer_cancel(&sched->grant_timer.timer);
+		hrtimer_cancel(&sched->stop_timer.timer);
+		hrtimer_cancel(&sched->close_timer.timer);
+		arbitration_sched_disable_work(sched);
+	}
+}
+
+static void arbitration_sched_term(struct panthor_arbitration_sched *sched)
+{
+	panthor_arbitration_sched_disable_set(sched, ARB_SCHED_DISABLE_TERM);
+
+	WARN_ON(panthor_arbitration_sched_stop(sched));
+
+	arbitration_sched_disable_work(sched);
+}
+
+static int arbitration_sched_init(struct panthor_arbitration *adev, int i)
+{
+	struct device *dev = adev->dev;
+	struct panthor_arbitration_sched *sched;
+
+	sched = devm_kzalloc(dev, sizeof(*sched), GFP_KERNEL);
+	if (!sched)
+		return -ENOMEM;
+
+	sched->name = devm_kasprintf(dev, GFP_KERNEL, "sched%d", i);
+	sched->dev = dev;
+
+	sched->wq = devm_alloc_ordered_workqueue(dev, "%s-wq", 0, sched->name);
+	if (!sched->wq)
+		return -ENOMEM;
+
+	INIT_WORK(&sched->reset_work.work, arb_sched_reset_work);
+
+	init_waitqueue_head(&sched->waitqueue);
+
+	spin_lock_init(&sched->lock);
+	INIT_KFIFO(sched->queue);
+	sched->active_aw_id = -1;
+	sched->phase = ARB_SCHED_PHASE_IDLE;
+
+	hrtimer_setup(&sched->grant_timer.timer,
+		      panthor_arbitration_sched_on_grant_timeout,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_setup(&sched->stop_timer.timer,
+		      panthor_arbitration_sched_on_stop_timeout,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_setup(&sched->close_timer.timer,
+		      panthor_arbitration_sched_on_close_timeout,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+
+	adev->sched[i] = sched;
+
+	return 0;
+}
+
+void panthor_arbitration_sched_term(struct panthor_arbitration *adev)
+{
+	for (int i = 0; i < AM_ARB_MAX_PC_COUNT; i++) {
+		struct panthor_arbitration_sched *sched = adev->sched[i];
+
+		if (!sched)
+			continue;
+
+		arbitration_sched_term(sched);
+	}
+}
+
+int panthor_arbitration_sched_init(struct panthor_arbitration *adev)
+{
+
+	for (int i = 0; i < AM_ARB_MAX_PC_COUNT; i++) {
+		int ret = arbitration_sched_init(adev, i);
+
+		if (ret == -ENODEV)
+			continue;
+
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int panthor_arbitration_sched_suspend(struct panthor_arbitration *adev)
+{
+	for (int i = 0; i < AM_ARB_MAX_PC_COUNT; i++) {
+		struct panthor_arbitration_sched *sched = adev->sched[i];
+		int ret;
+
+		if (!sched)
+			continue;
+
+		panthor_arbitration_sched_disable_set(sched, ARB_SCHED_DISABLE_PM);
+		ret = panthor_arbitration_sched_stop(sched);
+		if (ret) {
+			panthor_arbitration_sched_disable_clear(
+				sched, ARB_SCHED_DISABLE_PM);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+int panthor_arbitration_sched_resume(struct panthor_arbitration *adev)
+{
+	for (int i = 0; i < AM_ARB_MAX_PC_COUNT; i++) {
+		struct panthor_arbitration_sched *sched = adev->sched[i];
+		int ret;
+
+		if (!sched)
+			continue;
+
+		panthor_arbitration_sched_disable_clear(sched, ARB_SCHED_DISABLE_PM);
+		ret = panthor_arbitration_sched_start(sched);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * panthor_arbitration_sched_stop - Stop active aw and pause scheduler
+ *
+ * @sched: Pointer to arbitration scheduler
+ *
+ * This method is not IRQ safe as it waits for on_stopped() to be called.
+ */
+int panthor_arbitration_sched_stop(struct panthor_arbitration_sched *sched)
+{
+	int ret;
+
+	arb_sched_request_stop(sched);
+
+	/*
+	 * Provisionally waiting for up to 2x yield_timeout, but path may
+	 * include time taken for panthor_arbitration_on_grant() to complete
+	 * if sched_request_stop() is called while in the GRANTING state.
+	 *
+	 * Realistically, if granting takes more than yield_timeout, HW is in
+	 * bad state either way. Best continue and stop the scheduler.
+	 */
+	ret = arb_sched_wait_phase(sched, ARB_SCHED_PHASE_IDLE,
+				   request_timeout + yield_timeout);
+	if (ret)
+		arb_sched_force_close(sched);
+
+	/* Should no longer have any further activity. Cancel timer. */
+	hrtimer_cancel(&sched->grant_timer.timer);
+	hrtimer_cancel(&sched->stop_timer.timer);
+	hrtimer_cancel(&sched->close_timer.timer);
+	flush_workqueue(sched->wq);
+
+	scoped_guard(spinlock_irqsave, &sched->lock)
+		if (sched->phase == ARB_SCHED_PHASE_IDLE)
+			return 0;
+
+	return ret;
+}
+
+int panthor_arbitration_sched_start(struct panthor_arbitration_sched *sched)
+{
+	return arb_sched_next(sched);
+}
+
+void panthor_arbitration_sched_disable_set(struct panthor_arbitration_sched *sched,
+					   enum panthor_arb_sched_disable_reason reason)
+{
+	guard(spinlock_irqsave)(&sched->lock);
+
+	sched->disabled |= BIT(reason);
+}
+
+void panthor_arbitration_sched_disable_clear(struct panthor_arbitration_sched *sched,
+					     enum panthor_arb_sched_disable_reason reason)
+{
+	guard(spinlock_irqsave)(&sched->lock);
+
+	sched->disabled &= ~BIT(reason);
+}
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.h b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.h
new file mode 100644
index 0000000000000..f1f50316a2fff
--- /dev/null
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#ifndef __PANTHOR_ARBITRATION_SCHED_H__
+#define __PANTHOR_ARBITRATION_SCHED_H__
+
+#include <linux/types.h>
+
+struct panthor_arbitration;
+struct panthor_arbitration_sched;
+
+enum panthor_arb_sched_disable_reason {
+	/** @ARB_SCHED_DISABLE_PM: scheduler disabled due to PM suspend */
+	ARB_SCHED_DISABLE_PM = 0,
+
+	/** @ARB_SCHED_DISABLE_TERM: scheduler disabled for termination */
+	ARB_SCHED_DISABLE_TERM,
+};
+
+int panthor_arbitration_sched_init(struct panthor_arbitration *adev);
+void panthor_arbitration_sched_term(struct panthor_arbitration *adev);
+void panthor_arbitration_sched_cancel(struct panthor_arbitration *adev);
+
+int panthor_arbitration_sched_suspend(struct panthor_arbitration *adev);
+int panthor_arbitration_sched_resume(struct panthor_arbitration *adev);
+
+int panthor_arbitration_sched_stop(struct panthor_arbitration_sched *sched);
+int panthor_arbitration_sched_start(struct panthor_arbitration_sched *sched);
+
+void panthor_arbitration_sched_disable_set(struct panthor_arbitration_sched *sched,
+					   enum panthor_arb_sched_disable_reason reason);
+void panthor_arbitration_sched_disable_clear(struct panthor_arbitration_sched *sched,
+					     enum panthor_arb_sched_disable_reason reason);
+
+int panthor_arbitration_sched_on_request(struct panthor_arbitration_sched *sched, u8 aw_id);
+int panthor_arbitration_sched_on_idle(struct panthor_arbitration_sched *sched, u8 aw_id);
+int panthor_arbitration_sched_on_stopped(struct panthor_arbitration_sched *sched, u8 aw_id);
+
+#endif
-- 
2.43.0

