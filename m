Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32E0CA5FCF
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 09:36:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E674A10F604;
	Thu,  1 Oct 2026 09:36:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Y/HbZOho";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE76610E337;
 Thu,  1 Oct 2026 09:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790847360; x=1822383360;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=oyqLsQekDqp+EJ2SZufDHPIC63Hu9M6re0tVLuE0kjg=;
 b=Y/HbZOhod2Jrmap/QYBCsorw0WOSrKGPzX6FWDzhXCJ1+WA8kBTkQSUZ
 O9p+ENWTMZqGZjuM5BigR7WtrMRHzMRA/tnNtLROSeFLvyOceuDhrrOsA
 g3e0gQ6uMbXRxdHL9wvELIoieEDTBLdVPa8iVsad7DR1kNtsJtOuYXfDB
 jL/F7s5Y/SVP1nHMB2lWsIoq5tU5ZydyKbEPLJ12S9Q2EFGrS4lsjqe96
 9098gVtsfXIXYN+o4voN1ZPCKnLJysGFF0D59eKdQccESFthdWhkj7Ihg
 vU3wtNyMXh6jjjFT2IvEzEYVlvu3OmDH2dbbSImpKYX1UZnzbEfQsX+FV g==;
X-CSE-ConnectionGUID: A3hEk7OqSZ6BYQLHe0NGEQ==
X-CSE-MsgGUID: zO2GVZHHTiK/7r3dLHDtOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="90365873"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="90365873"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 02:35:58 -0700
X-CSE-ConnectionGUID: IfyH38swTN6+ABT5wrPUjA==
X-CSE-MsgGUID: zdtWcF7TT42m+4CopT9xXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="275481427"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.245.246.237])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 02:35:56 -0700
Message-ID: <8250a361b933cc895f4986632d85bdc95c29db6f.camel@linux.intel.com>
Subject: Re: [PATCH v5 1/6] drm/i915/selftests: Use gt_*/drm_* prints in
 core selftests
From: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>, Krzysztof Karas
 <krzysztof.karas@intel.com>, intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Andi Shyti
 <andi.shyti@linux.intel.com>,  Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>
Date: Thu, 01 Oct 2026 11:35:53 +0200
In-Reply-To: <9bf453cfcddc57e9ae1601697c170d693e9bf055@intel.com>
References: <20261001074100.2694888-1-krzysztof.karas@intel.com>
 <20261001074100.2694888-2-krzysztof.karas@intel.com>
 <9bf453cfcddc57e9ae1601697c170d693e9bf055@intel.com>
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

On Thu, 2026-10-01 at 11:42 +0300, Jani Nikula wrote:
> On Thu, 01 Oct 2026, Krzysztof Karas <krzysztof.karas@intel.com> wrote:
> > Move away from generic pr prints to GT aware gt_* versions,
> > which tag each message with device and the tile it came from.
> >=20
> > i915_perf.c now uses drm_* prints, as it reports on a device
> > wide perf stream with no GT to attribute the message to.
> >=20
> > Ensure that 80 character line limit is respected wherever
> > possible.
> >=20
> > Assisted-by: GitHub-Copilot:claude-opus-5
> > Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
>=20
> Nitpicks only. Some of them are about pre-existing issues (hey, full
> sashiko style!) Feel free to ignore and maybe fix later.
>=20
> I'll only mention each type of thing once, instead of ditto everywhere.
>=20
> > ---
> > v5:
> >  * No changes since v4;
> >  * Rebased;
> >=20
> >  .../gpu/drm/i915/selftests/i915_gem_evict.c   |  52 +++--
> >  drivers/gpu/drm/i915/selftests/i915_gem_gtt.c | 164 +++++++++-----
> >  drivers/gpu/drm/i915/selftests/i915_perf.c    |  30 ++-
> >  drivers/gpu/drm/i915/selftests/i915_request.c | 206 ++++++++++++------
> >  drivers/gpu/drm/i915/selftests/i915_vma.c     | 187 ++++++++++------
> >  drivers/gpu/drm/i915/selftests/intel_uncore.c |  24 +-
> >  6 files changed, 433 insertions(+), 230 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_evict.c b/drivers/=
gpu/drm/i915/selftests/i915_gem_evict.c
> > index 718cddde7e73..b399a1b18906 100644
> > --- a/drivers/gpu/drm/i915/selftests/i915_gem_evict.c
> > +++ b/drivers/gpu/drm/i915/selftests/i915_gem_evict.c
> > @@ -71,11 +71,13 @@ static int populate_ggtt(struct i915_ggtt *ggtt, st=
ruct list_head *objects)
> >  		quirk_add(obj, objects);
> >  		count++;
> >  	} while (1);
> > -	pr_debug("Filled GGTT with %lu pages [%llu total]\n",
> > -		 count, ggtt->vm.total / PAGE_SIZE);
> > +	gt_dbg(ggtt->vm.gt,
> > +	       "Filled GGTT with %lu pages [%llu total]\n", count,
> > +	       ggtt->vm.total / PAGE_SIZE);
>=20
> A *lot* of the changes could remain in fewer lines. I think the LLM
> sticks to the old strict 80 column rule that we don't really adhere to
> anymore.

That was me, not an LLM, asking for minimal changes, e.g., preserving as=C2=
=A0
much existing line breaks as possible, not rearranging them only just=C2=A0
because we didn't like how they looked before, and also for preserving the=
=C2=A0
80 columns rule in source files that have still followed it.

I think we can still fix those formatting issues in a separate patch or=C2=
=A0
patch series.

Thanks,
Janusz

>=20
> This being selftest code, I don't really care all that much. But I'd
> care a lot more elsewhere in i915 and display/ in particular.
>=20
> > =20
> >  	if (list_empty(&ggtt->vm.bound_list)) {
> > -		pr_err("No objects on the GGTT inactive list!\n");
> > +		gt_err(ggtt->vm.gt,
> > +		       "No objects on the GGTT inactive list!\n");
> >  		return -EINVAL;
> >  	}
> > =20
> > @@ -125,8 +127,9 @@ static int igt_evict_something(void *arg)
> >  				       0);
> >  	mutex_unlock(&ggtt->vm.mutex);
> >  	if (err !=3D -ENOSPC) {
> > -		pr_err("i915_gem_evict_something failed on a full GGTT with err=3D%d=
\n",
> > -		       err);
> > +		gt_err(gt,
> > +		       "i915_gem_evict_something failed on a full GGTT with err=3D%d=
\n",
> > +			err);
>=20
> Manually written function name.
>=20
> >  		goto cleanup;
> >  	}
> > =20
> > @@ -140,7 +143,8 @@ static int igt_evict_something(void *arg)
> >  				       0);
> >  	mutex_unlock(&ggtt->vm.mutex);
> >  	if (err) {
> > -		pr_err("i915_gem_evict_something failed on a full GGTT with err=3D%d=
\n",
> > +		gt_err(gt,
> > +		       "i915_gem_evict_something failed on a full GGTT with err=3D%d=
\n",
> >  		       err);
> >  		goto cleanup;
> >  	}
> > @@ -177,7 +181,9 @@ static int igt_overcommit(void *arg)
> > =20
> >  	vma =3D i915_gem_object_ggtt_pin(obj, NULL, 0, 0, 0);
> >  	if (vma !=3D ERR_PTR(-ENOSPC)) {
> > -		pr_err("Failed to evict+insert, i915_gem_object_ggtt_pin returned er=
r=3D%d\n", (int)PTR_ERR_OR_ZERO(vma));
> > +		gt_err(gt,
> > +		       "Failed to evict+insert, i915_gem_object_ggtt_pin returned er=
r=3D%d\n",
> > +		       (int)PTR_ERR_OR_ZERO(vma));
>=20
> Generally I prefer "%pe" and ERR_PTR(), especially when you already have
> an error pointer. I don't think i915_gem_object_ggtt_pin() ever returns
> NULL, and even if it did, "%pe" would handle it.
>=20
> >  		err =3D -EINVAL;
> >  		goto cleanup;
> >  	}
> > @@ -209,7 +215,8 @@ static int igt_evict_for_vma(void *arg)
> >  	err =3D i915_gem_evict_for_node(&ggtt->vm, NULL, &target, 0);
> >  	mutex_unlock(&ggtt->vm.mutex);
> >  	if (err !=3D -ENOSPC) {
> > -		pr_err("i915_gem_evict_for_node on a full GGTT returned err=3D%d\n",
> > +		gt_err(gt,
> > +		       "i915_gem_evict_for_node on a full GGTT returned err=3D%d\n",
> >  		       err);
> >  		goto cleanup;
> >  	}
> > @@ -221,8 +228,7 @@ static int igt_evict_for_vma(void *arg)
> >  	err =3D i915_gem_evict_for_node(&ggtt->vm, NULL, &target, 0);
> >  	mutex_unlock(&ggtt->vm.mutex);
> >  	if (err) {
> > -		pr_err("i915_gem_evict_for_node returned err=3D%d\n",
> > -		       err);
> > +		gt_err(gt, "i915_gem_evict_for_node returned err=3D%d\n", err);
> >  		goto cleanup;
> >  	}
> > =20
> > @@ -273,7 +279,7 @@ static int igt_evict_for_cache_color(void *arg)
> >  	vma =3D i915_gem_object_ggtt_pin(obj, NULL, 0, 0,
> >  				       I915_GTT_PAGE_SIZE | flags);
> >  	if (IS_ERR(vma)) {
> > -		pr_err("[0]i915_gem_object_ggtt_pin failed\n");
> > +		gt_err(gt, "[0]i915_gem_object_ggtt_pin failed\n");
> >  		err =3D PTR_ERR(vma);
> >  		goto cleanup;
> >  	}
> > @@ -290,7 +296,7 @@ static int igt_evict_for_cache_color(void *arg)
> >  	vma =3D i915_gem_object_ggtt_pin(obj, NULL, 0, 0,
> >  				       (I915_GTT_PAGE_SIZE * 2) | flags);
> >  	if (IS_ERR(vma)) {
> > -		pr_err("[1]i915_gem_object_ggtt_pin failed\n");
> > +		gt_err(gt, "[1]i915_gem_object_ggtt_pin failed\n");
> >  		err =3D PTR_ERR(vma);
> >  		goto cleanup;
> >  	}
> > @@ -302,7 +308,8 @@ static int igt_evict_for_cache_color(void *arg)
> >  	err =3D i915_gem_evict_for_node(&ggtt->vm, NULL, &target, 0);
> >  	mutex_unlock(&ggtt->vm.mutex);
> >  	if (err) {
> > -		pr_err("[0]i915_gem_evict_for_node returned err=3D%d\n", err);
> > +		gt_err(gt,
> > +		       "[0]i915_gem_evict_for_node returned err=3D%d\n", err);
> >  		goto cleanup;
> >  	}
> > =20
> > @@ -315,7 +322,8 @@ static int igt_evict_for_cache_color(void *arg)
> >  	err =3D i915_gem_evict_for_node(&ggtt->vm, NULL, &target, 0);
> >  	mutex_unlock(&ggtt->vm.mutex);
> >  	if (!err) {
> > -		pr_err("[1]i915_gem_evict_for_node returned err=3D%d\n", err);
> > +		gt_err(gt,
> > +		       "[1]i915_gem_evict_for_node returned err=3D%d\n", err);
> >  		err =3D -EINVAL;
> >  		goto cleanup;
> >  	}
> > @@ -348,7 +356,8 @@ static int igt_evict_vm(void *arg)
> >  	err =3D i915_gem_evict_vm(&ggtt->vm, NULL, NULL);
> >  	mutex_unlock(&ggtt->vm.mutex);
> >  	if (err) {
> > -		pr_err("i915_gem_evict_vm on a full GGTT returned err=3D%d]\n",
> > +		gt_err(gt,
> > +		       "i915_gem_evict_vm on a full GGTT returned err=3D%d]\n",
> >  		       err);
>=20
> There's a stray ] in there, but it predates the patch.
>=20
> >  		goto cleanup;
> >  	}
> > @@ -362,7 +371,8 @@ static int igt_evict_vm(void *arg)
> >  	}
> > =20
> >  	if (err) {
> > -		pr_err("i915_gem_evict_vm on a full GGTT returned err=3D%d]\n",
> > +		gt_err(gt,
> > +		       "i915_gem_evict_vm on a full GGTT returned err=3D%d]\n",
> >  		       err);
> >  		goto cleanup;
> >  	}
> > @@ -443,7 +453,7 @@ static int igt_evict_contexts(void *arg)
> >  	} while (1);
> >  	drm_mm_remove_node(&hole);
> >  	mutex_unlock(&ggtt->vm.mutex);
> > -	pr_info("Filled GGTT with %lu 1MiB nodes\n", count);
> > +	gt_info(gt, "Filled GGTT with %lu 1MiB nodes\n", count);
> > =20
> >  	/* Overfill the GGTT with context objects and so try to evict one. */
> >  	for_each_engine(engine, gt, id) {
> > @@ -469,7 +479,8 @@ static int igt_evict_contexts(void *arg)
> >  			if (IS_ERR(rq)) {
> >  				/* When full, fail_if_busy will trigger EBUSY */
> >  				if (PTR_ERR(rq) !=3D -EBUSY) {
> > -					pr_err("Unexpected error from request alloc (on %s): %d\n",
> > +					gt_err(gt,
> > +					       "Unexpected error from request alloc (on %s): %d\n",
> >  					       engine->name,
> >  					       (int)PTR_ERR(rq));
>=20
> %pe would be more natural than going (int)PTR_ERR(rq).
>=20
> >  					err =3D PTR_ERR(rq);
> > @@ -492,7 +503,7 @@ static int igt_evict_contexts(void *arg)
> >  			err =3D 0;
> >  		} while(1);
> >  		onstack_fence_fini(&fence);
> > -		pr_info("Submitted %lu contexts/requests on %s\n",
> > +		gt_info(gt, "Submitted %lu contexts/requests on %s\n",
> >  			count, engine->name);
> >  		if (err)
> >  			break;
> > @@ -500,7 +511,8 @@ static int igt_evict_contexts(void *arg)
> >  			if (i915_request_wait(last, 0, HZ) < 0) {
> >  				err =3D -EIO;
> >  				i915_request_put(last);
> > -				pr_err("Failed waiting for last request (on %s)",
> > +				gt_err(gt,
> > +				       "Failed waiting for last request (on %s)\n",
> >  				       engine->name);
> >  				break;
> >  			}
> > diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c b/drivers/gp=
u/drm/i915/selftests/i915_gem_gtt.c
> > index e6bd06774816..0505937b78cd 100644
> > --- a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
> > +++ b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
> > @@ -32,8 +32,10 @@
> >  #include "gem/selftests/mock_context.h"
> >  #include "gt/intel_context.h"
> >  #include "gt/intel_gpu_commands.h"
> > +#include "gt/intel_gt_print.h"
> >  #include "gt/intel_gtt.h"
> > =20
> > +#include "i915_drv.h"
> >  #include "i915_random.h"
> >  #include "i915_selftest.h"
> >  #include "i915_vma_resource.h"
> > @@ -268,8 +270,10 @@ static int lowlevel_hole(struct i915_address_space=
 *vm,
> >  			hole_size =3D KMALLOC_MAX_SIZE / sizeof(u32);
> >  		count =3D hole_size >> 1;
> >  		if (!count) {
> > -			pr_debug("%s: hole is too small [%llx - %llx] >> %d: %lld\n",
> > -				 __func__, hole_start, hole_end, size, hole_size);
> > +			gt_dbg(vm->gt,
> > +			       "%s: hole is too small [%llx - %llx] >> %d: %lld\n",
> > +			       __func__, hole_start, hole_end, size,
> > +			       hole_size);
>=20
> gt_dbg() ends up in __drm_dev_dbg() which includes
> __builtin_return_address(0) i.e. you'll get caller debugging twice.
>=20
> Granted, compiler optimization might make __builtin_return_address(0)
> inaccurate, but debug logging the caller twice is a bit much.
>=20
> Note that gt_err() does *not* include __builtin_return_address(0). Using
> __func__ instead of that does increase module size.
>=20
> >  			break;
> >  		}
> > =20
> > @@ -472,15 +476,21 @@ static int fill_hole(struct i915_address_space *v=
m,
> > =20
> >  					err =3D i915_vma_pin(vma, 0, 0, offset | flags);
> >  					if (err) {
> > -						pr_err("%s(%s) pin (forward) failed with err=3D%d on size=3D%lu =
pages (prime=3D%lu), offset=3D%llx\n",
> > -						       __func__, p->name, err, npages, prime, offset);
> > +						gt_err(vm->gt,
> > +						       "%s(%s) pin (forward) failed with err=3D%d on size=3D%lu =
pages (prime=3D%lu), offset=3D%llx\n",
> > +						       __func__, p->name, err,
> > +						       npages, prime, offset);
> >  						goto err;
> >  					}
> > =20
> >  					if (!drm_mm_node_allocated(&vma->node) ||
> >  					    i915_vma_misplaced(vma, 0, 0, offset | flags)) {
> > -						pr_err("%s(%s) (forward) insert failed: vma.node=3D%llx + %llx [=
allocated? %d], expected offset %llx\n",
> > -						       __func__, p->name, vma->node.start, vma->node.size, drm_m=
m_node_allocated(&vma->node),
> > +						gt_err(vm->gt,
> > +						       "%s(%s) (forward) insert failed: vma.node=3D%llx + %llx [=
allocated? %d], expected offset %llx\n",
> > +						       __func__, p->name,
> > +						       vma->node.start,
> > +						       vma->node.size,
> > +						       drm_mm_node_allocated(&vma->node),
> >  						       offset);
> >  						err =3D -EINVAL;
> >  						goto err;
> > @@ -512,18 +522,22 @@ static int fill_hole(struct i915_address_space *v=
m,
> > =20
> >  					if (!drm_mm_node_allocated(&vma->node) ||
> >  					    i915_vma_misplaced(vma, 0, 0, offset | flags)) {
> > -						pr_err("%s(%s) (forward) moved vma.node=3D%llx + %llx, expected =
offset %llx\n",
> > -						       __func__, p->name, vma->node.start, vma->node.size,
> > -						       offset);
> > +						gt_err(vm->gt,
> > +						       "%s(%s) (forward) moved vma.node=3D%llx + %llx, expected =
offset %llx\n",
> > +						       __func__, p->name,
> > +						       vma->node.start,
> > +						       vma->node.size, offset);
> >  						err =3D -EINVAL;
> >  						goto err;
> >  					}
> > =20
> >  					err =3D i915_vma_unbind_unlocked(vma);
> >  					if (err) {
> > -						pr_err("%s(%s) (forward) unbind of vma.node=3D%llx + %llx failed=
 with err=3D%d\n",
> > -						       __func__, p->name, vma->node.start, vma->node.size,
> > -						       err);
> > +						gt_err(vm->gt,
> > +						       "%s(%s) (forward) unbind of vma.node=3D%llx + %llx failed=
 with err=3D%d\n",
> > +						       __func__, p->name,
> > +						       vma->node.start,
> > +						       vma->node.size, err);
> >  						goto err;
> >  					}
> > =20
> > @@ -551,15 +565,21 @@ static int fill_hole(struct i915_address_space *v=
m,
> > =20
> >  					err =3D i915_vma_pin(vma, 0, 0, offset | flags);
> >  					if (err) {
> > -						pr_err("%s(%s) pin (backward) failed with err=3D%d on size=3D%lu=
 pages (prime=3D%lu), offset=3D%llx\n",
> > -						       __func__, p->name, err, npages, prime, offset);
> > +						gt_err(vm->gt,
> > +						       "%s(%s) pin (backward) failed with err=3D%d on size=3D%lu=
 pages (prime=3D%lu), offset=3D%llx\n",
> > +						       __func__, p->name, err,
> > +						       npages, prime, offset);
> >  						goto err;
> >  					}
> > =20
> >  					if (!drm_mm_node_allocated(&vma->node) ||
> >  					    i915_vma_misplaced(vma, 0, 0, offset | flags)) {
> > -						pr_err("%s(%s) (backward) insert failed: vma.node=3D%llx + %llx =
[allocated? %d], expected offset %llx\n",
> > -						       __func__, p->name, vma->node.start, vma->node.size, drm_m=
m_node_allocated(&vma->node),
> > +						gt_err(vm->gt,
> > +						       "%s(%s) (backward) insert failed: vma.node=3D%llx + %llx =
[allocated? %d], expected offset %llx\n",
> > +						       __func__, p->name,
> > +						       vma->node.start,
> > +						       vma->node.size,
> > +						       drm_mm_node_allocated(&vma->node),
> >  						       offset);
> >  						err =3D -EINVAL;
> >  						goto err;
> > @@ -591,8 +611,12 @@ static int fill_hole(struct i915_address_space *vm=
,
> > =20
> >  					if (!drm_mm_node_allocated(&vma->node) ||
> >  					    i915_vma_misplaced(vma, 0, 0, offset | flags)) {
> > -						pr_err("%s(%s) (backward) moved vma.node=3D%llx + %llx [allocate=
d? %d], expected offset %llx\n",
> > -						       __func__, p->name, vma->node.start, vma->node.size, drm_m=
m_node_allocated(&vma->node),
> > +						gt_err(vm->gt,
> > +						       "%s(%s) (backward) moved vma.node=3D%llx + %llx [allocate=
d? %d], expected offset %llx\n",
> > +						       __func__, p->name,
> > +						       vma->node.start,
> > +						       vma->node.size,
> > +						       drm_mm_node_allocated(&vma->node),
> >  						       offset);
> >  						err =3D -EINVAL;
> >  						goto err;
> > @@ -600,9 +624,11 @@ static int fill_hole(struct i915_address_space *vm=
,
> > =20
> >  					err =3D i915_vma_unbind_unlocked(vma);
> >  					if (err) {
> > -						pr_err("%s(%s) (backward) unbind of vma.node=3D%llx + %llx faile=
d with err=3D%d\n",
> > -						       __func__, p->name, vma->node.start, vma->node.size,
> > -						       err);
> > +						gt_err(vm->gt,
> > +						       "%s(%s) (backward) unbind of vma.node=3D%llx + %llx faile=
d with err=3D%d\n",
> > +						       __func__, p->name,
> > +						       vma->node.start,
> > +						       vma->node.size, err);
> >  						goto err;
> >  					}
> > =20
> > @@ -672,16 +698,18 @@ static int walk_hole(struct i915_address_space *v=
m,
> >  		     addr +=3D round_up(obj->base.size, min_alignment)) {
> >  			err =3D i915_vma_pin(vma, 0, 0, addr | flags);
> >  			if (err) {
> > -				pr_err("%s bind failed at %llx + %llx [hole %llx- %llx] with err=
=3D%d\n",
> > -				       __func__, addr, vma->size,
> > -				       hole_start, hole_end, err);
> > +				gt_err(vm->gt,
> > +				       "%s bind failed at %llx + %llx [hole %llx- %llx] with err=
=3D%d\n",
> > +				       __func__, addr, vma->size, hole_start,
> > +				       hole_end, err);
> >  				goto err_put;
> >  			}
> >  			i915_vma_unpin(vma);
> > =20
> >  			if (!drm_mm_node_allocated(&vma->node) ||
> >  			    i915_vma_misplaced(vma, 0, 0, addr | flags)) {
> > -				pr_err("%s incorrect at %llx + %llx\n",
> > +				gt_err(vm->gt,
> > +				       "%s incorrect at %llx + %llx\n",
> >  				       __func__, addr, vma->size);
> >  				err =3D -EINVAL;
> >  				goto err_put;
> > @@ -689,7 +717,8 @@ static int walk_hole(struct i915_address_space *vm,
> > =20
> >  			err =3D i915_vma_unbind_unlocked(vma);
> >  			if (err) {
> > -				pr_err("%s unbind failed at %llx + %llx  with err=3D%d\n",
> > +				gt_err(vm->gt,
> > +				       "%s unbind failed at %llx + %llx  with err=3D%d\n",
> >  				       __func__, addr, vma->size, err);
> >  				goto err_put;
> >  			}
> > @@ -754,7 +783,8 @@ static int pot_hole(struct i915_address_space *vm,
> >  		     addr +=3D step) {
> >  			err =3D i915_vma_pin(vma, 0, 0, addr | flags);
> >  			if (err) {
> > -				pr_err("%s failed to pin object at %llx in hole [%llx - %llx], wit=
h err=3D%d\n",
> > +				gt_err(vm->gt,
> > +				       "%s failed to pin object at %llx in hole [%llx - %llx], wit=
h err=3D%d\n",
> >  				       __func__,
> >  				       addr,
> >  				       hole_start, hole_end,
> > @@ -764,7 +794,8 @@ static int pot_hole(struct i915_address_space *vm,
> > =20
> >  			if (!drm_mm_node_allocated(&vma->node) ||
> >  			    i915_vma_misplaced(vma, 0, 0, addr | flags)) {
> > -				pr_err("%s incorrect at %llx + %llx\n",
> > +				gt_err(vm->gt,
> > +				       "%s incorrect at %llx + %llx\n",
> >  				       __func__, addr, vma->size);
> >  				i915_vma_unpin(vma);
> >  				err =3D i915_vma_unbind_unlocked(vma);
> > @@ -819,8 +850,10 @@ static int drunk_hole(struct i915_address_space *v=
m,
> >  			hole_size =3D KMALLOC_MAX_SIZE / sizeof(u32);
> >  		count =3D hole_size >> 1;
> >  		if (!count) {
> > -			pr_debug("%s: hole is too small [%llx - %llx] >> %d: %lld\n",
> > -				 __func__, hole_start, hole_end, size, hole_size);
> > +			gt_dbg(vm->gt,
> > +			       "%s: hole is too small [%llx - %llx] >> %d: %lld\n",
> > +			       __func__, hole_start, hole_end, size,
> > +			       hole_size);
> >  			break;
> >  		}
> > =20
> > @@ -859,7 +892,8 @@ static int drunk_hole(struct i915_address_space *vm=
,
> > =20
> >  			err =3D i915_vma_pin(vma, 0, 0, addr | flags);
> >  			if (err) {
> > -				pr_err("%s failed to pin object at %llx + %llx in hole [%llx - %ll=
x], with err=3D%d\n",
> > +				gt_err(vm->gt,
> > +				       "%s failed to pin object at %llx + %llx in hole [%llx - %ll=
x], with err=3D%d\n",
> >  				       __func__,
> >  				       addr, BIT_ULL(size),
> >  				       hole_start, hole_end,
> > @@ -869,7 +903,8 @@ static int drunk_hole(struct i915_address_space *vm=
,
> > =20
> >  			if (!drm_mm_node_allocated(&vma->node) ||
> >  			    i915_vma_misplaced(vma, 0, 0, addr | flags)) {
> > -				pr_err("%s incorrect at %llx + %llx\n",
> > +				gt_err(vm->gt,
> > +				       "%s incorrect at %llx + %llx\n",
> >  				       __func__, addr, BIT_ULL(size));
> >  				i915_vma_unpin(vma);
> >  				err =3D i915_vma_unbind_unlocked(vma);
> > @@ -939,14 +974,16 @@ static int __shrink_hole(struct i915_address_spac=
e *vm,
> > =20
> >  		err =3D i915_vma_pin(vma, 0, 0, addr | flags);
> >  		if (err) {
> > -			pr_err("%s failed to pin object at %llx + %llx in hole [%llx - %llx=
], with err=3D%d\n",
> > -			       __func__, addr, size, hole_start, hole_end, err);
> > +			gt_err(vm->gt,
> > +			       "%s failed to pin object at %llx + %llx in hole [%llx - %llx=
], with err=3D%d\n",
> > +			       __func__, addr, size, hole_start, hole_end,
> > +			       err);
> >  			break;
> >  		}
> > =20
> >  		if (!drm_mm_node_allocated(&vma->node) ||
> >  		    i915_vma_misplaced(vma, 0, 0, addr | flags)) {
> > -			pr_err("%s incorrect at %llx + %llx\n",
> > +			gt_err(vm->gt, "%s incorrect at %llx + %llx\n",
> >  			       __func__, addr, size);
> >  			i915_vma_unpin(vma);
> >  			err =3D i915_vma_unbind_unlocked(vma);
> > @@ -1419,7 +1456,8 @@ static int igt_ggtt_page(void *arg)
> >  		io_mapping_unmap_atomic(vaddr);
> > =20
> >  		if (val !=3D n) {
> > -			pr_err("insert page failed: found %d, expected %d\n",
> > +			gt_err(ggtt->vm.gt,
> > +			       "insert page failed: found %d, expected %d\n",
> >  			       val, n);
> >  			err =3D -EINVAL;
> >  			break;
> > @@ -1578,7 +1616,8 @@ static int igt_gtt_reserve(void *arg)
> > =20
> >  		err =3D reserve_gtt_with_resource(vma, total);
> >  		if (err) {
> > -			pr_err("i915_gem_gtt_reserve (pass 1) failed at %llu/%llu with err=
=3D%d\n",
> > +			gt_err(ggtt->vm.gt,
> > +			       "i915_gem_gtt_reserve (pass 1) failed at %llu/%llu with err=
=3D%d\n",
> >  			       total, ggtt->vm.total, err);
> >  			goto out;
> >  		}
> > @@ -1587,9 +1626,10 @@ static int igt_gtt_reserve(void *arg)
> >  		GEM_BUG_ON(!drm_mm_node_allocated(&vma->node));
> >  		if (vma->node.start !=3D total ||
> >  		    vma->node.size !=3D 2*I915_GTT_PAGE_SIZE) {
> > -			pr_err("i915_gem_gtt_reserve (pass 1) placement failed, found (%llx=
 + %llx), expected (%llx + %llx)\n",
> > -			       vma->node.start, vma->node.size,
> > -			       total, 2*I915_GTT_PAGE_SIZE);
> > +			gt_err(ggtt->vm.gt,
> > +			       "i915_gem_gtt_reserve (pass 1) placement failed, found (%llx=
 + %llx), expected (%llx + %llx)\n",
> > +			       vma->node.start, vma->node.size, total,
> > +			       2 * I915_GTT_PAGE_SIZE);
> >  			err =3D -EINVAL;
> >  			goto out;
> >  		}
> > @@ -1624,7 +1664,8 @@ static int igt_gtt_reserve(void *arg)
> > =20
> >  		err =3D reserve_gtt_with_resource(vma, total);
> >  		if (err) {
> > -			pr_err("i915_gem_gtt_reserve (pass 2) failed at %llu/%llu with err=
=3D%d\n",
> > +			gt_err(ggtt->vm.gt,
> > +			       "i915_gem_gtt_reserve (pass 2) failed at %llu/%llu with err=
=3D%d\n",
> >  			       total, ggtt->vm.total, err);
> >  			goto out;
> >  		}
> > @@ -1633,9 +1674,10 @@ static int igt_gtt_reserve(void *arg)
> >  		GEM_BUG_ON(!drm_mm_node_allocated(&vma->node));
> >  		if (vma->node.start !=3D total ||
> >  		    vma->node.size !=3D 2*I915_GTT_PAGE_SIZE) {
> > -			pr_err("i915_gem_gtt_reserve (pass 2) placement failed, found (%llx=
 + %llx), expected (%llx + %llx)\n",
> > -			       vma->node.start, vma->node.size,
> > -			       total, 2*I915_GTT_PAGE_SIZE);
> > +			gt_err(ggtt->vm.gt,
> > +			       "i915_gem_gtt_reserve (pass 2) placement failed, found (%llx=
 + %llx), expected (%llx + %llx)\n",
> > +			       vma->node.start, vma->node.size, total,
> > +			       2 * I915_GTT_PAGE_SIZE);
> >  			err =3D -EINVAL;
> >  			goto out;
> >  		}
> > @@ -1654,7 +1696,8 @@ static int igt_gtt_reserve(void *arg)
> > =20
> >  		err =3D i915_vma_unbind_unlocked(vma);
> >  		if (err) {
> > -			pr_err("i915_vma_unbind failed with err=3D%d!\n", err);
> > +			gt_err(ggtt->vm.gt,
> > +			       "i915_vma_unbind failed with err=3D%d!\n", err);
> >  			goto out;
> >  		}
> > =20
> > @@ -1665,7 +1708,8 @@ static int igt_gtt_reserve(void *arg)
> > =20
> >  		err =3D reserve_gtt_with_resource(vma, offset);
> >  		if (err) {
> > -			pr_err("i915_gem_gtt_reserve (pass 3) failed at %llu/%llu with err=
=3D%d\n",
> > +			gt_err(ggtt->vm.gt,
> > +			       "i915_gem_gtt_reserve (pass 3) failed at %llu/%llu with err=
=3D%d\n",
> >  			       total, ggtt->vm.total, err);
> >  			goto out;
> >  		}
> > @@ -1674,9 +1718,10 @@ static int igt_gtt_reserve(void *arg)
> >  		GEM_BUG_ON(!drm_mm_node_allocated(&vma->node));
> >  		if (vma->node.start !=3D offset ||
> >  		    vma->node.size !=3D 2*I915_GTT_PAGE_SIZE) {
> > -			pr_err("i915_gem_gtt_reserve (pass 3) placement failed, found (%llx=
 + %llx), expected (%llx + %llx)\n",
> > -			       vma->node.start, vma->node.size,
> > -			       offset, 2*I915_GTT_PAGE_SIZE);
> > +			gt_err(ggtt->vm.gt,
> > +			       "i915_gem_gtt_reserve (pass 3) placement failed, found (%llx=
 + %llx), expected (%llx + %llx)\n",
> > +			       vma->node.start, vma->node.size, offset,
> > +			       2 * I915_GTT_PAGE_SIZE);
> >  			err =3D -EINVAL;
> >  			goto out;
> >  		}
> > @@ -1766,7 +1811,8 @@ static int igt_gtt_insert(void *arg)
> >  					  0);
> >  		mutex_unlock(&ggtt->vm.mutex);
> >  		if (err !=3D -ENOSPC) {
> > -			pr_err("Invalid i915_gem_gtt_insert(.size=3D%llx, .alignment=3D%llx=
, .start=3D%llx, .end=3D%llx) succeeded (err=3D%d)\n",
> > +			gt_err(ggtt->vm.gt,
> > +			       "Invalid i915_gem_gtt_insert(.size=3D%llx, .alignment=3D%llx=
, .start=3D%llx, .end=3D%llx) succeeded (err=3D%d)\n",
> >  			       ii->size, ii->alignment, ii->start, ii->end,
> >  			       err);
> >  			return -EINVAL;
> > @@ -1807,7 +1853,8 @@ static int igt_gtt_insert(void *arg)
> >  			break;
> >  		}
> >  		if (err) {
> > -			pr_err("i915_gem_gtt_insert (pass 1) failed at %llu/%llu with err=
=3D%d\n",
> > +			gt_err(ggtt->vm.gt,
> > +			       "i915_gem_gtt_insert (pass 1) failed at %llu/%llu with err=
=3D%d\n",
> >  			       total, ggtt->vm.total, err);
> >  			goto out;
> >  		}
> > @@ -1827,7 +1874,8 @@ static int igt_gtt_insert(void *arg)
> >  		}
> > =20
> >  		if (!drm_mm_node_allocated(&vma->node)) {
> > -			pr_err("VMA was unexpectedly evicted!\n");
> > +			gt_err(ggtt->vm.gt,
> > +			       "VMA was unexpectedly evicted!\n");
> >  			err =3D -EINVAL;
> >  			goto out;
> >  		}
> > @@ -1851,13 +1899,15 @@ static int igt_gtt_insert(void *arg)
> > =20
> >  		err =3D i915_vma_unbind_unlocked(vma);
> >  		if (err) {
> > -			pr_err("i915_vma_unbind failed with err=3D%d!\n", err);
> > +			gt_err(ggtt->vm.gt,
> > +			       "i915_vma_unbind failed with err=3D%d!\n", err);
> >  			goto out;
> >  		}
> > =20
> >  		err =3D insert_gtt_with_resource(vma);
> >  		if (err) {
> > -			pr_err("i915_gem_gtt_insert (pass 2) failed at %llu/%llu with err=
=3D%d\n",
> > +			gt_err(ggtt->vm.gt,
> > +			       "i915_gem_gtt_insert (pass 2) failed at %llu/%llu with err=
=3D%d\n",
> >  			       total, ggtt->vm.total, err);
> >  			goto out;
> >  		}
> > @@ -1865,7 +1915,8 @@ static int igt_gtt_insert(void *arg)
> > =20
> >  		GEM_BUG_ON(!drm_mm_node_allocated(&vma->node));
> >  		if (vma->node.start !=3D offset) {
> > -			pr_err("i915_gem_gtt_insert did not return node to its previous loc=
ation (the only hole), expected address %llx, found %llx\n",
> > +			gt_err(ggtt->vm.gt,
> > +			       "i915_gem_gtt_insert did not return node to its previous loc=
ation (the only hole), expected address %llx, found %llx\n",
> >  			       offset, vma->node.start);
> >  			err =3D -EINVAL;
> >  			goto out;
> > @@ -1901,7 +1952,8 @@ static int igt_gtt_insert(void *arg)
> > =20
> >  		err =3D insert_gtt_with_resource(vma);
> >  		if (err) {
> > -			pr_err("i915_gem_gtt_insert (pass 3) failed at %llu/%llu with err=
=3D%d\n",
> > +			gt_err(ggtt->vm.gt,
> > +			       "i915_gem_gtt_insert (pass 3) failed at %llu/%llu with err=
=3D%d\n",
> >  			       total, ggtt->vm.total, err);
> >  			goto out;
> >  		}
> > diff --git a/drivers/gpu/drm/i915/selftests/i915_perf.c b/drivers/gpu/d=
rm/i915/selftests/i915_perf.c
> > index e9469e27f42a..b4a75d82e6be 100644
> > --- a/drivers/gpu/drm/i915/selftests/i915_perf.c
> > +++ b/drivers/gpu/drm/i915/selftests/i915_perf.c
> > @@ -6,6 +6,8 @@
> > =20
> >  #include <linux/kref.h>
> > =20
> > +#include <drm/drm_print.h>
> > +
> >  #include "gem/i915_gem_pm.h"
> >  #include "gt/intel_gt.h"
> > =20
> > @@ -263,20 +265,22 @@ static int live_noa_delay(void *arg)
> >  	t1 =3D poll_status(rq, 0x102);
> >  	preempt_enable();
> > =20
> > -	pr_info("CPU delay: %lluns, expected %lluns\n",
> > -		ktime_sub(t1, t0), expected);
> > +	drm_info(&i915->drm,
> > +		 "CPU delay: %lluns, expected %lluns\n", ktime_sub(t1, t0),
> > +		 expected);
> > =20
> >  	delay =3D intel_read_status_page(stream->engine, 0x102);
> >  	delay -=3D intel_read_status_page(stream->engine, 0x100);
> >  	delay =3D intel_gt_clock_interval_to_ns(stream->engine->gt, delay);
> > -	pr_info("GPU delay: %uns, expected %lluns\n",
> > -		delay, expected);
> > +	drm_info(&i915->drm,
> > +		 "GPU delay: %uns, expected %lluns\n", delay, expected);
> > =20
> >  	if (4 * delay < 3 * expected || 2 * delay > 3 * expected) {
> > -		pr_err("GPU delay [%uus] outside of expected threshold! [%lluus, %ll=
uus]\n",
> > -		       delay / 1000,
> > -		       div_u64(3 * expected, 4000),
> > -		       div_u64(3 * expected, 2000));
> > +		drm_err(&i915->drm,
> > +			"GPU delay [%uus] outside of expected threshold! [%lluus, %lluus]\n=
",
> > +			delay / 1000,
> > +			div_u64(3 * expected, 4000),
> > +			div_u64(3 * expected, 2000));
> >  		err =3D -EINVAL;
> >  	}
> > =20
> > @@ -385,7 +389,7 @@ static int live_noa_gpr(void *arg)
> >  	i915_request_add(rq);
> > =20
> >  	if (i915_request_wait(rq, I915_WAIT_INTERRUPTIBLE, HZ / 2) < 0) {
> > -		pr_err("noa_wait timed out\n");
> > +		drm_err(&i915->drm, "noa_wait timed out\n");
> >  		intel_gt_set_wedged(stream->engine->gt);
> >  		err =3D -EIO;
> >  		goto out_rq;
> > @@ -396,14 +400,16 @@ static int live_noa_gpr(void *arg)
> >  		if (store[i] =3D=3D STACK_MAGIC)
> >  			continue;
> > =20
> > -		pr_err("GPR[%d] lost, found:%08x, expected:%08x!\n",
> > -		       i, store[i], STACK_MAGIC);
> > +		drm_err(&i915->drm,
> > +			"GPR[%d] lost, found:%08x, expected:%08x!\n", i,
> > +			store[i], STACK_MAGIC);
> >  		err =3D -EINVAL;
> >  	}
> > =20
> >  	/* Verify that the user's scratch page was not used for GPR storage *=
/
> >  	if (memchr_inv(scratch, POISON_FREE, PAGE_SIZE)) {
> > -		pr_err("Scratch page overwritten!\n");
> > +		drm_err(&i915->drm,
> > +			"Scratch page overwritten!\n");
> >  		igt_hexdump(scratch, 4096);
> >  		err =3D -EINVAL;
> >  	}
> > diff --git a/drivers/gpu/drm/i915/selftests/i915_request.c b/drivers/gp=
u/drm/i915/selftests/i915_request.c
> > index e1a7c454a0a9..fade3e122205 100644
> > --- a/drivers/gpu/drm/i915/selftests/i915_request.c
> > +++ b/drivers/gpu/drm/i915/selftests/i915_request.c
> > @@ -26,8 +26,6 @@
> >  #include <linux/prime_numbers.h>
> >  #include <linux/sort.h>
> > =20
> > -#include <drm/drm_print.h>
> > -
> >  #include "gem/i915_gem_internal.h"
> >  #include "gem/i915_gem_pm.h"
> >  #include "gem/selftests/mock_context.h"
> > @@ -36,6 +34,7 @@
> >  #include "gt/intel_engine_user.h"
> >  #include "gt/intel_gt.h"
> >  #include "gt/intel_gt_clock_utils.h"
> > +#include "gt/intel_gt_print.h"
> >  #include "gt/intel_gt_requests.h"
> >  #include "gt/selftest_engine_heartbeat.h"
> > =20
> > @@ -98,49 +97,54 @@ static int igt_wait_request(void *arg)
> >  	i915_request_get(request);
> > =20
> >  	if (i915_request_wait(request, 0, 0) !=3D -ETIME) {
> > -		pr_err("request wait (busy query) succeeded (expected timeout before=
 submit!)\n");
> > +		gt_err(to_gt(i915),
> > +		       "request wait (busy query) succeeded (expected timeout before=
 submit!)\n");
> >  		goto out_request;
> >  	}
> > =20
> >  	if (i915_request_wait(request, 0, T) !=3D -ETIME) {
> > -		pr_err("request wait succeeded (expected timeout before submit!)\n")=
;
> > +		gt_err(to_gt(i915),
> > +		       "request wait succeeded (expected timeout before submit!)\n")=
;
> >  		goto out_request;
> >  	}
> > =20
> >  	if (i915_request_completed(request)) {
> > -		pr_err("request completed before submit!!\n");
> > +		gt_err(to_gt(i915), "request completed before submit!!\n");
> >  		goto out_request;
> >  	}
> > =20
> >  	i915_request_add(request);
> > =20
> >  	if (i915_request_wait(request, 0, 0) !=3D -ETIME) {
> > -		pr_err("request wait (busy query) succeeded (expected timeout after =
submit!)\n");
> > +		gt_err(to_gt(i915),
> > +		       "request wait (busy query) succeeded (expected timeout after =
submit!)\n");
> >  		goto out_request;
> >  	}
> > =20
> >  	if (i915_request_completed(request)) {
> > -		pr_err("request completed immediately!\n");
> > +		gt_err(to_gt(i915), "request completed immediately!\n");
> >  		goto out_request;
> >  	}
> > =20
> >  	if (i915_request_wait(request, 0, T / 2) !=3D -ETIME) {
> > -		pr_err("request wait succeeded (expected timeout!)\n");
> > +		gt_err(to_gt(i915),
> > +		       "request wait succeeded (expected timeout!)\n");
> >  		goto out_request;
> >  	}
> > =20
> >  	if (i915_request_wait(request, 0, T) =3D=3D -ETIME) {
> > -		pr_err("request wait timed out!\n");
> > +		gt_err(to_gt(i915), "request wait timed out!\n");
> >  		goto out_request;
> >  	}
> > =20
> >  	if (!i915_request_completed(request)) {
> > -		pr_err("request not complete after waiting!\n");
> > +		gt_err(to_gt(i915), "request not complete after waiting!\n");
> >  		goto out_request;
> >  	}
> > =20
> >  	if (i915_request_wait(request, 0, T) =3D=3D -ETIME) {
> > -		pr_err("request wait timed out when already complete!\n");
> > +		gt_err(to_gt(i915),
> > +		       "request wait timed out when already complete!\n");
> >  		goto out_request;
> >  	}
> > =20
> > @@ -165,34 +169,38 @@ static int igt_fence_wait(void *arg)
> >  		return PTR_ERR(request);
> > =20
> >  	if (dma_fence_wait_timeout(&request->fence, false, T) !=3D -ETIME) {
> > -		pr_err("fence wait success before submit (expected timeout)!\n");
> > +		gt_err(to_gt(i915),
> > +		       "fence wait success before submit (expected timeout)!\n");
> >  		goto out;
> >  	}
> > =20
> >  	i915_request_add(request);
> > =20
> >  	if (dma_fence_is_signaled(&request->fence)) {
> > -		pr_err("fence signaled immediately!\n");
> > +		gt_err(to_gt(i915), "fence signaled immediately!\n");
> >  		goto out;
> >  	}
> > =20
> >  	if (dma_fence_wait_timeout(&request->fence, false, T / 2) !=3D -ETIME=
) {
> > -		pr_err("fence wait success after submit (expected timeout)!\n");
> > +		gt_err(to_gt(i915),
> > +		       "fence wait success after submit (expected timeout)!\n");
> >  		goto out;
> >  	}
> > =20
> >  	if (dma_fence_wait_timeout(&request->fence, false, T) <=3D 0) {
> > -		pr_err("fence wait timed out (expected success)!\n");
> > +		gt_err(to_gt(i915),
> > +		       "fence wait timed out (expected success)!\n");
> >  		goto out;
> >  	}
> > =20
> >  	if (!dma_fence_is_signaled(&request->fence)) {
> > -		pr_err("fence unsignaled after waiting!\n");
> > +		gt_err(to_gt(i915), "fence unsignaled after waiting!\n");
> >  		goto out;
> >  	}
> > =20
> >  	if (dma_fence_wait_timeout(&request->fence, false, T) <=3D 0) {
> > -		pr_err("fence wait timed out when complete (expected success)!\n");
> > +		gt_err(to_gt(i915),
> > +		       "fence wait timed out when complete (expected success)!\n");
> >  		goto out;
> >  	}
> > =20
> > @@ -245,7 +253,8 @@ static int igt_request_rewind(void *arg)
> > =20
> >  	/* Simulate preemption by manual reordering */
> >  	if (!mock_cancel_request(request)) {
> > -		pr_err("failed to cancel request (already executed)!\n");
> > +		gt_err(to_gt(i915),
> > +		       "failed to cancel request (already executed)!\n");
> >  		i915_request_add(vip);
> >  		goto err_context_1;
> >  	}
> > @@ -257,12 +266,13 @@ static int igt_request_rewind(void *arg)
> > =20
> > =20
> >  	if (i915_request_wait(vip, 0, HZ) =3D=3D -ETIME) {
> > -		pr_err("timed out waiting for high priority request\n");
> > +		gt_err(to_gt(i915),
> > +		       "timed out waiting for high priority request\n");
> >  		goto err;
> >  	}
> > =20
> >  	if (i915_request_completed(request)) {
> > -		pr_err("low priority request already completed\n");
> > +		gt_err(to_gt(i915), "low priority request already completed\n");
> >  		goto err;
> >  	}
> > =20
> > @@ -313,6 +323,7 @@ static void __igt_breadcrumbs_smoketest(struct kthr=
ead_work *work)
> >  	struct smoke_thread *thread =3D container_of(work, typeof(*thread), w=
ork);
> >  	struct smoketest *t =3D thread->t;
> >  	const unsigned int max_batch =3D min(t->ncontexts, t->max_batch) - 1;
> > +	struct intel_gt *gt =3D t->engine->gt;
> >  	const unsigned int total =3D 4 * t->ncontexts + 1;
> >  	unsigned int num_waits =3D 0, num_fences =3D 0;
> >  	struct i915_request **requests;
> > @@ -406,7 +417,8 @@ static void __igt_breadcrumbs_smoketest(struct kthr=
ead_work *work)
> >  					5 * HZ)) {
> >  			struct i915_request *rq =3D requests[count - 1];
> > =20
> > -			pr_err("waiting for %d/%d fences (last %llx:%lld) on %s timed out!\=
n",
> > +			gt_err(gt,
> > +			       "waiting for %d/%d fences (last %llx:%lld) on %s timed out!\=
n",
> >  			       atomic_read(&wait->pending), count,
> >  			       rq->fence.context, rq->fence.seqno,
> >  			       t->engine->name);
> > @@ -423,7 +435,8 @@ static void __igt_breadcrumbs_smoketest(struct kthr=
ead_work *work)
> > =20
> >  			if (!test_bit(DMA_FENCE_FLAG_SIGNALED_BIT,
> >  				      &rq->fence.flags)) {
> > -				pr_err("%llu:%llu was not signaled!\n",
> > +				gt_err(gt,
> > +				       "%llu:%llu was not signaled!\n",
> >  				       rq->fence.context, rq->fence.seqno);
> >  				err =3D -EINVAL;
> >  			}
> > @@ -523,7 +536,8 @@ static int mock_breadcrumbs_smoketest(void *arg)
> > =20
> >  		kthread_destroy_worker(threads[n].worker);
> >  	}
> > -	pr_info("Completed %lu waits for %lu fence across %d cpus\n",
> > +	gt_info(to_gt(i915),
> > +		"Completed %lu waits for %lu fence across %d cpus\n",
> >  		atomic_long_read(&t.num_waits),
> >  		atomic_long_read(&t.num_fences),
> >  		ncpus);
> > @@ -632,7 +646,8 @@ static int live_nop_request(void *arg)
> >  		if (err)
> >  			return err;
> > =20
> > -		pr_info("Request latencies on %s: 1 =3D %lluns, %lu =3D %lluns\n",
> > +		gt_info(engine->gt,
> > +			"Request latencies on %s: 1 =3D %lluns, %lu =3D %lluns\n",
> >  			engine->name,
> >  			ktime_to_ns(times[0]),
> >  			prime, div64_u64(ktime_to_ns(times[1]), prime));
> > @@ -663,7 +678,8 @@ static int __cancel_inactive(struct intel_engine_cs=
 *engine)
> >  		goto out_ce;
> >  	}
> > =20
> > -	pr_debug("%s: Cancelling inactive request\n", engine->name);
> > +	gt_dbg(engine->gt, "%s: Cancelling inactive request\n",
> > +	       engine->name);
> >  	i915_request_cancel(rq, -EINTR);
> >  	i915_request_get(rq);
> >  	i915_request_add(rq);
> > @@ -671,14 +687,16 @@ static int __cancel_inactive(struct intel_engine_=
cs *engine)
> >  	if (i915_request_wait(rq, 0, HZ / 5) < 0) {
> >  		struct drm_printer p =3D drm_info_printer(engine->i915->drm.dev);
> > =20
> > -		pr_err("%s: Failed to cancel inactive request\n", engine->name);
> > +		gt_err(engine->gt,
> > +		       "%s: Failed to cancel inactive request\n",
> > +		       engine->name);
> >  		intel_engine_dump(engine, &p, "%s\n", engine->name);
> >  		err =3D -ETIME;
> >  		goto out_rq;
> >  	}
> > =20
> >  	if (rq->fence.error !=3D -EINTR) {
> > -		pr_err("%s: fence not cancelled (%u)\n",
> > +		gt_err(engine->gt, "%s: fence not cancelled (%u)\n",
> >  		       engine->name, rq->fence.error);
> >  		err =3D -EINVAL;
> >  	}
> > @@ -690,7 +708,8 @@ static int __cancel_inactive(struct intel_engine_cs=
 *engine)
> >  out_spin:
> >  	igt_spinner_fini(&spin);
> >  	if (err)
> > -		pr_err("%s: %s error %d\n", __func__, engine->name, err);
> > +		gt_err(engine->gt, "%s: %s error %d\n", __func__,
> > +		       engine->name, err);
> >  	return err;
> >  }
> > =20
> > @@ -716,13 +735,15 @@ static int __cancel_active(struct intel_engine_cs=
 *engine)
> >  		goto out_ce;
> >  	}
> > =20
> > -	pr_debug("%s: Cancelling active request\n", engine->name);
> > +	gt_dbg(engine->gt, "%s: Cancelling active request\n",
> > +	       engine->name);
> >  	i915_request_get(rq);
> >  	i915_request_add(rq);
> >  	if (!igt_wait_for_spinner(&spin, rq)) {
> >  		struct drm_printer p =3D drm_info_printer(engine->i915->drm.dev);
> > =20
> > -		pr_err("Failed to start spinner on %s\n", engine->name);
> > +		gt_err(engine->gt, "Failed to start spinner on %s\n",
> > +		       engine->name);
> >  		intel_engine_dump(engine, &p, "%s\n", engine->name);
> >  		err =3D -ETIME;
> >  		goto out_rq;
> > @@ -732,14 +753,15 @@ static int __cancel_active(struct intel_engine_cs=
 *engine)
> >  	if (i915_request_wait(rq, 0, HZ / 5) < 0) {
> >  		struct drm_printer p =3D drm_info_printer(engine->i915->drm.dev);
> > =20
> > -		pr_err("%s: Failed to cancel active request\n", engine->name);
> > +		gt_err(engine->gt,
> > +		       "%s: Failed to cancel active request\n", engine->name);
> >  		intel_engine_dump(engine, &p, "%s\n", engine->name);
> >  		err =3D -ETIME;
> >  		goto out_rq;
> >  	}
> > =20
> >  	if (rq->fence.error !=3D -EINTR) {
> > -		pr_err("%s: fence not cancelled (%u)\n",
> > +		gt_err(engine->gt, "%s: fence not cancelled (%u)\n",
> >  		       engine->name, rq->fence.error);
> >  		err =3D -EINVAL;
> >  	}
> > @@ -751,7 +773,8 @@ static int __cancel_active(struct intel_engine_cs *=
engine)
> >  out_spin:
> >  	igt_spinner_fini(&spin);
> >  	if (err)
> > -		pr_err("%s: %s error %d\n", __func__, engine->name, err);
> > +		gt_err(engine->gt, "%s: %s error %d\n", __func__,
> > +		       engine->name, err);
> >  	return err;
> >  }
> > =20
> > @@ -785,10 +808,11 @@ static int __cancel_completed(struct intel_engine=
_cs *engine)
> >  		goto out_rq;
> >  	}
> > =20
> > -	pr_debug("%s: Cancelling completed request\n", engine->name);
> > +	gt_dbg(engine->gt, "%s: Cancelling completed request\n",
> > +	       engine->name);
> >  	i915_request_cancel(rq, -EINTR);
> >  	if (rq->fence.error) {
> > -		pr_err("%s: fence not cancelled (%u)\n",
> > +		gt_err(engine->gt, "%s: fence not cancelled (%u)\n",
> >  		       engine->name, rq->fence.error);
> >  		err =3D -EINVAL;
> >  	}
> > @@ -800,7 +824,8 @@ static int __cancel_completed(struct intel_engine_c=
s *engine)
> >  out_spin:
> >  	igt_spinner_fini(&spin);
> >  	if (err)
> > -		pr_err("%s: %s error %d\n", __func__, engine->name, err);
> > +		gt_err(engine->gt, "%s: %s error %d\n", __func__,
> > +		       engine->name, err);
> >  	return err;
> >  }
> > =20
> > @@ -846,14 +871,16 @@ static int __cancel_reset(struct drm_i915_private=
 *i915,
> >  		goto out_ce;
> >  	}
> > =20
> > -	pr_debug("%s: Cancelling active non-preemptable request\n",
> > -		 engine->name);
> > +	gt_dbg(engine->gt,
> > +	       "%s: Cancelling active non-preemptable request\n",
> > +	       engine->name);
> >  	i915_request_get(rq);
> >  	i915_request_add(rq);
> >  	if (!igt_wait_for_spinner(&spin, rq)) {
> >  		struct drm_printer p =3D drm_info_printer(engine->i915->drm.dev);
> > =20
> > -		pr_err("Failed to start spinner on %s\n", engine->name);
> > +		gt_err(engine->gt, "Failed to start spinner on %s\n",
> > +		       engine->name);
> >  		intel_engine_dump(engine, &p, "%s\n", engine->name);
> >  		err =3D -ETIME;
> >  		goto out_rq;
> > @@ -870,14 +897,15 @@ static int __cancel_reset(struct drm_i915_private=
 *i915,
> >  	if (i915_request_wait(rq, 0, HZ) < 0) {
> >  		struct drm_printer p =3D drm_info_printer(engine->i915->drm.dev);
> > =20
> > -		pr_err("%s: Failed to cancel hung request\n", engine->name);
> > +		gt_err(engine->gt,
> > +		       "%s: Failed to cancel hung request\n", engine->name);
> >  		intel_engine_dump(engine, &p, "%s\n", engine->name);
> >  		err =3D -ETIME;
> >  		goto out_nop;
> >  	}
> > =20
> >  	if (rq->fence.error !=3D -EINTR) {
> > -		pr_err("%s: fence not cancelled (%u)\n",
> > +		gt_err(engine->gt, "%s: fence not cancelled (%u)\n",
> >  		       engine->name, rq->fence.error);
> >  		err =3D -EINVAL;
> >  		goto out_nop;
> > @@ -886,14 +914,15 @@ static int __cancel_reset(struct drm_i915_private=
 *i915,
> >  	if (i915_request_wait(nop, 0, HZ) < 0) {
> >  		struct drm_printer p =3D drm_info_printer(engine->i915->drm.dev);
> > =20
> > -		pr_err("%s: Failed to complete nop request\n", engine->name);
> > +		gt_err(engine->gt,
> > +		       "%s: Failed to complete nop request\n", engine->name);
> >  		intel_engine_dump(engine, &p, "%s\n", engine->name);
> >  		err =3D -ETIME;
> >  		goto out_nop;
> >  	}
> > =20
> >  	if (nop->fence.error !=3D 0) {
> > -		pr_err("%s: Nop request errored (%u)\n",
> > +		gt_err(engine->gt, "%s: Nop request errored (%u)\n",
> >  		       engine->name, nop->fence.error);
> >  		err =3D -EINVAL;
> >  	}
> > @@ -909,7 +938,8 @@ static int __cancel_reset(struct drm_i915_private *=
i915,
> >  out_restore:
> >  	engine->props.preempt_timeout_ms =3D preempt_timeout_ms;
> >  	if (err)
> > -		pr_err("%s: %s error %d\n", __func__, engine->name, err);
> > +		gt_err(engine->gt, "%s: %s error %d\n", __func__,
> > +		       engine->name, err);
> >  	return err;
> >  }
> > =20
> > @@ -1102,7 +1132,8 @@ static int live_empty_request(void *arg)
> >  		if (err)
> >  			goto out_batch;
> > =20
> > -		pr_info("Batch latencies on %s: 1 =3D %lluns, %lu =3D %lluns\n",
> > +		gt_info(engine->gt,
> > +			"Batch latencies on %s: 1 =3D %lluns, %lu =3D %lluns\n",
> >  			engine->name,
> >  			ktime_to_ns(times[0]),
> >  			prime, div64_u64(ktime_to_ns(times[1]), prime));
> > @@ -1218,7 +1249,8 @@ static int live_all_engines(void *arg)
> >  		batch =3D recursive_batch(engine->gt);
> >  		if (IS_ERR(batch)) {
> >  			err =3D PTR_ERR(batch);
> > -			pr_err("%s: Unable to create batch, err=3D%d\n",
> > +			gt_err(engine->gt,
> > +			       "%s: Unable to create batch, err=3D%d\n",
> >  			       __func__, err);
> >  			goto out_free;
> >  		}
> > @@ -1227,7 +1259,8 @@ static int live_all_engines(void *arg)
> >  		request[idx] =3D intel_engine_create_kernel_request(engine);
> >  		if (IS_ERR(request[idx])) {
> >  			err =3D PTR_ERR(request[idx]);
> > -			pr_err("%s: Request allocation failed with err=3D%d\n",
> > +			gt_err(engine->gt,
> > +			       "%s: Request allocation failed with err=3D%d\n",
> >  			       __func__, err);
> >  			goto out_unlock;
> >  		}
> > @@ -1252,7 +1285,8 @@ static int live_all_engines(void *arg)
> >  	idx =3D 0;
> >  	for_each_uabi_engine(engine, i915) {
> >  		if (i915_request_completed(request[idx])) {
> > -			pr_err("%s(%s): request completed too early!\n",
> > +			gt_err(engine->gt,
> > +			       "%s(%s): request completed too early!\n",
> >  			       __func__, engine->name);
> >  			err =3D -EINVAL;
> >  			goto out_request;
> > @@ -1264,7 +1298,8 @@ static int live_all_engines(void *arg)
> >  	for_each_uabi_engine(engine, i915) {
> >  		err =3D recursive_batch_resolve(request[idx]->batch);
> >  		if (err) {
> > -			pr_err("%s: failed to resolve batch, err=3D%d\n",
> > +			gt_err(engine->gt,
> > +			       "%s: failed to resolve batch, err=3D%d\n",
> >  			       __func__, err);
> >  			goto out_request;
> >  		}
> > @@ -1280,7 +1315,8 @@ static int live_all_engines(void *arg)
> >  					    MAX_SCHEDULE_TIMEOUT);
> >  		if (timeout < 0) {
> >  			err =3D timeout;
> > -			pr_err("%s: error waiting for request on %s, err=3D%d\n",
> > +			gt_err(engine->gt,
> > +			       "%s: error waiting for request on %s, err=3D%d\n",
> >  			       __func__, engine->name, err);
> >  			goto out_request;
> >  		}
> > @@ -1348,7 +1384,8 @@ static int live_sequential_engines(void *arg)
> >  		batch =3D recursive_batch(engine->gt);
> >  		if (IS_ERR(batch)) {
> >  			err =3D PTR_ERR(batch);
> > -			pr_err("%s: Unable to create batch for %s, err=3D%d\n",
> > +			gt_err(engine->gt,
> > +			       "%s: Unable to create batch for %s, err=3D%d\n",
> >  			       __func__, engine->name, err);
> >  			goto out_free;
> >  		}
> > @@ -1357,7 +1394,8 @@ static int live_sequential_engines(void *arg)
> >  		request[idx] =3D intel_engine_create_kernel_request(engine);
> >  		if (IS_ERR(request[idx])) {
> >  			err =3D PTR_ERR(request[idx]);
> > -			pr_err("%s: Request allocation failed for %s with err=3D%d\n",
> > +			gt_err(engine->gt,
> > +			       "%s: Request allocation failed for %s with err=3D%d\n",
> >  			       __func__, engine->name, err);
> >  			goto out_unlock;
> >  		}
> > @@ -1368,7 +1406,8 @@ static int live_sequential_engines(void *arg)
> >  							   &prev->fence);
> >  			if (err) {
> >  				i915_request_add(request[idx]);
> > -				pr_err("%s: Request await failed for %s with err=3D%d\n",
> > +				gt_err(engine->gt,
> > +				       "%s: Request await failed for %s with err=3D%d\n",
> >  				       __func__, engine->name, err);
> >  				goto out_unlock;
> >  			}
> > @@ -1398,7 +1437,8 @@ static int live_sequential_engines(void *arg)
> >  		long timeout;
> > =20
> >  		if (i915_request_completed(request[idx])) {
> > -			pr_err("%s(%s): request completed too early!\n",
> > +			gt_err(engine->gt,
> > +			       "%s(%s): request completed too early!\n",
> >  			       __func__, engine->name);
> >  			err =3D -EINVAL;
> >  			goto out_request;
> > @@ -1406,7 +1446,8 @@ static int live_sequential_engines(void *arg)
> > =20
> >  		err =3D recursive_batch_resolve(request[idx]->batch);
> >  		if (err) {
> > -			pr_err("%s: failed to resolve batch, err=3D%d\n",
> > +			gt_err(engine->gt,
> > +			       "%s: failed to resolve batch, err=3D%d\n",
> >  			       __func__, err);
> >  			goto out_request;
> >  		}
> > @@ -1415,7 +1456,8 @@ static int live_sequential_engines(void *arg)
> >  					    MAX_SCHEDULE_TIMEOUT);
> >  		if (timeout < 0) {
> >  			err =3D timeout;
> > -			pr_err("%s: error waiting for request on %s, err=3D%d\n",
> > +			gt_err(engine->gt,
> > +			       "%s: error waiting for request on %s, err=3D%d\n",
> >  			       __func__, engine->name, err);
> >  			goto out_request;
> >  		}
> > @@ -1496,7 +1538,8 @@ static void __live_parallel_engine1(struct kthrea=
d_work *work)
> >  	} while (!__igt_timeout(end_time, NULL));
> >  	intel_engine_pm_put(engine);
> > =20
> > -	pr_info("%s: %lu request + sync\n", engine->name, count);
> > +	gt_info(engine->gt, "%s: %lu request + sync\n", engine->name,
> > +		count);
> >  	thread->result =3D err;
> >  }
> > =20
> > @@ -1525,7 +1568,7 @@ static void __live_parallel_engineN(struct kthrea=
d_work *work)
> >  	} while (!__igt_timeout(end_time, NULL));
> >  	intel_engine_pm_put(engine);
> > =20
> > -	pr_info("%s: %lu requests\n", engine->name, count);
> > +	gt_info(engine->gt, "%s: %lu requests\n", engine->name, count);
> >  	thread->result =3D err;
> >  }
> > =20
> > @@ -1592,7 +1635,8 @@ static void __live_parallel_spin(struct kthread_w=
ork *work)
> >  		/* Occupy this engine for the whole test */
> >  		err =3D wait_for_all(engine->i915);
> >  	} else {
> > -		pr_err("Failed to start spinner on %s\n", engine->name);
> > +		gt_err(engine->gt, "Failed to start spinner on %s\n",
> > +		       engine->name);
> >  		err =3D -EINVAL;
> >  	}
> >  	igt_spinner_end(&spin);
> > @@ -1798,8 +1842,8 @@ static int live_breadcrumbs_smoketest(void *arg)
> >  		}
> >  		/* One ring interleaved between requests from all cpus */
> >  		smoke[idx].max_batch /=3D ncpus + 1;
> > -		pr_debug("Limiting batches to %d requests on %s\n",
> > -			 smoke[idx].max_batch, engine->name);
> > +		gt_dbg(engine->gt, "Limiting batches to %d requests on %s\n",
> > +		       smoke[idx].max_batch, engine->name);
> > =20
> >  		for (n =3D 0; n < ncpus; n++) {
> >  			unsigned int i =3D idx * ncpus + n;
> > @@ -1849,7 +1893,8 @@ static int live_breadcrumbs_smoketest(void *arg)
> >  		num_fences +=3D atomic_long_read(&smoke[idx].num_fences);
> >  		idx++;
> >  	}
> > -	pr_info("Completed %lu waits for %lu fences across %d engines and %d =
cpus\n",
> > +	gt_info(engine->gt,
> > +		"Completed %lu waits for %lu fences across %d engines and %d cpus\n"=
,
> >  		num_waits, num_fences, idx, ncpus);
> > =20
> >  	ret =3D igt_live_test_end(&live) ?: ret;
> > @@ -2013,6 +2058,7 @@ static u32 hwsp_offset(const struct intel_context=
 *ce, u32 *dw)
> > =20
> >  static int measure_semaphore_response(struct intel_context *ce)
> >  {
> > +	struct intel_gt *gt =3D ce->engine->gt;
> >  	u32 *sema =3D hwsp_scratch(ce);
> >  	const u32 offset =3D hwsp_offset(ce, sema);
> >  	u32 elapsed[TF_COUNT], cycles;
> > @@ -2075,7 +2121,8 @@ static int measure_semaphore_response(struct inte=
l_context *ce)
> >  	}
> > =20
> >  	cycles =3D trifilter(elapsed);
> > -	pr_info("%s: semaphore response %d cycles, %lluns\n",
> > +	gt_info(gt,
> > +		"%s: semaphore response %d cycles, %lluns\n",
> >  		ce->engine->name, cycles >> TF_BIAS,
> >  		cycles_to_ns(ce->engine, cycles));
> > =20
> > @@ -2088,6 +2135,7 @@ static int measure_semaphore_response(struct inte=
l_context *ce)
> > =20
> >  static int measure_idle_dispatch(struct intel_context *ce)
> >  {
> > +	struct intel_gt *gt =3D ce->engine->gt;
> >  	u32 *sema =3D hwsp_scratch(ce);
> >  	const u32 offset =3D hwsp_offset(ce, sema);
> >  	u32 elapsed[TF_COUNT], cycles;
> > @@ -2146,7 +2194,8 @@ static int measure_idle_dispatch(struct intel_con=
text *ce)
> >  		elapsed[i] =3D sema[i] - elapsed[i];
> > =20
> >  	cycles =3D trifilter(elapsed);
> > -	pr_info("%s: idle dispatch latency %d cycles, %lluns\n",
> > +	gt_info(gt,
> > +		"%s: idle dispatch latency %d cycles, %lluns\n",
> >  		ce->engine->name, cycles >> TF_BIAS,
> >  		cycles_to_ns(ce->engine, cycles));
> > =20
> > @@ -2159,6 +2208,7 @@ static int measure_idle_dispatch(struct intel_con=
text *ce)
> > =20
> >  static int measure_busy_dispatch(struct intel_context *ce)
> >  {
> > +	struct intel_gt *gt =3D ce->engine->gt;
> >  	u32 *sema =3D hwsp_scratch(ce);
> >  	const u32 offset =3D hwsp_offset(ce, sema);
> >  	u32 elapsed[TF_COUNT + 1], cycles;
> > @@ -2223,7 +2273,8 @@ static int measure_busy_dispatch(struct intel_con=
text *ce)
> >  	}
> > =20
> >  	cycles =3D trifilter(elapsed);
> > -	pr_info("%s: busy dispatch latency %d cycles, %lluns\n",
> > +	gt_info(gt,
> > +		"%s: busy dispatch latency %d cycles, %lluns\n",
> >  		ce->engine->name, cycles >> TF_BIAS,
> >  		cycles_to_ns(ce->engine, cycles));
> > =20
> > @@ -2262,6 +2313,7 @@ static int plug(struct intel_engine_cs *engine, u=
32 *sema, u32 mode, int value)
> > =20
> >  static int measure_inter_request(struct intel_context *ce)
> >  {
> > +	struct intel_gt *gt =3D ce->engine->gt;
> >  	u32 *sema =3D hwsp_scratch(ce);
> >  	const u32 offset =3D hwsp_offset(ce, sema);
> >  	u32 elapsed[TF_COUNT + 1], cycles;
> > @@ -2336,7 +2388,8 @@ static int measure_inter_request(struct intel_con=
text *ce)
> >  		elapsed[i - 1] =3D sema[i + 1] - sema[i];
> > =20
> >  	cycles =3D trifilter(elapsed);
> > -	pr_info("%s: inter-request latency %d cycles, %lluns\n",
> > +	gt_info(gt,
> > +		"%s: inter-request latency %d cycles, %lluns\n",
> >  		ce->engine->name, cycles >> TF_BIAS,
> >  		cycles_to_ns(ce->engine, cycles));
> > =20
> > @@ -2353,6 +2406,7 @@ static int measure_inter_request(struct intel_con=
text *ce)
> > =20
> >  static int measure_context_switch(struct intel_context *ce)
> >  {
> > +	struct intel_gt *gt =3D ce->engine->gt;
> >  	u32 *sema =3D hwsp_scratch(ce);
> >  	const u32 offset =3D hwsp_offset(ce, sema);
> >  	struct i915_request *fence =3D NULL;
> > @@ -2431,7 +2485,8 @@ static int measure_context_switch(struct intel_co=
ntext *ce)
> >  		elapsed[i - 1] =3D sema[2 * i + 2] - sema[2 * i + 1];
> > =20
> >  	cycles =3D trifilter(elapsed);
> > -	pr_info("%s: context switch latency %d cycles, %lluns\n",
> > +	gt_info(gt,
> > +		"%s: context switch latency %d cycles, %lluns\n",
> >  		ce->engine->name, cycles >> TF_BIAS,
> >  		cycles_to_ns(ce->engine, cycles));
> > =20
> > @@ -2447,6 +2502,7 @@ static int measure_context_switch(struct intel_co=
ntext *ce)
> > =20
> >  static int measure_preemption(struct intel_context *ce)
> >  {
> > +	struct intel_gt *gt =3D ce->engine->gt;
> >  	u32 *sema =3D hwsp_scratch(ce);
> >  	const u32 offset =3D hwsp_offset(ce, sema);
> >  	u32 elapsed[TF_COUNT], cycles;
> > @@ -2534,7 +2590,8 @@ static int measure_preemption(struct intel_contex=
t *ce)
> >  		elapsed[i - 1] =3D sema[2 * i + 0] - elapsed[i - 1];
> > =20
> >  	cycles =3D trifilter(elapsed);
> > -	pr_info("%s: preemption dispatch latency %d cycles, %lluns\n",
> > +	gt_info(gt,
> > +		"%s: preemption dispatch latency %d cycles, %lluns\n",
> >  		ce->engine->name, cycles >> TF_BIAS,
> >  		cycles_to_ns(ce->engine, cycles));
> > =20
> > @@ -2542,7 +2599,8 @@ static int measure_preemption(struct intel_contex=
t *ce)
> >  		elapsed[i - 1] =3D sema[2 * i + 1] - sema[2 * i + 0];
> > =20
> >  	cycles =3D trifilter(elapsed);
> > -	pr_info("%s: preemption switch latency %d cycles, %lluns\n",
> > +	gt_info(gt,
> > +		"%s: preemption switch latency %d cycles, %lluns\n",
> >  		ce->engine->name, cycles >> TF_BIAS,
> >  		cycles_to_ns(ce->engine, cycles));
> > =20
> > @@ -2567,6 +2625,7 @@ static void signal_cb(struct dma_fence *fence, st=
ruct dma_fence_cb *cb)
> > =20
> >  static int measure_completion(struct intel_context *ce)
> >  {
> > +	struct intel_gt *gt =3D ce->engine->gt;
> >  	u32 *sema =3D hwsp_scratch(ce);
> >  	const u32 offset =3D hwsp_offset(ce, sema);
> >  	u32 elapsed[TF_COUNT], cycles;
> > @@ -2636,7 +2695,8 @@ static int measure_completion(struct intel_contex=
t *ce)
> >  	}
> > =20
> >  	cycles =3D trifilter(elapsed);
> > -	pr_info("%s: completion latency %d cycles, %lluns\n",
> > +	gt_info(gt,
> > +		"%s: completion latency %d cycles, %lluns\n",
> >  		ce->engine->name, cycles >> TF_BIAS,
> >  		cycles_to_ns(ce->engine, cycles));
> > =20
> > @@ -2929,7 +2989,8 @@ static int perf_series_engines(void *arg)
> >  				decimal =3D 0;
> >  			}
> > =20
> > -			pr_info("%s %5s: { seqno:%d, busy:%d.%02d%%, runtime:%lldms, wallti=
me:%lldms }\n",
> > +			gt_info(engine->gt,
> > +				"%s %5s: { seqno:%d, busy:%d.%02d%%, runtime:%lldms, walltime:%lld=
ms }\n",
> >  				name, p->engine->name, ce->timeline->seqno,
> >  				integer, decimal,
> >  				div_u64(p->runtime, 1000 * 1000),
> > @@ -3275,7 +3336,8 @@ static int perf_parallel_engines(void *arg)
> >  			}
> > =20
> >  			GEM_BUG_ON(engine !=3D p->engine);
> > -			pr_info("%s %5s: { count:%lu, busy:%d.%02d%%, runtime:%lldms, wallt=
ime:%lldms }\n",
> > +			gt_info(engine->gt,
> > +				"%s %5s: { count:%lu, busy:%d.%02d%%, runtime:%lldms, walltime:%ll=
dms }\n",
> >  				name, engine->name, p->count, integer, decimal,
> >  				div_u64(p->runtime, 1000 * 1000),
> >  				div_u64(ktime_to_ns(p->time), 1000 * 1000));
> > diff --git a/drivers/gpu/drm/i915/selftests/i915_vma.c b/drivers/gpu/dr=
m/i915/selftests/i915_vma.c
> > index 7c4111e60f2e..4c2744a97c55 100644
> > --- a/drivers/gpu/drm/i915/selftests/i915_vma.c
> > +++ b/drivers/gpu/drm/i915/selftests/i915_vma.c
> > @@ -28,6 +28,8 @@
> >  #include "gem/i915_gem_internal.h"
> >  #include "gem/selftests/mock_context.h"
> > =20
> > +#include "gt/intel_gt_print.h"
> > +
> >  #include "i915_scatterlist.h"
> >  #include "i915_selftest.h"
> > =20
> > @@ -38,21 +40,23 @@ static bool assert_vma(struct i915_vma *vma,
> >  		       struct drm_i915_gem_object *obj,
> >  		       struct i915_gem_context *ctx)
> >  {
> > +	struct intel_gt *gt =3D vma->vm->gt;
> >  	bool ok =3D true;
> > =20
> >  	if (vma->vm !=3D ctx->vm) {
> > -		pr_err("VMA created with wrong VM\n");
> > +		gt_err(gt, "VMA created with wrong VM\n");
> >  		ok =3D false;
> >  	}
> > =20
> >  	if (vma->size !=3D obj->base.size) {
> > -		pr_err("VMA created with wrong size, found %llu, expected %zu\n",
> > +		gt_err(gt,
> > +		       "VMA created with wrong size, found %llu, expected %zu\n",
> >  		       vma->size, obj->base.size);
> >  		ok =3D false;
> >  	}
> > =20
> >  	if (vma->gtt_view.type !=3D I915_GTT_VIEW_NORMAL) {
> > -		pr_err("VMA created with wrong type [%d]\n",
> > +		gt_err(gt, "VMA created with wrong type [%d]\n",
> >  		       vma->gtt_view.type);
> >  		ok =3D false;
> >  	}
> > @@ -74,30 +78,34 @@ checked_vma_instance(struct drm_i915_gem_object *ob=
j,
> > =20
> >  	/* Manual checks, will be reinforced by i915_vma_compare! */
> >  	if (vma->vm !=3D vm) {
> > -		pr_err("VMA's vm [%p] does not match request [%p]\n",
> > -		       vma->vm, vm);
> > +		gt_err(vm->gt,
> > +		       "VMA's vm [%p] does not match request [%p]\n", vma->vm,
> > +		       vm);
> >  		ok =3D false;
> >  	}
> > =20
> >  	if (i915_is_ggtt(vm) !=3D i915_vma_is_ggtt(vma)) {
> > -		pr_err("VMA ggtt status [%d] does not match parent [%d]\n",
> > +		gt_err(vm->gt,
> > +		       "VMA ggtt status [%d] does not match parent [%d]\n",
> >  		       i915_vma_is_ggtt(vma), i915_is_ggtt(vm));
> >  		ok =3D false;
> >  	}
> > =20
> >  	if (i915_vma_compare(vma, vm, view)) {
> > -		pr_err("i915_vma_compare failed with create parameters!\n");
> > +		gt_err(vm->gt,
> > +		       "i915_vma_compare failed with create parameters!\n");
> >  		return ERR_PTR(-EINVAL);
> >  	}
> > =20
> >  	if (i915_vma_compare(vma, vma->vm,
> >  			     i915_vma_is_ggtt(vma) ? &vma->gtt_view : NULL)) {
> > -		pr_err("i915_vma_compare failed with itself\n");
> > +		gt_err(vm->gt, "i915_vma_compare failed with itself\n");
> >  		return ERR_PTR(-EINVAL);
> >  	}
> > =20
> >  	if (!ok) {
> > -		pr_err("i915_vma_compare failed to detect the difference!\n");
> > +		gt_err(vm->gt,
> > +		       "i915_vma_compare failed to detect the difference!\n");
> >  		return ERR_PTR(-EINVAL);
> >  	}
> > =20
> > @@ -126,14 +134,16 @@ static int create_vmas(struct drm_i915_private *i=
915,
> >  					return PTR_ERR(vma);
> > =20
> >  				if (!assert_vma(vma, obj, ctx)) {
> > -					pr_err("VMA lookup/create failed\n");
> > +					gt_err(vm->gt,
> > +					       "VMA lookup/create failed\n");
> >  					return -EINVAL;
> >  				}
> > =20
> >  				if (!pinned) {
> >  					err =3D i915_vma_pin(vma, 0, 0, PIN_USER);
> >  					if (err) {
> > -						pr_err("Failed to pin VMA\n");
> > +						gt_err(vm->gt,
> > +						       "Failed to pin VMA\n");
> >  						return err;
> >  					}
> >  				} else {
> > @@ -332,8 +342,11 @@ static int igt_vma_pin1(void *arg)
> >  	for (m =3D modes; m->assert; m++) {
> >  		err =3D i915_vma_pin(vma, m->size, 0, m->flags);
> >  		if (!m->assert(vma, m, err)) {
> > -			pr_err("%s to pin single page into GGTT with mode[%d:%s]: size=3D%l=
lx flags=3D%llx, err=3D%d\n",
> > -			       m->assert =3D=3D assert_pin_valid ? "Failed" : "Unexpectedly=
 succeeded",
> > +			gt_err(ggtt->vm.gt,
> > +			       "%s to pin single page into GGTT with mode[%d:%s]: size=3D%l=
lx flags=3D%llx, err=3D%d\n",
> > +			       m->assert =3D=3D assert_pin_valid ?
> > +				       "Failed" :
> > +				       "Unexpectedly succeeded",
> >  			       (int)(m - modes), m->string, m->size, m->flags,
> >  			       err);
> >  			if (!err)
> > @@ -346,7 +359,9 @@ static int igt_vma_pin1(void *arg)
> >  			i915_vma_unpin(vma);
> >  			err =3D i915_vma_unbind_unlocked(vma);
> >  			if (err) {
> > -				pr_err("Failed to unbind single page from GGTT, err=3D%d\n", err);
> > +				gt_err(ggtt->vm.gt,
> > +				       "Failed to unbind single page from GGTT, err=3D%d\n",
> > +				       err);
> >  				goto out;
> >  			}
> >  		}
> > @@ -374,6 +389,7 @@ assert_rotated(struct drm_i915_gem_object *obj,
> >  	       const struct intel_rotation_info *r, unsigned int n,
> >  	       struct scatterlist *sg)
> >  {
> > +	struct intel_gt *gt =3D to_gt(to_i915(obj->base.dev));
> >  	unsigned int x, y;
> > =20
> >  	for (x =3D 0; x < r->plane[n].width; x++) {
> > @@ -384,7 +400,8 @@ assert_rotated(struct drm_i915_gem_object *obj,
> >  			dma_addr_t src;
> > =20
> >  			if (!sg) {
> > -				pr_err("Invalid sg table: too short at plane %d, (%d, %d)!\n",
> > +				gt_err(gt,
> > +				       "Invalid sg table: too short at plane %d, (%d, %d)!\n",
> >  				       n, x, y);
> >  				return ERR_PTR(-EINVAL);
> >  			}
> > @@ -393,14 +410,16 @@ assert_rotated(struct drm_i915_gem_object *obj,
> >  			src =3D i915_gem_object_get_dma_address(obj, src_idx);
> > =20
> >  			if (sg_dma_len(sg) !=3D PAGE_SIZE) {
> > -				pr_err("Invalid sg.length, found %d, expected %lu for rotated page=
 (%d, %d) [src index %lu]\n",
> > -				       sg_dma_len(sg), PAGE_SIZE,
> > -				       x, y, src_idx);
> > +				gt_err(gt,
> > +				       "Invalid sg.length, found %d, expected %lu for rotated page=
 (%d, %d) [src index %lu]\n",
> > +				       sg_dma_len(sg), PAGE_SIZE, x, y,
> > +				       src_idx);
> >  				return ERR_PTR(-EINVAL);
> >  			}
> > =20
> >  			if (sg_dma_address(sg) !=3D src) {
> > -				pr_err("Invalid address for rotated page (%d, %d) [src index %lu]\=
n",
> > +				gt_err(gt,
> > +				       "Invalid address for rotated page (%d, %d) [src index %lu]\=
n",
> >  				       x, y, src_idx);
> >  				return ERR_PTR(-EINVAL);
> >  			}
> > @@ -414,19 +433,22 @@ assert_rotated(struct drm_i915_gem_object *obj,
> >  			continue;
> > =20
> >  		if (!sg) {
> > -			pr_err("Invalid sg table: too short at plane %d, (%d, %d)!\n",
> > +			gt_err(gt,
> > +			       "Invalid sg table: too short at plane %d, (%d, %d)!\n",
> >  			       n, x, y);
> >  			return ERR_PTR(-EINVAL);
> >  		}
> > =20
> >  		if (sg_dma_len(sg) !=3D left) {
> > -			pr_err("Invalid sg.length, found %d, expected %u for rotated page (=
%d, %d)\n",
> > +			gt_err(gt,
> > +			       "Invalid sg.length, found %d, expected %u for rotated page (=
%d, %d)\n",
> >  			       sg_dma_len(sg), left, x, y);
> >  			return ERR_PTR(-EINVAL);
> >  		}
> > =20
> >  		if (sg_dma_address(sg) !=3D 0) {
> > -			pr_err("Invalid address, found %pad, expected 0 for remapped page (=
%d, %d)\n",
> > +			gt_err(gt,
> > +			       "Invalid address, found %pad, expected 0 for remapped page (=
%d, %d)\n",
> >  			       &sg_dma_address(sg), x, y);
> >  			return ERR_PTR(-EINVAL);
> >  		}
> > @@ -451,6 +473,7 @@ assert_remapped(struct drm_i915_gem_object *obj,
> >  		const struct intel_remapped_info *r, unsigned int n,
> >  		struct scatterlist *sg)
> >  {
> > +	struct intel_gt *gt =3D to_gt(to_i915(obj->base.dev));
> >  	unsigned int x, y;
> >  	unsigned int left =3D 0;
> >  	unsigned int offset;
> > @@ -461,7 +484,8 @@ assert_remapped(struct drm_i915_gem_object *obj,
> >  			dma_addr_t src;
> > =20
> >  			if (!sg) {
> > -				pr_err("Invalid sg table: too short at plane %d, (%d, %d)!\n",
> > +				gt_err(gt,
> > +				       "Invalid sg table: too short at plane %d, (%d, %d)!\n",
> >  				       n, x, y);
> >  				return ERR_PTR(-EINVAL);
> >  			}
> > @@ -474,14 +498,16 @@ assert_remapped(struct drm_i915_gem_object *obj,
> >  			src =3D i915_gem_object_get_dma_address(obj, src_idx);
> > =20
> >  			if (left < PAGE_SIZE || left & (PAGE_SIZE-1)) {
> > -				pr_err("Invalid sg.length, found %d, expected %lu for remapped pag=
e (%d, %d) [src index %lu]\n",
> > -				       sg_dma_len(sg), PAGE_SIZE,
> > -				       x, y, src_idx);
> > +				gt_err(gt,
> > +				       "Invalid sg.length, found %d, expected %lu for remapped pag=
e (%d, %d) [src index %lu]\n",
> > +				       sg_dma_len(sg), PAGE_SIZE, x, y,
> > +				       src_idx);
> >  				return ERR_PTR(-EINVAL);
> >  			}
> > =20
> >  			if (sg_dma_address(sg) + offset !=3D src) {
> > -				pr_err("Invalid address for remapped page (%d, %d) [src index %lu]=
\n",
> > +				gt_err(gt,
> > +				       "Invalid address for remapped page (%d, %d) [src index %lu]=
\n",
> >  				       x, y, src_idx);
> >  				return ERR_PTR(-EINVAL);
> >  			}
> > @@ -495,7 +521,8 @@ assert_remapped(struct drm_i915_gem_object *obj,
> >  		}
> > =20
> >  		if (left) {
> > -			pr_err("Unexpected sg tail with %d size for remapped page (%d, %d)\=
n",
> > +			gt_err(gt,
> > +			       "Unexpected sg tail with %d size for remapped page (%d, %d)\=
n",
> >  			       left,
> >  			       x, y);
> >  			return ERR_PTR(-EINVAL);
> > @@ -507,20 +534,23 @@ assert_remapped(struct drm_i915_gem_object *obj,
> >  			continue;
> > =20
> >  		if (!sg) {
> > -			pr_err("Invalid sg table: too short at plane %d, (%d, %d)!\n",
> > +			gt_err(gt,
> > +			       "Invalid sg table: too short at plane %d, (%d, %d)!\n",
> >  			       n, x, y);
> >  			return ERR_PTR(-EINVAL);
> >  		}
> > =20
> >  		if (sg_dma_len(sg) !=3D left) {
> > -			pr_err("Invalid sg.length, found %u, expected %u for remapped page =
(%d, %d)\n",
> > +			gt_err(gt,
> > +			       "Invalid sg.length, found %u, expected %u for remapped page =
(%d, %d)\n",
> >  			       sg_dma_len(sg), left,
> >  			       x, y);
> >  			return ERR_PTR(-EINVAL);
> >  		}
> > =20
> >  		if (sg_dma_address(sg) !=3D 0) {
> > -			pr_err("Invalid address, found %pad, expected 0 for remapped page (=
%d, %d)\n",
> > +			gt_err(gt,
> > +			       "Invalid address, found %pad, expected 0 for remapped page (=
%d, %d)\n",
> >  			       &sg_dma_address(sg),
> >  			       x, y);
> >  			return ERR_PTR(-EINVAL);
> > @@ -628,7 +658,9 @@ static int igt_vma_rotate_remap(void *arg)
> > =20
> >  					err =3D i915_vma_pin(vma, 0, 0, PIN_GLOBAL);
> >  					if (err) {
> > -						pr_err("Failed to pin VMA, err=3D%d\n", err);
> > +						gt_err(vm->gt,
> > +						       "Failed to pin VMA, err=3D%d\n",
> > +						       err);
> >  						goto out_object;
> >  					}
> > =20
> > @@ -636,36 +668,47 @@ static int igt_vma_rotate_remap(void *arg)
> > =20
> >  					if (view.type =3D=3D I915_GTT_VIEW_ROTATED &&
> >  					    vma->size !=3D expected_pages * PAGE_SIZE) {
> > -						pr_err("VMA is wrong size, expected %lu, found %llu\n",
> > -						       PAGE_SIZE * expected_pages, vma->size);
> > +						gt_err(vm->gt,
> > +						       "VMA is wrong size, expected %lu, found %llu\n",
> > +						       PAGE_SIZE *
> > +							       expected_pages,
> > +						       vma->size);
> >  						err =3D -EINVAL;
> >  						goto out_object;
> >  					}
> > =20
> >  					if (view.type =3D=3D I915_GTT_VIEW_REMAPPED &&
> >  					    vma->size > expected_pages * PAGE_SIZE) {
> > -						pr_err("VMA is wrong size, expected %lu, found %llu\n",
> > -						       PAGE_SIZE * expected_pages, vma->size);
> > +						gt_err(vm->gt,
> > +						       "VMA is wrong size, expected %lu, found %llu\n",
> > +						       PAGE_SIZE *
> > +							       expected_pages,
> > +						       vma->size);
> >  						err =3D -EINVAL;
> >  						goto out_object;
> >  					}
> > =20
> >  					if (vma->pages->nents > expected_pages) {
> > -						pr_err("sg table is wrong sizeo, expected %u, found %u nents\n",
> > -						       expected_pages, vma->pages->nents);
> > +						gt_err(vm->gt,
> > +						       "sg table is wrong sizeo, expected %u, found %u nents\n",
> > +						       expected_pages,
> > +						       vma->pages->nents);
> >  						err =3D -EINVAL;
> >  						goto out_object;
> >  					}
> > =20
> >  					if (vma->node.size < vma->size) {
> > -						pr_err("VMA binding too small, expected %llu, found %llu\n",
> > -						       vma->size, vma->node.size);
> > +						gt_err(vm->gt,
> > +						       "VMA binding too small, expected %llu, found %llu\n",
> > +						       vma->size,
> > +						       vma->node.size);
> >  						err =3D -EINVAL;
> >  						goto out_object;
> >  					}
> > =20
> >  					if (vma->pages =3D=3D obj->mm.pages) {
> > -						pr_err("VMA using unrotated object pages!\n");
> > +						gt_err(vm->gt,
> > +						       "VMA using unrotated object pages!\n");
> >  						err =3D -EINVAL;
> >  						goto out_object;
> >  					}
> > @@ -677,7 +720,8 @@ static int igt_vma_rotate_remap(void *arg)
> >  						else
> >  							sg =3D assert_remapped(obj, &view.remapped, n, sg);
> >  						if (IS_ERR(sg)) {
> > -							pr_err("Inconsistent %s VMA pages for plane %d: [(%d, %d, %d, %=
d, %d), (%d, %d, %d, %d, %d)]\n",
> > +							gt_err(vm->gt,
> > +							       "Inconsistent %s VMA pages for plane %d: [(%d, %d, %d, %=
d, %d), (%d, %d, %d, %d, %d)]\n",
> >  							       view.type =3D=3D I915_GTT_VIEW_ROTATED ?
> >  							       "rotated" : "remapped", n,
> >  							       plane_info[0].width,
> > @@ -698,7 +742,9 @@ static int igt_vma_rotate_remap(void *arg)
> >  					i915_vma_unpin(vma);
> >  					err =3D i915_vma_unbind_unlocked(vma);
> >  					if (err) {
> > -						pr_err("Unbinding returned %i\n", err);
> > +						gt_err(vm->gt,
> > +						       "Unbinding returned %i\n",
> > +						       err);
> >  						goto out_object;
> >  					}
> >  					cond_resched();
> > @@ -719,6 +765,7 @@ static bool assert_partial(struct drm_i915_gem_obje=
ct *obj,
> >  			   unsigned long offset,
> >  			   unsigned long size)
> >  {
> > +	struct intel_gt *gt =3D vma->vm->gt;
> >  	struct sgt_iter sgt;
> >  	dma_addr_t dma;
> > =20
> > @@ -726,13 +773,15 @@ static bool assert_partial(struct drm_i915_gem_ob=
ject *obj,
> >  		dma_addr_t src;
> > =20
> >  		if (!size) {
> > -			pr_err("Partial scattergather list too long\n");
> > +			gt_err(gt,
> > +			       "Partial scattergather list too long\n");
> >  			return false;
> >  		}
> > =20
> >  		src =3D i915_gem_object_get_dma_address(obj, offset);
> >  		if (src !=3D dma) {
> > -			pr_err("DMA mismatch for partial page offset %lu\n",
> > +			gt_err(gt,
> > +			       "DMA mismatch for partial page offset %lu\n",
> >  			       offset);
> >  			return false;
> >  		}
> > @@ -749,41 +798,47 @@ static bool assert_pin(struct i915_vma *vma,
> >  		       u64 size,
> >  		       const char *name)
> >  {
> > +	struct intel_gt *gt =3D vma->vm->gt;
> >  	bool ok =3D true;
> > =20
> >  	if (vma->size !=3D size) {
> > -		pr_err("(%s) VMA is wrong size, expected %llu, found %llu\n",
> > +		gt_err(gt,
> > +		       "(%s) VMA is wrong size, expected %llu, found %llu\n",
> >  		       name, size, vma->size);
> >  		ok =3D false;
> >  	}
> > =20
> >  	if (vma->node.size < vma->size) {
> > -		pr_err("(%s) VMA binding too small, expected %llu, found %llu\n",
> > +		gt_err(gt,
> > +		       "(%s) VMA binding too small, expected %llu, found %llu\n",
> >  		       name, vma->size, vma->node.size);
> >  		ok =3D false;
> >  	}
> > =20
> >  	if (view && view->type !=3D I915_GTT_VIEW_NORMAL) {
> >  		if (memcmp(&vma->gtt_view, view, sizeof(*view))) {
> > -			pr_err("(%s) VMA mismatch upon creation!\n",
> > -			       name);
> > +			gt_err(gt,
> > +			       "(%s) VMA mismatch upon creation!\n", name);
> >  			ok =3D false;
> >  		}
> > =20
> >  		if (vma->pages =3D=3D vma->obj->mm.pages) {
> > -			pr_err("(%s) VMA using original object pages!\n",
> > +			gt_err(gt,
> > +			       "(%s) VMA using original object pages!\n",
> >  			       name);
> >  			ok =3D false;
> >  		}
> >  	} else {
> >  		if (vma->gtt_view.type !=3D I915_GTT_VIEW_NORMAL) {
> > -			pr_err("Not the normal ggtt view! Found %d\n",
> > +			gt_err(gt,
> > +			       "Not the normal ggtt view! Found %d\n",
> >  			       vma->gtt_view.type);
> >  			ok =3D false;
> >  		}
> > =20
> >  		if (vma->pages !=3D vma->obj->mm.pages) {
> > -			pr_err("VMA not using object pages!\n");
> > +			gt_err(gt,
> > +			       "VMA not using object pages!\n");
> >  			ok =3D false;
> >  		}
> >  	}
> > @@ -843,14 +898,16 @@ static int igt_vma_partial(void *arg)
> >  					goto out_object;
> > =20
> >  				if (!assert_pin(vma, &view, sz*PAGE_SIZE, p->name)) {
> > -					pr_err("(%s) Inconsistent partial pinning for (offset=3D%d, size=
=3D%d)\n",
> > +					gt_err(vm->gt,
> > +					       "(%s) Inconsistent partial pinning for (offset=3D%d, size=
=3D%d)\n",
> >  					       p->name, offset, sz);
> >  					err =3D -EINVAL;
> >  					goto out_object;
> >  				}
> > =20
> >  				if (!assert_partial(obj, vma, offset, sz)) {
> > -					pr_err("(%s) Inconsistent partial pages for (offset=3D%d, size=3D=
%d)\n",
> > +					gt_err(vm->gt,
> > +					       "(%s) Inconsistent partial pages for (offset=3D%d, size=3D=
%d)\n",
> >  					       p->name, offset, sz);
> >  					err =3D -EINVAL;
> >  					goto out_object;
> > @@ -860,7 +917,9 @@ static int igt_vma_partial(void *arg)
> >  				nvma++;
> >  				err =3D i915_vma_unbind_unlocked(vma);
> >  				if (err) {
> > -					pr_err("Unbinding returned %i\n", err);
> > +					gt_err(vm->gt,
> > +					       "Unbinding returned %i\n",
> > +					       err);
> >  					goto out_object;
> >  				}
> > =20
> > @@ -872,7 +931,8 @@ static int igt_vma_partial(void *arg)
> >  		list_for_each_entry(vma, &obj->vma.list, obj_link)
> >  			count++;
> >  		if (count !=3D nvma) {
> > -			pr_err("(%s) All partial vma were not recorded on the obj->vma_list=
: found %u, expected %u\n",
> > +			gt_err(vm->gt,
> > +			       "(%s) All partial vma were not recorded on the obj->vma_list=
: found %u, expected %u\n",
> >  			       p->name, count, nvma);
> >  			err =3D -EINVAL;
> >  			goto out_object;
> > @@ -890,7 +950,8 @@ static int igt_vma_partial(void *arg)
> >  			goto out_object;
> > =20
> >  		if (!assert_pin(vma, NULL, obj->base.size, p->name)) {
> > -			pr_err("(%s) inconsistent full pin\n", p->name);
> > +			gt_err(vm->gt, "(%s) inconsistent full pin\n",
> > +			       p->name);
> >  			err =3D -EINVAL;
> >  			goto out_object;
> >  		}
> > @@ -899,7 +960,7 @@ static int igt_vma_partial(void *arg)
> > =20
> >  		err =3D i915_vma_unbind_unlocked(vma);
> >  		if (err) {
> > -			pr_err("Unbinding returned %i\n", err);
> > +			gt_err(vm->gt, "Unbinding returned %i\n", err);
> >  			goto out_object;
> >  		}
> > =20
> > @@ -907,7 +968,9 @@ static int igt_vma_partial(void *arg)
> >  		list_for_each_entry(vma, &obj->vma.list, obj_link)
> >  			count++;
> >  		if (count !=3D nvma) {
> > -			pr_err("(%s) allocated an extra full vma!\n", p->name);
> > +			gt_err(vm->gt,
> > +			       "(%s) allocated an extra full vma!\n",
> > +			       p->name);
> >  			err =3D -EINVAL;
> >  			goto out_object;
> >  		}
> > @@ -1080,8 +1143,10 @@ static int igt_vma_remapped_gtt(void *arg)
> > =20
> >  					val =3D ioread32(&map[offset / sizeof(*map)]);
> >  					if (val !=3D exp) {
> > -						pr_err("%s VMA write test failed, expected 0x%x, found 0x%x\n",
> > -						       *t =3D=3D I915_GTT_VIEW_ROTATED ? "Rotated" : "Remapped",
> > +						gt_err(to_gt(i915),
> > +						       "%s VMA write test failed, expected 0x%x, found 0x%x\n",
> > +						       *t =3D=3D I915_GTT_VIEW_ROTATED ?
> > +						       "Rotated" : "Remapped",
> >  						       exp, val);
> >  						i915_vma_unpin_iomap(vma);
> >  						err =3D -EINVAL;
> > diff --git a/drivers/gpu/drm/i915/selftests/intel_uncore.c b/drivers/gp=
u/drm/i915/selftests/intel_uncore.c
> > index 514d2200751b..7e25e98f0fb7 100644
> > --- a/drivers/gpu/drm/i915/selftests/intel_uncore.c
> > +++ b/drivers/gpu/drm/i915/selftests/intel_uncore.c
> > @@ -25,6 +25,7 @@
> >  #include "../i915_selftest.h"
> > =20
> >  #include "gt/intel_gt.h"
> > +#include "gt/intel_gt_print.h"
> > =20
> >  static int intel_fw_table_check(const struct intel_forcewake_range *ra=
nges,
> >  				unsigned int num_ranges,
> > @@ -161,6 +162,7 @@ static int live_forcewake_ops(void *arg)
> >  	const struct reg *r;
> >  	struct intel_gt *gt =3D arg;
> >  	struct intel_uncore_forcewake_domain *domain;
> > +	struct drm_i915_private *i915 =3D gt->i915;
> >  	struct intel_uncore *uncore =3D gt->uncore;
> >  	struct intel_engine_cs *engine;
> >  	enum intel_engine_id id;
> > @@ -171,8 +173,8 @@ static int live_forcewake_ops(void *arg)
> >  	GEM_BUG_ON(gt->awake);
> > =20
> >  	/* vlv/chv with their pcu behave differently wrt reads */
> > -	if (IS_VALLEYVIEW(gt->i915) || IS_CHERRYVIEW(gt->i915)) {
> > -		pr_debug("PCU fakes forcewake badly; skipping\n");
> > +	if (IS_VALLEYVIEW(i915) || IS_CHERRYVIEW(i915)) {
> > +		gt_dbg(gt, "PCU fakes forcewake badly; skipping\n");
> >  		return 0;
> >  	}
> > =20
> > @@ -189,11 +191,12 @@ static int live_forcewake_ops(void *arg)
> > =20
> >  	/* We have to pick carefully to get the exact behaviour we need */
> >  	for (r =3D registers; r->name; r++)
> > -		if (IS_GRAPHICS_VER(gt->i915, r->min_graphics_ver, r->max_graphics_v=
er))
> > +		if (IS_GRAPHICS_VER(i915, r->min_graphics_ver, r->max_graphics_ver))
> >  			break;
> >  	if (!r->name) {
> > -		pr_debug("Forcewaked register not known for %s; skipping\n",
> > -			 intel_platform_name(INTEL_INFO(gt->i915)->platform));
> > +		gt_dbg(gt,
> > +		       "Forcewaked register not known for %s; skipping\n",
> > +		       intel_platform_name(INTEL_INFO(i915)->platform));
> >  		return 0;
> >  	}
> > =20
> > @@ -225,7 +228,8 @@ static int live_forcewake_ops(void *arg)
> >  			if (!domain->wake_count)
> >  				continue;
> > =20
> > -			pr_err("fw_domain %s still active, aborting test!\n",
> > +			gt_err(gt,
> > +			       "fw_domain %s still active, aborting test!\n",
> >  			       intel_uncore_forcewake_domain_to_str(domain->id));
> >  			err =3D -EINVAL;
> >  			goto out_rpm;
> > @@ -245,14 +249,15 @@ static int live_forcewake_ops(void *arg)
> >  			err =3D wait_ack_clear(domain, FORCEWAKE_KERNEL);
> >  			preempt_enable();
> >  			if (err) {
> > -				pr_err("Failed to clear fw_domain %s\n",
> > +				gt_err(gt,
> > +				       "Failed to clear fw_domain %s\n",
> >  				       intel_uncore_forcewake_domain_to_str(domain->id));
> >  				goto out_rpm;
> >  			}
> >  		}
> > =20
> >  		if (!val) {
> > -			pr_err("%s:%s was zero while fw was held!\n",
> > +			gt_err(gt, "%s:%s was zero while fw was held!\n",
> >  			       engine->name, r->name);
> >  			err =3D -EINVAL;
> >  			goto out_rpm;
> > @@ -260,7 +265,8 @@ static int live_forcewake_ops(void *arg)
> > =20
> >  		/* We then expect the read to return 0 outside of the fw */
> >  		if (wait_for(readl(reg) =3D=3D 0, 100)) {
> > -			pr_err("%s:%s=3D%0x, fw_domains 0x%x still up after 100ms!\n",
> > +			gt_err(gt,
> > +			       "%s:%s=3D%0x, fw_domains 0x%x still up after 100ms!\n",
> >  			       engine->name, r->name, readl(reg), fw_domains);
> >  			err =3D -ETIMEDOUT;
> >  			goto out_rpm;
