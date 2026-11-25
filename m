Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F005C606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 17:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=JlRPztLB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4017510FDAF;
	Wed, 25 Nov 2026 17:17:13 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010016.outbound.protection.outlook.com [52.101.228.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C31AB10FDAF
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 17:17:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IybvIvAa+g0lBDv6jWWgs02z/sSbq0zPEusHWB8QHgfv1KOKLA9UVE0ZmUlzJYYugI84CBA+DUNDqSg8BoLFB1z8gfcTram04Ef/ml1BAADHJlVwRgzBldSiF99ovrv8SAyUAc4P7IN4pGb7ytoBOEf+pM+7rzZQD5BFuyUFkPKR0tMVRLNEKF2W0c8CUmvCfP+YaUWz4NYWVnN6z8hXJvipHUQ1FpgnXfsPzq+nIZOZfrdsZ7hDn+SNFrsXbtZG9Pa/lSbrXlMoaq3qyaeenS5zObZdprc0FHkOYWMz2PN4UPSG1rwAS04daKJlIt1tcVsQ11CT6+RkJDyGu2nUmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wa1j6SmJMF0VOo2KAzUzjZQOBrSmp1seAMmE8/RTAbs=;
 b=rsB6Ec1U8kyUfh51Qqy3DO+a6cYmmZtJF/V7exV4BbdCwI2KDgHyYb5p/MhdpK409qr4wchriBfxCqEvakCGaSd76onK00l9VzV7ONUKEBUbBpFT+kIj5zqjHqe277jAqAK0a9zrKyj/UsDbnVMAiDu05X4JpgeTLa4PpaGBRoyCxL/NSWDmksGaUX+ZhHJhtsyCuVentPY2JjZDz3OC8du7PbuIMx+kYFC5qdpHEm5UijcVxyOAfPuI5WcTeQITArUXHXzFcgYHE9vBRVNvZKrK/NTstNFpDf8MRNNQg0qmhKnW6haACcpQoBfxDfwYEY9io7mshPSehIYkLRRZKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wa1j6SmJMF0VOo2KAzUzjZQOBrSmp1seAMmE8/RTAbs=;
 b=JlRPztLB4ygdbSY/ASLrHDze9/az3Y3tDrgtrTLcUTYS4sm8d4YAGFn1gFbWCsWmzD8KrQcEiQishPZqeAfkCiQM+pjofriZjI9X0iYRFmXS8iiE8K+wBVdRr41GQ3lwC6GkNPEMcoKM3yByQ9MyfWTLbF6BR3xyPb6RiemVpfQ=
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com (2603:1096:400:e0::9)
 by OSCPR01MB13656.jpnprd01.prod.outlook.com (2603:1096:604:37f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.5; Wed, 25 Nov
 2026 17:17:00 +0000
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f]) by TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f%5]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 17:17:00 +0000
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
Thread-Index: AQHdc2mQXc9YOQBvg02jmZuHcmeGVrc781HAgAE6mgCAABQz0IAADw6AgAABgjCAAA1wAIABElhggABqnQCAAACi8IAACdYAgAAU0vCAABvmgIAAAOFw
Date: Wed, 25 Nov 2026 17:17:00 +0000
Message-ID: <TYYPR01MB66030DEFEA6F409C3890ED4586432@TYYPR01MB6603.jpnprd01.prod.outlook.com>
References: <awV6pAtcSz8e9Q74@tom-desktop>
 <TYYPR01MB660334463EC01FCF06F7A9E586442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awWXLFAbDd_35Q-l@tom-desktop>
 <TYYPR01MB6603D650B839F808ACBA811F86442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awWkwJTxdJV1owf-@tom-desktop>
 <TYYPR01MB66037146324486059A62A60486432@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awbkUiagA_n9z521@tom-desktop>
 <OS3PR01MB65961475F4B3C1D5D781E7C486432@OS3PR01MB6596.jpnprd01.prod.outlook.com>
 <awbtGl7FghBWsW2C@tom-desktop>
 <TYYPR01MB6603FEBB7A68BE8A95F930D286432@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awcV-el2FwqD6pC1@tom-desktop>
In-Reply-To: <awcV-el2FwqD6pC1@tom-desktop>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6603:EE_|OSCPR01MB13656:EE_
x-ms-office365-filtering-correlation-id: aea99cac-239a-49c0-cee0-08df4b17eaae
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|23010399003|1800799024|38070700021|10067099003|11063799006|4143699003|56012099006|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261026140227099003|261028144727099003|261026121527099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: g4eqch2Jc9PyJhStfV+MYexm/0KGiSVcaqu5lfpgjZCQNl/K1xBh47Vcm9c/KScjgSpf9r270PgaRBvYRJoIJwMO057L1jUcs2kHp40Xm1U9CKp9ETYgeYoarTMWLuTOYIlSzhttR+mvTFUx4u5v8udZtxwGcv0HTh+sSpImvpySNaA0Bvnw2PmfubcZU94UmETuaH2dJdC9vDLiRui8NicLL4P2BZE3AfA8WzSeegxewBQ5r1tayPSMT+KOtJVpLIHVo3HAXKn12RTttBSSINq7xeCRE2mAp2DuZumk6RL6cHCTFoFz0JEiBUZYze+kIKaCcmeM8utjFIbEu1u9j5FZIMwlqUlGZjLE99awmzvgj7rRs02q1VtauZ3QTbue6kBpB1M1DwOUscyQKdkwTxOcMaA3whW+6HC/WboMyojRp8DwX7EP2j7gfxkBOyRNPcr7UyirrIQIm3B12eTWU7JyO/sJyJ0XwB1HQ9qZ0qyB+19OqFie/jEtiSrWDc8zlBz4/7XfAik1GgwMQtGyFk/RFmxdLSxWvFfYR/oe3crK/LpBvZdCpgT9NN/G0u5RpsD9F9VRM/CcFNr1zIpL/0YTu+zWked8N38+7uBQwO1JKOU0qN5sZ/ntTK/d/ofsfSvgp5hN8P/4NwZN4jxK7YxZtTCgY8c49s9krDZCXMI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYYPR01MB6603.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(23010399003)(1800799024)(38070700021)(10067099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261026140227099003)(261028144727099003)(261026121527099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?d62wQGM/nH1SgCZWUalVnxFQepz8F02TQDR67I4OsB9pkP71WojMw0vCgT?=
 =?iso-8859-1?Q?/X8c0RK8Eq0Hbbv6ELFhIi/vLId7BWaKRB4aNYCWJODlOz372m+J3Qnb+p?=
 =?iso-8859-1?Q?Ys2p0hqiGDzim7B/gIEhjDWdt+k3H48qJzcwUT3bxL/pbNhT4DFIBT4xZu?=
 =?iso-8859-1?Q?0bsleaWN91d5//yg0pnaQxKKzS9S3oEidVdjjvlEdS5Regq7/JYUh4Ox7E?=
 =?iso-8859-1?Q?WuuGStkYz4gnnOMoSeCDA/bE4H60bW9TvN5/PZUfQ8eT4PPsq8/SpZT2F9?=
 =?iso-8859-1?Q?3A5rzcgoxSgcGeP+0qymTeQpQXlKq+VlhlPYC4be0Tf/bCoU2ighFMWm++?=
 =?iso-8859-1?Q?laPWxxSK1l3YrFOoe8O3BQPY7qqKX0xAxGgHKqv4rOKkMXB0LgquWAF/76?=
 =?iso-8859-1?Q?qwZM9C2vCbOrOFJCiuerWace7fGhRTv/fU/oJe/TM0DXZGKYozIPmsJIPm?=
 =?iso-8859-1?Q?ZAuMZD0nucNuS+j+mQAG9GDIAGoHBckWhihFKh6qrlKowzKRTzPMjjYyMu?=
 =?iso-8859-1?Q?KzSrp/0a9BPEu6dzxcmlIuK55mHSyRPlB99LcNH149y8Yy2enG2bQsJ3JQ?=
 =?iso-8859-1?Q?7eOH0EJwrvbVYjb7LXBo9+CjhRih1NuvYkuiua1P6U4ujnrWgiiPyIsIEV?=
 =?iso-8859-1?Q?KEMg56OhiJHqvxtSpma+i3q/eA6g5wI/11SOubRsbXCuhNEibeDyHyE9wk?=
 =?iso-8859-1?Q?1v4Lrf9zjMRZ2+YRDBMVPabIjuT3DtpjZ4mQadMxNiR+AtFpaGGCehwONW?=
 =?iso-8859-1?Q?LEhmSLZY7jDEaTxfH/M+QUejBo+nnto6ir9L8I/jzjT/D3V3G3f46BRZs5?=
 =?iso-8859-1?Q?iTfauAzA4YWqKdUp9oQbDXynaDCxguNWVyHp7k7pxe+itHCdiw838tC2zq?=
 =?iso-8859-1?Q?BEe29bnO9qgKKyHKXfzPdbATgPYhEWnsONGnuZQ05uzk7XqwW04bJODRFK?=
 =?iso-8859-1?Q?pn7FAapKQRd/mtyvLmOPQy6hn/JZDs1ny6jxjePV8H+tSH8hqYsDs0f8RR?=
 =?iso-8859-1?Q?E5pH+JI5R9GLqeIvBRNN4dSZkguIqCsQaeJZ0Cj9XYZ0GUlrY4Mib4Bk5T?=
 =?iso-8859-1?Q?RX29OGXMTcn7CfOLBM/TThZWZR3VVnCoRqAPo7KQvJqLymup8K98LQN8wA?=
 =?iso-8859-1?Q?KTwKloJ9+wT7N9qPH6iWTebtiup90mNP1Z8GxL/qhXYBeuNKGu106XELTE?=
 =?iso-8859-1?Q?9NNXGJLU7B3syfgmdVujSyOt/2zw7VNv8U80vgoqR7BoqmZc7jvNwuwThW?=
 =?iso-8859-1?Q?J62GThS2iDUIcPAINCmK1oGGHzdRxi0jWDCkwZGBwcw4cKQjdzqV9P4ihU?=
 =?iso-8859-1?Q?5HD2KY22Ze2ZoLMnoKRmDX4NU2E+66VIVDbyt2c2BQb2kf8R99eNBiFCAk?=
 =?iso-8859-1?Q?3iOtHTuEljYfQHn/f4DfVmnj7UnPLfTe5TCdkg8j48rOVAlhHw0QcWM8Ci?=
 =?iso-8859-1?Q?zM94dh3pyoextbsqK/7MG5B45w3fBOSgH9UNYLoV0mUUtieq4eizDO8okw?=
 =?iso-8859-1?Q?TYg9jD+QmXLjwvAQWMNuoAp3Pq8qf4DeNvL8BfPojF81oWJ6PJXiXtxujv?=
 =?iso-8859-1?Q?kXyHDVpl2fUWCwjexYUrKLYC76xtg/NgM2rGlrrQuT84cJZgqZ2/K3HFvL?=
 =?iso-8859-1?Q?iXQw0O2+HGW1x2bNCBjHuwPkCMdkhXLTCcxyr1DGj2Ut5hmTb1MFAjlbDU?=
 =?iso-8859-1?Q?aYsw3XuHTSqEWpztZJm8AlqEKzupfEcgJkGehtP6mV4fpMePJmHcmnmlh5?=
 =?iso-8859-1?Q?sl9/mqVOr68cbEPQh5puMwd16QaewXuP/V2G8npC5S6HWaMpl7f9gzDVBS?=
 =?iso-8859-1?Q?NycVOty6WQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6603.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aea99cac-239a-49c0-cee0-08df4b17eaae
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 17:17:00.2576 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QUwXfXoabt91zcGgvlfkI8BIlZfSkhrR6XKvajVpV7cEGUHZiSODFrYxrubL2ZwB31JewSRbGjdXUZqG6emNCTcPXYI3Ejq3E0dqqLParhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13656
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

Tommaso,

> -----Original Message-----
> From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Sent: 25 November 2026 17:08
> Subject: Re: [PATCH v10 10/12] drm: renesas: rz-du: Support several DU in=
stances in one DRM device
>=20
> Hi Biju,
>=20
> On Wed, Nov 25, 2026 at 03:42:43PM +0000, Biju Das wrote:
> > Hi Tommaso,
> >
> > > -----Original Message-----
> > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > Sent: 25 November 2026 14:14
> > > Subject: Re: [PATCH v10 10/12] drm: renesas: rz-du: Support several
> > > DU instances in one DRM device
> > >
> > > Hi Biju,
> > >
> > > On Wed, Nov 25, 2026 at 01:45:46PM +0000, Biju Das wrote:
> > > > Hi Tommaso,
> > > >
> > > > > -----Original Message-----
> > > > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > > > Sent: 25 November 2026 13:36
> > > > > Subject: Re: [PATCH v10 10/12] drm: renesas: rz-du: Support
> > > > > several DU instances in one DRM device
> > > > >
> > > > > Hi Biju,
> > > > >
> > > > > On Wed, Nov 25, 2026 at 07:28:17AM +0000, Biju Das wrote:
> > > > > > Hi Tommaso,
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > > > > > Sent: 24 November 2026 14:53
> > > > > > > Subject: Re: [PATCH v10 10/12] drm: renesas: rz-du: Support
> > > > > > > several DU instances in one DRM device
> > > > > > >
> > > > > > > Hi Biju,
> > > > > > >
> > > > > > > On Tue, Nov 24, 2026 at 02:11:16PM +0000, Biju Das wrote:
> > > > > > > > Hi Tommaso,
> > > > > > > >
> > > > > > > > > -----Original Message-----
> > > > > > > > > From: Tommaso Merciai
> > > > > > > > > <tommaso.merciai.xr@bp.renesas.com>
> > > > > > > > > Sent: 24 November 2026 13:59
> > > > > > > > > Subject: Re: [PATCH v10 10/12] drm: renesas: rz-du:
> > > > > > > > > Support several DU instances in one DRM device
> > > > > > > > >
> > > > > > > > > Hi Biju,
> > > > > > > > >
> > > > > > > > > On Tue, Nov 24, 2026 at 01:18:43PM +0000, Biju Das wrote:
> > > > > > > > > > Hi Tommaso,
> > > > > > > > > >
> > > > > > > > > > > -----Original Message-----
> > > > > > > > > > > From: Tommaso Merciai
> > > > > > > > > > > <tommaso.merciai.xr@bp.renesas.com>
> > > > > > > > > > > Sent: 24 November 2026 11:53
> > > > > > > > > > > Subject: Re: [PATCH v10 10/12] drm: renesas: rz-du:
> > > > > > > > > > > Support several DU instances in one DRM device
> > > > > > > > > > >
> > > > > > > > > > > Hi Biju,
> > > > > > > > > > > Thanks for your review.
> > > > > > > > > > >
> > > > > > > > > > > On Tue, Nov 24, 2026 at 07:47:04AM +0000, Biju Das wr=
ote:
> > > > > > > > > > > > Hi Tommaso,
> > > > > > > > > > > >
> > > > > > > > > > > > > -----Original Message-----
> > > > > > > > > > > > > From: Tommaso Merciai
> > > > > > > > > > > > > <tommaso.merciai.xr@bp.renesas.com>
> > > > > > > > > > > > > Sent: 13 November 2026 12:20
> > > > > > > > > > > > > Subject: [PATCH v10 10/12] drm: renesas: rz-du:
> > > > > > > > > > > > > Support several DU instances in one DRM device
> > > > > > > > > > > > >
> > > > > > > > > > > > > RZ/G3E has two DU instances that share a single D=
RM device.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Add an RZG2L_DU_FEATURE_COMPONENT flag and use
> > > > > > > > > > > > > the component framework for it. The first
> > > > > > > > > > > > > available
> > > > > > > > > > > DU
> > > > > > > > > > > > > instance is the master and creates the DRM
> > > > > > > > > > > > > device, the other one binds to it as a
> > > > > > > component.
> > > > > > > > > > > > >
> > > > > > > > > > > > > If only one DU instance is available, it creates
> > > > > > > > > > > > > the DRM device directly at probe time, as on SoCs=
 without the flag.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Set the index of each instance to the number of C=
RTCs already created.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Signed-off-by: Tommaso Merciai
> > > > > > > > > > > > > <tommaso.merciai.xr@bp.renesas.com>
> > > > > > > > > > > > > ---
> > > > > > > > > > > > > v9->v10:
> > > > > > > > > > > > >  - New patch.
> > > > > > > > > > > > >
> > > > > > > > > > > > >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c | 1=
18 ++++++++++++++++++-
> > > > > > > > > > > > >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h |  =
 2 +
> > > > > > > > > > > > >  2 files changed, 115 insertions(+), 5
> > > > > > > > > > > > > deletions(-)
> > > > > > > > > > > > >
> > > > > > > > > > > > > diff --git
> > > > > > > > > > > > > a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > > > > > > > > b/drivers/gpu/drm/renesas/rz- du/rzg2l_du_drv.c
> > > > > > > > > > > > > index
> > > > > > > > > > > > > 93d59e2cf8a4..873586f2ef28 100644
> > > > > > > > > > > > > ---
> > > > > > > > > > > > > a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > > > > > > > > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv
> > > > > > > > > > > > > +++ .c
> > > > > > > > > > > > > @@ -7,6 +7,7 @@
> > > > > > > > > > > > >   * Based on rcar_du_drv.c
> > > > > > > > > > > > >   */
> > > > > > > > > > > > >
> > > > > > > > > > > > > +#include <linux/component.h>
> > > > > > > > > > > > >  #include <linux/dma-mapping.h>  #include
> > > > > > > > > > > > > <linux/module.h> #include <linux/of.h> @@ -14,10
> > > > > > > > > > > > > +15,12 @@
> > > > > > > > > > > > >
> > > > > > > > > > > > >  #include <drm/clients/drm_client_setup.h>
> > > > > > > > > > > > > #include <drm/drm_atomic_helper.h>
> > > > > > > > > > > > > +#include <drm/drm_crtc.h>
> > > > > > > > > > > > >  #include <drm/drm_drv.h>  #include
> > > > > > > > > > > > > <drm/drm_fbdev_dma.h>  #include
> > > > > > > > > > > > > <drm/drm_gem_dma_helper.h>  #include
> > > > > > > > > > > > > <drm/drm_managed.h>
> > > > > > > > > > > > > +#include <drm/drm_of.h>
> > > > > > > > > > > > >  #include <drm/drm_print.h>  #include
> > > > > > > > > > > > > <drm/drm_probe_helper.h>
> > > > > > > > > > > > >
> > > > > > > > > > > > > @@ -170,6 +173,7 @@ static int rzg2l_du_instance_=
init(struct rzg2l_du_device
> *du,
> > > > > > > > > > > > >  				  struct drm_device *ddev)  {
> > > > > > > > > > > > >  	struct rzg2l_du_device *rcdu;
> > > > > > > > > > > > > +	int ret;
> > > > > > > > > > > > >
> > > > > > > > > > > > >  	rcdu =3D drmm_kzalloc(ddev, sizeof(*rcdu), GFP_=
KERNEL);
> > > > > > > > > > > > >  	if (!rcdu)
> > > > > > > > > > > > > @@ -180,9 +184,28 @@ static int rzg2l_du_instance=
_init(struct rzg2l_du_device
> *du,
> > > > > > > > > > > > >  	rcdu->mmio =3D du->mmio;
> > > > > > > > > > > > >  	rcdu->ddev =3D ddev;
> > > > > > > > > > > > >
> > > > > > > > > > > > > -	return rzg2l_du_modeset_init_du(rcdu);
> > > > > > > > > > > > > +	rcdu->index =3D ddev->mode_config.num_crtc;
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +	ret =3D rzg2l_du_modeset_init_du(rcdu);
> > > > > > > > > > > > > +	if (ret < 0)
> > > > > > > > > > > > > +		return ret;
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +	if (WARN_ON(drm_crtc_index(&rcdu->crtcs[0].crtc=
) !=3D rcdu->index))
> > > > > > > > > > > > > +		return -EINVAL;
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +	return 0;
> > > > > > > > > > > > >  }
> > > > > > > > > > > > >
> > > > > > > > > > > > > +static int rzg2l_du_instance_bind(struct device =
*dev, struct device *master,
> > > > > > > > > > > > > +				  void *data) {
> > > > > > > > > > > > > +	return
> > > > > > > > > > > > > +rzg2l_du_instance_init(dev_get_drvdata(dev),
> > > > > > > > > > > > > +data); }
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +static const struct component_ops rzg2l_du_insta=
nce_ops =3D {
> > > > > > > > > > > > > +	.bind =3D rzg2l_du_instance_bind, };
> > > > > > > > > > > > > +
> > > > > > > > > > > > >  /* ---------------------------------------------=
-----------------------------
> ---
> > > > > > > > > > > > >   * DRM device
> > > > > > > > > > > > >   */
> > > > > > > > > > > > > @@ -191,7 +214,7 @@ struct rzg2l_du_drm {
> > > > > > > > > > > > >  	struct drm_device ddev;  };
> > > > > > > > > > > > >
> > > > > > > > > > > > > -static int rzg2l_du_drm_init(struct device
> > > > > > > > > > > > > *dev)
> > > > > > > > > > > > > +static int rzg2l_du_drm_init(struct device
> > > > > > > > > > > > > +*dev, bool
> > > > > > > > > > > > > +has_components)
> > > > > > > > > > > > >  {
> > > > > > > > > > > > >  	struct rzg2l_du_device *du =3D dev_get_drvdata(=
dev);
> > > > > > > > > > > > >  	struct rzg2l_du_drm *rzgdrm; @@ -213,6 +236,12
> > > > > > > > > > > > > @@ static int rzg2l_du_drm_init(struct device *de=
v)
> > > > > > > > > > > > >  	if (ret < 0)
> > > > > > > > > > > > >  		goto error;
> > > > > > > > > > > > >
> > > > > > > > > > > > > +	if (has_components) {
> > > > > > > > > > > > > +		ret =3D component_bind_all(dev, ddev);
> > > > > > > > > > > > > +		if (ret < 0)
> > > > > > > > > > > > > +			goto error;
> > > > > > > > > > > > > +	}
> > > > > > > > > > > > > +
> > > > > > > > > > > > >  	ret =3D rzg2l_du_modeset_init_finish(ddev);
> > > > > > > > > > > > >  	if (ret < 0)
> > > > > > > > > > > > >  		goto error_fini; @@ -235,6 +264,8 @@ static
> > > > > > > > > > > > > int rzg2l_du_drm_init(struct device
> > > > > > > > > > > > > *dev)
> > > > > > > > > > > > >
> > > > > > > > > > > > >  error_fini:
> > > > > > > > > > > > >  	drm_kms_helper_poll_fini(ddev);
> > > > > > > > > > > > > +	if (has_components)
> > > > > > > > > > > > > +		component_unbind_all(dev, ddev);
> > > > > > > > > > > > >  error:
> > > > > > > > > > > > >  	/*
> > > > > > > > > > > > >  	 * Don't use dev_err_probe(), as it would
> > > > > > > > > > > > > overwrite the probe deferral @@ -246,7 +277,7 @@
> > > > > > > > > > > > > static int rzg2l_du_drm_init(struct device
> > > > > *dev)
> > > > > > > > > > > > >  	return ret;
> > > > > > > > > > > > >  }
> > > > > > > > > > > > >
> > > > > > > > > > > > > -static void rzg2l_du_drm_fini(struct device
> > > > > > > > > > > > > *dev)
> > > > > > > > > > > > > +static void rzg2l_du_drm_fini(struct device
> > > > > > > > > > > > > +*dev, bool
> > > > > > > > > > > > > +has_components)
> > > > > > > > > > > > >  {
> > > > > > > > > > > > >  	struct rzg2l_du_device *du =3D dev_get_drvdata(=
dev);
> > > > > > > > > > > > >  	struct drm_device *ddev =3D du->ddev; @@ -254,6
> > > > > > > > > > > > > +285,83 @@ static void rzg2l_du_drm_fini(struct
> > > > > > > > > > > > > +device *dev)
> > > > > > > > > > > > >  	drm_dev_unregister(ddev);
> > > > > > > > > > > > >  	drm_atomic_helper_shutdown(ddev);
> > > > > > > > > > > > >  	drm_kms_helper_poll_fini(ddev);
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +	if (has_components)
> > > > > > > > > > > > > +		component_unbind_all(dev, ddev);
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +	du->ddev =3D NULL; }
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +/*
> > > > > > > > > > > > > +-----------------------------------------------
> > > > > > > > > > > > > +----
> > > > > > > > > > > > > +----
> > > > > > > > > > > > > +--------
> > > > > > > > > > > > > +--------
> > > > > > > > > > > > > +------
> > > > > > > > > > > > > + * Component master  */
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +static int rzg2l_du_master_bind(struct device *d=
ev) {
> > > > > > > > > > > > > +	return rzg2l_du_drm_init(dev, true); }
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +static void rzg2l_du_master_unbind(struct device=
 *dev) {
> > > > > > > > > > > > > +	rzg2l_du_drm_fini(dev, true); }
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +static const struct component_master_ops rzg2l_d=
u_master_ops =3D {
> > > > > > > > > > > > > +	.bind =3D rzg2l_du_master_bind,
> > > > > > > > > > > > > +	.unbind =3D rzg2l_du_master_unbind, };
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +static int rzg2l_du_instance_probe(struct rzg2l_=
du_device *du) {
> > > > > > > > > > > > > +	struct component_match *match =3D NULL;
> > > > > > > > > > > > > +	const struct of_device_id *of_id;
> > > > > > > > > > > > > +	struct device *dev =3D du->dev;
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +	if (!rzg2l_du_has(du, RZG2L_DU_FEATURE_COMPONEN=
T))
> > > > > > > > > > > > > +		return rzg2l_du_drm_init(dev, false);
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +	for_each_available_child_of_node_scoped(dev->of=
_node->parent, np) {
> > > > > > > > > > > > > +		of_id =3D of_match_node(dev->driver->of_match_=
table, np);
> > > > > > > > > > > > > +		if (!of_id || of_id->data !=3D du->info)
> > > > > > > > > > > > > +			continue;
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +		/* The first available DU instance is the comp=
onent master. */
> > > > > > > > > > > > > +		if (!du->is_master) {
> > > > > > > > > > > > > +			if (np !=3D dev->of_node)
> > > > > > > > > > > > > +				return component_add(dev,
> > > > > > > > > > > > > +&rzg2l_du_instance_ops);
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +			du->is_master =3D true;
> > > > > > > > > > > > > +			continue;
> > > > > > > > > > > > > +		}
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +		drm_of_component_match_add(dev, &match,
> > > > > > > > > > > > > +component_compare_of, np);
> > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > The master=A0is chosen purely by DT order. If the
> > > > > > > > > > > > first available DU never probes, the second never
> > > > > > > > > > > > gets a DRM device. How do you handle this
> > > > > case?
> > > > > > > > > > >
> > > > > > > > > > > All available instances are part of the component
> > > > > > > > > > > match, so the DRM device is only created once all of
> > > > > > > > > > > them have probed, whichever one is the master.
> > > > > > > > > > >
> > > > > > > > > > > This is how the component framework works.
> > > > > > > > > > >
> > > > > > > > > > > To use a single DU, the other one can be disabled in
> > > > > > > > > > > DT, in this case the remaining instance becomes the
> > > > > > > > > > > master and initializes the DRM device on its own.
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Assume both DU's available and run time
> > > > > > > > > >
> > > > > > > > > > second DU is probed first and master never probed at al=
l.
> > > > > > > > > > What is the state of second DU as bind never calls?
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > The second DU probes, registers itself with
> > > > > > > > > component_add() and stays idle, without touching the hard=
ware.
> > > > > > > > >
> > > > > > > > > When the master probes, both instances are bound and the =
DRM device is created.
> > > > > > > > >
> > > > > > > > > If the master never probes, there is no DRM device,
> > > > > > > > > because the bind is only triggered once the
> > > > > > > master
> > > > > > > > > has registered the aggregate device with
> > > > > > > > > component_master_add_with_match()
> > > > > > > >
> > > > > > > > Not sure is it the normal use case? DU0 and DU1 are
> > > > > > > > independent devices
> > > > > > > >
> > > > > > > > 1) DU0 or DU1 should work independently irrespective of the=
 probe failure of
> > > > > > > >    other device
> > > > > > > >
> > > > > > > > 2) When both DU's are probed, then we need to aggregate the=
 device using component
> > > > > > > >    framework so that use case like dynamically switching DS=
I0 to DSI1 can be achieved.
> > > > > > >
> > > > > > > IMHO 1) and 2) can't be achieved together.
> > > > > > >
> > > > > >
> > > > > > I guess we can achieve both use cases, if we define a companion=
 property in the second
> device.
> > > > > > This is a static design choice left to the DT user to choose be=
tween either 1 or 2.
> > > > > >
> > > > > > Krystof/Rob/Conor: Is it ok to add optional companion property
> > > > > > to support both
> > > > > > 1 and 2? Otherwise, we plan to stick with use case 2.
> > > > > >
> > > > > > Use case 1: 1 DRM device per DU
> > > > >
> > > > > Some clarification:
> > > > >
> > > > > For 1)
> > > > >
> > > > > Just FYI, the series already supports this when only one DU is
> > > > > enabled in DT. If only DU0 (or only
> > > > > DU1) is enabled, it creates its own DRM device directly, without
> > > > > the component framework, and we will get 1 DRM device with 1 CRTC=
.
> > > > >
> > > > >
> > > > > # r9a09g047e57-smarc-du0-dsi.dtso
> > > > >
> > > > > &du0 {
> > > > > 	status =3D "okay";
> > > > > };
> > > > >
> > > > > &du1 {
> > > > > 	status =3D "disabled";
> > > > > };
> > > > >
> > > > > > Use case 2: 1 DRM device for 2 DU's
> > > > >
> > > > > For 2)
> > > > >
> > > > > When both DU0 and DU1 are enabled, DU0 registers the aggregate
> > > > > device with
> > > > > component_master_add_with_match() and DU1 registers itself with
> > > > > component_add(). Both are driven by the same DRM device, with 2 C=
RTCs.
> > > > >
> > > > >
> > > > > &du0 {
> > > > > 	status =3D "okay";
> > > > > };
> > > > >
> > > > > &du1 {
> > > > > 	status =3D "okay";
> > > > > };
> > > >
> > > > DU0 and DU1 are independent devices.
> > > > Currently if DU0 fails to probe, DU1 won't work.
> > > > So, there is a limitation in the current design.
> > >
> > > Mmmm, checking better the others vendor drivers I can see the same be=
haviour:
> > > if one member of the aggregate fails to probe, the others won't work =
either.
> > >
> > > mtk_drm_drv.c driver where we have vdosys0 and vdosys1 [1] that are
> > > sharing the same drm device. And also in this case if one fails to pr=
obe there is no drm device.
> > >
> > > Same for rk3399-base.dtsi where we have vopl_out and vopb_out [2]
> > > Same for imx6q.dtsi with ipu1_di0, ipu1_di1, ipu2_di0, ipu2_di1 [3]
> > > Same for sun7i-a20.dtsi where we have fe0, fe1 [4]
> > >
> > > Please correct me if I'm wrong.
> > >
> > > [1]
> > > https://elixir.bootlin.com/linux/v7.4-rc1/source/drivers/gpu/drm/med
> > > iatek/mtk_drm_drv.c#L374 [2]
> > > https://elixir.bootlin.com/linux/v7.4-rc1/source/arch/arm64/boot/dts
> > > /rockchip/rk3399-
> > > base.dtsi#L245
> > > [3]
> > > https://elixir.bootlin.com/linux/v7.4-rc1/source/arch/arm/boot/dts/n
> > > xp/imx/imx6q.dtsi#L304 [4]
> > > https://elixir.bootlin.com/linux/v7.4-rc1/source/arch/arm/boot/dts/a
> > > llwinner/sun7i-a20.dtsi#L254
> > >
> >
> > Thanks for the link. After googling
> >
> > Separate DRM devices (card0 + card1) are only advantageous when
> > physical isolation is mandatory (e.g., safety-critical medical or
> > automotive instrument clusters where a primary gauge cluster cannot
> > share a kernel driver/compositor with an infotainment screen) and no
> > one normally split SoC display engine for such use case. So, I think we=
 can go with single DRM card
> approach and no need to support 2 separate DRM cards.
>=20
> Thanks for sharing.
> So we can stick with the current approach right?

We need to create a separate ticket checking internally for
any customer use case for separate DRM devices?

Mostly it is single DRM device, but better to check.

Cheers,
Biju
