Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8942CCD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 09:03:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D84B510E4BA;
	Wed, 10 Jun 2026 09:03:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aPpOaz/D";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011046.outbound.protection.outlook.com [52.101.62.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8876C10E4BA;
 Wed, 10 Jun 2026 09:03:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJMjJUZkCqHaotXktLZmscu/aZZ61GTji3NsQi0uiWUcxcr8IsIchd7DhiYX1vGcJHgQHuIegofEWfmGlqaQ4RaV6nwt75vERZMAX1vrGjij9yf33o/XZ0pgBeuhdxNtLRnF8EEFD0G57J2t03JalySCvIfwR0pOHar58J/BVAgW7gQZM4iXD2g6GbuB9yPeYqbLEbQIK1n0wIV0w2aDSC/kHC/UweNiuxLSc0XnKY4dzTeLXgDkRavbh7JDfuDD2PA/VhyYOyPdNg2rPm24ROSCQ2ci0J6yBpYsaC/3+7RGSbG7F+SI9n5EM7awyU2Kv52GnLhybTVAQCT6c2vPdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9CXXcfVi81Bauv/+KD/yuKdFL7N3SI4iqxDYaryOTw=;
 b=rqeKHdwehGJzVlcDXIYsSYhyWVQDLb2c+wc/8kMJvYDbj1OA/YmbSGqvMGxxAAqZ4n5//KS9MRqY5+MxomzafMWw/WXEjpFD3NCaIUeyEcgh3Vax0wPICKPO6GRHBxhVJ4d1rWj4CQwVUXp/SUZc+GlaHI+/1Uank0IaDBwwqy3VJSxHhpFWzo8nkm7wHzzrb1viwcrdAUHcmpzVVK1UskXUTXs6sU4Rtk+H874O1SURcmM4nLmVy+Z80J3DgZBYd9TDsd3Zcu2czSLJCx5lLzUv3x3hvM2/YBauklvv0xz/Kwb6quC5kL8NHptX42rlkg5IE6lGj2aU3RgrfX/oqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9CXXcfVi81Bauv/+KD/yuKdFL7N3SI4iqxDYaryOTw=;
 b=aPpOaz/Dl1ZyefAJAQ2f5SpGumHAo0xOpfUHRCMlH9PJvlSWNsdglwuANyuTNic3EbcjE5KJ7hPMVA4lI2bdUJ5qNt46mAHlYDAXtMF0wRNJA/BOLRAE2vP1iTHVbSkcsvONQOrbQUqG8xklm97/mgBcgs1KQZegdER6jn/WGyo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by PH7PR12MB8054.namprd12.prod.outlook.com (2603:10b6:510:27f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Wed, 10 Jun
 2026 09:03:17 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 09:03:17 +0000
Message-ID: <f5f76a05-b10a-49ba-9046-65a9713d592f@amd.com>
Date: Wed, 10 Jun 2026 17:03:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/5] drm/xe: have xe_svm_range embed one drm_gpusvm_pages
To: Matthew Brost <matthew.brost@intel.com>,
 Honglei Huang <honglei1.huang@amd.com>
Cc: sima@ffwll.ch, rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com,
 dakr@kernel.org, aliceryhl@google.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Christian.Koenig@amd.com, Oak.Zeng@amd.com,
 Jenny-Jing.Liu@amd.com, Philip.Yang@amd.com, Xiaogang.Chen@amd.com,
 Ray.Huang@amd.com, Lingshan.Zhu@amd.com, Junhua.Shen@amd.com,
 Yiru.Ma@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260603065620.2555316-1-honglei1.huang@amd.com>
 <20260603065620.2555316-4-honglei1.huang@amd.com>
 <aijkr+XH8FabaeiD@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <aijkr+XH8FabaeiD@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0035.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::17) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|PH7PR12MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: 22abc168-810e-41be-9a49-08dec6cf1c4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 4IVaTEcccCW2MASFf9M9+JYAfGZ5zap/sHgDyKAMy3rfaQ7CyUecvsRrQjClLuS37BBVAz6CwDyyj1aUBvnZZIThEqmr125v+93jhAWZ0Mt1i+Zv9ZRePm3H2eXLn2Lc59txLEF5JaTyYZY8f/rao90wEw/9dZ7ray+2PbKyM2ScAmTfOYFOZw5hISM7pYOEgq5TRdlBd6obXi5ORZzBE3DCx3KwnZzv4GYHcyALZUJemrZUUeIZqMHCNQFoCgMqCDbQIxZDAx5Y8UlLXQcqwakZd1lGTAZeyPNTo5Ma/1BwYBjcu+mvIUMkWoPkscgM2NOELzgc4+f9nRIf5KLfPBkRpEJALzRYhZEbb9HLLCa33onSsrWd26ZrNdKF7EnXw5J1OmF5LlqTXvaO+iXoL2d09Aw4xewrAg2zt1aCPeCNJytkNUTOkZQ52kdzVoNGZ50pgEqR4IU2Rt7HxRFYo4MnB5op0U17PTYdeutrhO9A3CQEL42LlO+vrpu8cyadNB/kdhisGgjaBCbFZ9HNXqa4qNls+bHNSlL2ZZSgs9U7Ddeb2hWlZxzcNyW3HYNbh+ijbG8hpCsyBP5eZGDdEk5VSaW8JqikI3sujEoXbPK/AJc5YsKuoAthHDsfE8OxHa2/hFv56GzAM79o3dKpv/Df328JM5uvHLYskx/rRm8k7IzrVPB6d7Dwn1M6HEuW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXFlaXlRRmZLVE9GV3lJNEQ2RHlWUHdFUllJODFrNlhDU3VDcDc1RkNPMXNx?=
 =?utf-8?B?V1NxUEdNejlOUTkrMmRCZG9rU05XSWNFdS9EeFRiRGtzTU1kZEx5QWludHpj?=
 =?utf-8?B?a29Dem9na3RyaFk2TEFGVUJzVjVDMnc2SGhtSnZtWkIxT2Z0eHZzbUlscjVw?=
 =?utf-8?B?OTRLTGFkZml2SG9TTWp2ekpRVnp4ZUFvMGcrbzd6d0REZDlsZ29wUjF6SzA1?=
 =?utf-8?B?WGEreVpVRWloTVhFS2hiNEV2RTNibXIwcSt2azdOY2Q4ZTRzZEl1TzZRUUYy?=
 =?utf-8?B?YW9aL0NxZEVCT0xPbkdlT2xkaVVVYmVsRDByajFmUUFVUTlyTUtXNWw2TERM?=
 =?utf-8?B?N213dklCeEFJZGhGUVluTmdCd29rc0Uvd0pON2x5OFZ3UFg1UDQ3a0hlTUN6?=
 =?utf-8?B?VUN1eVoyQ29ibFN2ZG9XSjc5d2ZOSHc4OGhSUDF0Sjc3Z1hPSXVCalZYTVM2?=
 =?utf-8?B?M1ZhKzV1UEsrN3FtU29LemZiUWZaZmREUk1SdmpyUytTMkY5aDhKbWV6aXk0?=
 =?utf-8?B?RGZFZkhxcmY3NXljSTAyd0YzRWt6OHFIMTNZcjNFV296c2NGZUZnRDIzQnBQ?=
 =?utf-8?B?bnJTYzBuWUVmMEI4ZzYyZldGMm9tb2s3cUh0UnJkWDh6QXJQUHNQMVBheFlN?=
 =?utf-8?B?cTExTSs1OTJxWUFxMld5ZVFzSFdDWDRGb2ZQWTNCL0w0cysxNHRjV3ZWMTdC?=
 =?utf-8?B?SjgvRDJIQ25qYnV0Y1kwSFA0WmRPM0tHV0NmNlBFbW8vdHZROGdaQmhjTTV5?=
 =?utf-8?B?OWpVRnd0SytJSUNvYTJtdlBFWnRsV3pka2lWbEI5MnlDZDRJSEwvcHAvb1Zp?=
 =?utf-8?B?Z2FBQXZTa1hTY1lFMUNNQ3FMaTljcGZDRm9UQVNmcXliL1F5YTZ4bXZ5T3Uv?=
 =?utf-8?B?bEVNNSsvWDNZVkIydUc2UjNQeDhSSml0OHhuWW00cW4rRGZ4MkRxZnQxNkNC?=
 =?utf-8?B?eXFpYkF6bG9NMUxBdmZQaThQVjZxSFZWT1VQRExyK0lzSTJKZ3FCVDFMK3FU?=
 =?utf-8?B?Rjd0SHVYL0RmUFFWWlZqMngvNDFDUVE2SUxMd0VFZVkzOEl3QlZwTEx4QnVw?=
 =?utf-8?B?Z3diaUpINkNrSFB3K29ySHR1ekw5dXUwamh1NkZnbkZxY2FzVXp6YzZmYW82?=
 =?utf-8?B?R0hWWmpWM2VNWm4rOW53OUpPUnRKaElCeXVGeTNwWk9FbDZ6YjlEaCtLWkxi?=
 =?utf-8?B?VVBCVEU5TUMwU3RKTWR2UnBqSisvQi93cFdRc1piT1ArczQ5OC9uZDhzUi9F?=
 =?utf-8?B?TXZJbmdKWFVHR1I5T3pmK0luR0RjaHlQVUE4TFgybkMzSzNvV1o1bTE0UUJs?=
 =?utf-8?B?TVZvaSt4czdXTzJ1azFZUm90dFZnL3E0dGlycG1PWjFwUzNxZEhJTmgwSlpw?=
 =?utf-8?B?cDhXclV2ZGxMWlVIS0x1STNsYjRoYWp5emFYMDgzcnBuWWhEMXowdForc3p4?=
 =?utf-8?B?R21zbVY2S1NkSkwzN3Y1azNVSmdBMFlkd3NWSU44blM2WUY4TWp2M0syNWtD?=
 =?utf-8?B?UFFqUngrVGVJY2RPcFlhY2h4MXduUDluUWFvcFRKekJzZWw4a3hxcWVzQkhh?=
 =?utf-8?B?WldDQmgzdTBqUUdGZnN1THB6Q0V5MFBRZXB0c3VZRGhZNWJld3U2Ukc0cEta?=
 =?utf-8?B?SEVobzVhWVJGS2JaMXo4YkplZnVWRWJVQ0RSbUtEWGVvYmdkUjB3TjVPaG9G?=
 =?utf-8?B?MTU2eUszdGNBc2t0UXFWZDN3QStieDB2Y3pFTms1NUNZd2FzZlBlakVXMzlK?=
 =?utf-8?B?d0JaNkJjdWE0VkZ6T1c3TWVvcW55Z054czQ0MWxMczREU25tTXI2NXYxdk9q?=
 =?utf-8?B?cTBEb2FsWTkzSUtSTnNtZFVNSVBuTkpieFM0RE5manlKOW5kSHprbmExcFJ4?=
 =?utf-8?B?blN5UmlaQnFnbENmU1hsbkhTV0ZnNEtyQTFqLzBad3N4ampEbHlVaEl0OGRW?=
 =?utf-8?B?ZCtuNXpKMmRzcVlySlVCZUU2MHdiQVMxQU45SnJubWlXL0YyV2pwVmVsb1c4?=
 =?utf-8?B?YnpGS0hiUnBjL2JMUXkxMk5jZ256MXBQYzQxZWhTSStpV25sVlVNQlNFeFhi?=
 =?utf-8?B?OHBZYUhwK3RTaEp3bG02eE1tRlNPai9kdk1ZRjZLckZZMWpkL3NPelN0UElU?=
 =?utf-8?B?TFZWaytpdExXQ3RERzBkSEJhT1pMaEFqR3hlWm05SGoyV3lDMlZZejBFUW1H?=
 =?utf-8?B?RmlqNUIrOTBaNGR2WXh6WUV3TkZ1dVc2RThMUmY0YzVFZDlnWTROeU14VktL?=
 =?utf-8?B?R3ZjQ1BCOUVCR3ZRU292OW1CS3kxblZUZnpOaUxjazUwVnhYdGxEcnRiaWNj?=
 =?utf-8?Q?nY94vLDjVDvdfCw3i1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22abc168-810e-41be-9a49-08dec6cf1c4e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:03:17.1694 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VM7uLFKRcj4apuOmlbooU3BqE9iqtR8GBawfi2KukXF5I9O5idkFBnWLiv6KxTG183ahpA3QvaI16yIUvQ45uQ==
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



On 6/10/2026 12:14 PM, Matthew Brost wrote:
> On Wed, Jun 03, 2026 at 02:56:18PM +0800, Honglei Huang wrote:
>> From: Honglei Huang <honghuan@amd.com>
>>
>> With drm_gpusvm_pages now self contained, make xe stop relying
>> on the drm_gpusvm_range pages and take responsibility for the page
>> lifecycle on the driver side.
>>
>> Driver side (xe):
>>
>>    - Embed struct drm_gpusvm_pages in xe_svm_range and route all
>>      xe accesses through it instead of range->base.pages.
>>    - Take over the page lifecycle: xe_svm_range_get_pages() calls
>>      drm_gpusvm_get_pages() directly with &xe->drm; the notifier
>>      event_end and xe_svm_range_free() paths drive unmap/free on
>>      the embedded pages object.
>>    - Switch xe_svm_range_pages_valid() to drm_gpusvm_pages_valid().
>>
>> Framework side (drm_gpusvm):
>>
>>    - Export drm_gpusvm_pages_valid() to let driver owned pages
>>      can query mapping state without going through a range.
>>    - Contract change: drm_gpusvm_range_remove() no longer unmaps or
>>      frees pages; drivers that own a drm_gpusvm_pages instance must
>>      do that themselves.
>>
>> Side effect / contract: drivers that own a drm_gpusvm_pages
>> are now responsible for its lifecycle, in particular for calling
>> drm_gpusvm_unmap_pages() and drm_gpusvm_free_pages() at the
>> appropriate points.
>>
>> Suggested-by: Matthew Brost <matthew.brost@intel.com>
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> ---
>>   drivers/gpu/drm/drm_gpusvm.c |  9 +++------
>>   drivers/gpu/drm/xe/xe_pt.c   |  2 +-
>>   drivers/gpu/drm/xe/xe_svm.c  | 22 +++++++++++++++-------
>>   drivers/gpu/drm/xe/xe_svm.h  |  9 +++++++--
>>   include/drm/drm_gpusvm.h     |  3 +++
>>   5 files changed, 29 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
>> index 3f076178b2a..a4b56cefeb2 100644
>> --- a/drivers/gpu/drm/drm_gpusvm.c
>> +++ b/drivers/gpu/drm/drm_gpusvm.c
>> @@ -1231,8 +1231,6 @@ EXPORT_SYMBOL_GPL(drm_gpusvm_free_pages);
>>   void drm_gpusvm_range_remove(struct drm_gpusvm *gpusvm,
>>   			     struct drm_gpusvm_range *range)
>>   {
>> -	unsigned long npages = npages_in_range(drm_gpusvm_range_start(range),
>> -					       drm_gpusvm_range_end(range));
>>   	struct drm_gpusvm_notifier *notifier;
>>   
>>   	drm_gpusvm_driver_lock_held(gpusvm);
>> @@ -1244,8 +1242,6 @@ void drm_gpusvm_range_remove(struct drm_gpusvm *gpusvm,
>>   		return;
>>   
>>   	drm_gpusvm_notifier_lock(gpusvm);
>> -	__drm_gpusvm_unmap_pages(gpusvm, &range->pages, npages);
>> -	__drm_gpusvm_free_pages(gpusvm, &range->pages);
>>   	__drm_gpusvm_range_remove(notifier, range);
>>   	drm_gpusvm_notifier_unlock(gpusvm);
>>   
>> @@ -1324,13 +1320,14 @@ EXPORT_SYMBOL_GPL(drm_gpusvm_range_put);
>>    *
>>    * Return: True if GPU SVM range has valid pages, False otherwise
>>    */
>> -static bool drm_gpusvm_pages_valid(struct drm_gpusvm *gpusvm,
>> -				   struct drm_gpusvm_pages *svm_pages)
>> +bool drm_gpusvm_pages_valid(struct drm_gpusvm *gpusvm,
>> +			    struct drm_gpusvm_pages *svm_pages)
>>   {
>>   	lockdep_assert_held(&gpusvm->notifier_lock);
>>   
>>   	return svm_pages->flags.has_devmem_pages || svm_pages->flags.has_dma_mapping;
>>   }
>> +EXPORT_SYMBOL_GPL(drm_gpusvm_pages_valid);
>>   
>>   /**
>>    * drm_gpusvm_range_pages_valid() - GPU SVM range pages valid
>> diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
>> index 2669ff5ee74..e82b0d8fab1 100644
>> --- a/drivers/gpu/drm/xe/xe_pt.c
>> +++ b/drivers/gpu/drm/xe/xe_pt.c
>> @@ -758,7 +758,7 @@ xe_pt_stage_bind(struct xe_tile *tile, struct xe_vma *vma,
>>   			return -EAGAIN;
>>   		}
>>   		if (xe_svm_range_has_dma_mapping(range)) {
>> -			xe_res_first_dma(range->base.pages.dma_addr, 0,
>> +			xe_res_first_dma(range->pages.dma_addr, 0,
>>   					 xe_svm_range_size(range),
>>   					 &curs);
>>   			xe_svm_range_debug(range, "BIND PREPARE - MIXED");
>> diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
>> index 3acfddb7c5b..33c26df5111 100644
>> --- a/drivers/gpu/drm/xe/xe_svm.c
>> +++ b/drivers/gpu/drm/xe/xe_svm.c
>> @@ -66,7 +66,7 @@ static bool xe_svm_range_in_vram(struct xe_svm_range *range)
>>   
>>   	struct drm_gpusvm_pages_flags flags = {
>>   		/* Pairs with WRITE_ONCE in drm_gpusvm.c */
>> -		.__flags = READ_ONCE(range->base.pages.flags.__flags),
>> +		.__flags = READ_ONCE(range->pages.flags.__flags),
>>   	};
>>   
>>   	return flags.has_devmem_pages;
>> @@ -96,7 +96,7 @@ static struct xe_vm *range_to_vm(struct drm_gpusvm_range *r)
>>   	       (r__)->base.gpusvm,					\
>>   	       xe_svm_range_in_vram((r__)) ? 1 : 0,			\
>>   	       xe_svm_range_has_vram_binding((r__)) ? 1 : 0,		\
>> -	       (r__)->base.pages.notifier_seq,				\
>> +	       (r__)->pages.notifier_seq,				\
>>   	       xe_svm_range_start((r__)), xe_svm_range_end((r__)),	\
>>   	       xe_svm_range_size((r__)))
>>   
>> @@ -115,6 +115,7 @@ xe_svm_range_alloc(struct drm_gpusvm *gpusvm)
>>   		return NULL;
>>   
>>   	INIT_LIST_HEAD(&range->garbage_collector_link);
>> +	range->pages.notifier_seq = LONG_MAX;
> 
> As discussed in the cover-letter let's do a drm_gpusvm_init_pages()
> function to set the notifier_seq.
> 
> If we want to include 'drm' in the init function as discussed in patch
> #2, to fish this out in Xe you can do '&gpusvm_to_vm(gpusvm)->xe->drm'.

Got it, will init the seq in drm_gpusvm_init_pages, and will aplly the 
init in Xe according to your suggestion.


> 
>>   	xe_vm_get(gpusvm_to_vm(gpusvm));
>>   
>>   	return &range->base;
>> @@ -122,8 +123,10 @@ xe_svm_range_alloc(struct drm_gpusvm *gpusvm)
>>   
>>   static void xe_svm_range_free(struct drm_gpusvm_range *range)
>>   {
>> +	drm_gpusvm_free_pages(range->gpusvm, &(to_xe_range(range)->pages),
>> +			      drm_gpusvm_range_size(range) >> PAGE_SHIFT);
>>   	xe_vm_put(range_to_vm(range));
>> -	kfree(range);
>> +	kfree(to_xe_range(range));
>>   }
>>   
>>   static void
>> @@ -208,7 +211,8 @@ xe_svm_range_notifier_event_end(struct xe_vm *vm, struct drm_gpusvm_range *r,
>>   
>>   	xe_svm_assert_in_notifier(vm);
>>   
>> -	drm_gpusvm_range_unmap_pages(&vm->svm.gpusvm, r, &ctx);
>> +	drm_gpusvm_unmap_pages(&vm->svm.gpusvm, &(to_xe_range(r)->pages),
>> +			       drm_gpusvm_range_size(r) >> PAGE_SHIFT, &ctx);
>>   	if (!xe_vm_is_closed(vm) && mmu_range->event == MMU_NOTIFY_UNMAP)
>>   		xe_svm_garbage_collector_add_range(vm, to_xe_range(r),
>>   						   mmu_range);
>> @@ -952,7 +956,7 @@ void xe_svm_fini(struct xe_vm *vm)
>>   static bool xe_svm_range_has_pagemap_locked(const struct xe_svm_range *range,
>>   					    const struct drm_pagemap *dpagemap)
>>   {
>> -	return range->base.pages.dpagemap == dpagemap;
>> +	return range->pages.dpagemap == dpagemap;
>>   }
>>   
>>   static bool xe_svm_range_has_pagemap(struct xe_svm_range *range,
>> @@ -1017,7 +1021,7 @@ bool xe_svm_range_validate(struct xe_vm *vm,
>>   	if (dpagemap)
>>   		ret = ret && xe_svm_range_has_pagemap_locked(range, dpagemap);
>>   	else
>> -		ret = ret && !range->base.pages.dpagemap;
>> +		ret = ret && !range->pages.dpagemap;
>>   
>>   	xe_svm_notifier_unlock(vm);
>>   
>> @@ -1510,7 +1514,11 @@ int xe_svm_range_get_pages(struct xe_vm *vm, struct xe_svm_range *range,
>>   	if (READ_ONCE(range->base.flags.unmapped))
>>   		return -EFAULT;
>>   
>> -	err = drm_gpusvm_range_get_pages(&vm->svm.gpusvm, &range->base, ctx);
>> +	err = drm_gpusvm_get_pages(&vm->svm.gpusvm, &range->pages,
>> +				   &vm->xe->drm, vm->svm.gpusvm.mm,
>> +				   &range->base.notifier->notifier,
>> +				   drm_gpusvm_range_start(&range->base),
>> +				   drm_gpusvm_range_end(&range->base), ctx);
>>   	if (err == -EOPNOTSUPP) {
>>   		range_debug(range, "PAGE FAULT - EVICT PAGES");
>>   		drm_gpusvm_range_evict(&vm->svm.gpusvm, &range->base);
>> diff --git a/drivers/gpu/drm/xe/xe_svm.h b/drivers/gpu/drm/xe/xe_svm.h
>> index b7b8eeacf19..ea73241d3d9 100644
>> --- a/drivers/gpu/drm/xe/xe_svm.h
>> +++ b/drivers/gpu/drm/xe/xe_svm.h
>> @@ -31,6 +31,11 @@ struct xe_vram_region;
>>   struct xe_svm_range {
>>   	/** @base: base drm_gpusvm_range */
>>   	struct drm_gpusvm_range base;
>> +	/**
>> +	 * @pages: Per-device DMA mapping state; single instance since
>> +	 * xe svm is 1 svm : 1 drm_device.
> 
> s/xe/Xe

Got it, will fix.

Regards,
Honglei

> 
> Matt
> 
>> +	 */
>> +	struct drm_gpusvm_pages pages;
>>   	/**
>>   	 * @garbage_collector_link: Link into VM's garbage collect SVM range
>>   	 * list. Protected by VM's garbage collect lock.
>> @@ -74,7 +79,7 @@ struct xe_pagemap {
>>    */
>>   static inline bool xe_svm_range_pages_valid(struct xe_svm_range *range)
>>   {
>> -	return drm_gpusvm_range_pages_valid(range->base.gpusvm, &range->base);
>> +	return drm_gpusvm_pages_valid(range->base.gpusvm, &range->pages);
>>   }
>>   
>>   int xe_devm_add(struct xe_tile *tile, struct xe_vram_region *vr);
>> @@ -132,7 +137,7 @@ void *xe_svm_private_page_owner(struct xe_vm *vm, bool force_smem);
>>   static inline bool xe_svm_range_has_dma_mapping(struct xe_svm_range *range)
>>   {
>>   	lockdep_assert_held(&range->base.gpusvm->notifier_lock);
>> -	return range->base.pages.flags.has_dma_mapping;
>> +	return range->pages.flags.has_dma_mapping;
>>   }
>>   
>>   /**
>> diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
>> index ed228d9ff6b..21baf91ec7e 100644
>> --- a/include/drm/drm_gpusvm.h
>> +++ b/include/drm/drm_gpusvm.h
>> @@ -306,6 +306,9 @@ void drm_gpusvm_range_put(struct drm_gpusvm_range *range);
>>   bool drm_gpusvm_range_pages_valid(struct drm_gpusvm *gpusvm,
>>   				  struct drm_gpusvm_range *range);
>>   
>> +bool drm_gpusvm_pages_valid(struct drm_gpusvm *gpusvm,
>> +			    struct drm_gpusvm_pages *svm_pages);
>> +
>>   int drm_gpusvm_range_get_pages(struct drm_gpusvm *gpusvm,
>>   			       struct drm_gpusvm_range *range,
>>   			       const struct drm_gpusvm_ctx *ctx);
>> -- 
>> 2.34.1
>>

