Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD58606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 06:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=EAT5tJ9g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A37CC10F39B;
	Tue,  3 Nov 2026 06:22:05 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011006.outbound.protection.outlook.com [52.101.70.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B946010F393
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 06:21:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QefmMH7kfDDlsnP/dNrPEaZkQXPA2GgmLHeaJ0h5c9xNyeL8+bry4yZpxdZ4+SROmLZLFVeO0hLF7kb6LJCx9Yt/fu2Ij89PE0WWrtYwWtsr0lximqICZ9XCVWkdY7b3UGTA0D4kbctgYrSmkBcuTKu5rA23MUhaP/COct/NV0BaNq2PjTCWEEZBjfic2Vut6cGxU6VhBYMyuVF4qv2J6C9S2BUs9xOV882AYo3OKcBLrF5EcEfpMxU9GM4uuhHPR/g6InPOuYswYmcvGN+jCAbKsHUYq29QX9Kq0Qz9Dam9o4IThVZxABSAdGGhLQ8L67sveTHb6fyGC4FrOnxxHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+gPCWzIAdsVPYkrizOXOeMwNsWbBjc3l8QYVxshcrI=;
 b=TjlY3ZZvhvkidRm3yuB/C4LKYB1sCJ+xegUnHDGxlkf4mWqpsUAiF2GkPKviLRm9lXaDWq/PPTHBe89uB7BpfkDAPRsdJlc8qWOAX7vGkYhdByD8KZF4QfoN6tdITTH1lNH+sGaxxyHHEoyu8t4XtKcApTOAdkaYVOePXnTe+oEZOTiQ9wHP7tD3kgr6ibhtRQUPNBAWmMSk6DHeN3hANCnsGL5/sggDlsf9ErQR9zWH7iMX1drcMOHGhjRKRaTvE69wx5t/i0pB2nK3Q8t/l2HoK2HwGo66eWzccHUrrvJzmvDxKVi0PUtlb7pCC2379/CdEdqdaJ1/gLt2s3uyyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+gPCWzIAdsVPYkrizOXOeMwNsWbBjc3l8QYVxshcrI=;
 b=EAT5tJ9gOh9PvWKtOZ5OAdzdd+3zMvNb6hF2wIgACKeClvD9KSelV0MPz61KuH3TbsTRHLke+FrA735I0sFvzYJ1sOmWi/dEvzrXOx7vDdEYXCRsQIIfAgHVnMQS8oEjZ+QCMofhWj93wv7b/3+iQIgKVycMOBJZCzM8eheFdRtZLv9ugGPJ0LCgjTFu0/0El8+AT0j17IIlFW81LE3bG8B8ZbIKuaBPTgvNeSWN77RQP1JCrR6OUs5bhnYYAaavKs99h3eWgpfUMTbmafFhwuK9jG+ttVWNWlH+JK8Y23wsclivjOJqBkfsRVeGonNuTm82u4AbbESi3tKqJyIfCA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by PR3PR04MB7353.eurprd04.prod.outlook.com (2603:10a6:102:82::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 06:21:56 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 06:21:56 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Tue, 03 Nov 2026 14:22:11 +0800
Subject: [PATCH v9 15/16] drm/imx: dc-fu: Get DPR channel
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-imx8-dc-prefetch-v9-15-3b985e7636e2@nxp.com>
References: <20261103-imx8-dc-prefetch-v9-0-3b985e7636e2@nxp.com>
In-Reply-To: <20261103-imx8-dc-prefetch-v9-0-3b985e7636e2@nxp.com>
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
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|PR3PR04MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 683d007a-de10-4db8-2943-08df3972c286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|23010399003|7416014|376014|1800799024|10067099003|22082099003|261102123227099003|18002099003|921020|56012099006|11063799006|261022105027099003|261021121427099003|261021123027099003|261009223027099003|261028144727099003|261026140227099003|260925022911599003|260925021911599003|260925021311599003;
X-Microsoft-Antispam-Message-Info: nP4TX+upHI7F/OAEjqIn33/gCHLfEfoam6BAArYkOkkV5YhzMOPo8BXChbZBRBXzZ6ARVKfkPdwFUOJdq7bKg88qzqZDIiJPOTPDvBI07zM9Qrh/ypoQjfE7oJbIN5ZYYO7xwoGELEeI3+40/ckyYuiGEUpRNTOUhZeWAV3h3rdKdNrIeQJRmSpCjA/OYNF2oSBPdXJswUi8q4Vw5/T+/j8oJqHMQRoFEXnBG7dDalrgSb9Ro4gak5zpW7xil6GznoJ6k6dPWF4bHHP1iThTF1Umn+3iBUmvshsrsZ+czsCC3e1lK7zS5V1rkyPbbFjXfZcKNF/EYURuPFL/G1+5OetWaWDZluYTFSmc4J7eyiF/IMjOIZOKTBPUYiETOq2aijQMTyDNS91zEFdKDO5oKs8aOUsCobzziqRxxqVTU+oTTgu8wyHzOU5GMcGgQIxDCRcUhLja7B4DpZY0Bjppca32sfgsUwF9Bwp72EYfwT4UXgy641mf9yWyha+Erb5OCwSrc9CsugT7jsLH29bV/9TKm7WVhzdgLekLfQkb7fq26kqxQcfOyKSjmrhlXjzWwMDo171hVhlDtgawOLebxOSSvKW3Q+ABKbUJXeQNlte6rFhxMXFCZAfnE8H5xZZMRLvmicBG+cV+/rAjrx8NIkr6KJS083SS+ttnPjhchD+f6VVgGGtO7x2qpIc9Haa7LHKZZMtMXaJ27YlocDIASA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(23010399003)(7416014)(376014)(1800799024)(10067099003)(22082099003)(261102123227099003)(18002099003)(921020)(56012099006)(11063799006)(261022105027099003)(261021121427099003)(261021123027099003)(261009223027099003)(261028144727099003)(261026140227099003)(260925022911599003)(260925021911599003)(260925021311599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGFGaWlDWnJLOVZWS1ZjQVcwSUdwZnIrSUtna1pkUkUrdXFaUVVBb1dqMnJW?=
 =?utf-8?B?bklzRUQ0SUJpQkRrQ3R1Zm5VWWlVSVlsbjIwWDVLRS84MndSQ2tPS2FhUVdP?=
 =?utf-8?B?OHBhU0pTUmFpVDZBbGRCd2dsdmhQTTRpUktBS3ZaMlRxZWNrd01seXFkdjhw?=
 =?utf-8?B?V1RoNCsrTEhEQ0JIYm5CZHF1UllJMGRzYlZ1cGMrWEpYa21CRDV3dGxZWjFy?=
 =?utf-8?B?Zm5ZQzEvM2N2VXYwSDF3cmlOeEVmbHcvOEhSdkpkVnBBdXdDUUF4TEVzYWtU?=
 =?utf-8?B?M3Jhc2ZrSXpOcENoUEkybnhuSlpFdVl6VkxiaWxHaWQzNnFpSEZkUkJ6TzJu?=
 =?utf-8?B?blFoaUNOVy9XYUcyRWNnYlJZNzJhUGR1ODN5QW13OUt2RXEvVFVWU24ycVk1?=
 =?utf-8?B?c1cvdmowR21CcjRUcERDUkFPYVM3aXVJTTJjcTJjdVBUSzNxWGlSWlpVaElv?=
 =?utf-8?B?OEwveFFPYTlVUU5NR3JIYmpBbkJjYW9maHhaZU45eDlWcU9Xb0g0Qi95Y1Jx?=
 =?utf-8?B?Z0hhK1pmMEg1SVJzeU1MRnZGWTlJb1FYQlBtVVNmNVM5RDBQU3hCK0pCUGl2?=
 =?utf-8?B?TnFhY2c5U3NPNmVCcVAwSnp3cWl2Q1FhRE9RdmQwb3RVc1Fzam1ublhzdzlt?=
 =?utf-8?B?d1Y1cjJDWDZMNlpCS3BvdnRiSlNNaXJ2Rk85ZDJPQlBLcmNIQ041OVFoWG9G?=
 =?utf-8?B?aDBVRHp4MkdtdC9RSlM2UVRNUTRTYVJIbkd4SDBvbjlEbEpELzdkK1JtSk1x?=
 =?utf-8?B?aWxOWjJ3VWR3V2hqL2JSc282QVc2NUR6OHJ0S2xCcE1MV0lrM0dEcmtyb21H?=
 =?utf-8?B?aStDZENmK2tpUVlwcFBTRXYzREVtYVlNRklXWFByWGx2bk9TWmpPSkJ0aVRo?=
 =?utf-8?B?RFJyZXZYbW5mNzYzMWZvUy90cXB2bUw1UHNZNUExbzBQY0ZscFgyZnh2Uktz?=
 =?utf-8?B?VUYyb2lpb09zajJ2V2o0S2pGbXYrZXNLRCtwaEs5VUVzbFdvYUVWZTlhZkw5?=
 =?utf-8?B?US9SS2NqUGEwVnh5Rm5tOFd1SC9pVDRzc1kvdEZSbVhtL0dZdnlFaTljdXYx?=
 =?utf-8?B?a09SQmF4TE02d0cwRDFVTCtTM29FQlg0QldaN09KbDd4WGVwUWhMMFlqWEhC?=
 =?utf-8?B?TFNBdHVzeEtwSTkwZnFYbTQ5S29CVnpFYkJ5QWR2Nk1keTNEODFlZ0lFSUQv?=
 =?utf-8?B?N2lRQWp0WHdTb2t5c3BjVkVNdWlxS3Y3VDNLcVhjS1RpazkyUlJhdDlucUVr?=
 =?utf-8?B?NGFzT3QveVdNVUtUMXV3WW1SNmRzQUZHYXA4WHd0TTJma3B2Y3dzYmVlUGk2?=
 =?utf-8?B?VExhUVFua2oxZGNXdGJuZkxuNG9GQ1Z5VEFWcktIQWRjWDJlNXBPM1RVRGhk?=
 =?utf-8?B?cDZoWis0QXFsZWNad1VaNC9TUWJLWWJqdVE2dlNRblk1Q0JPMXJweVBtd3RM?=
 =?utf-8?B?OXFKT0ZCdysyT0lBMmRFZVMwS1NNYkY0aEFMNmlMNGRCZzhtZ0tUWmRxdFhU?=
 =?utf-8?B?eWpleDAzSm4yYXdOWnR6NnZmcWpCUmdtOHk2ZnRJVVh5eURWUW9YMmREVWRt?=
 =?utf-8?B?Ym5pMnFyamJ3ZXJ3bWl2KzFQNHk4bVVMcUluZDNpNk51cXNBNjNkdlNvaHVG?=
 =?utf-8?B?TW1RRTlWMVc0bDlMbTRLcGQ5RFN6ajQ0cDZHbGYrRk9oZUdDY1ZTVklSVGZi?=
 =?utf-8?B?L3hkbnd6MzY5ZytNTWl5cy9rZTJuWForVlFEYi9FaWx1YnZ4YkE1ZFlDQk5m?=
 =?utf-8?B?UnRCdktnczZOcEdkaFEzeThKUW5JMW9oRUUrZTdMdFdJbnJpOHVoMlZLZm1Z?=
 =?utf-8?B?K2VDa3I4enFVUFl5bTR6M1BQNFFQL3BnUFlJU3Nxaldydkw5UWNqcC9KdldC?=
 =?utf-8?B?YXdIRjNyZG04ZW41MGErMTNYeWJzTUlYMnR1emcxZ3pFa2JMbk1MRU9NVlI4?=
 =?utf-8?B?QTE5WDlmakRDcEFqbXlCemVhTzhZY3FEYXhvSjhSdjhCa0xqeVo3T3JiVC85?=
 =?utf-8?B?Wk1FTXdKR0ZDcHg1VFYvUzdZYWhoOGJqdEdVMlR3K3lvcm95UkFJQUhYTUky?=
 =?utf-8?B?MHNJNGtuN0VPVjlSYkNNcjVDV0VvdWFkT1cxRUZYck44TnplNHdjNVlSdFZL?=
 =?utf-8?B?NlNtdHJpUXpBR2l0blpzOCtCZjBRdllNMEVxTXJjTjNXMFFzUTk2K0VHVU1a?=
 =?utf-8?B?NkRaRmpWeFJ3STVGOG1uKzkzd0l4MVpKN1NaU25YaUJvRElZWlgzL2hmc25Q?=
 =?utf-8?B?clZwdDZ5dGJiOG5QcUNnVzJXTWdqVXlMeElCbnVpVlFrU0Vkend2WWRIRndk?=
 =?utf-8?B?SkhpbHBFaW9WKzNHS2lLcE9IaUk4V2N6ZVFIQ21aK01KKzdKb3Zrdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 683d007a-de10-4db8-2943-08df3972c286
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 06:21:56.3037 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BkhIfHP3oCATyHUh8+6K0VV8d14DXEg1DEy/g6SSrBrkSh1ccc+bL4+VpFcwKJ9C1Xv08n4b1uKZqiPi/zV2IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7353
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

