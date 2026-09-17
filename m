Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB11C88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 09:46:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D1AC10ECB8;
	Thu, 17 Sep 2026 09:46:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fCin9IMU";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E747710E692;
 Thu, 17 Sep 2026 09:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789638365; x=1821174365;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=Lvwos+bDcxGCm+kU+UMqwnT6yriVYKFRQg992nJI2/A=;
 b=fCin9IMUEFpFIeUGsmhXsPsCyxsLlpHujKvyNRiv/8UkPn+zkicsqVnO
 z626GyUhDeM4sIvoEQ5DjQqyYWPRUT9BSVK9oZ46FQC/4ZvD82maSwCC+
 Tc6qNx4QBEIhcSb4GvTMUEsLQ6VcnKwPuQrL9Gm2VnlWUcOUhYXkJ5UFC
 84c11p71Rw9NnJKRD9DXQQQZ1sgUscKPHclCHxaKlAfU8EuQ0oOOICXfD
 Ah7ohSqBNUqw/gb+iJJJIN/J86bbQvuJuAyJujpUOrkzoAzwi3dYMF6na
 7gV1mYvVh0ASpilesZ4cSXSSjgLb87ErIDOyTkuU4IHwWKfFaEhtQPJIk w==;
X-CSE-ConnectionGUID: gZq+sgJqRee9n/4SG4lprw==
X-CSE-MsgGUID: kihspIrxRS+bGHcIxobK1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="551637"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="551637"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 02:46:05 -0700
X-CSE-ConnectionGUID: gORvuf4vT7i0YP9unWG3oQ==
X-CSE-MsgGUID: UONN/wkGToON1y62A2cIUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1906608"
Received: from kamilkon-desk.igk.intel.com (HELO localhost) ([10.211.136.201])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 02:46:02 -0700
Date: Thu, 17 Sep 2026 11:45:59 +0200
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
Subject: Re: [PATCH i-g-t v6 2/9] tests/cgroup_dmem: add dmem cgroup
 controller test
Message-ID: <20260917094559.3mgy6enka2dfeuq6@kamilkon-DESK.igk.intel.com>
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
 <20260903-dmem_max-v6-2-61dc62970fae@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260903-dmem_max-v6-2-61dc62970fae@igalia.com>
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
On 2026-09-03 at 19:00:24 -0300, Thadeu Lima de Souza Cascardo wrote:
> From: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> 
> Add a test that exercises the cgroup v2 dmem controller interface using
> the new igt_cgroup library.
> 
> The test uses igt_simple_main and:
>   - Skips if no dmem regions are registered (no cgroup v2 or no
>    dmem-capable device).
>   - Creates a sub-cgroup and moves the test process into it.
>   - Enumerates all registered device memory regions and prints their
>    capacity, system-wide current usage, per-cgroup current usage, and
>    configured min, low and max limits.
>   - Destroys the cgroup on completion.
> 
> Assisted-by: GitHub Copilot:claude-sonnet-4.6
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>  tests/cgroup_dmem.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/meson.build   |  1 +
>  2 files changed, 93 insertions(+)
> 
> diff --git a/tests/cgroup_dmem.c b/tests/cgroup_dmem.c
> new file mode 100644
> index 000000000000..442c965f9bbf
> --- /dev/null
> +++ b/tests/cgroup_dmem.c
> @@ -0,0 +1,92 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright © 2025 Intel Corporation
> + */
> +
> +/**
> + * TEST: cgroup dmem
> + * Description: Exercises the cgroup v2 dmem controller interface.  Creates a
> + *              cgroup, moves the process into it, enumerates all dmem regions,
> + *              prints their capacity, system-wide current usage, per-cgroup
> + *              current usage and configured limits, then destroys the cgroup.
> + * Category: Core
> + * Mega feature: General Core features
> + * Sub-category: uapi
> + * Functionality: cgroup
> + * Feature: dmem
> + * Test category: uapi
> + */
> +
> +#include <inttypes.h>
> +
> +#include "igt.h"
> +#include "igt_cgroup.h"
> +
> +IGT_TEST_DESCRIPTION("Exercises the cgroup v2 dmem controller interface.");
> +
> +static void fmt_bytes(uint64_t v, char *buf, size_t len)
> +{
> +	if (v == IGT_CGROUP_DMEM_MAX)
> +		snprintf(buf, len, "max");
> +	else
> +		snprintf(buf, len, "%" PRIu64, v);
> +}
> +
> +int igt_simple_main()

Can it be igt_main() with igt_fixture for require and a basic
subtest? It is not blocker, it could be converted later.

Regards,
Kamil

> +{
> +	struct igt_cgroup *cg;
> +	const char *region;
> +	char **regions;
> +	uint64_t capacity, sys_current, cg_current, min, low, max;
> +	char cap_s[32], sys_s[32], cg_s[32];
> +	char min_s[32], low_s[32], max_s[32];
> +	int i;
> +
> +	igt_require_f(igt_cgroup_dmem_available(),
> +		      "No dmem regions found; is cgroup v2 with the "
> +		      "dmem controller available?\n");
> +
> +	cg = igt_cgroup_new("igt-cgroup-dmem-test");
> +	igt_assert_f(cg, "Failed to create cgroup\n");
> +
> +	igt_cgroup_move_current(cg);
> +
> +	regions = igt_cgroup_dmem_regions();
> +	igt_assert_f(regions, "Failed to enumerate dmem regions\n");
> +
> +	igt_info("%-40s %16s %16s %16s %16s %16s %16s\n",
> +		 "region", "capacity", "system-current",
> +		 "cgroup-current", "min", "low", "max");
> +	igt_info("%-40s %16s %16s %16s %16s %16s %16s\n",
> +		 "------", "--------", "--------------",
> +		 "--------------", "---", "---", "---");
> +
> +	for (i = 0; regions[i]; i++) {
> +		region = regions[i];
> +
> +		igt_cgroup_dmem_get_capacity(region, &capacity);
> +		fmt_bytes(capacity, cap_s, sizeof(cap_s));
> +
> +		igt_cgroup_dmem_get_system_current(region, &sys_current);
> +		fmt_bytes(sys_current, sys_s, sizeof(sys_s));
> +
> +		igt_cgroup_dmem_get_current(cg, region, &cg_current);
> +		fmt_bytes(cg_current, cg_s, sizeof(cg_s));
> +
> +		igt_cgroup_dmem_get_min(cg, region, &min);
> +		fmt_bytes(min, min_s, sizeof(min_s));
> +
> +		igt_cgroup_dmem_get_low(cg, region, &low);
> +		fmt_bytes(low, low_s, sizeof(low_s));
> +
> +		igt_cgroup_dmem_get_max(cg, region, &max);
> +		fmt_bytes(max, max_s, sizeof(max_s));
> +
> +		igt_info("%-40s %16s %16s %16s %16s %16s %16s\n",
> +			 region, cap_s, sys_s, cg_s,
> +			 min_s, low_s, max_s);
> +	}
> +
> +	igt_cgroup_dmem_regions_free(regions);
> +	igt_cgroup_free(cg);
> +}
> diff --git a/tests/meson.build b/tests/meson.build
> index 1ac89bab7e15..c362d42888ba 100644
> --- a/tests/meson.build
> +++ b/tests/meson.build
> @@ -1,4 +1,5 @@
>  test_progs = [
> +	'cgroup_dmem',
>  	'core_auth',
>  	'core_debugfs',
>  	'core_getclient',
> 
> -- 
> 2.47.3
> 
