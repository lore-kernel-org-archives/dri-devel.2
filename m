Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC80CA5FA1
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:38:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BF7010E7DD;
	Mon, 28 Sep 2026 08:38:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0NUTnhtM";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012059.outbound.protection.outlook.com [52.101.43.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A595C10E7DD;
 Mon, 28 Sep 2026 08:38:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDfHoyF8XAoxMLKfH5pPctH4sl9MRubO/V7LLg38zss54NGsIFgq38wAM73O+3/iqkMVcBqFyHBpXcEJjp9VEVgg3fHl0nzqiVSs3KQjtPzTZRt8l4p/y2EDhaBDNWvp3WYbv99nkwe+dzuCN0/rXK4f/pJtHvTpFH7YF/mpCAPT2XPFJb/IuqPB4a+GJxqEtU6Ogq+W3eKHyynbsK5iujj6fEzMC9pfp2vul5U1j76LKCtuc9w+bG6O+hdKVtULoL+nRir2f489Qmaa2DxD82yWhHhsfII7wvwv6cqrJTqxKcAqiiCTlfzl/DVMtSeu/7wAbWuTnr9PQBetp4uDFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aEiFj8pFT4oSnif3TTK5ob0he2/ApiFmie9l4K8CLng=;
 b=zNuU8qB61fzw3TtJ3758uxsW38QkNQMURgmO3d4OY6JRt0AMT/ZUSMc0L5tB2MIWHfZkNptb5JYJsZtvo5X6wMa0TMVxdvmABgbC3/2uswX1INGwclzqMiSaQpzETfk76+6zxjTRIJVC+B2Fro8dVBDRsztUHnkUnsq5EjURIJK9DpWZZn8U6NKckuSYC9i0PCbj7Z85YvdhXhlLrYR85I3Ctx9RKyp+kZCM3RIq0kPicEpLzcBZa3gnPJvVMQqKTOyKvlQU9trf3WFRwXDIeZXdYh9dLH2g5CPysZdoCtxfiSor8BuAtDS7bPiBss9QL3WKLyUjkaL6tlvwAgLX5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEiFj8pFT4oSnif3TTK5ob0he2/ApiFmie9l4K8CLng=;
 b=0NUTnhtMogi8Dpturd3AftMzOnlWd3vya2C2mkqMmJS/18KBBESAkMSo1Kw+xf3DUjVAZAefLPrrLd27ucK+0glWpn0UUTf2uVtNx0He0NtOTfKdMdvu2ixt2RPmiXlKnAExInOBxbdGXQIjAOQD8sI8uzGinJrL6zYzRrON6xo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV8PR12MB9271.namprd12.prod.outlook.com (2603:10b6:408:1ff::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 08:38:00 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 08:37:59 +0000
Message-ID: <86ffe7f8-88f6-429f-bc4e-468fba5ed668@amd.com>
Date: Mon, 28 Sep 2026 10:37:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] drm/msm/gem: Mmap imported dma-bufs via the exporter
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Jianfeng Liu <liujianfeng1994@gmail.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:DMA BUFFER SHARING FRAMEWORK:Keyword:bdma_(?:buf|fence|resv)b"
 <linux-media@vger.kernel.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK:Keyword:bdma_(?:buf|fence|resv)b"
 <linaro-mm-sig@lists.linaro.org>
References: <20260926183051.25754-1-robin.clark@oss.qualcomm.com>
 <20260926183051.25754-3-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260926183051.25754-3-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV8PR12MB9271:EE_
X-MS-Office365-Filtering-Correlation-Id: c2e5b21c-7267-482f-de7c-08df1d3bcd6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|23010399003|1800799024|4143699003|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: X5P/nPjLXJzsf3QzMFsOsqLUIqlZpqhNKf4piSzxW4UPR/rP8htrJTqZw8zCJSFiL7UmkDVI8o7JrrFV23cVIgc4XyWdUikduLTQ3QowL63B2xmnfi3heFdGFrkHPpEO2BhZMawrvtuTsxhDFFKt00+dy2IFbMWoeXXtiGauKG3+w+yN7PW7sYBPFgz6KD0NMTssF//Lb47lUiR7BzamjAwA2TvMROAEjuDiJwM53wjShYo5Zwx26TsLy2OzTJHd6SkFtQWYa799EV1cTAp3FYyhrOns43kmQts4GD1xClCIy3/6lSzRdsZTTZfSLW2VnBt52e6NDYXaHJue7Wi7oYSy8CVU2d8VuamCIZuEci9dFk7RGAjQ7DKKs9ym3gZGhRUZDN1l9/pAT+aGQBApgb6j0p7bvP9XudYQ4Y+1TgfCVOzc8ptOFCL/IKXyVtAr4q0EzTvjeUvMBoKe6ReK5JHle+P4cBOhbGXIm+OWpivN8MwEdvHwQ2VVeSCw/1kl01bvxoq8zACGULf2daCr6haKe/X0yUfB0Fo+AeVSv5qAjdKCB2kqHBhlK9xxwTQgHW59OjC9qohe/oiYABUPM9fweUGTG/+TcoIMYpaDh3CyPWAOnTOM8WMeedUoZf8BYQZm7nGn0AEjJK5FYVlEOIJnEmNv1Beuog1ew2SpkBo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(4143699003)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVVCekFteFNtcERZS1F3S2Z2NTh4Ykw0WmtpT2FPNlhIdTNDT0pPeGxqZWhL?=
 =?utf-8?B?aEZjSmdRR1R1cHd5c3c5MGl2c3YraEwrT1ZvdmljVnhYZVI0QUZYeDVmY1ht?=
 =?utf-8?B?dW15emhiSGxmb1lMVGFpck5FNXhiL3liOTRVcStVUDNlRFVhcjdNR1JVZmtW?=
 =?utf-8?B?bVliMmtpZVdaME1BelVIOXl1MytXR2NPMkxTQmUrUk02aGVnZks1bWJpVGda?=
 =?utf-8?B?Z0M0emZvWWdBakxaT2MxQVRDZGlkTTd4VzEvUVorcDlvTXNDSXM5QTFtNjcy?=
 =?utf-8?B?MTU4R3JSNUpWbGFxbmpuUC85Ky9UZG1ibXVwWHNhaVdhUjlTWEtDT2NZbE1i?=
 =?utf-8?B?NkhqNndCZDVTN1NqQndkaFM4eFU4Sm5zM2syUnljSGNlb1czVEhHdVR2SVkv?=
 =?utf-8?B?dWE5WGRoY2ExSHI4bzZFUEZWS3d4bkhlUTRrR29kZ3czRTBuaENTK253RFJS?=
 =?utf-8?B?djRTVzhmUXVNZ2RkbW9tQkVOOVdVekkySXJmSkJMTWVOWjRJdkhyK1gybmJY?=
 =?utf-8?B?d21xT2pCZ2hWRW1YbUpzMW9JcnQxbFBZdDlGQkd3VER2dU54VDk4L3MzeEx0?=
 =?utf-8?B?UFNuR3B3T21BbS9LUEphUEZoOWJiVmgxQ0R5RlhxV1BkUGtORmhKeUltemRU?=
 =?utf-8?B?a3NPVUt6eVAwY1I4dVZGcGRmRE1aRXZoTWFJQk5CTWpiWFBuLzdrSHhRR3c3?=
 =?utf-8?B?TEVPYlJPM1pwNmlsRUJneEZHNFU0T3pUMDZRbnNOTTZ1RGVaWFpUdFZMQXpG?=
 =?utf-8?B?MWxPbkFkcEU2d1BiV2gyR0x5ZkRyS0tpZWJBRjRKVjgvSy9uWkJsWFlvcjRx?=
 =?utf-8?B?NGFCWUZKK2h0TXZud3lmaGhzNWhWeTZyK2V1MTgrQk40WnRNWFUxVHlmYlFL?=
 =?utf-8?B?cVRsSTZJaFR4SUxSNGlqS09FdlFlNzZkeEhDemk2cS9JMmNVTWl3d0hsZ016?=
 =?utf-8?B?WDhRRXU1VzBUSkhmWFlnUldOY3Btem9lckRId1ZwUjk0Qy9YM2ZmZXViVDJv?=
 =?utf-8?B?bWc5WjZMc1h3UWE5U0pUaVJ3QkFUQjRmZHlFNUIvd2R1NFgwazRLdk5pa2Fn?=
 =?utf-8?B?VytDanhuSUpNUlN2emZBenpqQ1dVejVuZGMrZFVQa3N2QnVkTXJhQjdBR1px?=
 =?utf-8?B?SWJ0UWMrdFdRbTNZQ3FmSXN2eS85RE1hM1IvaW1Wb1p1RmlTZ3N0ckszUGJ3?=
 =?utf-8?B?UWFrYUxkSmFBVGpBa2RYbExpZWNWZWdZWnZESmoxR2x4Wjd2b1NqZmFMenox?=
 =?utf-8?B?c0FFZTNESXFDb3QxTDgrSjBqcWpNbnhENkh1L2kzdnRzZnZaTVZhWkVYbk5V?=
 =?utf-8?B?S3JJZEZ4Qm01SzYyV1lIVFkwUmRaT1NCRTgzcXBXenlkQTQ0eGVFNll0UkVj?=
 =?utf-8?B?bEVCYWxpTHZpVndGMUt5SVNxWUZqSlI5bVNLZkVwYUpON3kyT3luR252VGtw?=
 =?utf-8?B?ZTJicUNKb1lsU1B3TTFWam9RN0w5VWJ3YUFRZXZ6ZG4wU0l0elF1NnY2NGhl?=
 =?utf-8?B?L3FBNm5lN0daanVRSXc4bFZtMVNCQTFOalhoeE9NeFdvVFA0MFlWcjNpdDA3?=
 =?utf-8?B?djZCbVJ2dktUdjJkVEpCK2FFclhNbTFnYTFWRUVXVlNPUzNodDdHYUs1Q3Vv?=
 =?utf-8?B?bzR2VU9aNXh4aThSekFleERUK1JsbWw2akRwb1htN1Jqd1EyK0pBdWkrdmtl?=
 =?utf-8?B?WHVuZ3JRVU8xQkpOZEhROFZmWUVCdE1MdnRxWjE5bUt0MW9KdVlZQndFS0Ix?=
 =?utf-8?B?OG1lclcxZG1Wb3lFbEpxSEdkd0hpRTFTSFNqcXNpVUNoTUFWUndJSzdaY0VX?=
 =?utf-8?B?NkJqSnJSYVJrQTZIY0RVbTAxT29XMHpiTzljS25XV3c0MWI2MmtMQXI1OW9L?=
 =?utf-8?B?TCtxVHE5a1dsekZzL3lVT21NdlJySnhkSnk2aVpvZDNSRE5tUmh2b0haWFhJ?=
 =?utf-8?B?TmQ5WGkweFk1K0FwbEN3bVRYUWJmVEtXK3UyaWVpWVpKK2cvaWhmcnJObWVY?=
 =?utf-8?B?KzR4NWJDdS85Vlp5WDhIUDBQNGRpMlBpV0p2NVJBWkg5QjNqZTlGbzZnczUv?=
 =?utf-8?B?QTR1d2pnM0ZobDdZSWRMcnlLT21nUDl3SjBlMVZuQmlVWW4vdlZWQmk4SlRM?=
 =?utf-8?B?S2RiTWlDbEt1c1BQZjBUK056blJBSEFhTmtzMWwzcU5tMkY0SmFRMXc1M0NN?=
 =?utf-8?B?MGJkWVJaZkVxdlpjU2NZcGVBTWVBYkd0dXYrYndaQzVkUk5wQmFuNVVtZ1Ew?=
 =?utf-8?B?YTlQNXlUN2w1QXBNL3ZGMnlrby9pVWxmSm5CVTErSGRoQ0FqNURwcUtKRjA2?=
 =?utf-8?Q?ZxvP9SOPiM8N9NFa6B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e5b21c-7267-482f-de7c-08df1d3bcd6c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 08:37:59.8018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gb3xpNle1ycJ0sYyXZ1zrS17hNIQlPTIdFEcGw0YSGplXMJfwVM5jKgQKhzDcJFp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9271
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

On 9/26/26 20:30, Rob Clark wrote:
> This was always the way it was supposed to work, and when we drop the
> page array for imported dma-bufs our fault handling path will no longer
> work.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>

Nice to see that finally happening.

Reviewed-by: Christian König <christian.koenig@amd.com> for this patch here, Acked-by: Christian König <christian.koenig@amd.com> for the rest of the series.

Regards,
Christian.

> ---
>  drivers/gpu/drm/msm/msm_gem.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> index e8390ebd5dd5..c90336b3b231 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c
> @@ -23,6 +23,8 @@
>  #include "msm_gpu.h"
>  #include "msm_kms.h"
>  
> +MODULE_IMPORT_NS("DMA_BUF");
> +
>  static void update_device_mem(struct msm_drm_private *priv, ssize_t size)
>  {
>  	uint64_t total_mem = atomic64_add_return(size, &priv->total_mem);
> @@ -338,6 +340,9 @@ static vm_fault_t msm_gem_fault(struct vm_fault *vmf)
>  	int err;
>  	vm_fault_t ret;
>  
> +	if (drm_WARN_ON_ONCE(obj->dev, drm_gem_is_imported(obj)))
> +		return VM_FAULT_SIGBUS;
> +
>  	/*
>  	 * vm_ops.open/drm_gem_mmap_obj and close get and put
>  	 * a reference on obj. So, we dont need to hold one here.
> @@ -1126,6 +1131,25 @@ static int msm_gem_object_mmap(struct drm_gem_object *obj, struct vm_area_struct
>  {
>  	struct msm_gem_object *msm_obj = to_msm_bo(obj);
>  
> +	if (drm_gem_is_imported(obj)) {
> +		int ret;
> +
> +		/* Reset both vm_ops and vm_private_data, so we don't end up with
> +		 * vm_ops pointing to our implementation if the dma-buf backend
> +		 * doesn't set those fields.
> +		 */
> +		vma->vm_private_data = NULL;
> +		vma->vm_ops = NULL;
> +
> +		ret = dma_buf_mmap(obj->dma_buf, vma, 0);
> +
> +		/* Drop the reference drm_gem_mmap_obj() acquired.*/
> +		if (!ret)
> +			drm_gem_object_put(obj);
> +
> +		return ret;
> +	}
> +
>  	vm_flags_set(vma, VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
>  	vma->vm_page_prot = msm_gem_pgprot(msm_obj, vma_get_page_prot(vma));
>  

