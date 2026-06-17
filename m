Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265DCCD98EE
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 08:57:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 607CB10EED7;
	Wed, 17 Jun 2026 08:57:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iNEQXayL";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013056.outbound.protection.outlook.com
 [40.93.201.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9AD310EED5;
 Wed, 17 Jun 2026 08:57:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQ0OjVSE/LNO9mEd/Vf+3E2JnlSa/8WH1zDANy8GaoGqDyGa4f0X5V/vd6ufU3FW7zLvLCA0hm2tpZ4NSpGJNjy0SEGkNX85ellxlkUXZ5erQgtID9Bl8hjIeWY+Gs1SjsujRFuLR68duTEXZm4Fv99h3y2Ca4wYHqqr/kW/zF0ueZ/6y/JkECKzCicR+0ZVaKlnTHRpzBj8La8MDqU9aR30gXjRG69Fx2/kNI1E1sZ3+LhmiGQKIwQUKNoHf/p8dhMICcVmYyRPyrUunHmGwS5wbpRgKCj0iFRBnlkwQfU2AiChGzRlye/++F2lWmTM8RyyTLm1XpQmmDVEuQxZjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZhmx+jueioJnZXJMZHg0TgRu3Um63UlCwaSdLw5sgY=;
 b=CIuE424ngMEI+/ENBNG0mzB2USzcx+Mva62EWt41B1NOioySAXUhez2aTTH0XkYP3JjycZSPzcqe0Y2jaMBjaSKbf8pjZ6luX8p0JtL2GUEdecYj8/qf1/NgEaIZeBEWA7Nc+6d4m6js9ljpHyK9lffxzU660oYj4LewevmULVRPV5+D+71LKTmK3vCZgo4fkj0RK59+xV4GcXpsasqqwUQG2qVCkg3jaA0SOAfMWupCyjSzn4qmk5wfcgNRJgNs2RXZGPNAINewrN31ZjnttsC2qj3WRDPCDKISpjXNuTx2cuY69C2Joeh/O/48A92LU/LWQfOYsRwzKrRAyc0OLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZhmx+jueioJnZXJMZHg0TgRu3Um63UlCwaSdLw5sgY=;
 b=iNEQXayLWKb0Pz9TUn3LcoiXDDO+YounA6xNawcMWfaDtu00XSn4eokQpeLKfyCCT32WzUBO2dlsqfyVwyrQZQ2dui9cscDhCB969OtiSvzRfXKNYrizQ9y8jhlqyeFImkn84EKXaNqJXutrjAldbk0JLFsJ85VTERPEI89f8gI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB9191.namprd12.prod.outlook.com (2603:10b6:a03:55a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 08:57:21 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 08:57:21 +0000
Message-ID: <98f5937a-52ec-4234-8fa9-fd0f47d2e70c@amd.com>
Date: Wed, 17 Jun 2026 10:57:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add filelist_mutex to lockdep lock ordering
 annotations
To: vitaly.prosyak@amd.com, amd-gfx@lists.freedesktop.org,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, Simona Vetter
 <simona@ffwll.ch>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
References: <20260617011804.106764-1-vitaly.prosyak@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260617011804.106764-1-vitaly.prosyak@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB9191:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d9978a4-d2d0-4232-e3bc-08decc4e70fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: DVum+SwJQUCF8uBYrK2sOBurJbdEUqpnAtrK5bfVBtPfjet3Pfp5kNlwOJEheG/DGm68HwZkZRS7B/p14i0uW1iM6NJUh2QMrzzNiSr8tlIcL0/qYzD1/6Pf2ykuqjVmkaEmXkCqnN/6wJC+zD96PDqCfLkjsXXffjguqx34XX4FW2g9CM0RD8ZIk7d0xIcqkW/xuuUKoNxDquGK8806/gL5wFHF+g+iRhXk31YoofcCv+e8rtXZtHAOFDakrkpl8LKxMmHqqrhJvWKCZBBnrF+jJY/uZas1blrUxLsy1hsAGe5mOgxMCgHzkUU2qZmimOi+dJeKyH9FJ31lW5n9Au2A+wTNOtAk0t0SUg6S+vXELOGWYrb5zv+PlIuMxh0ACMlADNwifqy1cQWhZieQktFpqeeHKwT9LyGDhIRUW+qFsta2eLUyC0Fjo31RCvAJCOgm5/hpOC5XSjb6Gah3kTLWl6Jx00Y5qUAoeRDTEngPWMsJZ+sjFaXzN0v5ojRXynOf9C9i6jNZVAZ6iIvkgwb1KSG0R/dX3pOUCDqJvFCg7eC/iiSjVKNd/pTcBMFjcFS8BhxyAeLXYLXH0kmWSQMHGicXyd+Wgc6dV3HsQ7tciPJOPJPeVDTGOm2rMzyMMt1UlyqbYZCrAx4pS1P9Lx2Upbpc0nDgUUlF3Xl35hHE0VwGtgLghBOKiVVLkNKH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDNabUdORys0d014b216YlZ4bi9TRTd1ejlIYVE5UmJzR255YytmSWFpckdk?=
 =?utf-8?B?L0NLVUJPNkkzTHo2VDN6ZkhqQUZqcXhDSllmQ3pna1NqdGx3eFA2MzdDaFpK?=
 =?utf-8?B?UERDWjFha1R1L2lhSjhuRjhhSjhMdFp6T3kxajEydWJ0TUw2b3JsR3ZVcnRM?=
 =?utf-8?B?RjlMSEZFYVl6WGlvOFRVZEtBL2Zmb3l6ZzJOYTUxaEF0K1pLQW5XNTg4b2xr?=
 =?utf-8?B?b0dhQnN0d0VBQ1dsci8wNzlzOWZIQVd5Q3EybTB3S010KzEzN1NjeFdLaS9x?=
 =?utf-8?B?NW1pOXdmZVNLQzFmd0R6Q3VQYlZFSk9hZ2VDdThGd2dnbzJMNWQ1RGRXV1VC?=
 =?utf-8?B?Zi82ZEhUQmhwRlZuWlB6eEVzM2lQZm1iOUlocEVPQStUdGdrYlhlbnYwZ2JN?=
 =?utf-8?B?b2theEJwNjRtQ3ZIMVZWUUxJZXg4NEVqY1ZJaWkrNnE4cjEyRXlsRC8yZDNC?=
 =?utf-8?B?SHNaUUxaSmZ6N3EvWmdrMWJwQTd4Ky9wVGhLNXRQQjdQSnR3TWllRkE5SFZr?=
 =?utf-8?B?V2RQdTFOTjZUWjZ4aGdTYi9VUTV5Smh4aWk0NHRtb2hKVXJMQmttR2I1MzVL?=
 =?utf-8?B?UTRuVWQ2MmtwY29SWktDQ3hUckRoaHNmaEJJanE0VFpUWHNOT05sUktlSUxI?=
 =?utf-8?B?OUE2TmRRMG1kd0kyeDhrWEdQaTJyNkoyNTVmZTdDenA0T0RER1V3ejRMN0hV?=
 =?utf-8?B?aEU0eG1GU2psRndkMUlicFN5SDN6K0gvcEVwSTNQUUVyTXVLdnB5clhDYkQ0?=
 =?utf-8?B?K0JLTk0waVJibDgrTmZUQnFWUHdtK2UyTjRQT1hsdmlhNG9GM1JieXdIRzlI?=
 =?utf-8?B?N0hZSk5xS2dsbmczdFZBc09sQWJrb3JscDVVWElYd3owdE4zdDBmdHJTak1H?=
 =?utf-8?B?R1c3amlOYStpSG9FZ21IWnNHUkhoVm85OXdrRU5BSUxxY3RzeWV0RVNHVXdx?=
 =?utf-8?B?Wmk1aTNSQi9ZSlZUYkIwNjRxWWp5QmNrd1dFR0Fad1VFRlVuYjl4OHd1OVBn?=
 =?utf-8?B?dHZlbkFzWUlyd2M0UlNEZGhEbGlZVHJEK3dPcVllOWFUaXRCalplUHkra2l1?=
 =?utf-8?B?RUtHZFEyNHlpQ3M0RHh1NXNadjFLSHduUDNOOWd5U2lySjIxS3p3aUVxWVFP?=
 =?utf-8?B?VnR4bFNMdy9ZbGRDUXo2aW94eGxYTVc3Vkx3RzBWSVJ4cEJCRE9sSlJZV0cz?=
 =?utf-8?B?Z3JqL0luVTcraTQ5aUNkcTVuMXdJQll6aXhpZEgrYzhvTVF0RzFaR2daTlY3?=
 =?utf-8?B?NEdYTHJZKzlsVjBnNmlYckdvTW9JbithNXJNRGdyMnl3OGo2NmlWY1NGeldr?=
 =?utf-8?B?TVFNZHNRaGRRNVlGMG5xTGxJSGFwaDNHQVo3WUN6akpRYTF2VVlNTXd4RWJj?=
 =?utf-8?B?TE9tSWw1bWlRalJyVldlbFlHSTZhbmp1SXVWdkFHQVB0YmhFRm1TckVDM3ZN?=
 =?utf-8?B?Q3NTSFAwdWxtTUdrUHlQTEJucnMwcUVZOU1nU3NCWnVQSDhROERMakMveUti?=
 =?utf-8?B?RkJzWEhFenp3bEtZa2t4WkxMM0RzYytYVk1YaHNyZncvSkFQc21zWjh0cS82?=
 =?utf-8?B?azFvVWlrZElWbllSNXZaUmpZeHRTaVZNT2VXVlNwZGpvQlQ2cWJQd05vNU9z?=
 =?utf-8?B?ZEJkY211TDMvcWxXUlRKRnlGN1lhZGZXOGl2ZXkyOExPdmhrcVpZUXNQVXd6?=
 =?utf-8?B?Z1A1MDBvR1ZUUUg3S0tqdXJjSEE4MEV6c2V3M1RzM0E3L0pXbk9VL0ZnYUpm?=
 =?utf-8?B?b3IvbUtsM3NvRHdhNUJlNUtZdHI5LzhVZUNsdjQrNXNvWmlsaE1yQmIweUZN?=
 =?utf-8?B?Z0RydmQ0ZUIzbmtoZHdrd0F0WHZaQWJndytLN3dXUURUMjlrTDBBc2Q4Z1N0?=
 =?utf-8?B?Q04vSkF3UVNqOExGVXV1RkVmTXRCb21COHBZS1pZd2x2aFg5UjVhNW51Vzdq?=
 =?utf-8?B?YUp2d2p2TmhmRFQ4WDViNkdlakgwbUNHazlHVGJQcXA3aUU5aUlhSXBCN003?=
 =?utf-8?B?dEFsQ25ncjhiMDF1VndLbjRGNmtqci9TUy9uOTliQ1ljTjhnN211SE5KQnFQ?=
 =?utf-8?B?ZVd5cFh3cTI5T0tDZnBYNHQzZ2YwZTVjOEEvQisrbVFEbjhHMkZlRjh6WUQx?=
 =?utf-8?B?RXVQUXFGV25lWmZSZEVCQThTU1AxWDg5ZkZLWE1CT0dTVEkxU29hd2ZKZi96?=
 =?utf-8?B?dG5mMVUvLy9hZ1VoSkxkZ1J5MGYvR05TWjNHdFY2c0JYV1ppNUt4U044c2tJ?=
 =?utf-8?B?MS9EckxZYUsvZFdNRGdIcHJOUGk0NnFYWklFcExzeXNSUE1GQzlKOS95VmZx?=
 =?utf-8?Q?zU7UXurG9KL2P8G5s1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d9978a4-d2d0-4232-e3bc-08decc4e70fc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:57:21.0285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8GkpMSoZ60sd33is85CmU0FnSFYpIjSsIuEhp4GVsOF+lPRJeVCjzgTLesXkmgJE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9191
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

On 6/17/26 03:15, vitaly.prosyak@amd.com wrote:
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
> 
> Add ddev->filelist_mutex as level 7 in the lockdep hierarchy, between
> reset_lock (level 6) and srbm_mutex (now level 8). This teaches lockdep
> the correct ordering for filelist_mutex relative to other amdgpu locks.
> 
> The ordering evidence comes from the GPU reset path: gpu_recover() holds
> reset_domain->sem (write) and calls amdgpu_device_eventfd_signal_gpu_reset()
> which acquires filelist_mutex to iterate the DRM file list and signal
> eventfds. This places filelist_mutex inner to reset_domain->sem.

Yeah I'm not sure if that is correct or not. That's why I asked.

> 
> Existing filelist_mutex users (amdgpu_gem_force_release, debugfs vm_info)
> do not hold any reset locks, so this ordering is consistent with all
> current call paths.
> 
> Updated hierarchy (10 lock levels):
>  1. userq_sch_mutex     - Global userq scheduler
>  2. userq_mutex         - Per-context userq
>  3. notifier_lock       - MMU notifier
>  4. vram_lock           - VRAM allocator
>  5. reset_domain->sem   - GPU reset synchronization
>  6. reset_lock          - Reset control
>  7. filelist_mutex      - DRM file list iteration (NEW)
>  8. srbm_mutex          - SRBM register access
>  9. grbm_idx_mutex      - GRBM index access
> 10. mmio_idx_lock       - MMIO index (spinlock, innermost)
> 
> Requested-by: Christian König <christian.koenig@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c | 29 ++++++++++++++++-----
>  1 file changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
> index 61450af539a6..b251350b1fb2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
> @@ -18,6 +18,7 @@
>  
>  struct amdgpu_lockdep_dummy_locks {
>  	struct mutex reset_lock;
> +	struct mutex filelist_mutex;
>  	struct mutex userq_sch_mutex;
>  	struct mutex userq_mutex;
>  	struct mutex notifier_lock;
> @@ -34,6 +35,7 @@ static struct lock_class_key amdgpu_notifier_lock_key;
>  static struct lock_class_key amdgpu_vram_lock_key;
>  static struct lock_class_key amdgpu_reset_sem_key;
>  static struct lock_class_key amdgpu_reset_lock_key;
> +static struct lock_class_key amdgpu_filelist_mutex_key;
>  static struct lock_class_key amdgpu_srbm_lock_key;
>  static struct lock_class_key amdgpu_grbm_lock_key;
>  static struct lock_class_key amdgpu_mmio_lock_key;
> @@ -57,6 +59,9 @@ void amdgpu_lockdep_set_class(struct amdgpu_device *adev)
>  	if (adev->reset_domain)
>  		lockdep_set_class(&adev->reset_domain->sem,
>  				  &amdgpu_reset_sem_key);
> +
> +	lockdep_set_class(&adev_to_drm(adev)->filelist_mutex,
> +			  &amdgpu_filelist_mutex_key);

I'm not sure if we can do this.

Could be that I'm wrong but modifying the lockdep class of a DRM mutex is potentially a bit problematic.

Adding a few people on CC for opinions/input.

Regards,
Christian.
 

>  }
>  
>  /**
> @@ -74,9 +79,10 @@ void amdgpu_lockdep_set_class(struct amdgpu_device *adev)
>   * 4. vram_lock           - VRAM allocator lock
>   * 5. reset_domain->sem   - GPU reset synchronization
>   * 6. reset_lock          - Reset control lock
> - * 7. srbm_mutex          - SRBM register access
> - * 8. grbm_idx_mutex      - GRBM index access
> - * 9. mmio_idx_lock       - MMIO index access (spinlock)
> + * 7. filelist_mutex      - DRM file list iteration (ddev->filelist_mutex)
> + * 8. srbm_mutex          - SRBM register access
> + * 9. grbm_idx_mutex      - GRBM index access
> + * 10. mmio_idx_lock      - MMIO index access (spinlock)
>   *
>   * Evidence:
>   * - userq_sch_mutex -> userq_mutex: amdgpu_gfx_kfd_sch_ctrl() calls
> @@ -88,6 +94,9 @@ void amdgpu_lockdep_set_class(struct amdgpu_device *adev)
>   *   must be outer to reset_domain->sem
>   * - vram_lock -> reset_domain->sem: VRAM management paths may need to
>   *   wait for ongoing reset to complete
> + * - reset_domain->sem -> filelist_mutex: GPU reset path
> + *   (amdgpu_device_gpu_recover) holds reset_domain->sem and calls
> + *   amdgpu_device_eventfd_signal_gpu_reset() which takes filelist_mutex
>   *
>   * Note: mmap_lock ordering relative to GPU locks is already taught
>   * by dma-resv (drivers/dma-buf/dma-resv.c).
> @@ -117,6 +126,7 @@ int amdgpu_lockdep_init(void)
>  	mutex_init(&locks->notifier_lock);
>  	mutex_init(&locks->vram_lock);
>  	mutex_init(&locks->reset_lock);
> +	mutex_init(&locks->filelist_mutex);
>  	mutex_init(&locks->srbm_mutex);
>  	mutex_init(&locks->grbm_idx_mutex);
>  	spin_lock_init(&locks->mmio_idx_lock);
> @@ -132,6 +142,7 @@ int amdgpu_lockdep_init(void)
>  	lockdep_set_class(&locks->vram_lock, &amdgpu_vram_lock_key);
>  	lockdep_set_class(&reset_domain->sem, &amdgpu_reset_sem_key);
>  	lockdep_set_class(&locks->reset_lock, &amdgpu_reset_lock_key);
> +	lockdep_set_class(&locks->filelist_mutex, &amdgpu_filelist_mutex_key);
>  	lockdep_set_class(&locks->srbm_mutex, &amdgpu_srbm_lock_key);
>  	lockdep_set_class(&locks->grbm_idx_mutex, &amdgpu_grbm_lock_key);
>  	lockdep_set_class(&locks->mmio_idx_lock, &amdgpu_mmio_lock_key);
> @@ -154,18 +165,21 @@ int amdgpu_lockdep_init(void)
>  
>  	/* Level 6: Reset control lock */
>  	mutex_lock(&locks->reset_lock);
> +
> +	/* Level 7: DRM file list mutex */
> +	mutex_lock(&locks->filelist_mutex);
>  	/*
>  	 * Mark potential memory reclaim boundary.
>  	 * GPU operations might trigger memory allocation/reclaim.
>  	 */
>  	fs_reclaim_acquire(GFP_KERNEL);
>  
> -	/* Level 7: SRBM register access */
> +	/* Level 8: SRBM register access */
>  	mutex_lock(&locks->srbm_mutex);
> -	/* Level 8: GRBM index access */
> +	/* Level 9: GRBM index access */
>  	mutex_lock(&locks->grbm_idx_mutex);
>  
> -	/* Level 9: MMIO index access (innermost lock, spinlock) */
> +	/* Level 10: MMIO index access (innermost lock, spinlock) */
>  	spin_lock_irqsave(&locks->mmio_idx_lock, flags);
>  	/*
>  	 * All locks acquired in order.
> @@ -178,6 +192,7 @@ int amdgpu_lockdep_init(void)
>  	mutex_unlock(&locks->srbm_mutex);
>  	fs_reclaim_release(GFP_KERNEL);
>  
> +	mutex_unlock(&locks->filelist_mutex);
>  	mutex_unlock(&locks->reset_lock);
>  	up_read(&reset_domain->sem);
>  
> @@ -190,7 +205,7 @@ int amdgpu_lockdep_init(void)
>  	amdgpu_reset_put_reset_domain(reset_domain);
>  
>  	kfree(locks);
> -	pr_info("AMDGPU: Lockdep annotations initialized (9 lock levels)\n");
> +	pr_info("AMDGPU: Lockdep annotations initialized (10 lock levels)\n");
>  
>  	return 0;
>  }

