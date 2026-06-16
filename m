Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA258CD98D2
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 05:38:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 277A410E82C;
	Tue, 16 Jun 2026 05:38:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5t30PuYb";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010069.outbound.protection.outlook.com [52.101.85.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81C7110E82C;
 Tue, 16 Jun 2026 05:38:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1uxdiUrz1ia4hCo8CcX+r3gjEPCpA46yNBt2+D33kob27IlozzEWyTJ8pZJvGCc1QxRk0FkxSET9JrgQVYGvZyFycDmFqfKQDWX2e16/bv4XI9bYk8wCWzvVMY6UQKnUij00ZOOyb7J18PrBwHTWeXYCpvraZvgERoIhRwt/ONIqVC0RPoCpyv20BR3NBpAhpKWMh8HLgVdo94aqhZ3Nn1wnJVf9HYO9b79JKdlR+PtYjQy/Iqn5uxM5zWvvd9xs/8GF74ArlOTDzijJZZZzUzgRb+3d+uasDLDHC47uaGf9mJebRW7dh/ES0OF3rngpwGnw+Ez1uDv7I55/aU2sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMAcMsttEjDa0an9H88MLupeyoqJIAcPf7eXmXPYTuw=;
 b=SD7rBkhPPdmbJ3IBcyTSEtD00NXg9sHj54qDo3KYgHcquL5wsloRoN1DqVWIGVGZdo9yJVcJvn3DhhybB1JpwHSj/WgzTH4M4VMVy8i8LRVZTz8iMNXDjy3TE2Zmv40X18VMeSMYl4Q+kYbkdYMuLvB+Hsm4NGbLk/gXXDukcLO/EQxROyA9Fq6btUYHYeGcRnByc0G2JgADVQAn4bC2v95/9Sq+/pRQf/HqTHjTHQb3Uhnzpz4L5Cb4IghgqdGjSoLChvJXhDd34yEffg5gWYnh6/Pz3XSpkv7K+CmdpZUTjbwD6JKzt5hIWewkKGbWJElEqXlfH9JjKsiin6H6ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMAcMsttEjDa0an9H88MLupeyoqJIAcPf7eXmXPYTuw=;
 b=5t30PuYbcecbnOgEPg8CX7/ezCnI9H1/jA9vEv2vJ/tbxtJMdD8EUTkLqyiCF7x2V8wmkZtsyt4BDSg9Xx47nbHD9jeMymenIxSaw34Pq/H7KAeanJugmP8FL1Ba2e8YPT7dQmDQ4mM+EU68AB5mJprwMPcS3vMSaTuBaUodamY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by IA1PR12MB6649.namprd12.prod.outlook.com (2603:10b6:208:3a2::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 05:38:03 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.21.0113.013; Tue, 16 Jun 2026
 05:38:02 +0000
Message-ID: <b26cb241-5b2f-44d4-95d1-bd127ad3847f@amd.com>
Date: Tue, 16 Jun 2026 13:37:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/18] drm/amdgpu: implement SVM range GPU mapping core
From: "Huang, Honglei" <honghuan@amd.com>
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
 <20260612090928.29682-8-ray.huang@amd.com>
 <7d073e2b-0a7c-4e42-a67d-32817596d238@amd.com>
 <2a93e0a5-dd7b-4d63-ba1b-3d24d1b59a27@amd.com>
 <1622273f-ab4f-427c-979b-833d0045d6c6@amd.com>
 <729ab423-4903-4079-bc54-9196278b473a@amd.com>
Content-Language: en-US
In-Reply-To: <729ab423-4903-4079-bc54-9196278b473a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:4:186::21) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|IA1PR12MB6649:EE_
X-MS-Office365-Filtering-Correlation-Id: 0203b015-0332-46a5-6684-08decb696ec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|4143699003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: PzxsRKMgMfYrHZQ67LFrPqDEMV4lgftQgUT2/UB0eZIPzt0cpykqBA6wMeOZ8cqqhre4IOWq7bsU1N6vTN8nuHhoQa5hQb6TCyIq36DTXMTqtIiGg86s7MVXv6W0V8vhDTPf9Hb15aq/DE6d4qZQv9cn7zFHQreo1VTgz1UaZ+O83nbwCcJ2RUmok8ywB+AugOPM8HoJe+ipPVaZCstdyUU9cFXtEj8v/OezCWTwyxBiUyaBB1/MnS+u0fOYjNjb1A81K4lq3HIo9e9exsTwiQQ3eYV9GL3BihsdDDoJ2Eq0obP7VnigDUrtIllvgcOlTzG9rVGITtG+ajH+BQ7v4hT5uayER9V3svaWLCRxu2Ko2WK3WL/K1tdPnNTJ+FStqwRv/ROtiWNlbMMg9sV1TdFKrIMBYLxVhxScpvpB5OmD03chpdryEnBzrEWpiVrI4iF9ErO6VRy7Z56/8WucDkB+2ayQfHCZDN8p5+CMx8NOyKlukK9CX5HcqePzCwdxyKCXPtc7ymMKfudZLWePp79Nk38rVtecTo5CZVMHli+luwedQHK3XWpQnzd3JaS2p/m1iebdFgpHwJkAVg6MtOI67RgBQjP+psrneP9er2J2+BumrZJvOBXsL38RcpkUFEMfVKBQHLUPsKb2i9X4HJh6XVLJ89Ob90caxu6aEkQWX0hAwyhatqyWTrZy+ODd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(4143699003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clRFTWtodFFQS2ZJWEQyVk9mUHBpZlFUZHhFS3VjZlE3YnBkZDlIakgzcCtR?=
 =?utf-8?B?QVdYN2VIR0tUeFFHaWFrbk42UzNFd1lab0Vwa2VYdnFZMVFrNGVwdUl1TXBO?=
 =?utf-8?B?VkxzUW5VTmRNOE5CK2JLamhKZWpPS3lDc3QzcWNwb3V1cDJ1cDB6Uy9EVkpE?=
 =?utf-8?B?S1ZyM0xJcXRyKzhaOCtOMERHcE5GZ1BpRTNnOFQ2VG1MUDNtS0dlVXdSYmQz?=
 =?utf-8?B?dStrRi80elBjazkyYVA5T1NBYmMzckJsbUk4bS9Ua1RLQlp4SWd2cEVnVnhY?=
 =?utf-8?B?T0JVRWdvVUwrZlhMV3lPbTVtWVR5WHZKYlpVZXQxTjlaKzV3MFNUOENqSVhu?=
 =?utf-8?B?TkRNM2taaDdCenhFUXl0UzA3T083V2w3R0JrLy9BajUvUHYvQnJKaUtoMWNh?=
 =?utf-8?B?cnpYU2hocmJTaU5NVFZzSXRwQVRwYmF1UmljWVIrMlpUc3oxbDgyaVMwOEhz?=
 =?utf-8?B?TnA5U3RzdHBhNDk4U0pDcy9RNkVNbkhiRzMybFlXV2hKOVBKUFRvRlZ2dFEr?=
 =?utf-8?B?NGhqLzE0ay9MbkNvL1dYWG1TaWxyVnhJN2lrZ1RHcU5iMkFEWTNJT0NuYXJY?=
 =?utf-8?B?ZTlPbWpKMHRQOWh3czAvc0ZSUDdBTzdsTkNUeXhGZENsS2RJMGdzY0g5VE1x?=
 =?utf-8?B?VWtZQ09iOFhuTzRYc2taa2YwOTFjOTBveGhxeTZ2Z1QxUEY1UkZLWkhsQ0du?=
 =?utf-8?B?R0FMbDRWL3lEWU4raUdHcnBrc1VuZ0NJbkhxYW1Hbk5yd20vMmlrTzQxL2lv?=
 =?utf-8?B?ZjJuNnk5V3VVMUtDaDhPK2oyVjFIL29sa0JQVVNwQklGZm8wTDFNdnc0dk93?=
 =?utf-8?B?d3d0aGUwYW1JTld6L1RHSEpBTHlhMEFUckt3M2lKY0pnYlc4bGdHN1ViWXlW?=
 =?utf-8?B?eXlEejhGb0oyekNHVmhPVkE1WkZsQmppNGVIQmpIbnpkNFFHbm9PaXE3MGk3?=
 =?utf-8?B?andqQWE3d0Fkb3NGaGtUSnhWK0ZkT3VuWEhpeGNGeW5abXJLa01VRkV6MEEw?=
 =?utf-8?B?MVdhbkpYb21lamxoZFNRRys4ZmRLTzF0ZlRqTVJpVTFTQy9UblBQbW9EcnVx?=
 =?utf-8?B?MklER0hLeU0zemxhTHdwNVBTMWxJTW5abWVEVlk1SDcwM2xVR0FBamF6c2ho?=
 =?utf-8?B?Yitob1d3RU1RT2JKVDBVa1lFRy9UQm9PKzJVbFFickZLZVZaQ0Irc0x2bVFO?=
 =?utf-8?B?K2IxL2FpV0xYU2gvWU5oU1AxZGNpSXRRbVF1dktBTGtIQWJhNzRQeW9HR2s0?=
 =?utf-8?B?ZGtmNTk5R2FyTFJZY2NrVmtmdytXT3g0QkVIbVNCZkRNZkpGOHNtbmJtdWJM?=
 =?utf-8?B?UTJ4ZndHNXNjTFlWdGZoSGUxeEVVYWxkQmxaOXFrbWR5eGZON1ZlZTl2L1Uy?=
 =?utf-8?B?L1ZBb2tWc3BTNXAvbkozbjRLbGF6bTBLVlpXOWNyenY1YjRMcFp2OU5WRmEw?=
 =?utf-8?B?OSsxWml1YlFvdHo4Y0pzazZXTElBSW1aZ21LOGxkU2RMYVgyRVdOU1UwbGVk?=
 =?utf-8?B?UGM5UFBZUmxPbi9IVit5UlQ0ZHc0dUlpTUlIeEw5UGRkbWdFWEErQXM2UUY4?=
 =?utf-8?B?eVpxZ0MrVDErTlhINjArL29mczJCQmRJN2wyaWNyU2gxODRDUmhFWllGSGlq?=
 =?utf-8?B?dlo0aGh4T1Y1UkVzcFM4alNiYUFxM2FtUmgwQlhGenNybVpSV1licDJZdWQv?=
 =?utf-8?B?WnRWUFFpZUNHV3E4YnJOSE9EeUJXNmJVcU93M0VpSXdIVjlHUlgxRkhvMjcw?=
 =?utf-8?B?c3JLcTRmV2ZlcExKTW5ZQStueGFpYnJqSGhNdEt3MkQvRUk5bVRpR2pjdk42?=
 =?utf-8?B?U2FDRm1yTGJPTjVWcmtBUk1RcnQzRVBWRytrUUF0OWFDV0d4S2xmUkNGcHdZ?=
 =?utf-8?B?cHhiREcwL2tYamRWNVovWUc0OVdkRUY0blFWNHhqVk41UEUwTnpmOExzRUNp?=
 =?utf-8?B?L1RlcGI2RnR4aFp5UXU5SXNOMmlWd3ZoWTNDTjFDOVJtbkVHT0NXOUR2bDBR?=
 =?utf-8?B?bzBnUCtqMjVCS0pBZ3I5WWliWTJnYW1YazhuYlBHZ1VRSVVjTWpreU1xaU50?=
 =?utf-8?B?WGdhMmdqbDRFNVZUdkhWOURqaC8xbGVJK2NrL25UNFR0a25qRW5OQnlya0dp?=
 =?utf-8?B?OG1PamZrK1RCVXBxOFZzbjFzK3NNT0Vva0tETmRDU2hEOEZVMnBsMER4cHpi?=
 =?utf-8?B?Y1RuRVFJaTY4TXVhOW9SMW9JVnNTb3FoMFhlVndKWWJ3KzV4RHhleExFZUxU?=
 =?utf-8?B?Q090UHRVS2JMY2NaOUhiSjhHSHlMQzNTMUs3ZnNIMmZldG94dTVFYkRpVTNk?=
 =?utf-8?Q?E1NxkmtFatYzOtK/O3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0203b015-0332-46a5-6684-08decb696ec2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 05:38:02.8201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FFlppYd1WtSEGlcs4Y4KhApQDt9sj1SoJ0GuledYjjxsmRMjsjZoH51r+GKO5mcpn8lx4n6qIxKunK0yt2bLow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6649
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



On 6/16/2026 10:14 AM, Huang, Honglei wrote:
> 
> 
> On 6/15/2026 7:21 PM, Christian König wrote:
>>
>>
>> On 6/12/26 17:07, Huang, Honglei wrote:
>>>
>>>
>>> On 6/12/2026 8:21 PM, Christian König wrote:
>> ...
>>> On the SVM and BO overlap issue: if planning to mirror xe is acceptable?
>>
>> I'm not sure yet but I don't think so.
>>
>> We have a mixture of engines which can do page faults (3D, SDMA) and 
>> engines which can't (multimedia).
>>
>> We most likely will need a way to completely separate the mapping from 
>> each other.
>>
>> Maybe lower address range for SVM mappings and higher one for BO 
>> mappings? But IDK if that will be sufficient for ROCm.
>>
> 
> Yeah, I agreed with you, and it seems like xe use a place holder in bo 
> tree to avoid the BO and SVM overlap.
> 
> I have remove the previous overlap check, cause it is a defensive check 
> so zero impact on functions. Will use the check method you raised when 
> it is done in amdgpu vm.
> 
> Regards,
> Honglei
> 

Hi Christian,

thanks again for the thorough review. I fixed the code locally, and the
series is ready and addresses comments from the last round.

1.  amdgpu_svm.h: dropped the AMDGPU_SVM_KMEM_CACHE_* macros; SVM ranges use
     plain kzalloc()/kfree().

2.  amdgpu_svm.h: dropped the flush_tlb callback; amdgpu_svm_flush_tlb() is
     called directly.

3.  amdgpu_svm_attr.h: added kerneldoc for the interval tree and list.

4.  amdgpu_svm_attr.c: dropped the attr slab cache; uses kzalloc()/kfree().

5.  amdgpu_svm_attr.c: squashed the types header into its implementation 
patch

6.  amdgpu_svm_attr.c: renamed the local "flags" to "unsupported_vm_flags".

7.  amdgpu_svm_attr.c: dropped amdgpu_svm_attr_validate_range_vma() from the
     fault path; hmm_range_fault() covers it. A lighter sync check is 
kept only at the
     set/get attr ioctl entry for fix regression.

8.  amdgpu_svm_range.h: AMDGPU_SVM_RANGE_DEBUG removed, replaced by a 
tracepoint.

9.  amdgpu_svm_range.h: dropped the UNMAP_WORK macro.

10. amdgpu_svm_range.c: the fast range valid check is now lock free.

11. amdgpu_svm_range.c: zap_ptes always drains the fence regardless of the
     update return value.

12. per IP PTE flags: moved the switch out of the SVM core into
     gmc_v9_0.c / gmc_v12_0.c behind a new gmc_funcs->get_svm_pte_flags()
     callback.

13. eviction_lock: drm_gpusvm  framwork's limitation blocks using the 
eviction_lock
	Kept as is.

14. SVM/BO overlap: dropped the scan-based amdgpu_svm_attr_check_vm_bo() 
helper.

15. This series has been rebased on top of the amdgpu vm fix.


Please let me know if there are any remaining review comments. And the 
follow up features xnack-off support, multi GPU, all build directly on 
this code, and they are much easier to develop incrementally once there 
is a stable baseline to build on rather than a moving out of tree base. 
So please point out anything else you'd like addressed.

Regards,
Honglei


>> Regards,
>> Christian.
>>
>>>
>>> And maybe need some modificaitons in amdgpu vm, may I know the next 
>>> step/design?
>>>
>>> Regards,
>>> Honglei
>>>
>>
>>
> 

