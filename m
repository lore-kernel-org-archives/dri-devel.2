Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00DA7C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 13:18:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5388010EE64;
	Wed,  5 Aug 2026 13:18:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="iVoJ+dXD";
	dkim-atps=neutral
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazon11011058.outbound.protection.outlook.com [52.101.125.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFE3410EE65
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 13:18:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xTf6OJCQfFbzg5X3nh8UGvhtVcEqPReHW55hZzvfL2QgdtxqiTb0cKk9ObIEMctdV8o8kxlhZ6gViHzI2KCoTZIxzfTRnpM1LXDCKd2UydtmyzFb+3S6CUGnfYECkI58dr73jNHnWZiQdE3G/cVVts8nnSfrZrjN9mxUYJEyZcm6tv7f7p+zD/SKGaAlBK0b0fn7SJwm+cPyC1SAyuBLRKGXucy5DwxVDm39kv2UzSfqnAG5dE0lW1F3v5z1fTALOKK5Cw+/26VDQRYclBeUDoEOn4ay6KZ5oscCUAk8nU6FONlMGi8i4ieO5w+aML+VXGqcdH/kYitMaoC0Ail7kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9ygr63OeNBIGsuc2MUV/muTG5KslaTQCBC4CT83Hyw=;
 b=omO2HpIOB8x2EqmOsiqTArxYOoxBykcFgMkL1kJkNWlQuGFJ52R0Gxz4um8rJ7O5XlRYehNeuulCeDgmdSxJhoTQkS4xfQaljPeYeVRkgZ/nlBJUCVwFHY9ykKRp4CF1qSO3KEbrTLPh1GNuWaG7nkL+dyTnnsqY0tTw5Vlm2plAZIb0RWYZ/0s0B0TAYlfvmUfo/v4FSuSo3KNW3V9MT6wOIyKR34wUwKZZY3HWjZMEm3OxgVLgi9d6WkGkxUqqwNpB996B+Znb3jSJYS5wuUxHuSDXtvdN1W4736ys4giBM4eMi2UFuvQ7Oq5TZi5xvYMopCduohDbbMyhucV/QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9ygr63OeNBIGsuc2MUV/muTG5KslaTQCBC4CT83Hyw=;
 b=iVoJ+dXDgEl1nHlTtQD8W8XSX3MPifTcdRn/AdoLZALPoC8r6pEb0kLWKsvVKJ+cvkYo5ixWaG5kCS651lsrnQlGmyVsN9+2bKB5NDt7W3BMKgIU9UB94jatBd1MWeAfvAVFpHg9TRrrTtEkz5/iALf4NFfjBxu16SGOWwqKE5k=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB10297.jpnprd01.prod.outlook.com (2603:1096:604:1df::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 13:18:33 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 13:18:33 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "biju.das.au" <biju.das.au@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, "magnus.damm" <magnus.damm@gmail.com>
CC: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, "biju.das.au"
 <biju.das.au@gmail.com>
Subject: RE: [PATCH v2 07/16] dt-bindings: display: renesas, rzg2l-du: Document
 RZ/G3L SoC
Thread-Topic: [PATCH v2 07/16] dt-bindings: display: renesas,rzg2l-du:
 Document RZ/G3L SoC
Thread-Index: AQHdH1mNwVD0Tyo6gkuWde9zVfhMjLaPet2Q
Date: Wed, 5 Aug 2026 13:18:33 +0000
Message-ID: <TY3PR01MB113468E6106F8042EA703C85D86D32@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260729125516.230757-1-biju.das.jz@bp.renesas.com>
 <20260729125516.230757-8-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260729125516.230757-8-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB10297:EE_
x-ms-office365-filtering-correlation-id: 31d03ec0-4609-4074-b682-08def2f40cf4
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|38070700021|921020|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info: OxMgYLCByJhbvFbWjhNLEUetkv6uJD/lYcC4dkFQFFcoIVNxuYrPqxoV2oSpkelkwP/ha9aDnKpPYaiLObxs6hlSlP8Lhl1BO/flBQ4qogiqCYHBLHQ3SE17rO/j2xN4znswlYEA8g3jKlVgcZOGCuflpaqd6jULPoS2iZmPnpOz+NDxv1WM4STziVTCbCUIw00wYdsbbWc9+1vvInsLhv4U7MH5cpe5fHRT5YSbz+UdfqJbs/pvGD7VizIMhRGqwETNjCAmTci9jpD5t2ioxbfakEROucCVpPlS9qGPd3xWPhME18+viPeRzarPSgr3EPhCmAtsDHS04XSS74oSYIW80mQ2Jw5AUUymgjg1x3YhyJPjQYC0gCV1PkM0+s3K4dmCInsgLm8sa/q9O6nrjUKQQm5sz1XPzEmGtP+9X0y6M1/VKC62ttQ1GAPMFoDgE8Y7WJqJyV4z6Yf9hwZSgTAkmAD2uTPlNYxgOSv4qAPqT0EwwFMGwVrw58tBzM8W2N5ImKusK25wCsLkdS3+b3R15RNeBfyWZiXKaJOURyNhEWLI1FyoSNN+MhAdPCR2hrZEK8/k494jnivr05M/+ciAgfEtopa5Sngqn/DVfvRqnjXqJ6G2UEvkbCBw1tM7mx9AOZC4ywRG0yto1MnndslGDlHj915E7eJtnsoXHFyO6tqYxPHsHg8U13yY5uCcn1eCyEvLBfLtnQG2TJtYQcV2xjbKQXq+Jlh3a+CC+kCJXS8y1uND3tc/qlRFVCMB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(38070700021)(921020)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aoGxrihvSBNxX5lZuKSD3huPaH2q1/QN+R41iMlAQoiB6MwQy4vJNxyXNkx0?=
 =?us-ascii?Q?9eJb2HtfTE0czR6Suww/g4MFW8tbYAf5Scw+UHHxa26MkfIdFNh1HpwHWRh/?=
 =?us-ascii?Q?6ZkAg8lj1YQGfg1VhN1YyjuuteZR0KZG9qqXmR2VQPR/aa7zr/xl6DOAH9Q5?=
 =?us-ascii?Q?/ur/V8BhR0NM4i/yPEAkL3cEO8nwyVUvvyM5BoEBebJ+RB1g7gKzITp9l06Q?=
 =?us-ascii?Q?xUZc3ym35wZlU5EyQEsa5bSmJv6YzLUqh7zT+NQni0yLEE7gds5gFkYiRvVS?=
 =?us-ascii?Q?WlYnMZyolCKZnH5eP5IdSJti9wJm5hRGXAi+RQsMEGjvKQF1hjUoYlrumtCG?=
 =?us-ascii?Q?QKuKmDdqx3Iw//Fk0lct4YlRyd9AQIPxVQx24gI4jQ9hS8Yfhctk2V/kPKCO?=
 =?us-ascii?Q?EZPmu9OE51Pa7DWZVlUbvNwulQn8dXtyx0h0vjhT8xBhUjo7YZG0Y+HKYB3p?=
 =?us-ascii?Q?mLsz2Xrc5XRG7JRJfZlsIi1g20Dvil0yaaJhq8Ry+/99O7fYAMbo2W1rEjfg?=
 =?us-ascii?Q?zl7LawcAHtZb5Q5tYPdHudaDFr5L3zS2osfGjOPHCDigBYclnklLlZ7x2b70?=
 =?us-ascii?Q?siZ3L3j2iIQ1IjJKBSSeI45AISdOrU4wNhw7Om1HMDzll8qChSuq76O5LJh/?=
 =?us-ascii?Q?RGkCAPrACKXmVwDKvP4QVPYglbRlQTeG+LoxttncUT6RtTge68MOZatuJAl3?=
 =?us-ascii?Q?WW0X6IS5wkJT0ZEpJEPTSdyDCKbgt226mmJPB3xy+NGUFvnOW0VPc7mYfqeb?=
 =?us-ascii?Q?ITrFbaDyKaM6OhO8Jrur5wAyubvtpSXeMutPLWr3tnirWw+PuDdYITkKKSK0?=
 =?us-ascii?Q?l5Thq9undba6422NAORolrJmeC+YxMMZ8VMPYJ2rev9mUexc7iTT76gZqA57?=
 =?us-ascii?Q?Sc9Zf3P1Mwn8dAzNwqgbNvShWLpHYLXbKeflXvt+dK3Aqm8/tsnSpmo5NgFh?=
 =?us-ascii?Q?/eD2lzr+QSpM2nR9SIs+cKu4vktNOnXyRD3PXMVNrkfCLpJviHkJnJEw0E+D?=
 =?us-ascii?Q?PkAHKqV95ZHh5zEmPmBoFVOAM6Svr6f5/eUNe+fKmnLVPET4T8IJIUXIR/eY?=
 =?us-ascii?Q?DFKaUn0XbtbROR0BX+PGM0oWBdwPAhdPqDHvmfwx8vtR0NE/X6+NZ3VSj4bW?=
 =?us-ascii?Q?/V002O6XOJGJBghiGgq2+dQd/k4+2W1XSzDTWz1vnmTKAEwHeKOzrVuHbkGD?=
 =?us-ascii?Q?+Y6MXnUP0+1nGuosjgSeYMDg5wHFt5RMdA15cgO+O1nuZLV3IlMRSnmWpQN9?=
 =?us-ascii?Q?fUQp4U/jOdHNaFV0mVgX7wCxM2kIWQcvm7aDTWRHQTCuAxcNlmL7tQZAhKwn?=
 =?us-ascii?Q?MGe4y8FYlfFiR5JeIYiylOGd6wjLHORfQUO1SAztP7x2QFI8xRtEX8mebQSP?=
 =?us-ascii?Q?QP6lT2zD3VbBXXcHTZyTVnTCWP9DUICGfibVLYgNlwTmhoBMsYV3cqnA5H2F?=
 =?us-ascii?Q?fn1rF1aTJP8ZTaeNyE33IwLXhO1L9NGv4Nvkdk0f5aUqUagL9kFCNo4SmsiN?=
 =?us-ascii?Q?cFiDjbpho+8oBHwvsEpxNbR12f42VXhGx+4anVmoekVDkpoUKYaRIHBn2862?=
 =?us-ascii?Q?dyGx/PelrDIWI7uTWspCrSZG1tOe94M1lq9xGvONo1nXrCiqDs2Ao0CYQDdm?=
 =?us-ascii?Q?vB2lF0bAa6imOGegmgugLCScsYGIYW8MERCZy28KA6vyfbcEgXUKSz/PCuhu?=
 =?us-ascii?Q?ZgNI/cAQ/va7QuoxrW39TR72oTZNoK33x4VgJD/xQAruD/6cX4BlsTU07FTe?=
 =?us-ascii?Q?RH/VECLQSQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d03ec0-4609-4074-b682-08def2f40cf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 13:18:33.6410 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UeBD85ouaIQCFqeX55cqGiXBua/mNzHIpOKGQY0WCqwXAd+Q2J/yoyU5zB9t8KqjpFZTLygaETsFRPiDS0loKEC3kHJxUCNC/McUb6ltR8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10297
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

Hi,

> -----Original Message-----
> From: Biju <biju.das.au@gmail.com>
> Sent: 29 July 2026 13:55
> Subject: [PATCH v2 07/16] dt-bindings: display: renesas,rzg2l-du: Documen=
t RZ/G3L SoC
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> The DU block on the RZ/G3L SoC is identical to the one found on the RZ/G2=
L SoC. However, it supports the
> DSI, DPI, and LVDS interfaces, while the RZ/G2L supports only the DSI and=
 DPI interfaces.
>=20
> Due to this difference, a SoC-specific compatible string, 'renesas,r9a08g=
046-du', is added for the RZ/G3L
> SoC.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Restored ports.
>  * Replaced endpoint with port in ports node.
> ---
>  .../bindings/display/renesas,rzg2l-du.yaml    | 26 ++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.y=
aml
> b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
> index 7c84a9ecc7a7..5c9b15a09dee 100644
> --- a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
> +++ b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
> @@ -20,6 +20,7 @@ properties:
>        - enum:
>            - renesas,r9a07g043u-du # RZ/G2UL
>            - renesas,r9a07g044-du # RZ/G2{L,LC}
> +          - renesas,r9a08g046-du # RZ/G3L
>            - renesas,r9a09g057-du # RZ/V2H(P)
>            - renesas,r9a09g077-du # RZ/T2H
>        - items:
> @@ -65,7 +66,7 @@ properties:
>        model-dependent. Each port shall have a single endpoint.
>=20
>      patternProperties:
> -      "^port@[0-1]$":
> +      "^port@[0-2]$":
>          $ref: /schemas/graph.yaml#/properties/port
>          unevaluatedProperties: false
>=20
> @@ -108,6 +109,7 @@ allOf:
>              port@0:
>                description: DPI
>              port@1: false
> +            port@2: false
>=20
>            required:
>              - port@0
> @@ -124,10 +126,31 @@ allOf:
>                description: DSI
>              port@1:
>                description: DPI
> +            port@2: false
>=20
>            required:
>              - port@0
>              - port@1
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r9a08g046-du
> +    then:
> +      properties:
> +        ports:
> +          properties:
> +            port@0:
> +              description: DSI
> +            port@1:
> +              description: DPI
> +            port@2:
> +              description: LVDS
> +
> +          required:
> +            - port@0
> +            - port@1
> +            - port@2
>    - if:
>        properties:
>          compatible:
> @@ -140,6 +163,7 @@ allOf:
>              port@0:
>                description: DSI
>              port@1: false
> +            port@2: false
>=20
>            required:
>              - port@0
> --
> 2.43.0

Applied to DRM-MISC/next.

Cheers,
Biju

