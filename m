Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C56F89248
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 10:07:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 007DA10E877;
	Tue, 21 Apr 2026 10:07:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SWWM+yrc";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010060.outbound.protection.outlook.com [52.101.85.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FD0210E843;
 Tue, 21 Apr 2026 10:07:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JG0MLYy1qeKBIKvZ9wJtN5H5um5yHHK9FDo6z7VII6qHVee8VhEDuVIzVlbxKueEIQvu5LgO5AAJldc6KuJ66olRzyIYiP+c5gnH/aeKHWSCOI+boFZZz0APmi9E5WgJMpfkMHrRmMD1uR4SKMJPMH6ydACJCP9ulqVYaVb7j6nroPLr62/7utIB2Ju6aJCYROtKm480nEIZZFHqKmTmkJQEESQ+SCn1BA1WF/VW9LSNLdFhJVwlKZyml7hpmnG8RAZhr16SBFm+GOfsx3mcQ7TJpXCdmMfKnQ3zNcsO7NsFTtqINrFet/x1LppO9y9heJkyYf63r+UJsvmfSQOyjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SU4fXBN5oEkhWwltuUEGnr5dJ/Uhtham1G4IKp7TEAU=;
 b=ubWSPj2krxsnUBsQ15xZkNdbZKng0Ba9ajLinsk5KipqyeLKsN9hNPH6Z4UIf03ChxWXj+gHDXnB/i7HIFKsDx19qmAUcrHFvBIO3WgpWwsbo5LvF1IAb/VZqgxZgTP2cfNRmolrctGqgTFeFcIrx1kkggsJikZqCorMEKOjNK5U/Im0xdjSsWchuyT7CamtAkptovTtp5C1ne6pHAAiJcFRzJ7bjavduC/JHRJ1zeqcrIQP1pLXPA3dIkAay9fEzgfQuaOAg9bXlfID/js10sf4Ws3ok7ajYubynO1HWwZzKJA84yshyh6R4/5ptx4JT9BzYdVcI/NnVt+O89w30g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SU4fXBN5oEkhWwltuUEGnr5dJ/Uhtham1G4IKp7TEAU=;
 b=SWWM+yrcdIO4Fz7SJTaEGI0GR48Jf7LhL9cEYQGQ7395oTId9QSkg49mDxzJ2lO8QpIiA0Se7B5nJcLHOjtVZs8f21d6tMuPCIy4gqFCISGaWVmojuvm4ZVtjIdOSEmwH0n7W6SqVLLJpu0fWkYpoRTGihxMrFuEbJeJow+5qT8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by PH8PR12MB7026.namprd12.prod.outlook.com (2603:10b6:510:1bd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Tue, 21 Apr
 2026 10:07:24 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.20.9846.017; Tue, 21 Apr 2026
 10:07:24 +0000
Message-ID: <baa18b75-b79b-4f66-94fb-54c54b225a1e@amd.com>
Date: Tue, 21 Apr 2026 18:07:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 11/12] drm/amdgpu: add SVM ioctl, garbage collector, and
 fault handler
To: Matthew Brost <matthew.brost@intel.com>
Cc: Honglei Huang <honglei1.huang@amd.com>, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Christian.Koenig@amd.com, Oak.Zeng@amd.com,
 Jenny-Jing.Liu@amd.com, Philip.Yang@amd.com, Xiaogang.Chen@amd.com,
 Ray.Huang@amd.com, Lingshan.Zhu@amd.com, Junhua.Shen@amd.com,
 rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com, dakr@kernel.org,
 aliceryhl@google.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Honghuan He <honghuan.he@amd.com>
References: <20260420131307.1816671-1-honglei1.huang@amd.com>
 <20260420131307.1816671-12-honglei1.huang@amd.com>
 <aeZTLi3yoZ1ADnDO@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: "Huang, Honglei1" <honghuan@amd.com>
In-Reply-To: <aeZTLi3yoZ1ADnDO@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0032.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::20) To CY5PR12MB6430.namprd12.prod.outlook.com
 (2603:10b6:930:3a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|PH8PR12MB7026:EE_
X-MS-Office365-Filtering-Correlation-Id: 966c4697-4975-41b7-23ea-08de9f8dc817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|18096099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Z/aZxzmAtYWw/zQ9WKxB8YVSmujnL4ZcGDFCGu/mDhq8HGPEv8+xf8SLiLrAiW2nmdZEqeLhjU4tCiAfo7dZOA4CPfCUofB7sxfrMLQzLw8erLTsWK5jgdDqsjULv3HuYes+5osNBgWpYrMOWvn9bAsiZ6tsW4xWEILG1fLcgaC1zePD+rTVG/nYNFnVdzYoGiB9sJInkevmGv6ob6lIcoiElLiyTXPg6WHeM/gaXmvOxXq8B1LbLN/cUZnWs54OeQvg71KZj/dS52jDV487Mo+0cwmpvaX4ggnQXwmo+f0VBBiMQ+FHNz91PSJGdUXylB3SPEOwsRHOjl5Q67+S7Ht+jjQ7eXTDpftJELbG99JSCifowk0lVE3d4Xd6Opozar8a4cZxT8RwdJhy93wOCgoB/34MNGTYwf7vufJgvFBimlAxaG2HTsWyTm7jA+NVR4pGF4hb27REDBw7z9oxhSbhIQi45WCAK7xOtLIzBkxQmZWp8pPg9NM3H+h3S/ID5qt+JuPSh0KLqqxdHAqX3UM9xVgaTUC5DtyPnH3p0+CPeOcXc684eJozeTGNq8/oSy/d24gUCAM+jRXGLuhDeOOnRk+D7iE6F8xUekCRQM25q8d96HPt7LQLF6BC+vXt6HMMuDhMktdX8Uv3K/jp4VqWHKDVVie7qjjCLJRPRuedU9cD/QB3+Wt6RxgmhM1xUp0ohJC0EMy/Ep6t/bmwi7yl3ERK3ohxSt2ce7jdC0U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18096099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWVvaVp5OU8wK3BtRnRJYmlhVzRybjllcWZkRnB3elp3empocmc4YWw3OTdz?=
 =?utf-8?B?U0NPbndrNit4TzJ0amhZY1ZNY0YvT21UR053ZUJId0JQVU5GUXdmVWh6RGhP?=
 =?utf-8?B?QU5aK1lWSnF3K1BSRnFtSnM2em5pL05QN0JsTHI2Wk1NSWRsa1M2cU4yQ2pt?=
 =?utf-8?B?V09zSHd5alBzN2xadzN4N0FJcXFNZnJrMHQraWFrdDVUbmNOakkveXcrUVEy?=
 =?utf-8?B?MGZZc0h1Rk96ai9JdkJOdnNPYWFlRjM0TFN4bndKSHFLODVpOUNjU2twekxo?=
 =?utf-8?B?NTE5R0ZBUlc4OTl0Mzgwbk1QTVNhS21PcUtxZUdZcWlqaFNsRHNTQ04zdWd6?=
 =?utf-8?B?blR3Z0c1NGt5V1Y2ZWVkOWVMTTB0Y2xoUjlUWlVYUTdXUnhId2pLb0pldVU3?=
 =?utf-8?B?SnByNTc0T3hsVktjT0NYc3NQd2lCbjAvYVMrNWE2WGM5L0VISjUwSXdkeEFO?=
 =?utf-8?B?aEV4L1kvTDZUV2tKSWY1QUZraW9mTlRwcnlQL1hkOTFGZTl5UTZYbU05Lzg0?=
 =?utf-8?B?U1gvKzRXcC9WaTE0ZHNOT0Q2czVXaGwyaGc3ekt3bjhxeDQ3T0lndEQzWkFW?=
 =?utf-8?B?UzVtKzlob1B3TjF5UnhMTlYwUnhSdVVoQ2hHQlZhOUptK1FmOUVwb3loV1FP?=
 =?utf-8?B?ajV6N3JjRFdWcDRhS2I4WWRMVk12dUkva2xORnQ0MlIxNU54UjF4Zi9aUHZw?=
 =?utf-8?B?L1VrcmRsUGJBaWJBR1FybEVGRXR6aHhVZStsOTBISmc4V0h3MGc3VFZJUndN?=
 =?utf-8?B?VjB2bk9CWUoyL05kazc5VU1jcG9zWGQrbnorMHEwOHBmamJaYkIvVER5alF6?=
 =?utf-8?B?RmZiUnFVU1QwajZnNjdFZDhTTmVlUkNnWGJOckFsOGJqVU04N2RrMVVzZE9q?=
 =?utf-8?B?ZWN6Y3Q2QUVVTU9IUHc3Zzlsem9rUkVmcjZ5dDE3RTJrVVRjc3loOC9ZWThU?=
 =?utf-8?B?Nks5WnZlNzFNYVMxaVNOVCtPN2hBRFMzcjJCY3lEU1RtQ0xxUEdlcEJhSXNF?=
 =?utf-8?B?VC84WUw1eis4RXhNdjBCbFpqVnFHNnNpK2pOa2NMbGtnREY1LzdiK1c3ZHpM?=
 =?utf-8?B?NG5iZ3N3V3NlRGliUHF6b1FpWnNPVnc1bXFRM2U5YVJxQS9ONHM0MS9uclNO?=
 =?utf-8?B?N3hoOU1kSldZSzM3VC9PYnBKV0pncmxrcTZkZHRscEdNUEx4YUN0dG5zcTlh?=
 =?utf-8?B?Tm5zbFIzbldrR3NQUGFLRklkeGVlZ2dRdkd0Qnl2ajFmdW9KeG1RZ0ZOczMx?=
 =?utf-8?B?ZHJzc3A3R3dhUDJQVEZZNVhKbE4xNDlCTmZUazQyU1I0U01jdWowQ3NNOTNw?=
 =?utf-8?B?YXhiTTF5OFUrQlJ1NmJZTlc0OVZNNTd4NkQyeW15SksxSTBUcWdqTmR5Yy9o?=
 =?utf-8?B?MzduSll4RjNaVU9rWkRMdHpmNjhiRnFzZWZnNkF5MUs5R0lweGZrK0k4SC8z?=
 =?utf-8?B?UU1DTjBrOXBHVDN2ZVprTmR5eXVzd3JXbkJtZ0pWcWt6TWFNVXdHZ3gxa0RP?=
 =?utf-8?B?Rm5vS0JXdVNrUVNmYVFla0lCNWI5akVpL2dZdkk0MmFhNnBWM3ZkUEhJZVhQ?=
 =?utf-8?B?YzJVbHdNUDNzQUFyUUlyblV2cTZJMHkwOC9HV1IxZjNiWlNPcVd4MEF0clcw?=
 =?utf-8?B?d2cyb1ZPRmJNTVlqM1F5TFIxemMxS05uQlpFRU1uY1l1aVpKR0ZmZTltZ01R?=
 =?utf-8?B?WlRZTCtVVjVQRDIrYUpybmRORjdjL1JWQ294a25oVHRTRzhzdUZPbmg4aGVO?=
 =?utf-8?B?R29mRGRXRnNGaUVqb2p0ZmJiRDVoajhvT1B5Z1hzVitLZlFSUHJQcHFZMEFl?=
 =?utf-8?B?Y2RrWDJXQmhPUzhURTBzRUlhdWZDTXM3Vkp2MHVJRTZPY0g2VFpPNjZlVVpw?=
 =?utf-8?B?a0hJWkUrZkk3M1RLK3RUR3J0RjJIS0hEQmFhT2hnNXM1UzZsNkVuTFJMQjNa?=
 =?utf-8?B?YzNlaUtCVEZ3UHFpNkNicUM3Y1owSnBGcjMrVVZRZHlIYUFWbi9kRk5zQTZt?=
 =?utf-8?B?RFdWOHhlMkhtaVFPVklOWi9HeldaZ2I3c1Q2OCtVclAxOEc1Q1I0KzRnNDFP?=
 =?utf-8?B?OHFEK1ZLSTBPREpmYUZFay9oaUx0RHhNc0E0U1lvbEREcUZCMFhpRVcxdlpz?=
 =?utf-8?B?NGhLbThWRG9NOUVjSTlvc1RiNlNtYkRFUHNxaU0vMjA0MW9tSTcvRWRVMWVP?=
 =?utf-8?B?elRXSTlkaWxvRUlpZjZMTHhXcEgydGI0RnVJR1QrNi9SL0JuMHJiZDdSRDNi?=
 =?utf-8?B?aGtnaG1Eak5KSG53ZHBqVE1tRWcvdENVWkNqWERpWktoWG1UNzI1ZG9lUmVB?=
 =?utf-8?Q?Yq4Jj7uxtxL+NvJU3B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 966c4697-4975-41b7-23ea-08de9f8dc817
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 10:07:24.3520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vqs9sx0aIrS6nZLNHasG3Hh25XYDcINiZgFTNEZD4MtSUqGaJy7pKIJmUgNi5iaGgQI1v0VKjBZXIQ+tTXF2fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7026
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



On 4/21/2026 12:24 AM, Matthew Brost wrote:
> On Mon, Apr 20, 2026 at 09:13:06PM +0800, Honglei Huang wrote:
>> From: Honglei Huang <honghuan@amd.com>
>>
>> Add the ioctl entry point and garbage collector to amdgpu_svm.c,
>> and introduce amdgpu_svm_fault.c and amdgpu_svm_fault.h as a
>> dedicated fault handler module.
>>
>> Ioctl (amdgpu_svm.c):
>> - amdgpu_svm_copy_attrs(): copy and validate user attribute array
>>    from userspace with size and alignment checks
>> - amdgpu_gem_svm_ioctl(): handle DRM_AMDGPU_GEM_SVM dispatching
>>    to SET_ATTR or GET_ATTR with copy_to_user for GET results
>>
>> Garbage collector (amdgpu_svm.c):
>> - amdgpu_svm_garbage_collector(): dequeue and remove GC-listed
>>    ranges under svm_lock, clear corresponding attributes
>> - amdgpu_svm_range_clean_queue(): batch cleanup for dequeued
>>    work items
>> - amdgpu_svm_garbage_collector_work_func(): GC work handler
>> - amdgpu_svm_gc_init/fini/flush(): lifecycle management for
>>    the GC workqueue
>>
>> Fault handler (amdgpu_svm_fault.c):
>> - AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING: 2ms dedup threshold
>> - amdgpu_svm_range_get_unregistered_attrs(): derive default
>>    attributes for faulting addresses without explicit registration,
>>    using VMA properties and GPU IP capabilities
>> - svm_check_fault_allowed(): validate fault access against
>>    attribute permissions and read-only enforcement
>> - amdgpu_svm_range_map_fault(): core fault mapping that finds or
>>    creates a gpusvm range, gets pages, maps into GPU page tables,
>>    retries on -EAGAIN up to 3 times
>> - amdgpu_svm_handle_fault(): main entry called from
>>    amdgpu_vm_handle_fault(). Looks up SVM by PASID, acquires
>>    mmap_read_lock and svm_lock, runs garbage collector, resolves
>>    attributes from the tree or derives defaults, uses timestamp
>>    deduplication to skip stale faults, dispatches to map_fault
>>
>> Fault header (amdgpu_svm_fault.h):
>> - Forward declarations and amdgpu_svm_handle_fault() prototype
>>
>> Signed-off-by: Honghuan He <honghuan.he@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       | 149 +++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c | 368 ++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h |  39 ++
>>   3 files changed, 556 insertions(+)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
>> index 5fbed9b9f..a672deede 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
>> @@ -316,3 +316,152 @@ bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm)
>>   	return vm->svm != NULL;
>>   }
>>   
>> +static int amdgpu_svm_copy_attrs(const struct drm_amdgpu_gem_svm *args,
>> +					   struct drm_amdgpu_svm_attribute **attrs,
>> +					   size_t *size)
>> +{
>> +	if (!args->nattr || args->nattr > AMDGPU_SVM_MAX_ATTRS)
>> +		return -EINVAL;
>> +	if (!args->attrs_ptr)
>> +		return -EINVAL;
>> +
>> +	*size = args->nattr * sizeof(**attrs);
>> +	*attrs = memdup_user(u64_to_user_ptr(args->attrs_ptr), *size);
>> +
>> +	return PTR_ERR_OR_ZERO(*attrs);
>> +}
>> +
>> +int amdgpu_svm_garbage_collector(struct amdgpu_svm *svm)
>> +{
>> +	int ret;
>> +	struct amdgpu_svm_range_op_ctx op_ctx;
>> +
>> +	lockdep_assert_held_write(&svm->svm_lock);
>> +
>> +	spin_lock(&svm->work_lock);
>> +	while (amdgpu_svm_range_dequeue_locked(svm, &svm->gc.list, &op_ctx)) {
>> +		spin_unlock(&svm->work_lock);
>> +
>> +		if (UNMAP_WORK(op_ctx.pending_ops)) {
>> +			ret = amdgpu_svm_attr_clear_pages(
>> +				svm->attr_tree, op_ctx.start_page, op_ctx.last_page);
>> +			if (ret)
>> +				return ret;
>> +
>> +			drm_gpusvm_range_remove(&svm->gpusvm,
>> +						&op_ctx.range->base);
>> +		}
>> +
>> +		amdgpu_svm_range_put_if_dequeued(svm, op_ctx.range);
>> +		spin_lock(&svm->work_lock);
>> +	}
>> +	spin_unlock(&svm->work_lock);
>> +	return 0;
>> +}
>> +
>> +void
>> +amdgpu_svm_range_clean_queue(struct amdgpu_svm *svm,
>> +			     struct list_head *work_list)
>> +{
>> +	struct amdgpu_svm_range_op_ctx op_ctx;
>> +
>> +	spin_lock(&svm->work_lock);
>> +	while (amdgpu_svm_range_dequeue_locked(svm, work_list,
>> +				    &op_ctx)) {
>> +		spin_unlock(&svm->work_lock);
>> +		amdgpu_svm_range_put_if_dequeued(svm, op_ctx.range);
>> +		spin_lock(&svm->work_lock);
>> +	}
>> +	spin_unlock(&svm->work_lock);
>> +}
>> +
>> +static void amdgpu_svm_garbage_collector_work_func(struct work_struct *w)
>> +{
>> +	struct amdgpu_svm_gc *gc = container_of(w, struct amdgpu_svm_gc, work);
>> +	struct amdgpu_svm *svm = container_of(gc, struct amdgpu_svm, gc);
>> +
>> +	down_write(&svm->svm_lock);
>> +	amdgpu_svm_garbage_collector(svm);
>> +	up_write(&svm->svm_lock);
>> +}
>> +
>> +int amdgpu_svm_gc_init(struct amdgpu_svm *svm)
>> +{
>> +	svm->gc.wq = alloc_workqueue(AMDGPU_SVM_GC_WQ_NAME,
>> +					WQ_UNBOUND | WQ_HIGHPRI | WQ_MEM_RECLAIM, 0);
>> +	if (!svm->gc.wq)
>> +		return -ENOMEM;
>> +
>> +	INIT_LIST_HEAD(&svm->gc.list);
>> +	INIT_WORK(&svm->gc.work, amdgpu_svm_garbage_collector_work_func);
>> +
>> +	return 0;
>> +}
>> +
>> +void amdgpu_svm_gc_fini(struct amdgpu_svm *svm)
>> +{
>> +	flush_work(&svm->gc.work);
>> +	amdgpu_svm_range_clean_queue(svm, &svm->gc.list);
>> +	destroy_workqueue(svm->gc.wq);
>> +	svm->gc.wq = NULL;
>> +}
>> +
>> +void amdgpu_svm_gc_flush(struct amdgpu_svm *svm)
>> +{
>> +	flush_work(&svm->gc.work);
>> +}
>> +
>> +int amdgpu_gem_svm_ioctl(struct drm_device *dev, void *data,
>> +			 struct drm_file *filp)
>> +{
>> +	struct amdgpu_fpriv *fpriv = filp->driver_priv;
>> +	struct amdgpu_device *adev = drm_to_adev(dev);
>> +	struct drm_amdgpu_gem_svm *args = data;
>> +	struct drm_amdgpu_svm_attribute *attrs = NULL;
>> +	struct amdgpu_vm *vm;
>> +	size_t attrs_size = 0;
>> +	int ret = 0;
>> +
>> +	AMDGPU_SVM_TRACE("ioctl op=%u va:[0x%llx-0x%llx)-0x%llx nattr=%u\n",
>> +			 args->operation, args->start_addr, args->start_addr + args->size,
>> +			 args->size, args->nattr);
>> +
>> +	vm = &fpriv->vm;
>> +	if (!amdgpu_svm_is_enabled(vm)) {
>> +		ret = amdgpu_svm_init(adev, vm);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	if ((args->start_addr & ~PAGE_MASK) || (args->size & ~PAGE_MASK))
>> +		return -EINVAL;
>> +
>> +	if (!args->start_addr || !args->size)
>> +		return -EINVAL;
>> +
>> +	ret = amdgpu_svm_copy_attrs(args, &attrs, &attrs_size);
>> +	if (ret)
>> +		return ret;
>> +
>> +	switch (args->operation) {
>> +	case AMDGPU_SVM_OP_SET_ATTR:
>> +		ret = amdgpu_svm_set_attr(vm, args->start_addr, args->size,
>> +					 args->nattr, attrs);
>> +		break;
>> +	case AMDGPU_SVM_OP_GET_ATTR:
>> +		ret = amdgpu_svm_get_attr(vm, args->start_addr, args->size,
>> +					 args->nattr, attrs);
>> +		if (!ret && copy_to_user(u64_to_user_ptr(args->attrs_ptr),
>> +					 attrs, attrs_size))
>> +			ret = -EFAULT;
>> +		break;
>> +	default:
>> +		ret = -EINVAL;
>> +		break;
>> +	}
>> +
>> +	kvfree(attrs);
>> +	return ret;
>> +}
>> +
>> +#endif /* CONFIG_DRM_AMDGPU_SVM */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
>> new file mode 100644
>> index 000000000..968fb402b
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
>> @@ -0,0 +1,368 @@
>> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
>> +/*
>> + * Copyright 2026 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a
>> + * copy of this software and associated documentation files (the "Software"),
>> + * to deal in the Software without restriction, including without limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +
>> +#include "amdgpu_svm.h"
>> +#include "amdgpu_svm_attr.h"
>> +#include "amdgpu_svm_fault.h"
>> +#include "amdgpu_svm_range.h"
>> +#include "amdgpu.h"
>> +#include "amdgpu_vm.h"
>> +#include "amdgpu_gmc.h"
>> +#include "amdgpu_ih.h"
>> +
>> +#include <drm/drm_exec.h>
>> +#include <drm/drm_gpusvm.h>
>> +
>> +#include <linux/delay.h>
>> +#include <linux/mm.h>
>> +#include <linux/sched/mm.h>
>> +
>> +#if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
>> +
>> +#define AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING	(2UL * NSEC_PER_MSEC)
>> +
>> +static int amdgpu_svm_range_get_unregistered_attrs(struct amdgpu_svm *svm,
>> +					    unsigned long fault_addr,
>> +					    unsigned long attr_start_page,
>> +					    unsigned long attr_last_page,
>> +					    struct amdgpu_svm_attr_range **out)
>> +{
>> +	struct amdgpu_svm_attr_tree *attr_tree = svm->attr_tree;
>> +	struct amdgpu_svm_attr_range *range;
>> +	struct amdgpu_svm_attrs attrs;
>> +	struct mm_struct *mm = svm->gpusvm.mm;
>> +	struct vm_area_struct *vma;
>> +	unsigned long fault_page = fault_addr >> PAGE_SHIFT;
>> +	unsigned long start_page, last_page;
>> +	unsigned long vma_start_page, vma_last_page;
>> +
>> +	amdgpu_svm_attr_set_default(svm, &attrs);
>> +
>> +	mmap_read_lock(mm);
>> +
>> +	vma = amdgpu_svm_check_vma(mm, fault_addr);
>> +	if (IS_ERR(vma)) {
>> +		mmap_read_unlock(mm);
>> +		AMDGPU_SVM_ERR("get_unregistered_attrs: invalid VMA for fault_addr=0x%lx\n",
>> +		       fault_addr);
>> +		return PTR_ERR(vma);
>> +	}
>> +	vma_start_page = vma->vm_start >> PAGE_SHIFT;
>> +	vma_last_page = (vma->vm_end >> PAGE_SHIFT) - 1;
>> +
>> +	if (vma_is_initial_heap(vma) || vma_is_initial_stack(vma))
>> +		attrs.preferred_loc = AMDGPU_SVM_LOCATION_SYSMEM;
>> +
>> +	mmap_read_unlock(mm);
>> +
>> +	start_page = max(vma_start_page,
>> +		    (unsigned long)ALIGN_DOWN(fault_page, 1UL << attrs.granularity));
>> +	last_page = min(vma_last_page,
>> +		   (unsigned long)ALIGN(fault_page + 1, 1UL << attrs.granularity) - 1);
>> +
>> +	start_page = max(start_page, attr_start_page);
>> +	last_page = min(last_page, attr_last_page);
>> +
>> +	mutex_lock(&attr_tree->lock);
>> +	range = amdgpu_svm_attr_range_alloc(start_page, last_page, &attrs);
>> +	if (!range) {
>> +		mutex_unlock(&attr_tree->lock);
>> +		return -ENOMEM;
>> +	}
>> +	amdgpu_svm_attr_range_insert_locked(attr_tree, range);
>> +	mutex_unlock(&attr_tree->lock);
>> +
>> +	AMDGPU_SVM_TRACE(
>> +		"Created unregistered range for fault_addr=0x%lx: attr range=[0x%lx-0x%lx] size: 0x%lx attrs={preferred_loc=%d, prefetch_loc=%d, flags=0x%x, granularity=%u, access=%u}\n",
>> +		fault_addr, amdgpu_svm_attr_start_page(range),
>> +		amdgpu_svm_attr_last_page(range) + 1,
>> +		amdgpu_svm_attr_last_page(range) -
>> +			amdgpu_svm_attr_start_page(range) + 1,
>> +		range->attrs.preferred_loc, range->attrs.prefetch_loc,
>> +		range->attrs.flags, range->attrs.granularity,
>> +		range->attrs.access);
>> +
>> +	*out = range;
>> +	return 0;
>> +}
>> +
>> +static int svm_check_fault_allowed(struct amdgpu_svm *svm,
>> +				   unsigned long fault_addr, bool write_fault)
>> +{
>> +	struct mm_struct *mm = svm->gpusvm.mm;
>> +	struct vm_area_struct *vma;
>> +	unsigned long requested = VM_READ;
>> +	int ret = 0;
>> +
>> +	if (write_fault)
>> +		requested |= VM_WRITE;
>> +
>> +	mmap_read_lock(mm);
>> +	vma = vma_lookup(mm, fault_addr);
>> +	if (vma && (vma->vm_flags & requested) != requested) {
>> +		AMDGPU_SVM_ERR("fault addr 0x%lx no %s permission\n",
>> +			 fault_addr, write_fault ? "write" : "read");
>> +		ret = -EPERM;
>> +	}
>> +	mmap_read_unlock(mm);
>> +
>> +	return ret;
>> +}
>> +
>> +static int amdgpu_svm_range_map_fault(struct amdgpu_svm *svm,
>> +			       unsigned long fault_addr,
>> +			       const struct amdgpu_svm_attr_range *attr_range,
>> +			       bool write_fault)
>> +{
>> +	const struct amdgpu_svm_attrs *attrs = &attr_range->attrs;
>> +	bool devmem_possible = amdgpu_svm_attr_devmem_possible(svm, attrs);
>> +	bool need_vram_migration = amdgpu_svm_attr_prefer_vram(svm, attrs);
>> +	devmem_possible = false; /* TODO: add migration */
>> +	struct drm_gpusvm_ctx map_ctx = {
>> +		.read_only = !!(attrs->flags & AMDGPU_SVM_FLAG_GPU_RO),
>> +		.devmem_possible = devmem_possible,
>> +		.check_pages_threshold = devmem_possible ? SZ_64K : 0,
>> +		.devmem_only = need_vram_migration && devmem_possible,
>> +		.timeslice_ms = need_vram_migration && devmem_possible ? 5 : 0,
>> +	};
>> +	struct amdgpu_svm_range *range;
>> +	ktime_t timestamp = ktime_get_boottime();
>> +	uint64_t range_pte_flags;
>> +	int retry_count = 3;
>> +	int ret;
>> +
>> +	lockdep_assert_held_write(&svm->svm_lock);
>> +	WARN_ON(!svm->xnack_enabled);
>> +
>> +retry:
>> +	ret = amdgpu_svm_garbage_collector(svm);
>> +	if (ret) {
>> +		AMDGPU_SVM_ERR(
>> +			"fault garbage collector failed: ret=%d, fault_addr=0x%lx\n",
>> +			ret, fault_addr);
>> +		return ret;
>> +	}
>> +
>> +	ret = svm_check_fault_allowed(svm, fault_addr, write_fault);
>> +	if (ret)
>> +		return ret;
>> +
>> +	range = amdgpu_svm_range_find_or_insert(svm, fault_addr,
>> +						 attr_range, &map_ctx);
>> +	if (IS_ERR(range)) {
>> +		ret = PTR_ERR(range);
>> +		AMDGPU_SVM_ERR("map_fault: range_find_or_insert failed: fault=0x%lx ret=%d\n",
>> +				 fault_addr, ret);
>> +		/*
>> +		 * -EINVAL: fault_addr out of gpusvm range, or no chunk size
>> +		 *          fits within VMA/notifier/attr_range bounds.
>> +		 * -EFAULT: mmget_not_zero failed.
>> +		 * -ENOENT: No VMA at fault_addr.
>> +		 * -ENOMEM: Notifier or range allocation failed.
>> +		 */
> 
> Just a drive-by comment: as we’re getting to multiple users of GPU SVM,
> and each driver is making decisions based on the error codes returned by
> the common layer, it may be time to update the GPU SVM kernel
> documentation to clearly define what each return code means for every
> call.
> 
> There may also be some inconsistency in the return codes due to the
> ad-hoc nature of how this evolved. If we need to clean up any return
> values, this is probably something we should do now—before we end up in
> a situation where we change a return value and then have to fix multiple
> drivers.
> 
> Please let us know if, while you’re working in this area, you notice any
> GPU SVM return values that don’t make sense or could use adjustment.
> 
> Matt
> 

Agreed, the handling of return values in faults is somewhat important, 
and I am not sure if I have encountered all the situations. Here are 
some that I have encountered, and some that I speculated based on the 
code. I will inform you if there are any places that need improvement.

Regards,
Honglei

>> +		if (ret == -EFAULT || ret == -ENOENT) {
>> +			AMDGPU_SVM_ERR("no vma or mm is dying: 0x%lx, ret=%d\n",
>> +					 fault_addr, ret);
>> +			ret = 0;
>> +		}
>> +
>> +		return ret;
>> +	}
>> +
>> +	if (ktime_before(timestamp, ktime_add_ns(range->validate_timestamp,
>> +					 AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING))) {
>> +		AMDGPU_SVM_TRACE("already restored, skip: fault=0x%lx range=[0x%lx-0x%lx)\n",
>> +				 fault_addr, drm_gpusvm_range_start(&range->base),
>> +				 drm_gpusvm_range_end(&range->base));
>> +		goto out;
>> +	}
>> +
>> +	range_pte_flags = amdgpu_svm_range_attr_pte_flags(
>> +					svm, attrs, map_ctx.read_only);
>> +
>> +	if (!(write_fault && map_ctx.read_only) &&
>> +	    amdgpu_svm_range_is_valid(svm, range, attrs, range_pte_flags)) {
>> +		AMDGPU_SVM_TRACE("valid range, skip: fault=0x%lx range=[0x%lx-0x%lx)\n",
>> +				 fault_addr, drm_gpusvm_range_start(&range->base),
>> +				 drm_gpusvm_range_end(&range->base));
>> +		goto out;
>> +	}
>> +
>> +	AMDGPU_SVM_RANGE_DEBUG(range, "PAGE FAULT");
>> +	/* TODO: add migration*/
>> +
>> +	AMDGPU_SVM_RANGE_DEBUG(range, "GET PAGES");
>> +	ret = amdgpu_svm_range_get_pages(svm, &range->base, &map_ctx);
>> +	if (ret == -EOPNOTSUPP || ret == -EFAULT) {
>> +		/*
>> +		* -EOPNOTSUPP  Mixed page types within range.
>> +		* -EFAULT      (a) mm is dying.
>> +		*              (b) range was unmapped.
>> +		*              (c) DMA mapping failed.
>> +		*              (d) devmem_only requested but system page encountered.
>> +		*              (e) hmm_range_fault: no VMA, page fault error, bad pte/pmd.
>> +		* -EBUSY       HMM retry loop timed out.
>> +		* -ENOMEM      PFN or DMA address array allocation failed.
>> +		* -EINVAL      hmm_range_fault: invalid VMA type.
>> +		*/
>> +		map_ctx.timeslice_ms <<= 1;
>> +		if (!map_ctx.devmem_only && --retry_count > 0) {
>> +			AMDGPU_SVM_ERR("start retry: get_pages failed with %d, retries_left=%d: fault=0x%lx range=[0x%lx-0x%lx)\n",
>> +					 ret, retry_count, fault_addr,
>> +					 drm_gpusvm_range_start(&range->base),
>> +					 drm_gpusvm_range_end(&range->base));
>> +			goto retry;
>> +		} else {
>> +			AMDGPU_SVM_ERR("map_fault: get_pages failed with %d, devmem fallback allowed, but no devmem pages: fault=0x%lx range=[0x%lx-0x%lx)\n",
>> +					 ret, fault_addr, drm_gpusvm_range_start(&range->base),
>> +					 drm_gpusvm_range_end(&range->base));
>> +		}
>> +	}
>> +
>> +	if (ret == -EPERM) {
>> +		AMDGPU_SVM_ERR("get_pages -EPERM: fault=0x%lx range=[0x%lx-0x%lx)\n",
>> +			       fault_addr, drm_gpusvm_range_start(&range->base),
>> +				       drm_gpusvm_range_end(&range->base));
>> +		return ret;
>> +	}
>> +
>> +	if (ret) {
>> +		AMDGPU_SVM_RANGE_DEBUG(range, "PAGE FAULT - FAIL PAGE COLLECT");
>> +		goto out;
>> +	}
>> +
>> +	AMDGPU_SVM_RANGE_DEBUG(range, "PAGE FAULT - GPU MAP");
>> +
>> +	ret = amdgpu_svm_range_update_mapping(svm, range,
>> +					      range_pte_flags, attrs->flags,
>> +					      false, false, false);
>> +
>> +	if (ret)
>> +		goto err_out;
>> +
>> +out:
>> +	return 0;
>> +
>> +err_out:
>> +	if (ret == -EAGAIN && --retry_count > 0) {
>> +		map_ctx.timeslice_ms <<= 1;
>> +		AMDGPU_SVM_RANGE_DEBUG(range, "PAGE FAULT - RETRY GPU MAP");
>> +		goto retry;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +int amdgpu_svm_handle_fault(struct amdgpu_device *adev, uint32_t pasid,
>> +			    uint64_t fault_addr, uint64_t ts,
>> +			    bool write_fault)
>> +{
>> +	struct amdgpu_svm *svm;
>> +	struct amdgpu_svm_attr_range *attr_range;
>> +	unsigned long attr_start_page, attr_last_page;
>> +	unsigned long fault_page;
>> +	uint64_t ckpt;
>> +	int ret;
>> +
>> +	fault_addr = fault_addr << PAGE_SHIFT;
>> +	fault_page = fault_addr >> PAGE_SHIFT;
>> +
>> +	svm = amdgpu_svm_lookup_by_pasid(adev, pasid);
>> +	if (!svm) {
>> +		AMDGPU_SVM_ERR("handle_fault: no SVM context for pasid %u\n", pasid);
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	if (atomic_read(&svm->exiting)) {
>> +		AMDGPU_SVM_ERR("handle_fault: SVM context is exiting for pasid %u\n", pasid);
>> +		ret = -EAGAIN;
>> +		goto out_put;
>> +	}
>> +
>> +	if (!svm->xnack_enabled) {
>> +		AMDGPU_SVM_ERR("handle_fault: SVM context does not have xnack enabled for pasid %u\n", pasid);
>> +		ret = -EOPNOTSUPP;
>> +		goto out_put;
>> +	}
>> +
>> +	ckpt = READ_ONCE(svm->checkpoint_ts);
>> +	if (ckpt != 0) {
>> +		if (amdgpu_ih_ts_after_or_equal(ts, ckpt)) {
>> +			AMDGPU_SVM_TRACE(
>> +			"handle_fault: draining stale retry fault, drop fault 0x%llx ts=%llu checkpoint=%llu\n",
>> +				fault_addr, ts, ckpt);
>> +			amdgpu_gmc_filter_faults_remove(
>> +				adev, fault_addr >> PAGE_SHIFT, pasid);
>> +			ret = 0;
>> +			goto out_put;
>> +		} else {
>> +			WRITE_ONCE(svm->checkpoint_ts, 0);
>> +		}
>> +	}
>> +
>> +	down_write(&svm->svm_lock);
>> +
>> +retry:
>> +	mutex_lock(&svm->attr_tree->lock);
>> +	attr_range = amdgpu_svm_attr_get_bounds_locked(svm->attr_tree,
>> +						       fault_page,
>> +						       &attr_start_page, &attr_last_page);
>> +	mutex_unlock(&svm->attr_tree->lock);
>> +	if (!attr_range) {
>> +		ret = amdgpu_svm_range_get_unregistered_attrs(svm, fault_addr,
>> +							      attr_start_page,
>> +							      attr_last_page,
>> +							      &attr_range);
>> +		if (ret) {
>> +			if (ret == -EFAULT)
>> +				goto out_no_vma;
>> +			goto out_unlock;
>> +		}
>> +	}
>> +	ret = amdgpu_svm_range_map_fault(svm, fault_addr, attr_range,
>> +					 write_fault);
>> +
>> +	if (ret == -EAGAIN) {
>> +		AMDGPU_SVM_ERR("handle_fault: got -EAGAIN: fault=0x%llx\n",
>> +			       fault_addr);
>> +		amdgpu_gmc_filter_faults_remove(adev, fault_addr>>PAGE_SHIFT, pasid);
>> +		goto retry;
>> +	}
>> +
>> +	goto out_unlock;
>> +
>> +out_no_vma:
>> +	AMDGPU_SVM_ERR("handle_fault: no VMA for fault=0x%llx (stale retry or GPU NULL deref)\n",
>> +		 fault_addr);
>> +	ret = 0;
>> +
>> +out_unlock:
>> +	up_write(&svm->svm_lock);
>> +
>> +out_put:
>> +	amdgpu_svm_put(svm);
>> +	return ret;
>> +}
>> +
>> +#endif /* CONFIG_DRM_AMDGPU_SVM */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h
>> new file mode 100644
>> index 000000000..1c8f6c15e
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h
>> @@ -0,0 +1,39 @@
>> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
>> +/*
>> + * Copyright 2026 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a
>> + * copy of this software and associated documentation files (the "Software"),
>> + * to deal in the Software without restriction, including without limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +
>> +#ifndef __AMDGPU_SVM_FAULT_H__
>> +#define __AMDGPU_SVM_FAULT_H__
>> +
>> +#include <linux/types.h>
>> +
>> +struct amdgpu_device;
>> +struct amdgpu_svm;
>> +struct amdgpu_svm_attr_range;
>> +struct amdgpu_svm_attrs;
>> +
>> +int amdgpu_svm_handle_fault(struct amdgpu_device *adev, uint32_t pasid,
>> +			    uint64_t fault_addr, uint64_t ts,
>> +			    bool write_fault);
>> +
>> +#endif /* __AMDGPU_SVM_FAULT_H__ */
>> -- 
>> 2.34.1
>>

