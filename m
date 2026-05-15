Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DA0CD37AC
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 02:57:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5666C10E3F8;
	Fri, 15 May 2026 02:57:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="silM5UX5";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012017.outbound.protection.outlook.com
 [40.93.195.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 783C110E3F8
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 02:57:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LK0nwnGGZ0C5pCDst16X+7uEsoG7I0EFmrREaOYAmVuRYyZ8bn6o4YNuSQOPkz0Eoz4pr1Y4Cf49vTWs2iYhtmSAAttU1YeHa0t061t3GxEoWZHugfv2CglI/+Ie5FhSu+OO2J11ExihkdIZUwfLWZafl7jjJ6Ql8jOY1Jtym6sxGt0viUQRXEVYRlwd7wNNO+3GEofyPih6A1UYJZBomnSY0C26yqSAV15HCK28oOeTEbdTlT8RvfU6gSot2vr/g3miBRGsxOdin3Os+GMJXd+y88XsesLlacts0FplTBAqsKYkOmASKO8rpMsC/mdvgKnX0m7PLKyeATatAvnqFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PI8oJhxOcGcIYfxl3pkK/JwPnw4dNZMeL4APXJhMGDU=;
 b=nzpzf2TCauTwvQRpTJ9lHc7+R+HRmZv8kqFUjlY+re2aKxJO9Th9tmeISnO4T3bhGaB+wEgEL7BwErK/pp7k2SrIRCq4hUyOtb51x9lJngeZV00omY6VPQAycp8uC8EzeaeprYxk8UaM/QOHVhtogMBL0yZYDZVCPv2sBV6MacFmuGE8OdIoL+omyJwaKsjGtcBllhjKf/BLOzqhdbtKM7bK8XKlI4wmvJQUZuij5EZW0QZ0bO4D2aMsNniGBBxhoVsxT5FzOHTL3aP9uwnwGRQznFu60F0hqsXSq8lbl179JXkbn7BZT+nM0xAmRlwivaDiVwDAB17HcqUcOwylWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PI8oJhxOcGcIYfxl3pkK/JwPnw4dNZMeL4APXJhMGDU=;
 b=silM5UX5MlUgrULL6Qc5xZJGnVm9MBnFCC6RUNzNA8QMqpq4guI0mN02OG+iOQUxCg6RFQFForRPKiJF687oBksx2ygYdjFBd+AkYOZGVxS7RJLKQBy5cwxECODeYCQF5sClHhZSkMSdRXBf2oYcphhQhL8jRSkq+oXdJpdpOFxDUXKfl0kV+Riw12eLNV5TfDkx6Fs+ba6FBYjzXRcn0X9qfn8vD8jjXNlHN/9AKENjVINcFTmw4+vg1njBMiYLe7LHJ9ro6pw4hMmdND2Q8TsIxHUGNzdnjKBqnH7J8GdtEZmkxQ1CFGfYuzZom28eHmra/qXSHT/GMX1BLO08EQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by LV8PR12MB9183.namprd12.prod.outlook.com (2603:10b6:408:193::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Fri, 15 May
 2026 02:56:56 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.21.0025.016; Fri, 15 May 2026
 02:56:56 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>, Ion Agorria <ion@agorria.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drm/tegra: gr2d/gr3d: Initialize address register
 map before HOST1X client is registered
Date: Fri, 15 May 2026 11:56:52 +0900
Message-ID: <Z7wT8y6gQPWQUiz9Yr77Fw@nvidia.com>
In-Reply-To: <20260503163842.213489-2-clamor95@gmail.com>
References: <20260503163842.213489-1-clamor95@gmail.com>
 <20260503163842.213489-2-clamor95@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY4PR01CA0102.jpnprd01.prod.outlook.com
 (2603:1096:405:378::17) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|LV8PR12MB9183:EE_
X-MS-Office365-Filtering-Correlation-Id: f29fac27-37e4-419e-bdd8-08deb22d9fea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|1800799024|366016|4143699003|18002099003|56012099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info: czQt8M27DeRho7Pxf0kHKNPdr2BcKok5P5F18yN2zg4jGj4csdRtTEYIC+ny1Ii5fT1ndPJhvhJ1aq8SOVYQZQdHfzpyu7O9A+I5i/0NX788pQ6MEfkEedHzyWIi2TTIUVtnh3NzjiEyhiqmULp7Ml3ooRhhHqHssY6/PjU9FQdK1eGIU+s1NYnDH2dTSdP9WYnWJFjtsF1JOuWmeG1OYWeILp+uShzp9yTmulQdgcm/BcwAceA3Qp1MNug1CVXvf4iY11rg6cqe3H2hG+9lq818zM1obFSUW+ULcV/Ahx36hiaxjgd3Q2Q0mpJ12EsglQCo3rf7e6Mt3tFKL2oV8+5+B4e5mDQPniTs83p8Rb7oh1KjEbn0eh0sASBLCf1wj6iaOWcmi32/hH4A8oWvRzdGh/m0E2JasYgjq0Ne3iwH6UC7qbuo8KbVnJS0ZNM2Hbu3HHv1D0jggA7/tXjLda0W+qCSP5+KFPFzBVSXJ0cHPNEQyyE7HxmbOwwoEiT366D/XaFFgdpIFWJoE4Lq+3pUNS/VRRaSx/uSDYSlMLMH3l6fG3xmtkGuSmvSIBmTehCs9iG5OYEh6Ejf4scUcs45X+oFNj43os/z/WARtfJB7QRAOXquDHJ+n5GybwRwTF9QONbF0yf/BDDrNens3HdDUKToTnl9olO4dPfXTzT2iHCNPwA/Q0d7g4WIbZTj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(4143699003)(18002099003)(56012099003)(22082099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmJKRWVXVDVEd2dYV0tyNGxxK1h2dDdFeVgvVzJLaG9JcHhObnJTODI1cGlP?=
 =?utf-8?B?RVpGS1NEd0lETk9FU2ZsQTY3ZHZxdTBHM1hDMGJlNXNlQjh6VkQ1VldUTmp0?=
 =?utf-8?B?RFRSN09Ud3dZa2w3aVg5ZXlYSHFOSjdQZjAreFp5TnM2czVwOEgxNzhwbjk3?=
 =?utf-8?B?b1ZMSXVKRHBHbHJvRDNHakJHdkxyT2tWeU1WTDNMbHp6ZzVRbkg3ZkNHdkRn?=
 =?utf-8?B?a0xMY2ZxNHBYWmk2S1VoK2NHeGh6NHdYY0V2eU1MTnVsYkw0YWdjMDFxY01W?=
 =?utf-8?B?TUcrakMrZDRJREF5Y1dMRGFBbG4yOVB0ODdmVE1QTjlrT1NlU0F1SEZTUDZ3?=
 =?utf-8?B?cGFURU1WRFJnT2h5MVNlNExMMmRUYk1FejkxSjRCUkVkeEx1YXVSMHBsQ0l4?=
 =?utf-8?B?MmxYbjZiVEtlMndWdEQxN2dES3RBUWdrTUsxbi9Wa1FvaStLend4ejVIbnFW?=
 =?utf-8?B?Tkt5L0JhaUZuRTJ4ZjdkZHNvR3JCK3JpRzlrNFZOVFBLSUdiZVMxMCtLWVg4?=
 =?utf-8?B?YmtwTmg5cUV0cTBTMnV0UC9FNFBJR2ZpOXNzaFQvYlZqRVM4eklQck91TVJv?=
 =?utf-8?B?MEYvQ0RqY3lnQXFWQThPeERKVyt3cWZkQ09PS2JtMlIwYTg1QmpHUlVvZ2lt?=
 =?utf-8?B?WFd5Q2RsNENWU0NpRjQwcWw1TldmZG1wNVg3S0ZVTVg2WWxUdHNhSUhxNkI5?=
 =?utf-8?B?Y1pKWVJjN21lamJ6RTE5SzFTcjNVM2tNazJMTHFGdjNsZFk4ejZyT2FrdU5Y?=
 =?utf-8?B?aU02dmJBRmlkSHVlMTJpeklLQTdpRnRsNkpqUkswV0F0elpQalBDS1ppTGFX?=
 =?utf-8?B?TWx2WWw3cys0Yityd0dQYjdoMWxiQWFlQ1RtSzV0aHBNaDROQlVYTmgwQ0hp?=
 =?utf-8?B?c0lwMzR0ZktOZzVjQWhHUlBWNHU0TkFzWnc1Z0ErSEF1NFJUbEVrcXN0VGxS?=
 =?utf-8?B?bEk4TXV5U2ZpNDVrRHMwVVlqMU5kMnhXOU1tTnliZXlSdHFmWk9QY3J5TVdw?=
 =?utf-8?B?MGNtS0s1Y2RPRjU2UXY1ZFlBbUMxTW14dzU4VjBhUmhhR2hhZWU5TzFEbTA5?=
 =?utf-8?B?UnhJRU43RktPajJETUhIeVRpL0pJV3hVWGZXekVORVkvcGord3pUVGFjc1lU?=
 =?utf-8?B?blZvMFlvOUJNeDRoMk9OWmZOU3UwZFBncTNiOS9rekI4RlluTXhnVHdSdnV1?=
 =?utf-8?B?WlMvejFISWF3NFh0YTlpTzA5MTFXR01ZczVrQ2F2aXVZaHcwUGdoeGM0RUJM?=
 =?utf-8?B?OGVTa1hZT2tuOTBnaVl5d3FvL3VxWW5xdjlUQk9BU0RRZE9DYnZwdjZPSE02?=
 =?utf-8?B?T2VmMy9KSXE2VTNrY01ldG94ZlZLck1aQ1Fnby9uSnlGeGdIaHQzRm5RMGZ0?=
 =?utf-8?B?ZkZCcUZRbUVrd3IrK1pRN3RucFVVTlRTQVRTblZyL2VRam0rOTYvakpob0dF?=
 =?utf-8?B?MUpGcjQ5NFNzYW96K3RCMHJhU1NWd3JiT0dSTmU0TkRXLzUxdWorbHRDNk5P?=
 =?utf-8?B?UkZ5dTFSd1lOVFlQOFRVb2pxdW9XYVVOTlpyNkJwWDNCbEgxL2xiVFlhK29o?=
 =?utf-8?B?RG8yRFRjOVVJSUt3VSsvblcxaUVJNTJJbjdRZXlEMnozb0lJTExpNzNEODZi?=
 =?utf-8?B?YVNCZk1RdFRzVFVQTkdIZDQvU2F1VS9Pa3NINmloU2RQaG9ldFZwdlcwUmQr?=
 =?utf-8?B?K2REMTNZTDU3K1ZVVkwxMjREdW9zditWSm5hVjQzU29RQ0RIN2Y4SGVaOGR6?=
 =?utf-8?B?OTFzRnBMSi9qUWVrcEl4U2RNTkZMTkRrTUJUTmVOSUNSOWFIVGNlM2hMV0hS?=
 =?utf-8?B?b25DM0h1TUlUdnJ0UE1oU1ltajNGeVY2bnlWNHR6SEM0eXlCRUpMWXlId0pH?=
 =?utf-8?B?V0FyZXVmRXdHMkQ5dm51azVjeXJVUnd6dldkdHZGS2hlVzNLbTBja0JsN3hV?=
 =?utf-8?B?cVJ2dkh5Y2RNL2NOamJWWXlGdkE2dndmVmFiTUZHdTBFWHN4V0hwZDFiZGtZ?=
 =?utf-8?B?ZUtUb2dzb2FXcWF1SDdOanVpdXRNd0pNeXB2dEhkSTE0ZUVRNmhrRUM2RGxM?=
 =?utf-8?B?aGh2Z2ZjTUVReDV0QTMzbGpPc1hvTXdTbk5GRjRNazZkcmwwaGxuQzNIUDlZ?=
 =?utf-8?B?Z0pSMkl2QVZuRDAwWDlIRks0dFVTTVFHcmNKbWc2aHFWT09nM3pVYUpQODlN?=
 =?utf-8?B?d2NmZHFXU3gxckRnZzhGaERCNldlL3R2VE9JaUN4ZVhCSE9peU5zaUNKekZ5?=
 =?utf-8?B?cVp4c05TNURZY29YOFg4L0xTd2k0YWM2S1dDZkJtTXQyK3FsUlQ1NzgvVU8w?=
 =?utf-8?B?d05jTDJJeDFFMUpwdk5YQkNmZWl4RFRGVWNTbFZ1Z2dDVDFVa1VWblpPN2RR?=
 =?utf-8?Q?64ySGdL/MH8y+dAYU+sovWH9VlN3gOkgt0PPC1cTEUECa?=
X-MS-Exchange-AntiSpam-MessageData-1: 5VIrT4n8CdX0zw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f29fac27-37e4-419e-bdd8-08deb22d9fea
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 02:56:56.1198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sBK5gUkF1vFzhHoNKPtbfkh7EsHElQhRmGXkrZn0lhgkxV7zf0CAdaluX1MyxHQ85cV7WqNuYAx99HpTTQBKQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9183
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

On Monday, May 4, 2026 1:38=E2=80=AFAM Svyatoslav Ryhel wrote:
> The host1x_client_register() function is called just prior to register ma=
p
> initialization loop, making the device available to userspace. This may
> result in userspace attempting to submits a job before the register map i=
s
> initialized. Address this by moving register initialization before host1x
> client registration.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/gpu/drm/tegra/gr2d.c | 8 ++++----
>  drivers/gpu/drm/tegra/gr3d.c | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tegra/gr2d.c b/drivers/gpu/drm/tegra/gr2d.c
> index 21f4dd0fa6af..e4148b034af7 100644
> --- a/drivers/gpu/drm/tegra/gr2d.c
> +++ b/drivers/gpu/drm/tegra/gr2d.c
> @@ -276,16 +276,16 @@ static int gr2d_probe(struct platform_device *pdev)
>  	if (err)
>  		return err;
> =20
> +	/* initialize address register map */
> +	for (i =3D 0; i < ARRAY_SIZE(gr2d_addr_regs); i++)
> +		set_bit(gr2d_addr_regs[i], gr2d->addr_regs);
> +
>  	err =3D host1x_client_register(&gr2d->client.base);
>  	if (err < 0) {
>  		dev_err(dev, "failed to register host1x client: %d\n", err);
>  		return err;
>  	}
> =20
> -	/* initialize address register map */
> -	for (i =3D 0; i < ARRAY_SIZE(gr2d_addr_regs); i++)
> -		set_bit(gr2d_addr_regs[i], gr2d->addr_regs);
> -
>  	return 0;
>  }
> =20
> diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra/gr3d.c
> index 42e9656ab80c..47b0c6c56bfd 100644
> --- a/drivers/gpu/drm/tegra/gr3d.c
> +++ b/drivers/gpu/drm/tegra/gr3d.c
> @@ -506,6 +506,10 @@ static int gr3d_probe(struct platform_device *pdev)
>  	if (err)
>  		return err;
> =20
> +	/* initialize address register map */
> +	for (i =3D 0; i < ARRAY_SIZE(gr3d_addr_regs); i++)
> +		set_bit(gr3d_addr_regs[i], gr3d->addr_regs);
> +
>  	err =3D host1x_client_register(&gr3d->client.base);
>  	if (err < 0) {
>  		dev_err(&pdev->dev, "failed to register host1x client: %d\n",
> @@ -513,10 +517,6 @@ static int gr3d_probe(struct platform_device *pdev)
>  		return err;
>  	}
> =20
> -	/* initialize address register map */
> -	for (i =3D 0; i < ARRAY_SIZE(gr3d_addr_regs); i++)
> -		set_bit(gr3d_addr_regs[i], gr3d->addr_regs);
> -
>  	return 0;
>  }
> =20
> --=20
> 2.51.0
>=20
>=20

Acked-by: Mikko Perttunen <mperttunen@nvidia.com>



