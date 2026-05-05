Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F4BCD3427
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 19:37:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 620DD10E480;
	Tue,  5 May 2026 19:37:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="sGCAQuhZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC58B10E480
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 19:37:36 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 96AEF43C6F;
 Tue,  5 May 2026 19:37:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A835C2BCB4;
 Tue,  5 May 2026 19:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778009856;
 bh=PH1rXgEohbvy6JgmI/Q13c9IE00yDEMRd0ElTt7wURM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=sGCAQuhZyBS5MFNDwgTGU764mfiy5qvRjpB/kRpIMEzgssQ+8kqVKlHrJROkl07Cs
 zsvuBGo7ZhFSnIofAQ9EnACI1Dg2vmELOq075spLvGu5lzXWxkXn4kvwPjhH4Vvc89
 sQXJrtJXUgBYXV8pxi9txk9qmvGZp6qaPC1hZBlmxndHz+vJVbaxOrzUc0rPtqid6j
 fcFG7NgMVWIgXxuYCihRBeFaf/yy+x88CNKMFkv5R1Kce8Rar/ZGKEdVpRdXAqRcwv
 eHUiwiOUsCYEJbSrTDujvioK+yIYbcXWyvlQ6K47Ih7gWRRgCuMa7mqAolWf3tXAyD
 dWU6oSyIOdwAQ==
Message-ID: <95a961f2-5793-42af-8d7a-0a76457e2222@kernel.org>
Date: Tue, 5 May 2026 14:37:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 1/6] accel/amdxdna: Add initial support for AIE4 VF
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 karol.wachowski@linux.intel.com
Cc: David Zhang <yidong.zhang@amd.com>, linux-kernel@vger.kernel.org,
 max.zhen@amd.com, sonal.santan@amd.com,
 Hayden Laccabue <Hayden.Laccabue@amd.com>
References: <20260505160936.3917732-1-lizhi.hou@amd.com>
 <20260505160936.3917732-2-lizhi.hou@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260505160936.3917732-2-lizhi.hou@amd.com>
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
> Add basic device initialization support for AIE4 Virtual Functions (PCI
> device IDs 0x17F3 and 0x1B0C).
> 
> Co-developed-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
> Signed-off-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
> Signed-off-by: David Zhang <yidong.zhang@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/accel/amdxdna/aie4_pci.c        | 160 +++++++++++++-----------
>   drivers/accel/amdxdna/aie4_pci.h        |   3 +-
>   drivers/accel/amdxdna/amdxdna_pci_drv.c |   4 +
>   drivers/accel/amdxdna/amdxdna_pci_drv.h |   1 +
>   drivers/accel/amdxdna/npu3_regs.c       |  20 ++-
>   include/uapi/drm/amdxdna_accel.h        |   1 +
>   6 files changed, 113 insertions(+), 76 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
> index 87f80f804f91..a967e2db7ebd 100644
> --- a/drivers/accel/amdxdna/aie4_pci.c
> +++ b/drivers/accel/amdxdna/aie4_pci.c
> @@ -196,8 +196,9 @@ static int aie4_mailbox_start(struct amdxdna_dev *xdna,
>   	return ret;
>   }
>   
> -static int aie4_mailbox_init(struct amdxdna_dev *xdna)
> +static int aie4_mailbox_init(struct amdxdna_dev_hdl *ndev)
>   {
> +	struct amdxdna_dev *xdna = ndev->aie.xdna;
>   	struct mailbox_info mbox_info;
>   	int ret;
>   
> @@ -208,13 +209,13 @@ static int aie4_mailbox_init(struct amdxdna_dev *xdna)
>   	return aie4_mailbox_start(xdna, &mbox_info);
>   }
>   
> -static void aie4_fw_unload(struct amdxdna_dev_hdl *ndev)
> +static void aie4_fw_stop(struct amdxdna_dev_hdl *ndev)
>   {
>   	aie_psp_stop(ndev->aie.psp_hdl);
>   	aie_smu_fini(ndev->aie.smu_hdl);
>   }
>   
> -static int aie4_fw_load(struct amdxdna_dev_hdl *ndev)
> +static int aie4_fw_start(struct amdxdna_dev_hdl *ndev)
>   {
>   	int ret;
>   
> @@ -233,49 +234,49 @@ static int aie4_fw_load(struct amdxdna_dev_hdl *ndev)
>   	return ret;
>   }
>   
> -static int aie4_hw_start(struct amdxdna_dev *xdna)
> +static int aie4_pf_hw_start(struct amdxdna_dev_hdl *ndev)
>   {
> -	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
>   	int ret;
>   
> -	ret = aie4_fw_load(ndev);
> +	ret = aie4_fw_start(ndev);
>   	if (ret)
>   		return ret;
>   
> -	ret = aie4_mailbox_init(xdna);
> +	ret = aie4_mailbox_init(ndev);
>   	if (ret)
> -		goto fw_unload;
> +		goto stop_fw;
>   
>   	return 0;
>   
> -fw_unload:
> -	aie4_fw_unload(ndev);
> +stop_fw:
> +	aie4_fw_stop(ndev);
>   
>   	return ret;
>   }
>   
> -static void aie4_mgmt_fw_fini(struct amdxdna_dev_hdl *ndev)
> +static void aie4_pf_hw_stop(struct amdxdna_dev_hdl *ndev)
>   {
> -	int ret;
> +	struct amdxdna_dev *xdna = ndev->aie.xdna;
>   
> -	/* No paired resume needed, fw is stateless */
> -	ret = aie4_suspend_fw(ndev);
> -	if (ret)
> -		XDNA_ERR(ndev->aie.xdna, "suspend_fw failed, ret %d", ret);
> -	else
> -		XDNA_DBG(ndev->aie.xdna, "npu firmware suspended");
> +	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
> +
> +	aie4_suspend_fw(ndev);
> +	aie4_mailbox_fini(ndev);
> +	aie4_fw_stop(ndev);
>   }
>   
> -static void aie4_hw_stop(struct amdxdna_dev *xdna)
> +static int aie4_vf_hw_start(struct amdxdna_dev_hdl *ndev)
>   {
> -	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
> +	return aie4_mailbox_init(ndev);
> +}
> +
> +static void aie4_vf_hw_stop(struct amdxdna_dev_hdl *ndev)
> +{
> +	struct amdxdna_dev *xdna = ndev->aie.xdna;
>   
>   	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
>   
> -	aie4_mgmt_fw_fini(ndev);
>   	aie4_mailbox_fini(ndev);
> -
> -	aie4_fw_unload(ndev);
>   }
>   
>   static int aie4_request_firmware(struct amdxdna_dev_hdl *ndev,
> @@ -365,15 +366,41 @@ static int aie4_prepare_firmware(struct amdxdna_dev_hdl *ndev,
>   	return 0;
>   }
>   
> -static int aie4_pcidev_init(struct amdxdna_dev_hdl *ndev)
> +static int aie4_load_fw(struct amdxdna_dev_hdl *ndev,
> +			void __iomem *tbl[PCI_NUM_RESOURCES])
> +{
> +	const struct firmware *npufw, *certfw;
> +	int ret;
> +
> +	if (!ndev->priv->npufw_path && !ndev->priv->certfw_path)
> +		return 0;
> +
> +	ret = aie4_request_firmware(ndev, &npufw, &certfw);
> +	if (ret)
> +		return ret;
> +
> +	ret = aie4_prepare_firmware(ndev, npufw, certfw, tbl);
> +	aie4_release_firmware(ndev, npufw, certfw);
> +
> +	return ret;
> +}
> +
> +static int aie4m_pcidev_init(struct amdxdna_dev *xdna)
>   {
> -	struct amdxdna_dev *xdna = ndev->aie.xdna;
>   	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
> +	struct amdxdna_dev_hdl *ndev;
>   	void __iomem *tbl[PCI_NUM_RESOURCES] = {0};
> -	const struct firmware *npufw, *certfw;
>   	unsigned long bars = 0;
>   	int ret, i;
>   
> +	ndev = drmm_kzalloc(&xdna->ddev, sizeof(*ndev), GFP_KERNEL);
> +	if (!ndev)
> +		return -ENOMEM;
> +
> +	ndev->priv = xdna->dev_info->dev_priv;
> +	ndev->aie.xdna = xdna;
> +	xdna->dev_handle = ndev;
> +
>   	/* Enable managed PCI device */
>   	ret = pcim_enable_device(pdev);
>   	if (ret) {
> @@ -409,75 +436,60 @@ static int aie4_pcidev_init(struct amdxdna_dev_hdl *ndev)
>   
>   	pci_set_master(pdev);
>   
> -	ret = aie4_request_firmware(ndev, &npufw, &certfw);
> -	if (ret)
> -		goto clear_master;
> -
> -	ret = aie4_prepare_firmware(ndev, npufw, certfw, tbl);
> -	aie4_release_firmware(ndev, npufw, certfw);
> +	ret = aie4_load_fw(ndev, tbl);
>   	if (ret)
> -		goto clear_master;
> +		return ret;
>   
>   	ret = aie4_irq_init(xdna);
>   	if (ret)
> -		goto clear_master;
> +		return ret;
>   
> -	ret = aie4_hw_start(xdna);
> -	if (ret)
> -		goto clear_master;
> +	amdxdna_vbnv_init(xdna);
> +	XDNA_DBG(xdna, "init finished");
>   
>   	return 0;
> -
> -clear_master:
> -	pci_clear_master(pdev);
> -
> -	return ret;
>   }
>   
> -static void aie4_pcidev_fini(struct amdxdna_dev_hdl *ndev)
> +static int aie4_pf_init(struct amdxdna_dev *xdna)
>   {
> -	struct amdxdna_dev *xdna = ndev->aie.xdna;
> -	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
> -
> -	aie4_hw_stop(xdna);
> -
> -	pci_clear_master(pdev);
> -}
> +	int ret;
>   
> -static void aie4_fini(struct amdxdna_dev *xdna)
> -{
> -	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
> +	ret = aie4m_pcidev_init(xdna);
> +	if (ret)
> +		return ret;
>   
> -	aie4_sriov_stop(ndev);
> -	aie4_pcidev_fini(ndev);
> +	return aie4_pf_hw_start(xdna->dev_handle);
>   }
>   
> -static int aie4_init(struct amdxdna_dev *xdna)
> +static int aie4_vf_init(struct amdxdna_dev *xdna)
>   {
> -	struct amdxdna_dev_hdl *ndev;
>   	int ret;
>   
> -	ndev = drmm_kzalloc(&xdna->ddev, sizeof(*ndev), GFP_KERNEL);
> -	if (!ndev)
> -		return -ENOMEM;
> +	ret = aie4m_pcidev_init(xdna);
> +	if (ret)
> +		return ret;
>   
> -	ndev->priv = xdna->dev_info->dev_priv;
> -	ndev->aie.xdna = xdna;
> -	xdna->dev_handle = ndev;
> +	return aie4_vf_hw_start(xdna->dev_handle);
> +}
>   
> -	ret = aie4_pcidev_init(ndev);
> -	if (ret) {
> -		XDNA_ERR(xdna, "Setup PCI device failed, ret %d", ret);
> -		return ret;
> -	}
> +static void aie4_pf_fini(struct amdxdna_dev *xdna)
> +{
> +	aie4_sriov_stop(xdna->dev_handle);
> +	aie4_pf_hw_stop(xdna->dev_handle);
> +}
>   
> -	amdxdna_vbnv_init(xdna);
> -	XDNA_DBG(xdna, "aie4 init finished");
> -	return 0;
> +static void aie4_vf_fini(struct amdxdna_dev *xdna)
> +{
> +	aie4_vf_hw_stop(xdna->dev_handle);
>   }
>   
> -const struct amdxdna_dev_ops aie4_ops = {
> -	.init			= aie4_init,
> -	.fini			= aie4_fini,
> +const struct amdxdna_dev_ops aie4_pf_ops = {
> +	.init			= aie4_pf_init,
> +	.fini			= aie4_pf_fini,
>   	.sriov_configure        = aie4_sriov_configure,
>   };
> +
> +const struct amdxdna_dev_ops aie4_vf_ops = {
> +	.init			= aie4_vf_init,
> +	.fini			= aie4_vf_fini,
> +};
> diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
> index aa1495c3370b..cbf3424a4341 100644
> --- a/drivers/accel/amdxdna/aie4_pci.h
> +++ b/drivers/accel/amdxdna/aie4_pci.h
> @@ -48,6 +48,7 @@ static inline int aie4_sriov_stop(struct amdxdna_dev_hdl *ndev)
>   }
>   #endif
>   
> -extern const struct amdxdna_dev_ops aie4_ops;
> +extern const struct amdxdna_dev_ops aie4_pf_ops;
> +extern const struct amdxdna_dev_ops aie4_vf_ops;
>   
>   #endif /* _AIE4_PCI_H_ */
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> index 1b08a08343cf..39ad081ac082 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> @@ -53,7 +53,9 @@ static const struct pci_device_id pci_ids[] = {
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x1502) },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x17f0) },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x17f2) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x17f3) },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x1B0B) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x1B0C) },
>   	{0}
>   };
>   
> @@ -65,7 +67,9 @@ static const struct amdxdna_device_id amdxdna_ids[] = {
>   	{ 0x17f0, 0x11, &dev_npu5_info },
>   	{ 0x17f0, 0x20, &dev_npu6_info },
>   	{ 0x17f2, 0x10, &dev_npu3_pf_info },
> +	{ 0x17f3, 0x10, &dev_npu3_vf_info },
>   	{ 0x1B0B, 0x10, &dev_npu3_pf_info },
> +	{ 0x1B0C, 0x10, &dev_npu3_vf_info },
>   	{0}
>   };
>   
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
> index b1548cf16f59..caed11c09e55 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
> @@ -167,6 +167,7 @@ struct amdxdna_client {
>   /* Add device info below */
>   extern const struct amdxdna_dev_info dev_npu1_info;
>   extern const struct amdxdna_dev_info dev_npu3_pf_info;
> +extern const struct amdxdna_dev_info dev_npu3_vf_info;
>   extern const struct amdxdna_dev_info dev_npu4_info;
>   extern const struct amdxdna_dev_info dev_npu5_info;
>   extern const struct amdxdna_dev_info dev_npu6_info;
> diff --git a/drivers/accel/amdxdna/npu3_regs.c b/drivers/accel/amdxdna/npu3_regs.c
> index acece0faddf2..6d5da779232b 100644
> --- a/drivers/accel/amdxdna/npu3_regs.c
> +++ b/drivers/accel/amdxdna/npu3_regs.c
> @@ -64,6 +64,14 @@ static const struct amdxdna_dev_priv npu3_dev_priv = {
>   	},
>   };
>   
> +static const struct amdxdna_dev_priv npu3_dev_vf_priv = {
> +	/* vf device does not load firmware */
> +	.mbox_bar		= NPU3_MBOX_BAR,
> +	.mbox_rbuf_bar		= NPU3_MBOX_BUFFER_BAR,
> +	.mbox_info_off		= NPU3_MBOX_INFO_OFF,
> +	/* vf device does not have smu and psp */
> +};
> +
>   const struct amdxdna_dev_info dev_npu3_pf_info = {
>   	.mbox_bar		= NPU3_MBOX_BAR,
>   	.sram_bar		= NPU3_MBOX_BUFFER_BAR,
> @@ -73,5 +81,15 @@ const struct amdxdna_dev_info dev_npu3_pf_info = {
>   	.device_type		= AMDXDNA_DEV_TYPE_PF,
>   	.dev_priv		= &npu3_dev_priv,
>   	.fw_feature_tbl		= npu3_fw_feature_table,
> -	.ops			= &aie4_ops,
> +	.ops			= &aie4_pf_ops,
> +};
> +
> +const struct amdxdna_dev_info dev_npu3_vf_info = {
> +	.mbox_bar		= NPU3_MBOX_BAR,
> +	.sram_bar		= NPU3_MBOX_BUFFER_BAR,
> +	.default_vbnv		= "RyzenAI-npu3-vf",
> +	.device_type		= AMDXDNA_DEV_TYPE_UMQ,
> +	.dev_priv		= &npu3_dev_vf_priv,
> +	.fw_feature_tbl		= npu3_fw_feature_table,
> +	.ops			= &aie4_vf_ops,
>   };
> diff --git a/include/uapi/drm/amdxdna_accel.h b/include/uapi/drm/amdxdna_accel.h
> index 0b11e8e3ea5d..34212feee15c 100644
> --- a/include/uapi/drm/amdxdna_accel.h
> +++ b/include/uapi/drm/amdxdna_accel.h
> @@ -30,6 +30,7 @@ extern "C" {
>   enum amdxdna_device_type {
>   	AMDXDNA_DEV_TYPE_UNKNOWN = -1,
>   	AMDXDNA_DEV_TYPE_KMQ = 0,
> +	AMDXDNA_DEV_TYPE_UMQ = 1,
>   	AMDXDNA_DEV_TYPE_PF = 2,
>   };
>   

