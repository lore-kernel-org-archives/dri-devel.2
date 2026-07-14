Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5CF6C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 13:59:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C4FE10ED64;
	Tue, 14 Jul 2026 13:59:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cGQelEd1";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013019.outbound.protection.outlook.com
 [52.101.83.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EE5710E6EF
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 13:59:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8YZZuE/8XlMAbUfrkONEBBeTmgxY/syzyduFsIss2eODpx92dJlPJfzDGQLhD6Q0QfzD9jP+Qcvl0pCnaixNJE2WM8FF8BaH/5OUjlFsWh9SNCq6YaNuxLd9kbL2cxMKURPzCVsblpplY6/s4HzBwB5fjD4GlT5mzMsIwI9srgYyxM0g8VEuaRslo3MJYkYkXYVmEf7AbAiUQ5rcIwUldvkpnxZ0vUc10QSjuObDf2yXESe+Bxedaw05noetSqmB/Sn54hX2Lf4MSpw4FWE2hmnJCPFvCWV7y1CNCWspe/gRHRFCeUtnb2mlv6bAvev4H5v4GU4VlBzjcKKR/M/nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJd8KOJeCrmOuwIi1H7RUUzlHeJR0F8Ww7f23Cipsp0=;
 b=oHe/e79+zEvQLkxe6/1iewyoYKL7cnwNNopZNDsQgaVbkITM+YFM235ttUxjYWo0I/F/EnSz++jOGjHHP0lRUf3p4jP9FWF0g4lbk4MgyC8gxRr9Hrn40rjNMBS+1orJfYKVccde6DiZf9m7p61NW9lxbAXUBYEOA+uZ9wmo+x55wOBLUi2X10oA2T8DWOFCFJBvAMKMLvFAjpfRZDvpyVvHlA6OdAc4y/moF1FPrCXHV5eZK7a3Qkbor06huQNttHx1f9+9GJrcYq27JkjProTpyqedljx0SbUCy9nmniebkSNhisqMPtLRBMd+6/4AHMG+x/ueZOvczuSgBfY+wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJd8KOJeCrmOuwIi1H7RUUzlHeJR0F8Ww7f23Cipsp0=;
 b=cGQelEd14Ly44buP4pD3/olWOBn77g2g20+EtgCHHHDbAVM131mxw3dRSK1rcdZvlNDg39+peDPC8HLSqilSH6kTd6z9o9jq5PDe5Tw2ahdLUbp8i+enphYBJG4khKNTaz97gr8jcBeeu32ApmpD2ifjZ1/EYozGI1xbphOpJxm9vwGTuRTTpRtZhxl2eaQYNp4Tu4fBA/28NjrZNFS49QhkQYmkIH8waDwtm+zBi6DUfY2NUgpXclQZdN+bHf8UJLohwB/pxSOltukTpAiu7S6yxfi9l95rDvNulrwtIc111TzGfgklw7wV3Tn+7LhS/9GVDtfkhFRYL+WpWvitOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GVUPR04MB12193.eurprd04.prod.outlook.com (2603:10a6:150:33e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 13:59:19 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 13:59:19 +0000
From: Frank.Li@oss.nxp.com
Date: Tue, 14 Jul 2026 09:58:48 -0400
Subject: [PATCH 6/6] arm64: dts: imx8dxl-evk: add lcdif overlay
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-dxl_lcdif-v1-6-6761a8a6592b@nxp.com>
References: <20260714-dxl_lcdif-v1-0-6761a8a6592b@nxp.com>
In-Reply-To: <20260714-dxl_lcdif-v1-0-6761a8a6592b@nxp.com>
To: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Robert Chiras <robert.chiras@nxp.com>, 
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784037527; l=3794;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=E3cBCZFHvVlN61oX5YXCDAviH/rZK8jt0J/OAROvPI8=;
 b=4DW0X2UNfXf5ShY2mypfasirBq0QT22hSwtlCEXjgThdFpKldJaR9lEDbDGAfyaqGRTHtcruc
 xmArdlTIJ1uCSmh0GXXBYlNX6zc93RF7PfiCuFXw5G/aglBtTP6Tz2c
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SN7PR04CA0162.namprd04.prod.outlook.com
 (2603:10b6:806:125::17) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GVUPR04MB12193:EE_
X-MS-Office365-Filtering-Correlation-Id: 34653b40-8991-45e1-fb95-08dee1b0198e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|7416014|1800799024|376014|366016|921020|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: cwzvVDLo1IT5aZSiPGvDuuIt3KRrOVSvqZSyHi6i+19szW6C6VYvluKCyA98MhR8xbewR9gca8y4UT/hCbOHpTdB2XuyhJtHFBMAu58LZDcHwrWskgOnWIu8v3lhWbDbJnS2brz5K3O0gWLruA7zsnG1hfc9ZzmGRrPWTF5sCoVmGYkxMbbIzMWICOENRSBf/+6P5cGFAXpUOxyaGAxVXKCGH4QnmKIMlyGd+jr+YvV/K4+Mm/PzrVTQeFEU5tmHm3keo178NRT4Xb5tGpIu3z10wUxXisQ190f5LNhOU/xhenk8P/xfQfD9xpjrv0pqMcLwIOWp69DaWvrtNnU2eQCASJB8A68PAkcfFDMaq4agsPrtfFRblB9Xtrh63LjQ84Va8XTUwexAtc2xSpZSPMd0qYGnuj+Rj579Nqib0wvjPEqiXN3YZQJ/qg0KVdJPRWGBKS+Ce5j3bK1mBI4KwIwAR0dVT+ZyvfFM2HO4oDyqwGUCIhQ/hm+6Y1q2NoEi6A0TAxyCis43dXIoF2yY2vizbsTc2sHgJHSJs4pggToTpFP+TUM/DCUb5zx/6VnaVcbfE8+sxwz6zxYNYLd7CeHpqz/CFLYFIExFe30pO83i3dEodoGfiBk/vT9XCXDghGv7rP18J27Rhtdv4a2977jTwPHCwcikKyEN3Z2IzDZvWjosw/GDHizuBr7WuQ/SP+xw7LMJ/UCMfE4/CqCjmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(7416014)(1800799024)(376014)(366016)(921020)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SldyWU9TYjZjQzg0ZDVRRU14VFYwL2w2amxpeVd1QUU2aUJKU3ZjYW9ZdmM5?=
 =?utf-8?B?cjNDOGhXUWp5bEhNTVI3aWJYNFZucjZHdzNNZkxnWEM4aHpEcDUzdWJBM2lC?=
 =?utf-8?B?RlNRYzdVRk1xZmoyS0NsTXlJU1VqRUpkM3RCbUVhTlJXaFE5K0hkUk9Xd0xa?=
 =?utf-8?B?STJyaGw1MVlkckIwZ25sQ09LRUpwOGY0QVdMaU5GTlUwQkcrSFlpYWFsaVdz?=
 =?utf-8?B?QlVrZTdOdHJPNHlnbkJMb0JRcTRnb2EvdVV3VENGVVR4TVMzQnlsWkwreURB?=
 =?utf-8?B?NSs3VFNMcVQzd0VwQkxxRFRIREgzZ1IvdXE3M2E0blJTdXBpY29WVXJ2MmpY?=
 =?utf-8?B?VFlPNzNnTDBucmlnTmMxKzN1NTVpbHdHUVhzNjhOYTcyOExLc1RoMzd0L2hM?=
 =?utf-8?B?Qjk2VHEyZXZkRG5XcTBLMjU0anZONFVVRXVXTVVKNzE0MVZrUDlHRTJoM2xT?=
 =?utf-8?B?b3lQSUhSRXNTcW5DSCtadWVydDViQS9rNkF0dGtpYzduS2NVbUdwbGVuTGhZ?=
 =?utf-8?B?MS9OMnZubVYzWnJ1MmFNb3ZpUVRSbWZKZFdYZnU1Wng5a2MrTkczcTJtY2Rp?=
 =?utf-8?B?Q09hS1o3WldtcXRocmZDRDcwYTVBVjkwWUk4M3o4STNlZkNYWmcvcENnRUtD?=
 =?utf-8?B?T0E3SHU0bkVSQmZYcW5vM0RrUnVuMm5paW9YcWlEbHk4c0lqOExRZ1ZvQzlF?=
 =?utf-8?B?dkUwTmZBTVpZR1JhL0wzWEFXckUvUU9rN1NvWGluTmRBRktabENreG5OOUM3?=
 =?utf-8?B?YURORjFGYnJ6SnRPQ0poYlQ4TEpnWDZNaTFNbWlqTHljZDhsZ3NXYnRPcmJ4?=
 =?utf-8?B?b0hXOWcvSVpaTHg4VzBwRld1QUNBYlMrWDRUeWQ4enFhaHlzWnNWWDZDcE1r?=
 =?utf-8?B?azQzMWFSNmtPcThwMG5LWkdTNTZDYm5pb0J2bEtIa0hzV05wMG0vQ2ZodlpJ?=
 =?utf-8?B?eUdySkREQXhodEQ5MFJrNnk5b3JLL0RSU0o2UVpiK3ZXeG9vRExOU3F2RWtq?=
 =?utf-8?B?MkZKeDk0TjBYRjZ3VVNwaEUvS0w1TkJ1bnNPY3NlN2VZVDRLc1diMlZ5YnIw?=
 =?utf-8?B?Yi9kYStVdHFDeG16bWplbUcrNEZzWlRHdmRERStvUFU4UGlhN1lQYitwSUZO?=
 =?utf-8?B?ZkoyN3JsaGp3VzlBNGxwYWlJMUI4bWlwYk4zbkhoSTJxNzBSbUxUQTQ1OEYv?=
 =?utf-8?B?UmVEU3JIMGlDd3J4azlUL1lQS002SDEyM0kzNlRiNEI4R3RaaERBU1FWeXFj?=
 =?utf-8?B?dUlzZkx4ZkxlRWIwbmduMWQwZWRlR1RxWHhWSVZsZEs2N3ZtWUVZaGEwQnBu?=
 =?utf-8?B?M1lvVWNMRTRNM3Nxa0hmT0NTbHl5clZIbmhSeHRCUWRhR3Y1TXJkbzMzTjFv?=
 =?utf-8?B?Q09BcktUY0tIOEJXb0EvREdnNVNkQWpYNTZ2SzlqOTB0NWFSeEN1WmRJSldJ?=
 =?utf-8?B?V0ZoOXg0TFJFKzdOb0o0dEE4ZDQvZXNoNEJiMWxBZjRVTmtQWjJNNTZRb08x?=
 =?utf-8?B?a0haK2h3T1crNTdJcFNsSXdlaitEZis2VmlMcEtOU3pydXhvdXpjeUlRdExE?=
 =?utf-8?B?UGd4dWZIcFdHZWZUWEJmbXpJNUNzRW5wY0dDbEhJaHpYMXhSc09QbEc2QWg0?=
 =?utf-8?B?akJEOFV4azIzLzRRd2xUdnJQMWhGdTFnWjVrQTZmc1ROR1krTTUxWkE2cTN4?=
 =?utf-8?B?OFNlSHJCZ1hRMkRIaW1HcWROa0I5V3JYVVVQaS9ldkVuZ1VMOXpXWFVuQzg1?=
 =?utf-8?B?V0RudTR1Q3ZiVWYrenYwZG51TG1LalZYS0hUVWVLbGJDVjY5QjUzeW5JcE1x?=
 =?utf-8?B?NnB3UzJJb2FKVHJwQm01cklQWW5JNFd5Q2I2emdadDYvUmhGZzJIQS9tcjU4?=
 =?utf-8?B?L0Z5elp1YUlxOVdvNVhWbzZCd0xNOGw2ZmFoY1pXZVNXUjNMYWE0ejZMT3VQ?=
 =?utf-8?B?MWhMTXgxcS96VlFJYjlkMWsrUGxSY2VZbWkvbmZGSURCdWJ2ZmYvcGUvUXdv?=
 =?utf-8?B?WGZTVmhBTzdtdVF0NStycVc3Tmx6YzMwK3hhcGlEMW5ab1NhRkdSZVRIdFhV?=
 =?utf-8?B?WWdQbWhQWmhaajY3U0xSQVk0bGdvNGJGK3dDMXhET05CMEdrV0dPS011akhm?=
 =?utf-8?B?WEtpS05OVHRhOTgwcUFndlNZOTc5dVpZc2FkWkZQWE1zKzM5UXU3Qm5OQ0dR?=
 =?utf-8?B?azA0RzZmaU5EU25KMktNbFk4aERuclBiS3BVbGIvM2JuT3BSZHpGaXcvZHRn?=
 =?utf-8?B?cVdjNnRhclFyaC94YmRNQlprZ0w5R1N6SW1IcDVsaUdiYUdjU3AvUHl0MkZo?=
 =?utf-8?B?VzRQaERiU20wUkJONjV0OU9WSm4xRURxSGxVOXBYcy9Bbzc3RUVTTHVrMlF3?=
 =?utf-8?Q?tCxfwVlfaou+D+NFetmU8ONECH/rmg9YQUHc8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34653b40-8991-45e1-fb95-08dee1b0198e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 13:59:19.4746 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2dmbwaGHLU4ErVRJAWOPKtA09FnF7EzozlG9r4bfYHvpPxgCAahzRznjjspLvSulVykQW6u8WexCzIAQNeA/xZg8FEy5152qpaKaJ4QBLxJ79fw2XXbHgoGZjOeyFl3H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVUPR04MB12193
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

From: Frank Li <Frank.Li@nxp.com>

Add lcd panel (waiken,101wx001) support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile             |   3 +
 .../boot/dts/freescale/imx8dxl-evk-lcdif.dtso      | 114 +++++++++++++++++++++
 2 files changed, 117 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 8ddaab127ab9c..aef7bc3292484 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -111,6 +111,9 @@ dtb-$(CONFIG_ARCH_MXC) += imx8dx-colibri-iris-v2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8dx-colibri-iris.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8dxl-evk.dtb
 
+imx8dxl-evk-lcdif-dtbs += imx8dxl-evk.dtb imx8dxl-evk-lcdif.dtbo
+dtb-$(CONFIG_ARCH_MXC) += imx8dxl-evk-lcdif.dtb
+
 imx8dxl-evk-pcie-ep-dtbs += imx8dxl-evk.dtb imx-pcie0-ep.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx8dxl-evk-pcie-ep.dtb
 DTC_FLAGS_imx8dxl-hummingboard-telematics := -@
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk-lcdif.dtso b/arch/arm64/boot/dts/freescale/imx8dxl-evk-lcdif.dtso
new file mode 100644
index 0000000000000..c0e573fb5f915
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk-lcdif.dtso
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2026 NXP.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/pads-imx8dxl.h>
+
+&{/} {
+	lcd_backlight: backlight {
+		compatible = "gpio-backlight";
+		gpios = <&pca6416_1 5 GPIO_ACTIVE_HIGH>;
+	};
+
+	lcd-panel {
+		compatible = "waiken,101wx001";
+		backlight = <&lcd_backlight>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&lcdif_out>;
+			};
+		};
+	};
+};
+
+&adma_lcdif {
+	pinctrl-0 = <&pinctrl_lcdif>, <&lcd_0_fun>, <&lcd_1_fun>, <&lcd_2_fun>, <&lcd_3_fun>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	port {
+		lcdif_out: endpoint {
+			remote-endpoint = <&panel_in>;
+		};
+	};
+};
+
+&cm40_lpuart {
+	status = "disabled";
+};
+
+&eqos {
+	status = "disabled";
+};
+
+&iomuxc {
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			IMX8DXL_COMP_CTL_GPIO_1V8_3V3_GPIORHB_PAD  0x000514a0
+		>;
+	};
+};
+
+&iomuxc {
+	pinctrl_lcdif: lcdifgrp {
+		fsl,pins = <
+			IMX8DXL_SPI3_SCK_ADMA_LCDIF_D00			0xe8000023
+			IMX8DXL_SPI3_SDO_ADMA_LCDIF_D01			0xe8000023
+			IMX8DXL_SPI3_SDI_ADMA_LCDIF_D02			0xe8000023
+			IMX8DXL_ENET1_RGMII_TXD3_ADMA_LCDIF_D03		0xd0000023
+			IMX8DXL_UART1_TX_ADMA_LCDIF_D04			0xe8000023
+			IMX8DXL_UART1_RX_ADMA_LCDIF_D05			0xe8000023
+			IMX8DXL_UART1_RTS_B_ADMA_LCDIF_D06		0xe8000023
+			IMX8DXL_UART1_CTS_B_ADMA_LCDIF_D07		0xe8000023
+			IMX8DXL_SPI0_SCK_ADMA_LCDIF_D08			0xe8000023
+			IMX8DXL_SPI0_SDI_ADMA_LCDIF_D09			0xe8000023
+			IMX8DXL_SPI0_SDO_ADMA_LCDIF_D10			0xe8000023
+			IMX8DXL_SPI0_CS1_ADMA_LCDIF_D11			0xe8000023
+			IMX8DXL_SPI0_CS0_ADMA_LCDIF_D12			0xe8000023
+			IMX8DXL_ADC_IN1_ADMA_LCDIF_D13			0xe8200003
+			IMX8DXL_ADC_IN0_ADMA_LCDIF_D14			0xe8200003
+			IMX8DXL_ADC_IN3_ADMA_LCDIF_D15			0xe8200003
+			IMX8DXL_ADC_IN2_ADMA_LCDIF_D16			0xe8200003
+			IMX8DXL_ADC_IN5_ADMA_LCDIF_D17			0xe8200003
+			IMX8DXL_SPI3_CS0_ADMA_LCDIF_HSYNC		0xd0000023
+			IMX8DXL_SPI3_CS1_ADMA_LCDIF_RESET		0xd0000023
+			IMX8DXL_MCLK_IN1_ADMA_LCDIF_EN			0xd0000023
+			IMX8DXL_MCLK_IN0_ADMA_LCDIF_VSYNC		0xd0000023
+			IMX8DXL_MCLK_OUT0_ADMA_LCDIF_CLK		0xd0000023
+		>;
+	};
+};
+
+&lpspi3 {
+	status = "disabled";
+};
+
+&lpuart1 {
+	status = "disabled";
+};
+
+&sai0 {
+	status = "disabled";
+};
+
+&sai1 {
+	status = "disabled";
+};
+
+&wm8960_1 {
+	status = "disabled";
+};
+
+&wm8960_2 {
+	status = "disabled";
+};
+
+&wm8960_3 {
+	status = "disabled";
+};

-- 
2.43.0

