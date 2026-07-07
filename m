Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C36C43602
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 09:11:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C476410EC0C;
	Tue,  7 Jul 2026 09:11:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M37MhmFr";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012044.outbound.protection.outlook.com
 [40.93.195.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA51F10E477;
 Tue,  7 Jul 2026 09:11:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrGxHrBwJRtGaQ3X9ksx2g/8KTYnSJpcpLxj9qDygGBQK//Yz/W2M5amSDTbYP0JOwDKl7flLuIyWnaGGLNczl1zSHeWrunfp9HuoSen3CatZbGbma+cJwg0TcGRt5+mZs+BrJvTozKKc7ZCVveFmlA8TGG8YyxELMi6X0aE2aYmlikXL8437bMkJGV75JxBdZtcto5NoO5bQWgdqR/puN9VyPbLdj1yJRe7S7Hc98o9hUf7GOT4iHjaTKniEzh5eRHHyWtd+96CZEqcs0xjivf2VAHj2QszDn6MhkFNNpwDMjWllSkLwzWigGimNo6UlR5H0jP+Rs4i7ur9lJNTDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxFYqRvQnTm0HwfSa2fx4RisAUDyGGSuxwL4wVlb3eI=;
 b=nhRBtwlGDymnXhwtZj49IPt6L9NQjF5Fm74kn3vkSpxd6KQEkW1RMuoY2dwa/9VazlRzjQkKhD5ocmR0893+2WkTI/YPrau3cGKYXFUEqwzTLH5ng741ECWF2zH6uFFZeR6G5Q5EfuqhsVSpLX6VMCx24Sd53V/Wl2S6nZwdCwgob37/9p9lKJjL0n+C7EMlmDeA8Bs+ncO/XeA4MRJTW4NbGiEGM87MKFZBj5VW/u+y01y6knm2bMAIwQyzk2mB/XmNlh4gTM+5kM8YzS8GxE/NpRtP3d8AnfnfYvhqBPYb9IDcKFIMbjj5Ccdl4UUkd24YDy1mYcKrbUmNE6AZEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxFYqRvQnTm0HwfSa2fx4RisAUDyGGSuxwL4wVlb3eI=;
 b=M37MhmFrxxxPo7WPv3WfpF9oWFTbE9aaSRkkB8C0/xdpg8C4ybRlM/e6LwsjWcxZSQ59TiTcV/L3v9FNK1Fbe5Y0I60w4L0IdDUWUuCe7zopJoYEGol9Fs+l9NuMJvH0p6D2j5NUhykL0ue8l8ZF7IYSZL4cEq003tRPQJ4ar2Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4044.namprd12.prod.outlook.com (2603:10b6:5:21d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 09:11:08 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 09:11:08 +0000
Message-ID: <c575453f-d798-4745-b67d-4476825dfa64@amd.com>
Date: Tue, 7 Jul 2026 11:11:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/drm_exec: avoid indirect goto
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
To: mikhail.v.gavrilov@gmail.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, peterz@infradead.org, jpoimboe@kernel.org,
 llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 David Airlie <airlied@gmail.com>
References: <20260704084133.122053-1-christian.koenig@amd.com>
Content-Language: en-US
In-Reply-To: <20260704084133.122053-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0169.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4044:EE_
X-MS-Office365-Filtering-Correlation-Id: 75c5041a-40f3-4133-0fa1-08dedc07ae10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|56012099006|18002099003|22082099003|11063799006|921020;
X-Microsoft-Antispam-Message-Info: Gsb3wZgdK/Jdc8Ys4XKJ/CxDXFguLrLVatF9bfZyh9QNMkTfLZYJqYc37/zEBx6GSLNO1MO2oTb+VqNHNmBxlRkXDPkg7bMhmux1IS6T87R6EF9wWYahJDRP6od/8PjjJTsVQOg1K1BY3cSy5BGxXVJ7S+IXtklZS9TBqOcWsKVCkDIF+dfx6oNPubg1Z6d0v0aJldGLeilH8QcCV2PR/joDTpDTjuX0jyv3iKdd1W9P6D04guhs/7wIIB8UpZK08YPZk2w9uAGxwXNZr+7bcH3i2i1CdhgoxLs0AakrxfADiKLn31O1yvLb4dqnboILszzb+PbLP/UgzKsoi4X4gZ9NY4Yr+7NBcI064aIFFMw2Wil3ZTlb5W+aMzXAt61sa3+Dk6LDZIVxQONkZYp9kE+n9wAL+e/NCbR81DCbWg3P+Ej9TSJc/slwH35nLT2qSWi7RGS1q3bqaf15lmXDWuX2RkWCqeR94OA1VwFX+db49Y1+jnv+aYvMSx/GP32A/4BOks3L4S1uZCU6FaEhyptVmNEp3ns17YVSOxXx/NVwDQiTAm/yVhluu/lUn+OAg+3CNUNeouetWVGTUnqCtKxpkxlugjMIQldGUOo0VXK5d3bX720R0B167gLgIF8BsDyFMfg4kT/wIuQbNODus59i/KFyja3q0AfTwICd0xj3gUtwpykVBOOvZmtLaF8upw3T4smXZ1Uf6fQsatKM5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(56012099006)(18002099003)(22082099003)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1NLczh3SDBIWFZiNTJ5NGRUYnVMRUFTL3UvSmJNNVFVcTdxL0hkWWsxVkR1?=
 =?utf-8?B?a21zWFBJNmNVTUJlR3l5TGtIblV6MmNxd1RmNjhqbE0yWEZBUlVGVjQ2MWhZ?=
 =?utf-8?B?RldUSjlFMmI0N0k5dGxkUFc2aDl1Tlk4N2lFMTRLMXZMRTBrbUtPWSt5Nit6?=
 =?utf-8?B?ck10MjJFWk1jWENSOXRrZmUxbXppUm1FM0VjdTRmVVJUbTV3UHRsSHNKWGVM?=
 =?utf-8?B?azkyNXRwY2lLUUw4dVVsWDRRYU54aG1qYWc5UTZ5bnQ2KzhzL0ZzWEJNV2tR?=
 =?utf-8?B?T29GVG9McFNtdzZlUXUyZzJlSi9jbFl2TWtaaGFneW5lSS9zcTEwZjlydlNm?=
 =?utf-8?B?SHlGbVZPUHdvNi9jY292TFkrSHdrQjFycGI3SkVXSzB1eEVwYW5hYW9uMkFt?=
 =?utf-8?B?VDlyT1VCMmlCd3FJQ0JBeVMwSjk3UExka3kxZ3BCckQvZ0NKM1ZaMlAvUWxC?=
 =?utf-8?B?bTRyZ2swNUJMdmdTdU8wSWZEL2dDT0JieWFsbGl3MVVkdHJsRWVtMG1TQlQ1?=
 =?utf-8?B?eDRhUTR5ci8vNnV0SXV4ZTYyZzlIN1U3QkI1MjhyZ2t5NzJXZ2NoOGV3YTdY?=
 =?utf-8?B?OTdmRUtxeHBreTJKcG9sSTlrUkVKL016dU5tclZEdEhYOVZ6ajYreDdickdB?=
 =?utf-8?B?aTFYZ2xKM1pOczkzcTd6MXliWUZwZURRSzVESDlreFloUTJpWXg2NW5ueXhk?=
 =?utf-8?B?SVltcGhHVE5ERFdBVlp4dDczQ0lsUXNzbERWaEF2NW5CckttNkF0dXN0YTRu?=
 =?utf-8?B?cXVHaHBtemZXVkRnVWJ4VTZnN1l2QlhNalRJZSttQXhwU0ZkL3laMWFnQUY5?=
 =?utf-8?B?YkNDNFFFOW1ZTGpvekZNZXZOVVh1a3J6ZTFWQnNtTlJCbmphbW5FczRVTlgz?=
 =?utf-8?B?VVpLVzNENlFmb0V2ekoxaDBlL3YyR0pwdGdXZWl0Q0ZuUXNHQmxZcHBIN1ZH?=
 =?utf-8?B?SkNpY0F6OWFTNFc0UE5DN2hpRGwrTWU2VlgzVW05dDM3c1VIRWR2cm5YNkdl?=
 =?utf-8?B?VHIwZHI3Zy9PQ1Y1OEJlcTFKenJ0YmlHTS9reVo5N29MTU1XZUN0MGxnZ1Q1?=
 =?utf-8?B?cnhML3hnUllCaEgrekRJcHN4YlQxOGk2dE5NNm9DVlJObTJFNnpYU2g4cGVl?=
 =?utf-8?B?ZmFwRTVTODBNb1Yra0pZcXdCQlI5R1NkVU5YMHJjZlRBQ21pSE1nbm5XN0Fz?=
 =?utf-8?B?ejVMM2UrY25ZalM4dkdJQXNXQVpNNDhORXNZcnpqL0Q4RFFrOTdYZEVXV29M?=
 =?utf-8?B?eTZJOFd1WEdtc2o0MUxFZW1tbGtzMjFoSTBBeVBDb0dMOE5DSnNwTnVHYlVr?=
 =?utf-8?B?eS9oTlE0bzlGWHp0Smx5bzZsNkRqR0ZLbGkwMnRvWkNvZXJWV3NocWIrNjBp?=
 =?utf-8?B?L2N1dVBPbW9LejZOQVkzOGpXRWR4RnNHYUZVSzZpNVQ3SkM0SXpRdjNJOERr?=
 =?utf-8?B?Z3gyK2owTXBrMDR2Q28rcU95SVptbTFJVEVoOWNiaDhqWWdxZkVCSllld3E3?=
 =?utf-8?B?M2R3NjZjWndhVDJ2Wkxodjg4d0YrK3dzMCtjS3dMY2NZemlrOVJ0alhvaitH?=
 =?utf-8?B?WEhzUG9KUkRvMkIxOFJadkczNHlXQVdNOUtSQUJXOGZsU09HQ1plNU0xODZp?=
 =?utf-8?B?ZmUxbmlab3Nha05SQjZYellkcGRKRzVSalFGK1BZL0VxNFFtcGhjcWRoeWlj?=
 =?utf-8?B?OHF3dWg5NG1DelA2WUdIUm5nWUxvNFlCUkh1dDRrZU13VzAxWlU5aDBFNFZz?=
 =?utf-8?B?dFBLVTBrUTc0Z2MwdjVVVmVKcG9FdW1YOFMxQlJZRzl2NFdSaC9Nazc5QWts?=
 =?utf-8?B?b0JJU21neWRheHNWV2l2TTdkUmVnUnVQK0ZMNWZjWDcyRHBSUTI2UHllNGVr?=
 =?utf-8?B?eHFJZDJoZFVDVGZKT3M2ZEVyZ0cyME0rL3ZxdWo0NmdPU3F0Q09oNjhlb2Vx?=
 =?utf-8?B?SVc0dnZnaGZOUjdFQzk0cERCYU5UckM3ZWFOZVczUjhlNmsxQnNCQ2EwZjU0?=
 =?utf-8?B?SVNJNW1GYS9hVnpIcDFqd25CSGZ6WVgyci8wcnNCaEZTS3d4NHRNN3pNMXVI?=
 =?utf-8?B?QkJXRGRnajdUV1Y4WWttdVlISmwvdWNTU1J5cnJOdjU1Zk1wMkovK3hOdEJF?=
 =?utf-8?B?U3h4YWJzNE1RRG1UengreDdUWWRKUWJjTUxQTzU3ck42ekc4ZVRFTzZFWlRp?=
 =?utf-8?B?V2NqbmorVzNCSW9Rc3hSNDdEZUlWY3VMMmFnTVd6YmgyS2QxcXJ4bE10QTJL?=
 =?utf-8?B?M0NDaVdCR241R2VlYk02aVF0c2dMWk1UaHd0cE12NlhQbnh6dktVVFQwNDd3?=
 =?utf-8?Q?2P7anBssBx2BxlqGat?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c5041a-40f3-4133-0fa1-08dedc07ae10
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 09:11:07.9790 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fp/z+wgZQkI9Dgtg3tvP0SOYy7RaXDTjXgnPCXPEy7qEp8lVADXYzCzlgEuabDm1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4044
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

Adding a few more people to comment and review.

Thanks Mike for the pointers, going to add them to the patch before pushing it to drm-misc-fixes.

@Thomas, Maxime, Simona, Dave can anybody give me an rb or comment?

Thanks,
Christian.

On 7/4/26 10:41, Christian König wrote:
> The drm_exec component uses a variable with scope limited to the for() and
> an indirect goto to allow instantiating multiple macros in the same
> function.
> 
> This unfortunately doesn't work well with certain compilers when the
> indirect goto can't be lowered to a direct jump.
> 
> Switch the indirect goto to a direct goto, the drawback is that we now
> can't use the dma_exec_until_all_locked() macro in the same function
> multiple times.
> 
> The is currently only one user of this and only as a hacky workaround
> which is about to be removed.
> 
> So document that the __label__ statement should be used when the macro is
> used multiple times and fix the tests and the only use case where that is
> necessary.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |  2 ++
>  drivers/gpu/drm/tests/drm_exec_test.c  | 24 ++++++++++++------
>  include/drm/drm_exec.h                 | 34 ++++++++++++++------------
>  3 files changed, 36 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index fee4c94c2585..fc28d0fdad37 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -3011,6 +3011,8 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>  	is_compute_context = vm->is_compute_context;
>  
>  	if (is_compute_context) {
> +		__label__ drm_exec_retry;
> +
>  		/* Release the root PD lock since svm_range_restore_pages
>  		 * might try to take it.
>  		 * TODO: rework svm_range_restore_pages so that this isn't
> diff --git a/drivers/gpu/drm/tests/drm_exec_test.c b/drivers/gpu/drm/tests/drm_exec_test.c
> index 2fc47f3b463b..7a374e462348 100644
> --- a/drivers/gpu/drm/tests/drm_exec_test.c
> +++ b/drivers/gpu/drm/tests/drm_exec_test.c
> @@ -180,19 +180,27 @@ static void test_multiple_loops(struct kunit *test)
>  {
>  	struct drm_exec exec;
>  
> -	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
> -	drm_exec_until_all_locked(&exec)
>  	{
> -		break;
> +		__label__ drm_exec_retry;
> +
> +		drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
> +		drm_exec_until_all_locked(&exec)
> +		{
> +			break;
> +		}
> +		drm_exec_fini(&exec);
>  	}
> -	drm_exec_fini(&exec);
>  
> -	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
> -	drm_exec_until_all_locked(&exec)
>  	{
> -		break;
> +		__label__ drm_exec_retry;
> +
> +		drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
> +		drm_exec_until_all_locked(&exec)
> +		{
> +			break;
> +		}
> +		drm_exec_fini(&exec);
>  	}
> -	drm_exec_fini(&exec);
>  	KUNIT_SUCCEED(test);
>  }
>  
> diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h
> index 8725ba92ff91..cc2937185a9f 100644
> --- a/include/drm/drm_exec.h
> +++ b/include/drm/drm_exec.h
> @@ -101,17 +101,6 @@ drm_exec_obj(struct drm_exec *exec, unsigned long index)
>  #define drm_exec_for_each_locked_object_reverse(exec, obj)		\
>  	__drm_exec_for_each_locked_object_reverse(exec, obj, __UNIQUE_ID(drm_exec))
>  
> -/*
> - * Helper to drm_exec_until_all_locked(). Don't use directly.
> - *
> - * Since labels can't be defined local to the loop's body we use a jump pointer
> - * to make sure that the retry is only used from within the loop's body.
> - */
> -#define __drm_exec_until_all_locked(exec, _label)			 \
> -_label:									 \
> -	for (void *const __maybe_unused __drm_exec_retry_ptr = &&_label; \
> -	     drm_exec_cleanup(exec);)
> -
>  /**
>   * drm_exec_until_all_locked - loop until all GEM objects are locked
>   * @exec: drm_exec object
> @@ -119,9 +108,18 @@ _label:									 \
>   * Core functionality of the drm_exec object. Loops until all GEM objects are
>   * locked and no more contention exists. At the beginning of the loop it is
>   * guaranteed that no GEM object is locked.
> + *
> + * A global label name drm_exec_retry is used, if you need to use more than one
> + * instance of this macro in the same function the label needs to be made local
> + * to the block with the __label__ keyword.
>   */
>  #define drm_exec_until_all_locked(exec)					\
> -	__drm_exec_until_all_locked(exec, __UNIQUE_ID(drm_exec))
> +	for (bool const __maybe_unused __drm_exec_loop = false;		\
> +	     drm_exec_cleanup(exec);)					\
> +		if (false) {						\
> +drm_exec_retry: __maybe_unused;						\
> +			continue;					\
> +		} else
>  
>  /**
>   * drm_exec_retry_on_contention - restart the loop to grap all locks
> @@ -129,12 +127,14 @@ _label:									 \
>   *
>   * Control flow helper to continue when a contention was detected and we need to
>   * clean up and re-start the loop to prepare all GEM objects.
> + * The __drm_exec_loop check exists to prevent usage outside of an
> + * drm_exec_until_all_locked() loop.
>   */
>  #define drm_exec_retry_on_contention(exec)			\
>  	do {							\
>  		if (unlikely(drm_exec_is_contended(exec)))	\
> -			goto *__drm_exec_retry_ptr;		\
> -	} while (0)
> +			goto drm_exec_retry;			\
> +	} while (__drm_exec_loop)
>  
>  /**
>   * drm_exec_is_contended - check for contention
> @@ -154,12 +154,14 @@ static inline bool drm_exec_is_contended(struct drm_exec *exec)
>   *
>   * Unconditionally retry the loop to lock all objects. For consistency,
>   * the exec object needs to be newly initialized.
> + * The __drm_exec_loop check exists to prevent usage outside of an
> + * drm_exec_until_all_locked() loop.
>   */
>  #define drm_exec_retry(_exec)					\
>  	do {							\
>  		WARN_ON((_exec)->contended != DRM_EXEC_DUMMY);	\
> -		goto *__drm_exec_retry_ptr;			\
> -	} while (0)
> +		goto drm_exec_retry;				\
> +	} while (__drm_exec_loop)
>  
>  /**
>   * drm_exec_ticket - return the ww_acquire_ctx for this exec context

