Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527AB606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 16:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ByiGL/R3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD6A810E28E;
	Tue, 20 Oct 2026 16:01:51 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011009.outbound.protection.outlook.com [40.107.130.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C43ED10E28E
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 16:01:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oU8amHryrJ6QlFh4H+2k7Gg9/nacT+gh6mrXCUwPtj7s2NQzcfANxLU/neHmrqwVoni2HVy0vVQjjJLjvlV6siq6BJik7fMksb2yBUk+m35xcuHRFBnEpnaQiYBvJFZAOS8NKGAi9ZYd8IXQZBzMtzutI5w9vz1p7ot6ClRdL2tdRtfLuuvEfCi9b8vtE6pgm9119MUGLjx10+VNGQryrcJ28y0vNCqqwbQV9VqpdYE/TJjd+tRnhOwTnkRNN4JuPbCuuVoq1/wCU1nsSQVywabWQNNRLBYf6EhNmpe8jI5PCIZZ95tlE849yLvDvkVAL61d4tciQVrmR7Fz6FTc/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekoqrIm0WW21+sshVfBws0IBQcvJyBcAoqSMJQoB4Tw=;
 b=OEJuaHbItgRBS+k0GuaKDThWrTEJ1jUe7LpnT7RGk1yCy5tOcTUhYAHe/m8Hx6R0Ju7oCG+/JE3RCxjq9TcovCh8wt/tWrexWtjrfFw1bIvqoC0phZjuaW6Gt6ffwssxKFcrEr+/rPvoMwe4iIskDE4H1wsue+8BtRGZxBqXKjHVaVOSa8KoKlmc8/o+6/srrgwsDP4LSbsr1Z4Gp+6SQKq74BkAwXl1jM1P7cszIXdUMcrttZ4hhN3SCBBN2kcRbevQsI0EmIZJD5nbGWETICDYvurMijI29eiKUFrUJwBWpwl0HZ6llm46hiNLPyTfweu7XG2/goII8F45EjFQqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekoqrIm0WW21+sshVfBws0IBQcvJyBcAoqSMJQoB4Tw=;
 b=ByiGL/R3hAyAt/Ps1YgEnUTJPOZRwvAAzfdWNyhFvP0PpzKmFPF3tU//CciMe2DnvVSfHXIA4In6nGjOY3rGlbAJ0N2mn0NTt5fFo0oo6gYRjbaK2IP3R2w1GNHgGvP9zk9H3OZWMm9NWkezNK5PipJT+m2zeso94f2TJp5IkLiBGzzcMfabJeAyplRFFhI8RCg5JA4WCBntDu2cCvevFr35kCf9qSpLaP/QnONkcInrKA6MBIE4/MSfyoNr6ppaau2+zSZ9ieo6n2+Thm0QivBZ+ivxOegVObTZv+Iwr4YBOfsGpX1YC68Iv7toBSBmbrj+vMEoNfSPa2VRBFN6+w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM8PR04MB7731.eurprd04.prod.outlook.com (2603:10a6:20b:249::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 16:01:42 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 16:01:42 +0000
Date: Tue, 20 Oct 2026 11:01:30 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Leonardo Costa <leoreis.costa@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
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
Message-ID: <ateQWqoTtXSBSBvm@SMW015318>
References: <20261019-v2-apalis-imx6-enable-vga-v2-0-ef6a3a780472@toradex.com>
 <20261019-v2-apalis-imx6-enable-vga-v2-3-ef6a3a780472@toradex.com>
 <atZxhWaUWthEHkti@SMW015318>
 <lozimedmt3h7v6odvp4svvmatvk7726a4ztn3j7ft44oto7p5p@dmrudrmzyz3s>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lozimedmt3h7v6odvp4svvmatvk7726a4ztn3j7ft44oto7p5p@dmrudrmzyz3s>
X-ClientProxiedBy: SA0PR11CA0124.namprd11.prod.outlook.com
 (2603:10b6:806:131::9) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM8PR04MB7731:EE_
X-MS-Office365-Filtering-Correlation-Id: 480b77e6-972a-4aac-f975-08df2ec36e82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|23010399003|19092799006|366016|56012099006|4143699003|11063799006|10067099003|261009223027099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 4sLI7FRJ+DBwq3BW4QA19l/UCAptdFTVQhO75x1jwXdvaB0/FXE+Er/aPwaeYE9S4yBl6e7OsqOS4XfSEuaqXwVYT6Tx8gfibeFWxPHiKQdTy3DSwJGlhCk3XUuc5EefolI9soVolhdo7Q4M/csIJ+buQfcVlxRbQtepQ2Acn0M/pSx4fmteizIMoszrI+p0KBtviO5PUX3G4Zt/SjzLuFdj935Gh92xxyGhe8AuRq1E6QUaXZaMvElGqlrql9MXGej/yc7EbHKc909ckqhtlF/m9ggY8mGbVKUHyWxiy/ZQmE7eRpMCgpagrl34YLBMqmW2+k7+vz/vqSEaf+AaqTly8luU51z+SKriizVXmP+M5yPR+mCHtFI4kG1F4maT8y6AOE6k6YKufQD2+4kis0XURAXEGe8eLsEM4OBn3LHXK5m4Dv2OB6NVQoN/i4449UH2Y0h3hqP5zIq09ek32fxdABYCazt2jnKJd9+YKEfraRKebSNSz/wtC521TieiJkf+eX0o8ZncU4KtA/VzKj+m28Zwt2IUP5n1J3J4PB9xZnC9C6P8ebpg/I1lAFbKrhB0ROYk9RR2eGTZv4KgHotVxbDfBEtbIWdA50z6dtLZFcP866PL3OOCE/t7+LwY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI3PR04MB12438.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(19092799006)(366016)(56012099006)(4143699003)(11063799006)(10067099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sttDgcBfncwz0+uOi7/qcvzCMaWqNj5A7duqhWGsgRtSUaJi1p29MarYw9lW?=
 =?us-ascii?Q?MJLJKPUALmTOzYqFVC2Y1+rQqegUYTWJ04ZhxkwSdIo7AHfwGXBzu5w9fLY4?=
 =?us-ascii?Q?PldV0lH/kVid2bCEvwv2A0ChaRhSrkV11qmYJmhI/DCS8GPUZvfNAesRBUTR?=
 =?us-ascii?Q?53lV0jle7AqB2prVVzBjRiwnyBu0fuczFL1pK4R9fhAOILbady/AVRxnMz2K?=
 =?us-ascii?Q?RfpeFCm8GXxM2v7dzSzFwsYvDkaXxO+A/dpe9S5BnHnEVb9VFLytdl/KlkfX?=
 =?us-ascii?Q?wSt25awQakZ4IW1WL9njaZDxYOUdciuFGpkdxsFYcKtZzknEHnqHM6UDZE6V?=
 =?us-ascii?Q?Ho4E46mPOejBLzntnA0AjfqBMUGuBET3VhN13xjk6bEnfhRUbPxpn3rec2lA?=
 =?us-ascii?Q?iJuaLqJB9uwGxH4ns6d5qOylLJGiMX6Bw+FW5+FMOS6UEcw0IBJui6W5KwWC?=
 =?us-ascii?Q?eqfmzmk5uPqIH0fcvBk8w/emujDKtUvtFUMBefWe54ymjF5ApXFgPvPNwNpB?=
 =?us-ascii?Q?/dQCiFW6T3ER0/8sLbTdMJJulRVavV2ITnvj+r+3pT1wuOjB5jdDZF8Qs1+c?=
 =?us-ascii?Q?72Wgr8fkWdKGTJ/nklv0bd4YYbnupwVmKDoTwwc6GZKKRUEdtSskpL5gzQv7?=
 =?us-ascii?Q?O7Xg2bVAZN1pBr9Vf22E2j+KQtUFTkswQ/7sye07uQxcp5jpV2u9Rxz+jA/b?=
 =?us-ascii?Q?MmWhm8CPcVOqerIpUKRuuWebTbSNSleSAF2or56R3Bdfzwigg7vHA/TY1+FC?=
 =?us-ascii?Q?Q440rd+SvyT8pgUQb+hoqmu9R6Bk8se8G4dXOocj19czT8WkekKqaChhOMrh?=
 =?us-ascii?Q?cC7DI6K3Thj+rSNRGybS1L+yKtPDyeKwtW+DxLcOYboPIUGg26eh6DtuV4qX?=
 =?us-ascii?Q?FIAmvStHqoaS82/4IWGnfs0s0wuGUKMlzdYY0YsIQgwOyinq5S7ei1vlQQPS?=
 =?us-ascii?Q?yCJh05vx05E23E1pgPe3T/vvQENX5lip2QpsZABhd5ipYsvvceiIThpGtoG8?=
 =?us-ascii?Q?7jOryIi2Kg+W2iVUy0WZsCnP0ZzYIATtB34dySxVYL86zekcOg+IPbzIPKQs?=
 =?us-ascii?Q?cN2gQcmaj81Je/EjmWnQJ2k728wFQ9/sDYYPirfrbmy+CEPzOkNH6CZsVtxI?=
 =?us-ascii?Q?rzDcNdCJXXJWhvwPNX2v55d3+ZPgC2hRm9gW0P7AOC5ppg77nB7J1z7Kutxc?=
 =?us-ascii?Q?BFP4x80URMW16CXYt5e5AuKOUASqv+ZLPL0GLxbx7MAOnKvECzSjKB9voV+1?=
 =?us-ascii?Q?WUy1Fh+9I0uTPs7efMbZs/9ZIwH/zAQOOVTQfJuVZNzOmE5sqjQ1F5kzu5Y+?=
 =?us-ascii?Q?nBFz3jc5sVW2XgvX71Pl0hFn8m7l6mebPtpFk6dLqEdXIyw+qpocjBTB+qSH?=
 =?us-ascii?Q?lZkb4dcNA4R96s1efUgqzTz90m7Gqzq1s2vX+E78c2dXiYKedHdFWCd5mDiD?=
 =?us-ascii?Q?Ah5y2hSv++ryNmcdW+4LUB8AkwSw2B+76Rc1TrlrXdyfKqOBcg3EYokoqe0a?=
 =?us-ascii?Q?e/2c3sIXQf95443UOcHhNX7zf5d7WOKyXnp4YgDYx9VmRJ0mgUo5OqFoZkAQ?=
 =?us-ascii?Q?AGZP5pksKj+OYmXLALS78e+l9SbElsZ20tZS1rdyevdWDIaPNXSnMbmArAKL?=
 =?us-ascii?Q?fXjCCeOiBt9p6PApPb0q75DprmkC2/nb5IFooT0RaSRziGwsw5cDu6L5n24H?=
 =?us-ascii?Q?OPbsoyOi37HMsBZr1VG5kbPrhVKPKuS1vqYuPAYNdXjKQFK+zioa/vy2IL3v?=
 =?us-ascii?Q?x2IKLJ3Me8ae3hPH13+3sVntJZ1WLGzaImZKsc4mGqmGbxyoUri9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 480b77e6-972a-4aac-f975-08df2ec36e82
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 16:01:41.9693 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RfRq3pwOd5jTlz2BNa2at7f8Zg7stGSheTp3fj0ZcNr+JBdo7mNnB97J3yLKEGr6rNWJII1Bqx4EmYyyvGgnHc+AzRLGMcYiZKBoheArzLeqAdbU4vyC3eqePM+/8rTS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7731
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

On Tue, Oct 20, 2026 at 07:33:10AM -0300, Leonardo Costa wrote:
> On Mon, Oct 19, 2026 at 02:37:41PM -0500, Frank Li wrote:
> > On Mon, Oct 19, 2026 at 07:17:16AM -0300, Leonardo Costa wrote:
> > > From: Leonardo Costa <leonardo.costa@toradex.com>
> > >
> > > Add a device tree overlay for the VGA output available on the Apalis
> > > Evaluation Board, which is driven from a parallel RGB interface passing
> > > through a non-programmable video DAC to a VGA connector, without VESA
> > > DDC I2C signals.
> > >
> > > The non-programmable video DAC consists of a simple resistor ladder that
> > > converts the digital 16-bit RGB signal to VGA. The VGA output is gated by
> > > an active-low data-enable signal.
> > >
> > > The overlay is also combined with the various Apalis Evaluation Board
> > > device trees to provide ready-to-use DTBs.
> > >
> > > Signed-off-by: Leonardo Costa <leonardo.costa@toradex.com>
> > > ---
> > >  arch/arm/boot/dts/nxp/imx/Makefile                 | 21 ++++++
> > >  .../boot/dts/nxp/imx/imx6q-apalis-eval-vga.dtso    | 80 ++++++++++++++++++++++
> >
> > what's difference with
> >
> > https://lore.kernel.org/imx/20261019-colibri-imx6-overlays-v1-5-e4d028727382@toradex.com/T/#u
> >
> > Is it possible share one dtso also?
> >
> > Frank
>
> Hi Frank,
>
> The Apalis iMX6 one needs to set up the connection between the IPU the
> LCD interface (endpoints ipu2_di0_disp0 and vga_display_in), and the
> Colibri iMX6 one uses a DVI connector instead of a VGA one. Most of all,
> the bridge on the Colibri iMX6 doesn't have any control signals, while
> this one on the Apalis iMX6 has an active-low data-enable signal

This make sense to use difference dtso to cover it. Is it use name
imx6q-ipu-di0-vga.dtso, because this dtso have not boards specific part,
which can reuse for other similar hardware? Or we can rename it when reuse
happen.

Frank

> specified on the input endpoint. Because of all of these, the overlay
> needs to be different between these modules.
>
> Best regards,
> Leonardo
