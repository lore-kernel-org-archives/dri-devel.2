Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135BAF8A146
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 10:20:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B53210E023;
	Thu, 16 Apr 2026 10:20:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EC+kdXkJ";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013005.outbound.protection.outlook.com [52.101.72.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1657310E023
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 10:20:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FPE/iSvNN2pHfD9bx8ah3c8GtdJDhe2PaTaHGTGazFdkOjEQEXAkrz500npd3oPc+afaozVadQ6LS0yAofECS3woz6zMw501AMPXGaHjMiWvYnEJ7v548Eeolb7T8/iCwHi4ptprc2xC/GPmZSpbCayWdS3XQtnR/kcSBMBMxHuMWumRLDKdlD63f5etpiSQvK5V/xsgTxHwqeDWfacHzpli6nUq2H8JfmuvKjcdTHjPN1/A0xVbCPfFSJhe1gvoh6xfxzVcczBs/AsMhtDR7kFyrZsIBxLfO7jRSPmVuhjI7169PwUpegBRKE5sX4SyBls8b0W9Q0AgW3/hOyBi5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJJmzjYtSFC/yVBD6maf0dNKdI7KbFsbig1QEG8x1dU=;
 b=jj8uSyPJhgz5Km2S2JB76Me9oo8DLpPAG+wyHitAZbKCV5F7SzyzozGSWL7zVyk0jAIcgByZTxtg2a9SSFPJn2eyoUHImdKWSzV+s6Whj5CuNqZeLdtMgJJRD+jVWms95sKI/qjbcBSeZD5C7OE1TZPWBP3lXkXgy1gSvGwa7tt0piU33Yt0uliY03nBsroQQ56eLHbwmOmr+3f0mj+a4mkIIW7l4QS9V6z17Epdd0+csSPaF4Y/1H23mSGFecdtTsLM+aKQn7t79b8J4RRriVVkp/KUeQHiuWuY/n/3xZ3sg0qUb8RWXwH4abtqLc0gxn7zJmP0vem7tLZFiW0GUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJJmzjYtSFC/yVBD6maf0dNKdI7KbFsbig1QEG8x1dU=;
 b=EC+kdXkJ5sDD5X+YKGk4D+WmLx3nB6290KfASLjPsZmFJ/qfKKbZOJG2EHi0lfVJh+UH8+2xVMODlw2ZuD55sO0KEiNSrveT+TCl5BbKQuuReFkAOS1+2uQHZwp3irq/zUrHkijuNokA6amLt4Fbu6Yz+SRQFfqF7WC2URAYBlLctT4EWAQlbl0xbq7kbxtCPVAIPsdhsQWD7GunCDsLVaPQHEs5gpUs+E3ovGMT3BiH4a0z20res+HLJ2/7kUK1UC6xjbNbCyxl313JMqIzD8uxAhATk3pO/i0Wt2Pkrp3aSACKhkFq1AZKwUbsjUzfawSJOVK5oPnB5u/XaBP+tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by DU4PR04MB10982.eurprd04.prod.outlook.com (2603:10a6:10:589::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 10:20:26 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2%5]) with mapi id 15.20.9818.023; Thu, 16 Apr 2026
 10:20:26 +0000
Date: Thu, 16 Apr 2026 13:20:20 +0300
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Marek Vasut <marex@nabladev.com>
Cc: Marco Felsch <m.felsch@pengutronix.de>, Liu Ying <victor.liu@nxp.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Marek Vasut <marex@denx.de>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: bridge: ldb: Require reg property
 only for i.MX6SX/8MP LDBs
Message-ID: <7hysu6kamrsltsfcp5hyx23o5nbqbds22jhv65266w2qmps6ft@4tpbs4gfnzx4>
References: <20260329-fsl_ldb_schema_fix-v1-1-351372754bc0@nxp.com>
 <crqzju5cqhvmy5msxvuquydmnpb2ft2t3gsyr6qsre6ccqjvzz@46gfcrelczsr>
 <0d7c7403-4b77-42f3-82d6-eaf2be8e5b1e@nabladev.com>
 <excxf6kxwx44kepc22smvvnirptc4kxpubioxoto7nqleqhoiq@ymch4y6dd5n5>
 <bc7d5955-600a-48eb-b897-3928ace275a5@nabladev.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc7d5955-600a-48eb-b897-3928ace275a5@nabladev.com>
X-ClientProxiedBy: FR4P281CA0376.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::19) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|DU4PR04MB10982:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f823fa1-c977-42c7-d035-08de9ba1c697
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|7416014|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3T6tLUARzqrmLZuNNnmfl8lzKHNyfvGPj+wGCJ0fVLzc1LWwjjfnF8QphZorzug7KNRNBkTrYoDCuSrfY74Dz6mpuBf8GOp16HZq+mGjUt9y5CRUXLgreGTHCNo6W2rQXvBzcWyW35tSUOJHHXRAK3Lff0xBPPdWG9P5poTWM8CNGULsbtTau3M8uSBoGZWM6dwyH6IEoWHiuObUhPupz8HsNf6xLvCwpTcQFrRou+ifPRqYRIf+W2W3GNe4UGXYbvGeE29e8q1iEme7Hgs22ee4M9hxrkrLWHLEomWxzZZs4ph7RBpc4iZO729dQygaWFwEwc9uZCt0jpQ9GsC9J44HYQSZj2TAO2SuJGH9cSYFXUyzt+xDKLo8pSIULs8ZimMzOQYI1k2yDguH8y5f7ZI3Lhdnx3W/BWarJkKt0tMPy7zBjvEGHUj41Uc9G8O/3rdMdrHPS2kT6bxPxKPU/x3529m8fweNhH4Zfpir7B3XOp6dtCpJ6WbjleJbs1V1XZn5hVkMfvRyXf+cpqy7zx+xp2uFxiGvMfdamqBsOBmGBq11ltwiK/KhHPY2NdmNXciRxNRtY1i6oLY9j4h2VI5m2EpMRLwk+bP1hK1isyssDrpXOtEWQnVgGItKXkUY0H+sXceAsiTYEjI1vef2o3/vIdnQVSsTALrYPDLqqPMN32otEbgiP8Hvc783307yT+H76qPblrr/R9S0ZqnL5Lb/HlYFAY2bMl2s+UG3xh8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB9135.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1lIbXhpRU5CdlR2cnNrVUF0MFVncEZuaWRDc0ZIdEp0SkcxRm5ibEIxVUR6?=
 =?utf-8?B?Q1ZmeFg2Nk9HU29UY1JHRExPN3UvdWNRYXBaWllJVUtrS1RQWUJZVjdQREs2?=
 =?utf-8?B?T1Y3ZVRJNzNjSlY2S0hxd1p1SFBpSUYxbTNqNnMvcXg5UmkrS0dsTS9mVnJu?=
 =?utf-8?B?NHNtQWtxRFMrOTVaU1NadENIMmR0bnk5TnVFVTRndTF6eENmdFI0ZXhRVTFR?=
 =?utf-8?B?Z2FVS2RSci90OFR6UXRzbmxrck5jMVZkNG9wenVvNy9KOEhqVjJqTjd2WllF?=
 =?utf-8?B?TjZKV0VVK3VyRzIzWmJ2YkRvZGJOWmlwZEpnOEUyNFhhUUxwY3RxU2tHNVZj?=
 =?utf-8?B?WjRlSDIvaWQ3ZWtvMFhraFVsWEVESGl6cmE4RmVBcGpwbENHbkZsL2didE1F?=
 =?utf-8?B?TkdNb1MyTG9qQVgrZ1FEbTN2M0IvYkxITmQ0cTFlYktCNitHdDVQU1BCL29Q?=
 =?utf-8?B?K2hFdkZEb3hqd2JRRGoxWUZ4UFFXRVQrS3pvNjZBQlJkWXRFMEJnbVh0MmZq?=
 =?utf-8?B?S04wNVdvSlk3NWZlTlRBSUxxZXpqR1B6dEVlWE5SUDk0SW5TRG1GL2Y1VDZQ?=
 =?utf-8?B?SmgxNjB3RG5Sdm5ud2FCZCthbG5RYkcrd0p1Z3U2YjlxTFN2L2JoeG1UU3lx?=
 =?utf-8?B?NU9WRjZyeUx5WW1FQU1hUVBDMktLeDNRRU5VTzE4V2RGaUNVS2tDcnBkd1VU?=
 =?utf-8?B?bVplWDR0YTdIYU42VTVUWEsxWmJFOXZ6NDVzdFJ2MXQxbE0wUWNHcEwyZS9u?=
 =?utf-8?B?UGVUUGhLa0tPSmNIVGhWZE51VTg3QjUrc2dvNCt6elB1YlZRd2hiOFpxUGlS?=
 =?utf-8?B?c3hoZmhtRUxUVU5aWWNpNHY2aXBNMDVtRU5rNmZmVWpqQVdFbkVITkVoT0Zh?=
 =?utf-8?B?ZitSdFRFNmFMSnh5MndGMjNDcmR2ZVFwSHNuL3lJM0tSQ3dzV2NsWU1XV2N0?=
 =?utf-8?B?Y1U2aEs1Wk9rTjVDVFdvc2NEU1Vrc1l2SUZjSitsQURvellLMDkzblQwZWho?=
 =?utf-8?B?b3ljVVBaRDVESlBEVGczbER5SVY3RVFXd09PSUJPL2taS1BYUG9CbGczWmhR?=
 =?utf-8?B?U2JxNm9uK2l2WTZzaWxIcm5WRFQ2MWc4bkcvSFpIWDJRSWNIQXM0NUZ2Vzdh?=
 =?utf-8?B?MU9qKzNnQnJOMGZHeEVrenVWZlBML05ReUlSWGtPSnRFL3M3Wk1XYzdKQVJa?=
 =?utf-8?B?TEVlTGlFYUhPUzFYK2xkT0MyZTU4cEhiZ2JxNHNSemthMG9jL3h5enpSTWJP?=
 =?utf-8?B?MkJCS0VLZTBWZzVWQks1Z1BuUEZwUTQ5QWovdVd1eDZ2dHJZNzN5cktZUFZu?=
 =?utf-8?B?Sk5vWU1JS3gybFp6eUQ0SzFGN2VyUU9lbGdUbFgxUFVMczd0MTlhYkVza0d5?=
 =?utf-8?B?MUY5SVdjTlQrT3RrM1FBTlRtejRRbG9IVlpLdVUvc2ZtSmMwZnhLT2tDUnd0?=
 =?utf-8?B?S1RtblB2TUFwaHZaZ2g3SG9YdG0zKzNjdkliZEZ3eFMzK2o4MjhKUXRHSHZj?=
 =?utf-8?B?ZWZ3MnRvQTBvcDFPTDd6Zk9mUDlDT3dGWFBvMWpNL2h0Q1VMREVCeUxCVi9X?=
 =?utf-8?B?T2cvK3hSOFh3eWlZL0Fhd2owZC84dVVSWG9Zc25qdGxaaW9relI3WHpjdTVR?=
 =?utf-8?B?TEkvRDV1ZFYvN29sYmxoYmJJUS9heDJKVVJoZDBHaTRoMDlja2NOTk1lZzVq?=
 =?utf-8?B?aTJ5amx0NHlvKzZMMmEyT2crTUNnV2ZMbDYwN1Rzb3Boam52azQxRDAvKzk1?=
 =?utf-8?B?TytoUFhjRzlrWElDa25yQVYwUFZFcDZ3cWFyNS9BWndvYnBacU5GNEMycFor?=
 =?utf-8?B?cGkydDZ5MlR3RkkrZlBOR1ZpUFNYUGlDVjltOStJMHFSOElyMUMrQjFaajdi?=
 =?utf-8?B?OCtSV3BsdnZMdkdYc1g2L3ZSK0tqbE42R1FJUHgrVmpVd3VvbFhDZGZLWjFo?=
 =?utf-8?B?ZnRKQnF4L2tXVmtCYTRrOGlneUlFM0FOT2ZVelhWVVFsOUsrYzRyTDBhODNZ?=
 =?utf-8?B?emJDemVpc2xDdUdXNHdMaW0rYmo1eHc4cWtkTmhkc1FyYVcrcCtpTU84amha?=
 =?utf-8?B?OUZ4ZUhoRld5aXJVb2xDWjd2Q3I2VzNQQVBWdDQyajEzU1l5NmEvbC9Ta25s?=
 =?utf-8?B?Z2hOeXRweVArcEV5NGNEcEJnaVlNc1ZUOUtyMEdDZWd1OGZCRjFZR2dYcWlS?=
 =?utf-8?B?MkJZR085ZVBNSlI3dHNRWVgxcC9IOTVRbkM3Sk1ZVEdzZkJ3VEJNdXQzZjRx?=
 =?utf-8?B?OFMwSUhyZUFzbE1Ea0R3S2NHVXAyVTZoaGNkb1NyTzJBZlVORnFyN2pOVitL?=
 =?utf-8?B?cVh2OHBCd1V5VGxERkxzTFc2ZGVQNWpSQTdkWUNoblRxN2VTQWo4YkJHNVZl?=
 =?utf-8?Q?9Rb/SUaicd5eukFk=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f823fa1-c977-42c7-d035-08de9ba1c697
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 10:20:25.9904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u5ERpu/AGaist9wRMbO+FsUBXm3vNOSc7nieGlMSmLct1Ja00Mjc2UiHQskgrqOLo9n910bzxQUwQtSwoj5LrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10982
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

Hi Marco, Marek, Ying,

On Tue, Mar 31, 2026 at 01:22:19AM +0200, Marek Vasut wrote:
> On 3/30/26 8:29 AM, Marco Felsch wrote:
> 
> Hello Marco,
> 
> > > > On 26-03-29, Liu Ying wrote:
> > > > > LDB's parent device could be a syscon which doesn't allow a reg property
> > > > > to be present in it's child devices, e.g., NXP i.MX93 Media blk-ctrl
> > > > > has a child device NXP i.MX93 Parallel Display Format Configuration(PDFC)
> > > > > without a reg property(LDB is also a child device of the Media blk-ctrl).
> > > > > To make the LDB schema be able to describe LDBs without the reg property
> > > > > like i.MX93 LDB, require the reg property only for i.MX6SX/8MP LDBs.
> > > > 
> > > > NACK, we want to describe the HW and from HW PoV the LDB is and was
> > > > always part of a syscon. This is the case for all SoCs i.MX6SX/8MP/93.
> > > > 
> > > > > Fixes: 8aa2f0ac08d3 ("dt-bindings: display: bridge: ldb: Add check for reg and reg-names")
> > > > 
> > > > Therefore I would just revert this patch completely.
> > > Last time, I pointed out the hardware is part of syscon, but as a subnode
> > > and therefore with reg properties. What is the problem there ?
> > 
> > To quote the DT spec here:
> > 
> > """
> > The reg property describes the address of the device’s resources within
> > the address space defined by its parent bus.
> > """
> 
> That parent bus would be the syscon, wouldn't it.
> 
> > The parent bus is not the parent iomuxc (i.MX6X) nor the blk-ctrl
> > (i.MX8MP/93) device. Therefore this is wrong IMHO and should be dropped.
> 
> How so ? What is the parent bus ?

It looks like the discussion is stuck on 2 things:

1. DT spec argument hasn't been fully addressed: Marek asked "what is
   the parent bus if not the syscon?". That question is still open. Syscon
   children carrying 'reg' to express their offset within the parent's MMIO
   range is a common upstream pattern. Marco, can you explain why syscon
   doesn't qualify as the address space provider here?

2. Regardless of (1), removing 'reg' from the imx6sx/imx8mp DT nodes is
   an ABI break, those nodes are already upstream. Ying's patch is
   the minimal fix that respects that constraint while unblocking imx93.

Marco, a broader cleanup of 'reg' from imx6sx/imx8mp would need to be a
separate patch with an explicit plan for the ABI impact... So, for now, my
suggestion is to move forward with Ying's solution.

-- 
Thanks,
Laurentiu
