Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87360C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 12:19:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41A7610E479;
	Mon, 21 Sep 2026 12:18:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VjhV0Msv";
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013047.outbound.protection.outlook.com [40.107.159.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5001B10E023
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 10:28:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfzslE3womuZDxsSpTyD+3Mdnt3a/U7UdpSNFQXPPRb7ijnz0IoofZfqSh/ABx61btwK+6M0Pk+WoEuGSVuKNRilC2ENJZdVFp2s6dtBQTuVbqtR7GddZ2rlhAExEDRv37H0VT4gLEFK9KxWX7qVSLUD6p77dRLI4a59OsOOSi2B2C2YL/VE/BQD/43t4pUVvJKeXHMOlDIpymmOrk52sQEQnBBVGnc6cCATXEr4WGBFHhjr9QGD8+QKB8cnPaVswJ8JCck3sHx9umt93q+Op+vpFUT6d4n8ioV/lw9SN5eMqbQq2IJ9c+4trreCwIBJJ8g2sMhj1GNiTHziOPvsEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7r6Bxy2Zuf0alnETU/KBg90qd69aeP6d92xfIJH7G7I=;
 b=ifn1WWc2HSbJyeWT5yNb5OdjBSVcda5jbJXEhh7gd1e+zIPacqqWO5A2nIYCfP1pb2lh8x/H6mO4Ws9DL7hCOjJEdAZycAl9jMu5bpZaaRSc5sk+O3HLfsf5ZB1rrODlZlUSY0IrEVy6z7EuhNHARktt1EEgHByG9D+KgDrRv5kL7XEyKGCSOi0nX5wEfVWT7USdJtTZiSWzfH8TkXjgSz2QqW3q7ssPAgG6FlYFFSN3koEieeN8y9Dh69bPKsVeyg8QsWmcbu06nN69Wb290VhUWQ1TdRplrEUwIe7rXTHplIynKSEmfFymbyQnU0o77Bu/whtIQj9AFDDZYw2q0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7r6Bxy2Zuf0alnETU/KBg90qd69aeP6d92xfIJH7G7I=;
 b=VjhV0MsvnzITU9ndFbpo/FsP1PHu5TumGscNOPQq70zUdyffpJijQWoX8JRPIvo/8DD/KO3oHy29tYRa3eYBuaUzjvRAJbYo+UH7d3hqr2UzXH4yxCIfvTasSBbYblQAcHSe/7IXOv1pgFih3Tc1OW98zKGTmnS/gpqjp8QQ1hLzq5t6PdTfVknX9BgGSk6dF8bYSwDYflRhYDX1wP6SFh1Rj96+rjGdpLPJVl8rRuHdV83Qbs6ypBrt9hdwd0RiCm1RcH2ao66uMA2V8O7HEOboPiJhW0IYEk+fTe6qAzsfF10EZnWJE3gZ8XxKFHOd0lQ/O1nEXeOQwFVafQ/86A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9222.eurprd04.prod.outlook.com (2603:10a6:102:2a1::18)
 by AS8PR04MB8134.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 10:28:10 +0000
Received: from PA4PR04MB9222.eurprd04.prod.outlook.com
 ([fe80::4bc5:69c:dff8:17dd]) by PA4PR04MB9222.eurprd04.prod.outlook.com
 ([fe80::4bc5:69c:dff8:17dd%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 10:28:10 +0000
From: ryan.zhang@oss.nxp.com
To: boris.brezillon@collabora.com, steven.price@arm.com, liviu.dudau@arm.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Ryan Zhang <ryan.zhang@oss.nxp.com>
Subject: [PATCH] drm/panthor: dummy read to discard the stale first
 GPU_TIMESTAMP read
Date: Mon, 21 Sep 2026 18:29:57 +0800
Message-ID: <20260921102957.1024029-1-ryan.zhang@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0027.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::17) To PA4PR04MB9222.eurprd04.prod.outlook.com
 (2603:10a6:102:2a1::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9222:EE_|AS8PR04MB8134:EE_
X-MS-Office365-Filtering-Correlation-Id: 27244280-1fe7-44b0-a38b-08df17cb08dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|19092799006|23010399003|11063799006|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: rE74FkJiOVGrlfHgsjpgCstpBWq79L1q9i/g+3n4x9t+yBaQqlzmwBliEti+bO6yX2u/5vUnQeP0C4YdufyW+wf+yohmf7ZF4xSLfYMsLEhQqHWvLAqUaJ8NZrEOiaAVmIHa/y83Qi8/iVNj5NeYRD4TbMLsoNi3BFtGRy+UC/7UOlYAMg6uAExqUqv4xIZOEZWU6wmROrng0B56LcFnXy65BzudHrNgICizgzY62l9y++vW/V3YMw/2LyIIKcgIcJhkd2C357FKHIfdZqDv64EIzNP+eV2Pt1o14aCH9TCNE3Ak3LFYhgTeFLuupYxuOCCE00FlfkSyx3Vm3BizCm8SDM3DVsSyNZ+W/2RG7YukYfH39wwb+rlLogrchSeKclBaxa2PPyq9GxjJYrPcPisUyc6xHVE5aFMxDI9iBGzmfZjLXnaRxzkn619kORrxPXePQy/YyJAqNvvXsmo3XQ7CvKpIVXMYwZqhfc1gsQzZOoNaZ6lbI7IP+NF88hVZWVA6X1Uz8nkqnUFSoji7YDhmbwb5i+E3DRQcG21RmwG37PSOesbjo+LqvqUCqAHB75JsUt91xA7ixEOmK1U7MOuDm6m9k28mgLV6pdEkxXvsjPARdhqPHlwLC3qLzUMqo4++q1/zIGiA6qpWuYb7Ng==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB9222.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(19092799006)(23010399003)(11063799006)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jPcWw+/baNHk7t0GGy46Yh+uPpZLRBZRXT6FwxkVS1wpJ4rZIgQa8kQAZb1+?=
 =?us-ascii?Q?0ELawVdwtKyztCNiPr/UZ+kNHHPrOAstOkQRvnga8meAiPFSnDmCbB+5WHZe?=
 =?us-ascii?Q?9wOuPZf52tj9ED95YwnfvFelxNDZBnl0OE/PKq5VZ0/7vFMKeeq7AEOC6SA4?=
 =?us-ascii?Q?/c4Ov/uCjVxYHjoRvI9RBPpckRAsZ8VgSqCmQ5LSKIrsu4PGw4/ywoP2VM7t?=
 =?us-ascii?Q?vf6ImrUL4e4vRzfrypeWotO/9LQsXRVymRUQydIkJZkB1E0Buq5fJ3icR2IN?=
 =?us-ascii?Q?FeqI7VTbE7FJBbXAv6HdIoTJaKu2hfUWeBZA10eH30VdDi935wygSddm14Sa?=
 =?us-ascii?Q?6Mz/f/yfY1fTo4M6jEToT/ab39zL62b3Ch7wyln9L5hRhjNP56wt4Id+tc30?=
 =?us-ascii?Q?X8mftq9tXhJt3cvIb+gm9QW9me4Ei1dY1mZv593iB9Jk8YTyZDDK3x4tE2My?=
 =?us-ascii?Q?+d20kwfsWIL0+0WdPiBLakWvExslEpaZ8Jc6m3x+e8dN1p2S7BmGvDYn//ho?=
 =?us-ascii?Q?GOFH3BL3DobeiTRL8BaEi5NdgDKHTDdlg8CsyOFG3gEopeH5O/mFgd4hm30n?=
 =?us-ascii?Q?Nm4csyUJYPSlB3bkJcDfjTzcYyRkMMPs7jdQQbTCl9eH6/4llRE9tutK0Qc+?=
 =?us-ascii?Q?pDKctybm6ASJEnBsXqyedLMNcINICafWwo4uDdWpTX1x+8Vopvj7Jei3EDHS?=
 =?us-ascii?Q?LuxksRtuzavkqY8fIChNm9PfDToWz+uTSJdhS9RKFNaOP12YNfYDPsBCrgpb?=
 =?us-ascii?Q?KUkqTzYkW//+VWE7Ua/EUVEeFwjtgoSXox5HCnBp08mj3poygY7vIFWgCxIm?=
 =?us-ascii?Q?0bPoqmMILsR8FZ9dyOB17u8EvSyAqO+LjINnbs1w6f0Fp3FIRfXSCEiQ7MKD?=
 =?us-ascii?Q?MGYF0DP/e7lzbH0Q9ytzt54ZJqYs2i6chnpoELjGibWnJ4aU13mDl/ta9sKg?=
 =?us-ascii?Q?O1yhhZBfgojIs3RZCqvg6BurOFgzV4Uam9mwHvOzaGjQGb7BwzK/HAoBmUqP?=
 =?us-ascii?Q?VGziu+8OiTWjMS7HP0N2aKm4Iu9Dh11lkRb2H2A7UrkjrW1McE9L3V67MMtS?=
 =?us-ascii?Q?QDOid+tr7Q7CHMs6kTxKuFIGfqYD8pyqdWjXJobsJ/95gNKdLIzdQ5lzg+W4?=
 =?us-ascii?Q?HIJNDzwWrvcFuTMRth7sC2LkHgZVtRHxfHPe9AD9pinq7a7DA9+9Myj7OHMA?=
 =?us-ascii?Q?Fp+S2yq3QhNGC7gW1pGocxoAZPQ6BjGXJmlfXoMb9H6m9ntX4TcXDjhwGrdN?=
 =?us-ascii?Q?X8yxKbxBylmRnGlixaokn/7dz1UOO8H5xXyFqqvwg1FNzWOxIQsGgAJxWeQg?=
 =?us-ascii?Q?6wLXiKVYMsYRi+2Ks/0bAzfXflM5NcqBzJILJRaU9Ouq8AwWsEXocjke8qNN?=
 =?us-ascii?Q?Key7teNtI+GZE/qRhWJYTMO5882i7VLqMx2X+xfFUKQRjynzqbaIy1V3mkaA?=
 =?us-ascii?Q?rTbJh35Og8wGjzWKn6Bom6RrUO93b9L4QQbI0iMuF60Ct01C2r0WZk9B6WGr?=
 =?us-ascii?Q?lYkGWIE1akBTnbetg85GQoyK1xs9Qog/VJjxzSJptu4Tg6vJHkmMKSsztReL?=
 =?us-ascii?Q?0K/ZJcm8Vjni4L+mVdkcYYnOs8jCnisN4azTFWT75qSEKb4Tsvnj14bJmO1W?=
 =?us-ascii?Q?UZrLMgCFET1Tw2DmBILWCMepts4EK4Ew9pM9a4BWsRzFlBFz39e0E22bN3pS?=
 =?us-ascii?Q?EvOEiFJUkqd/VnUvquJPvfTJ01a52T06hCokYOdILi/Pn4nZZUEdBhcwAGb2?=
 =?us-ascii?Q?Dhf0pcVrjtfd3vhgmqlaAmwlNw94X49cSY8CZQCKAThlbOWEh0Im?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27244280-1fe7-44b0-a38b-08df17cb08dc
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9222.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 10:28:10.7453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FH1hbShWzKozfABS1B3I5zto7v5Xh75+IxQ4jlJZ8rIPlrmha/6JBS1B3VHqY2QLsz87ljePIc6yCAfoNlyTDPhe6QgSqKElzNSQXMsYkGJmayn0i+m61navKgHfECwO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8134
X-Mailman-Approved-At: Mon, 21 Sep 2026 12:18:56 +0000
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
---
 drivers/gpu/drm/panthor/panthor_drv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 720bf889096d..956a147dc282 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -2,6 +2,7 @@
 /* Copyright 2018 Marty E. Plummer <hanetzer@startmail.com> */
 /* Copyright 2019 Linaro, Ltd., Rob Herring <robh@kernel.org> */
 /* Copyright 2019 Collabora ltd. */
+/* Copyright 2026 NXP */
 
 #ifdef CONFIG_ARM_ARCH_TIMER
 #include <asm/arch_timer.h>
@@ -772,6 +773,10 @@ static int panthor_query_timestamp_info(struct panthor_device *ptdev,
 #else
 	arg->timestamp_frequency = 0;
 #endif
+
+	/* Dummy read to avoid stale values. */
+	gpu_read64_counter(ptdev, GPU_TIMESTAMP);
+
 	arg->current_timestamp = gpu_read64_counter(ptdev, GPU_TIMESTAMP);
 	arg->timestamp_offset = gpu_read64(ptdev, GPU_TIMESTAMP_OFFSET);
 
-- 
2.43.0

