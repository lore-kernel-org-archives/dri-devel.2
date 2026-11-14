Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D46606A32D
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 06:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=guzTDcuR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB70C10E213;
	Sat, 14 Nov 2026 06:49:48 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C51510E213
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 06:49:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 66B4B60A7F;
 Sat, 14 Nov 2026 06:49:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E919E1F000C4;
 Sat, 14 Nov 2026 06:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794638981;
 bh=v3GCypYaQAgeBrlopYKDC339tUmYnabx6d2xyJd1ZK8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=guzTDcuRbNHAia7kgJYv4+pG8h19cN9f9i9EUjBXJlskAPRFZn7EigjuZELnrNL+n
 /9RYx+JK8KOdWVyJnHkjMlsDQyVZ7fdR0SewryCGb4Dtk8Ku1L4j2u/56aL118BOG6
 YaRvsBS6Jm4fk/kp1sToyobuM3Of/3LJF1BBNf5cW0Owy9DdSFfADurfm4ajMOs/ro
 zfdofZ9HYhfa+ITEgSvCSUeVK3krlX0EXiFVQ7oQuDRTDrOI95qkU9kFZtiUw+GEgM
 t0MB4KTK5QnP0zpilxSQjEVynqwodC6fnQbi5NB5x4gwuJv/aTA/ALCb3EBRLANi3f
 Z/lso0+4mDwAw==
Message-ID: <sashiko-outbox-214234@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/msm: Destroy the VM_BIND entity when its queue
 is closed
To: "Jiwoo Kim" <arpe1618@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261114062541.2001-1-arpe1618@gmail.com>
References: <20261114062541.2001-1-arpe1618@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 06:49:40 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/msm: BO pin leak and VM state corruption in
  msm_vma_job_free()
--

commit 805b414859330e06db0b87fe27330012423f8dcc
Author: Jiwoo Kim <arpe1618@gmail.com>

drm/msm: Destroy the VM_BIND entity when its queue is closed

This commit destroys the drm_sched_entity of a VM_BIND submitqueue when
userspace closes the queue via MSM_SUBMITQUEUE_CLOSE or file close
instead of on the final submitqueue reference drop, and rejects new
VM_BIND jobs on closed queues.

> diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/=
msm_submitqueue.c
> index 8d550d281704e..2dbe42551bd8f 100644
> --- a/drivers/gpu/drm/msm/msm_submitqueue.c
> +++ b/drivers/gpu/drm/msm/msm_submitqueue.c
[ ... ]
> @@ -107,6 +104,25 @@ struct msm_gpu_submitqueue *msm_submitqueue_get(stru=
ct msm_context *ctx,
>  	return NULL;
>  }
> =20
> +/*
> + * The VM_BIND scheduler is torn down by msm_gem_vm_close() when the fil=
e is
> + * closed, but a VM_BIND queue can outlive that, as long as a job still =
holds
> + * a reference to it.  So destroy the VM_BIND entity here, when userspace
> + * closes the queue, rather than on the final put.  Both ways a queue is=
 taken
> + * off ctx->submitqueues come through here.
> + */
> +static void msm_submitqueue_close_vm_bind(struct msm_gpu_submitqueue *qu=
eue)
> +{
> +	if (queue->entity !=3D &queue->_vm_bind_entity[0])
> +		return;
> +
> +	mutex_lock(&queue->lock);
> +	queue->vm_bind_closed =3D true;
> +	mutex_unlock(&queue->lock);
> +
> +	drm_sched_entity_destroy(queue->entity);
> +}

[Severity: High]
Does cancelling queued VM_BIND jobs in drm_sched_entity_destroy() leak
pinned GEM objects and leave job->vm out of sync with the IOMMU page
tables?

Previously, msm_submitqueue_remove() did not touch the entity, and
msm_submitqueue_close() only called drm_sched_entity_flush(), which left
remaining jobs on the entity unless the process exited via SIGKILL.  Calling
drm_sched_entity_destroy() runs drm_sched_entity_fini() ->
drm_sched_entity_kill() whenever the flush times out on file close (for
example, while a job waits on an unsignaled in-fence) or is interrupted by
a fatal signal during MSM_SUBMITQUEUE_CLOSE.

Killed jobs bypass msm_vma_job_run() and go straight to
msm_vma_job_free(), which neither unpins job->bos_pinned BOs nor drops the
op->obj reference acquired by vm_op_enqueue():

drivers/gpu/drm/msm/msm_gem_vma.c:msm_vma_job_free() {
	...
	/* In error paths, we could have unexecuted ops: */
	while (!list_empty(&job->vm_ops)) {
		struct msm_vm_op *op =3D
			list_first_entry(&job->vm_ops, struct msm_vm_op, node);
		list_del(&op->node);
		kfree(op);
	}
	...
}

In addition, vm_bind_job_prepare() has already updated the VMA state in
job->vm (marking new VMAs as mapped and closing unmapped ones), so
discarding job->vm_ops without applying the page-table updates or calling
msm_gem_vm_unusable(job->vm) leaves the VM state inconsistent while the
context can still be used after MSM_SUBMITQUEUE_CLOSE.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114062541.2001=
-1-arpe1618@gmail.com?part=3D1
