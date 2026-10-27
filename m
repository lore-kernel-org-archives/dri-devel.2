Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46357606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=M7yW6w+q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A01B510F40A;
	Tue, 27 Oct 2026 11:52:21 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012054.outbound.protection.outlook.com [52.101.43.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BBBA10F40F;
 Tue, 27 Oct 2026 11:52:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Atu5CaX5CvtMHgpB4XaGK0kTMd4mnaOBcXKPiQfYeBPvd+FBTnETyIvLOetX5S1l+yOjvRSYkktXwAhjLzjhyRN9GqOzUw47I/KKmhTHGTTZ1A921+klq8XWr8lmOs/6aRdlbvSoxImgKQlnLNypzXyi/Sbr6UyfSxZWiZwnwV7IC0qyEMQmSEvOcWeVzr0N84cw9CbCsjZUOJQ4vic8bEb+Y0/J9d2afpar03KYuRhCuBhpAuUik9IoK88eR7ou4NJcqqPZumRam3tHXVdih6r1kZHZCneibKpXjost1ekAHm/E4rNMu35M1M+GCaD3+L6c9pC25ZcjenXkcxPjJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kxt+qCO1e5YJyMPr7jhe/tSp8GNBclL8zqh8VLZYqok=;
 b=pDwBEn9nqel4kFGkRsIq86tVKIWE0cmr5HXWRZT0UeWNusUBbv/prDy8rRaw74XueyGUu+DvxggRJegvaq9vJK9jyGrS7Dlv0U4bXjP3cN0TfuMNpw/0stwmH50gpg1ih8v5yalyH0xOjTR9t4Jtf2jYm+Ll4cDzPKNCmH06Jcksr6StohzN/tmX6DynGrBzWzxFu7tSkBQOA5fgFmpNrcroD3/k46wQN47ymwhI0Vcmp62Pm2ZQibmOZu4aSoiYg5a4XkVu5vVirDgkoCQQcrwHytYdCHUwFe9goZCMGR2mNK3F3YXMELjc+6fbtuOj94dzjrOrcn6FemrWt9y6ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kxt+qCO1e5YJyMPr7jhe/tSp8GNBclL8zqh8VLZYqok=;
 b=M7yW6w+qSeu1p2c2b22AEtUGCnbyOzo928ZXq3eZrj7WK6m9W6lQdHGYszQJp2g1rOowsIsqrXjEhpb+wOvQUJ8UTvrIY5SjHaDpvuTyL+Orkrpozxq+NwST2WvEDBoNNQ9YWSKatkEc4QtByoydoojRImiwO1JOGwwcCXJBXRk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB8108.namprd12.prod.outlook.com (2603:10b6:510:2bc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 11:52:07 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 11:52:00 +0000
Message-ID: <1ed5c075-c66a-4144-b23b-a9d80e1fc2c1@amd.com>
Date: Tue, 27 Oct 2026 12:51:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Harden against potential deadlock
To: Felix Kuehling <felix.kuehling@amd.com>,
 Philipp Stanner <phasta@kernel.org>, Alex Deucher
 <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
References: <20261026141541.469727-2-phasta@kernel.org>
 <bcd63af3-d2ce-488c-ab96-2b11536cd50c@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <bcd63af3-d2ce-488c-ab96-2b11536cd50c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0358.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a31acfb-5dfa-4c33-5256-08df3420b600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|261009223027099003|261021123027099003|261022105027099003|261022075727099003|261021121427099003|10067099003|56012099006|261026140227099003|6133799003|18002099003|22082099003|261026121527099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 51C8fR19QL7D1PhsH7UInpSRwZXawiZI3tjbPhllxQTQ0d6JnmrdoXtX8j64jF5phQG8e+ZWTsy6kaYlj8so6ZEMZs6VRXbxVWxlFByGCLkf/fr7lzZpJKJv/vboVNHJZCZ/BLoR5qNigUDg/G5M46riF54Q9+0j2qQk6/6Yd4DBtFRHvW3x/GW+g+KOkUduyHKp/3enUZ5fFYumzFfQM9jpghvhHo6FmddZ6AfAdLovBRl7iyly10jd22s3O7pYJyMO1u+6WDWZHd8LKG52uyBqE0ATgzBnFFySp3+qs8mJ9sB2r0BywSP0sRqbErSWgEaIfiCtdtNdusLCNST2vzFu85jDZyxjDg2tQ5ftTyQffkII35Iptc7mYyIfUfx0KhkWFu65Nlk2tiz93dn9mGaWCtr7LcJQHYljhmjyaCHghCmZndZW/u0D7LT/Ed55UTBfL8ZNzafvyXfFc0Z0M5GI+J1CPKOg8aoV+Z2aLKZgXeaRfteL2VRgCRhh/+MnKtqJBAnP1lH2o1ZIzl5uspgXRcIBLS0G2az4txTTP6+awE/hObEGNtap1adOC27YmQTF9uQ5S4wVYtU935Yy02KU5BezQKGGQZunTA3caS1QDRS5WIG7C9AqjP9Eyv3q
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(261009223027099003)(261021123027099003)(261022105027099003)(261022075727099003)(261021121427099003)(10067099003)(56012099006)(261026140227099003)(6133799003)(18002099003)(22082099003)(261026121527099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXh0TGl0Y3l0c2YwckVzcGJISnNpaVpYZE84S3FQa0JXZzBpMCtYT1lMMDJL?=
 =?utf-8?B?TTcwYnNiM2I3QUp2WW5vZEdCQVBDTE5Yb2U5LytlaUlON0FOdm00TDA4aFQw?=
 =?utf-8?B?eWJjVnp0bCtob29jZDhuelAwUDlWYXpmQ2N0b1hZZW5adThzdVRZMlRYTlRF?=
 =?utf-8?B?a1VjR2o5TloxMC91MjUvdzRWVEJNTEtnWmxIN1dlK3BNZ2JyZWR4bkhjSmdu?=
 =?utf-8?B?VjJYRUg2R2JaOEtOQVZGYkViMzl6MW4wc0VWb1pmZzg4aVNtcWN1YWsyakRy?=
 =?utf-8?B?OXRFdmJJNGdjbHdXMjlWak12OWVXQ2RSd2RkK2hIOEs1TGFVT0V1eldEejBu?=
 =?utf-8?B?cGh0dlMrYlN0Znp6WWx6VkJSK1FTSGNSdjRDUXNUeUFVTVpxZUVwSlRpWk9F?=
 =?utf-8?B?OCszc2N1TlRuRkxoUVlSWTY2WWcveVJ0MFZkbURnaFRZYWlLZEdIMlZZOU9E?=
 =?utf-8?B?WTE1d0gxdFZsU2U0TkRQbm53SzhYNU9XQk04bHBYZ3U2OXIwQUpTR3lzK0tt?=
 =?utf-8?B?STZBbjRRc01GbWp0VmdVWk9xVERlTk1tazJ4bm1QZE5vdXlvK2xURDczRjZW?=
 =?utf-8?B?RWFHYkFQdWQ2ZHBQNVNFYUlpWFVVREN1cEJRMmFUMGVjL2JJNzNOQnNCdTJX?=
 =?utf-8?B?Y1drb1R4Y3d5eDlSNVR0ZXVnT3M4WWlwODBOa2ZYRllhN2M2NFZMdU13VHp4?=
 =?utf-8?B?dlpBY0tUQUxzMTBoT1lDUS9KaXdCU2lPMDlzaHNnYWZzNDVZMVpXTnJ4dTFm?=
 =?utf-8?B?T29VSnZscm5NSXByVHVLNVpueFF3c3NzUm5yS1VDdWNrWmV5WGVsMzZEVjFH?=
 =?utf-8?B?VnNVK1hmYUhOcnRGcnc2YUs2NzFPaXpkVXhZc1lFbmlrellqZk5keGFrak9x?=
 =?utf-8?B?VmxsNndOUTFEWXNFUUJLWnNTcDJTR1NzalJQZCtMN0NBSmR2eFlTRklwNjBw?=
 =?utf-8?B?em5zOS9UMnQwOHRGR2xwek1wcm5Ickl0RGptUVp2bGhXZlhmclVsZ2V1OXhH?=
 =?utf-8?B?Y0grUjY3NFAwUTVCWlI2bUoyVGRaSXBMUEp0V3BwR3dXZEVvVnc4T09xMGZP?=
 =?utf-8?B?OTNSYUFnSFlvYkJTYzBoa2FQQ2U0S0ZybVJXRmFwQm1DZkNkUlpUQkpwTUhN?=
 =?utf-8?B?a01BNzBDeTRNcVcrNjI5VXZOTnhSSlE3QjBiK1E2YVlhd1lYdHptVW16OTFu?=
 =?utf-8?B?TWJ0Z3FKdUhjb2ZIajhrVGNpS1ZpRjducFlsdE0xR0haZVQ1dTZBdE84SGxV?=
 =?utf-8?B?V3l6QVRCVVFSbEM4dU8yTnl3MlJwak1KMjJsaEMwNVJLZ3pCUDdvK2xBUlRp?=
 =?utf-8?B?Y2lENXBwaTd2eE93LytIck5PNHBHS2RISm9IaTBpaUtETDUxRnUyazB2SGUz?=
 =?utf-8?B?NVoydXEwOVhJTElhbmVYa1JBRS9RQWJDYkNTOE1TL1VwVHpHcGtxaFU4YWJN?=
 =?utf-8?B?bHFpU0F0dUllY1BXdzROaGpFVTZDQmhVQVZ0RjI2SFNlVTNsY3B3WEx4Si9U?=
 =?utf-8?B?TUVRSkZibVRENEVyb1hrM0hnTCtic0tLSmFURTdNY1hTOHRzeUZ6NitFMWs4?=
 =?utf-8?B?YVpDSGY1S1NhQ2FrTlhBeDR6VkpobUNxQ3ZuUGI0bUlxL2pUWkdlYk96Mnc5?=
 =?utf-8?B?K29peCs3a1gyY2Y0VCs3Tlp1dnVsWXA1N2J1akZBYUZ4cHdER01ha3RLaVJB?=
 =?utf-8?B?YkorMnp4cEFQSjRVajU5T3c2SWxkMnljd25acTF3V29hbm1uVWhLSUtwTWR2?=
 =?utf-8?B?V094QThCSUR6bk56dVZ4ODdGYSszOXMvK0Q4QTdiQkpEb2pRYVlnbUFhZUx1?=
 =?utf-8?B?NGoxYm9HV2owK3JUMzI0VUdLSko0Z2gwdHlXeEFqNnZyNkNqalBkbXJUSWFN?=
 =?utf-8?B?QU04VGpYUkJDWXpINGlaekFNaTVac1dqYy9rekl5VFFubkdRbUJEQjRkU3I2?=
 =?utf-8?B?Q0ZCbklreUFnckdpTmZPRnBSNnpxSHNwTEM2TlVIaWdRdW9ORzd6YitBMHZ0?=
 =?utf-8?B?UTZpQTh4M21CVmp6SGhHT1JYb3pVTHRrUWExVmpvZVNzYVVEM0w0Wm9SK1R5?=
 =?utf-8?B?MldBeFdnR3B4K0V4MXFveThBVm5FekQ2OURsZ3FoUkg5eFkvWFdWRVNQTTlS?=
 =?utf-8?B?YkE3L21rOGZyVzZEeXpTSnFiSmhaTlpVaDA5U0JNRGU3SUgxOHdmejRsUTRM?=
 =?utf-8?B?b2YzbVNlWjE1Zjh5STV0N0NDMGtWYXp6dXBsYWFZU0FxeUd2ak1rQ2VGNW1L?=
 =?utf-8?B?Y0hHOElkOThHSzNxMVlBWnhqREVWMkc1N1I2L0pmeUNYNFgycjY3L1hMNG9r?=
 =?utf-8?Q?OQ1h4s8KAnxQhI9LZ5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a31acfb-5dfa-4c33-5256-08df3420b600
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 11:52:00.8313 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7wTTtDGvTlPsp9Emzoy6M72NTk6M6K2gqMcYeffsjhyW+T9rHPZ+L+8c+5aoIQrh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8108
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/26/26 19:31, Felix Kuehling wrote:
> On 2026-10-26 10:15, Philipp Stanner wrote:
>> amdgpu's KFD eviction fence's dma_fence ops->enable_signaling() contains
>> a dma_fence_is_signaled() check.
>>
>> ops->enable_signaling() is currently consistently being called with the
>> dma_fence lock held. dma_fence_is_signaled() might try to take this lock
>> in its dma_fence_signal() call.
>>
>> This deadlock can currently not occur because the amdkfd_fence_ops do
>> not implement ops->signaled. Should that ever be added, however,
>> deadlocks might occur occasionally once the fastpath check in
>> dma_fence_is_signaled() is skipped.
>>
>> Replace dma_fence_is_signaled() with dma_fence_is_signaled_locked().
>>
>> Signed-off-by: Philipp Stanner <phasta@kernel.org>
>> ---
>> As detailed in my recent discussions with Christian [1], I also think
>> that drivers should be very tightly constrained as to what they do in
>> the fence_ops. I think at the very least they shouldn't use any
>> dma_fence functions there.
>>
>> So we could also remove this check here completely;
>> __dma_fence_enable_signaling() already checks the signaled-flag, after
>> all, but I'm not sure whether that might break amdgpu.
> 
> Looking at the code, I think it should be safe to remove the check. There is another one in kgd2kfd_schedule_evict_and_restore_process, which is called from amdkfd_fence_enable_signaling, which is also redundant.
> 
> We don't implement ops->signaled, and we explicitly signal the fence from SW with dma_fence_signal or dma_fence_check_and_signal. So the signaled flag should be the only thing that needs to be checked. The flag is only set while holding the fence lock, and checked while holding the fence lock. So in theory, relying on the check in __dma_fence_enable_signaling should be safe.

I actually had a patch to remove that one send out month ago already, it was just never merged.

The call absolutely doesn't make sense since the ops->signaled callback isn't implemented and the bit tested before the enable signaling callback called.

I can take care and push the removal to amd-staging-drm-next when I find time.

Regards,
Christian.

> 
> Regards,
>   Felix
> 
> 
>>
>>
>> P.
>>
>> [1] https://lore.kernel.org/dri-devel/320b6e7c75da6f05c015e89df0e2c7d11f20d70a.camel@mailbox.org/
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
>> index 9b10d015671c..61621eebb2b0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
>> @@ -123,7 +123,8 @@ static bool amdkfd_fence_enable_signaling(struct dma_fence *f)
>>       if (!fence)
>>           return false;
>>   -    if (dma_fence_is_signaled(f))
>> +    /* The enable_signaling() ops is called under lock protection. */
>> +    if (dma_fence_is_signaled_locked(f))
>>           return true;
>>         if (!kgd2kfd_schedule_evict_and_restore_process(fence->mm, fence->context_id, f))

