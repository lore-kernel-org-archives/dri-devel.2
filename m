Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05293606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 22:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NMxtoRm/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E11E10F0D3;
	Tue, 24 Nov 2026 22:29:28 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010029.outbound.protection.outlook.com [52.101.56.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94F9A10F0D3
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 22:29:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q83ZvahGeiNedWC/Vlw4n13XpqTYX2BfsQU2fuSgX6yTXQ0RBiuBpovSq8r6qeWbWC81V9yS/9LPmjKD9FDQFqp870MfysRsxIXhyKdHyezP0q6//n4GlgdUVyRFKpZ4kZezdefb9F1jCvWKT/thtEaaPz8gh9rITyM2ydDrANcgTMpLdfhayFSjLaZSlEZS1blLosfSkHJj9nYafwDXg7DZQnbNSh3+mRfg9ZfqlSOrV18g/69JGc9EAdBXVj5j4p4riQzxeQRjPG3Nj/U6o1RHzo5/+0RDM6v1Sj3ALmosOVeBtVzj2KR81Wqxif8sCDhMMut+fYUru2GgUx3l1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+5nb7vthXd1Pw+e4F/mXoYokz+7XMy/Kws0XxLx7no=;
 b=MipEr27BqFEp9pG78G9skNEooAXAHVuEbN6p8IUOtdoDfXakPw1pWTEPFgaf4DQw+a5dUEzaU+9FFvVwWl4SdO1sJGGwMbGjt1Zl+ND3ICWh3enS2AsX2luhb5kg5Syr3nKMsKqYQmkY+sB/UhxqXyqdoottkYvZKNdk+RRjqOleP6NEeTPDex3q2R4UR6w43wT+0jjrc53O+M0D7UhNfA9YQpxUtq6nsa0ARvZiIEb2hZHr3tmGLVY3Z2fR4INxIH6hAECYOr8pTiulQ7MGjkoscosBFMKik4EKFHGroyPv2mWb6muO8yevoEmk4S7RvzpZOnYwvjUZo99z8RvL7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+5nb7vthXd1Pw+e4F/mXoYokz+7XMy/Kws0XxLx7no=;
 b=NMxtoRm/3GINZe8AH6kbjqu55KuSwxxncD4YIlpVUASSiY9uFJtvTjEzhXRbqEgCufHHIjTdAX0fAjmqQ0u8U40hRw3OrFLkJFv5R4O33zwAqng/VuM8TA/gEaOB/cFk8JL7rN3hoHIVCAe7aLIMw0e30Xymgf/BHuaY+4v0OkJ4hPTxQ5cVIpI17Cqv7ZmChPigEFCTYW4729dqJZHlyabF4AvLY1qDZgfShRvh0A+PM+brF+z26r/nyFP999otuFdXncnVP0cCOCpW1ZSZAUDLhShb1y8/TRMuk5jyU3hvXRpr8zGfAD1JV7WX2RaIp54+Spipgi+sfa7fh0F2rw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14) by SJ2PR12MB9085.namprd12.prod.outlook.com
 (2603:10b6:a03:564::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 22:29:16 +0000
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777]) by SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 22:29:16 +0000
Date: Wed, 25 Nov 2026 09:29:11 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Karol Wachowski <karol.wachowski@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, 
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>, dawid.osuchowski@linux.intel.com,
 christian.koenig@amd.com, sumit.semwal@linaro.org
Subject: Re: [PATCH v2] accel/ivpu: Allocate a scatterlist per userptr
 dma-buf mapping
Message-ID: <awYORn499MM8Cf78@nvdebian.thelocal>
References: <20261123102644.627963-1-karol.wachowski@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123102644.627963-1-karol.wachowski@linux.intel.com>
X-ClientProxiedBy: SY8PR01CA0002.ausprd01.prod.outlook.com
 (2603:10c6:10:29c::30) To SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB598757:EE_|SJ2PR12MB9085:EE_
X-MS-Office365-Filtering-Correlation-Id: 511ceb3c-0b4b-44ea-1894-08df4a7a5f9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|261009223027099003|261026140227099003|11063799006|10067099003|56012099006|261026121527099003|261021121427099003|261022105027099003|261102123227099003|261102130727099003|261021123027099003|261022075727099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: DQzBGS5EhAvlwR1BQaACtAXnz4f4y4J4XOx8gYl6hAqGSeyXyHadeNGFj09uhYNHtordNtK9nK8sxq3IbStNN/R81ZjsxABgjj5NIRkALWcSN4kqS0GleTkH91bNYQmc+8BqqBQO4nf2zedgHCCqGxuF/pXGAu0cEi4WGH4LPMkTGVwIMZEFr6gW7REhvOxkG7FIFFqA34LSAwuuP2raMSjz/sLOaEA2x5Z2iLNSlFbwne4g8uwwZ0F5lJ//I8fFHDRR9QHjT6yYnGirTvwf0QbkwkLRkaLTWnxWbA/xKflLWxuzgZ2WLjmAMVYVpSZ1F31fvSgTUJad7mggTisCWfrjugKrqyvu+P1k6ITcuMN6OtJAeI/jDDKAmgk7EdjVVA9AFqpTfszsWG3Ev+XwJgJAl0k50z3311bJ2KKJ5e4IAH/YdzawMmnrY3x+70+iALWomAMaf2W2dKe9m5rF4X9FPk2LAtoyJIA2+fzFaQ3kEsqq5mcXULlHCdqF6D9aHcAM7OZDqSOTbU015nnbHoGpBpeFqaow5o8BTMYLXHzho6vQVL2+8j2kONl5fbhCzI8RUE0CKk9HsxnWQOJzmZtnjgFSkkVeUV5w+lLmHCuB3WpND+1Q/neNePRAoYdivUTUsRRMRufcoOPDjW0zWT974DDzH15y/yv92bWmM6A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR12MB598757.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(261026140227099003)(11063799006)(10067099003)(56012099006)(261026121527099003)(261021121427099003)(261022105027099003)(261102123227099003)(261102130727099003)(261021123027099003)(261022075727099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?05IsGNVLdA9/3yN9Gq3vd5y+lPEUoc4xXsOVmFWjcIXhD5T+toTX6QCRR9ok?=
 =?us-ascii?Q?P7FSIlRoyqO3xE4lC8GrIJ/rCAdKnD7h5BI6JM6jTK+dTbZjvn5YPjQQHAfj?=
 =?us-ascii?Q?cp1LdxL9vKk1D27z9DYOxH9t91aOGUwYKSjFPFUF9IW5QH/8UMLFL/FW84dZ?=
 =?us-ascii?Q?EvQz9qppc3e36LHJndeCF56yoRNdz/egqTO4BJHuEkT7N+4zcmXH5jsEPU/1?=
 =?us-ascii?Q?FUcT5yxO4IRlcsYQhKWTaxGfPeq+fZq0OPIvHPwRt+Y39o8QuUQxrTQGGiIY?=
 =?us-ascii?Q?woUid+XjqoFSQzQYCd6NMJZdTVc42QFR1dYYyxAQf26OBaz+henXDQCJ4FKa?=
 =?us-ascii?Q?1ClQ49LHdTalvXZrlxexg1VT+yqj5RNmVP0WCdzMZ5k/H66qj/ctgHHfqwwQ?=
 =?us-ascii?Q?UkBekN0GwY6m+nmq6vMpLeXm+xI2W1UzjYOujdu0gbVwpFmiD//0Ym+lWQsu?=
 =?us-ascii?Q?X+JHwdvqIoASK3lzIy6hJayIDrgLC5ouE8wIw82g7YxIHL8cTZH5sPvxl5zs?=
 =?us-ascii?Q?RgNfb7yEmpK80lVS3baLS/7zeg8r/7jK5jhofvZV5++tQ19gHYcxMku0twGG?=
 =?us-ascii?Q?tskSay/S1HJq3RVx/khZ66NeDglWS+xvn0s2rRSqZjYDKtxSYUalYZUEUdZd?=
 =?us-ascii?Q?c+PUw90TFpiyQvj2JxR+QZqakuRom4Rhk94vlHkdszyxifJ2TYarlDfp/vP/?=
 =?us-ascii?Q?oefZymTH95/tbByp61ErK8HWMz4Cd6ev5+g/cQoWi86ol2N15IclPRo9jTfy?=
 =?us-ascii?Q?sJXRjbzL1x9AxwqNAs4zVTA7vHBlxcZ5WLuBx7RE1bJgk9qORk9Fi8fRAYXo?=
 =?us-ascii?Q?9BMgZ4fxDmKD6Mb5hUgYPRLLeNGWOgZNsI7RknaxtItIVvcgZDP4f5A7K0F3?=
 =?us-ascii?Q?n31fRtYnUsqWxk8DQcRVyA3ykKulJ4wTq9tO053xTliwXkYZPH1rFUWMJkds?=
 =?us-ascii?Q?GvzCz84C72hyX7nzsPSbF+QpF68lmhwJq4GmTRUeLep4+80LiIHQg2I0+Eph?=
 =?us-ascii?Q?rcvkSuIbkcPav1LlNsYkyQhbtHENzfJEc37Z8pjVioGp0SHgl1biDjSjkK8B?=
 =?us-ascii?Q?zq9mblLao8q/YLfKmh/bSB7xLNeAkyDKnbqpdyZ0wLqu6YdVfMGlnSD/45pz?=
 =?us-ascii?Q?gWMppRVlz/kEQTvvGbYzOECy3Gr1dA/fOkshsIWwA0Dq4VChg3iTFM2kROJ+?=
 =?us-ascii?Q?VQs9jTjVh+lEIgQmKJmX0TJfAA/eVQstqjLipTjRzF4UsfmbMK5Ec4gdddbd?=
 =?us-ascii?Q?c0hCun02Hfg9aGObLhSvib0t7Qz/UokEHksQ2o8iswGp4vYY8E5DQlyQomtQ?=
 =?us-ascii?Q?VJPBvC4JXyBvVDKdNAErinPPJAp14c49JhV1XrkiCPdOi1BA4Pp3ZyuUfqxX?=
 =?us-ascii?Q?Pxpjf7JQqF+sLYUCkYEwkoshyJIZcWQknjkh+OCQHsOHUQWKsryIvvV1OZaV?=
 =?us-ascii?Q?/qL8WxksyaVOQ/Ngk3Pl1KNJzKCnFZfTnh3QR6gKp9qPlSd+Nm9n9uOkUDqP?=
 =?us-ascii?Q?X1UkXICd0qx+9XnBswAOHfm7pUoaLWko6m0v2atphD4aIs9LHBzLbzkuwkPP?=
 =?us-ascii?Q?BvCGu6S8dU8tdG12ixOLILw46O/IPC3X+yPvk/K4pr9DlRxQI/+xuVuGWjVF?=
 =?us-ascii?Q?rEujoJWUC5qEpMIMh8NVOWRZuz+cADjPFPAekWHB2BZvwttkx3Fdhsj3EHhD?=
 =?us-ascii?Q?yUhsyUmAZtbPiTGUOafC3knbVDzptjUCLQd7wj0CLJ3E4X7QgU01jQLv5BmN?=
 =?us-ascii?Q?dV66qWr8xQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 511ceb3c-0b4b-44ea-1894-08df4a7a5f9f
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB598757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 22:29:16.2960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e0UqrWG1WI5LbIU9aWGCoA8cDH2Y0J7DeLRjaOZyrFkWghxr3Lu48NwqNv8d23px4nFtyInVPTnfTYT3kou77w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9085
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-23 at 21:26 +1100, Karol Wachowski <karol.wachowski@linux.intel.com> wrote...
> The userptr dma-buf DMA maps the same sg_table on every map_dma_buf(),
> so a second mapping would overwrite the DMA addresses of the first one.
> It only works today because ivpu is the only importer.
> 
> Build a new sg_table from the pinned pages on each map instead.
> 
> Fixes: 57557964b582 ("accel/ivpu: Add support for userptr buffer objects")
> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
> ---
> 
> Notes:
>     v2:
>     - Use the correct upstream sha in the Fixes: tag (Sashiko).
>     - v1: https://lore.kernel.org/r/20261123085935.623564-1-karol.wachowski@linux.intel.com
> 
>     Alistair, your DMA-buf mapping types series [1] noted this as a
>     pre-existing issue in "[PATCH v3 15/24] accel/ivpu: Convert the userptr
>     exporter to the SGT mapping type" [2]. With this patch applied first,
>     ivpu becomes an exporter that allocates a table per map, so its
>     conversion reduces to the same pattern as "[PATCH v3 07/24] dma-buf:
>     Convert exporters allocating a table per map to the SGT mapping type"
>     (e.g. amdxdna_ubuf), without the shared header copy.

Yes, thanks for fixing this. I was avoiding going down too many different rabbit
holes at once, but this looks reasonable.

Reviewed-by: Alistair Popple <apopple@nvidia.com>

>     [1] https://lore.kernel.org/r/20261120-dma_mapping_type_v4-v3-0-c0183a409bdf@nvidia.com
>     [2] https://lore.kernel.org/r/20261120-dma_mapping_type_v4-v3-15-c0183a409bdf@nvidia.com
> 
>  drivers/accel/ivpu/ivpu_gem_userptr.c | 65 ++++++++++++++++-----------
>  1 file changed, 38 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_gem_userptr.c b/drivers/accel/ivpu/ivpu_gem_userptr.c
> index 7cbf3a4cdc73..cfb2894b572d 100644
> --- a/drivers/accel/ivpu/ivpu_gem_userptr.c
> +++ b/drivers/accel/ivpu/ivpu_gem_userptr.c
> @@ -19,18 +19,39 @@
>  #include "ivpu_drv.h"
>  #include "ivpu_gem.h"
>  
> +struct ivpu_userptr {
> +	struct page **pages;
> +	unsigned long nr_pages;
> +};
> +
>  static struct sg_table *
>  ivpu_gem_userptr_dmabuf_map(struct dma_buf_attachment *attachment,
>  			    enum dma_data_direction direction)
>  {
> -	struct sg_table *sgt = attachment->dmabuf->priv;
> +	struct ivpu_userptr *userptr = attachment->dmabuf->priv;
> +	struct sg_table *sgt;
>  	int ret;
>  
> +	sgt = kmalloc_obj(*sgt);
> +	if (!sgt)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = sg_alloc_table_from_pages(sgt, userptr->pages, userptr->nr_pages, 0,
> +					attachment->dmabuf->size, GFP_KERNEL);
> +	if (ret)
> +		goto free_sgt;
> +
>  	ret = dma_map_sgtable(attachment->dev, sgt, direction, DMA_ATTR_SKIP_CPU_SYNC);
>  	if (ret)
> -		return ERR_PTR(ret);
> +		goto free_table;
>  
>  	return sgt;
> +
> +free_table:
> +	sg_free_table(sgt);
> +free_sgt:
> +	kfree(sgt);
> +	return ERR_PTR(ret);
>  }
>  
>  static void ivpu_gem_userptr_dmabuf_unmap(struct dma_buf_attachment *attachment,
> @@ -38,21 +59,17 @@ static void ivpu_gem_userptr_dmabuf_unmap(struct dma_buf_attachment *attachment,
>  					  enum dma_data_direction direction)
>  {
>  	dma_unmap_sgtable(attachment->dev, sgt, direction, DMA_ATTR_SKIP_CPU_SYNC);
> +	sg_free_table(sgt);
> +	kfree(sgt);
>  }
>  
>  static void ivpu_gem_userptr_dmabuf_release(struct dma_buf *dma_buf)
>  {
> -	struct sg_table *sgt = dma_buf->priv;
> -	struct sg_page_iter page_iter;
> -	struct page *page;
> -
> -	for_each_sgtable_page(sgt, &page_iter, 0) {
> -		page = sg_page_iter_page(&page_iter);
> -		unpin_user_page(page);
> -	}
> +	struct ivpu_userptr *userptr = dma_buf->priv;
>  
> -	sg_free_table(sgt);
> -	kfree(sgt);
> +	unpin_user_pages(userptr->pages, userptr->nr_pages);
> +	kvfree(userptr->pages);
> +	kfree(userptr);
>  }
>  
>  static const struct dma_buf_ops ivpu_gem_userptr_dmabuf_ops = {
> @@ -67,7 +84,7 @@ ivpu_create_userptr_dmabuf(struct ivpu_device *vdev, void __user *user_ptr,
>  {
>  	struct dma_buf_export_info exp_info = {};
>  	struct dma_buf *dma_buf;
> -	struct sg_table *sgt;
> +	struct ivpu_userptr *userptr;
>  	struct page **pages;
>  	unsigned long nr_pages = size >> PAGE_SHIFT;
>  	unsigned int gup_flags = FOLL_LONGTERM;
> @@ -94,39 +111,33 @@ ivpu_create_userptr_dmabuf(struct ivpu_device *vdev, void __user *user_ptr,
>  		goto unpin_pages;
>  	}
>  
> -	sgt = kmalloc_obj(*sgt);
> -	if (!sgt) {
> +	userptr = kmalloc_obj(*userptr);
> +	if (!userptr) {
>  		ret = -ENOMEM;
>  		goto unpin_pages;
>  	}
>  
> -	ret = sg_alloc_table_from_pages(sgt, pages, nr_pages, 0, size, GFP_KERNEL);
> -	if (ret) {
> -		ivpu_dbg(vdev, IOCTL, "Failed to create sg table: %d\n", ret);
> -		goto free_sgt;
> -	}
> +	userptr->pages = pages;
> +	userptr->nr_pages = nr_pages;
>  
>  	exp_info.exp_name = "ivpu_userptr_dmabuf";
>  	exp_info.owner = THIS_MODULE;
>  	exp_info.ops = &ivpu_gem_userptr_dmabuf_ops;
>  	exp_info.size = size;
>  	exp_info.flags = O_RDWR | O_CLOEXEC;
> -	exp_info.priv = sgt;
> +	exp_info.priv = userptr;
>  
>  	dma_buf = dma_buf_export(&exp_info);
>  	if (IS_ERR(dma_buf)) {
>  		ret = PTR_ERR(dma_buf);
>  		ivpu_dbg(vdev, IOCTL, "Failed to export userptr dma-buf: %d\n", ret);
> -		goto free_sg_table;
> +		goto free_userptr;
>  	}
>  
> -	kvfree(pages);
>  	return dma_buf;
>  
> -free_sg_table:
> -	sg_free_table(sgt);
> -free_sgt:
> -	kfree(sgt);
> +free_userptr:
> +	kfree(userptr);
>  unpin_pages:
>  	for (i = 0; i < pinned; i++)
>  		unpin_user_page(pages[i]);
> 
> base-commit: 5ffdc8f8361387a1b11553e5c95cd589c67a51f2
> -- 
> 2.43.0
> 
