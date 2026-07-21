Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1720FC44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 11:55:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4230710E2D2;
	Tue, 21 Jul 2026 11:55:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="CYlN8PjA";
	dkim-atps=neutral
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com
 [91.218.175.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A590E10E2D2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 11:55:32 +0000 (UTC)
Message-ID: <c3a56e7e-1599-416e-a76d-2143656b5cf4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1784634929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ESYFlNYqnnw79nV05/D92TXtjki8hOc44KB1bg1igzo=;
 b=CYlN8PjAJVOi6Oe7Z3gOgBNAfkzrkp9GB79A+GqXzgn1VpUo1Rz/fm1rvMceKzouzNK+wg
 GWlN+evjXo6s+Zc23PHFJOnBGKlq9m8lsDlR+tszCJMxl4mj+y93t7UYMgraFXBMAzhGMe
 m9z4k4Vwc5/ZfxitsxpHmpE497D5N5k=
Date: Tue, 21 Jul 2026 13:55:22 +0200
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Marco Pagani <marco.pagani@linux.dev>
Subject: Re: [RFC PATCH] drm/sched/tests: Let the DRM scheduler manage job
 lifetimes
To: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260707114807.154572-1-marco.pagani@linux.dev>
 <46ffa75c-83e2-4f4b-9d5b-e43fdfa12176@ursulin.net>
 <f36c7c87-38c5-41f9-bd14-efc9918a4b61@linux.dev>
 <f524ee2d-c15f-4b7f-ae42-2c28b06e58b6@ursulin.net>
 <949473de-f402-44d7-9fd5-125270bdfbd9@linux.dev>
 <4dd5a686-f935-41a3-89d2-0f651061545d@ursulin.net>
Content-Language: en-US
In-Reply-To: <4dd5a686-f935-41a3-89d2-0f651061545d@ursulin.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
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



On 16/07/2026 14:14, Tvrtko Ursulin wrote:
> 
> 
> On 15/07/2026 17:02, Marco Pagani wrote:
> 
> 8<>
> 
>>> I first want to understand exactly what the issue is. The current design
>>> exactly cannot free the memory under the scheduler nose unless there is
>>> a test bug where test exited and has left the scheduler with unprocessed
>>> jobs. I am not saying we cannot have reference counted jobs but, again,
>>> at the moment I don't understand the problem.
>>
>> I think that the current design of the mock scheduler can indeed free
>> test objects' memory under the scheduler backend's nose. Consider the
>> example discussed above: the mock scheduler is instantiated and released
>> in the .init and .exit functions respectively, while jobs are allocated
>> in the test body using drm_mock_sched_job_new(). In this rather basic
>> use case, jobs' memory is freed before the entities and the scheduler
>> are released in the .exit function.
> 
> So at first I thought that as long as entity is freed at each test exit, 
> which includes idling, and is done by all current test cases (apart from 
> the parallel one where you did it via actions) it is all fine. The 
> entity->last_scheduled you mention is not a concern then since it is 
> cleared etc.
> 
> However, now I think that even if entity is idled and freed before test 
> exit that does nothing for the jobs not yet processed by the 
> drm_sched_free_job_work()-er.
> 
> Even though I was testing with KASAN I possibly did not manage to hit 
> that race. Strange but I guess possible.

It was also a surprise for me when Philipp reported a suspected UAF.
Definitely a subtle bug to catch. I managed to reproduce it by building
the kernel with KASAN and kunit.autorun enabled, and then simply booting
it with no rootfs using qemu with this slightly odd configuration:

qemu-system-x86_64 -enable-kvm -m 48G -smp cpus=18 -kernel [...]

> Unless I am missing something with the above analysis, one options is 
> along the lines of what you propose - forgo using kunit managed 
> allocations for anything mock scheduler owned. Second would be to stop 
> using test suite init/exit for the scheduler management and just make 
> each test create own scheduler and free it as it exits.

I think the second approach is still fragile. If we move
drm_mock_sched_fini() at the end of each test body, any KUNIT_ASSERT_*()
failure will cause the test to abort immediately, skipping the teardown
and leaving the scheduler in an inconsistent state that could cause any
sort of problem.

Moreover, initializing/tearing down the scheduler in the test's
init/exit functions is the most intuitive and possibly the best approach
(DRY) from a test code perspective. Asking test writers to not use the
standard init/exit functions and enforcing this limitation is a burden
that I think no one deserves to take.

> Regardless of the option, as long as it is safe against UAFs we are I 
> think good. Memory leaks on test failures are not that interesting that 
> it would warrant coming up with anything more complicated.

> Does that make sense? If so, question is which option is simpler? 
> Probably just making tests create and destroy schedulers since then 
> there is no need to deal with any memory freeing. It would be just two 
> lines added to a subset of tests, the ones which rely on .init/.exit.

I thought so too when developing the drm_gem_shmem_test some time ago,
but then I changed my mind after dealing with downstream CI. A single
test leaking some memory is not optimal, but not even a big deal per se.
However, consider hundreds of KUnit tests running periodically on a CI.
If all failing tests did not care about leaking memory, they could
seriously bog down the system. I think it's responsible to have tests
that do not leak memory when they fail.

I'll see if I can come up with a cleaner version of the kref approach,
taking into account your recommendations and Sashiko's bug report.

Thank you for your suggestions,
Marco
 
> Regards,
> 
> Tvrtko
> 

