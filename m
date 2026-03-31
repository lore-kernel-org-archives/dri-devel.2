Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADAC010F92E0
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 16:31:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 193C810EB33;
	Tue, 31 Mar 2026 16:31:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="j32W9O8F";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 400BD10EB33
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 16:31:14 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 8374F6111A;
 Tue, 31 Mar 2026 16:31:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365A0C19424;
 Tue, 31 Mar 2026 16:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774974673;
 bh=UNyP39XlbdLTd1VzhlRUnz9mhMQmImfYqCJ1qa+JEbw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=j32W9O8FkbR80tjp7Rh96yXHtd3mnVdaNVOAfbju8tDLKvCz1S4ID991ZIvz4V3eS
 Q2gR4ePF6oOLF/OXqpf62znowyLfFcRpj1lYyocAcgjt9/W4nLnN4+JpzPRS6cWzmg
 CQQ0qy2qAc2K793ij9HKrFHgOHipy6Uk4k2ThWBWwaOXy8KrvMqmHW06dfKeN889Tm
 Qv4Rb4VJs6H2NoWQOML+in1cegTJEfRHhQODU6sdZjujkxrz6ribLQR03+bSX/UdCu
 5YBrZEmgbJHV7ZYRwm2eon9rdf45NUzbscTsAwAHG5FlkkirqPGF+3BLVMvkpYMMF0
 AMOXK5vUcT0Cw==
Message-ID: <f4f7b6a0-f9ba-49df-871e-889d7f44f8b5@kernel.org>
Date: Tue, 31 Mar 2026 11:31:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 2/6] accel/amdxdna: Add basic support for AIE4 devices
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 maciej.falkowski@linux.intel.com
Cc: David Zhang <yidong.zhang@amd.com>, linux-kernel@vger.kernel.org,
 max.zhen@amd.com, sonal.santan@amd.com,
 Hayden Laccabue <Hayden.Laccabue@amd.com>
References: <20260330163705.3153647-1-lizhi.hou@amd.com>
 <20260330163705.3153647-3-lizhi.hou@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260330163705.3153647-3-lizhi.hou@amd.com>
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
> Add initial support for AIE4 devices (PCI device IDs 0x17F2 and 0x1B0B),
> including:
>    Device initialization
>    Basic mailbox communication
>    SR-IOV enablement
> 
> This lays the groundwork for full AIE4 support.
> 
> Co-developed-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
> Signed-off-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
> Signed-off-by: David Zhang <yidong.zhang@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/accel/amdxdna/Makefile          |   5 +
>   drivers/accel/amdxdna/aie.h             |   3 +
>   drivers/accel/amdxdna/aie2_pci.c        |   2 +-
>   drivers/accel/amdxdna/aie2_pci.h        |   3 -
>   drivers/accel/amdxdna/aie2_smu.c        |   2 +-
>   drivers/accel/amdxdna/aie4_message.c    |  27 ++
>   drivers/accel/amdxdna/aie4_msg_priv.h   |  49 ++++
>   drivers/accel/amdxdna/aie4_pci.c        | 364 ++++++++++++++++++++++++
>   drivers/accel/amdxdna/aie4_pci.h        |  48 ++++
>   drivers/accel/amdxdna/aie4_sriov.c      |  88 ++++++
>   drivers/accel/amdxdna/amdxdna_mailbox.c |  19 +-
>   drivers/accel/amdxdna/amdxdna_mailbox.h |   8 +-
>   drivers/accel/amdxdna/amdxdna_pci_drv.c |  19 +-
>   drivers/accel/amdxdna/amdxdna_pci_drv.h |   2 +
>   drivers/accel/amdxdna/npu3_regs.c       |  39 +++
>   include/uapi/drm/amdxdna_accel.h        |   3 +-
>   16 files changed, 666 insertions(+), 15 deletions(-)
>   create mode 100644 drivers/accel/amdxdna/aie4_message.c
>   create mode 100644 drivers/accel/amdxdna/aie4_msg_priv.h
>   create mode 100644 drivers/accel/amdxdna/aie4_pci.c
>   create mode 100644 drivers/accel/amdxdna/aie4_pci.h
>   create mode 100644 drivers/accel/amdxdna/aie4_sriov.c
>   create mode 100644 drivers/accel/amdxdna/npu3_regs.c
> 
> diff --git a/drivers/accel/amdxdna/Makefile b/drivers/accel/amdxdna/Makefile
> index 5c7911554c46..a61cd6c0db30 100644
> --- a/drivers/accel/amdxdna/Makefile
> +++ b/drivers/accel/amdxdna/Makefile
> @@ -10,6 +10,8 @@ amdxdna-y := \
>   	aie2_psp.o \
>   	aie2_smu.o \
>   	aie2_solver.o \
> +	aie4_message.o \
> +	aie4_pci.o \
>   	amdxdna_ctx.o \
>   	amdxdna_gem.o \
>   	amdxdna_iommu.o \
> @@ -20,7 +22,10 @@ amdxdna-y := \
>   	amdxdna_sysfs.o \
>   	amdxdna_ubuf.o \
>   	npu1_regs.o \
> +	npu3_regs.o \
>   	npu4_regs.o \
>   	npu5_regs.o \
>   	npu6_regs.o
> +
> +amdxdna-$(CONFIG_PCI_IOV) += aie4_sriov.o
>   obj-$(CONFIG_DRM_ACCEL_AMDXDNA) = amdxdna.o
> diff --git a/drivers/accel/amdxdna/aie.h b/drivers/accel/amdxdna/aie.h
> index 1bea14b79c7c..6c53870d0098 100644
> --- a/drivers/accel/amdxdna/aie.h
> +++ b/drivers/accel/amdxdna/aie.h
> @@ -8,6 +8,9 @@
>   #include "amdxdna_pci_drv.h"
>   #include "amdxdna_mailbox.h"
>   
> +#define AIE_INTERVAL	20000	/* us */
> +#define AIE_TIMEOUT	1000000	/* us */
> +
>   struct aie_device {
>   	struct amdxdna_dev *xdna;
>   	struct mailbox_channel *mgmt_chann;
> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
> index 03bac963516d..708d0b7fd2e3 100644
> --- a/drivers/accel/amdxdna/aie2_pci.c
> +++ b/drivers/accel/amdxdna/aie2_pci.c
> @@ -79,7 +79,7 @@ static int aie2_get_mgmt_chann_info(struct amdxdna_dev_hdl *ndev)
>   	 * is alive.
>   	 */
>   	ret = readx_poll_timeout(readl, SRAM_GET_ADDR(ndev, FW_ALIVE_OFF),
> -				 addr, addr, AIE2_INTERVAL, AIE2_TIMEOUT);
> +				 addr, addr, AIE_INTERVAL, AIE_TIMEOUT);
>   	if (ret || !addr)
>   		return -ETIME;
>   
> diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
> index 90fb0aafaf40..96960a2219a4 100644
> --- a/drivers/accel/amdxdna/aie2_pci.h
> +++ b/drivers/accel/amdxdna/aie2_pci.h
> @@ -14,9 +14,6 @@
>   #include "aie2_msg_priv.h"
>   #include "amdxdna_mailbox.h"
>   
> -#define AIE2_INTERVAL	20000	/* us */
> -#define AIE2_TIMEOUT	1000000	/* us */
> -
>   /* Firmware determines device memory base address and size */
>   #define AIE2_DEVM_BASE	0x4000000
>   #define AIE2_DEVM_SIZE	SZ_64M
> diff --git a/drivers/accel/amdxdna/aie2_smu.c b/drivers/accel/amdxdna/aie2_smu.c
> index 727637dac3a8..1b966bbef2e5 100644
> --- a/drivers/accel/amdxdna/aie2_smu.c
> +++ b/drivers/accel/amdxdna/aie2_smu.c
> @@ -44,7 +44,7 @@ static int aie2_smu_exec(struct amdxdna_dev_hdl *ndev, u32 reg_cmd,
>   	writel(1, SMU_REG(ndev, SMU_INTR_REG));
>   
>   	ret = readx_poll_timeout(readl, SMU_REG(ndev, SMU_RESP_REG), resp,
> -				 resp, AIE2_INTERVAL, AIE2_TIMEOUT);
> +				 resp, AIE_INTERVAL, AIE_TIMEOUT);
>   	if (ret) {
>   		XDNA_ERR(ndev->aie.xdna, "smu cmd %d timed out", reg_cmd);
>   		return ret;
> diff --git a/drivers/accel/amdxdna/aie4_message.c b/drivers/accel/amdxdna/aie4_message.c
> new file mode 100644
> index 000000000000..d621dd32ac40
> --- /dev/null
> +++ b/drivers/accel/amdxdna/aie4_message.c
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026, Advanced Micro Devices, Inc.
> + */
> +
> +#include <drm/amdxdna_accel.h>
> +#include <drm/drm_print.h>
> +#include <linux/mutex.h>
> +
> +#include "aie.h"
> +#include "aie4_msg_priv.h"
> +#include "aie4_pci.h"
> +#include "amdxdna_mailbox.h"
> +#include "amdxdna_mailbox_helper.h"
> +#include "amdxdna_pci_drv.h"
> +
> +int aie4_suspend_fw(struct amdxdna_dev_hdl *ndev)
> +{
> +	DECLARE_AIE_MSG(aie4_msg_suspend, AIE4_MSG_OP_SUSPEND);
> +	int ret;
> +
> +	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
> +	if (ret)
> +		XDNA_ERR(ndev->aie.xdna, "Failed to suspend fw, ret %d", ret);
> +
> +	return ret;
> +}
> diff --git a/drivers/accel/amdxdna/aie4_msg_priv.h b/drivers/accel/amdxdna/aie4_msg_priv.h
> new file mode 100644
> index 000000000000..88463cc3a98a
> --- /dev/null
> +++ b/drivers/accel/amdxdna/aie4_msg_priv.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2026, Advanced Micro Devices, Inc.
> + */
> +
> +#ifndef _AIE4_MSG_PRIV_H_
> +#define _AIE4_MSG_PRIV_H_
> +
> +#include <linux/types.h>
> +
> +enum aie4_msg_opcode {
> +	AIE4_MSG_OP_SUSPEND                          = 0x10003,
> +
> +	AIE4_MSG_OP_CREATE_VFS                       = 0x20001,
> +	AIE4_MSG_OP_DESTROY_VFS                      = 0x20002,
> +};
> +
> +enum aie4_msg_status {
> +	AIE4_MSG_STATUS_SUCCESS = 0x0,
> +	AIE4_MSG_STATUS_ERROR = 0x1,
> +	AIE4_MSG_STATUS_NOTSUPP = 0x2,
> +	MAX_AIE4_MSG_STATUS_CODE = 0x4,
> +};
> +
> +struct aie4_msg_suspend_req {
> +	__u32 rsvd;
> +} __packed;
> +
> +struct aie4_msg_suspend_resp {
> +	enum aie4_msg_status status;
> +} __packed;
> +
> +struct aie4_msg_create_vfs_req {
> +	__u32 vf_cnt;
> +} __packed;
> +
> +struct aie4_msg_create_vfs_resp {
> +	enum aie4_msg_status status;
> +} __packed;
> +
> +struct aie4_msg_destroy_vfs_req {
> +	__u32 rsvd;
> +} __packed;
> +
> +struct aie4_msg_destroy_vfs_resp {
> +	enum aie4_msg_status status;
> +} __packed;
> +
> +#endif /* _AIE4_MSG_PRIV_H_ */
> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
> new file mode 100644
> index 000000000000..0f360c1ccebd
> --- /dev/null
> +++ b/drivers/accel/amdxdna/aie4_pci.c
> @@ -0,0 +1,364 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026, Advanced Micro Devices, Inc.
> + */
> +
> +#include <drm/amdxdna_accel.h>
> +#include <drm/drm_managed.h>
> +#include <drm/drm_print.h>
> +
> +#include "aie4_pci.h"
> +#include "amdxdna_pci_drv.h"
> +
> +#define NO_IOHUB	0
> +
> +/*
> + * The management mailbox channel is allocated by firmware.
> + * The related register and ring buffer information is on SRAM BAR.
> + * This struct is the register layout.
> + */
> +struct mailbox_info {
> +	__u32 valid;
> +	__u32 protocol_major;
> +	__u32 protocol_minor;
> +	__u32 x2i_tail_offset;
> +	__u32 x2i_head_offset;
> +	__u32 x2i_buffer_addr;
> +	__u32 x2i_buffer_size;
> +	__u32 i2x_tail_offset;
> +	__u32 i2x_head_offset;
> +	__u32 i2x_buffer_addr;
> +	__u32 i2x_buffer_size;
> +	__u32 i2x_msi_idx;
> +	__u32 reserved[4];
> +};
> +
> +static int aie4_fw_is_alive(struct amdxdna_dev *xdna)
> +{
> +	const struct amdxdna_dev_priv *npriv = xdna->dev_info->dev_priv;
> +	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
> +	u32 __iomem *src;
> +	u32 fw_is_valid;
> +	int ret;
> +
> +	src = ndev->rbuf_base + npriv->mbox_info_off;
> +
> +	ret = readx_poll_timeout(readl, src + offsetof(struct mailbox_info, valid),
> +				 fw_is_valid, (fw_is_valid == 0x1),
> +				 AIE_INTERVAL, AIE_TIMEOUT);
> +	if (ret)
> +		XDNA_ERR(xdna, "fw_is_valid=%d after %d ms",
> +			 fw_is_valid, DIV_ROUND_CLOSEST(AIE_TIMEOUT, 1000000));
> +
> +	return ret;
> +}
> +
> +static void aie4_read_mbox_info(struct amdxdna_dev *xdna,
> +				struct mailbox_info *mbox_info)
> +{
> +	const struct amdxdna_dev_priv *npriv = xdna->dev_info->dev_priv;
> +	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
> +	u32 *dst = (u32 *)mbox_info;
> +	u32 __iomem *src;
> +	int i;
> +
> +	src = ndev->rbuf_base + npriv->mbox_info_off;
> +
> +	for (i = 0; i < sizeof(*mbox_info) / sizeof(u32); i++)
> +		dst[i] = readl(&src[i]);
> +}
> +
> +static int aie4_mailbox_info(struct amdxdna_dev *xdna,
> +			     struct mailbox_info *mbox_info)
> +{
> +	int ret;
> +
> +	ret = aie4_fw_is_alive(xdna);
> +	if (ret)
> +		return ret;
> +
> +	aie4_read_mbox_info(xdna, mbox_info);
> +
> +	ret = aie_check_protocol(&xdna->dev_handle->aie,
> +				 mbox_info->protocol_major,
> +				 mbox_info->protocol_minor);
> +	if (ret)
> +		XDNA_ERR(xdna, "mailbox major.minor %d.%d is not supported",
> +			 mbox_info->protocol_major, mbox_info->protocol_minor);
> +
> +	return ret;
> +}
> +
> +static void aie4_mailbox_fini(struct amdxdna_dev_hdl *ndev)
> +{
> +	struct amdxdna_dev *xdna = ndev->aie.xdna;
> +
> +	aie_destroy_chann(&ndev->aie, &ndev->aie.mgmt_chann);
> +	drmm_kfree(&xdna->ddev, ndev->mbox);
> +	ndev->mbox = NULL;
> +}
> +
> +static int aie4_irq_init(struct amdxdna_dev *xdna)
> +{
> +	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
> +	int ret, nvec;
> +
> +	nvec = pci_msix_vec_count(pdev);
> +	XDNA_DBG(xdna, "irq vectors:%d", nvec);
> +	if (nvec <= 0) {
> +		XDNA_ERR(xdna, "does not get number of interrupt vector");
> +		return -EINVAL;
> +	}
> +
> +	ret = pci_alloc_irq_vectors(pdev, nvec, nvec, PCI_IRQ_MSIX);
> +	if (ret < 0) {
> +		XDNA_ERR(xdna, "failed to alloc irq vector, ret: %d", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int aie4_mailbox_start(struct amdxdna_dev *xdna,
> +			      struct mailbox_info *mbi)
> +{
> +	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
> +	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
> +	const struct amdxdna_dev_priv *npriv = xdna->dev_info->dev_priv;
> +	struct xdna_mailbox_chann_res *i2x;
> +	struct xdna_mailbox_chann_res *x2i;
> +	int mgmt_mb_irq;
> +	int ret;
> +
> +	struct xdna_mailbox_res mbox_res = {
> +		.ringbuf_base = ndev->rbuf_base,
> +		.ringbuf_size = pci_resource_len(pdev, npriv->mbox_rbuf_bar),
> +		.mbox_base = ndev->mbox_base,
> +		.mbox_size = pci_resource_len(pdev, npriv->mbox_bar),
> +		.name = "xdna_aie4_mailbox",
> +	};
> +
> +	i2x = &ndev->aie.mgmt_i2x;
> +	x2i = &ndev->aie.mgmt_x2i;
> +
> +	x2i->mb_head_ptr_reg = mbi->x2i_head_offset;
> +	x2i->mb_tail_ptr_reg = mbi->x2i_tail_offset;
> +	x2i->rb_start_addr = mbi->x2i_buffer_addr;
> +	x2i->rb_size = mbi->x2i_buffer_size;
> +
> +	i2x->rb_start_addr = mbi->i2x_buffer_addr;
> +	i2x->rb_size = mbi->i2x_buffer_size;
> +	i2x->mb_head_ptr_reg = mbi->i2x_head_offset;
> +	i2x->mb_tail_ptr_reg = mbi->i2x_tail_offset;
> +
> +	ndev->aie.mgmt_chan_idx = mbi->i2x_msi_idx;
> +	aie_dump_mgmt_chann_debug(&ndev->aie);
> +
> +	ndev->mbox = xdnam_mailbox_create(&xdna->ddev, &mbox_res);
> +	if (!ndev->mbox) {
> +		XDNA_ERR(xdna, "failed to create mailbox device");
> +		return -ENODEV;
> +	}
> +
> +	ndev->aie.mgmt_chann = xdna_mailbox_alloc_channel(ndev->mbox);
> +	if (!ndev->aie.mgmt_chann) {
> +		XDNA_ERR(xdna, "failed to alloc mailbox channel");
> +		return -ENODEV;
> +	}
> +
> +	mgmt_mb_irq = pci_irq_vector(pdev, ndev->aie.mgmt_chan_idx);
> +	if (mgmt_mb_irq < 0) {
> +		XDNA_ERR(xdna, "failed to alloc irq vector, return %d", mgmt_mb_irq);
> +		ret = mgmt_mb_irq;
> +		goto free_channel;
> +	}
> +
> +	ret = xdna_mailbox_start_channel(ndev->aie.mgmt_chann,
> +					 &ndev->aie.mgmt_x2i,
> +					 &ndev->aie.mgmt_i2x,
> +					 NO_IOHUB,
> +					 mgmt_mb_irq);
> +	if (ret) {
> +		XDNA_ERR(xdna, "failed to start management mailbox channel");
> +		ret = -EINVAL;
> +		goto free_channel;
> +	}
> +
> +	XDNA_DBG(xdna, "Mailbox management channel created");
> +	return 0;
> +
> +free_channel:
> +	xdna_mailbox_free_channel(ndev->aie.mgmt_chann);
> +	ndev->aie.mgmt_chann = NULL;
> +	return ret;
> +}
> +
> +static int aie4_mailbox_init(struct amdxdna_dev *xdna)
> +{
> +	struct mailbox_info mbox_info;
> +	int ret;
> +
> +	ret = aie4_mailbox_info(xdna, &mbox_info);
> +	if (ret)
> +		return ret;
> +
> +	return aie4_mailbox_start(xdna, &mbox_info);
> +}
> +
> +static void aie4_fw_unload(struct amdxdna_dev_hdl *ndev)
> +{
> +	/* TODO */
> +}
> +
> +static int aie4_fw_load(struct amdxdna_dev_hdl *ndev)
> +{
> +	/* TODO */
> +	return 0;
> +}
> +
> +static int aie4_hw_start(struct amdxdna_dev *xdna)
> +{
> +	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
> +	int ret;
> +
> +	ret = aie4_fw_load(ndev);
> +	if (ret)
> +		return ret;
> +
> +	ret = aie4_mailbox_init(xdna);
> +	if (ret)
> +		goto fw_unload;
> +
> +	return 0;
> +
> +fw_unload:
> +	aie4_fw_unload(ndev);
> +
> +	return ret;
> +}
> +
> +static void aie4_mgmt_fw_fini(struct amdxdna_dev_hdl *ndev)
> +{
> +	int ret;
> +
> +	/* No paired resume needed, fw is stateless */
> +	ret = aie4_suspend_fw(ndev);
> +	if (ret)
> +		XDNA_ERR(ndev->aie.xdna, "suspend_fw failed, ret %d", ret);
> +	else
> +		XDNA_DBG(ndev->aie.xdna, "npu firmware suspended");
> +}
> +
> +static void aie4_hw_stop(struct amdxdna_dev *xdna)
> +{
> +	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
> +
> +	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
> +
> +	aie4_mgmt_fw_fini(ndev);
> +	aie4_mailbox_fini(ndev);
> +
> +	aie4_fw_unload(ndev);
> +}
> +
> +static int aie4_pcidev_init(struct amdxdna_dev_hdl *ndev)
> +{
> +	struct amdxdna_dev *xdna = ndev->aie.xdna;
> +	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
> +	void __iomem *tbl[PCI_NUM_RESOURCES] = {0};
> +	unsigned long bars = 0;
> +	int ret, i;
> +
> +	/* Enable managed PCI device */
> +	ret = pcim_enable_device(pdev);
> +	if (ret) {
> +		XDNA_ERR(xdna, "pcim enable device failed, ret %d", ret);
> +		return ret;
> +	}
> +
> +	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> +	if (ret) {
> +		XDNA_ERR(xdna, "failed to set DMA mask to 64:%d", ret);
> +		return ret;
> +	}
> +
> +	set_bit(xdna->dev_info->mbox_bar, &bars);
> +	set_bit(xdna->dev_info->sram_bar, &bars);
> +
> +	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
> +		if (!test_bit(i, &bars))
> +			continue;
> +		tbl[i] = pcim_iomap(pdev, i, 0);
> +		if (!tbl[i]) {
> +			XDNA_ERR(xdna, "map bar %d failed", i);
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	ndev->mbox_base = tbl[xdna->dev_info->mbox_bar];
> +	ndev->rbuf_base = tbl[xdna->dev_info->sram_bar];
> +
> +	pci_set_master(pdev);
> +
> +	ret = aie4_irq_init(xdna);
> +	if (ret)
> +		goto clear_master;
> +
> +	ret = aie4_hw_start(xdna);
> +	if (ret)
> +		goto clear_master;
> +
> +	return 0;
> +
> +clear_master:
> +	pci_clear_master(pdev);
> +
> +	return ret;
> +}
> +
> +static void aie4_pcidev_fini(struct amdxdna_dev_hdl *ndev)
> +{
> +	struct amdxdna_dev *xdna = ndev->aie.xdna;
> +	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
> +
> +	aie4_hw_stop(xdna);
> +
> +	pci_clear_master(pdev);
> +}
> +
> +static void aie4_fini(struct amdxdna_dev *xdna)
> +{
> +	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
> +
> +	aie4_sriov_stop(ndev);
> +	aie4_pcidev_fini(ndev);
> +}
> +
> +static int aie4_init(struct amdxdna_dev *xdna)
> +{
> +	struct amdxdna_dev_hdl *ndev;
> +	int ret;
> +
> +	ndev = drmm_kzalloc(&xdna->ddev, sizeof(*ndev), GFP_KERNEL);
> +	if (!ndev)
> +		return -ENOMEM;
> +
> +	ndev->priv = xdna->dev_info->dev_priv;
> +	ndev->aie.xdna = xdna;
> +	xdna->dev_handle = ndev;
> +
> +	ret = aie4_pcidev_init(ndev);
> +	if (ret) {
> +		XDNA_ERR(xdna, "Setup PCI device failed, ret %d", ret);
> +		return ret;
> +	}
> +
> +	XDNA_DBG(xdna, "aie4 init finished");
> +	return 0;
> +}
> +
> +const struct amdxdna_dev_ops aie4_ops = {
> +	.init			= aie4_init,
> +	.fini			= aie4_fini,
> +	.sriov_configure        = aie4_sriov_configure,
> +};
> diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
> new file mode 100644
> index 000000000000..f3810a969431
> --- /dev/null
> +++ b/drivers/accel/amdxdna/aie4_pci.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2026, Advanced Micro Devices, Inc.
> + */
> +
> +#ifndef _AIE4_PCI_H_
> +#define _AIE4_PCI_H_
> +
> +#include <linux/device.h>
> +#include <linux/iopoll.h>
> +#include <linux/pci.h>
> +
> +#include "aie.h"
> +#include "amdxdna_mailbox.h"
> +
> +struct amdxdna_dev_priv {
> +	u32			mbox_bar;
> +	u32			mbox_rbuf_bar;
> +	u64			mbox_info_off;
> +};
> +
> +struct amdxdna_dev_hdl {
> +	struct aie_device		aie;
> +	const struct amdxdna_dev_priv	*priv;
> +	void			__iomem *mbox_base;
> +	void			__iomem *rbuf_base;
> +
> +	struct mailbox			*mbox;
> +};
> +
> +/* aie4_message.c */
> +int aie4_suspend_fw(struct amdxdna_dev_hdl *ndev);
> +
> +/* aie4_sriov.c */
> +#if IS_ENABLED(CONFIG_PCI_IOV)
> +int aie4_sriov_configure(struct amdxdna_dev *xdna, int num_vfs);
> +int aie4_sriov_stop(struct amdxdna_dev_hdl *ndev);
> +#else
> +#define aie4_sriov_configure NULL
> +static inline int aie4_sriov_stop(struct amdxdna_dev_hdl *ndev)
> +{
> +	return 0;
> +}
> +#endif
> +
> +extern const struct amdxdna_dev_ops aie4_ops;
> +
> +#endif /* _AIE4_PCI_H_ */
> diff --git a/drivers/accel/amdxdna/aie4_sriov.c b/drivers/accel/amdxdna/aie4_sriov.c
> new file mode 100644
> index 000000000000..e1ce633768a5
> --- /dev/null
> +++ b/drivers/accel/amdxdna/aie4_sriov.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026, Advanced Micro Devices, Inc.
> + */
> +
> +#include <drm/amdxdna_accel.h>
> +#include <drm/drm_print.h>
> +#include <linux/pci.h>
> +
> +#include "aie.h"
> +#include "aie4_msg_priv.h"
> +#include "aie4_pci.h"
> +#include "amdxdna_mailbox.h"
> +#include "amdxdna_mailbox_helper.h"
> +#include "amdxdna_pci_drv.h"
> +
> +static int aie4_destroy_vfs(struct amdxdna_dev_hdl *ndev)
> +{
> +	DECLARE_AIE_MSG(aie4_msg_destroy_vfs, AIE4_MSG_OP_DESTROY_VFS);
> +	int ret;
> +
> +	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
> +	if (ret)
> +		XDNA_ERR(ndev->aie.xdna, "destroy vfs op failed: %d", ret);
> +
> +	return ret;
> +}
> +
> +static int aie4_create_vfs(struct amdxdna_dev_hdl *ndev, int num_vfs)
> +{
> +	DECLARE_AIE_MSG(aie4_msg_create_vfs, AIE4_MSG_OP_CREATE_VFS);
> +	int ret;
> +
> +	req.vf_cnt = num_vfs;
> +	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
> +	if (ret)
> +		XDNA_ERR(ndev->aie.xdna, "create vfs op failed: %d", ret);
> +
> +	return ret;
> +}
> +
> +int aie4_sriov_stop(struct amdxdna_dev_hdl *ndev)
> +{
> +	struct amdxdna_dev *xdna = ndev->aie.xdna;
> +	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
> +	int ret;
> +
> +	if (!pci_num_vf(pdev))
> +		return 0;
> +
> +	ret = pci_vfs_assigned(pdev);
> +	if (ret) {
> +		XDNA_ERR(xdna, "VFs are still assigned to VMs");
> +		return -EPERM;
> +	}
> +
> +	pci_disable_sriov(pdev);
> +	return aie4_destroy_vfs(ndev);
> +}
> +
> +static int aie4_sriov_start(struct amdxdna_dev_hdl *ndev, int num_vfs)
> +{
> +	struct amdxdna_dev *xdna = ndev->aie.xdna;
> +	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
> +	int ret;
> +
> +	ret = aie4_create_vfs(ndev, num_vfs);
> +	if (ret)
> +		return ret;
> +
> +	ret = pci_enable_sriov(pdev, num_vfs);
> +	if (ret) {
> +		XDNA_ERR(xdna, "configure VFs failed, ret: %d", ret);
> +		aie4_destroy_vfs(ndev);
> +		return ret;
> +	}
> +
> +	return num_vfs;
> +}
> +
> +int aie4_sriov_configure(struct amdxdna_dev *xdna, int num_vfs)
> +{
> +	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
> +
> +	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
> +
> +	return (num_vfs) ? aie4_sriov_start(ndev, num_vfs) : aie4_sriov_stop(ndev);
> +}
> diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/amdxdna/amdxdna_mailbox.c
> index e681a090752d..84a7e92562ad 100644
> --- a/drivers/accel/amdxdna/amdxdna_mailbox.c
> +++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
> @@ -112,6 +112,18 @@ static u32 mailbox_reg_read(struct mailbox_channel *mb_chann, u32 mbox_reg)
>   	return readl(ringbuf_addr);
>   }
>   
> +static inline void mailbox_irq_acknowledge(struct mailbox_channel *mb_chann)
> +{
> +	if (mb_chann->iohub_int_addr)
> +		mailbox_reg_write(mb_chann, mb_chann->iohub_int_addr, 0);
> +}
> +
> +static inline u32 mailbox_irq_status(struct mailbox_channel *mb_chann)
> +{
> +	return (mb_chann->iohub_int_addr) ?
> +		mailbox_reg_read(mb_chann, mb_chann->iohub_int_addr) : 0;
> +}
> +
>   static inline void
>   mailbox_set_headptr(struct mailbox_channel *mb_chann, u32 headptr_val)
>   {
> @@ -199,7 +211,6 @@ mailbox_send_msg(struct mailbox_channel *mb_chann, struct mailbox_msg *mb_msg)
>   	start_addr = mb_chann->res[CHAN_RES_X2I].rb_start_addr;
>   	tmp_tail = tail + mb_msg->pkg_size;
>   
> -
>   check_again:
>   	if (tail >= head && tmp_tail > ringbuf_size) {
>   		write_addr = mb_chann->mb->res.ringbuf_base + start_addr + tail;
> @@ -357,7 +368,7 @@ static void mailbox_rx_worker(struct work_struct *rx_work)
>   	}
>   
>   again:
> -	mailbox_reg_write(mb_chann, mb_chann->iohub_int_addr, 0);
> +	mailbox_irq_acknowledge(mb_chann);
>   
>   	while (1) {
>   		/*
> @@ -382,7 +393,7 @@ static void mailbox_rx_worker(struct work_struct *rx_work)
>   	 * the interrupt register to make sure there is not any new response
>   	 * before exiting.
>   	 */
> -	if (mailbox_reg_read(mb_chann, mb_chann->iohub_int_addr))
> +	if (mailbox_irq_status(mb_chann))
>   		goto again;
>   }
>   
> @@ -520,7 +531,7 @@ xdna_mailbox_start_channel(struct mailbox_channel *mb_chann,
>   	}
>   
>   	mb_chann->bad_state = false;
> -	mailbox_reg_write(mb_chann, mb_chann->iohub_int_addr, 0);
> +	mailbox_irq_acknowledge(mb_chann);
>   
>   	MB_DBG(mb_chann, "Mailbox channel started (irq: %d)", mb_chann->msix_irq);
>   	return 0;
> diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.h b/drivers/accel/amdxdna/amdxdna_mailbox.h
> index 8b1e00945da4..2908404303ae 100644
> --- a/drivers/accel/amdxdna/amdxdna_mailbox.h
> +++ b/drivers/accel/amdxdna/amdxdna_mailbox.h
> @@ -1,10 +1,10 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
>   /*
> - * Copyright (C) 2022-2024, Advanced Micro Devices, Inc.
> + * Copyright (C) 2022-2026, Advanced Micro Devices, Inc.
>    */
>   
> -#ifndef _AIE2_MAILBOX_H_
> -#define _AIE2_MAILBOX_H_
> +#ifndef _AIE_MAILBOX_H_
> +#define _AIE_MAILBOX_H_
>   
>   struct mailbox;
>   struct mailbox_channel;
> @@ -124,4 +124,4 @@ void xdna_mailbox_stop_channel(struct mailbox_channel *mailbox_chann);
>   int xdna_mailbox_send_msg(struct mailbox_channel *mailbox_chann,
>   			  const struct xdna_mailbox_msg *msg, u64 tx_timeout);
>   
> -#endif /* _AIE2_MAILBOX_ */
> +#endif /* _AIE_MAILBOX_ */
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> index b50a7d1f8a11..09d7d88bb6f1 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> @@ -37,9 +37,10 @@ MODULE_FIRMWARE("amdnpu/17f0_11/npu_7.sbin");
>    * 0.6: Support preemption
>    * 0.7: Support getting power and utilization data
>    * 0.8: Support BO usage query
> + * 0.9: Add new device type AMDXDNA_DEV_TYPE_PF
>    */
>   #define AMDXDNA_DRIVER_MAJOR		0
> -#define AMDXDNA_DRIVER_MINOR		8
> +#define AMDXDNA_DRIVER_MINOR		9
>   
>   /*
>    * Bind the driver base on (vendor_id, device_id) pair and later use the
> @@ -49,6 +50,8 @@ MODULE_FIRMWARE("amdnpu/17f0_11/npu_7.sbin");
>   static const struct pci_device_id pci_ids[] = {
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x1502) },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x17f0) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x17f2) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x1B0B) },
>   	{0}
>   };
>   
> @@ -59,6 +62,8 @@ static const struct amdxdna_device_id amdxdna_ids[] = {
>   	{ 0x17f0, 0x10, &dev_npu4_info },
>   	{ 0x17f0, 0x11, &dev_npu5_info },
>   	{ 0x17f0, 0x20, &dev_npu6_info },
> +	{ 0x17f2, 0x10, &dev_npu3_pf_info },
> +	{ 0x1B0B, 0x10, &dev_npu3_pf_info },
>   	{0}
>   };
>   
> @@ -365,12 +370,24 @@ static const struct dev_pm_ops amdxdna_pm_ops = {
>   	RUNTIME_PM_OPS(amdxdna_pm_suspend, amdxdna_pm_resume, NULL)
>   };
>   
> +static int amdxdna_sriov_configure(struct pci_dev *pdev, int num_vfs)
> +{
> +	struct amdxdna_dev *xdna = pci_get_drvdata(pdev);
> +
> +	guard(mutex)(&xdna->dev_lock);
> +	if (xdna->dev_info->ops->sriov_configure)
> +		return xdna->dev_info->ops->sriov_configure(xdna, num_vfs);
> +
> +	return -ENOENT;
> +}
> +
>   static struct pci_driver amdxdna_pci_driver = {
>   	.name = KBUILD_MODNAME,
>   	.id_table = pci_ids,
>   	.probe = amdxdna_probe,
>   	.remove = amdxdna_remove,
>   	.driver.pm = &amdxdna_pm_ops,
> +	.sriov_configure = amdxdna_sriov_configure,
>   };
>   
>   module_pci_driver(amdxdna_pci_driver);
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
> index 5e0bf565a1ae..eabbf57f2b38 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
> @@ -55,6 +55,7 @@ struct amdxdna_dev_ops {
>   	void (*fini)(struct amdxdna_dev *xdna);
>   	int (*resume)(struct amdxdna_dev *xdna);
>   	int (*suspend)(struct amdxdna_dev *xdna);
> +	int (*sriov_configure)(struct amdxdna_dev *xdna, int num_vfs);
>   	int (*hwctx_init)(struct amdxdna_hwctx *hwctx);
>   	void (*hwctx_fini)(struct amdxdna_hwctx *hwctx);
>   	int (*hwctx_config)(struct amdxdna_hwctx *hwctx, u32 type, u64 value, void *buf, u32 size);
> @@ -157,6 +158,7 @@ struct amdxdna_client {
>   
>   /* Add device info below */
>   extern const struct amdxdna_dev_info dev_npu1_info;
> +extern const struct amdxdna_dev_info dev_npu3_pf_info;
>   extern const struct amdxdna_dev_info dev_npu4_info;
>   extern const struct amdxdna_dev_info dev_npu5_info;
>   extern const struct amdxdna_dev_info dev_npu6_info;
> diff --git a/drivers/accel/amdxdna/npu3_regs.c b/drivers/accel/amdxdna/npu3_regs.c
> new file mode 100644
> index 000000000000..f6e20f4858db
> --- /dev/null
> +++ b/drivers/accel/amdxdna/npu3_regs.c
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026, Advanced Micro Devices, Inc.
> + */
> +
> +#include <drm/amdxdna_accel.h>
> +#include <drm/drm_device.h>
> +
> +#include "aie4_pci.h"
> +#include "amdxdna_pci_drv.h"
> +
> +#define NPU3_MBOX_BAR		0
> +
> +#define NPU3_MBOX_BUFFER_BAR	2
> +#define NPU3_MBOX_INFO_OFF	0x0
> +
> +/* PCIe BAR Index for NPU3 */
> +#define NPU3_REG_BAR_INDEX	0
> +
> +static const struct amdxdna_fw_feature_tbl npu3_fw_feature_table[] = {
> +	{ .major = 5, .min_minor = 10 },
> +	{ 0 }
> +};
> +
> +static const struct amdxdna_dev_priv npu3_dev_priv = {
> +	.mbox_bar		= NPU3_MBOX_BAR,
> +	.mbox_rbuf_bar		= NPU3_MBOX_BUFFER_BAR,
> +	.mbox_info_off		= NPU3_MBOX_INFO_OFF,
> +};
> +
> +const struct amdxdna_dev_info dev_npu3_pf_info = {
> +	.mbox_bar		= NPU3_MBOX_BAR,
> +	.sram_bar		= NPU3_MBOX_BUFFER_BAR,
> +	.vbnv			= "RyzenAI-npu3-pf",
> +	.device_type		= AMDXDNA_DEV_TYPE_PF,
> +	.dev_priv		= &npu3_dev_priv,
> +	.fw_feature_tbl		= npu3_fw_feature_table,
> +	.ops			= &aie4_ops,
> +};
> diff --git a/include/uapi/drm/amdxdna_accel.h b/include/uapi/drm/amdxdna_accel.h
> index 61d3686fa3b1..0b11e8e3ea5d 100644
> --- a/include/uapi/drm/amdxdna_accel.h
> +++ b/include/uapi/drm/amdxdna_accel.h
> @@ -29,7 +29,8 @@ extern "C" {
>   
>   enum amdxdna_device_type {
>   	AMDXDNA_DEV_TYPE_UNKNOWN = -1,
> -	AMDXDNA_DEV_TYPE_KMQ,
> +	AMDXDNA_DEV_TYPE_KMQ = 0,
> +	AMDXDNA_DEV_TYPE_PF = 2,
>   };
>   
>   enum amdxdna_drm_ioctl_id {

