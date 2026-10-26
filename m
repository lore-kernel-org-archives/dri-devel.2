Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644BD606A31D
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=MyXd42Mh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83CEC10E1C2;
	Mon, 26 Oct 2026 09:29:03 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013014.outbound.protection.outlook.com [40.107.159.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C30E210ED15
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:28:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cr2PgAfJGe0FTPzQ8MvNWFy2hwH2D1wXlxB3rWqGPsoKjdzZQd374p0Fz67ZSPUavIHI99T1JY9PWuUHdavk6BqDU8P52hZpQTIVVXso72yL2T9+t/LaSylNUoAmoMueJ1BxYpRSYp3ASAcWVzW+eFU9f51HZ38g5C9o5z2aikS1U7AeRBxH581w7oOTfCOtOyIlpmquxbh2J5uBWdJ2iHMRJ7rO7wcF0jCQigX68n1sELLOp8ItjkFL5KSasDQB+0CqcXPB7QOwgyum69mRYRIV+qezfL3ng9yyUUDGS916rrdTNjHCCoH1QVq0EXXKlQyYyG4BAISKWd/UAYGQyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/GtyAf3yTXulWWvbgAIMpCFSmjkkpMrX8lUFxgtWiI=;
 b=q5fAFP8VdzTlmAsNhEFqJak1v5CZXRswkjMMThkim6l75SOWT5Idjc6qURhe4TrBRjxishmd6jJXTfuqWGFt5Q47wL+MKtYHDBYPhaT0lYFSFVXsQw1E34hfYlAGHbQuwaC5LBDK7Y5y+fKKgSRZTIBD38G05/75mDaQCZDymAYgX1qIGBq6wyBWs3WxYmdpxKVtJZSMg133dl+qPHtvOSYQ5BMZo2EyJIB5R9nQRYmW9v7NFCT3c0xocIQCtQl5RW7uy9buRzLUiYwHbmUIXP6O6lg4XbGcYAepZWzCGQOidvgcQnV3wHUbFNc1LrZ0b7Z6KSIsvqGN+jCh/6b6oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/GtyAf3yTXulWWvbgAIMpCFSmjkkpMrX8lUFxgtWiI=;
 b=MyXd42MhUR00JKZAuN7tT0hxVxm/99ODBCCJpG4K2YljxdgH2WyH0zIiajUgMpRMxPGzhjUwUlqtOPbIL9PO/fM6T8rRrVI6MTDrtJg8hF98qkwgLtotBSC2hfDJeZsmT7ylz70hmZQHMMNMbdBX4ucDVUgddfMoIquPMKcAelBHsuGgQdgUEd3y5alTc3p82ukPHMDw7hB/4ptUBNuKijPgokElayZM+RlFcLYFu+s9EFXQNzLnt16L4F4pE/znr5AMiT76wfqXRb9ZQ69m7axuRHOMV/MMxsnNdDn2SktPN84/DjOwMhN277ym7RwWMbi+rAGeotni4jp+xmr+sw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by AM0PR04MB7124.eurprd04.prod.outlook.com (2603:10a6:208:1a0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 09:28:50 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 09:28:50 +0000
Date: Mon, 26 Oct 2026 17:30:27 +0800
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
Subject: Re: [PATCH v6 04/13] drm/imx: dc-crtc: Disable at boot
Message-ID: <at8ds0P-sN9QQbDB@raspi>
References: <20260904-imx8-dc-prefetch-v6-0-26643e3f6cb7@nxp.com>
 <20260904-imx8-dc-prefetch-v6-4-26643e3f6cb7@nxp.com>
 <app-rzrdgsxVozsI@houat>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <app-rzrdgsxVozsI@houat>
X-ClientProxiedBy: MA5P287CA0207.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ab::15) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|AM0PR04MB7124:EE_
X-MS-Office365-Filtering-Correlation-Id: 3de82cb2-9c77-4304-571c-08df33438b6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|23010399003|19092799006|260925022911599003|260925021911599003|260925021311599003|11063799006|56012099006|261009223027099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: uHcaJX0z/cEZMLOvTA+VSP87MNnjRGiMuHosJLvbrAY8JG1YJYBmrm+22S4gERoR5mXpky10EhOmlOOXDGARa+755wAofDi07OuoG/P70qCJ0SmQrWt+Z/nYdlZq47jBhuGupGHgW/B7/o3qNBk3epsl91Y79ZXSD3TGp6/hHsN/qKiTEomkwNFTVyoy2ooPsITGHpM71Uig0ZGLmuXE3iyELDBilcdOyI3a02Vkze4lBhHKwOvz6cQl5O+wralqPyxVVrtx6UKs/7Upo65LxS3z2RKXT788B2gbAaftLEXuStRHul28rViuaQIOM7fH8iCfc6kY/+M7M1Apt5/BOrYkDWsoeqN3SVOj4Pvcm6Ypdg2k7rtizMpJxiaTdF83y513VkvE3uMh9kEYGuiHXpl9zb7u4Z5QDc2tjx1JthsoOiWWN8RVgjl8LabOfUSsn2bICekOLx7tDx91o64n2VwXpcHF1ob7yt/6o/wOPx7NK/yb7wgI691l+9wB2p72OAZsr2hvYe9MBFZFzUEhZEApEWtKvR/7FKhl4aJobdD8Fv0qfsSzYiON35B6ZObXoxKWY/QjUOKdM2Z6MbUrtS94+SGO7AKj2thEn6B/ZT5xmYlcG13KNhS4jq5QdFxO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(19092799006)(260925022911599003)(260925021911599003)(260925021311599003)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CVckCg7j/OCwehjBQYmmNPcraCBcQLashpKtaIuDebADF+fSxq7I0FJx99/h?=
 =?us-ascii?Q?H0pb/wQMij6ffvKq+eLb1aLC5RsPRfhheTKW09KLvfKLtAcDCUYTqsUBc0WC?=
 =?us-ascii?Q?wbWMqTBWPv5OFjpg+1LU7H5xMrwxIfI9QtBmKEQPr8J1BgL+9kkHz7ZLDjox?=
 =?us-ascii?Q?2ldvThmkFkUzwRiCKwd3bkr/kK0apjTWyy/0PXGqH4dpq+2Cmw5hsoRwuFRz?=
 =?us-ascii?Q?KCor2nIbvoXUB7V/6LLWgFsBoSlqmF8jtiUCB26IlyV27qQKttx4Go8nApUn?=
 =?us-ascii?Q?56PLWpx55eo2KTUIIx9NHzFhLADo87MrudVxeFHa4KUVXSGwKQb/cdw7Ghcd?=
 =?us-ascii?Q?9Jux/kRg2yfoE1oCxquG98xh+BpSSdfMzeE4sYcJp0ib88KjzafbwnklBDc7?=
 =?us-ascii?Q?APnUwfelpMQAxm5oSrQi4SYOnzMTFyXYceocJekiVd9rPyMJ3jag6eV0aZ0y?=
 =?us-ascii?Q?dQlQxkpC2Sl3kx01TZvzzoTYuQsbxDK7WQ6e3UzF0jRqXHWs1NPzH/+UXwZR?=
 =?us-ascii?Q?E3+hPkYWIrtjKInznLa8ztCTQDq/aMne9TvWa/oDAqyu50W0nD4072saZ8OJ?=
 =?us-ascii?Q?6p5XGwD3i/oaHTyt4UZ0Qh8e873VbQ1r7NMxLf91s3DxhzevpWQei44oF/IJ?=
 =?us-ascii?Q?ull79Zvz027r2hIMxw7WTNy9YMZE7fK9q0S10Z6YV5zDK6RQNaMCEBBA4zGF?=
 =?us-ascii?Q?i69neAc1iqfmpMM7PkQ996S+63a2SHJ8j7ab/P0qEYTlKD/bM+i+OUOhvdL3?=
 =?us-ascii?Q?TARv8rpFwrwyN+mybjW0Fqj+ErEujL5Wx5DgDPtW9lnv+5je040/4YTkO2Mh?=
 =?us-ascii?Q?GDOiVzzNKlVnyT8uQiai/w/3szOp8k74GJtX/dG5bs1X7x7WE3jgkaF8ZqoR?=
 =?us-ascii?Q?ZmmXIY7GJDGkme466i1O/LO9if2Byly2/Wtm4PW9lJTGc6vm/iX6mrKS0h1E?=
 =?us-ascii?Q?5vGNcA79TbE3vAQ5oPdNC8yynQU5FcQ2Ahqkm5+IvuF0lA55MCE3duq/f9Hj?=
 =?us-ascii?Q?WIFNateMOvdlVXboIGvaqXobWoZbf4KL5Ql/+yWbVd2eIHqOX7pWAUlM2i5V?=
 =?us-ascii?Q?T7Nc6lBPMIatD6IGW/lbA8vzbCUZwXqSRdUE1/vS5zXMexIxaHXYJ9AKRj1c?=
 =?us-ascii?Q?V7Bkjq3y/uVRLacYBaSsJOMdAK7m8mDdbqU2K8V8rf3Dr/KdbzOGRlsDnNdX?=
 =?us-ascii?Q?YVPvejFIi5jNNJd4SjNNI8+kWy7Uk3Cbn0kla1dZZMXBY0AY4Xxjf3yygHqP?=
 =?us-ascii?Q?9+dchitbwCwRxqsTRN0HD+UwQhmv64BWC6XSYXFX4MEjcdSSR37WVmgM9sRu?=
 =?us-ascii?Q?z4JzRr3ZY9szRG6MHVDdnD5sWYUFqwSAlQ/8U6IFHqXUvbVZAgLTRk0S4fsW?=
 =?us-ascii?Q?/W/iNanWzqdza4TDYg+rR0D2nXvQ+I0pXuQtJYLAyxFanAwvseQsjAV5V25V?=
 =?us-ascii?Q?cE595TCjDsS4jm+d1gPgLJ6EsufAizDLDr4n7STKh64iqp2qkFg6lnNYlhVT?=
 =?us-ascii?Q?hS1xAz/oCAnEHTFsa4ow/XNN3NDtuXAFxIXWqw84EcoqYIDXIPlyRzBj8fvi?=
 =?us-ascii?Q?B9gX+HevRzsc5vM8OMilAELT/K/UVGL7IEQIcBmtvsLWrIvuph6iaKURqdpm?=
 =?us-ascii?Q?2KuZm3hHKi3FMX7k8yi9JFAHawUqXIJusoGgKi/boCNUq0Gj0bomCdG9ZHha?=
 =?us-ascii?Q?oKJtK0MvsqrlbrFXchfdPVbdpzkclGW29+KZ7pTnCmIoshYnPtl9pAZLRmaN?=
 =?us-ascii?Q?d7KBjseC7w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de82cb2-9c77-4304-571c-08df33438b6b
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 09:28:50.6949 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDlddffkO+zRj0xapl8M3Z1IQjzqcZ+VUK1GDxJa2n99Mp1IniAOC6d3/s7gkho9eVcdv75r8gsO6S/uSCCtdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7124
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

On Fri, Sep 04, 2026 at 10:27:41AM +0200, Maxime Ripard wrote:
> Hi,

Hi,

Sorry for late reply.

> 
> On Fri, Sep 04, 2026 at 03:54:54PM +0800, Liu Ying wrote:
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
> 
> Just as a heads-up, the readout series I'm working on is probably going
> to help you deal with it:
> https://lore.kernel.org/r/20260629-drm-state-readout-v4-0-5966657980ed@kernel.org

Good to know it.  Maybe, imx8-dc can use it in the future.

> 
> > ---
> > v6:
> > - Rebase onto the latest drm-misc-next and resolve conflicts.
> > 
> > v3:
> > - Collect Frank's R-b tag.
> > ---
> >  drivers/gpu/drm/imx/dc/dc-crtc.c | 55 +++++++++++++++++++++++++++++++++-------
> >  drivers/gpu/drm/imx/dc/dc-drv.c  |  5 ++++
> >  drivers/gpu/drm/imx/dc/dc-drv.h  |  3 +++
> >  3 files changed, 54 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/imx/dc/dc-crtc.c b/drivers/gpu/drm/imx/dc/dc-crtc.c
> > index 0d64186a9901..1a537cf88daf 100644
> > --- a/drivers/gpu/drm/imx/dc/dc-crtc.c
> > +++ b/drivers/gpu/drm/imx/dc/dc-crtc.c
> > @@ -293,23 +293,29 @@ dc_crtc_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
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
> > @@ -331,6 +337,37 @@ dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
> >  	spin_unlock_irq(&crtc->dev->event_lock);
> >  }
> >  
> > +void dc_crtc_disable_at_boot(struct drm_crtc *crtc)
> > +{
> > +	struct dc_drm_device *dc_drm = to_dc_drm_device(crtc->dev);
> > +	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
> > +	int ret;
> > +
> > +	ret = pm_runtime_resume_and_get(dc_crtc->de->dev);
> > +	if (ret < 0) {
> > +		dc_crtc_err(crtc, "failed to get DC display engine RPM: %d\n",
> > +			    ret);
> > +		return;
> > +	}
> > +
> > +	if (!dc_fg_wait_for_frame_index_moving(dc_crtc->fg)) {
> > +		dc_crtc_dbg(crtc, "FrameGen frame index isn't moving\n");
> > +		goto out;
> > +	}
> > +
> > +	dc_crtc_dbg(crtc, "disabling at boot\n");
> > +	__dc_crtc_disable_fg(crtc);
> > +	dc_fg_disable_clock(dc_crtc->fg);
> > +
> > +	if (!dc_drm->pe_clk_axi_disabled) {
> > +		clk_disable_unprepare(dc_drm->pe->clk_axi);
> > +		dc_drm->pe_clk_axi_disabled = true;
> > +	}
> > +
> > +out:
> > +	pm_runtime_put(dc_crtc->de->dev);
> 
> I'm not sure you actually need the pe_clk_axi_disabled flag. If you make
> it handled by runtime_pm, then you can also use pm_runtime_set_active to
> flag the device as active already when you probe, and the runtime_pm
> will know when to enable / disable things properly.

Because imx8-dc supports two CRTCs and dc_drm_bind() calls this function
to disable both the CRTCs, pe_clk_axi_disabled flag is just used to avoid
disabling clk_axi twice.  clk_axi is managed by runtime PM, so it can only
be enabled once.

> Maxime

-- 
Regards,
Liu Ying
