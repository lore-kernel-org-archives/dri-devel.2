Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC2EEC982D0
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 10:06:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC5C310E6B9;
	Thu, 17 Sep 2026 10:06:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="IHnrTBus";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E07210E6B9;
 Thu, 17 Sep 2026 10:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789639601; x=1821175601;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ow64ZZ9sQuCAD1j3JGtiSYAPm76KELMpQ6JYQh+ckJM=;
 b=IHnrTBuskmB2BLV434GK+9rTR+zXeokhooNNOuiiyoAHpZksKV+x75oS
 WQaPLif0BNtX/b15sd48RWKK1eg19aVqV/7xlqle4RQCU00oIVtJJq3Vx
 UTCRcyVAg3ZtOIcDA7A6u3bLLTWyTCFfbj3hjirtkI17/M5mqwGdqGRif
 uEAg6e67GEzPxkkE3TPxfsb0yI42DqqMNMOVno50WvQf0g0DXPd36CI2G
 mUI/cemk6SVFqx4iOv51IuktobjtpJQ9222LErtpf6bJNXKFHhnFq0mgV
 AaNPcM9jJSOJzJEs8sM5A9STKGS1w43Uqle0XNdJPfIBGk30sKadkZ6yT A==;
X-CSE-ConnectionGUID: /rQhcZL7RZSlwKd8bgw8Jw==
X-CSE-MsgGUID: L6QWWGc/RD+/ZbTW2h1Q8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90179279"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="90179279"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 03:06:30 -0700
X-CSE-ConnectionGUID: KoXcQ7YGTJmH714IbbBVdg==
X-CSE-MsgGUID: rPblGZHhSaqNYXGCWoOn4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="271065734"
Received: from kamilkon-desk.igk.intel.com (HELO localhost) ([10.211.136.201])
 by fmviesa008-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 03:06:27 -0700
Date: Thu, 17 Sep 2026 12:06:24 +0200
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
Subject: Re: [PATCH i-g-t v6 8/9] tests/cgroup_dmem: add dmem cgroup eviction
 test
Message-ID: <20260917100624.fvtcbqapqadt37dy@kamilkon-DESK.igk.intel.com>
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
 <20260903-dmem_max-v6-8-61dc62970fae@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260903-dmem_max-v6-8-61dc62970fae@igalia.com>
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
On 2026-09-03 at 19:00:30 -0300, Thadeu Lima de Souza Cascardo wrote:
> From: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> 
> The write_eviction subtest:
>  - Creates a sub-cgroup and moves the test process into it.
>  - Sets a dmem.max limit on the first VRAM region (up to 4 GiB, or
>    the full capacity if smaller).
> - Fills VRAM by repeatedly creating BOs placed in VRAM, depending on card
>   support.
>  - Verifies that cgroup current usage is within the expected range when
>    the limit is hit.
>  - Lowers dmem.max in 128 MiB steps, waiting for usage to follow each
>    reduction.
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
>  tests/cgroup_dmem.c | 149 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 149 insertions(+)
> 
> diff --git a/tests/cgroup_dmem.c b/tests/cgroup_dmem.c
> index ba5e6a2e3deb..0d3b415acd54 100644
> --- a/tests/cgroup_dmem.c
> +++ b/tests/cgroup_dmem.c
> @@ -36,9 +36,12 @@
>  
>  #define BO_SIZE			SZ_64M
>  #define MAX_LIMIT		((uint64_t)4 * SZ_1G)
> +#define EVICT_STEP		SZ_128M
>  #define USAGE_POLL_MS		10
>  #define USAGE_DROP_TIMEOUT_MS	1000
>  
> +#define TEST_INTERRUPTIBLE	(1 << 0)
> +
>  /**
>   * SUBTEST: simple
>   * DESCRIPTION:
> @@ -61,6 +64,62 @@
>   * REQUIREMENTS: xe or amdgpu device with at least one VRAM region
>   */
>  
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
> + * REQUIREMENTS: must run as root; xe device with at least one VRAM region

We do not have a subfield 'REQUIREMENTS', so why did you introduced this?
Second, almost all IGT tests should be run as root, so no point in
writing this down. imho just add this at end of description:

 *   usage follows.  This test requires GPU device with at least one VRAM region.

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
> + * REQUIREMENTS: must run as root; xe device with at least one VRAM region
> + */

Same here.



Regards,
Kamil

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
>  static uint64_t wait_for_usage_drop(struct igt_cgroup *cg, const char *region,
>  				    uint64_t limit)
>  {
> @@ -213,12 +272,102 @@ static void test_current(int fd, char *cg_region, unsigned int flags, const stru
>  	igt_cgroup_free(cg);
>  }
>  
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
> +		     "Usage %"PRIu64" MiB exceeds max %"PRIu64" MiB + slack\n",
> +		     current / SZ_1M, cg_max / SZ_1M);
> +
> +	/* Phase 2: lower max in 256 MiB steps, verify usage follows */
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
> +	igt_cgroup_free(cg);
> +}
> +
>  static const struct {
>  	const char *name;
>  	void (*test_fn)(int fd, char *cg_region, unsigned int flags, const struct igt_dmem_driver *drv, void *ctx);
>  	unsigned int flags;
>  } subtests[] = {
>  	{ "current", test_current, 0 },
> +	{ "write_eviction", test_write_eviction, 0 },
> +	{ "write_eviction_interruptible", test_write_eviction, TEST_INTERRUPTIBLE },
>  	{ }
>  };
>  
> 
> -- 
> 2.47.3
> 
