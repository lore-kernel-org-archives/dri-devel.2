Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C563FF8867
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 02:23:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C610E10E9F8;
	Tue, 28 Apr 2026 02:23:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VzgjLsZo";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010053.outbound.protection.outlook.com [52.101.201.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 930B910E9F3;
 Tue, 28 Apr 2026 02:23:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bNztwlkRTHeUvRXH9cMkDi/X67i6KH3s6XY3cCCfWvSc75OY+N8qzr1Df9Xl1njCJena7hEsUMnm97pe4By4tmMwdBcuPFRXy+TQnhuLyOCvVMa0YKFA1TspAq4nCbaqWCJRUOh5sFq3hDI/nFagz/hqLPAZ5hOeFOx0A6fe6UStBZgDE0i3ErCEDWL1O8dnjqz7MhzwYArD3+WdwGQENvyCql/UyuNp5Bon1/fAttag6jVGECCpuknu3TMhh8ZxT0BlOBmQ8SSwEwkfdq49tOFI7oT86XQirLU93OrXjrPr+vdmLAUxRvQMn9JZn8olArwJ5R0T27OfKng6ckchMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBjN6fFrH20UAD4n1FYi+rKy/JR1Uu6hMmd/jC7azjc=;
 b=nZ3EoK85cgtdGZdYsq4gDv93QPsfkywnXCV79rNUPtNURuhjBsmcf3Gcr3Nq/naL+Yey8YD+BGuHC8WUk0RHWlssKWfntVfacnqjMNNDvYspyAIhLlKA0tqJYVXHgMHzqjDroVsdCdMnUn30QJtVka++PDUJJ4MwOHlcULco8l2IUpHHKS4MoxsCJlUl/nT2ObIQTpX2N7qEPSrFhvBdtPWfErpAGbA/uGCRXe21QXq+jbCM/BgRsTnakG0sJchSNgSr5slahMvaBccKF0rIjwzdXccyn9PoBCOE+woJrw2YqdeyI9K/VYrmDQihHH1kAuRZ+FMeD4f/FglOsjM6VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBjN6fFrH20UAD4n1FYi+rKy/JR1Uu6hMmd/jC7azjc=;
 b=VzgjLsZo4av3jzRt4ZOAGQmLCy/LhuxdTPRP1jdpTfNmKHgQ8Lzb0f4dsw2t+xSKDJgCb89QXRCz+BWsUWFOYOIhLEGIX6XjMJ6q6oNwgct4kDGFXj6xUj9JIdhFeeD2wh4v86bFJCgyVhVYJ1DVLQBXzHdMKxVzxrQ+ifdZC1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by IA0PR12MB8696.namprd12.prod.outlook.com (2603:10b6:208:48f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 02:23:29 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 02:23:29 +0000
Message-ID: <9b4e3f7c-5d32-4b7b-a270-703325926f86@amd.com>
Date: Tue, 28 Apr 2026 10:23:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/POC PATCH 00/12] POC SVM implementation in AMDGPU based on
 drm_gpusvm
To: Felix Kuehling <felix.kuehling@amd.com>,
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
 <66a7efd4-8ec9-47af-b6c4-5be25459a474@amd.com>
Content-Language: en-US
From: "Huang, Honglei1" <honghuan@amd.com>
In-Reply-To: <66a7efd4-8ec9-47af-b6c4-5be25459a474@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0058.apcprd01.prod.exchangelabs.com
 (2603:1096:820:5::22) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|IA0PR12MB8696:EE_
X-MS-Office365-Filtering-Correlation-Id: 8220079a-d1f1-405b-e1b5-08dea4cd2224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: k4AUo3GvoaShYkNft4nY/1+BjozPX6xNlPNq/Rgg2AxOx7gOgWdd7VeMXPHCV6taCvRry/0SLsjvLlcQ7miwYYa4+Ecf3a/h4XQWBtUku6LxvYAjJodv6fkr2hId4nwZsLlfKrbzcRzbM9inh1eEmhvUJwKjOVHCw6cQrtjAmA4XFPT/S6xXYRTm8nC7Uder2zYIu7NrCMf80SvF6JP3VwH20tF1OCB61ohYbEOIk3l5vuRJ08e9id7H3ZkTxGaxKCdCaaO9kQOPq2MbNCLO2W9cL0TXilSTv+idhMNWDpadjzO9A7ZM6iEseiGmtuNX9rRQGc4tuTGhRc7SZmPVcA0JdiWAw1vp/7igw/Xx4IqM41dZQXHEp3j9g3ZbxC+1rNYqD+9/KTIY88Hl9RhYZBP5WAsXB08effQKqElJ1gJYvu3pwohdyjh+LDExI1g/0wxs2zev3jMgjN5f8JPwVCgM7Wz0NFt8yIfD23K2JYOW3fpttoN5IUWyqVwosVefYZmzvmvO2X9NJRX1Le/aGpLxNTijtDP0yy4xJvJ+ZUjRUC0YQT8uN6MFCtZOyd8oEBf7IqKIXu0U2eLKl7+atiN4yof+0oe6E2GmQ6DGqTGgqcfszDlqwobTHTZgsGYLYnYDf4MzCF/UWzWbyh6OVjZ9EQsv46AAM7FseOMHSQss7HW1cmR2eoUTGxLSIPaU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjJFcHcxTlZCb1pxcVZxaEFtbjhublBKOWhKZEdtNGpMaDRxMGdLYlVMS0Zm?=
 =?utf-8?B?c0UrNm5OYlRtSUZzM2JsRStCTUZxVkJZZ0duWkRnSzczeng2Q2ZydjJibTRQ?=
 =?utf-8?B?bVZBaEJDb1pucTc5c0UwbVNKTHNiaXRMTmFNc25Sc1dLTjFJS0JtaFF1MnE3?=
 =?utf-8?B?SWlma1VzeHNYeFFqQ056N29RbGQzcGMzamZUVGs0NGgwUnNGckhUWFlzQjN6?=
 =?utf-8?B?cWdXRDZXVFBzV0tNMWJwVVdOVlVpNVE1RmwzSms2S3NJMTBjWER4R0tHYTF6?=
 =?utf-8?B?eHJGLzdQZXVCUFF0Y3VNdFlXMjQ3TFRJVWF6NlZsaVhhYzZMMGZqQ2hVL0pQ?=
 =?utf-8?B?UUhTZWhHVjhQeXRlMllJNmVqMnFUUjRVM21tZDlJM2FTK1hSVmZNa1AvMXdu?=
 =?utf-8?B?ODcrZFRxWVgraXNRenBwdDZBQWRNTW5jUEdINUNUSXBKOUN3ZEpZcmlqeXlF?=
 =?utf-8?B?eURYTjlBSkJmU2NwYi9tZmMvb3NBL2Zkck4vS2VZaGR2NkhsS3BLZCtiZmdL?=
 =?utf-8?B?QndKS1FNOVY1UHdqVVAzUzFMQ3RUbW1Ucmltbm9YYWJKTmZlUnFpeWhRWlZy?=
 =?utf-8?B?aFFDbXRRZnYrYzBLYTYyK2JoakZjQjdPMDNVOHVDYkhuVTBZWXd4Vm0wTk1q?=
 =?utf-8?B?dVNjQmhtamhwRGF2SmFtSXZoUG1CVHR1RGlkclc3T0pwNDVuU0VaMy9hQXdD?=
 =?utf-8?B?cUNra3VjVzNWMlpzeWdmbVpzc0VSWGtUQmpYYnBKQjNqczNUZ2VBL3FHbFNo?=
 =?utf-8?B?V1lGemxTbEs1MU0rbmZYYW1lZGp3SE8zR3pwdVV5L1JHblF1dHFHTEN6dDh5?=
 =?utf-8?B?UDhyL3pvbnNzSkhGcDlGbldzOUp6aUhKVFpVYXFSNXBueWorYXl5VFczZ2ZP?=
 =?utf-8?B?bTgrRksvbUpuaWRWaFVzM3BienByTm93RnYvSlNzMjRlMWNNUzNuSWV1SFIx?=
 =?utf-8?B?clcwN3NCQ3diSkcrbjRyS3V4TFV5ZGlYQUkwczZzSFRsSGk3NS9keWZEdDdP?=
 =?utf-8?B?aHlpN0t5MDRMeU1tbTU1bERUZGpTRG94ZkVZa1B0NkhOVG1yVGNCRXczcGsw?=
 =?utf-8?B?dTJKR050RG5PUEdmdGdyeEx5UE5OTlZOajk5bTZzTmNXMytmK0xCbWgrVTR3?=
 =?utf-8?B?WTJKdTRmaEpMWFFYTndIK1lDY3E5UXVJYVgydzhjL3lFa05rK1R2a0s0YXp6?=
 =?utf-8?B?bG1IUXc1QW94OWdwZjlpUFN2akNIQW8velVpOVZ0WGdleXBDVVNmT0Q3bjdB?=
 =?utf-8?B?dXhCcy9sc1d0QVpUa1d6dUxuMXJoaUxzTmJldks5QVE4TU9yRlBrR0lrNHla?=
 =?utf-8?B?OTE4UXlUdzNjSXpCdEhlaWFaSVdodWpVQkVSL0FFVnhEMGtqeC81RXhKbEtp?=
 =?utf-8?B?VTZJSWozN3NYSjBsMlNrRGpIMGE0ZDVDVXhjamswMys2MGc2QUl6RitSSnUw?=
 =?utf-8?B?NnlpbDBWc2hFK0ZjaXdZamY0bm91M3dDM29EMnRYSWd4cWl4YzNzeE11SzQz?=
 =?utf-8?B?VU1iSWJYTW1rUE9xZDZ6aFZrQXV0STBpa2dVbTNkYmVTTVZINUNveVRtUHNz?=
 =?utf-8?B?MU1ITm0rSWJOaVAvK1VzUjRLakFOYWRZVW4xMEpkcHZxVTQ3SnVRY2RSczZY?=
 =?utf-8?B?dm5jbHJ3aEQ5UGFqcEcxZ1VNcEdwUGlSSFVrTHJKOFFNbUdHQ1BpNkhVb09X?=
 =?utf-8?B?aU12T0hGdC9NNncyS0l2TmI0RmtCaGZrVVJtdlJscTFNczVnaVRYbVNId0RG?=
 =?utf-8?B?MjBlVnZYSEpwNmZremljZ0lsamFyOFNLMHdjRFU5ZkZCcXZzMFdDS3ZSbDVz?=
 =?utf-8?B?alQrNXNFZDJaMURaRDNsb1F6QUhxTlRIdjBrVEpNSStJNVlISW5xU0R4eFUx?=
 =?utf-8?B?b25qSFcyZVRSOUEyeW1tVWxHeGNHRUxHaXVjU0VadWEwT1IxaG9lMEtqc0hY?=
 =?utf-8?B?VzNjNy80K0pQTzVsK0pPeXlubGdNWHRKY1ovMXZ3c2wySzBNcWEzeGJXVUd5?=
 =?utf-8?B?QjVJRWIrL2prL3IvYnUxYndwOFM1RVIzSnptN0dxR0hDNWg5K1hXa2dCQkc2?=
 =?utf-8?B?ODJZUWcxUTg1QUpWTkZ5NnlDb2ZINUNZY1F0d1BzbGQ0ZHFGMW5oSUlSazFR?=
 =?utf-8?B?aVRJWjh0cTh1N0NZNG5kenBFNnh3d0pqYmhTZlBhVXMxcWpGdjkzM09iL1FP?=
 =?utf-8?B?MDRPalZ0UzJKUk9QaUdncDZQOGtCVUVBa0RSQlc5Vk9NOEFEWlRhdFRySHU2?=
 =?utf-8?B?UFpKVUpKcDkzOGhyN0hiWmRaR051OFYza3hBUEJ3RStVM3VCWWtWMksxbXdE?=
 =?utf-8?Q?HgbJXL6paJ5NQN7gxd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8220079a-d1f1-405b-e1b5-08dea4cd2224
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 02:23:28.7642 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NBDgf/aL2Gvy9ABW4PWfF6gxgtAHZuUsbGg0DFd8fKdORnWgsJW1on7fjWrHCdxY2l76Dyy4lfhYIcx3VJWtEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8696
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



On 4/28/2026 4:00 AM, Felix Kuehling wrote:
> 
> On 2026-04-24 06:43, Huang, Honglei1 wrote:
>>
>>
>> On 4/24/2026 4:21 AM, Matthew Brost wrote:
>>> On Thu, Apr 23, 2026 at 07:03:52PM +0800, Huang, Honglei1 wrote:
>>>>
>>>>
>>>> On 4/23/2026 3:18 PM, Matthew Brost wrote:
>>>> ...
>>>>>>>>>>> This clarifies a lot. This is what we’d call in Xe 
>>>>>>>>>>> “preemption fence”
>>>>>>>>>>> mode for a VM. Anytime memory is moved, we trigger a GPU 
>>>>>>>>>>> preemption and
>>>>>>>>>>> resume. We don’t actually support SVM in this case; instead, 
>>>>>>>>>>> we use
>>>>>>>>>>> “userptr binds,” which are built on gpusvm for page
>>>>>>>>>>> collection. However,
>>>>>>>>>>> we don’t support migrating memory to the device—though we could.
>>>>>>>>>>>
>>>>>>>>>>> I’d look at how we converted 'userptr' to be based on GPU SVM 
>>>>>>>>>>> [2]. In
>>>>>>>>>>> this case, don’t maintain a range tree, as those—as you
>>>>>>>>>>> suggest—are more
>>>>>>>>>>> of an on-demand fault driver concern. Instead, just embed 
>>>>>>>>>>> 'struct
>>>>>>>>>>> drm_gpusvm_pages' in the VMA struct defined by the IOCTLs..
>>>>>>>>>>>
>>>>>>>>>>> We could extend this to support migrating 'userptr', but we
>>>>>>>>>>> just haven’t
>>>>>>>>>>> done that yet—this may be what you want to do in “XNACK off..
>>>>>>>>>>>
>>>>>>>>>>> [2] https://patchwork.freedesktop.org/series/146553/
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Actually we need to swith the xnack mode between on and off, so
>>>>>>>>>> in xnack off
>>>>>>>>>> mode, the driver operats in "implicit  prefetch mode". This may
>>>>>>>>>> be due to
>>>>>>>>>> compatibility with older hardware and the need for UMD 
>>>>>>>>>> runtime. We will
>>>>>>>>>> further discuss the handling method under xnack off internally.
>>>>>>>>>>
>>>>>>>
>>>>>>> Hi Matt,
>>>>>>>
>>>>>>> I studied the xe_userptr code and the conversion series [2] you
>>>>>>> pointed to.
>>>>>>>
>>>>>>> I have a question that:
>>>>>>> Would it be possible to reuse drm_gpusvm_range to handle the 
>>>>>>> hardware
>>>>>>> without gpu fault feature(xnack off mode).
>>>>>>
>>>>>> That’s not how we’ve done it. We embedded drm_gpusvm_pages into 
>>>>>> our VMA
>>>>>> structure and then attached a notifier. The notifier attachment is
>>>>>> open-coded on the Xe side, and this could be normalized and opened up
>>>>>> for common driver use cases.
>>>>
>>>> The way in xe_userptr likes the implementation in kfd_svm: embeded 
>>>> physical
>>>> pages into structure and attach same size notifier.
>>>> But kfd_svm is an implementation of SVM semantics, which supports 
>>>> partial
>>>> unmap, doesn't need explicitly delete userptr ioctl calling when 
>>>> remove ,
>>>> and doesn't need a explicitly userptr flag when creating.
>>>> And actually there is also a existing implementation for userptr 
>>>> semantics
>>>> in amdgpu kfd: KFD_IOC_ALLOC_MEM_FLAGS_USERPTR.
>>>> If the no gpu fault mode can not use the drm gpu svm fram work, use 
>>>> the same
>>>> way for xe_userptr, it seems like doing the duplicate work.
>>>>
>>>> I think the core gap is we are trying to use the drmgpu_svm to 
>>>> implement a
>>>> SVM semantics driver for no gpu fault hardware instead of userptr 
>>>> semantics.
>>>>
>>>>>>
>>>>>> The problem with reusing drm_gpusvm_range directly is that a VMA may
>>>>>> span multiple gpusvm notifiers—i.e., it can be larger than the 
>>>>>> notifier
>>>>>> size. Of course, we could rework this as well.
>>>>
>>>> So the "VMA spans multiple gpusvm notifiers" concern: I'd like to 
>>>> clarify
>>>> that this is not actually a blocker for amdgpu's XNACK-off path, 
>>>> because
>>>> amdgpu does not try to represent one user ioctl virtual address 
>>>> interval as
>>>> a single drm_gpusvm_range.
>>>>
>>>> we walk the attr interval and call drm_gpusvm_range_find_or_insert()
>>>> repeatedly, letting gpusvm pick chunk aligned ranges bounded by
>>>> notifier_size. One ioctl interval will create N chunk sized ranges.
>>>>
>>>>>>
>>>>>
>>>>> Sorry for the double reply—I just glanced at the latest series. I 
>>>>> don’t
>>>>> think creating a range per page of the userptr is desirable. While it
>>>>> would work, from a time-complexity point of view I don’t think this is
>>>>> ideal.
>>>>>
>>>>> The issue with spans across multiple notifiers is real, though.
>>>>>
>>>>> My rough idea would be:
>>>>>
>>>>> - Give drivers an interface to create larger ranges.
>>>>
>>>> So maybe we do not need to create larger ranges if we call
>>>> drm_gpusvm_range_find_or_insert() repeatedly.
>>>>
>>>
>>> That will be functional, but consider it from a time-complexity point of
>>> view.
>>>
>>> Multiple ranges increase the time complexity of range-tree searches.
>>> This isn’t a huge deal, but it will show up to some extent.
>>>
>>> Multiple ranges will also slow down DMA mapping and migration. We
>>> switched over to the dma_iova_alloc/link/unlink/sync uAPI here [1].
>>> While dma_iova_link is a relatively fast radix-tree walk, the allocation
>>> and sync steps are where things get expensive. Therefore, it is
>>> advantageous to perform these steps as few times as possible. For
>>> example, if your SVM buffer is 512MB, instead of doing these steps 256
>>> times, you do them once. The same logic applies to the migrate_vma_*
>>> functions—they are quite expensive, so doing them in a single shot is
>>> significantly faster.
>>>
>>> The same applies to invalidations. If you can invalidate a large range
>>> in a single shot, it will be faster. Although the logic in the notifier
>>> should be able to zap multiple ranges in one shot (Xe does this), having
>>> to DMA-unmap a single large range will still be faster than multiple
>>> smaller DMA unmaps.
>>>
>>> The TL;DR is if your driver knows size of SVM allocation upfront (e.g.,
>>> an IOCTL tells you the size) it makes more sense to use a single large
>>> struct (either embedded drm_gpusvm_pages into a VMA or we figure out an
>>> interface to insert large ranges / notifiers).
>>>
>>> [1] https://patchwork.freedesktop.org/series/160587/
>>>
>>>>>
>>>>> - If the range fits inside a single notifier’s size → done.
>>>>>
>>>>> - If the range spans multiple notifier sizes → round up to a power of
>>>>>     two and create a larger notifier. This may overlap with existing
>>>>>     notifiers, which is likely fine given that interval trees support
>>>>>     overlaps (?). We’d need to double-check and test this. If 
>>>>> overlapping
>>>>>     notifiers are not acceptable, we’d need some heavy-handed 
>>>>> notifier merge
>>>>>     logic—it will be complicated, but isolated, so once we get it 
>>>>> right
>>>>>     everyone can use it.
>>>>
>>>> If we call drm_gpusvm_range_find_or_insert() repeatedly the 
>>>> drmgpu_svm will
>>>> create the corresponding notifier correctly as far as I can see.
>>>>
>>>
>>> I agree this will be functional but not ideal. You can always start the
>>> approach you have here and optimize it later by adding the required
>>> support in GPU SVM.
>>>
>>
>> Hi Matt,
>>
>> Really thanks for your information, this really helps a lot!
>>
>>
>> Hi Christian, Felix,
>>
>> According to the discussion with Matt on the previous thread, I'd like 
>> to align with you on the XNACK off direction before start to the series.
>>
>> According to the information form Matt:
>> when the allocation size is known doing one big operation is
>> significantly faster than doing many small ranges, because
>> the allocation and sync steps are where things get expensive.
>> Doing them in a single shot is significantly faster, especially in the
>> situlation of xnack off mode, which needs pre fault and pre map in 
>> ioctl, and the size is known.
>>
>> It is confirmed that repeatedly calling 
>> drm_gpusvm_range_find_or_insert() is
>> functional, and suggested we land it first and optimize later by adding
>> large range support in GPU SVM core. That motivates the two phase plan 
>> below.
>>
>> Phase 1
>> - Reuse drm_gpusvm_range for XNACK-off, one ioctl interval is split by 
>> drm_gpusvm_range_find_or_insert() into
>>   N chunk-sized ranges bounded by notifier_size, same mechanism as the 
>> fault path.
>> - populate all ranges at ioctl / submit time instead of on fault.
>> - Invalidation -> GPU queue stop -> rebind/restore the pages and gpu 
>> map ->restore queue
>>
>> Phase 2:
>> Add a large range / large notifier insert interface in GPU SVM core
>> so one ioctl interval maps to a single range to improve efficiency.
>> This needs modify the drmgpu_svm frame work.
>>
>> May I know your thoughts on this plan?
> 
> I think drm_gpusvm_range_find_or_insert already has all the parameters 
> necessary to allocate larger notifiers and ranges. All it would take is 
> maybe adding a flag in drm_gpusvm_ctx to request larger range allocation 
> instead of arbitrary chunking.
> 
> I agree this could be done as a second phase and is mostly work in the 
> drm_gpusvm code.


Really thanks for the reply, will implement the large range feature 
according your suggestion.

Regards,
Honglei

> 
> Regards,
>    Felix
> 
> 
>>
>> Regards,
>> Honglei
>>
>>
>>> Matt
>>>
>>>> Regards,
>>>> Honglei
>>>>
>>>>>
>>>>> - Finally, make sure that individual userptr pages can reside at any
>>>>>     location.
>>>>>
>>>>> Over conversely:
>>>>>
>>>>> - Normalize embedding of drm_gpusvm_pages in VMA structs + notifier
>>>>>     creation
>>>>>
>>>>> - Make sure that individual userptr pages can reside at any location.
>>>>
>>>>>
>>>>> Both options actually sound really similar after typing this out.
>>>>>
>>>>> Matt
>>>>>
>>>>>> So either way, the Xe userptr + gpusvm implementation should be 
>>>>>> refined
>>>>>> further for common driver use.
>>>>>>
>>>>>>>
>>>>>>> Reusing drm_gpusvm_range for the XNACK-off case would simplify our
>>>>>>> implementation considerably, it already provides large page chunk
>>>>>>> optimization, can reuse the existing migration infrastructure.
>>>>>>>
>>>>>>> Building these on top of a standalone drm_gpusvm_pages
>>>>>>> would mean reimplementing much of what the range layer already 
>>>>>>> offers.
>>>>>>> It would also let us keep a single code path for both XNACK modes,
>>>>>>> which reduces maintenance burden and avoids behavioral difference.
>>>>>>>
>>>>>>> Would this direction be acceptable, or do you see concerns with 
>>>>>>> reusing
>>>>>>> the range infrastructure for the no-fault case?
>>>>>>>
>>>>>>
>>>>>> If you prefer something like insert a range exactly here + create 
>>>>>> range
>>>>>> + notifier I think that completely reasonable direction and Xe would
>>>>>> likely switch over to using this.
>>>>>>
>>>>>> I guess my only concern is sub-userptr migration. We are trending
>>>>>> towards allowing userptrs to being migrated either via prefetch 
>>>>>> IOCTLs
>>>>>> or access counters on the GPU side - access counter we'd likely a 
>>>>>> single
>>>>>> 2M page at time migration within the userptr. get_pages() supports 
>>>>>> mixed
>>>>>> mappings between VRAM + system but likely needs some more work to 
>>>>>> really
>>>>>> make this complete though.
>>>>>>
>>>>>> Matt
>>>>>>> Regards,
>>>>>>> Honglei
>>>> ...
>>>>
>>>>
>>

