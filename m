Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A240C4451C
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:00:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 641A310F559;
	Fri, 17 Jul 2026 13:00:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mcgvd3sE";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74C2D10E2C9;
 Fri, 17 Jul 2026 13:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784293240; x=1815829240;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=TkcnxLhgwX6O5nJjNSjksAcUqdGQAPjb6pfqo7xQWDU=;
 b=mcgvd3sELtoV8xXwZIsZDw0ErFuWXj9hiq7i8Pd8tis1aBV0FBkVcS66
 ASdIY6PbDEgLStpZB2HkIXISmH3B8w5rbfap7QgEMBmJbvw6DoK0ytZx5
 XxEA6iCrhD6LVZ2arVl6c89XA44qFOEbNPLmFjcIg5h6K0VCC5ldSKKYF
 KYF350yxklgBzVVA6KIyCMN86kYIF95Gwu2tL54xlWx+1sdDGvY6KKZlu
 2C+MC8ozC0ckZUlChFLLgZRAql71VR1r21CP6r4+/4l/A4psjPWNQA0wV
 VL5LgdEe+vH2fP43ALw468lC7gKKYjfhf6/Xf3T8SlpYZuFvy71yuLJF9 A==;
X-CSE-ConnectionGUID: l8z6oJlZQweag6D3VePIAg==
X-CSE-MsgGUID: s02n4rIAQzWm0l6pT9KrzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="85055148"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; d="scan'208";a="85055148"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 06:00:39 -0700
X-CSE-ConnectionGUID: x4qGi51JQOOet2xvBZy+tg==
X-CSE-MsgGUID: rVfFPm7dRWuKzLKlBWQOQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; d="scan'208";a="260595854"
Received: from abityuts-desk1.ger.corp.intel.com (HELO [10.245.245.155])
 ([10.245.245.155])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 06:00:35 -0700
Message-ID: <93ec79b4fe0ab7d75affdb7c01367ff4400354d2.camel@linux.intel.com>
Subject: Re: [PATCH i-g-t v4 7/7] tests/dmem_cgroups: add test for dmem.current
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, 
 igt-dev@lists.freedesktop.org
Cc: siqueira@igalia.com, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, Christian
 Koenig	 <christian.koenig@amd.com>, maarten.lankhorst@linux.intel.com,
 Kamil Konieczny	 <kamil.konieczny@linux.intel.com>, Janusz Krzysztofik	
 <janusz.krzysztofik@linux.intel.com>, Vitaly Prosyak
 <vitaly.prosyak@amd.com>,  Natalie Vock <natalie.vock@gmx.de>, Tvrtko
 Ursulin <tvrtko.ursulin@igalia.com>, kernel-dev@igalia.com
Date: Fri, 17 Jul 2026 15:00:33 +0200
In-Reply-To: <20260717120447.1837818-8-cascardo@igalia.com>
References: <20260717120447.1837818-1-cascardo@igalia.com>
 <20260717120447.1837818-8-cascardo@igalia.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
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

On Fri, 2026-07-17 at 09:04 -0300, Thadeu Lima de Souza Cascardo wrote:
> Based on the work of Thomas Hellstr=C3=B6m to test dmem.max eviction, add
> a
> test for dmem.current usage after allocations and setting dmem.max.
>=20
> Create a dmem cgroup, allocate close to capacity (or at most 4GiB),
> check current usage is within a small slack of the expected
> allocation.
> Then, set max to a small value and check allocations and current
> usage
> are limited to the max set.=C2=A0 Set max to less than a single BO size,
> then
> check no allocations are allowed and current usage is also within the
> slack. After each allocation, release memory and check current usage
> has gone down.
>=20
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

In what situations do you see the need for a slack? I've seen it only
when max is set close to 0. For higher max limit, the slack usage may
potentially mask bugs. Is there a way the slack can be activated only
when it's needed?

Thanks,
Thomas



> ---
> =C2=A0tests/cgroup_dmem.c | 251
> +++++++++++++++++++++++++++++++++++++++++++-
> =C2=A01 file changed, 246 insertions(+), 5 deletions(-)
>=20
> diff --git a/tests/cgroup_dmem.c b/tests/cgroup_dmem.c
> index 442c965f9bbf..fa4694b45035 100644
> --- a/tests/cgroup_dmem.c
> +++ b/tests/cgroup_dmem.c
> @@ -1,6 +1,8 @@
> =C2=A0// SPDX-License-Identifier: MIT
> =C2=A0/*
> =C2=A0 * Copyright =C2=A9 2025 Intel Corporation
> + * Copyright =C2=A9 2026 Intel Corporation
> + * Copyright 2026 Valve Corporation
> =C2=A0 */
> =C2=A0
> =C2=A0/**
> @@ -17,10 +19,214 @@
> =C2=A0 * Test category: uapi
> =C2=A0 */
> =C2=A0
> +#include <errno.h>
> =C2=A0#include <inttypes.h>
> +#include <signal.h>
> +#include <stdatomic.h>
> +#include <stdint.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> =C2=A0
> +#include "drmtest.h"
> =C2=A0#include "igt.h"
> +#include "igt_aux.h"
> =C2=A0#include "igt_cgroup.h"
> +#include "igt_dmem_driver.h"
> +
> +#define BO_SIZE			SZ_64M
> +#define MAX_LIMIT		((uint64_t)4 * SZ_1G)
> +#define USAGE_SLACK		SZ_4M		/* tolerance above
> the set max */
> +#define USAGE_POLL_MS		10
> +#define USAGE_DROP_TIMEOUT_MS	1000
> +
> +/**
> + * SUBTEST: simple
> + * DESCRIPTION:
> + *=C2=A0 Creates a cgroup, moves the process into it, enumerates all dme=
m
> regions,
> + *=C2=A0 prints their capacity, system-wide current usage, per-cgroup
> current usage
> + *=C2=A0 and configured limits, then destroys the cgroup.
> + */
> +
> +/**
> + * SUBTEST: current
> + * DESCRIPTION:
> + *=C2=A0 Create a dmem cgroup, allocate close to capacity (or at most
> 4GiB),
> + *=C2=A0 check current usage is within a small slack of the expected
> allocation.
> + *=C2=A0 Then, set max to a small value and check allocations and curren=
t
> usage
> + *=C2=A0 are limited to the max set.
> + *=C2=A0 Set max to less than a single BO size, then check no allocation=
s
> are allowed
> + *=C2=A0 and current usage is also within the slack.
> + *=C2=A0 After each allocation, release memory and check current usage
> has gone
> + *=C2=A0 down.
> + * REQUIREMENTS: xe or amdgpu device with at least one VRAM region
> + */
> +
> +static uint64_t wait_for_usage_drop(struct igt_cgroup *cg, const
> char *region,
> +				=C2=A0=C2=A0=C2=A0 uint64_t limit)
> +{
> +	uint64_t current;
> +	unsigned int elapsed =3D 0;
> +
> +	do {
> +		igt_cgroup_dmem_get_current(cg, region, &current);
> +		if (current <=3D limit)
> +			return current;
> +		usleep(USAGE_POLL_MS * 1000);
> +		elapsed +=3D USAGE_POLL_MS;
> +	} while (elapsed < USAGE_DROP_TIMEOUT_MS);
> +
> +	return current;
> +}
> +
> +static int allocate_vram(const struct igt_dmem_driver *drv, void
> *ctx, int fd, int max_bo, size_t len)
> +{
> +	int n_bo, err =3D 0;
> +	for (n_bo =3D 0; n_bo < max_bo; n_bo++) {
> +		err =3D drv->allocate_vram(ctx, n_bo, len);
> +		if (err)
> +			break;
> +	}
> +	/* These are expected failures we can ignore. */
> +	if (err =3D=3D -ENOMEM || err =3D=3D -ENOSPC)
> +		err =3D 0;
> +	return err ?: n_bo;
> +}
> +
> +static void free_vram(const struct igt_dmem_driver *drv, void *ctx,
> int max_bo)
> +{
> +	int i;
> +	for (i =3D 0; i < max_bo; i++)
> +		drv->free_vram(ctx, i);
> +}
> +
> +static void test_current(int fd, char *cg_region, unsigned int
> flags, const struct igt_dmem_driver *drv)
> +{
> +	struct igt_cgroup *cg;
> +	void *ctx;
> +	uint64_t current, capacity, cg_max;
> +	int n_bo =3D 0, max_bo;
> +	int err;
> +
> +	igt_cgroup_dmem_get_capacity(cg_region, &capacity);
> +	igt_require_f(capacity >=3D 4 * BO_SIZE,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "VRAM capacity (%"PRIu64" MiB) too smal=
l to
> test\n",
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 capacity / SZ_1M);
> +
> +	/*
> +	 * Use up to 4 GiB, or the full capacity if the device has
> less.
> +	 * Leave one BO_SIZE worth of headroom so the device isn't
> completely
> +	 * exhausted before the cgroup limit is hit.
> +	 */
> +	cg_max =3D min(MAX_LIMIT, capacity - BO_SIZE - USAGE_SLACK);
> +	cg_max =3D ALIGN_DOWN(cg_max, BO_SIZE);
> +
> +	/* Create cgroup and move into it */
> +	cg =3D igt_cgroup_new("igt_cgroups_test");
> +	igt_cgroup_move_current(cg);
> +
> +	max_bo =3D cg_max / BO_SIZE;
> +
> +	err =3D drv->init(&ctx, fd, max_bo);
> +	igt_assert_f(!err, "Failed to initialize driver");
> +
> +	n_bo =3D allocate_vram(drv, ctx, fd, max_bo, BO_SIZE);
> +	igt_assert_f(n_bo > 0, "failed to allocate VRAM\n");
> +
> +	igt_cgroup_dmem_get_current(cg, cg_region, &current);
> +	igt_debug("After fill: cgroup current =3D %"PRIu64" MiB, "
> +		=C2=A0 "max =3D %"PRIu64" MiB\n",
> +		=C2=A0 current / SZ_1M, cg_max / SZ_1M);
> +	igt_assert_f(current < cg_max + USAGE_SLACK && current >
> cg_max - USAGE_SLACK,
> +		=C2=A0=C2=A0=C2=A0=C2=A0 "current usage (%"PRIu64" MiB) is not within
> margin of allocation (%"PRIu64" MiB)\n",
> +		=C2=A0=C2=A0=C2=A0=C2=A0 current / SZ_1M, cg_max / SZ_1M);
> +
> +	free_vram(drv, ctx, n_bo);
> +	wait_for_usage_drop(cg, cg_region, USAGE_SLACK);
> +
> +	igt_cgroup_dmem_get_current(cg, cg_region, &current);
> +	igt_debug("After free: cgroup current =3D %"PRIu64" MiB, "
> +		=C2=A0 "max =3D %"PRIu64" MiB\n",
> +		=C2=A0 current / SZ_1M, cg_max / SZ_1M);
> +	igt_assert_f(current < USAGE_SLACK,
> +		=C2=A0=C2=A0=C2=A0=C2=A0 "current usage (%"PRIu64" MiB) is not within
> margin (%d MiB)\n",
> +		=C2=A0=C2=A0=C2=A0=C2=A0 current / SZ_1M, USAGE_SLACK / SZ_1M);
> +
> +	/* Allow for a slack as there might be some extra pages
> allocated. */
> +	igt_cgroup_dmem_set_max(cg, cg_region, 2 * BO_SIZE +
> USAGE_SLACK, false);
> +
> +	n_bo =3D allocate_vram(drv, ctx, fd, max_bo, BO_SIZE);
> +	igt_assert_f(n_bo > 0, "failed to allocate VRAM\n");
> +
> +	igt_cgroup_dmem_get_current(cg, cg_region, &current);
> +	igt_debug("After fill: cgroup current =3D %"PRIu64" MiB, "
> +		=C2=A0 "max =3D %"PRIu64" MiB\n",
> +		=C2=A0 current / SZ_1M, cg_max / SZ_1M);
> +	igt_assert_f(current < 2 * BO_SIZE + USAGE_SLACK && current
> > 2 * BO_SIZE - USAGE_SLACK,
> +		=C2=A0=C2=A0=C2=A0=C2=A0 "current usage (%"PRIu64" MiB) is not within
> margin of allocation (%"PRIu64" MiB)\n",
> +		=C2=A0=C2=A0=C2=A0=C2=A0 current / SZ_1M, cg_max / SZ_1M);
> +
> +	free_vram(drv, ctx, n_bo);
> +	wait_for_usage_drop(cg, cg_region, USAGE_SLACK);
> +
> +	igt_cgroup_dmem_get_current(cg, cg_region, &current);
> +	igt_debug("After free: cgroup current =3D %"PRIu64" MiB, "
> +		=C2=A0 "max =3D %"PRIu64" MiB\n",
> +		=C2=A0 current / SZ_1M, cg_max / SZ_1M);
> +	igt_assert_f(current < USAGE_SLACK,
> +		=C2=A0=C2=A0=C2=A0=C2=A0 "current usage (%"PRIu64" MiB) is not within
> margin (%d MiB)\n",
> +		=C2=A0=C2=A0=C2=A0=C2=A0 current / SZ_1M, USAGE_SLACK / SZ_1M);
> +
> +	igt_cgroup_dmem_set_max(cg, cg_region, USAGE_SLACK, false);
> +
> +	n_bo =3D allocate_vram(drv, ctx, fd, max_bo, BO_SIZE);
> +
> +	/*
> +	 * amdgpu may succeed the allocation, by falling back to
> GTT, so no assertion here.
> +	 * Verify by reading current usage.
> +	 */
> +
> +	igt_cgroup_dmem_get_current(cg, cg_region, &current);
> +	igt_debug("After fill: cgroup current =3D %"PRIu64" MiB, "
> +		=C2=A0 "max =3D %"PRIu64" MiB\n",
> +		=C2=A0 current / SZ_1M, cg_max / SZ_1M);
> +	igt_assert_f(current < USAGE_SLACK,
> +		=C2=A0=C2=A0=C2=A0=C2=A0 "current usage (%"PRIu64" MiB) is not within
> margin\n",
> +		=C2=A0=C2=A0=C2=A0=C2=A0 current / SZ_1M);
> +
> +	if (n_bo > 0)
> +		free_vram(drv, ctx, n_bo);
> +	wait_for_usage_drop(cg, cg_region, USAGE_SLACK);
> +
> +	igt_cgroup_dmem_get_current(cg, cg_region, &current);
> +	igt_debug("After free: cgroup current =3D %"PRIu64" MiB, "
> +		=C2=A0 "max =3D %"PRIu64" MiB\n",
> +		=C2=A0 current / SZ_1M, cg_max / SZ_1M);
> +	igt_assert_f(current < USAGE_SLACK,
> +		=C2=A0=C2=A0=C2=A0=C2=A0 "current usage (%"PRIu64" MiB) is not within
> margin (%d MiB)\n",
> +		=C2=A0=C2=A0=C2=A0=C2=A0 current / SZ_1M, USAGE_SLACK / SZ_1M);
> +
> +	drv->deinit(ctx);
> +	igt_cgroup_free(cg);
> +}
> +
> +static const struct {
> +	const char *name;
> +	void (*test_fn)(int fd, char *cg_region, unsigned int flags,
> const struct igt_dmem_driver *drv);
> +	unsigned int flags;
> +} subtests[] =3D {
> +	{ "current", test_current, 0 },
> +	{ }
> +};
> +
> +static const struct {
> +	int driver_flag;
> +	const struct igt_dmem_driver *driver;
> +} drivers[] =3D {
> +	{ DRIVER_XE, &xe_dmem_driver },
> +	{ DRIVER_AMDGPU, &amdgpu_dmem_driver },
> +	{ },
> +};
> =C2=A0
> =C2=A0IGT_TEST_DESCRIPTION("Exercises the cgroup v2 dmem controller
> interface.");
> =C2=A0
> @@ -32,7 +238,7 @@ static void fmt_bytes(uint64_t v, char *buf,
> size_t len)
> =C2=A0		snprintf(buf, len, "%" PRIu64, v);
> =C2=A0}
> =C2=A0
> -int igt_simple_main()
> +static void simple_cgroup(void)
> =C2=A0{
> =C2=A0	struct igt_cgroup *cg;
> =C2=A0	const char *region;
> @@ -42,10 +248,6 @@ int igt_simple_main()
> =C2=A0	char min_s[32], low_s[32], max_s[32];
> =C2=A0	int i;
> =C2=A0
> -	igt_require_f(igt_cgroup_dmem_available(),
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "No dmem regions found; is cgroup v2 wi=
th the
> "
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "dmem controller available?\n");
> -
> =C2=A0	cg =3D igt_cgroup_new("igt-cgroup-dmem-test");
> =C2=A0	igt_assert_f(cg, "Failed to create cgroup\n");
> =C2=A0
> @@ -90,3 +292,42 @@ int igt_simple_main()
> =C2=A0	igt_cgroup_dmem_regions_free(regions);
> =C2=A0	igt_cgroup_free(cg);
> =C2=A0}
> +
> +int igt_main()
> +{
> +	igt_fixture() {
> +		igt_require_f(getuid() =3D=3D 0, "Test requires
> root\n");
> +		/* Check dmem cgroup controller is available before
> doing anything else */
> +		igt_require_f(igt_cgroup_dmem_available(),
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "dmem cgroup controller not available
> (no cgroup v2 or no registered regions)\n");
> +
> +	}
> +
> +	igt_subtest("simple")
> +		simple_cgroup();
> +
> +	for (int d =3D 0; drivers[d].driver; d++) {
> +		igt_subtest_group() {
> +			int fd =3D -1;
> +			char *cg_region;
> +			igt_fixture() {
> +				fd =3D
> drm_open_driver(drivers[d].driver_flag);
> +				igt_require_f(fd >=3D 0,
> +					"No %s device found,
> skipping\n",
> +					drivers[d].driver->name);
> +				cg_region =3D drivers[d].driver-
> >get_region_name(fd);
> +				igt_require_f(cg_region, "Region not
> tracked by dmem cgroup controller\n");
> +			}
> +
> +			for (int i =3D 0; subtests[i].name; i++)
> +				igt_subtest_f("%s-%s",
> drivers[d].driver->name, subtests[i].name)
> +					subtests[i].test_fn(fd,
> cg_region, subtests[i].flags, drivers[d].driver);
> +
> +			igt_fixture() {
> +				if (fd >=3D 0)
> +					drm_close_driver(fd);
> +				free(cg_region);
> +			}
> +		}
> +	}
> +}
