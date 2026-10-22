Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884F8606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 15:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=ZCWy3+0g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6C521126EB;
	Thu, 22 Oct 2026 15:00:20 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 655FA1126EA;
 Thu, 22 Oct 2026 15:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=Md84KM8VlTJM7TzxUDP6rRLnJsjMGwh755pTZmAQAwQ=; b=ZCWy3+0gm5ZDf0/cJ306Z+X7Kb
 molEcMMyPLq6S9UxvdJ4ex9lTxxMCzEJvr/BfoyCqQDes5Qvgl54Ye1KhA/L2Cza/cqyFWfjJRg+5
 XiAyDo/3ohct5A3PJsDTqlSM3nVWDf+2EYekQbTZvXyw4UzP6AyxeRZj9YCtyfByIGDcDJ2+KrPas
 /RqGrt+Oe1g3duOL+B9nm1ruiH1Dx5TIx4iQB/6ws1LCvOC5HuOpjR30spM0Nj1lMyNnbrTwoxmrA
 LFbzbPrUH3/UcVnlNPxjE4GLpz/mUFuiCKyLb1wuBFSafahTxB9xzK6F6fSevtfAmWux5cU77mRfq
 XYgesDzA==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xJuH6-006uAi-2S; Thu, 22 Oct 2026 17:00:12 +0200
Message-ID: <caa8d644-2102-4a42-b81a-98302f57a37e@igalia.com>
Date: Thu, 22 Oct 2026 16:00:11 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH i-g-t v7 8/9] tests/cgroup_dmem: add
 write_eviction_nonblock subtest
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
 <20260923-dmem_max-v7-8-194ea47bbb4d@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260923-dmem_max-v7-8-194ea47bbb4d@igalia.com>
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
> Add write_eviction_nonblock to exercise the O_NONBLOCK path of the dmem
> cgroup max interface.  After filling VRAM to the cgroup limit, each
> limit-lowering step writes dmem.max with O_NONBLOCK so that synchronous
> eviction is skipped.  The test then verifies that usage has not yet
> dropped below the new limit, allocates a small BO to trigger eviction
> explicitly, and finally confirms that usage falls within bounds.
> 
> Assisted-by: GitHub Copilot:claude-sonnet-4.6
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> ---
>   tests/cgroup_dmem.c | 37 ++++++++++++++++++++++++++++++++++---
>   1 file changed, 34 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/cgroup_dmem.c b/tests/cgroup_dmem.c
> index 5cdb2f8830c8..7f3cfe22db2c 100644
> --- a/tests/cgroup_dmem.c
> +++ b/tests/cgroup_dmem.c
> @@ -38,6 +38,7 @@
>   #define EVICT_STEP		SZ_128M
>   
>   #define TEST_INTERRUPTIBLE	(1 << 0)
> +#define TEST_NONBLOCK		(1 << 1)
>   
>   /**
>    * SUBTEST: simple
> @@ -73,6 +74,18 @@
>    *   This subtest requires GPU device with at least one VRAM region.
>    */
>   
> +/**
> + * SUBTEST: write_eviction_nonblock
> + * DESCRIPTION:
> + *   Same fill phase as write_eviction.  In the limit-lowering phase dmem.max
> + *   is written with O_NONBLOCK, which causes the kernel to skip synchronous
> + *   eviction.  After each nonblock write the test verifies that usage has not
> + *   yet dropped below the new limit, then triggers eviction explicitly by
> + *   allocating a small BO.  Finally verifies that usage falls within bounds
> + *   after the forced eviction.
> + *   This subtest requires GPU device with at least one VRAM region.
> + */
> +
>   static atomic_int signal_count;
>   static struct sigaction sigcont_oldact;
>   
> @@ -129,7 +142,7 @@ static void test_write_eviction(int fd, char *cg_region, unsigned int flags, con
>   	struct igt_cgroup *cg;
>   	void **handles;
>   	int max_bo;
> -	uint64_t current, capacity, cg_max, limit, after;
> +	uint64_t current, capacity, cg_max, limit, after, before;
>   	int err;
>   
>   	igt_cgroup_dmem_get_capacity(cg_region, &capacity);
> @@ -174,14 +187,31 @@ static void test_write_eviction(int fd, char *cg_region, unsigned int flags, con
>   	while (limit >= EVICT_STEP) {
>   
>   		limit -= EVICT_STEP;
> -		igt_cgroup_dmem_set_max(cg, cg_region, limit, false);
> +
> +		if (flags & TEST_NONBLOCK)
> +			igt_cgroup_dmem_get_current(cg, cg_region, &before);
> +
> +		igt_cgroup_dmem_set_max(cg, cg_region, limit,
> +					!!(flags & TEST_NONBLOCK));
>   
>   		igt_cgroup_dmem_get_current(cg, cg_region, &after);
>   		igt_debug("Lowered max to %"PRIu64" MiB: usage = %"PRIu64" MiB\n",
>   			  limit / SZ_1M, after / SZ_1M);
>   
> +		if (flags & TEST_NONBLOCK) {
> +			/*
> +			 * O_NONBLOCK skips eviction: verify usage has not
> +			 * dropped below the new limit yet.
> +			 */
> +			igt_assert_f(after == before,
> +				     "Expected no eviction with O_NONBLOCK, but "
> +				     "usage dropped from %"PRIu64" MiB to %"PRIu64" MiB "
> +				     "(limit %"PRIu64" MiB)\n",
> +				     before / SZ_1M, after / SZ_1M, limit / SZ_1M);
> +		}
> +
>   		if (limit > EVICT_STEP) {
> -			if ((flags & TEST_INTERRUPTIBLE) && after > limit) {
> +			if ((flags & (TEST_INTERRUPTIBLE | TEST_NONBLOCK)) && after > limit) {
>   				/* Let a new bo creation trigger eviction. */
>   				void *handle;
>   				err = drv->allocate_vram(ctx, BO_SIZE / 8, &handle);
> @@ -218,6 +248,7 @@ static const struct {
>   } subtests[] = {
>   	{ "write_eviction", test_write_eviction, 0 },
>   	{ "write_eviction_interruptible", test_write_eviction, TEST_INTERRUPTIBLE },
> +	{ "write_eviction_nonblock", test_write_eviction, TEST_NONBLOCK },
>   	{ }
>   };
>   
> 

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

