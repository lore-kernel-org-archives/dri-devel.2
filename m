Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD61BC61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 06:36:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79C4210EE80;
	Thu, 27 Aug 2026 06:36:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kBDG9F1b";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012024.outbound.protection.outlook.com
 [40.93.195.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FA5710EE76;
 Thu, 27 Aug 2026 06:36:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXE3esS+1P6KIAPxZ80L7eKsUqpoIjcomMildKRKEVAOdfyFlCNvA8e+FSjCn4JugEY1fPiexoCPqqJ6XG4cl7EEvmO6nV/b0o57Ld5iL3e4RYXxj3ORHeKBYaVbK81h/3/i7qOeed8+v1o3kXxY/KxuuB39Fj7Fhijo4QXfM51cjyq9cIuDf9TnRsb3HBFNIC4jM9IGgTCJSJYqbh8gI6MQdLwie4QxSX/lEhUCXeMjZuSYt2XPQFi2vXSkI/9JyfII8JThMX8BoGDVqBbWeSQHzIQM7L+tZzsv3RpH1/QiNLfXBqwv8H2TPMB/p/k6a01B+uQCZSPGz5MWRaE1Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2tlHeTG0UpSFxBhXffQEPRpf3YV+yo1hNJYVqBGbvs=;
 b=JteClKncbp2+DNNrs429PgxtOfVxwQYmbY1AuBbd7h25SpchP0RwwLURsrHTxiRjia/QKk9Ah0RPIayEWhQpnRAaFPmf2ukdKPyM6ngCxzncT96z90jOK8/Tx79C5Lt8nna4LqaoWkvEZ6qT5sM/ry9BYWtGgLK5BZEylsuXOUBRpMViW6dO22dtuIBT1TIcOPTCFdjzF9uBVf/j3nWUsX21pjfk9x7fr5jWS6PBebCs/eTyy9w4iOLhgLfMoA+SCWnMdxXvJVel7rbqlNE6K9rIuJoRGokZZlX+11YNITMt/1ZP6sdTMuopbNurGWjYvi6lRMgVQxecRFStP/kjrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2tlHeTG0UpSFxBhXffQEPRpf3YV+yo1hNJYVqBGbvs=;
 b=kBDG9F1b9e+pPX5pyOt2n7AFImh9B1cHgq5eAelI62L05SSqRsInpbWUuXHaU6si03LtNYrZeMgxKwsvCKdqHb74sTe1psFC8zEEACADAQVwJ9a2jqmBiihpqT+YSDetmnBHGt7uFrHKeZh4x5vCnBEKE4yLEiOR406QMbIdUxk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7653.namprd12.prod.outlook.com (2603:10b6:8:13e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Thu, 27 Aug
 2026 06:36:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Thu, 27 Aug 2026
 06:36:41 +0000
Message-ID: <49d20e9c-8f34-4409-8736-c4ecbe8ced3c@amd.com>
Date: Thu, 27 Aug 2026 08:36:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/18] drm/amdgpu: add SVM core header and VM
 integration
To: Honglei Huang <honghuan@amd.com>, Huang Rui <ray.huang@amd.com>
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
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <9debc6fa-268b-49a7-9af6-20660bc2b1b3@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7653:EE_
X-MS-Office365-Filtering-Correlation-Id: dc6c738a-8955-48a0-28cc-08df04058e26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|4143699003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: r9a6MRcFKUlh08eUIH3HU4y0+lvG9h6hpavx9m2omloU6rqqCgGQ5GZ7Euq0IteH09qq+I9kz+rvFthbs7z2Gc6SkBuiE/RC/SvwhDdpW4HQMOhu6C3Ev42vyGjghuA3V3DWrDXazIPAdzuXjMsQJ+Nlr3c5M1mb/X7ZMlxPdYjeEgcYPaY1oFuQryV0mP31mcnxFaJQQfxQ7QxuFPqHJ6vQvrKy83SOmarCac8KenCdXJKdFMpodPZey/2hh1V52MEaUrqkbZBzStn0LdvV5bU7n6HlWwc2x/7jgPf8NLAVotr6Svm/Nqi41BIi3756keHC9Cmk0YtnOC588fghehYFNmsMnEd5Mhv/ZiAFBUJw0jLBbslmNRO2sNM+7wqtaTavOKm3iPwxEVOiJJvj9cAS9ip8AdS5lUhf02qXjnvQarCGo4L2CQ3heLcimK3UVNrFb1Cfq0VAGVurQZBDnSUJ3tqkL/gnV9qFPLm/TL47jEfW9D0JEXuZxnKUELWay7DxePJswR9KczIfZdWnberqGEbUyMtGkfR9zFI2KL0bBK5nXrsv5w8uebjvIGiFFh/uuXYyh+AKEMMn0lqsOMPqRFON8UUmphy8KgEePWSueIpeaYFHrXEsCR4nXAu+pkTqlo4BUzZHTs8a3ixrROXi5d8p0coczzOJakuw6xQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(4143699003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFUzdkdpa0ZMaHNySmpOVHVyOWtMaVRLVGxaNER1dUROZUpVRVRHSnNwUVRH?=
 =?utf-8?B?eGRRTm5ieU5WclZGUmRUZmFDVW9oMU1wVmpZMEl0ak4zTFMreTZoMTg3eFlV?=
 =?utf-8?B?bTBwRldFamVvREtCazY2REJKY1FJamNxUmk1VCtOOXBNcStrblFDelFFSVdQ?=
 =?utf-8?B?bXRZSUFMbnRNK1E3NXd3N0srelh5VytOR2ZLdXI2RGgxVXNid1E1VVlKcUJy?=
 =?utf-8?B?V0xkbUdzQWl3RTFuU3BXY3ZDRHFSZDErMlpncFhpaHdtWG1PK05xQ05LZ3k1?=
 =?utf-8?B?VlZVSWpGTElnRWpEbzNieUVMbTBIZ09jQ1p3WkFVcy8zTUM3b3dZY05Ybnc5?=
 =?utf-8?B?cTVQbGdQQkpYSmozcysvQU9qZVVIQVRYbUxOaGZ3ZC9TVms1TzVsK0hTNmFP?=
 =?utf-8?B?VHcrUkdwMXQ5L2J2VW5EMTl5ZkpSQ29veHNyNEZVL1RpSGxHSHVpeWlWWnl5?=
 =?utf-8?B?ZWlRK1BudUFQZTdXamNQbUc5MDZKV2RITXVDMGQ4N1NPRlNacW5DOUE2VjBL?=
 =?utf-8?B?eWFMK2hXSXIwN1A4bHJMZnJ2bE9tZzRQRkxjYmMwREtzb1RvQWRTSERVbUxB?=
 =?utf-8?B?My9XYTNqOGpVd0tiK2ZobWYxa3lhMjVJTEpKejN0eHh1UTJsWDRuM3lwMGJB?=
 =?utf-8?B?OWlLZUo0T0Y0T0F4WVBiaVBhTEVxNFljSFRMdmJvdFJPL0RQWG02VU9FMGNm?=
 =?utf-8?B?M1Fqci9zWVZiUEFnT3NMS0hiSWlTWFBHdWVXNXRWU0dCUHFEVUcvVEpzN09Q?=
 =?utf-8?B?TEtXVmRuVWdsZjBMZUdtMGlZYWdPRER3QjVJeWNGOTJ4SnlIeTRwQ05TQjRE?=
 =?utf-8?B?T3FlYlFOS0g4ZjJVOEZXUnFPUTBGbXNGTjZVeVJpcmVYcndyMzg1M3JicFpq?=
 =?utf-8?B?OWJpdDZhREpLOHByWXJMSmw5Y09FZllnSTBRTkNsYzYxR3dDeXhrMm1ybm5Y?=
 =?utf-8?B?bWJtNTdPL2tHTXFFRE9JK0NZSXdjSzZObDUwbjBxd293bVhjWU9wQUJwQ3hF?=
 =?utf-8?B?YW1DejhzRHFzWG1NYmY5T1JFRkV6bklLNm1wZEFoQlg2ZDN1K21NKzdNT2VO?=
 =?utf-8?B?SGRubUEzcCtpYk9PaGVjMzRrOXllRFZ5ZzhETVZyUStVNEMzMnNxSzVXNG5H?=
 =?utf-8?B?cFU5UHlucnJzelRQR0VaSmNmdXg4SFRHeEUxMEthSVozWGNXc2RuSkhHUlVr?=
 =?utf-8?B?TzNJSmlRY2xVOTN5UGFlcGIwT0VqUGFqdlRwY2MxOUc1aFNYU1B1aGNyZmhX?=
 =?utf-8?B?cDgrWGc4d3BHcVJPMzZQa2FEd1JTZ1hYRXUyRnhhOTQ3bFhTMXIrbzFLSkYy?=
 =?utf-8?B?WjBINnowdWd2YVRWR05TRjRaSDhuUkx6NlRERnZsOCt2NGo3MnRWTFZJMURw?=
 =?utf-8?B?N3YxSTB1WXNRemkvNEVXL1ZIVnhIQS9MZm9EdzlDS0lkZk5OdDhnMHArMmJG?=
 =?utf-8?B?b0Q5eFprMkcyckY0MTV1dE5sT0dMZnZJNzlsVkt0WkkyeFNYb3AzbzVTT0xo?=
 =?utf-8?B?MDA2MXNCdU1UdU4xVHRtMGNWa3lzMytVWEtqMlRLU3ZOekZtYkRIWHNPVStu?=
 =?utf-8?B?MVdTZGFpYVhMQlNnckdKN2JhNmxJRVZKYUFyeUNDci9VUnMvdnRyeER4Sjdl?=
 =?utf-8?B?V2ZNejlJSnRYU21QR1lQT2FJN0lzaDVkL0lBeXpnQndJWjU5T2g0WHhSRk95?=
 =?utf-8?B?Ukx6TmJIUUZSa1lDZ0dicVJ4L0tOeUxOVnM4RVUwTDhhbmcyU0d3TGVpWEI0?=
 =?utf-8?B?dzRFbVVQUUl5dm1zRkpzbjJtdW5Vd3NHUlFxMi92OFUyTzVZZ3hYY0Fwak9m?=
 =?utf-8?B?cXY1dDBFNWM2QTgwOUl3bTVHVitzdFcwTXVHR2NZTEV1c3ovSmZYdWpETFZ0?=
 =?utf-8?B?bklmQVIxM0hxQXcyN3J2ZjgxdlpFRERoWUtxV21Hcm9qc2IySG1lNUlNTUpx?=
 =?utf-8?B?bTlJUjB3T0E0SVVEb0tka0RFSFlGdWZPQUlLUHZSaUJZV1NSZ2JJQ1lDYUtz?=
 =?utf-8?B?TC8zL0JYcXdhQ1pYR1pmZFFqSHBFcVBSTDdjaC9VQ3JQaDlkMUU4a3FzN3NT?=
 =?utf-8?B?aEp4cW00V1ljMyt1YkZEMnkxcGNLV293ZjZveVh3WCt6M3BoWGkrRkNCRk9P?=
 =?utf-8?B?VWh3aUN0Z0RoemVYS2hzTjhYeU5yTFluMzhWUVFuTmpUSUx3dVA0dzBiYmw0?=
 =?utf-8?B?a0hEYzV1TjJyWTN3cGhjU3JUUFRTMU13djNpMCtaTWdiUWVNSURnZWd2VG0w?=
 =?utf-8?B?SkNUZGV2d3UyWmd2bWhGQys2ekxzVEZnRVF3VUxTUkpoT3NwRFF6VjhOYXRC?=
 =?utf-8?Q?IN+mM4b9XPCDUfcwEk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc6c738a-8955-48a0-28cc-08df04058e26
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 06:36:41.7954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KaZr7zSo607SxH5NNgR92cZ1Kwmkrxm7gInjUNEgSs0iP2CzLgIBAX3QBelue5tY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7653
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

On 8/25/26 09:42, Honglei Huang wrote:
> On 8/13/26 17:16, Huang, Honglei wrote:
...
> Hi Christian,
> 
> Following up on my previous mail, I changed the change. The diff to the existing VM code is below.
> 
> Does this look correct to you? for unify notifier lock and eviction lock.

That looks mostly correct to me, but I would change it quite a bit.

> 
> diff:
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> @@ -28,6 +28,7 @@
>  #include "amdgpu_hmm.h"
>  #include "amdgpu_vm.h"
> +#include "amdgpu_svm.h"
> @@ -66,6 +67,9 @@ struct amdgpu_vm_update_params {
>      bool unlocked;
> 
> +    /** @svm_locked: caller already holds the drm_gpusvm notifier_lock */
> +    bool svm_locked;
> +

Drop that, this approach is nonsense. The caller must always hold the drm_gpusvm lock.


>      /**
>       * @pages_addr:
> @@ -143,6 +147,30 @@
> +/* SVM VMs serialize eviction under the notifier_lock (write); others use eviction_lock. */
> +static inline void amdgpu_vm_eviction_lock(struct amdgpu_vm *vm)
> +{
> +    if (amdgpu_svm_is_enabled(vm))
> +        down_write(&vm->svm->gpusvm.notifier_lock);

I would either make the vm->svm mandatory or rename vm->eviction_lock to something like vm->notifier_lock and make it a pointer to the rw_semaphore which should be used.

Regards,
Christian.

> +    else
> +        mutex_lock(&vm->eviction_lock);
> +}
> +
> +static inline void amdgpu_vm_eviction_unlock(struct amdgpu_vm *vm)
> +{
> +    if (amdgpu_svm_is_enabled(vm))
> +        up_write(&vm->svm->gpusvm.notifier_lock);
> +    else
> +        mutex_unlock(&vm->eviction_lock);
> +}
> +
> +static inline bool amdgpu_vm_eviction_trylock(struct amdgpu_vm *vm)
> +{
> +    if (amdgpu_svm_is_enabled(vm))
> +        return down_write_trylock(&vm->svm->gpusvm.notifier_lock);
> +    return mutex_trylock(&vm->eviction_lock);
> +}
> +
>  static inline int amdgpu_vm_begin_critical(struct amdgpu_vm_update_params *p)
>  {
> +    if (amdgpu_svm_is_enabled(p->vm)) {
> +        if (p->svm_locked)
> +            lockdep_assert_held(&p->vm->svm->gpusvm.notifier_lock);
> +        else
> +            down_read(&p->vm->svm->gpusvm.notifier_lock);
> +        p->saved_flags = memalloc_noreclaim_save();
> +        if (p->vm->evicting)
> +            return -EBUSY;
> +        return 0;
> +    }
> +
>      mutex_lock(&p->vm->eviction_lock);
>      p->saved_flags = memalloc_noreclaim_save();
>      if (p->vm->evicting)
> @@ static inline void amdgpu_vm_end_critical(struct amdgpu_vm_update_params *p)
>      memalloc_noreclaim_restore(p->saved_flags);
> +    if (amdgpu_svm_is_enabled(p->vm)) {
> +        if (!p->svm_locked)
> +            up_read(&p->vm->svm->gpusvm.notifier_lock);
> +        return;
> +    }
>      mutex_unlock(&p->vm->eviction_lock);
>  }
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ amdgpu_vm_validate():
> -    scoped_guard(mutex, &vm->eviction_lock)
> -        vm->evicting = false;
> +    amdgpu_vm_eviction_lock(vm);
> +    vm->evicting = false;
> +    amdgpu_vm_eviction_unlock(vm);
> @@ amdgpu_vm_ready():
> -    scoped_guard(mutex, &vm->eviction_lock)
> -        ret = !vm->evicting;
> +    amdgpu_vm_eviction_lock(vm);
> +    ret = !vm->evicting;
> +    amdgpu_vm_eviction_unlock(vm);
> @@ amdgpu_vm_evictable():
> -    scoped_cond_guard(mutex_try, return false, &vm->eviction_lock) {
> -        if (!dma_fence_is_signaled(vm->last_unlocked))
> -            return false;
> -        vm->evicting = true;
> -    }
> +    if (!amdgpu_vm_eviction_trylock(vm))
> +        return false;
> +    if (!dma_fence_is_signaled(vm->last_unlocked)) {
> +        amdgpu_vm_eviction_unlock(vm);
> +        return false;
> +    }
> +    vm->evicting = true;
> +    amdgpu_vm_eviction_unlock(vm);
>      return true;
> @@ amdgpu_vm_map_range() / amdgpu_vm_unmap_range():   /* +bool svm_locked param, params.svm_locked = svm_locked; non-SVM callers pass false */
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ /* amdgpu_vm_map_range()/amdgpu_vm_unmap_range() declarations: +bool svm_locked */
> 
> Regards,
> Honglei
> 
> 
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>> Regards,
>>>>> Honglei
>>>>>
>>>>>>
>>>>>> The background is that XE uses a different page table allocation approach than amdgpu and we need to drop this lock in amdgpu to be able to allocate page tables. See function amdgpu_vm_pt_alloc().
>>>>>>
>>>>>> With that design here that currently doesn't work at all.
>>>>>>
>>>>>> We have two options, either use the drm_gpusvm notifier_lock as eviction_lock in amdgpu_vm.c or re-design amdgpu_vm.c to use the same approach for allocating page tables as XE.
>>>>>>
>>>>>> Some engineer from Valve is working on re-designing amdgpu_vm.c, but that will potentially take month if not years.
>>>>>>
>>>>>> So my take is that the new SVM code needs to modify amdgpu_vm.c so that the drm_gpusvm notifier_lock is used as eviction lock by the VM code.
>>>>>>
>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>
>>>>>>>
>>>>>>>     - driver_svm_lock: In addition to the locking mentioned above, the
>>>>>>>       driver should implement a lock to safeguard core GPU SVM function
>>>>>>>       calls that modify state, such as drm_gpusvm_range_find_or_insert and
>>>>>>>       drm_gpusvm_range_remove.
>>>>>>>
>>>>>>>     Two locks, two jobs.
>>>>>>>
>>>>>>> 2) The lock held in the MMU notifier is notifier_lock, never driver_svm_lock
>>>>>>>
>>>>>>>     drm_gpusvm_notifier_invalidate():
>>>>>>>           down_write(&gpusvm->notifier_lock);
>>>>>>>           ...
>>>>>>>           gpusvm->ops->invalidate(gpusvm, notifier, mmu_range);
>>>>>>>
>>>>>>>     The driver invalidate callback runs under notifier_lock only. Per the
>>>>>>>     framework's own notifier example it just unmaps pages
>>>>>>>     and queues the range to the garbage collector no allocation, and it
>>>>>>>     does not take driver_svm_lock:
>>>>>>>
>>>>>>>           drm_gpusvm_range_unmap_pages(...);
>>>>>>>           drm_gpusvm_range_set_unmapped(...);
>>>>>>>           driver_garbage_collector_add(...);
>>>>>>>
>>>>>>> 3) driver_svm_lock is by design an allocating, process context lock
>>>>>>>
>>>>>>>     drm_gpusvm_range_find_or_insert() asserts it and then allocates under it:
>>>>>>>
>>>>>>>           drm_gpusvm_range_find_or_insert():
>>>>>>>                   drm_gpusvm_driver_lock_held(gpusvm);
>>>>>>>                   ...
>>>>>>>                   range = drm_gpusvm_range_alloc(...);
>>>>>>>                   ... mmu_interval_notifier_insert(), kzalloc
>>>>>>>
>>>>>>>     drm_gpusvm_range_remove() asserts it and frees. This is only safe
>>>>>>>     because driver_svm_lock is a sleepable, reclaim friendly lock that is
>>>>>>>     never taken from the MMU notifier. Reference counting
>>>>>>>      handles range *lifetime*, but it does not
>>>>>>>     serialize tree insert/remove, which is exactly why the framework still
>>>>>>>     asserts driver_svm_lock on those two entry points regardless of refcount.
>>>>>>>
>>>>>>> Now the three concrete points:
>>>>>>>
>>>>>>> A) Why the primary driver_svm_lock is required
>>>>>>>
>>>>>>>     It is a framework requirement, not an amdgpu invention:
>>>>>>>      - DOC: Locking says the driver "should implement" it.
>>>>>>>      - drm_gpusvm lockdep-asserts it on every structural entry:
>>>>>>>        drm_gpusvm_range_find_or_insert() and drm_gpusvm_range_remove() both
>>>>>>>        call drm_gpusvm_driver_lock_held().
>>>>>>>      - The reference fault handler holds it across the whole fault:
>>>>>>>        GC -> find_or_insert -> migrate -> get_pages -> bind.
>>>>>>>
>>>>>>>     Xe does exactly this:
>>>>>>>      - xe_svm.c:      drm_gpusvm_driver_set_lock(&vm->svm.gpusvm, &vm->lock);
>>>>>>>      - xe_pagefault.c: down_write(&vm->lock); before dispatching the fault
>>>>>>>      - __xe_svm_handle_pagefault(): lockdep_assert_held_write(&vm- >lock);
>>>>>>>        held across GC / find_or_insert / alloc_vram / get_pages / rebind
>>>>>>>      - xe_svm_garbage_collector(): lockdep_assert_held_write(&vm- >lock);
>>>>>>>
>>>>>>>     amdgpu's svm_lock is the same driver_svm_lock, used the same way.
>>>>>>>
>>>>>>> B) Why eviction_lock cannot be that lock
>>>>>>>
>>>>>>>> This lock eviction_lock can only be grabbed while updating the mapping range.
>>>>>>>
>>>>>>>     and that is precisely why it cannot be driver_svm_lock.
>>>>>>>     driver_svm_lock must wrap find_or_insert, migration, and
>>>>>>>     drm_gpusvm_range_get_pages
>>>>>>>     eviction_lock is the opposite by contract:
>>>>>>>
>>>>>>>      - It is taken with memalloc_noreclaim_save() in
>>>>>>>        amdgpu_vm_begin_critical(), specifically so no reclaim happens while
>>>>>>>        held (to avoid the reclaim -> MMU-notifier deadlock). Holding it
>>>>>>>        across get_pages/migration breaks that.
>>>>>>>      - TTM eviction try-locks it: amdgpu_vm_evictable() does
>>>>>>>        scoped_cond_guard(mutex_try, return false, &vm- >eviction_lock) and
>>>>>>>        sets vm->evicting. Long holds starve eviction.
>>>>>>>      - It is a plain mutex that the SVM map path re-enters:
>>>>>>>        amdgpu_svm_range_update_mapping() -> amdgpu_vm_map_range() ->
>>>>>>>        amdgpu_vm_begin_critical() -> mutex_lock(&vm- >eviction_lock). If
>>>>>>>        eviction_lock were also the outer SVM lock, this is a self- deadlock.
>>>>>>>
>>>>>>>     In short, eviction_lock has the contract of notifier_lock , not of
>>>>>>>     driver_svm_lock. This is also why the current split is correct:
>>>>>>>     svm_lock (outer) != eviction_lock (inner). Your own rule - "you can't
>>>>>>>     call the VM code with the lock held, the VM code must take it itself" -
>>>>>>>     is satisfied today only because they are separate: svm_lock is held
>>>>>>>     while calling amdgpu_vm_map_range(), and amdgpu_vm_map_range() takes
>>>>>>>     eviction_lock itself. Merging them is what would violate that rule.
>>>>>>>
>>>>>>>> No, they Xe vm->lock and eviction_lock are actually identical in the handling.
>>>>>>>
>>>>>>>     They are not. Xe's vm->lock is a rw_semaphore, the "outer most lock" of
>>>>>>>     the VM , held down_write across the whole fault. amdgpu's
>>>>>>>     eviction_lock is a mutex taken only inside amdgpu_vm_begin_critical()
>>>>>>>     during a PT update, under memalloc_noreclaim. Xe's eviction/ reclaim
>>>>>>>     handling is separate from vm->lock. The amdgpu analogue of Xe's vm->lock
>>>>>>>     is svm_lock, not eviction_lock.
>>>>>>>
>>>>>>> C) Reusing an existing amdgpu_vm lock as the primary lock needs refactor amdgpu VM
>>>>>>>
>>>>>>>     Xe can register vm->lock because Xe's VM was designed with an outer
>>>>>>>     rw_semaphore held across faults. amdgpu_vm has no such lock: only
>>>>>>>     eviction_lock , the root PD dma_resv , and a few spinlocks.
>>>>>>>
>>>>>>>     So do it like Xe means introducing a dedicated, outer, sleepable VM
>>>>>>>     lock held across the fault. That lock is exactly svm_lock. Folding it
>>>>>>>     into struct amdgpu_vm as a general vm->lock is a core amdgpu VM refactor.
>>>>>>>
>>>>>>> Regards,
>>>>>>> Honglei
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Christian.
>>>>>>>>
>>>>>>>>> +
>>>>>>>>> +#if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
>>>>>>>>> +void amdgpu_svm_flush_tlb(struct amdgpu_svm *svm);
>>>>>>>>> +
>>>>>>>>> +int amdgpu_svm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>>>>>>>>> +void amdgpu_svm_close(struct amdgpu_vm *vm);
>>>>>>>>> +void amdgpu_svm_fini(struct amdgpu_vm *vm);
>>>>>>>>> +
>>>>>>>>> +void amdgpu_svm_put(struct amdgpu_svm *svm);
>>>>>>>>> +struct amdgpu_svm *amdgpu_svm_lookup_by_pasid(struct amdgpu_device *adev,
>>>>>>>>> +                           uint32_t pasid);
>>>>>>>>> +int amdgpu_svm_handle_fault(struct amdgpu_device *adev, uint32_t pasid,
>>>>>>>>> +                uint64_t fault_page, uint64_t ts,
>>>>>>>>> +                bool write_fault);
>>>>>>>>> +bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm);
>>>>>>>>> +
>>>>>>>>> +int amdgpu_gem_svm_ioctl(struct drm_device *dev, void *data,
>>>>>>>>> +             struct drm_file *filp);
>>>>>>>>> +void amdgpu_svm_clean_queue(struct amdgpu_svm *svm,
>>>>>>>>> +                struct list_head *work_list);
>>>>>>>>> +void amdgpu_svm_sync_work(struct amdgpu_svm *svm);
>>>>>>>>> +int amdgpu_svm_garbage_collector(struct amdgpu_svm *svm);
>>>>>>>>> +int amdgpu_svm_apply_attr_change(struct amdgpu_svm *svm,
>>>>>>>>> +                 const struct amdgpu_svm_attrs *old_attrs,
>>>>>>>>> +                 const struct amdgpu_svm_attrs *new_attrs,
>>>>>>>>> +                 unsigned long start_page,
>>>>>>>>> +                 unsigned long last_page);
>>>>>>>>> +bool amdgpu_svm_devmem_possible(struct amdgpu_svm *svm);
>>>>>>>>> +#else
>>>>>>>>> +static inline int amdgpu_svm_init(struct amdgpu_device *adev,
>>>>>>>>> +                  struct amdgpu_vm *vm)
>>>>>>>>> +{
>>>>>>>>> +    return 0;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static inline void amdgpu_svm_close(struct amdgpu_vm *vm)
>>>>>>>>> +{
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static inline void amdgpu_svm_fini(struct amdgpu_vm *vm)
>>>>>>>>> +{
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static inline int amdgpu_svm_handle_fault(struct amdgpu_device *adev,
>>>>>>>>> +                      uint32_t pasid,
>>>>>>>>> +                      uint64_t fault_page,
>>>>>>>>> +                      uint64_t ts,
>>>>>>>>> +                      bool write_fault)
>>>>>>>>> +{
>>>>>>>>> +    return -EOPNOTSUPP;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static inline bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm)
>>>>>>>>> +{
>>>>>>>>> +    return false;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static inline int amdgpu_gem_svm_ioctl(struct drm_device *dev, void *data,
>>>>>>>>> +                       struct drm_file *filp)
>>>>>>>>> +{
>>>>>>>>> +    return -EOPNOTSUPP;
>>>>>>>>> +}
>>>>>>>>> +#endif /* CONFIG_DRM_AMDGPU_SVM */
>>>>>>>>> +
>>>>>>>>> +#endif /* __AMDGPU_SVM_H__ */
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/ gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>>>>>> index ec1196d390bb7..30463a83e2e60 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>>>>>> @@ -43,6 +43,7 @@ struct amdgpu_bo_va;
>>>>>>>>>     struct amdgpu_job;
>>>>>>>>>     struct amdgpu_bo_list_entry;
>>>>>>>>>     struct amdgpu_bo_vm;
>>>>>>>>> +struct amdgpu_svm;
>>>>>>>>>       /*
>>>>>>>>>      * GPUVM handling
>>>>>>>>> @@ -373,6 +374,9 @@ struct amdgpu_vm {
>>>>>>>>>           /* cached fault info */
>>>>>>>>>         struct amdgpu_vm_fault_info fault_info;
>>>>>>>>> +
>>>>>>>>> +    /* SVM experimental implementation */
>>>>>>>>> +    struct amdgpu_svm *svm;
>>>>>>>>>     };
>>>>>>>>>       struct amdgpu_vm_manager {
>>>>>>>>
>>>>>>>
>>>>>
>>>>
>>
> 

