Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB546C79F80
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 07:53:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0388910F8ED;
	Fri,  4 Sep 2026 07:53:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="dLj+NpWl";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013010.outbound.protection.outlook.com [52.101.72.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3451F10F8EF
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 07:53:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mfpRGOtGzoNhfqHO95jMEHQTdm2sFfU4pW0AP6K8qtsJy7kfqGPqt3bXJOyO3i83OvTA87bbuENj5/cfjA2KQ1jRcCOQz8oJerw8L4lQA1DRV3QyzeS4qlckMZKJkkWvOsuDf4npN0Ft9NRI4cn1Fej3yXvxbpuQY7KJpc0B3as9O/d02+vAzeT4RTH64y5r8vvJbaOmc51RBGQXZ1V1LbURp704xI2T8MPryzXdgK1TvnqBOvQH76mDWWMHIB+CnJDDctPOmj84WXr3jGRX8jWswYzu0TncYWvsBqCdNQGOp354XRAje8Zvk1IhZw9+xlvFYxlPp16rF9TeCmJOGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Bqv1R8GmGKcasUcemz8w8yZIbvgHQVHBwtx+4sBYNs=;
 b=p25aD6Ed2eAC8LsO6o/dAIbsXDwl3pWYW/8Ywh6b3vDxjQK9Tddtn3t1/NEMs9XtZM/o5CUST6RBxnnQGLzleIM9so0AZPeYSNHxxtWQQlfMgMRzFkxRhdclKqp9cOGJ5xgQMsZD4eP/sKVVicm1tNotCH3Sz/jI2F+A2+4Yl84cHTXwvCl1sydRbkWoj8j0I+iXKxvcU0M5ATAHuo8CJ0NtQrVtcnAL9A1S2DXj0LIA4fxJx62sP/9KS5fb7Xt7UB44bB3jt1QdbMKB/xyO7yFq4V8wS/CbR94oGVppfyKDglrXfOW7TjDRtal3HL51HkLEOLes8/6HM1hVmBmJGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Bqv1R8GmGKcasUcemz8w8yZIbvgHQVHBwtx+4sBYNs=;
 b=dLj+NpWl/kpSZ18+VHJRz9IZnOlI5Qd49Jpk9NV93GMHyeKFccaxDZb/E+pNLu6KQD5xMkoTKHcQYOBfBP+EtO8uCjLmxlDCAezKB+KHlHeuRcV+sqxLjJDn0yd9Wo+Q7s+xO8pFiID4Mmd03sOrbISnB/zwGFL45agnBSOxI4Hn/JYdSsZ1DwSk20StESuMhHIdpyzQvqy7MHXJB8qb9ePUaSgQgCjPEKVef2oM9MDXuTr3WLDxtybxf9fPv6rA2NXKvWgXrBWlBUCK2VMp6xbxAIXKiVqO6m5D5JEMib3EUL0UGCYZrTWKCqU8grMg8lxoxH9xNDiNUTZ8RHQe9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by DB8PR04MB7115.eurprd04.prod.outlook.com (2603:10a6:10:128::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 07:53:52 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 07:53:52 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Fri, 04 Sep 2026 15:54:53 +0800
Subject: [PATCH v6 03/13] drm/imx: dc-fu: Fix dimensions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-imx8-dc-prefetch-v6-3-26643e3f6cb7@nxp.com>
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
 Liu Ying <victor.liu@nxp.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SG2P153CA0017.APCP153.PROD.OUTLOOK.COM (2603:1096::27) To
 MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|DB8PR04MB7115:EE_
X-MS-Office365-Filtering-Correlation-Id: f1175135-335b-4a45-178a-08df0a59a987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|7416014|23010399003|1800799024|366016|921020|11063799006|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: VUlNtgixFUnkcjB5vu8cfe2067L0zBk+nsuynhoLPrNsmmR4e4yiIXXcTwQPerXyVEj8lpYTrr8V1SUy6znkkauYIeuVXptYaylF7aFRpwgQld62N7rbNS9ehlRlRzwiO3fxTUr2U/MNoz+RB9kZ5ktgE5CgpvycY9VYmYXXc2UbJcZiXbkdMZLygBjEOOp4kcX1kQDNC39/HzM6TSNrQIcRmepM1w5UYS+mdPeF3RvUUISnlsnmTEK0gWdHdjKuvkXYOq4DFxtc0kPJlPcnIe03wfzk0K2oq1GFWVOkYq6wdFc/WP/X1GBv8uT62WTgkGY8+PZPukKRKng4yPoMYjdbtwTAKCDbSM0orvB9KYnt8BREmNETosj9EhdFA+Genix/TJmXDHDSlOz+iwtGr39VTlMCap0QPt7KMuLdNetpLoDo0QEb5tSjJLMvzH4++F+AEbQ3q5AmDJ++KlRe63iW6R4yeenEVLsEhmM2xUZQwe/UZucPeT3bmZ2BSjDvPYwh6iCqauf4KiI6JydZUYtfr5lBOHTHiL0pvog6Smw9CdEXK/kp6IeLnX1VQQtdRYwrwebR6ipWw6NBFk2WYyUpz7FuXBkCIDEIVqkdkw3D2IKa/M0fPBVeLwROws/wSwiB0FIKxZ3AtJk5YrOqwVJVNw3wxsikWEy1JFWF7YIJLPdFqeRcBKuLI9H0uwmKw+QFo3YsQlB/1LoFPeNPfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(7416014)(23010399003)(1800799024)(366016)(921020)(11063799006)(10067099003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bng0Q0FRTU05WFhmc01zVjNtTVdFQ2NVWldTUE1Vd21KdGQvUFMxSHkzS2xL?=
 =?utf-8?B?eVVyT0RkSmdWK1hNY2RHY0NSekpYaEo0d3M3ZThxTXA0YnlUUjJ6SEgwNWNL?=
 =?utf-8?B?cm5jb0JBV2FaMTVUV2p4QXJjTTBWcTUyVTNQNFZickNpZ2haRlB3YW52eWJl?=
 =?utf-8?B?QXRjNTVwdXhROFdOOGZPYmlMTzMyV2VqRStXOHRsQzBLdFJQc1N5Sy9XbWJJ?=
 =?utf-8?B?VE85RGdtY2FFdEpCRFdWeW45SENVdk1XRXVqS044cGJQeENjNCtBMUdpdG1v?=
 =?utf-8?B?OFl0azhIanU1blk1SGIzck5WaGJxRnVDdFBrR2lDNDU3NnJwdkx1U2tjd2xa?=
 =?utf-8?B?ZWJzYktTbktlaEM4SVMwT2R2MFZCSTl6N0Q0VFJ5V0VyOFZpcnNXVzRpdWNY?=
 =?utf-8?B?YVA5NkZGd0FzeGxIeW1LaXowblh6VE5uR0lvYXFLeHNjaG4ybHhKc0FYaC9Q?=
 =?utf-8?B?c1pJSmQrVVVuelpsQ0tjY0VNQlc5M1N0QS9rMmNjT3ZkVCtXTFNCYjFPc2lj?=
 =?utf-8?B?Zld3T2dtdlhRNk9xcXkycjFIYTFSb1l3amNoMnVyTUpqTWJVSWJRelhEVkg0?=
 =?utf-8?B?akZiTkM4ZURoYkdMNXl1RTFlbGxGYkQ5dkFkVVhHREtqVzJxTmV6c2w5dUE3?=
 =?utf-8?B?OWt0b1VYWXNrMzhwYXZFL2szNnpKVjJKZ1lwL3lOR0l3TklKVG5UbDBnQnN2?=
 =?utf-8?B?VHR5VWp4azE5Q3NzRTBPSEptaC9kdllTTXBqbUJqUnI0bTNLdXB6T1NVYmcr?=
 =?utf-8?B?TERQY2NCdDJFNUZkZm1SOElCNFhOYmNFYnk3eTdjOW1SSkN0UlZQQ2xGZldF?=
 =?utf-8?B?aitXWWZ2QTRZMjNoK3pVNXJ5c3Y3ZnkybUJlZ0dRdy93S3BJcjdhcjhkS1Rh?=
 =?utf-8?B?MzR6TG5NWGNqa0FnUHdqRU9OUmFmSTdTbHF4M2I5ZGw4RE1wczdLc2VPeUph?=
 =?utf-8?B?QnU1djVUQzdTZ21Ta2ZKOFVoalR0NlBzU0tieW9ZcEkxd3BJTHdBTURnVVY3?=
 =?utf-8?B?ZTk1OE8wMWNuMG9CSjdBRGlKQ3EzSVkvbk1PM29DZlFXbnZJRlhxNDhobmdq?=
 =?utf-8?B?a3k5Ni9vWlc0eDAyYmNMOWtFdTltc0dCVUdPMVRtSGtqYkRYS2xrV1luR3BH?=
 =?utf-8?B?ckpWYXkvVEhSaGlSVFlYQXJ4Z25OcmI1cWd6Q1dtVngvQ0NRRUMvd1dtMWU2?=
 =?utf-8?B?SkFhTFJWSExtOUZOSEJKK0x0M1ptVnRqM2NTVGtTSXJHakp3SFJDWjhiY3NM?=
 =?utf-8?B?T214L1lYSGl6RVVIZnNqeHRqdXdtUjhGTC9sMU9qY1ltbnFucG9Xczh5ekFW?=
 =?utf-8?B?MmJCOUJsbzdFTE5naUNEZ3hPU3FoeVdmU0xYbzVrTWJRaU9JVUt5VXZBUlhH?=
 =?utf-8?B?SWhUWXhaMjRQaXl1azY2YlJKWSt5UXNzL0NNYWJiOVdJRFYyVXpnbnl1L2Uw?=
 =?utf-8?B?YzlZK3J0U2t1aFpTc0NJVXpUaDlSSkVOMVBDWG5DeTJnRE9yNEQyYm1wSGdC?=
 =?utf-8?B?RW5lRmE4bDMrMCszb094b0tlUmZlWCtMaVNvd2tuSTVyWTlGNjdpTWJ0dXMy?=
 =?utf-8?B?NHcxN3VHdWN5Nk1zbWIyaURJYU8zTThxeFloN2QzQTJmL1c4OCswRElqWmdh?=
 =?utf-8?B?SnVlVUhNSitKalZ5ME5GL0RRaUlHTy9jMUFLUUVndGh3ZUVOdFhFVjRHTEtn?=
 =?utf-8?B?QUlGLzJERGxkUWpIdkxjbERMOE9VcHJrRU1iVzVPTlp3QXM4UnlqTEtEN0hN?=
 =?utf-8?B?aU1QM2FZcXBIUjhnSzV6ZkYwbm1aOHRhYWJubSt1b0pDc1N3U1lEQllMbFN1?=
 =?utf-8?B?U29RMCtBODF0a0ZjV21UaE9UMnIrL3F5Ty92bzVlR3cxZHJlemEwVHNOalRs?=
 =?utf-8?B?b0tITC91U0xvQlRGamM1cVRrWmw4RXByZmpvTmJpTmdtMDNBc1VnakJBM3NH?=
 =?utf-8?B?U09CTnlXWFRrNEpIMldoY1Y4NEkybVNrYkFwZEY1Rk1VL2NvSFhLd0xUMFJi?=
 =?utf-8?B?ZEdZWThvRHdRYnFBeEVJZGhMNFFQUE96MjNmV0dzbUhXSGRuMkZuYnBTcGF0?=
 =?utf-8?B?K2QwN1FWbUdXR04zOVR6amZ2TENuSG9MN0RPbERxVVNackZzUCtRTW8vWkRF?=
 =?utf-8?B?TmFmV1Rwa05mN3d1VG9HZFpKWHJpTXBadS9YYTBNekVub1lpcG9OeXg0bGRQ?=
 =?utf-8?B?Si9JZ2FZZGticzEyL21VN1QyTWZ4UmRMUURPMmhBRHFjZkswS1dyaHFLcXhw?=
 =?utf-8?B?a3A3SnJBalYxMWkyN1FHTm9XZ3dTTTR2SlRPcjZNY2xnOHJ1RUE1VlpjbS9v?=
 =?utf-8?B?SXZrTS9vWWlRRUlXVjhKZUtER3JEL0xPNkI1R3c3MHZ1MHF5ZnRTdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1175135-335b-4a45-178a-08df0a59a987
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 07:53:52.3212 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nstQXVr1F54yXC1LeZHeCdYa8FzlOX3BCELpYNYope3lGcwmKHAKCkyehMBvW148yxSlmMsqAYqA5XTkm35c+A==
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

Fix off-by-one issue in LINEWIDTH, LINECOUNT, FRAMEWIDTH and FRAMEHEIGHT
macro definitions.  The first two macros are used to set a fetchunit's
source buffer dimension and the other two are used to set a fetchunit's
frame dimension.  It appears that display controller itself works ok
without this fix, however, it enters panic mode when prefetch engine(DPRC
and PRGs) attaches to it without this fix.

Fixes: 0e177d5ce01c ("drm/imx: Add i.MX8qxp Display Controller pixel engine")
Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v4:
- Rebase onto the latest drm-misc-next and resolve conflicts.

v2:
- Collect Alexander's and Frank's R-b tags.
---
 drivers/gpu/drm/imx/dc/dc-fu.c | 4 ++--
 drivers/gpu/drm/imx/dc/dc-fu.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/imx/dc/dc-fu.c b/drivers/gpu/drm/imx/dc/dc-fu.c
index 1d8f74babef8..2e197b3344bd 100644
--- a/drivers/gpu/drm/imx/dc/dc-fu.c
+++ b/drivers/gpu/drm/imx/dc/dc-fu.c
@@ -31,8 +31,8 @@
 #define STRIDE(x)			FIELD_PREP(STRIDE_MASK, (x) - 1)
 
 /* SOURCEBUFFERDIMENSION */
-#define LINECOUNT(x)			FIELD_PREP(GENMASK(29, 16), (x))
-#define LINEWIDTH(x)			FIELD_PREP(GENMASK(13, 0), (x))
+#define LINECOUNT(x)			FIELD_PREP(GENMASK(29, 16), (x) - 1)
+#define LINEWIDTH(x)			FIELD_PREP(GENMASK(13, 0), (x) - 1)
 
 /* LAYEROFFSET */
 #define LAYERYOFFSET(x)			FIELD_PREP(GENMASK(30, 16), (x))
diff --git a/drivers/gpu/drm/imx/dc/dc-fu.h b/drivers/gpu/drm/imx/dc/dc-fu.h
index f678de3ca8c0..cc93317e3001 100644
--- a/drivers/gpu/drm/imx/dc/dc-fu.h
+++ b/drivers/gpu/drm/imx/dc/dc-fu.h
@@ -38,8 +38,8 @@
 #define YUVCONVERSIONMODE(x)		FIELD_PREP(YUVCONVERSIONMODE_MASK, (x))
 
 /* FRAMEDIMENSIONS */
-#define FRAMEHEIGHT(x)			FIELD_PREP(GENMASK(29, 16), (x))
-#define FRAMEWIDTH(x)			FIELD_PREP(GENMASK(13, 0), (x))
+#define FRAMEHEIGHT(x)			FIELD_PREP(GENMASK(29, 16), (x) - 1)
+#define FRAMEWIDTH(x)			FIELD_PREP(GENMASK(13, 0), (x) - 1)
 
 /* CONTROL */
 #define INPUTSELECT_MASK		GENMASK(4, 3)

-- 
2.43.0

