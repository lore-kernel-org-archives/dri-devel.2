Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A743FF885C
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 06:39:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E0EB10E00F;
	Sat, 25 Apr 2026 06:39:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="D/3L2X0K";
	dkim-atps=neutral
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010010.outbound.protection.outlook.com [52.101.228.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FDB710E00F
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 06:39:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tnGSmHVTb7XhsbxoorAVJsxtYIWI1UKTZLYmswelQlM9AVkeUaw/mzr9p2HxKKD6Hu1HblAssnQweUJNpcQV1Keqvprw266PZT/hnI0355mslhthnd6HtD2hwSDKrnLtytNzSTVB0kkJLIuaG2hymDEecC2X5ugwVijSNmJaSE2nBqcWMrbevKD0/AvLPwLeaWqyHokGbZ9+MB4qlqDv+jd4nhBff9CiEMM3XoN/HFJUxkYm55c4y9XALhaoCxvB5beTRNV/SJ31IOPaDxNNhYSfi3M/16V3wZjGwvCrRnPnKNkhbituHe4HBN7Jb62SBZEFQH1Bda8u7Qyr4HaneQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HZlZjF8BMVc3vDR5+4WvjQfzbxvtvANiKyfQQUJNOc=;
 b=EJZwrE0SEIJW9liq2rdGrwrbiXeV3meu7wQIGxb5jY6lVuoYMKrBo/hJ6mAAsW7rAuhkvYdwV6A6+Sa0zhRMwVhMndA+XZYypsYHqLJa85rCq5bWAMVkYdqrsFPFAGh5z0R8dSvj8qSH/+FCXrovJBCe5pvnD+d+9MlMUZ34pjlGntl9iKlJ0v7KCJWt+h+II+QiCiY1IecyQE7jdDrVeuSZhXnVhe675eJRnfE3qU0YfyILwwaDEbGxuEk52JiGw6oJwOrdbcPkNTPvmVwwr8EYWOVvRQGDpfeq/9qnr/8KanL0yuHjnhkYJQ4Fg636i5yydMMmXwL2PhApKIDkuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HZlZjF8BMVc3vDR5+4WvjQfzbxvtvANiKyfQQUJNOc=;
 b=D/3L2X0KZ6W64L1L6giIY3ajS4HlHP4NKArDWH6BNPBwUaVumJ/obpOHs+IBpI/hIg6Xw8CF0+Xkaebht+RUS072fTsWXKKY/r2WABJY5H8QFjxuIHoB+ywC5QmYsQJ368BXko/s57ANqTPuYQSgxRK9DyGdBSBHf9tddAiPRIQ=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB10153.jpnprd01.prod.outlook.com (2603:1096:604:1e4::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Sat, 25 Apr
 2026 06:39:44 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9846.023; Sat, 25 Apr 2026
 06:39:41 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: John Madieu <john.madieu.xa@bp.renesas.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "airlied@gmail.com" <airlied@gmail.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "john.madieu@gmail.com" <john.madieu@gmail.com>
Subject: RE: [PATCH] drm: renesas: rz-du: mipi-dsi: drop duplicate
 platform_set_drvdata() call
Thread-Topic: [PATCH] drm: renesas: rz-du: mipi-dsi: drop duplicate
 platform_set_drvdata() call
Thread-Index: AQHc1Fth6WAavjC7t0+tqZxtVO5pfLXvU0+A
Date: Sat, 25 Apr 2026 06:39:41 +0000
Message-ID: <TY3PR01MB11346EADBA4CCD3950E93A41686282@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260425022857.2382603-1-john.madieu.xa@bp.renesas.com>
In-Reply-To: <20260425022857.2382603-1-john.madieu.xa@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB10153:EE_
x-ms-office365-filtering-correlation-id: 163c26ad-f404-43d0-e114-08dea2956e0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: KAHgKn73s1kTFgnpfWjw/vBNsWIzOwewqDwgtYuhETP1as+eqcQ+SBe7xNaFJz6AIptJFAOJ8ifSLHsoabJCGFiJQeILVKu8Q+6XktfEkuTNfYAC9py2Ak+EetiwlP4cIX8T7AsTBIEQbUKHATw1WC/6xZwvKtMYpc4IS+WRZ65Qw43qB37aOF7+7/3LdT8q5nZ4D6zvJ8buZfLZLF6HiPWtFfZoYNBE3vWfYcuS0ZcULqQ+jte4UMwiUlsQ2QCb+QooijT1sGhKPjGc76/IrvpIN/RgAPvbdk4KAt74LQ4gPYY7um0Zdt6cYBZrDzf3Qe2+iJjBaCHqWGFgHxrsB+FrY2F93pGpkl0xppFoLmmRitaJY3KywBefrtmC6XD5UzoWp2sCPxmdTmM70ZMbGFhlYKzHBREJJaxAu4W/fsH3SlT5HqntQ+IqLNl5JBRWv8wsScBRNvjWHzITpK07ETMtzwpgeQ01187agmNCNoB+eAnqGC+9yST77gf72mb0KWygoZjBsxJKju4tKx7+jQFcaoDaEqXv6OkNE3AjRx9UAuRZ3NW/j0/1fzkfIMyiOoYsR9EML2HoENY2ZluqF/QHLkNZWPQ5ePF64RjC+gePoHVG1UD9NXQ/TmGfctenxTITU+NxxAKfyuBtLpsrrbNmSeSrGJC33yN5TbcxrRxm3f47bXenYkk20ypzltMH6I/HeT4BazjjsXKznGx4LRGyuP4awoz+zX9w1m1ibPLE8a0WHl5Pr6ENIA2+oaMAPyehS5faGnJKe2ZM3VRJjkVYo31orN09jJy5ulrrujs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JjQ1KBt/HNbMMqe3Ga3iFexDYWCmH9ujZ9ElQeobkiulpF+jD6xQ11Ug6Ire?=
 =?us-ascii?Q?NPkRTqgoPTXo1w/2gHgBcDp//Ty7M6BY0Wa+mzcQ5+pS3ncDkNRsjkU3lI+d?=
 =?us-ascii?Q?2mO9PP7mNGeuL6hc5Q4BXheK5lNxTFGKHtomzl3gdcWmrSfjr0rXFji8Xter?=
 =?us-ascii?Q?HF51CbzCo3N2FVtvmI1aDLg0DpQz1lV6daEZOrxaYe2fm+ZHR1341jTzq6gP?=
 =?us-ascii?Q?SuPF8CMtw/5ECp9aXEy8ZbhighwOqjI9RiCt/OLFsL76Jf2AvZyYdVe4K9YU?=
 =?us-ascii?Q?VfHBOK1uAFumpd8CvSrHAMN01enmYpZYFyZQU0HZ7RdmcXOFQ6zco6iwMvuP?=
 =?us-ascii?Q?ohf5CATj5EmKDGrpJP9Oacst9eb/QUW1qeCJxHZQEAj0nYs4CREYgomKt+sk?=
 =?us-ascii?Q?RJ4ECtwBrUxIpPolh8YWmwRk14I3sGippxwToI5GcBM4glQxeEIhBtPykups?=
 =?us-ascii?Q?iiC19jllXaVYWox+Ue1A/5Tqg1d04EteiRexgxkOacbqwEwFgaXraX5xzgDc?=
 =?us-ascii?Q?Eb1iJKUYDlo7J46E+T2CywK2o9qQXpluet0KM2CogJElF15X1yyuYBDQ7kei?=
 =?us-ascii?Q?MWmMn6Y/qboSD97yekP/JkaAiNxYsg2K/CtWdVHV53fkDTObFGO+xJ5+x7bC?=
 =?us-ascii?Q?CJDRnTnzhcNdUrYvthR3/accTmgPQxJam/HcT+bc56/Q/Gd7bi5BVnMaFQb/?=
 =?us-ascii?Q?Seib91nzDxC2eK92z3mkjOe2H/BjP2dEXY7dHwVqqMuJdx+I3uP6+ldfJ4dS?=
 =?us-ascii?Q?ArqqVoq+3/V5vbLXo9jIAvRWWnWikTQBPzeS5Xlw1G79oALhbHaZA2Qt5fww?=
 =?us-ascii?Q?GDkl2eTwCoO1suZOlQ2ugOAf0dVKqRzH6tC0wdJKCTRIhzTiny6E69ko+OLK?=
 =?us-ascii?Q?4g9emHYXwxMIpPuwujsksE0OxiJkVIRKWMS2y1WgO5yYAfBIqVIuEdFirlSf?=
 =?us-ascii?Q?KYDdNpj8x8osgXn22INTpDIrwe98v76EqfUmc/Ov8hfchLvjlDURSVib8dmj?=
 =?us-ascii?Q?CMzBUh6Pe1SpvUxgv5cd9QPqxVfOkbj0BFEF0JPKFZhHkKTCSk/aE4OrB8r2?=
 =?us-ascii?Q?dSvOuCULRIkF7oJMNGrfvMc5VphwjgmJn7HOlbfHarjZtz4UOIXUbY+mHmJT?=
 =?us-ascii?Q?vwdix/Fmw/fEuwO9lAkGffHR/NR/JURTBqEASAY5VHEjjQ1fXs5CeW7xsobC?=
 =?us-ascii?Q?u8qjxA5fp9iDJpg7a1/h5bpWiPU++SJoAK/kqYLvbzDwtbnNI2VEzAH10vPX?=
 =?us-ascii?Q?liMpE3P4aXCdxcki7YQsdKk96KU3CMCJS+mlgGDed5Y92Sph6llyjbFvZ8xQ?=
 =?us-ascii?Q?5wLa9ay51cUIdAFpTANEyV2MLskjRS/CbjUSvJnBC6QzzAMJogCqqABoVxmD?=
 =?us-ascii?Q?Lza1/LW1AmZlNZ0gPvrwOM5o14dcKWryzP1ucHnovaeDLZL087+YAsSp6ANd?=
 =?us-ascii?Q?kJqmJcLJCAkPhWipX+upTOYt+FTPBem1HmfG57bFdkCPv6Ti6SF56CBVR1oP?=
 =?us-ascii?Q?hic+iSgAw/HGzwGrsL3qcrma+rrSDMt2jpl4KMSea6vdr9HW5CUEnIvghAC0?=
 =?us-ascii?Q?0CYdlnzt64jZUWkxrkz+tsVPjFBudsdHZSvman4HqI9tqtzzBUkmdImtQUI+?=
 =?us-ascii?Q?1asYsfla5gpIA5UULINLrQkdWWFcPJEkYW3pX+wGpKcPiezG5Hf4yMiQD1xQ?=
 =?us-ascii?Q?jyL5xBfIN/ZUvtwr2UOVQj+pYFBRLT+1WwLubQPGxms4NpfVnqpE7cx9zaJa?=
 =?us-ascii?Q?7Kjy3qA+mg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 163c26ad-f404-43d0-e114-08dea2956e0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2026 06:39:41.2862 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oSR7moU+IhH5kaKis4LLm6yOSmE7dY32dY35pnqK6v3P+NL6kli+3UMcJMK4KFbjkHIYh9p98A3XwZvRyaYoGwu4Eo07/Ld/8X4fWE0JnbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10153
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

Hi John,

Thanks for the patch.

> -----Original Message-----
> From: John Madieu <john.madieu.xa@bp.renesas.com>
> Sent: 25 April 2026 03:29
> Subject: [PATCH] drm: renesas: rz-du: mipi-dsi: drop duplicate platform_s=
et_drvdata() call
>=20
> rzg2l_mipi_dsi_probe() calls platform_set_drvdata() twice with the same
> arguments: once right after devm_drm_bridge_alloc() succeeds and again af=
ter the reset controllers have
> been acquired. The second call is redundant; remove it.
>=20
> No functional change.
>=20
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> ---
>  drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu=
/drm/renesas/rz-
> du/rzg2l_mipi_dsi.c
> index 0b4861824319..b8527661a409 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> @@ -1441,8 +1441,6 @@ static int rzg2l_mipi_dsi_probe(struct platform_dev=
ice *pdev)
>  		return dev_err_probe(dsi->dev, PTR_ERR(dsi->prstc),
>  				     "failed to get prst\n");
>=20
> -	platform_set_drvdata(pdev, dsi);
> -

Keep this one here and drop the earlier one as pm_runtime_resume is the fir=
st user
of drvdata.

Cheers,
Biju

>  	pm_runtime_enable(dsi->dev);
>=20
>  	ret =3D pm_runtime_resume_and_get(dsi->dev);
> --
> 2.25.1

