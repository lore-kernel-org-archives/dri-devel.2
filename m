Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94F2FF60ED
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 08:51:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1607010E1C2;
	Tue, 31 Mar 2026 08:51:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="U1bDJT63";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010049.outbound.protection.outlook.com
 [40.93.198.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3DBF10E8E2
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 08:51:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ArfnFvbxxp+D6llzbgeiSrUXdRxKUolDD2FiJ/mMucB42rF6crZDzsEulD4yvdji8VNsTGetyfH7vCcGKBHO7hDJTx4rCP1u5t6iUNhuaDveYNPPmEL8t4sjtEmTvqzJkmW8nmP2YrbOyAvNT/JrUQ1uD7bVhcL8D26wLgiQN58a5S/u+bpy3A3IcMTEnB1NlG3bPvwMnEned6moKtZmTHiB0jBciw5kear9wJjVfznLwCcO3RGwSW1ca/m3wWGSVW6WLIBybX2VDrvFc+kRx6VeMZsMxrTD7K+s43hiLw/DkFvC5Gtal51azpHZICJLzIsLUqueEuHDt5L/K76SZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynem5a0wRYzFxDjYh0aXjXDg69SxX9j+hhlyB7/OIXY=;
 b=fvNAcYivcg4wOXKcEacqtXs9xwiDRBSRqn4FsT0w2ZNL8PhXNWH0ihDJWI0QmrzUf4FI3Xt99PryfTyXkJRGmtFFykXC+YwQgXZzdd00qYeoup0dSZ42kNuREH15loGyIaVVbb8PJ7n6r/h6ry4EUuxyI/ebpeuPiDNbzkT0BKFtB+4EOoc48OT/9uEU06nLHLBEFLPpnGoVFbE6UOjadICorlojCX5lRMcDAcyACnClgYNY8dZrutLwv8vEOWJ1YLshSl/JO1AfwwP4/tOPCFvnOHJINNpqeYW8dfLHhNmS5DCOnMTpowGBF5RQ/i0DDD38Z6LB8dp+CslWaoiOGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynem5a0wRYzFxDjYh0aXjXDg69SxX9j+hhlyB7/OIXY=;
 b=U1bDJT63uxe3nGlMrQUnyd28cj2vc6lv2H5uSLoylnNPBnp9QiZg0SAMUaDZvQFInMGZk6q0C7AwievDJZ2rmnYP0EDrjVFf9WFr7svazn0lzzJj9FF7Esv8lXlmljiJ2Usfz9N+1cutT5XvFuzrbIdqMo1wK/qFPtyNcyIs0LevtmEEg48j/QvAi+budE1tWSYAUWk1k8EtSFOZZibJlXNVbNCel981b1efjf5dns56Rr7BGg9O5OpmRrrCaAmlApahHw0DBZ0LW83WJRGaIyqnZoBLb8AwW30enkVbkGCuzo+sHtuZX+FZPgCiBjLUIiYwvOqJmstKrY3sqkrbWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by SA1PR12MB999228.namprd12.prod.outlook.com (2603:10b6:806:4db::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 08:51:11 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::2920:e6d9:4461:e2b4]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::2920:e6d9:4461:e2b4%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 08:51:11 +0000
Message-ID: <9426cc7d-bf27-4be8-afe6-7c123324655d@nvidia.com>
Date: Tue, 31 Mar 2026 19:51:05 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] selftests/mm: hmm-tests: don't hardcode THP size to
 2MB
To: Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org
Cc: zenghui.yu@linux.dev, Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
 david@kernel.org, jgg@ziepe.ca, leon@kernel.org,
 linux-kernel@vger.kernel.org, ljs@kernel.org, mhocko@suse.com,
 rppt@kernel.org, surenb@google.com, vbabka@kernel.org,
 dri-devel@lists.freedesktop.org
References: <20260331063445.3551404-1-apopple@nvidia.com>
 <20260331063445.3551404-3-apopple@nvidia.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <20260331063445.3551404-3-apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::20) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|SA1PR12MB999228:EE_
X-MS-Office365-Filtering-Correlation-Id: d4c2e789-10a4-44c2-47eb-08de8f02a875
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|13003099007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: AFrjbt45PydaM+Nmnf9kWTr4wOmwXxbFgmzyLS3IM1yRk/q+c4dc7EksIChUWRlmYoFQgp+fQhBRCiucR4HvIV22m1faIZf8fe0oj9o7cTTDtNBA3+DrcEGmWp6bT4kYUaW3p7r6BV1kpnygTlEwtzvmY+E1V0STdin5JhV+sSK8GNVj0uzVRyJoGArvutsqyYYB6x7IZMmulPv7ZRns++z1yOnmDSAjGqu9MEkC3pxD+M9vH+i+NSMFckhObMgjfqTtutczEVv+5sy3qAUp7zdbbjqgaNSVghQrot2tZVxwCucTdVtCShNfxYc5nKF2Q2j66XZ4IBlsjPOPXQufMYTDmhV2Mvae9WtryZVPxRkJjj2ZeuuS+rPCPKWsurDxeQ2O5uIYXvrJOEY4RTZclPJUpb7uAwwLYTU2+k3obPuRPPj9N1VImUO6tcV/dKiMTQHr7BBeprDYI8uPlYsdxbqGhhrtd8GV76cfDwe/9+ZZ6ZAT06cMCT1bQXWxwCMdbV2DR3qwsnG1V9IJ+sho6d9Pfc0OO3c+jvLV5YU+Yoz/OQHebMUste5sKODVDPhNUIVnhETOKA+ILN3QmniJAfClFbo7vzw4L+UL1aE4j40hbhB9LKpE6Yvvs/Pf7GukCrNEJQhMjxODLPZ24H1kBaTALQChlIMPXL/4zPx/xyXzRxPv/AF2Hon3xWQc+QmHMeUry4B2OY0ZFNmJIq8Go3dluVMfxtiOO598v0WLvG+FTwektBj+eK30gqAdcpd1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7277.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(13003099007)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXJ4R2lPM2ZuMlJYRko5RVF0YkppeVdnTERsTDVYdzNCZ3B3TDJPWngzUklL?=
 =?utf-8?B?S3kvOHB0QXN5U1B6bkh5SGwwSlNlb0M4WkY5UmoyZlJSVW9CcUltdVhnV2E2?=
 =?utf-8?B?OHJkSEFiSWkvRmJZcGVNSjNPSkZ1SXA3eFdwV3NyWDRlazBTM2ZmaElXQXhB?=
 =?utf-8?B?SmwzekR2ZjRBUmwvVTNtZzRab3VLMDJ1N3lzd2VrdHN5RTZwc0lwQ0RNckRF?=
 =?utf-8?B?V2FXQWhxNC8vV2p2OXBES2sxSG9xdFRsazdHUTRBKzFvZ1ZRY01BNmJLQWxx?=
 =?utf-8?B?ZHhrRWFsMnJ4OWdwbU01b0xFYXNVcDVuZC9oRTVhS3hTazRmSHI4TVJ1Smlv?=
 =?utf-8?B?QTlQUVRvOFhjdndBbFFiZ1oxaGYvWlRMY0Y5VDVydmlWV2NScHNOa2RtMmZU?=
 =?utf-8?B?YkQ3YzB3STdWd1dYRFhXVXpTV2swM2hpdkxaK2JVcHZjQlZmZHRURGlDVzhK?=
 =?utf-8?B?ZHp6cENxRWdKRW4xK25wU3BkbXFrTFBZdW96QWN6NVlYUEIyL2FjUWNOVENv?=
 =?utf-8?B?aG0xOGVXQlZjRHl1Z2d2Y3Bway9nOWIrbW9XY1dXSnVhdUhCOTJnS3ZzcGlu?=
 =?utf-8?B?Rk9DaFdmZUZqZ28yK0tXSUNJRDB4eGJKWnNtWXY4dnYvejl5elcrc2NSemI1?=
 =?utf-8?B?WXlDZ1RyYVVoRGEzRkVlbTZIaHJCeHFMdWVKaFZVUUNUcFE4aEhyQXZCMSs5?=
 =?utf-8?B?cUtQWUplR2orYnRnTC9WRHpsSXZCb3ZKdENNZ0o4aWxoK25aUWxGYisvSTFT?=
 =?utf-8?B?M3BRL0x1bUw0M2oyaEdoNmhyRnNPeFlhS3c2dVZyY2pyc2VTelFKc1FJV3RC?=
 =?utf-8?B?WERUOWZGNWtpZHpiTGw1VjZ4NnVKTTFRVWFiL0Nza1c0cEtVL1Uwa1UvTlZm?=
 =?utf-8?B?ZG5acTJkZnJjQkFzUzFuVHhaWWROR0NsaElOV2JCdGJYcDlNWGZnRW5VbXln?=
 =?utf-8?B?RzlCSFJsaFFSRXlVME8vdUg4NlVGZGxqRVZSaVNTdTlKUVpnQmhxS2JFRHhU?=
 =?utf-8?B?eGd0bGt3RUoyVlozaERJS0tyNTZoZ1YvVDJyUDhnL3F1VnRnNVl5ZVJnU3dO?=
 =?utf-8?B?UStSMWJIMVJWazZPTGtScUxwUmRuLzJzeWkwTnEva1hXNnhYaUozRzNLTkpr?=
 =?utf-8?B?ZlplOWdDVTM5WU0zQ0NCc1laZkZZRTJhMFhjdkEzMHhYODFOcTI4cDBWVWpi?=
 =?utf-8?B?a1JTTzNCbTd1YnJ0emdSYlF2RG5QZ0NyUkFGT0MzSk05MXVsYlNORUxybkdO?=
 =?utf-8?B?dHJNaDIwREJoOUlVbHh5d0l6S3dGUmE1eVczMVpmR1JTcnZCSzIzNStkcmoz?=
 =?utf-8?B?V1JxR3c1REh6cjdKOWo0TTVPLzhvOERlMUtoZnFlQXZuOXpXdTBRaXBEL0Jk?=
 =?utf-8?B?WjJkNFJIeCtYcUMyamdnL1Jla21HcUZaTnJCSE4yMjVGaW9vN1JGb2dwbVpq?=
 =?utf-8?B?OXAzQzIxTTJ1MGkyc09XNmM4QUhTdWdRVGtTaHkvTnFhS1JXZHF2NmdaSWp3?=
 =?utf-8?B?V3JjZ1dwQi9mYXVUK0VaRjBlTmFLOExaMU43RGk5TkZaVGJVMDg0V1RONWpt?=
 =?utf-8?B?WGFKeHVsMnRmb0IvTDZSalk2aUdyaFN6V0lYQklUNkxHODU2ellJb2czVUs3?=
 =?utf-8?B?TDlQQ1RwU1gwdEo4V2RENmZwb1Jub1g4RU14Z1p2VFE1MktrMndnekhicXRR?=
 =?utf-8?B?MWhCTHlENVQ3a0VoN2hUSlJGSStKV3lKNXpPTnRkZFBGeHlZcDdZQ0xyZE4r?=
 =?utf-8?B?ZEhkVWZ1cFB5bzF6bzBUZFovVnpVZGczUDhRTjBIMTd3NGRSWm05YWFBUUhE?=
 =?utf-8?B?cFdKd1A3cXBSalFhY2VqK0liT2kvcTgydERmYVFBOWpRVERsRktNMm5uUm8z?=
 =?utf-8?B?Z3VIMm02RjBselQrTmQ4ZEJsVVN3VEI2M2NPQXNMRGVrdkxrYnVUVmdQc0VV?=
 =?utf-8?B?WGt1WUNqYkZmTVpXajkwM240bTRLcGJsaUhkWm9lQ1p3QjlzZmZ4cUJqVTdS?=
 =?utf-8?B?RlFJWGUwR2FSaXlxTDBZbVlYS0ZsclZtLzJYTHhqOGNRL1BnN1oydFg1L1l4?=
 =?utf-8?B?QWMyK0kxMGU3Y3oreWlVdzdkbVpFaXVDbzVNV0cxK01mTkx5TWJhUW9ZdXAy?=
 =?utf-8?B?QWkyLzN4alB6aUZ3dFhCUHY3eHpQb2NscTNYRUxXOTVMVkNVdW1OYmp4YXZ0?=
 =?utf-8?B?VGxYbkY2YmV3RlUxMVJUa05zbjhYZGQ3dURKS3NueEpmWFIzY3d1emlqSnFD?=
 =?utf-8?B?TmprdDFHc1R1S0hDdHBiUjJ5VzNYd2RpTmZPSHgzMTE2ZGs3L0tKVHh2UStM?=
 =?utf-8?B?U1A4WlpGWVdrc2JERWhGbnltNWt6K1U5cTJwOXBVbTN1YUc2V2xrdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c2e789-10a4-44c2-47eb-08de8f02a875
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 08:51:11.3614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0/lFJcw9StwfOtu8o+sLdv1fF8eJXy4O6HUqJAM6cxyPqyuvZdZr+Seb2aIuCWBXep4T+Q+7garCjuwNhdOLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999228
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

On 3/31/26 17:34, Alistair Popple wrote:
> Several HMM tests hardcode TWOMEG as the THP size. This is wrong on
> architectures where the PMD size is not 2MB such as arm64 with 64K base
> pages where THP is 512MB. Fix this by using read_pmd_pagesize() from
> vm_util instead.
> 
> While here also replace the custom file_read_ulong() helper used to
> parse the default hugetlbfs page size from /proc/meminfo with the
> existing default_huge_page_size() from vm_util.
> 
> [1] https://lore.kernel.org/linux-mm/8bd0396a-8997-4d2e-a13f-5aac033083d7@linux.dev/
> 
> Fixes: fee9f6d1b8df ("mm/hmm/test: add selftests for HMM")
> Fixes: 519071529d2a ("selftests/mm/hmm-tests: new tests for zone device THP migration")
> Reported-by: Zenghui Yu <zenghui.yu@linux.dev>
> Closes: https://lore.kernel.org/linux-mm/8bd0396a-8997-4d2e-a13f-5aac033083d7@linux.dev/
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  tools/testing/selftests/mm/hmm-tests.c | 83 +++++---------------------
>  1 file changed, 16 insertions(+), 67 deletions(-)
> 

Reviewed-by: Balbir Singh <balbirs@nvidia.com>
