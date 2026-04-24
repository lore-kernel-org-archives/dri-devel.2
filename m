Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CDEFFED3F2
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 18:30:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDF6B10E004;
	Fri, 24 Apr 2026 18:30:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="pQvTAFhY";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011039.outbound.protection.outlook.com [52.101.62.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C0D010E004
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 18:30:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOVmZ978wVuIfnrf5ojCP/oy8Uw+YegAGcGScPfcQqVrmxx6xgX2OzydbxEAbGpyc/H7Qu/ikZTKZkGouQioozJnMdtYu7OtKaqm/I0AiQ4A/Wur3gS6VEiqoRpMWL83yj7uPsH0g7FAvvEjh9veviREQd0dG9rgZjinqvDkPrOMe7B/kgZBlKHebpD2PH1N9S3BFtektDkjgcCYncIWfDajbCSjrt78VBUOvGBwiPDai2rCa7h84pYpnj7OPMPRc0qTZlHEXSJV09JoLAo2tYjn2zQBweBJlZsaUbzgUY1Tb6fpeK41BqKWRktvXi0DMqkwnbMLr74iiM8WF4uvog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B28cUMDLN8YrvhvAvPQ+2rKU89qh6QRfjUVRKyn4U2U=;
 b=lI0FJCgNVEvYEjps7thuADz1MpwLNG4zvhelXUe3U/IGfpR39knKwQq6qXmMsuQ7RQBvSMR9vcR/8EOaF11PEu2QD5ldjkHFdW4L9n9S39rgSDYH5byZAC1mtjlYdDdmMcdg8eW5oFVO4DJlxI/JY5BanShFTbx6yYIBOTfgBfzZNkLkx5Q0rPWfyR70gIydfEiRsCQZOEeYznmv4ilxSdlK5PdEJJxzuwhC9fB3fUPnKVZdJV2icKxpY1ZnJTO4LGCdXYsEH/prDdCvCDHjQBMRp4sDewNkF2KIU6R821fkaKfu/CQPDWX0tWDZ/WC0AXO0FPYtXDLLxJjuB6Yshw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B28cUMDLN8YrvhvAvPQ+2rKU89qh6QRfjUVRKyn4U2U=;
 b=pQvTAFhYN32CATg4HERUvi3xvxPdzQTEeZ9pDV9TvLzK3sf/kQsgRxtFYn6RFizDJH/rlEC1pV5eaSiBehFVACBIqw7FgXezmmPvvUYW2raGQEMRAo/0GlaliZbNOLKzjLFeI9A9rUmnHCNvAuE89jkH0jzgr70Ft8zlLZEI2/eyXB5JsCvcbU1L2Ir/HRdHbBG1gkqbNMRIARAPL3Zr+hOuQ4sJua0lBVnn7e5lGvGrqR/tKSWKZyG8XyJUpCoJov0v31XRUAbMZDlcR6RAbCtVGraIiTyR6SXKeL2agvcaVoWxowMxGvK7Y6hEkAxBZkIqANpxZEqumDJMosv6NQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BL3PR12MB6476.namprd12.prod.outlook.com (2603:10b6:208:3bc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Fri, 24 Apr
 2026 18:30:07 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9846.019; Fri, 24 Apr 2026
 18:30:07 +0000
Date: Fri, 24 Apr 2026 15:30:06 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Matt Evans <mattev@meta.com>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Alex Mastro <amastro@fb.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Kevin Tian <kevin.tian@intel.com>,
 Ankit Agrawal <ankita@nvidia.com>, Pranjal Shrivastava <praan@google.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH 7/9] vfio/pci: Support mmap() of a VFIO DMABUF
Message-ID: <20260424183006.GI3444440@nvidia.com>
References: <20260416131815.2729131-1-mattev@meta.com>
 <20260416131815.2729131-8-mattev@meta.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416131815.2729131-8-mattev@meta.com>
X-ClientProxiedBy: YT4PR01CA0084.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BL3PR12MB6476:EE_
X-MS-Office365-Filtering-Correlation-Id: a1bf26df-b98b-4312-f9c4-08dea22f8297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 9+IC1eHa2uPSQzJlzo7VDd5mdVuKUpEBVwNv9Ts7tEoORYB3YgUMJAxioj7S6i2ZbfDI+j85182NWfoyt/U4yyB8IiVdK0qczHAAUX/+cjza5jjnPMawC+7WmcGjs1zQodtHci0RXyH0M39T+tdK+edHUgj2acSNmTTLsTcQQ7LkNqCG6We5eSvW4Y6ILRGigOwyNH4ZzadMuHXOgH+P9r1kaj2vzJIg50YOfBeL6ovhW4SJa0p8ZcYlJRliwus59we2Sb/nWHV6TY8zgKkh6xAX8D2ehNXJ+6IBDLjZ64DshK3GY0VEp7LA+BpwG9iopSwiw+gwo2zyGqj72h91saN6696GTWASPvEtEe0fB58tsjKazzWKg0Butr+DFa2UekaziMEITLE7gvLrHX3RSIjn3AmUVXPNPi5b4+WBffJbttXLLBPsrZX18WqTJTn/jLz35Yayj05VwnlGQZlpdl3xMsYMGtr48PC+LEAfZhCTK49258cKDQx3qYXlChgQO3iDysXBn851b/UNkYbuIBRKqx8Mq0Jv19X0+hJxlbAf2tzDwkAzAoqJi9LSdcZB8fqKJoEGzXsBqZS06izKqmV3zg4YDuYZkEmdPs20NvGmu7hZ31cq6HrBryyD/mgwBUBOQdV/EfzeJ+4cKRGhLjBT0bTsiuaaWpL86jhiPqa+ReSMRoEvRT4JEF8f64PVmpFQ8TDP+vi5RyOXWSQJXa0f2lZeaSkZyYJ9DV4rVK8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR12MB9620.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3UM6ziRBrV963GEkflIQjj0s4/9LNCmkm794pF1lSfFMJQvF76QTzITd6Fdo?=
 =?us-ascii?Q?h1tdVC36Aq6sp+1ko9DUGnOXvEnsEr6XO8P7adDM39HxzmwJ/ZTTJ4JJYYuq?=
 =?us-ascii?Q?4DCIP+PFpBkmlPF6q2DMZ9J01AfCyRnqbGtJTUPPC6HkYZ3xGkVLXRpzxuz3?=
 =?us-ascii?Q?oVcqPSbTEFv8TMH+KoUGIME/uLR8hcFa+/CqPTcUDsL2s0NIQNP6iJ/32HmI?=
 =?us-ascii?Q?fCHnoD0+vVE7G/VyevukcaB6NOSVMiJxw5dVP0ov0ajietXt0TQgl2mjglfp?=
 =?us-ascii?Q?AOjgvc8c0sfPWR49sUAIbwrJtWzWLNGBdOKieBvOJlMv7qylEJoNaGBtz8GV?=
 =?us-ascii?Q?RjNrge5+xPeNP/wW0VkEpxmGs4Ci1d+RxoTOBRRKyqChbiCvuIWdTF5wzyLh?=
 =?us-ascii?Q?3kfsT13hLCa8eOa3RrRf3sdk0X15UrPHi1Af00Nvbz99uuZdLgCMulcRxyr4?=
 =?us-ascii?Q?OoKZ1cgYaz0z2UJ+TQolIDMBVSl3vW2ZLk7l+tPBQrDSQloKNrZum5YRx4dc?=
 =?us-ascii?Q?kNMhmUJAw0UUN+ukbKYbAvH4AVXEVYQ1cAmqpvhcSLXKizkW7khCBRAztMn9?=
 =?us-ascii?Q?YdfEC2tFxkdMUFAiaHwTVA4hJyCCDBr+YP4wx8GbL5YIN5+eHTYGB7uu1o9N?=
 =?us-ascii?Q?BVGLpJh313JUcPOwBHSO9RODmdyZCpfVZEmzWxu2T9/gubE7Ivpg+2PVfaAh?=
 =?us-ascii?Q?ObQr4qu2oAsrKtWhR5A3UQApTfEJu09AGse4urnXFe06kNR8MbvcOrcBmyi0?=
 =?us-ascii?Q?3t0VyZAcjV5kOYT9UqI8B/jFnSxIWIPN+VA/nM/8HXq7jN0RYPUZq4PTm1oB?=
 =?us-ascii?Q?wTw54Xbe5b9UB462Qf6f+gIcrSTCD0q040kCApkGyWlHBPuAhJzFrOZ8UqYM?=
 =?us-ascii?Q?FLejxCiEhxVb2LZ0qYFsEZrTDvywY9jtGGUmeqqgad/tWZpFcoI2JIGSC34u?=
 =?us-ascii?Q?OSbSW9T02x+xRCErjVGVOYsQfq24WzxIKjompWawDROgTy6WPiJtBHmGfT0G?=
 =?us-ascii?Q?k4nCa+FZxLe759mKjMqtbIE/Vv9m3ntND5a8FVYgENGxOmpi4ObhJs1p7YA0?=
 =?us-ascii?Q?dOgFIqJvHaXlP93OMg5T5WIWGdlsSm9igQCPamx2OU2Vtk449d5rMDhcYvCE?=
 =?us-ascii?Q?/pb8Nb7pk4xi0gJXU+8veA4rldM1ShN2xIMZULRdSi5UrJdt/cXPdlZKiWns?=
 =?us-ascii?Q?wdZYHN5+9wQzd6Dzo11VqmqbL4vnM4uaTseFn6CuqflD7tn0azZgInh6h4+0?=
 =?us-ascii?Q?JfEun8Ks15y0SapT2qbLwdcGKY/iqcezZlsw1jcGZThB80yffs9F0KFsa3zw?=
 =?us-ascii?Q?0alsTnh61C1vwuDTutHj+3LUfu8Rmf9xfmfcI+KNQb7on6Nlwz/sx9WMogbh?=
 =?us-ascii?Q?sEeFKDmmi3QWbW5FsO8BoN5MnmIdwzHlXwU2nj+QBf6mu16Ld1tsyAtodM4/?=
 =?us-ascii?Q?jpQ80Liriwzp4BdkqQ56iP0YnT3+skFW4SrNAn/aum4ttlc58Z7p5AafwXRv?=
 =?us-ascii?Q?O7OwcnS0sulHLwbxZSBZvhX2+Zk80vuFnKdkdfj8Kr94zGKyEC8J6p53Y4b8?=
 =?us-ascii?Q?HoZrCCGlGtfU5Vc8ZTo0u9NK/pHKaQL7A2D4QHi/5JpRY2jFigWMDvCI2BtA?=
 =?us-ascii?Q?rNaE2NLfHsiPbprC4mtiLais8kTRL4XOunl0aUCMdbi/Ugpx0W7jFyvnS+9T?=
 =?us-ascii?Q?b0Ab4OPOvK6o2vzjG9vtpPXWvj7Sdb7qJy7xrprdJNIY+Sqx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1bf26df-b98b-4312-f9c4-08dea22f8297
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 18:30:07.3450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vFPpJks+y0xGWjQrezqlmc2X/WtTCdK6eLsobOZ6O0TD+7dHrd7xk7fhYCMfgYV9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6476
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

On Thu, Apr 16, 2026 at 06:17:50AM -0700, Matt Evans wrote:
> +
> +	dma_resv_lock(priv->dmabuf->resv, NULL);
>  	vdev = READ_ONCE(priv->vdev);
>
> +	if (READ_ONCE(priv->revoked) || !vdev) {

Why is this read once? It is inside the resv lock so it is stable?

> +		pr_debug_ratelimited("%s VA 0x%lx, pgoff 0x%lx: DMABUF revoked/cleaned up\n",
> +				     __func__, vmf->address, vma->vm_pgoff);
> +		dma_resv_unlock(priv->dmabuf->resv);
> +		return VM_FAULT_SIGBUS;
> +	}
> +	/* vdev is usable */
> +
> +	if (!vfio_device_try_get_registration(&vdev->vdev)) {
> +		/*
> +		 * If vdev != NULL (above), the registration should
> +		 * already be >0 and so this try_get should never
> +		 * fail.
> +		 */
> +		dev_warn(&vdev->pdev->dev, "%s: Unexpected registration failure\n",
> +			 __func__);
> +		dma_resv_unlock(priv->dmabuf->resv);
> +		return VM_FAULT_SIGBUS;
> +	}
> +	dma_resv_unlock(priv->dmabuf->resv);
> +
>  	scoped_guard(rwsem_read, &vdev->memory_lock) {
> -		if (!priv->revoked) {
> +		if (!READ_ONCE(priv->revoked)) {

Same here, it is not read once since you hold the memory_lock it is
stable.

Jason
