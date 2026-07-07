Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F6CC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 05:46:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8C1C10E42A;
	Tue,  7 Jul 2026 05:46:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uZf39U8R";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010034.outbound.protection.outlook.com [52.101.46.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 862F010E42A
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 05:46:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bj3DNfPHsDV8MAmPzJ2j9kpxsFb3AEKxp8rnafqy/3g44NeYIIOQt7E5svhW6O2CAKkvFELkAXRIHcaOa5j4hYfJ7ubzTckseNLS1oTzIL6dTkDv1sRJ+BgcZ5wa50KEMYA1MAYT8MIEXr1LwiyzZwOQXcP8Eb3ECJPIf2tWvVZ/ormFXnPzOVDk9J6t2AUy91MrkOjI/ZkY8sYTKjSegP1XqOuvZdgMfW+3+DnstKRj5RM1RMzdB/3nZYZCIS8gCkdaIRjzO7xUT678lYPNPshMxnnvr6mIz62QxSQHb3BogjMLOe05KWfOHwKfTZ8zK30fg3IG+TSJPRw5eCRozA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXi4N6k2dP4fkCG5y6UCJernvRJDlPJ6Yk8lMiRm+wE=;
 b=dyxQQkqSwZRHD1YaCotdvVHAA7gT4keSxZkaJVbRw5ozSCNdjEWyFKpJoYJPmhY2nB6/oXzBDKzrcJdvPzHMG4226H/TFXfIPTSSh5uZy2Yhh1APDhuX9kbePmQD70d/ByrohSQnFhv+NpdnUyTikVaIY6nTg2SQyMedUtDC1zX8ATqcjIsc19If35T8JYyT/Z5SHS83kPcQcgykW/sXwJ9uv91aqOhPpybjsv8FGxZWuGUYVzLIWCYzUapFcTYpEGyWr1ohsKxszJLE/WX7glv/5fwSSRvRDZ4d1TK6vyYoECa9oymVfQJIHfVw5njcb/F1oVLYEXVYDpYiqR5DKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXi4N6k2dP4fkCG5y6UCJernvRJDlPJ6Yk8lMiRm+wE=;
 b=uZf39U8RAqUwSCrm1JHwLwfXb8t+TprO4/zZVLIor3h7wjlR3hh7AYoeEs80+VlF6LnHHdNMmmZxoEZOWJ1mGqfubbKxFvELuatewYPDuR44PYVjK/eoWmY4rnJumA7W0ILwd3642QvuhsJ61vMvSfkDrWxHnGVfjGPB9saVs4s=
Received: from MN2PR07CA0004.namprd07.prod.outlook.com (2603:10b6:208:1a0::14)
 by DM4PR12MB5962.namprd12.prod.outlook.com (2603:10b6:8:69::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.10; Tue, 7 Jul 2026 05:46:39 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:1a0:cafe::1b) by MN2PR07CA0004.outlook.office365.com
 (2603:10b6:208:1a0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 7
 Jul 2026 05:46:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 05:46:38 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 00:46:38 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 00:46:38 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 00:46:37 -0500
Message-ID: <a0f776a2-952f-7308-3575-6f8d0eba8f2c@amd.com>
Date: Mon, 6 Jul 2026 22:46:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3] accel/amdxdna: Fix VMA access race
Content-Language: en-US
To: Max Zhen <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20260609011242.2833740-1-lizhi.hou@amd.com>
 <6d4b8db5-0212-4af7-9a2a-e8ed73ccdf03@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <6d4b8db5-0212-4af7-9a2a-e8ed73ccdf03@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|DM4PR12MB5962:EE_
X-MS-Office365-Filtering-Correlation-Id: 07e19f7d-0a57-488d-565f-08dedbeb1d57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|18002099003|22082099003|4143699003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: G9o+7LH6Rbruw688Q907Dj/5GSY9KMHunt6pwSAgdb1be54b2ReF8VpFecB63K6oQZ1W/if/fDLxsndqvfXe4zl+CVQnq/sRvyXsGzHJ6UArHxZ6hNfovTg4tfUYrpZUyMNm3ntEsW/1KBGu8soMCWcNQ9vY/FnTSuC6aCUJ262L1RzaJ3pyb2ImpXM0pUBb1UqAo2zh86uf426PU1INPuLvuSHvK48mJ+sWMk3JnTTh3sQRtxnyLK9GWYrRv803m76PvMGl3k+on/jTbveDlRQ8/JOQXYi3hHRXZ9dcBPNmICFsnTBzEddvBToIIHMNdafF5QpLuE/7s+CinjayFmNdaSJWIZDf786IHtFKibSN4jOjwqFLby3aAuXCRyAdeSjAlq0gkL5IYLgOEDkmKrSPh/Fc3z5e5LSJCwX0gxldUXj7vNT2zG8bmdyDRlbK0/ileqI9OEXhMN2dLanU14C9wbxQg/XHaFK7jDA+QSC1MFQhVjcGjcVhMB588TvEASk8z+JbyS82g4w1TZ65oF6zMdgKY8Md0F2wLcmOCMn2WOsQjG4nhr2rhC8ZldE8KYTvLGBxz8DtzELtOckNEf4KkqPTk7DEWz5r02KO5n5Z+YZvXslCMUwed57REHVKZrUQaEqxkXErQXel/XjWId+1/cNmYu/u9sgUC9A0J5H1fjMZUSa9ytzZ+tdubKqCME8ZPPEncz3SwGHz6te6Jg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NsmgM9nMQQ/M2PsQOU93jnscNxXgvGzoscRUbq5jwI1v+k2H8uEPYm4KPmtmwsCmTbllm2k+MbZLNIagv3gHHS+v/NR7ikrK26NWG8B0zy7Alfx1gx52g0+Sdc7s38QqFzSmTSCNLrCkTN4QbxILD/mFmqPGFT/w+WiIrvt6dxNu0FM5OguL01w+cAmxKaw0T1etSnPb0P66Z+u2/S+KCMJ1MF8yr2jV9HQylIHEU4cMcHjRWSJj1mblhjMuLPH2TLZRqmW1LDuW3wwYrcowcREKqsUkIl6HeFitN12xaZcoEe+GFQX0+BuarcH0zJXBgSgAq/y5Q7cgGK2B3H4JRuEtdfCDG7t6L9mTrUiCiKxHxNO4wqRzW/Jy5HlZHFHRaVDLqnKuaqfbr9UwdU3ZDDhQuei5m1AreFg7QA8jO4Y/z58UMW7Bcypq6JEm2QYs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 05:46:38.8822 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e19f7d-0a57-488d-565f-08dedbeb1d57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5962
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

Applied to drm-misc-fixes

On 7/6/26 15:40, Max Zhen wrote:
>
>
> On 6/8/2026 Mon 18:12, Lizhi Hou wrote:
>> aie2_populate_range() and amdxdna_umap_release() access a saved VMA
>> pointer that may have already been freed, leading to a potential
>> use-after-free.
>>
>> Remove the VMA accesses from these functions to avoid the race.
>>
>> Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviewed-by: Max Zhen <max.zhen@amd.com>
>> ---
>> V3:
>>    fix sashiko comments: error-path cleanup patch race
>> V2:
>>    fix sashiko comments: Use-after-free on `mapp->vma`
>>
>>   drivers/accel/amdxdna/aie2_ctx.c    |  2 --
>>   drivers/accel/amdxdna/amdxdna_gem.c | 31 +++++++++++++++++++----------
>>   drivers/accel/amdxdna/amdxdna_gem.h |  1 -
>>   3 files changed, 21 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/aie2_ctx.c 
>> b/drivers/accel/amdxdna/aie2_ctx.c
>> index da89b3701f5b..3e21e2dabe82 100644
>> --- a/drivers/accel/amdxdna/aie2_ctx.c
>> +++ b/drivers/accel/amdxdna/aie2_ctx.c
>> @@ -1023,8 +1023,6 @@ static int aie2_populate_range(struct 
>> amdxdna_gem_obj *abo)
>>       kref_get(&mapp->refcnt);
>>       up_write(&xdna->notifier_lock);
>>   -    XDNA_DBG(xdna, "populate memory range %lx %lx",
>> -         mapp->vma->vm_start, mapp->vma->vm_end);
>>       mm = mapp->notifier.mm;
>>       if (!mmget_not_zero(mm)) {
>>           amdxdna_umap_put(mapp);
>> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c 
>> b/drivers/accel/amdxdna/amdxdna_gem.c
>> index 63976c3bcbe0..20ce304b19ef 100644
>> --- a/drivers/accel/amdxdna/amdxdna_gem.c
>> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
>> @@ -254,7 +254,7 @@ static bool amdxdna_hmm_invalidate(struct 
>> mmu_interval_notifier *mni,
>>         xdna = to_xdna_dev(to_gobj(abo)->dev);
>>       XDNA_DBG(xdna, "Invalidating range 0x%lx, 0x%lx, type %d",
>> -         mapp->vma->vm_start, mapp->vma->vm_end, abo->type);
>> +         mapp->range.start, mapp->range.end, abo->type);
>>         if (!mmu_notifier_range_blockable(range))
>>           return false;
>> @@ -284,15 +284,23 @@ static const struct mmu_interval_notifier_ops 
>> amdxdna_hmm_ops = {
>>       .invalidate = amdxdna_hmm_invalidate,
>>   };
>>   +static inline bool compare_range(struct amdxdna_umap *mapp,
>> +                 struct mm_struct *mm,
>> +                 unsigned long start, unsigned long end)
>> +{
>> +    return (!mapp->unmapped && mapp->notifier.mm == mm &&
>> +        mapp->range.start == start && mapp->range.end == end);
>> +}
>> +
>>   static void amdxdna_hmm_unregister(struct amdxdna_gem_obj *abo,
>>                      struct vm_area_struct *vma)
>>   {
>>       struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
>>       struct amdxdna_umap *mapp;
>>   -    down_read(&xdna->notifier_lock);
>> +    down_write(&xdna->notifier_lock);
>>       list_for_each_entry(mapp, &abo->mem.umap_list, node) {
>> -        if (!vma || mapp->vma == vma) {
>> +        if (!vma || compare_range(mapp, vma->vm_mm, vma->vm_start, 
>> vma->vm_end)) {
>>               if (!mapp->unmapped) {
>>                   queue_work(xdna->notifier_wq, &mapp->hmm_unreg_work);
>>                   mapp->unmapped = true;
>> @@ -301,19 +309,16 @@ static void amdxdna_hmm_unregister(struct 
>> amdxdna_gem_obj *abo,
>>                   break;
>>           }
>>       }
>> -    up_read(&xdna->notifier_lock);
>> +    up_write(&xdna->notifier_lock);
>>   }
>>     static void amdxdna_umap_release(struct kref *ref)
>>   {
>>       struct amdxdna_umap *mapp = container_of(ref, struct 
>> amdxdna_umap, refcnt);
>>       struct amdxdna_gem_obj *abo = mapp->abo;
>> -    struct vm_area_struct *vma = mapp->vma;
>>       struct amdxdna_dev *xdna;
>>         mmu_interval_notifier_remove(&mapp->notifier);
>> -    if (is_import_bo(abo) && vma->vm_file && vma->vm_file->f_mapping)
>> - mapping_clear_unevictable(vma->vm_file->f_mapping);
>>         xdna = to_xdna_dev(to_gobj(mapp->abo)->dev);
>>       down_write(&xdna->notifier_lock);
>> @@ -355,6 +360,15 @@ static int amdxdna_hmm_register(struct 
>> amdxdna_gem_obj *abo,
>>           return 0;
>>       }
>>   +    down_read(&xdna->notifier_lock);
>> +    list_for_each_entry(mapp, &abo->mem.umap_list, node) {
>> +        if (compare_range(mapp, current->mm, addr, addr + len)) {
>> +            up_read(&xdna->notifier_lock);
>> +            return 0;
>> +        }
>> +    }
>> +    up_read(&xdna->notifier_lock);
>> +
>>       mapp = kzalloc_obj(*mapp);
>>       if (!mapp)
>>           return -ENOMEM;
>> @@ -380,13 +394,10 @@ static int amdxdna_hmm_register(struct 
>> amdxdna_gem_obj *abo,
>>       mapp->range.start = vma->vm_start;
>>       mapp->range.end = vma->vm_end;
>>       mapp->range.default_flags = HMM_PFN_REQ_FAULT;
>> -    mapp->vma = vma;
>>       mapp->abo = abo;
>>       kref_init(&mapp->refcnt);
>>         INIT_WORK(&mapp->hmm_unreg_work, amdxdna_hmm_unreg_work);
>> -    if (is_import_bo(abo) && vma->vm_file && vma->vm_file->f_mapping)
>> -        mapping_set_unevictable(vma->vm_file->f_mapping);
>>         down_write(&xdna->notifier_lock);
>>       if (list_empty(&abo->mem.umap_list))
>> diff --git a/drivers/accel/amdxdna/amdxdna_gem.h 
>> b/drivers/accel/amdxdna/amdxdna_gem.h
>> index a3e44c7a2395..a35d2f15d32c 100644
>> --- a/drivers/accel/amdxdna/amdxdna_gem.h
>> +++ b/drivers/accel/amdxdna/amdxdna_gem.h
>> @@ -12,7 +12,6 @@
>>   #include "amdxdna_pci_drv.h"
>>     struct amdxdna_umap {
>> -    struct vm_area_struct        *vma;
>>       struct mmu_interval_notifier    notifier;
>>       struct hmm_range        range;
>>       struct work_struct        hmm_unreg_work;
>
