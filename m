Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F05606A323
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 13:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=dHHHOMpO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A13B210E8B4;
	Wed, 25 Nov 2026 13:47:55 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazon11010069.outbound.protection.outlook.com [52.101.229.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3489910FC56
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 13:47:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSryrpXwMlXQfc2GEd4az4y5O1f8328yPcOcKWAurKGTA81M7yOiskPwzTodk8WZI2hOqO1Cr8wUy7ZSsfCBt3bCGsEtHPumD8ylkf6cjIGQ0pn0BmXeX7mkgZhGZ06uZ1MxCJazUMKvcAGLuwEKBkX0+W0B43yEnEfBx61yzjSdMrhEl3duoLDKSxHSRBwgrFtFWp8gVAg58SOAG6QE+qgKUsV24nPNramCIp2Fj/+KhkVDqo8YwsT7VAEgcH+o4gR2YRHgSlMMe8NLnB9wZqq4ZnVR3RCHQxKDZqriz2A0N1dKcZY/Jzz+Ipc3WIlu7X1wIi2icN3G2F3Td/Vx3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejt5gDYjk9+qx7vpzXmU4SDhh+vXTMXNDdPM+1ps7zA=;
 b=s3lgzsiDSh1O493CHG3ZyYJnjfBh7jM8vx+ZovOOTJuk3W4XCLzekKAsRN1BTOZb0YnxVayTsuLbC1+2XybNdblAJxc+44ErWCywHtF3m3N5iJyhsfEC7GXvAwYbD0OlraBKtR/xC2gv6dC0DnnT0F06v1jLdPwjHT9oWdgHg+3TrgIHFgZvMMgRcok2dgwdrBn3Gm3sxdR9mDinexbI9mYaM1+y4F7T2/6BSZH3b4wSLq0xvRtT4TIDSlSD7g48aTjjRUnLBukZechsAA0m28rZjHvYhcEQTVhYrJyw+4ADD9rn4kIIpQ+SXo8lgRoQSM8PkSgIlWroOUlX+H34Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejt5gDYjk9+qx7vpzXmU4SDhh+vXTMXNDdPM+1ps7zA=;
 b=dHHHOMpO/kaGiS0Uub95ziFCmWGTIWdH57MinH/xSnspQv5o0UU5E05Jyqic2jV601QiItM6o0L2Kq8hXTLCTfhVL+VIIQO6vowpXC7NvtHaugCx/vuOSLeXlVmWzaBLDsxbUbYt9foak26fhLtBMChJCT1Oe0ghYtsswRNoeY4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OSCPR01MB15909.jpnprd01.prod.outlook.com
 (2603:1096:604:3f0::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 13:47:41 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 13:47:41 +0000
Date: Wed, 25 Nov 2026 14:47:21 +0100
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
Message-ID: <awbm6f3ovtva5gg2@tom-desktop>
References: <68fcf838eee14c1906f23b2b7c74c560793cd1d4.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <OS3PR01MB65968FEBCB08429F11188CE986452@OS3PR01MB6596.jpnprd01.prod.outlook.com>
 <awVW5B4p06FUfBHw@tom-desktop>
 <TYYPR01MB6603AA1B7A48B7D899604EE586442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awV8G86QIth4GtaA@tom-desktop>
 <TYYPR01MB6603A1FB28A473A400A2C49386442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awWsGjt6cW_CSoMH@tom-desktop>
 <OS3PR01MB659637409ADFF9CFC2AD395186442@OS3PR01MB6596.jpnprd01.prod.outlook.com>
 <awXcSSnNeaOQFQZ5@tom-desktop>
 <TYYPR01MB660340BEF9704BB69FE150FC86432@TYYPR01MB6603.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYYPR01MB660340BEF9704BB69FE150FC86432@TYYPR01MB6603.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: FR2P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::10) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|OSCPR01MB15909:EE_
X-MS-Office365-Filtering-Correlation-Id: e85c5b8c-0065-4f92-372e-08df4afaacd0
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|52116014|366016|23010399003|4143699003|261009223027099003|18002099003|22082099003|10067099003|11063799006|56012099006|261102123227099003|261026121527099003|261026140227099003|261021123027099003|261022105027099003|261022075727099003|261028144727099003|261021121427099003|38350700014;
X-Microsoft-Antispam-Message-Info: w6fJdAFG+wmyjYchxIcbMQsFLcr8tom2PBqnHfwpq9vp1ILYHBh10TZtBA+3f624i3LSRKGpmfeARY9q2Aw1JSNg1T1JFm9Z5dYKlBvFbH+wIUDoSE5rHdH2dzq2BIMlIzJu/SwzF8/YnlU3OcmtNwGzPznnXHEhFMKPT5mLa7FW8e3tLuctwx6i01eDpGLoei24OhJmGQulrVVGnSNv4y83/DLd3rXTXm2eGYO4Cuus7RZ4KqGvN5KeQY7Ov0QNz9ua0mf0c8KcWuxOiVtskWXwb/YwJY8FY93FR7YK5yvpHslzWlr64OVcIM0JATltLNd+nI6pdfCkudnWIsSsS1hYTLwaGF1sk7xlHoRmnjDF0mbWE0LwTyKSSG2alKJlYa5fKAsjTlPdYZKfRPpZj8fsF+dDT371+u0MqU5mJziLQeTQUDhLsY3pmbdUckIuvpjL7p2o+ToAw/F1W9Y1Mop9+OKwlKKGQC/XTq/wyYvgM0YvRIs06II2TZwsrXJlAwt+qmWxfreoqtR7cB1sX8dDO8cFD7MLDev0qJkq9bVUK7ODr74cy2uUpwdxfTCbWYIGP20TaMz/kI/hMD4rgyy90NHHSwBOAr/gMwhwVfiW8e9gTK42yfHZGtHt/T+LTKBAgOucagbfun0cWDNCrCi7MkgpjklnFWhDtIF9Bw6q6ZD/U8KaDrbWYy5wQeV4Hy279SHEHhJaI6vH0IJF3s5OqruXCRcVnl0y2zYI1cw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSOPR01MB295138.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(23010399003)(4143699003)(261009223027099003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261026121527099003)(261026140227099003)(261021123027099003)(261022105027099003)(261022075727099003)(261028144727099003)(261021121427099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E9+CYzJWE/XkMRtzQ4EPRCH1NfrLXnrD2QmLn2ZOhmph2HndP2DLMcurzoa1?=
 =?us-ascii?Q?8DNJwG/K2XwgyxFB2gCIKLFPRBI/ih4FqiS63GyVvAMUvUD4LKUodp3Nu3la?=
 =?us-ascii?Q?IMnL6FTFKQOSywJ/f/0XltFyF+itgDorrAHWOJMmPnDSqb5z61ldRYxk+mXJ?=
 =?us-ascii?Q?a+GakxUqHzIpEcbUFRk8++DtxwdaHx+nCFJ4O46sj4+mhRL/dIF6IAiyWryq?=
 =?us-ascii?Q?o+lxD1O3RBpp8cShRx59GBgPicDWh/HaF5O6UlOJXOnwcjoNnTPN4W9S/1dO?=
 =?us-ascii?Q?TmQDSBRzYcNA5RakOatP1FzPvMjTMn03+sArGPpgNU+4TmIJ1EX5h8TexIoq?=
 =?us-ascii?Q?vYpECcVQCh57I7++Ya+yv/QRlCmVvoIU6CoZJteiAOnJ2CVsSHD66qDVEymk?=
 =?us-ascii?Q?SjNiN0yATXqiGLAEFMW4UuRnuG+eGG72La3qccQZXu+PdcYzwmr8sJAMjymd?=
 =?us-ascii?Q?/nVZp8yCQKljmJc10tgPxt7RavnAvXmr+3DosDfgXULKXKoFuSW6TNntlsWd?=
 =?us-ascii?Q?Q9n5qKKi3EVCKUP3RruWfBRReS72fS4d3Kzfd/SmSgbU/eA+DRRrYKiSxyHT?=
 =?us-ascii?Q?Ih1IgxkKk/sSMmfcT9MfdU3Mht9tP6kuCFEig5jPL4fTm+0F6GZi2R3Zt3jo?=
 =?us-ascii?Q?Z3HYZVJ3YQ1A448yaznXnrSbLqyzGq+1h8yPeJDF+mDrwiAd8Wo+qmMFwXFs?=
 =?us-ascii?Q?rFxOCMryEO8rTcqeHyz1dQmz/9iCYm9LJCY5QeBcYLItFN9egfqXpiapfO7P?=
 =?us-ascii?Q?b+KfGy073XykVQEOR/VNvPaDY1cCM4ZT/lCz570s1EU2YCCBPVNYKVraaoMv?=
 =?us-ascii?Q?lWWZ+xKOxp5EDpR+K90htTqMRLvFhY0L74k+xXLDhnNAuN/YhW/G/iKOSoG7?=
 =?us-ascii?Q?WzPaEA2aMOGQj5/iEJYn6y7//nY7vK2XQhv96qGMGtWZfdlc4jxoWR2HkDky?=
 =?us-ascii?Q?WLB3sBLgtrNfQSawyjzh7WGVYNWdJwMba07uxdaY4CeQzmz356f1GYLDlQ1m?=
 =?us-ascii?Q?R0HgEeTYv9P9Xdd4MpT3mS6BI/5GsoykxDS4a2zq4GUhgE+I79WYFtU55KFG?=
 =?us-ascii?Q?aHI5u0JuEWWUS1PU/0nj6Umo/H3xzjXK6Z7lybDPAHVch6YX8u42J+knln0m?=
 =?us-ascii?Q?pC2lHZVIxGQZ7KYEA1rRfFDhZLRHoevVjT/al40J/axKEq4dAlLKfBwhmNzp?=
 =?us-ascii?Q?VgWDWiI5SUbV+WxUn9Dq/uUGwRRnpzaefFG/zv4ykwgn5iTKgK9jwgab+80M?=
 =?us-ascii?Q?08WFlBsaubSvj2gSxayF+dSWIZvzAt0CJDzDWrwN3ghJ1XJTgGUiK/8XrwbE?=
 =?us-ascii?Q?c5RyV81wZzGVORPEPwiDBN5yBnJY0LWbxBcAAzDsrAuGlQUmYq91NBEufmvf?=
 =?us-ascii?Q?Nc59kGrhYb+VBIe9Qj6kEGi6TidJ/uG4dEKvDQO71PaNoYesZtwnYSv9qPHM?=
 =?us-ascii?Q?tgSOH5Ae8+gpxQ8u1+BzR7n3VrmBJUjG1XrsHhvWM+nvJnqw3nzRzPsm18zY?=
 =?us-ascii?Q?KsVzUmBEkQCD2fgAet3Qbiq6SmLU7O60URcn5yBQgu/wK6eJ8VPZom5YTEac?=
 =?us-ascii?Q?VCUSxWKE8dDPmho8SLX3PdEN/C/KmzYv0eHTExK+5yYh/f9nRww+L90e889U?=
 =?us-ascii?Q?GHmjp6Vj1KQ63o4/VdhmO9ve345RNz1mSUbsTGcITf8osD2/7VO0DKH/2dSf?=
 =?us-ascii?Q?jFUxi2g3d1OnJ5K1wc+XJgZubE5uAstekDcaPnLxYu/53GpXbA+NK00YY49p?=
 =?us-ascii?Q?3uXyPLHvjktRaW5+QMY3i6ggOhlumw6n5ckz0Y9GTurRn/WHmzb3?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e85c5b8c-0065-4f92-372e-08df4afaacd0
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 13:47:41.4494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aSsM4o4OdUqd4gLJCU9U34W6tfUyGDFVduNVIRmas5nMd7jWx7OgIwhBRgSgC+CDTvcGi/x/95eOCA/Bp68QWQRJ/LLGGQPXTBfWCjCWMa+bOMAnZfjszl5EE3I2+UhX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15909
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

On Wed, Nov 25, 2026 at 07:07:00AM +0000, Biju Das wrote:
> Hi Tommaso,
> 
> > -----Original Message-----
> > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > Sent: 24 November 2026 18:50
> > Subject: Re: [PATCH v10 08/12] drm: renesas: rz-du: Separate the DU instance from the DRM device
> > 
> > Hi Biju,
> > 
> > On Tue, Nov 24, 2026 at 04:04:48PM +0000, Biju Das wrote:
> > > Hi Tommaso,
> > >
> > > > -----Original Message-----
> > > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > > Sent: 24 November 2026 15:24
> > > > Subject: Re: [PATCH v10 08/12] drm: renesas: rz-du: Separate the DU
> > > > instance from the DRM device
> > > >
> > > > Hi Biju,
> > > >
> > > > On Tue, Nov 24, 2026 at 12:51:18PM +0000, Biju Das wrote:
> > > > >
> > > > > Hi Tommaso,
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > > > > Sent: 24 November 2026 11:59
> > > > > > Subject: Re: [PATCH v10 08/12] drm: renesas: rz-du: Separate the
> > > > > > DU instance from the DRM device
> > > > > >
> > > > > > Hi Biju,
> > > > > >
> > > > > > On Tue, Nov 24, 2026 at 09:33:13AM +0000, Biju Das wrote:
> > > > > > > Hi Tommaso,
> > > > > > >
> > > > > > > > -----Original Message-----
> > > > > > > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > > > > > > Sent: 24 November 2026 09:21
> > > > > > > > Subject: Re: [PATCH v10 08/12] drm: renesas: rz-du: Separate
> > > > > > > > the DU instance from the DRM device
> > > > > > > >
> > > > > > > > Hi Biju,
> > > > > > > > Thanks for your review.
> > > > > > > >
> > > > > > > > On Mon, Nov 23, 2026 at 04:59:32PM +0000, Biju Das wrote:
> > > > > > > > > Hi Tommaso,
> > > > > > > > >
> > > > > > > > > > -----Original Message-----
> > > > > > > > > > From: Tommaso Merciai
> > > > > > > > > > <tommaso.merciai.xr@bp.renesas.com>
> > > > > > > > > > Sent: 13 November 2026 12:20
> > > > > > > > > > Subject: [PATCH v10 08/12] drm: renesas: rz-du: Separate
> > > > > > > > > > the DU instance from the DRM device
> > > > > > > > > >
> > > > > > > > > > On RZ/G3E two DU instances share a DRM device, which can
> > > > > > > > > > only be created once both instances have been probed.
> > > > > > > > > >
> > > > > > > > > > Split the DU device structure: keep the match data and
> > > > > > > > > > the registers in a structure allocated with the platform
> > > > > > > > > > device, and allocate the KMS objects with the DRM device
> > > > > > > > > > in a new
> > > > > > > > > > rzg2l_du_instance_init() helper, as they are released
> > > > > > > > with it.
> > > > > > > > > >
> > > > > > > > > > No functional change intended.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Tommaso Merciai
> > > > > > > > > > <tommaso.merciai.xr@bp.renesas.com>
> > > > > > > > > > ---
> > > > > > > > > > v9->v10:
> > > > > > > > > >  - New patch.
> > > > > > > > > >
> > > > > > > > > >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c | 61
> > > > > > > > > > ++++++++++++++------
> > > > > > > > > >  1 file changed, 44 insertions(+), 17 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git
> > > > > > > > > > a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > > > > > b/drivers/gpu/drm/renesas/rz- du/rzg2l_du_drv.c index
> > > > > > > > > > d3cccbdf9012..d102876c07e1 100644
> > > > > > > > > > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > > > > > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > > > > > @@ -162,6 +162,27 @@ static int
> > > > > > > > > > rzg2l_du_pm_resume(struct device
> > > > > > > > > > *dev)  static DEFINE_SIMPLE_DEV_PM_OPS(rzg2l_du_pm_ops,
> > > > > > > > > >  				rzg2l_du_pm_suspend, rzg2l_du_pm_resume);
> > > > > > > > > >
> > > > > > > > > > +/*
> > > > > > > > > > +-------------------------------------------------------
> > > > > > > > > > +----
> > > > > > > > > > +----
> > > > > > > > > > +----
> > > > > > > > > > +----
> > > > > > > > > > +------
> > > > > > > > > > + * DU instance
> > > > > > > > > > + */
> > > > > > > > > > +
> > > > > > > > > > +static int rzg2l_du_instance_init(struct rzg2l_du_device *du,
> > > > > > > > > > +				  struct drm_device *ddev) {
> > > > > > > > > > +	struct rzg2l_du_device *rcdu;
> > > > > > > > > > +
> > > > > > > > > > +	rcdu = drmm_kzalloc(ddev, sizeof(*rcdu), GFP_KERNEL);
> > > > > > > > > > +	if (!rcdu)
> > > > > > > > > > +		return -ENOMEM;
> > > > > > > > >
> > > > > > > > > Why there is duplicate allocation of rcdu? One in probe()
> > > > > > > > > and here
> > > > > > > >
> > > > > > > > The two allocations have different lifetimes.
> > > > > > > >
> > > > > > > > The one in rzg2l_du_probe() is tied to the platform device.
> > > > > > > > It holds what is needed before the DRM device exists and
> > > > > > > > outside of the component bind (dev, info, mmio, and
> > > > > > > > ddev/is_master for the master, PM and remove), as on RZ/G3E
> > > > > > the DRM device is only created once both instances have been probed.
> > > > > > > >
> > > > > > > > The one in rzg2l_du_instance_init() holds the KMS objects
> > > > > > > > (crtcs, vsps, lvds, index). Their drmm cleanup handlers
> > > > > > > > point into it and run when the DRM device is released, which
> > > > > > > > can happen after the platform device has been unbound,
> > > > > > so it has to be allocated with the DRM device.
> > > > > > >
> > > > > > > Then there is an issue right, platform unbound will unmap mmio
> > > > > > > and other data structures it allocated in rzg2l_du_probe()and
> > > > > > > drm driver is using after that( Use after free Bug)
> > > > > >
> > > > > > Mmmm In theory no.
> > > > > >
> > > > > > The KMS part keeps its own copy of dev, info and mmio, and its
> > > > > > drmm cleanup handlers only drop references, they don't access the hardware.
> > > > >
> > > > > Can you please make sure these variables set to NULL, after
> > > > > Platform unbound?
> > > >
> > > > Please correct me if I'm wrong but IMHO this patch keeps the same
> > > > behaviour as the driver before this series.
> > > >
> > > > Where rcdu is embedded in the DRM device (devm_drm_dev_alloc()) and
> > > > mmio is devm managed. Setting the pointers to NULL would only turn an invalid access into a NULL
> > dereference no?
> > >
> > > Ack.
> > >
> > > But why you need copy? What preventing to use original allocated rcdu
> > > in rzg2l_du_modeset_init_du()?
> > 
> > The copy is needed because the two DUs share one DRM device, which can only be created at bind time,
> > once both instances have been probed.
> 
> That is ok. Both DU's share 1 DRM device.
> 
> > 
> > Before this series, the DRM device was allocated in probe with devm_drm_dev_alloc(), and rcdu was
> > embedded in it.
> > 
> 
> OK.
> 
> > Now each instance needs its own structure at probe time (dev, info, mmio), before the DRM device is
> > allocated with devm_drm_dev_alloc() in the master bind, so it is allocated with devm_kzalloc().
> > 
> 
> That is ok.
> 
> > The KMS objects (crtcs[], vsps[]) belong to the shared DRM device, so at bind time each instance
> > allocates its own structure for them with drmm_kzalloc(), released with the DRM device.
> 
> Why we need drmm_kzalloc() here? Can't we use pointer allocated with devm_kzalloc() 
> to avoid another copy?
> 
> > 
> > Each instance copies its own dev, info and mmio into that structure, as they are used by the KMS code,
> > e.g. rzg2l_du_crtc_set_display_timing()
> > (mmio), rzg2l_du_encoders_init() (info) and rzg2l_du_crtc_create() (dev).
> 
> Since each probe's DU allocates rcdu, can't we reuse same rcdu for holding
> dev, info and mmio and pass the pointer to KMS code to reuse mmio,info and 
> dev in rzg2l_du_crtc_set_display_timing(), rzg2l_du_encoders_init() and
> rzg2l_du_crtc_create()
> 
> Is the below code[1] does not work? Do you see any issues?
> 
> [1]
> static int rzg2l_du_instance_init(struct rzg2l_du_device *du,
> 				  struct drm_device *ddev)
> {
> 	du->ddev = ddev;
> 
> 	du->index = ddev->mode_config.num_crtc;
> 
> 	ret = rzg2l_du_modeset_init_du(du);
> 	if (ret < 0)
> 		return ret;
> 
> 	if (WARN_ON(drm_crtc_index(&du->crtcs[0].crtc) != du ->index))
> 		return -EINVAL;
> 
> 	return 0;
> }

TO avoid the copy maybe we can do:

static int rzg2l_du_instance_init(struct device *dev, struct drm_device *ddev)
{
	struct rzg2l_du_device *rcdu;
	int ret;

	rcdu = drmm_kzalloc(ddev, sizeof(*rcdu), GFP_KERNEL);
	if (!rcdu)
		return -ENOMEM;

	rcdu->dev = dev;
	rcdu->info = of_device_get_match_data(dev);
	rcdu->ddev = ddev;

	rcdu->mmio = devm_platform_ioremap_resource(to_platform_device(dev), 0);
	if (IS_ERR(rcdu->mmio))
		return PTR_ERR(rcdu->mmio);

	rcdu->index = ddev->mode_config.num_crtc;

	ret = rzg2l_du_modeset_init_du(rcdu);
	if (ret < 0)
		return ret;

	if (WARN_ON(drm_crtc_index(&rcdu->crtcs[0].crtc) != rcdu->index))
		return -EINVAL;

	return 0;
}

In this way we can drop the devm_kzalloc() from the rzg2l_du_probe().
Will be fine for you?


Kind regards,
Tommaso

> 
> Cheers,
> Biju
