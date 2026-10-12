Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD6BCA9ED2
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 20:37:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C92810E032;
	Mon, 12 Oct 2026 20:37:27 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010034.outbound.protection.outlook.com [52.101.56.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AD5910E032
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 20:37:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WWuS/b/swVKWJTgupcToHNXqOyYWZ3MTipvTtYUD7XmuoGCZQPvvAMSLxMv+aSYwkJgPIywQ7Y0k8AO7Yiuj2zwihCrkVaWqBGmxsRxZzYwMu0ANzFBHexFffVSH5OWk4ACknRutDPXjOQXJHVv78L8SYuC6hkIzzLKr15X2/8Us3JocO8o2/cF/qPP1wv1zlQVVPUtYPwRrK0TE23nZLHEGXZWOl2QGOjYUA4dgGxEdSa5OfPP394+hRbULz1occvF8Irq+jABofQOVGGnJ83/nbfCwc+7iGkprcrNXDpzgKjG4iP2VDNP+XDCPiYhUy7rRHpeaj2p5sulkDF9A2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Muu9gayDNDmpCZKTgTAlp8XP9HW86xb3/R873L87/TI=;
 b=PVctlLTzivL5QLf61ZrTyBGcdRiOwN3ylMdlhoaWLf5hwJ5sHam4qmJ74Eedt1t16T5SkxHe5QUGm1Iuxif9kcIYg6/e5kNCX5FSidGP+sMxhl0FDvXBNG6/7A8Oe1VcX8pI8Q6//sg0on00I7iEVnzRNJDY3n9a+9TWvjjLg43YaQEfvZUXaH2NexIwjMMsArC6qj/GdEXEaAqfptVjAQgGAOYEFi//x0HveONZ3alw8cDUHRTGBI+QGm/Srm5xZ1jaqqFJLF0WyuH+ValKayjpLhNZIt2JO6AItWK45DzTt5T61D/sr3PteAzYX9/f47v6eTSBVvlZiOcwTuPnTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Muu9gayDNDmpCZKTgTAlp8XP9HW86xb3/R873L87/TI=;
 b=Z7/Suw5RNM6ZcgECV8aE7W5YUlYoPBiidgB93J9CfdTz67HgA/PA+mkbII6n2KX4Wswbv0q5Foq8+slKP3lrPnJefMDdh642/DC34A9E2jziG06rvE+qvm+CyQObxlzoGxTU5SIWu9lrpPo0d5nt3/iTnwK1lHa9AqWok1lQVMc=
Received: from BN9P223CA0017.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::22)
 by DS7PR12MB8230.namprd12.prod.outlook.com (2603:10b6:8:ed::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.23; Mon, 12 Oct 2026 20:37:13 +0000
Received: from BN2PEPF0000A88E.namprd04.prod.outlook.com
 (2603:10b6:408:10b:cafe::86) by BN9P223CA0017.outlook.office365.com
 (2603:10b6:408:10b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 12
 Oct 2026 20:37:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A88E.mail.protection.outlook.com (10.167.248.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 12 Oct 2026 20:37:13 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 12 Oct
 2026 15:37:07 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 12 Oct 2026 15:37:06 -0500
Message-ID: <2224aae6-dcc4-22e3-21ca-3a4a1b5c57ee@amd.com>
Date: Mon, 12 Oct 2026 13:37:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V4 02/19] accel/amdxdna: Remove mmap for doorbell
Content-Language: en-US
To: David Zhang <yidong.zhang@amd.com>, <quic_jhugo@quicinc.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <sonal.santan@amd.com>, <mario.limonciello@amd.com>
References: <yidong.zhang@amd.com>
 <20261009225343.3079074-1-yidong.zhang@amd.com>
 <20261009225343.3079074-3-yidong.zhang@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20261009225343.3079074-3-yidong.zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A88E:EE_|DS7PR12MB8230:EE_
X-MS-Office365-Filtering-Correlation-Id: bed1125b-38af-4ad9-8b6d-08df28a098ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|6133799003|18002099003|22082099003|10067099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: AHlTBPq6FozOHmiln+On2a/bhcq7IDloIj+FtkJylL20JFkxFHmkloTCs+A79+Dj254llWioqOWn8zpsrItj2osq3PeR7+R/MBwftMib7yn9gxn2ztnMqiEGT+o2hqLHu9dUNps1FK2Q7a1PDlMkX3VWKrwBHSjed/Uq/bHq8/rzwMRUCzYL6NvhHfemeNuFD1xGQdSsUOucZFIuR/N3P93hzCuBClGa4bx4zPZ9zNfi6sa1JQzyD025E7fFqgQgtZREZL7gVTWirsFOgVFNP8l1i5jgH9UcLV5l3pUbf7UFgTCuiuy1vwO+/W2a5zQJdlU7XZ7BoNc5p0hK6DPMVuYwQ4EnzISBuLSxzbnDJHoEyL8ycS41+i1mjA6tdIRNTJgK7ocImuIzHzbr+wUC87hSXxb4JECMvrQHXwBLMOIxykxbGAHOoKKqLFRoo+dPV7H7zidwOmzP74iIHWcpwj9ANydmM8sqJRCcECN2JzvE8N6xSD1QNk1Gp0dT/Qj1/EC610RqH7nfPlAsrvIuyhiGXA22ukGjWv8IlW29Elx7siWfes93Z4QWiamP8eJP+zqGoxuaQSm/17iKXP/GgZ2H5MnFR1UfibM2dxhbYRSHGLt2hBb6/ZbKU0JFDYZPxfrwSImF+iHj7s6Te3hfwSBaiKKA6qsadwWJva0CjUaozNkJlFcHInLr+FT39mNqnt9ux8VAxH7mVldXr4CbqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(6133799003)(18002099003)(22082099003)(10067099003)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AN+t4pW5VksgBGZAmBe9hMspa1VTeZKysr5W3sWEiiSwMojDUN9yHJsU3NAbYroZEjsZNNbedD8Cek6CSEEQlo8KPX4hWy3EWYFbSmKyHhlueeaKuaC1EnC82fFHYRMnnozx1U6wmaQFrnTb41IbVyteR5RaRCTtxi2HC4mnOkbGfhKUNcoBgA/G6gnVvSW4NPIhHK6JKRY51vDpUDPp6riIOoAoUsXyLNljLxXlpeZvbQF5QYmog194/kDMj0ghGW2yvZV9u0XGUL20D2Wv7ObZ5UzKJrGMRVdok05iFa9aOTijQiM5+iwAM/VN9n6CPUu30tKFqmHqKrnj8YunmctAuHUH7junaczxicxHOt3/MR70u+x92Z/Q/EjyhuQVZ0fw2Eq0WtpNmvsCoHR0W+eBCxU1eIccg0czV3vSWzRTsxX/iwQxFhPrrR5vfrmz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 20:37:13.1722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bed1125b-38af-4ad9-8b6d-08df28a098ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A88E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8230
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
> Make kernel submission the default, so mapping the doorbell back to user
> space is not needed:
> - Remove .mmap handler and use standard drm_gem_mmap.
> - Set hwctx->doorbell_offset to AMDXDNA_INVALID_DOORBELL_OFFSET on
>    context creation so userspace does not receive a valid-looking BAR
>    offset.
>
> Signed-off-by: David Zhang <yidong.zhang@amd.com>
> ---
>   drivers/accel/amdxdna/aie4_ctx.c        | 20 +--------------
>   drivers/accel/amdxdna/aie4_pci.c        | 33 -------------------------
>   drivers/accel/amdxdna/aie4_pci.h        |  1 -
>   drivers/accel/amdxdna/amdxdna_pci_drv.c | 17 +------------
>   drivers/accel/amdxdna/amdxdna_pci_drv.h |  1 -
>   5 files changed, 2 insertions(+), 70 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie4_ctx.c
> index 8408b0d2696f..8157f2a6fd10 100644
> --- a/drivers/accel/amdxdna/aie4_ctx.c
> +++ b/drivers/accel/amdxdna/aie4_ctx.c
> @@ -158,7 +158,7 @@ static int aie4_hwctx_create(struct amdxdna_hwctx *hwctx)
>   	}
>   
>   	priv->hw_ctx_id = resp.hw_context_id;
> -	hwctx->doorbell_offset = resp.doorbell_offset;
> +	hwctx->doorbell_offset = AMDXDNA_INVALID_DOORBELL_OFFSET;
>   
>   	return 0;
>   }
> @@ -313,21 +313,3 @@ int aie4_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout)
>   
>   	return ret <= 0 ? ret : 0;
>   }
> -
> -int aie4_hwctx_valid_doorbell(struct amdxdna_client *client, u32 vm_pgoff)
> -{
> -	struct amdxdna_hwctx *hwctx;
> -	unsigned long hwctx_id;
> -	int idx;
> -
> -	idx = srcu_read_lock(&client->hwctx_srcu);
> -	amdxdna_for_each_hwctx(client, hwctx_id, hwctx) {
> -		if (vm_pgoff == (hwctx->doorbell_offset >> PAGE_SHIFT)) {
> -			srcu_read_unlock(&client->hwctx_srcu, idx);
> -			return 1;
> -		}
> -	}
> -	srcu_read_unlock(&client->hwctx_srcu, idx);
> -
> -	return 0;
> -}
> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
> index e99ad35870ef..f81c43a1f884 100644
> --- a/drivers/accel/amdxdna/aie4_pci.c
> +++ b/drivers/accel/amdxdna/aie4_pci.c
> @@ -524,38 +524,6 @@ static int aie4m_pcidev_init(struct amdxdna_dev *xdna)
>   	return 0;
>   }
>   
> -static int aie4_doorbell_mmap(struct amdxdna_client *client, struct vm_area_struct *vma)
> -{
> -	struct amdxdna_dev *xdna = client->xdna;
> -	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
> -	const struct amdxdna_dev_priv *npriv = xdna->dev_info->dev_priv;
> -	phys_addr_t res_start;
> -	unsigned long pfn;
> -	int ret;
> -
> -	if (!aie4_hwctx_valid_doorbell(client, vma->vm_pgoff)) {
> -		XDNA_ERR(xdna, "Invalid doorbell page offset 0x%lx", vma->vm_pgoff);
> -		return -EINVAL;
> -	}
> -
> -	if (vma_pages(vma) != 1) {
> -		XDNA_ERR(xdna, "can only map one page, got %ld", vma_pages(vma));
> -		return -EINVAL;
> -	}
> -
> -	res_start = pci_resource_start(pdev, xdna->dev_info->doorbell_bar) + npriv->doorbell_off;
> -	pfn = PHYS_PFN(res_start) + vma->vm_pgoff;
> -	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> -	vm_flags_set(vma, VM_IO | VM_DONTEXPAND | VM_DONTDUMP);
> -	ret = io_remap_pfn_range(vma, vma->vm_start,
> -				 pfn,
> -				 PAGE_SIZE,
> -				 vma->vm_page_prot);
> -
> -	XDNA_DBG(xdna, "doorbell ret %d", ret);
> -	return ret;
> -}
> -
>   static int aie4_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_info *args)
>   {
>   	struct amdxdna_dev *xdna = client->xdna;
> @@ -667,7 +635,6 @@ const struct amdxdna_dev_ops aie4_vf_ops = {
>   	.fini			= aie4_vf_fini,
>   	.hwctx_init		= aie4_hwctx_init,
>   	.hwctx_fini		= aie4_hwctx_fini,
> -	.mmap			= aie4_doorbell_mmap,
>   	.cmd_wait		= aie4_cmd_wait,
>   	.get_aie_info		= aie4_get_info,
>   };
> diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
> index 3fd5eace3ed7..c6219544dc0f 100644
> --- a/drivers/accel/amdxdna/aie4_pci.h
> +++ b/drivers/accel/amdxdna/aie4_pci.h
> @@ -69,7 +69,6 @@ int aie4_attach_work_buffer(struct amdxdna_dev_hdl *ndev);
>   int aie4_hwctx_init(struct amdxdna_hwctx *hwctx);
>   void aie4_hwctx_fini(struct amdxdna_hwctx *hwctx);
>   int aie4_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout);
> -int aie4_hwctx_valid_doorbell(struct amdxdna_client *client, u32 vm_pgoff);
>   
>   /* aie4_sriov.c */
>   #if IS_ENABLED(CONFIG_PCI_IOV)
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> index d9e2e71d3e05..3140af69e29c 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> @@ -250,21 +250,6 @@ static int amdxdna_drm_set_state_ioctl(struct drm_device *dev, void *data, struc
>   	return ret;
>   }
>   
> -static int amdxdna_drm_gem_mmap(struct file *filp, struct vm_area_struct *vma)
> -{
> -	struct drm_file *drm_filp = filp->private_data;
> -	struct amdxdna_client *client = drm_filp->driver_priv;
> -	struct amdxdna_dev *xdna = client->xdna;
> -
> -	if (likely(vma->vm_pgoff >= DRM_FILE_PAGE_OFFSET_START))
> -		return drm_gem_mmap(filp, vma);
> -
> -	if (!xdna->dev_info->ops->mmap)
> -		return -EOPNOTSUPP;
> -
> -	return xdna->dev_info->ops->mmap(client, vma);
> -}
> -
>   static const struct drm_ioctl_desc amdxdna_drm_ioctls[] = {
>   	/* Context */
>   	DRM_IOCTL_DEF_DRV(AMDXDNA_CREATE_HWCTX, amdxdna_drm_create_hwctx_ioctl, 0),
> @@ -323,7 +308,7 @@ static const struct file_operations amdxdna_fops = {
>   	.poll		= drm_poll,
>   	.read		= drm_read,
>   	.llseek		= noop_llseek,
> -	.mmap		= amdxdna_drm_gem_mmap,
> +	.mmap		= drm_gem_mmap,
>   	.show_fdinfo	= drm_show_fdinfo,
>   	.fop_flags	= FOP_UNSIGNED_OFFSET,
>   };
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
> index a997d27a504d..84c8973e9197 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
> @@ -57,7 +57,6 @@ struct amdxdna_dev_ops {
>   	int (*resume)(struct amdxdna_dev *xdna);
>   	int (*suspend)(struct amdxdna_dev *xdna);
>   	int (*sriov_configure)(struct amdxdna_dev *xdna, int num_vfs);
> -	int (*mmap)(struct amdxdna_client *client, struct vm_area_struct *vma);
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>   	int (*hwctx_init)(struct amdxdna_hwctx *hwctx);
>   	void (*hwctx_fini)(struct amdxdna_hwctx *hwctx);
>   	int (*hwctx_config)(struct amdxdna_hwctx *hwctx, u32 type, u64 value, void *buf, u32 size);
