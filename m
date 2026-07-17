Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE57C4451C
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:40:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2780910E48E;
	Fri, 17 Jul 2026 14:40:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HI7H5Wxz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4D5010F5AE
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 14:40:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ABF1B411F2;
 Fri, 17 Jul 2026 14:40:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF931F00A3A;
 Fri, 17 Jul 2026 14:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784299243;
 bh=fX5mcCwOQii+PIuiWFBtDl3puun/cghIFXP7awNGqD8=;
 h=Date:From:To:Cc:Subject;
 b=HI7H5WxzFK+QmpLWw1Niv/ky084T1EdFTJ4gRLT5JiCwxTZVCHGFkfAMJirl7VCrx
 TRMT5G+wMobPMen9c4xVmK8y0I+0drSmFVGhBe+IoRvZvWorsh8exKja/q7MFTzPPp
 VPOgu71jNEAOh0mKB0EuTQQlgDs7BFusy03iYq0bh/IrcU0EuJG45/JD/jBtRcNwLr
 2pa5lgdSxbbUkr5ApFg9xhf0BTeuhjcen7UWCaGuMZmtmnpq0iMUc1i7g3XtcGQ9i/
 dzzbg6c7kdb6V0+e+CEcVmGAsUo0KWG84maKLYkeBNOU3JTCn6JxjpgE6oV1LRlrMA
 XfrtBKwQTysHQ==
Date: Fri, 17 Jul 2026 15:40:39 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the drm tree with the drm-fixes tree
Message-ID: <alo-58eAjlzRkrjF@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lhswrDOQmoK/TBVl"
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


--lhswrDOQmoK/TBVl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c

between commits:

  614e8a989d462 ("drm/amdgpu: trigger GPU recovery when userq destroy fails=
 to unmap a hung queue")
  cee666427f280 ("drm/amdgpu/userq: fix indefinite fence wait during GPU re=
set")

=66rom the drm-fixes tree and commits:

  8396b9de4198a ("drm/amdgpu: trigger GPU recovery when userq destroy fails=
 to unmap a hung queue")
  9102b39fa924d ("drm/amdgpu/userq: fix indefinite fence wait during GPU re=
set")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 572f2949cb64e,babaabe2d891d..0000000000000
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@@ -33,6 -33,7 +33,7 @@@
  #include "amdgpu_userq.h"
  #include "amdgpu_hmm.h"
  #include "amdgpu_userq_fence.h"
+ #include "amdgpu_trace.h"
 =20
  u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
  {
@@@ -88,14 -89,7 +89,7 @@@ static void amdgpu_userq_mgr_reset_work
  		container_of(work, struct amdgpu_userq_mgr,
  			     reset_work);
  	struct amdgpu_device *adev =3D uq_mgr->adev;
- 	const int queue_types[] =3D {
- 		AMDGPU_RING_TYPE_COMPUTE,
- 		AMDGPU_RING_TYPE_GFX,
- 		AMDGPU_RING_TYPE_SDMA
- 	};
- 	const int num_queue_types =3D ARRAY_SIZE(queue_types);
- 	bool gpu_reset =3D false;
- 	int i, r;
+ 	struct amdgpu_reset_context reset_context;
 =20
  	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
  		dev_err(adev->dev, "userq reset disabled by debug mask\n");
@@@ -109,42 -103,15 +103,15 @@@
  	if (!amdgpu_gpu_recovery)
  		return;
 =20
- 	/*
- 	 * Iterate through all queue types to detect and reset problematic queues
- 	 * Process each queue type in the defined order
- 	 */
- 	for (i =3D 0; i < num_queue_types; i++) {
- 		int ring_type =3D queue_types[i];
- 		const struct amdgpu_userq_funcs *funcs =3D
- 			adev->userq_funcs[ring_type];
+ 	memset(&reset_context, 0, sizeof(reset_context));
 =20
- 		if (!amdgpu_userq_is_reset_type_supported(adev, ring_type,
- 							  AMDGPU_RESET_TYPE_PER_QUEUE))
- 				continue;
+ 	reset_context.method =3D AMD_RESET_METHOD_NONE;
+ 	reset_context.reset_req_dev =3D adev;
+ 	reset_context.src =3D AMDGPU_RESET_SRC_USERQ;
+ 	set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+ 	/*set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);*/
 =20
- 		if (atomic_read(&uq_mgr->userq_count[ring_type]) > 0 &&
- 		    funcs && funcs->detect_and_reset) {
- 			r =3D funcs->detect_and_reset(adev, ring_type);
- 			if (r) {
- 				gpu_reset =3D true;
- 				break;
- 			}
- 		}
- 	}
-=20
- 	if (gpu_reset) {
- 		struct amdgpu_reset_context reset_context;
-=20
- 		memset(&reset_context, 0, sizeof(reset_context));
-=20
- 		reset_context.method =3D AMD_RESET_METHOD_NONE;
- 		reset_context.reset_req_dev =3D adev;
- 		reset_context.src =3D AMDGPU_RESET_SRC_USERQ;
- 		set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
- 		/*set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);*/
-=20
- 		amdgpu_device_gpu_recover(adev, NULL, &reset_context);
- 	}
+ 	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
  }
 =20
  static void amdgpu_userq_hang_detect_work(struct work_struct *work)
@@@ -152,12 -119,45 +119,45 @@@
  	struct amdgpu_usermode_queue *queue =3D
  		container_of(work, struct amdgpu_usermode_queue,
  			     hang_detect_work.work);
+ 	struct amdgpu_userq_mgr *uq_mgr =3D queue->userq_mgr;
+ 	struct amdgpu_device *adev =3D uq_mgr->adev;
+ 	const struct amdgpu_userq_funcs *userq_funcs =3D
+ 		adev->userq_funcs[queue->queue_type];
+ 	bool gpu_reset =3D false;
+=20
+ 	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
+ 		dev_err(adev->dev, "userq reset disabled by debug mask\n");
+ 		return;
+ 	}
+=20
+ 	/*
+ 	 * If GPU recovery feature is disabled system-wide,
+ 	 * skip all reset detection logic
+ 	 */
+ 	if (!amdgpu_gpu_recovery)
+ 		return;
+=20
+ 	if (amdgpu_userq_is_reset_type_supported(adev, queue->queue_type,
+ 						 AMDGPU_RESET_TYPE_PER_QUEUE)) {
+ 		int r;
+=20
+ 		if (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE)
+ 			r =3D amdgpu_gfx_reset_mes_compute(adev, NULL, NULL,
+ 							 queue, NULL, NULL);
+ 		else
+ 			r =3D userq_funcs->reset(queue);
+ 		if (r)
+ 			gpu_reset =3D true;
+ 	} else {
+ 		gpu_reset =3D true;
+ 	}
 =20
  	/*
  	 * Don't schedule the work here! Scheduling or queue work from one reset
  	 * handler to another is illegal if you don't take extra precautions!
  	 */
- 	amdgpu_userq_mgr_reset_work(&queue->userq_mgr->reset_work);
+ 	if (gpu_reset)
+ 		amdgpu_userq_mgr_reset_work(&queue->userq_mgr->reset_work);
  }
 =20
  /*
@@@ -293,11 -293,15 +293,15 @@@ static int amdgpu_userq_preempt_helper(
  	int r;
 =20
  	if (queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED) {
+ 		trace_amdgpu_userq_state_start(queue);
+=20
  		r =3D userq_funcs->preempt(queue);
  		if (r) {
+ 			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
  			queue->state =3D AMDGPU_USERQ_STATE_HUNG;
  			return r;
  		} else {
+ 			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_PREEMPTED);
  			queue->state =3D AMDGPU_USERQ_STATE_PREEMPTED;
  		}
  	}
@@@ -313,10 -317,14 +317,14 @@@ static int amdgpu_userq_restore_helper(
  	int r =3D 0;
 =20
  	if (queue->state =3D=3D AMDGPU_USERQ_STATE_PREEMPTED) {
+ 		trace_amdgpu_userq_state_start(queue);
+=20
  		r =3D userq_funcs->restore(queue);
  		if (r) {
+ 			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
  			queue->state =3D AMDGPU_USERQ_STATE_HUNG;
  		} else {
+ 			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_MAPPED);
  			queue->state =3D AMDGPU_USERQ_STATE_MAPPED;
  		}
  	}
@@@ -334,12 -342,15 +342,15 @@@ static int amdgpu_userq_unmap_helper(st
 =20
  	if ((queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED) ||
  	    (queue->state =3D=3D AMDGPU_USERQ_STATE_PREEMPTED)) {
+ 		trace_amdgpu_userq_state_start(queue);
 =20
  		r =3D userq_funcs->unmap(queue);
  		if (r) {
+ 			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
  			queue->state =3D AMDGPU_USERQ_STATE_HUNG;
  			return r;
  		} else {
+ 			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_UNMAPPED);
  			queue->state =3D AMDGPU_USERQ_STATE_UNMAPPED;
  		}
  	}
@@@ -356,11 -367,15 +367,15 @@@ static int amdgpu_userq_map_helper(stru
  	int r;
 =20
  	if (queue->state =3D=3D AMDGPU_USERQ_STATE_UNMAPPED) {
+ 		trace_amdgpu_userq_state_start(queue);
+=20
  		r =3D userq_funcs->map(queue);
  		if (r) {
+ 			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
  			queue->state =3D AMDGPU_USERQ_STATE_HUNG;
  			return r;
  		} else {
+ 			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_MAPPED);
  			queue->state =3D AMDGPU_USERQ_STATE_MAPPED;
  		}
  	}
@@@ -507,6 -522,8 +522,8 @@@ amdgpu_userq_destroy(struct amdgpu_user
  	const struct amdgpu_userq_funcs *uq_funcs =3D adev->userq_funcs[queue->q=
ueue_type];
  	int r =3D 0;
 =20
+ 	trace_amdgpu_userq_destroy_start(queue);
+=20
  	cancel_delayed_work_sync(&uq_mgr->resume_work);
 =20
  	/* Cancel any pending hang detection work and cleanup */
@@@ -541,6 -558,7 +558,7 @@@
  	amdgpu_bo_unreserve(queue->db_obj.obj);
  	amdgpu_bo_unref(&queue->db_obj.obj);
 =20
+ 	trace_amdgpu_userq_destroy_end(queue, r);
  	kfree(queue);
 =20
  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@@ -638,6 -656,8 +656,8 @@@ amdgpu_userq_create(struct drm_file *fi
  	queue->queue_type =3D args->in.ip_type;
  	queue->vm =3D &fpriv->vm;
  	queue->priority =3D priority;
+ 	queue->xcp_id =3D (fpriv->xcp_id !=3D AMDGPU_XCP_NO_PARTITION) ?
+ 				fpriv->xcp_id : 0;
  	queue->userq_mgr =3D uq_mgr;
  	INIT_DELAYED_WORK(&queue->hang_detect_work,
  			  amdgpu_userq_hang_detect_work);
@@@ -680,6 -700,8 +700,8 @@@
  	}
 =20
  	queue->doorbell_index =3D index;
+ 	queue->doorbell_offset =3D (u32)args->in.doorbell_offset;
+ 	trace_amdgpu_userq_create_start(queue);
  	r =3D uq_funcs->mqd_create(queue, &args->in);
  	if (r) {
  		drm_file_err(uq_mgr->file, "Failed to create Queue\n");
@@@ -703,6 -725,7 +725,7 @@@
  		r =3D amdgpu_userq_map_helper(queue);
  		if (r) {
  			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
+ 			trace_amdgpu_userq_create_end(queue, r);
  			mutex_unlock(&uq_mgr->userq_mutex);
  			goto erase_doorbell;
  		}
@@@ -719,11 -742,13 +742,13 @@@
  		 * This drops the last reference which should take care of
  		 * all cleanup.
  		 */
+ 		trace_amdgpu_userq_create_end(queue, r);
  		amdgpu_userq_put(queue);
  		return r;
  	}
 =20
  	amdgpu_debugfs_userq_init(filp, queue, qid);
+ 	trace_amdgpu_userq_create_end(queue, 0);
  	args->out.queue_id =3D qid;
  	return 0;
 =20
@@@ -739,6 -764,7 +764,7 @@@ clean_doorbell_bo
  free_fence_drv:
  	amdgpu_userq_fence_driver_free(queue);
  free_queue:
+ 	trace_amdgpu_userq_create_end(queue, r);
  	kfree(queue);
  err_pm_runtime:
  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@@ -871,16 -897,10 +897,10 @@@ int amdgpu_userq_ioctl(struct drm_devic
  static int
  amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
  {
- 	struct amdgpu_fpriv *fpriv =3D uq_mgr_to_fpriv(uq_mgr);
- 	struct amdgpu_vm *vm =3D &fpriv->vm;
  	struct amdgpu_usermode_queue *queue;
  	unsigned long queue_id;
  	int ret =3D 0, r;
 =20
-=20
- 	if (amdgpu_bo_reserve(vm->root.bo, false))
- 		return false;
-=20
  	mutex_lock(&uq_mgr->userq_mutex);
  	/* Resume all the queues for this process */
  	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
@@@ -888,6 -908,7 +908,7 @@@
  		if (!amdgpu_userq_buffer_vas_mapped(queue)) {
  			drm_file_err(uq_mgr->file,
  				     "trying restore queue without va mapping\n");
+ 			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_INVALID_VA);
  			queue->state =3D AMDGPU_USERQ_STATE_INVALID_VA;
  			continue;
  		}
@@@ -895,10 -916,8 +916,8 @@@
  		r =3D amdgpu_userq_map_helper(queue);
  		if (r)
  			ret =3D r;
-=20
  	}
  	mutex_unlock(&uq_mgr->userq_mutex);
- 	amdgpu_bo_unreserve(vm->root.bo);
 =20
  	if (ret)
  		drm_file_err(uq_mgr->file,
@@@ -932,7 -951,8 +951,8 @@@ amdgpu_userq_bo_validate(struct amdgpu_
  		spin_unlock(&vm->individual_lock);
 =20
  		bo =3D bo_va->base.bo;
- 		ret =3D drm_exec_prepare_obj(exec, &bo->tbo.base, 2);
+ 		ret =3D drm_exec_prepare_obj(exec, &bo->tbo.base,
+ 					   TTM_NUM_MOVE_FENCES + 1);
  		if (unlikely(ret))
  			return ret;
 =20
@@@ -955,7 -975,7 +975,7 @@@
 =20
  /* Make sure the whole VM is ready to be used */
  static int
- amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
+ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mg=
r)
  {
  	struct amdgpu_fpriv *fpriv =3D uq_mgr_to_fpriv(uq_mgr);
  	bool invalidated =3D false, new_addition =3D false;
@@@ -1081,8 -1101,12 +1101,12 @@@ retry_lock
  	dma_fence_wait(vm->last_update, false);
 =20
  	ret =3D amdgpu_evf_mgr_rearm(&fpriv->evf_mgr, &exec);
- 	if (ret)
+ 	if (ret) {
  		drm_file_err(uq_mgr->file, "Failed to replace eviction fence\n");
+ 		goto unlock_all;
+ 	}
+=20
+ 	ret =3D amdgpu_userq_restore_all(uq_mgr);
 =20
  unlock_all:
  	drm_exec_fini(&exec);
@@@ -1108,18 -1132,34 +1132,34 @@@ static void amdgpu_userq_restore_worker
  	if (!dma_fence_is_signaled(ev_fence))
  		goto put_fence;
 =20
- 	ret =3D amdgpu_userq_vm_validate(uq_mgr);
+ 	ret =3D amdgpu_userq_vm_validate_and_restore_queue(uq_mgr);
  	if (ret) {
  		drm_file_err(uq_mgr->file, "Failed to validate BOs to restore ret=3D%d\=
n", ret);
  		goto put_fence;
  	}
 =20
- 	amdgpu_userq_restore_all(uq_mgr);
-=20
  put_fence:
  	dma_fence_put(ev_fence);
  }
 =20
+ void amdgpu_userq_process_reset_irq(struct amdgpu_device *adev,
+ 				    u32 pasid, u32 doorbell_offset)
+ {
+ 	struct xarray *xa =3D &adev->userq_doorbell_xa;
+ 	struct amdgpu_usermode_queue *queue;
+ 	unsigned long flags, idx;
+=20
+ 	xa_lock_irqsave(xa, flags);
+ 	xa_for_each(xa, idx, queue) {
+ 		if (queue->vm && queue->vm->pasid =3D=3D pasid &&
+ 		    queue->doorbell_offset =3D=3D doorbell_offset) {
+ 			amdgpu_userq_start_hang_detect_work(queue);
+ 			break;
+ 		}
+ 	}
+ 	xa_unlock_irqrestore(xa, flags);
+ }
+=20
  static int
  amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
  {
@@@ -1175,6 -1215,7 +1215,7 @@@ int amdgpu_userq_mgr_init(struct amdgpu
  	xa_init_flags(&userq_mgr->userq_xa, XA_FLAGS_ALLOC);
  	userq_mgr->adev =3D adev;
  	userq_mgr->file =3D file_priv;
+ 	mutex_init(&userq_mgr->proc_ctx_lock);
 =20
  	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_worker);
  	INIT_WORK(&userq_mgr->reset_work, amdgpu_userq_mgr_reset_work);
@@@ -1228,6 -1269,11 +1269,11 @@@ void amdgpu_userq_mgr_fini(struct amdgp
  	 */
  	cancel_work_sync(&userq_mgr->reset_work);
 =20
+ 	amdgpu_bo_free_kernel(&userq_mgr->proc_ctx_obj.obj,
+ 			      &userq_mgr->proc_ctx_obj.gpu_addr,
+ 			      &userq_mgr->proc_ctx_obj.cpu_ptr);
+=20
+ 	mutex_destroy(&userq_mgr->proc_ctx_lock);
  	mutex_destroy(&userq_mgr->userq_mutex);
  }
 =20
@@@ -1377,12 -1423,14 +1423,14 @@@ void amdgpu_userq_pre_reset(struct amdg
  	/* TODO: We probably need a new lock for the queue state */
  	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
  		if (queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED) {
+ 			trace_amdgpu_userq_state_start(queue);
  			userq_funcs =3D adev->userq_funcs[queue->queue_type];
  			userq_funcs->unmap(queue);
  			/* just mark all queues as hung at this point.
  			 * if unmap succeeds, we could map again
  			 * in amdgpu_userq_post_reset() if vram is not lost
  			 */
+ 			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
  			queue->state =3D AMDGPU_USERQ_STATE_HUNG;
  		}
  		/* Force-complete any pending fence regardless of queue state so
@@@ -1406,6 -1454,8 +1454,8 @@@ int amdgpu_userq_post_reset(struct amdg
 =20
  	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
  		if (queue->state =3D=3D AMDGPU_USERQ_STATE_HUNG && !vram_lost) {
+ 			trace_amdgpu_userq_state_start(queue);
+=20
  			userq_funcs =3D adev->userq_funcs[queue->queue_type];
  			/* Re-map queue */
  			r =3D userq_funcs->map(queue);
@@@ -1413,6 -1463,7 +1463,7 @@@
  				dev_err(adev->dev, "Failed to remap queue %ld\n", queue_id);
  				continue;
  			}
+ 			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_MAPPED);
  			queue->state =3D AMDGPU_USERQ_STATE_MAPPED;
  		}
  	}

--lhswrDOQmoK/TBVl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpaPucACgkQJNaLcl1U
h9AqTQf+NH++IlDmqsTJD22I8veX8Y1j7Oqhcmxp4DdDD6lUWgTZsNBEmG5N96lP
IWLlllG7LSTgqnGHcYC7XLZh/Iru43u3tY7PLmnJViaKakAS+VvRgWjwyZKKCHrB
ZMNAQfjFKpeoxfQqvq1iIIdsz5JomMGuu6hBCE5DHizDVmjvxGHZjetaeDJNHum5
gaeNLL8zc1PLppk7CO3TLywcW6USW6ERaRG7tNtx/mMrPlUeeUlHO1GhslyXq6RM
m611Su72EjFd2aoyr8B5TjK4VBtYMfK30eOMiyvq5iyFgpQ807UAse+JCXUOGQAj
EV0SMwc/UdC/t1CAob9FBPxTCWex2w==
=4nVn
-----END PGP SIGNATURE-----

--lhswrDOQmoK/TBVl--
