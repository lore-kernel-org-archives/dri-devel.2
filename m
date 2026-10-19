Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A8A606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 19:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=VV6lrCak
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76C8410EAF2;
	Mon, 19 Oct 2026 19:42:55 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010029.outbound.protection.outlook.com [52.101.84.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20A1C10EAF2
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 19:42:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=teeCYqEPBLIelqiL6qy+65iSeRXvDtKulTh81IRDrq9MsMrRzb/fz6gKsQy+j+aDr/7S1F7UiYQs9osje8rOV7zybGeRWajDp4wha6DxutXSAI1Yb9OIjHPTOs8sfgaMu8Ripwiqeowg3dRPC4UuEI0E4gYMMFG5Ju/aAk8HpCbK5LLMyEFQd1lP4FIYcQ7xIMM7mHh7Ke7/fRCsqXjZZodblLtpGdbK5yhEaBNOShfXak4qC+u+KKvadfeXl35UbbaW5kNZZpxsn7Gf9KLl1dGHwc9IwtMOl/lHYuTodHtXBdTkIt2wQmxYfKWkCylConpcia433BtN82vb5HrVjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8dYGK21sRrzBvhf89J2cAMbSRFJaLP0jDonotOhdflw=;
 b=ElrwKrrmZZXU+x2DfQVIU0rCI3jTktIXuq2OP5hZyxS2leUZCsyjpOkSAdIYqkcDecVSif2n6OraiaXG0FpFomGeDN99mczdiOzDJSMSgmehEKcVu5stIQc0hdjLzD6CtAoNxfj0fyNsKtN13nhkn7L+eG4PDmD6Z/urSYQl5l3CvSV537rFlyrP51XSU0WHe6UriY2j6vgZ09f79qUdwDqlY4ZY/ViYZ+8bafF01Y5ybKYWBIyn7UYZR4QQ1AzO2V/3hhSyoXOGJkzK7ohwywVjJ16U4zQKaQqKaUEjiBVcFaHmE+57dtQRB904Rk39az7EnY5Nmgh7LDiNBfBUKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dYGK21sRrzBvhf89J2cAMbSRFJaLP0jDonotOhdflw=;
 b=VV6lrCak6aN9wQ5pg8aYF5sUNwti7fnoKMHzGzHDMD8vGNWbCeew+r5tohAgUH4D5ilePdxg2vjYUYJJnR4CPD6DK/aYonXR0HzKpEO5Z01QqMX+eO0xhw6D/Bsq8eDuGRRBm3K8QryEm/0phP3icJFXZgnetJIJY7aQPNTQMYAR6ZkHHaynZaVzIWLKYQ5knQtbaTtxrBwgpeyGqftm6mPEDpmGbSCZUOtLEiWdSW6N8RSIwMxr2idho6gBn69qJWj8S49dAQ/1VHwFeQM+xB880rPTXe8emW2NlWUr6+0EQlYNI+BWBEYNjtiL89+4JLmG6RAerv/lIWfHhXqDTA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by WA4PR04MB588810.eurprd04.prod.outlook.com (2603:10a6:1d0:108::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 19:42:44 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 19:42:44 +0000
Date: Mon, 19 Oct 2026 14:42:31 -0500
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
Subject: Re: [PATCH v2 1/3] dt-bindings: display: bridge: simple: Add
 data-enable-active to dumb-vga-dac
Message-ID: <atZyp2wYXNW52NYu@SMW015318>
References: <20261019-v2-apalis-imx6-enable-vga-v2-0-ef6a3a780472@toradex.com>
 <20261019-v2-apalis-imx6-enable-vga-v2-1-ef6a3a780472@toradex.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019-v2-apalis-imx6-enable-vga-v2-1-ef6a3a780472@toradex.com>
X-ClientProxiedBy: DS1PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:8:457::18) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|WA4PR04MB588810:EE_
X-MS-Office365-Filtering-Correlation-Id: 85d5bf57-334f-43a5-afaa-08df2e1924e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|19092799006|1800799024|23010399003|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: tadK19oeqvnD/8nKjEJshDKq8u4Gx7YtXWInEaW892foD2RVwnYLHRxv5LmuxshZ1zxgk6e5oY/3+zTLGtk4D6/jlmglkFMGt8S/KA33npKTo8t6JDqgE+I9PIazVN5+mf2F/jL//PeCMBMHZPYV0fj94B5rby0F34HtLEyQuIEBXDBEozFA0k6PIsplrSM2dGqx1ir3QDgDSP4E0PuX26x6jCI7Lq07BlkPkMgGkC5moXWLsD4eJ+Gtvn0/HdhAyT/L4taBMGWSPar2UgUjSD/C5I9qCAv/HuxID7Ru1kwAWRWjF2epRDJr/dtCDNIQ7HQj2+mHZ0HgcGFGgNDB8Q+0KNIEwLmzZhMHy6VAzF5OVuMW2ybjJ3Uycn08EAIu6fJhIs/4Nq+iQjuQtU3IP07gJF4ijeCSHBXoakMPrVyx3pn3RHPzX52w8BH0bHkFyXmlL3Ef3ykr6x7dPfqjiAZM/7RRmIWoFWN1aLsUfRxp1gMTE1joBSvzENcf+bSzxwcurW4TQoihPgJAWVHxzV6Z92cYELUh3oMWu+aN4PTKAMHiR4/d3xAp4pUK6pSYmr8IuRKNwnGAHbtoDfg5v15l3ubSsqQMlyLKIQXJXSUYApdYrNl5inY+ItLjeJYgVcCImBURgEb9tl+J/wdle08Pcu/TSMhshQ/FIvnX5KE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI3PR04MB12438.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(19092799006)(1800799024)(23010399003)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NcFfi6SBwEug0KGul295nQxl83/re4oLabrw3kkJbErWyJqYrmzP+QlUhbSe?=
 =?us-ascii?Q?WvEBGRZbK0rJQbeymJQtnBQ2KFdzFFKS/kIBMZtEsWCzZ1uWcDwy1qoUo1zQ?=
 =?us-ascii?Q?KqxRn+H/mP0PWzHhKtdHTtOYZMCIIvDNb9VzTu3Wv2XleX75t0Fikjwq5yMa?=
 =?us-ascii?Q?jmhJxt4Qd6IZoSgGCdI66j6CRve7wgvChHb0vnw+v3ysEsVmbbmfeJl+OUdy?=
 =?us-ascii?Q?yWsjTVHfXPLER3sJAyZyWnPTrJtMujgXKjmUR7dI6xD6bBSnBMQKyhEmT83j?=
 =?us-ascii?Q?WXwrq/1qbbonOOxvTBEwhiyRJjE187673o2FT++cv2JbUtStSj9+X4GS1zjS?=
 =?us-ascii?Q?ZIrz4bOrG61ltPJaJCRwe8CVwW/4+eYtV0dgpQyLWDXUgj2KwiisDRKd8Hk5?=
 =?us-ascii?Q?iww+/J4FOufViFf89MLSQGuBQQpnMHab0/HJDHMO75peyrZ2gJzWV6hshsMe?=
 =?us-ascii?Q?Ik9BpB+Rz0v2csoSO67Bm7uQiRtGeDCUWYEF9+BBJ48TEVJU5FfMcanywC1S?=
 =?us-ascii?Q?Mf+2yi6poGk9bHH8oyN7qPvZmjWAMS4orylUl9WJfdNSNGTcEy0TemdAt1cM?=
 =?us-ascii?Q?4yxoh/kyonOTfkqSq8S2w9orRYQndpPLXs/zCba6DeU3MMLlmkchjPbZlWxn?=
 =?us-ascii?Q?+jIrXzbgoXxLeA5OWN9zKXX3qoocPDQnzS3WQ0NmZNMOO3vKfOJpvqtbGRQK?=
 =?us-ascii?Q?OeDflZ8ZwIAIdUtPjTFxw7V0v4Bsxc3Tg9p9fR9LWIaPkUfxXEy9er/s9a2C?=
 =?us-ascii?Q?4DWa63W81by5PGva9AXp/IpgGFXEdOugewdY7bBHmBUV1Frc58VQ7HiS5Mz9?=
 =?us-ascii?Q?XayELeSeHhNgI7GjVlf80TTmc9ep6yRGykaC5X8N8L+SQbT0fBpyURZXq9MD?=
 =?us-ascii?Q?8cd6Q+Hx2JFR048m/y9CBHueXDnvHWEQ0cLPWv6/Q/jKvYjxHmKH1d/SoK64?=
 =?us-ascii?Q?dhalHUOdTpOCLxpbY315+r06+eOMme229jybyd1wzbneXG3tvBYkBgjWUwiX?=
 =?us-ascii?Q?oZl04x3Ghk2WXT4f6AC8qQT23ao9QJCFSUYwndJdmijNunQn+o+b40l+3etb?=
 =?us-ascii?Q?sDuKetH2yDaEyN9IN4aICC4/VxbT5xjkDdsWXPOh77aKhTGW483WXy3IKmsO?=
 =?us-ascii?Q?DYHOZQ5zDsZ7Q+ldGorjgDIV+EuleMp9pU8sppQgHK6Cjq4UypFHQLfOUFAc?=
 =?us-ascii?Q?HNvetvuh1NkPkoJ9ZcCXQJNenB3NF9tkThmN17/omkOVQ/6jFBIKPKih75f+?=
 =?us-ascii?Q?esxAGylSA8G+nV8ukDR4yyV3MyV124gmIEro+Q6ywKaRnan+bC1ebw2SpWST?=
 =?us-ascii?Q?2K5vE8pcGrRXUhrKEJUtvTpHl50f2ctLzNK4nJkogk66ixcwNQ68Jy4srFQa?=
 =?us-ascii?Q?yprisoac+eUqoz5Ga2+5n0dizwnRxGdz/EwI2nV72sjm8l03Y1P8ZlEy3TXJ?=
 =?us-ascii?Q?LP5dEUooWHuE+bqidXmuEOMaAH/VYrApMsTkok+1BmNCC0sTPVEJ6WTt/uwR?=
 =?us-ascii?Q?H/gPqFp3G4gBipH5/Xu3A+fN6QqrQ2IsNs+ea56bJbgZPGGl+nzHxt3xEtx4?=
 =?us-ascii?Q?33wan+Bro5Ksx8eEOtYmxJd69Bu7GYZRcBKjjldQ8Mjb/jiyUcBFTu8X5Xry?=
 =?us-ascii?Q?2if4kodilOg97IJJj4v8SsgDgQRphRTrRZEtJKk8SvhMBK/I30IdG3+fm62S?=
 =?us-ascii?Q?lQbRyuygNcApk0xfUlT4YEmbuXvqeDUpSoh1KpN9nfZKzxHfsklxv446miI9?=
 =?us-ascii?Q?A0nLaxsrBXG4wFJtsbNprbGhDcnlYoGz92R+C2xN1hlZae07pgB6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d5bf57-334f-43a5-afaa-08df2e1924e2
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 19:42:43.9712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7gthoVnU3Qc8yPptcXdZc9v8KzBIXB/kfAuhObpKLYRpvMHU1Yat5/Zh8DVfrv6VippNSFIFVutLOyLRF/sy6Q6zJ+sG1nEvxSNwVlCXjoyGwAhKPoLrcTYU7ELOfd5/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA4PR04MB588810
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

On Mon, Oct 19, 2026 at 07:17:14AM -0300, Leonardo Costa wrote:
> From: Leonardo Costa <leonardo.costa@toradex.com>
>
> Some simple VGA DACs may include a data-enable input that must be driven
> at a specific polarity. Add the data-enable-active property from
> video-interfaces to the input endpoint to describe that polarity.
>
> Signed-off-by: Leonardo Costa <leonardo.costa@toradex.com>
> ---
>  .../bindings/display/bridge/simple-bridge.yaml     | 28 +++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml b/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
> index 7636c24906ba..b1b23d41245d 100644
> --- a/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
> @@ -43,9 +43,18 @@ properties:
>
>      properties:
>        port@0:
> -        $ref: /schemas/graph.yaml#/properties/port
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
>          description: The bridge input
>
> +        properties:
> +          endpoint:
> +            $ref: /schemas/media/video-interfaces.yaml
> +            unevaluatedProperties: false
> +
> +            properties:
> +              data-enable-active: true
> +

suppose needn't it because unevaluatedProperties: false, which allow all
property in video-interfaces.yaml.

If you only want to enable one property, should be
additionalProperties: false

but I think unevaluatedProperties: false make sense and needn't below if
branch.

Frank

>        port@1:
>          $ref: /schemas/graph.yaml#/properties/port
>          description: The bridge output
> @@ -65,6 +74,23 @@ required:
>    - compatible
>    - ports
>
> +allOf:
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              const: dumb-vga-dac
> +    then:
> +      properties:
> +        ports:
> +          properties:
> +            port@0:
> +              properties:
> +                endpoint:
> +                  properties:
> +                    data-enable-active: false
> +
>  additionalProperties: false
>
>  examples:
>
> --
> 2.43.0
>
>
