Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D308FE5206
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 10:43:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45A9510F4E3;
	Fri, 24 Apr 2026 10:43:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AQCcg+d2";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011056.outbound.protection.outlook.com [52.101.57.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B278510E325;
 Fri, 24 Apr 2026 10:43:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J18Y2PHYpfh7Sz8H3vnP+q55wn+MUytuydmNIDDH6rt4y9ZCQ3MMXbt8sIx5dxw62DFOeiWu8TmOEy7f+UtW33xtlOoE3lyasUa8xNM+hMFywd+qUuZ7YdN2tuS1ucnsrzzBPTaECEs1T6yViGnAaFFNm9X7oWpmWL8xoqriWdQxpW9lW2C3rSNxMJwnV3OdokQ8huBTnkxMhEYqPjG1VWQwtha7c3GtBcEyGeBCRTEIwkr9j6cKd3ynpyqTnqhA6YirBOisX4A5fCUX9nZTXjUZfVMqTwjYF+JzYL6lOTKe/bYfM+g9F7K8v+QohSaF888IvhdagDPp57VrSsOz9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHDycykiKvbyN/dgwT88xWwKL0JHOCU8tCESJEW2KPY=;
 b=WGzZHihQkel1whlmrW8WJwJod0tue9D4TfI9QtrmWoyNaPP8eS+ZsWIZJaGsRjF+tVtpOpZ6Q2PiAsaksrv4XgMpegfL7qIGZ7lONSZRoDZ0SPxIejWKBHKeiPdii/Wj538QA2cqRVarBHi3u5fbs2PGKo3YOM15UtFixu0b0v4e+JZkzlEk8H00KiGlTds5Sq49yliYdwmcX+5agHSjLALdijFqD0GArnAOvf1/GwY2dyVHJu0khDYcl3/3PBn/gW94sf6hvW3sHFR4L483tlSCqy9KbyXIWbjauBl65+6mxz8Pl4hQ229mz65jwIAHTg+9+cSpJlTZch6DwIxUdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHDycykiKvbyN/dgwT88xWwKL0JHOCU8tCESJEW2KPY=;
 b=AQCcg+d2PIVz5MtWpJZf8R8Lktb8EMq9/K4FZcCHpEerCW0iL7GJHbKH1ptrZCyIq7u5cZ+fq9U5Pt+AKhAzsToWH65yYkQIkerx1sLJD/cHQmT4aLKJ9Kf5j4krw/PW97gpicP19W2ThMLDHkKCl3lEHekTEdcU/eEAeYgA5dE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by PH7PR12MB8426.namprd12.prod.outlook.com (2603:10b6:510:241::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 10:43:31 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 10:43:30 +0000
Message-ID: <79e9730b-80b5-4517-9942-fb6ec1569276@amd.com>
Date: Fri, 24 Apr 2026 18:43:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/POC PATCH 00/12] POC SVM implementation in AMDGPU based on
 drm_gpusvm
To: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Felix.Kuehling@amd.com
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
Content-Language: en-US
From: "Huang, Honglei1" <honghuan@amd.com>
In-Reply-To: <aep/S6m7vG5K7Ra9@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0058.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:8::9)
 To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|PH7PR12MB8426:EE_
X-MS-Office365-Filtering-Correlation-Id: 14aaa6e1-5f3c-4c1f-df88-08dea1ee5319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: w+s9cuRd5C3dYdcEePxF+Kl3WDokYVfhTLozciGcuP6KD2ETyofVW1E2dbXeg7hxOQWRULo+UzjL4UCOnGhek7eHmkbqP4917zbwaSqPfDZuq+ASeo1zoJ15P9oU29Ah/CnWEchduDtpxtzWoR4M9qUrYY1qUuj1OzBdbJ72N5kOEIfATdrggC8k0GpB1al9vs16eVdH7Kih2uJBzM9tXjZ0JP2KzMb4M+c3FqcCXL7IAlehUmnm7ELok38kcdh9sfD/G1fnpz3oM3yuj8hkE3qSVGcqNtHLIo8/ci7Qo6/qUa4haaopTEShW1fIabMdgsWxdhJtiUaa7jNEiAjTyjqbFi4vmEDXn/Jcgb+mk+hRJShAokWNdmKyXL5pj8GryT/6ygcFWcFf7GAPY0xYPraMQDvkWzQVKhw7p6n4gXTSNpSpFI1R4hIrMPj32IbPQmd3M7NP0uGrdDIEi6P1v5fInUnUxlnS9sExQM3yXjGf8GUm/23v4eyTyIiZ6OjdDF4wTatDS1tea/nEmGqm7GEkqv0XBiFXRXyUYNRCXHCOhLXBQ0IuM1+pS3CM3n23FBD2oiAis9PULkSKRDQP85xW/k+CRptc7+mpRwpD5OGCkAui/WLtHe8XdlI1eDXIJD46Br/CTnOLDTaDIT0WjTTdQtl/drG0Ya3lLyRPsvgUmI1dZdzEUlJQunQlO5qQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2QzZWtzZDJuVE9YdTBwQ2xrY3NpY1hISmpFMjBWYTdNejdFR2xpNXBhVGRZ?=
 =?utf-8?B?L3UxcFVlVzlCSjc1WDhsV2UweENEVWhaRExoVDFMOXA2M0tpQit4Q3F0Mytl?=
 =?utf-8?B?TVFLN3A5WG0rbk9TVGtjM0Z6Q2dsWkVnV0lVamd2QVV1OUlua2VOSXZEWjlR?=
 =?utf-8?B?L2twK3QwZGJBTlY3bXB0ekt4eG56elZEY1lFZzg3OUZiUFc5V2FPZExBTGVP?=
 =?utf-8?B?M2p4TGtyZ0FjSDc1ODlqUDVUdDJrS1A5L1A2T3dISHIwNmtDWVhWdDRGOXhG?=
 =?utf-8?B?dDRQd0QxUWhQL0MzT3NGeXFZRUNvZU45ZGVDTVpVekJLVWZZQ2g0ajJUM25H?=
 =?utf-8?B?SDc0ZENPZGVUUkxiVXNsYm5wcGlpNzN2S0hkSy9TTHBvK0pORHVPRUhVcWVs?=
 =?utf-8?B?VVltbmJST29MUDBSK05qdWIrb0pqc3RxSGJlNUxEM3Z3Nnhqb0JjLzMrWDM3?=
 =?utf-8?B?OTRWU043WmNVbkdwak9KZ0t5Z2gwUXNrZkpmcnp6TElaR3h6L1hqN3R0TXRE?=
 =?utf-8?B?RThkNGRKai9xSlJxVjdlN1VjcWt3bVhUWVd4ZkRxMTZUdEc2bmhGazUwTkJx?=
 =?utf-8?B?YUhpbys2MTdUZkk0azU2RzhYTHU5L1ZidzNreG81QmxWd201aW82ZmwwTTU0?=
 =?utf-8?B?d0o0Q0x3NVI5cmI5Q2xkZGQ0Y1F0dDRlTDRuYVh1b3BkSTlLK3QzbHBTVWpP?=
 =?utf-8?B?U3lqZTBZK25MVjN2djRMZk1BeS9zMWFKTytxdk1SN0I3a2ZWWno5SUlRVmZq?=
 =?utf-8?B?NUdxcElKSDZWMU9xMlA4a1UvUzBhSHFtYk5uenhyb0ZKTmMwODNoSjFBTHpZ?=
 =?utf-8?B?dGhUclV2RGlYY3ZlSC9tTjlMeFM4R2FJWkE1emdTRHZROHJZRzlIUDZUOUdD?=
 =?utf-8?B?MVRWSVNrMWxhQ0N2KzlJQ3M5OHlwUFhLMVFMVW1PaVdaRXlTeEhJOWpkT3Rw?=
 =?utf-8?B?cHBoQVF6MDVkQzBKRTlmRnovWTVQM1BxL2F1WEZhQ1lXeDZiMUFJRFpzVWZl?=
 =?utf-8?B?aFNkYmJXSWFvamlOMU5VQ0tFUGZMSDVsd3BSdHlLN1hjeTRTOEJsMm02VjdB?=
 =?utf-8?B?MWdRTmVjc1l2d1RBU2J2QnNMaFJ5Q05MLzUzL0REVTMwY3ZyQmRydGJBTVh5?=
 =?utf-8?B?Y0psM3VVVWgvaEV4ZTJIaFRFVk5jOTc4R3AzZjQ3MCtqU0lrVGhkK0o2VFQx?=
 =?utf-8?B?WXZZVWFzdGtma1lsMk9CQ2ZiOXJ3UmNXMDNLbTBQcW4wZU04ZlRudnU2eVhX?=
 =?utf-8?B?M01iQUs2VjRWaFZoZUJuUWJBRHk0OVhBbmczdjFDL1ZMNTNmTUF0Y2VBVXh1?=
 =?utf-8?B?bXc2ZWZ6TlUzVklVWnpVY1ZVcGhuV01mU0swSmRrVVBVNVVJdTJ0T05nV3hH?=
 =?utf-8?B?TkdWcWlXZzRET1J5ZGJNeitSZWlqck4xUWFhalpra3hXL2c3ek51V0MrOUYz?=
 =?utf-8?B?V1BVUi84RVNaRzRtaEZuZjRDbzdtNzNGbjl6bFZNQlhzSGFELzJVa0dncnIx?=
 =?utf-8?B?NC9xTlcwMmVHSE8rcWVNZk0rNThxVXdzUHhodFF4bng2Skh0T1BuRDZzYUVV?=
 =?utf-8?B?RXRhOElOQ0x5Rkgrd2JSdTFjVnBLRUVNYjBUdFVaZUJnNUM5YS91MlYzN0ll?=
 =?utf-8?B?V2MySkNQOU5GYW5NTis1NWg5cFRYN3lUb3RJUGRDV25RR0phMXAyVmZRcFJt?=
 =?utf-8?B?cHorM1FDK2RDdTc0L0I3cStqb0cwLy9rOWhzNUxYUFRIVTZrTWgwTlYxazhz?=
 =?utf-8?B?QnhRa0xVWXdqOXFjb0lXRVVxZjFzZnNBM3pVN29PbzE1YnIxUENXQ0xBb0E1?=
 =?utf-8?B?VjF3K2ZxalJObmFBN1BEd0l1MURtbmRkRmZiQy92U3dlb0szM2Fkb1VpQ05t?=
 =?utf-8?B?cGZQcUplL0RibXo3OVR6WWI4V0gxbHZXQjlqeXFiNXM1ZjFJNHVrVzdCREd0?=
 =?utf-8?B?c2o3YVg3RktEQWg2LzkvOHZERGhVNyt6M3lJempsNGZhd2NabFRmbmM1cTVL?=
 =?utf-8?B?d085RmxMd3gxNnFlQUd0MXhCK1FBRnFQajVVbWY0SEVDOTYvWm16T25sRGNE?=
 =?utf-8?B?MWFDbEpoejJhT1FubHBLUnV1ZDhuSWgySkEzaE9OemVscGtUSmc5dmRXak5i?=
 =?utf-8?B?SUcyR2Npbnl3ZUJpSGY2OWxCV3p4MzE3SUgxbXNqbGllZGFxMUh2WWw2VmhT?=
 =?utf-8?B?OTVnQWxMMkRYQ0ZoRWxQTXg5d3crZ1YyTWZaV0FnWHdQQXVRWVhhMHV5Q3Ro?=
 =?utf-8?B?V2NRV2I3WFpGeFlzZk5oSHJpSWRSa0ZRb1RsSzZ4Mm55Wm1jZWs3YVZ1Rjcx?=
 =?utf-8?Q?O21M8AftrZngCgj+Wx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14aaa6e1-5f3c-4c1f-df88-08dea1ee5319
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 10:43:30.4882 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6gv/vlqFfvmlMOmiz+CpQz9mACeotsMMT5A3sw9zipXniMhJAsYkVvGVS5QL1j1njAFq+iK2mdMOIilA7CX0Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8426
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



On 4/24/2026 4:21 AM, Matthew Brost wrote:
> On Thu, Apr 23, 2026 at 07:03:52PM +0800, Huang, Honglei1 wrote:
>>
>>
>> On 4/23/2026 3:18 PM, Matthew Brost wrote:
>> ...
>>>>>>>>> This clarifies a lot. This is what we’d call in Xe “preemption fence”
>>>>>>>>> mode for a VM. Anytime memory is moved, we trigger a GPU preemption and
>>>>>>>>> resume. We don’t actually support SVM in this case; instead, we use
>>>>>>>>> “userptr binds,” which are built on gpusvm for page
>>>>>>>>> collection. However,
>>>>>>>>> we don’t support migrating memory to the device—though we could.
>>>>>>>>>
>>>>>>>>> I’d look at how we converted 'userptr' to be based on GPU SVM [2]. In
>>>>>>>>> this case, don’t maintain a range tree, as those—as you
>>>>>>>>> suggest—are more
>>>>>>>>> of an on-demand fault driver concern. Instead, just embed 'struct
>>>>>>>>> drm_gpusvm_pages' in the VMA struct defined by the IOCTLs..
>>>>>>>>>
>>>>>>>>> We could extend this to support migrating 'userptr', but we
>>>>>>>>> just haven’t
>>>>>>>>> done that yet—this may be what you want to do in “XNACK off..
>>>>>>>>>
>>>>>>>>> [2] https://patchwork.freedesktop.org/series/146553/
>>>>>>>>>
>>>>>>>>
>>>>>>>> Actually we need to swith the xnack mode between on and off, so
>>>>>>>> in xnack off
>>>>>>>> mode, the driver operats in "implicit  prefetch mode". This may
>>>>>>>> be due to
>>>>>>>> compatibility with older hardware and the need for UMD runtime. We will
>>>>>>>> further discuss the handling method under xnack off internally.
>>>>>>>>
>>>>>
>>>>> Hi Matt,
>>>>>
>>>>> I studied the xe_userptr code and the conversion series [2] you
>>>>> pointed to.
>>>>>
>>>>> I have a question that:
>>>>> Would it be possible to reuse drm_gpusvm_range to handle the hardware
>>>>> without gpu fault feature(xnack off mode).
>>>>
>>>> That’s not how we’ve done it. We embedded drm_gpusvm_pages into our VMA
>>>> structure and then attached a notifier. The notifier attachment is
>>>> open-coded on the Xe side, and this could be normalized and opened up
>>>> for common driver use cases.
>>
>> The way in xe_userptr likes the implementation in kfd_svm: embeded physical
>> pages into structure and attach same size notifier.
>> But kfd_svm is an implementation of SVM semantics, which supports partial
>> unmap, doesn't need explicitly delete userptr ioctl calling when remove ,
>> and doesn't need a explicitly userptr flag when creating.
>> And actually there is also a existing implementation for userptr semantics
>> in amdgpu kfd: KFD_IOC_ALLOC_MEM_FLAGS_USERPTR.
>> If the no gpu fault mode can not use the drm gpu svm fram work, use the same
>> way for xe_userptr, it seems like doing the duplicate work.
>>
>> I think the core gap is we are trying to use the drmgpu_svm to implement a
>> SVM semantics driver for no gpu fault hardware instead of userptr semantics.
>>
>>>>
>>>> The problem with reusing drm_gpusvm_range directly is that a VMA may
>>>> span multiple gpusvm notifiers—i.e., it can be larger than the notifier
>>>> size. Of course, we could rework this as well.
>>
>> So the "VMA spans multiple gpusvm notifiers" concern: I'd like to clarify
>> that this is not actually a blocker for amdgpu's XNACK-off path, because
>> amdgpu does not try to represent one user ioctl virtual address interval as
>> a single drm_gpusvm_range.
>>
>> we walk the attr interval and call drm_gpusvm_range_find_or_insert()
>> repeatedly, letting gpusvm pick chunk aligned ranges bounded by
>> notifier_size. One ioctl interval will create N chunk sized ranges.
>>
>>>>
>>>
>>> Sorry for the double reply—I just glanced at the latest series. I don’t
>>> think creating a range per page of the userptr is desirable. While it
>>> would work, from a time-complexity point of view I don’t think this is
>>> ideal.
>>>
>>> The issue with spans across multiple notifiers is real, though.
>>>
>>> My rough idea would be:
>>>
>>> - Give drivers an interface to create larger ranges.
>>
>> So maybe we do not need to create larger ranges if we call
>> drm_gpusvm_range_find_or_insert() repeatedly.
>>
> 
> That will be functional, but consider it from a time-complexity point of
> view.
> 
> Multiple ranges increase the time complexity of range-tree searches.
> This isn’t a huge deal, but it will show up to some extent.
> 
> Multiple ranges will also slow down DMA mapping and migration. We
> switched over to the dma_iova_alloc/link/unlink/sync uAPI here [1].
> While dma_iova_link is a relatively fast radix-tree walk, the allocation
> and sync steps are where things get expensive. Therefore, it is
> advantageous to perform these steps as few times as possible. For
> example, if your SVM buffer is 512MB, instead of doing these steps 256
> times, you do them once. The same logic applies to the migrate_vma_*
> functions—they are quite expensive, so doing them in a single shot is
> significantly faster.
> 
> The same applies to invalidations. If you can invalidate a large range
> in a single shot, it will be faster. Although the logic in the notifier
> should be able to zap multiple ranges in one shot (Xe does this), having
> to DMA-unmap a single large range will still be faster than multiple
> smaller DMA unmaps.
> 
> The TL;DR is if your driver knows size of SVM allocation upfront (e.g.,
> an IOCTL tells you the size) it makes more sense to use a single large
> struct (either embedded drm_gpusvm_pages into a VMA or we figure out an
> interface to insert large ranges / notifiers).
> 
> [1] https://patchwork.freedesktop.org/series/160587/
> 
>>>
>>> - If the range fits inside a single notifier’s size → done.
>>>
>>> - If the range spans multiple notifier sizes → round up to a power of
>>>     two and create a larger notifier. This may overlap with existing
>>>     notifiers, which is likely fine given that interval trees support
>>>     overlaps (?). We’d need to double-check and test this. If overlapping
>>>     notifiers are not acceptable, we’d need some heavy-handed notifier merge
>>>     logic—it will be complicated, but isolated, so once we get it right
>>>     everyone can use it.
>>
>> If we call drm_gpusvm_range_find_or_insert() repeatedly the drmgpu_svm will
>> create the corresponding notifier correctly as far as I can see.
>>
> 
> I agree this will be functional but not ideal. You can always start the
> approach you have here and optimize it later by adding the required
> support in GPU SVM.
> 

Hi Matt,

Really thanks for your information, this really helps a lot!


Hi Christian, Felix,

According to the discussion with Matt on the previous thread, I'd like 
to align with you on the XNACK off direction before start to the series.

According to the information form Matt:
when the allocation size is known doing one big operation is
significantly faster than doing many small ranges, because
the allocation and sync steps are where things get expensive.
Doing them in a single shot is significantly faster, especially in the
situlation of xnack off mode, which needs pre fault and pre map in 
ioctl, and the size is known.

It is confirmed that repeatedly calling drm_gpusvm_range_find_or_insert() is
functional, and suggested we land it first and optimize later by adding
large range support in GPU SVM core. That motivates the two phase plan 
below.

Phase 1
- Reuse drm_gpusvm_range for XNACK-off, one ioctl interval is split by 
drm_gpusvm_range_find_or_insert() into
   N chunk-sized ranges bounded by notifier_size, same mechanism as the 
fault path.
- populate all ranges at ioctl / submit time instead of on fault.
- Invalidation -> GPU queue stop -> rebind/restore the pages and gpu map 
->restore queue

Phase 2:
Add a large range / large notifier insert interface in GPU SVM core
so one ioctl interval maps to a single range to improve efficiency.
This needs modify the drmgpu_svm frame work.

May I know your thoughts on this plan?

Regards,
Honglei


> Matt
> 
>> Regards,
>> Honglei
>>
>>>
>>> - Finally, make sure that individual userptr pages can reside at any
>>>     location.
>>>
>>> Over conversely:
>>>
>>> - Normalize embedding of drm_gpusvm_pages in VMA structs + notifier
>>>     creation
>>>
>>> - Make sure that individual userptr pages can reside at any location.
>>
>>>
>>> Both options actually sound really similar after typing this out.
>>>
>>> Matt
>>>
>>>> So either way, the Xe userptr + gpusvm implementation should be refined
>>>> further for common driver use.
>>>>
>>>>>
>>>>> Reusing drm_gpusvm_range for the XNACK-off case would simplify our
>>>>> implementation considerably, it already provides large page chunk
>>>>> optimization, can reuse the existing migration infrastructure.
>>>>>
>>>>> Building these on top of a standalone drm_gpusvm_pages
>>>>> would mean reimplementing much of what the range layer already offers.
>>>>> It would also let us keep a single code path for both XNACK modes,
>>>>> which reduces maintenance burden and avoids behavioral difference.
>>>>>
>>>>> Would this direction be acceptable, or do you see concerns with reusing
>>>>> the range infrastructure for the no-fault case?
>>>>>
>>>>
>>>> If you prefer something like insert a range exactly here + create range
>>>> + notifier I think that completely reasonable direction and Xe would
>>>> likely switch over to using this.
>>>>
>>>> I guess my only concern is sub-userptr migration. We are trending
>>>> towards allowing userptrs to being migrated either via prefetch IOCTLs
>>>> or access counters on the GPU side - access counter we'd likely a single
>>>> 2M page at time migration within the userptr. get_pages() supports mixed
>>>> mappings between VRAM + system but likely needs some more work to really
>>>> make this complete though.
>>>>
>>>> Matt
>>>>> Regards,
>>>>> Honglei
>> ...
>>
>>

