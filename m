Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D2FC5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 08:31:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BF0310E53F;
	Mon, 24 Aug 2026 08:31:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="nwPRyxsm";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43E8810E53F;
 Mon, 24 Aug 2026 08:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787560299; x=1819096299;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=qan31AAHCL6JrHBfsDgckpZeuVi9hUm5p9BUJggeBWE=;
 b=nwPRyxsmmjr0i7JqCBpcaq5DkUhBd42S3d8slgIfP1y3+vfJXqYFFDSz
 zhu+wT+97+sK1g8T3tqOT3lY/rQ2IThasHGfewRSIngF1QfKZYG4cawMm
 cZx5RofBZ4BBNZyUvNdRI96VPsyCu7wCwJ22IgLYq2oUkOV4qKgtevweD
 HfL1amaY1K7JGJxVw1+UT7ymXh1BdqB5UfcXdg6rjTloBo7+jCtstpaH8
 l8nUw+eLkauQVsPI0eTnsrvIfjP5hJteWDqEBIgMpCgUdb2pPPhtss4Ip
 iv2DjIcCqliaITp6RMjy3Hv1Fg/qUZzdVQ/jaUXq7s1VvcbL5aiBs3Bza g==;
X-CSE-ConnectionGUID: GPGhqj6fQu6yQMfRZJj4gg==
X-CSE-MsgGUID: Ohu4/SVhQ5u0SKPZi6oIlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="105382174"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="105382174"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 01:31:39 -0700
X-CSE-ConnectionGUID: rsSrVjrhRq6MlxCfDkPeSA==
X-CSE-MsgGUID: RHRd2jjaTyWa6oz0lG8aPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="267513965"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.245.246.205])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 01:31:36 -0700
Message-ID: <7380c0773cff19eb2955328856ef1ab7497ece83.camel@linux.intel.com>
Subject: Re: [PATCH v2 3/8] drm/i915/selftests: Use drm_* prints in live
 selftests
From: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>, 
 intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Jani Nikula
 <jani.nikula@linux.intel.com>,  Andi Shyti <andi.shyti@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,  Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>
Date: Mon, 24 Aug 2026 10:31:32 +0200
In-Reply-To: <20260818095624.3254368-4-krzysztof.karas@intel.com>
References: <20260818095624.3254368-1-krzysztof.karas@intel.com>
 <20260818095624.3254368-4-krzysztof.karas@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
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

Hi Krzysztof,

On Tue, 2026-08-18 at 09:56 +0000, Krzysztof Karas wrote:
> Move away from generic pr prints to device context aware drm
> versions.
>=20
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> ---
>  .../gpu/drm/i915/selftests/i915_gem_evict.c   |  58 ++---
>  drivers/gpu/drm/i915/selftests/i915_gem_gtt.c | 197 ++++++++-------
>  drivers/gpu/drm/i915/selftests/i915_perf.c    |  24 +-
>  drivers/gpu/drm/i915/selftests/i915_request.c | 234 +++++++++---------
>  drivers/gpu/drm/i915/selftests/i915_vma.c     | 222 +++++++++--------
>  drivers/gpu/drm/i915/selftests/intel_uncore.c |  59 +++--
>  6 files changed, 418 insertions(+), 376 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_evict.c b/drivers/gp=
u/drm/i915/selftests/i915_gem_evict.c
> index 718cddde7e73..e6cdb02173a1 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_gem_evict.c
> +++ b/drivers/gpu/drm/i915/selftests/i915_gem_evict.c
> @@ -29,6 +29,8 @@
>  #include "gt/intel_gt.h"
>  #include "gt/intel_gt_print.h"
> =20
> +#include <drm/drm_print.h>
> +
>  #include "i915_selftest.h"
> =20
>  #include "igt_flush_test.h"
> @@ -71,11 +73,11 @@ static int populate_ggtt(struct i915_ggtt *ggtt, stru=
ct list_head *objects)
>  		quirk_add(obj, objects);
>  		count++;
>  	} while (1);
> -	pr_debug("Filled GGTT with %lu pages [%llu total]\n",
> -		 count, ggtt->vm.total / PAGE_SIZE);
> +	drm_dbg(&ggtt->vm.i915->drm, "Filled GGTT with %lu pages [%llu total]\n=
",

Looking at the current code I can see the 80-char line lenght rule is
generally followed, with an obvious exception of long strings.  Your
changes often break that rule, even if that's easily avoidable.

If you see benefits from not following the current rule then please limit
your formatting modifications to a reasonable minimum, mention that in
commit description, preferably describing your preferred approach to code
formatting that you are going to apply, and try to follow it consequently,
otherwise your changes look inconsistently, at least to me.

And yes, I know that lengths of drm_* function names differ from their
equivalent pr_* variants, then slight adjustment of indentation of lines
that follow is required.

> +		count, ggtt->vm.total / PAGE_SIZE);
> =20
>  	if (list_empty(&ggtt->vm.bound_list)) {
> -		pr_err("No objects on the GGTT inactive list!\n");
> +		drm_err(&ggtt->vm.i915->drm, "No objects on the GGTT inactive list!\n"=
);
>  		return -EINVAL;
>  	}
> =20
> @@ -125,8 +127,8 @@ static int igt_evict_something(void *arg)
>  				       0);
>  	mutex_unlock(&ggtt->vm.mutex);
>  	if (err !=3D -ENOSPC) {
> -		pr_err("i915_gem_evict_something failed on a full GGTT with err=3D%d\n=
",
> -		       err);
> +		drm_err(&gt->i915->drm,
> +			"i915_gem_evict_something failed on a full GGTT with err=3D%d\n", err=
);
>  		goto cleanup;
>  	}
> =20
> @@ -140,8 +142,8 @@ static int igt_evict_something(void *arg)
>  				       0);
>  	mutex_unlock(&ggtt->vm.mutex);
>  	if (err) {
> -		pr_err("i915_gem_evict_something failed on a full GGTT with err=3D%d\n=
",
> -		       err);
> +		drm_err(&gt->i915->drm,
> +			"i915_gem_evict_something failed on a full GGTT with err=3D%d\n", err=
);
>  		goto cleanup;
>  	}
> =20
> @@ -177,7 +179,9 @@ static int igt_overcommit(void *arg)
> =20
>  	vma =3D i915_gem_object_ggtt_pin(obj, NULL, 0, 0, 0);
>  	if (vma !=3D ERR_PTR(-ENOSPC)) {
> -		pr_err("Failed to evict+insert, i915_gem_object_ggtt_pin returned err=
=3D%d\n", (int)PTR_ERR_OR_ZERO(vma));
> +		drm_err(&gt->i915->drm,
> +			"Failed to evict+insert, i915_gem_object_ggtt_pin returned err=3D%d\n=
",
> +			(int)PTR_ERR_OR_ZERO(vma));
>  		err =3D -EINVAL;
>  		goto cleanup;
>  	}
> @@ -209,8 +213,8 @@ static int igt_evict_for_vma(void *arg)
>  	err =3D i915_gem_evict_for_node(&ggtt->vm, NULL, &target, 0);
>  	mutex_unlock(&ggtt->vm.mutex);
>  	if (err !=3D -ENOSPC) {
> -		pr_err("i915_gem_evict_for_node on a full GGTT returned err=3D%d\n",
> -		       err);
> +		drm_err(&gt->i915->drm, "i915_gem_evict_for_node on a full GGTT return=
ed err=3D%d\n",
> +			err);
>  		goto cleanup;
>  	}
> =20
> @@ -221,8 +225,7 @@ static int igt_evict_for_vma(void *arg)
>  	err =3D i915_gem_evict_for_node(&ggtt->vm, NULL, &target, 0);
>  	mutex_unlock(&ggtt->vm.mutex);
>  	if (err) {
> -		pr_err("i915_gem_evict_for_node returned err=3D%d\n",
> -		       err);
> +		drm_err(&gt->i915->drm, "i915_gem_evict_for_node returned err=3D%d\n",=
 err);
>  		goto cleanup;
>  	}
> =20
> @@ -273,7 +276,7 @@ static int igt_evict_for_cache_color(void *arg)
>  	vma =3D i915_gem_object_ggtt_pin(obj, NULL, 0, 0,
>  				       I915_GTT_PAGE_SIZE | flags);
>  	if (IS_ERR(vma)) {
> -		pr_err("[0]i915_gem_object_ggtt_pin failed\n");
> +		drm_err(&gt->i915->drm, "[0]i915_gem_object_ggtt_pin failed\n");
>  		err =3D PTR_ERR(vma);
>  		goto cleanup;
>  	}
> @@ -290,7 +293,7 @@ static int igt_evict_for_cache_color(void *arg)
>  	vma =3D i915_gem_object_ggtt_pin(obj, NULL, 0, 0,
>  				       (I915_GTT_PAGE_SIZE * 2) | flags);
>  	if (IS_ERR(vma)) {
> -		pr_err("[1]i915_gem_object_ggtt_pin failed\n");
> +		drm_err(&gt->i915->drm, "[1]i915_gem_object_ggtt_pin failed\n");
>  		err =3D PTR_ERR(vma);
>  		goto cleanup;
>  	}
> @@ -302,7 +305,7 @@ static int igt_evict_for_cache_color(void *arg)
>  	err =3D i915_gem_evict_for_node(&ggtt->vm, NULL, &target, 0);
>  	mutex_unlock(&ggtt->vm.mutex);
>  	if (err) {
> -		pr_err("[0]i915_gem_evict_for_node returned err=3D%d\n", err);
> +		drm_err(&gt->i915->drm, "[0]i915_gem_evict_for_node returned err=3D%d\=
n", err);
>  		goto cleanup;
>  	}
> =20
> @@ -315,7 +318,7 @@ static int igt_evict_for_cache_color(void *arg)
>  	err =3D i915_gem_evict_for_node(&ggtt->vm, NULL, &target, 0);
>  	mutex_unlock(&ggtt->vm.mutex);
>  	if (!err) {
> -		pr_err("[1]i915_gem_evict_for_node returned err=3D%d\n", err);
> +		drm_err(&gt->i915->drm, "[1]i915_gem_evict_for_node returned err=3D%d\=
n", err);
>  		err =3D -EINVAL;
>  		goto cleanup;

NIT: How about declaring a local variable struct drm_i915_private *i915,
here initialized as gt->i915, and using a more compact &i915->drm in place
of &gt->i915->drm, especially in this function where there are 4 instances?
=C2=A0
I would also follow that pattern in other functions with more than one
instance of a similarly complex expression.

>  	}
> @@ -348,8 +351,7 @@ static int igt_evict_vm(void *arg)
>  	err =3D i915_gem_evict_vm(&ggtt->vm, NULL, NULL);
>  	mutex_unlock(&ggtt->vm.mutex);
>  	if (err) {
> -		pr_err("i915_gem_evict_vm on a full GGTT returned err=3D%d]\n",
> -		       err);
> +		drm_err(&gt->i915->drm, "i915_gem_evict_vm on a full GGTT returned err=
=3D%d]\n", err);
>  		goto cleanup;
>  	}
> =20
> @@ -362,8 +364,7 @@ static int igt_evict_vm(void *arg)
>  	}
> =20
>  	if (err) {
> -		pr_err("i915_gem_evict_vm on a full GGTT returned err=3D%d]\n",
> -		       err);
> +		drm_err(&gt->i915->drm, "i915_gem_evict_vm on a full GGTT returned err=
=3D%d]\n", err);
>  		goto cleanup;
>  	}
> =20
> @@ -443,7 +444,7 @@ static int igt_evict_contexts(void *arg)
>  	} while (1);
>  	drm_mm_remove_node(&hole);
>  	mutex_unlock(&ggtt->vm.mutex);
> -	pr_info("Filled GGTT with %lu 1MiB nodes\n", count);
> +	drm_info(&i915->drm, "Filled GGTT with %lu 1MiB nodes\n", count);
> =20
>  	/* Overfill the GGTT with context objects and so try to evict one. */
>  	for_each_engine(engine, gt, id) {
> @@ -469,9 +470,10 @@ static int igt_evict_contexts(void *arg)
>  			if (IS_ERR(rq)) {
>  				/* When full, fail_if_busy will trigger EBUSY */
>  				if (PTR_ERR(rq) !=3D -EBUSY) {
> -					pr_err("Unexpected error from request alloc (on %s): %d\n",
> -					       engine->name,
> -					       (int)PTR_ERR(rq));
> +					drm_err(&i915->drm,
> +						"Unexpected error from request alloc (on %s): %d\n",
> +						engine->name,
> +						(int)PTR_ERR(rq));
>  					err =3D PTR_ERR(rq);
>  				}
>  				break;
> @@ -492,16 +494,16 @@ static int igt_evict_contexts(void *arg)
>  			err =3D 0;
>  		} while(1);
>  		onstack_fence_fini(&fence);
> -		pr_info("Submitted %lu contexts/requests on %s\n",
> -			count, engine->name);
> +		drm_info(&i915->drm, "Submitted %lu contexts/requests on %s\n",
> +			 count, engine->name);
>  		if (err)
>  			break;
>  		if (last) {
>  			if (i915_request_wait(last, 0, HZ) < 0) {
>  				err =3D -EIO;
>  				i915_request_put(last);
> -				pr_err("Failed waiting for last request (on %s)",
> -				       engine->name);
> +				drm_err(&i915->drm, "Failed waiting for last request (on %s)\n",
> +					engine->name);
>  				break;
>  			}
>  			i915_request_put(last);
> diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c b/drivers/gpu/=
drm/i915/selftests/i915_gem_gtt.c
> index e6bd06774816..79c219d3a627 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
> +++ b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
> @@ -25,6 +25,8 @@
>  #include <linux/list_sort.h>
>  #include <linux/prime_numbers.h>
> =20
> +#include <drm/drm_print.h>
> +
>  #include "gem/i915_gem_context.h"
>  #include "gem/i915_gem_internal.h"
>  #include "gem/i915_gem_lmem.h"
> @@ -34,6 +36,7 @@
>  #include "gt/intel_gpu_commands.h"
>  #include "gt/intel_gtt.h"
> =20
> +#include "../i915_drv.h"
>  #include "i915_random.h"
>  #include "i915_selftest.h"
>  #include "i915_vma_resource.h"
> @@ -268,8 +271,8 @@ static int lowlevel_hole(struct i915_address_space *v=
m,
>  			hole_size =3D KMALLOC_MAX_SIZE / sizeof(u32);
>  		count =3D hole_size >> 1;
>  		if (!count) {
> -			pr_debug("%s: hole is too small [%llx - %llx] >> %d: %lld\n",
> -				 __func__, hole_start, hole_end, size, hole_size);
> +			drm_dbg(&vm->i915->drm, "%s: hole is too small [%llx - %llx] >> %d: %=
lld\n",
> +				__func__, hole_start, hole_end, size, hole_size);
>  			break;
>  		}
> =20
> @@ -472,16 +475,20 @@ static int fill_hole(struct i915_address_space *vm,
> =20
>  					err =3D i915_vma_pin(vma, 0, 0, offset | flags);
>  					if (err) {
> -						pr_err("%s(%s) pin (forward) failed with err=3D%d on size=3D%lu pa=
ges (prime=3D%lu), offset=3D%llx\n",
> -						       __func__, p->name, err, npages, prime, offset);
> +						drm_err(&vm->i915->drm,
> +							"%s(%s) pin (forward) failed with err=3D%d on size=3D%lu pages (p=
rime=3D%lu), offset=3D%llx\n",
> +							__func__, p->name, err, npages, prime,
> +							offset);
>  						goto err;
>  					}
> =20
>  					if (!drm_mm_node_allocated(&vma->node) ||
>  					    i915_vma_misplaced(vma, 0, 0, offset | flags)) {
> -						pr_err("%s(%s) (forward) insert failed: vma.node=3D%llx + %llx [al=
located? %d], expected offset %llx\n",
> -						       __func__, p->name, vma->node.start, vma->node.size, drm_mm_=
node_allocated(&vma->node),
> -						       offset);
> +						drm_err(&vm->i915->drm,
> +							"%s(%s) (forward) insert failed: vma.node=3D%llx + %llx [allocate=
d? %d], expected offset %llx\n",
> +							__func__, p->name, vma->node.start,
> +							vma->node.size,
> +							drm_mm_node_allocated(&vma->node), offset);
>  						err =3D -EINVAL;
>  						goto err;
>  					}
> @@ -512,18 +519,20 @@ static int fill_hole(struct i915_address_space *vm,
> =20
>  					if (!drm_mm_node_allocated(&vma->node) ||
>  					    i915_vma_misplaced(vma, 0, 0, offset | flags)) {
> -						pr_err("%s(%s) (forward) moved vma.node=3D%llx + %llx, expected of=
fset %llx\n",
> -						       __func__, p->name, vma->node.start, vma->node.size,
> -						       offset);
> +						drm_err(&vm->i915->drm,
> +							"%s(%s) (forward) moved vma.node=3D%llx + %llx, expected offset %=
llx\n",
> +							__func__, p->name, vma->node.start,
> +							vma->node.size, offset);
>  						err =3D -EINVAL;
>  						goto err;
>  					}
> =20
>  					err =3D i915_vma_unbind_unlocked(vma);
>  					if (err) {
> -						pr_err("%s(%s) (forward) unbind of vma.node=3D%llx + %llx failed w=
ith err=3D%d\n",
> -						       __func__, p->name, vma->node.start, vma->node.size,
> -						       err);
> +						drm_err(&vm->i915->drm,
> +							"%s(%s) (forward) unbind of vma.node=3D%llx + %llx failed with er=
r=3D%d\n",
> +							__func__, p->name, vma->node.start,
> +							vma->node.size, err);
>  						goto err;
>  					}
> =20
> @@ -551,16 +560,20 @@ static int fill_hole(struct i915_address_space *vm,
> =20
>  					err =3D i915_vma_pin(vma, 0, 0, offset | flags);
>  					if (err) {
> -						pr_err("%s(%s) pin (backward) failed with err=3D%d on size=3D%lu p=
ages (prime=3D%lu), offset=3D%llx\n",
> -						       __func__, p->name, err, npages, prime, offset);
> +						drm_err(&vm->i915->drm,
> +							"%s(%s) pin (backward) failed with err=3D%d on size=3D%lu pages (=
prime=3D%lu), offset=3D%llx\n",
> +							__func__, p->name, err, npages, prime,
> +							offset);
>  						goto err;
>  					}
> =20
>  					if (!drm_mm_node_allocated(&vma->node) ||
>  					    i915_vma_misplaced(vma, 0, 0, offset | flags)) {
> -						pr_err("%s(%s) (backward) insert failed: vma.node=3D%llx + %llx [a=
llocated? %d], expected offset %llx\n",
> -						       __func__, p->name, vma->node.start, vma->node.size, drm_mm_=
node_allocated(&vma->node),
> -						       offset);
> +						drm_err(&vm->i915->drm,
> +							"%s(%s) (backward) insert failed: vma.node=3D%llx + %llx [allocat=
ed? %d], expected offset %llx\n",
> +							__func__, p->name, vma->node.start,
> +							vma->node.size,
> +							drm_mm_node_allocated(&vma->node), offset);
>  						err =3D -EINVAL;
>  						goto err;
>  					}
> @@ -591,18 +604,21 @@ static int fill_hole(struct i915_address_space *vm,
> =20
>  					if (!drm_mm_node_allocated(&vma->node) ||
>  					    i915_vma_misplaced(vma, 0, 0, offset | flags)) {
> -						pr_err("%s(%s) (backward) moved vma.node=3D%llx + %llx [allocated?=
 %d], expected offset %llx\n",
> -						       __func__, p->name, vma->node.start, vma->node.size, drm_mm_=
node_allocated(&vma->node),
> -						       offset);
> +						drm_err(&vm->i915->drm,
> +							"%s(%s) (backward) moved vma.node=3D%llx + %llx [allocated? %d], =
expected offset %llx\n",
> +							__func__, p->name, vma->node.start,
> +							vma->node.size,
> +							drm_mm_node_allocated(&vma->node), offset);
>  						err =3D -EINVAL;
>  						goto err;
>  					}
> =20
>  					err =3D i915_vma_unbind_unlocked(vma);
>  					if (err) {
> -						pr_err("%s(%s) (backward) unbind of vma.node=3D%llx + %llx failed =
with err=3D%d\n",
> -						       __func__, p->name, vma->node.start, vma->node.size,
> -						       err);
> +						drm_err(&vm->i915->drm,
> +							"%s(%s) (backward) unbind of vma.node=3D%llx + %llx failed with e=
rr=3D%d\n",
> +							__func__, p->name, vma->node.start,
> +							vma->node.size, err);
>  						goto err;
>  					}
> =20
> @@ -672,25 +688,26 @@ static int walk_hole(struct i915_address_space *vm,
>  		     addr +=3D round_up(obj->base.size, min_alignment)) {
>  			err =3D i915_vma_pin(vma, 0, 0, addr | flags);
>  			if (err) {
> -				pr_err("%s bind failed at %llx + %llx [hole %llx- %llx] with err=3D%=
d\n",
> -				       __func__, addr, vma->size,
> -				       hole_start, hole_end, err);
> +				drm_err(&vm->i915->drm,
> +					"%s bind failed at %llx + %llx [hole %llx- %llx] with err=3D%d\n",
> +					__func__, addr, vma->size, hole_start, hole_end, err);
>  				goto err_put;
>  			}
>  			i915_vma_unpin(vma);
> =20
>  			if (!drm_mm_node_allocated(&vma->node) ||
>  			    i915_vma_misplaced(vma, 0, 0, addr | flags)) {
> -				pr_err("%s incorrect at %llx + %llx\n",
> -				       __func__, addr, vma->size);
> +				drm_err(&vm->i915->drm, "%s incorrect at %llx + %llx\n",
> +					__func__, addr, vma->size);
>  				err =3D -EINVAL;
>  				goto err_put;
>  			}
> =20
>  			err =3D i915_vma_unbind_unlocked(vma);
>  			if (err) {
> -				pr_err("%s unbind failed at %llx + %llx  with err=3D%d\n",
> -				       __func__, addr, vma->size, err);
> +				drm_err(&vm->i915->drm,
> +					"%s unbind failed at %llx + %llx  with err=3D%d\n",
> +					__func__, addr, vma->size, err);
>  				goto err_put;
>  			}
> =20
> @@ -754,18 +771,16 @@ static int pot_hole(struct i915_address_space *vm,
>  		     addr +=3D step) {
>  			err =3D i915_vma_pin(vma, 0, 0, addr | flags);
>  			if (err) {
> -				pr_err("%s failed to pin object at %llx in hole [%llx - %llx], with =
err=3D%d\n",
> -				       __func__,
> -				       addr,
> -				       hole_start, hole_end,
> -				       err);
> +				drm_err(&vm->i915->drm,
> +					"%s failed to pin object at %llx in hole [%llx - %llx], with err=3D=
%d\n",
> +					__func__, addr, hole_start, hole_end, err);
>  				goto err_obj;
>  			}
> =20
>  			if (!drm_mm_node_allocated(&vma->node) ||
>  			    i915_vma_misplaced(vma, 0, 0, addr | flags)) {
> -				pr_err("%s incorrect at %llx + %llx\n",
> -				       __func__, addr, vma->size);
> +				drm_err(&vm->i915->drm, "%s incorrect at %llx + %llx\n",
> +					__func__, addr, vma->size);
>  				i915_vma_unpin(vma);
>  				err =3D i915_vma_unbind_unlocked(vma);
>  				err =3D -EINVAL;
> @@ -819,8 +834,8 @@ static int drunk_hole(struct i915_address_space *vm,
>  			hole_size =3D KMALLOC_MAX_SIZE / sizeof(u32);
>  		count =3D hole_size >> 1;
>  		if (!count) {
> -			pr_debug("%s: hole is too small [%llx - %llx] >> %d: %lld\n",
> -				 __func__, hole_start, hole_end, size, hole_size);
> +			drm_dbg(&vm->i915->drm, "%s: hole is too small [%llx - %llx] >> %d: %=
lld\n",
> +				__func__, hole_start, hole_end, size, hole_size);
>  			break;
>  		}
> =20
> @@ -859,18 +874,16 @@ static int drunk_hole(struct i915_address_space *vm=
,
> =20
>  			err =3D i915_vma_pin(vma, 0, 0, addr | flags);
>  			if (err) {
> -				pr_err("%s failed to pin object at %llx + %llx in hole [%llx - %llx]=
, with err=3D%d\n",
> -				       __func__,
> -				       addr, BIT_ULL(size),
> -				       hole_start, hole_end,
> -				       err);
> +				drm_err(&vm->i915->drm,
> +					"%s failed to pin object at %llx + %llx in hole [%llx - %llx], with=
 err=3D%d\n",
> +					__func__, addr, BIT_ULL(size), hole_start, hole_end, err);
>  				goto err_obj;
>  			}
> =20
>  			if (!drm_mm_node_allocated(&vma->node) ||
>  			    i915_vma_misplaced(vma, 0, 0, addr | flags)) {
> -				pr_err("%s incorrect at %llx + %llx\n",
> -				       __func__, addr, BIT_ULL(size));
> +				drm_err(&vm->i915->drm, "%s incorrect at %llx + %llx\n",
> +					__func__, addr, BIT_ULL(size));
>  				i915_vma_unpin(vma);
>  				err =3D i915_vma_unbind_unlocked(vma);
>  				err =3D -EINVAL;
> @@ -939,15 +952,16 @@ static int __shrink_hole(struct i915_address_space =
*vm,
> =20
>  		err =3D i915_vma_pin(vma, 0, 0, addr | flags);
>  		if (err) {
> -			pr_err("%s failed to pin object at %llx + %llx in hole [%llx - %llx],=
 with err=3D%d\n",
> -			       __func__, addr, size, hole_start, hole_end, err);
> +			drm_err(&vm->i915->drm,
> +				"%s failed to pin object at %llx + %llx in hole [%llx - %llx], with =
err=3D%d\n",
> +				__func__, addr, size, hole_start, hole_end, err);
>  			break;
>  		}
> =20
>  		if (!drm_mm_node_allocated(&vma->node) ||
>  		    i915_vma_misplaced(vma, 0, 0, addr | flags)) {
> -			pr_err("%s incorrect at %llx + %llx\n",
> -			       __func__, addr, size);
> +			drm_err(&vm->i915->drm, "%s incorrect at %llx + %llx\n",
> +				__func__, addr, size);
>  			i915_vma_unpin(vma);
>  			err =3D i915_vma_unbind_unlocked(vma);
>  			err =3D -EINVAL;
> @@ -966,8 +980,7 @@ static int __shrink_hole(struct i915_address_space *v=
m,
>  		if (err)
>  			break;
> =20
> -		if (igt_timeout(end_time,
> -				"%s timed out at offset %llx [%llx - %llx]\n",
> +		if (igt_timeout(end_time, "%s timed out at offset %llx [%llx - %llx]\n=
",

Not related, please drop it unless I'm missing something.

>  				__func__, addr, hole_start, hole_end)) {
>  			err =3D -EINTR;
>  			break;
> @@ -1419,8 +1432,7 @@ static int igt_ggtt_page(void *arg)
>  		io_mapping_unmap_atomic(vaddr);
> =20
>  		if (val !=3D n) {
> -			pr_err("insert page failed: found %d, expected %d\n",
> -			       val, n);
> +			drm_err(&i915->drm, "insert page failed: found %d, expected %d\n", va=
l, n);
>  			err =3D -EINVAL;
>  			break;
>  		}
> @@ -1578,18 +1590,19 @@ static int igt_gtt_reserve(void *arg)
> =20
>  		err =3D reserve_gtt_with_resource(vma, total);
>  		if (err) {
> -			pr_err("i915_gem_gtt_reserve (pass 1) failed at %llu/%llu with err=3D=
%d\n",
> -			       total, ggtt->vm.total, err);
> +			drm_err(&ggtt->vm.i915->drm,
> +				"i915_gem_gtt_reserve (pass 1) failed at %llu/%llu with err=3D%d\n",
> +				total, ggtt->vm.total, err);
>  			goto out;
>  		}
>  		track_vma_bind(vma);
> =20
>  		GEM_BUG_ON(!drm_mm_node_allocated(&vma->node));
>  		if (vma->node.start !=3D total ||
> -		    vma->node.size !=3D 2*I915_GTT_PAGE_SIZE) {

ditto

> -			pr_err("i915_gem_gtt_reserve (pass 1) placement failed, found (%llx +=
 %llx), expected (%llx + %llx)\n",
> -			       vma->node.start, vma->node.size,
> -			       total, 2*I915_GTT_PAGE_SIZE);
> +		    vma->node.size !=3D 2 * I915_GTT_PAGE_SIZE) {
> +			drm_err(&ggtt->vm.i915->drm,
> +				"i915_gem_gtt_reserve (pass 1) placement failed, found (%llx + %llx)=
, expected (%llx + %llx)\n",
> +				vma->node.start, vma->node.size, total, 2 * I915_GTT_PAGE_SIZE);
>  			err =3D -EINVAL;
>  			goto out;
>  		}
> @@ -1624,18 +1637,19 @@ static int igt_gtt_reserve(void *arg)
> =20
>  		err =3D reserve_gtt_with_resource(vma, total);
>  		if (err) {
> -			pr_err("i915_gem_gtt_reserve (pass 2) failed at %llu/%llu with err=3D=
%d\n",
> -			       total, ggtt->vm.total, err);
> +			drm_err(&ggtt->vm.i915->drm,
> +				"i915_gem_gtt_reserve (pass 2) failed at %llu/%llu with err=3D%d\n",
> +				total, ggtt->vm.total, err);
>  			goto out;
>  		}
>  		track_vma_bind(vma);
> =20
>  		GEM_BUG_ON(!drm_mm_node_allocated(&vma->node));
>  		if (vma->node.start !=3D total ||
> -		    vma->node.size !=3D 2*I915_GTT_PAGE_SIZE) {

ditto

> -			pr_err("i915_gem_gtt_reserve (pass 2) placement failed, found (%llx +=
 %llx), expected (%llx + %llx)\n",
> -			       vma->node.start, vma->node.size,
> -			       total, 2*I915_GTT_PAGE_SIZE);
> +		    vma->node.size !=3D 2 * I915_GTT_PAGE_SIZE) {
> +			drm_err(&ggtt->vm.i915->drm,
> +				"i915_gem_gtt_reserve (pass 2) placement failed, found (%llx + %llx)=
, expected (%llx + %llx)\n",
> +				vma->node.start, vma->node.size, total, 2 * I915_GTT_PAGE_SIZE);
>  			err =3D -EINVAL;
>  			goto out;
>  		}
> @@ -1654,7 +1668,7 @@ static int igt_gtt_reserve(void *arg)
> =20
>  		err =3D i915_vma_unbind_unlocked(vma);
>  		if (err) {
> -			pr_err("i915_vma_unbind failed with err=3D%d!\n", err);
> +			drm_err(&ggtt->vm.i915->drm, "i915_vma_unbind failed with err=3D%d!\n=
", err);
>  			goto out;
>  		}
> =20
> @@ -1665,18 +1679,19 @@ static int igt_gtt_reserve(void *arg)
> =20
>  		err =3D reserve_gtt_with_resource(vma, offset);
>  		if (err) {
> -			pr_err("i915_gem_gtt_reserve (pass 3) failed at %llu/%llu with err=3D=
%d\n",
> -			       total, ggtt->vm.total, err);
> +			drm_err(&ggtt->vm.i915->drm,
> +				"i915_gem_gtt_reserve (pass 3) failed at %llu/%llu with err=3D%d\n",
> +				total, ggtt->vm.total, err);
>  			goto out;
>  		}
>  		track_vma_bind(vma);
> =20
>  		GEM_BUG_ON(!drm_mm_node_allocated(&vma->node));
>  		if (vma->node.start !=3D offset ||
> -		    vma->node.size !=3D 2*I915_GTT_PAGE_SIZE) {

ditto

> -			pr_err("i915_gem_gtt_reserve (pass 3) placement failed, found (%llx +=
 %llx), expected (%llx + %llx)\n",
> -			       vma->node.start, vma->node.size,
> -			       offset, 2*I915_GTT_PAGE_SIZE);
> +		    vma->node.size !=3D 2 * I915_GTT_PAGE_SIZE) {
> +			drm_err(&ggtt->vm.i915->drm,
> +				"i915_gem_gtt_reserve (pass 3) placement failed, found (%llx + %llx)=
, expected (%llx + %llx)\n",
> +				vma->node.start, vma->node.size, offset, 2 * I915_GTT_PAGE_SIZE);
>  			err =3D -EINVAL;
>  			goto out;
>  		}
> @@ -1730,7 +1745,7 @@ static int igt_gtt_insert(void *arg)
>  			0, ggtt->vm.total,
>  		},
>  		{
> -			2*I915_GTT_PAGE_SIZE, 0,
> +			2 * I915_GTT_PAGE_SIZE, 0,

ditto

>  			0, I915_GTT_PAGE_SIZE,
>  		},
>  		{
> @@ -1738,7 +1753,7 @@ static int igt_gtt_insert(void *arg)
>  			0, 4*I915_GTT_PAGE_SIZE,
>  		},
>  		{
> -			-(u64)2*I915_GTT_PAGE_SIZE, 2*I915_GTT_PAGE_SIZE,
> +			-(u64)2 * I915_GTT_PAGE_SIZE, 2 * I915_GTT_PAGE_SIZE,

ditto

>  			0, 4*I915_GTT_PAGE_SIZE,
>  		},
>  		{
> @@ -1766,9 +1781,9 @@ static int igt_gtt_insert(void *arg)
>  					  0);
>  		mutex_unlock(&ggtt->vm.mutex);
>  		if (err !=3D -ENOSPC) {
> -			pr_err("Invalid i915_gem_gtt_insert(.size=3D%llx, .alignment=3D%llx, =
.start=3D%llx, .end=3D%llx) succeeded (err=3D%d)\n",
> -			       ii->size, ii->alignment, ii->start, ii->end,
> -			       err);
> +			drm_err(&ggtt->vm.i915->drm,
> +				"Invalid i915_gem_gtt_insert(.size=3D%llx, .alignment=3D%llx, .start=
=3D%llx, .end=3D%llx) succeeded (err=3D%d)\n",
> +				ii->size, ii->alignment, ii->start, ii->end, err);
>  			return -EINVAL;
>  		}
>  	}
> @@ -1807,8 +1822,9 @@ static int igt_gtt_insert(void *arg)
>  			break;
>  		}
>  		if (err) {
> -			pr_err("i915_gem_gtt_insert (pass 1) failed at %llu/%llu with err=3D%=
d\n",
> -			       total, ggtt->vm.total, err);
> +			drm_err(&ggtt->vm.i915->drm,
> +				"i915_gem_gtt_insert (pass 1) failed at %llu/%llu with err=3D%d\n",
> +				total, ggtt->vm.total, err);
>  			goto out;
>  		}
>  		track_vma_bind(vma);
> @@ -1827,7 +1843,7 @@ static int igt_gtt_insert(void *arg)
>  		}
> =20
>  		if (!drm_mm_node_allocated(&vma->node)) {
> -			pr_err("VMA was unexpectedly evicted!\n");
> +			drm_err(&ggtt->vm.i915->drm, "VMA was unexpectedly evicted!\n");
>  			err =3D -EINVAL;
>  			goto out;
>  		}
> @@ -1851,22 +1867,24 @@ static int igt_gtt_insert(void *arg)
> =20
>  		err =3D i915_vma_unbind_unlocked(vma);
>  		if (err) {
> -			pr_err("i915_vma_unbind failed with err=3D%d!\n", err);
> +			drm_err(&ggtt->vm.i915->drm, "i915_vma_unbind failed with err=3D%d!\n=
", err);
>  			goto out;
>  		}
> =20
>  		err =3D insert_gtt_with_resource(vma);
>  		if (err) {
> -			pr_err("i915_gem_gtt_insert (pass 2) failed at %llu/%llu with err=3D%=
d\n",
> -			       total, ggtt->vm.total, err);
> +			drm_err(&ggtt->vm.i915->drm,
> +				"i915_gem_gtt_insert (pass 2) failed at %llu/%llu with err=3D%d\n",
> +				total, ggtt->vm.total, err);
>  			goto out;
>  		}
>  		track_vma_bind(vma);
> =20
>  		GEM_BUG_ON(!drm_mm_node_allocated(&vma->node));
>  		if (vma->node.start !=3D offset) {
> -			pr_err("i915_gem_gtt_insert did not return node to its previous locat=
ion (the only hole), expected address %llx, found %llx\n",
> -			       offset, vma->node.start);
> +			drm_err(&ggtt->vm.i915->drm,
> +				"i915_gem_gtt_insert did not return node to its previous location (t=
he only hole), expected address %llx, found %llx\n",
> +				offset, vma->node.start);
>  			err =3D -EINVAL;
>  			goto out;
>  		}
> @@ -1901,8 +1919,9 @@ static int igt_gtt_insert(void *arg)
> =20
>  		err =3D insert_gtt_with_resource(vma);
>  		if (err) {
> -			pr_err("i915_gem_gtt_insert (pass 3) failed at %llu/%llu with err=3D%=
d\n",
> -			       total, ggtt->vm.total, err);
> +			drm_err(&ggtt->vm.i915->drm,
> +				"i915_gem_gtt_insert (pass 3) failed at %llu/%llu with err=3D%d\n",
> +				total, ggtt->vm.total, err);
>  			goto out;
>  		}
>  		track_vma_bind(vma);
> diff --git a/drivers/gpu/drm/i915/selftests/i915_perf.c b/drivers/gpu/drm=
/i915/selftests/i915_perf.c
> index e9469e27f42a..1d5ed73e60ab 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_perf.c
> +++ b/drivers/gpu/drm/i915/selftests/i915_perf.c
> @@ -14,6 +14,8 @@
>  #include "igt_flush_test.h"
>  #include "lib_sw_fence.h"
> =20
> +#include <drm/drm_print.h>
> +
>  #define TEST_OA_CONFIG_UUID "12345678-1234-1234-1234-1234567890ab"
> =20
>  static int
> @@ -263,20 +265,18 @@ static int live_noa_delay(void *arg)
>  	t1 =3D poll_status(rq, 0x102);
>  	preempt_enable();
> =20
> -	pr_info("CPU delay: %lluns, expected %lluns\n",
> -		ktime_sub(t1, t0), expected);
> +	drm_info(&stream->engine->i915->drm, "CPU delay: %lluns, expected %llun=
s\n",
> +		 ktime_sub(t1, t0), expected);
> =20
>  	delay =3D intel_read_status_page(stream->engine, 0x102);
>  	delay -=3D intel_read_status_page(stream->engine, 0x100);
>  	delay =3D intel_gt_clock_interval_to_ns(stream->engine->gt, delay);
> -	pr_info("GPU delay: %uns, expected %lluns\n",
> -		delay, expected);
> +	drm_info(&stream->engine->i915->drm, "GPU delay: %uns, expected %lluns\=
n", delay, expected);
> =20
>  	if (4 * delay < 3 * expected || 2 * delay > 3 * expected) {
> -		pr_err("GPU delay [%uus] outside of expected threshold! [%lluus, %lluu=
s]\n",
> -		       delay / 1000,
> -		       div_u64(3 * expected, 4000),
> -		       div_u64(3 * expected, 2000));
> +		drm_err(&stream->engine->i915->drm,
> +			"GPU delay [%uus] outside of expected threshold! [%lluus, %lluus]\n",
> +			delay / 1000, div_u64(3 * expected, 4000), div_u64(3 * expected, 2000=
));
>  		err =3D -EINVAL;
>  	}
> =20
> @@ -385,7 +385,7 @@ static int live_noa_gpr(void *arg)
>  	i915_request_add(rq);
> =20
>  	if (i915_request_wait(rq, I915_WAIT_INTERRUPTIBLE, HZ / 2) < 0) {
> -		pr_err("noa_wait timed out\n");
> +		drm_err(&stream->engine->i915->drm, "noa_wait timed out\n");
>  		intel_gt_set_wedged(stream->engine->gt);
>  		err =3D -EIO;
>  		goto out_rq;
> @@ -396,14 +396,14 @@ static int live_noa_gpr(void *arg)
>  		if (store[i] =3D=3D STACK_MAGIC)
>  			continue;
> =20
> -		pr_err("GPR[%d] lost, found:%08x, expected:%08x!\n",
> -		       i, store[i], STACK_MAGIC);
> +		drm_err(&stream->engine->i915->drm, "GPR[%d] lost, found:%08x, expecte=
d:%08x!\n",
> +			i, store[i], STACK_MAGIC);
>  		err =3D -EINVAL;
>  	}
> =20
>  	/* Verify that the user's scratch page was not used for GPR storage */
>  	if (memchr_inv(scratch, POISON_FREE, PAGE_SIZE)) {
> -		pr_err("Scratch page overwritten!\n");
> +		drm_err(&stream->engine->i915->drm, "Scratch page overwritten!\n");
>  		igt_hexdump(scratch, 4096);
>  		err =3D -EINVAL;
>  	}
> diff --git a/drivers/gpu/drm/i915/selftests/i915_request.c b/drivers/gpu/=
drm/i915/selftests/i915_request.c
> index e1a7c454a0a9..e562c0dee03f 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_request.c
> +++ b/drivers/gpu/drm/i915/selftests/i915_request.c
> @@ -98,49 +98,51 @@ static int igt_wait_request(void *arg)
>  	i915_request_get(request);
> =20
>  	if (i915_request_wait(request, 0, 0) !=3D -ETIME) {
> -		pr_err("request wait (busy query) succeeded (expected timeout before s=
ubmit!)\n");
> +		drm_err(&i915->drm,
> +			"request wait (busy query) succeeded (expected timeout before submit!=
)\n");
>  		goto out_request;
>  	}
> =20
>  	if (i915_request_wait(request, 0, T) !=3D -ETIME) {
> -		pr_err("request wait succeeded (expected timeout before submit!)\n");
> +		drm_err(&i915->drm, "request wait succeeded (expected timeout before s=
ubmit!)\n");
>  		goto out_request;
>  	}
> =20
>  	if (i915_request_completed(request)) {
> -		pr_err("request completed before submit!!\n");
> +		drm_err(&i915->drm, "request completed before submit!!\n");
>  		goto out_request;
>  	}
> =20
>  	i915_request_add(request);
> =20
>  	if (i915_request_wait(request, 0, 0) !=3D -ETIME) {
> -		pr_err("request wait (busy query) succeeded (expected timeout after su=
bmit!)\n");
> +		drm_err(&i915->drm,
> +			"request wait (busy query) succeeded (expected timeout after submit!)=
\n");
>  		goto out_request;
>  	}
> =20
>  	if (i915_request_completed(request)) {
> -		pr_err("request completed immediately!\n");
> +		drm_err(&i915->drm, "request completed immediately!\n");
>  		goto out_request;
>  	}
> =20
>  	if (i915_request_wait(request, 0, T / 2) !=3D -ETIME) {
> -		pr_err("request wait succeeded (expected timeout!)\n");
> +		drm_err(&i915->drm, "request wait succeeded (expected timeout!)\n");
>  		goto out_request;
>  	}
> =20
>  	if (i915_request_wait(request, 0, T) =3D=3D -ETIME) {
> -		pr_err("request wait timed out!\n");
> +		drm_err(&i915->drm, "request wait timed out!\n");
>  		goto out_request;
>  	}
> =20
>  	if (!i915_request_completed(request)) {
> -		pr_err("request not complete after waiting!\n");
> +		drm_err(&i915->drm, "request not complete after waiting!\n");
>  		goto out_request;
>  	}
> =20
>  	if (i915_request_wait(request, 0, T) =3D=3D -ETIME) {
> -		pr_err("request wait timed out when already complete!\n");
> +		drm_err(&i915->drm, "request wait timed out when already complete!\n")=
;
>  		goto out_request;
>  	}
> =20
> @@ -165,34 +167,34 @@ static int igt_fence_wait(void *arg)
>  		return PTR_ERR(request);
> =20
>  	if (dma_fence_wait_timeout(&request->fence, false, T) !=3D -ETIME) {
> -		pr_err("fence wait success before submit (expected timeout)!\n");
> +		drm_err(&i915->drm, "fence wait success before submit (expected timeou=
t)!\n");
>  		goto out;
>  	}
> =20
>  	i915_request_add(request);
> =20
>  	if (dma_fence_is_signaled(&request->fence)) {
> -		pr_err("fence signaled immediately!\n");
> +		drm_err(&i915->drm, "fence signaled immediately!\n");
>  		goto out;
>  	}
> =20
>  	if (dma_fence_wait_timeout(&request->fence, false, T / 2) !=3D -ETIME) =
{
> -		pr_err("fence wait success after submit (expected timeout)!\n");
> +		drm_err(&i915->drm, "fence wait success after submit (expected timeout=
)!\n");
>  		goto out;
>  	}
> =20
>  	if (dma_fence_wait_timeout(&request->fence, false, T) <=3D 0) {
> -		pr_err("fence wait timed out (expected success)!\n");
> +		drm_err(&i915->drm, "fence wait timed out (expected success)!\n");
>  		goto out;
>  	}
> =20
>  	if (!dma_fence_is_signaled(&request->fence)) {
> -		pr_err("fence unsignaled after waiting!\n");
> +		drm_err(&i915->drm, "fence unsignaled after waiting!\n");
>  		goto out;
>  	}
> =20
>  	if (dma_fence_wait_timeout(&request->fence, false, T) <=3D 0) {
> -		pr_err("fence wait timed out when complete (expected success)!\n");
> +		drm_err(&i915->drm, "fence wait timed out when complete (expected succ=
ess)!\n");
>  		goto out;
>  	}
> =20
> @@ -245,7 +247,7 @@ static int igt_request_rewind(void *arg)
> =20
>  	/* Simulate preemption by manual reordering */
>  	if (!mock_cancel_request(request)) {
> -		pr_err("failed to cancel request (already executed)!\n");
> +		drm_err(&i915->drm, "failed to cancel request (already executed)!\n");
>  		i915_request_add(vip);
>  		goto err_context_1;
>  	}
> @@ -257,12 +259,12 @@ static int igt_request_rewind(void *arg)
> =20
> =20
>  	if (i915_request_wait(vip, 0, HZ) =3D=3D -ETIME) {
> -		pr_err("timed out waiting for high priority request\n");
> +		drm_err(&i915->drm, "timed out waiting for high priority request\n");
>  		goto err;
>  	}
> =20
>  	if (i915_request_completed(request)) {
> -		pr_err("low priority request already completed\n");
> +		drm_err(&i915->drm, "low priority request already completed\n");
>  		goto err;
>  	}
> =20
> @@ -406,10 +408,10 @@ static void __igt_breadcrumbs_smoketest(struct kthr=
ead_work *work)
>  					5 * HZ)) {
>  			struct i915_request *rq =3D requests[count - 1];
> =20
> -			pr_err("waiting for %d/%d fences (last %llx:%lld) on %s timed out!\n"=
,
> -			       atomic_read(&wait->pending), count,
> -			       rq->fence.context, rq->fence.seqno,
> -			       t->engine->name);
> +			drm_err(&t->engine->i915->drm,
> +				"waiting for %d/%d fences (last %llx:%lld) on %s timed out!\n",
> +				atomic_read(&wait->pending), count, rq->fence.context,
> +				rq->fence.seqno, t->engine->name);
>  			GEM_TRACE_DUMP();
> =20
>  			intel_gt_set_wedged(t->engine->gt);
> @@ -423,8 +425,8 @@ static void __igt_breadcrumbs_smoketest(struct kthrea=
d_work *work)
> =20
>  			if (!test_bit(DMA_FENCE_FLAG_SIGNALED_BIT,
>  				      &rq->fence.flags)) {
> -				pr_err("%llu:%llu was not signaled!\n",
> -				       rq->fence.context, rq->fence.seqno);
> +				drm_err(&t->engine->i915->drm, "%llu:%llu was not signaled!\n",
> +					rq->fence.context, rq->fence.seqno);
>  				err =3D -EINVAL;
>  			}
> =20
> @@ -523,10 +525,10 @@ static int mock_breadcrumbs_smoketest(void *arg)
> =20
>  		kthread_destroy_worker(threads[n].worker);
>  	}
> -	pr_info("Completed %lu waits for %lu fence across %d cpus\n",
> -		atomic_long_read(&t.num_waits),
> -		atomic_long_read(&t.num_fences),
> -		ncpus);
> +	drm_info(&i915->drm, "Completed %lu waits for %lu fence across %d cpus\=
n",
> +		 atomic_long_read(&t.num_waits),
> +		 atomic_long_read(&t.num_fences),
> +		 ncpus);
> =20
>  out_contexts:
>  	for (n =3D 0; n < t.ncontexts; n++) {
> @@ -632,10 +634,9 @@ static int live_nop_request(void *arg)
>  		if (err)
>  			return err;
> =20
> -		pr_info("Request latencies on %s: 1 =3D %lluns, %lu =3D %lluns\n",
> -			engine->name,
> -			ktime_to_ns(times[0]),
> -			prime, div64_u64(ktime_to_ns(times[1]), prime));
> +		drm_info(&i915->drm, "Request latencies on %s: 1 =3D %lluns, %lu =3D %=
lluns\n",
> +			 engine->name, ktime_to_ns(times[0]),  prime,
> +			 div64_u64(ktime_to_ns(times[1]), prime));
>  	}
> =20
>  	return err;
> @@ -663,7 +664,7 @@ static int __cancel_inactive(struct intel_engine_cs *=
engine)
>  		goto out_ce;
>  	}
> =20
> -	pr_debug("%s: Cancelling inactive request\n", engine->name);
> +	drm_dbg(&engine->i915->drm, "%s: Cancelling inactive request\n", engine=
->name);
>  	i915_request_cancel(rq, -EINTR);
>  	i915_request_get(rq);
>  	i915_request_add(rq);
> @@ -671,15 +672,16 @@ static int __cancel_inactive(struct intel_engine_cs=
 *engine)
>  	if (i915_request_wait(rq, 0, HZ / 5) < 0) {
>  		struct drm_printer p =3D drm_info_printer(engine->i915->drm.dev);
> =20
> -		pr_err("%s: Failed to cancel inactive request\n", engine->name);
> +			drm_err(&engine->i915->drm, "%s: Failed to cancel inactive request\n"=
,
> +				engine->name);
>  		intel_engine_dump(engine, &p, "%s\n", engine->name);
>  		err =3D -ETIME;
>  		goto out_rq;
>  	}
> =20
>  	if (rq->fence.error !=3D -EINTR) {
> -		pr_err("%s: fence not cancelled (%u)\n",
> -		       engine->name, rq->fence.error);
> +		drm_err(&engine->i915->drm, "%s: fence not cancelled (%u)\n",
> +			engine->name, rq->fence.error);
>  		err =3D -EINVAL;
>  	}
> =20
> @@ -690,7 +692,7 @@ static int __cancel_inactive(struct intel_engine_cs *=
engine)
>  out_spin:
>  	igt_spinner_fini(&spin);
>  	if (err)
> -		pr_err("%s: %s error %d\n", __func__, engine->name, err);
> +		drm_err(&engine->i915->drm, "%s: %s error %d\n", __func__, engine->nam=
e, err);
>  	return err;
>  }
> =20
> @@ -716,13 +718,13 @@ static int __cancel_active(struct intel_engine_cs *=
engine)
>  		goto out_ce;
>  	}
> =20
> -	pr_debug("%s: Cancelling active request\n", engine->name);
> +	drm_dbg(&engine->i915->drm, "%s: Cancelling active request\n", engine->=
name);
>  	i915_request_get(rq);
>  	i915_request_add(rq);
>  	if (!igt_wait_for_spinner(&spin, rq)) {
>  		struct drm_printer p =3D drm_info_printer(engine->i915->drm.dev);
> =20
> -		pr_err("Failed to start spinner on %s\n", engine->name);
> +		drm_err(&engine->i915->drm, "Failed to start spinner on %s\n", engine-=
>name);
>  		intel_engine_dump(engine, &p, "%s\n", engine->name);
>  		err =3D -ETIME;
>  		goto out_rq;
> @@ -732,15 +734,15 @@ static int __cancel_active(struct intel_engine_cs *=
engine)
>  	if (i915_request_wait(rq, 0, HZ / 5) < 0) {
>  		struct drm_printer p =3D drm_info_printer(engine->i915->drm.dev);
> =20
> -		pr_err("%s: Failed to cancel active request\n", engine->name);
> +		drm_err(&engine->i915->drm, "%s: Failed to cancel active request\n", e=
ngine->name);
>  		intel_engine_dump(engine, &p, "%s\n", engine->name);
>  		err =3D -ETIME;
>  		goto out_rq;
>  	}
> =20
>  	if (rq->fence.error !=3D -EINTR) {
> -		pr_err("%s: fence not cancelled (%u)\n",
> -		       engine->name, rq->fence.error);
> +		drm_err(&engine->i915->drm, "%s: fence not cancelled (%u)\n",
> +			engine->name, rq->fence.error);
>  		err =3D -EINVAL;
>  	}
> =20
> @@ -751,7 +753,7 @@ static int __cancel_active(struct intel_engine_cs *en=
gine)
>  out_spin:
>  	igt_spinner_fini(&spin);
>  	if (err)
> -		pr_err("%s: %s error %d\n", __func__, engine->name, err);
> +		drm_err(&engine->i915->drm, "%s: %s error %d\n", __func__, engine->nam=
e, err);
>  	return err;
>  }
> =20
> @@ -785,11 +787,11 @@ static int __cancel_completed(struct intel_engine_c=
s *engine)
>  		goto out_rq;
>  	}
> =20
> -	pr_debug("%s: Cancelling completed request\n", engine->name);
> +	drm_dbg(&engine->i915->drm, "%s: Cancelling completed request\n", engin=
e->name);
>  	i915_request_cancel(rq, -EINTR);
>  	if (rq->fence.error) {
> -		pr_err("%s: fence not cancelled (%u)\n",
> -		       engine->name, rq->fence.error);
> +		drm_err(&engine->i915->drm, "%s: fence not cancelled (%u)\n",
> +			engine->name, rq->fence.error);
>  		err =3D -EINVAL;
>  	}
> =20
> @@ -800,7 +802,7 @@ static int __cancel_completed(struct intel_engine_cs =
*engine)
>  out_spin:
>  	igt_spinner_fini(&spin);
>  	if (err)
> -		pr_err("%s: %s error %d\n", __func__, engine->name, err);
> +		drm_err(&engine->i915->drm, "%s: %s error %d\n", __func__, engine->nam=
e, err);
>  	return err;
>  }
> =20
> @@ -846,14 +848,14 @@ static int __cancel_reset(struct drm_i915_private *=
i915,
>  		goto out_ce;
>  	}
> =20
> -	pr_debug("%s: Cancelling active non-preemptable request\n",
> +	drm_dbg(&engine->i915->drm, "%s: Cancelling active non-preemptable requ=
est\n",
>  		 engine->name);
>  	i915_request_get(rq);
>  	i915_request_add(rq);
>  	if (!igt_wait_for_spinner(&spin, rq)) {
>  		struct drm_printer p =3D drm_info_printer(engine->i915->drm.dev);
> =20
> -		pr_err("Failed to start spinner on %s\n", engine->name);
> +		drm_err(&engine->i915->drm, "Failed to start spinner on %s\n", engine-=
>name);
>  		intel_engine_dump(engine, &p, "%s\n", engine->name);
>  		err =3D -ETIME;
>  		goto out_rq;
> @@ -870,15 +872,15 @@ static int __cancel_reset(struct drm_i915_private *=
i915,
>  	if (i915_request_wait(rq, 0, HZ) < 0) {
>  		struct drm_printer p =3D drm_info_printer(engine->i915->drm.dev);
> =20
> -		pr_err("%s: Failed to cancel hung request\n", engine->name);
> +		drm_err(&engine->i915->drm, "%s: Failed to cancel hung request\n", eng=
ine->name);
>  		intel_engine_dump(engine, &p, "%s\n", engine->name);
>  		err =3D -ETIME;
>  		goto out_nop;
>  	}
> =20
>  	if (rq->fence.error !=3D -EINTR) {
> -		pr_err("%s: fence not cancelled (%u)\n",
> -		       engine->name, rq->fence.error);
> +		drm_err(&engine->i915->drm, "%s: fence not cancelled (%u)\n",
> +			engine->name, rq->fence.error);
>  		err =3D -EINVAL;
>  		goto out_nop;
>  	}
> @@ -886,15 +888,15 @@ static int __cancel_reset(struct drm_i915_private *=
i915,
>  	if (i915_request_wait(nop, 0, HZ) < 0) {
>  		struct drm_printer p =3D drm_info_printer(engine->i915->drm.dev);
> =20
> -		pr_err("%s: Failed to complete nop request\n", engine->name);
> +		drm_err(&engine->i915->drm, "%s: Failed to complete nop request\n", en=
gine->name);
>  		intel_engine_dump(engine, &p, "%s\n", engine->name);
>  		err =3D -ETIME;
>  		goto out_nop;
>  	}
> =20
>  	if (nop->fence.error !=3D 0) {
> -		pr_err("%s: Nop request errored (%u)\n",
> -		       engine->name, nop->fence.error);
> +		drm_err(&engine->i915->drm, "%s: Nop request errored (%u)\n",
> +			engine->name, nop->fence.error);
>  		err =3D -EINVAL;
>  	}
> =20
> @@ -909,7 +911,7 @@ static int __cancel_reset(struct drm_i915_private *i9=
15,
>  out_restore:
>  	engine->props.preempt_timeout_ms =3D preempt_timeout_ms;
>  	if (err)
> -		pr_err("%s: %s error %d\n", __func__, engine->name, err);
> +		drm_err(&engine->i915->drm, "%s: %s error %d\n", __func__, engine->nam=
e, err);
>  	return err;
>  }
> =20
> @@ -1102,10 +1104,9 @@ static int live_empty_request(void *arg)
>  		if (err)
>  			goto out_batch;
> =20
> -		pr_info("Batch latencies on %s: 1 =3D %lluns, %lu =3D %lluns\n",
> -			engine->name,
> -			ktime_to_ns(times[0]),
> -			prime, div64_u64(ktime_to_ns(times[1]), prime));
> +		drm_info(&i915->drm, "Batch latencies on %s: 1 =3D %lluns, %lu =3D %ll=
uns\n",
> +			 engine->name, ktime_to_ns(times[0]),  prime,
> +			 div64_u64(ktime_to_ns(times[1]), prime));
>  out_batch:
>  		i915_vma_unpin(batch);
>  		i915_vma_put(batch);
> @@ -1218,8 +1219,7 @@ static int live_all_engines(void *arg)
>  		batch =3D recursive_batch(engine->gt);
>  		if (IS_ERR(batch)) {
>  			err =3D PTR_ERR(batch);
> -			pr_err("%s: Unable to create batch, err=3D%d\n",
> -			       __func__, err);
> +			drm_err(&i915->drm, "%s: Unable to create batch, err=3D%d\n", __func_=
_, err);
>  			goto out_free;
>  		}
> =20
> @@ -1227,8 +1227,8 @@ static int live_all_engines(void *arg)
>  		request[idx] =3D intel_engine_create_kernel_request(engine);
>  		if (IS_ERR(request[idx])) {
>  			err =3D PTR_ERR(request[idx]);
> -			pr_err("%s: Request allocation failed with err=3D%d\n",
> -			       __func__, err);
> +			drm_err(&i915->drm, "%s: Request allocation failed with err=3D%d\n",
> +				__func__, err);
>  			goto out_unlock;
>  		}
>  		GEM_BUG_ON(request[idx]->context->vm !=3D batch->vm);
> @@ -1252,7 +1252,7 @@ static int live_all_engines(void *arg)
>  	idx =3D 0;
>  	for_each_uabi_engine(engine, i915) {
>  		if (i915_request_completed(request[idx])) {
> -			pr_err("%s(%s): request completed too early!\n",
> +			drm_err(&i915->drm, "%s(%s): request completed too early!\n",
>  			       __func__, engine->name);
>  			err =3D -EINVAL;
>  			goto out_request;
> @@ -1264,8 +1264,8 @@ static int live_all_engines(void *arg)
>  	for_each_uabi_engine(engine, i915) {
>  		err =3D recursive_batch_resolve(request[idx]->batch);
>  		if (err) {
> -			pr_err("%s: failed to resolve batch, err=3D%d\n",
> -			       __func__, err);
> +			drm_err(&i915->drm, "%s: failed to resolve batch, err=3D%d\n",
> +				__func__, err);
>  			goto out_request;
>  		}
>  		idx++;
> @@ -1280,8 +1280,8 @@ static int live_all_engines(void *arg)
>  					    MAX_SCHEDULE_TIMEOUT);
>  		if (timeout < 0) {
>  			err =3D timeout;
> -			pr_err("%s: error waiting for request on %s, err=3D%d\n",
> -			       __func__, engine->name, err);
> +			drm_err(&i915->drm, "%s: error waiting for request on %s, err=3D%d\n"=
,
> +				__func__, engine->name, err);
>  			goto out_request;
>  		}
> =20
> @@ -1348,8 +1348,8 @@ static int live_sequential_engines(void *arg)
>  		batch =3D recursive_batch(engine->gt);
>  		if (IS_ERR(batch)) {
>  			err =3D PTR_ERR(batch);
> -			pr_err("%s: Unable to create batch for %s, err=3D%d\n",
> -			       __func__, engine->name, err);
> +			drm_err(&i915->drm, "%s: Unable to create batch for %s, err=3D%d\n",
> +				__func__, engine->name, err);
>  			goto out_free;
>  		}
> =20
> @@ -1357,8 +1357,8 @@ static int live_sequential_engines(void *arg)
>  		request[idx] =3D intel_engine_create_kernel_request(engine);
>  		if (IS_ERR(request[idx])) {
>  			err =3D PTR_ERR(request[idx]);
> -			pr_err("%s: Request allocation failed for %s with err=3D%d\n",
> -			       __func__, engine->name, err);
> +			drm_err(&i915->drm, "%s: Request allocation failed for %s with err=3D=
%d\n",
> +				__func__, engine->name, err);
>  			goto out_unlock;
>  		}
>  		GEM_BUG_ON(request[idx]->context->vm !=3D batch->vm);
> @@ -1368,8 +1368,8 @@ static int live_sequential_engines(void *arg)
>  							   &prev->fence);
>  			if (err) {
>  				i915_request_add(request[idx]);
> -				pr_err("%s: Request await failed for %s with err=3D%d\n",
> -				       __func__, engine->name, err);
> +				drm_err(&i915->drm, "%s: Request await failed for %s with err=3D%d\n=
",
> +					__func__, engine->name, err);
>  				goto out_unlock;
>  			}
>  		}
> @@ -1398,16 +1398,16 @@ static int live_sequential_engines(void *arg)
>  		long timeout;
> =20
>  		if (i915_request_completed(request[idx])) {
> -			pr_err("%s(%s): request completed too early!\n",
> -			       __func__, engine->name);
> +			drm_err(&i915->drm, "%s(%s): request completed too early!\n",
> +				__func__, engine->name);
>  			err =3D -EINVAL;
>  			goto out_request;
>  		}
> =20
>  		err =3D recursive_batch_resolve(request[idx]->batch);
>  		if (err) {
> -			pr_err("%s: failed to resolve batch, err=3D%d\n",
> -			       __func__, err);
> +			drm_err(&i915->drm, "%s: failed to resolve batch, err=3D%d\n",
> +				__func__, err);
>  			goto out_request;
>  		}
> =20
> @@ -1415,8 +1415,8 @@ static int live_sequential_engines(void *arg)
>  					    MAX_SCHEDULE_TIMEOUT);
>  		if (timeout < 0) {
>  			err =3D timeout;
> -			pr_err("%s: error waiting for request on %s, err=3D%d\n",
> -			       __func__, engine->name, err);
> +			drm_err(&i915->drm, "%s: error waiting for request on %s, err=3D%d\n"=
,
> +				__func__, engine->name, err);
>  			goto out_request;
>  		}
> =20
> @@ -1496,7 +1496,7 @@ static void __live_parallel_engine1(struct kthread_=
work *work)
>  	} while (!__igt_timeout(end_time, NULL));
>  	intel_engine_pm_put(engine);
> =20
> -	pr_info("%s: %lu request + sync\n", engine->name, count);
> +	drm_info(&engine->i915->drm, "%s: %lu request + sync\n", engine->name, =
count);
>  	thread->result =3D err;
>  }
> =20
> @@ -1525,7 +1525,7 @@ static void __live_parallel_engineN(struct kthread_=
work *work)
>  	} while (!__igt_timeout(end_time, NULL));
>  	intel_engine_pm_put(engine);
> =20
> -	pr_info("%s: %lu requests\n", engine->name, count);
> +	drm_info(&engine->i915->drm, "%s: %lu requests\n", engine->name, count)=
;
>  	thread->result =3D err;
>  }
> =20
> @@ -1592,7 +1592,7 @@ static void __live_parallel_spin(struct kthread_wor=
k *work)
>  		/* Occupy this engine for the whole test */
>  		err =3D wait_for_all(engine->i915);
>  	} else {
> -		pr_err("Failed to start spinner on %s\n", engine->name);
> +		drm_err(&engine->i915->drm, "Failed to start spinner on %s\n", engine-=
>name);
>  		err =3D -EINVAL;
>  	}
>  	igt_spinner_end(&spin);
> @@ -1798,8 +1798,8 @@ static int live_breadcrumbs_smoketest(void *arg)
>  		}
>  		/* One ring interleaved between requests from all cpus */
>  		smoke[idx].max_batch /=3D ncpus + 1;
> -		pr_debug("Limiting batches to %d requests on %s\n",
> -			 smoke[idx].max_batch, engine->name);
> +		drm_dbg(&i915->drm, "Limiting batches to %d requests on %s\n",
> +			smoke[idx].max_batch, engine->name);
> =20
>  		for (n =3D 0; n < ncpus; n++) {
>  			unsigned int i =3D idx * ncpus + n;
> @@ -1849,8 +1849,8 @@ static int live_breadcrumbs_smoketest(void *arg)
>  		num_fences +=3D atomic_long_read(&smoke[idx].num_fences);
>  		idx++;
>  	}
> -	pr_info("Completed %lu waits for %lu fences across %d engines and %d cp=
us\n",
> -		num_waits, num_fences, idx, ncpus);
> +	drm_info(&i915->drm, "Completed %lu waits for %lu fences across %d engi=
nes and %d cpus\n",
> +		 num_waits, num_fences, idx, ncpus);
> =20
>  	ret =3D igt_live_test_end(&live) ?: ret;
>  out_contexts:
> @@ -2075,9 +2075,8 @@ static int measure_semaphore_response(struct intel_=
context *ce)
>  	}
> =20
>  	cycles =3D trifilter(elapsed);
> -	pr_info("%s: semaphore response %d cycles, %lluns\n",
> -		ce->engine->name, cycles >> TF_BIAS,
> -		cycles_to_ns(ce->engine, cycles));
> +	drm_info(&ce->engine->i915->drm, "%s: semaphore response %d cycles, %ll=
uns\n",
> +		 ce->engine->name, cycles >> TF_BIAS, cycles_to_ns(ce->engine, cycles)=
);
> =20
>  	return intel_gt_wait_for_idle(ce->engine->gt, HZ);
> =20
> @@ -2146,9 +2145,8 @@ static int measure_idle_dispatch(struct intel_conte=
xt *ce)
>  		elapsed[i] =3D sema[i] - elapsed[i];
> =20
>  	cycles =3D trifilter(elapsed);
> -	pr_info("%s: idle dispatch latency %d cycles, %lluns\n",
> -		ce->engine->name, cycles >> TF_BIAS,
> -		cycles_to_ns(ce->engine, cycles));
> +	drm_info(&ce->engine->i915->drm, "%s: idle dispatch latency %d cycles, =
%lluns\n",
> +		 ce->engine->name, cycles >> TF_BIAS, cycles_to_ns(ce->engine, cycles)=
);
> =20
>  	return intel_gt_wait_for_idle(ce->engine->gt, HZ);
> =20
> @@ -2223,9 +2221,8 @@ static int measure_busy_dispatch(struct intel_conte=
xt *ce)
>  	}
> =20
>  	cycles =3D trifilter(elapsed);
> -	pr_info("%s: busy dispatch latency %d cycles, %lluns\n",
> -		ce->engine->name, cycles >> TF_BIAS,
> -		cycles_to_ns(ce->engine, cycles));
> +	drm_info(&ce->engine->i915->drm, "%s: busy dispatch latency %d cycles, =
%lluns\n",
> +		 ce->engine->name, cycles >> TF_BIAS, cycles_to_ns(ce->engine, cycles)=
);
> =20
>  	return intel_gt_wait_for_idle(ce->engine->gt, HZ);
> =20
> @@ -2336,9 +2333,8 @@ static int measure_inter_request(struct intel_conte=
xt *ce)
>  		elapsed[i - 1] =3D sema[i + 1] - sema[i];
> =20
>  	cycles =3D trifilter(elapsed);
> -	pr_info("%s: inter-request latency %d cycles, %lluns\n",
> -		ce->engine->name, cycles >> TF_BIAS,
> -		cycles_to_ns(ce->engine, cycles));
> +	drm_info(&ce->engine->i915->drm, "%s: inter-request latency %d cycles, =
%lluns\n",
> +		 ce->engine->name, cycles >> TF_BIAS, cycles_to_ns(ce->engine, cycles)=
);
> =20
>  	return intel_gt_wait_for_idle(ce->engine->gt, HZ);
> =20
> @@ -2431,9 +2427,8 @@ static int measure_context_switch(struct intel_cont=
ext *ce)
>  		elapsed[i - 1] =3D sema[2 * i + 2] - sema[2 * i + 1];
> =20
>  	cycles =3D trifilter(elapsed);
> -	pr_info("%s: context switch latency %d cycles, %lluns\n",
> -		ce->engine->name, cycles >> TF_BIAS,
> -		cycles_to_ns(ce->engine, cycles));
> +	drm_info(&ce->engine->i915->drm, "%s: context switch latency %d cycles,=
 %lluns\n",
> +		 ce->engine->name, cycles >> TF_BIAS, cycles_to_ns(ce->engine, cycles)=
);
> =20
>  	return intel_gt_wait_for_idle(ce->engine->gt, HZ);
> =20
> @@ -2534,17 +2529,15 @@ static int measure_preemption(struct intel_contex=
t *ce)
>  		elapsed[i - 1] =3D sema[2 * i + 0] - elapsed[i - 1];
> =20
>  	cycles =3D trifilter(elapsed);
> -	pr_info("%s: preemption dispatch latency %d cycles, %lluns\n",
> -		ce->engine->name, cycles >> TF_BIAS,
> -		cycles_to_ns(ce->engine, cycles));
> +	drm_info(&ce->engine->i915->drm,  "%s: preemption dispatch latency %d c=
ycles, %lluns\n",
> +		 ce->engine->name, cycles >> TF_BIAS, cycles_to_ns(ce->engine, cycles)=
);
> =20
>  	for (i =3D 1; i <=3D TF_COUNT; i++)
>  		elapsed[i - 1] =3D sema[2 * i + 1] - sema[2 * i + 0];
> =20
>  	cycles =3D trifilter(elapsed);
> -	pr_info("%s: preemption switch latency %d cycles, %lluns\n",
> -		ce->engine->name, cycles >> TF_BIAS,
> -		cycles_to_ns(ce->engine, cycles));
> +	drm_info(&ce->engine->i915->drm, "%s: preemption switch latency %d cycl=
es, %lluns\n",
> +		 ce->engine->name, cycles >> TF_BIAS, cycles_to_ns(ce->engine, cycles)=
);
> =20
>  	return intel_gt_wait_for_idle(ce->engine->gt, HZ);
> =20
> @@ -2636,9 +2629,8 @@ static int measure_completion(struct intel_context =
*ce)
>  	}
> =20
>  	cycles =3D trifilter(elapsed);
> -	pr_info("%s: completion latency %d cycles, %lluns\n",
> -		ce->engine->name, cycles >> TF_BIAS,
> -		cycles_to_ns(ce->engine, cycles));
> +	drm_info(&ce->engine->i915->drm, "%s: completion latency %d cycles, %ll=
uns\n",
> +		 ce->engine->name, cycles >> TF_BIAS, cycles_to_ns(ce->engine, cycles)=
);
> =20
>  	return intel_gt_wait_for_idle(ce->engine->gt, HZ);
> =20
> @@ -2929,11 +2921,11 @@ static int perf_series_engines(void *arg)
>  				decimal =3D 0;
>  			}
> =20
> -			pr_info("%s %5s: { seqno:%d, busy:%d.%02d%%, runtime:%lldms, walltime=
:%lldms }\n",
> -				name, p->engine->name, ce->timeline->seqno,
> -				integer, decimal,
> -				div_u64(p->runtime, 1000 * 1000),
> -				div_u64(ktime_to_ns(p->time), 1000 * 1000));
> +			drm_info(&i915->drm,
> +				 "%s %5s: { seqno:%d, busy:%d.%02d%%, runtime:%lldms, walltime:%lldm=
s }\n",
> +				 name, p->engine->name, ce->timeline->seqno, integer, decimal,
> +				 div_u64(p->runtime, 1000 * 1000), div_u64(ktime_to_ns(p->time),
> +				 1000 * 1000));
>  		}
>  	}
> =20
> @@ -3275,10 +3267,10 @@ static int perf_parallel_engines(void *arg)
>  			}
> =20
>  			GEM_BUG_ON(engine !=3D p->engine);
> -			pr_info("%s %5s: { count:%lu, busy:%d.%02d%%, runtime:%lldms, walltim=
e:%lldms }\n",
> -				name, engine->name, p->count, integer, decimal,
> -				div_u64(p->runtime, 1000 * 1000),
> -				div_u64(ktime_to_ns(p->time), 1000 * 1000));
> +			drm_info(&i915->drm, "%s %5s: { count:%lu, busy:%d.%02d%%, runtime:%l=
ldms, walltime:%lldms }\n",
> +				 name, engine->name, p->count, integer, decimal,
> +				 div_u64(p->runtime, 1000 * 1000),
> +				 div_u64(ktime_to_ns(p->time), 1000 * 1000));
>  			idx++;
>  		}
>  	}
> diff --git a/drivers/gpu/drm/i915/selftests/i915_vma.c b/drivers/gpu/drm/=
i915/selftests/i915_vma.c
> index 7c4111e60f2e..3750b9841818 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_vma.c
> +++ b/drivers/gpu/drm/i915/selftests/i915_vma.c
> @@ -24,6 +24,8 @@
> =20
>  #include <linux/prime_numbers.h>
> =20
> +#include <drm/drm_print.h>
> +
>  #include "gem/i915_gem_context.h"
>  #include "gem/i915_gem_internal.h"
>  #include "gem/selftests/mock_context.h"
> @@ -41,19 +43,18 @@ static bool assert_vma(struct i915_vma *vma,
>  	bool ok =3D true;
> =20
>  	if (vma->vm !=3D ctx->vm) {
> -		pr_err("VMA created with wrong VM\n");
> +		drm_err(obj->base.dev, "VMA created with wrong VM\n");
>  		ok =3D false;
>  	}
> =20
>  	if (vma->size !=3D obj->base.size) {
> -		pr_err("VMA created with wrong size, found %llu, expected %zu\n",
> +		drm_err(obj->base.dev, "VMA created with wrong size, found %llu, expec=
ted %zu\n",
>  		       vma->size, obj->base.size);
>  		ok =3D false;
>  	}
> =20
>  	if (vma->gtt_view.type !=3D I915_GTT_VIEW_NORMAL) {
> -		pr_err("VMA created with wrong type [%d]\n",
> -		       vma->gtt_view.type);
> +		drm_err(obj->base.dev, "VMA created with wrong type [%d]\n", vma->gtt_=
view.type);
>  		ok =3D false;
>  	}
> =20
> @@ -74,30 +75,29 @@ checked_vma_instance(struct drm_i915_gem_object *obj,
> =20
>  	/* Manual checks, will be reinforced by i915_vma_compare! */
>  	if (vma->vm !=3D vm) {
> -		pr_err("VMA's vm [%p] does not match request [%p]\n",
> -		       vma->vm, vm);
> +		drm_err(obj->base.dev, "VMA's vm [%p] does not match request [%p]\n", =
vma->vm, vm);
>  		ok =3D false;
>  	}
> =20
>  	if (i915_is_ggtt(vm) !=3D i915_vma_is_ggtt(vma)) {
> -		pr_err("VMA ggtt status [%d] does not match parent [%d]\n",
> -		       i915_vma_is_ggtt(vma), i915_is_ggtt(vm));
> +		drm_err(obj->base.dev, "VMA ggtt status [%d] does not match parent [%d=
]\n",
> +			i915_vma_is_ggtt(vma), i915_is_ggtt(vm));
>  		ok =3D false;
>  	}
> =20
>  	if (i915_vma_compare(vma, vm, view)) {
> -		pr_err("i915_vma_compare failed with create parameters!\n");
> +		drm_err(obj->base.dev, "i915_vma_compare failed with create parameters=
!\n");
>  		return ERR_PTR(-EINVAL);
>  	}
> =20
>  	if (i915_vma_compare(vma, vma->vm,
>  			     i915_vma_is_ggtt(vma) ? &vma->gtt_view : NULL)) {
> -		pr_err("i915_vma_compare failed with itself\n");
> +		drm_err(obj->base.dev, "i915_vma_compare failed with itself\n");
>  		return ERR_PTR(-EINVAL);
>  	}
> =20
>  	if (!ok) {
> -		pr_err("i915_vma_compare failed to detect the difference!\n");
> +		drm_err(obj->base.dev, "i915_vma_compare failed to detect the differen=
ce!\n");
>  		return ERR_PTR(-EINVAL);
>  	}
> =20
> @@ -126,14 +126,14 @@ static int create_vmas(struct drm_i915_private *i91=
5,
>  					return PTR_ERR(vma);
> =20
>  				if (!assert_vma(vma, obj, ctx)) {
> -					pr_err("VMA lookup/create failed\n");
> +					drm_err(obj->base.dev, "VMA lookup/create failed\n");
>  					return -EINVAL;
>  				}
> =20
>  				if (!pinned) {
>  					err =3D i915_vma_pin(vma, 0, 0, PIN_USER);
>  					if (err) {
> -						pr_err("Failed to pin VMA\n");
> +						drm_err(obj->base.dev, "Failed to pin VMA\n");
>  						return err;
>  					}
>  				} else {
> @@ -332,10 +332,10 @@ static int igt_vma_pin1(void *arg)
>  	for (m =3D modes; m->assert; m++) {
>  		err =3D i915_vma_pin(vma, m->size, 0, m->flags);
>  		if (!m->assert(vma, m, err)) {
> -			pr_err("%s to pin single page into GGTT with mode[%d:%s]: size=3D%llx=
 flags=3D%llx, err=3D%d\n",
> -			       m->assert =3D=3D assert_pin_valid ? "Failed" : "Unexpectedly s=
ucceeded",
> -			       (int)(m - modes), m->string, m->size, m->flags,
> -			       err);
> +			drm_err(obj->base.dev,
> +				"%s to pin single page into GGTT with mode[%d:%s]: size=3D%llx flags=
=3D%llx, err=3D%d\n",
> +				m->assert =3D=3D assert_pin_valid ? "Failed" : "Unexpectedly succeed=
ed",
> +				(int)(m - modes), m->string, m->size, m->flags, err);
>  			if (!err)
>  				i915_vma_unpin(vma);
>  			err =3D -EINVAL;
> @@ -346,7 +346,8 @@ static int igt_vma_pin1(void *arg)
>  			i915_vma_unpin(vma);
>  			err =3D i915_vma_unbind_unlocked(vma);
>  			if (err) {
> -				pr_err("Failed to unbind single page from GGTT, err=3D%d\n", err);
> +				drm_err(obj->base.dev,
> +					"Failed to unbind single page from GGTT, err=3D%d\n", err);
>  				goto out;
>  			}
>  		}
> @@ -384,8 +385,9 @@ assert_rotated(struct drm_i915_gem_object *obj,
>  			dma_addr_t src;
> =20
>  			if (!sg) {
> -				pr_err("Invalid sg table: too short at plane %d, (%d, %d)!\n",
> -				       n, x, y);
> +				drm_err(obj->base.dev,
> +					"Invalid sg table: too short at plane %d, (%d, %d)!\n",
> +					n, x, y);
>  				return ERR_PTR(-EINVAL);
>  			}
> =20
> @@ -393,15 +395,16 @@ assert_rotated(struct drm_i915_gem_object *obj,
>  			src =3D i915_gem_object_get_dma_address(obj, src_idx);
> =20
>  			if (sg_dma_len(sg) !=3D PAGE_SIZE) {
> -				pr_err("Invalid sg.length, found %d, expected %lu for rotated page (=
%d, %d) [src index %lu]\n",
> -				       sg_dma_len(sg), PAGE_SIZE,
> -				       x, y, src_idx);
> +				drm_err(obj->base.dev,
> +					"Invalid sg.length, found %d, expected %lu for rotated page (%d, %d=
) [src index %lu]\n",
> +					sg_dma_len(sg), PAGE_SIZE, x, y, src_idx);
>  				return ERR_PTR(-EINVAL);
>  			}
> =20
>  			if (sg_dma_address(sg) !=3D src) {
> -				pr_err("Invalid address for rotated page (%d, %d) [src index %lu]\n"=
,
> -				       x, y, src_idx);
> +				drm_err(obj->base.dev,
> +					"Invalid address for rotated page (%d, %d) [src index %lu]\n",
> +					x, y, src_idx);
>  				return ERR_PTR(-EINVAL);
>  			}
> =20
> @@ -414,20 +417,22 @@ assert_rotated(struct drm_i915_gem_object *obj,
>  			continue;
> =20
>  		if (!sg) {
> -			pr_err("Invalid sg table: too short at plane %d, (%d, %d)!\n",
> -			       n, x, y);
> +			drm_err(obj->base.dev,
> +				"Invalid sg table: too short at plane %d, (%d, %d)!\n", n, x, y);
>  			return ERR_PTR(-EINVAL);
>  		}
> =20
>  		if (sg_dma_len(sg) !=3D left) {
> -			pr_err("Invalid sg.length, found %d, expected %u for rotated page (%d=
, %d)\n",
> -			       sg_dma_len(sg), left, x, y);
> +			drm_err(obj->base.dev,
> +				"Invalid sg.length, found %d, expected %u for rotated page (%d, %d)\=
n",
> +				sg_dma_len(sg), left, x, y);
>  			return ERR_PTR(-EINVAL);
>  		}
> =20
>  		if (sg_dma_address(sg) !=3D 0) {
> -			pr_err("Invalid address, found %pad, expected 0 for remapped page (%d=
, %d)\n",
> -			       &sg_dma_address(sg), x, y);
> +			drm_err(obj->base.dev,
> +				"Invalid address, found %pad, expected 0 for remapped page (%d, %d)\=
n",
> +				&sg_dma_address(sg), x, y);
>  			return ERR_PTR(-EINVAL);
>  		}
> =20
> @@ -461,8 +466,9 @@ assert_remapped(struct drm_i915_gem_object *obj,
>  			dma_addr_t src;
> =20
>  			if (!sg) {
> -				pr_err("Invalid sg table: too short at plane %d, (%d, %d)!\n",
> -				       n, x, y);
> +				drm_err(obj->base.dev,
> +					"Invalid sg table: too short at plane %d, (%d, %d)!\n",
> +					n, x, y);
>  				return ERR_PTR(-EINVAL);
>  			}
>  			if (!left) {
> @@ -474,15 +480,16 @@ assert_remapped(struct drm_i915_gem_object *obj,
>  			src =3D i915_gem_object_get_dma_address(obj, src_idx);
> =20
>  			if (left < PAGE_SIZE || left & (PAGE_SIZE-1)) {
> -				pr_err("Invalid sg.length, found %d, expected %lu for remapped page =
(%d, %d) [src index %lu]\n",
> -				       sg_dma_len(sg), PAGE_SIZE,
> -				       x, y, src_idx);
> +				drm_err(obj->base.dev,
> +					"Invalid sg.length, found %d, expected %lu for remapped page (%d, %=
d) [src index %lu]\n",
> +					sg_dma_len(sg), PAGE_SIZE, x, y, src_idx);
>  				return ERR_PTR(-EINVAL);
>  			}
> =20
>  			if (sg_dma_address(sg) + offset !=3D src) {
> -				pr_err("Invalid address for remapped page (%d, %d) [src index %lu]\n=
",
> -				       x, y, src_idx);
> +				drm_err(obj->base.dev,
> +					"Invalid address for remapped page (%d, %d) [src index %lu]\n",
> +					x, y, src_idx);
>  				return ERR_PTR(-EINVAL);
>  			}
> =20
> @@ -495,9 +502,9 @@ assert_remapped(struct drm_i915_gem_object *obj,
>  		}
> =20
>  		if (left) {
> -			pr_err("Unexpected sg tail with %d size for remapped page (%d, %d)\n"=
,
> -			       left,
> -			       x, y);
> +			drm_err(obj->base.dev,
> +				"Unexpected sg tail with %d size for remapped page (%d, %d)\n",
> +				left, x, y);
>  			return ERR_PTR(-EINVAL);
>  		}
> =20
> @@ -507,22 +514,22 @@ assert_remapped(struct drm_i915_gem_object *obj,
>  			continue;
> =20
>  		if (!sg) {
> -			pr_err("Invalid sg table: too short at plane %d, (%d, %d)!\n",
> -			       n, x, y);
> +			drm_err(obj->base.dev,
> +				"Invalid sg table: too short at plane %d, (%d, %d)!\n", n, x, y);
>  			return ERR_PTR(-EINVAL);
>  		}
> =20
>  		if (sg_dma_len(sg) !=3D left) {
> -			pr_err("Invalid sg.length, found %u, expected %u for remapped page (%=
d, %d)\n",
> -			       sg_dma_len(sg), left,
> -			       x, y);
> +			drm_err(obj->base.dev,
> +				"Invalid sg.length, found %u, expected %u for remapped page (%d, %d)=
\n",
> +				sg_dma_len(sg), left, x, y);
>  			return ERR_PTR(-EINVAL);
>  		}
> =20
>  		if (sg_dma_address(sg) !=3D 0) {
> -			pr_err("Invalid address, found %pad, expected 0 for remapped page (%d=
, %d)\n",
> -			       &sg_dma_address(sg),
> -			       x, y);
> +			drm_err(obj->base.dev,
> +				"Invalid address, found %pad, expected 0 for remapped page (%d, %d)\=
n",
> +				&sg_dma_address(sg), x, y);
>  			return ERR_PTR(-EINVAL);
>  		}
> =20
> @@ -628,7 +635,8 @@ static int igt_vma_rotate_remap(void *arg)
> =20
>  					err =3D i915_vma_pin(vma, 0, 0, PIN_GLOBAL);
>  					if (err) {
> -						pr_err("Failed to pin VMA, err=3D%d\n", err);
> +						drm_err(obj->base.dev,
> +							"Failed to pin VMA, err=3D%d\n", err);
>  						goto out_object;
>  					}
> =20
> @@ -636,36 +644,41 @@ static int igt_vma_rotate_remap(void *arg)
> =20
>  					if (view.type =3D=3D I915_GTT_VIEW_ROTATED &&
>  					    vma->size !=3D expected_pages * PAGE_SIZE) {
> -						pr_err("VMA is wrong size, expected %lu, found %llu\n",
> -						       PAGE_SIZE * expected_pages, vma->size);
> +						drm_err(obj->base.dev,
> +							"VMA is wrong size, expected %lu, found %llu\n",
> +							PAGE_SIZE * expected_pages, vma->size);
>  						err =3D -EINVAL;
>  						goto out_object;
>  					}
> =20
>  					if (view.type =3D=3D I915_GTT_VIEW_REMAPPED &&
>  					    vma->size > expected_pages * PAGE_SIZE) {
> -						pr_err("VMA is wrong size, expected %lu, found %llu\n",
> -						       PAGE_SIZE * expected_pages, vma->size);
> +						drm_err(obj->base.dev,
> +							"VMA is wrong size, expected %lu, found %llu\n",
> +							PAGE_SIZE * expected_pages, vma->size);
>  						err =3D -EINVAL;
>  						goto out_object;
>  					}
> =20
>  					if (vma->pages->nents > expected_pages) {
> -						pr_err("sg table is wrong sizeo, expected %u, found %u nents\n",
> -						       expected_pages, vma->pages->nents);
> +						drm_err(obj->base.dev,
> +							"sg table is wrong sizeo, expected %u, found %u nents\n",
> +							expected_pages, vma->pages->nents);
>  						err =3D -EINVAL;
>  						goto out_object;
>  					}
> =20
>  					if (vma->node.size < vma->size) {
> -						pr_err("VMA binding too small, expected %llu, found %llu\n",
> -						       vma->size, vma->node.size);
> +						drm_err(obj->base.dev,
> +							"VMA binding too small, expected %llu, found %llu\n",
> +							vma->size, vma->node.size);
>  						err =3D -EINVAL;
>  						goto out_object;
>  					}
> =20
>  					if (vma->pages =3D=3D obj->mm.pages) {
> -						pr_err("VMA using unrotated object pages!\n");
> +						drm_err(obj->base.dev,
> +							"VMA using unrotated object pages!\n");
>  						err =3D -EINVAL;
>  						goto out_object;
>  					}
> @@ -677,19 +690,20 @@ static int igt_vma_rotate_remap(void *arg)
>  						else
>  							sg =3D assert_remapped(obj, &view.remapped, n, sg);
>  						if (IS_ERR(sg)) {
> -							pr_err("Inconsistent %s VMA pages for plane %d: [(%d, %d, %d, %d,=
 %d), (%d, %d, %d, %d, %d)]\n",
> -							       view.type =3D=3D I915_GTT_VIEW_ROTATED ?
> -							       "rotated" : "remapped", n,
> -							       plane_info[0].width,
> -							       plane_info[0].height,
> -							       plane_info[0].src_stride,
> -							       plane_info[0].dst_stride,
> -							       plane_info[0].offset,
> -							       plane_info[1].width,
> -							       plane_info[1].height,
> -							       plane_info[1].src_stride,
> -							       plane_info[1].dst_stride,
> -							       plane_info[1].offset);
> +							drm_err(obj->base.dev,
> +								"Inconsistent %s VMA pages for plane %d: [(%d, %d, %d, %d, %d), =
(%d, %d, %d, %d, %d)]\n",
> +								view.type =3D=3D I915_GTT_VIEW_ROTATED ?
> +								"rotated" : "remapped", n,
> +								plane_info[0].width,
> +								plane_info[0].height,
> +								plane_info[0].src_stride,
> +								plane_info[0].dst_stride,
> +								plane_info[0].offset,
> +								plane_info[1].width,
> +								plane_info[1].height,
> +								plane_info[1].src_stride,
> +								plane_info[1].dst_stride,
> +								plane_info[1].offset);
>  							err =3D -EINVAL;
>  							goto out_object;
>  						}
> @@ -698,7 +712,8 @@ static int igt_vma_rotate_remap(void *arg)
>  					i915_vma_unpin(vma);
>  					err =3D i915_vma_unbind_unlocked(vma);
>  					if (err) {
> -						pr_err("Unbinding returned %i\n", err);
> +						drm_err(obj->base.dev,
> +							"Unbinding returned %i\n", err);
>  						goto out_object;
>  					}
>  					cond_resched();
> @@ -726,14 +741,14 @@ static bool assert_partial(struct drm_i915_gem_obje=
ct *obj,
>  		dma_addr_t src;
> =20
>  		if (!size) {
> -			pr_err("Partial scattergather list too long\n");
> +			drm_err(obj->base.dev, "Partial scattergather list too long\n");
>  			return false;
>  		}
> =20
>  		src =3D i915_gem_object_get_dma_address(obj, offset);
>  		if (src !=3D dma) {
> -			pr_err("DMA mismatch for partial page offset %lu\n",
> -			       offset);
> +			drm_err(obj->base.dev,
> +				"DMA mismatch for partial page offset %lu\n", offset);
>  			return false;
>  		}
> =20
> @@ -752,38 +767,38 @@ static bool assert_pin(struct i915_vma *vma,
>  	bool ok =3D true;
> =20
>  	if (vma->size !=3D size) {
> -		pr_err("(%s) VMA is wrong size, expected %llu, found %llu\n",
> -		       name, size, vma->size);
> +		drm_err(vma->obj->base.dev, "(%s) VMA is wrong size, expected %llu, fo=
und %llu\n",
> +			name, size, vma->size);
>  		ok =3D false;
>  	}
> =20
>  	if (vma->node.size < vma->size) {
> -		pr_err("(%s) VMA binding too small, expected %llu, found %llu\n",
> -		       name, vma->size, vma->node.size);
> +		drm_err(vma->obj->base.dev,
> +			"(%s) VMA binding too small, expected %llu, found %llu\n",
> +			name, vma->size, vma->node.size);
>  		ok =3D false;
>  	}
> =20
>  	if (view && view->type !=3D I915_GTT_VIEW_NORMAL) {
>  		if (memcmp(&vma->gtt_view, view, sizeof(*view))) {
> -			pr_err("(%s) VMA mismatch upon creation!\n",
> -			       name);
> +			drm_err(vma->obj->base.dev, "(%s) VMA mismatch upon creation!\n", nam=
e);
>  			ok =3D false;
>  		}
> =20
>  		if (vma->pages =3D=3D vma->obj->mm.pages) {
> -			pr_err("(%s) VMA using original object pages!\n",
> -			       name);
> +			drm_err(vma->obj->base.dev,
> +				"(%s) VMA using original object pages!\n", name);
>  			ok =3D false;
>  		}
>  	} else {
>  		if (vma->gtt_view.type !=3D I915_GTT_VIEW_NORMAL) {
> -			pr_err("Not the normal ggtt view! Found %d\n",
> -			       vma->gtt_view.type);
> +			drm_err(vma->obj->base.dev,
> +				"Not the normal ggtt view! Found %d\n", vma->gtt_view.type);
>  			ok =3D false;
>  		}
> =20
>  		if (vma->pages !=3D vma->obj->mm.pages) {
> -			pr_err("VMA not using object pages!\n");
> +			drm_err(vma->obj->base.dev, "VMA not using object pages!\n");
>  			ok =3D false;
>  		}
>  	}
> @@ -843,15 +858,17 @@ static int igt_vma_partial(void *arg)
>  					goto out_object;
> =20
>  				if (!assert_pin(vma, &view, sz*PAGE_SIZE, p->name)) {
> -					pr_err("(%s) Inconsistent partial pinning for (offset=3D%d, size=3D=
%d)\n",
> -					       p->name, offset, sz);
> +					drm_err(obj->base.dev,
> +						"(%s) Inconsistent partial pinning for (offset=3D%d, size=3D%d)\n"=
,
> +						p->name, offset, sz);
>  					err =3D -EINVAL;
>  					goto out_object;
>  				}
> =20
>  				if (!assert_partial(obj, vma, offset, sz)) {
> -					pr_err("(%s) Inconsistent partial pages for (offset=3D%d, size=3D%d=
)\n",
> -					       p->name, offset, sz);
> +					drm_err(obj->base.dev,
> +						"(%s) Inconsistent partial pages for (offset=3D%d, size=3D%d)\n",
> +						p->name, offset, sz);
>  					err =3D -EINVAL;
>  					goto out_object;
>  				}
> @@ -860,7 +877,7 @@ static int igt_vma_partial(void *arg)
>  				nvma++;
>  				err =3D i915_vma_unbind_unlocked(vma);
>  				if (err) {
> -					pr_err("Unbinding returned %i\n", err);
> +					drm_err(obj->base.dev, "Unbinding returned %i\n", err);
>  					goto out_object;
>  				}
> =20
> @@ -872,8 +889,9 @@ static int igt_vma_partial(void *arg)
>  		list_for_each_entry(vma, &obj->vma.list, obj_link)
>  			count++;
>  		if (count !=3D nvma) {
> -			pr_err("(%s) All partial vma were not recorded on the obj->vma_list: =
found %u, expected %u\n",
> -			       p->name, count, nvma);
> +			drm_err(obj->base.dev,
> +				"(%s) All partial vma were not recorded on the obj->vma_list: found =
%u, expected %u\n",
> +				p->name, count, nvma);
>  			err =3D -EINVAL;
>  			goto out_object;
>  		}
> @@ -890,7 +908,7 @@ static int igt_vma_partial(void *arg)
>  			goto out_object;
> =20
>  		if (!assert_pin(vma, NULL, obj->base.size, p->name)) {
> -			pr_err("(%s) inconsistent full pin\n", p->name);
> +			drm_err(obj->base.dev, "(%s) inconsistent full pin\n", p->name);
>  			err =3D -EINVAL;
>  			goto out_object;
>  		}
> @@ -899,7 +917,7 @@ static int igt_vma_partial(void *arg)
> =20
>  		err =3D i915_vma_unbind_unlocked(vma);
>  		if (err) {
> -			pr_err("Unbinding returned %i\n", err);
> +			drm_err(obj->base.dev, "Unbinding returned %i\n", err);
>  			goto out_object;
>  		}
> =20
> @@ -907,7 +925,7 @@ static int igt_vma_partial(void *arg)
>  		list_for_each_entry(vma, &obj->vma.list, obj_link)
>  			count++;
>  		if (count !=3D nvma) {
> -			pr_err("(%s) allocated an extra full vma!\n", p->name);
> +			drm_err(obj->base.dev, "(%s) allocated an extra full vma!\n", p->name=
);
>  			err =3D -EINVAL;
>  			goto out_object;
>  		}
> @@ -1080,9 +1098,13 @@ static int igt_vma_remapped_gtt(void *arg)
> =20
>  					val =3D ioread32(&map[offset / sizeof(*map)]);
>  					if (val !=3D exp) {
> -						pr_err("%s VMA write test failed, expected 0x%x, found 0x%x\n",
> -						       *t =3D=3D I915_GTT_VIEW_ROTATED ? "Rotated" : "Remapped",
> -						       exp, val);
> +						const char *kind;
> +
> +						kind =3D *t =3D=3D I915_GTT_VIEW_ROTATED ?
> +							"Rotated" : "Remapped";

Not related.

> +						drm_err(vma->obj->base.dev,
> +							"%s VMA write test failed, expected 0x%x, found 0x%x\n",
> +							kind, exp, val);
>  						i915_vma_unpin_iomap(vma);
>  						err =3D -EINVAL;
>  						goto out;
> diff --git a/drivers/gpu/drm/i915/selftests/intel_uncore.c b/drivers/gpu/=
drm/i915/selftests/intel_uncore.c
> index 514d2200751b..ef17479fff1e 100644
> --- a/drivers/gpu/drm/i915/selftests/intel_uncore.c
> +++ b/drivers/gpu/drm/i915/selftests/intel_uncore.c
> @@ -26,9 +26,12 @@
> =20
>  #include "gt/intel_gt.h"
> =20
> +#include <drm/drm_print.h>
> +
>  static int intel_fw_table_check(const struct intel_forcewake_range *rang=
es,
>  				unsigned int num_ranges,
> -				bool is_watertight)
> +				bool is_watertight,
> +				const struct drm_device *drm)
>  {
>  	unsigned int i;
>  	s32 prev;
> @@ -36,22 +39,22 @@ static int intel_fw_table_check(const struct intel_fo=
rcewake_range *ranges,
>  	for (i =3D 0, prev =3D -1; i < num_ranges; i++, ranges++) {
>  		/* Check that the table is watertight */
>  		if (is_watertight && (prev + 1) !=3D (s32)ranges->start) {
> -			pr_err("%s: entry[%d]:(%x, %x) is not watertight to previous (%x)\n",
> -			       __func__, i, ranges->start, ranges->end, prev);
> +			drm_err(drm, "%s: entry[%d]:(%x, %x) is not watertight to previous (%=
x)\n",
> +				__func__, i, ranges->start, ranges->end, prev);
>  			return -EINVAL;
>  		}
> =20
>  		/* Check that the table never goes backwards */
>  		if (prev >=3D (s32)ranges->start) {
> -			pr_err("%s: entry[%d]:(%x, %x) is less than the previous (%x)\n",
> -			       __func__, i, ranges->start, ranges->end, prev);
> +			drm_err(drm, "%s: entry[%d]:(%x, %x) is less than the previous (%x)\n=
",
> +				__func__, i, ranges->start, ranges->end, prev);
>  			return -EINVAL;
>  		}
> =20
>  		/* Check that the entry is valid */
>  		if (ranges->start >=3D ranges->end) {
> -			pr_err("%s: entry[%d]:(%x, %x) has negative length\n",
> -			       __func__, i, ranges->start, ranges->end);
> +			drm_err(drm, "%s: entry[%d]:(%x, %x) has negative length\n",
> +				__func__, i, ranges->start, ranges->end);
>  			return -EINVAL;
>  		}
> =20
> @@ -82,20 +85,21 @@ static int intel_shadow_table_check(void)
>  		range =3D range_lists[j].regs;
>  		for (i =3D 0, prev =3D -1; i < range_lists[j].size; i++, range++) {
>  			if (range->end < range->start) {
> -				pr_err("%s: range[%d]:(%06x-%06x) has end before start\n",
> -				       __func__, i, range->start, range->end);
> +				drm_err(NULL, "%s: range[%d]:(%06x-%06x) has end before start\n",

As in the other patch, I'm not sure if switching to drm version and
explicitly passing NULL context to it makes sense.

Thanks,
Janusz

> +					__func__, i, range->start, range->end);
>  				return -EINVAL;
>  			}
> =20
>  			if (prev >=3D (s32)range->start) {
> -				pr_err("%s: range[%d]:(%06x-%06x) is before end of previous (%06x)\n=
",
> -				       __func__, i, range->start, range->end, prev);
> +				drm_err(NULL, "%s: range[%d]:(%06x-%06x) is before end of previous (=
%06x)\n",
> +					__func__, i, range->start, range->end, prev);
>  				return -EINVAL;
>  			}
> =20
>  			if (range->start % 4) {
> -				pr_err("%s: range[%d]:(%06x-%06x) has non-dword-aligned start\n",
> -				       __func__, i, range->start, range->end);
> +				drm_err(NULL,
> +					"%s: range[%d]:(%06x-%06x) has non-dword-aligned start\n",
> +					__func__, i, range->start, range->end);
>  				return -EINVAL;
>  			}
> =20
> @@ -126,7 +130,8 @@ int intel_uncore_mock_selftests(void)
>  	for (i =3D 0; i < ARRAY_SIZE(fw); i++) {
>  		err =3D intel_fw_table_check(fw[i].ranges,
>  					   fw[i].num_ranges,
> -					   fw[i].is_watertight);
> +					   fw[i].is_watertight,
> +					   NULL);
>  		if (err)
>  			return err;
>  	}
> @@ -172,7 +177,7 @@ static int live_forcewake_ops(void *arg)
> =20
>  	/* vlv/chv with their pcu behave differently wrt reads */
>  	if (IS_VALLEYVIEW(gt->i915) || IS_CHERRYVIEW(gt->i915)) {
> -		pr_debug("PCU fakes forcewake badly; skipping\n");
> +		drm_dbg(&gt->i915->drm, "PCU fakes forcewake badly; skipping\n");
>  		return 0;
>  	}
> =20
> @@ -192,8 +197,8 @@ static int live_forcewake_ops(void *arg)
>  		if (IS_GRAPHICS_VER(gt->i915, r->min_graphics_ver, r->max_graphics_ver=
))
>  			break;
>  	if (!r->name) {
> -		pr_debug("Forcewaked register not known for %s; skipping\n",
> -			 intel_platform_name(INTEL_INFO(gt->i915)->platform));
> +		drm_dbg(&gt->i915->drm, "Forcewaked register not known for %s; skippin=
g\n",
> +			intel_platform_name(INTEL_INFO(gt->i915)->platform));
>  		return 0;
>  	}
> =20
> @@ -225,8 +230,8 @@ static int live_forcewake_ops(void *arg)
>  			if (!domain->wake_count)
>  				continue;
> =20
> -			pr_err("fw_domain %s still active, aborting test!\n",
> -			       intel_uncore_forcewake_domain_to_str(domain->id));
> +			drm_err(&gt->i915->drm, "fw_domain %s still active, aborting test!\n"=
,
> +				intel_uncore_forcewake_domain_to_str(domain->id));
>  			err =3D -EINVAL;
>  			goto out_rpm;
>  		}
> @@ -245,23 +250,24 @@ static int live_forcewake_ops(void *arg)
>  			err =3D wait_ack_clear(domain, FORCEWAKE_KERNEL);
>  			preempt_enable();
>  			if (err) {
> -				pr_err("Failed to clear fw_domain %s\n",
> -				       intel_uncore_forcewake_domain_to_str(domain->id));
> +				drm_err(&gt->i915->drm, "Failed to clear fw_domain %s\n",
> +					intel_uncore_forcewake_domain_to_str(domain->id));
>  				goto out_rpm;
>  			}
>  		}
> =20
>  		if (!val) {
> -			pr_err("%s:%s was zero while fw was held!\n",
> -			       engine->name, r->name);
> +			drm_err(&engine->i915->drm, "%s:%s was zero while fw was held!\n",
> +				engine->name, r->name);
>  			err =3D -EINVAL;
>  			goto out_rpm;
>  		}
> =20
>  		/* We then expect the read to return 0 outside of the fw */
>  		if (wait_for(readl(reg) =3D=3D 0, 100)) {
> -			pr_err("%s:%s=3D%0x, fw_domains 0x%x still up after 100ms!\n",
> -			       engine->name, r->name, readl(reg), fw_domains);
> +			drm_err(&engine->i915->drm,
> +				"%s:%s=3D%0x, fw_domains 0x%x still up after 100ms!\n",
> +				engine->name, r->name, readl(reg), fw_domains);
>  			err =3D -ETIMEDOUT;
>  			goto out_rpm;
>  		}
> @@ -279,7 +285,8 @@ static int live_fw_table(void *arg)
>  	/* Confirm the table we load is still valid */
>  	return intel_fw_table_check(gt->uncore->fw_domains_table,
>  				    gt->uncore->fw_domains_table_entries,
> -				    GRAPHICS_VER(gt->i915) >=3D 9);
> +				    GRAPHICS_VER(gt->i915) >=3D 9,
> +				    &gt->i915->drm);
>  }
> =20
>  int intel_uncore_live_selftests(struct drm_i915_private *i915)
