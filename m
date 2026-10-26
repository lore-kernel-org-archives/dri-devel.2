Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAD660A2614
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=TLewGmXv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DE7F10EDB9;
	Mon, 26 Oct 2026 10:05:28 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011071.outbound.protection.outlook.com [52.101.70.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0B4510ED9E
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:05:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOTCc/zLhZdUjpsVVLY81Z7SyKssIHPoteCLGfU6gIRS2mLbyYvjW5N9pE+4bNjQWsO/0WyiKxtIc289fnhJNxXGn+4wWeg6IeHVX+tnk6b42SWIJaZpfj8JSy3uyNzh3xkwFQUAe1thYnMeBP9CiBFDVATykk7oCCTL9oq8JTIrYIv/Mu+04tG7s76RfrslsUKBIIJMGDfsfWvEV+Y4T8JwpXZzLWAW00/jsFI8cAAAB6+sh/bS6bsP8p9WMcAHMzuw8+IMteN32mB+gNIay5mDz8DQjXnuubjKFvKhlvEzTCBoRYUk9h9eoUelQ0j53KOI71GF8QBgERNO1AzqCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+gPCWzIAdsVPYkrizOXOeMwNsWbBjc3l8QYVxshcrI=;
 b=vNAhdC+rS128ZLPGIKDcJAmpMuPNxcSJiWznCbao76P74fAsqGdnqv2hdxNcfDaex1za2mlbMCNwj5c2TXtsnZdIwdRibSTsHB/aH7wqllCyTIx5+QZAJLJB5+oWfixSaOFRwLKlCQOh+vNNErU+v5QiwCoRuIkOP586YKlWXIXidKOvxXMveSAl2gazoCqD4mO2NNnclKOfKJM6/PkQIDHImcNEwIazB4nNRHiz0WE2iWjG80c2KwTSYM+cN6sdwAb4SU02/znZtSpoJl6Tp2k1Z8ZgHM6PSbyQXz6+LzwUNfKz7f/RjG29EcHqehgvFwExxktJKmZLFMHeam440Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+gPCWzIAdsVPYkrizOXOeMwNsWbBjc3l8QYVxshcrI=;
 b=TLewGmXvDxAv4ZMzxsDeFlwsZwILRvj/SZZbiNzShFoOpTnJYSjU4LzNAAY5fhSy8RCopP2gwor2zkvUhshMjUdAJ8I3cI85BdOzcossSFVJWG2OqFwO0JrKftDrr6ryQWthN58Pxou1eeX1PyLlmoI8sND2sBra9pbSKXxq7e24eZjeqBg2lUwvODCQIIo5siYLSMLQZ+myc6b5Ea3Kax+NE0ku9nsCQKR3EMLptJDZom8bAbmSD9IQUv54TJR2tmqGWMRR9NkftijuaiK2JVYMnrV3UqRzf69sT6JFmaZOrBPChdg0DzslWRlW+tSzpcNGZqKYkQ4WnLZr0qIY8Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by GVXPR04MB11500.eurprd04.prod.outlook.com (2603:10a6:150:288::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 10:04:59 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 10:04:59 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Mon, 26 Oct 2026 18:05:19 +0800
Subject: [PATCH v7 14/15] drm/imx: dc-fu: Get DPR channel
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-imx8-dc-prefetch-v7-14-a0b50cc4fc65@nxp.com>
References: <20261026-imx8-dc-prefetch-v7-0-a0b50cc4fc65@nxp.com>
In-Reply-To: <20261026-imx8-dc-prefetch-v7-0-a0b50cc4fc65@nxp.com>
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
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:4:197::8) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|GVXPR04MB11500:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d407bbf-d9dd-45ae-974b-08df33489835
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|19092799006|366016|23010399003|1800799024|921020|11063799006|56012099006|261021121427099003|261022105027099003|261021123027099003|261009223027099003|260925021311599003|260925021911599003|260925022911599003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Z9DGG8w/f2RhiEiY3x1zU5qAwsCqOKJ9JlBQ/YYnLEAHaRj+cWEorlsuTLxxtZnq+Yn8SND7DGhp70Qd0akYJlh/AWP+pFBNUUk1dCrhslCalMngfpaJ1pTW25W1UZjaOi+D1x2Z1ItP+eq9B9JtaOsR3nsIikT+ARgQcQn1aaJ/X19sk1ZuKHaXOULa37pKUrKFMuAK/jrMoQpSDOHPtVnXziADSq/zHyWZTpY6IhfEXWBA/b5S9db5irS0C/tfAWrUJIdLElPEK9cq/3tZnz4R4YqkYUXy4EpAbMaMybiQkFcih9AzYrCZHsmBimAFfG4zxLDYh0LqzP87r7gM3lkQnpEc4/4FMnX6TTyj8yjAI6Um2sO9Eet9r/qY/7VbdjBDF3Mp1VZ7e7Y7sUIqvHbThjuO+VTowAY2qKGmu+t9MHLe355jlGoAoBrE7sH05JkxgKXQ7dzqwtEy8FjgsoOBSMb1sgxPFFUI1FxGzXXWp8itAwaCSMSAu3WNEdxTIihD88/M605aOQEnwUJRt6nl/0dlDpf82mhmRehYBMg5NUIAqtqPxew/tpep3crY/iREUwqegKJXNqHzYJ9xqiQQc/eW6ebAhkqa/15qFLILicwZMf/EBjbGH0Hjzr8hVtFldzp/GmqBtPq6XDb51WBmMcNvPrJDNZM0tROE92T1PH8WdlBP9DkUY2gazwHMY2rcGQfmz94NiUCgMpBpRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(19092799006)(366016)(23010399003)(1800799024)(921020)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(261021123027099003)(261009223027099003)(260925021311599003)(260925021911599003)(260925022911599003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnRFckpMYVFkTUJLODQ2U09WbFg3Q0E1NFgxblViQ1cxcXNTVXdHQUIyWndK?=
 =?utf-8?B?ci8reVd5ZDl1RW5GRDRqU1hJTmdzTy9HR1dnTUhON283NEQ1azFqMUIwVDFN?=
 =?utf-8?B?dk1nUlcvcjJ0cWV2NGZXRExhUk51NS9tV2RJSWc3ZUsrTkpoZjN0WFdRMFZM?=
 =?utf-8?B?bkZlMytTblh6NU9yT0lsbDdsNTI2cFNSeE5vVmcxclBJYktZaUk4dGxHZEIv?=
 =?utf-8?B?K3lMWmYyWHViWDFKbytvejA1Y0RqYTJyQWY2Y05oRGVyYkpQa2lJLy84anVY?=
 =?utf-8?B?aXc2YXJzRzlNMnZZdytoSXhXbk5rWkNycytlS05hdnIwLzZ4QUlJcHFqdGd5?=
 =?utf-8?B?T0NRVGVJT1RBVnJsZUl3QzdRWTdtbHhHUTA1SUMzYmxiTmQ1VTFWc0wvNFN1?=
 =?utf-8?B?bUx5ME5jMHZWMU0ybWFrVTZSYkIxYVhQRGRoaStQZUZKT2xTVkZYUlZ4MXBa?=
 =?utf-8?B?TGtaZDZLUVVNZmdYMHkzRC80R05SamtReEVYVzBOMzBaZE53c1BDY3ViUFRC?=
 =?utf-8?B?dUVSOGtZeThhTC9hWGFjdFcxZ29sL1NEY1ZOQzM2WjNrMjR6RzhPK0ZuNVhG?=
 =?utf-8?B?MU41N25CSUJwaGNZSDB1cWRneWR6Q2sxM3MwNEUzR3VRdnNGUFRxcGxEZndV?=
 =?utf-8?B?S2JHZkZkb0FyZDl6ZzFub2RlejAwRW5WRDFCdS9Fb05wU1RHcHVpcEp3ZzRv?=
 =?utf-8?B?NGYwaVBGcmxFYU8yYlhvQXdXK09HbUZ3cG1ydUUwWEY4L3FGMjNySmhYV1ow?=
 =?utf-8?B?YUdJTXRtMGxjZDJWNmFSSG9yV1lIOFZOTG9jQ0REbTIyWFVuYzlnWUpVWG1P?=
 =?utf-8?B?S1JmVzRyL3pUUXUrclV1aGIyV3FGU1Q2c01Vb2NGZzRMMVhFWDVHVGJucFFn?=
 =?utf-8?B?MHRPWXlLeEN3KzBHRUR3WFM3b0I3NGQwQ3RlTnBKT2VMRmtlN1RIeVM2VHRU?=
 =?utf-8?B?NSs1RytzemszdHQrZVJJMHpHS3c4cm5hdHRLTU10SDBabyt5UWF0UWpsU2Jm?=
 =?utf-8?B?L0hIZlJrc0hSaGJuczhSZGM2ZTZJcWdLWDZBZ2RPNzVTdjYrS1VHd0xrR1VI?=
 =?utf-8?B?am5SZGpiTGtKNXRCS2xLblI3VXo4c2F2MUlnWnBsMWppdHRPbmVCbzBVRmps?=
 =?utf-8?B?UERQMjl3SGZRQWhYUmY2QXJaMCs2SWxEOE5yUHduRTdOT2FmV0pEaFlmamxJ?=
 =?utf-8?B?U09ZN1NEU1ZTQzZpZnNLVEZZb2xYOENWZkJqTlpNbk9QWHJ5N2pOL05UVHF0?=
 =?utf-8?B?eXJxM1Z1NEdkNUMyVkkzVFZ0bFJUMWkwdzcxdHpZK0tFOFRMUkU0S2QxejNG?=
 =?utf-8?B?dFduQnNCZVphWE9OSldNUzhNQVJXVE94Nml6aThpRzQzaXhHSmdFRWQ3ckxn?=
 =?utf-8?B?QkdNNTFMWlkzazdzOVpNQlV4YTRKaE1qdTJOK3NWbzg3UTdyRkM4c3IzZzY3?=
 =?utf-8?B?dEI2S2VBZWprOVBDV1hMK29IVS9NRGZTd1hiVGt2cFNoOWxneWdwNDZFLy9m?=
 =?utf-8?B?V3BwZFZ1WENjRVhYckVQL0huSmdwMkV5aVlGSkRVaEtkNjdqOWYwUE4zSjNu?=
 =?utf-8?B?TDRsYjNYNndZb2JwRTJ0VVp2cE96UklCbHlOSXd2L2RGdXN0MXZBOTBwOTNo?=
 =?utf-8?B?TGJSeTk2ZndmNFh0eCs4WDBFUGtPYVNDRHJoOEIvT0l4WDNEZHBLWlNlSHB1?=
 =?utf-8?B?blhkUitRSUVJR2h2UEwrRFVVakhlNGRyNlRJemJCcVlocVQwVFhMYk02Nktl?=
 =?utf-8?B?eXNxZEJHbXE3UHJFNGtRYXhmM21aQk1TdDMzTEJId3NSdkNkTEdWcDVLWUk1?=
 =?utf-8?B?MTFoR2QzNVFIcVVFTGJHaCtRNGVYV0NkbHVJV0FNTmlYVjZlVi9ZZHRVcVdN?=
 =?utf-8?B?V2pRUFJPaVBtT3Iya0h0Sk4vOWdWS2NsSHJQRXNUVDc4cC9RcFJhRWhONG1m?=
 =?utf-8?B?dXJURWw4MlRTSmdpTjZmNzlGMzZPbXhyTDlYWWQzMEtkRUZFSDVSd1hzdlU0?=
 =?utf-8?B?YmNKWE1jUGJqUk92ZndXTzJTMjZPSWNaeVMxZ1hCM29ERUdITW5zY2FMZTNK?=
 =?utf-8?B?UXVXVnAzYUhiSGZlZUVScDBDSytYNktGaHM4dFhDbGFYWjBKeDBOZm51RVNV?=
 =?utf-8?B?a3dhOG5PSXM1YytwZnBzbVpCUkJ6VUtYUVVmM2hOSUVJMUF3NWhFODlBMlJx?=
 =?utf-8?B?U0Z0a1RRMGV2VHQxeUJUL0N4VmVvb2FSazZJNlRDaHFRU0pTNVQ3YlorenFo?=
 =?utf-8?B?L1ZYNVZ0ZjJYRzVRSlFZbjN0OVZSWGVncGQ4eFlMVm9ZRmNDMmJIZzZBd2RI?=
 =?utf-8?B?bjkrQnNKWG5xd1F2M2dqTUFBQ2hCQkk2TDFEUjJmZUNtZGZsSnd6QT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d407bbf-d9dd-45ae-974b-08df33489835
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 10:04:59.7148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: StB/HU3CQUCEwraJ2sgI2bxH0PLVwjCb06XjKbM+LJQDBKSt596jtG239khev94jWGxAAsAvqngpq9gO3XEz/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11500
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a helper dc_fu_get_dprc() to get DPR channel for FetchUnit.
And, call it from dc_{fl,fw)_bind() to get DPR channels for
FetchLayer and FetchWarp.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v7:
- Collect Maxime's A-b tag.
- Call dc_dprc_get() in dc_fu_get_dprc() to create a device link between
  consumer FetchUnit and supplier DPRC to avoid potential UAF when
  accessing fu->dprc.  (Sashiko AI bot)

v2:
- Collect Frank's R-b tag.
---
 drivers/gpu/drm/imx/dc/dc-fl.c |  7 ++++++-
 drivers/gpu/drm/imx/dc/dc-fu.c | 25 +++++++++++++++++++++++++
 drivers/gpu/drm/imx/dc/dc-fu.h |  5 +++++
 drivers/gpu/drm/imx/dc/dc-fw.c |  7 ++++++-
 4 files changed, 42 insertions(+), 2 deletions(-)

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
index 2e197b3344bd..d9933218069c 100644
--- a/drivers/gpu/drm/imx/dc/dc-fu.c
+++ b/drivers/gpu/drm/imx/dc/dc-fu.c
@@ -8,8 +8,10 @@
 #include <linux/bits.h>
 #include <linux/math.h>
 
+#include "dc-dprc.h"
 #include "dc-fu.h"
 #include "dc-pe.h"
+#include "dc-prg.h"
 
 /* STATICCONTROL */
 #define SHDLDREQSTICKY_MASK		GENMASK(31, 24)
@@ -256,3 +258,26 @@ void dc_fu_common_hw_init(struct dc_fu *fu)
 		dc_fu_set_pixel_blend_mode(fu, i);
 	}
 }
+
+int dc_fu_get_dprc(struct dc_fu *fu)
+{
+	struct dc_dprc *dprc;
+	struct dc_prg *prg;
+
+	prg = dc_prg_lookup_by_phandle(fu->dev, "fsl,prg", 0);
+	if (!prg)
+		return dev_err_probe(fu->dev, -EPROBE_DEFER,
+				     "failed to lookup PRG\n");
+
+	dprc = dc_prg_get_dprc(prg);
+	if (!dprc)
+		return dev_err_probe(fu->dev, -EPROBE_DEFER,
+				     "failed to get DPR channel from PRG\n");
+
+	fu->dprc = dc_dprc_get(fu->dev, dprc);
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

