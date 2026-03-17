Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486BBFED9FA
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 17:36:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79D7210E57D;
	Tue, 17 Mar 2026 17:36:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="EJbq89Pp";
	dkim-atps=neutral
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazon11011021.outbound.protection.outlook.com [52.101.125.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30B0710E57D
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 17:36:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QNNheT2dn2k4TE8KcMVQdxKI383DS/FlR4kjGdYPQQzuxXTePO/ByG+M28olHBSB+g0Y3zigj9gScjveMTUSBUSnOflmjPU9VtTPKgQ7nboKLSInXyM/Zea6HAxFwLHi9dN4OgJ76h4ERt1BnkefbkkdRC+RqiWNY8OpFuMjSig07uevviX7MpAjZqgNN4NvHWcnuWRdBG0e2WHRHcKTpiq6859DraN5GNDflfYeDRWg4wqVbkiu+OIJcX+PfIUr9ZVI2eQJTES4uhgFBbykW3em+J8KXuteaag9waIYvTUjYl0vjtaTbZTYvCultm80kO/bF4/I8k6qhEqjjOJwLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnXJviPmuPPtJhGm9o2T1cIqHhSG8ikJiEk09rjrEzM=;
 b=Xc4xT7B6Etl3PskQyihiLr/CKIQ9xUuOljpjXrvgkkveeFFWn0gFUb9UVBpLl7e4JoriASe/qFQiWyMmgLAGLby0+2hAJKb2u9DbPiWJRycJrf4sk82AlUoB5dv9MQdwhZQKaavpdffRki68X5xRbb2qI0fJkb80iRQOOgZDorAd1HAOyq9fVkaUjwEwkSokR+vOlDv4zYbqhyGxySgj7Yp/WJ0RFf4j/gVCqHm+7DSaHRMShN24UgNLxknIerxQOZqgEF6tkIHBlwvZJIKnLP2kI1qLKq2NfM5Fbj+yI7rf4QdLJHeqTuayEntaDLsnxGYeCL/6kRkrvPx5vkRnmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnXJviPmuPPtJhGm9o2T1cIqHhSG8ikJiEk09rjrEzM=;
 b=EJbq89Pp25lP5AjP6I8H22mJKVKpEMjRuU2iUBgticCt/2UEr4YjU5sNVnT4D/+TRNAs9AqjM4MBf+nMjutDzauQ8Uktb9CYplLplfloin/3J3Ppym2B1rKkt/4H/DNCpA/N38qL7GuslHcGDPXsV8lmxXMTgZPqoBdcQwZKKJw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY3PR01MB11948.jpnprd01.prod.outlook.com (2603:1096:400:409::5)
 by OS7PR01MB17833.jpnprd01.prod.outlook.com (2603:1096:604:445::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 17:36:43 +0000
Received: from TY3PR01MB11948.jpnprd01.prod.outlook.com
 ([fe80::b718:17d0:6c0f:1495]) by TY3PR01MB11948.jpnprd01.prod.outlook.com
 ([fe80::b718:17d0:6c0f:1495%6]) with mapi id 15.20.9700.025; Tue, 17 Mar 2026
 17:36:43 +0000
Message-ID: <a3beb209-c82d-4386-9a79-480f99658c25@bp.renesas.com>
Date: Tue, 17 Mar 2026 18:36:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/20] drm: renesas: rz-du: Add RZ/G3E support
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Tommaso Merciai <tomm.merciai@gmail.com>, geert <geert@linux-m68k.org>,
 "laurent.pinchart" <laurent.pinchart@ideasonboard.com>
Cc: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, "magnus.damm" <magnus.damm@gmail.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
References: <cover.1770996493.git.tommaso.merciai.xr@bp.renesas.com>
 <152f19a068fcdf27c063e845fe04a48a46c5b47e.1770996493.git.tommaso.merciai.xr@bp.renesas.com>
 <TY3PR01MB11346E0B218CBFD8A403514918641A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <TY3PR01MB11346E0B218CBFD8A403514918641A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::13) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB11948:EE_|OS7PR01MB17833:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bc4688b-21ce-4174-a48b-08de844bc129
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: xeL0BusGj56A6E1Tri/0hDS+fxpDkrFi4zMRdDZIBFYnXwXpHjCh9pG0T6isrWAxgbeJ+KDPwYysgAWUrq7/qLAwxFNy/fA/ydebyAvB4ptcqtWHyBUu8F20nI/mw97JHge+OvG/f+fvdABZN0Ni6oeSpFSY73TaDpBwCG9Q7EKbwrgZMgHtUJfb5ETfuxk+1f1fb2QUX8JFDJm+kKxgkpVtHunac563xXB5pUULW6VPS6JIVMC9Rtk03zfJoLDruyUUmZvLilQJta8OebrJk7A7nRaiI28BmMarrEhAKliMQBA6ZGH4CPkwTyD0vVUL2PNcdI9ZOuU+u5V7M/W0PK5FfHYtUMOuuVdZs8LSk21U3LVd6WzmdkNsYY0mGCDnXKII8K7MILkzjRd3+e1a6Fpng0DxFvvTy6fF0FWELrDqU3nWbjynb4AAAcbwg5UAh932aVsCQnzOFcqLfylDkph8SdANAC98VxRKWPEewm5PNkqzjw4xd08CUo8x9+ScryzOoWH3AkT4KdeVSVxiKYdbkbF8O1kQvY439OjZWTPJkK0X9Cka3SYef475l9yF/+sqotnPZIui/iiPxHFPCiqEwLUP8msDaHYCbZCk2I+T8xG6th5f5bxv30qpPGi4p0z2skiPIMH5Qp3KFnuOpbVW8A0SbhW1Q0IrqvpIstGXT0zVzouCWy1Cdytw45Z8iT3pgJx9WyoofYH7OjuLcz1RXswmNlLrbqYWor94+9s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11948.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmcremJONHVxSy8vaU5KKzZjckdqem5wVW5CalRHNXBaamV5UENYL0dpcXdL?=
 =?utf-8?B?cCtjZWdSVzBIS3c4b2ZzMVBMVXpWZmZ6d1lIc1hUWFFJcGw5cmpVQVl5QlU4?=
 =?utf-8?B?MTc1UFZ6eDkwaDVza3pRZ0FHdnRlc09vZW5nSEhRb1Z4c25Zank2bVRXRDBX?=
 =?utf-8?B?bEo3azA5elJZTUpBU05lTC9NQlljM0p6OFRLc1NTU1I4cy9tNEZveWhMQmU0?=
 =?utf-8?B?QjA5OEtIRXdMWkhXZlFtQWtBYTMxZ2M1Y3dFdURpWU9NZmdjVkhIbDdUejFX?=
 =?utf-8?B?L05zU05kWk0wRGpVTXlXeHp6U2RYUDJMUEd4ZFNVWWNrMEFFUnJkQys3Zllz?=
 =?utf-8?B?eVlKK1lyeDJNS25iNmtCYkZDY2R6bkhLc0lSc0lJYTlOajVxVmVMTTNKVE1x?=
 =?utf-8?B?dDhjYzRVTEplTVJycG05TW42a0U2aXhrV0g3Vzc1Z1I3NnlWaGFmemU4MHBB?=
 =?utf-8?B?bUlKZ3FEcmc1UVFBNWVpdWF0bWZNMVdiRkFwUmlmQ0owem9tSitldHFIMEFS?=
 =?utf-8?B?cXNiMU5yU01XWUtNbmoydlZKY1BhR3paM0p3R25lUW9XWHhHUWs0K3dHSGxq?=
 =?utf-8?B?S210eThLQWg1R2ozRVRQeXNqQVhxU1l3YUFGZEtvUkFFNWhmM09mb29iNWRG?=
 =?utf-8?B?V2QvU05vNXk2Y2FPalhiMTRMaVp2ZkJzcHhPYVRaWFRTbFUzYkRHZHpnUDNu?=
 =?utf-8?B?YmkvQ1ozcnJBZW8wU3I1Y0VVYkJIRlljMFB6WmFSM3RIUTlib3FjMWpTNTBt?=
 =?utf-8?B?b1h4NXhsdnBlZ2ZncjN6dGwrM0RpcjhOeC9JTjFxNFpObDAzb2xSWjMrSHRX?=
 =?utf-8?B?L0ZPbHA2K0lSbjRRc0xLOGRjY203UU14M1dXODltVWVLY0tUT3pYbDNZY3R5?=
 =?utf-8?B?WklsZ2ZFcjduN1ZGZmVEbzdtMElCY25RK1lpczA4aVE5K2VlYUNlaFFHc2o4?=
 =?utf-8?B?MXRzL0dtRWhTbjZOT2lMYWNTNzg4aGUvYWxIZWNzeDVrZ21PYzIrT0I4QXhH?=
 =?utf-8?B?SGFaOGxPV1VDK3B1SG5hU0lEUDd0VTlkQ1FLdW5qZ3lHZlB3SUZtZGpHbFNH?=
 =?utf-8?B?V2pUNkJONmJtd3NXWSs1QzZUS2dRR1FsbUFsSjdNNS93SElkREc2Rk9QblFu?=
 =?utf-8?B?aWZJMEJJVkY0YVVnZE5zSkhGRWlBY3l5cnZTa3cxQXU2SzBGb3ZGZ1I1dXhy?=
 =?utf-8?B?N1Mxd0tEVGtpMGZTem4vMDJKTkREdVhzUGNGOGUySnN1ZFJNcDcvbGhVSk0x?=
 =?utf-8?B?VXd3bGJEZmh5VE0rTFZka3ZoT2ZPbkZ4RGczWFlQUFZ2eXo1K3drb3B0ZzZk?=
 =?utf-8?B?QVRWOFdnR09VYkx6bXAzbDhwOWhMaHdtbE02K2JYWk81RTI0cWUrU2VkUlIz?=
 =?utf-8?B?bSsxeG1hSmtHV0x4UEZUR21Oam1ocW53elE5R1ZqZ0I3aGJwQjl0b0ZVWG9m?=
 =?utf-8?B?cjlEeFdyVGpueDJKR2c2T3FtTXBwUnF0UDRkRHA5TEdXRDRXdnE4c0xjeENt?=
 =?utf-8?B?QVB2alBraUxKUkVMdE1ka2hUYzRuNFE3SlhScnNzV204T2c0dmNFMzV4NFdZ?=
 =?utf-8?B?aUpIZHF1SXBCRU4wSVdDL2ZqeXdnNGFJYmVhQm5XRTdLTUl1OElaazVFdno2?=
 =?utf-8?B?VDlQN0lNTG1sN2ppZUhrMk5wNVkya2taWFJISmtJTGNyWXUwMTYvdXVaejYw?=
 =?utf-8?B?ZU5sQW5Qd3F5N0VlMUVZeGJ4MUVWdEN5UmVuSjR0Yk9qMmR3WU5PQW1IMVFo?=
 =?utf-8?B?NGFpMWwrWVJ2a3FwdkgyTzJCVXQya1QzcHg5NUdoaTU1enphRXhtQURvOUhT?=
 =?utf-8?B?eWx3N3F2RlRra0R1MmVMRWp3WStpVUl5a0MxUmtGV0luK2k4a05QdmZRTEkr?=
 =?utf-8?B?ZkpzcFROZVhGSTdHMEhBUGEyOUk4ZE1ac2NCUjRNMm9lM0l5UkV0eXM1ZlF2?=
 =?utf-8?B?WmlaK2Q3U0x3bDl0dVZyZXp0YjNNK0dqQzg1TGlhN0h0N0p5ZlhJWDFGZnZt?=
 =?utf-8?B?U0d5NUVkY1paZHYrYUJ3TWhGQjVhcjR3OEYweHBrWmhZQU4vSkI1ZXFDaEVJ?=
 =?utf-8?B?UTNyRW5xd0w1ZEhzN2NuU01rNUptUGxpdTFQQW9KRUJYQjZqSEpiRmFGRVV3?=
 =?utf-8?B?MS9keGplRDlVNzhwRTg3UVFYMDdRQjBMSWpTWjI4TlQwdWx3enJQRWtjMGlJ?=
 =?utf-8?B?SElWTE9vVkprYVNsem91bzVHZFZaZlBZaG5DYndjejBuTEFPaFU2M0p0TXBP?=
 =?utf-8?B?MU1lNUR5dmNmdlk0R0RNYlhZMi9HR25ycTVmdUprb0phOHp0a09oLzlqeG9R?=
 =?utf-8?B?Q1FVLzhXUHk2Ykk3N3dWamVSZ3IzNjFidFFCR1ZFK2hCa1RzS1MvNk0wYW1x?=
 =?utf-8?Q?7k8MshWla7LtARI9gMcPY0GFIABill5gtPLMK?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc4688b-21ce-4174-a48b-08de844bc129
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 17:36:43.5094 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k4+m/U/SCrUZAfLvp0oIQqT2NPU/eJu+tGdsQyS0PFf+GHl60LyKwC/WhuQNF9cgjyebmlTvvM1a3VpUnpuq8nlW0rKdG9rD3+JCrTAaeOCOshiH5QEzMy6LZVZ4vAUf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB17833
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

Hi Biju,
Thanks for your review.

On 3/17/26 14:35, Biju Das wrote:
> Hi Tommaso,
> 
> Thanks for the patch.
> 
>> -----Original Message-----
>> From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
>> Sent: 13 February 2026 16:28
>> Subject: [PATCH v5 14/20] drm: renesas: rz-du: Add RZ/G3E support
>>
>> The RZ/G3E Soc has 2 LCD controller (LCDC), contain a Frame Compression Processor (FCPVD), a Video
>> Signal Processor (VSPD), Video Signal Processor (VSPD), and Display Unit (DU).
>>
>> LCDC0 supports DSI and LVDS (single or dual-channel) outputs.
>> LCDC1 supports DSI, LVDS (single-channel), and RGB outputs.
>>
>> Depending on the selected output, the correct SMUX2 clock parent must be chosen based on the requested
>> duty cycle:
>>
>>   - Index 0 for LVDS -> CDIV7_DSIx_CLK (DUTY H/L=4/3, 4/7 duty cycle)
>>   - Index 1 for DSI/DPAD -> CSDIV_2to16_PLLDSIx (symmetric 50% duty cycle)
>>
>> To support this behavior, introduce the `RZG2L_DU_FEATURE_SMUX2_DSI_CLK` feature flag and extend the
>> `rzg2l_du_device_info` structure to include a features field. Also, add a new helper function
>> `rzg2l_du_has()` to check for feature flags.
>>
>> Add support for the RZ/G3E SoC by introducing:
>>   - `rzg2l_du_r9a09g047_du_info` structure
>>   - The `renesas,r9a09g047-du` compatible string
>>
>> Additionally, introduce the missing output definitions `RZG2L_DU_OUTPUT_LVDS{0,1}`.
>>
>> Introduce `rzg2l_du_crtc_atomic_check()` helper to store the routes from the CRTC output to the DU
>> outputs.
>>
>> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
>> ---
>> v4->v5:
>>   - Fixed RG2L_DU_FEATURE_SMUX2_DSI_CLK to RZG2L_DU_FEATURE_SMUX2_DSI_CLK,
>>     update commit body accordingly.
>>   - Added features field documentation.
>>
>> v3->v4:
>>   - No changes.
>>
>> v2->v3:
>>   - No changes.
>>
>> v1->v2:
>>   - Instead of using clk-provider API to select the right parent clock,
>>     based on the outputs. Just set the correct duty cycle based on the
>>     output, this reflects at CPG lvl to select the right parent.
>>   - Updated commit message accordingly.
>>
>>   drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c | 48 +++++++++++++++++++  drivers/gpu/drm/renesas/rz-
>> du/rzg2l_du_drv.c  | 26 ++++++++++  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h  | 12 +++++
>>   3 files changed, 86 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c b/drivers/gpu/drm/renesas/rz-
>> du/rzg2l_du_crtc.c
>> index 6e7aac6219be..cc35dd409e3e 100644
>> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
>> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
>> @@ -64,11 +64,32 @@
>>   static void rzg2l_du_crtc_set_display_timing(struct rzg2l_du_crtc *rcrtc)  {
>>   	const struct drm_display_mode *mode = &rcrtc->crtc.state->adjusted_mode;
>> +	struct rzg2l_du_crtc_state *rstate =
>> +		to_rzg2l_crtc_state(rcrtc->crtc.state);
>>   	unsigned long mode_clock = mode->clock * 1000;
>>   	u32 ditr0, ditr1, ditr2, ditr3, ditr4, pbcr0;
>>   	struct rzg2l_du_device *rcdu = rcrtc->dev;
>>
>>   	clk_prepare_enable(rcrtc->rzg2l_clocks.dclk);
>> +
>> +	if (rzg2l_du_has(rcdu, RZG2L_DU_FEATURE_SMUX2_DSI_CLK)) {
>> +		struct clk *clk_parent;
>> +
>> +		clk_parent = clk_get_parent(rcrtc->rzg2l_clocks.dclk);
>> +
>> +		/*
>> +		 * Request appropriate duty cycle to let clock driver select
>> +		 * the correct parent:
>> +		 * - CDIV7_DSIx_CLK (LVDS path) has DUTY H/L=4/3, 4/7 duty cycle.
>> +		 * - CSDIV_2to16_PLLDSIx (DSI/RGB path) has symmetric 50% duty cycle.
>> +		 */
>> +		if (rstate->outputs == BIT(RZG2L_DU_OUTPUT_LVDS0) ||
>> +		    rstate->outputs == BIT(RZG2L_DU_OUTPUT_LVDS1))
>> +			clk_set_duty_cycle(clk_parent, 4, 7);
>> +		else
>> +			clk_set_duty_cycle(clk_parent, 1, 2);
> 
> What happens if clk_set_duty_cycle returns 0 due to clk_parent is NULL??

If clk_get_parent() returns NULL (e.g., the clock has no parent, or is 
an orphan), the duty cycle is never applied but the code proceeds as if 
it succeeded.

Maybe we should check clk_parent with somenthing like:

     clk_parent = clk_get_parent(rcrtc->rzg2l_clocks.dclk);
     if (!clk_parent) {
         dev_warn(rcdu->dev, "failed to get dclk parent\n");
     } else {
         if (rstate->outputs == BIT(RZG2L_DU_OUTPUT_LVDS0) ||
             rstate->outputs == BIT(RZG2L_DU_OUTPUT_LVDS1))
             clk_set_duty_cycle(clk_parent, 4, 7);
         else
             clk_set_duty_cycle(clk_parent, 1, 2);
     }

What do you think?

Kind Regards,
Tommaso

> 
>> +	}
>> +
>>   	clk_set_rate(rcrtc->rzg2l_clocks.dclk, mode_clock);
>>
>>   	ditr0 = (DU_DITR0_DEMD_HIGH
>> @@ -248,6 +269,32 @@ static void rzg2l_du_crtc_stop(struct rzg2l_du_crtc *rcrtc)
>>    * CRTC Functions
>>    */
>>
>> +static int rzg2l_du_crtc_atomic_check(struct drm_crtc *crtc,
>> +				      struct drm_atomic_state *state) {
>> +	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
>> +									  crtc);
>> +	struct rzg2l_du_crtc_state *rstate = to_rzg2l_crtc_state(crtc_state);
>> +	struct drm_encoder *encoder;
>> +
>> +	/* Store the routes from the CRTC output to the DU outputs. */
>> +	rstate->outputs = 0;
>> +
>> +	drm_for_each_encoder_mask(encoder, crtc->dev,
>> +				  crtc_state->encoder_mask) {
>> +		struct rzg2l_du_encoder *renc;
>> +
>> +		/* Skip the writeback encoder. */
>> +		if (encoder->encoder_type == DRM_MODE_ENCODER_VIRTUAL)
>> +			continue;
>> +
>> +		renc = to_rzg2l_encoder(encoder);
>> +		rstate->outputs |= BIT(renc->output);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static void rzg2l_du_crtc_atomic_enable(struct drm_crtc *crtc,
>>   					struct drm_atomic_state *state)
>>   {
>> @@ -296,6 +343,7 @@ static void rzg2l_du_crtc_atomic_flush(struct drm_crtc *crtc,  }
>>
>>   static const struct drm_crtc_helper_funcs crtc_helper_funcs = {
>> +	.atomic_check = rzg2l_du_crtc_atomic_check,
>>   	.atomic_flush = rzg2l_du_crtc_atomic_flush,
>>   	.atomic_enable = rzg2l_du_crtc_atomic_enable,
>>   	.atomic_disable = rzg2l_du_crtc_atomic_disable, diff --git a/drivers/gpu/drm/renesas/rz-
>> du/rzg2l_du_drv.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
>> index 0fef33a5a089..3c20471fdbea 100644
>> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
>> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
>> @@ -51,6 +51,29 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a07g044_info = {
>>   	}
>>   };
>>
>> +static const struct rzg2l_du_device_info rzg2l_du_r9a09g047_du_info = {
>> +	.features = RZG2L_DU_FEATURE_SMUX2_DSI_CLK,
>> +	.channels_mask = BIT(0),
>> +	.routes = {
>> +		[RZG2L_DU_OUTPUT_DSI0] = {
>> +			.possible_outputs = BIT(0),
>> +			.port = 0,
>> +		},
>> +		[RZG2L_DU_OUTPUT_LVDS0] = {
>> +			.possible_outputs = BIT(0),
>> +			.port = 1,
>> +		},
>> +		[RZG2L_DU_OUTPUT_LVDS1] = {
>> +			.possible_outputs = BIT(0),
>> +			.port = 2,
>> +		},
>> +		[RZG2L_DU_OUTPUT_DPAD0] = {
>> +			.possible_outputs = BIT(0),
>> +			.port = 3,
> 
> Maybe use .port = 1 for DAPD0 for consistency with RZ/G2L.
> 
> 
>> +		},
>> +	},
>> +};
>> +
>>   static const struct rzg2l_du_device_info rzg2l_du_r9a09g057_info = {
>>   	.channels_mask = BIT(0),
>>   	.routes = {
>> @@ -64,6 +87,7 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a09g057_info = {  static const
>> struct of_device_id rzg2l_du_of_table[] = {
>>   	{ .compatible = "renesas,r9a07g043u-du", .data = &rzg2l_du_r9a07g043u_info },
>>   	{ .compatible = "renesas,r9a07g044-du", .data = &rzg2l_du_r9a07g044_info },
>> +	{ .compatible = "renesas,r9a09g047-du", .data =
>> +&rzg2l_du_r9a09g047_du_info },
>>   	{ .compatible = "renesas,r9a09g057-du", .data = &rzg2l_du_r9a09g057_info },
>>   	{ /* sentinel */ }
>>   };
>> @@ -74,6 +98,8 @@ const char *rzg2l_du_output_name(enum rzg2l_du_output output)  {
>>   	static const char * const names[] = {
>>   		[RZG2L_DU_OUTPUT_DSI0] = "DSI0",
>> +		[RZG2L_DU_OUTPUT_LVDS0] = "LVDS0",
>> +		[RZG2L_DU_OUTPUT_LVDS1] = "LVDS1",
> 
> Normally new additions are done at the bottom of the array.
> 
> Cheers,
> Biju
> 
>>   		[RZG2L_DU_OUTPUT_DPAD0] = "DPAD0"
>>   	};
>>
>> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h b/drivers/gpu/drm/renesas/rz-
>> du/rzg2l_du_drv.h
>> index 58806c2a8f2b..480a7bdfcd66 100644
>> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
>> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
>> @@ -20,8 +20,12 @@
>>   struct device;
>>   struct drm_property;
>>
>> +#define RZG2L_DU_FEATURE_SMUX2_DSI_CLK	BIT(0)	/* Per output mux */
>> +
>>   enum rzg2l_du_output {
>>   	RZG2L_DU_OUTPUT_DSI0,
>> +	RZG2L_DU_OUTPUT_LVDS0,
>> +	RZG2L_DU_OUTPUT_LVDS1,
>>   	RZG2L_DU_OUTPUT_DPAD0,
>>   	RZG2L_DU_OUTPUT_MAX,
>>   };
>> @@ -42,10 +46,12 @@ struct rzg2l_du_output_routing {
>>
>>   /*
>>    * struct rzg2l_du_device_info - DU model-specific information
>> + * @features: device features (RZG2L_DU_FEATURE_*)
>>    * @channels_mask: bit mask of available DU channels
>>    * @routes: array of CRTC to output routes, indexed by output (RZG2L_DU_OUTPUT_*)
>>    */
>>   struct rzg2l_du_device_info {
>> +	unsigned int features;
>>   	unsigned int channels_mask;
>>   	struct rzg2l_du_output_routing routes[RZG2L_DU_OUTPUT_MAX];  }; @@ -73,6 +79,12 @@ static inline
>> struct rzg2l_du_device *to_rzg2l_du_device(struct drm_device *dev)
>>   	return container_of(dev, struct rzg2l_du_device, ddev);  }
>>
>> +static inline bool rzg2l_du_has(struct rzg2l_du_device *rcdu,
>> +				unsigned int feature)
>> +{
>> +	return rcdu->info->features & feature; }
>> +
>>   const char *rzg2l_du_output_name(enum rzg2l_du_output output);
>>
>>   #endif /* __RZG2L_DU_DRV_H__ */
>> --
>> 2.43.0
> 

