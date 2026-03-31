Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BBA10F92E3
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 16:31:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F6B810EB65;
	Tue, 31 Mar 2026 16:31:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ctsxkAv8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 901BE10EB65
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 16:31:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E4E9A6111A;
 Tue, 31 Mar 2026 16:31:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66CFC19423;
 Tue, 31 Mar 2026 16:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774974682;
 bh=TqTNEuqVWSaqiURZYkyILtXaIB+MC8NSOuVFqW4fRdo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ctsxkAv8LkpNb6v0RDqK+O8+FH42/MOPWE8CtIFztZt18781Y/t441I04QUgwDB78
 +ehkCByxpH38JGdZIxCwYVlXs710ysVJii6RUnopsDkswuMYpjFEc7SMCS0WfFwk7X
 U6b63oGyB4uMwKtVfD4GUwUkPzj1Z2vRyY7NWHk6DPyx+U+8ydm9zYiGL0kwsQfCFY
 sBlOM5nDDHUB0vOVMukk39x0zk/GxZbG0Mb8/EahZNyeQnnbN5b+S2wDaDX5CMINDR
 fuBLIgsE2Bp7Fu7fkdCSXimkSkEcfQlun5Vtd4s/MFRjnKj/hNWOYZZydd5YYXCN/s
 9ED39PD3MGRWQ==
Message-ID: <6a0463af-b4c3-491e-9dfc-ff76733a6fd0@kernel.org>
Date: Tue, 31 Mar 2026 11:31:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 3/6] accel/amdxdna: Create common PSP interfaces for
 AIE2 and AIE4
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 maciej.falkowski@linux.intel.com
Cc: David Zhang <yidong.zhang@amd.com>, linux-kernel@vger.kernel.org,
 max.zhen@amd.com, sonal.santan@amd.com,
 Hayden Laccabue <Hayden.Laccabue@amd.com>
References: <20260330163705.3153647-1-lizhi.hou@amd.com>
 <20260330163705.3153647-4-lizhi.hou@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260330163705.3153647-4-lizhi.hou@amd.com>
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



On 3/30/26 11:37, Lizhi Hou wrote:
> From: David Zhang <yidong.zhang@amd.com>
> 
> The AIE2 and AIE4 use the similar interface to PSP (Platform Security
> Processor). Move the PSP implementation into aie_psp.c so both platforms
> use the same path and future AIE4 PSP work can build on it.
> 
> Co-developed-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
> Signed-off-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
> Signed-off-by: David Zhang <yidong.zhang@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/accel/amdxdna/Makefile                |  2 +-
>   drivers/accel/amdxdna/aie.h                   | 41 +++++++++++++++++
>   drivers/accel/amdxdna/aie2_message.c          |  2 +-
>   drivers/accel/amdxdna/aie2_pci.c              | 12 ++---
>   drivers/accel/amdxdna/aie2_pci.h              | 44 ++-----------------
>   .../accel/amdxdna/{aie2_psp.c => aie_psp.c}   | 17 +++----
>   6 files changed, 60 insertions(+), 58 deletions(-)
>   rename drivers/accel/amdxdna/{aie2_psp.c => aie_psp.c} (88%)
> 
> diff --git a/drivers/accel/amdxdna/Makefile b/drivers/accel/amdxdna/Makefile
> index a61cd6c0db30..d3c0fe765a8b 100644
> --- a/drivers/accel/amdxdna/Makefile
> +++ b/drivers/accel/amdxdna/Makefile
> @@ -2,12 +2,12 @@
>   
>   amdxdna-y := \
>   	aie.o \
> +	aie_psp.o \
>   	aie2_ctx.o \
>   	aie2_error.o \
>   	aie2_message.o \
>   	aie2_pci.o \
>   	aie2_pm.o \
> -	aie2_psp.o \
>   	aie2_smu.o \
>   	aie2_solver.o \
>   	aie4_message.o \
> diff --git a/drivers/accel/amdxdna/aie.h b/drivers/accel/amdxdna/aie.h
> index 6c53870d0098..124c0f7e9ca0 100644
> --- a/drivers/accel/amdxdna/aie.h
> +++ b/drivers/accel/amdxdna/aie.h
> @@ -11,6 +11,8 @@
>   #define AIE_INTERVAL	20000	/* us */
>   #define AIE_TIMEOUT	1000000	/* us */
>   
> +struct psp_device;
> +
>   struct aie_device {
>   	struct amdxdna_dev *xdna;
>   	struct mailbox_channel *mgmt_chann;
> @@ -20,15 +22,54 @@ struct aie_device {
>   	u32 mgmt_prot_major;
>   	u32 mgmt_prot_minor;
>   	unsigned long feature_mask;
> +
> +	struct psp_device *psp_hdl;
>   };
>   
>   #define DECLARE_AIE_MSG(name, op) \
>   	DECLARE_XDNA_MSG_COMMON(name, op, -1)
>   #define AIE_FEATURE_ON(aie, feature) test_bit(feature, &(aie)->feature_mask)
>   
> +#define PSP_REG_BAR(ndev, idx) ((ndev)->priv->psp_regs_off[(idx)].bar_idx)
> +#define PSP_REG_OFF(ndev, idx) ((ndev)->priv->psp_regs_off[(idx)].offset)
> +
> +#define DEFINE_BAR_OFFSET(reg_name, bar, reg_addr) \
> +	[reg_name] = {bar##_BAR_INDEX, (reg_addr) - bar##_BAR_BASE}
> +
> +enum psp_reg_idx {
> +	PSP_CMD_REG = 0,
> +	PSP_ARG0_REG,
> +	PSP_ARG1_REG,
> +	PSP_ARG2_REG,
> +	PSP_NUM_IN_REGS, /* number of input registers */
> +	PSP_INTR_REG = PSP_NUM_IN_REGS,
> +	PSP_STATUS_REG,
> +	PSP_RESP_REG,
> +	PSP_PWAITMODE_REG,
> +	PSP_MAX_REGS /* Keep this at the end */
> +};
> +
> +struct aie_bar_off_pair {
> +	int	bar_idx;
> +	u32	offset;
> +};
> +
> +struct psp_config {
> +	const void		*fw_buf;
> +	u32			fw_size;
> +	void __iomem		*psp_regs[PSP_MAX_REGS];
> +};
> +
> +/* aie.c */
>   void aie_dump_mgmt_chann_debug(struct aie_device *aie);
>   void aie_destroy_chann(struct aie_device *aie, struct mailbox_channel **chann);
>   int aie_send_mgmt_msg_wait(struct aie_device *aie, struct xdna_mailbox_msg *msg);
>   int aie_check_protocol(struct aie_device *aie, u32 fw_major, u32 fw_minor);
>   
> +/* aie_psp.c */
> +struct psp_device *aiem_psp_create(struct drm_device *ddev, struct psp_config *conf);
> +int aie_psp_start(struct psp_device *psp);
> +void aie_psp_stop(struct psp_device *psp);
> +int aie_psp_waitmode_poll(struct psp_device *psp);
> +
>   #endif /* _AIE_H_ */
> diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
> index ccf87b1aa1cc..e5e7da7a8f40 100644
> --- a/drivers/accel/amdxdna/aie2_message.c
> +++ b/drivers/accel/amdxdna/aie2_message.c
> @@ -75,7 +75,7 @@ int aie2_suspend_fw(struct amdxdna_dev_hdl *ndev)
>   		return ret;
>   	}
>   
> -	return aie2_psp_waitmode_poll(ndev->psp_hdl);
> +	return aie_psp_waitmode_poll(ndev->aie.psp_hdl);
>   }
>   
>   int aie2_resume_fw(struct amdxdna_dev_hdl *ndev)
> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
> index 708d0b7fd2e3..e4b7893bd429 100644
> --- a/drivers/accel/amdxdna/aie2_pci.c
> +++ b/drivers/accel/amdxdna/aie2_pci.c
> @@ -297,7 +297,7 @@ static void aie2_hw_stop(struct amdxdna_dev *xdna)
>   	aie_destroy_chann(&ndev->aie, &ndev->aie.mgmt_chann);
>   	drmm_kfree(&xdna->ddev, ndev->mbox);
>   	ndev->mbox = NULL;
> -	aie2_psp_stop(ndev->psp_hdl);
> +	aie_psp_stop(ndev->aie.psp_hdl);
>   	aie2_smu_fini(ndev);
>   	aie2_error_async_events_free(ndev);
>   	pci_disable_device(pdev);
> @@ -350,7 +350,7 @@ static int aie2_hw_start(struct amdxdna_dev *xdna)
>   		goto free_channel;
>   	}
>   
> -	ret = aie2_psp_start(ndev->psp_hdl);
> +	ret = aie_psp_start(ndev->aie.psp_hdl);
>   	if (ret) {
>   		XDNA_ERR(xdna, "failed to start psp, ret %d", ret);
>   		goto fini_smu;
> @@ -413,7 +413,7 @@ static int aie2_hw_start(struct amdxdna_dev *xdna)
>   	aie2_suspend_fw(ndev);
>   	xdna_mailbox_stop_channel(ndev->aie.mgmt_chann);
>   stop_psp:
> -	aie2_psp_stop(ndev->psp_hdl);
> +	aie_psp_stop(ndev->aie.psp_hdl);
>   fini_smu:
>   	aie2_smu_fini(ndev);
>   free_channel:
> @@ -463,7 +463,7 @@ static int aie2_init(struct amdxdna_dev *xdna)
>   	void __iomem *tbl[PCI_NUM_RESOURCES] = {0};
>   	struct init_config xrs_cfg = { 0 };
>   	struct amdxdna_dev_hdl *ndev;
> -	struct psp_config psp_conf;
> +	struct psp_config psp_conf = { 0 };
>   	const struct firmware *fw;
>   	unsigned long bars = 0;
>   	char *fw_full_path;
> @@ -551,8 +551,8 @@ static int aie2_init(struct amdxdna_dev *xdna)
>   	psp_conf.fw_buf = fw->data;
>   	for (i = 0; i < PSP_MAX_REGS; i++)
>   		psp_conf.psp_regs[i] = tbl[PSP_REG_BAR(ndev, i)] + PSP_REG_OFF(ndev, i);
> -	ndev->psp_hdl = aie2m_psp_create(&xdna->ddev, &psp_conf);
> -	if (!ndev->psp_hdl) {
> +	ndev->aie.psp_hdl = aiem_psp_create(&xdna->ddev, &psp_conf);
> +	if (!ndev->aie.psp_hdl) {
>   		XDNA_ERR(xdna, "failed to create psp");
>   		ret = -ENOMEM;
>   		goto release_fw;
> diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
> index 96960a2219a4..4f036b9fa096 100644
> --- a/drivers/accel/amdxdna/aie2_pci.h
> +++ b/drivers/accel/amdxdna/aie2_pci.h
> @@ -1,6 +1,6 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
>   /*
> - * Copyright (C) 2023-2024, Advanced Micro Devices, Inc.
> + * Copyright (C) 2023-2026, Advanced Micro Devices, Inc.
>    */
>   
>   #ifndef _AIE2_PCI_H_
> @@ -23,8 +23,6 @@
>   #define AIE2_SRAM_OFF(ndev, addr) ((addr) - (ndev)->priv->sram_dev_addr)
>   #define AIE2_MBOX_OFF(ndev, addr) ((addr) - (ndev)->priv->mbox_dev_addr)
>   
> -#define PSP_REG_BAR(ndev, idx) ((ndev)->priv->psp_regs_off[(idx)].bar_idx)
> -#define PSP_REG_OFF(ndev, idx) ((ndev)->priv->psp_regs_off[(idx)].offset)
>   #define SRAM_REG_OFF(ndev, idx) ((ndev)->priv->sram_offs[(idx)].offset)
>   
>   #define SMU_REG(ndev, idx) \
> @@ -88,30 +86,11 @@ enum aie2_sram_reg_idx {
>   	SRAM_MAX_INDEX /* Keep this at the end */
>   };
>   
> -enum psp_reg_idx {
> -	PSP_CMD_REG = 0,
> -	PSP_ARG0_REG,
> -	PSP_ARG1_REG,
> -	PSP_ARG2_REG,
> -	PSP_NUM_IN_REGS, /* number of input registers */
> -	PSP_INTR_REG = PSP_NUM_IN_REGS,
> -	PSP_STATUS_REG,
> -	PSP_RESP_REG,
> -	PSP_PWAITMODE_REG,
> -	PSP_MAX_REGS /* Keep this at the end */
> -};
> -
>   struct amdxdna_client;
>   struct amdxdna_fw_ver;
>   struct amdxdna_hwctx;
>   struct amdxdna_sched_job;
>   
> -struct psp_config {
> -	const void	*fw_buf;
> -	u32		fw_size;
> -	void __iomem	*psp_regs[PSP_MAX_REGS];
> -};
> -
>   struct aie_version {
>   	u16 major;
>   	u16 minor;
> @@ -206,7 +185,6 @@ struct amdxdna_dev_hdl {
>   	void			__iomem *sram_base;
>   	void			__iomem *smu_base;
>   	void			__iomem *mbox_base;
> -	struct psp_device		*psp_hdl;
>   
>   	u32				total_col;
>   	struct aie_version		version;
> @@ -236,14 +214,6 @@ struct amdxdna_dev_hdl {
>   	struct amdxdna_async_error	last_async_err;
>   };
>   
> -#define DEFINE_BAR_OFFSET(reg_name, bar, reg_addr) \
> -	[reg_name] = {bar##_BAR_INDEX, (reg_addr) - bar##_BAR_BASE}
> -
> -struct aie2_bar_off_pair {
> -	int	bar_idx;
> -	u32	offset;
> -};
> -
>   struct aie2_hw_ops {
>   	int (*set_dpm)(struct amdxdna_dev_hdl *ndev, u32 dpm_level);
>   };
> @@ -271,9 +241,9 @@ struct amdxdna_dev_priv {
>   	u32				mbox_size;
>   	u32				hwctx_limit;
>   	u32				sram_dev_addr;
> -	struct aie2_bar_off_pair	sram_offs[SRAM_MAX_INDEX];
> -	struct aie2_bar_off_pair	psp_regs_off[PSP_MAX_REGS];
> -	struct aie2_bar_off_pair	smu_regs_off[SMU_MAX_REGS];
> +	struct aie_bar_off_pair		sram_offs[SRAM_MAX_INDEX];
> +	struct aie_bar_off_pair		psp_regs_off[PSP_MAX_REGS];
> +	struct aie_bar_off_pair		smu_regs_off[SMU_MAX_REGS];
>   	struct aie2_hw_ops		hw_ops;
>   };
>   
> @@ -300,12 +270,6 @@ int aie2_pm_init(struct amdxdna_dev_hdl *ndev);
>   int aie2_pm_set_mode(struct amdxdna_dev_hdl *ndev, enum amdxdna_power_mode_type target);
>   int aie2_pm_set_dpm(struct amdxdna_dev_hdl *ndev, u32 dpm_level);
>   
> -/* aie2_psp.c */
> -struct psp_device *aie2m_psp_create(struct drm_device *ddev, struct psp_config *conf);
> -int aie2_psp_start(struct psp_device *psp);
> -void aie2_psp_stop(struct psp_device *psp);
> -int aie2_psp_waitmode_poll(struct psp_device *psp);
> -
>   /* aie2_error.c */
>   int aie2_error_async_events_alloc(struct amdxdna_dev_hdl *ndev);
>   void aie2_error_async_events_free(struct amdxdna_dev_hdl *ndev);
> diff --git a/drivers/accel/amdxdna/aie2_psp.c b/drivers/accel/amdxdna/aie_psp.c
> similarity index 88%
> rename from drivers/accel/amdxdna/aie2_psp.c
> rename to drivers/accel/amdxdna/aie_psp.c
> index 3a7130577e3e..8743b812a449 100644
> --- a/drivers/accel/amdxdna/aie2_psp.c
> +++ b/drivers/accel/amdxdna/aie_psp.c
> @@ -1,19 +1,16 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
> - * Copyright (C) 2022-2024, Advanced Micro Devices, Inc.
> + * Copyright (C) 2026, Advanced Micro Devices, Inc.
>    */
>   
>   #include <drm/drm_device.h>
> -#include <drm/drm_gem_shmem_helper.h>
>   #include <drm/drm_managed.h>
>   #include <drm/drm_print.h>
> -#include <drm/gpu_scheduler.h>
>   #include <linux/bitfield.h>
>   #include <linux/iopoll.h>
> +#include <linux/slab.h>
>   
> -#include "aie2_pci.h"
> -#include "amdxdna_mailbox.h"
> -#include "amdxdna_pci_drv.h"
> +#include "aie.h"
>   
>   #define PSP_STATUS_READY	BIT(31)
>   
> @@ -76,7 +73,7 @@ static int psp_exec(struct psp_device *psp, u32 *reg_vals)
>   	return 0;
>   }
>   
> -int aie2_psp_waitmode_poll(struct psp_device *psp)
> +int aie_psp_waitmode_poll(struct psp_device *psp)
>   {
>   	struct amdxdna_dev *xdna = to_xdna_dev(psp->ddev);
>   	u32 mode_reg;
> @@ -91,7 +88,7 @@ int aie2_psp_waitmode_poll(struct psp_device *psp)
>   	return ret;
>   }
>   
> -void aie2_psp_stop(struct psp_device *psp)
> +void aie_psp_stop(struct psp_device *psp)
>   {
>   	u32 reg_vals[PSP_NUM_IN_REGS] = { PSP_RELEASE_TMR, };
>   	int ret;
> @@ -101,7 +98,7 @@ void aie2_psp_stop(struct psp_device *psp)
>   		drm_err(psp->ddev, "release tmr failed, ret %d", ret);
>   }
>   
> -int aie2_psp_start(struct psp_device *psp)
> +int aie_psp_start(struct psp_device *psp)
>   {
>   	u32 reg_vals[PSP_NUM_IN_REGS];
>   	int ret;
> @@ -129,7 +126,7 @@ int aie2_psp_start(struct psp_device *psp)
>   	return 0;
>   }
>   
> -struct psp_device *aie2m_psp_create(struct drm_device *ddev, struct psp_config *conf)
> +struct psp_device *aiem_psp_create(struct drm_device *ddev, struct psp_config *conf)
>   {
>   	struct psp_device *psp;
>   	u64 offset;

