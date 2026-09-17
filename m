Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7521C88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 10:08:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC3A110E6BC;
	Thu, 17 Sep 2026 10:08:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="iZ8vfKiu";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE05510E6BC;
 Thu, 17 Sep 2026 10:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=M4bN2C7s/6zOley9omRubsgYnDZticA8q7pf30uDR1o=; b=iZ8vfKiufR/D8EEUFITCzUQ93W
 SxguyEG6HHr3uG+iJfCVlDcOzrHIulnsozIcYT5nVkZI8b9jsaNg8Mh5si1pgeShpYVK2MLZqUcz8
 FUhZqyDWK5TNNIu7/AeHI7e6R9Bmnum/0FjrkRNtuHSd4R7Uk4lBdI/gdfq6LOBMrZ7Q8i1EN47Uw
 ivzF+BQepyt1V5MQ/dd5WF2a6Xg1K4MWFN6W+3H3BjtY/Nb5NLE3w3DT5o5NmGMEV3MOQAOWbjvp/
 /BnDjpd1umh1jj9jH3s3lILGyyJ8GC/9JVpI4A7v/KC1pRZZ/3FJaSJLqz+3PanHkN5p4qiyQmm7O
 MLACkfEA==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1x792F-003LBf-TL; Thu, 17 Sep 2026 12:08:07 +0200
Message-ID: <22f3541b-6c35-406f-9caa-7ff9fe6793da@igalia.com>
Date: Thu, 17 Sep 2026 11:08:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH i-g-t v6 9/9] tests/cgroup_dmem: add
 write_eviction_nonblock subtest
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: igt-dev@lists.freedesktop.org, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, Christian Koenig <christian.koenig@amd.com>,
 maarten.lankhorst@linux.intel.com,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Kamil Konieczny <kamil.konieczny@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, Natalie Vock <natalie.vock@gmx.de>,
 kernel-dev@igalia.com
References: <20260903-dmem_max-v6-0-61dc62970fae@igalia.com>
 <20260903-dmem_max-v6-9-61dc62970fae@igalia.com>
 <ec2d6a48-f243-4990-8c22-132fb3ef1007@igalia.com>
 <aqlZQENgx5px15hb@quatroqueijos.cascardo.eti.br>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <aqlZQENgx5px15hb@quatroqueijos.cascardo.eti.br>
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


On 15/09/2026 15:42, Thadeu Lima de Souza Cascardo wrote:
> On Fri, Sep 04, 2026 at 03:51:33PM +0100, Tvrtko Ursulin wrote:
>>
>> On 03/09/2026 23:00, Thadeu Lima de Souza Cascardo wrote:
>>> From: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>>
>>> Add write_eviction_nonblock to exercise the O_NONBLOCK path of the dmem
>>> cgroup max interface.  After filling VRAM to the cgroup limit, each
>>> limit-lowering step writes dmem.max with O_NONBLOCK so that synchronous
>>> eviction is skipped.  The test then verifies that usage has not yet
>>> dropped below the new limit, allocates a small BO to trigger eviction
>>> explicitly, and finally confirms that usage falls within bounds.
>>>
>>> Assisted-by: GitHub Copilot:claude-sonnet-4.6
>>> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
>>> ---
>>>    tests/cgroup_dmem.c | 37 ++++++++++++++++++++++++++++++++++---
>>>    1 file changed, 34 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tests/cgroup_dmem.c b/tests/cgroup_dmem.c
>>> index 0d3b415acd54..ee6345c17878 100644
>>> --- a/tests/cgroup_dmem.c
>>> +++ b/tests/cgroup_dmem.c
>>> @@ -41,6 +41,7 @@
>>>    #define USAGE_DROP_TIMEOUT_MS	1000
>>>    #define TEST_INTERRUPTIBLE	(1 << 0)
>>> +#define TEST_NONBLOCK		(1 << 1)
>>>    /**
>>>     * SUBTEST: simple
>>> @@ -90,6 +91,18 @@
>>>     * REQUIREMENTS: must run as root; xe device with at least one VRAM region
>>>     */
>>> +/**
>>> + * SUBTEST: write_eviction_nonblock
>>> + * DESCRIPTION:
>>> + *   Same fill phase as write_eviction.  In the limit-lowering phase dmem.max
>>> + *   is written with O_NONBLOCK, which causes the kernel to skip synchronous
>>> + *   eviction.  After each nonblock write the test verifies that usage has not
>>> + *   yet dropped below the new limit, then triggers eviction explicitly by
>>> + *   allocating a small BO.  Finally verifies that usage falls within bounds
>>> + *   after the forced eviction.
>>> + * REQUIREMENTS: must run as root; xe device with at least one VRAM region
>>> + */
>>> +
>>>    static atomic_int signal_count;
>>>    static struct sigaction sigcont_oldact;
>>> @@ -277,7 +290,7 @@ static void test_write_eviction(int fd, char *cg_region, unsigned int flags, con
>>>    	struct igt_cgroup *cg;
>>>    	void **handles;
>>>    	int max_bo;
>>> -	uint64_t current, capacity, cg_max, limit, after;
>>> +	uint64_t current, capacity, cg_max, limit, after, before;
>>>    	int err;
>>>    	igt_cgroup_dmem_get_capacity(cg_region, &capacity);
>>> @@ -322,14 +335,31 @@ static void test_write_eviction(int fd, char *cg_region, unsigned int flags, con
>>>    	while (limit >= EVICT_STEP) {
>>>    		limit -= EVICT_STEP;
>>> -		igt_cgroup_dmem_set_max(cg, cg_region, limit, false);
>>> +
>>> +		if (flags & TEST_NONBLOCK)
>>> +			igt_cgroup_dmem_get_current(cg, cg_region, &before);
>>> +
>>> +		igt_cgroup_dmem_set_max(cg, cg_region, limit,
>>> +					!!(flags & TEST_NONBLOCK));
>>>    		igt_cgroup_dmem_get_current(cg, cg_region, &after);
>>>    		igt_debug("Lowered max to %"PRIu64" MiB: usage = %"PRIu64" MiB\n",
>>>    			  limit / SZ_1M, after / SZ_1M);
>>> +		if (flags & TEST_NONBLOCK) {
>>> +			/*
>>> +			 * O_NONBLOCK skips eviction: verify usage has not
>>> +			 * dropped below the new limit yet.
>>> +			 */
>>
>> Is this userspace ABI contract or happens to be? It feels odd - even if we
>> ask for non block for the write why would kernel not be allowed to do stuff
>> behind the covers?
>>
> 
> You bring up an interesting perspective. So maybe the test below might
> fail. But we are assuming the test is running with no other users, so this
> would be unexpected. Unless we setup dmem.min, there is no guarantee that
> eviction won't happen. However, I think the test is still useful as it is.
> We are checking that nonblocking behavior will not trigger eviction right
> away. We risk not catching up such regression if we leave it out. If we end
> up noticing on CI that this happens, we can investigate and revisit.

I looked at the commit which added it:

commit 747c4bb450adcd8b99d3543448419e1952755832
Author: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Date:   Sat Jul 25 12:00:33 2026 +0200

     cgroup/dmem: Add reclaim callback for lowering max below current usage

...

     Also honor O_NONBLOCK so that if that flag is set during the
     max value write, no reclaim is initiated. The idea is to avoid
     charging the reclaim cost to the writer of the max value.

So it was by design. I assume the charging avoidance is for the case 
when eviction needs to allocate in a different placement. Perhaps a bit 
of a kludge but perhaps I also miss some historical conversations about it.

Either way, the test itself is a-okay.

Regards,

Tvrtko

>>> +			igt_assert_f(after == before,
>>> +				     "Expected no eviction with O_NONBLOCK, but "
>>> +				     "usage dropped from %"PRIu64" MiB to %"PRIu64" MiB "
>>> +				     "(limit %"PRIu64" MiB)\n",
>>> +				     before / SZ_1M, after / SZ_1M, limit / SZ_1M);
>>> +		}
>>> +
>>>    		if (limit > EVICT_STEP) {
>>> -			if ((flags & TEST_INTERRUPTIBLE) && after > limit) {
>>> +			if ((flags & (TEST_INTERRUPTIBLE | TEST_NONBLOCK)) && after > limit) {
>>>    				/* Let a new bo creation trigger eviction. */
>>>    				void *handle;
>>>    				err = drv->allocate_vram(ctx, BO_SIZE / 8, &handle);
>>> @@ -368,6 +398,7 @@ static const struct {
>>>    	{ "current", test_current, 0 },
>>>    	{ "write_eviction", test_write_eviction, 0 },
>>>    	{ "write_eviction_interruptible", test_write_eviction, TEST_INTERRUPTIBLE },
>>> +	{ "write_eviction_nonblock", test_write_eviction, TEST_NONBLOCK },
>>>    	{ }
>>>    };
>>>
>>

