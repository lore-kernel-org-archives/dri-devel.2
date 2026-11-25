Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD08B606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 13:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=TeKLHezZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1700D10FC3B;
	Wed, 25 Nov 2026 13:45:58 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazon11011031.outbound.protection.outlook.com [52.101.125.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACCD710FC3B
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 13:45:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/E2XxfncOv2hlRfHMLVJ4incynDX6diDVAuP+hV5ieu0NaVE+OVP4kY2y0TvCravGy6zmrN/ijlUdOUYmQ8hDtW1jqrI0E3LfUNaXxrYmkkCrpEdSkHybG4R0o4l1KHXwv7LVmr0hswHz0q+ZzmFN7+VQazpupWT4O1HwT2pw2f94FJ5+leeRnPZl8H2mNtiyg3BFodbcmtYhqEh4jSMcUKA4+UVvIjzYc/hE0OtBKuNO6h9kmcdoVWOjVXpGD3WOVmOBAYpTSxFpmdNTDlVmJaDifuZ/G0fgT3CIrqtMg3cs1zcKZlVLMcpUGjOgNFphVvWXOTTcFgFGrcyLJsoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBPOFbSyNU48GPiVt2Hoh/JBCLcs5HuCY9iDYitN2ws=;
 b=KZwncSIAC8Pc5YE2sUexw4c2rw10SVYlwY46Y51Vyry/NQZVJN+kbMMWeFYXwwHalqsOwc0mKT23aV2O/dUIH+QC5eSCKN3f40AlSSTktPDaS4tp1z4NX+05Q8LKVV6FaNaA7UDk6aGOq2B4AaxTvIGQxnooqzUCjZUS4KA4IrqhQK+I1sFUbnqa/w4fxPOA413KywYV+8hGjAC1BJieBofm7dGHpI2xOn+73c8g+w8VUmzmTFJrcvaJpTg8xKjncL6ugCxUJ1ZHGOkblLwIAPCE0k5yfOLBEpVTCtp5vvCESKJSFG5NYidJf4uNbDWWqynp1Zqzu3qMldJkRys+YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBPOFbSyNU48GPiVt2Hoh/JBCLcs5HuCY9iDYitN2ws=;
 b=TeKLHezZjCFourMPHwJVqK1pzUqzPhWDynVYPY8SsWQHmHhc/dwlNK6K7RPFV8OWLRAu1JNXa5Mq4eiNLqK8BhzhEKrgizol9RlBJdA5Q1j4IZjKe2LfBZZJZY2dESkC5REEJWYRN5c89U8m889vyDTGuxzYMPTOBHSY3t1eqEY=
Received: from OS3PR01MB6596.jpnprd01.prod.outlook.com (2603:1096:604:10a::8)
 by TYRPR01MB15470.jpnprd01.prod.outlook.com (2603:1096:405:287::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Wed, 25 Nov
 2026 13:45:46 +0000
Received: from OS3PR01MB6596.jpnprd01.prod.outlook.com
 ([fe80::58ce:825e:c38b:ec98]) by OS3PR01MB6596.jpnprd01.prod.outlook.com
 ([fe80::58ce:825e:c38b:ec98%4]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 13:45:46 +0000
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
Thread-Index: AQHdc2mQXc9YOQBvg02jmZuHcmeGVrc781HAgAE6mgCAABQz0IAADw6AgAABgjCAAA1wAIABElhggABqnQCAAACi8A==
Date: Wed, 25 Nov 2026 13:45:46 +0000
Message-ID: <OS3PR01MB65961475F4B3C1D5D781E7C486432@OS3PR01MB6596.jpnprd01.prod.outlook.com>
References: <cover.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <e22a176720a38df652c7f7eabe27219da50f217d.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <TYYPR01MB660397C3B66F6EED53656B2086442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awV6pAtcSz8e9Q74@tom-desktop>
 <TYYPR01MB660334463EC01FCF06F7A9E586442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awWXLFAbDd_35Q-l@tom-desktop>
 <TYYPR01MB6603D650B839F808ACBA811F86442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awWkwJTxdJV1owf-@tom-desktop>
 <TYYPR01MB66037146324486059A62A60486432@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awbkUiagA_n9z521@tom-desktop>
In-Reply-To: <awbkUiagA_n9z521@tom-desktop>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6596:EE_|TYRPR01MB15470:EE_
x-ms-office365-filtering-correlation-id: 63fc6c7d-a1b7-4a61-d012-08df4afa686d
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|7416014|366016|376014|1800799024|38070700021|10067099003|11063799006|56012099006|4143699003|261021121427099003|261022075727099003|261021123027099003|261026121527099003|261022105027099003|261026140227099003|261102123227099003|261028144727099003|261009223027099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: 4TYxbXDglzLz8jKsL2Our074Nf9GyFHJvuiz2LYYSo4+HJ7PX0EXXdbGWwkgNHNnQM6TSkJJHddp3qShTikjaVF5o7kXxkbcR3x0vcitHhLWrdN2PromsMGHQfv0cBkm2mcrqkuup4if8GTRTpC0vkQ/qlVDiRaBAnsUE1TrajwJ+69pT6PIiAx1BI9xZJZtnIkhX3BKwyy/RRurPgDI2jysqE/xX8tSPVSzGE/GYNGEsfyZxGjFg6xk0i/C34CALVcfEDHo+Nh9u5ZiRhuTwRFJcLcCKct5oS8Vz13xDEJN4cFOMlIIGIcGkmU9RKI/t3KkSngxaUFX4Owxbpr8wb8zibscws3GPuG+RaU4KpmUev+a06iAdCdKj3JbCb17N1MnB4GgTDxTeBBUPjxI621Lgu5+1yZHDlAEWaVBYxMOkUlSN0d5rFaeIb1/jxpdn+ll42sLn9RkP2nHnq64wAoWdO7vQ/NPHGUc/N6uXbG9Yb9HBNTBhKlTDnZEANIfVeHOOXjZst+oPipX7VmZnn1DUkSEJWo1jyIXmWaJF9Ubd0ww4Lacy/Mq+xayq3Axe5901TjsQ3TPjghEJwlGhAoDxmofPndU92OIyC+YBFPNUvxeFc510Vgg4iDFlyg/iz0AV8lylGshab2ICx1Tl749s7jei1h4bZ0fB2TTajGI5L2lSioEDd5q096UF652GbKvEarfMHsyiZmbVaig8YfqZdle+3AxYXY7aJ05ThU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3PR01MB6596.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(38070700021)(10067099003)(11063799006)(56012099006)(4143699003)(261021121427099003)(261022075727099003)(261021123027099003)(261026121527099003)(261022105027099003)(261026140227099003)(261102123227099003)(261028144727099003)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xHoL0JCPWehtXD5tDHHgjb3bLJ+hfinj/QmWwEQAKQ6tKnkj8ueqxgdPb2?=
 =?iso-8859-1?Q?6Mr/seTa0G2dxmj41hl7XrRiAhsj9rWbfpduHNBcIxm1YTcD2keDQLhEtJ?=
 =?iso-8859-1?Q?wDsPnt8t9Py7yLzwnUZio+zJWus/gX8oXBeyjsIsTKFiYC2cJKgse6Rbt+?=
 =?iso-8859-1?Q?Vfl80ErgU83gVABXv8Nn21qTkygD1AfCiyUdupmcuTRsC3raOEKQsz0QnR?=
 =?iso-8859-1?Q?wSiQonbnTNhQn0Q5ef3C+EygOwp0vOpMch8qjZLIWqjxIKQGWXIgOpcDf7?=
 =?iso-8859-1?Q?5QxvZkPTX8fSgyjN+EQlRki06uOn0R1OS2OmXFCcKH0O6lPSGMOMZP8O7x?=
 =?iso-8859-1?Q?X3uLO+whQOVE6buvizmGQK3Idg+SQfJ4CDXAP5AmxLkdZj8Z5QxgRMYIdS?=
 =?iso-8859-1?Q?VYd+Wcd2bVz8XoZK1cAB0gkjGKe2pDS+rAjGsL2Tiskg5qw+RJxS5p7tBN?=
 =?iso-8859-1?Q?A8C6BoyF5Xmr5Zu7rMDP/EY7oSdfpJsAc8X3p5vtMjxNYHqLwMeK21YnET?=
 =?iso-8859-1?Q?q/juIOw4DIRsUaBWeRSdtwRW1NB+XwNLNa/p+7LxWFTt7ot/fJqPfrlVC8?=
 =?iso-8859-1?Q?mzuCdQN1O30D78mWQQ6mToa6oMPRftlkeUDm1MkQp9ElXYmS2t1bgUOK+n?=
 =?iso-8859-1?Q?D2Ox/X8q1DnZmhXSt3wXX8y6OU+waQFGOU1R9k7gapXQC4q0P9MVqWiLp7?=
 =?iso-8859-1?Q?/CglMmvVioIKFy6nb6UFDEHxYRfJL3t3Ox8ODVndoZ8TExfr+9sksIEgb5?=
 =?iso-8859-1?Q?4zoTA92ikhTykwfDYTDMdsa27g8I/MTzK1GNCS8CTcbHZIon6JidUtVlV8?=
 =?iso-8859-1?Q?5QTZKxFjy0axmEXM+3au9Uhh8in32oskszmT7k1arq+HqQHrg2qQOlWqrw?=
 =?iso-8859-1?Q?zfeg3s88qNO0jvzXBh9219Xh3RW6ykDnF/EvxFbRZZQi/3ccI1yR+AGufJ?=
 =?iso-8859-1?Q?znlfiDqLdrqtR5HxbP6kxx/4+FJeIf56wecBH6JyhQTbekICip0vI9VO2N?=
 =?iso-8859-1?Q?PLlCnBtYvq1Idu8I5R2pYisjmFTiMPRKSUCxP3zAqJva1DX9oIsAJLUSEV?=
 =?iso-8859-1?Q?94AiWFYNK3eaINa56HiLL8QVkBty/PyPkNXBsfQj0HwWNr6gWNA6JeIRSO?=
 =?iso-8859-1?Q?k+aR20FFPo6TM82JMXcYPnCbEj+JJN4oydj9N+WEsTU6eChKAb+icmuI9l?=
 =?iso-8859-1?Q?/LhM9Rlr4Vbh2palSG4TkPPJrSUneOTzai1/czx/WuOrQ5GA1/lQT+bW5h?=
 =?iso-8859-1?Q?b7d59Ac4wONvxC/EQpUaoEdPjp43X7IVqs6UkvTTRmGQ32NA0kJosUkJIu?=
 =?iso-8859-1?Q?TvXWwAUuXtAABkrsMB+7icx3g08pMKdQY68lHoB8N1toJk4th9jLsSxROt?=
 =?iso-8859-1?Q?6HeJgKQNZEwgsDaJVRDoY887+DFPNKmilKsBnkptZRjPpRoGEckvHT4bUL?=
 =?iso-8859-1?Q?CV3PLyzx0WAnIu8d+pgPURT5r2WcaqvM1QbQN8MdrbExOH4QAm1XiotBd4?=
 =?iso-8859-1?Q?ZI1UQboaFLRQB1D3I/8oby8ydJCbrvInN+C10KU37b436SWLyhWm9bisGa?=
 =?iso-8859-1?Q?iiRj9CivYSiC/nGEvfaCekAfc1fAvwECTrbjAGxeP6XYiTeqAALHqCIysm?=
 =?iso-8859-1?Q?4k0mKFj8iuKnc+Ds9FLG+4dWNOtNSk8zMDde5FmDsmTHmkL7oizbRcaio8?=
 =?iso-8859-1?Q?i2P6x+Qqoc+JjXdOGzr3p6VEGGKqz0YmU0iXRqbNoHatdMWdpnJLSNO9Dm?=
 =?iso-8859-1?Q?SDLW+9tuq3oFeYellG7q2BU5z50glkVJiZXPnZ90R/WSl51Nw95uIxPxlJ?=
 =?iso-8859-1?Q?aZVoEvxYgQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6596.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63fc6c7d-a1b7-4a61-d012-08df4afa686d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 13:45:46.4082 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WS7bHjKlYTX5TfoH7D0xl6xIjt8Z89phIeHFqqslFRmFySJCeiSoIVhQCgU1xS81KEQ5rgHXdRQodyOBnpAFbJUtKCXhnaBdcgIJ6/2RV70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB15470
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
> Sent: 25 November 2026 13:36
> Subject: Re: [PATCH v10 10/12] drm: renesas: rz-du: Support several DU in=
stances in one DRM device
>=20
> Hi Biju,
>=20
> On Wed, Nov 25, 2026 at 07:28:17AM +0000, Biju Das wrote:
> > Hi Tommaso,
> >
> > > -----Original Message-----
> > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > Sent: 24 November 2026 14:53
> > > Subject: Re: [PATCH v10 10/12] drm: renesas: rz-du: Support several
> > > DU instances in one DRM device
> > >
> > > Hi Biju,
> > >
> > > On Tue, Nov 24, 2026 at 02:11:16PM +0000, Biju Das wrote:
> > > > Hi Tommaso,
> > > >
> > > > > -----Original Message-----
> > > > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > > > Sent: 24 November 2026 13:59
> > > > > Subject: Re: [PATCH v10 10/12] drm: renesas: rz-du: Support
> > > > > several DU instances in one DRM device
> > > > >
> > > > > Hi Biju,
> > > > >
> > > > > On Tue, Nov 24, 2026 at 01:18:43PM +0000, Biju Das wrote:
> > > > > > Hi Tommaso,
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > > > > > Sent: 24 November 2026 11:53
> > > > > > > Subject: Re: [PATCH v10 10/12] drm: renesas: rz-du: Support
> > > > > > > several DU instances in one DRM device
> > > > > > >
> > > > > > > Hi Biju,
> > > > > > > Thanks for your review.
> > > > > > >
> > > > > > > On Tue, Nov 24, 2026 at 07:47:04AM +0000, Biju Das wrote:
> > > > > > > > Hi Tommaso,
> > > > > > > >
> > > > > > > > > -----Original Message-----
> > > > > > > > > From: Tommaso Merciai
> > > > > > > > > <tommaso.merciai.xr@bp.renesas.com>
> > > > > > > > > Sent: 13 November 2026 12:20
> > > > > > > > > Subject: [PATCH v10 10/12] drm: renesas: rz-du: Support
> > > > > > > > > several DU instances in one DRM device
> > > > > > > > >
> > > > > > > > > RZ/G3E has two DU instances that share a single DRM devic=
e.
> > > > > > > > >
> > > > > > > > > Add an RZG2L_DU_FEATURE_COMPONENT flag and use the
> > > > > > > > > component framework for it. The first available
> > > > > > > DU
> > > > > > > > > instance is the master and creates the DRM device, the
> > > > > > > > > other one binds to it as a
> > > component.
> > > > > > > > >
> > > > > > > > > If only one DU instance is available, it creates the DRM
> > > > > > > > > device directly at probe time, as on SoCs without the fla=
g.
> > > > > > > > >
> > > > > > > > > Set the index of each instance to the number of CRTCs alr=
eady created.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Tommaso Merciai
> > > > > > > > > <tommaso.merciai.xr@bp.renesas.com>
> > > > > > > > > ---
> > > > > > > > > v9->v10:
> > > > > > > > >  - New patch.
> > > > > > > > >
> > > > > > > > >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c | 118 +++++=
+++++++++++++-
> > > > > > > > >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h |   2 +
> > > > > > > > >  2 files changed, 115 insertions(+), 5 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git
> > > > > > > > > a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > > > > b/drivers/gpu/drm/renesas/rz- du/rzg2l_du_drv.c index
> > > > > > > > > 93d59e2cf8a4..873586f2ef28 100644
> > > > > > > > > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > > > > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > > > > @@ -7,6 +7,7 @@
> > > > > > > > >   * Based on rcar_du_drv.c
> > > > > > > > >   */
> > > > > > > > >
> > > > > > > > > +#include <linux/component.h>
> > > > > > > > >  #include <linux/dma-mapping.h>  #include
> > > > > > > > > <linux/module.h> #include <linux/of.h> @@ -14,10 +15,12
> > > > > > > > > @@
> > > > > > > > >
> > > > > > > > >  #include <drm/clients/drm_client_setup.h>  #include
> > > > > > > > > <drm/drm_atomic_helper.h>
> > > > > > > > > +#include <drm/drm_crtc.h>
> > > > > > > > >  #include <drm/drm_drv.h>  #include
> > > > > > > > > <drm/drm_fbdev_dma.h>  #include
> > > > > > > > > <drm/drm_gem_dma_helper.h>  #include <drm/drm_managed.h>
> > > > > > > > > +#include <drm/drm_of.h>
> > > > > > > > >  #include <drm/drm_print.h>  #include
> > > > > > > > > <drm/drm_probe_helper.h>
> > > > > > > > >
> > > > > > > > > @@ -170,6 +173,7 @@ static int rzg2l_du_instance_init(str=
uct rzg2l_du_device *du,
> > > > > > > > >  				  struct drm_device *ddev)  {
> > > > > > > > >  	struct rzg2l_du_device *rcdu;
> > > > > > > > > +	int ret;
> > > > > > > > >
> > > > > > > > >  	rcdu =3D drmm_kzalloc(ddev, sizeof(*rcdu), GFP_KERNEL);
> > > > > > > > >  	if (!rcdu)
> > > > > > > > > @@ -180,9 +184,28 @@ static int rzg2l_du_instance_init(st=
ruct rzg2l_du_device *du,
> > > > > > > > >  	rcdu->mmio =3D du->mmio;
> > > > > > > > >  	rcdu->ddev =3D ddev;
> > > > > > > > >
> > > > > > > > > -	return rzg2l_du_modeset_init_du(rcdu);
> > > > > > > > > +	rcdu->index =3D ddev->mode_config.num_crtc;
> > > > > > > > > +
> > > > > > > > > +	ret =3D rzg2l_du_modeset_init_du(rcdu);
> > > > > > > > > +	if (ret < 0)
> > > > > > > > > +		return ret;
> > > > > > > > > +
> > > > > > > > > +	if (WARN_ON(drm_crtc_index(&rcdu->crtcs[0].crtc) !=3D r=
cdu->index))
> > > > > > > > > +		return -EINVAL;
> > > > > > > > > +
> > > > > > > > > +	return 0;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > +static int rzg2l_du_instance_bind(struct device *dev, st=
ruct device *master,
> > > > > > > > > +				  void *data)
> > > > > > > > > +{
> > > > > > > > > +	return rzg2l_du_instance_init(dev_get_drvdata(dev),
> > > > > > > > > +data); }
> > > > > > > > > +
> > > > > > > > > +static const struct component_ops rzg2l_du_instance_ops =
=3D {
> > > > > > > > > +	.bind =3D rzg2l_du_instance_bind, };
> > > > > > > > > +
> > > > > > > > >  /* -----------------------------------------------------=
------------------------
> > > > > > > > >   * DRM device
> > > > > > > > >   */
> > > > > > > > > @@ -191,7 +214,7 @@ struct rzg2l_du_drm {
> > > > > > > > >  	struct drm_device ddev;  };
> > > > > > > > >
> > > > > > > > > -static int rzg2l_du_drm_init(struct device *dev)
> > > > > > > > > +static int rzg2l_du_drm_init(struct device *dev, bool
> > > > > > > > > +has_components)
> > > > > > > > >  {
> > > > > > > > >  	struct rzg2l_du_device *du =3D dev_get_drvdata(dev);
> > > > > > > > >  	struct rzg2l_du_drm *rzgdrm; @@ -213,6 +236,12 @@
> > > > > > > > > static int rzg2l_du_drm_init(struct device *dev)
> > > > > > > > >  	if (ret < 0)
> > > > > > > > >  		goto error;
> > > > > > > > >
> > > > > > > > > +	if (has_components) {
> > > > > > > > > +		ret =3D component_bind_all(dev, ddev);
> > > > > > > > > +		if (ret < 0)
> > > > > > > > > +			goto error;
> > > > > > > > > +	}
> > > > > > > > > +
> > > > > > > > >  	ret =3D rzg2l_du_modeset_init_finish(ddev);
> > > > > > > > >  	if (ret < 0)
> > > > > > > > >  		goto error_fini;
> > > > > > > > > @@ -235,6 +264,8 @@ static int rzg2l_du_drm_init(struct
> > > > > > > > > device
> > > > > > > > > *dev)
> > > > > > > > >
> > > > > > > > >  error_fini:
> > > > > > > > >  	drm_kms_helper_poll_fini(ddev);
> > > > > > > > > +	if (has_components)
> > > > > > > > > +		component_unbind_all(dev, ddev);
> > > > > > > > >  error:
> > > > > > > > >  	/*
> > > > > > > > >  	 * Don't use dev_err_probe(), as it would overwrite
> > > > > > > > > the probe deferral @@ -246,7 +277,7 @@ static int rzg2l_d=
u_drm_init(struct device
> *dev)
> > > > > > > > >  	return ret;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > -static void rzg2l_du_drm_fini(struct device *dev)
> > > > > > > > > +static void rzg2l_du_drm_fini(struct device *dev, bool
> > > > > > > > > +has_components)
> > > > > > > > >  {
> > > > > > > > >  	struct rzg2l_du_device *du =3D dev_get_drvdata(dev);
> > > > > > > > >  	struct drm_device *ddev =3D du->ddev; @@ -254,6 +285,83
> > > > > > > > > @@ static void rzg2l_du_drm_fini(struct device *dev)
> > > > > > > > >  	drm_dev_unregister(ddev);
> > > > > > > > >  	drm_atomic_helper_shutdown(ddev);
> > > > > > > > >  	drm_kms_helper_poll_fini(ddev);
> > > > > > > > > +
> > > > > > > > > +	if (has_components)
> > > > > > > > > +		component_unbind_all(dev, ddev);
> > > > > > > > > +
> > > > > > > > > +	du->ddev =3D NULL;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +/*
> > > > > > > > > +-------------------------------------------------------
> > > > > > > > > +--------
> > > > > > > > > +--------
> > > > > > > > > +------
> > > > > > > > > + * Component master
> > > > > > > > > + */
> > > > > > > > > +
> > > > > > > > > +static int rzg2l_du_master_bind(struct device *dev) {
> > > > > > > > > +	return rzg2l_du_drm_init(dev, true); }
> > > > > > > > > +
> > > > > > > > > +static void rzg2l_du_master_unbind(struct device *dev) {
> > > > > > > > > +	rzg2l_du_drm_fini(dev, true); }
> > > > > > > > > +
> > > > > > > > > +static const struct component_master_ops rzg2l_du_master=
_ops =3D {
> > > > > > > > > +	.bind =3D rzg2l_du_master_bind,
> > > > > > > > > +	.unbind =3D rzg2l_du_master_unbind, };
> > > > > > > > > +
> > > > > > > > > +static int rzg2l_du_instance_probe(struct rzg2l_du_devic=
e *du) {
> > > > > > > > > +	struct component_match *match =3D NULL;
> > > > > > > > > +	const struct of_device_id *of_id;
> > > > > > > > > +	struct device *dev =3D du->dev;
> > > > > > > > > +
> > > > > > > > > +	if (!rzg2l_du_has(du, RZG2L_DU_FEATURE_COMPONENT))
> > > > > > > > > +		return rzg2l_du_drm_init(dev, false);
> > > > > > > > > +
> > > > > > > > > +	for_each_available_child_of_node_scoped(dev->of_node->p=
arent, np) {
> > > > > > > > > +		of_id =3D of_match_node(dev->driver->of_match_table, n=
p);
> > > > > > > > > +		if (!of_id || of_id->data !=3D du->info)
> > > > > > > > > +			continue;
> > > > > > > > > +
> > > > > > > > > +		/* The first available DU instance is the component ma=
ster. */
> > > > > > > > > +		if (!du->is_master) {
> > > > > > > > > +			if (np !=3D dev->of_node)
> > > > > > > > > +				return component_add(dev, &rzg2l_du_instance_ops);
> > > > > > > > > +
> > > > > > > > > +			du->is_master =3D true;
> > > > > > > > > +			continue;
> > > > > > > > > +		}
> > > > > > > > > +
> > > > > > > > > +		drm_of_component_match_add(dev, &match,
> > > > > > > > > +component_compare_of, np);
> > > > > > > >
> > > > > > > >
> > > > > > > > The master=A0is chosen purely by DT order. If the first
> > > > > > > > available DU never probes, the second never gets a DRM devi=
ce. How do you handle this
> case?
> > > > > > >
> > > > > > > All available instances are part of the component match, so
> > > > > > > the DRM device is only created once all of them have probed,
> > > > > > > whichever one is the master.
> > > > > > >
> > > > > > > This is how the component framework works.
> > > > > > >
> > > > > > > To use a single DU, the other one can be disabled in DT, in
> > > > > > > this case the remaining instance becomes the master and
> > > > > > > initializes the DRM device on its own.
> > > > > >
> > > > > >
> > > > > > Assume both DU's available and run time
> > > > > >
> > > > > > second DU is probed first and master never probed at all.
> > > > > > What is the state of second DU as bind never calls?
> > > > >
> > > > >
> > > > > The second DU probes, registers itself with component_add() and
> > > > > stays idle, without touching the hardware.
> > > > >
> > > > > When the master probes, both instances are bound and the DRM devi=
ce is created.
> > > > >
> > > > > If the master never probes, there is no DRM device, because the
> > > > > bind is only triggered once the
> > > master
> > > > > has registered the aggregate device with
> > > > > component_master_add_with_match()
> > > >
> > > > Not sure is it the normal use case? DU0 and DU1 are independent
> > > > devices
> > > >
> > > > 1) DU0 or DU1 should work independently irrespective of the probe f=
ailure of
> > > >    other device
> > > >
> > > > 2) When both DU's are probed, then we need to aggregate the device =
using component
> > > >    framework so that use case like dynamically switching DSI0 to DS=
I1 can be achieved.
> > >
> > > IMHO 1) and 2) can't be achieved together.
> > >
> >
> > I guess we can achieve both use cases, if we define a companion propert=
y in the second device.
> > This is a static design choice left to the DT user to choose between ei=
ther 1 or 2.
> >
> > Krystof/Rob/Conor: Is it ok to add optional companion property to
> > support both
> > 1 and 2? Otherwise, we plan to stick with use case 2.
> >
> > Use case 1: 1 DRM device per DU
>=20
> Some clarification:
>=20
> For 1)
>=20
> Just FYI, the series already supports this when only one DU is enabled in=
 DT. If only DU0 (or only
> DU1) is enabled, it creates its own DRM device directly, without the comp=
onent framework, and we will
> get 1 DRM device with 1 CRTC.
>=20
>=20
> # r9a09g047e57-smarc-du0-dsi.dtso
>=20
> &du0 {
> 	status =3D "okay";
> };
>=20
> &du1 {
> 	status =3D "disabled";
> };
>=20
> > Use case 2: 1 DRM device for 2 DU's
>=20
> For 2)
>=20
> When both DU0 and DU1 are enabled, DU0 registers the aggregate device wit=
h
> component_master_add_with_match() and DU1 registers itself with component=
_add(). Both are driven by
> the same DRM device, with 2 CRTCs.
>=20
>=20
> &du0 {
> 	status =3D "okay";
> };
>=20
> &du1 {
> 	status =3D "okay";
> };

DU0 and DU1 are independent devices.
Currently if DU0 fails to probe, DU1 won't work.
So, there is a limitation in the current design.

The proposal is

Usecase 1)

&du0 {
	status =3D "okay";
};

&du1 {
	status =3D "okay";
};

Usecase 2)
&du0 {
	status =3D "okay";
      companion =3D <&du1>
};

&du1 {
	status =3D "okay";
};

In this design,

Based on DT design,=20

User can have 1 DRM device per DU

Or

1 DRM device for 2DU's

Cheers,
Biju
