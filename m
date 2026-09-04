Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A674C79F85
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:40:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0463010E565;
	Fri,  4 Sep 2026 12:40:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="MdbgDKP5";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD66110E1AB;
 Fri,  4 Sep 2026 12:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=Gw99tT+N6x1OL/o3iwipTcioh1ScKGsVIVybRoGfeaE=; b=MdbgDKP5su4pt0vUAXtIDUMvnj
 ZyunS+0GfNkJSeR6l1BMO2h/nHGQ4+RPWKCxdR21kcPKL55tVf8qtxTyHVUaSRRMHRIcKtjuiZH53
 svzN3Q+31wOKKN2BdG9ehY/fMrTyJfVE8gs4Vt6z8cXKwp6hAGghwXmMQoxAMPJuo+S2Uqt5IX20z
 eJpSOdfYwrPTGlB7ZbY56x02SmvIdhvdBpQdq+AfoYGxiICroNjjEFhVzjKzUK4mxWJCRJkxq7tb6
 hQnzuJA0NDi9+atZO8C6B47KTiR+7Lmgu8BxLPtIOYZXxC3R1V61wuHz3oqVj8VUcKNtJ372a17z1
 H/BTgzCg==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1x2TDg-00EsvX-TJ; Fri, 04 Sep 2026 14:40:36 +0200
Message-ID: <26f0c07d-5284-406e-ab26-5994859da6c0@igalia.com>
Date: Fri, 4 Sep 2026 13:40:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH i-g-t v6 7/9] tests/cgroup_dmem: add test for dmem.current
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
References: <20260903-dmem_max-v6-0-61dc62970fae@igalia.com>
 <20260903-dmem_max-v6-7-61dc62970fae@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260903-dmem_max-v6-7-61dc62970fae@igalia.com>
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


On 03/09/2026 23:00, Thadeu Lima de Souza Cascardo wrote:
> Based on the work of Thomas Hellström to test dmem.max eviction, add a
> test for dmem.current usage after allocations and setting dmem.max.
> 
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
>   tests/cgroup_dmem.c | 262 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 257 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/cgroup_dmem.c b/tests/cgroup_dmem.c
> index 442c965f9bbf..ba5e6a2e3deb 100644
> --- a/tests/cgroup_dmem.c
> +++ b/tests/cgroup_dmem.c
> @@ -1,6 +1,8 @@
>   // SPDX-License-Identifier: MIT
>   /*
>    * Copyright © 2025 Intel Corporation
> + * Copyright © 2026 Intel Corporation

This is from a patch by Thomas? I would put a Co-developed-by: or his 
SoB even if that is agreeable since Intel's copyright is being recorded.

> + * Copyright 2026 Valve Corporation
>    */
>   
>   /**
> @@ -17,10 +19,217 @@
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
> +#define USAGE_POLL_MS		10
> +#define USAGE_DROP_TIMEOUT_MS	1000
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
> + * REQUIREMENTS: xe or amdgpu device with at least one VRAM region

I am out of touch the IGT documentation requirements but assuming the 
REQUIREMENTS: is real, I would suggest instead of "xe or amdgpu device" 
you put something like "a device supported by igt_dmem_driver.c" or 
something like that.

> + */
> +
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
> +static int allocate_vram(void **handles, const struct igt_dmem_driver *drv,
> +			 void *ctx, int max_bo, size_t len)
> +{
> +	int i, err = 0;

Nit - blank lines between the declarations and bodies are a bit 
inconsistent in the patch.

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
> +	return err;
> +}
> +
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

4 * BO_SIZE = 256 Mib - is that what you intended?

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

Looking at the igt_cgroup_new() implementation there isn't any automatic 
cleanup on failure registered, right? If so, then any test failure below 
will prevent further tests from running. At least for the Intel's 
automated CI that will be a problem but I let Intel people give their 
opinion on what should happen.

> +	igt_cgroup_move_current(cg);
> +
> +	max_bo = cg_max / BO_SIZE;
> +
> +	handles = calloc(max_bo, sizeof(handles[0]));

If clearing on alloc is required then it could be that clearing in 
free_vram() also is since the array is reused in the test? Or clearing 
is not needed at either end? What I am trying to say is that it looks 
both should be the same in this respect.

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

Similar class of a problem as above - if the test fails here objects are 
not freed and because fd is shared subsquent tests will also fail, right?

On the assert itself, the strict equality may become a problem if driver 
internal objects start getting charger to the cgroup. I know there are 
plans underway to close that gap. So maybe it would be best to start 
with current >= cg_max.

> +
> +	free_vram(handles, drv, ctx, n_bo);
> +	wait_for_usage_drop(cg, cg_region, 0);

Similar as above - usage may not drop to zero all while the fd is open. 
I would make it robust by sampling a baseline at the start of the test 
and have the checks relative to it.

> +
> +	igt_cgroup_dmem_get_current(cg, cg_region, &current);
> +	igt_debug("After free: cgroup current = %"PRIu64" MiB, "
> +		  "max = %"PRIu64" MiB\n",
> +		  current / SZ_1M, cg_max / SZ_1M);
> +	igt_assert_f(current == 0,
> +		     "current usage (%"PRIu64" MiB) is not zero\n",
> +		     current / SZ_1M);
> +
> +	/* Allow for a slack as there might be some extra pages allocated. */
> +	igt_cgroup_dmem_set_max(cg, cg_region, 2 * BO_SIZE, false);

I did not get what is the slack? Max is set to 2 BOs and then below it 
is checked usage is exactly 2 BOs.

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

On APUs or even discrete? Could you make the test explicitly control it 
and ask for no automatic fallback?

Ar at least pass drivers[].driver_flag so test can have stricter 
asserts. Even strcmp on drv->name could work.

Regards,

Tvrtko

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
> +
> +	igt_cgroup_free(cg);
> +}
> +
> +static const struct {
> +	const char *name;
> +	void (*test_fn)(int fd, char *cg_region, unsigned int flags, const struct igt_dmem_driver *drv, void *ctx);
> +	unsigned int flags;
> +} subtests[] = {
> +	{ "current", test_current, 0 },
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
> @@ -32,7 +241,7 @@ static void fmt_bytes(uint64_t v, char *buf, size_t len)
>   		snprintf(buf, len, "%" PRIu64, v);
>   }
>   
> -int igt_simple_main()
> +static void simple_cgroup(void)
>   {
>   	struct igt_cgroup *cg;
>   	const char *region;
> @@ -42,10 +251,6 @@ int igt_simple_main()
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
> @@ -90,3 +295,50 @@ int igt_simple_main()
>   	igt_cgroup_dmem_regions_free(regions);
>   	igt_cgroup_free(cg);
>   }
> +
> +int igt_main()
> +{
> +	igt_fixture() {
> +		igt_require_f(getuid() == 0, "Test requires root\n");
> +		/* Check dmem cgroup controller is available before doing anything else */
> +		igt_require_f(igt_cgroup_dmem_available(),
> +			      "dmem cgroup controller not available (no cgroup v2 or no registered regions)\n");
> +
> +	}
> +
> +	igt_subtest("simple")
> +		simple_cgroup();
> +
> +	for (int d = 0; drivers[d].driver; d++) {
> +		igt_subtest_group() {
> +			int fd = -1;
> +			int ret = -1;
> +			char *cg_region = NULL;
> +			void *ctx = NULL;
> +			igt_fixture() {
> +				fd = drm_open_driver(drivers[d].driver_flag);
> +				igt_require_f(fd >= 0,
> +					"No %s device found, skipping\n",
> +					drivers[d].driver->name);
> +				ret = drivers[d].driver->init(&ctx, fd);
> +				igt_require_f(ret == 0,
> +					"Failed to initialize %s device, skipping\n",
> +					drivers[d].driver->name);
> +				cg_region = drivers[d].driver->get_region_name(ctx);
> +				igt_require_f(cg_region, "Region not tracked by dmem cgroup controller\n");
> +			}
> +
> +			for (int i = 0; subtests[i].name; i++)
> +				igt_subtest_f("%s-%s", drivers[d].driver->name, subtests[i].name)
> +					subtests[i].test_fn(fd, cg_region, subtests[i].flags, drivers[d].driver, ctx);
> +
> +			igt_fixture() {
> +				if (!ret)
> +					drivers[d].driver->deinit(ctx);
> +				if (fd >= 0)
> +					drm_close_driver(fd);
> +				free(cg_region);
> +			}
> +		}
> +	}
> +}
> 

