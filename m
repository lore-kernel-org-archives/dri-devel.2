Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE91CD98DE
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 12:31:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 882C010E3D7;
	Mon, 15 Jun 2026 12:31:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O6hHU3Q8";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013026.outbound.protection.outlook.com
 [40.93.201.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3510010E3D2;
 Mon, 15 Jun 2026 12:31:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+qN1lykaLPk5PkmtrBvQqq0e8rrYdwbvt+dolb9SK/uBvM6vg8IIOwn2fk8uXYpJgtIZSGdW/du5rvfQwEcnJE9rPkz45Rq49c0fchN/nWdgUPdHoDIUDe5WazE4hAIHd2DeLyZ4MZZCsTscQJOTV7D6+voMPKcFZ5yfAa0O8z6+dj8M3wf/UwyPJ6bsJalfcFCWRCcsqfWt1rYqnbwc8tP6WdrJf200Ij8tms9ha+9be4s/cp5OYMinOWO2Hp50BIGVT9TgrMcpmyjc7ZOnpN+N0V8O5EGHulnUoea2zmk9lyaL7AXiqYHup+61tF1Zfy2HJJtB41aIT7d+EQOWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBHFD1u4Vj5na8kTz77PbPe+JC5vfoXl1lnnfuM6F74=;
 b=KnqQ5cYfqONLzG0C20j5c6wATbCbxOPOy83SQI4I1/UmEVpNedoBfzl9RpbNYjk1u3YPERI8hiqJ1TjURkhAoOkzWBV49bASkxsDzEJkqQiOeXMqLVtOa04UrPlm46s+OxjfscGuScPskrAidc0N3ci/BjifA+TS1U6w/9W/ChLzcViCFhpQf19ToiLH2eSF0HltDRO0JNaBKXrp+KB0yRuChsmsiVrALYl2JwWbGEsshKwRHV0zfrmhIhxydUVivQqUme3tQHgP9htLjwaRt0UHcxImdXKQT6c2dM/szgyHH6IZKWEpD19rg+3vfsguf5oTWzs+6s9L2MgGfOKMoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBHFD1u4Vj5na8kTz77PbPe+JC5vfoXl1lnnfuM6F74=;
 b=O6hHU3Q8kfwYrlgZdIRUrG4ByIQKPu5inzZk6fuAkagoaUjL7vuuPQHBau6n1lf5lGGLlvIbjLbOUB6Zm89bZ0FfQ7sYvwWKZz/JVL5PTLoLqExd41FUlznXmf/8pxAHbHzK4fgc1Ut576eWKg5lc+HtYNfkRKLTfozkwfBwsZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by DM6PR12MB4187.namprd12.prod.outlook.com (2603:10b6:5:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 12:31:33 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.21.0113.013; Mon, 15 Jun 2026
 12:31:33 +0000
Message-ID: <46c13593-b5e2-4b05-9c81-34d33ebb7bb3@amd.com>
Date: Mon, 15 Jun 2026 20:31:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/18] drm/amdgpu: add SVM core header and VM
 integration
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Matthew Brost <matthew.brost@intel.com>
Cc: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Jenny Liu <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>,
 Yiru Ma <yiru.ma@amd.com>, Simona Vetter <simona@ffwll.ch>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260612090928.29682-1-ray.huang@amd.com>
 <20260612090928.29682-3-ray.huang@amd.com>
 <889e580d-5ecc-4bed-b1b1-a5693692cf79@amd.com>
 <03e6e547-3c03-446e-91e7-da5b043344ea@amd.com>
 <e8ecc15d-63f2-4bd2-9fb0-1d800498c1f5@amd.com>
 <a9e22971-ec11-4b9c-937c-30d202019f1e@amd.com>
 <81ead8f8-ffa8-4f92-89ef-b016d141b371@amd.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <81ead8f8-ffa8-4f92-89ef-b016d141b371@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KUZPR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:d10:32::18) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|DM6PR12MB4187:EE_
X-MS-Office365-Filtering-Correlation-Id: c938db6a-27f0-41c2-5586-08decada0889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: hqc0VWFQBZZoQlHKAHA0mvUXVIGtS/h7k/FQh9+ZPnWO341q3hZqTILHvNLo7e5ikxKBER7W8x4iFtJ4orgwdmLqnXr7btzat85wcTUBn+16dfHybJLjoV9U+FcLH/ISlOevTA8oqhsVz5rHJSrVlCkygNEJq8gKfPtpK9gj0bXG2o5fQpFJ+Mm63rF5eobmYyJww1xItBXcps7v+xJsiL8axGFePKO7EkCmroi47j69aD0YM8/whgbiyZay80TohMqEdopqhDFHmvEgq64k7M56aoy4sLDT12kqiKy6eNF5+Se7CvRbeWVbfcyrSdcoyM7KKrToA4juxWrYG5xTNX9ygOkMHRGP86U9eW7sIQPLLBlUZEEsOcQ1nwxppRWZqhtOg/ZoSZTkQUpkOYzwNudEizfH9o3lpSozFyCi3O1vCme4tiu97K8sxsRZIItbVqjt4jogxhzRlkarbun7nJOvZgYCSovK8BKEguXEpwqw25h8DPjVO1km7KsvxehxjHxvsBTE5OuPDf5VybHozypinYZ3TyfTEJYpmnrBQap7lIosvlwVyUmy/8GaEOZPJbwQysIXe1+jj/yJST35C0vGR/iysGow6f/qw8Vxy4nTNfz2t92CqXQazMCSdlC0Z53YTrTWronggcCyDtpq5fDPDUPrxrRgE5mBluQz79M3YlQKzPlkjf5L+s4OjM84
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkQxOFk1V1VzWFVZZ2xlUytuMUF0RERmelZ0UWJlTnN3SzVvMVN4MnFwZG1G?=
 =?utf-8?B?UlprcVdiL0RCZnd0cHBSanRFYUlLT24vTTRDaWdIMk45TWR6NGtxOXp2dlNu?=
 =?utf-8?B?TGp6NDRWWkZtaHErODdtUGVZMk1rL0NJNFN1TkU4MWFoUWhheDVNRW5lVmR3?=
 =?utf-8?B?aHZtdWFoM0VkTHprcG5ZdUpvQ3ZLdm0yemlIVVJ1RGxNdW9lek5qckZzbVJk?=
 =?utf-8?B?b3BLc1lRMFJwT0NyaUlLN0k1YU1pLzVFbnZ0VjgySWFpTDMxeXV5d3BkYlFn?=
 =?utf-8?B?YllXRDYwLzBJQ0QwZWNSVi84cUh5ci9ub1RQY2xjdHlWRFBmamFabU05RC8z?=
 =?utf-8?B?Qy94OHM1Sjd6Y2hONDF0bU5QYllsZWxjQzY1a1NhNkdaMGNHbFRBVkVDTUU4?=
 =?utf-8?B?WDNXZmFPaENZendockhUS1ptMlZ0czEwWUltOVkrTGk5Rzk5UGNlc3VHUnpU?=
 =?utf-8?B?Y3VWUGtLRldGcHFacmpPbW9UbG4xemxLM3RBODdjQmtEK0hUZXhodnpmTEVT?=
 =?utf-8?B?Uk1FSWdLc2ZRMEc3Q2JNNmNGbHgvMUZZdHRXU2l6VTBGRTB3QUxwUXo0MnU0?=
 =?utf-8?B?ajRvVUJWVVJIbi9CRkdRaEtFVllYbk1lcDNZMHVSR0pvNVdRalptUFVxWjNF?=
 =?utf-8?B?SHdmalUrYmJXRHFLcVZNNFdiT0h4dFNhbDN3cVhVL3N1TzFzREg5SmNjVG1E?=
 =?utf-8?B?VkJFbHpDR0hRem5uM2dPYWZ6eE82dWdkUXhxWEk2Y2orMy9saXpBK01JM2Fv?=
 =?utf-8?B?SkVlOVB5Z1k5WlhsV2FwMEdpdzk0QlZKL2U1R3lXMW9GY0FEL2d3VlEyOU9K?=
 =?utf-8?B?ZUxNNHpYVVJGTGRYd2tnVkhpREV6enNrd2xuQXlaYzFSSVovVS9FZm1HZjBk?=
 =?utf-8?B?ODhzSXNrYUk0OE1HbEJCQm81TTg3Mjc3bUp1RTd6ZmFFdVV0VlcwVEUreVpP?=
 =?utf-8?B?WnhIamorYWNoSEJQWDM1WVFta1lOeDVGWE1yclcwSEJJNS84aWd5QXRkV1JN?=
 =?utf-8?B?YnU3NUl0SDluK3kwZ2VBNjJObGFmRzV3Z3JRWDJUR0hRbXF5R0d0OEtZUi9H?=
 =?utf-8?B?VDVwL0ljMnlZN3E0UmNnamRRQStmQXlBVG0yMnBET1orbTk4TUl1RlA5MDJr?=
 =?utf-8?B?SjF5am4wRU5PQkIvZ1c4VmpaWXFhSE01dDUxQXQ1Mks5bTN5dU1aWTJVYUtB?=
 =?utf-8?B?T2RFWkhncmJuRDlwQkF5blVsV0FNclV1MjEzVzg2K3VLZG8wRDFiRXFIc0FY?=
 =?utf-8?B?VlpvMUp4azZ3YzBOOGNKeU1sMjI1cWJ1TmluUTNIcnBiaHFPMkJqRDFCUUpB?=
 =?utf-8?B?Nkl2ODM4UkduT1R5bG52WlJ1cWU3bVpxL0R1blk4STNiT25PcEZsdnV3Vkwr?=
 =?utf-8?B?SXQzQXpYeGNwSG1mOTFFb2d3a1pNVjRMUVY4YWp0UktKVk1tYjkzQkJNd0g3?=
 =?utf-8?B?Q1ZSUi9Xa2VnL0lqS0t5dzlya25oK3pLb0xyV0thSDcvNVhzS3NnaTh4QlJJ?=
 =?utf-8?B?aUUrQnBxTVpEeVZFdFlrdlJybDRINkRBaHEvdXNMU0hhaEtOdUNrMjl2Tk5q?=
 =?utf-8?B?R0VxbmxiZktVKyt0R05oRXdQdzAwTlJDMmFqR2hrQnV4VmlXRFRhZ05WMGNl?=
 =?utf-8?B?TGVhZ21sRFZocHRUZFNGQTFXb1NuL3dLSG5CV1lGRWk4eGpaTnhoOXFPZU5t?=
 =?utf-8?B?ODJKKzA4VDBBL2F0STF6VjZnRmtsNFJZQXNDV2ZhNnJ2Mnh1WXFQc1J5RFV1?=
 =?utf-8?B?RjQ1dGwwMDE1L1FhQng5MzkwZlFacU9sSDN2eW9DSURZQ3VqUTVOTy95aFBF?=
 =?utf-8?B?OHJQdFlySGdHVWFUODRmbXdFNURvQVZRSVJ6ZkFVZDJjSkYyVFgwZ2NBMnhl?=
 =?utf-8?B?RUdiNktOYjg0MndNek45Rnh6RUdEc3VVZVNsTURPa3JuT1VVSVlzeVRib2p0?=
 =?utf-8?B?NFhFcjhMQ3FQVGdWRWNpT1F6Wk1BUWk1cXErSzFMRnczRjc0eUhiclpXbXlZ?=
 =?utf-8?B?WWEzLzFsNDd6OC9CdmsvYkhhWklEMUlWOStMRk1MZVYwR1FDbEZnSkxVUmhI?=
 =?utf-8?B?RksyWkozby94TG1TL1JYaFNmR1hxSVYvRlZzQTV1RlNWQ05sT1kwc1hvMTZY?=
 =?utf-8?B?T3orWmw0ZTZ5aENrdlRCaDlQeDZWREJmbWhXeE1FNFFsZGtCRFZDMG83ci9i?=
 =?utf-8?B?eWVtdGhYUnFkVlVaMjh2VGw0QUdTdEhlWWhhMUdhUis1bU5LZDFETiszNFpK?=
 =?utf-8?B?a3MyRjRWQjg1cnhDSmNObklQaWpMMk9FWi9jcml2TVdYVkNVNElEbVhyUG9T?=
 =?utf-8?Q?FbTn5MgtZ495GR8F+h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c938db6a-27f0-41c2-5586-08decada0889
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 12:31:33.0244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7sxCYU2sc6gwVb7oFWejwT8+XJ4ZPPElDip4FXgkg7TK8u1HCxcM1GDYHjThFNhka510ELClpVvgTcNvrBMlUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4187
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



On 6/15/2026 7:49 PM, Christian König wrote:
> On 6/15/26 11:36, Huang, Honglei wrote:
>>
>>
>> On 6/15/2026 4:08 PM, Christian König wrote:
>>> On 6/12/26 15:20, Huang, Honglei wrote:
>>>> On 6/12/2026 8:02 PM, Christian König wrote:
>>>>> On 6/12/26 11:09, Huang Rui wrote:
>>>>>> From: Honglei Huang <honghuan@amd.com>
>>> ...
>>>>>> +static inline void amdgpu_svm_assert_locked(struct amdgpu_svm *svm)
>>>>>> +{
>>>>>> +    lockdep_assert_held_write(&svm->svm_lock);
>>>>>> +}
>>>>>
>>>>> What exactly is that lock protecting?
>>>>>
>>>>
>>>> this lock is the driver_svm_lock required by the drm_gpusvm framework
>>>> It is registered by drm_gpusvm_driver_set_lock(), and drm_gpusvm lockdep asserts it on every structural entry point, e.g.
>>>> drm_gpusvm_range_find_or_insert() / drm_gpusvm_range_remove().
>>>>
>>>> Per amdgpu_svm it serializes the write/commit side against the fault
>>>> handler: range/notifier tree insert+remove, attribute changes, and the
>>>> garbage collector.
>>>>
>>>> This is the same thing xe does, in drivers/gpu/drm/xe/xe_svm.c:
>>>>
>>>> drm_gpusvm_driver_set_lock(&vm->svm.gpusvm, &vm->lock);
>>>
>>> This is clearly incorrect in that case. Our equivalent in amdgpu is vm->eviction_lock.
>>>
>>> That was already completely incorrect in the old KFD implementation, please don't use that one as blueprint.
>>
>> I really want to use vm->eviction_lock as SVM primary lock,
>> but it seems like in Xe, Xe uses vm->lock as an outer VM lock by design rwsem instead of mutex lock to broad VM ownership, not an eviction lock, they are semantically different.
> 
> No, they are actually identical in the handling.
> 
>>
>> I tried to replace the svm lock with eviction lock locally, ABBA dead lock encountered:
>>
>> amdgpu_svm_handle_fault
>>    amdgpu_svm_lock (A: eviction_lock)
> 
> That's nonsense. This lock can only be grabbed while updating the mapping range.
> 
>>      fault_map_range
>>        amdgpu_svm_range_update_mapping
>>               drm_gpusvm_notifier_lock (B)
>>
>>
>> drm_gpusvm_notifier_invalidate
>>     down_write(B - notifier_lock)
> 
> Same here. You simply can't call the VM code with the lock held.
> 
> The VM code itself must take it as appropriate.


I think the core gap is what exactly does SVM lock 
(drm_gpusvm_driver_set_lock) do in the framework

I checked xe svm, in xe_svm.c:1209:__xe_svm_handle_pagefault() the very 
first thing is:

lockdep_assert_held_write(&vm->lock);

The lock is already held on entry and stays held across the entire fault 
progress:

xe_svm_garbage_collector(vm)
xe_svm_range_find_or_insert(...)
xe_svm_alloc_vram(...) (possible migration)
xe_svm_range_get_pages(...)
xe_vm_range_rebind(...) (the actual bind)

they are not grabbed while updating the mapping range.

And the drm_gpusvm framework itself requires the driver lock to be held 
at the structural entry points:


drm_gpusvm_range_find_or_insert()
	...
	drm_gpusvm_driver_lock_held(gpusvm);
	...

drm_gpusvm_range_remove()
	...
	drm_gpusvm_driver_lock_held(gpusvm);
	...

The garbage collector and unmap paths hold the same lock in write mode:

xe_svm_garbage_collector()
	...
	lockdep_assert_held_write(&vm->lock);
	...
	__xe_svm_garbage_collector
	...

xe_svm_unmap_address_range
	
	...
	lockdep_assert_held_write
	__xe_svm_garbage_collector
	drm_gpusvm_range_put
	...

These codes indicate that this lock needs to be held on the outer layer 
to protect the data structure of SVM, rather than just during GPU mapping.

Making eviction lock the main lock of SVM will indeed block the 
functionality of SVM and also violate the design philosophyof drmgpu svm
as far as I ca see, at least I can not make the SVM functional under 
this conditions.

I am not a expert of drmgpu svm, how about ask maintainer of drmgpu svm
to ask how to use the drm_gpusvm_driver_set_lock, and can eviction lock 
be used for drm_gpusvm_driver_set_lock.

Regards,
Honglei


> 
> Regards,
> Christian.
> 
>>        amdgpu_svm_invalidate
>>           amdgpu_svm_range_invalidate
>>              amdgpu_svm_range_notifier_event_begin
>>                amdgpu_svm_range_zap_ptes
>>                  amdgpu_vm_update_range
>>                     amdgpu_vm_eviction_lock (A: eviction_lock)
>>
>>
>> the current SVM side can switch its registered driver lock at any time easily as you wish, but doing so safely is not just an amdgpu SVM local change.
>>
>> The issue is that change lock / change lock registration is easy, while lock semantics are not. SVM execution paths like fault handling, invalidation, mapping updates, garbage collection, notifier callbacks... are coupled with VM locking and update flows follow the xe svm style. If we switch SVM to a different VM lock now, we can introduce lock recursion, ABBA lock...
>>
>> SVM can technically switch lock registration now.
>> But make all stack works and pass all tests maybe needs amdgpu VM refactoring.
>>
>> Regards,
>> Honglei
>>
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>
> 

