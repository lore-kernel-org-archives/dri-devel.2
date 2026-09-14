Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05975C88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 10:07:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 338C410E43C;
	Mon, 14 Sep 2026 10:07:06 +0000 (UTC)
Received: from sphereful.davidgow.net (sphereful.davidgow.net [203.29.242.92])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3464010E43C
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 10:07:05 +0000 (UTC)
Received: by sphereful.davidgow.net (Postfix, from userid 119)
 id BA26A1EAB50; Mon, 14 Sep 2026 18:07:01 +0800 (AWST)
Received: from [IPV6:2001:8003:8802:7000::9c4] (unknown
 [IPv6:2001:8003:8802:7000::9c4])
 by sphereful.davidgow.net (Postfix) with ESMTPSA id 3F9291EAB50;
 Mon, 14 Sep 2026 18:06:58 +0800 (AWST)
Message-ID: <0ce1883f-7de3-4a16-82f0-c8950459163e@davidgow.net>
Date: Mon, 14 Sep 2026 18:06:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: Increase drm_mock_sched_job_wait_finished
 timeout when CONFIG_HZ=100
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com, kunit-dev@googlegroups.com
References: <20260913084155.520015-2-david@davidgow.net>
 <b4f017cc-3dbf-416c-b456-0c19d2f0647a@igalia.com>
From: David Gow <david@davidgow.net>
Content-Language: fr
In-Reply-To: <b4f017cc-3dbf-416c-b456-0c19d2f0647a@igalia.com>
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

Le 14/09/2026 à 4:49 PM, Tvrtko Ursulin a écrit :
> 
> On 13/09/2026 09:41, David Gow wrote:
>> The drm_sched_scheduler_overhead_tests tests hardcode a timeout of 5x
>> total_us, and fail if it's exceeded. However, on systems with
>> CONFIG_HZ < 250, this tends to fail.
> 
> Systems plural or just UML? I suppose if no hrtimer support and low HZ
> it is plausible since executing the tests needs 1000 x 1ms hrtimer
> callbacks to fire.

UML is the most important of the ones I tested (as it doesn't have a way
to increase HZ, though it did pass if I manually forced CONFIG_HZ=1000),
but even x86/x86_64 will trigger this if CONFIG_HZ_100=y.

For example, I can reproduce it with:
./tools/testing/kunit/kunit.py run --arch x86_64 --kconfig_add CONFIG_DRM=y --kconfig_add CONFIG_HZ_100=y drm_sched_scheduler_overhead_tests

> 
> Anyway, increasing the tolerance is okay-ish, with the -ish part being
> that it would be even better to skip if test could know before hand on a
> particular system it would be uselessly slow. Hence I am curious whether
> it is just UML or you could point me to other specific platforms/kconfig
> combinations where you saw it fail. In which case maybe we can come up
> with a skip criteria.

I saw it passing relatively consistently on x86 (under qemu) with
CONFIG_HZ=250, and failing consistently on everything with
CONFIG_HZ=100.
I don't think it'd be a problem to either have the test depend
on CONFIG_HZ >= 250 or use that as criteria to skip the test
altogether.

I'm happy to send out a v2 of this patch which just uses the same
criteria (CONFIG_HZ < 250) to just skip the test if you'd prefer.

Cheers,
-- David

> 
> Regards,
> 
> Tvrtko
> 
>> As it's possible to configure many architectures to use 100 Hz (and some,
>> such as UML, hardcode CONFIG_HZ=100), increase the timeout so that the
>> test
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
>>
>> [1]: https://lore.kernel.org/all/20260911-kunit-drm-v1-1-
>> c5c0f18fc7b0@kernel.org/
>> ---
>>   drivers/gpu/drm/scheduler/tests/tests_scheduler.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/scheduler/tests/tests_scheduler.c b/
>> drivers/gpu/drm/scheduler/tests/tests_scheduler.c
>> index 285546a2218f..02c83b5c2189 100644
>> --- a/drivers/gpu/drm/scheduler/tests/tests_scheduler.c
>> +++ b/drivers/gpu/drm/scheduler/tests/tests_scheduler.c
>> @@ -13,6 +13,13 @@
>>    * logic.
>>    */
>>   +/* We need a more generous timeout when CONFIG_HZ=100. */
>> +#if CONFIG_HZ < 250
>> +#define TIMEOUT_MULTIPLIER 15
>> +#else
>> +#define TIMEOUT_MULTIPLIER 5
>> +#endif
>> +
>>   static int drm_sched_scheduler_init(struct kunit *test)
>>   {
>>       struct drm_mock_scheduler *sched;
>> @@ -88,7 +95,7 @@ static void
>> drm_sched_scheduler_queue_overhead(struct kunit *test)
>>         /* Wait with a safe margin to avoid every failing. */
>>       done = drm_mock_sched_job_wait_finished(job,
>> -                        usecs_to_jiffies(total_us) * 5);
>> +                        usecs_to_jiffies(total_us) *
>> TIMEOUT_MULTIPLIER);
>>       end = ktime_get();
>>       KUNIT_ASSERT_TRUE(test, done);
>>   @@ -149,7 +156,7 @@ static void drm_sched_scheduler_ping_pong(struct
>> kunit *test)
>>         /* Wait with a safe margin to avoid every failing. */
>>       done = drm_mock_sched_job_wait_finished(job,
>> -                        usecs_to_jiffies(total_us) * 5);
>> +                        usecs_to_jiffies(total_us) *
>> TIMEOUT_MULTIPLIER);
>>       end = ktime_get();
>>       KUNIT_ASSERT_TRUE(test, done);
>>   
> 

