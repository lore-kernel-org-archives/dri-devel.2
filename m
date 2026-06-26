Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4946ECD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 09:08:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A348310F512;
	Fri, 26 Jun 2026 09:08:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jghLy4qw";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010069.outbound.protection.outlook.com [52.101.201.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4F6B10F511;
 Fri, 26 Jun 2026 09:08:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wg1Flu800i8Es/uY+87mcBn6fKUU6T1UhIp4rVbLGEVlXLZn9VyWCY31A+AaUDgP3UpGhsNt9CsEFl/U3KaugNx5UgCu1mxov+0y+3acYnFMNVH9xmDrnOwchf3xFwJT+u+8OKR5DKIhmWWDUmv1mGpaAmx65a87R+tr7fSxaqv27d8GhJpzJR3ZMCi/DA2/IN+i+CZDaFlZznTY853qFhI6UTuAypGkSl1PtNljPXfF8SzNNlMKhvBumyVS1zPdomACrpOGqUKxaGpLKjQczUThOkK/ppapk8IYq/X/+1cpNr0P05ogw2qKYWesSOsJUwlkHD63ccO+X9Vni0lmJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YW+bl58XM/L9XARJ2TNyses93zgV2iTGNEUFTO/XJEM=;
 b=q7MwCQla2EfuIUguy6ettyLFYYit2+wslIytG/CM/QB24WBl4Ih2vpNhOerBGF9ttW/GK6QMJ4B7YJREjGmOyyJycx3RAVB3nk6QzvkvPo0CW+6nVpZej2y6AI1seDsg8qg/sU5f0Xv46GsQeXmXE4KmimTy8d5l7Uzp6poJw2dyxp6rJUR0tt3/UxvzHSUJ3PLPPe+HVrPjIbsx9N6LEluZ0qzaO9XZIFQ5zRlzQ65MQMlUDGEd9dlvJt3TFLK9NiqhS1FGKIMd4rUvA0qqxgkfBIeILfuFddgDD7zsBYdP1bSB9Y4NJQGPpxnOi0xd5OScu8nuMXjDAK2oUpVCow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YW+bl58XM/L9XARJ2TNyses93zgV2iTGNEUFTO/XJEM=;
 b=jghLy4qwLcUNFkq2ZiP0ZgICnYbCex1ldMuMQBzXXPk88j0Qm1i3lS/6TGVbzw6rXYSggWijGL4jp2WnVz31lzMiw0lvtUA7SF+wm+6xlIPu12+dc7taW3bPoEUhqBEERSgqlU97zWpmq9PC8zpR6eNiixsfqzDoX4c46CigfqQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by DS0PR12MB9446.namprd12.prod.outlook.com (2603:10b6:8:192::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Fri, 26 Jun
 2026 09:08:45 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 09:08:43 +0000
Message-ID: <0d34250f-9af8-433c-ba4d-c841b7920c84@amd.com>
Date: Fri, 26 Jun 2026 17:08:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] drm/gpusvm: split MM state flags out of
 drm_gpusvm_pages_flags
To: Matthew Brost <matthew.brost@intel.com>
Cc: sima@ffwll.ch, rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com,
 dakr@kernel.org, aliceryhl@google.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Christian.Koenig@amd.com, Oak.Zeng@amd.com,
 Jenny-Jing.Liu@amd.com, Philip.Yang@amd.com, Xiaogang.Chen@amd.com,
 Ray.Huang@amd.com, Lingshan.Zhu@amd.com, Junhua.Shen@amd.com,
 Yiru.Ma@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Honglei Huang <honglei1.huang@amd.com>
References: <20260618080902.1527255-1-honglei1.huang@amd.com>
 <20260618080902.1527255-2-honglei1.huang@amd.com>
 <aj40xcAiXlj6/z6S@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <aj40xcAiXlj6/z6S@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0047.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::16) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|DS0PR12MB9446:EE_
X-MS-Office365-Filtering-Correlation-Id: 33b7e2c4-9148-428b-8e07-08ded362857b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|6133799003|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: FNFlEdoxaG8W+eH37RQpCotHRQL85fcMujl9uiXAqCJJX/AIuY3CUv4sUF5+nSmf3LgWnucYQx9FJ30izaz6co/r253LIqBEek9MgIrYidalN1ubRXCIguRDNjoojfzIqL8wyWrdQPZHmkTDmYOK9c4TBR5OVCCSiDiXLrLLdqeQw2lWu98kkd+pbTcY/sLZVP/0Ydrd4lANaU7mwQoq5kNjOD519kfpnox+zYy8dvTcOtGngEXOtHUadmFrj8FILtPnQNfBC1+hk7TF0P5K0WGh0KmfZITVZP2E3HyNk1KZW9cOyKy+b6xNpI7yO+oKk6Vrs7IlXKCTYo55V1aRlX1Ck0GCL5sMxFEoK4SqAEbIKjmjaZllayGQj/IZhPhrJnP8ROau+1EmGZDNVJtBUn6FC1cHJXVQI5auJ5du25A+C+H2NlIMgOQ6e90wd35iFxuyqytwtRtGTklth+Tb5r1jLFykxqvPd7V9wMJ8Kdyl5GUqufldjn5WROX94K5EtmO5pEN+Xl/7fUp/xbzmtOd0srSVzbyz0t9g05c75MZNAGRct942EeUxRoEz8go5Qbaod7hTPn9ejGZMyFrzI5aznVWfFxViDFySBC8JfGUNSR+xK91r2H0bQVT/6sP4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUlsMFY0aDVZYUNpdGdFdmdnbFBLK1FuODFLUUZqNlprS2s2Skg3aTdoVC82?=
 =?utf-8?B?SEd4NWVFbHJjbVRtK0JMZ3RrMHVYdG1CSVpnQzRPZ016WGxaYXdjTTVCWEZp?=
 =?utf-8?B?VDRBQ3hhakhMTmI0Und2LzFMYUdBSUwyNmNkV2FvQ0F4NFBaOHZKMENMZ2dY?=
 =?utf-8?B?SXBLMWsvK0tsYU9UOU53Tk1zNFcxc3NaK2lBTFZNWk1ReEtpcHJJczhyN3p0?=
 =?utf-8?B?M09pS1QzdmRIeFZPcHIweDMyeFlEcTFUNFpYYitPekl3Q053M1U3TngxRE5z?=
 =?utf-8?B?S0trTDVsYi9lTFhKb2dyb1lPRHlxOE43QWFUVnBsZTQyeTl3YW1NcGxOQUFo?=
 =?utf-8?B?ODkxOHNMYkZ0ay93SHJDZFhmblpVVU5HRVNDYk4zbUVJNlFZZlhXeGVPbmt3?=
 =?utf-8?B?anFwdXdDUk5NZTMzODZJZE1Fb1JwUUVpM2ZEdVFHT2NROHRvcVc4Z1RFbHk1?=
 =?utf-8?B?TndzSFJ4czZDUHN0VFQrN1FkeS9JUy9Gc0xPdlo0SCtlZWdCWkF6WGxNWmZJ?=
 =?utf-8?B?QkNJVDdKN09maktsVytneGZSL1lhUTdXdDZoczdZYll6bmJWMFZoZzVydmpI?=
 =?utf-8?B?ZENVWnZGNWgzcVZtSVM4UW1tc0JJdjllcVFpZTcxQWQ5SXBpTjRSNGhOOUJi?=
 =?utf-8?B?eUNBMU5IZmpUYmljbWhQc3h2dWhNZDR4NXU3UEE2S3VOTXVhekZGNWJ4ZFli?=
 =?utf-8?B?cVE4OXdVNFlTczY5ZUpMbG9Beko0TDNRSk5tM2FxM1o0OS9kN203NFJ2NHVm?=
 =?utf-8?B?aUdjd1NJaUFYRnFKUk1yd1ZtWlppRXBmbHJkS051NHRxRVd5WGpnL3pyRGdM?=
 =?utf-8?B?cjV1ZTNwazZ4MzZ5RE43SG5wZjdsd0xkNVN5anZtMHd6N2QwM1BKN3dTMSsy?=
 =?utf-8?B?VkgzQWsyVlVKcC9BQkkxL1U5TTlxVDRYem5hN3IvZWlYSVdhekE3dHBNSVpJ?=
 =?utf-8?B?Y01JMERCZzg3eWtrRGVaTjBjWllnbk1YQUx5ekowNldRVmV4VmcvS0o5LzI2?=
 =?utf-8?B?OWE3TGU5T0Z2NFVGRlYwd2p1MlQvUnZ2UC8vK2NFdGZwVDJtT3JKengwaEtP?=
 =?utf-8?B?VzV2M0dMRktoZFE4QmJ1YnprVXdkNmkxMks0dGowOFNLL3l6MklFN0lkZVFZ?=
 =?utf-8?B?MEVZaXFHU1Y1OXFtYnFybmNaVlBzK0dKSDVZUjFvM2NWSTRpSEtIWFYvelNV?=
 =?utf-8?B?WEk1ZHpiaVV1N1hHSnBLL1VyWHIvS0Yza2F1SGxUQ3Erb2JURXhHZmtNaEJx?=
 =?utf-8?B?VUVZcGk2U1hhV1VuamdwSCtFQU5kR3cxa2lhdmlYRmY0RG9lcWdoQmg5SlZQ?=
 =?utf-8?B?clVMNFRodEpZOTc1OTI4S0JtSTNuTGc1Y2g4VzFBTXlpTi9ubzB5Wlk0VGg5?=
 =?utf-8?B?aEVFZ2VXemJid2I4SEdLeFY1Mk5tZHlRM091R3p0UDJZcXpLdkhwNnQwMHor?=
 =?utf-8?B?V2twTlFLMzFhMDQ1VDJidkpBYndvQ0trVUh3dHZsRnFJQm10ZjRxdFVUQk50?=
 =?utf-8?B?RWdpdDZ3bVBKeDlSUTZjTnZWM2ZlQkJtRW9GMFI3TjdtbTJLcGNsUHE4WUYw?=
 =?utf-8?B?aFYvbDZGVGpMNFhKZW1kZXJKQXc0WmFjZ1JPUEJYRzl5TWdUMkg1clN5MlVV?=
 =?utf-8?B?dFRnWlZlZEtxalhDU3hnZ1p0NmkwTDJ4VmJDUkk4WFpVem1hZmNTVTdGNzk2?=
 =?utf-8?B?ZFFTSkErdGdXM2dCQjhuVFhjVkVDNGJvTVFHWlFSdjlWdlJRYjhXN3dOa0dZ?=
 =?utf-8?B?Y2hheU51MlNrbHdEaytLVlBaaGFyOWhrRFMyNytXVm42MCtGQlk5eWVPQW5O?=
 =?utf-8?B?MHRlUmJBcmlWVDN1VGllOFk4eThyODY3TjBraEh0eFMrTitBVy9lN01YRW9l?=
 =?utf-8?B?cnRHdjNyNHg4RkUrM2hhVld3c050WmI5UEJVWFdkRzJCTnQ2d0tMOURad1dX?=
 =?utf-8?B?Wnd3MGRrNG4wb0J3Mkp2azg5bUwvbFA0T0hyNzFJWEFObm1MVjNJczBmRldu?=
 =?utf-8?B?ZHI5c291eDhERmdJL3J3bmVCZCtqTFYzM0pydG0yMHlHMWZCOUlJTTljOUJS?=
 =?utf-8?B?SXNNbGR3REhxaUd1U3JQcHMyZFRPaVJBRjhoaEsxNXBPWWpvcVdQNHJCK3dV?=
 =?utf-8?B?K2RtUjNIcGJRbkxHcmZDcVk1OWYyTEp6UWF3aGtJdm90QVMyZnhFM3FYM2Z0?=
 =?utf-8?B?OGVlQjIxZnc1aFIrVGpjRHlPMEovK3lZajd4UUFGV29xdmpyNDcrRDE2MHh4?=
 =?utf-8?B?Rjc0M0lZSGNNTWF1VHlDaXFSNURFYmdaQjc4SVc2WDcycDVzUnFScDc5STNT?=
 =?utf-8?Q?K+CDOnJNpJtu8Mh9Z1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b7e2c4-9148-428b-8e07-08ded362857b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 09:08:43.5992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: duEMlMObzt2IfmmLyqjsbehvybgjvdIGUDP9svWhz27ohuxaebkIO0U9ZTzHN3jaduZHP2LdkbugHFxCbJo67w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9446
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



On 6/26/2026 4:13 PM, Matthew Brost wrote:
> On Thu, Jun 18, 2026 at 04:08:58PM +0800, Honglei Huang wrote:
>> From: Honglei Huang <honghuan@amd.com>
>>
>> drm_gpusvm_pages_flags currently mixes two status:
>>    - MM / virtual-address state: whether the range has been (partially)
>>      unmapped by the Linux MM, these follow the lifetime of the VMA and
>>      are a single per VA range fact.
>>    - Device mapping state: has_devmem_pages and has_dma_mapping,
>>      which describe the current page mapping status held by device
>>      itself.
>>
>> Keeping both on the pages object blurs the semantics of the
>> abstraction of pages and VA range. So move the MM state flags onto the
>> range, and keep drm_gpusvm_pages_flags strictly for mapping state.
>>
>>    - Introduce drm_gpusvm_range_flags { migrate_devmem, unmapped,
>>      partial_unmap } on drm_gpusvm_range.
>>    - Shrink drm_gpusvm_pages_flags to just has_devmem_pages and
>>      has_dma_mapping.
>>
>> Side effect: drivers now need to check the unmap flags in the driver
>> itself to avoid handling the unmapped pages.
>>
>> Mirror that bit onto drm_gpusvm_pages so the framework can
>> still short circuit drm_gpusvm_get_pages() under the notifier lock, and
>> make drm_gpusvm_range_set_unmapped() propagate it to the backing pages.
>> This follows Matt's review fixup for the v0 series; see the Link below.
>>
>> Suggested-by: Matthew Brost <matthew.brost@intel.com>
> 
> Reviewed-by: Matthew Brost <matthew.brost@intel.com>

Really thanks for the detailed review!

Regards,
Honglei

> 
>> Link: https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commit/623f6a50c037d9e44f6c9fbe6859a0ba7ad50177
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> ---
>>   drivers/gpu/drm/drm_gpusvm.c | 21 ++++++++++++++++++---
>>   drivers/gpu/drm/xe/xe_svm.c  | 11 ++++++-----
>>   include/drm/drm_gpusvm.h     | 30 +++++++++++++++++++++++++-----
>>   3 files changed, 49 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
>> index 958cb605aed..df900553f21 100644
>> --- a/drivers/gpu/drm/drm_gpusvm.c
>> +++ b/drivers/gpu/drm/drm_gpusvm.c
>> @@ -641,7 +641,7 @@ drm_gpusvm_range_alloc(struct drm_gpusvm *gpusvm,
>>   	range->itree.last = ALIGN(fault_addr + 1, chunk_size) - 1;
>>   	INIT_LIST_HEAD(&range->entry);
>>   	range->pages.notifier_seq = LONG_MAX;
>> -	range->pages.flags.migrate_devmem = migrate_devmem ? 1 : 0;
>> +	range->flags.migrate_devmem = migrate_devmem ? 1 : 0;
>>   
>>   	return range;
>>   }
>> @@ -1784,20 +1784,35 @@ EXPORT_SYMBOL_GPL(drm_gpusvm_has_mapping);
>>   /**
>>    * drm_gpusvm_range_set_unmapped() - Mark a GPU SVM range as unmapped
>>    * @range: Pointer to the GPU SVM range structure.
>> + * @pages: Pointer to the GPU SVM pages structure(s).
>> + * @pages_count: Number of GPU SVM pages structure(s) passed in.
>>    * @mmu_range: Pointer to the MMU notifier range structure.
>>    *
>>    * This function marks a GPU SVM range as unmapped and sets the partial_unmap flag
>>    * if the range partially falls within the provided MMU notifier range.
>>    */
>>   void drm_gpusvm_range_set_unmapped(struct drm_gpusvm_range *range,
>> +				   struct drm_gpusvm_pages *pages,
>> +				   unsigned int pages_count,
>>   				   const struct mmu_notifier_range *mmu_range)
>>   {
>> +	unsigned int i;
>> +
>>   	lockdep_assert_held_write(&range->gpusvm->notifier_lock);
>>   
>> -	range->pages.flags.unmapped = true;
>> +	range->flags.unmapped = true;
>> +	for (i = 0; i < pages_count; ++i) {
>> +		struct drm_gpusvm_pages_flags flags = {
>> +			.__flags = pages[i].flags.__flags,
>> +		};
>> +
>> +		flags.unmapped = true;
>> +		/* WRITE_ONCE pairs with READ_ONCE for opportunistic checks */
>> +		WRITE_ONCE(pages[i].flags.__flags, flags.__flags);
>> +	}
>>   	if (drm_gpusvm_range_start(range) < mmu_range->start ||
>>   	    drm_gpusvm_range_end(range) > mmu_range->end)
>> -		range->pages.flags.partial_unmap = true;
>> +		range->flags.partial_unmap = true;
>>   }
>>   EXPORT_SYMBOL_GPL(drm_gpusvm_range_set_unmapped);
>>   
>> diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
>> index e1651e70c8f..63da149f3b7 100644
>> --- a/drivers/gpu/drm/xe/xe_svm.c
>> +++ b/drivers/gpu/drm/xe/xe_svm.c
>> @@ -134,7 +134,8 @@ xe_svm_garbage_collector_add_range(struct xe_vm *vm, struct xe_svm_range *range,
>>   
>>   	range_debug(range, "GARBAGE COLLECTOR ADD");
>>   
>> -	drm_gpusvm_range_set_unmapped(&range->base, mmu_range);
>> +	drm_gpusvm_range_set_unmapped(&range->base, &range->base.pages, 1,
>> +				      mmu_range);
>>   
>>   	spin_lock(&vm->svm.garbage_collector.lock);
>>   	if (list_empty(&range->garbage_collector_link))
>> @@ -166,7 +167,7 @@ xe_svm_range_notifier_event_begin(struct xe_vm *vm, struct drm_gpusvm_range *r,
>>   	range_debug(range, "NOTIFIER");
>>   
>>   	/* Skip if already unmapped or if no binding exist */
>> -	if (range->base.pages.flags.unmapped || !range->tile_present)
>> +	if (range->base.flags.unmapped || !range->tile_present)
>>   		return 0;
>>   
>>   	range_debug(range, "NOTIFIER - EXECUTE");
>> @@ -1136,7 +1137,7 @@ bool xe_svm_range_needs_migrate_to_vram(struct xe_svm_range *range, struct xe_vm
>>   	struct xe_vm *vm = range_to_vm(&range->base);
>>   	u64 range_size = xe_svm_range_size(range);
>>   
>> -	if (!range->base.pages.flags.migrate_devmem || !dpagemap)
>> +	if (!range->base.flags.migrate_devmem || !dpagemap)
>>   		return false;
>>   
>>   	xe_assert(vm->xe, IS_DGFX(vm->xe));
>> @@ -1248,7 +1249,7 @@ static int __xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
>>   
>>   	xe_svm_range_fault_count_stats_incr(gt, range);
>>   
>> -	if (ctx.devmem_only && !range->base.pages.flags.migrate_devmem) {
>> +	if (ctx.devmem_only && !range->base.flags.migrate_devmem) {
>>   		err = -EACCES;
>>   		goto out;
>>   	}
>> @@ -1623,7 +1624,7 @@ int xe_svm_alloc_vram(struct xe_svm_range *range, const struct drm_gpusvm_ctx *c
>>   	int err, retries = 1;
>>   	bool write_locked = false;
>>   
>> -	xe_assert(range_to_vm(&range->base)->xe, range->base.pages.flags.migrate_devmem);
>> +	xe_assert(range_to_vm(&range->base)->xe, range->base.flags.migrate_devmem);
>>   	range_debug(range, "ALLOCATE VRAM");
>>   
>>   	migration_state = drm_gpusvm_scan_mm(&range->base,
>> diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
>> index 8a4d7134a9a..251a7266a73 100644
>> --- a/include/drm/drm_gpusvm.h
>> +++ b/include/drm/drm_gpusvm.h
>> @@ -109,9 +109,7 @@ struct drm_gpusvm_notifier {
>>   /**
>>    * struct drm_gpusvm_pages_flags - Structure representing a GPU SVM pages flags
>>    *
>> - * @migrate_devmem: Flag indicating whether the pages can be migrated to device memory
>>    * @unmapped: Flag indicating if the pages has been unmapped
>> - * @partial_unmap: Flag indicating if the pages has been partially unmapped
>>    * @has_devmem_pages: Flag indicating if the pages has devmem pages
>>    * @has_dma_mapping: Flag indicating if the pages has a DMA mapping
>>    * @__flags: Flags for pages in u16 form (used for READ_ONCE)
>> @@ -119,11 +117,8 @@ struct drm_gpusvm_notifier {
>>   struct drm_gpusvm_pages_flags {
>>   	union {
>>   		struct {
>> -			/* All flags below must be set upon creation */
>> -			u16 migrate_devmem : 1;
>>   			/* All flags below must be set / cleared under notifier lock */
>>   			u16 unmapped : 1;
>> -			u16 partial_unmap : 1;
>>   			u16 has_devmem_pages : 1;
>>   			u16 has_dma_mapping : 1;
>>   		};
>> @@ -151,6 +146,27 @@ struct drm_gpusvm_pages {
>>   	struct drm_gpusvm_pages_flags flags;
>>   };
>>   
>> +/**
>> + * struct drm_gpusvm_range_flags - Range-level GPU SVM flags
>> + *
>> + * @migrate_devmem: Flag indicating whether the range can be migrated to device memory
>> + * @unmapped: Flag indicating if the range has been unmapped
>> + * @partial_unmap: Flag indicating if the range has been partially unmapped
>> + * @__flags: All flags in u16 form (used for READ_ONCE)
>> + */
>> +struct drm_gpusvm_range_flags {
>> +	union {
>> +		struct {
>> +			/* All flags below must be set upon creation */
>> +			u16 migrate_devmem	: 1;
>> +			/* All flags below must be set / cleared under notifier lock */
>> +			u16 unmapped		: 1;
>> +			u16 partial_unmap	: 1;
>> +		};
>> +		u16 __flags;
>> +	};
>> +};
>> +
>>   /**
>>    * struct drm_gpusvm_range - Structure representing a GPU SVM range
>>    *
>> @@ -160,6 +176,7 @@ struct drm_gpusvm_pages {
>>    * @itree: Interval tree node for the range (inserted in GPU SVM notifier)
>>    * @entry: List entry to fast interval tree traversal
>>    * @pages: The pages for this range.
>> + * @flags: Flags for range see &struct drm_gpusvm_range_flags
>>    *
>>    * This structure represents a GPU SVM range used for tracking memory ranges
>>    * mapped in a DRM device.
>> @@ -171,6 +188,7 @@ struct drm_gpusvm_range {
>>   	struct interval_tree_node itree;
>>   	struct list_head entry;
>>   	struct drm_gpusvm_pages pages;
>> +	struct drm_gpusvm_range_flags flags;
>>   };
>>   
>>   /**
>> @@ -310,6 +328,8 @@ drm_gpusvm_range_find(struct drm_gpusvm_notifier *notifier, unsigned long start,
>>   		      unsigned long end);
>>   
>>   void drm_gpusvm_range_set_unmapped(struct drm_gpusvm_range *range,
>> +				   struct drm_gpusvm_pages *pages,
>> +				   unsigned int pages_count,
>>   				   const struct mmu_notifier_range *mmu_range);
>>   
>>   int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>> -- 
>> 2.34.1
>>

