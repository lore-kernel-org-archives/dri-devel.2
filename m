Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73428FF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 20:31:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B01A210EC0E;
	Tue,  5 May 2026 20:31:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZyK6kOLY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D0EB10EC0E
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 20:31:11 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 76E476057A;
 Tue,  5 May 2026 20:31:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F04C2BCB4;
 Tue,  5 May 2026 20:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778013070;
 bh=RQACp8yZvicDKFG+7cjATwJDNroWVQ5bqbXjcZ8mCi0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZyK6kOLYP9Tf+1zxxwSBE0tFRMvGhSWHQ4PLqflmHsSagAUIWF9N2x9pLC5jqFuC5
 3sBzOqnkVe3qsjCLcmjzCnSSpBFFjFOkyVN8lq3ckOq+x1Ys4/uVhIdstwE13x8JOi
 Uk/aQ6EGChnKJ6eQ0g1BsIuA2P5s3jsrHm9zaPXlcyE/9COO9rzf0pDO5ogCsi/1wI
 vSNNjfq2SeUDBFOM5xKLI1Qy7eJzFk1BPQJ8PvDRu+j2WRNjgEP0AoeDRErDf71CcM
 iFiOyzVnvP7G3WGmKLGx/SSw84PH2TmO4t32v0Fiq4qp3IaBy4/uvYoujZLQY0kgHV
 4hquFrGjisfAw==
Message-ID: <d2c7e43b-b3b6-4aee-abb4-82edfb98d2ab@kernel.org>
Date: Tue, 5 May 2026 15:31:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 4/6] accel/amdxdna: Add command doorbell and wait
 support
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 karol.wachowski@linux.intel.com
Cc: David Zhang <yidong.zhang@amd.com>, linux-kernel@vger.kernel.org,
 max.zhen@amd.com, sonal.santan@amd.com,
 Hayden Laccabue <Hayden.Laccabue@amd.com>
References: <20260505160936.3917732-1-lizhi.hou@amd.com>
 <20260505160936.3917732-5-lizhi.hou@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260505160936.3917732-5-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 5/5/26 11:09, Lizhi Hou wrote:
> From: David Zhang <yidong.zhang@amd.com>
> 
> Expose the command doorbell register to userspace on a per-hardware
> context basis, enabling applications to notify the firmware of pending
> commands via doorbell writes.
> 
> Introduce DRM_IOCTL_AMDXDNA_WAIT_CMD to allow userspace to wait for
> completion of individual commands.
> 
> Co-developed-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
> Signed-off-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
> Signed-off-by: David Zhang <yidong.zhang@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Minor suggestion below.

> ---
>   drivers/accel/amdxdna/aie4_ctx.c        | 75 +++++++++++++++++++++++++
>   drivers/accel/amdxdna/aie4_host_queue.h |  2 +
>   drivers/accel/amdxdna/aie4_pci.c        | 34 +++++++++++
>   drivers/accel/amdxdna/aie4_pci.h        |  3 +
>   drivers/accel/amdxdna/amdxdna_ctx.c     | 34 +++++++++++
>   drivers/accel/amdxdna/amdxdna_ctx.h     |  4 +-
>   drivers/accel/amdxdna/amdxdna_gem.c     |  5 +-
>   drivers/accel/amdxdna/amdxdna_pci_drv.c | 18 +++++-
>   drivers/accel/amdxdna/amdxdna_pci_drv.h |  3 +
>   drivers/accel/amdxdna/npu3_regs.c       |  5 ++
>   include/uapi/drm/amdxdna_accel.h        | 22 +++++++-
>   11 files changed, 198 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie4_ctx.c
> index 84ac706d0ffb..8408b0d2696f 100644
> --- a/drivers/accel/amdxdna/aie4_ctx.c
> +++ b/drivers/accel/amdxdna/aie4_ctx.c
> @@ -256,3 +256,78 @@ void aie4_hwctx_fini(struct amdxdna_hwctx *hwctx)
>   	aie4_hwctx_umq_fini(hwctx);
>   	kfree(hwctx->priv);
>   }
> +
> +static inline bool valid_queue_index(u64 read, u64 write, u32 capacity)
> +{
> +	return (write >= read) && ((write - read) <= capacity);
> +}
> +
> +static u64 get_read_index(struct amdxdna_hwctx *hwctx)
> +{
> +	u64 wi = READ_ONCE(*hwctx->priv->umq_write_index);
> +	u64 ri = READ_ONCE(*hwctx->priv->umq_read_index);
> +	struct amdxdna_dev *xdna = hwctx->client->xdna;
> +
> +	/*
> +	 * CERT cannot update read index as uint64 atomically. Driver may read
> +	 * half-updated read index when it has bits in high 32bit. In case read
> +	 * index is not valid, wait for some time and retry once. It should
> +	 * allow CERT to complete the read index update.
> +	 */
> +	if (!valid_queue_index(ri, wi, CTX_MAX_CMDS)) {
> +		XDNA_WARN(xdna, "Invalid index, ri %llu, wi %llu", ri, wi);
> +		usleep_range(100, 200);
> +		ri = READ_ONCE(*hwctx->priv->umq_read_index);
> +		if (!valid_queue_index(ri, wi, CTX_MAX_CMDS)) {
> +			XDNA_ERR(xdna, "Invalid index after retry, ri %llu, wi %llu", ri, wi);
> +			ri = 0;
> +		}
> +	}
> +
> +	return ri;
> +}
> +
> +static inline bool check_cmd_done(struct amdxdna_hwctx *hwctx, u64 seq)
> +{
> +	u64 read_idx = get_read_index(hwctx);
> +
> +	return read_idx > seq;
> +}
> +
> +int aie4_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout)
> +{
> +	unsigned long wait_jifs = MAX_SCHEDULE_TIMEOUT;
> +	struct amdxdna_hwctx_priv *priv = hwctx->priv;
> +	struct cert_comp *cert_comp = priv->cert_comp;
> +	long ret;

Not sure I see the point in making ret a long. 
wait_event_interruptible_timeout() retun 0 or 1.

bool val;
val = wait_event_interruptible_timeout()
return val ? 0 : -ETIME;


> +
> +	if (timeout)
> +		wait_jifs = msecs_to_jiffies(timeout);
> +
> +	ret = wait_event_interruptible_timeout(cert_comp->waitq,
> +					       (check_cmd_done(hwctx, seq)),
> +					       wait_jifs);
> +
> +	if (!ret)
> +		ret = -ETIME;
> +
> +	return ret <= 0 ? ret : 0;
> +}
> +
> +int aie4_hwctx_valid_doorbell(struct amdxdna_client *client, u32 vm_pgoff)
> +{
> +	struct amdxdna_hwctx *hwctx;
> +	unsigned long hwctx_id;
> +	int idx;
> +
> +	idx = srcu_read_lock(&client->hwctx_srcu);
> +	amdxdna_for_each_hwctx(client, hwctx_id, hwctx) {
> +		if (vm_pgoff == (hwctx->doorbell_offset >> PAGE_SHIFT)) {
> +			srcu_read_unlock(&client->hwctx_srcu, idx);
> +			return 1;
> +		}
> +	}
> +	srcu_read_unlock(&client->hwctx_srcu, idx);
> +
> +	return 0;
> +}
> diff --git a/drivers/accel/amdxdna/aie4_host_queue.h b/drivers/accel/amdxdna/aie4_host_queue.h
> index eb6a38dfb53e..1b33eda3f727 100644
> --- a/drivers/accel/amdxdna/aie4_host_queue.h
> +++ b/drivers/accel/amdxdna/aie4_host_queue.h
> @@ -8,6 +8,8 @@
>   
>   #include <linux/types.h>
>   
> +#define CTX_MAX_CMDS                    32
> +
>   struct host_queue_header {
>   	__u64 read_index;
>   	struct {
> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
> index 3be9066b7178..9ff34ce57fcb 100644
> --- a/drivers/accel/amdxdna/aie4_pci.c
> +++ b/drivers/accel/amdxdna/aie4_pci.c
> @@ -503,6 +503,38 @@ static int aie4m_pcidev_init(struct amdxdna_dev *xdna)
>   	return 0;
>   }
>   
> +static int aie4_doorbell_mmap(struct amdxdna_client *client, struct vm_area_struct *vma)
> +{
> +	struct amdxdna_dev *xdna = client->xdna;
> +	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
> +	const struct amdxdna_dev_priv *npriv = xdna->dev_info->dev_priv;
> +	phys_addr_t res_start;
> +	unsigned long pfn;
> +	int ret;
> +
> +	if (!aie4_hwctx_valid_doorbell(client, vma->vm_pgoff)) {
> +		XDNA_ERR(xdna, "Invalid doorbell page offset 0x%lx", vma->vm_pgoff);
> +		return -EINVAL;
> +	}
> +
> +	if (vma_pages(vma) != 1) {
> +		XDNA_ERR(xdna, "can only map one page, got %ld", vma_pages(vma));
> +		return -EINVAL;
> +	}
> +
> +	res_start = pci_resource_start(pdev, xdna->dev_info->doorbell_bar) + npriv->doorbell_off;
> +	pfn = PHYS_PFN(res_start) + vma->vm_pgoff;
> +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +	vm_flags_set(vma, VM_IO | VM_DONTEXPAND | VM_DONTDUMP);
> +	ret = io_remap_pfn_range(vma, vma->vm_start,
> +				 pfn,
> +				 PAGE_SIZE,
> +				 vma->vm_page_prot);
> +
> +	XDNA_DBG(xdna, "doorbell ret %d", ret);
> +	return ret;
> +}
> +
>   static int aie4_pf_init(struct amdxdna_dev *xdna)
>   {
>   	int ret;
> @@ -547,4 +579,6 @@ const struct amdxdna_dev_ops aie4_vf_ops = {
>   	.fini			= aie4_vf_fini,
>   	.hwctx_init		= aie4_hwctx_init,
>   	.hwctx_fini		= aie4_hwctx_fini,
> +	.mmap			= aie4_doorbell_mmap,
> +	.cmd_wait		= aie4_cmd_wait,
>   };
> diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
> index 6103007e6d2f..b69489acd53d 100644
> --- a/drivers/accel/amdxdna/aie4_pci.h
> +++ b/drivers/accel/amdxdna/aie4_pci.h
> @@ -36,6 +36,7 @@ struct amdxdna_dev_priv {
>   	u32			mbox_bar;
>   	u32			mbox_rbuf_bar;
>   	u64			mbox_info_off;
> +	u32			doorbell_off;
>   
>   	struct aie_bar_off_pair	psp_regs_off[PSP_MAX_REGS];
>   	struct aie_bar_off_pair	smu_regs_off[SMU_MAX_REGS];
> @@ -60,6 +61,8 @@ int aie4_suspend_fw(struct amdxdna_dev_hdl *ndev);
>   /* aie4_ctx.c */
>   int aie4_hwctx_init(struct amdxdna_hwctx *hwctx);
>   void aie4_hwctx_fini(struct amdxdna_hwctx *hwctx);
> +int aie4_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout);
> +int aie4_hwctx_valid_doorbell(struct amdxdna_client *client, u32 vm_pgoff);
>   
>   /* aie4_sriov.c */
>   #if IS_ENABLED(CONFIG_PCI_IOV)
> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
> index b5ad60d4b734..b79229a63af3 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
> @@ -627,3 +627,37 @@ int amdxdna_drm_submit_cmd_ioctl(struct drm_device *dev, void *data, struct drm_
>   	XDNA_ERR(client->xdna, "Invalid command type %d", args->type);
>   	return -EINVAL;
>   }
> +
> +int amdxdna_drm_wait_cmd_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
> +{
> +	struct amdxdna_client *client = filp->driver_priv;
> +	struct amdxdna_dev *xdna = to_xdna_dev(dev);
> +	struct amdxdna_drm_wait_cmd *args = data;
> +	struct amdxdna_hwctx *hwctx;
> +	int ret, idx;
> +
> +	XDNA_DBG(xdna, "PID %d ctx %d timeout set %d ms for cmd %llu",
> +		 client->pid, args->hwctx, args->timeout, args->seq);
> +
> +	if (!xdna->dev_info->ops->cmd_wait)
> +		return -EOPNOTSUPP;
> +
> +	idx = srcu_read_lock(&client->hwctx_srcu);
> +	hwctx = xa_load(&client->hwctx_xa, args->hwctx);
> +	if (!hwctx) {
> +		XDNA_DBG(xdna, "PID %d failed to get ctx %d", client->pid, args->hwctx);
> +		ret = -EINVAL;
> +		goto unlock_ctx_srcu;
> +	}
> +
> +	ret = xdna->dev_info->ops->cmd_wait(hwctx, args->seq, args->timeout);
> +
> +	XDNA_DBG(xdna, "PID %d ctx %d cmd %lld wait finished, ret %d",
> +		 client->pid, args->hwctx, args->seq, ret);
> +
> +	trace_amdxdna_debug_point(current->comm, args->seq, "job returned to user");
> +
> +unlock_ctx_srcu:
> +	srcu_read_unlock(&client->hwctx_srcu, idx);
> +	return ret;
> +}
> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h b/drivers/accel/amdxdna/amdxdna_ctx.h
> index c5622718b4d5..6e3c6371a088 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.h
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.h
> @@ -211,12 +211,10 @@ int amdxdna_cmd_submit(struct amdxdna_client *client,
>   		       u32 *arg_bo_hdls, u32 arg_bo_cnt,
>   		       u32 hwctx_hdl, u64 *seq);
>   
> -int amdxdna_cmd_wait(struct amdxdna_client *client, u32 hwctx_hdl,
> -		     u64 seq, u32 timeout);
> -
>   int amdxdna_drm_create_hwctx_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
>   int amdxdna_drm_config_hwctx_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
>   int amdxdna_drm_destroy_hwctx_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
>   int amdxdna_drm_submit_cmd_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
> +int amdxdna_drm_wait_cmd_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
>   
>   #endif /* _AMDXDNA_CTX_H_ */
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index ebfc472aa9e7..319d2064fafa 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -212,7 +212,8 @@ static bool amdxdna_hmm_invalidate(struct mmu_interval_notifier *mni,
>   	mmu_interval_set_seq(&mapp->notifier, cur_seq);
>   	up_write(&xdna->notifier_lock);
>   
> -	xdna->dev_info->ops->hmm_invalidate(abo, cur_seq);
> +	if (xdna->dev_info->ops->hmm_invalidate)
> +		xdna->dev_info->ops->hmm_invalidate(abo, cur_seq);
>   
>   	if (range->event == MMU_NOTIFY_UNMAP) {
>   		down_write(&xdna->notifier_lock);
> @@ -295,7 +296,7 @@ static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
>   	u32 nr_pages;
>   	int ret;
>   
> -	if (!xdna->dev_info->ops->hmm_invalidate)
> +	if (!amdxdna_pasid_on(abo->client))
>   		return 0;
>   
>   	mapp = kzalloc_obj(*mapp);
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> index 39ad081ac082..c0d00db25cde 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> @@ -224,6 +224,21 @@ static int amdxdna_drm_set_state_ioctl(struct drm_device *dev, void *data, struc
>   	return ret;
>   }
>   
> +static int amdxdna_drm_gem_mmap(struct file *filp, struct vm_area_struct *vma)
> +{
> +	struct drm_file *drm_filp = filp->private_data;
> +	struct amdxdna_client *client = drm_filp->driver_priv;
> +	struct amdxdna_dev *xdna = client->xdna;
> +
> +	if (likely(vma->vm_pgoff >= DRM_FILE_PAGE_OFFSET_START))
> +		return drm_gem_mmap(filp, vma);
> +
> +	if (!xdna->dev_info->ops->mmap)
> +		return -EOPNOTSUPP;
> +
> +	return xdna->dev_info->ops->mmap(client, vma);
> +}
> +
>   static const struct drm_ioctl_desc amdxdna_drm_ioctls[] = {
>   	/* Context */
>   	DRM_IOCTL_DEF_DRV(AMDXDNA_CREATE_HWCTX, amdxdna_drm_create_hwctx_ioctl, 0),
> @@ -235,6 +250,7 @@ static const struct drm_ioctl_desc amdxdna_drm_ioctls[] = {
>   	DRM_IOCTL_DEF_DRV(AMDXDNA_SYNC_BO, amdxdna_drm_sync_bo_ioctl, 0),
>   	/* Execution */
>   	DRM_IOCTL_DEF_DRV(AMDXDNA_EXEC_CMD, amdxdna_drm_submit_cmd_ioctl, 0),
> +	DRM_IOCTL_DEF_DRV(AMDXDNA_WAIT_CMD, amdxdna_drm_wait_cmd_ioctl, 0),
>   	/* AIE hardware */
>   	DRM_IOCTL_DEF_DRV(AMDXDNA_GET_INFO, amdxdna_drm_get_info_ioctl, 0),
>   	DRM_IOCTL_DEF_DRV(AMDXDNA_GET_ARRAY, amdxdna_drm_get_array_ioctl, 0),
> @@ -281,7 +297,7 @@ static const struct file_operations amdxdna_fops = {
>   	.poll		= drm_poll,
>   	.read		= drm_read,
>   	.llseek		= noop_llseek,
> -	.mmap		= drm_gem_mmap,
> +	.mmap		= amdxdna_drm_gem_mmap,
>   	.show_fdinfo	= drm_show_fdinfo,
>   	.fop_flags	= FOP_UNSIGNED_OFFSET,
>   };
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
> index caed11c09e55..471b72299aee 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
> @@ -56,12 +56,14 @@ struct amdxdna_dev_ops {
>   	int (*resume)(struct amdxdna_dev *xdna);
>   	int (*suspend)(struct amdxdna_dev *xdna);
>   	int (*sriov_configure)(struct amdxdna_dev *xdna, int num_vfs);
> +	int (*mmap)(struct amdxdna_client *client, struct vm_area_struct *vma);
>   	int (*hwctx_init)(struct amdxdna_hwctx *hwctx);
>   	void (*hwctx_fini)(struct amdxdna_hwctx *hwctx);
>   	int (*hwctx_config)(struct amdxdna_hwctx *hwctx, u32 type, u64 value, void *buf, u32 size);
>   	int (*hwctx_sync_debug_bo)(struct amdxdna_hwctx *hwctx, u32 debug_bo_hdl);
>   	void (*hmm_invalidate)(struct amdxdna_gem_obj *abo, unsigned long cur_seq);
>   	int (*cmd_submit)(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job, u64 *seq);
> +	int (*cmd_wait)(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout);
>   	int (*get_aie_info)(struct amdxdna_client *client, struct amdxdna_drm_get_info *args);
>   	int (*set_aie_state)(struct amdxdna_client *client, struct amdxdna_drm_set_state *args);
>   	int (*get_array)(struct amdxdna_client *client, struct amdxdna_drm_get_array *args);
> @@ -85,6 +87,7 @@ struct amdxdna_dev_info {
>   	int				sram_bar;
>   	int				psp_bar;
>   	int				smu_bar;
> +	int				doorbell_bar;
>   	int				device_type;
>   	int				first_col;
>   	u32				dev_mem_buf_shift;
> diff --git a/drivers/accel/amdxdna/npu3_regs.c b/drivers/accel/amdxdna/npu3_regs.c
> index 6d5da779232b..d76b2e99c308 100644
> --- a/drivers/accel/amdxdna/npu3_regs.c
> +++ b/drivers/accel/amdxdna/npu3_regs.c
> @@ -14,6 +14,9 @@
>   #define NPU3_MBOX_BUFFER_BAR	2
>   #define NPU3_MBOX_INFO_OFF	0x0
>   
> +#define NPU3_DOORBELL_BAR       2
> +#define NPU3_DOORBELL_OFF       0x0
> +
>   /* PCIe BAR Index for NPU3 */
>   #define NPU3_REG_BAR_INDEX	0
>   #define NPU3_PSP_BAR_INDEX      4
> @@ -45,6 +48,7 @@ static const struct amdxdna_dev_priv npu3_dev_priv = {
>   	.mbox_bar		= NPU3_MBOX_BAR,
>   	.mbox_rbuf_bar		= NPU3_MBOX_BUFFER_BAR,
>   	.mbox_info_off		= NPU3_MBOX_INFO_OFF,
> +	.doorbell_off		= NPU3_DOORBELL_OFF,
>   	.psp_regs_off   = {
>   		DEFINE_BAR_OFFSET(PSP_CMD_REG,    NPU3_PSP, MPASP_C2PMSG_123_ALT_1),
>   		DEFINE_BAR_OFFSET(PSP_ARG0_REG,   NPU3_PSP, MPASP_C2PMSG_156_ALT_1),
> @@ -87,6 +91,7 @@ const struct amdxdna_dev_info dev_npu3_pf_info = {
>   const struct amdxdna_dev_info dev_npu3_vf_info = {
>   	.mbox_bar		= NPU3_MBOX_BAR,
>   	.sram_bar		= NPU3_MBOX_BUFFER_BAR,
> +	.doorbell_bar		= NPU3_DOORBELL_BAR,
>   	.default_vbnv		= "RyzenAI-npu3-vf",
>   	.device_type		= AMDXDNA_DEV_TYPE_UMQ,
>   	.dev_priv		= &npu3_dev_vf_priv,
> diff --git a/include/uapi/drm/amdxdna_accel.h b/include/uapi/drm/amdxdna_accel.h
> index ad9b33dd7b13..51a507561df6 100644
> --- a/include/uapi/drm/amdxdna_accel.h
> +++ b/include/uapi/drm/amdxdna_accel.h
> @@ -45,7 +45,8 @@ enum amdxdna_drm_ioctl_id {
>   	DRM_AMDXDNA_EXEC_CMD,
>   	DRM_AMDXDNA_GET_INFO,
>   	DRM_AMDXDNA_SET_STATE,
> -	DRM_AMDXDNA_GET_ARRAY = 10,
> +	DRM_AMDXDNA_WAIT_CMD,
> +	DRM_AMDXDNA_GET_ARRAY,
>   };
>   
>   /**
> @@ -274,6 +275,21 @@ struct amdxdna_drm_exec_cmd {
>   	__u64 seq;
>   };
>   
> +/**
> + * struct amdxdna_drm_wait_cmd - Wait execution command.
> + *
> + * @hwctx: Context handle.
> + * @timeout: timeout in ms, 0 implies infinite wait.
> + * @seq: sequence number of the command returned by execute command.
> + *
> + * Wait a command specified by seq to be completed.
> + */
> +struct amdxdna_drm_wait_cmd {
> +	__u32 hwctx;
> +	__u32 timeout;
> +	__u64 seq;
> +};
> +
>   /**
>    * struct amdxdna_drm_query_aie_status - Query the status of the AIE hardware
>    * @buffer: The user space buffer that will return the AIE status.
> @@ -739,6 +755,10 @@ struct amdxdna_drm_set_power_mode {
>   	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDXDNA_GET_ARRAY, \
>   		 struct amdxdna_drm_get_array)
>   
> +#define DRM_IOCTL_AMDXDNA_WAIT_CMD \
> +	DRM_IOW(DRM_COMMAND_BASE + DRM_AMDXDNA_WAIT_CMD, \
> +		struct amdxdna_drm_wait_cmd)
> +
>   #if defined(__cplusplus)
>   } /* extern c end */
>   #endif

