Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F56CA5FC7
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:46:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5F6E10F139;
	Wed, 30 Sep 2026 15:46:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vpG8BtUH";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011047.outbound.protection.outlook.com [52.101.70.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0634710F139
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 15:46:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXVRVYnXnt6/mEvX8Wciyo9HYpo8qTyoNTz/3mSZXV7etTzvBaWJ5i16a+hmzMVJQwQM9cZcGiBXqWLXROB0XIdVrX4SmtnyaBeJKavKyaOyq/l5RH9m9IwFhQUZDd4x2bP9HMb0BYIBk3Jwj63n0LmCRMiM7bO7vQ/6ZOeklNHPByTBwqQa0RaWF9IU/FonuZuQ1jtHZludKkRXdBE6VJvTKSA9SPr8e0Iydfhf2tz7yQDBC/ZRaekpiBbWF/pq3/HqGbu5tvzNOPId3PD2gl0GoDhvtko6Sjo6rLok9g0FFgnupZiRj6fHCCArPli21qM++KLUREgkrba+E8OG3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gpCAGup6Nz06OzvBIAYkaGYuNmKaB3JdvYXrCJt2w0=;
 b=MmFKQi8wd2s6iuQ+fbSJQdtBqSjuRGU5z5DkhpJ3PjYfnomfKX/RIXdeiAmjJA0yvpm98fqX5DR9idNrygMXWVLwNeJ1/QBUibkZNunTb2PLoREHHTzt05MbutUvQZYP1Iy58GKcaWiJtcUYYIQ+IaTpGEFfXchrutoo2mD/N8IAx15WbOLmtGJefbCw8+TOqC5R4cyiXflglzjAiHmqgTM6XSHg3ANJ0oC45mc+XnXRnMGvzPSdH8nQeZ1T+H5+QNjvPF3SwKhfWYPfGH7MRN+cV11bVeivNyJLGtvaxvx2QUreeQ4GUbMR35/t1sZWTVOL51ZkZkEzXg3k/J7c3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gpCAGup6Nz06OzvBIAYkaGYuNmKaB3JdvYXrCJt2w0=;
 b=vpG8BtUH4L2KNjG+5gILzDp9z+6rETDU3CFOrrb38qPKoEDe5da+DNVcOzWe3Vllr6yITniivj9bWqpLVsgGuDSHSIy/si6ALF3IPmwFdE9Yqwsy+CwMV2qOCooq0Cb57FMhzCrlnnMVNFgNChb1B3PpX4P2v0c6WMMa2lIYKoXUfVxCJ5LtzElJj0uczhq9vE/6pL6f0IlvoLmAQmd/tfAK7kAynf+88Yegx1gPt57OwbjeqEptP+O3wPD+Pe9zF8TZXK5HDFTLjyKBEZmCpzqualXz9laKXgA1rrDaxlmvp0V3IySK4v7CXYi/HGhS03nk4UxOCbTxI9VQdh96iQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV1PR04MB10848.eurprd04.prod.outlook.com (2603:10a6:150:20f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 15:45:54 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 15:45:54 +0000
From: Frank.Li@oss.nxp.com
To: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco@dolcini.it>
Cc: Frank Li <Frank.Li@nxp.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>
Subject: Re: (subset) [PATCH v5 0/4] drm: mxsfb: Support LCDIF interface bus
 width
Date: Wed, 30 Sep 2026 11:45:46 -0400
Message-ID: <179078313436.598059.17936202871523895836.b4-ty@b4>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917140042.118181-1-francesco@dolcini.it>
References: <20260917140042.118181-1-francesco@dolcini.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P220CA0101.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32d::17) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV1PR04MB10848:EE_
X-MS-Office365-Filtering-Correlation-Id: fa17baf4-a925-41c7-dc21-08df1f09e96e
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|19092799006|376014|7416014|22082099003|18002099003|921020|3023799007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: WuCPeGkcPrBOxbqRbm31TZ2KSfiOiRfStn5jSsYAJU9d9r0i4a+JZEz+8rgAGOg7j5i719yxPvsC07si7xnsJPQDTInyIKmh32SjtBehp/I5omjBkowkq/mbxa0/NN+3yQAPic9uhrLn0X6vjclebR93Uk85JtgU8u3iiOACVxk7dyKkwo3Wpt3/Rw6D0jKD2x0+wzoVNOtxmmiFLGAXA81pCxj7ZTiWwHkYar1FPJkHyXA46zl94TUSgZavGS6qJUsLufbZZroeuC24Pro1MPoLbjysOXsOziEUem2rxgai3wRregfybjOkxZpKpIbeuKnWgvSM7dxwqn5fono8XZN3EV1tfRHB5MmKhqmHFXh5atbU3SyzmRYxLXdwE+5RBuLJdbFPieKoBmEzrdbdZsP0Tw/Ngrxv5qU5U7ao7YsDx35L5Z68E+yYCCwfCbIeFlV0KS5PLhChdkRJ/rZDZ0JBkxTTor9oSmM/6rMQT2soJzU6/k+Og2di2lIlWFSLQ6HU1EEnPn9gBg8WvDnxLX8a8zkxp93HmDO1Q0V85XbJtXF9UuCOggBONcH8EPQFkk/Nu4JJllUyAWWwzcBbTnW3gRFf2FFeId1MnMYSCD/ntz5x4fNO+aZTw49BaXCEMrDaHMpCdwBtgr1XSGqmTVmLZ0Dtblu6XHDITpXKxlJPqGqn5NjIMYx9zo/MocQRtmN9wOUtKDYiPNg6EJqCpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(19092799006)(376014)(7416014)(22082099003)(18002099003)(921020)(3023799007)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlZ5ODFBZFBMRVVVMHM1czR3alFlVlVoTEUvRGxIWVVMTGxrbWVxZFAzc1ZD?=
 =?utf-8?B?R1VMV0NGcFdvemNaOUJSR0VaS1IreXBNWURnWHp2T0tUZ2JrVHJaSVdkOExm?=
 =?utf-8?B?R0dKL3hNclFSdGdPUExiVUZxbExYTy85cnUxSmZKRHZVdXpIdGJqdWNJS1hx?=
 =?utf-8?B?M3J5TVYwUzJmckYzWXV2RTdSVk9USTZ4M3JBRk9qUmhsWVdrRmZld3pmMzIy?=
 =?utf-8?B?T1V3Y3lVMFZBanVreWV2RWtkWkNCWEZtZ3dCZXpsZEw2UlZwTzZSemY5KzlJ?=
 =?utf-8?B?eVhzM2VxVklXWFcxQ0htUndTTE5YRXdoQi9rM1gwdm1wRnc4YWwyTVdyQ0Jk?=
 =?utf-8?B?WlRoa1plZ000TVFqeUg0TWl4NUtpV01ob2hCd3VoMGhHZFBneVBIZWhDLzdl?=
 =?utf-8?B?YzYyTFE1QWMrZ3A0K1ExdHoyZXV1S3VrWUdMT1g4b25naE9vTG5jMStUdVFU?=
 =?utf-8?B?T0xyR2Y5amZkWU1rU2M5a0NDRFZ5WE9Bb2ZudkhSNDRTTWhSdFg3MG41T2gr?=
 =?utf-8?B?OXNpbHJidDhBVHY5ZW81VXlvaWlBOEhpQTJ3MVZ0cjY2S1lCdUwyTVIvK2pL?=
 =?utf-8?B?bnh1WGg4RlF5bnFwS1JCWTEyUXVIbFR3ek4xV1p3aUxRY2NJU0xLYm9iOXlw?=
 =?utf-8?B?SWVaYzMzUTdTbnhianp1VFRRK0dra1pmZ0FCWHJGbS9aK0t3MlJtMzdRR0FO?=
 =?utf-8?B?R0dKdkxsQWw4aTBBMHc1dEVVSXpFTnAzdnlNV1F3MExEZ0JWeFhuKzNKL1U0?=
 =?utf-8?B?MG1PaXIzL0c0SVV1RGlEenBLUjd3dW1nRDkyNWl0eUxhUWhiWWVIU2xlZWxG?=
 =?utf-8?B?UWo1VXFVOFE3Q2diUUJrOStZZUxkME5zeEd3cmdsRXlJdExWRDZCNk5rWEJz?=
 =?utf-8?B?cFJ1LzIrNDR6dXloek1RMngvSnBhR2wrYnBQZUx2bktGRFZZNVpKR204MzVL?=
 =?utf-8?B?cld4TUNkeUJVZmJVZG1YOG5rU3htNjdReGdzTWc1UWkzMzNkNWpTQ25ZeFpM?=
 =?utf-8?B?UXVpL09HTG0zK2RIQjhNNkgvUEN0WVY0VHJRZnRiV2xXOU41eE9mY3Z3U3BW?=
 =?utf-8?B?Z0JqZG1lZ0R3amk2WFZoTnN4d0lRWnNGNHBndXAyVWthc3JIT3RvSHZQU0s1?=
 =?utf-8?B?VENSbWhOTGgzUUtjcXpkM2xmbCs4RkVUMHVqb3BwakNEMWFJT29hb3cvWS9I?=
 =?utf-8?B?SUhXL1drZjIrREtzRW10b0NRZHFWc2h2WWp2dWl0MDdwSWNBbURnSWR0Sjk4?=
 =?utf-8?B?MTFVcWJ2alpXcW93Rk1OUGp1eEdPQmttTjhhRFQwU1htdldObXBra25WWDJ0?=
 =?utf-8?B?cklKSkJXbitkcVR3VlJJakNzaTZpUXRpeTgyWitUTjgzVS9OR3EwbjBycWdR?=
 =?utf-8?B?aU5lZW0rSyswYXg4d0x1bFk3UnNxOEY3cEFCR3BsT3dMMmMrSnJGSU1QZkNk?=
 =?utf-8?B?WE1YdVNnV09EZkVJU0pHRGhlbVVyZ1ZNOW1UODdwdVN3TjZlWFcvWnErSS84?=
 =?utf-8?B?U3lYNm9Idy9vRjc0cWVGWmVEaU95ZG13WmRnSzAxbUZPN3pNWnJ6VFllYjM1?=
 =?utf-8?B?b2NKUy9VdlRmVldPTkg3eThuallaMHlPTENKTTVMNlVGSm5COFdkTzJvNXhH?=
 =?utf-8?B?aTBONmwxaW9qSW5oamNzNFZOeWM1VVBVb1Z0UVFENjhZVTlVSmlwTk5KdXNX?=
 =?utf-8?B?WnRXZDhyNWg3MkJ6MkM4Q3lvN1E2L1BSa09pdmhqcmZ1cmQ2T3FmRHBPUEFR?=
 =?utf-8?B?T2ZUdEhiUVR2SEVaSmRVc2RacVlKdkpFNXRTYzl6aVJDaEIzRFBUREZCL1dR?=
 =?utf-8?B?KzZEYlZlbUMxNXdCa2dnWU9oZGpub1hINnBGR1Q1YzRPMVgvVVlsdlVybDJH?=
 =?utf-8?B?c2k3LzlqTEtLajkzUFpEYzc1T2h1OXN0L1liYzN3YVZKN3g0ZkxhOWwzQUNK?=
 =?utf-8?B?di9sZG9uQ3dwTFdRMC82OGQ0VmNXN1dxaDNiczl2elVuR3h2c1lkc2FtTUJp?=
 =?utf-8?B?WmpBU1g2QVcrTGJDd3BUdDRCT08zcXRuYzdwaEJxZkFrWGNac0JsZG4xTXd3?=
 =?utf-8?B?aitGWjM5c3Z4Wk0zdmF6MVoya2M3R2FRZDRKbm45R2FVR1Q4ZSsxU1RKaTV2?=
 =?utf-8?B?VFcyK3dBNklsdEc1OTk2M3RGcklQUms4R1BoSm55MmJCZHkzVXR4N3JlaTJQ?=
 =?utf-8?B?N3RnaEsyeHFHVFEyMzJHQ21nNVVSaEdrVFFpcHAxY3V2QTN6emVpaDJ3djNR?=
 =?utf-8?B?KzJVZ2J3bkRvU25ORnozeWF0dkZHWi92bHorVVBZNndEMDZURDJEMlE4SjVn?=
 =?utf-8?B?T2t4TkR1cGVRdExYdThaODM1bWh5OHlvdWVjTFN0dkZzTnhCRmEwa2NLMmdI?=
 =?utf-8?Q?VaHehtBh16j/bI1aGonXnuageNJ3KKWhPMi+Y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa17baf4-a925-41c7-dc21-08df1f09e96e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 15:45:54.4396 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4ids3Z3nrGP/sZ5xTyy1nvEr0ZZIAijBqNIo7HZXFsJj5OffbbboDlJ4vd1R0gzvurJzA377aq7i8z90E77kNicl1zJBQ/u8vEBLkD11eDRwG81JYtwZn7aZvO/VpAC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10848
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


On Thu, 17 Sep 2026 16:00:35 +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> The width of the physical LCDIF output bus can differ from the input bus
> format advertised by the downstream panel or bridge.
> 
> Such a distinction is required when the LCDIF bus width does not match the
> width of the downstream display interface. For example, an 18-bit or
> 16-bit LCDIF bus can drive a 24-bit display by wiring the available color
> bits to the appropriate display inputs. Configuring LCDIF solely from the
> display's 24-bit format in this case selects the wrong LCD_DATABUS_WIDTH
> mode, changing the color-bit assignment on the LCD_DATA pins and resulting
> in incorrect colors.
> 
> [...]

Applied, thanks!

[3/4] ARM: dts: imx6ull-colibri: Set LCDIF bus width
      commit: b1818c5bc05407c6c0ce39898e76f609b4c94199
[4/4] ARM: dts: imx7-colibri: Set LCDIF bus width
      commit: bc7c81213293966faaef1e41a624a9092ae89429

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>
