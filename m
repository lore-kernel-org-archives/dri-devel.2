Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAED2FF885A
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 08:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2405310E50F;
	Fri,  1 May 2026 08:21:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="dt3CDjf9";
	dkim-atps=neutral
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazon11011051.outbound.protection.outlook.com [40.107.74.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D358510E50F
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 08:21:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqL04bT6o9VRlxU8vpfFmO4v3E+P8HV3n2ALzRZbB+hGs0DGiHwQgY+B6ryP+oi/5GU9yfB+22qYRHHAfI6qHDAKH9p1SM0wjUnaxvlJRYumWD3FAzk1/ZcSpE8EjF40668MuuV6ySyYH1X92mTADpSKd3ht8g0oElGu+ORPYJsK0sDmhZ3m70kxYevy5sK9ZNxyqhoxGa1T0Dus0+Bsz0kBtqsG+es5pV5T2onDPKyG6sOiFdXdDY+Bv8Z3uWmkSDIELaCnO2w4t7Ev0svcbfk7G05/zQ7FeAdesJS2Lvpq8bdjR+iX4spiQjPzxdK73CoG/5w8jpxpyjfGaf1tjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXrfBrdxNhewRWXpX/+1n75pvJxghzwDymRF3twjJHQ=;
 b=DLZPKy7kDRwZKiz5yqdTSe8GV6gxnFoV0D2+prb3DQw/7fK4vtQcKx0j3jme2zO8MCg6r3giAtp5WonHMOg9KCX+Bt4uiEdAzb5ZwRgL6OhtXO/GywW2cki4SCnY2CZ77NTHKNfchHY6QHtTivUv/+eLgOXKI2RxJz6uJ/BJ5+mqo0RMRn87ZFdR73530vkQ9L4u0yPin6shHSUqnmmFriyhzQW7ZF/r2fzqJg9vl7M0Df/1yu8vrDOgJbq3f0NdZIA31NYehR+AD0sVYNCxDj3LUTs/UMa2ZFThjHuql4MydD2ifDsl3Bl5yw/En686JChzRAQOT0P+yXa+RifzXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXrfBrdxNhewRWXpX/+1n75pvJxghzwDymRF3twjJHQ=;
 b=dt3CDjf93v5rLxPpcD3vTC0NqhR/Yms63KVStf1SrTyLDfjzuawI/MnH+ArPdFgmNydiHxgzn5SOWnftKVGvdimaennP2mBNYXPZXKhhOwUXoSUDFzU8z13qMd1tQLDRWFeML/912UeNAQWT/PFu4a6VvyrLxhgXOdf/YTaAcTI=
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TYRPR01MB12629.jpnprd01.prod.outlook.com (2603:1096:405:1b2::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Fri, 1 May
 2026 08:21:31 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9870.016; Fri, 1 May 2026
 08:21:31 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "john.madieu@gmail.com" <john.madieu@gmail.com>
Subject: RE: [PATCH v2] drm: renesas: rz-du: mipi-dsi: drop duplicate
 platform_set_drvdata() call
Thread-Topic: [PATCH v2] drm: renesas: rz-du: mipi-dsi: drop duplicate
 platform_set_drvdata() call
Thread-Index: AQHc2UHO9YnYkthdH0aCcaXmgOmQLbX406iAgAAAX1A=
Date: Fri, 1 May 2026 08:21:31 +0000
Message-ID: <TY6PR01MB173770FD0BA340F5A50633E21FF322@TY6PR01MB17377.jpnprd01.prod.outlook.com>
References: <20260501080818.955914-1-john.madieu.xa@bp.renesas.com>
 <TY3PR01MB11346EF532EB7974EFAE4BD1186322@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB11346EF532EB7974EFAE4BD1186322@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY6PR01MB17377:EE_|TYRPR01MB12629:EE_
x-ms-office365-filtering-correlation-id: 5a9f31dd-6533-4131-dc18-08dea75aa691
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: w4Oe5tkYS+gT6ez7S61obverjgp4fSYh50SnF2PFYjfSAJX4uNFEjETarIwkoNwAOY0wgbZZGtfxJqT1KGk7EbhLqY++pmlSpji3A/2vIozYr2ekQs357z0+IipBm6m/5m8h+FXgTXq/pw6w59bEeFkKfAHPhAzbNnmvN27tmhSc5d1GB1uuXzPlSjX39VSGj3wz0++bFGj1Loa1AeNmeHRBo23e2pOijy+b1vCd10jkQddMeZ/Ym8HPp6tyUoHW057PWCR2YRodxxJy4lnNwM2sKI8AxE+8OytapKxkFO9X3/zgAE1oCAqs1ZQ3bn/lrwXWvGosN9wjGCwTxw2FThdqxDQT8TBAGpBTlkoAiIiJnMyF/yvkSIvSlQo/8AZtSGiMWPSznBQQ1sh7ZpyAA3inzIVK4qsfSVvrXEZNqEMXw6Dqvz7HtE+BcYIqY3zr950u8LRV24JFbc2OfSQP4IU93KP3koTAE+f0PW+pp54xp2eGqMxQGqz3Ee8wkRALD2iZyMmyKOxouEyOSRmFpgCDFJEl42BuJleBgp3hlD34TFW1ON9FMIaB+JiexfwNHEVWz31jwytWYS6OinsnjNcnxL2oe9zREawyzX8syEXOtNRgZkh0bdivqRnemwDebB5vGBYxByYf25OIPxFX1r7ZDTdSIt/EXDVMilDKn7qCt27xGicLXHPOPAgmrtI++Jnfabxk0zvZUcHJIE/6yuOSCchB7Zo4FZ7agpHaacJgkqQlB63E0QoKwJlePcEy
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY6PR01MB17377.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fBLGBdlzXyMFoaqE0DMjItemG5r92hLOkBIHH4jKuv8l3iRwVO27ThBtn4BO?=
 =?us-ascii?Q?E40yJTulZAACZ/Icl+BkGSO734h8ulYPjCTUEjbARnjBfLIQRBcYEk65cTRI?=
 =?us-ascii?Q?cgNkuWoHhJkv0fdsADgA6qBMknmuXceMvhf2qZwjSyroCZfUAUOBu5tztweL?=
 =?us-ascii?Q?ZfdYcVFYpOoCcWoz3CEmcnKF0rsUIdS4fRODK/BV+bVSXp57OPdot6uhp1I1?=
 =?us-ascii?Q?LZO8BSvttaehTA+O3W5lJZwX4Fh/+ap40x3SPf+5VmCPudSTYTGTZrlseASZ?=
 =?us-ascii?Q?3mumPLP0YVFKJbbFyz/16yDkGd46UJbaU7AS+jkgGMPo8ecAt1q9eKlHIYjm?=
 =?us-ascii?Q?ACtYQO0NseOOJsUrDdg/MSvIF614BUcRlWY30x6q83pe2vdkfLlQu7knuNrt?=
 =?us-ascii?Q?+Pd6oz98JyI5REX0lwn3bGdRLyOCI95OvsUH024xZeIWhVbcPeRh8vktA4zd?=
 =?us-ascii?Q?6vZZ+TafWfsztprGLcMp215z+Zrrj7DXxWPa47LE8dUg+9xv/0bquOexDcJ0?=
 =?us-ascii?Q?vt5bNjYTbHaQ0t/2cgiVL6dKu+MSuyNeVpJvtErK/oi/UABX4lP8QPB+hQWA?=
 =?us-ascii?Q?9aiYxCercaA3SF+3fVWDC53ouG8rCr79frjs2C2vC49WXSZqF7CiiPtEZe9Q?=
 =?us-ascii?Q?3i0oWcThLyNdugOgVC8Jcyr5Qez4iDPm+lRbdlfyrXjpVWZbpbgIjpXxCo5z?=
 =?us-ascii?Q?5F3+iYcq/k/O+pXOInu5Ofgx3M1wxJS9Xe0HPrxKr78y7Dg7YXN2chXnoB2p?=
 =?us-ascii?Q?6sVjyQRrJBhIEitDHF2INMkVQo679dgWahZu0cbw8w6CvTx9asVQxCN2qjt/?=
 =?us-ascii?Q?kA1whqO32lhnE9RCRwx13zXnKDl/VAMKL1OXzffLRNObqs/w/Y0Y+ZkH2fhw?=
 =?us-ascii?Q?9WsmctV3iRAz9pc74ii7X/HU3haWTlLzeffF1bdQp6sO1xBIliouR2OowRUT?=
 =?us-ascii?Q?2U2QWanPD2bJsPkS+7kCGDXdTHwT4sCdgYyvhDs6ARn9QMI5aa1zLYNXSHLo?=
 =?us-ascii?Q?q+2X9cYECaOJlpar9pd1WViQ1RKD/FlJpwgbRDmEGM6YkRagpNEKNmOC7FQ1?=
 =?us-ascii?Q?+2pKsoMtTNeFC0K3RAcqXB0Zw/DsyL+l+UY64mfZ0bMQsNZYpIrP0sgQ8UXE?=
 =?us-ascii?Q?G/EUMd3qUc7AOsMy5/37ykz3zlUS8cIo1zzHe+c8103oCr+KV0nUwexYvQsR?=
 =?us-ascii?Q?xhI8MeSuswMKJKp+j7VYX5IYEOdTVvSF897f7wY0opPo9H2ozCeO2kxb1Iv+?=
 =?us-ascii?Q?XHv8vuD+bpwer0gAYa5dAIbCyxGAhQcRqlztfgbl/kMZHG4lLHhbkZ+yH7Lh?=
 =?us-ascii?Q?xO//KveqUNvj1B+en/9zdMmnc8ycZEttJ9TZrPjXlIcxI0dT9hcLpGeiqz54?=
 =?us-ascii?Q?Y4ciCFwPEwfiFUDsj6viD/OVhwzB5yHLwDJodjtY65F9Qk53emM8l0GQsX2v?=
 =?us-ascii?Q?/0aYBYcnRCjcW89ejOoduzIZ/bKSTj4eJQhGrfSIhjPEKH2a3mHgtWcTL0zb?=
 =?us-ascii?Q?OWb8WuUxCPPwl5ORphOnhmghZAYNCcVn1M/Pxx31q8NnjWXT28r7ojiuiWt4?=
 =?us-ascii?Q?Ygd4Cn3jGXF9otdm7xgcd6MJIn1CKGGPwoYsCKGEmZS9XHhuwoagGs60knRY?=
 =?us-ascii?Q?BBEe2V5u9H2bg9cK2xxIv2NUn+aJpOlpmCrz7P6KJG32f1LPxwiH2NczWLXb?=
 =?us-ascii?Q?03o2jvpIVpShM4nbB1wDQrvB0D3xDmKJg5Zekixnm0QKTibgX1w02Qt7f4RU?=
 =?us-ascii?Q?7Zykz8WuS6pGt53/6xgXpuFeX17N4mg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a9f31dd-6533-4131-dc18-08dea75aa691
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2026 08:21:31.5867 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bV5qsTZ2sVs3tqesiDE1S5xgD8OFONbE24SfiUVtbxk8Gk+YItgsq3ru8eqeHlzkG1kmPD7GSHOex64oQ6IcOKiA7mJLs6sX2DbSPpzUeCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12629
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

Hi Biju,

Thanks fort he review.=20

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Freitag, 1. Mai 2026 10:18
> To: John Madieu <john.madieu.xa@bp.renesas.com>;
> maarten.lankhorst@linux.intel.com; mripard@kernel.org;
> tzimmermann@suse.de; airlied@gmail.com; simona@ffwll.ch
> Cc: dri-devel@lists.freedesktop.org; linux-renesas-soc@vger.kernel.org;
> linux-kernel@vger.kernel.org; john.madieu@gmail.com
> Subject: RE: [PATCH v2] drm: renesas: rz-du: mipi-dsi: drop duplicate
> platform_set_drvdata() call
>=20
> Hi John,
>=20
> Thanks for the patch.
>=20
> > -----Original Message-----
> > From: John Madieu <john.madieu.xa@bp.renesas.com>
> > Sent: 01 May 2026 09:08
> > Subject: [PATCH v2] drm: renesas: rz-du: mipi-dsi: drop duplicate
> > platform_set_drvdata() call
> >
> > rzg2l_mipi_dsi_probe() calls platform_set_drvdata() twice with the
> > same
> > arguments: once right after devm_drm_bridge_alloc() succeeds and again
> > after the reset controllers have been acquired. The second call is
> redundant; remove it.
>=20
> May be "Drop the first call and keep the second one, as it is close to
> where the platform data would really be used."
>=20

Will update the message and send v3?

Regards,
John

> With that fixed,
>=20
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Cheers,
> Biju
>=20

