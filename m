Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6901DC61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 07:12:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 961A610EE8D;
	Thu, 27 Aug 2026 07:12:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kg1pt/HY";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010011.outbound.protection.outlook.com
 [40.93.198.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C49710EE88;
 Thu, 27 Aug 2026 07:12:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gG7jvDy0i7ZhH66zjdi4GCknUZS2aGNVLqKKi05Eh5Eu819XHSmfJgKYDIxNLeUVTT4WtTQ5bH2PeWUvt48GEjc9ElcYlnBRxad1GNXl/MBrQVQjy2tG+RMnXSSrnaYtJbJEJDGvFxOaJixlRjxa/mDcZwFK42MyaiTeUt3GQ1qQumEbTXALF99Fzw+ao/IFwp8ZIs9bod8nwabxfgjnlm18o/wadDFR56Ml2g677YZRqW8OfoFKZtPxA8+TSGJ90MoF02jt4afTl6qpiq0pTl4RDOOcSEpbCbu3DeRc8FLXfRInPiEaiwFF4Qs/kKWfLvJ8qEQL+EU9dfd5XcDTCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MX68tf0M3XyguH66RqojQKzsApSrJmXPuYtQ020MPA=;
 b=ind53gercSPhpncFhlITYOYytFTdkGWfdAsCOEQv/UEFl9KV+i8ohF3KqOf6CsN7lHRUB84+UNy3nT2PZPyc6n1hQ4fiJ38gfw1jYiHnS6LOYcYo5YWl2ZWAD71N9ooX4RuU9dT60b3R8SaqyCHa2vJ4SBTGiFezopIShTem8EO7pGRP/8nJL/ih6kqVm3AYymctJG+cpc2htl8/DFTX6FTBzKA4F5GgReFIENEXgjWvrvjHbtJWrVVQPXsno+eWXtZKSBJqEbcW4+xIBD+ZMTbUTu4YPxVkqIZiC6BTEIgrY19+JF+5D5grsuHg9y50jNsTpUgw7jJKjWrclflppw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MX68tf0M3XyguH66RqojQKzsApSrJmXPuYtQ020MPA=;
 b=Kg1pt/HYZ6IdbrP37EMMFnKiIUa8YR2lUDHea3vUbFsgwP0vq6a1cOwvlpcb3pvDyL1pA07rAIR3403qu1/+0KnRDOu2Y4dC8mN9B3cQZnqWprQ4AaJbdoH5Bu28V+zpGvJRtfJtB5maaewPrFuBgmdhlL3osBhNhzTSJU1CDAE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by PH7PR12MB6936.namprd12.prod.outlook.com (2603:10b6:510:1ba::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Thu, 27 Aug
 2026 07:12:42 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%6]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 07:12:42 +0000
Message-ID: <75ab9702-783a-440c-af78-348735d571c9@amd.com>
Date: Thu, 27 Aug 2026 15:12:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/18] drm/amdgpu: add SVM core header and VM
 integration
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>
Cc: Philip Yang <Philip.Yang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Jenny Liu <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>,
 Yiru Ma <yiru.ma@amd.com>, Simona Vetter <simona@ffwll.ch>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Thomas Hellstrrrm <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260804094246.1719318-1-ray.huang@amd.com>
 <20260804094246.1719318-3-ray.huang@amd.com>
 <ee51e993-705e-496e-89f4-c5d0196c8951@amd.com>
 <b12d31fb-f9f2-4e09-a0fe-21f2d6bb7999@amd.com>
 <d9439960-3e65-4fc9-921d-02a6052655c2@amd.com>
 <e4e1acc6-c8f6-47af-b3e2-cd4bb396bbde@amd.com>
 <ffda865c-2f2f-4b5c-a21d-6d0ef7c1b10a@amd.com> <anx29y9NdLSrkkBk@amd.com>
 <bef7c6cc-d3b7-492f-abef-bf87e49c6b3e@amd.com>
 <9debc6fa-268b-49a7-9af6-20660bc2b1b3@amd.com>
 <49d20e9c-8f34-4409-8736-c4ecbe8ced3c@amd.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <49d20e9c-8f34-4409-8736-c4ecbe8ced3c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI3PR03CA0006.apcprd03.prod.outlook.com
 (2603:1096:4:297::8) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|PH7PR12MB6936:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e76704f-b371-4fdd-df9c-08df040a95f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|22082099003|18002099003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 5oubeE+TIVKesBdlKwcx+O11EhOSTVwQ1XTeVPGpoWUMPgXO7EEjG5ctEUQRmt/UTBBHA87klbuPy6f6MOUtDX+1XxSeEvJKAveR8Wzv6iY4zJMWfalZs8ahrzHUWWV+xLGEiRYJfALL/xmVe4qD6+hHYCZ6EFUTg8bRgbz+O3FRnK3Sic5Z3BdIvrPtxixtVIflWW4YVRoJV/KVR4Ilyz6ZmJsJZ2pJISwVg+Fodf+DX4mQchTfxAMXd4U2ZBs6PFaEJlAq5ravVQy6lsstTdpBvmajazKRe4o/b1zld+WwAzJ9J/V19ekgVX1yNyd9OJR0BD0sOlkhOWRfLIGVNaXuATgRGHSQmz7qMQtYYlBtK5WgkDwu8IS6F3Oi6OkMDGRaBsdETPUe8mj+lG+HuD6LD12l6XENlgSr4MssYDZdqyyuQEJG9PrUA1XHXTUVv62sTa0RbKsACE+RW24B/oa3+UFMHLo6yMGElinE1c7WuaoiBJqFjiXrSUHDwi6oDhSzhB5/YR5MAXqobkhMNZ2kHSr2Jr7nKsQ4naut40qFb63HHWaTIMBhzbTz94vkc+hTMRd6w4waRKte0feCIQzteB+1Ad5iWtH3I4m6bRJiQIq4jl/3h/69XIYgOsVMq1LT4u+eNZjOb8hG/khNUOJsb/w/nhodvOSCDF7j5hA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVY2L0hOR1NFQ0YzeGl3bU9NK3p4UkdVYWg0MDY2c0kyWllhSXltRGEydTZk?=
 =?utf-8?B?MkgxQ1BWOG1ad1pLdGxmSERHM2kwTWY3VCtJS0NrRVh3OE5Ca3J5OExVeFJK?=
 =?utf-8?B?eW5vbHBUTEtSQm5GT2FFQnp6UHh2RmJTZmRrQmNnOHdZSE5aQmhobXptUnZ6?=
 =?utf-8?B?SHBZTHNBMFBRSWpSczJUSFYxZ1NadVZvK1BXTkhqL05UT29Fdk5JZjg2cHZs?=
 =?utf-8?B?WWx5Y3RXR2MycndZRWJzT05FTHk3OWhGN0MwSXNhMnNYVmZoQmw3dTRZbU1V?=
 =?utf-8?B?U2o2THByeTRnK0xRM2Irb1pLakJUelNtenRzNWJDSFNiS1RCbWt1dmVsNHBK?=
 =?utf-8?B?SGVra1NWNDZGaFV6SSsvaFZSZnV1WmpMRzBvb1RsOWFoZHlIZVpYWFJ1bHJB?=
 =?utf-8?B?emlXcWRTd1dGOTdZS21HcWJDVzdndzFxY24wQzNwSlAyRiswOXppTTlZWUl6?=
 =?utf-8?B?WFlxbUFYUVVwK3I1ZWxzQzljL2k4aHI3U2prVlhZa2lvU3J2WHgxYWdZTDlh?=
 =?utf-8?B?NUlaK2QrTDRjeThKdDNtc0IyeVVtOGtSNnpoQTN3KzBYQllEalR5Zk5sTXZo?=
 =?utf-8?B?Q3hINFJRT1E2aHZEWkpsY3lxOWdyKzF6ZHRrSXZlZ2ZqbkIrWmlTclJwcFlq?=
 =?utf-8?B?bEQ3SzNzbXcxOUl2U01MU280TzRoaWhMUDF2MUl1MDJCNjRFZmVrRWZLbXQx?=
 =?utf-8?B?b0NlSDU5b0FIb05xa1FIbmdRSDh1Q2I5OUtIMFhtem9ITUxKTHhWUEZUSmpn?=
 =?utf-8?B?RU54eFlRWGo2dzdQSDRGRGtVVWd3TUxWTFhwODRSL3BId2VsTHNTMHRMeVJB?=
 =?utf-8?B?Si90Mkl1ZHA5TGdmN2dLK3Jnc0FVTzF2d0liT2hKdVBrdkdZZ2FPSlZySTNs?=
 =?utf-8?B?VklkbjdOUUpxKy9WWWZ4ZFBKTklCZVdwYVZsUzNWaWQrUmpDVVdJR1RxQ3dW?=
 =?utf-8?B?Kzkxb3dhZm45eWUvUjRzeFQ0VWlNOXA1R0gxN2dYdTVyUnFTbkN2VUQwSUx3?=
 =?utf-8?B?K3BEY2VhR2Qwd1B3QUVmdEw0WXBmckhBTFQvUWtHTlVxSkpBUkEzSFE5WVow?=
 =?utf-8?B?bmVBeE0ycU1hbXBmdVBwNFBVSU0zaUVjOUhYTmFXOFpvTmFHMmR2SkpBYzFG?=
 =?utf-8?B?SlFrTW5MRlN0dldLMWtVNGJKK2x6bTdEeUNGVHZ4U2N5bjFITVRJMWgrNHhk?=
 =?utf-8?B?MW9CTVM2U04yOXVRa2IxdVpOa1haNG5zd3ZGWlp5STFjWFJkNzAwaEQwS29J?=
 =?utf-8?B?Sm1VRjV1SS83Ri9lSEMvTnpzQ1NVQ0I5cllOYS9IMWxiTlBzOUFXdDRGaDRm?=
 =?utf-8?B?QmFlWWxkUkhONDVrb3RzaFRWVk9zM1l1S2g1VkM3Y041SHRrZVFvNjRYVk4z?=
 =?utf-8?B?WTZKMWNpRmFLUCtQU1gwMUU5S1VoQUF0eGl4OHJzM04zMllHaTcvNlhPN0tk?=
 =?utf-8?B?UVJJaG8wZTh2TSt6enExaWhYeGJDM2hramYwRjhNOS9JR3JwK0FXOGlnZ3d6?=
 =?utf-8?B?VEdjc2tBSm1maTNUdCtJUGNKNlpkc2N4QzNMYngrdC96aXFMS0pwcThiNXFt?=
 =?utf-8?B?Qy9pZ09oNDdWcmRlS0xlSHFlSDlpRUNGQUJPRzAxbHBURkQzcUZ1YjZMMDBZ?=
 =?utf-8?B?YUtXdmF5WnJGYmY5L09sekFwSFA2YzNGT0FvTlhIOVZERnZ3bnBpOWwvUWs2?=
 =?utf-8?B?QXdtUkNRZGlENWYzWHRvaERzN0hENlpWS3hVUTQzMUpKK1lqSTM4Rjc0WVgz?=
 =?utf-8?B?bngraVdkTm5rSEJ3RGJWRHk2a1ZkNEk2UUx4T3ZpL1Z4NVhZMnFQdDdkNTYz?=
 =?utf-8?B?K1ZaZmRJc25ESktvTnVnRnhoZkt0ZlNFUENhaVcwWEhoaVdTRmttRE5XMnEx?=
 =?utf-8?B?aVh2R3BERGxqVnk4SkU1NTFzK1JsRXhUR3F2R1BkN21VdHdTTWllZEE5bmM0?=
 =?utf-8?B?UlU1RC9YL2lQZzNRS3dhSGpSbU5OOCt1bnB5ZzVacnFJR3VEOG13MkprdUoy?=
 =?utf-8?B?dXZkb0J6bjloeG51Q2hMZEdRaG1KbWZpdjdyaE0vbzBNV2tncFJuUnN3aWpu?=
 =?utf-8?B?UE5jeUh1dFpFSXpwWnBpSXJ1NVREZlBocGtCQzJWU2FTdy82emMxUnBTczZz?=
 =?utf-8?B?YXNCZi9RUkZ2bWhWYlFrek5wSXAxNmREWkdKRGkyNmltZ0VNL3pQdWVhS0ov?=
 =?utf-8?B?dUtZdFVxMUVKZDQzQzBRaEJGZk50UUxjN2N2elNrTjRPeXdIQlg0QkRjVVBD?=
 =?utf-8?B?MzlUd01haHlGSWRUMlFmcC93MmtPTGNrMngxckc2ZHRiTzRtdHJ2Y3JoVm8v?=
 =?utf-8?Q?uz03UCiXA5kovJbhPI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e76704f-b371-4fdd-df9c-08df040a95f2
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 07:12:42.4910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CXMPgA420oPEZilo4U1Now3Qg0ROG219uN3IrHsWD76e5OTMPbK5IfSUgZvC6E0XYL/bUbWzBHp9rWyAv5oUJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6936
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



On 8/27/2026 2:36 PM, Christian König wrote:
> On 8/25/26 09:42, Honglei Huang wrote:
>> On 8/13/26 17:16, Huang, Honglei wrote:
> ...
>> Hi Christian,
>>
>> Following up on my previous mail, I changed the change. The diff to the existing VM code is below.
>>
>> Does this look correct to you? for unify notifier lock and eviction lock.
> 
> That looks mostly correct to me, but I would change it quite a bit.
> 
>>
>> diff:
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
>> @@ -28,6 +28,7 @@
>>   #include "amdgpu_hmm.h"
>>   #include "amdgpu_vm.h"
>> +#include "amdgpu_svm.h"
>> @@ -66,6 +67,9 @@ struct amdgpu_vm_update_params {
>>       bool unlocked;
>>
>> +    /** @svm_locked: caller already holds the drm_gpusvm notifier_lock */
>> +    bool svm_locked;
>> +
> 
> Drop that, this approach is nonsense. The caller must always hold the drm_gpusvm lock.
> 
> 
>>       /**
>>        * @pages_addr:
>> @@ -143,6 +147,30 @@
>> +/* SVM VMs serialize eviction under the notifier_lock (write); others use eviction_lock. */
>> +static inline void amdgpu_vm_eviction_lock(struct amdgpu_vm *vm)
>> +{
>> +    if (amdgpu_svm_is_enabled(vm))
>> +        down_write(&vm->svm->gpusvm.notifier_lock);
> 
> I would either make the vm->svm mandatory or rename vm->eviction_lock to something like vm->notifier_lock and make it a pointer to the rw_semaphore which should be used.
> 


This part really needs your help and input, you know this locking better 
than I do.

I'd like to go with your pointer approach: rename vm->eviction_lock to a
rw_semaphore *notifier_lock and drop the svm_locked flag.
Should I go ahead and implement it?

Regards,
Honglei

> Regards,
> Christian.
> 
>> +    else
>> +        mutex_lock(&vm->eviction_lock);
>> +}
>> +
>> +static inline void amdgpu_vm_eviction_unlock(struct amdgpu_vm *vm)
>> +{
>> +    if (amdgpu_svm_is_enabled(vm))
>> +        up_write(&vm->svm->gpusvm.notifier_lock);
>> +    else
>> +        mutex_unlock(&vm->eviction_lock);
>> +}
>> +
>> +static inline bool amdgpu_vm_eviction_trylock(struct amdgpu_vm *vm)
>> +{
>> +    if (amdgpu_svm_is_enabled(vm))
>> +        return down_write_trylock(&vm->svm->gpusvm.notifier_lock);
>> +    return mutex_trylock(&vm->eviction_lock);
>> +}
>> +
>>   static inline int amdgpu_vm_begin_critical(struct amdgpu_vm_update_params *p)
>>   {
>> +    if (amdgpu_svm_is_enabled(p->vm)) {
>> +        if (p->svm_locked)
>> +            lockdep_assert_held(&p->vm->svm->gpusvm.notifier_lock);
>> +        else
>> +            down_read(&p->vm->svm->gpusvm.notifier_lock);
>> +        p->saved_flags = memalloc_noreclaim_save();
>> +        if (p->vm->evicting)
>> +            return -EBUSY;
>> +        return 0;
>> +    }
>> +
>>       mutex_lock(&p->vm->eviction_lock);
>>       p->saved_flags = memalloc_noreclaim_save();
>>       if (p->vm->evicting)
>> @@ static inline void amdgpu_vm_end_critical(struct amdgpu_vm_update_params *p)
>>       memalloc_noreclaim_restore(p->saved_flags);
>> +    if (amdgpu_svm_is_enabled(p->vm)) {
>> +        if (!p->svm_locked)
>> +            up_read(&p->vm->svm->gpusvm.notifier_lock);
>> +        return;
>> +    }
>>       mutex_unlock(&p->vm->eviction_lock);
>>   }
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ amdgpu_vm_validate():
>> -    scoped_guard(mutex, &vm->eviction_lock)
>> -        vm->evicting = false;
>> +    amdgpu_vm_eviction_lock(vm);
>> +    vm->evicting = false;
>> +    amdgpu_vm_eviction_unlock(vm);
>> @@ amdgpu_vm_ready():
>> -    scoped_guard(mutex, &vm->eviction_lock)
>> -        ret = !vm->evicting;
>> +    amdgpu_vm_eviction_lock(vm);
>> +    ret = !vm->evicting;
>> +    amdgpu_vm_eviction_unlock(vm);
>> @@ amdgpu_vm_evictable():
>> -    scoped_cond_guard(mutex_try, return false, &vm->eviction_lock) {
>> -        if (!dma_fence_is_signaled(vm->last_unlocked))
>> -            return false;
>> -        vm->evicting = true;
>> -    }
>> +    if (!amdgpu_vm_eviction_trylock(vm))
>> +        return false;
>> +    if (!dma_fence_is_signaled(vm->last_unlocked)) {
>> +        amdgpu_vm_eviction_unlock(vm);
>> +        return false;
>> +    }
>> +    vm->evicting = true;
>> +    amdgpu_vm_eviction_unlock(vm);
>>       return true;
>> @@ amdgpu_vm_map_range() / amdgpu_vm_unmap_range():   /* +bool svm_locked param, params.svm_locked = svm_locked; non-SVM callers pass false */
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ /* amdgpu_vm_map_range()/amdgpu_vm_unmap_range() declarations: +bool svm_locked */
>>
>> Regards,
>> Honglei
>>
>>
>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>
>>>>>> Regards,
>>>>>> Honglei
>>>>>>
>>>>>>>
>>>>>>> The background is that XE uses a different page table allocation approach than amdgpu and we need to drop this lock in amdgpu to be able to allocate page tables. See function amdgpu_vm_pt_alloc().
>>>>>>>
>>>>>>> With that design here that currently doesn't work at all.
>>>>>>>
>>>>>>> We have two options, either use the drm_gpusvm notifier_lock as eviction_lock in amdgpu_vm.c or re-design amdgpu_vm.c to use the same approach for allocating page tables as XE.
>>>>>>>
>>>>>>> Some engineer from Valve is working on re-designing amdgpu_vm.c, but that will potentially take month if not years.
>>>>>>>
>>>>>>> So my take is that the new SVM code needs to modify amdgpu_vm.c so that the drm_gpusvm notifier_lock is used as eviction lock by the VM code.
>>>>>>>
>>>>>>
>>>>>>> Regards,
>>>>>>> Christian.
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>      - driver_svm_lock: In addition to the locking mentioned above, the
>>>>>>>>        driver should implement a lock to safeguard core GPU SVM function
>>>>>>>>        calls that modify state, such as drm_gpusvm_range_find_or_insert and
>>>>>>>>        drm_gpusvm_range_remove.
>>>>>>>>
>>>>>>>>      Two locks, two jobs.
>>>>>>>>
>>>>>>>> 2) The lock held in the MMU notifier is notifier_lock, never driver_svm_lock
>>>>>>>>
>>>>>>>>      drm_gpusvm_notifier_invalidate():
>>>>>>>>            down_write(&gpusvm->notifier_lock);
>>>>>>>>            ...
>>>>>>>>            gpusvm->ops->invalidate(gpusvm, notifier, mmu_range);
>>>>>>>>
>>>>>>>>      The driver invalidate callback runs under notifier_lock only. Per the
>>>>>>>>      framework's own notifier example it just unmaps pages
>>>>>>>>      and queues the range to the garbage collector no allocation, and it
>>>>>>>>      does not take driver_svm_lock:
>>>>>>>>
>>>>>>>>            drm_gpusvm_range_unmap_pages(...);
>>>>>>>>            drm_gpusvm_range_set_unmapped(...);
>>>>>>>>            driver_garbage_collector_add(...);
>>>>>>>>
>>>>>>>> 3) driver_svm_lock is by design an allocating, process context lock
>>>>>>>>
>>>>>>>>      drm_gpusvm_range_find_or_insert() asserts it and then allocates under it:
>>>>>>>>
>>>>>>>>            drm_gpusvm_range_find_or_insert():
>>>>>>>>                    drm_gpusvm_driver_lock_held(gpusvm);
>>>>>>>>                    ...
>>>>>>>>                    range = drm_gpusvm_range_alloc(...);
>>>>>>>>                    ... mmu_interval_notifier_insert(), kzalloc
>>>>>>>>
>>>>>>>>      drm_gpusvm_range_remove() asserts it and frees. This is only safe
>>>>>>>>      because driver_svm_lock is a sleepable, reclaim friendly lock that is
>>>>>>>>      never taken from the MMU notifier. Reference counting
>>>>>>>>       handles range *lifetime*, but it does not
>>>>>>>>      serialize tree insert/remove, which is exactly why the framework still
>>>>>>>>      asserts driver_svm_lock on those two entry points regardless of refcount.
>>>>>>>>
>>>>>>>> Now the three concrete points:
>>>>>>>>
>>>>>>>> A) Why the primary driver_svm_lock is required
>>>>>>>>
>>>>>>>>      It is a framework requirement, not an amdgpu invention:
>>>>>>>>       - DOC: Locking says the driver "should implement" it.
>>>>>>>>       - drm_gpusvm lockdep-asserts it on every structural entry:
>>>>>>>>         drm_gpusvm_range_find_or_insert() and drm_gpusvm_range_remove() both
>>>>>>>>         call drm_gpusvm_driver_lock_held().
>>>>>>>>       - The reference fault handler holds it across the whole fault:
>>>>>>>>         GC -> find_or_insert -> migrate -> get_pages -> bind.
>>>>>>>>
>>>>>>>>      Xe does exactly this:
>>>>>>>>       - xe_svm.c:      drm_gpusvm_driver_set_lock(&vm->svm.gpusvm, &vm->lock);
>>>>>>>>       - xe_pagefault.c: down_write(&vm->lock); before dispatching the fault
>>>>>>>>       - __xe_svm_handle_pagefault(): lockdep_assert_held_write(&vm- >lock);
>>>>>>>>         held across GC / find_or_insert / alloc_vram / get_pages / rebind
>>>>>>>>       - xe_svm_garbage_collector(): lockdep_assert_held_write(&vm- >lock);
>>>>>>>>
>>>>>>>>      amdgpu's svm_lock is the same driver_svm_lock, used the same way.
>>>>>>>>
>>>>>>>> B) Why eviction_lock cannot be that lock
>>>>>>>>
>>>>>>>>> This lock eviction_lock can only be grabbed while updating the mapping range.
>>>>>>>>
>>>>>>>>      and that is precisely why it cannot be driver_svm_lock.
>>>>>>>>      driver_svm_lock must wrap find_or_insert, migration, and
>>>>>>>>      drm_gpusvm_range_get_pages
>>>>>>>>      eviction_lock is the opposite by contract:
>>>>>>>>
>>>>>>>>       - It is taken with memalloc_noreclaim_save() in
>>>>>>>>         amdgpu_vm_begin_critical(), specifically so no reclaim happens while
>>>>>>>>         held (to avoid the reclaim -> MMU-notifier deadlock). Holding it
>>>>>>>>         across get_pages/migration breaks that.
>>>>>>>>       - TTM eviction try-locks it: amdgpu_vm_evictable() does
>>>>>>>>         scoped_cond_guard(mutex_try, return false, &vm- >eviction_lock) and
>>>>>>>>         sets vm->evicting. Long holds starve eviction.
>>>>>>>>       - It is a plain mutex that the SVM map path re-enters:
>>>>>>>>         amdgpu_svm_range_update_mapping() -> amdgpu_vm_map_range() ->
>>>>>>>>         amdgpu_vm_begin_critical() -> mutex_lock(&vm- >eviction_lock). If
>>>>>>>>         eviction_lock were also the outer SVM lock, this is a self- deadlock.
>>>>>>>>
>>>>>>>>      In short, eviction_lock has the contract of notifier_lock , not of
>>>>>>>>      driver_svm_lock. This is also why the current split is correct:
>>>>>>>>      svm_lock (outer) != eviction_lock (inner). Your own rule - "you can't
>>>>>>>>      call the VM code with the lock held, the VM code must take it itself" -
>>>>>>>>      is satisfied today only because they are separate: svm_lock is held
>>>>>>>>      while calling amdgpu_vm_map_range(), and amdgpu_vm_map_range() takes
>>>>>>>>      eviction_lock itself. Merging them is what would violate that rule.
>>>>>>>>
>>>>>>>>> No, they Xe vm->lock and eviction_lock are actually identical in the handling.
>>>>>>>>
>>>>>>>>      They are not. Xe's vm->lock is a rw_semaphore, the "outer most lock" of
>>>>>>>>      the VM , held down_write across the whole fault. amdgpu's
>>>>>>>>      eviction_lock is a mutex taken only inside amdgpu_vm_begin_critical()
>>>>>>>>      during a PT update, under memalloc_noreclaim. Xe's eviction/ reclaim
>>>>>>>>      handling is separate from vm->lock. The amdgpu analogue of Xe's vm->lock
>>>>>>>>      is svm_lock, not eviction_lock.
>>>>>>>>
>>>>>>>> C) Reusing an existing amdgpu_vm lock as the primary lock needs refactor amdgpu VM
>>>>>>>>
>>>>>>>>      Xe can register vm->lock because Xe's VM was designed with an outer
>>>>>>>>      rw_semaphore held across faults. amdgpu_vm has no such lock: only
>>>>>>>>      eviction_lock , the root PD dma_resv , and a few spinlocks.
>>>>>>>>
>>>>>>>>      So do it like Xe means introducing a dedicated, outer, sleepable VM
>>>>>>>>      lock held across the fault. That lock is exactly svm_lock. Folding it
>>>>>>>>      into struct amdgpu_vm as a general vm->lock is a core amdgpu VM refactor.
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Honglei
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Regards,
>>>>>>>>> Christian.
>>>>>>>>>
>>>>>>>>>> +
>>>>>>>>>> +#if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
>>>>>>>>>> +void amdgpu_svm_flush_tlb(struct amdgpu_svm *svm);
>>>>>>>>>> +
>>>>>>>>>> +int amdgpu_svm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>>>>>>>>>> +void amdgpu_svm_close(struct amdgpu_vm *vm);
>>>>>>>>>> +void amdgpu_svm_fini(struct amdgpu_vm *vm);
>>>>>>>>>> +
>>>>>>>>>> +void amdgpu_svm_put(struct amdgpu_svm *svm);
>>>>>>>>>> +struct amdgpu_svm *amdgpu_svm_lookup_by_pasid(struct amdgpu_device *adev,
>>>>>>>>>> +                           uint32_t pasid);
>>>>>>>>>> +int amdgpu_svm_handle_fault(struct amdgpu_device *adev, uint32_t pasid,
>>>>>>>>>> +                uint64_t fault_page, uint64_t ts,
>>>>>>>>>> +                bool write_fault);
>>>>>>>>>> +bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm);
>>>>>>>>>> +
>>>>>>>>>> +int amdgpu_gem_svm_ioctl(struct drm_device *dev, void *data,
>>>>>>>>>> +             struct drm_file *filp);
>>>>>>>>>> +void amdgpu_svm_clean_queue(struct amdgpu_svm *svm,
>>>>>>>>>> +                struct list_head *work_list);
>>>>>>>>>> +void amdgpu_svm_sync_work(struct amdgpu_svm *svm);
>>>>>>>>>> +int amdgpu_svm_garbage_collector(struct amdgpu_svm *svm);
>>>>>>>>>> +int amdgpu_svm_apply_attr_change(struct amdgpu_svm *svm,
>>>>>>>>>> +                 const struct amdgpu_svm_attrs *old_attrs,
>>>>>>>>>> +                 const struct amdgpu_svm_attrs *new_attrs,
>>>>>>>>>> +                 unsigned long start_page,
>>>>>>>>>> +                 unsigned long last_page);
>>>>>>>>>> +bool amdgpu_svm_devmem_possible(struct amdgpu_svm *svm);
>>>>>>>>>> +#else
>>>>>>>>>> +static inline int amdgpu_svm_init(struct amdgpu_device *adev,
>>>>>>>>>> +                  struct amdgpu_vm *vm)
>>>>>>>>>> +{
>>>>>>>>>> +    return 0;
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static inline void amdgpu_svm_close(struct amdgpu_vm *vm)
>>>>>>>>>> +{
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static inline void amdgpu_svm_fini(struct amdgpu_vm *vm)
>>>>>>>>>> +{
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static inline int amdgpu_svm_handle_fault(struct amdgpu_device *adev,
>>>>>>>>>> +                      uint32_t pasid,
>>>>>>>>>> +                      uint64_t fault_page,
>>>>>>>>>> +                      uint64_t ts,
>>>>>>>>>> +                      bool write_fault)
>>>>>>>>>> +{
>>>>>>>>>> +    return -EOPNOTSUPP;
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static inline bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm)
>>>>>>>>>> +{
>>>>>>>>>> +    return false;
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static inline int amdgpu_gem_svm_ioctl(struct drm_device *dev, void *data,
>>>>>>>>>> +                       struct drm_file *filp)
>>>>>>>>>> +{
>>>>>>>>>> +    return -EOPNOTSUPP;
>>>>>>>>>> +}
>>>>>>>>>> +#endif /* CONFIG_DRM_AMDGPU_SVM */
>>>>>>>>>> +
>>>>>>>>>> +#endif /* __AMDGPU_SVM_H__ */
>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/ gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>>>>>>> index ec1196d390bb7..30463a83e2e60 100644
>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>>>>>>> @@ -43,6 +43,7 @@ struct amdgpu_bo_va;
>>>>>>>>>>      struct amdgpu_job;
>>>>>>>>>>      struct amdgpu_bo_list_entry;
>>>>>>>>>>      struct amdgpu_bo_vm;
>>>>>>>>>> +struct amdgpu_svm;
>>>>>>>>>>        /*
>>>>>>>>>>       * GPUVM handling
>>>>>>>>>> @@ -373,6 +374,9 @@ struct amdgpu_vm {
>>>>>>>>>>            /* cached fault info */
>>>>>>>>>>          struct amdgpu_vm_fault_info fault_info;
>>>>>>>>>> +
>>>>>>>>>> +    /* SVM experimental implementation */
>>>>>>>>>> +    struct amdgpu_svm *svm;
>>>>>>>>>>      };
>>>>>>>>>>        struct amdgpu_vm_manager {
>>>>>>>>>
>>>>>>>>
>>>>>>
>>>>>
>>>
>>
> 

