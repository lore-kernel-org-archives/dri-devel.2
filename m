Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E430FF886D
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 20:00:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F48610E8F5;
	Mon, 27 Apr 2026 20:00:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ALnXr+uT";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010043.outbound.protection.outlook.com [52.101.201.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4BCE10E8F5;
 Mon, 27 Apr 2026 20:00:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hfXsQzeEM8IXQryte31+cvjwNx5AMtJ9nCnP8Sobjj3fJkZrBvzho3x9IvvwdEJlD5JOE9TOS6jpfrDtWW4bUgZcWW9GTzCon4gc0dc0hZkQT+cMrGqvIZ8GOY/fvvij2WHypAEIqY0ZWB5q6Dt89h6VvtyIIEMnrHb+y9h/qavF3DLG7C4HyGrMbQ1/bGfcmuQqJL7QVVa3elUVSj3+cjFj5cxT1xQ+U9dn5ci6VYha4UEIoRm1WhdTNlHK85NcAc7EIiq7bNcEosw3VwhBpAfdgZ9hOoYAsakiNgiLESSSdQVHQFWP9U/FK6JI09Z/ftGCegcLDKRZCl9sgkA0hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vj+GU6m0bcUImM6Vj/Zt8wPi0I15nocrwqlQT4PLSzo=;
 b=jYoxofGaUVUw8/R96NZKtfM0Ru/faf5uPA8DzREWLhq6/kLRnQfX8XapWv5TiqnXnnT0aobRp6a9uPfsgQ6NrtoAC+xWlpV543cvkFfK2AZ0PJJuxr8CfL1ODv+UyGGDJ3JW6OeHYjf+gh/LuCWj766FPAu3usk8l+m4ZtIZS+SS4l4XMl9D0fj9GvGSs/zChrc4pR+OKcbA2ogP4k8vFaXdDliApVhqtiWQ5HOzaYvkb67OsOQq6auJcR/4oois10CRhIPeSlNdfYi9PizmeX/e3OJvY/R2nX0vC1VwUskafqbIn0y6k5W2ZQqsa7Xcs3qXomW8fguRaiZNcYh7XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vj+GU6m0bcUImM6Vj/Zt8wPi0I15nocrwqlQT4PLSzo=;
 b=ALnXr+uTyDXfR07RRf0m0IxWoZWBFlzciPbEN6ZRAxnxl6MhMrEr99Ni43Dpzrpm/jmkE0XvQ73Bf/Lc/xXjTxxSp9v7zHCg+jXk4ZrDhXHiiFUm8jeQ6Wy5m0RcCTssaoNRLTEwg+nCzcwkb4nz8fhOwB1bB7dGpzJuX1Ws3gI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by SA6PR12MB999200.namprd12.prod.outlook.com (2603:10b6:806:450::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 20:00:43 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::d977:95c9:e89:ff27]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::d977:95c9:e89:ff27%6]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 20:00:43 +0000
Message-ID: <66a7efd4-8ec9-47af-b6c4-5be25459a474@amd.com>
Date: Mon, 27 Apr 2026 16:00:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/POC PATCH 00/12] POC SVM implementation in AMDGPU based on
 drm_gpusvm
To: "Huang, Honglei1" <honghuan@amd.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Honglei Huang <honglei1.huang@amd.com>,
 Oak.Zeng@amd.com, Jenny-Jing.Liu@amd.com, Philip.Yang@amd.com,
 Xiaogang.Chen@amd.com, Ray.Huang@amd.com, Lingshan.Zhu@amd.com,
 Junhua.Shen@amd.com, =?UTF-8?Q?Thomas_Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>
References: <abuE0KBPtAZM9Bo0@lstrano-desk.jf.intel.com>
 <098d5d68-f218-4cee-8b73-201e7012a287@amd.com>
 <acDeRhCTh/ehOUyu@lstrano-desk.jf.intel.com>
 <26186168-abff-4ce4-ad93-db9bc2fd68d7@amd.com> <acRgr7QwdULsn6G2@gsse-cloud1>
 <d2fddc5d-2628-47e3-95c5-874b3a0466be@amd.com>
 <5fb57768-35b9-4e48-8178-2e1760a93aed@amd.com>
 <aem++OfFRJqHAPTG@gsse-cloud1.jf.intel.com>
 <aenH0REel7/enRi+@gsse-cloud1.jf.intel.com>
 <812102ac-906b-4fbf-bc8c-1881493a3eca@amd.com>
 <aep/S6m7vG5K7Ra9@gsse-cloud1.jf.intel.com>
 <79e9730b-80b5-4517-9942-fb6ec1569276@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <79e9730b-80b5-4517-9942-fb6ec1569276@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0144.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::44) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|SA6PR12MB999200:EE_
X-MS-Office365-Filtering-Correlation-Id: 17662974-cbb4-4cfd-9141-08dea497a956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: nfloivDL6+EG3Dt9nUZkYHSBTXViPrtnV/G8e0Uz3aNpjaByWPAgBiwI8lkcMKNR9aAIJcHnOxHuj8ijKTAm+ND5cC1AJxzipuyQKyRlCILItjTwismJ3SFEiWWVxUPUYn6artxQlTvP+LR8JMjnn6Scl9dIrGkDjwAcwn+E1AAwQK7eOV/FHVKpLxrG9WcYwSLUrmgDmFaGcMEUHTe2gapdpgf1NGBUeptL/ankSn6Ug41bkjaXjHrvIg0XjHcNTf/kUK6aGQlPV0E3QSx3V2BpUaNjq/s4CTbqbOwOlC1odAHTY+BNcfHQagYHE4r7ydQFzVOUodyfeyT1W/kUVqPtOm2xNItnnpfU5bgGE1hBolf1MDYwAIFr/yGCQUgITM89NKTTJuHeABwFdj8PaH6cN63rZWTh1CtOzqXujOMI+zTqmE7WaXcsWvwzQDCHl1F8zQMJRDGNkP6/QvfhiDTVh9/fKvEIMALQH1vXIrjW/oaI23hWySIPXkPu4fxG+i44CosssC9nMphe9MHDdqgQI/q4bqnlhstRefp/5Ti8j02hEExjv4afVEX1KMVJkJ9/Pp470BQlSN6pvwCXA16xmodBzVBCrfiRfkBxRF3Jz1u4A0Q/bGtndTwBIGMK/AIVLOuTgf/Km2hGWHlO5JQIxEKbVqMn4a97jP8d/nt1R5pNsdXILDM/oILu1aov
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rm5acTVIaUdmYzRlcUs3S1ZOVjJndU1hSERSKy9SdmRacHRRRjZjTnJnVjdn?=
 =?utf-8?B?bXNrVTlQaWVsZ0lOOGdUbjBMY0dIc1dteitIaU1Eby9CTkxyNUdOYkQyZVpI?=
 =?utf-8?B?YTMxaGs1RVRqVGMwNkp5NEc0aVhrV2plK0V2SnNnWGNrMWFmNmxDZDFwUWpk?=
 =?utf-8?B?d2FKb0xoZ2ZFTHdNVFRFMXBDengvVXNDUnBmYUcvV2tlMUVlaUdXZ29td2F1?=
 =?utf-8?B?QW9iZVAxekZ0ZGh2RHlEeWpJQ1hDT1pETkkvcVlFTEZucVc2ODFxUVg4Tmtz?=
 =?utf-8?B?N011RFN3YllRYjBhM2MvTHB5MS9TVnh1K0FkUHVZRzNKTTlLYkZSY1ZZM00z?=
 =?utf-8?B?a2ZuLzAxYU4vZXZUMUdoUjNjZ0FGd1BVZ1dJbDdHSG5VR09SWWNtVWhmdW8y?=
 =?utf-8?B?MkFjeUF2TjJNN0Y4RFJRWjlFN1hrY2ZRcEJqQThOaFRGVlVCVm5aWXR6aC9P?=
 =?utf-8?B?MVhwZ3hadFVXcGk0cFZ4N2ZEVkcvaWVBTkV4ckFyMW92RzlqaWdoVllIY2V5?=
 =?utf-8?B?Q002TnpLeUpZZzRiZW5WdFJTdzFBVzB1UzZDRStSd3lZR1RxUDJXV0J3Zk5K?=
 =?utf-8?B?K1pnaGpaQlZoakliNklOaWJqaUpSN21VcWQ3dnMwdkVwWmtBRUpnSjZmQS92?=
 =?utf-8?B?VnFSMVFFMjdJdkRHNWhjQWJLbXA0Qlh4WjVVSGN3YXVKbm8rbnY4eEV3RlE0?=
 =?utf-8?B?QldDQkQzMmptdjhkNHlnN0ROc3NtYlZrZUhubm13cU1sdTBVY3hWODlVNlpw?=
 =?utf-8?B?MjVVVFdUaE8rR3FuOUl2b1lUNFA0dllGcWJacXo4SmFtREZhSXBZc0N1TXNs?=
 =?utf-8?B?dGJEU2JMNDlMbk5HT3BvWGhQOWN0NWpvK1pINHFRVmlJK1N4SkdtQkljV1Rh?=
 =?utf-8?B?VDdOb3I3TWFaQ0NTSDhEVk1haEZwbEtuUEZBUTZvOFY1NlJrMUMzVnFIajdL?=
 =?utf-8?B?UDErOVlqSVRvUU96TmwyZUdYNG9UUU84cE1wTkcxTDZ6Z0JZemdHaURvemc5?=
 =?utf-8?B?YWJQcWpjOUY5ZkNKdXpveGM4a28rUnRGYXI1VGhjbGlzWGltZFBJcUErK1Ra?=
 =?utf-8?B?WFJYNjc3bUdOUGRKOXk5OUtkODlSNW5Fb05rbDQyUytDSlpmUDJ3MTZQQjNm?=
 =?utf-8?B?dmJTalFFQitadFRBbE0xR0NFUERia3g0NjhyUG15dWhuWjlGa0J1WUxDQjcw?=
 =?utf-8?B?U3g3blpEMUg3RUFzc0R3RFJsbmlXcWJzMTFwVHduRzdxWFFqTGY2Tklvakpw?=
 =?utf-8?B?aE45Y3lpRGZCMGpXVUYwdGNVRkxFZVBZQXIvYlRtYi9jbHEyUjllMUFYSklw?=
 =?utf-8?B?RjNZZFJZVzNZc0VySVNmU093dDhGVDJCRXRtRDYwaHRRWU1mZGMxYWsxREpB?=
 =?utf-8?B?d0pmZ2lGNEt5QWliWFRlbXRHeGNocCtsekpPUGhSZEVMbjI4ZjU4SnF0dFVK?=
 =?utf-8?B?NHptQzFPMlVzL2pocTRORXV6VmdnVW10VnlOUlBpZUZEdUI0cUVFeTloNW5J?=
 =?utf-8?B?QXRFa1RKL2xQeUdTd3ZZS2NMQzJOM3VJekl1ZHVvVXpvUG8zNWFpTWZ6NkNP?=
 =?utf-8?B?VjhseXNiMVpzN2x5SWM3N25Gd1pyUnM1YzVJL296U2pEL2s2UGU1b0F5dmFs?=
 =?utf-8?B?aVBjeVZnSnBNcEx3WUEzUWFkQU8rVGliUGd6d3BiRHFIOEEzRUloVEF3WDcv?=
 =?utf-8?B?U1Rib0tvaHZDSDNpeUc3Rjl4d1N0VXR2TklIRURKamZSTk5VeU5YN1pPODZI?=
 =?utf-8?B?MlhCeVZDb1FMKy9IeThwc3l5RmlqMi9oa3Y2L1pyNG44ekY1R2FSWlpMdDFw?=
 =?utf-8?B?OVBkRElQeWFRZzhWMERsU2VVRGVJWWNkNFdZMWY0cFFGWldDNWJBUzdYZEF6?=
 =?utf-8?B?ZnVDTXA4dk9wUkw4cmtGUWdHMnd0NTNtVWN2VkRYYU9IcWJUT252ckxuQWFG?=
 =?utf-8?B?Q0loVDNFakM1dlQyb0pXc3ArMUxuSHIwK3B6cUlaeGZrczNlMkU2amc4R3pZ?=
 =?utf-8?B?RW44V2wyeHZBRXFyVktPajBta0tDaXc4VHovVzQxNzc0TmRlQnJMa0oyR2dS?=
 =?utf-8?B?WEpuUkt3K3RXek1mUTJsNUdrNmd0RnhWZU1HWkZYQUpaUWZndUlRUS9mR2R0?=
 =?utf-8?B?dmJoTm9MLyt2YUdyY2IvV3lSaWpNRE9xWGhWWWZ5THBWYWRTUTBZcEkwREdQ?=
 =?utf-8?B?VmN5WittMzRCcHNmWlIrUGZOVVI2MFc0QVpSWEJEMDQ1NWxGZC82TFdnMGto?=
 =?utf-8?B?Y2JoY3hCUVZaUWh1d2x4c05rb0ZIOG1wZDl5a2dpNElrc1drZjRYNnRZUkhN?=
 =?utf-8?B?QUtBN0JWN2tVQ0JtS2pZR2VWR2hCZXJnWmF3UXpkRnZreTM4QVdJUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17662974-cbb4-4cfd-9141-08dea497a956
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 20:00:42.6363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Mf0JlsLWSg1LU0NJm/tp8ABbTFCYaBn/jRsRqahYCWgGLnI21BlFOJegcI8RRrl+sw97EcJlMB3j+V0t7QK5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR12MB999200
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


On 2026-04-24 06:43, Huang, Honglei1 wrote:
>
>
> On 4/24/2026 4:21 AM, Matthew Brost wrote:
>> On Thu, Apr 23, 2026 at 07:03:52PM +0800, Huang, Honglei1 wrote:
>>>
>>>
>>> On 4/23/2026 3:18 PM, Matthew Brost wrote:
>>> ...
>>>>>>>>>> This clarifies a lot. This is what we’d call in Xe 
>>>>>>>>>> “preemption fence”
>>>>>>>>>> mode for a VM. Anytime memory is moved, we trigger a GPU 
>>>>>>>>>> preemption and
>>>>>>>>>> resume. We don’t actually support SVM in this case; instead, 
>>>>>>>>>> we use
>>>>>>>>>> “userptr binds,” which are built on gpusvm for page
>>>>>>>>>> collection. However,
>>>>>>>>>> we don’t support migrating memory to the device—though we could.
>>>>>>>>>>
>>>>>>>>>> I’d look at how we converted 'userptr' to be based on GPU SVM 
>>>>>>>>>> [2]. In
>>>>>>>>>> this case, don’t maintain a range tree, as those—as you
>>>>>>>>>> suggest—are more
>>>>>>>>>> of an on-demand fault driver concern. Instead, just embed 
>>>>>>>>>> 'struct
>>>>>>>>>> drm_gpusvm_pages' in the VMA struct defined by the IOCTLs..
>>>>>>>>>>
>>>>>>>>>> We could extend this to support migrating 'userptr', but we
>>>>>>>>>> just haven’t
>>>>>>>>>> done that yet—this may be what you want to do in “XNACK off..
>>>>>>>>>>
>>>>>>>>>> [2] https://patchwork.freedesktop.org/series/146553/
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Actually we need to swith the xnack mode between on and off, so
>>>>>>>>> in xnack off
>>>>>>>>> mode, the driver operats in "implicit  prefetch mode". This may
>>>>>>>>> be due to
>>>>>>>>> compatibility with older hardware and the need for UMD 
>>>>>>>>> runtime. We will
>>>>>>>>> further discuss the handling method under xnack off internally.
>>>>>>>>>
>>>>>>
>>>>>> Hi Matt,
>>>>>>
>>>>>> I studied the xe_userptr code and the conversion series [2] you
>>>>>> pointed to.
>>>>>>
>>>>>> I have a question that:
>>>>>> Would it be possible to reuse drm_gpusvm_range to handle the 
>>>>>> hardware
>>>>>> without gpu fault feature(xnack off mode).
>>>>>
>>>>> That’s not how we’ve done it. We embedded drm_gpusvm_pages into 
>>>>> our VMA
>>>>> structure and then attached a notifier. The notifier attachment is
>>>>> open-coded on the Xe side, and this could be normalized and opened up
>>>>> for common driver use cases.
>>>
>>> The way in xe_userptr likes the implementation in kfd_svm: embeded 
>>> physical
>>> pages into structure and attach same size notifier.
>>> But kfd_svm is an implementation of SVM semantics, which supports 
>>> partial
>>> unmap, doesn't need explicitly delete userptr ioctl calling when 
>>> remove ,
>>> and doesn't need a explicitly userptr flag when creating.
>>> And actually there is also a existing implementation for userptr 
>>> semantics
>>> in amdgpu kfd: KFD_IOC_ALLOC_MEM_FLAGS_USERPTR.
>>> If the no gpu fault mode can not use the drm gpu svm fram work, use 
>>> the same
>>> way for xe_userptr, it seems like doing the duplicate work.
>>>
>>> I think the core gap is we are trying to use the drmgpu_svm to 
>>> implement a
>>> SVM semantics driver for no gpu fault hardware instead of userptr 
>>> semantics.
>>>
>>>>>
>>>>> The problem with reusing drm_gpusvm_range directly is that a VMA may
>>>>> span multiple gpusvm notifiers—i.e., it can be larger than the 
>>>>> notifier
>>>>> size. Of course, we could rework this as well.
>>>
>>> So the "VMA spans multiple gpusvm notifiers" concern: I'd like to 
>>> clarify
>>> that this is not actually a blocker for amdgpu's XNACK-off path, 
>>> because
>>> amdgpu does not try to represent one user ioctl virtual address 
>>> interval as
>>> a single drm_gpusvm_range.
>>>
>>> we walk the attr interval and call drm_gpusvm_range_find_or_insert()
>>> repeatedly, letting gpusvm pick chunk aligned ranges bounded by
>>> notifier_size. One ioctl interval will create N chunk sized ranges.
>>>
>>>>>
>>>>
>>>> Sorry for the double reply—I just glanced at the latest series. I 
>>>> don’t
>>>> think creating a range per page of the userptr is desirable. While it
>>>> would work, from a time-complexity point of view I don’t think this is
>>>> ideal.
>>>>
>>>> The issue with spans across multiple notifiers is real, though.
>>>>
>>>> My rough idea would be:
>>>>
>>>> - Give drivers an interface to create larger ranges.
>>>
>>> So maybe we do not need to create larger ranges if we call
>>> drm_gpusvm_range_find_or_insert() repeatedly.
>>>
>>
>> That will be functional, but consider it from a time-complexity point of
>> view.
>>
>> Multiple ranges increase the time complexity of range-tree searches.
>> This isn’t a huge deal, but it will show up to some extent.
>>
>> Multiple ranges will also slow down DMA mapping and migration. We
>> switched over to the dma_iova_alloc/link/unlink/sync uAPI here [1].
>> While dma_iova_link is a relatively fast radix-tree walk, the allocation
>> and sync steps are where things get expensive. Therefore, it is
>> advantageous to perform these steps as few times as possible. For
>> example, if your SVM buffer is 512MB, instead of doing these steps 256
>> times, you do them once. The same logic applies to the migrate_vma_*
>> functions—they are quite expensive, so doing them in a single shot is
>> significantly faster.
>>
>> The same applies to invalidations. If you can invalidate a large range
>> in a single shot, it will be faster. Although the logic in the notifier
>> should be able to zap multiple ranges in one shot (Xe does this), having
>> to DMA-unmap a single large range will still be faster than multiple
>> smaller DMA unmaps.
>>
>> The TL;DR is if your driver knows size of SVM allocation upfront (e.g.,
>> an IOCTL tells you the size) it makes more sense to use a single large
>> struct (either embedded drm_gpusvm_pages into a VMA or we figure out an
>> interface to insert large ranges / notifiers).
>>
>> [1] https://patchwork.freedesktop.org/series/160587/
>>
>>>>
>>>> - If the range fits inside a single notifier’s size → done.
>>>>
>>>> - If the range spans multiple notifier sizes → round up to a power of
>>>>     two and create a larger notifier. This may overlap with existing
>>>>     notifiers, which is likely fine given that interval trees support
>>>>     overlaps (?). We’d need to double-check and test this. If 
>>>> overlapping
>>>>     notifiers are not acceptable, we’d need some heavy-handed 
>>>> notifier merge
>>>>     logic—it will be complicated, but isolated, so once we get it 
>>>> right
>>>>     everyone can use it.
>>>
>>> If we call drm_gpusvm_range_find_or_insert() repeatedly the 
>>> drmgpu_svm will
>>> create the corresponding notifier correctly as far as I can see.
>>>
>>
>> I agree this will be functional but not ideal. You can always start the
>> approach you have here and optimize it later by adding the required
>> support in GPU SVM.
>>
>
> Hi Matt,
>
> Really thanks for your information, this really helps a lot!
>
>
> Hi Christian, Felix,
>
> According to the discussion with Matt on the previous thread, I'd like 
> to align with you on the XNACK off direction before start to the series.
>
> According to the information form Matt:
> when the allocation size is known doing one big operation is
> significantly faster than doing many small ranges, because
> the allocation and sync steps are where things get expensive.
> Doing them in a single shot is significantly faster, especially in the
> situlation of xnack off mode, which needs pre fault and pre map in 
> ioctl, and the size is known.
>
> It is confirmed that repeatedly calling 
> drm_gpusvm_range_find_or_insert() is
> functional, and suggested we land it first and optimize later by adding
> large range support in GPU SVM core. That motivates the two phase plan 
> below.
>
> Phase 1
> - Reuse drm_gpusvm_range for XNACK-off, one ioctl interval is split by 
> drm_gpusvm_range_find_or_insert() into
>   N chunk-sized ranges bounded by notifier_size, same mechanism as the 
> fault path.
> - populate all ranges at ioctl / submit time instead of on fault.
> - Invalidation -> GPU queue stop -> rebind/restore the pages and gpu 
> map ->restore queue
>
> Phase 2:
> Add a large range / large notifier insert interface in GPU SVM core
> so one ioctl interval maps to a single range to improve efficiency.
> This needs modify the drmgpu_svm frame work.
>
> May I know your thoughts on this plan?

I think drm_gpusvm_range_find_or_insert already has all the parameters 
necessary to allocate larger notifiers and ranges. All it would take is 
maybe adding a flag in drm_gpusvm_ctx to request larger range allocation 
instead of arbitrary chunking.

I agree this could be done as a second phase and is mostly work in the 
drm_gpusvm code.

Regards,
   Felix


>
> Regards,
> Honglei
>
>
>> Matt
>>
>>> Regards,
>>> Honglei
>>>
>>>>
>>>> - Finally, make sure that individual userptr pages can reside at any
>>>>     location.
>>>>
>>>> Over conversely:
>>>>
>>>> - Normalize embedding of drm_gpusvm_pages in VMA structs + notifier
>>>>     creation
>>>>
>>>> - Make sure that individual userptr pages can reside at any location.
>>>
>>>>
>>>> Both options actually sound really similar after typing this out.
>>>>
>>>> Matt
>>>>
>>>>> So either way, the Xe userptr + gpusvm implementation should be 
>>>>> refined
>>>>> further for common driver use.
>>>>>
>>>>>>
>>>>>> Reusing drm_gpusvm_range for the XNACK-off case would simplify our
>>>>>> implementation considerably, it already provides large page chunk
>>>>>> optimization, can reuse the existing migration infrastructure.
>>>>>>
>>>>>> Building these on top of a standalone drm_gpusvm_pages
>>>>>> would mean reimplementing much of what the range layer already 
>>>>>> offers.
>>>>>> It would also let us keep a single code path for both XNACK modes,
>>>>>> which reduces maintenance burden and avoids behavioral difference.
>>>>>>
>>>>>> Would this direction be acceptable, or do you see concerns with 
>>>>>> reusing
>>>>>> the range infrastructure for the no-fault case?
>>>>>>
>>>>>
>>>>> If you prefer something like insert a range exactly here + create 
>>>>> range
>>>>> + notifier I think that completely reasonable direction and Xe would
>>>>> likely switch over to using this.
>>>>>
>>>>> I guess my only concern is sub-userptr migration. We are trending
>>>>> towards allowing userptrs to being migrated either via prefetch 
>>>>> IOCTLs
>>>>> or access counters on the GPU side - access counter we'd likely a 
>>>>> single
>>>>> 2M page at time migration within the userptr. get_pages() supports 
>>>>> mixed
>>>>> mappings between VRAM + system but likely needs some more work to 
>>>>> really
>>>>> make this complete though.
>>>>>
>>>>> Matt
>>>>>> Regards,
>>>>>> Honglei
>>> ...
>>>
>>>
>
