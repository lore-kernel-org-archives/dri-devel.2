Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AED8CD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 15:31:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 971F910EEFC;
	Wed, 13 May 2026 15:31:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="J2+It5B+";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4815510E313;
 Wed, 13 May 2026 15:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778686280; x=1810222280;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=zMQaxEsS1So+uYuvwRnT7buBO/fQ8iaMqPHMPkticiA=;
 b=J2+It5B+hHQAMqFLnpFeETFKhWH0n+L85FsMvLNMqkFtUaZcOX3fFyPN
 R/5S6JxGT1MT83PAM+/NGsjz/VSDswUgQcg6VtNnWSxe1o1j9Fnu2D051
 Kf4Vd9djSQzwP11iExcIHQt3LqSMAYIV2PRG6ZxgG4Svjfh9iay42NpUf
 LsJ30JkEjln1dWP6dOlmoMaa7Pg9h0/3KCnmbf/6QJ4zaeHy6MSGJ1p4C
 bj5YhVNQGLn3NpivGemjmwDLahXolYd462GQyBfq3OFCw0oFsHRCR561r
 YsSQTe9uCbNCCVhDaivtbgImuVL07fhPKbFeHOvP6+AdEvBscEigq8mGj A==;
X-CSE-ConnectionGUID: h5oRh8sIRKKHtSlSDWO6Lw==
X-CSE-MsgGUID: mzZZ4lUaS1Gp4lvQ+t4bHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="91001117"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; d="scan'208";a="91001117"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2026 08:31:20 -0700
X-CSE-ConnectionGUID: YIUIny/2TQGLrbVRZaHmvw==
X-CSE-MsgGUID: 55mp6dLITz6ZAyuXru9LRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; d="scan'208";a="239934498"
Received: from kamilkon-desk.igk.intel.com (HELO localhost) ([10.211.136.201])
 by fmviesa004-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 08:31:17 -0700
Date: Wed, 13 May 2026 17:31:15 +0200
From: Kamil Konieczny <kamil.konieczny@linux.intel.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: igt-dev@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Christian Koenig <christian.koenig@amd.com>,
 maarten.lankhorst@linux.intel.com,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Natalie Vock <natalie.vock@gmx.de>, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: Re: [PATCH i-g-t 6/8] dmem: add test for current/max
Message-ID: <20260513153115.bbfstpsrubasw4rq@kamilkon-DESK.igk.intel.com>
Mail-Followup-To: Kamil Konieczny <kamil.konieczny@linux.intel.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 igt-dev@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Christian Koenig <christian.koenig@amd.com>,
 maarten.lankhorst@linux.intel.com,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Natalie Vock <natalie.vock@gmx.de>, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
References: <20260512215156.4083082-1-cascardo@igalia.com>
 <20260512215156.4083082-7-cascardo@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260512215156.4083082-7-cascardo@igalia.com>
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
On 2026-05-12 at 18:51:53 -0300, Thadeu Lima de Souza Cascardo wrote:
> Add a test that checks for current usage after VRAM allocation and release.
> Set max to different values and track that current usage is not above max,
> given some slack.
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> ---
>  tests/drv_dmem_cgroups.c | 136 ++++++++++++++++++++++++++++++++++++++-

When you make a change in test only, add a prefix tests/a_test_name_here:
so in subject there will be:

[PATCH i-g-t 6/8] tests/drv_dmem_cgroups: add test for current/max

Btw I see below only 'current' subtest, where is 'max'?

>  1 file changed, 133 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/drv_dmem_cgroups.c b/tests/drv_dmem_cgroups.c
> index 0e26b7e2bb9a..43331117854c 100644
> --- a/tests/drv_dmem_cgroups.c
> +++ b/tests/drv_dmem_cgroups.c
> @@ -223,12 +223,142 @@ static void test_write_eviction(int fd, unsigned int flags, const struct igt_dme
>  	igt_cgroup_free(cg);
>  }
>  
> +static int allocate_vram(const struct igt_dmem_driver *drv, void *ctx, int fd, int max_bo, size_t len)
> +{
> +	int n_bo, err = 0;
> +	for (n_bo = 0; n_bo < max_bo; n_bo++) {
> +		err = drv->allocate_vram(ctx, n_bo, len);
> +		if (err)
> +			break;
> +	}
> +	return err ?: n_bo;
> +}
> +
> +static void test_current(int fd, unsigned int flags, const struct igt_dmem_driver *drv)
> +{
> +	struct igt_cgroup *cg;
> +	char *cg_region;
> +	void *ctx;
> +	uint64_t current, capacity, cg_max;
> +	int n_bo = 0, max_bo;
> +	int err;
> +
> +	cg_region = drv->get_region_name(fd);
> +	igt_require_f(cg_region, "Region not tracked by dmem cgroup controller\n");
> +
> +	/* Check dmem cgroup controller is available before doing anything else */
> +	igt_require_f(igt_cgroup_dmem_available(),
> +		      "dmem cgroup controller not available (no cgroup v2 or no registered regions)\n");
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
> +
> +	/* Create cgroup and move into it */
> +	cg = igt_cgroup_new("igt_cgroups_test");
> +	igt_cgroup_move_current(cg);
> +
> +	max_bo = cg_max / BO_SIZE;
> +
> +	err = drv->init(&ctx, fd, max_bo);
> +	igt_assert_f(!err, "Failed to initialize driver");
> +
> +	n_bo = allocate_vram(drv, ctx, fd, max_bo, BO_SIZE);
> +	igt_assert_f(n_bo > 0, "failed to allocate VRAM\n");
> +
> +	igt_cgroup_dmem_get_current(cg, cg_region, &current);
> +	igt_debug("After fill: cgroup current = %"PRIu64" MiB, "
> +		  "max = %"PRIu64" MiB\n",
> +		  current / SZ_1M, cg_max / SZ_1M);
> +	igt_assert_f(current < cg_max + USAGE_SLACK && current > cg_max - USAGE_SLACK,
> +		     "current usage (%"PRIu64" MiB) is not within margin of allocation (%"PRIu64" MiB)\n",
> +		     current / SZ_1M, cg_max / SZ_1M);
> +
> +	drv->free_vram(ctx, n_bo, BO_SIZE);
> +	sleep(1);
> +
> +	igt_cgroup_dmem_get_current(cg, cg_region, &current);
> +	igt_debug("After free: cgroup current = %"PRIu64" MiB, "
> +		  "max = %"PRIu64" MiB\n",
> +		  current / SZ_1M, cg_max / SZ_1M);
> +	igt_assert_f(current < USAGE_SLACK,
> +		     "current usage (%"PRIu64" MiB) is not within margin (%d MiB)\n",
> +		     current / SZ_1M, USAGE_SLACK / SZ_1M);
> +
> +	igt_cgroup_dmem_set_max(cg, cg_region, 2 * BO_SIZE);
> +
> +	n_bo = allocate_vram(drv, ctx, fd, max_bo, BO_SIZE);
> +	igt_assert_f(n_bo > 0, "failed to allocate VRAM\n");
> +
> +	igt_cgroup_dmem_get_current(cg, cg_region, &current);
> +	igt_debug("After fill: cgroup current = %"PRIu64" MiB, "
> +		  "max = %"PRIu64" MiB\n",
> +		  current / SZ_1M, cg_max / SZ_1M);
> +	igt_assert_f(current < 2 * BO_SIZE + USAGE_SLACK && current > 2 * BO_SIZE - USAGE_SLACK,
> +		     "current usage (%"PRIu64" MiB) is not within margin of allocation (%"PRIu64" MiB)\n",
> +		     current / SZ_1M, cg_max / SZ_1M);
> +
> +	drv->free_vram(ctx, n_bo, BO_SIZE);
> +	sleep(1);
> +
> +	igt_cgroup_dmem_get_current(cg, cg_region, &current);
> +	igt_debug("After free: cgroup current = %"PRIu64" MiB, "
> +		  "max = %"PRIu64" MiB\n",
> +		  current / SZ_1M, cg_max / SZ_1M);
> +	igt_assert_f(current < USAGE_SLACK,
> +		     "current usage (%"PRIu64" MiB) is not within margin (%d MiB)\n",
> +		     current / SZ_1M, USAGE_SLACK / SZ_1M);
> +
> +	igt_cgroup_dmem_set_max(cg, cg_region, 0);
> +
> +	n_bo = allocate_vram(drv, ctx, fd, max_bo, BO_SIZE);
> +	igt_assert_f(n_bo != -ENOMEM, "VRAM allocation succeeded despite max set to 0\n");
> +
> +	igt_cgroup_dmem_get_current(cg, cg_region, &current);
> +	igt_debug("After fill: cgroup current = %"PRIu64" MiB, "
> +		  "max = %"PRIu64" MiB\n",
> +		  current / SZ_1M, cg_max / SZ_1M);
> +	igt_assert_f(current < USAGE_SLACK,
> +		     "current usage (%"PRIu64" MiB) is not within margin\n",
> +		     current / SZ_1M);
> +
> +	if (n_bo > 0)
> +		drv->free_vram(ctx, n_bo, BO_SIZE);
> +	sleep(1);
> +
> +	igt_cgroup_dmem_get_current(cg, cg_region, &current);
> +	igt_debug("After free: cgroup current = %"PRIu64" MiB, "
> +		  "max = %"PRIu64" MiB\n",
> +		  current / SZ_1M, cg_max / SZ_1M);
> +	igt_assert_f(current < USAGE_SLACK,
> +		     "current usage (%"PRIu64" MiB) is not within margin (%d MiB)\n",
> +		     current / SZ_1M, USAGE_SLACK / SZ_1M);
> +
> +	drv->deinit(ctx);
> +	free(cg_region);
> +	igt_cgroup_free(cg);
> +}
> +
>  static const struct {
>  	const char *name;
> +	void (*test_fn)(int fd, unsigned int flags, const struct igt_dmem_driver *drv);
>  	unsigned int flags;
>  } subtests[] = {
> -	{ "write_eviction",		0 },
> -	{ "write_eviction_interruptible",	TEST_INTERRUPTIBLE },
> +	{ "current", test_current, 0 },

For each new subetest add a corresponding SUBTEST: comment section.

Regards,
Kamil

> +	{ "write_eviction", test_write_eviction, 0 },
> +	{ "write_eviction_interruptible", test_write_eviction, TEST_INTERRUPTIBLE },
>  	{ }
>  };
>  
> @@ -259,7 +389,7 @@ int igt_main()
>  
>  			for (int i = 0; subtests[i].name; i++)
>  				igt_subtest_f("%s-%s", drivers[d].driver->name, subtests[i].name)
> -					test_write_eviction(fd, subtests[i].flags, drivers[d].driver);
> +					subtests[i].test_fn(fd, subtests[i].flags, drivers[d].driver);
>  
>  			igt_fixture() {
>  				if (fd >= 0)
> -- 
> 2.47.3
> 
