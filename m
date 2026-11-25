Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7B6606B380
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 15:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=q+HwVhLc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E8BF10FD17;
	Wed, 25 Nov 2026 15:43:02 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010049.outbound.protection.outlook.com [52.101.228.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9F5310FD17
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 15:42:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bSNARYzjTmq4emCAU02YfO/4OvoRfb1XzHFN32b+Qi/lOB3/aJPyjux48za2kFEFNWW6MrLL4J8hNvtrxY5MpuPoRtgTfR7hmLMiiOA41K5vUvfbOxWEkUVBXz2BTmHzsC8nmz9lTFWyIkltIGivgvuX3ct5PnPGiQUPRUC4wD3ZMR62lszlDFCAIPf61L2LewX4xliHeEGpaD02tyFdEAprXCWimmo9P3Z2NoPg1v76eY+KkUlG58Wt2UWmfJoVu7tm/BcDqDeW/ZV0C1Vg3VU7gn7wH18beMhKifPMA6tS8mtW6hHqHNnuXz388hOb7pC6mUuqBcythFltamdXAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51H70+L/Moo2tq1MNooRkWMBParyLJ6dgENFVsCZwi4=;
 b=Fs6WR0H13HA8cLDZ/xOEsn+AlYKKIsdxeMdfbFW25pBGCfdzaslN7WXUGB6lkQ04XCbQUmgVjOQPbGye5s5aRIdSBOXZDPQY21Te8Jtx0lE11BiQHa+mmg6FjMdEeZUGVkInFyCnXooBfe2HgTLDP0/kxs0k2LVg5It3alYQg8iZDH2P1I7KWYIKsEmxTpPJjLVwRkqARsihc3TakD6vPHyvlJBy7Wy/+A1mcCZXB1KAxsBocz2jSlOz/hXg+VrfIMWvBIaydnVM3eazgpqKuWN+VxDTu89qvxfYCuwjWD5HDOVAYDn3imJ5zD0YgQ3K5nvYYBG3Hd6b60s8ibFDCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51H70+L/Moo2tq1MNooRkWMBParyLJ6dgENFVsCZwi4=;
 b=q+HwVhLclmN76gnpfbQntCKYlbYPglMn5M10VKOi/TqFVucIYWUL3K4tbsHuUcS/lb6dI0fFdJn++qygpwTkV89Ft53TwyvbcC1IbWYcuLjK/v6RCrLei7kTQ7OSUWoC1vFwgVE0ewIrW58FYX2gN5uAPYrD9BvG0U4oh9ks2Yo=
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com (2603:1096:400:e0::9)
 by TY4PR01MB15779.jpnprd01.prod.outlook.com (2603:1096:405:2ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.5; Wed, 25 Nov
 2026 15:42:47 +0000
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f]) by TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f%5]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 15:42:43 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Tommaso Merciai <tomm.merciai@gmail.com>, 
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Geert
 Uytterhoeven <geert+renesas@glider.be>, "magnus.damm"
 <magnus.damm@gmail.com>, Laurent Pinchart
 <laurent.pinchart+renesas@ideasonboard.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v10 10/12] drm: renesas: rz-du: Support several DU
 instances in one DRM device
Thread-Topic: [PATCH v10 10/12] drm: renesas: rz-du: Support several DU
 instances in one DRM device
Thread-Index: AQHdc2mQXc9YOQBvg02jmZuHcmeGVrc781HAgAE6mgCAABQz0IAADw6AgAABgjCAAA1wAIABElhggABqnQCAAACi8IAACdYAgAAU0vA=
Date: Wed, 25 Nov 2026 15:42:43 +0000
Message-ID: <TYYPR01MB6603FEBB7A68BE8A95F930D286432@TYYPR01MB6603.jpnprd01.prod.outlook.com>
References: <e22a176720a38df652c7f7eabe27219da50f217d.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <TYYPR01MB660397C3B66F6EED53656B2086442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awV6pAtcSz8e9Q74@tom-desktop>
 <TYYPR01MB660334463EC01FCF06F7A9E586442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awWXLFAbDd_35Q-l@tom-desktop>
 <TYYPR01MB6603D650B839F808ACBA811F86442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awWkwJTxdJV1owf-@tom-desktop>
 <TYYPR01MB66037146324486059A62A60486432@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awbkUiagA_n9z521@tom-desktop>
 <OS3PR01MB65961475F4B3C1D5D781E7C486432@OS3PR01MB6596.jpnprd01.prod.outlook.com>
 <awbtGl7FghBWsW2C@tom-desktop>
In-Reply-To: <awbtGl7FghBWsW2C@tom-desktop>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6603:EE_|TY4PR01MB15779:EE_
x-ms-office365-filtering-correlation-id: bd667f39-7f5d-4961-6de3-08df4b0abede
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|7416014|366016|22082099003|18002099003|6133799003|261009223027099003|56012099006|4143699003|261028144727099003|11063799006|261022105027099003|261021121427099003|261102123227099003|261022075727099003|261021123027099003|261026121527099003|261026140227099003|38070700021|10067099003;
x-microsoft-antispam-message-info: Cv1Tg0kSGV2GpiSMa2Of9d51yhP8HSs5vJXaWNJppiGi5posUkFyyiD+ZVdc6ozVDFRrgmT6ZC07cQxA52ixvpenUbWsDQflf7XCpRuAgJdSZhzWJXIU/27BV+/jscGgrGtWtkzf0ZgD7jt9kfdvQZbAPGDGny5GLT4UXnpMYlmNk89cFcAeBeGkeYlezEt22RrNrtK9tOtQpS8oBFeBgS+2FnGdblEa9+njc5+CXZW9KPBCNjg3DDtM78XFgSGNwQQ7giuvM5DHR+cAw0xszU4jUma0+Y8Z+w4u+K8rYNpmFrVvSeitoVSyiSFc1hI23KfK9k91s0C5oz5jCuZRkZLNEiB2Lz1E4zuBNV6xDkVGFExfoEYNJamIncloTzZAEfj1GGnMOH8017OYZlrzCNGEoELX9nMxyAHkKA4wX+zgi0yq181lcsQNFX29d/GGxtPb8R0VxqQq6UHA+rWCYQZ56150Bh0NL/ChTNrVY1S4HJ2eLOw5OeRQyOZ5//DGYexfvQO573TrxXc3OTLKe8UrKIUM+7ju9sBIo5FfieCDuFGThyLetlJ1HAz53ooOCqwfyjtXT+2J+q1SQM9V6Kg0qaAtHg8B/Z/xmu9RXHFWKYPz9JsdREKB0bRIM9mOKcaNJI4Rs+JwZ1nuS7m1bLbXO/q5JaHVCor03n2bbKA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYYPR01MB6603.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(22082099003)(18002099003)(6133799003)(261009223027099003)(56012099006)(4143699003)(261028144727099003)(11063799006)(261022105027099003)(261021121427099003)(261102123227099003)(261022075727099003)(261021123027099003)(261026121527099003)(261026140227099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?u12mFoAp7Ef/lvYfmrIun8XOH85mBVHn3LOoA+DB/Sk8VriCsUb3wWbwAm?=
 =?iso-8859-1?Q?EWo8e3/PkgAu797w5IhdFIS5d41wk2E4u9yc1sWcTHrkZbQ02W9ae2UWsC?=
 =?iso-8859-1?Q?39BaE1gdwDqwOFDQO01aqanIw5tAuWVZhtyoKZr1QGwZ8bk8HaIfmNLGZq?=
 =?iso-8859-1?Q?mH9oNO+Kaw+3a5dkecZwZ1WxAYQW0vkrmxHcrzseG8EcSM+ns8cAmhVRIT?=
 =?iso-8859-1?Q?pGMPfBYOud3Vy1CUnyOYsDEBw0ggOqNtxs21aPh+SOseZt1UbAG3ma6sil?=
 =?iso-8859-1?Q?tnhZ5YGBaB3hS5PS1vGaHdGNM0EYUTv/VNkzqEKbHSXqlttqoaDr4BNotp?=
 =?iso-8859-1?Q?eCleSpqH2wQdfVrrbl1jZImnCNWjSZCjdka12XkFsMsWKNBUn9MNmZ7R3r?=
 =?iso-8859-1?Q?JQs0nzXyPfsWSSSuueQnU82lGTj0wcIpH6Vx4SmoPtR548VHDTNMmc+dn+?=
 =?iso-8859-1?Q?WAk8nVoc3Vcw+t2JNZMrx2VChLlsJuzextybxkbjtKM0I7lcG4QsCwVJos?=
 =?iso-8859-1?Q?bjDjkthqrTCXsLC4tBLENXLuLbfFXDuqymUEg+7xLHfgNXvUEe/MZleduF?=
 =?iso-8859-1?Q?dgORfbW16cxG9l+FA8WZtor9TJQpFckzqSRWpN7C/FYfvRg2DuWq5wuq30?=
 =?iso-8859-1?Q?DtqLIxpk/W/Dwfn3KjTuRPzDBgVx2xLwTRGNN2nZKlrgLukKXmmV6gJtMC?=
 =?iso-8859-1?Q?U4wvCKmfMXc3BDXun3VRw9VPkxBQO4rUYcvzC0O3CjGK7e2E28kC1/T6ps?=
 =?iso-8859-1?Q?nA+6NGIqDbB3pM0FglsT3kj0uCEFXYHC2mSEf7RjMoRo8TtWb/SSc2klwo?=
 =?iso-8859-1?Q?5Or5a1dpksA46M1I7k3o4e7pFnbBuSbIpjqCA4hGi/du9k7GH70ph12M4J?=
 =?iso-8859-1?Q?sZFV4HYsYZeusMdKTFuHgvBzvhPNzW7IjkPeVX1frYXo8J6bmF6KfKqAv3?=
 =?iso-8859-1?Q?xcPefgTLcZ9he6JBQuCTrBJRYc5FGy0jA/dPj/X2Fr10cjYmYMn3a4LYP4?=
 =?iso-8859-1?Q?5NItN/q7R6RXXVQG3Gf95Lp5xgjphrER4tMGmI3ucQG/RWIbkAHFK9s6ph?=
 =?iso-8859-1?Q?Fq1HApsvtYVNnwn570rcAMjx+RpDIR+syE7jrHoTcCuV8sTxNf/lYBmubg?=
 =?iso-8859-1?Q?4+DnGEJaM0mimmftdz/vgv5uGYgVue4tA7w5AJMj1bDuOSp2qgTcsAhtS5?=
 =?iso-8859-1?Q?IuU3ZWSiwMpSEwYXZc4B1B6477ng6DSAxYfjTghasVwunY6zorDA98Wys4?=
 =?iso-8859-1?Q?nJfZZF50Yns3HLC56LTwjPnHnQkrSirCmi1VPETl9fgu8qZDHauTTK3z+3?=
 =?iso-8859-1?Q?U8HyxZUVQeonLvj5kINd6usZBqgyh9TRJ1W59IYwh6MMYuHld0dvYEy2o1?=
 =?iso-8859-1?Q?lw0gZDQ3sIhZarC1bGEtWl6QrlPkXvwDc5tLa4EiVKniNGZjnQK+v0s21h?=
 =?iso-8859-1?Q?k9qIF9T/UyJY28bl9Sf1BHeAhZEozr5EzgHZhwsslIasMd+BYqdxVjMkxJ?=
 =?iso-8859-1?Q?DCfKuCOZdKblX3m1R6zooGM/YBgwWtnTeK6qwcKZspVpOVmRJyJFSTTkbR?=
 =?iso-8859-1?Q?YevZQ20/gYByhifOtVNkw4FA/FXsovNcOW6CDtWr+2AyF0KOG8b+sc7bPk?=
 =?iso-8859-1?Q?Pwmcyed18WqA8MZ4bYpU/nwJusJ0pEQqVSBe2vAInF+LbC4XxbJQdF3BGv?=
 =?iso-8859-1?Q?HpVHNljN4KbTGQ7GkN0DsKr0+YRInhSVjVKmx24U3q/1olAmfbxWXUDMXX?=
 =?iso-8859-1?Q?qAgHXymOTc+al/Lpn+TE2MWGcNpIVmvfDdVP7PTlTNpp8+KE+ECzZP8K8+?=
 =?iso-8859-1?Q?N3uDJ5uUNQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6603.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd667f39-7f5d-4961-6de3-08df4b0abede
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 15:42:43.3325 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GNtbfujHMSLRGYjWt0I/QG6AVWtp8Bq3jz0nabqfI0CD56QYEBHFUCKD9TnqedDjPttrxTZlVpfMQsObqmy8L0Ms0i0HCiixmXUh45qbfRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15779
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
> Sent: 25 November 2026 14:14
> Subject: Re: [PATCH v10 10/12] drm: renesas: rz-du: Support several DU in=
stances in one DRM device
>=20
> Hi Biju,
>=20
> On Wed, Nov 25, 2026 at 01:45:46PM +0000, Biju Das wrote:
> > Hi Tommaso,
> >
> > > -----Original Message-----
> > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > Sent: 25 November 2026 13:36
> > > Subject: Re: [PATCH v10 10/12] drm: renesas: rz-du: Support several
> > > DU instances in one DRM device
> > >
> > > Hi Biju,
> > >
> > > On Wed, Nov 25, 2026 at 07:28:17AM +0000, Biju Das wrote:
> > > > Hi Tommaso,
> > > >
> > > > > -----Original Message-----
> > > > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > > > Sent: 24 November 2026 14:53
> > > > > Subject: Re: [PATCH v10 10/12] drm: renesas: rz-du: Support
> > > > > several DU instances in one DRM device
> > > > >
> > > > > Hi Biju,
> > > > >
> > > > > On Tue, Nov 24, 2026 at 02:11:16PM +0000, Biju Das wrote:
> > > > > > Hi Tommaso,
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > > > > > Sent: 24 November 2026 13:59
> > > > > > > Subject: Re: [PATCH v10 10/12] drm: renesas: rz-du: Support
> > > > > > > several DU instances in one DRM device
> > > > > > >
> > > > > > > Hi Biju,
> > > > > > >
> > > > > > > On Tue, Nov 24, 2026 at 01:18:43PM +0000, Biju Das wrote:
> > > > > > > > Hi Tommaso,
> > > > > > > >
> > > > > > > > > -----Original Message-----
> > > > > > > > > From: Tommaso Merciai
> > > > > > > > > <tommaso.merciai.xr@bp.renesas.com>
> > > > > > > > > Sent: 24 November 2026 11:53
> > > > > > > > > Subject: Re: [PATCH v10 10/12] drm: renesas: rz-du:
> > > > > > > > > Support several DU instances in one DRM device
> > > > > > > > >
> > > > > > > > > Hi Biju,
> > > > > > > > > Thanks for your review.
> > > > > > > > >
> > > > > > > > > On Tue, Nov 24, 2026 at 07:47:04AM +0000, Biju Das wrote:
> > > > > > > > > > Hi Tommaso,
> > > > > > > > > >
> > > > > > > > > > > -----Original Message-----
> > > > > > > > > > > From: Tommaso Merciai
> > > > > > > > > > > <tommaso.merciai.xr@bp.renesas.com>
> > > > > > > > > > > Sent: 13 November 2026 12:20
> > > > > > > > > > > Subject: [PATCH v10 10/12] drm: renesas: rz-du:
> > > > > > > > > > > Support several DU instances in one DRM device
> > > > > > > > > > >
> > > > > > > > > > > RZ/G3E has two DU instances that share a single DRM d=
evice.
> > > > > > > > > > >
> > > > > > > > > > > Add an RZG2L_DU_FEATURE_COMPONENT flag and use the
> > > > > > > > > > > component framework for it. The first available
> > > > > > > > > DU
> > > > > > > > > > > instance is the master and creates the DRM device,
> > > > > > > > > > > the other one binds to it as a
> > > > > component.
> > > > > > > > > > >
> > > > > > > > > > > If only one DU instance is available, it creates the
> > > > > > > > > > > DRM device directly at probe time, as on SoCs without=
 the flag.
> > > > > > > > > > >
> > > > > > > > > > > Set the index of each instance to the number of CRTCs=
 already created.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Tommaso Merciai
> > > > > > > > > > > <tommaso.merciai.xr@bp.renesas.com>
> > > > > > > > > > > ---
> > > > > > > > > > > v9->v10:
> > > > > > > > > > >  - New patch.
> > > > > > > > > > >
> > > > > > > > > > >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c | 118 +=
+++++++++++++++++-
> > > > > > > > > > >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h |   2 +
> > > > > > > > > > >  2 files changed, 115 insertions(+), 5 deletions(-)
> > > > > > > > > > >
> > > > > > > > > > > diff --git
> > > > > > > > > > > a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > > > > > > b/drivers/gpu/drm/renesas/rz- du/rzg2l_du_drv.c
> > > > > > > > > > > index
> > > > > > > > > > > 93d59e2cf8a4..873586f2ef28 100644
> > > > > > > > > > > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > > > > > > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > > > > > > @@ -7,6 +7,7 @@
> > > > > > > > > > >   * Based on rcar_du_drv.c
> > > > > > > > > > >   */
> > > > > > > > > > >
> > > > > > > > > > > +#include <linux/component.h>
> > > > > > > > > > >  #include <linux/dma-mapping.h>  #include
> > > > > > > > > > > <linux/module.h> #include <linux/of.h> @@ -14,10
> > > > > > > > > > > +15,12 @@
> > > > > > > > > > >
> > > > > > > > > > >  #include <drm/clients/drm_client_setup.h>  #include
> > > > > > > > > > > <drm/drm_atomic_helper.h>
> > > > > > > > > > > +#include <drm/drm_crtc.h>
> > > > > > > > > > >  #include <drm/drm_drv.h>  #include
> > > > > > > > > > > <drm/drm_fbdev_dma.h>  #include
> > > > > > > > > > > <drm/drm_gem_dma_helper.h>  #include
> > > > > > > > > > > <drm/drm_managed.h>
> > > > > > > > > > > +#include <drm/drm_of.h>
> > > > > > > > > > >  #include <drm/drm_print.h>  #include
> > > > > > > > > > > <drm/drm_probe_helper.h>
> > > > > > > > > > >
> > > > > > > > > > > @@ -170,6 +173,7 @@ static int rzg2l_du_instance_init=
(struct rzg2l_du_device *du,
> > > > > > > > > > >  				  struct drm_device *ddev)  {
> > > > > > > > > > >  	struct rzg2l_du_device *rcdu;
> > > > > > > > > > > +	int ret;
> > > > > > > > > > >
> > > > > > > > > > >  	rcdu =3D drmm_kzalloc(ddev, sizeof(*rcdu), GFP_KERN=
EL);
> > > > > > > > > > >  	if (!rcdu)
> > > > > > > > > > > @@ -180,9 +184,28 @@ static int rzg2l_du_instance_ini=
t(struct rzg2l_du_device *du,
> > > > > > > > > > >  	rcdu->mmio =3D du->mmio;
> > > > > > > > > > >  	rcdu->ddev =3D ddev;
> > > > > > > > > > >
> > > > > > > > > > > -	return rzg2l_du_modeset_init_du(rcdu);
> > > > > > > > > > > +	rcdu->index =3D ddev->mode_config.num_crtc;
> > > > > > > > > > > +
> > > > > > > > > > > +	ret =3D rzg2l_du_modeset_init_du(rcdu);
> > > > > > > > > > > +	if (ret < 0)
> > > > > > > > > > > +		return ret;
> > > > > > > > > > > +
> > > > > > > > > > > +	if (WARN_ON(drm_crtc_index(&rcdu->crtcs[0].crtc) !=
=3D rcdu->index))
> > > > > > > > > > > +		return -EINVAL;
> > > > > > > > > > > +
> > > > > > > > > > > +	return 0;
> > > > > > > > > > >  }
> > > > > > > > > > >
> > > > > > > > > > > +static int rzg2l_du_instance_bind(struct device *dev=
, struct device *master,
> > > > > > > > > > > +				  void *data)
> > > > > > > > > > > +{
> > > > > > > > > > > +	return
> > > > > > > > > > > +rzg2l_du_instance_init(dev_get_drvdata(dev),
> > > > > > > > > > > +data); }
> > > > > > > > > > > +
> > > > > > > > > > > +static const struct component_ops rzg2l_du_instance_=
ops =3D {
> > > > > > > > > > > +	.bind =3D rzg2l_du_instance_bind, };
> > > > > > > > > > > +
> > > > > > > > > > >  /* -------------------------------------------------=
----------------------------
> > > > > > > > > > >   * DRM device
> > > > > > > > > > >   */
> > > > > > > > > > > @@ -191,7 +214,7 @@ struct rzg2l_du_drm {
> > > > > > > > > > >  	struct drm_device ddev;  };
> > > > > > > > > > >
> > > > > > > > > > > -static int rzg2l_du_drm_init(struct device *dev)
> > > > > > > > > > > +static int rzg2l_du_drm_init(struct device *dev,
> > > > > > > > > > > +bool
> > > > > > > > > > > +has_components)
> > > > > > > > > > >  {
> > > > > > > > > > >  	struct rzg2l_du_device *du =3D dev_get_drvdata(dev)=
;
> > > > > > > > > > >  	struct rzg2l_du_drm *rzgdrm; @@ -213,6 +236,12 @@
> > > > > > > > > > > static int rzg2l_du_drm_init(struct device *dev)
> > > > > > > > > > >  	if (ret < 0)
> > > > > > > > > > >  		goto error;
> > > > > > > > > > >
> > > > > > > > > > > +	if (has_components) {
> > > > > > > > > > > +		ret =3D component_bind_all(dev, ddev);
> > > > > > > > > > > +		if (ret < 0)
> > > > > > > > > > > +			goto error;
> > > > > > > > > > > +	}
> > > > > > > > > > > +
> > > > > > > > > > >  	ret =3D rzg2l_du_modeset_init_finish(ddev);
> > > > > > > > > > >  	if (ret < 0)
> > > > > > > > > > >  		goto error_fini;
> > > > > > > > > > > @@ -235,6 +264,8 @@ static int
> > > > > > > > > > > rzg2l_du_drm_init(struct device
> > > > > > > > > > > *dev)
> > > > > > > > > > >
> > > > > > > > > > >  error_fini:
> > > > > > > > > > >  	drm_kms_helper_poll_fini(ddev);
> > > > > > > > > > > +	if (has_components)
> > > > > > > > > > > +		component_unbind_all(dev, ddev);
> > > > > > > > > > >  error:
> > > > > > > > > > >  	/*
> > > > > > > > > > >  	 * Don't use dev_err_probe(), as it would
> > > > > > > > > > > overwrite the probe deferral @@ -246,7 +277,7 @@
> > > > > > > > > > > static int rzg2l_du_drm_init(struct device
> > > *dev)
> > > > > > > > > > >  	return ret;
> > > > > > > > > > >  }
> > > > > > > > > > >
> > > > > > > > > > > -static void rzg2l_du_drm_fini(struct device *dev)
> > > > > > > > > > > +static void rzg2l_du_drm_fini(struct device *dev,
> > > > > > > > > > > +bool
> > > > > > > > > > > +has_components)
> > > > > > > > > > >  {
> > > > > > > > > > >  	struct rzg2l_du_device *du =3D dev_get_drvdata(dev)=
;
> > > > > > > > > > >  	struct drm_device *ddev =3D du->ddev; @@ -254,6
> > > > > > > > > > > +285,83 @@ static void rzg2l_du_drm_fini(struct devic=
e *dev)
> > > > > > > > > > >  	drm_dev_unregister(ddev);
> > > > > > > > > > >  	drm_atomic_helper_shutdown(ddev);
> > > > > > > > > > >  	drm_kms_helper_poll_fini(ddev);
> > > > > > > > > > > +
> > > > > > > > > > > +	if (has_components)
> > > > > > > > > > > +		component_unbind_all(dev, ddev);
> > > > > > > > > > > +
> > > > > > > > > > > +	du->ddev =3D NULL;
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > > +/*
> > > > > > > > > > > +---------------------------------------------------
> > > > > > > > > > > +----
> > > > > > > > > > > +--------
> > > > > > > > > > > +--------
> > > > > > > > > > > +------
> > > > > > > > > > > + * Component master  */
> > > > > > > > > > > +
> > > > > > > > > > > +static int rzg2l_du_master_bind(struct device *dev) =
{
> > > > > > > > > > > +	return rzg2l_du_drm_init(dev, true); }
> > > > > > > > > > > +
> > > > > > > > > > > +static void rzg2l_du_master_unbind(struct device *de=
v) {
> > > > > > > > > > > +	rzg2l_du_drm_fini(dev, true); }
> > > > > > > > > > > +
> > > > > > > > > > > +static const struct component_master_ops rzg2l_du_ma=
ster_ops =3D {
> > > > > > > > > > > +	.bind =3D rzg2l_du_master_bind,
> > > > > > > > > > > +	.unbind =3D rzg2l_du_master_unbind, };
> > > > > > > > > > > +
> > > > > > > > > > > +static int rzg2l_du_instance_probe(struct rzg2l_du_d=
evice *du) {
> > > > > > > > > > > +	struct component_match *match =3D NULL;
> > > > > > > > > > > +	const struct of_device_id *of_id;
> > > > > > > > > > > +	struct device *dev =3D du->dev;
> > > > > > > > > > > +
> > > > > > > > > > > +	if (!rzg2l_du_has(du, RZG2L_DU_FEATURE_COMPONENT))
> > > > > > > > > > > +		return rzg2l_du_drm_init(dev, false);
> > > > > > > > > > > +
> > > > > > > > > > > +	for_each_available_child_of_node_scoped(dev->of_nod=
e->parent, np) {
> > > > > > > > > > > +		of_id =3D of_match_node(dev->driver->of_match_tabl=
e, np);
> > > > > > > > > > > +		if (!of_id || of_id->data !=3D du->info)
> > > > > > > > > > > +			continue;
> > > > > > > > > > > +
> > > > > > > > > > > +		/* The first available DU instance is the componen=
t master. */
> > > > > > > > > > > +		if (!du->is_master) {
> > > > > > > > > > > +			if (np !=3D dev->of_node)
> > > > > > > > > > > +				return component_add(dev,
> > > > > > > > > > > +&rzg2l_du_instance_ops);
> > > > > > > > > > > +
> > > > > > > > > > > +			du->is_master =3D true;
> > > > > > > > > > > +			continue;
> > > > > > > > > > > +		}
> > > > > > > > > > > +
> > > > > > > > > > > +		drm_of_component_match_add(dev, &match,
> > > > > > > > > > > +component_compare_of, np);
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > The master=A0is chosen purely by DT order. If the first
> > > > > > > > > > available DU never probes, the second never gets a DRM
> > > > > > > > > > device. How do you handle this
> > > case?
> > > > > > > > >
> > > > > > > > > All available instances are part of the component match,
> > > > > > > > > so the DRM device is only created once all of them have
> > > > > > > > > probed, whichever one is the master.
> > > > > > > > >
> > > > > > > > > This is how the component framework works.
> > > > > > > > >
> > > > > > > > > To use a single DU, the other one can be disabled in DT,
> > > > > > > > > in this case the remaining instance becomes the master
> > > > > > > > > and initializes the DRM device on its own.
> > > > > > > >
> > > > > > > >
> > > > > > > > Assume both DU's available and run time
> > > > > > > >
> > > > > > > > second DU is probed first and master never probed at all.
> > > > > > > > What is the state of second DU as bind never calls?
> > > > > > >
> > > > > > >
> > > > > > > The second DU probes, registers itself with component_add()
> > > > > > > and stays idle, without touching the hardware.
> > > > > > >
> > > > > > > When the master probes, both instances are bound and the DRM =
device is created.
> > > > > > >
> > > > > > > If the master never probes, there is no DRM device, because
> > > > > > > the bind is only triggered once the
> > > > > master
> > > > > > > has registered the aggregate device with
> > > > > > > component_master_add_with_match()
> > > > > >
> > > > > > Not sure is it the normal use case? DU0 and DU1 are
> > > > > > independent devices
> > > > > >
> > > > > > 1) DU0 or DU1 should work independently irrespective of the pro=
be failure of
> > > > > >    other device
> > > > > >
> > > > > > 2) When both DU's are probed, then we need to aggregate the dev=
ice using component
> > > > > >    framework so that use case like dynamically switching DSI0 t=
o DSI1 can be achieved.
> > > > >
> > > > > IMHO 1) and 2) can't be achieved together.
> > > > >
> > > >
> > > > I guess we can achieve both use cases, if we define a companion pro=
perty in the second device.
> > > > This is a static design choice left to the DT user to choose betwee=
n either 1 or 2.
> > > >
> > > > Krystof/Rob/Conor: Is it ok to add optional companion property to
> > > > support both
> > > > 1 and 2? Otherwise, we plan to stick with use case 2.
> > > >
> > > > Use case 1: 1 DRM device per DU
> > >
> > > Some clarification:
> > >
> > > For 1)
> > >
> > > Just FYI, the series already supports this when only one DU is
> > > enabled in DT. If only DU0 (or only
> > > DU1) is enabled, it creates its own DRM device directly, without the
> > > component framework, and we will get 1 DRM device with 1 CRTC.
> > >
> > >
> > > # r9a09g047e57-smarc-du0-dsi.dtso
> > >
> > > &du0 {
> > > 	status =3D "okay";
> > > };
> > >
> > > &du1 {
> > > 	status =3D "disabled";
> > > };
> > >
> > > > Use case 2: 1 DRM device for 2 DU's
> > >
> > > For 2)
> > >
> > > When both DU0 and DU1 are enabled, DU0 registers the aggregate
> > > device with
> > > component_master_add_with_match() and DU1 registers itself with
> > > component_add(). Both are driven by the same DRM device, with 2 CRTCs=
.
> > >
> > >
> > > &du0 {
> > > 	status =3D "okay";
> > > };
> > >
> > > &du1 {
> > > 	status =3D "okay";
> > > };
> >
> > DU0 and DU1 are independent devices.
> > Currently if DU0 fails to probe, DU1 won't work.
> > So, there is a limitation in the current design.
>=20
> Mmmm, checking better the others vendor drivers I can see the same behavi=
our:
> if one member of the aggregate fails to probe, the others won't work eith=
er.
>=20
> mtk_drm_drv.c driver where we have vdosys0 and vdosys1 [1] that are shari=
ng the same drm device. And
> also in this case if one fails to probe there is no drm device.
>=20
> Same for rk3399-base.dtsi where we have vopl_out and vopb_out [2] Same fo=
r imx6q.dtsi with ipu1_di0,
> ipu1_di1, ipu2_di0, ipu2_di1 [3] Same for sun7i-a20.dtsi where we have fe=
0, fe1 [4]
>=20
> Please correct me if I'm wrong.
>=20
> [1] https://elixir.bootlin.com/linux/v7.4-rc1/source/drivers/gpu/drm/medi=
atek/mtk_drm_drv.c#L374
> [2] https://elixir.bootlin.com/linux/v7.4-rc1/source/arch/arm64/boot/dts/=
rockchip/rk3399-
> base.dtsi#L245
> [3] https://elixir.bootlin.com/linux/v7.4-rc1/source/arch/arm/boot/dts/nx=
p/imx/imx6q.dtsi#L304
> [4] https://elixir.bootlin.com/linux/v7.4-rc1/source/arch/arm/boot/dts/al=
lwinner/sun7i-a20.dtsi#L254
>=20

Thanks for the link. After googling

Separate DRM devices (card0 + card1) are only advantageous when physical is=
olation is mandatory
(e.g., safety-critical medical or automotive instrument clusters where a pr=
imary gauge cluster
cannot share a kernel driver/compositor with an infotainment screen) and no=
 one normally
split SoC display engine for such use case. So, I think we can go with sing=
le DRM card
approach and no need to support 2 separate DRM cards.

Cheers,
Biju
