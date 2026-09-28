Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8D2C9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:09:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BEE410E91C;
	Mon, 28 Sep 2026 10:09:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XJ/85OPU";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011068.outbound.protection.outlook.com [40.107.208.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E05AD10E91C;
 Mon, 28 Sep 2026 10:09:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jczITGPfXOQJpjAkxY0AaVZ0t0MZLArAkGo0IQEIn4n1JCvVtinCYiA/LWoXtRTUuEaSsih3wyHi/uBoP3MSL+v58D+VxZ7gEu7o/xJPZY08orTL1WA+kQdLiHB6iVo1837g0yh4+d3uGF7fx1UZ/YUNXlFMJrbm6XP0u4TnAtOB/Chy0lIBWzgCBLEdTi/jbv41ts0pvGZwyXJ51gKpJ6e/vs2t6QY4mBigMN1SZAyRpDb3oiHUGqzy4rXmP5tbXuONFfEHoJZJWjwoCSFTeai/05InyPT70QnXqQNc8zEGpULQD9T8f5XIeraCJ+nOAfskPF+K1Z8A4aN6Je3YKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+2cWYw+cNw1U/ZnbTJm8xIjB2ZFYrYKVd+UhMHA6aw=;
 b=quO3mfoiIMwQlyggE3O7X1R1GUfo0l1pkcl3sfqoTlL5TYETKYoXhjLPeI8W+exs02ZB9GyI3DIxCHmiPM/iC72qXkHNbCUvRqfz6M84yOIerwQ7Mr3PnIzfLxZWRjdnwLYvNPJyxOZvj+wSCyzr0MHIygD7luyGAcELR4sq7VcwybeS0OI9I/g57xIRwr2+31uqBlEFshbFcIhCBkphuqZUkYicnOqDHwDbTqyr6Nmr5qozPb0yhENM4E4Pu/iKOG58aRR0X/EJ0lgSQVpcRGvmXyCvto16w+k/UYpOBW/IUqAL76zi4aSa4Wrt/CoHCHQOeRQpJsTJcRMorRayYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+2cWYw+cNw1U/ZnbTJm8xIjB2ZFYrYKVd+UhMHA6aw=;
 b=XJ/85OPUmt412XIvg5OoXzPR/baEmMnctGKbBGETM9LRNlKCRqffRmKR7MW7l2EOzEViB97Yh6JxNGqQ4PpvT0BMYwm9hkH6W+3sHOuasC9mm19l1g7Sk4wwKc2CIsIv0CtCsoPNCp2HNIhS5xLBDw7moVnA5NlmagMaMfKjz3I=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB7144.namprd12.prod.outlook.com (2603:10b6:303:21b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 10:09:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 10:09:11 +0000
Message-ID: <bd4e5ece-1358-4e0b-bb04-ba9de62d26f6@amd.com>
Date: Mon, 28 Sep 2026 12:09:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] drm/msm: map page-less imported sg_tables from
 their DMA addresses
To: Jianfeng Liu <liujianfeng1994@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 freedreno@lists.freedesktop.org, iommu@lists.linux.dev,
 Dmitry Baryshkov <lumag@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 linux-media@vger.kernel.org, Bryan O'Donoghue <bod.linux@nxsw.ie>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, David Airlie <airlied@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>, Sean Paul <sean@poorly.run>,
 Simona Vetter <simona@ffwll.ch>
References: <20260928053901.7270-1-liujianfeng1994@gmail.com>
 <20260928053901.7270-3-liujianfeng1994@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260928053901.7270-3-liujianfeng1994@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0441.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB7144:EE_
X-MS-Office365-Filtering-Correlation-Id: eaa09384-4982-46e2-68bd-08df1d488a72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|1800799024|366016|4143699003|10067099003|56012099006|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: bR55gF9OOEfAN6PqL6/1O4SmBHj5co4Jv6p6AsY5YRhg54nPWFfiE5Mf9SxJ01Cy3m//X7tx+hmZCzhfDo5jtvkE8NfPu3h39ixs/k+RGZkaCmQLarfzjpYOcYQcP83NaNqPvSsq7gE7hkCaeW58YBzlVT6UNIOJ4Dd/GXLffl4UowTPX0RQg23qBTBTcO0xwumo5mgdJsyO/NscQYAQNGySEc/rTISAPonCrr3d+V4PEqQ3HAIW6ECgq9Cf7WHORF//ZU2koeYYYqW1ivl66lFFPlve5BXyB5VhmPBpij7KrrmHhdPjRbcTOdmAaUXvan9TYRjk2Qa0fdtJn63xgIUeEpEjFQx6UkX8QIfJUXNTNOUL5OI2g7rEJhCYi5zsl4PmuicKA2sSBXTduDtdu9hJ972YRaS+cEPjbLyzt5FIaW5KlQZAKfoIHKYUCdrVqtmj08eNWd9P8rsI9OkpBKDJe2Dc00u3mwFIvjgfM7PZ0IlCU9sH1zoXDO/vTqgpIhVWLzSVXmeD4ouRVHlfMwJqg/+xhtAvbwmNJbyO7AYAMKoC2BCFTpgDzt+Pv4T6EO5R5AwXzLt8YV885BCAbgfHYBbUcjNs2635kh+BTRpd5u/CTa3J7TIRhDuyAMEILwrB0qzAipwgRgfXNTkI8YEcL/LLuzC7O3kkq3BYCuk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(4143699003)(10067099003)(56012099006)(5023799004)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEpIYzhJUnFrVFBqdm9NNnJRNUhEbnRWMXRzd3k1N3Nid2NOT2p1S2pobWtj?=
 =?utf-8?B?Sk93MVBqVStVQ2RVZTN2bWF0QnhISGxGdEgvT1FsdXVVTEw5cEF5dDUyTVlt?=
 =?utf-8?B?djBBbjQ3UnhhZHR4dUJWQjhDWXZSK3BDTkNxRytvNE9GV3FWSThYWmw1Znd0?=
 =?utf-8?B?cW5WVksraWhhQUdrQTY0ZHYyakFFZ09BMUJqZEEzdjdweDRDU0dPeTBIUnNl?=
 =?utf-8?B?R0hjMi8xY1FPdEYwR1FWRUpmcFV4cHZYenhtSk1wU01HSEFKSkVFVTJGVXVy?=
 =?utf-8?B?NW5xaFlTS0QyTkRFbVB3VXk3QnUxTENENm1iLzZ5a1JvaVZWSnoxUnBsdzdC?=
 =?utf-8?B?VEtXaStpSkxzYVc4ZFBPWElHOEdYeUdhWU1oZm1WRmc3S1FZcXJ6U0F4WTZl?=
 =?utf-8?B?eUdyOVZ1R1o3Mm4yTGl4T0FEUVJUd0pEMXo2VE1SaUdFc25QeGJBelZadkZZ?=
 =?utf-8?B?UnNUYUlCMTFJVzZZMlNJdUVBSWZNVUwxV3ZtSk81RVhxdFZETlpRVnNlNGp2?=
 =?utf-8?B?dlc2eWVMeWg5VVJZWnVZM25KMURoT01BR3JKRWQzZndPdlpUZFNrS0pGQThZ?=
 =?utf-8?B?UmxRM05VMnc4c2ZKWUdzRk9acGVaTFZKK3pVVUU0SVZkRmZiYnlVM2kxYVBo?=
 =?utf-8?B?b0Q4bnZoN3czRXZ0VG9EWm1HSTJZM0NNNzROVXRCSTZDR1BJZXB3WUMzb3FL?=
 =?utf-8?B?bmxVdlNFSTBML2ZZZTk4K2I3KzdpQ1FOK3RZVjlPWlVZUGtCTTVxOGE3TFRh?=
 =?utf-8?B?TTdkZWNRMTFjMTlvd3ltbGlUbHBZN2xxQjg4ZkYwYUJzT0pESXlralJqbHNq?=
 =?utf-8?B?bVVndzliNEFKZHpiWlRrMGZmTXhsY3lIOFRZL25BSUVhMHpBdDdiUG5iVmlS?=
 =?utf-8?B?eG9aejQ2TGIrK0lySUVyaTJTbkFVdWxhbHBmREtkTmxocXROelZJakFUYUhQ?=
 =?utf-8?B?ZFcyTDZlVUk4TGNrYjRIL0hidkxPWk5SYkNVdnZRMDBRNm1qZXQ1VWhyWW95?=
 =?utf-8?B?bVczVXdncGdKbGV3OEZtejZqSnhSaTQxdGRhMXdoWit2ZGlvaWw0M2xLN3JK?=
 =?utf-8?B?VTJUeHQwUG01U3R4SE9PcEg1VUJFV2R2WUw0aCtubFZsM3hJRm1mdkRhbVor?=
 =?utf-8?B?NWRFNnhZUnljMERqcWd0OEw5UDNWejBXSHFYT1IyQnUwMW1hWUU5NUNjaDNw?=
 =?utf-8?B?ZTFiUnVlOHNFT1BUdXFsenJhbUpVUEh3em9ibUtGejBVUXZFdGZNaVo2ZEJP?=
 =?utf-8?B?SjVRUG5BVmJnUVBvamRBMmZHOHBXUk5iQ1B1Y2ltcXFkNmV0SDV0a1g3N0ZH?=
 =?utf-8?B?K2huRWZ2RVladkZRRDRxNHI3V3JhVHdvUXhHOFBocE1jazVrcDFYOG9BbDBF?=
 =?utf-8?B?ZEVMSFd1RWk0aDNXK1NnbUF3SytObHA3RXJDNzkrRTdNYk1ST3dWNmM0eUdz?=
 =?utf-8?B?WEMvcWhxa0NHNEhCRldZbnd6OWsyeVZZZ1BPNG5nZUdaWnY5bzB2ZWxrSE5t?=
 =?utf-8?B?QUJyZk9xN1NFeUxUTm1Va3Q5TWNHVTY0ODE4U2tjb3FaRjQ3TGJRTEZNVlQ3?=
 =?utf-8?B?R3FMRVQrZUdxVU1yWkU2TUlMNW9tY3J4VzlvV0pnY1NGcGNXb0xVVVk3R1l0?=
 =?utf-8?B?d2NXazk2SlFZK2w1K0R6enlCZXBTeExmRnZiZmJaWVVqbEdnRWJXU3crcG9Y?=
 =?utf-8?B?RWJ2Z2g4Z0J4TkJ0eEs2SWFYRUpWZ0tSVlpQczVoc0lkbW9xRStjeVpEZ2c2?=
 =?utf-8?B?OUFUSUI4bThTSUZzRmNUVkdOelJLWlRMRkpwVGJVUnRhQllQc0lZWlMrZ3dY?=
 =?utf-8?B?TDVNVkxodkVxR2t1a3ZUamQySWFyWjJCYXNVYlNQU3VMUU5wazJpdjBBajE5?=
 =?utf-8?B?UlpHYUNRek1Zdmx4RVBNdHZSY0tabTJ5dUFVVnVreUVraXlPUXN2cjhIYWFP?=
 =?utf-8?B?Z1FHWEdMbkoxYzJIU3JRY2pxS01NYVIwL3J2QjA1YUIxTlBpTGQwTkQxU25Y?=
 =?utf-8?B?TzZzMkZHY0F6ZXVnS1ROU1hrL0MxKzFKS29TaGhXRENvZEMrS0Ezcmd6anQ3?=
 =?utf-8?B?ZFZOYW5hNXhsV0JMVWI3RVVYSGV3WW9IZTJJQXZIVU95R3ZOQlhGSzlmQjFS?=
 =?utf-8?B?SSsyU09sdmRLVHU1bk44ZXhLMkVTUFc5V1pUMm5VQnNlNk9JdHd1SnlWeVV1?=
 =?utf-8?B?S1o2T1M4Nk1oRTkzNFNETTAvZnRRcDVmcnhQeHd4ZEJHR1NDYUU4NVAwS0JP?=
 =?utf-8?B?SWNEUXZybHVQdDN4dFYyekMzV2JXNkVaT1RyK0RlYkdBSi9hV0tQNVdvU0Iz?=
 =?utf-8?Q?z8amb5FFf2piqTAxwR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa09384-4982-46e2-68bd-08df1d488a72
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 10:09:10.9317 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOShepzdSoy1epTOkaBg0QSExypExwIKlg00kkTlV54MaVcnsb+LgXcMomuzbgHH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7144
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

On 9/28/26 07:38, Jianfeng Liu wrote:
> With CONFIG_DMABUF_DEBUG=y, dma_buf_map_attachment() hands importers a
> copy of the attachment sg_table with the struct page pointers stripped
> and sg->length zeroed; only sg_dma_address()/sg_dma_len() are carried
> over.  msm consumes sg->length and sg_phys() in both of its map paths:
> 
>  - msm_iommu_pagetable_map() (userspace managed, per-process GPU
>    pagetables) walks the sg_table with sg->length and sg_phys()
> 
>  - msm_iommu_map() (kernel managed mappings: display, and TTBR1 for the
>    GPU), via iommu_map_sgtable(), which consumes sg->length and
>    sg_phys() as well
> 
> With a page-stripped sg_table both paths silently map nothing and
> return success.  Userspace then observes arm-smmu translation faults
> once the GPU first touches the mapping, e.g. during hardware video
> decode:
> 
>   gpu fault: ttbr0=000000088a889000 iova=000000010741c000 dir=READ
>   type=TRANSLATION source=UCHE
> 
> and __arm_lpae_unmap() WARNs for the never-mapped ranges when the GEM
> handles are closed (a WARN storm of ~470 traces within a minute of
> video playback on my x1e78100 laptop).
> 
> For sg entries that still carry a struct page (native objects, and
> imports without the DMABUF_DEBUG wrapper) keep using sg_phys(), so
> native objects which msm never dma-maps itself (non-MSM_BO_WC) are
> unaffected.  For page-less entries, recover the physical address from
> the DMA address instead: dmabuf attachments are dma-mapped against
> the msm drm device, so the dma_addr -> phys lookup can be done with
> iommu_iova_to_phys() in that device's DMA-API domain, cached per VM
> in struct msm_mmu::dma_domain at msm_gem_vm_create() time.  If the
> drm device is direct mapped the DMA address already is a physical
> address and the lookup degenerates to the identity.

That is not in any way better than illegally using struct page. The point is we need to get away from using phys_addr at all here.

Regards,
Christian.

> 
> Applied on top of "drm/msm/gem: Drop use of pages for imported
> dma-bufs" [1], which removes the remaining struct page consumers for
> imported buffers.  With both, hardware video decode works with
> DMABUF_DEBUG=y, tested with clapper and chromium on x1e78100
> (Snapdragon X1E78100): zero arm-smmu faults, zero io-pgtable WARNs,
> correct frames.  Without this patch, the same system logs a WARN
> trace per unmap and falls back to a copy path for video playback.
> 
> [1] <20260926183051.25754-1-robin.clark@oss.qualcomm.com>
> 
> Suggested-by: Rob Clark <robin.clark@oss.qualcomm.com>
> Cc: Rob Clark <robin.clark@oss.qualcomm.com>
> Cc: Dmitry Baryshkov <lumag@kernel.org>
> Cc: Christian König <christian.koenig@amd.com>
> 
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
> ---
> 
>  drivers/gpu/drm/msm/msm_gem_vma.c |  9 ++++
>  drivers/gpu/drm/msm/msm_iommu.c   | 90 ++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/msm/msm_mmu.h     | 13 +++++
>  3 files changed, 110 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
> index f687a629629d3..322b96e0e07ec 100644
> --- a/drivers/gpu/drm/msm/msm_gem_vma.c
> +++ b/drivers/gpu/drm/msm/msm_gem_vma.c
> @@ -840,6 +840,15 @@ msm_gem_vm_create(struct drm_device *drm, struct msm_mmu *mmu, const char *name,
>  		goto err_free_vm;
>  	}
>  
> +	/*
> +	 * dma-buf imports attach against the msm drm device, and their
> +	 * sg_dma_address() lives in that device's DMA-API domain.  Keep it
> +	 * so the map paths can translate page-less sg_table entries (the
> +	 * DMABUF_DEBUG wrapper) back to physical addresses.
> +	 */
> +	if (device_iommu_mapped(drm->dev))
> +		mmu->dma_domain = iommu_get_dma_domain(drm->dev);
> +
>  	if (!managed) {
>  		struct drm_sched_init_args args = {
>  			.ops = &msm_vm_bind_ops,
> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
> index da6782fca6bd2..8407a37f9efee 100644
> --- a/drivers/gpu/drm/msm/msm_iommu.c
> +++ b/drivers/gpu/drm/msm/msm_iommu.c
> @@ -140,6 +140,24 @@ static int msm_iommu_pagetable_unmap(struct msm_mmu *mmu, u64 iova,
>  	return ret;
>  }
>  
> +/**
> + * msm_mmu_dma_to_phys() - recover the physical address of a dma address
> + *
> + * dma-buf attachments are dma-mapped against the msm drm device, so the
> + * DMA domain of that device (msm_mmu::dma_domain) holds the mapping.
> + * For a direct-mapped drm device the DMA address already is a physical
> + * address.
> + */
> +static phys_addr_t msm_mmu_dma_to_phys(struct msm_mmu *mmu, dma_addr_t dma_addr)
> +{
> +	struct iommu_domain *dma_domain = mmu->dma_domain;
> +
> +	if (!dma_domain)
> +		return (phys_addr_t)dma_addr;
> +
> +	return iommu_iova_to_phys(dma_domain, dma_addr);
> +}
> +
>  static int msm_iommu_pagetable_map_prr(struct msm_mmu *mmu, u64 iova, size_t len, int prot)
>  {
>  	struct msm_iommu_pagetable *pagetable = to_pagetable(mmu);
> @@ -184,8 +202,35 @@ static int msm_iommu_pagetable_map(struct msm_mmu *mmu, u64 iova,
>  		return msm_iommu_pagetable_map_prr(mmu, iova, len, prot);
>  
>  	for_each_sgtable_sg(sgt, sg, i) {
> -		size_t size = sg->length;
> -		phys_addr_t phys = sg_phys(sg);
> +		size_t size;
> +		phys_addr_t phys;
> +
> +		if (sg_page(sg)) {
> +			/* CPU-view entry: native objects, and imported
> +			 * sg_tables that still carry struct page
> +			 */
> +			size = sg->length;
> +			phys = sg_phys(sg);
> +		} else {
> +			/*
> +			 * Page-less entry, e.g. the sg_table wrapper
> +			 * that dma_buf_map_attachment() hands out when
> +			 * CONFIG_DMABUF_DEBUG=y (page pointers stripped,
> +			 * sg->length zeroed, only the DMA fields carried
> +			 * over).  Recover the physical address by
> +			 * translating the DMA address through the drm
> +			 * device's DMA-API domain.
> +			 */
> +			size = sg_dma_len(sg);
> +			phys = msm_mmu_dma_to_phys(mmu, sg_dma_address(sg));
> +
> +			if (!size || !phys) {
> +				dev_err(mmu->dev,
> +					"cannot map page-less sg entry: dma=%pad len=%zu\n",
> +					&sg_dma_address(sg), size);
> +				return -EINVAL;
> +			}
> +		}
>  
>  		if (!len)
>  			break;
> @@ -697,6 +742,47 @@ static int msm_iommu_map(struct msm_mmu *mmu, uint64_t iova,
>  	if (iova & BIT_ULL(48))
>  		iova |= GENMASK_ULL(63, 49);
>  
> +	/*
> +	 * With CONFIG_DMABUF_DEBUG=y, imported sg_tables carry no struct
> +	 * page and sg->length is zeroed; iommu_map_sgtable() would consume
> +	 * zero length and silently map nothing.  Map from the (translated)
> +	 * DMA addresses instead.
> +	 */
> +	if (!sg_page(sgt->sgl)) {
> +		struct scatterlist *sg;
> +		size_t mapped = 0;
> +		unsigned int i;
> +
> +		for_each_sgtable_dma_sg(sgt, sg, i) {
> +			phys_addr_t phys =
> +				msm_mmu_dma_to_phys(mmu, sg_dma_address(sg));
> +			size_t size = sg_dma_len(sg);
> +
> +			if (!phys || !size) {
> +				ret = -EINVAL;
> +				goto err_unmap;
> +			}
> +
> +			ret = iommu_map(iommu->domain, iova + mapped, phys,
> +					size, prot, GFP_KERNEL);
> +			if (ret)
> +				goto err_unmap;
> +
> +			mapped += size;
> +		}
> +
> +		if (mapped != len) {
> +			ret = -EINVAL;
> +			goto err_unmap;
> +		}
> +
> +		return 0;
> +
> +err_unmap:
> +		iommu_unmap(iommu->domain, iova, mapped);
> +		return ret;
> +	}
> +
>  	ret = iommu_map_sgtable(iommu->domain, iova, sgt, prot);
>  	if (ret < 0)
>  		return ret;
> diff --git a/drivers/gpu/drm/msm/msm_mmu.h b/drivers/gpu/drm/msm/msm_mmu.h
> index 8915662fbd4d0..116daf6ce47cb 100644
> --- a/drivers/gpu/drm/msm/msm_mmu.h
> +++ b/drivers/gpu/drm/msm/msm_mmu.h
> @@ -64,6 +64,19 @@ struct msm_mmu {
>  	 * msm_gem_vm::mmu_lock.
>  	 */
>  	struct msm_mmu_prealloc *prealloc;
> +
> +	/**
> +	 * @dma_domain: DMA-API domain of the msm drm device
> +	 *
> +	 * dma-buf attachments are dma-mapped against the msm drm device,
> +	 * so this domain holds the mapping dma_addr -> phys for imported
> +	 * buffers.  Used to recover the physical address of sg_table
> +	 * entries which carry no struct page (e.g. the page-stripped
> +	 * sg_table wrapper that dma_buf_map_attachment() hands out when
> +	 * CONFIG_DMABUF_DEBUG=y).  NULL if the drm device is direct
> +	 * mapped, in which case DMA addresses are physical addresses.
> +	 */
> +	struct iommu_domain *dma_domain;
>  };
>  
>  static inline void msm_mmu_init(struct msm_mmu *mmu, struct device *dev,

