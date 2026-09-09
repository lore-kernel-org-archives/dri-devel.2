Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219D3C79FAA
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 07:24:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8DE110E3A8;
	Wed,  9 Sep 2026 07:24:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yjrcs6hA";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010035.outbound.protection.outlook.com [52.101.201.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47BC910E131;
 Wed,  9 Sep 2026 07:24:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6NE498Gc0gcIIgUe9oRfB6jmBYN/ZFLXujge25nalBymvcLndrXh0jjFn9En7SpjIhUxVANVT2upAe3s8pntKkxG+ShBt9INKT+wmMNPEUeX7CqVsg7WVlGfA9b9hcAZQgsJPhe0++UzKWWqWBAD7kYqvQ1YUiVqzMekVUhW01Y+yAkOGNOYA6KrweBMRuVNWCevWpsx2L3DNJyySI48z7FAR0QMh2reCfnho60XEJZKC2eJVdtFNgnrmFLnYVHJ7HnwZdCbRzYtKQJ8IGqpxFwuxqfKaoMrrtR3KlXoKtdJzvZXiPPuTqw5Ea2PwOlcQa2//C8LbOrTFnWu+4/tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0R+baNSj9+2xPHm9rlTuu4b6Un4xMjfbaPgpTmzQhc=;
 b=Gi/TW9UYGLIhih9BYmGLwDxurVzqgiQmNEseHs8zekq4hk62si2A1M99b9J3SWyQrN8Ju6xAqFC/4sGVRuMlvmjZ1LSDR6Nhk5btlgE/D3C5ynZg4n4ICa3Q6veBzfkUNYWptiLuLNutFK+RLwPRT+abIiF57rexYvXY0GsHT+/eexCJbc4DN+8mESS6IR2d3eHJDYVpj8DecwgEmd97IjMWNC+Vnp+c0NnO3ZPSzhWcDiSTZHFLj9uYS+L5aBOUrbSHCHRH1v+QMuqRk0cO3cFQeb5ZBQh64o2IqYGM7Q77sZ9/NH9x/FD4bmDX+fp6JeRQd3YoyArjzM5GjF8L8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0R+baNSj9+2xPHm9rlTuu4b6Un4xMjfbaPgpTmzQhc=;
 b=yjrcs6hALc2xcsbRXKRJux+J/9KbGmiBkag2PY6jguU0z/7geZMLkFwLei045HUm7OvMF+ONzZyu9V2SbWxAuWEjgjT8UO3TILWZkwxguwodU5qVpWvWRMXraGDhK/DZdukgZJHAyoEFHuabePq/N6hiGH7hntdknanQwVCZrMM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB4104.namprd12.prod.outlook.com (2603:10b6:610:a4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 9 Sep
 2026 07:24:50 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 07:24:50 +0000
Message-ID: <378d447a-a285-451c-b001-5c6dd6ea74b6@amd.com>
Date: Wed, 9 Sep 2026 09:24:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915: fix incorrect RCU teardown order
To: Tvrtko Ursulin <tursulin@ursulin.net>, jani.nikula@linux.intel.com,
 joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260903113621.54660-1-christian.koenig@amd.com>
 <30c0848e-e8f6-4bb7-8505-89316158c49e@ursulin.net>
 <2030085d-5f14-4bd7-8694-dc8a6a2a25ed@amd.com>
 <0e10455a-a328-42a8-981f-43dbb46593a2@ursulin.net>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <0e10455a-a328-42a8-981f-43dbb46593a2@ursulin.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB4104:EE_
X-MS-Office365-Filtering-Correlation-Id: 1926a7d5-9f3a-4fed-800e-08df0e436f3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|6133799003|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: zrR/hb0MVgMc9qxbF4pFAGCW1FNDTr1U2IdYZKC6XFDfMH7/Kt/QF2CmVGS3aVRwOSUW3+6PZZLVtlQn1W8/UMcjoZK4VlKWQt1GrMgZGc+FU89mBeTl/lAVaUOmqmnrKHf+tf+X6uDvC3s3hJL3Gf5obzzrae6zjmZI0bWAqUguJkLP9oDZgBV5Q9G1bjut80j4DugVGl55rI55mMImrXGrzrJSr1jIL1ytphj1Q7FTHWWcUNBTxEwyNtv8wfirwwlazkuGu2Lqb1MnrBiQ/akgXGok1r7UhuKY5VenRyVywVCIUSzZckjLtOEziBRccFvnSgGx4dTUHXXE4Fn3f8nlInzSu/lmRtTPm3chHDHHLyN1CFVTXcMGmJiMT7N81n6s4wNzIu8VyVylu+wjqpm5WLBUn2NxOqgjdWfSUB1pfNxtWcuF1VU5LOaq9BxuyRIvnr5mtnIOJrG7JWvTf+iqBQhsJaqe6wG4+gegRdQlLHN8tlda2iwTE+i4J5QRQbkyF99RQ7L4WSX6mLWOX2eOOIPFQOMKgiK8Abg8CLsdwi0Ym61eKLwWXgU357lwWS6Zp/Z9BOe5Jl4H6cLhIYKz+SPp2nmXvp51gKsX/qw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3FXUmN0andGTEU1c3ZFdXAyeGY2ZXZtOWZsOFlTSXJlWnovZENVKzlwcTRq?=
 =?utf-8?B?Y1M5amZqUXpOVC84ZXhLd29jSTBXNkVxTjMzcWFta2dDK1NYQ21VQVBtQ0kz?=
 =?utf-8?B?TXVpa0ZRdWVIbURLVDJVeWlCaXNUY21NOGhWRHc3Z2VjS3dQblMxU3lzb0Vs?=
 =?utf-8?B?TjBCYm9hUFMvRjkzUlRwbEN2Rzczc01Obk4zSkUyTHpLVFRmZGs0R3R1Mk1F?=
 =?utf-8?B?K21NQ2owVmE5V2l2dmNQYUNtbnc3SXRvbE9aQldmelhIQndHZGgzS2RLbWE0?=
 =?utf-8?B?NlFKd0U3WENvakdrVEo0V1JqVWpaQTNvVWdjYlRTR21uZmhFY1JKTGVuTmR4?=
 =?utf-8?B?b3p1STc5R3BnbEdSOEdUeVFPejhqM2ZxTm8xT0dNdHc5UzFoTGFDUitrSUFE?=
 =?utf-8?B?NHAwYUg1bGJIN1VPdlZTOGYwVnBBa0NtZmdqYUR4c3RaQWNWdHk2QksreEJs?=
 =?utf-8?B?VHZqTFNSTDRkcHo5elNqdDRaQy84MHRBdzhQejZjUUtmMW4yZE9ZMStqVVp4?=
 =?utf-8?B?Rzc2V1F1ZzBCbWpHT1ZDdWllT3ZrOW96THJEVnRleGZSL055YXh1czhXL2J5?=
 =?utf-8?B?N0thQWRDK1RnclNOMm9uc3Z2bHlyaDZnV3cxK1hGSmlVYUpieTQ5RVhkZDZo?=
 =?utf-8?B?ai9yRnc5ZWFYSVkzQzNIbjcrQWNVY2NvVFlaTEZQaURpd2RWUGtVVG9CMnlp?=
 =?utf-8?B?ZU5XaVh6YU9pL0plNWFKVHdvM3ZvNFBqWnVJdkhoS2pPOWtqTW4zaHRaeDUw?=
 =?utf-8?B?b00wWDVaTGovTVI0YjBaak1MUnNEUHRxaUJhOFhQMElYTTlHNlZSRTI0WXFr?=
 =?utf-8?B?RVhReVpXNmRweXRzZk1ab0dhcXl4d1JmenVJTkRCVE9kTU1wUHFGbzhJbWNw?=
 =?utf-8?B?eHdkR2EvUG02OFlRNWFaM1h1dHA5bGk4OWtSMVBCSURYc1dtL2JxVHJEYldE?=
 =?utf-8?B?aHN1Nm84NG9QVXBBWmRXZXVuMWtXMUhYTThFV2RXUDg3YU1acVVOejdiSmRJ?=
 =?utf-8?B?VE94QnBtLzZEMUMrSUZxdE55Y1ErMk1hM0kzMC9QZ1RYamJVQmsyaGZ1eWh5?=
 =?utf-8?B?YnB1YjM0Mm8xY1BKTitQREpRK3hxdmd1a2VlWDg1Y3Fqd3E3aVRwNThqRHll?=
 =?utf-8?B?WUo5WjFXeWVXYndyUnJmdmRqM25WYVRXcHJES3pzaStDM1hldWRVdklRbmls?=
 =?utf-8?B?S0R4UkdJbW9NT2UyZk0yTm9rR1FOcjN3czFIbnFuRW8rZ2UrNXhLRmdoQ2xz?=
 =?utf-8?B?bDk1aHZZT1pCbWFHMjlxMEN2WWpNQ04wR1NtbEJ4akw3dWdIaDJGejZwa3RE?=
 =?utf-8?B?QzFzQ2VtMEFzK1lqYlZRdE9OVHE2NWptQW92cElGcWhXZ1gzd0RYK1pzZkRr?=
 =?utf-8?B?SkJjT2FVNUxlb3prRDUwMDRLalU3emErOWtsNGxPcVJKRHQveFgyMkRDSW1u?=
 =?utf-8?B?bDRnczhReEw5dEx6VDdlMlB0TkszWEQ3Q1FWQ3p6MGFWdHBtZmg2cGREWmhK?=
 =?utf-8?B?YW9sb0NObXNQWjBYbkZmWEFnQmtNa0x4K0RIUEw0a0loY2pTQ3ppQmNnMmxi?=
 =?utf-8?B?K1RFNHl2TkpJYkdpM00zRmlZYVZCcithN2VrRmF0cDhLcWNteXZkUHZzZlpt?=
 =?utf-8?B?eDg2VTZmZklUb1d6alovZlREYm1nMmUxeFRXcnhuTC9KVzdqaG14K1pwaXBQ?=
 =?utf-8?B?NlVyTjFSVkxFd1hwakxOMHZ1L1V6L211U1FtSjJ1SzhLRitKMXNzTE5waFQ2?=
 =?utf-8?B?cElYeWI2Q1ZYUTV1NWYvK0VXeTlETForemxxaVowc2hGM3piK2IyWEs3dUlx?=
 =?utf-8?B?b2tjeGFocHJ0TERkMTVsTEIxOGQ3Ny9DRHA0TnJ3RVl2dDNLZml0N0Z0TENj?=
 =?utf-8?B?eDJ4L0tCN0w5UHhNNzArcENDbnlFZW4vbnVCZjkrRHNaVGlEMFVrK29ZU2g5?=
 =?utf-8?B?SzFoazc4L25TV3FteXFmeXM2QmhpNDRoTEs3b3psaFduYS9OWU1sNyswVkdG?=
 =?utf-8?B?Y2RIQWxWUWpXUUtLTndERVA1T2RscFVFVmJLS2FpZUxpb3Q0NXRUaTYwVWNO?=
 =?utf-8?B?dzlmT1ZrNlJnTkgvR0FNaHdPc0dGRU9iREtpeVNGNzVKWTIzcExBOHNZZHJi?=
 =?utf-8?B?UkZVdEhCMmllZ2NEcjloN05Ua1d3YURLSTRoenNWQ1NpQWRNQ3A0c3k4eEVN?=
 =?utf-8?B?NEUrWWd3U0gyVTk2VWVTL3J4NUwzbHBzOHljcG1zNzh3bkFJRjlFMDg3MXpK?=
 =?utf-8?B?UE80Y3dkN2IvcTJpU2xxR3IzeEY1OVFOYXk1cHZFeGpVVXJjYWl1dTN6a0xJ?=
 =?utf-8?Q?q9RaQexlfku2a1NiZI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1926a7d5-9f3a-4fed-800e-08df0e436f3a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 07:24:50.4721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6AHCwCr4FLstUDUXnDu8kz92qco7vpF81/GnY3OmONrVmhiqTNEZ6VVr63HGh2F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4104
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

On 9/8/26 09:25, Tvrtko Ursulin wrote:
> On 07/09/2026 12:53, Christian König wrote:
>> On 9/7/26 11:54, Tvrtko Ursulin wrote:
>>>
>>> On 03/09/2026 12:36, Christian König wrote:
>>>> i915_gem_busy_ioctl uses dma_resv_for_each_fence_unlocked() to iterate
>>>> over the fences in an GEM object without holding a reference but only
>>>> the RCU read side lock.
>>>>
>>>> What can happen here is that the GEM object is destroyed concurrently
>>>> while i915_gem_busy_ioctl is still running. This won't free the GEM
>>>> objects memory, but still drops all the dma_fence references.
>>>>
>>>> Now when dma_resv_for_each_fence_unlocked() sees a destroyed dma_fence it
>>>> assumes that a new fence list was installed and re-starts the loop.
>>>>
>>>> But in the case of a destroyed GEM object a new fence list is never
>>>> installed, only the old one freed and therefore the iteration never
>>>> finishes resulting in an endless loop.
>>>
>>> Only i915_busy can get into this failure mode? None of the other users of the iterator?
>>
>> Yes, at least as far as I can see.
>>
>> The problem is completely i915 specific because it is the only driver (I could find) which protects GEM objects by RCU.
>>
>>> Also, the reference counting series makes the fix irrelevant?
>>
>> No, that series just helped uncover the issue.
>>
>> Sashiko-bot correctly complained that i915 is dropping the new dma-resv reference to early resulting in potential use after free. And I was thinking wait a second when the dma_resv_fini() is called to early in the existing code then the dma_fence references are dropped to early as well... so that is an pre-existing bug.
>>
>> Before the commit mentioned in the fixes tag the i915_gem_busy_ioctl() could just return nonsense, but after that change it could result in an endless loop and that is problematic.
> 
> Where is this sashiko report, associated with which patch I mean?

See the comment here https://patchwork.freedesktop.org/patch/748868/#comment_1379963:

>> @@ -159,8 +146,7 @@ static void dma_resv_release(struct kref *kref)
>>  
>>  	dma_resv_list_free(rcu_dereference_protected(obj->fences, true));
>>  	ww_mutex_destroy(&obj->lock);
>> -	if (obj->allocated)
>> -		kfree(obj);
>> +	kfree(obj);
>>  }
> 
> [Severity: Critical]
> Does this synchronous free cause a use-after-free for concurrent lockless
> RCU readers?
> 
> In the i915 driver, GEM objects are destroyed using call_rcu() (via
> __i915_gem_free_object_rcu). Lockless readers like i915_gem_busy_ioctl()
> look up objects under rcu_read_lock() and access obj->base.resv.
> 
> If an object shares its resv instance (e.g., via obj->shares_resv_from with
> an i915_address_space), __i915_gem_free_object() drops the lock reference
> synchronously via i915_vm_resv_put(). If that drops the last reference,
> dma_resv_release() synchronously frees the memory here.
> 
> However, the GEM object itself remains valid during the RCU grace period.
> Can concurrent RCU readers dereference the already freed dma_resv pointer
> when calling dma_resv_iter_begin(&cursor, obj->base.resv, ...) in
> i915_gem_busy_ioctl()?

> Is the dma_fence_get_rcu() inside dma_resv_iter_walk_unlocked() what triggers the endless restarts?

Yes, exactly that one. When it can't grab a fence reference it tries to get a new list, but when there isn't any new list it just tries that forever.

> It's been some time since I looked at the dma-resv walks.. but fences on the list have reference held so that can trigger either via dma_resv_fini() or dma_resv_replace_fences(), right?

No, dma_resv_replace_fences() replaces an old fence with a valid new one. So the loop never becomes endless.

Same for dma_resv_reserve_fences(), here we replace a whole list with a new one and make sure that we free up the old one only after an RCU grace period.

The problem happens only when drivers incorrectly call dma_resv_fini() while a call to dma_resv_for_each_fence_unlocked() is still ongoing at the same time. And that is pretty obviously a bug.

> If second is true then how does i915 having the dma-resv containing object RCU freed cause the problem?

I also considered setting obj->fences to NULL in dma_resv_fini() as alternative workaround, but that would break again when I try to reference count the dma_resv object in the future.

So I would need to free the dma_resv object RCU safe as well just because of the problem in i915 and that is not something I like to do when it is actually a trivial fix in i915.

Regards,
Christian.

> 
> Regards,
> 
> Tvrtko
> 
>>>> The solution is to drop the fence references only after the RCU grace
>>>> period.
>>>>
>>>> The fixes tag is not necessary the patch introducing the problem, but the
>>>> one making it so worse that we need to address it.
>>>>
>>>> This problem was pointed out by Sashiko-bot.
>>>>
>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>>> Fixes: 912ff2ebd695 ("drm/i915: use the new iterator in i915_gem_busy_ioctl v2")
>>>> CC: stable@vger.kernel.org
>>>> ---
>>>>    drivers/gpu/drm/i915/gem/i915_gem_object.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.c b/drivers/gpu/drm/i915/gem/i915_gem_object.c
>>>> index 5172d3982654..9e01f8b2079a 100644
>>>> --- a/drivers/gpu/drm/i915/gem/i915_gem_object.c
>>>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_object.c
>>>> @@ -89,6 +89,7 @@ struct drm_i915_gem_object *i915_gem_object_alloc(void)
>>>>      void i915_gem_object_free(struct drm_i915_gem_object *obj)
>>>>    {
>>>> +    dma_resv_fini(&obj->base._resv);
>>>>        return kmem_cache_free(slab_objects, obj);
>>>>    }
>>>>    @@ -144,7 +145,6 @@ void __i915_gem_object_fini(struct drm_i915_gem_object *obj)
>>>>    {
>>>>        mutex_destroy(&obj->mm.get_page.lock);
>>>>        mutex_destroy(&obj->mm.get_dma_page.lock);
>>>> -    dma_resv_fini(&obj->base._resv);
>>>>    }
>>>>      /**
>>>
>>
> 

