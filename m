Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0B2FF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 20:37:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75AFF10E181;
	Tue,  5 May 2026 20:37:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YJgRS8sC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17EAB10E181
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 20:37:00 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D199C43CD9;
 Tue,  5 May 2026 20:36:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C61FC2BCB4;
 Tue,  5 May 2026 20:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778013419;
 bh=FaNreOkIE7Xy1Id0LHYvk8Iaii5p3fJ+4wCUNG74iSo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=YJgRS8sCWjQxs8mwT0UGag8AMCQHpIwuH43wKPeKS1tvboSu7fUcbsM5bmUmvdICU
 yIT/vm9eEnWFW7wNpA1VNkzl5EIa75trbupNIRscAkcCASbGJz0SvOGJCmOCExn8dL
 H9lgxTpZEIAelxIB+ttK0JjHxKpL18K+FQc8so72AxjoeQzCXNXoGpYL1A+/qTuxtH
 GcPw3UnxwsUurbd9rkyPVYWCYRtL313J+wLkR+S+JopH9f/XZRhy9hbEpuWwHkkG6Q
 WqPrXEdZ+RPFtNFRGlMjkf0ybUkQZeD3citwImzI6E5rvF7OK57GLLZlCzDXgNOkU/
 PSYFpxZWn80Ww==
Message-ID: <1cc48158-f443-45d3-811b-f5957726a898@kernel.org>
Date: Tue, 5 May 2026 15:36:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 6/6] accel/amdxdna: Add AIE4 work buffer initialization
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 karol.wachowski@linux.intel.com
Cc: Nishad Saraf <nishads@amd.com>, linux-kernel@vger.kernel.org,
 max.zhen@amd.com, sonal.santan@amd.com
References: <20260505160936.3917732-1-lizhi.hou@amd.com>
 <20260505160936.3917732-7-lizhi.hou@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260505160936.3917732-7-lizhi.hou@amd.com>
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
> From: Nishad Saraf <nishads@amd.com>
> 
> NPU firmware requires a host-allocated work buffer for hardware contexts.
> Allocate a 4 MB host buffer and attach it to device during device init.
> 
> Refactor aie2_alloc_msg_buffer() and aie2_free_msg_buffer() into common
> helpers by moving them to aie.c and renaming them to
> amdxdna_alloc_msg_buffer() and amdxdna_free_msg_buffer(), allowing both
> AIE2 and AIE4 to reuse the implementation.
> 
> Signed-off-by: Nishad Saraf <nishads@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/accel/amdxdna/aie.c             | 34 +++++++++++++++
>   drivers/accel/amdxdna/aie.h             |  4 ++
>   drivers/accel/amdxdna/aie2_error.c      |  7 ++--
>   drivers/accel/amdxdna/aie2_message.c    | 49 +++-------------------
>   drivers/accel/amdxdna/aie2_pci.h        |  4 --
>   drivers/accel/amdxdna/aie4_message.c    | 18 ++++++++
>   drivers/accel/amdxdna/aie4_msg_priv.h   | 14 +++++++
>   drivers/accel/amdxdna/aie4_pci.c        | 55 ++++++++++++++++++++++++-
>   drivers/accel/amdxdna/aie4_pci.h        |  5 +++
>   drivers/accel/amdxdna/amdxdna_pci_drv.c |  3 +-
>   10 files changed, 141 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/aie.c b/drivers/accel/amdxdna/aie.c
> index a31051cc1ec8..4db2fd80a032 100644
> --- a/drivers/accel/amdxdna/aie.c
> +++ b/drivers/accel/amdxdna/aie.c
> @@ -162,3 +162,37 @@ int amdxdna_get_metadata(struct aie_device *aie,
>   	kfree(meta);
>   	return ret;
>   }
> +
> +void *amdxdna_alloc_msg_buffer(struct amdxdna_dev *xdna, u32 *size,
> +			       dma_addr_t *dma_addr)
> +{
> +	void *vaddr;
> +	int order;
> +
> +	*size = max_t(u32, *size, SZ_8K);
> +	order = get_order(*size);
> +	if (order > MAX_PAGE_ORDER)
> +		return ERR_PTR(-EINVAL);
> +	*size = PAGE_SIZE << order;
> +
> +	if (amdxdna_iova_on(xdna))
> +		return amdxdna_iommu_alloc(xdna, *size, dma_addr);
> +
> +	vaddr = dma_alloc_noncoherent(xdna->ddev.dev, *size, dma_addr,
> +				      DMA_FROM_DEVICE, GFP_KERNEL);
> +	if (!vaddr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	return vaddr;
> +}
> +
> +void amdxdna_free_msg_buffer(struct amdxdna_dev *xdna, size_t size,
> +			     void *cpu_addr, dma_addr_t dma_addr)
> +{
> +	if (amdxdna_iova_on(xdna)) {
> +		amdxdna_iommu_free(xdna, size, cpu_addr, dma_addr);
> +		return;
> +	}
> +
> +	dma_free_noncoherent(xdna->ddev.dev, size, cpu_addr, dma_addr, DMA_FROM_DEVICE);
> +}
> diff --git a/drivers/accel/amdxdna/aie.h b/drivers/accel/amdxdna/aie.h
> index 4bb3719ee0c0..70618204c0ab 100644
> --- a/drivers/accel/amdxdna/aie.h
> +++ b/drivers/accel/amdxdna/aie.h
> @@ -121,6 +121,10 @@ int aie_check_protocol(struct aie_device *aie, u32 fw_major, u32 fw_minor);
>   void amdxdna_vbnv_init(struct amdxdna_dev *xdna);
>   int amdxdna_get_metadata(struct aie_device *aie, struct amdxdna_client *client,
>   			 struct amdxdna_drm_get_info *args);
> +void *amdxdna_alloc_msg_buffer(struct amdxdna_dev *xdna, u32 *size,
> +			       dma_addr_t *dma_addr);
> +void amdxdna_free_msg_buffer(struct amdxdna_dev *xdna, size_t size,
> +			     void *cpu_addr, dma_addr_t dma_addr);
>   
>   /* aie_psp.c */
>   struct psp_device *aiem_psp_create(struct drm_device *ddev, struct psp_config *conf);
> diff --git a/drivers/accel/amdxdna/aie2_error.c b/drivers/accel/amdxdna/aie2_error.c
> index 70007b4363cd..babdac0157ab 100644
> --- a/drivers/accel/amdxdna/aie2_error.c
> +++ b/drivers/accel/amdxdna/aie2_error.c
> @@ -11,6 +11,7 @@
>   #include <linux/kthread.h>
>   #include <linux/kernel.h>
>   
> +#include "aie.h"
>   #include "aie2_msg_priv.h"
>   #include "aie2_pci.h"
>   #include "amdxdna_error.h"
> @@ -338,7 +339,7 @@ void aie2_error_async_events_free(struct amdxdna_dev_hdl *ndev)
>   	destroy_workqueue(events->wq);
>   	mutex_lock(&xdna->dev_lock);
>   
> -	aie2_free_msg_buffer(ndev, events->size, events->buf, events->addr);
> +	amdxdna_free_msg_buffer(xdna, events->size, events->buf, events->addr);
>   	kfree(events);
>   }
>   
> @@ -354,7 +355,7 @@ int aie2_error_async_events_alloc(struct amdxdna_dev_hdl *ndev)
>   	if (!events)
>   		return -ENOMEM;
>   
> -	events->buf = aie2_alloc_msg_buffer(ndev, &total_size, &events->addr);
> +	events->buf = amdxdna_alloc_msg_buffer(xdna, &total_size, &events->addr);
>   	if (IS_ERR(events->buf)) {
>   		ret = PTR_ERR(events->buf);
>   		goto free_events;
> @@ -394,7 +395,7 @@ int aie2_error_async_events_alloc(struct amdxdna_dev_hdl *ndev)
>   free_wq:
>   	destroy_workqueue(events->wq);
>   free_buf:
> -	aie2_free_msg_buffer(ndev, events->size, events->buf, events->addr);
> +	amdxdna_free_msg_buffer(xdna, events->size, events->buf, events->addr);
>   free_events:
>   	kfree(events);
>   	return ret;
> diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
> index f555ffecea6f..0417c6a4c80a 100644
> --- a/drivers/accel/amdxdna/aie2_message.c
> +++ b/drivers/accel/amdxdna/aie2_message.c
> @@ -27,43 +27,6 @@
>   
>   #define EXEC_MSG_OPS(xdna)	((xdna)->dev_handle->exec_msg_ops)
>   
> -void *aie2_alloc_msg_buffer(struct amdxdna_dev_hdl *ndev, u32 *size,
> -			    dma_addr_t *dma_addr)
> -{
> -	struct amdxdna_dev *xdna = ndev->aie.xdna;
> -	void *vaddr;
> -	int order;
> -
> -	*size = max(*size, SZ_8K);
> -	order = get_order(*size);
> -	if (order > MAX_PAGE_ORDER)
> -		return ERR_PTR(-EINVAL);
> -	*size = PAGE_SIZE << order;
> -
> -	if (amdxdna_iova_on(xdna))
> -		return amdxdna_iommu_alloc(xdna, *size, dma_addr);
> -
> -	vaddr = dma_alloc_noncoherent(xdna->ddev.dev, *size, dma_addr,
> -				      DMA_FROM_DEVICE, GFP_KERNEL);
> -	if (!vaddr)
> -		return ERR_PTR(-ENOMEM);
> -
> -	return vaddr;
> -}
> -
> -void aie2_free_msg_buffer(struct amdxdna_dev_hdl *ndev, size_t size,
> -			  void *cpu_addr, dma_addr_t dma_addr)
> -{
> -	struct amdxdna_dev *xdna = ndev->aie.xdna;
> -
> -	if (amdxdna_iova_on(xdna)) {
> -		amdxdna_iommu_free(xdna, size, cpu_addr, dma_addr);
> -		return;
> -	}
> -
> -	dma_free_noncoherent(xdna->ddev.dev, size, cpu_addr, dma_addr, DMA_FROM_DEVICE);
> -}
> -
>   int aie2_suspend_fw(struct amdxdna_dev_hdl *ndev)
>   {
>   	DECLARE_AIE_MSG(suspend, MSG_OP_SUSPEND);
> @@ -376,7 +339,7 @@ int aie2_query_status(struct amdxdna_dev_hdl *ndev, char __user *buf,
>   	int ret;
>   
>   	buf_sz = ndev->aie.metadata.cols * ndev->aie.metadata.size;
> -	buff_addr = aie2_alloc_msg_buffer(ndev, &buf_sz, &dma_addr);
> +	buff_addr = amdxdna_alloc_msg_buffer(xdna, &buf_sz, &dma_addr);
>   	if (IS_ERR(buff_addr))
>   		return PTR_ERR(buff_addr);
>   
> @@ -415,7 +378,7 @@ int aie2_query_status(struct amdxdna_dev_hdl *ndev, char __user *buf,
>   	*cols_filled = aie_bitmap;
>   
>   fail:
> -	aie2_free_msg_buffer(ndev, buf_sz, buff_addr, dma_addr);
> +	amdxdna_free_msg_buffer(xdna, buf_sz, buff_addr, dma_addr);
>   	return ret;
>   }
>   
> @@ -434,7 +397,7 @@ int aie2_query_telemetry(struct amdxdna_dev_hdl *ndev,
>   		return -EINVAL;
>   
>   	buf_sz = min(size, SZ_4M);
> -	addr = aie2_alloc_msg_buffer(ndev, &buf_sz, &dma_addr);
> +	addr = amdxdna_alloc_msg_buffer(xdna, &buf_sz, &dma_addr);
>   	if (IS_ERR(addr))
>   		return PTR_ERR(addr);
>   
> @@ -466,7 +429,7 @@ int aie2_query_telemetry(struct amdxdna_dev_hdl *ndev,
>   	header->minor = resp.minor;
>   
>   free_buf:
> -	aie2_free_msg_buffer(ndev, buf_sz, addr, dma_addr);
> +	amdxdna_free_msg_buffer(xdna, buf_sz, addr, dma_addr);
>   	return ret;
>   }
>   
> @@ -1176,7 +1139,7 @@ int aie2_query_app_health(struct amdxdna_dev_hdl *ndev, u32 context_id,
>   	}
>   
>   	buf_size = sizeof(*report);
> -	buf = aie2_alloc_msg_buffer(ndev, &buf_size, &dma_addr);
> +	buf = amdxdna_alloc_msg_buffer(xdna, &buf_size, &dma_addr);
>   	if (IS_ERR(buf)) {
>   		XDNA_ERR(xdna, "Failed to allocate buffer for app health");
>   		return PTR_ERR(buf);
> @@ -1197,7 +1160,7 @@ int aie2_query_app_health(struct amdxdna_dev_hdl *ndev, u32 context_id,
>   	memcpy(report, buf, sizeof(*report));
>   
>   free_buf:
> -	aie2_free_msg_buffer(ndev, buf_size, buf, dma_addr);
> +	amdxdna_free_msg_buffer(xdna, buf_size, buf, dma_addr);
>   	return ret;
>   }
>   
> diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
> index c884fed610f9..33b6c84e8b6e 100644
> --- a/drivers/accel/amdxdna/aie2_pci.h
> +++ b/drivers/accel/amdxdna/aie2_pci.h
> @@ -290,10 +290,6 @@ int aie2_sync_bo(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job,
>   int aie2_config_debug_bo(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job,
>   			 int (*notify_cb)(void *, void __iomem *, size_t));
>   int aie2_update_prop_time_quota(struct amdxdna_dev_hdl *ndev, u32 us);
> -void *aie2_alloc_msg_buffer(struct amdxdna_dev_hdl *ndev, u32 *size,
> -			    dma_addr_t *dma_addr);
> -void aie2_free_msg_buffer(struct amdxdna_dev_hdl *ndev, size_t size,
> -			  void *cpu_addr, dma_addr_t dma_addr);
>   
>   /* aie2_hwctx.c */
>   int aie2_hwctx_init(struct amdxdna_hwctx *hwctx);
> diff --git a/drivers/accel/amdxdna/aie4_message.c b/drivers/accel/amdxdna/aie4_message.c
> index ac89a9a842b2..d85df04c5f6b 100644
> --- a/drivers/accel/amdxdna/aie4_message.c
> +++ b/drivers/accel/amdxdna/aie4_message.c
> @@ -62,3 +62,21 @@ int aie4_query_aie_metadata(struct amdxdna_dev_hdl *ndev, struct aie_metadata *m
>   
>   	return 0;
>   }
> +
> +int aie4_attach_work_buffer(struct amdxdna_dev_hdl *ndev)
> +{
> +	DECLARE_AIE_MSG(aie4_msg_attach_work_buffer, AIE4_MSG_OP_ATTACH_WORK_BUFFER);
> +	struct amdxdna_dev *xdna = ndev->aie.xdna;
> +	int ret;
> +
> +	req.buff_addr = ndev->work_buf_addr;
> +	req.buff_size = AIE4_WORK_BUFFER_MIN_SIZE;
> +
> +	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
> +	if (ret)
> +		XDNA_ERR(xdna, "Failed to attach work buffer, ret %d", ret);
> +	else
> +		XDNA_DBG(xdna, "Attached work buffer");
> +
> +	return ret;
> +}
> diff --git a/drivers/accel/amdxdna/aie4_msg_priv.h b/drivers/accel/amdxdna/aie4_msg_priv.h
> index 69e220e40900..af0866045b91 100644
> --- a/drivers/accel/amdxdna/aie4_msg_priv.h
> +++ b/drivers/accel/amdxdna/aie4_msg_priv.h
> @@ -6,10 +6,12 @@
>   #ifndef _AIE4_MSG_PRIV_H_
>   #define _AIE4_MSG_PRIV_H_
>   
> +#include <linux/sizes.h>
>   #include <linux/types.h>
>   
>   enum aie4_msg_opcode {
>   	AIE4_MSG_OP_SUSPEND                          = 0x10003,
> +	AIE4_MSG_OP_ATTACH_WORK_BUFFER               = 0x1000D,
>   
>   	AIE4_MSG_OP_CREATE_VFS                       = 0x20001,
>   	AIE4_MSG_OP_DESTROY_VFS                      = 0x20002,
> @@ -130,4 +132,16 @@ struct aie4_msg_aie4_tile_info_resp {
>   	struct aie4_tile_info info;
>   } __packed;
>   
> +#define AIE4_WORK_BUFFER_MIN_SIZE      SZ_4M
> +
> +struct aie4_msg_attach_work_buffer_req {
> +	__u64 buff_addr;
> +	__u32 reserved;
> +	__u32 buff_size;
> +} __packed;
> +
> +struct aie4_msg_attach_work_buffer_resp {
> +	enum aie4_msg_status status;
> +} __packed;
> +
>   #endif /* _AIE4_MSG_PRIV_H_ */
> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
> index 8b5eff0e45c1..a58a83af42a4 100644
> --- a/drivers/accel/amdxdna/aie4_pci.c
> +++ b/drivers/accel/amdxdna/aie4_pci.c
> @@ -286,8 +286,14 @@ static int aie4_pf_hw_start(struct amdxdna_dev_hdl *ndev)
>   	if (ret)
>   		goto stop_fw;
>   
> +	ret = aie4_attach_work_buffer(ndev);
> +	if (ret)
> +		goto mbox_fini;
> +
>   	return 0;
>   
> +mbox_fini:
> +	aie4_mailbox_fini(ndev);
>   stop_fw:
>   	aie4_fw_stop(ndev);
>   
> @@ -564,6 +570,40 @@ static int aie4_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_i
>   	return ret;
>   }
>   
> +static int aie4_alloc_work_buffer(struct amdxdna_dev_hdl *ndev)
> +{
> +	struct amdxdna_dev *xdna = ndev->aie.xdna;
> +	u32 buf_size = AIE4_WORK_BUFFER_MIN_SIZE;
> +
> +	ndev->work_buf = amdxdna_alloc_msg_buffer(xdna, &buf_size,
> +						  &ndev->work_buf_addr);
> +	if (IS_ERR(ndev->work_buf)) {
> +		int ret = PTR_ERR(ndev->work_buf);
> +
> +		XDNA_ERR(xdna, "Failed to alloc work buffer, size 0x%x",
> +			 AIE4_WORK_BUFFER_MIN_SIZE);
> +		ndev->work_buf = NULL;
> +		return ret;
> +	}
> +
> +	ndev->work_buf_size = buf_size;
> +	XDNA_DBG(xdna, "Work buffer allocated: size 0x%x", buf_size);
> +
> +	return 0;
> +}
> +
> +static void aie4_free_work_buffer(struct amdxdna_dev_hdl *ndev)
> +{
> +	struct amdxdna_dev *xdna = ndev->aie.xdna;
> +
> +	if (!ndev->work_buf)
> +		return;
> +
> +	amdxdna_free_msg_buffer(xdna, ndev->work_buf_size, ndev->work_buf,
> +				ndev->work_buf_addr);
> +	ndev->work_buf = NULL;
> +}
> +
>   static int aie4_pf_init(struct amdxdna_dev *xdna)
>   {
>   	int ret;
> @@ -572,7 +612,19 @@ static int aie4_pf_init(struct amdxdna_dev *xdna)
>   	if (ret)
>   		return ret;
>   
> -	return aie4_pf_hw_start(xdna->dev_handle);
> +	ret = aie4_alloc_work_buffer(xdna->dev_handle);
> +	if (ret)
> +		return ret;
> +
> +	ret = aie4_pf_hw_start(xdna->dev_handle);
> +	if (ret)
> +		goto free_work_buf;
> +
> +	return 0;
> +
> +free_work_buf:
> +	aie4_free_work_buffer(xdna->dev_handle);
> +	return ret;
>   }
>   
>   static int aie4_vf_init(struct amdxdna_dev *xdna)
> @@ -590,6 +642,7 @@ static void aie4_pf_fini(struct amdxdna_dev *xdna)
>   {
>   	aie4_sriov_stop(xdna->dev_handle);
>   	aie4_pf_hw_stop(xdna->dev_handle);
> +	aie4_free_work_buffer(xdna->dev_handle);
>   }
>   
>   static void aie4_vf_fini(struct amdxdna_dev *xdna)
> diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
> index 1886cffc62db..390864876ca5 100644
> --- a/drivers/accel/amdxdna/aie4_pci.h
> +++ b/drivers/accel/amdxdna/aie4_pci.h
> @@ -53,11 +53,16 @@ struct amdxdna_dev_hdl {
>   
>   	struct xarray                   cert_comp_xa; /* device level indexed by msix id */
>   	struct mutex                    cert_comp_lock; /* protects cert_comp operations*/
> +
> +	void				*work_buf;
> +	dma_addr_t			work_buf_addr;
> +	u32				work_buf_size;
>   };
>   
>   /* aie4_message.c */
>   int aie4_query_aie_metadata(struct amdxdna_dev_hdl *ndev, struct aie_metadata *metadata);
>   int aie4_suspend_fw(struct amdxdna_dev_hdl *ndev);
> +int aie4_attach_work_buffer(struct amdxdna_dev_hdl *ndev);
>   
>   /* aie4_ctx.c */
>   int aie4_hwctx_init(struct amdxdna_hwctx *hwctx);
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> index c0d00db25cde..a6e9be7960c2 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> @@ -40,9 +40,10 @@ MODULE_FIRMWARE("amdnpu/17f0_11/npu_7.sbin");
>    * 0.7: Support getting power and utilization data
>    * 0.8: Support BO usage query
>    * 0.9: Add new device type AMDXDNA_DEV_TYPE_PF
> + * 0.10: Support AIE4 UMQ
>    */
>   #define AMDXDNA_DRIVER_MAJOR		0
> -#define AMDXDNA_DRIVER_MINOR		9
> +#define AMDXDNA_DRIVER_MINOR		10
>   
>   /*
>    * Bind the driver base on (vendor_id, device_id) pair and later use the

