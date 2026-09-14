Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D481EC88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:49:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13A1410EC1D;
	Mon, 14 Sep 2026 08:49:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="eRW76e9t";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A54510EC1D
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 08:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=yo1GY2MmHk7QkRRi3OS89hQv0DuDbZf77cOD7Bv/K5Y=; b=eRW76e9t/pKTx1me4kK1FgrslX
 FcOydG2QkjPDCEl3kafNg4I7hgGm0N3GKptacHZxPUYXZkpd3o/CXrGlg9WeS6re2TIbRkzT4HgHz
 aPNYo/EVl2lhq9SiK3W4+WeFrDx9fRyAD4ImuQRB2FEaB5aSffL5b/dLTFy8vlNuhZg62oIPGuzoB
 SLhrBxXdmKtuAwWYiIT81QpsXke97GE40qeODzAwT85KHUqo6VaTTerzZFp0vhdb3518+XJpxXzEU
 EzSvQKOyfJfBkjp5BZZKKc4aH7t73ptr6o87zl5NTBtLTsyvhyaf6UcG7ndPdgaapLHjpL2HbyMmw
 PM3xk9Jg==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1x62NY-001mqE-SS; Mon, 14 Sep 2026 10:49:32 +0200
Message-ID: <b4f017cc-3dbf-416c-b456-0c19d2f0647a@igalia.com>
Date: Mon, 14 Sep 2026 09:49:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: Increase drm_mock_sched_job_wait_finished
 timeout when CONFIG_HZ=100
To: David Gow <david@davidgow.net>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com, kunit-dev@googlegroups.com
References: <20260913084155.520015-2-david@davidgow.net>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260913084155.520015-2-david@davidgow.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 13/09/2026 09:41, David Gow wrote:
> The drm_sched_scheduler_overhead_tests tests hardcode a timeout of 5x
> total_us, and fail if it's exceeded. However, on systems with
> CONFIG_HZ < 250, this tends to fail.

Systems plural or just UML? I suppose if no hrtimer support and low HZ 
it is plausible since executing the tests needs 1000 x 1ms hrtimer 
callbacks to fire.

Anyway, increasing the tolerance is okay-ish, with the -ish part being 
that it would be even better to skip if test could know before hand on a 
particular system it would be uselessly slow. Hence I am curious whether 
it is just UML or you could point me to other specific platforms/kconfig 
combinations where you saw it fail. In which case maybe we can come up 
with a skip criteria.

Regards,

Tvrtko

> As it's possible to configure many architectures to use 100 Hz (and some,
> such as UML, hardcode CONFIG_HZ=100), increase the timeout so that the test
> doesn't fail on these configurations.
> 
> Fixes: 97ef806a5314 ("drm/sched: Add some scheduling quality unit tests")
> Signed-off-by: David Gow <david@davidgow.net>
> ---
> 
> This failure showed up on UML when testing the addition of CONFIG_DRM to
> the KUnit 'alltests' config[1]. Ideally, I'd like to see this test fixed
> (or at least skipped/disabled) on these broken configurations so that the
> alltests run is clean. (I don't actually run any CONFIG_HZ=100 configs
> other than UML, but fixing them all is ideal if we can manage it.)
> 
> If you'd rather a different implementation / magic number, let me know.
> I picked 15 here as it gave me plenty of leeway: 10 worked most, but not
> all, of the time under i386 qemu w/ CONFIG_HZ_100, and was fine with UML
> on this machine.
> 
> Thanks,
> -- David
> 
> [1]: https://lore.kernel.org/all/20260911-kunit-drm-v1-1-c5c0f18fc7b0@kernel.org/
> ---
>   drivers/gpu/drm/scheduler/tests/tests_scheduler.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/tests/tests_scheduler.c b/drivers/gpu/drm/scheduler/tests/tests_scheduler.c
> index 285546a2218f..02c83b5c2189 100644
> --- a/drivers/gpu/drm/scheduler/tests/tests_scheduler.c
> +++ b/drivers/gpu/drm/scheduler/tests/tests_scheduler.c
> @@ -13,6 +13,13 @@
>    * logic.
>    */
>   
> +/* We need a more generous timeout when CONFIG_HZ=100. */
> +#if CONFIG_HZ < 250
> +#define TIMEOUT_MULTIPLIER 15
> +#else
> +#define TIMEOUT_MULTIPLIER 5
> +#endif
> +
>   static int drm_sched_scheduler_init(struct kunit *test)
>   {
>   	struct drm_mock_scheduler *sched;
> @@ -88,7 +95,7 @@ static void drm_sched_scheduler_queue_overhead(struct kunit *test)
>   
>   	/* Wait with a safe margin to avoid every failing. */
>   	done = drm_mock_sched_job_wait_finished(job,
> -						usecs_to_jiffies(total_us) * 5);
> +						usecs_to_jiffies(total_us) * TIMEOUT_MULTIPLIER);
>   	end = ktime_get();
>   	KUNIT_ASSERT_TRUE(test, done);
>   
> @@ -149,7 +156,7 @@ static void drm_sched_scheduler_ping_pong(struct kunit *test)
>   
>   	/* Wait with a safe margin to avoid every failing. */
>   	done = drm_mock_sched_job_wait_finished(job,
> -						usecs_to_jiffies(total_us) * 5);
> +						usecs_to_jiffies(total_us) * TIMEOUT_MULTIPLIER);
>   	end = ktime_get();
>   	KUNIT_ASSERT_TRUE(test, done);
>   

