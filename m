Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD31CD3427
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 20:28:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63E5310E140;
	Tue,  5 May 2026 20:28:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ExXSNaLu";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4532610E140
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 20:28:03 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 900B46024D;
 Tue,  5 May 2026 20:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758E6C2BCB4;
 Tue,  5 May 2026 20:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778012882;
 bh=ihzValLwDTLFKZcp63tGGuNHowh+UdCvEb5P3HPPFQk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ExXSNaLuDVMLZey6lrKgL4E6a3Nkk/7DEsTuAUvEXvD4gaZN7TGE27iFsIK4XEMES
 ppM3mdEkQ0bJfX5TypG8/EnafQComZ5rUS/9lbidW5SMLqfjilMPUSr13sFRWA8vxh
 dBpTNhb+jAviHplNswy2tmUJsMDZOR8FFWhgOIBJmYSQt74qn1XTTHULJOqkfG/2FR
 Xp17NxMCn6Ouq+rMPdPTo/p+ye4uyyW/9qoNdoFjEQ4+thzLpbv0aRwgN/ZeM2Sgcj
 9aHmGko0H+SD2nHAER98SMROX0pXOiF8vVb2aUL9Q8B8EF9PLf1/Ro8RjeKx2A11cy
 VTgF+MDueJC8A==
Message-ID: <e87c5360-0aa9-45fb-ac3c-35b8f3203ba1@kernel.org>
Date: Tue, 5 May 2026 15:28:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 3/6] accel/amdxdna: Add AIE4 VF hardware context create
 and destroy
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 karol.wachowski@linux.intel.com
Cc: David Zhang <yidong.zhang@amd.com>, linux-kernel@vger.kernel.org,
 max.zhen@amd.com, sonal.santan@amd.com,
 Hayden Laccabue <Hayden.Laccabue@amd.com>
References: <20260505160936.3917732-1-lizhi.hou@amd.com>
 <20260505160936.3917732-4-lizhi.hou@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260505160936.3917732-4-lizhi.hou@amd.com>
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
> Implement hardware context creation and destruction for AIE4 VF devices.
> 
> Co-developed-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
> Signed-off-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
> Signed-off-by: David Zhang <yidong.zhang@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/accel/amdxdna/Makefile          |   1 +
>   drivers/accel/amdxdna/aie4_ctx.c        | 258 ++++++++++++++++++++++++
>   drivers/accel/amdxdna/aie4_host_queue.h |  22 ++
>   drivers/accel/amdxdna/aie4_msg_priv.h   |  29 +++
>   drivers/accel/amdxdna/aie4_pci.c        |   5 +
>   drivers/accel/amdxdna/aie4_pci.h        |  24 +++
>   drivers/accel/amdxdna/amdxdna_ctx.c     |   6 +
>   drivers/accel/amdxdna/amdxdna_ctx.h     |   3 +
>   include/uapi/drm/amdxdna_accel.h        |   1 +
>   9 files changed, 349 insertions(+)
>   create mode 100644 drivers/accel/amdxdna/aie4_ctx.c
>   create mode 100644 drivers/accel/amdxdna/aie4_host_queue.h
> 
> diff --git a/drivers/accel/amdxdna/Makefile b/drivers/accel/amdxdna/Makefile
> index d7720c8c8a98..05cce0a38692 100644
> --- a/drivers/accel/amdxdna/Makefile
> +++ b/drivers/accel/amdxdna/Makefile
> @@ -10,6 +10,7 @@ amdxdna-y := \
>   	aie2_pci.o \
>   	aie2_pm.o \
>   	aie2_solver.o \
> +	aie4_ctx.o \
>   	aie4_message.o \
>   	aie4_pci.o \
>   	amdxdna_cbuf.o \
> diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie4_ctx.c
> new file mode 100644
> index 000000000000..84ac706d0ffb
> --- /dev/null
> +++ b/drivers/accel/amdxdna/aie4_ctx.c
> @@ -0,0 +1,258 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026, Advanced Micro Devices, Inc.
> + */
> +
> +#include <drm/amdxdna_accel.h>
> +#include <drm/drm_device.h>
> +#include <drm/drm_gem.h>
> +#include <drm/drm_gem_shmem_helper.h>
> +#include <drm/drm_print.h>
> +#include <drm/gpu_scheduler.h>
> +#include <linux/types.h>
> +
> +#include "aie.h"
> +#include "aie4_host_queue.h"
> +#include "aie4_msg_priv.h"
> +#include "aie4_pci.h"
> +#include "amdxdna_ctx.h"
> +#include "amdxdna_gem.h"
> +#include "amdxdna_mailbox.h"
> +#include "amdxdna_mailbox_helper.h"
> +#include "amdxdna_pci_drv.h"
> +
> +static irqreturn_t cert_comp_isr(int irq, void *p)
> +{
> +	struct cert_comp *cert_comp = p;
> +
> +	wake_up_all(&cert_comp->waitq);
> +	return IRQ_HANDLED;
> +}
> +
> +static struct cert_comp *aie4_lookup_cert_comp(struct amdxdna_dev_hdl *ndev, u32 msix_idx)
> +{
> +	struct amdxdna_dev *xdna = ndev->aie.xdna;
> +	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
> +	struct cert_comp *cert_comp;
> +	int ret;
> +
> +	guard(mutex)(&ndev->cert_comp_lock);
> +
> +	cert_comp = xa_load(&ndev->cert_comp_xa, msix_idx);
> +	if (cert_comp) {
> +		kref_get(&cert_comp->kref);
> +		return cert_comp;
> +	}
> +
> +	cert_comp = kzalloc_obj(*cert_comp);
> +	if (!cert_comp)
> +		return NULL;
> +
> +	cert_comp->ndev = ndev;
> +	cert_comp->msix_idx = msix_idx;
> +	init_waitqueue_head(&cert_comp->waitq);
> +	kref_init(&cert_comp->kref);
> +
> +	ret = pci_irq_vector(pdev, cert_comp->msix_idx);
> +	if (ret < 0) {
> +		XDNA_ERR(xdna, "MSI-X idx %u is invalid, ret:%d", msix_idx, ret);
> +		goto free_cert_comp;
> +	}
> +	cert_comp->irq = ret;
> +
> +	ret = request_irq(cert_comp->irq, cert_comp_isr, 0, "xdna_hsa", cert_comp);
> +	if (ret) {
> +		XDNA_ERR(xdna, "request irq %d failed %d", cert_comp->irq, ret);
> +		goto free_cert_comp;
> +	}
> +
> +	ret = xa_err(xa_store(&ndev->cert_comp_xa, msix_idx, cert_comp, GFP_KERNEL));
> +	if (ret) {
> +		XDNA_ERR(xdna, "store cert_comp for msix idx %d failed %d", msix_idx, ret);
> +		goto free_irq;
> +	}
> +
> +	return cert_comp;
> +
> +free_irq:
> +	free_irq(cert_comp->irq, cert_comp);
> +free_cert_comp:
> +	kfree(cert_comp);
> +	return NULL;
> +}
> +
> +static void cert_comp_release(struct kref *kref)
> +{
> +	struct cert_comp *cert_comp = container_of(kref, struct cert_comp, kref);
> +	struct amdxdna_dev_hdl *ndev = cert_comp->ndev;
> +
> +	drm_WARN_ON(&ndev->aie.xdna->ddev, !mutex_is_locked(&ndev->cert_comp_lock));
> +
> +	xa_erase(&ndev->cert_comp_xa, cert_comp->msix_idx);
> +	free_irq(cert_comp->irq, cert_comp);
> +	kfree(cert_comp);
> +}
> +
> +static void aie4_put_cert_comp(struct cert_comp *cert_comp)
> +{
> +	struct amdxdna_dev_hdl *ndev;
> +
> +	ndev = cert_comp->ndev;
> +	guard(mutex)(&ndev->cert_comp_lock);
> +	kref_put(&cert_comp->kref, cert_comp_release);
> +}
> +
> +static int aie4_msg_destroy_context(struct amdxdna_dev_hdl *ndev, u32 hw_context_id)
> +{
> +	DECLARE_AIE_MSG(aie4_msg_destroy_hw_context, AIE4_MSG_OP_DESTROY_HW_CONTEXT);
> +
> +	req.hw_context_id = hw_context_id;
> +	return aie_send_mgmt_msg_wait(&ndev->aie, &msg);
> +}
> +
> +static int aie4_hwctx_create(struct amdxdna_hwctx *hwctx)
> +{
> +	DECLARE_AIE_MSG(aie4_msg_create_hw_context, AIE4_MSG_OP_CREATE_HW_CONTEXT);
> +	struct amdxdna_client *client = hwctx->client;
> +	struct amdxdna_hwctx_priv *priv = hwctx->priv;
> +	struct amdxdna_dev *xdna = hwctx->client->xdna;
> +	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
> +	int ret;
> +
> +	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
> +
> +	if (!ndev->partition_id || !hwctx->num_tiles) {
> +		XDNA_ERR(xdna, "invalid request partition_id %d, num_tiles %d",
> +			 ndev->partition_id, hwctx->num_tiles);
> +		return -EINVAL;
> +	}
> +
> +	req.partition_id = ndev->partition_id;
> +	req.request_num_tiles = hwctx->num_tiles;
> +	req.pasid = FIELD_PREP(AIE4_MSG_PASID, client->pasid) |
> +		FIELD_PREP(AIE4_MSG_PASID_VLD, 1);
> +	req.priority_band = hwctx->qos.priority;
> +
> +	req.hsa_addr_high = upper_32_bits(amdxdna_gem_dev_addr(priv->umq_bo));
> +	req.hsa_addr_low = lower_32_bits(amdxdna_gem_dev_addr(priv->umq_bo));
> +
> +	XDNA_DBG(xdna, "pasid 0x%x, num_tiles %d, hsa[0x%x 0x%x]",
> +		 req.pasid, req.request_num_tiles, req.hsa_addr_high, req.hsa_addr_low);
> +
> +	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
> +	if (ret) {
> +		XDNA_ERR(xdna, "create ctx failed: %d", ret);
> +		return ret;
> +	}
> +
> +	XDNA_DBG(xdna, "resp msix: %d, ctx id: %d, doorbell: %d",
> +		 resp.job_complete_msix_idx,
> +		 resp.hw_context_id,
> +		 resp.doorbell_offset);
> +
> +	/* setup interrupt completion per msix index */
> +	priv->cert_comp = aie4_lookup_cert_comp(ndev, resp.job_complete_msix_idx);
> +	if (!priv->cert_comp) {
> +		aie4_msg_destroy_context(ndev, resp.hw_context_id);
> +		return -EINVAL;
> +	}
> +
> +	priv->hw_ctx_id = resp.hw_context_id;
> +	hwctx->doorbell_offset = resp.doorbell_offset;
> +
> +	return 0;
> +}
> +
> +static void aie4_hwctx_destroy(struct amdxdna_hwctx *hwctx)
> +{
> +	struct amdxdna_client *client = hwctx->client;
> +	struct amdxdna_hwctx_priv *priv = hwctx->priv;
> +	struct amdxdna_dev *xdna = client->xdna;
> +	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
> +
> +	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
> +
> +	aie4_msg_destroy_context(ndev, priv->hw_ctx_id);
> +	aie4_put_cert_comp(priv->cert_comp);
> +}
> +
> +static void aie4_hwctx_umq_fini(struct amdxdna_hwctx *hwctx)
> +{
> +	if (hwctx->priv && hwctx->priv->umq_bo)
> +		amdxdna_gem_put_obj(hwctx->priv->umq_bo);
> +}
> +
> +static int aie4_hwctx_umq_init(struct amdxdna_hwctx *hwctx)
> +{
> +	struct amdxdna_hwctx_priv *priv = hwctx->priv;
> +	struct amdxdna_dev *xdna = hwctx->client->xdna;
> +	struct amdxdna_gem_obj *umq_bo;
> +	struct host_queue_header *qhdr;
> +	int ret;
> +
> +	umq_bo = amdxdna_gem_get_obj(hwctx->client, hwctx->umq_bo_hdl, AMDXDNA_BO_SHARE);
> +	if (!umq_bo) {
> +		XDNA_ERR(xdna, "cannot find umq_bo handle %d", hwctx->umq_bo_hdl);
> +		return -ENOENT;
> +	}
> +	if (umq_bo->mem.size < sizeof(*qhdr)) {
> +		XDNA_ERR(xdna, "umq_bo size is too small");
> +		ret = -EINVAL;
> +		goto put_umq_bo;
> +	}
> +
> +	/* get kva address for host queue read index and write index */
> +	qhdr = amdxdna_gem_vmap(umq_bo);
> +	if (!qhdr) {
> +		ret = -ENOMEM;
> +		goto put_umq_bo;
> +	}
> +
> +	priv->umq_bo = umq_bo;
> +	priv->umq_read_index = &qhdr->read_index;
> +	priv->umq_write_index = &qhdr->write_index;
> +
> +	return 0;
> +
> +put_umq_bo:
> +	amdxdna_gem_put_obj(umq_bo);
> +	return ret;
> +}
> +
> +int aie4_hwctx_init(struct amdxdna_hwctx *hwctx)
> +{
> +	struct amdxdna_client *client = hwctx->client;
> +	struct amdxdna_dev *xdna = client->xdna;
> +	struct amdxdna_hwctx_priv *priv;
> +	int ret;
> +
> +	priv = kzalloc_obj(*priv);
> +	if (!priv)
> +		return -ENOMEM;
> +	hwctx->priv = priv;
> +
> +	ret = aie4_hwctx_umq_init(hwctx);
> +	if (ret)
> +		goto free_priv;
> +
> +	ret = aie4_hwctx_create(hwctx);
> +	if (ret)
> +		goto umq_fini;
> +
> +	XDNA_DBG(xdna, "hwctx %s init completed", hwctx->name);
> +	return 0;
> +
> +umq_fini:
> +	aie4_hwctx_umq_fini(hwctx);
> +free_priv:
> +	kfree(priv);
> +	hwctx->priv = NULL;
> +	return ret;
> +}
> +
> +void aie4_hwctx_fini(struct amdxdna_hwctx *hwctx)
> +{
> +	aie4_hwctx_destroy(hwctx);
> +	aie4_hwctx_umq_fini(hwctx);
> +	kfree(hwctx->priv);
> +}
> diff --git a/drivers/accel/amdxdna/aie4_host_queue.h b/drivers/accel/amdxdna/aie4_host_queue.h
> new file mode 100644
> index 000000000000..eb6a38dfb53e
> --- /dev/null
> +++ b/drivers/accel/amdxdna/aie4_host_queue.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2026, Advanced Micro Devices, Inc.
> + */
> +
> +#ifndef _AIE4_HOST_QUEUE_H_
> +#define _AIE4_HOST_QUEUE_H_
> +
> +#include <linux/types.h>
> +
> +struct host_queue_header {
> +	__u64 read_index;
> +	struct {
> +		__u16 major;
> +		__u16 minor;
> +	} version;
> +	__u32 capacity; /* Queue capacity, must be power of two. */
> +	__u64 write_index;
> +	__u64 data_address; /* The xdna dev addr for payload. */
> +};
> +
> +#endif /* _AIE4_HOST_QUEUE_H_ */
> diff --git a/drivers/accel/amdxdna/aie4_msg_priv.h b/drivers/accel/amdxdna/aie4_msg_priv.h
> index cada53257921..7faa01ca3436 100644
> --- a/drivers/accel/amdxdna/aie4_msg_priv.h
> +++ b/drivers/accel/amdxdna/aie4_msg_priv.h
> @@ -16,6 +16,8 @@ enum aie4_msg_opcode {
>   
>   	AIE4_MSG_OP_CREATE_PARTITION                 = 0x30001,
>   	AIE4_MSG_OP_DESTROY_PARTITION                = 0x30002,
> +	AIE4_MSG_OP_CREATE_HW_CONTEXT                = 0x30003,
> +	AIE4_MSG_OP_DESTROY_HW_CONTEXT               = 0x30004,
>   };
>   
>   enum aie4_msg_status {
> @@ -67,4 +69,31 @@ struct aie4_msg_destroy_partition_resp {
>   	enum aie4_msg_status status;
>   } __packed;
>   
> +struct aie4_msg_create_hw_context_req {
> +	__u32 partition_id;
> +	__u32 request_num_tiles;
> +	__u32 hsa_addr_high;
> +	__u32 hsa_addr_low;
> +#define AIE4_MSG_PASID GENMASK(19, 0)
> +#define AIE4_MSG_PASID_VLD GENMASK(31, 31)
> +	__u32 pasid;
> +	__u32 priority_band;
> +} __packed;
> +
> +struct aie4_msg_create_hw_context_resp {
> +	enum aie4_msg_status status;
> +	__u32 hw_context_id;
> +	__u32 doorbell_offset;
> +	__u32 job_complete_msix_idx;
> +} __packed;
> +
> +struct aie4_msg_destroy_hw_context_req {
> +	__u32 hw_context_id;
> +	__u32 resvd1;
> +} __packed;
> +
> +struct aie4_msg_destroy_hw_context_resp {
> +	enum aie4_msg_status status;
> +} __packed;
> +
>   #endif /* _AIE4_MSG_PRIV_H_ */
> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
> index 13f5d45e388d..3be9066b7178 100644
> --- a/drivers/accel/amdxdna/aie4_pci.c
> +++ b/drivers/accel/amdxdna/aie4_pci.c
> @@ -451,6 +451,9 @@ static int aie4m_pcidev_init(struct amdxdna_dev *xdna)
>   	ndev->aie.xdna = xdna;
>   	xdna->dev_handle = ndev;
>   
> +	xa_init_flags(&ndev->cert_comp_xa, XA_FLAGS_ALLOC);
> +	mutex_init(&ndev->cert_comp_lock);
> +
>   	/* Enable managed PCI device */
>   	ret = pcim_enable_device(pdev);
>   	if (ret) {
> @@ -542,4 +545,6 @@ const struct amdxdna_dev_ops aie4_pf_ops = {
>   const struct amdxdna_dev_ops aie4_vf_ops = {
>   	.init			= aie4_vf_init,
>   	.fini			= aie4_vf_fini,
> +	.hwctx_init		= aie4_hwctx_init,
> +	.hwctx_fini		= aie4_hwctx_fini,
>   };
> diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
> index 620fb5bd23e4..6103007e6d2f 100644
> --- a/drivers/accel/amdxdna/aie4_pci.h
> +++ b/drivers/accel/amdxdna/aie4_pci.h
> @@ -13,6 +13,23 @@
>   #include "aie.h"
>   #include "amdxdna_mailbox.h"
>   
> +struct cert_comp {
> +	struct amdxdna_dev_hdl          *ndev;
> +	u32                             msix_idx;
> +	int                             irq;
> +	struct kref                     kref;
> +	wait_queue_head_t               waitq;
> +};
> +
> +struct amdxdna_hwctx_priv {
> +	struct amdxdna_gem_obj          *umq_bo;
> +	u64                             *umq_read_index;
> +	u64                             *umq_write_index;
> +
> +	struct cert_comp                *cert_comp;
> +	u32                             hw_ctx_id;
> +};
> +
>   struct amdxdna_dev_priv {
>   	const char              *npufw_path;
>   	const char              *certfw_path;
> @@ -32,11 +49,18 @@ struct amdxdna_dev_hdl {
>   
>   	struct mailbox			*mbox;
>   	u32				partition_id;
> +
> +	struct xarray                   cert_comp_xa; /* device level indexed by msix id */
> +	struct mutex                    cert_comp_lock; /* protects cert_comp operations*/
>   };
>   
>   /* aie4_message.c */
>   int aie4_suspend_fw(struct amdxdna_dev_hdl *ndev);
>   
> +/* aie4_ctx.c */
> +int aie4_hwctx_init(struct amdxdna_hwctx *hwctx);
> +void aie4_hwctx_fini(struct amdxdna_hwctx *hwctx);
> +
>   /* aie4_sriov.c */
>   #if IS_ENABLED(CONFIG_PCI_IOV)
>   int aie4_sriov_configure(struct amdxdna_dev *xdna, int num_vfs);
> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
> index 2c2c21992c87..b5ad60d4b734 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
> @@ -207,6 +207,9 @@ int amdxdna_drm_create_hwctx_ioctl(struct drm_device *dev, void *data, struct dr
>   	if (args->ext || args->ext_flags)
>   		return -EINVAL;
>   
> +	if (!xdna->dev_info->ops->hwctx_init)
> +		return -EOPNOTSUPP;
> +
>   	hwctx = kzalloc_obj(*hwctx);
>   	if (!hwctx)
>   		return -ENOMEM;
> @@ -220,6 +223,8 @@ int amdxdna_drm_create_hwctx_ioctl(struct drm_device *dev, void *data, struct dr
>   	hwctx->client = client;
>   	hwctx->fw_ctx_id = -1;
>   	hwctx->num_tiles = args->num_tiles;
> +	hwctx->umq_bo_hdl = args->umq_bo;
> +	hwctx->doorbell_offset = AMDXDNA_INVALID_DOORBELL_OFFSET;
>   	hwctx->mem_size = args->mem_size;
>   	hwctx->max_opc = args->max_opc;
>   
> @@ -252,6 +257,7 @@ int amdxdna_drm_create_hwctx_ioctl(struct drm_device *dev, void *data, struct dr
>   
>   	args->handle = hwctx->id;
>   	args->syncobj_handle = hwctx->syncobj_hdl;
> +	args->umq_doorbell = hwctx->doorbell_offset;
>   
>   	atomic64_set(&hwctx->job_submit_cnt, 0);
>   	atomic64_set(&hwctx->job_free_cnt, 0);
> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h b/drivers/accel/amdxdna/amdxdna_ctx.h
> index 355798687376..c5622718b4d5 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.h
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.h
> @@ -14,6 +14,7 @@ struct amdxdna_hwctx_priv;
>   
>   enum ert_cmd_opcode {
>   	ERT_START_CU = 0,
> +	ERT_START_DPU = 18,
>   	ERT_CMD_CHAIN = 19,
>   	ERT_START_NPU = 20,
>   	ERT_START_NPU_PREEMPT = 21,
> @@ -105,6 +106,8 @@ struct amdxdna_hwctx {
>   	u32				*col_list;
>   	u32				start_col;
>   	u32				num_col;
> +	u32				umq_bo_hdl;
> +	u32				doorbell_offset;
>   	u32				num_unused_col;
>   
>   	struct amdxdna_qos_info		     qos;
> diff --git a/include/uapi/drm/amdxdna_accel.h b/include/uapi/drm/amdxdna_accel.h
> index 34212feee15c..ad9b33dd7b13 100644
> --- a/include/uapi/drm/amdxdna_accel.h
> +++ b/include/uapi/drm/amdxdna_accel.h
> @@ -18,6 +18,7 @@ extern "C" {
>   #define AMDXDNA_INVALID_CTX_HANDLE	0
>   #define AMDXDNA_INVALID_BO_HANDLE	0
>   #define AMDXDNA_INVALID_FENCE_HANDLE	0
> +#define AMDXDNA_INVALID_DOORBELL_OFFSET	(~0U)
>   
>   /*
>    * Define hardware context priority

