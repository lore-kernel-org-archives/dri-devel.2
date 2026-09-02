Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0972C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 06:39:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 407E510F007;
	Wed,  2 Sep 2026 06:39:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H+LqPBCX";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012058.outbound.protection.outlook.com
 [40.93.195.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 303F110F007;
 Wed,  2 Sep 2026 06:39:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFpkfOg01okaKPeea4AGZPBA4/9v7Rol+JU2TOxXv8Lcl7rq8TmfBUr8KS4DB+6sy7BCd7XvBmUMA4jgesOShHk/v5c68ypqnmVRX6rOmddoN61F7zoVG+RywP58LLYTqYmIrBvioTs8YCB5sK8miyLicjQmKgeeEfYKwnkkPdbVJoFxANbXpzJxXMQhKC8CR6cLgMIx/trIJbupNNJdywpCAuwYse7iW1VhenwxQy5e9669OMq8BUp5yFjcDjTZhcoJoInhy6RW4WPfrh7ojl0lQUFRyuysgI3MUk4rk/4b3kZ7eV6rHkgaAMpOlrGeepJiqBZQlaovq0RlXX+5eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZwEaipbRQtiOXgvAQYPYOqvl8Ilufa0O0IYTfCukBY=;
 b=WK4y9NLv+awAwZwyawdsNiepimbRHpQe9DsOK+6zA4IkFYNhRIUelrrf6jIynQpZRN9cTWNuT4oZeh5R0ATJRPcmf/FHR2ObF15X8ea7pvWleHvjn1uAhw0W6Y9u9z05tMKSPii/CdtfUqK3RAWXxmMF17Mx7Se/x9Z7uZbtPS0bU4P2LYuGAGV2Eb2Aj7cl5Z9gxmC12aBWyUYIAsL8ti0M9AsRp/rgerzi4FpAkVD7XgLfKWUvr8WwxUm+FmKDdgkuC4LBECvhW6ClYPljeKFh4giCk0M1aMPfiAEQ7FQuTreuPfMtDSdyMCMCrG/KBurI1EbL+E7l1SLOSkV48w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZwEaipbRQtiOXgvAQYPYOqvl8Ilufa0O0IYTfCukBY=;
 b=H+LqPBCXtbaXK89foow5oGwl6VZAGq56s1NL1P0oMr02i0gLBifvMlB6Q1fVvVxf3s8Wq55b2nLgsGdVm5Ox9OUU+QunJzpRSQrT1r2eg3o2eoEuMpi/3/BoN/yZ+y0ut5MkaFfd/2x0qZM8VlsnuXm9eYiWCz6H9E8CLpy6KeQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by MW4PR12MB5641.namprd12.prod.outlook.com (2603:10b6:303:186::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 06:39:38 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%6]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 06:39:38 +0000
Message-ID: <64571bff-1c62-4d00-b300-9dc0b0532543@amd.com>
Date: Wed, 2 Sep 2026 14:39:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] drm/gpusvm: let drm_gpusvm_get_pages() map an
 array of pages
To: Matthew Brost <matthew.brost@intel.com>
Cc: sima@ffwll.ch, rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com,
 himal.prasad.ghimiray@intel.com, dakr@kernel.org,
 intel-xe@lists.freedesktop.org, aliceryhl@google.com,
 Alexander.Deucher@amd.com, Felix.Kuehling@amd.com, Christian.Koenig@amd.com,
 Ray.Huang@amd.com, Junhua.Shen@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260901090100.2024933-1-honghuan@amd.com>
 <20260901090100.2024933-4-honghuan@amd.com>
 <apcuPwxjBs8HPv3x@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <apcuPwxjBs8HPv3x@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0020.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::7)
 To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|MW4PR12MB5641:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a29ad97-4dfc-4e38-72e2-08df08bcf5eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|6133799003|22082099003|18002099003|56012099006|10067099003|11063799006|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info: BtYytLI2fedZFOZHhBKvb7zCC+Cq3yevdPcI8+HGrbW3cePg/uSdyb0m4iWYKesOID/PwlJiZ16hzAn9jrVD3qKmy0mAmap7loqX5SSDdJWcowcDrc96tefnEd1AMdQVJBUuTfShgEbpOhQoJYrUWZqEe8YfvNTEhqCyaYg6wLyruv+2pWoFlPS21EJ6PQwn37eEPdC8jrXZEVE44j8RSQ/5Rz9VGot1cXbIODrhBLdE2nqUrgRu95J21BnDFme8MN3ET7Xr4h/7jNCQlNPXjYMBGqwfmzcIuSNGYUGUXzWkatRjYmh3tqY4lEGRld93xtlu/VdXulryELURWp2rZZUZ6Onke2ztrHC5km1+zECsK6wxuR2mN3XzIlIMocjenK6yeEcRBtW7uR5MmBCeS2vdJaCloH2AEYiUv5w/rQqrtYZKGcToo+zRbA85MmImGEi4T/11eYAvPKbW/ZuYVEAtuwK/YNS38K2rFx+YMxD91H0D1YYINoYgehkfDFK0wwvIPrHjHSf1uU1r2AZ9WSeK3QSAaG8MczA67GwjGq11sS19iL1ne3dg91gUCHdDi4G1oLh1UC8Pv7fwXFyzrVoukvl/gzjl7mUHmMebSKevwKolRrx9cM6FAxWO/joidBnC7AcQDmFN3Nl+qXiOz7G5N7DjD7s4cTd69fmiHf8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(6133799003)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006)(5023799004)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGM0WmJsejNBKzJOdG51czhIMDZuOHZUa0Z1ZUJ0bDBMWlVRSFpVWGhMRmJT?=
 =?utf-8?B?TUNPMjBzd0ZveHowMnZlbzk2K0tJREdHTWg1TzZLU2tIbG0wOHdTbkN4WTVa?=
 =?utf-8?B?RVB5ZnVYVG8vZk5jUmIwQXAwQzVOWGdMQzhVRE84S3I0eW9nQjU1anpkdktB?=
 =?utf-8?B?bjN3T0xiWmF5YjZNSjMvcnJqUXJmcVFrWHhTSUhBa0N0QXRwUnoyVU5aclI0?=
 =?utf-8?B?ZllUaW1kUGxsSElSMDFJZ2RDVnBJeVBwRzFsZlgrMnBvYWhBc1p3eE8wRkxN?=
 =?utf-8?B?ME9HTWlOanJCSXlSQ05Lb0tsYnZOdGZmalFxUHYzc3BmbU52em9IUzgrT2w0?=
 =?utf-8?B?UjMzcU9VWkdHb05Ya2NrS2RLcGNPNjZpZ1BBQis1Lzk1S3ZHLzFjQTFLMnQ5?=
 =?utf-8?B?VmJ4Ukx5aVB4Z0NuVmMzZDA4aEpBaUlJTW03WVY0YmR2d0RaVG5PNXFER2FC?=
 =?utf-8?B?N0hKOCtQSzVLRkxEeUROTlBvYXhuUlFRMVpwQzUrTkpxMjVmbXRWVUoxa2Nv?=
 =?utf-8?B?Q2ZITVozT3pPZFZDdFJUSHd1dHhzRWRXNjVuQ1J2dDRCZWhnTXYweWxOQ25J?=
 =?utf-8?B?REtsbUZDQUVmSjlJeWlQdDFDdU9nMHhKY1YxNmhqMllHZm53bEY1eDhiZ2JK?=
 =?utf-8?B?czJTczBMZlBiRTBBQ0laays1N2lSZS9mQU56R1p4VytvMXNSODllTzBYTzMy?=
 =?utf-8?B?b1hFL20vT3NOa05rTDIzY3RXNXc0K0J4WHpvVnN3M3Uxc0lRemVBN29VRnRa?=
 =?utf-8?B?cVUzVU1GbGd6TGlITXJwUU16Y2JDZUxWZzArd1p1QVBtcWxQSHRRdmN6cnpV?=
 =?utf-8?B?aW1YYmxaYTVhN1ZNWGJIejFsTjQreTRqdWVMd1FtTnkvS20rMkk4ZUdId1lx?=
 =?utf-8?B?eTY0UzdSdWpRL3IvSFNuM1BVRFNiZ3hMNDQ3eGdiUW00LzhPSjI3UmxRRHZl?=
 =?utf-8?B?SjlKWGxPWjgyUTFXZjNMdFpUTjF4ZElkajl5VzdOa29FNlhwN3hZaWY2K1JC?=
 =?utf-8?B?MlN6ekMyb2wrZWVUVVI0dFVPV1VaSHVRTEV4Y2dzVEk5WlhpVUxiTkZQUGIz?=
 =?utf-8?B?N2tyM3pCNDc4SWxYalBSSlpoRXYrQ05BU0s1WmtUZDJxOW1PZENQY3lDd2Er?=
 =?utf-8?B?bVU2V0NGemhITjYzSmFCck1YeS9zcTVTSExVWDE0MjdrZ0NCYnpFQ1NEb2dI?=
 =?utf-8?B?REFLdTFKUGg1UFJmREVHakxvSmdJZ25TdFBxTkVhbHJRdGRQY0dSN3RWRFdM?=
 =?utf-8?B?ZEUrT2pYOUVDQTRZZlB5YlJ5TzFDMURoRkpoUFJ2RlV5ZisvVW9rcG8zQThy?=
 =?utf-8?B?R1A2ZjBsVEVqOW1FQklRVG1zeXJ2ZVovZEpnYnZkSnk2QTJBTmh5NFV2aG8r?=
 =?utf-8?B?MHF4RTkxdzQrRlNjalhvejJ3cGhlWHV0Zis4YlN5ZUwyTmwvcHNlbkV3TnBh?=
 =?utf-8?B?dXFvQytlQlJjNDdOQkpHRlVWMFJSdTlFT2lSeFl2YXg3dnZwd0p1dTBacDNl?=
 =?utf-8?B?b0xCY1g4K3c1SU55V1NHTTVBNFdoRTQxdEd5NjkzajhLUzNoS1BPVG5ITHBH?=
 =?utf-8?B?QVhOSkJXYnpqNG13NzJObGl1OTVCQjNsYmhLZHB4Y201TWM0cVVySk1BOE5F?=
 =?utf-8?B?aHZ0clBObTFPWEdmMUptVUt6dTEwNGs2dElKZzNNdCtyR0FPaUFyL3VmbVpv?=
 =?utf-8?B?RlBUakY0NHZldDBBUUhOM2RsYW5jcEFuMXdPSmlqZHZvWko5SnZqb1I3SXph?=
 =?utf-8?B?bmxjNGVXS3hXcjNqZ0x1TTNmQ0xGZjVxTmN2QU1hSFd6UjRNLzlxVUhHOXhD?=
 =?utf-8?B?cjJKOEV1SFdmcmhyTi8rdHlVenNJMzZQYTZIVldDUEhrZC9QQjAxeU16aWhY?=
 =?utf-8?B?eE9rNHZyQ1RSbUU0VTN0TXhwOHloMEdtN0J3UnNBdnpzR2R5b1gvUHZnVEdm?=
 =?utf-8?B?TFk2SzYzeWxFWi91Z0dzMXpRM1J5YkEvd2UwZUp2UkhoaERaNlc2SzFTUEtl?=
 =?utf-8?B?ZWtFWkdReWdHNnpWVFRXcHUxd2Zpd1RYQ0dpT1RnN3djMkE5eHFYbllTSWZR?=
 =?utf-8?B?TTdiNktEcG1haUVhaTIySmY0eXNuV3JxTGprR2RGaWVNSmlmWEhGdmZDREpO?=
 =?utf-8?B?blBoTU1WVFdwUkFPRHQ2TGoyd2JoTEIrTDNVNGpsd3NBbmNSZi9FT3lWS0E3?=
 =?utf-8?B?ckNlbXFTWEFQZVlMK1ZlOUxibDNNWXNtb09PTFJSdTl3b3VvNjFTTTJmek12?=
 =?utf-8?B?VWpsSWdXNGRueUhhTU82dmVLWUF5b0h5Rm1PdG85c3JsbDBmM2RNZVM1LzZa?=
 =?utf-8?Q?vl9uRFE1OXfM5lymld?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a29ad97-4dfc-4e38-72e2-08df08bcf5eb
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 06:39:38.4780 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1884VYUEUmd0aXz2g8Lv8G/mH2p99D8515PlnYYZRiyyuwSJu2rMtG4jjtD6ZITo3zJqkceXq45Odd1Ow3c8bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5641
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



On 9/2/2026 3:57 AM, Matthew Brost wrote:
> On Tue, Sep 01, 2026 at 05:00:59PM +0800, Honglei Huang wrote:
>> With the N:1 drm_gpusvm_pages layout, one CPU range mirrored on several
>> drm_devices, the caller had to invoke get_pages() once per device and
>> repeat the HMM fault every time.
>>
>> Make get_pages() take a contiguous array of drm_gpusvm_pages plus a
>> count: fault once, then DMA map each instance by
>> drm_gpusvm_dma_map_pages() under a single read_retry gate. xe range and
>> userptr callers are updated.
>>
>> Document the N:1 array usage in the Overview, showing how get_pages()
>> and drm_gpusvm_range_set_unmapped() take the whole array and its count
>> while the unmap and free paths stay per-instance.
>>
>> Suggested-by: Matthew Brost <matthew.brost@intel.com>
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> ---
>>   drivers/gpu/drm/drm_gpusvm.c    | 141 ++++++++++++++++++++++++--------
>>   drivers/gpu/drm/xe/xe_svm.c     |   2 +-
>>   drivers/gpu/drm/xe/xe_userptr.c |   2 +-
>>   include/drm/drm_gpusvm.h        |   1 +
>>   4 files changed, 108 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
>> index 89c3061d8ef..810f801a9f7 100644
>> --- a/drivers/gpu/drm/drm_gpusvm.c
>> +++ b/drivers/gpu/drm/drm_gpusvm.c
>> @@ -80,6 +80,13 @@
>>    *			};
>>    *		};
>>    *
>> + *		static struct drm_gpusvm_pages *
>> + *		driver_pages(struct driver_range *drange)
>> + *		{
>> + *			return drange->num_pages == 1 ? &drange->inline_pages :
>> + *							drange->pages;
>> + *		}
>> + *
>>    *	In the N:1 case the driver allocates the pages array with a zeroing
>>    *	allocator (e.g. kcalloc(num_pages, ...)), initialises each entry with
>>    *	drm_gpusvm_init_pages(), and frees each entry with
>> @@ -89,6 +96,28 @@
>>    *	Each drm_gpusvm_pages must be zero-initialised and initialised with
>>    *	drm_gpusvm_init_pages(), called once per entry.
>>    *
>> + *	The 1:1 examples below pass @num_pages == 1 and &drange->pages. In the
>> + *	N:1 case the driver instead passes the whole array and its count, so a
>> + *	single call faults the CPU range once and DMA maps it for every owning
>> + *	drm_device, e.g.:
>> + *
>> + *	.. code-block:: c
>> + *
>> + *		// GPU fault handler: one fault, one DMA mapping per device
>> + *		err = drm_gpusvm_get_pages(gpusvm, driver_pages(drange),
>> + *					   drange->num_pages, gpusvm->mm,
>> + *					   &range->notifier->notifier,
>> + *					   drm_gpusvm_range_start(range),
>> + *					   drm_gpusvm_range_end(range), &ctx);
>> + *
>> + *		// Notifier callback: mark every instance unmapped in one call
>> + *		drm_gpusvm_range_set_unmapped(range, driver_pages(drange),
>> + *					      drange->num_pages, mmu_range);
>> + *
>> + *	The unmap and free paths stay per-instance: iterate @num_pages over
>> + *	driver_pages(drange) and call drm_gpusvm_unmap_pages() /
>> + *	drm_gpusvm_free_pages() for each entry.
>> + *
>>    * - Operations:
>>    *	Define the interface for driver-specific GPU SVM operations such as
>>    *	range allocation, notifier allocation, and invalidations.
>> @@ -232,7 +261,7 @@
>>    *				goto retry;
>>    *		}
>>    *
>> - *		err = drm_gpusvm_get_pages(gpusvm, &drange->pages,
>> + *		err = drm_gpusvm_get_pages(gpusvm, &drange->pages, 1,
>>    *					   gpusvm->mm, &range->notifier->notifier,
>>    *					   drm_gpusvm_range_start(range),
>>    *					   drm_gpusvm_range_end(range), &ctx);
>> @@ -1417,25 +1446,34 @@ EXPORT_SYMBOL_GPL(drm_gpusvm_pages_valid);
>>   /**
>>    * drm_gpusvm_pages_valid_unlocked() - GPU SVM pages valid unlocked
>>    * @gpusvm: Pointer to the GPU SVM structure
>> - * @svm_pages: Pointer to the GPU SVM pages structure
>> + * @svm_pages: Array of GPU SVM pages structures
>> + * @num_pages: Number of drm_gpusvm_pages instances in @svm_pages
>>    *
>> - * This function determines if a GPU SVM pages are valid. Expected be called
>> + * This function determines if every GPU SVM pages instance is valid, dropping
>> + * the stale dma_addr array of any instance which is not. Expected be called
>>    * without holding gpusvm->notifier_lock.
>>    *
>> - * Return: True if GPU SVM pages are valid, False otherwise
>> + * Return: True if all GPU SVM pages are valid, False otherwise
>>    */
>>   static bool drm_gpusvm_pages_valid_unlocked(struct drm_gpusvm *gpusvm,
>> -					    struct drm_gpusvm_pages *svm_pages)
>> +					    struct drm_gpusvm_pages *svm_pages,
>> +					    unsigned int num_pages)
>>   {
>> -	bool pages_valid;
>> +	bool pages_valid = true;
>> +	unsigned int p;
>>   
>> -	if (!svm_pages->dma_addr)
>> -		return false;
>> +	for (p = 0; p < num_pages; ++p) {
>> +		if (!svm_pages[p].dma_addr)
>> +			return false;
>> +	}
>>   
>>   	drm_gpusvm_notifier_lock(gpusvm);
>> -	pages_valid = drm_gpusvm_pages_valid(gpusvm, svm_pages);
>> -	if (!pages_valid)
>> -		__drm_gpusvm_free_pages(gpusvm, svm_pages);
>> +	for (p = 0; p < num_pages; ++p) {
>> +		if (drm_gpusvm_pages_valid(gpusvm, &svm_pages[p]))
>> +			continue;
>> +		__drm_gpusvm_free_pages(gpusvm, &svm_pages[p]);
>> +		pages_valid = false;
>> +	}
>>   	drm_gpusvm_notifier_unlock(gpusvm);
>>   
>>   	return pages_valid;
>> @@ -1451,8 +1489,9 @@ static bool drm_gpusvm_pages_valid_unlocked(struct drm_gpusvm *gpusvm,
>>    * @dma_dir: DMA data direction for the mappings
>>    *
>>    * Map the faulted @pfns into @svm_pages for DMA access through its owning
>> - * drm_device. Must be called under the notifier lock. On failure this unwinds
>> - * the partial mapping of this instance before returning.
>> + * drm_device. Must be called under the notifier lock and only for an instance
>> + * without a live mapping. On failure this unwinds the partial mapping of this
>> + * instance before returning.
>>    *
>>    * Return: 0 on success, negative error code on failure.
>>    */
>> @@ -1475,6 +1514,9 @@ static int drm_gpusvm_dma_map_pages(struct drm_gpusvm *gpusvm,
>>   
>>   	lockdep_assert_held(&gpusvm->notifier_lock);
>>   
>> +	*state = (struct dma_iova_state){};
>> +	svm_pages->state_offset = 0;
>> +
>>   	flags.__flags = svm_pages->flags.__flags;
>>   
>>   	for (i = 0, j = 0; i < npages; ++j) {
>> @@ -1603,20 +1645,29 @@ static int drm_gpusvm_dma_map_pages(struct drm_gpusvm *gpusvm,
>>   /**
>>    * drm_gpusvm_get_pages() - Get pages and populate GPU SVM pages struct
>>    * @gpusvm: Pointer to the GPU SVM structure
>> - * @svm_pages: The SVM pages to populate. This will contain the dma-addresses
>> + * @svm_pages: Array of SVM pages instances to populate with dma addresses
>> + * @num_pages: Number of drm_gpusvm_pages instances in @svm_pages
>>    * @mm: The mm corresponding to the CPU range
>>    * @notifier: The corresponding notifier for the given CPU range
>>    * @pages_start: Start CPU address for the pages
>>    * @pages_end: End CPU address for the pages (exclusive)
>>    * @ctx: GPU SVM context
>>    *
>> - * This function gets and maps pages for CPU range and ensures they are
>> - * mapped for DMA access.
>> + * This function gets and maps pages for a CPU range and ensures they are
>> + * mapped for DMA access. The HMM fault for the CPU range is performed once,
>> + * the DMA mapping by drm_gpusvm_dma_map_pages() is then done per instance,
>> + * one per owning drm_device. The retry against notifier races is kept here
>> + * in common code so drivers never open code it.
>> + * The common 1:1 case passes @num_pages == 1.
>> + *
>> + * On error the instances mapped before the failing one stay mapped, so the
>> + * caller must unmap and free every instance regardless of the return value.
>>    *
>>    * Return: 0 on success, negative error code on failure.
>>    */
>>   int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>>   			 struct drm_gpusvm_pages *svm_pages,
>> +			 unsigned int num_pages,
>>   			 struct mm_struct *mm,
>>   			 struct mmu_interval_notifier *notifier,
>>   			 unsigned long pages_start, unsigned long pages_end,
>> @@ -1638,9 +1689,11 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>>   	int err = 0;
>>   	enum dma_data_direction dma_dir = ctx->read_only ? DMA_TO_DEVICE :
>>   							   DMA_BIDIRECTIONAL;
>> +	unsigned int p;
>>   
>> -	if (!svm_pages->drm)
>> -		return -EINVAL;
>> +	for (p = 0; p < num_pages; ++p)
>> +		if (!svm_pages[p].drm)
>> +			return -EINVAL;
>>   
>>   retry:
>>   	remaining = timeout - jiffies;
>> @@ -1649,7 +1702,8 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>>   		return -EBUSY;
>>   
>>   	hmm_range.notifier_seq = mmu_interval_read_begin(notifier);
>> -	if (drm_gpusvm_pages_valid_unlocked(gpusvm, svm_pages))
>> +
>> +	if (drm_gpusvm_pages_valid_unlocked(gpusvm, svm_pages, num_pages))
>>   		goto set_seqno;
>>   
>>   	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
>> @@ -1667,18 +1721,17 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>>   	if (err)
>>   		goto err_free;
>>   
>> -	if (!svm_pages->dma_addr) {
>> -		svm_pages->dma_addr =
>> -			kvzalloc_objs(*svm_pages->dma_addr, npages);
>> -		if (!svm_pages->dma_addr) {
>> +	for (p = 0; p < num_pages; ++p) {
>> +		if (svm_pages[p].dma_addr)
>> +			continue;
>> +		svm_pages[p].dma_addr =
>> +			kvzalloc_objs(*svm_pages[p].dma_addr, npages);
>> +		if (!svm_pages[p].dma_addr) {
>>   			err = -ENOMEM;
>>   			goto err_free;
>>   		}
>>   	}
>>   
>> -	svm_pages->state = (struct dma_iova_state){};
>> -	svm_pages->state_offset = 0;
>> -
>>   	/*
>>   	 * Perform all dma mappings under the notifier lock to not
>>   	 * access freed pages. A notifier will either block on
>> @@ -1686,10 +1739,12 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>>   	 */
>>   	drm_gpusvm_notifier_lock(gpusvm);
>>   
>> -	if (svm_pages->flags.unmapped) {
>> -		drm_gpusvm_notifier_unlock(gpusvm);
>> -		err = -EFAULT;
>> -		goto err_free;
>> +	for (p = 0; p < num_pages; ++p) {
>> +		if (svm_pages[p].flags.unmapped) {
>> +			drm_gpusvm_notifier_unlock(gpusvm);
>> +			err = -EFAULT;
>> +			goto err_free;
>> +		}
> 
> I believe, given how the notifiers work, that checking
> `svm_pages[0].flags.unmapped` is actually sufficient. It's a
> micro-optimization, so I'm fine with it either way.

Agreed, will change to `svm_pages[0].flags.unmapped` .

>   
>>   	}
>>   
>>   	if (mmu_interval_read_retry(notifier, hmm_range.notifier_seq)) {
>> @@ -1698,15 +1753,29 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>>   		goto retry;
>>   	}
>>   
>> -	err = drm_gpusvm_dma_map_pages(gpusvm, svm_pages, pfns, npages, ctx,
>> -				       dma_dir);
>> -	drm_gpusvm_notifier_unlock(gpusvm);
>> -	if (err)
>> -		goto err_free;
>> +	for (p = 0; p < num_pages; ++p) {
>> +		if (drm_gpusvm_pages_valid(gpusvm, &svm_pages[p]))
>> +			continue;
>>   
>> +		err = drm_gpusvm_dma_map_pages(gpusvm, &svm_pages[p], pfns,
>> +					       npages, ctx, dma_dir);
> 
> One thing that is different here is that if `drm_gpusvm_dma_map_pages()`
> fails, say at `p == 1`, then `p[0]` will already contain valid DMA
> mappings. I think this is actually fine, though, because the existing
> cleanup paths will eventually release those mappings one way or another.
>   
> That said, it's probably worth confirming this through a code-path audit
> and adding a comment here explaining why this is safe.
>   
> Again, Sashiko didn't run on this patch, and it would be good to get a
> run before merging this series.
> 

Actually, I hesitated when modifying the code whether to perform a 
rollback here. And I decided to not rollback here, driver can reuse the
previous success mapping when return -EAGAIN, and for other error code,
driver will call drm_gpusvm_unmap_pages then range_free safely.

And actullay I put some comments below, after if (err),
and int drm_gpusvm.c:1663, I put same documents for this situlation.

And I will also resent this series to trigger Sashiko review, and use AI 
to scan this part to ensure it is safe.

Regards,
Honglei

> Matt
> 
>> +		if (err) {
>> +			/*
>> +			 * The failing instance was unwound by the helper. Keep
>> +			 * the ones mapped earlier: the -EAGAIN retry reuses
>> +			 * them, and the driver unmaps every instance with the
>> +			 * range on the other error paths.
>> +			 */
>> +			drm_gpusvm_notifier_unlock(gpusvm);
>> +			goto err_free;
>> +		}
>> +	}
>> +
>> +	drm_gpusvm_notifier_unlock(gpusvm);
>>   	kvfree(pfns);
>>   set_seqno:
>> -	svm_pages->notifier_seq = hmm_range.notifier_seq;
>> +	for (p = 0; p < num_pages; ++p)
>> +		svm_pages[p].notifier_seq = hmm_range.notifier_seq;
>>   
>>   	return 0;
>>   
>> diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
>> index 627a741293d..1c7793d8caa 100644
>> --- a/drivers/gpu/drm/xe/xe_svm.c
>> +++ b/drivers/gpu/drm/xe/xe_svm.c
>> @@ -1598,7 +1598,7 @@ int xe_svm_range_get_pages(struct xe_vm *vm, struct xe_svm_range *range,
>>   
>>   	lockdep_assert_held(&range->lock);
>>   
>> -	err = drm_gpusvm_get_pages(&vm->svm.gpusvm, &range->pages,
>> +	err = drm_gpusvm_get_pages(&vm->svm.gpusvm, &range->pages, 1,
>>   				   vm->svm.gpusvm.mm,
>>   				   &range->base.notifier->notifier,
>>   				   drm_gpusvm_range_start(&range->base),
>> diff --git a/drivers/gpu/drm/xe/xe_userptr.c b/drivers/gpu/drm/xe/xe_userptr.c
>> index 90ac141fc12..9c1dac0fce6 100644
>> --- a/drivers/gpu/drm/xe/xe_userptr.c
>> +++ b/drivers/gpu/drm/xe/xe_userptr.c
>> @@ -91,7 +91,7 @@ int xe_vma_userptr_pin_pages(struct xe_userptr_vma *uvma)
>>   	if (vma->gpuva.flags & XE_VMA_DESTROYED)
>>   		return 0;
>>   
>> -	return drm_gpusvm_get_pages(&vm->svm.gpusvm, &uvma->userptr.pages,
>> +	return drm_gpusvm_get_pages(&vm->svm.gpusvm, &uvma->userptr.pages, 1,
>>   				    uvma->userptr.notifier.mm,
>>   				    &uvma->userptr.notifier,
>>   				    xe_vma_userptr(vma),
>> diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
>> index b7d987bf76a..d2b6f3d2b84 100644
>> --- a/include/drm/drm_gpusvm.h
>> +++ b/include/drm/drm_gpusvm.h
>> @@ -324,6 +324,7 @@ void drm_gpusvm_range_set_unmapped(struct drm_gpusvm_range *range,
>>   
>>   int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>>   			 struct drm_gpusvm_pages *svm_pages,
>> +			 unsigned int num_pages,
>>   			 struct mm_struct *mm,
>>   			 struct mmu_interval_notifier *notifier,
>>   			 unsigned long pages_start, unsigned long pages_end,
>> -- 
>> 2.34.1
>>

