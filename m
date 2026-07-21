Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86BF6C44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 07:18:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83B2310E5CF;
	Tue, 21 Jul 2026 07:18:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WjRsEnqP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FEBF10E3DF
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 07:17:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C83C560A96;
 Tue, 21 Jul 2026 07:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48EA01F00A3D;
 Tue, 21 Jul 2026 07:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784618278;
 bh=yImYQadUavsy9ABkXnZsK+URN2+4At1CLIsQX67uHdo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WjRsEnqPPwq5Zv8CXWON2CKAvGe7h5eGI3wyRzBZ+OTNiHMDW7dQjFyE/X8bwRnOL
 ic1Cd0GF5QSvmY3fPiWHUCYhEFIV0o4NYdjSPK48nMIphWI7S7zjqnR6ecCMxWrgS5
 ipNidMEmHy1QphtkGkHc2STKse0t3jaxtfgqwBNAi78S7LiPDV7Q4UYTmzQDzH4mCU
 4CXimIrUNgaa2Ac3Dq97oIq2G/ZW3ZKvE7NSO89xis2BsE9pHRIsRdaXpX0oRHfzR+
 pf9bSqH9VQ+Y2e/mkX9RFJS5lG4Km5EpNIfEmTUVUKwj+ZjLhwuLgz7vwZn9PjDaYR
 lEBFZY2sCx4FQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH net-next 06/13] drm/amdkfd: prepare kfd core for the
 knod provider
To: "Taehee Yoo" <ap420073@gmail.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org, bpf@vger.kernel.org
In-Reply-To: <20260719175857.4071636-7-ap420073@gmail.com>
References: <20260719175857.4071636-1-ap420073@gmail.com>
 <20260719175857.4071636-7-ap420073@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 07:17:57 +0000
Message-Id: <20260721071758.48EA01F00A3D@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] kfd_wait_on_events_kernel mixes user and kernel memory semantics, =
causing persistent failures and security risks.
- [High] kfd_ioctl_alloc_memory_of_gpu crashes if called from a kernel thre=
ad due to current->mm dereference.
- [High] kfd_ioctl_map_memory_to_gpu fails unconditionally for kernel calle=
rs due to memdup_array_user.
- [Medium] The return value of knod_init() is silently ignored during probe.
- [Medium] kfd_ioctl_export_dmabuf leaks a file descriptor when called from=
 a kernel thread.
--

--- Patch [6]: [RFC PATCH net-next 06/13] drm/amdkfd: prepare kfd core for =
the knod provider ---
commit c9a02222fa92c5ac2eb02dcfd71c15c6d2016bd7
Author: Taehee Yoo <ap420073@gmail.com>
Subject: drm/amdkfd: prepare kfd core for the knod provider

Expose the kfd internals the knod provider needs to build and run GPU
queues on behalf of the kernel: kernel-side event waiting, GPUVM
allocation for VRAM/GTT, doorbell access, and the HSA queue/packet
layout (kfd_hsa.h). No functional change for existing user-mode
queue users; the provider itself is added in a following patch.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 4c0c77eafbd1c..aa974929d22a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2480,6 +2480,8 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>  		drm_client_setup(adev_to_drm(adev), format);
>  	}
> =20
> +	knod_init(adev);
> +

[Severity: Medium]
Is it intentional to discard the return value of knod_init()?

If this initialization fails or cannot allocate its resources, the error
is not propagated. This might leave the system in an inconsistent state and
lead to further issues when knod_fini() operates on uninitialized structure=
s.

>  	ret =3D amdgpu_debugfs_init(adev);
>  	if (ret)
>  		DRM_ERROR("Creating debugfs files failed (%d).\n", ret);

[ ... ]

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_chardev.c
> index c7edebd2fd8a4..7879a6ffaa762 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1078,8 +1081,8 @@ static int kfd_ioctl_get_available_memory(struct fi=
le *filep,
>  	return 0;
>  }
> =20
> -static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
> -					struct kfd_process *p, void *data)
> +int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
> +				  struct kfd_process *p, void *data)
>  {
>  	struct kfd_ioctl_alloc_memory_of_gpu_args *args =3D data;
>  	struct kfd_process_device *pdd;

[Severity: High]
Could this cause a NULL pointer dereference when called from a kernel threa=
d?

This function is now exported for kernel callers, but internally it has blo=
cks
that dereference current->mm:

svm_range_list_lock_and_flush_work(&p->svms, current->mm);
mutex_lock(&p->svms.lock);
mmap_write_unlock(current->mm);

Since kernel threads execute without a user address space, current->mm is
NULL, which would cause a panic when accessed.

[ ... ]

> @@ -1279,8 +1282,8 @@ static int kfd_ioctl_free_memory_of_gpu(struct file=
 *filep,
>  	return ret;
>  }
> =20
> -static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
> -					struct kfd_process *p, void *data)
> +int kfd_ioctl_map_memory_to_gpu(struct file *filep,
> +				struct kfd_process *p, void *data)
>  {
>  	struct kfd_ioctl_map_memory_to_gpu_args *args =3D data;
>  	struct kfd_process_device *pdd, *peer_pdd;

[Severity: High]
Will memdup_array_user() fail unconditionally when this API is invoked by a
kernel caller?

kfd_ioctl_map_memory_to_gpu() copies the device_ids_array_ptr parameter usi=
ng
memdup_array_user(). Because memdup_array_user() internally relies on
copy_from_user(), it will fail the access_ok() check and return -EFAULT if
provided a kernel-allocated array of device IDs.

[ ... ]

> @@ -1624,8 +1627,8 @@ static int kfd_ioctl_import_dmabuf(struct file *fil=
ep,
>  	return r;
>  }
> =20
> -static int kfd_ioctl_export_dmabuf(struct file *filep,
> -				   struct kfd_process *p, void *data)
> +int kfd_ioctl_export_dmabuf(struct file *filep,
> +			    struct kfd_process *p, void *data)
>  {
>  	struct kfd_ioctl_export_dmabuf_args *args =3D data;
>  	struct kfd_process_device *pdd;

[Severity: Medium]
Does this code permanently leak the file descriptor when called from a kern=
el
thread?

kfd_ioctl_export_dmabuf() calls dma_buf_fd(), which uses fd_install() to
allocate an integer file descriptor in the current process's FD table.
Because kernel threads execute with isolated FD tables and have no mechanism
to pass integer FDs back to userspace or automatically clean them up, both
the file descriptor and its underlying dmabuf reference might leak.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_events.c
> index 81900b49d9d5b..91ef4c61a8bc3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -1068,6 +1068,116 @@ int kfd_wait_on_events(struct kfd_process *p,
>  	return ret;
>  }
> =20
> +int kfd_wait_on_events_kernel(struct kfd_process *p,
> +			      uint32_t num_events, void __user *data,
> +			      bool all, uint32_t *user_timeout_ms,
> +			      uint32_t *wait_result)
> +{
> +	struct kfd_event_data *events =3D (struct kfd_event_data *) data;
> +	uint32_t i;
> +	int ret =3D 0;
> +
> +	struct kfd_event_waiter *event_waiters =3D NULL;
> +	long timeout =3D user_timeout_to_jiffies(*user_timeout_ms);
> +
> +	event_waiters =3D alloc_event_waiters(num_events);
> +	if (!event_waiters) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
> +
> +	/* Use p->event_mutex here to protect against concurrent creation and
> +	 * destruction of events while we initialize event_waiters.
> +	 */
> +	mutex_lock(&p->event_mutex);
> +
> +	for (i =3D 0; i < num_events; i++) {
> +		struct kfd_event_data event_data;
> +
> +		memcpy(&event_data, &events[i], sizeof(struct kfd_event_data));
> +		ret =3D init_event_waiter(p, &event_waiters[i], &event_data);
> +		if (ret)
> +			goto out_unlock;
> +	}
> +
> +	/* Check condition once. */
> +	*wait_result =3D test_event_condition(all, num_events, event_waiters);
> +	if (*wait_result =3D=3D KFD_IOC_WAIT_RESULT_COMPLETE) {
> +		ret =3D copy_signaled_event_data(num_events,
> +					       event_waiters, events);
> +		goto out_unlock;
> +	}

[Severity: High]
Can this mix of memory handling semantics cause failures for both user and
kernel callers?

When evaluating the loop in kfd_wait_on_events_kernel(), there is a direct
memcpy() from the data pointer. If a user pointer is inadvertently passed,
this bypasses copy_from_user(), which can trigger a SMAP violation.

However, when waking up on the fast or slow path, it relies on
copy_signaled_event_data() which internally uses copy_to_user(). If a kernel
caller correctly provides a kernel pointer, copy_to_user() fails the
access_ok() check and returns -EFAULT, causing the event data to be dropped.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719175857.4071=
636-1-ap420073@gmail.com?part=3D6
