Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B60CCD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 06:17:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23C0310E1CB;
	Mon, 15 Jun 2026 06:17:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nknlZJ6S";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012048.outbound.protection.outlook.com [52.101.53.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BF9010E1CB;
 Mon, 15 Jun 2026 06:17:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OOKs2vFy9EzGkX8otBsRwKZZNEbzLnrOW5mVJdJFMOK/KmL75mZCW5RshrToTXl/8mFnQQICOfTXoby2eUjTwHvFkR2q5uXIjbbdeaDrdiqejGKxFp5NGv1rdTRsfaQiDVfUqyFA8be+qFWFftnZvAKMty1TrenBOXU2c8Nd8GmfNleKhv4dYiHbkKJyoHvP1q3RwvLhEXZ8kAyAhmD7TVVo7j1+QELsFC4xr6+Zk0XIsExEWHUKvDr+gPeHOaNFNSYs2JYtZcPZkqkKOnnFsIOF4jC/9JnL2bADqveOfmJivM7rsHAvA7vGa28hl2B2D73W6S+56r7S2HDDIIr6AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CldNMYVqI53c2tQhOkQXnmr3DheOwEHk4gVakSqdekE=;
 b=ELCGZpRWgbmE8/AyE2PxpmZ6WpfC1MMlp5tA0JPrJMT1B2X5231Q3+cPbFKcGGYPP7nEGZBofHT3JxoqUoBKTdpZBk52b3W0k162dzphIAcmvWkrrdNkjesYeRnEuGC7FIo2rYC4ZOfPXbrTLEG2qtP1o59h6hphiJCJ+y4y9k0SHXfElIvJvDQxdYbBx+Zj0UQ8vwOU3Y6w/M99ANs/6kfAEjgFCyLWfWXRK+tsmNvBHJoaNgELHy5Up2IzLMXRjz13G7CVBQm1ZcgLYG/Qd+awt383UG1tmtmfckz7Q/kDwoLuF5ItOG15QRG8HbDEuVnJy1i4ovoMmVVsZAgcfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CldNMYVqI53c2tQhOkQXnmr3DheOwEHk4gVakSqdekE=;
 b=nknlZJ6SPP648Po5GnKTjQwNm2SHfwav4L/8uKC40Vm0uTEwJd30bcCnldV8KX/IG2GicYZcxujvuMyj82zKrAYCr9/FI/jWISQxK0hSM3UxS5Qscv0a8aowM+z35YZ+KY7NNXrpOVj7MaCE98A9tLQdtSxsx9CaGiBwDxGZErk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by DS0PR12MB7702.namprd12.prod.outlook.com (2603:10b6:8:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 06:17:02 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.21.0113.013; Mon, 15 Jun 2026
 06:17:01 +0000
Message-ID: <830db864-f66d-41d2-8365-3099b97e8d71@amd.com>
Date: Mon, 15 Jun 2026 14:16:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/18] drm/amdgpu: implement SVM attribute
 set/get/clear operations
From: "Huang, Honglei" <honghuan@amd.com>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>
Cc: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Jenny Liu <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>,
 Yiru Ma <yiru.ma@amd.com>, Simona Vetter <simona@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260612090928.29682-1-ray.huang@amd.com>
 <20260612090928.29682-6-ray.huang@amd.com>
 <32a43737-d2cc-4b8a-9f9e-6b7d0fdabf67@amd.com>
 <3a1ee25e-8fbf-420f-9940-cd3ba487a241@amd.com>
Content-Language: en-US
In-Reply-To: <3a1ee25e-8fbf-420f-9940-cd3ba487a241@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SL2P216CA0090.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2::23) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|DS0PR12MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: c8750ca5-6079-446b-7757-08decaa5b646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: t/4kPAvpwLTfd66pTyivKU57TCWE40iRLrvJK4XkAtH5zUltvl5gJ1sDiRALjeAke1mT5vQGr70ahhOE6wrJUxUHi4GdFxLTh6c0vs6lwoZh298CCNhYxqi/2HAyNNw3BklG8bUgwCLQaOHihKCgeTzvEHQf5g6ySbrZ2Z7lsj8KkY+qHklYPAIgejlfPuVdpyVpbt1GNIRlOET2N+qJqZ1gGpGz5SGgeWjSS1n+OZ2akb1+zNRW8Q8D32LNvQm1TIXi3I5DhLoKCImq8b7ovnmj46OsJbDiFKMQPZ9yM7UbbjSpX8yWErRYIPlS9A7QWhKFgD0Glv4Coo9x7iPHGxtgJHRoHoI468LBUlrTj5d7d0jvXIoRFAtoalg6UXw8F7zQl0/Bv8BrKQdtG9R4cA/itSjNejOOrygtAjfeQ92lQ8e06pV7u7vgeavC1s3ZNzHndzJGiFm1ub1Mxdy+FzqXs9eLbAPTTRrU/mZLr5b4PAymhXvijzOSCU6IRofn/mUDtDuRCK9WmhpQWiKvKQ2FJBayKhjG6G1EXCsZQGzL6cYmltFGL40Cn+b60reuVNLP/WJxPbSprOfnEzjpwyxjRlPLUA7Ep7jfCbV/rLL7Hi471V2Ld17bO76wHx9vnQWpxjlcXN0E9H8jsfV8D8Ab6P4jk8Dm1MlKkr69p7pXz9koFJj9P82z/AKb++WZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmZNUTFUbkdJUWVFNWFkV054UENNMVlnWGhsZjVqWFhMTTRSbmxFZWUrMTBy?=
 =?utf-8?B?V3NZRmttTTJERjZWbGQ4SUp4MzhHZ3BaY0dlSnhPd2dvQkRkdU1GU1pzK2p4?=
 =?utf-8?B?cjlPVXluSk5pS3pQNytWWXFBbHljOGFHZGp6SnRyNHlEdzUzbFVzWVl1UWhx?=
 =?utf-8?B?TWlLMnJxcUk1QWRmbHo1eFVucitXdUl3TFZlODhiNFV4YWlRbHlpeGxuODV2?=
 =?utf-8?B?NDhUd3JCMXJsS01aVXdDd1B5dlVBNVQzWFFMbzJVbEZnQUcrNDlmcHVDMmVR?=
 =?utf-8?B?UmNmT3RKNS9kSmliRzVtTzJFa2tOQm5LbmhJYUxTeTc0L0c4MEpNQlZlVEpi?=
 =?utf-8?B?bWtiaVRNYUY5cUpqa1pvcnJCRlFpcHlLM05kQkFEc2ZjTUgzVzlFUFdvaGVF?=
 =?utf-8?B?alExZ1dTMWlmS2plYmN0YVFlUzBjZG1meThJUm9QQmUzUjVvSzZUMjBBNC9L?=
 =?utf-8?B?cFBrOVo2WjVNYkllV3NlbStHNzVTYUg1WEdsdHBzeE5NMUxtazNmUU92NUVQ?=
 =?utf-8?B?WnFDR0NOY2Z1TWJxUFo5SWVuTUVpTHo0bzIwN29yVENVZmxrK3RwTjJIaXNu?=
 =?utf-8?B?SUNHaFhnNkR2NEQ1SVN2Y2hQQnFjcFBZeFkrL1lQeG5JbnF0NmkrWGViZGJF?=
 =?utf-8?B?ak9ROWhET1VVOTVGQUI1ZmNVNEgxRnFIUG5pRThCZmxsbEJGNDlCdzNPalR6?=
 =?utf-8?B?SEZwOEJYWU5PNHRzM25BOEthbDhJWU50RVcrQUpSb1o2UCtKYUZmZXY3cDEx?=
 =?utf-8?B?S2oxZmFZcTFUSWtsUXdBYXltbnZEY0U5M2NLNFR0LzZMZG43L3lrRW1TVk9k?=
 =?utf-8?B?eEYwR1JPOVF1RHI3QVMzVTAvNXkzMno4bjhEU2FZK3R1M1FTU2o3TDN5UjMx?=
 =?utf-8?B?cG1uZzMxczJ1azVaWHNEbDQwM2d3bC9DOGg3dmV2eFhteVNwVE9sUGlRbEE3?=
 =?utf-8?B?ZnpQaXRlRE15UjdNMld5aTlWSHh2b0xhcmQ1OHZsQldKMjhSZWZ6SXhha01r?=
 =?utf-8?B?V25NQ1A5aUh4ampmdDl4WDhaay9SZjhkZFlrRTAxUU5Gbjg4SEhzMHN4RHdx?=
 =?utf-8?B?TEExb201M0IyZEQvYzlBNHFreXhEb2s5Mkllbmx2RWVzMVhMV1BaZzB0Ullo?=
 =?utf-8?B?cnVnN1h2NU0ycVBvSFYxb2g3TWNYSGhNbmtMd3M0TjBkL1c1TWJrdThzL0ty?=
 =?utf-8?B?RFY1YVdPajV0TUovcDJzeXloL29Kc2hmVTY1TjBkdHBzMW1UKzBWMDJqNzF1?=
 =?utf-8?B?d0pJaU5CaktsYUQwc09oSGN1OGhES2xFUE5oWTh1QitOb1BtRkoyUGdTWjdr?=
 =?utf-8?B?eE9hSzFaOWZCSWpnSUlrUHFJV0RGeDJUMWRtaHJwOWhJM3ZxNjBISFNSeTQ5?=
 =?utf-8?B?cUo2bUVRWitqYkFTVXlCU3hXUTNYQ0E3VVAvWWd2S0JDUnY2bUV3M0t6Wi9X?=
 =?utf-8?B?NmorN1JLV1FvZUpXUnNINjBXME9WcjU1dTdHcUNLck41a2xEMXZudzBnLzEx?=
 =?utf-8?B?aXFpVTMvdGRMVlM1OXErdXZVN0hQTXFDeVNYYVJOQ1pWN08yanFwVFNrcVFL?=
 =?utf-8?B?V3hvclVnNHU2WUd5VEJ6OHo1cWFhaTNydTlCRmQ4anM2eGdYWlpwVmRBVjRt?=
 =?utf-8?B?M2hxK1JLMVJueElwOWdHakdRaFo2djh5RVFLdVZmaDZ4bWNDZzBDVW1QUFlH?=
 =?utf-8?B?S0lOT3dab1hFUXM5dTJXelVENGc3empvSmNiV3NrajYxeU5Fb0p1TkoxLzNR?=
 =?utf-8?B?Q1JUSG5aUHlURlhrVVZSTkV5MUlHWXVuWU5FV3dhV2dNQS9vWmJMZWhQejlz?=
 =?utf-8?B?ZGFUaGU5UDJrWXd6WTc4Mmo2YXpWYzBxUWxlVDROQi9JR2E0WkhMbUl5YzNL?=
 =?utf-8?B?SlVZQWNMOEN2aFR6TElDRDlWR2lsTUpYbnhkckc5elRyem8wZ0FSVWVIVmVl?=
 =?utf-8?B?UmorSjhRU1F6MWVWdWpIKzdCWjR4UkRRakFvQ3lQdWlSMzh3TXFBSjRPbHhU?=
 =?utf-8?B?QytybythSE9hWWxhblZBL1pCc1k5ZFBmbDk5bmhVRWN2Z2pURjg4eHltaFNl?=
 =?utf-8?B?cGYzQXQxM3drenNic1VTNlpBZHFlOWpJVWM2TXBzcUtLT2s3eUN6dCtHTUJT?=
 =?utf-8?B?cEZKZEdpZkZyVjdtb3ZwY0ViekVYakEzMitocnhQdzdXb2x3dzVWbTl3blVq?=
 =?utf-8?B?ekJLWDFvUmZZSUtXbzB1cGdlSEo1bjM1a1N2aDhzdVdRclhOcUdZUWpKQWVw?=
 =?utf-8?B?ajlnVUh5RllLVVB6MXpTaHptOUtxamxsN3FBaVY0KzR4Qjd6czZoNjFXKzVk?=
 =?utf-8?Q?5v9inyEJJfqjhlgy02?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8750ca5-6079-446b-7757-08decaa5b646
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 06:17:01.4028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cy53C2RMPtRJbH++NfJB3SvBKoxXghswMjvYbERJwoaI2IJ0yfHsqv+kDeRICzHlim3cfudOsmmT7+Nd4ulzfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7702
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



On 6/12/2026 10:38 PM, Huang, Honglei wrote:
>>> +static int
>>> +amdgpu_svm_attr_validate_range_vma(struct amdgpu_svm_attr_tree 
>>> *attr_tree,
>>> +                   unsigned long start_page,
>>> +                   unsigned long last_page)
>>> +{
>>> +    struct vm_area_struct *vma;
>>> +    struct mm_struct *mm;
>>> +    unsigned long start, end;
>>> +    int ret = 0;
>>> +
>>> +    if (start_page > last_page)
>>> +        return -EINVAL;
>>> +
>>> +    if (last_page == ULONG_MAX)
>>> +        return -EINVAL;
>>> +
>>> +    start = start_page << PAGE_SHIFT;
>>> +    end = (last_page + 1) << PAGE_SHIFT;
>>> +    mm = attr_tree->svm->gpusvm.mm;
>>> +    if (!mm)
>>> +        return -EFAULT;
>>> +
>>> +    mmap_read_lock(mm);
>>> +    while (start < end) {
>>> +        vma = amdgpu_svm_check_vma(mm, start);
>>> +        if (IS_ERR(vma)) {
>>> +            ret = PTR_ERR(vma);
>>> +            break;
>>> +        }
>>> +
>>> +        start = min(end, vma->vm_end);
>>> +    }
>>
>> That's complete nonsense as well.
>>
>> The result becomes invalid as soon as you drop the lock again, so just 
>> completely drop the check.
>>
>> hmm_range fault will tell us if the fault was succesful or not.
> 
> Got it will drop.>

I dropped that check in my local fix, but there is a regression:
A KFD test failed after dropping the VMA check:
KFDSVMRangeTest.InvalidRangeTest

it does a set attr on an invalid
address: 0x10000 and expects it to fail. Removing the check from the
fault path is correct hmm_range_fault() reports the real outcome
there.

But in xnack on mode set/get-attr are asynchronous fault ioctls with 
lazy fault to report errors, so an unmapped range was silently accepted.

I double checked what Xe does, actually Xe SVM also do legality checks, 
but it checks xe_vma instead of mm vma, see code below.

Abandoning or retaining the check are all acceptable. I am only 
reporting the test results and the current approach of XE SVM here. I 
just need a decision on my end.

Xe implementation:
int xe_vm_madvise_ioctl(struct drm_device *dev, void *data,
                         struct drm_file *file)
{
         ...
         if (!madvise_args_are_sane(vm->xe, args)) {
                 err = -EINVAL;
                 goto put_vm;
         }
         ...
         err = xe_vm_alloc_madvise_vma(vm, args->start, args->range);
         if (err)
                 goto madv_fini;

         err = get_vmas(vm, &madvise_range);
         if (err || !madvise_range.num_vmas)
                 goto madv_fini;   /* no vmas in range -> rejected */
         ...
}


drm_gpuvm_for_each_va_range(gpuva, &vm->gpuvm, addr, addr + range) {
		struct xe_vma *vma = gpuva_to_vma(gpuva);

		if (xe_vma_bo(vma))
			madvise_range->has_bo_vmas = true;
		else if (xe_vma_is_cpu_addr_mirror(vma) || xe_vma_is_userptr(vma))
			madvise_range->has_svm_userptr_vmas = true;
...


Regards,
Honglei


>> Regards,
>> Christian. 

