Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAE6606A32A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 14:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=eFHwDG2m
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0F55112697;
	Thu, 22 Oct 2026 14:10:34 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC25A112683;
 Thu, 22 Oct 2026 14:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=Dyu6vz+f0iLZswmgr8SGFbtm2N1KS/lekOeVwmHDSw0=; b=eFHwDG2m4iHdBWwUILinCCIzDt
 ftLrfL+qQs6zmBhOG4Ghz1fgGXzNpSimBXIBriJTMvfA/+qhdAYxDRVMc/GIRHaiGG2/2VRYRxAPq
 DrpnM3oUCfIrjFFlY7AzDyEYpL00b2TNNwkG08Gb3263neUGxAZq95Hwqmy/yVbrBsa1AdZlePbQa
 JT6TbBHwD2oaTMI3xDTYgN2sUNXncuX/beTUmz0vFbmhOhFoY6w3V/seW+LM87RrwvDlJjBjKqO5o
 bo/ZLFLNhS2CgHp05Wuo55ImPRwPzA7FDt1V3TCw5hFTha5Tf/cG+agrwOfwrP09/IxBlErnFnWtZ
 cKctZBNA==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xJtUu-006rpM-Sx; Thu, 22 Oct 2026 16:10:24 +0200
Message-ID: <7b38450a-724b-4b37-b124-e044d5e49fe3@igalia.com>
Date: Thu, 22 Oct 2026 15:10:23 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH i-g-t v7 2/9] tests/cgroup_dmem: add dmem cgroup
 controller test
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
 <20260923-dmem_max-v7-2-194ea47bbb4d@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260923-dmem_max-v7-2-194ea47bbb4d@igalia.com>
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
> Add a test that exercises the cgroup v2 dmem controller interface using
> the new igt_cgroup library.
> 
> The test uses igt_simple_main and:
>    - Skips if no dmem regions are registered (no cgroup v2 or no
>     dmem-capable device).
>    - Creates a sub-cgroup and moves the test process into it.
>    - Enumerates all registered device memory regions and prints their
>     capacity, system-wide current usage, per-cgroup current usage, and
>     configured min, low and max limits.
> 
> Assisted-by: GitHub Copilot:claude-sonnet-4.6
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> ---
>   tests/cgroup_dmem.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   tests/meson.build   |  1 +
>   2 files changed, 92 insertions(+)
> 
> diff --git a/tests/cgroup_dmem.c b/tests/cgroup_dmem.c
> new file mode 100644
> index 000000000000..2ccd8bdb00ae
> --- /dev/null
> +++ b/tests/cgroup_dmem.c
> @@ -0,0 +1,91 @@
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
> +}
> diff --git a/tests/meson.build b/tests/meson.build
> index 4f5c9be7b458..65b9a230f935 100644
> --- a/tests/meson.build
> +++ b/tests/meson.build
> @@ -1,4 +1,5 @@
>   test_progs = [
> +	'cgroup_dmem',
>   	'core_auth',
>   	'core_debugfs',
>   	'core_getclient',
> 

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko


