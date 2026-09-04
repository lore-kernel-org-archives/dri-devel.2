Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0353C79F89
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 14:48:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 966B910FA2A;
	Fri,  4 Sep 2026 14:48:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="qBtf9nHS";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C30E10F9EC;
 Fri,  4 Sep 2026 14:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=Z0AFrPAkSLIJZgW4DHiySn0QKCNtvNdYMlzN42SGbHw=; b=qBtf9nHS6rRERVccf+4THQ4eVJ
 P+QZqsfjvCe/H2IEunO4jmU86L7wonZ9hw1rxrGv9jz2SSqTIw28AB8vGll6zhJaUR4kRLiuldlyD
 LhzspsUrUL0YDsTRyuNvhTcZwVZwWzZ2dG5cT6mdLGOc9kVjFmsS68XmO0GuHnyzMfXTgr3OXrJfh
 5affD5CpTzDfEW5PvKx8l1MpfXOAiSH/v9BarJVZN23DBWFycgY3fj5SIjoLk3wb3TEQzLx4DGKk2
 /u7q4jSh/Z4bc5vRHhvLpcmkbzU9f+XiIHpAXqzvCgpHK0AskcKSXAK+pzSj+6YADRNvn1I/MQpvE
 MP/6KHJA==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1x2VDj-00EvoO-JA; Fri, 04 Sep 2026 16:48:47 +0200
Message-ID: <715172ab-e2c1-495b-a1a1-d95ef2563ee6@igalia.com>
Date: Fri, 4 Sep 2026 15:48:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH i-g-t v6 8/9] tests/cgroup_dmem: add dmem cgroup eviction
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
References: <20260903-dmem_max-v6-0-61dc62970fae@igalia.com>
 <20260903-dmem_max-v6-8-61dc62970fae@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260903-dmem_max-v6-8-61dc62970fae@igalia.com>
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
>   tests/cgroup_dmem.c | 149 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 149 insertions(+)
> 
> diff --git a/tests/cgroup_dmem.c b/tests/cgroup_dmem.c
> index ba5e6a2e3deb..0d3b415acd54 100644
> --- a/tests/cgroup_dmem.c
> +++ b/tests/cgroup_dmem.c
> @@ -36,9 +36,12 @@
>   
>   #define BO_SIZE			SZ_64M
>   #define MAX_LIMIT		((uint64_t)4 * SZ_1G)
> +#define EVICT_STEP		SZ_128M
>   #define USAGE_POLL_MS		10
>   #define USAGE_DROP_TIMEOUT_MS	1000
>   
> +#define TEST_INTERRUPTIBLE	(1 << 0)
> +
>   /**
>    * SUBTEST: simple
>    * DESCRIPTION:
> @@ -61,6 +64,62 @@
>    * REQUIREMENTS: xe or amdgpu device with at least one VRAM region
>    */
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

It feels that adding an explicit igt_require(DRIVER_XE) to the test 
would be a good move.

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
>   static uint64_t wait_for_usage_drop(struct igt_cgroup *cg, const char *region,
>   				    uint64_t limit)
>   {
> @@ -213,12 +272,102 @@ static void test_current(int fd, char *cg_region, unsigned int flags, const stru
>   	igt_cgroup_free(cg);
>   }
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

I stumbled upon IGT docs recommending igt_while_interruptible as a 
gentler alternative. Would that still work here and be simpler?

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

I was quite confused by what is the interrupt by signal business about. 
My best guess is the point is not to interrupt the write to the sysfs on 
the superficial level, but to interrupt the actual eviction process 
which happens during the write? Is that a cgroup requirement that the 
new limit has to become effective (or attempted at least) during the 
write itself? And once interrupted it will not re-try it until new 
"activity" in the dmem cgroup happens (the dummy allocation above)?

Regards,

Tvrtko

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
>   static const struct {
>   	const char *name;
>   	void (*test_fn)(int fd, char *cg_region, unsigned int flags, const struct igt_dmem_driver *drv, void *ctx);
>   	unsigned int flags;
>   } subtests[] = {
>   	{ "current", test_current, 0 },
> +	{ "write_eviction", test_write_eviction, 0 },
> +	{ "write_eviction_interruptible", test_write_eviction, TEST_INTERRUPTIBLE },
>   	{ }
>   };
>   
> 

