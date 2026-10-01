Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE50CA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 10:56:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DBC310E063;
	Thu,  1 Oct 2026 10:56:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="fhD3kAlR";
	dkim-atps=neutral
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazon11010011.outbound.protection.outlook.com [52.101.229.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C35D510E063
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 10:56:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOwX2mYiT+T3ON9/y7xw86+TfPR5/xcJcVEc1ZdfG6BhjNaEWutm4/W6JLC9lQrgcNZSjU2BBtypZaeuBASBZZL23uoXNeyqjW6tY+hL3qp4BofVEi6VK1Kyd5JiU0/WYMV9Bh/dPIKyShUrgqbl/h7riBTx7ilLEWb5VG/GT82KteWA0EAabU6vUgdvUrkizaXHCEhN0ovNNgXo1gF0cTu/OIZMeKOB5+Hr9B6aFGS+M0xXvOoTFBFn0XtLQ5IHyA+fINz5f5+hqwxQg9WW8YcNhSbuZBx1Kx1fA9dQ0XBiscrrmmt2RFSDYrh5SkTmJ5vIQrTtL94zVUIthYadAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqqBuEWcTxhjtjSU4S0TREMb8anPcvdIBEYdQIHT6g8=;
 b=r+qQZTCBCa+X3rr0YNtdQxsYtmDq23b85YsVAmgXuYnQXMNo8pZXWSQ53C1UsIO6o9MuqpvyCRyE46efm/uvvDLZ+iV1JwFXX+l4zX1UVVuWMO0pSoMpI+/2YC78HHcWB+GJ/IQKMtq99SyPXu1X+mWlt8IXt8aXbVTl1C7f2xw8wckNEts6V+DvEVNDnd5eEoP4zACLwuiGWiiWrge1GSZU3qeq9k3cSnniWiFnmL5jBeaZ2eUyoh8vSFRKMcKoBoc7OyqI/BuDSs1STIF/AH30nDqF4nCRWvyk23BoIPFXJ/K9Cd/Rt76FhqzxH94WHR+PXdXrH8nGHrfqmkbfsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqqBuEWcTxhjtjSU4S0TREMb8anPcvdIBEYdQIHT6g8=;
 b=fhD3kAlR4naWdCmdBtzvVQy4Sb7jgjAORdtrHANy9GzNKHF+go2oJJrhC6l6NCzUk7u2Hd8Bult39HPPGAS3SJYUz9jUEKoqWzLxOrptNdyyJzSg5936PtjK78ZuU158MpM8qgx44gODKoudf1/nMXkt/9OE6DX2H0rJqBu5eVY=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYYPR01MB12418.jpnprd01.prod.outlook.com (2603:1096:405:f8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 10:56:37 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 10:56:37 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "biju.das.au" <biju.das.au@gmail.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, Robert
 Foss <rfoss@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Philipp Zabel <p.zabel@pengutronix.de>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Geert Uytterhoeven
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
 <biju.das.au@gmail.com>
Subject: RE: [PATCH v5 0/9] Add support for DU, LVDS and DSI on the Renesas
 RZ/G3L SoC
Thread-Topic: [PATCH v5 0/9] Add support for DU, LVDS and DSI on the Renesas
 RZ/G3L SoC
Thread-Index: AQHdUYjx9uHffJnf20W6dhJCyerXp7bog3uA
Date: Thu, 1 Oct 2026 10:56:36 +0000
Message-ID: <TY3PR01MB11346526530C7998D0FDEA560868A2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20261001094041.135697-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20261001094041.135697-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYYPR01MB12418:EE_
x-ms-office365-filtering-correlation-id: d5ae6c2b-49e9-4d3d-4fff-08df1faaaa60
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|38070700021|921020|11063799006|56012099006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: iUNlFvvhNa7ZXx5A3xeW9b/7YCUb0eCVzYQ7nkC/+qXQHmduxuV1l88iywpNT09t3ldwGqhDjRG66k+ioqFxWQDlrWjiri7wBFoEy1E+r/bYQ97SfYzc/boNbdM635r0g7Ufs8ilB10D2O8kiIxA1klCeW6LLMCHrbLqM0IXUbwNQY1iFB4yUGjvDPSMjuM8jdGBdTotpFcIHsl6UJYGX7MN1IlTcCy6humKy1OkXNAcSgAVh7ODO3pvU82KTguuqrcnDDgnLaOQkAZzpfawcf74kQ6EZbSGRGTd/nyNgSpJnRJBDXPRKX4zqXdBjuCzr50BPmDmLM5EW6SPXeEv//uQhdGQDM3IOxnUT1q3oSRkxFzx7Gh+O9qBkMuMl+XfonuWx96Eb8emVj4I7Abxe08fVtSw4yksvU2KZpFL3EN6C9kHPRxNatEz4Vh/k4ySyxY6h+lYkTD9bav+9/btXzSSNOT44zz+sMA190urdmJkUysbsQU1t4JrDqUE9vSaL/utrj3t+CKQyICUEbrpUYydXIg6Xfw1WOexdOVZ78Iu2A4cXYNHKo+m2kG7EB9R9YFr4dxpaOmj0lF713JPo1jje1jTTJ+bl1TgkuYu94bF3s+lQ98bSQ0AJ7jnv2ieWXMeGTqdpwskwD/6+f2LldtjR0xjM+kb12IK+LLu1E69lXgRlQ0b9UEcjIQh7zfTM3LLbVZc2PR07OFucj3JaN4t6L4Hv5IXzZOzwKj1MgQY55kCOV0c/CXnLfFfIGcv
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(38070700021)(921020)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cXPrE/rDxnXIDzx4k3ctqyijUAPDRJgWDaPbtpnPK+VvCW+EK3rpCiUHM6JA?=
 =?us-ascii?Q?iQNjsFnnEo4aWIMl/r1fo+XKiw4L7tM5g2IqV7X9kyk/THOpSt9kN/wv8hDF?=
 =?us-ascii?Q?ChapHedvRNU2TY6cttR4Ni1PFY9MH4n66KVEnioAkExQfWgnJuxHP/hFLu4b?=
 =?us-ascii?Q?9DO+Zk3GETASSU+xQoTnRj1gp9HIrWS8AfBMSdfQSD+RN9xkqLT77TTjIY28?=
 =?us-ascii?Q?uvm7FlN59Bu1vfpewLRasUlTzuriOrEzgSFhZEImggYPbC8RoQAm0HY3fzHG?=
 =?us-ascii?Q?hsdMr+jl3XjptvVpEdpcC9+xw6B2e58UiBaIT/8Fxczq6regVaYulPcC58yr?=
 =?us-ascii?Q?4kNXpQf0A+dTb1iyUKJbWG7SyDx0lgZcu4YbEQR/3D3O3AU2ClHjX200ONDr?=
 =?us-ascii?Q?a4aiecRlYkoQ+GFp5SHFFF5NtjzExCm0M1KDXI+wBsK1XQ8m/+a+17JLyIrU?=
 =?us-ascii?Q?KsXavPJSDb1MRU/O4rDnqu15cKmm4xQlSY05F+lusH2LGakiN8F7MI0qEMeY?=
 =?us-ascii?Q?OFMROyLViieXhuO6KfF3N1idnFpYQ14cAEWjNVO0fGOI3tK/bx/ySihRx6Ad?=
 =?us-ascii?Q?+zPva85zV8D+zKBMbTYIuqdGzkYadY7kusEXBmd4K0lp7KAP4k4PtN2925eL?=
 =?us-ascii?Q?33N9R+tUwulyFGZN2fL5HnBDXHZs9nNbHNRkaQI/VtV5WUSMrBCehg8Jt2LD?=
 =?us-ascii?Q?q+FdJpSolOKGDJ07Xbgyo1smaQuplemjB6FVhDcQK7vWDwuzizUJJvmjZy5u?=
 =?us-ascii?Q?YY7SU7stF8FQffcqbqu0tsX0E6Fd48R3hOdbcZlngdrB3YXg5aXNeNR4jlk+?=
 =?us-ascii?Q?wpObYZ2kV1J3hzarEqh22scWqOc4p5ZVzH724yyvb7y1mbjMEMzcS0fJtLDx?=
 =?us-ascii?Q?rHsWwwR/uJL27r0ynJiG7O+dxdZFPF3LnQ0vztVI7dNhsJztT9gUvGVXEiXG?=
 =?us-ascii?Q?TuHbtpCqroV5+7vq20XMKQGZnNXQzU986gn8Czrrj7oevVwgMOAUVM8jLISv?=
 =?us-ascii?Q?srEaZOH/FrJAl0HXbj0mQrnpp4Vs0Jl4aJzZLF2zhdOgMtahgnoh00DQBs3y?=
 =?us-ascii?Q?ROWmAQN93ixjJyM7dkXbnVhKNyk3fSrV2AvuReuJn033qpYsScDQAVSOY6HY?=
 =?us-ascii?Q?M3/jVPjh3xk3tU97EhEYb1lqCDt0w7CAGv+qosg+e7xxQbmam2Ft6t5KgCNW?=
 =?us-ascii?Q?OYYuGb9EItUh8ID4ZIF6hrkuVJvqsBRnRM5wMumvP/fZ9P9wxiypHPgS1V7x?=
 =?us-ascii?Q?/2BwBtBjRlDoi0d00Tfw/aHDPr9AdIKDMvJd/gX8pL3No7xT85IE/M2ne9Aq?=
 =?us-ascii?Q?E2ISU8/5v0mOX9ArWFpB88CPcV5WZI21ggU2ZSQRlrl99JstM5MERylZMJew?=
 =?us-ascii?Q?d/pDlPxa0rIHqiJx6yE2/Ta2Mr1R4MB8AQ2XyedM48WShofAENKZTOmqH7WS?=
 =?us-ascii?Q?l+1JXfbZccMfjTp+jF+bjTcfQa8qVkYHQ/1iwL9iPkMWjVs1AUs0wpe16lFg?=
 =?us-ascii?Q?RZt0YVPMcMN3Wspxbgd7vIFKtsgXZm4UbR8bg1y8/aX5XGibwd9auuVTGDkS?=
 =?us-ascii?Q?OZx6tNUfieycNNg5SEWAi0oUn2CvQNogLGb0bQQ48aJxn+T2CXh8pa/R0ZCO?=
 =?us-ascii?Q?NEUhGDlzbaQkEijgr1s9opmEb6KyMGamL+MxPvANzcMpUI/QHVdAoimuwpfn?=
 =?us-ascii?Q?t7G9fl7/qiR4TgeUzWqRr1egvWL5x218ciIRglaShajX9GUAZEtPPI2HZi9k?=
 =?us-ascii?Q?TiBRMSRZaw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ae6c2b-49e9-4d3d-4fff-08df1faaaa60
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 10:56:36.9519 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9JBgsXPDpyFB0p4sNF8xGWHXElGO25XUJR9K8/XeV7rQdSTLbS8I944OTul3AlouAfDq4NQVshQylm0FCN575DzliJMd14xuYHIXpMWYtfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12418
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
> Sent: 01 October 2026 10:40
> Subject: [PATCH v5 0/9] Add support for DU, LVDS and DSI on the Renesas R=
Z/G3L SoC
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Hi All,
>=20
> This patch series aims to add DSI, LVDS and LCD support for the RZ/G3L SM=
ARC EVK. The RZ/G3L LCDC is
> similar to the one found on RZ/G2L, but has LVDS support.
>=20
> The LVDS series [1] is merged here to get an overall picture.
>=20
> [1] https://lore.kernel.org/all/20260625172359.292631-1-biju.das.jz@bp.re=
nesas.com/
>=20
> v4->v5:
>  * Collected tag.
>  * Restored mode_clock_min to 5440 kHz.
>  * Replaced static resets array in probe with global resets array.
>  * Updated rzg3l_lvds_atomic_disable() to fix the
>    PM_RUNTIME_ACQUIRE_IF_ENABLED guard that prevents synchronous suspend.
>  * Updated rzg3l_lvds_atomic_enable() to fix refcount underflow in
>    atomic_disable due to early return in atomic_enable.
>  * Dropped dotclk from struct rzg3l_lvds.
> v3->v4:
>  * Collected tag.
>  * Dropped pwrrdy variable from struct rzg2l_mipi_dsi_hw_info and instead
>    using feature flag RZ_MIPI_DSI_FEATURE_PWRRDY
>  * Dropped rzg2l_mipi_dsi_pwrrdy_off() as it is taken care by
>    devm_pwrseq_get().
>  * Updated mode_clock_min from 5440->5400 kHz.
>  * Added resets in pair for simplification.
>  * Added comment in probe() for asserting resets.
>  * Updated commit description for patch#8 and #9.
>  * Updated license header  for patch#8 and #9.
>  * Added HDMI audio support.
>  * Dropped reg_1v8 and reg_3v3 nodes as they are redundant.
>  * Renamed it6263 node name from it6263 to hdmi.
> v2->v3:
>  * Dropped binding patches as it is accepted.
> v1->v2:
>  * Dropped renesas,sysc-pwrrdy property as it is modelled as power
>    sequence.
>  * Switched to power sequence for handling pwrrdy signal.
>  * Dropped header file regmap.h and mfd/syscon.h
>  * Added header file pwrseq/consumer.h
>  * Replaced syscon_field->pwrrdy in struct rzg3l_mipi_dsi_info.
>  * Restored ports in DU bindings.
>  * Replaced endpoint with port in ports node.
>  * Dropped the macro RZG2L_DU_FEATURE_SMUX2_DSI_CLK and RZG2L_DU_MAX_LVDS=
.
>  * Dropped the variable rcdu from struct rzg2l_du_encoder.
>  * Dropped the variable lvds from struct rzg2l_du_device.
>  * Dropped renesas,sysc-pwrrdy from dsi node.
>=20
> Biju Das (9):
>   drm: renesas: rzg2l_mipi_dsi: Add dphyctrl0_init_val to hw_info
>   drm: renesas: rzg2l_mipi_dsi: Add activation_dly to hw_info
>   drm: renesas: rzg2l_mipi_dsi: Move global timings into hardware info
>     struct
>   drm: renesas: rzg2l_mipi_dsi: Add support for DSI PWRRDY
>   drm: renesas: rzg2l_mipi_dsi: Add RZ/G3L MIPI DSI support
>   drm: renesas: rz-du: Add RZ/G3L (R9A08G046) DU support
>   drm: renesas: rz-du: Add support for RZ/G3L LVDS encoder
>   arm64: dts: renesas: Add DSI overlay for RZ/G3L SMARC EVK with ADV7535
>   arm64: dts: renesas: Add LVDS overlay for RZ/G3L SMARC EVK with
>     ITE6263
>=20
>  arch/arm64/boot/dts/renesas/Makefile          |   6 +
>  .../r9a08g046l48-smarc-dsi-adv7535.dtso       | 138 +++++++++
>  .../r9a08g046l48-smarc-lvds-ite6263.dtso      |  86 ++++++
>  drivers/gpu/drm/renesas/rz-du/Kconfig         |  13 +
>  drivers/gpu/drm/renesas/rz-du/Makefile        |   1 +
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c  |  24 +-
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h  |   3 +-
>  .../gpu/drm/renesas/rz-du/rzg2l_du_encoder.c  |  24 ++
>  .../gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c    | 162 ++++++++++-
>  drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c    | 275 ++++++++++++++++++
>  .../gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h   |  25 ++
>  11 files changed, 749 insertions(+), 8 deletions(-)  create mode 100644
> arch/arm64/boot/dts/renesas/r9a08g046l48-smarc-dsi-adv7535.dtso
>  create mode 100644 arch/arm64/boot/dts/renesas/r9a08g046l48-smarc-lvds-i=
te6263.dtso
>  create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c
>  create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h
>=20
> --
> 2.43.0

Applied patches 1..7 on drm-misc-next.

Cheers,
Biju

