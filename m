Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C35FE5214
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 12:10:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E80110E3CF;
	Fri, 24 Apr 2026 12:10:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="QshOk4O7";
	dkim-atps=neutral
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazon11011067.outbound.protection.outlook.com [40.107.74.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68F4D10E3CF
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 12:10:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MdYT7AWeqd/3qWt40BUChYA39BEKdmDZirb1Pd0PSgSvMWaRVso5XrqaRGxcp7fm858pv6H+eOKSMIrCoZF+u1MAtlE+826HVN1wPEQSue53oxTNQIfi8IX7fN+Ltkr9V+9FO7v7xC0z6sRWcEk/Rp6QhPSzbPvzu58HValnNfquVwMU7ZRt+IToyTybCf67AjBEkZWlPUdkkrYmoxwsdJLbgUQQ8Wh1hIkEa0u1VuuWP+KCWpwhTaXEQeKxEq+gifC//pdWPK6/ylHqa5xbUaS8xd8zDWBNdm0lM7XqfQ/k9/Hp91owWwl7qL5a3A2VOgedPsOF/SBjtPkX/7R7vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aunVaAz7iNFwqfkpdmd19PdQHB8K/CYzdRBhT3gbdO0=;
 b=bHygvpo0gl6J/doaRFFKW2HrgOYV3PLMM3CD5hVPG9tOn1RJ0VMecY8bVhSocP3PxiUtxGxGH+IoUfeoY6Or7+VhMAS6p4glWI40CoabmQUVy5weg6YxZcmHJTb57tdGU9JbeYofAD5a2InMchmGynp6wRTzQdBhWTVJDmQrZKICPFi3FVC6EhsymnfGi3CWkiuCeuTt3JqyrzwOnB3V1XEsjNmGi37oF8JEHP/YQzMGkrwVAk1Ty368ofVj3wWsvoprYk6OiZjXwMtRdrh0afFoclN2hou4x/zfU2u29wxdN2Pk0sEvp7UZjaZQx8mJaZ/cUY79JTOYFALWD5OOVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aunVaAz7iNFwqfkpdmd19PdQHB8K/CYzdRBhT3gbdO0=;
 b=QshOk4O7C7Ucb+CnbN5r+ILo5+tABjWyPG4ptZspVBb3jvPbv7jR3rcH2awkixf/W29VmqsXtteivWsZthvaK7FJv9r5dcxRxaDCuOGW49frNhBaNxEQdyEuqCAFYRHnqDbiYuA9YBtWSi/580HDQyhJ1RMOdtEuYndacn55W3s=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY4PR01MB12956.jpnprd01.prod.outlook.com (2603:1096:405:1e6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 12:10:17 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 12:10:17 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Chris Brandt <Chris.Brandt@renesas.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Pavel Machek <pavel@nabladev.com>, Hugo
 Villeneuve <hugo@hugovil.com>
CC: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Chris
 Brandt <Chris.Brandt@renesas.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: RE: [PATCH v2] drm: renesas: rz-du: mipi_dsi: Fix return path on error
Thread-Topic: [PATCH v2] drm: renesas: rz-du: mipi_dsi: Fix return path on
 error
Thread-Index: AQHc0meinmXgOg3bwE20e+5HFeyfnrXuIZTA
Date: Fri, 24 Apr 2026 12:10:17 +0000
Message-ID: <TY3PR01MB113464115454EB533EE670E81862B2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260422145146.1638998-1-chris.brandt@renesas.com>
In-Reply-To: <20260422145146.1638998-1-chris.brandt@renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY4PR01MB12956:EE_
x-ms-office365-filtering-correlation-id: b5e4df28-5ff2-496d-6070-08dea1fa72ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: hvBiRI4fICBpqJIC9LEeUJJF4DBfYkuOfKt6QNxZqDm8Dq/0vP/EkXUi69+aAsfmlhLKyiFwFgAFZlgnmnCRh7ZQpH+qNhYjTVEl8XX4/zSqQRDVxMxX39lxmn1hGo4cPTKpPt9YKqQQkxvMSa73YjMOA8SbM4x1adtfCz/Mnuw+eMEqiUHnbm/0oROYFnMnha3Lg0nHeWfIYBJrB4JaTgOAgLEFTqjr8HKxQHOEQfSwu1rmd9G64u5P+xbsj+sWBnw37a43cyH63IWMNF589a3+1mU7UUQYP7N0kaf+I9DYjcZrMImCv4vWGogL2HP52QzrYdSN6t4FH1viOZCbeVMiGkn4p2HIzMAMFiJvq30ImE7+MooaHy2Vr3UxhhxMWAOJhUHa50A1dl5Gpa8jElV0OkSwk0Ot3/oJzl7l6wYbqBfCIdvMV7Ai8jUktjYOVv2vgMSnz9+skJxjmym0rcU375IQAk74S2YNujEI/NaShxT8gLL5ZS4KqTMH+iXV+1xQpNPX5kpuAQTcCmXn2dVZGHxnJ90KZbwgEq1oml8yhAhHFNF6HuWCwNlFHV4j58NGbwjJGDEHS+1TP+KcKR0SVglBCWoFIK1QeVgPdPxJpHnFDTBk3HprGscNhUE1/SlsIhE8sfb+kMH1nCOvYuslv8a9EI2jcsERTjXG0staR7+KBNlao7UUCQT6XZae6iFAGBmQcGCPws+8YsrNSdGz7UG93MUkI1vBL4uaiM3vmZBP41JKhsvnX3hLsDxVaXoULq9QjVQJitBeFWITM8SuA+DqkAS1ttOFNBzkJpw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wbBW2QDtuDu8B1eTSqYOPPhTk2P7vWCFly1BvzE+NBNkyGFaBIhiwkuxTd+N?=
 =?us-ascii?Q?W+0tpzZv7iTChlVRpdP6JrDxQp7UxsGVcAjzGcHjyKoV1n5QVatVewRegNF8?=
 =?us-ascii?Q?rqT6BwUEdbSuR94Z3my5TIYoHX28fgL3Jxha2tGDqQlmmEV0v0C5jinl19nO?=
 =?us-ascii?Q?h6kyFJvknOyB6Uwdtx9MMLUlbY66QcLpqF18CCbcu/tlsXiwSYTUm3V1WnPr?=
 =?us-ascii?Q?YT6lCvR8O4tzOwhwYxvBoINVlVZrJ/YYk2xdmOUgbX5MgwQO6NhlOJZ9P6JV?=
 =?us-ascii?Q?2anR6gw+QHPe1a7rzJeSczLAZqbdUIQcnhPhkoTjav0d1RXE2hDy5sCPTMgW?=
 =?us-ascii?Q?gwb6jZ+4y0mBj1nYYoVNkXHKA4e9nUJHvjjEAuZTTtJ4Flq5CMUFwNuv1lyO?=
 =?us-ascii?Q?qRDrPmD0wkV5qEMGgbAHVrc0LRyauZBdg1hqJru63l6+hdoRfIX6cObvRgEz?=
 =?us-ascii?Q?gHIj/X4zIOLTHOAgyJrfvj/RaKm7DiPguFSUvP2rY0mTTTGawDjEMMYAHUto?=
 =?us-ascii?Q?Ca/SS54jxfn4/5D6wCpOQBLhtk02K6nCsRgyMWGYCAo8w6jonltsnSYZSSBS?=
 =?us-ascii?Q?KIPWDnMSor9Mij2t7irL6YfPsOspTsGHJjEGNgsBVL54SyBuHhtWy4NfXwlg?=
 =?us-ascii?Q?OLC0PTTjgCBz4LuI1TztCav8ioMvtrc7EzWo+HmEUGEtnBOipAGwAu5HBFQo?=
 =?us-ascii?Q?y+0W9M5OKhY9smdHGpHnx/6JCQjFwpCuNG4FMBmtd01VF3bm/6QhtGugOwH4?=
 =?us-ascii?Q?6u2ExHxgx7ZvHvQ8d+JGfJFlydEGVD9u8qPayMFUPwYV7k8iGXbrYlj+7634?=
 =?us-ascii?Q?v7UTkPUfQ7PGs+A7jBEng0ItIWANINkJjGvwhyhTKwIwUhG0wwxRw/P3Q43w?=
 =?us-ascii?Q?2BqthMLofRnWQATcsX3ACUKXjkezQcEpsl0bs0+FzZss8tAiFC3czHrL67dn?=
 =?us-ascii?Q?tU6ky1hSQuhgniZ20+iztCzJW+JdWgXmg8vUWGi/s980BpEqYWMjrwRy02DJ?=
 =?us-ascii?Q?TQe4kJFhyhi6MpG/QLqNyaDz+bdJSGrL+UVF0rAvLelnjkI7xFxQDfyyuJVn?=
 =?us-ascii?Q?nYHMn/3zjveA33jqIYrENAxZlj1CrGgcGfvSDhRKRF513PVl0bTxc2CWHtMo?=
 =?us-ascii?Q?UXunVma3Ka+CpGVgz1ntl3vMcnwFhyRYaUHGjenUqky4ieEioLPWxijjU1vr?=
 =?us-ascii?Q?SC9/NvT1YqSj6HjAUydgoSVGSYkphshgAGRqZ+rk0+drHSKtqdyAxih+DsfU?=
 =?us-ascii?Q?uOtEJuSSnnuhEKy6BtjnZix0vJ55x3EOBnn+p3poV7VrW0SMr3KYxR4HGyJN?=
 =?us-ascii?Q?sf/8Ysg+HjEMaq/ahlhGuSaenSWPx6KR0cDoNayk2ou1QU+RamHzzMPoq+SO?=
 =?us-ascii?Q?LhBhvn/0EiuLcu2d5qs1GhsoUTozxTw5VqrRNVIomWHd4dHloubUv2MtxYBG?=
 =?us-ascii?Q?5SHZEjqxS90cawOpXI9YERYuDxKW9ibjUYQ/zjEpb7D9aY4q5NncgEy3iYku?=
 =?us-ascii?Q?WnLxcrH3kviwT0q4iqWHL6lat/7F5et4b52VgNDXAsajuUcQ6GZEDbO13NP3?=
 =?us-ascii?Q?GnVk/6HunjR8Lo1qfh2YywpsFl1PCuQm+diq/48nWBEcTxOIougKE9Juwxxu?=
 =?us-ascii?Q?v2t9OgIrg5qC19T1VTPOnsYavBvc1KOsPNIW7y12MYYBNkUB0he7vqXjzo5y?=
 =?us-ascii?Q?azqN0xrXHXPzl8UK+S6NmJvBl5F404gVhuevfHVJa+1L8Ws35o5XN0vsEfuQ?=
 =?us-ascii?Q?Mnied2EuZw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e4df28-5ff2-496d-6070-08dea1fa72ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 12:10:17.1096 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N1K4uxwCQF0kJkJAmrclgdrnz2Ulq/iO1mpjW1E5bpV5Qs1nNNgA29ZcRh4QxkEdPb4pPUQsgKIJJXXbNSd0b+OHKBTCwuAlQty98TAwU9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12956
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

Hi Chris,

Thanks for the patch.

> -----Original Message-----
> From: Chris Brandt <chris.brandt@renesas.com>
> Sent: 22 April 2026 15:52
> Subject: [PATCH v2] drm: renesas: rz-du: mipi_dsi: Fix return path on err=
or
>=20
> In case of error, we should unwind correctly.
> Switching to using dmam_ instead of dma_ and moving the code earlier fixe=
s the issue.
>=20
> Fixes: 6f392f371650 ("drm: renesas: rz-du: Implement MIPI DSI host transf=
ers")
> Suggested-by: Pavel Machek <pavel@nabladev.com>
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> Acked-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Cheers,
Biju

>=20
> ---
> V1->V2:
>  - Need to take into account mipi_dsi_host_register was already called (G=
eert)
>  - Switch to using dmam_alloc_coherent to automate unwinding (Chris)
>  - Added Acked-by (Hugo)
> ---
>  drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu=
/drm/renesas/rz-
> du/rzg2l_mipi_dsi.c
> index 29f2b7d24fe5..b908e702b607 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> @@ -1442,6 +1442,11 @@ static int rzg2l_mipi_dsi_probe(struct platform_de=
vice *pdev)
>  		return dev_err_probe(dsi->dev, PTR_ERR(dsi->prstc),
>  				     "failed to get prst\n");
>=20
> +	dsi->dcs_buf_virt =3D dmam_alloc_coherent(dsi->dev, RZG2L_DCS_BUF_SIZE,
> +						&dsi->dcs_buf_phys, GFP_KERNEL);
> +	if (!dsi->dcs_buf_virt)
> +		return -ENOMEM;
> +
>  	platform_set_drvdata(pdev, dsi);
>=20
>  	pm_runtime_enable(dsi->dev);
> @@ -1474,11 +1479,6 @@ static int rzg2l_mipi_dsi_probe(struct platform_de=
vice *pdev)
>  	if (ret < 0)
>  		goto err_pm_disable;
>=20
> -	dsi->dcs_buf_virt =3D dma_alloc_coherent(dsi->host.dev, RZG2L_DCS_BUF_S=
IZE,
> -					       &dsi->dcs_buf_phys, GFP_KERNEL);
> -	if (!dsi->dcs_buf_virt)
> -		return -ENOMEM;
> -
>  	return 0;
>=20
>  err_phy:
> @@ -1493,8 +1493,6 @@ static void rzg2l_mipi_dsi_remove(struct platform_d=
evice *pdev)  {
>  	struct rzg2l_mipi_dsi *dsi =3D platform_get_drvdata(pdev);
>=20
> -	dma_free_coherent(dsi->host.dev, RZG2L_DCS_BUF_SIZE, dsi->dcs_buf_virt,
> -			  dsi->dcs_buf_phys);
>  	mipi_dsi_host_unregister(&dsi->host);
>  	pm_runtime_disable(&pdev->dev);
>  }
> --
> 2.52.0

