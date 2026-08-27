Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2A5C61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 08:22:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F42210E5B8;
	Thu, 27 Aug 2026 08:22:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e0oDApU7";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012048.outbound.protection.outlook.com [52.101.43.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADF4510E5B8
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 08:22:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=te7VK1RhlxMCb90wwo5RQ1QRqSzcoBzhaYlZpYldPZP+HJwLE2NDTcTIWuzLmPToKQ6WKkc6xdK/gDDRy75sKY7QSQic4w49nwpIBbuxSZZLL5uyheerECFa/HNbMxrod6NYhvVMHhMOp7T8Jk6+b/Xn+CiZMJWZqnxI/FZb3RAj8FTnqdYYFeATBXRgxUEL3/WvWQ1KLH/qH9y4kay4hfNQ9nzY1wDCf9Z2RQKquR9C16TABiJscf5F3IVDagOICCX7YsDcuRkkbWX6irxKvenJDuo5ZRA3mCCmC6usIEXDHZNwMN8cG6cxaQS1OgvsRwmFhWCc6gYXQ1MdnBVrVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+W5FJvJDEw2Ztd2QW9zgGyIiYH3DLAXegNwsYulZfw=;
 b=yJ4igirfukYRk0NvLuf2plpLYn1INDXCfK8VZQZvWoKLe9GnLyZXRWJoc2v+qGB9lP8taObDNhsXU0ohCWeI4mheNiwpL5soe3lyeV2MjoXC4H3d5LaDGViaor4DElQODz6xqrO0Sur4hy0ndFgRbw3Sa8+CbVnBYv0+WTsEExBBIa43zolY1j+kEvKNW3IUJbpjNKuOTx6U8FlX++MwWYpfk0mnHUm4xidpoGrFNPmWOkTPSlrAX49BGL/O7Tvy9Wl3WfGtbY4I+MvEDaPi3UDqaS5W6S9bI52kV0gT8GuJmSQgH2YWNBOFY7ZyjtQf37W05a497UpzwLXqAdiP4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+W5FJvJDEw2Ztd2QW9zgGyIiYH3DLAXegNwsYulZfw=;
 b=e0oDApU7A3/KNT/iQMwwwYbNME8UeUxLUvTzj1/kyb/hom/iMoGnGWqWSnYe5jCqzcvxmPCfxGbjauSFCZiGmkoZf9TpzAxDQ13GLrSVE+9fmH4WV9srG+HZ6U+qSfAJ444sL7jAHZJG+kGTWP4d9/8Ovair+yRLLLu/cqEyjlU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7871.namprd12.prod.outlook.com (2603:10b6:510:27d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Thu, 27 Aug
 2026 08:22:53 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Thu, 27 Aug 2026
 08:22:47 +0000
Message-ID: <b20dc18d-b85c-470e-9eee-f33911b3ce36@amd.com>
Date: Thu, 27 Aug 2026 10:22:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/gpusvm: Assign maintainers to the DRM GPUSVM helpers
To: Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org
Cc: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Himal Prasad <himal.prasad.ghimiray@intel.com>,
 David Airlie <airlied@redhat.com>, Simona Vetter <simona.vetter@ffwll.ch>,
 Felix Kuehling <felix.kuehling@amd.com>, Alistair Popple
 <apopple@nvidia.com>, Honglei Huang <honghuan@amd.com>
References: <20260827075106.2052472-1-matthew.brost@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260827075106.2052472-1-matthew.brost@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0356.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: ed791bb7-1db4-4def-fc34-08df04146096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: lGexW/4ec6ik1FgxWel2n4IXpgVILNS7h/SMG3qR0a5mpmpSKQk3smQ1KC4Oo4hMb3grfaj17IIPOFVgo7Ylu/G/DZjrHbADPpTkhsAQxLvFXiBoGfQowBAk4Ij4c5aFZ3VFzzPEO9Pv80wpxHxDVVQE9x34D075gXgf7dH26pfZ9siTGWHQW4VO2W9ciFk/UGvSRCv9elcHlz3Sd0tK02KitKJHVGXELDUYU1IoOpkbwvlU+jO7Xl6etMgm94vkmru4dklbtcDnN1lKQlbQect2ANEPOepOOF+a6OV0F88kObiZxijaHXjyy6tDZWmUfF+obN6JPRidhIGVUyzxpkekVRSdmfQgeqeZxSu/5NdneQdNmd0zUDntmTs/imryd/HSOrDu/W33xgCaV8/v+bxdviiQbrhK9Hff5irSOtBDnxMOgSGFtG9aQzTmsrM8wJaXEb252n80YoLk8D23qC1rNQfSRv7pQxFp0XO+vu3/0AvuS9WQBSOQDCvFz1KFVsaGRmiF2wTrfxilQf29qVTOvo/EfTa1NlfLu1ek+XeiscB0gdQYI1Y235a2WqNkaXFryc0KG0zT4xDNbfY2A56loz3DHb+etf3myf4pWG8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDVZejVTVVJvUldRMC9CU2tVNVB1dXBZZWU5dDhaMTFOYnl4dWh6RjlvOUcw?=
 =?utf-8?B?SEU2NnYzQkVNWjlNUzdTSllBVUpVWVIvOVdNcTArK1VhMW1xVm5JbmNuQTcz?=
 =?utf-8?B?VE9RalJCR2NIdnhzdSsxMWs3enIxZU83YVg4OHNrUzl0YjN5TWhvQTRvSXJk?=
 =?utf-8?B?Um9wbXpzOTY1Qk5aRGlFbHBOK0JXS3RJdzJwRHJ3WlhMa1BYeFJ3MkNPZEZl?=
 =?utf-8?B?aTUwVXVQZkgycnZBbm05OWRSU3ZxV2NWaDYwc2FUWjF5S1ZVdGxiNzcyZUxh?=
 =?utf-8?B?c3F1bDlQblBtN054UXE0S3ZLVEhtbUNFWUhHeGFQaTZSb2lsekFkZCtiTGVH?=
 =?utf-8?B?UzFUT0ptK1lqRXVFVzc5YkZ4cXZtRXJjU2wvVmdpV2tZM2lWb3BKRnViQXVQ?=
 =?utf-8?B?dm1mOHpUejZlUUY0SEwrM0pOTjBoWGpIejFWSTdzREN0SUlnWjA0K3RRN3ZO?=
 =?utf-8?B?d244MlVNMmVXQWllSkpPckVjVDBnSUNadnkxdUVpNm02YUxvQkc2cStoQVNa?=
 =?utf-8?B?bG0ySitsa2dYalFnRVRYVU1IeWdxZFc1RHZjL0U4dUhnUVdhMTRaVUVVbFI0?=
 =?utf-8?B?SmJKWXlMbXlWV1JrL3lQSEtpYmpJZDI5ejJuQXJFelNjNjhmZTJrL0pNOWxG?=
 =?utf-8?B?YS9wNDZ0bStLT0RPcnpYTnZ5KzZGSkRUeWpONVdmMzc1dmFuUHQwVTd4ZTl3?=
 =?utf-8?B?Nkw4ZXZYREs5YUl4bTZNdzdCT2VIRitURUpHenRJOTc4TDV6czc4djB5NjFn?=
 =?utf-8?B?d2FVZzdHZW0xWWxtbUh4SjRhbFhTWXhvcW81OEhwYlhNQVlrWHFRQVlCRHh5?=
 =?utf-8?B?MEo1TVJiYVBacG5PRTUyYlpnWHVHU1EwNzF0V3ljelhtbUVHZmdEb0xxVTJq?=
 =?utf-8?B?R3JJN3l2em82dGNlQlN3Z3VMMGsrVUkwajJSdlNvT3BpTWZiV0l0cy9YenNX?=
 =?utf-8?B?aWdiMXBibGtldGIwZFgxNnRzaTZhVUpBMVhKZlVGZFpKNXdhVnBvM29LUENZ?=
 =?utf-8?B?SWh3TGFOcVRCSHBtT0Vwa3dnakV1cldZYmkvT09DNFI5YUplY3ZDMjRBSnBa?=
 =?utf-8?B?cGs3K0JvU1NzQVlMN3lvK2xzZmVEVmZ2VFpXdTRjM241YnJRR0dRNmlmbUZi?=
 =?utf-8?B?ZXdvNXRWR1UwenF2UWVlSmJjQVROaEZJQnFVMUZGL0RScWZ5ZEZsVUlnQnJh?=
 =?utf-8?B?YXI1NFhaKzdUTWI0Rk5zbzk2Mzg3ZEpySFNBMnFDcGkrQmg0Qm5LdG5CV1gr?=
 =?utf-8?B?a0FNVnp4b2owR3dMMnkxZXZGbmxGK3htRFhHeHNJcEF6REJyc0RCOWNWbUsz?=
 =?utf-8?B?eTR3MlhXR2plUTloUk83YWd0OXJjbWxtSHZNWWg3Zmp0eTZ5N1hVOGtDR2xD?=
 =?utf-8?B?eVNjSzVvVm02N04wekpCczB6b0FCNVVWVi9MUzdiemEzajdoZXd4bi9MenNo?=
 =?utf-8?B?WEcwODBPbUlSVjkzODFjeDEzeElyYzNQa3B4MThQYXBvK1NycVVORzEyRFVl?=
 =?utf-8?B?NXNaQzh6ZGdjQVBCaWZrNFlrZlJoeXczWnNOMzF0RXJmdzVvTzVqZ1kwQzZl?=
 =?utf-8?B?K25YamY5SVlvWlF6S2p1a0tQcTVNODlYQnlsaXd4ZnA3WVRwaXR0cE9aWnBZ?=
 =?utf-8?B?LzRqVzU2bGp0TDhhYjJzTTFObkwzaytCakh2eGo5UVVNY09ZZXhpanB5aUZU?=
 =?utf-8?B?UW5VdU55Sk9WdEMzNC80SzdCVk9LUUYzdmlMZCt6RTcyaUlyUUIrR0ZrUitP?=
 =?utf-8?B?amIvK0FkL3VaaHEwcnVBVGg3dnBhYkZMZFBmMnp2cmd5YVZMdm5rcXI5aTVk?=
 =?utf-8?B?aStBUlhTbHA0ZVA5REhMZnkyYTB3Y3Y0UmM5YkxXQmtWaWdpaVMySWl4cTlK?=
 =?utf-8?B?N05ZUllPMk5YYXYvTHNhS3UzQUdIUVZxUTg4NWVmL3pyVEk1N1paM29xVVNL?=
 =?utf-8?B?R0sxNmVTdlpqZjhhRDNpQlJGb3IwOStWTU5VMGMvWkdiVEpxOUtsWFV2Zm5B?=
 =?utf-8?B?eU1BMzJGaFgrQkZKeVM0SzZEWUx5RnJweUwxWlNsbU9MTC9acXg5Z0FYbDda?=
 =?utf-8?B?QWRJNUllampZZXNQVmhKOGh6VU5RN3FpSjg2Vk94eWRiTzVLMUxvdXB4TkRY?=
 =?utf-8?B?cUlhR3F3WWpRUlF1Wmg2YlYrajYvR09qdCt4bk9JUlh4UHFKaUhuZHdlcE9I?=
 =?utf-8?B?OGd1ejB4S3dINll1TDNyVVRjWG9WdTZaMGFTR0ZUSklQMnlTcmRLS1pzaUdU?=
 =?utf-8?B?S01STWdUNHBOWjBwcUtQdU9TemIzOXh3RFpPN3hUa2gvR2lzcWFhelYwTHdQ?=
 =?utf-8?Q?8MnByRk3of4iHuMcJI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed791bb7-1db4-4def-fc34-08df04146096
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 08:22:47.8361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6cpYWhfImEgC4sbq64Oo13rlv7JL/43unXsg8B35wg+aWvaIYuuic+u0CdG9BzI3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7871
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



On 8/27/26 09:51, Matthew Brost wrote:
> From: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> 
> Document maintainers and reviewers of the DRM GPUSVM helpers
> 
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Ghimiray, Himal Prasad <himal.prasad.ghimiray@intel.com>
> Cc: David Airlie <airlied@redhat.com>
> Cc: Simona Vetter <simona.vetter@ffwll.ch>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Dri Development Mailing List <dri-devel@lists.freedesktop.org>
> Cc: Honglei Huang <honghuan@amd.com>
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> Acked-by: Matthew Brost <matthew.brost@intel.com>
> Acked-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>

Acked-by: Christian König <christian.koenig@amd.com>

> 
> ---
> 
> v2:
>  - Add Honglei as reviewer as he is driving AMD efforts on GPUSVM
> ---
>  MAINTAINERS | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3c508bda61d5..dfb0d36f0ae2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8991,6 +8991,21 @@ F:	include/drm/drm_gpuvm.h
>  F:	rust/helpers/drm_gpuvm.c
>  F:	rust/kernel/drm/gpuvm/
>  
> +DRM GPUSVM
> +M:	Matthew Brost <matthew.brost@intel.com>
> +R:	Thomas Hellström <thomas.hellstrom@linux.intel.com>
> +R:	Ghimiray Himal Prasad <himal.prasad.ghimiray@intel.com>
> +R:	Honglei Huang <honghuan@amd.com>
> +L:	dri-devel@lists.freedesktop.org
> +S:	Supported
> +T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
> +F:	drivers/gpu/drm/drm_gpusvm.c
> +F:	drivers/gpu/drm/drm_pagemap.c
> +F:	drivers/gpu/drm/drm_pagemap_util.c
> +F:	include/drm/drm_gpusvm.h
> +F:	include/drm/drm_pagemap.h
> +F:	include/drm/drm_pagemap_util.h
> +
>  DRM LOG
>  M:	Jocelyn Falempe <jfalempe@redhat.com>
>  M:	Javier Martinez Canillas <javierm@redhat.com>

