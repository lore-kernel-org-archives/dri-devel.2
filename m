Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F8E606A32E
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 06:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=dgW3OAZt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F26AB10F38A;
	Tue,  3 Nov 2026 06:21:31 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013005.outbound.protection.outlook.com
 [52.101.83.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B096510F38A
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 06:21:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eO8v5OhblDYGUvAfrx9iVebJHtcTF0lLQ2D1gEz0NhrDwdvy7sOB6S/MhnonpRKsGGCOnN16Zy5k67a9o/qZVh3Q2YFr7klC6Tbo4Uac0N9H14r4K2wUbJLiyNPXE9RBXnuhC8FpphWheAsfoQOoSGbIQTeDAUL5ZjKpKzintaPU5wCuR04T8wDRX1lgn5rYU0/GT8k21NS0BGVaULksgDzJQ05HFjrldLTi2QggSkf/LWMk5ZuEFKv2rIyXyOr5sYCKyKNpfGjJiNX3MMN9r7dUhLVWWzClIkAC4uiOySGF0/ZjHYtT9gNz+mf5E3wRs4kRImZuMUEyg7/mtqfJsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxVTTYTajHrsegQTE92O9FOTE03NbUi9JhxndOUk0gg=;
 b=qh1xSqJa/uDPJOwEi3P6u7VZmT2KAuVrjuTNctvQM7O2GmnePXrfC6xKzTSIq1NpTy20+PWQUAtDxH9+reaunwFvlSJBjErBROTo0VseaEtnjzJsAk6Wby8AwbwgMhAwJcLSt5QyVQn0p79DcZEXfzP1ZbcSbwVrRmOHNoZaiiwhwWGJef0BbsQdmrQylIKcomb7+P7Uxc+r5y9pYc6F96z/dxnMjyR53sAHtQw/R8CWn3qgP9qUfA/hnfdh5GWgxiG/LNS4q/kEt02XPbA091q4mFu7FC5FlFCMeyn/egDGupi239EgR+vwQQViQoNhjXF49pm+JNJrto5VBsasRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxVTTYTajHrsegQTE92O9FOTE03NbUi9JhxndOUk0gg=;
 b=dgW3OAZt+M3RO57i6iVyMta3pPSL2HR0fZshtBBs2HUpeu/o/7A0s3b+WLcDHPjPlGqICrgG2+EJOc0f+ULIsPsgc5xcMHSog/wONCCdJZNN1eyQZWP+rO19KWX4m0NkvAeMlixsTJIhPy9Y/mhWqnEVGKE7nMMV/0/umGq5IyocJL6Ma+wni96j+uJnjuFYEDWtBa1KESjL32ZoM3x84yt8COq5c8gy4tiJ44ibyRH5O2V5zHTfq+w9rICBxAdq9xtqMf164bHE6YTpVziClqV9ofxlmaUkzf5i2dfMjI01u9aJnuP91yFkTi/+1c/iX9QiEnu0d388Z4yKbh0pLQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by AS1PR04MB9698.eurprd04.prod.outlook.com (2603:10a6:20b:481::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 06:21:21 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 06:21:21 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Tue, 03 Nov 2026 14:22:05 +0800
Subject: [PATCH v9 09/16] drm/imx: dc: Add DPR channel support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-imx8-dc-prefetch-v9-9-3b985e7636e2@nxp.com>
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
X-ClientProxiedBy: SI2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:4:186::12) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|AS1PR04MB9698:EE_
X-MS-Office365-Filtering-Correlation-Id: af15e5d3-4c34-4906-d014-08df3972ad79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|7416014|23010399003|376014|1800799024|6133799003|10067099003|22082099003|261102123227099003|18002099003|921020|56012099006|11063799006|261022105027099003|261021121427099003|261009221227099003|261021123027099003|261026121527099003|261022075727099003|261009223327099003|261009220027099003|261009221727099003|261009223027099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: iPGeqAAhB7UuGokXiE9hgrXbhMikj1SuwV7u7D3W9EhFo6SS8P+GzjBlpIn4AEUMUIFMyCiEtv8k9Nuib+ciaFXnT9CMwbXz3QjJL4elcQF8KcpNblxGBm1WbvU/NxL9aVf2vOSYfMB+VqlKkYJ827rpP95OSWI7fp1T0Iv97Oc8gYqd9DgJHhZDb/uQAQThLGuPE3+CqTtyK43j8eS2OmrfCobFGaYSbWFluTyppi7vQG5Ot5SYv9kANgz3Eiq9ahw1Z4Tt1iD03xgBHPwk3UlJMuuZkgWDq74sPqcxdG9+wtDU7zggreiG2160g6FxcmQ9hZ67552EaRyfhWZaneT0aztNzCf00GhqwAxEreMP5B/YetpQqocJAuNX0cYiib6+3Cwz8y/6AKOHCnOn9XT/JJorrA/2TTIRJ3YTM5aaJ7Xfgy+mbeIbk3kIW5q+C/RufKRf4PFKiFHBT2WS5isuqWQwTrWHkWaX6vjbQlg0y6OsoUd9+0DN7LKQGTU5R85P2sYxZTiUYcLSLQ41o4TFHTGNLSjjFz+JhaxNRsFrsBmEOJ17FjkMxXF1B6zpItCr4LYX9foe6ePhbQ8FFgPF5Xqk4EtbClawNo3AY//njZugWd0Hh9juBMk2WBRCKjdnXAA91DWKO42C54bXoRZw7h6qGoA+JjFA0shenJUAA5K9Awe/cf+oUF2hCo33huMWii83KeBKtmPnxaohfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(7416014)(23010399003)(376014)(1800799024)(6133799003)(10067099003)(22082099003)(261102123227099003)(18002099003)(921020)(56012099006)(11063799006)(261022105027099003)(261021121427099003)(261009221227099003)(261021123027099003)(261026121527099003)(261022075727099003)(261009223327099003)(261009220027099003)(261009221727099003)(261009223027099003)(261028144727099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWs0dnlTZG9rMUFyV2RtazJWNmpIbGlwem5jWTZQQ1g3dmRUWkl2Wk9mZzBk?=
 =?utf-8?B?Y1BiN2J6MFVLc3lvSXlreHRtZzdIc0xvR0JSY21Uamd5a05UOEM2aXAyS3JD?=
 =?utf-8?B?Z3hWTTdCa1I4clM5QnkxYTNRTkliZCsxMXM5c1BhNTFubStBN0FYckJyWkpK?=
 =?utf-8?B?ZGxMNWlLMWFORzFRZHRqTGhNQzVBTVhIenNJanhLYkoyY0drQTFvbVVwYWZK?=
 =?utf-8?B?NkdrMEJJQldlTVNxNHdxeGlVYWVDR0hvSGpxekdIa0l1YkxyNWY1Zy84V09t?=
 =?utf-8?B?QjczTDFHZ1lGaDJLUmVERHhPVFB5L1YxVXRDWTEydi9MN01JTmxiNGt6V3Iv?=
 =?utf-8?B?QkllMVVBcTZLTWVmc1hKMUZoZVpHZjlSTlhiejY3V3ZtRmlsTllMSndrbHho?=
 =?utf-8?B?MFpYdFUwTmtLQ0dRU0JQTmh2S0VmaWhzLzliM3NXNndydEdvUTY1UWU5aHM0?=
 =?utf-8?B?a0ZncEUySFo3eTlyTDBWNGplTVdWSEMyN0M4cUJiZFhaUjgxMjUwMXlXVDdz?=
 =?utf-8?B?MVVHUTAzQjFEM2I0N0RWRGhNS1pRNzlwekFMdlZ5bnN2RTF2WWV0YlZMVUZP?=
 =?utf-8?B?RmNKaldGV25sVmpnY1IzM0s3clUzdDlNU1cvMlhrUitteU9TQmRhQk14c2d5?=
 =?utf-8?B?eTg5TGw3N3dqVFV6MktvblBMMUc3VGxSL05pbk80ckRmY0IyaVVmc0JXQ0M2?=
 =?utf-8?B?TiswM2ZlZDQ2cE1OMnZIMzA1ZkxFRkdHdUoxNE1JZnQzRXZQR09Sa28vRzNi?=
 =?utf-8?B?ZWpCbDZCWGZMa2dkMFFRQnhpdHR4Qkc2amhoMkoySUdMdXVrMjRGN0grMU5J?=
 =?utf-8?B?ZEVVKzhLOUMrQlVHRUJ1ditPL0xlbzNCQ2h2N041RWFrdllRcjVYZTl3MWdM?=
 =?utf-8?B?OGZwa2xyeFU1MHhubGs0T0VzR3hoaFUreWs3bFVqbnVlcEIyNEZHVVpUelRL?=
 =?utf-8?B?VzgyM3N6NStoYUlUVnJrVmZweDFFUGNkRkRwS3R3Wk1CLzdrMTAwem8wWHVi?=
 =?utf-8?B?czBEcmM3eFlOZ2JFTEZNSTRxOU95dEdJQU1LRTBpNTJaWUh0VmpjTm9lM3dr?=
 =?utf-8?B?OSthRlNPbnRsYWFydDV5a25LZ3RkUnR3Sm1MV2t6amtYZDRRSmV3S0xiWjFa?=
 =?utf-8?B?UXdwUkNJN3NLcXp0OUt5TTRmaWRlbGt5eFJKcy9HWmxlbU5pWG1vblBmNTJp?=
 =?utf-8?B?ZGFIQnNOMGZXRFE1OXhhNlozNnJYK24zRHpnZzE5UU5HalA3V05xTElJVVFZ?=
 =?utf-8?B?K013ajRhc2xqUmpZTDB3R2FLK2RxS3lrMTNmL0J6OTBCbCtJVEJFbE9RdHMx?=
 =?utf-8?B?TXpmMERzekh4VTJJUlpiTGV2Yml0V0x6UnQ0dkVqL2NHRXVBNjFKc0l0WVBu?=
 =?utf-8?B?ZjJzZ0taSTZwTi9QL0RMeWlBUlBkcDlmTm5rdDlvZmdjeUd0N2xjZ2tmRlJk?=
 =?utf-8?B?bkpiQWk5ZVU2eWFlMDh5bmNieVZMeG0yRE9Cd2l3bDN1RGJnMVJUZkplMjJ0?=
 =?utf-8?B?SDlGZjFnRklldVZQbHdBeDhrRTVHSlNsZHFXeFJBajRvbnUxc3pod09tZTNR?=
 =?utf-8?B?Nk9WZU1KSlE4aERETTYrdlZlN1A0K1g3TkEwbDQrNXdUUTNkVGVnbkV0SDdn?=
 =?utf-8?B?ZFIzUEFPMGEwWm9NcElHM3FIK2N5R0NjenFRL2lzaGtFaDUwS1VsNWc4WHpI?=
 =?utf-8?B?MzJ1ajhRNlJqQXFLRDFCTXJCRWRzV2R4U2xONVlSM25yby90NjVkOFkyQUxC?=
 =?utf-8?B?Rnc3SXJuY1ZYaTFpcGlpWXNqWmMzTnkzNXlwMjdFdnE0MVBMWTF6SWk0Q3Jm?=
 =?utf-8?B?YnBUdHl6QzhaQ3Q2dW9PTWcyRmRDUzNGNDdPQVBQQVVIZ1pTWUFURXdlZmdC?=
 =?utf-8?B?SkliNi9xOHRiS0ZJenl0V2xtQjZlS3dpaUJBc1VJWXpvbC9xdjhzckZyM2Z4?=
 =?utf-8?B?bnp1RHFMckVMdnBHL0dmTzFvR1ltVmIvK3ZETzJKWmhRclhPWkwrak1seU9T?=
 =?utf-8?B?eTFuaElSSkx4azRvK1V5U25xTnVqSTBlM1hnZG1Mb2FRcFpybkNOVDA3Vk1M?=
 =?utf-8?B?SnMzRzUza1ZSRTNoWXRmaXN2dW0vV3NWVldBN2lKb1FXY095OHFqZ0dhSWdl?=
 =?utf-8?B?TXhIc3FnS1V2aEQyUXN5SytrUVBXWkNNVGNZejNVdm5GYTcyQ1dpaXk3Zk5L?=
 =?utf-8?B?QnhoWmo1d1ZTUEpZcnJrbVJBS1owQlZEM1ByUVlkYi9jY2M2c005ZDg4ZFFK?=
 =?utf-8?B?WEpHZDFEZG8yMGFqTHVzTC9JS2o1c3owemxGZ2RlRjhZczNMdjVxTDAwdEtV?=
 =?utf-8?B?VjZHUFRtRGVxanVnZTU4dFVEcjgyOUUwcWN0Yks5NnplVTVPczdYZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af15e5d3-4c34-4906-d014-08df3972ad79
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 06:21:21.1181 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZBiAZIfLmtMbQa1/U2Pk83w3HJm4bjmFSKmb31zEQ08hnU1I6Drtw2a8XKe3t2ZYgJlrcO18ME3FXK2niM69OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9698
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

Display Prefetch Resolve Channel(DPRC) is a part of a prefetch engine.
It fetches display data, transforms it to linear format and stores it
to DPRC's RTRAM.  PRG, as the other part of a prefetch engine, acts as
a gasket between the RTRAM controller and a FetchUnit.  Add a platform
driver to support the DPRC.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v9:
- Drop "struct dc_dprc *dprc" argument from dc_dprc_rtram_width_supported()
  and dc_dprc_stride_supported().  (Laurentiu)
- Collect Laurentiu's R-b tag.
- Change dprc->lock from spinlock_t to raw_spinlock_t.  (Sashiko AI bot)
- Add IRQF_NO_THREAD flag to devm_request_irq() function call.  (Sashiko AI bot)
- Mask all IRQ bits with the scoped guard dprc->lock before calling
  sychronize_hardirq() in dc_dprc_disable_repeat_en() so that runtime PM
  callbacks are synchronous with DPRC register accesses in
  dc_dprc_wrap_irq_handler().  (Sashiko AI bot)

v8:
- Check device_link_add()'s return value and bail out if needed.
  (Sashiko AI bot)
- Mask IRQ_DPR_CRTL_DONE irq and synchronize wrap_irq in
  dc_dprc_disable_repeat_en() to avoid a race condition.  (Sashiko AI bot)
- Call devm_pm_runtime_enable() before devm_request_irq() to avoid reading
  dprc->reg in dc_dprc_wrap_irq_handler while dprc->clks are disabled, since
  another device sharing wrap_irq could raise an interrupt during probe.
  (Sashiko AI bot)
- Drop an unused header file.  (Laurentiu)
- Use dev_err_probe() to handle errors returned from several function calls.
  (Laurentiu)

v7:
- Collect Maxime's A-b tag.
- Fix dc_dprc_regmap_write_ranges[].  (Sashiko AI bot)
- Fix dc_dprc_wrap_irq_handler() return value.  (Sashiko AI bot)
- Check runtime PM status in dc_dprc_wrap_irq_handler().  (Sashiko AI bot)
- Fix DPU_DRPC_MAX_STRIDE macro.  (Sashiko AI bot)
- Support deferral probe if platform_get_irq_byname() fails.  (Sashiko AI bot)
- Avoid dangling prg->dprc by calling dc_prg_set_dprc() properly.
  (Sashiko AI bot)
- Add dc_dprc_get() helper for consumer device to get DPRC properly.
- Set use_raw_spinlock flag in regmap configuration to avoid a potential
  hard lockup because dc_dprc_disable_repeat_en() is supposed to be called
  with local irq and preempt disabled.

v6:
- Include "dc-drv.h" to avoid build warning with C=1.

v3:
- Call dc_dprc_enable() only when start == true.  (Frank)
- Collect Frank's R-b tag.

v2:
- Manage clocks with bulk interfaces.  (Frank)
- Sort variables in probe function in reverse Christmas tree fashion.  (Frank)
---
 drivers/gpu/drm/imx/dc/Kconfig   |   1 +
 drivers/gpu/drm/imx/dc/Makefile  |   6 +-
 drivers/gpu/drm/imx/dc/dc-dprc.c | 534 +++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/imx/dc/dc-dprc.h |  36 +++
 drivers/gpu/drm/imx/dc/dc-drv.c  |   1 +
 drivers/gpu/drm/imx/dc/dc-drv.h  |   1 +
 drivers/gpu/drm/imx/dc/dc-prg.c  |  12 +
 drivers/gpu/drm/imx/dc/dc-prg.h  |   4 +
 8 files changed, 592 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/imx/dc/Kconfig b/drivers/gpu/drm/imx/dc/Kconfig
index 415993207f2e..507dc9a92d96 100644
--- a/drivers/gpu/drm/imx/dc/Kconfig
+++ b/drivers/gpu/drm/imx/dc/Kconfig
@@ -1,6 +1,7 @@
 config DRM_IMX8_DC
 	tristate "Freescale i.MX8 Display Controller Graphics"
 	depends on DRM && COMMON_CLK && OF && (ARCH_MXC || COMPILE_TEST)
+	depends on IMX_SCU
 	select DRM_CLIENT_SELECTION
 	select DRM_GEM_DMA_HELPER
 	select DRM_KMS_HELPER
diff --git a/drivers/gpu/drm/imx/dc/Makefile b/drivers/gpu/drm/imx/dc/Makefile
index e3a06ee3ce1a..fd5d62783971 100644
--- a/drivers/gpu/drm/imx/dc/Makefile
+++ b/drivers/gpu/drm/imx/dc/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
-imx8-dc-drm-objs := dc-cf.o dc-crtc.o dc-de.o dc-drv.o dc-ed.o dc-fg.o dc-fl.o \
-		    dc-fu.o dc-fw.o dc-ic.o dc-kms.o dc-lb.o dc-pe.o dc-prg.o  \
-		    dc-plane.o dc-tc.o
+imx8-dc-drm-objs := dc-cf.o dc-crtc.o dc-de.o dc-dprc.o dc-drv.o dc-ed.o \
+		    dc-fg.o dc-fl.o dc-fu.o dc-fw.o dc-ic.o dc-kms.o dc-lb.o \
+		    dc-pe.o dc-prg.o dc-plane.o dc-tc.o
 
 obj-$(CONFIG_DRM_IMX8_DC) += imx8-dc-drm.o
diff --git a/drivers/gpu/drm/imx/dc/dc-dprc.c b/drivers/gpu/drm/imx/dc/dc-dprc.c
new file mode 100644
index 000000000000..aa6899d162e3
--- /dev/null
+++ b/drivers/gpu/drm/imx/dc/dc-dprc.c
@@ -0,0 +1,534 @@
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
+#include <linux/firmware/imx/svc/misc.h>
+#include <linux/hardirq.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/firmware/imx/rsrc.h>
+
+#include "dc-dprc.h"
+#include "dc-drv.h"
+#include "dc-prg.h"
+
+#define SET					0x4
+#define CLR					0x8
+#define TOG					0xc
+
+#define SYSTEM_CTRL0				0x00
+#define  SW_SHADOW_LOAD_SEL			BIT(4)
+#define  SHADOW_LOAD_EN				BIT(3)
+#define  REPEAT_EN				BIT(2)
+#define  SOFT_RESET				BIT(1)
+#define  RUN_EN					BIT(0)	/* self-clearing */
+
+#define IRQ_MASK				0x20
+#define IRQ_MASK_STATUS				0x30
+#define IRQ_NONMASK_STATUS			0x40
+#define  DPR2RTR_FIFO_LOAD_BUF_RDY_UV_ERROR	BIT(7)
+#define  DPR2RTR_FIFO_LOAD_BUF_RDY_YRGB_ERROR	BIT(6)
+#define  DPR2RTR_UV_FIFO_OVFL			BIT(5)
+#define  DPR2RTR_YRGB_FIFO_OVFL			BIT(4)
+#define  IRQ_AXI_READ_ERROR			BIT(3)
+#define  IRQ_DPR_SHADOW_LOADED_MASK		BIT(2)
+#define  IRQ_DPR_RUN				BIT(1)
+#define  IRQ_DPR_CRTL_DONE			BIT(0)
+#define  IRQ_CTRL_MASK				GENMASK(2, 0)
+#define  IRQ_ALL_MASK				GENMASK(7, 0)
+
+#define MODE_CTRL0				0x50
+#define  A_COMP_SEL(byte)			FIELD_PREP(GENMASK(17, 16), (byte))
+#define  R_COMP_SEL(byte)			FIELD_PREP(GENMASK(15, 14), (byte))
+#define  G_COMP_SEL(byte)			FIELD_PREP(GENMASK(13, 12), (byte))
+#define  B_COMP_SEL(byte)			FIELD_PREP(GENMASK(11, 10), (byte))
+#define  PIX_SIZE_32BIT				FIELD_PREP(GENMASK(7, 6), 0x2)
+#define  LINE4					BIT(1)
+#define  BUF2					0
+
+#define FRAME_CTRL0				0x70
+#define  PITCH(n)				FIELD_PREP(GENMASK(31, 16), (n))
+
+#define FRAME_1P_CTRL0				0x90
+#define FRAME_2P_CTRL0				0xe0
+#define  MAX_BYTES_PREQ_MASK			GENMASK(2, 0)
+#define  BYTE_1K				FIELD_PREP(MAX_BYTES_PREQ_MASK, 0x4)
+
+#define FRAME_1P_PIX_X_CTRL			0xa0
+#define  NUM_X_PIX_WIDE(n)			FIELD_PREP(GENMASK(15, 0), (n))
+
+#define FRAME_1P_PIX_Y_CTRL			0xb0
+#define  NUM_Y_PIX_HIGH(n)			FIELD_PREP(GENMASK(15, 0), (n))
+
+#define FRAME_1P_BASE_ADDR_CTRL0		0xc0
+
+#define FRAME_PIX_X_ULC_CTRL			0xf0
+#define  CROP_ULC_X(n)				FIELD_PREP(GENMASK(15, 0), (n))
+
+#define FRAME_PIX_Y_ULC_CTRL			0x100
+#define  CROP_ULC_Y(n)				FIELD_PREP(GENMASK(15, 0), (n))
+
+#define FRAME_2P_BASE_ADDR_CTRL0		0x110
+
+#define STATUS_CTRL0				0x130
+#define STATUS_CTRL1				0x140
+
+#define RTRAM_CTRL0				0x200
+#define  THRES_LOW(n)				FIELD_PREP(GENMASK(6, 4), (n))
+#define  THRES_HIGH(n)				FIELD_PREP(GENMASK(3, 1), (n))
+
+#define DPU_DRPC_MAX_STRIDE			0xffff
+#define DPU_DPRC_MAX_RTRAM_WIDTH		2880
+
+struct dc_dprc {
+	struct device *dev;
+	struct regmap *reg;
+	struct list_head list;
+	struct clk_bulk_data *clks;
+	int num_clks;
+	int wrap_irq;
+	struct imx_sc_ipc *ipc_handle;
+	raw_spinlock_t lock;	/* protect IRQ registers */
+	u32 sc_resource;
+	struct dc_prg *prg;
+};
+
+static DEFINE_MUTEX(dc_dprc_list_mutex);
+static LIST_HEAD(dc_dprc_list);
+
+static const struct regmap_range dc_dprc_regmap_write_ranges[] = {
+	regmap_reg_range(SYSTEM_CTRL0, SYSTEM_CTRL0 + TOG),
+	regmap_reg_range(IRQ_MASK, MODE_CTRL0 + TOG),
+	regmap_reg_range(FRAME_CTRL0, FRAME_CTRL0 + TOG),
+	regmap_reg_range(FRAME_1P_CTRL0, FRAME_1P_BASE_ADDR_CTRL0 + TOG),
+	regmap_reg_range(FRAME_PIX_X_ULC_CTRL, FRAME_2P_BASE_ADDR_CTRL0 + TOG),
+	regmap_reg_range(STATUS_CTRL0, STATUS_CTRL0 + TOG),
+	regmap_reg_range(RTRAM_CTRL0, RTRAM_CTRL0 + TOG),
+};
+
+static const struct regmap_range dc_dprc_regmap_read_ranges[] = {
+	regmap_reg_range(SYSTEM_CTRL0, SYSTEM_CTRL0 + TOG),
+	regmap_reg_range(IRQ_MASK, IRQ_MASK_STATUS + TOG),
+	regmap_reg_range(MODE_CTRL0, MODE_CTRL0 + TOG),
+	regmap_reg_range(FRAME_CTRL0, FRAME_CTRL0 + TOG),
+	regmap_reg_range(FRAME_1P_CTRL0, FRAME_1P_BASE_ADDR_CTRL0 + TOG),
+	regmap_reg_range(FRAME_PIX_X_ULC_CTRL, FRAME_2P_BASE_ADDR_CTRL0 + TOG),
+	regmap_reg_range(STATUS_CTRL0, STATUS_CTRL1 + TOG),
+	regmap_reg_range(RTRAM_CTRL0, RTRAM_CTRL0 + TOG),
+};
+
+static const struct regmap_access_table dc_dprc_regmap_write_table = {
+	.yes_ranges = dc_dprc_regmap_write_ranges,
+	.n_yes_ranges = ARRAY_SIZE(dc_dprc_regmap_write_ranges),
+};
+
+static const struct regmap_access_table dc_dprc_regmap_read_table = {
+	.yes_ranges = dc_dprc_regmap_read_ranges,
+	.n_yes_ranges = ARRAY_SIZE(dc_dprc_regmap_read_ranges),
+};
+
+static const struct regmap_config dc_dprc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.fast_io = true,
+	/*
+	 * Registers could be accessed with local irq and preempt disabled,
+	 * so use a raw spinlock to avoid sleeping on PREEMPT_RT.
+	 */
+	.use_raw_spinlock = true,
+	.wr_table = &dc_dprc_regmap_write_table,
+	.rd_table = &dc_dprc_regmap_read_table,
+	.max_register = RTRAM_CTRL0 + TOG,
+};
+
+static void dc_dprc_set_stream_id(struct dc_dprc *dprc, unsigned int stream_id)
+{
+	int ret;
+
+	ret = imx_sc_misc_set_control(dprc->ipc_handle, dprc->sc_resource,
+				      IMX_SC_C_KACHUNK_SEL, stream_id);
+	if (ret)
+		dev_err(dprc->dev, "failed to set KACHUNK_SEL: %d\n", ret);
+}
+
+static void dc_dprc_reset(struct dc_dprc *dprc)
+{
+	regmap_write(dprc->reg, SYSTEM_CTRL0 + SET, SOFT_RESET);
+	fsleep(20);
+	regmap_write(dprc->reg, SYSTEM_CTRL0 + CLR, SOFT_RESET);
+	fsleep(20);
+}
+
+static void dc_dprc_enable(struct dc_dprc *dprc)
+{
+	dc_prg_enable(dprc->prg);
+}
+
+static void dc_dprc_reg_update(struct dc_dprc *dprc)
+{
+	dc_prg_reg_update(dprc->prg);
+}
+
+static void dc_dprc_enable_ctrl_done_irq(struct dc_dprc *dprc)
+{
+	guard(raw_spinlock_irqsave)(&dprc->lock);
+	regmap_write(dprc->reg, IRQ_MASK + CLR, IRQ_DPR_CRTL_DONE);
+}
+
+void dc_dprc_configure(struct dc_dprc *dprc, unsigned int stream_id,
+		       unsigned int width, unsigned int height,
+		       unsigned int stride,
+		       const struct drm_format_info *format,
+		       dma_addr_t baddr, bool start)
+{
+	unsigned int prg_stride = width * format->cpp[0];
+	unsigned int bpp = format->cpp[0] * 8;
+	struct device *dev = dprc->dev;
+	unsigned int p1_w, p1_h;
+	u32 val;
+	int ret;
+
+	if (start) {
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret < 0) {
+			dev_err(dev, "failed to get RPM: %d\n", ret);
+			return;
+		}
+
+		dc_dprc_set_stream_id(dprc, stream_id);
+	}
+
+	p1_w = round_up(width, format->cpp[0] == 2 ? 32 : 16);
+	p1_h = round_up(height, 4);
+
+	regmap_write(dprc->reg, FRAME_CTRL0, PITCH(stride));
+	regmap_write(dprc->reg, FRAME_1P_CTRL0, BYTE_1K);
+	regmap_write(dprc->reg, FRAME_1P_PIX_X_CTRL, NUM_X_PIX_WIDE(p1_w));
+	regmap_write(dprc->reg, FRAME_1P_PIX_Y_CTRL, NUM_Y_PIX_HIGH(p1_h));
+	regmap_write(dprc->reg, FRAME_1P_BASE_ADDR_CTRL0, baddr);
+	regmap_write(dprc->reg, FRAME_PIX_X_ULC_CTRL, CROP_ULC_X(0));
+	regmap_write(dprc->reg, FRAME_PIX_Y_ULC_CTRL, CROP_ULC_Y(0));
+
+	regmap_write(dprc->reg, RTRAM_CTRL0, THRES_LOW(3) | THRES_HIGH(7));
+
+	val = LINE4 | BUF2;
+	switch (format->format) {
+	case DRM_FORMAT_XRGB8888:
+		/*
+		 * It turns out pixel components are mapped directly
+		 * without position change via DPR processing with
+		 * the following color component configurations.
+		 * Leave the pixel format to be handled by the
+		 * display controllers.
+		 */
+		val |= A_COMP_SEL(3) | R_COMP_SEL(2) |
+		       G_COMP_SEL(1) | B_COMP_SEL(0);
+		val |= PIX_SIZE_32BIT;
+		break;
+	default:
+		dev_err(dev, "unsupported format 0x%08x\n", format->format);
+		return;
+	}
+	regmap_write(dprc->reg, MODE_CTRL0, val);
+
+	if (start) {
+		/* software shadow load for the first frame */
+		val = SW_SHADOW_LOAD_SEL | SHADOW_LOAD_EN;
+		regmap_write(dprc->reg, SYSTEM_CTRL0, val);
+
+		/* and then, run... */
+		val |= RUN_EN | REPEAT_EN;
+		regmap_write(dprc->reg, SYSTEM_CTRL0, val);
+	}
+
+	dc_prg_configure(dprc->prg, width, height, prg_stride, bpp, baddr, start);
+
+	if (start)
+		dc_dprc_enable(dprc);
+
+	dc_dprc_reg_update(dprc);
+
+	if (start)
+		dc_dprc_enable_ctrl_done_irq(dprc);
+
+	dev_dbg(dev, "w: %u, h: %u, s: %u, fmt: 0x%08x\n",
+		width, height, stride, format->format);
+}
+
+void dc_dprc_disable_repeat_en(struct dc_dprc *dprc)
+{
+	scoped_guard(raw_spinlock, &dprc->lock)
+		regmap_write(dprc->reg, IRQ_MASK + SET, IRQ_ALL_MASK);
+
+	synchronize_hardirq(dprc->wrap_irq);
+
+	regmap_write(dprc->reg, SYSTEM_CTRL0 + CLR, REPEAT_EN);
+	dev_dbg(dprc->dev, "disable REPEAT_EN\n");
+}
+
+/*
+ * dc_dprc_disable_repeat_en() must be called beforehand to mask
+ * IRQ_DPR_CRTL_DONE and synchronize wrap_irq.
+ */
+void dc_dprc_disable(struct dc_dprc *dprc)
+{
+	dc_prg_disable(dprc->prg);
+
+	pm_runtime_put(dprc->dev);
+
+	dev_dbg(dprc->dev, "disable\n");
+}
+
+void dc_dprc_disable_at_boot(struct dc_dprc *dprc)
+{
+	dc_prg_disable_at_boot(dprc->prg);
+
+	clk_bulk_disable_unprepare(dprc->num_clks, dprc->clks);
+
+	dev_dbg(dprc->dev, "disable at boot\n");
+}
+
+static void dc_dprc_ctrl_done_handle(struct dc_dprc *dprc)
+{
+	regmap_write(dprc->reg, SYSTEM_CTRL0, REPEAT_EN);
+
+	dc_prg_shadow_enable(dprc->prg);
+
+	dev_dbg(dprc->dev, "CTRL done handle\n");
+}
+
+static irqreturn_t dc_dprc_wrap_irq_handler(int irq, void *data)
+{
+	struct dc_dprc *dprc = data;
+	struct device *dev = dprc->dev;
+	u32 mask = 0, status = 0;
+	irqreturn_t result;
+
+	pm_runtime_get_noresume(dev);
+	if (!pm_runtime_active(dev)) {
+		result = IRQ_NONE;
+		goto out;
+	}
+
+	scoped_guard(raw_spinlock, &dprc->lock) {
+		/* cache valid IRQ status */
+		regmap_read(dprc->reg, IRQ_MASK, &mask);
+		regmap_read(dprc->reg, IRQ_MASK_STATUS, &status);
+		status &= ~mask;
+
+		/* mask the IRQ(s) being handled */
+		regmap_write(dprc->reg, IRQ_MASK + SET, status);
+
+		/* clear status register */
+		regmap_write(dprc->reg, IRQ_MASK_STATUS, status);
+	}
+
+	if (status == 0) {
+		result = IRQ_NONE;
+		goto out;
+	}
+
+	if (status & DPR2RTR_FIFO_LOAD_BUF_RDY_UV_ERROR)
+		dev_err(dev, "DPR to RTRAM FIFO load UV buffer ready error\n");
+
+	if (status & DPR2RTR_FIFO_LOAD_BUF_RDY_YRGB_ERROR)
+		dev_err(dev, "DPR to RTRAM FIFO load YRGB buffer ready error\n");
+
+	if (status & DPR2RTR_UV_FIFO_OVFL)
+		dev_err(dev, "DPR to RTRAM FIFO UV FIFO overflow\n");
+
+	if (status & DPR2RTR_YRGB_FIFO_OVFL)
+		dev_err(dev, "DPR to RTRAM FIFO YRGB FIFO overflow\n");
+
+	if (status & IRQ_AXI_READ_ERROR)
+		dev_err(dev, "AXI read error\n");
+
+	if (status & IRQ_DPR_CRTL_DONE)
+		dc_dprc_ctrl_done_handle(dprc);
+
+	result = IRQ_HANDLED;
+out:
+	pm_runtime_put_noidle(dev);
+	return result;
+}
+
+bool dc_dprc_rtram_width_supported(unsigned int width)
+{
+	return width <= DPU_DPRC_MAX_RTRAM_WIDTH;
+}
+
+bool dc_dprc_stride_supported(unsigned int stride, unsigned int width,
+			      const struct drm_format_info *format,
+			      dma_addr_t baddr)
+{
+	unsigned int prg_stride = width * format->cpp[0];
+
+	if (stride > DPU_DRPC_MAX_STRIDE)
+		return false;
+
+	if (!dc_prg_stride_supported(prg_stride, baddr))
+		return false;
+
+	return true;
+}
+
+struct dc_dprc *dc_dprc_get(struct device *dev, struct dc_dprc *dprc)
+{
+	struct device_link *link;
+	struct dc_dprc *iter;
+
+	guard(mutex)(&dc_dprc_list_mutex);
+	list_for_each_entry(iter, &dc_dprc_list, list) {
+		if (iter == dprc) {
+			link = device_link_add(dev, dprc->dev,
+					       DL_FLAG_AUTOREMOVE_CONSUMER);
+			if (!link) {
+				dev_err(dev, "failed to add device link to DPRC\n");
+				return NULL;
+			}
+
+			return dprc;
+		}
+	}
+
+	return NULL;
+}
+
+static int dc_dprc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct resource *res;
+	struct dc_dprc *dprc;
+	void __iomem *base;
+	int ret;
+
+	dprc = devm_kzalloc(dev, sizeof(*dprc), GFP_KERNEL);
+	if (!dprc)
+		return -ENOMEM;
+
+	ret = imx_scu_get_handle(&dprc->ipc_handle);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get SCU ipc handle\n");
+
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	dprc->reg = devm_regmap_init_mmio(dev, base, &dc_dprc_regmap_config);
+	if (IS_ERR(dprc->reg))
+		return PTR_ERR(dprc->reg);
+
+	dprc->wrap_irq = platform_get_irq_byname(pdev, "dpr_wrap");
+	if (dprc->wrap_irq < 0)
+		return dev_err_probe(dev, dprc->wrap_irq, "failed to get dpr_wrap IRQ\n");
+
+	dprc->num_clks = devm_clk_bulk_get_all(dev, &dprc->clks);
+	if (dprc->num_clks < 0)
+		return dev_err_probe(dev, dprc->num_clks, "failed to get clocks\n");
+
+	ret = of_property_read_u32(np, "fsl,sc-resource", &dprc->sc_resource);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get SC resource\n");
+
+	dprc->prg = dc_prg_lookup_by_phandle(dev, "fsl,prgs", 0);
+	if (!dprc->prg)
+		return dev_err_probe(dev, -EPROBE_DEFER,
+				     "failed to lookup PRG\n");
+
+	dprc->dev = dev;
+	raw_spin_lock_init(&dprc->lock);
+
+	dev_set_drvdata(dev, dprc);
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable PM runtime\n");
+
+	ret = devm_request_irq(dev, dprc->wrap_irq, dc_dprc_wrap_irq_handler,
+			       IRQF_SHARED | IRQF_NO_THREAD, dev_name(dev), dprc);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to request dpr_wrap IRQ(%d)\n",
+				     dprc->wrap_irq);
+
+	guard(mutex)(&dc_dprc_list_mutex);
+	list_add(&dprc->list, &dc_dprc_list);
+
+	dc_prg_set_dprc(dprc->prg, dprc);
+
+	return 0;
+}
+
+static void dc_dprc_remove(struct platform_device *pdev)
+{
+	struct dc_dprc *dprc = dev_get_drvdata(&pdev->dev);
+
+	dc_prg_set_dprc(dprc->prg, NULL);
+
+	guard(mutex)(&dc_dprc_list_mutex);
+	list_del(&dprc->list);
+}
+
+static int dc_dprc_runtime_suspend(struct device *dev)
+{
+	struct dc_dprc *dprc = dev_get_drvdata(dev);
+
+	clk_bulk_disable_unprepare(dprc->num_clks, dprc->clks);
+
+	return 0;
+}
+
+static int dc_dprc_runtime_resume(struct device *dev)
+{
+	struct dc_dprc *dprc = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_bulk_prepare_enable(dprc->num_clks, dprc->clks);
+	if (ret) {
+		dev_err(dev, "failed to enable clocks: %d\n", ret);
+		return ret;
+	}
+
+	dc_dprc_reset(dprc);
+
+	/* disable all control IRQs and enable all error IRQs */
+	guard(raw_spinlock_irqsave)(&dprc->lock);
+	regmap_write(dprc->reg, IRQ_MASK, IRQ_CTRL_MASK);
+
+	return 0;
+}
+
+static const struct dev_pm_ops dc_dprc_pm_ops = {
+	RUNTIME_PM_OPS(dc_dprc_runtime_suspend, dc_dprc_runtime_resume, NULL)
+};
+
+static const struct of_device_id dc_dprc_dt_ids[] = {
+	{ .compatible = "fsl,imx8qxp-dpr-channel", },
+	{ /* sentinel */ }
+};
+
+struct platform_driver dc_dprc_driver = {
+	.probe = dc_dprc_probe,
+	.remove = dc_dprc_remove,
+	.driver = {
+		.name = "imx8-dc-dpr-channel",
+		.suppress_bind_attrs = true,
+		.of_match_table = dc_dprc_dt_ids,
+		.pm = pm_ptr(&dc_dprc_pm_ops),
+	},
+};
diff --git a/drivers/gpu/drm/imx/dc/dc-dprc.h b/drivers/gpu/drm/imx/dc/dc-dprc.h
new file mode 100644
index 000000000000..2081e69434e4
--- /dev/null
+++ b/drivers/gpu/drm/imx/dc/dc-dprc.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2025 NXP
+ */
+
+#ifndef __DC_DPRC_H__
+#define __DC_DPRC_H__
+
+#include <linux/device.h>
+#include <linux/types.h>
+
+#include <drm/drm_fourcc.h>
+
+struct dc_dprc;
+
+void dc_dprc_configure(struct dc_dprc *dprc, unsigned int stream_id,
+		       unsigned int width, unsigned int height,
+		       unsigned int stride,
+		       const struct drm_format_info *format,
+		       dma_addr_t baddr, bool start);
+
+void dc_dprc_disable_repeat_en(struct dc_dprc *dprc);
+
+void dc_dprc_disable(struct dc_dprc *dprc);
+
+void dc_dprc_disable_at_boot(struct dc_dprc *dprc);
+
+bool dc_dprc_rtram_width_supported(unsigned int width);
+
+bool dc_dprc_stride_supported(unsigned int stride, unsigned int width,
+			      const struct drm_format_info *format,
+			      dma_addr_t baddr);
+
+struct dc_dprc *dc_dprc_get(struct device *dev, struct dc_dprc *dprc);
+
+#endif
diff --git a/drivers/gpu/drm/imx/dc/dc-drv.c b/drivers/gpu/drm/imx/dc/dc-drv.c
index e1c7d51db82b..9fb9ee640a4d 100644
--- a/drivers/gpu/drm/imx/dc/dc-drv.c
+++ b/drivers/gpu/drm/imx/dc/dc-drv.c
@@ -350,6 +350,7 @@ static struct platform_driver dc_driver = {
 static struct platform_driver * const dc_drivers[] = {
 	&dc_cf_driver,
 	&dc_de_driver,
+	&dc_dprc_driver,
 	&dc_ed_driver,
 	&dc_fg_driver,
 	&dc_fl_driver,
diff --git a/drivers/gpu/drm/imx/dc/dc-drv.h b/drivers/gpu/drm/imx/dc/dc-drv.h
index 7873cd421942..ba6ed7b06bfc 100644
--- a/drivers/gpu/drm/imx/dc/dc-drv.h
+++ b/drivers/gpu/drm/imx/dc/dc-drv.h
@@ -74,6 +74,7 @@ int dc_plane_init(struct dc_drm_device *dc_drm, struct dc_plane *dc_plane);
 
 extern struct platform_driver dc_cf_driver;
 extern struct platform_driver dc_de_driver;
+extern struct platform_driver dc_dprc_driver;
 extern struct platform_driver dc_ed_driver;
 extern struct platform_driver dc_fg_driver;
 extern struct platform_driver dc_fl_driver;
diff --git a/drivers/gpu/drm/imx/dc/dc-prg.c b/drivers/gpu/drm/imx/dc/dc-prg.c
index b80ce5e64117..b6a2dc8f6df7 100644
--- a/drivers/gpu/drm/imx/dc/dc-prg.c
+++ b/drivers/gpu/drm/imx/dc/dc-prg.c
@@ -17,6 +17,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
+#include "dc-dprc.h"
 #include "dc-drv.h"
 #include "dc-prg.h"
 
@@ -62,6 +63,7 @@ struct dc_prg {
 	struct list_head list;
 	struct clk_bulk_data *clks;
 	int num_clks;
+	struct dc_dprc *dprc;
 };
 
 static DEFINE_MUTEX(dc_prg_list_mutex);
@@ -225,6 +227,16 @@ dc_prg_lookup_by_phandle(struct device *dev, const char *name, int index)
 	return NULL;
 }
 
+void dc_prg_set_dprc(struct dc_prg *prg, struct dc_dprc *dprc)
+{
+	prg->dprc = dprc;
+}
+
+struct dc_dprc *dc_prg_get_dprc(struct dc_prg *prg)
+{
+	return prg->dprc;
+}
+
 static int dc_prg_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
diff --git a/drivers/gpu/drm/imx/dc/dc-prg.h b/drivers/gpu/drm/imx/dc/dc-prg.h
index ea11c4080927..a26647784d00 100644
--- a/drivers/gpu/drm/imx/dc/dc-prg.h
+++ b/drivers/gpu/drm/imx/dc/dc-prg.h
@@ -31,4 +31,8 @@ bool dc_prg_stride_supported(unsigned int stride, dma_addr_t baddr);
 struct dc_prg *
 dc_prg_lookup_by_phandle(struct device *dev, const char *name, int index);
 
+void dc_prg_set_dprc(struct dc_prg *prg, struct dc_dprc *dprc);
+
+struct dc_dprc *dc_prg_get_dprc(struct dc_prg *prg);
+
 #endif

-- 
2.43.0

