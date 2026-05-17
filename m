Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFEA0CD4F4A
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 17:59:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66A3E10E27F;
	Sun, 17 May 2026 17:59:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Y8G7iq2/";
	dkim-atps=neutral
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazon11011048.outbound.protection.outlook.com [52.101.125.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4E9710E27F
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 17:59:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RRdlhd3luAJ72WNMkzkBo+ekiUYPt9mRQDtUO2LWLsiJEc5ZDSSS21GgyWR/5lFMFSqNp7RbuSdo9e+ZEJLYCzhUqdUAmzMQ3mExKVGoKB4+rPnbXvj/kafztl5xjFEaz+q64FClk9cw1yv3HHJfiLyHL2tRWOMRdsrxRZee8XYp2KsOBAgEiMGzGzBpujQ+fmGuX+rV6CJ59tZOI4JZ3Re9d0ubNvdP23R/jX/Qwk2UhhAYgc02Ri2s/TppuGwLDl/53NrCpJ/jJL6WxovF9x8ANdyN4mLFwoNW6POflAPEtF9sI5L6w7NTOFby2K7r+aivL52An9rK5zv11OOh6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VujkUuoirrpLohhZpmqOo9Ywjq+vULCF8lVMhbesnsk=;
 b=W7TLOYacji7fWYXREhb/xI0NVBd8YEAfD/IA6mT6vA/IpP6x6SzwwKf7/CvV1vG47PzwZx2DXJL/v8RAyK0PJOfy+PtZwpIjrzNpdP2rQ6Z28og5dhmVicl8bvu9epBXRY5BLDzrh6D5deP4JDboFB/6HxOrSo2lLXXogYIsR1ZJ0nDmq/Owt+OOXhcOM9aDPiRj+otQtIJL4VxO+NPKwE/2he8+d7bYeuYcn/z2e1IFXjrZACCEgGdbq82O2nCVeVS1flaJmOP7hAC1rMya4cyS+Gf1gOFrQb9Bot9HtlE1tLoXJAtYgcj8AAbgHjBSDGQrSnHADSIfd976A1sozw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VujkUuoirrpLohhZpmqOo9Ywjq+vULCF8lVMhbesnsk=;
 b=Y8G7iq2/nLFwAxCoFoGezo5cm9AFmhj47pHecKcEACYhFaJ67J2LxTRzKR1nHs4exBSOJx+VNbGhnZTmjElj16e9EtwGMl06QKzTe58rQeXijSWsilkVrTIIb2h29JKGVdAqKlGBys7lttMeuzLEez5U58GobEfDt86EAVAQTVg=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS9PR01MB16855.jpnprd01.prod.outlook.com (2603:1096:604:2bd::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Sun, 17 May
 2026 17:59:09 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0025.022; Sun, 17 May 2026
 17:59:03 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Prabhakar <prabhakar.csengg@gmail.com>, Laurent Pinchart
 <laurent.pinchart+renesas@ideasonboard.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Geert Uytterhoeven <geert+renesas@glider.be>, 
 magnus.damm <magnus.damm@gmail.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Fabrizio
 Castro <fabrizio.castro.jz@renesas.com>, Prabhakar Mahadev Lad
 <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v3 4/5] drm: renesas: rz-du: Move mode_valid logic to
 per-output clock limits
Thread-Topic: [PATCH v3 4/5] drm: renesas: rz-du: Move mode_valid logic to
 per-output clock limits
Thread-Index: AQHc4h12S/BvNeveSEeUROA0xwu+DrYShyGg
Date: Sun, 17 May 2026 17:59:03 +0000
Message-ID: <TY3PR01MB11346174DD5FFD70AB39F570086022@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260512144104.761531-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260512144104.761531-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260512144104.761531-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS9PR01MB16855:EE_
x-ms-office365-filtering-correlation-id: ea4a50d7-9305-4de9-852c-08deb43dfb4d
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|921020|18002099003|56012099003|22082099003|11063799003|4143699003|3023799003|38070700021;
x-microsoft-antispam-message-info: YrdcJFdK4DCpFzV5jlzE/mmTRkDHf5xczsGtCI267Fm1agp/KdISUpG+fyohsbe4izSGwxo/9Drzveg0VxxOzIKg4Wsz0GWR905r6WRihcyUfrpBwC3iNAmTZryw7sKAEXHHKa95ZzY/WSdhqpgdDRJd8ECxUDig1ZvYFlcD+ed2Tf4LrxXKwwOu1LwF0qsnXX/Cq78VsLzTiME/sxd99bVk+JBlw8MT9SnQ/nAOQRt9iVN9lSuqjUoRINOEZjTqbJqtFaQNcIYmVt0XZxa+QEZ49hvcVCrPHFlT4YYFP8jPUDqkeEypZ4gydv7/WzHBCXQ+J4CRJ7Sjpo+m+hlkhP96s83of5u+YmMkKViVQKHnZepxTJ4wKWCTjOl7HuMoo6p73jhaTfiWo4fKqkatP5UxBpbSnvwwoJfydeNEhli7rUsdZcwPQc5APZXaDuXyXXAHk+aEVXWSWNvvxSavkmfviRbwBa0tnq91Lx4rAZlbZqtC+q/B98oHTaqetcIOoY7QHVo513kz14YvTe1AkvRxNkb1Z+sMAehTn+Varf3P5UvByhpDoj+r4Q4bn10mw5fRDMfGDWZtf06tvno2OJE4WEj8r+tLudqjUtIA58+9aH+1oXOBoiOOz/7q5ytPhhr55IDhJzEDjGBHtgrCyxqwhNOGg9T4kna0HPSIsa25uKgvKJSokA42w+VwIGJ43Yaml4F2mrzc4eOEtl15baXU60Z+TO1zQhoPnNpcfNAz+P8/abQfVTH0iBqjDtdfaq3s6mtE+lb3zHkvtTdbqQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(18002099003)(56012099003)(22082099003)(11063799003)(4143699003)(3023799003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zL5aaWRaNPXezXgtEeaidyhP99gJYUp9OCcHMcQn8Udz42FLtszRQJYDD3c7?=
 =?us-ascii?Q?GRV/0Y2EpZR//IdlHmgTLV8epc6gLdidDpeVS8VQCCcDLlgvpPi679N05Nz0?=
 =?us-ascii?Q?JW9PEU84+J4r08KeWndTXenVxsv0lPu50+pDs89wGnHOXRsRooAubh0ynH6j?=
 =?us-ascii?Q?ughzZjKbiHx4ajA+HkZcz/YfChXOSg5QVF3PAT7mCEbnokHFJNQlEfsHITHY?=
 =?us-ascii?Q?b3sCaaLN+o6PmqfO1x9+R3/PYSXjDgHHoByRMT/LWby9VMl9jgBbkWPolquf?=
 =?us-ascii?Q?kl+0IXqdkKG9YRfDqUSEHeShy4n/sBXOrR3sWbo9pGnJE/vlyvkDRVyrQHMM?=
 =?us-ascii?Q?NZKUwx2vptxvTuSNXzUGiac2y9ohke8CDyUXDUjmPM76eRqv9FK+QxA/Cc6R?=
 =?us-ascii?Q?ieKa5invV4/IQCGsX2JFQ8C/IgvIfzE0cm5ucKnL6dT3ot0Gi2ujsOgFe0kw?=
 =?us-ascii?Q?u9M+FCraSQkSHpElGXGuASWZQK0hPrnwSUu4T+uXWfmWrSi0KPE6ejH7gXA1?=
 =?us-ascii?Q?mIXgfuLOr8Jvp2hr2dI7Tf77zmWt4NXFBIdYqbKhVZPkksS4eLbp3ya6lbhy?=
 =?us-ascii?Q?utXbL5yi25fPvyCJRfZAQclYvmmUxZuvfsgH8E2o8ZVM0gPMl8Sp8DDhITHh?=
 =?us-ascii?Q?ZYPNG2ahoeGJQ5h4JN6Gv066fEMpMXW5bC4G4w8auO36aPSoWMXbOXFp94oK?=
 =?us-ascii?Q?faX79clEWAfaY5yF0g5sWiApA6mFgKWKWE4jAH+tJ6Za9lHEtnFPgKPtyBub?=
 =?us-ascii?Q?O5wMfqpXtNi3lfNCBKeez6qnsPxmPCC98GAODR98gCXFFGrH4wZSNcvxTCqm?=
 =?us-ascii?Q?TXwMQvRWzlK01iBcN3DLqqj48NLXFTM64SjS9Hcm/INjN0+j3cVB7iINZROT?=
 =?us-ascii?Q?vFLqH7N7Vd/b091Ksg9GFkOuso4OanxX0MgDErvIPZliSSnIEMViYBTO6m5g?=
 =?us-ascii?Q?1a7xWe0NgC53/7XlmgLa0qxVKczKXsvYoCkQnCOblWSKRHaISGKG20VcGyxz?=
 =?us-ascii?Q?6YxnuHbOCDIhvsvECVq7tmbZJEFfscqHp8aXtMVdAQP3Egifhr4D6sMK1JsR?=
 =?us-ascii?Q?xMlYdiHhdVeiRBswSRTnCpSs+y1tX1ftC4tM+anyqS/uVNzeLqhhOa4Vx3Es?=
 =?us-ascii?Q?rLA3H3DzlVKhvzY/v4M851JgfPAxwmFG6oTXWfEAUhEQvn3B8jWFLoYTeBUo?=
 =?us-ascii?Q?/wz++lWNk6jDD3g5H9Vdq6RxQuMLHGpKCxAXjCn/YC065QR1SW773RA/Hnox?=
 =?us-ascii?Q?dD26nSS5ZEgRWfDyL3KWAok+wvNtXdZfHUbrlnuA1sc1Q6aCAraliKI5yibY?=
 =?us-ascii?Q?MsQN+xKBmxUDs4x+UTomd5zeFVMoK/yt6mrddUv5ETgPAM/xiN7YVvS9vc7S?=
 =?us-ascii?Q?TrHP8Pzwo4FAtdzy1Kfz+JLsuEaCR21XhbW8VXT8cyYflr/Ck9jKS9wyPjqY?=
 =?us-ascii?Q?i0tM2qO3qO4/k73+MZRJ7gHCI91TgZePP+Q1wzF/aZEPRhOUsVQW2NX/umHa?=
 =?us-ascii?Q?iebw4Pd8V8qfSCWGuoXZQrn3HUmFhbqsM1fSsrHjgtFXhz9gyWlEYEnaYxU1?=
 =?us-ascii?Q?Mzut/VuGvQSjvhEv5fQ0uUJrzKM30q270peQ75NlBJ47wogIRcjiHgIMl735?=
 =?us-ascii?Q?bBOqcAxC27NPTC5GU1MRkGUP9jJ341OcWHFBGLTWNnBwnglVA3rWxzzTMRa0?=
 =?us-ascii?Q?y1Ke0UVzTFVjQQWOTH4gRPayyZoxhTrQc0a5i2nDQEnhOob5Hi6+ThOl/mkw?=
 =?us-ascii?Q?udVakpvoTw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea4a50d7-9305-4de9-852c-08deb43dfb4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2026 17:59:03.5283 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9A+6EzvqzLo7IIj2/mEVl4Mae3wduoU/8ySNi1LWBi+qp9gYo77/DQec0xz8bNFelMRsZUQqXzkhRPytlEzlGPiDIJDwuVCIb3UjGMy+7eg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16855
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

Hi Prabhakar,

Thanks for the patch.

> -----Original Message-----
> From: Prabhakar <prabhakar.csengg@gmail.com>
> Sent: 12 May 2026 15:41
> Subject: [PATCH v3 4/5] drm: renesas: rz-du: Move mode_valid logic to per=
-output clock limits
>=20
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Move pixel clock validation from a fixed encoder check to per-output cons=
traints stored in
> rzg2l_du_output_routing.
>=20
> Previously, rzg2l_du_encoder_mode_valid() applied a hard-coded 83.5 MHz u=
pper limit specifically for
> DPAD0. This approach cannot scale across the RZ DU family because pixel c=
lock limits vary per SoC and
> per output interface.
>=20
> Add mode_clock_min and mode_clock_max fields to rzg2l_du_output_routing s=
o that clock constraints are
> expressed at the granularity of individual output interfaces rather than =
globally per SoC. Update
> rzg2l_du_encoder_mode_valid() to look up the routing entry for the active=
 output and return
> MODE_CLOCK_LOW or MODE_CLOCK_HIGH when the pixel clock falls outside the =
declared range. A value of 0
> for either field means no bound is enforced in that direction.
>=20
> Set the DPAD0 pixel clock limits for RZ/G2UL (R9A07G043U) to 20.875 MHz m=
inimum and 83.5 MHz maximum.
> RZ/G2L and RZ/G2LC (R9A07G044) share the same DPAD0 pixel clock limits.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v2->v3:
> - Moved clock limits from device_info to output_routing to allow
>   per-output constraints.
> - Updated commit message to reflect the change in approach.
>=20
> v1->v2:
> - Dropped storing info pointer in struct rzg2l_du_encoder as it's not nee=
ded.
> ---
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c     | 4 ++++
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h     | 4 ++++
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c | 6 +++++-
>  3 files changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu/d=
rm/renesas/rz-
> du/rzg2l_du_drv.c
> index 0fef33a5a089..d1bc205eb5f8 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> @@ -33,6 +33,8 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a07=
g043u_info =3D {
>  		[RZG2L_DU_OUTPUT_DPAD0] =3D {
>  			.possible_outputs =3D BIT(0),
>  			.port =3D 0,
> +			.mode_clock_min =3D 20875,
> +			.mode_clock_max =3D 83500,
>  		},
>  	},
>  };
> @@ -47,6 +49,8 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a07=
g044_info =3D {
>  		[RZG2L_DU_OUTPUT_DPAD0] =3D {
>  			.possible_outputs =3D BIT(0),
>  			.port =3D 1,
> +			.mode_clock_min =3D 20875,
> +			.mode_clock_max =3D 83500,
>  		}
>  	}
>  };
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h b/drivers/gpu/d=
rm/renesas/rz-
> du/rzg2l_du_drv.h
> index 58806c2a8f2b..307ae70dd382 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> @@ -30,6 +30,8 @@ enum rzg2l_du_output {
>   * struct rzg2l_du_output_routing - Output routing specification
>   * @possible_outputs: bitmask of possible outputs
>   * @port: device tree port number corresponding to this output route
> + * @mode_clock_min: minimum pixel clock in kHz
> + * @mode_clock_max: maximum pixel clock in kHz
>   *
>   * The DU has 2 possible outputs (DPAD0, DSI0). Output routing data
>   * specify the valid SoC outputs, which CRTC can drive the output, and t=
he type @@ -38,6 +40,8 @@ enum
> rzg2l_du_output {  struct rzg2l_du_output_routing {
>  	unsigned int possible_outputs;
>  	unsigned int port;
> +	int mode_clock_min;
> +	int mode_clock_max;
>  };
>=20
>  /*
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c b/drivers/g=
pu/drm/renesas/rz-
> du/rzg2l_du_encoder.c
> index 0e567b57a408..4af2ae09ff39 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
> @@ -50,8 +50,12 @@ rzg2l_du_encoder_mode_valid(struct drm_encoder *encode=
r,
>  			    const struct drm_display_mode *mode)  {
>  	struct rzg2l_du_encoder *renc =3D to_rzg2l_encoder(encoder);
> +	struct rzg2l_du_device *rcdu =3D to_rzg2l_du_device(renc->base.dev);
> +	const struct rzg2l_du_output_routing *route =3D
> +&rcdu->info->routes[renc->output];
>=20
> -	if (renc->output =3D=3D RZG2L_DU_OUTPUT_DPAD0 && mode->clock > 83500)

Please retain the check for DPAD output, to avoid checking the same for DSI=
 and LVDS.

Or=20

Maybe add the below check to skip for DSI and LVDS.

if (renc->output !=3D RZG2L_DU_OUTPUT_DPAD0)
	return MODE_OK;


Cheers,
Biju

> +	if (route->mode_clock_min && mode->clock < route->mode_clock_min)
> +		return MODE_CLOCK_LOW;
> +	if (route->mode_clock_max && mode->clock > route->mode_clock_max)
>  		return MODE_CLOCK_HIGH;
>=20
>  	return MODE_OK;
> --
> 2.54.0

