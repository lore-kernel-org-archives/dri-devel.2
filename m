Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED63C982D0
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 10:02:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BC8910E6B6;
	Thu, 17 Sep 2026 10:02:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Bds6e7Xq";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 698E410E6B1;
 Thu, 17 Sep 2026 10:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789639359; x=1821175359;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ckVNtsFgXhWc73VuAfKp11JBtwVgm7rZ1hf2PnBaXFw=;
 b=Bds6e7XqR63HjXLfROZJsx5i3U04rHRccG1oSf7mAJjK0y1v70A1F7YY
 Lp2o7lMOrwthlqOj2gr9+H3sHkqwN1q2RE5poBy4qh3BkVAXrQutwOtfd
 SpulSPFtOqBgwnao0+j/ZwxNsQnfFb287H7PJ8+H9z7mkGaL7yuRUoTkh
 6xD0BER+v2rujJhOVCqkMi6hiM0f1x8gznEKZR7sSTjCrxhN5aC11WJqx
 5ywSmaFzEvmYDwEeB9IZ2ZHDAWMRVLwjIg3q1oWSt2vhabt50PlXonUd1
 6VdLTiGClPjcIWVyGRl+mfVYpYAT+h8srfi+I2Eo3Kuoy158gvQ0XuzJ9 w==;
X-CSE-ConnectionGUID: nPWYCWvORMqK3w42Pp8ZGA==
X-CSE-MsgGUID: rVAPBTBoTyCY4o8SFHt5wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89911508"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89911508"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 03:02:39 -0700
X-CSE-ConnectionGUID: Nnb7nkTdQWyERZIoxRHTXg==
X-CSE-MsgGUID: q2AduYsRTCOHwNVHyO73xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1897348"
Received: from kamilkon-desk.igk.intel.com (HELO localhost) ([10.211.136.201])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 03:02:36 -0700
Date: Thu, 17 Sep 2026 12:02:33 +0200
From: Kamil Konieczny <kamil.konieczny@linux.intel.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: igt-dev@lists.freedesktop.org, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org,
 Christian Koenig <christian.koenig@amd.com>,
 maarten.lankhorst@linux.intel.com,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, kernel-dev@igalia.com
Subject: Re: [PATCH i-g-t v6 7/9] tests/cgroup_dmem: add test for dmem.current
Message-ID: <20260917100233.h2gmwkbd3jzeeytd@kamilkon-DESK.igk.intel.com>
Mail-Followup-To: Kamil Konieczny <kamil.konieczny@linux.intel.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 igt-dev@lists.freedesktop.org, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org,
 Christian Koenig <christian.koenig@amd.com>,
 maarten.lankhorst@linux.intel.com,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, kernel-dev@igalia.com
References: <20260903-dmem_max-v6-0-61dc62970fae@igalia.com>
 <20260903-dmem_max-v6-7-61dc62970fae@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260903-dmem_max-v6-7-61dc62970fae@igalia.com>
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

Hi Thadeu,
On 2026-09-03 at 19:00:29 -0300, Thadeu Lima de Souza Cascardo wrote:
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
>  tests/cgroup_dmem.c | 262 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 257 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/cgroup_dmem.c b/tests/cgroup_dmem.c
> index 442c965f9bbf..ba5e6a2e3deb 100644
> --- a/tests/cgroup_dmem.c
> +++ b/tests/cgroup_dmem.c
> @@ -1,6 +1,8 @@
>  // SPDX-License-Identifier: MIT
>  /*
>   * Copyright © 2025 Intel Corporation
> + * Copyright © 2026 Intel Corporation

Can you make it shorter? Just add 2026 to it:
   * Copyright © 2025,2026 Intel Corporation

> + * Copyright 2026 Valve Corporation

Missing (c) or its UTF char:

   * Copyright © 2026 Valve Corporation

>   */
>  
>  /**
> @@ -17,10 +19,217 @@
>   * Test category: uapi
>   */
>  
> +#include <errno.h>
>  #include <inttypes.h>
> +#include <signal.h>
> +#include <stdatomic.h>
> +#include <stdint.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
>  
> +#include "drmtest.h"
>  #include "igt.h"
> +#include "igt_aux.h"
>  #include "igt_cgroup.h"
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

Make this part of description, also imho drop xe/amdgpu, so:

 *  down. This subtest requires GPU device with at least one VRAM region.

For VRAM, add specific checks for this in beginning of test and
bail out if it is iGPU.

Regards,
Kamil

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
>  IGT_TEST_DESCRIPTION("Exercises the cgroup v2 dmem controller interface.");
>  
> @@ -32,7 +241,7 @@ static void fmt_bytes(uint64_t v, char *buf, size_t len)
>  		snprintf(buf, len, "%" PRIu64, v);
>  }
>  
> -int igt_simple_main()
> +static void simple_cgroup(void)
>  {
>  	struct igt_cgroup *cg;
>  	const char *region;
> @@ -42,10 +251,6 @@ int igt_simple_main()
>  	char min_s[32], low_s[32], max_s[32];
>  	int i;
>  
> -	igt_require_f(igt_cgroup_dmem_available(),
> -		      "No dmem regions found; is cgroup v2 with the "
> -		      "dmem controller available?\n");
> -
>  	cg = igt_cgroup_new("igt-cgroup-dmem-test");
>  	igt_assert_f(cg, "Failed to create cgroup\n");
>  
> @@ -90,3 +295,50 @@ int igt_simple_main()
>  	igt_cgroup_dmem_regions_free(regions);
>  	igt_cgroup_free(cg);
>  }
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
> -- 
> 2.47.3
> 
