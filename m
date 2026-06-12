Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82BB7CD98D6
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 14:39:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8613D10F568;
	Fri, 12 Jun 2026 14:39:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OZ4OJUyQ";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010055.outbound.protection.outlook.com [52.101.61.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 398B410EA4B;
 Fri, 12 Jun 2026 14:39:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SneuDzUnNZIlpPgNdCjHeBParTcJz69BKY9XRCQxqK08gNPhxYksCcr80lk8gRRAEHyUioCZiEbPxOgYZ8llS1/o1X8CHC+GnsJPiTmt5E6NAJwGjt+q7wc2LB+UprJuo8gmjyxtwP2neUXwCgkff2aQPwweTdSwH5IYWll618TGM7PXPcfrmTGx5HZAKEF+pr+mJF4q5P3uPs5AZ82oES8HnA/HrsoO8/5HLjT0i+UpNK0Namo586KOiTSPcx1RibFvflW0nnag3voLkDmwP/RBpEbt2ZWHyBIENHo0NC2BXn8PG8/hvYPhA6pGy2Qvp7U8/vR8NkB1tsHfhe5sGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQNlIIwlwe9ofbYw6N9KhNI/ru5cCTRGV/wtiIOW9BU=;
 b=k/bgty5qhsX26CtvdG5LxZcUJ9KXxqfdWtpGfJ0s+xtUzKo/X2UqTj8lFjE3SEGOhOJobqt1ZjqpXW7J/7rx7JDmm+CIXfbtIdTBMywA/VkIcIIiHlitdCqO92Fkl+ubLE0T8fnFADERCvIdPpaYl+WXdRXdlR8l2zFRs+Lb1T3dR7VqU9zhlYeDo68g+w5NfVU1hJy0zzPkTOBT5KSkXdnFgjg4gxjmABpVbt8oyRFx0rMquEAELtvcOQn/t0UshoSf+yG8ZVSP4w212z076qoFfOukXoTz6x69evG1jbquW7L4PAotk5HjpJO81zZu3FN0lOEaGX08nwNs3vN+gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQNlIIwlwe9ofbYw6N9KhNI/ru5cCTRGV/wtiIOW9BU=;
 b=OZ4OJUyQ4p47sImehit8kbMr9JSnswXqxNf5ijmfJMmjTMI3hFRJVUPHrGi8gFseUWXPRChAVZVvOafu7ijYZUZ030sUQCp8nd9AVsR2ZHMoEWulXeFYdgNdhttg0QAwaJfsfonDyBXNtmJpDoxYnJGSCk4II/9gQ4wN+n29v8g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by IA0PR12MB7577.namprd12.prod.outlook.com (2603:10b6:208:43e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 14:39:07 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 14:39:07 +0000
Message-ID: <3a1ee25e-8fbf-420f-9940-cd3ba487a241@amd.com>
Date: Fri, 12 Jun 2026 22:38:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/18] drm/amdgpu: implement SVM attribute
 set/get/clear operations
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>
Cc: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Jenny Liu <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>,
 Yiru Ma <yiru.ma@amd.com>, Simona Vetter <simona@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260612090928.29682-1-ray.huang@amd.com>
 <20260612090928.29682-6-ray.huang@amd.com>
 <32a43737-d2cc-4b8a-9f9e-6b7d0fdabf67@amd.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <32a43737-d2cc-4b8a-9f9e-6b7d0fdabf67@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0058.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:8::9)
 To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|IA0PR12MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: cd478142-b2b1-454b-4006-08dec8905bcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|4143699003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: 60SRqw42y+fF0od0dounLvO0s9y9G67B7s2L+nm3Fku5+frYovZEGAo4GGcwOwZZReMyHRoWcZPtprD1dUVEKSQnScJX2kaaSuALiQb1V4trSrboOCqH4HoGbdG3EGX39xhyd0nBWp9MMftitWM90ZbHdCXlJb40KhuNaOMr4fSuDPhAIm7IubWnc6AvRdDURVxgiH4ChH5Hojj8TvWrk8c1aPrnlqvts+Wocur71/wXpaqojlB5JDQBtwWXMfCJbzD7KveWvBAiGNa7OVVUST+k4g5KQxtpLkCoXQJ4+C7OiIZCWm4wDluBUIxrCv/0jFuI3m8LDG4OzikseQDCilvgU7uSuosfZ+GyoRixnOIewlwp5ZlKc7XmoFewr7RkVB4T10UiQsvJ9BV49jrFLrSCi5XRhPIigJk0JliIo4bcFx2rNpL5cX/PtoZ8CRkJ05Mu6nX1aZZVeQdQqd20VEoRe+2RiIcdJhQw5OZ5yF6MXcYIYrLePrsnRDBo5r8Twk4xQzVnVwMYR9bkG2Yl5EDYCZLpxBrycyquofVGTJWocaPGmys7jjS8xsebreQZRZbsVz3nfZRz9o6vwFca8XfpJP0NpwncE6Olg9XHUS8NhHeHPiUAP3dnz7ILOuFkk5maNKv4nYEjCb0wRzv5D09NLHx2bOGljm6uSZ0b2EFwbhJmWHqE4dbY2H01YJ8j
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEJsekRQRWl4V1duN2MxendnbTNoUkVabHFpWHVCdVh1LzMxbVFaWHNWNFQ5?=
 =?utf-8?B?UmVsWGZaTEtuOVVYYlZGbEp4Q0FGUE1rdmkrTlR0dzYxTEZaV0lyV1FsZGha?=
 =?utf-8?B?WGVMMFhISkhiR29mdmEvQnBQUDBHUmQ3dkxGRXZTVEdIN2oweFQwMDJHdGNv?=
 =?utf-8?B?d3c4WVYzN2dmQTU1VmE3ZEk5N2hPb2RjNFJsZFcwbWJnUjAyWWs4ZDhqZi9p?=
 =?utf-8?B?VERmOG80czBOaWM2UzhEOHhRcS9mY2FiK2g5ekFJTmxoT01yazhMbCtRZHBY?=
 =?utf-8?B?Qm9KVnI4ZUFMWDhxblV3RWlPMW84cmJGNW53ZjJuMS9WZXZEajJMVE1jejBX?=
 =?utf-8?B?cFJWZndYaUY3bEJ4ZmxpRGtsY2lTY1AraWdzeVJqTFdzdTNQS0ZsZzkvSEs4?=
 =?utf-8?B?ZWs1YWptZWxYOWFUVG0vajd1bHhzU1FZdnlHZWJzK3BERk84SVBHMHl1WXEr?=
 =?utf-8?B?T3BSTnhlNlYxalVUdE1jbVRYNlAzMFZEWm44WUFKVEJwdlBUTW9wbDhxaGhC?=
 =?utf-8?B?djVVWGQ2VkhIK3hJQkttbWxiV1NkazFIRnV1bkRzQmRHeEl4bm1FTzlaOEIv?=
 =?utf-8?B?dmN6UjlOZURFWU81NXh1enBBMXZ0eWYxQ1dibVNWdktibUU1Njl0T0g4YVJN?=
 =?utf-8?B?L2tQa1l4c1o2bjZmY09INndoK0RlaUwvT1d3RHJiOFNLZVNBYW5XSDNNN2hr?=
 =?utf-8?B?elVLSkhORndYbHdnZmpzZG5EemhnenlyUzlaVjB3SXdzSCtpdjJPL2ZKcXVG?=
 =?utf-8?B?WHpxUWxsTUY4eW1FazFjejhTc0VCNEdjUTFaSFhTNG5CNCtuRXpjU0s4R3NI?=
 =?utf-8?B?dExRd3hzQnRMNWQxckNkTWU1RjR5OUR2bXpVSnNWLzd1NDNQSFdDTGptZVFj?=
 =?utf-8?B?ZzJydVNDUDI4dEhTa3dDUTdGeElZRk9ybUFwMjZ2NW54b205NlVrZ2ZCU3lI?=
 =?utf-8?B?T3ZSL1AzK2xCRy9jY1hPTnFkSjBnYkdaemJkQnlIOVo3WjdSdSt0eUVIK203?=
 =?utf-8?B?TWwvb0hsU2RYWlZjMWhibk5aeHBEUU5BYmh6enFzYWtvai81R3czVmZPOHpj?=
 =?utf-8?B?T3Nkb21JbWlJMHhFd1RablZWQzRKdldiSHg1eEdvcUtnSjlFbEtkWHdGKzUr?=
 =?utf-8?B?ZXFORU5vd2ZJdVFUYzFsUDEvTEpuNDgrcWdwTnhJMis1RGFsbU9vSTlNNXdr?=
 =?utf-8?B?K0dUREtpUFV4bFh3NTl1MWhsWlI4NDVpSzl3R0JDekpraVlyMkNnajROY3F2?=
 =?utf-8?B?aXNJUzFTREJtNTN6K09JZFlPdHNSRXlxMEtXV2pQSWFTYXBaWFB0bWxNUkxU?=
 =?utf-8?B?Ynl3ekxpeHdvTHk2eHJGNkZDOVkweXIydU9IK0pLSkN1a2lTaHhMZVlyVHpm?=
 =?utf-8?B?aWNHSDZiRTJPYzREQzlpeUdEbmh6NHZuTHZaQjdVeS9PaXJIM2t2VUxmVjh5?=
 =?utf-8?B?VjZnb2x1V3EyYkFXYmxCZkxMMHM1czRMZVYyNzZoWnZ3QzZCV2pSeVJucUdC?=
 =?utf-8?B?QlFMZzZZZm5DZCtJbnl3bGZ3TFVHWnZLcklmM1FPTTFuUFdJZ2xoVEdlV29W?=
 =?utf-8?B?VHJycmxteVJwN1E2TnhSb1JqbmFtYnIxNkFIY2FqNnJVNG1nMDNQZytVM0U2?=
 =?utf-8?B?czQveERCWkF5aUdTY1VzUXkyTFpoakFFSFpQbllWT2xTQlVTVjRwaElzSy93?=
 =?utf-8?B?Y0dSSHQ1Ky9aUU1lY1o0T3IyYmF2VGdnNVc1MVlwNG1rUjdTUk1iQmYvZjhS?=
 =?utf-8?B?SHB1RHBzTG4wNkVWSHE3VlgrdWtDOTVyR2VuZkdKOG55UVJJNFJxVG54MGdk?=
 =?utf-8?B?QSsxWnMrV25Pc3dHK29zNGd2UkhNNVhOT3FqUlVQVjBDYU5LQ2xVOXdLSGxj?=
 =?utf-8?B?M0ZFa0VKODZlQXVpUXlkdG1tR1A0UW5PR0xLODFycnFkVU5nUzA2aThaWExV?=
 =?utf-8?B?VmdQVFBQakFJKzU2ZTZpeTFuS2VuSmpPNzBBQUFsTm1ZdktpeGl3Uldwamdh?=
 =?utf-8?B?K3dQdUdYYXoxRGhobnZSV1RVVkpSQ0Fob2JwVXpTYm5oUzlMaFpLdVlhb1Rn?=
 =?utf-8?B?bXNsQUJNVkxjeDZtZ2orQzZaTjc1cGZiRnJoTGloWW80aW1GMStVK2pxR0ZU?=
 =?utf-8?B?eGY3OXVVaklSUVNqTUFBOHBOazVEV3FidnZqbzRnQWd0SDhDNGRUcWcxTXJ0?=
 =?utf-8?B?Q254WVdidkdldVpwTERZMWFlbWlkanVES2VBbnpjeGJ4SlhuN1VBNnVOeUZ6?=
 =?utf-8?B?dlFDZFFjTkx6UHJiODVHU3NTU0dQMjB5ZnR1bUZUUlp1RHhDVEFVZjBaUHZt?=
 =?utf-8?Q?XONmh31racbMvTFu6p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd478142-b2b1-454b-4006-08dec8905bcc
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 14:39:07.7491 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Fc/yytUdba/DSDGDjTpRexPcmANZiWJsCdaDvz2dOKKTlua+xDqXDABJM59mMSj4hAiKb1BawiOAiUY0A4q6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7577
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



On 6/12/2026 8:10 PM, Christian König wrote:
> On 6/12/26 11:09, Huang Rui wrote:
>> From: Honglei Huang <honghuan@amd.com>
>>
>> Complete attribute subsystem with validation, tree modification, and
>> public API:
>> - Attribute validation: per-type checks for preferred_loc, prefetch_loc,
>>    access, flags, granularity
>> - Flag application: attr_apply_flag, amdgpu_svm_attr_apply
>> - VMA range validation: amdgpu_svm_attr_validate_range_vma
>> - VM BO overlap detection: amdgpu_svm_attr_check_vm_bo
>> - Tree modification with gap/overlap handling:
>>    amdgpu_svm_attr_set_hole (new range in gap),
>>    amdgpu_svm_attr_set_existing (split/update existing range)
>> - amdgpu_svm_attr_set_range: cursor based iteration with per segment
>> - Lifecycle: amdgpu_svm_attr_tree_create/destroy
>> - Public API: amdgpu_svm_attr_set (validate, set_range with retry),
>>    amdgpu_svm_attr_get (aggregate attrs across interval),
>>    amdgpu_svm_attr_clear (interval removal with split),
>>    amdgpu_svm_attr_reset
>>
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c | 738 +++++++++++++++++++
>>   1 file changed, 738 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
>> index ba09aa3c3fe4d..26e33defb8b9d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
>> @@ -232,3 +232,741 @@ static void attr_remove_range_locked(struct amdgpu_svm_attr_tree *attr_tree,
>>   	if (free_range)
>>   		kmem_cache_free(amdgpu_svm_attr_range_cache, range);
>>   }
>> +
>> +static void attr_change_ctx_set(
>> +		struct attr_set_ctx *change,
>> +		const struct amdgpu_svm_attrs *old_attrs,
>> +		const struct amdgpu_svm_attrs *new_attrs,
>> +		unsigned long start_page,
>> +		unsigned long last_page)
>> +{
>> +	change->old_attrs = *old_attrs;
>> +	change->new_attrs = *new_attrs;
>> +	change->start_page = start_page;
>> +	change->last_page = last_page;
>> +}
>> +
>> +static inline int attr_check_preferred_loc(uint32_t value)
>> +{
>> +	/* cause one svm one gpu so value > 0 then means preferred loc is this GPU */
>> +	if (value == AMDGPU_SVM_LOCATION_SYSMEM || value == AMDGPU_SVM_LOCATION_UNDEFINED)
>> +		return 0;
>> +
>> +	return 0;
>> +}
>> +
>> +static inline int attr_check_prefetch_loc(uint32_t value)
>> +{
>> +	/* cause one svm one gpu so value > 0 then means prefetch loc is this GPU
>> +	 * keep prefetch loc to adapt to KFD API
>> +	 */
>> +	if (value == AMDGPU_SVM_LOCATION_SYSMEM)
>> +		return 0;
>> +
>> +	if (value == AMDGPU_SVM_LOCATION_UNDEFINED)
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
>> +static inline int attr_check_access(uint32_t value)
>> +{
>> +	switch (value) {
>> +	case AMDGPU_SVM_ACCESS_INACCESSIBLE:
>> +	case AMDGPU_SVM_ACCESS_IN_PLACE:
>> +	case AMDGPU_SVM_ACCESS_ALLOW_MIGRATE:
>> +		return 0;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static bool attr_flag_type_to_bit(uint32_t type, uint32_t *flag_bit)
>> +{
>> +	if (type < AMDGPU_SVM_ATTR_HOST_ACCESS ||
>> +	    type > AMDGPU_SVM_ATTR_GPU_READ_MOSTLY)
>> +		return false;
>> +
>> +	*flag_bit = 1u << (type - AMDGPU_SVM_ATTR_HOST_ACCESS);
>> +	return true;
>> +}
>> +
>> +static inline int attr_check_flag_value(uint32_t value)
>> +{
>> +	if (value > 1)
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
>> +static inline int attr_check_flag_attr(uint32_t type, uint32_t value)
>> +{
>> +	uint32_t flag_bit;
>> +	int ret;
>> +
>> +	if (!attr_flag_type_to_bit(type, &flag_bit))
>> +		return -EINVAL;
>> +
>> +	ret = attr_check_flag_value(value);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>> +static inline int attr_check_granularity(uint32_t value)
>> +{
>> +	return 0;
>> +}
>> +
>> +int
>> +amdgpu_svm_attr_check_vm_bo(struct amdgpu_svm_attr_tree *attr_tree,
>> +			    unsigned long start_page,
>> +			    unsigned long last_page,
>> +			    unsigned long *bo_start, unsigned long *bo_last)
>> +{
>> +	struct amdgpu_svm *svm = attr_tree->svm;
>> +	struct amdgpu_vm *vm = svm->vm;
>> +	struct interval_tree_node *node;
>> +	int r;
>> +
>> +	r = amdgpu_bo_reserve(vm->root.bo, false);
>> +	if (r)
>> +		return r;
>> +
>> +	node = interval_tree_iter_first(&vm->va, start_page, last_page);
>> +	if (node) {
>> +		AMDGPU_SVM_ERR("SVM range [0x%lx 0x%lx] overlaps with BO mapping [0x%lx 0x%lx]\n",
>> +			       start_page, last_page, node->start, node->last);
> 
> Yeah that approach is a clear NAK.
> 
> We must enforce that based on the range I think.

How about mirror what xe does, but on amdgpu_vm. xe puts SVM ranges into 
the same drm_gpuvm va tree as BO mappings, tagged with
XE_VMA_FLAG_CPU_ADDR_MIRROR, so overlap is enforced by drm_gpuvm at
insert time.

vm->va is already an interval tree of amdgpu_bo_va_mapping with
amdgpu_vm_bo_map() doing the overlap check on insert.

But it needs some modifications in amdgpu vm, so what is the next step?
What is the feasabile design in you side?


> 
>> +		if (bo_start)
>> +			*bo_start = node->start;
>> +		if (bo_last)
>> +			*bo_last = node->last;
>> +		amdgpu_bo_unreserve(vm->root.bo);
>> +		return -EADDRINUSE;
>> +	}
>> +
>> +	amdgpu_bo_unreserve(vm->root.bo);
>> +	return 0;
>> +}
>> +
>> +static int
>> +amdgpu_svm_attr_validate_range_vma(struct amdgpu_svm_attr_tree *attr_tree,
>> +				   unsigned long start_page,
>> +				   unsigned long last_page)
>> +{
>> +	struct vm_area_struct *vma;
>> +	struct mm_struct *mm;
>> +	unsigned long start, end;
>> +	int ret = 0;
>> +
>> +	if (start_page > last_page)
>> +		return -EINVAL;
>> +
>> +	if (last_page == ULONG_MAX)
>> +		return -EINVAL;
>> +
>> +	start = start_page << PAGE_SHIFT;
>> +	end = (last_page + 1) << PAGE_SHIFT;
>> +	mm = attr_tree->svm->gpusvm.mm;
>> +	if (!mm)
>> +		return -EFAULT;
>> +
>> +	mmap_read_lock(mm);
>> +	while (start < end) {
>> +		vma = amdgpu_svm_check_vma(mm, start);
>> +		if (IS_ERR(vma)) {
>> +			ret = PTR_ERR(vma);
>> +			break;
>> +		}
>> +
>> +		start = min(end, vma->vm_end);
>> +	}
> 
> That's complete nonsense as well.
> 
> The result becomes invalid as soon as you drop the lock again, so just completely drop the check.
> 
> hmm_range fault will tell us if the fault was succesful or not.

Got it will drop.>
> Regards,
> Christian.
> 
>> +	mmap_read_unlock(mm);
>> +
>> +	return ret;
>> +}
>> +
>> +static int attr_set_validate(const struct drm_amdgpu_svm_attribute *attr)
>> +{
>> +	switch (attr->type) {
>> +	case AMDGPU_SVM_ATTR_PREFERRED_LOC:
>> +		return attr_check_preferred_loc(attr->value);
>> +	case AMDGPU_SVM_ATTR_PREFETCH_LOC:
>> +		return attr_check_prefetch_loc(attr->value);
>> +	case AMDGPU_SVM_ATTR_ACCESS:
>> +		return attr_check_access(attr->value);
>> +	case AMDGPU_SVM_ATTR_GRANULARITY:
>> +		return attr_check_granularity(attr->value);
>> +	case AMDGPU_SVM_ATTR_HOST_ACCESS:
>> +	case AMDGPU_SVM_ATTR_COHERENT:
>> +	case AMDGPU_SVM_ATTR_HIVE_LOCAL:
>> +	case AMDGPU_SVM_ATTR_GPU_RO:
>> +	case AMDGPU_SVM_ATTR_GPU_EXEC:
>> +	case AMDGPU_SVM_ATTR_GPU_READ_MOSTLY:
>> +	case AMDGPU_SVM_ATTR_EXT_COHERENT:
>> +		return attr_check_flag_attr(attr->type, attr->value);
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static void attr_apply_flag(struct amdgpu_svm_attrs *attrs,
>> +			    uint32_t type, uint32_t value)
>> +{
>> +	uint32_t flag_bit;
>> +
>> +	if (!attr_flag_type_to_bit(type, &flag_bit))
>> +		return;
>> +
>> +	if (value)
>> +		attrs->flags |= flag_bit;
>> +	else
>> +		attrs->flags &= ~flag_bit;
>> +}
>> +
>> +static void attr_apply(struct amdgpu_svm_attrs *attrs,
>> +					uint32_t nattr,
>> +					const struct drm_amdgpu_svm_attribute *pattrs)
>> +{
>> +	const struct drm_amdgpu_svm_attribute *attr;
>> +
>> +	for (attr = pattrs; nattr--; attr++) {
>> +		switch (attr->type) {
>> +		case AMDGPU_SVM_ATTR_PREFERRED_LOC:
>> +			attrs->preferred_loc = (int32_t)attr->value;
>> +			break;
>> +		case AMDGPU_SVM_ATTR_PREFETCH_LOC:
>> +			attrs->prefetch_loc = (int32_t)attr->value;
>> +			break;
>> +		case AMDGPU_SVM_ATTR_ACCESS:
>> +			attrs->access = (enum amdgpu_ioctl_svm_access)attr->value;
>> +			break;
>> +		case AMDGPU_SVM_ATTR_HOST_ACCESS:
>> +		case AMDGPU_SVM_ATTR_COHERENT:
>> +		case AMDGPU_SVM_ATTR_HIVE_LOCAL:
>> +		case AMDGPU_SVM_ATTR_GPU_RO:
>> +		case AMDGPU_SVM_ATTR_GPU_EXEC:
>> +		case AMDGPU_SVM_ATTR_GPU_READ_MOSTLY:
>> +		case AMDGPU_SVM_ATTR_EXT_COHERENT:
>> +			attr_apply_flag(attrs, attr->type, attr->value);
>> +			break;
>> +		case AMDGPU_SVM_ATTR_GRANULARITY:
>> +			attrs->granularity = min_t(uint32_t, attr->value, 0x3f);
>> +			break;
>> +		default:
>> +			break;
>> +		}
>> +	}
>> +}
>> +
>> +static bool attr_same_attrs(const struct amdgpu_svm_attr_range *range,
>> +			    uint32_t nattr,
>> +			    const struct drm_amdgpu_svm_attribute *attrs)
>> +{
>> +	struct amdgpu_svm_attrs target;
>> +
>> +	target = range->attrs;
>> +	attr_apply(&target, nattr, attrs);
>> +	return attr_equal(&range->attrs, &target);
>> +}
>> +
>> +static int
>> +amdgpu_svm_attr_set_hole(struct amdgpu_svm_attr_tree *attr_tree,
>> +			  const struct amdgpu_svm_attrs *default_attrs,
>> +			  unsigned long start_page, unsigned long last_page,
>> +			  uint32_t nattr,
>> +			  const struct drm_amdgpu_svm_attribute *attrs,
>> +			  struct attr_set_ctx *change)
>> +{
>> +	struct amdgpu_svm_attrs new_attrs;
>> +	struct amdgpu_svm_attr_range *range;
>> +
>> +	lockdep_assert_held(&attr_tree->lock);
>> +
>> +	if (start_page > last_page)
>> +		return 0;
>> +
>> +	new_attrs = *default_attrs;
>> +	attr_apply(&new_attrs, nattr, attrs);
>> +
>> +	/* Always create a range entry even when attrs equal defaults */
>> +	range = amdgpu_svm_attr_range_alloc(start_page, last_page, &new_attrs);
>> +	if (!range)
>> +		return -ENOMEM;
>> +
>> +	amdgpu_svm_attr_range_insert_locked(attr_tree, range);
>> +
>> +	attr_change_ctx_set(change, default_attrs,
>> +				       &new_attrs, start_page, last_page);
>> +	return 0;
>> +}
>> +
>> +static int
>> +amdgpu_svm_attr_set_existing(struct amdgpu_svm_attr_tree *attr_tree,
>> +			     struct amdgpu_svm_attr_range *range,
>> +			     unsigned long start_page, unsigned long last_page,
>> +			     uint32_t nattr,
>> +			     const struct drm_amdgpu_svm_attribute *attrs,
>> +			     struct attr_set_ctx *change)
>> +{
>> +	unsigned long range_start = amdgpu_svm_attr_start_page(range);
>> +	unsigned long range_last = amdgpu_svm_attr_last_page(range);
>> +	struct amdgpu_svm_attr_range *left = NULL;
>> +	struct amdgpu_svm_attr_range *right = NULL;
>> +	struct amdgpu_svm_attrs old_attrs;
>> +	struct amdgpu_svm_attrs new_attrs;
>> +
>> +	lockdep_assert_held(&attr_tree->lock);
>> +
>> +	old_attrs = range->attrs;
>> +
>> +	if (attr_same_attrs(range, nattr, attrs)) {
>> +		/* Report old==new so apply_attr_change can decide */
>> +		attr_change_ctx_set(change, &old_attrs,
>> +					       &old_attrs,
>> +					       start_page, last_page);
>> +		return 0;
>> +	}
>> +
>> +	new_attrs = old_attrs;
>> +	attr_apply(&new_attrs, nattr, attrs);
>> +
>> +	/* only need to update attr */
>> +	if (start_page == range_start && last_page == range_last) {
>> +		range->attrs = new_attrs;
>> +		attr_change_ctx_set(change, &old_attrs,
>> +					       &new_attrs, start_page, last_page);
>> +		return 0;
>> +	}
>> +
>> +	/* split head */
>> +	if (start_page > range_start) {
>> +		left = amdgpu_svm_attr_range_alloc(range_start, start_page - 1, &old_attrs);
>> +		if (!left)
>> +			return -ENOMEM;
>> +	}
>> +
>> +	/* split tail */
>> +	if (last_page < range_last) {
>> +		right = amdgpu_svm_attr_range_alloc(last_page + 1, range_last, &old_attrs);
>> +		if (!right) {
>> +			if (left)
>> +				kmem_cache_free(amdgpu_svm_attr_range_cache, left);
>> +			return -ENOMEM;
>> +		}
>> +	}
>> +
>> +	attr_remove_range_locked(attr_tree, range, false);
>> +	if (left)
>> +		amdgpu_svm_attr_range_insert_locked(attr_tree, left);
>> +	attr_set_interval(range, start_page, last_page);
>> +	range->attrs = new_attrs;
>> +	amdgpu_svm_attr_range_insert_locked(attr_tree, range);
>> +	if (right)
>> +		amdgpu_svm_attr_range_insert_locked(attr_tree, right);
>> +
>> +	attr_change_ctx_set(change, &old_attrs,
>> +				       &new_attrs, start_page, last_page);
>> +	return 0;
>> +}
>> +
>> +static int
>> +amdgpu_svm_attr_set_range(struct amdgpu_svm_attr_tree *attr_tree,
>> +			  const struct amdgpu_svm_attrs *default_attrs,
>> +			  unsigned long start_page, unsigned long last_page,
>> +			  uint32_t nattr,
>> +			  const struct drm_amdgpu_svm_attribute *attrs)
>> +{
>> +	struct amdgpu_svm *svm = attr_tree->svm;
>> +	unsigned long cursor = start_page;
>> +	bool need_retry = false;
>> +
>> +	while (cursor <= last_page) {
>> +		struct interval_tree_node *node;
>> +		unsigned long seg_last;
>> +		struct attr_set_ctx change = { 0 };
>> +		int ret;
>> +
>> +		amdgpu_svm_lock(svm);
>> +		mutex_lock(&attr_tree->lock);
>> +		node = interval_tree_iter_first(&attr_tree->tree, cursor, cursor);
>> +		if (node) {
>> +			struct amdgpu_svm_attr_range *range;
>> +
>> +			range = container_of(node, struct amdgpu_svm_attr_range, it_node);
>> +			seg_last = min(last_page, amdgpu_svm_attr_last_page(range));
>> +			ret = amdgpu_svm_attr_set_existing(attr_tree, range,
>> +								   cursor, seg_last,
>> +								   nattr, attrs, &change);
>> +		} else {
>> +			struct interval_tree_node *next;
>> +
>> +			seg_last = last_page;
>> +			if (cursor != ULONG_MAX) {
>> +				next = interval_tree_iter_first(&attr_tree->tree,
>> +								cursor + 1,
>> +								ULONG_MAX);
>> +				if (next) {
>> +					struct amdgpu_svm_attr_range *next_range;
>> +
>> +					next_range = container_of(next,
>> +						struct amdgpu_svm_attr_range,
>> +						it_node);
>> +					seg_last = min(last_page,
>> +						       amdgpu_svm_attr_start_page(next_range) - 1);
>> +				}
>> +			}
>> +			ret = amdgpu_svm_attr_set_hole(attr_tree,
>> +							       default_attrs,
>> +							       cursor, seg_last,
>> +							       nattr, attrs,
>> +							       &change);
>> +		}
>> +		mutex_unlock(&attr_tree->lock);
>> +
>> +		if (ret) {
>> +			amdgpu_svm_unlock(svm);
>> +			return ret;
>> +		}
>> +
>> +		ret = amdgpu_svm_apply_attr_change(svm,
>> +						   &change.old_attrs,
>> +						   &change.new_attrs,
>> +						   change.start_page,
>> +						   change.last_page);
>> +		amdgpu_svm_unlock(svm);
>> +
>> +		if (ret == -EAGAIN) {
>> +			need_retry = true;
>> +			ret = 0;
>> +		}
>> +
>> +		if (ret)
>> +			return ret;
>> +
>> +		if (seg_last == ULONG_MAX || seg_last == last_page)
>> +			break;
>> +
>> +		cursor = seg_last + 1;
>> +	}
>> +
>> +	return need_retry ? -EAGAIN : 0;
>> +}
>> +
>> +struct amdgpu_svm_attr_tree *
>> +amdgpu_svm_attr_tree_create(struct amdgpu_svm *svm)
>> +{
>> +	struct amdgpu_svm_attr_tree *attr_tree;
>> +
>> +	attr_tree = kzalloc(sizeof(*attr_tree), GFP_KERNEL);
>> +	if (!attr_tree)
>> +		return NULL;
>> +
>> +	mutex_init(&attr_tree->lock);
>> +	attr_tree->tree = RB_ROOT_CACHED;
>> +	INIT_LIST_HEAD(&attr_tree->range_list);
>> +	attr_tree->svm = svm;
>> +	return attr_tree;
>> +}
>> +
>> +void amdgpu_svm_attr_tree_destroy(struct amdgpu_svm_attr_tree *attr_tree)
>> +{
>> +	struct amdgpu_svm_attr_range *range, *tmp;
>> +
>> +	if (!attr_tree)
>> +		return;
>> +
>> +	mutex_lock(&attr_tree->lock);
>> +	list_for_each_entry_safe(range, tmp, &attr_tree->range_list, list) {
>> +		interval_tree_remove(&range->it_node, &attr_tree->tree);
>> +		list_del_init(&range->list);
>> +		kmem_cache_free(amdgpu_svm_attr_range_cache, range);
>> +	}
>> +	mutex_unlock(&attr_tree->lock);
>> +
>> +	mutex_destroy(&attr_tree->lock);
>> +	kfree(attr_tree);
>> +}
>> +
>> +int amdgpu_svm_attr_set(struct amdgpu_svm_attr_tree *attr_tree,
>> +			uint64_t start,
>> +			uint64_t size,
>> +			uint32_t nattr,
>> +			const struct drm_amdgpu_svm_attribute *attrs)
>> +{
>> +	struct amdgpu_svm *svm = attr_tree->svm;
>> +	struct amdgpu_svm_attrs default_attrs;
>> +	unsigned long start_page, last_page;
>> +	uint32_t i;
>> +	int r;
>> +
>> +	start_page = start >> PAGE_SHIFT;
>> +	last_page = (start + size - 1) >> PAGE_SHIFT;
>> +
>> +	for (i = 0; i < nattr; i++) {
>> +		AMDGPU_SVM_TRACE("set attr type %u value 0x%08x range [0x%lx-0x%lx] xnack:%d",
>> +			 attrs[i].type, attrs[i].value, start_page, last_page,
>> +			 svm->xnack_enabled ? 1 : 0);
>> +		r = attr_set_validate(&attrs[i]);
>> +		if (r) {
>> +			AMDGPU_SVM_TRACE("invalid attribute %u value 0x%08x",
>> +					 attrs[i].type, attrs[i].value);
>> +			return r;
>> +		}
>> +	}
>> +
>> +	r = amdgpu_svm_attr_validate_range_vma(attr_tree, start_page, last_page);
>> +	if (r)
>> +		return r;
>> +
>> +	r = amdgpu_svm_attr_check_vm_bo(attr_tree, start_page, last_page,
>> +					NULL, NULL);
>> +	if (r)
>> +		return r;
>> +
>> +	amdgpu_svm_attr_set_default(attr_tree->svm, &default_attrs);
>> +
>> +retry:
>> +	r = amdgpu_svm_attr_set_range(attr_tree, &default_attrs,
>> +					       start_page, last_page,
>> +					       nattr, attrs);
>> +	if (r == -EAGAIN) {
>> +		AMDGPU_SVM_TRACE("attr_set retry [0x%lx-0x%lx]\n",
>> +				 start_page, last_page);
>> +		amdgpu_svm_sync_work(svm);
>> +		cond_resched();
>> +		goto retry;
>> +	}
>> +
>> +	return r;
>> +}
>> +
>> +int amdgpu_svm_attr_clear(struct amdgpu_svm_attr_tree *attr_tree,
>> +			  unsigned long start_page,
>> +			  unsigned long last_page)
>> +{
>> +	struct interval_tree_node *node;
>> +	int r = 0;
>> +
>> +	if (start_page > last_page)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&attr_tree->lock);
>> +
>> +	node = interval_tree_iter_first(&attr_tree->tree, start_page, last_page);
>> +	while (node) {
>> +		struct interval_tree_node *next;
>> +		struct amdgpu_svm_attr_range *range;
>> +		unsigned long range_start;
>> +		unsigned long range_last;
>> +
>> +		range = container_of(node, struct amdgpu_svm_attr_range, it_node);
>> +		next = interval_tree_iter_next(node, start_page, last_page);
>> +		range_start = amdgpu_svm_attr_start_page(range);
>> +		range_last = amdgpu_svm_attr_last_page(range);
>> +
>> +		if (range_start < start_page && range_last > last_page) {
>> +			struct amdgpu_svm_attr_range *tail;
>> +
>> +			tail = amdgpu_svm_attr_range_alloc(last_page + 1, range_last,
>> +							   &range->attrs);
>> +			if (!tail) {
>> +				r = -ENOMEM;
>> +				break;
>> +			}
>> +
>> +			attr_remove_range_locked(attr_tree, range, false);
>> +			attr_set_interval(range, range_start, start_page - 1);
>> +			amdgpu_svm_attr_range_insert_locked(attr_tree, range);
>> +			amdgpu_svm_attr_range_insert_locked(attr_tree, tail);
>> +		} else if (range_start < start_page) {
>> +			attr_remove_range_locked(attr_tree, range, false);
>> +			attr_set_interval(range, range_start, start_page - 1);
>> +			amdgpu_svm_attr_range_insert_locked(attr_tree, range);
>> +		} else if (range_last > last_page) {
>> +			attr_remove_range_locked(attr_tree, range, false);
>> +			attr_set_interval(range, last_page + 1, range_last);
>> +			amdgpu_svm_attr_range_insert_locked(attr_tree, range);
>> +		} else {
>> +			attr_remove_range_locked(attr_tree, range, true);
>> +		}
>> +
>> +		node = next;
>> +	}
>> +
>> +	mutex_unlock(&attr_tree->lock);
>> +	return r;
>> +}
>> +
>> +int amdgpu_svm_attr_reset(struct amdgpu_svm_attr_tree *attr_tree,
>> +			  unsigned long start_page,
>> +			  unsigned long last_page)
>> +{
>> +	/*
>> +	 * Range with no attr node in this implementation is treated the
>> +	 * same as one that explicitly stores default attrs. So clear
>> +	 * the attribute ranges when user wants to reset the attrs.
>> +	 *
>> +	 * - GET_ATTR: return default_attrs to userspace when there is no attr
>> +	 *   range.
>> +	 * - SET_ATTR: holes are treated as having default_attrs when
>> +	 *   computing the change trigger.
>> +	 * - Fault: attr lookup falls back to defaults when no attr range exists,
>> +	 *   so migration and PTE flag decisions are unchanged.
>> +	 *
>> +	 * This approach simplifies the implementation and avoids redundant
>> +	 * attribute maintenance. This ioctl operation is for attribute only,
>> +	 * so do not invalidate the GPU mapping here.
>> +	 */
>> +	return amdgpu_svm_attr_clear(attr_tree, start_page, last_page);
>> +}
>> +
>> +static void attr_get_ctx_add(struct attr_get_ctx *ctx,
>> +			       const struct amdgpu_svm_attrs *attrs)
>> +{
>> +	if (!ctx->has_range) {
>> +		ctx->preferred_loc = attrs->preferred_loc;
>> +		ctx->prefetch_loc = attrs->prefetch_loc;
>> +		ctx->granularity = attrs->granularity;
>> +		ctx->access = attrs->access;
>> +		ctx->flags_and = attrs->flags;
>> +		ctx->has_range = true;
>> +		return;
>> +	}
>> +
>> +	if (ctx->preferred_loc != attrs->preferred_loc)
>> +		ctx->preferred_loc = AMDGPU_SVM_LOCATION_UNDEFINED;
>> +	if (ctx->prefetch_loc != attrs->prefetch_loc)
>> +		ctx->prefetch_loc = AMDGPU_SVM_LOCATION_UNDEFINED;
>> +	if (attrs->granularity < ctx->granularity)
>> +		ctx->granularity = attrs->granularity;
>> +	if (ctx->access != attrs->access)
>> +		ctx->access = AMDGPU_SVM_ACCESS_INACCESSIBLE;
>> +	ctx->flags_and &= attrs->flags;
>> +}
>> +
>> +static int attr_get_ctx_to_result(const struct attr_get_ctx *ctx,
>> +				uint32_t nattr,
>> +				struct drm_amdgpu_svm_attribute *attrs)
>> +{
>> +	uint32_t i;
>> +
>> +	for (i = 0; i < nattr; i++) {
>> +		switch (attrs[i].type) {
>> +		case AMDGPU_SVM_ATTR_PREFERRED_LOC:
>> +			attrs[i].value = ctx->preferred_loc;
>> +			break;
>> +		case AMDGPU_SVM_ATTR_PREFETCH_LOC:
>> +			attrs[i].value = ctx->prefetch_loc;
>> +			break;
>> +		case AMDGPU_SVM_ATTR_ACCESS:
>> +			attrs[i].value = (uint32_t)ctx->access;
>> +			break;
>> +		case AMDGPU_SVM_ATTR_HOST_ACCESS:
>> +		case AMDGPU_SVM_ATTR_COHERENT:
>> +		case AMDGPU_SVM_ATTR_HIVE_LOCAL:
>> +		case AMDGPU_SVM_ATTR_GPU_RO:
>> +		case AMDGPU_SVM_ATTR_GPU_EXEC:
>> +		case AMDGPU_SVM_ATTR_GPU_READ_MOSTLY:
>> +		case AMDGPU_SVM_ATTR_EXT_COHERENT: {
>> +			uint32_t flag_bit;
>> +
>> +			if (!attr_flag_type_to_bit(attrs[i].type, &flag_bit))
>> +				return -EINVAL;
>> +
>> +			attrs[i].value = (ctx->flags_and & flag_bit) ? 1 : 0;
>> +			break;
>> +		}
>> +		case AMDGPU_SVM_ATTR_GRANULARITY:
>> +			attrs[i].value = ctx->granularity;
>> +			break;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +int amdgpu_svm_attr_get(struct amdgpu_svm_attr_tree *attr_tree,
>> +			uint64_t start, uint64_t size,
>> +			uint32_t nattr,
>> +			struct drm_amdgpu_svm_attribute *attrs)
>> +{
>> +	struct amdgpu_svm_attrs default_attrs;
>> +	struct attr_get_ctx ctx = { 0 };
>> +	struct interval_tree_node *node;
>> +	unsigned long start_page, last_page, cursor;
>> +	int r;
>> +
>> +	start_page = start >> PAGE_SHIFT;
>> +	last_page = (start + size - 1) >> PAGE_SHIFT;
>> +
>> +	r = amdgpu_svm_attr_validate_range_vma(attr_tree, start_page, last_page);
>> +	if (r)
>> +		return r;
>> +
>> +	r = amdgpu_svm_attr_check_vm_bo(attr_tree, start_page, last_page,
>> +					NULL, NULL);
>> +	if (r)
>> +		return r;
>> +
>> +	mutex_lock(&attr_tree->lock);
>> +	amdgpu_svm_attr_set_default(attr_tree->svm, &default_attrs);
>> +	node = interval_tree_iter_first(&attr_tree->tree, start_page, last_page);
>> +
>> +	if (!node) {
>> +		attr_get_ctx_add(&ctx, &default_attrs);
>> +		r = attr_get_ctx_to_result(&ctx, nattr, attrs);
>> +		mutex_unlock(&attr_tree->lock);
>> +		return r;
>> +	}
>> +
>> +	cursor = start_page;
>> +	while (cursor <= last_page) {
>> +		const struct amdgpu_svm_attrs *range_attrs;
>> +		unsigned long range_last = last_page;
>> +		struct amdgpu_svm_attr_range *range = NULL;
>> +		unsigned long next;
>> +
>> +		if (node) {
>> +			range = container_of(node, struct amdgpu_svm_attr_range,
>> +					     it_node);
>> +
>> +			if (amdgpu_svm_attr_last_page(range) < cursor) {
>> +				node = interval_tree_iter_next(node, start_page,
>> +							      last_page);
>> +				continue;
>> +			}
>> +
>> +			if (amdgpu_svm_attr_start_page(range) <= cursor) {
>> +				range_last = min(last_page, amdgpu_svm_attr_last_page(range));
>> +				node = interval_tree_iter_next(node, start_page,
>> +							      last_page);
>> +			} else {
>> +				range_last = min(last_page,
>> +						 amdgpu_svm_attr_start_page(range) - 1);
>> +				range = NULL;
>> +			}
>> +		}
>> +
>> +		range_attrs = range ? &range->attrs : &default_attrs;
>> +		attr_get_ctx_add(&ctx, range_attrs);
>> +
>> +		if (range_last == ULONG_MAX)
>> +			break;
>> +
>> +		next = range_last + 1;
>> +		if (next <= cursor)
>> +			break;
>> +		cursor = next;
>> +	}
>> +
>> +	if (!ctx.has_range)
>> +		attr_get_ctx_add(&ctx, &default_attrs);
>> +
>> +	r = attr_get_ctx_to_result(&ctx, nattr, attrs);
>> +	mutex_unlock(&attr_tree->lock);
>> +	return r;
>> +}
> 

