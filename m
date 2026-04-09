Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FB7F364B6
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 20:47:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 347FE10E052;
	Thu,  9 Apr 2026 20:47:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oc4/F4YE";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011052.outbound.protection.outlook.com [52.101.52.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E78010E052
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 20:47:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d0DsL/ZcvqbLd57t6tigGVWZHhMo1vvLhOD7Bev+6/2TWKIWH64HO7bzF18FTqS+c+DZ+uyJDYadzBZorPhAzAV1iXuR2wgDaPlFar5rAPqoXMo0ci2VC/DYsNeLO471SRnjzW5K9HBfpeloh2J9af+xFXPdxyEh8rDYdXYpdHdYiG/ejHG9Wc1QHpfxmb/Gnw8o5ZoUWQ3f4iStqhdrQNTTBiNTPT51z2bLqsWvVTIiQHCQ59ITBOMeoFxkJ3e5OQgoK8zfcnZLS/oFd+4nts1nu4ZXKpROtVHdTlSunLOjRU2knvkQwqA+hQjDt58lcgQjcaNRmwzGevpF5urz7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6dvt0YaHSdVdJRRgiGcOoIeC0dJX8DlTq4ZCIIhQgU=;
 b=PgkGeT8GNXKQFHTd8jKQ4WoyXp9dQFpKyZqX2slFtA/3SoT12Of9B3jNRo6p6XXnWRadWX7D06n2q4kvJuCGkSBWhPSjDJommywaiimL8WjXphPMAJmKcGAp+ANSnULaTu1RKhIWF6jcGqkS/rI11W8eyJqPgRtUI3IMukP6bWYIxMFXtzG2AAXpQMr46TDu2jBqpi34QG/aB/RYgY9szhWHpFml0bZxgZ21jQWFm7hAGUKkrubj7fJ6pJ09esFq7b1nzfM+sw08EtoSHtYplDIk4uZL+OY2FNhU/pSqnaOi4cohWgVk6T7zC855mlPaz+RT/zq1LGirzfPKRPS4LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6dvt0YaHSdVdJRRgiGcOoIeC0dJX8DlTq4ZCIIhQgU=;
 b=oc4/F4YEorhL7JF0bDfxrraCV7m/F3AUZJOcas6z0qZZfRuXw7P6API7R2x/EHUgFqd0rpjkufzq205688U/6KoGBN9Yl8uobfR9R0WQKn/BYDRnCwfWH+7478/OdM8eyU6rVNyxuZNKxVAGk+WWLRMGFH5QQ45Vq3vTyTIvldc=
Received: from BY5PR03CA0027.namprd03.prod.outlook.com (2603:10b6:a03:1e0::37)
 by DS7PR12MB8081.namprd12.prod.outlook.com (2603:10b6:8:e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Thu, 9 Apr
 2026 20:46:53 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::bf) by BY5PR03CA0027.outlook.office365.com
 (2603:10b6:a03:1e0::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.40 via Frontend Transport; Thu,
 9 Apr 2026 20:46:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 20:46:53 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Apr
 2026 15:46:52 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Apr
 2026 13:46:52 -0700
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 9 Apr 2026 15:46:50 -0500
Message-ID: <3052c267-7717-b109-6c49-b9302df5eae4@amd.com>
Date: Thu, 9 Apr 2026 13:46:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Expose per-client BO memory usage via
 fdinfo
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <maciej.falkowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <max.zhen@amd.com>, <sonal.santan@amd.com>
References: <20260409152259.176883-1-lizhi.hou@amd.com>
 <cc594c62-8ad7-4582-8838-7f46872be939@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <cc594c62-8ad7-4582-8838-7f46872be939@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|DS7PR12MB8081:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a7bc52a-8094-4c3d-c7ec-08de967921b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: geM0AzjqheYDzAsr6alJVvQr+PehZCKH56if0zIa1lGlkVcxYVzXzErY2bi0tugWnha/FzQ8eusOFJqphs5oTgEEnKFAVkZQcQ6R2SY0BlE2V4FAhyTy3MBgW565jhNA9+vrO96qtnQAcfEEz1C4tvBUVGAlYbn3rSqhoZwcJW9zNqxjsGfyoFMty/8Gss9CHCJtEKM7ahQkIrhm1jadk6RjLmpLYKxCORNLt7rFLiVlFW9AFTIf53kRBEp0x1TCx/rPxJ0ybvMf+h0cCSfAjZgKxzImImCaSyKuggxE0K6QLUEG8rWJLFL1bT4Z1AK5RLMPG1G/VxaMHVxo6Q2qsNRYLZUDxTTXOdSxf9Qm8M/01IWAOFikBcSffjkT8hSUcaVLy6yKrHCWgU8FkvcLVAcyt3Pm3H3HAhSL3XGZ9Je8hpffLJCcjA9nr3/8oyjR2fJbuxpqB+neygl9jdKmZAEIVa7VEQQ8k18PEEdcj/+KHRpjdk8B0D1By+su9buvAtMKsStPa6VmMO0djE5PYr83hdOZQlUXAMTygRR6ej6MrBQb7Ub51z5TVMWAvhVCGmTWI0qD9ppCtOJJMK4zA5Vzhh2WZWXTf19MSviVm7quTUjtqSNbST5GfeOsweXjPGlRfy7Xlv+v82BB6a/Q7m8bLuw8PrkjxZHbsHA5IEyTcHjodYvjapqU78/dmWISFZeuDwsyOcynrxucGBFgXRIHPDpGJBfKW9DPqfyzw4gy4KUIcY/Ca7xw0pzAmBsuwdPYBeXFkPjDqk57P3ji0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +zvSHvNRLo4pHGNdWi81jcDcnEGMrbvsm8HPckzzyi8gczAc6qnciRVHiiy4jqPnwTdGdbsQOMEPFy/6S7Qy6AiKqPvgXJ5M0ybhUHWxm1lH4nW1OfuTGjyvto/Sp1cQtIsTjcAtwHiU4DoBAhLofa2TPY93G4BCsgC82n0DGLx77QQnUdHd/KEDY57QPiAIRbRNhtXRMwZp/73+m72w+/qMGdCItR06UUZ63qNPfT59KZsWOlcbNm7WJ0UWKZnPA1T/jI85juO6JLl4Jynv+IgbQRFvRecq1X1EKM//bQwQYZUlNe2Vn78rBZeFrbEyPimJUy2UmyWri3iCvaNFA8snUgvZWAMQjKurH3eVgFwl5HFMjqUCzItg1F6KTaPfip6lY1yrUpKPgjHhJERT+xa6nTvJW09dDUnW9kxGA+Mm+Y0CjGYecROO/eNlroRv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 20:46:53.2366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a7bc52a-8094-4c3d-c7ec-08de967921b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8081
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


On 4/9/26 10:02, Mario Limonciello wrote:
>
>
> On 4/9/26 10:22, Lizhi Hou wrote:
>> Implement amdxdna_show_fdinfo() to report per-client memory usage,
>> including below driver-specific memory stat:
>>    - heap allocation (amdxdna-heap-alloc)
>>    - internal BO allocation (amdxdna-internal-alloc)
>>    - external BO allocation (amdxdna-external-alloc)
>>
>> Hook the implementation into the DRM fdinfo infrastructure via
>> drm_driver.show_fdinfo, while continuing to expose standard DRM
>> memory stat through drm_show_memory_stats().
>>
>> This improves observability of per-process memory usage and aligns
>> with existing fdinfo reporting mechanisms used by other drivers.
>>
>> Signed-off-by: Max Zhen <max.zhen@amd.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>
> I think you should add a Suggested-by: tag for the person that 
> suggested it (I forget who it was).
>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Added Suggested-by and applied to drm-misc-next
>> ---
>>   Documentation/accel/amdxdna/amdnpu.rst  | 25 +++++++++++++++++++
>>   Documentation/gpu/drm-usage-stats.rst   |  1 +
>>   drivers/accel/amdxdna/amdxdna_pci_drv.c | 32 ++++++++++++++++++++++++-
>>   3 files changed, 57 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/accel/amdxdna/amdnpu.rst 
>> b/Documentation/accel/amdxdna/amdnpu.rst
>> index 42e54904f9a8..064973bf4893 100644
>> --- a/Documentation/accel/amdxdna/amdnpu.rst
>> +++ b/Documentation/accel/amdxdna/amdnpu.rst
>> @@ -270,6 +270,31 @@ MERT can report various kinds of telemetry 
>> information like the following:
>>   * Deep Sleep counter
>>   * etc.
>>   +.. _amdxdna-usage-stats:
>> +
>> +Amdxdna DRM client usage stats implementation
>> +=============================================
>> +
>> +The amdxdna driver implements the DRM client usage stats 
>> specification as
>> +documented in :ref:`drm-client-usage-stats`.
>> +
>> +Example of the output showing the implemented key value pairs:
>> +
>> +::
>> +
>> +        pos:    0
>> +        flags:    0100002
>> +        mnt_id:    29
>> +        ino:    939
>> +        drm-driver:    amdxdna_accel_driver
>> +        drm-client-id:    3219
>> +        drm-pdev:    0000:c5:00.1
>> +        amdxdna_accel_driver-heap-alloc:    60 KiB
>> +        amdxdna_accel_driver-internal-alloc:    67588 KiB
>> +        amdxdna_accel_driver-external-alloc:    0
>> +        drm-total-memory:    67632 KiB
>> +        drm-shared-memory:    0
>> +
>>     References
>>   ==========
>> diff --git a/Documentation/gpu/drm-usage-stats.rst 
>> b/Documentation/gpu/drm-usage-stats.rst
>> index 63d6b2abe5ad..24d3012ca7a6 100644
>> --- a/Documentation/gpu/drm-usage-stats.rst
>> +++ b/Documentation/gpu/drm-usage-stats.rst
>> @@ -215,3 +215,4 @@ Driver specific implementations
>>   * :ref:`panfrost-usage-stats`
>>   * :ref:`panthor-usage-stats`
>>   * :ref:`xe-usage-stats`
>> +* :ref:`amdxdna-usage-stats`
>> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c 
>> b/drivers/accel/amdxdna/amdxdna_pci_drv.c
>> index 09d7d88bb6f1..21eddfc538d0 100644
>> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
>> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
>> @@ -226,6 +226,35 @@ static const struct drm_ioctl_desc 
>> amdxdna_drm_ioctls[] = {
>>       DRM_IOCTL_DEF_DRV(AMDXDNA_SET_STATE, 
>> amdxdna_drm_set_state_ioctl, DRM_ROOT_ONLY),
>>   };
>>   +static void amdxdna_show_fdinfo(struct drm_printer *p, struct 
>> drm_file *filp)
>> +{
>> +    struct amdxdna_client *client = filp->driver_priv;
>> +    size_t heap_usage, external_usage, internal_usage;
>> +    char *drv_name = filp->minor->dev->driver->name;
>> +
>> +    mutex_lock(&client->mm_lock);
>> +
>> +    heap_usage = client->heap_usage;
>> +    internal_usage = client->total_int_bo_usage;
>> +    external_usage = client->total_bo_usage - internal_usage;
>> +
>> +    mutex_unlock(&client->mm_lock);
>> +
>> +    /*
>> +     * Note for driver specific BO memory usage stat.
>> +     * Total memory alloc = amdxdna-internal-alloc + 
>> amdxdna-external-alloc
>> +     */
>> +    drm_fdinfo_print_size(p, drv_name, "heap", "alloc", heap_usage);
>> +    drm_fdinfo_print_size(p, drv_name, "internal", "alloc", 
>> internal_usage);
>> +    drm_fdinfo_print_size(p, drv_name, "external", "alloc", 
>> external_usage);
>> +    /*
>> +     * Note for DRM standard BO memory stat.
>> +     * drm-total-memory counts both DEV BO and HEAP BO
>> +     * drm-shared-memory counts BO imported
>> +     */
>> +    drm_show_memory_stats(p, filp);
>> +}
>> +
>>   static const struct file_operations amdxdna_fops = {
>>       .owner        = THIS_MODULE,
>>       .open        = accel_open,
>> @@ -236,6 +265,7 @@ static const struct file_operations amdxdna_fops = {
>>       .read        = drm_read,
>>       .llseek        = noop_llseek,
>>       .mmap        = drm_gem_mmap,
>> +    .show_fdinfo    = drm_show_fdinfo,
>>       .fop_flags    = FOP_UNSIGNED_OFFSET,
>>   };
>>   @@ -251,7 +281,7 @@ const struct drm_driver amdxdna_drm_drv = {
>>       .postclose = amdxdna_drm_close,
>>       .ioctls = amdxdna_drm_ioctls,
>>       .num_ioctls = ARRAY_SIZE(amdxdna_drm_ioctls),
>> -
>> +    .show_fdinfo = amdxdna_show_fdinfo,
>>       .gem_create_object = amdxdna_gem_create_shmem_object_cb,
>>       .gem_prime_import = amdxdna_gem_prime_import,
>>   };
>
