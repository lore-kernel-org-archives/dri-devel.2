Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0B3606A324
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 09:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ItQERvYk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC32010E88C;
	Fri, 30 Oct 2026 09:53:05 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010054.outbound.protection.outlook.com [52.101.84.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 815A010E865
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 09:52:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IfGkmh89Q9iN9U6MkbPKpcfFedVdVhYlJNFJzgFAhjrr0jUZ10TQw+wWXaZ5g0o+Bu0IweVWIVFBu5QRugRIZoNmkno1Css60AaMsr9FD92tkJ7lgu5Zs6ztQcpc1O9xbim7qY0/5au3CUcKi1fejAYV3NpyrPjxF8dprTG+jbdBpyjngrdtI7wCSF98dac7y241cBh7JQc3mi7EA7I85f43rAgOepY+gWPF6NSCpBkI2Ed5o6K+mezqXVzjif6BwEUqxu56hmlqwAO/cUwlC/xxxquNHnXe2nutnqJj1lY4M4FLANGGtAmYV5TdoZ8dOhvPdxR8iHLXf64LyM6jlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHCxTEWDNETUxhv+yZAo1HbpAOGjCmJXlsDreFMCp/8=;
 b=mRrABArCmwOq35kv0zvxrbCWdPoQ+GPTxhJDctPd5HF0RnbnEO/KosTkNBtt0M3BJrPsroyzHD3cdmH7fYcs3vqMqrMZ1oyl9+6MJ24TdYHCjq65Ck2isl1MG0tiFuCkJPHTrxpZ81DmlaUfpHWZu98+ysin9lautTDCybbUCqz/i+s+1XeVhWZXIWumCbsG6vhlbRQWezAS81/uwWAghXdiHUIeHbz1CXvse9Hftzi8F8VkPqVHK1m0lkB0vWfxFwXxZCb2jPvtJfKM04G0Zblq0E6OGELCFRXuNJruz5S8lhm/CRPioIfe6k701Q3lI25khzQVv9i7Y8ez4ODCKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHCxTEWDNETUxhv+yZAo1HbpAOGjCmJXlsDreFMCp/8=;
 b=ItQERvYktdk1oedFNmz00JjUfz6RyMTkZLzCmVnU+m0+cGNHm+9xD2S0tqPusL5spme+exVrX2z8qBEvo1mQadtDTnX2CuUSkLF+P72g4gFfoNTZNVrGddzjTB99HyurXtP46DAQUQaWJdm2SXL/yUVpFqe0jrJvjtvLdsbGJF3z5Ht2KQBOSmCjVVuEza3X3ohbnuh+vCTzaHUF+Sj80ll4tNR2QiSOHKjOU3PZp4yxl74o3HKpv5lXrAPuBxpzs34fKbY+ttr5wsq82Y542Za4/72htmkxn77/e0mc0iFSUZX54dbosujkP/JhT/pUbP9f5dNcFTn0AIUcfL7zrw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by MA9PR04MB839208.eurprd04.prod.outlook.com (2603:10a6:250:103::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 09:52:54 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 09:52:54 +0000
From: Liu Ying <victor.liu@nxp.com>
Subject: [PATCH v8 00/15] drm/imx: dc: Use prefetch engine
Date: Fri, 30 Oct 2026 17:54:24 +0800
Message-Id: <20261030-imx8-dc-prefetch-v8-0-c4f81afd4533@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFBp5GoC/23QTW7DIBAF4KtErEs1/A3QVe9RdWEPULOIHdmR5
 Sry3YsjJbVblgP63jzNjU1xzHFib6cbG+Ocpzz0ZXAvJ0Zd039FnkOZmQRpwILi+bw4Hohfxpj
 ilToO0kUFaLwgZIVtH3m5R358lrnL03UYv+8bZrG9PsL0/7BZcODWaQKVAmqT3vvl8krDmW1Rs
 /zlXla6zLJwE9AH8g251hy52nNf4apwAhEAwTUhyCPXTy5AYIXrwkMKjdKWWkV/tpsdl7bCTeE
 6UouEQXstjhwfHMFXT4eFS0StokpIrT1y++Rle628LbyB1gCRToS78uu6/gDGP4UvKAIAAA==
X-Change-ID: 20250703-imx8-dc-prefetch-028e306591c6
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
 Liu Ying <victor.liu@nxp.com>, 
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SG2PR01CA0186.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::14) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|MA9PR04MB839208:EE_
X-MS-Office365-Filtering-Correlation-Id: d8aba44f-e1f7-48b0-1649-08df366b9184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|376014|7416014|366016|1800799024|10067099003|18002099003|3023799007|921020|56012099006|5023799004|11063799006|261028144727099003|261026140227099003|261026121527099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: HvKEn9vgFGbMB8FiQPFykU58zBRJDIyjNvlbeYDIE+q+m1SIfxO2VGSz7NeQbpFUI5Tkkvson6A4MpaypR6ZfxyVOyKI4jAdKIxxK057fvyffxpBLr+kBN6oDaTrZjz4B4mg9XwtBWer25LUco/uuo+9fcK0jHld20M04oLs4Pa73Ll7rkgmwedW3fRLGKNpvGlKAalcQGYrutd4aWCd2Pdk1f+Cdd4/D2zqxUHm/02fKq3JuYZOGYzHbcKCuAMdzApC1NVEJFgZ66c0TcqgRMxPefKVnLkDCWE2vYzlEDFv+sxhFYogNzX1P114iRQNkchdUVpMtBdBqEivvPQiouYd8uXv9sUzOlJJ+HGVcajxqlpDNtxHpWC3X4PuQ7Bnlc4O4aCPVc1+6UsroaXudocvy3bSbwc3DtA0o3doAN42Dr7FGRze4jDFKYPzzSPvXjAurMNx1iM979xb21xj9aGBK3nONA0utf1T8hJv0qbW+RlNx+9m01LG5z8aA8qCTF0GTp/33D2DtjG4+TMw/q91wEXKiql9Lm0yTnT2tD7L7cURdvBS0kqOUoHvzUGXm/ovpzsh8NGHvqWXjaxV4kMWOBUjWNSGTYnh/HVH1LlZVE5XcTeEHDH+axs7DsilV3OT7jabG7KUwqUtA32o6476oILKu7+gq2gqL+avLOA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(18002099003)(3023799007)(921020)(56012099006)(5023799004)(11063799006)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TW1qSlluSlp2VWRsNUpkSHQveFdGK2sra0RPRHpsWGZtY01McjBla013ZEJD?=
 =?utf-8?B?NHJhZjUwek1HZS9vazk2dGUrSXZ0NCtnZHVtdDFJRGdHQy94TXNGa1RDRm9E?=
 =?utf-8?B?N1FPM3NHQmdISjJESW80ZDhVSFI5TXFsZm5WMGtvQzRPYzNlRG9jNTh1WnpI?=
 =?utf-8?B?bGd5b0RiQkluRVk5a0xJN0dlOUkvSkZXVnlrNG1EY000a2tDczByUUdCU00r?=
 =?utf-8?B?QmJSRklORVVwdnFYSklXaWlKRTJMb3pjZkZwajY5U0xIMUtDSGdzYnZhamdR?=
 =?utf-8?B?M2c5NlJDZVd4RnB1YVJIaEd3VjJaamFNemJRa1FUUXdaOUtFR3B2OGdNRDJo?=
 =?utf-8?B?dWw1bWlzTGw3bFMzVDlodDdVWm5FMnAxTjJjbXptQi9uc3JGSUR5MnE5SGV0?=
 =?utf-8?B?ZVlYZksvTkJXaW4yaW5tU210T2NRbEozZFBzbWxSWks4dGxHWkJWK3R2SDVS?=
 =?utf-8?B?OXU4R1RmdjJBNm5RV0l5WWM2R0h2c0xZK3BqTDFLRytMT3RQVElaZE9WdU9B?=
 =?utf-8?B?cW8zQkxwbW5PZDNOcmhjWE5BckRmS0loQXZHMThZTXdEVEdKRFF2S0lOVXNZ?=
 =?utf-8?B?T1VGSllWaHcyWWM1aHBPSmYyYWdoVG5SYzNYOFR6R253YWIvekxWZ0k2ZHdW?=
 =?utf-8?B?NitLd0VlZDh2MjFCRkhvRmV6SUlNZUFDMmQ2MS9meHFzT0t5eHpIYm40cU9K?=
 =?utf-8?B?NUk1WnNUWVlHU2QyRlRCZ0VIbWFNbjBsWllKdWR2T1VsRVFrMUpaZ3VNenBi?=
 =?utf-8?B?YjNZV0xZbTFlUUZaUExUTHRteFJ6eGhzZDVVOWtwNHFCRDFRNmFEM1BBVkJN?=
 =?utf-8?B?RnFMQjVGdnViRDJCTXBmUGVicC9KZm5ReUlMRk1xZFROdXVJRUYxaUNtQU8v?=
 =?utf-8?B?a29CbnF3MWE2YnhJUHArUGd6RnhYNkRYV0s0bjlPeXJTckJGZGNYajFPeU5q?=
 =?utf-8?B?K29ZSFB5aFh3SjBFZGtwUFAwYTd5S1Erb2w3cXJ1ckpFcUd6VVI1akZOemxG?=
 =?utf-8?B?eHBkZDBlVDlCUEQwcllWRktKTjh2T1VWNXhKNnp6dzFsK3ExclRDSUtIWXVn?=
 =?utf-8?B?ME9zdThWd0hadmtWSnI3Q0d3UUljSGV6dHBiREdmY2ZDZVhKVGNSWi9ScFRn?=
 =?utf-8?B?bGFZZVZoSmJ4WnZVY3FYQmkzSjc0VENHaVo4azF3UW05QmJYWlpNUHN3dFB6?=
 =?utf-8?B?bWN4dVY1RUxvRHA1Mlp3L2VFL1Q1eVE4dzhoSW5aSFhhQ21vaTBhV2ovd244?=
 =?utf-8?B?L0o0U1AyWmRYeDJkMVZrRmEwOVkrN2JVN1hwM2w0L1lGVzRsNnFyY05oS093?=
 =?utf-8?B?aHFiYnNwbU5pcVNoL3hlYjJvZnphcGZmYmdjRVJibC81YlM3cW5XMG10MDdt?=
 =?utf-8?B?cHl3U0orWldrbVZVZngvR1lFaytFQ2Z1dVhrK1VKWi91Y04zYngvN25tT2hV?=
 =?utf-8?B?VWpuMFFZWWJtb09URHlWbVVOUmI0WUljeUdBbGRVOHpJOEZ0cjRRUVA4ZVlC?=
 =?utf-8?B?TFN2bVRMY01SWnhPc0JvQTlGSFQxRzRaamZzMjVnUHlxME9WWGpTMDRzZ1FK?=
 =?utf-8?B?K3lkdnRiZmNXcHhudFh3eU5lOWRBb1EwMWUvM0FGNzlsdmpwVWhMRGoyUjFS?=
 =?utf-8?B?TkFCQ3pESVUzTXRObDhKWnVLR25mVUxzLzVLUjJUN2R3TVJzWmxBempOTVVF?=
 =?utf-8?B?UUhzVW5IT0Y4OURFTkVkRi9sZjdXVWRVbnVUdnJOcTlCa0ZqNWhwVThycDcx?=
 =?utf-8?B?ZmU0Uk45SnMxRTNkWkQwRGhhSGQ4TXk2ay81N2xOWkpOb0h2dFVTNGFmZWJa?=
 =?utf-8?B?OHgydmI2SzdSVzBJaW8wRnpYUFBNZEpxZlFTYVlITGVVdjIzbE5PM3FDREFM?=
 =?utf-8?B?WEFsYTZFSE04RFN1YWZGUFRRQ1FDRXdkQ3p2aTRFeU5KQTlRYk81YW1xTHBu?=
 =?utf-8?B?MERualYyZmU4WnUrcGp0UXQ3ZE9FeEtmdkw2bnpsbGJvTmZlUmlNaFdNbVJZ?=
 =?utf-8?B?bWNqYXlnYVFEOHhCazlHY2p1NVhNRmQ4MDFZeG1rM1dKVVphZWlnVzRPaU16?=
 =?utf-8?B?UjBZTHlQWVpYWExncVhjWmFqVHpYTGQ0U0hLVFZ5MXNHVE5yZ2VXeFdKREdE?=
 =?utf-8?B?SHdhWndvQ0hpZnVWZlU4bGE3M0N5NEZNdHNvYnBNaHRvcnJ2UXcwaDRHb1ht?=
 =?utf-8?B?UXozKzFYdHhrc1hIL0VlQ1pHSHVMYldLMXpUMnZUcXJIRlg3Z09MNUxEL2dT?=
 =?utf-8?B?K2hpNjFNNmVZVTVvbjYza1daSkMzZUdKbFVSV0FjTm9FaVhYUFM4L2xVWXN6?=
 =?utf-8?B?TUNpUExLejUxR3lNQVZXS1dsUUdabk1Ud3hEaVFqNkczUzZSWEhQdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8aba44f-e1f7-48b0-1649-08df366b9184
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 09:52:54.2809 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SLNcAkZfAKND1tNn7xE9B32vuJUqVdOqEpdmT9h5wA/hcbOMiTSVET3+mFgobi94ChpCAy56VpTmjT1h7gFSwQ==
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

Hi,

This patch series aims to use prefetch engine in imx8-dc KMS driver.

One prefetch engine consists of one DPR Channel(DPRC) and one or two
Display Prefetch Resolve Gaskets(PRGs).  It prefetches data from
DDR, resolves data in tile formats if needed and outputs the result
data to FetchUnit(s).  When one PRG is used, a prefetch engine supports
processing pixel formats with one planar, e.g., RGB formats.  When two
are used, pixel formats with two planars are supported, e.g., NV12.

For now, this patch series only supports prefetch engines with one PRG
because it is enough for XRGB8888 which is the only pixel format
supported by imx8-dc plane driver.  Two PRGs would be supported by
future patches.

Patch 1 and 2 add dt-bindings for DPRC and PRG.  They were reviewed
by Rob[1][2].  I slightly modified the patches' commit message to use
imperative mood.

Patch 3 fixes invisible plane issue reported by Sashiko AI bot in v6.

Patch 4 fixes FetchUnit dimensions as related to prefetch engine function.

Patch 5 flags CRTC status in GERNERALPURPOSE register as needed by patch 6.

Patch 6 disables CRTC at boot if needed to support prefetch engine better.

Patch 7 and 8 add PRG and DPRC drivers.

Patch 9 to 14 do preparations before using prefetch engine in imx8-dc KMS
driver.

Patch 15 uses prefetch engine in imx8-dc KMS driver.

[1] https://lore.kernel.org/lkml/20201207165945.GA430214@robh.at.kernel.org/
[2] https://lore.kernel.org/lkml/20201207170206.GA434964@robh.at.kernel.org/

Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
Changes in v8:
- Collect Laurentiu's R-b tags.
- Collect Alexander's R-b tag.
- Fix Sashiko AI bot's comments.  See detail changelog in each patch.
- Fix Alexander's comments.  See detail changelog in each patch.
- Fix Laurentiu's comments.  See detail changelog in each patch.
- Trivial tweaks.
- Link to v7: https://patch.msgid.link/20261026-imx8-dc-prefetch-v7-0-a0b50cc4fc65@nxp.com

Changes in v7:
- Collect Maxime's A-b tags.
- Fix Sashiko AI bot's comments.  See detail changelog in each patch.
- Trivial tweaks.
- Cc Alexander.
- Link to v6: https://patch.msgid.link/20260904-imx8-dc-prefetch-v6-0-26643e3f6cb7@nxp.com

Changes in v6:
- Rebase onto the latest drm-misc-next and resolve conflicts in patch 4&7&13.
- Include "dc-drv.h" in patch 5&6 to avoid build warnings with C=1.
- Fix PRG BYPASS programming in patch 5.
- Link to v5: https://lore.kernel.org/r/20251027-imx8-dc-prefetch-v5-0-4ecb6c6d4941@nxp.com

Changes in v5:
- Squash MAINTAINERS file update into patch 1&2.  (Krzysztof)
- Link to v4: https://lore.kernel.org/r/20251016-imx8-dc-prefetch-v4-0-dfda347cb3c5@nxp.com

Changes in v4:
- Rebase onto the latest drm-misc-next and resolve conflicts in patch 4&10.
- Sort bits and bitfields in descending order for register PRG_CTRL in patch 6.
- Cc Marek as stakeholder of the driver due to recent i.MX95 DC patches posted.
- Link to v3: https://lore.kernel.org/r/20250929-imx8-dc-prefetch-v3-0-c01d0608add2@nxp.com

Changes in v3:
- Call dc_dprc_enable() only when start == true in patch 7.  (Frank)
- Collect Frank's R-b tags.
- Link to v2: https://lore.kernel.org/r/20250923-imx8-dc-prefetch-v2-0-5d69dc9ac8b5@nxp.com

Changes in v2:
- Rebase the patch series onto next-20250922.
- Collect Alexander's and Frank's R-b tags.
- Manage PRG's and DPRC's clocks with bulk interfaces in patch 6&7.  (Frank)
- Sort variables in probe function in reverse Christmas tree fashion in patch 7.  (Frank)
- Link to v1: https://lore.kernel.org/r/20250704-imx8-dc-prefetch-v1-0-784c03fd645f@nxp.com

---
Liu Ying (15):
      dt-bindings: display: imx: Add i.MX8qxp/qm PRG binding
      dt-bindings: display: imx: Add i.MX8qxp/qm DPR channel binding
      drm/imx: dc-plane: Disable plane when it is invisible
      drm/imx: dc-fu: Fix dimensions
      drm/imx: dc: Flag CRTC status in GERNERALPURPOSE register
      drm/imx: dc-crtc: Disable at boot
      drm/imx: dc: Add PRG support
      drm/imx: dc: Add DPR channel support
      drm/imx: dc: Use TCON operation mode
      drm/imx: dc-ed: Support getting source selection
      drm/imx: dc-lb: Support getting secondary input selection
      drm/imx: dc-ed: Drop initial source selection
      drm/imx: dc-lb: Drop initial primary and secondary input selections
      drm/imx: dc-fu: Get DPR channel
      drm/imx: dc: Use prefetch engine

 .../bindings/display/imx/fsl,imx8qxp-dprc.yaml     | 100 ++++
 .../bindings/display/imx/fsl,imx8qxp-prg.yaml      |  60 +++
 MAINTAINERS                                        |   2 +
 drivers/gpu/drm/imx/dc/Kconfig                     |   1 +
 drivers/gpu/drm/imx/dc/Makefile                    |   6 +-
 drivers/gpu/drm/imx/dc/dc-crtc.c                   | 244 +++++++++-
 drivers/gpu/drm/imx/dc/dc-de.h                     |   2 +
 drivers/gpu/drm/imx/dc/dc-dprc.c                   | 534 +++++++++++++++++++++
 drivers/gpu/drm/imx/dc/dc-dprc.h                   |  37 ++
 drivers/gpu/drm/imx/dc/dc-drv.c                    |  88 ++++
 drivers/gpu/drm/imx/dc/dc-drv.h                    |  12 +
 drivers/gpu/drm/imx/dc/dc-ed.c                     |  27 +-
 drivers/gpu/drm/imx/dc/dc-fg.c                     |  11 +-
 drivers/gpu/drm/imx/dc/dc-fl.c                     |   7 +-
 drivers/gpu/drm/imx/dc/dc-fu.c                     |  59 ++-
 drivers/gpu/drm/imx/dc/dc-fu.h                     |  11 +-
 drivers/gpu/drm/imx/dc/dc-fw.c                     |   7 +-
 drivers/gpu/drm/imx/dc/dc-kms.h                    |   7 +
 drivers/gpu/drm/imx/dc/dc-lb.c                     |  27 +-
 drivers/gpu/drm/imx/dc/dc-pe.h                     |   2 +
 drivers/gpu/drm/imx/dc/dc-plane.c                  | 102 ++--
 drivers/gpu/drm/imx/dc/dc-prg.c                    | 330 +++++++++++++
 drivers/gpu/drm/imx/dc/dc-prg.h                    |  39 ++
 drivers/gpu/drm/imx/dc/dc-tc.c                     | 119 ++++-
 24 files changed, 1771 insertions(+), 63 deletions(-)
---
base-commit: cf61bef3801c3c9d0d8c39026b7b2fb242898a3a
change-id: 20250703-imx8-dc-prefetch-028e306591c6

Best regards,
--  
Regards,
Liu Ying

