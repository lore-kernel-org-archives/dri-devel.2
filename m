Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13374FEA82F
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 08:03:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7999E10E80C;
	Wed, 25 Mar 2026 08:03:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="S0aOgxFI";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011006.outbound.protection.outlook.com [40.107.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DCFD10E80C
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 08:03:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S6V8LQLFto9DLEMMTKD1kY9cLjj4HjkcUHdrrqv2GAW6FslxuhIDhMtvV9nhgy0nZxpyJPiTsdUCBEIZ9ackuMDNukdtRTL7fc5ReQqWKDJ4A0Iyg7WIr4CKIY93UuoEot5IkvuRPmxKdePMU+52/zJxrB6qqOaEvrGaNUZwn1iWJVltW+bW7s/MT/znbxoFH2hdF6l/fGyhnN8p7nAGj77n3cL6j6N72O2UH6778QDey2aJ0Lja0t1LRC+zPnODV7g/XjFSARdBfzw2aRxTrfSSXcxQJMTJBcFuJ9F+94zRNcBPbAMwN+47dNLvDFKtxvud5eJdsfeK1xS4kiXrfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bet5riBYZ1EVhfN4D7m02nIU64826vnRqFabdVMlH4Q=;
 b=UxBqtvIIFTFx4DHZSwbFbaaMG0yCjI9EdwWpgG/pnSVbzSJnOgaV7qhI0P1DbsEEnAtlfBDp5Vc3aW6P1t1MQuipftX5VywFVeuTY8Sh9AGmnrHAryeRuScZxXBCwLUAjlIVC7Xq8QDz0YlNI87KGInKAylcJHGmn7tt9deI3t5ZpdU2nNc7rzOSlpQM79yblpv2hOM26OXgwfBKJ+vZuMt61JqBUfN2yVqBnB2KoPB7pOgnBo3apG5FDJEc0eijB4tM+bC4APUoKJGG4o4opxkssYHnSjS/k4yl53fO19ICqRpiXXn8YaYSqoN3qlJ2W7EwCkwazzclB5BV8/gkaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bet5riBYZ1EVhfN4D7m02nIU64826vnRqFabdVMlH4Q=;
 b=S0aOgxFIzz9yGIkyYLWH4DxaBJbMWVYKWxZLZVKSopi73Y5djju46R4M9s5g0Hlli5TO0Qy2s5E9mQsUOIgnjNsKkBOaRxmlSaNzv8qkBUKD5/BOPTj1b0H25v/qYuDFub7/gn1AA8wDcM+mbFaSkLVAdb2T1Q12Qf2yVUVuHDqU0+cb17UAsIzh3ELnWr8GrWqeRQTL6NLR2BAskCPg/ypLUM/utGr566c/bG/ySKqRecu7FjvJcxC4+eglM6RgGwe8qeI8Ex7fHLwKnHr4/elz1fUZCPeAvegysuXY7xS7P5U4mQfKqEoNOGnzLp6POO3Y4J62NfqGvGkLyml3Gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by AM7PR04MB6886.eurprd04.prod.outlook.com (2603:10a6:20b:106::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 08:02:59 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 08:02:59 +0000
Date: Wed, 25 Mar 2026 10:02:54 +0200
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Liu Ying <victor.liu@nxp.com>, Marek Vasut <marex@nabladev.com>, 
 Marco Felsch <m.felsch@pengutronix.de>
Cc: imx@lists.linux.dev, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 dri-devel@lists.freedesktop.org, 
 Frank Li <Frank.Li@nxp.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/9] dt-bindings: display: fsl,ldb: Add i.MX94 LDB
Message-ID: <p7glzm344tiu76zm5aa7qq4lswdcjuqlqel3hl3tr3s2cllltj@i2eyzuux4cj3>
References: <20260304-dcif-upstreaming-v8-0-bec5c047edd4@oss.nxp.com>
 <20260304-dcif-upstreaming-v8-1-bec5c047edd4@oss.nxp.com>
 <b7968f1a-c4bc-4bad-bcf8-407ff2d8db27@nxp.com>
 <dmqbmmpyi3ssvq67iqwbt6ww7tsaik7ifi5dnupmuhep7u5saz@ads5g7ette3y>
 <mx6b5svmvlonil4efuiaxcmtygn7lld3nj7gcxnnauaryt2yed@gohjshakc2g6>
 <40b3d1c8-0cf2-470d-8223-751240061735@nabladev.com>
 <xqy67fmh42k26iagl7wqrh2dbsn7c5fytwbkcksfzagefp327j@s5hg4lpuvy3q>
 <4e75f1d3-29ff-46a2-adb5-78a08f781834@nabladev.com>
 <2fe36f04-97d3-4e99-97e9-7a3ac53cffdb@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fe36f04-97d3-4e99-97e9-7a3ac53cffdb@nxp.com>
X-ClientProxiedBy: AS9PR05CA0336.eurprd05.prod.outlook.com
 (2603:10a6:20b:490::28) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|AM7PR04MB6886:EE_
X-MS-Office365-Filtering-Correlation-Id: 186ee68e-d069-4c36-c8e2-08de8a44ee0a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|7416014|376014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: GkDI5eve26IXDm8i+BqoUr9/r0/z3d4N9/G2mvgpOT5Oi5AwQJ5qEf/OIx+Btv2RvA2WJ6fY3iVwSjeYgS9SNmCepvpnaOM2bpwzYH+H26F1XziJFdd8a3AAG3gjj/62HYfrw12q0xmeLAbaJnfoj1CcaZZbsVmw8yKFzVGTeTY6K025IHuRTJ4z7m/keTkYqUvCfVarsf5Gj2eolk08paWvgrHp1Giegi7EoQlMqV2VGWf19IcfV0DIH/yR2qcu7LdRP/1rEXbh+vPcFmrLXYtgqJegB7LXm8SRitg0/xWDJWdHz7a9ezVLCrti5STcNdYFHTrFf5mhUGfS7oUWXYtDrs1za0Z7ZBXcL9KT4HK0GSFHVErax4hNAPv5dtRnzsI2mkR1/PggFgk5mjo+K7k3VwKVxgYJhP+Og35Kszz26LQpNlsPLk4BqQ5VHVtXBKB421XGGcy1qwxr1oYcj0M+cIfD8ayhQs4XpcUzKww6sFMAwIwr93X9Qsv1tloHvPiW31PVlVvgjJ11zXRpHe2GkcYYsmaXQwkMXkh0VqmOD0xjvaYLCKx3HlniJ0IiCvEd2sT5dRRMxoKBA2oi+FHfw/g+7Ima7+CFDyj1NPKp02m2vNpN06DksThigCQ8agBsD3pmPefTc1BGCF9dqQvcLSqrHamEXJLE4jVfTnj2/YUr6OzdIay2SxTHpL/Di5Z84ta6ybUKxAp1zVflPeTwk5DXiOA/qFeDAVuC2uGoHN16cKK18g4Y6kiDoOq/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB9135.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(7416014)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hFQS/Dk4S7KWJCR7hGPOSVyDyUbxHz6uc6JAvVkFNEN5Vy6C136R7qASgUST?=
 =?us-ascii?Q?S/oRzIulM+XXBA4L54Eo8j8i/i6/CjM9HqmUKE1NuPNxCxTVZd3ynfLxc88X?=
 =?us-ascii?Q?NvWEYAzaqsiK/6P7yABVJ41daW1tQwjbAOxSJ/sm20C4cDMQcoraxlIYi49F?=
 =?us-ascii?Q?9aIKYZzHxht1tO9b8HJ3RXRVAAYYsutBf/ibefj1YPyGnkVwARY/EqYJf4w5?=
 =?us-ascii?Q?YYBcaPbqSXsJxqenC8i/+RCuhHddzrK1RhFiQ2943nI9zvaQL/4G7c0V+yGg?=
 =?us-ascii?Q?zSFV598gjFUbGfrhCV7fFiULGY6ZGcCAlcm3HT2Du0I3KtjIdx3otItRPnMX?=
 =?us-ascii?Q?HFQz5D/moncPVYNPXTxyoab/4qsIHISrkOJmqkTXRKDFmS4fUituuCsoODcx?=
 =?us-ascii?Q?xz/Qzu94YAFLeYLH+woi4VCGxwryyk4WlAd7YOO2u95ur3PIca62xXDOshHc?=
 =?us-ascii?Q?Yg0M/GB10FluBu4CSd31t2B7DXnrwIPGX9UkaE3JBQxAJmSH3cfdBSYwCoWh?=
 =?us-ascii?Q?VjM7gIQOE79X8poMiO33gVn/DrxRWKkP49MmvPDHJZS2mTWoZ4N26QfQW6DQ?=
 =?us-ascii?Q?A7EaGtCIEOpuGdt4XHgaD75+SaaEpcvF2DF/RUSOlguQ7oNOoUyu8zahNVPI?=
 =?us-ascii?Q?xvvNiyqcw4IZtl3gJMtAsRp3wypf1hQIa85vXn4n62EDbEAdOBLOsreFJgsJ?=
 =?us-ascii?Q?E8GjtvlbgGduVDy+D4H21UvKscWUNnb/vL5/j+2dW0l7aHEMFmMuQVt8WwDR?=
 =?us-ascii?Q?uUi7bsFcjkwrl1+mbVQnOoAYTACU7dB2c9z/8bP6nIxu/fv32AZqNwgcQOr+?=
 =?us-ascii?Q?VWSZf5X0h3Tw/LhV5onAZEn7fYzAJpG1ldGO7+TfnZQIDyacPz1jnR8EXv71?=
 =?us-ascii?Q?UBNhmFHoXID5NQDUJRoFipwcOXJv3h61pVImMKZBgOqbSBzKDeCBnuZulYI8?=
 =?us-ascii?Q?GfZDl2nOsF75Y/RJrYglTq5ISZUzOYafh2/c41f/uQeO7WF6Bz5ryFELEYPZ?=
 =?us-ascii?Q?5jDyaHPB0hUYaLotDK5/fFUc0dZ8AnfGsFz99rp3daWLNQ/+Sf2pd/3cf8/y?=
 =?us-ascii?Q?9m1gMlzMjvQbvLqMb1VsmUKkI9hVaBYmosEbHq/mowy2gFUfNwfFwcGwgc1o?=
 =?us-ascii?Q?cvzCOi4ddMUZSy5Of2OEm64YW1OxfSxwjBNWDCdvOdFtZ38okB9+gK+mhWfh?=
 =?us-ascii?Q?aj3ByQMk1NyGKc6ijsAvomcZfL+TrtyP1S6cnb3Poy5R2Kf0MMtAl7cvYVmR?=
 =?us-ascii?Q?btDfrvyhRKdpnsrBNcfCYv+4ovR6BG71+X9qDJ9ToX8gnh885TkJ2aQwtZZ4?=
 =?us-ascii?Q?cIxynR00uD7efF9UvL3P+Sae4EPj6eOOnAet58TPu1KB78EmYzTPRBd50j9I?=
 =?us-ascii?Q?LAavGuWxmbFyeUGap/t9jbGU/Be/zMleZvZk5Z6j6MmJ0dE0dCfsKkrOqab3?=
 =?us-ascii?Q?lwr+8OB7rUQWtmY1wd/a3qbvEPuIY6PrMVpY2h2XPSdFkKQzgXYgCOunWAOo?=
 =?us-ascii?Q?cpL4KCM/OUA75dTnrSX3KxQw8icjOulRfMFKW5pDBIu9p6A5clond0mFfbUt?=
 =?us-ascii?Q?ozZ0JnyAfsZMOxOj8XBz9JZwVGAh7USvqRA2229P2YXz1FKj6sImAjs0pBeB?=
 =?us-ascii?Q?1FzH0oPnuw2VkLFR++YPi2LaSxcmYskFxIn4hs0p9Mb7m9mQaapewAYnevgI?=
 =?us-ascii?Q?jtQuLxhp/N0PaeVsfN2WmRaWQQUn2VgBXdVnGrfmj2iD98ryZ3thPQqRGtz8?=
 =?us-ascii?Q?QbF2GV+cujXZ8AXvx488zk7jXaQ0JRo=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 186ee68e-d069-4c36-c8e2-08de8a44ee0a
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 08:02:59.3196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5KmfmYwqiJ/4hWVhMwRrTA6AizKvw7E6DISwyyVOqRGDBos5Sd/vtjFiMuqnDQy3RC33qX2O7AFn0GSrZk11aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6886
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

On Mon, Mar 23, 2026 at 03:22:35PM +0800, Liu Ying wrote:
> On Sat, Mar 21, 2026 at 03:37:47AM +0100, Marek Vasut wrote:
> > On 3/20/26 9:23 AM, Marco Felsch wrote:
> > 
> > Hello Marco,
> > 
> >>> The LDB driver was always written with parsing 'reg' out of the DT, so
> >>
> >> Not sure what you mean by always.
> > 
> > By always, I mean since the very beginning.
> 
> Marek, your below patch is not accepted(at least for now).  In that patch,
> register offset(s) are directly parsed by calling of_property_read_reg().
> Without that patch, register offset(s) are determined via device data in
> driver according to compatible string.
> 
> [PATCH v3] drm/bridge: fsl-ldb: Parse register offsets from DT
> https://lore.kernel.org/all/20260104213712.128982-1-marek.vasut@mailbox.org/
> 
> [...]
> 
> > 
> >>> encoding the register offsets into the driver was a mistake. The LDB
> >>> controls two registers, which can be comfortably described in DT.
> >>
> >> Sorry but I have to disagree on this. It's no about if it's possible,
> >> it's about if the abstraction is correct and IMHO the LDB is just one
> >> subdevice of the syscon. For i.MX6SX the syscon is the iomuxc-gpr for
> >> the i.MX8M and i.MX9 this is now a blkctrl.
> > 
> > Right, and the "reg" DT property specifies at which offsets are the LDB
> > control registers from the start of that blkctrl. What is the problem
> > with that ?
> 
> The problem is that ...
> 
> > 
> > Look at e.g. imx8mp.dtsi as an example with blkctrl and LDB as a subnode
> > with "reg" DT properties:
> > 
> > 1938                         media_blk_ctrl: blk-ctrl@32ec0000 {
> > 1939                                 compatible = "fsl,imx8mp-media-blk-ctrl",
> > 1940                                              "syscon";
> > ...
> > 2003                                 lvds_bridge: bridge@5c {
> > 2004                                         compatible = "fsl,imx8mp-ldb";
> > 2005                                         reg = <0x5c 0x4>, <0x128 0x4>;
> > 2006                                         reg-names = "ldb", "lvds";
> 
> ... i.MX8MP LVDS bridge node is fine with the reg property, but the property
> is not allowed for i.MX93 LVDS bridge node according to commit[1] while
> commit[2] requires the property for all LVDS bridge nodes.  See the contradict
> here?
> 
> [1] 3feaa4342637 dt-bindings: soc: imx93-media-blk-ctrl: Add PDFC subnode to schema and example
> [2] 8aa2f0ac08d3 dt-bindings: display: bridge: ldb: Add check for reg and reg-names
> 
> To avoid the contradict, how about requiring the reg property only for i.MX6SX
> and i.MX8MP LVDS bridge nodes and making it kind of optional for i.MX93 and
> i.MX94 LVDS bridge nodes?  Overall, in terms of the reg property, I feel the
> LVDS bridge nodes look similar to reg-mux/mmio-mux(See reg-mux.yaml) where
> the property is optional.  BTW, there is a mux-controller node with 'mmio-mux'
> compatible string in i.MX8mq syscon@30340000:
> 
> iomuxc_gpr: syscon@30340000 {
> 	compatible = "fsl,imx8mq-iomuxc-gpr", "syscon", "simple-mfd";
> 	reg = <0x30340000 0x10000>;
> 
> 	mux: mux-controller {
> 		compatible = "mmio-mux";
> 		#mux-control-cells = <1>;
> 		mux-reg-masks = <0x34 0x00000004>; /* MIPI_MUX_SEL */
> 	};
> };
> 
> We never know if HW designer would put a mux-controller next to a LVDS
> bridge under a syscon device like gpr or blk-ctrl in future i.MX SoCs,
> so the optional reg property would buy us some flexibility.
> 
> The below patch is what I propose together with a Fixes tag for commit[2].
> Since commit[2] is not in v6.19 and v7.0-rc5 was just released, it seems
> that we have time to land the proposal fix if it makes sense.  WDYT?

Marek, Marco,

Does Ying's proposed solution sound reasonable? Having the 'reg'
property optional for i.MX93 and i.MX94 platforms seems like  a good
compromise. Can we move forward with this?

> 
> --- a/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
> @@ -28,6 +28,7 @@ properties:
>      const: ldb
>  
>    reg:
> +    minItems: 1
>      maxItems: 2
>  
>    reg-names:
> @@ -68,7 +69,6 @@ required:
>    - compatible
>    - clocks
>    - ports
> -  - reg
>  
>  allOf:
>    - if:
> @@ -83,12 +83,23 @@ allOf:
>          ports:
>            properties:
>              port@2: false
> +
>    - if:
> -      not:
> -        properties:
> -          compatible:
> -            contains:
> -              const: fsl,imx6sx-ldb
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx6sx-ldb
> +              - fsl,imx8mp-ldb
> +    then:
> +      required:
> +        - reg
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,imx8mp-ldb
>      then:
>        required:
>          - reg-names
> 
> -- 
> Regards,
> Liu Ying

-- 
Thanks,
Laurentiu
