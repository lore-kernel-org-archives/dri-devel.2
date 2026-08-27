Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E79CC61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 09:33:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D6BE10E3CF;
	Thu, 27 Aug 2026 09:33:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="EBlW2fuV";
	dkim-atps=neutral
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010053.outbound.protection.outlook.com [52.101.228.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7073A10E3CF
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 09:33:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vsOC+ivbszWazZGjgay43Ovh38JGwWzhulpl5VDHK/PbvVzj/ko6z9l82X4cDK8wAOdEVeLfe3k9waumRQcCKLUt2SOEV/Wsm+DSkI3TfGyyv5X0vwhOidXLUBkZK5Ko1mF2VKsIq6EwTVO3H9v5oA8QXNLadrxpFhf9TMyz+gz0z7vlxN0hzq4bA+i5nIJMxR9yT18BpCH+3gvbYqFQFDzFtIl3+0hfsiQOrhaN4iu+2tizdDSLIYrlQdZQ/E4j7o0uGw/IHlZ1TFQ1jfpBA3i36ZQDDzwUtbXJ0ZVAXjQ0uQjurJrcOLyfkTyhrqPi30FS2BxMXtS6Y7XvLhGPXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DrSdYt3/jbKTm0IpgjuoMyzLyk9PAdO5JHPgR7u1/1M=;
 b=Bo2iKm5MNsDkYnwXrBupsXg/Yl4DK51GOIzZsFhlx4HgaCYFuCgwm45vlYdl1E2y4SMc1bzLB4pU8nX/6jO+qhDbiV84xMmgPD+JCZmQLsivgPDxoxhbv/wwCkblLzVenfF6V4P2NAj+sjKSAj1nJzUmSE+acnZUVLQKFi9unECks2aVsS131VnbjJBzE08N6xN6N7S07GI1BRMjPWZmBe0FPh9na/dfa8RHBoCjR1eirUM+La2u7iD+yN16FMnO0+xWOFq9opKRCsXmikBKu81LrFjmEZNdAPrdq11y3rRRg1fe1sZacRiSy3JEL5mazh5cFvpBInDz5qpQB8miXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrSdYt3/jbKTm0IpgjuoMyzLyk9PAdO5JHPgR7u1/1M=;
 b=EBlW2fuV6r2XR3bvGEgVsT0bIBhhBHeQOOgN2DyGr5I46vl4REd123Sm5XcIMjo6jY/fmdLWYD+WzEORfUEoB6YfInXKPONN4uHTwiwLTdNxGpSGrk77JBtGRVxQ/QwMADmHEMetPfovpZApPnM65eLcDWmvvFWalV4ujVtP7+M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by OS7PR01MB18490.jpnprd01.prod.outlook.com (2603:1096:604:4c1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Thu, 27 Aug
 2026 09:33:46 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 09:33:46 +0000
Date: Thu, 27 Aug 2026 11:33:31 +0200
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Biju <biju.das.au@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 06/13] drm: renesas: rz-du: Add RZ/G3L (R9A08G046) DU
 support
Message-ID: <apAEa8tPBgejxzX0@tom-desktop>
References: <20260826174854.199139-1-biju.das.jz@bp.renesas.com>
 <20260826174854.199139-7-biju.das.jz@bp.renesas.com>
 <ao_xad3vB1e00GID@tom-desktop>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ao_xad3vB1e00GID@tom-desktop>
X-ClientProxiedBy: LO4P123CA0479.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::16) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|OS7PR01MB18490:EE_
X-MS-Office365-Filtering-Correlation-Id: cce97812-769c-4623-66dc-08df041e4af3
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|366016|23010399003|376014|7416014|38350700014|10067099003|56012099006|5023799004|4143699003|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: f107sx8fWm4zS84V3iwduq/UKcASZqdHQUW2OL3LdfsNKiAxceEW20em/z3hfgjNpEcc8tuAG9pLMJ+3agnS74Q58zBgctkjiMBNdO04L0QoTee8bhFajxDsId2aKwsBxWToC2PsdyRd9K2KEL4ktWmebd6fgZL6wV6bkW+wkmZk9TKkx6zFrk7lprBkgxR5wZScjowBhzy/Cufo2agfBnsgCKOWQaoVk1+iHlBZyoyVLlS1+1qzbsrQ/wuPp/sW8LvrwFJ/LCwWAKq33WyQTHr4Gh/E+1/63SAXotQ6FibPVSc+8lidWCrQMAzc2d2RPuzWL6v+4nwhPgmJBxgaYN8GiWJ0fscztg1GBaFpBGmgjMNJscwMyTT6vFse8DjAetMHYPAnDwuGFZ8TK/jqjbweETvplBxNR8zc1lnA03DtT/v3rIpHgeBI/uIWK9+CkxK3w9jNPfrB6NsxlZAghfNGYwYU/TFMxzuDP4NzWDpAcE9a1YvqdV85mznjU9K5iGHEu+xN5olBpQd7zFF5wauWs8K015Ew6zCU1ajGjeb/jozXdmrQDdrbVEn8XahjFRy9kcznLE2BOZmAyFIPbkMVy+BGsn+mpfRzDpUq2BzB90S4mfNGwKtCjIwjMZDue/6LE/5Inh5kxCh5lfroB0yPBXkQQGOXqMtFAk/ZOt4OR9sPhmoUP9mDZ5Oe2nt/3RNPPvfyKIuVTVTCXzInXZy/PZ2YTH4cBvSKsJuN484=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYRPR01MB13588.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(366016)(23010399003)(376014)(7416014)(38350700014)(10067099003)(56012099006)(5023799004)(4143699003)(11063799006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkNoQnlDaVF5SFNNTW0xV0JpTFEzaTZYcUpSbG02S1Z1ZGtOeFN1ZTJnRTFu?=
 =?utf-8?B?K054Z080Q0hYM2p4azVMb1JmZU8rUW5zbkFLYmE4SjFxSjJFUU8wYmt5UW5J?=
 =?utf-8?B?NzVZV2VwRi9uYTJkcUN2VGszNXRBcldVc2hKUDVnNGFrb2QyL3hvdWdCdFlZ?=
 =?utf-8?B?OUI5aHJaa2d2ZVl0bzZrb25EandSMzIyZHFyV0RtcGdDYW1oM2NOVm5yV1k4?=
 =?utf-8?B?MjFEdzZGQm9OWElyRFpwZmJPZ0RtY25JNGl6RnA5cmhFS3U4bHhqeVg0Zitx?=
 =?utf-8?B?VmErSkJZa1U3eEpDNmlSM09oa2NOblpybTgwNnMxTmF5Mis2SW9Ba21KcWxh?=
 =?utf-8?B?a01tb0lCejZSUTNsYmNHcytXSDZ5M3ZaT3h0UzZzSjNLcC96ZitIdWdzalFS?=
 =?utf-8?B?dUZXbitBbHJWckdFRVlCNTkwNEpVVVFlYXp1ay8yMjlJWXJ4SHdHbU83a3pI?=
 =?utf-8?B?cTJDUVdQc2M3LzlxQkY1cUE3UkkzRTNyR20yc21sRWZwcGI2SS9aWExIK0h2?=
 =?utf-8?B?YjJJNkJhNllSNHRDZHBnR2hWYzgyOW5GTHhndVd6M2ZkeFpmTHF2UVU1bmJO?=
 =?utf-8?B?aXF6cHJkVDNSZHVpVkJPUU9UZXdVRVZZOS9sT0t5ZFhMSUdYZndtb3cxQjdE?=
 =?utf-8?B?RmJ0MG1kZDlWZGxTbllzTVFMY3l3a2R5NUdyUVI5dHByakwwcDRadW1nL0w3?=
 =?utf-8?B?Z2VXeGVFdUJ0Y0tweUp5VHJmbFJoRFNlaG5OL2NLdjdGRW9UbTB0cFROZzlw?=
 =?utf-8?B?cW1LSDExZmw0bm9COFFrRXh2clR1cHBvbTk5NFJQeVAxWWphWHl6Y3lnT1E4?=
 =?utf-8?B?M2o5QTFUYXpTZ0hmYm5YRU5sbVBLK2FkSmg2ZHV5cWV6bjlwZGFUbUxuZSth?=
 =?utf-8?B?YmV6QWY5OUhmVk1pZlhGRUJPNERoWlRjQVQzU0xva09XRHJtL1hFdmxxempl?=
 =?utf-8?B?RjZiVlJUcVJac3hzZGNESkoxb0MrSWlWemsrYzNXdld5RlRJREEwb0wrbGxM?=
 =?utf-8?B?cGlIbGNiV2NFQS95NFdZUEpsS1NpUjRqbDRwYWhVNjFPYUZ6VUVNb3JlNkxl?=
 =?utf-8?B?MC9paDg4NzV3VHpLRkVybjhXWGlOTjl4ektETlFjcHhpRHdtLzQ1Q01ia2g3?=
 =?utf-8?B?MFhCK2EyY29taFcrSllpR3NKNEUybTBtblFDRGV6Z1UwbE9YdC9sZW1nQ1px?=
 =?utf-8?B?Smo0SUxCdkdab3ZrTVRudCs0ZFJPa1RjeHFuWkcvcDBLbXBQMEhqS2M4V0I4?=
 =?utf-8?B?VFIwa1M2bzhNSEFCMFVRcHVoNjhDREZ0akp5djh3RTRBRCtzbklRdGk4MHpC?=
 =?utf-8?B?S0Q4UGZVb2ZNZlY5UzNMWUVOUmFZbTYvT1RjMmZtNEF5UnhlNnZkdWhIb25X?=
 =?utf-8?B?V3diVk9ic2NrbmdiQXlsSEZxWndvWHJ3SUgzUUx1UEp5c013QmJqWENvVXJ5?=
 =?utf-8?B?anBNZm9VNkRBeVY4U3BkZlpVZ0pPNmo4WUxJcXlzbVdYYWh2L09abEV0V0Jl?=
 =?utf-8?B?dC9lU3E3QkFNdlNjZDdRb05YZWJUWk1QcFNYZlZHZC9ZTExCL0x4RXpYSXZP?=
 =?utf-8?B?L3ppbk5CNzRIR1lIbWpIdkZyL1VXUkIxU3pnOXhTUmlMNDNRYUNYTlFpUnpW?=
 =?utf-8?B?aUNZOFNYU2N2MlVLb1dXY1BMYXZFWGozMmttUFNpMVJXK2tEZ0tURG1aSlBK?=
 =?utf-8?B?aEY1MHRiYzVNN0pFZTNnQlBqNjRXL2tDSkk4bUthR2NZQnJLSmRqOUhMRUpG?=
 =?utf-8?B?S1dWNVdLV0lHRDVqVDQvd0xyRXFqK0lHTi9HM3lJM2tDbUgydVhyaUgxVkJr?=
 =?utf-8?B?QzF2d2M1WXB4SXVYMjhmMVdiUlZmU25rcDZVYVpGU2FOcGszblo5eHU0TGpj?=
 =?utf-8?B?aTdMYkM1T1M3UERXUUpwdGUzYjltVXcyclp5T1hGOTAvaWw5TENsVDZTaDZx?=
 =?utf-8?B?cmZXdmIydkVyWHFJS0JqcWJYTW8ySHNWdVl0TFljRVFqc0kyNFV6NHZCcGlR?=
 =?utf-8?B?bTZVVUh5NTIzMlB4cTBHMURHWDFTc2NKTStsTDJleFdaOHE5WGprOUduUFpp?=
 =?utf-8?B?Zmp2dzFralFVRWRlWUMrSDNEcUJuNnhWZm9aVUZmYVZXVnhOQkl4bm53d3Za?=
 =?utf-8?B?MTU4eTdQdm1BMUZTalFmbDNhSEl3NFZpZDQra0JuS3NuTzlIYlE2alp0TE02?=
 =?utf-8?B?LzgySGhJM3l2UDBscWJiVGtoc2IxSE5kNGl0ZEdET1FqVFQybkd6MXZtWDNs?=
 =?utf-8?B?NzNENXhxbHBZb1lwY3dTSHRMd1QreFJRZVBoaUYrY2F0VHZxcTFKZVZ0aTRv?=
 =?utf-8?B?bVEvQkxPZWNtTEJGeWg2aXprNXd6YmpKM0haM0wxZzVjNDRTemFFZkJTOHhl?=
 =?utf-8?Q?MHAYVo0/TaLIplT8am9WHEcx6+PgQXMCBqF6q?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce97812-769c-4623-66dc-08df041e4af3
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 09:33:46.4661 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FE8ABrpst9bBLBzPDnBIntn6YtvL1ia1x4D9Z/HYKgtiXuvd5Hh9xDDf5K5kv5X7jKDf1ZURqjtxIfrO0nHlothq1s9DK2mKpb5yIH6sS/nVXCVtWjGkFpC7uKsk5HxU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB18490
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

On Thu, Aug 27, 2026 at 10:12:25AM +0200, Tommaso Merciai wrote:
> Hi Biju,
> Thanks, for your patch.
> 
> On Wed, Aug 26, 2026 at 06:48:40PM +0100, Biju wrote:
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> > 
> > Add Display Unit support for the Renesas RZ/G3L SoC (R9A08G046). It is
> > similar to the one found on RZ/G2L, but has LVDS support.
> > 
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > v2->v3:
> >  * Set duty cycle handling in DU encoder
> >  * Added min/max frequencies for DPI.
> > v1->v2:
> >  * Dropped the macro RZG2L_DU_FEATURE_SMUX2_DSI_CLK and RZG2L_DU_MAX_LVDS.
> >  * Dropped the variable rcdu from struct rzg2l_du_encoder.
> >  * Dropped the variable lvds from struct rzg2l_du_device.
> > ---
> >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c  | 24 ++++++++++++++++++-
> >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h  |  3 ++-
> >  .../gpu/drm/renesas/rz-du/rzg2l_du_encoder.c  | 24 +++++++++++++++++++
> >  3 files changed, 49 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > index 3d13f61d3c97..6c2dc86abc7d 100644
> > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > @@ -55,6 +55,26 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a07g044_info = {
> >  	.mode_clock_max = 83500,
> >  };
> >  
> > +static const struct rzg2l_du_device_info rzg2l_du_r9a08g046_info = {
> > +	.channels_mask = BIT(0),
> > +	.routes = {
> > +		[RZG2L_DU_OUTPUT_DSI0] = {
> > +			.possible_outputs = BIT(0),
> > +			.port = 0,
> > +		},
> > +		[RZG2L_DU_OUTPUT_DPAD0] = {
> > +			.possible_outputs = BIT(0),
> > +			.port = 1,
> > +		},
> > +		[RZG2L_DU_OUTPUT_LVDS0] = {
> > +			.possible_outputs = BIT(0),
> > +			.port = 2,
> > +		},
> > +	},
> > +	.mode_clock_min = 5440,
> > +	.mode_clock_max = 87000,
> 
> Pixel clock must be within the following range:
> 
> 	– Parallel = 5.4 to 87 MHz
> 
> rzg2l_du_encoder_mode_valid() is checking the DPAD0
> output mode clock then here we should set:
> 
> 	.mode_clock_min = 5400,

Apart for that the rest LGTM.

Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

Kind regards,
Tommaso

> 
> Thanks, Tommaso
> 
> 
> > +};
> > +
> >  static const struct rzg2l_du_device_info rzg2l_du_r9a09g057_info = {
> >  	.channels_mask = BIT(0),
> >  	.routes = {
> > @@ -81,6 +101,7 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a09g077_info = {
> >  static const struct of_device_id rzg2l_du_of_table[] = {
> >  	{ .compatible = "renesas,r9a07g043u-du", .data = &rzg2l_du_r9a07g043u_info },
> >  	{ .compatible = "renesas,r9a07g044-du", .data = &rzg2l_du_r9a07g044_info },
> > +	{ .compatible = "renesas,r9a08g046-du", .data = &rzg2l_du_r9a08g046_info },
> >  	{ .compatible = "renesas,r9a09g057-du", .data = &rzg2l_du_r9a09g057_info },
> >  	{ .compatible = "renesas,r9a09g077-du", .data = &rzg2l_du_r9a09g077_info },
> >  	{ /* sentinel */ }
> > @@ -92,7 +113,8 @@ const char *rzg2l_du_output_name(enum rzg2l_du_output output)
> >  {
> >  	static const char * const names[] = {
> >  		[RZG2L_DU_OUTPUT_DSI0] = "DSI0",
> > -		[RZG2L_DU_OUTPUT_DPAD0] = "DPAD0"
> > +		[RZG2L_DU_OUTPUT_DPAD0] = "DPAD0",
> > +		[RZG2L_DU_OUTPUT_LVDS0] = "LVDS0"
> >  	};
> >  
> >  	if (output >= ARRAY_SIZE(names))
> > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> > index baf076d69cda..e9626ef37cde 100644
> > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> > @@ -25,6 +25,7 @@ struct drm_property;
> >  enum rzg2l_du_output {
> >  	RZG2L_DU_OUTPUT_DSI0,
> >  	RZG2L_DU_OUTPUT_DPAD0,
> > +	RZG2L_DU_OUTPUT_LVDS0,
> >  	RZG2L_DU_OUTPUT_MAX,
> >  };
> >  
> > @@ -33,7 +34,7 @@ enum rzg2l_du_output {
> >   * @possible_outputs: bitmask of possible outputs
> >   * @port: device tree port number corresponding to this output route
> >   *
> > - * The DU has 2 possible outputs (DPAD0, DSI0). Output routing data
> > + * The DU has 3 possible outputs (DPAD0, DSI0, LVDS0). Output routing data
> >   * specify the valid SoC outputs, which CRTC can drive the output, and the type
> >   * of in-SoC encoder for the output.
> >   */
> > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
> > index 3d0999e4fcfd..a1b48973aa8e 100644
> > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
> > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
> > @@ -7,6 +7,7 @@
> >   * Based on rcar_du_encoder.c
> >   */
> >  
> > +#include <linux/clk.h>
> >  #include <linux/export.h>
> >  #include <linux/of.h>
> >  
> > @@ -15,6 +16,7 @@
> >  #include <drm/drm_bridge_connector.h>
> >  #include <drm/drm_panel.h>
> >  
> > +#include "rzg2l_du_crtc.h"
> >  #include "rzg2l_du_drv.h"
> >  #include "rzg2l_du_encoder.h"
> >  
> > @@ -64,8 +66,30 @@ rzg2l_du_encoder_mode_valid(struct drm_encoder *encoder,
> >  	return MODE_OK;
> >  }
> >  
> > +static void rzg2l_du_encoder_atomic_mode_set(struct drm_encoder *encoder,
> > +					     struct drm_crtc_state *crtc_state,
> > +					     struct drm_connector_state *conn_state)
> > +{
> > +	struct rzg2l_du_encoder *renc = to_rzg2l_encoder(encoder);
> > +	struct rzg2l_du_crtc *rcrtc = to_rzg2l_crtc(crtc_state->crtc);
> > +	struct clk *clk_parent;
> > +
> > +	clk_parent = clk_get_parent(rcrtc->rzg2l_clocks.dclk);
> > +
> > +	/*
> > +	 * Request appropriate duty cycle
> > +	 * - LVDS path has DUTY H/L=4/3, 4/7 duty cycle.
> > +	 * - DSI/RGB path has symmetric 50% duty cycle.
> > +	 */
> > +	if (renc->output == RZG2L_DU_OUTPUT_LVDS0)
> > +		clk_set_duty_cycle(clk_parent, 4, 7);
> > +	else
> > +		clk_set_duty_cycle(clk_parent, 1, 2);
> > +}
> > +
> >  static const struct drm_encoder_helper_funcs rzg2l_du_encoder_helper_funcs = {
> >  	.mode_valid = rzg2l_du_encoder_mode_valid,
> > +	.atomic_mode_set = rzg2l_du_encoder_atomic_mode_set,
> >  };
> >  
> >  int rzg2l_du_encoder_init(struct rzg2l_du_device  *rcdu,
> > -- 
> > 2.43.0
> > 
> 
