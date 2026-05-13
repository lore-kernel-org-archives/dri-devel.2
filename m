Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4945ECD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 15:21:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A682310E32C;
	Wed, 13 May 2026 15:21:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HmUyWrfE";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A68010E32C;
 Wed, 13 May 2026 15:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778685686; x=1810221686;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=B1gFXMZG4UifJDCalQPh5CCHGkLIdsb/52e5tsA+j0c=;
 b=HmUyWrfE/jsybIjvJMOXFcGVaPuUoob3xM738A5DbJNzJ41w/UwprJTP
 /7BSwFtlFUUjEK/mVTtGPFq0THXH3Wxipw9jA9jJvwqrmbGbDqOJFdESH
 Uk3kjF/1ukbujog7CbHcF2GlZJuA2KN94qT7Hp9SmrzShpwLYXI1xMIzM
 OF3XeMvgIndjyrUBz15bacABaQ5NNxJvTWAGRLr9CXHhf5BmqfsixL7lL
 jtYpudKzARvwfubz0ljiklV4TkuGD+O7ghbiT8v4rA5+tYyOkVfUIMpeY
 OetwC4MTXWwK92ezKevaciDUoq1EZqd+BN3dOTuMBMXfxixoYn/gYWwc2 Q==;
X-CSE-ConnectionGUID: ETjLozYnTQWIi7UeoqdMpw==
X-CSE-MsgGUID: dtGCWrz0To2Il9Buq40S9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="83489645"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; d="scan'208";a="83489645"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2026 08:21:25 -0700
X-CSE-ConnectionGUID: iJ22L8+3Q8WdVPIYt+NBUg==
X-CSE-MsgGUID: rPXW3bIeRwGm1IOETJhKKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; d="scan'208";a="239931938"
Received: from kamilkon-desk.igk.intel.com (HELO localhost) ([10.211.136.201])
 by fmviesa004-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 08:21:23 -0700
Date: Wed, 13 May 2026 17:21:20 +0200
From: Kamil Konieczny <kamil.konieczny@linux.intel.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: igt-dev@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Christian Koenig <christian.koenig@amd.com>,
 maarten.lankhorst@linux.intel.com,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Natalie Vock <natalie.vock@gmx.de>, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: Re: [PATCH i-g-t 3/8] Make xe_cgroup test a generic test
Message-ID: <20260513152120.yaes367qju6juxvb@kamilkon-DESK.igk.intel.com>
Mail-Followup-To: Kamil Konieczny <kamil.konieczny@linux.intel.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 igt-dev@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Christian Koenig <christian.koenig@amd.com>,
 maarten.lankhorst@linux.intel.com,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Natalie Vock <natalie.vock@gmx.de>, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
References: <20260512215156.4083082-1-cascardo@igalia.com>
 <20260512215156.4083082-4-cascardo@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260512215156.4083082-4-cascardo@igalia.com>
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
On 2026-05-12 at 18:51:50 -0300, Thadeu Lima de Souza Cascardo wrote:
> It should not be driver specific anymore. Make it run for multiple drivers,
> though there is still only Xe now.
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> ---
>  .../xe_cgroups.c => drv_dmem_cgroups.c}       | 61 +++++++++++--------

Can we start with a more generic name? imho core_cgroups.c
looks better, so it will be tests/core_cgroups.c

+cc Janusz
Cc: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>

>  tests/meson.build                             |  2 +-
>  2 files changed, 38 insertions(+), 25 deletions(-)
>  rename tests/{intel/xe_cgroups.c => drv_dmem_cgroups.c} (83%)
> 
> diff --git a/tests/intel/xe_cgroups.c b/tests/drv_dmem_cgroups.c
> similarity index 83%
> rename from tests/intel/xe_cgroups.c
> rename to tests/drv_dmem_cgroups.c
> index 9ff8d46570ab..6f4f779f3c2c 100644
> --- a/tests/intel/xe_cgroups.c
> +++ b/tests/drv_dmem_cgroups.c
> @@ -4,13 +4,12 @@
>   */
>  
>  /**
> - * TEST: xe_cgroups
> - * DESCRIPTION: Tests exercising the dmem cgroup controller on xe devices.
> + * TEST: drv_dmem_cgroups
> + * DESCRIPTION: Tests exercising the dmem cgroup controller on devices.
>   * Category: Core
>   * Mega feature: General Core features
>   * Sub-category: cgroup
>   * FUNCTIONALITY: cgroup dmem controller
> - * SUBSETS: xe
>   */
>  
>  #include <errno.h>
> @@ -26,9 +25,6 @@
>  #include "igt_aux.h"
>  #include "igt_cgroup.h"
>  #include "igt_dmem_driver.h"
> -#include "xe_drm.h"
> -#include "xe/xe_ioctl.h"
> -#include "xe/xe_query.h"
>  
>  #define BO_SIZE			SZ_128M
>  #define MAX_LIMIT		((uint64_t)4 * SZ_1G)
> @@ -45,13 +41,12 @@
>   * DESCRIPTION:
>   *   Create a dmem cgroup, move the current process into it and set the max
>   *   device memory limit for the first VRAM region to 4 GiB.  Then fill VRAM
> - *   by creating BOs with %DRM_XE_GEM_CREATE_FLAG_DEFER_BACKING (so that the
> - *   physical allocation is deferred until VM_BIND) and binding them into an
> - *   LR VM until the cgroup limit is hit.  Verify that the reported cgroup
> - *   current usage is within the expected range when the error occurs.
> + *   by creating BOs.
> + *   Verify that the reported cgroup current usage is within the expected
> + *   range when the error occurs.
>   *   Finally lower the max limit in 256 MiB steps and verify that the cgroup
>   *   usage follows.
> - * REQUIREMENTS: must run as root; xe device with at least one VRAM region
> + * REQUIREMENTS: must run as root; device with at least one VRAM region
>   */
>  
>  /**
> @@ -61,7 +56,7 @@
>   *   igt_fork_signal_helper() to verify that the dmem.max write path handles
>   *   signal interruption correctly.  A signal handler counts received signals
>   *   and the count is reported as debug output at the end of the test.
> - * REQUIREMENTS: must run as root; xe device with at least one VRAM region
> + * REQUIREMENTS: must run as root; device with at least one VRAM region

Almost all igt tests require a root, do we need this comment here?

Regards,
Kamil

>   */
>  
>  static atomic_int signal_count;
> @@ -111,7 +106,7 @@ static uint64_t wait_for_usage_drop(struct igt_cgroup *cg, const char *region,
>  	return current;
>  }
>  
> -static int fill_vram(struct igt_dmem_driver *drv, void *ctx, int fd, int max_bo)
> +static int fill_vram(const struct igt_dmem_driver *drv, void *ctx, int fd, int max_bo)
>  {
>  	int n_bo, err = 0;
>  
> @@ -128,7 +123,7 @@ static int fill_vram(struct igt_dmem_driver *drv, void *ctx, int fd, int max_bo)
>  	return n_bo;
>  }
>  
> -static void test_write_eviction(int fd, unsigned int flags, struct igt_dmem_driver *drv)
> +static void test_write_eviction(int fd, unsigned int flags, const struct igt_dmem_driver *drv)
>  {
>  	void *ctx;
>  	struct igt_cgroup *cg;
> @@ -161,7 +156,7 @@ static void test_write_eviction(int fd, unsigned int flags, struct igt_dmem_driv
>  		install_sigcont_counter();
>  
>  	/* Create cgroup and move into it */
> -	cg = igt_cgroup_new("xe_cgroups_test");
> +	cg = igt_cgroup_new("igt_cgroups_test");
>  	igt_cgroup_move_current(cg);
>  	igt_cgroup_dmem_set_max(cg, cg_region, cg_max);
>  
> @@ -236,20 +231,38 @@ static const struct {
>  	{ }
>  };
>  
> +static const struct {
> +	int driver_flag;
> +	const struct igt_dmem_driver *driver;
> +} drivers[] = {
> +	{ DRIVER_XE, &xe_dmem_driver },
> +	{ },
> +};
> +
>  int igt_main()
>  {
> -	int fd = -1;
> -
>  	igt_fixture() {
> -		fd = drm_open_driver(DRIVER_XE);
>  		igt_require_f(getuid() == 0, "Test requires root\n");
>  	}
>  
> -	for (int i = 0; subtests[i].name; i++)
> -		igt_subtest(subtests[i].name)
> -			test_write_eviction(fd, subtests[i].flags, &xe_dmem_driver);
> -
> -	igt_fixture() {
> -		drm_close_driver(fd);
> +	for (int d = 0; drivers[d].driver; d++) {
> +		igt_subtest_group() {
> +			int fd = -1;
> +			igt_fixture() {
> +				fd = drm_open_driver(drivers[d].driver_flag);
> +				igt_require_f(fd >= 0,
> +					"No %s device found, skipping\n",
> +					drivers[d].driver->name);
> +			}
> +
> +			for (int i = 0; subtests[i].name; i++)
> +				igt_subtest_f("%s-%s", drivers[d].driver->name, subtests[i].name)
> +					test_write_eviction(fd, subtests[i].flags, drivers[d].driver);
> +
> +			igt_fixture() {
> +				if (fd >= 0)
> +					drm_close_driver(fd);
> +			}
> +		}
>  	}
>  }
> diff --git a/tests/meson.build b/tests/meson.build
> index b4463a722361..deb049875b46 100644
> --- a/tests/meson.build
> +++ b/tests/meson.build
> @@ -17,6 +17,7 @@ test_progs = [
>  	'drm_mm',
>  	'drm_read',
>  	'drm_virtgpu',
> +	'drv_dmem_cgroups',
>  	'fbdev',
>  	'kms_3d',
>  	'kms_addfb_basic',
> @@ -292,7 +293,6 @@ intel_xe_progs = [
>  	'xe_dma_buf_sync',
>  	'xe_drm_fdinfo',
>  	'xe_eu_stall',
> -	'xe_cgroups',
>  	'xe_evict',
>  	'xe_evict_ccs',
>  	'xe_exec_atomic',
> -- 
> 2.47.3
> 
