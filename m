Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDCDC54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 14:01:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0785A10F25B;
	Fri, 31 Jul 2026 14:01:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AhZdMp3H";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CDF710F25B
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 14:01:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7706E600AF;
 Fri, 31 Jul 2026 14:01:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CABC1F00A3A;
 Fri, 31 Jul 2026 14:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785506473;
 bh=rZSd5pV7B4MK/p367s/WQ9fhJrhOWkviG5zn8fJiikc=;
 h=Date:From:To:Cc:Subject;
 b=AhZdMp3HnNYXGU1lsaDa4Bt6OxwbbyujBAlbSd74Nj3ycD9hu8Mx5WjTRf3fC2RPW
 l/BgvJuOmODf3dtVt9C6Lq6UmHl6E7uNw/gmy62Lb5kqBf2CBv9t+QuEXRvlSc/GX2
 lSeKEWwGXtan3xAc+YCRcjtpZEjAFieBAge4FOGqOnUQc62rEXQ+NgUQQs53JmnQwV
 x+paiE1hTYkVRBIgOJC4KAEcPbUa5u2LHOeFf9Ie15Z+GJrBfYCOLid4IBiwKVKQSh
 v4N2y4SSOhACkrJsO+o0f2XT69QhQXBSQNQBvNCcdi/Um9V0EM+Z0SvSpmV42kdcx7
 vs8A0PRU/clGQ==
Date: Fri, 31 Jul 2026 15:01:09 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Shahyan Soltani <shahyan.soltani@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Subject: linux-next: manual merge of the drm tree with the origin tree
Message-ID: <amyqpXv6_drYUPPt@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PZ3a0a1mEzO6pf0R"
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


--PZ3a0a1mEzO6pf0R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c

between commit:

  04cc4aa3617b0 ("drm/amdgpu: fix lifetime issue of amdgpu_vm_get_task_info=
_pasid()")

=66rom the origin tree and commit:

  b0ae60ea3f3f1 ("drm/amdgpu: Resolve VM through DRM PASID ownership")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index dc6a9d7dd0b28,aac8ace9d7a63..0000000000000
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@@ -2506,14 -2506,16 +2506,16 @@@ amdgpu_vm_get_task_info_vm(struct amdgp
  struct amdgpu_task_info *
  amdgpu_vm_get_task_info_pasid(struct amdgpu_device *adev, u32 pasid)
  {
+ 	struct amdgpu_fpriv *fpriv;
  	struct amdgpu_task_info *ti;
  	struct amdgpu_vm *vm;
  	unsigned long flags;
 =20
- 	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
- 	vm =3D xa_load(&adev->vm_manager.pasids, pasid);
+ 	amdgpu_pasid_lock(&flags);
+ 	fpriv =3D amdgpu_pasid_get_fpriv_locked(pasid);
+ 	vm =3D fpriv ? &fpriv->vm : NULL;
  	ti =3D amdgpu_vm_get_task_info_vm(vm);
- 	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
+ 	amdgpu_pasid_unlock(flags);
 =20
  	return ti;
  }
@@@ -2554,7 -2556,6 +2556,6 @@@ void amdgpu_vm_set_task_info(struct amd
   * @adev: amdgpu_device pointer
   * @vm: requested vm
   * @xcp_id: GPU partition selection id
-  * @pasid: the pasid the VM is using on this GPU
   *
   * Init @vm fields.
   *
@@@ -2562,7 -2563,7 +2563,7 @@@
   * 0 for success, error for failure.
   */
  int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
- 		   int32_t xcp_id, uint32_t pasid)
+ 		   int32_t xcp_id)
  {
  	struct amdgpu_bo *root_bo;
  	struct amdgpu_bo_vm *root;
@@@ -2637,26 -2638,12 +2638,12 @@@
  	if (r)
  		dev_dbg(adev->dev, "Failed to create task info for VM\n");
 =20
- 	/* Store new PASID in XArray (if non-zero) */
- 	if (pasid !=3D 0) {
- 		r =3D xa_err(xa_store_irq(&adev->vm_manager.pasids, pasid, vm, GFP_KERN=
EL));
- 		if (r < 0)
- 			goto error_free_root;
-=20
- 		vm->pasid =3D pasid;
- 	}
-=20
  	amdgpu_bo_unreserve(vm->root.bo);
  	amdgpu_bo_unref(&root_bo);
 =20
  	return 0;
 =20
  error_free_root:
- 	/* If PASID was partially set, erase it from XArray before failing */
- 	if (vm->pasid !=3D 0) {
- 		xa_erase_irq(&adev->vm_manager.pasids, vm->pasid);
- 		vm->pasid =3D 0;
- 	}
  	amdgpu_vm_pt_free_root(adev, vm);
  	amdgpu_bo_unreserve(vm->root.bo);
  	amdgpu_bo_unref(&root_bo);
@@@ -2763,11 -2750,6 +2750,6 @@@ void amdgpu_vm_fini(struct amdgpu_devic
 =20
  	root =3D amdgpu_bo_ref(vm->root.bo);
  	amdgpu_bo_reserve(root, true);
- 	/* Remove PASID mapping before destroying VM */
- 	if (vm->pasid !=3D 0) {
- 		xa_erase_irq(&adev->vm_manager.pasids, vm->pasid);
- 		vm->pasid =3D 0;
- 	}
  	dma_fence_wait(vm->last_unlocked, false);
  	dma_fence_put(vm->last_unlocked);
  	dma_fence_wait(vm->last_tlb_flush, false);
@@@ -2863,8 -2845,6 +2845,6 @@@ void amdgpu_vm_manager_init(struct amdg
  #else
  	adev->vm_manager.vm_update_mode =3D 0;
  #endif
-=20
- 	xa_init_flags(&adev->vm_manager.pasids, XA_FLAGS_LOCK_IRQ);
  }
 =20
  /**
@@@ -2876,9 -2856,6 +2856,6 @@@
   */
  void amdgpu_vm_manager_fini(struct amdgpu_device *adev)
  {
- 	WARN_ON(!xa_empty(&adev->vm_manager.pasids));
- 	xa_destroy(&adev->vm_manager.pasids);
-=20
  	amdgpu_vmid_mgr_fini(adev);
  	amdgpu_pasid_mgr_cleanup();
  }
@@@ -2935,14 -2912,16 +2912,16 @@@ struct amdgpu_vm *amdgpu_vm_lock_by_pas
  					  u32 pasid, struct drm_exec *exec)
  {
  	unsigned long irqflags;
+ 	struct amdgpu_fpriv *fpriv;
  	struct amdgpu_bo *root;
  	struct amdgpu_vm *vm;
  	int r;
 =20
- 	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
- 	vm =3D xa_load(&adev->vm_manager.pasids, pasid);
- 	root =3D vm ? amdgpu_bo_ref(vm->root.bo) : NULL;
- 	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
+ 	amdgpu_pasid_lock(&irqflags);
+ 	fpriv =3D amdgpu_pasid_get_fpriv_locked(pasid);
+ 	vm =3D fpriv ? &fpriv->vm : NULL;
+ 	root =3D vm && vm->root.bo ? amdgpu_bo_ref(vm->root.bo) : NULL;
+ 	amdgpu_pasid_unlock(irqflags);
 =20
  	if (!root)
  		return NULL;
@@@ -2954,11 -2933,17 +2933,17 @@@
  	}
 =20
  	/* Double check that the VM still exists */
- 	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
- 	vm =3D xa_load(&adev->vm_manager.pasids, pasid);
- 	if (vm && vm->root.bo !=3D root)
+ 	amdgpu_pasid_lock(&irqflags);
+ 	fpriv =3D amdgpu_pasid_get_fpriv_locked(pasid);
+ 	if (!fpriv) {
  		vm =3D NULL;
- 	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
+ 	} else {
+ 		vm =3D &fpriv->vm;
+ 		if (vm->root.bo !=3D root)
+ 			vm =3D NULL;
+ 	}
+ 	amdgpu_pasid_unlock(irqflags);
+=20
  	if (!vm) {
  		drm_exec_unlock_obj(exec, &root->tbo.base);
  		amdgpu_bo_unref(&root);
@@@ -3010,8 -2995,6 +2995,8 @@@ bool amdgpu_vm_handle_fault(struct amdg
  	is_compute_context =3D vm->is_compute_context;
 =20
  	if (is_compute_context) {
 +		__label__ drm_exec_retry;
 +
  		/* Release the root PD lock since svm_range_restore_pages
  		 * might try to take it.
  		 * TODO: rework svm_range_restore_pages so that this isn't
@@@ -3157,12 -3140,14 +3142,14 @@@ void amdgpu_vm_update_fault_cache(struc
  				  uint32_t status,
  				  unsigned int vmhub)
  {
+ 	struct amdgpu_fpriv *fpriv;
  	struct amdgpu_vm *vm;
  	unsigned long flags;
 =20
- 	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
+ 	amdgpu_pasid_lock(&flags);
 =20
- 	vm =3D xa_load(&adev->vm_manager.pasids, pasid);
+ 	fpriv =3D amdgpu_pasid_get_fpriv_locked(pasid);
+ 	vm =3D fpriv ? &fpriv->vm : NULL;
  	/* Don't update the fault cache if status is 0.  In the multiple
  	 * fault case, subsequent faults will return a 0 status which is
  	 * useless for userspace and replaces the useful fault status, so
@@@ -3195,7 -3180,7 +3182,7 @@@
  			WARN_ONCE(1, "Invalid vmhub %u\n", vmhub);
  		}
  	}
- 	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
+ 	amdgpu_pasid_unlock(flags);
  }
 =20
  void amdgpu_vm_print_task_info(struct amdgpu_device *adev,

--PZ3a0a1mEzO6pf0R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpsqqQACgkQJNaLcl1U
h9DRRAf/Y7niW8oRncQvgyPrV4lSpQ0aXIaTG8u7QvNVf2LGCtnPHVuIFfIZEwK5
QiJj+UoEmaryQK2YD+QRXRpfK7l2s4FY7UqYPAMj4xDiHEYHBsx8QdynNNJ4EQah
1RJLH4bpoiqKgUtxLPwis9k+R8EIPlIdtZnYSNPyYsa85lHLXnys1LvGQMmH3BPR
wEIToagv/faLT+K7rUSymRxgph11u8JwIL78aookX8FGdC108LEPXBdzDzfLNEb6
3qRfsIL2CyMfyJ4PZT+BfFBqm5caB2ibNU0r8gMfWVX31lOOwVMAYC54Zx3bsG1X
u40IrPV9WZtaIBN9hiArE+MwcytLJw==
=f2+1
-----END PGP SIGNATURE-----

--PZ3a0a1mEzO6pf0R--
