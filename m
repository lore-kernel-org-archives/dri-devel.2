Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 608B5CD4F3D
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 07:30:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC54710E0A9;
	Fri, 22 May 2026 07:29:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XBQRCazw";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012065.outbound.protection.outlook.com [52.101.43.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B43B410E0A9
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 07:29:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dnJIPZ2zfoiag/usDlFsk79b60GcVa3m+aTpJ+F1OPFwDzXq2K9J9X4mBPShieFnhMawTAhWgn1oPzAwoU5e30bRQkkO6ibP3oyUL7y8+JQY24Sv5TF4yFbFwNwiYlrO2VkzLjWJZD4qRjJdv/b0kGBj2o/i5tc0O2u6v9PWjIPg3bGQy08os3EcuxtnlSyXY1QJtafm3l38I/mTww/2X3jQaXIAlv9zhVZCYCazd2/OxT1IBbSDdvPdL/cVid8G18fqMcln8A0wCqShb3tMGcsx4FMYaJ/I9fL9j4O6vDn0v8dK7aJC5r/o+oIfGWfoHPYOXsWrLwr7p9ItPEBg1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4mq+K78PNd2T6sS2jQ1TN1fOxGJjDjP/A9J0iRavnM=;
 b=bZ1ZDQizyxWQwk88m6QMK4UetWXT5GWl04aZfaIMMQqlAEanXk/x0U8SoYfmDmR2kVGcCkWKN7h0f+cQewFO8L0B3W3Rytq6XK89CP66bldHtfpo5EhhP4J+aMd8htnthmnOq6k23lJAVRYupnAHqQbJKU3agigwGgEFLmTD6kvSuizP5l/z0gMBxQJakquRQNq6IVXUBAYK0YC9ETW8yRvJTbNbsto3Xha6fUQOoM3DmyBH6ELvzftzwWpiESxcigKiagyp1obTRA45FdOKNL777bSTA+MK6bmjYUrstqQIMfJOXfAejHAee30dnxiK0TYVqBzGTBg5hHv2yUtymw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4mq+K78PNd2T6sS2jQ1TN1fOxGJjDjP/A9J0iRavnM=;
 b=XBQRCazwTAi38GITH/LGJbq9XaxIF9WTKdjwEjWXKAO8UW9kU5gBEP9kuZU64ON9vLkT8279v+D8SY/4Kn8KGxmwCdmO9wAwNYOzpeHbM9+yAxsSdGis6BX83oa4U58qzyunjDt0JRwq87IjL51JXyCay28ZCJpvXnsWyfwOzGE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6161.namprd12.prod.outlook.com (2603:10b6:208:3eb::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Fri, 22 May
 2026 07:29:48 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Fri, 22 May 2026
 07:29:47 +0000
Message-ID: <88588749-aa0b-470b-be79-bf7316313f0c@amd.com>
Date: Fri, 22 May 2026 09:29:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] Revert "accel/amdxdna: Support read-only user-pointer
 BO mappings"
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, mario.limonciello@amd.com,
 karol.wachowski@linux.intel.com
Cc: linux-kernel@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 dri-devel@lists.freedesktop.org, simona@ffwll.ch, max.zhen@amd.com,
 sonal.santan@amd.com
References: <20260521162930.1451042-1-lizhi.hou@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260521162930.1451042-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6161:EE_
X-MS-Office365-Filtering-Correlation-Id: a45f7d49-7e38-44e9-77a6-08deb7d3e6e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: fA0OEKDLTdyuSohoMvujZxyA3U5LgRrevalYnZOoeHbj4ezwl1py2cb3rl9C1HpTpe5P7cymrxP0nNLV9aW0O5tbHgkPE53F3xY0AtnYT2CEngIXNlsVBaRlozCLul9iBNlxX/LqSbYmap6nyacp/b5JYeKLgvNlT6S/TOs/r6kK/m8t6jaLxFzMZ6dQoePV0nhz2EnqaryTW3GXH6qt+lcvNqstlBOLQmDX5TvLdduxh1+Xdm5mcPv6mRJlk2a+1u60Gm4MxbGxx0hXdihY6QKGd7FGJYoByX5gOPAN1NecQdF6Vna0oBxQe6MeIpoXthTsV1DgyrXR0OSxcsOCXVr/QvXpZS+/GwXQw4/DD9H91a/0fbnZ5esiKFLDU+TBtZ4WQXHNtSvijbLx+3qo8QBhUcSChGGcu0sflEGtHTVM2QUi0I7HKiFfhy0qxNtWkXHA0wOt+tBYpgBttAIjUJ3X/pzPwYZu2SR1BFR5/ER3EQs0VE5vnL/YCBcyNGsgu1OG+LbPpczKaS8E8CjWka36Ww9jhM1coaXsoeEsJqL/eRANs4Y5tOg3MmfqrDLOcO2dL/Ynd7WYNvqC1wc98jveyfi1hun/dIAHt4vzBJjHDjv7faRp24SJVYu5szkUx0agvgMpZ7fBK0Fnet5q5VuSJ1SfDhQ7kyPPuA6g6X1NuJM9K2SIhqxkLk5CwVbU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGpVZ1pCWm1jSzdLdGRwRG1RWkt3TUc0ZjdYOEIyK3liU0lMQVRjTEpkRTZ2?=
 =?utf-8?B?MWpoUGhqTDhPNFJva3BjaW9FSk5hRmQ5dEExM01FekxvUis3dUczOWs3RmVx?=
 =?utf-8?B?MTIwc1NCdTdCNkF4VG9qVE9nS0I2MmRaaGZvRExKTlNPdjJGc1ZvZFd3T2lx?=
 =?utf-8?B?ZDdCZHppRmJxeDcyU1hBays2QVJSUjVISHA1ejJwWlVVZEtCd3ZpN0hWYWZx?=
 =?utf-8?B?VmptVmxEUkxDRDFuNXlmcUNzbGtkaEduTThrVTZkQ1FTN296RkwyYVFpMXhi?=
 =?utf-8?B?c1h5WXRpd3pjRUtMZlNOSVNRWlh6anpuOVIzRUkwaUpIakNycFMyaW9qaVdN?=
 =?utf-8?B?ejJNeWt0M0docklTV2RrTHhFdU41VkJIRi9rWnV6a3RGam1hbE8yM3I0Tjl6?=
 =?utf-8?B?RnVvdGsyazdDZWhVdUZsUXNlb3FLeTlCL3hWSjVUZzlqQThISlhWZ21JK2Fq?=
 =?utf-8?B?Tm5wQlZPQWV5Y0o2eDczU1BkSlN6WG5nNmRxdllYcHNGREl3WWNKVmJ5a3lh?=
 =?utf-8?B?Ui9LT1JPQnFld0IvSU9lcHhEU0FRWllMMDFjNlpZV3J2QzU2cUYyTzQ4THEv?=
 =?utf-8?B?STF4YU5acERDSkdTNDJyM25lYk0yenNqOTA2MFZacDRxalJZSlBQUVNIUndu?=
 =?utf-8?B?b1Y0akpOc0t6Ui9SdXNVeGxyblBLMXVWdnRQQzJLWVIzZmtiZ2ZsRVR1amoz?=
 =?utf-8?B?cC9tc2d5ZVFGVnVMTDNXQUtYL1p5N2RBNnJla0FCeFc0L3BBUmpQazR4dU9r?=
 =?utf-8?B?aTMwSVYyZncxYWMrVEo1SzdIQVpYS0swWlFGYk9rR2x1VkM0bWhGdjFsQXQv?=
 =?utf-8?B?Z3NvMUZkUkNya1I5VEZick1PT20xZm1xaWZhQVFNdmdId0kzMGRqc28wRkI2?=
 =?utf-8?B?ZFlXOU1HK09kdGU5TVY0VnlxdW5iOUlZZS9aYzl6Y3dHNW1MT3pKcVJ0VjZS?=
 =?utf-8?B?Vy9rdWE0WXVFN2thYVZPY1llQ0FUenV0dkxESGM4d2ltb3c0S0ZJa1NJTnQy?=
 =?utf-8?B?NWJzMko1d2tjVDVHNzM0Z3c3cnVGaHdZR2xMTVowbDFTejlHWnJJOGJHbmxG?=
 =?utf-8?B?K0FnYmxtNjR5K242MkNHZGwyN0REVFh5a3lOOGQ1d2JvY3NtcW1Oc3JobmZr?=
 =?utf-8?B?aUQzMkphRlNhdEVqOTA4UWhiYUtZTUtWZDNEZHNVRVgxNEpHbzNOOTl4OGNP?=
 =?utf-8?B?K253RG4ralIyRlZwRVk1aE5wY0VGam5XWUVmRDUyb1NkeHppR2Z1R3V4L0Zh?=
 =?utf-8?B?dGVMbitHbkZ3U2ZsSldmYzU5dDgxTDRpaDIvUm0zcFF5WFZESkdtQlppMDB4?=
 =?utf-8?B?RjFCWUt2ZDYzTUFvV2dZNEJGeTdXOCtDenNlTS9DT21VSDgxa0ZvUFR0Z3hz?=
 =?utf-8?B?ZXFxZTFFdFhKcW9uRno0MDJ5eTVMMERMeXJEOUsxb1VyR2xKRHlEUktxcThk?=
 =?utf-8?B?M051TmY4YkRwS0Y5dUdtQXRYS3hpUlo5bDdkeFZuaW9zdjFrUXN4aWlOQytX?=
 =?utf-8?B?UE9kcHZhT0JCVXZwZm5BNXlaV0d0bjFEeDA0SHVMbER2ZTRhTXRzNko0RGxh?=
 =?utf-8?B?aU5xOGNuN1RWVElsdzZnVEYzMlNzc3d6dXhYUVY4TEwrQndWR2hyWkgwRjB0?=
 =?utf-8?B?MWxKVllDYjJMWXVqVE5pK2hSU05jTzQyZlRkUDNvUHU3aEVaYnFzZTZCdEV0?=
 =?utf-8?B?V0NjOEw0YUs4NU5INTArVlIrN1o0YXl5SmhyN1VVaFplbUw0MllhMEhrRU10?=
 =?utf-8?B?dVZxK1dTaFdpNTJqdU9iY2Z4U0VDSDN2cnhOYTM3ZzgrN1c0R3JwT2FqdmZ6?=
 =?utf-8?B?K2xRZ3Z1b3lvQ2dzek0xVTdScVJoaExCZ3JXV0Q3dExGMldTbFd1Z1VmN0Vh?=
 =?utf-8?B?eHZVQWtDSk5XdlFvQUJtSXU4elg5ekZHKzJ5QWxkdUdMOUY5RGtSeFk4NWtF?=
 =?utf-8?B?ZE91M3cza3l3MWg2RTlkRTY4VXBTMTNKY3M3cVhZQ3Q0ZlBhSEN0ZjErMVc0?=
 =?utf-8?B?YjVsV2krUm5meDhRZzBFTDYxRUNsVW1pVXFaeVRwZ2VNWVFjS3IyQjk1b3g0?=
 =?utf-8?B?WFU5akZGOWMxV2puRTVOSFN3OTN3anBTeTFXK0FYdGgxY0F3bmw1RGE2NHFL?=
 =?utf-8?B?Zm9UaU96VFpqS2pLMGdpejAzRHdtZm9ob1UrNHVFaklBYzdsdVc1R3kzZjZL?=
 =?utf-8?B?SUV6QVFFdXdsRmlJdGdxaHg0N0FFdHlFQ3BNMERWbTZua3dFL1VtU2w1Q0w0?=
 =?utf-8?B?VDJQb0N1YkZEQ3V2OHgyUjRSNGIrckppc1JONlh5Sk5tSlZmOFZKTFFwaGls?=
 =?utf-8?Q?NE8GHA/qsOrK/SR4CV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a45f7d49-7e38-44e9-77a6-08deb7d3e6e1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 07:29:47.6021 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6rlNKqHfRakTFZiF5LIXQ8eBy7yMyawTWlE9dppt7Yc1XvdxAGG4QUiEx78M9tPA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6161
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

On 5/21/26 18:29, Lizhi Hou wrote:
> This reverts commit f649e63d4a6423eda8eb208638849fd6396aedd7.
> 
> The read-only feature requires further consideration.
> 
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/accel/amdxdna/amdxdna_ubuf.c | 29 ++--------------------------
>  1 file changed, 2 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c b/drivers/accel/amdxdna/amdxdna_ubuf.c
> index 3769210c55cc..4c0647057759 100644
> --- a/drivers/accel/amdxdna/amdxdna_ubuf.c
> +++ b/drivers/accel/amdxdna/amdxdna_ubuf.c
> @@ -125,26 +125,6 @@ static const struct dma_buf_ops amdxdna_ubuf_dmabuf_ops = {
>  	.vunmap = amdxdna_ubuf_vunmap,
>  };
>  
> -static int readonly_va_entry(struct amdxdna_drm_va_entry *va_ent)
> -{
> -	struct mm_struct *mm = current->mm;
> -	struct vm_area_struct *vma;
> -	int ret;
> -
> -	mmap_read_lock(mm);
> -
> -	vma = find_vma(mm, va_ent->vaddr);
> -	if (!vma ||
> -	    vma->vm_start > va_ent->vaddr ||
> -	    vma->vm_end - va_ent->vaddr < va_ent->len)
> -		ret = -ENOENT;
> -	else
> -		ret = vma->vm_flags & VM_WRITE ? 0 : 1;
> -
> -	mmap_read_unlock(mm);
> -	return ret;
> -}
> -
>  struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>  				 u32 num_entries, void __user *va_entries)
>  {
> @@ -154,7 +134,6 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>  	struct amdxdna_ubuf_priv *ubuf;
>  	u32 npages, start = 0;
>  	struct dma_buf *dbuf;
> -	bool readonly = true;
>  	int i, ret;
>  	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
>  
> @@ -193,10 +172,6 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>  			ret = -EINVAL;
>  			goto free_ent;
>  		}
> -
> -		/* Pin pages as writable as long as not all entries are read-only. */
> -		if (readonly && readonly_va_entry(&va_ent[i]) != 1)
> -			readonly = false;
>  	}
>  
>  	ubuf->nr_pages = exp_info.size >> PAGE_SHIFT;
> @@ -219,7 +194,7 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>  		npages = va_ent[i].len >> PAGE_SHIFT;
>  
>  		ret = pin_user_pages_fast(va_ent[i].vaddr, npages,
> -					  (readonly ? 0 : FOLL_WRITE) | FOLL_LONGTERM,
> +					  FOLL_WRITE | FOLL_LONGTERM,
>  					  &ubuf->pages[start]);
>  		if (ret >= 0) {
>  			start += ret;
> @@ -236,7 +211,7 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>  
>  	exp_info.ops = &amdxdna_ubuf_dmabuf_ops;
>  	exp_info.priv = ubuf;
> -	exp_info.flags = (readonly ? O_RDONLY : O_RDWR) | O_CLOEXEC;
> +	exp_info.flags = O_RDWR | O_CLOEXEC;
>  
>  	dbuf = dma_buf_export(&exp_info);
>  	if (IS_ERR(dbuf)) {

