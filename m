Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8FCFD875E
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 12:46:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60A6610E1F1;
	Tue, 17 Mar 2026 12:46:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="VhgGCy+7";
	dkim-atps=neutral
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazon11011032.outbound.protection.outlook.com [40.107.74.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7CEE10E1F1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 12:46:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K29TMghbeiGaEpc6HeTV/9xn/pgRBvYoKg0OYh4gs2p63huMkjhxY4LEYndEthtUGL8XbqN9QdM4eZPZs/g8RIUqcrdKnh1uShuVXf59tkNsS4UTgtgmsOeUc38TxS5D72i4Z1tB0HX5Mb3+5qeMUq0xZVzB8XD+ZfowKz1T4yKFpowXgmPpZuoahsENvXZ5vJHxQzkWr3LXEtvu211gnHh5yCGR57zUTvLrkkNcvT5Yo0LeywfWcpj0NU2i125bH8nLW2rW4rh0V+nfJcbNW62MM/2Gtrv5Wn6clrdl+oSrTuWpMMeiRq56UklwvIR07v8eLYwuXea0mSSmr63ZbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDfZovbHiOh+4GJbL3sywNE0BJpagCNanQem6BiTEBE=;
 b=RbZ8SWQOppk7ojxYDPV5zVdQHLJij+uFOhc5W2jeusNV4NkeUmsf0ivWES+vJYs6hVAhTkQ/CtVEf//NuT81LG691FWFWsX07iA+PX/+6aUEHDd6pYzsEBgz2m673n9k0bDJEmnEdCOU0xjltV4txy9Ey40RPOESoKRQuB8eqp6azr0FtMiLZms6ZGoH5si+SZklOdxhQkHeCdAaTGTAf7g3ECquYxkfKWgdaDeK+SDDDvZXlvne5fkKCf6Pi/+lYhy9gPHCbEuFHJr7F3eS+OAr/2UFaa1ULpFaTAIQWvT5PNAeFWecvq7V4kAL27rgBRog+k1PnY9QGoOcrPk55g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDfZovbHiOh+4GJbL3sywNE0BJpagCNanQem6BiTEBE=;
 b=VhgGCy+7mDvvfN7fZ8q59+h4R/YW8YAr52T2bGxFr9rwQ83ZhDB7OW4OgMvT1hsxaETUpdijrHyoVMyJWagJxM40IobmkaBNNvxsRbQ3MbtuFCp0bEo+yDdj644bAg+qtTf+AYLuy/f/4CyyDtx1fyK3wAB7PmwYAET54LRrUEg=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYRPR01MB16070.jpnprd01.prod.outlook.com (2603:1096:405:2ec::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 12:46:12 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 12:46:12 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, Tommaso Merciai
 <tomm.merciai@gmail.com>, geert <geert@linux-m68k.org>, laurent.pinchart
 <laurent.pinchart@ideasonboard.com>
CC: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 magnus.damm <magnus.damm@gmail.com>, Laurent Pinchart
 <laurent.pinchart+renesas@ideasonboard.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH v5 10/20] dt-bindings: display: bridge: renesas,dsi: Add
 support for RZ/G3E SoC
Thread-Topic: [PATCH v5 10/20] dt-bindings: display: bridge: renesas, dsi: Add
 support for RZ/G3E SoC
Thread-Index: AQHcnQX1YgHEkoVhUke+0jJkdVf6nbWy3cSg
Date: Tue, 17 Mar 2026 12:46:12 +0000
Message-ID: <TY3PR01MB11346EAA76EF4DC59B2FDD1D68641A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <cover.1770996493.git.tommaso.merciai.xr@bp.renesas.com>
 <bcfe88f55ca42f45aaa3a364f293bd149b721701.1770996493.git.tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <bcfe88f55ca42f45aaa3a364f293bd149b721701.1770996493.git.tommaso.merciai.xr@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYRPR01MB16070:EE_
x-ms-office365-filtering-correlation-id: c13141d0-b415-4984-3f91-08de84232bba
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: N6L3wmxPBd8JqzpwWJ0+mdwExh7/u9G0auRC8k9qBCpQMP7LM4MdU5l9JRf32VhxwKWYTtYMKNzpsQDd7mDzBUEIEhUzlEjkx0jJHZoR0v55h7zhmQz4IfJ7aTqVi/jSpiERkJQDV8UMOWZaU/IVNC3RY9D/VrHjYMq5yiI+pHAlZ3DtY4L5mU6Rns3aQBxeUv0fV66Ul105oZ61/6Om5fUv3eNnjwuQMbFBL/ZQSRIOHrOBNfLsAW2WupRZIrOGYuQrWfd/UNqRXstzcapCIuFVPx9DIyNUkXTDjRqG5LH+I0pPNWb21n+iyI7RlYvpbFzAtPw86IRm8vlfmg5Ys6Vfy7Gwwk7xZtgTtCh/Aavs4E0KXqgiYaw1drcL0SG9MWEuneHIHYscqeh0cr2x9YISVaPP2xi0Z/apE6KdcJvrnxDmKuRRRCb2JzmoJYd9+7lp9y3B5mOpBNvItmYVRwLhK+Q8NvcfybUGGaycl83fmXio09VglVV+Ro+sjLv3okLg4PCo+U62I+VvXL902f8M9yU8clh2dUPHN3WitJmAbj7gfnZ1e3NR2kxj2nS9AW632GEvxHJbV4T9KdDBPlWDBpR1DDSQTFmpk/uto+G7nf5BsauRGz87U4fwZoMrGKwnHtRxxTw8nr+xd78HySw0stZUyKqXwfanDkJVoFZwtPKGev14LO8e9K+8N+nAXCVa4qE6I48atxA//YJ6f/Qk41ZylYHywl/FrG6rDB5qe2TK+QhVOvxM220/TxGmihtFdvsM1lIFOv2mtabILHSmTLoirpBaFc9YJfaH5dQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Fcf6z0f9jD0kNjsVzKtZubjpHqyVmN1CAKuSojqA72tEuY/aQhlfjPHA1hhN?=
 =?us-ascii?Q?rF5/VfO20mSz76hlCf2sgLxSrAuEl0kCqyQD5660O7m5Rv+/E98lSQKimBGg?=
 =?us-ascii?Q?YRRYf3Qr7BeQ+Zhz9ZOKbNFLMug06NsZtnI1vc+kGU1+2DmgawXVRnsHTOFB?=
 =?us-ascii?Q?QRxJp5HZDaT67mkddBl/xT05JZprmNTJR9bFSCAyDDcBJ/70PyhAj2EpQyUi?=
 =?us-ascii?Q?rmfYiy0pXAOVYWGapmNUn/R7MqNNeHonYvAaYlT3xUkkP6CFh7yVqrtUk7Th?=
 =?us-ascii?Q?T2re6WYd5YY3CVFxj+MetdjosBjm/5HPYNJnfYOzgisHaeIM8+nzLZJXqTJ5?=
 =?us-ascii?Q?R0HobYaC7Qh+5zB/SHGhPduVGgOu1JcedmjmssnOhNUHbvOI5HBmRZM3VmfJ?=
 =?us-ascii?Q?15xZlKxcEonWg2tRgTDlRjbmUAAZHCKXG22zwScWWmzJgDa6XPku/fTEL2nF?=
 =?us-ascii?Q?Q1aUj1o8WcghkcVnn8SlNU262w4yerc9ZedRmLenoVcVG9kE/UyG3UOMW0eK?=
 =?us-ascii?Q?5uq0jlXUa0suAzc/UhiseRMHTvKFaHVL0rV2wrUdSu4X1X2VKy9rKd8tjbbm?=
 =?us-ascii?Q?0pRZgoA+8fgssC+caowEVQTfG7B63gMvgABC4vkgEWRE4di/zanEAiEmwHb5?=
 =?us-ascii?Q?wFzRAqX7/GBvPs4U4Qy2XX3l+93z5hti/Am3mWhUWRNnrOgqbB+K/65XWlwO?=
 =?us-ascii?Q?x+f8xUnPlNt2jgo95Jl1T8taoPIyIkpEjWkQEcbNczSOleZrrVyuaT+CqEFw?=
 =?us-ascii?Q?3HfzahBMrd3yqrGTffQ9UFLFS0t4mZ426dkg5TF2Axksm0jZtJF0aEgJEiH9?=
 =?us-ascii?Q?GJoggI6zZ2ySyFcbwmSjtE+3ehgzu9UDLRLJHOHAAm91zfwPz9bbTuwgb9rM?=
 =?us-ascii?Q?2E8bOXiZG/yGyPWxtQWD9piQf2pifO6VUghVX7OHIJuAELpMS56HXZ83+Sj/?=
 =?us-ascii?Q?waJAQC1iG5/R/9Ve8abGMlR2xleJmsbriNuSqid4bxGgZHCafbL0SagxzTYT?=
 =?us-ascii?Q?MzXDhmg9N4QwOMIFh9EzpibmjFSfQ4ktZOwSzbSbj/ssPoVkw1JYOEU45UFH?=
 =?us-ascii?Q?hOs4Oa3vp5TyggvX4T+uJbSYwJWefsDALt16C5S9fYqW3xkY55QvKN4vPuF3?=
 =?us-ascii?Q?LTCG+3nBgmM1TzDJtEDlTFpYNit3viJlGejx2X1qM1S8F8GRj9GaJyaZRUdt?=
 =?us-ascii?Q?dZAbN1/THkNySr7u/+5ZEAjv6EUIvAAJJdtimpsViBPqTH2qUX6kOnYVCO2Y?=
 =?us-ascii?Q?EKxhNQVd4mBpz/YHpgirdAr+FszIK7L5jzx7yp/p0aka20L5ZuDIJyltBGHn?=
 =?us-ascii?Q?X+/QaRNXWHEKrt9bGg3J+d7qnD4Q9Cxs7ZwO/1HJ0FREgAOItObaM76cMDvx?=
 =?us-ascii?Q?DDuk0d+LnLl29M8ZoVTXKglbiJ7G8o+p01vqsSkw2vYRJyXixeYelIcADTFY?=
 =?us-ascii?Q?D8a+ZsgKkt90YMgH/L3UdhWfWiOjWD6wKn3fnDopfBFH0tNuuvFOBr/pc03J?=
 =?us-ascii?Q?y5VnVIP2xR1YjUGW+mbob0hqV9NxYKfhaVTSEkTpKAfbo4kTjCliE4SP/trG?=
 =?us-ascii?Q?8APLF5pu+BNk6GUbp8DMZZnXT5N/yo1bK6up9LBRdmKCdRu+PkI987WKOvFW?=
 =?us-ascii?Q?j42G0W0105v6iTyLLlW1YjkXuRnFE15IQh0oz6djpjQ9oidE5d0RrwEnkfRi?=
 =?us-ascii?Q?8uKJXJl08Pt8ypxcTalzLKk285x6wzk7k6TCql3edb3No/mc4tx8vxv0pKp6?=
 =?us-ascii?Q?ERC+CkVKCg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c13141d0-b415-4984-3f91-08de84232bba
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 12:46:12.5065 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hO6uAKLCutnPerLBqc1zS9jHFyp2Aj7nOkypUkLoHTnlUE7RJhl5YRA3CMpJ93DSTJHidR1kTJBVxgBjR3hzDwPR16W/HFKozwetARBIHxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB16070
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

Hi Tommaso,

Thanks for the patch.

> -----Original Message-----
> From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Sent: 13 February 2026 16:28
> Subject: [PATCH v5 10/20] dt-bindings: display: bridge: renesas,dsi: Add =
support for RZ/G3E SoC
>=20
> The MIPI DSI interface on the RZ/G3E SoC is nearly identical to that of t=
he RZ/V2H(P) SoC, except that
> this have 2 input port and can use vclk1 or vclk2 as DSI Video clock, dep=
ending on the selected port.
>=20
> To accommodate these differences, a SoC-specific `renesas,r9a09g047-mipi-=
dsi` compatible string has
> been added for the RZ/G3E SoC.
>=20
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Cheers,
Biju

> ---
> v4->v5:
>  - Collected tag.
>=20
> v3->v4:
>  - No changes.
>=20
> v2->v3:
>  - No changes.
>=20
> v1->v2:
>  - Removed oneOf from clocks property, which is no sufficient to
>    differentiate between RZ/G3E, RZ/V2H(P) and RZ/G2L.
>    In particular both RZ/G3E and RZ/G2L have 6 clocks with different
>    meanings.
>  - Use the already exist vclk instead of vclk1 for RZ/G3E DSI bindings.
>  - Updated the allOf section accordingly.
>=20
>  .../bindings/display/bridge/renesas,dsi.yaml  | 144 +++++++++++++-----
>  1 file changed, 109 insertions(+), 35 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/display/bridge/renesas,dsi=
.yaml
> b/Documentation/devicetree/bindings/display/bridge/renesas,dsi.yaml
> index c20625b8425e..00ef279129fd 100644
> --- a/Documentation/devicetree/bindings/display/bridge/renesas,dsi.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/renesas,dsi.yaml
> @@ -28,6 +28,7 @@ properties:
>            - const: renesas,r9a09g057-mipi-dsi
>=20
>        - enum:
> +          - renesas,r9a09g047-mipi-dsi # RZ/G3E
>            - renesas,r9a09g057-mipi-dsi # RZ/V2H(P)
>=20
>    reg:
> @@ -54,20 +55,8 @@ properties:
>        - const: debug
>=20
>    clocks:
> -    oneOf:
> -      - items:
> -          - description: DSI D-PHY PLL multiplied clock
> -          - description: DSI D-PHY system clock
> -          - description: DSI AXI bus clock
> -          - description: DSI Register access clock
> -          - description: DSI Video clock
> -          - description: DSI D-PHY Escape mode transmit clock
> -      - items:
> -          - description: DSI D-PHY PLL reference clock
> -          - description: DSI AXI bus clock
> -          - description: DSI Register access clock
> -          - description: DSI Video clock
> -          - description: DSI D-PHY Escape mode transmit clock
> +    minItems: 5
> +    maxItems: 6
>=20
>    clock-names:
>      oneOf:
> @@ -78,12 +67,14 @@ properties:
>            - const: pclk
>            - const: vclk
>            - const: lpclk
> -      - items:
> +      - minItems: 5
> +        items:
>            - const: pllrefclk
>            - const: aclk
>            - const: pclk
>            - const: vclk
>            - const: lpclk
> +          - const: vclk2
>=20
>    resets:
>      oneOf:
> @@ -136,13 +127,6 @@ properties:
>                    - const: 3
>                    - const: 4
>=20
> -            required:
> -              - data-lanes
> -
> -    required:
> -      - port@0
> -      - port@1
> -
>  required:
>    - compatible
>    - reg
> @@ -164,33 +148,123 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: renesas,r9a09g057-mipi-dsi
> +            const: renesas,r9a09g047-mipi-dsi
>      then:
>        properties:
> -        clocks:
> -          maxItems: 5
> +        ports:
> +          properties:
> +            port@0:
> +              description: DSI input port 0
> +            port@1:
> +              description: DSI input port 1
> +              properties:
> +                endpoint:
> +                  properties:
> +                    data-lanes: false
> +            port@2:
> +              description: DSI output port
> +              properties:
> +                endpoint:
> +                  $ref: /schemas/media/video-interfaces.yaml#
> +                  unevaluatedProperties: false
> +
> +                  properties:
> +                    data-lanes:
> +                      description: array of physical DSI data lane index=
es.
> +                      minItems: 1
> +                      items:
> +                        - const: 1
> +                        - const: 2
> +                        - const: 3
> +                        - const: 4
> +                  required:
> +                    - data-lanes
> +
> +          required:
> +            - port@0
> +            - port@1
> +            - port@2
> +    else:
> +      properties:
> +        ports:
> +          properties:
> +            port@0: true
> +            port@1:
> +              properties:
> +                endpoint:
> +                  properties:
> +                    data-lanes: true
> +                  required:
> +                    - data-lanes
> +
> +          required:
> +            - port@0
> +            - port@1
>=20
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,rzg2l-mipi-dsi
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: DSI D-PHY PLL multiplied clock
> +            - description: DSI D-PHY system clock
> +            - description: DSI AXI bus clock
> +            - description: DSI Register access clock
> +            - description: DSI Video clock
> +            - description: DSI D-PHY Escape mode transmit clock
>          clock-names:
> -          maxItems: 5
> +          minItems: 6
> +        resets:
> +          minItems: 3
> +        reset-names:
> +          minItems: 3
>=20
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r9a09g047-mipi-dsi
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: DSI D-PHY PLL reference clock
> +            - description: DSI AXI bus clock
> +            - description: DSI Register access clock
> +            - description: DSI Video clock
> +            - description: DSI D-PHY Escape mode transmit clock
> +            - description: DSI Video clock (2nd input clock)
> +        clock-names:
> +          minItems: 6
>          resets:
>            maxItems: 2
> -
>          reset-names:
>            maxItems: 2
> -    else:
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r9a09g057-mipi-dsi
> +    then:
>        properties:
>          clocks:
> -          minItems: 6
> -
> +          items:
> +            - description: DSI D-PHY PLL reference clock
> +            - description: DSI AXI bus clock
> +            - description: DSI Register access clock
> +            - description: DSI Video clock
> +            - description: DSI D-PHY Escape mode transmit clock
>          clock-names:
> -          minItems: 6
> -
> +          maxItems: 5
>          resets:
> -          minItems: 3
> -
> +          maxItems: 2
>          reset-names:
> -          minItems: 3
> +          maxItems: 2
>=20
>  examples:
>    - |
> --
> 2.43.0

