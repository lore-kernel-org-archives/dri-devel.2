Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDFFC5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 13:56:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D041610E140;
	Fri, 14 Aug 2026 13:56:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UKW8LGPp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 196BA10E140
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 13:56:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 52A7C60120;
 Fri, 14 Aug 2026 13:56:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2CA1F000E9;
 Fri, 14 Aug 2026 13:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786715766;
 bh=giLQZ5Hmr157q7EH2kI6PQk9vvVjOlOsTVfSJuMXA7I=;
 h=Date:From:To:Cc:Subject;
 b=UKW8LGPpAj46kyYolC+jwU75p+aEQA4+LDclWwITo7n3yw0MFlbMePm0q7rHuKqa1
 dt3f+4KfJh0fnEklSQJIAVfeYCo2fBwwBp9Z9yefcS6PYFARUF2HhA3U3iPtmdWOIX
 rBZ3sRQE6uoGnyhY9QIMqZQk59obyXTKyBkdqWhoaLwGNSrxpE+l6nzvMlWAP5NswS
 fnOYrzhoi320rW9mAo/wjWLXrojK5WiwGKuU4I5VoOGUK1NMYhtQiXgBV5aA1sJ5UD
 40fzOOeXS83drdqr9FSZyEYtpkTG5IRRtwgtXATr+Am6IvodGKJcVh4jfiDBACBOQY
 vTRbWuqhcMO+A==
Date: Fri, 14 Aug 2026 14:56:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, Bob Zhou <bobzhou2@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Shahyan Soltani <shahyan.soltani@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
Subject: linux-next: manual merge of the drm tree with the origin tree
Message-ID: <an8ecDdmWAQIjher@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fCPR+YZ/2is26ImR"
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


--fCPR+YZ/2is26ImR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c

between commits:

  47cd31185090b ("drm/amdgpu: fix missing check in vm_flush()")
  e3a721753f60c ("drm/amdgpu: skip clearing empty freed VM list on GEM clos=
e")
  b2ff0595c31cc ("drm/amdgpu: always emit the job vm fence")
  04cc4aa3617b0 ("drm/amdgpu: fix lifetime issue of amdgpu_vm_get_task_info=
_pasid()")
  4e28aa8f7ee26 ("drm/drm_exec: avoid indirect goto")

=66rom the origin tree and commits:

  04b48274e9852 ("drm/amdgpu: keep PRT mappings off the vm_bo state lists")
  cb1e657ccac89 ("drm/amdgpu: handle GDS and SPM without a VM fence")
  54a118f1d7e18 ("drm/amdgpu: fix missing check in vm_flush()")
  90163c8f3b73a ("drm/amdgpu/gfx7: Fixup emitting SWITCH_BUFFER packets")
  66f46209fd5ea ("drm/amdgpu: Drop vm_manager PASID to VM mapping")
  b0ae60ea3f3f1 ("drm/amdgpu: Resolve VM through DRM PASID ownership")
  8ba869e852d4f ("drm/amdgpu: skip clearing empty freed VM list on GEM clos=
e")
  bc639a9eadc75 ("drm/amdgpu: always emit the job vm fence")
  9d01579f3f868 ("drm/amdgpu: fix lifetime issue of amdgpu_vm_get_task_info=
_pasid()")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 1baad7624f1f9,71050a86bcc3a..0000000000000
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@@ -766,18 -766,22 +766,22 @@@ bool amdgpu_vm_need_pipeline_sync(struc
   * @ring: ring to use for flush
   * @job:  related job
   * @need_pipe_sync: is pipe sync needed
+  * @emit_spm_needed: does the caller need to emit spm
+  * @emit_gds_needed: does the caller need to emit gds
   *
   * Emit a VM flush when it is necessary.
   */
  void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
- 		     bool need_pipe_sync)
+ 		     bool need_pipe_sync, bool *emit_spm_needed,
+ 		     bool *emit_gds_needed)
  {
  	struct amdgpu_device *adev =3D ring->adev;
  	struct amdgpu_isolation *isolation =3D &adev->isolation[ring->xcp_id];
  	unsigned vmhub =3D ring->vm_hub;
  	struct amdgpu_vmid_mgr *id_mgr =3D &adev->vm_manager.id_mgr[vmhub];
  	struct amdgpu_vmid *id =3D &id_mgr->ids[job->vmid];
- 	bool spm_update_needed =3D job->spm_update_needed;
+ 	bool spm_update_needed =3D adev->gfx.rlc.funcs->update_spm_vmid &&
+ 		job->spm_update_needed;
  	bool gds_switch_needed =3D ring->funcs->emit_gds_switch &&
  		job->gds_switch_needed;
  	bool vm_flush_needed =3D job->vm_needs_flush;
@@@ -785,6 -789,7 +789,7 @@@
  	bool pasid_mapping_needed =3D false;
  	struct dma_fence *fence =3D NULL;
  	unsigned int patch =3D 0;
+ 	bool emit_fence;
 =20
  	if (amdgpu_vmid_had_gpu_reset(adev, id)) {
  		gds_switch_needed =3D true;
@@@ -811,6 -816,17 +816,17 @@@
  		ring->funcs->emit_cleaner_shader && job->base.s_fence &&
  		&job->base.s_fence->scheduled =3D=3D isolation->spearhead;
 =20
+ 	emit_fence =3D vm_flush_needed || pasid_mapping_needed ||
+ 		cleaner_shader_needed;
+=20
+ 	*emit_spm_needed =3D spm_update_needed;
+ 	if (spm_update_needed && emit_fence)
+ 		*emit_spm_needed =3D false;
+=20
+ 	*emit_gds_needed =3D gds_switch_needed;
+ 	if (gds_switch_needed && emit_fence)
+ 		*emit_gds_needed =3D false;
+=20
  	if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
  	    !cleaner_shader_needed && !spm_update_needed)
  		return;
@@@ -845,22 -861,22 +861,22 @@@
  	if (pasid_mapping_needed)
  		amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
 =20
- 	if (spm_update_needed && adev->gfx.rlc.funcs->update_spm_vmid)
- 		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring, job->vmi=
d);
+ 	if (emit_fence) {
+ 		if (spm_update_needed)
+ 			adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring, job->vm=
id);
 =20
- 	if (ring->funcs->emit_gds_switch &&
- 	    gds_switch_needed) {
- 		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
- 					    job->gds_size, job->gws_base,
- 					    job->gws_size, job->oa_base,
- 					    job->oa_size);
+ 		if (gds_switch_needed)
+ 			amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
+ 						    job->gds_size, job->gws_base,
+ 						    job->gws_size, job->oa_base,
+ 						    job->oa_size);
+=20
+ 		amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
+ 		fence =3D &job->hw_vm_fence->base;
+ 		/* get a ref for the job */
+ 		dma_fence_get(fence);
  	}
 =20
- 	amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
- 	fence =3D &job->hw_vm_fence->base;
- 	/* get a ref for the job */
- 	dma_fence_get(fence);
-=20
  	if (vm_flush_needed) {
  		mutex_lock(&id_mgr->lock);
  		dma_fence_put(id->last_flush);
@@@ -893,7 -909,12 +909,12 @@@
 =20
  	amdgpu_ring_patch_cond_exec(ring, patch);
 =20
- 	/* the double SWITCH_BUFFER here *cannot* be skipped by COND_EXEC */
+ 	/*
+ 	 * Sync CE with ME to prevent CE from fetching the next CE IB
+ 	 * before the context switch is done. This is emitted before
+ 	 * the first IB of a job submission after a context switch.
+ 	 * The double SWITCH_BUFFER here *cannot* be skipped by COND_EXEC.
+ 	 */
  	if (ring->funcs->emit_switch_buffer) {
  		amdgpu_ring_emit_switch_buffer(ring);
  		amdgpu_ring_emit_switch_buffer(ring);
@@@ -1387,7 -1408,13 +1408,13 @@@ int amdgpu_vm_bo_update(struct amdgpu_d
  			amdgpu_vm_bo_evicted(&bo_va->base);
  		else
  			amdgpu_vm_bo_idle(&bo_va->base);
- 	} else {
+ 	} else if (bo) {
+ 		/*
+ 		 * A PRT/sparse mapping has no BO and is kept off the vm_bo
+ 		 * state lists (see amdgpu_vm_bo_base_init()); putting it on the
+ 		 * idle list here would let amdgpu_vm_handle_moved() dereference
+ 		 * the NULL bo after a reset.
+ 		 */
  		amdgpu_vm_bo_idle(&bo_va->base);
  	}
 =20
@@@ -2507,14 -2534,16 +2534,16 @@@ amdgpu_vm_get_task_info_vm(struct amdgp
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
@@@ -2555,7 -2584,6 +2584,6 @@@ void amdgpu_vm_set_task_info(struct amd
   * @adev: amdgpu_device pointer
   * @vm: requested vm
   * @xcp_id: GPU partition selection id
-  * @pasid: the pasid the VM is using on this GPU
   *
   * Init @vm fields.
   *
@@@ -2563,7 -2591,7 +2591,7 @@@
   * 0 for success, error for failure.
   */
  int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
- 		   int32_t xcp_id, uint32_t pasid)
+ 		   int32_t xcp_id)
  {
  	struct amdgpu_bo *root_bo;
  	struct amdgpu_bo_vm *root;
@@@ -2638,26 -2666,12 +2666,12 @@@
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
@@@ -2764,11 -2778,6 +2778,6 @@@ void amdgpu_vm_fini(struct amdgpu_devic
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
@@@ -2864,8 -2873,6 +2873,6 @@@ void amdgpu_vm_manager_init(struct amdg
  #else
  	adev->vm_manager.vm_update_mode =3D 0;
  #endif
-=20
- 	xa_init_flags(&adev->vm_manager.pasids, XA_FLAGS_LOCK_IRQ);
  }
 =20
  /**
@@@ -2877,9 -2884,6 +2884,6 @@@
   */
  void amdgpu_vm_manager_fini(struct amdgpu_device *adev)
  {
- 	WARN_ON(!xa_empty(&adev->vm_manager.pasids));
- 	xa_destroy(&adev->vm_manager.pasids);
-=20
  	amdgpu_vmid_mgr_fini(adev);
  	amdgpu_pasid_mgr_cleanup();
  }
@@@ -2936,14 -2940,16 +2940,16 @@@ struct amdgpu_vm *amdgpu_vm_lock_by_pas
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
@@@ -2955,11 -2961,17 +2961,17 @@@
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
@@@ -3011,8 -3023,6 +3023,8 @@@ bool amdgpu_vm_handle_fault(struct amdg
  	is_compute_context =3D vm->is_compute_context;
 =20
  	if (is_compute_context) {
 +		__label__ drm_exec_retry;
 +
  		/* Release the root PD lock since svm_range_restore_pages
  		 * might try to take it.
  		 * TODO: rework svm_range_restore_pages so that this isn't
@@@ -3158,12 -3168,14 +3170,14 @@@ void amdgpu_vm_update_fault_cache(struc
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
@@@ -3196,7 -3208,7 +3210,7 @@@
  			WARN_ONCE(1, "Invalid vmhub %u\n", vmhub);
  		}
  	}
- 	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
+ 	amdgpu_pasid_unlock(flags);
  }
 =20
  void amdgpu_vm_print_task_info(struct amdgpu_device *adev,

--fCPR+YZ/2is26ImR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmp/Hm8ACgkQJNaLcl1U
h9C0UAf9GP++N8zlruGjOfx8HZUMdI/U//dbOzXYWLp14K+UgGRzgV7A2KEXbo0Q
54/CNktoUkZq3ZyKP9VTGUaxEONaIcIE4GMrA011y/LgOGIcwfIXtmNGmq1+XKhJ
xD1BfFE5pcT3watM9ARXkGAaR9idkJCPXx0kH1CzEFrIaSj28PRLDIbe3Lv0bGz0
E2Ja9sL1BdR5/u6LK6w2frBzAL+KJLh3Ak2ttUYAA35dF6ugSSDNkjkw6CKWhq1t
lVe/rpQIbvrlWZzc0ccJCr4nkeLx6snWryefkqTex87cmM6NRhISMwGLrGiJQMWV
vdyvzmPdv3O464NWf8wNaUyaTREYIA==
=ZcBB
-----END PGP SIGNATURE-----

--fCPR+YZ/2is26ImR--
