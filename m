Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 363A9CD3442
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 17:03:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F22F10F295;
	Thu,  7 May 2026 17:03:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="edw31bHw";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82E9410F294
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 17:03:35 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4475D43384;
 Thu,  7 May 2026 17:03:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BE5C2BCC9;
 Thu,  7 May 2026 17:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778173415;
 bh=JHGmbQ8mku9Hk9s8+StqirJkXSo850yg5Fw4XHu334g=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=edw31bHwdZ9FZAAxl4wjDPJdzjFxHIkAq7jm39zvc5yFEp3L59o07GfBtINJaksNz
 yteF2lSSCiUhQaW6OYvYCuvIDxtYt6VIr6SqzR6dOlQI0qfdtzktZ/YcVAhR/ZtUJa
 cUP0hJFnvN3B1ZZp9WdRYkORb3QQWaL8TwDLHpn3rGN0t3uS6wI1LyArG6ARDMVeBB
 CX0NfL0GuoNQ0CTEIopb/egDtVpTZ7O+blycyVrANofaWia9oi4QxqVStl+ks+nF1+
 7IWaMHqLJsBEEh1wtBVEoJPrZlMStPWsnA00XXe14EhVgwU+BT0k6O8nStOu9lVLnb
 Z9nhP3jm/oteg==
Message-ID: <61214a05-2110-4e04-8f79-a30d7da0a45c@kernel.org>
Date: Thu, 7 May 2026 12:03:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 5/6] accel/amdxdna: Add AIE4 metadata query support
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 karol.wachowski@linux.intel.com
Cc: David Zhang <yidong.zhang@amd.com>, linux-kernel@vger.kernel.org,
 max.zhen@amd.com, sonal.santan@amd.com,
 Hayden Laccabue <Hayden.Laccabue@amd.com>
References: <20260506161642.141257-1-lizhi.hou@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260506161642.141257-1-lizhi.hou@amd.com>
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



On 5/6/26 11:16, Lizhi Hou wrote:
> From: David Zhang <yidong.zhang@amd.com>
> 
> Add support for querying device metadata on AIE4 via a mailbox message.
> Refactor aie2_get_aie_metadata() into a common helper by moving it to
> aie.c and renaming it to amdxdna_get_metadata(), allowing both AIE2
> and AIE4 to reuse the implementation.
> 
> Co-developed-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
> Signed-off-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
> Signed-off-by: David Zhang <yidong.zhang@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Thanks, much better!

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/accel/amdxdna/aie.c           | 14 +++++++
>   drivers/accel/amdxdna/aie.h           |  5 +++
>   drivers/accel/amdxdna/aie2_ctx.c      |  4 +-
>   drivers/accel/amdxdna/aie2_message.c  | 10 +++--
>   drivers/accel/amdxdna/aie2_pci.c      | 54 ++-------------------------
>   drivers/accel/amdxdna/aie2_pci.h      | 32 +++-------------
>   drivers/accel/amdxdna/aie4_message.c  | 38 +++++++++++++++++++
>   drivers/accel/amdxdna/aie4_msg_priv.h | 34 +++++++++++++++++
>   drivers/accel/amdxdna/aie4_pci.c      | 30 +++++++++++++++
>   drivers/accel/amdxdna/aie4_pci.h      |  2 +
>   10 files changed, 140 insertions(+), 83 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/aie.c b/drivers/accel/amdxdna/aie.c
> index 66849ba9026a..94747fb72340 100644
> --- a/drivers/accel/amdxdna/aie.c
> +++ b/drivers/accel/amdxdna/aie.c
> @@ -117,3 +117,17 @@ void amdxdna_vbnv_init(struct amdxdna_dev *xdna)
>   
>   	amdxdna_update_vbnv(xdna, info->rev_vbnv_tbl, rev);
>   }
> +
> +int amdxdna_get_metadata(struct aie_device *aie,
> +			 struct amdxdna_client *client,
> +			 struct amdxdna_drm_get_info *args)
> +{
> +	int ret = 0;
> +	u32 buf_sz;
> +
> +	buf_sz = min(args->buffer_size, sizeof(aie->metadata));
> +	if (copy_to_user(u64_to_user_ptr(args->buffer), &aie->metadata, buf_sz))
> +		ret = -EFAULT;
> +
> +	return ret;
> +}
> diff --git a/drivers/accel/amdxdna/aie.h b/drivers/accel/amdxdna/aie.h
> index 7a68b114f235..cca0cfdeee1a 100644
> --- a/drivers/accel/amdxdna/aie.h
> +++ b/drivers/accel/amdxdna/aie.h
> @@ -5,6 +5,7 @@
>   #ifndef _AIE_H_
>   #define _AIE_H_
>   
> +#include <drm/amdxdna_accel.h>
>   #include "amdxdna_pci_drv.h"
>   #include "amdxdna_mailbox.h"
>   
> @@ -26,6 +27,8 @@ struct aie_device {
>   
>   	struct psp_device *psp_hdl;
>   	struct smu_device *smu_hdl;
> +
> +	struct amdxdna_drm_query_aie_metadata metadata;
>   };
>   
>   #define DECLARE_AIE_MSG(name, op) \
> @@ -94,6 +97,8 @@ void aie_destroy_chann(struct aie_device *aie, struct mailbox_channel **chann);
>   int aie_send_mgmt_msg_wait(struct aie_device *aie, struct xdna_mailbox_msg *msg);
>   int aie_check_protocol(struct aie_device *aie, u32 fw_major, u32 fw_minor);
>   void amdxdna_vbnv_init(struct amdxdna_dev *xdna);
> +int amdxdna_get_metadata(struct aie_device *aie, struct amdxdna_client *client,
> +			 struct amdxdna_drm_get_info *args);
>   
>   /* aie_psp.c */
>   struct psp_device *aiem_psp_create(struct drm_device *ddev, struct psp_config *conf);
> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
> index 139825ac8515..7d6094aefb6f 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -489,12 +489,12 @@ static int aie2_hwctx_col_list(struct amdxdna_hwctx *hwctx)
>   	}
>   
>   	ndev = xdna->dev_handle;
> -	if (unlikely(!ndev->metadata.core.row_count)) {
> +	if (unlikely(!ndev->aie.metadata.core.row_count)) {
>   		XDNA_WARN(xdna, "Core tile row count is zero");
>   		return -EINVAL;
>   	}
>   
> -	hwctx->num_col = hwctx->num_tiles / ndev->metadata.core.row_count;
> +	hwctx->num_col = hwctx->num_tiles / ndev->aie.metadata.core.row_count;
>   	if (!hwctx->num_col || hwctx->num_col > ndev->total_col) {
>   		XDNA_ERR(xdna, "Invalid num_col %d", hwctx->num_col);
>   		return -EINVAL;
> diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
> index 6e98af7b74db..bbe701ad5574 100644
> --- a/drivers/accel/amdxdna/aie2_message.c
> +++ b/drivers/accel/amdxdna/aie2_message.c
> @@ -127,7 +127,8 @@ int aie2_assign_mgmt_pasid(struct amdxdna_dev_hdl *ndev, u16 pasid)
>   	return aie_send_mgmt_msg_wait(&ndev->aie, &msg);
>   }
>   
> -int aie2_query_aie_version(struct amdxdna_dev_hdl *ndev, struct aie_version *version)
> +int aie2_query_aie_version(struct amdxdna_dev_hdl *ndev,
> +			   struct amdxdna_drm_query_aie_version *version)
>   {
>   	DECLARE_AIE_MSG(aie_version_info, MSG_OP_QUERY_AIE_VERSION);
>   	struct amdxdna_dev *xdna = ndev->aie.xdna;
> @@ -146,7 +147,8 @@ int aie2_query_aie_version(struct amdxdna_dev_hdl *ndev, struct aie_version *ver
>   	return 0;
>   }
>   
> -int aie2_query_aie_metadata(struct amdxdna_dev_hdl *ndev, struct aie_metadata *metadata)
> +int aie2_query_aie_metadata(struct amdxdna_dev_hdl *ndev,
> +			    struct amdxdna_drm_query_aie_metadata *metadata)
>   {
>   	DECLARE_AIE_MSG(aie_tile_info, MSG_OP_QUERY_AIE_TILE_INFO);
>   	int ret;
> @@ -155,7 +157,7 @@ int aie2_query_aie_metadata(struct amdxdna_dev_hdl *ndev, struct aie_metadata *m
>   	if (ret)
>   		return ret;
>   
> -	metadata->size = resp.info.size;
> +	metadata->col_size = resp.info.size;
>   	metadata->cols = resp.info.cols;
>   	metadata->rows = resp.info.rows;
>   
> @@ -375,7 +377,7 @@ int aie2_query_status(struct amdxdna_dev_hdl *ndev, char __user *buf,
>   	u8 *buff_addr;
>   	int ret;
>   
> -	buf_sz = ndev->metadata.cols * ndev->metadata.size;
> +	buf_sz = ndev->aie.metadata.cols * ndev->aie.metadata.col_size;
>   	buff_addr = aie2_alloc_msg_buffer(ndev, &buf_sz, &dma_addr);
>   	if (IS_ERR(buff_addr))
>   		return PTR_ERR(buff_addr);
> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
> index f0ddb843eb21..6c8a0f70b73d 100644
> --- a/drivers/accel/amdxdna/aie2_pci.c
> +++ b/drivers/accel/amdxdna/aie2_pci.c
> @@ -219,13 +219,13 @@ static int aie2_mgmt_fw_query(struct amdxdna_dev_hdl *ndev)
>   		return ret;
>   	}
>   
> -	ret = aie2_query_aie_metadata(ndev, &ndev->metadata);
> +	ret = aie2_query_aie_metadata(ndev, &ndev->aie.metadata);
>   	if (ret) {
>   		XDNA_ERR(ndev->aie.xdna, "Query AIE metadata failed");
>   		return ret;
>   	}
>   
> -	ndev->total_col = min(aie2_max_col, ndev->metadata.cols);
> +	ndev->total_col = min(aie2_max_col, ndev->aie.metadata.cols);
>   
>   	return 0;
>   }
> @@ -658,53 +658,6 @@ static int aie2_get_aie_status(struct amdxdna_client *client,
>   	return 0;
>   }
>   
> -static int aie2_get_aie_metadata(struct amdxdna_client *client,
> -				 struct amdxdna_drm_get_info *args)
> -{
> -	struct amdxdna_drm_query_aie_metadata *meta;
> -	struct amdxdna_dev *xdna = client->xdna;
> -	struct amdxdna_dev_hdl *ndev;
> -	int ret = 0;
> -	u32 buf_sz;
> -
> -	ndev = xdna->dev_handle;
> -	meta = kzalloc_obj(*meta);
> -	if (!meta)
> -		return -ENOMEM;
> -
> -	meta->col_size = ndev->metadata.size;
> -	meta->cols = ndev->metadata.cols;
> -	meta->rows = ndev->metadata.rows;
> -
> -	meta->version.major = ndev->metadata.version.major;
> -	meta->version.minor = ndev->metadata.version.minor;
> -
> -	meta->core.row_count = ndev->metadata.core.row_count;
> -	meta->core.row_start = ndev->metadata.core.row_start;
> -	meta->core.dma_channel_count = ndev->metadata.core.dma_channel_count;
> -	meta->core.lock_count = ndev->metadata.core.lock_count;
> -	meta->core.event_reg_count = ndev->metadata.core.event_reg_count;
> -
> -	meta->mem.row_count = ndev->metadata.mem.row_count;
> -	meta->mem.row_start = ndev->metadata.mem.row_start;
> -	meta->mem.dma_channel_count = ndev->metadata.mem.dma_channel_count;
> -	meta->mem.lock_count = ndev->metadata.mem.lock_count;
> -	meta->mem.event_reg_count = ndev->metadata.mem.event_reg_count;
> -
> -	meta->shim.row_count = ndev->metadata.shim.row_count;
> -	meta->shim.row_start = ndev->metadata.shim.row_start;
> -	meta->shim.dma_channel_count = ndev->metadata.shim.dma_channel_count;
> -	meta->shim.lock_count = ndev->metadata.shim.lock_count;
> -	meta->shim.event_reg_count = ndev->metadata.shim.event_reg_count;
> -
> -	buf_sz = min(args->buffer_size, sizeof(*meta));
> -	if (copy_to_user(u64_to_user_ptr(args->buffer), meta, buf_sz))
> -		ret = -EFAULT;
> -
> -	kfree(meta);
> -	return ret;
> -}
> -
>   static int aie2_get_aie_version(struct amdxdna_client *client,
>   				struct amdxdna_drm_get_info *args)
>   {
> @@ -1039,6 +992,7 @@ static int aie2_get_preempt_state(struct amdxdna_client *client,
>   static int aie2_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_info *args)
>   {
>   	struct amdxdna_dev *xdna = client->xdna;
> +	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
>   	int ret, idx;
>   
>   	if (!drm_dev_enter(&xdna->ddev, &idx))
> @@ -1053,7 +1007,7 @@ static int aie2_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_i
>   		ret = aie2_get_aie_status(client, args);
>   		break;
>   	case DRM_AMDXDNA_QUERY_AIE_METADATA:
> -		ret = aie2_get_aie_metadata(client, args);
> +		ret = amdxdna_get_metadata(&ndev->aie, client, args);
>   		break;
>   	case DRM_AMDXDNA_QUERY_AIE_VERSION:
>   		ret = aie2_get_aie_version(client, args);
> diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
> index f12073175676..fe51d516a358 100644
> --- a/drivers/accel/amdxdna/aie2_pci.h
> +++ b/drivers/accel/amdxdna/aie2_pci.h
> @@ -77,29 +77,6 @@ struct amdxdna_fw_ver;
>   struct amdxdna_hwctx;
>   struct amdxdna_sched_job;
>   
> -struct aie_version {
> -	u16 major;
> -	u16 minor;
> -};
> -
> -struct aie_tile_metadata {
> -	u16 row_count;
> -	u16 row_start;
> -	u16 dma_channel_count;
> -	u16 lock_count;
> -	u16 event_reg_count;
> -};
> -
> -struct aie_metadata {
> -	u32 size;
> -	u16 cols;
> -	u16 rows;
> -	struct aie_version version;
> -	struct aie_tile_metadata core;
> -	struct aie_tile_metadata mem;
> -	struct aie_tile_metadata shim;
> -};
> -
>   enum rt_config_category {
>   	AIE2_RT_CFG_INIT,
>   	AIE2_RT_CFG_CLK_GATING,
> @@ -177,8 +154,7 @@ struct amdxdna_dev_hdl {
>   	void			__iomem *mbox_base;
>   
>   	u32				total_col;
> -	struct aie_version		version;
> -	struct aie_metadata		metadata;
> +	struct amdxdna_drm_query_aie_version version;
>   	struct aie2_exec_msg_ops	*exec_msg_ops;
>   
>   	/* power management and clock*/
> @@ -283,8 +259,10 @@ int aie2_resume_fw(struct amdxdna_dev_hdl *ndev);
>   int aie2_set_runtime_cfg(struct amdxdna_dev_hdl *ndev, u32 type, u64 value);
>   int aie2_get_runtime_cfg(struct amdxdna_dev_hdl *ndev, u32 type, u64 *value);
>   int aie2_assign_mgmt_pasid(struct amdxdna_dev_hdl *ndev, u16 pasid);
> -int aie2_query_aie_version(struct amdxdna_dev_hdl *ndev, struct aie_version *version);
> -int aie2_query_aie_metadata(struct amdxdna_dev_hdl *ndev, struct aie_metadata *metadata);
> +int aie2_query_aie_version(struct amdxdna_dev_hdl *ndev,
> +			   struct amdxdna_drm_query_aie_version *version);
> +int aie2_query_aie_metadata(struct amdxdna_dev_hdl *ndev,
> +			    struct amdxdna_drm_query_aie_metadata *metadata);
>   int aie2_query_firmware_version(struct amdxdna_dev_hdl *ndev,
>   				struct amdxdna_fw_ver *fw_ver);
>   int aie2_query_app_health(struct amdxdna_dev_hdl *ndev, u32 context_id,
> diff --git a/drivers/accel/amdxdna/aie4_message.c b/drivers/accel/amdxdna/aie4_message.c
> index d621dd32ac40..8d19af2a186f 100644
> --- a/drivers/accel/amdxdna/aie4_message.c
> +++ b/drivers/accel/amdxdna/aie4_message.c
> @@ -25,3 +25,41 @@ int aie4_suspend_fw(struct amdxdna_dev_hdl *ndev)
>   
>   	return ret;
>   }
> +
> +int aie4_query_aie_metadata(struct amdxdna_dev_hdl *ndev,
> +			    struct amdxdna_drm_query_aie_metadata *metadata)
> +{
> +	DECLARE_AIE_MSG(aie4_msg_aie4_tile_info, AIE4_MSG_OP_AIE_TILE_INFO);
> +	int ret;
> +
> +	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
> +	if (ret)
> +		return ret;
> +
> +	metadata->col_size = resp.info.size;
> +	metadata->cols = resp.info.cols;
> +	metadata->rows = resp.info.rows;
> +
> +	metadata->version.major = resp.info.major;
> +	metadata->version.minor = resp.info.minor;
> +
> +	metadata->core.row_count = resp.info.core_rows;
> +	metadata->core.row_start = resp.info.core_row_start;
> +	metadata->core.dma_channel_count = resp.info.core_dma_channels;
> +	metadata->core.lock_count = resp.info.core_locks;
> +	metadata->core.event_reg_count = resp.info.core_events;
> +
> +	metadata->mem.row_count = resp.info.mem_rows;
> +	metadata->mem.row_start = resp.info.mem_row_start;
> +	metadata->mem.dma_channel_count = resp.info.mem_dma_channels;
> +	metadata->mem.lock_count = resp.info.mem_locks;
> +	metadata->mem.event_reg_count = resp.info.mem_events;
> +
> +	metadata->shim.row_count = resp.info.shim_rows;
> +	metadata->shim.row_start = resp.info.shim_row_start;
> +	metadata->shim.dma_channel_count = resp.info.shim_dma_channels;
> +	metadata->shim.lock_count = resp.info.shim_locks;
> +	metadata->shim.event_reg_count = resp.info.shim_events;
> +
> +	return 0;
> +}
> diff --git a/drivers/accel/amdxdna/aie4_msg_priv.h b/drivers/accel/amdxdna/aie4_msg_priv.h
> index 7faa01ca3436..69e220e40900 100644
> --- a/drivers/accel/amdxdna/aie4_msg_priv.h
> +++ b/drivers/accel/amdxdna/aie4_msg_priv.h
> @@ -18,6 +18,7 @@ enum aie4_msg_opcode {
>   	AIE4_MSG_OP_DESTROY_PARTITION                = 0x30002,
>   	AIE4_MSG_OP_CREATE_HW_CONTEXT                = 0x30003,
>   	AIE4_MSG_OP_DESTROY_HW_CONTEXT               = 0x30004,
> +	AIE4_MSG_OP_AIE_TILE_INFO                    = 0x30006,
>   };
>   
>   enum aie4_msg_status {
> @@ -96,4 +97,37 @@ struct aie4_msg_destroy_hw_context_resp {
>   	enum aie4_msg_status status;
>   } __packed;
>   
> +struct aie4_tile_info {
> +	__u32 size;
> +	__u16 major;
> +	__u16 minor;
> +	__u16 cols;
> +	__u16 rows;
> +	__u16 core_rows;
> +	__u16 mem_rows;
> +	__u16 shim_rows;
> +	__u16 core_row_start;
> +	__u16 mem_row_start;
> +	__u16 shim_row_start;
> +	__u16 core_dma_channels;
> +	__u16 mem_dma_channels;
> +	__u16 shim_dma_channels;
> +	__u16 core_locks;
> +	__u16 mem_locks;
> +	__u16 shim_locks;
> +	__u16 core_events;
> +	__u16 mem_events;
> +	__u16 shim_events;
> +	__u16 resvd;
> +} __packed;
> +
> +struct aie4_msg_aie4_tile_info_req {
> +	__u32 resvd;
> +} __packed;
> +
> +struct aie4_msg_aie4_tile_info_resp {
> +	enum aie4_msg_status status;
> +	struct aie4_tile_info info;
> +} __packed;
> +
>   #endif /* _AIE4_MSG_PRIV_H_ */
> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
> index 9ff34ce57fcb..8b5eff0e45c1 100644
> --- a/drivers/accel/amdxdna/aie4_pci.c
> +++ b/drivers/accel/amdxdna/aie4_pci.c
> @@ -269,6 +269,11 @@ static void aie4_partition_fini(struct amdxdna_dev_hdl *ndev)
>   		XDNA_ERR(xdna, "partition fini failed: %d", ret);
>   }
>   
> +static int aie4_query(struct amdxdna_dev_hdl *ndev)
> +{
> +	return aie4_query_aie_metadata(ndev, &ndev->aie.metadata);
> +}
> +
>   static int aie4_pf_hw_start(struct amdxdna_dev_hdl *ndev)
>   {
>   	int ret;
> @@ -308,6 +313,10 @@ static int aie4_vf_hw_start(struct amdxdna_dev_hdl *ndev)
>   	if (ret)
>   		return ret;
>   
> +	ret = aie4_query(ndev);
> +	if (ret)
> +		goto mailbox_fini;
> +
>   	ret = aie4_partition_init(ndev);
>   	if (ret)
>   		goto mailbox_fini;
> @@ -535,6 +544,26 @@ static int aie4_doorbell_mmap(struct amdxdna_client *client, struct vm_area_stru
>   	return ret;
>   }
>   
> +static int aie4_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_info *args)
> +{
> +	struct amdxdna_dev *xdna = client->xdna;
> +	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
> +	int ret;
> +
> +	switch (args->param) {
> +	case DRM_AMDXDNA_QUERY_AIE_METADATA:
> +		ret = amdxdna_get_metadata(&ndev->aie, client, args);
> +		break;
> +	default:
> +		XDNA_ERR(xdna, "Not supported request parameter %u", args->param);
> +		ret = -EOPNOTSUPP;
> +	}
> +
> +	XDNA_DBG(xdna, "Got param %d", args->param);
> +
> +	return ret;
> +}
> +
>   static int aie4_pf_init(struct amdxdna_dev *xdna)
>   {
>   	int ret;
> @@ -581,4 +610,5 @@ const struct amdxdna_dev_ops aie4_vf_ops = {
>   	.hwctx_fini		= aie4_hwctx_fini,
>   	.mmap			= aie4_doorbell_mmap,
>   	.cmd_wait		= aie4_cmd_wait,
> +	.get_aie_info		= aie4_get_info,
>   };
> diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
> index b69489acd53d..64a1955cab9a 100644
> --- a/drivers/accel/amdxdna/aie4_pci.h
> +++ b/drivers/accel/amdxdna/aie4_pci.h
> @@ -56,6 +56,8 @@ struct amdxdna_dev_hdl {
>   };
>   
>   /* aie4_message.c */
> +int aie4_query_aie_metadata(struct amdxdna_dev_hdl *ndev,
> +			    struct amdxdna_drm_query_aie_metadata *metadata);
>   int aie4_suspend_fw(struct amdxdna_dev_hdl *ndev);
>   
>   /* aie4_ctx.c */

