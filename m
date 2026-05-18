Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FDDCD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 16:09:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F7F510E334;
	Mon, 18 May 2026 16:09:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B2YKLY7q";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013021.outbound.protection.outlook.com
 [40.107.201.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E27C10E334
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 16:09:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDhzEXj7vqB1rpMmkZdUR3q3mvOA8pf0uBJBxCCWL27GJYh8rhjkCNkPmB+tQkDP3BMJ0uawuxDCOFW53WdpJwe3Q7SCb0mEx7MCeRK0/a8mjSZwn7XXQdcLruNktZHbFGiRTKcRYn51QamgQRu4lOxco8KLiqmCc4mrZlGY432YzAL7Y2SgXjAKBIe853wMO7FIswmcVHZfvlMHAOAxTRg0/YStEYMhuTjey0L/Ok8fvTU0kg2iFSqXG3L53KQmy3n6RROkuu59RT0FB7B6Uh2lyB6t4rRtMpTP9uhJXrBcYvkCM53Brl7zz6kXlQXaS025r9HdILDD4Cl+K8PNGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmuMz2+W0ETfPzJXGr9v2Y03Ad+1CS2B45iVMY58Cb8=;
 b=T302x3rPxW35k6QLcplDkdoNnv/f0kYPBsUO0tT3z5pIxf/tuDIailBu8ifETwl8ZCLsw8/rqWbBcc9KBhDpVv+urBToMBNYHbtrGCV9hmcbPXX6L190mEStnrBGN5bbw7XRvyCvJCmwmm1ZiurDd5o1QrUHcZf69CdftxGUA8z+ZfOz07qa0zQfuZ2XBUQ1CVCk9m3mQGJR1DoahmQXV/+Pk3ulrvxMD4+yC5eMRejipDoV8Xj4qMCdybS31mMucqvQoK/L3Hh+KUA6NpFi5N0EGK1TeugMIbf1lgQUST91miLd+GC2Ms3WriuwhsDtiHfOxRn3jxHUFKRa5/tK+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmuMz2+W0ETfPzJXGr9v2Y03Ad+1CS2B45iVMY58Cb8=;
 b=B2YKLY7qi+CRMQi8O2ze1wX1/lIZtWzLhnwQYQgsqLgH28oKJiSBxEo/p7BxwUSXiQY6QvU9eoGo+vnHCePAsmxjobQ/8pudVbWbbcPxBz1647UrqI2OBP8kikt27rQY9GufWhTnvmHBsrodxE85Y0x7++++yKwkNI6ZMKGi+2E=
Received: from CY5PR19CA0037.namprd19.prod.outlook.com (2603:10b6:930:1a::18)
 by CH2PR12MB4166.namprd12.prod.outlook.com (2603:10b6:610:78::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 16:09:21 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:1a:cafe::41) by CY5PR19CA0037.outlook.office365.com
 (2603:10b6:930:1a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 16:09:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 16:09:20 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 18 May
 2026 11:09:20 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 18 May 2026 11:09:19 -0500
Message-ID: <758c2748-97df-9eff-06d3-e62c3d7c23e8@amd.com>
Date: Mon, 18 May 2026 09:09:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2] accel/amdxdna: Add expandable device heap support
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <max.zhen@amd.com>,
 <sonal.santan@amd.com>, Wendy Liang <wendy.liang@amd.com>
References: <20260515161922.744647-1-lizhi.hou@amd.com>
 <155ad1aa-4847-4acd-8ede-1157449a4709@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <155ad1aa-4847-4acd-8ede-1157449a4709@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|CH2PR12MB4166:EE_
X-MS-Office365-Filtering-Correlation-Id: 42e269fd-2f81-4a36-fab3-08deb4f7d229
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|56012099003|22082099003|18002099003|3023799003|4143699003|10063799003|11063799003;
X-Microsoft-Antispam-Message-Info: bIIgo9x1tFlhmwKkgGgYrUbeUp7wZPilNlwcloF1lVWcL/JuYigL4Ak+fRZqz2EZ3poEIUsXa0D3+bSZGkBeU0wOjeuDiHa2kqcYQrOewxLMLzi4haLXGB7gpE6/AiojgITWW4wfNnXM9WimrtrzQC4EiyXX3nKRStUDmciO2MAD4qN49uhjY0DnH67tOzxjLwUm/hTL2HTEYl3JDplHh6KcyPbj2sOas/U5AjM38fd2BtyfcyEoC0szdoF2r8mv5IUI76flNInEjHXffjhpX14EfGVGaQqsx015TcM9qKnO2d50p7i9cF0225K9NAlt6rm4itRP9LT3sHHbxFTu9NVvzwHfgbduZA9cs7m5J7QloGyJcmB58R4kV/qTdtAqqCQp84NfhsR8FNhZsFoWH3w190tbFxbYDH3ctSdKS+zRtiBLYr4KI95rrcJxmOh2VpCKdezx9RaoOTyOMbAK57UAWcNs0n9TenSXv8YHZgql8MN/cKd6lOCwvxruXDiH9bHegZw7zO+2N8zz2zyKClfh4hiOOuV3joD5Qm1W+GVmue11LEjt7YRyYhaWLwvO1+SIXRGOIqldEhoC3Z3NBDdmlbK4SfPi3Ahxjg/5P0cvvQoVFqkE503kgEJSIPN2ueDYV0gz/vGIIG/GCn2Fq0kzho8nq2nTHJiVcylBpZPZJ8n1gsI8lCpbtR4T9J/hzHkv1GXwTDceaMiA9wALdABk5MvW+jdnY2c7o3/WZps=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(22082099003)(18002099003)(3023799003)(4143699003)(10063799003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Hk5Gp0q5uieoiWmMdVtY6DQ/FsX/+jL1AWj+jbwAkZcIPzSOfqVqW9aUhiQfPiJsN9j+VFG2dL2fk4J5F43kXjZF4acHBft06Y7fQZHtT5u5K5O6v06awseJ4YLbW5Bo0Mmbtj4GJU4PqKglV6GDmC/PYo1mCxXw7xqRzOrvhHAeEnZSCXOCZxVdofDGS1ua8mbUg4V0Bvq2fXlWv1EiHHCAhEIHx+i/AWqoqmkbCCjenh8+z5oOhcbBNIZrZMNOKLnSqKZ/t8lHoyDYEi6lf00aFKuYX7SSgzIE/15HinufaY5AgS6FmN0t1muioQO9oIUc9spaPyr/F7+8yov7o5zBZEYThJIn5HyjKlJheyd3cn1OGVGIG7sU7jrcPkrxdmzv70Y6qCp5hzUcF3Zca7exO62ujHabSV4HVSTC5A02rtdLRaaOdfXfZvgf7nL4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 16:09:20.8220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e269fd-2f81-4a36-fab3-08deb4f7d229
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4166
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


On 5/15/26 14:01, Mario Limonciello wrote:
>
>
> On 5/15/26 11:19, Lizhi Hou wrote:
>> Introduce an expandable device heap to avoid allocating a large heap
>> upfront. Start with a smaller initial heap and grow it on demand.
>> Return -EAGAIN when BO allocation fails due to insufficient heap space,
>> allowing userspace to trigger heap expansion via a heap BO creation
>> IOCTL and retry the allocation.
>>
>> Manage heap chunks using an xarray. On expansion, register new chunks
>> with the firmware via MSG_OP_ADD_HOST_BUFFER.
>>
>> Since heap shrinking is not supported by the firmware, release all heap
>> chunks on device close.
>>
>> Co-developed-by: Wendy Liang <wendy.liang@amd.com>
>> Signed-off-by: Wendy Liang <wendy.liang@amd.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>> ---
>> v2:
>>    Fix memory leak when initializing hardware context failed.
>>    For flush BO, only flush the requested area.
>
> I have some minor feedback below that can be follow ups.
>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>
>>
>>   drivers/accel/amdxdna/aie2_ctx.c        |  45 +++-
>>   drivers/accel/amdxdna/aie2_message.c    |  52 +++-
>>   drivers/accel/amdxdna/aie2_msg_priv.h   |   1 +
>>   drivers/accel/amdxdna/aie2_pci.c        |   1 +
>>   drivers/accel/amdxdna/aie2_pci.h        |   8 +-
>>   drivers/accel/amdxdna/amdxdna_ctx.c     |  88 ++++++-
>>   drivers/accel/amdxdna/amdxdna_ctx.h     |   2 +
>>   drivers/accel/amdxdna/amdxdna_gem.c     | 319 ++++++++++++++++++------
>>   drivers/accel/amdxdna/amdxdna_gem.h     |  16 +-
>>   drivers/accel/amdxdna/amdxdna_pci_drv.c |  12 +-
>>   drivers/accel/amdxdna/amdxdna_pci_drv.h |   8 +-
>>   drivers/accel/amdxdna/npu1_regs.c       |   1 +
>>   drivers/accel/amdxdna/npu4_regs.c       |   2 +
>>   drivers/accel/amdxdna/npu5_regs.c       |   1 +
>>   drivers/accel/amdxdna/npu6_regs.c       |   1 +
>>   15 files changed, 460 insertions(+), 97 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/aie2_ctx.c 
>> b/drivers/accel/amdxdna/aie2_ctx.c
>> index 7d6094aefb6f..658a5fb1fda6 100644
>> --- a/drivers/accel/amdxdna/aie2_ctx.c
>> +++ b/drivers/accel/amdxdna/aie2_ctx.c
>> @@ -91,6 +91,7 @@ static void aie2_hwctx_stop(struct amdxdna_dev 
>> *xdna, struct amdxdna_hwctx *hwct
>>   static int aie2_hwctx_restart(struct amdxdna_dev *xdna, struct 
>> amdxdna_hwctx *hwctx)
>>   {
>>       struct amdxdna_gem_obj *heap = hwctx->priv->heap;
>> +    unsigned long heap_id;
>>       int ret;
>>         ret = aie2_create_context(xdna->dev_handle, hwctx);
>> @@ -107,6 +108,17 @@ static int aie2_hwctx_restart(struct amdxdna_dev 
>> *xdna, struct amdxdna_hwctx *hw
>>           goto out;
>>       }
>>   +    xa_for_each_range(&hwctx->client->dev_heap_xa, heap_id, heap, 1,
>> +              hwctx->last_attached_heap) {
>> +        ret = aie2_add_host_buf(xdna->dev_handle, hwctx->fw_ctx_id,
>> +                    amdxdna_obj_dma_addr(heap),
>> +                    heap->mem.size);
>> +        if (ret) {
>> +            XDNA_ERR(xdna, "Add heap %ld failed ret %d", heap_id, ret);
>> +            goto out;
>> +        }
>> +    }
>> +
>>       ret = aie2_config_cu(hwctx, NULL);
>>       if (ret) {
>>           XDNA_ERR(xdna, "Config cu failed, ret %d", ret);
>> @@ -650,7 +662,7 @@ int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
>>       hwctx->priv = priv;
>>         mutex_lock(&client->mm_lock);
>> -    heap = client->dev_heap;
>> +    heap = xa_load(&client->dev_heap_xa, 0);
>>       if (!heap) {
>>           XDNA_ERR(xdna, "The client dev heap object not exist");
>>           mutex_unlock(&client->mm_lock);
>> @@ -732,6 +744,12 @@ int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
>>           goto release_resource;
>>       }
>>   +    ret = amdxdna_update_heap(client, hwctx);
>> +    if (ret) {
>> +        XDNA_ERR(xdna, "Update heap failed, ret %d", ret);
>> +        goto release_resource;
>> +    }
>> +
>>       ret = aie2_ctx_syncobj_create(hwctx);
>>       if (ret) {
>>           XDNA_ERR(xdna, "Create syncobj failed, ret %d", ret);
>> @@ -1161,3 +1179,28 @@ void aie2_hmm_invalidate(struct 
>> amdxdna_gem_obj *abo,
>>       else if (ret == -ERESTARTSYS)
>>           XDNA_DBG(xdna, "Wait for bo interrupted by signal");
>>   }
>> +
>> +int aie2_hwctx_heap_expand(struct amdxdna_hwctx *hwctx,
>> +               struct amdxdna_gem_obj *heap)
>> +{
>> +    struct amdxdna_client *client = hwctx->client;
>> +    struct amdxdna_dev *xdna = client->xdna;
>> +    u64 addr;
>> +    int ret;
>> +
>> +    ret = amdxdna_pm_resume_get_locked(xdna);
>> +    if (ret)
>> +        return ret;
>> +
>> +    addr = amdxdna_obj_dma_addr(heap);
>> +    ret = aie2_add_host_buf(xdna->dev_handle, hwctx->fw_ctx_id,
>> +                addr, heap->mem.size);
>> +    if (ret) {
>> +        XDNA_ERR(xdna, "Add heap failed hwctx %s 0x%lx ret %d",
>> +             hwctx->name, heap->mem.size, ret);
>> +    }
>> +
>> +    amdxdna_pm_suspend_put(xdna);
>> +
>> +    return ret;
>> +}
>> diff --git a/drivers/accel/amdxdna/aie2_message.c 
>> b/drivers/accel/amdxdna/aie2_message.c
>> index 1504295a21e4..c4b364801cc0 100644
>> --- a/drivers/accel/amdxdna/aie2_message.c
>> +++ b/drivers/accel/amdxdna/aie2_message.c
>> @@ -301,25 +301,59 @@ int aie2_destroy_context(struct amdxdna_dev_hdl 
>> *ndev, struct amdxdna_hwctx *hwc
>>       return ret;
>>   }
>>   -int aie2_map_host_buf(struct amdxdna_dev_hdl *ndev, u32 
>> context_id, u64 addr, u64 size)
>> +static int aie2_send_host_buf_msgs(struct amdxdna_dev_hdl *ndev, u32 
>> context_id,
>> +                   u64 addr, u64 size, u32 initial_opcode)
>>   {
>>       DECLARE_AIE_MSG(map_host_buffer, MSG_OP_MAP_HOST_BUFFER);
>>       struct amdxdna_dev *xdna = ndev->aie.xdna;
>> +    size_t chunk_size;
>>       int ret;
>>   -    req.context_id = context_id;
>> -    req.buf_addr = addr;
>> -    req.buf_size = size;
>> -    ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
>> -    if (ret)
>> -        return ret;
>> +    chunk_size = xdna->dev_info->dev_mem_size;
>> +    if (!size || !IS_ALIGNED(size, chunk_size)) {
>> +        XDNA_ERR(xdna, "Invalid size 0x%llx for chunk 0x%lx",
>> +             size, chunk_size);
>> +        return -EINVAL;
>> +    }
>>   -    XDNA_DBG(xdna, "fw ctx %d map host buf addr 0x%llx size 0x%llx",
>> -         context_id, addr, size);
>> +    msg.opcode = initial_opcode;
>> +    do {
>> +        req.context_id = context_id;
>> +        req.buf_addr = addr;
>> +        req.buf_size = chunk_size;
>> +        ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
>> +        if (ret) {
>> +            XDNA_ERR(xdna, "fw ctx %d addr 0x%llx size 0x%lx",
>> +                 context_id, addr, chunk_size);
>> +            return ret;
>> +        }
>> +
>> +        XDNA_DBG(xdna, "fw ctx %d host buf op 0x%x addr 0x%llx size 
>> 0x%lx",
>> +             context_id, msg.opcode, addr, chunk_size);
>> +
>> +        addr += chunk_size;
>> +        size -= chunk_size;
>> +        msg.opcode = MSG_OP_ADD_HOST_BUFFER;
>> +    } while (size);
>>         return 0;
>>   }
>>   +int aie2_map_host_buf(struct amdxdna_dev_hdl *ndev, u32 
>> context_id, u64 addr, u64 size)
>> +{
>> +    return aie2_send_host_buf_msgs(ndev, context_id, addr, size,
>> +                       MSG_OP_MAP_HOST_BUFFER);
>> +}
>> +
>> +int aie2_add_host_buf(struct amdxdna_dev_hdl *ndev, u32 context_id, 
>> u64 addr, u64 size)
>> +{
>> +    if (!AIE_FEATURE_ON(&ndev->aie, AIE2_ADD_HOST_BUFFER))
>> +        return -EOPNOTSUPP;
>> +
>> +    return aie2_send_host_buf_msgs(ndev, context_id, addr, size,
>> +                       MSG_OP_ADD_HOST_BUFFER);
>> +}
>> +
>>   static int amdxdna_hwctx_col_map(struct amdxdna_hwctx *hwctx, void 
>> *arg)
>>   {
>>       u32 *bitmap = arg;
>> diff --git a/drivers/accel/amdxdna/aie2_msg_priv.h 
>> b/drivers/accel/amdxdna/aie2_msg_priv.h
>> index a41c9797e265..fd65a4236d49 100644
>> --- a/drivers/accel/amdxdna/aie2_msg_priv.h
>> +++ b/drivers/accel/amdxdna/aie2_msg_priv.h
>> @@ -33,6 +33,7 @@ enum aie2_msg_opcode {
>>       MSG_OP_REGISTER_ASYNC_EVENT_MSG    = 0x10C,
>>       MSG_OP_UPDATE_PROPERTY             = 0x113,
>>       MSG_OP_GET_APP_HEALTH              = 0x114,
>> +    MSG_OP_ADD_HOST_BUFFER             = 0x115,
>>       MSG_OP_GET_DEV_REVISION            = 0x117,
>>       MSG_OP_MAX_DRV_OPCODE,
>>       MSG_OP_GET_PROTOCOL_VERSION        = 0x301,
>> diff --git a/drivers/accel/amdxdna/aie2_pci.c 
>> b/drivers/accel/amdxdna/aie2_pci.c
>> index 6c8a0f70b73d..c4d345d4c76b 100644
>> --- a/drivers/accel/amdxdna/aie2_pci.c
>> +++ b/drivers/accel/amdxdna/aie2_pci.c
>> @@ -1241,4 +1241,5 @@ const struct amdxdna_dev_ops aie2_ops = {
>>       .hmm_invalidate = aie2_hmm_invalidate,
>>       .get_array = aie2_get_array,
>>       .get_dev_revision = aie2_get_dev_rev,
>> +    .hwctx_heap_expand = aie2_hwctx_heap_expand,
>>   };
>> diff --git a/drivers/accel/amdxdna/aie2_pci.h 
>> b/drivers/accel/amdxdna/aie2_pci.h
>> index 84bdb3f8b8f9..77648cc548b6 100644
>> --- a/drivers/accel/amdxdna/aie2_pci.h
>> +++ b/drivers/accel/amdxdna/aie2_pci.h
>> @@ -15,8 +15,9 @@
>>   #include "amdxdna_mailbox.h"
>>     /* Firmware determines device memory base address and size */
>> -#define AIE2_DEVM_BASE    0x4000000
>> -#define AIE2_DEVM_SIZE    SZ_64M
>> +#define AIE2_DEVM_BASE        0x4000000
>> +#define AIE2_DEVM_SIZE        SZ_64M
>> +#define AIE2_DEVM_MAX_SIZE    SZ_512M
>>     #define NDEV2PDEV(ndev) (to_pci_dev((ndev)->aie.xdna->ddev.dev))
>>   @@ -198,6 +199,7 @@ enum aie2_fw_feature {
>>       AIE2_PREEMPT,
>>       AIE2_TEMPORAL_ONLY,
>>       AIE2_APP_HEALTH,
>> +    AIE2_ADD_HOST_BUFFER,
>>       AIE2_UPDATE_PROPERTY,
>>       AIE2_GET_DEV_REVISION,
>>       AIE2_FEATURE_MAX
>> @@ -271,6 +273,7 @@ int aie2_get_dev_revision(struct amdxdna_dev_hdl 
>> *ndev, enum aie2_dev_revision *
>>   int aie2_create_context(struct amdxdna_dev_hdl *ndev, struct 
>> amdxdna_hwctx *hwctx);
>>   int aie2_destroy_context(struct amdxdna_dev_hdl *ndev, struct 
>> amdxdna_hwctx *hwctx);
>>   int aie2_map_host_buf(struct amdxdna_dev_hdl *ndev, u32 context_id, 
>> u64 addr, u64 size);
>> +int aie2_add_host_buf(struct amdxdna_dev_hdl *ndev, u32 context_id, 
>> u64 addr, u64 size);
>>   int aie2_query_status(struct amdxdna_dev_hdl *ndev, char __user 
>> *buf, u32 size, u32 *cols_filled);
>>   int aie2_query_telemetry(struct amdxdna_dev_hdl *ndev,
>>                char __user *buf, u32 size,
>> @@ -302,5 +305,6 @@ void aie2_hwctx_suspend(struct amdxdna_client 
>> *client);
>>   int aie2_hwctx_resume(struct amdxdna_client *client);
>>   int aie2_cmd_submit(struct amdxdna_hwctx *hwctx, struct 
>> amdxdna_sched_job *job, u64 *seq);
>>   void aie2_hmm_invalidate(struct amdxdna_gem_obj *abo, unsigned long 
>> cur_seq);
>> +int aie2_hwctx_heap_expand(struct amdxdna_hwctx *hwctx, struct 
>> amdxdna_gem_obj *heap);
>>     #endif /* _AIE2_PCI_H_ */
>> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c 
>> b/drivers/accel/amdxdna/amdxdna_ctx.c
>> index b79229a63af3..34466916a6ab 100644
>> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
>> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
>> @@ -61,16 +61,35 @@ static struct dma_fence 
>> *amdxdna_fence_create(struct amdxdna_hwctx *hwctx)
>>       return &fence->base;
>>   }
>>   +static void amdxdna_hwctx_release_expanded_heap(struct 
>> amdxdna_hwctx *hwctx)
>> +{
>> +    struct amdxdna_client *client = hwctx->client;
>> +    struct amdxdna_gem_obj *heap;
>> +    unsigned long heap_id;
>> +
>> +    mutex_lock(&client->mm_lock);
>> +    if (hwctx->last_attached_heap) {
>> +        xa_for_each_range(&client->dev_heap_xa, heap_id, heap, 1,
>> +                  hwctx->last_attached_heap) {
>> +            amdxdna_gem_unpin(heap);
>> +            drm_gem_object_put(to_gobj(heap));
>> +        }
>> +    }
>> +    mutex_unlock(&client->mm_lock);
>> +}
>> +
>>   static void amdxdna_hwctx_destroy_rcu(struct amdxdna_hwctx *hwctx,
>>                         struct srcu_struct *ss)
>>   {
>> -    struct amdxdna_dev *xdna = hwctx->client->xdna;
>> +    struct amdxdna_client *client = hwctx->client;
>> +    struct amdxdna_dev *xdna = client->xdna;
>>         synchronize_srcu(ss);
>>         /* At this point, user is not able to submit new commands */
>>       xdna->dev_info->ops->hwctx_fini(hwctx);
>>   +    amdxdna_hwctx_release_expanded_heap(hwctx);
>>       kfree(hwctx->name);
>>       kfree(hwctx);
>>   }
>> @@ -238,7 +257,7 @@ int amdxdna_drm_create_hwctx_ioctl(struct 
>> drm_device *dev, void *data, struct dr
>>       ret = xdna->dev_info->ops->hwctx_init(hwctx);
>>       if (ret) {
>>           XDNA_ERR(xdna, "Init hwctx failed, ret %d", ret);
>> -        goto dev_exit;
>> +        goto release_expanded_heap;
>>       }
>
> There's an existing issue here, Sahiko found it too.  You can't use 
> goto  with guard(mutex).  Because of how the guard() macro works you 
> break cleanups.  You either need to do the release with at __free 
> macro or cleanup in each path or switch away from guard.
Sure, Thanks. I will create a patch and fix this existing issue later.
>
>
>>         hwctx->name = kasprintf(GFP_KERNEL, "hwctx.%d.%d", 
>> client->pid, hwctx->fw_ctx_id);
>> @@ -269,7 +288,8 @@ int amdxdna_drm_create_hwctx_ioctl(struct 
>> drm_device *dev, void *data, struct dr
>>       kfree(hwctx->name);
>>   fini_hwctx:
>>       xdna->dev_info->ops->hwctx_fini(hwctx);
>> -dev_exit:
>> +release_expanded_heap:
>> +    amdxdna_hwctx_release_expanded_heap(hwctx);
>>       drm_dev_exit(idx);
>>   free_hwctx:
>>       kfree(hwctx);
>> @@ -407,6 +427,68 @@ int amdxdna_hwctx_sync_debug_bo(struct 
>> amdxdna_client *client, u32 debug_bo_hdl)
>>       return ret;
>>   }
>>   +static int amdxdna_hwctx_expand_heap(struct amdxdna_hwctx *hwctx)
>> +{
>> +    struct amdxdna_client *client = hwctx->client;
>> +    struct amdxdna_dev *xdna = client->xdna;
>> +    struct amdxdna_gem_obj *heap;
>> +    unsigned long heap_id, nid;
>> +    int ret = 0;
>> +
>> +    nid = hwctx->last_attached_heap + 1;
>> +    if (nid == client->dev_heap_nid)
>> +        goto out;
>> +
>> +    if (!xdna->dev_info->ops->hwctx_heap_expand) {
>> +        ret = -EOPNOTSUPP;
>> +        goto out;
>> +    }
>
> I would re-order these.
>
> If hwctx_heap_expand isn't available for the HW then the last attached 
> heap should never have been set right?
Agree. I will reorder when merging the patch.
>
>> +
>> +    xa_for_each_range(&client->dev_heap_xa, heap_id, heap,
>> +              nid, client->dev_heap_nid) {
>> +        drm_gem_object_get(to_gobj(heap));
>> +        ret = amdxdna_gem_pin(heap);
>> +        if (ret) {
>> +            drm_gem_object_put(to_gobj(heap));
>> +            break;
>> +        }
>> +
>> +        mutex_unlock(&client->mm_lock);
>> +        ret = xdna->dev_info->ops->hwctx_heap_expand(hwctx, heap);
>> +        mutex_lock(&client->mm_lock);
>> +        if (ret) {
>> +            amdxdna_gem_unpin(heap);
>> +            drm_gem_object_put(to_gobj(heap));
>> +            break;
>> +        }
>> +
>> +        hwctx->last_attached_heap = heap_id;
>> +    }
>> +
>> +out:
>> +    return ret;
>> +}
>> +
>> +int amdxdna_update_heap(struct amdxdna_client *client, struct 
>> amdxdna_hwctx *hwctx)
>> +{
>> +    unsigned long hwctx_id;
>> +    int ret;
>> +
>> +    if (hwctx) {
>> +        guard(mutex)(&client->mm_lock);
>
> Since both paths in this function use the guard, just uplevel it so 
> you only need it once.

Will fix when merging.


Thanks,

Lizhi

>
>> +        return amdxdna_hwctx_expand_heap(hwctx);
>> +    }
>> +
>> +    guard(mutex)(&client->mm_lock);
>> +    amdxdna_for_each_hwctx(client, hwctx_id, hwctx) {
>> +        ret = amdxdna_hwctx_expand_heap(hwctx);
>> +        if (ret)
>> +            return ret;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static void
>>   amdxdna_arg_bos_put(struct amdxdna_sched_job *job)
>>   {
>> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h 
>> b/drivers/accel/amdxdna/amdxdna_ctx.h
>> index 6e3c6371a088..aaae16430466 100644
>> --- a/drivers/accel/amdxdna/amdxdna_ctx.h
>> +++ b/drivers/accel/amdxdna/amdxdna_ctx.h
>> @@ -109,6 +109,7 @@ struct amdxdna_hwctx {
>>       u32                umq_bo_hdl;
>>       u32                doorbell_offset;
>>       u32                num_unused_col;
>> +    u32                last_attached_heap;
>>         struct amdxdna_qos_info             qos;
>>       struct amdxdna_hwctx_param_config_cu *cus;
>> @@ -205,6 +206,7 @@ void amdxdna_hwctx_remove_all(struct 
>> amdxdna_client *client);
>>   int amdxdna_hwctx_walk(struct amdxdna_client *client, void *arg,
>>                  int (*walk)(struct amdxdna_hwctx *hwctx, void *arg));
>>   int amdxdna_hwctx_sync_debug_bo(struct amdxdna_client *client, u32 
>> debug_bo_hdl);
>> +int amdxdna_update_heap(struct amdxdna_client *client, struct 
>> amdxdna_hwctx *hwctx);
>>     int amdxdna_cmd_submit(struct amdxdna_client *client,
>>                  struct amdxdna_drv_cmd *drv_cmd, u32 cmd_bo_hdls,
>> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c 
>> b/drivers/accel/amdxdna/amdxdna_gem.c
>> index 6087264ba1b5..97a521401a46 100644
>> --- a/drivers/accel/amdxdna/amdxdna_gem.c
>> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
>> @@ -24,6 +24,77 @@
>>     MODULE_IMPORT_NS("DMA_BUF");
>>   +/*
>> + * The dev BO could be across multiple heap BO chunks. The heap 
>> chunks should
>> + * be mapped to userspace and the userspace virtual address should be
>> + * contiguous.
>> + */
>> +static int
>> +amdxdna_init_dev_bo(struct amdxdna_gem_obj *dev_bo)
>> +{
>> +    struct amdxdna_client *client = dev_bo->client;
>> +    struct amdxdna_dev *xdna = client->xdna;
>> +    struct amdxdna_gem_obj *heap;
>> +    u64 heap_addr, exp_heap_uva;
>> +    u32 heap_id;
>> +
>> +    if (xa_empty(&client->dev_heap_xa)) {
>> +        XDNA_DBG(xdna, "Empty heap xa");
>> +        return -EAGAIN;
>> +    }
>> +
>> +    for (heap_id = 0; heap_id < client->dev_heap_nid; heap_id++) {
>> +        heap = xa_load(&client->dev_heap_xa, heap_id);
>> +        if (!heap) {
>> +            XDNA_ERR(xdna, "Failed to load heap %d", heap_id);
>> +            return -EINVAL;
>> +        }
>> +        heap_addr = amdxdna_gem_dev_addr(heap);
>> +        if (heap_addr > dev_bo->mm_node.start)
>> +            break;
>> +    }
>> +
>> +    heap_id--;
>> +    heap = xa_load(&client->dev_heap_xa, heap_id);
>> +    exp_heap_uva = amdxdna_gem_uva(heap);
>> +    heap_addr = amdxdna_gem_dev_addr(heap);
>> +    dev_bo->heap_start_id = heap_id;
>> +    dev_bo->mem.uva = dev_bo->mm_node.start - heap_addr + exp_heap_uva;
>> +
>> +    for (; heap_id < client->dev_heap_nid; heap_id++) {
>> +        heap = xa_load(&client->dev_heap_xa, heap_id);
>> +        if (!heap) {
>> +            XDNA_ERR(xdna, "Failed to load heap %d", heap_id);
>> +            return -EINVAL;
>> +        }
>> +        heap_addr = amdxdna_gem_uva(heap);
>> +        if (heap_addr == AMDXDNA_INVALID_ADDR) {
>> +            XDNA_ERR(xdna, "Heap %d is not mapped", heap_id);
>> +            return -EAGAIN;
>> +        }
>> +
>> +        if (heap_addr != exp_heap_uva) {
>> +            XDNA_ERR(xdna, "Heap %d uva is not contiguous", heap_id);
>> +            return -EINVAL;
>> +        }
>> +
>> +        if (heap->dev_addr + heap->mem.size >=
>> +            dev_bo->mm_node.start + dev_bo->mem.size)
>> +            break;
>> +
>> +        exp_heap_uva += heap->mem.size;
>> +    }
>> +
>> +    if (heap_id == client->dev_heap_nid) {
>> +        XDNA_DBG(xdna, "Can not find heap end");
>> +        return -EAGAIN;
>> +    }
>> +
>> +    dev_bo->heap_end_id = heap_id;
>> +
>> +    return 0;
>> +}
>> +
>>   static int
>>   amdxdna_gem_heap_alloc(struct amdxdna_gem_obj *abo)
>>   {
>> @@ -31,32 +102,22 @@ amdxdna_gem_heap_alloc(struct amdxdna_gem_obj *abo)
>>       struct amdxdna_dev *xdna = client->xdna;
>>       struct amdxdna_mem *mem = &abo->mem;
>>       struct amdxdna_gem_obj *heap;
>> +    unsigned long heap_id;
>>       u32 align;
>>       int ret;
>>         mutex_lock(&client->mm_lock);
>>   -    heap = client->dev_heap;
>> -    if (!heap) {
>> -        ret = -EINVAL;
>> -        goto unlock_out;
>> -    }
>> -
>> -    if (amdxdna_gem_uva(heap) == AMDXDNA_INVALID_ADDR) {
>> -        XDNA_ERR(xdna, "Invalid dev heap userptr");
>> -        ret = -EINVAL;
>> -        goto unlock_out;
>> -    }
>> -
>> -    if (mem->size == 0 || mem->size > heap->mem.size) {
>> -        XDNA_ERR(xdna, "Invalid dev bo size 0x%lx, limit 0x%lx",
>> -             mem->size, heap->mem.size);
>> +    if (!mem->size || mem->size > xdna->dev_info->dev_heap_max_size) {
>> +        XDNA_ERR(xdna, "Invalid dev bo size 0x%lx, max heap 0x%lx",
>> +             mem->size, xdna->dev_info->dev_heap_max_size);
>>           ret = -EINVAL;
>>           goto unlock_out;
>>       }
>>         align = 1 << max(PAGE_SHIFT, xdna->dev_info->dev_mem_buf_shift);
>> -    ret = drm_mm_insert_node_generic(&heap->mm, &abo->mm_node,
>> +    ret = drm_mm_insert_node_generic(&client->dev_heap_mm,
>> +                     &abo->mm_node,
>>                        mem->size, align,
>>                        0, DRM_MM_INSERT_BEST);
>>       if (ret) {
>> @@ -64,9 +125,16 @@ amdxdna_gem_heap_alloc(struct amdxdna_gem_obj *abo)
>>           goto unlock_out;
>>       }
>>   -    client->heap_usage += mem->size;
>> +    ret = amdxdna_init_dev_bo(abo);
>> +    if (ret) {
>> +        drm_mm_remove_node(&abo->mm_node);
>> +        goto unlock_out;
>> +    }
>>   -    drm_gem_object_get(to_gobj(heap));
>> +    client->heap_usage += mem->size;
>> +    xa_for_each_range(&client->dev_heap_xa, heap_id, heap,
>> +              abo->heap_start_id, abo->heap_end_id)
>> +        drm_gem_object_get(to_gobj(heap));
>>     unlock_out:
>>       mutex_unlock(&client->mm_lock);
>> @@ -79,13 +147,16 @@ amdxdna_gem_heap_free(struct amdxdna_gem_obj *abo)
>>   {
>>       struct amdxdna_client *client = abo->client;
>>       struct amdxdna_gem_obj *heap;
>> +    unsigned long heap_id;
>>         mutex_lock(&client->mm_lock);
>>         drm_mm_remove_node(&abo->mm_node);
>>       client->heap_usage -= abo->mem.size;
>> -    heap = client->dev_heap;
>> -    drm_gem_object_put(to_gobj(heap));
>> +
>> +    xa_for_each_range(&client->dev_heap_xa, heap_id, heap,
>> +              abo->heap_start_id, abo->heap_end_id)
>> +        drm_gem_object_put(to_gobj(heap));
>>         mutex_unlock(&client->mm_lock);
>>   }
>> @@ -161,31 +232,13 @@ static void amdxdna_gem_vunmap(struct 
>> amdxdna_gem_obj *abo)
>>       }
>>   }
>>   -/*
>> - * Obtain the user virtual address for accessing the BO.
>> - * It can be used for device to access the BO when PASID is enabled.
>> - */
>> -u64 amdxdna_gem_uva(struct amdxdna_gem_obj *abo)
>> -{
>> -    if (abo->type == AMDXDNA_BO_DEV) {
>> -        struct amdxdna_gem_obj *heap = abo->client->dev_heap;
>> -        u64 off = amdxdna_dev_bo_offset(abo);
>> -
>> -        if (amdxdna_gem_uva(heap) != AMDXDNA_INVALID_ADDR)
>> -            return amdxdna_gem_uva(heap) + off;
>> -        return AMDXDNA_INVALID_ADDR;
>> -    }
>> -
>> -    return abo->mem.uva;
>> -}
>> -
>>   /*
>>    * Obtain the address for device to access the BO.
>>    */
>>   u64 amdxdna_gem_dev_addr(struct amdxdna_gem_obj *abo)
>>   {
>>       if (abo->type == AMDXDNA_BO_DEV_HEAP)
>> -        return abo->client->xdna->dev_info->dev_mem_base;
>> +        return abo->dev_addr;
>>       if (abo->type == AMDXDNA_BO_DEV)
>>           return abo->mm_node.start;
>>       return amdxdna_obj_dma_addr(abo);
>> @@ -569,9 +622,6 @@ static void amdxdna_gem_obj_free(struct 
>> drm_gem_object *gobj)
>>       if (abo->pinned)
>>           amdxdna_gem_unpin(abo);
>>   -    if (abo->type == AMDXDNA_BO_DEV_HEAP)
>> -        drm_mm_takedown(&abo->mm);
>> -
>>       amdxdna_dma_unmap_bo(xdna, abo);
>>       amdxdna_gem_vunmap(abo);
>>       mutex_destroy(&abo->lock);
>> @@ -657,11 +707,23 @@ static void amdxdna_gem_obj_vunmap(struct 
>> drm_gem_object *obj, struct iosys_map
>>   static int amdxdna_gem_dev_obj_vmap(struct drm_gem_object *obj, 
>> struct iosys_map *map)
>>   {
>>       struct amdxdna_gem_obj *abo = to_xdna_obj(obj);
>> -    void *base = amdxdna_gem_vmap(abo->client->dev_heap);
>> -    u64 offset = amdxdna_dev_bo_offset(abo);
>> +    struct amdxdna_gem_obj *heap;
>> +    void *base;
>> +    u64 offset;
>> +
>> +    /* vmap dev bo which is across more than 1 heap is not allowed */
>> +    if (abo->heap_start_id != abo->heap_end_id)
>> +        return -ENOMEM;
>>   +    heap = xa_load(&abo->client->dev_heap_xa, abo->heap_start_id);
>> +    if (!heap)
>> +        return -ENOMEM;
>> +
>> +    base = amdxdna_gem_vmap(heap);
>>       if (!base)
>>           return -ENOMEM;
>> +
>> +    offset = amdxdna_gem_dev_addr(abo) - amdxdna_gem_dev_addr(heap);
>>       iosys_map_set_vaddr(map, base + offset);
>>       return 0;
>>   }
>> @@ -880,15 +942,25 @@ amdxdna_drm_create_dev_heap_bo(struct 
>> drm_device *dev,
>>       /* Set up heap for this client. */
>>       mutex_lock(&client->mm_lock);
>>   -    if (client->dev_heap) {
>> -        XDNA_DBG(client->xdna, "dev heap is already created");
>> -        ret = -EBUSY;
>> +    if (client->total_heap_size + abo->mem.size >
>> +        xdna->dev_info->dev_heap_max_size) {
>> +        XDNA_ERR(xdna, "Heap size 0x%lx + 0x%lx exceeds max 0x%lx",
>> +             client->total_heap_size, abo->mem.size,
>> +             xdna->dev_info->dev_heap_max_size);
>> +        ret = -ENOSPC;
>>           goto mm_unlock;
>>       }
>> -    client->dev_heap = abo;
>> -    drm_gem_object_get(to_gobj(abo));
>>   -    drm_mm_init(&abo->mm, xdna->dev_info->dev_mem_base, 
>> abo->mem.size);
>> +    ret = xa_insert(&client->dev_heap_xa, client->dev_heap_nid, abo, 
>> GFP_KERNEL);
>> +    if (ret) {
>> +        XDNA_ERR(xdna, "Add heap failed %d", ret);
>> +        goto mm_unlock;
>> +    }
>> +
>> +    abo->dev_addr = xdna->dev_info->dev_mem_base + 
>> client->total_heap_size;
>> +    client->total_heap_size += abo->mem.size;
>> +    client->dev_heap_nid++;
>> +    drm_gem_object_get(to_gobj(abo));
>>         mutex_unlock(&client->mm_lock);
>>   @@ -931,10 +1003,10 @@ amdxdna_drm_create_dev_bo(struct drm_device 
>> *dev,
>>         ret = amdxdna_gem_heap_alloc(abo);
>>       if (ret) {
>> -        XDNA_ERR(xdna, "Failed to alloc dev bo memory, ret %d", ret);
>>           amdxdna_gem_destroy_obj(abo);
>>           return ERR_PTR(ret);
>>       }
>> +
>>       drm_gem_private_object_init(dev, gobj, aligned_sz);
>>         return abo;
>> @@ -942,6 +1014,7 @@ amdxdna_drm_create_dev_bo(struct drm_device *dev,
>>     int amdxdna_drm_create_bo_ioctl(struct drm_device *dev, void 
>> *data, struct drm_file *filp)
>>   {
>> +    struct amdxdna_client *client = filp->driver_priv;
>>       struct amdxdna_dev *xdna = to_xdna_dev(dev);
>>       struct amdxdna_drm_create_bo *args = data;
>>       struct amdxdna_gem_obj *abo;
>> @@ -962,6 +1035,13 @@ int amdxdna_drm_create_bo_ioctl(struct 
>> drm_device *dev, void *data, struct drm_f
>>           break;
>>       case AMDXDNA_BO_DEV:
>>           abo = amdxdna_drm_create_dev_bo(dev, args, filp);
>> +        if (!IS_ERR(abo)) {
>> +            mutex_lock(&xdna->dev_lock);
>> +            ret = amdxdna_update_heap(client, NULL);
>> +            mutex_unlock(&xdna->dev_lock);
>> +            if (ret)
>> +                goto put_obj;
>> +        }
>>           break;
>>       default:
>>           return -EINVAL;
>> @@ -985,14 +1065,11 @@ int amdxdna_drm_create_bo_ioctl(struct 
>> drm_device *dev, void *data, struct drm_f
>>       return ret;
>>   }
>>   -int amdxdna_gem_pin_nolock(struct amdxdna_gem_obj *abo)
>> +static int amdxdna_bo_pin(struct amdxdna_gem_obj *abo)
>>   {
>>       struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
>>       int ret;
>>   -    if (abo->type == AMDXDNA_BO_DEV)
>> -        abo = abo->client->dev_heap;
>> -
>>       if (is_import_bo(abo))
>>           return 0;
>>   @@ -1002,6 +1079,45 @@ int amdxdna_gem_pin_nolock(struct 
>> amdxdna_gem_obj *abo)
>>       return ret;
>>   }
>>   +static void amdxdna_bo_unpin(struct amdxdna_gem_obj *abo)
>> +{
>> +    struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
>> +
>> +    if (is_import_bo(abo))
>> +        return;
>> +
>> +    drm_gem_shmem_unpin(&abo->base);
>> +
>> +    XDNA_DBG(xdna, "BO type %d", abo->type);
>> +}
>> +
>> +int amdxdna_gem_pin_nolock(struct amdxdna_gem_obj *abo)
>> +{
>> +    struct amdxdna_client *client = abo->client;
>> +    struct amdxdna_gem_obj *heap;
>> +    unsigned long heap_id, last = ULONG_MAX;
>> +    int ret = 0;
>> +
>> +    if (abo->type != AMDXDNA_BO_DEV)
>> +        return amdxdna_bo_pin(abo);
>> +
>> +    xa_for_each_range(&client->dev_heap_xa, heap_id, heap,
>> +              abo->heap_start_id, abo->heap_end_id) {
>> +        ret = amdxdna_bo_pin(heap);
>> +        if (ret)
>> +            break;
>> +        last = heap_id;
>> +    }
>> +
>> +    if (ret && last <= abo->heap_end_id) {
>> +        xa_for_each_range(&client->dev_heap_xa, heap_id, heap,
>> +                  abo->heap_start_id, last)
>> +            amdxdna_bo_unpin(heap);
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>>   int amdxdna_gem_pin(struct amdxdna_gem_obj *abo)
>>   {
>>       int ret;
>> @@ -1015,14 +1131,18 @@ int amdxdna_gem_pin(struct amdxdna_gem_obj *abo)
>>     void amdxdna_gem_unpin(struct amdxdna_gem_obj *abo)
>>   {
>> -    if (abo->type == AMDXDNA_BO_DEV)
>> -        abo = abo->client->dev_heap;
>> +    mutex_lock(&abo->lock);
>> +    if (abo->type == AMDXDNA_BO_DEV) {
>> +        struct amdxdna_gem_obj *heap;
>> +        unsigned long heap_id;
>>   -    if (is_import_bo(abo))
>> -        return;
>> +        xa_for_each_range(&abo->client->dev_heap_xa, heap_id, heap,
>> +                  abo->heap_start_id, abo->heap_end_id)
>> +            amdxdna_bo_unpin(heap);
>> +    } else {
>> +        amdxdna_bo_unpin(abo);
>> +    }
>>   -    mutex_lock(&abo->lock);
>> -    drm_gem_shmem_unpin(&abo->base);
>>       mutex_unlock(&abo->lock);
>>   }
>>   @@ -1079,6 +1199,29 @@ int amdxdna_drm_get_bo_info_ioctl(struct 
>> drm_device *dev, void *data, struct drm
>>       return ret;
>>   }
>>   +static int amdxdna_flush_bo(struct amdxdna_gem_obj *abo, u64 
>> offset, u64 size)
>> +{
>> +    u64 end;
>> +
>> +    if (offset >= abo->mem.size)
>> +        return -EINVAL;
>> +
>> +    if (check_add_overflow(offset, size, &end))
>> +        return -EINVAL;
>> +
>> +    size = min(abo->mem.size, end) - offset;
>> +    if (is_import_bo(abo))
>> +        drm_clflush_sg(abo->base.sgt);
>> +    else if (amdxdna_gem_vmap(abo))
>> +        drm_clflush_virt_range(amdxdna_gem_vmap(abo) + offset, size);
>> +    else if (abo->base.pages)
>> +        drm_clflush_pages(abo->base.pages, abo->mem.size >> 
>> PAGE_SHIFT);
>> +    else
>> +        return -EINVAL;
>> +
>> +    return 0;
>> +}
>> +
>>   /*
>>    * The sync bo ioctl is to make sure the CPU cache is in sync with 
>> memory.
>>    * This is required because NPU is not cache coherent device. CPU 
>> cache
>> @@ -1089,11 +1232,12 @@ int amdxdna_drm_get_bo_info_ioctl(struct 
>> drm_device *dev, void *data, struct drm
>>   int amdxdna_drm_sync_bo_ioctl(struct drm_device *dev,
>>                     void *data, struct drm_file *filp)
>>   {
>> +    struct amdxdna_client *client = filp->driver_priv;
>>       struct amdxdna_dev *xdna = to_xdna_dev(dev);
>>       struct amdxdna_drm_sync_bo *args = data;
>>       struct amdxdna_gem_obj *abo;
>>       struct drm_gem_object *gobj;
>> -    int ret;
>> +    int ret = 0;
>>         gobj = drm_gem_object_lookup(filp, args->handle);
>>       if (!gobj) {
>> @@ -1102,22 +1246,45 @@ int amdxdna_drm_sync_bo_ioctl(struct 
>> drm_device *dev,
>>       }
>>       abo = to_xdna_obj(gobj);
>>   -    ret = amdxdna_gem_pin(abo);
>> -    if (ret) {
>> -        XDNA_ERR(xdna, "Pin BO %d failed, ret %d", args->handle, ret);
>> -        goto put_obj;
>> -    }
>> +    if (abo->type == AMDXDNA_BO_DEV) {
>> +        struct amdxdna_gem_obj *heap;
>> +        unsigned long heap_id;
>> +        u64 bo_start = amdxdna_gem_dev_addr(abo);
>> +        u64 flush_start = bo_start + args->offset;
>> +        u64 flush_end = flush_start + args->size;
>> +
>> +        xa_for_each_range(&client->dev_heap_xa, heap_id, heap,
>> +                  abo->heap_start_id, abo->heap_end_id) {
>> +            u64 heap_start = amdxdna_gem_dev_addr(heap);
>> +            u64 heap_end = heap_start + heap->mem.size;
>> +            u64 start = max(flush_start, heap_start);
>> +            u64 end = min(flush_end, heap_end);
>> +
>> +            if (start >= end)
>> +                continue;
>> +
>> +            ret = amdxdna_flush_bo(heap, start - heap_start, end - 
>> start);
>> +            if (ret) {
>> +                XDNA_ERR(xdna, "Failed to flush heap %ld ret %d",
>> +                     heap_id, ret);
>> +                goto put_obj;
>> +            }
>> +        }
>> +    } else {
>> +        ret = amdxdna_gem_pin(abo);
>> +        if (ret) {
>> +            XDNA_ERR(xdna, "Pin BO %d failed, ret %d", args->handle, 
>> ret);
>> +            goto put_obj;
>> +        }
>>   -    if (is_import_bo(abo))
>> -        drm_clflush_sg(abo->base.sgt);
>> -    else if (amdxdna_gem_vmap(abo))
>> -        drm_clflush_virt_range(amdxdna_gem_vmap(abo) + args->offset, 
>> args->size);
>> -    else if (abo->base.pages)
>> -        drm_clflush_pages(abo->base.pages, gobj->size >> PAGE_SHIFT);
>> -    else
>> -        drm_WARN(&xdna->ddev, 1, "Can not get flush memory");
>> +        ret = amdxdna_flush_bo(abo, args->offset, args->size);
>> +        amdxdna_gem_unpin(abo);
>>   -    amdxdna_gem_unpin(abo);
>> +        if (ret) {
>> +            drm_WARN(&xdna->ddev, 1, "Can not get flush memory");
>> +            goto put_obj;
>> +        }
>> +    }
>>         XDNA_DBG(xdna, "Sync bo %d offset 0x%llx, size 0x%llx\n",
>>            args->handle, args->offset, args->size);
>> diff --git a/drivers/accel/amdxdna/amdxdna_gem.h 
>> b/drivers/accel/amdxdna/amdxdna_gem.h
>> index 162e5499f5e0..ffdb18395a54 100644
>> --- a/drivers/accel/amdxdna/amdxdna_gem.h
>> +++ b/drivers/accel/amdxdna/amdxdna_gem.h
>> @@ -46,8 +46,10 @@ struct amdxdna_gem_obj {
>>       int                open_ref;
>>         /* Below members are initialized when needed */
>> -    struct drm_mm            mm; /* For AMDXDNA_BO_DEV_HEAP */
>>       struct drm_mm_node        mm_node; /* For AMDXDNA_BO_DEV */
>> +    u32                heap_start_id;
>> +    u32                heap_end_id;
>> +    u64                dev_addr; /* For heap bo */
>>       u32                assigned_hwctx;
>>       struct dma_buf            *dma_buf;
>>       struct dma_buf_attachment    *attach;
>> @@ -73,13 +75,21 @@ static inline void amdxdna_gem_put_obj(struct 
>> amdxdna_gem_obj *abo)
>>       drm_gem_object_put(to_gobj(abo));
>>   }
>>   +/*
>> + * Obtain the user virtual address for accessing the BO.
>> + * It can be used for device to access the BO when PASID is enabled.
>> + */
>> +static inline u64 amdxdna_gem_uva(struct amdxdna_gem_obj *abo)
>> +{
>> +    return abo->mem.uva;
>> +}
>> +
>>   void *amdxdna_gem_vmap(struct amdxdna_gem_obj *abo);
>> -u64 amdxdna_gem_uva(struct amdxdna_gem_obj *abo);
>>   u64 amdxdna_gem_dev_addr(struct amdxdna_gem_obj *abo);
>>     static inline u64 amdxdna_dev_bo_offset(struct amdxdna_gem_obj *abo)
>>   {
>> -    return amdxdna_gem_dev_addr(abo) - 
>> amdxdna_gem_dev_addr(abo->client->dev_heap);
>> +    return amdxdna_gem_dev_addr(abo) - 
>> abo->client->xdna->dev_info->dev_mem_base;
>>   }
>>     static inline u64 amdxdna_obj_dma_addr(struct amdxdna_gem_obj *abo)
>> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c 
>> b/drivers/accel/amdxdna/amdxdna_pci_drv.c
>> index a6e9be7960c2..c677293c1ae7 100644
>> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
>> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
>> @@ -126,6 +126,9 @@ static int amdxdna_drm_open(struct drm_device 
>> *ddev, struct drm_file *filp)
>>       mmgrab(client->mm);
>>       init_srcu_struct(&client->hwctx_srcu);
>>       xa_init_flags(&client->hwctx_xa, XA_FLAGS_ALLOC);
>> +    xa_init_flags(&client->dev_heap_xa, XA_FLAGS_ALLOC);
>> +    drm_mm_init(&client->dev_heap_mm, xdna->dev_info->dev_mem_base,
>> +            xdna->dev_info->dev_heap_max_size);
>>       mutex_init(&client->mm_lock);
>>         mutex_lock(&xdna->dev_lock);
>> @@ -141,13 +144,18 @@ static int amdxdna_drm_open(struct drm_device 
>> *ddev, struct drm_file *filp)
>>     static void amdxdna_client_cleanup(struct amdxdna_client *client)
>>   {
>> +    struct amdxdna_gem_obj *heap;
>> +    unsigned long heap_id;
>> +
>>       list_del(&client->node);
>>       amdxdna_hwctx_remove_all(client);
>>       xa_destroy(&client->hwctx_xa);
>>       cleanup_srcu_struct(&client->hwctx_srcu);
>>   -    if (client->dev_heap)
>> -        drm_gem_object_put(to_gobj(client->dev_heap));
>> +    xa_for_each(&client->dev_heap_xa, heap_id, heap)
>> +        drm_gem_object_put(to_gobj(heap));
>> +    xa_destroy(&client->dev_heap_xa);
>> +    drm_mm_takedown(&client->dev_heap_mm);
>>         mutex_destroy(&client->mm_lock);
>>       mmdrop(client->mm);
>> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h 
>> b/drivers/accel/amdxdna/amdxdna_pci_drv.h
>> index 471b72299aee..34271c14d359 100644
>> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
>> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
>> @@ -7,6 +7,7 @@
>>   #define _AMDXDNA_PCI_DRV_H_
>>     #include <drm/amdxdna_accel.h>
>> +#include <drm/drm_mm.h>
>>   #include <drm/drm_print.h>
>>   #include <linux/iommu.h>
>>   #include <linux/iova.h>
>> @@ -61,6 +62,7 @@ struct amdxdna_dev_ops {
>>       void (*hwctx_fini)(struct amdxdna_hwctx *hwctx);
>>       int (*hwctx_config)(struct amdxdna_hwctx *hwctx, u32 type, u64 
>> value, void *buf, u32 size);
>>       int (*hwctx_sync_debug_bo)(struct amdxdna_hwctx *hwctx, u32 
>> debug_bo_hdl);
>> +    int (*hwctx_heap_expand)(struct amdxdna_hwctx *hwctx, struct 
>> amdxdna_gem_obj *heap);
>>       void (*hmm_invalidate)(struct amdxdna_gem_obj *abo, unsigned 
>> long cur_seq);
>>       int (*cmd_submit)(struct amdxdna_hwctx *hwctx, struct 
>> amdxdna_sched_job *job, u64 *seq);
>>       int (*cmd_wait)(struct amdxdna_hwctx *hwctx, u64 seq, u32 
>> timeout);
>> @@ -95,6 +97,7 @@ struct amdxdna_dev_info {
>>       size_t                dev_mem_size;
>>       const char            *default_vbnv;
>>       const struct amdxdna_rev_vbnv    *rev_vbnv_tbl;
>> +    size_t                dev_heap_max_size;
>>       const struct amdxdna_dev_priv    *dev_priv;
>>       const struct amdxdna_fw_feature_tbl *fw_feature_tbl;
>>       const struct amdxdna_dev_ops    *ops;
>> @@ -153,7 +156,10 @@ struct amdxdna_client {
>>       struct drm_file            *filp;
>>         struct mutex            mm_lock; /* protect memory related */
>> -    struct amdxdna_gem_obj        *dev_heap;
>> +    struct xarray            dev_heap_xa;
>> +    struct drm_mm            dev_heap_mm;
>> +    u32                dev_heap_nid;
>> +    size_t                total_heap_size;
>>         struct iommu_sva        *sva;
>>       int                pasid;
>> diff --git a/drivers/accel/amdxdna/npu1_regs.c 
>> b/drivers/accel/amdxdna/npu1_regs.c
>> index 4e48c030a69f..ca779674017a 100644
>> --- a/drivers/accel/amdxdna/npu1_regs.c
>> +++ b/drivers/accel/amdxdna/npu1_regs.c
>> @@ -139,6 +139,7 @@ const struct amdxdna_dev_info dev_npu1_info = {
>>       .dev_mem_base      = AIE2_DEVM_BASE,
>>       .dev_mem_size      = AIE2_DEVM_SIZE,
>>       .default_vbnv      = "RyzenAI-npu1",
>> +    .dev_heap_max_size = AIE2_DEVM_SIZE,
>>       .device_type       = AMDXDNA_DEV_TYPE_KMQ,
>>       .dev_priv          = &npu1_dev_priv,
>>       .fw_feature_tbl    = npu1_fw_feature_table,
>> diff --git a/drivers/accel/amdxdna/npu4_regs.c 
>> b/drivers/accel/amdxdna/npu4_regs.c
>> index eddc31803a50..15a161384625 100644
>> --- a/drivers/accel/amdxdna/npu4_regs.c
>> +++ b/drivers/accel/amdxdna/npu4_regs.c
>> @@ -98,6 +98,7 @@ const struct amdxdna_fw_feature_tbl 
>> npu4_fw_feature_table[] = {
>>       { .features = BIT_U64(AIE2_NPU_COMMAND), .major = 6, .min_minor 
>> = 15 },
>>       { .features = BIT_U64(AIE2_UPDATE_PROPERTY), .major = 6, 
>> .min_minor = 15 },
>>       { .features = BIT_U64(AIE2_APP_HEALTH), .major = 6, .min_minor 
>> = 18 },
>> +    { .features = BIT_U64(AIE2_ADD_HOST_BUFFER), .major = 6, 
>> .min_minor = 18 },
>>       { .features = BIT_U64(AIE2_GET_DEV_REVISION), .major = 6, 
>> .min_minor = 24 },
>>       { .features = AIE2_ALL_FEATURES, .major = 7 },
>>       { 0 }
>> @@ -200,6 +201,7 @@ const struct amdxdna_dev_info dev_npu4_info = {
>>       .dev_mem_base      = AIE2_DEVM_BASE,
>>       .dev_mem_size      = AIE2_DEVM_SIZE,
>>       .default_vbnv      = "RyzenAI-npu4",
>> +    .dev_heap_max_size = AIE2_DEVM_MAX_SIZE,
>>       .device_type       = AMDXDNA_DEV_TYPE_KMQ,
>>       .rev_vbnv_tbl      = npu4_rev_vbnv_tbl,
>>       .dev_priv          = &npu4_dev_priv,
>> diff --git a/drivers/accel/amdxdna/npu5_regs.c 
>> b/drivers/accel/amdxdna/npu5_regs.c
>> index a9102978e4a8..306b359d0cd3 100644
>> --- a/drivers/accel/amdxdna/npu5_regs.c
>> +++ b/drivers/accel/amdxdna/npu5_regs.c
>> @@ -107,6 +107,7 @@ const struct amdxdna_dev_info dev_npu5_info = {
>>       .dev_mem_base      = AIE2_DEVM_BASE,
>>       .dev_mem_size      = AIE2_DEVM_SIZE,
>>       .default_vbnv      = "RyzenAI-npu5",
>> +    .dev_heap_max_size = AIE2_DEVM_MAX_SIZE,
>>       .device_type       = AMDXDNA_DEV_TYPE_KMQ,
>>       .rev_vbnv_tbl      = npu4_rev_vbnv_tbl,
>>       .dev_priv          = &npu5_dev_priv,
>> diff --git a/drivers/accel/amdxdna/npu6_regs.c 
>> b/drivers/accel/amdxdna/npu6_regs.c
>> index e0db3a09740b..e68637d2a228 100644
>> --- a/drivers/accel/amdxdna/npu6_regs.c
>> +++ b/drivers/accel/amdxdna/npu6_regs.c
>> @@ -108,6 +108,7 @@ const struct amdxdna_dev_info dev_npu6_info = {
>>       .dev_mem_base      = AIE2_DEVM_BASE,
>>       .dev_mem_size      = AIE2_DEVM_SIZE,
>>       .default_vbnv      = "RyzenAI-npu6",
>> +    .dev_heap_max_size = AIE2_DEVM_MAX_SIZE,
>>       .device_type       = AMDXDNA_DEV_TYPE_KMQ,
>>       .rev_vbnv_tbl      = npu4_rev_vbnv_tbl,
>>       .dev_priv          = &npu6_dev_priv,
>
