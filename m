Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFB4C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:38:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92E2410FB86;
	Fri, 25 Sep 2026 16:38:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hRa93mbv";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011058.outbound.protection.outlook.com [52.101.70.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23C6910FB79
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 16:38:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H8v78R6m1CWQuqD+fgNADscTDH6a4x8rw3r6Vpyw9gBfAj9HqdkeZfOQNkog2ba1gTHNPg9lsrA/AEYrZ+c+tlLREvtnjbuyGrOTiNmuTa0dPZCHY0t6KXzINzhf0MjnZDz6+Q2NhhSgvlhADhWQdV+W9f9CLOUIi9h8gN0AbW7QDy0QS3ivuXjcQW7dTHjqHG8jZ6TlXn9i+4+0fcbk7oq8nE2kkjte9z4ja+wJ9Lh5GurwKQGwaK6QuapngSGFm1Bd3Kh+qCkNnJP5qtCt5lVGsuknzSWFcvG1WC0lhEHrxawivy00aUAt+OdsIageEl5Fq3hSAkQEPdWJ6MTNwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhkAP2LeKywPckto7jEE6mmpb9gohcBu4bdcvXsbfqU=;
 b=XMyDQjUalgGSEVdU9inyetL2dJ320c1fcqk5gcEuURpsPG9/axit+Ebb7UgaZKx0BsiZP1pVbXkaBM8+S1f1XuFcgJA5cXUbkO7y183aVGdPHyEx0AJS/Nw5lJ+kH9L6d7yKqiprpqQcAD4sOZuoS5wijytasztXh6q80c7a1x0Bp+uVNW/9JAub30qjm/uX2C7A9xImntzZOLeCLBSHkkAftEKuv1j0qhTOlOEbO16vn9COeWwFpptepyRkK/raJbzl3l8HcNnK4K9/U3iOFcxlnylQozuk054Y6uW6cla5mRGa1Si/1Y9DsQptMMCGDWjuHMOuiTQvKZ94daDl9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhkAP2LeKywPckto7jEE6mmpb9gohcBu4bdcvXsbfqU=;
 b=hRa93mbvZ2blKSmP2LKhTMnmgcAzK/2KWEWJEGoa/V+zajS/Bxi3rYAHKw76azAwfj0AJCrR0lEPkdbvP4H1rxlGW1AmTSnadpQFhWNTlCST1slgwvFzPdWiaGUCd1vCaWR7K4r5ezcvpEiN9LkNKrnnB6pWD1mVHdHVqNixlc3lsaQceWAiRDA++gHYtctNX3oTzpe/t7IgoKm7bwZOSc9WPt3FU2QEt1TnDgdH5IC7hWg7p0Y/ZFDICQjhi08lybwrDGyNlI0664ihm69L3yaYsKgj476tGpCUSUiW/3eOyLW+Hchk7+PXYsSvpPlUgGjjIDMRjo74/+XXX0EKzw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AMDPR04MB075100.eurprd04.prod.outlook.com (2603:10a6:20b:749::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 16:38:24 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 16:38:24 +0000
From: Frank.Li@oss.nxp.com
Date: Fri, 25 Sep 2026 12:37:54 -0400
Subject: [PATCH 5/8] arm64: dts: fsl-lx216x: remove #address-cells and
 #size-cells from pinctrl node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-cleanup_dtb_warning-v1-5-f999fafbca60@nxp.com>
References: <20260925-cleanup_dtb_warning-v1-0-f999fafbca60@nxp.com>
In-Reply-To: <20260925-cleanup_dtb_warning-v1-0-f999fafbca60@nxp.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Guido_G=C3=BAnther?= <agx@sigxcpu.org>, 
 Robert Chiras <robert.chiras@nxp.com>, Tim Harvey <tharvey@gateworks.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790354274; l=1135;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=lgX4DSVfNJF1xO6kh/Ie5H2c4YGjgIiMjFErMMX552A=;
 b=c5RoZh8Us4RjpiPXRqEJk2ozt8xH5RA5zbDgZGWw0qzJnfCJA+bl/oO/C2McH9Xye751550oB
 CmmzlGKhqWyCqKfbIYABwgF3b+9THval2+eexiafXUlTZhTGt5Tg1t9
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: CY5PR13CA0013.namprd13.prod.outlook.com (2603:10b6:930::11)
 To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AMDPR04MB075100:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ed2c8d2-de5f-4e53-3839-08df1b236b05
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|376014|7416014|366016|1800799024|260925021311599003|260925021911599003|921020|10067099003|22082099003|56012099006|11063799006|18002099003|260925022911599003;
X-Microsoft-Antispam-Message-Info: Q/pRlAazRrbtTSezjuEIW7lRnYfxtCQ3NkqWXJCTaLN+Xsx0eATH08Y5oqhJISXyrhv/fO4Iyim0dFEBuXFjYlQZ0pVot20xiqcwDP+FCa1l205B6Ag/a76sYiDow6au7UloGyz8bFvOG8asfrQVPwgB8vDKmV2/yer8pXQJVWi7nMGt6l+WCOATt3JPtALirc4b6bLojDqgKW9iqNGUCfy95GcMgOBBfeREWMu859XzioezJiYj1qpnMjxUBAFGIvGaKA7oFeQTyZjEdyoGSl0z+mHd/tuSU/AUDENYg8+3JiykhdA2Zsh0bHT65lUgx3R8FkInddhFA4hh5EP0r7i2Zk3+m21NCX4Ccu7VGxSndJvOG3pToWPublLmGerAML6mcwQ2QmX88ZG28cdob9JYfnLT2lST2cbfl8VNkBrsf2BpHHZxm46zjoiLQGUxabee84LXDxfBDngnCLTV/G5Cpv+jXOGSU1UN4BecssrwXCb+KV1nIP1vkw+P6mTTaPNrWLragIOrKb/I1TgfIsWzi/lGEo4fMrdc6YOk3yvD5i9dgNTfSlMgvgs+LS0FpA/C2wlM4dnwrm6A+vAdcfgNkiHywDR6CtRuFAhTMSCBprS7n3YKR8ZPb0wGXH4+yZtzSvsZFzRGMCf8NSKb/rlQfNIaNDLrjw51CdrsHmi45s9xC0igDLD3h8YeK7P3yCINQMMaMilJbaTCYG3Qrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(366016)(1800799024)(260925021311599003)(260925021911599003)(921020)(10067099003)(22082099003)(56012099006)(11063799006)(18002099003)(260925022911599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TldUdlQ3TkhNdkFLVllDNjU3NUhWRXFQN3lHZGg4Yjh6SU9VaE02SUhIYVlk?=
 =?utf-8?B?cnRTQ0t1SzB1dWI3akZkdXlCazZVOWFKUGc1RzRDc1dtQlEvcTkwR3R0U1pm?=
 =?utf-8?B?Vkx3N2E1TmxOdm9LV1NYTTFCK0pJZUxyR2ZVOXZBU0dBb2ZvcXZtNmszanFO?=
 =?utf-8?B?RjJJK1U2UVp5WG1SUmxiUzAxNlhOQkh4R2pkZXNRTDlmeEQyVmFGVE5HRFdT?=
 =?utf-8?B?SFNoUWhVLzhBS2h3Z1djTURKc0d2V0JtQy8rbTBHQlc0MmlxYm9mOHd2ODU5?=
 =?utf-8?B?amNCZWNrTlVIUU5ZVUwvcXJTTnJoek5vUXNWVXMwbjdKdnB6YVFvRFlpdTRi?=
 =?utf-8?B?c0h0R2U0UXlVaHFyTWp0WmZGeXE5ckZXeTI2a0NjNWozSU8wY3NNcm9ON3Iv?=
 =?utf-8?B?OFRkZCtaMWpkZ2lmN0phUlJuQXQ0eXBYNWZIZkRoMTFCQWY5eURZQTBLMi8y?=
 =?utf-8?B?aFZTRlpQWGZ3Z3hJSkN6Mm1weVFGVUlKMk5mcms0T25PanJ3dXVBNGdHUTl4?=
 =?utf-8?B?eTBiM2lhR2JiK2M4OUhveUJJRVdLYkxWUlp5bnRpWkZBcEdLU1hJR0h5OE1m?=
 =?utf-8?B?RWZNTm5KZytUQ1RObDcyRXdKd3R6S1UzZjRxV3NITDIwOUhHWUpqNW1SZWpJ?=
 =?utf-8?B?OFlRK3JYOEZhbGNZYlpiYTBLb3dDdG5JLzF3eU1TUUFLbUpVSUFlSVNTeTl2?=
 =?utf-8?B?bXFsMk1lc1pkdGRqampJV1doVHFlb1FpOWIwSmdleDNOZnJXRHZMdXA2Vm1y?=
 =?utf-8?B?Y1lrYnFvVGttWmFweDNyWGgzYUlIVytoUmdvLzRLUGx3RU9YdENUMkt4Yjdy?=
 =?utf-8?B?dmM1eE9GdG1rSnNJdVhFVlNJVmt1VDR2aTJHdlBpclR0KzhZZEpFTVZYV1M3?=
 =?utf-8?B?TENobTczaTdNN2V6TE9PWVh5WmJhWTQ4RmN0UUlMendoOU9OOEhSREpSWm1B?=
 =?utf-8?B?WmZ4R1BUeVdieTBhVTNkVWl5c0RIRk9MRXQwbjRJQmdMeUtXQk9nY1R2MmFS?=
 =?utf-8?B?ZWxCSFdXcUhwbmNuZ1JpOXc0Y1p6T2JJZ0xic3ZPYlAwYTgza1pDV3V2Y2V0?=
 =?utf-8?B?R2lIZThQQUtVY1NHb3E2cVY5dmZSc0x4SnZnRnJHaDU4Sm9tNmN4NGRlVHRj?=
 =?utf-8?B?Tm1JZnBXNDlvekc4NkFOaCttazFEMFFnQU12bU5pZjQwUG1OK3hHZGRZcXJB?=
 =?utf-8?B?NjBqcis5TGYyaFNONzdqL3QvakhSNlBpUUdTNXhJZWl3akhuTHd0K001RGFi?=
 =?utf-8?B?Zm8ycStMZE8zWkREL2E2TUluOWwzaUU2eXhoYVhkMG1rNnY3MERqMUZDZnpa?=
 =?utf-8?B?bGU4OS9UZVdMUnNQSHVVaDdQeGlpRmVCeWpYSkdVSXJjN0pwa0FaZ0YxeVhR?=
 =?utf-8?B?ZFlONkg0cUtoOTU5THhwWHBRa3Z5ZWU1ZEJUaEhSdFdkdWJweFFnYmtLdytI?=
 =?utf-8?B?R1pGZm9uemNDdUcwMGI0OHF6bmdNRFBJUGxqQmRXTWtManpJNTVxWjZkNS9F?=
 =?utf-8?B?VVVDTzJnSVRHV05aVnhYdmZEUFJmK2lkUXRVY3V3REluQmM4QVJvaUxDQ281?=
 =?utf-8?B?Rmw1eDJjcDNoeUtzUGFWNTdhQmp5SFVsZW9Cd3Q3em5FYnYyT1NFZXBOK2x5?=
 =?utf-8?B?S0twUXR6STFYbXFFWldnRzhzSE8zWW14WCt3TmNReDRRVnJWQit0MzV2YjIz?=
 =?utf-8?B?OEdhdnJxNWFqTzY3Ti9HNExlenJtamxjM2xIMHhSbFVtZEh4Q29DQ2huaFMv?=
 =?utf-8?B?QU1mRnhzbjJzOTdoWU1FTDkzbE5mdDRBSzBhSE02UExVN0lwdzVOQ1kvNElI?=
 =?utf-8?B?aGFFVzhybWx0eU1DbGVBQk13ZUFsS3QxV3Bac053akNhVjVHWURoR1BkRHZL?=
 =?utf-8?B?MFMxNWVCU0dyK29kcHFUdGlKckhXVkEzR1ZNN1JpbHlmaEd0VHlyS1Mxd3Jo?=
 =?utf-8?B?M3BVRGFpVkp1R251a1huQkxXQVN5ZEdRRmdobkN1QWUyY1ZPa3VnU09oM3B5?=
 =?utf-8?B?OStYcW5TLzY4RzNJQXlFQ1NJSXY1RUluOWppM1hVT3BWR1BuN0RQLzNpK2t0?=
 =?utf-8?B?VFhXQTRMVW0rTnZ6WEtRZkdVS3BYaVk2R0ZzYTFJSmVLUXdIaHNzNy80Y1NT?=
 =?utf-8?B?bUtmeVRIMitNL0pQNnMzNXZlaHBQYWJjWGFiNW5sNmt6WENVUm80QjRiRlh4?=
 =?utf-8?B?bHByRHlOWU1ubVNoTFAzR3dMRHp0NEF5VFFBL1dxZVNZeGF5Z1RqcHAwTXBn?=
 =?utf-8?B?MXRleFN4Rys1aWlibVV2Z25wbThwajZDZ040bmx1UTBoTEM3czJ0YXowQVl1?=
 =?utf-8?B?eUhLVzZIWm9pYVRpZEhkWWh5Rk9iQjlvRDZrVGlYNm5xWDc2TmZoeE9uUHF0?=
 =?utf-8?Q?xyBJm39sZ0Uu8Kg8lJlpio1ZSqXlMOj5v30QF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed2c8d2-de5f-4e53-3839-08df1b236b05
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 16:38:24.4724 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUTO7pi9sthe6Hq0sZCskQZWthocokwhmivVL/NdqStPGEmiukZEhPRr8KJdwSyRdjTFXVeudAp4bBnpD7zsV1+iUqEdEN+QJ7WcKAejN3B3Ll4odd2iHTN4HO7VkLX7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB075100
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

The pinmux node has no address-based child nodes, so '#address-cells' and
'#size-cells' are unnecessary. Remove them to fix the following W=1 warning:

  arch/arm64/boot/dts/freescale/fsl-lx216x.dtsi:1534.34-1704.5: Warning (avoid_unnecessary_addr_size): /soc/pinmux@70010012c: unnecessary #address-cells/#size-cells without "ranges", "dma-ranges" or child "reg" or "ranges" property

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx216x.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx216x.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx216x.dtsi
index bccf2d6730230..6d2667051674b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx216x.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx216x.dtsi
@@ -1534,8 +1534,6 @@ pcs18: ethernet-phy@0 {
 		pinmux_i2crv: pinmux@70010012c {
 			compatible = "pinctrl-single";
 			reg = <0x00000007 0x0010012c 0x0 0xc>;
-			#address-cells = <1>;
-			#size-cells = <0>;
 			pinctrl-single,bit-per-mux;
 			pinctrl-single,register-width = <32>;
 			pinctrl-single,function-mask = <0x7>;

-- 
2.43.0

