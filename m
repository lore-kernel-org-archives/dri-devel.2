Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865C0606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=u8B88wbs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D668310F626;
	Tue, 24 Nov 2026 15:24:33 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazon11011026.outbound.protection.outlook.com [40.107.74.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38BA410F626
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 15:24:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YFo7HY3l7Ox/QKOXXA1E45PwgbOT9iQWeqN1Iho+Zlm+fYXzkjtpfaRiCVTfdZTPbJujT4HmyG44bLK13vRwkfLexRbO6Q6GquOtDc15YWVgLatCkKEhjiF2E8JIrZBjoVjA4tfVW87QjrC4A8ZEMeLbEpNH+1RcdHZbh6NqXKY7n7btVWdH8rUTSQdTfCLFslPH9GiQwk0bpQoeIJ8kzrF/9SKxJzdBRXou7loY6d0KOcm6zpT6YLxtLeQzEi4v3HIgXRCMQd6edqlcSKHgeWG6mOOvc5eRsbpIzDa2DugmoHCQlraxZ91AxBlnfan4nRfdKsWI7xK0fk1Y8fvOgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2W1pOpQit+waCD2jihvc9+lVRg8k1Lgvuv+GDE8PdM=;
 b=xvguYv55HW9LIgpyghsouWg6RPi/nT2nAQCKfDB86jTJX15ynZWvSgqCnhgLHWXqeGMldLxS9mUx8ZB1gr98LcSL7pHnTej5CNI1hNgpjCfcWabsJDrifd8lzfdcVcVcEUIGnWotwfVeWd1kKsC/PF4YBDarRQs0d/UX9ZSF2AZox4rs4PqUi801Scz720HM+Gz0QMIQUfzMRvyPUK3i+Go+GBkFC/SBuEiIOyXhxxbmgm+nCiLk6sgLYIRWnf62UTgE54y85uhRnAocVssRmLSvmv6Byci07sfSCMW8Jve9MBeA0Ob8Gabaduun0bRVk9J+QJCpdIBR2qw7M7AmQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2W1pOpQit+waCD2jihvc9+lVRg8k1Lgvuv+GDE8PdM=;
 b=u8B88wbs0EpnGYNg+MqHgHWsgLIV0l/yVqqRIiyrfUGdQ0s4WQSEV8Wf0zYV3fShLbOB0IJwj11dwDJsUkJtIqr0+MBXYVYPIqWKhmmX7OBCxEMq45g0828j5aMKCcLO/vZmqkzkvFPWDVYmklnfbjIlWm4Pi6BtL3MdrgZKA1M=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OS7PR01MB13650.jpnprd01.prod.outlook.com
 (2603:1096:604:359::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 15:24:23 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 15:24:22 +0000
Date: Tue, 24 Nov 2026 16:24:10 +0100
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
Message-ID: <awWsGjt6cW_CSoMH@tom-desktop>
References: <cover.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <68fcf838eee14c1906f23b2b7c74c560793cd1d4.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <OS3PR01MB65968FEBCB08429F11188CE986452@OS3PR01MB6596.jpnprd01.prod.outlook.com>
 <awVW5B4p06FUfBHw@tom-desktop>
 <TYYPR01MB6603AA1B7A48B7D899604EE586442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awV8G86QIth4GtaA@tom-desktop>
 <TYYPR01MB6603A1FB28A473A400A2C49386442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYYPR01MB6603A1FB28A473A400A2C49386442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: FR2P281CA0065.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::11) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|OS7PR01MB13650:EE_
X-MS-Office365-Filtering-Correlation-Id: fa18593c-8b0b-4b16-bde9-08df4a3f043f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|52116014|23010399003|366016|18002099003|22082099003|261009223027099003|4143699003|261028144727099003|56012099006|11063799006|261022075727099003|261102123227099003|261026121527099003|261021121427099003|261022105027099003|261021123027099003|261026140227099003|38350700014|10067099003;
X-Microsoft-Antispam-Message-Info: Aepn4M0xooXvDu6ZpnXG9ZdAbIzpx0zD1+e6Ztx+oYc/RpMrKC0jLdapHVVXs73l13xI2dSoHPqut4qpD4BD0ZbMicW9mJFm5HoBDstufEicyJUXTaJm8f38+CKddqKafT0+T/WfX+u/Eb1Rs3nCJRStsQIxsGqseSk2qfJVoioY+e2kVSpV/va0cBUhEsUGaPTHeTiguCfIJdEFmWppQ9GgVfjTWNZm1g176gXvdAzMAGujT/uk58gRhMFj6N+7K635uy7NXgrsGRYNTR9gkAC8K0rYyvGRCKZ/H5thkX7v7a568UekNMC5wQqdevAj/gPYtiZmMt1La48N/CpCYCxKG5byRiLSQXXBUVBkh/T5jaUbNvRIJ+hOjoMzHSNDiDi5e1PTU4vNFFh25R/YPuUqsld0zn4oL0OOowny3TaxfKFJ53//Ps6yKFeI9KMJAyq2Zwiz+hkq+sCXGCgaqskjXi88cHnLFRXJJrVGrxPW94Z6IvDbGNaZsoAGCJ1+B2QyucTi9Yv5ZGYXGs03axKPQb7fyVarA7to9E7FyMvPv3y8cYRz/5KkwIYzD3zL0mXv3HrJREdg8EMyHx1y3MKAYOnmOWA96uieDlNPZ5HDjThJMoCIyjMBLqecf6phnhlIWqS233A1UsAHdlgT4F1bT/uLhwdv9td3XFlCQCzWwqCoKDRTGsjvntrxqnj3kb/Mx2Y/y8saT4uMG1aI04fyxdyMgd3V1EJcQLIs35k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSOPR01MB295138.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(23010399003)(366016)(18002099003)(22082099003)(261009223027099003)(4143699003)(261028144727099003)(56012099006)(11063799006)(261022075727099003)(261102123227099003)(261026121527099003)(261021121427099003)(261022105027099003)(261021123027099003)(261026140227099003)(38350700014)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sVJU3UAsNzq/oqd3e4xTlxCSzaoL6+7voURWSA4DDBpkVlCMpQJW3ZHOVFAq?=
 =?us-ascii?Q?Zc6vOgyWWNcWOQQYSBiIb8QX9KQdf6jmoAv/bgU8n+irIX3H6BFnbTNJIhGG?=
 =?us-ascii?Q?GmOsWgPQA6aMmHgRJ70sFWEJAd435pj5S5yTbmdEBGg79PGM90hLUiix6K9l?=
 =?us-ascii?Q?LzZCK1bYrdG3wpm2atYq46KkSebeK7uc/TZBfX5V9w9mS7WObybn/R9excne?=
 =?us-ascii?Q?iET6daU8gaznvTn3IVoflAc192lwF5p4DRd8VMiY+1ShEcOeDueRkYvMWp3L?=
 =?us-ascii?Q?RN813D2/kSm8XftW9nscMySlL3oArllkONzaFl8wRSZRrMnYcXefRAAT2R3W?=
 =?us-ascii?Q?nPA/gGiz7Zx4H/rOxXZKJ/wwZvLFsMcrlokj0DDESohQoyx7kgdMQt6eg28a?=
 =?us-ascii?Q?RfddgTpv7zicV+opI+2zE2AJ8fZC80ulhVtsuHEAu9GhuWoY4q2k5ACOe7J9?=
 =?us-ascii?Q?VnsqJQkQ/lSfPIjMGTVq2/1/msI6IsySOMPloUk5bnZ/CTodefX6RNdMznYC?=
 =?us-ascii?Q?4434QLR/Q9hidCdReYl4k/nfFZv7eb7sOdbtP/cb4HMqtOwYUtbHgdkeUDxR?=
 =?us-ascii?Q?T7vE+Hbftop5rtbAzFYur2iLLSDdAi4cwj4D+GVaRMXr67vF2U+mAemb2rWY?=
 =?us-ascii?Q?TQOrYDrwE8LfrNVZBTXBoH11dV+nySXosWXlfBa4IdDAwdZ55peFoaz1UT7+?=
 =?us-ascii?Q?lUtszTNO6I4gPSntApy8PIvnLa3U+7UhPbwk9kL8h16v4YFV8cOxqHVKAsd/?=
 =?us-ascii?Q?OXQViu8no6U04OK0dt4bDzceEjUDOGhhiktlWT9G0yvXQyOssKnvGSNcpuiS?=
 =?us-ascii?Q?l5NIbuHYnbV5bkg243QRhCnYcOSoFXNONFYZo344MPkoL5o5CeM4NR13Xhq/?=
 =?us-ascii?Q?tPIExrRHKzQqhqYdUQjWUFEy1N9BxxJ/f1/5ZnCrezKsahY7VdWg70h+2ME/?=
 =?us-ascii?Q?Q++IczDPJ/vH3D5akOro6viBQ9Dg3pATvKHXMPE4ZbUcBiNFPLuSHVYS49sG?=
 =?us-ascii?Q?qK9OHL7vWcKRX3ILLm/m18ikJ1XkpEmTaNztqGbItQtm0Q3oOxORvrIipAbX?=
 =?us-ascii?Q?WhlZ9pegEkQMDyTyrCQu5HgHCo6E/PZxv+Wwvg/x+iRp/FjKgnxEui60RxjA?=
 =?us-ascii?Q?eNsYSjDwLp/Q+nz5LCGC7EHf8HYW9xPkzy+51nvTjU5P6ha8KbVOgbyiG7jf?=
 =?us-ascii?Q?nwSEIK54r0TP6LTIAFDvAph9+kFXfBeD2E5qqs2WXomAupsi4EXw8HQ0sVOJ?=
 =?us-ascii?Q?acP368YH6F2OkuKcB8u7RAmncm+MbdC3bj5a2QNK0tFpO+fdTmv312thIxJP?=
 =?us-ascii?Q?B9mYzTm1Q7Gc0YGcdhmi0KK2J5KIGmcJgWF5fDxQaQWuEm4R78qgmx3TGVxN?=
 =?us-ascii?Q?jINdjhPeui1mP3SeV8V2sBY+/cmyJkh2UjB69wgmwqbAxBTDWanuEVRf9QLS?=
 =?us-ascii?Q?hkCwV9XnHlAQXa735NPV6y9Y/9t53oidIC8Q+taNJ2uM+kB3IOq3FXEK3GTt?=
 =?us-ascii?Q?RDVQ+iZT1/K07+W70ldtazfn3Z1EYZr44c2xNiP0h1HrMzpm851mAPzZ5ogY?=
 =?us-ascii?Q?91ciP8+KD1F1WWYgcurkDM6pXiQp4rSNcWISRy9gcKmIArxTYUXxr+KDbIIJ?=
 =?us-ascii?Q?63ZMp0HjjqyQGKrv6ZIXo+mKCKufpZKEdvYnWdbpaLK17D6uGpeDHv571O+O?=
 =?us-ascii?Q?ZrDkMYjEC52D2ER7PWQS4DFLMtNRw3AdcClOuxRq2p53rmK1By5jQBuJrBft?=
 =?us-ascii?Q?hnK8YSPWJH82sLw1cWGgdFBJmX+f/6/syRO5NU1Ht3iW7M5gqmfz?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa18593c-8b0b-4b16-bde9-08df4a3f043f
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 15:24:22.8228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wgp5IHvoDaAjdh6/Nt5Pc1OLo0IGEvMTENV4saML9eYb1lwhlzlqQY9qIsRFBDQHNjYQEOQH5x5BvRkV4IClgD6wCEymwyu1NKvjtekX7jeXCO1oKcWj5EbLTsv5U6L2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB13650
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

On Tue, Nov 24, 2026 at 12:51:18PM +0000, Biju Das wrote:
> 
> Hi Tommaso,
> 
> > -----Original Message-----
> > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > Sent: 24 November 2026 11:59
> > Subject: Re: [PATCH v10 08/12] drm: renesas: rz-du: Separate the DU instance from the DRM device
> > 
> > Hi Biju,
> > 
> > On Tue, Nov 24, 2026 at 09:33:13AM +0000, Biju Das wrote:
> > > Hi Tommaso,
> > >
> > > > -----Original Message-----
> > > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > > Sent: 24 November 2026 09:21
> > > > Subject: Re: [PATCH v10 08/12] drm: renesas: rz-du: Separate the DU
> > > > instance from the DRM device
> > > >
> > > > Hi Biju,
> > > > Thanks for your review.
> > > >
> > > > On Mon, Nov 23, 2026 at 04:59:32PM +0000, Biju Das wrote:
> > > > > Hi Tommaso,
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > > > > Sent: 13 November 2026 12:20
> > > > > > Subject: [PATCH v10 08/12] drm: renesas: rz-du: Separate the DU
> > > > > > instance from the DRM device
> > > > > >
> > > > > > On RZ/G3E two DU instances share a DRM device, which can only be
> > > > > > created once both instances have been probed.
> > > > > >
> > > > > > Split the DU device structure: keep the match data and the
> > > > > > registers in a structure allocated with the platform device, and
> > > > > > allocate the KMS objects with the DRM device in a new
> > > > > > rzg2l_du_instance_init() helper, as they are released
> > > > with it.
> > > > > >
> > > > > > No functional change intended.
> > > > > >
> > > > > > Signed-off-by: Tommaso Merciai
> > > > > > <tommaso.merciai.xr@bp.renesas.com>
> > > > > > ---
> > > > > > v9->v10:
> > > > > >  - New patch.
> > > > > >
> > > > > >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c | 61
> > > > > > ++++++++++++++------
> > > > > >  1 file changed, 44 insertions(+), 17 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > b/drivers/gpu/drm/renesas/rz- du/rzg2l_du_drv.c index
> > > > > > d3cccbdf9012..d102876c07e1 100644
> > > > > > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > @@ -162,6 +162,27 @@ static int rzg2l_du_pm_resume(struct device
> > > > > > *dev)  static DEFINE_SIMPLE_DEV_PM_OPS(rzg2l_du_pm_ops,
> > > > > >  				rzg2l_du_pm_suspend, rzg2l_du_pm_resume);
> > > > > >
> > > > > > +/*
> > > > > > +---------------------------------------------------------------
> > > > > > +----
> > > > > > +----
> > > > > > +------
> > > > > > + * DU instance
> > > > > > + */
> > > > > > +
> > > > > > +static int rzg2l_du_instance_init(struct rzg2l_du_device *du,
> > > > > > +				  struct drm_device *ddev)
> > > > > > +{
> > > > > > +	struct rzg2l_du_device *rcdu;
> > > > > > +
> > > > > > +	rcdu = drmm_kzalloc(ddev, sizeof(*rcdu), GFP_KERNEL);
> > > > > > +	if (!rcdu)
> > > > > > +		return -ENOMEM;
> > > > >
> > > > > Why there is duplicate allocation of rcdu? One in probe() and here
> > > >
> > > > The two allocations have different lifetimes.
> > > >
> > > > The one in rzg2l_du_probe() is tied to the platform device. It holds
> > > > what is needed before the DRM device exists and outside of the
> > > > component bind (dev, info, mmio, and ddev/is_master for the master, PM and remove), as on RZ/G3E
> > the DRM device is only created once both instances have been probed.
> > > >
> > > > The one in rzg2l_du_instance_init() holds the KMS objects (crtcs,
> > > > vsps, lvds, index). Their drmm cleanup handlers point into it and
> > > > run when the DRM device is released, which can happen after the platform device has been unbound,
> > so it has to be allocated with the DRM device.
> > >
> > > Then there is an issue right, platform unbound will unmap mmio and
> > > other data structures it allocated in rzg2l_du_probe()and drm driver
> > > is using after that( Use after free Bug)
> > 
> > Mmmm In theory no.
> > 
> > The KMS part keeps its own copy of dev, info and mmio, and its drmm cleanup handlers only drop
> > references, they don't access the hardware.
> 
> Can you please make sure these variables set to NULL, after
> Platform unbound?

Please correct me if I'm wrong but IMHO this patch keeps the same behaviour
as the driver before this series.

Where rcdu is embedded in the DRM device (devm_drm_dev_alloc()) and mmio
is devm managed. Setting the pointers to NULL would only turn an invalid
access into a NULL dereference no?


Kind regards,
Tommaso

> 
> Cheers,
> Biju
> 
