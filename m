Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA14C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 12:29:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9334A10E7C2;
	Mon,  7 Sep 2026 12:29:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="pTu8wf0q";
	dkim-atps=neutral
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6721310E7C2
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 12:28:58 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-6a374bea882so5035396a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 05:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1788784137; x=1789388937; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aJm8oYa2XMgACvK1LNx+Nj4anO8CYxc+Hsnqz6K6hAA=;
 b=pTu8wf0qriydc+ymTQCym6A3x2S2qWVOnAhEuu+gX5ChkL1AZ9oqpLa0/qzRiK8qKi
 3TPt09YBMoNqzCTafyVSYlGIdPOrZKFqdSEMWugqYUNCnK3ppHwZh0D0xEeABv/1iol0
 bceyKvBEmKy8Whzru4meSp6MwUsmojgzuJbQtT9FpQ9eoebKuHx+Mf4BLRPYr9eeMl+6
 moYsEB4G7oIWRNUrMyQbUvyuUCAsiSyx2mDO68Eq4phMe78raELCYMZS6wZ6zyFY53AU
 IhgBdy0CmjzybPrgtbrt3C812pSE47g5zrUTqK3TMN+QW5m8pK9pR5Zdbma9dpPyJVTM
 1R6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788784137; x=1789388937;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aJm8oYa2XMgACvK1LNx+Nj4anO8CYxc+Hsnqz6K6hAA=;
 b=bQ7gqZ1tkNmqCf7V57L+/Jq5BC/+o4t39VwQ7xhNI8zs3Kuvf/yeHSQhDoDD0E+QqI
 0dlkF10QgXTj+ivNybCKjp8xni7C3N6yfCIzW5/EdQidHDIZOZUhFApa5mMgbZdRpjgr
 dt2TNukdig0UXQ2MAaiBSJaUHQ5q/+MFvK17+m1NLC6Nkfy3VPZtWA6T9Wa8lyZXO1jb
 viQowkLi4Wyis1F6hJKR5qFpo80ieSdqrFr5R3jGe29cZJNAj4vIAvnZmhfKre56Lus9
 0Q+LH0gcYL39w6ksRj4khtIuyhKuHXrZertyxB7LYJkwWoVsPmw6N8PVSFMueS6rU8MQ
 +Gsg==
X-Gm-Message-State: AFuF++nNFHn0zbGlIP6szMSp5Dh7yiGeArWKIeN09Mcqo4C6DprQrCGo
 ZTtqjIyu75Hqosr0sB8EEFeJ7wMHAPAxsKOdRVbPvFmb8OCJFFFng37k7p/YQ4V0Y0s=
X-Gm-Gg: AYBFou15RZgrN9yhoOvIglHZh8JXohT3k/fnfH1PhPJeyxSLziqC9zXSNSwzeNy+vcn
 yPW8dSWNOGOYCTKdOXF2rVcyfwEb1M9+5ZnYZmHGrGjQroMSlyyEq4eZRi8LKDcV7mpG+fI+W8u
 0Cev4EBtSNaGt6irGIAp+c3yG+TRiwwRWcXYAZbg44hzJaS2J62flHdO6RVoW4mhcK4jb4KCxBV
 nRNRwbG4BjguW22NH3k8GjlyuFyLz5HRVKSuZvd4FDbECRUfBZbNzDcl9uGfRMDQhxJaf1VwxPJ
 7Urq1BBa3ebkkore4H5/9cO08b3Y87i7fkoZ6+Z0PnDBuCxuIKGFyehAYi/MsG2J+YIRQJNQoCr
 u4EXTjkbzxcVVnGoqwUPU9WLXhzWKQSHx4tVOHU/KvzLc1/VUimV0Anp1Hff9XqbmaqXDydUBRe
 EQpPAQZzbua9SLbNGkgkIhVf/A+siEbNyklzEbDVrV1kr1DKU3pH0Fq5SNJLW0CYhfzhQRUyYR3
 rLJ
X-Received: by 2002:a05:6402:270a:b0:6a6:32f5:90b4 with SMTP id
 4fb4d7f45d1cf-6a7e90a5f76mr13059715a12.22.1788784136511; 
 Mon, 07 Sep 2026 05:28:56 -0700 (PDT)
Received: from [192.168.0.116] ([81.79.79.1]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a7e66eb84dsm4416331a12.2.2026.09.07.05.28.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 05:28:56 -0700 (PDT)
Message-ID: <96eb6288-5c85-47c0-8f72-57d6f138851e@ursulin.net>
Date: Mon, 7 Sep 2026 13:28:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a
 use-after-free
From: Tvrtko Ursulin <tursulin@ursulin.net>
To: phasta@kernel.org, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>,
 matthew.brost@intel.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mdaenzer@redhat.com, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com,
 stable@vger.kernel.org
References: <20260904080618.2098450-1-malhyuk97@gmail.com>
 <20260904080618.2098450-2-malhyuk97@gmail.com>
 <f25f2a91-b72e-4392-ab53-c11ef60e0fe0@amd.com>
 <ee27d37269f609192cdfd7a217d9731d7dca04c8.camel@mailbox.org>
 <a41a35b8-c78b-4c18-af11-26374918f222@amd.com>
 <7e4497506bb051fd1c25ed54f88a8036084e779c.camel@mailbox.org>
 <81e51d72-d608-46d0-a986-390ecd6f468a@ursulin.net>
 <d3d2ae0ae55fb07780f643de9517f3668484575a.camel@mailbox.org>
 <47464619-890d-484f-986b-9a6c06cd89b0@ursulin.net>
 <c3434f0a80318390d183a3a2f8f8fb3ae71c9906.camel@mailbox.org>
 <2aa58eb8-a33f-45b9-8ee0-518d72160f41@ursulin.net>
Content-Language: en-GB
In-Reply-To: <2aa58eb8-a33f-45b9-8ee0-518d72160f41@ursulin.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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


On 07/09/2026 12:06, Tvrtko Ursulin wrote:
> 
> On 07/09/2026 11:47, Philipp Stanner wrote:
>> On Mon, 2026-09-07 at 11:28 +0100, Tvrtko Ursulin wrote:
>>>>
>>
>> […]
>>
>>>> How did the others fix that?
>>>
>>> Combination of kfree_rcu, synchronize_rcu and storing the name in an
>>> object protected by those:
>>
>> […]
>>
>>> For the scheduler (nouveau_sched_destroy()) the same, kfree_rcu.
>>>
>>> That makes scheduler timeline name vfunc safe:
>>>
>>> static const char *drm_sched_fence_get_timeline_name(struct dma_fence 
>>> *f)
>>> {
>>>     struct drm_sched_fence *fence = to_drm_sched_fence(f);
>>>     return (const char *)fence->sched->name;
>>>
>>> sched is then RCU protected. sched->name is already static so not a 
>>> concern.
>>>
>>> As you say nouveau_sched_fini() only tears down the scheduler after
>>> fences have been signaled it seems adding two new kfree_rcu make is 
>>> safe.
>>
>>
>> I don't see how any RCU mechanism would make anything here safe.
>>
>> As long as ops->release is implemented, ops will never be set to NULL,
>> (with or without RCU) – so everyone who holds a reference to finished-
>> fence can still run into drm_sched_fence_get_timeline_name() and cause
>> UAF on the sched pointer *and* the name pointer.
>>
>> Moreover, all of this falls apart should the driver unload.
>>
>> So I maintain the position that we only get it right by having the
>> signaled-bit be the decoupling point.
>>
>> Or am I missing something?
> 
> The driver fixes you asked about and I listed work(ed) in the context of 
> 506aa8b02a8d ("dma-fence: Add safe access helpers and document the 
> rules"). In that "world" it would have been safe. Did 035219a760ed 
> ("dma-buf: dma-fence: Fix potential NULL pointer dereference") break 
> those fixes a bit?
> 
> I can try my IGT and see..

With RCU frees in xe it is harder to hit it reliably for KASAN to 
notice. Guess I would need to have a way to flush the RCU callbacks from 
IGT but I did not bother with that, it seemed easier to check the 
returned name. Since it is not returning "detached-driver" / 
"detached-timeline" post signalling that proves things are indeed broken:

$ sudo tests/xe_sync_file
IGT-Version: 2.5-ge37a85b91 (x86_64) (Linux: 7.3.0-rc1+ x86_64)
Using IGT_SRANDOM=1788784104 for randomisation
Opened device: /dev/dri/card0
Starting subtest: sync_file_race
[2178.517756] (xe_sync_file:10970) CRITICAL: Test assertion failure 
function test_race, file ../tests/intel/xe_sync_file.c:130:
[2178.517790] (xe_sync_file:10970) CRITICAL: Failed assertion: 
!strcmp(driver_name, "detached-driver")
Stack trace:
   #0 ../lib/igt_core.c:2089 __igt_fail_assert()
   #1 ../tests/intel/xe_sync_file.c:155 __igt_unique____real_main136()
   #2 ../tests/intel/xe_sync_file.c:136 main()
   #3 ../sysdeps/nptl/libc_start_call_main.h:83 __libc_start_call_main()
   #4 ../csu/libc-start.c:128 __libc_start_main@@GLIBC_2.34()
   #5 [_start+0x25]
Subtest sync_file_race failed.
**** DEBUG ****
[2177.516393] (xe_sync_file:10970) DEBUG: 'drm_sched'/'rcs16' = 1
[2178.517745] (xe_sync_file:10970) DEBUG: 'drm_sched'/'rcs16' = 1
[2178.517756] (xe_sync_file:10970) CRITICAL: Test assertion failure 
function test_race, file ../tests/intel/xe_sync_file.c:130:
[2178.517790] (xe_sync_file:10970) CRITICAL: Failed assertion: 
!strcmp(driver_name, "detached-driver")
[2178.518762] (xe_sync_file:10970) igt_core-INFO: Stack trace:
[2178.523313] (xe_sync_file:10970) igt_core-INFO:   #0 
../lib/igt_core.c:2089 __igt_fail_assert()
[2178.523428] (xe_sync_file:10970) igt_core-INFO:   #1 
../tests/intel/xe_sync_file.c:155 __igt_unique____real_main136()
[2178.523436] (xe_sync_file:10970) igt_core-INFO:   #2 
../tests/intel/xe_sync_file.c:136 main()
[2178.564635] (xe_sync_file:10970) igt_core-INFO:   #3 
../sysdeps/nptl/libc_start_call_main.h:83 __libc_start_call_main()
[2178.564690] (xe_sync_file:10970) igt_core-INFO:   #4 
../csu/libc-start.c:128 __libc_start_main@@GLIBC_2.34()
[2178.564892] (xe_sync_file:10970) igt_core-INFO:   #5 [_start+0x25]
****  END  ****
Subtest sync_file_race: FAIL (1.054s)

I'll copy you on the updated IGT for reference.

Regards,

Tvrtko

