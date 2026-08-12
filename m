Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56EBDC5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEF5C10F01F;
	Wed, 12 Aug 2026 14:18:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wc31T7CM";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011039.outbound.protection.outlook.com
 [40.107.130.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11F5910F01F
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 14:18:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=epKXnQoZSsGSQXx/Br+L5LiQgLl1iYNtXJkTW5+6KfEnWC5+pH/1YwQMXn/gcjZDbtQU4hDQGz/3Z7pv8cvs7LS/fO67NeiaRKKwqOfVxkoEsMz+8f2kUrXzVvrEQiCqOT4RT74YezRxfVy9UjEu/ouQFF3cgk281ZR+ZDZOcDABPS6+LhPjkBE6SIEIMafPVgxWl5lX3y/bHzf05igxYxvYLhxAyEWrQsvTtL5QApXwYfMUquQZoFpPCBfRqQGTbyUtyA5diOo48B9AE0mLtIs0nLQbGdifoBqJtRq+Cjko9j5ZT6CUgobQSAvcLko9P7qJDMTRHDfY4W1zcH8XVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkUqj1o281TE55cK67mtPPpLkAKosx12N5dULxfbYcY=;
 b=pWsgPfaeG/G77HB/UWQ+ElzTV27SdwZBvKibggUPWImjR3biRdb/Xk9AeVzou/Yq8uJXL7VW4c9hXjihsBrtyvgIBwRQyEPp2GjMUtocZcsEkhsD0f2MuhtFeTiO2JNuEyAr6Qag17x5YZF7DivD8DnDZM7uJVlptWAYspbnbH8oJ3DAVAj0MLxTyg+Rvf8R+KmVVN69b2xlY7Z/m70fFUD5cGxW1kJDtda67i1i9bkYGpDqUwu4+rpEGfydrGZuO3/Sb+L2MJzujJe8qdKQeIj4NHySlPzUE3HUNpffGchH1idSJF05AlPdM/lS1mslw0i1VH9ko7rFmDbS67x2oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkUqj1o281TE55cK67mtPPpLkAKosx12N5dULxfbYcY=;
 b=wc31T7CMb4A76pxF7jQ8t3UcCPsqCcRrTsQg6rFHLI/6NUHZlhTqdoQe7lz+pWsbPuWB5+rCKoBYZ1VqPN33ZZ9Qxot6sbAriMNFdiF+S2azmErQ0c25ZfyIJB9t1RN2pOibsp2wHtv47yesjftgW92mIBE2FSWHSghwYRF0ydl433/wIXEMUJLjHt3x619nhrA/tX3Jah+msnGu2YX5DV7kDmn9PXahM/oCwTJVzWzLmawdwChcZBo6V6j9SXt6mZuECr59C2twUH5RHqfbr5GJtGA7i1T3asmCAXP9yyFyfaPueJ9ISRTIG/z2uit20iG2s3wOZNExC1YKwmymJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB8PR04MB6889.eurprd04.prod.outlook.com (2603:10a6:10:11d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 14:18:27 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 14:18:27 +0000
Date: Wed, 12 Aug 2026 09:18:16 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/4] dt-bindings: lcdif: Add endpoint bus-width property
Message-ID: <anyAqL4knY45ALNZ@SMW015318>
References: <20260812132954.148571-1-francesco@dolcini.it>
 <20260812132954.148571-2-francesco@dolcini.it>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812132954.148571-2-francesco@dolcini.it>
X-ClientProxiedBy: SN7PR04CA0073.namprd04.prod.outlook.com
 (2603:10b6:806:121::18) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB8PR04MB6889:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d44a928-c3da-4854-eaab-08def87c938b
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|7416014|376014|366016|1800799024|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: cfS1Zqu5QoW7fcDWO8Tqk5Pke/8+OwJObkL9zwL4Immkqosv2dsXR3gTxIxL6BrLamDHIIpU20IsQrIk9uVfF39LhKbsS/vgzv9vQcYGhCFVutN6m0JuT6HqSgoUTWthmBmalx8XrGbdYsWkBQJesuMIpBaemF66emxen4Adbit5RX2WQmcYBy1rsfpLpamm3Y3phKsThiC1REKldrZ/75tMzfkeiH9AaVHF1BimmZTq0ijglfBQRSCinn5J4f+mX3YT6UIGjv0Jf3+r1S9rnDe6NpJHO0WWiqEjt0kzF5oGuqMDHbHLmL4zA1dCklvvJOXfmVXcwBgMlwfOri970AwrNMYxQYhpxtcT8QPOMMDBTZFTnLdtzT+qSb5euIWFowhumohZllxiJeBftNzizgLVAx5MgmFA6WngjUEBV1FNF27+cRWWv3bRNUCdIrpS/xa4rlRQ2qYC3D9dPeCiRT2PgtXAdObAqED+nNhMGK+RmO06OCsK7lA97zxM1VubM2QEtCh0qhes4See6V+tEBaHhLPxt9kdzntD5G+yngamhIsQ3QYnniNJwdgOwD0YERntTfvOKnsrGQIMPWO0O9vmfFKncFot3S4Kc66WdAEgQ25OCGqFfDESiE50PhkLgdye5AKL5JtErlLODuupI01Tb2D8NZbmZg34lWK30jU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(7416014)(376014)(366016)(1800799024)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XJMZ8fm2AA9WTP7pKjpxqG9Q5IHKlKSKy1iKrme6/mwpDRVRJZOcKx23k7W7?=
 =?us-ascii?Q?bmSdvRFucjEha6atBzYRLG8K7f592xddNBZDF70bLubYoZpe4Dd0e5gJip4Y?=
 =?us-ascii?Q?lArVcqK07hTsyMLX9ixcpLtHzG49vlM6qn9J0GbGl+In6cMAo9mK0mfBkRP6?=
 =?us-ascii?Q?UKmbULwGkiXM1vJTV7SG9nddpc3RIi0OupC5zr23j7MtA0P8FnH418+Nzz1l?=
 =?us-ascii?Q?nTWfz6g6s1aCyzTxgCI1cYM9sgMthHgUgPgwiFli+OsEDtZux7eOTxe1iX+T?=
 =?us-ascii?Q?RE6v3i1Romj2xOWTTx6yA3zd2Alr8IEyYKI5giTPRS13mpHj+sIwicARXXhA?=
 =?us-ascii?Q?zLVc18NCASy53RP847rgj5lhEQ9VRE1sfNl9DoeXaRyr79EcvW8tSjYlHfqW?=
 =?us-ascii?Q?8MQXve4BeSnH/KnVrxpjULicicdrebN/Ep49ZYrYbVu1iHSsyhiLzce1aUr5?=
 =?us-ascii?Q?3VJjKkcPZVWS4SoGl4Zsu111jgUUXUtJNs9U+aAn0BQbJTOqKAqma4pkowWf?=
 =?us-ascii?Q?PUFFzqhqcI+JnNZ5PPQ56l4LKhjNRQxvo+qfxGauDglwab1gi5ICrYTyfTBM?=
 =?us-ascii?Q?ycp1WRh3dQqMS13L6WbOPiCEiMHY14fmkIb/mn+clnTZJlX7SI6VrCaQaMYm?=
 =?us-ascii?Q?Acar3b+4r/6XIq+TXwzsxbf9QJG36uHfz43/mfgrYvasfdzOQ8HzACGqN9fO?=
 =?us-ascii?Q?vuQmvr19dbDycu7B3QnAOeRgi9QIUev3xztTkG1ITXF8vaBYFzdMLtUmPaNH?=
 =?us-ascii?Q?R2/mZCfUO4zdunWTbB5Rfe/ax0IeevEIGVK/rNZT3j1oxlV+MGtkNmrqYLQn?=
 =?us-ascii?Q?DA+ff8k78x2zslHZIH47Sbbx/256nPCmZnyUM33tPC/nqV4TegyS6Q2J5+1I?=
 =?us-ascii?Q?NqCEC38xjGA86CYDChHhc0fe/bpae74bIKIeUiCsWN60mCCQIBjRakEmWKFC?=
 =?us-ascii?Q?s7L4bXs7DGUiPCy/1+MD7GxqMkDTRn26uLOTmyaMTfkcTwE8R1973A+rBRwb?=
 =?us-ascii?Q?05PKOfzFLj533Ll2o0u3HdDRsgDQHcNGp/9/p0Xg521YGUn/XDFCpUJUYjeo?=
 =?us-ascii?Q?USdBywWgWtGMPgOcO3U5qoXAt93viIM3Wqvj/z8uJ3xt02lcdKTjUNclz56C?=
 =?us-ascii?Q?+9U4uLpygutqiCMKJeNArd+T7R/+CIY8+C6PkUUO9012/beVQ+Xun8jBPBNI?=
 =?us-ascii?Q?ZPcT9rw4cYCQx08b8j5OIkpFBSPtWQ9KlRt0M1vQ/1mqKFNpV6Dsa35wjcYn?=
 =?us-ascii?Q?KJ6GFnfavOTVDJ+kXYiPJa9Ql/DgunOm89jgcepNX9kSBX4dB9JJ8Sq2+/q2?=
 =?us-ascii?Q?yrB5INs0DTFUnnhyuO2xQ+RJg5vx9mM4fLrXZP8vs/RDhNw1QQgIYFbZFk4U?=
 =?us-ascii?Q?NbT0EkNNp0eqv/1y1AwKx4slL6aTxpGiAVDOkroMRU+UVDSC9l5LKiwWbpE0?=
 =?us-ascii?Q?yGB6O7eM+Z7ZR+mOmUKDegiyiXbP3A9zzm0ZWfNivGDkgaKX+S0ubMsRFHKH?=
 =?us-ascii?Q?itOqJewLNZxPnquqH18TQ+uMN8KXHx3Qti5Flb0VkpEL/nKKj4GSYoNmiX7f?=
 =?us-ascii?Q?XWEHV+qNCp8MEvJgYoMyd+yJYUpzHQEgen1Ff8gtvFmWBmJ91p3m/EWdfkZn?=
 =?us-ascii?Q?pW4ecvD2B0Be3phHWwQLy59Ec5Fv3VMMQnISPz2OP7B2YFphJcC9SIbdtGDq?=
 =?us-ascii?Q?YcV8LAF4OHPb6TO3jBELuRTyAdg1xTpnZGm7if8fs046RaGkpHmci/Bl31AS?=
 =?us-ascii?Q?eCydMhzGHxiTQ9qXCLRbiulWGBcuuyyXHG+tm/HQkOFwa/3OIbvj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d44a928-c3da-4854-eaab-08def87c938b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 14:18:27.1051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tMHLMwVZFTCOEwef1Q4NE83wlLGZXnRr3vchhJg9lP4mS6UiJIm1bFddoabC++LiAiAMgksERIfd+hr7HKXJRt6Ghw4yQexO+vJhMsNQ0StHYcJLlkphEW76Jp+rMveY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6889
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

On Wed, Aug 12, 2026 at 03:29:49PM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>
> The DPI output of the LCD interface can be configured with a bus width
> of 16, 18, or 24 bits. Introduce a bus-width property to the output
> endpoint, specifying the number of parallel RGB bits connected.
>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> v3: use video-interfaces.yaml
> v2: use the common bus-width property instead of the legacy interface-pix-fmt
> ---
>  Documentation/devicetree/bindings/display/fsl,lcdif.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> index 2dd0411ec651..1f3daf002707 100644
> --- a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> +++ b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> @@ -71,6 +71,15 @@ properties:
>      $ref: /schemas/graph.yaml#/properties/port
>      description: The LCDIF output port
>
> +    properties:
> +      endpoint:
> +        $ref: /schemas/media/video-interfaces.yaml
> +        unevaluatedProperties: false
> +
> +        properties:
> +          bus-width:
> +            enum: [ 16, 18, 24 ]
> +
>    display:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description: phandle to display panel
> --
> 2.47.3
>
>
