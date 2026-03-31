Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F86E10F92E0
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 16:32:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9F8210EB98;
	Tue, 31 Mar 2026 16:32:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Jjr2v8qp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E04E810EB98
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 16:32:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1BB886133D;
 Tue, 31 Mar 2026 16:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B26C19423;
 Tue, 31 Mar 2026 16:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774974742;
 bh=rd5Rxr8L2m7TjMcH9J94go+Jm803pUF/noAV2QLYfJg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Jjr2v8qpOcRsTUeNWuIqKpLXDCwAEfLOmRYH5nnkyk2XZA0GnQpIGVvR/MJ39njCP
 +1iH/Jj4VqhkB9RdCWn7qqsjZmLSIWlD86mkrDplLCBAX5Fd5m//Eka++iPTxA2LiM
 q1eLHhYZlaMxTe4VBYubJ3HFtYHfyVxIB7lNtP5yPukC/s0XT2W2iY+zTYDivwJ9AM
 y9qxlOWd4NSQGvvbZwyZH4yqZKlD8BLGSxcJeUN4FHkXVmKMRW81pKofteRFLRnZHO
 F5GMSyVRE30KCxpnzc/N3iVAq6fyV2DR7CE242lje0lFaknE2J9ZfTOO7WqkcwyL0z
 c+s4KEbTrMu6Q==
Message-ID: <44436b18-99f1-4eb3-8402-dfd553494a57@kernel.org>
Date: Tue, 31 Mar 2026 11:32:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 6/6] accel/amdxdna: Add AIE4 power on and off support
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 maciej.falkowski@linux.intel.com
Cc: David Zhang <yidong.zhang@amd.com>, linux-kernel@vger.kernel.org,
 max.zhen@amd.com, sonal.santan@amd.com,
 Hayden Laccabue <Hayden.Laccabue@amd.com>
References: <20260330163705.3153647-1-lizhi.hou@amd.com>
 <20260330163705.3153647-7-lizhi.hou@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260330163705.3153647-7-lizhi.hou@amd.com>
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
> Implement AIE4 power on and off control using the common SMU interfaces.
> 
> Co-developed-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
> Signed-off-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
> Signed-off-by: David Zhang <yidong.zhang@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/accel/amdxdna/aie4_pci.c  | 28 +++++++++++++++++++++++++++-
>   drivers/accel/amdxdna/aie4_pci.h  |  1 +
>   drivers/accel/amdxdna/npu3_regs.c | 17 ++++++++++++++++-
>   3 files changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
> index e7993b315996..2249b2c9398d 100644
> --- a/drivers/accel/amdxdna/aie4_pci.c
> +++ b/drivers/accel/amdxdna/aie4_pci.c
> @@ -212,11 +212,26 @@ static int aie4_mailbox_init(struct amdxdna_dev *xdna)
>   static void aie4_fw_unload(struct amdxdna_dev_hdl *ndev)
>   {
>   	aie_psp_stop(ndev->aie.psp_hdl);
> +	aie_smu_fini(ndev->aie.smu_hdl);
>   }
>   
>   static int aie4_fw_load(struct amdxdna_dev_hdl *ndev)
>   {
> -	return aie_psp_start(ndev->aie.psp_hdl);
> +	int ret;
> +
> +	ret = aie_smu_init(ndev->aie.smu_hdl);
> +	if (ret) {
> +		XDNA_ERR(ndev->aie.xdna, "failed to init smu, ret %d", ret);
> +		return ret;
> +	}
> +
> +	ret = aie_psp_start(ndev->aie.psp_hdl);
> +	if (ret) {
> +		XDNA_ERR(ndev->aie.xdna, "failed to start psp, ret %d", ret);
> +		aie_smu_fini(ndev->aie.smu_hdl);
> +	}
> +
> +	return ret;
>   }
>   
>   static int aie4_hw_start(struct amdxdna_dev *xdna)
> @@ -331,6 +346,7 @@ static int aie4_prepare_firmware(struct amdxdna_dev_hdl *ndev,
>   {
>   	struct amdxdna_dev *xdna = ndev->aie.xdna;
>   	struct psp_config psp_conf;
> +	struct smu_config smu_conf;
>   	int i;
>   
>   	psp_conf.fw_size = npufw->size;
> @@ -347,6 +363,14 @@ static int aie4_prepare_firmware(struct amdxdna_dev_hdl *ndev,
>   		return -ENOMEM;
>   	}
>   
> +	for (i = 0; i < SMU_MAX_REGS; i++)
> +		smu_conf.smu_regs[i] = tbl[SMU_REG_BAR(ndev, i)] + SMU_REG_OFF(ndev, i);
> +	ndev->aie.smu_hdl = aiem_smu_create(&xdna->ddev, &smu_conf);
> +	if (!ndev->aie.smu_hdl) {
> +		XDNA_ERR(xdna, "failed to create smu");
> +		return -ENOMEM;
> +	}
> +
>   	return 0;
>   }
>   
> @@ -374,6 +398,8 @@ static int aie4_pcidev_init(struct amdxdna_dev_hdl *ndev)
>   
>   	for (i = 0; i < PSP_MAX_REGS; i++)
>   		set_bit(PSP_REG_BAR(ndev, i), &bars);
> +	for (i = 0; i < SMU_MAX_REGS; i++)
> +		set_bit(SMU_REG_BAR(ndev, i), &bars);
>   	set_bit(xdna->dev_info->mbox_bar, &bars);
>   	set_bit(xdna->dev_info->sram_bar, &bars);
>   
> diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
> index ee388ccf7196..aa1495c3370b 100644
> --- a/drivers/accel/amdxdna/aie4_pci.h
> +++ b/drivers/accel/amdxdna/aie4_pci.h
> @@ -21,6 +21,7 @@ struct amdxdna_dev_priv {
>   	u64			mbox_info_off;
>   
>   	struct aie_bar_off_pair	psp_regs_off[PSP_MAX_REGS];
> +	struct aie_bar_off_pair	smu_regs_off[SMU_MAX_REGS];
>   };
>   
>   struct amdxdna_dev_hdl {
> diff --git a/drivers/accel/amdxdna/npu3_regs.c b/drivers/accel/amdxdna/npu3_regs.c
> index fb2bd60b8f00..5a0bbc916094 100644
> --- a/drivers/accel/amdxdna/npu3_regs.c
> +++ b/drivers/accel/amdxdna/npu3_regs.c
> @@ -17,15 +17,23 @@
>   /* PCIe BAR Index for NPU3 */
>   #define NPU3_REG_BAR_INDEX	0
>   #define NPU3_PSP_BAR_INDEX      4
> +#define NPU3_SMU_BAR_INDEX      5
>   
>   #define MMNPU_APERTURE3_BASE    0x3810000
> +#define MMNPU_APERTURE4_BASE    0x3B10000
> +
>   #define NPU3_PSP_BAR_BASE       MMNPU_APERTURE3_BASE
> +#define NPU3_SMU_BAR_BASE       MMNPU_APERTURE4_BASE
>   
>   #define MPASP_C2PMSG_123_ALT_1  0x3810AEC
>   #define MPASP_C2PMSG_156_ALT_1  0x3810B70
>   #define MPASP_C2PMSG_157_ALT_1  0x3810B74
>   #define MPASP_C2PMSG_73_ALT_1   0x3810A24
>   
> +#define MP1_C2PMSG_59_ALT_1     0x3B109EC
> +#define MP1_C2PMSG_61_ALT_1     0x3B109F4
> +#define MP1_C2PMSG_60_ALT_1     0x3B109F0
> +
>   static const struct amdxdna_fw_feature_tbl npu3_fw_feature_table[] = {
>   	{ .major = 5, .min_minor = 10 },
>   	{ 0 }
> @@ -47,13 +55,20 @@ static const struct amdxdna_dev_priv npu3_dev_priv = {
>   		DEFINE_BAR_OFFSET(PSP_RESP_REG,   NPU3_PSP, MPASP_C2PMSG_156_ALT_1),
>   		/* npu3 doesn't use 8th pwaitmode register */
>   	},
> -
> +	.smu_regs_off   = {
> +		DEFINE_BAR_OFFSET(SMU_CMD_REG,  NPU3_SMU, MP1_C2PMSG_59_ALT_1),
> +		DEFINE_BAR_OFFSET(SMU_ARG_REG,  NPU3_SMU, MP1_C2PMSG_61_ALT_1),
> +		DEFINE_BAR_OFFSET(SMU_INTR_REG, NPU3_SMU, MMNPU_APERTURE4_BASE),
> +		DEFINE_BAR_OFFSET(SMU_RESP_REG, NPU3_SMU, MP1_C2PMSG_60_ALT_1),
> +		DEFINE_BAR_OFFSET(SMU_OUT_REG,  NPU3_SMU, MP1_C2PMSG_61_ALT_1),
> +	},
>   };
>   
>   const struct amdxdna_dev_info dev_npu3_pf_info = {
>   	.mbox_bar		= NPU3_MBOX_BAR,
>   	.sram_bar		= NPU3_MBOX_BUFFER_BAR,
>   	.psp_bar                = NPU3_PSP_BAR_INDEX,
> +	.smu_bar		= NPU3_SMU_BAR_INDEX,
>   	.vbnv			= "RyzenAI-npu3-pf",
>   	.device_type		= AMDXDNA_DEV_TYPE_PF,
>   	.dev_priv		= &npu3_dev_priv,

