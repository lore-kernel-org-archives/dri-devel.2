Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DFD606A328
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 21:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=j8RFXFuc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A79610E0B8;
	Tue,  3 Nov 2026 21:27:10 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012047.outbound.protection.outlook.com [52.101.66.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 605AE10E0B8
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 21:27:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y9R9rfwEurkvcttF9s635SWDhUKeJj/GQhFkB7kxkv5mefaDC2uRHCfS8i5I5/J1/2i5Be3wKhXoBNh2dpe1/J+lS4KBZhWAQKXtZorD4VHU3rEzqqQGxltbrQl+CKpZkl+oauWF76oAko1BfA1J8NIDAkFvauqCYIRKHRIgUsCpIekuvjtq3H+RK3lJMamaFUU4VCnahk+nriT/IZwilBv7ky8z+Ue+52cOlw0Ez29UmfuttjCd0AzgfWVRxY09bZMygdw4ZiXTlpp7kNsW/BjK+RCLX7Ur0w14KzXU4AUijWy1XBRrATTZ3wGwwfAGHSMCzQO+k5mDZZfksj8/5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htzvAMiU2FhngqwtGPbOr1GhKE6efX+L5FgMwLwRxfc=;
 b=p3ysl1ktOZAb+ZVBvGICeeiMGXmOosF3Vqag2aar0x8pTJKyDSNKQsa9e4Hte6HauQDNLJdBqewLlJu1WPNxW+f1MwE8Ky07BpMdfthkb9av7C53Vpg0vP2RLxRmm4DB3N9AjRMtWh1RkGP41wbYPo438aW55viRqvM55S8Jr3ATiF3vAaOr+fcix75VooN/kWV+8lQgyvCY4AUsKD0uW3d1MqTCszznmP98E0JfOJhuNkHSsxTcz/qRM9i7EIm9LqIV2f7XLisCZGNSnVaTiTIDhjhXt422oMEwrOz4FmeOsXGo90vODO0x0QTUsbN2DDwlOYdZOr4tJxX9W+Xa4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htzvAMiU2FhngqwtGPbOr1GhKE6efX+L5FgMwLwRxfc=;
 b=j8RFXFuc9fuhhxe2uvJXAl/D5/PHzUthpCWGQAhXr6MfwaTDIy0Q0G7woazR6ZzJHgc0jplp96hbLIRR/Lx5yDI8130DUqwIRFcJC6uU9KqfTjGUGjY7WVC/uNwrCLkyKB8wGJ4dS4Ej0m/J5SHX8zGSmGxx6jmhe3ziM5/C6j7yt8o/IBVuKl8TMM2DkOH5wCBw7LEzkwsaAO/YSLoGwibI3c587m0ZmxlWvZ5JcHcnKTyrLN/LND9Gnl2IUSgz83rHDDdVQHwKHiEqFIJpTJbjU8SOtSl8zJe9ENzpn3jjsI8B7IIrfl+AwgGTA2CdYralBixCtOq2onlk+P4TUw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by MI7PR04MB364121.eurprd04.prod.outlook.com (2603:10a6:290:100::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 21:27:01 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 21:27:01 +0000
From: Frank.Li@oss.nxp.com
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Andi Shyti <andi.shyti@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 linux-renesas-soc@vger.kernel.org (open list:RENESAS R-CAR I2C DRIVERS),
 linux-i2c@vger.kernel.org (open list:I2C SUBSYSTEM HOST DRIVERS),
 linux-kernel@vger.kernel.org (open list),
 linux-media@vger.kernel.org (open list:DMA BUFFER SHARING
 FRAMEWORK:Keyword:\bdma_(?:buf|fence|resv)\b), 
 dri-devel@lists.freedesktop.org (open list:DMA BUFFER SHARING
 FRAMEWORK:Keyword:\bdma_(?:buf|fence|resv)\b), 
 linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
 FRAMEWORK:Keyword:\bdma_(?:buf|fence|resv)\b)
Cc: imx@lists.linux.dev,
	vkoul@kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 1/1] i2c: use dmaengine_get_dma_device() instead of
 chan->device->dev
Date: Tue,  3 Nov 2026 16:26:54 -0500
Message-ID: <20261103212655.1774644-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::11) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|MI7PR04MB364121:EE_
X-MS-Office365-Filtering-Correlation-Id: 5306a812-083d-4c6f-70c3-08df39f13305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|19092799006|23010399003|18002099003|261102123227099003|56012099006|10067099003|261009221227099003|261009223027099003|921020|261022105027099003|261021121427099003|261021123027099003|11063799006|261028144727099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: fw0mIinos2Ko2bamA9L3VcnaJSuoz4xNrODuQBF7owYsgjbvuV0PFRRuSCXmBy9WBaS+kA9fjqp18W4ZHcoY5YDQ9N3/FpBbHuE8GI6n9vhLsydSRQU66g5xC2MNbhcoEMs2auh8T0TQHgSjmDT1MlbME+cUQDFJQrhHoh+vDapZ4WR4EF70aKcj6oagh/EoHP1pzDMTGAL9TkuT50nY7DCj0mmSFMBKOsrpvuObeor5+x+PwbwWBQfq1k85onuOEFgdHt6eA+4MBmQZO81ohukVyR7ZGPdofgUEtMBiChsds3I+Zqu4qe4Wn/ejhcB9/5aZe2kjEtgayw3tfeBo/QuxdKVFAzS1TO4Veehb9garIgAFz5rL+l8+8Z8DqXLcS8ng6bnGBYptUtlwj+mOzyZq7DxuVI7dYZUPdhEzqXWPITjU8bAKbp2UxgaK6RVbH/AJjtmqQFtNWIL0t62u0LjadS7icIeQOvEOv3sE9N7g6VlzdAFUTqQCkUCUI8HyjyntWcozlMb1w9X3jzSQB1FBgvTjEF5nNYPRqBu1DtKZOPm77vAnho0t3Be5bNW5f2HaTFIR1g9mZTpc/UQc0V7SKAX6kFa3gXNWQbjMlEAR7gZyGmIj3B/1/pQFo2KcIwK7PHCBWppAWjRZxAX3/hoFg5Qps61eEzFkbUPb6qeLeY7agdUjNu2laP9RJnpyIMIoXcbVrs/H4ERMmCElxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI3PR04MB12438.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(19092799006)(23010399003)(18002099003)(261102123227099003)(56012099006)(10067099003)(261009221227099003)(261009223027099003)(921020)(261022105027099003)(261021121427099003)(261021123027099003)(11063799006)(261028144727099003)(261026121527099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zxdy4r5leuO7PQuRWrRkmmil6Jned7lgJ7SOT5sE1mEUAYrVZuhyNvd/LWC0?=
 =?us-ascii?Q?2vhxcFxYjg7snl1W60HuIxLaY3CJhLs4gYdd1mHys1XElYPLPaPM1HBy0Dze?=
 =?us-ascii?Q?74WwVoBfF3hMJqBI9UDT4al7VhfjAE9Deitk1NKuF0kFFu4asG/Etd0BvA1G?=
 =?us-ascii?Q?wkw2HQLOh/NGgMt2oW+XF0VuR1X+xIOdgHJPVQQPj+iZNOwvL4vozYdo5uVB?=
 =?us-ascii?Q?4ocbrpRwY+I9USdSh5DbVQbvpRxHVHEakCdMTUrZj7g0gPkgK2uf9d0HouIk?=
 =?us-ascii?Q?jOE2578aIoO758f3m0qhXy97R1bpu1SR9KAHoVtXtJJYtVGWVyntlrZojKnn?=
 =?us-ascii?Q?H6p3f7l/zb/zorsXkyfQg2p6tB3313r153zvHIwgj09cBhuf2bmgEc1qXoes?=
 =?us-ascii?Q?9AgBZmCuqR6Eg8Q7zMgbcOAL6suynfbKi4Tw8RoctjDImf4Vz208TaUC6mDB?=
 =?us-ascii?Q?DCfLONsEBddBbUafgCteoEjriJCFAoxbSJ97Vss2MJw8i1UYBsGZOybPy21H?=
 =?us-ascii?Q?zV17S/x08N9xqdy0boejiXijVMjEWYJzqBzqrzuVttepWh8kqtZ4OTwcKXLG?=
 =?us-ascii?Q?SFNaWrHVql1ewnaj/esV6qqN4yI0d7Jp2QSfblZ5m8jt0/JlDYXGZzVBmLYl?=
 =?us-ascii?Q?KnH2je/WIZby0Q6yfGr1Asv6edW/tH6rDC3Rx7i3RdyPP13EeBqjIE10XtHx?=
 =?us-ascii?Q?jo2Z7cfEOVv9Rm/axz3EZE6YB/3584UtZi+Jrnc5qAHYKN8IKZfHKGcI8N/b?=
 =?us-ascii?Q?ctbeVfEsEgtGZh/5+83cRaU5kU9sLJqyPCHeY8xWYalT/bvtHwqbVcBJppsh?=
 =?us-ascii?Q?DK1727P2NV9DC8MUQot+74ZuG/I3SaLT6v75xf+aQveSBtXONwd8B8F5p2ax?=
 =?us-ascii?Q?UYOpqWxNsm7FIcY+DJobuB7Gl0W1MZiTqECvcayeu8JC3U5bo8yp8TGNk+Gu?=
 =?us-ascii?Q?WuFIKfQ0zBaDqDfB6kFL7vKrND/EodB5XlU32D21GnZa4mIDO/CjopQO+A0r?=
 =?us-ascii?Q?tN9SDHc8HsWfPQtCxLHn91MfZIwPQzp8hlSbQLmSRROccazq0BFjxhPnA/lj?=
 =?us-ascii?Q?86CtfADF1b4XlEesFBw+GlvRgvQMvXQGc6dgoG4Vb0M7HjhzIMy18HKrP2Cg?=
 =?us-ascii?Q?WrC23g9xjm6Z9Oed3AEEZUkhyvEX8pwqKXmpwPdXgUKV12cqw1+yoWTMwthT?=
 =?us-ascii?Q?7OBwfmtRZFc950ARR7vP//8f4HgLehl8JY4FYXaA8jfBBQcndaryPH8iYNAz?=
 =?us-ascii?Q?PQ04N0Uuc15U7EremWHOtFyA3Bus9/2dApxVpaQUWnvoj3hRLI24wXPaP6R0?=
 =?us-ascii?Q?V/kruUYCOVGdqmf+P6wuVzB2iGznnRIxw1FKjjGUprqURtbGCOdFOI8Yymrd?=
 =?us-ascii?Q?vLMQ792TaUlSrQcunYNFIl2rWqn6W0DAGKjNbAN3c1DDUjflaxaRhPxS9TN3?=
 =?us-ascii?Q?CQE9onKR/xJz1POGZdzvINI4IrMh/bDrqB8TZFvtmgxFn2t6MBammO4wv2BZ?=
 =?us-ascii?Q?0kdhg5/SfPCRKmqEC6bdVF8YXP1htwobBAxqQXyxjW9qCfAa6HwBdm7LVp/p?=
 =?us-ascii?Q?nxprBM9Dg4FeC/QZ5BAuWACScQRDeTohu/Ysx5IHFEhbpmC+/BKpHjmdskdC?=
 =?us-ascii?Q?it+XB0WY+q9LxNxAaJcxjAdYSWcjl2jdxQ2arh/htOkG3+qyafS1yTUPalU/?=
 =?us-ascii?Q?S20vXYC8gubug17u3M7yn8lKN2QmcCsVzTdhqyAKu2C4ULlnPenaZWJbJkty?=
 =?us-ascii?Q?hScB4ji+z5g00cZZwOdnzebqakUHU0OObRMQIaYEJYWZSGUf9/Dn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5306a812-083d-4c6f-70c3-08df39f13305
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 21:27:01.6419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g5Ecp2IQOAyl2M9NqwTWJmxVG4Bvjte+Tdy0uylXQ27/012QWNzY0YnT5m5rvfajGCAO3FpVXYUvZ+VaMIEixpTmRd2PvGVd3fu2c4WQrP7l7nkHPb4UHYUlq1HEtSnS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI7PR04MB364121
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frank Li <Frank.Li@nxp.com>

Replace direct dma_chan::device::dev access with the proper
dmaengine_get_dma_device() for consumer API.

chan->device->dev is not always the device used for DMA mapping.  Some DMA
engines support per-channel IOMMU mappings, so different channels may use
different DMA devices.  dmaengine_get_dma_device() returns the correct
device for each channel.

This also prepares for making the DMA engine provider data structures
private.  DMA consumers should not access DMA engine internals directly.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i2c/busses/i2c-rcar.c      | 6 +++---
 drivers/i2c/busses/i2c-sh_mobile.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 755064804cb21..86b1df3a56c4d 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -455,7 +455,7 @@ static void rcar_i2c_cleanup_dma(struct rcar_i2c_priv *priv, bool terminate)
 	if (terminate)
 		dmaengine_terminate_sync(chan);
 
-	dma_unmap_single(chan->device->dev, sg_dma_address(&priv->sg),
+	dma_unmap_single(dmaengine_get_dma_device(chan), sg_dma_address(&priv->sg),
 			 sg_dma_len(&priv->sg), priv->dma_direction);
 
 	/* Gen3+ can only do one RXDMA per transfer and we just completed it */
@@ -511,8 +511,8 @@ static bool rcar_i2c_dma(struct rcar_i2c_priv *priv)
 		len = priv->msg->len - 1;
 	}
 
-	dma_addr = dma_map_single(chan->device->dev, buf, len, dir);
-	if (dma_mapping_error(chan->device->dev, dma_addr)) {
+	dma_addr = dma_map_single(dmaengine_get_dma_device(chan), buf, len, dir);
+	if (dma_mapping_error(dmaengine_get_dma_device(chan), dma_addr)) {
 		dev_dbg(dev, "dma map failed, using PIO\n");
 		return false;
 	}
diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 3a55f803e4f15..023813c2f7809 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -452,7 +452,7 @@ static void sh_mobile_i2c_cleanup_dma(struct sh_mobile_i2c_data *pd, bool termin
 	if (terminate)
 		dmaengine_terminate_sync(chan);
 
-	dma_unmap_single(chan->device->dev, sg_dma_address(&pd->sg),
+	dma_unmap_single(dmaengine_get_dma_device(chan), sg_dma_address(&pd->sg),
 			 pd->msg->len, pd->dma_direction);
 
 	pd->dma_direction = DMA_NONE;
@@ -526,8 +526,8 @@ static void sh_mobile_i2c_xfer_dma(struct sh_mobile_i2c_data *pd)
 	if (IS_ERR(chan))
 		return;
 
-	dma_addr = dma_map_single(chan->device->dev, pd->dma_buf, pd->msg->len, dir);
-	if (dma_mapping_error(chan->device->dev, dma_addr)) {
+	dma_addr = dma_map_single(dmaengine_get_dma_device(chan), pd->dma_buf, pd->msg->len, dir);
+	if (dma_mapping_error(dmaengine_get_dma_device(chan), dma_addr)) {
 		dev_dbg(pd->dev, "dma map failed, using PIO\n");
 		return;
 	}
-- 
2.43.0

