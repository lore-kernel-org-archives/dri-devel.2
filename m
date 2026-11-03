Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB81C606A32C
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 06:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=j5yCHj1N
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F280310F37F;
	Tue,  3 Nov 2026 06:20:36 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013018.outbound.protection.outlook.com
 [40.107.162.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A45C610F37F
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 06:20:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u46+zMZ6bC4pFfh53HqyC+jh/gUpaDRB71kyFudW5BIcsN5wjTj4cCOA9R/OlBKrE2hdlMmML/O6NlZO6kP0xLIsFGhDxRhR8ZyqBtmYN65Jn/GA+JWRj32SblL6XpB3IHRjzFuyEyppGRVtoL897MGPgqVewnY92MEZliZ9aFAJXpGvnyC5tGklR9buOxw0tXfXOS1ik+awzu2W16c2tv9WZpcequKvEjFEF75C4tkJYupl9l1Cf5eH9aGJGpjtIgWPancQL11UNK+LBiEX6HqMcLVVyuYaTShAPATYrQitgwaRhJaeFklD3ezqdq8lTaFvrWSkOEkmFYF3Y0QpGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BrT+Cse4O5JjOHGQRmccsr+7HQd7LlAZt0gREuIMI8=;
 b=DVzxrOU9eIG0gYQeBuIkjcnbqQbLfLLbBRUKElS9DMCceKPlmqrDFSAyHRDyxGYKJeA27vNmY5uwai5hBGdcKgwJgKVzrvhK85p+WfGrrjLt5cD00L2337YMDmY48qL1P6oe+ISFoemQ9uFIzId7SKwxJETz7KzE/YfI2FWPxhv7vsquXacI8wsYgFUs5eKPahwLpROpZFhXvSyeg7ujOpsuBvEWMfZlkipHrcezVEYydjSAXpRuyK/lg0YKatEFa6RFITzwCzAORr5QkROMFIVe8fSiOwcfKtDgd1v/Zi2QN7aqzZ/5Dx398lpOqPL/RiP4RuvuoxmjODDh2lxyjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BrT+Cse4O5JjOHGQRmccsr+7HQd7LlAZt0gREuIMI8=;
 b=j5yCHj1NqpAWsc3OV1+gAYin/wv0JtaMiwTl5WxuLcqzd/MHoY8weeh5ci4xnJc3sJMie2SEsG1JYvMMD5iwp4ikFnR/caI6gyQWSpYi3MF6cTnhIUqVoC/VOWcIsvGoXPsZDQUT37ve6fa6n9MG5lUeM88owtR5QG4cHLTDGPYQUVaDocBBBhKmdQSHqlX/zl5FBf4vcnNtrbSuLj+aZ54VqbKrWp3w7c2bnIwHaaLRkBmxZPS/Q+0OW8x1/FGqowhQMLB5kr6/xxVTKs6hGT8PN7iy2cB2BIrHPly4/m27AXNH5WOoYp4DohVbV3ZdDJSybV8OfhsBFZZZm6KB6g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by AM0PR04MB6993.eurprd04.prod.outlook.com (2603:10a6:208:17d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 06:20:26 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 06:20:26 +0000
From: Liu Ying <victor.liu@nxp.com>
Subject: [PATCH v9 00/16] drm/imx: dc: Use prefetch engine
Date: Tue, 03 Nov 2026 14:21:56 +0800
Message-Id: <20261103-imx8-dc-prefetch-v9-0-3b985e7636e2@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIR96WoC/23Qy27DIBAF0F+JWJdqgGGArvofVRf2AA2LPGRHl
 qso/14cKQ+nLAd07lzNWYxpKGkUH5uzGNJUxnLY1yG8bQRvu/1PkiXWWWjQFhwYWXazl5HlcUg
 5nXgrQftkgGxQTKKy5aPM18iv7zpvy3g6DL/XDZNaXm9h+D9sUhKk88hgciS0+XM/H9/5sBNL1
 KQfPOhGl0lXbiOFyKFj39s1N888NLipnEFFIPBdjHrN8c4VKGpwrDzm2Bl03Bt+2W6fuHYNbiv
 HxD0xRQyo1pxunCA0T0eVayI0yWTi3q25u/O6vVXeVd5Bb4EZM9NLef/EDTS4X06H2asuR7TGP
 PjlcvkDicNgpGcCAAA=
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
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|AM0PR04MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: c5363f64-ee6b-4ac3-cefa-08df39728ce8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|7416014|376014|366016|1800799024|3023799007|10067099003|18002099003|921020|56012099006|5023799004|11063799006|261022105027099003|261022075727099003|261021123027099003|261028144727099003|261102123227099003|261021121427099003|261026121527099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: Bk8d23cw5utGJ1JnX/j+KN7ChZAPcmsCPe9pfSaDJurgdeKpJa2RFL7KbpJ1MwWykXaYEV89GKyX3wazMWJXRUQkhXlahSgjXfZNSevtvKCNXUuI0TT+zYRoIhjOyRL9RXLCJWuruVf0IVFNHN3n/kjmHRX+wWsIU1L8rmwRyxsopjKjnlHTjns45bsMnXlpxkuGKQ57AHlEEIGdXD9nstFw3ZaAVaa80eWXmGbZJAQRlej/xrI0wfo/BUoel5ZRPIAImN2msNBgA7Rwrg7o0yxkYv0H/7w/bhoTfXZ7teNO7kXeEvE0Gyiwv1NekxYYWSPKzSfKzbz96YNcmjE70VC6PC3m6WnbwN/70SUhoW0aOYXfvie95pR+ZfEeQe6mPK6CYii8uIdFdVNF0QkUgsQWe8/5IIzcPDxgKi/gQZn3+i0aVJTIIgxde4afvs1mOc5zw2yasTIWNpvx9xfNAv8XfQumTK8cxdOA8dHckD0mqIZdPuaWJJsZH7/wDM9taH4OdhfUBC7Kc5iTyJa8lsPfkVKD55OIJJxR/4PeuXMv//Kz9cbcxPG1mBUwtWTExkeN5bBjvnThHIyKg/2GH1rU1U/AS6ovm6ekPKz44oSItAEc5bjNFqvs6F1toSe5j6ic/IazqLhBANPjihQZ51Bsf0/HlIh/cfEu1mJiIag=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(366016)(1800799024)(3023799007)(10067099003)(18002099003)(921020)(56012099006)(5023799004)(11063799006)(261022105027099003)(261022075727099003)(261021123027099003)(261028144727099003)(261102123227099003)(261021121427099003)(261026121527099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHdpaTFoUmZLZHJDRVBocTlkTmsweTd0MmFCc3ZFcEcyU3lTcmFrRDJmM29p?=
 =?utf-8?B?RkQzRFNpaHprb0NxdmQrVXVZMGphRnBGOGVVUzhzaXJLaXNqNk0rNjRhQjlj?=
 =?utf-8?B?Yi9WUmVKK2ZQUkhhY3Z1VHVraE9FdEdmS2xMSDRQVVJqODRuMDZoSE1zNjRH?=
 =?utf-8?B?Vm9DdkhRSVNJSkMzSG50MzZrclI1bnBPblFRWGtaOWd3TzBBcGxXUWs5dlFi?=
 =?utf-8?B?bEkzNVkyNjVsOVNCa3hYLzBpNUl2SjFXdjFLb3MzOTY2bDVlWUhPeEs2VGY1?=
 =?utf-8?B?OXhJSTZ3akhLRFBXUE1kajhPc0NXWmlraE8zaWxKTGRoRGgzWFNWY0Raemhx?=
 =?utf-8?B?Rm5CTU80UVRJZ0VBK2VmKytiZHFFaW1QM1J5eVBiMjVGVkhZMXBJVUdBNE9m?=
 =?utf-8?B?SGNoWTFUWlpvWnRxYTdyNEwyTFFOSlpGck9PM1k2cnFTSUJEM2dSa0tJcXlR?=
 =?utf-8?B?MGYvc0RnV2c2ZEpwSHVYV0ljRlo1UHNzdFd3Z1lQTFU5NEJvdUovMnFQekFI?=
 =?utf-8?B?WkY0bWZ4clRaT3YrdmxzVXArVjNDajN3WmZkTXJUOTVkdFhyOC9zbTY0aHNI?=
 =?utf-8?B?WnVsREZlQmNQY1Q4SWJDbXVyNVFPNng5R3dnSi9INEM1QmtLdGtUZjhaM3Rv?=
 =?utf-8?B?aGExajJ2K3E4eWZzYjFzS083b0VVcEloQU0rRDF3b01jV2d6RDg1a2ZMTnZ6?=
 =?utf-8?B?eHpsYTJCT0w1Uk80SXpiUHI4d0ZoeGNxZHFTelRYblBSN1pFVnZkMjhyako5?=
 =?utf-8?B?RlJkS2t2QytRRlpCcWZSVjBlVmk4S1JsQTJwcVYwZHc0SGRNQTNuV1dIeCt0?=
 =?utf-8?B?YWk3Z1ZtTkZjek1mTmo5bWhPaTd0Yzd6OVNoMWxrMXI4MVRadldyeUQ2OGZh?=
 =?utf-8?B?ZWp3MzlzT0ZJWEVieGVGaHlRc1VZQnN3VzMyQUdjelFBWm01T2w2OUpnQzBi?=
 =?utf-8?B?UFlTZVpQMXBNQzBTR24wVGpHb1hhMDJUYnVwMUo4SWRkcWRpN1ExcmJrQmVO?=
 =?utf-8?B?SWRTOWkvaUwyZ1ZlclE0UzcwK2NsWGIxQXlDZm8vVytPVHJpY2pLZWdIOGJl?=
 =?utf-8?B?LzdMbkFJSHQrWGZJaklwcEZiWmxyWHJ2VXRGc3JiQmlBRGFsdUZRR3B1em4y?=
 =?utf-8?B?N3hld0oxTVppdDRpb0d4bnpvR05qR2Q5cXcyN2MyVFltZUFwNVRVdjF3T3NQ?=
 =?utf-8?B?YVorSENNY2FTVmpYZ3dtVTA2Z3Q5b05VWnovV0s4Y1hJRTZidkk3N0ZGV0li?=
 =?utf-8?B?bXdnVmM0OEdTeVl0VEhxcVRodTh5KzVzQXJvLzVIUnFZS3lXVEZoQ1hReFhm?=
 =?utf-8?B?YUw1Z1NRUmoySU9LbHR4ajQvbE1mRFRyVm51ai8vNzMwYU5OazRBUUFoMUFB?=
 =?utf-8?B?WUFqME5vUGFwT2xJSGtrWTJ6NEhtVndac3doRFJMdm1iYkl3Z2U0ZlMyRXM2?=
 =?utf-8?B?Vkt0Z1ArV3Q5OUJDTXdxaDl3UUo2TjRhSFZaYUFqMlVYLzdONlVtd0V4c0Vn?=
 =?utf-8?B?RG1EQ3k5Q25XMno5eEJSeHFBSGV0TlVNRGszbDU3WjNHVi9NanFzTk5aRU4x?=
 =?utf-8?B?UVJBRGtBRW9WZlZrcUUzZXNteVJGVFlndWw1THNIaWpsb3h1SlVDd1RVWUQ0?=
 =?utf-8?B?RnFEUzhZcldJMzQ4VFRCZ2NvRVAvMyt2VmI3OHVZSlYwQkduaUlEdkpGSEQw?=
 =?utf-8?B?bWRjamZqVWxPR1hSSUc0MzhZazhISmFHTmVWb0hxZEV4aEtsUk1wQng1ellh?=
 =?utf-8?B?R05VaWpEeUx6Z1JXYnE5T2xDUEhXajM5MUJVTG9TdWJUM2F6OXg1OHI3ZDNt?=
 =?utf-8?B?TWZhdmtYT3BHeEdQc2tGKzJkNUc5SGUycFQzNHc1LzRKbUVOdnBNejllMUJY?=
 =?utf-8?B?UVpidUJ6R3JSTkp6b0I0OCtuaWRHRngvb09NQ2ZLbS9oT3pJbWtZaTREa2VL?=
 =?utf-8?B?TTlPejg1bFVBaUk2MHBMUkZGcFVqYnBPdHhXVDlObzZJNTRoZnEyQzFOT3hw?=
 =?utf-8?B?bkkyWlYybGJmTE5qNVIvSGhDMnNhcG5oOFlPanBCaXJmRjRzTDNoOERhb0FI?=
 =?utf-8?B?UXNmOHBnVDZkZENMUHNkSmRTd0VVcGV2OUhnS1VxaEM0dnJQVVhHSlBVTTJ0?=
 =?utf-8?B?a2U3OGFXSFlKd3FHcEtEVGVzMU1YemUxZ0s1bWxWK0RrbjJrTjc2K3pPa3ls?=
 =?utf-8?B?YnhOd2N1NCsydzFsTEtrbnV5TmtZSDJjcTJFK090YkUxczBPeTVBNWpxU2FK?=
 =?utf-8?B?V01FTGVVckRlT1liZ0MxTzE3NHpvZnRNSUcyS2d2bXlNOENlaExJRldQQ1FH?=
 =?utf-8?B?NG13ZlpQakxiTHExTHY2Ly92b2tRMnRsYm9rNVNoRHhmOWk1ekMzUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5363f64-ee6b-4ac3-cefa-08df39728ce8
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 06:20:26.5603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+/L1+YIazIC9xS11D8iM8MdM6DU+GgNp2Nj9ldPIur1Ra3TDjrAr0zuSDaxKmSMe3gYwSZ6uKbFRxhxgTDGIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6993
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

Patch 4 fixes runtime PM issue for register accesses in .atomic_update
and .atomic_disable callbacks in dc-plane.c as reported by Sashiko AI bot
in v8.

Patch 5 fixes FetchUnit dimensions as related to prefetch engine function.

Patch 6 flags CRTC status in GERNERALPURPOSE register as needed by patch 6.

Patch 7 disables CRTC at boot if needed to support prefetch engine better.

Patch 8 and 9 add PRG and DPRC drivers.

Patch 10 to 15 do preparations before using prefetch engine in imx8-dc KMS
driver.

Patch 16 uses prefetch engine in imx8-dc KMS driver.

[1] https://lore.kernel.org/lkml/20201207165945.GA430214@robh.at.kernel.org/
[2] https://lore.kernel.org/lkml/20201207170206.GA434964@robh.at.kernel.org/

Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
Changes in v9:
- Collect Laurentiu's R-b tags.
- Drop unused function arguments from dc-prg.c and dc-dprc.c.  (Laurentiu)
- Fix Sashiko AI bot's comments.  See detail changelog in each patch.
- Link to v8: https://patch.msgid.link/20261030-imx8-dc-prefetch-v8-0-c4f81afd4533@nxp.com

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
Liu Ying (16):
      dt-bindings: display: imx: Add i.MX8qxp/qm PRG binding
      dt-bindings: display: imx: Add i.MX8qxp/qm DPR channel binding
      drm/imx: dc-plane: Disable plane when it is invisible
      drm/imx: dc-kms: Use driver specific .atomic_commit_tail callback
      drm/imx: dc-fu: Fix dimensions
      drm/imx: dc: Flag CRTC status in GENERALPURPOSE register
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
 drivers/gpu/drm/imx/dc/dc-dprc.h                   |  36 ++
 drivers/gpu/drm/imx/dc/dc-drv.c                    |  89 ++++
 drivers/gpu/drm/imx/dc/dc-drv.h                    |  12 +
 drivers/gpu/drm/imx/dc/dc-ed.c                     |  27 +-
 drivers/gpu/drm/imx/dc/dc-fg.c                     |  11 +-
 drivers/gpu/drm/imx/dc/dc-fl.c                     |   7 +-
 drivers/gpu/drm/imx/dc/dc-fu.c                     |  59 ++-
 drivers/gpu/drm/imx/dc/dc-fu.h                     |  11 +-
 drivers/gpu/drm/imx/dc/dc-fw.c                     |   7 +-
 drivers/gpu/drm/imx/dc/dc-kms.c                    |  25 +
 drivers/gpu/drm/imx/dc/dc-kms.h                    |   7 +
 drivers/gpu/drm/imx/dc/dc-lb.c                     |  27 +-
 drivers/gpu/drm/imx/dc/dc-pe.h                     |   2 +
 drivers/gpu/drm/imx/dc/dc-plane.c                  | 100 ++--
 drivers/gpu/drm/imx/dc/dc-prg.c                    | 329 +++++++++++++
 drivers/gpu/drm/imx/dc/dc-prg.h                    |  38 ++
 drivers/gpu/drm/imx/dc/dc-tc.c                     | 119 ++++-
 25 files changed, 1792 insertions(+), 63 deletions(-)
---
base-commit: ea74b623855291e60835c0f7fa7a29673332ad41
change-id: 20250703-imx8-dc-prefetch-028e306591c6

Best regards,
--  
Regards,
Liu Ying

