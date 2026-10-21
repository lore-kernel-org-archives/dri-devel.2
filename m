Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCDD606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 22:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M80IoC7d
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8562110E02E;
	Wed, 21 Oct 2026 22:03:36 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2619510E02E;
 Wed, 21 Oct 2026 22:03:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5054360098;
 Wed, 21 Oct 2026 22:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1531F000C2;
 Wed, 21 Oct 2026 22:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792620209;
 bh=SGraS/VayzGCTJrYsXxZMmeSokrzDoq1NtWr2zpZuUY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=M80IoC7d/KRmwXF8cXUVlCuRyTN27cJjQ40rfQq1lx4j4qdaLhkwuezE2EOc0FZde
 tTL3yVg7Zd5JbpypeTXRWybenMJXc3V6FGv1HbluFNb3pVYdH4tC1PNQJHwOAdv41U
 BEVzUhaO5FQrrD42KXJKtO3Skx3L0hDojI4I4syjYRxd+9iseAeIHHZcyPX9gpcVp7
 f2CuN7bt2ebs6Bp40pXX9Hq8TyqP231JcpMUmFK6JWuVP/rV3y/1/Ie2cKStgdrLXN
 8Kw+T/qCaivi0xkbeHIcbR3C2QyC3O+xirK4slY1NfzbDUwLU4wNAC0CmWuqtSOwmV
 AGvQYeVsJkzCg==
Date: Thu, 22 Oct 2026 00:03:26 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Jani Nikula <jani.nikula@linux.intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>, 
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>, 
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v5 1/6] drm/i915/selftests: Use gt_*/drm_* prints in core
 selftests
Message-ID: <atkzD99digX-p3KI@zenone.zhora.eu>
References: <20261001074100.2694888-1-krzysztof.karas@intel.com>
 <20261001074100.2694888-2-krzysztof.karas@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001074100.2694888-2-krzysztof.karas@intel.com>
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Krzysztof,

On Thu, Oct 01, 2026 at 07:40:55AM +0000, Krzysztof Karas wrote:
> Move away from generic pr prints to GT aware gt_* versions,
> which tag each message with device and the tile it came from.
> 
> i915_perf.c now uses drm_* prints, as it reports on a device
> wide perf stream with no GT to attribute the message to.
> 
> Ensure that 80 character line limit is respected wherever
> possible.
> 
> Assisted-by: GitHub-Copilot:claude-opus-5

Assisted-by: LLM

> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> ---
> v5:
>  * No changes since v4;
>  * Rebased;
> 
>  .../gpu/drm/i915/selftests/i915_gem_evict.c   |  52 +++--
>  drivers/gpu/drm/i915/selftests/i915_gem_gtt.c | 164 +++++++++-----
>  drivers/gpu/drm/i915/selftests/i915_perf.c    |  30 ++-
>  drivers/gpu/drm/i915/selftests/i915_request.c | 206 ++++++++++++------
>  drivers/gpu/drm/i915/selftests/i915_vma.c     | 187 ++++++++++------
>  drivers/gpu/drm/i915/selftests/intel_uncore.c |  24 +-
>  6 files changed, 433 insertions(+), 230 deletions(-)

This patch is too long, for now it's OK as I've managed to go
through it already. But please, next time (not next version),
make it shorter.

...

> @@ -1849,7 +1893,8 @@ static int live_breadcrumbs_smoketest(void *arg)
>  		num_fences += atomic_long_read(&smoke[idx].num_fences);
>  		idx++;
>  	}
> -	pr_info("Completed %lu waits for %lu fences across %d engines and %d cpus\n",
> +	gt_info(engine->gt,
> +		"Completed %lu waits for %lu fences across %d engines and %d cpus\n",
>  		num_waits, num_fences, idx, ncpus);

you end up here in a NULL pointer dereference because this is
printed after a for_each_uabi_engine() which exits when engine is
NULL.

You can use drm_info() here.

>  
>  	ret = igt_live_test_end(&live) ?: ret;

...

> @@ -2929,7 +2989,8 @@ static int perf_series_engines(void *arg)
>  				decimal = 0;
>  			}
>  
> -			pr_info("%s %5s: { seqno:%d, busy:%d.%02d%%, runtime:%lldms, walltime:%lldms }\n",
> +			gt_info(engine->gt,
> +				"%s %5s: { seqno:%d, busy:%d.%02d%%, runtime:%lldms, walltime:%lldms }\n",
>  				name, p->engine->name, ce->timeline->seqno,
>  				integer, decimal,
>  				div_u64(p->runtime, 1000 * 1000),

For the same reason this should be:

gt_info(p->engine->gt, ...);

Andi
