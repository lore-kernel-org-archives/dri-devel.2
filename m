Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710B9C982FA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 10:23:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3B6210E05B;
	Wed, 23 Sep 2026 10:23:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Dm5/Lt6C";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012071.outbound.protection.outlook.com [52.101.66.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C54CC10E05B
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:23:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AdaxN0D3aPoJqz2swppoQp5lIzYCZaNx5x/KDeM6xAUg+yAuyp8QGVTyRJolDcPDF570KEwDRuTS8/VA7uZjGSamKGBPOonNojjDJ2oiLmfKGPyV8iwqIiv+YD7s94pckDdztLkVmbv+zI/GGSIX15xfTdGwDsCdXqbSsmW72VomlmV5p3farRX4ypI0kNqUA1E4V1zNA3+24i/e8KMamYycCgKE0d7NtXaJlvuQa8VguHjiFd19i6hQHbwrPq6JUE2cPr4nkpO5wNgwkwACV9p3GyaF17EToLswEgGwo/pPUw2s74GzORvfg96yUvwacr2rpfSlSEj2UAdjyFMpPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tPUr5Atf0SAYRFCH60bBXHrezE6NpTgRsKIYhsP9yM=;
 b=ZrGmw1rcmWaI+UNKxB2NfClpNAhrdvr7PGpCIA6m2BccPV28r2f+XO7bsLk4Vv4wdTVRT7J+uqG1SXNMJQBZC2227VCKjAtBaEdoHriIY0uZGjYSXYkMycQr6GLlkEBtnFnJ9tNGbdLw+geJni+PY+xpouSFeTJ0vN/c7pABsQnySoA+XVCimQO2U9EdMMsNYqGjDjyhQXj+s7yG+uLBPc8MbSGXnL9W5gAXJkwsIe1Ox592jteI51NYoev8D4spEEdsi0jpHxGie2z269FOsygNoJ3oxqKO513SnAzrLqDCF37O97yGmQZjS25lcuNbMssgJPl4X5XVqajjXrxHzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tPUr5Atf0SAYRFCH60bBXHrezE6NpTgRsKIYhsP9yM=;
 b=Dm5/Lt6Cl569AJxAZQYhxpk43u/cEbNmjCDg0//xPhlUuRPZBJy7J5NyDeI4zOuvzJ8fT/va13+YUxSPZ6CLOjvOfg5TquNyuv1ez9AQsuIPDU8yqTWp7QNPx6+BwHtLkRkrZO5yQ0+7sDpwQXbHk60gYuUCgtcV1cphMKxlHNXGXFVh84cs9nBF5DtV6RpkI3w2+hCfNMNDv/YQFRL12RXmiDlQOMtx7VfqchLVuQJWhVFk4dsAyB0dlwPJy4rjfBDg1dap7rPlvnDRZUY6G97YAuVnpuYWmGHTA4ipmYpZe0whH3pdXWgjqk6YPEU6TZ0s3+NnOMQ5Ynh6C628wA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9222.eurprd04.prod.outlook.com (2603:10a6:102:2a1::18)
 by GV2PR04MB11958.eurprd04.prod.outlook.com (2603:10a6:150:2f3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Wed, 23 Sep
 2026 10:23:03 +0000
Received: from PA4PR04MB9222.eurprd04.prod.outlook.com
 ([fe80::4bc5:69c:dff8:17dd]) by PA4PR04MB9222.eurprd04.prod.outlook.com
 ([fe80::4bc5:69c:dff8:17dd%4]) with mapi id 15.21.0428.015; Wed, 23 Sep 2026
 10:23:03 +0000
From: ryan.zhang@oss.nxp.com
To: boris.brezillon@collabora.com, steven.price@arm.com, liviu.dudau@arm.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Ryan Zhang <ryan.zhang@oss.nxp.com>
Subject: [PATCH v2] drm/panthor: dummy read to discard the stale first
 GPU_TIMESTAMP read
Date: Wed, 23 Sep 2026 18:24:48 +0800
Message-ID: <20260923102448.2279852-1-ryan.zhang@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921102957.1024029-1-ryan.zhang@oss.nxp.com>
References: <20260921102957.1024029-1-ryan.zhang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0020.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::10) To PA4PR04MB9222.eurprd04.prod.outlook.com
 (2603:10a6:102:2a1::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9222:EE_|GV2PR04MB11958:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d826739-1bb7-464f-84e9-08df195ca688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|7416014|23010399003|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: YWx+Ar7b+sBno6ee7joedu5ab6oIjViVnJWmQEup7pz1Gbvs2z0W0Hkf1IoLT5vF/6FihNzXGi0jfp4tk4QJTrDLGP2RkA1iecmhFtXvTXy+aAkprxihqov04RDSbcRAEjds3uQCkzjRqNJBSrsySOPo7FChVarSQ1rzNJNlBjyy2hulESV8qSooG0IZzmQTRAYy/eyRr5I8MOFgVApG6zlrsFULilMEo/vrVJKsfrkO6OZJKZUZm+uOkDPp7iJHtd74HAM5eXwsD3yzuQn+MYIAe0e5+AK9n6DV/ALChVdLae5fNVvR23nkxe+nZxF/FGwbqnxAturD6IpJRzxohqGeC/8g2Vp8nHWDD9gmi6ulhqY2/1Xzcu/jeDjJIsz+QaIUG82fFVLzhq2EXjbGeWAyYVwFoXSWFF6kB9DWg0m4CQClx1ON2RXqjT+VXKr+LcrCBNwfDrEkIlUJDSzrEoP6WxYZwymT9DM/Pz4BdiDRt7N5OZ896O0wiUpXBzqRdFKM3WhEQ6q/DiB5errB8GdOzDh+g0NVAPMfNLOrawJl5I643u+rwH3ydlgIMleOjUl1T0dOBkQRs6lTRbblXqx4OEnzA7MosppkULrIzdHMPVYk4ysGqQgDFBGGh07aVkRPJiTxzANjAHArkEtp4dasnH8xKPvqBrXDxFnxBpk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB9222.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(7416014)(23010399003)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R4/VkuegaeCVeSkZkDJZC/QUAY4oN4tctfnIKKik91b4T9vSejAGYY4rlLS+?=
 =?us-ascii?Q?A7GKbQqjsRf2SR9McIV3gDsS2PHSDE9JM1LRph6N1M0W3DuM3Rl6QuZcRa2b?=
 =?us-ascii?Q?iP2xYOmkQmKsehAgBxFFejFD8JCDqUefi0qXcPIZEbCJ2daKzGT/6wqPnsCQ?=
 =?us-ascii?Q?pUvVbnyqTt5ZSTGSNpcQJWixgO+McHzP51e2w508kwVyKWewt/hcyViP3HFF?=
 =?us-ascii?Q?4H7n1CZN5ps12JEI3sFN4tZZ+42WHls9Yy6CBj4awuW70+PAUWM9lDu/r8oy?=
 =?us-ascii?Q?wjKBOfmkj9S8brd+C8WnFc4fzXDnI/zKYuI2tYXX+5r4G4wOqm13Ytsfw3Z3?=
 =?us-ascii?Q?LC6o9Ve8KYClzk6yqJdFFodQHJYKAC/sjWB2hxN90yZD4mrI2tk433oSaKB2?=
 =?us-ascii?Q?niLCBWzPq/QjVNc+FAJ6mRhuwfQZE4cPvislK1aQXmam/8K6SyzR/GjRh0CS?=
 =?us-ascii?Q?3RhgkxZIZlSY6yWRyrFP2w2HuOg/SEJ66tydzCSws5Sck7w1JwEKDBIALy6M?=
 =?us-ascii?Q?HPIGvOcNfqRHPg5yHhi86uzFAF8h6iThu37TpyEvhj3/j7heswd2u5CsYC6R?=
 =?us-ascii?Q?90HZhRC6RzdHAQNhZ9/SU2esEiqkZm7X6MjGegfC2LMXksNQMPJB01Yf8lzI?=
 =?us-ascii?Q?6DEPsZRABn6uEaOFGok3VToirypgy++irPKgWzUNxiPvqEnLNDijgo5GZumn?=
 =?us-ascii?Q?LfSb5H2kTvZENSjQp0mZcqySzFIYo2aztoIbkXhfM/to/Li+S7xrLX1LqSFR?=
 =?us-ascii?Q?xQuMKSy+Q2pT45LXz47Z9tNo2Wzyrgvqn2Bae4iJaRDeuiHjSpBYHy1eXJan?=
 =?us-ascii?Q?WNFM17peSHPIApewzeAUTdbWjlPXQy4zAeKESbgPUltqmWj5xukc1ownGsel?=
 =?us-ascii?Q?rw//gn1WPYtXZwySIWXiYIQVKjejccvQq5djDcMBMVj/FSbjuLx2NXHcH4e8?=
 =?us-ascii?Q?G2JlPWB1CMnFQNHe1Ax39Lag71KkwQgsfK2WOshj7WrCUxbUpvfjAkydx4mS?=
 =?us-ascii?Q?Pb8jjjpaQWtDdlA3I1FxSe2o9kY9E7Ea+49S+E50X9nTfBih96tD3ze7vEZ0?=
 =?us-ascii?Q?L/JEj3EE95KD5sINudSHxvgTla21uHa4BiZQE5TZpkxH3KFthi6/WU0UuS0h?=
 =?us-ascii?Q?+yxqnMixpdf3lSt3aYWBL1OwuoTXrl7qYBDE8UzMzrv/Lxxl2W3RCB5T1z2e?=
 =?us-ascii?Q?FOMOefdJVRITL+gAjm/zVUAx025PtJ6uXteco5sDTRWLouPZ0Gw5MjRR99er?=
 =?us-ascii?Q?5T+64kab+RX3lwK60nETkE6iEVGDFKcCkUblAklRAsI+uejjIPV7IMA+u0WJ?=
 =?us-ascii?Q?eFBCtUBjl10kNrjyaLbxNisLvuNaYeSdjjm3GYPej/oTYxdgn3bYEAc0Z4Po?=
 =?us-ascii?Q?r6OUuzfZ0fOVpsjJHoxA/3V5Q8ctggMQYO4XVsOSeqMGNxuuIMnepztyIQYz?=
 =?us-ascii?Q?+7Ayiw9zXyszaWEUjUi/Dg5z8X8gL4OWGDLrxY21KUSpTxrqCtewntdl5xBI?=
 =?us-ascii?Q?g12C5uWj9GUT37mPitlLhKHAitVN2b6drO5LWCbL/t/T5axlSdM79QEPeWO9?=
 =?us-ascii?Q?NbHxkAYoCWcNEw3gkVbA5q+nHqnrksF4FZUpd9u4lMFFJudlSfpcz3zuuGc+?=
 =?us-ascii?Q?jXT++9r9++C/k3c/ViReYVxlzywHhdoxEaEHqVCwhsRzHGGCvVDHZjj5wDnd?=
 =?us-ascii?Q?1/9zlg9NXigjl1VxMipeBS96gsSWe334r144bcceLu2ejl3+D8MCAUyn0sfF?=
 =?us-ascii?Q?IgNdEEeZ4pFRG3xpB9R17Q3+B5s4ZnsEeXIABtzLnYAuclJp+BMB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d826739-1bb7-464f-84e9-08df195ca688
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9222.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 10:23:03.5158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u2asheg6P9pLg2iMu6z+s09xMgB0DqizlSBUG7Ve5UZZHB+UWyQmtstNnCK/jFGq3Y93eQ+VKqoWZV1ZkMu5bTzLxgLDnkKvNtm1n/SNFwM2Uftj3EYfsG0+79kCkcmW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11958
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

From: Ryan Zhang <ryan.zhang@oss.nxp.com>

The first read of GPU_TIMESTAMP after the GPU has been idle can return a
value that lags the real counter, while a read issued immediately after is
accurate.

Userspace correlates this timestamp with the host clock, so a stale value
shows up as skew between the device and host time domains and makes
dEQP-VK.pipeline.monolithic.timestamp.calibrated.calibration_test fail
whenever a query happens to hit a large first-read error.

Signed-off-by: Ryan Zhang <ryan.zhang@oss.nxp.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
---
v2:
 - Added the r-b in commit msg.
 - Rebased on drm-misc-next to resolve conflict.
 - Moved the dummy read into panthor_gpu_get_timestamp() to align with
   the refactored timestamp query code on drm-misc-next.
Note: The original v1 patch was based on v6.18 and applied cleanly there.
Could we also port v1 into 6.18?

 drivers/gpu/drm/panthor/panthor_gpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index a383b04f101e..b8df5663f04e 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -2,6 +2,7 @@
 /* Copyright 2018 Marty E. Plummer <hanetzer@startmail.com> */
 /* Copyright 2019 Linaro, Ltd., Rob Herring <robh@kernel.org> */
 /* Copyright 2019 Collabora ltd. */
+/* Copyright 2026 NXP */
 
 #include <linux/bitfield.h>
 #include <linux/bitmap.h>
@@ -470,6 +471,9 @@ void panthor_gpu_resume(struct panthor_device *ptdev)
 
 u64 panthor_gpu_get_timestamp(struct panthor_device *ptdev)
 {
+	/* Dummy read to avoid stale values. */
+	gpu_read64_counter(ptdev->gpu->iomem, GPU_TIMESTAMP);
+
 	return gpu_read64_counter(ptdev->gpu->iomem, GPU_TIMESTAMP);
 }
 
-- 
2.43.0

