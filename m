Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EBE606A689
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 09:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=EV9Yunri
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9F5510E535;
	Tue, 24 Nov 2026 09:21:36 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010027.outbound.protection.outlook.com [52.101.228.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B38E710E535
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 09:21:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5avUopaTGjF18kMnWumcAM32chjZiG1L513DAe76x1BiAXM1x7WxxxqEvJEW5H3LkeLs/fiSDxoXbUarPCrDSfYFjiRVn6JHCw3wFO97vVFnp+urordzF/GMCWn0w12iq8LHuemNLMJ2zmcPXiWrTt0qs5ttskYMYG5qTCZ8ogYpSZnx49IJodC884cG2DaeM76u71jrfwwctF0r7l65Rm4HcFwDVZ31NOPK7NK/VxG2WMc3XLQKLTbAPKRGMOC4+1tXoDfxNU4iVyVxC6ZUup2R61SEDmPWfDIIBhT1vNv9m9W0MNSgL2TdP4qamzU9y6dO7l+DdSqB3Z+hlr2/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctbxF5B+y6L/JHufQc69gZUon7h+6IHwoGQ5DYI4x3Q=;
 b=oMrV/jI21PsncKCH4uex0d904mvG6fLGNblFAx25s1wtvIC6fEzNfA9Y35VdjY9rfCiNG9hdLEwvH0fF/F3QUJmDZ/MNkEiReP/6dB9CE/1Y8qvFykDkCN9k+BDC8vCHEWTK14+i9ZD0ee3DB5GV3nOEBnIY6WQQE766fANeC11bkNFAQrhqsNa0qKqy+hASAVzGedvyCrSZzr8ksyPlU5mjBonw7JTyY0qE5UHUZWwGDzJXIPqKl5LEM0I7XB//1KLcObl5swOLLHMhvhvEZbZOxyZeI2po6U7WX/9bYsmrNm2gDsEIO3VWc6B9dv+VPZns1oKxTJhT3gnkX5nVXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctbxF5B+y6L/JHufQc69gZUon7h+6IHwoGQ5DYI4x3Q=;
 b=EV9YunriUcbmyZ4TZ6507yWa1MzAs6gooQWi4ziDuR2aWtKpV9RXfvQHdEAgxcZGo4Llxwq+2f5XI0xCOHK8FFj9P2lvviq7h0aF/G8IuNDos1r6jnUZz3bLnWqxp9nJnxtnFrd+ln+OsxWXj64PxIdQTDeniHqiTpSkDAnwX4s=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY7PR01MB045388.jpnprd01.prod.outlook.com
 (2603:1096:403:405::18) by TY7PR01MB17940.jpnprd01.prod.outlook.com
 (2603:1096:405:39f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Tue, 24 Nov
 2026 09:21:26 +0000
Received: from TY7PR01MB045388.jpnprd01.prod.outlook.com
 ([fe80::efc7:876a:53ee:a019]) by TY7PR01MB045388.jpnprd01.prod.outlook.com
 ([fe80::efc7:876a:53ee:a019%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 09:21:14 +0000
Date: Tue, 24 Nov 2026 10:20:36 +0100
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Tommaso Merciai <tomm.merciai@gmail.com>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "magnus.damm" <magnus.damm@gmail.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 08/12] drm: renesas: rz-du: Separate the DU instance
 from the DRM device
Message-ID: <awVW5B4p06FUfBHw@tom-desktop>
References: <cover.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <68fcf838eee14c1906f23b2b7c74c560793cd1d4.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <OS3PR01MB65968FEBCB08429F11188CE986452@OS3PR01MB6596.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS3PR01MB65968FEBCB08429F11188CE986452@OS3PR01MB6596.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: LO0P123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::12) To TY5PR01MB864802.jpnprd01.prod.outlook.com
 (2603:1096:403:512::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7PR01MB045388:EE_|TY7PR01MB17940:EE_
X-MS-Office365-Filtering-Correlation-Id: 85e18807-547e-4a96-9db1-08df4a0c4929
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|52116014|376014|7416014|366016|22082099003|18002099003|4143699003|11063799006|261026121527099003|56012099006|261026140227099003|10067099003|261009223027099003|38350700014|261028144727099003|261021121427099003|261021123027099003|261022075727099003|261022105027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: zq9TKljw5kjkbe6QhBhzINVLhqMuKx7z1gE1/ct2wlqdNkokS7BBPKYgrYCCgT3UGGpGEHwNtzHdnNUx7p9kxNLnHbjF4DrmU6iaog4twLaA9LhlF7QKZSpRa2P8KoyMdgzYCTsjhND4VqlWqH0ovrbDxRRIVaI82saGb/GFYfvxKb816MrNzQ9ioFgx4JGyChQnpQr3I2+DWOH9Qc14x6ZNTFrpGWS2BNv5iqHjpbfSr2PFci3+hoHrZPQBpDJ0jvANzZ0MFc5EW7nrFtStkP0JAZyXSTmo28FZ0dWJMxfKuZpR2L5aLbEzmjQgU7LCK4w2rP7irCtz/5XFLe7Q006NfIYtI4vffxaTJELTM3mg1HwRhMPr3BhoHB15iFJNjFn6/hUzu9v3eQTmqKx49nQWJwR0OocGsN+/VFZU1007zx/tcbIz5mRY65bLzBOXAjNxZ305pZEoQK/zrS8QpFWYW+rrBCDrh0vR5K4CONIsH3kr/OGoZ1WX1PtVaIy2fub19JyyLg1T7xKUdx2ZbLprthgoytruPZY62f4iFBZbu4XOEyZbH6VxAm9Jcw+kN42uUKCbKY0CwmsqpNTua8uil5kWsh0fAf7N5NQUPoOKodyQuw4oTFLpbi0P5lFYsQWvjBlJ27D2q3uH9ycHYTsVMH3ygLeP1zmTBgXebEYdSAySOqsELQ06JfrZUwHvmmL++6sUn3LPK7immZ2LkaFFbE11YtnzxET0FPs76FA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY7PR01MB045388.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(52116014)(376014)(7416014)(366016)(22082099003)(18002099003)(4143699003)(11063799006)(261026121527099003)(56012099006)(261026140227099003)(10067099003)(261009223027099003)(38350700014)(261028144727099003)(261021121427099003)(261021123027099003)(261022075727099003)(261022105027099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bqTOtDClPONyyt1sjoALC+JC6eJ+vTjCddkA/rAmNnwdKryESo8/zRlVWeCn?=
 =?us-ascii?Q?gFnZYUvI7wW/S0t34xidIe+nq4TCewvJIcsbRqgFqEI8WTcNggVkwhIEh+U3?=
 =?us-ascii?Q?88oPO+5/D7XDWXL97a8rZqDDinBpoPMfxIjkokZEtgGR3qDSXACBkfMmANR1?=
 =?us-ascii?Q?+giF3MCpXKhI999kX6j1QlTMj+PQ5GfnoXUWZrcA7m8PLsWAYetky2hXNVFU?=
 =?us-ascii?Q?Gsge4M3H3eP6uAQ3X50xV3n/zbkI8CV+yP58MYDzKdGT/xkbPuBmspTm/sS/?=
 =?us-ascii?Q?XFxTBVJ4GxuQn+Fq2B5Sf5r7qGULpLo1fsoUTQtbaCNbhSLcShoUjd2AT8cx?=
 =?us-ascii?Q?Wt77h3EwkOoKbyW0Qged+CjuKwF7egajkrvnCtteZHNHXr4pEWL/DbwI2Osm?=
 =?us-ascii?Q?JRC6C+0heZMaJ29jrydMjuzqDHZxz6sRwQj0mQZtzEkq9zeNDkJ2jh39Ig3w?=
 =?us-ascii?Q?RfGgMmD9WlYQXFNoxpwwFF5AcCKCW7InNMURK3qRFH0epXqTSdZQC0+4qbt5?=
 =?us-ascii?Q?Sbgz724rq4eaXK07yvUUl75O6tiB3QSwn5LYK/3+PRJtIrhw02Isk8lS4saB?=
 =?us-ascii?Q?0+YUqT/BV2CbLQqq57SKfhL94vRehPtalvFSZgP1fLtQCqyBwqY8LL5HNTti?=
 =?us-ascii?Q?UFQV57GG9qcVa3Y6SPGkq2UPgDP6BDoRLfrCV59sfIrsnG/fRHXTYxN6VhMC?=
 =?us-ascii?Q?DVpAlvMoIxAjGTHX1fjti2SZgnGVWz4f/Z0LEhF/Jgx0slVshfWFyoQiQeNo?=
 =?us-ascii?Q?I4gcuDTa8ufI8EICRenkf4ZQB4RaMABcIjZXsbY5Nuq/tO19YALWZ/1E1SL8?=
 =?us-ascii?Q?zkrPasOeEonbCJUvQIWq0PvnGC0+NSH3zmdBl0F0+vzjB8xadxeu8fGp5rQP?=
 =?us-ascii?Q?qFMTCNVOLSsgt0X85yJruw8xDxwJfz3NZ8WERjePVvgAOsL6hKPLspj9ACzO?=
 =?us-ascii?Q?umXZEHFGByv1NIWQfAfrpGiZZVqYCrpCKLnPu9yICgfEqI37uF5KxHlsOdtE?=
 =?us-ascii?Q?DakUhD8HSxYSbzyJBmj2idnkkpQKnowRKfrA+gHfXBBNPpm2MHoHDyb/xIoe?=
 =?us-ascii?Q?E9sxf3XPPY5UmxhupuZ4WP/jKLjwflrUrmzAzbdcws1x+HBke2Zy1aFEv+za?=
 =?us-ascii?Q?8//ZeYQLLdZ2AAZBwtqo37dWIWx5PEwljbwc5s91tICB+CuO5r3Ak9dEHI/4?=
 =?us-ascii?Q?p3TSgg5FWeTmq5MQD+Xy5sV4+6Fw4YNDs+afOjCt3rkVk4gKYKaeC6/gOZM9?=
 =?us-ascii?Q?QMc5abe+UmpOk0tV5Rnsq599Ty9EhhPPfGgTu9MKo/el+n9VKhMjAMQGmv1C?=
 =?us-ascii?Q?nBI3B163sUrxO0K6UiNorSkCIjCfFNWILIckO7fP+OYBJaOABpDx0ufwJgty?=
 =?us-ascii?Q?D6oF5QiCFIc3UyxOIpIApe/N6wdv/bA6WC4+Xsqk0UihpZw7ptV2A/i4eyoQ?=
 =?us-ascii?Q?dIr9ek+htKTzn7N9vGMAJEOP2LwErlCgfcRcCKZj1IXhMZ+Zc4/65p4kRzNi?=
 =?us-ascii?Q?it3+WzzWo4T0wmps7ol8mSi7hxLYZGMS+86rlQ/ScgJqXgrGbdF+nO5l5nub?=
 =?us-ascii?Q?6ax5UcEH/wbGXRXyNFzysSdFc0WsN+DS9VjNDRTJze4xV/+3Jk3vwAKSG1Zu?=
 =?us-ascii?Q?4DOTA7z30jXqG0MX7AyKq2+JGEqP6eMhhfUBJVn36tX95CDNj/pWCFmuUv0J?=
 =?us-ascii?Q?fspacBMcx9WkfCJysQvX3s+Hhlan5ydEkfMFYHBA1HFOzBxYAPINO7NyU73k?=
 =?us-ascii?Q?Vcd+jlfrYcyyGpzrulf+3bupo1j0WlrvYGlqoV0Wec2gdY3Xsw0l?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e18807-547e-4a96-9db1-08df4a0c4929
X-MS-Exchange-CrossTenant-AuthSource: TY5PR01MB864802.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 09:21:14.0610 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A5xNAP9bG3DZwxXiyV5x1FiMvr3l/W3gbgtf90mevL4M37BObb9nFLgwuKsX8TK9Tyu6qN4anl7o/kMYIgwR7fXYDIaNjLzOch9gN28QHgFQCrj3wUMjdaZEO0nEE5Ed
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB17940
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

Hi Biju,
Thanks for your review.

On Mon, Nov 23, 2026 at 04:59:32PM +0000, Biju Das wrote:
> Hi Tommaso,
> 
> > -----Original Message-----
> > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > Sent: 13 November 2026 12:20
> > Subject: [PATCH v10 08/12] drm: renesas: rz-du: Separate the DU instance from the DRM device
> > 
> > On RZ/G3E two DU instances share a DRM device, which can only be created once both instances have been
> > probed.
> > 
> > Split the DU device structure: keep the match data and the registers in a structure allocated with the
> > platform device, and allocate the KMS objects with the DRM device in a new rzg2l_du_instance_init()
> > helper, as they are released with it.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > ---
> > v9->v10:
> >  - New patch.
> > 
> >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c | 61 ++++++++++++++------
> >  1 file changed, 44 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu/drm/renesas/rz-
> > du/rzg2l_du_drv.c
> > index d3cccbdf9012..d102876c07e1 100644
> > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > @@ -162,6 +162,27 @@ static int rzg2l_du_pm_resume(struct device *dev)  static
> > DEFINE_SIMPLE_DEV_PM_OPS(rzg2l_du_pm_ops,
> >  				rzg2l_du_pm_suspend, rzg2l_du_pm_resume);
> > 
> > +/*
> > +-----------------------------------------------------------------------
> > +------
> > + * DU instance
> > + */
> > +
> > +static int rzg2l_du_instance_init(struct rzg2l_du_device *du,
> > +				  struct drm_device *ddev)
> > +{
> > +	struct rzg2l_du_device *rcdu;
> > +
> > +	rcdu = drmm_kzalloc(ddev, sizeof(*rcdu), GFP_KERNEL);
> > +	if (!rcdu)
> > +		return -ENOMEM;
> 
> Why there is duplicate allocation of rcdu? One in probe() and here

The two allocations have different lifetimes.

The one in rzg2l_du_probe() is tied to the platform device. It holds
what is needed before the DRM device exists and outside of the
component bind (dev, info, mmio, and ddev/is_master for the master,
PM and remove), as on RZ/G3E the DRM device is only created once both
instances have been probed.

The one in rzg2l_du_instance_init() holds the KMS objects (crtcs, vsps,
lvds, index). Their drmm cleanup handlers point into it and run when
the DRM device is released, which can happen after the platform device
has been unbound, so it has to be allocated with the DRM device.

Thanks, Tommaso

> 
> Cheers,
> Biju
> 
> > +
> > +	rcdu->dev = du->dev;
> > +	rcdu->info = du->info;
> > +	rcdu->mmio = du->mmio;
> > +	rcdu->ddev = ddev;
> > +
> > +	return rzg2l_du_modeset_init_du(rcdu); }
> > +
> >  /* -----------------------------------------------------------------------------
> >   * Platform driver
> >   */
> > @@ -190,44 +211,48 @@ static void rzg2l_du_shutdown(struct platform_device *pdev)
> > 
> >  static int rzg2l_du_probe(struct platform_device *pdev)  {
> > +	const struct rzg2l_du_device_info *info;
> >  	struct rzg2l_du_device *rcdu;
> >  	struct rzg2l_du_drm *rzgdrm;
> > +	void __iomem *mmio;
> >  	int ret;
> > 
> >  	if (drm_firmware_drivers_only())
> >  		return -ENODEV;
> > 
> > -	/* Allocate and initialize the RZ/G2L device structure. */
> > -	rzgdrm = devm_drm_dev_alloc(&pdev->dev, &rzg2l_du_driver,
> > -				    struct rzg2l_du_drm, ddev);
> > -	if (IS_ERR(rzgdrm))
> > -		return PTR_ERR(rzgdrm);
> > +	info = of_device_get_match_data(&pdev->dev);
> > +
> > +	/* I/O resources */
> > +	mmio = devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(mmio))
> > +		return PTR_ERR(mmio);
> > +
> > +	ret = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> > +	if (ret)
> > +		return ret;
> > 
> > -	rcdu = drmm_kzalloc(&rzgdrm->ddev, sizeof(*rcdu), GFP_KERNEL);
> > +	/* Allocate and initialize the RZ/G2L device structure. */
> > +	rcdu = devm_kzalloc(&pdev->dev, sizeof(*rcdu), GFP_KERNEL);
> >  	if (!rcdu)
> >  		return -ENOMEM;
> > 
> >  	platform_set_drvdata(pdev, rcdu);
> > 
> >  	rcdu->dev = &pdev->dev;
> > -	rcdu->info = of_device_get_match_data(rcdu->dev);
> > -	rcdu->ddev = &rzgdrm->ddev;
> > -
> > -	/* I/O resources */
> > -	rcdu->mmio = devm_platform_ioremap_resource(pdev, 0);
> > -	if (IS_ERR(rcdu->mmio))
> > -		return PTR_ERR(rcdu->mmio);
> > +	rcdu->info = info;
> > +	rcdu->mmio = mmio;
> > 
> > -	ret = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> > -	if (ret)
> > -		return ret;
> > +	rzgdrm = devm_drm_dev_alloc(&pdev->dev, &rzg2l_du_driver,
> > +				    struct rzg2l_du_drm, ddev);
> > +	if (IS_ERR(rzgdrm))
> > +		return PTR_ERR(rzgdrm);
> > 
> >  	/* DRM/KMS objects */
> >  	ret = rzg2l_du_modeset_init_drm(&rzgdrm->ddev);
> >  	if (ret < 0)
> >  		goto error;
> > 
> > -	ret = rzg2l_du_modeset_init_du(rcdu);
> > +	ret = rzg2l_du_instance_init(rcdu, &rzgdrm->ddev);
> >  	if (ret < 0)
> >  		goto error;
> > 
> > @@ -243,6 +268,8 @@ static int rzg2l_du_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		goto error_fini;
> > 
> > +	rcdu->ddev = &rzgdrm->ddev;
> > +
> >  	drm_info(&rzgdrm->ddev, "Device %s probed\n", dev_name(&pdev->dev));
> > 
> >  	drm_client_setup(&rzgdrm->ddev, NULL);
> > --
> > 2.54.0
> 
