Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F24210F92E0
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 16:30:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6800D10EA87;
	Tue, 31 Mar 2026 16:30:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UQUPRkqx";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012050.outbound.protection.outlook.com [52.101.43.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EEBE10EC39
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 16:30:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1tgkjjM4yU2wezoKfR+oDjcg5GPID0MUMt7nMUFsHeRb8XckwCCWptm2MEfdrYHUtPgwDVV9Yz8XXJfmYNo0V06AvKFXSPb1ZBPMHFV146oxGgY5RSQhVz5rQYAKHb8nofHJ6xcDQdNsd3JiUWHMyMAWZdcss6C6/dnGDZ585RgXpYMinDXVR8jbp2ZJXJU3Fe68Y1s3VSeoI7s2kY1xnrucXFKTYxqhpFml2EVpMtxag35GFjOEqoMcEsykah4m0ndvkWh7sbJkpcXxUbKEQm/FzjjTMaJmcEGtwgnjBDAasJtDZqxsUOUCkuMz2ve1CNswtOtI2jEv8XP18S4Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsFjoCZHaSkSjm4Cj33eNgNcZTmSctHMksP4e3V5vaE=;
 b=dSEbdYYapx4rD34Lsf2LIIcFaDFSz1legnXRph1rPvnheTMMrD8mEL6Eax0iDHMIHPWBbB5RS5IBkHN9pj7OkRKvKCXWq42uXBqdnb8AVMoJsfDuCiIwKownwQfOTgz+udrGZsbs0D6iPnenvzEd/Fb8DYchquhZ1OOoOCHvd+KthBIfeUO6CGDz1BevNyXdFgayGVVQjOym7lsNdLvxc/ljPIoWCNYzLFh9ZgdehT7C/THh9GxeLnbIc6YGWVOSCgeBdHNgnByAAXegUqutUNoRTFL6Ajt1iPT4yH/aOuck7t31A2+8HzGse6ItCyR3FGewsgfUUIjLml2Z5uRMGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsFjoCZHaSkSjm4Cj33eNgNcZTmSctHMksP4e3V5vaE=;
 b=UQUPRkqxi45Xd+jE7qHDENGQz7KUBNl3LbAZurAlfYLUDgP6I7BIKJjKL4OIhdXqswtOYPQP6OyFaeNqlJKQhJAzG8h3ecuRf/yZELLFYPtokN6tEnEh+LZ9Qks6OGGObQhhZLj4HM04KND0GlsmYYSy5DtoldZ1wu4QxVzIbnU=
Received: from SJ0PR03CA0007.namprd03.prod.outlook.com (2603:10b6:a03:33a::12)
 by DS5PPF4ACC15C0E.namprd12.prod.outlook.com (2603:10b6:f:fc00::64c)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Tue, 31 Mar
 2026 16:29:56 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::86) by SJ0PR03CA0007.outlook.office365.com
 (2603:10b6:a03:33a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.29 via Frontend Transport; Tue,
 31 Mar 2026 16:29:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 31 Mar 2026 16:29:53 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 31 Mar
 2026 11:29:51 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 31 Mar 2026 11:29:51 -0500
Message-ID: <1f3a273f-ba47-08b2-92d4-b2d656241669@amd.com>
Date: Tue, 31 Mar 2026 09:29:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Support read-only user-pointer BO
 mappings
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <maciej.falkowski@linux.intel.com>
CC: Max Zhen <max.zhen@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>
References: <20260326162759.2674547-1-lizhi.hou@amd.com>
 <a4886d87-b359-4bf8-ae2c-02e17664bd8e@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <a4886d87-b359-4bf8-ae2c-02e17664bd8e@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|DS5PPF4ACC15C0E:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf3cd00-7890-42ed-3041-08de8f42bd37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: YMPKA9uuVosSwuQENz5KSHhhn2yMjUXOSRMWJk9psmoaYwmPT8Q6GwCcOnoXx1UVVQdYsbc8teMfzvRxO74kUOySH+8U1ZihYCIHltHYGaBRJDfo//6RU/pDDWliO8uJ4mgF5iZNY7miCxk4lXYqKb40asKrHB0CHsvpoExgNuXmC+0pQdbnWnnQNPXuc44PduDhcI99URaDzM8w7i/rJ9b/rTNVe0n8Bv8+a+8Zlq9bGleqELTPxuqeIfk8VHCOJyqY+UyoAKx3wxsf9cz6k3UL5oJfkJDl0Uzbw4JmWUFctr7aSqfRuA49p9SH4NANjTUPSlddXFDxtCXaT1RLuf2Z7aFwJAEFgtzUdKj4UlAyrrMqNikMhysgC/jSI7e92Grc7GmaYj61lH8Wc0MJhqx13XIHLzsEgt/TQ9knjTu7/Go2sIPdiyEsmrFNZp19zTOBPC3rp36Ijjq54o2IVaTeMHQuF6TBWrLsZnQIYsxOBkGWRmp7yG3ZRujUTrLLjarK/QR7I08wqCdIUsn/QRY/yHF5dbMPRn9/Dod4lMBqU0jy+t3O8rLVPyy9Sf9S+z8WtXebGz95cC1Ie86en1F1FXvcXP0rK4rMlBjq/1xyRvO/JuF44hIKqUx6mluC5bMGHDB2TRyeP/46ZnQvJInxs9gHgmWfgqes0tnZ+3oaFlI6q0U+AEPQzb5/u4x3qk5s5y+aLMMZwxXAw0GYYFi3VzSbeOqUkrySEqSKnmYycj/VcUF7EItHnf6L043tfE9Zx6PxnqylrM+EFHlSJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Qm4PntPzmPHB0YIZJXjfnXMIw0uzuxDxYmn+4uRPycSRPcOxisqPD9GiTnBcttIeua2E51GtBCjyxRnzrdw1pgyQLgnl42xPFaiAHwg57rmJqErmPkh7ZBOuLxf9NKWBVQQEiEP+YQv9PZvSp+j8gtmYthMaVSGlVjoqyo+T71xO8foushM5GuVwgSdRHTd/JYgawvUCChyHEb6xXiaMa1W/8T/op0GH66qyAaRZdcId7nJbyhgeWtTPyKRX4plLGsE/14v3lqz8ZqsC5l4JjDY6pCtnFU+6IjauolAi7YzzGRM9kJYa6k4P49CZqTNasZrbzni383EvFVlKV45ZYvdz9DO45bx9j9cDoZ4r8BJ+fVu0/OmHSPZXPZ4B+Vm/7GI7puVDtpfiYYlZB4QZ/5ISTotMgp6mPOFwK4HxuZvek973PdkfCTh2/vX3bUFQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 16:29:53.6977 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf3cd00-7890-42ed-3041-08de8f42bd37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF4ACC15C0E
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


On 3/31/26 09:13, Mario Limonciello wrote:
>
>
> On 3/26/26 11:27, Lizhi Hou wrote:
>> From: Max Zhen <max.zhen@amd.com>
>>
>> Update the amdxdna user-pointer (ubuf) BO path to support creating 
>> buffer
>> objects from read-only user mappings.
>>
>> Detect read-only VMAs by checking VMA permissions across all user 
>> virtual
>> address ranges associated with the BO. When all entries are 
>> read-only, pin
>> user pages without FOLL_WRITE and export the resulting dmabuf as 
>> read-only
>> (O_RDONLY).
>>
>> This allows userptr BOs backed by read-only mappings to be safely 
>> imported
>> and used without requiring write access, which was previously 
>> rejected due
>> to unconditional FOLL_WRITE usage.
>>
>> Signed-off-by: Max Zhen <max.zhen@amd.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>> ---
>>   drivers/accel/amdxdna/amdxdna_ubuf.c | 30 ++++++++++++++++++++++++++--
>>   1 file changed, 28 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c 
>> b/drivers/accel/amdxdna/amdxdna_ubuf.c
>> index 4c0647057759..1a0e2a274170 100644
>> --- a/drivers/accel/amdxdna/amdxdna_ubuf.c
>> +++ b/drivers/accel/amdxdna/amdxdna_ubuf.c
>> @@ -125,6 +125,27 @@ static const struct dma_buf_ops 
>> amdxdna_ubuf_dmabuf_ops = {
>>       .vunmap = amdxdna_ubuf_vunmap,
>>   };
>>   +static int readonly_va_entry(struct amdxdna_drm_va_entry *va_ent)
>> +{
>> +    struct mm_struct *mm = current->mm;
>> +    struct vm_area_struct *vma;
>> +    int ret;
>> +
>> +    mmap_read_lock(mm);
>> +
>> +    vma = find_vma(mm, va_ent->vaddr);
>> +    if (!vma ||
>> +        vma->vm_start > va_ent->vaddr ||
>> +        vma->vm_end < va_ent->vaddr ||
>> +        vma->vm_end - va_ent->vaddr < va_ent->len)
>> +        ret = -ENOENT;
>
> The check on line "vma->vm_end < va_ent->vaddr" appears to be 
> unreachable.
> find_vma() is documented to return the first VMA where vma->vm_end > 
> addr, so
> if vma is non-NULL, this condition can never be true.
Sure. I will remove it.
>
>> +    else
>> +        ret = vma->vm_flags & VM_WRITE ? 0 : 1;
>> +
>> +    mmap_read_unlock(mm);
>> +    return ret;
>> +}
>> +
>>   struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>>                    u32 num_entries, void __user *va_entries)
>>   {
>> @@ -134,6 +155,7 @@ struct dma_buf *amdxdna_get_ubuf(struct 
>> drm_device *dev,
>>       struct amdxdna_ubuf_priv *ubuf;
>>       u32 npages, start = 0;
>>       struct dma_buf *dbuf;
>> +    bool readonly = true;
>>       int i, ret;
>>       DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
>>   @@ -172,6 +194,10 @@ struct dma_buf *amdxdna_get_ubuf(struct 
>> drm_device *dev,
>>               ret = -EINVAL;
>>               goto free_ent;
>>           }
>> +
>> +        /* Pin pages as writable as long as not all entries are 
>> read-only. */
>> +        if (readonly && readonly_va_entry(&va_ent[i]) != 1)
>> +            readonly = false;
>>       }
>
> The check "!= 1" treats errors the same as writable VMAs. 
> readonly_va_entry()
> returns -ENOENT for errors, 0 for writable, and 1 for read-only.
>
> Extra error handling maybe needed?

The idea is to specifically handle the readonly_va_entry() == 1 case. 
For -ENOENT and 0, it fallbacks to writeable and the error handling will 
be done by checking pin_user_pages_fast() return value.


Lizhi

>
>>         ubuf->nr_pages = exp_info.size >> PAGE_SHIFT;
>> @@ -194,7 +220,7 @@ struct dma_buf *amdxdna_get_ubuf(struct 
>> drm_device *dev,
>>           npages = va_ent[i].len >> PAGE_SHIFT;
>>             ret = pin_user_pages_fast(va_ent[i].vaddr, npages,
>> -                      FOLL_WRITE | FOLL_LONGTERM,
>> +                      (readonly ? 0 : FOLL_WRITE) | FOLL_LONGTERM,
>>                         &ubuf->pages[start]);
>>           if (ret >= 0) {
>>               start += ret;
>> @@ -211,7 +237,7 @@ struct dma_buf *amdxdna_get_ubuf(struct 
>> drm_device *dev,
>>         exp_info.ops = &amdxdna_ubuf_dmabuf_ops;
>>       exp_info.priv = ubuf;
>> -    exp_info.flags = O_RDWR | O_CLOEXEC;
>> +    exp_info.flags = (readonly ? O_RDONLY : O_RDWR) | O_CLOEXEC;
>>         dbuf = dma_buf_export(&exp_info);
>>       if (IS_ERR(dbuf)) {
>
