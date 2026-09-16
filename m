Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D682CC88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 12:53:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85C7A10E449;
	Wed, 16 Sep 2026 12:53:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V0Yj2c2j";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010028.outbound.protection.outlook.com [52.101.46.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 569C510E23B;
 Wed, 16 Sep 2026 12:53:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wkYc+cH1MY6/06a2HzX53STgGxO5HUSKr3rtoqTb1u7K0l2an5MZAd/bnPgQLhLDlyNjCCdkCNgt3gnGn4vuJ2y/Noc4bEQVGFDdJ5fWQ1bC3tF2Q6zQHk1vmKT7cGlvtWsJLvdT8jpiBItWIKAbonLLP18xTxOjv3KohAAo7g+OxP6AirLimFkDE81ounTBCTqeSBncAJ0xpf8XWZT2F/mK5qOZtag1mXEUzpX/aTEtJgsBtO2ZwOEvbNJ3+e6AE5Nj2fw+NqHKxVYbKRZcOJkJ2zMWGjJIz9HM3vZXIphANS251u7nFmhfhGknNlrLpo23DI/IN3bYv0J+WIT0UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCBWKEDEIoeb+Ek3ChX8vdbJwJ5mRBzOzkQNoHOT0WQ=;
 b=YVYvnnoicpgb1In3+DWBdlW+P851vK1JDmgAY3fCfGvbJjdxvyyy9fIJCtJ391nd+5Ep+iiHaANheixMpkLfNjzt7jzMKxYeWLiHrpbcZHvqS5YuHg9io3gjl+7fkWNF8rLYr+huBRw6KdsjLj8kMQVZXnSuR57G5Hhwm2U7GWuObUx+ER276xAOCox2RNwz5YeYst6Q0ZTdYQhDBno4RVni17COSR8HjiLtS6jcgLc0h15bK6xk8IDz30rjSisH1FkBGU0Sp2ceX8Rb+Fxi8me1aQRo3HDwmI4485tkeeiyoAA8Oh5i4P1r8cpuIglNrzbvQVmY+uOQu9GYcy+FZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCBWKEDEIoeb+Ek3ChX8vdbJwJ5mRBzOzkQNoHOT0WQ=;
 b=V0Yj2c2jBpmAofACo4kKpPJg5ipME8YU7nDrI/M+7IBQC9hfdWkmykXaGlU2TQji7Ynt6XY50BupqOlZgsa5KtjR4I6MjteY4nmOyFBotrUsUfmhuM7HuHQX/Kf30/aDx15QK27zeCyiV+TZfngyiGckQV0UnHNh90fRhzJfI9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8257.namprd12.prod.outlook.com (2603:10b6:610:121::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 12:53:50 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 12:53:47 +0000
Message-ID: <120a913c-2522-4601-a17a-708778de2036@amd.com>
Date: Wed, 16 Sep 2026 14:53:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915: fix incorrect RCU teardown order
To: Tvrtko Ursulin <tursulin@ursulin.net>, jani.nikula@linux.intel.com,
 joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260903113621.54660-1-christian.koenig@amd.com>
 <30c0848e-e8f6-4bb7-8505-89316158c49e@ursulin.net>
 <2030085d-5f14-4bd7-8694-dc8a6a2a25ed@amd.com>
 <0e10455a-a328-42a8-981f-43dbb46593a2@ursulin.net>
 <378d447a-a285-451c-b001-5c6dd6ea74b6@amd.com>
 <0ea708d8-eef4-4245-8b49-fe47d30ca343@ursulin.net>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <0ea708d8-eef4-4245-8b49-fe47d30ca343@ursulin.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0292.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: 7028a334-218f-4b8d-df7e-08df13f18c45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: L/Jf8jWvqQNYI8S/sSUvLuv2BW9YgEhswymjjJObeIlDCGRYy08wA8RH8Bbf1kmYdBFqjvqjWPfW6KWtjLoV3R4Wug4xxr7Vu/SjN5S0cFd+A1S+6G6OlMiTiO6DRX8vDuCT7r8yW1m4wv2iyYfxplsW4fkKpUDJ06QRGYQ6Qd2HiJNuw5FGUT/X04HJbfvEgmlybe3sr9jviotQTexgLtLuHjzxGF3Iu/DWyXNVwvSdKnPYpUD1EAvS8zu8dUllG4mpSnWqLvUFaEVcN3w9MGgUYm+4620jBuHtZt9MyeGh0m/77z5OuKxBWo4IW2CmKlT5aYn2HTOtpkvik7SExsZsC9xbsiWx1ISWY7niXL90F5JfbDpouks+ma36pAmumVXsQvSFKPe5j0EPiNaSXkEhsz24WkRSVTV63u/10HhSrATpwtXOlxJEyL+sVDfFbc0gnA17qkA63xlaKXhQDUf5SskoDO/UpcnuclN5NnPGN2BEmSo2q+jOz0dQwKrSHATXSiTvj3kGQcF5YMsSYdyCgRcb0F/JawE2TtO5UOh1xYKQPjVOs1WWciZI+scf783zTQ8Q9o0rc9UMVlQ/k9Ho6uud0vziBuWeionrHx4RawB1gBzQrdUTca//5N2ON4MTuFtlBTfJHl4j5YIsFCUyeZREKeEFBGAFbhHarAs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTlJcCtibE9kSEJOZGpUZlhFaWNVY0dqMHJKNlZoWG1BcFR3UXF1SVFHLzI5?=
 =?utf-8?B?VXhYSnRmN2NreEk3ZjQ4WGVCNDJ5SXRBajBOazZnWERlNlVkcWU0OTc0Ny9H?=
 =?utf-8?B?WWZmcnp0QVZSSFNndUZWTUQybDNIS0podWNvRnoxejBrOEpyQXBiNUlqL2Zv?=
 =?utf-8?B?QTBuZlh0YklSTmRoditidW0rNXRmZW12bDArY1k3aW41Z1BZMXgxYitoVGVO?=
 =?utf-8?B?eGJPejZ5ZG9KL3I5MHNGQ2Fzd0pRUDIzSm5PbWpCUDQwZmRIRExWV2xmdHU1?=
 =?utf-8?B?cmFVTXYwaFYwbjBGaEVMM3NJZjFJRytBOXZGRVlRZ1dWOStZRE9XS2RQTzkw?=
 =?utf-8?B?SE5ldnl1aHJSalo4ajhKNEN6Um9Ia201c2dDaUxOUXhOczUxVStPWkZrT0c1?=
 =?utf-8?B?TWJoTXVWdGxGcEV0YzBiTXJTTFc0NDFMb0xsTldQak5rOVo5TEhSUzBqQ1pL?=
 =?utf-8?B?VlU2VWhJakI5SVR1VXlrS1dUWHBZaEg0OGRVb084aXFzdXNGOERFaFV2WWg1?=
 =?utf-8?B?NDRGU0I0Z3IrWGI2akFaUFhGTWZWaEFLVFc3WEZaSmRYVWZ0TjAwY2ZlSW5p?=
 =?utf-8?B?NmsvbjlBUy8zdm9wdzdOdWFPYU9CWmthOGUySXFHTHQxYUg3RzdobzdWVk1r?=
 =?utf-8?B?VlYrQjlwV2VtVnU3QkxaNmFsWUtucjBSNGtMTnpXNVNCQkZmbE0ydjBLczJF?=
 =?utf-8?B?QTR6Qk5Md1RNRlN5TlBQdlZNOTNyVStqVzMxYnBnb3Jsb0RTNnNNOEU4VHNO?=
 =?utf-8?B?QlBXbWpuMEFkbG51R1dubFkzVjMyWS8zTzZnU29taEU3UjI5QWlZMWtPMFVM?=
 =?utf-8?B?aEx1MHlJSUtGUyt0cG9Pc041MHRqRnlYMTI2NlBidzRYSCtmQWJnanFCZHBz?=
 =?utf-8?B?NitOSndWSU03U3hwanoxNERoaHN3TmFTeEVIejU0NC8rRnZpNHdSV3FMY24x?=
 =?utf-8?B?SHJpbExpSEY2RlV3NCsrR1FWRmlVU3l6NE5sbDl4em5BejZJRFQ3R0UxY21Z?=
 =?utf-8?B?MVBMYzdSY0plekdvRlNwbEo3eGNnNjQrWXF2WE9jTklZQSs0T09jR05BOElK?=
 =?utf-8?B?VWVLWnI1eFM2R0VPckNLY1B6REpRUEUwUmVZMzRKOWh4Wm1iNE5Wc3J2YjJ4?=
 =?utf-8?B?MnpqNnUrZ3lOeTJRZXArRzBQK1R1Z0JLMmErMStYbDcvZHZsMFozNmxZSmZ3?=
 =?utf-8?B?eG51eGxXdThMMWREUnhac1o5WGhNYWpROVBrd0VUUGZ5MzZQbENYUUFOOEtw?=
 =?utf-8?B?N0VBSmphczdQL0xVKzN4ZmlqTkVvKy80Uit6andUSFY2dG9PL1R6MlpLeEJC?=
 =?utf-8?B?L2M0OVVyd3gxOE9VS21kYjkwcTBkRmxHSnlSMG9DZ3VQRlNUK1NSeU1ZVXhL?=
 =?utf-8?B?VUN2RGdOQmRjOC91NThRSEVEZEFvTWc4U2N0Y1o0R1RlTzNVM3pjUmFSWWt4?=
 =?utf-8?B?V0I4ZXE4N3hycko2S2Nld1JLWncwdThGZXZEcGdGaUR2L3Y3Q20vS3Jtd0Vu?=
 =?utf-8?B?ZkI0YVFaeUp2T3c2SmtxUkRCTm1Hd05kcysvamljUjVJSDZkME16aU05OVZN?=
 =?utf-8?B?eTlGU2hsYnl2VjI5ZzZrN0tndlRHL3JnQzFuUUtUajdhMUZsb05LR3dtYlNN?=
 =?utf-8?B?U2ZZeDlKUEUraEFjWlN4Q3o0cnZ5OWp2aXBjQkRnVUxJbjIrRFNTa0pSUUtR?=
 =?utf-8?B?cEJnSkVXZXFRajFjd29GUk1GS0ZrSDgrSTBvMWVxKzFqY1ZzSUo1Z0sxQ0tT?=
 =?utf-8?B?T2ZGaFlWanhzTmw3aGVRYXZaODVaaS93RUg4TzNZNkQydGY5ajFyeEF3aS9m?=
 =?utf-8?B?Q1l5NHB6N1A5ZnZHcVZLTGtvcW9YNTRjbmdtYU1LOTgwUUplK1FXd0VDS3NU?=
 =?utf-8?B?TThWV3ZFQitEUmZkKzVjNXNGUFZKTGgrTE9XemNQaEtVMjdyVFVLRXRyaS95?=
 =?utf-8?B?bkw0UkpmTklLQjVMSjR4N0kwbzNuaUpJV3JpMTlja1ZkRWo3WkhIY000bXhl?=
 =?utf-8?B?K2JxdzRWcTFySldJRXJodXJBMGpTeXRlZFpZdmh6L24vUTRsNFVOVXBzU3pK?=
 =?utf-8?B?azlCOVRxWVRPUXFjRXNkSXVSNmV1NjRoWjQzK3FqQ3NTSTdVVzdJd3hWaGVy?=
 =?utf-8?B?eWVSRUk1aVJMc2o4U3REalhrZEdlajQ1Z3NkT1hFUHBFK3o5bkdaUWJra25B?=
 =?utf-8?B?MERyUUdLTktOa3NIcUk1RjVnamhPYllic1lOUWMrS3dQS25nTVZoZk9kTm1a?=
 =?utf-8?B?dFZvWEJQazVHejQrd0RldG1PVUh6OGFyOFhqRHBzVi9qbzFOMzF6bDhMMFRI?=
 =?utf-8?Q?CrTUSVCIelpcx/+W30?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7028a334-218f-4b8d-df7e-08df13f18c45
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 12:53:47.6020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QIoxJqUb5Gx/632uQvng1GDa2GYhZL2F1VDtwVYMgBrPlkQNbP4KUuD1P5+RiH7e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8257
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

On 9/16/26 11:51, Tvrtko Ursulin wrote:
...
>>> [Severity: Critical]
>>> Does this synchronous free cause a use-after-free for concurrent lockless
>>> RCU readers?
>>>
>>> In the i915 driver, GEM objects are destroyed using call_rcu() (via
>>> __i915_gem_free_object_rcu). Lockless readers like i915_gem_busy_ioctl()
>>> look up objects under rcu_read_lock() and access obj->base.resv.
>>>
>>> If an object shares its resv instance (e.g., via obj->shares_resv_from with
>>> an i915_address_space), __i915_gem_free_object() drops the lock reference
>>> synchronously via i915_vm_resv_put(). If that drops the last reference,
>>> dma_resv_release() synchronously frees the memory here.
>>>
>>> However, the GEM object itself remains valid during the RCU grace period.
>>> Can concurrent RCU readers dereference the already freed dma_resv pointer
>>> when calling dma_resv_iter_begin(&cursor, obj->base.resv, ...) in
>>> i915_gem_busy_ioctl()?
> 
> I guess the shared dma-resv part you will solve in the context of the reference counting series.

Yes, of course.

>>> Is the dma_fence_get_rcu() inside dma_resv_iter_walk_unlocked() what triggers the endless restarts?
>>
>> Yes, exactly that one. When it can't grab a fence reference it tries to get a new list, but when there isn't any new list it just tries that forever.
>>
>>> It's been some time since I looked at the dma-resv walks.. but fences on the list have reference held so that can trigger either via dma_resv_fini() or dma_resv_replace_fences(), right?
>>
>> No, dma_resv_replace_fences() replaces an old fence with a valid new one. So the loop never becomes endless.
> 
> What I was wondering about is that dma_resv_replace_fences() has no RCU protection so how does it co-operate with unlocked walks?

Hui?

dma_resv_replace_fences() asserts on holding the reservation lock and uses dma_resv_list_set() to update the entry with the replacement. dma_resv_list_set() then uses RCU_INIT_POINTER().

Could be that using rcu_assign_pointer() instead of RCU_INIT_POINTER() would be better, but apart from that I don't see why that shouldn't be correctly RCU protected.
>> Same for dma_resv_reserve_fences(), here we replace a whole list with a new one and make sure that we free up the old one only after an RCU grace period.
>>
>> The problem happens only when drivers incorrectly call dma_resv_fini() while a call to dma_resv_for_each_fence_unlocked() is still ongoing at the same time. And that is pretty obviously a bug.
>>
>>> If second is true then how does i915 having the dma-resv containing object RCU freed cause the problem?
>>
>> I also considered setting obj->fences to NULL in dma_resv_fini() as alternative workaround, but that would break again when I try to reference count the dma_resv object in the future.
>>
>> So I would need to free the dma_resv object RCU safe as well just because of the problem in i915 and that is not something I like to do when it is actually a trivial fix in i915.
> 
> Fix looks plausible to me but I still wonder of the implication any driver which would use  dma_resv_for_each_fence_unlocked would need to ensure a RCU grace before calling dma_resv_fini, no? I do not see it documented in dma_resv_for_each_fence_unlocked kerneldoc so if that is true we should add it.
> 
> For this patch:
> 
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> 
> There were some CI failures so I have queued a re-test. If things will look reasonable I will merge it.

Please let me know when it landed in drm-tip since I want to rebase on that.

Thanks,
Christian.

> 
> Regards,
> 
> Tvrtko
> 
>>>>>> The solution is to drop the fence references only after the RCU grace
>>>>>> period.
>>>>>>
>>>>>> The fixes tag is not necessary the patch introducing the problem, but the
>>>>>> one making it so worse that we need to address it.
>>>>>>
>>>>>> This problem was pointed out by Sashiko-bot.
>>>>>>
>>>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>>>>> Fixes: 912ff2ebd695 ("drm/i915: use the new iterator in i915_gem_busy_ioctl v2")
>>>>>> CC: stable@vger.kernel.org
>>>>>> ---
>>>>>>     drivers/gpu/drm/i915/gem/i915_gem_object.c | 2 +-
>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.c b/drivers/gpu/drm/i915/gem/i915_gem_object.c
>>>>>> index 5172d3982654..9e01f8b2079a 100644
>>>>>> --- a/drivers/gpu/drm/i915/gem/i915_gem_object.c
>>>>>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_object.c
>>>>>> @@ -89,6 +89,7 @@ struct drm_i915_gem_object *i915_gem_object_alloc(void)
>>>>>>       void i915_gem_object_free(struct drm_i915_gem_object *obj)
>>>>>>     {
>>>>>> +    dma_resv_fini(&obj->base._resv);
>>>>>>         return kmem_cache_free(slab_objects, obj);
>>>>>>     }
>>>>>>     @@ -144,7 +145,6 @@ void __i915_gem_object_fini(struct drm_i915_gem_object *obj)
>>>>>>     {
>>>>>>         mutex_destroy(&obj->mm.get_page.lock);
>>>>>>         mutex_destroy(&obj->mm.get_dma_page.lock);
>>>>>> -    dma_resv_fini(&obj->base._resv);
>>>>>>     }
>>>>>>       /**
>>>>>
>>>>
>>>
>>
> 

