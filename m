Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503FB606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 13:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=J/YhtrLw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0B5B10FC66;
	Wed, 25 Nov 2026 13:49:42 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazon11010017.outbound.protection.outlook.com [52.101.229.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03F1410FC66
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 13:49:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5SYHyFjcO5gvV9u1XeA8lWt3TfHDIvZj0XvL/pX2F1lVmiW0U3tVWb1g5+qZ0XMw6krEHFRUyL7ub71Jf2/CvwMmOMWv7JommQxMxP6kxETK5gh2fBX0XxfDfHVLt31KVNqpxrsY/xI9LrohLfsjqlkU5bHUO+6DQ7BfpIw4kYNq085OyMYS4roTXgPwIXFwaaChddP+kObaZrhyMpQp74xCTByXBUlF/CVa2F9kl/eIMAHdBuLPjFq5GSlgeg7CHG9IU1jvM0bIrszfMRtLZeKd9kjk/0ftdPDxOwEPfBba0VdYRNDrK3Az9AXTo4BTF+sLzUrNSxZiiw8jfw5/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Osq+W7LHoaSvN4iuafP57QaD2hLD6QJItx/itoEnVII=;
 b=rE78+yrps5UeZTqplY8/7sYAm10nJeZ4wMPXxXV9sLgcCdPCiFvlFiCgV/5TTylZSXnSwfa9W7xVYQJlcSSr9DpH+JdzkdUPBsiEBc5cmR1Pvkv2kkQgluyvnFdlqK9bAClmqSYZHTr+Wa2xxHFdZA39lvGXfeN8xj+i37qF5eK7alrzyHJtIUw+DYRiYo4ZoP3/hHRys8jkrIi6aNYCkuPNUaYwfdWnxqYnCDnyPEUsv3GpwtOX7pbGn+0eWk7JHR4ZD0JkkwxKKH+JLtfc4ik1Y+czhJq1VgXrTln92kLWDBooTjFAmTt74wmYtjk6OzgVjBF7/o/Il2v/rkOUgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Osq+W7LHoaSvN4iuafP57QaD2hLD6QJItx/itoEnVII=;
 b=J/YhtrLwwRlR0tBU9d0rX2x3mLTB1egd1fP5clAcBUdiAwXhnCJQA86FrvAKiMDRnbqJA/cOXrZzTIH7sJ+kRx+Yx/aysNlEDi2uxhUrTEjpSAvEt5mF612XCo4uWGc7/OMTJgsEp2LX36JT51aLCNSGKiLj6dDMvGQhdRqFpi4=
Received: from OS3PR01MB6596.jpnprd01.prod.outlook.com (2603:1096:604:10a::8)
 by TY4PR01MB14667.jpnprd01.prod.outlook.com (2603:1096:405:209::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 13:49:26 +0000
Received: from OS3PR01MB6596.jpnprd01.prod.outlook.com
 ([fe80::58ce:825e:c38b:ec98]) by OS3PR01MB6596.jpnprd01.prod.outlook.com
 ([fe80::58ce:825e:c38b:ec98%4]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 13:49:21 +0000
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
Subject: RE: [PATCH v10 08/12] drm: renesas: rz-du: Separate the DU instance
 from the DRM device
Thread-Topic: [PATCH v10 08/12] drm: renesas: rz-du: Separate the DU instance
 from the DRM device
Thread-Index: AQHdc2mHvfvfxGybKU23d8MzJCmRZbc78H6ggAESzwCAAALngIAAKXaAgAAOCVCAACsuAIAABMHQgAA0sICAAMXVQIAAeAKAgAAAV5A=
Date: Wed, 25 Nov 2026 13:49:21 +0000
Message-ID: <OS3PR01MB6596FE927C038F264BE0C97186432@OS3PR01MB6596.jpnprd01.prod.outlook.com>
References: <68fcf838eee14c1906f23b2b7c74c560793cd1d4.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <OS3PR01MB65968FEBCB08429F11188CE986452@OS3PR01MB6596.jpnprd01.prod.outlook.com>
 <awVW5B4p06FUfBHw@tom-desktop>
 <TYYPR01MB6603AA1B7A48B7D899604EE586442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awV8G86QIth4GtaA@tom-desktop>
 <TYYPR01MB6603A1FB28A473A400A2C49386442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awWsGjt6cW_CSoMH@tom-desktop>
 <OS3PR01MB659637409ADFF9CFC2AD395186442@OS3PR01MB6596.jpnprd01.prod.outlook.com>
 <awXcSSnNeaOQFQZ5@tom-desktop>
 <TYYPR01MB660340BEF9704BB69FE150FC86432@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awbm6f3ovtva5gg2@tom-desktop>
In-Reply-To: <awbm6f3ovtva5gg2@tom-desktop>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6596:EE_|TY4PR01MB14667:EE_
x-ms-office365-filtering-correlation-id: 5f3af61c-1ae8-4b6f-5f39-08df4afae8ce
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|4143699003|261009223027099003|18002099003|22082099003|10067099003|11063799006|56012099006|261102123227099003|261026140227099003|261026121527099003|261021123027099003|261022075727099003|261022105027099003|261028144727099003|261021121427099003|38070700021;
x-microsoft-antispam-message-info: POUB8WjDaB6mlXBAFJOP/zBGUyGmlKj2q/ZI0nz6tXXi7juX2PDqMri8xarLZVJ6riiKwgLMZ2OluP+fDDoKPmlQC6HTB2fOH8E5fI+mcfFfYBeKQYmQu/uN2Czu5z4bKesT9XAKRTfJJVWofabomdBl+GRlTGNkNHlaQ3P7SbYCvK3mCIf7VwzVsfnLnwzCHR+4HhPXeGzrEkIm1Ax9l4CG9GkATBkGlbKhqPgn/+Aiqh1lJe9TdrwuIvXJQuJTdeF8XalDG1ww5hgziLH9ET1eLglhQTAE8sWdAYl7JKRbrZnX4J84Vse55+bVOl2nWT16jKFSwytoPmdPWAQnEVDG42fhuOzbkKkAmoiguo0YqXLQAAcE99Zb1TzwIVo+uo2+EUzPFzDAeWCpDoEqySR/4NdSiK9C8m6Z0XYYcWdCr9ikjJBQrTKIR382bqtF2fFO3Ukn3gjBEgOhqHV+h1qZbsqBBVLQzF7OZLGUcE8QDAPjQJ6bVbf4FERVWCu1C6I3AwYaBZZwebZpVzgVmUghrA69ns09fRXL9JqN0juknt01xD4BU7wtaf92X2Boe9EFvY7pv/3unujgiVrb2yR1cZMEOBc/vpzxC8rJF+UhtwQVPIEscItKPdmBVzDkMW5KQx5hhBj0OklcJgTtWB2MMW3QfAmc3GS8SRbguZig8c7SSE4dBjkpDIqlZ2u5vie03T4jz1n9OldxLxP5RzGFpxfvmilrMnTdfqD4kX4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3PR01MB6596.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(4143699003)(261009223027099003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261026140227099003)(261026121527099003)(261021123027099003)(261022075727099003)(261022105027099003)(261028144727099003)(261021121427099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JsJzkiGWvsq3C4lqY6D4WsA9MWdQ9h01Q8UCGjQJdX6ZFbFdhejPg7j1dDrq?=
 =?us-ascii?Q?U0ae16lOM45uzoY+JyF4KCmKtaO3WzhdkOO65EL+mq+tn2XTaVstw5JB+9QB?=
 =?us-ascii?Q?FlBum7nmgCbtYxc+14hrknD+lYF0ddOxL2Trx72Kg4xg3khcKg3TJc5GH01z?=
 =?us-ascii?Q?tNqt3/0gqDxtkZKG/PeQNE1U7A2LbMxmnBlQ29C0XPz3dsPqvEL9BHVIqwyC?=
 =?us-ascii?Q?5vLmQssUTKjSv/W1LZ36ocSH21Hn8ExEpCiPYCf5u9mVEjqaJ/cA2L0wM+Lr?=
 =?us-ascii?Q?AewO/xk9yDzZ7U+Y5JXAZw+8wO/nFVgyScjx/+ShcfJkpVEtXYvGY/IlQDQq?=
 =?us-ascii?Q?AtAAphBmHOHshaYTaCP6oLcdYeGPWnOjMzgCS5lEc8KyondY6rnXQ8l1TEg7?=
 =?us-ascii?Q?mYJ398Y16/CbTxedjZAUjMXahwcQ7ZZemoiANuvITFd9Lvrj/mb3OnBoAKsN?=
 =?us-ascii?Q?p1TDqvuzvu8wFP7bIOUcoIhFaQS/50AJjqySWrcvMTDfw1OZwee4S5m+CYNF?=
 =?us-ascii?Q?Eo8NxHcTqGUKnAd+y7oel+Kbnt8HWgRhi79bwcfDibotobtyPIfVIq/F8ceo?=
 =?us-ascii?Q?kBXilVS2C/qyTQ0plGx+KdFX5jMjkKGrYJqMh0/SvDtYy8emxnLoqudU4auG?=
 =?us-ascii?Q?UqcTpquKQ4cVLSW96oksRlSdLo/AGgy3aovPqN2TZAHfZgpQMEMH5HhoH0BF?=
 =?us-ascii?Q?/xw7LdjMrEF6pLA469L2XF/R2Bo4efbv9X3nI/CbBtFVcdcJ7KIPvaEzdgnh?=
 =?us-ascii?Q?0fp5VSFGrxq9Z9uHLkLjKuGC0jInh1iTB9ZLKzXz+Keb2m/8V3JZIalQV+SZ?=
 =?us-ascii?Q?L2UG5EwWmz/LAb10Cr/sgLYOHYN8CRC41jb28pq09oG49HNvPq5SflMlbqeU?=
 =?us-ascii?Q?kUpgeFHoTFAodP4O8fEuT8xyNQrdhi5g3DFV4RYIOF1EMyMQJZvn4cvvMLZ8?=
 =?us-ascii?Q?qAjkDFOle6rM9l7KMOx7GayUvoeD0TxiVijypmJ8uHtF5gt0e/Ag6MQiCJs7?=
 =?us-ascii?Q?AxTdnIq0xdX7gZQzXZECUPzx0qrsflrGhJ9C0O6nrJREIFfvL+oIs5F+iNAb?=
 =?us-ascii?Q?sLKU2tYwO3G7EkbRwY7S8Tjdgfw2d/pImoRc1rh0sr59fUeQkOSARP1bZlz0?=
 =?us-ascii?Q?UtQ7ys1q4dUXGMWER4GN6B4qAlb8598PRtZZcZ4rCmlqRx4TovEdJVzBkuJR?=
 =?us-ascii?Q?Ja5ssToNAHB6N4pwxq+4a4KNOGhCP5a5zr4GTJWgd3+SlLgI1RApcThEwpj7?=
 =?us-ascii?Q?tOmyyJd0D8CoTX8v5uS9UAH/wcDR//IEI33HdOijg87/hbgIkD9PVvFdF7UT?=
 =?us-ascii?Q?qHl7uSRVSd/VQA9y+zrqfKPouSHrnKUPdC2Z9W2fwbBJOEWRJh197hpWxLv1?=
 =?us-ascii?Q?KRJ+20Z/kk0Sn6APII1Uc3sJrL309qOwkHG2bsh8ZBHHhs/x7MbjYDfhrk7Y?=
 =?us-ascii?Q?9w0mwWBWjVn6MZIwBIm21jbWzxXI8fDC4ey4y+/gO/qnmWgB6VvkqVaaJ/qu?=
 =?us-ascii?Q?YQdaILVACczQSbk1fVrciCNH+MPv1PrR0bisZVjrQD7CD+ySFgrOYpBo24QD?=
 =?us-ascii?Q?veJ4je4VDF/Uh7h7Q8HLm0f71ndZI4rduMhxjAL2b53Vcg+v2dE0yh0VgHzq?=
 =?us-ascii?Q?6mNk8Pdwq2YXMs576IEggUmB9qXdP6ySlffm5GJ3h67uESOdqk9a2yTlxNsC?=
 =?us-ascii?Q?3KwQ/qnr921x3O/tspJhcJRFp6rAlZKuHqrRY+/FP9JBEtCbhDjE5jyfMEtH?=
 =?us-ascii?Q?U7Nd0scV7Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6596.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f3af61c-1ae8-4b6f-5f39-08df4afae8ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 13:49:21.7764 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d9xLW51A997PYoT18FKLyM0sx68B+9q4xjfu+Hju6t1hbznaOnxEqiM5BCY6yiUQ93On9m73G5xTndv3SSlgSQa0f1hcK5/EYTzTcT1dEzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14667
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
> Sent: 25 November 2026 13:47
> Subject: Re: [PATCH v10 08/12] drm: renesas: rz-du: Separate the DU insta=
nce from the DRM device
>=20
> Hi Biju,
>=20
> On Wed, Nov 25, 2026 at 07:07:00AM +0000, Biju Das wrote:
> > Hi Tommaso,
> >
> > > -----Original Message-----
> > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > Sent: 24 November 2026 18:50
> > > Subject: Re: [PATCH v10 08/12] drm: renesas: rz-du: Separate the DU
> > > instance from the DRM device
> > >
> > > Hi Biju,
> > >
> > > On Tue, Nov 24, 2026 at 04:04:48PM +0000, Biju Das wrote:
> > > > Hi Tommaso,
> > > >
> > > > > -----Original Message-----
> > > > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > > > Sent: 24 November 2026 15:24
> > > > > Subject: Re: [PATCH v10 08/12] drm: renesas: rz-du: Separate the
> > > > > DU instance from the DRM device
> > > > >
> > > > > Hi Biju,
> > > > >
> > > > > On Tue, Nov 24, 2026 at 12:51:18PM +0000, Biju Das wrote:
> > > > > >
> > > > > > Hi Tommaso,
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > > > > > Sent: 24 November 2026 11:59
> > > > > > > Subject: Re: [PATCH v10 08/12] drm: renesas: rz-du: Separate
> > > > > > > the DU instance from the DRM device
> > > > > > >
> > > > > > > Hi Biju,
> > > > > > >
> > > > > > > On Tue, Nov 24, 2026 at 09:33:13AM +0000, Biju Das wrote:
> > > > > > > > Hi Tommaso,
> > > > > > > >
> > > > > > > > > -----Original Message-----
> > > > > > > > > From: Tommaso Merciai
> > > > > > > > > <tommaso.merciai.xr@bp.renesas.com>
> > > > > > > > > Sent: 24 November 2026 09:21
> > > > > > > > > Subject: Re: [PATCH v10 08/12] drm: renesas: rz-du:
> > > > > > > > > Separate the DU instance from the DRM device
> > > > > > > > >
> > > > > > > > > Hi Biju,
> > > > > > > > > Thanks for your review.
> > > > > > > > >
> > > > > > > > > On Mon, Nov 23, 2026 at 04:59:32PM +0000, Biju Das wrote:
> > > > > > > > > > Hi Tommaso,
> > > > > > > > > >
> > > > > > > > > > > -----Original Message-----
> > > > > > > > > > > From: Tommaso Merciai
> > > > > > > > > > > <tommaso.merciai.xr@bp.renesas.com>
> > > > > > > > > > > Sent: 13 November 2026 12:20
> > > > > > > > > > > Subject: [PATCH v10 08/12] drm: renesas: rz-du:
> > > > > > > > > > > Separate the DU instance from the DRM device
> > > > > > > > > > >
> > > > > > > > > > > On RZ/G3E two DU instances share a DRM device, which
> > > > > > > > > > > can only be created once both instances have been pro=
bed.
> > > > > > > > > > >
> > > > > > > > > > > Split the DU device structure: keep the match data
> > > > > > > > > > > and the registers in a structure allocated with the
> > > > > > > > > > > platform device, and allocate the KMS objects with
> > > > > > > > > > > the DRM device in a new
> > > > > > > > > > > rzg2l_du_instance_init() helper, as they are
> > > > > > > > > > > released
> > > > > > > > > with it.
> > > > > > > > > > >
> > > > > > > > > > > No functional change intended.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Tommaso Merciai
> > > > > > > > > > > <tommaso.merciai.xr@bp.renesas.com>
> > > > > > > > > > > ---
> > > > > > > > > > > v9->v10:
> > > > > > > > > > >  - New patch.
> > > > > > > > > > >
> > > > > > > > > > >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c | 61
> > > > > > > > > > > ++++++++++++++------
> > > > > > > > > > >  1 file changed, 44 insertions(+), 17 deletions(-)
> > > > > > > > > > >
> > > > > > > > > > > diff --git
> > > > > > > > > > > a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > > > > > > b/drivers/gpu/drm/renesas/rz- du/rzg2l_du_drv.c
> > > > > > > > > > > index
> > > > > > > > > > > d3cccbdf9012..d102876c07e1 100644
> > > > > > > > > > > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > > > > > > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > > > > > > @@ -162,6 +162,27 @@ static int
> > > > > > > > > > > rzg2l_du_pm_resume(struct device
> > > > > > > > > > > *dev)  static DEFINE_SIMPLE_DEV_PM_OPS(rzg2l_du_pm_op=
s,
> > > > > > > > > > >  				rzg2l_du_pm_suspend, rzg2l_du_pm_resume);
> > > > > > > > > > >
> > > > > > > > > > > +/*
> > > > > > > > > > > +---------------------------------------------------
> > > > > > > > > > > +----
> > > > > > > > > > > +----
> > > > > > > > > > > +----
> > > > > > > > > > > +----
> > > > > > > > > > > +----
> > > > > > > > > > > +------
> > > > > > > > > > > + * DU instance
> > > > > > > > > > > + */
> > > > > > > > > > > +
> > > > > > > > > > > +static int rzg2l_du_instance_init(struct rzg2l_du_de=
vice *du,
> > > > > > > > > > > +				  struct drm_device *ddev) {
> > > > > > > > > > > +	struct rzg2l_du_device *rcdu;
> > > > > > > > > > > +
> > > > > > > > > > > +	rcdu =3D drmm_kzalloc(ddev, sizeof(*rcdu), GFP_KERN=
EL);
> > > > > > > > > > > +	if (!rcdu)
> > > > > > > > > > > +		return -ENOMEM;
> > > > > > > > > >
> > > > > > > > > > Why there is duplicate allocation of rcdu? One in
> > > > > > > > > > probe() and here
> > > > > > > > >
> > > > > > > > > The two allocations have different lifetimes.
> > > > > > > > >
> > > > > > > > > The one in rzg2l_du_probe() is tied to the platform devic=
e.
> > > > > > > > > It holds what is needed before the DRM device exists and
> > > > > > > > > outside of the component bind (dev, info, mmio, and
> > > > > > > > > ddev/is_master for the master, PM and remove), as on
> > > > > > > > > RZ/G3E
> > > > > > > the DRM device is only created once both instances have been =
probed.
> > > > > > > > >
> > > > > > > > > The one in rzg2l_du_instance_init() holds the KMS
> > > > > > > > > objects (crtcs, vsps, lvds, index). Their drmm cleanup
> > > > > > > > > handlers point into it and run when the DRM device is
> > > > > > > > > released, which can happen after the platform device has
> > > > > > > > > been unbound,
> > > > > > > so it has to be allocated with the DRM device.
> > > > > > > >
> > > > > > > > Then there is an issue right, platform unbound will unmap
> > > > > > > > mmio and other data structures it allocated in
> > > > > > > > rzg2l_du_probe()and drm driver is using after that( Use
> > > > > > > > after free Bug)
> > > > > > >
> > > > > > > Mmmm In theory no.
> > > > > > >
> > > > > > > The KMS part keeps its own copy of dev, info and mmio, and
> > > > > > > its drmm cleanup handlers only drop references, they don't ac=
cess the hardware.
> > > > > >
> > > > > > Can you please make sure these variables set to NULL, after
> > > > > > Platform unbound?
> > > > >
> > > > > Please correct me if I'm wrong but IMHO this patch keeps the
> > > > > same behaviour as the driver before this series.
> > > > >
> > > > > Where rcdu is embedded in the DRM device (devm_drm_dev_alloc())
> > > > > and mmio is devm managed. Setting the pointers to NULL would
> > > > > only turn an invalid access into a NULL
> > > dereference no?
> > > >
> > > > Ack.
> > > >
> > > > But why you need copy? What preventing to use original allocated
> > > > rcdu in rzg2l_du_modeset_init_du()?
> > >
> > > The copy is needed because the two DUs share one DRM device, which
> > > can only be created at bind time, once both instances have been probe=
d.
> >
> > That is ok. Both DU's share 1 DRM device.
> >
> > >
> > > Before this series, the DRM device was allocated in probe with
> > > devm_drm_dev_alloc(), and rcdu was embedded in it.
> > >
> >
> > OK.
> >
> > > Now each instance needs its own structure at probe time (dev, info,
> > > mmio), before the DRM device is allocated with devm_drm_dev_alloc() i=
n the master bind, so it is
> allocated with devm_kzalloc().
> > >
> >
> > That is ok.
> >
> > > The KMS objects (crtcs[], vsps[]) belong to the shared DRM device,
> > > so at bind time each instance allocates its own structure for them wi=
th drmm_kzalloc(), released
> with the DRM device.
> >
> > Why we need drmm_kzalloc() here? Can't we use pointer allocated with
> > devm_kzalloc() to avoid another copy?
> >
> > >
> > > Each instance copies its own dev, info and mmio into that structure,
> > > as they are used by the KMS code, e.g.
> > > rzg2l_du_crtc_set_display_timing()
> > > (mmio), rzg2l_du_encoders_init() (info) and rzg2l_du_crtc_create() (d=
ev).
> >
> > Since each probe's DU allocates rcdu, can't we reuse same rcdu for
> > holding dev, info and mmio and pass the pointer to KMS code to reuse
> > mmio,info and dev in rzg2l_du_crtc_set_display_timing(),
> > rzg2l_du_encoders_init() and
> > rzg2l_du_crtc_create()
> >
> > Is the below code[1] does not work? Do you see any issues?
> >
> > [1]
> > static int rzg2l_du_instance_init(struct rzg2l_du_device *du,
> > 				  struct drm_device *ddev)
> > {
> > 	du->ddev =3D ddev;
> >
> > 	du->index =3D ddev->mode_config.num_crtc;
> >
> > 	ret =3D rzg2l_du_modeset_init_du(du);
> > 	if (ret < 0)
> > 		return ret;
> >
> > 	if (WARN_ON(drm_crtc_index(&du->crtcs[0].crtc) !=3D du ->index))
> > 		return -EINVAL;
> >
> > 	return 0;
> > }
>=20
> TO avoid the copy maybe we can do:
>=20
> static int rzg2l_du_instance_init(struct device *dev, struct drm_device *=
ddev) {
> 	struct rzg2l_du_device *rcdu;
> 	int ret;
>=20
> 	rcdu =3D drmm_kzalloc(ddev, sizeof(*rcdu), GFP_KERNEL);
> 	if (!rcdu)
> 		return -ENOMEM;
>=20
> 	rcdu->dev =3D dev;
> 	rcdu->info =3D of_device_get_match_data(dev);
> 	rcdu->ddev =3D ddev;
>=20
> 	rcdu->mmio =3D devm_platform_ioremap_resource(to_platform_device(dev), 0=
);
> 	if (IS_ERR(rcdu->mmio))
> 		return PTR_ERR(rcdu->mmio);
>=20
> 	rcdu->index =3D ddev->mode_config.num_crtc;
>=20
> 	ret =3D rzg2l_du_modeset_init_du(rcdu);
> 	if (ret < 0)
> 		return ret;
>=20
> 	if (WARN_ON(drm_crtc_index(&rcdu->crtcs[0].crtc) !=3D rcdu->index))
> 		return -EINVAL;
>=20
> 	return 0;
> }
>=20
> In this way we can drop the devm_kzalloc() from the rzg2l_du_probe().
> Will be fine for you?

Much better.

Cheers,
Biju
