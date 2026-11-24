Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04663606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=VjPKtJ0i
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F00D10F59A;
	Tue, 24 Nov 2026 13:18:55 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazon11010015.outbound.protection.outlook.com [52.101.229.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1C8210F59A
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 13:18:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQwDTpMu8M9KpMNI1VCpdg/XHQVBo271wKvy+OAcpKJwaakKGseuMtSm+3QFQQw+cwuur6arUJgMv65fMObOU3xODJ1hDeDbyMhMq7RZ4smU7wxtNaOv7Z8bOXCbN2/rvpu2JbUvtdwkTm3wTSvlIYlHrgGzAv/V5Kt1aPjRBy33iyQ80WOzFLXj9WBkZ1kpOIE86serqLbM+vc73VhXxZL4ejfTMwdc/hJZJMfZJUdIkFheU4IeQfxPEnaTAzRb/Xu1uK1Cx1jsTjeqOYwNfvtTAzqf1xIBrqt+udkNvbUq7deI/HeXlRXmZCMnsEgKe15ta2kfetYQfYW+/M/h+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UI3BOB8uSn4b0MtNnPoOlZzPYYlGeIY/3EPGxNGt3Is=;
 b=x9dayrNUq+pOIgaOPFmwYuBy2OskPngYtsst8sr39HsqL0Od8TMWh/1cZe/iQi7m13oNPH+ABpSmtruy/i662Uxzm9wXP1mikXhcBZAZnvVrDFrURrtV6ASvdxqpuYR6F3pCHSy2IhCTZuYbTWBbp6Zh4FFZQMj/0Kamf0euH4B0KvzhEEZ6RoTSJfgptZHl6ghOzguVNLSWq+Vn+UZB+J3efuK101U35TFyQ996lroKphv+9iyNobblnkihPHtHhEZwnX6WEnqjW8lmk1EYHMbhKzDxaIJfH0tr7uvDQL7kVidaa5FPZbyjNE+b//iEJkErt4+VkMfE9m0zevdNow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UI3BOB8uSn4b0MtNnPoOlZzPYYlGeIY/3EPGxNGt3Is=;
 b=VjPKtJ0iT3VitTMcuKh5Xy2M9cJk/n0k6ak6WxjiAMypv67UrGgsQa084jYngi70YLj49zr3Q5rCdVb3VjrXa6a+iMetGlYISDoQ+k/0PfV+erZb11fpvwtsZt6JEQsPjc+1mM2XvEINF+CpG0j8ppBrP5BEGEsxoLQusmzIh9Q=
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com (2603:1096:400:e0::9)
 by OS7PR01MB14652.jpnprd01.prod.outlook.com (2603:1096:604:389::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 13:18:44 +0000
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f]) by TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 13:18:44 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
CC: Tommaso Merciai <tomm.merciai@gmail.com>, Prabhakar Mahadev Lad
 <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 "magnus.damm" <magnus.damm@gmail.com>, Laurent Pinchart
 <laurent.pinchart+renesas@ideasonboard.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v10 10/12] drm: renesas: rz-du: Support several DU
 instances in one DRM device
Thread-Topic: [PATCH v10 10/12] drm: renesas: rz-du: Support several DU
 instances in one DRM device
Thread-Index: AQHdc2mQXc9YOQBvg02jmZuHcmeGVrc781HAgAE6mgCAABQz0A==
Date: Tue, 24 Nov 2026 13:18:43 +0000
Message-ID: <TYYPR01MB660334463EC01FCF06F7A9E586442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
References: <cover.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <e22a176720a38df652c7f7eabe27219da50f217d.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <TYYPR01MB660397C3B66F6EED53656B2086442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awV6pAtcSz8e9Q74@tom-desktop>
In-Reply-To: <awV6pAtcSz8e9Q74@tom-desktop>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6603:EE_|OS7PR01MB14652:EE_
x-ms-office365-filtering-correlation-id: 0e9ed5c8-4f6f-4ca9-cd5e-08df4a2d7708
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|366016|18002099003|22082099003|261009223027099003|261028144727099003|4143699003|56012099006|11063799006|261102123227099003|261026121527099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|261026140227099003|38070700021|10067099003;
x-microsoft-antispam-message-info: fDxQM5eiqg2uGveIH8otR5aeM0Cdz0PYbmfoIoh+neuNEUTUGPLIjvqSI9aVQGPecmMh3YD3IAKF2IYziBOSOx7akTK7JEK/Ijt485kqPb0jM7rIA5nicv3lqfJMkCSpf/AHmt2ErjBOIZHrj11bReqOQIb8+4jrIJGvd9QK9KgTtHrkEZHbx7DZKFAOdcq0rufzEw4AD0fBQnnAuHhERJhNSglv9iUfZi1zxx/9E6NPKid88Xkl4PvbIWmVOQawz9OpUi82tGuH/d2eHYt4S8TV/rAexI+EOwdflwJe24AzSumOQyV+AJNn1UIf6pSrpDYYK4ZQNbKr9ee6fMiZWZySAikaWsRihXOSYhffEnBBja3i8L4Ydb9GC792ogD2ocxnXE+LVV4DmpJ7VAr4IFaC8OtWFOPCWmeYDU5QJA0MSJO1kM6gaXaCIn1DpHh/vCLj6WycQ2kttx8OnlNPGXags/KUkR6QjTfK+wLXZ9V2XnhmmNrjGQUwEKYOfLnKq+DkJalQ0RKd1uRvdlmYiIPHK8nRcGuxVG7nAckvRJgphZ3qoI8BZKBRdoaAiDUA+QkLSMCh+K77oa8pSeq9Nsm67brbEabplwJoQZT2GJx7wpf7bHs2Xksaet7hKyjsjmsfAzin0GCuNyrhK9m8wQQo7LbycWJS4KoGvgPcrrH9ypO0zzWCvvP99QUJt27sKTomKeALekaE2J1hDmeRhNYtAy1oj3MtiWgYpRFNcwk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYYPR01MB6603.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(18002099003)(22082099003)(261009223027099003)(261028144727099003)(4143699003)(56012099006)(11063799006)(261102123227099003)(261026121527099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261026140227099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?U79hO45VuJhYnesSbX2OTEXSRF0r97TQFEtqEgYPuF6ptFACbNA4sBft51?=
 =?iso-8859-1?Q?x0MFKz7+4lfJYW4cWTyKj8I+ZdyTdiROX4qE3U0RLHd8Dgj+KZ4Cj/QfMV?=
 =?iso-8859-1?Q?HbjLpjec8XPkFKGfQjZAyX5OnKKNEEhKJTja/1Bu/SFUDjZH9uFNNj2Mtp?=
 =?iso-8859-1?Q?xIASjmMhq2kym1Fbolz+FXsAVl5sC27bEvqfoXtN65F5PhlYm0df3WJxlH?=
 =?iso-8859-1?Q?E99lDOPxncQbrqInSS9Oy6DS1HM7JJXu3KhnfsIM5B9DcU/ysgj6rpdkHV?=
 =?iso-8859-1?Q?vu88i1FfFXZV0a7/yNwXphZXHLDOro5jfvqXZlK0nElDky4I0cysplArIg?=
 =?iso-8859-1?Q?NYssdDaC1p7i/L/CI+jlzu6SrqZuXPi8AsLSWkt8ST1mNMkFpqwlpoCT82?=
 =?iso-8859-1?Q?7xSriyo9Uv/o50Dry9gPtDr7LrRBHPiStkD4hc1OLviwS4LDox+CXA13q1?=
 =?iso-8859-1?Q?Mqt98xH7S6NcMapZqU29X9F9QAJ9ANvDvgawpnaY1vVLM8REI0CUlc10Py?=
 =?iso-8859-1?Q?es0Xdd3EiJs/uNVcP8DM8FnWGxJLGFUPBaBKwkColPlWFdRE4lhCfNW9uA?=
 =?iso-8859-1?Q?ru8aUag8FqVGK+s+EUfhAqeY1ldXb0lSP6yZdIq4Ur42onEYLWUiJqxB5k?=
 =?iso-8859-1?Q?V1VBvu4/4LQrIEJD3aSxCykc0XWsZugp1WQw+vNk95V7NjRBvTCy8iYDDh?=
 =?iso-8859-1?Q?73iLpaBJ/ZRD18RqXDDqb9F0UtT6F8w0ja8c5waJjWzp2UseOyfS9rH7eR?=
 =?iso-8859-1?Q?LUJ+WFCOtzaiKRST7liMNsXTGlQORfoIZt60/EJE4m7V3GF4L2XoT+FpMI?=
 =?iso-8859-1?Q?jmHyMg7DPtujzhz7Aq7o9OC/2HXIRK9JskXV42Qj2pxZDgO/FB3bOkbLK8?=
 =?iso-8859-1?Q?5IniXsIyBGyuSvC2a9sTEw0n37Qu/rUfXrslg6DI2fkJ89/yjm71wgxAEo?=
 =?iso-8859-1?Q?TRmt2a7GPEfapOyLxLbvKpw9DA0R9XtbciED6pT29rzc4SEhkY0AAelLE+?=
 =?iso-8859-1?Q?yMnK7JYIqHAB4RDJ1JU4rhuJxF5n3UIPclCOPL9y3Nnz70G9ZEZ+rOjJPz?=
 =?iso-8859-1?Q?2m5qpv0FxYStnek1G6hNREuHCLEcIg8g9hlEyP7Ufo8k3CBvgkRthRY6d6?=
 =?iso-8859-1?Q?QA6/8UWtev6ZjOSgm1nVkyOSmuvGln1sBB7rd+uygXGkcZim8kTeHRQU7Q?=
 =?iso-8859-1?Q?M4N/d2KmykP201s3S3bGuue45LYc1rsC+V1kWlXimEhVLd9KWHOW/CUaF+?=
 =?iso-8859-1?Q?QfgJr5uH8lNfu7v1c09juvJt2BvibVtZYnIA2X8aKfzN47+ewQGq4//ARP?=
 =?iso-8859-1?Q?Kj9piMHeKUcK7z00p3PYBHGmzO4IbzFDI7aKfwmviZpY3mF95T/mo6aW14?=
 =?iso-8859-1?Q?1t6QIiFxdlq+FXlytjkM58SJN5m+LuDmEMPxd/EJIhukwXIq0rS0yDip3L?=
 =?iso-8859-1?Q?8QtG7KDatqhVbfY9eQ7yh4ST+6v3+gA1XfzhdBigc6Ub7rY4ew8wj5pxXm?=
 =?iso-8859-1?Q?dgy59EVJ6kIVWAtxYE1eyOffXKyTEzS0f/pV4Rw4jE9ClbEfVN/n5VPOlx?=
 =?iso-8859-1?Q?j9hYMi2SD3Wpo61D/4ZGh5SiUCBnBzdFRIt3ci2yzYJmILOqyMG2IaKg3D?=
 =?iso-8859-1?Q?PcViQqU/NVqbJW2AGGaic+FnpbGUWN4I/ZEohIPKOcRHyb/hFwzTaDIzmv?=
 =?iso-8859-1?Q?oiWv74Zf1G9wiCSiDuEWe6AxrBpXg9mlMY/cFybl+xnwYnxvYZxrt8zGyS?=
 =?iso-8859-1?Q?d2CwVFADxpPXV3jidZSgU7rtURAWwX6LOT2+d1oac1kzBXeSAwUPVm7uku?=
 =?iso-8859-1?Q?d+R3qrOETQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6603.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9ed5c8-4f6f-4ca9-cd5e-08df4a2d7708
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 13:18:44.0403 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E1MqeDalJHwgWVzN9KDk2Ba04NPlahNMX9P4sBqg+9rUnYgC25ne4/tKZsYw+rs5GHbJbeRXOEp26GYcTZVOyhO/cy26CHsex7rCPM6KU+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14652
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tommaso,

> -----Original Message-----
> From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Sent: 24 November 2026 11:53
> Subject: Re: [PATCH v10 10/12] drm: renesas: rz-du: Support several DU in=
stances in one DRM device
>=20
> Hi Biju,
> Thanks for your review.
>=20
> On Tue, Nov 24, 2026 at 07:47:04AM +0000, Biju Das wrote:
> > Hi Tommaso,
> >
> > > -----Original Message-----
> > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > Sent: 13 November 2026 12:20
> > > Subject: [PATCH v10 10/12] drm: renesas: rz-du: Support several DU in=
stances in one DRM device
> > >
> > > RZ/G3E has two DU instances that share a single DRM device.
> > >
> > > Add an RZG2L_DU_FEATURE_COMPONENT flag and use the component framewor=
k for it. The first available
> DU
> > > instance is the master and creates the DRM device, the other one bind=
s to it as a component.
> > >
> > > If only one DU instance is available, it creates the DRM device direc=
tly at probe time, as on SoCs
> > > without the flag.
> > >
> > > Set the index of each instance to the number of CRTCs already created=
.
> > >
> > > Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > ---
> > > v9->v10:
> > >  - New patch.
> > >
> > >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c | 118 +++++++++++++++++=
+-
> > >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h |   2 +
> > >  2 files changed, 115 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/g=
pu/drm/renesas/rz-
> > > du/rzg2l_du_drv.c
> > > index 93d59e2cf8a4..873586f2ef28 100644
> > > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > @@ -7,6 +7,7 @@
> > >   * Based on rcar_du_drv.c
> > >   */
> > >
> > > +#include <linux/component.h>
> > >  #include <linux/dma-mapping.h>
> > >  #include <linux/module.h>
> > >  #include <linux/of.h>
> > > @@ -14,10 +15,12 @@
> > >
> > >  #include <drm/clients/drm_client_setup.h>  #include <drm/drm_atomic_=
helper.h>
> > > +#include <drm/drm_crtc.h>
> > >  #include <drm/drm_drv.h>
> > >  #include <drm/drm_fbdev_dma.h>
> > >  #include <drm/drm_gem_dma_helper.h>
> > >  #include <drm/drm_managed.h>
> > > +#include <drm/drm_of.h>
> > >  #include <drm/drm_print.h>
> > >  #include <drm/drm_probe_helper.h>
> > >
> > > @@ -170,6 +173,7 @@ static int rzg2l_du_instance_init(struct rzg2l_du=
_device *du,
> > >  				  struct drm_device *ddev)
> > >  {
> > >  	struct rzg2l_du_device *rcdu;
> > > +	int ret;
> > >
> > >  	rcdu =3D drmm_kzalloc(ddev, sizeof(*rcdu), GFP_KERNEL);
> > >  	if (!rcdu)
> > > @@ -180,9 +184,28 @@ static int rzg2l_du_instance_init(struct rzg2l_d=
u_device *du,
> > >  	rcdu->mmio =3D du->mmio;
> > >  	rcdu->ddev =3D ddev;
> > >
> > > -	return rzg2l_du_modeset_init_du(rcdu);
> > > +	rcdu->index =3D ddev->mode_config.num_crtc;
> > > +
> > > +	ret =3D rzg2l_du_modeset_init_du(rcdu);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	if (WARN_ON(drm_crtc_index(&rcdu->crtcs[0].crtc) !=3D rcdu->index))
> > > +		return -EINVAL;
> > > +
> > > +	return 0;
> > >  }
> > >
> > > +static int rzg2l_du_instance_bind(struct device *dev, struct device =
*master,
> > > +				  void *data)
> > > +{
> > > +	return rzg2l_du_instance_init(dev_get_drvdata(dev), data); }
> > > +
> > > +static const struct component_ops rzg2l_du_instance_ops =3D {
> > > +	.bind =3D rzg2l_du_instance_bind,
> > > +};
> > > +
> > >  /* -----------------------------------------------------------------=
------------
> > >   * DRM device
> > >   */
> > > @@ -191,7 +214,7 @@ struct rzg2l_du_drm {
> > >  	struct drm_device ddev;
> > >  };
> > >
> > > -static int rzg2l_du_drm_init(struct device *dev)
> > > +static int rzg2l_du_drm_init(struct device *dev, bool has_components=
)
> > >  {
> > >  	struct rzg2l_du_device *du =3D dev_get_drvdata(dev);
> > >  	struct rzg2l_du_drm *rzgdrm;
> > > @@ -213,6 +236,12 @@ static int rzg2l_du_drm_init(struct device *dev)
> > >  	if (ret < 0)
> > >  		goto error;
> > >
> > > +	if (has_components) {
> > > +		ret =3D component_bind_all(dev, ddev);
> > > +		if (ret < 0)
> > > +			goto error;
> > > +	}
> > > +
> > >  	ret =3D rzg2l_du_modeset_init_finish(ddev);
> > >  	if (ret < 0)
> > >  		goto error_fini;
> > > @@ -235,6 +264,8 @@ static int rzg2l_du_drm_init(struct device *dev)
> > >
> > >  error_fini:
> > >  	drm_kms_helper_poll_fini(ddev);
> > > +	if (has_components)
> > > +		component_unbind_all(dev, ddev);
> > >  error:
> > >  	/*
> > >  	 * Don't use dev_err_probe(), as it would overwrite the probe defer=
ral @@ -246,7 +277,7 @@
> > > static int rzg2l_du_drm_init(struct device *dev)
> > >  	return ret;
> > >  }
> > >
> > > -static void rzg2l_du_drm_fini(struct device *dev)
> > > +static void rzg2l_du_drm_fini(struct device *dev, bool has_component=
s)
> > >  {
> > >  	struct rzg2l_du_device *du =3D dev_get_drvdata(dev);
> > >  	struct drm_device *ddev =3D du->ddev;
> > > @@ -254,6 +285,83 @@ static void rzg2l_du_drm_fini(struct device *dev=
)
> > >  	drm_dev_unregister(ddev);
> > >  	drm_atomic_helper_shutdown(ddev);
> > >  	drm_kms_helper_poll_fini(ddev);
> > > +
> > > +	if (has_components)
> > > +		component_unbind_all(dev, ddev);
> > > +
> > > +	du->ddev =3D NULL;
> > > +}
> > > +
> > > +/*
> > > +--------------------------------------------------------------------=
---
> > > +------
> > > + * Component master
> > > + */
> > > +
> > > +static int rzg2l_du_master_bind(struct device *dev) {
> > > +	return rzg2l_du_drm_init(dev, true);
> > > +}
> > > +
> > > +static void rzg2l_du_master_unbind(struct device *dev) {
> > > +	rzg2l_du_drm_fini(dev, true);
> > > +}
> > > +
> > > +static const struct component_master_ops rzg2l_du_master_ops =3D {
> > > +	.bind =3D rzg2l_du_master_bind,
> > > +	.unbind =3D rzg2l_du_master_unbind,
> > > +};
> > > +
> > > +static int rzg2l_du_instance_probe(struct rzg2l_du_device *du) {
> > > +	struct component_match *match =3D NULL;
> > > +	const struct of_device_id *of_id;
> > > +	struct device *dev =3D du->dev;
> > > +
> > > +	if (!rzg2l_du_has(du, RZG2L_DU_FEATURE_COMPONENT))
> > > +		return rzg2l_du_drm_init(dev, false);
> > > +
> > > +	for_each_available_child_of_node_scoped(dev->of_node->parent, np) {
> > > +		of_id =3D of_match_node(dev->driver->of_match_table, np);
> > > +		if (!of_id || of_id->data !=3D du->info)
> > > +			continue;
> > > +
> > > +		/* The first available DU instance is the component master. */
> > > +		if (!du->is_master) {
> > > +			if (np !=3D dev->of_node)
> > > +				return component_add(dev, &rzg2l_du_instance_ops);
> > > +
> > > +			du->is_master =3D true;
> > > +			continue;
> > > +		}
> > > +
> > > +		drm_of_component_match_add(dev, &match, component_compare_of, np);
> >
> >
> > The master=A0is chosen purely by DT order. If the first available DU ne=
ver probes,
> > the second never gets a DRM device. How do you handle this case?
>=20
> All available instances are part of the component match, so the DRM
> device is only created once all of them have probed, whichever one is
> the master.
>=20
> This is how the component framework works.
>=20
> To use a single DU, the other one can be disabled in DT, in this case
> the remaining instance becomes the master and initializes the DRM
> device on its own.


Assume both DU's available and run time

second DU is probed first and master never probed at all.
What is the state of second DU as bind never calls?




> >
> > > +	}
> > > +
> > > +	if (IS_ERR(match))
> > > +		return PTR_ERR(match);
> >
> > Why this error path cannot be inside loop?
>=20
> component_match_add_release() ignores further calls once the match is an
> error pointer, so a single check after the loop is enough.

If there is an error, you can do early return, instead of keep looping.

Cheers,
Biju
