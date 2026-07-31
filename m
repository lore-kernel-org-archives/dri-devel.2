Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE096C55174
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 18:33:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A4CB10E210;
	Fri, 31 Jul 2026 18:33:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eRW4NqTK";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010013.outbound.protection.outlook.com [52.101.61.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB36D10E210
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 18:33:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXwoDtmrRhK5lTNPxAun/STNKeYhhw0+r8VpABpAzyn1aYT+/dX9rFOsTL2B72NtVJIGCBaa9YS/twu3y/eoN3ZSMOBtgw44ApLahGgJ6x+X6tG9EeYGwN69iLUqDYACsjvcSo+HAaNUjqM7fqx+BkvtxvJ5ZK5JEFvnsxZsuTxqTpKqoQ6p6+t9PCVmKn9fQRy2OuVQEJuOJ9x90kwmlpIo4zZhMQ5nrgYsCXqFYjSWe+Zinz5CH7p73iIdhAxrhcGum/6mVFNPDoy4/nsEmKorSz06dYquMQeDrLqL2GXgrOecDP7rIFBSzJ9FG6AOdkGVk5UHZqexdUwllW7tVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/GLVc9v0d76ZSGmxy+NnpGPXjx/CdpwrNfzJ/cKW5U=;
 b=m0NS+Bw5S+457PayTWod/TxnL3/u+Ghvac3dJ3i2M0XDwluWN0Ox04m0/vi+XUa3W66DudbIqQ//y6oL9wGNtg/tnmRqAdlQGMliVppJlYfYuuKOtBTKy4uJ8nn6kSP5f/t9ZoHXw3sKRSe9VmV8qQew+2oTwJ024DQylnd6H+3Elg2NYfCcMBiwShoKPbAzAznxZq1gOuUjO14M0gUQbiU+ojTRYExPSzSFIeinGLwBlcZBifWw41pWhyjM2OMMXSYAR3vPPI6NanRLtvifOrLEA2D2FyPa6hlkaMrgdt5rMg8sRpMzALDMR2J9NRldkbm8782i5Px9tWIy5Ivosg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/GLVc9v0d76ZSGmxy+NnpGPXjx/CdpwrNfzJ/cKW5U=;
 b=eRW4NqTKsenu3kIO80WgrHHGgggde2WkMYXznx7AKBUXykVmC/6luK6GRyY9eN3enzyk8zBaRs5X0CcdnPEP6+WeVG61wJ9e4joGi89g41yHjAGpAYMAhFutD391oin7LU7a57g6FMPai4f6nTPkqdQMqve5bhrXWNEruBMI/Vw=
Received: from BN1PR13CA0002.namprd13.prod.outlook.com (2603:10b6:408:e2::7)
 by SJ0PR12MB7006.namprd12.prod.outlook.com (2603:10b6:a03:486::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 18:33:09 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:408:e2:cafe::77) by BN1PR13CA0002.outlook.office365.com
 (2603:10b6:408:e2::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.10 via Frontend Transport; Fri,
 31 Jul 2026 18:33:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 18:33:08 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 13:33:08 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 13:33:07 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 13:33:07 -0500
Message-ID: <f6f12b9b-1fb4-8bec-ad62-bd4dd0f3cb05@amd.com>
Date: Fri, 31 Jul 2026 11:33:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amxdna: fix page-insertion errors in
 amdxdna_insert_pages()
Content-Language: en-US
To: Max Zhen <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20260723074256.2435143-1-lizhi.hou@amd.com>
 <b414f3d5-b88d-4bb1-9d28-917348506e57@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <b414f3d5-b88d-4bb1-9d28-917348506e57@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|SJ0PR12MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: a6e0d1c4-85f6-4a0f-ca9e-08deef322b2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|18002099003|22082099003|4143699003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: c0BhncWq88Vnk7G0aFTVOM77f62YFjape+3UHoPhb4XAndB26+VcKR83Om3gfcLsi/SnLhiMw69OuPix5AdSSnh3VEDA4HWMcMPosnTFVbVBdKVoiNCOLQBsav/PVIvabR9FKFpyWzEzGvVAn2lQKFRlO3r/B3v0RzEjB+p+g6n7sHbmc6m3mUK/H5YKhO6o2VB1NMQY3+9FZzFAwyuILR/Hv+/7X+i4MihyzDUJpPI3921wGNtaP+eoQ5AdjbzhGcgMSLtyNvztvD75hnqDDIQPjS+vRe26zS+wPReLZm/X1Wg5VsoL7/as0VZdVJMstxweAPxUtqENjT8asf4tlE23wbLVVJiXA/VmFps+Vw2HGbqLsrjHC4uz8711vJ1ZM+q8vCS13uAvuZW6PZWlZr/ERI2S8Aas9dr9o8iyADLeFbvbeC9m3+z1KllHUNI9+HaIt9DxbL6hhXm/tE1+ZXNTmfiA4ca9ZqTqA+0MlOntI9+I7/tl0yFUUG3OZzVO6PN2dosoYyE3DvsK5vKSP/73c9Pv73yTU2oiSPU/pTCtg1LmhVCZ8JwrezOZbrEnyIqScuTiokpxUOS8pSP8UHbZL7+Hhv7LcapMbum67iyNbQ34c6tYa/lntcQLugZ1MxeswBgFbW8lf+7kR+A+FTfZ34oAsnKbaHXUIDMFDVG6mOZFW6cvVjylwYDJOIR6/5/HVTBsCVPwncqWwYbeUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(18002099003)(22082099003)(4143699003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: X7Yf9GTjJ4PFRfHPuY/Sbri8VLJ0Hv3JnTSXxs1dNliaL9hdZXbYmsZttM+SQl9db5iQDqhzoclmJZN5af5H2W6RY+FKSc5oCr8bxvVhP5trVeFE7e23BAYNXgwN6LijSIf2IRg1R+6M/JgGU6ejr8KWA9NtWnDJnCKDMFO5K6/+PxFdDRW7OL1dRhcPYf261ndYmfpIga6F7tOtWmk5nmnwOUwPVGnHbbyQUK+zDPgEr7LK4LrtUAnRX2ZUFu4kYx54mQCrjBRZ/s3megNr55cidu9J2VuV9VrNSQbKSMdssoJbdRieO/tJ91v85KnivALEhbHBNBrIaoA4XUKdT5NLZpU5UF1e0JAE9e2fjxB07XCuW8z2PNdPXZAyD1oJsfL2q853LuYj1ZATMf1bZUbcriG3l4Y+OlnXJa0ZBDBXkeKcBaeXcqEbEERFv4KU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 18:33:08.4473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e0d1c4-85f6-4a0f-ca9e-08deef322b2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7006
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

On 7/23/26 11:03, Max Zhen wrote:
>
>
> On 7/23/2026 Thu 00:42, Lizhi Hou wrote:
>> Two error paths in amdxdna_insert_pages() called vma->vm_ops->close(vma)
>> before returning an error code to the caller.  This is incorrect:
>> amdxdna_gem_obj_mmap() registers an HMM interval notifier before calling
>> amdxdna_insert_pages(), and on a hard error it jumps to hmm_unreg to 
>> undo
>> that registration.  Calling vm_ops->close() manually — which drops the
>> shmem pages_pin_count and the GEM object reference that backs the VMA —
>> before the mmap syscall has even returned causes those resources to be
>> released while the VMA is still alive.  The kernel VMA teardown will 
>> call
>> vm_ops->close() a second time when the process later unmaps the range,
>> producing a reference count underflow.
>>
>> Replace both hard-error returns with a deferred-fault approach that 
>> keeps
>> the VMA alive and retries page insertion through the HMM range-fault 
>> path.
>>
>> Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviewed-by: Max Zhen <max.zhen@amd.com>
>> ---
>>   drivers/accel/amdxdna/amdxdna_gem.c | 24 ++++++++++++++++++++----
>>   1 file changed, 20 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c 
>> b/drivers/accel/amdxdna/amdxdna_gem.c
>> index d6fe6fb41286..aed110ad1c1e 100644
>> --- a/drivers/accel/amdxdna/amdxdna_gem.c
>> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
>> @@ -435,6 +435,23 @@ static void amdxdna_gem_dev_obj_free(struct 
>> drm_gem_object *gobj)
>>       amdxdna_gem_destroy_obj(abo);
>>   }
>>   +static void amdxdna_mark_mapp_invalid(struct amdxdna_gem_obj *abo,
>> +                      struct vm_area_struct *vma)
>> +{
>> +    struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
>> +    struct amdxdna_umap *mapp;
>> +
>> +    down_write(&xdna->notifier_lock);
>> +    abo->mem.map_invalid = true;
>> +    list_for_each_entry(mapp, &abo->mem.umap_list, node) {
>> +        if (compare_range(mapp, vma->vm_mm, vma->vm_start, 
>> vma->vm_end)) {
>> +            mapp->invalid = true;
>> +            break;
>> +        }
>> +    }
>> +    up_write(&xdna->notifier_lock);
>> +}
>> +
>>   static int amdxdna_insert_pages(struct amdxdna_gem_obj *abo,
>>                   struct vm_area_struct *vma)
>>   {
>> @@ -456,8 +473,7 @@ static int amdxdna_insert_pages(struct 
>> amdxdna_gem_obj *abo,
>>                         &num_pages);
>>           if (ret) {
>>               XDNA_ERR(xdna, "Failed insert pages %d", ret);
>> -            vma->vm_ops->close(vma);
>> -            return ret;
>> +            amdxdna_mark_mapp_invalid(abo, vma);
>>           }
>>             return 0;
>> @@ -477,9 +493,9 @@ static int amdxdna_insert_pages(struct 
>> amdxdna_gem_obj *abo,
>>           fault_ret = handle_mm_fault(vma, vma->vm_start + offset,
>>                           FAULT_FLAG_WRITE, NULL);
>>           if (fault_ret & VM_FAULT_ERROR) {
>> -            vma->vm_ops->close(vma);
>>               XDNA_ERR(xdna, "Fault in page failed");
>> -            return -EFAULT;
>> +            amdxdna_mark_mapp_invalid(abo, vma);
>> +            break;
>>           }
>>             offset += PAGE_SIZE;
>
