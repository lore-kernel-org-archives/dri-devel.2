Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90AE4C61DFD
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 06:21:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8C2C10E469;
	Wed,  2 Sep 2026 06:21:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NUbAh+hU";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012034.outbound.protection.outlook.com
 [40.107.200.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E79F910E469;
 Wed,  2 Sep 2026 06:21:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w2uVAUXiZoD57c0nylJWodgau/P/VUwjUgFbd43M9cdFAIMKWlbbOHNu2iN8rYdb0htMZvr6cXvtZVROlishZwvBc4QvsF21wVtlTGp5aib5uCDGg/pHUn/YuIUNKISugbWBfC42B/ZOArJ836Nl/6n2CjgFFEBSwF1KKKhv07lcyB1iyVHAEK73LdysMaltufYtVOoxdMs7RfZDTCsaBAYaLR1Vn9u+qMHKqFtpTkrora8nFnbHG6Zfv465xV2pqVEULZnlKa8ZERVg/BAObFx0X30K2YHWT+MO+rfbthCwNUQVFgeCH5tu8amNVjs92wyjhY+kEXpmQfr9MgLivw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+EQtFPB16h6ymwykvlqtfq6zVjRYVKwbcTP00rs+tM=;
 b=nhKOEVgbf4g8Vj17yXCxGe26sdlN9rozKOJzB3Sg6NQZRLcb6oENjWUoGbDECgNWcIVi8kMwMM8nsIN7xM/gMxnLt7mm0akjfoxaOPmeVU3ZUqBZ4Wi1GQNMV8orPR2cUPhDIfToxy6OVln+BNe2Dgi819c+DWYrnjZgKInRogknqSmcrEYOFrUpf+9Ii0IeP8o3Y2joFWyvqoAB27/Qzy1SIksGA/Q8BHGpvLANUUZYUc12mdx6d8EtOGfNNbHPSLAYrK4iCzG/EapM7GTyZA7nwZury5qDEqc7XWnH52cPsxvTI/0lJ2uNlpVobz9tPBOFD97Tru4x6oAlnCxobg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+EQtFPB16h6ymwykvlqtfq6zVjRYVKwbcTP00rs+tM=;
 b=NUbAh+hUL5dD+1/62jyhPIrsaXyYavehjRWbJwxPfvWLhbePEBCo4616m3kmlXhvnVJZ5ymrHPHyZIK6PIfXW35pG3SVAEX+FcpLcb9c+A1quptBPQepe2TFNSH3Hng8ohVpoPWoFYyJsxa8k8dBbKIbg1o93DZqqsz1ycsJ0sU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by IA0PR12MB7532.namprd12.prod.outlook.com (2603:10b6:208:43e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 2 Sep 2026
 06:21:28 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%6]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 06:21:28 +0000
Message-ID: <5101ad21-aa02-40d6-877c-38ae13f3cf3b@amd.com>
Date: Wed, 2 Sep 2026 14:21:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] drm/gpusvm: move dma_addr allocation before the
 notifier lock
To: Matthew Brost <matthew.brost@intel.com>
Cc: sima@ffwll.ch, rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com,
 himal.prasad.ghimiray@intel.com, dakr@kernel.org,
 intel-xe@lists.freedesktop.org, aliceryhl@google.com,
 Alexander.Deucher@amd.com, Felix.Kuehling@amd.com, Christian.Koenig@amd.com,
 Ray.Huang@amd.com, Junhua.Shen@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260901090100.2024933-1-honghuan@amd.com>
 <20260901090100.2024933-2-honghuan@amd.com>
 <apcp/XJpPdG3jzPd@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <apcp/XJpPdG3jzPd@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0025.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::15) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|IA0PR12MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e02f566-d41c-46f9-9539-08df08ba6bd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|23010399003|1800799024|56012099006|10067099003|6133799003|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: ikpqeYUJap/wUlboQ3ElQvDv5I4D4CTyQXx57jg3GnQJPT0autMohn1mOsHMMO5SuvGILoZoeBn7hogYCQOnPF8/VuYzJgY4BDeuOiPWQqJaZi2P/Y7JjPMPJ7BHV4au7Pocw4m8SaB40XV0K+XW23PNLFD3czEUnY/q1a9DL1n47ct/O48iUt9hwj1hZTIs/c1ciwFIO5CX2FBTTj5WpTxGSBYnrktSoZkEadRZxQ5Tu9PLHVvsdPqK3Wiw+RI16vcmXNATOzyqed0Pc7o3cLwbQkjV6/iIdqgA6mjk+xeGg2vCJmSCAyYK+bmCLPok1ZUHIlafu/3/Qkf+LBukBTlVntQEuwI0rRXg5PBT5DOu4prI3cNRCJm2LkR+CKt1xYAiEf/VWA+Xq9DZoJ0CvQ1KPo/wvXBGG8WK7ltr2Hrxk7afbtalFj+vZO6vN6oBO8wSz7I+XyWda+lVz1xOFJYA4vhdvFAADKOMO+iKHUdEJSepDThWYh0x0y2fQ7x2JR2cZQCFSkCSmdHjZFl/G0sgdkJmABy1F+wAt2pL92O1U4BwOwJTR2PlNzIYYYDdBqYoInx9P/mL1QMwff1nA7rHKYagGjd8Asg8iybY9DPZ8brkFjySKoAnj3KUlG+MegN71EJ8QzHKiHW2hyU5Dda5N74/cSQrgUj694QFD80=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(23010399003)(1800799024)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmJ0TUZQNVJUMTRKMTRZSVM2Ym00ZkhnTHFSVVlqdkZUZTN0U1dLYXlNTnEr?=
 =?utf-8?B?ZEN1YW1jZWRSdW5IV0toRHNobTFpRklDYkhrbWYxc01lZzBKVUwyUVErWlpj?=
 =?utf-8?B?dlIwbFRNSENOUUN4Sk53NENFeGJqdDBqaWp6ZjZVY1dub0dhN05OQUtBdmVR?=
 =?utf-8?B?dllQRk1tSDBFRlBBME14SkRKYnBxM0JTSDJhV05rbTRkTkFDT3IrNm1tTWVX?=
 =?utf-8?B?QzZUdDR3MGhjOHFvV3htWjh5Ny9kWmp0NlAzTzF6QnlpUDNndFBDQnIvWS9C?=
 =?utf-8?B?V3dpUnQ0RHFVM2s1ZWl4Wk5TQ1gvZ1gxNmlQNDZBaWppL1VyTjJTdytQQWRH?=
 =?utf-8?B?YTI4YVlyWEl1ejBseXZaYWtkNEhhbzNlV3VPbnVRYmhuVUhNSUpZZmkyM2R5?=
 =?utf-8?B?YUFoMG04Um5BcFBldm8vUEwxeUhzbE02d2lDYVVSS2ViRGw0ZjVUVnhQa29n?=
 =?utf-8?B?TEYyWFJMVkZSVVRFcSszaVdONmgzOUVDb1NYWG56TlJpdEdjbGdXSXRiU1Bs?=
 =?utf-8?B?ZjBSbDJ3SEM1T05sdFNtYUx4Y0VVM1dXdlRWRnNweUhob0RhVHh3elpZSXpO?=
 =?utf-8?B?NHhpUXpjTUQwUXhkeVZXd3FSRCtvb1M1bElPQmpuT2YvNjJ4TExxNFhMUmxM?=
 =?utf-8?B?czEyRVA4bGlKRnV4dWx0UWhEcmdvZURxU1gvTFhiOFVKOTR4YzE3SWdMTTdX?=
 =?utf-8?B?R2I3SDdidzdzWDV5ZGVsOVdZVmtjaGtFYmdQTThsWTdJQXRKa0dtMDZmdlIv?=
 =?utf-8?B?Qk1KOU9xenRDWVFselUxdTVmeWppNGp2SU9Uc2tBQlVVdVBOQ2I1TWRBTmlV?=
 =?utf-8?B?WFhJTmVZVmhVV3NjVnVPTHA3Sm1pdTlTcFV5d2NGR0hkRk03T04wZUt2QnhY?=
 =?utf-8?B?WXBYS2V2ZEhjYmRkblZDRy9yeDNFRGpnN3IzN0UyQllsUGVLY0E3bktBVTdF?=
 =?utf-8?B?ajNhYllqNXdxNnpGM1ovaUpSdmtCME9PRmo5SUpPc1NaMzhqeWZlWDM1R1Fp?=
 =?utf-8?B?M3FKbFNjeW1pUktXbTd4S1liNVRtYkkyeHZ6ZFN2anhZS2poZFoxc2Via2la?=
 =?utf-8?B?RjFTZWVMRnF6ZHc3U1FHbSttRUZCMGllZmEwSkp0VllxMXNrWUQ1THVEWmFk?=
 =?utf-8?B?ajFwVmdKWWIwcWUrWnRtREcvTzR1K204NDdmeEE4Y2w3a1lsczdtMVlsTmUv?=
 =?utf-8?B?V2dCa0VlMlhNcXpEclFMZ2xtRnJ1N29RdkdCUFExa2phRHorclBVaDAzbVNo?=
 =?utf-8?B?VGFoNXpSUkFtcW5zTTA5bDdGUm1xYmp5SWtleDdlazVib3ZHTks0eEh0Mjl5?=
 =?utf-8?B?cGtiUkpGQWc5dGswa0pVckJzRWZ2THpVTG81MnZveUpMRHplY1V3V0JoOHdK?=
 =?utf-8?B?aHZQWG9hRjVZSjh2bGdXSloyTDZCemlNei9XNVN2bjdIeGwybXFLR3BvTVZ3?=
 =?utf-8?B?Ly96TGlYcGJLNndsL1BxRUthUWdnaW0ybVJVb2NoNVlxN0dwTTB0NDZiajVv?=
 =?utf-8?B?SzlxWjc5Wk8yZFZSUmVSQ1RDYnFRcGlaK1Z6cTVsaTVrOUFXaWlzdmNzU2Uv?=
 =?utf-8?B?bUhrNDZwNDk5NThrWWFaMG1sT3M2UGhaK2lTWEhKQk5vVjFoZnNTeS9mc1c1?=
 =?utf-8?B?cGQxQ0RyOTF3cEJpS0pGZmE2bzZuZ0ZKVVNnR2hsZG5qRDlEUjRQOE5ON3pJ?=
 =?utf-8?B?YXl6TXhHU3dVM0RxVklaVXVkTXQ2dmFCSHc0M0lVL2N4SjRDRWRNVDJBN2lE?=
 =?utf-8?B?NU1JOUlndFpZVXI5clk1SDFoMVNrMXg2Rkh6am9qa2dBU21yQlpORXhkWU1i?=
 =?utf-8?B?NjNIMlZjV2VlSis3Q1pveFV0dGUwU1M5bzhKd2JzVkYxYm9xUGlVSHZOdW8w?=
 =?utf-8?B?cnZ3OVZTTFpJUVJBUklMYlNYT3NtVFNMYjA4dHI0cW52eTNDbmxzNlpGZmxp?=
 =?utf-8?B?WjNCTkU1NHhvWEhHdURMY0tybUpuSi82OVZmc0k4MUdoYnR4bWFnWTVRNEli?=
 =?utf-8?B?RWFZd1ZONXZ6TWJTcmFvbGcrU1F6djQwZDRPTVBJc2xYcVFRZGRKT0VQNE1U?=
 =?utf-8?B?M1RUVXF3MTRaWEUrbGlSUVRUdFlqMVJlajBneGV4TmJVOXhrY1hiWm5Md2JG?=
 =?utf-8?B?ZUtqRVB0M3hZN28rS3A1UE01bEhQd2tGRU9pSDJ1d2hMWWhWbVp5ZC84NUFj?=
 =?utf-8?B?cStuandNZlFrRjFIVkhvNExQQjAvdUs3S2ViZ0tsaFpDZXdTNlVoSmhOdmkv?=
 =?utf-8?B?SDZOd2RJNmMrOWk1b1c5WFNwQmZ2QlN0WFE0NzdRVnBaWVh5WGtsOHNEaTFz?=
 =?utf-8?Q?tEsmA6bKePtEEd7f+Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e02f566-d41c-46f9-9539-08df08ba6bd5
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 06:21:27.8919 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0zPQbsVLh9xfRBYtEGmA4LWZR+tTBj6k1LWn7cUasw0TPVOD/K1EUj2Gjn5W0AXp56maa0X2fhfz3PLVr3gyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7532
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



On 9/2/2026 3:39 AM, Matthew Brost wrote:
> On Tue, Sep 01, 2026 at 05:00:57PM +0800, Honglei Huang wrote:
>> The dma_addr allocation was in a lazy allocation flow, it needs unlock
>> and goto map_pages. The allocation only needs npages, so just do it
>> before taking the lock. Drop the map_pages label and the relock flow, so
>> the sequence becomes fault, allocate, then lock, validate, map and
>> unlock. No functional change intended.
>>
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
> 
> One follow up suggestion below - not blocker for merging this series.
> Feel free to implement this or at some point (we) Intel will get around
> to this.

Got it, you can give me RB after you are really satisfied. I can keep 
modifying until you feel there are no problems.

> 
> This patch is:
> Reviewed-by: Matthew Brost <matthew.brost@intel.com>
> 
>> ---
>>   drivers/gpu/drm/drm_gpusvm.c | 22 +++++++++-------------
>>   1 file changed, 9 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
>> index a93eee7ddb9..b507de539e6 100644
>> --- a/drivers/gpu/drm/drm_gpusvm.c
>> +++ b/drivers/gpu/drm/drm_gpusvm.c
>> @@ -1516,10 +1516,18 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>>   	if (err)
>>   		goto err_free;
>>   
>> +	if (!svm_pages->dma_addr) {
>> +		svm_pages->dma_addr =
>> +			kvzalloc_objs(*svm_pages->dma_addr, npages);
> 
> One thing that isn't great about the current code is that, regardless of
> `npages`, the overwhelming majority of cases result in exactly one DMA
> mapping. As a result, we end up wasting a significant amount of memory.
> If an IOVA is allocated, we only ever need a single DMA mapping. Even
> without IOVA support (e.g., `iommu=off` or `iommu=pt`), a 2 MiB backing
> store implemented as a THP would still yield a single DMA mapping via
> `dma_map_page()`.
> 
> Longer term, I'd like to do something like the structure changes below.
> We would still preallocate unless `npages == 1`, but if
> `drm_gpusvm_dma_map_pages()` finds exactly one DMA mapping, we could free
> `dma_addr`, store the `drm_pagemap_addr` in `inline_addr`, and set an
> `inline_dma_mapping` flag. This would save 8 KiB per page of
> `drm_gpusvm_pages` for every 2 MiB THP-backed allocation.

Makes sense, working on it to reduce memory waste.

> 
> Then the final piece is teach drivers to understand 'inline_dma_mapping'
> in their iterators (xe_res_cursor.h in Xe) to correctly walk the
> dma-mapping.

Agreed, the important part is driver maybe miss this change and the 
compiles still fine, maybe worth changing xe_res_first_dma() to take a 
drm_gpusvm_pages instead of a bare pointer.

> 
> Matt
> 
> diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
> index b7d987bf76aa..73b7065610f0 100644
> --- a/include/drm/drm_gpusvm.h
> +++ b/include/drm/drm_gpusvm.h
> @@ -121,6 +121,7 @@ struct drm_gpusvm_pages_flags {
>                          u16 unmapped : 1;
>                          u16 has_devmem_pages : 1;
>                          u16 has_dma_mapping : 1;
> +                       u16 inline_dma_mapping : 1;
>                  };
>                  u16 __flags;
>          };
> @@ -140,7 +141,10 @@ struct drm_gpusvm_pages_flags {
>    */
>   struct drm_gpusvm_pages {
>          struct drm_device *drm;
> -       struct drm_pagemap_addr *dma_addr;
> +       union {
> +               struct drm_pagemap_addr *dma_addr;
> +               struct drm_pagemap_addr inline_addr;
> +       };
>          struct drm_pagemap *dpagemap;
>          struct dma_iova_state state;
>          unsigned long state_offset;

Will modify the code according to your suggestion.

Regards,
Honglei


> 
> 
>> +		if (!svm_pages->dma_addr) {
>> +			err = -ENOMEM;
>> +			goto err_free;
>> +		}
>> +	}
>> +
>>   	*state = (struct dma_iova_state){};
>>   	svm_pages->state_offset = 0;
>>   
>> -map_pages:
>>   	/*
>>   	 * Perform all dma mappings under the notifier lock to not
>>   	 * access freed pages. A notifier will either block on
>> @@ -1540,18 +1548,6 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>>   		goto retry;
>>   	}
>>   
>> -	if (!svm_pages->dma_addr) {
>> -		/* Unlock and restart mapping to allocate memory. */
>> -		drm_gpusvm_notifier_unlock(gpusvm);
>> -		svm_pages->dma_addr =
>> -			kvzalloc_objs(*svm_pages->dma_addr, npages);
>> -		if (!svm_pages->dma_addr) {
>> -			err = -ENOMEM;
>> -			goto err_free;
>> -		}
>> -		goto map_pages;
>> -	}
>> -
>>   	zdd = NULL;
>>   	pagemap = NULL;
>>   	num_dma_mapped = 0;
>> -- 
>> 2.34.1
>>

