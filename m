Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF68C5516F
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 05:50:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDC6C10E28B;
	Sat,  1 Aug 2026 05:50:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dlfrR5Zr";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012012.outbound.protection.outlook.com [52.101.48.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2887E10E28B
 for <dri-devel@lists.freedesktop.org>; Sat,  1 Aug 2026 05:50:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K89TbGdFP7fWgBIalfl1UmiI3V29k/0POd9aJkr3Pku8ZH0TX1dzxptokkNryKmdz2+pTZ/hZVRFG6CwYI1HRJh0Di/TAEzpCeOiQX2ZoXg9NFNGxNgtJfekPtxS0OeZPvl2oi78MdQT0rrvzXGe3qevyCqO6/5bV3WPHN67FQDGdHM/ZaNH7boLE2xRrsxBpwBkniGro/bo9Qaxc4Ff3kr6AENPm3F9OMaYn8mj9eF5/FFwBsyNcv39WaVi2NbjtKor/ObaR/OnSjZuWgKGkQXTJIGZr8GM5MqIcKwvUZx3g1giEzYol6/htcaMKQr9zz/RO8XHb0fqfOfs+oKarQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvId50Mn5zfUX2dlT47bSd3yz0rxEScVD91xTEbsWSY=;
 b=zI2AgnTncDpwqXXgn7nGT0wgDLMszzi/d9V5kb8e6JMaINM1o38RiPVa7UmBewx86r2GzLXsGbCov+UWgpl0r2vCVWZjKmkLfOfqQJKcxLzsngIzVCNqklSXMwqBUH0U6F5vcGIpmWlycjI7cEOBilFG+1Gw4k2gUjiPNmcNahFNHbCSWAYz7AjvUj5btohyTAy7jVc8NayZy0DICWPxewABS7JQPP2LqfRspXqLRCGBFt7/SqiZdpRcdoACCAMoArTRSgwpibbVMMzmyfHVVsfjn5rOuRZbhCxfJKe7DaE1pjeyk8ZWnbyON7kaR6e3KGXSOwfTNKLTN5L62sma8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvId50Mn5zfUX2dlT47bSd3yz0rxEScVD91xTEbsWSY=;
 b=dlfrR5ZrH+QBp1qlTnSesHgWWj8e3CkP1D+iMkBJSgLk+5Bw1rtj0WaW+erqOFeWrmxd+T3w+YREv5TI7QfLNN31aGAXioRErcp/52y0HQIPtIWoQVzrVXw4YFks8oeKgm4s9ZdG4Rqe9qYul14Bkd9+k87stwEq3+KUhZp4Oxw=
Received: from CH2PR16CA0015.namprd16.prod.outlook.com (2603:10b6:610:50::25)
 by SA0PR12MB7462.namprd12.prod.outlook.com (2603:10b6:806:24b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Sat, 1 Aug
 2026 05:50:28 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::67) by CH2PR16CA0015.outlook.office365.com
 (2603:10b6:610:50::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.17 via Frontend Transport; Sat, 1
 Aug 2026 05:50:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Sat, 1 Aug 2026 05:50:25 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 1 Aug
 2026 00:50:25 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 1 Aug
 2026 00:50:25 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Sat, 1 Aug 2026 00:50:24 -0500
Message-ID: <6a12a388-b50b-8822-ebf6-6d9a897946f9@amd.com>
Date: Fri, 31 Jul 2026 22:50:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Fix locally exploitable BUG_ON in
 amdxdna_insert_pages()
Content-Language: en-US
To: Max Zhen <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20260731185955.3449311-1-lizhi.hou@amd.com>
 <2b118f6a-f672-4e91-bb53-30431cfcc0b6@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <2b118f6a-f672-4e91-bb53-30431cfcc0b6@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|SA0PR12MB7462:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b62533e-3168-4119-375e-08deef90c8e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|56012099006|11063799006|4143699003|10067099003|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: gybwW/09TS4WupTo/uyWUt7zGZXDjLJ6TcgAXXnJF6wLwxW0oYdqnEMGlWrDwJy3Ox28E0FIlkwlIebDa2mxXGwjrYPey/oBS4e0B7X8Z+zv1k8z9Ml+/mKDdcx4pL2INIovj6tpnhlitpVRCaZzabHcJEDSCMJcnpdSf2ZPyr898va95mrsem6ZKfsFspcj/bRjnF6SHpLFtdspCUbG9ZXw09qhcQA51Ts0RPm+XQHbeqQlcoWD4eEyJAzUJYqq0KkvRRnxliNCUuqCTeBK4QZ/mMzgkQEee1VSjHizFko3wku77Gdepms/7hDYk/AmqiWYhUCfNOHD7qJKJlmCaZ6UojjchFbCI+c6wMFIsMqIasP40NeM58+MzYAhGaBuncgTPvwo36rEtP4j50aQYrd1X1mFUCZH7sAdNocB0bLnfGPVOO5RsChvu9vNAzgP/e8tSH7552OJapaP+7MTmYyw25vDD+vgDNwe24Sh9ED9xsxCPaDjJqvn+wilGUfrFhL71zOUHHMahcFT5LLxAz4VLiWfreqrXazr79+OkJZUjWP6nVX8Q/lH+4nTBz4Da6L+06fWnCuqyRQWvwDvrap/R/jayJhhEJyYCN4CBTIzE+sTtmAs6Cj4/xSe05AvHyGL5z9ZyieJhw6fJ4hsgPkCNT35HFA+kFxZ0Axd8UkL36bYzmOlAj21kWVuHK2aAHpX4qXOaRohGls7BAhFGQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(56012099006)(11063799006)(4143699003)(10067099003)(3023799007)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oAxegIVN0IVVVT2NFKv+nQA4561MaGK6CYQt6mckem2YTAIypQZtxQBxIMCwM3k1UJfKj3upnaQ88eKtBHZbEK/mkPw2vbFOrl3QRf/yXJHMVWPHg3BI3j8v/8v34hLPBkBLbr4op5SaGkr4eY7+CBtEPLeGABLCvxZpYXanA8sMNa4QXvv2SNC8uWN7MyxkCiMYeY2VetVf8mlSVK8hHG0kITEoh0A5ID/ya7nyx5xLdqpxSNVJe38hEwAMPrie4bUrLxOE8JGMM7nfAQQWnijPFsOEA0haFjAWHA/Bw0QNE/E8gA8uoisb+hs5J22LNiXVUatf8QgV1ecm9AwS62qzQ015WgmMXV/3sQ9fAa4W4GmlWlal8ildlPqhI7U8W0UJksSL0JQvVpJfhwSxlUUGX0lgESFS0qwHSodR+iYIprHiYzHznOe4NVrfIXkX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2026 05:50:25.7521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b62533e-3168-4119-375e-08deef90c8e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7462
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

Applied to drm-misc-fixes.

On 7/31/26 13:59, Max Zhen wrote:
>
>
> On 7/31/2026 Fri 11:59, Lizhi Hou wrote:
>> In amdxdna_insert_pages(), vm_flags_mod() sets VM_MIXEDMAP and clears
>> VM_PFNMAP. If an unprivileged userspace process mmaps a non-imported GEM
>> object and then calls madvise(MADV_DONTNEED), the PTEs will be
>> successfully cleared because VM_MIXEDMAP allows this (unlike VM_PFNMAP).
>>
>> When userspace subsequently accesses the memory, drm_gem_shmem_fault()
>> handles the page fault and attempts to map the backing shmem page via
>> vmf_insert_pfn() which calls vmf_insert_pfn_prot(). Because the backing
>> shmem page is normal system memory (pfn_valid(pfn) is true) and the VMA
>> now has VM_MIXEDMAP set, won't this predictably trigger the explicit
>> assertion BUG_ON((vma->vm_flags & VM_MIXEDMAP) && pfn_valid(pfn))
>>
>> Fix by removing the vm_flags_mod() call and replacing the 
>> vm_insert_pages()
>> pre-population with the handle_mm_fault() loop that was already used for
>> the import (dma-buf) path.
>>
>> Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviewed-by: Max Zhen <max.zhen@amd.com>
>> ---
>>   drivers/accel/amdxdna/amdxdna_gem.c | 27 ++++++++-------------------
>>   1 file changed, 8 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c 
>> b/drivers/accel/amdxdna/amdxdna_gem.c
>> index aec69d5f463e..1c63eff0a4a8 100644
>> --- a/drivers/accel/amdxdna/amdxdna_gem.c
>> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
>> @@ -467,25 +467,17 @@ static int amdxdna_insert_pages(struct 
>> amdxdna_gem_obj *abo,
>>               XDNA_ERR(xdna, "Failed shmem mmap %d", ret);
>>               return ret;
>>           }
>> -
>> -        /* The buffer is based on memory pages. Fix the flag. */
>> -        vm_flags_mod(vma, VM_MIXEDMAP, VM_PFNMAP);
>> -        ret = vm_insert_pages(vma, vma->vm_start, abo->base.pages,
>> -                      &num_pages);
>> +    } else {
>> +        vma->vm_private_data = NULL;
>> +        vma->vm_ops = NULL;
>> +        ret = dma_buf_mmap(abo->dma_buf, vma, 0);
>>           if (ret) {
>> -            XDNA_ERR(xdna, "Failed insert pages %d", ret);
>> -            amdxdna_mark_mapp_invalid(abo, vma);
>> +            XDNA_ERR(xdna, "Failed to mmap dma buf %d", ret);
>> +            return ret;
>>           }
>>   -        return 0;
>> -    }
>> -
>> -    vma->vm_private_data = NULL;
>> -    vma->vm_ops = NULL;
>> -    ret = dma_buf_mmap(abo->dma_buf, vma, 0);
>> -    if (ret) {
>> -        XDNA_ERR(xdna, "Failed to mmap dma buf %d", ret);
>> -        return ret;
>> +        /* Drop the reference drm_gem_mmap_obj() acquired.*/
>> +        drm_gem_object_put(to_gobj(abo));
>>       }
>>         do {
>> @@ -502,9 +494,6 @@ static int amdxdna_insert_pages(struct 
>> amdxdna_gem_obj *abo,
>>           offset += PAGE_SIZE;
>>       } while (--num_pages);
>>   -    /* Drop the reference drm_gem_mmap_obj() acquired.*/
>> -    drm_gem_object_put(to_gobj(abo));
>> -
>>       return 0;
>>   }
>
