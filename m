Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61719C44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 05:55:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B00CC10E2B2;
	Tue, 21 Jul 2026 05:55:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="oTIlfCOF";
	dkim-atps=neutral
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazon11022133.outbound.protection.outlook.com [52.101.126.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C142110E1F7
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 05:55:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HcTvqO/ty/0yr+axGcTJi4wSnWjInT4MDKgU2bZCqyKNtcLzA6r/QvyC3qY+rYcmTZoVkaxFrV7oCd8T3tHMSl0xpbsIoMOz/PLKRWMkcecwNeRswXtkaHQoRkHty7BVOv0oBTrWJ7v9a3m9kKqxTMAVN2sow2PdQMuFFPpJatisBOciBn9OM37w4N47rx0w5drog4SVVV+knHOfT8edn/Eu9zqEelxM+p5R10ZXccmt7g1AiQngUuPQkqlj5OdFqRiyfc0e7KxlqUvO86VlkMkwoIs4O6L3OFcx5uAICfeWqlVHgAO+RKKEMox8sW5p5XyiFJ34PiTBdHr1TWhs2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7R5yJ73QMuMJa/pOFz5nyJoXoV8X1KVlX2KPA5brcGk=;
 b=XvLnaS/L2OLmuHieJWsC7W2crkWw2MuiJq+BUX4582PMnut4A1yqOLG82P3I6HHpKwhJpCL3WQKJbaStJ4LgGp1WU/53s3aac36Sk93GtIpbPKuIf3bYcQGP2HHqfnC4wA+gF/F/glLJDAtI8/hIg5WBIAOpyYvbQ0KnW0iw4lY+DwEuAE29QfkXfT187ATpW00Oi6hO0dLZCFGcweQqza3peye5ShvlBu+A+SrVh+naJr9HW4o4l//3N94HMssY3xVlGSUSUTJBk7A83K+uyXCijmHdS88YOhbjUmrC7drYA0eKE4bW5H7B7gKUAf3HCn/7kCONmnmtGbUp2F6iUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7R5yJ73QMuMJa/pOFz5nyJoXoV8X1KVlX2KPA5brcGk=;
 b=oTIlfCOFfVTJJThoMafghywKz+ZPGWCt9xRfUWK1r5k7vGrxUYu0+UXuWM9GFZfsdhR6WM6C9B30cs0ilkBCO+IkXVTjWvqF4xsVPggAcUH7sTZ18Mbn1pVaUqbF2dAYo9bTggFXTTAqaavewzh6vUj7EZOYUWFIsGO3fUTRyN6d+mbKJfZXuLkSPLH4uhDgBIez7e8QIsV2psQcSx0lvN+foh+SIixfQsA5UC2QbFtjvUwFtn/ITUraPiK87WWlW/9ynBTr4lB+T6xtPwbL/FBuDPlXNLLRaqOI7J0IAQ4T+2KX9ESTcLXQpsVlxbqWn05GB9qEfiTMtDXbTcvxMA==
Received: from TYZPR06MB6568.apcprd06.prod.outlook.com (2603:1096:400:45f::6)
 by TYZPR06MB6545.apcprd06.prod.outlook.com (2603:1096:400:465::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 05:55:46 +0000
Received: from TYZPR06MB6568.apcprd06.prod.outlook.com
 ([fe80::b803:eff4:ebd4:9393]) by TYZPR06MB6568.apcprd06.prod.outlook.com
 ([fe80::b803:eff4:ebd4:9393%3]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 05:55:46 +0000
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, Dave Airlie <airlied@redhat.com>, 
 Jocelyn Falempe <jfalempe@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, Jani
 Nikula <jani.nikula@linux.intel.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] drm/ast: DisplayPort edid supports 256 bytes
Thread-Topic: [PATCH v2] drm/ast: DisplayPort edid supports 256 bytes
Thread-Index: AQHctghLcM60vWSjB0q2hmYy6od4zrWz5cqAgB8T2UA=
Date: Tue, 21 Jul 2026 05:55:46 +0000
Message-ID: <TYZPR06MB6568D830FCFB93A9776333ECF1C22@TYZPR06MB6568.apcprd06.prod.outlook.com>
References: <20260317-upstream_ast_dp_edid-v2-1-31166703c491@aspeedtech.com>
 <2efefedd-a36a-4b3c-a2cd-89db3499ebdb@suse.de>
In-Reply-To: <2efefedd-a36a-4b3c-a2cd-89db3499ebdb@suse.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB6568:EE_|TYZPR06MB6545:EE_
x-ms-office365-filtering-correlation-id: a07a5800-28e3-4b96-d3df-08dee6ecb567
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|10067099003|56012099006|4143699003|13003099007|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: CdrYo8P1dexnqSRCBFp47Cx+ZOmtr3ryf1mkqxwmHvpFs5diFpNu8YxBDoSEiarQFCUEasJVUXWTA8O/f7LNNuHFbPu22EQmrr0+1cjyhInW5amWSTRxG3N/2G/2WnAg3YxfwDjSTGDOeLAh69txbYtblln16MTXZXFKU7835C8p/NMJ7I7v4JY6i8n67jC7fauhcMQOpaYxvXt16mIcioq4fq2TZIkfouXoPUSmii+royu2hyKDHjynzPuMVTARvKxjmEePLg3S/iml7JPVw+DTNVej7mp7ojYtLz0rj4pNjKVq7G8D6u+F5ByzovOQgXriTbmxWSYD+ZuQQRxPFmGS2ypGUImf+pnentLfmH9RWU8zhrZvF4xrvSOk8ja3f4nAROyR1SmWpE8ZLb3BrJlJJhZU9Ur39U9V0qwFTIJWg+0ckCzWW4rc2PF3k7IO5CJey38xk92bKexOGzSw6WMwyp1GNqe7DUMsuMd6fZm17Ab3AbUU0uW8wpjDHsGWeRUGfO96VdDdPFd3fHIP9cE5qrmlt8Ha9J/cuGPnHCdT0ZAUukutjchTzdyQg6n40IQ1IEJz+m1V2Mofn3dRrHX/pjWS6mrYD/JQBKFoNhevMAw1LxZg7hlZA0ZGLkiOSh9nzOoJkBCRd/BRmdE/Akoayss5+Xch0AVQGLWoqsQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB6568.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(56012099006)(4143699003)(13003099007)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8FJEcjyXo2xSL5BoQJlMIWfnZ18MyjPegX7yCu1+KjRbEcfQ2/+lXRI0tO?=
 =?iso-8859-1?Q?Vh2IXMUjsP2aFI6xV1PDirtxr3rPjOeh3ClwjAUQvEgZYbEFoLkpqOeUxS?=
 =?iso-8859-1?Q?OolnlLwTypAOZmFjEgwG+eiaPdjsFHJFoMDc/4jq3a2e5LfXHuk3th7ixf?=
 =?iso-8859-1?Q?dLlialkdrUmB8dXh6Cfb26bSXM2DlMvt3dc2uNuoD02gn7sfxV2vuzzgs5?=
 =?iso-8859-1?Q?jxr22cKkSuXnppdLZXSjJtEkNScZxVljzyqV2RXjfSsJ86Cq3CpV/K2jBX?=
 =?iso-8859-1?Q?aVVt8CQDIMQW1MvMQXwI7n6iFhIRP60iNgvctTXb+2z+rsTGats1UV0GWl?=
 =?iso-8859-1?Q?T9V4lZEeeer1ir5a1levTiO0DrQDhnu8zPVF/MYJOqjK0b93DXIUYnNixw?=
 =?iso-8859-1?Q?WdL9qxwX1ARvDyECORsF1OueFngtHULyU3QUDuPU08fAj6Ww7Wvv7vAggl?=
 =?iso-8859-1?Q?/iupf9ExL+sq93lQsGIl3GliezTe5Nc/CzOgG7TZgDxsoe0mwA6LC4Nifh?=
 =?iso-8859-1?Q?ipKqC79EzObqLWN7dkuXvSm4LG4Xh8g9qbO+roOby0HuW9wIW7O0hg4oRJ?=
 =?iso-8859-1?Q?lm7QDO6EJZoUGMJO/BA/YK3TlE10VNpDpnDh0XLr7azOi7oGhc4oLhMNUd?=
 =?iso-8859-1?Q?Ed54AyrwVSj5Qb8fRJyvOTOUZYEUmIH6a3duR8RVE5fVTpzz8F/asCUDeZ?=
 =?iso-8859-1?Q?tD4VA2oOk2hk1cQt7LFOMutdJY5wDkj8EKg+c0d+7P2lm+OSAooaPByK1w?=
 =?iso-8859-1?Q?qgQmAl48UlY9i1WmUo+6AcEoxqLrLvaWG5kVDgg+qW6kzDph2KMivMhlel?=
 =?iso-8859-1?Q?81BzhMzGjpOAmCn4gF/Y8syxQF9t7LDS+hSvJzSPgMJi23Y8GmzEsv6fXI?=
 =?iso-8859-1?Q?cxGZ2oCjT3oD670OdM6bjSK3sDU5vm7Z4eqk9sI3cFDt2BTUoJxDeK4/6v?=
 =?iso-8859-1?Q?o3d+vt0mTTpi+dS4Vr06HWEfmd2+MD8y3GNmagJh/jD0plSRWjBtWS/lxV?=
 =?iso-8859-1?Q?qGRqDCBj5G6/SVG9V09piB3VD7i+S0yUf/sRzSzS6Z/Jb4FOsMY87/Pnbq?=
 =?iso-8859-1?Q?w8DBygudwo0k9i6rSwql6ZeN1lqlJZbJLTgqQ3jmcf9GFavZR/oJi/1VtB?=
 =?iso-8859-1?Q?QhzEq7SaVg5/m5TG56oQQEpEXa88BYlWuJJQxkBIFqR0fRIV6N3cP4uA6Q?=
 =?iso-8859-1?Q?WRV9n1LmmNzvXi0Vf6nWmqjA60/sJlE2xp0sMvHCBPI0xanMdEAbcX2swF?=
 =?iso-8859-1?Q?Eky63xcZeGa2hju/eHWQnQuHCJwkEbAlCKx5P+8JOP+d8/bi89Ta1G399H?=
 =?iso-8859-1?Q?3C9HdXFS2sCviVfjiGM9RF17QlWZmSGdaNDR8UBUO0toddZmTPyrPsw7++?=
 =?iso-8859-1?Q?HaqqvNwQu2qcJOMHy4lgLJVMDVg6UAvz+tJLv/BNUMo/69oxz+NnpIjN/B?=
 =?iso-8859-1?Q?cI5IFre2RG7LWClhwOkXHqpSQuHjT7O7pT5t60f/vQSaGohldJOosMOahx?=
 =?iso-8859-1?Q?h/3BUFNznaR2Ki96q5OqZUCMdNS3tK08PZuVBixJ7H/pxOiG15NvNP4SU0?=
 =?iso-8859-1?Q?90z46dU4YCVfvDiauBYuli39JQhGhRJXnmXMe0amd022Mt598ztpkpmMvq?=
 =?iso-8859-1?Q?a0+C6n8mR2uhajjpnEGowZ5IJuY+lhrzTXdEHxVuxABTufiULwYa8LGgnH?=
 =?iso-8859-1?Q?1tUogtf041EaWhEe3sOTR1bPRnCCLuu9lyaAcSjGSXA5/3wRAGddtGTB1V?=
 =?iso-8859-1?Q?k8izi5WAsfI9tmSAvsOEbSY+R0BrvvGCJT4TGz62vSDyZ01wdJTazN+TS9?=
 =?iso-8859-1?Q?ZFRTMgHfVA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rqZ4nkLODvw6T3VA9kD5yNIV1C9scHMzX2qNX8WXGHcocU9C/udqNHwnvW7GcE4bsskTPMGbm1oDrs4lJYEzVhCehQxJ7FHl0hPsAyxgAY8c0Yr6suk7i77x1JaBxJOdkDPgV2S22dl31mezR5b8dRvF9yOislWxjLbZqRABRa8gOPIisHPdZF+eG1ihWcE+BHguRA4gVrxlmJx5fONXv8OtHD9mEs7M2pyvcdcVlOHhAP5cUoG0iQBcnOJTfTMdoCqOP1zcazg9DeH2+ix+qCKyFMDU677IZ/wTeFEaPabtSwNqvMjISeT6Bw8aIlc5PyxsQGXaD6RwYeHqEjPTOQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6568.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a07a5800-28e3-4b96-d3df-08dee6ecb567
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 05:55:46.2653 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ccbjGU37yfwjzJqkOijsCro+2TfctUEmLxDY2a8IBu4QnLngBOK2p4PIADQpc1Z731tdZb1BgBTzsMUPdQGSbag1VUUt5YKUfX0It5pHiC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6545
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

Hi Thomas,

Good catch - returning 0 without writing to buf wasn't safe. But I also fou=
nd that returning -EIO isn't right either: _drm_do_get_edid() treats EDID_B=
LOCK_READ_FAIL as fatal for any block index, not just block 0, so that woul=
d have discarded the whole EDID for any monitor reporting more than one ext=
ension.

In v3, for block > 1 I now zero the buffer explicitly and return 0. That ma=
kes drm_edid's block checker classify it as EDID_BLOCK_ZERO instead, which =
is non-fatal - it gets trimmed via edid_filter_invalid_blocks() (extensions=
 count reduced, checksum recomputed), and blocks 0 and 1 still come through=
 fine. This also directly addresses your point about the buffer not being g=
uaranteed zeroed, since we zero it ourselves now.

Best regards,
Jammy
>=20
> (cc Villa, Jani)
>=20
> Hi
>=20
> Am 17.03.26 um 13:19 schrieb Jammy Huang:
> > DisplayPort supports EDID up to 256 bytes (blocks 0 and 1). Update the
> > block check to allow these two blocks while returning 0 for any
> > additional extension blocks.
> >
> > Furthermore, remove the manual EDID byte manipulation logic. The DRM
> > core (drm_edid) already handles error correction and checksum
> > validation.
>=20
> Does that really work? AFAICT
>=20
> - The allocations in _drm_do_get_edid() [1] do not guarantee that the mem=
ory
> is cleared to zero.

> - If the helper detects an error, it will conditionally print an error [2=
].
> - As ast is polling the EDID, it'll fill the kernel log over time with th=
ese
> warnings.
>=20
> I think we'd still need some sort of 'valid error state' that signals an =
EOF that is
> not an error, but still counts as an invalid header.
>=20
> Best regards
> Thomas
>=20
>=20
> [1]
> https://elixir.bootlin.com/linux/v6.19.8/source/drivers/gpu/drm/drm_edid.=
c#L
> 2366
> [2]
> https://elixir.bootlin.com/linux/v6.19.8/source/drivers/gpu/drm/drm_edid.=
c#L
> 1919
>=20
> >
> > Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> > ---
> > ASPEED DisplayPort's EDID size can be 256 bytes at most. Thus, EDID
> > blocks fetched can be 0 and 1.
> > ---
> > Changes in v2:
> > Becasue drm-edid will handle invalid EDID if happen, we have 2 changes
> > below.
> > - Return 0 for the number of block more than 1.
> > - Remove modification of EDID
> > - Link to v1:
> https://lore.kernel.org/r/20260313-upstream_ast_dp_edid-v1-1-2a75b7c091b2
> @aspeedtech.com
> > ---
> >   drivers/gpu/drm/ast/ast_dp.c | 18 ++----------------
> >   1 file changed, 2 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast_dp.=
c
> > index 9d07dad358c..282c694218c 100644
> > --- a/drivers/gpu/drm/ast/ast_dp.c
> > +++ b/drivers/gpu/drm/ast/ast_dp.c
> > @@ -88,8 +88,8 @@ static int ast_astdp_read_edid_block(void *data, u8
> *buf, unsigned int block, si
> >   	int ret =3D 0;
> >   	unsigned int i;
> >
> > -	if (block > 0)
> > -		return -EIO; /* extension headers not supported */
> > +	if (block > 1)
> > +		return 0;
> >
> >   	/*
> >   	 * Protect access to I/O registers from concurrent modesetting
> > @@ -154,20 +154,6 @@ static int ast_astdp_read_edid_block(void *data, u=
8
> *buf, unsigned int block, si
> >   		ediddata[2] =3D ast_get_index_reg(ast, AST_IO_VGACRI, 0xda);
> >   		ediddata[3] =3D ast_get_index_reg(ast, AST_IO_VGACRI, 0xdb);
> >
> > -		if (i =3D=3D 31) {
> > -			/*
> > -			 * For 128-bytes EDID_1.3,
> > -			 * 1. Add the value of Bytes-126 to Bytes-127.
> > -			 *		The Bytes-127 is Checksum. Sum of all 128bytes
> should
> > -			 *		equal 0	(mod 256).
> > -			 * 2. Modify Bytes-126 to be 0.
> > -			 *		The Bytes-126 indicates the Number of extensions to
> > -			 *		follow. 0 represents noextensions.
> > -			 */
> > -			ediddata[3] =3D ediddata[3] + ediddata[2];
> > -			ediddata[2] =3D 0;
> > -		}
> > -
> >   		memcpy(buf, ediddata, min((len - i), 4));
> >   		buf +=3D 4;
> >   	}
> >
> > ---
> > base-commit: 5ee8dbf54602dc340d6235b1d6aa17c0f283f48c
> > change-id: 20260313-upstream_ast_dp_edid-5fe6adf7ad36
> >
> > Best regards,
>=20
> --
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstr. 146, 90461 N=FCrnberg, Germany, www.suse.com
> GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG
> N=FCrnberg)
>=20

