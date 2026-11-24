Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F958606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 16:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=RjOEou3g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EA2510E8B5;
	Tue, 24 Nov 2026 16:05:00 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazon11011006.outbound.protection.outlook.com [52.101.125.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11F8410E8B5
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 16:04:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAT3wHheVUWsGF/KuIfCLc4OaQbyuJI9QdRTYV2xxUriAgh45s9S2jf+rtIRV9ZWuGLda3ZsrjoYS5qhy6ZVNLgDoq29Azc578W6W83vqZnVYt6ixyiWVbHKlLAoyb43HwxNYkQW1B6OTsLaE6SxO0RF/+2qUy0PBl3UTe9Xt4WOpzaiCUV+zxc4r94/VovbHuqSVeRnjjzXq8eJhuDG6orhmbKaEeLIr6IhCQF+aHxku4dd/G3vqyTTjxYhfwT8yaTxHoVrRyqE7UJOZYnx6jYDXGVhViCOEI+ZkmR42T6kVhp6vQW9tZLnRT6Yc6GwCmBYS6nuTQwcJZ8N/ThnlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSierpSF5oZFPg4z+WKsSAWS9oFCkoCEHloBDDn6aJQ=;
 b=h5pS10V8dqKb52Zkwcc27TTlU8x4rpJtj2q5uP8OdBwx1ejldZPK8+0CPO/0CZnRCs5FTf81qXovStogW8zSp6IpZQYqSOMYd9pfbz3ptF9E5+4tFC+mLRNgXask20g+u1+SvMzT9Ec1fDoludhY/Vj8JXlOiL9TDQ8ZnFZfQ5YdZFzx0Q05M5voiBSy/N+QvXulb7BL7X5d8slngFRte51WhkhhkqZOpXlmDU01E0ekMvYw3QbhIzW9zBTL+tFZWoDi8a2xfv+uBe6WNK2RRqM6Od9fQHFCevmNXabr56CtjhzKR9yl6CFz57c/sqaVQjXdQdCJKLmYZ4Ik9rMYXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSierpSF5oZFPg4z+WKsSAWS9oFCkoCEHloBDDn6aJQ=;
 b=RjOEou3g2fA6GjuC+9rdTZhhh3C/1Jg+B0OZzUe/KVtXU4kaw8xCxZnWC3WYv7KL6MfE5bK4AZtRKtkHYIfMYUH5hnGU8w74dpKIB/hvdqvPvcINhv5mKi3NBr5hh4U1BFIfD3Bq64OY1whiFOkSfM5ustixOSzvgm+Jkwiv744=
Received: from OS3PR01MB6596.jpnprd01.prod.outlook.com (2603:1096:604:10a::8)
 by TY4PR01MB15605.jpnprd01.prod.outlook.com (2603:1096:405:28b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.5; Tue, 24 Nov
 2026 16:04:49 +0000
Received: from OS3PR01MB6596.jpnprd01.prod.outlook.com
 ([fe80::58ce:825e:c38b:ec98]) by OS3PR01MB6596.jpnprd01.prod.outlook.com
 ([fe80::58ce:825e:c38b:ec98%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 16:04:48 +0000
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
Thread-Index: AQHdc2mHvfvfxGybKU23d8MzJCmRZbc78H6ggAESzwCAAALngIAAKXaAgAAOCVCAACsuAIAABMHQ
Date: Tue, 24 Nov 2026 16:04:48 +0000
Message-ID: <OS3PR01MB659637409ADFF9CFC2AD395186442@OS3PR01MB6596.jpnprd01.prod.outlook.com>
References: <cover.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <68fcf838eee14c1906f23b2b7c74c560793cd1d4.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <OS3PR01MB65968FEBCB08429F11188CE986452@OS3PR01MB6596.jpnprd01.prod.outlook.com>
 <awVW5B4p06FUfBHw@tom-desktop>
 <TYYPR01MB6603AA1B7A48B7D899604EE586442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awV8G86QIth4GtaA@tom-desktop>
 <TYYPR01MB6603A1FB28A473A400A2C49386442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awWsGjt6cW_CSoMH@tom-desktop>
In-Reply-To: <awWsGjt6cW_CSoMH@tom-desktop>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6596:EE_|TY4PR01MB15605:EE_
x-ms-office365-filtering-correlation-id: 103f0d9d-3a31-4d48-a7a4-08df4a44aa7c
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|23010399003|1800799024|38070700021|10067099003|11063799006|4143699003|56012099006|261022105027099003|261021123027099003|261022075727099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003;
x-microsoft-antispam-message-info: yUalymzOfwOy0wPpcm3uL07CMDcxO1HT3I4k6+oHFSoRcLUPjLXi4nyW1dmTkgHxNu9QpmTlibeLRexU/sWA/sS1SksZZcTqWBeLVCaZ2rBdZ2zLoLDa7W4jLKj0cDlN2e3NYRyeBEU5VNML7N6bODPif5L1DmPxqZRiXWzsIRb1ViAXaiBJN0x9JeTWvuyOrQKg2Wqk78yDFrVaSRFv4eILnhRybrJZk3OCegYkOxjtgvxqLydHFkWzBdnD2V8LcQiDOAZY3aF9SrgcMBepxD5X7WUVOT2b3ihubJKgzmra4v/ayO/zDWQ0zVT6Y++Yq7jMKPvUmFq9v9BloTJrJPvV0YblT36paC8mVPP7BG2ZDaK7DsGAbMxgZncRF4hnyBQvsIlicydwx/ol7YoiFOszu3Ihbsn7M0gcIX0DjpJ4M1/xWrtD3IDijeoCcrNWVAcfd6m6fhuV5jGtm2GJC/EqXJI1CQz5cd7nqS+ixr97jqhdjhVIaa5nhdtucGeSqXZeM0k+xG97cXgztMc1ge2msw2ii9M+zMjXaJYitZF60+Pb7PFW21ZIqlYH3vjz5E/M5/5p12wdLS96UKjYIZ0J8csLnzyqcBBD7A01dVHAwkeJK7dJaANVMVRDEmg/u5jSDvnkXQlHpKKWmtOaX4UYxUoEPh1if5W+quPqckZfE5uvu9DnaJtEF8Bl0Kf8WHUBsKWJnQfc7WrqBQBYtAml9k2RHGgtuk3g06g7GiI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3PR01MB6596.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(38070700021)(10067099003)(11063799006)(4143699003)(56012099006)(261022105027099003)(261021123027099003)(261022075727099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UcmFUSUREBICjxMpbHfXWEX9YoLHQqXamyX7zpXj1P54nGNN70+pFL5ijR78?=
 =?us-ascii?Q?Fv3xnjA07yGEd6ZY2PmVGZRiFjwIUTeTq3kqBE6OD/nZ2sCfwwhZb+6fa8lj?=
 =?us-ascii?Q?Wwoq0C4e/KBizLXeSdy/5IoMG6s/ib3QAdcwdQG8WUKAVThOoDrihKG8Q6ww?=
 =?us-ascii?Q?Dj6LVYJAIHV4WGYK3P5D9Ps22Qy13XIo+tGNC323XDpvYv6FdvTD4v+4EAfP?=
 =?us-ascii?Q?HIjvifpHspZ3+KKh3sI0W313qI5ApZkRmhxAfSk9/s37msgNakwzaTi+LS+a?=
 =?us-ascii?Q?doKhLaPiWZWtiYtBViEIhUay9qPOADjSEkObVa0TFQqgMcmt26bQEgJYmtaT?=
 =?us-ascii?Q?9XMe+svA23LPGA/qfCoZESUEiAR62dODepRXY/KZ51ocNAS6TCE9Fipyh60j?=
 =?us-ascii?Q?KYlu//OEkDP9QxY49gAhyKKtj0gyalCUogxJMxmpp1o5P3qCTSObzlv8dpXG?=
 =?us-ascii?Q?kAzZN+CJ2f6j6DGd8/9Sl+YY9kGhripgEweeIWtql/OhRbrg5vxw6MBf6JWe?=
 =?us-ascii?Q?nlGrSGWv6/pbG9qeB/LNXyYCmdLL1tBgKjlaHnBOPrTyxbOqedj/Tv64/idj?=
 =?us-ascii?Q?lScgI6fG3EmSo5nKc5OrrRzNXFRy+xbZsiCmIy5004xlKKYJRF2Eo/Kywi9W?=
 =?us-ascii?Q?vNui4XyurVryPSNKtHqsZyehC/Y/p7V+WfqayDjABS1lr3fhFieOjqcSu0SL?=
 =?us-ascii?Q?qqW2urDtuPtDtyjYjvJxWNcRjrzjNnqpzwR4BsZtp4VY0Fue2rdgHqZ/pB56?=
 =?us-ascii?Q?jbttn2DbDAO00UXJnM77ByVWrfhwVkxUtI8AV8e6xmTW5aXRj8A+5AkadS4u?=
 =?us-ascii?Q?f1suECJyiDPzl7CcwRQoOnJAZ6lgJGTgHl8O+13mzXcd62lDLn395MqsvONl?=
 =?us-ascii?Q?nl7ECHAVnf21dlq9O7VWmdlIumY1AaeCCCZUiy0y9c+/WoEjBEXu7SKh3Myw?=
 =?us-ascii?Q?qbQ1OaDBpBmNUOSGMnIa9YaaUlrQkiNmbRgHi0nFVJ+vVQIVrOne/u3NjLG6?=
 =?us-ascii?Q?wiWwxLUAKU+0HvLF+fFoQWMWQsoPdmzQcb8lz5o2hkgWRb0tCRVF0ZR/o4t5?=
 =?us-ascii?Q?pecgACs107lRJn9fBCZfDVTNML+hWqZXcuyWLSyiRZsE6Etbq1k4+z2FeX9C?=
 =?us-ascii?Q?7nAZ08VfAPRD2oA6ud+O6dxnbIkdVszJSXCB6ZPpUIxtomRQ9LvIC9NBLcgd?=
 =?us-ascii?Q?LLF3ei8JcOFMg9QE118hRzYGMAuOQAFgs0jaopL8V8T4uhskpmiBNAtPCvll?=
 =?us-ascii?Q?ZvKeTGgUTpiIPlJ1CE6S0qZ9N1a6FnIvbHwShUzyePmgT4uaYFqJYhcA7Oag?=
 =?us-ascii?Q?V7fJogVmEEezzOdSPUz+eiptTrCUOCOG7LkhKqh4OqaDHonycMQ+l9et8ns3?=
 =?us-ascii?Q?Leup05s4+sqhg4714j66YZXfDhPjDHDsFGh8TIaryqvbUURGtVy4G4GYrelt?=
 =?us-ascii?Q?9hR5FKrEogFUatV75UmhHWo8eh1dNfsYhALOLPjj1sDy9+vEkxxGSDEKa4rJ?=
 =?us-ascii?Q?BXsaqpLE891Uc9IXebA27ystZtqHsbBh0bCFKb/BnYiYvCpQp5+s8tls2nhM?=
 =?us-ascii?Q?smfv7ngR6jUzL8+vLdSBgT/v8JTcpQCmm4NUZf9adAhv/j7bA1zRcwABmG0P?=
 =?us-ascii?Q?is5feVJ4dxd/0ErYtlqzfeJ0dqnJCwgyZC1WvNZHExYB9bxUVq1fSB+RsBHT?=
 =?us-ascii?Q?83vPf4QuTufwPG8cGhkwlXH3cS6F4SBueb15GbWGPlLXAHw3w87VJBDIS2G9?=
 =?us-ascii?Q?Is72YmivYw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6596.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 103f0d9d-3a31-4d48-a7a4-08df4a44aa7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 16:04:48.8273 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1bicT17DUG5PUe2/ra/jZN8CuuRG/Mc3zyYr+qGdUGpgbVmCdVPI9ue9VgLPFIwcwnO34AyoIXsw6+pGkp7APHaLNI8+qw5Vt4Bp3bYmRWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15605
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
> Sent: 24 November 2026 15:24
> Subject: Re: [PATCH v10 08/12] drm: renesas: rz-du: Separate the DU insta=
nce from the DRM device
>=20
> Hi Biju,
>=20
> On Tue, Nov 24, 2026 at 12:51:18PM +0000, Biju Das wrote:
> >
> > Hi Tommaso,
> >
> > > -----Original Message-----
> > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > Sent: 24 November 2026 11:59
> > > Subject: Re: [PATCH v10 08/12] drm: renesas: rz-du: Separate the DU
> > > instance from the DRM device
> > >
> > > Hi Biju,
> > >
> > > On Tue, Nov 24, 2026 at 09:33:13AM +0000, Biju Das wrote:
> > > > Hi Tommaso,
> > > >
> > > > > -----Original Message-----
> > > > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > > > Sent: 24 November 2026 09:21
> > > > > Subject: Re: [PATCH v10 08/12] drm: renesas: rz-du: Separate the
> > > > > DU instance from the DRM device
> > > > >
> > > > > Hi Biju,
> > > > > Thanks for your review.
> > > > >
> > > > > On Mon, Nov 23, 2026 at 04:59:32PM +0000, Biju Das wrote:
> > > > > > Hi Tommaso,
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > > > > > Sent: 13 November 2026 12:20
> > > > > > > Subject: [PATCH v10 08/12] drm: renesas: rz-du: Separate the
> > > > > > > DU instance from the DRM device
> > > > > > >
> > > > > > > On RZ/G3E two DU instances share a DRM device, which can
> > > > > > > only be created once both instances have been probed.
> > > > > > >
> > > > > > > Split the DU device structure: keep the match data and the
> > > > > > > registers in a structure allocated with the platform device,
> > > > > > > and allocate the KMS objects with the DRM device in a new
> > > > > > > rzg2l_du_instance_init() helper, as they are released
> > > > > with it.
> > > > > > >
> > > > > > > No functional change intended.
> > > > > > >
> > > > > > > Signed-off-by: Tommaso Merciai
> > > > > > > <tommaso.merciai.xr@bp.renesas.com>
> > > > > > > ---
> > > > > > > v9->v10:
> > > > > > >  - New patch.
> > > > > > >
> > > > > > >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c | 61
> > > > > > > ++++++++++++++------
> > > > > > >  1 file changed, 44 insertions(+), 17 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > > b/drivers/gpu/drm/renesas/rz- du/rzg2l_du_drv.c index
> > > > > > > d3cccbdf9012..d102876c07e1 100644
> > > > > > > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > > @@ -162,6 +162,27 @@ static int rzg2l_du_pm_resume(struct
> > > > > > > device
> > > > > > > *dev)  static DEFINE_SIMPLE_DEV_PM_OPS(rzg2l_du_pm_ops,
> > > > > > >  				rzg2l_du_pm_suspend, rzg2l_du_pm_resume);
> > > > > > >
> > > > > > > +/*
> > > > > > > +-----------------------------------------------------------
> > > > > > > +----
> > > > > > > +----
> > > > > > > +----
> > > > > > > +------
> > > > > > > + * DU instance
> > > > > > > + */
> > > > > > > +
> > > > > > > +static int rzg2l_du_instance_init(struct rzg2l_du_device *du=
,
> > > > > > > +				  struct drm_device *ddev) {
> > > > > > > +	struct rzg2l_du_device *rcdu;
> > > > > > > +
> > > > > > > +	rcdu =3D drmm_kzalloc(ddev, sizeof(*rcdu), GFP_KERNEL);
> > > > > > > +	if (!rcdu)
> > > > > > > +		return -ENOMEM;
> > > > > >
> > > > > > Why there is duplicate allocation of rcdu? One in probe() and
> > > > > > here
> > > > >
> > > > > The two allocations have different lifetimes.
> > > > >
> > > > > The one in rzg2l_du_probe() is tied to the platform device. It
> > > > > holds what is needed before the DRM device exists and outside of
> > > > > the component bind (dev, info, mmio, and ddev/is_master for the
> > > > > master, PM and remove), as on RZ/G3E
> > > the DRM device is only created once both instances have been probed.
> > > > >
> > > > > The one in rzg2l_du_instance_init() holds the KMS objects
> > > > > (crtcs, vsps, lvds, index). Their drmm cleanup handlers point
> > > > > into it and run when the DRM device is released, which can
> > > > > happen after the platform device has been unbound,
> > > so it has to be allocated with the DRM device.
> > > >
> > > > Then there is an issue right, platform unbound will unmap mmio and
> > > > other data structures it allocated in rzg2l_du_probe()and drm
> > > > driver is using after that( Use after free Bug)
> > >
> > > Mmmm In theory no.
> > >
> > > The KMS part keeps its own copy of dev, info and mmio, and its drmm
> > > cleanup handlers only drop references, they don't access the hardware=
.
> >
> > Can you please make sure these variables set to NULL, after Platform
> > unbound?
>=20
> Please correct me if I'm wrong but IMHO this patch keeps the same behavio=
ur as the driver before this
> series.
>=20
> Where rcdu is embedded in the DRM device (devm_drm_dev_alloc()) and mmio =
is devm managed. Setting the
> pointers to NULL would only turn an invalid access into a NULL dereferenc=
e no?

Ack.

But why you need copy? What preventing to use original allocated rcdu
in rzg2l_du_modeset_init_du()?

Cheers,
Biju

