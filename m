Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE1BCA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:58:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27CA210F5EE;
	Wed,  7 Oct 2026 13:58:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PgDeiUji";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011062.outbound.protection.outlook.com
 [40.107.130.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A26210F5EE
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 13:58:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b0mZ7DMO5xPeuO+cWyrvfxJC869YQeV9/dA4+joXExKhir9TQgPPvECZx4QvcH7PlUAJ5A9r2bj/yrz8aDosOspnkBlsGoRz377ZZcLM/OUKdzIkwBBkU8nDOHZvgebNvyfiSRPQItq10i8gUC31zG0mszC9hi1uzhot7r5YpP8dyLKMAmxHkm47Iw/hFufHz6oPHXnXu2CKBHChNrEPV1yPzBhmhi1fVPmhtzuHTVCm47P7V7vXI6yheX9+9sWtdcbB8mqYBo0vQADFswMS04VqS5qXpskY4SmbQ14XAJJH5y63KcdvMcLzhGwJANPQPJuLUKjgF/qmVtVfJ4E/hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9V3db5fReji9umAIytJxndQ4RbtwZVeS5wxSrOevUg=;
 b=mysoM0bHa4L+Uji7i06j9JsDA25od5Ya4xQkBFTOyniSd8MIG5Yzui5s48Avbs2mpy4ETTf891fcB4qdac6FtMYuLrWXk7rGmrszia66nvgct+vN6UnJj8HahJ720Y7/IRmv2fdKXJes3XZNrdNsiWLhvZGKOpCpici4oqUD1GKpbLAGvPGKHHlR4OrdqaR+q5kgTBaT/7lVZx5StzPTNpB0OvrZrlR0BtRV0o74/le3U/DoAfV7KHEfDq8t79IlqpeWZo5D7ohK1hMMWPpIf7Dsh5F4xL1G1TZrHGtyWKB/rl3f1+ZD9nBPU+juHQV6Qhu1nkjjSYqNtzpgtrToAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9V3db5fReji9umAIytJxndQ4RbtwZVeS5wxSrOevUg=;
 b=PgDeiUji6fEjW0oZ5xQtgoXaMOOqCcqx+W+epHJgtC8fNCfThs8MoIxMXJsY7Yc5txjvSYF5OKK1dOB59hX/nWSpkSdOy4Imc5dYblebxKnr+Z3wdxHgjkDwe/loslSDygIrcYeacvZfEk+P0WlWpjgt4vHnfK/FZva2hxLvXSr4q+nhjthxSaz4Ig9DDbeq+TbKbkTEuRgKhfNTCFMiLzlAMd+hl+OWMaYRSnl2XCXzr/iI6s5UQjMIsbc9CW6SYANkYow693IoYdNielnZT0EOPQE+M9ck8jnlufMp63H5ehNq9A7iwp8vc62EzeVQOEkUK3bEYTXIeEDHtOMhMg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by OSKPR04MB11343.eurprd04.prod.outlook.com
 (2603:10a6:e10:95::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 13:57:51 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 13:57:51 +0000
Date: Wed, 7 Oct 2026 16:57:45 +0300
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Conor Dooley <conor@kernel.org>
Cc: Ying Liu <victor.liu@nxp.com>, Frank Li <frank.li@oss.nxp.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Abel Vesa <abelvesa@kernel.org>,
 Peng Fan <peng.fan@nxp.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, linux-clk@vger.kernel.org,
 imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v10 6/9] dt-bindings: clock: nxp,imx95-blk-ctl: Add ldb
 child node
Message-ID: <jr7zy2oxsuzfjrp4d74tl6gxiz5kg3pxl4qgigbbmtzyvjliwp@xaidoy4qvrdh>
References: <20261006-dcif-upstreaming-v10-0-bcfb28de0aae@oss.nxp.com>
 <20261006-dcif-upstreaming-v10-6-bcfb28de0aae@oss.nxp.com>
 <20261007-cb2d638508f306f3385c3799@squawk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007-cb2d638508f306f3385c3799@squawk>
X-ClientProxiedBy: FR0P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::12) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|OSKPR04MB11343:EE_
X-MS-Office365-Filtering-Correlation-Id: 5392795b-a113-4e24-1eae-08df247afa04
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|7416014|23010399003|11063799006|3023799007|10067099003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +YKc/bSxo2TezryxigbomLbg4aUMN1bSw+ukJw8bERx9GpEUiwDZU5tw8MZZVgc0TxyS87gr2O19759zDAjwjO+qOArZQRXmE82VGRr63pmt28JxtljmLtI5M1JxljCrPzdu8Iuaokc4NI0dguj3KH7AykUxF9JVH6CK5ifzS3+nLSoMdAiSI6z6TPEGrnq3wSLrF+XQWnU0QyB2uYHnsFvpGj73fnpNC9eD78A3dDZ1BofGcDL8rsUFiR0t0C5xcn2t7YL9JmKf3XDgPs0z2bEvnTrHEzobppOA2VfVXYSRUN6OARE4RCPzaRSLNwT5Wk3HDjzqNrGSsuT1xwrvp0czNx4RGGr0hx/HFQq/1LnwQ0BSpbUwHvnkPairp1l22lDx5AGoTQlmhr7+CP8QL0ht4NrCkemh5FHLMKWg1LUsNmlMxb4oN6zVToYsDIzzmWFKhJjgidBQ8dqxYHnakWDt+MlZr2cY/VLLp0qDVvVZNkiiE23MVlf6/kiV8ibjaqX4A+r+elR/1/JHi6ppSILwvAuAGBagQzv11bAdnFCaLtIVQgBOjEzAhSdD9QKLUG1/qyTMd9Ww8HC7f/dtGgUCBYxNchYbO2ZBlLABs/jmecI6G1f2yTMQq4m0mxd4eyCg4IK3LxVYw0HqQUvMPqnUwnmogDq/zm/4Y36Ch+g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7416014)(23010399003)(11063799006)(3023799007)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?28LqNc0SJzUGS5BPebcRCn2Tf4eFMLLqgBt9pPK8vXJLLmOXy9VvF8s/oOLN?=
 =?us-ascii?Q?DcLC+FCneF5RAW1ZhVYNu8cU3AcAT7bR1dVti2QPiZrOM2Xr/owpr8rbv3ba?=
 =?us-ascii?Q?uSx/gkPMrXVBBPuJpp5nhNfSkFoRpThREOi//MgGaTHQQqoEzVtjJCzulqu7?=
 =?us-ascii?Q?lsXRKNbP+zjUPctR/XzVuxeyay5WY3IRw4W/uvxd0ng1J3ooTqvPSxOxX5yJ?=
 =?us-ascii?Q?OhOl1WpeQ+3EWXeUY3ihh+u85yYhPWXWa5Jz2/llxzXdmPdRUp6qCz73qiHp?=
 =?us-ascii?Q?HSbuDctyeaK4NZncvTuyoqOwWHsNyjQZxyzkpG3/kEgcN27tq7PlZgM/1Rlm?=
 =?us-ascii?Q?GBi0do1axj7+7nAJJOGYuz2kANQic6KUVrYcRMGmkSh4YSQrI8ZbZsMXdTqd?=
 =?us-ascii?Q?iOsahEaB/5zd7w/88L6XfSQuYqhCv0ZFg3xdXCcO2Eh3RFYo5O4mwUYDDzHu?=
 =?us-ascii?Q?UPhKS4b/I95b3PYA56Nx87o+NIuIkCMJOTd4v/t16+MarxrZLVB2QJcsPbaw?=
 =?us-ascii?Q?Ix/UfuTFEK38yrhRNPDAaEVVY41ITlSLNN/PnDO12jWYk9rbItbp1mqjX/Xj?=
 =?us-ascii?Q?kN4jQ9OFy6JqoAj8ujqZJJ3FBVlZmlcwEC0H0YVPgjjPyMClIC+IkrPWrcKN?=
 =?us-ascii?Q?8D6Ctb0Y50QfwaCtxyajkZkwYVpffaY3Vx2Psb+VMSMpCiii+dhx8+V88Nul?=
 =?us-ascii?Q?/Fe2PtSt93bZv2g4y6dGBEvJfB8gQJY2258FetHFyVci8jM/vmm7zMsxj+Ev?=
 =?us-ascii?Q?AX4k5cIlHgzAD8XRPh4b/gcwjhD0XptnaDHgyCTIAGDLMli2Vz6c7AkCWiOg?=
 =?us-ascii?Q?GumLY4/8EerZLdVOrNQdG7mb/1nMTSP8/r8SyIoA49fFut7pBjrc6HJ0IHgw?=
 =?us-ascii?Q?BB7zhcflYCbsYpChv/3jWTvD6NqcOvNfOer/K5Y85LswZ5lhR+VMacI+H3u5?=
 =?us-ascii?Q?s7TBR7SJ8+9fNZvgTLEq9QN1mICLzRLClkpDvCGU3lhD7gLKrkmxZfNdX96a?=
 =?us-ascii?Q?NCh8F1KBYM/uSMrMJgzXTeYfMDpsAdy7JRkMpMQvyLJdi4ARKu9u/4wpuav0?=
 =?us-ascii?Q?BHSzAz+H0RBWtcXqfNRQJfsrK7t9dKHOxG5U2OV864pYBHgs9qJyVZDYF866?=
 =?us-ascii?Q?8o/2bLT83KpAxOe4w4dmiFBAUwKzI8lwbqGV8hnqS7IhYHjJpRt6DIpLPoIN?=
 =?us-ascii?Q?Dl1zWPRkhw33Ir4IE3UDqFDK9f+IZ7F65VkvxUOPB569LM2ZMlHq61AbFJr/?=
 =?us-ascii?Q?D0gKXrf/62qPq8LnQgiqJAA0tQDBi3yAKR3Xkm9W18VGrsfZ0qk1h7JzOcQT?=
 =?us-ascii?Q?hUcgwwCgkSizzklAYEIJzhLz3SZd0Ui49ITGElV4mlNxdAEXQ3M/VmHvgG3j?=
 =?us-ascii?Q?F5Etpl12Q35RZA39miLuI0oZ0Fcs+gN351uyt7pGlEp3SYjaLikoAF9Rkpdg?=
 =?us-ascii?Q?EoF+QR0JjcGQGYEcnQHvKD0M/5JjtaoW7WNrnUDTl1MtL9N08UTI0K0tohTx?=
 =?us-ascii?Q?6a87/LFwFvMvDYrx6lFT6TQ6BACUawxFF0xEkZ/IZfmm6iyvydzra/A7ZYx3?=
 =?us-ascii?Q?jhpa9vJb7rrb2etO/6AlTYa7Yj/V0nQpwTnhJnL/nLx/+lel9lVkqa/nAsES?=
 =?us-ascii?Q?0zGYw6tGt0MnEP06IsnYB+Y8jvs7VRWpo1CeItzPobsdZkBlZGyLDNaQZSHc?=
 =?us-ascii?Q?gegUxdXRgsPezbk/y81Th7nUPa4T2AhgNMlS5+wbT+CRXSevpTynzjPDmSv8?=
 =?us-ascii?Q?S8kIVF3/ItnelFWLiyrwHTPIEgPXhdQ=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5392795b-a113-4e24-1eae-08df247afa04
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 13:57:51.1038 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKMF7v2D2MSv9sIW0mIJJQaPk7ILghXLL5T8XpCOLdIw7BB0P9gLhFD4ZQjtx/N4nu+9ZeclCZSWLjgDJDD7LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11343
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

Hi Conor,

On Wed, Oct 07, 2026 at 02:12:52PM +0100, Conor Dooley wrote:
> On Tue, Oct 06, 2026 at 12:22:01PM +0000, Laurentiu Palcu wrote:
> > Since the BLK CTL registers, like the LVDS CSR, can be used to control the
> > LVDS Display Bridge controllers, add 'ldb' child node to handle
> > these use cases.
> > 
> > Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> > ---
> >  .../bindings/clock/nxp,imx95-blk-ctl.yaml          | 24 +++++++++++++++++++++-
> >  1 file changed, 23 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> > index fbbf1b3f17904..97fe816a38f94 100644
> > --- a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> > +++ b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> > @@ -51,6 +51,10 @@ patternProperties:
> >      $ref: /schemas/media/fsl,imx95-csi-formatter.yaml#
> >      unevaluatedProperties: false
> >  
> > +  '^ldb@[0-9a-f]+$':
> > +    type: object
> > +    $ref: /schemas/display/bridge/fsl,ldb.yaml#
> 
> The class of device is bridge, why not use that here?

I'm sorry, your question is a bit vague... Are you referring to renaming
the pattern to '^bridge@[0-9a-f]+$'? If yes, I don't have strong
opinions against it. I can do it in the next iteration.

-- 
Thanks,
Laurentiu
