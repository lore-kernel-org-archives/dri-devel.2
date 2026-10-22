Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68931606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=E0f7Iqo/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C59B1112710;
	Thu, 22 Oct 2026 15:30:31 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6194F11273A;
 Thu, 22 Oct 2026 15:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=SYWwh2VRytE5FRj1bzQwo6n4zw1NVdUhiGY7gh4Fghk=; b=E0f7Iqo/V4v+mUmAE3UwW8tij1
 MqOnVTo5o5e1oC1oEdO3bK8ZxMmFkCCdUt5digRtZOgRDX4gG6orhNZ+BigPkUKIl71DPaXDJ2vAQ
 iSvRUv1OmtjS75UkNU/wb0zlFYASQd6VCtHlT3vUNZKDNU9hyD+lytx/Yjqukz3kJW4UqHs/KK6py
 sLQ1CfHX6SjB3Ow3TSfjFxZsiW3UQcVZ0wVJlm3U+/6ReJk9UH/J118twZk+sFbO90lDjyPmYyunO
 zUVgojiXlDO3gXJ2vxNmCgUkNN7X9KzWIq59grTV5h1UvAeij8TZb9/UAJtWLwYZUqCIuAUr0mXe1
 /fg1vh9g==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xJukJ-006vdp-Gk; Thu, 22 Oct 2026 17:30:23 +0200
Message-ID: <e9ed9a33-80b4-4cd0-98f6-61695aa981cf@igalia.com>
Date: Thu, 22 Oct 2026 16:30:22 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH i-g-t v7 9/9] tests/cgroup_dmem: add test for dmem.current
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 igt-dev@lists.freedesktop.org
Cc: siqueira@igalia.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Christian Koenig <christian.koenig@amd.com>,
 maarten.lankhorst@linux.intel.com,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Kamil Konieczny <kamil.konieczny@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, Natalie Vock <natalie.vock@gmx.de>,
 kernel-dev@igalia.com
References: <20260923-dmem_max-v7-0-194ea47bbb4d@igalia.com>
 <20260923-dmem_max-v7-9-194ea47bbb4d@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260923-dmem_max-v7-9-194ea47bbb4d@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 23/09/2026 21:44, Thadeu Lima de Souza Cascardo wrote:
> Based on the work of Thomas Hellström to test dmem.max eviction, add a
> test for dmem.current usage after allocations and setting dmem.max.

Isn't 7/9 testing current after setting max already? I went back and 
forth a bit and isn't the new thing in this test is looking at current 
after freeing objects? Unless I got confused maybe then rename the test 
and update the commit message. One more comment below.

> Create a dmem cgroup, allocate close to capacity (or at most 4GiB),
> check current usage is within a small slack of the expected allocation.
> Then, set max to a small value and check allocations and current usage
> are limited to the max set.  Set max to less than a single BO size, then
> check no allocations are allowed and current usage is also within the
> slack. After each allocation, release memory and check current usage
> has gone down.
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> ---
>   tests/cgroup_dmem.c | 147 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 147 insertions(+)
> 
> diff --git a/tests/cgroup_dmem.c b/tests/cgroup_dmem.c
> index 7f3cfe22db2c..1f01037e1cf2 100644
> --- a/tests/cgroup_dmem.c
> +++ b/tests/cgroup_dmem.c
> @@ -36,6 +36,8 @@
>   #define BO_SIZE			SZ_64M
>   #define MAX_LIMIT		((uint64_t)4 * SZ_1G)
>   #define EVICT_STEP		SZ_128M
> +#define USAGE_POLL_MS		10
> +#define USAGE_DROP_TIMEOUT_MS	1000
>   
>   #define TEST_INTERRUPTIBLE	(1 << 0)
>   #define TEST_NONBLOCK		(1 << 1)
> @@ -48,6 +50,20 @@
>    *  and configured limits, then destroys the cgroup.
>    */
>   
> +/**
> + * SUBTEST: current
> + * DESCRIPTION:
> + *  Create a dmem cgroup, allocate close to capacity (or at most 4GiB),
> + *  check current usage is within a small slack of the expected allocation.
> + *  Then, set max to a small value and check allocations and current usage
> + *  are limited to the max set.
> + *  Set max to less than a single BO size, then check no allocations are allowed
> + *  and current usage is also within the slack.
> + *  After each allocation, release memory and check current usage has gone
> + *  down.
> + *  This subtest requires GPU device with at least one VRAM region.
> + */
> +
>   /**
>    * SUBTEST: write_eviction
>    * DESCRIPTION:
> @@ -116,6 +132,23 @@ static void install_sigcont_counter(void)
>   	sigaction(SIGCONT, &sa, &sigcont_oldact);
>   }
>   
> +static uint64_t wait_for_usage_drop(struct igt_cgroup *cg, const char *region,
> +				    uint64_t limit)
> +{
> +	uint64_t current;
> +	unsigned int elapsed = 0;
> +
> +	do {
> +		igt_cgroup_dmem_get_current(cg, region, &current);
> +		if (current <= limit)
> +			return current;
> +		usleep(USAGE_POLL_MS * 1000);
> +		elapsed += USAGE_POLL_MS;
> +	} while (elapsed < USAGE_DROP_TIMEOUT_MS);
> +
> +	return current;
> +}
> +
>   static int allocate_vram(void **handles, const struct igt_dmem_driver *drv,
>   			 void *ctx, int max_bo, size_t len)
>   {
> @@ -137,6 +170,119 @@ static int allocate_vram(void **handles, const struct igt_dmem_driver *drv,
>   	return err;
>   }
>   
> +static void free_vram(void **handles, const struct igt_dmem_driver *drv,
> +		      void *ctx, int max_bo)
> +{
> +	int i;
> +	for (i = 0; i < max_bo; i++)
> +		drv->free_vram(ctx, handles[i]);
> +}
> +
> +static void test_current(int fd, char *cg_region, unsigned int flags, const struct igt_dmem_driver *drv, void *ctx)
> +{
> +	struct igt_cgroup *cg;
> +	void **handles;
> +	uint64_t current, capacity, cg_max;
> +	int n_bo = 0, max_bo;
> +
> +	igt_cgroup_dmem_get_capacity(cg_region, &capacity);
> +	igt_require_f(capacity >= 4 * BO_SIZE,
> +		      "VRAM capacity (%"PRIu64" MiB) too small to test\n",
> +		      capacity / SZ_1M);
> +
> +	/*
> +	 * Use up to 4 GiB, or the full capacity if the device has less.
> +	 * Leave one BO_SIZE worth of headroom so the device isn't completely
> +	 * exhausted before the cgroup limit is hit.
> +	 */
> +	cg_max = min(MAX_LIMIT, capacity - BO_SIZE);
> +	cg_max = ALIGN_DOWN(cg_max, BO_SIZE);
> +
> +	/* Create cgroup and move into it */
> +	cg = igt_cgroup_new("igt_cgroups_test");
> +	igt_cgroup_move_current(cg);
> +
> +	max_bo = cg_max / BO_SIZE;
> +
> +	handles = calloc(max_bo, sizeof(handles[0]));
> +	igt_assert_f(handles, "failed to allocate handles array");
> +
> +	n_bo = allocate_vram(handles, drv, ctx, max_bo, BO_SIZE);
> +	igt_assert_f(n_bo > 0, "failed to allocate VRAM\n");
> +
> +	igt_cgroup_dmem_get_current(cg, cg_region, &current);
> +	igt_debug("After fill: cgroup current = %"PRIu64" MiB, "
> +		  "max = %"PRIu64" MiB\n",
> +		  current / SZ_1M, cg_max / SZ_1M);
> +	igt_assert_f(current == cg_max,
> +		     "current usage (%"PRIu64" MiB) is not requested allocation (%"PRIu64" MiB)\n",
> +		     current / SZ_1M, cg_max / SZ_1M);
> +
> +	free_vram(handles, drv, ctx, n_bo);
> +	wait_for_usage_drop(cg, cg_region, 0);

The fact in there is a sleeping loop makes me think dmem cgroup contract 
is not for current to go down immediate when bos are freed from 
userspace, but when the driver feels like it?

In which case, to ask an annoying question, does it ever have to go down 
(in a generic case) if no one is touching neither the fd nor the device. 
Or maybe I am misunderstanding something.

Regards,

Tvrtko

> +
> +	igt_cgroup_dmem_get_current(cg, cg_region, &current);
> +	igt_debug("After free: cgroup current = %"PRIu64" MiB, "
> +		  "max = %"PRIu64" MiB\n",
> +		  current / SZ_1M, cg_max / SZ_1M);
> +	igt_assert_f(current == 0,
> +		     "current usage (%"PRIu64" MiB) is not zero\n",
> +		     current / SZ_1M);
> +
> +	igt_cgroup_dmem_set_max(cg, cg_region, 2 * BO_SIZE, false);
> +
> +	n_bo = allocate_vram(handles, drv, ctx, max_bo, BO_SIZE);
> +	igt_assert_f(n_bo > 0, "failed to allocate VRAM\n");
> +
> +	igt_cgroup_dmem_get_current(cg, cg_region, &current);
> +	igt_debug("After fill: cgroup current = %"PRIu64" MiB, "
> +		  "max = %"PRIu64" MiB\n",
> +		  current / SZ_1M, cg_max / SZ_1M);
> +	igt_assert_f(current == 2 * BO_SIZE,
> +		     "current usage (%"PRIu64" MiB) is not requested max allocation (%"PRIu64" MiB)\n",
> +		     current / SZ_1M, cg_max / SZ_1M);
> +
> +	free_vram(handles, drv, ctx, n_bo);
> +	wait_for_usage_drop(cg, cg_region, 0);
> +
> +	igt_cgroup_dmem_get_current(cg, cg_region, &current);
> +	igt_debug("After free: cgroup current = %"PRIu64" MiB, "
> +		  "max = %"PRIu64" MiB\n",
> +		  current / SZ_1M, cg_max / SZ_1M);
> +	igt_assert_f(current == 0,
> +		     "current usage (%"PRIu64" MiB) is not zero\n",
> +		     current / SZ_1M);
> +
> +	igt_cgroup_dmem_set_max(cg, cg_region, 0, false);
> +
> +	n_bo = allocate_vram(handles, drv, ctx, max_bo, BO_SIZE);
> +
> +	/*
> +	 * amdgpu may succeed the allocation, by falling back to GTT, so no assertion here.
> +	 * Verify by reading current usage.
> +	 */
> +
> +	igt_cgroup_dmem_get_current(cg, cg_region, &current);
> +	igt_debug("After fill: cgroup current = %"PRIu64" MiB, "
> +		  "max = %"PRIu64" MiB\n",
> +		  current / SZ_1M, cg_max / SZ_1M);
> +	igt_assert_f(current == 0,
> +		     "current usage (%"PRIu64" MiB) is not zero\n",
> +		     current / SZ_1M);
> +
> +	if (n_bo > 0)
> +		free_vram(handles, drv, ctx, n_bo);
> +	wait_for_usage_drop(cg, cg_region, 0);
> +
> +	igt_cgroup_dmem_get_current(cg, cg_region, &current);
> +	igt_debug("After free: cgroup current = %"PRIu64" MiB, "
> +		  "max = %"PRIu64" MiB\n",
> +		  current / SZ_1M, cg_max / SZ_1M);
> +	igt_assert_f(current == 0,
> +		     "current usage (%"PRIu64" MiB) is not zero\n",
> +		     current / SZ_1M);
> +}
> +
>   static void test_write_eviction(int fd, char *cg_region, unsigned int flags, const struct igt_dmem_driver *drv, void *ctx)
>   {
>   	struct igt_cgroup *cg;
> @@ -246,6 +392,7 @@ static const struct {
>   	void (*test_fn)(int fd, char *cg_region, unsigned int flags, const struct igt_dmem_driver *drv, void *ctx);
>   	unsigned int flags;
>   } subtests[] = {
> +	{ "current", test_current, 0 },
>   	{ "write_eviction", test_write_eviction, 0 },
>   	{ "write_eviction_interruptible", test_write_eviction, TEST_INTERRUPTIBLE },
>   	{ "write_eviction_nonblock", test_write_eviction, TEST_NONBLOCK },
> 

