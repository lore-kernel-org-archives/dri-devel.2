Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ABE8CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 11:54:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B67A10F58D;
	Fri, 26 Jun 2026 11:54:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZGLOIrPw";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010048.outbound.protection.outlook.com [52.101.85.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5124410F5A2;
 Fri, 26 Jun 2026 11:54:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A6T9sBph6QalItwbcYbzY6DAuB3xOlITFYt74+eEjdKiDr0eYYbuShylDLx+OimPF3tTgyabOJVymnBX5pG/o1fZ478PsU/fnOpyt5vibWeblxuNK0N5eb3gbpea+lD0WNkgT4K8po3rjVKZ1O0WJLt8qp/mTC6+2iZZOCkpyXRtJUOFSc7B+RbaCjmHuaHKPah0HcVf3yZjRbbGMD9gfdQCF2iL1NlV+Exd94O1EtD+52abNZFCCSFXGu4Y9fi7tuDDzuMKsFRGU0M48SC0c+DrAczn7PBPzA41q529OtadEGq/wwfnzYjbZLwO0b/oNK1v5hLiTpwr+u+FRlzHXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6MiLCB6md5Ri7bwNjP9cZgriSgAPYITp+jnvQjVbtI=;
 b=IANDoBNPpsGYkR69uOvC4AKtvHWWNLHvyPtgNbm2VxzwOOHVDrs59Ph8jQGvQZNN0jfPp06L+dtBdThJcr1yqZW1SBiUw4M3JD5ZVUToNi3T6NS82shY0zdPA1SbWza9HajJl4XoyOSOQKmtwB1eUooda24810eIo5coe5wBBHii+dSHoPv39UX1FZFV//BYM20inbalLG2ayiNXDTqq24OwE7+m5efrcSnRiQOEP5rTQQMadbyYKp/CvxQeyZicy6P3UBNFbBmeNAxYDXnfi1r9qXxnWQxf84MUktm0VqOK/y/LhX9A2zPdQmaYnLPP7pzyUFTxH1mSzCvrgALDPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6MiLCB6md5Ri7bwNjP9cZgriSgAPYITp+jnvQjVbtI=;
 b=ZGLOIrPwbENWqFWzZhVPMeMbsneq8Chl6vgfOx93P9JuiI7k8fbi+0YAVZ+HkPODHExxO6JDlFmCXHpYCG1fDI3gInbk2YoWIpW+YfURdz2yOZ4N+QY47OKq2omoeZe4lPC7Rpu8703D+DtLgIY+tBBLkNpmuzIEsuF7emCI/fQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY1PR12MB9627.namprd12.prod.outlook.com (2603:10b6:930:104::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Fri, 26 Jun
 2026 11:54:44 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 11:54:44 +0000
Message-ID: <104c8e60-11f5-4c08-86ca-51ca5c8bf57b@amd.com>
Date: Fri, 26 Jun 2026 13:54:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdgpu/jpeg: deduplicate jpeg_v3_0
 process_interrupt
To: Tiago Dourado <tiagodourado@usp.br>, kernel@lists.ime.usp.br,
 airlied@gmail.com, alexander.deucher@amd.com, simona@ffwll.ch,
 "Liu, Leo" <Leo.Liu@amd.com>
Cc: Luiz Fernandes <luiz.f.f.fernandes@usp.br>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260626030013.20569-1-tiagodourado@usp.br>
 <20260626030013.20569-2-tiagodourado@usp.br>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260626030013.20569-2-tiagodourado@usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0244.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY1PR12MB9627:EE_
X-MS-Office365-Filtering-Correlation-Id: c78d9f22-b11c-4479-aa69-08ded379b643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|6133799003|11063799006|5023799004|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0cdkeFEE4NSw7JQyQgVAbayUBTRqIXoIht1axgQGGLSFIxDhaQkE8m1XGg7fsQrjj6SVG6Xw/uk5DEbEH9maRSvS4PHvXQpzDxsKszaxElo51ucmqaxO+c6GTUKZa8K77Th+DS5N1AJimBysstJu1SCcA8W6QSLJ6oXC1a0agCNUPax4Hn3AutcCoeRxKHBLGzj3dJkG/Rl7IvhHNZ0rU4JxfUEr2/nYKnnDk7mXp5eXxN61l3LwaqJUH+YQoXoW+zuRa+6y2PI0ptLPn9VILlV8ObK5tOYg7iJxfiX2Ta0pjD70vC7uqHY6/kpq5JD+B16MZIWhumYwTvFdgRYURCOZRiwYbpjXe/xeCBK44XjZiyqD9Cy0FNZOgm093b+QoKdE+vvcfSExCYKl4vFlHRQJOaQUCl5CA1CY1QXZij0jQWUou6hChi3lTmv+FHkYszH0NPweM4BPgdWRXgjWAhwFGW6ExxTnBHtAJEYAFfN0R4ZAidPSZDgeDqkTnBw0WKvYL9CL01JSc++r4EyJXTLMHB6GNqJPyHWmI6xrDYpAt75i04v+ZcTQjjr8jJoCFoDFUz5HZ427E/1KmixnvbWMbFml3PkhIfVxeq+anaPrCwwUmnBk8ILw7UUlR7em4BdFKke7nDmUa2WAjmnOzi3oY6AKGYDpZy9SBZH4J6A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(6133799003)(11063799006)(5023799004)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejRBV2RSTElFTldxaHBnSmIwT2tnMERBenRkZXNYZC9jc1VNdVB4Z3lGN1VE?=
 =?utf-8?B?THR5cXRvT0tVdXVOVFI2RFkrOUI2Q1VqUC9PTjNEV01UY1YwVjAzTEppejhv?=
 =?utf-8?B?Nk5OQXFlZTVpMjFnbzdkeU45ZWc1ZzF0RERJVWlSdVhyU3R4eGhITnpIdEtk?=
 =?utf-8?B?eUhnOHR3RE45TGVtaENPT0llZXVocXF3d1p3TkRjb05DcTRIMjZDR2h5bFdy?=
 =?utf-8?B?WHFsUmtGUnUyOUdnQ3pSWnliM3FJOWZhamhzVlBibWRQc1I5RldicEliQjJq?=
 =?utf-8?B?em9KU2J3eUVaeXIvbjd2Rk1NMGhOaXZ6OS8rdE4vZXRlVFhYRStKTFFoaEtw?=
 =?utf-8?B?QXI2dEJKaFRiTVRlRUFPUDNUV2NBZWNUUlowa1k5ZXA3Sml1a1FaNW56T1Fw?=
 =?utf-8?B?UTFNUlcwK2swVDZkVVNhQTAxcTNuSHJXekdNcGkvQVVzNXhla3lnbDN4VjlW?=
 =?utf-8?B?djJrQWd5SG9PR1NyRWU2cUtWUnhVU0JVdi9Xd1g3WEhNVlFKQkVQZkNrckFm?=
 =?utf-8?B?dHVZY09hZEYvcEtEMFVpazVqMmd3ajhCNXA4S21VY0NOTjBjSzVNOVFKbzBp?=
 =?utf-8?B?K2p3eklvUTc1K1lCSmwwWVdmU3NQRTJxdnNwbDVFcUkzZk1iTHZGNTBWQ3VN?=
 =?utf-8?B?MERkSlNCTC9UV1FjOTZ6em1pOHZnL2hVMjRHcTJrT1Bjd0FrcmlDbngwRGtn?=
 =?utf-8?B?dGZ4Q3ZmWXl0SVltRnhmd3dmUDcrN1U1bE11MUtwOGZHSzVuZ2VxajNicjhH?=
 =?utf-8?B?Q2ROeG95d0FzdjZSakdyMkdqNFZzb2RheUdraGo4K05ybkN3RjVJTHYveEpC?=
 =?utf-8?B?c1Q3MUVmdlJVT1BkVkRVWmFZbHpRWmg4MG4yQ2Fwc1F0RnVhdGVUUGtKWXVG?=
 =?utf-8?B?Y1B4UEk1UDVVWGVyV0h6aTdpMEtQWjRSbTVSRWVkVXBTQjFRNEYwWWlaMmcv?=
 =?utf-8?B?ZE5BNDdwSVBZRVR5eEo2cFZMUGFEWXVwT3A2ZGE4Sm5GVk5paHl5N2tyVTJU?=
 =?utf-8?B?SkkzZndnMno1dXg0WTh0OW5UTTBVUWsva2hCYmc1ODBlVHlrZlNvbS9XSVNk?=
 =?utf-8?B?ZWMrcXAvUS9XaVQ0bGt1eHppblNKVGloQ1RUbFkyY3JrVUVGRVJkaVkraURT?=
 =?utf-8?B?TFloV1B1enhZMDRiT1g5ZnVIL0xBcXJSN0ovSXhKVytGRU1XM3FWZnQ2aXpm?=
 =?utf-8?B?N0hqZjZjRWJQcjljeFphSXorRmN4VzdQVmhyYVM3Mkh0QTVQcVZSRlRwbEwv?=
 =?utf-8?B?KzZFd09MaS8yMjdhYzdkbGdISUtPZ1d4OGlPbFo1ZFBwcTEyMXhWOXl3YWFP?=
 =?utf-8?B?ejI1dE1GYndWampnaTRnakdNVitNZU9SaEY0VW9uQUYzTGFoU0dBVDBRbTI0?=
 =?utf-8?B?aC82d3hWTW9YMHlkdUEwazlmVDV6Y2pqbEtEQk5ubGxFT2o0OGxRM2xCSktL?=
 =?utf-8?B?ZHZQNlFNai9FSm5VL0FZOUFIangxWHpNR2p6OXUyOWtnL21rVTBSTlNkYkVu?=
 =?utf-8?B?UjBUdXpmK3o1WTc5QlZMRC94VUVlV0ZCakFVK09lMGFWYXdLeHdvc2pMemYy?=
 =?utf-8?B?WFRCVG82Tm84b3FHem9RU3pObk5UVHc1TkxoM2QzREw1dzVMaFprN0Z6Tm00?=
 =?utf-8?B?aitHVk1xWFc0ckY0K2x3cnVEcG50aWlIcFJXaWI3dHBMTElDc3JkWU1xdVRS?=
 =?utf-8?B?ZnVvZmRhd3UxUmw2YStnZnZXYlNSODVDTGxrUXJUeHl1cmJPamxXdlZTN1Jt?=
 =?utf-8?B?WmZVV2RZLzllS09QN1Z4RWJDZ2dtblpFTVdDQTlMV0R4R2wyMm9qaFdzd3VS?=
 =?utf-8?B?VGhzS1VUbFFvcE5jM0dlTnU4eWtXZW8xLy9lamV3OGd3SHlFbGJMUk1TSzBF?=
 =?utf-8?B?QUxKS0NNZldWekpaM0NPeHZtWEw1TW82WTFjMUk3MmhCVk1YSDljcnBVTFhw?=
 =?utf-8?B?Z1dSWEVyWUlKMml1WHY2VnVDQWY1Q2p6V1FVb3hxMnhnbUhhQncxNkoveVdP?=
 =?utf-8?B?OWxaWDY4TGlrNFZwbkxkdmorNGtkYWRJMEMzU0ludkxTbFRmYVBtRnorcklu?=
 =?utf-8?B?SUlpbEtMN0RhbkdTVGRYVkMrUWdhRzBnemY4WndmaUJnNG5zUk51NmgvZDdB?=
 =?utf-8?B?bWRtR1V6MHo4SlNITjgvbi9rQjgzcFkyUzdxSUdXY0ZZU1ppVG81NnBacWRx?=
 =?utf-8?B?U0lIeWhlY2F2QUVrU2dFVlh4K2FVaUQyYU5PSmRnSXRUakVxN1lIVlpHaG1Y?=
 =?utf-8?B?R2Qvd2FEcFJZVTJIamtFN3hlNXlIZVBNTkVVenhLVkVQb0xDRDMrMjYxalZr?=
 =?utf-8?Q?OwKo5nqinMAk3+Tcen?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c78d9f22-b11c-4479-aa69-08ded379b643
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 11:54:44.1201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 19G6lkaAkczEkGyFE05QWzwGWm2iDWyYDed3GufOsxk+HjPDR3yom9vWFBD3cfIG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9627
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

On 6/26/26 04:59, Tiago Dourado wrote:
> The jpeg_v3_0_process_interrupt function is identical to
> jpeg_v2_0_process_interrupt. Remove the duplicate implementation
> in jpeg_v3_0 and assign the jpeg_v2_0 version directly to the irq_funcs struct.
> Export jpeg_v2_0_process_interrupt through jpeg_v2_0.h to allow
> cross-version reuse.

Usually we intentionally don't do any cross IP version reuse, that has cause tons of problems in the past.

@Leo any particular reason why we don't have a separate SRCID file for VCN3?

My educated guess is that nothing changed compared to VCN2 and nobody cared to re-generate the file from the HW definition.

Regards,
Christian.

> 
> Signed-off-by: Tiago Dourado <tiagodourado@usp.br>
> Co-developed-by: Luiz Fernandes <luiz.f.f.fernandes@usp.br>
> Signed-off-by: Luiz Fernandes <luiz.f.f.fernandes@usp.br>
> ---
> 
> v2:
> - Assigned function directly to irq_funcs instead of using a macro.
> 
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h |  4 ++++
>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 21 +--------------------
>  3 files changed, 6 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> index 9fe8d10ab..9006fc57e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -747,7 +747,7 @@ static int jpeg_v2_0_set_interrupt_state(struct amdgpu_device *adev,
>  	return 0;
>  }
>  
> -static int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
> +int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
>  				      struct amdgpu_irq_src *source,
>  				      struct amdgpu_iv_entry *entry)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
> index 654e43e83..4f400fb47 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
> @@ -58,6 +58,10 @@ void jpeg_v2_0_dec_ring_emit_vm_flush(struct amdgpu_ring *ring,
>  void jpeg_v2_0_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val);
>  void jpeg_v2_0_dec_ring_nop(struct amdgpu_ring *ring, uint32_t count);
>  
> +int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
> +				struct amdgpu_irq_src *source,
> +				struct amdgpu_iv_entry *entry);
> +
>  extern const struct amdgpu_ip_block_version jpeg_v2_0_ip_block;
>  
>  #endif /* __JPEG_V2_0_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> index 98f5e0622..2f3a5a17e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> @@ -539,25 +539,6 @@ static int jpeg_v3_0_set_interrupt_state(struct amdgpu_device *adev,
>  	return 0;
>  }
>  
> -static int jpeg_v3_0_process_interrupt(struct amdgpu_device *adev,
> -				      struct amdgpu_irq_src *source,
> -				      struct amdgpu_iv_entry *entry)
> -{
> -	DRM_DEBUG("IH: JPEG TRAP\n");
> -
> -	switch (entry->src_id) {
> -	case VCN_2_0__SRCID__JPEG_DECODE:
> -		amdgpu_fence_process(adev->jpeg.inst->ring_dec);
> -		break;
> -	default:
> -		DRM_ERROR("Unhandled interrupt: %d %d\n",
> -			  entry->src_id, entry->src_data[0]);
> -		break;
> -	}
> -
> -	return 0;
> -}
> -
>  static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
>  				unsigned int vmid,
>  				struct amdgpu_fence *timedout_fence)
> @@ -629,7 +610,7 @@ static void jpeg_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev)
>  
>  static const struct amdgpu_irq_src_funcs jpeg_v3_0_irq_funcs = {
>  	.set = jpeg_v3_0_set_interrupt_state,
> -	.process = jpeg_v3_0_process_interrupt,
> +	.process = jpeg_v2_0_process_interrupt,
>  };
>  
>  static void jpeg_v3_0_set_irq_funcs(struct amdgpu_device *adev)

