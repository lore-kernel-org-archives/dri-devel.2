Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1EC606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=HaOnoQFq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B99A310EF52;
	Mon, 26 Oct 2026 14:59:00 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013000.outbound.protection.outlook.com [40.107.159.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8CF010EF52
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 14:58:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UMmJ8i7MQYrgznJ5pScjKOLFjJ4PT5tmm4jN/ScCHUXwdzaejSmOim3UGV7mb2dgStvuAjGqELIg81c9fvE/hHKMtiwX322AzlIPljHBAdj5Dur3QDTFsZqo+pV+3vkHEEaiykv8hX7Kh+1A5wZ0sdzFYe7wC/F++6B9cwoCDKMbW8/Ae/BCHoHIUDiKVx8DuS36yVF9vrcuyYYib4rGCHsyHyP43LwEgUdKehsiG6b1O1fkb8D++dD/I16UyiZDDhIpnTQhFbX16UD+dmbcR6EYk2iitCO0nJ0fw+gCF36dg36Vu4/GMlpg8ukj7GbtxUgw1rlC8Ve38GH3MTubyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSmOZrIpRY65/d5vWIFXFZ1Wq5EMAjQ6Og4Ui6Xnkoo=;
 b=r7GJsFLCJx9el/4O/ulWK4ulFVCQOTVKiCM8ACXhYfED3hiCs1oyltljxLmgerBMNnRbxY0L+/qSURtUDECs72iWYmWqXP0xPHuhpWrinyqwxJghZ53WFlLnDRyxi2grWNEnwv58baF8Ax4zTukW1Z9tr3OOgB+FkCQm0a7Vmcp1clgVvyBU3tGoD1/I+nMDY+MiAuC2AfGmbcYrqc5LW6OacjywIK48bJZpin8Wf9th1IppUEJvouRFfkzHq1SABy04NNgyCr/duHbQhOHvKSC0tbdBZi+/RafUI65OO00GnmKjAmyT4x1kH7W8oPJTD8bav1fZzIbNWhGU7izoag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSmOZrIpRY65/d5vWIFXFZ1Wq5EMAjQ6Og4Ui6Xnkoo=;
 b=HaOnoQFq8lGPJuieI9gNNGjxQdnmbdNqC3w7n0SxXa5MSzEX/78RQ7h1VNgX8B2B2BeWBpAbliyYUICpIawgjKveY8e4XDiV59iLnOJj6HCe0pXdYU4Xrjf/sRdoT5FsREjoDIyTBJjzItmHwUc52p76nu/iY51Pqa1QxAXnMu43nB6ksEcdNJvkZqvOEJ0YjVqyh5Hfbqmvm/5UawA5Qe70TIqO3HS2ffZaMk7NENoQo7fy8D3ib9/PYwa9J2DzTJpunJuHOXeg+ntvkLR9gBMBNydUoBZ4mLY0tM68/YV5YcZiku7Hci+0K6EUCD27p47hcVv+002wOmk7ad44rw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM0PR04MB662462.eurprd04.prod.outlook.com (2603:10a6:20b:7fb::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 14:58:50 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 14:58:50 +0000
Date: Mon, 26 Oct 2026 09:58:38 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Leonardo Costa <leoreis.costa@gmail.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Leonardo Costa <leonardo.costa@toradex.com>
Subject: Re: [PATCH v2 3/3] ARM: dts: imx6q-apalis: Add VGA overlay
Message-ID: <at9qnn_njux-hwj2@SMW015318>
References: <20261019-v2-apalis-imx6-enable-vga-v2-0-ef6a3a780472@toradex.com>
 <20261019-v2-apalis-imx6-enable-vga-v2-3-ef6a3a780472@toradex.com>
 <atZxhWaUWthEHkti@SMW015318>
 <lozimedmt3h7v6odvp4svvmatvk7726a4ztn3j7ft44oto7p5p@dmrudrmzyz3s>
 <ateQWqoTtXSBSBvm@SMW015318>
 <wancrsxcem5uep5oy5pnw5prewefqah7drmhiu5wrq3ctykltl@akwvtqbebblb>
 <20261026124328.GA82443@francesco-nb>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026124328.GA82443@francesco-nb>
X-ClientProxiedBy: DS7PR03CA0296.namprd03.prod.outlook.com
 (2603:10b6:5:3ad::31) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM0PR04MB662462:EE_
X-MS-Office365-Filtering-Correlation-Id: a2809a36-084d-4543-b8ae-08df3371a53b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|19092799006|23010399003|366016|1800799024|261026140227099002|261026121527099002|4143699003|11063799006|56012099006|261021121427099003|261022105027099003|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: yXqFxykwJji3vXgxki86xjKpVDHjKJtd8T5BafR4Gkm6VSBQQ7iOMoC9AARo+AZOCoRJXNDshbGA3D7KoZd3I2pcc92SHn2TJXVshu2I4j/lQU2rYa5ntlpgjCV36leX5ndOu4PrXayP+urNieVrmt14IC8gWEeJnjlRZ9gYZnHuEMCz+rnHvzlprOfk6WgDPNjRHHoBlfiuzTLJkqIOddCg8BAklOXK7zy0B8hQninGEREI2x+f11l7EcFJmTrV5eEr/JfUrdcOE8HE/i7r6WMvOJUGs8z+R9SOZUCzjszzkI3Us6zY2paGtC8BnpvT7os6lmTQed1yp+6iIRYjQBPYYYPLguJNVgXYp73XetIG4DcAwEzdaHxUxlzFkz+QDWY6wOZZCoHPqmHnQaq2zHZ5hcKRu5iE+kSCLzdCjP77z1FICH3kZJsoFC9LfRQrO4JrZ6mplTOzOiWH8ii7kqK1sJPTHwTibyldARFnqA8NKW7Wg43j5LA9+Y8Uzw1XviRLPKky12VXkT0VvMrNnO9y/+noWtCv/47f5/1hAbsHIXGERL+kMIu9sFEDEJIJ05hQxGhrRGgE5vMUuibApF1tmOAQcwkdjh8c0rgx/78a/K6F3fYQVd/bkgGxT17a
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI3PR04MB12438.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(19092799006)(23010399003)(366016)(1800799024)(261026140227099002)(261026121527099002)(4143699003)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ujRAjjNxBonV26zJ8am51G3tm9XDLDcx4lGXt11Ir4yvl+viksWDyAUOMkiF?=
 =?us-ascii?Q?tdXrusU/HSDsEBa/i6J8eMtZAbLAghi9ootYf88kAMs2bqPrMcuPElgGvT2D?=
 =?us-ascii?Q?5Bfd1JIGT6kk6w7w2C0EBI1hlXDB2picoqKQ90xXD4peJ2GO130ZradGNpDF?=
 =?us-ascii?Q?AfZWdTs4ul7mBx/f9G2AGu22QtlJSaeca4xLhb9zS8OXPJPpSgH6xIX7emuj?=
 =?us-ascii?Q?zoTnT48DzHg4WSsps/pYdP0/3EuOsbi2vjDVkJxT+zWY8dBauwVpYRwQ4WAK?=
 =?us-ascii?Q?1Hi6msNIITKWCRXQJFcEPwKtloFPoxtR7Jj0DGgBUI2tf1Pu/0isY+pi4dkG?=
 =?us-ascii?Q?gQ9FBAaSwTMnRSj6kLyfRvqz39gQmVtfcP3lFHhmBPLwcKov9MsxqBUQOuI2?=
 =?us-ascii?Q?t4caScUZmWxyV5n071FnqLdtrHthcBohvW/edSXBmXpUYvR3thgKS5o7w9bn?=
 =?us-ascii?Q?8XdlxndC6jJ9Me+LQCCxiwI+W1aumA30K2VBCnyBp6LmCXL2pK+9UbpXOpBk?=
 =?us-ascii?Q?t8vnKAWinOYjLXnngYa6o/rwkwUZpZH9xnruHml8Nr7eBCR7E8Y/EkcQNtEP?=
 =?us-ascii?Q?L1vKugOGEZzN09+Xg/qOQ+D8megSWwEDVHd3E9OLp5U+zVlwEo+4Cce1At91?=
 =?us-ascii?Q?rOjwK1o5KDU0nlGxPfyxBFoMMH/XDu3SgBf/5auhLZBE2gNt2ecQIQvNpyg2?=
 =?us-ascii?Q?CdH15m7Db28iAwilTJsxdmCUzGRbYwwLb0zY2DdoC6D0IA0sUD1EA5OgkJLD?=
 =?us-ascii?Q?Bj81OQxrk/sKCuJpQqpbfY+E22YAkfpnybe3K2Zvnntl5mriT1D7IIT7i8Rw?=
 =?us-ascii?Q?Aq/eIf57sP3dAx8QBJeL3DWAwQ4Vec1cXHW5ZHwhVfv2sfDtekX9xv2smj1r?=
 =?us-ascii?Q?sxPHvXpcZ676MJtho3jluyWxtcZtypfbuAJ1CSO9xdf4YV0yh0DVXSnaFXd3?=
 =?us-ascii?Q?dU2lN+YtQlDy3NhzEDB1HadUQu4Fm38BqSz3zGwPbJmBI0aGTgRNfDzIiwNg?=
 =?us-ascii?Q?v++cKlepFsiyX2aNKqjdUVAXorOt4oqzRm0GS7ZIhtrmOqpaq4mCauoTi689?=
 =?us-ascii?Q?iCSru8qqWocg8NQxIjUHDn8+r6Mim7GJaQhXNAN6FTGN/57VrgmvKKdI2kF/?=
 =?us-ascii?Q?mkC1zD2lEPKRhk/AC/imaALezY9QY4d5yrcfIEeza6KFGt/cDPKounvbUEvQ?=
 =?us-ascii?Q?vf/iFlL5cfM+q748LhuxQwAMWBBGJZGTPm1i2+qWAkF5hRGtBJpfZDDQ9v5d?=
 =?us-ascii?Q?o1GGAnjOzoqXtcuRR33Z/WCu2xfkiqIQ7gw+szicUWFcW53OZbzKkwNoLEGV?=
 =?us-ascii?Q?q0A3XOUq13IaqxfCXT4lbzmli2wcUEQZhfTKjCAVHqgHXVrrSi3ioZx+F0NA?=
 =?us-ascii?Q?QJbBASihQgMBpqSYHAcj1U7jnga9jZh3rux/ZGidemBSn27CLEiQSRXzZJpG?=
 =?us-ascii?Q?rNbfmvdq2OEzf12XJVtSnsVtQ6Et/IFSGDvmysmdNLKUDk8y947nwAJeiCsE?=
 =?us-ascii?Q?9m3E/ihybFX12Wsg4PVly74UOohG7ehpsMbEbxvdX080zzEpyB8or5R/DPpu?=
 =?us-ascii?Q?9hnkhw39dhMORzZqHOufVLySSL2DqaXp8U0U5usH8wJGrAZIkyLVEtx3GkjS?=
 =?us-ascii?Q?YKmRaOzpVUBudrgLQNDa/hrTkzslVkn1jAn/3gcf+/INoz/N4vBmIZr4xsFq?=
 =?us-ascii?Q?ezzQZXdXLm1VxkLHav1PDDJDzjJzrPpbNYXPF/QUpZt47VqApQ60V41lgK7S?=
 =?us-ascii?Q?El29u+Z27z9s14oF+JMhDQAikpnT7e0p5NDFUVLon6l25QroFjWf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2809a36-084d-4543-b8ae-08df3371a53b
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 14:58:50.8279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3UpClUqnueZ3CjW1B+NgrgJ1hrSnS/NA2lSNYF1O/4l6vTFhCj+TiBOConBzsrAINggtAE9liaMS2+H5oiD6ZRhwpk47+ah//TdqNjEGDo02/sgneYkspK/auflsiXb5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB662462
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

On Mon, Oct 26, 2026 at 01:43:28PM +0100, Francesco Dolcini wrote:
> On Mon, Oct 26, 2026 at 09:25:20AM -0300, Leonardo Costa wrote:
> > Hi Frank,
> >
> > On Tue, Oct 20, 2026 at 11:01:30AM -0500, Frank Li wrote:
> > > On Tue, Oct 20, 2026 at 07:33:10AM -0300, Leonardo Costa wrote:
> > > > On Mon, Oct 19, 2026 at 02:37:41PM -0500, Frank Li wrote:
> > > > > On Mon, Oct 19, 2026 at 07:17:16AM -0300, Leonardo Costa wrote:
> > > > > > From: Leonardo Costa <leonardo.costa@toradex.com>
> > > > > >
> > > > > > Add a device tree overlay for the VGA output available on the Apalis
> > > > > > Evaluation Board, which is driven from a parallel RGB interface passing
> > > > > > through a non-programmable video DAC to a VGA connector, without VESA
> > > > > > DDC I2C signals.
> > > > > >
> > > > > > The non-programmable video DAC consists of a simple resistor ladder that
> > > > > > converts the digital 16-bit RGB signal to VGA. The VGA output is gated by
> > > > > > an active-low data-enable signal.
> > > > > >
> > > > > > The overlay is also combined with the various Apalis Evaluation Board
> > > > > > device trees to provide ready-to-use DTBs.
> > > > > >
> > > > > > Signed-off-by: Leonardo Costa <leonardo.costa@toradex.com>
> > > > > > ---
> > > > > >  arch/arm/boot/dts/nxp/imx/Makefile                 | 21 ++++++
> > > > > >  .../boot/dts/nxp/imx/imx6q-apalis-eval-vga.dtso    | 80 ++++++++++++++++++++++
> > > > >
> > > > > what's difference with
> > > > >
> > > > > https://lore.kernel.org/imx/20261019-colibri-imx6-overlays-v1-5-e4d028727382@toradex.com/T/#u
> > > > >
> > > > > Is it possible share one dtso also?
> > > > >
> > > > > Frank
> > > >
> > > > Hi Frank,
> > > >
> > > > The Apalis iMX6 one needs to set up the connection between the IPU the
> > > > LCD interface (endpoints ipu2_di0_disp0 and vga_display_in), and the
> > > > Colibri iMX6 one uses a DVI connector instead of a VGA one. Most of all,
> > > > the bridge on the Colibri iMX6 doesn't have any control signals, while
> > > > this one on the Apalis iMX6 has an active-low data-enable signal
> > >
> > > This make sense to use difference dtso to cover it. Is it use name
> > > imx6q-ipu-di0-vga.dtso, because this dtso have not boards specific part,
> > > which can reuse for other similar hardware? Or we can rename it when reuse
> > > happen.
> >
> > I think the overlay should be kept as imx6q-apalis-eval-vga.dtso. As it
> > currently is, it's easy to identify the hardware it may be used with. If
> > another board is added which uses the same interface in this same way,
> > we can evaluate if it's adequate to change names for reusability.

Okay, we can rename at that time.

Frank

>
> 2 more cents. There is no such other board in the toradex portfolio and
> it's very unlikely we are going to build any new board with an old VGA
> interface.
>
> Francesco
>
>
>
