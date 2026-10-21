Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7306F606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=BHahQ11G
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D913110FCE4;
	Wed, 21 Oct 2026 08:59:18 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 621C210FCE4
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 08:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1792573150;
 bh=d3Zk6ZpB/nBqRQTNVHDwUoOKv+LbqWLF3lu9k8Yh1FA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=BHahQ11Gi4mZmrxNYHO1kJsmdmpSoRFe+ljDZXz5GZK6uKXD+09Uys+3o5Mnyzu8Q
 OAfI8B77CFSOiWui8RBPBP9DvkuPpgYiwciKQr+D+G2hEYZ5lwtDdnJcazdIVv1lJX
 hbY7K8pBu2yWoaHtoTcegAHX/MrCXN9qxBkNUtOnOccKqP9yFxqR3AZtZfA3GXfh8a
 pf/SAfdIvodZsmBy6kp3e8jXDFdyfSaYdJyGNW2Vki8sKU+8IhDNEbxpALIQNtMhKV
 D6GqEubnglyQo3SJuNxv+gWAkjyxtXV9W9fpWLi1nFVHkIsmZZYK/eUVMZkPByYYnk
 MumEqfLCqw4VQ==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 4B4B617E05F3;
 Wed, 21 Oct 2026 10:59:10 +0200 (CEST)
Date: Wed, 21 Oct 2026 10:59:04 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Ketil Johnsen <ketil.johnsen@arm.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Daniel Almeida
 <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 11/12] drm/panthor: Protm support for groups
Message-ID: <20261021105904.70fad4b3@fedora-21.home>
In-Reply-To: <20261012125940.3291951-12-ketil.johnsen@arm.com>
References: <20261012125940.3291951-1-ketil.johnsen@arm.com>
 <20261012125940.3291951-12-ketil.johnsen@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 12 Oct 2026 14:59:39 +0200
Ketil Johnsen <ketil.johnsen@arm.com> wrote:

> From: Boris Brezillon <boris.brezillon@collabora.com>
> 
> Extends struct drm_panthor_group_create to allow user provided protm
> suspend buffer. This is needed for protm execution with this group.
> 
> Make use of the user supplied suspend buffer (import).
> 
> Allow PROT_REGION instruction for groups which provided protm
> suspend buffer.
> 
> Store the suspend buffer sizes (normal and protected) provided by FW
> after FW start. Unsafe to read directly from FW as these will return
> zero between FW load and FW start.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Co-developed-by: Ketil Johnsen <ketil.johnsen@arm.com>
> Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>
> 
> ---
> 
> v4:
> - First version of this change as a separate commit
> ---
>  drivers/gpu/drm/panthor/panthor_fw.c    | 24 ++++++++++
>  drivers/gpu/drm/panthor/panthor_fw.h    |  2 +
>  drivers/gpu/drm/panthor/panthor_sched.c | 59 ++++++++++++++++++++-----
>  include/uapi/drm/panthor_drm.h          | 10 ++++-
>  4 files changed, 83 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index 0af6addfd55a5..11c370ef86aad 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -269,6 +269,12 @@ struct panthor_fw {
>  	/** @protm_init_lock: Used to serialize protm initialization. */
>  	struct mutex protm_init_lock;
>  
> +	/** @suspend_size: Size of regular suspend buffer */
> +	u32 suspend_size;
> +
> +	/** @protm_suspend_size: Size of protected suspend buffer size */
> +	u32 protm_suspend_size;
> +
>  	/**
>  	 * @req_waitqueue: FW request waitqueue.
>  	 *
> @@ -1006,6 +1012,14 @@ static int panthor_init_csg_iface(struct panthor_device *ptdev,
>  	}
>  
>  	if (!csg_idx) {
> +		/* We make a copy of these sizes, as csg_iface can read these
> +		 * as zero during full GPU reset, between FW sections being
> +		 * reloaded and FW fully booted.
> +		 */
> +		ptdev->fw->suspend_size = csg_iface->control->suspend_size;
> +		ptdev->fw->protm_suspend_size =
> +			csg_iface->control->protm_suspend_size;
> +
>  		ptdev->protm.info.group_protected_suspend_buf_size =
>  			csg_iface->control->protm_suspend_size;
>  	}
> @@ -1523,6 +1537,16 @@ static void panthor_fw_ping_work(struct work_struct *work)
>  	}
>  }
>  
> +u32 panthor_fw_suspend_size(struct panthor_device *ptdev)
> +{
> +	return ptdev->fw->suspend_size;
> +}
> +
> +u32 panthor_fw_protm_suspend_size(struct panthor_device *ptdev)
> +{
> +	return ptdev->fw->protm_suspend_size;
> +}
> +
>  static bool wait_protm_enter(struct panthor_device *ptdev,
>  			     s64 protm_session_seqno)
>  {
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.h b/drivers/gpu/drm/panthor/panthor_fw.h
> index 34bc9dc82314c..98576114cc803 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.h
> +++ b/drivers/gpu/drm/panthor/panthor_fw.h
> @@ -531,6 +531,8 @@ void panthor_fw_unplug(struct panthor_device *ptdev);
>  
>  int panthor_fw_protm_init(struct drm_file *file,
>  			  struct drm_panthor_protm_init *args);
> +u32 panthor_fw_suspend_size(struct panthor_device *ptdev);
> +u32 panthor_fw_protm_suspend_size(struct panthor_device *ptdev);
>  int panthor_fw_protm_enter(struct panthor_device *ptdev);
>  int panthor_fw_protm_exit(struct panthor_device *ptdev, u32 timeout_ms);
>  int panthor_fw_protm_exit_wait(struct panthor_device *ptdev, u32 timeout_ms);
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index fff805fd794a5..d1178be178a48 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -1462,10 +1462,15 @@ cs_slot_process_protm_pending_event_locked(struct panthor_device *ptdev,
>  	if (!group)
>  		return;
>  
> -	/* Do not allow user space work to switch into protected mode, as we
> -	 * do not fully support this quite yet.
> +	/* Do not allow user space work to switch into protected mode if we
> +	 * do not support protected mode on this device.
> +	 * User space should query (and init) this support before attempting
> +	 * to use such GPU instructions.
>  	 */
> -	atomic_or(BIT(cs_id), &group->fatal_queues);
> +	if (group->protm_suspend_buf)
> +		atomic_or(BIT(cs_id), &group->protm_pending_queues);
> +	else
> +		atomic_or(BIT(cs_id), &group->fatal_queues);
>  
>  	sched_queue_delayed_work(sched, tick, 0);
>  }
> @@ -4074,6 +4079,7 @@ static void add_group_kbo_sizes(struct panthor_device *ptdev,
>  }
>  
>  #define MAX_GROUPS_PER_POOL		128
> +#define GROUP_CREATE_FLAGS DRM_PANTHOR_GROUP_CREATE_PROTECTED
>  
>  int panthor_group_create(struct drm_file *file,
>  			 const struct drm_panthor_group_create *group_args,
> @@ -4083,14 +4089,10 @@ int panthor_group_create(struct drm_file *file,
>  	struct panthor_device *ptdev = pfile->ptdev;
>  	struct panthor_group_pool *gpool = pfile->groups;
>  	struct panthor_scheduler *sched = ptdev->scheduler;
> -	struct panthor_fw_csg_iface *csg_iface = panthor_fw_get_csg_iface(ptdev, 0);
>  	struct panthor_group *group = NULL;
> -	u32 gid, i, suspend_size;
> +	u32 gid, i;
>  	int ret;
>  
> -	if (group_args->pad)
> -		return -EINVAL;
> -
>  	if (group_args->priority >= PANTHOR_CSG_PRIORITY_COUNT)
>  		return -EINVAL;
>  
> @@ -4136,14 +4138,51 @@ int panthor_group_create(struct drm_file *file,
>  		goto err_put_group;
>  	}
>  
> -	suspend_size = csg_iface->control->suspend_size;
> -	group->suspend_buf = panthor_fw_alloc_suspend_buf_mem(ptdev, suspend_size);
> +	group->suspend_buf = panthor_fw_alloc_suspend_buf_mem(
> +		ptdev, panthor_fw_suspend_size(ptdev));
>  	if (IS_ERR(group->suspend_buf)) {
>  		ret = PTR_ERR(group->suspend_buf);
>  		group->suspend_buf = NULL;
>  		goto err_put_group;
>  	}
>  
> +	if (group_args->protected_suspend_bo_handle) {
> +		struct drm_gem_object *obj;
> +
> +		/* Read a correct snapshot of the state */
> +		if (!(smp_load_acquire(&ptdev->protm.info.state) &
> +		      DRM_PANTHOR_PROTM_INITIALIZED)) {

Same comment I made in previous patch: let's use a regular lock to
access this state.

> +			ret = -EINVAL;
> +			goto err_put_group;
> +		}
> +
> +		obj = drm_gem_object_lookup(
> +			file, group_args->protected_suspend_bo_handle);

		obj = drm_gem_object_lookup(file,
					    group_args->protected_suspend_bo_handle);

> +		if (!obj) {
> +			ret = -ENOENT;
> +			goto err_put_group;
> +		}
> +
> +		if (obj->size <
> +		    ptdev->protm.info.group_protected_suspend_buf_size) {

		if (obj->size < ptdev->protm.info.group_protected_suspend_buf_size) {

> +			drm_gem_object_put(obj);
> +			ret = -EINVAL;
> +			goto err_put_group;
> +		}
> +
> +		group->protm_suspend_buf = panthor_kernel_bo_create_from_gem(
> +			ptdev, panthor_fw_vm(ptdev), to_panthor_bo(obj),
> +			DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC,
> +			PANTHOR_VM_KERNEL_AUTO_VA,
> +			panthor_fw_protm_suspend_size(ptdev));

		group->protm_suspend_buf =
			panthor_kernel_bo_create_from_gem(ptdev, panthor_fw_vm(ptdev),
							  to_panthor_bo(obj),
							  DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC,
							  PANTHOR_VM_KERNEL_AUTO_VA,
							  panthor_fw_protm_suspend_size(ptdev));

> +		drm_gem_object_put(obj);
> +		if (IS_ERR(group->protm_suspend_buf)) {
> +			ret = PTR_ERR(group->protm_suspend_buf);
> +			group->protm_suspend_buf = NULL;
> +			goto err_put_group;
> +		}
> +	}
> +
>  	group->syncobjs = panthor_kernel_bo_create(ptdev, group->vm,
>  						   group_args->queues.count *
>  						   sizeof(struct panthor_syncobj_64b),
> diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
> index d2d21e3e6bb39..a0ed16041e178 100644
> --- a/include/uapi/drm/panthor_drm.h
> +++ b/include/uapi/drm/panthor_drm.h
> @@ -956,8 +956,14 @@ struct drm_panthor_group_create {
>  	/** @priority: Group priority (see enum drm_panthor_group_priority). */
>  	__u8 priority;
>  
> -	/** @pad: Padding field, MBZ. */
> -	__u32 pad;
> +	/**
> +	 * @protected_suspend_bo_handle: BO to use as a protected suspend buffer.
> +	 *
> +	 * This BO must have been allocated from a protected DMA-BUF heap and
> +	 * imported in panthor. It's size must be at least
> +	 * drm_panthor_protm_info::group_protected_suspend_buf_size.
> +	 */
> +	__u32 protected_suspend_bo_handle;
>  
>  	/**
>  	 * @compute_core_mask: Mask encoding cores that can be used for compute jobs.

