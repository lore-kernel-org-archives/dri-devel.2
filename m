Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3445606A31F
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 12:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qbCu9V0Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D21D112AFB;
	Fri, 23 Oct 2026 12:10:56 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011035.outbound.protection.outlook.com [52.101.62.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAFE3112AFB
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 12:10:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uy2j5vkGxDzevVa5gXqo8QxJncyvfj2/ORUvEk79QmYA0yNaKiRGkh3QWdwt6K0rMzMbPNwCtsgoY0vspS18BFMvAhlewI4d8Xv9SnNAm9wz7VYyGpt7Y1qViVk7mW6oVE4SAz34ecmJdZqkr8iQJYaE05j4eaRurlhbCCt1F2FJqcdqlWDhmRRUe41SGr6puWk1jEf1z2TqMiXrFNNXLjF3t/ONkPl+vf0u7jGRJ9zlZhe8hLFID/qgDvavizRA+BXAgiVHbibNaiB8534/86+x0fqZ3EiAxN3BE6Ecom/ehUxJ7zqucOUTZXFol7k0upqZqM0sFstNK5atFyihbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TG4Iu73aAEKP2jcwjceYT4rYGA7uks5j6bejX77+yvc=;
 b=EkFqbkr6b2R+2s1Y2QFSyEwkK8xT8iJnuLS6y1semhf7GpSvFzO94PIvXjBPr0JWDnuy6jIe9ieLdU4/fcXWn5XjrJbwTNee6IKzWhkJuH3OFs71pdSE/WRzSQYUkodpxQ3GXRzaM+69XcrQrO8O6H4LMW9raSBPSaKI6zoLmyj3iJesc84kxWFW24ZiVU+9vkk4ZCOfb0WqB+SzWT6dxyf+lRQmNUU1YCWoQjJferiTrAMZq4/X5GLURIFgyr7xo29St3R/x/2LkWSTogFRZCgOCKPYuKKw4IuFHQz9g1kMc5FyD9V0Ec+baRwMO3w8SD8WcaWUqkguPNU5XMhLEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TG4Iu73aAEKP2jcwjceYT4rYGA7uks5j6bejX77+yvc=;
 b=qbCu9V0YwD85TCrPhYuTVGaqBHtF1DBQXpyv5eGiMcBCvN9V6n6tsftSrUcbVYvlqrXchKRjw2gC1ydoEEkuu1ENYCviOiGELsyYP7F+UL8mQ8aI5x/KN5vKsngaTQkzA5gEf33sRzAwvWyfOS/s8w7bm7GA1Hl60aOeNhxrfuhfZ0JAdsyG1X5z/WPKGqW6tkDGeV9lj3SSIibrnA8Vfbsqe6Mr/S1Q8z1OZtFKjrfY/eqRDublKtVJ0t+boRI3QbuFmfKj9u9N3alAonpGTfZ2zgsX9hkFm1XKDrxXMjJI2uBKkTz1LMzin+uJB3EG2B1REcJXLq2JYD/2B4kkAA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by CH3PR12MB7545.namprd12.prod.outlook.com (2603:10b6:610:146::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 12:10:16 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 12:10:16 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>,
 webgeek1234@gmail.com
Subject: Re: [PATCH v3 2/2] drm/tegra: Support YVU formats
Date: Fri, 23 Oct 2026 21:10:12 +0900
Message-ID: <T1504rPqStSSyO9jl0by8w@nvidia.com>
In-Reply-To: <20261020-tegra-drm-yvu420-v3-2-7f19a834ba98@gmail.com>
References: <20261020-tegra-drm-yvu420-v3-0-7f19a834ba98@gmail.com>
 <20261020-tegra-drm-yvu420-v3-2-7f19a834ba98@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: OS7PR01CA0026.jpnprd01.prod.outlook.com
 (2603:1096:604:24f::11) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|CH3PR12MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: 21331dc3-0c7f-41ce-f23a-08df30fe994f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|10070799003|1800799024|18002099003|6133799003|22082099003|10067099003|11063799006|56012099006|4143699003|261022105027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: P3qQrYngS4qz3xHu4egjiPNo4H+8ZsAAfZRow2EkNmu1mCaAhEs8rONMIOUKJuT3JGo6cBrkBxTU+niC5JuBAV6kGIp8LrfYqtzSgUAwNjBrrduICx5uMb0hRe4x5atminq3c47QshMlDslio9znLoTLglQfxohWGvk7mKkYWqKN2JMaB9uv2g2L/1NBypmfxVQkJWNnE2GyqHESl/HdL/G/8mujy45baKLDw2PJtvemkVN+ipmOW8hfFAuH4DolCY4iqj98RNBC86Z0zaeJIvX4wXRj+NoZgcmH03m7sgu5s6/RmGWWJZDyJMj5xME57qxEh2QYDxaoSvrWB2Dz0iOlWjBpaRNPgkFL2ag6p8vIkddyC8ialyxdR8liJQukPtWLdlBuYrnXFIEdNjJZKeGdxpnu9YrhVj12IOz/edAom93eLJZm1qiWvIVXGt/hQmf4kEmQk9/uf9T4R1xvCyISoC9Mv8theVf2IbpK+2tNoTxN7U4fA0J30bb8YKAyDHBFykD9ffK7WdJieH10RDNohL/nOIOJkZz0VLdJUm3LODtsPXAbMKkZ4TCca6zxMtXeww1au40lkOPwbvaJqmFzsiDTpJMcfKqj6z7V8a0DXJc2zx5HnIJmdjau9GW44DP4AUuAp0QL/cg/svp7GLo4jb0S+IVJncRch50sy44=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(10070799003)(1800799024)(18002099003)(6133799003)(22082099003)(10067099003)(11063799006)(56012099006)(4143699003)(261022105027099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXcwK1kxSGRXRVFGYzNKVE1hTEV3OG9VNWRaMHNEdTFjc0lMK1pLNUl3ZzVJ?=
 =?utf-8?B?MDBwY3JsVkJRYUcvSm8wUHRrTDZmbHU5V1pOTU5zNmlyTUI2enE2MWxzSEFp?=
 =?utf-8?B?RTZ6YkhIbE96TWhyaGsreTIzeWVMUlB6REtDRE1DajRxdm1jajB6dndvaUh5?=
 =?utf-8?B?bEJtcndzZy9FMVpjZmg2Y09PemIrNXZZU2xtajZuTWdJUk1zZWc4ZUZCSUpC?=
 =?utf-8?B?VTB4VXFDdGxTUjJEMDJnQmZRaEhORCtwSFpkWFpMNVNLNjFmWWZvNjlhVElB?=
 =?utf-8?B?WTJZeFRKZVVFV3Yxc3liSGxvRnV4MDU5MUwrdWV5MC9pRWlNOThQNkV3ZFNX?=
 =?utf-8?B?TFpVcTNEV1gya0NSSjZGb0o2ZlR4MXZxSElQQ2xCckxsdEtwRklyMlVmd0pO?=
 =?utf-8?B?bkREWXc2a3VLbE92L01lR1ExYU5NQ0ptQ3oxQnhRYzI0WXYwOUlCY2xBaXc2?=
 =?utf-8?B?TUlaNXpSSWx3ZmpZMnhWbVFrdlUxSUxmaVdUeUk5L1pxRlRKM2ova2tJRVJL?=
 =?utf-8?B?a0dyZVdLRmx5TkdmZ09vc0lTeFQzQ2R4R3hlb3JmOElKY2RSdXZ5L1VnOFcx?=
 =?utf-8?B?VlFPb1Q3MVl3dnBCZ2VxeVhNS3NTWkF2VFFWVWo2MTdvWXJMRmRmK2I0REZh?=
 =?utf-8?B?R2llVjgvb2tJc3BqY0JNeEk0ZlhjTDB5VW9JeUVlY3NscGMyMGQyRXNyU3Vz?=
 =?utf-8?B?aGFkUCt6dzZUWGwzMGowNXU5N2RyK0FZN3NVdHhqSCsyYnJGWk5yRDJoaXZT?=
 =?utf-8?B?c0tRU2hRMmd4YU5wdUFuditZNFdBVStyS0dDUWxYZVQ0QjRJbFUzeUtxQkZ2?=
 =?utf-8?B?K1ZMUjRNMUlZY21vancraVNzVGVpSy9FdmJGNFFjVVlpRjF3RG5jSVlXczlZ?=
 =?utf-8?B?VXEvMHZPQ1I2MDVrQ1RZdzB2L0xjb0hVMkFKYW9yNU55d3BaaURvckdsdG5y?=
 =?utf-8?B?YkE4cC92MEY4Q2x0Wlk0bEd3eHkrN0IzYkZRSjRKRVc3RnZNNFdvd2xBOVFE?=
 =?utf-8?B?SWNZV0gzVUwrWWFjb1p1N09PbWR3eTY4OWlWTzlXUDdjdHQ2TUZwWDdQQWUz?=
 =?utf-8?B?WWh3YndNTzEwZ1ZqVXJNVXZmNEpLbDU2VTlJQXhBVmJJQTFGNG5uUFI0TExO?=
 =?utf-8?B?TXczWFJyTnZ6QmFtcFNsQVJXWHF0NFZ6NXZDR2lLVldwV0NaTnIzQ2hBRG5Y?=
 =?utf-8?B?bWxrSktsTWNsa0RhdXVNU3FhMFJtVldGd28wajNtK1hwNmVpZlo3U1F5OU5S?=
 =?utf-8?B?QjJMOFVacWdFSlZKdkd2M2wvTWZUNVQ4aTRxaDkzSEVhTFNNb21PckhMV1BS?=
 =?utf-8?B?WGQraGwvZmw3Q1VNa0MwdGFmRVlNM3lObjlJcWtWREZGdStmMHNhQS9IUVZl?=
 =?utf-8?B?OE4vYlhqSnE1WDQvaytSY3FaQS9SVzRYZXNBSk9xWDdoQnRXVGdJKzczcTkr?=
 =?utf-8?B?REZoNmphaWR6YzV1WHkwWGcweVFsZzM3b3JGSG9nODRJMmx5L216SHU1YStS?=
 =?utf-8?B?dnNBYzhyMjFjU1dOUHdnV1pzeDY0eVRRN2cxN28xREo5YlR6SHpEZ1dzUkVl?=
 =?utf-8?B?a2xNWW1PVUtxZ09Jelp2MXNWM0FXcytCQ2RQMjZtbTc1cVZFZlloMU11UlVB?=
 =?utf-8?B?eHpoRFd0NjRtbUVDZ2xEVGhKYTkxV0NTT09YVjZqakFlTkhJRkoyd0o0QVBL?=
 =?utf-8?B?aUUyckg2cjhRLzlFMHV3VFZRYzU0ZHRvUkd0TXBQb2UvYzlFMS9DcTIvdjhY?=
 =?utf-8?B?ZWdqNm5NcDBDMmFUMFIxdjVybTJPWFJQVU5QL29NeWIyUHZnSmdNdG5rbEtj?=
 =?utf-8?B?UDdLSkJycys3TVAwWUh1VER3UTBnMEJyWUNWZmJVYlFveFhaRXNocVVHQ0th?=
 =?utf-8?B?UzcwZ3NnalM4Wk4ydmhpUFI2WVUxRlRPWGZrRmZpYXp6NVBvdExmcG93YU96?=
 =?utf-8?B?NVR5dG1oeW83azFNVW5IUlVuUEgyYzJwVzZLREFwZ1hTVHJKUHlYR3hNUStW?=
 =?utf-8?B?ZFg1WlJIeFo1Q3VwelhYaVIzemlINEU0SFg2NDVIbzJsM1dJUnBaNFdTRVpt?=
 =?utf-8?B?dXNsZjdZYU40TXdzU0dyendJQ3hWaHhrMzQxZ0xxWGZnMTdxSUltK3JjVDRZ?=
 =?utf-8?B?WlFpaCtvanpvTG5PVFZBakxrQjZTZVNUNDMzM01KSXNzQ1d0SVhSNXhoeWg1?=
 =?utf-8?B?czNxZmdzTmpnTHZBdVJKdjZkR2NuNEJ4MmFyVnFlM0M4MjcxUUp2ZzNOVkRt?=
 =?utf-8?B?NjBUNEM2VGVLeW0rbHdlVTcyRzBiem9nTWdSSjJZN3dncFJRS0FkVkdiVjUx?=
 =?utf-8?B?ZTQ5M2U3NmZpM2hzclJwd09NUlJ2b1lTUUszMzJWMk1CV0dSNWwyQStNSDlB?=
 =?utf-8?Q?Qt99H8sGAWLBfylDwl/gCOdRzL/uiLxJ+ddY8+tJX5i5u?=
X-MS-Exchange-AntiSpam-MessageData-1: W8+8YxMs/8JZkg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21331dc3-0c7f-41ce-f23a-08df30fe994f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 12:10:16.4607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9i8XmFPqo69BjxYzeZSnFMMh41+hCw1gYyOI7qCWFE8hm0g50k7hdiiqW2xjusfdYjx5lI9zHhMvOcPOvxjKeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7545
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tuesday, October 20, 2026 5:10=E2=80=AFPM Aaron Kling via B4 Relay wrote=
:
> From: Aaron Kling <webgeek1234@gmail.com>
>=20
> YVU420 is used by AOSP for video playback among other things. YVU422 and
> YVU444 can be trivially supported in the same manner, so add them as
> well.
>=20
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  drivers/gpu/drm/tegra/dc.c    |  7 +++++++
>  drivers/gpu/drm/tegra/hub.c   |  2 ++
>  drivers/gpu/drm/tegra/plane.c | 24 ++++++++++++++++++++++++
>  3 files changed, 33 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> index 39c2e920d76a6..be913f2609077 100644
> --- a/drivers/gpu/drm/tegra/dc.c
> +++ b/drivers/gpu/drm/tegra/dc.c
> @@ -1282,6 +1282,8 @@ static const u32 tegra20_overlay_formats[] =3D {
>  	DRM_FORMAT_YUYV,
>  	DRM_FORMAT_YUV420,
>  	DRM_FORMAT_YUV422,
> +	DRM_FORMAT_YVU420,
> +	DRM_FORMAT_YVU422,
>  };
> =20
>  static const u32 tegra114_overlay_formats[] =3D {
> @@ -1309,6 +1311,8 @@ static const u32 tegra114_overlay_formats[] =3D {
>  	DRM_FORMAT_YUYV,
>  	DRM_FORMAT_YUV420,
>  	DRM_FORMAT_YUV422,
> +	DRM_FORMAT_YVU420,
> +	DRM_FORMAT_YVU422,
>  	/* semi-planar formats */
>  	DRM_FORMAT_NV12,
>  	DRM_FORMAT_NV21,
> @@ -1349,6 +1353,9 @@ static const u32 tegra124_overlay_formats[] =3D {
>  	DRM_FORMAT_YUV420, /* YU12 */
>  	DRM_FORMAT_YUV422, /* YU16 */
>  	DRM_FORMAT_YUV444, /* YU24 */
> +	DRM_FORMAT_YVU420, /* YV12 */
> +	DRM_FORMAT_YVU422, /* YV16 */
> +	DRM_FORMAT_YVU444, /* YV24 */
>  	/* semi-planar formats */
>  	DRM_FORMAT_NV12,
>  	DRM_FORMAT_NV21,
> diff --git a/drivers/gpu/drm/tegra/hub.c b/drivers/gpu/drm/tegra/hub.c
> index 5a86f8260f136..ac4542e54d7dd 100644
> --- a/drivers/gpu/drm/tegra/hub.c
> +++ b/drivers/gpu/drm/tegra/hub.c
> @@ -51,6 +51,8 @@ static const u32 tegra_shared_plane_formats[] =3D {
>  	DRM_FORMAT_YUYV,
>  	DRM_FORMAT_YUV420,
>  	DRM_FORMAT_YUV422,
> +	DRM_FORMAT_YVU420,
> +	DRM_FORMAT_YVU422,
>  };

Well, I just tested this and it looks like the nvdisplay/hub.c based=20
display controllers don't support planar YUV422. So that's an existing=20
bug in the driver but I think anyway we shouldn't advertise YVU422.. :)

Could you respin one more time and drop YVU422 from hub.c? You can add a=20
patch to drop YUV422 as well or I can follow up with one, either way is=20
fine by me.

Thanks
Mikko

> =20
>  static const u64 tegra_shared_plane_modifiers[] =3D {
> diff --git a/drivers/gpu/drm/tegra/plane.c b/drivers/gpu/drm/tegra/plane.=
c
> index 757bc552809fe..79ef5fc1b3678 100644
> --- a/drivers/gpu/drm/tegra/plane.c
> +++ b/drivers/gpu/drm/tegra/plane.c
> @@ -433,14 +433,38 @@ int tegra_plane_format(u32 fourcc, u32 *format, u32=
 *swap, bool *swap_uv)
>  		*format =3D WIN_COLOR_DEPTH_YCbCr420P;
>  		break;
> =20
> +	case DRM_FORMAT_YVU420:
> +		if (!swap_uv)
> +			return -EINVAL;
> +
> +		*format =3D WIN_COLOR_DEPTH_YCbCr420P;
> +		*swap_uv =3D true;
> +		break;
> +
>  	case DRM_FORMAT_YUV422:
>  		*format =3D WIN_COLOR_DEPTH_YCbCr422P;
>  		break;
> =20
> +	case DRM_FORMAT_YVU422:
> +		if (!swap_uv)
> +			return -EINVAL;
> +
> +		*format =3D WIN_COLOR_DEPTH_YCbCr422P;
> +		*swap_uv =3D true;
> +		break;
> +
>  	case DRM_FORMAT_YUV444:
>  		*format =3D WIN_COLOR_DEPTH_YCbCr444P;
>  		break;
> =20
> +	case DRM_FORMAT_YVU444:
> +		if (!swap_uv)
> +			return -EINVAL;
> +
> +		*format =3D WIN_COLOR_DEPTH_YCbCr444P;
> +		*swap_uv =3D true;
> +		break;
> +
>  	case DRM_FORMAT_NV12:
>  		*format =3D WIN_COLOR_DEPTH_YCbCr420SP;
>  		break;
>=20
> --=20
> 2.54.0
>=20
>=20
>=20




