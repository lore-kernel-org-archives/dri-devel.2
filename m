Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16DF5C88E45
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:25:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C22010F681;
	Fri, 11 Sep 2026 15:25:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sBFTPOjr";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011044.outbound.protection.outlook.com [52.101.57.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BBDE10F681
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:25:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pdCydAkM9E2R+HQ5QF7ZcCUUBn2epd65FU5Ya/7/aLbr63j9R2FjEqHYX5qhbgluTYuv01ZyZ/eNgV99xmGD5gRPuo0sghV9Wf1iilYxWWMbJUeEOt2OAEB4PAVBxPVh5/P2o+W8mwVVUz+8RblOulGNeGzXC4PJLTBCm9/k5XyonjA/tf9C9WVG7PJKCSeXSNFevqn9jZE2OWf/bN5aoIXkQV0I8jtN56VFw43X5HGf9aLg1WIq7/pgwsED9y/3RLnfbRl/cExM2DoTdQ6mqudSXOMF6s6eKk8UcUazOXGMlOkDSc6x+x4F89MrO8JV05A41bpamTv69I0pa/TdiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Se9X24lmtshxH3AQnngAjp2vPnbJwOwH81mdWWU2jjs=;
 b=dRDEPSHDFpoWLOqewrb9ZO4QgxkizMe2lBgfyjhklY+zkblHZhitcmQf0R26jjWESgkU9A8DetzP7HXSsU/cGf+6vc/gTlrWMvYyE1n9utloVuQprQsmcaF2WmrR/Q8TfH3m8nzFjzadFwFzApeXroaEykFZyfC/X1wiTO257rhYom4VhIqorK0el/JO3gtZaG1X7UgGxzV/UACQjM443jMIzWl8Vz/BuOYFYptoZ0kvjJV7jsNnYO1IHz8RSoZSaIcQO0hUe0W7GEkfl8obETQYxORso9POVmY8Fe3ldOp3xcsr8JMHISK0cD4HCq2zXpDYhbCLgbKoZBXfkG2B1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Se9X24lmtshxH3AQnngAjp2vPnbJwOwH81mdWWU2jjs=;
 b=sBFTPOjr1me71k5E5AdWcutYs4VFjBY9/FdQldIA/lnor8CAOAyztZCwgRrdDBOMU0/2Hjam2JMHOLFsKMmHjMwT1rNYWaDwkbY2XJshL0V0p2O2XEfY4x0cXRUrE0Ew1k7gILambVfmsI9TYqoL+EcKgJSsWDSDnKHzKxrrRpc=
Received: from SA0PR11CA0052.namprd11.prod.outlook.com (2603:10b6:806:d0::27)
 by DM6PR12MB4467.namprd12.prod.outlook.com (2603:10b6:5:2a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 15:25:31 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:d0:cafe::3e) by SA0PR11CA0052.outlook.office365.com
 (2603:10b6:806:d0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 15:25:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 15:25:31 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 10:25:31 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 10:25:30 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 11 Sep 2026 10:25:30 -0500
Message-ID: <eac6b351-5526-c47f-9797-6d5329c909cf@amd.com>
Date: Fri, 11 Sep 2026 08:25:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3] accel/amdxdna: Fix unsafe use of handle_mm_fault()
Content-Language: en-US
To: Max Zhen <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>, <dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20260910211338.1102315-1-lizhi.hou@amd.com>
 <e263dca3-c61d-45ae-a7da-096d7f509f26@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <e263dca3-c61d-45ae-a7da-096d7f509f26@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|DM6PR12MB4467:EE_
X-MS-Office365-Filtering-Correlation-Id: 85dba9da-2918-492f-745f-08df1018ead8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|10067099003|4143699003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: TTXLPo5yDrITAkv0V3ROQq9E2AapsNMTKavPdhTxY0MYBsHvCDm/HNJ3u43tvNN+sf+vcGlXPwyAQr/VGlkHfC7aMOUIRunYwVeMQ29AcyOyG2eIbWPGdHSwAXci4i/GKRr2lxyOugKhLEsR5b5JUQwHrqXMbqhPAFaAhzTnfhABaxw9+x1ruxCNu1n0/TsFkSjTYFtXwG/7Qfs30NvGfcRw7hjPrb6uDqIJ/OMJA9hOyboGBdkwT2bN7VGiK1NS+EW2GY+698fugoF5TJPORWz2gtKjENMZJ0ZIk6KUvI4RznPjnVlnzkljvQubWJeSIW0pblbxhD2TIEt+yLU6FUdf896RATyBy21zbXvtFWNJfBC1fbCvSoyLG6QwBmNqX/AbbEMIacp8EqP+TMkbSWZ8nW9hE8EI9EeffcPc+xPAZqzOHbtOJ7IMRV1UjAC4Jcc6O61x2WvheAWAPFL+cw1R5LOkNeTaxZ6x6iefBO9+RzjK0IIMVSYU3/buOAgdcW/GYTUWjbPPhcXKwJ2mTtOEKIRqPLhzeAHqVVK4037YIJsuizKjIKVYtyi/X8lC+X8pOd+416Xa2Rg3CNDoJde/lcxOrqF4mVCIUrU9AMbZG2hwYSJh8cjAwqfh7Q5U6icKMtRfVxJUHUHtnEWtLu92XRxFQWzNQR+AywmYc9HZZT1OWXYSXfEfTTq33k2Yq+UsCAPMPCCQEdzr9fHVcQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(10067099003)(4143699003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oo22B2zIu6i2NZ+53kWta1XTx6pzpvZJ9XBre0IvI4TPbCQKRCMbjKQircLHPsZNMUnydwlEwEIKxC1BAcH7u3DSCPEBzS6m71N0Wi7GzoRqlzlOX2vxDWs64+i2hHoqr7hflrZdO+PNa5DLS2QE6M0yr63B+N3sn5A4Io7iHCHDECuYac/JLhmWEnItcDSPMMad1m2vYSXX7bxVLvj7MJxcWc3FtYDtOBcnLCagjv48k+g8MqLmfNZ6u8EATzusPwXDiRoO0nUAQCeVBskTjt5XQzg/z4ZeGX1sw8BcUEde1aAkRXXxp8rw5wvYlWLFUmnFJwQTs/DVQ9FAAOAQzLAKJDa27iZyjhA3B8XSWYc4EgMqhjR+ulxIhoQv2yaMRzEPd+x190dJi49vxIXugqU4PYgUykUZpCFBPRFqVOMMt2iF4NFhn7facu0EdwmN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 15:25:31.4826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85dba9da-2918-492f-745f-08df1018ead8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4467
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

Applied to drm-misc-next

On 9/10/26 15:39, Max Zhen wrote:
>
>
> On 9/10/2026 Thu 14:13, Lizhi Hou wrote:
>> handle_mm_fault() must not be called from the mmap callback because
>> the VMA has not yet been linked. The handle_mm_fault() API contract
>> assumes that the VMA is already linked.
>>
>> Remove the handle_mm_fault() call from the mmap callback. For imported
>> BOs, mark the mapping as invalid and rely on the first command 
>> submission
>> to fault in the pages.
>>
>> For shmem BOs, set the VM_MIXEDMAP flag and use vm_insert_pages().
>> Implement amdxdna_gem_mixed_vm_ops to handle the page faults.
>>
>> Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviewed-by: Max Zhen <max.zhen@amd.com>
>> ---
>> v2 & v3:
>>    Fix sashiko comment.
>>
>>   drivers/accel/amdxdna/amdxdna_gem.c | 151 ++++++++++++++++++++++------
>>   1 file changed, 118 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c 
>> b/drivers/accel/amdxdna/amdxdna_gem.c
>> index 0d165b66c1fc..a12a762b3a6b 100644
>> --- a/drivers/accel/amdxdna/amdxdna_gem.c
>> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
>> @@ -14,6 +14,7 @@
>>   #include <linux/dma-direct.h>
>>   #include <linux/iosys-map.h>
>>   #include <linux/pagemap.h>
>> +#include <linux/swap.h>
>>   #include <linux/vmalloc.h>
>>     #include "amdxdna_cbuf.h"
>> @@ -490,16 +491,16 @@ static int amdxdna_insert_pages(struct 
>> amdxdna_gem_obj *abo,
>>   {
>>       struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
>>       unsigned long num_pages = vma_pages(vma);
>> -    unsigned long offset = 0;
>>       int ret;
>>   -    if (!is_import_bo(abo)) {
>> -        ret = drm_gem_shmem_mmap(&abo->base, vma);
>> -        if (ret) {
>> -            XDNA_ERR(xdna, "Failed shmem mmap %d", ret);
>> -            return ret;
>> -        }
>> -    } else {
>> +    /*
>> +     * Until today there is not any use case to mmap with non-zero
>> +     * offset. Put an explicit check here.
>> +     */
>> +    if (vma->vm_pgoff - drm_vma_node_start(&to_gobj(abo)->vma_node))
>> +        return -EINVAL;
>> +
>> +    if (is_import_bo(abo)) {
>>           vma->vm_private_data = NULL;
>>           vma->vm_ops = NULL;
>>           ret = dma_buf_mmap(abo->dma_buf, vma, 0);
>> @@ -508,23 +509,28 @@ static int amdxdna_insert_pages(struct 
>> amdxdna_gem_obj *abo,
>>               return ret;
>>           }
>>   +        amdxdna_mark_mapp_invalid(abo, vma);
>> +
>>           /* Drop the reference drm_gem_mmap_obj() acquired.*/
>>           drm_gem_object_put(to_gobj(abo));
>> +        return 0;
>>       }
>>   -    do {
>> -        vm_fault_t fault_ret;
>> -
>> -        fault_ret = handle_mm_fault(vma, vma->vm_start + offset,
>> -                        FAULT_FLAG_WRITE, NULL);
>> -        if (fault_ret & VM_FAULT_ERROR) {
>> -            XDNA_ERR(xdna, "Fault in page failed");
>> -            amdxdna_mark_mapp_invalid(abo, vma);
>> -            break;
>> -        }
>> +    ret = drm_gem_shmem_mmap(&abo->base, vma);
>> +    if (ret) {
>> +        XDNA_ERR(xdna, "Failed shmem mmap %d", ret);
>> +        return ret;
>> +    }
>>   -        offset += PAGE_SIZE;
>> -    } while (--num_pages);
>> +    vm_flags_mod(vma, VM_MIXEDMAP, VM_PFNMAP);
>> +    ret = vm_insert_pages(vma, vma->vm_start, abo->base.pages, 
>> &num_pages);
>> +    if (ret) {
>> +        XDNA_ERR(xdna, "Failed to insert pages %d", ret);
>> +        dma_resv_lock(to_gobj(abo)->resv, NULL);
>> +        drm_gem_shmem_put_pages_locked(&abo->base);
>> +        dma_resv_unlock(to_gobj(abo)->resv);
>> +        return ret;
>> +    }
>>         return 0;
>>   }
>> @@ -536,6 +542,10 @@ static int amdxdna_gem_obj_mmap(struct 
>> drm_gem_object *gobj,
>>       struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
>>       int ret;
>>   +    XDNA_DBG(xdna, "BO map_offset 0x%llx type %d userptr 0x%lx 
>> size 0x%lx",
>> +         drm_vma_node_offset_addr(&gobj->vma_node), abo->type,
>> +         vma->vm_start, gobj->size);
>> +
>>       ret = amdxdna_hmm_register(abo, vma);
>>       if (ret)
>>           return ret;
>> @@ -546,9 +556,6 @@ static int amdxdna_gem_obj_mmap(struct 
>> drm_gem_object *gobj,
>>           goto hmm_unreg;
>>       }
>>   -    XDNA_DBG(xdna, "BO map_offset 0x%llx type %d userptr 0x%lx 
>> size 0x%lx",
>> -         drm_vma_node_offset_addr(&gobj->vma_node), abo->type,
>> -         vma->vm_start, gobj->size);
>>       return 0;
>>     hmm_unreg:
>> @@ -556,14 +563,99 @@ static int amdxdna_gem_obj_mmap(struct 
>> drm_gem_object *gobj,
>>       return ret;
>>   }
>>   +/*
>> + * VM operations for amdxdna shmem VMAs that use VM_MIXEDMAP.
>> + *
>> + * drm_gem_shmem_vm_ops cannot be used on VM_MIXEDMAP VMAs because 
>> its fault
>> + * handler calls vmf_insert_pfn() → vmf_insert_pfn_prot() which 
>> contains:
>> + *   BUG_ON((vma->vm_flags & VM_MIXEDMAP) && pfn_valid(pfn))
>> + * All amdxdna shmem pages are ordinary struct pages so pfn_valid() 
>> is always
>> + * true, making the combination fatal.
>> + *
>> + * These ops use vmf_insert_page() (struct-page based) instead, 
>> which is the
>> + * correct API for VM_MIXEDMAP VMAs backed by real struct pages.  
>> The open and
>> + * close handlers replicate drm_gem_shmem_vm_open/close using only 
>> exported
>> + * symbols.
>> + */
>> +static vm_fault_t amdxdna_gem_mixedmap_fault(struct vm_fault *vmf)
>> +{
>> +    struct vm_area_struct *vma = vmf->vma;
>> +    struct drm_gem_object *gobj = vma->vm_private_data;
>> +    struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(gobj);
>> +    loff_t num_pages = gobj->size >> PAGE_SHIFT;
>> +    vm_fault_t ret = VM_FAULT_SIGBUS;
>> +    pgoff_t page_offset;
>> +    struct page *page;
>> +
>> +    /*
>> +     * Partial free of vma is unexpected. Otherwise, the wrong page
>> +     * will be faulted in and the user application may crash itself.
>> +     */
>> +    page_offset = vmf->pgoff - vma->vm_pgoff;
>> +
>> +    dma_resv_lock(gobj->resv, NULL);
>> +
>> +    if (!shmem->pages || shmem->madv < 0 || page_offset >= num_pages)
>> +        goto out;
>> +
>> +    page = shmem->pages[page_offset];
>> +    if (WARN_ON_ONCE(!page))
>> +        goto out;
>> +
>> +    /*
>> +     * Use vmf_insert_page() (struct-page path) not vmf_insert_pfn()
>> +     * (PFN path) because this VMA carries VM_MIXEDMAP.
>> +     */
>> +    ret = vmf_insert_page(vma, vmf->address, page);
>> +    if (ret == VM_FAULT_NOPAGE)
>> +        folio_mark_accessed(page_folio(page));
>> +
>> +out:
>> +    dma_resv_unlock(gobj->resv);
>> +    return ret;
>> +}
>> +
>> +static void amdxdna_gem_mixedmap_vm_open(struct vm_area_struct *vma)
>> +{
>> +    struct drm_gem_object *gobj = vma->vm_private_data;
>> +    struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(gobj);
>> +
>> +    /*
>> +     * Bump pages_use_count so the page array stays alive for the new
>> +     * mapping copy created by fork().  Mirrors 
>> drm_gem_shmem_vm_open().
>> +     */
>> +    dma_resv_lock(gobj->resv, NULL);
>> +    drm_WARN_ON_ONCE(gobj->dev, 
>> !refcount_inc_not_zero(&shmem->pages_use_count));
>> +    dma_resv_unlock(gobj->resv);
>> +
>> +    drm_gem_vm_open(vma);
>> +}
>> +
>> +static void amdxdna_gem_mixedmap_vm_close(struct vm_area_struct *vma)
>> +{
>> +    struct drm_gem_object *gobj = vma->vm_private_data;
>> +    struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(gobj);
>> +
>> +    dma_resv_lock(gobj->resv, NULL);
>> +    drm_gem_shmem_put_pages_locked(shmem);
>> +    dma_resv_unlock(gobj->resv);
>> +
>> +    drm_gem_vm_close(vma);
>> +}
>> +
>> +static const struct vm_operations_struct amdxdna_gem_mixedmap_vm_ops 
>> = {
>> +    .fault  = amdxdna_gem_mixedmap_fault,
>> +    .open   = amdxdna_gem_mixedmap_vm_open,
>> +    .close  = amdxdna_gem_mixedmap_vm_close,
>> +};
>> +
>>   static int amdxdna_gem_dmabuf_mmap(struct dma_buf *dma_buf, struct 
>> vm_area_struct *vma)
>>   {
>>       struct drm_gem_object *gobj = dma_buf->priv;
>>       struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
>> -    unsigned long num_pages = vma_pages(vma);
>>       int ret;
>>   -    vma->vm_ops = &drm_gem_shmem_vm_ops;
>> +    vma->vm_ops = &amdxdna_gem_mixedmap_vm_ops;
>>       vma->vm_private_data = gobj;
>>         drm_gem_object_get(gobj);
>> @@ -573,16 +665,9 @@ static int amdxdna_gem_dmabuf_mmap(struct 
>> dma_buf *dma_buf, struct vm_area_struc
>>         /* The buffer is based on memory pages. Fix the flag. */
>>       vm_flags_mod(vma, VM_MIXEDMAP, VM_PFNMAP);
>> -    ret = vm_insert_pages(vma, vma->vm_start, abo->base.pages,
>> -                  &num_pages);
>> -    if (ret)
>> -        goto close_vma;
>>         return 0;
>>   -close_vma:
>> -    vma->vm_ops->close(vma);
>> -    return ret;
>>   put_obj:
>>       drm_gem_object_put(gobj);
>>       return ret;
>> @@ -878,7 +963,7 @@ static const struct drm_gem_object_funcs 
>> amdxdna_gem_shmem_funcs = {
>>       .vmap = amdxdna_gem_obj_vmap,
>>       .vunmap = amdxdna_gem_obj_vunmap,
>>       .mmap = amdxdna_gem_obj_mmap,
>> -    .vm_ops = &drm_gem_shmem_vm_ops,
>> +    .vm_ops = &amdxdna_gem_mixedmap_vm_ops,
>>       .export = amdxdna_gem_prime_export,
>>   };
>
