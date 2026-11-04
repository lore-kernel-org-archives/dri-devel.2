Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37E3606EE80
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 20:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ktGzyRNs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E0A010FECE;
	Wed,  4 Nov 2026 20:05:21 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013071.outbound.protection.outlook.com
 [52.101.83.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D22BC10FECE
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 20:05:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SFGKy8NktD3NMUkG5MCCQASGgRp8L3yNN8BPmRq1kKKTbb+gQRBNYclm8rYBRXkmc3slK0+3ynTtejFZ197sR2pxIKgzEspua6yovIGN4YBpMJMJmxaUoEJmU5hwKsEJK1xVwLLFxyZHFm5qiH84pYvQ/KABMvtbbxXmX6vtGneb+gx/rXI+8WW2C9GyE+MT4JzgYwlhfGjEqrgSKyAqEZF5Ln4vSv2VcfP/G5d2TlGwenSMsmdk+1fS05xSjgmunVA356SYhB32pAizfPViXvfa2RoyVp2OGXCFo8nHel5Dt76wCULFWofhzXPNTxeImx4eN+7MtTutZ7k6mRCveA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhoy7algb4bgf3CRm8fGHl7yMuSBr3uw1avh3u51pgM=;
 b=mxZvzdqljAFC7wpdv3mD03JkYCyp8ehRjpQ7PPsmAZ3aMsNCGIHLKi8VwaB81wDOl0FIcyqfvKChBaxOU4tMQ+JNm3z+qZlEUfHGLMPaqM843tDS28lhZcHl6WkX0tTW8MXqjatyKwpXpV8ukIcKc2ufq3FkBw8/yO3SH/va2B7f+UHkjHE6lLfECkkP9/CNe4HljXp1AzVlyd1ssdDI3E50fPJKG+Lk11RSORrKPKJsykQ3J9DWCtY/MuQCE9IebaCudLDnE0RdiAMpcAHouOC+Lbp07uxEJI6R5KmysAFNplp00KaugsEDO6FPA41NXQQmThC5xdGpf0kbsgMUFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhoy7algb4bgf3CRm8fGHl7yMuSBr3uw1avh3u51pgM=;
 b=ktGzyRNsJ1X6e4CisJl6uIc8hJKUZokFH4nUrmrtoFu0IvWdxT85VhWg5z/Y7MgvDYZ1gzC+DjP/n/glsCnztniwfK9bvyxWArT2eyh46chTnsfGHRSpuKY34H29s1fnJiLRUgvfWFyGP4dFS/s5aWh/2QTDpxDzmd9d3HNOi5J+BZKyMhErG8laz/8FAVw1UyKfGDm+hgJHpP3H3ZCLOr3qFncGzj6yBU9ZT1QL4NV/lAtm8yKy/PnxVn345abMNfuHYCO2qtHuLHEp2c6b0dfrBdz0V6amf/4oTaYmXFVX8OruHgq15BgTxef5WQE/ozL2pOOY+HIjNyuZp22Kxw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DU4PR04MB10484.eurprd04.prod.outlook.com (2603:10a6:10:564::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 20:05:11 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 20:05:09 +0000
Date: Wed, 4 Nov 2026 14:05:02 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: p.zabel@pengutronix.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev, luca.ceresoli@bootlin.com
Subject: Re: [PATCH] dt-bindings: display: imx: Document fsl,pcr
Message-ID: <auuP7o2cW1B7XgI0@SMW015318>
References: <20261103224830.377009-1-festevam@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103224830.377009-1-festevam@gmail.com>
X-ClientProxiedBy: DS1PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:8:452::17) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DU4PR04MB10484:EE_
X-MS-Office365-Filtering-Correlation-Id: a34b985e-3148-4b40-fb63-08df3aaeed7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|19092799006|11063799006|56012099006|261021121427099003|261009223027099003|261028144727099003|261022105027099003|261022075727099003|261102123227099003|261026140227099003|261026121527099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: pBMcUAwJ5OmOXnZlRnedaaJo0e49Mqt512WBjqLUiTbt/r88Wsf/gn4inl0NKwH4cO5pSDBchg+Rmv8us//1JWy8htkXOyglLB350PjuOBsA2v5/X3CoxWIDcgc3GL68tWUcYRhOn1TPNkSaHGZonGBoNSH3igg0y+xx9CVnzVv8SpNMQmnGvrzmhKRDS9FY6kDnts84VhPrcmn9dpRVxStAUU+6LhpJoZzhQAgLynxDKsNjaJzxOSTKQRoT9YfaBHQpRZSceQlOgbWs3qx+LXztVMbxz5l6v6CJ4ZGaEfnc50tbYoJTrwJAeMPKpgAm4enUzXaG9ITN59ZEOwNzHpfC8gwBrCIKLgRXnpd7gc3pcPECMd3jxHg7ljiiQf9Me3QfvZ1WYav5JGqMQgjFDvzz7TwQjikr5HNGIf8/d8KToLsy8trZM9xqpNv2rMJPbX6hW3qxzDhrJ1I8l5bMXj3gm8IeGbH6hoDmXqWHa96udUYnHVOP5w7kKopj+1lObk5Xejs6DUTDwzwa3XLu31UbGNMF8GtXunBywCIT+s15rq39mKA7oDj/7KDkFs2IbEdJyfclY6FiCdulbgBaw8DLJ/0Iu6VKLr4neeCO+6s3++duLFpmfObZoFcJrOwiv7AxzT08cLEt1ABYZRW0TbdBmTwMas5DZ9OGyv6Enj0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI3PR04MB12438.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(19092799006)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261028144727099003)(261022105027099003)(261022075727099003)(261102123227099003)(261026140227099003)(261026121527099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YU1Ej8AWvW414mdw+zalsL4wEp2ss1Z69rlJ6qvG/+ydTE7g3BYilWwDON7w?=
 =?us-ascii?Q?wuvU27orddLUqheAdz3lrMnv15VF+Fmh43wNfgBjDCr/DMxpNL9vMihISuFt?=
 =?us-ascii?Q?pdn4156DPCOROIJq5NHrnknDMvrauLtgct7I0n9jbkGQIlKrc8QFejAZiS9b?=
 =?us-ascii?Q?qKmdkrbuRyEB9Oj0cA+W+OfQHWI6yUYQVc191sYghd+uQjRLOg4f36oQtgPf?=
 =?us-ascii?Q?vKiC6Kdqlhb+z7bvfrA+LQJ5XjmdWU+LAfbY6yKZMt5udjNY92roH0LintlY?=
 =?us-ascii?Q?Cdnots4gCh8o7965g/B0RwV7sTDzZx/4R/TddNz6NrCJbzjhqSZnoq+dcvWQ?=
 =?us-ascii?Q?MsPJyW0z8Odu6A9q4qF8d+MKZf62Wk3cpk7yFnwGNwdemS8JHD5FYxLbbRka?=
 =?us-ascii?Q?zKkf9sPwZ1Y4HWXowH9ClMJJv8Jf6NrzxtoUQ+QuG/Do6mxm8pWKYaRLAwwM?=
 =?us-ascii?Q?sC1Z2at66wvoJQ/RcRFexuIgnOM/bjuy/F+DtAbtW4bBJxxmDJXXiHZDSfbZ?=
 =?us-ascii?Q?u2D266VP9RUd/c39mE5NrVTG0RQg1133HJ83mj360Watee3wJvcvJDeYWNPe?=
 =?us-ascii?Q?IIgk0Jmxnd6T7wZOBD6XHHMT9wwXu+r0surl3ZG+iKRIgZWsC/FRQObdIoJC?=
 =?us-ascii?Q?ayAQZ0UR7VLvYlqrqRQmi8zXCJOsRLqka5dPYupI7j1gy5J0zwtT5ibC8RLD?=
 =?us-ascii?Q?rFh1tI20U3LcdwQHEJbeG2YL/of8bldVgil3Q8nSks6l+2QKN2261N8DIKvM?=
 =?us-ascii?Q?2nRBUyOp7PKxI9vk43+pf20+1QLKLL29XjTaMAJJZ2PzPqb4fgV2bHPQAr7B?=
 =?us-ascii?Q?yyX059OTKZ47yPORXEhrwfJLT/X8hTS49AktRoi63lFbxXcR6UnP1Q2m+poT?=
 =?us-ascii?Q?LHqe4KFhfPnRGLs5c/qUgpH2L+GufKfX/tPsvZyRz3klIkoWc3FU5jiUQFSV?=
 =?us-ascii?Q?bUi2sLIrRHqm8AHvfwRvBGF/5bWCEY0fXBhQ7DOU0xK6QJbeghzrWtQaKBNR?=
 =?us-ascii?Q?SvL3tcf9BFvNraFMKci7yHgOXHLVx+nG8lFG1dppPDNpWp5BemLq7juQPSA9?=
 =?us-ascii?Q?Q6jifulTAmP9zOLm68IwYjbhyhCCG0so48HqCYmuk/qax7UK3vQeDkpeu65n?=
 =?us-ascii?Q?76OGoZKaFAwoCGLjJVG4hcEmDzp/6i9pJnU1Ashdv/9zvopSjg8Mq5YVieiM?=
 =?us-ascii?Q?rUjdN/qtz5Y16Smkgp/VrtN4dVueQwMMixIR7NCTXGlQSrmgiztrjZ45MdQd?=
 =?us-ascii?Q?dof9gulEbUUXisMCrAjH37zZECIdjnG/njRknyZeHy9AH1Tf6X+g4EAhsw6d?=
 =?us-ascii?Q?8p2IdP5ScGooxliyvN7bcFJdvwiI2o3Ct/hW0Kx5JAqKxTapSsHvo1yp9BYP?=
 =?us-ascii?Q?jq9c5ZwY+d3c39sOfBOHzkYQXOSuILu5pa1Rqv1Rk92Dqr8AAKRjlxoDJGze?=
 =?us-ascii?Q?kQOUsBZEfR0L9UVGFBJvtEeg0CJOZBtq0YPbhz25sI0PLllhJnV5hSNuWBvl?=
 =?us-ascii?Q?24yVNohN82m3/3EPabsC9xuMXy8bVkaNhjVjLWlKZeal+bt/rNQCvsrhAnZ7?=
 =?us-ascii?Q?XmbMVS4RsK1jGipXzFNRKTs0KGOe8+pWo6JkJzK2pOiJAwrdYJRXhspmtC3U?=
 =?us-ascii?Q?GBwygisALjKt43NSksNHNFbhtFQT/GT57rBQkZvtKByY1VgwsbyerxBmRGoE?=
 =?us-ascii?Q?11AVjnuUTSdl2dYKJ7PWzXtL5htl4Y4TJ8SK+nl84tMkb2Psd0SUNapEIuM6?=
 =?us-ascii?Q?1OZref6IpAWPvuaamT8WBAfIj41zXirTXrZv7d/LIFCWVbCcnYEA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a34b985e-3148-4b40-fb63-08df3aaeed7c
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 20:05:09.5281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3cPa0/okXrS4fqvRZjEhqOEFaNFpS14kpgsEHWclZICn/XaAeKz+Dbf1wO3ryBjv0DF+NVDkp3ZulevGFgkHcP6ovDqouUtBSv6XxftfzQOTzvuz1xTArLIrIAl+qPr3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10484
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

On Tue, Nov 03, 2026 at 07:48:30PM -0300, Fabio Estevam wrote:
> Some i.MX25 and i.MX27 devicetree display nodes contain fsl,pcr, but
> this property is not documented. As a result, dt-core.yaml reports
> its raw bytes as an invalid property:
>
> imx27-phytec-phycard-s-rdk.dtb: display: fsl,pcr: b'\xf0\xc8\x80\x80' is
> not of type 'object', 'integer', 'array', 'boolean', 'null'
>
> Document fsl,pcr.
>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
> With this change applied, imx_v4_v5_defconfig builds with zero dt-schema
> warnings.
>
>  .../devicetree/bindings/display/imx/fsl,imx-lcdc.yaml       | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/imx/fsl,imx-lcdc.yaml b/Documentation/devicetree/bindings/display/imx/fsl,imx-lcdc.yaml
> index 84610b5690c4..f1931436a4d8 100644
> --- a/Documentation/devicetree/bindings/display/imx/fsl,imx-lcdc.yaml
> +++ b/Documentation/devicetree/bindings/display/imx/fsl,imx-lcdc.yaml
> @@ -65,6 +65,12 @@ properties:
>      description:
>        LCDC Sharp Configuration Register value.
>
> +  fsl,pcr:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      LCDC Panel Configuration Register value used in the display node
> +      referenced by the display property.
> +

Can you restict only allow for imx25 and imx27?

Frank
>  allOf:
>    - if:
>        properties:
> --
> 2.43.0
>
>
