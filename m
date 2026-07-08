Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08567C44506
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:25:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BF5810F3FC;
	Thu,  9 Jul 2026 07:25:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="lz1+ar8f";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010025.outbound.protection.outlook.com [52.101.69.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E604B10E420
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 03:14:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4pmaNVslyQBS3tX1UAbCvlkE32LYZ9yfYdWS2BzZqGQRv70hnK0MgpdXrlX/bWg2l2sDN6C+k1Ota95rl9JMf8xrC0fAW91eVQTZXFkR2zu1ZfTeBdLztGOK7yafXd12gnei+u8h4Xoa64wTioV33Zwf4wopH+UpDlviwzhq7wjDVW0gzfJ+pWVCeR1zOP9+1rLKVrxN0LKAWw6h8QD55StfgofV0bY+QZYSlXeXVjtAeVJop1BBqojcTgGlKaRGnxb5L6hHZH2feXpQps3tG02D+6V5SepMwRhH9AOExAoAN3kI0JSGRmHEWXhrzat5AkF6w2TeNkdBSG70V8iPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qjcyK1cCFgvCyzDTx5toqnW+UrBoSMQ+93XxrWqkb0=;
 b=ylv82P/JVYTjC1B7jrvJQEdRF9SxR8BIbkGcjCykUQ0xtrQ4SOuezVxKJKO3bySh9xSUXOGZ/2mHYrmkF+/oZ3YDq8EcBe94FmrBu2oVFlP3Ou8c7gAIOBjeq7+4f65+PepXau1rLraR3n0Jxk805OX+UKTeW1bTtteo+dGvGZ4E2K8eDR3tY60iVv6prCegWcNV5BdlIu8qPz4nMDQFphKfdH5qVetJKt6GTXfWwOIkTxax3Rwfud89ALLhD7gKjcx/CP/HIF9OwbwOKbx3TqBoF/nt5iNutgYB79X1pHhINGUAcUX4m2lQPDRclPIMG5jbdaWG8Q0ehQGM7v0ajg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qjcyK1cCFgvCyzDTx5toqnW+UrBoSMQ+93XxrWqkb0=;
 b=lz1+ar8fcyoySMHGucwoEMaLTwXEAeDjqvDJTUJKbcDp2ZwWgT589EGbG7ZhQV0wjUvmvVCm33GpBtLh0oppNcKVmOVjPcTd+nFi3wHtCvU1JgmHW92Prx1j6HS/ZAUSvXe8048DXQwCyXvpuhD3DU8ghG+7G/sJChCywBLrLC+myaScoYrANhb+rvkKMDnhO3qbjp0v6orft9nOBRnGQBhV2gg4zfGEhYZbd5Hp6sBLeghDrpKC3/ySoFjiKW+U7QK2UuTopehaeYmvY5KChVsjMgU2t+Oijnd6/Rp/MmoLAvXm12OjnoWakeGy1Ufja+P9n0LbSSnLBOEUn2aHfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GVXPR04MB12158.eurprd04.prod.outlook.com
 (2603:10a6:150:2bf::14) by AM9PR04MB8745.eurprd04.prod.outlook.com
 (2603:10a6:20b:43e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Wed, 8 Jul
 2026 03:14:47 +0000
Received: from GVXPR04MB12158.eurprd04.prod.outlook.com
 ([fe80::d658:d51d:2d08:4df4]) by GVXPR04MB12158.eurprd04.prod.outlook.com
 ([fe80::d658:d51d:2d08:4df4%7]) with mapi id 15.21.0159.013; Wed, 8 Jul 2026
 03:14:47 +0000
From: Guangliu Ding <guangliu.ding@nxp.com>
Date: Wed, 08 Jul 2026 11:24:28 +0800
Subject: [PATCH] drm/panthor: add gpu_load debugfs node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-master-v1-1-713a00fe35ec@nxp.com>
X-B4-Tracking: v=1; b=H4sIAOvCTWoC/yXMSQqAMBBE0atIrw1EF05XERdJLLUFB9Iqgnh3o
 y4f/KqLBJ4hVEUXeRwsvMwBSRyRG8zcQ3EbTKlOM53rTE1GNnhlWw10ZelMAQrx6tHx+R3VzW/
 Z7Qi3vWu67wc7rEtaagAAAA==
X-Change-ID: 20260706-master-bd0eef99ca8e
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Guangliu Ding <guangliu.ding@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783481069; l=6217;
 i=guangliu.ding@nxp.com; s=20260708; h=from:subject:message-id;
 bh=/KjV5/Ta7m3vqkrceZI/3X53CqdBn72ZvaRAd4Kly48=;
 b=jachVgpEe9We4RJTZvkI47caThgZjerEnHbQ8BaCPCeBdJ3ueY9pCLw4UD50ryoMHZjtPIRJ1
 MzpkjgwOVVDBk7xQNO1QaxPWwrOi5j/XM7XWPlJamyOOKzOxTr/UzF9
X-Developer-Key: i=guangliu.ding@nxp.com; a=ed25519;
 pk=Da4RaEF1NcViZJ9TRJpon0zA2ZTO+pVjE9uhYDniLUI=
X-ClientProxiedBy: MA5PR01CA0089.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a8::14) To GVXPR04MB12158.eurprd04.prod.outlook.com
 (2603:10a6:150:2bf::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12158:EE_|AM9PR04MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: 00d2ed07-f1d2-41d8-1aa5-08dedc9f10dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|19092799006|23010399003|56012099006|6133799003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: TdrNf1QLq1HTtBWfAwmVxWp1ZL1K18mlaYwKs0cSklJ8dPXg+y1idh/hoG0zVqyZq3qGmVVIchaDixVcDjQRlYS5AtOjVHIF5HI9RdoCVwHrBE2GKkaDQLwgcnWdSY0wtCyziIEdN8rbhtOr/xAS7bE8GANMuy4RjdVXsiIS0zt+LcPPH7XCiRNC5tJhgdKcX+8GDceIbYFrDUFLTJ6HUhsbCLPo9WfqdiBIlzPInaztcoR1b5FAjGUm/KfOgmOF4sWnlkzXWl8ZliUC/2inRzEkCDfUXc4fDI5BqnUZLnl90ZWkQv3GIkCY6gARGrDuOg1Y922ALEUeX2bZzzSEqXmWcW4hmWGl8N2ewpApg6QKamcFFy8TEVsiurEMBiQEJXgIyQFWQrVmc9IP6hmFIyaLpZYdGDs6xZ7LU5Tcu3+zEJgpHFNstfEPHnTfodDRSf0cAMGMtAxAnX2jeLXzpU+SiGmHbIYItR1Y4P4lkodaWYFREKyqvpwCNQovnC155Cm3SZwlUDzkuAbUi/b6PCjqiQ5W/YCMbxrt61GGt2V+zxXcMyUMU8FqwymSImXV7NHNf/5QQfJmpWdOPMhtc2DOTWnoUszBVVj0ZHVzeU2/bGvuz7oOt62XT+TGRXcXv4O7m3wJErB8QpBixNwxU6gmRHKxdVXp0rtO6oqpGJI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12158.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(19092799006)(23010399003)(56012099006)(6133799003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzgvWmhLbjRBUWlQMUYzVVhqNE9neGw2anlidjZ4RzFLSzlCVUdRRDVsR1hI?=
 =?utf-8?B?Vnl4ZmRjSUN3TzBmL0Vxc1dvem9XSGFtMHpxa2R2SVRXYVI2RUlhdmVHOHZY?=
 =?utf-8?B?WFpSc3hybTd2MEY2S0tmZHpwT25XU2hhNVcrWkJiL1VmRmhvWlJWK2lBQzZ4?=
 =?utf-8?B?akVMZzlMbVBtSk1YQUtlbE5vV2pCbHF3VU40eEM5ZStoaGErTERsb3lRT3kz?=
 =?utf-8?B?eXpRdmo4Ym5NWEFTVHFCTTRtK2ZWbUhQdjdFNGZQb2hLelNGTkliTWtqc1E1?=
 =?utf-8?B?V3JIWTArTGFmS09LdE1DdkhNUzN5MjNxR1A3OXJWZG53ZUEvMGlDS2RVZWw4?=
 =?utf-8?B?L0VqMmJyS3AraC9zcDVXOE1TckhCSUZLWTVCblA1TldTYXM4bEc4NDJxOXVp?=
 =?utf-8?B?Q0E4blc5RU9hYjlDZFg3QUpxUjBVeHJPbFBHNnRJZkluNU5VRExJR3JOdnkr?=
 =?utf-8?B?d09FYjNoY2JJMnh4WjRmQWUxRE1nN3h5cWRvQkZOQUxYZ01SMzA0aHpFYlBq?=
 =?utf-8?B?NUtmeU5adHhqR0JZUjh5RjZyVlgrYk5uL2FYQlVkMFdOU1JjUmNiblVEMWhl?=
 =?utf-8?B?dlhZemM1UUZ0ZDl4Y2liSXBRWEkrMGVwaVNLTXZWLzJjTGJtUXovOHVRYk1Q?=
 =?utf-8?B?ODFCYkQrZFcwMVcrdlNCZ0p4ZWVOMlBwOFdPd0EvNTlEV2tZY016ZXhTQXUx?=
 =?utf-8?B?UHJXU1lZN1VCejEwZFdXWjMwYUIyVUxEUTAxVWdhaDcyYjkxcCtJUTViRU1p?=
 =?utf-8?B?MjlieXk5MVJoNU5vM28zckZuVVJndS80aVQvUjNYMUdvNXFxcWtQUHI5ZHRy?=
 =?utf-8?B?VkcrdmJGM21oZ0NibCthZWU3NkJpNzN3aXlPR05KS1V5RWdFQTdjbTczQzdx?=
 =?utf-8?B?a0ZEOG42RW42Rm1pdTFGbTVlQ2NRZHJnREhYZVZ0NVNwc2JEQUxjTFZ6a0I1?=
 =?utf-8?B?Q0RSTVREOXRjUXZOWURxUndEbmw5SXVzMkZKMTRWMzI5cVJRdDNBMmdkSzJ5?=
 =?utf-8?B?RUJPSm9hcXRHcG9WVnk3Qy9ZVUhYM05ra2J4eFVyVUdCUlFtSEhFOU9CTGJ0?=
 =?utf-8?B?R05mYy9SVElmcll2cmtOQ0FacjROaktvbXhCVzI0dlAxRmM3K1lHTmdzd0xY?=
 =?utf-8?B?eU5DRjV4NXNQMjAwVHF3OXhESFZZRGU2TW1RUGdmRUxta1VhMGZuNXpRV2tU?=
 =?utf-8?B?QVU4TE9Md296Z1dvZkNhb0tja0t3eEJPb2w3U1NCYzIvaXJQb05tb3NPbmVq?=
 =?utf-8?B?ZEZHSFRlUG50Z2J3Y2FvNjVWZUIyc0lqVW9WRnkvcE9SSnZoYmZTY0daSUpa?=
 =?utf-8?B?UERvczF6VC8wQ08xN2dCZEw1dm8wQjJlZ2RESWg1czlMVzhvUGFrK1lIMkor?=
 =?utf-8?B?QWN6djRiSXlRUUMzQkN1eFdHeWQ3VWFHSGl5OVpBZDN2cFBVWGNoUmFRVmFi?=
 =?utf-8?B?ME5uamRZNlBabjRmeGxEQjBrbDFPSWhlY2I3NUh6L204d0lHUkl2ZWErM2Fu?=
 =?utf-8?B?LzU2VHRGdlNvNWIyWG56cGZGc0lwYmVUVnJmYWJCWVg2RUNrbzNKZ1dhS0JP?=
 =?utf-8?B?ZlNaM3VOeGxDczIyc01SZ005ZVd2TlBYL2lVNjY2MVRHWEZhaWc5RXNMb1Zv?=
 =?utf-8?B?N3lwVmZpN2dEcUZaSEhiSXkyaXpWQVpqa1N4UG12MFVGRUFKbGlFVDN0Vnd5?=
 =?utf-8?B?WkZSUUFieldselZmOXY2ajRQVFAyODA5ZFhET3NWTmJPVkVzQm10R2J1bm43?=
 =?utf-8?B?OFRZZlhTUGNOZGIveEkwVVZucnRENWpwRXVCV0NxWTBUb3FrcDhsNVJ3SC9y?=
 =?utf-8?B?eVlreFdCVzkvZmFEa3pHQ3FWMm1aMThPNjhtQXpoZDJRdzNGc2l6RlNodGFC?=
 =?utf-8?B?SHhUNm1zQ0tPNVFBaEpveFFCam51WTNsQnl2TE9vQ3B5YTZpbU9UMkJLS3RV?=
 =?utf-8?B?b0gvSERqRStsdEMvMVlaVTBybDRKKzJVU2ZxZ2NlTEkyL0F5OHgxc2RhK0dp?=
 =?utf-8?B?Rlp4WjFTL0dlOHpJSk9aVmJTOHhGcURvYzhTcmxBZ1Z1K1RtbVNwNm5TbHVU?=
 =?utf-8?B?UEZ3Q3JtVXB2NXppRGpmYVhENFdrVkRRSlFGS0IzT1NOSm1pYnhPa08vN2Vm?=
 =?utf-8?B?WFV4ekZ3ajdDMnF1YThBd1ljLzFTV3dUM2FFMk0xcU1ucWJRTHVqdEVFWWVC?=
 =?utf-8?B?SzFGSStLQ1pyUlFBeVBSTDVGSVcxMEdUNXB0enBWQ2kwcGVSQkZQTzRBYUlx?=
 =?utf-8?B?WUtsa3dGdkxlYkFIWkxhenVqeUtyeFNZaVhrOTRhZHdpRDZnSlhFNUU0Z2Ru?=
 =?utf-8?B?a0kxcmU1cTl2bk00aVZ4RElkSWpmbEZROUttNDdZTXZ2U2VuTGIvUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d2ed07-f1d2-41d8-1aa5-08dedc9f10dc
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12158.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 03:14:47.6461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZmF8C1eopNEE00MU/btHH/l9ChSNiBsMcQXb29AGdrEdYpr0C07TLNqZLriiJ5IpYopC2KzkT7UjWW1waN7EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8745
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:19 +0000
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

Expose GPU utilization via /sys/kernel/debug/dri/<N>/gpu_load.  The
file reports busy_time_ns, idle_time_ns and gpu_load %.

Values are snapshotted at the end of each devfreq sampling window
(~50 ms) rather than read from live accumulators, avoiding load swings
over short observation intervals.

The snapshot is cleared on suspend to avoid stale data when the GPU
is powered off.

Signed-off-by: Guangliu Ding <guangliu.ding@nxp.com>
---
Add /sys/kernel/debug/dri/<N>/gpu_load to expose GPU utilisation
from the last devfreq sampling window (~50 ms).
The file reports busy_time_ns, idle_time_ns and load percentage.

Tested on NXP i.MX95 EVK (Mali-G310 V2).
---
 drivers/gpu/drm/panthor/panthor_devfreq.c | 80 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_devfreq.h |  6 +++
 drivers/gpu/drm/panthor/panthor_drv.c     |  2 +
 3 files changed, 88 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/panthor/panthor_devfreq.c
index 2249b41ca4af..1b3f58ddfbd3 100644
--- a/drivers/gpu/drm/panthor/panthor_devfreq.c
+++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
@@ -1,12 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0 or MIT
 /* Copyright 2019 Collabora ltd. */
+/* Copyright 2026 NXP */
 
 #include <linux/clk.h>
+#include <linux/debugfs.h>
 #include <linux/devfreq.h>
 #include <linux/devfreq_cooling.h>
+#include <linux/math64.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 
+#include <drm/drm_file.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_print.h>
 
@@ -43,6 +47,22 @@ struct panthor_devfreq {
 	 * and panthor_devfreq_record_{busy,idle}().
 	 */
 	spinlock_t lock;
+
+#ifdef CONFIG_DEBUG_FS
+	/**
+	 * @last_busy_ns: Busy time in nanoseconds of the last completed devfreq window.
+	 * Updated by panthor_devfreq_get_dev_status() before resetting the counters.
+	 * Protected by @lock.
+	 */
+	u64 last_busy_ns;
+
+	/**
+	 * @last_total_ns: Total time in nanoseconds of the last completed devfreq window.
+	 * Updated by panthor_devfreq_get_dev_status() before resetting the counters.
+	 * Protected by @lock.
+	 */
+	u64 last_total_ns;
+#endif
 };
 
 static void panthor_devfreq_update_utilization(struct panthor_devfreq *pdevfreq)
@@ -101,6 +121,11 @@ static int panthor_devfreq_get_dev_status(struct device *dev,
 
 	status->busy_time = ktime_to_ns(pdevfreq->busy_time);
 
+#ifdef CONFIG_DEBUG_FS
+	pdevfreq->last_busy_ns = status->busy_time;
+	pdevfreq->last_total_ns = status->total_time;
+#endif
+
 	panthor_devfreq_reset(pdevfreq);
 
 	spin_unlock_irqrestore(&pdevfreq->lock, irqflags);
@@ -283,6 +308,17 @@ void panthor_devfreq_suspend(struct panthor_device *ptdev)
 		return;
 
 	drm_WARN_ON(&ptdev->base, devfreq_suspend_device(pdevfreq->devfreq));
+
+#ifdef CONFIG_DEBUG_FS
+	{
+		unsigned long irqflags;
+
+		spin_lock_irqsave(&pdevfreq->lock, irqflags);
+		pdevfreq->last_busy_ns = 0;
+		pdevfreq->last_total_ns = 0;
+		spin_unlock_irqrestore(&pdevfreq->lock, irqflags);
+	}
+#endif
 }
 
 void panthor_devfreq_record_busy(struct panthor_device *ptdev)
@@ -332,3 +368,47 @@ unsigned long panthor_devfreq_get_freq(struct panthor_device *ptdev)
 
 	return freq;
 }
+
+#ifdef CONFIG_DEBUG_FS
+static int panthor_devfreq_gpu_load_show(struct seq_file *m, void *unused)
+{
+	struct panthor_device *ptdev = m->private;
+	struct panthor_devfreq *pdevfreq = ptdev->devfreq;
+	unsigned long irqflags;
+	unsigned int gpu_load;
+	u64 total_ns;
+	u64 busy_ns;
+
+	if (!pdevfreq->devfreq) {
+		seq_puts(m, "devfreq not initialized\n");
+		return 0;
+	}
+
+	spin_lock_irqsave(&pdevfreq->lock, irqflags);
+	busy_ns = pdevfreq->last_busy_ns;
+	total_ns = pdevfreq->last_total_ns;
+	spin_unlock_irqrestore(&pdevfreq->lock, irqflags);
+
+	busy_ns = min(busy_ns, total_ns);
+	gpu_load = total_ns ? (unsigned int)div64_u64(busy_ns * 100ULL, total_ns) : 0;
+
+	seq_printf(m, "busy_time_ns: %llu  idle_time_ns: %llu  gpu_load: %u%%\n",
+		   busy_ns, total_ns - busy_ns, gpu_load);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(panthor_devfreq_gpu_load);
+
+/**
+ * panthor_devfreq_debugfs_init() - Initialize devfreq debugfs entries
+ * @minor: DRM minor.
+ */
+void panthor_devfreq_debugfs_init(struct drm_minor *minor)
+{
+	struct panthor_device *ptdev = container_of(minor->dev,
+						    struct panthor_device, base);
+
+	debugfs_create_file("gpu_load", 0444, minor->debugfs_root, ptdev,
+			    &panthor_devfreq_gpu_load_fops);
+}
+#endif /* CONFIG_DEBUG_FS */
diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.h b/drivers/gpu/drm/panthor/panthor_devfreq.h
index f8e29e02f66c..4552569abfe4 100644
--- a/drivers/gpu/drm/panthor/panthor_devfreq.h
+++ b/drivers/gpu/drm/panthor/panthor_devfreq.h
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 or MIT */
 /* Copyright 2019 Collabora ltd. */
+/* Copyright 2026 NXP */
 
 #ifndef __PANTHOR_DEVFREQ_H__
 #define __PANTHOR_DEVFREQ_H__
@@ -20,4 +21,9 @@ void panthor_devfreq_record_idle(struct panthor_device *ptdev);
 
 unsigned long panthor_devfreq_get_freq(struct panthor_device *ptdev);
 
+#ifdef CONFIG_DEBUG_FS
+struct drm_minor;
+void panthor_devfreq_debugfs_init(struct drm_minor *minor);
+#endif
+
 #endif /* __PANTHOR_DEVFREQ_H__ */
diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index e8dc4096c1d2..4093a6d21337 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -2,6 +2,7 @@
 /* Copyright 2018 Marty E. Plummer <hanetzer@startmail.com> */
 /* Copyright 2019 Linaro, Ltd., Rob Herring <robh@kernel.org> */
 /* Copyright 2019 Collabora ltd. */
+/* Copyright 2026 NXP */
 
 #ifdef CONFIG_ARM_ARCH_TIMER
 #include <asm/arch_timer.h>
@@ -1761,6 +1762,7 @@ static void panthor_debugfs_init(struct drm_minor *minor)
 {
 	panthor_mmu_debugfs_init(minor);
 	panthor_gem_debugfs_init(minor);
+	panthor_devfreq_debugfs_init(minor);
 }
 #endif
 

---
base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
change-id: 20260706-master-bd0eef99ca8e

Best regards,
--  
Guangliu Ding <guangliu.ding@nxp.com>

