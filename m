Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B16606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 14:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TSKty5/x
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56FD210FD6C;
	Wed, 18 Nov 2026 14:53:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E28010FD82;
 Wed, 18 Nov 2026 14:53:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 593D741AA7;
 Wed, 18 Nov 2026 14:53:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF1D1F000C4;
 Wed, 18 Nov 2026 14:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795013616;
 bh=Vq6Uc4LoemS8TszUP6FSImYRhqqMJpFIYXQIww4FHYQ=;
 h=Date:From:To:Cc:Subject;
 b=TSKty5/xPEdFYYn23XD33khOaGLNsuxdO5s689SWSKMnEexyMc0RMCARtWFKOz3I4
 kO3VbCUKI/m5gp8eXTkn18Q9MkoV3L8aXVLawK/DMfuj+SkDOGdyqsZDKwcSZrcmQ7
 3tNjB4JD7wV6zO9O5kCPmxkFUCDjR5hbRdoSBDkjGhs7+wy6B2Ri6RAFtFS6h/XcOB
 pANtf+prZftG3l4FZ8enauKf1jAk+yNGK/rGpysocTse6v+TpMyF9+eD3EsG84EqeV
 UgOgUyaPK3oEuZVuidm+rH0v0q2cG54hjPDDewdmXB/LG0Hl3TCu2Xk51Wd9LDmoaD
 L7OzoUW9/dwmQ==
Date: Wed, 18 Nov 2026 14:53:32 +0000
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>,
 Triet Hoang <triet.hoang.dev@gmail.com>
Subject: linux-next: manual merge of the drm tree with the drm-misc-fixes tree
Message-ID: <av27642L7XkY-L2E@sirena.org.uk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KLNgp1zSBCEYXc2u"
Content-Disposition: inline
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--KLNgp1zSBCEYXc2u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/accel/rocket/rocket_job.c

between commits:

  9bca2b5f1a4fa ("accel/rocket: Keep scheduler allocation in rocket_file_pr=
iv")
  d341ef030f3ce ("accel/rocket: Check allocations before use")

=66rom the drm-misc-fixes tree and commits:

  be22e979c18f5 ("accel/rocket: Check allocations before use")
  91c7da1f42cad ("drm/rocket: Keep scheduler allocation in rocket_file_priv=
")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/accel/rocket/rocket_job.c
index 7b798a90bc492,b2a00992c8894..0000000000000
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@@ -201,13 -201,12 +201,13 @@@ static int rocket_acquire_object_fences
 =20
  static void rocket_attach_object_fences(struct drm_gem_object **bos,
  					int bo_count,
 -					struct dma_fence *fence)
 +					struct dma_fence *fence,
 +					enum dma_resv_usage usage)
  {
  	int i;
 =20
  	for (i =3D 0; i < bo_count; i++)
 -		dma_resv_add_fence(bos[i]->resv, fence, DMA_RESV_USAGE_WRITE);
 +		dma_resv_add_fence(bos[i]->resv, fence, usage);
  }
 =20
  static int rocket_job_push(struct rocket_job *job)
@@@ -215,7 -214,7 +215,7 @@@
  	struct rocket_device *rdev =3D job->rdev;
  	struct drm_gem_object **bos;
  	struct ww_acquire_ctx acquire_ctx;
- 	u32 bo_count;
+ 	int bo_count;
  	int ret =3D 0;
 =20
  	if (check_add_overflow(job->in_bo_count, job->out_bo_count, &bo_count))
@@@ -231,28 -230,27 +231,30 @@@
  	if (ret)
  		goto err;
 =20
+ 	ret =3D rocket_acquire_object_fences(job->in_bos, job->in_bo_count,
+ 					   &job->base, false);
+ 	if (ret)
+ 		goto err_unlock;
+=20
+ 	ret =3D rocket_acquire_object_fences(job->out_bos, job->out_bo_count,
+ 					   &job->base, true);
+ 	if (ret)
+ 		goto err_unlock;
+=20
  	scoped_guard(mutex, &rdev->sched_lock) {
  		drm_sched_job_arm(&job->base);
 =20
  		job->inference_done_fence =3D dma_fence_get(&job->base.s_fence->finishe=
d);
 =20
- 		ret =3D rocket_acquire_object_fences(job->in_bos, job->in_bo_count, &jo=
b->base, false);
- 		if (ret)
- 			goto err_unlock;
-=20
- 		ret =3D rocket_acquire_object_fences(job->out_bos, job->out_bo_count, &=
job->base, true);
- 		if (ret)
- 			goto err_unlock;
-=20
  		kref_get(&job->refcount); /* put by scheduler job completion */
 =20
  		drm_sched_entity_push_job(&job->base);
  	}
 =20
 -	rocket_attach_object_fences(job->out_bos, job->out_bo_count, job->infere=
nce_done_fence);
 +	rocket_attach_object_fences(job->in_bos, job->in_bo_count,
 +				    job->inference_done_fence, DMA_RESV_USAGE_READ);
 +	rocket_attach_object_fences(job->out_bos, job->out_bo_count,
 +				    job->inference_done_fence, DMA_RESV_USAGE_WRITE);
 =20
  err_unlock:
  	drm_gem_unlock_reservations(bos, bo_count, &acquire_ctx);
@@@ -268,7 -266,7 +270,7 @@@ static void rocket_job_cleanup(struct k
  						refcount);
  	unsigned int i;
 =20
 -	rocket_iommu_domain_put(job->domain);
 +	rocket_vm_put(job->vm);
 =20
  	dma_fence_put(job->done_fence);
  	dma_fence_put(job->inference_done_fence);
@@@ -349,7 -347,7 +351,7 @@@ static struct dma_fence *rocket_job_run
  	if (ret < 0)
  		goto err_put_fences;
 =20
 -	ret =3D iommu_attach_group(job->domain->domain, core->iommu_group);
 +	ret =3D iommu_attach_group(job->vm->domain, core->iommu_group);
  	if (ret < 0)
  		goto err_put_pm;
 =20
@@@ -373,56 -371,39 +375,56 @@@ static void rocket_job_handle_irq(struc
  {
  	pm_runtime_mark_last_busy(core->dev);
 =20
 -	rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
 -	rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
 +	scoped_guard(mutex, &core->job_lock) {
 +		/*
 +		 * Stopping the block belongs under the lock. hw_submit() writes
 +		 * OPERATION_ENABLE too, and outside the lock this zero can land
 +		 * after that one and stop a task that has only just started.
 +		 */
 +		rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
 +		rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
 =20
 -	scoped_guard(mutex, &core->job_lock)
  		if (core->in_flight_job) {
  			if (core->in_flight_job->next_task_idx < core->in_flight_job->task_cou=
nt) {
  				rocket_job_hw_submit(core, core->in_flight_job);
  				return;
  			}
 =20
 -			iommu_detach_group(NULL, iommu_group_get(core->dev));
 +			iommu_detach_group(NULL, core->iommu_group);
  			dma_fence_signal(core->in_flight_job->done_fence);
  			pm_runtime_put_autosuspend(core->dev);
  			core->in_flight_job =3D NULL;
  		}
 +	}
  }
 =20
  static void
  rocket_reset(struct rocket_core *core, struct drm_sched_job *bad)
  {
 +	bool put_job_ref;
 +
  	if (!atomic_read(&core->reset.pending))
  		return;
 =20
  	drm_sched_stop(&core->sched, bad);
 =20
 +	scoped_guard(mutex, &core->job_lock) {
 +		if (pm_runtime_get_if_active(core->dev) > 0) {
 +			rocket_pc_writel(core, INTERRUPT_MASK, 0x0);
 +			rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
 +			pm_runtime_put_autosuspend(core->dev);
 +		}
 +	}
 +
 +	synchronize_irq(core->irq);
 +
  	/*
  	 * Remaining interrupts have been handled, but we might still have
  	 * stuck jobs. Let's make sure the PM counters stay balanced by
 -	 * manually calling pm_runtime_put_noidle().
 +	 * dropping the job's reference once the core has been reset.
  	 */
  	scoped_guard(mutex, &core->job_lock) {
 -		if (core->in_flight_job)
 -			pm_runtime_put_noidle(core->dev);
 +		put_job_ref =3D core->in_flight_job;
 =20
  		iommu_detach_group(NULL, core->iommu_group);
 =20
@@@ -432,9 -413,6 +434,9 @@@
  	/* Proceed with reset now. */
  	rocket_core_reset(core);
 =20
 +	if (put_job_ref)
 +		pm_runtime_put_autosuspend(core->dev);
 +
  	/* NPU has been reset, we can clear the reset pending bit. */
  	atomic_set(&core->reset.pending, 0);
 =20
@@@ -572,7 -550,7 +574,7 @@@ int rocket_job_open(struct rocket_file_
  				    DRM_SCHED_PRIORITY_NORMAL,
  				    scheds,
  				    rdev->num_cores, NULL);
- 	if (WARN_ON(ret))
+ 	if (ret)
  		kfree(scheds);
  	else
  		rocket_priv->scheds =3D scheds;
@@@ -584,8 -562,8 +586,8 @@@ void rocket_job_close(struct rocket_fil
  {
  	struct drm_sched_entity *entity =3D &rocket_priv->sched_entity;
 =20
- 	kfree(rocket_priv->scheds);
  	drm_sched_entity_destroy(entity);
+ 	kfree(rocket_priv->scheds);
  }
 =20
  int rocket_job_is_idle(struct rocket_core *core)
@@@ -608,6 -586,11 +610,11 @@@ static int rocket_ioctl_submit_job(stru
  	if (job->task_count =3D=3D 0)
  		return -EINVAL;
 =20
+ 	/* GEM lookup takes a signed object count. */
+ 	if (job->in_bo_handle_count > INT_MAX ||
+ 	    job->out_bo_handle_count > INT_MAX)
+ 		return -EINVAL;
+=20
  	rjob =3D kzalloc_obj(*rjob);
  	if (!rjob)
  		return -ENOMEM;
@@@ -615,7 -598,7 +622,7 @@@
  	kref_init(&rjob->refcount);
 =20
  	rjob->rdev =3D rdev;
 -	rjob->domain =3D rocket_iommu_domain_get(file_priv);
 +	rjob->vm =3D rocket_vm_get(file_priv);
 =20
  	ret =3D drm_sched_job_init(&rjob->base,
  				 &file_priv->sched_entity,
@@@ -691,8 -674,11 +698,11 @@@ int rocket_ioctl_submit(struct drm_devi
  	}
 =20
 =20
- 	for (i =3D 0; i < args->job_count; i++)
- 		rocket_ioctl_submit_job(dev, file, &jobs[i]);
+ 	for (i =3D 0; i < args->job_count; i++) {
+ 		ret =3D rocket_ioctl_submit_job(dev, file, &jobs[i]);
+ 		if (ret)
+ 			goto exit;
+ 	}
 =20
  exit:
  	kvfree(jobs);

--KLNgp1zSBCEYXc2u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmr9u+sACgkQJNaLcl1U
h9BW0Qf/VsJcaTY8Psv1i1TYBMay9B0cQYxYvz+PaGwb32ZHSoyGHPsS5PdwTjXp
iVzmjIUaR27P/cp1AX+1hLV2x0LqxsTEVAO1wPaVOotVYIIR3axubnliqHNHwpB+
RvINw4b5oMZdfhl/HdVFahprpXdcPBfAJF+vnbTWDzDLRwkYzEUUclix+IlrYvIe
Idn26zDGcosHS13PjyBCJSyXU0eu0YvfX896oeh8Ij+JSYB4Y/HeqEWzgT77OQEh
lehoxdYs+nGClfu2L1YJcRXMNx5fqGnf8HRPSjDGDwarAQjJEHOywxJ1BMOTlay7
XeRoYe5lKlUXxwxEHLxSOlSvy38tjQ==
=VPdv
-----END PGP SIGNATURE-----

--KLNgp1zSBCEYXc2u--
