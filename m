Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E75D606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 17:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=iCJTJm3K
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6750310FC81;
	Wed, 11 Nov 2026 17:05:37 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazon11010039.outbound.protection.outlook.com [52.101.229.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C49F10FC67
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 17:05:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9xJYart8TsDBmd099ozm5n9mqYOoTiCKxdQ2g35qeyKvsk8DUo3IE7jv3DFBI9VMKN/GS3VDpEzuiIUDY0VsC1ZD7sqnuCBzoAmgxUUS+YOqztI1eAWgW1GeMyvLhfNobShv4PsLqEZZv3TmE/enpDq0sjduu4ZExcSxrIAkwyygP3hw3XrqmAr65Z1Zn6q88LDYcaVf0q1lnZVBn6kO1DIFdNHTOJoLazJWXOo/Ivt86GZN5vK92kb7jDQuhiwIfmz3TG8smmELIFmUmwkZLCVfSkwKl+yCKDYythh6XDoNQbwJyNZCn1g6Mmvdz4oBNMFxiq+RNCzlOP/6a/R7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7H20tjvXNBe4siCZGdnGFCcxctRcWBrpzAUWZVw3WlE=;
 b=iOo33EjapdFCYBKYtmXC3kmmfvQWRqNi18ZXsrSKU40zts9w6Q35whOZovDEv6YKO7CVzM/0XtlEmvl6hnrFnf/PaMIzgvSULpwlcHIlloMrHBXagm4ZWirj48Y8xtk3rhBNLxXerFlkX4SLFqjK1iTBJ7GILsC1ONVVRdZ+dOwJN2XNbsSc69A95Ul9bGGvy+su6ffIbCbe+RLZ4kXTCF+NE3Sv2/lhs4DphcJGVAzedS8oQ02WcRlZocKl5TVvl2OqpxouRkGox6a5qz0bCtCeN3GEpOzC9xpvOKFYwK1D/ZUMAZgrRTtTunoG4YqnHqEk3sognu5/UgdcHRhFyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7H20tjvXNBe4siCZGdnGFCcxctRcWBrpzAUWZVw3WlE=;
 b=iCJTJm3KdTfsQz8BZkQB1rDdyzsaEZApih4YFL+4QHmOnq4Bx9QVxkBeo7m/2+n60Sr3naTiXTguQZfjJUny6E2MSHr7a7zCh+1VH+tI7BfPjlcmeI/urj/2qrKAFkdxF4Jz6Atmso2d6M1hcE8rf50vPiQTPUK0h6CxXNHaP/8=
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com (2603:1096:400:e0::9)
 by TY7PR01MB14325.jpnprd01.prod.outlook.com (2603:1096:405:244::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 17:05:27 +0000
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f]) by TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f%5]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 17:05:27 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Prabhakar <prabhakar.csengg@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prabhakar
 <prabhakar.csengg+renesas@gmail.com>, Fabrizio Castro
 <fabrizio.castro.jz@renesas.com>, Prabhakar Mahadev Lad
 <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v4] drm: renesas: rzg2l_mipi_dsi: Remove redundant driver
 data assignment
Thread-Topic: [PATCH v4] drm: renesas: rzg2l_mipi_dsi: Remove redundant driver
 data assignment
Thread-Index: AQHdcdBrFezFhKtrAk+SFSHFEH4RkbcpGdVg
Date: Wed, 11 Nov 2026 17:05:27 +0000
Message-ID: <TYYPR01MB6603C08C1A6C4753A184CFA986712@TYYPR01MB6603.jpnprd01.prod.outlook.com>
References: <20261111113259.3334619-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20261111113259.3334619-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6603:EE_|TY7PR01MB14325:EE_
x-ms-office365-filtering-correlation-id: 63135db0-bae5-4444-4aa6-08df4015fbd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|376014|18002099003|22082099003|10067099003|11063799006|261022105027099003|261021123027099003|56012099006|261022075727099003|261026140227099003|261009223027099003|38070700021|261028144727099003;
x-microsoft-antispam-message-info: ypdVkI4yyiSaw/XE4oSuLJgJAw0j7cN90cKYY2gvsXMUtZzgVcUAAjV37dFxO4E5Iu/AwZEoKIUf02LHLDs/aoDxHaG0LTjBttMFcw5Tb0phTQ1enwQTkLIeoRGwPKr1u4U8l5d7IJcSNg38NzRSlfRnNlJ1Cpy8sRYPHpY2s21BOw0VnjoNT64H+KyfU+6tMLGwIkNSNNyJ7fKimdQkxkXAAx48cMtusE6JvDMUkVL6xAJqorPmMdZapdPoXl1sZy9UGJML8is3AXAIm044k3iUm5+6XeNoXd5JTN+GxhjmS2YHq4pV+qbGGkGjVoeRHs8TzIQtvQRhvdhryso9Mwk4rO0zIi05Xjt8/OAKIl6RAMJVdMnvXfQZg+EnJ0rhtxpW7lCK8QrwHrHh0RHbk7pHc0VWWuikb2V+4QDXeCT0/h9w9zKsx8hcb379Ka4kodbhBTCdoCyCGe4wmSI/qyWw4+f8wQtSrrM6a8MiaSVhyrBIBoEy/6veXH9TshoyjbTzjQiRDKbau1ERWJAGYyYU8jJf9NUbYZZ8JzuYKySQgLKhYQBf2AfXWry/CI0cRN3PZQAU6Tzep5ojnbcE3s+uGrCJZdcmFUwKJ3gSfEs7VUxy86SNFNEXULd7TQAjpeWZOpcctS8/eB9nExLOI9j46Ks398JCAKcppKzwV5Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYYPR01MB6603.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(18002099003)(22082099003)(10067099003)(11063799006)(261022105027099003)(261021123027099003)(56012099006)(261022075727099003)(261026140227099003)(261009223027099003)(38070700021)(261028144727099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6OWCfHXqsyU32jJwEANGD5YNqh/y6g1rvfN5o827SXz9M75lPWP+7auVsxHb?=
 =?us-ascii?Q?cL7Gn00pkcGE4gTi5HYhmx8Io3Tc+BK8qde9ZYdILByeqXBhGgfjTrKQqxCL?=
 =?us-ascii?Q?2MzBMmEBNZdNvhMxPVDdlF9TPK34WF983V1JTyTW0DVSu0Nqw3QGw6kMuv7b?=
 =?us-ascii?Q?7M9wHh6z9EeaVhU803Lz+uPkC3k+MMYHUZWdPME7cRzA7AQfdIDjGi8GPW71?=
 =?us-ascii?Q?tKIjZxnjy8caB+mAAKji/TAD0nTABVBb0mzFJUQHaithIomSPA82HSw1ozKr?=
 =?us-ascii?Q?j1otH89zRIrMGvsWFkrBAXFnLJzMsd3YAL0uPwnC2oBeDGzOCbABfAlR8Zgw?=
 =?us-ascii?Q?5BiXveJpHMoebD57b9H5df0P8p4Tod0LEp16nijBz+0S3IV935cD/bq0Ny5J?=
 =?us-ascii?Q?A5ZO58dcFLXRSrUlJ5AFJjFjbcKmYEeAGd0sp8r/+iGavDqmI+ft81MXU2Zs?=
 =?us-ascii?Q?sW+NIj+hRH71CWSqh+luTxZqSQ6AQu5HnsQrttTJmHkEbriZyJtjBYvGIy0k?=
 =?us-ascii?Q?fEIaR2Xb/pC+ghfGR4/K/9lm8Q7dHoM6tGINbf03sHXv2ynlyD5YhH/uOvKY?=
 =?us-ascii?Q?CZB1y6zWjUxI9Qn+MPjjI9O42KiS04bnR0qSjVc2u6abVN/UNbpW0Py6ij6M?=
 =?us-ascii?Q?KtbevRz19JwoglXr+sB1HFItZ1pOyPIyAoQXr/INzuuDrdimUIZJbXSfwePr?=
 =?us-ascii?Q?dJOiOilRCdxdb0jeQxSn0AkSb2CwdyfEuI3bqsTv0dmMAxkAa8n3IsggO8nA?=
 =?us-ascii?Q?3bJfnxJxta4p6rFgcPZ4QB9oYSZJHwvm+/FK+xq7kaQIr++1xP498LfcQRWA?=
 =?us-ascii?Q?leWFzxoTGif4qc5HCRmsR/5fAQBn1zRJo4ayN8oqjKQhhkU67VYSXCHXsk4w?=
 =?us-ascii?Q?qFQ9LlYK3oMVChUCQkbrYBnz0p0WlFtNc8KCgU3Y4CQI5B84rJOHO3Pm9Twi?=
 =?us-ascii?Q?cLj4FDCM2RcdclBripy6hiHlyRcxV/eWEgUhlD+/kI1brBaR2hcKP6R/XcrH?=
 =?us-ascii?Q?qM4gTY/x7l7W3EmrzG1tgMAaND4gUW95iEsETcsU4EyY80rE/+e5b21jn7mp?=
 =?us-ascii?Q?BcHdHhsv/GTxzdy1cFdkra0CpvxCqiUXqxtPyIABHsmtpMjrQrN49W2Iufgk?=
 =?us-ascii?Q?idBzW9qsT+oWo23c5Z93gDbDyjFXJbcCXyk2BQE8xLzua7mJ1KZT2klVu9FQ?=
 =?us-ascii?Q?Gi85gX5giyue/FuIsh/D1PVQz/NlPyVrs8a08XhqStnH5VM52qNIhjq+DK84?=
 =?us-ascii?Q?PAm0JmQ5ad5WprYJejJxt9d9rk5VGM1HjJcr/JukTrmbCm6kULT0I+NVey9j?=
 =?us-ascii?Q?yMOFmraSCsuwIfIM7KpFYuneQxTb6018XWVubBRHTGYjCmTWIgQ3lf98qQoP?=
 =?us-ascii?Q?oNS8wzgRP+mp2fExHwrNzwqezBaBMgzxCO3f5XvP9S/3bGbsNgwiziYVVmH/?=
 =?us-ascii?Q?XQvJw3Pb73lQLWskKbFClO7ZXXKbxu+NIsGVLbe2LR/k0sBjyxUGnPA3EOIz?=
 =?us-ascii?Q?l15KDcRR9NCfccdVU3/kBzzZfJrIAly4Llp+HbYWIzy391Fjk2URhailQ6Ak?=
 =?us-ascii?Q?hML2ctlSZxsMPOEonHPsDbARNVUFQyHc2tdKkt+OYnSvJhICBMTqBW922j/Q?=
 =?us-ascii?Q?rIow2eqSK3ShUPbDPZVz0gr7fl/TQpLJCg4CzfUFqel+mn3l8D91VCxEuL0s?=
 =?us-ascii?Q?gITPYpOyXlk0G2yE/WzjlWkB+1sK8GuhGicncBWy4QLqJvRjWw23QjqCZ0OT?=
 =?us-ascii?Q?bc4DiamKgA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6603.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63135db0-bae5-4444-4aa6-08df4015fbd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 17:05:27.2583 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A28e3MES9AbtCFe2miYG3QLRXxduGFi2YO6tEvHnG4/UzBw3QkXETZbHlXt2P8/kejD9vslg4RYXIwxz6jIOtG44vqXj4XeqjxoQyEwmpmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14325
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

Hi Prabhakar,

> -----Original Message-----
> From: Prabhakar <prabhakar.csengg@gmail.com>
> Sent: 11 November 2026 11:33
> Subject: [PATCH v4] drm: renesas: rzg2l_mipi_dsi: Remove redundant driver=
 data assignment
>=20
> From: John Madieu <john.madieu.xa@bp.renesas.com>
>=20
> rzg2l_mipi_dsi_probe() calls platform_set_drvdata() twice with the same
> arguments: once immediately after devm_drm_bridge_alloc() succeeds and ag=
ain after the DCS buffer has
> been allocated.
>=20
> Drop the first call and keep the second one, as it is closer to where the=
 platform data is actually
> used.
>=20
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Cheers,
Biju

> ---
> v3->v4:
>  - Updated commit message
>  - Dropped the first driver data assignment in rzg2l_mipi_dsi_probe()
>  v3: https://lore.kernel.org/all/20261110114622.229608-1-prabhakar.mahade=
v-lad.rj@bp.renesas.com/
>  v2: https://lore.kernel.org/all/20260501080818.955914-1-john.madieu.xa@b=
p.renesas.com/
>  v1: https://lore.kernel.org/all/20260425022857.2382603-1-john.madieu.xa@=
bp.renesas.com/
>  ---
>  drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu=
/drm/renesas/rz-
> du/rzg2l_mipi_dsi.c
> index 5b257f5adf06..65f26f889a67 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> @@ -1532,7 +1532,6 @@ static int rzg2l_mipi_dsi_probe(struct platform_dev=
ice *pdev)
>  	if (IS_ERR(dsi))
>  		return PTR_ERR(dsi);
>=20
> -	platform_set_drvdata(pdev, dsi);
>  	dsi->dev =3D &pdev->dev;
>=20
>  	dsi->info =3D of_device_get_match_data(&pdev->dev);
> --
> 2.56.1

