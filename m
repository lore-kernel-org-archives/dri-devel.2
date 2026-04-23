Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D36FDEE4D
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 23:38:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9132F10E121;
	Thu, 23 Apr 2026 23:38:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="LlLbD7q9";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011035.outbound.protection.outlook.com
 [40.93.194.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4461610E121
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 23:38:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bg6gfjXtsn2gh3zN3JF4g1roAdU0KRJJB994gBHncVqLGfjYlNFNMPwyzys37tvQEDRcFEI88IT7g+ss+mFtYjtHlznmZ8zdFNodOiq2O8ohPWZkVzob6EnbTH51pUrcBqdjBL45UWlXmgzqFXzuZ7YKbbFrOA3Eo7GUJr5KtzG63kHGPfB3jDHA7Pzlh9IgLVlPd5SyCiw7uxJMI9W+chVnP5zKtfsaTpq0V2gKdEvQYTA2G5wBXDTO9TkdfLsYiC4apZXCH3HP6WcMjljq9yS7OuI/p0XTFmXRkp9rNyGDzIV4oY81gBy1aewkxvD3W/uHC4Acg0iS1fEpwLap8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLgfvt8chiZeQ5uBRAF7LvTFKNYSiHRZwfM2P7W/fqs=;
 b=YxESP4rfn5QYH3VaJQccPBTpSv7ZXYyKwYfvaAxlWWQc3Pu8T59+bBIfBT16plhQO5/erUIvWJYiPb0An8CHZo7Ze/fzBvnoIBRhan19GB2lo3/djveJwzOKXP3OFuwSi+YD0+7JvtYGoiyIYaZUY5Y1f8DOwHlx32slYOD+1906oqn03ET47qNrDxRIzp2yorgNJ/ejLOyQiphNvwnxYpCEzcPSh0ZKw0Qy+x7ppKN0I9Gbf15NqPOhrFyFrw1Gx0hOrh6ZOVWPzmYR3mJ19KSR5aH7ActyHJyE2m+HnxJHJOx/kFRe4tJhvOoOJ62Z4MxG0k4J8zD8lYZLQV1+XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLgfvt8chiZeQ5uBRAF7LvTFKNYSiHRZwfM2P7W/fqs=;
 b=LlLbD7q9An+/Qe1PLTA5mooTvkSYVaz779H3XjGrJFL9Kdt3VhW7dVw7lFd/Ay+jeGAgXozo0Dng+eGYX2Ydsmt+JpUlkqgzLltXzgW/ivAFhtiqyxaSOBsBMpj2sUOyOmewyU8hVFTR46wTVnMufCc9PyKIP9tZI86BXiq0FMWjJt9NS0++X0LrEAhyrOL0oP3NfWR0dQI6sXfxDjpp5I0qRADUuGhCxS4POYwRQwP9xQyj1H6qsotNvV0gNqf7tLM6js8C2J/A/TaZdb1kh4p68eO61Lut+9OglRzY09adVZBMR4n3oWi/wpR65zpZUdksm7gaP+b1wAlOui2Htw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 DS7PR12MB5935.namprd12.prod.outlook.com (2603:10b6:8:7e::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.22; Thu, 23 Apr 2026 23:38:28 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 23:38:28 +0000
Message-ID: <976c06d0-b69f-4755-88d7-5516016354d3@nvidia.com>
Date: Thu, 23 Apr 2026 16:38:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: nova: update mailing list
To: Danilo Krummrich <dakr@kernel.org>, acourbot@nvidia.com,
 ecourtney@nvidia.com, joelagnelf@nvidia.com, apopple@nvidia.com,
 ttabi@nvidia.com, zhiw@nvidia.com, airlied@gmail.com, simona@ffwll.ch,
 aliceryhl@google.com
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260423124649.38793-1-dakr@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260423124649.38793-1-dakr@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0194.namprd05.prod.outlook.com
 (2603:10b6:a03:330::19) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|DS7PR12MB5935:EE_
X-MS-Office365-Filtering-Correlation-Id: 26c3431b-95b8-4dd2-43b6-08dea1916b46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|921020|13003099007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rOT3Ds6fnqgyfLqoXbEx1j7FSpltf3WD2oW9ByZ06zRJDL9H7FUVtmpPefVpzxlT1i0rGnrHFWCk83t2QQv/sFkknlyRuQI4eclMoZWR7yGpmrOkOt2Xw9XgmL9QJI94KsWD3H07HBulyNpD7t5xatAwkykTIxU5oXjDZXhYB7+mAI3BxZ6G3RD4X7/II05gbLaEykFvQHLny4YIJRiibvQoWzzCNONwXWUWhdozVhqJojneZbjecb9sUhiGBB6iIuQ8R/2m7fHmo91tYovT60+I93rQibTsBvZY7kUaMPkHVn0ihDEn4UOK6X9BB6Ygexyh3s0VM3xjXJdHmronHMlEqu5Lme9aQ+nGb0tRt6sxbQWfvMwOj8PLVqHi/HdAaaNRfMoHbWwj6NLMVbq95BQ+hDlYyNcBHQM+G3IZqv2+SYX9zJD6bUjBtyG4TbhOj5FdxJOPiMSW4xlCiqQbng6LH1iXjtVtnGLaCiwhv+L3z2PbWRgGaOUGVSXlY2e/yreUPjJFE72Nwhmy4cwswwRHbPoB8elgrUsNiiFCl9knNZI8VP1Uo55n7wd7lx7nmX1W7CPWICcQffZ4YeXEmy8vCFH0YGeN/SuBKDrWEVpcAhNe8MN63gty1N9MKoy9oPDKbbxeEmltrO09824xaHlgmp/F6c1hz1frujI5mzWPwumVK2Rvkw6moGfnySeIFcCGjOOFpDE0QUPST24B7puggETcq3wbOfbaLszH29eCg8mWOwu1Le02seVTfPNFLk/AKsRYg1o0zXzlXkJZ5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(921020)(13003099007)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFJGWUFYVTRKTEI3Vld3SXgwTUI5ZzNhcDMxaWY3ZTlsV3dOOXNiTldiZnZU?=
 =?utf-8?B?eWNISmF3eW1iOVlBVnNtRkFGUEdrUE9rUnBGcGg0Y0NWM1RSOGxvNGcyS0pn?=
 =?utf-8?B?RVdhM3NXS3NSRGk2UmhmUXdqT09malkxTk1HQ2pvZVR6Nk5xSEdDN1haZmI3?=
 =?utf-8?B?TmQyVmJlRjJodHRxdkdRZWVoRjRRSGE5SHhEZjVyd1pJbThMay9LK2JQbVpa?=
 =?utf-8?B?ei9kdk90Yjhidk5aRVVPTkVpOTNuN1Y2MlRIUkt0cmNLbE9iOTd3TWFSQitO?=
 =?utf-8?B?Y0c2WW0ySDdtRTZMYWRYR3lXRkw5Nm82OVRRZVhMNlBRK2Q1YnFUNHJwclZF?=
 =?utf-8?B?V3NsbzhKa2JGbGc2b0FvWDhGWkp6U3hHVENjWEFDU2xuYUVoVk9QQU5SSVVs?=
 =?utf-8?B?TE5maXE1OXBVZFowVFpGTjdlYktrM25nRHJwKzIyVmdwQUJvdEFJVG1HRVZT?=
 =?utf-8?B?ZlNQamkya05oOEFLR2JyVTFhQnJvV1hGQnR4aDdFTEdJbFJvYkQ3L28vbEpo?=
 =?utf-8?B?N2h5T2FibkVzVzJ4SmlZVHJ5N1ZTVVBKQlJmczJVaEN4VFhNME11eXlzblh0?=
 =?utf-8?B?ZDhvaldOMkNETlJUWGx6YkV3allKV3Z2dEYyQThpMFhuTWovaU1LYXlYNm1V?=
 =?utf-8?B?WFRjdkF6eXhkMHpBdVZQME41RHBMQXlSZmtSTnJUc3JwQ1lHL3psSi9ONWwz?=
 =?utf-8?B?RWU1ZGc1SjN5ZkI1VkNkWVgxY2JQNmRGcmpnazIxTlliUVFPdTVqOThWNVFW?=
 =?utf-8?B?aEo4azBIcEhhdzRDSTRYWjZWaEJyc2prL3kwZTF4VVFjcjF1YVNNaXczdEI1?=
 =?utf-8?B?Q2p3NGQ2KzZ6NGJjRTlwaDE5TjhQVFpWNmlBa1BrSGFpdk03N2F4V1pFQkMz?=
 =?utf-8?B?d0s1NDNBSStrZ1o4MjNhUDlmR0R0aWlZZjlXTm1qQ1ZSNStLVDJMMmZzR2Ni?=
 =?utf-8?B?RHdaVDdEWHh2N0pGYzVaSzF5TVBOQUpYajZzdXFBVzJqdVV5MkxXSXZjOXNQ?=
 =?utf-8?B?eE5nSk9odWNicGJRNnQ2a3dnRGJ3MSs0cjVFd3pZMUY0ZDMvVG9LQVNSMFBn?=
 =?utf-8?B?dExFYmgycVRlUTd2Vm4yRWZhZDRBcHY5Tzg4ZDRKY0RvOW1vdjI4TUFYekZv?=
 =?utf-8?B?MUhTWUNMdlhjTGxoYUpqU0UwcForL2hsb2c2eUlSbkZVL2ZuME5kckNKa3Z1?=
 =?utf-8?B?ZkJGOGF2Y0ZXREJoS1dyVlJpaStsNVdkdWpPN2N1MUtqL1B3QkNtQXo5cHRQ?=
 =?utf-8?B?SjdYVEpUb3pYV1FTL1FzUWU3azk3V0V4dzNyM0lJMStjV1hmUC9XZVZpc29j?=
 =?utf-8?B?Y2tJZXhjaUZZOUluaGJwNXJEai84NFlZYkVjQW41SFFPdWJZRUdOSkRXcTdj?=
 =?utf-8?B?MjZDS0lMQzFiM2drbnFpa1c1NUU1VjQ2clo3c0tPRDE2a1QydVdLdStZZWRH?=
 =?utf-8?B?MisxU2EwK3crTEZRWCtTd2VCWGlaS29HU0tPaS9mM3ZRb3loYlNlaE9xWVZq?=
 =?utf-8?B?aS91UXkwekNqVjZSS3dHd3g5aDlXb3Q5Y2plR1gyYnRxL1phQ21ldFh4eTRK?=
 =?utf-8?B?M1lHWi8wVHkva1RZRXZYaXAxdDlrcTkrK0l0VWNNaXgyYm56OU5xZXBtNTdr?=
 =?utf-8?B?S3N4SGNscnc1WHJQQTU3R3hDZHhsQ3FrTG9PdTRvUkFaSlZpRW1WYW8zcXRn?=
 =?utf-8?B?WjhrYW5HZmdrVVRBT0lNVWJUM1NSWkxvNUtyS2dDQUF6dFRCR2xjd2NOZlFk?=
 =?utf-8?B?VmVaYk16SFh2RFordUcrODJCMERjeks4VmFXak1pV3RZNEk1UzhRd3JUVHhl?=
 =?utf-8?B?a1JQTUtJdWJqd0N5VzVTY291TEhaclpRU0xjcGpVSW5IUjFLdGVxejR0VjMz?=
 =?utf-8?B?UVJyU1AvaGhYMVhxZFVHK1F0N3ZKMmEvSTZxS3pOaHhtcTljeHZxeW0ybTBp?=
 =?utf-8?B?ZmNmK2Y1Nm5pd1Zvc0t0ZHZyZ3FnMmdtMTdaRG15TUIzYnY0Z29XSGxOb25u?=
 =?utf-8?B?ekRGWGNDYjdHbFU4V29jQnhZWmNnTWcycmJvc3d4Wnd6WDRFZUVPS1htQnhK?=
 =?utf-8?B?YlFxUkZKODVkbTZDQlVPbDVHeW5aV3ZFMHFKbll4Y2t5eDFoNlBoME5UMUJa?=
 =?utf-8?B?T00ybGVnWk4zNHZwQXNqNEJxWUN5M29SanZyM3NwODdNd21ZYXFka1VZRUVK?=
 =?utf-8?B?ckYxMFlkK2V1QU5wbUtUa0U1NjExMXdvRHhMaThQb2JTMEU0VlFrT0tMTWxl?=
 =?utf-8?B?SDAza2tFY0J4MjVnUXVzdE4wN0VKSWZaM0pDRWh5VG1aeWs2VGlGL3dNcDc3?=
 =?utf-8?B?ckF1UjlCQnlqL3NWRVpQTit1TnBRb2tjZ2FtNmhQdjVRdlNieXNEdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26c3431b-95b8-4dd2-43b6-08dea1916b46
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 23:38:27.8105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OGPwVFO9s2KPuz6+NS2C+pz2bpZGmm5hcPc6+YD/ERkKnGKTE7AVRZgB9iJEpvI7BUqV+1Z/bMcaZLYdfoR+gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5935
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

On 4/23/26 5:46 AM, Danilo Krummrich wrote:
> The nouveau mailing list has some issues (e.g. with stripping Cc entries
> from replies when using notmuch + b4 based workflows).
> 
> Besides that, having a separate mailing list for nova also helps to
> better distinguish nova from nouveau and makes it easier to track
> nova-specific discussions.
> 
> Replace the nouveau mailing list with the new nova-gpu@lists.linux.dev
> mailing list for both nova-core and nova-drm, and remove the patchwork
> entries, since those are bound to the nouveau mailing list and not used
> by nova anyway.
> 
> Link: https://lore.kernel.org/all/bc2517c2-6772-4cbd-8fd7-6dbdcdd13eab@nvidia.com/
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  MAINTAINERS | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c9b7b6f9828e..f44955f177a9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8207,10 +8207,9 @@ F:	include/uapi/drm/nouveau_drm.h
>  CORE DRIVER FOR NVIDIA GPUS [RUST]
>  M:	Danilo Krummrich <dakr@kernel.org>
>  M:	Alexandre Courbot <acourbot@nvidia.com>
> -L:	nouveau@lists.freedesktop.org
> +L:	nova-gpu@lists.linux.dev
>  S:	Supported
>  W:	https://rust-for-linux.com/nova-gpu-driver
> -Q:	https://patchwork.freedesktop.org/project/nouveau/
>  B:	https://gitlab.freedesktop.org/drm/nova/-/issues
>  C:	irc://irc.oftc.net/nouveau
>  T:	git https://gitlab.freedesktop.org/drm/rust/kernel.git drm-rust-next
> @@ -8219,10 +8218,9 @@ F:	drivers/gpu/nova-core/
>  
>  DRM DRIVER FOR NVIDIA GPUS [RUST]
>  M:	Danilo Krummrich <dakr@kernel.org>
> -L:	nouveau@lists.freedesktop.org
> +L:	nova-gpu@lists.linux.dev
>  S:	Supported
>  W:	https://rust-for-linux.com/nova-gpu-driver
> -Q:	https://patchwork.freedesktop.org/project/nouveau/
>  B:	https://gitlab.freedesktop.org/drm/nova/-/issues
>  C:	irc://irc.oftc.net/nouveau
>  T:	git https://gitlab.freedesktop.org/drm/rust/kernel.git drm-rust-next
> 
> base-commit: 2e68039281932e6dc37718a1ea7cbb8e2cda42e6


Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard

