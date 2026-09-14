Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B615AC88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 10:07:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9CBC10E530;
	Mon, 14 Sep 2026 10:07:22 +0000 (UTC)
Received: from sphereful.davidgow.net (sphereful.davidgow.net [203.29.242.92])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EE6A10E530
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 10:07:21 +0000 (UTC)
Received: by sphereful.davidgow.net (Postfix, from userid 119)
 id E02FA1EAB56; Mon, 14 Sep 2026 18:07:19 +0800 (AWST)
Received: from [IPV6:2001:8003:8802:7000::9c4] (unknown
 [IPv6:2001:8003:8802:7000::9c4])
 by sphereful.davidgow.net (Postfix) with ESMTPSA id A3E3B1EAB52;
 Mon, 14 Sep 2026 18:07:18 +0800 (AWST)
Message-ID: <a03d4e21-71df-432f-b707-3c7e16a37578@davidgow.net>
Date: Mon, 14 Sep 2026 18:07:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: Increase drm_mock_sched_job_wait_finished
 timeout when CONFIG_HZ=100
To: phasta@kernel.org, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com, kunit-dev@googlegroups.com,
 Marco Pagani <marpagan@redhat.com>
References: <20260913084155.520015-2-david@davidgow.net>
 <4357c0bd2a78e88b49b7375bc18d1116df3275b6.camel@mailbox.org>
From: David Gow <david@davidgow.net>
Content-Language: fr
In-Reply-To: <4357c0bd2a78e88b49b7375bc18d1116df3275b6.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
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

Le 14/09/2026 à 5:03 PM, Philipp Stanner a écrit :
> +Cc Marco
> 
> On Sun, 2026-09-13 at 16:41 +0800, David Gow wrote:
>> The drm_sched_scheduler_overhead_tests tests hardcode a timeout of 5x
>> total_us, and fail if it's exceeded. However, on systems with
>> CONFIG_HZ < 250, this tends to fail.
>>
>> As it's possible to configure many architectures to use 100 Hz (and some,
>> such as UML, hardcode CONFIG_HZ=100), increase the timeout so that the test
>> doesn't fail on these configurations.
>>
>> Fixes: 97ef806a5314 ("drm/sched: Add some scheduling quality unit tests")
>> Signed-off-by: David Gow <david@davidgow.net>
>> ---
>>
>> This failure showed up on UML when testing the addition of CONFIG_DRM to
>> the KUnit 'alltests' config[1]. Ideally, I'd like to see this test fixed
>> (or at least skipped/disabled) on these broken configurations so that the
>> alltests run is clean. (I don't actually run any CONFIG_HZ=100 configs
>> other than UML, but fixing them all is ideal if we can manage it.)
>>
>> If you'd rather a different implementation / magic number, let me know.
>> I picked 15 here as it gave me plenty of leeway: 10 worked most, but not
>> all, of the time under i386 qemu w/ CONFIG_HZ_100, and was fine with UML
>> on this machine.
>>
>> Thanks,
>> -- David
> 
> Thx for the patch. Where are you running the tests and what for, is it
> a CI or other test system?
> 

Yeah, this is generally for KUnit in CI (and, in my case, to make sure
changes to KUnit itself don't regress other tests). But KUnit tests are
also run in several different CI systems, and now on linux-next as well.

In particular, this has been caught up whilst testing adding
CONFIG_DRM=y to the KUnit 'alltests' config, which is used to get a
config which includes as many tests as possible. This is finding some
real issues, so I think it is worthwhile in general.

> 
> So one thing about the unit tests is that they were originally not so
> much intended for being run on all sorts of CIs, but as a development
> tool for the drm_sched devs to have something to move forward with.
> That's in part why they contain "scheduling quality tests".
> 
> That caused some raised eyebrows already because people run these
> lengthy tests in CIs.

Yeah, finding the distinction between KUnit as a useful tool/framework
for writing tests and KUnit as a suite of tests that should be run
automatically is a bit tricky.

Ultimately, it's a judgement call if the benefit of having the test run
more widely (potentially uncovering real issues, or discovering issues
earlier in, e.g, linux-next merges) is worth the effort of making the
test suitably robust against all of the different environments it runs in.

> Maybe what we actually should have is a split of the test suite into
> two parts, where one part covers basic sanity, and the other measures
> scheduling behavior. The former could then be run by CI folks, the
> latter explicitly be discouraged from being run by anyone who is not a
> drm_sched-developer.
> 

That definitely can be done. As-is, the way this is currently handled is
though CONFIG_KUNIT_ALL_TESTS, and through .kunitconfig files.

If you don't want tests to be caught up in automatic systems (other, I
guess, than your own), then removing the 'default KUNIT_ALL_TESTS' (and
'if !KUNIT_ALL_TESTS' from the DRM_SCHED_KUNIT_TEST Kconfig entry is the
simplest way to do it. You could then set CONFIG_DRM_SCHED_KUNIT_TEST=y
(either via a .kunitconfig file or some other means) to run them whilst
doing drm scheduler development in particular.

And, of course, splitting suites up or skipping tests if certain
prerequisites aren't met are both options for keeping tests in the more
general CI pool if you'd like.

Cheers,
-- David

> 
> P.
> 
>>
>> [1]: https://lore.kernel.org/all/20260911-kunit-drm-v1-1-c5c0f18fc7b0@kernel.org/
>> ---
>>  drivers/gpu/drm/scheduler/tests/tests_scheduler.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/scheduler/tests/tests_scheduler.c b/drivers/gpu/drm/scheduler/tests/tests_scheduler.c
>> index 285546a2218f..02c83b5c2189 100644
>> --- a/drivers/gpu/drm/scheduler/tests/tests_scheduler.c
>> +++ b/drivers/gpu/drm/scheduler/tests/tests_scheduler.c
>> @@ -13,6 +13,13 @@
>>   * logic.
>>   */
>>  
>> +/* We need a more generous timeout when CONFIG_HZ=100. */
>> +#if CONFIG_HZ < 250
>> +#define TIMEOUT_MULTIPLIER 15
>> +#else
>> +#define TIMEOUT_MULTIPLIER 5
>> +#endif
>> +
>>  static int drm_sched_scheduler_init(struct kunit *test)
>>  {
>>  	struct drm_mock_scheduler *sched;
>> @@ -88,7 +95,7 @@ static void drm_sched_scheduler_queue_overhead(struct kunit *test)
>>  
>>  	/* Wait with a safe margin to avoid every failing. */
>>  	done = drm_mock_sched_job_wait_finished(job,
>> -						usecs_to_jiffies(total_us) * 5);
>> +						usecs_to_jiffies(total_us) * TIMEOUT_MULTIPLIER);
>>  	end = ktime_get();
>>  	KUNIT_ASSERT_TRUE(test, done);
>>  
>> @@ -149,7 +156,7 @@ static void drm_sched_scheduler_ping_pong(struct kunit *test)
>>  
>>  	/* Wait with a safe margin to avoid every failing. */
>>  	done = drm_mock_sched_job_wait_finished(job,
>> -						usecs_to_jiffies(total_us) * 5);
>> +						usecs_to_jiffies(total_us) * TIMEOUT_MULTIPLIER);
>>  	end = ktime_get();
>>  	KUNIT_ASSERT_TRUE(test, done);
>>  
> 		

