Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A313606A32D
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 02:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=CgP8uph2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A56410E4F4;
	Mon,  2 Nov 2026 02:09:55 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013001.outbound.protection.outlook.com
 [52.101.83.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC9F410E4F4
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 02:09:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AEv3CEs19i2HeaVhQ/rn3qmvZxYBabfDfwuM+epR6qgyyRLgCOTgt8PW1xSSU7LtD3Yq6OFza6WA93VaYPCNBT0m2rVasO6KlNYVxy0TDdmQpG4ma5Ma8oDebLHWRadIsy9LtiYGgMp9aTBrgZNM4V10fJCumpL8nq5wsBkK2YY90kzL+KoDmKul5RvjpgHsdQ3VYVEiJT5hMmN5dU6H9+ttlesDpxma8D2y2DLsxG7lVh+SDe9GJyjSu8raBTb2/6zl0yQfhCZTicjyUwAiQB0sWR3ON2gOX/qoBJFesUimr8GCt5/lx/JR9P+uDOtCwDmntigXxiZ2ckZZGBKlCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8u5LARDAU4S+2COIAr4v1zU7mc+NcezcGi+X/Mp1Uo=;
 b=haq3MoAhb/rHZGECjsW5mVxHMPAO2JnwBDcpdm+SGSayjK1BEXgrmG1VhNt25E8iFefs1NV40we8IN1jbXsW9muMsPz42bcMjh7rVHUNwWTYaiRuTVWoPH+2xriaNLEgbscCY7+bWn7H4E0CKAEvNmJqtcB3uLizIfBGMf9J/OK1WnGjRQvT87QthRMZ65kDseljXVa+af/ekskr/d+v0jOQ+ADmU+LcZdUnRZkxaEtZRZE563DrDZMyEvSTFeP8E6jLr5wGklNQpSO7ZreEXUUJcx8X68Cs10KcPHOwRm2PrXSvvh5YVrVP9dn+Ma/Rg+z4XEkJeTsDG/1yR0yuIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8u5LARDAU4S+2COIAr4v1zU7mc+NcezcGi+X/Mp1Uo=;
 b=CgP8uph2QGEd2ofEULqEkwMTr6xxVw+B6H6FWR3kfrTi4aab141d8aa5J7QdwasRS1wGIYWHYjg0dzb3oxwF9waQqxWvXWU/k73KmhQ2IJ+f7X0jN71sAMIxNhzlEr4i9NIaX+5XX7WuiLIDJtW1sDPG7KYUgS10Qhn2wTwbpoymBF+rVAjOSY2/RX4BbCWx5md+twWjzbORrQLAVFr/T3T/IczbcSHzdk7CxP+NkLWd+0IA52wZEcHc+jwyDybEwdtAo2IIj2bMRoafwWXa1mSAZBrLlZCa4QClYJRV2f3Fi9Zw880zqtYhYFjncpSTuMmndWOhg9clh0e+ER7Wsg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by PAXPR04MB9400.eurprd04.prod.outlook.com (2603:10a6:102:2b2::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 02:09:45 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 02:09:45 +0000
Date: Mon, 2 Nov 2026 10:11:22 +0800
From: Liu Ying <victor.liu@nxp.com>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
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
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v8 06/15] drm/imx: dc-crtc: Disable at boot
Message-ID: <aufxSha2jzQJxjWu@raspi>
References: <20261030-imx8-dc-prefetch-v8-0-c4f81afd4533@nxp.com>
 <20261030-imx8-dc-prefetch-v8-6-c4f81afd4533@nxp.com>
 <auR3zOdTi93AhWSS@vm>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auR3zOdTi93AhWSS@vm>
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|PAXPR04MB9400:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c481ecf-b1b9-4bf8-0889-08df38865d33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|7416014|19092799006|4143699003|11063799006|56012099006|261009223027099003|261028144727099003|261021121427099003|261021123027099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3BjUOH6AMwC9JMU3Ivh+nIfx+gPzm+1iVoaZ3KPkMDX8nKEqsWd/cC09shzeArBsyzIrfB70gDg/YyPbfLLU+1dY6J4DLNUE6UT40KN81/ER5wS5HA76qn1lmwfBmn+HqxKIptKOpszj9MF9M2Zgd/1NySP58wOhePxwPm3aA7hlucvSeYieuJTESymDyyhfwXh2zO+wdUvN6eCAOsDEyRj+OwL1TTWAPSfB4JBbXVn7rQmBqSCun/SrietKfDtS2Ju/Eyh1O42jgVQEm9ydKDegFnsuufADcgBeh6v6XwcE1MATIw/Fo0mmCnJLZZ0KFd+FzC8z1TPf6uvuiF+2EeMWwCbaXzVgsukJ1GCw77zGPqxx1b2l7NFyUUiCKrqDdSjOPWP8yMzgTsSBTX5g8hMqrGLrnoytgYQqbN18VR0us9hnhwbms/8DnY69irAn0ejCn1kz+rSavmLzgoAT9HtduAFzZ/UFH2hYQNmZUCyewloqiim5l0M6bpejvjPboY3NIL8U7qpei3pHcHP2QQgA+HQFpFNv5642F5evLiTrxNq9YpF8l4p/KA7+OiaPFfDVrCIV5c7h4HQqPmwe2ieRIH+1iHI/Wa3lbfNzlvnEnBBcbFvlS/nKzBgO7RldPFmnmTat+UYK11whWKk4ETp6Yx6m3Kcp4E34GXtvw04=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(19092799006)(4143699003)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ksbqc2sYlSGZWfOizkNvTvm2ZYdKBRjiMEgNiapwChh8JeAUPzRHEIJYBlxL?=
 =?us-ascii?Q?0bYv7PKLFQXXE2ZRswkr1FSrhpD2jmcKKZ+EBDVoxLUdqNB8vzA4hItyRhYI?=
 =?us-ascii?Q?whps46Djwtj1203Q3Cvd90syJseErE7x9lv81gZ1T+54A3IHLNQqZa40lRYC?=
 =?us-ascii?Q?Z/sWnMrjtiBTO9WF7ckyRPE82tE7VYTOaZsqskPUkKQ2P156dD1eDRdZTKgz?=
 =?us-ascii?Q?NkmiEwZLfXQ3198QKS32AR4i2Imn8A1D0LvqkVzSxS3jaHFYYqAZmySR5Dzh?=
 =?us-ascii?Q?7XVQAzPmvsiW2AukUOgJuZbZ78Ryq5o7VB5ZUjK7+KccR9DGPEcE79PTcbKO?=
 =?us-ascii?Q?hPZLAInacuL/viGVZNcPZDBF5RUulK8v5nbeHhCPGUCCKRER01tuH1R9EuCv?=
 =?us-ascii?Q?EOBavf7D8ZHTsbK4V+P+O36+6wZqRsp4oh4olS+3tXXCKXkv5/+fqnouOQpP?=
 =?us-ascii?Q?8w243fSClbcx89/h9GS2MEShLhL6P+lJvqgN7KnIGY+2tkSVn8fFFLyPjf5D?=
 =?us-ascii?Q?xDrjinsvUswq6KhIGNSemCeIBKgS605bovp65RejRxQPdianS3mcmANQpbmg?=
 =?us-ascii?Q?d/nmuZwsjnVgzKXTNPUZ0/WIK43hHK1Yov3U6WZDeQ985E84qobUo+Fe9O3R?=
 =?us-ascii?Q?bCsGWIjB+HBw8atUY+qSf9EIAYX5arMTjzVXcZCevmWkQ9XcP2Ecj7TtpyuE?=
 =?us-ascii?Q?PFwTkU1sjWs5VezY1xrPAVQbP5Z7fLJkReJaf2m3FIURH6XBORcliiBw6h7S?=
 =?us-ascii?Q?PsE5uN2Jy8JBj/jm2KjkdyXadnsRJpdrHv5KrOuuxkAmfApEjafhe8pxXSag?=
 =?us-ascii?Q?IckQdG2RO1qrWvyndcSMczyq2avsZrsuStYGapquFipo/i/uAJJaRgXszd4y?=
 =?us-ascii?Q?hSD9owAbxx7mpiCD6mKzGpSS5x4Zd7lanv48MoTIXMCIb+TgsLKcXik2g8iJ?=
 =?us-ascii?Q?2cKKXLD6/fhcVk7aLFa9UckTsshU5FS17ZWzAuefTahfabzo//M0OjVyPkdv?=
 =?us-ascii?Q?LOY3Dp41s1bkhyJWTuAqvu1e7oG+9//C6arqVio7O77RnhQ7mnOWE4hdkIsH?=
 =?us-ascii?Q?O9dqwhj8/HP4X1uiom/gQEkttJoFsuxTj3uPZ7BlxKNxfyE7zbV4GuUvCWG5?=
 =?us-ascii?Q?MW9ZraUpsPeNvX1EEqQRXoQ7ZBim0zu/6ab/vycthXCQqtkpd3H1njB2XmFK?=
 =?us-ascii?Q?83FZcGtk3XpCLfYM0V4gd6I/1LS/t0n8aIfC51fCcDMROBfVr+tpiR3z7nMH?=
 =?us-ascii?Q?iUHW/7sOpsQyN0lIRl7A13FTMyfx3QiBMLPq3/A8zOwiEMzlFitHLAGUAE6W?=
 =?us-ascii?Q?6BYPS16qfnpVLq+knW4v4QsfKqqhD4lYLPL0iEjRX5JERaXGNmI/PZKfdF/E?=
 =?us-ascii?Q?3OWMBoUKMvKRB5Qvt1Z2cEF4TEAOlPwW7RoVBNtR/yHLCtTZGWayHe3Unb1V?=
 =?us-ascii?Q?Lw0I84phvbpNnYXwx1x4trp/U7cUm2D8UHi0p1e7KCz7iBdBaSWhkPteGfqw?=
 =?us-ascii?Q?Kpb8f+CwdqGxabYkiisT+e+cdRq1hgeusg9Az58J34rMij8QcbPP4dpTc7Bh?=
 =?us-ascii?Q?8dfRLR9HQCJ0WO98jiuemTYt3M2xPlItqEmy3dofnxa0ibSI/Me9jQ/N3xB5?=
 =?us-ascii?Q?b5uzOgxIK3KCOwVDML1Gq1FVts9COlgphkzh4lv4TZqQlrU5eqr33PbLXccN?=
 =?us-ascii?Q?MYcseWWOM8fgYju5/0T/GQq9kPtqw7T8IVgVcwRmVkEqZ70lU2B0yTRAoSKB?=
 =?us-ascii?Q?M84apOfOSA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c481ecf-b1b9-4bf8-0889-08df38865d33
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 02:09:45.1114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbWzMfMTHyFz2/o+Gowf8kcpdjodgRTvOyCFYGtON2p5Yb4WsAhkJ/8PDy1NlYQ+JshoEZcTZoHT6u8EEkGNPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9400
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 03:05:14PM +0200, Laurentiu Palcu wrote:
> On Fri, Oct 30, 2026 at 05:54:30PM +0800, Liu Ying wrote:
> > CRTC(s) could still be running after the DRM device is unplugged by
> > calling drm_dev_unplug(), because the CRTC disablement logic is
> > protected and bypassed by the drm_dev_enter()/drm_dev_exit() pair.
> > Hence, Pixel Engine's AXI clock use count(managed by Pixel Engine
> > driver's runtime PM) and pixel clock use count could be inbalanced
> > after removing and re-installing the driver module.  To fix this,
> > add a helper dc_crtc_disable_at_boot() and call it to properly
> > disable all CRTCs before advertising DRM device to user-space by
> > calling drm_dev_register().
> > 
> > Fixes: 711a3b878366 ("drm/imx: Add i.MX8qxp Display Controller KMS")
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > ---
> > v8:
> > - Call dc_drv_set_crtc_disable() in dc_crtc_disable_at_boot() after CRTC
> >   is disabled.  (Sashiko AI bot)
> > - Make dc_crtc_disable_at_boot() return an integer instead of void.
> >   (Laurentiu)
> > - Postpone Pixel Engine AXI clock disablement at boot to the time point
> >   where CRTC1(with index == 1) is being disabled at boot.
> > 
> > v7:
> > - Check CRTC status to ensure that clocks were enabled by a previous boot
> >   before disabling them in dc_crtc_disable_at_boot().  (Sashiko AI bot)
> > - Modify debug message in dc_crtc_disable_at_boot().
> > 
> > v6:
> > - Rebase onto the latest drm-misc-next and resolve conflicts.
> > 
> > v3:
> > - Collect Frank's R-b tag.
> > ---
> >  drivers/gpu/drm/imx/dc/dc-crtc.c | 72 ++++++++++++++++++++++++++++++++++------
> >  drivers/gpu/drm/imx/dc/dc-drv.c  | 11 ++++++
> >  drivers/gpu/drm/imx/dc/dc-drv.h  |  3 ++
> >  3 files changed, 76 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/imx/dc/dc-crtc.c b/drivers/gpu/drm/imx/dc/dc-crtc.c
> > index 0d64186a9901..5bc952d6883e 100644
> > --- a/drivers/gpu/drm/imx/dc/dc-crtc.c
> > +++ b/drivers/gpu/drm/imx/dc/dc-crtc.c
> > @@ -227,6 +227,7 @@ dc_crtc_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
> >  	struct drm_crtc_state *new_crtc_state =
> >  				drm_atomic_get_new_crtc_state(state, crtc);
> >  	struct drm_display_mode *adj = &new_crtc_state->adjusted_mode;
> > +	struct dc_drm_device *dc_drm = to_dc_drm_device(crtc->dev);
> >  	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
> >  	enum dc_link_id cf_link;
> >  	int idx, ret;
> > @@ -287,29 +288,37 @@ dc_crtc_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
> >  
> >  	DC_CRTC_CHECK_FRAMEGEN_FIFO(dc_crtc->fg);
> >  
> > +	dc_drv_set_crtc_enable(dc_drm, drm_crtc_index(crtc));
> > +
> >  	drm_dev_exit(idx);
> >  
> >  out:
> >  	dc_crtc_queue_state_event(new_crtc_state);
> >  }
> >  
> > -static void
> > -dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
> > +static inline void __dc_crtc_disable_fg(struct drm_crtc *crtc)
> >  {
> > -	struct drm_crtc_state *new_crtc_state =
> > -				drm_atomic_get_new_crtc_state(state, crtc);
> > -	struct dc_drm_device *dc_drm = to_dc_drm_device(crtc->dev);
> >  	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
> > -	int idx;
> > -
> > -	if (!drm_dev_enter(crtc->dev, &idx))
> > -		goto out;
> >  
> >  	enable_irq(dc_crtc->irq_dec_seqcomplete);
> >  	dc_fg_disable(dc_crtc->fg);
> >  	DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(dec_seqcomplete_done);
> >  	disable_irq(dc_crtc->irq_dec_seqcomplete);
> > +}
> >  
> > +static void
> > +dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
> > +{
> > +	struct drm_crtc_state *new_crtc_state =
> > +				drm_atomic_get_new_crtc_state(state, crtc);
> > +	struct dc_drm_device *dc_drm = to_dc_drm_device(crtc->dev);
> > +	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
> > +	int idx;
> > +
> > +	if (!drm_dev_enter(crtc->dev, &idx))
> > +		goto out;
> > +
> > +	__dc_crtc_disable_fg(crtc);
> >  	dc_fg_disable_clock(dc_crtc->fg);
> >  
> >  	/* request pixel engine power-off as plane is off too */
> > @@ -318,8 +327,9 @@ dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
> >  	/* request display engine power-off when CRTC is disabled */
> >  	pm_runtime_put(dc_crtc->de->dev);
> >  
> > -	drm_dev_exit(idx);
> > +	dc_drv_set_crtc_disable(dc_drm, drm_crtc_index(crtc));
> >  
> > +	drm_dev_exit(idx);
> >  out:
> >  	drm_crtc_vblank_off(crtc);
> >  
> > @@ -331,6 +341,48 @@ dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
> >  	spin_unlock_irq(&crtc->dev->event_lock);
> >  }
> >  
> > +int dc_crtc_disable_at_boot(struct drm_crtc *crtc)
> > +{
> > +	struct dc_drm_device *dc_drm = to_dc_drm_device(crtc->dev);
> > +	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
> > +	int ret;
> > +
> > +	ret = pm_runtime_resume_and_get(dc_crtc->de->dev);
> > +	if (ret < 0) {
> > +		dc_crtc_err(crtc, "failed to get DC display engine RPM: %d\n",
> > +			    ret);
> > +		goto out1;
> > +	}
> > +
> > +	if (!dc_fg_wait_for_frame_index_moving(dc_crtc->fg)) {
> > +		dc_crtc_dbg(crtc, "FrameGen frame index isn't moving\n");
> 
> Shouldn't you set 'ret' to something here? Otherwise you'd return the previous
> ret value, which would be 0.

We take FrameGen frame index not moving as a normal case, which means
the CRTC was not enabled before this boot, so returning 0 is fine.

> 
> -- 
> Thanks,
> Laurentiu

-- 
Regards,
Liu Ying
