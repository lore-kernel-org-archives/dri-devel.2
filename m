Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB7EC5DF94
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:43:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8F2D10E8FC;
	Tue, 25 Aug 2026 07:43:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ir3/+FkN";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011004.outbound.protection.outlook.com
 [40.93.194.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1ADC10E8F9;
 Tue, 25 Aug 2026 07:43:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=amOmJITM9aIPtd0sNwG9WUxc0ixOBzqQWfeZO7LRAdNkepDvpSTTddllpZy8z/97P7x4OurToXHQwPHcLyaTmp+yOH7lGHic5TRwNA62WOwGwRi1/xqJf2RNvde/zWJZTHtKxQ0kCq+mf5+IETlIyum/VUtcAoiDpSaTICD5nebhJ5S4Tg2/rnmNj45FTwPKR4zm1vvT+YWWhtSxCmPeMmg44ZQSUrs8es2NkDLqeF0AF00qQvEOWixhND51g5TktV1fND6yyFMC5FUHpPx2+CmeFeAfnHvzmG0G7ujj5zzS/cv+xj7t4c94/XljKZ8JPwSIY8BYTFqLeF6pp52zGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9FWIHp5XPW8epnn9j6DBtmxe5TiQVFpYZsffxogqjs=;
 b=V//buEqAO+8stbpVYSPvvJ/frr5s+Ovd2RNRrFQz7WnsQMHAHzPax1r34kz8AlfJaHUTDIi/kVaC7SmIB1H9v429zJOPSjB9a+3h1oAW4rDdqal66rJ+j1c6/oXTdr0xeGcNxs6WGwJocIqZjm1maqVk0A/RS5C8xTbBS38NtORtWZaDqKi5h2sdmulvRi1SV+LgTTlV0qNRKUkW4HAgZmcPxeaHzIRxQBcKx3C9hJ2xX3TUETbUgkOEL+YokPoztQlVsq1MRT3jYWikQnwKMnvdqX1B1jOsqDxDWWXfoM98W/pFFVRd0XwErvcF5iFACC/MQnyAankOI5XTwLTsPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9FWIHp5XPW8epnn9j6DBtmxe5TiQVFpYZsffxogqjs=;
 b=ir3/+FkNVYh6aMCy8Y7fwPo1rc9/NNEKHDe4Crbi0L6KoZspY/FHofzhH3sFQ1woSMTPHUBf2ptx86eBFPbHV2FSEwBVRuU9yVkfLeWKMoYE1gDTFP35gij8D41az5d9HC6Hh/ffsRz6fZHajcKohYNtIlryiflSuSfnNy8OQqE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by CH3PR12MB9024.namprd12.prod.outlook.com (2603:10b6:610:176::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 07:43:03 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%6]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 07:43:03 +0000
Message-ID: <9debc6fa-268b-49a7-9af6-20660bc2b1b3@amd.com>
Date: Tue, 25 Aug 2026 15:42:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/18] drm/amdgpu: add SVM core header and VM
 integration
From: Honglei Huang <honghuan@amd.com>
To: Christian KKKnig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>
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
Content-Language: en-US
In-Reply-To: <bef7c6cc-d3b7-492f-abef-bf87e49c6b3e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0038.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::11) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|CH3PR12MB9024:EE_
X-MS-Office365-Filtering-Correlation-Id: 4294df6b-c3c5-4354-58d2-08df027c7e4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4v1kbYTfdwvGXs84rF5tBioeTjbvVlFKp9e9Za8kYFXb1HnqfMrgDg6l+Ns5PqPvLKdijn+MI4OGeJwfPOvCq4iv3Clst4Ipo0PXyRx+nzgGfG1dMokISyllgTDmAX/yBafEbf5tndzoqSDViauInX1UKoQkoXJ/roiTl4YiRFHQFWqcaPcoNhOvJXM90VmT3EaGI2zIjGrAzy8FM/rYxeuEs6cCeH9DYL8wf7BdExLVevX6AhxgIeiZ2FFF/L63tyhC3JsQKN7cIr4UFBSrBDXdModLyK5IaiWd4PEu5u7pl6tn2iG8x1Kvrvzb7wLwXWGIzQLnpfBAp2VHtVHcrrsyPBBrhcxv+IEvOoFG9VqBVO0lInFzwFwuraTDZEQ5K8JO/AdyB2GDe6fNKTY+9VhBPTC8C+caaywc4AJ+tbiJaWB823VcIIU95QJilFmQ+ZhRjMDQl23aJmc9cRhyHKFqQMYjGMZ5FK7p/X8EbZO/Vrb1Xr8yzdLtDAWgivmca7KbhQToDviAY6/MKSaT633Dt3l8dFNqwtNN0y3I5RYVcu0JBzMM1FkEyFxz1918znOHKbLxBon87FswX/E+RF92sY+qmQySchFEFfcut2JAybeMeVa1QznwEg+upD1iGkmvPZ7im7SGj5aeYZubjHZWg5getp6DIVbKHp5lw1Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZU90NXBqd2t1aXJ2T2JMWHo3dUJsL2syWTB0VmxCUmJUd3lnVjl6QmE0Lzho?=
 =?utf-8?B?cVd0T2F4U09zNTRNdzc4aGpibmJwZ3NwY0U2dk1sRVNLSmxNMGJkTDFSQ2pX?=
 =?utf-8?B?dnVNTWtRNDhVa09wNXJFUjZFUk5XMS9BaHoydG9yMmhsaytFWVI5ZXd1VnlQ?=
 =?utf-8?B?d3RMVTAvcDRFbUUvcVNUVGpmaTZmU3Zzcy9UM01XWHRzazZ1VVhKZFlMR2lp?=
 =?utf-8?B?VE9nL20wTnI0NkdRRzNtMnFESXhkaXJQQVZWcWJ4LzI3WktyeVlRVzROcUhS?=
 =?utf-8?B?VkhnMitlamowS3dmbUNPQkU0THdwQk4vSStBSjE4SHVXU2VQZGdSWkhDc1Nz?=
 =?utf-8?B?Z0diNElnNVYyd2c3YUNOTWo5OUhuM0RQelF3Nm52bWVGeVJNTmhGekF5VnIw?=
 =?utf-8?B?bnU0S3lYaFN5Ulk3cGhzYTljbHoxNDBsUzk1WjZpYnpuZlVRTWJjZmlUYzVy?=
 =?utf-8?B?czFKeDh2Y1FrZERUM3FWMnFMWENTQkpCZG5uRlhnNzE3WHBnZlZoS0JlK3Nk?=
 =?utf-8?B?UjE3UFZ3UEJaOCtpVURyaStOdHJlZnBHQnF1YWlEZnJxaU9vdGs3dXFEVW9C?=
 =?utf-8?B?RFEwbUJSUjltZjJ2eVVRcElHVVlMNjRueXVZNEhLNCtQOTlvSi8vVTdEaWFn?=
 =?utf-8?B?OVdZWnpYVTVqSDNWQWlDWFRNQUNncjI2M2U5NXFuMEZ3bS9VRElucXVtcWhq?=
 =?utf-8?B?RHE3eDQxUEg0YXNTcDJEVWxJSnh1NUordkdETFMxMERKdkpBTnh6SmVUcmpH?=
 =?utf-8?B?ckN6RHFpNmM3WVZtZnNWMHRpd1FueG01SjBUL0ZuUDVHNzBQMzZPclFSWm1S?=
 =?utf-8?B?aWp1SHphQno5eDh1TWVDWTArRVZGYmJsSittdnVQUXVFc0hxQ2JpcVpmeGR0?=
 =?utf-8?B?MnY3Uk5La2FWZmoxK1VzTldMMVluaS84SDZEdERTWVJzL2wvZ3ZYbXhqUGdX?=
 =?utf-8?B?QXQ5U2dkTFgzZHAxRWVYQ0NVK0pWaU1FRjB0RlZaZXpoR0ZRaXJuRmZOeUEx?=
 =?utf-8?B?TE1GcGhkdVVmRlF4ZXdhcXFjYnVBVkFRcU5oYUZncms2VGtnakhrSmhhY1RJ?=
 =?utf-8?B?cU9wQ0pDNmJTSXJzY3hwbTBQaFN2YlJLQzhUUjVHYzRUN1hidFVVYXNYdDUx?=
 =?utf-8?B?R3RlWDR6MXRncEsxWFNBQUt5U01PSGo0b3g4eVVtZDF0by91bmd4eVpyVWdo?=
 =?utf-8?B?amR1VEVKWkxNaFR3ZmVyc2NqcS9keElBNERXUlVoQUhXWitBMzdyTDk1U21u?=
 =?utf-8?B?RkYrTnBUb1haRkFyeDFhM05mRGticCtHbnlDN3AyZ3AxaEo0bUhZWGhQK1hx?=
 =?utf-8?B?R1BlREg1VDBLMUtWcmFSeDB0TllKVE9SQ3hmbVQweWkwZmdiOWlidDMzdWo3?=
 =?utf-8?B?WGZ6Mis5R1dSQVdPU3pVeitrZXdwK3Bna0ZZenVuRTJIbXM2dVYrdDJGME5B?=
 =?utf-8?B?cWgxTjRjQjlLaEJGNU1yWkkyZXVuMkhUcUFLUWRjRzZXUFRGQzk0cjFWY05H?=
 =?utf-8?B?cVp4MzNhTEozVXpEQVJYeGpHY0ltYk8yb1FvNk12TVhGVGswMU9SU3JoQjBP?=
 =?utf-8?B?aUdZRzUrVXpkRzUyWHNaTzdFdWJCaGUwcDkrbGZidHlJOVJOeGc0YzFpZzRv?=
 =?utf-8?B?akZ6aXlkK3AybXRnZ2pZRVgvbE5pTTNMd1hyb0FCT05La2FWWVpYU24zM25k?=
 =?utf-8?B?TnZDVzR6ZFlWSW5FY1pEZGttOFVzU3NkOTV2bnZNV3pqTHk5aUEwMUo0c1di?=
 =?utf-8?B?UVhyVmhXSEVMYW9qRUkrbkZpY0Jha0RRUlhoUjJucjkrVXN1NStwdWdneVhT?=
 =?utf-8?B?VTluTHRQVTRPNUZyQkc1TnVDQ0FjQ1FtNmdNelQ5c1dkNW9ZdVdvZTJHTzRG?=
 =?utf-8?B?MGhYNUxURkNqTTllalRBRVBHOHdGN0pOUlNxTjNLcUhWc0dzekJ5NGp4OUty?=
 =?utf-8?B?dkh5aFVCS2VBSko4TTV4L1BxQ2lhOUpEVDN3elJwcmUzdTN6SG9WWnhNdm1Q?=
 =?utf-8?B?QnIyNkFhVGw5YVZaQmJMYmdvVWRuUmoya3ozZUJhUjE2NnRtUk9jK29wdTgw?=
 =?utf-8?B?YXRWMk5MOE1Ud1pQWXo3L3pnK0VsMmhFcGlBYThwSFp1VUVxYTg0UVcwNnlj?=
 =?utf-8?B?MEZYV3hla0plckpldjFmNWFwMUdEaW01dm9VOVkwemU0clltRkdLYS9qbGls?=
 =?utf-8?B?MGVKYTEzcnpHODd3b3BSanR0OXdHT3pWOXF4QWNPeGw4MXRKWDhDVDVwSGpz?=
 =?utf-8?B?M3ZuZGhTd3dQWjZvelc1VHRJTUpVQkdMc0dYSmRUR254T1Y0a3hDUzNFVE1H?=
 =?utf-8?Q?r/aRD6l9hcCrxtDTxS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4294df6b-c3c5-4354-58d2-08df027c7e4d
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 07:43:02.9808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRLi+Rp+1DlYT5G0AgbtUpecUnx3wRqtT5w+ISP3FRdsGYEleC6+70dW6FI1Q91NYKmz1zJABjM+lzlJiBF3Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9024
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



On 8/13/26 17:16, Huang, Honglei wrote:

...

>>>
>>
>> So, if I understand your point correctly, the best way to solve the
>> serialization issue between these two locks is to turn them into a single
>> lock. Given that a full re-design of amdgpu_vm could take a significant
>> amount of time, it seems that using drm_gpusvm's notifier_lock as a
>> replacement for eviction_lock in amdgpu_vm would be the more practical
>> short-term solution.
>>
>> Please correct me if I've misunderstood your position.
>>
>> Thanks,
>> Ray
> 
> 
> Hi Christian,
> 
> I made some changes based on your modification to unify the locking,
> only use the notifier lock when svm is enabled,
> instead of using notifier lock and eviciton lock at the same time.
> 
> see diff below, not sure if it is correct, so confirming with you：
> 
> 
>   static inline int amdgpu_vm_begin_critical(struct 
> amdgpu_vm_update_params *p)
>   {
> -    mutex_lock(&p->vm->eviction_lock);
> +    struct amdgpu_vm *vm = p->vm;
> +
> +    if (vm->svm)
> +        down_read(&vm->svm->gpusvm.notifier_lock);
> +    else
> +        mutex_lock(&vm->eviction_lock);
>       p->saved_flags = memalloc_noreclaim_save();
> -    if (p->vm->evicting)
> +    if (vm->evicting)
>           return -EBUSY;
>       if (p->hmm_range && !amdgpu_hmm_range_valid(p->hmm_range))
>           return -EAGAIN;
> @@ -174,8 +181,13 @@ static inline int amdgpu_vm_begin_critical(struct 
> amdgpu_vm_update_params *p)
>    */
>   static inline void amdgpu_vm_end_critical(struct 
> amdgpu_vm_update_params *p)
>   {
> +    struct amdgpu_vm *vm = p->vm;
> +
>       memalloc_noreclaim_restore(p->saved_flags);
> -    mutex_unlock(&p->vm->eviction_lock);
> +    if (vm->svm)
> +        up_read(&vm->svm->gpusvm.notifier_lock);
> +    else
> +        mutex_unlock(&vm->eviction_lock);
>   }
> 
> 
> if above is valid, I have a question that
> some places still not using begin/end critical, using vm->eviction_lock 
> directly, do thoes places need to be changed?
> amdgpu_vm_evictable():
>      scoped_cond_guard(mutex_try, return false, &vm->eviction_lock)
> 
> amdgpu_vm_validate():
>      scoped_guard(mutex, &vm->eviction_lock)
> 
> amdgpu_vm_ready()
>      scoped_guard(mutex, &vm->eviction_lock)
> 
> Regards,
> Honglei
> 

Hi Christian,

Following up on my previous mail, I changed the change. The diff to the 
existing VM code is below.

Does this look correct to you? for unify notifier lock and eviction lock.

diff:

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h 
b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
@@ -28,6 +28,7 @@
  #include "amdgpu_hmm.h"
  #include "amdgpu_vm.h"
+#include "amdgpu_svm.h"
@@ -66,6 +67,9 @@ struct amdgpu_vm_update_params {
      bool unlocked;

+	/** @svm_locked: caller already holds the drm_gpusvm notifier_lock */
+	bool svm_locked;
+
      /**
       * @pages_addr:
@@ -143,6 +147,30 @@
+/* SVM VMs serialize eviction under the notifier_lock (write); others 
use eviction_lock. */
+static inline void amdgpu_vm_eviction_lock(struct amdgpu_vm *vm)
+{
+	if (amdgpu_svm_is_enabled(vm))
+		down_write(&vm->svm->gpusvm.notifier_lock);
+	else
+		mutex_lock(&vm->eviction_lock);
+}
+
+static inline void amdgpu_vm_eviction_unlock(struct amdgpu_vm *vm)
+{
+	if (amdgpu_svm_is_enabled(vm))
+		up_write(&vm->svm->gpusvm.notifier_lock);
+	else
+		mutex_unlock(&vm->eviction_lock);
+}
+
+static inline bool amdgpu_vm_eviction_trylock(struct amdgpu_vm *vm)
+{
+	if (amdgpu_svm_is_enabled(vm))
+		return down_write_trylock(&vm->svm->gpusvm.notifier_lock);
+	return mutex_trylock(&vm->eviction_lock);
+}
+
  static inline int amdgpu_vm_begin_critical(struct 
amdgpu_vm_update_params *p)
  {
+	if (amdgpu_svm_is_enabled(p->vm)) {
+		if (p->svm_locked)
+			lockdep_assert_held(&p->vm->svm->gpusvm.notifier_lock);
+		else
+			down_read(&p->vm->svm->gpusvm.notifier_lock);
+		p->saved_flags = memalloc_noreclaim_save();
+		if (p->vm->evicting)
+			return -EBUSY;
+		return 0;
+	}
+
      mutex_lock(&p->vm->eviction_lock);
      p->saved_flags = memalloc_noreclaim_save();
      if (p->vm->evicting)
@@ static inline void amdgpu_vm_end_critical(struct 
amdgpu_vm_update_params *p)
      memalloc_noreclaim_restore(p->saved_flags);
+	if (amdgpu_svm_is_enabled(p->vm)) {
+		if (!p->svm_locked)
+			up_read(&p->vm->svm->gpusvm.notifier_lock);
+		return;
+	}
      mutex_unlock(&p->vm->eviction_lock);
  }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ amdgpu_vm_validate():
-	scoped_guard(mutex, &vm->eviction_lock)
-		vm->evicting = false;
+	amdgpu_vm_eviction_lock(vm);
+	vm->evicting = false;
+	amdgpu_vm_eviction_unlock(vm);
@@ amdgpu_vm_ready():
-	scoped_guard(mutex, &vm->eviction_lock)
-		ret = !vm->evicting;
+	amdgpu_vm_eviction_lock(vm);
+	ret = !vm->evicting;
+	amdgpu_vm_eviction_unlock(vm);
@@ amdgpu_vm_evictable():
-	scoped_cond_guard(mutex_try, return false, &vm->eviction_lock) {
-		if (!dma_fence_is_signaled(vm->last_unlocked))
-			return false;
-		vm->evicting = true;
-	}
+	if (!amdgpu_vm_eviction_trylock(vm))
+		return false;
+	if (!dma_fence_is_signaled(vm->last_unlocked)) {
+		amdgpu_vm_eviction_unlock(vm);
+		return false;
+	}
+	vm->evicting = true;
+	amdgpu_vm_eviction_unlock(vm);
      return true;
@@ amdgpu_vm_map_range() / amdgpu_vm_unmap_range():   /* +bool 
svm_locked param, params.svm_locked = svm_locked; non-SVM callers pass 
false */

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ /* amdgpu_vm_map_range()/amdgpu_vm_unmap_range() declarations: +bool 
svm_locked */

Regards,
Honglei


>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> Regards,
>>>> Honglei
>>>>
>>>>>
>>>>> The background is that XE uses a different page table allocation 
>>>>> approach than amdgpu and we need to drop this lock in amdgpu to be 
>>>>> able to allocate page tables. See function amdgpu_vm_pt_alloc().
>>>>>
>>>>> With that design here that currently doesn't work at all.
>>>>>
>>>>> We have two options, either use the drm_gpusvm notifier_lock as 
>>>>> eviction_lock in amdgpu_vm.c or re-design amdgpu_vm.c to use the 
>>>>> same approach for allocating page tables as XE.
>>>>>
>>>>> Some engineer from Valve is working on re-designing amdgpu_vm.c, 
>>>>> but that will potentially take month if not years.
>>>>>
>>>>> So my take is that the new SVM code needs to modify amdgpu_vm.c so 
>>>>> that the drm_gpusvm notifier_lock is used as eviction lock by the 
>>>>> VM code.
>>>>>
>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>
>>>>>>
>>>>>>     - driver_svm_lock: In addition to the locking mentioned above, 
>>>>>> the
>>>>>>       driver should implement a lock to safeguard core GPU SVM 
>>>>>> function
>>>>>>       calls that modify state, such as 
>>>>>> drm_gpusvm_range_find_or_insert and
>>>>>>       drm_gpusvm_range_remove.
>>>>>>
>>>>>>     Two locks, two jobs.
>>>>>>
>>>>>> 2) The lock held in the MMU notifier is notifier_lock, never 
>>>>>> driver_svm_lock
>>>>>>
>>>>>>     drm_gpusvm_notifier_invalidate():
>>>>>>           down_write(&gpusvm->notifier_lock);
>>>>>>           ...
>>>>>>           gpusvm->ops->invalidate(gpusvm, notifier, mmu_range);
>>>>>>
>>>>>>     The driver invalidate callback runs under notifier_lock only. 
>>>>>> Per the
>>>>>>     framework's own notifier example it just unmaps pages
>>>>>>     and queues the range to the garbage collector no allocation, 
>>>>>> and it
>>>>>>     does not take driver_svm_lock:
>>>>>>
>>>>>>           drm_gpusvm_range_unmap_pages(...);
>>>>>>           drm_gpusvm_range_set_unmapped(...);
>>>>>>           driver_garbage_collector_add(...);
>>>>>>
>>>>>> 3) driver_svm_lock is by design an allocating, process context lock
>>>>>>
>>>>>>     drm_gpusvm_range_find_or_insert() asserts it and then 
>>>>>> allocates under it:
>>>>>>
>>>>>>           drm_gpusvm_range_find_or_insert():
>>>>>>                   drm_gpusvm_driver_lock_held(gpusvm);
>>>>>>                   ...
>>>>>>                   range = drm_gpusvm_range_alloc(...);
>>>>>>                   ... mmu_interval_notifier_insert(), kzalloc
>>>>>>
>>>>>>     drm_gpusvm_range_remove() asserts it and frees. This is only safe
>>>>>>     because driver_svm_lock is a sleepable, reclaim friendly lock 
>>>>>> that is
>>>>>>     never taken from the MMU notifier. Reference counting
>>>>>>      handles range *lifetime*, but it does not
>>>>>>     serialize tree insert/remove, which is exactly why the 
>>>>>> framework still
>>>>>>     asserts driver_svm_lock on those two entry points regardless 
>>>>>> of refcount.
>>>>>>
>>>>>> Now the three concrete points:
>>>>>>
>>>>>> A) Why the primary driver_svm_lock is required
>>>>>>
>>>>>>     It is a framework requirement, not an amdgpu invention:
>>>>>>      - DOC: Locking says the driver "should implement" it.
>>>>>>      - drm_gpusvm lockdep-asserts it on every structural entry:
>>>>>>        drm_gpusvm_range_find_or_insert() and 
>>>>>> drm_gpusvm_range_remove() both
>>>>>>        call drm_gpusvm_driver_lock_held().
>>>>>>      - The reference fault handler holds it across the whole fault:
>>>>>>        GC -> find_or_insert -> migrate -> get_pages -> bind.
>>>>>>
>>>>>>     Xe does exactly this:
>>>>>>      - xe_svm.c:      drm_gpusvm_driver_set_lock(&vm->svm.gpusvm, 
>>>>>> &vm->lock);
>>>>>>      - xe_pagefault.c: down_write(&vm->lock); before dispatching 
>>>>>> the fault
>>>>>>      - __xe_svm_handle_pagefault(): lockdep_assert_held_write(&vm- 
>>>>>> >lock);
>>>>>>        held across GC / find_or_insert / alloc_vram / get_pages / 
>>>>>> rebind
>>>>>>      - xe_svm_garbage_collector(): lockdep_assert_held_write(&vm- 
>>>>>> >lock);
>>>>>>
>>>>>>     amdgpu's svm_lock is the same driver_svm_lock, used the same way.
>>>>>>
>>>>>> B) Why eviction_lock cannot be that lock
>>>>>>
>>>>>>> This lock eviction_lock can only be grabbed while updating the 
>>>>>>> mapping range.
>>>>>>
>>>>>>     and that is precisely why it cannot be driver_svm_lock.
>>>>>>     driver_svm_lock must wrap find_or_insert, migration, and
>>>>>>     drm_gpusvm_range_get_pages
>>>>>>     eviction_lock is the opposite by contract:
>>>>>>
>>>>>>      - It is taken with memalloc_noreclaim_save() in
>>>>>>        amdgpu_vm_begin_critical(), specifically so no reclaim 
>>>>>> happens while
>>>>>>        held (to avoid the reclaim -> MMU-notifier deadlock). 
>>>>>> Holding it
>>>>>>        across get_pages/migration breaks that.
>>>>>>      - TTM eviction try-locks it: amdgpu_vm_evictable() does
>>>>>>        scoped_cond_guard(mutex_try, return false, &vm- 
>>>>>> >eviction_lock) and
>>>>>>        sets vm->evicting. Long holds starve eviction.
>>>>>>      - It is a plain mutex that the SVM map path re-enters:
>>>>>>        amdgpu_svm_range_update_mapping() -> amdgpu_vm_map_range() ->
>>>>>>        amdgpu_vm_begin_critical() -> mutex_lock(&vm- 
>>>>>> >eviction_lock). If
>>>>>>        eviction_lock were also the outer SVM lock, this is a self- 
>>>>>> deadlock.
>>>>>>
>>>>>>     In short, eviction_lock has the contract of notifier_lock , 
>>>>>> not of
>>>>>>     driver_svm_lock. This is also why the current split is correct:
>>>>>>     svm_lock (outer) != eviction_lock (inner). Your own rule - 
>>>>>> "you can't
>>>>>>     call the VM code with the lock held, the VM code must take it 
>>>>>> itself" -
>>>>>>     is satisfied today only because they are separate: svm_lock is 
>>>>>> held
>>>>>>     while calling amdgpu_vm_map_range(), and amdgpu_vm_map_range() 
>>>>>> takes
>>>>>>     eviction_lock itself. Merging them is what would violate that 
>>>>>> rule.
>>>>>>
>>>>>>> No, they Xe vm->lock and eviction_lock are actually identical in 
>>>>>>> the handling.
>>>>>>
>>>>>>     They are not. Xe's vm->lock is a rw_semaphore, the "outer most 
>>>>>> lock" of
>>>>>>     the VM , held down_write across the whole fault. amdgpu's
>>>>>>     eviction_lock is a mutex taken only inside 
>>>>>> amdgpu_vm_begin_critical()
>>>>>>     during a PT update, under memalloc_noreclaim. Xe's eviction/ 
>>>>>> reclaim
>>>>>>     handling is separate from vm->lock. The amdgpu analogue of 
>>>>>> Xe's vm->lock
>>>>>>     is svm_lock, not eviction_lock.
>>>>>>
>>>>>> C) Reusing an existing amdgpu_vm lock as the primary lock needs 
>>>>>> refactor amdgpu VM
>>>>>>
>>>>>>     Xe can register vm->lock because Xe's VM was designed with an 
>>>>>> outer
>>>>>>     rw_semaphore held across faults. amdgpu_vm has no such lock: only
>>>>>>     eviction_lock , the root PD dma_resv , and a few spinlocks.
>>>>>>
>>>>>>     So do it like Xe means introducing a dedicated, outer, 
>>>>>> sleepable VM
>>>>>>     lock held across the fault. That lock is exactly svm_lock. 
>>>>>> Folding it
>>>>>>     into struct amdgpu_vm as a general vm->lock is a core amdgpu 
>>>>>> VM refactor.
>>>>>>
>>>>>> Regards,
>>>>>> Honglei
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> Regards,
>>>>>>> Christian.
>>>>>>>
>>>>>>>> +
>>>>>>>> +#if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
>>>>>>>> +void amdgpu_svm_flush_tlb(struct amdgpu_svm *svm);
>>>>>>>> +
>>>>>>>> +int amdgpu_svm_init(struct amdgpu_device *adev, struct 
>>>>>>>> amdgpu_vm *vm);
>>>>>>>> +void amdgpu_svm_close(struct amdgpu_vm *vm);
>>>>>>>> +void amdgpu_svm_fini(struct amdgpu_vm *vm);
>>>>>>>> +
>>>>>>>> +void amdgpu_svm_put(struct amdgpu_svm *svm);
>>>>>>>> +struct amdgpu_svm *amdgpu_svm_lookup_by_pasid(struct 
>>>>>>>> amdgpu_device *adev,
>>>>>>>> +                           uint32_t pasid);
>>>>>>>> +int amdgpu_svm_handle_fault(struct amdgpu_device *adev, 
>>>>>>>> uint32_t pasid,
>>>>>>>> +                uint64_t fault_page, uint64_t ts,
>>>>>>>> +                bool write_fault);
>>>>>>>> +bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm);
>>>>>>>> +
>>>>>>>> +int amdgpu_gem_svm_ioctl(struct drm_device *dev, void *data,
>>>>>>>> +             struct drm_file *filp);
>>>>>>>> +void amdgpu_svm_clean_queue(struct amdgpu_svm *svm,
>>>>>>>> +                struct list_head *work_list);
>>>>>>>> +void amdgpu_svm_sync_work(struct amdgpu_svm *svm);
>>>>>>>> +int amdgpu_svm_garbage_collector(struct amdgpu_svm *svm);
>>>>>>>> +int amdgpu_svm_apply_attr_change(struct amdgpu_svm *svm,
>>>>>>>> +                 const struct amdgpu_svm_attrs *old_attrs,
>>>>>>>> +                 const struct amdgpu_svm_attrs *new_attrs,
>>>>>>>> +                 unsigned long start_page,
>>>>>>>> +                 unsigned long last_page);
>>>>>>>> +bool amdgpu_svm_devmem_possible(struct amdgpu_svm *svm);
>>>>>>>> +#else
>>>>>>>> +static inline int amdgpu_svm_init(struct amdgpu_device *adev,
>>>>>>>> +                  struct amdgpu_vm *vm)
>>>>>>>> +{
>>>>>>>> +    return 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static inline void amdgpu_svm_close(struct amdgpu_vm *vm)
>>>>>>>> +{
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static inline void amdgpu_svm_fini(struct amdgpu_vm *vm)
>>>>>>>> +{
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static inline int amdgpu_svm_handle_fault(struct amdgpu_device 
>>>>>>>> *adev,
>>>>>>>> +                      uint32_t pasid,
>>>>>>>> +                      uint64_t fault_page,
>>>>>>>> +                      uint64_t ts,
>>>>>>>> +                      bool write_fault)
>>>>>>>> +{
>>>>>>>> +    return -EOPNOTSUPP;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static inline bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm)
>>>>>>>> +{
>>>>>>>> +    return false;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static inline int amdgpu_gem_svm_ioctl(struct drm_device *dev, 
>>>>>>>> void *data,
>>>>>>>> +                       struct drm_file *filp)
>>>>>>>> +{
>>>>>>>> +    return -EOPNOTSUPP;
>>>>>>>> +}
>>>>>>>> +#endif /* CONFIG_DRM_AMDGPU_SVM */
>>>>>>>> +
>>>>>>>> +#endif /* __AMDGPU_SVM_H__ */
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/ 
>>>>>>>> gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>>>>> index ec1196d390bb7..30463a83e2e60 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>>>>> @@ -43,6 +43,7 @@ struct amdgpu_bo_va;
>>>>>>>>     struct amdgpu_job;
>>>>>>>>     struct amdgpu_bo_list_entry;
>>>>>>>>     struct amdgpu_bo_vm;
>>>>>>>> +struct amdgpu_svm;
>>>>>>>>       /*
>>>>>>>>      * GPUVM handling
>>>>>>>> @@ -373,6 +374,9 @@ struct amdgpu_vm {
>>>>>>>>           /* cached fault info */
>>>>>>>>         struct amdgpu_vm_fault_info fault_info;
>>>>>>>> +
>>>>>>>> +    /* SVM experimental implementation */
>>>>>>>> +    struct amdgpu_svm *svm;
>>>>>>>>     };
>>>>>>>>       struct amdgpu_vm_manager {
>>>>>>>
>>>>>>
>>>>
>>>
> 

