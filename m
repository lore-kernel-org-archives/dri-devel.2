Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6CFF10F92E3
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 16:31:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36B2410EB7F;
	Tue, 31 Mar 2026 16:31:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XVpwgVze";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4781D10EB7F
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 16:31:34 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id AC23B6111A;
 Tue, 31 Mar 2026 16:31:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB2BC19423;
 Tue, 31 Mar 2026 16:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774974693;
 bh=rVikLet6dpLf2TPLaHzM8JpzMCpQXlq0jgoGTvaz2IM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=XVpwgVzeH6rwttWsHEgXIuHcHVRl6RF3XzrrL7FgFUWHAbNI/HFdiu7RlG9fzuij2
 B/Y3jHAWRA8nOM0d+AUdOGlLu0o4nS5ct8gYtIMiggX9uM+0rLHgWo+p6U0d5cy4lc
 TunJCZjPik9VCxs+i2rEmhFZHiLYYdHIGZOHXBHR7boeWsN0kKlxQju6kZoD1zIUkb
 sfsMfffbh/GBdS1H2UzWgGDnHJTCqG0+jsB/kAt55Ix8IKzea0JD3qWloV+sAzdVHd
 4XN61MjO3dzAQTo50xc632v5iMj/11rITGHjgm5HGp/xyL0fTOK+7iloY4g4CehEP0
 UJEp9RK3F+0pw==
Message-ID: <beb91168-b191-4886-a983-5805eee90dcc@kernel.org>
Date: Tue, 31 Mar 2026 11:31:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 5/6] accel/amdxdna: Create common SMU interfaces for
 AIE2 and AIE4
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 maciej.falkowski@linux.intel.com
Cc: David Zhang <yidong.zhang@amd.com>, linux-kernel@vger.kernel.org,
 max.zhen@amd.com, sonal.santan@amd.com,
 Hayden Laccabue <Hayden.Laccabue@amd.com>
References: <20260330163705.3153647-1-lizhi.hou@amd.com>
 <20260330163705.3153647-6-lizhi.hou@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260330163705.3153647-6-lizhi.hou@amd.com>
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
> AIE2 and AIE4 use similar interfaces to the SMU (System Management
> Unit). Move the SMU implementation into aie_smu.c and provide common
> interfaces for both platforms.
> 
> This allows AIE2 and AIE4 to share the same implementation and reduces
> code duplication.
> 
> Co-developed-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
> Signed-off-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
> Signed-off-by: David Zhang <yidong.zhang@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/accel/amdxdna/Makefile    |   2 +-
>   drivers/accel/amdxdna/aie.h       |  25 +++++
>   drivers/accel/amdxdna/aie2_pci.c  |  22 ++++-
>   drivers/accel/amdxdna/aie2_pci.h  |  20 ----
>   drivers/accel/amdxdna/aie2_smu.c  | 156 ------------------------------
>   drivers/accel/amdxdna/aie_smu.c   | 153 +++++++++++++++++++++++++++++
>   drivers/accel/amdxdna/npu1_regs.c |  21 ++++
>   drivers/accel/amdxdna/npu4_regs.c |  26 +++++
>   8 files changed, 245 insertions(+), 180 deletions(-)
>   delete mode 100644 drivers/accel/amdxdna/aie2_smu.c
>   create mode 100644 drivers/accel/amdxdna/aie_smu.c
> 
> diff --git a/drivers/accel/amdxdna/Makefile b/drivers/accel/amdxdna/Makefile
> index d3c0fe765a8b..79369e497540 100644
> --- a/drivers/accel/amdxdna/Makefile
> +++ b/drivers/accel/amdxdna/Makefile
> @@ -3,12 +3,12 @@
>   amdxdna-y := \
>   	aie.o \
>   	aie_psp.o \
> +	aie_smu.o \
>   	aie2_ctx.o \
>   	aie2_error.o \
>   	aie2_message.o \
>   	aie2_pci.o \
>   	aie2_pm.o \
> -	aie2_smu.o \
>   	aie2_solver.o \
>   	aie4_message.o \
>   	aie4_pci.o \
> diff --git a/drivers/accel/amdxdna/aie.h b/drivers/accel/amdxdna/aie.h
> index 423ed34af9ee..ba4c9ee21823 100644
> --- a/drivers/accel/amdxdna/aie.h
> +++ b/drivers/accel/amdxdna/aie.h
> @@ -12,6 +12,7 @@
>   #define AIE_TIMEOUT	1000000	/* us */
>   
>   struct psp_device;
> +struct smu_device;
>   
>   struct aie_device {
>   	struct amdxdna_dev *xdna;
> @@ -24,6 +25,7 @@ struct aie_device {
>   	unsigned long feature_mask;
>   
>   	struct psp_device *psp_hdl;
> +	struct smu_device *smu_hdl;
>   };
>   
>   #define DECLARE_AIE_MSG(name, op) \
> @@ -33,9 +35,21 @@ struct aie_device {
>   #define PSP_REG_BAR(ndev, idx) ((ndev)->priv->psp_regs_off[(idx)].bar_idx)
>   #define PSP_REG_OFF(ndev, idx) ((ndev)->priv->psp_regs_off[(idx)].offset)
>   
> +#define SMU_REG_BAR(ndev, idx) ((ndev)->priv->smu_regs_off[(idx)].bar_idx)
> +#define SMU_REG_OFF(ndev, idx) ((ndev)->priv->smu_regs_off[(idx)].offset)
> +
>   #define DEFINE_BAR_OFFSET(reg_name, bar, reg_addr) \
>   	[reg_name] = {bar##_BAR_INDEX, (reg_addr) - bar##_BAR_BASE}
>   
> +enum smu_reg_idx {
> +	SMU_CMD_REG = 0,
> +	SMU_ARG_REG,
> +	SMU_INTR_REG,
> +	SMU_RESP_REG,
> +	SMU_OUT_REG,
> +	SMU_MAX_REGS /* Keep this at the end */
> +};
> +
>   enum psp_reg_idx {
>   	PSP_CMD_REG = 0,
>   	PSP_ARG0_REG,
> @@ -54,6 +68,10 @@ struct aie_bar_off_pair {
>   	u32	offset;
>   };
>   
> +struct smu_config {
> +	void __iomem    *smu_regs[SMU_MAX_REGS];
> +};
> +
>   struct psp_config {
>   	const void		*fw_buf;
>   	u32			fw_size;
> @@ -76,4 +94,11 @@ int aie_psp_start(struct psp_device *psp);
>   void aie_psp_stop(struct psp_device *psp);
>   int aie_psp_waitmode_poll(struct psp_device *psp);
>   
> +/* aie_smu.c */
> +struct smu_device *aiem_smu_create(struct drm_device *ddev, struct smu_config *conf);
> +int aie_smu_init(struct smu_device *smu);
> +void aie_smu_fini(struct smu_device *smu);
> +int aie_smu_set_clocks(struct smu_device *smu, u32 *npuclk, u32 *hclk);
> +int aie_smu_set_dpm(struct smu_device *smu, u32 dpm_level);
> +
>   #endif /* _AIE_H_ */
> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
> index 0489e668cd73..164e188ba501 100644
> --- a/drivers/accel/amdxdna/aie2_pci.c
> +++ b/drivers/accel/amdxdna/aie2_pci.c
> @@ -282,6 +282,12 @@ static struct xrs_action_ops aie2_xrs_actions = {
>   	.set_dft_dpm_level = aie2_xrs_set_dft_dpm_level,
>   };
>   
> +static void aie2_smu_fini(struct amdxdna_dev_hdl *ndev)
> +{
> +	ndev->priv->hw_ops.set_dpm(ndev, 0);
> +	aie_smu_fini(ndev->aie.smu_hdl);
> +}
> +
>   static void aie2_hw_stop(struct amdxdna_dev *xdna)
>   {
>   	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
> @@ -344,7 +350,7 @@ static int aie2_hw_start(struct amdxdna_dev *xdna)
>   		goto disable_dev;
>   	}
>   
> -	ret = aie2_smu_init(ndev);
> +	ret = aie_smu_init(ndev->aie.smu_hdl);
>   	if (ret) {
>   		XDNA_ERR(xdna, "failed to init smu, ret %d", ret);
>   		goto free_channel;
> @@ -464,6 +470,7 @@ static int aie2_init(struct amdxdna_dev *xdna)
>   	struct init_config xrs_cfg = { 0 };
>   	struct amdxdna_dev_hdl *ndev;
>   	struct psp_config psp_conf = { 0 };
> +	struct smu_config smu_conf;
>   	const struct firmware *fw;
>   	unsigned long bars = 0;
>   	char *fw_full_path;
> @@ -508,9 +515,10 @@ static int aie2_init(struct amdxdna_dev *xdna)
>   
>   	for (i = 0; i < PSP_MAX_REGS; i++)
>   		set_bit(PSP_REG_BAR(ndev, i), &bars);
> +	for (i = 0; i < SMU_MAX_REGS; i++)
> +		set_bit(SMU_REG_BAR(ndev, i), &bars);
>   
>   	set_bit(xdna->dev_info->sram_bar, &bars);
> -	set_bit(xdna->dev_info->smu_bar, &bars);
>   	set_bit(xdna->dev_info->mbox_bar, &bars);
>   
>   	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
> @@ -525,7 +533,6 @@ static int aie2_init(struct amdxdna_dev *xdna)
>   	}
>   
>   	ndev->sram_base = tbl[xdna->dev_info->sram_bar];
> -	ndev->smu_base = tbl[xdna->dev_info->smu_bar];
>   	ndev->mbox_base = tbl[xdna->dev_info->mbox_bar];
>   
>   	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> @@ -559,6 +566,15 @@ static int aie2_init(struct amdxdna_dev *xdna)
>   		ret = -ENOMEM;
>   		goto release_fw;
>   	}
> +
> +	for (i = 0; i < SMU_MAX_REGS; i++)
> +		smu_conf.smu_regs[i] = tbl[SMU_REG_BAR(ndev, i)] + SMU_REG_OFF(ndev, i);
> +	ndev->aie.smu_hdl = aiem_smu_create(&xdna->ddev, &smu_conf);
> +	if (!ndev->aie.smu_hdl) {
> +		XDNA_ERR(xdna, "failed to create smu");
> +		ret = -ENOMEM;
> +		goto release_fw;
> +	}
>   	xdna->dev_handle = ndev;
>   
>   	ret = aie2_hw_start(xdna);
> diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
> index 4f036b9fa096..7c308672b5fe 100644
> --- a/drivers/accel/amdxdna/aie2_pci.h
> +++ b/drivers/accel/amdxdna/aie2_pci.h
> @@ -25,11 +25,6 @@
>   
>   #define SRAM_REG_OFF(ndev, idx) ((ndev)->priv->sram_offs[(idx)].offset)
>   
> -#define SMU_REG(ndev, idx) \
> -({ \
> -	typeof(ndev) _ndev = ndev; \
> -	((_ndev)->smu_base + (_ndev)->priv->smu_regs_off[(idx)].offset); \
> -})
>   #define SRAM_GET_ADDR(ndev, idx) \
>   ({ \
>   	typeof(ndev) _ndev = ndev; \
> @@ -71,15 +66,6 @@
>   })
>   #endif
>   
> -enum aie2_smu_reg_idx {
> -	SMU_CMD_REG = 0,
> -	SMU_ARG_REG,
> -	SMU_INTR_REG,
> -	SMU_RESP_REG,
> -	SMU_OUT_REG,
> -	SMU_MAX_REGS /* Keep this at the end */
> -};
> -
>   enum aie2_sram_reg_idx {
>   	MBOX_CHANN_OFF = 0,
>   	FW_ALIVE_OFF,
> @@ -183,7 +169,6 @@ struct amdxdna_dev_hdl {
>   	struct aie_device		aie;
>   	const struct amdxdna_dev_priv	*priv;
>   	void			__iomem *sram_base;
> -	void			__iomem *smu_base;
>   	void			__iomem *mbox_base;
>   
>   	u32				total_col;
> @@ -258,11 +243,6 @@ extern const struct dpm_clk_freq npu4_dpm_clk_table[];
>   extern const struct rt_config npu1_default_rt_cfg[];
>   extern const struct rt_config npu4_default_rt_cfg[];
>   extern const struct amdxdna_fw_feature_tbl npu4_fw_feature_table[];
> -
> -/* aie2_smu.c */
> -int aie2_smu_init(struct amdxdna_dev_hdl *ndev);
> -void aie2_smu_fini(struct amdxdna_dev_hdl *ndev);
> -int npu1_set_dpm(struct amdxdna_dev_hdl *ndev, u32 dpm_level);
>   int npu4_set_dpm(struct amdxdna_dev_hdl *ndev, u32 dpm_level);
>   
>   /* aie2_pm.c */
> diff --git a/drivers/accel/amdxdna/aie2_smu.c b/drivers/accel/amdxdna/aie2_smu.c
> deleted file mode 100644
> index 1b966bbef2e5..000000000000
> --- a/drivers/accel/amdxdna/aie2_smu.c
> +++ /dev/null
> @@ -1,156 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (C) 2022-2024, Advanced Micro Devices, Inc.
> - */
> -
> -#include <drm/drm_device.h>
> -#include <drm/drm_gem_shmem_helper.h>
> -#include <drm/drm_print.h>
> -#include <drm/gpu_scheduler.h>
> -#include <linux/iopoll.h>
> -
> -#include "aie2_pci.h"
> -#include "amdxdna_pci_drv.h"
> -
> -#define SMU_RESULT_OK		1
> -
> -/* SMU commands */
> -#define AIE2_SMU_POWER_ON		0x3
> -#define AIE2_SMU_POWER_OFF		0x4
> -#define AIE2_SMU_SET_MPNPUCLK_FREQ	0x5
> -#define AIE2_SMU_SET_HCLK_FREQ		0x6
> -#define AIE2_SMU_SET_SOFT_DPMLEVEL	0x7
> -#define AIE2_SMU_SET_HARD_DPMLEVEL	0x8
> -
> -#define NPU4_DPM_TOPS(ndev, dpm_level) \
> -({ \
> -	typeof(ndev) _ndev = ndev; \
> -	(4096 * (_ndev)->total_col * \
> -	 (_ndev)->priv->dpm_clk_tbl[dpm_level].hclk / 1000000); \
> -})
> -
> -static int aie2_smu_exec(struct amdxdna_dev_hdl *ndev, u32 reg_cmd,
> -			 u32 reg_arg, u32 *out)
> -{
> -	u32 resp;
> -	int ret;
> -
> -	writel(0, SMU_REG(ndev, SMU_RESP_REG));
> -	writel(reg_arg, SMU_REG(ndev, SMU_ARG_REG));
> -	writel(reg_cmd, SMU_REG(ndev, SMU_CMD_REG));
> -
> -	/* Clear and set SMU_INTR_REG to kick off */
> -	writel(0, SMU_REG(ndev, SMU_INTR_REG));
> -	writel(1, SMU_REG(ndev, SMU_INTR_REG));
> -
> -	ret = readx_poll_timeout(readl, SMU_REG(ndev, SMU_RESP_REG), resp,
> -				 resp, AIE_INTERVAL, AIE_TIMEOUT);
> -	if (ret) {
> -		XDNA_ERR(ndev->aie.xdna, "smu cmd %d timed out", reg_cmd);
> -		return ret;
> -	}
> -
> -	if (out)
> -		*out = readl(SMU_REG(ndev, SMU_OUT_REG));
> -
> -	if (resp != SMU_RESULT_OK) {
> -		XDNA_ERR(ndev->aie.xdna, "smu cmd %d failed, 0x%x", reg_cmd, resp);
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -int npu1_set_dpm(struct amdxdna_dev_hdl *ndev, u32 dpm_level)
> -{
> -	u32 freq;
> -	int ret;
> -
> -	ret = aie2_smu_exec(ndev, AIE2_SMU_SET_MPNPUCLK_FREQ,
> -			    ndev->priv->dpm_clk_tbl[dpm_level].npuclk, &freq);
> -	if (ret) {
> -		XDNA_ERR(ndev->aie.xdna, "Set npu clock to %d failed, ret %d\n",
> -			 ndev->priv->dpm_clk_tbl[dpm_level].npuclk, ret);
> -		return ret;
> -	}
> -	ndev->npuclk_freq = freq;
> -
> -	ret = aie2_smu_exec(ndev, AIE2_SMU_SET_HCLK_FREQ,
> -			    ndev->priv->dpm_clk_tbl[dpm_level].hclk, &freq);
> -	if (ret) {
> -		XDNA_ERR(ndev->aie.xdna, "Set h clock to %d failed, ret %d\n",
> -			 ndev->priv->dpm_clk_tbl[dpm_level].hclk, ret);
> -		return ret;
> -	}
> -
> -	ndev->hclk_freq = freq;
> -	ndev->max_tops = 2 * ndev->total_col;
> -	ndev->curr_tops = ndev->max_tops * freq / 1028;
> -
> -	XDNA_DBG(ndev->aie.xdna, "MP-NPU clock %d, H clock %d\n",
> -		 ndev->npuclk_freq, ndev->hclk_freq);
> -
> -	return 0;
> -}
> -
> -int npu4_set_dpm(struct amdxdna_dev_hdl *ndev, u32 dpm_level)
> -{
> -	int ret;
> -
> -	ret = aie2_smu_exec(ndev, AIE2_SMU_SET_HARD_DPMLEVEL, dpm_level, NULL);
> -	if (ret) {
> -		XDNA_ERR(ndev->aie.xdna, "Set hard dpm level %d failed, ret %d ",
> -			 dpm_level, ret);
> -		return ret;
> -	}
> -
> -	ret = aie2_smu_exec(ndev, AIE2_SMU_SET_SOFT_DPMLEVEL, dpm_level, NULL);
> -	if (ret) {
> -		XDNA_ERR(ndev->aie.xdna, "Set soft dpm level %d failed, ret %d",
> -			 dpm_level, ret);
> -		return ret;
> -	}
> -
> -	ndev->npuclk_freq = ndev->priv->dpm_clk_tbl[dpm_level].npuclk;
> -	ndev->hclk_freq = ndev->priv->dpm_clk_tbl[dpm_level].hclk;
> -	ndev->max_tops = NPU4_DPM_TOPS(ndev, ndev->max_dpm_level);
> -	ndev->curr_tops = NPU4_DPM_TOPS(ndev, dpm_level);
> -
> -	XDNA_DBG(ndev->aie.xdna, "MP-NPU clock %d, H clock %d\n",
> -		 ndev->npuclk_freq, ndev->hclk_freq);
> -
> -	return 0;
> -}
> -
> -int aie2_smu_init(struct amdxdna_dev_hdl *ndev)
> -{
> -	int ret;
> -
> -	/*
> -	 * Failing to set power off indicates an unrecoverable hardware or
> -	 * firmware error.
> -	 */
> -	ret = aie2_smu_exec(ndev, AIE2_SMU_POWER_OFF, 0, NULL);
> -	if (ret) {
> -		XDNA_ERR(ndev->aie.xdna, "Access power failed, ret %d", ret);
> -		return ret;
> -	}
> -
> -	ret = aie2_smu_exec(ndev, AIE2_SMU_POWER_ON, 0, NULL);
> -	if (ret) {
> -		XDNA_ERR(ndev->aie.xdna, "Power on failed, ret %d", ret);
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
> -void aie2_smu_fini(struct amdxdna_dev_hdl *ndev)
> -{
> -	int ret;
> -
> -	ndev->priv->hw_ops.set_dpm(ndev, 0);
> -	ret = aie2_smu_exec(ndev, AIE2_SMU_POWER_OFF, 0, NULL);
> -	if (ret)
> -		XDNA_ERR(ndev->aie.xdna, "Power off failed, ret %d", ret);
> -}
> diff --git a/drivers/accel/amdxdna/aie_smu.c b/drivers/accel/amdxdna/aie_smu.c
> new file mode 100644
> index 000000000000..62aea550aabc
> --- /dev/null
> +++ b/drivers/accel/amdxdna/aie_smu.c
> @@ -0,0 +1,153 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026, Advanced Micro Devices, Inc.
> + */
> +
> +#include "drm/amdxdna_accel.h"
> +#include <drm/drm_device.h>
> +#include <drm/drm_managed.h>
> +#include <drm/drm_print.h>
> +#include <drm/gpu_scheduler.h>
> +#include <linux/iopoll.h>
> +
> +#include "aie.h"
> +
> +#define SMU_RESULT_OK   1
> +
> +/* SMU commands */
> +#define AIE_SMU_POWER_ON                0x3
> +#define AIE_SMU_POWER_OFF               0x4
> +#define AIE_SMU_SET_MPNPUCLK_FREQ       0x5
> +#define AIE_SMU_SET_HCLK_FREQ           0x6
> +#define AIE_SMU_SET_SOFT_DPMLEVEL       0x7
> +#define AIE_SMU_SET_HARD_DPMLEVEL       0x8
> +
> +#define SMU_REG(s, reg) ((s)->smu_regs[reg])
> +
> +struct smu_device {
> +	struct drm_device	*ddev;
> +	struct smu_config	conf;
> +	void __iomem		*smu_regs[SMU_MAX_REGS];
> +};
> +
> +static int aie_smu_exec(struct smu_device *smu, u32 reg_cmd, u32 reg_arg, u32 *out)
> +{
> +	u32 resp;
> +	int ret;
> +
> +	writel(0, SMU_REG(smu, SMU_RESP_REG));
> +	writel(reg_arg, SMU_REG(smu, SMU_ARG_REG));
> +	writel(reg_cmd, SMU_REG(smu, SMU_CMD_REG));
> +
> +	/* Clear and set SMU_INTR_REG to kick off */
> +	writel(0, SMU_REG(smu, SMU_INTR_REG));
> +	writel(1, SMU_REG(smu, SMU_INTR_REG));
> +
> +	ret = readx_poll_timeout(readl, SMU_REG(smu, SMU_RESP_REG), resp,
> +				 resp, AIE_INTERVAL, AIE_TIMEOUT);
> +	if (ret) {
> +		drm_err(smu->ddev, "smu cmd %d timed out", reg_cmd);
> +		return ret;
> +	}
> +
> +	if (out)
> +		*out = readl(SMU_REG(smu, SMU_OUT_REG));
> +
> +	if (resp != SMU_RESULT_OK) {
> +		drm_err(smu->ddev, "smu cmd %d failed, 0x%x", reg_cmd, resp);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +int aie_smu_init(struct smu_device *smu)
> +{
> +	int ret;
> +
> +	/*
> +	 * Failing to set power off indicates an unrecoverable hardware or
> +	 * firmware error.
> +	 */
> +	ret = aie_smu_exec(smu, AIE_SMU_POWER_OFF, 0, NULL);
> +	if (ret) {
> +		drm_err(smu->ddev, "Access power failed, ret %d", ret);
> +		return ret;
> +	}
> +
> +	ret = aie_smu_exec(smu, AIE_SMU_POWER_ON, 0, NULL);
> +	if (ret) {
> +		drm_err(smu->ddev, "Power on failed, ret %d", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +void aie_smu_fini(struct smu_device *smu)
> +{
> +	int ret;
> +
> +	ret = aie_smu_exec(smu, AIE_SMU_POWER_OFF, 0, NULL);
> +	if (ret)
> +		drm_err(smu->ddev, "Power off failed, ret %d", ret);
> +}
> +
> +int aie_smu_set_clocks(struct smu_device *smu, u32 *npuclk, u32 *hclk)
> +{
> +	int ret;
> +
> +	if (npuclk) {
> +		ret = aie_smu_exec(smu, AIE_SMU_SET_MPNPUCLK_FREQ, *npuclk, npuclk);
> +		if (ret) {
> +			drm_err(smu->ddev, "Set mpnpu clock to %d failed, ret %d", *npuclk, ret);
> +			return ret;
> +		}
> +	}
> +
> +	if (hclk) {
> +		ret = aie_smu_exec(smu, AIE_SMU_SET_HCLK_FREQ, *hclk, hclk);
> +		if (ret) {
> +			drm_err(smu->ddev, "Set hclock to %d failed, ret %d",
> +				*hclk, ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +int aie_smu_set_dpm(struct smu_device *smu, u32 dpm_level)
> +{
> +	int ret;
> +
> +	ret = aie_smu_exec(smu, AIE_SMU_SET_HARD_DPMLEVEL, dpm_level, NULL);
> +	if (ret) {
> +		drm_err(smu->ddev, "Set hard dpm level %d failed, ret %d",
> +			dpm_level, ret);
> +		return ret;
> +	}
> +
> +	ret = aie_smu_exec(smu, AIE_SMU_SET_SOFT_DPMLEVEL, dpm_level, NULL);
> +	if (ret) {
> +		drm_err(smu->ddev, "Set soft dpm level %d failed, ret %d",
> +			dpm_level, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +struct smu_device *aiem_smu_create(struct drm_device *ddev, struct smu_config *conf)
> +{
> +	struct smu_device *smu;
> +
> +	smu = drmm_kzalloc(ddev, sizeof(*smu), GFP_KERNEL);
> +	if (!smu)
> +		return NULL;
> +
> +	smu->ddev = ddev;
> +	memcpy(smu->smu_regs, conf->smu_regs, sizeof(smu->smu_regs));
> +
> +	return smu;
> +}
> diff --git a/drivers/accel/amdxdna/npu1_regs.c b/drivers/accel/amdxdna/npu1_regs.c
> index 2ea7568a2e99..a83e44f378ad 100644
> --- a/drivers/accel/amdxdna/npu1_regs.c
> +++ b/drivers/accel/amdxdna/npu1_regs.c
> @@ -71,6 +71,27 @@ static const struct amdxdna_fw_feature_tbl npu1_fw_feature_table[] = {
>   	{ 0 }
>   };
>   
> +static int npu1_set_dpm(struct amdxdna_dev_hdl *ndev, u32 dpm_level)
> +{
> +	u32 npuclk, hclk;
> +	int ret;
> +
> +	npuclk = ndev->priv->dpm_clk_tbl[dpm_level].npuclk;
> +	hclk = ndev->priv->dpm_clk_tbl[dpm_level].hclk;
> +	ret = aie_smu_set_clocks(ndev->aie.smu_hdl, &npuclk, &hclk);
> +	if (ret)
> +		return ret;
> +
> +	ndev->npuclk_freq = npuclk;
> +	ndev->hclk_freq = hclk;
> +	ndev->max_tops = 2 * ndev->total_col;
> +	ndev->curr_tops = ndev->max_tops * hclk / 1028;
> +
> +	XDNA_DBG(ndev->aie.xdna, "MP-NPU clock %d, H clock %d\n",
> +		 ndev->npuclk_freq, ndev->hclk_freq);
> +	return 0;
> +}
> +
>   static const struct amdxdna_dev_priv npu1_dev_priv = {
>   	.fw_path        = "amdnpu/1502_00/",
>   	.rt_config	= npu1_default_rt_cfg,
> diff --git a/drivers/accel/amdxdna/npu4_regs.c b/drivers/accel/amdxdna/npu4_regs.c
> index 9689c56c83be..5d68171f4ec2 100644
> --- a/drivers/accel/amdxdna/npu4_regs.c
> +++ b/drivers/accel/amdxdna/npu4_regs.c
> @@ -63,6 +63,13 @@
>   #define NPU4_SMU_BAR_BASE	MMNPU_APERTURE4_BASE
>   #define NPU4_SRAM_BAR_BASE	MMNPU_APERTURE1_BASE
>   
> +#define NPU4_DPM_TOPS(ndev, dpm_level) \
> +({ \
> +	typeof(ndev) _ndev = ndev; \
> +	(4096 * (_ndev)->total_col * \
> +	 (_ndev)->priv->dpm_clk_tbl[dpm_level].hclk / 1000000); \
> +})
> +
>   const struct rt_config npu4_default_rt_cfg[] = {
>   	{ 5, 1, AIE2_RT_CFG_INIT }, /* PDI APP LOAD MODE */
>   	{ 10, 1, AIE2_RT_CFG_INIT }, /* DEBUG BUF */
> @@ -98,6 +105,25 @@ const struct amdxdna_fw_feature_tbl npu4_fw_feature_table[] = {
>   	{ 0 }
>   };
>   
> +int npu4_set_dpm(struct amdxdna_dev_hdl *ndev, u32 dpm_level)
> +{
> +	int ret;
> +
> +	ret = aie_smu_set_dpm(ndev->aie.smu_hdl, dpm_level);
> +	if (ret)
> +		return ret;
> +
> +	ndev->npuclk_freq = ndev->priv->dpm_clk_tbl[dpm_level].npuclk;
> +	ndev->hclk_freq = ndev->priv->dpm_clk_tbl[dpm_level].hclk;
> +	ndev->max_tops = NPU4_DPM_TOPS(ndev, ndev->max_dpm_level);
> +	ndev->curr_tops = NPU4_DPM_TOPS(ndev, dpm_level);
> +
> +	XDNA_DBG(ndev->aie.xdna, "MP-NPU clock %d, H clock %d\n",
> +		 ndev->npuclk_freq, ndev->hclk_freq);
> +
> +	return 0;
> +}
> +
>   static const struct amdxdna_dev_priv npu4_dev_priv = {
>   	.fw_path        = "amdnpu/17f0_10/",
>   	.rt_config	= npu4_default_rt_cfg,

