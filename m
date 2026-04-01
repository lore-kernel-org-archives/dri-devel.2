Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115A3E7E34C
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 08:59:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D309210F41C;
	Fri,  3 Apr 2026 08:59:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="A4gmZPvg";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013015.outbound.protection.outlook.com [52.101.72.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56D2310EBEF
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 11:01:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KR1RUfjUKIzQMcglBwyAX0Df+NtnAt/c17XDIPXbiaVsn9eKainqibGHGEHFE1MMlq0z8t3GI2IcyYuogVvaD99Lpnlq25f9PMKN6BVPpTJVrHVIKb3S7qOe+IUwDR4MuvXg5916pom4e9b4v5sUmhxYfxPuewg+U2evmUDStqiRADaPulH3/mtd6HTFHYBxIGYfGqFImvKYwc3zivT3WoTvhCEhAv+LaD3J2OzDm+DHzvisH4QjjrzOKFtaXXmrj5wyNpDP/lEwBRzpO03x2fGMwFQYw64FWZORVVnORyEPC/tn0Uzg5a9bis55dhRK3yIZ4qwiv629CgDv53FHmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RR7dn+wRkXt2kif0IMG3BKngE8Pj6FP/v/oBR3R5abg=;
 b=T/aHFSxLjSEqflyvY5EHD6nQo7J/YNdCl/qXhGDRhRM3gUbzl8b602GLdV01jUu66k8y1+7YnDN0q/zOHCHKX7yxATfc3g+S/UbjPC5MSuEgvxDDw8ZcurMQtiWcL0uU8BCk3z2JSCY0TxoNpat+WI0lEgeTgpO+T9+xBXQM+HD7wgGl1jIAfz8jwXaHzASfb4B7HA9P87FT2j1YzPHLHrujswpJV9oml0ACHSz0Z9al6mJjdRDkCAnTU3twdljuPutWvp3HTiCVypT8TjzPKv1KfPOhXAHE9NGKgT/Sh+wmt/qcekuyaPbLqx8MsxgBOTxhDJ89NrY6zpEVGil6nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RR7dn+wRkXt2kif0IMG3BKngE8Pj6FP/v/oBR3R5abg=;
 b=A4gmZPvgdIuagVR7LvHPptnpoZBCdEBJmMc51DuzAtwdESkrsq3gEHgf/s1kkzZqlgqCu/N6RvGYE92H0CZR3XvyEaTE68q+kLVIvL3qJu5VRn5X+szT1c0orva3JCb/hroIc9jehTZDhoMqvy/1ETC/w0GZWi52d22PNHqGjp1XlWxOURP/McA+o78uFCDoNoGlnevJjEf2Wnyop+BLl2IjfujXlAVvGg/xINhVI3cx+d9bzkjX3FfMzFXn3noEh6WeAYnLyJLrHrirUgII50PPkwCAFWwQJqANj/5SLLFrB7N+9LFP3/AVgNt+uLuu6A5HNIC5+77wua8Fz61j5A==
Received: from AM0PR04MB4707.eurprd04.prod.outlook.com (2603:10a6:208:c0::29)
 by AMBPR04MB11787.eurprd04.prod.outlook.com (2603:10a6:20b:6ee::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Wed, 1 Apr
 2026 11:01:18 +0000
Received: from AM0PR04MB4707.eurprd04.prod.outlook.com
 ([fe80::e918:eca8:f034:698f]) by AM0PR04MB4707.eurprd04.prod.outlook.com
 ([fe80::e918:eca8:f034:698f%5]) with mapi id 15.20.9632.017; Wed, 1 Apr 2026
 11:01:17 +0000
From: Guangliu Ding <guangliu.ding@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>
CC: "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>, Daniel Almeida
 <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>, Boris
 Brezillon <boris.brezillon@collabora.com>, Steven Price
 <steven.price@arm.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <frank.li@nxp.com>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Jiyu Yang <jiyu.yang@nxp.com>
Subject: RE: Re: [PATCH 1/2] dt-bindings: gpu: mali-valhall-csf: Document
 i.MX952 support
Thread-Topic: Re: [PATCH 1/2] dt-bindings: gpu: mali-valhall-csf: Document
 i.MX952 support
Thread-Index: AQHcwcbd/tMXVB9tRkmqpeQn2Kc07A==
Date: Wed, 1 Apr 2026 11:01:17 +0000
Message-ID: <AM0PR04MB4707D758EC8B08C6D42F3A82F350A@AM0PR04MB4707.eurprd04.prod.outlook.com>
References: <20260331-master-v1-0-65c8e318d462@nxp.com>
 <20260331-master-v1-1-65c8e318d462@nxp.com> <acva1Xt8V4k9-uG8@e142607>
 <AM0PR04MB47073E9E8B5C704BCF5D9F72F350A@AM0PR04MB4707.eurprd04.prod.outlook.com>
 <99a1da55-d6e5-4d11-abaa-8c85283ab5f2@oss.nxp.com>
 <AM0PR04MB4707B3E37DFE7AEE587DBA2AF350A@AM0PR04MB4707.eurprd04.prod.outlook.com>
 <aczv0R0aQRmHKdvt@e142607>
 <AM0PR04MB4707335CC7035232D44E6ED9F350A@AM0PR04MB4707.eurprd04.prod.outlook.com>
 <2f4c4063-daf6-48f2-b830-9f58dc7af80d@kernel.org>
In-Reply-To: <2f4c4063-daf6-48f2-b830-9f58dc7af80d@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4707:EE_|AMBPR04MB11787:EE_
x-ms-office365-filtering-correlation-id: 4143c5a4-086a-43ba-d599-08de8fde0003
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|19092799006|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: LAgccFmoZ2dccMeiWUlfBr0TFSJjJeFyxIjK3/Gq2TX/jsCKF8zMEZYRsr7IxY/9xQA2of1/OuWuUW2ZxGPnXxg43IO8cLBOGz+3xj6nppY91j9XEoLpHhJjVKXZYgo0h8E8FvF/89HuJJhwy4qg7JolE7dG0YeuMFx/YC6pX04P8vh4Mowc0mtZMMqEDCeqsXiOWHwXblJBOYHNz0AXe60h9VG2nBj1Lb/y2kbyQesABJu//MIEg6mvMBFB9B4lNN4cgeWGrqiF11sPwGlApPAGj2WXolyoRMfMD5SmTINU5U2kMvlLiPGyv/JEkQHnayU3nq157vwXaCEy893nr0ggxdHgpiC/Iox3v92QDVxK/uzB8NrNqKF7dHgR3yYZNktYpAqZNPZum16jvuJAqvi1Kk++HgoY5zmoJXmt281BbjLJwVXg22SK4TvczBfWBZ82nWHq18xeuctmRGuU+kbgQfqzHUDtbslMnB9TnjzgY9frDaSEpW+Afspa3eBjUVyxci1VyHP/k5M4LMjYJKC6WO9ZQIpG5xkHjpxlTZcnhrkkWvJ54GKx4vaKN5YLibIngL+0umaIWY8DZj1ntLg9rjQcd+Y8eaB5pKAlmznMRW2IVxvpOQmGulgmMyohd1K/9UHPslju9A0uZy8hqOVY5nWSBaiWO+cBH5o59loLGc8zafwCQLLCNcILK69njR1TAVvsoXvu+fjYr/iP9Mjnpo330E00hp03KzNPMC1sobTHy+s/G5KdUMn2KOtr9N/MO8+ifbG1oYBtLARq7Cov9PEPnFIeIy2uonX0qeI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4707.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(19092799006)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MXYhSIuQddBjStJyuco50baT4fPWZYnBcHQDVxNKQqIdTl6jCT6D8NgjfK+G?=
 =?us-ascii?Q?H3zY6c/TqpwEi6kBdQpPYxDUzCTR5843v+urwN2tQSgoNk/i8I+0b/wzp7c0?=
 =?us-ascii?Q?FS3qm27P8h+Xyy6BKKkEionlXy9kfeWhHXPW+cIjep31hMPYmyfXiuxKK2tC?=
 =?us-ascii?Q?IbUnRnXb4dC95NN6wj7RZeyfGWQrm6+OyJ/nlcUOXz1+OJgC9FN6OwTv0EUq?=
 =?us-ascii?Q?30e/6LmnAxoHUiiisWbrMgkTmW9k0rMZoPzDxJtQKqTbCe7EM/WZvEjgiaU9?=
 =?us-ascii?Q?5oYCjFfXjkPGm+JHFYJr6yyYevYIky6aV3qExnrG0LUP0+2vyNW4Jrrp7Z37?=
 =?us-ascii?Q?S8g57SGvbACKubzrZsp1tMgF7vayjK5y4KUI2QGNAhXd2RTukcQL+jW/Hvro?=
 =?us-ascii?Q?qBTIfdhgQasiCayYj/z9D0uKiQdTBERAiwQwUiAN0nTHbb0jEqIqAzqlug+j?=
 =?us-ascii?Q?uf169I78KJpyTCI+AGyu+MCuo5eUBHGaLaxoM6XTMdUC6tap0HNeR2rDorw0?=
 =?us-ascii?Q?KneD9XRbToRfIh5sjb+kWH8ma23/BfvTU3U07xFodE+3RnhvaDaqHMxq17C9?=
 =?us-ascii?Q?v+jPwdZfcfnrcYDP3ROmgvARKOjHN0FAfc7271rcfrwzoqLVymOV6oirfJzr?=
 =?us-ascii?Q?jSbx1ORkc8Tjm6BLDydtH6b6m+Y6VlZQwOgqly84XbjUYV9zzn2cX1Yhnk9r?=
 =?us-ascii?Q?+pvphSSLbH+Gk/4c6u0jtFTHcsaUGvMbgZfqJ/8AkBdwpOazJslmT8KSMfPB?=
 =?us-ascii?Q?Gg7FX2jEfWuZzXGlnS6mlrbAuzACGhKaUSE5aYCh1Yfy9SfWGMDoSMM5ZtNZ?=
 =?us-ascii?Q?BxvZBw1p2kMpeNVB9e6Xi6BKPdNoFa6B6txzxSczyLq9wNJZKgkb4KpLDwKq?=
 =?us-ascii?Q?VyoPtAV/fItDx7JHGP+GNSgeYtg4l1bGBGAgcHlA9ti6X02LGIFBMJ9gouLv?=
 =?us-ascii?Q?h7vwe8/81morSJRkGWHnIl2n7iYlPQlQzWsK85O6bNJJO6MjQ7sLESzEdxVE?=
 =?us-ascii?Q?itySTjCCK76YYCeY05KH2wphC3cpCvnVxYg6+6AF7BFjLrXizDbRMpNYbwvP?=
 =?us-ascii?Q?43UnQvcPBlk5tLeM1LaSB8noYcpM6TFBFZQ/r4njroKN9rzJUlQJpWf0yWFv?=
 =?us-ascii?Q?WteEAo55/eg1WiyGTuUol/jQQlk3YBdjA84hQDICgoqGWcLtMSAkkbjBV6rM?=
 =?us-ascii?Q?nNZXgKwDeE1nBtN3aHY1vNK4ejN8n0fsyPlDZFDmFTVu/mVyOfTZw6b2Sfv3?=
 =?us-ascii?Q?wb7VfXoSWevDmDVBqRWihRIukNA0D3qA7wehbvK1O9MbJKBgSts98Etj1rGW?=
 =?us-ascii?Q?MzK0yc73HS2GwwBzp/C9iOtP2QRWegQi5lcJxHyfNi1stT7Em3KCwkxvvuZR?=
 =?us-ascii?Q?0iLFmM8MMB0jY8mVfTF8527pJcHVFWHAZZtMsswFmCLh2yRCsHBHHvTDpeSS?=
 =?us-ascii?Q?HPv9XeIIamt15oZtzs8GMMK1OrD2+jjclJqv/U9kbjsZsucdZbcuzFb3iERy?=
 =?us-ascii?Q?y3RZmyhpDRoUCXw6eZ6ejy7CARSudbZCwgdbN8H7fPlwn/cL9ulbkb8DrGeG?=
 =?us-ascii?Q?QMjJw/kg8/lVL1G+dDAmll8siHevWLD+JMmGPJbeF4yh2PyjeHWTXt2mQCW+?=
 =?us-ascii?Q?fgQR932IxdfjSyDQu4830GehCp0rhXtDemCwlZvi8tvSIhq3EZ5oJASqEh+Q?=
 =?us-ascii?Q?4iSrx2O8PCfnRN60nYfrfGauI80QqZ4uwshmQL0b+9MPYdYm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4707.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4143c5a4-086a-43ba-d599-08de8fde0003
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 11:01:17.8717 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9nrBRVidejKW8ssmd4sQXJ5X/3ShbwOQTD1wxWU5+q5QkFFzquAVhkbMN+rSX2DOGlrL2ngSTFuoE8fhs72cEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB11787
X-Mailman-Approved-At: Fri, 03 Apr 2026 08:59:17 +0000
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

Hi Krzysztof

> On 01/04/2026 12:31, Guangliu Ding wrote:
> >> Either add the patch(es) that use the compatible to this series in
> >> v2, or put a comment in the commit message on where we can see the
> driver changes.
> >>
> >
> > According to discussions with the GPU vendor, this is a hardware
> > limitation of Mali-G310 rather than a hardware bug, and it has been
> > addressed in newer Mali GPU families.
> >
> > In addition, ipa_counters are not enabled in the current Panthor
> > driver. We observed this issue with the private Mali DDK where ipa_coun=
ters
> were enabled.
> > Therefore, keeping the compatible string is necessary to allow for futu=
re
> divergence.
>=20
> No one discusses here whether you need separate compatible string.
> writing bindings and all my talks are (e.g. DTS 101) are clearly expectin=
g you.
>=20
> We discuss only the lack of compatibility in terms of DT, how DT sees
> compatible devices.
>=20
> And lack of driver code is clear indication that devices are compatible i=
n terms
> how DT understands it. Feel encouraged to bring actual arguments in commi=
t
> msgs in the future.
>=20
> Best regards,
> Krzysztof

So the best approach is only reserve "arm,mali-valhall-csf" for now, since =
currently there is
no need for an additional compatible entry from a DT compatibility perspect=
ive.
We can introduce "nxp,imx952-mali" in future commits if hardware or driver =
differences
actually require it, and include more detailed justification in the commit =
message. Right?
