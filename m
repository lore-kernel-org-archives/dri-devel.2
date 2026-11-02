Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF11606A32E
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 07:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=KV5cDH2t
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 350AE10E58B;
	Mon,  2 Nov 2026 07:51:52 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010027.outbound.protection.outlook.com [52.101.69.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8616B10E574
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 07:51:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVCrpUoox5F4RRi60ZbFPUEEzb57KLMz2+AE6ktI3/xzW7faQDxJN3OIGsMCYZ9BuMzSgiBakGQWLGr+SxwQEjAk96NrsHAwqqedT4udm6vxyzhNUoW+B1b03//mY/GdzjAd0BoaHgojFtVp/V5QTYtSzU4IB2RBbrVnJdld0XT4hWTYQ+GJORoy7HNB/M0M0SEu0/u2fOVPkX84zHKqMd6tS6WFQ5tp2a3ftZvj43X86bO3BFr8q9/Z4aTaH2umeCtv5qf98KwQG6zEMJm1oi+IdSSLPg83JQJskle/IN2XQiqkyjPcYii9UMLhiGF7fDWPG0jbX7Ngo1OEtKepvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJ/aJ8Nr/qlFcxbpvwkWXqHe8owBNaySlKUfRW+2NG4=;
 b=BkIiau3VG3sUDWo7iqVD/9f/agBcpMvK2pzXErjGAtsaO0o4AY5mYPMv2rzgUO+oZLf06YuUhQ6QKQO7868CjIK2Gq6giuNbAvR7rBi6/6WNeCgC9ICFp5oj1BapGu5P00lpFbc8BsG6JoI6QRzsBHo62W1fys4tu2QFC1CUclgAYCjZJO4zNkpyE6GtnHmzPXWUIvdu2XyhQRZEiYqMOkIvbmB2t4UtxeNRDMEWnjZ84NVkY7aXK9O6mgEROFnivormogLxCDm2sPqzkI+do0rX76dVrjWVpLhtLu4lpe+DoZBuICuxkJ8PNG7QPUa6cQp56gsmuaNFjMjDWxNaTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJ/aJ8Nr/qlFcxbpvwkWXqHe8owBNaySlKUfRW+2NG4=;
 b=KV5cDH2tOhk75ZHRHkd2EjOMelo1o3RqmTvot0tXzmjO7gPm7gUMrV0kxNb5alXcpgVNgSRa0N8p9pRoajKi2406a6afwpZTz187O3Rld2eL7bCZMUo7lkIik2kfQGWhMk57avFn9fz4RT/WEVFiJcRJZWE/97ZO2s25Kpv2vf+nr6YdVwmUNptNRljDtlx1W/H028InY9LrRTVdt5X7WqXBzv+WA11CwoBRQusbmNOueHkRBawq9fb2NWqJF1o0uWfrfW7jBJh1xo/ZVvwBoQF/SDlbVSstMJqkuc1OD0jO/dymKubCqwfXi/3oRbfKmcTTuFCum9FwUKZzoM3BdA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by PA1PR04MB10939.eurprd04.prod.outlook.com
 (2603:10a6:102:489::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 07:51:38 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 07:51:38 +0000
Date: Mon, 2 Nov 2026 09:51:32 +0200
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Liu Ying <victor.liu@nxp.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@mailbox.org>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v8 06/15] drm/imx: dc-crtc: Disable at boot
Message-ID: <auhAyqHZSFD0MsUQ@vm>
References: <20261030-imx8-dc-prefetch-v8-0-c4f81afd4533@nxp.com>
 <20261030-imx8-dc-prefetch-v8-6-c4f81afd4533@nxp.com>
 <auR3zOdTi93AhWSS@vm> <aufxSha2jzQJxjWu@raspi>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aufxSha2jzQJxjWu@raspi>
X-ClientProxiedBy: AS4PR09CA0021.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::19) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|PA1PR04MB10939:EE_
X-MS-Office365-Filtering-Correlation-Id: e8ba704c-54c5-455d-b4ec-08df38b61fc5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|1800799024|366016|376014|7416014|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|11063799006|4143699003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: pxSlzbyAKAL1sZ+5bdpqE9V2/38HdSJkGuwcsQCIU9Pe6t27JKNKMW/kgt5UDXnmD6QkhQZkOIiTeq00L6vGJ6YSAt+7Qc/bPWtvAyY7D4uXdAnOTAopCdilz7Hfsg5Yk9nq93P/GQ1iO8z0OWQmDB0UXCvfnJS9aBdW5AiHNpW64zqwvNC7Mre0w6VGOycb0GRRi9BoTEuE8cI5QbXXkoj5EVK6wFDuu0uto6w6iLq7tbuRq9OmvHRG8g0RnQyWOQD+gNm4KN9NcpOg0jCO1aPjxsK7wymSGoOHIds+2Ev5zSVssZ2XIYJiCTNG1tiHSYJwOmE9uCB+wOnSk0Uf7eag4klYO/on/bejh/Dcly/R06WjH+vkMU+ijs1khM5mRSrCdYS5LBeqCmZl1VsoejQUylTEUdLOH/olBg0ds4FEQvw5bJeNxvZl1aG47A/fFcwFFJ9YGkeNfPQHzwAbkCV4Sh4nBH09wEJvBWw9roh8bVciWi7ONU4/YdHZ62l+kuNTr2mb3RyQ8ZO4AA1bsBwniPVhC2Ka85QisJlBJDSqIWMLzoftOrA3hfikpn3RFvjXr872Qz9ibs6Id3GW2g92JzukX5mclaPVRPX6Uro60brFSHpanyoY1N0Pz9dT07+sLjVVGQWTq9WrgLP5Q/p3bVhvRLnSKAem7uryvUU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(1800799024)(366016)(376014)(7416014)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(11063799006)(4143699003)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AIggiwMfQMYW7CQdlOyBO4lkGwdIz75ioke4/HGaGZqCJQhGOqMGDPsGkP9G?=
 =?us-ascii?Q?5riT+qibi1M88Bx3Sz3tCrIIKddpC/X1pe2baHByO8nNX0w0x+uU8DtEeGlV?=
 =?us-ascii?Q?FkBYeEPOGR5/uTHCj7juFWIKPZNhhjUFkOYjnAeNZFTSx1R4/FzYCUWeisos?=
 =?us-ascii?Q?+oeifkyiOulNXJb7b1cmNAKlLd77q3BRAw2u7C8GqvlhfGk6vrHrd/o0SCmQ?=
 =?us-ascii?Q?X3j/LyC/j0PJIRPkUjW9C0Ccc63KpWXlYSSF2cgqm6dCFX0BeHcrJoQcavHc?=
 =?us-ascii?Q?dPr1Ibjxnu/mx6vLqJGMFQ5ODdisZB9ranMvRvSSxPLHciAYTB8UPWqIeZwJ?=
 =?us-ascii?Q?GF4CQhuE6Di7i+MVEXwRvrPVdiC/+b+/LsET8V508aJs1GniGj/1uW2Gm2Yq?=
 =?us-ascii?Q?tP7TL5cgnXJ4fybIx3MT2G3Z2inNynD2LDy50bHfstjzX0C7oAiMNOkSyoY9?=
 =?us-ascii?Q?e3lpfYFZM75CN26WSiZvzBjroyBpsJtZOzOCoHlW9A6I56UlPGsI6T4rngXS?=
 =?us-ascii?Q?3KBPVZd6XU9YUUIpvXFmsIPefSq6+dZhhVgYB0F6bgSyPWLsNrD4F9gMG+JB?=
 =?us-ascii?Q?yzaEcBWEljsIhudlnK/U4cOYFuqmhScqOWf9FCQ16W7Fl/kdyfKfNOGz5C/R?=
 =?us-ascii?Q?n71uGGGAwRtEIEqJyD2Ueyv37aci2G+V/p7/pmD/Xhr2oebWJ2oCmmoVGdl1?=
 =?us-ascii?Q?PgnYBOESK+MJxcjzhjn9ukDWfS2qCBf6MPK6/ZmUDFgu11S5D0Gr16kXgZMR?=
 =?us-ascii?Q?7xOSEgp1ATBRsABAkkW7CP8zfXwf/ffZd258mYmjEXrBBLg2/5W+6/jaNcMr?=
 =?us-ascii?Q?EvS6q1kO7LryCecuoONaAsE9bhfIuTUFz84j0rf9vmOENQBzPRKnovhimaZF?=
 =?us-ascii?Q?628PwmiqtPboBSgjCaK99NOSud0ab9eWpjA4zrYMADDI1mhTQswZH99Rv8tL?=
 =?us-ascii?Q?LSR3ICXlTvnye/N+FFWeLXWqGRibIocqnbF/LFqOK3qUmJnCrRxfaEkEjvnJ?=
 =?us-ascii?Q?gzZUF1ZKGJU5MpOXv3P89hMZoLtU2jej/RX0In2unhnQp90QkfD7KPv3v2ul?=
 =?us-ascii?Q?tjwVbVcV8tOeFjs8Lwveiz0K0kiungPU4K+VkDLwtc88k3oU+7BAcHLItbfj?=
 =?us-ascii?Q?Sq9hxmYpxLeWi3tLsfDJ02btLETSel3kdDGu5tHkuEPGK/NJ0i+CDVJPySGF?=
 =?us-ascii?Q?ETGXHM9Pz+ViLM4wz20nlWmAp23T0lzjCnrHJTkF8JfflD8cKpN3bSW4NpYS?=
 =?us-ascii?Q?JxchJbRqmhS04nYb09+bx6zZmEMUjddoIMYxkofPi3PgqdyXqHqsbzqVzLYK?=
 =?us-ascii?Q?/u5SR+4bqxayB63JrAOEIwIY/x9Zmjx0XiZr6aMdHIJ/pMD2kDtX2HCAnSVN?=
 =?us-ascii?Q?R1lTzz2rbPbMptQ9T72GKThqD/ufDBVEs5GMnyUzbjZ+doDjgtwYTyT463ZF?=
 =?us-ascii?Q?R8BSBfyXiThdvC5OsSqrmbVZr8bX6iXpB2m2zSmONQGIprgwY9RjcGamx8MV?=
 =?us-ascii?Q?HPiKWrXXWFubLUPXavkpkaNL7rMo82Z3CeUVKxQEO0OnTLxetswjQAORMbS/?=
 =?us-ascii?Q?swCZO7XRvWNQDPHkJ9QMDU5+E2l+SdJFKb2Pe/kFB4a9lDOHb41EQDTLpIWP?=
 =?us-ascii?Q?Ewwq/StrAMAxbtjvI9LjCAIb7rYFO2YofRkA3+1tSVO9lloy94JXJYLXbK+o?=
 =?us-ascii?Q?CMdVFBdxCzCYzxcioJkCxXFcuD5dFu4FCWYbcfS3Ejqa16RosNzmg6AotKin?=
 =?us-ascii?Q?nqR/eF80a5z5ZTrO6xz4jQ4ngsBssts=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ba704c-54c5-455d-b4ec-08df38b61fc5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 07:51:38.0994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EYtq+Du3gKy+C+YIMNZkdGNlhuzlAqBC1/iJCtGZlM9no3A1njN+SGXSirLsfVuIqK43vFzPycGm8B/at8cd0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10939
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 02, 2026 at 10:11:22AM +0800, Liu Ying wrote:
> On Fri, Oct 30, 2026 at 03:05:14PM +0200, Laurentiu Palcu wrote:
> > On Fri, Oct 30, 2026 at 05:54:30PM +0800, Liu Ying wrote:
> > > CRTC(s) could still be running after the DRM device is unplugged by
> > > calling drm_dev_unplug(), because the CRTC disablement logic is
> > > protected and bypassed by the drm_dev_enter()/drm_dev_exit() pair.
> > > Hence, Pixel Engine's AXI clock use count(managed by Pixel Engine
> > > driver's runtime PM) and pixel clock use count could be inbalanced
> > > after removing and re-installing the driver module.  To fix this,
> > > add a helper dc_crtc_disable_at_boot() and call it to properly
> > > disable all CRTCs before advertising DRM device to user-space by
> > > calling drm_dev_register().
> > > 
> > > Fixes: 711a3b878366 ("drm/imx: Add i.MX8qxp Display Controller KMS")
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > > ---
> > > v8:
> > > - Call dc_drv_set_crtc_disable() in dc_crtc_disable_at_boot() after CRTC
> > >   is disabled.  (Sashiko AI bot)
> > > - Make dc_crtc_disable_at_boot() return an integer instead of void.
> > >   (Laurentiu)
> > > - Postpone Pixel Engine AXI clock disablement at boot to the time point
> > >   where CRTC1(with index == 1) is being disabled at boot.
> > > 
> > > v7:
> > > - Check CRTC status to ensure that clocks were enabled by a previous boot
> > >   before disabling them in dc_crtc_disable_at_boot().  (Sashiko AI bot)
> > > - Modify debug message in dc_crtc_disable_at_boot().
> > > 
> > > v6:
> > > - Rebase onto the latest drm-misc-next and resolve conflicts.
> > > 
> > > v3:
> > > - Collect Frank's R-b tag.
> > > ---
> > >  drivers/gpu/drm/imx/dc/dc-crtc.c | 72 ++++++++++++++++++++++++++++++++++------
> > >  drivers/gpu/drm/imx/dc/dc-drv.c  | 11 ++++++
> > >  drivers/gpu/drm/imx/dc/dc-drv.h  |  3 ++
> > >  3 files changed, 76 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/imx/dc/dc-crtc.c b/drivers/gpu/drm/imx/dc/dc-crtc.c
> > > index 0d64186a9901..5bc952d6883e 100644
> > > --- a/drivers/gpu/drm/imx/dc/dc-crtc.c
> > > +++ b/drivers/gpu/drm/imx/dc/dc-crtc.c
> > > @@ -227,6 +227,7 @@ dc_crtc_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
> > >  	struct drm_crtc_state *new_crtc_state =
> > >  				drm_atomic_get_new_crtc_state(state, crtc);
> > >  	struct drm_display_mode *adj = &new_crtc_state->adjusted_mode;
> > > +	struct dc_drm_device *dc_drm = to_dc_drm_device(crtc->dev);
> > >  	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
> > >  	enum dc_link_id cf_link;
> > >  	int idx, ret;
> > > @@ -287,29 +288,37 @@ dc_crtc_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
> > >  
> > >  	DC_CRTC_CHECK_FRAMEGEN_FIFO(dc_crtc->fg);
> > >  
> > > +	dc_drv_set_crtc_enable(dc_drm, drm_crtc_index(crtc));
> > > +
> > >  	drm_dev_exit(idx);
> > >  
> > >  out:
> > >  	dc_crtc_queue_state_event(new_crtc_state);
> > >  }
> > >  
> > > -static void
> > > -dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
> > > +static inline void __dc_crtc_disable_fg(struct drm_crtc *crtc)
> > >  {
> > > -	struct drm_crtc_state *new_crtc_state =
> > > -				drm_atomic_get_new_crtc_state(state, crtc);
> > > -	struct dc_drm_device *dc_drm = to_dc_drm_device(crtc->dev);
> > >  	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
> > > -	int idx;
> > > -
> > > -	if (!drm_dev_enter(crtc->dev, &idx))
> > > -		goto out;
> > >  
> > >  	enable_irq(dc_crtc->irq_dec_seqcomplete);
> > >  	dc_fg_disable(dc_crtc->fg);
> > >  	DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(dec_seqcomplete_done);
> > >  	disable_irq(dc_crtc->irq_dec_seqcomplete);
> > > +}
> > >  
> > > +static void
> > > +dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
> > > +{
> > > +	struct drm_crtc_state *new_crtc_state =
> > > +				drm_atomic_get_new_crtc_state(state, crtc);
> > > +	struct dc_drm_device *dc_drm = to_dc_drm_device(crtc->dev);
> > > +	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
> > > +	int idx;
> > > +
> > > +	if (!drm_dev_enter(crtc->dev, &idx))
> > > +		goto out;
> > > +
> > > +	__dc_crtc_disable_fg(crtc);
> > >  	dc_fg_disable_clock(dc_crtc->fg);
> > >  
> > >  	/* request pixel engine power-off as plane is off too */
> > > @@ -318,8 +327,9 @@ dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
> > >  	/* request display engine power-off when CRTC is disabled */
> > >  	pm_runtime_put(dc_crtc->de->dev);
> > >  
> > > -	drm_dev_exit(idx);
> > > +	dc_drv_set_crtc_disable(dc_drm, drm_crtc_index(crtc));
> > >  
> > > +	drm_dev_exit(idx);
> > >  out:
> > >  	drm_crtc_vblank_off(crtc);
> > >  
> > > @@ -331,6 +341,48 @@ dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
> > >  	spin_unlock_irq(&crtc->dev->event_lock);
> > >  }
> > >  
> > > +int dc_crtc_disable_at_boot(struct drm_crtc *crtc)
> > > +{
> > > +	struct dc_drm_device *dc_drm = to_dc_drm_device(crtc->dev);
> > > +	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
> > > +	int ret;
> > > +
> > > +	ret = pm_runtime_resume_and_get(dc_crtc->de->dev);
> > > +	if (ret < 0) {
> > > +		dc_crtc_err(crtc, "failed to get DC display engine RPM: %d\n",
> > > +			    ret);
> > > +		goto out1;
> > > +	}
> > > +
> > > +	if (!dc_fg_wait_for_frame_index_moving(dc_crtc->fg)) {
> > > +		dc_crtc_dbg(crtc, "FrameGen frame index isn't moving\n");
> > 
> > Shouldn't you set 'ret' to something here? Otherwise you'd return the previous
> > ret value, which would be 0.
> 
> We take FrameGen frame index not moving as a normal case, which means
> the CRTC was not enabled before this boot, so returning 0 is fine.

Ok

Reviewed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

-- 
Thanks,
Laurentiu
