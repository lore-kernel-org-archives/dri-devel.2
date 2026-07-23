Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B15C4453A
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 02:20:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3259010EF77;
	Thu, 23 Jul 2026 02:20:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="TCD9EoNO";
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013045.outbound.protection.outlook.com [40.107.159.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12C7B10EF77
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 02:20:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gr11JyJxBWH/h8ecOzmpXp3PJELHWV7j2LaDtpt4Yqpx1qOZSJf5t54p/720/tZYG7Eu0dGtl4vORknK3/vGOTdW5F3NuLD1Lm3ZZfVanbNxkkXRfb3SosQri6OIhwnBKitYyCfHB5GS4ivL2Y0CVgrAlwwjMojXM4Q6cNeb51ZMgTengPmHIZ7wkePw+CVYUiuN6CJyUQ8MJbKaXB20ZWEVwvASeKNu5xAywhUM4ZwQKJrGOViheNYHZPnQgk2cwqvTr6jjX5j9XXHd9FYk71Xo6QIbxYePOjfitKgWzcUnwxk4OkNkG3sTemgbSAXp69wwyNM8bre8CGLP2F1nYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YU6BwJFZstly4GbGZ0/VMSxPAhN86imWQnzINgNvVs4=;
 b=Yj+SDjSr0i5ndvvnE+EtnNDzLM9sOnbPo9yHDyZXGqYXx6K/LspczRNFZZCavMgeQbLuKPlcKXaHwBMa4ZU3NxVndnx5KmmlDOzn5jKRHoncU874yUs93X8nJvxoE4wwi3NiXJNhK/us9fQY275JNpqI4UvRqgRYzemN1pfS0wPzcyg8lhMawwC3Lhmm6Ep/vSSWneFmOMBfRk/kieM/BgcQ94mEvUZrZooI/xSzdF4tQ59A9J4XPcfU1i7rhKvEkhVz2jFJja1ESYvHG9cc1xJmEDK75+HOQWqrJZNBTNazTHJaQhC6RQO8A9BgJa7a8PO5VtYQmOMryJDzd1Yyzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YU6BwJFZstly4GbGZ0/VMSxPAhN86imWQnzINgNvVs4=;
 b=TCD9EoNO6l90LDplG/Bu9hOyhoMOCOy1WXRSCE5SAfjfTyjBNyNZMNTLGDn6PNXKQf+yHFLhfbxGP36UIULLUZG6on4wEXAhQt6fexn8Mp3AJG++SqfF56KRVJEzA7Y9xBBBPcdQbrJY66sumtJwGRxs3zOPQoOsAYt1KwdKxYueQxBfsuVvPxs1wZoEdE+ZxjFIQG9ioLGgF18RFsQE7oBn9PLe+ipwP63YwaB001tuu13LK32/ER38CMrhH2npwxeN+bnfK14ahcjQbXbJzZFEJcCHJhW06hxFlWSnSU5Q4gRbA2J6nOlSMBtnvkfU7YPl43quNe+jDuz2/zb/Lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by PAXPR04MB8442.eurprd04.prod.outlook.com (2603:10a6:102:20b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 02:20:44 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.21.0223.017; Thu, 23 Jul 2026
 02:20:44 +0000
Date: Thu, 23 Jul 2026 10:22:10 +0800
From: Liu Ying <victor.liu@nxp.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Marek Vasut <marex@denx.de>,
 Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Robert Chiras <robert.chiras@nxp.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 3/7] drm/panel: simple: Add waiken WKS101WX001-WCT
 support
Message-ID: <amF60o7yUcqAE24N@raspi>
References: <20260715-dxl_lcdif-v2-0-da797562636e@nxp.com>
 <20260715-dxl_lcdif-v2-3-da797562636e@nxp.com>
 <alnCL7ylMyvGD-ui@raspi> <amAJL9TIcDAK7kbh@SMW015318>
 <amA8iVS4c0exg6pT@raspi> <amA_lUpWkbOFal1y@raspi>
 <amFAXwoM4j2sIENj@SMW015318>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amFAXwoM4j2sIENj@SMW015318>
X-ClientProxiedBy: MA0PR01CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::7) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|PAXPR04MB8442:EE_
X-MS-Office365-Filtering-Correlation-Id: 829f5ec6-adcc-4472-c2c7-08dee860ffe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|19092799006|366016|23010399003|1800799024|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: q2Ik9fO3dC2gst6wVsHJ/ws+jTPTe/nHcUyDViK1MeHB3OvTLD4gXB+Dazoq0xif4b0kpFF85YhrwexjMIMhMWKFjF+5+aa3kuywtv46R7gefTS32nqIDwHQZ1in3B2H4V1+iKSyIaowHB1ddBIgoFhCKqFsqgiMmVfAbP7hAZn9FNeC8JDzyNGrRxHfxWnsqkM3dr2wEMglHqU6CMoQzBTRIBnBPSQTN/DDnXAJZlKgFs55HeASJXAzOVLk2QtXBc4dAEt4XdP6DV+Gfnz0rdeAiDE+disA2ekScZDXb048mO4xBaawX9Xwqccd/7wWIWisXJwXx4D8EYwNstDZ6rob9dkMEF5Ls3f5tEmrpAmTb/mhl1lDt5xLvUhxYX9eXAKH6R+9jtqPJYJKC9za3wbwlzGY2fEUe1A022t6TdpF2uhg+hZ1VgUVFOnYsyFRl9nkIOjJb0CmNmeO+JR8GIFTzJcW+CPFCOt6ivb9VNn/rhXpGgzPzQLbAPlMRV83fjXwjwXHcB3UzN4KjqDW1NUqReICCN3NC6x/i0Lzffjy7aCsPspaQbxPStfm95mAc4xuwPQx0u+sd1wmItdBxKUs47qJvxLy1tqc4yQMTJk/bAKTw0vWnSEOJfTkWBF10jlHk4k/FftW/YKyR7BxggWoiGIpXOMP8Wg/6Wchn3M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(19092799006)(366016)(23010399003)(1800799024)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7V+ky6oFTpgFZcV3mW/zY5IiAWZXn3uGkd35DzNVaI/EHMQzKKGVSflVNa6M?=
 =?us-ascii?Q?tWCzV1178Uxgnir7di5bX1viZ+f44iYPZ8tM41Ya7tKzw3XWJc2ijuxI8g4C?=
 =?us-ascii?Q?mvMa8TqcRwZcCvHfNsRNANVsc7v0i5LHRKqC23qkbnV0Q3gX33UdQrHYNRbn?=
 =?us-ascii?Q?kXM3BIOoomkEMgGItDytwvgdAz88+V5n6p961C6UgA7EvCMoV3qMarsvrof0?=
 =?us-ascii?Q?1cCLLilCAHfOO/u98Ss55oztKI2Q2NECk5GU6shMjpyb7n9Ds6Jxh7il2rK2?=
 =?us-ascii?Q?iYsfTb96trWfHV4R3tW5/QVjCq4F8smOvRYDeFf/OdkNPo5w9A2eHnTRmhpA?=
 =?us-ascii?Q?qrPrD2qK3mfIc53hBxMHiR2/z0mGsYI4QxxJhpqvku1kXvmF0Gtk2/Q14UI6?=
 =?us-ascii?Q?xvVZOqXdD+xHYow4x5fPlPTcpok+e7dcEYIUTr5vmZqtHYSyAQz5yV94dW3n?=
 =?us-ascii?Q?jdemKALvufqLJd9A2mUPg03Gs7ALksgJLLcgJVr2Tu56ZixsBmPSZ90zhKs0?=
 =?us-ascii?Q?RO4EZC3F32Hlq8ObwyccgxVzCAyKEcaZzuLkhzORHEnmQdBJSOs56yETrERK?=
 =?us-ascii?Q?Ls8BSaqXGmp852vjDh3E5xpn3uK2UiGqxbK/o6KUBNahsVwlxlFxhQ8xqp/J?=
 =?us-ascii?Q?MoL9mYwftAqXtCPKsioam0Mn2e5x84z+Fgv4RqJVbs53NpX3koO6YW/f6rJW?=
 =?us-ascii?Q?KYs15yDpABCJtLzmJd481y2YykOdts19pH6cHqkI5Ao4EWazxau27drVN+9s?=
 =?us-ascii?Q?2pZXQWF+az2WmWk+wCSugYRxFOMej6dE1/vmxHXqKYd6K6gsFZqIH/eObB/V?=
 =?us-ascii?Q?deZxK7UfAKGS3NaLp+W1STcYYM0Ol6rxxfMydA5a4SqEKzhwqF11dt1ADBlk?=
 =?us-ascii?Q?BOZw2qfnOSbMntLtMRWJRgi72EPRWKQ0E8qBkneqGS1X2YIHY91KzFbddzE6?=
 =?us-ascii?Q?UksX91wUIez5MBfE3/Z9MOJ9FQur7dEgzquiSnCkBBJBP8XmRgGAZ/nUh4rK?=
 =?us-ascii?Q?cMAXPiYxFmuxj/tjN3FXg7bbQTHzih2HMcVoh5kZz1Z0SWMXNlJg1nkhHIuM?=
 =?us-ascii?Q?MVfzs+ih4WZoU7zFrGRB80SYg9ABPz7ITKzoQmG4EyRgUkr+xNfeCw2JXNQ1?=
 =?us-ascii?Q?EbIjPwc/b3LS/ObmgmurxLoWMCvLi4mXrB1PoLC+s2OHzAWO0xlkJ455fYRI?=
 =?us-ascii?Q?9g8FzK0LM8oJh1Y44DSdOUBlironf1T7S086bbP0++GdN4eL+dINqt+VA+fe?=
 =?us-ascii?Q?n02lZ6IwIaT78XN1hrIlotwZ3i4fDS8pF1xRJjTYH1AHmuMeP9NwBZ+VN8xT?=
 =?us-ascii?Q?pLicmkbY9BljPKpNncHquWsvWNG38UkOPFe0ROTCbykXx0QJ1H1Y78f6I1QB?=
 =?us-ascii?Q?thy9nShTYFfplq1vB9znJyA+GBGuUo9kZPXSLgfbMrzhsf5f7l+kpj1OYnCU?=
 =?us-ascii?Q?k/5ARTEzU51nw1US5kooC7pXh1mFmfl7DnNcHkNEKqwl6inNYluhxVbjucEg?=
 =?us-ascii?Q?CyLMYIY4vMYXulygqLY2XXoFUF9MXebN7dDtHXOb5d9XVXEnqYcPf84r8LX3?=
 =?us-ascii?Q?wz79ZcZOOsyZr7lUrdPD6mIhxNwwZtNVWpLoHA39T9Udw8Q9leWUH8TmHgid?=
 =?us-ascii?Q?nbZ1P83eZGB8KBxewVB1N5J8fIT6jB21PqHAL35ohkJLNEEUE4OehML4ZSGd?=
 =?us-ascii?Q?EPsoVG4Hiys1LsrLt8+tC4bOGlYerZdiWvmgwWnQAK0YzhbQPmrzRK4tSAuK?=
 =?us-ascii?Q?nnediscwfQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 829f5ec6-adcc-4472-c2c7-08dee860ffe5
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 02:20:44.5706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZMJqo4b72JWaa2UwgCOgel/tnit++/DurqhJ58PfLha55PwmYTBsXtifibOj/5QcIpA1BRPYuv2h76DRuDDBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8442
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

On Wed, Jul 22, 2026 at 05:12:47PM -0500, Frank Li wrote:
> On Wed, Jul 22, 2026 at 11:57:09AM +0800, Liu Ying wrote:
> > On Wed, Jul 22, 2026 at 11:44:09AM +0800, Liu Ying wrote:
> > > On Tue, Jul 21, 2026 at 07:05:03PM -0500, Frank Li wrote:
> > > > On Fri, Jul 17, 2026 at 01:48:31PM +0800, Liu Ying wrote:
> > > > > On Wed, Jul 15, 2026 at 02:34:48PM -0400, Frank.Li@oss.nxp.com wrote:
> > > > > > From: Frank Li <Frank.Li@nxp.com>
> > > > > >
> > > > > > Add support for WKS101WX001-WCT panel, which is an industrial-grade
> > > > > > 10.1-inch IPS TFT LCD capacitive touch screen display module.
> > > > > >
> > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > ---
> > > > > > change in v2
> > > > > > - update height to 135 from 136 (sashiko)
> > > > > > ---
> > > > > >  drivers/gpu/drm/panel/panel-simple.c | 31 +++++++++++++++++++++++++++++++
> > > > > >  1 file changed, 31 insertions(+)
> > >
> > > [...]
> > >
> > > > > > +	.connector_type = DRM_MODE_CONNECTOR_DPI,
> > > > >
> > > > > Seems that the panel also supports LVDS input according to the specification,
> > > > > since it mentions 'RGB or LVDS Interface'?
> > > >
> > > > Need hardware rework to use LVDS. Need remove banch of resistors. Should it
> > > > be treat as difference panel by different compatible string? hardware
> > > > actually changed.
> > >
> > > Not sure how to handle that.
> >
> > Wait, you probably may drop this patch, just document the compatible
> > string in panel-simple.yaml and panel-lvds.yaml and use add a fallback
> > compatible string "panel-dpi" or "panel-lvds" in device tree plus a
> > panel-timing node.
> 
> Look like recently prefer add panel-timing informaiton into c code instead
> of put it into dts file. But I am not sure about it. Just check recent's
> log history.

If display timing is specified in panel-simple.c, then you have to specify
the connector_type there too, right?  The problem here is that you don't
know the connector_type, as it could be either LVDS or DPI, and I'd assume
that we don't want two compatible strings - one for LVDS and the other for
DPI.  Although display timing in panel-simple.c avoids duplicated panel-timing
nodes across various potential DT files, I think you have the "good" reason
here to use the panel-timing node + fallback compatible string with one single
panel specific compatible string.

> 
> Add Neil Armstrong for comments.
> 
> Frank
> 
> >
> > --
> > Regards,
> > Liu Ying

-- 
Regards,
Liu Ying
