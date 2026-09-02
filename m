Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C9FC61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:04:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8804310F0EF;
	Wed,  2 Sep 2026 10:04:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="NKl0lgE2";
	dkim-atps=neutral
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4061B10F0EF
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 10:04:32 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c25099bb1fbso104435266b.3
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 03:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1788343470; x=1788948270; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PRfZ86q63IMswZF57GVdHdFrLtck0kAywsbnrKui+Qo=;
 b=NKl0lgE28aZ3TlUlC++nq8CexHU6Ep030txxGaaN2eXOqEFA4V8MFA1ZrSd/rMbnwT
 6gB/Lz9OacIgMu2PNABoehMpdjK7JUBAI7cbN3JuHCXLRGncKv48kwPLksCusTDrM8+S
 5ysRs+6+AxqDRWgPW/H6UxU9RT348FqmeWhjFv6AUe3aymg0z37IEEuxFY8Rp6legljl
 Evoc+KznPNDhcfoGB7u+oecM0MwnV8tJa7zYfWu2OGKLlUC1GWCcO0tYxfgCgRp02R3W
 RUzM9Whb4YWXdDZzIZ2C7l9UKENXLtxPkN5idjeyE6BU7wdeWjibI9QpHiJgAjsw/+LC
 V5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788343470; x=1788948270;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PRfZ86q63IMswZF57GVdHdFrLtck0kAywsbnrKui+Qo=;
 b=Fww6U0lPFmWaLmt7jFZFgBAoRBjs7nqLsjN/lQ5XseexdKf0wlVmJThqEPXNO1cONM
 r5l/y2Br0XIDlFPGpomvY9lr2zXOKmMOXUFdagApGqs2woyJlHj4w/qPQKDDTwW+u7+O
 A3EXGLu8h1dJO/iY5uX4bAuetNsMVcCIflvNQSp8XV9FzWN4Fgin0D7FVO5yiF4QWlet
 pI2hgA1BFZ4LIOGaqyH7ZmwRKK0OmmGUj5hJ9iPss8+LJlcfNsR71vYU4f4+31F5Ym1H
 luaXfEp5LgGaWIBtXwptdeXa05tQY6tBQMkLrjDK09jsQRqmCBGV6LgSpZ264/iiTDru
 QDRg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwVygY6o4gKotUskxo9Wta+qNiRzJcErmwnzi25Wxh168O06khr/eEv5AC9rfttSjLJfik+jjxC+18=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nfX9zf48/xnjJ6QCxi0NzdHMY13OyWOfqUKLsEzAQlho7eZ3Cn
 iuhehASgc3UkrNnN+cC44Yld8nmziQ25K5QlOPDjkrv7xr0lff66uEbRrs7Vkk/QA/E=
X-Gm-Gg: AYBFou2X5UhzCAqkLzS1+wLP35JVZkmERiaYEcNP7nc+MAHK08kzWFpiT0hRRLn9CGQ
 kSPF1ZA7uNMaRHpYJkTzWnuIpKph6blJrIEG7rSCupK98QygrAgRaWKo3z2LeXGuRQmukXsbPgn
 ++Cp5dvwRzT4mbnC/wW/VoDhxWr4a1PSUR1RwKHx/qYf7yArS/vZnXafkxeYBpeFfsYchYRm+08
 2rPPEmQoST7sxLazVhZDXvw/pjPxpnfIP443c0EpieCfRLkgxpOUXXvUMX00cUvnm8QUdmjn82p
 9YQVoT8+vHeV67f1U1PmAszxzt7Pzh5LepnGeVDIHwby0UkYy7FLG/sscRpIRG2vVyfssiAoYc4
 SqRrwQpaRgUnc7LtlynPEQXcj/+ZPeoW89S3q8tWJ6Vy8+b+N/soRyn8/YCEYEE3CMvoktlOzCE
 4rbZngzln+qbjgl/U7oauGee7GoSdATpZ6EdSYg5uv+9Yp+aSI2zAUpZczZyEvo9KZX1ZEzMZu/
 uZz
X-Received: by 2002:a17:907:1c92:b0:c25:2fb9:b897 with SMTP id
 a640c23a62f3a-c25d5470752mr261560666b.18.1788343470268; 
 Wed, 02 Sep 2026 03:04:30 -0700 (PDT)
Received: from [192.168.0.116] ([81.79.79.1]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c25cffc5d85sm104365766b.1.2026.09.02.03.04.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 03:04:29 -0700 (PDT)
Message-ID: <b9fb4967-0fbd-4abb-8244-1b80c46fb1e0@ursulin.net>
Date: Wed, 2 Sep 2026 11:04:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] drm/sched/tests: add a UAF regression test for
 get_timeline_name()
To: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 Philipp Stanner <phasta@kernel.org>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <cover.1787928528.git.malhyuk97@gmail.com>
 <83d1cde658ad4c34080398ea89fc17dc1e87d5ae.1787928528.git.malhyuk97@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <83d1cde658ad4c34080398ea89fc17dc1e87d5ae.1787928528.git.malhyuk97@gmail.com>
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


On 28/08/2026 15:57, Jonghyuk Kim(MalHyuk) wrote:
> Add a KUnit test that reproduces the use-after-free fixed by the previous
> patch. It holds a reference on a job's finished drm_sched_fence (standing
> in for a userspace sync_file), frees the mock scheduler, then calls
> get_timeline_name(). Before the fix this triggers a KASAN
> slab-use-after-free read of the freed scheduler; after it the test passes.
> 
> The test needs no hardware - it exercises the drm_sched core through the
> existing mock scheduler under KASAN.
> 
> Signed-off-by: Jonghyuk Kim(MalHyuk) <malhyuk97@gmail.com>
> ---
>   drivers/gpu/drm/scheduler/tests/tests_basic.c | 65 ++++++++++++++++++-
>   1 file changed, 64 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/tests/tests_basic.c b/drivers/gpu/drm/scheduler/tests/tests_basic.c
> index a5a5a35a87b0..2c6744b58f04 100644
> --- a/drivers/gpu/drm/scheduler/tests/tests_basic.c
> +++ b/drivers/gpu/drm/scheduler/tests/tests_basic.c
> @@ -555,9 +555,72 @@ static struct kunit_suite drm_sched_credits = {
>   	.test_cases = drm_sched_credits_tests,
>   };
>   
> +/*
> + * Reproduce the drm_sched_fence get_timeline_name() lifetime bug.
> + *
> + * drm_sched_fence_get_timeline_name() dereferences fence->sched->name, and the
> + * drm_sched_fence ops keep .release set, so the fence is NOT ops-detached on
> + * signal (unlike stub fences). A driver that frees a per-context
> + * drm_gpu_scheduler while userspace still holds the exported ->finished fence
> + * (via sync_file / drm_syncobj) leaves fence->sched dangling; reading the
> + * timeline name then touches freed slab memory (arbitrary-read once the slab is
> + * re-sprayed). Confirmed instances: amdxdna, nouveau, msm. Same class as
> + * CVE-2025-38703 (xe) and CVE-2025-71302 (panthor). KASAN reports a
> + * slab-use-after-free READ in drm_sched_fence_get_timeline_name.
> + */
> +static void drm_sched_fence_get_timeline_name_uaf(struct kunit *test)
> +{
> +	struct drm_mock_sched_entity *entity;
> +	struct drm_mock_scheduler *sched;
> +	struct drm_mock_sched_job *job;
> +	struct dma_fence *finished;
> +	const char *name;
> +	bool done;
> +
> +	sched = drm_mock_sched_new(test, MAX_SCHEDULE_TIMEOUT);
> +	entity = drm_mock_sched_entity_new(test, DRM_SCHED_PRIORITY_NORMAL,
> +					   sched);
> +	job = drm_mock_sched_job_new(test, entity);
> +
> +	/* Arm + submit first; the s_fence is only created by drm_sched_job_arm(). */
> +	drm_mock_sched_job_submit(job);
> +
> +	/* Independent reference on the finished fence == userspace sync_file. */
> +	finished = dma_fence_get(&job->base.s_fence->finished);
> +
> +	/* Let the job get picked up (hw_fence created), then signal + finish. */
> +	done = drm_mock_sched_job_wait_scheduled(job, HZ);
> +	KUNIT_ASSERT_TRUE(test, done);
> +	drm_mock_sched_advance(sched, 1);
> +	done = drm_mock_sched_job_wait_finished(job, HZ);
> +	KUNIT_ASSERT_TRUE(test, done);
> +
> +	/* Free the per-context scheduler while the finished fence is held. */
> +	drm_mock_sched_entity_free(entity);
> +	drm_mock_sched_fini(sched);
> +	kunit_kfree(test, sched);
> +
> +	/* UAF read: fence->sched->name is read from the freed scheduler. */
> +	name = finished->ops->get_timeline_name(finished);

It would be better to use the API (dma_fence_timeline_name()). It should 
still reproduce, no?

Bigger question is does this belong in the scheduler unit tests. 
Strictly no, there is no requirement scheduler fences have to be 
exported to userspace. De facto yes, most (all?) DRM scheduler users do 
it so I guess pragmatic thing would be to allow it.

Perhaps not in tests_basic.c but chuck it to a new tests_integration.c 
and call it drm-sched-dma-fence-uaf or something?

Regards,

Tvrtko

> +	kunit_info(test, "get_timeline_name() on stale fence returned %p\n", name);
> +
> +	dma_fence_put(finished);
> +}
> +
> +static struct kunit_case drm_sched_fence_uaf_tests[] = {
> +	KUNIT_CASE(drm_sched_fence_get_timeline_name_uaf),
> +	{}
> +};
> +
> +static struct kunit_suite drm_sched_fence_uaf = {
> +	.name = "drm_sched_fence_uaf_tests",
> +	.test_cases = drm_sched_fence_uaf_tests,
> +};
> +
>   kunit_test_suites(&drm_sched_basic,
>   		  &drm_sched_timeout,
>   		  &drm_sched_cancel,
>   		  &drm_sched_priority,
>   		  &drm_sched_modify_sched,
> -		  &drm_sched_credits);
> +		  &drm_sched_credits,
> +		  &drm_sched_fence_uaf);

