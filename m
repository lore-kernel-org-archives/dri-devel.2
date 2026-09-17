Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599CCC88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 18:20:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC93D10ED7C;
	Thu, 17 Sep 2026 18:20:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zMJh05Hi";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011067.outbound.protection.outlook.com [52.101.57.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C934C10ED7C;
 Thu, 17 Sep 2026 18:20:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gf/N/rjkJfd6V8ME29hI8pnwJXN7WBAzn45j4AG7T/yTms1YhoJCl8U+Sp6aYshkIAypwHsB4zJFHmQK8AK6+VI4YWf4GQtWAA8Xe03zH7Wm7gJuOfDkGjX6+lZP+Ve6g2jkkPoekAkiH2mg6fNpmhb3j5mZTcl5ixq2l2EmJmhyAdXEC8v1A7tqRInuuAnyy31ErwCUwQxux8mHHVDURfWQm5AVDuLr8sLoGFt4LycpSKMj8nbJaYT+fcEtb+u2h0Pu73KM+kVunjjGgu25IxWX/xdAhaXSLTc3eim1ty2eVF95k3wUPAunmR4q073mAtRISpYzmM0K1LmUltbf5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lh6628cIvtobzU6EUELV4MlNE/Ua56T69bX3+ocvbZU=;
 b=xQV2IH9ezqHeXLZ2TbjvwuOzMSPm0DSAB58FjrNU4dWzAqHsw0+BZIPhaPoaBy79+2wuaW5MeYSz6TIN1BfR8/OV5Io5UQpsptRxnP6B0YyoLN9lowt4htZ16hd2+NO660Ik4cSQzXuaS3e+4EQDRzTP5fBlOznBFGRx7khzWt92X/Bms06BG/x8mFfMhkHCASnCGZb+mDOMhARSLY63gnJxgnO69AjU/s+82DCoy2jBS9k02BcaseueeR2KhkJ21OCylXiMjuVIwFF7WszgJDOcU7HM/Tiq4repNVVF/Ig8SpJsHR0yS46IRzkgmXY2K4UYhsKKpkY5XRtqzcnYDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lh6628cIvtobzU6EUELV4MlNE/Ua56T69bX3+ocvbZU=;
 b=zMJh05HiEfdF2QZjWP5qmX/MaRwciL15K4PkPO05XwtdzrYbj3+2RZQrIf5rpocCWOnZBDpYzFvmYTwWORKC1XzSHFWxocyqBaL5o5YaM9+nl+r/pl9IiFKk0ch16vyFWiG03MFRxs+bi1eoSxhhCdi5gVelpXgQHOoKr5GmAaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7966.namprd12.prod.outlook.com (2603:10b6:510:274::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 18:19:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 18:19:54 +0000
Message-ID: <05684d1e-1785-4166-aa26-e11b17c3c9e0@amd.com>
Date: Thu, 17 Sep 2026 20:19:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] drm/gem: Use dynamic allocation for GEM object
 dma_resv
To: Matthew Brost <matthew.brost@intel.com>
Cc: thomas.hellstrom@linux.intel.com, dakr@kernel.org, ecourtney@nvidia.com,
 nat@pixelcluster.dev, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
References: <20260903134408.105317-1-christian.koenig@amd.com>
 <20260903134408.105317-11-christian.koenig@amd.com>
 <aqId4079/mXgWMgh@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <aqId4079/mXgWMgh@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0279.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: 25086986-07c3-4ffe-c6d9-08df14e84588
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|6133799003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: o+Bt39es2et8qX30rGeiwg9TmnOTbSeaBxXqGSsXAH/aZGFYTiaVJVtnfAQkqbmx2FL8yOtlciJV3uVY5ZJhg4frkqLJlmZLK5gMJR+PWHKehnagyI3fZz9KPuNFkI2cFJEzFpbX4WCZFNLVTDsMe+Q+eAHVliTnXzCX0zP5uVeSU1EpzzF1qg3DnLHpdqfMclYH2hqH9/qNUIKMScIDLybS+Oa1imOR1WKusAqb6j4qxNT5m+mdbKHjGb0w2jYHaTho4M5Acix9s4+YdOLlf5yfCZVMwso0vKM9xIJnMSkMkVltJvWw7ymyqaL0wvjXSe7N7a5PAuQWhDE0EXrAkeixc8cHjQEyU6X/jwqlyZP1YHGgD7KTNwJDCcgUoxY9pLft0fRkPdm7LyfOH9fJo635zbdsf2jffN7LDUF8sJkIDcZoc/V5TUTP8h2JypPReo8DxQbv/xyjBqq3iLhcPzzFqVe79VcX78hkjl9dg919PJ666a3FQh3vkU1Ovq+YDB2ErNzO++kkGVbZp9JuOm6OdCf35Jn5q4JoFXKmlcXn+sYMe3ogvNqOku57AdeGYoNzHvQNley1/g2/iaZqCCbJVRXvq6h2rtYJF8ZSm2hz07tb4NTBVqJHviqREuAaU0vSaAOrSds+Ee9c4hKzu3PTXFf7SXG8iTNt+6eDAOA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(6133799003)(4143699003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVB4UGFZN0FvVWhBVXRWWW9OOUFock5nMXgxL1JOSTdwVWNMUnMxbGtEc2hr?=
 =?utf-8?B?TUxVakVhVUpJQWs1RktEbjcyenNsYTZHbC9EdU02V3cvcVJwTzdReldlUVpa?=
 =?utf-8?B?M1pLTzdEbFd4VVRpMzcybStScWlkVzR3QkQwWkUvbzNYZFByTkRhb2dGZ0pR?=
 =?utf-8?B?aHpGYklrYXJDZFBDM0Nad3BpUytaaHFLTmRtQWNiSXZIa3BYREM2RmgzZE9W?=
 =?utf-8?B?QTYzbU1YaDJJY2lieDFEVzZoNE5RRlhJVkZudmgzc0tmSGZHMTRkVFpqWkl2?=
 =?utf-8?B?cVhwL2psMDB0bElJVCtxK2lyWk9FcTQ4QXZzcVdVbi9aVnRCRDhoa3FwVFJK?=
 =?utf-8?B?M0FOQXA3RGh0UEpjUFkrS29lN0NzVUJjZHdZUDkwV2ZhWWFoazNFZ0kwZnlN?=
 =?utf-8?B?ZHNnNFVmZmN6UUlEZHVMOTVacmVxYzllOUxwME16cnRzY2k3OXF3YkF2cDZy?=
 =?utf-8?B?QkNOaHJJMFBWd2REbjZSQlJkSmdWK3UyYkJSOHhyMGVMU2kxWTdCNzhqdnk4?=
 =?utf-8?B?OWl4R2w4N1g5ZUVaSXcySHNkRFl0cDlNQWhPOVJSMVlWSzE5UW9pbWRNM3VC?=
 =?utf-8?B?eUhPVVM4TnhaWCtoVS9Ja3dyWWxuamZlQTZSSmVicGFYUUlIelFzalUvU0wx?=
 =?utf-8?B?R1hxbmxPYkZMNzd5dGpTYStYRlhOTlpOQ1loK1FERTc0N2JDR1RNS2EwaDU0?=
 =?utf-8?B?K0YwMnpqWGlDYXp5aExqN0V5aFJRWERTK1Focnl0TXZDVmNlckh4bFR5NDdw?=
 =?utf-8?B?R3ZzOEZ2L1YveW1XNVhQRGg1bVFCOEc4MnNxVDBLK2RJUVRsV3VtS0dpZXk3?=
 =?utf-8?B?U2xJMjF5UVFFaDF6ZkcrMHlaQ2VORmZ1YTFoZkkycEhlZm53WkRGTUZ1b2FR?=
 =?utf-8?B?ajlHVlhXbHdwMEJ4cTJYWUVJVFh3Uno1WjlDRmM5UkJJMVJvSEpJeUhJUy8y?=
 =?utf-8?B?QWs0RG93cXlqcGdaVldwNVVLalc1Tmdtdk1qL3lrQkJnR2VTNEZiNTVsR2sw?=
 =?utf-8?B?Vm9PdDlTOVZGUFd4MURQSWdpcDV2alhIWXJORFptTEwvYVVzMUhxdmUzb3o1?=
 =?utf-8?B?Q3UvU2YyTFdSb3JlNEFZMnl0cmZIdGlFR3l1b3FYOEJ4UDlmOVQveldvM3hK?=
 =?utf-8?B?UUc4a1U2MTlEcnhFRjVvdjZtQmxLdVVpa3pjd2NaemVzNjlqTkYrazJlNElu?=
 =?utf-8?B?OGpEdktkL3NNRDJEUHJOem5pV2J1b3QzbFZ2cnVvb0RxOXpDWUZNb2tCbFFa?=
 =?utf-8?B?S0ZCS3dXUUFKL09tcXEwTUl6dnkrMi9XWDZ5eDlJQndjUC82Zk1zQ2dWN0p6?=
 =?utf-8?B?YmNMdUo0NmhBUEFXUndXbjJrKzRWcFBMS2hRK1dXOXQ3S0dBdWl6MndibVVQ?=
 =?utf-8?B?U2MvRFdVeE9uUlhoWHNZaUFrVFgvbmVaOW1WNHk3M0pKWGRzYVI1c2hRN0lP?=
 =?utf-8?B?d0RpbHNub1ZuRkNZclNtVWVPWU1xdkFZRSsvN3U4eld2bHozdjgxZmpGMnpv?=
 =?utf-8?B?dmU4K0tWY1JXZDd6M1lOU3Z6ZCs0ZFF5SU5Wa0JWNzd5OVNaYTBoRWRtVk1r?=
 =?utf-8?B?bkFGSEhQcGJXWFQzZXlBeGZNU0ZsVmowcWRQa1JNVlRidUtkTExleXA2eTBC?=
 =?utf-8?B?VjgrWGwxeCtUSWY3S2lnMk4zM29lVm1VbUlpa3lhWHdaeTg1ZXhlLzZJdXF3?=
 =?utf-8?B?NEFEdXQyZ0FrcnVmL0hpZFV4TjJ6eHRBby9lOWtMZ2xmV2dUUEx3SFJ0WXlj?=
 =?utf-8?B?VmpkaS9RL2xzSE5QbDI0WCtwWmFGUWRBYWZ5dlBMSUs0MXlXNmNQdVZLMGw0?=
 =?utf-8?B?OEs0ejFIT3V2dUJSWDMrN1c2WVdsTVlRdFZ1eGFDaS9UalZuK2htQ2NzclAx?=
 =?utf-8?B?OW9VK1lqNkFab09xVzlVZWRTQ2ZWRkJKNVQ5OHhPcHROc1VyT1l4TFdOa1NT?=
 =?utf-8?B?dzdBRGRUeHAzaG1VemNwTHdrVzc4bmpzd0llbUVId1hzM2l5Uy94Z3FDZ0xX?=
 =?utf-8?B?RjNIc3ZZRjdTSGdUSVhuSjR5eG8ralQvOStsRHM4NkM1OVRwdmtvTVIzemlk?=
 =?utf-8?B?M09GekhrS1FUdXFsMzg4K3BHN3V6M09YcVVqcndMK09Jd3k4ZjhvRWNtT29q?=
 =?utf-8?B?dFZDVC96WmlwQmYycW80YWg1UUxrcExTV2xKZVM3eE9LNGlLN1hOWXJRQ1NB?=
 =?utf-8?B?bnd0cEdTTWs3VUJFUksxczVKeHFsVEswenJaNzNXSU4rYTM1eDVLVmVNYk15?=
 =?utf-8?B?WlEzWm5oSVcwRHB2alAveEgzRlVzNWl6Q2FHbllvSW9DRm03TWpYcTJsQnlq?=
 =?utf-8?Q?P8JTOtSjEfdL7+y5sj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25086986-07c3-4ffe-c6d9-08df14e84588
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 18:19:54.3830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vk6AymYA6AUmPtxNbrQfbNZyWKU6Ftads44ysm6bWRj94e5Q/OquzXNICL+dmY0z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7966
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



On 9/10/26 05:02, Matthew Brost wrote:
> On Thu, Sep 03, 2026 at 03:28:05PM +0200, Christian König wrote:
>> Remove the embedded dma_resv (_resv) from struct drm_gem_object and use
>> dynamically allocated reservations instead. This change aligns with the
>> new reference counted dma_resv infrastructure and reduces the size of
>> drm_gem_object.
>>
>> In drm_gem_private_object_init(), when no external resv is provided,
>> allocate a new dma_resv using dma_resv_alloc() instead of initializing
>> the embedded _resv field. This allows proper error handling if the
>> allocation fails, returning -ENOMEM to the caller.
>>
>> The corresponding cleanup in drm_gem_private_object_fini() is simplified
>> to only put the resv pointer, removing the redundant put on _resv.
>>
>> For TTM buffer objects, add an individual_resv field to track the
>> dynamically allocated reservation object for proper cleanup during
>> destruction. This ensures we can distinguish between shared and
>> individual reservations when freeing resources.
>>
>> This change builds on the previous work to make drm_gem_private_object_init()
>> return an error code, now utilizing that capability to handle allocation
>> failures properly.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> Assisted-by: Claude:Sonnet 4
>> ---
>>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  2 +-
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    | 12 ++---
>>  drivers/gpu/drm/drm_gem.c                     |  9 ++--
>>  drivers/gpu/drm/i915/gem/i915_gem_object.c    |  1 -
>>  drivers/gpu/drm/nouveau/nouveau_bo.c          |  3 --
>>  .../gpu/drm/ttm/tests/ttm_bo_validate_test.c  |  2 +-
>>  drivers/gpu/drm/ttm/ttm_bo.c                  | 26 ++++++-----
>>  drivers/gpu/drm/ttm/ttm_bo_util.c             | 44 +++++++++++++------
>>  drivers/gpu/drm/xe/xe_bo.c                    |  8 ++--
>>  include/drm/drm_gem.h                         |  9 ----
>>  include/drm/ttm/ttm_bo.h                      |  2 +
>>  11 files changed, 65 insertions(+), 53 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index 20831dbebc31..a168083edab2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -397,7 +397,7 @@ static int amdgpu_amdkfd_remove_eviction_fence(struct amdgpu_bo *bo,
>>   */
>>  void amdgpu_amdkfd_remove_all_eviction_fences(struct amdgpu_bo *bo)
>>  {
>> -	struct dma_resv *resv = &bo->tbo.base._resv;
>> +	struct dma_resv *resv = bo->tbo.individual_resv;
>>  	struct dma_fence *fence, *stub;
>>  	struct dma_resv_iter cursor;
>>  
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index 6c5182d54f7d..026821f6da7c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -1319,7 +1319,7 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
>>  	 * So when this locking here fails something is wrong with the reference
>>  	 * counting.
>>  	 */
>> -	if (WARN_ON_ONCE(!dma_resv_trylock(&bo->base._resv)))
>> +	if (WARN_ON_ONCE(!dma_resv_trylock(bo->individual_resv)))
>>  		return;
>>  
>>  	amdgpu_amdkfd_remove_all_eviction_fences(abo);
>> @@ -1329,22 +1329,22 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
>>  	    adev->in_suspend || drm_dev_is_unplugged(adev_to_drm(adev)))
>>  		goto out;
>>  
>> -	r = dma_resv_reserve_fences(&bo->base._resv, 1);
>> +	r = dma_resv_reserve_fences(bo->individual_resv, 1);
>>  	if (r)
>>  		goto out;
>>  
>>  	r = amdgpu_ttm_clear_buffer(amdgpu_ttm_next_clear_entity(adev),
>> -				    abo, &bo->base._resv, &fence,
>> -				    false, AMDGPU_KERNEL_JOB_ID_CLEAR_ON_RELEASE);
>> +				    abo, bo->individual_resv, &fence, false,
>> +				    AMDGPU_KERNEL_JOB_ID_CLEAR_ON_RELEASE);
>>  	if (WARN_ON(r))
>>  		goto out;
>>  
>>  	amdgpu_vram_mgr_set_cleared(bo->resource);
>> -	dma_resv_add_fence(&bo->base._resv, fence, DMA_RESV_USAGE_KERNEL);
>> +	dma_resv_add_fence(bo->individual_resv, fence, DMA_RESV_USAGE_KERNEL);
>>  	dma_fence_put(fence);
>>  
>>  out:
>> -	dma_resv_unlock(&bo->base._resv);
>> +	dma_resv_unlock(bo->individual_resv);
>>  }
>>  
>>  /**
>> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
>> index d2ce18bbddea..480391df556d 100644
>> --- a/drivers/gpu/drm/drm_gem.c
>> +++ b/drivers/gpu/drm/drm_gem.c
>> @@ -235,9 +235,11 @@ int drm_gem_private_object_init(struct drm_device *dev,
>>  	obj->handle_count = 0;
>>  	obj->size = size;
>>  	mutex_init(&obj->gpuva.lock);
>> -	dma_resv_init(&obj->_resv);
>> -	if (!obj->resv)
>> -		obj->resv = dma_resv_get(&obj->_resv);
>> +	if (!obj->resv) {
>> +		obj->resv = dma_resv_alloc();
>> +		if (!obj->resv)
>> +			return -ENOMEM;
>> +	}
>>  
>>  	drm_gem_gpuva_init(obj);
>>  
>> @@ -259,7 +261,6 @@ void drm_gem_private_object_fini(struct drm_gem_object *obj)
>>  	WARN_ON(obj->dma_buf);
>>  
>>  	dma_resv_put(obj->resv);
>> -	dma_resv_put(&obj->_resv);
>>  	mutex_destroy(&obj->gpuva.lock);
>>  }
>>  EXPORT_SYMBOL(drm_gem_private_object_fini);
>> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.c b/drivers/gpu/drm/i915/gem/i915_gem_object.c
>> index 3f37b0cbb70f..1c73f15d0315 100644
>> --- a/drivers/gpu/drm/i915/gem/i915_gem_object.c
>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_object.c
>> @@ -90,7 +90,6 @@ struct drm_i915_gem_object *i915_gem_object_alloc(void)
>>  void i915_gem_object_free(struct drm_i915_gem_object *obj)
>>  {
>>  	dma_resv_put(obj->base.resv);
>> -	dma_resv_put(&obj->base._resv);
>>  	return kmem_cache_free(slab_objects, obj);
>>  }
>>  
>> diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
>> index 67c9d32f4f27..65e1f0c2f984 100644
>> --- a/drivers/gpu/drm/nouveau/nouveau_bo.c
>> +++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
>> @@ -159,8 +159,6 @@ nouveau_bo_del_ttm(struct ttm_buffer_object *bo)
>>  			drm_gem_object_put(nvbo->r_obj);
>>  
>>  		drm_gem_object_release(&bo->base);
>> -	} else {
>> -		dma_resv_put(&bo->base._resv);
>>  	}
>>  
>>  	kfree(nvbo);
>> @@ -385,7 +383,6 @@ nouveau_bo_new(struct nouveau_cli *cli, u64 size, int align,
>>  		return PTR_ERR(nvbo);
>>  
>>  	nvbo->bo.base.size = size;
>> -	dma_resv_init(&nvbo->bo.base._resv);
>>  	drm_vma_node_reset(&nvbo->bo.base.vma_node);
>>  
>>  	/* This must be called before ttm_bo_init_reserved(). Subsequent
>> diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
>> index e0ecadccccf8..4559352e7115 100644
>> --- a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
>> +++ b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
>> @@ -640,7 +640,7 @@ static void ttm_bo_validate_no_placement_not_signaled(struct kunit *test)
>>  	KUNIT_EXPECT_EQ(test, ctx.bytes_moved, 0);
>>  
>>  	if (bo->type != ttm_bo_type_sg)
>> -		KUNIT_ASSERT_PTR_EQ(test, bo->base.resv, &bo->base._resv);
>> +		KUNIT_ASSERT_PTR_EQ(test, bo->base.resv, &bo->individual_resv);
>>  
>>  	/* Make sure we have an idle object at this point */
>>  	dma_resv_wait_timeout(bo->base.resv, usage, false, MAX_SCHEDULE_TIMEOUT);
>> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
>> index 999c24251fb7..ecb5f55a0dd1 100644
>> --- a/drivers/gpu/drm/ttm/ttm_bo.c
>> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
>> @@ -193,13 +193,13 @@ static int ttm_bo_individualize_resv(struct ttm_buffer_object *bo)
>>  {
>>  	int r;
>>  
>> -	if (bo->base.resv == &bo->base._resv)
>> +	if (bo->base.resv == bo->individual_resv)
>>  		return 0;
>>  
>> -	BUG_ON(!dma_resv_trylock(&bo->base._resv));
>> +	BUG_ON(!dma_resv_trylock(bo->individual_resv));
>>  
>> -	r = dma_resv_copy_fences(&bo->base._resv, bo->base.resv);
>> -	dma_resv_unlock(&bo->base._resv);
>> +	r = dma_resv_copy_fences(bo->individual_resv, bo->base.resv);
>> +	dma_resv_unlock(bo->individual_resv);
>>  	if (r)
>>  		return r;
>>  
>> @@ -209,7 +209,7 @@ static int ttm_bo_individualize_resv(struct ttm_buffer_object *bo)
>>  		 * the resv object while holding the lru_lock.
>>  		 */
>>  		spin_lock(&bo->bdev->lru_lock);
>> -		drm_gem_object_set_resv(&bo->base, &bo->base._resv);
>> +		drm_gem_object_set_resv(&bo->base, bo->individual_resv);
>>  		spin_unlock(&bo->bdev->lru_lock);
>>  	}
>>  
>> @@ -218,7 +218,7 @@ static int ttm_bo_individualize_resv(struct ttm_buffer_object *bo)
>>  
>>  static void ttm_bo_flush_all_fences(struct ttm_buffer_object *bo)
>>  {
>> -	struct dma_resv *resv = &bo->base._resv;
>> +	struct dma_resv *resv = bo->individual_resv;
>>  	struct dma_resv_iter cursor;
>>  	struct dma_fence *fence;
>>  
>> @@ -238,8 +238,8 @@ static void ttm_bo_delayed_delete(struct work_struct *work)
>>  
>>  	bo = container_of(work, typeof(*bo), delayed_delete);
>>  
>> -	dma_resv_wait_timeout(&bo->base._resv, DMA_RESV_USAGE_BOOKKEEP, false,
>> -			      MAX_SCHEDULE_TIMEOUT);
>> +	dma_resv_wait_timeout(bo->individual_resv, DMA_RESV_USAGE_BOOKKEEP,
>> +			      false, MAX_SCHEDULE_TIMEOUT);
>>  	dma_resv_lock(bo->base.resv, NULL);
>>  	ttm_bo_cleanup_memtype_use(bo);
>>  	dma_resv_unlock(bo->base.resv);
>> @@ -273,7 +273,7 @@ static void ttm_bo_release(struct kref *kref)
>>  		drm_vma_offset_remove(bdev->vma_manager, &bo->base.vma_node);
>>  		ttm_mem_io_free(bdev, bo->resource);
>>  
>> -		if (!dma_resv_test_signaled(&bo->base._resv,
>> +		if (!dma_resv_test_signaled(bo->individual_resv,
>>  					    DMA_RESV_USAGE_BOOKKEEP) ||
>>  		    (want_init_on_free() && (bo->ttm != NULL)) ||
>>  		    bo->type == ttm_bo_type_sg ||
>> @@ -316,6 +316,8 @@ static void ttm_bo_release(struct kref *kref)
>>  	}
>>  
>>  	atomic_dec(&ttm_glob.bo_count);
>> +	dma_resv_put(bo->individual_resv);
>> +	bo->individual_resv = NULL;
> 
> individual_resv is set to NULL.
> 
>>  	bo->destroy(bo);
> 
> vfunc ->destroy() called and this the only call site.
> 
>>  }
>>  
>> @@ -1197,7 +1199,11 @@ int ttm_bo_init_reserved(struct ttm_device *bdev, struct ttm_buffer_object *bo,
>>  	bo->pin_count = 0;
>>  	bo->sg = sg;
>>  	bo->bulk_move = NULL;
>> -	drm_gem_object_set_resv(&bo->base, resv ?: &bo->base._resv);
>> +
>> +	/* Save the original resv object before overwriting it */
>> +	bo->individual_resv = dma_resv_get(bo->base.resv);
>> +	if (resv)
>> +		drm_gem_object_set_resv(&bo->base, resv);
>>  	atomic_inc(&ttm_glob.bo_count);
>>  
>>  	/*
>> diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
>> index e080ce60933e..e39448a5015e 100644
>> --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
>> +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
>> @@ -208,7 +208,7 @@ static void ttm_transfered_destroy(struct ttm_buffer_object *bo)
> 
> This is the vfunc ->destroy() for transfer destroys.
> 
>>  
>>  	fbo = container_of(bo, struct ttm_transfer_obj, base);
>>  	dma_resv_put(fbo->base.base.resv);
>> -	dma_resv_put(&fbo->base.base._resv);
>> +	dma_resv_put(fbo->base.individual_resv);
> 
> fbo->base.individual_resv should always be NULL per above comments.
> 
> Not functionally incorrect as dma_resv_put has a NULL check, but this
> confused me in my analysis of the refcounting.
> 
> Can we either delete this or WARN_ON_ONCE(fbo->base.individual_resv) to
> future proof this?

Good point, I just though better save than sorry here but that is indeed not needed.

Any other comments/reviews on that series? If not I'm going to send it out once more to a wider audience.

Thanks,
Christian.

> 
> Otherwise Xe, TTM, and DRM changes LGTM.
> 
> Matt
> 
>>  	ttm_bo_put(fbo->bo);
>>  	kfree(fbo);
>>  }
>> @@ -238,12 +238,23 @@ static int ttm_buffer_object_transfer(struct ttm_buffer_object *bo,
>>  	if (!fbo)
>>  		return -ENOMEM;
>>  
>> -	fbo->base = *bo;
>>  
>>  	/**
>>  	 * Fix up members that we shouldn't copy directly:
>>  	 * TODO: Explicit member copy would probably be better here.
>>  	 */
>> +	fbo->base = *bo;
>> +
>> +	fbo->base.individual_resv = dma_resv_alloc();
>> +	if (!fbo->base.individual_resv) {
>> +		ret = -ENOMEM;
>> +		goto error_free;
>> +	}
>> +
>> +	if (bo->type != ttm_bo_type_sg)
>> +		fbo->base.base.resv = dma_resv_get(fbo->base.individual_resv);
>> +	else
>> +		dma_resv_get(fbo->base.base.resv);
>>  
>>  	atomic_inc(&ttm_glob.bo_count);
>>  	drm_vma_node_reset(&fbo->base.base.vma_node);
>> @@ -251,19 +262,16 @@ static int ttm_buffer_object_transfer(struct ttm_buffer_object *bo,
>>  	kref_init(&fbo->base.kref);
>>  	fbo->base.destroy = &ttm_transfered_destroy;
>>  	fbo->base.pin_count = 0;
>> -	if (bo->type != ttm_bo_type_sg)
>> -		fbo->base.base.resv = &fbo->base.base._resv;
>>  
>> -	dma_resv_init(&fbo->base.base._resv);
>>  	fbo->base.base.dev = NULL;
>> -	ret = dma_resv_trylock(&fbo->base.base._resv);
>> +	ret = dma_resv_trylock(fbo->base.individual_resv);
>>  	WARN_ON(!ret);
>>  
>> -	ret = dma_resv_reserve_fences(&fbo->base.base._resv, TTM_NUM_MOVE_FENCES);
>> +	ret = dma_resv_reserve_fences(fbo->base.individual_resv,
>> +				      TTM_NUM_MOVE_FENCES);
>>  	if (ret) {
>> -		dma_resv_unlock(&fbo->base.base._resv);
>> -		kfree(fbo);
>> -		return ret;
>> +		dma_resv_unlock(fbo->base.individual_resv);
>> +		goto error_unref;
>>  	}
>>  
>>  	if (fbo->base.resource) {
>> @@ -281,6 +289,14 @@ static int ttm_buffer_object_transfer(struct ttm_buffer_object *bo,
>>  
>>  	*new_obj = &fbo->base;
>>  	return 0;
>> +
>> +error_unref:
>> +	dma_resv_put(fbo->base.individual_resv);
>> +	dma_resv_put(fbo->base.base.resv);
>> +
>> +error_free:
>> +	kfree(fbo);
>> +	return ret;
>>  }
>>  
>>  /**
>> @@ -618,7 +634,7 @@ static int ttm_bo_move_to_ghost(struct ttm_buffer_object *bo,
>>  	if (ret)
>>  		return ret;
>>  
>> -	dma_resv_add_fence(&ghost_obj->base._resv, fence,
>> +	dma_resv_add_fence(ghost_obj->individual_resv, fence,
>>  			   DMA_RESV_USAGE_KERNEL);
>>  
>>  	/**
>> @@ -632,7 +648,7 @@ static int ttm_bo_move_to_ghost(struct ttm_buffer_object *bo,
>>  	else
>>  		bo->ttm = NULL;
>>  
>> -	dma_resv_unlock(&ghost_obj->base._resv);
>> +	dma_resv_unlock(ghost_obj->individual_resv);
>>  	ttm_bo_put(ghost_obj);
>>  	return 0;
>>  }
>> @@ -802,14 +818,14 @@ int ttm_bo_pipeline_gutting(struct ttm_buffer_object *bo)
>>  	if (ret)
>>  		goto error_destroy_tt;
>>  
>> -	ret = dma_resv_copy_fences(&ghost->base._resv, bo->base.resv);
>> +	ret = dma_resv_copy_fences(ghost->individual_resv, bo->base.resv);
>>  	/* Last resort, wait for the BO to be idle when we are OOM */
>>  	if (ret) {
>>  		dma_resv_wait_timeout(bo->base.resv, DMA_RESV_USAGE_BOOKKEEP,
>>  				      false, MAX_SCHEDULE_TIMEOUT);
>>  	}
>>  
>> -	dma_resv_unlock(&ghost->base._resv);
>> +	dma_resv_unlock(ghost->individual_resv);
>>  	ttm_bo_put(ghost);
>>  	bo->ttm = ttm;
>>  	return 0;
>> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
>> index 6df7ef07ec0b..422fe4bddf00 100644
>> --- a/drivers/gpu/drm/xe/xe_bo.c
>> +++ b/drivers/gpu/drm/xe/xe_bo.c
>> @@ -1660,7 +1660,7 @@ static bool xe_ttm_bo_lock_in_destructor(struct ttm_buffer_object *ttm_bo)
>>  	 * always succeed here, as long as we hold the lru lock.
>>  	 */
>>  	spin_lock(&ttm_bo->bdev->lru_lock);
>> -	locked = dma_resv_trylock(&ttm_bo->base._resv);
>> +	locked = dma_resv_trylock(ttm_bo->individual_resv);
>>  	spin_unlock(&ttm_bo->bdev->lru_lock);
>>  	xe_assert(xe, locked);
>>  
>> @@ -1689,14 +1689,14 @@ static void xe_ttm_bo_release_notify(struct ttm_buffer_object *ttm_bo)
>>  	 * TODO: Don't do this for external bos once we scrub them after
>>  	 * unbind.
>>  	 */
>> -	dma_resv_for_each_fence(&cursor, &ttm_bo->base._resv,
>> +	dma_resv_for_each_fence(&cursor, ttm_bo->individual_resv,
>>  				DMA_RESV_USAGE_BOOKKEEP, fence) {
>>  		if (xe_fence_is_xe_preempt(fence) &&
>>  		    !dma_fence_is_signaled(fence)) {
>>  			if (!replacement)
>>  				replacement = dma_fence_get_stub();
>>  
>> -			dma_resv_replace_fences(&ttm_bo->base._resv,
>> +			dma_resv_replace_fences(ttm_bo->individual_resv,
>>  						fence->context,
>>  						replacement,
>>  						DMA_RESV_USAGE_BOOKKEEP);
>> @@ -1704,7 +1704,7 @@ static void xe_ttm_bo_release_notify(struct ttm_buffer_object *ttm_bo)
>>  	}
>>  	dma_fence_put(replacement);
>>  
>> -	dma_resv_unlock(&ttm_bo->base._resv);
>> +	dma_resv_unlock(ttm_bo->individual_resv);
>>  }
>>  
>>  static void xe_ttm_bo_delete_mem_notify(struct ttm_buffer_object *ttm_bo)
>> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
>> index f889232e8525..8aed680bfca2 100644
>> --- a/include/drm/drm_gem.h
>> +++ b/include/drm/drm_gem.h
>> @@ -385,15 +385,6 @@ struct drm_gem_object {
>>  	 */
>>  	struct dma_resv *resv;
>>  
>> -	/**
>> -	 * @_resv:
>> -	 *
>> -	 * A reservation object for this GEM object.
>> -	 *
>> -	 * This is unused for imported GEM objects.
>> -	 */
>> -	struct dma_resv _resv;
>> -
>>  	/**
>>  	 * @gpuva: Fields used by GPUVM to manage mappings pointing to this GEM object.
>>  	 *
>> diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
>> index 32791c4db2a9..f132caa9647f 100644
>> --- a/include/drm/ttm/ttm_bo.h
>> +++ b/include/drm/ttm/ttm_bo.h
>> @@ -77,6 +77,7 @@ enum ttm_bo_type {
>>   * @bdev: Pointer to the buffer object device structure.
>>   * @type: The bo type.
>>   * @page_alignment: Page alignment.
>> + * @individual_resv: Individual resv for destruction
>>   * @destroy: Destruction function. If NULL, kfree is used.
>>   * @kref: Reference count of this buffer object. When this refcount reaches
>>   * zero, the object is destroyed or put on the delayed delete list.
>> @@ -107,6 +108,7 @@ struct ttm_buffer_object {
>>  	struct ttm_device *bdev;
>>  	enum ttm_bo_type type;
>>  	uint32_t page_alignment;
>> +	struct dma_resv *individual_resv;
>>  	void (*destroy) (struct ttm_buffer_object *);
>>  
>>  	/*
>> -- 
>> 2.43.0
>>

