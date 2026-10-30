Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ABA60A263E
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 09:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ePLikgJT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66F2910E8A9;
	Fri, 30 Oct 2026 09:53:50 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013026.outbound.protection.outlook.com [52.101.72.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94F0E10E8A9
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 09:53:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GoySUTaD1wHrtK2C0FHbZwxO6cQpEmPH163hXbFu5ma1kZ/0nOZCD/N+nry3fXI9enuLorcbNGjiKjILGvmsEyDvLXdoNj7tY9b+mLPfjX7XzFWkieSuCrKweSnIigRlCLw0eARTPp9EkdjKa2MqndchvoHbwGWVyI5xQJQIGoARoS0x7G8Am8ecGUqu07nK/8gjxLcBqf5dZdAqTn64ZcaTNNjvc++uScXFNav21I1Uofh1hqWbsQGCeQHVxXO8tjhwml9gudeGrRGS9wP3BOm5owwpXZzKaJJqcL5BEWRDNvqls+53pRIQvtX6fogJ+evQiXCOw4brqJ4DKMVOxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4PG/pAQBW5b9uHB5XiOckTbMHDJMgHyhQvxNlmBUgk=;
 b=OkJ2h82uFYeoHz7Sd2S5ue4AtHhjYNO9heh7fG1zsnU8z6ji4xQLaGS8jSHjfyIrjpWdjirx8vLexf7OQJ4USNfPv5Ob3OsQGujBmH9l7TKvSona9F5GnaAOSSn1SrmuGLZb+fT8Rex7Q3Ws5jxuD1PPE3RgEA9Cbmw3Hv1BdkHq2DTtz3uMej2D5AJ/XS0rokd3+bf4bDpgq7DYHjEHwu1qnV0pJQppIvMBZUTmDZL3cvdrg8YTSW1aWoOgW1v8ZtSdKupT5G5v7O81+a0H2sL8OXpXtsVK7ehf7CpC6EEtEfq3JLXlnPuk6HzFOElC9V9prELqyi7HPP5QcwwPrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4PG/pAQBW5b9uHB5XiOckTbMHDJMgHyhQvxNlmBUgk=;
 b=ePLikgJT5UTxjIv7lTidXwrtKFcPRv4d0TMg5N1iMCm8nnB4D/Z+enz1vaSyMU72t5aNOm+FOGVcoQtnMKeBX3PBqFu+mdDuF2KYYdQvYbchSfPVrEGJTouWZ3OK9Lju0sAHH/C8TWYYMmWsVg17//14oSSXixbd4NSIHOHoxx/gUdmrNlpnhhlmM4wkDIaA3pnHOTb5/FkSWwr3wZ64sP3JCjJ+BTW9AZUG02YZ4kaOf4PfgodIW1zcmNBDM9a5nNYg2reonSgZcVyg7AbuW7lIW7qmGmJ04pXrx9p/qtjc2YfzLixuR83J+uHfS+xozVRDt27vnJP/Nnxg7KBoBw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by MA9PR04MB839208.eurprd04.prod.outlook.com (2603:10a6:250:103::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 09:53:38 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 09:53:38 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Fri, 30 Oct 2026 17:54:31 +0800
Subject: [PATCH v8 07/15] drm/imx: dc: Add PRG support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-imx8-dc-prefetch-v8-7-c4f81afd4533@nxp.com>
References: <20261030-imx8-dc-prefetch-v8-0-c4f81afd4533@nxp.com>
In-Reply-To: <20261030-imx8-dc-prefetch-v8-0-c4f81afd4533@nxp.com>
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
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|MA9PR04MB839208:EE_
X-MS-Office365-Filtering-Correlation-Id: f3d4fdc6-e1a0-4fba-ec41-08df366baba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|376014|7416014|366016|1800799024|10067099003|18002099003|22082099003|921020|56012099006|11063799006|261028144727099003|261026140227099003|261026121527099003|261022105027099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: StN9Cu969VirzUhgS+OXxkytMaB/xjpc5vtyRvn3/NJSvUBdVL/L42r37wzXGAOJzK2SeiLUDhfhztAT5YVlkzI7nlaoIdnLfKBhaKDKJ5+Wh/UDHJmyzrJpJ6+YRX7IBCRCrPc/nQgGadSjmABbnv8m/lJ8Ywke4XSPYNydM3fg2b/L/tkzTqPqy3i9lwC/p5XTIr+O9f9n3B3FTYb3Z32cUtFa1lj+3dM3e5BQcG5g8HQAnSbYm6WxoO6xGo9JScxh5sPpMlY4RomEUTli2pRJr2AsupQ/90CZTOvBtRnHHUP5dHYQRhbdBdNfcdL4BASrP8Mw0hApiPcBKr9a54mcTck4FfzMVC30khhBdmizo4pY/pTTry3sF5SZ+4kYoVciHbh2wo6OChi3beM2VdCpMCBSkVxN4pz4Ow4QUN0x3xCQK1yMHVWIxocfuPA98fzjZCMnbgVK5gyzTFsWVUrGiE1dlmqh18Kz0DgGtSbKCyqcj26s09Av1wsPxy3pBIyydU+P+XSK15zKBxQtCtT3WPTX+MkVowKHGAezcQ5JAaoOXT4wrN6wIgABazOv1b/BxRSM7me0uMtTyGMnkF4YFTrsYwhtu+1SbyEeTq4tY6vIHT1cyaT3Gcxo6B2Q4sfSRvxdB4vO4AYOsIdrezeIS2gXjaRtdUwjgIoYznVfzWqDum50Ct6fbjTIcUR3zy8QdZEATv6AG3BCFQwOtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(921020)(56012099006)(11063799006)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QURveVI5VkhwQWJ1b0dieVlTRkFxam8vazJiZzZWK2N6Y1JubDFDWGxXN0R1?=
 =?utf-8?B?UUlvemsxRjYxMktnV1dRd1FOYUJ2OFVEeS8rY2szWVgxcjJRR3lwZE05c0Z6?=
 =?utf-8?B?N2l6bWthM0JBQ1BEODZ5ZzlCbnNWa0hZeTV4TzUreWpuRDZ6RlZ1VUx4RFBu?=
 =?utf-8?B?TVZ3cUtvSjVSZGE2bGYyYWxPRDNzZEt1SjFNbWNGV3JwaVVHUmRkQmV4QWdj?=
 =?utf-8?B?aFozQjR1QjlqaitkWGRWNGxpdmJ2TW1MQ0NvV21KTWZRVVM1dlJhcTU2c1Zt?=
 =?utf-8?B?Z041NFdsSng3eVU5c0NBOE56TVI4endScCtUd2Jna2hrTi9SS2d2eWFyZGc2?=
 =?utf-8?B?cXJJcTF5bXJ2SlM4d0MzdUtRK094TEZBMVRqQ0dteG5LdXYwT3JZYzFCemVi?=
 =?utf-8?B?dkpuRVdWTjVwQmllcTArNUR6alM3R2FQVmFtQ284MEFoYktpaWxaWFJyOWYv?=
 =?utf-8?B?Z2xOMExibE1zdGVSOHNsT0dOMzYxTlN5QTRrcWpUUFlvNWEwTGloSHZiSHVL?=
 =?utf-8?B?cG1ZbnBpeE9oY3lQdUUzZWZzUDhzNHZzeHAwVHY5Rjc3ODc3Y0hLNEtlcGt6?=
 =?utf-8?B?REI5ZVk0dU4xeUY0elkvemZXT1BRbFNhcDJKZmx3cXQyTTk4UXdZcGNaYnJX?=
 =?utf-8?B?UEE4NmFvTEsveTA5SXkvb0Jwa0Z5dC9EUmZHZUczY2FkZTdDVDFOK2hXeG80?=
 =?utf-8?B?MkRyT00wWm54aWRDVElkUWtYcEYwRy9iM0JKMkRXZHRjYkJOZ0Y5QmJqYWM5?=
 =?utf-8?B?MWM2cXlaSWFHVzVWYjZsTUh0U0gyUXRMbGpyL3RzUEc0dVVwcWdRS3V0TjdQ?=
 =?utf-8?B?cUtmOEkwMGRSOHI5SDVnWlJDMFhtb0FoT1dEb2dNclFxNUhRVjFCMzV4d0NT?=
 =?utf-8?B?VmNCRWI5b1k1cTNXQzNscjR1K0V6bC85UmE5NXF3TFc4OWpUVHpSK21rU2VC?=
 =?utf-8?B?Y3AvRFd5bWorbjJvQ0lnR01heHBPYVpPWXNIempFSk51d2x2RXdkNnR0REZG?=
 =?utf-8?B?dFc0ZkdrWmc5dVRKRjRwUUlybU5VZHl6YUt6NHFqWU5KUkhWMmNOYm45Y25K?=
 =?utf-8?B?Rzltb3loQjkxS0xwOUpVcGlZazUxQ0xpdFo5L1ZmNFhSVFVoV0N5ZDhiZWVu?=
 =?utf-8?B?MjFtb1ExU09NZ3IxWDEwMmVCSzdpeUNYY1dhYnlwbHpzQis5cFZEbzNPdk12?=
 =?utf-8?B?Ym9GcCtWMENQTkN3NEpWNm9qc25TQzkra056SkI1aTNNaUovVXVaajE1bjVV?=
 =?utf-8?B?UjY1b2pneGFCRnNpQzd4Z1dPY2FRSU45aFZmYUl6U25hdndlV0RISElnc0Z0?=
 =?utf-8?B?R0haazZJUUREQlM2M3FqaDM0QmlLOFlPcWROVy9icE80bGVCNXBUYURzR3Rk?=
 =?utf-8?B?STdnNFM4MFdGQkRRM1lZZFFWUlNXYW0vdUU2RnBxMVZZZGt4RUZyNjVhcExZ?=
 =?utf-8?B?UUQwckZIRFB5QldVZTdiaGVXOEpnTjZXVWNsZmV4WGxJc1JuMmdCTW1XR1dn?=
 =?utf-8?B?T29LbFJ5c3kwV0ZxVDFna2V6ZUJRYlUyc0h3WHhiTk1ONU5ESm43aURMbkhW?=
 =?utf-8?B?bW13WHhEN3FSRy9MaHRadjJBSzM1eHQ2dTMxQWsyN3Z1eFdwZWdwUGc0eXdF?=
 =?utf-8?B?bmxxam9CNlBRWHVQN1V3eTlVSTZzdE9rYXpPdlo2NjJqbW94YTlMVCtxN2xO?=
 =?utf-8?B?SW43MTZxdHpNaytsdWZHNmxrVU5nRDAzSGpEeHpOaWgrUTdPK0o3VWZYOGxl?=
 =?utf-8?B?K3pvbEpQTU9vc3RhNFhCdXBkOHRZSk8wdVZ6YXRuSHNPQTVKblAzRCtsMVZ6?=
 =?utf-8?B?ZEkxNlBiNy9xWkM5TnF6RzZGZ1VEVzhBQjl0QVJoYWJMWVFvZUdqLzF0NWtl?=
 =?utf-8?B?UGlhemhlTDdtY1ZRdncwSkZrSm40bEJNZHVoeEY0SzNGejI5VjJlbkt6YXA5?=
 =?utf-8?B?dk5ueUZ2c1FaMTBSQUwwQTRsenZZOGQvek1pRVFQb3NWR1pBRDBiaURkbmhr?=
 =?utf-8?B?WXlhS2VFcHhvL2ZjaE9sLzlBT0U5MnI3NENEb0g1UndwTGRaNHRmZnQ1cmN1?=
 =?utf-8?B?OEVscEc3UzJNQ2tLRUJ2SWZHcXhUS1RFWlpQSU45YThpNTREK3BRV1h6ZDEx?=
 =?utf-8?B?Z0kvakRxVTM1RElMM3BwTWg3d3pYU1RRREdzTFBDUHNVMm1IUURUMUlCTW43?=
 =?utf-8?B?WXNRckZ2clBBcFJ6akdHQS9TM1hMSHZIbkpOVEFyK2tucGdpYXVWbVRHNzk4?=
 =?utf-8?B?TC83bTFDTWJrakxiSEwvZmY3ZWtOb3o4YWRlK3pFdFhLbWx5ZHQ1WGxwS2pI?=
 =?utf-8?B?MHF2SytzY2ZKY0dQYmhkeTJ0dk5FTS8yZkdVTGd6QTNhVldQeHNaZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d4fdc6-e1a0-4fba-ec41-08df366baba6
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 09:53:38.0372 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n1al5CzP7sTVtQrzEXUDKKZPTZLCp5KrWvvFjkdebdLV3dXAtSdgjsch2X4TZDIVQ7+RWV2yR98/BD0cxIYZdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR04MB839208
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Display Prefetch Resolve Gasket(PRG) is a part of a FetchUnit's
prefetch engine.  It sits between a Display Prefetch Resolve
Channel(DPRC) and a FetchUnit.  Add a platform driver to support
the PRG.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v8:
- Fix dc_prg_burst_size_fixup() to avoid overflowing signed integer 1.
  (Sashiko AI bot)
- Check device_link_add()'s return value and bail out if needed.
  (Sashiko AI bot)
- Drop unused header files.  (Laurentiu)

v7:
- Collect Maxime's A-b tag.
- Return 128B burst size from dc_prg_burst_size_fixup() when baddr == 0.
  This avoids undefined behavior of __ffs(0).  (Sashiko AI bot)
- Initialize and declare prg_node at the same time.  (Sashiko AI bot)
- Add device link between PRG's consumer and PRG.  (Sashiko AI bot)

v6:
- Include "dc-drv.h" to avoid build warning with C=1.
- Fix PRG BYPASS programming.

v4:
- Sort bits and bitfields in descending order for register PRG_CTRL.

v2:
- Manage clocks with bulk interfaces.  (Frank)
- Collect Frank's R-b tag.
---
 drivers/gpu/drm/imx/dc/Makefile |   2 +-
 drivers/gpu/drm/imx/dc/dc-drv.c |   1 +
 drivers/gpu/drm/imx/dc/dc-drv.h |   1 +
 drivers/gpu/drm/imx/dc/dc-prg.c | 318 ++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/imx/dc/dc-prg.h |  35 +++++
 5 files changed, 356 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/dc/Makefile b/drivers/gpu/drm/imx/dc/Makefile
index b9d33c074984..e3a06ee3ce1a 100644
--- a/drivers/gpu/drm/imx/dc/Makefile
+++ b/drivers/gpu/drm/imx/dc/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 imx8-dc-drm-objs := dc-cf.o dc-crtc.o dc-de.o dc-drv.o dc-ed.o dc-fg.o dc-fl.o \
-		    dc-fu.o dc-fw.o dc-ic.o dc-kms.o dc-lb.o dc-pe.o \
+		    dc-fu.o dc-fw.o dc-ic.o dc-kms.o dc-lb.o dc-pe.o dc-prg.o  \
 		    dc-plane.o dc-tc.o
 
 obj-$(CONFIG_DRM_IMX8_DC) += imx8-dc-drm.o
diff --git a/drivers/gpu/drm/imx/dc/dc-drv.c b/drivers/gpu/drm/imx/dc/dc-drv.c
index 393f7e07df7b..8e1e495f1992 100644
--- a/drivers/gpu/drm/imx/dc/dc-drv.c
+++ b/drivers/gpu/drm/imx/dc/dc-drv.c
@@ -356,6 +356,7 @@ static struct platform_driver * const dc_drivers[] = {
 	&dc_ic_driver,
 	&dc_lb_driver,
 	&dc_pe_driver,
+	&dc_prg_driver,
 	&dc_tc_driver,
 	&dc_driver,
 };
diff --git a/drivers/gpu/drm/imx/dc/dc-drv.h b/drivers/gpu/drm/imx/dc/dc-drv.h
index 1f0af7af5749..7873cd421942 100644
--- a/drivers/gpu/drm/imx/dc/dc-drv.h
+++ b/drivers/gpu/drm/imx/dc/dc-drv.h
@@ -81,6 +81,7 @@ extern struct platform_driver dc_fw_driver;
 extern struct platform_driver dc_ic_driver;
 extern struct platform_driver dc_lb_driver;
 extern struct platform_driver dc_pe_driver;
+extern struct platform_driver dc_prg_driver;
 extern struct platform_driver dc_tc_driver;
 
 static inline int dc_subdev_get_id(const struct dc_subdev_info *info,
diff --git a/drivers/gpu/drm/imx/dc/dc-prg.c b/drivers/gpu/drm/imx/dc/dc-prg.c
new file mode 100644
index 000000000000..46108f7e09af
--- /dev/null
+++ b/drivers/gpu/drm/imx/dc/dc-prg.c
@@ -0,0 +1,318 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+
+#include "dc-drv.h"
+#include "dc-prg.h"
+
+#define SET			0x4
+#define CLR			0x8
+#define TOG			0xc
+
+#define PRG_CTRL		0x00
+#define  SHADOW_EN		BIT(31)
+#define  SOFTRST		BIT(30)
+#define  DES_DATA_TYPE_MASK	GENMASK(17, 16)
+#define  DES_DATA_TYPE_32BPP	FIELD_PREP(DES_DATA_TYPE_MASK, 0)
+#define  DES_DATA_TYPE_24BPP	FIELD_PREP(DES_DATA_TYPE_MASK, 1)
+#define  DES_DATA_TYPE_16BPP	FIELD_PREP(DES_DATA_TYPE_MASK, 2)
+#define  DES_DATA_TYPE_8BPP	FIELD_PREP(DES_DATA_TYPE_MASK, 3)
+#define  SHADOW_LOAD_MODE	BIT(5)
+#define  HANDSHAKE_MODE_4LINES	0
+#define  SC_DATA_TYPE_8BIT	0
+#define  BYPASS			BIT(0)
+
+#define PRG_STATUS		0x10
+
+#define PRG_REG_UPDATE		0x20
+#define  REG_UPDATE		BIT(0)
+
+#define PRG_STRIDE		0x30
+#define  STRIDE(n)		FIELD_PREP(GENMASK(15, 0), (n) - 1)
+
+#define PRG_HEIGHT		0x40
+#define  HEIGHT(n)		FIELD_PREP(GENMASK(15, 0), (n) - 1)
+
+#define PRG_BADDR		0x50
+#define PRG_OFFSET		0x60
+
+#define PRG_WIDTH		0x70
+#define  WIDTH(n)		FIELD_PREP(GENMASK(15, 0), (n) - 1)
+
+#define DPU_PRG_MAX_STRIDE	0x10000
+
+struct dc_prg {
+	struct device *dev;
+	struct regmap *reg;
+	struct list_head list;
+	struct clk_bulk_data *clks;
+	int num_clks;
+};
+
+static DEFINE_MUTEX(dc_prg_list_mutex);
+static LIST_HEAD(dc_prg_list);
+
+static const struct regmap_config dc_prg_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.fast_io = true,
+	.max_register = PRG_WIDTH + TOG,
+};
+
+static void dc_prg_reset(struct dc_prg *prg)
+{
+	regmap_write(prg->reg, PRG_CTRL + SET, SOFTRST);
+	fsleep(10);
+	regmap_write(prg->reg, PRG_CTRL + CLR, SOFTRST);
+	fsleep(10);
+}
+
+void dc_prg_enable(struct dc_prg *prg)
+{
+	regmap_write(prg->reg, PRG_CTRL + CLR, BYPASS);
+}
+
+void dc_prg_disable(struct dc_prg *prg)
+{
+	regmap_write(prg->reg, PRG_CTRL, BYPASS);
+
+	pm_runtime_put(prg->dev);
+}
+
+void dc_prg_disable_at_boot(struct dc_prg *prg)
+{
+	regmap_write(prg->reg, PRG_CTRL, BYPASS);
+
+	clk_bulk_disable_unprepare(prg->num_clks, prg->clks);
+}
+
+static unsigned int dc_prg_burst_size_fixup(dma_addr_t baddr)
+{
+	unsigned int burst_size;
+
+	if (baddr == 0)
+		return 128U;
+
+	burst_size = 1U << __ffs(baddr);
+	burst_size = round_up(burst_size, 8);
+	burst_size = min(burst_size, 128U);
+
+	return burst_size;
+}
+
+static unsigned int
+dc_prg_stride_fixup(unsigned int stride, unsigned int burst_size)
+{
+	return round_up(stride, burst_size);
+}
+
+void dc_prg_configure(struct dc_prg *prg,
+		      unsigned int width, unsigned int height,
+		      unsigned int stride, unsigned int bits_per_pixel,
+		      dma_addr_t baddr, bool start)
+{
+	struct device *dev = prg->dev;
+	unsigned int burst_size;
+	u32 val;
+	int ret;
+
+	if (start) {
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret < 0) {
+			dev_err(dev, "failed to get RPM: %d\n", ret);
+			return;
+		}
+	}
+
+	burst_size = dc_prg_burst_size_fixup(baddr);
+
+	stride = dc_prg_stride_fixup(stride, burst_size);
+
+	regmap_write(prg->reg, PRG_STRIDE, STRIDE(stride));
+	regmap_write(prg->reg, PRG_WIDTH, WIDTH(width));
+	regmap_write(prg->reg, PRG_HEIGHT, HEIGHT(height));
+	regmap_write(prg->reg, PRG_OFFSET, 0);
+	regmap_write(prg->reg, PRG_BADDR, baddr);
+
+	val = SHADOW_LOAD_MODE | SC_DATA_TYPE_8BIT | HANDSHAKE_MODE_4LINES;
+
+	switch (bits_per_pixel) {
+	case 32:
+		val |= DES_DATA_TYPE_32BPP;
+		break;
+	case 24:
+		val |= DES_DATA_TYPE_24BPP;
+		break;
+	case 16:
+		val |= DES_DATA_TYPE_16BPP;
+		break;
+	case 8:
+		val |= DES_DATA_TYPE_8BPP;
+		break;
+	}
+
+	/* no shadow for the first frame */
+	val |= start ? BYPASS : SHADOW_EN;
+
+	regmap_write(prg->reg, PRG_CTRL, val);
+}
+
+void dc_prg_reg_update(struct dc_prg *prg)
+{
+	regmap_write(prg->reg, PRG_REG_UPDATE, REG_UPDATE);
+}
+
+void dc_prg_shadow_enable(struct dc_prg *prg)
+{
+	regmap_write(prg->reg, PRG_CTRL + SET, SHADOW_EN);
+}
+
+bool dc_prg_stride_supported(struct dc_prg *prg,
+			     unsigned int stride, dma_addr_t baddr)
+{
+	unsigned int burst_size;
+
+	burst_size = dc_prg_burst_size_fixup(baddr);
+
+	stride = dc_prg_stride_fixup(stride, burst_size);
+
+	if (stride > DPU_PRG_MAX_STRIDE)
+		return false;
+
+	return true;
+}
+
+struct dc_prg *
+dc_prg_lookup_by_phandle(struct device *dev, const char *name, int index)
+{
+	struct device_node *prg_node __free(device_node) =
+				of_parse_phandle(dev->of_node, name, index);
+	struct device_link *link;
+	struct dc_prg *prg;
+
+	if (!prg_node)
+		return NULL;
+
+	guard(mutex)(&dc_prg_list_mutex);
+	list_for_each_entry(prg, &dc_prg_list, list) {
+		if (prg_node == prg->dev->of_node) {
+			link = device_link_add(dev, prg->dev,
+					       DL_FLAG_AUTOREMOVE_CONSUMER);
+			if (!link) {
+				dev_err(dev, "failed to add device link to PRG\n");
+				return NULL;
+			}
+
+			return prg;
+		}
+	}
+
+	return NULL;
+}
+
+static int dc_prg_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	void __iomem *base;
+	struct dc_prg *prg;
+	int ret;
+
+	prg = devm_kzalloc(dev, sizeof(*prg), GFP_KERNEL);
+	if (!prg)
+		return -ENOMEM;
+
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	prg->reg = devm_regmap_init_mmio(dev, base, &dc_prg_regmap_config);
+	if (IS_ERR(prg->reg))
+		return PTR_ERR(prg->reg);
+
+	prg->num_clks = devm_clk_bulk_get_all(dev, &prg->clks);
+	if (prg->num_clks < 0)
+		return dev_err_probe(dev, prg->num_clks, "failed to get clocks\n");
+
+	dev_set_drvdata(dev, prg);
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable PM runtime\n");
+
+	prg->dev = dev;
+
+	guard(mutex)(&dc_prg_list_mutex);
+	list_add(&prg->list, &dc_prg_list);
+
+	return 0;
+}
+
+static void dc_prg_remove(struct platform_device *pdev)
+{
+	struct dc_prg *prg = dev_get_drvdata(&pdev->dev);
+
+	guard(mutex)(&dc_prg_list_mutex);
+	list_del(&prg->list);
+}
+
+static int dc_prg_runtime_suspend(struct device *dev)
+{
+	struct dc_prg *prg = dev_get_drvdata(dev);
+
+	clk_bulk_disable_unprepare(prg->num_clks, prg->clks);
+
+	return 0;
+}
+
+static int dc_prg_runtime_resume(struct device *dev)
+{
+	struct dc_prg *prg = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_bulk_prepare_enable(prg->num_clks, prg->clks);
+	if (ret) {
+		dev_err(dev, "failed to enable clocks: %d\n", ret);
+		return ret;
+	}
+
+	dc_prg_reset(prg);
+
+	return 0;
+}
+
+static const struct dev_pm_ops dc_prg_pm_ops = {
+	RUNTIME_PM_OPS(dc_prg_runtime_suspend, dc_prg_runtime_resume, NULL)
+};
+
+static const struct of_device_id dc_prg_dt_ids[] = {
+	{ .compatible = "fsl,imx8qxp-prg", },
+	{ /* sentinel */ }
+};
+
+struct platform_driver dc_prg_driver = {
+	.probe = dc_prg_probe,
+	.remove = dc_prg_remove,
+	.driver = {
+		.name = "imx8-dc-prg",
+		.suppress_bind_attrs = true,
+		.of_match_table = dc_prg_dt_ids,
+		.pm = pm_ptr(&dc_prg_pm_ops),
+	},
+};
diff --git a/drivers/gpu/drm/imx/dc/dc-prg.h b/drivers/gpu/drm/imx/dc/dc-prg.h
new file mode 100644
index 000000000000..6fd9b050bfa1
--- /dev/null
+++ b/drivers/gpu/drm/imx/dc/dc-prg.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2025 NXP
+ */
+
+#ifndef __DC_PRG_H__
+#define __DC_PRG_H__
+
+#include <linux/device.h>
+#include <linux/types.h>
+
+struct dc_prg;
+
+void dc_prg_enable(struct dc_prg *prg);
+
+void dc_prg_disable(struct dc_prg *prg);
+
+void dc_prg_disable_at_boot(struct dc_prg *prg);
+
+void dc_prg_configure(struct dc_prg *prg,
+		      unsigned int width, unsigned int height,
+		      unsigned int stride, unsigned int bits_per_pixel,
+		      dma_addr_t baddr, bool start);
+
+void dc_prg_reg_update(struct dc_prg *prg);
+
+void dc_prg_shadow_enable(struct dc_prg *prg);
+
+bool dc_prg_stride_supported(struct dc_prg *prg,
+			     unsigned int stride, dma_addr_t baddr);
+
+struct dc_prg *
+dc_prg_lookup_by_phandle(struct device *dev, const char *name, int index);
+
+#endif

-- 
2.43.0

