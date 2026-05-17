Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75AA9CD4F47
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 18:30:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF40210E2B0;
	Sun, 17 May 2026 18:30:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="I40+Fw35";
	dkim-atps=neutral
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazon11011024.outbound.protection.outlook.com [40.107.74.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C53410E2B0
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 18:30:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jCndcWEBNRIYm5znwkK2L9gGoX/1HLIc2szpv20yrmXa/1NkjtAt9KPCADD3XZdUsc2oPdwFTiS3rhax67gNbMzBJKmmVE4AqlZWpq1h9HUvP3ZHXyGRTrnN8C5wnz46KAUb7ypN++ku5sqxYdZDPvBXNKsqmznM6npMN9lDHmfN/SSuVAFLDeWBe8/70jBz5ry5WobLutJ0haovUd5OlaJq04dbXoancCD9+Zp+UmJhQ8bxhmmoZVKygMeEl8O88qTa0mIcuZJmI6IiG76ZtZpoSiOnrswONo4x4N2LRux7qdr2Ir2ZSgMKhJvxlFfQmxhm1Y+2n/dT6wZbEk4/rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJxBqlVT8Qq9bhPgEJok5tRSKL7umh5El09ODjG9Deg=;
 b=nvGX00ZyY2EHgcrCK7zrZo70vXAg5dNA75KNBVTP/Z5LObOtarl5Em1clOqK6Uo5n0qduVOa6us0++I2Z8CfXuR8W/S4p8ycZBlp9/MXDp6IlRTgiMyglUUTWAIwKouuYXl6ac/se/+HBU4bHqKTDm+7VQ8BivMA37euLTJA25wQ9DWVNtGfC5Ib/5P+FSfbInFmqa1dkoBuoby9XWp6meiVM/5hjVrprNt/VLr5G6+ZLASZ1ZjcFhA1Wqt29aeYyA8exUhkdD6Z60BTIC3DLauPHMh8ZSXrzEtrsQBVz3J6jkGvxcFMz+WOHUeqzR5PjafsbCve6M9z8udGYQ5H3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJxBqlVT8Qq9bhPgEJok5tRSKL7umh5El09ODjG9Deg=;
 b=I40+Fw35NjL6qCWSUCVS5lui52lpb9Tu92qUWaPmqWaG5Ipi3YpjMxJoyEDVcfSlGELMX5zfyx+UnKfudDz6rK5BMqoj1SP/chD821cRhKt+01qgePp1eLHET2gVKXWoZe9vyBUSSHWipYQUVNAndDcdCtAyvPIUWUqPqXciYA4=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYRPR01MB12725.jpnprd01.prod.outlook.com (2603:1096:405:1b2::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Sun, 17 May
 2026 18:30:15 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0025.022; Sun, 17 May 2026
 18:30:15 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 tomi.valkeinen <tomi.valkeinen@ideasonboard.com>, kieran.bingham
 <kieran.bingham@ideasonboard.com>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>
Subject: RE: [PATCH 04/11] drm: renesas: rz-du: Switch to new VSP API
Thread-Topic: [PATCH 04/11] drm: renesas: rz-du: Switch to new VSP API
Thread-Index: AQHc4aHYFosoVQaP6kCr3S+Hcm/SQLYSknig
Date: Sun, 17 May 2026 18:30:15 +0000
Message-ID: <TY3PR01MB11346319648FB960CA238884C86022@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260511235637.3468558-1-laurent.pinchart+renesas@ideasonboard.com>
 <20260511235637.3468558-5-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <20260511235637.3468558-5-laurent.pinchart+renesas@ideasonboard.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYRPR01MB12725:EE_
x-ms-office365-filtering-correlation-id: 18880097-c198-4186-9b14-08deb4425730
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003|38070700021|4143699003|11063799003;
x-microsoft-antispam-message-info: 9bjxGyUwLEjraGAfUON3NYxKZDgCxNdi5fERrPNuHZjvJ3POtUnEba3QuGVlPWP/ROl6/CdX/BGMHesvChoSi1d+49/+KdC6OIvvIZs8F3+joF0KifSuB0sqhQWkIlc517DyyYtmCmIGM5CGPvFWl3VosW9N2U+jnFN5IEm9GVOEgIp3qAT75QArJ2dmb3Z+4aSanRaAhr3i1QuCNBjMnBPtoEOsPtyZtXmJg7shu0XaNtJGOfMbJfNFoteZYEwKk816ChUp1pciPtNsQ3o2aD8x5GlbkOhbMHYa+XPdpV9GM60dVY/sxo9GE92kKV1a3VIqykOBbCSnfXDqd/5mq2nKVBUPnDE0hWuOoFaKFKPfgvx0LmGByV4XQ/8WMVBkDXIHlMqYaMyOBC0vrdcXL9zjp8V0g1qw9M0HCRGvy97K4Phraj8yLV1nQkajPS8sJDQmnmGiTqKRyUVVGcRvyqM7zAx9f2A0CKXIDCxN5iyzX+f4fHBixr/vd21ePIMb8LUwczsVjd5MfNL/ACTItY+iNhqgonJO4WnLXMc5gU780v840biYeT4OFQsXN8tfgq6BUd7YTbo8i31zVQTjbaYdB0SERRT+AxmO2M/ly8qoDQtS3stMJcd2iOUWT7bctsLOFpjCq0on1tlrZnHPMpvXikz/eGspYLPzSg2VlufgwIW2Y28RDCAltpzIt4fWY2+hTWRH4jsHuZoHQdH8vLkHNDqYGdEDobtXcMnE1CbC6cjMduwH41li7BhoweXl
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(38070700021)(4143699003)(11063799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+N9e9+vIE7eaHU3idTR21nipRZrr8GMrsLQUOV/1PGIizFPaJDSKRpGJxcgP?=
 =?us-ascii?Q?m7Bp/87BUWUpiOlEEDkbLiUP46lfLlILb1HY+grIqFlTgpAbehjOM0FPj1qR?=
 =?us-ascii?Q?EeXUhgDoKjta3WUi4Owklhrh5B1Ls1De8pBtRjF+vRe8UY0ergX9FE3w+w9z?=
 =?us-ascii?Q?zC7kpm42bgWJT9Fv7/wxRG9H/XY6kBSgz1CyV1gOd6b3htyOmfA0ZXgTkUEt?=
 =?us-ascii?Q?yIIZYpt+qnfwqoogDQU2Nqw8p0c+sMiX9IbBy4j8QwD12FiwW6c3eTGyDxnA?=
 =?us-ascii?Q?jithaA5mZAcGNmaa+xk1sL9sGd215DtLwSRYf93RZ6thw1adBQ3JuCJ+Q6Il?=
 =?us-ascii?Q?YOmdoi7rqVd46JQYRiqcs1knBow4VXXG8AAmz2hHC6hD0lmeB1QPWjOh+SXD?=
 =?us-ascii?Q?LivKcI22e2x5u3SisKsT9rVyGx6zUfPRKmiA+6G0v+vrySTEW0KjMjXKB6sR?=
 =?us-ascii?Q?MZqDuMP0FbCQhq56tsEQWNyyQ3YyV2EtboOtRdocsUShsIcrEG4scIzWDder?=
 =?us-ascii?Q?sjXp5PpmoknAtqHNy+H87UvOpRno57HPeH3bz1lOkaxbKJqZu/2yjSmqBFnM?=
 =?us-ascii?Q?5T/XFhiah4Beg4/yeQYb3IK08KlBMfMtHvTmkw2pUfu1FlzQqZSBDs8SLrMj?=
 =?us-ascii?Q?uZigD+T0OGFiYvOdwNMzYhjvMM/yUivSCyYepMj11iw3fWjO1AwYfmnWLEIG?=
 =?us-ascii?Q?/wG8o2rAN4Gp7M4pJ/gs2Jc+1b77sQEvi8NFNIvjLYhbAXsk5U5ixKLGyCnx?=
 =?us-ascii?Q?mbrYPfMIQKb+HYcyO1FGWAxg7AX44fyNF7R3V48wK4WcN4KVaqJM2Cofk4MM?=
 =?us-ascii?Q?+OpBacJl9uopxsZLnlPBKieifUGmTP8bzqSClwZFsMNfei6J8alPtfqdm2Z7?=
 =?us-ascii?Q?PdrkXCvEsZWOfBT0dQ4gjsbavW+50M6lpI1c/VHEHRrf4X/ocpEUuiNicGdf?=
 =?us-ascii?Q?3WC4uE9dqq84v9qPbUM8EZJJqnX58TsMxIDvId0rLjJFqmpQKfdoUErHuROp?=
 =?us-ascii?Q?Z3IkMnE6X2h/x5ZC+YUGtJdUZs7tOQfWkxoWxRvod9pa9y1GcP0mxiZoQC5W?=
 =?us-ascii?Q?IIOXeHfH1uAbHPnBlftXChuc+/MzzB3ASI+XKNlCHW7NYd6Kr+uVXARYpDUJ?=
 =?us-ascii?Q?WsB0wZsHZTjKg6B76YkcC9TiNXLq3jfQcgudQlDuUNsB3pWSpLUXA/b3m7oU?=
 =?us-ascii?Q?B58GTCX7FyBxyhV4eno2S8OJdk1GsMykND2e9sovMdWw61dUY/QJXg/H/Hjh?=
 =?us-ascii?Q?Ys3GR6emf9Pt29KKqkYT5D3eOybndeSyccS/WGPymZ0CwFfpKKQzaUzqqFbE?=
 =?us-ascii?Q?yNOHLZQcoesvnFTr22+W5AdvPewTlsVvV6bkvOPL+tX6ow9eDLy86SN2O5ra?=
 =?us-ascii?Q?y/IsUdofsMwrQpaOzeCrEcJTbtSUAwCPxQsAYuOi4yuIZktjsMzN6HrGa1M2?=
 =?us-ascii?Q?6Rh+GmmTmi8uNN8klz7uu+KqYhkxIznVWXa726dTPa9vO+i+vzAG3p1Bw87i?=
 =?us-ascii?Q?zw1csVWt1oFUhAdNuMCi6+RfDjOl1rXEm1PbfDr7AOebHFSqgri5dOF9CseO?=
 =?us-ascii?Q?1EzADe9t0ke6RWycEZH0tqJEoGLUCSB8rzsUd/+aGzWd6Y0i5CeWqiJfLEhK?=
 =?us-ascii?Q?Je5A5ybba0WNiEwxn/Sba6gSl+JwwQQcjzSWKDk4UNt2LaTuNbi49n3Emk1M?=
 =?us-ascii?Q?MXaCcuNq98CikCVuzZXq3XDVdwmkKIsgIKGeAXvNQbj5Rftf91M1WbzhB7tA?=
 =?us-ascii?Q?oG0zUpdkjQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18880097-c198-4186-9b14-08deb4425730
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2026 18:30:15.6302 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TPxtS6MaAn6q5paX3EWaP7YlF9Vrr5zPmiVUVsc8u9xnH2930ri0nOIhrOvMQfH7K4gOz1KMaKWFC01r7N/IGwxXGHg4WxJATzVnVIqezmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12725
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

Hi Laurent,

Thanks for the patch.

> -----Original Message-----
> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Sent: 12 May 2026 00:56
> To: linux-media@vger.kernel.org; dri-devel@lists.freedesktop.org
> Cc: linux-renesas-soc@vger.kernel.org; tomi.valkeinen <tomi.valkeinen@ide=
asonboard.com>; kieran.bingham
> <kieran.bingham@ideasonboard.com>; Biju Das <biju.das.jz@bp.renesas.com>;=
 David Airlie
> <airlied@gmail.com>; Simona Vetter <simona@ffwll.ch>
> Subject: [PATCH 04/11] drm: renesas: rz-du: Switch to new VSP API
>=20
> The vsp1_du_setup_lif() function is deprecated. Use the new
> vsp1_du_enable() and vsp1_du_disable() functions instead.
>=20
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.co=
m>
> ---
> Biju, I would like to merge this for v7.2 through the media tree instead =
of the DRM tree. Would that be
> OK with you, or do you expect conflicting changes to the rz-du driver for=
 v7.2 ?

Yes, it is ok for me. I don't expect any conflicting changes to the rz-du d=
river for v7.2 in this file.

Acked-by: Biju Das <biju.das.jz@bp.renesas.com>

Cheers,
Biju

> ---
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c b/drivers/gpu/d=
rm/renesas/rz-
> du/rzg2l_du_vsp.c
> index bd486377f037..d5a1d36db2c1 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
> @@ -55,12 +55,12 @@ void rzg2l_du_vsp_enable(struct rzg2l_du_crtc *crtc)
>  		.callback_data =3D crtc,
>  	};
>=20
> -	vsp1_du_setup_lif(crtc->vsp->vsp, crtc->vsp_pipe, &cfg);
> +	vsp1_du_enable(crtc->vsp->vsp, crtc->vsp_pipe, &cfg);
>  }
>=20
>  void rzg2l_du_vsp_disable(struct rzg2l_du_crtc *crtc)  {
> -	vsp1_du_setup_lif(crtc->vsp->vsp, crtc->vsp_pipe, NULL);
> +	vsp1_du_disable(crtc->vsp->vsp, crtc->vsp_pipe);
>  }
>=20
>  void rzg2l_du_vsp_atomic_flush(struct rzg2l_du_crtc *crtc)
> --
> Regards,
>=20
> Laurent Pinchart

