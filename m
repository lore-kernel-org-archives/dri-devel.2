Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06859CC6B38
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 16:53:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A63110E1BF;
	Thu, 15 Oct 2026 16:53:42 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010051.outbound.protection.outlook.com
 [40.93.198.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C960A112419
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 16:53:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SXHVxtgCjLNLJEjCHOMhuSQx4kfCOmtY43JqokwnWT4hwaehWKXeBysEGrpxmNjutZn5/bNgcZtE0CKWRy6oXhOHgKGiFUCfX0/qddO0qWormLglRRHBVWLRMKfyO5jZRitpyA2SzAye/FOgML2BYQI9t8M5WdYt25X+SSVEpJRAD7mgQ/kkBY8cV/k9NeDi21LZcvfIRM6+SlGwolewgVmOxpb8f8WUY3zS1SUf4M5BpmrtZ4s0lexqeO5NrVR+UraiGOK9BBl7NRRRWWfDCtuc8+JKDfgKdOWQdkelqAQwBl2+o+rsT1waDvewAQgnN4/RZ7yitCCvC0TYVPcTHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2CM+KPv1QSF67wvryma+Cgy12MkjUyfADq3WYyUN6U=;
 b=LzKCuO27QFyeLW7hzTQa/TodiUulB3NgSykrYzWGR48TGQA2s0XRYt9N0SyBW1ZQjVFsdH8Fhn5EQs0vFffHYqxpLpqZjNDbEwvYIqK8wTpv5ffkuKsjlBuRtrtohW6gSNZdRqy7XPr5Rj1DEQCon7axg1u1Uza3hg9mCImu4qOWUj3J2VbvFLGPksfbbkM4UJnWTfxEujMJt7NjKSgRiDl2YwuT7v0WDEMKTr5j9EAJEkeo38ocAtbnpy2ZJatGJ0Cv73L9EilckW4LQIJY7myLavf6rpEeVXnafu8zf3g/l+k/pPOTRYgwufMsLadFzlY3E4jJ5ZUQWWYsQyDRbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2CM+KPv1QSF67wvryma+Cgy12MkjUyfADq3WYyUN6U=;
 b=wZ/KxLXaj+7+N6DazjJAc6pBABA/zTz06TEjz5TKT4gGBPki2VJECEPVVrGaWo5HUi8HGLjRJh+WLzOKf5VCAfV08yAbGbSfduDnFAoKn4SVz5ehA+G7I8DVUdOPkFTtfXhp3bM7+b4HSVrt6JIYs/l0LtpnN6enkGO8EZqz9eo=
Received: from CH0PR03CA0107.namprd03.prod.outlook.com (2603:10b6:610:cd::22)
 by LV8PR12MB9229.namprd12.prod.outlook.com (2603:10b6:408:191::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 16:53:27 +0000
Received: from BN6PEPF0000006F.namprd03.prod.outlook.com
 (2603:10b6:610:cd:cafe::9) by CH0PR03CA0107.outlook.office365.com
 (2603:10b6:610:cd::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 16:53:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN6PEPF0000006F.mail.protection.outlook.com (10.167.248.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 16:53:27 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 11:53:20 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 15 Oct 2026 11:53:20 -0500
Message-ID: <5b6115a9-e316-f697-0106-17f297eb4b55@amd.com>
Date: Thu, 15 Oct 2026 09:53:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V4 14/19] accel/amdxdna: Move HMM invalidate wait into
 common GEM code
Content-Language: en-US
From: Lizhi Hou <lizhi.hou@amd.com>
To: David Zhang <yidong.zhang@amd.com>, <quic_jhugo@quicinc.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <sonal.santan@amd.com>, <mario.limonciello@amd.com>, Hayden Laccabue
 <Hayden.Laccabue@amd.com>
References: <yidong.zhang@amd.com>
 <20261009225343.3079074-1-yidong.zhang@amd.com>
 <20261009225343.3079074-15-yidong.zhang@amd.com>
 <ccabdb48-f7a6-d6ce-d148-b4e2827aec17@amd.com>
In-Reply-To: <ccabdb48-f7a6-d6ce-d148-b4e2827aec17@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PEPF0000006F:EE_|LV8PR12MB9229:EE_
X-MS-Office365-Filtering-Correlation-Id: b444a3c2-d581-417f-2e72-08df2adcd586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|56012099006|11063799006|4143699003|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: LVThJtlHfGS2Nf+WepGAsQb0avYDyHvaWcafKj3rdY0qKTToL4dI6mQX8pDog2z7V3AWmLxbzGw7gq7OV1g+fPq9qZH5rZbYTILBij67gvh6obZkGl98UViXHu2aY1pTwBYlEkyUKdArXqIm+QhFIDKyiVIbtW5bsse36RC6eu4iDC3f6OE0IPqkcZwRtYyT9BiCQ8uAkaPn4Z4BrUe3mu79Mc/z7iyQwcltV5UM7vZaU2iK9qXSgWQPi2sketdn3/d2l+M4z9TtoP0j7/aIj6sLfQQ8aMyO4b+4hBgZhigyUsJDiIpXv42Pg/90NkIrcdP3aU26xQX9UusA1hLuG2EWjMS6N2jB2V0G8KWGpciP0g9Kd2RcY96HNHkrTYjgEbrhdT8ZmURwM5n2N5K+mYFSUjT4M61Rx+5/mmp629uTrCYfMKTaPe4j+g3S7mMjI0k9kj2DbSrZp8mE/GhrH1KHGm5so6G9O4Gt8s93mPwdImDefcdEXnlTh2p3YuvSOII4doQedEEsi/f9ozhfyjweCl5b+Fw2PDnqALUCgDMwM6J5KtuwUSgmBdEvnCnn71UF9JzYCr6U5q9OCcmYTCAtaomn+oegyWVc168Fk80pR/7az3sEEYUNrL4PNObdsm9MscIpjL0/g5OvEXcFCXEv6nfZ/9vthsDVkQImx9Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: b3rq/GH4rmFesBXI57lLMdvqs79OATKGBQwSKocB/EIFWnCF46pmHY1tw9SeF1b+u7tw4PL+ZbplxxwnpwC9EM14CrTKtWYkltS605fcQTJnOVieD0UALvRd5av8qkh4h0S1Vqhxw2cGkxoP5cLABPNldUXskowz7kUZY5xh4IqLMlo3/tPkEYWWtFOfr+brqAO4HQiWnJIGbNJRzbkzaQIzlcAuory9u/7LyDnta1arr3hYUROX40NNKfGG7AgrmX5vhFAyY5aGey2gv00W/yDbYOz38LIxvGm7guJdG0mV25LKBIiBOqEjmxuvJZe6HMrDiyp2UbA7vS/xSXOpY6u2akP34rFX+RI3Bsscvhij2bsaDklaw6LDIyWzPtm4GCyzthV+oR41LBbCsGtKSFO8Fp0QqRl4nnFaBilsQdyssNRhc3bkCcKb2snux3bb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 16:53:27.2965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b444a3c2-d581-417f-2e72-08df2adcd586
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN6PEPF0000006F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9229
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


On 10/13/26 11:45, Lizhi Hou wrote:
>
> On 10/9/26 15:53, David Zhang wrote:
>> When a user mapping of a BO is invalidated, the driver must wait for
>> the BO's reservation fences before the pages are released. AIE2 does
>> this in aie2_hmm_invalidate() through the .hmm_invalidate callback,
>> and AIE4 needs the same wait.
>>
>> Do the wait directly in amdxdna_hmm_invalidate() in amdxdna_gem.c and
>> remove the .hmm_invalidate callback and aie2_hmm_invalidate(). Devices
>> that do not attach fences to user BOs return from the wait at once.
>>
>> Make the wait uninterruptible. With an interruptible wait, a pending
>> signal, such as SIGKILL during process exit, ends the wait early and
>> the pages can be freed while the NPU may still access them.
>
> This is a bug fix. Please add "Fixes" tag and change the title to 
> reflect the fix.

It is actually better to separate the bug fix and the movement to common 
code.

I would take the fix:

https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commit/dfa1a332824421f1713388a86331a4c4d84f680f

Then moving to common code on top.

Thanks,

Lizhi

>
> Lizhi
>
>>
>> Co-developed-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
>> Signed-off-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
>> Signed-off-by: David Zhang <yidong.zhang@amd.com>
>> ---
>>   drivers/accel/amdxdna/aie2_ctx.c        | 15 ---------------
>>   drivers/accel/amdxdna/aie2_pci.c        |  1 -
>>   drivers/accel/amdxdna/aie2_pci.h        |  1 -
>>   drivers/accel/amdxdna/amdxdna_gem.c     | 14 ++++++++++++--
>>   drivers/accel/amdxdna/amdxdna_pci_drv.h |  1 -
>>   5 files changed, 12 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/aie2_ctx.c 
>> b/drivers/accel/amdxdna/aie2_ctx.c
>> index d927c8c9d557..8c1b29964f8f 100644
>> --- a/drivers/accel/amdxdna/aie2_ctx.c
>> +++ b/drivers/accel/amdxdna/aie2_ctx.c
>> @@ -1277,21 +1277,6 @@ int aie2_cmd_submit(struct amdxdna_hwctx 
>> *hwctx, struct amdxdna_sched_job *job,
>>       return ret;
>>   }
>>   -void aie2_hmm_invalidate(struct amdxdna_gem_obj *abo,
>> -             unsigned long cur_seq)
>> -{
>> -    struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
>> -    struct drm_gem_object *gobj = to_gobj(abo);
>> -    long ret;
>> -
>> -    ret = dma_resv_wait_timeout(gobj->resv, DMA_RESV_USAGE_BOOKKEEP,
>> -                    true, MAX_SCHEDULE_TIMEOUT);
>> -    if (!ret)
>> -        XDNA_ERR(xdna, "Failed to wait for bo, ret %ld", ret);
>> -    else if (ret == -ERESTARTSYS)
>> -        XDNA_DBG(xdna, "Wait for bo interrupted by signal");
>> -}
>> -
>>   int aie2_hwctx_heap_expand(struct amdxdna_hwctx *hwctx,
>>                  struct amdxdna_gem_obj *heap)
>>   {
>> diff --git a/drivers/accel/amdxdna/aie2_pci.c 
>> b/drivers/accel/amdxdna/aie2_pci.c
>> index 1b029d33a24b..690ad035463c 100644
>> --- a/drivers/accel/amdxdna/aie2_pci.c
>> +++ b/drivers/accel/amdxdna/aie2_pci.c
>> @@ -1228,7 +1228,6 @@ const struct amdxdna_dev_ops aie2_ops = {
>>       .hwctx_config = aie2_hwctx_config,
>>       .hwctx_sync_debug_bo = aie2_hwctx_sync_debug_bo,
>>       .cmd_submit = aie2_cmd_submit,
>> -    .hmm_invalidate = aie2_hmm_invalidate,
>>       .get_array = aie2_get_array,
>>       .get_dev_revision = aie2_get_dev_rev,
>>       .hwctx_heap_expand = aie2_hwctx_heap_expand,
>> diff --git a/drivers/accel/amdxdna/aie2_pci.h 
>> b/drivers/accel/amdxdna/aie2_pci.h
>> index 709e7545c65f..13391275df31 100644
>> --- a/drivers/accel/amdxdna/aie2_pci.h
>> +++ b/drivers/accel/amdxdna/aie2_pci.h
>> @@ -272,7 +272,6 @@ int aie2_hwctx_sync_debug_bo(struct amdxdna_hwctx 
>> *hwctx, u32 debug_bo_hdl);
>>   void aie2_hwctx_suspend(struct amdxdna_client *client);
>>   int aie2_hwctx_resume(struct amdxdna_client *client);
>>   int aie2_cmd_submit(struct amdxdna_hwctx *hwctx, struct 
>> amdxdna_sched_job *job, u64 *seq);
>> -void aie2_hmm_invalidate(struct amdxdna_gem_obj *abo, unsigned long 
>> cur_seq);
>>   int aie2_hwctx_heap_expand(struct amdxdna_hwctx *hwctx, struct 
>> amdxdna_gem_obj *heap);
>>     #endif /* _AIE2_PCI_H_ */
>> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c 
>> b/drivers/accel/amdxdna/amdxdna_gem.c
>> index f4832337ec31..e1b72cef51bd 100644
>> --- a/drivers/accel/amdxdna/amdxdna_gem.c
>> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
>> @@ -12,6 +12,7 @@
>>   #include <drm/gpu_scheduler.h>
>>   #include <linux/dma-buf.h>
>>   #include <linux/dma-direct.h>
>> +#include <linux/dma-resv.h>
>>   #include <linux/iosys-map.h>
>>   #include <linux/pagemap.h>
>>   #include <linux/swap.h>
>> @@ -232,6 +233,7 @@ static bool amdxdna_hmm_invalidate(struct 
>> mmu_interval_notifier *mni,
>>       struct amdxdna_umap *mapp = container_of(mni, struct 
>> amdxdna_umap, notifier);
>>       struct amdxdna_gem_obj *abo = mapp->abo;
>>       struct amdxdna_dev *xdna;
>> +    long ret;
>>         if (!mmu_notifier_range_blockable(range))
>>           return false;
>> @@ -249,8 +251,16 @@ static bool amdxdna_hmm_invalidate(struct 
>> mmu_interval_notifier *mni,
>>       mmu_interval_set_seq(&mapp->notifier, cur_seq);
>>       up_write(&xdna->notifier_lock);
>>   -    if (xdna->dev_info->ops->hmm_invalidate)
>> -        xdna->dev_info->ops->hmm_invalidate(abo, cur_seq);
>> +    /*
>> +     * Wait uninterruptibly. Returning early on a signal would let the
>> +     * pages be freed while the NPU may still access them. This relies
>> +     * on job fences signaling in finite time; job timeout detection
>> +     * and recovery (TDR) for AIE4 will be added in a separate change.
>> +     */
>> +    ret = dma_resv_wait_timeout(to_gobj(abo)->resv, 
>> DMA_RESV_USAGE_BOOKKEEP,
>> +                    false, MAX_SCHEDULE_TIMEOUT);
>> +    if (!ret)
>> +        XDNA_ERR(xdna, "Failed to wait for bo, ret %ld", ret);
>>         if (range->event == MMU_NOTIFY_UNMAP) {
>>           down_write(&xdna->notifier_lock);
>> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h 
>> b/drivers/accel/amdxdna/amdxdna_pci_drv.h
>> index 11f46ec738d7..2a1d6b33363c 100644
>> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
>> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
>> @@ -63,7 +63,6 @@ struct amdxdna_dev_ops {
>>       int (*hwctx_config)(struct amdxdna_hwctx *hwctx, u32 type, u64 
>> value, void *buf, u32 size);
>>       int (*hwctx_sync_debug_bo)(struct amdxdna_hwctx *hwctx, u32 
>> debug_bo_hdl);
>>       int (*hwctx_heap_expand)(struct amdxdna_hwctx *hwctx, struct 
>> amdxdna_gem_obj *heap);
>> -    void (*hmm_invalidate)(struct amdxdna_gem_obj *abo, unsigned 
>> long cur_seq);
>>       int (*cmd_submit)(struct amdxdna_hwctx *hwctx, struct 
>> amdxdna_sched_job *job, u64 *seq);
>>       int (*cmd_wait)(struct amdxdna_hwctx *hwctx, u64 seq, u32 
>> timeout);
>>       int (*get_aie_info)(struct amdxdna_client *client, struct 
>> amdxdna_drm_get_info *args);
