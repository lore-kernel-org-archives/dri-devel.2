Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C348CA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 20:41:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5893310E694;
	Mon, 12 Oct 2026 20:41:54 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010028.outbound.protection.outlook.com [52.101.56.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C5FE10E694
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 20:41:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PwH5wjjmiw1C3wkP4KZbT5jf9IK07hYXdrIGzXGcLiRgNRUSg1SJE5fM/9POcKmyLgjnlZOHEbkndXKccKnSzZITvrbnXzebuG1eNh6FClLgkmaoWni5ssxOKixYjZ9IX7/EYims4xdgivYV+fTos7Gka3gD/W+zlZ3sKlIQEeB8fNjBJQLMjzzIC7H9FQ+nK1qA/T7xnuT6ngY+vtxFUjb+hNILHviRksvbN2FAmXT6H3DCDTcBwTb8fAetoksir0P4xv658t0phDK+CmtnmuiAq/VBvPOcGIyhB46haq7ikcGxcqocrq+7BXMHLIIzs7xWolFBr6qhq8jj+DJbrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7cMC5DLSCXywjex8gy/LA6TNCuRls1vb16zqmHnJgY=;
 b=R1GUj7duUL8Duw9K48H8ncfaFm2YbwiqnM5vQ2j9Ufg61Lf4VQHRuIb0vczRAoUIiNDb4izvKucAxBE7YgQloTJGQSvF45vSAO3bBeE8eeQiUy99fBo7ifatY+4aT6OknYokxsMNkkDMOq9Vingk7hsKPl6ebDiElPSY4Kw6seBHA+CZkQRsHNKgq0uRjfj/7uH3NSKTmAslOReoVuwFs8hQMuVgaVr3MpF4h/W5uKLz6nvoCXX7BlobLh1TL1xkaOD4nVJB6zwgAWqj7Mvij/C64W1Z/W6w7qTDSsIrGO60LxSqkb+aW6taF904FefUEt1mP/+LHsulFEHPz3TinA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7cMC5DLSCXywjex8gy/LA6TNCuRls1vb16zqmHnJgY=;
 b=4jXZNMm1E4RNLwuDsH+xGBC4GiuvSrdyf2Yy4+VJ5APoI6xXUP5+M90OR1Y5EpUiluTfFQ+nN9LfAns/mmWJfVrT0k6eaX+JGl/VGivZVZaEeSsEovguXbYTf1mgd76sOLZERb1p+vD7H5CfvOUhO0Iyu+W8ddHmjA8RkSLRyjw=
Received: from SJ0PR03CA0212.namprd03.prod.outlook.com (2603:10b6:a03:39f::7)
 by DS0PR12MB7969.namprd12.prod.outlook.com (2603:10b6:8:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Mon, 12 Oct
 2026 20:41:40 +0000
Received: from CO1PEPF00012E65.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::97) by SJ0PR03CA0212.outlook.office365.com
 (2603:10b6:a03:39f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 12
 Oct 2026 20:41:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E65.mail.protection.outlook.com (10.167.249.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 12 Oct 2026 20:41:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 12 Oct
 2026 15:41:33 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 12 Oct
 2026 15:41:33 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 12 Oct 2026 15:41:32 -0500
Message-ID: <29fad348-94d1-3f83-91d1-df3c19d27af0@amd.com>
Date: Mon, 12 Oct 2026 13:41:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V4 05/19] accel/amdxdna: Add NPU3 classic device support
Content-Language: en-US
To: David Zhang <yidong.zhang@amd.com>, <quic_jhugo@quicinc.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <sonal.santan@amd.com>, <mario.limonciello@amd.com>
References: <yidong.zhang@amd.com>
 <20261009225343.3079074-1-yidong.zhang@amd.com>
 <20261009225343.3079074-6-yidong.zhang@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20261009225343.3079074-6-yidong.zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E65:EE_|DS0PR12MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e7e1d80-3765-4f04-c35d-08df28a13779
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|10067099003|18002099003|22082099003|3023799007|4143699003|261009223027099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: fhTuIMJZzi1pVcdpFvYftGv/cQYTtu3QHtEec5i4Azdg3DIKqUBLP3L2pK8m8eAnpS53l/sds6yUBDnYAAlF3PFugzaK8aj/7u7Dy38wUatPF6rz2clejt9LaCc8/JUCeCEHiNTrM0KG+AtDas7iVO+dMZBha+S1Cwy9ZppDqGAc9yJbHiofK2MISo/ptV4eEiDDkq2bsHqZbho8ZM0WJrvsbRhgqkYIHXkBjB47GkPr7uGUUGl25C2N/8LADtwfH6Nb62c5r1apPpLdH74mX7L/EaKcLYjCr6aW4pgWoyTW+RkX3+XEPTS3ZQk0exDK7CgAAwEToPu3azod4fMtfFle+ggxrcXSvTlnu+mU2I2vNJThkk/gp5sU59SKJHlpsm5y3ix6fEicObXU1v41HSbFFEajz0LN7059iZXdSjgPcmJdAxL2BA/MOEX66xCUkyU8KfmE/msvNMr2Q2KH05Ap/lF6+sx0nw/kZ1H4elE6v2kXBeb01gC8ulWVmrr1ZjTzZzgc24dDdMsjSqGHIfaLFTzr8MpyiB8fHE+yyy0LFWu0oo/CzRnzPVpMitt28TVNz1SrhLuy8rL3118dh6A9suZ/G81I8/5yDRGPG0rg0wv1Um7vIy3sPSmmxd28MlmISpyQoFU+cL9R75YeXW0ozYwEuU8Gdep0XfJu5L6t8Jl3GUr9rmDx7sd/gFfRMvLDlvUAdqs5Sx1q2UKY5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(10067099003)(18002099003)(22082099003)(3023799007)(4143699003)(261009223027099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RZqkBiLdO1Q9p0R8foBCJrmjauS3TqBc+qUDpafXl5cXSUAp/sLTms7VT4xdIZUtnVZHmKTIBDrq9GRxWvQckR4rWGAQmCOmLQm6YKaoO22m9L8VxyV4C7oOpEdSVAMf0jhnzwObsZPvX2P+pkW5r0yLmX6VIbl9zweZdjp+g5pOSaYXYV9r277N+luJAJP81Ror7kGmlcjwPV0m4tF6J95fDcLm9p/OjFFrNzVg1m1ssyii9XWpWoBNto434ljz3zn9GRvMLHbdDf4Wf+Nx9XeLlBrmqgk3DxI2Y4aepS4W1I8cDf7QqoaZeDNXXsthpOoUPJuuGTlwiCXQAgInui+GKv2rRASmkPdNi3nw2b7rCibLW5QdxMmmtvjBmj9aInjizn80eXmcSCLtcv7u/PpsFl/oYjtHH/+CqpkLF2/9MzgrA8sk1cY6BkaEpGjC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 20:41:39.4116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7e1d80-3765-4f04-c35d-08df28a13779
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E65.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7969
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


On 10/9/26 15:53, David Zhang wrote:
> Add NPU3 classic device operations (aie4_classic_ops) and register
> definitions, as well as the PCI device ID and firmware declarations for
> NPU3 classic devices. Remove device IDs 0x1B0B and 0x1B0C because those
> devices will not be released.
>
> Suspend and resume support is added in a later patch, once the
> kernel-mode queue (KMQ) can drain in-flight commands.
>
> Signed-off-by: David Zhang <yidong.zhang@amd.com>
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>   drivers/accel/amdxdna/aie4_pci.c        | 83 +++++++++++++++++++++++++
>   drivers/accel/amdxdna/aie4_pci.h        |  1 +
>   drivers/accel/amdxdna/amdxdna_pci_drv.c | 23 ++++---
>   drivers/accel/amdxdna/amdxdna_pci_drv.h |  1 +
>   drivers/accel/amdxdna/npu3_regs.c       | 14 +++++
>   5 files changed, 115 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
> index e9cd2af224d3..1eeb1cb73b27 100644
> --- a/drivers/accel/amdxdna/aie4_pci.c
> +++ b/drivers/accel/amdxdna/aie4_pci.c
> @@ -366,6 +366,51 @@ static void aie4_vf_hw_stop(struct amdxdna_dev_hdl *ndev)
>   	aie4_mailbox_fini(ndev);
>   }
>   
> +static int aie4_classic_hw_start(struct amdxdna_dev_hdl *ndev)
> +{
> +	int ret;
> +
> +	ret = aie4_fw_start(ndev);
> +	if (ret)
> +		return ret;
> +
> +	ret = aie4_mailbox_init(ndev);
> +	if (ret)
> +		goto stop_fw;
> +
> +	ret = aie4_query(ndev);
> +	if (ret)
> +		goto mailbox_fini;
> +
> +	ret = aie4_attach_work_buffer(ndev);
> +	if (ret)
> +		goto mailbox_fini;
> +
> +	ret = aie4_partition_init(ndev);
> +	if (ret)
> +		goto mailbox_fini;
> +
> +	return 0;
> +
> +mailbox_fini:
> +	aie4_mailbox_fini(ndev);
> +stop_fw:
> +	aie4_fw_stop(ndev);
> +	return ret;
> +}
> +
> +static void aie4_classic_hw_stop(struct amdxdna_dev_hdl *ndev)
> +{
> +	struct amdxdna_dev *xdna = ndev->aie.xdna;
> +
> +	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
> +
> +	aie4_partition_fini(ndev);
> +	aie4_suspend_fw(ndev);
> +	aie4_mailbox_fini(ndev);
> +	aie4_fw_stop(ndev);
> +}
> +
>   static int aie4_request_firmware(struct amdxdna_dev_hdl *ndev,
>   				 const struct firmware **npufw,
>   				 const struct firmware **certfw)
> @@ -628,6 +673,29 @@ static int aie4_vf_init(struct amdxdna_dev *xdna)
>   	return aie4_vf_hw_start(xdna->dev_handle);
>   }
>   
> +static int aie4_classic_init(struct amdxdna_dev *xdna)
> +{
> +	int ret;
> +
> +	ret = aie4m_pcidev_init(xdna);
> +	if (ret)
> +		return ret;
> +
> +	ret = aie4_alloc_work_buffer(xdna->dev_handle);
> +	if (ret)
> +		return ret;
> +
> +	ret = aie4_classic_hw_start(xdna->dev_handle);
> +	if (ret)
> +		goto free_work_buf;
> +
> +	return 0;
> +
> +free_work_buf:
> +	aie4_free_work_buffer(xdna->dev_handle);
> +	return ret;
> +}
> +
>   static void aie4_pf_fini(struct amdxdna_dev *xdna)
>   {
>   	aie4_sriov_stop(xdna->dev_handle);
> @@ -640,6 +708,12 @@ static void aie4_vf_fini(struct amdxdna_dev *xdna)
>   	aie4_vf_hw_stop(xdna->dev_handle);
>   }
>   
> +static void aie4_classic_fini(struct amdxdna_dev *xdna)
> +{
> +	aie4_classic_hw_stop(xdna->dev_handle);
> +	aie4_free_work_buffer(xdna->dev_handle);
> +}
> +
>   const struct amdxdna_dev_ops aie4_pf_ops = {
>   	.init			= aie4_pf_init,
>   	.fini			= aie4_pf_fini,
> @@ -654,3 +728,12 @@ const struct amdxdna_dev_ops aie4_vf_ops = {
>   	.cmd_wait		= aie4_cmd_wait,
>   	.get_aie_info		= aie4_get_info,
>   };
> +
> +const struct amdxdna_dev_ops aie4_classic_ops = {
> +	.init			= aie4_classic_init,
> +	.fini			= aie4_classic_fini,
> +	.hwctx_init		= aie4_hwctx_init,
> +	.hwctx_fini		= aie4_hwctx_fini,
> +	.cmd_wait		= aie4_cmd_wait,
> +	.get_aie_info		= aie4_get_info,
> +};
> diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
> index bdbb2d7cf0e7..940e67347d74 100644
> --- a/drivers/accel/amdxdna/aie4_pci.h
> +++ b/drivers/accel/amdxdna/aie4_pci.h
> @@ -96,5 +96,6 @@ static inline int aie4_sriov_stop(struct amdxdna_dev_hdl *ndev)
>   
>   extern const struct amdxdna_dev_ops aie4_pf_ops;
>   extern const struct amdxdna_dev_ops aie4_vf_ops;
> +extern const struct amdxdna_dev_ops aie4_classic_ops;
>   
>   #endif /* _AIE4_PCI_H_ */
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> index 3140af69e29c..f5f7831c4e80 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> @@ -28,8 +28,14 @@ MODULE_FIRMWARE("amdnpu/17f0_20/npu.sbin");
>   MODULE_FIRMWARE("amdnpu/1502_00/npu_7.sbin");
>   MODULE_FIRMWARE("amdnpu/17f0_10/npu_7.sbin");
>   MODULE_FIRMWARE("amdnpu/17f0_11/npu_7.sbin");
> +MODULE_FIRMWARE("amdnpu/17f1_10/npu.sbin");
> +MODULE_FIRMWARE("amdnpu/17f1_10/cert.sbin");
>   MODULE_FIRMWARE("amdnpu/17f2_10/npu.sbin");
>   MODULE_FIRMWARE("amdnpu/17f2_10/cert.sbin");
> +MODULE_FIRMWARE("amdnpu/17f1_13/npu.sbin");
> +MODULE_FIRMWARE("amdnpu/17f1_13/cert.sbin");
> +MODULE_FIRMWARE("amdnpu/17f2_13/npu.sbin");
> +MODULE_FIRMWARE("amdnpu/17f2_13/cert.sbin");
>   
>   /*
>    * 0.0: Initial version
> @@ -55,10 +61,9 @@ MODULE_FIRMWARE("amdnpu/17f2_10/cert.sbin");
>   static const struct pci_device_id pci_ids[] = {
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x1502) },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x17f0) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x17f1) },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x17f2) },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x17f3) },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x1B0B) },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x1B0C) },
>   	{0}
>   };
>   
> @@ -69,10 +74,12 @@ static const struct amdxdna_device_id amdxdna_ids[] = {
>   	{ 0x17f0, 0x10, &dev_npu4_info },
>   	{ 0x17f0, 0x11, &dev_npu5_info },
>   	{ 0x17f0, 0x20, &dev_npu6_info },
> +	{ 0x17f1, 0x10, &dev_npu3_classic_info },
>   	{ 0x17f2, 0x10, &dev_npu3_pf_info },
>   	{ 0x17f3, 0x10, &dev_npu3_vf_info },
> -	{ 0x1B0B, 0x10, &dev_npu3_pf_info },
> -	{ 0x1B0C, 0x10, &dev_npu3_vf_info },
> +	{ 0x17f1, 0x13, &dev_npu3_classic_info },
> +	{ 0x17f2, 0x13, &dev_npu3_pf_info },
> +	{ 0x17f3, 0x13, &dev_npu3_vf_info },
>   	{0}
>   };
>   
> @@ -140,8 +147,9 @@ static int amdxdna_drm_open(struct drm_device *ddev, struct drm_file *filp)
>   	mmgrab(client->mm);
>   	xa_init_flags(&client->hwctx_xa, XA_FLAGS_ALLOC);
>   	xa_init_flags(&client->dev_heap_xa, XA_FLAGS_ALLOC);
> -	drm_mm_init(&client->dev_heap_mm, xdna->dev_info->dev_mem_base,
> -		    xdna->dev_info->dev_heap_max_size);
> +	if (xdna->dev_info->dev_heap_max_size)
> +		drm_mm_init(&client->dev_heap_mm, xdna->dev_info->dev_mem_base,
> +			    xdna->dev_info->dev_heap_max_size);
>   	mutex_init(&client->mm_lock);
>   
>   	mutex_lock(&xdna->client_lock);
> @@ -176,7 +184,8 @@ static void amdxdna_client_cleanup(struct amdxdna_client *client)
>   	xa_for_each(&client->dev_heap_xa, heap_id, heap)
>   		drm_gem_object_put(to_gobj(heap));
>   	xa_destroy(&client->dev_heap_xa);
> -	drm_mm_takedown(&client->dev_heap_mm);
> +	if (client->xdna->dev_info->dev_heap_max_size)
> +		drm_mm_takedown(&client->dev_heap_mm);
>   
>   	mutex_destroy(&client->mm_lock);
>   	mmdrop(client->mm);
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
> index 0002e6ef32ba..953bf783b3f7 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
> @@ -169,6 +169,7 @@ struct amdxdna_client {
>   
>   /* Add device info below */
>   extern const struct amdxdna_dev_info dev_npu1_info;
> +extern const struct amdxdna_dev_info dev_npu3_classic_info;
>   extern const struct amdxdna_dev_info dev_npu3_pf_info;
>   extern const struct amdxdna_dev_info dev_npu3_vf_info;
>   extern const struct amdxdna_dev_info dev_npu4_info;
> diff --git a/drivers/accel/amdxdna/npu3_regs.c b/drivers/accel/amdxdna/npu3_regs.c
> index 93f749acb5d5..c82433d62901 100644
> --- a/drivers/accel/amdxdna/npu3_regs.c
> +++ b/drivers/accel/amdxdna/npu3_regs.c
> @@ -105,3 +105,17 @@ const struct amdxdna_dev_info dev_npu3_vf_info = {
>   	.cert_feature_tbl	= npu3_cert_feature_table,
>   	.ops			= &aie4_vf_ops,
>   };
> +
> +const struct amdxdna_dev_info dev_npu3_classic_info = {
> +	.mbox_bar		= NPU3_MBOX_BAR,
> +	.sram_bar		= NPU3_MBOX_BUFFER_BAR,
> +	.psp_bar                = NPU3_PSP_BAR_INDEX,
> +	.smu_bar		= NPU3_SMU_BAR_INDEX,
> +	.doorbell_bar		= NPU3_DOORBELL_BAR,
> +	.default_vbnv		= "RyzenAI-npu3",
> +	.device_type		= AMDXDNA_DEV_TYPE_UMQ,
> +	.dev_priv		= &npu3_dev_priv,
> +	.fw_feature_tbl		= npu3_fw_feature_table,
> +	.cert_feature_tbl	= npu3_cert_feature_table,
> +	.ops			= &aie4_classic_ops,
> +};
