Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CA010F92E3
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 16:14:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9E9C10E2D5;
	Tue, 31 Mar 2026 16:14:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B8Cw/4Qa";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010069.outbound.protection.outlook.com
 [40.93.198.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D85510E1FE
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 16:14:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2ZVsKX8OZFmYYcx/SerlD7Gt2BIWmd5XNwRB7QRWs3b9aStbd32ZZBYPrRxFS1jJGcOn9Q4+i76wM1GK9U67oogKS1SPOcJ3F88+5gPtMfadWwV914i8wgzok7ejvWkKTOdvbJALoV2B3Kh1XNfW1OHc7flzzRuYrWYEEDCjimpokXBlZBfqFTzYlZmC+ZoNUOkyLYRIRknjhtULdMR8IzCg8msH4ZUPKEpF7snyf02roxC9dH0quPr7XFiP8A7ITBxjElwVvT8i2ESteyO/5yy2iEv5VuO2N1V0wUA9OzqOzGRoYV7qsv+S7aMRw53AS7L0bhaKtOCI0kyr8NBRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEFZ00Q3SZ8o/eiRev3JZaenC1FlevsdRS71nM/j+mU=;
 b=vbnIE6mq7RclYs1l6t6vRrsXbExf3SZF0OgN8ehcA3iFWpC4+/QZamFLY5qq3qovaofenfK4jM2i32cAWgeeGcYoz0zbDWLraxIeqEIdi0+sQQCjnuw07PYBxUmJTQW84SVLrIMB4hvZAXYuvqTNc2lLfpwWI11B2/DHCTmTqGyLLLUp2V3/xOVAjsupQa7YG6+0nqfUKdNG3/QBnKtwJNEje/o6zTqsrgtsGe//xCG3+7s4PwqJIbgVp5HZ/8khemk76QHB+tss48kiKe4h+HAaTRNeG8yBBopJVRdypQ/QBejf/Uisj/LwErEHvv0xWlteE+8VqHpXtjMQAkOoOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEFZ00Q3SZ8o/eiRev3JZaenC1FlevsdRS71nM/j+mU=;
 b=B8Cw/4Qa/zb9hRCgMxA5KhrD7qjakUjnDKnA6oi66ZAGSg5U73zCgpZMZZqWWG6By8sh4CLJ+EOVu/Gz7BSBbqAdNqHXR0wmkx0b9J2QsOUZK0ZjiA2AVshF9GR2F38nQH9ZP8e2vElbSrfwUtvv1O5DkGo+odihJ5k2qx8TDI4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by SJ2PR12MB8651.namprd12.prod.outlook.com (2603:10b6:a03:541::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 31 Mar
 2026 16:13:54 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 16:13:53 +0000
Message-ID: <a4886d87-b359-4bf8-ae2c-02e17664bd8e@amd.com>
Date: Tue, 31 Mar 2026 11:13:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Support read-only user-pointer BO
 mappings
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 maciej.falkowski@linux.intel.com
Cc: Max Zhen <max.zhen@amd.com>, linux-kernel@vger.kernel.org,
 sonal.santan@amd.com
References: <20260326162759.2674547-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260326162759.2674547-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0118.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::6) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|SJ2PR12MB8651:EE_
X-MS-Office365-Filtering-Correlation-Id: d9465d5c-b001-414e-27a2-08de8f40807f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: ulEFGedtJy6xSGCsi4VZKDhOj5wfz3BVOJbyUhGnWlkXDJ7SGj4dEGgsnrSQu7//2NjAPz9Jf4cs1rvS5eGGfn+MXVgsm0zs9QtWbJ1CANoR4PQW9EnkzA5P0dPc4Uz/10+I8yz5BqaPBYo91CQIzdBW+N/JN+IPEHgUhLG8iRs4+pwSTXwz7J4fjXmTpCOCQ4NlJknpjb5EBpQZNT/AifaPplkj3EBeJcAN66OAfhoOuZbVUVBxTMrUbVjUKpxsbbn1SOKmgdg1P5eJmRshQCBOhhNqvBXljLjlPyg0qx6CnHMaP6To0nL0Xcp+OHhflbk+8/LCDQ9AuMVRuYpiB+v97otdWLx1s5hmeNiQNm5/1GjDf9FmHEpDlO28SODhXJH32mNb87IUR+i36UEKiTlOS0saDx2TeLESfYeX0grdCym9Ulmam+ol04SWn1fCJYKzQQzC8JpIj0aGropdkCLz5qs2S2y8xa6V1Vuplum5fIluNeneCfkyD0FloWdQ4F8RH4CNkpQkYHa3FJaxE8ZWw+UHT762DrFNAMQsJwWyuX1/PFAJvr93ZZNK3ji4z6vSeWbLCpqgRlcvdfYDg9VfLeYAku4To+nbFMuozdYK5FGj6fZ9jLNfSdmeQFxuW+JfoK8XKgUKs7cFOiShU+Rh2TGnMYZZX//WD08rPICHjsIdVRBYSLELIAyMpLk23JU9S36kM9P0ojm4kGoShCGx0VG99YndcYPYBBcnXCE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm1QLzk2QUVXSG9QS2w2emI2dmNjakxOQS9TSElHd1NyZklCdEZhMHNtLzF0?=
 =?utf-8?B?YTlJZk0rdTl0aGdCZmluMDVhdUJzYzVoNGY0NFVCSjRHRjk0TTd5RkVaMWNj?=
 =?utf-8?B?TlA4cEhXRkJTUm1peGR4MHdYVVFHazRrV3p4eTJ6cnVaY3QrU3RQY2M2NlY4?=
 =?utf-8?B?VTBpbEIwRzcvL0tMdjBlZnRsdWpTbmpIWnE1dktoNzQzRi9WSDQxSHNib3V6?=
 =?utf-8?B?eVV0RkFHSVRwOFdQdUQ2TWZwUEJRMFFlZWEreUJ2M3FhbkRtNWtmcXBkSFFC?=
 =?utf-8?B?Uy95QUg5U3lBMmFaWTdMd3o2U21haVkzTklGZjJBYjVVU1piTWY4aUJSWXVH?=
 =?utf-8?B?YnMrRzloSTVrK0dIaVovQ2psK0YvYWswMXA3MHZ2OURrZERuOG50d1gwTTBk?=
 =?utf-8?B?RVIzNkMwMTJFSmdpbys0T3EzOVAvNko1SVVPOEhRVTFYajF2eUhnNFJSbjlu?=
 =?utf-8?B?UG1XNFBwZksvT1NMaGlGTTlVbGJHa1JTcUQvcG5scDd5YWFwUWhzSTU4Smhk?=
 =?utf-8?B?eW0ySStmcWt3YTQ1M0JZWERNVzBZTllQMmxFZkI3ZnhzckI0NXNKeFNIN2xV?=
 =?utf-8?B?ejBlc3h3Q1BQeWRjUW02T21JSllYSFBsOCtNM3RzUWJJanRJNVUxNGhSNE5V?=
 =?utf-8?B?NEVkd044K3UxS044MWIzMTFBTnVRRlV3M3hRUElET0VTeGpSajh2RGtpVFpw?=
 =?utf-8?B?Z3hHM0owM0tKTkVoTnd3bUpFd2ZONDVlb3Z0dWtMRFhBU3VKNFV6ODRYWjVr?=
 =?utf-8?B?WVN5SnM1TkxkVGxXZy9Fbnk1WWZuUnRHTTV0cGRaa3FlQUJhbUo1RitVdHlr?=
 =?utf-8?B?RUtyOCtpTmptaHpZL09BdGw5dXFuTXJqR1Y1WGU2UE1rSE15TW5qTHRDRDFr?=
 =?utf-8?B?NDRFdVdGS2lvYUVueFVscGwwZkJaUS9PNkd2T3pPU1JnYWh6RW1FWHRBbDk0?=
 =?utf-8?B?QVBLOTdVVVpMN01yR1M5K0FmUnkrNHEzM1BuU2JZUERpZmNnUG5kMWkwSS9a?=
 =?utf-8?B?YS9XR25nU25zUEhId1dRWlJ0Z01pcDJPZ0EvYzA3RElxMWVibjdTM3lUejBq?=
 =?utf-8?B?SmNCYzA0cURJclBuTlRYb3hXeEJLVzZMeU9vTFRlMEdqUnU0MnNYc3F4VlF4?=
 =?utf-8?B?U1RycG1XVTRrQnpQaDNPTDFuQkcxNEtITXhLV3hQUTA1NWFTblkzYW96OFdP?=
 =?utf-8?B?ZkpGZmZxQnQ5MlpVK2JwcjE0dlhyeks0Skd1ZS8yMXUvcTZobjBoVVRHV2hs?=
 =?utf-8?B?RVBrbERTd0d1SnhaR3FBUWltUHZNZFRaSXpPcFNDdVM1ODVRTTNWKzQxamhy?=
 =?utf-8?B?Z09IU0oxaU1yQVFwY3JPeFlsQmIxaXgwMmM5eDVhSytzRmhYcTVMQ2M0UUFr?=
 =?utf-8?B?NTBGMWtoMVhQa0Q4NkQ5aUQvZHVkQUhZbVNEVGJXd1c4cTVKYmZLeCtMVXdv?=
 =?utf-8?B?ZHFBS29GZVJ0MFp1RXRTT2RMdHB3K0N6aGtReXVkazc3dHFVQlBkTjR1T242?=
 =?utf-8?B?cHBFRlZ6RXhXd0l0dDZmK3pXNENvbkFFK1NtZzN5NlBLbks4T0NmbG9pSGpy?=
 =?utf-8?B?SFJKcHFCeE1NVVBIWmlNazhEVzY0MFJNdXh3UlpGRXgraTgxNFNwRVdic0Y3?=
 =?utf-8?B?Qzg3Uk5LSm91VjVEYVNNbGtBSnVQMVFqSXNOb0lQY25HS0xkSU1mVitZSU5i?=
 =?utf-8?B?Uk1BaG9lOVQ0Uk14cEJDdndPbjI3cVg3TUpPVWlUZmVmOFdSY2xTOSsydjRB?=
 =?utf-8?B?dmg2SEpnVlhybWFnYkR1Y0k0V0owY1V3eGM3TGV4ajJFbEpsYnlNcmJIZ00x?=
 =?utf-8?B?RmV6VDRBVFZNZ0JRSHNIaUJaNGNrS3pPUVBiWXRvNkRZczlkVWYrSU1Bcnlz?=
 =?utf-8?B?Vlh6ME9zR3dzeUltNHQrelVBS3BGaVp6Vjc2YU5HTlBEU04rQ3A3cWI4Znds?=
 =?utf-8?B?MDVzaXA1U1hIc3ZuNExZb0xsUWpjSUZibVFOd2VSdEtPUzV2ZXFEVXhFTklj?=
 =?utf-8?B?dnNJMGhYMGsxU2h4a01OOTAzNU1NQkNCM0ZXVGg4NHNYUjZkalJ3SWhGTXVF?=
 =?utf-8?B?M1BRdUc2ckg4YnE5NTZ6dWZ3RUg5R3NUN0psdnhDR1BhWHRTRkgraEUwTS9X?=
 =?utf-8?B?Ylo2UFhCNEE1MjlLQlpPZjlVVGJMVkNwcGlPQ3A3U1VSSWpraWxlMEl3WHpr?=
 =?utf-8?B?b0JTRjI5L3p3OFl2WHd5MG8wczY0aU1tRWJmaEdHQTZrNExHN1E1ZExueVll?=
 =?utf-8?B?SDBPSWNMcm5VMU9YMjZjYjJCdStUeHVUNkJyK3hwb0R0UUhROUFiQktiOExv?=
 =?utf-8?B?QXBINWJWRkN1TjFpN1QzQStRSkZhSW95enRtNVhPYTFIT2ZiRkRlQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9465d5c-b001-414e-27a2-08de8f40807f
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 16:13:53.3357 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C38kbeRLKsGFzyjA6mLjYeQZYrKCAz+XUkl7OJsTJoZEkd95Y0oLRocMKtHIv/szaiYIDc7gjG4PBt+jTO9QYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8651
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



On 3/26/26 11:27, Lizhi Hou wrote:
> From: Max Zhen <max.zhen@amd.com>
> 
> Update the amdxdna user-pointer (ubuf) BO path to support creating buffer
> objects from read-only user mappings.
> 
> Detect read-only VMAs by checking VMA permissions across all user virtual
> address ranges associated with the BO. When all entries are read-only, pin
> user pages without FOLL_WRITE and export the resulting dmabuf as read-only
> (O_RDONLY).
> 
> This allows userptr BOs backed by read-only mappings to be safely imported
> and used without requiring write access, which was previously rejected due
> to unconditional FOLL_WRITE usage.
> 
> Signed-off-by: Max Zhen <max.zhen@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>   drivers/accel/amdxdna/amdxdna_ubuf.c | 30 ++++++++++++++++++++++++++--
>   1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c b/drivers/accel/amdxdna/amdxdna_ubuf.c
> index 4c0647057759..1a0e2a274170 100644
> --- a/drivers/accel/amdxdna/amdxdna_ubuf.c
> +++ b/drivers/accel/amdxdna/amdxdna_ubuf.c
> @@ -125,6 +125,27 @@ static const struct dma_buf_ops amdxdna_ubuf_dmabuf_ops = {
>   	.vunmap = amdxdna_ubuf_vunmap,
>   };
>   
> +static int readonly_va_entry(struct amdxdna_drm_va_entry *va_ent)
> +{
> +	struct mm_struct *mm = current->mm;
> +	struct vm_area_struct *vma;
> +	int ret;
> +
> +	mmap_read_lock(mm);
> +
> +	vma = find_vma(mm, va_ent->vaddr);
> +	if (!vma ||
> +	    vma->vm_start > va_ent->vaddr ||
> +	    vma->vm_end < va_ent->vaddr ||
> +	    vma->vm_end - va_ent->vaddr < va_ent->len)
> +		ret = -ENOENT;

The check on line "vma->vm_end < va_ent->vaddr" appears to be unreachable.
find_vma() is documented to return the first VMA where vma->vm_end > 
addr, so
if vma is non-NULL, this condition can never be true.

> +	else
> +		ret = vma->vm_flags & VM_WRITE ? 0 : 1;
> +
> +	mmap_read_unlock(mm);
> +	return ret;
> +}
> +
>   struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>   				 u32 num_entries, void __user *va_entries)
>   {
> @@ -134,6 +155,7 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>   	struct amdxdna_ubuf_priv *ubuf;
>   	u32 npages, start = 0;
>   	struct dma_buf *dbuf;
> +	bool readonly = true;
>   	int i, ret;
>   	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
>   
> @@ -172,6 +194,10 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>   			ret = -EINVAL;
>   			goto free_ent;
>   		}
> +
> +		/* Pin pages as writable as long as not all entries are read-only. */
> +		if (readonly && readonly_va_entry(&va_ent[i]) != 1)
> +			readonly = false;
>   	}

The check "!= 1" treats errors the same as writable VMAs. 
readonly_va_entry()
returns -ENOENT for errors, 0 for writable, and 1 for read-only.

Extra error handling maybe needed?

>   
>   	ubuf->nr_pages = exp_info.size >> PAGE_SHIFT;
> @@ -194,7 +220,7 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>   		npages = va_ent[i].len >> PAGE_SHIFT;
>   
>   		ret = pin_user_pages_fast(va_ent[i].vaddr, npages,
> -					  FOLL_WRITE | FOLL_LONGTERM,
> +					  (readonly ? 0 : FOLL_WRITE) | FOLL_LONGTERM,
>   					  &ubuf->pages[start]);
>   		if (ret >= 0) {
>   			start += ret;
> @@ -211,7 +237,7 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>   
>   	exp_info.ops = &amdxdna_ubuf_dmabuf_ops;
>   	exp_info.priv = ubuf;
> -	exp_info.flags = O_RDWR | O_CLOEXEC;
> +	exp_info.flags = (readonly ? O_RDONLY : O_RDWR) | O_CLOEXEC;
>   
>   	dbuf = dma_buf_export(&exp_info);
>   	if (IS_ERR(dbuf)) {

