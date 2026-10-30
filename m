Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCF660A380D
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 09:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=BFTgUXhF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5C3B1126DC;
	Fri, 30 Oct 2026 09:53:55 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013026.outbound.protection.outlook.com [52.101.72.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3A3D1126D2
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 09:53:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPbGfgLfL/bVPRRcP8xwMZHDLn4dB51cx95cMpeuZZn7ALNuv8neTL5b4+16DgDCduMlS1/FYG0+0PPxRqmE6oHVUP3VHsiiK8LnhRN+NgGY5xjURks54DG1L1u5aywB4reWFZiAQwBc7iKd5g3OxuXKgs7iOPHhIC6B45pM+rVOmPAznduUelMgkF69/XXlyH1KXkKL5R8D18vxJcJFAN3bOixKU2ybT1vbv5x0h3s4zMdNbLFkozDVuKF3IRGbAeRtlf6kE9WicXDzIyRFdwZ1hOalHFfjkmmAgB7BuStZ9TPh146UMfwVvCNBXo4zoO5A2GBmM/Jc9wtT1io4Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+foQ/P8g6utJLcg7zR3WnBjEkdhuzKVaaZ7Q138Fa8=;
 b=i3a7WmLacJAJ6xQENDkl5OEZ5V3cwEdKrXl68yIHLBEje6wyki8qrMpL6gKpxI3SZNLxrO0HN+SKlbeUP8KiQhlLPOZdEKPZdNkuzpf9Yf2q7UC8/o9sgOzm0ya98Gvdnn9VRtdCya2YBEnwzf2MZKP0ZYyMlpaxezW+0OmJn5aIACCYyrmnKOqE+LQOJjTeXBGlam4DKWXTQwpZ2pZZXF8aHXsVfEaLrnmWcBikUZvIt07yfPjkoBSkfSLU4JiCMY1ROAPIE6PNwnbp3TD8UWwPoNgg88vBwY55LSUeiQv32tdey7l7zBfzxshdOc83Mm5nSFEt8EnadSU+XG/ROw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+foQ/P8g6utJLcg7zR3WnBjEkdhuzKVaaZ7Q138Fa8=;
 b=BFTgUXhFB5V7yj++a0uVAR060+HIpP+XNy8IeZsC7JrIMgdjXMMcMbKM/bU8ATs8c9J06A6Ai/WdZn3StBReStJh7WrPPGgYQ84objfebs+Y4poSoJhXEspZxSLdBiaIlPxk4bcgl1nQlbBL+OWyqTaVWUfOTUUJf312qVnusdasgNKobSaK7dKnm2cDpyaQJ56rotY5P7GGSoi4ATYb6T4WIbe6+n7MqnGQscO0IGXfx5uHfZ+5xqSTpWug490OkEqFqLgWCXKqubqmJJ+rIL/UdRHbRqVENqKGSJWZlsKCyr4vZN1VuQ0Oe91878vrPwurxc2Obaqbz3GlYJwvSg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by MA9PR04MB839208.eurprd04.prod.outlook.com (2603:10a6:250:103::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 09:53:45 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 09:53:45 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Fri, 30 Oct 2026 17:54:32 +0800
Subject: [PATCH v8 08/15] drm/imx: dc: Add DPR channel support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-imx8-dc-prefetch-v8-8-c4f81afd4533@nxp.com>
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
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|MA9PR04MB839208:EE_
X-MS-Office365-Filtering-Correlation-Id: f8426565-3845-44e7-910c-08df366bafd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|376014|7416014|366016|1800799024|6133799003|10067099003|18002099003|22082099003|921020|56012099006|11063799006|261028144727099003|261026140227099003|261026121527099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261009221727099003|261009220027099003|261009221227099003|261009223327099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: Mb7143kpqixmxPRT9TiEGj0pCkuMgiKiTFutdDEPCpYXIHpvGQEvWaps/7he0TumBkOVR9BBEcahvvO6aQLJwGGIBVbyIIO5L5af7djODj7xSPcbUB5TLJ1mBWpCC2yhDTxLZQrtJA027ebJ+sger1Hq8G184c3o87DoRiOoYykFZJjg9zKs0aoR+/g4xtRhrd+/XbUkEgo5qttdw0/ul73/3Kg4YHgo6/sRAJ6l+lNxuC1uOkEbERc3JDpS0bkkZX1kFsAVBX018YnUXM9ZiQUyT1XNGMjPN5setr0LF3Gmy/tUVGF9DSthpCERzUt+/ISFJ7qa78ivOF0z3Vr/CCNh/9T9RF9jovvDzia2Z4B7HqrpWpzlNgwy73wO5t1mowOXqr9ZqUKbkJCveOz/+/z2tlJs5PnROHM8Pszy2CyWUAqyZ5EAnys5/laJIboG7A6ZplIEW91ziqbk3OO89ODSJV4M5S7kUq38PDxC0ajHlrQS95/E2zkWQ0RYhvqbSDwRTcOldWluZQPxIL8oQ59EBmNuKhjUoAfabi7P2sGNTZU3lM17UH6NQRAk3h2fwkNUIeyUE6/t376CE7DEsSrnEvz10hlRtb5sINJvfO6jumFPUBU1vAUmeJfs34Gl0kc9qnhU4IEh3JZXV0bFNP3fQKzP4pFh7olOBfb7nbwnOsejzRUwScIJ0No8Ju/2+HjTek5MPLi/jMJW1MhgHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(366016)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(921020)(56012099006)(11063799006)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261009221727099003)(261009220027099003)(261009221227099003)(261009223327099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFNNUEpwdTlhVmV2OE5scks5UXBXcFEwS3RUc2wvYUg0RjczZ0FjNHBZSXQz?=
 =?utf-8?B?QVVBTGw5RUFibG54Mkl0RGhWSkhYTU1Oc2R1elhReUl4ZlhPeUhwVmJ0UklN?=
 =?utf-8?B?MXV4bXZidWFFUFZSMkpwRVB2QmlIZ0lWTVIzOWp3OXpWNFBJVW9PQjlLOWNm?=
 =?utf-8?B?dHdzVVFvRHFOa0orTjV4TTJkWTFJU0Qwa0h4ZGVIdHpxWGRuWTlhYUdpMzY1?=
 =?utf-8?B?UXFOSHJiZ1ZReDlyd2RzSlczM1BOSW5kZFZXNGVtZkg0TUVWUXJBRUUzREVo?=
 =?utf-8?B?VzNrbGdPaHdQOW1OcXlPTzQ3VENUWEZzYW5hcWdWcVlSY3FXdkVWcnhxa2tB?=
 =?utf-8?B?MnZycDExMHJBZE9vUnQ2dlpnSUMrcGFJSUtGUmEzUzhJMW1RMnJqOEF5YlND?=
 =?utf-8?B?OVV3OWdNN29CZjdkSVU4UHZDWEdzZFR1SjlmWjZNWEh1SkFNK2lrdDVuOUZa?=
 =?utf-8?B?Y3g1aTVtMy91SjdiTFE3U2dOZTB3aGNOdWMxc3V5SEhNTXAxYnh2WHMyc1ZM?=
 =?utf-8?B?NjhzTFllTURVV1RKY0o2MnU1YmZicWtNMDZpOWFobmcrQ1IrWXlmbVFYczJi?=
 =?utf-8?B?ZXpvQWplMnNTMCtDV0ltOHZodnZBZVZIOENmTFEzZGc4WUVwT3VESmVQQlZD?=
 =?utf-8?B?UnZ6UzhsTkFTTEZDR1ZvalU1dkdaVmFaTitoL0d0NWJoQ01tbHMxVVNDL3U1?=
 =?utf-8?B?UlVZOVJBbWVBd3ExV1E5M3VWbmZhZzZlb1VoajRoSnRmMkZ6SnViS2ltaWRP?=
 =?utf-8?B?WkdldmxFdmgwZS9FUHZTbEtBc0xtQWNFalV1V3ZpcHNHUXBEdFpwRGtUTFp5?=
 =?utf-8?B?Nnhnc0ROYXdNTlVZRzNtOWJLQ2Jvc1d5OUxJQkF5YTdDd2Mrc0RDWEw4ZWtS?=
 =?utf-8?B?aG1rbEZlSW82OWhISzV0SWlvU0I3Z1NmS3hKM2RvKzdiZUJoZWtjdlRVYUNn?=
 =?utf-8?B?UnpETkUyZG5xcFV1ZmhDVkZ2UFNIRGkrS2g2d3dXcjFJYkJHNTBPUjloMWF5?=
 =?utf-8?B?U2ZEeUNUeEhMMlc3Z25wTjdOUHpacXVVb1BSRDdsWjA1Wi9YMHFDNC84NFNL?=
 =?utf-8?B?ZFJycWNBYzBzMXIyK3JZU2lCN3NxNlZSZjdEL2hEa3R3Q2o5bzVJVDVOMnQ1?=
 =?utf-8?B?c0w0RlpqNDVWK3pycVRLbGg4WFlKQnpWQWdhUEZrTkIwcEMrU2hmRUtHZzR0?=
 =?utf-8?B?K3ZkSXRVWE1aWDFrZU4vQnd2RWtNWE84QSt5dDkzb09TSTJ3UFMzZEFHendB?=
 =?utf-8?B?bzYvT1lNRmF3amdjUC9ldUJNZDhZRGUwSUhmVWpRcTMxcXgzTWRab21oV2FS?=
 =?utf-8?B?TmI3NDFSUnFIamlPUmtGcm9FcGIyOUNadGsyQndyODk5cmMxWDZMRE1yd2Fm?=
 =?utf-8?B?S2oyazA2QkJPSGNiWkFQOWZMaVhvQXczc3BDSVN3TmFmZklGTWZxVllDazNG?=
 =?utf-8?B?cTZqOHpZMWl6QWhKYzNUZGRqU1J4QVNWVENyQ01ub2NsRHd1N3B4cTVSMnpJ?=
 =?utf-8?B?YmRNZ3NLcDNISlN5Q2sreGEwWEFib2JJeDRocDNvalR4N0laZWxYUlV4SFB3?=
 =?utf-8?B?Y3Z4OE1UTkpRbVRYT3dNVkhJTFU3aGpzQjY2QS9vZ21SaExyWXNwMldhbGdP?=
 =?utf-8?B?SUFYUGRQb2owU3NqalJ5NGdsbkFHdW45V3Z1bjFrdk1LK0o3MU1TaUVVNTNu?=
 =?utf-8?B?NjZLT1VXQnJ5cSs1VWRuWUlWRXhaVGlzeldHbHdqM1hSVkdBaXZpckEzblFH?=
 =?utf-8?B?NC81QUVmbkFCZTF6djdKQXp3YWJZSDZoRFpTTDN3aVIyM1VjZlB3Z1BoVHhF?=
 =?utf-8?B?QnBqREtrUkh1K29JSnNtTkkwM3VXaTc1dUl5S1MxK1RvbUhDUjNzb2h5WW9z?=
 =?utf-8?B?L3JSSHR3QnhxL2N6RjNxSExQd2djazJxK3U3cnowbDFlZmkvT0Rpa2hNelBZ?=
 =?utf-8?B?UTFPc3Y2L0IwMVFiVHFoOTNQWi9CTlhpT0E2cEtVSENWM3ZRYjF5ZlBIZWJ3?=
 =?utf-8?B?Z0FJUkxOMnh5KzJUa2lqb0w4eEZQc0RXam9KSmM4R0g5bFBDT3doOURRVUN4?=
 =?utf-8?B?QTBBRHFaVTk3RE9EcU54RjZnM2lVZkhjUWNBcnFkUjVOdi93NFl2L0RuZEIv?=
 =?utf-8?B?UVlualFmRnhnMXJEQWZlUGxadDZHczVmY1JteVdWL2JaVTQ3c0oxOWh5ZUda?=
 =?utf-8?B?STc3SjFPTGJETlRLM20xTWtFUy9MaEF5VHY4Y0NWaWxGM1dpTFB2M25wRnRN?=
 =?utf-8?B?cnRydDMxcnhDcG1ybGRPU0Naa3hqT0NGZEhCSmRva2NWeHFjdEhmZ09PMmJQ?=
 =?utf-8?B?WTJFakRvd2xYeGN1enFGNHNuQlorN3F1U3c3SU1FQ3RXN0RtL2NBZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8426565-3845-44e7-910c-08df366bafd5
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 09:53:45.2311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nzDPas6cbnnI9mv/GKjbAg7BuvjhyhBJ0Ax+pUUCGb/Q0qlKRBT0++d2rHRc5Y1Dq9eMkA22+OUL12qwKor9yw==
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
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
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
 drivers/gpu/drm/imx/dc/dc-dprc.h |  37 +++
 drivers/gpu/drm/imx/dc/dc-drv.c  |   1 +
 drivers/gpu/drm/imx/dc/dc-drv.h  |   1 +
 drivers/gpu/drm/imx/dc/dc-prg.c  |  12 +
 drivers/gpu/drm/imx/dc/dc-prg.h  |   4 +
 8 files changed, 593 insertions(+), 3 deletions(-)

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
index 000000000000..29188fa72a32
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
+	spinlock_t lock;	/* protect IRQ registers */
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
+	guard(spinlock_irqsave)(&dprc->lock);
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
+	guard(spinlock)(&dprc->lock);
+	regmap_write(dprc->reg, IRQ_MASK + SET, IRQ_DPR_CRTL_DONE);
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
+	scoped_guard(spinlock, &dprc->lock) {
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
+bool dc_dprc_rtram_width_supported(struct dc_dprc *dprc, unsigned int width)
+{
+	return width <= DPU_DPRC_MAX_RTRAM_WIDTH;
+}
+
+bool dc_dprc_stride_supported(struct dc_dprc *dprc,
+			      unsigned int stride, unsigned int width,
+			      const struct drm_format_info *format,
+			      dma_addr_t baddr)
+{
+	unsigned int prg_stride = width * format->cpp[0];
+
+	if (stride > DPU_DRPC_MAX_STRIDE)
+		return false;
+
+	if (!dc_prg_stride_supported(dprc->prg, prg_stride, baddr))
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
+	spin_lock_init(&dprc->lock);
+
+	dev_set_drvdata(dev, dprc);
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable PM runtime\n");
+
+	ret = devm_request_irq(dev, dprc->wrap_irq, dc_dprc_wrap_irq_handler,
+			       IRQF_SHARED, dev_name(dev), dprc);
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
+	guard(spinlock_irqsave)(&dprc->lock);
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
index 000000000000..45b0f1d3dd6e
--- /dev/null
+++ b/drivers/gpu/drm/imx/dc/dc-dprc.h
@@ -0,0 +1,37 @@
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
+bool dc_dprc_rtram_width_supported(struct dc_dprc *dprc, unsigned int width);
+
+bool dc_dprc_stride_supported(struct dc_dprc *dprc,
+			      unsigned int stride, unsigned int width,
+			      const struct drm_format_info *format,
+			      dma_addr_t baddr);
+
+struct dc_dprc *dc_dprc_get(struct device *dev, struct dc_dprc *dprc);
+
+#endif
diff --git a/drivers/gpu/drm/imx/dc/dc-drv.c b/drivers/gpu/drm/imx/dc/dc-drv.c
index 8e1e495f1992..9fbc588cd09d 100644
--- a/drivers/gpu/drm/imx/dc/dc-drv.c
+++ b/drivers/gpu/drm/imx/dc/dc-drv.c
@@ -349,6 +349,7 @@ static struct platform_driver dc_driver = {
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
index 46108f7e09af..82cf8170eea3 100644
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
@@ -226,6 +228,16 @@ dc_prg_lookup_by_phandle(struct device *dev, const char *name, int index)
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
index 6fd9b050bfa1..f29d154f7de5 100644
--- a/drivers/gpu/drm/imx/dc/dc-prg.h
+++ b/drivers/gpu/drm/imx/dc/dc-prg.h
@@ -32,4 +32,8 @@ bool dc_prg_stride_supported(struct dc_prg *prg,
 struct dc_prg *
 dc_prg_lookup_by_phandle(struct device *dev, const char *name, int index);
 
+void dc_prg_set_dprc(struct dc_prg *prg, struct dc_dprc *dprc);
+
+struct dc_dprc *dc_prg_get_dprc(struct dc_prg *prg);
+
 #endif

-- 
2.43.0

