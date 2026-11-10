Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B49606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 18:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UnmBZT9S
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BD8910E2DC;
	Tue, 10 Nov 2026 18:17:01 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011055.outbound.protection.outlook.com [40.107.208.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A8FF10E2BF
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 18:16:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0EUI2oxdc9ldamKVxMdQuiDy7O8m4ScpKyUTTu3sywaISzR4GnYEjtxEc3xBHJShzvNsz98rk3QkbdQkgx1oXt9CJQYm8H3d1w7Noteck7LQUaWC0LJWGv39+xGdOIzSMQOl0luYDvnmNWdbHlP32rjSVPkmw3gzLkGMBp9DozWR4bHkNzu/Xc4ormp6nuwkUsEJV2eR8VjS0epi4eT/cAlZ7mJW/XQe476+0D7STjzgtLR7oIrIGa5dPnT5kNwQIycxefZ825rg0pIf8fOY7K5lMwLDhZ0i8epHkH3LD3AWlHiNAdzegoiLNyEq6ThiKB93Fkz69Y8hjEF/x2Dag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+wbQXBGqvCis/LItHiRxpWD8V///ZaQ7/cUHxoitXk=;
 b=ZKy017aH4aqW+IOwBphI7WocxLYY0RJkDFwOuZ/6NAbIwyKxSfozgwPJNiT79758NX99KCbusTX4Yxh176Uw7oy7WvpH7brVoVbi6640Nm00N3gg3tWvh0v54o2JbC6xuWQL4xN4/J5tnAMsfLqc54NIibbhu7UlfFEXzKAlqvlDb5cOE6xxIhwboNR8IJfvDgfhA/lSeozYym/yJGT75hfoDwFDyjZRI09NVGoHdaB6C71G9gSoyMYgEH0GfTtnWsPbqPcGaDt0SuOtN0lHjsGlVlZ3aH3mEFuEjsxzgzogZyoENQLh5bV5zDE9aB18ejZUBGonNBFUaakU+UAYxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+wbQXBGqvCis/LItHiRxpWD8V///ZaQ7/cUHxoitXk=;
 b=UnmBZT9SYfE2P1GXILdvvtKwQGuPFSjbJwB1jGpFmr+QU78mNl4NUx3TVX0UF0ikM+Yn/guL8tu4IrV4GptCzRbLU3/oxOK8ptos5zuAkRpXcVrWE/CoBedFsO+vtN2U0CMbhoFcgMkAnXngo0N2kvK6XtWIzPVooPfLGAbLErY=
Received: from SJ0PR03CA0337.namprd03.prod.outlook.com (2603:10b6:a03:39c::12)
 by SA1PR12MB8842.namprd12.prod.outlook.com (2603:10b6:806:378::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 18:16:43 +0000
Received: from MWH0EPF000C6195.namprd02.prod.outlook.com
 (2603:10b6:a03:39c:cafe::98) by SJ0PR03CA0337.outlook.office365.com
 (2603:10b6:a03:39c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 18:16:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6195.mail.protection.outlook.com (10.167.249.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 18:16:41 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 12:16:40 -0600
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 12:16:39 -0600
Message-ID: <a12185d5-fe6c-4714-78b9-5c45a45c7c30@amd.com>
Date: Tue, 10 Nov 2026 10:16:39 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1 2/2] accel/amdxdna: use drm_gpusvm_pages for user
 mapping tracking
Content-Language: en-US
To: Max Zhen <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>,
 <thomas.hellstrom@linux.intel.com>, <himal.prasad.ghimiray@intel.com>,
 <honghuan@amd.com>
CC: Matthew Brost <matthew.brost@intel.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>
References: <20261106184217.2720718-1-lizhi.hou@amd.com>
 <20261106184217.2720718-2-lizhi.hou@amd.com>
 <b76bb18c-a0e5-4a49-8866-888df3bd9a30@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <b76bb18c-a0e5-4a49-8866-888df3bd9a30@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6195:EE_|SA1PR12MB8842:EE_
X-MS-Office365-Filtering-Correlation-Id: 4561ba75-9f7d-427a-66c2-08df3f56c529
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|56012099006|4143699003|11063799006|5023799004|22082099003|18002099003|10067099003|261009223327099003|261009221727099003|261009223027099003|261009220027099003|261009221227099003|261026140227099003|261026121527099003|261102123227099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|261022113327099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: /424k2R0fprI2FOBm7zVIBVTlL1u2+Mxb02U30xwwVzhiqFd9B3MrngvW3hhbONkrqKneZ+88grSaYrWM5xwUJHYgPuvZbNpy+WGBso4QmpXjFEICIpfAJ7622IEE6LiDxe9HzKvrpS3N7BNbgTK4X105UzUUSCh0Wl+LcEUw34g/avsB9+8ZdIRFnFmJOJF2h+K1aQFF43RfcQJYsQHmgW0REw5DitHBOdfBSYkGRtz2zM3iJggqFszGl9mH+be0dCRPTJ4YLVrWCuY+MYNoGQcdpXkxi0yVtjvQ0Pan65zl96MDRg2gwqD0BO6jq5i+J9chWGrmSeSg7tBZEmm2bazoLfyICJjxxfLqGhNnlc8FvA+Ug4MiR+6VRigEHmVXU51jUbQUSk8S14WL0A9vzQXvNaUMlrK+kRM0gC+lrWV4U+gsdTvvTUz88hAvA69Hjb3PwAIiVhWgXLeoAKLmIX5aG0YlVlTgYRluENdcH94e70fAZmNu0GjLbhMYZJXtaGGOEfQ/SBMNu19Ha66SqJCmPZ1eVm4xB8BPBcOOoeYsD66NjALVPqhDe0Ummc7DrMmV+mttlK+2WSTNvz+1ALvfkMYz53S69ScNEeAzToROQPYEjr57dvxZcILaBvdSjz5qt/n7Mff2ZINOCaNSYGX+UIGB3yIC7VklQy1adx9sYWkMjOs4ubyVavT8cqgTC9/XreD1189IxRJqVtsoA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(56012099006)(4143699003)(11063799006)(5023799004)(22082099003)(18002099003)(10067099003)(261009223327099003)(261009221727099003)(261009223027099003)(261009220027099003)(261009221227099003)(261026140227099003)(261026121527099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261022113327099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: n635NHl7B3Vx0YFDpLSzzMjPCL8Ngb9PEPne0VNpc85S+8/IKlctLWs+vOaq1RwHr3KV3kGtAalvmLdHaGedYjxxGrgIhVHFGbzeh5+f4fI3rwdvIyLrP+xofeMtJfrgfGYeQZfMtEYvqsi35uhrHncMHrLMnfjY9Td2hmYkCwmKXBv1nCWDFRrQdi7T1fGxbM+9Ijw07LIH18ZYoEbaEBwYmlWlpmBr+sTvpvtYI8IAh3+SEmNWi/yTVXDTdmLgmvLfq+85tiVzomCtLDxyAL4kzomOksKm7hYoSw9qfnFFCyhl4wYVyaQYNkLBfH+XclRPkOtvnD+E0ePmvZ06qA+g2WBHNL6e/xDz1yB3pevSi80h/9nv2OEcCB3+qdkrdlhRYG/exuB2QdlAj8pTPJvpLRangw5yER68y5cfKmfyvf9HE/MW3lEk00mN7hQz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 18:16:41.6647 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4561ba75-9f7d-427a-66c2-08df3f56c529
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6195.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8842
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Applied drm-misc-next

On 11/9/26 11:44, Max Zhen wrote:
>
>
> On 11/6/2026 Fri 10:42, Lizhi Hou wrote:
>> From: Matthew Brost <matthew.brost@intel.com>
>>
>> In PASID mode the device accesses user mappings of a BO through the
>> IOMMU, but cannot take page faults, so the driver faults the CPU pages
>> in with HMM before submitting a job and waits for the job from the MMU
>> notifier. The HMM PFNs themselves are never used.
>>
>> The open coded implementation of this has a few problems:
>>
>> - Each mapping embeds a struct hmm_range, and keeps the PFN array it
>>    points at allocated for the lifetime of the mapping, although the
>>    PFNs are dropped as soon as the fault returns.
>> - The per mapping invalid flag duplicates what the notifier sequence
>>    number already tracks, and must be kept in sync with it.
>> - The notifier lock is taken in write mode on the populate path.
>> - Submission locks all reservations, finds the first BO with an
>>    invalidated mapping, unlocks everything, faults that single BO in and
>>    starts over, once per invalidated BO.
>>
>> drm_gpusvm already implements the fault and retry loop, including
>> faulting without a DMA mapping (&drm_gpusvm_ctx.no_dma_map), and its
>> pages only mode does not require the driver to use drm_gpusvm ranges.
>> Use it:
>>
>> - Replace the device notifier_lock with a pages only struct drm_gpusvm
>>    and its notifier lock.
>> - Replace the embedded hmm_range and the invalid/unmapped flags with a
>>    struct drm_gpusvm_pages. A mapping is stale when
>>    drm_gpusvm_pages_read_retry() says so and it is not unmapped.
>> - Fault in all stale mappings with drm_gpusvm_get_pages() before
>>    locking the reservations, then check that none went stale again
>>    under the notifier lock, which is held until the job fences are
>>    published, as before.
>> - The invalidate callback only bumps the sequence number and marks the
>>    mapping unmapped on MMU_NOTIFY_UNMAP under the write lock, before
>>    waiting for the jobs.
>>
>> A temporary PFN array is now allocated per fault instead of keeping one
>> per mapping, which also removes the race above.
>>
>> Assisted-by: LLM
>> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>> [Lizhi: Merge with latest code]
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviewed-by: Max Zhen <max.zhen@amd.com>
>> ---
>>   drivers/accel/amdxdna/Kconfig           |   2 +-
>>   drivers/accel/amdxdna/aie2_ctx.c        |  31 +--
>>   drivers/accel/amdxdna/aie4_ctx.c        |  29 +--
>>   drivers/accel/amdxdna/amdxdna_gem.c     | 312 +++++++++++++-----------
>>   drivers/accel/amdxdna/amdxdna_gem.h     |  23 +-
>>   drivers/accel/amdxdna/amdxdna_pci_drv.c |  15 +-
>>   drivers/accel/amdxdna/amdxdna_pci_drv.h |   3 +-
>>   7 files changed, 213 insertions(+), 202 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/Kconfig 
>> b/drivers/accel/amdxdna/Kconfig
>> index eddff490b4f75..3721eb580b71a 100644
>> --- a/drivers/accel/amdxdna/Kconfig
>> +++ b/drivers/accel/amdxdna/Kconfig
>> @@ -7,10 +7,10 @@ config DRM_ACCEL_AMDXDNA
>>       depends on PCI && HAS_IOMEM
>>       depends on X86_64
>>       depends on AMD_PMF || !AMD_PMF
>> +    select DRM_GPUSVM
>>       select DRM_SCHED
>>       select DRM_GEM_SHMEM_HELPER
>>       select FW_LOADER
>> -    select HMM_MIRROR
>>       help
>>         Choose this option to enable support for NPU integrated into AMD
>>         client CPUs like AMD Ryzen AI 300 Series. AMD NPU can be used to
>> diff --git a/drivers/accel/amdxdna/aie2_ctx.c 
>> b/drivers/accel/amdxdna/aie2_ctx.c
>> index e1c0e0689b12e..552c30ea6e387 100644
>> --- a/drivers/accel/amdxdna/aie2_ctx.c
>> +++ b/drivers/accel/amdxdna/aie2_ctx.c
>> @@ -1116,8 +1116,7 @@ int aie2_cmd_submit(struct amdxdna_hwctx 
>> *hwctx, struct amdxdna_sched_job *job,
>>       struct amdxdna_dev *xdna = hwctx->client->xdna;
>>       struct ww_acquire_ctx acquire_ctx;
>>       struct dma_fence_chain *chain;
>> -    struct amdxdna_gem_obj *abo;
>> -    unsigned long timeout = 0;
>> +    unsigned long deadline;
>>       int ret, i;
>>         ret = down_interruptible(&hwctx->priv->job_sem);
>> @@ -1140,7 +1139,15 @@ int aie2_cmd_submit(struct amdxdna_hwctx 
>> *hwctx, struct amdxdna_sched_job *job,
>>           goto free_chain;
>>       }
>>   +    deadline = jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
>>   retry:
>> +    for (i = 0; i < job->bo_cnt; i++) {
>> +        ret = amdxdna_gem_umap_populate(to_xdna_obj(job->bos[i]),
>> +                        deadline);
>> +        if (ret)
>> +            goto cleanup_job;
>> +    }
>> +
>>       ret = drm_gem_lock_reservations(job->bos, job->bo_cnt, 
>> &acquire_ctx);
>>       if (ret) {
>>           XDNA_WARN(xdna, "Failed to lock BOs, ret %d", ret);
>> @@ -1156,23 +1163,11 @@ int aie2_cmd_submit(struct amdxdna_hwctx 
>> *hwctx, struct amdxdna_sched_job *job,
>>           }
>>       }
>>   -    down_read(&xdna->notifier_lock);
>> +    drm_gpusvm_notifier_lock(&xdna->gpusvm);
>>       for (i = 0; i < job->bo_cnt; i++) {
>> -        abo = to_xdna_obj(job->bos[i]);
>> -        if (abo->mem.map_invalid) {
>> -            up_read(&xdna->notifier_lock);
>> +        if (amdxdna_gem_umap_stale(to_xdna_obj(job->bos[i]))) {
>> +            drm_gpusvm_notifier_unlock(&xdna->gpusvm);
>>               drm_gem_unlock_reservations(job->bos, job->bo_cnt, 
>> &acquire_ctx);
>> -            if (!timeout) {
>> -                timeout = jiffies +
>> - msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
>> -            } else if (time_after(jiffies, timeout)) {
>> -                ret = -ETIME;
>> -                goto cleanup_job;
>> -            }
>> -
>> -            ret = amdxdna_populate_range(abo);
>> -            if (ret)
>> -                goto cleanup_job;
>>               goto retry;
>>           }
>>       }
>> @@ -1192,7 +1187,7 @@ int aie2_cmd_submit(struct amdxdna_hwctx 
>> *hwctx, struct amdxdna_sched_job *job,
>>       drm_syncobj_add_point(hwctx->priv->syncobj, chain, 
>> job->out_fence, *seq);
>>       mutex_unlock(&hwctx->priv->io_lock);
>>   -    up_read(&xdna->notifier_lock);
>> +    drm_gpusvm_notifier_unlock(&xdna->gpusvm);
>>       drm_gem_unlock_reservations(job->bos, job->bo_cnt, &acquire_ctx);
>>         aie2_job_put(job);
>> diff --git a/drivers/accel/amdxdna/aie4_ctx.c 
>> b/drivers/accel/amdxdna/aie4_ctx.c
>> index a3f0a69b93b75..0db7dcdf106ba 100644
>> --- a/drivers/accel/amdxdna/aie4_ctx.c
>> +++ b/drivers/accel/amdxdna/aie4_ctx.c
>> @@ -1059,8 +1059,7 @@ static int fence_job_bos(struct amdxdna_dev 
>> *xdna, struct amdxdna_sched_job *job
>>   {
>>       struct ww_acquire_ctx acquire_ctx;
>>       struct drm_gem_object **objs;
>> -    struct amdxdna_gem_obj *abo;
>> -    unsigned long timeout = 0;
>> +    unsigned long deadline;
>>       u32 cnt = 0;
>>       int ret;
>>       u32 i;
>> @@ -1076,7 +1075,13 @@ static int fence_job_bos(struct amdxdna_dev 
>> *xdna, struct amdxdna_sched_job *job
>>       for (i = 0; i < job->aie4_cmd_bo_cnt; i++)
>>           add_lock_obj(objs, &cnt, to_gobj(job->aie4_cmd_bos[i]));
>>   +    deadline = jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
>>   retry:
>> +    for (i = 0; i < cnt; i++) {
>> +        ret = amdxdna_gem_umap_populate(to_xdna_obj(objs[i]), 
>> deadline);
>> +        if (ret)
>> +            goto free_objs;
>> +    }
>>       ret = drm_gem_lock_reservations(objs, cnt, &acquire_ctx);
>>       if (ret) {
>>           XDNA_WARN(xdna, "Failed to lock BOs, ret %d", ret);
>> @@ -1091,23 +1096,11 @@ static int fence_job_bos(struct amdxdna_dev 
>> *xdna, struct amdxdna_sched_job *job
>>           }
>>       }
>>   -    down_read(&xdna->notifier_lock);
>> +    drm_gpusvm_notifier_lock(&xdna->gpusvm);
>>       for (i = 0; i < cnt; i++) {
>> -        abo = to_xdna_obj(objs[i]);
>> -        if (abo->mem.map_invalid) {
>> -            up_read(&xdna->notifier_lock);
>> +        if (amdxdna_gem_umap_stale(to_xdna_obj(objs[i]))) {
>> +            drm_gpusvm_notifier_unlock(&xdna->gpusvm);
>>               drm_gem_unlock_reservations(objs, cnt, &acquire_ctx);
>> -            if (!timeout) {
>> -                timeout = jiffies +
>> - msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
>> -            } else if (time_after(jiffies, timeout)) {
>> -                ret = -ETIME;
>> -                goto free_objs;
>> -            }
>> -
>> -            ret = amdxdna_populate_range(abo);
>> -            if (ret)
>> -                goto free_objs;
>>               goto retry;
>>           }
>>       }
>> @@ -1115,7 +1108,7 @@ static int fence_job_bos(struct amdxdna_dev 
>> *xdna, struct amdxdna_sched_job *job
>>       job->out_fence = dma_fence_get(job->fence);
>>       for (i = 0; i < cnt; i++)
>>           dma_resv_add_fence(objs[i]->resv, job->out_fence, 
>> DMA_RESV_USAGE_WRITE);
>> -    up_read(&xdna->notifier_lock);
>> +    drm_gpusvm_notifier_unlock(&xdna->gpusvm);
>>     unlock:
>>       drm_gem_unlock_reservations(objs, cnt, &acquire_ctx);
>> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c 
>> b/drivers/accel/amdxdna/amdxdna_gem.c
>> index 09e48c794e1b0..57d87fa98d671 100644
>> --- a/drivers/accel/amdxdna/amdxdna_gem.c
>> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
>> @@ -232,37 +232,46 @@ static bool amdxdna_hmm_invalidate(struct 
>> mmu_interval_notifier *mni,
>>   {
>>       struct amdxdna_umap *mapp = container_of(mni, struct 
>> amdxdna_umap, notifier);
>>       struct amdxdna_gem_obj *abo = mapp->abo;
>> -    struct amdxdna_dev *xdna;
>> +    struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
>> +    bool unreg;
>>         if (!mmu_notifier_range_blockable(range))
>>           return false;
>>   -    if (mapp->unmapped)
>> -        return true;
>> -
>> -    xdna = to_xdna_dev(to_gobj(abo)->dev);
>>       XDNA_DBG(xdna, "Invalidating range 0x%lx, 0x%lx, type %d",
>> -         mapp->range.start, mapp->range.end, abo->type);
>> +         mapp->start, mapp->end, abo->type);
>>   -    down_write(&xdna->notifier_lock);
>> -    abo->mem.map_invalid = true;
>> -    mapp->invalid = true;
>> -    mmu_interval_set_seq(&mapp->notifier, cur_seq);
>> -    up_write(&xdna->notifier_lock);
>> +    down_write(&xdna->gpusvm.notifier_lock);
>> +    mmu_interval_set_seq(mni, cur_seq);
>> +    /*
>> +     * Flag the mapping as gone before the wait below, so that a 
>> submission
>> +     * racing with the unmap does not try to fault it in again.
>> +     */
>> +    unreg = !mapp->pages.flags.unmapped && range->event == 
>> MMU_NOTIFY_UNMAP;
>> +    if (unreg)
>> +        drm_gpusvm_pages_set_unmapped(&xdna->gpusvm, &mapp->pages, 1);
>> +    up_write(&xdna->gpusvm.notifier_lock);
>>         /*
>>        * The pages must not be released while the device may still 
>> access
>>        * them, so this wait must be neither interruptible nor time 
>> limited.
>> +     *
>> +     * Every invalidation of the mapping has to wait, including the 
>> ones
>> +     * which find it already flagged: the flag is set above before 
>> the wait,
>> +     * so it does not tell whether the jobs of a concurrent 
>> invalidation
>> +     * have finished.
>>        */
>>       dma_resv_wait_timeout(to_gobj(abo)->resv, DMA_RESV_USAGE_BOOKKEEP,
>>                     false, MAX_SCHEDULE_TIMEOUT);
>>   -    if (range->event == MMU_NOTIFY_UNMAP) {
>> -        down_write(&xdna->notifier_lock);
>> -        mapp->unmapped = true;
>> +    /*
>> +     * Queue the unregistration only once the jobs are done: it 
>> drops the
>> +     * last reference of the mapping, and 
>> mmu_interval_notifier_remove()
>> +     * waits for this callback, which would pin the single worker of 
>> the
>> +     * ordered WQ_MEM_RECLAIM notifier_wq for as long as a job runs.
>> +     */
>> +    if (unreg)
>>           queue_work(xdna->notifier_wq, &abo->hmm_unreg_work);
>> -        up_write(&xdna->notifier_lock);
>> -    }
>>         return true;
>>   }
>> @@ -271,12 +280,25 @@ static const struct mmu_interval_notifier_ops 
>> amdxdna_hmm_ops = {
>>       .invalidate = amdxdna_hmm_invalidate,
>>   };
>>   -static inline bool compare_range(struct amdxdna_umap *mapp,
>> -                 struct mm_struct *mm,
>> -                 unsigned long start, unsigned long end)
>> +static bool amdxdna_umap_match(struct amdxdna_umap *mapp,
>> +                   struct mm_struct *mm,
>> +                   unsigned long start, unsigned long end)
>>   {
>> -    return (!mapp->unmapped && mapp->notifier.mm == mm &&
>> -        mapp->range.start == start && mapp->range.end == end);
>> +    return !mapp->pages.flags.unmapped && mapp->notifier.mm == mm &&
>> +        mapp->start == start && mapp->end == end;
>> +}
>> +
>> +static bool amdxdna_umap_stale(struct drm_gpusvm *gpusvm,
>> +                   struct amdxdna_umap *mapp)
>> +{
>> +    /*
>> +     * The pages of a BO whose mappings mmap() populated upfront are 
>> never
>> +     * faulted in. Neither are the ones of a mapping which is gone: 
>> device
>> +     * accesses through it are rejected by the IOMMU, so there is 
>> nothing
>> +     * to fault in for it.
>> +     */
>> +    return mapp->abo->mem.map_invalid && !mapp->pages.flags.unmapped &&
>> +        drm_gpusvm_pages_read_retry(gpusvm, &mapp->pages, 
>> &mapp->notifier);
>>   }
>>     static void amdxdna_hmm_unregister(struct amdxdna_gem_obj *abo,
>> @@ -285,15 +307,28 @@ static void amdxdna_hmm_unregister(struct 
>> amdxdna_gem_obj *abo,
>>       struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
>>       struct amdxdna_umap *mapp;
>>   -    down_write(&xdna->notifier_lock);
>> +    down_write(&xdna->gpusvm.notifier_lock);
>>       list_for_each_entry(mapp, &abo->mem.umap_list, node) {
>> -        if (!compare_range(mapp, vma->vm_mm, vma->vm_start, 
>> vma->vm_end))
>> +        if (!amdxdna_umap_match(mapp, vma->vm_mm, vma->vm_start, 
>> vma->vm_end))
>>               continue;
>>   -        mapp->unmapped = true;
>> +        drm_gpusvm_pages_set_unmapped(&xdna->gpusvm, &mapp->pages, 1);
>>           queue_work(xdna->notifier_wq, &abo->hmm_unreg_work);
>>       }
>> -    up_write(&xdna->notifier_lock);
>> +    up_write(&xdna->gpusvm.notifier_lock);
>> +}
>> +
>> +static void amdxdna_umap_release(struct kref *ref)
>> +{
>> +    struct amdxdna_umap *mapp = container_of(ref, struct 
>> amdxdna_umap, refcnt);
>> +
>> +    mmu_interval_notifier_remove(&mapp->notifier);
>> +    kfree(mapp);
>> +}
>> +
>> +static void amdxdna_umap_put(struct amdxdna_umap *mapp)
>> +{
>> +    kref_put(&mapp->refcnt, amdxdna_umap_release);
>>   }
>>     static void amdxdna_hmm_unreg_umaps(struct amdxdna_gem_obj *abo, 
>> bool force)
>> @@ -302,121 +337,119 @@ static void amdxdna_hmm_unreg_umaps(struct 
>> amdxdna_gem_obj *abo, bool force)
>>       struct amdxdna_umap *mapp, *tmp;
>>       LIST_HEAD(dead);
>>   -    down_write(&xdna->notifier_lock);
>> +    down_write(&xdna->gpusvm.notifier_lock);
>>       list_for_each_entry_safe(mapp, tmp, &abo->mem.umap_list, node) {
>> -        if (!force && !mapp->unmapped)
>> +        if (!force && !mapp->pages.flags.unmapped)
>>               continue;
>>   -        mapp->unmapped = true;
>> +        drm_gpusvm_pages_set_unmapped(&xdna->gpusvm, &mapp->pages, 1);
>>           list_move(&mapp->node, &dead);
>>       }
>>       if (list_empty(&abo->mem.umap_list))
>>           abo->mem.uva = AMDXDNA_INVALID_ADDR;
>> -    up_write(&xdna->notifier_lock);
>> +    up_write(&xdna->gpusvm.notifier_lock);
>>         list_for_each_entry_safe(mapp, tmp, &dead, node)
>>           amdxdna_umap_put(mapp);
>>   }
>>   -static void amdxdna_umap_release(struct kref *ref)
>> +static void amdxdna_hmm_unreg_work(struct work_struct *work)
>>   {
>> -    struct amdxdna_umap *mapp = container_of(ref, struct 
>> amdxdna_umap, refcnt);
>> -
>> -    mmu_interval_notifier_remove(&mapp->notifier);
>> -    mutex_destroy(&mapp->lock);
>> -    kvfree(mapp->range.hmm_pfns);
>> -    kfree(mapp);
>> -}
>> +    struct amdxdna_gem_obj *abo = container_of(work, struct 
>> amdxdna_gem_obj,
>> +                           hmm_unreg_work);
>>   -void amdxdna_umap_put(struct amdxdna_umap *mapp)
>> -{
>> -    kref_put(&mapp->refcnt, amdxdna_umap_release);
>> +    amdxdna_hmm_unreg_umaps(abo, false);
>>   }
>>   -int amdxdna_populate_range(struct amdxdna_gem_obj *abo)
>> +/**
>> + * amdxdna_gem_umap_populate() - Fault in the invalidated user 
>> mappings of a BO
>> + * @abo: The BO.
>> + * @deadline: Jiffies after which to give up.
>> + *
>> + * The device accesses user mappings through the PASID and cannot 
>> take page
>> + * faults, so the CPU pages of every mapping of @abo invalidated 
>> since it was
>> + * last faulted are faulted in again here. This is only a snapshot, 
>> the caller
>> + * must check amdxdna_gem_umap_stale() under the notifier lock 
>> before using
>> + * the mappings and retry if it fails.
>> + *
>> + * Two hardware contexts may fault the same mapping at the same 
>> time. That is
>> + * left unserialized: with &drm_gpusvm_ctx.no_dma_map the only state 
>> recorded
>> + * for a mapping is its notifier sequence, and the loser of such a 
>> race can
>> + * only store an older sequence, which makes 
>> amdxdna_gem_umap_stale() report
>> + * stale and the caller fault again.
>> + *
>> + * Return: 0 on success, -ETIME if @deadline passed, negative error 
>> code on
>> + * other failures.
>> + */
>> +int amdxdna_gem_umap_populate(struct amdxdna_gem_obj *abo,
>> +                  unsigned long deadline)
>>   {
>>       struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
>> +    struct drm_gpusvm *gpusvm = &xdna->gpusvm;
>>       struct amdxdna_umap *mapp;
>> -    unsigned long timeout;
>> -    struct mm_struct *mm;
>> -    bool found;
>> +    bool found, unmapped;
>>       int ret;
>>   -    timeout = msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
>> -again:
>> -    found = false;
>> -    down_write(&xdna->notifier_lock);
>> -    list_for_each_entry(mapp, &abo->mem.umap_list, node) {
>> -        /*
>> -         * Skip entries that have already been unmapped.
>> -         *
>> -         * If userspace unmaps the address and later submits I/O using
>> -         * it, the IOMMU will reject the access and report a fault.
>> -         * Ignore such entries here.
>> -         */
>> -        if (mapp->unmapped)
>> -            continue;
>> +    for (;;) {
>> +        struct drm_gpusvm_ctx ctx = { .no_dma_map = 1 };
>>   -        if (mapp->invalid && kref_get_unless_zero(&mapp->refcnt)) {
>> -            found = true;
>> -            break;
>> +        found = false;
>> +        drm_gpusvm_notifier_lock(gpusvm);
>> +        list_for_each_entry(mapp, &abo->mem.umap_list, node) {
>> +            if (amdxdna_umap_stale(gpusvm, mapp) &&
>> +                kref_get_unless_zero(&mapp->refcnt)) {
>> +                found = true;
>> +                break;
>> +            }
>>           }
>> -    }
>> -
>> -    if (!found) {
>> -        /*
>> -         * This also covers the case where all mappings have been
>> -         * removed. There are no invalid mappings left to process.
>> -         * Any subsequent I/O using the unmapped address will be
>> -         * rejected by the IOMMU.
>> -         */
>> -        abo->mem.map_invalid = false;
>> -        up_write(&xdna->notifier_lock);
>> -        return 0;
>> -    }
>> -
>> -    up_write(&xdna->notifier_lock);
>> -
>> -    mm = mapp->notifier.mm;
>> -    if (!mmget_not_zero(mm)) {
>> -        amdxdna_umap_put(mapp);
>> -        return -EFAULT;
>> -    }
>> +        drm_gpusvm_notifier_unlock(gpusvm);
>> +        if (!found)
>> +            return 0;
>>   -    mutex_lock(&mapp->lock);
>> -    ret = hmm_range_fault_unlocked_timeout(&mapp->range, timeout);
>> -    if (ret) {
>> -        mutex_unlock(&mapp->lock);
>> -        goto put_mm;
>> -    }
>> +        if (time_after(jiffies, deadline)) {
>> +            amdxdna_umap_put(mapp);
>> +            return -ETIME;
>> +        }
>>   -    down_write(&xdna->notifier_lock);
>> -    if (mmu_interval_read_retry(&mapp->notifier, 
>> mapp->range.notifier_seq)) {
>> -        up_write(&xdna->notifier_lock);
>> -        mutex_unlock(&mapp->lock);
>> +        ctx.read_only = mapp->read_only;
>> +        ret = drm_gpusvm_get_pages(gpusvm, &mapp->pages, 1,
>> +                       mapp->notifier.mm, &mapp->notifier,
>> +                       mapp->start, mapp->end, &ctx);
>> +        if (ret == -EFAULT) {
>> +            drm_gpusvm_notifier_lock(gpusvm);
>> +            unmapped = mapp->pages.flags.unmapped;
>> +            drm_gpusvm_notifier_unlock(gpusvm);
>> +            if (unmapped)
>> +                ret = 0;
>> +        }
>>           amdxdna_umap_put(mapp);
>> -        mmput(mm);
>> -        goto again;
>> +        if (ret)
>> +            return ret == -EBUSY ? -ETIME : ret;
>>       }
>> -    mapp->invalid = false;
>> -    up_write(&xdna->notifier_lock);
>> -    mutex_unlock(&mapp->lock);
>> -    amdxdna_umap_put(mapp);
>> -    mmput(mm);
>> -    goto again;
>> -
>> -put_mm:
>> -    amdxdna_umap_put(mapp);
>> -    mmput(mm);
>> -    return ret == -EBUSY ? -ETIME : ret;
>>   }
>>   -static void amdxdna_hmm_unreg_work(struct work_struct *work)
>> +/**
>> + * amdxdna_gem_umap_stale() - Check whether a BO needs its user 
>> mappings faulted
>> + * @abo: The BO.
>> + *
>> + * Must be called with the notifier lock held, which must be kept 
>> held until
>> + * the fences of the jobs using @abo are published in its 
>> reservation object.
>> + *
>> + * Return: True if amdxdna_gem_umap_populate() must be called for @abo.
>> + */
>> +bool amdxdna_gem_umap_stale(struct amdxdna_gem_obj *abo)
>>   {
>> -    struct amdxdna_gem_obj *abo = container_of(work, struct 
>> amdxdna_gem_obj,
>> -                           hmm_unreg_work);
>> +    struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
>> +    struct amdxdna_umap *mapp;
>>   -    amdxdna_hmm_unreg_umaps(abo, false);
>> +    lockdep_assert_held(&xdna->gpusvm.notifier_lock);
>> +
>> +    list_for_each_entry(mapp, &abo->mem.umap_list, node) {
>> +        if (amdxdna_umap_stale(&xdna->gpusvm, mapp))
>> +            return true;
>> +    }
>> +
>> +    return false;
>>   }
>>     static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
>> @@ -426,7 +459,6 @@ static int amdxdna_hmm_register(struct 
>> amdxdna_gem_obj *abo,
>>       unsigned long len = vma->vm_end - vma->vm_start;
>>       unsigned long addr = vma->vm_start;
>>       struct amdxdna_umap *mapp;
>> -    unsigned long nr_pages;
>>       int ret;
>>         /*
>> @@ -441,38 +473,34 @@ static int amdxdna_hmm_register(struct 
>> amdxdna_gem_obj *abo,
>>           return 0;
>>       }
>>   -    down_read(&xdna->notifier_lock);
>> +    down_read(&xdna->gpusvm.notifier_lock);
>>       list_for_each_entry(mapp, &abo->mem.umap_list, node) {
>> -        if (compare_range(mapp, current->mm, addr, addr + len)) {
>> -            up_read(&xdna->notifier_lock);
>> +        if (amdxdna_umap_match(mapp, current->mm, addr, addr + len)) {
>> +            up_read(&xdna->gpusvm.notifier_lock);
>>               return 0;
>>           }
>>       }
>> -    up_read(&xdna->notifier_lock);
>> +    up_read(&xdna->gpusvm.notifier_lock);
>>         mapp = kzalloc_obj(*mapp);
>>       if (!mapp)
>>           return -ENOMEM;
>>   -    nr_pages = (PAGE_ALIGN(addr + len) - (addr & PAGE_MASK)) >> 
>> PAGE_SHIFT;
>> -    mapp->range.hmm_pfns = kvzalloc_objs(*mapp->range.hmm_pfns, 
>> nr_pages);
>> -    if (!mapp->range.hmm_pfns) {
>> -        ret = -ENOMEM;
>> -        goto free_map;
>> -    }
>> +    /*
>> +     * Never faulted, so stale until the first 
>> amdxdna_gem_umap_populate(),
>> +     * should the pages of the BO have to be faulted in at all.
>> +     */
>> +    drm_gpusvm_init_pages(&mapp->pages, &xdna->ddev);
>> +    mapp->start = addr;
>> +    mapp->end = addr + len;
>>   -    mapp->range.notifier = &mapp->notifier;
>> -    mapp->range.start = vma->vm_start;
>> -    mapp->range.end = vma->vm_end;
>>       /*
>>        * Access permissions are fixed at mmap() time. Changing them 
>> later
>> -     * with mprotect() is not supported: the range keeps requesting the
>> +     * with mprotect() is not supported: the mapping keeps 
>> requesting the
>>        * original permissions, so the application may see a fault 
>> failure
>>        * or an IOMMU fault.
>>        */
>> -    mapp->range.default_flags = HMM_PFN_REQ_FAULT;
>> -    if (vma->vm_flags & VM_WRITE)
>> -        mapp->range.default_flags |= HMM_PFN_REQ_WRITE;
>> +    mapp->read_only = !(vma->vm_flags & VM_WRITE);
>>       mapp->abo = abo;
>>       kref_init(&mapp->refcnt);
>>   @@ -483,23 +511,17 @@ static int amdxdna_hmm_register(struct 
>> amdxdna_gem_obj *abo,
>>                             &amdxdna_hmm_ops);
>>       if (ret) {
>>           XDNA_ERR(xdna, "Insert mmu notifier failed, ret %d", ret);
>> -        goto free_pfns;
>> +        kfree(mapp);
>> +        return ret;
>>       }
>>   -    mutex_init(&mapp->lock);
>> -    down_write(&xdna->notifier_lock);
>> +    down_write(&xdna->gpusvm.notifier_lock);
>>       if (list_empty(&abo->mem.umap_list))
>>           abo->mem.uva = addr;
>>       list_add_tail(&mapp->node, &abo->mem.umap_list);
>> -    up_write(&xdna->notifier_lock);
>> +    up_write(&xdna->gpusvm.notifier_lock);
>>         return 0;
>> -
>> -free_pfns:
>> -    kvfree(mapp->range.hmm_pfns);
>> -free_map:
>> -    kfree(mapp);
>> -    return ret;
>>   }
>>     static struct amdxdna_gem_obj *
>> @@ -547,21 +569,13 @@ static void amdxdna_gem_dev_obj_free(struct 
>> drm_gem_object *gobj)
>>       amdxdna_gem_destroy_obj(abo);
>>   }
>>   -static void amdxdna_mark_mapp_invalid(struct amdxdna_gem_obj *abo,
>> -                      struct vm_area_struct *vma)
>> +static void amdxdna_mark_map_invalid(struct amdxdna_gem_obj *abo)
>>   {
>>       struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
>> -    struct amdxdna_umap *mapp;
>>   -    down_write(&xdna->notifier_lock);
>> +    down_write(&xdna->gpusvm.notifier_lock);
>>       abo->mem.map_invalid = true;
>> -    list_for_each_entry(mapp, &abo->mem.umap_list, node) {
>> -        if (compare_range(mapp, vma->vm_mm, vma->vm_start, 
>> vma->vm_end)) {
>> -            mapp->invalid = true;
>> -            break;
>> -        }
>> -    }
>> -    up_write(&xdna->notifier_lock);
>> +    up_write(&xdna->gpusvm.notifier_lock);
>>   }
>>     static int amdxdna_remap_pages(struct amdxdna_gem_obj *abo,
>> @@ -628,7 +642,7 @@ static int amdxdna_insert_pages(struct 
>> amdxdna_gem_obj *abo,
>>           }
>>             if (!(vma->vm_flags & VM_PFNMAP))
>> -            amdxdna_mark_mapp_invalid(abo, vma);
>> +            amdxdna_mark_map_invalid(abo);
>>             /* Drop the reference drm_gem_mmap_obj() acquired.*/
>>           drm_gem_object_put(to_gobj(abo));
>> diff --git a/drivers/accel/amdxdna/amdxdna_gem.h 
>> b/drivers/accel/amdxdna/amdxdna_gem.h
>> index 5c429869992e8..2deead107d6b1 100644
>> --- a/drivers/accel/amdxdna/amdxdna_gem.h
>> +++ b/drivers/accel/amdxdna/amdxdna_gem.h
>> @@ -7,19 +7,19 @@
>>   #define _AMDXDNA_GEM_H_
>>     #include <drm/drm_gem_shmem_helper.h>
>> -#include <linux/hmm.h>
>> +#include <drm/drm_gpusvm.h>
>>   #include <linux/iova.h>
>>   #include "amdxdna_pci_drv.h"
>>     struct amdxdna_umap {
>>       struct mmu_interval_notifier    notifier;
>> -    struct hmm_range        range;
>> +    struct drm_gpusvm_pages        pages;
>> +    unsigned long            start;
>> +    unsigned long            end;
>> +    bool                read_only;
>>       struct amdxdna_gem_obj        *abo;
>>       struct list_head        node;
>>       struct kref            refcnt;
>> -    bool                invalid;
>> -    bool                unmapped;
>> -    struct mutex            lock; /* protect range */
>>   };
>>     struct amdxdna_mem {
>> @@ -27,10 +27,16 @@ struct amdxdna_mem {
>>       u64                dma_addr;
>>       size_t                size;
>>       struct list_head        umap_list;
>> +    /*
>> +     * True, if the pages of the user mappings have to be faulted in 
>> before
>> +     * the device accesses them. A mapping which mmap() populated 
>> upfront,
>> +     * which is a VM_PFNMAP one, must not be faulted in: 
>> hmm_range_fault()
>> +     * rejects such a VMA.
>> +     */
>>       bool                map_invalid;
>>       /*
>>        * Cache the first mmap uva as PASID addr, which can be 
>> accessed by driver
>> -     * without taking notifier_lock.
>> +     * without taking the gpusvm notifier lock.
>>        */
>>       u64                uva;
>>   };
>> @@ -103,8 +109,9 @@ static inline u64 amdxdna_obj_dma_addr(struct 
>> amdxdna_gem_obj *abo)
>>           abo->mem.dma_addr : amdxdna_gem_uva(abo);
>>   }
>>   -void amdxdna_umap_put(struct amdxdna_umap *mapp);
>> -int amdxdna_populate_range(struct amdxdna_gem_obj *abo);
>> +int amdxdna_gem_umap_populate(struct amdxdna_gem_obj *abo,
>> +                  unsigned long deadline);
>> +bool amdxdna_gem_umap_stale(struct amdxdna_gem_obj *abo);
>>   void amdxdna_gem_heap_free(struct amdxdna_client *client, struct 
>> amdxdna_gem_obj *abo);
>>     struct drm_gem_object *
>> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c 
>> b/drivers/accel/amdxdna/amdxdna_pci_drv.c
>> index f233eb70a2957..18bd7bdd12969 100644
>> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
>> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
>> @@ -363,6 +363,7 @@ static void amdxdna_xdna_drm_release(struct 
>> drm_device *drm, void *res)
>>       struct amdxdna_dev *xdna = res;
>>         amdxdna_carveout_fini(xdna);
>> +    drm_gpusvm_fini(&xdna->gpusvm);
>>   }
>>     static int amdxdna_probe(struct pci_dev *pdev, const struct 
>> pci_device_id *id)
>> @@ -389,18 +390,18 @@ static int amdxdna_probe(struct pci_dev *pdev, 
>> const struct pci_device_id *id)
>>       if (ret)
>>           return ret;
>>   -    init_rwsem(&xdna->notifier_lock);
>> +    ret = drm_gpusvm_init(&xdna->gpusvm, "amdxdna", NULL, 0, 0, 0, 
>> NULL,
>> +                  NULL, 0);
>> +    if (ret)
>> +        return ret;
>> +
>>       INIT_LIST_HEAD(&xdna->client_list);
>>       pci_set_drvdata(pdev, xdna);
>>         ret = drmm_add_action(ddev, amdxdna_xdna_drm_release, xdna);
>> -    if (ret)
>> +    if (ret) {
>> +        drm_gpusvm_fini(&xdna->gpusvm);
>>           return ret;
>> -
>> -    if (IS_ENABLED(CONFIG_LOCKDEP)) {
>> -        fs_reclaim_acquire(GFP_KERNEL);
>> -        might_lock(&xdna->notifier_lock);
>> -        fs_reclaim_release(GFP_KERNEL);
>>       }
>>         ret = amdxdna_iommu_init(xdna);
>> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h 
>> b/drivers/accel/amdxdna/amdxdna_pci_drv.h
>> index 27593190dcf67..7663b883d4f8b 100644
>> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
>> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
>> @@ -7,6 +7,7 @@
>>   #define _AMDXDNA_PCI_DRV_H_
>>     #include <drm/amdxdna_accel.h>
>> +#include <drm/drm_gpusvm.h>
>>   #include <drm/drm_mm.h>
>>   #include <drm/drm_print.h>
>>   #include <linux/iommu.h>
>> @@ -118,7 +119,7 @@ struct amdxdna_dev {
>>       struct list_head        client_list;
>>       struct mutex            client_lock; /* client_list */
>>       struct amdxdna_drm_query_firmware_version fw_ver;
>> -    struct rw_semaphore        notifier_lock; /* for mmu notifier*/
>> +    struct drm_gpusvm        gpusvm; /* notifier lock for user 
>> mappings */
>>       struct workqueue_struct        *notifier_wq;
>>         struct iommu_group        *group;
>
