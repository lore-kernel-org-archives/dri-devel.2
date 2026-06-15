Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DC4CD98DE
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 11:49:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D5DE10E3B0;
	Mon, 15 Jun 2026 11:49:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dr1RDzzM";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011039.outbound.protection.outlook.com [52.101.57.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7C7610E3AE;
 Mon, 15 Jun 2026 11:49:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqgtPCQS2LRmz4MolwmFGvnMBFCLuO8Dk3fw7krFkQwrcgNDIV6UVcOD6xKoqdnzRJHaGiFBQmdhxZpkPVZJLHdFclMYvWh3ZFn7fZCHo8BXzBOh3c9BP4IXShBJIYEYhHSN2S0Dvr0rQU/md0mPs4Cps4e4qGdBVQnF7cClfGbfchnT/pZOIzfoyorRgV+3H5/InFZ70ZUnuBPE6NCPbyOTv/bMA4YlLd8pmC1shenA1nae8LzXhA3xjm9i62+MlZqfXiDTVMJ+aoGBfjOMZcqX7tP5hUxxgQq4qHfSSAJOz8DOIwlch+ESG9QUnKCtr3CR850L5LSlnEcY1oLwsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9g1KBPtdDEP+8y939+6HGK8cAnHcAHD2p/jke4p8Ds=;
 b=DynmN+fIfQWcotqVodDbgvdKOdo5CM4CnXyyCP/1X6/DF0y2DkD08FLLTVgkMT1jvRArX/J2+pSoJStEFv5mM2LQ2kko49d5vnwe8HmUTbYF2sRJAQKixy/hxzX2peSeA284nbFPHg+dnGODdmB8RYyACxOYjs5+AEILC/rAYoileKBExwlsWAAHLhWY4XoBG0yBQZ5cAfU9MmZrBNpXkbPfviGR/jq/ztM33bdJiNRL4YDMYre0uAs53oc7X18Euzdrf7Vmy/oK08BvVs5ilInT95LV7Yyg4ZbgvxTIhR4zZ2+HegcQ/XfjYDJMDbxfan+7ujkrxxuz6UHemhirjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9g1KBPtdDEP+8y939+6HGK8cAnHcAHD2p/jke4p8Ds=;
 b=dr1RDzzMvjj0Da6bP1WObWAiIeUITJwl0y8hyDoB6rZnZ+7lpcVx1W/82Z7gl+VrCakugXqQuzwXNfJQcYlxguAFEMRV29lA3dKT1q0kLI4Teh3CzgrSNaDW+kE37HhAKRgTiHPMls0lX8cwNnOi1V/Q/T2Z2oFrgyE0JZIGlUE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB7623.namprd12.prod.outlook.com (2603:10b6:8:108::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 11:49:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Mon, 15 Jun 2026
 11:49:23 +0000
Message-ID: <81ead8f8-ffa8-4f92-89ef-b016d141b371@amd.com>
Date: Mon, 15 Jun 2026 13:49:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/18] drm/amdgpu: add SVM core header and VM
 integration
To: "Huang, Honglei" <honghuan@amd.com>, Huang Rui <ray.huang@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
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
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <a9e22971-ec11-4b9c-937c-30d202019f1e@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0260.namprd03.prod.outlook.com
 (2603:10b6:408:ff::25) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a479898-3793-4477-d371-08decad424ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /8OS4Oa2w+rEBcKJ+4pN8QcUENZ9NZ+vX2Dhe8j9pgte+apmkapmFEIujjW5oquorg83NMiK/9eojC00zTCk8gBs/KpNodaReGcHJJM+HyqQ9aGE5E/nsFAbGNCTD918Rt6nnmuYjFacC+nMNNvflLSyHYQ7RI2MAx7O+6lhl6LPh9qQNNqqovN4kmdAzKu9FhGaT8snt5UDTN+ZEE4GpmywMbXn1qe8h+k3YELuJfay0yfy1zOaPmyo3V+zNJHmjBZUZuAiaGpydh9s5arKfx0w/o69ukKqBGmPoIidfJEFfa4UjfV1WE5gCkp4RNQx5pxKyoOt9upyzOtuVmj4l/zrgxALvic77XqEmM2Lp0ukmM+rG4LAtwqRHt5AolowRw9PklrnvSyMAlVeC8mbJuRnNjJtjudDA1wWv2VfrzaKBVFge2zPfCiP0tpAxoD7rjHgB1G7KiBrK8k1sjxoO37/5CIBYQLqSzxjWFda65rlJas1Zfct/NtVIqLsoeHvi++4ogDm2H+CNLg9OJbnceUw8ltsDGvM56V3Wh+5WkLTjnuPKAWkUCJkLe1lhfJGi4srPvrbQ6bRP1zG6pJ/+M1Gvv5soOUQgHF2CArqc2BnmlHpzBWpy0tfLdseVCV3tSqnyX95EuzAYJ1AhXXne6QysPAsfQ7d8mOBqOabWkPHjm1pk5B/USmrEMSjaAKZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFRDbytRaWpYTGVzYmUvTkhyNS9qUFBiS0VFVTNEVUxoTnFwY0pjc0dhUldN?=
 =?utf-8?B?V0Q3eFk4L2pTblNueXU3VXRMTUQ3WHI2dVZIOXJPTTViWHJvOCtCb0Zxay9P?=
 =?utf-8?B?aElSK3ZzTUE5ZWpMZmZzbDU4YXFVZ1dKN2IwMi82ZDBmVzhpYitTMTFNSVUx?=
 =?utf-8?B?dEdWS2J0cU54TUlOblFOaHB4eWFLTVVnR3BIeHZRd2NTSk9EVDRGb2F3dENZ?=
 =?utf-8?B?YkZ4NDRJNmtpa1h0SVBXSVlUd25ITTRFTC9iSXZvWUFYRXhiVWFBRVJMQnV6?=
 =?utf-8?B?SFpCeit5QWR0WEN6M3ZsS3YxZkQ4L0tYYzNiWjU5MXF2djFRUFNJSm1TU212?=
 =?utf-8?B?Y1Iyc0ZCVW84bUIxRnczWnZUeXpvaHZydWRSeXlLbHEyWStFeGlVV2xRU0Jl?=
 =?utf-8?B?Qkg2SzBVaGJrc2ZXN1FIcng3VTdmV3FkVXcvYjNBRnRqNnhEZkRnZmh2QmhI?=
 =?utf-8?B?cUR3NXlEcVo0dSt2L2tGNk5sQm9HWURMbElJQU5HV0dYU1hSc2IxcjM0dXdH?=
 =?utf-8?B?TGt1cVNFOTRiUHlITXJMRXdxdHE4MEFpUVhxUXY0ZFRhdml3MjlSN1YzSkZQ?=
 =?utf-8?B?aStCN3JvckFjc3VtVEV1WENRTGgrc0tFNG5ESVR2OUhMN0wxQ1JWM3dwR3gy?=
 =?utf-8?B?RU5BaVlEOWUyV2xlcHh1ZDhjY3c3ZDVXMDUwNkdlZnBtTFowaGlEdElJRDJz?=
 =?utf-8?B?RWFrM0tMNDMxZThPdnZTaGpWdDU1ZTJtSW1HVVp3czVFZnpTemlIbEdkVGFt?=
 =?utf-8?B?Q3hSV1ZYWS85VU9nVlI4WHdud2REcU5PZ1QzaEhuSTVlY2g4VlNLZ0NDSURs?=
 =?utf-8?B?YkZJQm9DUnhoTklCMm1NYTNzbFp2THZFSEdrRHlPdDFxV1RsYUptTWI3ZmZE?=
 =?utf-8?B?Q1g5Ry9FdDgxZVNhNzZ6WXhQcGdZL2haWlhhTk1pcU1HY250OEJrcHBBNjJM?=
 =?utf-8?B?ME9JcHhuc2cvVGxsQ0hVVnFqb1BlR2E1OGllUGFaZjNIVGxQVXRLbWR5aHly?=
 =?utf-8?B?UVpib0UyZ2V1eGRtNGNLNlRmMjhDeGkxR1ViVjFoS2VVK2JVQWhkaGhaLzIv?=
 =?utf-8?B?RVBEdkh0MXR1M0JJOG1vdmV2SU85dlZScUJ6QmU0Z0lsNkx0T2JpZmVGQmNs?=
 =?utf-8?B?Y0JVVHlYMXloRG14Y0p3b0RrMXk4azM2Mm44Wms1dUxENXVtdEpXQURBSno5?=
 =?utf-8?B?cnA0ZEpDeUR5cEV1QXhoRWw1Vzd1MEVuVWordkJ3V3g4bGVoMTJHTmFRNUNK?=
 =?utf-8?B?L3dxZTgzaHhnakFab0RGWkU5WENXRkluYTRzeXFQUkt3a2d4bGwvUFRMN1BJ?=
 =?utf-8?B?TkdTdUV3a1RlcE4zWHo0RnUxKzhvbDFHWkIzQ29RM1dkeCtqOWVWM3VVNldN?=
 =?utf-8?B?b09lQ2YxZm5JRnpvbHRBWGVBOGlzbVBEVGcwMjhTZDVMelZ1cTR0Nk13QlN1?=
 =?utf-8?B?bnJkTDBUN1dCa3RnMHJPT2c0OXlvMXJ2T1VBTnczUkdDNWlYblRUQlR6VS9p?=
 =?utf-8?B?T2gvbXpKWXBlMTcrZnBEVmdLT1NETG1yUDkrbGx3Tkpac3pZYnVSUEFqS3J2?=
 =?utf-8?B?QklnQm9XY28zUUNJWC9hRnNtNE1oNVU4eXZSZ0NpOGcvcHlFWk4rQXdodUV6?=
 =?utf-8?B?aHZZd1VZclBKeHZ4L3RGSDZJZFJ3Z050dEtpcEF4aThWTy9CTUs1MVBmaTQ4?=
 =?utf-8?B?cGtsUUNiYmtXbngzazFIUndMNVRBMTFJVHJXRFJjaVFuQjVMdVgzWTFJWm9l?=
 =?utf-8?B?dDczM0NERkRHODl3Unp5OEtmaXROZ0wzaTJRaDhybUFpMWR4MG1qUXl2b0FE?=
 =?utf-8?B?VWw2NjU2aVloT1VVRDBKaU1Yb2s5a2gwQ1NmVXhWcjcrcHdaMWxYMmRSMHZk?=
 =?utf-8?B?VHhkNnRnS1pVd1lXdEF1SFQxQVg5ZHZyUStOcjZIVkF1MVNwa2FQd2s3aWtl?=
 =?utf-8?B?bERqY2lVQm03REFrRkFlQWR1dlc2WkpNK0NFWG0zUTkremNOSk9tV1d0L1lU?=
 =?utf-8?B?cS9oZ1c5ODhoeXlBNUNsckVTbm8yU0E1NGtaZW1JdlZmYnpmWnhXMmJ4QW9j?=
 =?utf-8?B?UnNPeHBtWk9nZTd0WEhuMkFmQXBRZW9lQ3Fua041Zi9pbncwUEJkdm1kRUNI?=
 =?utf-8?B?N1pvU29wcWZoNWdoU0VpSDVaaXVrOWg4a3dDN0gxVW5NdjBtbzhkTlFnZUhU?=
 =?utf-8?B?Yzlta3R5cFJQZDRQTFFSbTlaNnJNSU8rTUhXWkZ5WlJCZFJzMmY1WCs1RG13?=
 =?utf-8?B?a0JlRXZreU1zVGpuQTN4TEZGU0tqMFF0bnpZNEJzUGt6L3lrQ3NzRmRzUjRC?=
 =?utf-8?Q?bp8QD7PMozeYZeNjDl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a479898-3793-4477-d371-08decad424ba
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 11:49:23.3089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y07vm9eJ4rPYXDK6XKHmdLU2eV3EOt2kbcuxy17wTi11tvuG9/oQpz5DVZySp9Bb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7623
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

On 6/15/26 11:36, Huang, Honglei wrote:
> 
> 
> On 6/15/2026 4:08 PM, Christian König wrote:
>> On 6/12/26 15:20, Huang, Honglei wrote:
>>> On 6/12/2026 8:02 PM, Christian König wrote:
>>>> On 6/12/26 11:09, Huang Rui wrote:
>>>>> From: Honglei Huang <honghuan@amd.com>
>> ...
>>>>> +static inline void amdgpu_svm_assert_locked(struct amdgpu_svm *svm)
>>>>> +{
>>>>> +    lockdep_assert_held_write(&svm->svm_lock);
>>>>> +}
>>>>
>>>> What exactly is that lock protecting?
>>>>
>>>
>>> this lock is the driver_svm_lock required by the drm_gpusvm framework
>>> It is registered by drm_gpusvm_driver_set_lock(), and drm_gpusvm lockdep asserts it on every structural entry point, e.g.
>>> drm_gpusvm_range_find_or_insert() / drm_gpusvm_range_remove().
>>>
>>> Per amdgpu_svm it serializes the write/commit side against the fault
>>> handler: range/notifier tree insert+remove, attribute changes, and the
>>> garbage collector.
>>>
>>> This is the same thing xe does, in drivers/gpu/drm/xe/xe_svm.c:
>>>
>>> drm_gpusvm_driver_set_lock(&vm->svm.gpusvm, &vm->lock);
>>
>> This is clearly incorrect in that case. Our equivalent in amdgpu is vm->eviction_lock.
>>
>> That was already completely incorrect in the old KFD implementation, please don't use that one as blueprint.
> 
> I really want to use vm->eviction_lock as SVM primary lock,
> but it seems like in Xe, Xe uses vm->lock as an outer VM lock by design rwsem instead of mutex lock to broad VM ownership, not an eviction lock, they are semantically different.

No, they are actually identical in the handling.

> 
> I tried to replace the svm lock with eviction lock locally, ABBA dead lock encountered:
> 
> amdgpu_svm_handle_fault
>   amdgpu_svm_lock (A: eviction_lock)

That's nonsense. This lock can only be grabbed while updating the mapping range.

>     fault_map_range
>       amdgpu_svm_range_update_mapping
>              drm_gpusvm_notifier_lock (B)
> 
> 
> drm_gpusvm_notifier_invalidate
>    down_write(B - notifier_lock)

Same here. You simply can't call the VM code with the lock held.

The VM code itself must take it as appropriate.

Regards,
Christian.

>       amdgpu_svm_invalidate
>          amdgpu_svm_range_invalidate
>             amdgpu_svm_range_notifier_event_begin
>               amdgpu_svm_range_zap_ptes
>                 amdgpu_vm_update_range
>                    amdgpu_vm_eviction_lock (A: eviction_lock)
> 
> 
> the current SVM side can switch its registered driver lock at any time easily as you wish, but doing so safely is not just an amdgpu SVM local change.
> 
> The issue is that change lock / change lock registration is easy, while lock semantics are not. SVM execution paths like fault handling, invalidation, mapping updates, garbage collection, notifier callbacks... are coupled with VM locking and update flows follow the xe svm style. If we switch SVM to a different VM lock now, we can introduce lock recursion, ABBA lock...
> 
> SVM can technically switch lock registration now.
> But make all stack works and pass all tests maybe needs amdgpu VM refactoring.
> 
> Regards,
> Honglei
> 
> 
>>
>> Regards,
>> Christian.
>>
> 

