Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF69ECD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 09:10:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26D5210E583;
	Wed, 10 Jun 2026 09:10:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VF3x+z2G";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010063.outbound.protection.outlook.com
 [40.93.198.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D40AF10E4BF;
 Wed, 10 Jun 2026 09:10:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ckPcLCd/9BAVY1CpA9vkahWf4S7tbE0JnMH7/iIfIs+oqxQjbobM2k8w0qGw/cM5PlO9ioQvdwEPPdHolxmu/SYmbz9EAYrn00sXp17ovwctypRx4RpMt+vCM5siQsbm/c3umpBgA1UcOd+lbvz1A8hAA9L05cD2JCkcM5ygr4eP+p5rGsb4bFu0/KUMmWmRvjnJ02WfRb1T3SVDXt6Lv6w3r/hhdRSVF1AwyRHnjZo/EWlP5LAHoVcV2fRVExjBKLz5Zth9+58W7ByNH66tk3dgUtFVLnxmDLLZh9E4KouuE90TWOfRaWvmzrxuzNwZeelyreQk/jpyHwaepk98EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4LumbGYgD/bfQ44FqI9OPuRijGM50Rig5NpaQIaLBA=;
 b=olJnA1OqESDDsuGhuxXAZEibxvU3fjnxVB6dpvnxxKEoTFqlcUP/4WAGOie0cYOT2XuWSTDDhlRhdPAfNlI9YLG2KX6f2ptjd17b3myGq5tfUpo5b0HBE0oFSQc7RFe7QdlRJ3Uz1djN818mOoakqpWiYingZ09V3twNAEjAgNCclGYo9PWMiFcTWjbOKE1GL1hqQSqYkrAGN+nasFefz6VLfBnk180m5/gj27zz0226mNbd/aRcx7kxbUCXIFYmDgTnqVuoW/CFHI4/oleSKI9ETP/Ye8P/8iFIrlG7U3zr/c82Ism+vmlrCtqKe+ABcpPVBYx9b4JB9/gWUQrBBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4LumbGYgD/bfQ44FqI9OPuRijGM50Rig5NpaQIaLBA=;
 b=VF3x+z2GjlCqGF2eGaU4O1IJSmJK/iBClPABRUgdGkCoH6pdd+JT/f+V6fBC8cpgja4wz7jfCcktmaCwPABmISSqrX9q3ZeL0GmB7xS2zbR3Fq6LrKlOsSTWZ55CVv7n9UOmSCcZWBdiv3kXI2rw5muCyw84+Uz6YMAhf9AJEuQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by PH7PR12MB8054.namprd12.prod.outlook.com (2603:10b6:510:27f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Wed, 10 Jun
 2026 09:10:43 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 09:10:43 +0000
Message-ID: <371e50a3-cc92-49c4-843a-f76dcc6c9917@amd.com>
Date: Wed, 10 Jun 2026 17:10:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 5/5] drm/gpusvm: let the drm_gpusvm core context purely MM
 level
To: Matthew Brost <matthew.brost@intel.com>
Cc: sima@ffwll.ch, rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com,
 dakr@kernel.org, aliceryhl@google.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Christian.Koenig@amd.com, Oak.Zeng@amd.com,
 Jenny-Jing.Liu@amd.com, Philip.Yang@amd.com, Xiaogang.Chen@amd.com,
 Ray.Huang@amd.com, Lingshan.Zhu@amd.com, Junhua.Shen@amd.com,
 Yiru.Ma@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Honglei Huang <honglei1.huang@amd.com>
References: <20260603065620.2555316-1-honglei1.huang@amd.com>
 <20260603065620.2555316-6-honglei1.huang@amd.com>
 <aijlvyqblELUBAJi@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <aijlvyqblELUBAJi@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0044.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:4::6)
 To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|PH7PR12MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f8498e9-99c4-4a3e-b0d2-08dec6d0264f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|4143699003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: CBRHvNkpExzbRtJFUTDCDIE4nTNjO2I2yLL/R44j0lB4TCagNVuXkChxzW91g9fTDzeOPE0YNqQGQy9hZkzX9c/Vu1puFPoJv7OOd7bFYmg5n1ArgDSpq5LQo+6Vmgqs09aqFrGJWM5rOSSxXwm6MuucXIj2wiVNSSyOF/6dk3Hmsp/VDoqHjfsjq/InwSlFrVGJmCoxiH/p1sgVdRRF953mEgvgaRMA//etVT79wkLe5onbHYaTVoKciEVhvohuC86Uv+WyBKjLl+i4RsqbCKNpgfgz1ss+pV5dqLYSb8Sc3gAjCnuSsgKXbVatQFSEmEQJWIx2X0EqViXGQAocEsoLynvrZJIkFrE9irHwvtUHQXT92auPwTlW2DxJ673TcH6Zee4A7ocn4xcgilvINZZdRjZORofDxsOuVNnuNQHXRSiZELGCSZ1Im37S19FBK+W4I+iTvrYQFhtbMiCX2Eb+o/NxFYkerR2yExDmSyk4HplV6pi0trfSxfoiZ1HkMnc3ebLsHqrOHllPyodviMvxCnECoBO8mTfcGmosvfiVuZhKP3G9APubxU29WD8XVDRzLRHz0++QQ/grgdBAvCEGMTDgA9uWv3p5bBL8yo08wCo8GgRwj/JepLqwdrws9G0xbjZwp3/Xs5gzMm7Y/95FQ8f2LwtqnaHfhtT29Od8ejevJ2fHyOSTcGY8A2Kb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDM5RDkwTEFpT3ZLdHVVVGZEMnlYV3ROLzdLUzNibWlra2djWit1M3ArYmhU?=
 =?utf-8?B?RFM2Wm51aS95c0NST01nblhTWVN4c2NhMUo1cnNuaDZMcHRXMjNHakVRZFE3?=
 =?utf-8?B?dDlURTlKV3kvdGNmbTcraGRSM3llM2pSbWFhZ1ptMDl3Qm9jNHJOMG03SHAv?=
 =?utf-8?B?OEtEMWZNSzN5ckJvdVR4NGkvM1FZZ29nNXhOVkMycm15Q0FaUjVlaDlIcmRC?=
 =?utf-8?B?RElNektyT2hRcGxtNE9DeVF5Mk96aW10R1lGVkcyR3ZtUkJMbDdXS1lsYUJI?=
 =?utf-8?B?MkVkWjdlMzB6OXF6S2p5MHJCUkM0Ym1FaHVkYjl5ZkVGTlp6cXBvWHMvK3ps?=
 =?utf-8?B?Qk4zaXVYb1hJT2RYdHF3QUg3T0xJSUxiaVlpQlJ4N2dTWktNclhsTlVoVTNC?=
 =?utf-8?B?bjNxY1ZBaHVUZUg2K2MxVERNaGdNNVhyYlVTakJCeVRuYjhpd0RNYWFKL3NS?=
 =?utf-8?B?NVVxNHk4V3piRVgyVG9wdUc3UW50OFlCc0xOTHhVWWJleVY3TDcrNEtUWmp6?=
 =?utf-8?B?RXM0eHpBV1dFNWV1U0FNdU9KTnpTOEo1T21oK2tyaWpLSUlIMjQ5VmFHc2Rq?=
 =?utf-8?B?SEFoOERwUllNaUtRTnNvdVpaUkVlZEk2MUdQdFNrTzhXM0lnSFAzSUt0NVF0?=
 =?utf-8?B?bFFHa0preUF4bmJuMkJBTjBlN3AxNUZPOWM4b3BkMUdBQm5HeS9Cc1VTdnAx?=
 =?utf-8?B?ZEU2UDROeWVuNjQyUTAxWWNuMVZXN3BNejFKbnd1OGpOTW5Zb2UxTEtFMmZu?=
 =?utf-8?B?QnRWd003b2tWdVljYXlzd24rUU11Y004NFhTMWszbFgvL1M5NCtsUmlrQjNR?=
 =?utf-8?B?U1RZTHNseEorV1ZHY0lvQzc2VDhscDRra3FKbnkrb2p0WkZhc3JFU0EvLy83?=
 =?utf-8?B?MndqVzhkaUZ0SkxsNkxvUmpJUU56WmRjWE1FL2NRTERjUjdLWG5xSXFsS3lr?=
 =?utf-8?B?M1pHbjNhUlZwRW1Ta3R3R1pabVlPZk9rWU9DQlFZaWptU2RXOFRMaGM4b0hH?=
 =?utf-8?B?dU5Vd2dLZ2w5M0xWYzU4VDZWZFVjRS96N0JmN3pLeGdOSUJFaUNyeWxrcWZN?=
 =?utf-8?B?THhPd1FHSEYvVjVYbkdLdGtrcHhQZVJRWFR0SlIxbUd2L2FzRk1TbDkwU1dk?=
 =?utf-8?B?RkRndm5xVE5WNjZUUGV1RldZR0pwN1B3N2hrSjFZVkpXbUUxMW1PdmUxSEh2?=
 =?utf-8?B?Q0tkL0p5YS8rNVZMVVByNGFKOVRFVFM5NDY5UEllaWhzT0VwMllyZmxKbUZD?=
 =?utf-8?B?SXRSeVlXRitXSDdram1XcSs4WGQ5VGZKazdJSXRybGdBV2Q1R3JKL0tCeFpV?=
 =?utf-8?B?eXJJN1hTaElUYTg2QnpHdlNvSWgxTzNkRDhUcm1lc2p4MkZ3OFJwNER5QlNN?=
 =?utf-8?B?YjBLNkw3QnM2d1poTzdwanZBMWpPbU51andGQUZPemlUd09iTURSYk9TU3M2?=
 =?utf-8?B?bXpqNzhLemFwbjFvbHpieXZrSWNacXU2bDAwNHRBRnVHYUhsbk9qeFM3dXhH?=
 =?utf-8?B?UXMwd1YyejdobGpoOE0zbzVlbXlaRXF4S0h3b1M4cVJMUVh1c1VOaVNZTXl2?=
 =?utf-8?B?Q0dheFM1a1E3c2lsTk5vQmJmM0oxeWJtVzZqNUUrNmRYZnBVZ0l6NFg5enly?=
 =?utf-8?B?Y0RpUGdVQzF6NlRuLzJRT1M0Qk1NOU51YzZJTjdrT2t0cU81d29JY0NteVpD?=
 =?utf-8?B?aXg0NzNVa1ZCVGtnK1hHZC9WTUQyT2Z6WDd3ejRrVzV1M2diaFNKMVdWcDJt?=
 =?utf-8?B?TzBUQzRuamw5RndUc1F6RktmRnNOL1laQmtyUTJpa1NGeVMyamF4YjB3a3pI?=
 =?utf-8?B?MTJTQng5U256Y3kyR0dJRlNKWlBKbmVsZzRpa0tGb0dXS2t5SWMvRjFPVS9m?=
 =?utf-8?B?bDVia1BRZXoxM0JUS1ZCMk1QMjJwdndRZ0RWODg4Y2p0NXZMeXVGb1BYNDk5?=
 =?utf-8?B?ZzQvNVdBMHZhWEdHamdkUFZBd3diTDFDenFodTBmWlQvT1N0RDUwUDdDb3dJ?=
 =?utf-8?B?UytSYm5obGh5N1FWdW5qUXd5TTd0VDdYcjltRGttZUN6cjhFRGwzS0JoV09h?=
 =?utf-8?B?V3FPbEVYRWtqbStVQXIveDdxU2toVUl2MVVtRlgwTGd1N0M3NFM5dUlhU1dT?=
 =?utf-8?B?cnFZYW5YOXRibXRlblZwTkVVQXRBNTN3UnM4Y1BhK1RzWXhBNFJwOWVyNjhK?=
 =?utf-8?B?bUxNT2tieXdZcWZpUHFxQ0Z6ZEQ1elRqRlY4Q1hwWFlINjRaVXNBNk9wYTEr?=
 =?utf-8?B?WDN1ckdrSUhwN3hzUnE3R0F3TTNXeEpYYzEyb2wxMmFGY3VxSzdleHRwdnUy?=
 =?utf-8?Q?UEqhb3r/1HX+ARl4UM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8498e9-99c4-4a3e-b0d2-08dec6d0264f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:10:43.4723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZ7VI3D7dVL5xpSrjZBgdjxY5nRO7lP+/0/1PjpY8C9nVDY1dDxGwysj9BuZXGndA/YNJF3dutafBFxUgxru0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8054
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



On 6/10/2026 12:19 PM, Matthew Brost wrote:
> On Wed, Jun 03, 2026 at 02:56:20PM +0800, Honglei Huang wrote:
>> From: Honglei Huang <honghuan@amd.com>
>>
>> The core mechanism of drm_gpusvm is HMM, which is fundamentally an
>> MM side subsystem. A drm_device, enters the picture on the device side at
>> DMA mapping / GPU bind.
>>
>> So drop struct drm_device from struct drm_gpusvm. Let drm_gpusvm keep
>> its core neutral and leave device side decisions to the driver.
>> Make drm_gpusvm a pure MM level object.
>>
>>    - Drop the drm  from struct drm_gpusvm
>>    - Drop the drm parameter from drm_gpusvm_init()
>>    - Update the xe call sites in xe_svm_init() and other callers.
>>
> 
> I'd mention somewhere that drm_device is now stored in the pages.
> 
> Otherwise LGTM.

Got it, will add text for the drm_device store location.


And thanks a lot for the review and your quick fix for my bugs in this 
series!
will make fixes to the opinions you have provided. And will send the 
patches to the Xe mailing list to trigger the CI test according the link 
in cover letter.

Regards,
Honglei


> 
> Matt
> 
>> Suggested-by: Matthew Brost <matthew.brost@intel.com>
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> ---
>>   drivers/gpu/drm/drm_gpusvm.c | 7 +++----
>>   drivers/gpu/drm/xe/xe_svm.c  | 4 ++--
>>   drivers/gpu/drm/xe/xe_svm.h  | 2 +-
>>   include/drm/drm_gpusvm.h     | 4 +---
>>   4 files changed, 7 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
>> index 55515390c53..5cade46234c 100644
>> --- a/drivers/gpu/drm/drm_gpusvm.c
>> +++ b/drivers/gpu/drm/drm_gpusvm.c
>> @@ -359,7 +359,6 @@ static const struct mmu_interval_notifier_ops drm_gpusvm_notifier_ops = {
>>    * drm_gpusvm_init() - Initialize the GPU SVM.
>>    * @gpusvm: Pointer to the GPU SVM structure.
>>    * @name: Name of the GPU SVM.
>> - * @drm: Pointer to the DRM device structure.
>>    * @mm: Pointer to the mm_struct for the address space.
>>    * @mm_start: Start address of GPU SVM.
>>    * @mm_range: Range of the GPU SVM.
>> @@ -373,7 +372,8 @@ static const struct mmu_interval_notifier_ops drm_gpusvm_notifier_ops = {
>>    * This function initializes the GPU SVM.
>>    *
>>    * Note: If only using the simple drm_gpusvm_pages API (get/unmap/free),
>> - * then only @gpusvm, @name, and @drm are expected. However, the same base
>> + * then only @gpusvm and @name are expected. The struct @drm for dma
>> + * mappings is now required in drm_gpusvm_get_pages(). However, the same base
>>    * @gpusvm can also be used with both modes together in which case the full
>>    * setup is needed, where the core drm_gpusvm_pages API will simply never use
>>    * the other fields.
>> @@ -381,7 +381,7 @@ static const struct mmu_interval_notifier_ops drm_gpusvm_notifier_ops = {
>>    * Return: 0 on success, a negative error code on failure.
>>    */
>>   int drm_gpusvm_init(struct drm_gpusvm *gpusvm,
>> -		    const char *name, struct drm_device *drm,
>> +		    const char *name,
>>   		    struct mm_struct *mm,
>>   		    unsigned long mm_start, unsigned long mm_range,
>>   		    unsigned long notifier_size,
>> @@ -399,7 +399,6 @@ int drm_gpusvm_init(struct drm_gpusvm *gpusvm,
>>   	}
>>   
>>   	gpusvm->name = name;
>> -	gpusvm->drm = drm;
>>   	gpusvm->mm = mm;
>>   	gpusvm->mm_start = mm_start;
>>   	gpusvm->mm_range = mm_range;
>> diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
>> index 33c26df5111..b0b737234ee 100644
>> --- a/drivers/gpu/drm/xe/xe_svm.c
>> +++ b/drivers/gpu/drm/xe/xe_svm.c
>> @@ -905,7 +905,7 @@ int xe_svm_init(struct xe_vm *vm)
>>   			return err;
>>   		}
>>   
>> -		err = drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM", &vm->xe->drm,
>> +		err = drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM",
>>   				      current->mm, 0, vm->size,
>>   				      xe_modparam.svm_notifier_size * SZ_1M,
>>   				      &gpusvm_ops, fault_chunk_sizes,
>> @@ -919,7 +919,7 @@ int xe_svm_init(struct xe_vm *vm)
>>   		}
>>   	} else {
>>   		err = drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM (simple)",
>> -				      &vm->xe->drm, NULL, 0, 0, 0, NULL,
>> +				      NULL, 0, 0, 0, NULL,
>>   				      NULL, 0);
>>   	}
>>   
>> diff --git a/drivers/gpu/drm/xe/xe_svm.h b/drivers/gpu/drm/xe/xe_svm.h
>> index ea73241d3d9..1c5195f5495 100644
>> --- a/drivers/gpu/drm/xe/xe_svm.h
>> +++ b/drivers/gpu/drm/xe/xe_svm.h
>> @@ -238,7 +238,7 @@ static inline
>>   int xe_svm_init(struct xe_vm *vm)
>>   {
>>   #if IS_ENABLED(CONFIG_DRM_GPUSVM)
>> -	return drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM (simple)", &vm->xe->drm,
>> +	return drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM (simple)",
>>   			       NULL, 0, 0, 0, NULL, NULL, 0);
>>   #else
>>   	return 0;
>> diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
>> index 250c59f0930..2bea47ee171 100644
>> --- a/include/drm/drm_gpusvm.h
>> +++ b/include/drm/drm_gpusvm.h
>> @@ -191,7 +191,6 @@ struct drm_gpusvm_range {
>>    * struct drm_gpusvm - GPU SVM structure
>>    *
>>    * @name: Name of the GPU SVM
>> - * @drm: Pointer to the DRM device structure
>>    * @mm: Pointer to the mm_struct for the address space
>>    * @mm_start: Start address of GPU SVM
>>    * @mm_range: Range of the GPU SVM
>> @@ -215,7 +214,6 @@ struct drm_gpusvm_range {
>>    */
>>   struct drm_gpusvm {
>>   	const char *name;
>> -	struct drm_device *drm;
>>   	struct mm_struct *mm;
>>   	unsigned long mm_start;
>>   	unsigned long mm_range;
>> @@ -267,7 +265,7 @@ struct drm_gpusvm_ctx {
>>   };
>>   
>>   int drm_gpusvm_init(struct drm_gpusvm *gpusvm,
>> -		    const char *name, struct drm_device *drm,
>> +		    const char *name,
>>   		    struct mm_struct *mm,
>>   		    unsigned long mm_start, unsigned long mm_range,
>>   		    unsigned long notifier_size,
>> -- 
>> 2.34.1
>>

