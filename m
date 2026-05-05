Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02B6FF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 19:48:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A9A010EBE3;
	Tue,  5 May 2026 19:48:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="oOJrg7tt";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011023.outbound.protection.outlook.com
 [40.107.130.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6B5C10EBE3
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 19:48:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=exBCPRyQnZ5EFgTNOz6Mwe2LBv6PsE3CdD6GbtK069CG863jFy3avcKtHJjrxmiRIhTaY4uz80/X+8s90r/kkAxnuipG2lkNcu5jBUskoFaawO9iMVmKNwXfrzxdZ69Oer+q+ZMVYN4Z2PH3okmYVgzk8c5kAZu7daDd1auJF2awjPFHn4LKibS6w9gJVP0xvz5SfV9mvct8jVE7Ahjt7AFt9WYSouQJWv0aYQA+ZLr5kvezKjhc5v3tmROP5iwDmBhcFzhFuy4ZFFP6yycdNEjbuKvk9HVSugN4MkFEy6eZJvZdyXMUBhtbvw+5RJlsHGsvq/RUd3xWjjKEIpY70g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CJoa+ucvfjMJQI1vPNBvHc0tcthf/mXgP9PjD4MH5w=;
 b=koOlUXAEKEQma63wlM18wHlXh9i5aVhzCYtqnvSW+otDKVhEG8ewc6NwpUplU9mzYyIPU4BWlrs6mnK+iU8P0NBh1k2ND87w/wmqgJpU22MIgqgrrFQG+2y6Z6uWRb04SMa9X5x3Ixq3UswhvwhjXDWOjqpKO0FWACrsRYwdhX7PkLyZk78j16aJl9EvEBZqgEbj/NKmoWM4x1rAduNPYMJ/AD8tbcnRvpJNVo/T3rgKL5nB26Tfr83QI6vvHzV0tB5/6f1qnByptTASHg9d1RFAMKlnzwretbp/EvIP8c3WICPGgJKJ8/G6bDgcxR5MZxr7S4adjG9dgrJbbj7zIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CJoa+ucvfjMJQI1vPNBvHc0tcthf/mXgP9PjD4MH5w=;
 b=oOJrg7ttsFYREG3WFutNt9qGkPqjCTNgo8FrLYCAv6DhQvKFqcAyVcyqGV30PjIABAOV8VazKkwittDyie0JCl4ZFTTwJT6jXwSRiGQgVTqQ47QqGzlyqtBK7dcnYTsQqAhTHte+HtH2nYGvKnALJCPPEqm4mQLgMBLO0cyLfELjCy8XMXHVBCaE6m0OrKIM4g9gF00P6do7qP8i8bo+jORgJLP2Pl4EjbkBR8MRrfklHglSEPBG9rO3dKVuS7xR3sWPHoZbrsSUGVqlTMqzLrf0WpaA/V0+F+YVHAb1kokO7zL8LDXijdLKWfX09+Dt4ZldNbfpaERtfyFYhkuIag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS8PR04MB8229.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 19:48:52 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 19:48:51 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Guangliu Ding <guangliu.ding@nxp.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260407-master-v3-1-5a05cea0c521@nxp.com>
References: <20260407-master-v3-1-5a05cea0c521@nxp.com>
Subject: Re: [PATCH v3] arm64: dts: imx952: Describe Mali G310 GPU
Message-Id: <177801052813.2007246.9274737288364090954.b4-ty@nxp.com>
Date: Tue, 05 May 2026 15:48:48 -0400
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SA1P222CA0147.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::11) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS8PR04MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: 572cabc8-7e83-4888-eb16-08deaadf5517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|366016|7416014|376014|52116014|22082099003|56012099003|921020|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: +X5uGQ+71gkVDqugZvrTfTsi1TWbHzwd6J9yzXvD/Ec4dfkHx5g4mo+JTbpXWRreZnzklONvlv8eLjgFz445qx71j0wNfv6wx8DU5SDFGLbfh20ztazVVyMkcGpfMzEdeH5K4BynAAO/9afs+Ryb6FwbYGMQ/H33Ajp968BwvFzmVeotHNGp9kS/KjOcID6kq4+bUGDm/VLCKtmdyhFwgJy7YCAoECGhtRvbtxvJG10XwOCMRuUwjVZqlkqIawbv3vQAtq7MSgsUFa4QcCWmBEZ3Mr6McfRzyK1QTJVWvbUBnh4q4o18wkeGWifapbS9Dg3BHdAtuMuMROXP5m7htqhibcjxqf812dspzzsSvtKRngMrVtt37RjqR/Rav4Vn7/vpiSqk6ApSu9b9tlY5kUDleNHfzTYkv4uHcQpdPLAa9CNEZkBotIKYBw4YSC9403lZqvxyzYeTV6w/Sojmn3p/m0nqkgz2K0QxYpBc4JnhkbRywRTPsPIJEw6sny9BsGRpLy+wCv4PbGegbWLzUgLGr65aw2me1ul+dk/dvz0q9VULvUmpgp10V8gg+OwKSGE+9ZcfXRdXDC5SVsowYlQZEL2f9dC9F+h8qIZkkGRlkGVk08499iUGEu0NKmxOfnKxEzumgQnhIQpFJtlJPV1is1A+qyXOcWXSG6VYBndQhdUubA8LOjsbLoAJMRCrgI978Ts8zy6tWlAKhvWNfj5sIpUlYz6SJgk0gOCpZVN7OVtUhxAVg9Q5CojLdVhaNSE+xw/TU+ewERbCsPZhxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB9366.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(52116014)(22082099003)(56012099003)(921020)(18002099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmdKVXdMbDNFSmExN1J1bEZOYnJvemFwZFBIRkJpZFNDQmZkaUx0clU3RDM1?=
 =?utf-8?B?MkNJeEgwaGNDR3BJT29lc2xHcDFQckcreVhlK2xLMXllQno1bXcrUWhaSVFn?=
 =?utf-8?B?bWpsd2tCbWpZRWc3REZ1UHJ1d2twRXpNQkVNbnRNMGE4ZndpNXlQN1ZMRGtP?=
 =?utf-8?B?d3pJRjhMcXorTElXZkZPeHpHUjhFcUJOV012dUgwZkFTb3NtaVpZYzFwUU9q?=
 =?utf-8?B?Qml5d3AyanZYTWlObmt0Y0xPem95aFBBR1NpV3lHL1BpSGZwcmFKMXlZd1pG?=
 =?utf-8?B?WnR1RE5hZDZ3SWtsOHB4M3poM1FaSkVDd0xvSlFIbGZoT3NLN1k5NTg1d28y?=
 =?utf-8?B?UjFNWFRGVXV2bml0UW5rd3dkQkNpcG41OXZNcmMvTkNFdmU1QTM3RWdZRmdi?=
 =?utf-8?B?OWR6VENpY1NvMCs5VDBJWHV0bXRwRWR5WElzd2FweGMzWXdOcVZrbHBaVmlJ?=
 =?utf-8?B?SXVjMHcyRWpzeUtBSFdtYXRHNmw1ajc0VG1BZUc4YXNNcTkxRDAxRDBoZzE2?=
 =?utf-8?B?Vi9NWk5ReEZSK3JUWUFkQmdRSHJ0QzBkMlZCMm11bGw4THpHK21kYVZkeUJy?=
 =?utf-8?B?UGRzMFlMR1FhN3ZwNnR1eS9GUXBKa3E3UEZCcnF2V0E1N3I5eC9UbDZjWmJD?=
 =?utf-8?B?QU4vSlYyakJJYXhkT244Qm9MRHlKMEo3N2FUQzVFa1grUmJnLy94ZHZTTEZi?=
 =?utf-8?B?dmJJdmVURExOajNsRkVrTGZ4R0M0NzFySTBXeVp4YjJIcXA1Q1ExVGJDdUlk?=
 =?utf-8?B?ZjdCeG9lRUtXN0lLajlHV0kwV25UNmE1YUZrb3dIN0RhSEVkZHVobVBZZy9W?=
 =?utf-8?B?K29ndXI2N25BN0tVRFd2cFBFeVZQaFJ0UDFqRjMxanhEcFRBWVhzWmYrRzRv?=
 =?utf-8?B?ZWlTVkR2bXVjS1VtaTlPcGRvSzlaaEgrVGZhUGtvRk51S0hXUEdUSlZsWFZx?=
 =?utf-8?B?MSt4dmN4RzlWNDhic1pkQ3BSZWY4SEl6cm16SVUrMllkNG5oOGQzSWFxQ0la?=
 =?utf-8?B?dGhxbWVmUDZpNHdUVXVqY2w2VUYwVXhKZlJiV0tiSnFUQVh2TGZUNDloTmg3?=
 =?utf-8?B?SldJNHluaHlsVUJOT3dhZUNrdzJFQUZidWUwMWx5a1U4dlZUMlcwV1RkNUt4?=
 =?utf-8?B?NE9sYjAxYU9QRTVNZEs2ekd2R1UzaFJkVlNPMk5td3JrUTNBMGdXLzlUSXRE?=
 =?utf-8?B?RVpuMmlBU0pWZWd4YkU0ZFNVbzBtNTJBenNVdXlvZjhYYjIzeXVRZE0wdG5D?=
 =?utf-8?B?N0ZVb3A0eThNOTB3N0s0Z0NTVmVUTjNtRU9hVlJlQzArekJ2QVQydHpUOHc3?=
 =?utf-8?B?RTVBamVjQStzdlZUN21WK3N4U0NSb2pMUmJiQ2Q3VkdSRmhiSU56THMyTHFt?=
 =?utf-8?B?Y1BIUGlpdVBqTjBhdzRWNlZqRFVNZFc4NDlEMEFuT0kwbXNaM2dMM0Zrcmox?=
 =?utf-8?B?SFN4UVBwZkcrMitObnd1aFFZaHhoOW1SOVVGN1RkaXB4V0JtZGIvMFhRQnJ1?=
 =?utf-8?B?ejRIZnM4b1hBa2hESmtiUUhNMkdlejI2THMrRUFYQmVJQXpSMCt6eVEwVnRX?=
 =?utf-8?B?SVdNWEV2ekJuaElzZGc1d1R0MjcvSkp4MG5FMjJQbUdzcXRaNTlKQy9Zb1d3?=
 =?utf-8?B?QzA4dEVNSEhGYlZQcGoxVFJvcHN4bGJaUGlHSHlLRVo5VE5wNHJqKzFsTWtO?=
 =?utf-8?B?TWdWaVF0WS9UL1l6bk04VFF3TC91allSWFdYVzZlZnlRZHBKY3QyTU9aVlh2?=
 =?utf-8?B?bEpvSDkzM1BBa3RiRkNGUUxGWTI4ejNsSng4TlIyYnpqSy9ndWwvRTI0ZkJk?=
 =?utf-8?B?ZEhDVlh4bTFGRTJieG44ck9HR25DWmt1RVVwSnphTXdJeTBhelZQcExvVkFm?=
 =?utf-8?B?Nmg0Q2I1eDJKNlgzdzZBMXh4UkxyekxndHJORTNhTVdBajhtYjk2RXlxUU5t?=
 =?utf-8?B?dkRiejZRMjZib3RCVjhSQkYwN2dpOVUwdHZsSHZuY3k5aFpFTUFMVHE3MnFj?=
 =?utf-8?B?d0V0VnZpWWNPWWpoYWxRYmJyQkV3MUl4TWdtbGc0NllhS29KRE1qWW5GK0VS?=
 =?utf-8?B?S041RG9DMUdnWE9FcVdzd252L01UVkNVZ1dQUmt1cXJQcnFGNmJDc3czWUha?=
 =?utf-8?B?NU0zRFZlSVl4eUowWlFFbytUVjRieXFhdEZ3b1BPQTl1NWFyajM3MHZpUXls?=
 =?utf-8?B?NUtmQnJxYzFBY0I3MGoxMUdnSVFPMXZzaXVPeU56Zy9jdXNlUnJVVkRqNEdj?=
 =?utf-8?B?OSsyMEc0eEcyeWpQZkFBUXZxV3hNVWtWSk94Q2E3TjlPeG5RN0k1ZG10bjds?=
 =?utf-8?Q?AL4Ha/TbVWB5UXemmE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 572cabc8-7e83-4888-eb16-08deaadf5517
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 19:48:51.6901 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pgG+FOhEklrNyJskdLZ5CfDlGtz6nRuW5CcM90Gs01FsHUBsp2ojAbLMMC0ScZdjW4lvYFuJSjLpWqSUCZnUPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8229
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


On Tue, 07 Apr 2026 11:15:03 +0800, Guangliu Ding wrote:
> Support Mali G310 GPU on i.MX952 board. Describe this GPU in the DT.
> Include dummy GPU voltage regulator and OPP tables.
> 
> A hardware GPU auto clock‑gating mechanism has been introduced,
> enabling GPUMIX to automatically manage the GPU clock. This improves
> overall response time.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: imx952: Describe Mali G310 GPU
      commit: 3ae6b04598bb3ea5ef859d96b37bb47ca395d3c3

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>

