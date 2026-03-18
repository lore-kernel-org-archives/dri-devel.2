Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9529D103E183
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 14:46:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1E7510E36C;
	Wed, 18 Mar 2026 14:46:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="B7p8JFd7";
	dkim-atps=neutral
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010059.outbound.protection.outlook.com [52.101.228.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01D7410E36C
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 14:46:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zEeth5Vi+BSfo+b/6OFE6K6OkALVrhT4AtXjiImBsaAO0T5kPmZUpolwuxdOwq+70BGZusTV8065KxnqsuNiBBzuXevhjbwDOSNfLoT3EPAAcIR3y6R/6pvGtwD7xL/h8bhfVero5Ez66UCpHz70F9Z+sFUi+ppL0uUJgud3xpwdmNu1T722yjmu6B7f8XwD9K0dSNjKHu+MLGt5x04UZd525CvlPbFfOL/YAJcYNJXFSszIhOQdkapbpHJ8u73Lye+NRQyma5lV0Lulsn2w/yKdH8Fuiuzkv1yexD25vXFT3l4MO2IyVfurluA7G2WKCDUfQcIFB1JYAZLll+zN9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxJLdMhSkTm++jn24gUSa6GfAFaPVt/vvEaZed+asDI=;
 b=yxnC7l9HL7rq/5Hqj6XzFuC/eZIKX/7Nep2J6EQ2KgsSASPkZvh0qn0o+uSxlV7p1f72ajYMDyWgt+KXpMaMAy+rI/7ukUyda8/6Tjwu5p9G2e+trZTaAL4YcKlzzz8qdUF7AQyS5G08dSdtKCTAe679enn/+AqiQCjjheLSJxX1aMZMWxt2ple36RBfI/pprV2jmHmaYhW+Rg0FRS1+JXZiGkFfKHu3Z4nx6VIz+YFvHWryibtxzK5oJI7vp/WcR2TrpO4aUGbyCu1hdxrlE4K//P0W8hFbjCP90nw7NgaURlDG9Z2l8iNdWtz+ttqUzl9Zxxk8EyLNALlFp1cB8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxJLdMhSkTm++jn24gUSa6GfAFaPVt/vvEaZed+asDI=;
 b=B7p8JFd7QYerRmGrAIAC9OKJV8ws/Juv23Nw/GoHBrmg2ArQzpMQPfZuGyhU5WbligzbEb7Crd1g8bg9/jTjBG8p/c/FAMzKOu4EHRweCJc4DIzWWPqoO9fyjQJy9cxGoPHNM3JxVJi5Eho0Vbjtk8m8fcaRBouMf3dzQFyUF0I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSCPR01MB15595.jpnprd01.prod.outlook.com (2603:1096:604:3c1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Wed, 18 Mar
 2026 14:46:22 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 14:46:22 +0000
Date: Wed, 18 Mar 2026 15:45:54 +0100
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: tomm.merciai@gmail.com, geert@linux-m68k.org,
 laurent.pinchart@ideasonboard.com
Cc: linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 14/20] drm: renesas: rz-du: Add RZ/G3E support
Message-ID: <abq6ohQW-LPcmXgy@tom-desktop>
References: <cover.1770996493.git.tommaso.merciai.xr@bp.renesas.com>
 <152f19a068fcdf27c063e845fe04a48a46c5b47e.1770996493.git.tommaso.merciai.xr@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <152f19a068fcdf27c063e845fe04a48a46c5b47e.1770996493.git.tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::20) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSCPR01MB15595:EE_
X-MS-Office365-Filtering-Correlation-Id: 383e4847-6da5-4838-d864-08de84fd1f4a
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|52116014|366016|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: UGsisScybomr6urqGBwHrX5SyPlTq8Gs9zyYwPWTls1fbpD2oeK95NS0LjQzBIfYkh3g/0P4XnxM23wSze1tRChom7kpPZsFONfnndcabSo6EEWi2dnBhSkmIjqNd/rDoQAGAleNargqXJXKhetBjwqe+jEZ+vzdCkWNZeEdcKWga6DH1Wr2E8Tb5o64k4+9gEOrGpIdsIBHhVTkqUGHxsRXlB0SdsDqIKBbkrVEzbOpoISWhLxtYwch8IIvU1cUoCtiVAYn7QW0hVGPJOWzaTczXus94j5G5BpESpVRAaxGDmPZqU7W9rgUD4rQy1b3QQ4XR1fP+uYbEk+ShDtviEBE2DYtaIh80Ql4rDND9wqcwRAXdWEVAUBwCcogLw3+avKZWz0pjda6S/IqXchEV/x4PO6FzJrrueupV+qD7tXatp9Ov4GHh1smA09Hl/4Zw55vy1h+MyrIg1Bnp4lx1PeSFPxs1ZEzPQnkIs3djGnKRXqsCB/MMI0HEjjjwO5txyYnsk4D8TC/utRy57ch1NA9qUWjcoGXLe0VzsXx96KxvE0m36vT3JIwy/vLlO8shglwdJdsKBnWNylJXvvUvzcjz+T6ZdoC18DUHsyvKMB3p9tHLyGMBD6dyfwpSoLX2yxgrzsLy702mL8bOC+5i2MQi9rynRmFWZ+BG6CjVGQBZ7cx2XQ1Eaz2sSdQN4Pug+rtqKGfX/SlGpstU68XmmSbYUU4Fsff5gHS4YCSFYj52xXKVvdaULOERoO06OVD6kERD8z42qc4p3estKbYWIWvM5iYFggREBGqxmuKYY8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB11947.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(22082099003)(18002099003)(56012099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1k2NnM4Tkl6bmlxdlJHQ2ZpZjMyRGwzNFhqUGdGbFFGUDhZd29BSnNScFZs?=
 =?utf-8?B?UkRVeTk4MEVvK1N0MTgwT09jc05QdUttbWZxbE51UWZmOVRXdEVTZkl5MTJ6?=
 =?utf-8?B?by96Z1U4ZEd6NTl1UkFSVVNQRUYzTE43VDhJY09VMUJQTUY1VE9wUEVweWk2?=
 =?utf-8?B?bUR6VUFmK2Nma0ZrRzJrWjVPYzQxMWo5djlnMGwxUE9sMG5yWXVjNFJjTGRR?=
 =?utf-8?B?azFGVEEvSm1hQXI5Rm9jZHpnbEhoRHVidVBjcnVoa1lYcUpSYmN2UlR6c0ta?=
 =?utf-8?B?N25rV29qc0NMSWtEamovdkV6VThPdGx1RkFEUUsyUGNrcGM1MnRNcGZyREJ1?=
 =?utf-8?B?NURuZmNQcDUxTmo2TldHSkxtcE9tSVdUdWNYdjF0SlNDQldtTVN6ajVoQ1lj?=
 =?utf-8?B?QWJ2Sk1TMi9VRmFHa256VkgzbFNSNXg0L2xvMnpSY0IwQzNzbUhoUVlPTjlm?=
 =?utf-8?B?UEptUjZBT1dvdlBpNXVYOStETkt4Vi94dGNiMjdCcGFtWGxURGRkcG1VZ1JT?=
 =?utf-8?B?SFJFRDE2cHljRXo4VStDUlJkMkxXSFgwN1Y2Yks1RGFLVy9BT1QweEJDRXVm?=
 =?utf-8?B?K3hrczRyRTh1ZzhFVzhkeHVBQ0daZkptV2dHWXFrQk8zK3F5U1RuZ00rN2ZD?=
 =?utf-8?B?bTJnRjVFODRreHMrSXNIN3loYWJxQzluMUFZbUFBRVRzL0Vjam1rQ3dudmtn?=
 =?utf-8?B?OWFFR0l2VVU1S2ZpWm5vSjFLMENXUmM0RVEzVE9ub1NJeXhjTGo5cXJyUlBn?=
 =?utf-8?B?QmNWODRDYU1LT01MWlovbHRvNTNBdm1TUVk3TENGSFJ2L3Z3YzZ5REhHQ1pl?=
 =?utf-8?B?OFptTE1FaU11RXlKMlB5bzBsVVo3ZlpyMzJVdXJDR0hKSHNEQzA2Tmk0V1dH?=
 =?utf-8?B?eVJPRXhiNU5nU2huaWJjU3hrMCtMNmd6SUpZQ2xPNzlWM1pXUFgzTkhhd3M5?=
 =?utf-8?B?cEJiV0xRb3M1R1hoOTl2TytOYVZOdldJM1VQNWxCVHl5ajY2RDZXaEt1a3dK?=
 =?utf-8?B?TVd3Z0JDZGsxUXV1VkZTdHdoWVhvR1lmdjZRVE9GMjQxUnRmSE12QW44aFdU?=
 =?utf-8?B?b2hmRDZSM1FsczFIdDUwRENqQWtkSG1GRUFSeEJIR2lsT1c1Z1dEdTJYTGFi?=
 =?utf-8?B?VjM2VWxPcnNyUzNIbTBOR1ljKzNsSG5Ub1hxMEdMOTBoOFhXMFNpOTJFb2pi?=
 =?utf-8?B?WC91WXYyZ2Y2VWlOSW01bGpWNmlSZzdSMHJRaXVSdEo0YVB5elhMOU5BZjZG?=
 =?utf-8?B?bmprazJxSW1TR0t0N05WVUxvVWRmYnJ6dmxLK3liM3E3bS9jOE5kS2lmUmlW?=
 =?utf-8?B?b3ZybFZjNzNHLzVOTjJhK2dDakhjWXR3Qk8yUUxTQXgzc1lDZG1pSk9uNXhV?=
 =?utf-8?B?U2F6R2JnYnk5N3N4WHBRVVhUSS9pQzlCUmdvUXBDWmkvL0lxY0JqdXNTTDNE?=
 =?utf-8?B?SXVWTGl2ZXB1S05EMzJsUTVtRFlWM3NUbUJGMVpGV3IyQXcrUjRZYmNFYzds?=
 =?utf-8?B?K2RRSXdwakNUL0J2ZXFPTkJFU3g5VmpjYkhNajlBbGZDdXhqUGp4SWZXQ3RT?=
 =?utf-8?B?eUZyeHZqL2psazd4MURHUjhhd09PQWRWV3h0OTRoQnZMOTRaNFd1N2JwREth?=
 =?utf-8?B?RVRVQlBKS0lDVlIzd1NvcGJVVDFUTXZjVUdhckhEU2hSRkNaazAvTTduMFI2?=
 =?utf-8?B?NmVRS0R2WmVRRzNLZXdOSUExWC83SmF1UXc5UjhzQXdRV0hrLzAraWJUWVJG?=
 =?utf-8?B?aW5EQk9UOU1qOE1qaXNXdjEyUGdCM3UxbzYzMzlobGZqU3NsS3R5RmxTbzIw?=
 =?utf-8?B?NzIySE5sNDdyMVR5S0FJemR4YzNEc1lodjNOSER3aEdJUEZudytVUEhTQ0Vm?=
 =?utf-8?B?UldVN2Y1Rk9UZmg4MXpGNDZ3QmVtN2h5SngrZVdlOCtrbkZwSVVKbGhMTEoz?=
 =?utf-8?B?amU1dGhad3k3ZkhrK1plOWVKZnBKaFJDdjVLUFBjbys1TGJJZHYxcVMvZ0lR?=
 =?utf-8?B?MmpJSm9XUEtKa2x3NjJSYUo0L0JLOHJHaFpxV3BXcml3bzRXNWMxNUlHUXFu?=
 =?utf-8?B?VzMrRjRJaWRIQ25lTTlENU1XdXhGbStsK3h2anFjVVNnMmhyTjBWVmd1OUUr?=
 =?utf-8?B?Sm1TT29WSlhWemIrZkZhd2pPbFZnWXRpc3lESU1PZ0FleGl3WWJxWTltUlRO?=
 =?utf-8?B?aWFMY3Q1bG1kbTZlUCthcGl6UkpZdElhdGtXOXZCZGpycHR3Y0grSFI4Zzk4?=
 =?utf-8?B?VzN3UnlWWkJYMk4xZ2FDZXIyNE5hT0N5YTdYSnFrRnNyUDJVVGNjd1RTQU9X?=
 =?utf-8?B?eEhoTHdicEoxeFZOYTZtTEFyYjY4NWFYZXo0SC8vWjN5WDBkcnVPUEVqZm9L?=
 =?utf-8?Q?oTefXNF+UTqpwsGpz6WZsL2+dKWCFEOYfKWnj?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 383e4847-6da5-4838-d864-08de84fd1f4a
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:46:22.4294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFoT0n/SYDEE3joFe0aB3dSAVeTVTymlw2PDwGY3YY4jjUorUpZr6GPnMYxKIogx4aVG1W+U0B7yw29pqGp7gVdb4hsZCArqAL/vdLlddCNs1qgzeWS4Ah3ePBNFAuMJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15595
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

Hi Laurent,

On Fri, Feb 13, 2026 at 05:27:40PM +0100, Tommaso Merciai wrote:
> The RZ/G3E Soc has 2 LCD controller (LCDC), contain a Frame Compression
> Processor (FCPVD), a Video Signal Processor (VSPD), Video Signal
> Processor (VSPD), and Display Unit (DU).
> 
> LCDC0 supports DSI and LVDS (single or dual-channel) outputs.
> LCDC1 supports DSI, LVDS (single-channel), and RGB outputs.
> 
> Depending on the selected output, the correct SMUX2 clock parent must be
> chosen based on the requested duty cycle:
> 
>  - Index 0 for LVDS -> CDIV7_DSIx_CLK (DUTY H/L=4/3, 4/7 duty cycle)
>  - Index 1 for DSI/DPAD -> CSDIV_2to16_PLLDSIx (symmetric 50% duty cycle)
> 
> To support this behavior, introduce the `RZG2L_DU_FEATURE_SMUX2_DSI_CLK`
> feature flag and extend the `rzg2l_du_device_info` structure to include a
> features field. Also, add a new helper function `rzg2l_du_has()` to check
> for feature flags.
> 
> Add support for the RZ/G3E SoC by introducing:
>  - `rzg2l_du_r9a09g047_du_info` structure
>  - The `renesas,r9a09g047-du` compatible string
> 
> Additionally, introduce the missing output definitions
> `RZG2L_DU_OUTPUT_LVDS{0,1}`.
> 
> Introduce `rzg2l_du_crtc_atomic_check()` helper to store the routes from
> the CRTC output to the DU outputs.
> 
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> ---
> v4->v5:
>  - Fixed RG2L_DU_FEATURE_SMUX2_DSI_CLK to RZG2L_DU_FEATURE_SMUX2_DSI_CLK,
>    update commit body accordingly.
>  - Added features field documentation.
> 
> v3->v4:
>  - No changes.
> 
> v2->v3:
>  - No changes.
> 
> v1->v2:
>  - Instead of using clk-provider API to select the right parent clock,
>    based on the outputs. Just set the correct duty cycle based on the
>    output, this reflects at CPG lvl to select the right parent.
>  - Updated commit message accordingly.
> 
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c | 48 +++++++++++++++++++
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c  | 26 ++++++++++
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h  | 12 +++++
>  3 files changed, 86 insertions(+)
> 
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
> index 6e7aac6219be..cc35dd409e3e 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
> @@ -64,11 +64,32 @@
>  static void rzg2l_du_crtc_set_display_timing(struct rzg2l_du_crtc *rcrtc)
>  {
>  	const struct drm_display_mode *mode = &rcrtc->crtc.state->adjusted_mode;
> +	struct rzg2l_du_crtc_state *rstate =
> +		to_rzg2l_crtc_state(rcrtc->crtc.state);
>  	unsigned long mode_clock = mode->clock * 1000;
>  	u32 ditr0, ditr1, ditr2, ditr3, ditr4, pbcr0;
>  	struct rzg2l_du_device *rcdu = rcrtc->dev;
>  
>  	clk_prepare_enable(rcrtc->rzg2l_clocks.dclk);
> +
> +	if (rzg2l_du_has(rcdu, RZG2L_DU_FEATURE_SMUX2_DSI_CLK)) {
> +		struct clk *clk_parent;
> +
> +		clk_parent = clk_get_parent(rcrtc->rzg2l_clocks.dclk);
> +
> +		/*
> +		 * Request appropriate duty cycle to let clock driver select
> +		 * the correct parent:
> +		 * - CDIV7_DSIx_CLK (LVDS path) has DUTY H/L=4/3, 4/7 duty cycle.
> +		 * - CSDIV_2to16_PLLDSIx (DSI/RGB path) has symmetric 50% duty cycle.
> +		 */
> +		if (rstate->outputs == BIT(RZG2L_DU_OUTPUT_LVDS0) ||
> +		    rstate->outputs == BIT(RZG2L_DU_OUTPUT_LVDS1))
> +			clk_set_duty_cycle(clk_parent, 4, 7);
> +		else
> +			clk_set_duty_cycle(clk_parent, 1, 2);
> +	}
> +

I’d appreciate any feedback/suggestions regarding this.
Thank you in advance for your time.

FYI this commit is related to [0]

[0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/53c8d9e7fde7b176e05503a72af81e74c7a8a1c1.1770996493.git.tommaso.merciai.xr@bp.renesas.com/

Kind Regards,
Tommaso

>  	clk_set_rate(rcrtc->rzg2l_clocks.dclk, mode_clock);
>  
>  	ditr0 = (DU_DITR0_DEMD_HIGH
> @@ -248,6 +269,32 @@ static void rzg2l_du_crtc_stop(struct rzg2l_du_crtc *rcrtc)
>   * CRTC Functions
>   */
>  
> +static int rzg2l_du_crtc_atomic_check(struct drm_crtc *crtc,
> +				      struct drm_atomic_state *state)
> +{
> +	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
> +									  crtc);
> +	struct rzg2l_du_crtc_state *rstate = to_rzg2l_crtc_state(crtc_state);
> +	struct drm_encoder *encoder;
> +
> +	/* Store the routes from the CRTC output to the DU outputs. */
> +	rstate->outputs = 0;
> +
> +	drm_for_each_encoder_mask(encoder, crtc->dev,
> +				  crtc_state->encoder_mask) {
> +		struct rzg2l_du_encoder *renc;
> +
> +		/* Skip the writeback encoder. */
> +		if (encoder->encoder_type == DRM_MODE_ENCODER_VIRTUAL)
> +			continue;
> +
> +		renc = to_rzg2l_encoder(encoder);
> +		rstate->outputs |= BIT(renc->output);
> +	}
> +
> +	return 0;
> +}
> +
>  static void rzg2l_du_crtc_atomic_enable(struct drm_crtc *crtc,
>  					struct drm_atomic_state *state)
>  {
> @@ -296,6 +343,7 @@ static void rzg2l_du_crtc_atomic_flush(struct drm_crtc *crtc,
>  }
>  
>  static const struct drm_crtc_helper_funcs crtc_helper_funcs = {
> +	.atomic_check = rzg2l_du_crtc_atomic_check,
>  	.atomic_flush = rzg2l_du_crtc_atomic_flush,
>  	.atomic_enable = rzg2l_du_crtc_atomic_enable,
>  	.atomic_disable = rzg2l_du_crtc_atomic_disable,
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> index 0fef33a5a089..3c20471fdbea 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> @@ -51,6 +51,29 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a07g044_info = {
>  	}
>  };
>  
> +static const struct rzg2l_du_device_info rzg2l_du_r9a09g047_du_info = {
> +	.features = RZG2L_DU_FEATURE_SMUX2_DSI_CLK,
> +	.channels_mask = BIT(0),
> +	.routes = {
> +		[RZG2L_DU_OUTPUT_DSI0] = {
> +			.possible_outputs = BIT(0),
> +			.port = 0,
> +		},
> +		[RZG2L_DU_OUTPUT_LVDS0] = {
> +			.possible_outputs = BIT(0),
> +			.port = 1,
> +		},
> +		[RZG2L_DU_OUTPUT_LVDS1] = {
> +			.possible_outputs = BIT(0),
> +			.port = 2,
> +		},
> +		[RZG2L_DU_OUTPUT_DPAD0] = {
> +			.possible_outputs = BIT(0),
> +			.port = 3,
> +		},
> +	},
> +};
> +
>  static const struct rzg2l_du_device_info rzg2l_du_r9a09g057_info = {
>  	.channels_mask = BIT(0),
>  	.routes = {
> @@ -64,6 +87,7 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a09g057_info = {
>  static const struct of_device_id rzg2l_du_of_table[] = {
>  	{ .compatible = "renesas,r9a07g043u-du", .data = &rzg2l_du_r9a07g043u_info },
>  	{ .compatible = "renesas,r9a07g044-du", .data = &rzg2l_du_r9a07g044_info },
> +	{ .compatible = "renesas,r9a09g047-du", .data = &rzg2l_du_r9a09g047_du_info },
>  	{ .compatible = "renesas,r9a09g057-du", .data = &rzg2l_du_r9a09g057_info },
>  	{ /* sentinel */ }
>  };
> @@ -74,6 +98,8 @@ const char *rzg2l_du_output_name(enum rzg2l_du_output output)
>  {
>  	static const char * const names[] = {
>  		[RZG2L_DU_OUTPUT_DSI0] = "DSI0",
> +		[RZG2L_DU_OUTPUT_LVDS0] = "LVDS0",
> +		[RZG2L_DU_OUTPUT_LVDS1] = "LVDS1",
>  		[RZG2L_DU_OUTPUT_DPAD0] = "DPAD0"
>  	};
>  
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> index 58806c2a8f2b..480a7bdfcd66 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> @@ -20,8 +20,12 @@
>  struct device;
>  struct drm_property;
>  
> +#define RZG2L_DU_FEATURE_SMUX2_DSI_CLK	BIT(0)	/* Per output mux */
> +
>  enum rzg2l_du_output {
>  	RZG2L_DU_OUTPUT_DSI0,
> +	RZG2L_DU_OUTPUT_LVDS0,
> +	RZG2L_DU_OUTPUT_LVDS1,
>  	RZG2L_DU_OUTPUT_DPAD0,
>  	RZG2L_DU_OUTPUT_MAX,
>  };
> @@ -42,10 +46,12 @@ struct rzg2l_du_output_routing {
>  
>  /*
>   * struct rzg2l_du_device_info - DU model-specific information
> + * @features: device features (RZG2L_DU_FEATURE_*)
>   * @channels_mask: bit mask of available DU channels
>   * @routes: array of CRTC to output routes, indexed by output (RZG2L_DU_OUTPUT_*)
>   */
>  struct rzg2l_du_device_info {
> +	unsigned int features;
>  	unsigned int channels_mask;
>  	struct rzg2l_du_output_routing routes[RZG2L_DU_OUTPUT_MAX];
>  };
> @@ -73,6 +79,12 @@ static inline struct rzg2l_du_device *to_rzg2l_du_device(struct drm_device *dev)
>  	return container_of(dev, struct rzg2l_du_device, ddev);
>  }
>  
> +static inline bool rzg2l_du_has(struct rzg2l_du_device *rcdu,
> +				unsigned int feature)
> +{
> +	return rcdu->info->features & feature;
> +}
> +
>  const char *rzg2l_du_output_name(enum rzg2l_du_output output);
>  
>  #endif /* __RZG2L_DU_DRV_H__ */
> -- 
> 2.43.0
> 
