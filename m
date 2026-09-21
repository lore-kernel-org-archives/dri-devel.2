Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A16C982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 15:28:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0D2D10E7C3;
	Mon, 21 Sep 2026 15:28:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jTvHa62w";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40EAA10E8A0;
 Mon, 21 Sep 2026 15:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790004479; x=1821540479;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=WqwBkOvl7Nvjw3Qx/7mvOpNWzhT1SmBWTf+g8qaRVrk=;
 b=jTvHa62wc3xwWsR5jcqN67fPRcpzP0fTjtnU8kxtR7i0QRct6enVhWTE
 FMANplb6+2LBiGBR8SR878RssO6PgpN2P2oTDfawuYtp+sQCOgqee7x0X
 Wly9VKnwzbeLzj+o8fSbplhZdHh+8AFvtcOcRr5dSOO8TaKImgcQvoR+r
 AZYDfub97iOSkPL4lwicGo82H19FrYvNsm8QtJmZ8D0LqWb8S9p7F19lR
 o+LzwybgHJMFYhvmqs3I69XZftZth2fQseAxh8FAEsA7edCtePp7ZAZU4
 x4hSugWH6YO1GrpWqO+c+EyebYzdyIJcNfPFkhc9Rd69CCBPt+WbtlPjg A==;
X-CSE-ConnectionGUID: 2MnAQQ92Qy+kO8dryC2HAA==
X-CSE-MsgGUID: YRwM6gVCQIOBkygfR+ELgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="116056953"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; d="scan'208";a="116056953"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 08:22:45 -0700
X-CSE-ConnectionGUID: t85yXTjoTWussV39ZOw2Rg==
X-CSE-MsgGUID: dw7GL3XBQ9+F6Xzjr81pTg==
X-ExtLoop1: 1
Received: from kamilkon-desk.igk.intel.com (HELO localhost) ([10.211.136.201])
 by fmviesa003-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 08:22:43 -0700
Date: Mon, 21 Sep 2026 17:22:40 +0200
From: Kamil Konieczny <kamil.konieczny@linux.intel.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: igt-dev@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 boris.brezillon@collabora.com, steven.price@arm.com,
 liviu.dudau@arm.com, adrian.larumbe@collabora.com, samitolvanen@google.com
Subject: Re: [PATCH i-g-t v2] tests/panthor: skip sparse VM_BIND tests before
 v1.9
Message-ID: <20260921152240.4j6paghgr3vktbuv@kamilkon-DESK.igk.intel.com>
Mail-Followup-To: Kamil Konieczny <kamil.konieczny@linux.intel.com>,
 Deborah Brouwer <deborah.brouwer@collabora.com>,
 igt-dev@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 boris.brezillon@collabora.com, steven.price@arm.com,
 liviu.dudau@arm.com, adrian.larumbe@collabora.com,
 samitolvanen@google.com
References: <20260920-b4-panthor_version_sparse-v2-1-fa395c125eb1@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260920-b4-panthor_version_sparse-v2-1-fa395c125eb1@collabora.com>
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

Hi Deborah,
On 2026-09-20 at 17:59:09 -0700, Deborah Brouwer wrote:

I have one more nit, see below, and an ask for you or other
panthor developers to look into igt work item on gitlab:

gputop does not work with the panthor kernel driver
https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/work_items/209

> Sparse VM_BIND support was introduced with Panthor DRM driver version
> 1.9. If a driver isn't advertising support for v1.9, skip the sparse
> VM_BIND subtests.
> 
> Use the advertised driver version rather than probing for EINVAL, since
> EINVAL may also indicate a uAPI regression rather than lack of support for
> sparse VM_BIND.
> 
> Add a shared macro igt_require_panthor_version() to check the version in
> case other Panthor tests would like to use it in the future.
> 
> The Panthor version macro wraps the igt_require_f() macro so that we can
> clear the last errno. The last errno is irrelevant to the version check
> but __igt_skip_check() will still print it like this:
> 
>   Starting subtest: vm_bind_sparse
>   Test requirement not met in function __igt_unique____real_main10, file ../tests/panthor/panthor_vm.c:296:
>   Test requirement: __igt_panthor_driver_version_at_least(fd, 1, 9)
>   Requires Panthor version 1.9 or newer
>   Last errno: 2, No such file or directory
>   Subtest vm_bind_sparse: SKIP (0.000s)
> 
> This makes the log noisier than it already is. So set the errno to 0 to
> suppress that line. Skipping the test will now print:
> 
>   Starting subtest: vm_bind_sparse
>   Test requirement not met in function __igt_unique____real_main10, file ../tests/panthor/panthor_vm.c:296:
>   Test requirement: __igt_panthor_driver_version_at_least(fd, 1, 9)
>   Requires Panthor version 1.9 or newer
>   Subtest vm_bind_sparse: SKIP (0.000s)
> 
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> ---
> Changes in v2:
> - check for version at each subtest
> - make version check available to all panthor tests
> - use macro to suppress printing the last error
> - Link to v1: https://lore.kernel.org/r/20260915-b4-panthor_version_sparse-v1-1-7ac10b75e631@collabora.com
> ---
>  lib/igt_panthor.c          | 14 ++++++++++++++
>  lib/igt_panthor.h          | 18 ++++++++++++++++++
>  tests/panthor/panthor_vm.c | 18 ++++++++++++++++++
>  3 files changed, 50 insertions(+)
> 
> diff --git a/lib/igt_panthor.c b/lib/igt_panthor.c
> index 11d8ec342..0f8c408d5 100644
> --- a/lib/igt_panthor.c
> +++ b/lib/igt_panthor.c
> @@ -385,3 +385,17 @@ void igt_panthor_free_bo(int fd, struct panthor_bo *bo)
>  
>  	gem_close(fd, bo->handle);
>  }
> +
> +bool __igt_panthor_driver_version_at_least(int fd, int major, int minor)
> +{
> +	drmVersionPtr version = drmGetVersion(fd);
> +	bool supported;
> +
> +	igt_assert(version);
> +	supported = version->version_major > major ||
> +		    (version->version_major == major &&
> +		     version->version_minor >= minor);
> +	drmFreeVersion(version);
> +
> +	return supported;
> +}
> diff --git a/lib/igt_panthor.h b/lib/igt_panthor.h
> index ba4a9bf1e..626e5d525 100644
> --- a/lib/igt_panthor.h
> +++ b/lib/igt_panthor.h
> @@ -37,6 +37,24 @@ void igt_panthor_group_submit_simple(int fd, uint32_t group_handle,
>  				     uint32_t stream_size, uint32_t syncobj_handle,
>  				     int err);
>  uint64_t igt_panthor_get_first_core(uint64_t cores_present);
> +bool __igt_panthor_driver_version_at_least(int fd, int major, int minor);
> +
> +/**
> + * igt_require_panthor_version:
> + * @fd: device file descriptor
> + * @major: required Panthor major version
> + * @minor: required Panthor minor version
> + *
> + * Require the Panthor version to be at least the requested version.
> + */
> +#define igt_require_panthor_version(fd, major, minor) do { \

Can you make it a function in test? Macro seems an overkill.
Also, it could be moved to library when there will be more
users in other tests.

Regards,
Kamil

> +	/* igt_require_f() reports errno through __igt_skip_check(); */ \
> +	/* clear it since errno is unrelated to the version check. */ \
> +	errno = 0; \
> +	igt_require_f(__igt_panthor_driver_version_at_least(fd, major, minor), \
> +		      "Requires Panthor version %d.%d or newer\n", \
> +		      major, minor); \
> +} while (0)
>  
>  static inline void igt_panthor_vm_bind(int fd, uint32_t vm_id, uint32_t bo_handle,
>  				       uint64_t va, uint64_t size, uint32_t flags, int err)
> diff --git a/tests/panthor/panthor_vm.c b/tests/panthor/panthor_vm.c
> index 9011df25e..bd8f14ecb 100644
> --- a/tests/panthor/panthor_vm.c
> +++ b/tests/panthor/panthor_vm.c
> @@ -293,6 +293,7 @@ int igt_main() {
[cut]
