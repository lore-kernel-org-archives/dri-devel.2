Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6579FFED3CC
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 14:38:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4EDE10F5E0;
	Fri, 24 Apr 2026 14:38:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KJjGXdtb";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010062.outbound.protection.outlook.com [52.101.69.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87DF910F5E0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 14:38:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iAg4eNtuRTDBMbkIZ7XkdyZp5vL4gLo1TARBFaqBC0Hb1aI36QPXvVPS+t4W0j0qiJ98MDQfaFF/XSYMxUUdZqD4gsdp/jmMz4BghrgUpteooYDggcxkW2V0kI6yLkows05rSdMCMp2y6rVSmReTZ2n6E+bD907lFt7Af1o6NFGDQltUIB20JDmtOocua6eq6iRRA9STly+wmIlESuJfDg2eb5B3ziOdox683uHghjw+nsGAUpscU61eQAfwRrHIOBVAr3BtQDuQMcsF/9RhC7EZ5zjaFuirPlXcRmwK79DpZG6+dWar3B+YMEWumXHjsv6vmC5XAIaQR6FXTRDUsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Wce7oXt3Tetx9qhsgwWAT4Y7786S1m3Y5hAHhmmPEw=;
 b=wdomfuyrh0ZGr7B+nMA9b7pgXVI2NgrGxvGdU5rVMxiQs117hCRG0ldLeJ1xnf6aNVdD4ZxxUXkBEU5XxbrPpdHmg/EDwwXyfsjfRCR87tfE555kVY9BTB1XtB/ogdIN7egmbqj1J9KZHwy9l0j9doQ/uEe+nKraAdOcBOVpgt8mvllEOxXS7xx8ydkmqFd0LFXsrcmaPrbJVqGrpRFOb7ci71OX13GnYkcVNRW5c9ls83OB/PQZnNdCD9xAdevLAfNFZdBIuAUrebjH7le+hdaFb/6R+NY5trRJghmAO0WV7nOjwfkfptJaorJM9szoO/O8xZS/YUgpnRLATBYHew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Wce7oXt3Tetx9qhsgwWAT4Y7786S1m3Y5hAHhmmPEw=;
 b=KJjGXdtb+XYAFVTyJ/8kTGrj7pgoCPgtylgcvdOuYU46nMOb++6B+DldN/InbSxYTA+4oWpJZ01gN/5a3MRZ2ewBSGx7+k+1nfrU8PX7sRWtxLusot/uaeGwvobD/sHPUUKCwGIQ7Iz4lvJtBWVpbaDiC6oTJEOrnYf3uVHuUVzOe4ZqRgD2ZYh54D8NJqfPHfsbFDLRcB5xsBlK4uZCElpbxwq6cz6GrhyMj1+dBoLrsWpJvjQ1d1J9cTM2mxZzeSTdmkK3JYkHYmzTmZZq8FfB4gWZTzDmSXr7gRi0i/GInDuCF4+KwOF9picmqvi48Mi8Qmlkg2DsyxHN1Js1KQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by AS8PR04MB8468.eurprd04.prod.outlook.com (2603:10a6:20b:34b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 14:37:57 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2%5]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 14:37:56 +0000
Date: Fri, 24 Apr 2026 17:37:51 +0300
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 dri-devel@lists.freedesktop.org, Jonas Karlman <jonas@kwiboo.se>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Simona Vetter <simona@ffwll.ch>, 
 linux-arm-kernel@lists.infradead.org, Maxime Ripard <mripard@kernel.org>,
 imx@lists.linux.dev, linux@ew.tq-group.com, devicetree@vger.kernel.org,
 linux-phy@lists.infradead.org, 
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Robert Foss <rfoss@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ying Liu <victor.liu@nxp.com>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 David Airlie <airlied@gmail.com>, Andrzej Hajda <andrzej.hajda@intel.com>
Subject: Re: [PATCH v22 3/8] dt-bindings: display: bridge: Add Cadence MHDP8501
Message-ID: <udpesa5i2fdi6rwrtuwut5zsahy7gvsla4p3ujqml6zl3mvayz@fd4e5tddzuv5>
References: <20260424-dcss-hdmi-upstreaming-v22-0-30a28f89298d@oss.nxp.com>
 <20260424-dcss-hdmi-upstreaming-v22-3-30a28f89298d@oss.nxp.com>
 <177703391401.3671402.9330071570952735700.robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177703391401.3671402.9330071570952735700.robh@kernel.org>
X-ClientProxiedBy: FR4P281CA0193.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::17) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|AS8PR04MB8468:EE_
X-MS-Office365-Filtering-Correlation-Id: 4677cb27-fa06-4d5f-e7cb-08dea20f133b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|19092799006|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: jDeL+jvKqhx43BTMF4r8QR8eHVwLA0fgPaln8GY315K5Rs7/Z3+txTZomT3j8cutViKxrOIrAflspn+fbt4FlIYyR0vgqsleRjdML1hFbseM0ABiA71ChQBOTS/FCU7u0mANX/gGdnSidk7T73SoiuhsQOSV3zD4E8MVyPjJT40HVo1TwFI1wz40yRl+J4snCoY78Wpeh86hsLyOkHS5MX+dXFaInnR8p3Vi+Mdr0+85NMuuCb+fQ0yfKFQaJkcCOFw+aGhtUHwkdAa/MG4PS/YaLVYgRG8L6Fh4Tcg/UHkMGMRuQDMp3UAnv6TA5WlsF9TDS5Mu78S9rOgJOasU9smkhqzPCy2elMTnAV8K+AuYC5beOnxFYlAW7JdT9B2kz0MDz1oWZdknpD/vMRfRKFFQly9mIPmppGmGcDEAdMgfaa9e7WRlN2dHslyOr2lV2FHVfWHCKbV6STG/bRZx3pp6+OsEi0rB67WX/I8O8talc6dT5QYwqLP8YMFglpNZPWDLv0FlMN56J2TG7GUf1UzrrI70EBE2qE9kIrhuGLQLHG0EzsVBnojHwF4lXB3xGQK+MDAsJ2ylkUYAubDsgMAVYRcZMvKW6At5wRghup0ZBKghAoq2LXSQ6sNBm5heY0uUra68eIrU1m4HX1s1yPcn6qLU0JiinHyZjnFcHq82n1wAsy1Dg/6Sl/TZp5y5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB9135.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QNnzqCInUp55xnHYbYV9/ePG6yFtlUh3c9Hg4HtkEWghuxbNL/mAv2gPmoZx?=
 =?us-ascii?Q?CyJ1+IbnZLxhyDmWRLKGySZdvOdpyWNvquR+PCCaVdxgIVhUM4Im2KVc+/gC?=
 =?us-ascii?Q?CdcRw5wm90cbC21qE6oeuT5lGvUPAZ+czGSRuXPGHyatgKS4g5gdkaxaVuvQ?=
 =?us-ascii?Q?gKTtzkXYVddjHaBjLb2XHY6BA/4RIV/qIQSdd3SmaCjrvUGvsHyA+GHc3SIu?=
 =?us-ascii?Q?OaV8tApnvRCmCdfN25kAfzUR4TddjD77eekDHz0aIpQYk6hZFkutl/Qms7v2?=
 =?us-ascii?Q?s+Yglz2DCGLI+YyYK0gzRi/R9qDng4M4pfU9s5vN5XEDEQ7673gOsEK9ieSa?=
 =?us-ascii?Q?ol/x2suXfZwWPHiLGDMwsKiFrxADfMUffNHIPoobvlGhvsP59/WJxT+NsHyB?=
 =?us-ascii?Q?vriVKQ7Yj7fdn6GbGkFR0a4P9XME7R4ABCVk/5uA0glYRpH/g4e/u/RoVst+?=
 =?us-ascii?Q?pQ4yHiTB2nQND5nCtsWpkwI1F3hkfA3rTzz12MOGehdoniRrUJfivZC93r2F?=
 =?us-ascii?Q?WZft/tX2TI6txxb7LuPu9bz722M/sdiYLHozddPA4Dt3QItKyPUpC3brGOQp?=
 =?us-ascii?Q?HpdPWkaCKMsW7Cd5rNXnjFoCf8yM67rkP0COYwdOD6iAOa8629plMmLlF4Kn?=
 =?us-ascii?Q?RseqNv47CSpwKY0k7JizOyIg38ztthj226RkRgaqyybszEamlcSoRjEhh2Fh?=
 =?us-ascii?Q?H6Ly+10+wjTUB/5Q6Tf68EvNYENaBoey0aPMlOYOaygFJbUrm7ucRjl5j2BK?=
 =?us-ascii?Q?TAuloszo/hImxS3GuZAwQRfNN8UcefHC0wrX3PxjLmK+NJPFq+45lTuCR1YR?=
 =?us-ascii?Q?iceeLjGG/kQVM7/+Gp0ZK14BtJ8ZNxvd20ZlI5AA2zAIAkTft2JsBQ3rhTlf?=
 =?us-ascii?Q?i4GMZCgGmdNEkh1/3aVsa6oNmBNUhJ3vx3O3QtWu2lc55sGPShH7pZ5NzGnz?=
 =?us-ascii?Q?WopIyj6X8zKWr2z/3ER1ugjIh6ce4ALUDvBUxYqwvlgfm8ibasB9d0GZBZl/?=
 =?us-ascii?Q?0KxCTxhlRjAAGGhmYPo9VZB5i8G27LryHlxrRVF+GkopfJyztvvdnSztiD/V?=
 =?us-ascii?Q?Ynh+cjWKEbOFwM9sjSfmYl+M+IkuYAhgItCxg/gnCdypIJRNKzTl/BIUQwdq?=
 =?us-ascii?Q?2Id4NXCHxAdHzoJX2OYM4ZGR/nTT4OgEi4BA7sAsvwGUY17ZXgV3jrM6n7oC?=
 =?us-ascii?Q?USO2+bEaZTkO4cKKTtF2FKCxgAbh/bJttZHYo+veIY4nYyhkZUpHtYz7AJJV?=
 =?us-ascii?Q?L2xOvnA0M1sW1Gxdgl0eBsKBH33qecJhRxZDOImZtvqi97+sG9gNPu16oFCM?=
 =?us-ascii?Q?L3JO20fd9nOydsbamwf9frQ5YwWxaI0rmSNNrhbT3oqlcXUnffUuF0ejSSNf?=
 =?us-ascii?Q?ek7klSbHtSpAREeD84NM81PUFcj3idRFJNIQdUdhmGP5YDRSKcg4pRFv/+U9?=
 =?us-ascii?Q?SoO0qE7LXWArQJxzZweeZk579LHFsJvO5gTfykgjqFohOEBmS4sBlcrpBugD?=
 =?us-ascii?Q?JdcNvz+KB0F+Mq0z26InwC6BzeYBKOSPsZNaDO6QSJnN4OkhSNWq99bNhqwZ?=
 =?us-ascii?Q?MriURxZI7iVCR0Bv20zxOFjY0UydyjtQNXC0IxC/Zeuc/7z9u7bZF4PZScqY?=
 =?us-ascii?Q?9iNWzX00npAfc+n07twV/PmZyPWpi7+vCMgvvC4lS8idY9F+ShQcTwaKF2OY?=
 =?us-ascii?Q?BVMYyAsCBLnehpAZn5BOhkKbPlGUpNy7dWndWVoKqvVYXX6BnQrhi4HUyiSf?=
 =?us-ascii?Q?KWr1we5HEaFQPWBp3EYdAYvf90PwrHk=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4677cb27-fa06-4d5f-e7cb-08dea20f133b
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 14:37:56.7502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oH5SJk3PxiqAaxPlvrqDHaU6P4rUoQscsNZbA9MO94OWqrX49yrS7G2LLCqLPLYTXQ6YBXoIFv1v+UFMcST+0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8468
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

On Fri, Apr 24, 2026 at 07:31:54AM -0500, Rob Herring (Arm) wrote:
> 
> On Fri, 24 Apr 2026 11:07:16 +0000, Laurentiu Palcu wrote:
> > From: Sandor Yu <Sandor.yu@nxp.com>
> > 
> > Add bindings for Cadence MHDP8501 DisplayPort/HDMI bridge.
> > 
> > Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> > Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> > ---
> >  .../bindings/display/bridge/cdns,mhdp8501.yaml     | 135 +++++++++++++++++++++
> >  1 file changed, 135 insertions(+)
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml: Unresolvable reference: /schemas/phy/fsl,imx8mq-hdptx-phy.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.example.dtb: display-bridge@32c00000 (fsl,imx8mq-mhdp8501): phy: False schema does not allow {'compatible': ['fsl,imx8mq-hdptx-phy'], '#phy-cells': 0, 'clocks': [[4294967295], [4294967295, 248]], 'clock-names': ['ref', 'apb'], 'phandle': 2}
> 	from schema $id: http://devicetree.org/schemas/display/bridge/cdns,mhdp8501.yaml
> Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.example.dtb: /example-0/display-bridge@32c00000/phy: failed to match any schema with compatible: ['fsl,imx8mq-hdptx-phy']
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.kernel.org/project/devicetree/patch/20260424-dcss-hdmi-upstreaming-v22-3-30a28f89298d@oss.nxp.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
>

It appears the problem is triggered by the fact that the dt-binding
patch adding fsl,imx8mq-hdptx-phy.yaml comes later than this patch... I
only tested with dt_binding_check after all patches were applied. :/
I'll reorder the patches in the next version.

-- 
Thanks,
Laurentiu
