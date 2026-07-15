Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0CBC4450A
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 05:55:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B10010EEC1;
	Wed, 15 Jul 2026 05:55:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="nwAlSjW7";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012028.outbound.protection.outlook.com [52.101.43.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CA8B10EEC1
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 05:55:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/O665ezj2Bduxz7moXw9OhesUab++Gu1ZxFAdzOaREA1T2woes4ER8tDEQsl1MXeMAn6MaYyVs4Svcf9F7wHEKfAUvodD9IOfBuJXs64T0IRSYEVuLansZ9u4oOGHeOIo2S+oKZvWjvnf9zAq4eFROY4PHMSYWRJX7RREqVf88Ommsub2VsHXzwA6LCIL31HNGZYucNYCmX4RIRBz6qYNlvbC8aoqilJ+D7sggh86PU84hITfJ7DVe4YEnkqTMklmPzXYYlIOx2ws+gbTxGDyMkL4d68gU6HJT2iXObh0sBpr9XKuoFPncq6GrK7+Nnhnh4/upObBbAftuI3+3QVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2KyelKxEtNiYRqd9llnUy1PRFrFjeUumBZpGPIxefE=;
 b=dluU8tJYHohgcBClFmD1j4MhrkYRmLYbuhZue3FwbXBJ6o8ecCTeI9hn49xYd2wPAZS+pHXl1NHc+I3n7T7RYB9SVrP6h1OOMTb79kxQDxNuSj/UduIJFaRBfxqInWAwKH8jtgwLI7HBflrB2ZQ4p/j2ou0FmRnsJCEdXZJ9D26rJ+HWAgmt71+G80ViRJsmsif4qMsY/xYQvQ1HZ2QO8++zVecmISh+2W5Hw09o/PtVCBxqi2ZhsfLe9uHeMJCh63mIBhNNxgRRI5ru8qHne24kwET/Y6fENovP9GW+/ckjkNl2RFP6DAD70fcZXYeBum0NdKW9kks4XLfZUF0vYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2KyelKxEtNiYRqd9llnUy1PRFrFjeUumBZpGPIxefE=;
 b=nwAlSjW7iAmVzVuHKLfYjpDO7kNX9SQfiAIhsUPhuvqINgJoOS2LkksQ6Wtxk6R2JnC6DWFvcORbG5JXyAmZpq0Vdh/H3XiEYzKxwl0R2NBqIJv5VF6Yx7zSCT1q9awnkFsQtIiSjqErKZXyUNPW/qUxKALKdxh+/7Wd7nGXjX+1KsYlHVhalVNV3iCa0moc5OY4r3eGEtR5nGmpefb7W1GbD35OuAamY1HugEaN7f3OPSxjFnNzxvZfnCeKneYaQQc2adR3CJ4zEjPZM1BNev2wUk+jeDu10GdV4s+2lP70pBLU1r8WNBhDbkYGiWYT3r08Zo+Xhbo3lMB8KdPsKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by PH7PR12MB6977.namprd12.prod.outlook.com (2603:10b6:510:1b7::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Wed, 15 Jul
 2026 05:54:59 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0181.019; Wed, 15 Jul 2026
 05:54:59 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 Guangshuo Li <lgs201920130244@gmail.com>
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: Re: [PATCH] drm/tegra: Finalize GEM object on initialization failure
Date: Wed, 15 Jul 2026 14:54:55 +0900
Message-ID: <zoMtvLtqSfu7q9QMPT-kPg@nvidia.com>
In-Reply-To: <20260714131923.1575860-1-lgs201920130244@gmail.com>
References: <20260714131923.1575860-1-lgs201920130244@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0144.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::8) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|PH7PR12MB6977:EE_
X-MS-Office365-Filtering-Correlation-Id: 53e46a10-d7f8-4d75-c796-08dee2359af6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|10070799003|18002099003|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: Xvvhlw2rNCW+C2uhSZrSpWRiIftERCY5/Ls9VS7NvCXDxU9lmlTsni+uq1+oaWVKdB31wE5ZonsaFTzPFJRShVNMplXrkjfjRbX/UeUSjqKgz9fTb2t8M45GBfEzhZrOS5NTXIcfpzwcfDSVbvytZiHQ2bcjnc9Izj55chJ8NYCAkVuRnx785YJSBo2rnIJLxgzwZGVnaUXOIQwOV4tAnK3alN0aa8F0KJX9W0z/4o6gc7jtRrwE6uWevoJsg51POwldL1pTX7K/bvy5TSQcHudtZ2n9s8++yoaUYQ+H9aXGEAne4EYlMfbuFtIRJJT6jcF3haL2dT7hkhBNW4egDmPjwmVFSL/5FVUUApdGISMoK+YyiyDsHBs1mTM774mjfzM5pJ0Sr60tMe23TsfVBT1wlNLW0g2XnPC+DmNntQGdOo6TKXxPgAZJK3uAJoHIDyCRrq1WQ3xAdQwNdRO+SXZAzsH0Gu2Buij2Rkt+dumiRl0o6JxgtHRGMSyd0NDYR3OV1NBE4cqH1O7btmDwaMZjim0DFjy7DHfX0fHpXnSLkDWFcdms9JXqrHjNF8lYHZ7oamYMWzqgJkf7oU+PouyaNHBQDTiwNN28LFlxvcvbH/EYZ6Kv9RdsifgO6WmHe0KGGUG6IjGM3ltNw0U0T6y7bgS2cAxXOZUnPpT2u1w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10070799003)(18002099003)(11063799006)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czJNSDVzSUVoWmJJMEM2dWc2K2UzNnZkYWVXUHhWOUdJdUZJMWZFMEN4aXRr?=
 =?utf-8?B?bXBOcElXVWVPRWhDS1lyWXRKMCt3NXFsWlVoZGJRMmFQM2UvdmYvdWRvTGFa?=
 =?utf-8?B?dnRkejQzWEdiTXhXQlcxTnA2cVN0WUU4YjRSMjZwejFsbndYS0hSZUY1YVBN?=
 =?utf-8?B?MDFaVktwRTBkY3E4Zkc2TzM1WWVBWDNrK3g3d3A5NkJ3QzE3bWxiYnc0bmsz?=
 =?utf-8?B?Yy9Oc3dNTHpwWmxTYWFrRXd3NjRYendzTDV5eGF3dzJtRk5SRDZFeFhyU2dx?=
 =?utf-8?B?OGw5aWlUZ25hWUpHK05TQ0l5SXJwTmVWMzI5Sk1DUlVOYnJnQmZubHhkb2oz?=
 =?utf-8?B?YUZvUi9vOUtvL2NjdktrRUlvUDhoMTFTWTBxWit4Rmc0c2dUaEE5dSt5UzFX?=
 =?utf-8?B?ZjlqU3Z2TWlVWWR1NWFmMXRqOXV4S0NvMjBwK09qWlRKdnMzdHNaSS9wVE95?=
 =?utf-8?B?ZzdyR3l6VkhZSXRlQzUvRXpzczVCZ1VrNlJ6emxvQkJibzNJOHRtdVlZVDh4?=
 =?utf-8?B?eWJNUFYxL3ZrSkcvdTNDUVZ3NHQ5TGt5V3gzNUd6UlZZU2FOMGhMS1orWldS?=
 =?utf-8?B?aSttVGlrUlllK0daQy9nZUlDNUlxZUdsQWE5UVNWNnFWRjBaUndoY3lBaU5p?=
 =?utf-8?B?eUhKck4vMTIvRnFiMngyNllyL0YySzdhTnBLVitya1hRdlFCUGM5ZytTd3BG?=
 =?utf-8?B?OVBUcExkSkJieVowRDdXMGcwblkvMWJFdWFLQTYwaHFIaFJlcWsrL2lZdWQz?=
 =?utf-8?B?a09rdXBtRUtkdFowZnl1Ykd0all6Y3pEbDJpWmdRR3l6WkxwR3ZQelhGNWh5?=
 =?utf-8?B?NS90cTdlTnN0cm5FSUJlVW9lRFNZTlovd1orQWdDcVBoVVZ1VTdPNjQ1d0xX?=
 =?utf-8?B?S2x0S21ielFqSHdTMVM5M1ZPQnFCT0FlZEZXZ2Q2cjZzTzVhSkwxV0JCU252?=
 =?utf-8?B?ZEY4ZFpBTUFiZlpoM1lIM0JmUVo5TFVRaWRMcm16YTl6ZXoxQnU2SGhYOEx1?=
 =?utf-8?B?S21Rd3NYbUpubi9JR1pGV05Ld3ZvQmgvK2JjaGloRkVRay9MbkgzaVFLeGJs?=
 =?utf-8?B?NENWaEJXb1lYeFc5VnJIeG9WMWRDTkY0K2g1aU0vNmdkUzlJMEJ1VkVLZUV1?=
 =?utf-8?B?cmNkNWp5dW8yc295ekVjUmpvOGJQb24yRCtCU3h3SFl5QWV2cFU2L3RGdVBn?=
 =?utf-8?B?Q0ZVQkJSaTRSdVhYRU9sc2h2QjBmWTYyc0JaT1RHb2NMbTEwUGZzamozYkRh?=
 =?utf-8?B?UGNpekZWQWNraW5lbm13Q0JmM3FvVzBEa0d6V1ZqM0dxMm83Ri96S2ZQZWVt?=
 =?utf-8?B?NFFyZzRxRW4veDVoMlgybkc2MGlHMEJCZkRUaG1YZ3N4SXdtcVgrN2JQQjZo?=
 =?utf-8?B?czRUQmxMUVVkTHRoeHFvbzdZOU5yZEVJTlZBcFJqUFYxMkdBSjY4ZktaQUJH?=
 =?utf-8?B?Tnk0UWlFVHFwZmRyK21oY1hkV0V2SHhSY1oyNkl0cFhqdUJHVWY5UVdaQ25u?=
 =?utf-8?B?anEzU3F3NWNDcEZvTEJIS0I1SHRNMnB2ZkxJQkQ4Wnl1ZXVVRFF4d05lYXpW?=
 =?utf-8?B?NXlnMkl1aFYveGxoOXRzTTRyaXJTdFRDbytYVDl4OXlaaWFDZi9iVlpGQ3VQ?=
 =?utf-8?B?dDk5Q0ZWeEVYUzBFZzN6S2NzZGFoM1E4SThCdUd0OUlkaTVUOVFZaU16OUxl?=
 =?utf-8?B?QWJ2MGl2bGdZd3pncWNSNmZoU0FMUDU3bTJGOFhjdFVOZU9DQ010N05QaDZB?=
 =?utf-8?B?cnZxMTduVUtsUStxRTFvdEJHTytKUldUb3c2VjBmZ2dQSFFWNktEcytDZFU2?=
 =?utf-8?B?QzFpaUF4S09rMEFMWnpNM3VyMGd4anEvZ2hLWDA1QjhzNmhydnI3VVV6QjVV?=
 =?utf-8?B?RDRadGN4YU1NTWhBYVpuRW1Sb3hRUjFWa0dtL1ZwcW1wQW1kb0R6YWZWTjdL?=
 =?utf-8?B?VWlXNS9qSGx2RXlrRHlnUHBLVmw5QzQ5bDdSQ1VEajhiWkhIZWROSmFZZDc3?=
 =?utf-8?B?MU0yTk1tdDQ0bGUvYWZNRmxPaUlPUDFDV2JzSjdkT0tOUm53RVhiTERmMUQ5?=
 =?utf-8?B?bjdJb1NWaUtTWmRRTndEM1ZuWWx0SlZjaGhzYTlDaXpZYXk3ZHhOOUhzTFRL?=
 =?utf-8?B?RlcrclhVOSs1bWx2QndGRUZ0WEU5VGdCSnlhQnNxZHhlS3dWekErRnJiQlU1?=
 =?utf-8?B?ZENxSU9ETGVWcTF0cmtIdkR0S2xQa21RWFJBMlFEZmJNOWlEL3N6aG41QXlW?=
 =?utf-8?B?N0hXQVdPNkJFNk9VWkk3MHBwQitPazJBR1Y4RFpSbmxpVHlGR1pNWUIxTnlx?=
 =?utf-8?B?ckRIUGt6MjFPT1JObHFUREh6NkN1YVpsQ3hzcVAwbmpxZS83akVITG5yRms0?=
 =?utf-8?Q?xTExY24zNRJ0BQFRdUtzq5thPxdEa6aYKliA/YpWIMHik?=
X-MS-Exchange-AntiSpam-MessageData-1: t26gRRp0swBQeg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e46a10-d7f8-4d75-c796-08dee2359af6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 05:54:59.6778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VBsjGwdQDXhFqxJq7uMRBTZbVBQ/2jLcuwowkgbRHdnc/JSCml++CMTcR9Rm2pEQP7OwhHuwl4ZmUuFA9YKlQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6977
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

On Tuesday, July 14, 2026 10:19=E2=80=AFPM Guangshuo Li wrote:
> tegra_bo_alloc_object() allocates bo and passes its embedded GEM object
> to drm_gem_object_init().
>=20
> drm_gem_object_init() initializes the GEM private state before creating
> the shmem backing file. If the file creation fails, it returns an error
> with the reservation object and GPUVA mutex still initialized.
>=20
> The current error path directly frees bo, bypassing the matching GEM
> private-object cleanup. Finalize the partially initialized GEM object
> with drm_gem_private_object_fini() before freeing bo.
>=20
> This issue was found by a static analysis tool I am developing.
>=20
> Fixes: c28d4a317fef ("drm/tegra: gem: Extract tegra_bo_alloc_object()")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/gpu/drm/tegra/gem.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
> index 436394e04812..eb513cb7521c 100644
> --- a/drivers/gpu/drm/tegra/gem.c
> +++ b/drivers/gpu/drm/tegra/gem.c
> @@ -314,8 +314,10 @@ static struct tegra_bo *tegra_bo_alloc_object(struct=
 drm_device *drm,
>  	size =3D round_up(size, PAGE_SIZE);
> =20
>  	err =3D drm_gem_object_init(drm, &bo->gem, size);
> -	if (err < 0)
> +	if (err < 0) {
> +		drm_gem_private_object_fini(&bo->gem);
>  		goto free;
> +	}
> =20
>  	err =3D drm_gem_create_mmap_offset(&bo->gem);
>  	if (err < 0)
> --=20
> 2.43.0
>=20
>=20

This looks correct, but a quick analysis shows a lot of drivers have
the same issue. I think it'd be a good idea to either

1. Fix drm_gem_object_init to clean up after itself (and update
   callers accordingly)

or

2. Fix the same issue at other call sites of drm_gem_object_init
   as well in one go.

In any case,

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>

Thank you
Mikko


