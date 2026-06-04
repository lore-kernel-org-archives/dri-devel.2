Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFB0CD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 14:13:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F36111A119;
	Thu,  4 Jun 2026 14:13:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IzX17ULl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B909C11A117
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 14:13:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 920F7402DB;
 Thu,  4 Jun 2026 14:13:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C2A1F00893;
 Thu,  4 Jun 2026 14:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780582397;
 bh=3g2tiGknBI66XipoyGXOtNUjxfoagpUoLUFskwNxSo0=;
 h=Date:From:To:Cc:Subject;
 b=IzX17ULlyiHmLd5gayAv3axFi2P3QqEink6naoeZvY6H0Mdb+8L1RcEknqS1rnJBS
 xL1Lpfu5RP7unbS9P2hpKg2LewnKWIgMuRtJWgEg4rGC1lh6XZTZLiwk522d5GRMP5
 LnLFJKkOCV58qke9XtHr+VSIluLcRYxqzY14tP0YwDzVYlmfN0xs5NdA+gqyr7l0uG
 Mlb/t/0+vnIDXEAb+0jIxDQ3x6Eg/iDsNIe2yOzHNZ0oN8WDAavbRuNPx4P8cp4p/W
 KVuGDkPzY6z5/+NIH/fgqw8yJHNIzW1hbMiuYmb/0578WLeD3itkVXZcsVAQ8UmGGR
 SGb4oY7nQjy2w==
Date: Thu, 4 Jun 2026 15:13:13 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the drm tree with the origin tree
Message-ID: <aiGH-Rhg1Wr-SlAV@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="G18XfyBjh4ev2/1l"
Content-Disposition: inline
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


--G18XfyBjh4ev2/1l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c

between commit:

  1c824497d8acd ("drm/amdgpu: fix calling VM invalidation in amdgpu_hmm_inv=
alidate_gfx")

=66rom the origin tree and commit:

  b6444d1bcbc34 ("drm/amdgpu: fix calling VM invalidation in amdgpu_hmm_inv=
alidate_gfx")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 381901bc539fd,7d51880b48608..0000000000000
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@@ -138,6 -138,47 +138,47 @@@ static void amdgpu_vm_assert_locked(str
  	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
  }
 =20
+ /* Initialize the amdgpu_vm_bo_status object */
+ static void amdgpu_vm_bo_status_init(struct amdgpu_vm_bo_status *lists)
+ {
+ 	INIT_LIST_HEAD(&lists->evicted);
+ 	INIT_LIST_HEAD(&lists->moved);
+ 	INIT_LIST_HEAD(&lists->idle);
+ }
+=20
+ /*
+  * Make sure we have the lock to modify the vm_bo status and return the o=
bject
+  * with the status lists.
+  */
+ static struct amdgpu_vm_bo_status *
+ amdgpu_vm_bo_lock_lists(struct amdgpu_vm_bo_base *vm_bo)
+ {
+ 	struct amdgpu_vm *vm =3D vm_bo->vm;
+ 	struct amdgpu_bo *bo =3D vm_bo->bo;
+=20
+ 	if (amdgpu_vm_is_bo_always_valid(vm, bo)) {
+ 		/* No extra locking needed, protected by the root PD resv lock */
+ 		amdgpu_vm_assert_locked(vm);
+=20
+ 		if (bo->tbo.type =3D=3D ttm_bo_type_kernel)
+ 			return &vm->kernel;
+=20
+ 		return &vm->always_valid;
+ 	}
+=20
+ 	spin_lock(&vm_bo->vm->individual_lock);
+ 	return &vm->individual;
+ }
+=20
+ /* Eventually unlock the status list lock again */
+ static void amdgpu_vm_bo_unlock_lists(struct amdgpu_vm_bo_base *vm_bo)
+ {
+ 	if (amdgpu_vm_is_bo_always_valid(vm_bo->vm, vm_bo->bo))
+ 		amdgpu_vm_assert_locked(vm_bo->vm);
+ 	else
+ 		spin_unlock(&vm_bo->vm->individual_lock);
+ }
+=20
  /**
   * amdgpu_vm_is_bo_always_valid - check if the BO is VM always valid
   *
@@@ -157,37 -198,44 +198,44 @@@ bool amdgpu_vm_is_bo_always_valid(struc
   *
   * @vm_bo: vm_bo which is evicted
   *
-  * State for PDs/PTs and per VM BOs which are not at the location they sh=
ould
-  * be.
+  * State for vm_bo objects meaning the underlying BO was evicted and need=
 to
+  * move in place again.
   */
  static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
  {
- 	struct amdgpu_vm *vm =3D vm_bo->vm;
- 	struct amdgpu_bo *bo =3D vm_bo->bo;
+ 	struct amdgpu_vm_bo_status *lists;
 =20
+ 	lists =3D amdgpu_vm_bo_lock_lists(vm_bo);
  	vm_bo->moved =3D true;
- 	amdgpu_vm_assert_locked(vm);
- 	spin_lock(&vm_bo->vm->status_lock);
- 	if (bo->tbo.type =3D=3D ttm_bo_type_kernel)
- 		list_move(&vm_bo->vm_status, &vm->evicted);
- 	else
- 		list_move_tail(&vm_bo->vm_status, &vm->evicted);
- 	spin_unlock(&vm_bo->vm->status_lock);
+ 	list_move(&vm_bo->vm_status, &lists->evicted);
+ 	amdgpu_vm_bo_unlock_lists(vm_bo);
  }
  /**
   * amdgpu_vm_bo_moved - vm_bo is moved
   *
   * @vm_bo: vm_bo which is moved
   *
-  * State for per VM BOs which are moved, but that change is not yet refle=
cted
-  * in the page tables.
+  * State for vm_bo objects meaning the underlying BO was moved but the new
+  * location not yet reflected in the page tables.
   */
  static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
  {
- 	amdgpu_vm_assert_locked(vm_bo->vm);
- 	spin_lock(&vm_bo->vm->status_lock);
- 	list_move(&vm_bo->vm_status, &vm_bo->vm->moved);
- 	spin_unlock(&vm_bo->vm->status_lock);
+ 	struct amdgpu_vm_bo_status *lists;
+ 	struct amdgpu_bo *bo =3D vm_bo->bo;
+=20
+ 	/*
+ 	 * The root PD doesn't have a parent PDE and goes directly into the
+ 	 * idle state.
+ 	 */
+ 	lists =3D amdgpu_vm_bo_lock_lists(vm_bo);
+ 	if (bo && bo->tbo.type =3D=3D ttm_bo_type_kernel && !bo->parent) {
+ 		vm_bo->moved =3D false;
+ 		list_move(&vm_bo->vm_status, &lists->idle);
+ 	} else {
+ 		vm_bo->moved =3D true;
+ 		list_move(&vm_bo->vm_status, &lists->moved);
+ 	}
+ 	amdgpu_vm_bo_unlock_lists(vm_bo);
  }
 =20
  /**
@@@ -195,120 -243,54 +243,54 @@@
   *
   * @vm_bo: vm_bo which is now idle
   *
-  * State for PDs/PTs and per VM BOs which have gone through the state mac=
hine
-  * and are now idle.
+  * State for vm_bo objects meaning we are done with the state machine and=
 no
+  * further action is necessary.
   */
  static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
  {
- 	amdgpu_vm_assert_locked(vm_bo->vm);
- 	spin_lock(&vm_bo->vm->status_lock);
- 	list_move(&vm_bo->vm_status, &vm_bo->vm->idle);
- 	spin_unlock(&vm_bo->vm->status_lock);
- 	vm_bo->moved =3D false;
- }
+ 	struct amdgpu_vm_bo_status *lists;
 =20
- /**
-  * amdgpu_vm_bo_invalidated - vm_bo is invalidated
-  *
-  * @vm_bo: vm_bo which is now invalidated
-  *
-  * State for normal BOs which are invalidated and that change not yet ref=
lected
-  * in the PTs.
-  */
- static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
- {
- 	spin_lock(&vm_bo->vm->status_lock);
- 	list_move(&vm_bo->vm_status, &vm_bo->vm->invalidated);
- 	spin_unlock(&vm_bo->vm->status_lock);
- }
-=20
- /**
-  * amdgpu_vm_bo_evicted_user - vm_bo is evicted
-  *
-  * @vm_bo: vm_bo which is evicted
-  *
-  * State for BOs used by user mode queues which are not at the location t=
hey
-  * should be.
-  */
- static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)
- {
- 	vm_bo->moved =3D true;
- 	spin_lock(&vm_bo->vm->status_lock);
- 	list_move(&vm_bo->vm_status, &vm_bo->vm->evicted_user);
- 	spin_unlock(&vm_bo->vm->status_lock);
- }
-=20
- /**
-  * amdgpu_vm_bo_relocated - vm_bo is reloacted
-  *
-  * @vm_bo: vm_bo which is relocated
-  *
-  * State for PDs/PTs which needs to update their parent PD.
-  * For the root PD, just move to idle state.
-  */
- static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
- {
- 	amdgpu_vm_assert_locked(vm_bo->vm);
- 	if (vm_bo->bo->parent) {
- 		spin_lock(&vm_bo->vm->status_lock);
- 		list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
- 		spin_unlock(&vm_bo->vm->status_lock);
- 	} else {
- 		amdgpu_vm_bo_idle(vm_bo);
- 	}
- }
-=20
- /**
-  * amdgpu_vm_bo_done - vm_bo is done
-  *
-  * @vm_bo: vm_bo which is now done
-  *
-  * State for normal BOs which are invalidated and that change has been up=
dated
-  * in the PTs.
-  */
- static void amdgpu_vm_bo_done(struct amdgpu_vm_bo_base *vm_bo)
- {
- 	amdgpu_vm_assert_locked(vm_bo->vm);
- 	spin_lock(&vm_bo->vm->status_lock);
- 	list_move(&vm_bo->vm_status, &vm_bo->vm->done);
- 	spin_unlock(&vm_bo->vm->status_lock);
+ 	lists =3D amdgpu_vm_bo_lock_lists(vm_bo);
+ 	if (!amdgpu_vm_is_bo_always_valid(vm_bo->vm, vm_bo->bo))
+ 		vm_bo->moved =3D false;
+ 	list_move(&vm_bo->vm_status, &lists->idle);
+ 	amdgpu_vm_bo_unlock_lists(vm_bo);
  }
 =20
  /**
   * amdgpu_vm_bo_reset_state_machine - reset the vm_bo state machine
   * @vm: the VM which state machine to reset
   *
-  * Move all vm_bo object in the VM into a state where they will be updated
-  * again during validation.
+  * Move all vm_bo object in the VM into a state where their location will=
 be
+  * updated in the page tables again.
   */
  static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
  {
  	struct amdgpu_vm_bo_base *vm_bo, *tmp;
 =20
+ 	/*
+ 	 * Don't use list splice here, we need the special handling for the root
+ 	 * PD and set the moved flag appropriately.
+ 	 */
  	amdgpu_vm_assert_locked(vm);
+ 	list_for_each_entry_safe(vm_bo, tmp, &vm->kernel.idle, vm_status)
+ 		amdgpu_vm_bo_moved(vm_bo);
+ 	list_for_each_entry_safe(vm_bo, tmp, &vm->always_valid.idle, vm_status)
+ 		amdgpu_vm_bo_moved(vm_bo);
 =20
- 	spin_lock(&vm->status_lock);
- 	list_splice_init(&vm->done, &vm->invalidated);
- 	list_for_each_entry(vm_bo, &vm->invalidated, vm_status)
+ 	spin_lock(&vm->individual_lock);
+ 	list_for_each_entry_safe(vm_bo, tmp, &vm->individual.idle, vm_status) {
  		vm_bo->moved =3D true;
-=20
- 	list_for_each_entry_safe(vm_bo, tmp, &vm->idle, vm_status) {
- 		struct amdgpu_bo *bo =3D vm_bo->bo;
-=20
- 		vm_bo->moved =3D true;
- 		if (!bo || bo->tbo.type !=3D ttm_bo_type_kernel)
- 			list_move(&vm_bo->vm_status, &vm_bo->vm->moved);
- 		else if (bo->parent)
- 			list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
+ 		list_move(&vm_bo->vm_status, &vm->individual.moved);
  	}
- 	spin_unlock(&vm->status_lock);
+ 	spin_unlock(&vm->individual_lock);
  }
 =20
  /**
   * amdgpu_vm_update_shared - helper to update shared memory stat
   * @base: base structure for tracking BO usage in a VM
   *
-  * Takes the vm status_lock and updates the shared memory stat. If the ba=
sic
+  * Takes the vm stats_lock and updates the shared memory stat. If the bas=
ic
   * stat changed (e.g. buffer was moved) amdgpu_vm_update_stats need to be=
 called
   * as well.
   */
@@@ -321,7 -303,7 +303,7 @@@ static void amdgpu_vm_update_shared(str
  	bool shared;
 =20
  	dma_resv_assert_held(bo->tbo.base.resv);
- 	spin_lock(&vm->status_lock);
+ 	spin_lock(&vm->stats_lock);
  	shared =3D drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
  	if (base->shared !=3D shared) {
  		base->shared =3D shared;
@@@ -333,7 -315,7 +315,7 @@@
  			vm->stats[bo_memtype].drm.private +=3D size;
  		}
  	}
- 	spin_unlock(&vm->status_lock);
+ 	spin_unlock(&vm->stats_lock);
  }
 =20
  /**
@@@ -358,11 -340,11 +340,11 @@@ void amdgpu_vm_bo_update_shared(struct=20
   *        be bo->tbo.resource
   * @sign: if we should add (+1) or subtract (-1) from the stat
   *
-  * Caller need to have the vm status_lock held. Useful for when multiple =
update
+  * Caller need to have the vm stats_lock held. Useful for when multiple u=
pdate
   * need to happen at the same time.
   */
  static void amdgpu_vm_update_stats_locked(struct amdgpu_vm_bo_base *base,
- 			    struct ttm_resource *res, int sign)
+ 					  struct ttm_resource *res, int sign)
  {
  	struct amdgpu_vm *vm =3D base->vm;
  	struct amdgpu_bo *bo =3D base->bo;
@@@ -386,7 -368,8 +368,8 @@@
  		 */
  		if (bo->flags & AMDGPU_GEM_CREATE_DISCARDABLE)
  			vm->stats[res_memtype].drm.purgeable +=3D size;
- 		if (!(bo->preferred_domains & amdgpu_mem_type_to_domain(res_memtype)))
+ 		if (!(bo->preferred_domains &
+ 		      amdgpu_mem_type_to_domain(res_memtype)))
  			vm->stats[bo_memtype].evicted +=3D size;
  	}
  }
@@@ -405,9 -388,9 +388,9 @@@ void amdgpu_vm_update_stats(struct amdg
  {
  	struct amdgpu_vm *vm =3D base->vm;
 =20
- 	spin_lock(&vm->status_lock);
+ 	spin_lock(&vm->stats_lock);
  	amdgpu_vm_update_stats_locked(base, res, sign);
- 	spin_unlock(&vm->status_lock);
+ 	spin_unlock(&vm->stats_lock);
  }
 =20
  /**
@@@ -428,37 -411,34 +411,34 @@@ void amdgpu_vm_bo_base_init(struct amdg
  	base->next =3D NULL;
  	INIT_LIST_HEAD(&base->vm_status);
 =20
+ 	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
  	if (!bo)
  		return;
+=20
  	base->next =3D bo->vm_bo;
  	bo->vm_bo =3D base;
 =20
- 	spin_lock(&vm->status_lock);
+ 	spin_lock(&vm->stats_lock);
  	base->shared =3D drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base=
);
  	amdgpu_vm_update_stats_locked(base, bo->tbo.resource, +1);
- 	spin_unlock(&vm->status_lock);
+ 	spin_unlock(&vm->stats_lock);
 =20
- 	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
+ 	if (!amdgpu_vm_is_bo_always_valid(vm, bo)) {
+ 		amdgpu_vm_bo_idle(base);
  		return;
-=20
- 	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
+ 	}
 =20
  	ttm_bo_set_bulk_move(&bo->tbo, &vm->lru_bulk_move);
- 	if (bo->tbo.type =3D=3D ttm_bo_type_kernel && bo->parent)
- 		amdgpu_vm_bo_relocated(base);
- 	else
- 		amdgpu_vm_bo_idle(base);
-=20
- 	if (bo->preferred_domains &
- 	    amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type))
- 		return;
 =20
  	/*
- 	 * we checked all the prerequisites, but it looks like this per vm bo
- 	 * is currently evicted. add the bo to the evicted list to make sure it
- 	 * is validated on next vm use to avoid fault.
- 	 * */
- 	amdgpu_vm_bo_evicted(base);
+ 	 * When a per VM isn't in the desired domain put it into the evicted
+ 	 * state to make sure that it gets validated on the next best occasion.
+ 	 */
+ 	if (bo->preferred_domains &
+ 	    amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type))
+ 		amdgpu_vm_bo_moved(base);
+ 	else
+ 		amdgpu_vm_bo_evicted(base);
  }
 =20
  /**
@@@ -479,41 -459,41 +459,41 @@@ int amdgpu_vm_lock_pd(struct amdgpu_vm=20
  }
 =20
  /**
-  * amdgpu_vm_lock_done_list - lock all BOs on the done list
+  * amdgpu_vm_lock_individual - lock all BOs on the individual idle list
   * @vm: vm providing the BOs
   * @exec: drm execution context
   * @num_fences: number of extra fences to reserve
   *
-  * Lock the BOs on the done list in the DRM execution context.
+  * Lock the BOs on the individual idle list in the DRM execution context.
   */
- int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm, struct drm_exec *exec,
- 			     unsigned int num_fences)
+ int amdgpu_vm_lock_individual(struct amdgpu_vm *vm, struct drm_exec *exec,
+ 			      unsigned int num_fences)
  {
- 	struct list_head *prev =3D &vm->done;
+ 	struct list_head *prev =3D &vm->individual.idle;
  	struct amdgpu_bo_va *bo_va;
  	struct amdgpu_bo *bo;
  	int ret;
 =20
  	/* We can only trust prev->next while holding the lock */
- 	spin_lock(&vm->status_lock);
- 	while (!list_is_head(prev->next, &vm->done)) {
+ 	spin_lock(&vm->individual_lock);
+ 	while (!list_is_head(prev->next, &vm->individual.idle)) {
  		bo_va =3D list_entry(prev->next, typeof(*bo_va), base.vm_status);
 =20
  		bo =3D bo_va->base.bo;
  		if (bo) {
  			amdgpu_bo_ref(bo);
- 			spin_unlock(&vm->status_lock);
+ 			spin_unlock(&vm->individual_lock);
 =20
- 			ret =3D drm_exec_prepare_obj(exec, &bo->tbo.base, 1);
+ 			ret =3D drm_exec_prepare_obj(exec, &bo->tbo.base, num_fences);
  			amdgpu_bo_unref(&bo);
  			if (unlikely(ret))
  				return ret;
 =20
- 			spin_lock(&vm->status_lock);
+ 			spin_lock(&vm->individual_lock);
  		}
  		prev =3D prev->next;
  	}
- 	spin_unlock(&vm->status_lock);
+ 	spin_unlock(&vm->individual_lock);
 =20
  	return 0;
  }
@@@ -609,10 -589,10 +589,10 @@@ int amdgpu_vm_validate(struct amdgpu_de
  		       void *param)
  {
  	uint64_t new_vm_generation =3D amdgpu_vm_generation(adev, vm);
- 	struct amdgpu_vm_bo_base *bo_base;
- 	struct amdgpu_bo *bo;
+ 	struct amdgpu_vm_bo_base *bo_base, *tmp;
  	int r;
 =20
+ 	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
  	if (vm->generation !=3D new_vm_generation) {
  		vm->generation =3D new_vm_generation;
  		amdgpu_vm_bo_reset_state_machine(vm);
@@@ -622,50 -602,60 +602,60 @@@
  			return r;
  	}
 =20
- 	spin_lock(&vm->status_lock);
- 	while (!list_empty(&vm->evicted)) {
- 		bo_base =3D list_first_entry(&vm->evicted,
- 					   struct amdgpu_vm_bo_base,
- 					   vm_status);
- 		spin_unlock(&vm->status_lock);
-=20
- 		bo =3D bo_base->bo;
-=20
- 		r =3D validate(param, bo);
+ 	list_for_each_entry_safe(bo_base, tmp, &vm->kernel.evicted, vm_status) {
+ 		r =3D validate(param, bo_base->bo);
  		if (r)
  			return r;
 =20
- 		if (bo->tbo.type !=3D ttm_bo_type_kernel) {
- 			amdgpu_vm_bo_moved(bo_base);
- 		} else {
- 			vm->update_funcs->map_table(to_amdgpu_bo_vm(bo));
- 			amdgpu_vm_bo_relocated(bo_base);
- 		}
- 		spin_lock(&vm->status_lock);
+ 		vm->update_funcs->map_table(to_amdgpu_bo_vm(bo_base->bo));
+ 		amdgpu_vm_bo_moved(bo_base);
  	}
- 	while (ticket && !list_empty(&vm->evicted_user)) {
- 		bo_base =3D list_first_entry(&vm->evicted_user,
- 					   struct amdgpu_vm_bo_base,
- 					   vm_status);
- 		spin_unlock(&vm->status_lock);
-=20
- 		bo =3D bo_base->bo;
- 		dma_resv_assert_held(bo->tbo.base.resv);
-=20
- 		r =3D validate(param, bo);
- 		if (r)
- 			return r;
-=20
- 		amdgpu_vm_bo_invalidated(bo_base);
-=20
- 		spin_lock(&vm->status_lock);
- 	}
- 	spin_unlock(&vm->status_lock);
 =20
+ 	/*
+ 	 * As soon as all page tables are in place we can start updating them
+ 	 * again.
+ 	 */
  	amdgpu_vm_eviction_lock(vm);
  	vm->evicting =3D false;
  	amdgpu_vm_eviction_unlock(vm);
 =20
+ 	list_for_each_entry_safe(bo_base, tmp, &vm->always_valid.evicted,
+ 				 vm_status) {
+ 		r =3D validate(param, bo_base->bo);
+ 		if (r)
+ 			return r;
+=20
+ 		amdgpu_vm_bo_moved(bo_base);
+ 	}
+=20
+ 	if (!ticket)
+ 		return 0;
+=20
+ 	spin_lock(&vm->individual_lock);
+ restart:
+ 	list_for_each_entry(bo_base, &vm->individual.evicted, vm_status) {
+ 		struct amdgpu_bo *bo =3D bo_base->bo;
+=20
+ 		if (dma_resv_locking_ctx(bo->tbo.base.resv) !=3D ticket)
+ 			continue;
+=20
+ 		spin_unlock(&vm->individual_lock);
+=20
+ 		r =3D validate(param, bo);
+ 		if (r)
+ 			return r;
+=20
+ 		amdgpu_vm_bo_moved(bo_base);
+=20
+ 		/* It's a bit inefficient to always jump back to the start, but
+ 		 * we would need to re-structure the KFD for properly fixing
+ 		 * that.
+ 		 */
+ 		spin_lock(&vm->individual_lock);
+ 		goto restart;
+ 	}
+ 	spin_unlock(&vm->individual_lock);
+=20
  	return 0;
  }
 =20
@@@ -689,9 -679,7 +679,7 @@@ bool amdgpu_vm_ready(struct amdgpu_vm *
  	ret =3D !vm->evicting;
  	amdgpu_vm_eviction_unlock(vm);
 =20
- 	spin_lock(&vm->status_lock);
- 	ret &=3D list_empty(&vm->evicted);
- 	spin_unlock(&vm->status_lock);
+ 	ret &=3D list_empty(&vm->kernel.evicted);
 =20
  	spin_lock(&vm->immediate.lock);
  	ret &=3D !vm->immediate.stopped;
@@@ -985,18 -973,13 +973,13 @@@ int amdgpu_vm_update_pdes(struct amdgpu
  			  struct amdgpu_vm *vm, bool immediate)
  {
  	struct amdgpu_vm_update_params params;
- 	struct amdgpu_vm_bo_base *entry;
+ 	struct amdgpu_vm_bo_base *entry, *tmp;
  	bool flush_tlb_needed =3D false;
- 	LIST_HEAD(relocated);
  	int r, idx;
 =20
  	amdgpu_vm_assert_locked(vm);
 =20
- 	spin_lock(&vm->status_lock);
- 	list_splice_init(&vm->relocated, &relocated);
- 	spin_unlock(&vm->status_lock);
-=20
- 	if (list_empty(&relocated))
+ 	if (list_empty(&vm->kernel.moved))
  		return 0;
 =20
  	if (!drm_dev_enter(adev_to_drm(adev), &idx))
@@@ -1012,7 -995,7 +995,7 @@@
  	if (r)
  		goto error;
 =20
- 	list_for_each_entry(entry, &relocated, vm_status) {
+ 	list_for_each_entry(entry, &vm->kernel.moved, vm_status) {
  		/* vm_flush_needed after updating moved PDEs */
  		flush_tlb_needed |=3D entry->moved;
 =20
@@@ -1028,11 -1011,8 +1011,8 @@@
  	if (flush_tlb_needed)
  		atomic64_inc(&vm->tlb_seq);
 =20
- 	while (!list_empty(&relocated)) {
- 		entry =3D list_first_entry(&relocated, struct amdgpu_vm_bo_base,
- 					 vm_status);
+ 	list_for_each_entry_safe(entry, tmp, &vm->kernel.moved, vm_status)
  		amdgpu_vm_bo_idle(entry);
- 	}
 =20
  error:
  	drm_dev_exit(idx);
@@@ -1163,7 -1143,7 +1143,7 @@@ int amdgpu_vm_update_range(struct amdgp
  	params.pages_addr =3D pages_addr;
  	params.unlocked =3D unlocked;
  	params.needs_flush =3D flush_tlb;
- 	params.allow_override =3D allow_override;
+ 	params.override_pte =3D allow_override && adev->gmc.override_pte;
  	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
 =20
  	amdgpu_vm_eviction_lock(vm);
@@@ -1260,9 -1240,9 +1240,9 @@@ error_free
  void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
  			  struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM])
  {
- 	spin_lock(&vm->status_lock);
+ 	spin_lock(&vm->stats_lock);
  	memcpy(stats, vm->stats, sizeof(*stats) * __AMDGPU_PL_NUM);
- 	spin_unlock(&vm->status_lock);
+ 	spin_unlock(&vm->stats_lock);
  }
 =20
  /**
@@@ -1406,7 -1386,7 +1386,7 @@@ int amdgpu_vm_bo_update(struct amdgpu_d
  		else
  			amdgpu_vm_bo_idle(&bo_va->base);
  	} else {
- 		amdgpu_vm_bo_done(&bo_va->base);
+ 		amdgpu_vm_bo_idle(&bo_va->base);
  	}
 =20
  	list_splice_init(&bo_va->invalids, &bo_va->valids);
@@@ -1629,31 -1609,27 +1609,27 @@@ int amdgpu_vm_handle_moved(struct amdgp
  			   struct amdgpu_vm *vm,
  			   struct ww_acquire_ctx *ticket)
  {
- 	struct amdgpu_bo_va *bo_va;
+ 	struct amdgpu_bo_va *bo_va, *tmp;
  	struct dma_resv *resv;
  	struct amdgpu_bo *bo;
  	bool clear, unlock;
  	int r;
 =20
- 	spin_lock(&vm->status_lock);
- 	while (!list_empty(&vm->moved)) {
- 		bo_va =3D list_first_entry(&vm->moved, struct amdgpu_bo_va,
- 					 base.vm_status);
- 		spin_unlock(&vm->status_lock);
-=20
+ 	list_for_each_entry_safe(bo_va, tmp, &vm->always_valid.moved,
+ 				 base.vm_status) {
  		/* Per VM BOs never need to bo cleared in the page tables */
  		r =3D amdgpu_vm_bo_update(adev, bo_va, false);
  		if (r)
  			return r;
- 		spin_lock(&vm->status_lock);
  	}
 =20
- 	while (!list_empty(&vm->invalidated)) {
- 		bo_va =3D list_first_entry(&vm->invalidated, struct amdgpu_bo_va,
- 					 base.vm_status);
+ 	spin_lock(&vm->individual_lock);
+ 	while (!list_empty(&vm->individual.moved)) {
+ 		bo_va =3D list_first_entry(&vm->individual.moved,
+ 					 typeof(*bo_va), base.vm_status);
  		bo =3D bo_va->base.bo;
  		resv =3D bo->tbo.base.resv;
- 		spin_unlock(&vm->status_lock);
+ 		spin_unlock(&vm->individual_lock);
 =20
  		/* Try to reserve the BO to avoid clearing its ptes */
  		if (!adev->debug_vm && !amdgpu_ttm_tt_get_usermm(bo->tbo.ttm) &&
@@@ -1684,11 -1660,11 +1660,11 @@@
  		    drm_gem_is_imported(&bo_va->base.bo->tbo.base) &&
  		    (!bo_va->base.bo->tbo.resource ||
  		     bo_va->base.bo->tbo.resource->mem_type =3D=3D TTM_PL_SYSTEM))
- 			amdgpu_vm_bo_evicted_user(&bo_va->base);
+ 			amdgpu_vm_bo_evicted(&bo_va->base);
 =20
- 		spin_lock(&vm->status_lock);
+ 		spin_lock(&vm->individual_lock);
  	}
- 	spin_unlock(&vm->status_lock);
+ 	spin_unlock(&vm->individual_lock);
 =20
  	return 0;
  }
@@@ -2226,9 -2202,9 +2202,9 @@@ void amdgpu_vm_bo_del(struct amdgpu_dev
  		}
  	}
 =20
- 	spin_lock(&vm->status_lock);
+ 	spin_lock(&vm->individual_lock);
  	list_del(&bo_va->base.vm_status);
- 	spin_unlock(&vm->status_lock);
+ 	spin_unlock(&vm->individual_lock);
 =20
  	list_for_each_entry_safe(mapping, next, &bo_va->valids, list) {
  		list_del(&mapping->list);
@@@ -2308,14 -2284,7 +2284,7 @@@ void amdgpu_vm_bo_invalidate(struct amd
 =20
  		if (bo_base->moved)
  			continue;
- 		bo_base->moved =3D true;
-=20
- 		if (bo->tbo.type =3D=3D ttm_bo_type_kernel)
- 			amdgpu_vm_bo_relocated(bo_base);
- 		else if (amdgpu_vm_is_bo_always_valid(vm, bo))
- 			amdgpu_vm_bo_moved(bo_base);
- 		else
- 			amdgpu_vm_bo_invalidated(bo_base);
+ 		amdgpu_vm_bo_moved(bo_base);
  	}
  }
 =20
@@@ -2336,10 -2305,10 +2305,10 @@@ void amdgpu_vm_bo_move(struct amdgpu_b
  	for (bo_base =3D bo->vm_bo; bo_base; bo_base =3D bo_base->next) {
  		struct amdgpu_vm *vm =3D bo_base->vm;
 =20
- 		spin_lock(&vm->status_lock);
+ 		spin_lock(&vm->stats_lock);
  		amdgpu_vm_update_stats_locked(bo_base, bo->tbo.resource, -1);
  		amdgpu_vm_update_stats_locked(bo_base, new_mem, +1);
- 		spin_unlock(&vm->status_lock);
+ 		spin_unlock(&vm->stats_lock);
  	}
 =20
  	amdgpu_vm_bo_invalidate(bo, evicted);
@@@ -2603,16 -2572,14 +2572,14 @@@ int amdgpu_vm_init(struct amdgpu_devic
  	vm->va =3D RB_ROOT_CACHED;
  	for (i =3D 0; i < AMDGPU_MAX_VMHUBS; i++)
  		vm->reserved_vmid[i] =3D NULL;
- 	INIT_LIST_HEAD(&vm->evicted);
- 	INIT_LIST_HEAD(&vm->evicted_user);
- 	INIT_LIST_HEAD(&vm->relocated);
- 	INIT_LIST_HEAD(&vm->moved);
- 	INIT_LIST_HEAD(&vm->idle);
- 	INIT_LIST_HEAD(&vm->invalidated);
- 	spin_lock_init(&vm->status_lock);
+=20
+ 	amdgpu_vm_bo_status_init(&vm->kernel);
+ 	amdgpu_vm_bo_status_init(&vm->always_valid);
+ 	spin_lock_init(&vm->individual_lock);
+ 	amdgpu_vm_bo_status_init(&vm->individual);
  	INIT_LIST_HEAD(&vm->freed);
- 	INIT_LIST_HEAD(&vm->done);
  	INIT_KFIFO(vm->faults);
+ 	spin_lock_init(&vm->stats_lock);
 =20
  	r =3D amdgpu_vm_init_entities(adev, vm);
  	if (r)
@@@ -3089,6 -3056,42 +3056,42 @@@ error_unlock
  }
 =20
  #if defined(CONFIG_DEBUG_FS)
+=20
+ /* print the debug info for a specific set of status lists */
+ static void amdgpu_debugfs_vm_bo_status_info(struct seq_file *m,
+ 					     struct amdgpu_vm_bo_status *lists)
+ {
+ 	struct amdgpu_vm_bo_base *base;
+ 	unsigned int id;
+=20
+ 	id =3D 0;
+ 	seq_puts(m, "\tEvicted BOs:\n");
+ 	list_for_each_entry(base, &lists->evicted, vm_status) {
+ 		if (!base->bo)
+ 			continue;
+=20
+ 		amdgpu_bo_print_info(id++, base->bo, m);
+ 	}
+=20
+ 	id =3D 0;
+ 	seq_puts(m, "\tMoved BOs:\n");
+ 	list_for_each_entry(base, &lists->moved, vm_status) {
+ 		if (!base->bo)
+ 			continue;
+=20
+ 		amdgpu_bo_print_info(id++, base->bo, m);
+ 	}
+=20
+ 	id =3D 0;
+ 	seq_puts(m, "\tIdle BOs:\n");
+ 	list_for_each_entry(base, &lists->moved, vm_status) {
+ 		if (!base->bo)
+ 			continue;
+=20
+ 		amdgpu_bo_print_info(id++, base->bo, m);
+ 	}
+ }
+=20
  /**
   * amdgpu_debugfs_vm_bo_info  - print BO info for the VM
   *
@@@ -3099,90 -3102,18 +3102,18 @@@
   */
  void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
  {
- 	struct amdgpu_bo_va *bo_va, *tmp;
- 	u64 total_idle =3D 0;
- 	u64 total_evicted =3D 0;
- 	u64 total_relocated =3D 0;
- 	u64 total_moved =3D 0;
- 	u64 total_invalidated =3D 0;
- 	u64 total_done =3D 0;
- 	unsigned int total_idle_objs =3D 0;
- 	unsigned int total_evicted_objs =3D 0;
- 	unsigned int total_relocated_objs =3D 0;
- 	unsigned int total_moved_objs =3D 0;
- 	unsigned int total_invalidated_objs =3D 0;
- 	unsigned int total_done_objs =3D 0;
- 	unsigned int id =3D 0;
-=20
  	amdgpu_vm_assert_locked(vm);
 =20
- 	spin_lock(&vm->status_lock);
- 	seq_puts(m, "\tIdle BOs:\n");
- 	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
- 		if (!bo_va->base.bo)
- 			continue;
- 		total_idle +=3D amdgpu_bo_print_info(id++, bo_va->base.bo, m);
- 	}
- 	total_idle_objs =3D id;
- 	id =3D 0;
+ 	seq_puts(m, "\tKernel PT/PDs:\n");
+ 	amdgpu_debugfs_vm_bo_status_info(m, &vm->kernel);
 =20
- 	seq_puts(m, "\tEvicted BOs:\n");
- 	list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status) {
- 		if (!bo_va->base.bo)
- 			continue;
- 		total_evicted +=3D amdgpu_bo_print_info(id++, bo_va->base.bo, m);
- 	}
- 	total_evicted_objs =3D id;
- 	id =3D 0;
+ 	seq_puts(m, "\tPer VM BOs:\n");
+ 	amdgpu_debugfs_vm_bo_status_info(m, &vm->always_valid);
 =20
- 	seq_puts(m, "\tRelocated BOs:\n");
- 	list_for_each_entry_safe(bo_va, tmp, &vm->relocated, base.vm_status) {
- 		if (!bo_va->base.bo)
- 			continue;
- 		total_relocated +=3D amdgpu_bo_print_info(id++, bo_va->base.bo, m);
- 	}
- 	total_relocated_objs =3D id;
- 	id =3D 0;
-=20
- 	seq_puts(m, "\tMoved BOs:\n");
- 	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
- 		if (!bo_va->base.bo)
- 			continue;
- 		total_moved +=3D amdgpu_bo_print_info(id++, bo_va->base.bo, m);
- 	}
- 	total_moved_objs =3D id;
- 	id =3D 0;
-=20
- 	seq_puts(m, "\tInvalidated BOs:\n");
- 	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
- 		if (!bo_va->base.bo)
- 			continue;
- 		total_invalidated +=3D amdgpu_bo_print_info(id++,	bo_va->base.bo, m);
- 	}
- 	total_invalidated_objs =3D id;
- 	id =3D 0;
-=20
- 	seq_puts(m, "\tDone BOs:\n");
- 	list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status) {
- 		if (!bo_va->base.bo)
- 			continue;
- 		total_done +=3D amdgpu_bo_print_info(id++, bo_va->base.bo, m);
- 	}
- 	spin_unlock(&vm->status_lock);
- 	total_done_objs =3D id;
-=20
- 	seq_printf(m, "\tTotal idle size:        %12lld\tobjs:\t%d\n", total_idl=
e,
- 		   total_idle_objs);
- 	seq_printf(m, "\tTotal evicted size:     %12lld\tobjs:\t%d\n", total_evi=
cted,
- 		   total_evicted_objs);
- 	seq_printf(m, "\tTotal relocated size:   %12lld\tobjs:\t%d\n", total_rel=
ocated,
- 		   total_relocated_objs);
- 	seq_printf(m, "\tTotal moved size:       %12lld\tobjs:\t%d\n", total_mov=
ed,
- 		   total_moved_objs);
- 	seq_printf(m, "\tTotal invalidated size: %12lld\tobjs:\t%d\n", total_inv=
alidated,
- 		   total_invalidated_objs);
- 	seq_printf(m, "\tTotal done size:        %12lld\tobjs:\t%d\n", total_don=
e,
- 		   total_done_objs);
+ 	seq_puts(m, "\tIndividual BOs:\n");
+ 	spin_lock(&vm->individual_lock);
+ 	amdgpu_debugfs_vm_bo_status_info(m, &vm->individual);
+ 	spin_unlock(&vm->individual_lock);
  }
  #endif
 =20

--G18XfyBjh4ev2/1l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmohh/gACgkQJNaLcl1U
h9DK2gf9Gd74HHlgPpqS5hVllS3laKo5362su9nOEfZ1bT9YtnNmSSHU1QGlYSiN
6ARfzUD5Bac6hbfTyu4JQ+4K0XDaV2ftl/6Qr5g3QssKFg0SdjitXnA4D0rl8m8Q
/xhyveeO9J1bfYQsI53W4gFVoVtxU4QGSPldRqyvWLrhwYupIfoNhqHS8RmS6FrA
9t2yvjAHIsv3YOahmmv+4d4Xru6pL/golloz/u/TQD3vMo/Eq2ECbh4kAA7Sd+HE
PSUYvKzVMIKtYWCytvwDuaFVIZAUruN88QisGbMKgTa9KVvrpaezIPRItZZnhWV0
nlubXbEfR+zk9EB6i4aeX4yAMUYalA==
=f4XR
-----END PGP SIGNATURE-----

--G18XfyBjh4ev2/1l--
