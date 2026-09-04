Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA569C79F83
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 07:54:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC36C10F8FE;
	Fri,  4 Sep 2026 07:54:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="McYxh31E";
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013025.outbound.protection.outlook.com [40.107.159.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2C3810F8FE
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 07:54:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qunG8WD8vrJnOg6AvMRtVUtyB3fB3rGuXtzV483X13eMoaoRTy6P9xdJHf9qDiwAVgR4ya9L7rmNLi+DVn1RZIohS785ec+mcIbGK9hy2ACpU3DURJkdO12rEZbXyHmHTucuYz48FCecdCeJqZ4s3T6LbZELOaMi+fCZiO/tQn/V3On9RkQi2/GsyEj8KpiSievzw3z8/Owg4ZyQOC5nIwgJONtEXlKSNYlrtfK+eNJ1GBT0ALWLCSWiqiUQMdYpCPx1rxU1JtelBZY6GXe+DMVg8+CFyOsUIaiaGnlfyUr/wjb82siP4XrGagc23hnb4A2xwUBxZiY8ow02wkQdgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/EgPLsqIghtyz/H7ErZ0Yb4uMe11bzV6NZRlALu1lA=;
 b=uey2o6qH3OpVi+22MbNTwJtyF9OWau7QaGO7YRxFRMe+NIDvV94HvLCqS9iFbHVb6f9RBpN0Cpe4lJt05j2aHRhSdTK3ETMf3H4fvGtsrippVzbpTmaJfHV43PQ8j45m7+mfozIL4U3cNSHMglWxPQsD9yCHnEZZWv0zONZF0nm4N6f2sckBQLYN9qkor4WJ4eygRfRwlqbV0L94kjPN/KqDgOCG881KL0gvz8juxYPjGYSQ0WsBwIoxj/L4p3pCRSPvb79XihnObH1ZxvV1t8V8yt7+vmUzPKCdJsiLmTl7Nz/FATJAHCQE9WDkIyT0H8wfEn7DhRFcq49JFSOpNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/EgPLsqIghtyz/H7ErZ0Yb4uMe11bzV6NZRlALu1lA=;
 b=McYxh31ETOSdBTp8AlS35MEua+xV52Zm1cewQDfxCNI3+0r/5m/5MvCKzbzfI+bkCcIa/i8kHCnZrfxILkdtFLGfUq7DPn+2VT514ZHN0t7st6VQcz5fbCFNkx4Y6tjG/FodutZndfkZhJILiGMitWrME0u0XXMchnHUuy+cUCbJVJFXFPBnyOBSa7990nS5/r73Dztbxc64p6rBU7X4tix4kh/O1rOAUKjHvHhL/kcNG27dxMS1/hhl9M3fziJ6QEr5D1VLOtYvKXIyrnwLP5gCYKuSmlXz2I2DElapl5apjlB6wazhfT0eC4N69sbyQoVJvoHEakSs8dDKVh7ZcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by DB8PR04MB7115.eurprd04.prod.outlook.com (2603:10a6:10:128::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 07:54:17 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 07:54:17 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Fri, 04 Sep 2026 15:54:57 +0800
Subject: [PATCH v6 07/13] drm/imx: dc: Use TCON operation mode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-imx8-dc-prefetch-v6-7-26643e3f6cb7@nxp.com>
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
X-ClientProxiedBy: MA5P287CA0126.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d0::7) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|DB8PR04MB7115:EE_
X-MS-Office365-Filtering-Correlation-Id: 135d1fec-bc44-40fa-2983-08df0a59b89d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|7416014|23010399003|1800799024|366016|921020|11063799006|6133799003|10067099003|18002099003|3023799007|18092099006|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: Z/hdqgQmBPkvrUKHz601lWwMRvM5mFis1BzPs/WUnnoZpGjScZrDIZ8rC+FxV4ZUW/jdlSS2jjRkRiw7di/TPDgeSkfVSpCPQPdBxiYRMID5TSHV+lRqvzpOmB2lds42XH1oRA6U0aSJK8xYPEBzMUaG2pykr0CZVjb0pfhgRWGFNq7D2+rjDxaf+9O2LKgqilxZemFlkgqBBdwNZt/9AcLWGEgGP9bh8P5XfCYR2jDDsXNv8LdfzGHfJoYTvybZgyr1OsmkQeKLuT9B+rAxOOqSSBBunpuxWrSEP3Yg2ciRttTBqqNCvi3QRIm49OG/Y9J9mH0LUV73PnaJ6P8xkDHG1G7rr5geJFV8jE/euewxFipXQHF/50KlXv5gvtiPXu1dkjemWQv3YqEtqrM7tblkr4pC4DbwTQAen4sM2qpKp3HUIhrOnkFXP5gV3otQcTZuUkwPUYqmLaWIPjXcD3Eg5RYEH9MwjZx3L0aPV5xUo4OZt8zC6mZyczMwcvZfjmmDV4pPM0hq7B5F9x77D55U+rFE9FoNVn+g9UEqGiTgNgnIvM4pmfUmo5iHHqE+sOlrMdSVhVI/eHbXx8t0n1dtcdFt9/Ye+aVd6qTVw5PljblNumBc0LE/hKMhJ5sWcqhCFmA62HyblFLt5uNd2/zwECHfz2koHRLoL0ev5Z5GMPqy9LY8MKIUxHyJHbLHrII2kuHf+o1qbZkNMcyM9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(7416014)(23010399003)(1800799024)(366016)(921020)(11063799006)(6133799003)(10067099003)(18002099003)(3023799007)(18092099006)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkNzNzZvT1VpSUs0TUlScXhHWmYrUVJoai9hMGJXVkQzN2x0SzBQQUx3VW1u?=
 =?utf-8?B?dURpQnA4SG1iSWh4TFhaSkdFb2s4NERzN0FSbytrbUpzb0VjaFE4N2JhcUdv?=
 =?utf-8?B?WUxkZTFpOC85cENsWStXb3czN1l4WHhrRFBIeEZHRFhCdW1jckNXUGFKMllw?=
 =?utf-8?B?VTlBRmNpOTNOYWlFWE0wdnk4S3IwZTVzV2lYS3pXeEo0WFJTU0dnazZKWWVU?=
 =?utf-8?B?endZdGUvVVd6L0FxQmVvdThOZi9QS1F2bU84K1NpODlGa00ySms1dTFnam51?=
 =?utf-8?B?SGg4dXVkMXhTQmx0YUk0TlRka01EQWR3SmpXSmN6Z1lQcG9YSURyOGtaUDRU?=
 =?utf-8?B?eDlNdklGNFR3RG91aG1BakVWMklOcGtyYUNEcGVlQUVlTU4yelN2RHkwd25D?=
 =?utf-8?B?MlhlTW0wM0JXQ01jWjF6NlFXTDFCMWNsbUEzWUtKdGRZZjVpaTU3cmFlQzRN?=
 =?utf-8?B?djJlMStvc0NuUituR1p0d05xTzJMUmZnYTBZK3UxWVVQRTllN29OOG1iZHNX?=
 =?utf-8?B?OTBHblhXWjI5QS84blphVkdFMHYwZUF3NWtzZm5SRFN5SGtocGlsUlZuZzFE?=
 =?utf-8?B?VjN4bE0wczBpbG5iTkd3bUV5TWQ5Wk9EMnZTOEs3R2pFL0ZIbDdCS21RU1pH?=
 =?utf-8?B?MkJVMzRwcEF5ekdOZUY2RktWT3ozdmd6Vm5FakovNTZDR0Zza2FLWUtTVkJP?=
 =?utf-8?B?RUxIMHZMdEo3WG9SeGlYTWRFeFVYMnFaZnF5N29ISmVrcE1uTFE4cGx5US85?=
 =?utf-8?B?RFBBRXpUOUJaU0FMV3JHUHFRR29xV1FqdE1VVTBkRVF2dCtkMldmWEs0Si9Z?=
 =?utf-8?B?WnZrTk9vTVlQV045aWZlWU5VbW1kc1NpYkJ3anRoRUFuaDRRdzZQY3U3cEZ6?=
 =?utf-8?B?UGZZNFRoTEsxNzl2eTFaRnlLbmVLWWxJZ0xxWmlpYmluRDJtVDM0K1JNOGFZ?=
 =?utf-8?B?UzlURElNN3JrOFJWZ1hwK3VYalFOU2NDTVpFNGtrN2lJRjAvQjRPVmtBK3li?=
 =?utf-8?B?aGNuSjdLWExteEFIazNGV0tUdU1FSzNsT0d0Z2RSaTZ5Q0NwaXIzem5Db29R?=
 =?utf-8?B?MUNoengyQUtab1ZkTmI1UnhZNjJXdzdYSzNJb0xLZGI3UnFSUGp5L1o1dnFB?=
 =?utf-8?B?TStnQ2hzcitrNjdmUXF2ZFRGYVJlT2dKTTVFQ1ZRdVF3QU5JSUZRM05mY2t6?=
 =?utf-8?B?Y1FpT0pDRHNva050ZFJEYmlJMGRMd0Y4Q1M2N0VKNSt4ZmRMZmcya2RQQ08w?=
 =?utf-8?B?aDAwWnVuVmhicS95RUFyWVhsaEowaGYydWhOdm85c0lRdXZubjJxb2RuS1Ns?=
 =?utf-8?B?dHVYanJQNFdoY3JqNS8yWXVXQVgvUWVXWUhHQ2ZpR2RSb0ZBVml4T3ZjMHZS?=
 =?utf-8?B?b29aZVU4TElVcC9EZHNHZjZUU1JSS2FXM0RFQ3h3aUVwUStpbDRYdDZPbWgw?=
 =?utf-8?B?b0tLeG44aklrZld3NFU5N2x2S3JBbXh0aFFSQTZKb3hMaDkwWGFGOHQ3b2s0?=
 =?utf-8?B?bEtkSmliNjdySWdVa1RpOFNYOXh2ak5BNjRaRUxKWFdiNXQ3NDF2WWVwRWtF?=
 =?utf-8?B?TEFVODh4dnBOR2JTWG1aSzRyWUhPcGswVSt4aGI2WjRKdStyc2NIMjZ0M0I0?=
 =?utf-8?B?Q1dJYXZrTXY4Rk1HeXRoY1owcFhKS21mcnhHMHlXSzNjNjdMcDJJRGkyNU8v?=
 =?utf-8?B?TnErN2dJd3Y3LzNIQVNCRW1oVHFmdk1ZZGFuRXhjVmFvV3U1ZTlEeUpLRzVR?=
 =?utf-8?B?cld0QjFRQU42R09pbWppUzI0ZldadCtjYWJId2FkRlNHNEoxcEp2eGQ4VGZq?=
 =?utf-8?B?U0dKZGd2R0hVbUlOQ29HWW1PZGcyRURYUjg5UHFTSHE5SXNzOGE0YU8zc2dL?=
 =?utf-8?B?a2dKS3BUbzJDWEw4ZG91cEZvWFVNaTZ3aU90N1pvWXBiQXNubUNmS1VYTUVr?=
 =?utf-8?B?aFREWm1QeDVxNnhsM2NEek1MY2g4T2NkQVlNb0JhMk9HS2ZDbUhKb1RJV0JK?=
 =?utf-8?B?Tm54dlBBZnNZNHVjeTA4SlRCa2tKUU8wdngxM2NQNU56cDREdERvcm1YUXlp?=
 =?utf-8?B?djNKZ1d6UDlYTWZHUjNkM0xCcXdJTVBPbEdlOG1ONG0yUEFJOXVRV3NRYk9w?=
 =?utf-8?B?K0Q1TkwydnUvZG1Cc3IzL2Y4eHZ1cWZYKzZ2bWp1RHZCWVo1WW91OW5KbTJa?=
 =?utf-8?B?UWVMVGpFNkM5dm4yNWZmdmdCYkpVbFNFNkpzMmN0MDNrQnRMd1V2WkttZllr?=
 =?utf-8?B?dXppZm9IWXNQMUZhVCt6aE1XU25QN3BUMVV0RHVOSmdNVnV3UGdFMU5hL05j?=
 =?utf-8?B?ZGdONVRWd1dVR2FObnNkZFdWUnhPbkJOTURuRkVIMlVuSWY4R0xvUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 135d1fec-bc44-40fa-2983-08df0a59b89d
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 07:54:17.8786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VRrPiDLPPdzAJPTdrqoFstd7W6S8G64Ns89CAaHNbmsFGa+OCH8UsOM1m32XmiszrSNSXM/STs1mkxJAp+9tqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7115
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

In TCON operation mode, sync signals from FrameGen are ignored, but
a much more customized output timing can be generated by the TCON
module.  By using TCON operaton mode, generate KACHUNK signal along
with HSYNC/VSYNC/data enable signals.  The KACHUNK signal is used as
a synchronization signal inside the prefetch engine(DPRC + PRG(s),
attached to FetchUnit(s)).  Carefully switch TCON bypass mode to TCON
operation mode when CRTC is being enabled so that the prefetch engine
may evade the first dumb frame generated by the display controller.

Since TCON BYPASS bit is controlled by KMS driver when doing atomic
commits, drop the bit setting when initializing TCON.  This also
avoids accidentally initializing TCON BYPASS bit to 1 when driver
module removing and re-installing where an upcoming patch would
disable a CRTC at boot in TCON operation mode if needed.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v6:
- Rebase onto the latest drm-misc-next and resolve conflicts.

v3:
- Collect Frank's R-b tag.
---
 drivers/gpu/drm/imx/dc/dc-crtc.c |  28 ++++++++++
 drivers/gpu/drm/imx/dc/dc-de.h   |   2 +
 drivers/gpu/drm/imx/dc/dc-kms.h  |   2 +
 drivers/gpu/drm/imx/dc/dc-tc.c   | 114 +++++++++++++++++++++++++++++++++++++--
 4 files changed, 142 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/imx/dc/dc-crtc.c b/drivers/gpu/drm/imx/dc/dc-crtc.c
index 1a537cf88daf..beefa01e4fa2 100644
--- a/drivers/gpu/drm/imx/dc/dc-crtc.c
+++ b/drivers/gpu/drm/imx/dc/dc-crtc.c
@@ -6,8 +6,10 @@
 #include <linux/completion.h>
 #include <linux/container_of.h>
 #include <linux/interrupt.h>
+#include <linux/irqflags.h>
 #include <linux/irqreturn.h>
 #include <linux/pm_runtime.h>
+#include <linux/preempt.h>
 #include <linux/spinlock.h>
 
 #include <drm/drm_atomic.h>
@@ -68,6 +70,14 @@ do {									\
 							__func__);	\
 } while (0)
 
+#define DC_CRTC_WAIT_FOR_FRAMEGEN_FRAME_INDEX_MOVING(fg)		\
+do {									\
+	if (!dc_fg_wait_for_frame_index_moving(fg))			\
+		dc_crtc_err(crtc,					\
+			"%s: FrameGen frame index isn't moving\n",	\
+							__func__);	\
+} while (0)
+
 static inline struct dc_crtc *to_dc_crtc(struct drm_crtc *crtc)
 {
 	return container_of(crtc, struct dc_crtc, base);
@@ -229,6 +239,7 @@ dc_crtc_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 	struct drm_display_mode *adj = &new_crtc_state->adjusted_mode;
 	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
 	enum dc_link_id cf_link;
+	unsigned long flags;
 	int idx, ret;
 
 	dc_crtc_dbg(crtc, "mode " DRM_MODE_FMT "\n", DRM_MODE_ARG(adj));
@@ -249,6 +260,7 @@ dc_crtc_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 	enable_irq(dc_crtc->irq_ed_safe_shdload);
 
 	dc_fg_cfg_videomode(dc_crtc->fg, adj);
+	dc_tc_cfg_videomode(dc_crtc->tc, adj);
 
 	dc_cf_framedimensions(dc_crtc->cf_cont,
 			      adj->crtc_hdisplay, adj->crtc_vdisplay);
@@ -273,7 +285,22 @@ dc_crtc_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 	dc_ed_pec_sync_trigger(dc_crtc->ed_cont);
 	dc_ed_pec_sync_trigger(dc_crtc->ed_safe);
 	dc_fg_shdtokgen(dc_crtc->fg);
+
+	/* Don't relinquish CPU until TCON is set to operation mode. */
+	local_irq_save(flags);
+	preempt_disable();
+
 	dc_fg_enable(dc_crtc->fg);
+	/*
+	 * Turn TCON into operation mode as soon as the first dumb
+	 * frame is generated by DC(we don't relinquish CPU to ensure
+	 * this).  This makes DPR/PRG be able to evade the frame.
+	 */
+	DC_CRTC_WAIT_FOR_FRAMEGEN_FRAME_INDEX_MOVING(dc_crtc->fg);
+	dc_tc_set_operation_mode(dc_crtc->tc);
+
+	local_irq_restore(flags);
+	preempt_enable();
 
 	DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(ed_safe_shdload_done);
 	DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(ed_cont_shdload_done);
@@ -552,6 +579,7 @@ int dc_crtc_init(struct dc_drm_device *dc_drm, int crtc_index)
 	dc_crtc->ed_cont = pe->ed_cont[crtc_index];
 	dc_crtc->ed_safe = pe->ed_safe[crtc_index];
 	dc_crtc->fg = de->fg;
+	dc_crtc->tc = de->tc;
 
 	dc_crtc->irq_dec_framecomplete = de->irq_framecomplete;
 	dc_crtc->irq_dec_seqcomplete = de->irq_seqcomplete;
diff --git a/drivers/gpu/drm/imx/dc/dc-de.h b/drivers/gpu/drm/imx/dc/dc-de.h
index 211f3fcc1a9a..c39f2ef5eea9 100644
--- a/drivers/gpu/drm/imx/dc/dc-de.h
+++ b/drivers/gpu/drm/imx/dc/dc-de.h
@@ -54,6 +54,8 @@ enum drm_mode_status dc_fg_check_clock(struct dc_fg *fg, int clk_khz);
 void dc_fg_init(struct dc_fg *fg);
 
 /* Timing Controller Unit */
+void dc_tc_set_operation_mode(struct dc_tc *tc);
+void dc_tc_cfg_videomode(struct dc_tc *tc, struct drm_display_mode *m);
 void dc_tc_init(struct dc_tc *tc);
 
 #endif /* __DC_DISPLAY_ENGINE_H__ */
diff --git a/drivers/gpu/drm/imx/dc/dc-kms.h b/drivers/gpu/drm/imx/dc/dc-kms.h
index cd7860eff986..a25d47eebd28 100644
--- a/drivers/gpu/drm/imx/dc/dc-kms.h
+++ b/drivers/gpu/drm/imx/dc/dc-kms.h
@@ -50,6 +50,8 @@ struct dc_crtc {
 	struct dc_ed *ed_safe;
 	/** @fg: framegen */
 	struct dc_fg *fg;
+	/** @tc: tcon */
+	struct dc_tc *tc;
 	/**
 	 * @irq_dec_framecomplete:
 	 *
diff --git a/drivers/gpu/drm/imx/dc/dc-tc.c b/drivers/gpu/drm/imx/dc/dc-tc.c
index d0d4faba790e..746fcaaf97f5 100644
--- a/drivers/gpu/drm/imx/dc/dc-tc.c
+++ b/drivers/gpu/drm/imx/dc/dc-tc.c
@@ -8,11 +8,30 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
+#include <drm/drm_modes.h>
+
 #include "dc-drv.h"
 #include "dc-de.h"
 
 #define TCON_CTRL	0x410
-#define  CTRL_RST_VAL	0x01401408
+#define  SPLITPOSITION_MASK	GENMASK(29, 16)
+#define  SPLITPOSITION(n)	FIELD_PREP(SPLITPOSITION_MASK, (n))
+#define  DUAL_SWAP	BIT(15)
+#define  MINILVDS_OPCODE_MASK	GENMASK(14, 12)
+#define  MODE_4PAIRS	FIELD_PREP(MINILVDS_OPCODE_MASK, 0x1)
+#define  LVDS_CLOCK_INV	BIT(11)
+#define  LVDS_BALANCE	BIT(10)
+#define  LVDSMODE	BIT(9)
+#define  ENLVDS		BIT(8)
+#define  INV_CTRL_MASK	GENMASK(7, 4)
+#define  BYPASS		BIT(3)
+#define  TCON_SYNC	BIT(2)
+#define  CHANNELMODE_MASK	GENMASK(1, 0)
+#define  CTRL_RST_MASK	\
+		(SPLITPOSITION_MASK | DUAL_SWAP | MINILVDS_OPCODE_MASK | \
+		 LVDS_CLOCK_INV | LVDS_BALANCE | LVDSMODE | ENLVDS | \
+		 INV_CTRL_MASK | TCON_SYNC | CHANNELMODE_MASK)
+#define  CTRL_RST_VAL  (SPLITPOSITION(0x140) | MODE_4PAIRS | LVDS_BALANCE)
 
 /* red: MAPBIT 29-20, green: MAPBIT 19-10, blue: MAPBIT 9-0 */
 #define MAPBIT3_0	0x418
@@ -24,6 +43,16 @@
 #define MAPBIT27_24	0x430
 #define MAPBIT31_28	0x434
 
+#define SPGPOSON(n)	(0x460 + (n) * 16)
+#define SPGMASKON(n)	(0x464 + (n) * 16)
+#define SPGPOSOFF(n)	(0x468 + (n) * 16)
+#define SPGMASKOFF(n)	(0x46c + (n) * 16)
+#define  X(n)		FIELD_PREP(GENMASK(30, 16), (n))
+#define  Y(n)		FIELD_PREP(GENMASK(14, 0), (n))
+
+#define SMXSIGS(n)	(0x520 + (n) * 8)
+#define SMXFCTTABLE(n)	(0x524 + (n) * 8)
+
 static const struct dc_subdev_info dc_tc_info[] = {
 	{ .reg_start = 0x5618c800, .id = 0, },
 	{ .reg_start = 0x5618e400, .id = 1, },
@@ -32,6 +61,8 @@ static const struct dc_subdev_info dc_tc_info[] = {
 static const struct regmap_range dc_tc_regmap_ranges[] = {
 	regmap_reg_range(TCON_CTRL, TCON_CTRL),
 	regmap_reg_range(MAPBIT3_0, MAPBIT31_28),
+	regmap_reg_range(SPGPOSON(0), SPGMASKOFF(4)),
+	regmap_reg_range(SMXSIGS(0), SMXFCTTABLE(3)),
 };
 
 static const struct regmap_access_table dc_tc_regmap_access_table = {
@@ -46,7 +77,7 @@ static const struct regmap_config dc_tc_regmap_config = {
 	.fast_io = true,
 	.wr_table = &dc_tc_regmap_access_table,
 	.rd_table = &dc_tc_regmap_access_table,
-	.max_register = MAPBIT31_28,
+	.max_register = SMXFCTTABLE(3),
 };
 
 /*
@@ -59,10 +90,85 @@ static const u32 dc_tc_mapbit[] = {
 	0x13121110, 0x03020100, 0x07060504, 0x00000908,
 };
 
+void dc_tc_set_operation_mode(struct dc_tc *tc)
+{
+	regmap_write_bits(tc->reg, TCON_CTRL, BYPASS, 0);
+}
+
+void dc_tc_cfg_videomode(struct dc_tc *tc, struct drm_display_mode *m)
+{
+	int hdisplay, hsync_start, hsync_end;
+	int vdisplay, vsync_start, vsync_end;
+	int y;
+
+	hdisplay = m->hdisplay;
+	vdisplay = m->vdisplay;
+	hsync_start = m->hsync_start;
+	vsync_start = m->vsync_start;
+	hsync_end = m->hsync_end;
+	vsync_end = m->vsync_end;
+
+	/*
+	 * Turn TCON into operation mode later after the first dumb frame is
+	 * generated by DC.  This makes DPR/PRG be able to evade the frame.
+	 */
+	regmap_write_bits(tc->reg, TCON_CTRL, BYPASS, BYPASS);
+
+	/* dsp_control[0]: HSYNC */
+	regmap_write(tc->reg, SPGPOSON(0), X(hsync_start));
+	regmap_write(tc->reg, SPGMASKON(0), 0xffff);
+
+	regmap_write(tc->reg, SPGPOSOFF(0), X(hsync_end));
+	regmap_write(tc->reg, SPGMASKOFF(0), 0xffff);
+
+	regmap_write(tc->reg, SMXSIGS(0), 0x2);
+	regmap_write(tc->reg, SMXFCTTABLE(0), 0x1);
+
+	/* dsp_control[1]: VSYNC */
+	regmap_write(tc->reg, SPGPOSON(1), X(hsync_start) | Y(vsync_start - 1));
+	regmap_write(tc->reg, SPGMASKON(1), 0x0);
+
+	regmap_write(tc->reg, SPGPOSOFF(1), X(hsync_start) | Y(vsync_end - 1));
+	regmap_write(tc->reg, SPGMASKOFF(1), 0x0);
+
+	regmap_write(tc->reg, SMXSIGS(1), 0x3);
+	regmap_write(tc->reg, SMXFCTTABLE(1), 0x1);
+
+	/* dsp_control[2]: data enable */
+	/* horizontal */
+	regmap_write(tc->reg, SPGPOSON(2), 0x0);
+	regmap_write(tc->reg, SPGMASKON(2), 0xffff);
+
+	regmap_write(tc->reg, SPGPOSOFF(2), X(hdisplay));
+	regmap_write(tc->reg, SPGMASKOFF(2), 0xffff);
+
+	/* vertical */
+	regmap_write(tc->reg, SPGPOSON(3), 0x0);
+	regmap_write(tc->reg, SPGMASKON(3), 0x7fff0000);
+
+	regmap_write(tc->reg, SPGPOSOFF(3), Y(vdisplay));
+	regmap_write(tc->reg, SPGMASKOFF(3), 0x7fff0000);
+
+	regmap_write(tc->reg, SMXSIGS(2), 0x2c);
+	regmap_write(tc->reg, SMXFCTTABLE(2), 0x8);
+
+	/* dsp_control[3]: KACHUNK */
+	y = vdisplay + 1;
+
+	regmap_write(tc->reg, SPGPOSON(4), X(0x0) | Y(y));
+	regmap_write(tc->reg, SPGMASKON(4), 0x0);
+
+	regmap_write(tc->reg, SPGPOSOFF(4), X(0x20) | Y(y));
+	regmap_write(tc->reg, SPGMASKOFF(4), 0x0);
+
+	regmap_write(tc->reg, SMXSIGS(3), 0x6);
+	regmap_write(tc->reg, SMXFCTTABLE(3), 0x2);
+}
+
 void dc_tc_init(struct dc_tc *tc)
 {
-	/* reset TCON_CTRL to POR default so that TCON works in bypass mode */
-	regmap_write(tc->reg, TCON_CTRL, CTRL_RST_VAL);
+	/* reset TCON_CTRL to POR default except for touching BYPASS bit */
+	regmap_write_bits(tc->reg, TCON_CTRL, CTRL_RST_MASK, CTRL_RST_VAL);
 
 	/* set format */
 	regmap_bulk_write(tc->reg, MAPBIT3_0, dc_tc_mapbit,

-- 
2.43.0

