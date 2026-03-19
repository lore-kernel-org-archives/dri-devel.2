Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 632CA1075273
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 08:27:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8D1510E8E4;
	Thu, 19 Mar 2026 08:27:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="KuaBtdkO";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KuaBtdkO";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013015.outbound.protection.outlook.com
 [40.107.162.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A32310E8E7
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 08:27:09 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=m2Ox05L7p0pO8PbtmesplJ/VBh0sk5i90MR21YIqcVUxDq5+xzaPIfyOZ/XlwOzt78FqNnzYvIASxhhcv5fDsIxeZ2Nr+ExbRwYM3kplWaIgwT0m+ki2jRJd+j/Doqzh8zkhpeFLbZ/imcUtx5SfJCKx7suY+lWu4icrjH23ApSnX2zLbAJCWWy4AvSeGlmRWC7HirpixaLRx9xgRPQnjze8UVKBT252X9qCwpGymJuXX1/daERhWrrWs5JJuyiGLlvLtNPrvfjx+9RU+PXAuvXwPFxXqQGXyI2Xik83bXiReACP3V9Cbm7BzKvKvcqIqThuRa9nSZCA/0Yl3kaklQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7ddZ5lXI3r9H0UpcRht6oNkN8sn0eV67meiztbCVaA=;
 b=jkdPyb7500lZfEYjptismIJCpH7hu7VZvtArl7kDfnTgqZq8w0qbaZvbbe8lgIEGST+yuSWxU44ZYW/EsB721E02cW+3enP0ob2ivV/UO+tgxxMjGtuxteUkrMRXTj4uHeXVV76r7suN2++oO545B7LAyfCUGT6Z+wjQGrXvYScpH8cKZ1S/oCTFocAIoVIALfSun+fgdIaJkHV5F7WIkbwRLVxMNTs/Kq0p85iR7CF6GdD9E4evD+y3jNZYZZPLk6XNpHHJVKui1dpg8MXTQSWBDSnUqCIWK/nKcxADcIOUh52enP43D7mu7K/IxOB/PoQ/ItvGVexRV0uGXI3RDQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=collabora.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7ddZ5lXI3r9H0UpcRht6oNkN8sn0eV67meiztbCVaA=;
 b=KuaBtdkO8IRgVuELzjogpV/GrKAWb3JgbMRuV9/Tw0oyoRm+K9FP+cdx/WTbmhY1DH1EbD2DmI42y5kTLPQWt/DCNM8qgXpZRnFl7izk9X3CmSg2sIjv+XyLhuet5eYZrnomSuedPyueNptA/nw1cxifr0dBOwJv7wX9ymDhMo4=
Received: from DU2PR04CA0248.eurprd04.prod.outlook.com (2603:10a6:10:28e::13)
 by AS8PR08MB6472.eurprd08.prod.outlook.com (2603:10a6:20b:336::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 08:27:01 +0000
Received: from DB5PEPF00014B98.eurprd02.prod.outlook.com
 (2603:10a6:10:28e:cafe::c7) by DU2PR04CA0248.outlook.office365.com
 (2603:10a6:10:28e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Thu,
 19 Mar 2026 08:27:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B98.mail.protection.outlook.com (10.167.8.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19
 via Frontend Transport; Thu, 19 Mar 2026 08:27:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wNcSszJuT/Uzg2LyxTKcLR1TN20reYs3C4OXC+oTTwdWpwy5VvmBUH190gkTba6C/W5r/jb4RKO/n/GysyuX2vDf9aE7GmiIQC2MZJDoIID6jg46RCvkhLLSV+QfuW5K7HWQVXET9+kTgZMGgV9INkOnmERk5Rb8ASmJq9tlk5NPWmXCLtDLWCqPWw4W31z9HR+LN64MD0TckCiHRr4jcaRz5j+RHb+sBPUDOi91yck/5zzXwq+y6DQFrkQiW8zWRqQPc1itezxKvACu5mOteeuxXGABFYhyPFhG7y0+BDkhj9m+T+IqQtT8B0C5ZbTziRMrk+a2NgwL9I6WHfkLdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7ddZ5lXI3r9H0UpcRht6oNkN8sn0eV67meiztbCVaA=;
 b=HoFyn9XmZP+EnhyDhWZRst+AEzKsTeqVRQzDkjrCElgnVP97e87eineXdItcm/HLRy0xNfEbOOIhKuzfIM8WnW48cXamzOIM7u5BdnLnA164FpHnGj++zqX9GtdyqX7icrzizC3PpB/TTAWKciaIWjBKjc77OcRJT+sjGIyXsCM+4/bYzARGurFFX8JAI9WckEA1i2hf5GNXH4pCo0OC9MZTvOLNI0oSLafsUJIBWchywPI7nA+iIOK6DptopGq+5fd75bYb5Y4NW7apcOj1dLHBx6PWL1tWSBO9KGYWL20YxVMNw26RfALtDG7PgZZc9v8HgMW2K25fQI8HvC4joQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7ddZ5lXI3r9H0UpcRht6oNkN8sn0eV67meiztbCVaA=;
 b=KuaBtdkO8IRgVuELzjogpV/GrKAWb3JgbMRuV9/Tw0oyoRm+K9FP+cdx/WTbmhY1DH1EbD2DmI42y5kTLPQWt/DCNM8qgXpZRnFl7izk9X3CmSg2sIjv+XyLhuet5eYZrnomSuedPyueNptA/nw1cxifr0dBOwJv7wX9ymDhMo4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAWPR08MB9996.eurprd08.prod.outlook.com (2603:10a6:102:35a::11)
 by VE1PR08MB5821.eurprd08.prod.outlook.com (2603:10a6:800:1b2::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 08:25:54 +0000
Received: from PAWPR08MB9996.eurprd08.prod.outlook.com
 ([fe80::5856:8db5:9ee6:414f]) by PAWPR08MB9996.eurprd08.prod.outlook.com
 ([fe80::5856:8db5:9ee6:414f%6]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 08:25:53 +0000
From: Marcin Slusarz <marcin.slusarz@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 dri-devel@lists.freedesktop.org, Chia-I Wu <olvaffe@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Lukas Zapolskas <lukas.zapolskas@arm.com>,
 nd@arm.com
Subject: [PATCH v2] drm/panthor: extend timestamp query with flags
Date: Thu, 19 Mar 2026 09:25:51 +0100
Message-ID: <20260319082551.841182-1-marcin.slusarz@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318112952.645160-1-marcin.slusarz@arm.com>
References: <20260318112952.645160-1-marcin.slusarz@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0310.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::18) To PAWPR08MB9996.eurprd08.prod.outlook.com
 (2603:10a6:102:35a::11)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: PAWPR08MB9996:EE_|VE1PR08MB5821:EE_|DB5PEPF00014B98:EE_|AS8PR08MB6472:EE_
X-MS-Office365-Filtering-Correlation-Id: eddb007f-e239-4347-bcda-08de85914afa
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info-Original: d491soM7yenZTv/4U8mkfAb2scCgEYTRA/pUHY+Z3s93q0MZhOTkbkaqCLCgRD/ucrGxdP02KqqnM3b4Q+BF8/nYvuHgqaSI4lTwoEpRE89a9AWf/uba16q5+Eq1vJfiDbQTCXv2Of+z+ACe55b0X5GBk6IX8N2dwD1qsHDXazKgFjf0itgmE8tPKTxXgJXYGkFsJA4bLbYlCy3UuSxZ2qz+grNXadTcOA4iozZOewsd5NoWJhz3AHYcfY3V2YeJCun616DnOC3kdcjmtcy1LWbBhSh3jC/N16UiOAaVfL0hYFwuiGpHBLkk1nX9wlI/S9Bd+sTN/GhwxXk21s/5t2CXqQfXfuyttveZRyWl7HZKgPBwz0/DpOEnJNzR0PEkriStGIUS6glornjFjTvyjNRnUdJKHRa5TCtp3Bsv7LsE0PfLwlJcBWSs2XS7xk56Ms3Td74TLda8gGIE+AZYDC3oPuM1Mpzk6jg2gy1rZcaEk7M36RaeRG2nkCBEGVQtQqEgXMGMWRr1ix6blvin7jK50b0DlLHLUmi9s8d+Z++AEARekKCRV5jujaiS+mzqCrGLyvccnmzOFOBsXsCNteQb8TM7isrKGJ1+ClEUyE/THk46F61RVvkma74DlxHa8262gIUwW358iGk8YOrmLjXVKylXTC7O85NxVOKuqO5mdJVHHriSr3R6rE59ctUDkbgYywjmOE4zI0CbS3c0v7gy866FvpOGbgynY5ei8oE=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAWPR08MB9996.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: hlY/uinaaTJSQi48xaeNZjBh4fc2hp2C6CM944y+QSYiZT6x8jQ5oeZVrGZQl4RAUZrGM14UV615rwFbiSsbR6gT7v1Gl+flTcGf5YPsjTen5z7Y2V8nnR6BIlax4wMAX1DP0CbtND+ALbu47NwVx0y0izYZIsfnHgw0GvqKIoRCv5VQOQJPMlgjfOCc+yPHFnQI3w9yRaBVxUEgTAPMwCCUURGrrfUccql4qksEJRHt4swUlub+9hsWQr6uVZWFKcYExnl84BJjObed7OrjFSXcVPB9t3UDYu//DeMiNC5aV3DnmRsjjnJctBhE/STbS7C2T1/OZ1kClFKJJl/E3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5821
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5PEPF00014B98.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 094372c6-00bb-4a0d-44ac-08de859122d3
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|82310400026|36860700016|1800799024|14060799003|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 59MVeh3XqxCDJLebXcejP8dgYKfMdmvfDtZmor0F7tf/RZniDfkR6I9YoQZ8CmxRD8CZYMhXfwjOQeg67vUB45dTKpfqxS4BG2ql87pdRZLjGHc+0Up/MXeVrpzmrZPD+gq7FWin3PZrigZH8kDkQXfR9Y8J8RR0vOfXsl9oK/mJY5HLN2rvPBzWnQjvVeeb2TWKPKnt4dgxGnIpxh/egbW5HUeTOLNG9uX+nUgBYe8UlL6Rp86I5BMwN7CQw78WtSp7bUlIkckA6zD9Jdig1ZTGpcnkByDTA4WRHTKxY+6Hjy24bl2aUIA82gDENoRA3DM78o9P0eGO49DFX53B5PKwWQjyKAxzbIkClVsPTipdpdtAjLUD2HqV9SThl30ffApn3jlIwmcamci/RodpR75K4QVCxOk+H2LuMlygiJoCeR+1xwBs8VV1s7kvvOYdn1pkh9lncMD90eGW0mrbeJMxJMGwxVqblKxyyS3l5vc2AsuEF/Oc6DayE5LgXfFgITmJue0FKt8gplLzNDgKhCF6nCyYVIye7Pje6LTUaTdWkyI4ekpy+vXRIesGF9wWPOwe20FE6Be8U/9/UcOZjdqe8+SlRhdkD5uG9nRbMnZWspS4VF3TxSJ2eDizCz8McZohV220TOoAjBE9czSBYmfeTAHAXIwqlAJjaGSJEGO2OrNOlteB0QFN5hwoGYAEBsTJUShJ6GBW2V3i0u5iG8W02Z2IL/zwrAsT9L2+APzZ5Po1py0711zZrwyfKHt/XKPQJrFk8bAbAYWeNuIoGg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(82310400026)(36860700016)(1800799024)(14060799003)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: S2+EZbYCfDGeFSupA+2K55UBkn+p8RYxMVgS3Nvt9I9nXBcTk4pDtjzMrBlbT05B36BqrbKegBDrvj5LSzyR+muaZSK09xlZjxH7o5Psbvm1UeC7xTVDCREgXMcE9aY8tBtoUDwgR88NP3bhX4GE+wd6ZC7fRovVTSMteWsxsjyQGlHpw7mMage9wlxPbf5cHz84cm6mfFc05M86hp/LeOD2NvLaA+b80XzB7goPE853FUepjh9zJDs8iZ6RUU3/F0F4xO0aZBO+LC59D+CDvAPJ+LrRCW4rd5ttOluY3g6yoVZGA6ZHA27H9uT1qaQ3Gmf3dKOApAilCBrt79VP5m3SQJ8qA+MblkQLiwcD3MOYjwdlEsImu9tcFAB+E2fqFqziO7TzVNZMxb5vuV4xX1N19v+5doYqX9VXKqSYA6kwaLYMzBjLdGFP2fEuVWrF
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 08:27:00.6637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eddb007f-e239-4347-bcda-08de85914afa
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B98.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6472
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

Flags now control which data user space wants to query,
there is more information sources, and there's ability
to query duration of multiple timestamp reads.

New sources:
- CPU's monotonic,
- CPU's monotonic raw,
- GPU's cycle count

These changes should make the implementation of
VK_KHR_calibrated_timestamps more accurate and much simpler.

Signed-off-by: Marcin Slusarz <marcin.slusarz@arm.com>
---
Changes in v2:
 - added DRM_PANTHOR_TIMESTAMP_CPU_NONE
 - cpu_timestamp_nsec extended to u64
 - pad1 removed
 - copy_from_user -> copy_struct_from_user
 - looking at size replaced by looking at flags
 - more comments
---
 drivers/gpu/drm/panthor/panthor_drv.c | 125 ++++++++++++++++++++++++--
 include/uapi/drm/panthor_drm.h        |  58 +++++++++++-
 2 files changed, 175 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 165dddfde6ca..b6a100ce389d 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -13,7 +13,9 @@
 #include <linux/pagemap.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/sched/clock.h>
 #include <linux/time64.h>
+#include <linux/time_namespace.h>
 
 #include <drm/drm_auth.h>
 #include <drm/drm_debugfs.h>
@@ -765,18 +767,123 @@ static int panthor_query_timestamp_info(struct panthor_device *ptdev,
 					struct drm_panthor_timestamp_info *arg)
 {
 	int ret;
+	u32 flags;
+	unsigned long irq_flags;
+	struct timespec64 cpu_ts;
+	u64 query_start_time;
+	bool minimize_interruption;
+	u32 timestamp_types = 0;
+
+	if (arg->flags != 0)
+		flags = arg->flags;
+	else
+		flags = DRM_PANTHOR_TIMESTAMP_GPU |
+			DRM_PANTHOR_TIMESTAMP_GPU_OFFSET |
+			DRM_PANTHOR_TIMESTAMP_FREQ;
+
+	switch (flags & DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK) {
+	case 0:
+		break;
+	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC:
+	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW:
+		timestamp_types++;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (flags & ~(DRM_PANTHOR_TIMESTAMP_GPU |
+		      DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK |
+		      DRM_PANTHOR_TIMESTAMP_GPU_OFFSET |
+		      DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT |
+		      DRM_PANTHOR_TIMESTAMP_FREQ |
+		      DRM_PANTHOR_TIMESTAMP_DURATION))
+		return -EINVAL;
+
+	if (flags & DRM_PANTHOR_TIMESTAMP_GPU)
+		timestamp_types++;
+	if (flags & DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT)
+		timestamp_types++;
+
+	/* If user asked to obtain timestamps from more than one source,
+	 * then it very likely means they want them to be as close as possible.
+	 * If they asked for duration, then that likely means that they
+	 * want to know how long obtaining timestamp takes, without random
+	 * events, like process scheduling or interrupts.
+	 */
+	minimize_interruption =
+		(flags & DRM_PANTHOR_TIMESTAMP_DURATION) ||
+		(timestamp_types >= 2);
 
 	ret = panthor_device_resume_and_get(ptdev);
 	if (ret)
 		return ret;
 
+	if (flags & DRM_PANTHOR_TIMESTAMP_FREQ) {
 #ifdef CONFIG_ARM_ARCH_TIMER
-	arg->timestamp_frequency = arch_timer_get_cntfrq();
+		arg->timestamp_frequency = arch_timer_get_cntfrq();
 #else
-	arg->timestamp_frequency = 0;
+		arg->timestamp_frequency = 0;
 #endif
-	arg->current_timestamp = gpu_read64_counter(ptdev, GPU_TIMESTAMP);
-	arg->timestamp_offset = gpu_read64(ptdev, GPU_TIMESTAMP_OFFSET);
+	} else {
+		arg->timestamp_frequency = 0;
+	}
+
+	if (flags & DRM_PANTHOR_TIMESTAMP_GPU_OFFSET)
+		arg->timestamp_offset = gpu_read64(ptdev, GPU_TIMESTAMP_OFFSET);
+	else
+		arg->timestamp_offset = 0;
+
+	if (minimize_interruption) {
+		preempt_disable();
+		local_irq_save(irq_flags);
+	}
+
+	if (flags & DRM_PANTHOR_TIMESTAMP_DURATION)
+		query_start_time = local_clock();
+	else
+		query_start_time = 0;
+
+	if (flags & DRM_PANTHOR_TIMESTAMP_GPU)
+		arg->current_timestamp = gpu_read64_counter(ptdev, GPU_TIMESTAMP);
+	else
+		arg->current_timestamp = 0;
+
+	switch (flags & DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK) {
+	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC:
+		ktime_get_ts64(&cpu_ts);
+		break;
+	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW:
+		ktime_get_raw_ts64(&cpu_ts);
+		break;
+	default:
+		break;
+	}
+
+	if (flags & DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT)
+		arg->cycle_count = gpu_read64_counter(ptdev, GPU_CYCLE_COUNT);
+	else
+		arg->cycle_count = 0;
+
+	if (flags & DRM_PANTHOR_TIMESTAMP_DURATION)
+		arg->duration_nsec = local_clock() - query_start_time;
+	else
+		arg->duration_nsec = 0;
+
+	if (minimize_interruption) {
+		local_irq_restore(irq_flags);
+		preempt_enable();
+	}
+
+	if (flags & DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK) {
+		timens_add_monotonic(&cpu_ts);
+
+		arg->cpu_timestamp_sec = cpu_ts.tv_sec;
+		arg->cpu_timestamp_nsec = cpu_ts.tv_nsec;
+	} else {
+		arg->cpu_timestamp_sec = 0;
+		arg->cpu_timestamp_nsec = 0;
+	}
 
 	pm_runtime_put(ptdev->base.dev);
 	return 0;
@@ -851,8 +958,13 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
 		return PANTHOR_UOBJ_SET(args->pointer, args->size, ptdev->csif_info);
 
 	case DRM_PANTHOR_DEV_QUERY_TIMESTAMP_INFO:
-		ret = panthor_query_timestamp_info(ptdev, &timestamp_info);
+		ret = copy_struct_from_user(&timestamp_info, sizeof(timestamp_info),
+					    (const void __user __force *) args->pointer,
+					    args->size);
+		if (ret)
+			return ret;
 
+		ret = panthor_query_timestamp_info(ptdev, &timestamp_info);
 		if (ret)
 			return ret;
 
@@ -1680,6 +1792,7 @@ static void panthor_debugfs_init(struct drm_minor *minor)
  *       - adds DRM_IOCTL_PANTHOR_BO_SYNC ioctl
  *       - adds DRM_IOCTL_PANTHOR_BO_QUERY_INFO ioctl
  *       - adds drm_panthor_gpu_info::selected_coherency
+ * - 1.8 - extends DEV_QUERY_TIMESTAMP_INFO with flags
  */
 static const struct drm_driver panthor_drm_driver = {
 	.driver_features = DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ |
@@ -1693,7 +1806,7 @@ static const struct drm_driver panthor_drm_driver = {
 	.name = "panthor",
 	.desc = "Panthor DRM driver",
 	.major = 1,
-	.minor = 7,
+	.minor = 8,
 
 	.gem_create_object = panthor_gem_create_object,
 	.gem_prime_import_sg_table = drm_gem_shmem_prime_import_sg_table,
diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
index b401ac585d6a..8a46ef040c3d 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -409,6 +409,38 @@ struct drm_panthor_csif_info {
 	__u32 pad;
 };
 
+/**
+ * enum drm_panthor_timestamp_info_flags - drm_panthor_timestamp_info.flags
+ */
+enum drm_panthor_timestamp_info_flags {
+	/** @DRM_PANTHOR_TIMESTAMP_GPU: Query GPU time. */
+	DRM_PANTHOR_TIMESTAMP_GPU = 1 << 0,
+
+	/** @DRM_PANTHOR_TIMESTAMP_CPU_NONE: Don't query CPU time. */
+	DRM_PANTHOR_TIMESTAMP_CPU_NONE = 0 << 1,
+
+	/** @DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC: Query CPU time using CLOCK_MONOTONIC. */
+	DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC = 1 << 1,
+
+	/** @DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW: Query CPU time using CLOCK_MONOTONIC_RAW. */
+	DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW = 2 << 1,
+
+	/** @DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK: Space reserved for CPU clock type. */
+	DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK = 7 << 1,
+
+	/** @DRM_PANTHOR_TIMESTAMP_GPU_OFFSET: Query GPU offset. */
+	DRM_PANTHOR_TIMESTAMP_GPU_OFFSET = 1 << 4,
+
+	/** @DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT: Query GPU cycle count. */
+	DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT = 1 << 5,
+
+	/** @DRM_PANTHOR_TIMESTAMP_FREQ: Query timestamp frequency. */
+	DRM_PANTHOR_TIMESTAMP_FREQ = 1 << 6,
+
+	/** @DRM_PANTHOR_TIMESTAMP_DURATION: Return duration of time query. */
+	DRM_PANTHOR_TIMESTAMP_DURATION = 1 << 7,
+};
+
 /**
  * struct drm_panthor_timestamp_info - Timestamp information
  *
@@ -421,11 +453,33 @@ struct drm_panthor_timestamp_info {
 	 */
 	__u64 timestamp_frequency;
 
-	/** @current_timestamp: The current timestamp. */
+	/** @current_timestamp: The current GPU timestamp. */
 	__u64 current_timestamp;
 
-	/** @timestamp_offset: The offset of the timestamp timer. */
+	/** @timestamp_offset: The offset of the GPU timestamp timer. */
 	__u64 timestamp_offset;
+
+	/**
+	 * @flags: Bitmask of drm_panthor_timestamp_info_flags.
+	 *
+	 * If set to 0, then it is interpreted as:
+	 *  DRM_PANTHOR_TIMESTAMP_GPU |
+	 *  DRM_PANTHOR_TIMESTAMP_GPU_OFFSET |
+	 *  DRM_PANTHOR_TIMESTAMP_FREQ
+	 */
+	__u32 flags;
+
+	/** @duration_nsec: Duration of time query. */
+	__u32 duration_nsec;
+
+	/** @cycle_count: Value of GPU_CYCLE_COUNT. */
+	__u64 cycle_count;
+
+	/** @cpu_timestamp_sec: Seconds part of CPU timestamp. */
+	__u64 cpu_timestamp_sec;
+
+	/** @cpu_timestamp_nsec: Nanseconds part of CPU timestamp. */
+	__u64 cpu_timestamp_nsec;
 };
 
 /**
-- 
2.34.1

