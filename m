Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9860C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 13:19:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CE7710E1F7;
	Wed,  5 Aug 2026 13:19:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Bz7Bvt4h";
	dkim-atps=neutral
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010036.outbound.protection.outlook.com [52.101.228.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDECC10E1F7
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 13:19:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dExYrP2eZrY7WY6YmalGx8K/zMwqOkbn5NwWgvrDWRL9sFwhSSb4BEoLbwZCRr+EjSqBYxHzZ1zgl+AZKuLvHe4QNcc8tkSIk5D2e8yM8ya3csjZb/PQ7x464Dm0C+HmTX80w2av114wF+LrLUCgk98bV01FLqIQjvVyl4jjI99LM7DrpbfkIaR25Vy7NLug7bDDasZUF46bL27su8Vl2jMPHWrpyrF3BfyuSkZVM0+EKTgexPCaKhC4zLr4j7GnpuyfBTQHbd+H8xTXB/fo8Kms+D9BT4k6UtCxze2+IdDyOj9cOi/RR7inn7D0xg6sMq/YGyjqa9gI7jJ6Q0GrTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1T+1DO/7LtaxMhzamiYOENb5Xui+VHS5eL1WR4rJ1c=;
 b=Cc1WKunXDgxdniA2yWoCejWfZ4o9bqkzpbIb5wlnE8UZgBRqR3NqEZy0sdtnQdYhSrf26fQowISwvHTymffokzhmyfvZqdG8A6VSoOC6F4Nxee60w+9GXme2ZNz/pWL77uvG5KHuW9XMpKayb/eRrhFAHl6GWrDWPnazT5UOOp51I2oUvc86G2rnBx3Few1ngQFfRPuETqKR1CkPZx//6uuyQJkw/QL1XF/ykW6ky1xDQkp89WqVnjg+69BCPKrU2I6vFxqoFsRDT+UcyTEJGiuuPMhXWV4+AWNUiXSsH0LAUU0FnDFXg9BSB2YrigtkcAHrYJlH1DPvwWzwbUJWNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1T+1DO/7LtaxMhzamiYOENb5Xui+VHS5eL1WR4rJ1c=;
 b=Bz7Bvt4hf5ODEl4fKGCRx0KWc0Ck0OWxxQjBSA6WPpspJ+u04l6Q/W9eMHIqypU1o9QRXK+kBsODQ6sH+Sw/q16tnsIVWBGSkBAn+io3EubWSd/Hiw3hMWNrBBo8/pVggk9yI3vxjJmmZOnP/4Jk7o6DVO8rjuZwlzWdJi7BATc=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB10297.jpnprd01.prod.outlook.com (2603:1096:604:1df::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 13:19:44 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 13:19:44 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "biju.das.au" <biju.das.au@gmail.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, Robert
 Foss <rfoss@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven
 <geert+renesas@glider.be>, "magnus.damm" <magnus.damm@gmail.com>
CC: "laurent.pinchart" <laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Tommaso Merciai
 <tommaso.merciai.xr@bp.renesas.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
 <linux-renesas-soc@vger.kernel.org>, Prabhakar Mahadev Lad
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, "biju.das.au"
 <biju.das.au@gmail.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@oss.qualcomm.com>
Subject: RE: [PATCH v2 09/16] dt-bindings: display: bridge: Document Renesas
 RZ/G3L LVDS encoder
Thread-Topic: [PATCH v2 09/16] dt-bindings: display: bridge: Document Renesas
 RZ/G3L LVDS encoder
Thread-Index: AQHdH1mQc00+LcYrEE6IPOOt6APBSbaPez8g
Date: Wed, 5 Aug 2026 13:19:44 +0000
Message-ID: <TY3PR01MB11346E2681F2048239B37B60A86D32@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260729125516.230757-1-biju.das.jz@bp.renesas.com>
 <20260729125516.230757-10-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260729125516.230757-10-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB10297:EE_
x-ms-office365-filtering-correlation-id: 82da596d-6c5e-424f-21bb-08def2f4375f
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|38070700021|921020|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info: 4G8+tZValPdxikMVkYnhMrRsSQWmmunuEv+ARGPW6YVcYFWzMO9Ow4/oTH+3/lD3DiSgSrvMqh0JVF2GoSOGfIY+qWA/fSex6H3VA1+Aif4ED5UPExNVaThDHu6ebYP495nkzHUCD8WtooTBI6acbq6sHzOSFJEIXYDs6uMT06PgOhpR63HgGzvy9GbeE8QrzK1u8IUF66n2BzFhlTRLvZxGLj849UbB3ymm49LtkQwJWtmzdwItX+r5MzPECWhXbVIjpEXNNmRuQO4Bw3WCCErV75xvQL+lJCnhY9N2iuMWj1oDgmUBapALn8qrgk0nUz1RqOy/BrzN6ZYEBKMhi2RANh/7bs0W65OUKIg0DITOoxsIkSEeMNFkKIey/1MVZK6ndVb2k4hjUGe/Mgsme2Ljch3XQql+0Ah2xzJiPpLCUIwqO8hZ7J894RHtzgZZzeM0v5YGW2zx8lazrjAFRbXcXVBEY3PxVaqrbfRAW20FXZO88OR2FZZQdLSebkAQftwXf4dZWVerZVNcO3yLTL8zFINhmM+HRCY1FVDKWATu3SFRlsP4fglphoYCy8rJ1Il9hUs08hOhtEfnvU6m99IXibrQG+gwteF8j2j3h1Qb9PnJ7nNUysTDj+P/sx2ZE5abW3Dhv4AOldCQ1SYDu2XMJoVXpDa0VGOaeXwV4zWIiP1HZyY+IbRdv9l/EfQRdE+tkovBk2C/YIpWKgVePeSBgzq7HhlUN5+qrfA2GTFM1fLdBOQbFYaDNVgDsvep
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(38070700021)(921020)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qlRaHifNYJLlrzE41XupDG7iP1o/MVmSqlraFl0fzh7nup9QqsDM/WoQ9mjN?=
 =?us-ascii?Q?j6hepmQbI+6VeZvWuioythWGngnIoH2QxsMGrl+umtlfklAnSwcCu8F6fH3/?=
 =?us-ascii?Q?OpOncE7XdIs7ITeL5RYRxeudiApEE1eP08+MciyuXplqM96Mjhod9/44BSKe?=
 =?us-ascii?Q?1S9wgRZXpWmyh0tnWHcm6ciayka2PrkY29dKaU/0W78iTpfLrYXQ+BMXW6lX?=
 =?us-ascii?Q?HSJ/BIo7x8j6JGCtSWL1RbWtzGYe1IV+cT6GZfx97eF0DCtN+HYwtAoq3KYE?=
 =?us-ascii?Q?hxivbvIChEwkU2ykdQj0ZFv0D1wFKslgjnXEcdERwh3QCHBlkgR+LNcbvbNG?=
 =?us-ascii?Q?rsqD1d0pd3Ja4EkkBJYqUiovEDIMagf79nbZjfIyyBdPpC+ll8szxfLpzSec?=
 =?us-ascii?Q?INtZBSmM8UjvzISN1bX6736AvFi8kI+KGOFPfvWfzVI0j5t6kI4j0io8sR3O?=
 =?us-ascii?Q?TsM81OZhxGs7KDncJnD1scFx+0f39N52flLqSN8ys+pTk+7acOjkfFu7xpMg?=
 =?us-ascii?Q?ecVFYBoKajEnkehB+S2Zgq/zYRNtzQX9B24e5dHGtGfEZ1IEk/VEC8bRD75o?=
 =?us-ascii?Q?p0g3kpZlzfvHOgjZyyqDnEFy+/A18fY5CVBXOykW9VQUMT9O0RHHAny7kveS?=
 =?us-ascii?Q?mULbDLMKzylGTPWfZcyXRfmWTp2YhjqF6Jb32+3RhMCMemLx86xuXc4YJHCa?=
 =?us-ascii?Q?Ppxgqy/ihkbDtTr8dGmS4Jii3fziuJOQjwudr1cyY1l1R2N6Ae+4ZepvK++9?=
 =?us-ascii?Q?TScxWAHyQuL4YZIg8y6kA6CVo81sf3uqeBYxbmuNL7D2m6ZCj0wbIq9oVKCP?=
 =?us-ascii?Q?ehBP7SYRTqFVylb7NRpkI3I0eXHlJZsyeNhqgklxyo9KZBZqRzhwMoDFXjDN?=
 =?us-ascii?Q?rR8kvjroaubS2kshRtwxzWUwcjfP4nvlBaT3gpZdHsbYtO98E4QAwifJwr0o?=
 =?us-ascii?Q?bdk1uYsuCitwH7rIi+s9i131P5/p0UZiZkwOEBqwuzb8yhYEc5M1cxjH2rcb?=
 =?us-ascii?Q?A3lXUa+dAzn+o4wF6Cc3mXCt7vvcmgKB7ts0TkI6hY8mP0zeuNhBQUhlAcj5?=
 =?us-ascii?Q?yMLRjzJhLOfCGVSxpAEXszjyW2XSLH7PQ0zr43pg64NQy9XjAG2fnWbJS2rf?=
 =?us-ascii?Q?WR5XiJ6V8DeQdQFBLQJYhMCBCf7JAitbSL0xpuhydhbvdRKCRfSFStGLZe2l?=
 =?us-ascii?Q?luysWbSztbfqfqm/SMzoT0BvSLB6D3VgtmBIi+CGP2vedcvczKeAlyfb5/x8?=
 =?us-ascii?Q?9inhiIRFsDqzxP4nb1THUudZsE9e+1ud5scmjcUYBOEU6CnhC/HKnfZc5qOv?=
 =?us-ascii?Q?0q+PySBEkPqeLny/tuyoISAJRwnV36OHVoBVqEPnt516YJWvnNLR1V8ZiXoq?=
 =?us-ascii?Q?FiDw+FtBPZTp4K+uLmflb6Ec8rVaGSXLD6NEbCJ40906ZMFvyGluq7IJtCvr?=
 =?us-ascii?Q?qyKaUEX4+Mievz9/uk2k97MB6HIfShF1umbhNfymTuxBeRrVXQtnsMCroH9B?=
 =?us-ascii?Q?pPC1sLbZJYqMzBG3Gi7exV+u0W1S4x2fGQuK984ZLKoqYcUrnpMrzT6NoCAZ?=
 =?us-ascii?Q?lIbeb7zuDvt7iYBJlDUozGqKCFq8hW41dxAFvw/EcIybvBzALbDByWkSqNta?=
 =?us-ascii?Q?rhahfmTvkB7KR+Bww20zrGHLA7rh8xXzDXQrVRrYCAwEicS3pLCYMy/+6vFH?=
 =?us-ascii?Q?obSwP2x13sPZ6uyuQc/HSyb7zcmV6rYV15vwFTJW60P4cd/Q/FmH5IOOBDZI?=
 =?us-ascii?Q?pFInm0CATQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82da596d-6c5e-424f-21bb-08def2f4375f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 13:19:44.7676 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gs1VUvJPs14kw4IEw7wFQ2fNncqlc9o460eKfx/3J56ZUuNFJvCRyZX8Yt8hONY6XD9cKkW0VLVPmJW4XV61YlZc7euDNJmw3C30WXkrxFc=
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
> Subject: [PATCH v2 09/16] dt-bindings: display: bridge: Document Renesas =
RZ/G3L LVDS encoder
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Document the LVDS encoder IP found on the RZ/G3L SoC. It supports single-=
link mode. LVDS and the DSI
> interface share a peripheral clock and the MIPI_DSI_PRESET_N reset signal=
. However, the LVDS module
> cannot be used at the same time as MIPI-DSI.
>=20
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * No change.
> v5[1]->v1:
>  * No change.
> v5 [1] https://lore.kernel.org/all/20260625172359.292631-2-biju.das.jz@bp=
.renesas.com/#t
> v4->v5:
>  * Collected tag.
> v3->v4:
>  * Dropped the tags as it is a rework dropping parent node that contains
>    simple-mfd and syscon.
> v2->v3:
>  * Collected tag.
> v2->v2[1]:
>  * No change.
> [1] https://lore.kernel.org/all/20260524195829.960401F000E9@smtp.kernel.o=
rg/
> v1->v2:
>  * Collected tag.
> ---
>  .../bridge/renesas,r9a08g046-lvds.yaml        | 120 ++++++++++++++++++
>  1 file changed, 120 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/rene=
sas,r9a08g046-lvds.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/display/bridge/renesas,r9a=
08g046-lvds.yaml
> b/Documentation/devicetree/bindings/display/bridge/renesas,r9a08g046-lvds=
.yaml
> new file mode 100644
> index 000000000000..4cd7b688fbf7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/renesas,r9a08g046
> +++ -lvds.yaml
> @@ -0,0 +1,120 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> +---
> +$id:
> +http://devicetree.org/schemas/display/bridge/renesas,r9a08g046-lvds.yam
> +l#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas RZ/G3L LVDS Encoder
> +
> +maintainers:
> +  - Biju Das <biju.das.jz@bp.renesas.com>
> +  - Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> +
> +description: |
> +  This binding describes the LVDS encoder embedded in the Renesas
> +RZ/G3L
> +  SoC. The encoder can operate in LVDS Single-link mode with 4 lanes
> +  (Data) + 1 lane (Clock).
> +
> +properties:
> +  compatible:
> +    const: renesas,r9a08g046-lvds
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Peripheral clock
> +      - description: PHY clock
> +      - description: Dot clock
> +
> +  clock-names:
> +    items:
> +      - const: pclk
> +      - const: phyclk
> +      - const: dotclk
> +
> +  resets:
> +    items:
> +      - description: LVDS_RESET_N
> +      - description: MIPI_DSI_PRESET_N
> +      - description: MIPI_DSI_CMN_RSTB
> +      - description: MIPI_DSI_ARESET_N
> +
> +  reset-names:
> +    items:
> +      - const: lvdrst
> +      - const: prst
> +      - const: rst
> +      - const: arst
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Input channel, directly connected to the Display Un=
it.
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: |
> +          Output channel, directly connected to the LVDS panel or bridge=
.
> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - power-domains
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/renesas,r9a08g046-cpg.h>
> +
> +    lvds@108a0000 {
> +        compatible =3D "renesas,r9a08g046-lvds";
> +        reg =3D <0x108a0000 0x10000>;
> +        clocks =3D <&cpg CPG_MOD R9A08G046_MIPI_DSI_PCLK>,
> +                 <&cpg CPG_MOD R9A08G046_LVDS_PLLCLK>,
> +                 <&cpg CPG_MOD R9A08G046_LVDS_CLK_DOT0>;
> +        clock-names =3D "pclk", "phyclk", "dotclk";
> +        resets =3D <&cpg R9A08G046_LVDS_RESET_N>,
> +                 <&cpg R9A08G046_MIPI_DSI_PRESET_N>,
> +                 <&cpg R9A08G046_MIPI_DSI_CMN_RSTB>,
> +                 <&cpg R9A08G046_MIPI_DSI_ARESET_N>;
> +        reset-names =3D "lvdrst", "prst", "rst", "arst";
> +        power-domains =3D <&cpg>;
> +
> +        ports {
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +
> +            port@0 {
> +                reg =3D <0>;
> +                lvds0_in: endpoint {
> +                    remote-endpoint =3D <&du_out_lvds0>;
> +                };
> +            };
> +
> +            port@1 {
> +                reg =3D <1>;
> +                lvds0_out: endpoint {
> +                    remote-endpoint =3D <&panel_in>;
> +                };
> +            };
> +        };
> +    };
> +...
> --
> 2.43.0

Applied to drm-misc/next.

Cheers,
Biju

