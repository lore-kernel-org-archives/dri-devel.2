Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2AECD8CB2
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 05:39:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 537ED10E6FE;
	Wed, 10 Jun 2026 05:39:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DfPtLeOW";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010040.outbound.protection.outlook.com [52.101.56.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 064BD10E6FE
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 05:39:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ozUvjDakeL7NRiFe2MKdU7OGP8d0alXzXHLgE3pzyk/boRsl/vZIsJxFQW7k+Y4z53WEuA1HTI1np75cFA8DXgq2ONJhK7E8yNaAAney29+XLLxS/NoSCN94A4ZdMUzihJWc1C1/k0uxoz8jHDYVyNJovqB6YYOISYkAU8hVJHn7tPP6MSX+oWJl0cTLtTWCC22XOKdfxh+75Hth6MrYjF8Ssr44qbNBXUJDFkhfe1coHA2cF884gFPJpLdZqojE6b/UALxq047UkUL89ZC+w/ei6z8AfwIzharBSLMUiSlFCPNv5iXP56iKXel+g4zJpWb73+9RaCsm0SqvXJqUrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0joaAXtV7ZT10BH/RAoo7sdyA9C1nUfTWElfv/J7tHM=;
 b=vbSdZvJHflA6ynyTDy7mVHbrMYNu0Y6KEi6grrMQRHPBqGsVpsLzVC7DX+Jpt0k4FeZIkzAdxdInQm9LVYuIB6qVw6Pdpv1BDiwsESeWjBti5vJhKSxYyo+1pjw12/eTMwMSqH3Q+SvIsmyTAtovKRx+7lHPwh9af7OeD8rySGjXtIStziLM/jsYcSd2NrWTcRZSTErOP2SnjmdN+Uf5+mEdVus7JCOa0c0AuNz9t3MyP5QXLuJ0K/4ySKBO2HEVLYdDYk8DHT/w8XKo0EoCKpr0yJPSdnxqHnPZZM170hqQaFC5kSKz17PE6AvKbWl/A/zNzBqqYArxR53I1GrXmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0joaAXtV7ZT10BH/RAoo7sdyA9C1nUfTWElfv/J7tHM=;
 b=DfPtLeOWbFavMsOV/dXapwvA6UXvFwuerUYLqZDfp+l4n1f16IxkKurAolH5iS1gz3C/kXikisBvsZnvWtpmlIpJ6sAHf9l5nqc8glF1HFC9Nm4CHIoP+u61uHYpE64/Y4WmSXbck93qJMfZrstdrC8vmkH/MR769BthtJKiFqE=
Received: from MN0PR03CA0021.namprd03.prod.outlook.com (2603:10b6:208:52f::35)
 by DS0PR12MB8480.namprd12.prod.outlook.com (2603:10b6:8:159::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Wed, 10 Jun
 2026 05:39:04 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:52f:cafe::88) by MN0PR03CA0021.outlook.office365.com
 (2603:10b6:208:52f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.12 via Frontend Transport; Wed,
 10 Jun 2026 05:39:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 05:39:04 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 00:39:03 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 00:39:03 -0500
Message-ID: <fdb5c678-c615-2bdd-3957-5134f2dd75bf@amd.com>
Date: Tue, 9 Jun 2026 22:39:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3] accel/amdxdna: Fix VMA access race
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <max.zhen@amd.com>, <sonal.santan@amd.com>
References: <20260609011242.2833740-1-lizhi.hou@amd.com>
 <ca07f990-8b5b-41ca-bba9-2a07a26c6cdf@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <ca07f990-8b5b-41ca-bba9-2a07a26c6cdf@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|DS0PR12MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: 42d52461-5e82-4d70-27f5-08dec6b29562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|6133799003|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 0qfJIynXOIepB/PL3a08swph9UjpykqT4ygtWU973Iit71AsiinIW+RB3iBUVjzVgNJuSfnS+JXAAmgc2YA7SH9XoKy28MYdy4lezbdVtLE4HmW1xOF68osshlYGx4uLBxTf90J/jko1JR85f03WpmFZ2hRhY5m9yeqNDEU7AlROHpMzpWF8ScgfTJKkbBjhD/MfK02RmS1+lJ1hSR7TqRIdN/Ci1VlT5HL+BenbVPR5HqR70rdzTzYdhgpqrbq/BNPpaBOBcCpOF98MYv31foAkmsVJxpbAlJTBJ424HzHBfuBOn3ViKWRuHAanH3Yug+CfZbnnK1XeuhmzYfwv94LcBHFryxcNpof4A388B1eB+TGeegwkNpPFoj6QvOqw2JGEAHN9otG0vk6/EgZukjZOEbGeMzJKp7edHLP9U5z5yBHHYeU6T6tD7mxs+jSnle1LZIMkiNTrUI+6v7E4ubJoqy6VfgEv3SPkSOXO99usTnsJiEgoE6rYDlx+W5HVJ0lYVFIuOM6SPtQZkG/Hiity6gbuLCCzSWN0oKykwmfRPsvdfUs5eFWiFExDhbpbFWLGGsbOXCxl9vZbwpRoy41xyLlCj1W1R238NCXuxvTqpD72bYkT/2SQW71xiCJ2vj4Dpi4RIBpYeJfTDY99tW5Vg579NkO5JvJmPAmceWK9V67J2tx4c2wOlh3KTHyNWXHotE1jVPDB/ttjttTNOWN7AfRjqXbZjCCRx8YA/3s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xKr67Wm/jjXln7zyeH15rNpqjj64OTITDRfFbhpn4DHuNrPObRVSkUkmHhug0KhQipO5AL4DPJlOgq+59JNpGLFFA3NtbJQ6uIiyXDogyk3Wi8J6AY1GdLLmLR9/ru5ssb9S54rPn5Dlcs8uJNNdCDVV4vWjnKKEmZ2Lk9DVoKcRqoNSqGChTWx7mPpUjfvdh1vZ3HR+CzPKqWaSSBUycgSvqesf1X1h8Y5tH7W1mYJHyryngDNjZnYkwn17EaY25w4dhgEKWGEsIOk4sX7nd6afiCHnOjx2TFOf1RjstgPg43qNaM96mf31B4mlzIxZJIwFTonLNM2PQvOCk9oUH8bzsXrumv1+JefiuDLR2K4RADscltYw5qXFFDnl/Eh6tOasN6+Yqt3+GN3IBMbf3z+28e0I6UBSvbDkKQcN5UQIQ0Mox3/iNRGnTBGUt5n2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 05:39:04.5470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d52461-5e82-4d70-27f5-08dec6b29562
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8480
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


On 6/9/26 15:46, Mario Limonciello wrote:
>
>
> On 6/8/26 20:12, Lizhi Hou wrote:
>> aie2_populate_range() and amdxdna_umap_release() access a saved VMA
>> pointer that may have already been freed, leading to a potential
>> use-after-free.
>>
>> Remove the VMA accesses from these functions to avoid the race.
>>
>> Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>> ---
>> V3:
>>    fix sashiko comments: error-path cleanup patch race
>> V2:
>>    fix sashiko comments: Use-after-free on `mapp->vma`
>
> I'm thinking we should make sure that the other existing bugs sashiko 
> raised are fixed first

I am working on other fixes as well. And they are not related to this 
issue.

This is an use-after-free and can potentially crash the system in some 
cases. Fixing it early may also avoid receiving more AI scan reports on 
this. :)


Thanks,

Lizhi

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
