Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073F0606A320
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 14:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=WW3HK2RG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D1AC1126E0;
	Thu, 22 Oct 2026 14:56:23 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3DF01126EA;
 Thu, 22 Oct 2026 14:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=KVZXirYmjSt9t8wCQ9s8F1Og8+yXsk1FVMfEWXSHtn4=; b=WW3HK2RGz1pC94LCYMsaX9Bobg
 UP8JBO0e1JsgiDFwJjuWCfK4xWM6ao+OhpILkfc0aw6Murv7z6vMB8tSzXs9cvnv0rI1cgN3/KbI/
 /MPizUveN9WxMda7ksxfhkpSMh7iwU7ZiYGGTzDIBU+BhEIUzs9rJn+t3Ai51Xzb125khvo4AGoPw
 W0Zqx19CZO2dWF/6ZwfjbpC7KhDQcuMLfubnWywOq7/yd+2Ew7uz7o5P1wFeNePlScUoZSerh7/HE
 wCz018g8YRFvLu7j8lJBtzUyVL64Gr1AR3U5LcVqU1D/MD7TJq2p25zsg3g8PEPFocs5YjYa6btWi
 KV6dyaZQ==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xJuDG-006tz4-2p; Thu, 22 Oct 2026 16:56:14 +0200
Message-ID: <511fadfc-e165-47d3-a09d-9c2832e1862b@igalia.com>
Date: Thu, 22 Oct 2026 15:56:12 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH i-g-t v7 7/9] tests/cgroup_dmem: add dmem cgroup eviction
 test
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
 <20260923-dmem_max-v7-7-194ea47bbb4d@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260923-dmem_max-v7-7-194ea47bbb4d@igalia.com>
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 23/09/2026 21:44, Thadeu Lima de Souza Cascardo wrote:
> From: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> 
> The write_eviction subtest:
>   - Creates a sub-cgroup and moves the test process into it.
>   - Sets a dmem.max limit on the first VRAM region (up to 4 GiB, or
>     the full capacity if smaller).
> - Fills VRAM by repeatedly creating BOs placed in VRAM, depending on card
>    support.
>   - Verifies that cgroup current usage is within the expected range when
>     the limit is hit.
>   - Lowers dmem.max in 128 MiB steps, waiting for usage to follow each
>     reduction.
> 
> The write_eviction_interruptible subtest runs the same test with
> SIGCONT signals injected via igt_fork_signal_helper() and reports the
> number of signals received.  When a signal interrupts kernel-side
> eviction, a small BO allocation is used to re-trigger it.
> 
> Assisted-by: GitHub Copilot:claude-sonnet-4.6
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> ---
>   tests/cgroup_dmem.c | 285 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 279 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/cgroup_dmem.c b/tests/cgroup_dmem.c
> index 2ccd8bdb00ae..5cdb2f8830c8 100644
> --- a/tests/cgroup_dmem.c
> +++ b/tests/cgroup_dmem.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: MIT
>   /*
> - * Copyright © 2025 Intel Corporation
> + * Copyright © 2025,2026 Intel Corporation
> + * Copyright © 2026 Valve Corporation
>    */
>   
>   /**
> @@ -17,10 +18,217 @@
>    * Test category: uapi
>    */
>   
> +#include <errno.h>
>   #include <inttypes.h>
> +#include <signal.h>
> +#include <stdatomic.h>
> +#include <stdint.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
>   
> +#include "drmtest.h"
>   #include "igt.h"
> +#include "igt_aux.h"
>   #include "igt_cgroup.h"
> +#include "igt_dmem_driver.h"
> +
> +#define BO_SIZE			SZ_64M
> +#define MAX_LIMIT		((uint64_t)4 * SZ_1G)
> +#define EVICT_STEP		SZ_128M
> +
> +#define TEST_INTERRUPTIBLE	(1 << 0)
> +
> +/**
> + * SUBTEST: simple
> + * DESCRIPTION:
> + *  Creates a cgroup, moves the process into it, enumerates all dmem regions,
> + *  prints their capacity, system-wide current usage, per-cgroup current usage
> + *  and configured limits, then destroys the cgroup.
> + */
> +
> +/**
> + * SUBTEST: write_eviction
> + * DESCRIPTION:
> + *   Create a dmem cgroup, move the current process into it and set the max
> + *   device memory limit for the first VRAM region to 4 GiB.  Then fill VRAM
> + *   by creating BOs with %DRM_XE_GEM_CREATE_FLAG_DEFER_BACKING (so that the
> + *   physical allocation is deferred until VM_BIND) and binding them into an
> + *   LR VM until the cgroup limit is hit.  Verify that the reported cgroup
> + *   current usage is within the expected range when the error occurs.
> + *   Finally lower the max limit in 256 MiB steps and verify that the cgroup
> + *   usage follows.
> + *   This subtest requires GPU device with at least one VRAM region.
> + */
> +
> +/**
> + * SUBTEST: write_eviction_interruptible
> + * DESCRIPTION:
> + *   Same as write_eviction but with SIGCONT signals injected throughout via
> + *   igt_fork_signal_helper() to verify that the dmem.max write path handles
> + *   signal interruption correctly.  A signal handler counts received signals
> + *   and the count is reported as debug output at the end of the test.
> + *   A signal interrupts the set-time eviction, and further eviction can be
> + *   triggered by an explicit allocation.
> + *   This subtest requires GPU device with at least one VRAM region.
> + */
> +
> +static atomic_int signal_count;
> +static struct sigaction sigcont_oldact;
> +
> +static void sigcont_handler(int sig)
> +{
> +	atomic_fetch_add(&signal_count, 1);
> +
> +	/* Chain to the previous handler (IGT's dummy sig_handler) */
> +	if (sigcont_oldact.sa_handler &&
> +	    sigcont_oldact.sa_handler != SIG_IGN &&
> +	    sigcont_oldact.sa_handler != SIG_DFL)
> +		sigcont_oldact.sa_handler(sig);
> +}
> +
> +static void install_sigcont_counter(void)
> +{
> +	struct sigaction sa;
> +
> +	atomic_store(&signal_count, 0);
> +	igt_fork_signal_helper();
> +	/*
> +	 * Install the counter after igt_fork_signal_helper() so our handler
> +	 * is not overwritten.  Save the old handler so we can chain to it.
> +	 */
> +	memset(&sa, 0, sizeof(sa));
> +	sa.sa_handler = sigcont_handler;
> +	sigemptyset(&sa.sa_mask);
> +	sigaction(SIGCONT, &sa, &sigcont_oldact);
> +}
> +
> +static int allocate_vram(void **handles, const struct igt_dmem_driver *drv,
> +			 void *ctx, int max_bo, size_t len)
> +{
> +	int i, err = 0;
> +
> +	for (i = 0; i < max_bo; i++) {
> +		err = drv->allocate_vram(ctx, len, &handles[i]);
> +		if (err)
> +			break;
> +	}
> +	/* These are expected failures we can ignore. */
> +	if (err == -ENOMEM || err == -ENOSPC)
> +		err = 0;
> +	if (!err)
> +		return i;
> +	for (i--; i >= 0; i--)
> +		drv->free_vram(ctx, handles[i]);
> +
> +	return err;
> +}
> +
> +static void test_write_eviction(int fd, char *cg_region, unsigned int flags, const struct igt_dmem_driver *drv, void *ctx)
> +{
> +	struct igt_cgroup *cg;
> +	void **handles;
> +	int max_bo;
> +	uint64_t current, capacity, cg_max, limit, after;
> +	int err;
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
> +	cg_max = ALIGN_DOWN(cg_max, EVICT_STEP);
> +
> +	if (flags & TEST_INTERRUPTIBLE)
> +		install_sigcont_counter();

Is it okay to start the signal spam so early or it should be before the 
loop below? I guess if it works it works.. more stress testing the better.

> +
> +	/* Create cgroup and move into it */
> +	cg = igt_cgroup_new("igt_cgroups_test");
> +	igt_cgroup_move_current(cg);
> +	igt_cgroup_dmem_set_max(cg, cg_region, cg_max, false);
> +
> +	max_bo = (cg_max / BO_SIZE) + 8; /* headroom for overcommit */
> +
> +	handles = calloc(max_bo, sizeof(handles[0]));
> +	igt_assert_f(handles, "failed to allocate handles array");
> +
> +	allocate_vram(handles, drv, ctx, max_bo, BO_SIZE);
> +
> +	igt_cgroup_dmem_get_current(cg, cg_region, &current);
> +	igt_debug("After fill: cgroup current = %"PRIu64" MiB, "
> +		  "max = %"PRIu64" MiB\n",
> +		  current / SZ_1M, cg_max / SZ_1M);
> +
> +	igt_assert_f(current <= cg_max,
> +		     "Usage %"PRIu64" MiB exceeds max %"PRIu64" MiB\n",
> +		     current / SZ_1M, cg_max / SZ_1M);
> +
> +	/* Phase 2: lower max in 128 MiB steps, verify usage follows */
> +	limit = cg_max;
> +	while (limit >= EVICT_STEP) {
> +
> +		limit -= EVICT_STEP;
> +		igt_cgroup_dmem_set_max(cg, cg_region, limit, false);
> +
> +		igt_cgroup_dmem_get_current(cg, cg_region, &after);
> +		igt_debug("Lowered max to %"PRIu64" MiB: usage = %"PRIu64" MiB\n",
> +			  limit / SZ_1M, after / SZ_1M);
> +
> +		if (limit > EVICT_STEP) {
> +			if ((flags & TEST_INTERRUPTIBLE) && after > limit) {
> +				/* Let a new bo creation trigger eviction. */
> +				void *handle;
> +				err = drv->allocate_vram(ctx, BO_SIZE / 8, &handle);
> +				igt_assert_f(err == 0,
> +					"Error trying to allocate more VRAM to trigger eviction.");
> +				drv->free_vram(ctx, handle);
> +
> +				igt_cgroup_dmem_get_current(cg, cg_region, &after);
> +				igt_debug("Forced eviction max is %"PRIu64
> +					  " MiB: usage = %"PRIu64" MiB\n",
> +					  limit / SZ_1M, after / SZ_1M);
> +			}
> +
> +			igt_assert_f(after <= limit,
> +				     "Usage %"PRIu64" MiB did not follow max %"PRIu64" MiB\n",
> +				     after / SZ_1M, limit / SZ_1M);
> +		}
> +	}
> +
> +	if (flags & TEST_INTERRUPTIBLE) {
> +		igt_stop_signal_helper();
> +		igt_info("Signals received during test: %d\n",
> +			 atomic_load(&signal_count));
> +	}
> +
> +	/* Cleanup */
> +	igt_cgroup_dmem_set_max(cg, cg_region, IGT_CGROUP_DMEM_MAX, false);
> +}
> +
> +static const struct {
> +	const char *name;
> +	void (*test_fn)(int fd, char *cg_region, unsigned int flags, const struct igt_dmem_driver *drv, void *ctx);
> +	unsigned int flags;
> +} subtests[] = {
> +	{ "write_eviction", test_write_eviction, 0 },
> +	{ "write_eviction_interruptible", test_write_eviction, TEST_INTERRUPTIBLE },
> +	{ }
> +};
> +
> +static const struct {
> +	int driver_flag;
> +	const struct igt_dmem_driver *driver;
> +} drivers[] = {
> +	{ DRIVER_XE, &xe_dmem_driver },
> +	{ DRIVER_AMDGPU, &amdgpu_dmem_driver },
> +	{ },
> +};
>   
>   IGT_TEST_DESCRIPTION("Exercises the cgroup v2 dmem controller interface.");
>   
> @@ -32,7 +240,7 @@ static void fmt_bytes(uint64_t v, char *buf, size_t len)
>   		snprintf(buf, len, "%" PRIu64, v);
>   }
>   
> -int igt_simple_main()
> +static void simple_cgroup(void)
>   {
>   	struct igt_cgroup *cg;
>   	const char *region;
> @@ -42,10 +250,6 @@ int igt_simple_main()
>   	char min_s[32], low_s[32], max_s[32];
>   	int i;
>   
> -	igt_require_f(igt_cgroup_dmem_available(),
> -		      "No dmem regions found; is cgroup v2 with the "
> -		      "dmem controller available?\n");
> -
>   	cg = igt_cgroup_new("igt-cgroup-dmem-test");
>   	igt_assert_f(cg, "Failed to create cgroup\n");
>   
> @@ -89,3 +293,72 @@ int igt_simple_main()
>   
>   	igt_cgroup_dmem_regions_free(regions);
>   }
> +
> +int igt_main()
> +{
> +	igt_fixture() {
> +		igt_require_f(getuid() == 0, "Test requires root\n");

It doesn't matter for IGT but geteuid would be more correct.

> +		/* Check dmem cgroup controller is available before doing anything else */
> +		igt_require_f(igt_cgroup_dmem_available(),
> +			      "dmem cgroup controller not available (no cgroup v2 or no registered regions)\n");
> +
> +	}
> +
> +	igt_subtest("simple")
> +		simple_cgroup();

FWIW "basic" would be more in line with how we used to do it in the 
past. IIRC.

> +
> +	for (int d = 0; drivers[d].driver; d++) {
> +

Spurious blank line.

> +		int fd = -1;
> +
> +		for (int i = 0; subtests[i].name; i++) {
> +			igt_subtest_group() {
> +

Hm perhaps it was deliberate? I don't see a pattern here and in some 
cases below.

> +				int ret = -1;
> +				char *cg_region = NULL;
> +				void *ctx = NULL;
> +
> +				igt_fixture() {
> +					igt_cgroup_exit_current();
> +					if (fd >= 0) {
> +						int new_fd;

Blank line.

> +						new_fd = drm_reopen_driver(fd);
> +						drm_close_driver(fd);

This I guess frees the bos belonging to the previous subtest?

> +						fd = new_fd;
> +					} else {
> +						fd = drm_open_driver(drivers[d].driver_flag);

Strictly speaking it could use render node right? (Moot because it needs 
root to configure dmem controller.)

> +					}
> +					igt_require_f(fd >= 0,
> +						"No %s device found, skipping\n",
> +						drivers[d].driver->name);
> +					ret = drivers[d].driver->init(&ctx, fd);
> +					igt_require_f(ret == 0,
> +						"Failed to initialize %s device, skipping\n",
> +						drivers[d].driver->name);
> +					cg_region = drivers[d].driver->get_region_name(ctx);
> +					igt_require_f(cg_region, "Region not tracked by dmem cgroup controller\n");

"No regions tracked.." ?

> +				}
> +
> +				igt_subtest_f("%s-%s", drivers[d].driver->name, subtests[i].name)
> +					subtests[i].test_fn(fd, cg_region, subtests[i].flags, drivers[d].driver, ctx);

My IGT-fu is somewhat dimishied these days, but isn't one bad thing here 
that the list of subtests is not stable (as in cgroup_dmem --l)? Ie. it 
depends on the GPUs installed. In the past that was annoying for CI 
systems so we added igt_dynamic to deal with disappearing subtests. 
Maybe look into that, or perhaps nowadays people do not care.

Regards,

Tvrtko

> +
> +				igt_fixture() {
> +
> +					if (subtests[i].flags & TEST_INTERRUPTIBLE)
> +						igt_stop_signal_helper();
> +
> +					if (!ret)
> +						drivers[d].driver->deinit(ctx);
> +					free(cg_region);
> +				}
> +
> +			}
> +		}
> +
> +		igt_fixture() {
> +			if (fd >= 0)
> +				drm_close_driver(fd);
> +		}
> +
> +	}
> +}
> 

