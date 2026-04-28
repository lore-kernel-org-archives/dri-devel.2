Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1CBCFF8864
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 01:53:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4391B10E9E7;
	Tue, 28 Apr 2026 01:53:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="mY3iPPFF";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013030.outbound.protection.outlook.com
 [40.93.196.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66CF410E9E7
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 01:53:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TuM4G/uLhKXGplKnriqn/zlcv0RA2tQAjeJn7EmVeirZt9SBoygttGvbw2bETS+3kix4/TFl+EBqlDAJKcbXM4384XP7T8aEPNB6btF2/CLgFPJva0thrHg5BHBdR33FqpbgK75Hgh0Q6LK5yxz8wRR5U8FgChwcOgDwgEJHqsHMPh6Au6AxeOY+kblVBBd5loI88gSXuGS+e7qCBQBJCmBqNzzLfz41WA1vh25sTu8bmp6yHOHMIMF+bx2mLYS0NhRmhySX3/g5+UNtWh8BSsWSVPXiQIHZxK2frdWNAS6TlN5Oh7S+6VCws7Ebij9lTSDObX8eLy1V9e7+RbqnfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgkZoFqiDNjFDSj2UNcIfDRN2J8Tuu7UePEifsUNWvY=;
 b=bkKA8MITW4enM8S2YUna+M6DqcKlCVo9tZi3TeEQW+zQjJJZ1FGpOyNEcsBBZp7e5U5LQ825HQiOsDJweO/PpoNDKakbrZ1m3U5p++kKDBZMx+kj85H4QOSyZJK3m6SaJcqFYExxH1oEKGAdjXL6iFsecLE4ZWoTre3aUD7MZJCU/oGGGq5/2l6oRAz2h9gN2ZiMxB3NRBrwAa08UFFZ66jDRDfBfc10lOUBwuUpV6WIw2oA0q16m8QFTLYjYp/xCfS9vqKOq4mhho57/c4YeG5LyZbM++axPhyb8ja/JNJXC9xdrEFF02GAK80eGAdEMWgNkJWRdjasxlqzl8yvyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgkZoFqiDNjFDSj2UNcIfDRN2J8Tuu7UePEifsUNWvY=;
 b=mY3iPPFFtj2hpoENtG+Wtjjg8xGBUkyzczLE8iNAxlmnRGHwLUYG/swFsYOa3kg8Gl8WBEGiQ//pM0cr4sP2JMuZ3DsJGrDnGk3ZpEx0ayz8qbAMcXaWeP9TgKwAybLxBz/QUvFVF2uBg3pdPl3RgiXPA5GRBM6ZEb/NQc4HNtY1fgLygJd/NmiWfIXtdJTYJRkmbUNfidj2c2bayzDJUOsKZy4R1gdHh51liE1xNOvI3iJ+AYz2cshWg6wMknG4zRNrPcWOehH0UM5IAgGs7BOrIkzmCjrSDnPcVKb0VN1Yw4VdtxaEV5KZIdJQuo7VRF/UYFtWmL64TWOcPKZbtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by IA0PR12MB8975.namprd12.prod.outlook.com (2603:10b6:208:48f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Tue, 28 Apr
 2026 01:52:58 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 01:52:56 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>, Ion Agorria <ion@agorria.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] drm/tegra: gr2d/gr3d: Move pm_runtime_enable to
 gr*d_probe
Date: Tue, 28 Apr 2026 10:52:48 +0900
Message-ID: <gUUml1BmSZiZjQ7gY5A_cg@nvidia.com>
In-Reply-To: <20260427075856.85208-2-clamor95@gmail.com>
References: <20260427075856.85208-1-clamor95@gmail.com>
 <20260427075856.85208-2-clamor95@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: OSTP286CA0113.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:225::9) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|IA0PR12MB8975:EE_
X-MS-Office365-Filtering-Correlation-Id: c5d05e4a-5752-47e2-25b6-08dea4c8de6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: LlQxTwOycVbuzsiJvpPj6gZd0pgJmdjNzBdE5vFG3VF7XSCVuI/VQpf4rTH2A6O5yAm2AxNVVnkgHVVpcKBYPmOD+cko2oWRE7jGaB2VgfepSx5XL0RpT4XFQKRkU1YN9G8OWyZ60OFN4Koj8L5WZQXT10rtpo0qO4zfZkFH+Mn35FqkvXhX7i+1Nj0EpEyTVhENPBKcDzsNcJ57SDxAgOt9zXbszIUQmXPKNr8r0L17xqw06LXSHhL/QxmuLvwrYEn5CtNMyFTAv3/IAQIH+y0hCog2V3xuO5/hk83jx4m3ljcuQyQ0dX6nPHgKP9fLbefKLWfixE1a4c6aldhs+6sXQwOulCpjvUAwL0nkD62zaLA94M/gY867X6p/pwsrvWObtVZ6kIrSPUWoXLAdIa1blqOsfESqdJ7gr/pZBLArbz8w4C8/Y0xglWjPgpMy+Cv+9dJpzKQJ4Cp/Yu0wUGAWefVAgMfwXCHXdZRgzLrBJ3i8bpf5+z8VE53cQX4Yqv71kr9eNSUWlA0lqmDDf88ri8nyKnSqGOTd7B86JSvZgClszLiDmJAGK5nvUdjYbSAu/0Cvd9ygbV7I1CA787fiQ0l1VmT1PDrBGOq5E4OhC+gvAlMS+SP3JpGckIW4JjKP7axjdL1g5uCDurrgnjYdT+aQm6o7D5nQ8rsDFILenhHZ85xLGUqDdE1k2vBLVKkP9UgPLB7p9wbt+AMPFq0cpHA9S73a5YkEXOTPVKc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlNTTmo0cndDUjFxaG1KVlI1UnQ4ZTExOFVZRWdkZGE5czhMbmJjYmhyeGtN?=
 =?utf-8?B?MFBwWm05a1NJdXk0L3VyZVE2Q25zeVJlUjFnODZHSU9pdDhLS05oVGc0TTRr?=
 =?utf-8?B?bmViVWtDbTN6eFQ1cVEwMkxGNUZ5UnNNUzFUUUZObitzcmRmZHpTdzQ3ZTYr?=
 =?utf-8?B?eHI1RDgrWE4zSUpwejh3blA2ODE4QlIvaXFwcDFXcmZiU3R3bEdXSmt6ZFdz?=
 =?utf-8?B?TXY1amY4M0JKVnFlcURjREFzUmZ3YjlaRlRFdGtkUVE4c3pxRndCc0lqWGJZ?=
 =?utf-8?B?V21wZHFmdW04YWJ5Zmx4YkpCMHVLMlpDekxPU1hHZUxQUGJsd1AxQmczRmY3?=
 =?utf-8?B?T3lOUW1ZVEUvN2xHNkpSQnZkNFQxSHo5WGdpMjlTd2Y0L0hXTm1ERmJLaC9U?=
 =?utf-8?B?U1IySXFraThGVnpiMmFZdDZabmFyaHFLNjVuUkM0amg1QlJjc3FQaitMTWNx?=
 =?utf-8?B?aGxxU2JYUzNwWTRFUnV4aUdqZGVzb2F0QWJXejdWeG9SZjJ0Q2M0MTdGeXpG?=
 =?utf-8?B?UjJLMUc3ZGd2dVl0NDIzUmdYVCtiZ2VuYkI5bVoyUTBaVkYrVm8vWlU4cHpm?=
 =?utf-8?B?eDZzblo3VS9OckF2MlpTVEJhVUdkdzhCNzJ5azlCOHA4R1pXWjdNdFNzSkFN?=
 =?utf-8?B?aHpNZVZBRGU2T3dHdGNLUUZtaG5xVE1sUVNIMkZnY1JIa003QVgwT1FtRzBz?=
 =?utf-8?B?SWtleDJhTGdpU1JYRHN4c0dQQVQ5QlF5UzN6UVVLeVdHTXkxakRWcENYVlVw?=
 =?utf-8?B?Y0ZNb0I4VEhwSnpBK00zK1Z3ZW05ZSs2dHlZQTJ1U2QzdVFVdHc1ZFlKZnlk?=
 =?utf-8?B?SU9LZDRqK2ZqQksrVWZuWk5FTEtmeUU0TEhDSWlHQWxpQ3dmT3ZWOHhsaHFG?=
 =?utf-8?B?KzRFbklSNURUSnRLUHNGeHZlTndLbEVXYXYzTWZseE1IYUJqQkRUM3VYZzdv?=
 =?utf-8?B?dVUxL0JSWVA2SFdzNnMrSWM5RWZMckZYUkpWOUtVRVFXVmp4amtPVnpwUytw?=
 =?utf-8?B?cHJrdFF5Y1NSRmx1MzJ0R0k1TEtNWkkvYWRtRVBGeHppMWM2SjBGd1Q4QW9C?=
 =?utf-8?B?aHJFcjJwbU0wdlNTdHRrNlYxSys4NXNRVE9WbnhkNFovZHZCaUM2N0hVVEV6?=
 =?utf-8?B?M01tNDZHSjRSUzVadDdFNWhNMGNYQy9rTEh5dXdlNTltbmRmZ3IzMkZDT1RB?=
 =?utf-8?B?ajNabittcEZkaktDUEVwcC9kVlFtdXhSMmN5NHgyemtidXJHZEVUcUgrODJ4?=
 =?utf-8?B?cHUrbGJPNk5oSGFpT0JmUVZ0WlAvSjg2bHNzc29wdk9XVmkyZXk0Y0xsQ3V5?=
 =?utf-8?B?bW5DUDNDTVVHOGVkTDZrTjhYa1dsZ0krd0JQR05sZHo0Y1pRaDM3YmI4UWxG?=
 =?utf-8?B?ajNTZEpqcUhSUjRJa0laQnh4VlRkRnFhRnpUcHVBM2FIeHpvNjhXdldJNSt4?=
 =?utf-8?B?RUwrdDNpcE44bHVSZ1g3eTV2L2VtemE4d3ZVV3p0bmRROHBQVlJOTy8yVWNM?=
 =?utf-8?B?amsrNnQxdmhDdjNoVzh3ck9Sbk5GOWxycWtJd2p2ZnRnZmxBWEhFMS95YjVu?=
 =?utf-8?B?NWppZGRaeFRlRkFtNXIwQk8rUG1UNUJVcHFwMWNoSk5FQU1hTWpGUWViYzY5?=
 =?utf-8?B?UWRtQUVwM2VyYVRUakkwZWNhNnA1NUhqN1AwWTZIUC8wQUdLSGdKQ0E1bjdu?=
 =?utf-8?B?Y2dUNHBTM1diUC91bCtMbFM5dERBdFY1cWdXdEx5Z1BNbVFCaWZ0dThFSHZz?=
 =?utf-8?B?cXpMa3lXY05SeDlBRlVtOXR6YmNnMzdCSG9jdnQ1YUJQeEhnSjF0WmhqR3pG?=
 =?utf-8?B?ZHMyUVo5cXRsYXZTZ3pkcWs3S3lkUjlnejdRckJNSERRcFFaWTdwam1JbUpu?=
 =?utf-8?B?K3d0d005WVY1ZDd3bXRBdzc3UExRdWxOdURER0JnUy9FMDN0U1AzcUhFZkw4?=
 =?utf-8?B?NzhOTExEaEQ1YkNXSHY5c0RWUThCcW1mZGF6YXYzTkY5Y3NtWktjdjFMTHNz?=
 =?utf-8?B?NWhpbk45TTdBRkVNNXphekhtbXN5NjZzek1OaDNTTHRHZmpIa3F1dlRra3Bx?=
 =?utf-8?B?R2pKTU9jWDRzWENkOCtQU3hRV3FxcDlyMjFVaCtUOEowOWpwUWVqOGQ3SkR4?=
 =?utf-8?B?Y3c0eWc0Z1hNb3BJeFVwZ09RbEc2Q2V3ejhPMSs0Qm5GMlFjNlN3VFRQOEpZ?=
 =?utf-8?B?RnA5T1h6QnZTMXBmcGsyb21PTUZud2NjRTlhRU5ybU90V2NZL0ljYkZtSFY2?=
 =?utf-8?B?dFBxMWNsWXU0Qk16TjBCclhoM2RVelRqRnpndS9HUGRmSzYzeUF5bm9mVEYy?=
 =?utf-8?B?L2NJZHZvVHFJcWpTZFd2SWdrcXRSaGxpM25wNDk0czhrbFJzeGJaZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d05e4a-5752-47e2-25b6-08dea4c8de6f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 01:52:56.7268 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bmui3ak1oK/hU9PfzASoB1BDSmN/N+l0wRP8XnyzQZ9+qzG3Ylv1UR+s8Xati0lB53dp7W4zpc9ts79S6ScSiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8975
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

On Monday, April 27, 2026 4:58=E2=80=AFPM Svyatoslav Ryhel wrote:
> From: Ion Agorria <ion@agorria.com>
>=20
> The gr*d_remove() has pm_runtime_disable, this indicates it should be
> paired with pm_runtime_enable in the probe instead of being inside
> gr*d_runtime_resume().
>=20
> Signed-off-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/gpu/drm/tegra/gr2d.c | 8 ++++----
>  drivers/gpu/drm/tegra/gr3d.c | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tegra/gr2d.c b/drivers/gpu/drm/tegra/gr2d.c
> index 21f4dd0fa6af..71f092d59d65 100644
> --- a/drivers/gpu/drm/tegra/gr2d.c
> +++ b/drivers/gpu/drm/tegra/gr2d.c
> @@ -286,6 +286,10 @@ static int gr2d_probe(struct platform_device *pdev)
>  	for (i =3D 0; i < ARRAY_SIZE(gr2d_addr_regs); i++)
>  		set_bit(gr2d_addr_regs[i], gr2d->addr_regs);
> =20
> +	pm_runtime_enable(dev);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_set_autosuspend_delay(dev, 500);
> +
>  	return 0;
>  }
> =20
> @@ -367,10 +371,6 @@ static int __maybe_unused gr2d_runtime_resume(struct=
 device *dev)
>  		goto disable_clk;
>  	}
> =20
> -	pm_runtime_enable(dev);
> -	pm_runtime_use_autosuspend(dev);
> -	pm_runtime_set_autosuspend_delay(dev, 500);
> -
>  	return 0;
> =20
>  disable_clk:
> diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra/gr3d.c
> index 42e9656ab80c..33e88ca4d4c5 100644
> --- a/drivers/gpu/drm/tegra/gr3d.c
> +++ b/drivers/gpu/drm/tegra/gr3d.c
> @@ -517,6 +517,10 @@ static int gr3d_probe(struct platform_device *pdev)
>  	for (i =3D 0; i < ARRAY_SIZE(gr3d_addr_regs); i++)
>  		set_bit(gr3d_addr_regs[i], gr3d->addr_regs);
> =20
> +	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
> +
>  	return 0;
>  }
> =20
> @@ -578,10 +582,6 @@ static int __maybe_unused gr3d_runtime_resume(struct=
 device *dev)
>  		goto disable_clk;
>  	}
> =20
> -	pm_runtime_enable(dev);
> -	pm_runtime_use_autosuspend(dev);
> -	pm_runtime_set_autosuspend_delay(dev, 500);
> -
>  	return 0;
> =20
>  disable_clk:
> --=20
> 2.51.0
>=20
>=20

Oof, looks like I had managed to really bungle this with my earlier
patch. Thanks for fixing it!

FWIW, I've been working on adding some nightly testing for Host1x/
TegraDRM, so hopefully we'll be able to catch such things easier
in the future.

Fixes: 62fa0a985e2c ("drm/tegra: Enable runtime PM during probe")
Acked-by: Mikko Perttunen <mperttunen@nvidia.com>



