Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0FEFDEE53
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 00:01:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 678A510E124;
	Fri, 24 Apr 2026 00:01:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="TfXxeiRW";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011013.outbound.protection.outlook.com [40.107.208.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9573C10E124
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 00:01:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tUNq21Ku0Co5kAWNjvgWbx23xoQUTEoZRgH63ey1d5I9If0pqudQx8AqlhEI0bEGsYrMi4D+wDT//2zsV7tI4sRNx5oGZyijGOaXSVVLS3/tOORhG5z640Gry9g2RYsfSIL2dDJnADuls2AfAaQuvYT7T/UIgRanOC+ttB1n434OkoVkDwCDfiZqp5n4TYwgSg08JUKPBoMCe0+gNTJJxPOh+A/SbIRObSPRlynfa8eMvTEqvho06/p+sBDEMCUwu1b2EHA5qnwptzrcerBAUR7ht6VVtd7W8lkAGpaYuW2B1DWqigSgumGrBE396swFe8wq6XSTlfygY6LNOoORbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqft+yD/3dxgTuqzWYr4MdBEhcgJkdiFaNPsJ0jhwHQ=;
 b=gu80FZ4HsdvrVJbk+NHVc0oONuRbuaITQAhJFmCxaR4fYMkGjjhO/1iuc33USznBRji5b2zLe9ftO9ZbbA/ifEY/O0NxTdKeykUUomDDa94jg9DIkzYEHTTPBhpTi/eaLZPC2lljFGnPcdcmGRAhRmJ3VavqIL+dIzy+8raBZfj5WTvYoMXv7MAxAbTNKiCV6PXe1RL6VzOpoyzzuj3vth/miaVYvUQY5JebFvD75Ub1GUEdicDjFCGKVdkT1UXnLWgLC/PmkSVZw2rP3MyWG5eggaYb6HdnHIzSg2/JFo9v4epzTbnSO9B/aryTsAfSo7jSYpOmISmNdl9fYll5ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqft+yD/3dxgTuqzWYr4MdBEhcgJkdiFaNPsJ0jhwHQ=;
 b=TfXxeiRWQZRjORxD/6xrf08u00kE5kt63a0nlmviZBQwydVePhj3NzUjrZ6kjP+XWjjDktn2CrEX177ZhEZhADTYHOJJ9BAA+bN3+UIWGPq1OkPtPG1085p8XN2l6KX6JjMjkBEw8ZUhGZzt3G6o49+ZQyHBYC74ZTM1pAkI3svhQYtl/1hU7i/zysAQU9e4g1G/Um5ObHfOgWZUub/r6n6t+tFmhMJJ2z+AfO2RQ7pQNO2gsFT9W3ziXQ4NuJ2au8BR466XW68Ugpya3NrDeKZFeGp7e2tqbMwLr9Og44Vz/FY6LGItPRRN+jt/1JGfuoE7BakguDaxiOfar8O/cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 PH0PR12MB7485.namprd12.prod.outlook.com (2603:10b6:510:1e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Fri, 24 Apr
 2026 00:01:51 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9846.019; Fri, 24 Apr 2026
 00:01:50 +0000
Message-ID: <73350120-6eff-4f9e-945a-69a5d1d14a28@nvidia.com>
Date: Thu, 23 Apr 2026 20:01:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: nova: update mailing list
To: Danilo Krummrich <dakr@kernel.org>, acourbot@nvidia.com,
 jhubbard@nvidia.com, ecourtney@nvidia.com, apopple@nvidia.com,
 ttabi@nvidia.com, zhiw@nvidia.com, airlied@gmail.com, simona@ffwll.ch,
 aliceryhl@google.com
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260423124649.38793-1-dakr@kernel.org>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20260423124649.38793-1-dakr@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN1PR10CA0003.namprd10.prod.outlook.com
 (2603:10b6:408:e0::8) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|PH0PR12MB7485:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d829d29-303e-49ce-ac4e-08dea194af71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|13003099007|22082099003|18002099003|921020|56012099003;
X-Microsoft-Antispam-Message-Info: HaV/dBlaw+kJpO0iPvMqRyvrSbp0V012oRZzgzAEiL+02LVSZT/zyqHrLkOUTx8it4CnJc/W5gdDv+q5EKq/mxeaeYDYSvF9y6x1nrvXSA+Qy2nUdC/CkUNmxN2D3MMBoN4szKnhJZoZ+YddAISV118DkIj8v8eM3VzU3tbcvnWN5OCvuW/O3ALqsgEce6/BJ+PgbObNVKEzpL2G0w4Nal7tL8W9kr8dZjM2iybFIsnOgkNYqkw45KQuTEpVh1NExh4suphZ08K9VBO5FstaOQaXZkEQFDoRM5j5/aK+eZ861dUuFIPNnyKiEhHUWf+eO4WbF1vbS6nmW+1HpMlqmmoCwxkN2xJQSDZ/aE17serELPs9ugDuqlb7n3IMYp1S18f6z1RI9un/sV6ZrIw3/snZfqrKv2e5EwCvgoksAKNS/581ILA4mo6fwoN1/ZNErBazKiznAN1vJHtbo1morE2PZ4RLGCVMDndaYZ1MO8XZtQHI3cv37p/EbqSqLAPJo1z5qnBnKnoRR5M6LcywaGVPeDGq775da4Rgm5l8TXKOi3uFHwk11U0akSMz6b3tcUTNNYZpfSRSBPCI4j6wXouaoM0DVLezsz6FZ0oS6DMUIMg4M5TkgBph0YBPE2cX1u15f8RFbWb+7oZse7hjqafzMEYzbDmrGKeZYc/k9aNvzqJRYN1j6Jb0EN6/Ed7QHmOrDhsbH7OfUPMyVWUE4B4Y0kKAgWjplMAODngjmE7GiDbITQZEuy+8Db6vEe+fpIeKQq03KFiSh/hA7gbv7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(13003099007)(22082099003)(18002099003)(921020)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a21tWSsvWFpoY3QrY3pvbkpIb2dXSzA3WktYb1hnM3lQVWpRQ2F5NVFyVkVo?=
 =?utf-8?B?ZG5Na3ptdWpxSEVqaU1CRUwwMHhyRUZyMHVXQjhjUFpORmdQU2JiYzJweEFL?=
 =?utf-8?B?alNvSHJjZXhlcUsrNyt6LzFDTmVwY0IwaFc5dUJybGtScWw1Wk9LS2RIWmRt?=
 =?utf-8?B?eERsYnNJanNKRzdZV3QzQXR1dTMyQWlBUlFLcC9Ka1VNcFFjQ2pQS2t0U3Ew?=
 =?utf-8?B?M3UzNTlxamVKVVp5eHpDcnFubVNkbEdnVlpPcVZVVVQvN09SREpaQ2tjRTdU?=
 =?utf-8?B?a1N6NVR0eEJBS0NGUGNVcElCbFNLcTNDVVVPSWVlNzErTmc4TmZsTkQ2NFdK?=
 =?utf-8?B?Mk14M3ZXQU5tT0FNWHBsZzV3aS9DTk5kRitteXY3OGZ4TGFkQlJ2TWEzOFN4?=
 =?utf-8?B?aGpsb0g5RzVOVVFIMlZOMDhJVzl6Y0g5K05JN1FpTVYyYkc5OTV0cE5mdEsx?=
 =?utf-8?B?NjlMS3hSY3VjWUpvR0hIV1hISVdFbkN3ZzRiT2kwR0l1eW9QV3dWdW1GR211?=
 =?utf-8?B?c2hIdmFUcWNyZ3E5bUQ5L2xaRjlIdFU2RlNBNWVrMDNUd3BJbU5lbHA4cVBI?=
 =?utf-8?B?WDlIRkNoWkhUQVRVaHZGcWNEZXJvZENWWXNlbHpGdFZQVnV0QzE0SUtNdDV3?=
 =?utf-8?B?NDlaVTV4Z0F2a2lUcDMxMnlsa1l4YzhSR3FBd0FKR29nZlJrTllxVGNhWGdl?=
 =?utf-8?B?b3UvQThqK2xsaGpuZmk5ZDRpYS93dXVrK0FRcjhIQmRkMGtJZkdhMTlJUE1O?=
 =?utf-8?B?citBTFp0RVFPTHdsUEtONkQ4d2tCK1IwcGxzbFdmYTVyQkc4YTdQbURLSGlT?=
 =?utf-8?B?NmJ6MkFBT3A3V1VYdWZ3cElGUHY2YnpxWGFnWm1STVhMWG9WazJvdGc0R1FN?=
 =?utf-8?B?aWhjTTdlSmVuU0o0R2xCNTFoaEZWQWMrQWE4SE5HQ3NVdUt0K1BwTkYwSFpW?=
 =?utf-8?B?a2x4dmlHc0pSSUprTmkxM1VYWUcyaUNoT1NiVlloSEdmNG1IT2tGbE0xTDhE?=
 =?utf-8?B?dHo3WE45ck1UTmxGVUpZcVY0bjVFaDlHZkhzTWJyU0dZa1BWNEtQWEtUQ2tT?=
 =?utf-8?B?UzFGQXRWb2xhUDluZU9rdEtHdzdka09Uc0VseWlXRHlqdndXM0trMklqMi92?=
 =?utf-8?B?MTByTDQ1aUZQalNmVWZXL25PWCsrZlJOT3VoaGltNUFHNHFZOXc5VThHODdU?=
 =?utf-8?B?S3dkUE1wR1FscWwyTkF6dGFieTB1VnJtTmdPNkpDUHdtZDJMMFVCMmMxZjJ6?=
 =?utf-8?B?T3dVcUtEOFY0MER2SGNsUjJmVUYxSmJQQkNRVWoreVFrU0xpWGZMTWF6TWpi?=
 =?utf-8?B?WGsxSzJEQjBiMWU4WlZXbzBrVVRxZkxvMjA3dmk1OEhJMDZRSzhXTE0zNVA5?=
 =?utf-8?B?ei91TmJ4VUpyZUtZQ1kzRVhQUGl1UlVZWk1YdE10SHJ1R3pmcTBDTU5SYTlC?=
 =?utf-8?B?TjZsVXZNZ2dUQTZBV1pTUjI0UmU0M2xkQjVvZzRKRGdOaUxQWVJwSm9KeERL?=
 =?utf-8?B?NTJyZXl6TWJ3WnA4WFZJTU1tb0xaQ3duazhtSG1qWWtZSWU3cGxaeC9qNWZE?=
 =?utf-8?B?ZnJ0UlIxdG9zV0FLSk1uU0hDUFBPemlob2NGSDVuaWhtVlh2NlNiTkpPRTBi?=
 =?utf-8?B?Y0xHbEE3NXZWandZcnNwdTdoLzJtUXdMVkNaOUE5Q2NUZE5wRTRIdSt3VnpX?=
 =?utf-8?B?V0FhNG4xaXVKdGl4bnE1TkloYXAxWEpDSmUyNmNsb2NmVjV4aVpSWWQ1cm54?=
 =?utf-8?B?V1U4aEJlbzBBa2IwTWJ6U21EdzJmSVFEV0NuSEVKbW0vT0hBdGs0YUJYbnlt?=
 =?utf-8?B?OUJPNnRtOCtibEhsL1Z0WmhVc3lzUXJ3UnNlY2dDZkx1UXh6NEQ3dStMczR5?=
 =?utf-8?B?MlNpbFVLanltbzNSSUJjUElRUmw5cjZ0V3pXOUdGUlRzaHA0TTNLT0VjRFBK?=
 =?utf-8?B?di9hbzlyTk9MSE9tcTRwVFNNbFl3TGpidk5zT0ZqNEl2TWV2WkdLaTQxZmF0?=
 =?utf-8?B?RTZSc2E0NXdNUHNYVW1xSkJZK0lpSHorYkhtL2lISzRFcVhFNGtIRVZLRllu?=
 =?utf-8?B?bzBvUmdhTm1OS2Q2bzhyTC9ieER5VVVHWE00UWlqV1JqY3FJRzBkZ0dpQlMx?=
 =?utf-8?B?L25oeEdlY2daeHN0YWljOXF5Z00yK0EzOGNZSThUYkc2eWwxNFRBajlCbkRU?=
 =?utf-8?B?RUVWeURSdDNOOXR1aGY4V0VlaG96SVE0YmduaThieDJ1L0pJMnhYR1czK2Mr?=
 =?utf-8?B?OGF5cFA5SUlJazhRcDhtM0YzampOWFJ0VGxiVzg3eVpldy85WU9CbnNIRUJP?=
 =?utf-8?B?NUpHQ3ZEQUVLNm53VkVtdytpbFBhcjIrcWluWnZQVVkwQjBHbFlOZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d829d29-303e-49ce-ac4e-08dea194af71
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 00:01:50.6638 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VbVgZmhdlRYKEuIRjZ+hKl9aZ5aS+JNBTDNZCcB32ocYulpjkIfaXjwZB7huCZlK3QIBmqBBcx0y/Y7weHVKnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7485
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



On 4/23/2026 8:46 AM, Danilo Krummrich wrote:
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

Nice! Thanks

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

