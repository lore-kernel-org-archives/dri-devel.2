Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26EC0C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 13:17:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 779B310EE7D;
	Wed,  5 Aug 2026 13:17:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="TRp3rYvT";
	dkim-atps=neutral
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010019.outbound.protection.outlook.com [52.101.228.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 646BB10EE6E
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 13:17:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OhmHkemnntzXeYz5nhPTMDHJaVwOMwSnF1HGCpgYjRJoZVJXLC+gULywW+E8XhlM4PfZfsHGJEVB7W3ysobMvtmraE0BvxoyloUz6siuO4XXQ70eYZu++T1wHIkOPQ+AsS2IbOJa/mwnJfaGhz2LdY2fgX+GHDImFQNLmr+f74XRxzbBmbQZ95Ly+j7b/k6JQRKySn/+K4oEEhJe7fEx56ROqx0SKYaKvKD411+yzDjcuPsZ5EDDs9DdhuSZsWs7czpk3Q+cGg1ZdPQ3tLcDuJnWZbgN18WBA1u0eUsNOFMGwB+jlUs0cFb5zXELOOI8xXcnvwzHl6vg+BCDM77dhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMqlbH0nj/KQ3k4R/Jb3R7ejGD3l4Nm4wgZmXQ2+Dqo=;
 b=pz1MQ8Hpiq2/MX1vErPkOsMPibRZ1zqYt2tLkMw+L/TzKhFD5T+VQcn2uu3Yrs+B761aFhgyNA1RrKdltT6Elw0q7nqZOUvhDktGY14mZoyAszworCifJXOlXGiUA8hSXjvmFzCFOF7Gs3gF5SyMKkq0PRlZO39h+wYMNzBBDhcKVDxo6H2ax9kzLtAs3ApwQ3SMMXTUh3T1GJo50tZwd2gaNEl++/j4rZeG5RgXTjqZfbcXUBm2WQANepT0e/cMT1KJ+WjeRhUN7qKcRLPHwhagEf2eGxBtJF4/tx3Gbre5FailzHS13GB67kV3nnaO89tmOl8Dy/pxkFYL3Ve5zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMqlbH0nj/KQ3k4R/Jb3R7ejGD3l4Nm4wgZmXQ2+Dqo=;
 b=TRp3rYvTwDPjaHjUkim+ZZYClU2nLDAZdJuEqwlZ8BcfpggU+Cqw9w90Bb/uq219mfe0zvHfQdXOCnRCMspLPLVaLMDM/+e3yUYg2OKhoPdwp2qPtyPkyggMJcV1nE1PrQh8tScC24n4K7UBc5RcGmnQyj9G31rFJix+TCGlSOk=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB10297.jpnprd01.prod.outlook.com (2603:1096:604:1df::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 13:17:14 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 13:17:14 +0000
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
 <luca.ceresoli@bootlin.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
 <linux-renesas-soc@vger.kernel.org>, Prabhakar Mahadev Lad
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, "biju.das.au"
 <biju.das.au@gmail.com>
Subject: RE: [PATCH v2 01/16] dt-bindings: display: bridge: renesas,dsi:
 Document RZ/G3L
Thread-Topic: [PATCH v2 01/16] dt-bindings: display: bridge: renesas,dsi:
 Document RZ/G3L
Thread-Index: AQHdH1mIt+JFIeI0HUuTuwuq/ag4gbaPecJQ
Date: Wed, 5 Aug 2026 13:17:13 +0000
Message-ID: <TY3PR01MB11346D4BDA3C9F15B564F1C1986D32@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260729125516.230757-1-biju.das.jz@bp.renesas.com>
 <20260729125516.230757-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260729125516.230757-2-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB10297:EE_
x-ms-office365-filtering-correlation-id: 32fff7da-5f72-4976-970e-08def2f3dd86
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|38070700021|921020|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: A7oaJyu4JMcomWaxnFU8UjzZ7pt7uRuLb1e+vdoxuaqW2Bj2IBE2kKZc9yZrVI0kw3JanT7uLjqOAiZIv2+JbnBVnVVJZhYN408krNAb9id1h5v93NO1kHK7GkrJrtw0uxDrBbH6Ib7AS7KIkMdpVAdGWBONjdGU3HYCxcOCzncJwbxFP2Hvd3ZRzFbkB16H2ICB7X952sRFoonioSt44BFfvGZbPIifrgP3+X2GdJHgN0J36LgeoRmarBWZrB+NBx8EksTYxwNYas/0/LJnoNLA2jPNlnmq1XUBfmWZARmmu2WPk6ZYeZGJRxi9QMroBb63zN9AhGTPHcsQ8Kdlu2RvNyiNvNAg8XI2hPeloEdgFAOtjJ3j0T9hQQ3XRJxmLK7fYoblX03gKXPNFjXA5WYKU9LdBFmYpFVvZ729LpdnqNkOJUKx4m0+TGZVVQRFN6odtQNYuPg655AFEY2Su7lZVwQWIn65xfgjJUYFbZmS2XUmtV+GoJEMHHUFsPIx5S9Bvw8hqDnoJzL5/V3h4pca+qhkiiscZrDCb5QgJtx41I/7FQC2TnFMuR+bFltOFfwJKo2OUEQhlFjH1orInLrF6aVoykBRFAJuXtvaDOoJQ97+ecI2/jBEvpxUKkVdzOT99HgQLOG9l0+IepBpyVAEr4s6Zqo+3AFmGne3HfGTwUCxLu/iVCKl4WMYmjZ7jmusL9deHHkYQ5ca1SwsxikC1mEa89sS5mIKTAdl5N4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(38070700021)(921020)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FbnDbVhIKQhDW/NlsLpM8qSRUqtjCy94igFcne6674uKt6B5AV/awRZDh6rB?=
 =?us-ascii?Q?ZWBLHZcddZdp7BWBc5m8mKM5G9J5NmuDHESka4szdFI/vEMrX8jCyvhnQehg?=
 =?us-ascii?Q?t94kEkmMk5hQmHBKZsvJ4KqnMd2Jkuk1Jv+14jsJhrIr4nz+Xq9tFa489VLL?=
 =?us-ascii?Q?ZhjzcwK22NdNRTFlwB7djGqbSrHruw2z9haGbCOD2Heilc3BoNB8OpmZbQrC?=
 =?us-ascii?Q?quQtZ6/SfZTjQZfdu+f7yGZdjYstgmpyNO69ys5rlH0Lb2E3xPRzsnOA2lN/?=
 =?us-ascii?Q?BZCkk2AK+3LHeEbQ3HBYcQHV/OAnzgDnAjX3tbXs1XgitnhMbKk8A7wNDU9P?=
 =?us-ascii?Q?1EmW3CuTJ8Z7/GcZsJRFGleTZb4yJl/fYfQySeIMhgPKl7V0IC5sSQzJsPDM?=
 =?us-ascii?Q?09YeP8r39I4rDP7BJbEtzhePOtNbsInKjE/Pc63Nd33L5QItUZjmhBvV/gsE?=
 =?us-ascii?Q?/9SbKHzWphjfhlXzQ0IXPTUKGRzOXc3AyZAeHxrbIRwmCgbzybHe2/C5mMFo?=
 =?us-ascii?Q?ErkuZ+HPQotUf+8dxLm2/NbD12AO+pmMcY+DCFf4B1+v03MhVTbtmcv09Nw5?=
 =?us-ascii?Q?gl9K7tZyCDXIVWO81dT0fyhwoGmV9/NffRK362Xq0HF54SE4Jx9I8k/OyM6h?=
 =?us-ascii?Q?RuxyV0qy/CrCamjZjZBhWKLhap5a2oKJhNSTclPRuyBNgIRdmAg313/4wuaP?=
 =?us-ascii?Q?ClOac2/JUHE4qGnvYHl8T/BzYe0fXWBLyfjfnBkXZ0KqvohoF1WdZ71iXGZK?=
 =?us-ascii?Q?/T+OSr15F0g9vQo7tUvsx2TwXljDO9C1H/2PDs+D/oHnmBq8/XV5OG/hu1B+?=
 =?us-ascii?Q?HN82lJ8v7jH+kKgP/4v/kWudz1GJC6hnkULMo7sRvgEGQoKDmES+PBRUTZwG?=
 =?us-ascii?Q?llxi4ta+VeQxBDMT4d0//UdonlWPH1EcKMNijBW2KtJVmTeKGIAWR5yKAcmS?=
 =?us-ascii?Q?C0ewkWKb0EXY9/J0d0PAuwJM7ZzAfaVPuoSQstkMmVt7FRJx1ZMUavvswxPP?=
 =?us-ascii?Q?lIQ3BCcpOGEwV9PoepJzogIW7T+rovxbKG7YpdFD2pM6rlfVR3i1gsrQVbaW?=
 =?us-ascii?Q?uAf2yH+dHdyoBRWIrxHjJ5boICVpVm8MQ5icMNUK1ZIjwoGmAu4L+iVKZ/iw?=
 =?us-ascii?Q?iQPKY73Ew22bHGVZT3GdXA/4XsPMBOgQ7+2YKoTxGorCM18LEq61n//7yRKf?=
 =?us-ascii?Q?53DRmev0TyH7VqP+W17ldqAkRPzq9FeLJRDg5H0awXJD9Mk7Xsw3XOuypTHP?=
 =?us-ascii?Q?rci+1U383CxQc7NawUpflhtqHZHXUNOa+P9N46lpqPWG8mIUHWbg9TbXXA3P?=
 =?us-ascii?Q?9z4sNTNaBTGXx3+Uj2PDayEyc+KJbfo/lXyKXLE/swvIKhInFdksePcWPadG?=
 =?us-ascii?Q?vw3vuLQQiTNJcCUd+5cfvEmCQsnYAOKeHUeUP/3fwUYhr8dbRkWJdSWpAisn?=
 =?us-ascii?Q?NFze/7/EukHxwOvjRqLiv2y1+E/QSk5WlEX9+h1117YPe7aEHwsv+3TgwTDK?=
 =?us-ascii?Q?z3biM3S/eC1APKCdNrM4MU72o4GZhEmyYXoWrTH3znEcGM0Meb/7ED2bSPmR?=
 =?us-ascii?Q?KYxLPrke6qdiKZ8PVPEXmaIf3NINYj2VRPVyA+/BjZl704jbEUgM23Z3j7HR?=
 =?us-ascii?Q?zV1ZfV2UpC07KNwgsEUWlc6RRuWJYTtOtjbTtW6qItJmpOzlngFvMcHar7L0?=
 =?us-ascii?Q?v3lSpU7mG4SLQwl6NT3ReK+eII/hNxa5yBgKRIPV/qo+MY+mIHziAIsI22si?=
 =?us-ascii?Q?wHJ7ghTpgw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32fff7da-5f72-4976-970e-08def2f3dd86
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 13:17:14.0320 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z2TCWC2ESJOVG/EHI07vahqx2PCZpzbBhq3Z1AVrmR6BieOcqSXegaHV4nj+ea8Z9PSkMp3qhF+2LWRjWmGhLbgZL7Dhk16cwJi0VqNv/Y8=
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

Hi All,

> -----Original Message-----
> From: Biju <biju.das.au@gmail.com>
> Sent: 29 July 2026 13:55
> Subject: [PATCH v2 01/16] dt-bindings: display: bridge: renesas,dsi: Docu=
ment RZ/G3L
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> The RZ/G3L DSI IP is similar to the RZ/G2L but has different global PHY t=
imings and also the PLLCLK is
> ungateble clock. Add the compatible string "renesas,r9a08g046-mipi-dsi" t=
o handle these difference for
> the Renesas RZ/G3L SoC. The power to DSI region is controlled by SYSC blo=
ck.
> Document renesas,sysc-pwrrdy property to handle the power control.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Dropped renesas,sysc-pwrrdy property as it is modelled as power
>    sequence.
> ---
>  .../devicetree/bindings/display/bridge/renesas,dsi.yaml          | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/bridge/renesas,dsi=
.yaml
> b/Documentation/devicetree/bindings/display/bridge/renesas,dsi.yaml
> index c20625b8425e..3832a553871b 100644
> --- a/Documentation/devicetree/bindings/display/bridge/renesas,dsi.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/renesas,dsi.yaml
> @@ -28,6 +28,7 @@ properties:
>            - const: renesas,r9a09g057-mipi-dsi
>=20
>        - enum:
> +          - renesas,r9a08g046-mipi-dsi # RZ/G3L
>            - renesas,r9a09g057-mipi-dsi # RZ/V2H(P)
>=20
>    reg:
> --
> 2.43.0

Applied to drm-misc-next as the compatible used in power/sequence driver
and also, for easy rebase for the RZ/G3E DU series.

Cheers,
Biju

