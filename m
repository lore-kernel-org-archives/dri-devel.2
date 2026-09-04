Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BFBC624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 07:53:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3C2A10E53D;
	Fri,  4 Sep 2026 07:53:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Cx77mw3r";
	dkim-atps=neutral
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010006.outbound.protection.outlook.com [52.101.84.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 831D310E53D
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 07:53:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CkfQi4nSvNoTzLFibIc43HxizHC4SEt8II/34khLFYiZeAOtecLbzLLEBHpybpyGr018ovOXcCRaCIe3xcnCR2B5T6IMBegC80lOjtrQB9/AllQo5/B79oxlFEcamqVtZv1MyL801rVmi/0QoakuZYB8c3L8sdv9vO7b0AjIH6qXzob7Ana8vmzRQtak3Y+PhTovgt1TZKkeB1fzUjgZtWpUocz6LADG5Gvjr3dWd99DFOO0YyCgHTf/YQz4hAEE+qsMSzJN2WMmEoabiv85nZz5gguuPfXPds34xbCHaXfNNo8AhTUDZNp8FAiUBxwQt0iuu2DW3OwmjvUM65X3Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQBhXLJf/mtSdCnXS619NgQtvKBCBFo8xA4px58AiJ4=;
 b=ACxSrRNctMfuvmnnmN/Jx+KznrtHbdFEJE0lf46GWnhsrsfLp3e1EZa0MTgtI7r7UR21Z2wBEHX+lxwpGC+HydTE4aoWEFtmdNJ2iCs9fVI6JilqBxl3+JiAnFhebGIiQLZXADksdMhw4tCccd7Thm4ldpj8cmuDtA/K8DzoSXFyZ81+HtXm01rmNLhkV7k3qWWoZtugZ6XBPkGtZjZQBe0GJN1fVzGxRhLEm3mciqgXO0Uivn7zqeshvHc7ELwVFKHKhUtzVW5WSj48IxBwXNDg3JHcpMU2K/+CMHPkLmFpujN60xgxRTqmiYxDP/OjqbLmemx8TQ3LPBLZKiNemQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQBhXLJf/mtSdCnXS619NgQtvKBCBFo8xA4px58AiJ4=;
 b=Cx77mw3rdFgvHIoOyxDwb6lXO3AQiB7UUabWRUXabYYxkWtWiosJVEihBA1eqSgpdKXkBJ7u1sFIeCFHiCzOkWdomyO1IZwnCQGwPXF4z0TkO+8w9LQduju4MSh9SuBgw4S47/beogL1h7mSM6xsZJ9H2CoAxVvk7d1KBMFgP2sOY5h5JFFYLzYzNfOSeuM6hxlooMH/3dm0omHK/1hUp6jkdb3HmyPCxahucQLNQsLxNQrGedyvZf473NOyAlY4ZI7Cu+2KWSZjQUyPd4qqPMih3uFnohql77HAzbkT/TmMdFnBy2okyOOcZqSKJrSqhdNiqK4oTj0ySOULFc6/ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by AMDPR04MB11702.eurprd04.prod.outlook.com (2603:10a6:20b:719::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 07:53:30 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 07:53:30 +0000
From: Liu Ying <victor.liu@nxp.com>
Subject: [PATCH v6 00/13] drm/imx: dc: Use prefetch engine
Date: Fri, 04 Sep 2026 15:54:50 +0800
Message-Id: <20260904-imx8-dc-prefetch-v6-0-26643e3f6cb7@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEp5mmoC/23Oz27DIAwG8FepOI/JgCHQU9+j2iGxycKhSZVUK
 FOVdx+ptPVfjp+t32dfxRTHFCex313FGHOa0tCX4D52grq6/44ycclCg7ZQgZHpNHvJJM9jbOO
 FOgnaRwPOBkVOFLYu0nyrPH6V3KXpMow/twtZrdO/Mnwvy0qCrDwSmJYd2vbQz+dPGk5ircr6z
 oPe+CXrwi27wBRq8o195uaRhw1uCidQDA58zayfOf5zBcptcCycW64NVtQYerluH7iuNrgtHCM
 1jhxjQHXny7L8AuGOSjmqAQAA
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
 Liu Ying <victor.liu@nxp.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:4:186::21) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|AMDPR04MB11702:EE_
X-MS-Office365-Filtering-Correlation-Id: 2124e034-9584-4c74-212c-08df0a599c94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|19092799006|366016|1800799024|23010399003|10067099003|3023799007|18002099003|56012099006|11063799006|5023799004|921020;
X-Microsoft-Antispam-Message-Info: 7vLlzdEdJzHDOgaLRu7z/lxfIS328YnYe7lGv4c2cnsUNrrH9tZKjA81ZbirZHZFM9dMAhqkEP2Fm4iAHvQJZQ8NsteN2DmEsUJjB1xESkJarCuuYmAQQ8dibcO+aX40k0e//FB107Jj2cyXylvk7OFlyHzcBXiHhM/T/ffZHKZdyx1jhqjoS/88hm+XeO/SIlFeE08FDaNN/kpSYuKmT4VcPZXyleEsEaN//hfkbfDp8DxRosbNM7IVZAfySuxofejoajWkygkwWO5XIn/i5kTMF55hTFU1Fzaq7Qzpvv0LqBlMltb2zhPkDb7A/P2MQxJY3BjQv9LBT2S9gZcJVVx3UUWn5KwmJcwUZpoN+wM3VSbH9s+HBgsShSD7nTzAtVG1ZEKR/b02PTEiupEBcxHwEqoZ7uyiOzXNGQcoqKxaZ+dgh/8NanDKR1A8vp7Dv4eoSI+SmFrdlYj7/f2kTGigaoAh7VyvSEHfpnmGCATjNjhkX3yG0GpCllf3Nv/QnSpxh1hZkMD+Cndn3mgN1dj1GxFJqWXSrU8TStsX/8k2/HVOCondAlN3Oj7XemO2N+XFwH/doVmSl6KmLj4tnX6QwO/P1qmP7p9sYJzuEuAI2tOrKtHns6X/D7y2kO3MR6iMDGZOPTQUdPzPz304QQ+T0WfTFLtdba03LEU+3Xa130yPxgR2aCvgmMFEQ5Sj3aNSMArwZsPK0Fy6+7lscQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(19092799006)(366016)(1800799024)(23010399003)(10067099003)(3023799007)(18002099003)(56012099006)(11063799006)(5023799004)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXFPNG96RVpPRkhGNS9HVUlxQWFtaVh4SUIyS0pCYVFxWFNPT2lycnYzVTZU?=
 =?utf-8?B?Ty9wV0JvS0JLTmRyU2d6SXB4eFNlYm9NemFCVDJBb1gxd3U1QlUwMnNxMkJT?=
 =?utf-8?B?YUVaZUErRnd1RHBsRktGRVU0dThGUS9pMWpYaTJxTnY4RjJLa0kvNTkwN1ln?=
 =?utf-8?B?S0lDZFZZZldtTmhudzBoYzhkZjFONml4ZmoxUjl4NEozcFJJRzlHa2xCcGVO?=
 =?utf-8?B?Z1MrQnlOMm9oeEp2WGZvR1dWVzZOUGxaMWFXVGNHNlAvRDNTM210Ly84ejEr?=
 =?utf-8?B?TndNb0g4MGtzWXpyb3lWS1AzTHMzdnZPbHNqbis2cTFJNEY3TVowU0QvTVhz?=
 =?utf-8?B?bGpxTURPblRiMUxZNCtPKzg3cG9PaGJNYzQyY3AwaUVGSmxjM3h5dEZNVE9j?=
 =?utf-8?B?Ynpva0Mra05BVUJ0RUxPeXUxdm5QWmEwL0x1b2E2VFpQQzUwT2hJQjZLanNP?=
 =?utf-8?B?VEJzejUwQ08xWnZueHdvZ01qUEt2UnVpQ0JHZmhHMC9MZEo0UW9ZblRlR05O?=
 =?utf-8?B?NW1NTktzR3dKMHJubU9yOG4rVm5NVHNLL0gyOW1LcGVrRHBBSkpQZ20vd0lH?=
 =?utf-8?B?cTI4LzZnVjE2YkFDUzNGTzBvY2wyTUp5d1hjQUUyWjliNDJJaUsxeGlCRDhl?=
 =?utf-8?B?Y2g1ZGRvcng1d3NxQ3c3eERURVh0UXkvNExLbXg0b0YyTzl4K293Tkp0aGRt?=
 =?utf-8?B?UHhLQmxpNWpleDkvWFN2c2NUaGFNYkVYMG5yVjhUUVh5aVVTVlRwQjQwbmZ0?=
 =?utf-8?B?YzhoaWttc28vU3FTc3lkV1BGV2VyZGtGYVBCUHNsTkJwMUVhZjZVTVJWcFRV?=
 =?utf-8?B?OTlCSU80azlqUkJDb0c2VS9IcW1DcUxEcVByb0ZZTDZjMlo1OG9nWHg2Nm92?=
 =?utf-8?B?ZGg2VDVaMUhOVTRlRENxaDhKOHkrNHZmY2Q1ditTcHR3bnFTNE9rZjI5YjFC?=
 =?utf-8?B?cDdUMjNKZzlBdEM5SVdvNXlMQ3EyQWVQeityR3lqdWNxUW5KZU01MzFIQmtw?=
 =?utf-8?B?eHd3K1VLbTBrZldVRXcrczVyVnA4d2pFZnBCQkZSd3QzNDc0MkROaVBtK0dK?=
 =?utf-8?B?TEdmUXN6aTVyTnFsdFNBaXpqcVJHTWN3bXZMdGk4clhlc2RzM01jSUtqRWNC?=
 =?utf-8?B?eTZ6VUk2TlE0Ny9WeTl2QXpmcytmVEpoaVdTdXM0eGlqRk8wbWVsVzU1Q0Jj?=
 =?utf-8?B?NTRYOGt6cy9xalAvMlVHSmowWGVFUE5WeCs5VmlOejFqVllsdnJrenFLaC9D?=
 =?utf-8?B?eE40K2UxcG03ZThRNkxnT3JaMWttWW40cytoaklEYUNpV0NtNDByOXAwY280?=
 =?utf-8?B?akl1TFAzbmdOaVNnVm1lU013UzhSMnRyZEl6TkdSYlNmY1Q1WUEyeW1Fdndk?=
 =?utf-8?B?bzhOWUtmenFaajBXNmp0RllLQXVWRXhvak9MNWVSanRpSWRYRi8vMm8zdVlt?=
 =?utf-8?B?WjF2WjRoNnZzM2dpYXRrZS9OcjUxQUFUSUx5MHNPcnFvOHNFNCtibnA3U1NB?=
 =?utf-8?B?WFVzcTN3MlJiaTMvbExyQ2V5SnhaU0FQMFVnT1o1ZzZ2RTBlazBiK1pPM2JF?=
 =?utf-8?B?eHVBMXdpSkdyaUdnbms0NlZwRkY0TjJ4c0Z0UE5VcVVYVmFRTVBPUjJ4ZUxU?=
 =?utf-8?B?eDRHS1JTbTRwenNtY24wZUlSdTliN3IvMTIwNmNrMnNIcU5OTU14S1R3MllY?=
 =?utf-8?B?YVBtUTVqU0szQ0tiU3o0RlMxMmdCMFcyZ0lpdk1Zc1V5S0FvQ1BKRURRcmRp?=
 =?utf-8?B?Ly93MmRqaDJIMFI0MzJZdWxYclhGVHErTTFqeDhIWVNEbUZOOWFpU1RjRHcx?=
 =?utf-8?B?OWpKTkxUUFV6YTVhb3lWZmEyZW1oTjZRbk1qQnp3WmZLSnlZTGhYT0ZiUHYw?=
 =?utf-8?B?dUtBbXZYbzM1cFh3Vk5XZDlLY0pkQzJGRmk3U3dMRVo0T0hMM09CdVI3TzhS?=
 =?utf-8?B?SHErSnVhT2M3Mis0UEcxb1hKcEpqN05Wbmt0K2NmcVVBMDkvQ2Z2cFNPc0lj?=
 =?utf-8?B?anNqcnhzNDlFQSsrajM5aDBPOVhXVVZHaXloU01wNU5ZVlBVWVNxWjhqZHVF?=
 =?utf-8?B?OUJ4dEEwTjRjTDN5V3NSMTVCdWJ0akR3NmxNQnVlS0IwM0ZkSllYRlJoYTVq?=
 =?utf-8?B?ME85cHFya0ZYbFZOc3U4TDhSMlNOTSs0Q2dQTERaZGZwU1owZHJqN21EanhQ?=
 =?utf-8?B?QjcydCtkMGl2VjhTeGZyYUNyYnZhWkRkdStnYnp3cEgveitZQmNkZGw3UjZ5?=
 =?utf-8?B?a0Y3WmxGUXptVXJOOHR3QlVnMVFNclpFaWRjZWljNENiTG1Yc01VK1BPTmt2?=
 =?utf-8?B?MmQrMks1czZUSW4yV1BpdWxjRXZBRjRhMnNZc21JS3puQmNPMWV0UT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2124e034-9584-4c74-212c-08df0a599c94
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 07:53:30.5833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SvvSjeUNd0YLcETI2vMGg13oUuGd4jq6otOqpP8YxxIRt61MrBdPIrB6WIZ1aFEBEmbFaC9BEsi2B9eFA70Stg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11702
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

Patch 3 fixes FetchUnit dimensions as related to prefetch engine function.

Patch 4 disables CRTC at boot if needed to support prefetch engine better.

Patch 5 and 6 add PRG and DPRC drivers.

Patch 7 to 12 do preparations before using prefetch engine in imx8-dc KMS
driver.

Patch 13 uses prefetch engine in imx8-dc KMS driver.

[1] https://lore.kernel.org/lkml/20201207165945.GA430214@robh.at.kernel.org/
[2] https://lore.kernel.org/lkml/20201207170206.GA434964@robh.at.kernel.org/

Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
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
Liu Ying (13):
      dt-bindings: display: imx: Add i.MX8qxp/qm PRG binding
      dt-bindings: display: imx: Add i.MX8qxp/qm DPR channel binding
      drm/imx: dc-fu: Fix dimensions
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

 .../bindings/display/imx/fsl,imx8qxp-dprc.yaml     | 100 +++++
 .../bindings/display/imx/fsl,imx8qxp-prg.yaml      |  60 +++
 MAINTAINERS                                        |   2 +
 drivers/gpu/drm/imx/dc/Kconfig                     |   1 +
 drivers/gpu/drm/imx/dc/Makefile                    |   6 +-
 drivers/gpu/drm/imx/dc/dc-crtc.c                   | 200 ++++++++-
 drivers/gpu/drm/imx/dc/dc-de.h                     |   2 +
 drivers/gpu/drm/imx/dc/dc-dprc.c                   | 467 +++++++++++++++++++++
 drivers/gpu/drm/imx/dc/dc-dprc.h                   |  35 ++
 drivers/gpu/drm/imx/dc/dc-drv.c                    |   7 +
 drivers/gpu/drm/imx/dc/dc-drv.h                    |   5 +
 drivers/gpu/drm/imx/dc/dc-ed.c                     |  27 +-
 drivers/gpu/drm/imx/dc/dc-fl.c                     |   7 +-
 drivers/gpu/drm/imx/dc/dc-fu.c                     |  49 ++-
 drivers/gpu/drm/imx/dc/dc-fu.h                     |  11 +-
 drivers/gpu/drm/imx/dc/dc-fw.c                     |   7 +-
 drivers/gpu/drm/imx/dc/dc-kms.h                    |   7 +
 drivers/gpu/drm/imx/dc/dc-lb.c                     |  23 +-
 drivers/gpu/drm/imx/dc/dc-pe.h                     |   2 +
 drivers/gpu/drm/imx/dc/dc-plane.c                  |  46 +-
 drivers/gpu/drm/imx/dc/dc-prg.c                    | 320 ++++++++++++++
 drivers/gpu/drm/imx/dc/dc-prg.h                    |  39 ++
 drivers/gpu/drm/imx/dc/dc-tc.c                     | 114 ++++-
 23 files changed, 1499 insertions(+), 38 deletions(-)
---
base-commit: a9f09b5ea0c3db1e2d4c0f8d3ebdd612d8aa0366
change-id: 20250703-imx8-dc-prefetch-028e306591c6

Best regards,
--  
Regards,
Liu Ying

