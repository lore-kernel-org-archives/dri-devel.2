Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A43606D80C
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 06:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=AhFz8blE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FDBF10F391;
	Tue,  3 Nov 2026 06:21:27 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013064.outbound.protection.outlook.com [40.107.159.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1E6710F38A
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 06:21:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/1o+51BFlGGCBNBFgaYzoyOa5hRWJZajfTzz1m1u7qmRWz830YWWtbWbmWQE/aVTTgolmMOEpcsV963JT5TyPKPugquyY+VSeENSIQnJ8wV+BOxlL/btqeHVpwvFaRQU4rQvQiz9VCKqqNYIzFgbyyTbM5s78alwxPYVW1Q9m9XPEyF8C/20CfxU445uQZx75RFhz2keVRwh2cn5VPYyqBkjXx6LtAaYXKU4nc80BMn6/jiwAwwSfu7k2uC+TSj/5wa4bKx5Wg3fP/tOAxGPOwF7swYC60cXBoLgm9sAyJ38ycEA2FRIazTbN7mLkDMPYX2AGLNwbFdEGtHYBOlhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adOi/CUoW7YkCLQAYINAsTfUf18TE7Gu0SlaUe7VGP0=;
 b=PWVhnCu9JJ8sHwjWI16ufbbPwRhiOHOBu8zjFoMPtIepMf78dmiNVSnDuXCWrjQykOYCxHBcItsPA+r6CVJzfOFLrThgbMZP5Ux4tm8hfJMNlqorwG10ZtDskkfw/M3Uj/A4NCxbbEt6p/7BRpYaL4ajoGIGdMxTZhwaJZ+iek8tFXrYmdPbIwSXqpFQqAbwQLjJIZ+9oUm14Y1iJBy8AN75BCRo23WJSdUQ/CvypKRuP5cWSPep11WIwfWxWtIbw/k4DcsMzmZZRIhd/7NBwH7S8amE2TTGd8kaaOQZXhuDOb5tm0SbF2avKBh8ZCF1FzelK8Vyi9gDEngQcfYScw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adOi/CUoW7YkCLQAYINAsTfUf18TE7Gu0SlaUe7VGP0=;
 b=AhFz8blEgCIEHWf2LYK+eA94b+5yAVOXqi9sPIuM6xZuoC646I0AqhKCUb/B+ic52D0Y2UZzhlKlgHcNDVtKY2LX6OxDN0Vs9TaOaA3uuDXaQIHMQ4XMQBI7Eq1t5gruO2a0tZmgo7IOfbc5KHknR8Lc6v+m6VQoEue4rRdciFEFedPy3Tmn6b34QaP+mZjlkyVCoIjzVt7spBFf/GTUtoGr/C+wo6RYF8L/QlnDPkTCissJj5d2pJcCJ7ujWaHVVWkztoXuRGKmxRli1OZvHt35egytV9/Ui3oQl00GdLiyXRVN0hjk+at53m0uems26nWy9SjyRuWzKv+3jX80Tg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by PR3PR04MB7353.eurprd04.prod.outlook.com (2603:10a6:102:82::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 06:21:15 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 06:21:15 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Tue, 03 Nov 2026 14:22:04 +0800
Subject: [PATCH v9 08/16] drm/imx: dc: Add PRG support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-imx8-dc-prefetch-v9-8-3b985e7636e2@nxp.com>
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
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI3PR03CA0011.apcprd03.prod.outlook.com
 (2603:1096:4:297::6) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|PR3PR04MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: d00a9193-635b-4cc2-3036-08df3972aa14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|23010399003|7416014|376014|1800799024|10067099003|22082099003|261102123227099003|18002099003|921020|56012099006|11063799006|261022105027099003|261021121427099003|261021123027099003|261026121527099003|261009223027099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: XNmzd6vJvo4jdMss+BdkfN7UZ6SE6YPcHzv+CHZ2xh4icxqRBhpIuT32Wd67mTk4sjXGpmQ6fN6bWRVRYKX6raNXlrBKpvzEgzlan3TOK0QXPq1SsYNM6WEpYliAbETL0m4GTMhJqYLNX/Lm0AdXEWoaoq513rZrQlfQirDKrHoDj/ZnzKbGQToZUTo/THyIxj++I3bxatDxQMvkmNZ8LJ0csb1MMLJMm1KL3RT77F8B0ulf9qWiGs85zvZ5OrPf2IPeNVzvfliGI5qsJaL9f/2MBw9D995aURTHpce5Zu4XDKj4UIRcw4I+38i/W5rrwCyzOiXJblClG8234Epkj/WnIEML/c85jj7rgzeOcgTKruIES1/uEklWy+LTW3+obbqM22PJz9JYV76BkfybQUSpf8yAJb3SG2HhPiPie/zX3craeQfdrHhX8MqNIvwSULuDp572NNYDpceKcXI0I05NuTv4ySrc8qzL9vyeeTSuhPJ7nbqQi6YGulguCsSsQMvNHi1VJcYFYp08cOKMCUMtOc4AXTp6mNdg5gBuYH0BnfrJEbC9i+oN5ugAm9QOlf790DMJRGrhJvOfMvOFdZK4w9QiHkNU2qHzj2njei86YHgRvUdjHztJjOGGyuGF/ENketO1VEOOEFysxo6rPRLU9ALZzcPXUNjJ/niSs7Qhl+ypMnYxOfD/VG48pEH4Wj5CkrFjZrMyQlH3E6M4Uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(23010399003)(7416014)(376014)(1800799024)(10067099003)(22082099003)(261102123227099003)(18002099003)(921020)(56012099006)(11063799006)(261022105027099003)(261021121427099003)(261021123027099003)(261026121527099003)(261009223027099003)(261028144727099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlJ0VWJBNXFjUFpiZC9lNW1sR0ZmRS9GNTBya05DKzIrU3YwL3NJQnMrYm1r?=
 =?utf-8?B?ajNXbGlKYU5yR3U2OXZidDg5aEI5SEVWQjJFeG9IdGw2Z3F3T2tHVVIvN0p5?=
 =?utf-8?B?U1FTbFN1Qi9tVE1oM28ybkw2bHhaK21NRmVJaVl6Z0M3SSs5RXJ2RjhpZVhM?=
 =?utf-8?B?L3N2OERiOTlleEtNYkZSY2RmVERDUlEvTHI5ZFhZZldyeEhrblFyaU1hd3Ar?=
 =?utf-8?B?ZlJ0bEhTM3B3YlRTWDBOekpMdFpIRWxvNlJ1OTY5U3IzUFdyMlFyRHA1eVRw?=
 =?utf-8?B?SitjeUh6UUJ5M01iYmsvclZMTVNLdVdGYzVsZm9jUm0vNm9GZXQrclBwRzly?=
 =?utf-8?B?UUtlUHVNV0NRZFQ1TzZReGxSS1BMWk1ETmc4OGp3SFQ0dUZoU1RRbW1qc2J0?=
 =?utf-8?B?Y1ZCOUZVZDZuak1CWEV0UDYvdHNSejJrdmdBMjgvMmNhY28vb2VJNVdVVUI0?=
 =?utf-8?B?WCtDcmJmZFMvelNEYW93a0txUmVURVpMTFhBQTFkNGdLVUZYTmdwNTU2MHRR?=
 =?utf-8?B?UW1Zd242RWk0Vlc1VXU2NXRQTmNNaU5YQmdWamlsTW1IWmE4MlVwUkJBNTdt?=
 =?utf-8?B?c1Y0Z1dWVTFkNSsvQ3NlQk0vUFNtcGxzajFYalVFOGhFa2xvMmFEa3FTSUtj?=
 =?utf-8?B?ZDk1UW5oaU5UTEM2TEYwdnBGU2RKV3grdUFSOTk0WFJCRnBUN1dBNEJtYUJh?=
 =?utf-8?B?VUQ0c3B3eDRIdGhVaHppTi9UUTh6aXdlMVVSZjNMNlpTcy9rZHpEWXJtTkIr?=
 =?utf-8?B?RndyTFZyc1NEYXNYVXJ5aW1SMWp1ZTN6QTRseE80YlBKMGFjSmlrMDdkWlN0?=
 =?utf-8?B?WHdMYlpPUVdKTkxZRTRVWC81N2JqNmFTM0h6RjV3cTk0dDU3ZUx1Y0tOdzhh?=
 =?utf-8?B?M0RuNC95OXhXOXZORnhtb2N3Y1JaL016b1BzTFFuOC81R0F5T2RmOFJVT1Ex?=
 =?utf-8?B?ZSsySDRQT2ozdEN0dlpDWGRLd1V6Q3FtWlZoYldLVktaQy9lbDcvVmJ3L21H?=
 =?utf-8?B?Mmt3ZjlqSjhjYVFOVi92TnlRVXA5VENqeG5ETC9Fb0w5YkF4M214U3p4QkhM?=
 =?utf-8?B?QktZUnpvTHVzTDB3R2VLY0s4N2l2UGVHTVViSkhYbGx3Vm5JVHlubGZxdnJw?=
 =?utf-8?B?Y0NZZ2VYYVRxRktPc0J5Y0pEN2NTZlQ1NEFTR3VNeFJXNXhVV0JzU0ZSZkVr?=
 =?utf-8?B?OHR0Q3VLNWRydmF1MWpNNEgvWUxKQnExSXBmM3lwYjR5R1o4dDNvU1hGMUFF?=
 =?utf-8?B?M0sxWDM2cW1mV3RDTm9CUGN4OHdoZTJEZ1lDZTExKy9XazlEdDNQalljbnNz?=
 =?utf-8?B?VHk4bGJ5TEUzdXhRMktwYWNpalJoSmFvd00vTkRlaXE3R1FnT2F2bVdkVnpu?=
 =?utf-8?B?WjVaT0JyY0lGeWcxbDhlYnFqbC9tQTFPQ0d4VkkwdGZ2Vm1acVpsa1JLZmpG?=
 =?utf-8?B?TnJ1Kysxb3EvNHM1SWdiRVl4NFpyTEcyWkY2TDF3RmtHKzBZOUZHZitYRldN?=
 =?utf-8?B?N1RYMGtVeEhLSm83VjkvWFh3bWdFUyt3NlJ0b1N6ZGJ5VXd4b0V4WUF3QW9h?=
 =?utf-8?B?NDNvQit0ZlV2MVRmSWQyTTR0ZVFNSEVJQnArVjMxSHNQZXFHdkJodUJyM2Jl?=
 =?utf-8?B?bjEzVFFPMTJRT25nYkVHNzRPOWpReUx3azAvMTJBYjZ4UXI3VCtFVGw0S1JF?=
 =?utf-8?B?VXJYZEowL3lMemJGeEV6NWdEK0R6aUxwT0VVSmRjc0hpQy8wckR3b3BpOFFT?=
 =?utf-8?B?ZEZqTXV2RUpkMUdDR1BtNWpqM0xTS0wyY2xRREZBQ3dUUGcrRHBVa2dHZlY4?=
 =?utf-8?B?RHNIZ2pydUZHcjJ1Ym4wVHhwT2pPSDNDTlovYmVQV3BkZGV4RjdFN1B4NWll?=
 =?utf-8?B?cnd4WTllVUF0REU3MWJ4NlpyeGRVOSs1eVBCZW55ZUREbGVGNENhTlMwWlRo?=
 =?utf-8?B?T3Q2c0FCZWkvZlNWWnBUTlZXUThoeG5PWks4VzJDcE9PV1NnSXNVdXBRUlI2?=
 =?utf-8?B?RW1ocS9YcmhpcGpseU45dldSYlVHT3JtSjFORDJCMEdqaVZJTkRyOGVoNjY4?=
 =?utf-8?B?NEtIcHMvblc5YWdwM0syV1RnTzE3ZWtqaWlPVG9seFpDbGV5aW4xUVMxS2ZE?=
 =?utf-8?B?ZXFlUGVMenRZODBSNGZFZGdRam16TVk0cElhWjZycVdLb05acmVGbUdnMGlO?=
 =?utf-8?B?T244Vy9sVFVLVmkrdjlQYkF6dGpaWVRsNXdTaWFiWlhacWRxTXI0K25ocXFy?=
 =?utf-8?B?TFdsZElEZTc3SUdETVhtNkpTU3FCb2o2YS92amp3K1o1VDdFNVI2NzFUL1V2?=
 =?utf-8?B?bkoxbnBWdkJLZlQ3V0w5SWxZdExqZFJUalFOTDNtOGhYa3JJZjRmQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d00a9193-635b-4cc2-3036-08df3972aa14
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 06:21:15.3020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgEkNHUBFw8QvSAxpRbiACshHwIml0ozDqAUhgpWGAlxAFLVmqdQMltWY1ejiTnFy5CJ/9mbwNBGzVSzPhPUUA==
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
Reviewed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v9:
- Drop "struct dc_prg *prg" argument from dc_prg_stride_supported().
  (Laurentiu)
- Collect Laurentiu's R-b tag.

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
 drivers/gpu/drm/imx/dc/dc-prg.c | 317 ++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/imx/dc/dc-prg.h |  34 +++++
 5 files changed, 354 insertions(+), 1 deletion(-)

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
index 24b4be7be09e..e1c7d51db82b 100644
--- a/drivers/gpu/drm/imx/dc/dc-drv.c
+++ b/drivers/gpu/drm/imx/dc/dc-drv.c
@@ -357,6 +357,7 @@ static struct platform_driver * const dc_drivers[] = {
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
index 000000000000..b80ce5e64117
--- /dev/null
+++ b/drivers/gpu/drm/imx/dc/dc-prg.c
@@ -0,0 +1,317 @@
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
+bool dc_prg_stride_supported(unsigned int stride, dma_addr_t baddr)
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
index 000000000000..ea11c4080927
--- /dev/null
+++ b/drivers/gpu/drm/imx/dc/dc-prg.h
@@ -0,0 +1,34 @@
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
+bool dc_prg_stride_supported(unsigned int stride, dma_addr_t baddr);
+
+struct dc_prg *
+dc_prg_lookup_by_phandle(struct device *dev, const char *name, int index);
+
+#endif

-- 
2.43.0

