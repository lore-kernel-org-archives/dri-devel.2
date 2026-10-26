Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F68606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=S3mffKzx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DB6C10ED1E;
	Mon, 26 Oct 2026 09:36:22 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010060.outbound.protection.outlook.com [52.101.69.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D473C10ED1E
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:36:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUwDlbIz9kloYIDcidggRyK0ceBjV/Zlg/mCPxcbpxurLDjlUl8J5mqZdujoNUzRrHatFHPyuZILjVMb6J0Hy+VOxS476JrPbsH8bTCFngf6O7Ag4iWeyDYoPwoSg7FV8tjLfqbhIdIPc4UdbUH1HeEilAKPMBxQUJgixxd0FKRaPY+pMvxPQ7i1MSSDg8Hz7a+glQPcCimJU1zntiYvM/2OMS2N/wDTOLnVh7OMgMFqLEMROBaI1/iOq1gmCHBDlMqjmKQi2z51PaIefQpAhsBTWV8vRu92Qe4er1bTVOUMNxbc6qQfyYMmnJK62xD0JyiRLaZeXk1/E15S8NtOqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9crnHvk+Msuoo1SOz47Zy5HKLqjz1md5BXrkLxW8pwQ=;
 b=GpN/tBZ3yFArOY29fPPZStEjG4maUBpYsL7c7uiMCpjfwibnJn8Bn4RvHs/yFQ9O/ndBLd2PuMCPjPGslJOKHq3uj1nZL2ywFZazmGyb5QgKlISCQRwiTJuHsByc259aNlItZ9F4mKknoG8OIeHqVoZAhzIC3IxjrjZaZ7m0WExqCYJ3/w82CstjLA1hpUoLKqeON0lzNrXCkGW1St2uBeTZVgjoSATo2XLwIZrRFM9fcF7dkY1P0UTbGiFMEWk+CJYrsaluaQvdfOad/+ZUepDoCPVgdG4wR0CY472k/7hkyP9VZ17Xz9LsCVSJLmHxf58mGgcOdMCLqivocnvwDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9crnHvk+Msuoo1SOz47Zy5HKLqjz1md5BXrkLxW8pwQ=;
 b=S3mffKzxdlhkLO6xZY5Jxjjy7+Zr4zSW/j1QC4X8U1sk6vfR740qucrqFFs/l21w2lus5dw1Z9NFaxne0qcyH0lfGaHfKC/5aSp5p7Bu2Te1k0dzCd8kFnlbmt2e0jH6ElcKVK+qMVsLFC0tSNpe3Eo8RyyZ3uCTaBzZSdacZU1Xnu9q2us7Oas9Xv8LWacZyDSU36iOEXOCgwkgg+7yIVurjlnfjcqe+PUabZmvznd1ZRyzNobRgdkXlX2GhXEteQRoYjA1HID460h3jpVRE1Ku0NSHr/OiB9VDMrYCQI8/gNrf6CATHBu/rJS2XY9pGv00oZmdIv9kUwb9jX6ltg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by PAWPR04MB11707.eurprd04.prod.outlook.com (2603:10a6:102:509::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 09:36:12 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 09:36:11 +0000
Date: Mon, 26 Oct 2026 17:37:45 +0800
From: Liu Ying <victor.liu@nxp.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@mailbox.org>,
 Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v6 07/13] drm/imx: dc: Use TCON operation mode
Message-ID: <at8faVUk6GOXVjmX@raspi>
References: <20260904-imx8-dc-prefetch-v6-0-26643e3f6cb7@nxp.com>
 <20260904-imx8-dc-prefetch-v6-7-26643e3f6cb7@nxp.com>
 <apqBoxjblzSIuG36@houat>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apqBoxjblzSIuG36@houat>
X-ClientProxiedBy: SI2PR01CA0026.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::16) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|PAWPR04MB11707:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cc04cd6-f047-4cfb-d82b-08df3344927b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|19092799006|1800799024|261009223027099003|261022075727099003|261022105027099003|261021121427099003|10067099003|56012099006|6133799003|22082099003|18002099003|18092099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: jhdPx4+J6kwpx4hw8B8+l3qKQU2rHD0XwVyaLH0YdTHTqDYBSUixd5lTfAQeS2+00xlfLmYsspeuheWHOa5OYSkD18RwsDU2rgztuVJO4eVjnSx1CtKkwl0yYGKAq7K8C8x094ULHGM8CX4bhdH3DLRAhI66hE4rFm7jPVMaAIkvFvXaAfUqHAvgzkgAh7fvBWXznIuedE2apwB9Dm2XaWeV20CzrNOLnnBHrisKabgvWaMCmnsEQBmLjF7j04AmCNQRDodNh0CdIoy6DQBjqqB/TruGnegay0yTsYDx+rHH1fkv8UcCxpS8oa3U9FhDexs09O1q+gR5DX5kQfCs/J0O2UQoGQzl1GvKh11+HGg/LOV1r5Jk7CrSIRUREhFhTZoC5Bnv/ov/P+msdawdD1AXdyO9JU+A5sVJ5rA87IDFZsfb1vMgmWx8gdSxRa10QHAMHzObZ+tdjCLTHozz2DzUktw7NsSdykr/gVz2y8QZtrZ22uimUW1gbsqV1uDj44uGa2TCBq9jKa0jEJhBokR7Y630xpLcR20+yEdsUB/Ii03IA3TsF+X6DOk4pF5j7VEOZ9dlcHAJTCePsc3ZgUbwi5YSUGXWSgoY++7kreNJUFDpBK2mu184UkMywMMdabb4erCBA4EFPYwmVqzNsdd0M/9M8pTt3LK9fSX/ffY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(19092799006)(1800799024)(261009223027099003)(261022075727099003)(261022105027099003)(261021121427099003)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(18092099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sHSvqQTBXw61k9KCfXmcQb1Y52vHWoGwiSjkhqGbk9IRRq/cudKtQSix+C2u?=
 =?us-ascii?Q?mdEaq0nI/P9wkEv3tpxgI2sF1oxbTzcm74uu4dK7YnF8mYIBksWQJ7srVffh?=
 =?us-ascii?Q?xp6bSXp3IxmQbKPslBsrhB6U0WjJA5uvqL/ogjMLjzOHWzCEYuzP10LeedwJ?=
 =?us-ascii?Q?//qrF26U1uVirMtpjSWK3PgpEQqfLsBfSvCMr/sh8dAPZsYyp5QpDIM3NLd9?=
 =?us-ascii?Q?g9zB5jxONLyKhblNGEzfBq+cg5SDKo5YX6mGDINSip0Cnac95TA5cQZWU1O5?=
 =?us-ascii?Q?tceLDeofEMDfHGB2N28iKMDK/7G2fUdeoYNVIdNG813ZItTzxP+xkkAsaqU4?=
 =?us-ascii?Q?vg+Ge6bqhpwSZg3UEO4K62PF4725ycwwQEsZwIpUJJ/YBCOXadaDgIiOaSif?=
 =?us-ascii?Q?POLZqdUJ/8/kyoIOnNFGt50oQvMk7aZgIBELimLFAFBy42SSCvVBd703eNuA?=
 =?us-ascii?Q?i1ourmU4thCaZEMoV3ebS6ZExgKFPs3+BBJvdcdvx355TBxEp6aEdz5ShvbT?=
 =?us-ascii?Q?0zesX0jXhdYHnK8T33kGjM/O6sbKQaQysVZAIKTx0KVO2Mf3W3SWwQNfwXug?=
 =?us-ascii?Q?fGYJGh41kTmUNCmMjYar/A8dpv9zLUXp08bqYlR67afU9/sWZIE/sutr52Nz?=
 =?us-ascii?Q?1VeyWZQ4ozEwmE4GgjUlBY+oi93IHgKdlZ5DtdCg9a9gqPv9QQbsj4Q6BrXC?=
 =?us-ascii?Q?v1IVO/rWWWXKSIQOYRhnpWyJ+g1/IZXhDgas5g55NdB2uxRixrZxrlT5RoU5?=
 =?us-ascii?Q?2E5suAxSdBJPnWTZ3lOqd0Cq2fexvh3WztwvQf5CXhBSEwiamckhI4Py6QG6?=
 =?us-ascii?Q?/NY01VVNREdjq8S2oaB1f5Pha45fCv0TTGH+9NyEzeezZfxf1hY650CckEGC?=
 =?us-ascii?Q?V95s43QvbeeZSXDiUbk7ldtDld7aoqdYj4XX7610MsFQOvd4gQf+58CxH2fG?=
 =?us-ascii?Q?rjuloyVmaHA/GPyBHkStL0EMzkeV5fdG7Ca0/OUokcjuI8OzlWxHj8nxxiQB?=
 =?us-ascii?Q?dIbLeMtA/AbDb4ANajv17XpWIMX3TJvvHNz6hJ2xFn/artw0xdnNahdrqLc7?=
 =?us-ascii?Q?CeROGQ8q5AtxS/GIqmTxSsoGGFr/VZd84OZ2VbH/MdA3dd+muMMmKJHGETkm?=
 =?us-ascii?Q?+PT05LNsWHbU6fQTRYnDKOiXS1R0sCd9wEanQpykVPDhWenwzur+VsJeFrDo?=
 =?us-ascii?Q?9+U7a8Quj4pPF/JqngSkM7PVpXmIN+zaR3ihgYjVUb4RjHZlxF/esJ6ssAnd?=
 =?us-ascii?Q?wCkRBHw0ghrJoHb9PgaSeqHcgoXbkN5AnrSZi125GWHMTQSlscUhKneuDhAa?=
 =?us-ascii?Q?XFdHXh3zGTQXVlwhPI8VIF3L3c8qUr6lv1B4/+X4VGkjd6paQ0pMpa1RGPWJ?=
 =?us-ascii?Q?w2eUGRD0RtOlq/HgEQqF3l8BSKHHKBF1XSnnflIQpH5R74ckAXm5T79vBeau?=
 =?us-ascii?Q?COEXKiscpGoWxnJe17PpbJd9vo0AGCCqFjjJ/4BWN1VEe0ENI/Yki9s4AHYh?=
 =?us-ascii?Q?vmH9ABc0mEqDOiuJ5ntMXB4uVVTlzoMm/7TqD95OVMeaaYcyRI9q21tvQmzK?=
 =?us-ascii?Q?IMUuqhtcuBZzwRkgke6qwuQbfn59O68QKAa6TIk/EwYWuw1mI/x4zcLMJlAK?=
 =?us-ascii?Q?QUPBqebqZw1uOUcDUvDpmYa5WTawkeANDz/eX2SEHR56CcQ0U0bKWhjIzPWQ?=
 =?us-ascii?Q?SkWNe0Xs8oqIBFKxZ4jsaUx8HIBo8/1Ou54v0AP+wgTUm0/NGHMHiZ+naGDR?=
 =?us-ascii?Q?vcDw4twzOw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc04cd6-f047-4cfb-d82b-08df3344927b
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 09:36:11.8996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0aDYRvr/mVyI78ygSbbYLMN2z3rhY3OitwyQQliJU7QMf9/56q6rs/fKyspykTFgDto8w1e0EjSt042hY+uRrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB11707
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Sep 04, 2026 at 10:32:35AM +0200, Maxime Ripard wrote:
> Hi,

Hi,

Sorry for the late reply.

> 
> On Fri, Sep 04, 2026 at 03:54:57PM +0800, Liu Ying wrote:
> > @@ -273,7 +285,22 @@ dc_crtc_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
> >  	dc_ed_pec_sync_trigger(dc_crtc->ed_cont);
> >  	dc_ed_pec_sync_trigger(dc_crtc->ed_safe);
> >  	dc_fg_shdtokgen(dc_crtc->fg);
> > +
> > +	/* Don't relinquish CPU until TCON is set to operation mode. */
> > +	local_irq_save(flags);
> > +	preempt_disable();
> > +
> >  	dc_fg_enable(dc_crtc->fg);
> > +	/*
> > +	 * Turn TCON into operation mode as soon as the first dumb
> > +	 * frame is generated by DC(we don't relinquish CPU to ensure
> > +	 * this).  This makes DPR/PRG be able to evade the frame.
> > +	 */
> > +	DC_CRTC_WAIT_FOR_FRAMEGEN_FRAME_INDEX_MOVING(dc_crtc->fg);
> > +	dc_tc_set_operation_mode(dc_crtc->tc);
> > +
> > +	local_irq_restore(flags);
> > +	preempt_enable();
> 
> That's really not great... Can you expand on why you need this, and is
> there really no other way to do it?

This is a sequence instructed by NXP/Freescale IP designer to ensure
that the prefetch engine(DPRC + PRG) can be enabled reliably - TCON must
be switched to operation mode from bypass mode as soon as FrameGen finishes
generating the first frame(frame index moves).  This is the only way to
do that, AFAIK.

I'll address Sashiko AI bot's comments about local irq disablement in
next version.

> 
> Maxime

-- 
Regards,
Liu Ying
