Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBDFC624D3
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 13:27:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A989B10E240;
	Sat,  5 Sep 2026 13:27:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OyF806os";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5106C10E210;
 Sat,  5 Sep 2026 13:27:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e2w+x5EJQ5QkSVjKPngngmrLjp/UQ2TwrPg0UI6iJpc2gk21yGbzQ61tHQ8nmBPkRXfLjhV22jMOXCAa2nlJumXznca8RE/z5pu+MC5MtlRb+e8VOtukonwGLfBqVdsGxDBCYbLEgBOCT3+aI956QyR0R1FqYIaHZ77JaxgaftVKfoS5cuUxOV7g7TXlEulRYE5WNHnPVkz5qnwhXybkHZVLi82e35Qj9djtKpzgyxdISlLQ24DOj683raf9B6DJKHecuVmGrpA39+0o0Z9Z3bn0wWwKNY/d2ACqUWWG+1sZ5Ur8bhQAoEJWP5YAJ/H6bkWF9uXLPvUpzG7iGSTpYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSVRL+c58U8U/s40WzM2bUf/F1rA3T3e8GcMm/uKujk=;
 b=Lv0GDqmY8sYm+U2qcDCE7jBFzkLZW5+rvcDDiWv8YmWCv9wNKP6kP2T0ib1FY3lN2BgBV07ZQFe7doXZTfTuy5va1bVv5+fVl74FMHk3rTCGKCseywqAMS6JOeZ//QZZ/NyrLg6P9ZgaKE3LQRvWThd/XH1WRscjPGUAnkAA7Vmf/AVZDWeOezznYmE4dq1CS8D61BWSqi+My21w6h/2zM7Q9s7QP/qY2n19kG5tZsRj/ey8wvZIsT8+3lq+BuaWGYw5pb1vPXbIsPK/2oJycdJq5LIcRuqLrjaAVDM44+KYXtljl2xOcVE8QC9b4ivWWHTUUpqBf9XDtAVmWruBgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSVRL+c58U8U/s40WzM2bUf/F1rA3T3e8GcMm/uKujk=;
 b=OyF806osNqBOQ/L+JYowZ+XIyA+apWu0iLSZ/fT7LNckddHbYpIM/atJSFysDiVfDJFMHlYjtJNNTIst2ViXMbUCYrImaZDyelRm2rcIMiYEfgsanizoRlYUv3tE+2LKoKzzR5w4OZiR2UwqJ5klEzXmxCLlZAyDpuxL31gqSPw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by DS0PR12MB8563.namprd12.prod.outlook.com (2603:10b6:8:165::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Sat, 5 Sep
 2026 13:27:14 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%6]) with mapi id 15.21.0382.012; Sat, 5 Sep 2026
 13:27:14 +0000
Message-ID: <a29ff993-cd6d-4837-96ec-4554b27c1831@amd.com>
Date: Sat, 5 Sep 2026 21:27:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] drm/gpusvm: keep a single DMA mapping inline for
 THP
To: Matthew Brost <matthew.brost@intel.com>, sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
References: <20260904163956.3433293-1-honghuan@amd.com>
 <20260904163956.3433293-6-honghuan@amd.com>
 <20260904165805.13BF21F00A3D@smtp.kernel.org>
 <apr8Ok1NeYrUCcbC@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <apr8Ok1NeYrUCcbC@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0020.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::10) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|DS0PR12MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: d73c8f36-1c1a-4aaf-7b38-08df0b5165ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|4143699003|10067099003|5023799004|56012099006|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zkG365krsQ0u4ZHp0Xm28fzhZ+DyT4CsI1j7dnlSFfZMaTCdB2K9qMz4TbH+wZPus7heHB2aY06TyG71BfYjpYUTgNOI90j3OxRTAHvm/ZsC3nxNpxSrqNt+nweWOQOQVaoafUxWwr9DgeLQY/UTeyUdHMkyzY7fo9bwM+hvCh7zup28zfwMhaNXp0Rgq4Cp55VV4BYiCblGxqgYwSsfaU8Bmlwroeqe0NER/Rg+Uhi8m7eN5AzqpqCH4Sl35fWOGIgZ1B8CSmJzN+26XzP1NxoQyRo/vBBlxftPevJgm5Fvn8vQe88xNuym16ch+JXfSawuUjrI7lTTBh4ptr/IjwOCzBMcVZ/Dw47XHTfnB7o5i4Lw6bm1sXLvzpezwNB+wH6x+kQS3nKxtUAAlfNVqFmojJjWzC+Slo31VGU4FtU+nxRVN+IhIMtQdPLH2IGM+JKY/DSb6V9iT/Ig5OZ0RvFUrCK2wxBDXScK2Q0GGesNJxbfdC2uSMMRWRUlIZZXep0pQL8nYmc6RVH7hG1HRKMUljQwrl31mTATk+Cqa0QBYMLQQA0K71IM1obVHG/8ttVlmcC82Oa6eovd4rhGAYErg8e2NqaRsehin6Gkj64=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(4143699003)(10067099003)(5023799004)(56012099006)(11063799006)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUR1M1dTb3RHL0QzbTUyZGRodlZVNXZaVGMwK0lhSDlJMWp4ampPSFRJVHhL?=
 =?utf-8?B?aU5RTkFGWTA1Zmd5UW9EUjR6TE5YWUIvZWtnRjNTTG1WVEduM2pIVzhwWVhD?=
 =?utf-8?B?S01rRkZsTTVXNHdtQjgxQytFUGlxV0c5T0tGb2lNSGZIY0JYVk9MK1hHcVZ1?=
 =?utf-8?B?NXZieTdBbUx1NmVOdGs1N2JWWUdMMjJHL1V6Ly9oSE1FenByVjYwV09EcEFR?=
 =?utf-8?B?S1ZxbTNBcTcvUDlPbjJGcXQvU1k1SEdjdFlyQVUzU2t1YWpTbTRRSzBHcTUx?=
 =?utf-8?B?U2RhTWM3dHNUOGVlUnE2NkN3cDBQV3ZvTnNsUFZhZ1JnODdEdE1xM1dLTWp5?=
 =?utf-8?B?U0lWZEZ2SkdEcDR5NHRQZ0s5QmdSZ0Zlc21aWlN1WWxzSyszOWJzTzY2RmFq?=
 =?utf-8?B?dGZkd2pDb3lWQ3MyU1dSc0Q0dGp6ZmwvZE1MdGtJQ2VGZ0d2SDhIRnE0NVc4?=
 =?utf-8?B?K242R3FHUDJacXNIeGRUdDU2eWpKV0did3lVWGc1TXQxclRSY1JyV05uMkc1?=
 =?utf-8?B?Y1NpUVdFT0tEb2VnUmc4UVVyTjUzQVRhWmQzODJEMzdxSzFVMHFYTkVWOHVR?=
 =?utf-8?B?VS9ZT0VFbmQ0Mmxmbkl5Qng5NEtWTmZoRjcrUlM1S1VMYkttR3EyV0R1aVFW?=
 =?utf-8?B?NU96dDRBMlRxdGZLbEoyc0dyZ3Q1cmQ2Z2ZOREtTby9CRGhEUWxhSmNGK2ll?=
 =?utf-8?B?dDhpZ1BSZUtLMjM1cWlZdFNGSmw4ZFpmM3c0T0hmRDF2eDdnWTVsZEFudlZW?=
 =?utf-8?B?aGhQL1U5SktTa0NMbnN6YUtNWHNaUTByeHJHMm4rNldFUFNVSTdwRm80TEFP?=
 =?utf-8?B?cnpMNUZpTVZhS1FkNHpycHlSSkVPTGJuT0tOWk1ERFhDdmYrZG5INU9aa29W?=
 =?utf-8?B?VzBIRHlRR0VNMU5CTkh0L0NudElPMjZrMnpMeCtSTHIxV2JKS0U4dkI2Yzgr?=
 =?utf-8?B?bTJnc21nazVuVXRkOUNtZHFHUm0wUUJDTy9MZUxWcWpaa3ZHMjh1cFRETEUy?=
 =?utf-8?B?L2syRTdsTzdlMEZJbVdpdHFaN25JVFhReUFpRnZldFdqdEM3ci9PU0FCTEVY?=
 =?utf-8?B?MmtIUkxRYVYySVZGU2RsMm16VExsaElBQ09rc203Vis0L2ZDMDFsK2FSeDhR?=
 =?utf-8?B?TjZpR3M0YmUzRi9XRW4zK0xwdkVjRXp6UWRkZjB3dmxYRVlmUEVjNEVsc21C?=
 =?utf-8?B?Q3BFTHZiSExWR28rVU5ieFBNQlNSSS9IY2tyeDVzZDZCZTNZVWl0ZUtacG9Q?=
 =?utf-8?B?UzFVaVpyVklyKzFzNy9kQ0dGMG5uZGoydE5Hck02enpjeXFORitvZE9Pdmhj?=
 =?utf-8?B?bUZxZEZSd1c1bmFFb0tiek1obDNucVBmOXpkNkdwZ2gwY2hsMHcwS3FXNFl0?=
 =?utf-8?B?U0hmSE4zTWtIKzU5UUZ3SXNaQk5GRlEyQ3lodm9TYzg1RWREcDlWVEFYZzdi?=
 =?utf-8?B?YnhsWWFRYkxVR1I5MGtDN3RuWE0zeFB3UjNsN2dQODJvK09kRkxvcFFkRUx3?=
 =?utf-8?B?amNVSVBQZG0zTW8vUFZhUWVKdlBkSVlVZlpna3FuMk5aeDJzT29Sa2pDWE5s?=
 =?utf-8?B?MTBmQzNJRjZaNHBTdmxJSDMwV3dGQ0xSdVJOQlkvZnZCZDVDb3NmT2Q5OGNp?=
 =?utf-8?B?RWpLNWQ5RTVLMGVMYXNnU2xOZ2hqb2JGTVdFK0lsVnR4NlNHTWluRXI3WHBp?=
 =?utf-8?B?Vm5VWTJaVkJiZHEyalltVHMva2VkOGROZDRvbjNtZFF4TCtUc25FNCt0UjJI?=
 =?utf-8?B?UkZjeWpGcEdUNDlxby9leURHMkdEZ1hmbVdPZnQ4ajkwRXlRTUdYYjlSSzUw?=
 =?utf-8?B?MTB3UWt6L096TlJNVkxHZ281U0h3K253MkVZWExBbHRPeU96ZTRXYU9HZUc0?=
 =?utf-8?B?TGZPU2RxUmF2NGEvVFBvRytHaEVFMFhDRXlLTXJ4bjVtYjVpTEdxOTcwVWZu?=
 =?utf-8?B?V2Y5aWhPTitGOUE1d25kVjh0S0hDY0sybzlPUmZERVhINUdydWE4aTE5cU5Z?=
 =?utf-8?B?MzZRQzE0QW50NDAzcVQ5ZEJiMk9aNXd2d3RqSGRrY2ZOZ3NieWFXYW9oTnlt?=
 =?utf-8?B?REFOQUtnZDU5TlBzRGJ0SU9kMEloTnNHZmhlZnltcGREc1FNdWhpM1NRcnBM?=
 =?utf-8?B?bktRL2ZqZXNUa25NcXZsbTVHYi9tV0p0VXFTMUhsOEhPT0VjVFArZVQ5b24x?=
 =?utf-8?B?NWhYcTZpUi9BYisyeE4wczFCS094TDVoemtNc01Ec3VTYW9vOWFzU3VVaitn?=
 =?utf-8?B?Skp6ZEV0UkczZUk4ODlTVEFTTzl4dmNxY1hYVTNqbFdMMmhzcndwaE9aN29s?=
 =?utf-8?B?aDVWRSt6ZlpaRXFITGZMRE9YWmpDWGZxZVFBWjNiYjFlWDJRN2R5Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d73c8f36-1c1a-4aaf-7b38-08df0b5165ea
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 13:27:14.1835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /gm9hZml0bUR9mhBDnq1XBp+0NU6jQ2nVeqImLxXSZ6Eg7vdO2c7z1ANvks0ZIlkQwcnJprKKiP1X9MAOfy92g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8563
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



On 9/5/2026 1:13 AM, Matthew Brost wrote:
> On Fri, Sep 04, 2026 at 04:58:04PM +0000, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [Low] Incompatible pointer type in `xe_pt_stage_bind` when `CONFIG_DRM_XE_GPUSVM` is disabled, leading to a build failure.
>> --
>>
>> commit ba41c31a99e11c5fd960b8101a85807f5290cd76
>> Author: Honglei Huang <honghuan@amd.com>
>>
>> drm/gpusvm: keep a single DMA mapping inline for THP
>>
>> This commit optimizes drm_gpusvm_get_pages() by inlining a single DMA
>> mapping entry for Transparent Huge Pages (THP), reducing memory overhead.
>> It updates the accessors, including xe_pt_stage_bind() paths, to safely
>> handle the new union containing the inline address.
>>
>>> diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
>>> index 5d990c1c3740a..96ea9735f34ce 100644
>>> --- a/drivers/gpu/drm/xe/xe_pt.c
>>> +++ b/drivers/gpu/drm/xe/xe_pt.c
>>> @@ -831,7 +831,7 @@ xe_pt_stage_bind(struct xe_tile *tile, struct xe_vma *vma,
>>>   			return -EAGAIN;
>>>   		}
>>>   		if (xe_svm_range_has_dma_mapping(range)) {
>>> -			xe_res_first_dma(range->pages.dma_addr, 0,
>>> +			xe_res_first_dma(drm_gpusvm_pages_first_dma(&range->pages), 0,
>>
>> [Severity: Low]
>> Will this cause a build failure when compiling the driver with
>> CONFIG_DRM_XE_GPUSVM disabled?
>>
>> When CONFIG_DRM_XE_GPUSVM is disabled, struct xe_svm_range uses an anonymous
>> struct for its pages field instead of struct drm_gpusvm_pages. Since
>> drm_gpusvm_pages_first_dma() expects a const struct drm_gpusvm_pages *,
>> passing &range->pages here appears to result in a compiler type mismatch
>> error.
>>
> 
> Yep. This is related to failure in Intel's CI - kunit builds without
> CONFIG_DRM_XE_GPUSVM [1].
> 
> I believe Xe side we'd some more inline wrapper:
> 
> xe_svm_range_first_dma(struct xe_svm *range)
> 
> Then use ifdef around CONFIG_DRM_XE_GPUSVM to either call
> drm_gpusvm_pages_first_dma or return NULL. xe_svm.h is structured with
> this ifdef in mind.
> 
> If you ask AI how build and run Xe's kunit, it should give you
> instructions and should work without any Intel hardware.


Got it, will fix that issue according to your suggestion,
and also will test Xe's kunit test.

Regards,
Honglei
> 
> Matt
> 
> [1] https://patchwork.freedesktop.org/series/173405/
> 
>>>   					 xe_svm_range_size(range),
>>>   					 &curs);
>>>   			xe_svm_range_debug(range, "BIND PREPARE - MIXED");
>>
>> [ ... ]
>>
>> -- 
>> Sashiko AI review · https://sashiko.dev/#/patchset/20260904163956.3433293-1-honghuan@amd.com?part=5

