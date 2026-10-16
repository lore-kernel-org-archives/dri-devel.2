Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47760CCF2C0
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 17:38:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D00C10E33C;
	Fri, 16 Oct 2026 17:38:09 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012064.outbound.protection.outlook.com
 [40.93.195.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F1A410E33C
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 17:38:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gPYloYA3AXTV5m2vqcD+a71WBlu0Rg+lRS0MW8rU+6PsHojd1i0iemZ5zc7LO/AMdF/h8+rycPYErO/2ChGjDzjiYwhCIbd4W5gfKoqXvqRcB4UEm8MkFfY4AFwVCmpuMr9eOCtHquSX+uEQS2+8ur7mXHjXBP5FkVx94k/d9GQxmgeV9VseLBbyuLkDMxIoO50hma8hs2Xp59klCYaSjCk+WlbcB5uYKnz6SUr0ThxE9KLOblqgUd7GcRbSWXX/QZbY5yPzUkcqGPUs+N774ndrtUCDl5wnoAOIWUyJFsT4Gv2drZyDTMXfoHmTL5bwqx9LFSDzIMkuG7sS4rS1ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YyKRZt0eHCsTUaYaAL7O0wbBtRRBKcHwkx5/yBgmJoM=;
 b=xyfND3J1Vd0cQCkhiS+MmWzGx9h8+ryvzvxkqagQA7D7EuQkTgLf+HG9P7mmTsPuIFRmDKqXNgfLMIEiS8nIIgb6zbasFWsDEtBEsRMvEZtsWdC43jl1CzuMKTBpdQvXj9nsEq765KxAVBYf0MXH77CTRuCjCEPXIy5OGP26ImVW1qZPsBwRUzFm27TT3kGT84NuGhczIrM/iKZnzsObvgPd/AkDlm5bxVxHxpQGiO6jELKg/8Wbhe5YroB808KYFTJsM/QbiMOrKaF+qw2oajxvD3kYIinEQquCYDX4qoTCBjFPiRO83EWmwLxxf1fpIadu5u6XH42mYf/UTyBMFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyKRZt0eHCsTUaYaAL7O0wbBtRRBKcHwkx5/yBgmJoM=;
 b=12yHWhjeUfbalrtBaDxZYg1YDLgsapVpcT/grpZwUEZdKuw/2DFHwyLBXY21CwJJ8TNRmExH1dMKDEI7UmDpY59lKID6pxRMzqvWshxgELOqTRf30mi5N1vJiqxuMYfJbArtLjuom7rDCMveSNS9hwDZfPo/lm9yeVC61fmoi1U=
Received: from MW3PR06CA0010.namprd06.prod.outlook.com (2603:10b6:303:2a::15)
 by IA3PR12MB482642.namprd12.prod.outlook.com (2603:10b6:208:712::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 17:37:57 +0000
Received: from SJ1PEPF000037A9.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::86) by MW3PR06CA0010.outlook.office365.com
 (2603:10b6:303:2a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 17:37:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037A9.mail.protection.outlook.com (10.167.244.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 17:37:57 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 12:37:49 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 16 Oct 2026 12:37:49 -0500
Message-ID: <0e18b9e5-35a8-621b-7b28-387b5eef2244@amd.com>
Date: Fri, 16 Oct 2026 10:37:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Serialize HMM range faults on one umap
Content-Language: en-US
From: Lizhi Hou <lizhi.hou@amd.com>
To: Matthew Brost <matthew.brost@intel.com>, Max Zhen <max.zhen@amd.com>
CC: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>
References: <20261012203139.2573687-1-lizhi.hou@amd.com>
 <7a29937c-b591-40fc-95cf-021799ea52a7@amd.com>
 <as21qsFsf9HepYok@gsse-cloud1.jf.intel.com>
 <75d7c27a-66f1-80cf-1aec-895828592e66@amd.com>
In-Reply-To: <75d7c27a-66f1-80cf-1aec-895828592e66@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A9:EE_|IA3PR12MB482642:EE_
X-MS-Office365-Filtering-Correlation-Id: f1a930f3-2e08-401d-a7b0-08df2bac3754
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|261009223027099003|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: rQSEXampZCzdYt975ViSqHNwvWzoXI+ISGwEFdWsomUgBy7F6iRbPBLVxhrA6keUjVkWfGRiyRmPxUfqcVgtlEdS9mWq1qpH8uzK0KBYP7uqD1lNAL0n4aSt4f+Lm69cabh9pnUBQ7PQ9uGFxUJlvJxzEuYNLNb4B8fhW1guZsrBIJxc4jhuaUGXwgfjBj+irY41HRlmuLgOHx6u7KbSTCYky4kuqOCxc87h9I1jFjAJ088rjujs32hfi/0lXMxXVIg5nn3pSYul5UYYBgABsbA+Q/jEzL+4MhsT0hHpVgmQn21YZM3u3CKWkBqPhiWRvioB+N1PE45BjFybC/DI5/UocFuu2r6+ymvUdV0g7+lBixDzIvqsVtvKjEUUNcWYE6cHPqCqcKnn9rLtCKFlJz+Qa0VnEof0XMFw8KSzRXoUlRRC7SbFrQ/AH1oxe6nzMTKa3805o2egAtfAKZk3qtdvRR6KKqa4UsX39cqXxtsk+Ap5ef79C+ywMUdmDCeQxxSATvAsAtcy+u6P1ZaJLbvYZ6ACX8dFfJKDhEhMysaDntC5l8fh74fTvhptWsgL1CqnqNzyUPn2371PyIgDctYT4tQngRJi/xTYxjpFb8liHQj+UQxGKVyJryRScFCkMyZcQhN2ZMquLL4MJdarPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(261009223027099003)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: l21MlnBveheXhEPKLkF33mpP139aV6nQlPnWUvCtG91LhNQMHX5waMOsN9SYZdWSCSMeRBVj62EulUHgXk1Hu5P31z9FgU8WyL6+KqJdlNcTaVilxssCASGN/TEil9rLwabVzckgc5I8ctRxRa6G71RxD9sbFM/rrD4rIOvJh63MCZzoHKH6/K7tPaV9w8BQi9z9I4bfFHLEULI4lNU581PaHFDyVDcNTGOJegPlGgxuyn8HrUT/55OJ7hOKo4zpacnZibiZditl1JVDvkcZxTKG+V99uabjFMozPgG5qHAcZ3XMGsGEK2YSyuijZksvLQGAveP3s0P8N7YdvCB0QSZc1CNASoMDN3mGbyggYZ2z65/p84cL2LqecwvIHNK2sOyhSSZM1qXnoZ2ogxswIkDw37hC4hO0J1bTFeujDve68jmGAVaBsIDbR36Rz9BC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 17:37:57.1301 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a930f3-2e08-401d-a7b0-08df2bac3754
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB482642
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

Applied to drm-misc-next for a quick fix.

And I will converge it to gpusvm after aie4 changes.


Thanks,

Lizhi

On 10/13/26 09:36, Lizhi Hou wrote:
>
> On 10/12/26 21:38, Matthew Brost wrote:
>> On Mon, Oct 12, 2026 at 09:10:15PM -0700, Max Zhen wrote:
>>>
>>> On 10/12/2026 Mon 13:31, Lizhi Hou wrote:
>>>> Two hardware contexts can submit jobs that use the same GEM object 
>>>> while
>>>> a user mapping is invalid. aie2_cmd_submit() drops the reservation and
>>>> notifier_lock before aie2_populate_range(), and that function takes a
>>>> reference on the first invalid umap without clearing invalid until the
>>>> fault returns. Both submissions then call
>>>> hmm_range_fault_unlocked_timeout() on the same struct hmm_range. That
>>>> structure is not safe for concurrent callers. The calls write
>>>> notifier_seq and hmm_pfns[] at the same time, so 
>>>> mmu_interval_read_retry()
>>>> can see the other call's sequence, miss an invalidation, and clear
>>>> invalid. The job is then pushed while the pages may already be gone.
>>>> Give each umap its own mutex and hold it from the fault through the 
>>>> retry
>>>> check and the store that clears invalid. notifier_lock is dropped 
>>>> before
>>>> this mutex is taken, and the fault drops mmap_lock before 
>>>> notifier_lock
>>>> is taken again.
>>>>
>>>> Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
>>>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>>> Reviewed-by: Max Zhen <max.zhen@amd.com>
>> I was browsing dri-devel and this hmm interaction annoyed me enough to
>> ask my AI to fix this and converge properly on a DRM framework:
>>
>> https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commits/local_dev/amd_hmm_cleanup 
>>
>>
>> Improper HMM or abuse affects the entire kernel, hence we should
>> converge.
>>
>> Please consider the AI suggestions (last 3 patches) instead of open
>> coding this.
>
> Sure. Using gpusvm interfaces would be great. I will patch these on my 
> system and see how it works.
>
> In the meanwhile, for back porting, will it still worth to merge this 
> patch?
>
>
> Also, we are working on aie4 hardware support which also relies on 
> hmm. Thus, aie2_populate_range() will be renamed to 
> amdxdna_populate_range() and moved to amdxdna_gem.c.
>
> https://lore.kernel.org/dri-devel/20261009225343.3079074-16-yidong.zhang@amd.com/ 
>
>
> As a great enhancement, would it be ok to put your last patch on top 
> of aie4 patches?
>
>
> And this patch in aie4 series tried to fix the same issue been pointed 
> out by your second patch.
>
> https://lore.kernel.org/dri-devel/20261009225343.3079074-15-yidong.zhang@amd.com/ 
>
>
> Does it look ok to you? ("Fixes" tag needs to be added).
>
>
> Thanks a lot,
>
> Lizhi
>
>>
>> Matt
>>
>>>> ---
>>>>    drivers/accel/amdxdna/aie2_ctx.c    | 7 ++++++-
>>>>    drivers/accel/amdxdna/amdxdna_gem.c | 2 ++
>>>>    drivers/accel/amdxdna/amdxdna_gem.h | 1 +
>>>>    3 files changed, 9 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/accel/amdxdna/aie2_ctx.c 
>>>> b/drivers/accel/amdxdna/aie2_ctx.c
>>>> index d927c8c9d557..4db67a789c34 100644
>>>> --- a/drivers/accel/amdxdna/aie2_ctx.c
>>>> +++ b/drivers/accel/amdxdna/aie2_ctx.c
>>>> @@ -1155,19 +1155,24 @@ static int aie2_populate_range(struct 
>>>> amdxdna_gem_obj *abo)
>>>>            return -EFAULT;
>>>>        }
>>>> +    mutex_lock(&mapp->lock);
>>>>        ret = hmm_range_fault_unlocked_timeout(&mapp->range, timeout);
>>>> -    if (ret)
>>>> +    if (ret) {
>>>> +        mutex_unlock(&mapp->lock);
>>>>            goto put_mm;
>>>> +    }
>>>>        down_write(&xdna->notifier_lock);
>>>>        if (mmu_interval_read_retry(&mapp->notifier, 
>>>> mapp->range.notifier_seq)) {
>>>>            up_write(&xdna->notifier_lock);
>>>> +        mutex_unlock(&mapp->lock);
>>>>            amdxdna_umap_put(mapp);
>>>>            mmput(mm);
>>>>            goto again;
>>>>        }
>>>>        mapp->invalid = false;
>>>>        up_write(&xdna->notifier_lock);
>>>> +    mutex_unlock(&mapp->lock);
>>>>        amdxdna_umap_put(mapp);
>>>>        mmput(mm);
>>>>        goto again;
>>>> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c 
>>>> b/drivers/accel/amdxdna/amdxdna_gem.c
>>>> index f14484bc31ec..37bfa5058095 100644
>>>> --- a/drivers/accel/amdxdna/amdxdna_gem.c
>>>> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
>>>> @@ -318,6 +318,7 @@ static void amdxdna_umap_release(struct kref *ref)
>>>>        struct amdxdna_umap *mapp = container_of(ref, struct 
>>>> amdxdna_umap, refcnt);
>>>>        mmu_interval_notifier_remove(&mapp->notifier);
>>>> +    mutex_destroy(&mapp->lock);
>>>>        kvfree(mapp->range.hmm_pfns);
>>>>        kfree(mapp);
>>>>    }
>>>> @@ -402,6 +403,7 @@ static int amdxdna_hmm_register(struct 
>>>> amdxdna_gem_obj *abo,
>>>>            goto free_pfns;
>>>>        }
>>>> +    mutex_init(&mapp->lock);
>>>>        down_write(&xdna->notifier_lock);
>>>>        if (list_empty(&abo->mem.umap_list))
>>>>            abo->mem.uva = addr;
>>>> diff --git a/drivers/accel/amdxdna/amdxdna_gem.h 
>>>> b/drivers/accel/amdxdna/amdxdna_gem.h
>>>> index 9b4aa21a37c9..456a537eb68c 100644
>>>> --- a/drivers/accel/amdxdna/amdxdna_gem.h
>>>> +++ b/drivers/accel/amdxdna/amdxdna_gem.h
>>>> @@ -19,6 +19,7 @@ struct amdxdna_umap {
>>>>        struct kref            refcnt;
>>>>        bool                invalid;
>>>>        bool                unmapped;
>>>> +    struct mutex            lock; /* protect range */
>>>>    };
>>>>    struct amdxdna_mem {
