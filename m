Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CEDBC79F80
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 07:54:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7085A10F90A;
	Fri,  4 Sep 2026 07:54:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="W8itQ5wv";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010041.outbound.protection.outlook.com [52.101.69.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1163110F90A
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 07:54:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYkkoquIPhxfor8caeRQQykWoamatKPa0QCSkxzMpE5Kdk+3t9OIHgnWmWRPc1wq7tQ8dekP7/+5nFrUHck8GchH9XDTIMoxeQgKADUeJzX+0320Y2bb6OcW+fph4feF/ktNm3Tlou2XVCA01mWlcghAp9pHzgUGf1plRZKod7DyNP4TzzmaHer21W6dz5uSyRYNebvNBKxOdR8sHH+b4pdRsR1fag4w8CtcrfARRFHnWw3wX7pgbKJmcpYOs4L/9kzTdX2OYi/c5HXS+28pKPPSt0+abvm9GhqGUGRszK99XALajNOYcfAjCVzrP8fwnOSKqBqv4Cg5TXQCLOsBTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8ZcgiLzeA/kAAJwr/O87xIsraGrWaTGDJsqkTWfhss=;
 b=l4VEy+KV3Sj74DM9H4jLy473TxA5ioZIt4FixMP2jS8daA0xrSAw89WmhlBJUSSnbCol3PFrU5Itphb/yJmtsnZmUjCX/JTeXlT0ccE7P2yitSmIOE1vvxkjhzuBKWsxC63/Zqa2OCGg9NTaq66qOJF0umNzv4QZ7TMN6KTYVcLGX1zD+kfcce8ypMBiDpSl2KVqKcNB6ALzDnlxHKk9tiXHJlnathmoakgILAUpmG0mAuA+bbuXXC+jgbNN1dBZPcuT5BZ+lx+j6F6Pt1M6dztUwO76DHwjSl9q4645q/2ui2Py+QRYZPQlg200xEEkTwfXgx4LdwWkk/DT85ogvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8ZcgiLzeA/kAAJwr/O87xIsraGrWaTGDJsqkTWfhss=;
 b=W8itQ5wv6lwMDrFfd7Dc3MBnclL45B/XOQSZXCuTsOgnb04CYIE/MiRylOaGZTSgtaJbjMLuwX5tg3aWw/gE/81tjnjDwZYDYNl1UWIeNvipiQo4raPIbrlrml06cEyspsJGrHukB9z7EG5u18XAN730pWcu15+DUrBlowki6dkHmCWbswK+oBArTexYIkMEW93mbBTMRFAJ+PijmsneYFV4pMg1XDY9UkHYnmDUy0shQtlcPr3586EUccwT/TSdPhWxUzpI3gtSppcjIINV27APEKM9xNttq9QmIat/YFvmzffaEi6amceUN7DqiYjx4XsWnq1jY0x9AJPUZeTs5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by AMDPR04MB11702.eurprd04.prod.outlook.com (2603:10a6:20b:719::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 07:54:50 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 07:54:50 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Fri, 04 Sep 2026 15:55:02 +0800
Subject: [PATCH v6 12/13] drm/imx: dc-fu: Get DPR channel
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-imx8-dc-prefetch-v6-12-26643e3f6cb7@nxp.com>
References: <20260904-imx8-dc-prefetch-v6-0-26643e3f6cb7@nxp.com>
In-Reply-To: <20260904-imx8-dc-prefetch-v6-0-26643e3f6cb7@nxp.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@mailbox.org>, 
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA5P287CA0262.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f1::16) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|AMDPR04MB11702:EE_
X-MS-Office365-Filtering-Correlation-Id: e13b6da5-0f4a-435c-dc23-08df0a59cbdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|19092799006|366016|1800799024|23010399003|10067099003|18002099003|56012099006|11063799006|22082099003|921020;
X-Microsoft-Antispam-Message-Info: ul3D7QfVOHgGf/g6zJXTWAjus1E/1LhHou68zrynpFCqToUUy5MPcdBJN/1xBdPANopyZHizG2ACCnBpkpusO0Xdztk2ExSTo+2Wbf19lxZwcmJKHHUqhjwBpRDbyvJNi5JC8/uXgVEAOyTJy9zW1NtZbHxXZUGjq7LgeXzIfDNxxzqBLy8egbE73510hTsfN9NLtSuGfV59RLLptPFQ0l85w6USHfHAJMTo5ufcJrHTbhHN1Z/HFxGqcmzlsljrwFCRZkscrDoDuoxh94IGfFrbnXS2a7zd5VWEJdOQQeowG5xLmIJuoxl2975zDidqL174UIPK85V+i5ntfTfHudTKG7cz2XigfsHzI17mme8QZmkrnAdUkC+YdqfoKHPQCG353assA4NdXXi/PUM95tlCNJcydswkzCHqymHcd0kNGcgUM/QYspNKvKIxyCAcWCBVwZZFksv8f7RbOp4uzFhg4reYnWjkwTVfUSyDcCFiJZUIPpuiw/GPUI9mMh/B2fOo6wIRdDoz4UgIKclwIBXJ9MC2TsspIJDNeHFJ8e2wLiOV8LGbTXHcSXTv0V8/7qID5hcK2y0+YH2S7laMBEskHIpB4TrozOvN1ZNjZB2g1B7TvdTxlvDgVTMqA0xUF9DS2/oJFm8UAPuLp668ewSBvFrfwczRlPrCaAfWDnZ9Ji1HprkPj3kIVCo2/zI1c7jKU4AjIHiySC46FKoi/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(19092799006)(366016)(1800799024)(23010399003)(10067099003)(18002099003)(56012099006)(11063799006)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmI5Wlltajl4RWNKQTE4dmpQQWZtV0R3TW05K2RlbXUwcW52NjJuTWU4ZGp0?=
 =?utf-8?B?SHB0dmEwbVlqd21MMzJOUlJmSmNWMGU1Zk5xczFQK2JuRjg0WEhsWlVzelRI?=
 =?utf-8?B?elZ5WVU5NnpmWUovTU9MaEErSFJhNGFnTEdwWlptYWtST29ndnFSZ3ZmY3FI?=
 =?utf-8?B?ZUVhRHF6U2EycVRCd0duV1BJNS9jczBKYVAzWUhtd0RvY2pHQ29xUno0K3RW?=
 =?utf-8?B?bTl0SGFPdjI3akdxcjdMdDJ5aEUyaDE0bXhhOVJ4TXU3YXBySjMwVFlvQmJq?=
 =?utf-8?B?WmZOK2pTcStNM0NXUVU4WTZLclJNZlVFRHVlejhDY2x4UlNQeTVvVE1JN24w?=
 =?utf-8?B?OVdQbDF0SHZjUVI0TjNFM3NTT2VJTnJJNmVNak1BVldWQjdQUTFPTWV3bzR0?=
 =?utf-8?B?by9sSHRTMVRrRkp1Y25nSWp2U0pyRkY3TXFUNGNOV1FQb2Zxa1RtajRFbWxX?=
 =?utf-8?B?WDAxV1FhZ2I1K0hIVEtDVUhJdlFtVytXd0hJSUUwa2VuWk55S0tUa3gxNGUw?=
 =?utf-8?B?eHlJSDJVTlI5VmxQUGNyc212S0lSdGRqOWFOYlNIZXNEOEtkY1lTTytnbmR2?=
 =?utf-8?B?c2FEdzIxaUpBaXJseHR5bVJ0dXh3K1hGaVQyRmVtU0RKaHRKRDltcWZhZEVF?=
 =?utf-8?B?VnNndnR5RzV5emYvQ0FYaGI4MGhjQTZzTUFUckFBV2U2NWRQemxYTlgwMk9X?=
 =?utf-8?B?d1BNemh5YjhlZStHTFNiQ2IrdFhjZFdyQ2N6UndBeVFndGVqUnVNN2tSbGdw?=
 =?utf-8?B?bXRNNitRU1JIZjlNU3JpTjJXNWdITjdwZWFPS0Q4ekpOeHVRczFsaGc2bWVM?=
 =?utf-8?B?RkVFdXJ3NlpnSDJNK0ZEV3pXdDJmZmlxYU9NLzNnQkVmYnNxTjVTRGl3UTRw?=
 =?utf-8?B?MWlVLzBVUHVmNzFDNnN0WnZiYmkxNEo2aC9ZMmRJQ0VtZnJaaFN3RXBOaTJv?=
 =?utf-8?B?NnRmYjQ1aFZUelE3T2h6SG01TnpWMEVCSElueXFoZVkyRFFrU2E1Y1phQkNN?=
 =?utf-8?B?Y1hhSVZ0RkRBa3R6THNIYmtjdURZdVVESHh6b2p1eWw3WVlBN3h3THI5b1A1?=
 =?utf-8?B?TDRyS0pvSHN6bVBidVh2VHdkYTN3b2VMbGlBa3V4QkdjTlJTYTF0ZkxFeUNt?=
 =?utf-8?B?d29qbnorczVOc1c5a1ZNU3NjVW1tcURvMzhoQWhQZUlGU2k0MytLRk44TGZa?=
 =?utf-8?B?VFBncXBUN29udHpJUnYvOC93dDNXWkJRUSt1WGdoTEdsSDZLZmJ0eDY1K0hY?=
 =?utf-8?B?SDlSRk5IanNEdVdGbStTSUlyUXBsbzFSbllrTmM3YzNvN0FYcDZ2ZUxxd3Vs?=
 =?utf-8?B?MVRxNUl3OEN4bTMxUnVGakJRd3dBbkVaS2ZTY3NmWC92dVlVV1ZNRkppaUlD?=
 =?utf-8?B?cWt2dGVTaHhhNnV0YWdWSzZoVVlFUzBGN1VSckhTRTgwTFBUakRNWE1lNWpw?=
 =?utf-8?B?blBwYVRzUmtVeGcwb3RWNGI4cWdXVTBaTUt0SjY1Wjg5aTZWdVlXZ1VOUmpE?=
 =?utf-8?B?NWFJNVVJZjJyVzFRRVNpRHdVNHJxWnlTYzdPZ0hlWk9nbWNSZFgvRVdHK3gx?=
 =?utf-8?B?VUlnRHN5alBRd0l2SXdiTmVrZHBJU0ZhUXdxYTIzL09QcmY2V2lJNHRKREky?=
 =?utf-8?B?L1JtTUkxM1ZEWVQ5NUJIdVpJYTdqcUZWNWRnVGJjQlhYakpQa0REbm1XR2ND?=
 =?utf-8?B?Z3F4N3FSbmRCbU1kZytRZEFvSWlwb3RLMHlObTI4cmk4Rjl2aXVDalpCbGdD?=
 =?utf-8?B?VkE3WkE0cEZOdER6VjJVOFN0V1phUE9JOWdCdDFrSWZ2RGNvTXRZK2R1Zk10?=
 =?utf-8?B?aVh6K0tTMFFrRVJINEkzTXpqdC90TXpVMEpETnkvb2wxODVpSytmcTBadUNa?=
 =?utf-8?B?YXpxSU9IZUNQcWVkbXNwSlA3RUN0eThOTys2UFJjYWR5Y0szeElDTFhIUG54?=
 =?utf-8?B?bHpjM2lIN3YyMEJyeXNRUHhqVmlyMGphSXBISHZYQmRwUTUxMlprTmltNkRz?=
 =?utf-8?B?QUdHb2RaNU9qWmE3K0EraGg4cWNoRnMySDdra2FUZnFnS2dYcWg0NVFQSTlS?=
 =?utf-8?B?QlBMVElNY1p4c3R1cCsvZ3RRb3g0a1h2L2M0TmU3Z3JjZUZCRE1WV0xmQkNN?=
 =?utf-8?B?bVBFdkZyU09ONFI4UW15MDZNcGV0R3k2ZzI5R1VzbGVGVVlVd2FlakRRRzFV?=
 =?utf-8?B?MjZUZEtBSzhSaXFKb1FYejJ2eWZ5TDNyaWdraitucEZXU1BOaFhJUGRZVmI1?=
 =?utf-8?B?K3RvU0xrNGJuZC9JSTlNdG51TG9HL0dNcS9SM3gzak1FYk9pVG5sUnZTOURl?=
 =?utf-8?B?Y1dMNDBuam1NT2p5ZTFubXNiQ3dvckJMdWlNKzF2RGV1MmoyU3Rpdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e13b6da5-0f4a-435c-dc23-08df0a59cbdb
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 07:54:50.0327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 39hfZy6Q3iP4YM78OHYcnn8WrnfPp8wfC1h2H1ZjMtZyJxoY6VDatqF/W1xNaWzcNYIr2TRssv19w6Csx3rZdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11702
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

Add a helper dc_fu_get_dprc() to get DPR channel for FetchUnit.
And, call it from dc_{fl,fw)_bind() to get DPR channels for
FetchLayer and FetchWarp.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v2:
- Collect Frank's R-b tag.
---
 drivers/gpu/drm/imx/dc/dc-fl.c |  7 ++++++-
 drivers/gpu/drm/imx/dc/dc-fu.c | 18 ++++++++++++++++++
 drivers/gpu/drm/imx/dc/dc-fu.h |  5 +++++
 drivers/gpu/drm/imx/dc/dc-fw.c |  7 ++++++-
 4 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imx/dc/dc-fl.c b/drivers/gpu/drm/imx/dc/dc-fl.c
index 9f03df44a63a..f7b8c4909c80 100644
--- a/drivers/gpu/drm/imx/dc/dc-fl.c
+++ b/drivers/gpu/drm/imx/dc/dc-fl.c
@@ -100,13 +100,18 @@ static int dc_fl_bind(struct device *dev, struct device *master, void *data)
 	void __iomem *base_cfg;
 	struct dc_fl *fl;
 	struct dc_fu *fu;
-	int i, id;
+	int ret, i, id;
 
 	fl = devm_kzalloc(dev, sizeof(*fl), GFP_KERNEL);
 	if (!fl)
 		return -ENOMEM;
 
 	fu = &fl->fu;
+	fu->dev = dev;
+
+	ret = dc_fu_get_dprc(fu);
+	if (ret)
+		return ret;
 
 	res_pec = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
diff --git a/drivers/gpu/drm/imx/dc/dc-fu.c b/drivers/gpu/drm/imx/dc/dc-fu.c
index 2e197b3344bd..8339f44c0091 100644
--- a/drivers/gpu/drm/imx/dc/dc-fu.c
+++ b/drivers/gpu/drm/imx/dc/dc-fu.c
@@ -10,6 +10,7 @@
 
 #include "dc-fu.h"
 #include "dc-pe.h"
+#include "dc-prg.h"
 
 /* STATICCONTROL */
 #define SHDLDREQSTICKY_MASK		GENMASK(31, 24)
@@ -256,3 +257,20 @@ void dc_fu_common_hw_init(struct dc_fu *fu)
 		dc_fu_set_pixel_blend_mode(fu, i);
 	}
 }
+
+int dc_fu_get_dprc(struct dc_fu *fu)
+{
+	struct dc_prg *prg;
+
+	prg = dc_prg_lookup_by_phandle(fu->dev, "fsl,prg", 0);
+	if (!prg)
+		return dev_err_probe(fu->dev, -EPROBE_DEFER,
+				     "failed to lookup PRG\n");
+
+	fu->dprc = dc_prg_get_dprc(prg);
+	if (!fu->dprc)
+		return dev_err_probe(fu->dev, -EPROBE_DEFER,
+				     "failed to get DPR channel\n");
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/imx/dc/dc-fu.h b/drivers/gpu/drm/imx/dc/dc-fu.h
index cc93317e3001..9fbd7aadd264 100644
--- a/drivers/gpu/drm/imx/dc/dc-fu.h
+++ b/drivers/gpu/drm/imx/dc/dc-fu.h
@@ -8,11 +8,13 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/device.h>
 #include <linux/regmap.h>
 #include <linux/types.h>
 
 #include <drm/drm_fourcc.h>
 
+#include "dc-dprc.h"
 #include "dc-pe.h"
 
 #define FRAC_OFFSET			0x28
@@ -99,6 +101,7 @@ struct dc_fu_ops {
 };
 
 struct dc_fu {
+	struct device *dev;
 	struct regmap *reg_pec;
 	struct regmap *reg_cfg;
 	char name[21];
@@ -114,6 +117,7 @@ struct dc_fu {
 	enum dc_link_id link_id;
 	struct dc_fu_ops ops;
 	struct dc_lb *lb;
+	struct dc_dprc *dprc;
 };
 
 extern const struct dc_fu_ops dc_fu_common_ops;
@@ -123,6 +127,7 @@ void dc_fu_get_pixel_format_shifts(struct dc_fu *fu, u32 format, u32 *shifts);
 void dc_fu_shdldreq_sticky(struct dc_fu *fu, u8 layer_mask);
 void dc_fu_set_src_bpp(struct dc_fu *fu, enum dc_fu_frac frac, unsigned int bpp);
 void dc_fu_common_hw_init(struct dc_fu *fu);
+int dc_fu_get_dprc(struct dc_fu *fu);
 
 const struct dc_fu_ops *dc_fu_get_ops(struct dc_fu *fu);
 
diff --git a/drivers/gpu/drm/imx/dc/dc-fw.c b/drivers/gpu/drm/imx/dc/dc-fw.c
index 14512c01ea78..030970d4f987 100644
--- a/drivers/gpu/drm/imx/dc/dc-fw.c
+++ b/drivers/gpu/drm/imx/dc/dc-fw.c
@@ -130,13 +130,18 @@ static int dc_fw_bind(struct device *dev, struct device *master, void *data)
 	void __iomem *base_cfg;
 	struct dc_fw *fw;
 	struct dc_fu *fu;
-	int i, id;
+	int ret, i, id;
 
 	fw = devm_kzalloc(dev, sizeof(*fw), GFP_KERNEL);
 	if (!fw)
 		return -ENOMEM;
 
 	fu = &fw->fu;
+	fu->dev = dev;
+
+	ret = dc_fu_get_dprc(fu);
+	if (ret)
+		return ret;
 
 	base_pec = devm_platform_get_and_ioremap_resource(pdev, 0, &res_pec);
 	if (IS_ERR(base_pec))

-- 
2.43.0

