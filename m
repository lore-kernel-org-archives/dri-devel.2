Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790B6CD5BB4
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 03:06:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E18B710F759;
	Sat, 23 May 2026 03:06:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="eS6rAr7t";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011026.outbound.protection.outlook.com [52.101.62.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28D0710F759
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 03:06:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c69bZAfsXJSa7R8JKOBKt8tFtb9S3mtnPGiyWqvWnLxtlsTakfxSRT0Y3UaV/8GHPfP6+kY2yxGzp0EYC2bUJbDOlJBcua9GYLW3yVrSdk08ga3kwsaFxNZeNKIIddAHADxjhAaeys1pze9nkCNbvx1XJbZRmc9ZzTQq1Tq48GGDiNhcUUsFAdnv8f7GRB7m3W2E3lyJaPunynaPPsrMbQS+3XFjgZOqPNz5ZOW8As6D+vQGt6xY04cwSsd/FEwNGo7cRp+YOC4btArkCOemUcraPcllalwOWXM7kRXsiuc59tFp+mpg9Ny+DGwoP4D2SgIvf0P1PI/BzQDE7wAJ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEWU93mdUXKas+HRROZUJdDEEpquSt0TGgzm7AUrJB8=;
 b=NvNWTXhvBvZfgoSjBVn0TfLhTvwHaXqY+1vpSmrRrESWbtcosAnS6nyy2FsXtJHyN+mS4zyvG/JlIfMHAnCtDMOePFD+ZRPAgQxa/IbkiZrS4pSYVlLUSQ5oEjZEpiEVAAd4qA6C7fj+bA5X5zIqQR4QLYA2xx+wGcKJ5iOeumKDfgjWqm6O/ye84UvcN94o1eidj8juTrqmPNYXKKemhPYfzuZcU/4RND7LZo/SEsyROEtQVhxUuiUjaNJ+QLKzllRUbgpKZiERRljXJ5HJGJpWIToQzzSdP95YLfxtpy80cizHSXnY+kVFr8VvUn8XIzVjz1Agcw1pIa0YLfy4tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEWU93mdUXKas+HRROZUJdDEEpquSt0TGgzm7AUrJB8=;
 b=eS6rAr7tluR50R0OKCMIuE2dnWy7/GT5LiEQqLrSaUzpTznc2n7RFgvmU4+HJC1Iv7+952vzcnOkzfntGvAJaFNJijDNVvV1moE9OIbpRmBYWQKxcldjhARKU/kw93Fa2Sx60QYTzy9gIUrcFNKZHrsj9B2c8swLtsTGBSmB5Kl6es+24mzFPpQ/DPyNw29DsCuyJ8EFYFGQPg0xhgUfdVSQHiHlSQxrK2CW1Uo7EEAY/T+v5oqbFuclyi9lFHOs5bvX+s3DiM4UtUvHlqaf2PenHj6LL0KjHYfQUz09gtSsDVFRCCoGQ6XdpbDrpdPk8O3ulkMtMo9ORja33gCqTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 DS7PR12MB6263.namprd12.prod.outlook.com (2603:10b6:8:95::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.17; Sat, 23 May 2026 03:06:22 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 03:06:22 +0000
Message-ID: <b149ae04-98a4-486f-bf19-ff448303e9d6@nvidia.com>
Date: Fri, 22 May 2026 20:06:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/20] gpu: nova-core: vbios: drop redundant TryFrom
 import
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
 <20260519-fix-vbios-v4-19-5d3f210c5602@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260519-fix-vbios-v4-19-5d3f210c5602@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::10) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|DS7PR12MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: a121e0b4-fc99-4271-0247-08deb8784483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: Qt67CrGiJIiSkRyPr7/BThWe0Aic+QWWhsZ6fQ6drAad+rb5r1jj/vASZebtheO558dKsR4P9umjAspdFsDWVz6ol8Q9h4ABLLfGvxJzWXVyMXPsvgJ4RqTua5bOMSMVhYI6XkcxqJJAquAaTO0ifFk52CvXM2I2i2sDP5jLKqIHrEIgp1xRx/sT7inO5fM3rYmvrYJfeHp+DIRlZ3zL83blisQnW3MXaepVdIUooeU7butBSYHeqcVoCxu5T2TuigRWEoL9CaTGLqVzOknUS3SaJHscst8eSH9gqArZUkkRoD7ImrIgANoICjPw1O9mkTqoZ/YpvFm/Uq+/QEJLD6RVkTroA+03iL7tMuIkJ94PthEq/6jBb8DBLQgcjjm+B4a7q96M03+tn4wVezyTQPlNjGHcmUCTNRMLbfwDxVIPsvEBWZhj3yQw+4ykhvYYp5T83W11CUYMGUFoIezmvA/omQeQrSVFZ2tj7COfN1XfuRvclX5YtG8ZszH/25dK+wVvu4XH781hUkUwwhgIMjB3caBH2huG2VgEJmR3J18x0O7KSaTSTwmFd9SEchvhVQBSB4IXMp8997SrNoZNU3ezVrd64pWpX+hXwqpbW32FWhr0n6wq8RuR++yz43FdLmdix1Txd0D4Rn8aqfoTYrhe0JU46hTz4V8A0z944n5wz3PYbO4q2JnUk4mTm41T
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnVaYlNmRU9FVW10VW5zRTRscjhCM29YTXhtb0wwWFBSZmhLWVIxUmxqL011?=
 =?utf-8?B?S01PeE5hd2lWZ1BoMWV4dnhQZUdRQVI5cU5KQU9wT1g4NWVlV2pTU3N6U1N5?=
 =?utf-8?B?UWNqc1FWWTFLSmo3NW9Ia3BEY2FLcmZMeWMyMjhwZ3VxWG5tWFg4di9vZWda?=
 =?utf-8?B?TXlTclRpUzBpVzNSbGNRMTY5NTVGRk9ycVJlblBaT2Exa1Jad2VZY0RwbFIr?=
 =?utf-8?B?enZQMXpvRE1kL1B5aGF5WHN3MC9TU3JFRDVyZldqZFhRNE1qNktibk1qMUha?=
 =?utf-8?B?WjVJQWNKV0xUeXBwTDdvVGViQmwzVnE1RG91c1VyWGE1Si9CUk5MM3VOTWR0?=
 =?utf-8?B?bDFiY1hyMDZIRjRiZG9NWlVSWWF5ZU1zaEs3VURuMDBTODZOSDluYytSTUhR?=
 =?utf-8?B?TTFMK3pwWC83b1E2dW4vL2RrQ1p6YXZoZkpQa3lzazBzTVFrK2NPazNwM1JK?=
 =?utf-8?B?ZEVSaDZ0WURyT3VKRGtaY3dJQXlVZmdFVTQvbHpKbHRzSHU4VXp1N1VvOEQz?=
 =?utf-8?B?QzRUUzdQeHdDcFgyeEdLdjlKNlVRSjhUam5lejAzY1hnRW1paG10ZFBSa1R1?=
 =?utf-8?B?b0UrZkx2aVFZQmFGTEg2eEFjUFdWYk42eTU5VXg1Um0yazczQllqWEtudGxn?=
 =?utf-8?B?ZmZEcVRlUW96TkdDeUEyR2Q5OWkwSVh4WGsrNjF2OUt4VERjWGZJd1JYUi80?=
 =?utf-8?B?OWlManN5Tk5wWE5DdTA0d0xLbmhnSkM4R1RPZklhTlFCRTNqcnFrYWZrbmNR?=
 =?utf-8?B?dTJlcmlIWFRFdENUZWpyVmRPdC9hQ2NXZ1VrT2kvb0pJckxyUXFaRmx2cnV2?=
 =?utf-8?B?ZnM5TDlUblU0UVJuMFhOejc1TGhZQThPODlLUzRCWEwrUUhIRm5FNTZlOGd4?=
 =?utf-8?B?Q3pIL2xlVkw4aXROUE1jcU9SZmVhZ1EyV1FXZGhKdzhla3dTQVpGUnJNQ0cv?=
 =?utf-8?B?OWZvbEpRQmYvZ3U4Q1JyU09SL2RXNjV0Q0R5NnRRM2lKVTd2U2NmdndBMTRX?=
 =?utf-8?B?MVFscTRYYjNOcFZncGJiUFJCOXhtaUxaWEJhSlRsMmlHWlhDNGJPYVJTaVFH?=
 =?utf-8?B?VCtZaUhJVExnR3pZa0E5Tll6Z0dxMWJpS0lGNk14RDZDN3E3ZDV4NDVvZFZL?=
 =?utf-8?B?bE5mS0tLOWNxdnB5L0QydEsxWHB3dG9iT3MvaHhKQVBRbHhmM21kUnFsWTYz?=
 =?utf-8?B?b29WVVV6VmxFVjd5UlJlK1ZBSWFiSHZRYjZ0TXA0UXVRLzd5MTRpSEF6QjVZ?=
 =?utf-8?B?cXFtREsxOEVabUJwQXc0bDNrS0R3Tk5hVEpINmFmblRaMGZJUzF5UVg4Ry8r?=
 =?utf-8?B?SnErV25YaVhJd25QY1ZUVEZQSGtLdStIY3pxQXRYU0t6RGVuemFaRUxMbm1P?=
 =?utf-8?B?ZXpwNHhuSi9MUUx6VGg1Q1p0aTYzU2txTG5YYUFTc2ZpUE83bEpGTkdPVWdG?=
 =?utf-8?B?WE5ZN0U1RzhuaVBFTms1dWN6c1RMVmtyVWV3L2NxYWgyNjMwWHVHWmVSc2pT?=
 =?utf-8?B?WTF1cVdZS0g3cmlHbm9lenFLM0hiSzE4VGlRWVpUOWJGTjEyeHdBK1U3L2E3?=
 =?utf-8?B?OUZGaTVuTzltWmtQTHlIbFFMTTlJenBjc2FNaEt2RlQxRkRRdGRiQTBTWkVt?=
 =?utf-8?B?REQ1UFAxZVY2RU9XSVhqcWdoeGhXVnYwVmsvY2dmV2gwemsxMk5qM3NrREho?=
 =?utf-8?B?aWw4Tnpxenk3U1llYnZwUUtlMzBlck5WeDBYWUdMMTVVNjVEQ2V6d25KSUpH?=
 =?utf-8?B?WW92V3BiOWFIbXorYjhIKys1bEk2TldTeFU2Tmh5bTk2MVNwTmRPck1WWVgz?=
 =?utf-8?B?VDZyMUk0NjZhcS8rNzhET0huUG1KMlpPaGtzT29xNlBUcTg1MlFzNXZjdGVr?=
 =?utf-8?B?Z3FBZ2Fma1FXY0JLYnQ0cm11NXVXNk1XQlQ1amw0MzlNbTYyb1hkVFhZTG9Z?=
 =?utf-8?B?NkFUcGhGODdMcTdtNU9oaWxNZ2M0OGc4SFpNRlQyS3pxWGptcWdocHJieHRZ?=
 =?utf-8?B?RytkNjBWa1ppYWszTmRlWFkvNU1NMHZPQ1h0QUZvRlQ0cUk4amFOZGtneUZD?=
 =?utf-8?B?aUVTSmZWMXRKOWFlQWpTTzlnZWYrTkZCTm9jdGh1L01vZHhiVE9VV1VCTWt3?=
 =?utf-8?B?SXNlNVRSVytlQnd0blIva05SMDB6TDB4ZTAxSDlkdE93RW5kMWpDc3h1cmFX?=
 =?utf-8?B?WnRyK1hhc2RuOHhuSTArNGtiRHd0THFqM3RaelNPZTZVVWhpZXpuS1ZOWUUv?=
 =?utf-8?B?TGd4ZXh1YldDcGtnVStvWUNkWjY2aXZ5LzI5cGRRUDhkdUNqTTNHUkc3cGpV?=
 =?utf-8?B?QUd3YWxYSWRFL2NRaU9vVFFZWTRwRDJEZnBzRjRKRkYwdlZvemVNQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a121e0b4-fc99-4271-0247-08deb8784483
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 03:06:21.9658 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7jh6YVqaaeGyhCa21Q//dchgZZ7bVGYSbs1WMsy9rAMZ+uj1LRLLgths7qjhml8hDFhweTcA2HQWFuimPlztkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6263
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

On 5/18/26 7:55 PM, Eliot Courtney wrote:
> This is unused.
> 
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/vbios.rs | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard

> 
> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
> index ad571b39400d..9cc2f008bbfb 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -2,8 +2,6 @@
>  
>  //! VBIOS extraction and parsing.
>  
> -use core::convert::TryFrom;
> -
>  use kernel::{
>      device,
>      io::Io,
> 

