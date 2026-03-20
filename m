Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B781099B37
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 20:56:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA55310EB14;
	Fri, 20 Mar 2026 20:56:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oY5BFNpn";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011054.outbound.protection.outlook.com [40.107.208.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30F4710EB14
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 20:56:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BDsvraktdttP/1EDnGCl3IlxvpJ2eDkAL5d6RTkomLiUhP03VJhRbEp2j5phDv/lL7olhqab5G/HnW4AKxPReG1VRiNCaPclWVUaMaC0SwXVvdrOU+j+GfKv8qUN6iDiaogI2+slIis+5yP2KnnGx+PBx0NrrLdtRAkuL3SNpKjecHfa0inYoviKRYft5LrUbONKvf8D53oRhl9xG57NMg8T/y/pbpWQEWtOd2BMPuIymNpJbAhlPq7JeozlO7TGQW62WqKBPxIcTYLn1ohOSndweSvP60b6rfOmFfvBYdVzMHhYNexudlKvNsRHlBVAmUBuSqsjxu3W/hH5+Qy0WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9zK7Mz3ntnCMz6xerJ0c3E/ZJkeFc8bUX84LLZzSjI=;
 b=wZZLR229FjIefBo/CwSIMMZeNRWAw4IYAwVVTeMdE2wVQeytz2otNhzgsSoXc5A3KyyNTA4kpfzhwUXzj0BktRUXsQLlONJ8/4lK8/0yZS7+PijbHR8U6X/KzFxFsDv+gYeUWgtiU/mUThJJ9vXfnHkvoxgxFiCRNG7q70rf8OohidcsqxGNjaodzd4LctoSP66nY0YFS2S3va3GqNWzE/jbZfk92px2hfnLF1tlhJqRtL/eTnCFQAurfN7erHXUIubrkmO5mteAijAwCpIFupPOuIf0SnezXuaDN4phg4tvd9vx4In6QI8llriqukV9ZVD4bJp3djl9ycewuMMPwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9zK7Mz3ntnCMz6xerJ0c3E/ZJkeFc8bUX84LLZzSjI=;
 b=oY5BFNpnk9OqtRGtyJ0Q7qWc3KX2bVxRJjzs+DlHggLJoZZTj+oy21E8UjnfBinyyWEKC9ho7h32k0+32hgRBUJX1dZcBDSCgAR2h/9VnRtfyDb7w2qZ1NSzzKtWNLNfyYhVkMvq5ovxFFwSPoSSN5KUMc1+aq1aPR5ySWVNeSA=
Received: from SA0PR13CA0029.namprd13.prod.outlook.com (2603:10b6:806:130::34)
 by CH1PPFC908D89D1.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::623) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 20:56:35 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:806:130:cafe::e0) by SA0PR13CA0029.outlook.office365.com
 (2603:10b6:806:130::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.20 via Frontend Transport; Fri,
 20 Mar 2026 20:56:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 20:56:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 20 Mar
 2026 15:56:34 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Mar
 2026 15:56:34 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 20 Mar 2026 15:56:33 -0500
Message-ID: <ed04586d-a81a-3afa-338e-96e4da3a9e71@amd.com>
Date: Fri, 20 Mar 2026 13:56:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Refactor GEM BO handling and add helper
 APIs for address retrieval
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <maciej.falkowski@linux.intel.com>
CC: Max Zhen <max.zhen@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>
References: <20260318155821.1690255-1-lizhi.hou@amd.com>
 <711e2017-fec9-4fae-a956-ed2b2176eb51@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <711e2017-fec9-4fae-a956-ed2b2176eb51@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|CH1PPFC908D89D1:EE_
X-MS-Office365-Filtering-Correlation-Id: 62a2ed4e-30b4-4838-6ca9-08de86c32c26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2YOd38eowsxfpa29D30VUI0OYU/v7nhtzi6+acT8lSzVM0wDUdKHOMjWiDz1GjgxbO3GP8TNARW9XhsWDxuqnUH0nZM4oRMPLFcAxcCCUmsTZEeirJCvEvGiVjX0vMfrjOgb+zXrpLM1DRd5+35GWKZnVMUNjII2dxzTjoCgu2qM7p84ZZF+UsLEmWse43hUwNbYipF5ymt1oqpG1d6bOQ1xlv2hiB77Mt3uhwLyDaLKZ6tYStZfQ8JpLu69lWYc2ywbzIZCkeZ0OT5TqDrrEj9L0kaxZ7JbZTIkXNG/o49VqlpTpvR22tx2HI9/dhrqXFPwfP+AUfRi31uz3sl8UIcCwJchFAKQvsE/DRQTGlJNQgfY0lbDh2mgk+JYeFFIqVv9kInRN3l9YonaxYBmPaoJTOeCDJzvMJY65RyoEgCDW2RwtgH/vLXSAQMxj/jhkeFP8lV+gtzXR7hKFlcrgzTVGwadsvoOfZRWmi76S1dbE0OHvFbgjQDjhkerSbqidYkJ14ahnSFgehU1B7B50nilZD0+7UPpiF2TMrj9o1cKX5nlH77bgloz/WkDsoeQPbso7C7DJIYrs+k0WBJcr1niIBmxt+eViQfqTt9N1XUH+texK4D0JOEy+vM/RWAW2pSJmvwADfc7u58t1QTHmPMajF7pZjI08aEzm+L3X6zef+GfPd7dL5r2i38lRe3fElXSVpfbVFAkApy0lcWZL5iCpmau7WWNuNE3SXUHuDmWg/RiWlAziY8UVf70rEL/MFY6aEPsgs9RiBMQ+VvVyA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Wtmza2GSCLNVolE87jxPsHAPdXwPZz2GWKZxNVukEWIpJAewVkI9BbkqSW9i3QCTb/gBO+XsQOTsdVqWX3gIEHZ5MlX8FZDtCSvrrhp5uRfMLtt6ZKqI/Z9IH8/EpiaQTUK/qJ2HOTlPingZBUmR+YhTHMiiHM0PX9Cp9s94UBkvBqevobgP3W4AcOnulir/fz46JOPs5KKiLIngxWkbkTtjOZQr/j8s/r8JoLbeDKUdNm5NR6rJqoyLPpL6E+Np32TSDu3uvWGZ4Y8Slt5YDo9G1vC7RLnhlLHWKsI0Vlzw2oEK/7V42Qgzv0Te3T8DLFafevK8Prx1Vz8pJsxCQLn+EZpwIG8tElA+ZSp24jeIu27Um/CMJIB7A97683xOa5hmFkXW5WvXtMlZ6AQOHgto5pogrMGU/skG9/kIV13n6bFCSreTOEtkY/gK6EFI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 20:56:35.0023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a2ed4e-30b4-4838-6ca9-08de86c32c26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC908D89D1
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


On 3/20/26 13:35, Mario Limonciello wrote:
>
>
> On 3/18/2026 10:58 AM, Lizhi Hou wrote:
>> From: Max Zhen <max.zhen@amd.com>
>>
>> Refactor amdxdna GEM buffer object (BO) handling to simplify address
>> management and unify BO type semantics.
>>
>> Introduce helper APIs to retrieve commonly used BO addresses:
>> - User virtual address (UVA)
>> - Kernel virtual address (KVA)
>> - Device address (IOVA/PA)
>>
>> These helpers centralize address lookup logic and avoid duplicating
>> BO-specific handling across submission and execution paths. This also
>> improves readability and reduces the risk of inconsistent address
>> handling in future changes.
>>
>> As part of the refactor:
>> - Rename SHMEM BO type to SHARE to better reflect its usage.
>> - Merge CMD BO handling into SHARE, removing special-case logic for
>>    command buffers.
>> - Consolidate BO type handling paths to reduce code duplication and
>>    simplify maintenance.
>>
>> No functional change is intended. The refactor prepares the driver for
>> future enhancements by providing a cleaner abstraction for BO address
>> management.
>>
>> Signed-off-by: Max Zhen <max.zhen@amd.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>> ---
>>   drivers/accel/amdxdna/aie2_ctx.c        |   8 +-
>>   drivers/accel/amdxdna/aie2_message.c    |  33 +-
>>   drivers/accel/amdxdna/amdxdna_ctx.c     |  23 +-
>>   drivers/accel/amdxdna/amdxdna_ctx.h     |  15 +-
>>   drivers/accel/amdxdna/amdxdna_gem.c     | 400 +++++++++++-------------
>>   drivers/accel/amdxdna/amdxdna_gem.h     |  32 +-
>>   drivers/accel/amdxdna/amdxdna_pci_drv.c |   2 +-
>>   drivers/accel/amdxdna/amdxdna_ubuf.c    |  17 +-
>>   drivers/accel/amdxdna/amdxdna_ubuf.h    |   5 -
>>   include/uapi/drm/amdxdna_accel.h        |   9 +-
>>   10 files changed, 266 insertions(+), 278 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/aie2_ctx.c 
>> b/drivers/accel/amdxdna/aie2_ctx.c
>> index 6292349868c5..66dbbfd322a2 100644
>> --- a/drivers/accel/amdxdna/aie2_ctx.c
>> +++ b/drivers/accel/amdxdna/aie2_ctx.c
>> @@ -79,7 +79,7 @@ static int aie2_hwctx_restart(struct amdxdna_dev 
>> *xdna, struct amdxdna_hwctx *hw
>>       }
>>         ret = aie2_map_host_buf(xdna->dev_handle, hwctx->fw_ctx_id,
>> -                amdxdna_obj_dma_addr(hwctx->client, heap),
>> +                amdxdna_obj_dma_addr(heap),
>>                   heap->mem.size);
>>       if (ret) {
>>           XDNA_ERR(xdna, "Map host buf failed, ret %d", ret);
>> @@ -659,14 +659,14 @@ int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
>>               .size = MAX_CHAIN_CMDBUF_SIZE,
>>           };
>>   -        abo = amdxdna_drm_alloc_dev_bo(&xdna->ddev, &args, 
>> client->filp);
>> +        abo = amdxdna_drm_create_dev_bo(&xdna->ddev, &args, 
>> client->filp);
>>           if (IS_ERR(abo)) {
>>               ret = PTR_ERR(abo);
>>               goto free_cmd_bufs;
>>           }
>>             XDNA_DBG(xdna, "Command buf %d addr 0x%llx size 0x%lx",
>> -             i, abo->mem.dev_addr, abo->mem.size);
>> +             i, amdxdna_gem_dev_addr(abo), abo->mem.size);
>>           priv->cmd_buf[i] = abo;
>>       }
>>   @@ -707,7 +707,7 @@ int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
>>       }
>>         ret = aie2_map_host_buf(xdna->dev_handle, hwctx->fw_ctx_id,
>> -                amdxdna_obj_dma_addr(hwctx->client, heap),
>> +                amdxdna_obj_dma_addr(heap),
>>                   heap->mem.size);
>>       if (ret) {
>>           XDNA_ERR(xdna, "Map host buffer failed, ret %d", ret);
>> diff --git a/drivers/accel/amdxdna/aie2_message.c 
>> b/drivers/accel/amdxdna/aie2_message.c
>> index 4ec591306854..6e3fb52aa35f 100644
>> --- a/drivers/accel/amdxdna/aie2_message.c
>> +++ b/drivers/accel/amdxdna/aie2_message.c
>> @@ -548,10 +548,10 @@ int aie2_config_cu(struct amdxdna_hwctx *hwctx,
>>           }
>>             req.cfgs[i] = FIELD_PREP(AIE2_MSG_CFG_CU_PDI_ADDR,
>> -                     abo->mem.dev_addr >> shift);
>> +                     amdxdna_gem_dev_addr(abo) >> shift);
>>           req.cfgs[i] |= FIELD_PREP(AIE2_MSG_CFG_CU_FUNC, cu->cu_func);
>>           XDNA_DBG(xdna, "CU %d full addr 0x%llx, cfg 0x%x", i,
>> -             abo->mem.dev_addr, req.cfgs[i]);
>> +             amdxdna_gem_dev_addr(abo), req.cfgs[i]);
>>           drm_gem_object_put(gobj);
>>       }
>>       req.num_cus = hwctx->cus->num_cus;
>> @@ -998,6 +998,7 @@ int aie2_cmdlist_multi_execbuf(struct 
>> amdxdna_hwctx *hwctx,
>>       struct mailbox_channel *chann = hwctx->priv->mbox_chann;
>>       struct amdxdna_client *client = hwctx->client;
>>       struct amdxdna_gem_obj *cmd_abo = job->cmd_bo;
>> +    void *cmd_buf = amdxdna_gem_vmap(cmdbuf_abo);
>>       struct amdxdna_dev *xdna = client->xdna;
>>       struct amdxdna_cmd_chain *payload;
>>       struct xdna_mailbox_msg msg;
>> @@ -1009,6 +1010,9 @@ int aie2_cmdlist_multi_execbuf(struct 
>> amdxdna_hwctx *hwctx,
>>       u32 op;
>>       u32 i;
>>   +    if (!cmd_buf)
>> +        return -ENOMEM;
>> +
>>       op = amdxdna_cmd_get_op(cmd_abo);
>>       payload = amdxdna_cmd_get_payload(cmd_abo, &payload_len);
>>       if (op != ERT_CMD_CHAIN) {
>> @@ -1032,15 +1036,14 @@ int aie2_cmdlist_multi_execbuf(struct 
>> amdxdna_hwctx *hwctx,
>>           u32 boh = (u32)(payload->data[i]);
>>           struct amdxdna_gem_obj *abo;
>>   -        abo = amdxdna_gem_get_obj(client, boh, AMDXDNA_BO_CMD);
>> +        abo = amdxdna_gem_get_obj(client, boh, AMDXDNA_BO_SHMEM);
>>           if (!abo) {
>>               XDNA_ERR(xdna, "Failed to find cmd BO %d", boh);
>>               return -ENOENT;
>>           }
>>             size = cmdbuf_abo->mem.size - offset;
>> -        ret = aie2_cmdlist_fill_slot(cmdbuf_abo->mem.kva + offset,
>> -                         abo, &size, &op);
>> +        ret = aie2_cmdlist_fill_slot(cmd_buf + offset, abo, &size, 
>> &op);
>>           amdxdna_gem_put_obj(abo);
>>           if (ret)
>>               return ret;
>> @@ -1050,16 +1053,16 @@ int aie2_cmdlist_multi_execbuf(struct 
>> amdxdna_hwctx *hwctx,
>>         XDNA_DBG(xdna, "Total %d commands:", ccnt);
>>       print_hex_dump_debug("cmdbufs: ", DUMP_PREFIX_OFFSET, 16, 4,
>> -                 cmdbuf_abo->mem.kva, offset, false);
>> +                 cmd_buf, offset, false);
>>         msg.opcode = EXEC_MSG_OPS(xdna)->get_chain_msg_op(op);
>>       if (msg.opcode == MSG_OP_MAX_OPCODE)
>>           return -EOPNOTSUPP;
>>         /* The offset is the accumulated total size of the cmd buffer */
>> -    EXEC_MSG_OPS(xdna)->init_chain_req(&req, cmdbuf_abo->mem.dev_addr,
>> +    EXEC_MSG_OPS(xdna)->init_chain_req(&req, 
>> amdxdna_gem_dev_addr(cmdbuf_abo),
>>                          offset, ccnt);
>> -    drm_clflush_virt_range(cmdbuf_abo->mem.kva, offset);
>> +    drm_clflush_virt_range(cmd_buf, offset);
>>         msg.handle = job;
>>       msg.notify_cb = notify_cb;
>> @@ -1084,27 +1087,29 @@ int aie2_cmdlist_single_execbuf(struct 
>> amdxdna_hwctx *hwctx,
>>       struct mailbox_channel *chann = hwctx->priv->mbox_chann;
>>       struct amdxdna_dev *xdna = hwctx->client->xdna;
>>       struct amdxdna_gem_obj *cmd_abo = job->cmd_bo;
>> +    void *cmd_buf = amdxdna_gem_vmap(cmdbuf_abo);
>>       struct xdna_mailbox_msg msg;
>>       union exec_chain_req req;
>>       u32 op = ERT_INVALID_CMD;
>>       size_t size;
>>       int ret;
>>   +    if (!cmd_buf)
>> +        return -ENOMEM;
>> +
>>       size = cmdbuf_abo->mem.size;
>> -    ret = aie2_cmdlist_fill_slot(cmdbuf_abo->mem.kva, cmd_abo, 
>> &size, &op);
>> +    ret = aie2_cmdlist_fill_slot(cmd_buf, cmd_abo, &size, &op);
>>       if (ret)
>>           return ret;
>>   -    print_hex_dump_debug("cmdbuf: ", DUMP_PREFIX_OFFSET, 16, 4,
>> -                 cmdbuf_abo->mem.kva, size, false);
>> +    print_hex_dump_debug("cmdbuf: ", DUMP_PREFIX_OFFSET, 16, 4, 
>> cmd_buf, size, false);
>>         msg.opcode = EXEC_MSG_OPS(xdna)->get_chain_msg_op(op);
>>       if (msg.opcode == MSG_OP_MAX_OPCODE)
>>           return -EOPNOTSUPP;
>>   -    EXEC_MSG_OPS(xdna)->init_chain_req(&req, 
>> cmdbuf_abo->mem.dev_addr,
>> -                       size, 1);
>> -    drm_clflush_virt_range(cmdbuf_abo->mem.kva, size);
>> +    EXEC_MSG_OPS(xdna)->init_chain_req(&req, 
>> amdxdna_gem_dev_addr(cmdbuf_abo), size, 1);
>> +    drm_clflush_virt_range(cmd_buf, size);
>>         msg.handle = job;
>>       msg.notify_cb = notify_cb;
>> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c 
>> b/drivers/accel/amdxdna/amdxdna_ctx.c
>> index 4b921715176d..94e5639adc64 100644
>> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
>> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
>> @@ -94,9 +94,12 @@ int amdxdna_hwctx_walk(struct amdxdna_client 
>> *client, void *arg,
>>     void *amdxdna_cmd_get_payload(struct amdxdna_gem_obj *abo, u32 
>> *size)
>>   {
>> -    struct amdxdna_cmd *cmd = abo->mem.kva;
>> +    struct amdxdna_cmd *cmd = amdxdna_gem_vmap(abo);
>>       u32 num_masks, count;
>>   +    if (!cmd)
>> +        return NULL;
>> +
>>       if (amdxdna_cmd_get_op(abo) == ERT_CMD_CHAIN)
>>           num_masks = 0;
>>       else
>> @@ -118,10 +121,13 @@ void *amdxdna_cmd_get_payload(struct 
>> amdxdna_gem_obj *abo, u32 *size)
>>     u32 amdxdna_cmd_get_cu_idx(struct amdxdna_gem_obj *abo)
>>   {
>> -    struct amdxdna_cmd *cmd = abo->mem.kva;
>> +    struct amdxdna_cmd *cmd = amdxdna_gem_vmap(abo);
>>       u32 num_masks, i;
>>       u32 *cu_mask;
>>   +    if (!cmd)
>> +        return INVALID_CU_IDX;
>> +
>>       if (amdxdna_cmd_get_op(abo) == ERT_CMD_CHAIN)
>>           return INVALID_CU_IDX;
>>   @@ -141,19 +147,24 @@ int amdxdna_cmd_set_error(struct 
>> amdxdna_gem_obj *abo,
>>                 void *err_data, size_t size)
>>   {
>>       struct amdxdna_client *client = job->hwctx->client;
>> -    struct amdxdna_cmd *cmd = abo->mem.kva;
>> +    struct amdxdna_cmd *cmd = amdxdna_gem_vmap(abo);
>>       struct amdxdna_cmd_chain *cc = NULL;
>>   +    if (!cmd)
>> +        return -ENOMEM;
>> +
>>       cmd->header &= ~AMDXDNA_CMD_STATE;
>>       cmd->header |= FIELD_PREP(AMDXDNA_CMD_STATE, error_state);
>>         if (amdxdna_cmd_get_op(abo) == ERT_CMD_CHAIN) {
>>           cc = amdxdna_cmd_get_payload(abo, NULL);
>>           cc->error_index = (cmd_idx < cc->command_count) ? cmd_idx : 0;
>> -        abo = amdxdna_gem_get_obj(client, cc->data[0], AMDXDNA_BO_CMD);
>> +        abo = amdxdna_gem_get_obj(client, cc->data[0], 
>> AMDXDNA_BO_SHMEM);
>>           if (!abo)
>>               return -EINVAL;
>> -        cmd = abo->mem.kva;
>> +        cmd = amdxdna_gem_vmap(abo);
>> +        if (!cmd)
>> +            return -ENOMEM;
>>       }
>>         memset(cmd->data, 0xff, abo->mem.size - sizeof(*cmd));
>> @@ -472,7 +483,7 @@ int amdxdna_cmd_submit(struct amdxdna_client 
>> *client,
>>       job->drv_cmd = drv_cmd;
>>         if (cmd_bo_hdl != AMDXDNA_INVALID_BO_HANDLE) {
>> -        job->cmd_bo = amdxdna_gem_get_obj(client, cmd_bo_hdl, 
>> AMDXDNA_BO_CMD);
>> +        job->cmd_bo = amdxdna_gem_get_obj(client, cmd_bo_hdl, 
>> AMDXDNA_BO_SHMEM);
>>           if (!job->cmd_bo) {
>>               XDNA_ERR(xdna, "Failed to get cmd bo from %d", 
>> cmd_bo_hdl);
>>               ret = -EINVAL;
>> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h 
>> b/drivers/accel/amdxdna/amdxdna_ctx.h
>> index 57db1527a93b..a8557d7e8923 100644
>> --- a/drivers/accel/amdxdna/amdxdna_ctx.h
>> +++ b/drivers/accel/amdxdna/amdxdna_ctx.h
>> @@ -158,7 +158,10 @@ struct amdxdna_sched_job {
>>   static inline u32
>>   amdxdna_cmd_get_op(struct amdxdna_gem_obj *abo)
>>   {
>> -    struct amdxdna_cmd *cmd = abo->mem.kva;
>> +    struct amdxdna_cmd *cmd = amdxdna_gem_vmap(abo);
>> +
>> +    if (!cmd)
>> +        return ERT_INVALID_CMD;
>>         return FIELD_GET(AMDXDNA_CMD_OPCODE, cmd->header);
>>   }
>> @@ -166,7 +169,10 @@ amdxdna_cmd_get_op(struct amdxdna_gem_obj *abo)
>>   static inline void
>>   amdxdna_cmd_set_state(struct amdxdna_gem_obj *abo, enum 
>> ert_cmd_state s)
>>   {
>> -    struct amdxdna_cmd *cmd = abo->mem.kva;
>> +    struct amdxdna_cmd *cmd = amdxdna_gem_vmap(abo);
>> +
>> +    if (!cmd)
>> +        return;
>>         cmd->header &= ~AMDXDNA_CMD_STATE;
>>       cmd->header |= FIELD_PREP(AMDXDNA_CMD_STATE, s);
>> @@ -175,7 +181,10 @@ amdxdna_cmd_set_state(struct amdxdna_gem_obj 
>> *abo, enum ert_cmd_state s)
>>   static inline enum ert_cmd_state
>>   amdxdna_cmd_get_state(struct amdxdna_gem_obj *abo)
>>   {
>> -    struct amdxdna_cmd *cmd = abo->mem.kva;
>> +    struct amdxdna_cmd *cmd = amdxdna_gem_vmap(abo);
>> +
>> +    if (!cmd)
>> +        return ERT_CMD_STATE_INVALID;
>>         return FIELD_GET(AMDXDNA_CMD_STATE, cmd->header);
>>   }
>> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c 
>> b/drivers/accel/amdxdna/amdxdna_gem.c
>> index d80cf164740c..3c15d06b6048 100644
>> --- a/drivers/accel/amdxdna/amdxdna_gem.c
>> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
>> @@ -30,7 +30,6 @@ amdxdna_gem_heap_alloc(struct amdxdna_gem_obj *abo)
>>       struct amdxdna_dev *xdna = client->xdna;
>>       struct amdxdna_mem *mem = &abo->mem;
>>       struct amdxdna_gem_obj *heap;
>> -    u64 offset;
>>       u32 align;
>>       int ret;
>>   @@ -42,7 +41,7 @@ amdxdna_gem_heap_alloc(struct amdxdna_gem_obj *abo)
>>           goto unlock_out;
>>       }
>>   -    if (heap->mem.userptr == AMDXDNA_INVALID_ADDR) {
>> +    if (amdxdna_gem_uva(heap) == AMDXDNA_INVALID_ADDR) {
>>           XDNA_ERR(xdna, "Invalid dev heap userptr");
>>           ret = -EINVAL;
>>           goto unlock_out;
>> @@ -64,11 +63,6 @@ amdxdna_gem_heap_alloc(struct amdxdna_gem_obj *abo)
>>           goto unlock_out;
>>       }
>>   -    mem->dev_addr = abo->mm_node.start;
>> -    offset = mem->dev_addr - heap->mem.dev_addr;
>> -    mem->userptr = heap->mem.userptr + offset;
>> -    mem->kva = heap->mem.kva + offset;
>> -
>>       drm_gem_object_get(to_gobj(heap));
>>     unlock_out:
>> @@ -77,13 +71,6 @@ amdxdna_gem_heap_alloc(struct amdxdna_gem_obj *abo)
>>       return ret;
>>   }
>>   -static void
>> -amdxdna_gem_destroy_obj(struct amdxdna_gem_obj *abo)
>> -{
>> -    mutex_destroy(&abo->lock);
>> -    kfree(abo);
>> -}
>> -
>>   static void
>>   amdxdna_gem_heap_free(struct amdxdna_gem_obj *abo)
>>   {
>> @@ -99,6 +86,105 @@ amdxdna_gem_heap_free(struct amdxdna_gem_obj *abo)
>>       mutex_unlock(&abo->client->mm_lock);
>>   }
>>   +static struct amdxdna_gem_obj *
>> +amdxdna_gem_create_obj(struct drm_device *dev, size_t size)
>> +{
>> +    struct amdxdna_gem_obj *abo;
>> +
>> +    abo = kzalloc_obj(*abo);
>> +    if (!abo)
>> +        return ERR_PTR(-ENOMEM);
>> +
>> +    abo->pinned = false;
>> +    abo->assigned_hwctx = AMDXDNA_INVALID_CTX_HANDLE;
>> +    mutex_init(&abo->lock);
>> +
>> +    abo->mem.dma_addr = AMDXDNA_INVALID_ADDR;
>> +    abo->mem.uva = AMDXDNA_INVALID_ADDR;
>> +    abo->mem.size = size;
>> +    INIT_LIST_HEAD(&abo->mem.umap_list);
>> +
>> +    return abo;
>> +}
>> +
>> +static void
>> +amdxdna_gem_destroy_obj(struct amdxdna_gem_obj *abo)
>> +{
>> +    mutex_destroy(&abo->lock);
>> +    kfree(abo);
>> +}
>> +
>> +/*
>> + * Obtains a kernel virtual address on the BO (usually of small size).
>> + * The mapping is established on the first call and stays valid until
>> + * amdxdna_gem_vunmap() is called.
>> + */
>> +void *amdxdna_gem_vmap(struct amdxdna_gem_obj *abo)
>> +{
>> +    struct iosys_map map = IOSYS_MAP_INIT_VADDR(NULL);
>> +    int ret;
>> +
>> +    if (abo->mem.kva)
>> +        return abo->mem.kva;
>> +
>> +    /* The first call to get the kva, taking slow path. */
>> +    guard(mutex)(&abo->lock);
>> +
>> +    if (!abo->mem.kva) {
>> +        ret = drm_gem_vmap(to_gobj(abo), &map);
>> +        if (ret)
>> +            XDNA_ERR(abo->client->xdna, "Vmap bo failed, ret %d", ret);
>> +        else
>> +            abo->mem.kva = map.vaddr;
>> +    }
>> +    return abo->mem.kva;
>> +}
>> +
>> +/*
>> + * Free mapping established through amdxdna_gem_vmap()
>> + */
>> +static void amdxdna_gem_vunmap(struct amdxdna_gem_obj *abo)
>> +{
>> +    guard(mutex)(&abo->lock);
>> +
>> +    if (abo->mem.kva) {
>> +        struct iosys_map map = IOSYS_MAP_INIT_VADDR(abo->mem.kva);
>> +
>> +        drm_gem_vunmap(to_gobj(abo), &map);
>> +        abo->mem.kva = NULL;
>> +    }
>> +}
>> +
>> +/*
>> + * Obtain the user virtual address for accessing the BO.
>> + * It can be used for device to access the BO when PASID is enabled.
>> + */
>> +u64 amdxdna_gem_uva(struct amdxdna_gem_obj *abo)
>> +{
>> +    if (abo->type == AMDXDNA_BO_DEV) {
>> +        struct amdxdna_gem_obj *heap = abo->client->dev_heap;
>> +        u64 off = amdxdna_dev_bo_offset(abo);
>> +
>> +        if (amdxdna_gem_uva(heap) != AMDXDNA_INVALID_ADDR)
>> +            return amdxdna_gem_uva(heap) + off;
>> +        return AMDXDNA_INVALID_ADDR;
>> +    }
>> +
>> +    return abo->mem.uva;
>> +}
>> +
>> +/*
>> + * Obtain the address for device to access the BO.
>> + */
>> +u64 amdxdna_gem_dev_addr(struct amdxdna_gem_obj *abo)
>> +{
>> +    if (abo->type == AMDXDNA_BO_DEV_HEAP)
>> +        return abo->client->xdna->dev_info->dev_mem_base;
>> +    if (abo->type == AMDXDNA_BO_DEV)
>> +        return abo->mm_node.start;
>> +    return amdxdna_obj_dma_addr(abo);
>> +}
>> +
>>   static bool amdxdna_hmm_invalidate(struct mmu_interval_notifier *mni,
>>                      const struct mmu_notifier_range *range,
>>                      unsigned long cur_seq)
>> @@ -161,16 +247,19 @@ static void amdxdna_hmm_unregister(struct 
>> amdxdna_gem_obj *abo,
>>   static void amdxdna_umap_release(struct kref *ref)
>>   {
>>       struct amdxdna_umap *mapp = container_of(ref, struct 
>> amdxdna_umap, refcnt);
>> +    struct amdxdna_gem_obj *abo = mapp->abo;
>>       struct vm_area_struct *vma = mapp->vma;
>>       struct amdxdna_dev *xdna;
>>         mmu_interval_notifier_remove(&mapp->notifier);
>> -    if (is_import_bo(mapp->abo) && vma->vm_file && 
>> vma->vm_file->f_mapping)
>> +    if (is_import_bo(abo) && vma->vm_file && vma->vm_file->f_mapping)
>> mapping_clear_unevictable(vma->vm_file->f_mapping);
>>         xdna = to_xdna_dev(to_gobj(mapp->abo)->dev);
>>       down_write(&xdna->notifier_lock);
>>       list_del(&mapp->node);
>> +    if (list_empty(&abo->mem.umap_list))
>> +        abo->mem.uva = AMDXDNA_INVALID_ADDR;
>>       up_write(&xdna->notifier_lock);
>>         kvfree(mapp->range.hmm_pfns);
>> @@ -232,13 +321,13 @@ static int amdxdna_hmm_register(struct 
>> amdxdna_gem_obj *abo,
>>       mapp->abo = abo;
>>       kref_init(&mapp->refcnt);
>>   -    if (abo->mem.userptr == AMDXDNA_INVALID_ADDR)
>> -        abo->mem.userptr = addr;
>>       INIT_WORK(&mapp->hmm_unreg_work, amdxdna_hmm_unreg_work);
>>       if (is_import_bo(abo) && vma->vm_file && vma->vm_file->f_mapping)
>> mapping_set_unevictable(vma->vm_file->f_mapping);
>>         down_write(&xdna->notifier_lock);
>> +    if (list_empty(&abo->mem.umap_list))
>> +        abo->mem.uva = addr;
>>       list_add_tail(&mapp->node, &abo->mem.umap_list);
>>       up_write(&xdna->notifier_lock);
>>   @@ -256,10 +345,11 @@ static void amdxdna_gem_dev_obj_free(struct 
>> drm_gem_object *gobj)
>>       struct amdxdna_dev *xdna = to_xdna_dev(gobj->dev);
>>       struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
>>   -    XDNA_DBG(xdna, "BO type %d xdna_addr 0x%llx", abo->type, 
>> abo->mem.dev_addr);
>> +    XDNA_DBG(xdna, "BO type %d xdna_addr 0x%llx", abo->type, 
>> amdxdna_gem_dev_addr(abo));
>>       if (abo->pinned)
>>           amdxdna_gem_unpin(abo);
>>   +    amdxdna_gem_vunmap(abo);
>>       amdxdna_gem_heap_free(abo);
>>       drm_gem_object_release(gobj);
>>       amdxdna_gem_destroy_obj(abo);
>> @@ -390,35 +480,6 @@ static const struct dma_buf_ops 
>> amdxdna_dmabuf_ops = {
>>       .vunmap = drm_gem_dmabuf_vunmap,
>>   };
>>   -static int amdxdna_gem_obj_vmap(struct amdxdna_gem_obj *abo, void 
>> **vaddr)
>> -{
>> -    struct iosys_map map = IOSYS_MAP_INIT_VADDR(NULL);
>> -    int ret;
>> -
>> -    if (is_import_bo(abo))
>> -        ret = dma_buf_vmap_unlocked(abo->dma_buf, &map);
>> -    else
>> -        ret = drm_gem_vmap(to_gobj(abo), &map);
>> -
>> -    *vaddr = map.vaddr;
>> -    return ret;
>> -}
>> -
>> -static void amdxdna_gem_obj_vunmap(struct amdxdna_gem_obj *abo)
>> -{
>> -    struct iosys_map map;
>> -
>> -    if (!abo->mem.kva)
>> -        return;
>> -
>> -    iosys_map_set_vaddr(&map, abo->mem.kva);
>> -
>> -    if (is_import_bo(abo))
>> -        dma_buf_vunmap_unlocked(abo->dma_buf, &map);
>> -    else
>> -        drm_gem_vunmap(to_gobj(abo), &map);
>> -}
>> -
>>   static struct dma_buf *amdxdna_gem_prime_export(struct 
>> drm_gem_object *gobj, int flags)
>>   {
>>       struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
>> @@ -452,7 +513,7 @@ static void amdxdna_gem_obj_free(struct 
>> drm_gem_object *gobj)
>>       struct amdxdna_dev *xdna = to_xdna_dev(gobj->dev);
>>       struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
>>   -    XDNA_DBG(xdna, "BO type %d xdna_addr 0x%llx", abo->type, 
>> abo->mem.dev_addr);
>> +    XDNA_DBG(xdna, "BO type %d xdna_addr 0x%llx", abo->type, 
>> amdxdna_gem_dev_addr(abo));
>>         amdxdna_hmm_unregister(abo, NULL);
>>       flush_workqueue(xdna->notifier_wq);
>> @@ -463,15 +524,16 @@ static void amdxdna_gem_obj_free(struct 
>> drm_gem_object *gobj)
>>       if (abo->type == AMDXDNA_BO_DEV_HEAP)
>>           drm_mm_takedown(&abo->mm);
>>   -    amdxdna_gem_obj_vunmap(abo);
>> +    if (amdxdna_iova_on(xdna))
>> +        amdxdna_iommu_unmap_bo(xdna, abo);
>> +
>> +    amdxdna_gem_vunmap(abo);
>>       mutex_destroy(&abo->lock);
>>   -    if (is_import_bo(abo)) {
>> +    if (is_import_bo(abo))
>>           amdxdna_imported_obj_free(abo);
>> -        return;
>> -    }
>> -
>> -    drm_gem_shmem_free(&abo->base);
>> +    else
>> +        drm_gem_shmem_free(&abo->base);
>>   }
>>     static int amdxdna_gem_obj_open(struct drm_gem_object *gobj, 
>> struct drm_file *filp)
>> @@ -481,43 +543,38 @@ static int amdxdna_gem_obj_open(struct 
>> drm_gem_object *gobj, struct drm_file *fi
>>       int ret;
>>         guard(mutex)(&abo->lock);
>> -    if (abo->ref) {
>> -        abo->ref++;
>> -        return 0;
>> -    }
>>   +    if (!abo->client)
>> +        abo->client = filp->driver_priv;
>>       if (amdxdna_iova_on(xdna)) {
>>           ret = amdxdna_iommu_map_bo(xdna, abo);
>>           if (ret)
>>               return ret;
>>       }
>> -    abo->ref++;
>>         return 0;
>>   }
>>   -static void amdxdna_gem_obj_close(struct drm_gem_object *gobj, 
>> struct drm_file *filp)
>> +static int amdxdna_gem_dev_obj_vmap(struct drm_gem_object *obj, 
>> struct iosys_map *map)
>>   {
>> -    struct amdxdna_dev *xdna = to_xdna_dev(gobj->dev);
>> -    struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
>> +    struct amdxdna_gem_obj *abo = to_xdna_obj(obj);
>> +    void *base = amdxdna_gem_vmap(abo->client->dev_heap);
>> +    u64 offset = amdxdna_dev_bo_offset(abo);
>>   -    guard(mutex)(&abo->lock);
>> -    abo->ref--;
>> -    if (abo->ref)
>> -        return;
>> -
>> -    if (amdxdna_iova_on(xdna))
>> -        amdxdna_iommu_unmap_bo(xdna, abo);
>> +    if (!base)
>> +        return -ENOMEM;
>> +    iosys_map_set_vaddr(map, base + offset);
>> +    return 0;
>>   }
>>     static const struct drm_gem_object_funcs 
>> amdxdna_gem_dev_obj_funcs = {
>>       .free = amdxdna_gem_dev_obj_free,
>> +    .vmap = amdxdna_gem_dev_obj_vmap,
>>   };
>>     static const struct drm_gem_object_funcs amdxdna_gem_shmem_funcs = {
>>       .free = amdxdna_gem_obj_free,
>>       .open = amdxdna_gem_obj_open,
>> -    .close = amdxdna_gem_obj_close,
>>       .print_info = drm_gem_shmem_object_print_info,
>>       .pin = drm_gem_shmem_object_pin,
>>       .unpin = drm_gem_shmem_object_unpin,
>> @@ -529,31 +586,9 @@ static const struct drm_gem_object_funcs 
>> amdxdna_gem_shmem_funcs = {
>>       .export = amdxdna_gem_prime_export,
>>   };
>>   -static struct amdxdna_gem_obj *
>> -amdxdna_gem_create_obj(struct drm_device *dev, size_t size)
>> -{
>> -    struct amdxdna_gem_obj *abo;
>> -
>> -    abo = kzalloc_obj(*abo);
>> -    if (!abo)
>> -        return ERR_PTR(-ENOMEM);
>> -
>> -    abo->pinned = false;
>> -    abo->assigned_hwctx = AMDXDNA_INVALID_CTX_HANDLE;
>> -    mutex_init(&abo->lock);
>> -
>> -    abo->mem.userptr = AMDXDNA_INVALID_ADDR;
>> -    abo->mem.dev_addr = AMDXDNA_INVALID_ADDR;
>> -    abo->mem.dma_addr = AMDXDNA_INVALID_ADDR;
>> -    abo->mem.size = size;
>> -    INIT_LIST_HEAD(&abo->mem.umap_list);
>> -
>> -    return abo;
>> -}
>> -
>>   /* For drm_driver->gem_create_object callback */
>>   struct drm_gem_object *
>> -amdxdna_gem_create_object_cb(struct drm_device *dev, size_t size)
>> +amdxdna_gem_create_shmem_object_cb(struct drm_device *dev, size_t size)
>>   {
>>       struct amdxdna_gem_obj *abo;
>>   @@ -567,8 +602,9 @@ amdxdna_gem_create_object_cb(struct drm_device 
>> *dev, size_t size)
>>   }
>>     static struct amdxdna_gem_obj *
>> -amdxdna_gem_create_shmem_object(struct drm_device *dev, size_t size)
>> +amdxdna_gem_create_shmem_object(struct drm_device *dev, struct 
>> amdxdna_drm_create_bo *args)
>>   {
>> +    size_t size = args->size;
>>       struct drm_gem_shmem_object *shmem = drm_gem_shmem_create(dev, 
>> size);
>>         if (IS_ERR(shmem))
>> @@ -582,7 +618,6 @@ static struct amdxdna_gem_obj *
>>   amdxdna_gem_create_ubuf_object(struct drm_device *dev, struct 
>> amdxdna_drm_create_bo *args)
>>   {
>>       struct amdxdna_dev *xdna = to_xdna_dev(dev);
>> -    enum amdxdna_ubuf_flag flags = 0;
>>       struct amdxdna_drm_va_tbl va_tbl;
>>       struct drm_gem_object *gobj;
>>       struct dma_buf *dma_buf;
>> @@ -593,10 +628,7 @@ amdxdna_gem_create_ubuf_object(struct drm_device 
>> *dev, struct amdxdna_drm_create
>>       }
>>         if (va_tbl.num_entries) {
>> -        if (args->type == AMDXDNA_BO_CMD)
>> -            flags |= AMDXDNA_UBUF_FLAG_MAP_DMA;
>> -
>> -        dma_buf = amdxdna_get_ubuf(dev, flags, va_tbl.num_entries,
>> +        dma_buf = amdxdna_get_ubuf(dev, va_tbl.num_entries,
>>                          u64_to_user_ptr(args->vaddr + sizeof(va_tbl)));
>>       } else {
>>           dma_buf = dma_buf_get(va_tbl.dmabuf_fd);
>> @@ -616,18 +648,6 @@ amdxdna_gem_create_ubuf_object(struct drm_device 
>> *dev, struct amdxdna_drm_create
>>       return to_xdna_obj(gobj);
>>   }
>>   -static struct amdxdna_gem_obj *
>> -amdxdna_gem_create_object(struct drm_device *dev,
>> -              struct amdxdna_drm_create_bo *args)
>> -{
>> -    size_t aligned_sz = PAGE_ALIGN(args->size);
>> -
>> -    if (args->vaddr)
>> -        return amdxdna_gem_create_ubuf_object(dev, args);
>> -
>> -    return amdxdna_gem_create_shmem_object(dev, aligned_sz);
>> -}
>> -
>>   struct drm_gem_object *
>>   amdxdna_gem_prime_import(struct drm_device *dev, struct dma_buf 
>> *dma_buf)
>>   {
>> @@ -660,7 +680,8 @@ amdxdna_gem_prime_import(struct drm_device *dev, 
>> struct dma_buf *dma_buf)
>>       abo = to_xdna_obj(gobj);
>>       abo->attach = attach;
>>       abo->dma_buf = dma_buf;
>> -    abo->type = AMDXDNA_BO_SHMEM;
>> +    abo->type = AMDXDNA_BO_SHARE;
>> +    gobj->resv = dma_buf->resv;
>>         return gobj;
>>   @@ -675,92 +696,92 @@ amdxdna_gem_prime_import(struct drm_device 
>> *dev, struct dma_buf *dma_buf)
>>   }
>>     static struct amdxdna_gem_obj *
>> -amdxdna_drm_alloc_shmem(struct drm_device *dev,
>> -            struct amdxdna_drm_create_bo *args,
>> -            struct drm_file *filp)
>> +amdxdna_drm_create_share_bo(struct drm_device *dev,
>> +                struct amdxdna_drm_create_bo *args, struct drm_file 
>> *filp)
>>   {
>> -    struct amdxdna_client *client = filp->driver_priv;
>>       struct amdxdna_gem_obj *abo;
>>   -    abo = amdxdna_gem_create_object(dev, args);
>> +    if (args->vaddr)
>> +        abo = amdxdna_gem_create_ubuf_object(dev, args);
>> +    else
>> +        abo = amdxdna_gem_create_shmem_object(dev, args);
>>       if (IS_ERR(abo))
>>           return ERR_CAST(abo);
>>   -    abo->client = client;
>> -    abo->type = AMDXDNA_BO_SHMEM;
>> +    if (args->type == AMDXDNA_BO_DEV_HEAP)
>> +        abo->type = AMDXDNA_BO_DEV_HEAP;
>> +    else
>> +        abo->type = AMDXDNA_BO_SHARE;
>>         return abo;
>>   }
>>     static struct amdxdna_gem_obj *
>> -amdxdna_drm_create_dev_heap(struct drm_device *dev,
>> -                struct amdxdna_drm_create_bo *args,
>> -                struct drm_file *filp)
>> +amdxdna_drm_create_dev_heap_bo(struct drm_device *dev,
>> +                   struct amdxdna_drm_create_bo *args, struct 
>> drm_file *filp)
>>   {
>>       struct amdxdna_client *client = filp->driver_priv;
>>       struct amdxdna_dev *xdna = to_xdna_dev(dev);
>>       struct amdxdna_gem_obj *abo;
>>       int ret;
>>   -    if (args->size > xdna->dev_info->dev_mem_size) {
>> -        XDNA_DBG(xdna, "Invalid dev heap size 0x%llx, limit 0x%lx",
>> + WARN_ON(!is_power_of_2(xdna->dev_info->dev_mem_size));
>> +    XDNA_DBG(xdna, "Requested dev heap size 0x%llx", args->size);
>> +    if (!args->size || !IS_ALIGNED(args->size, 
>> xdna->dev_info->dev_mem_size)) {
>> +        XDNA_ERR(xdna, "The dev heap size 0x%llx is not multiple of 
>> 0x%lx",
>>                args->size, xdna->dev_info->dev_mem_size);
>>           return ERR_PTR(-EINVAL);
>>       }
>>   +    /* HEAP BO is a special case of SHMEM BO. */
>> +    abo = amdxdna_drm_create_share_bo(dev, args, filp);
>> +    if (IS_ERR(abo))
>> +        return ERR_CAST(abo);
>> +
>> +    /* Set up heap for this client. */
>>       mutex_lock(&client->mm_lock);
>> +
>>       if (client->dev_heap) {
>>           XDNA_DBG(client->xdna, "dev heap is already created");
>>           ret = -EBUSY;
>>           goto mm_unlock;
>>       }
>> -
>> -    abo = amdxdna_gem_create_object(dev, args);
>> -    if (IS_ERR(abo)) {
>> -        ret = PTR_ERR(abo);
>> -        goto mm_unlock;
>> -    }
>> -
>> -    abo->type = AMDXDNA_BO_DEV_HEAP;
>> -    abo->client = client;
>> -    abo->mem.dev_addr = client->xdna->dev_info->dev_mem_base;
>> -    drm_mm_init(&abo->mm, abo->mem.dev_addr, abo->mem.size);
>> -
>> -    ret = amdxdna_gem_obj_vmap(abo, &abo->mem.kva);
>> -    if (ret) {
>> -        XDNA_ERR(xdna, "Vmap heap bo failed, ret %d", ret);
>> -        goto release_obj;
>> -    }
>> -
>>       client->dev_heap = abo;
>>       drm_gem_object_get(to_gobj(abo));
>> +
>> +    drm_mm_init(&abo->mm, xdna->dev_info->dev_mem_base, abo->mem.size);
>> +
>>       mutex_unlock(&client->mm_lock);
>>         return abo;
>>   -release_obj:
>> -    drm_gem_object_put(to_gobj(abo));
>>   mm_unlock:
>>       mutex_unlock(&client->mm_lock);
>> +    drm_gem_object_put(to_gobj(abo));
>>       return ERR_PTR(ret);
>>   }
>>     struct amdxdna_gem_obj *
>> -amdxdna_drm_alloc_dev_bo(struct drm_device *dev,
>> -             struct amdxdna_drm_create_bo *args,
>> -             struct drm_file *filp)
>> +amdxdna_drm_create_dev_bo(struct drm_device *dev,
>> +              struct amdxdna_drm_create_bo *args, struct drm_file 
>> *filp)
>>   {
>> +    size_t aligned_sz = PAGE_ALIGN(args->size);
>>       struct amdxdna_client *client = filp->driver_priv;
>>       struct amdxdna_dev *xdna = to_xdna_dev(dev);
>> -    size_t aligned_sz = PAGE_ALIGN(args->size);
>>       struct amdxdna_gem_obj *abo;
>> +    struct drm_gem_object *gobj;
>>       int ret;
>>   -    abo = amdxdna_gem_create_obj(&xdna->ddev, aligned_sz);
>> +    if (!aligned_sz) {
>> +        XDNA_ERR(xdna, "Invalid BO size 0x%llx", args->size);
>> +        return ERR_PTR(-EINVAL);
>> +    }
>> +
>> +    abo = amdxdna_gem_create_obj(dev, aligned_sz);
>>       if (IS_ERR(abo))
>>           return abo;
>> -
>> -    to_gobj(abo)->funcs = &amdxdna_gem_dev_obj_funcs;
>> +    gobj = to_gobj(abo);
>> +    gobj->funcs = &amdxdna_gem_dev_obj_funcs;
>>       abo->type = AMDXDNA_BO_DEV;
>>       abo->client = client;
>>   @@ -770,31 +791,7 @@ amdxdna_drm_alloc_dev_bo(struct drm_device *dev,
>>           amdxdna_gem_destroy_obj(abo);
>>           return ERR_PTR(ret);
>>       }
>> -
>> -    drm_gem_private_object_init(&xdna->ddev, to_gobj(abo), aligned_sz);
>> -
>> -    return abo;
>> -}
>> -
>> -static struct amdxdna_gem_obj *
>> -amdxdna_drm_create_cmd_bo(struct drm_device *dev,
>> -              struct amdxdna_drm_create_bo *args,
>> -              struct drm_file *filp)
>> -{
>> -    struct amdxdna_dev *xdna = to_xdna_dev(dev);
>> -    struct amdxdna_gem_obj *abo;
>> -
>> -    if (args->size < sizeof(struct amdxdna_cmd)) {
>> -        XDNA_DBG(xdna, "Command BO size 0x%llx too small", args->size);
>> -        return ERR_PTR(-EINVAL);
>> -    }
>> -
>> -    abo = amdxdna_gem_create_object(dev, args);
>> -    if (IS_ERR(abo))
>> -        return ERR_CAST(abo);
>> -
>> -    abo->type = AMDXDNA_BO_CMD;
>> -    abo->client = filp->driver_priv;
>> +    drm_gem_private_object_init(dev, gobj, aligned_sz);
>>         return abo;
>>   }
>> @@ -812,17 +809,16 @@ int amdxdna_drm_create_bo_ioctl(struct 
>> drm_device *dev, void *data, struct drm_f
>>       XDNA_DBG(xdna, "BO arg type %d vaddr 0x%llx size 0x%llx flags 
>> 0x%llx",
>>            args->type, args->vaddr, args->size, args->flags);
>>       switch (args->type) {
>> -    case AMDXDNA_BO_SHMEM:
>> -        abo = amdxdna_drm_alloc_shmem(dev, args, filp);
>> +    case AMDXDNA_BO_CMD:
>> +        fallthrough;
>> +    case AMDXDNA_BO_SHARE:
>> +        abo = amdxdna_drm_create_share_bo(dev, args, filp);
>>           break;
>>       case AMDXDNA_BO_DEV_HEAP:
>> -        abo = amdxdna_drm_create_dev_heap(dev, args, filp);
>> +        abo = amdxdna_drm_create_dev_heap_bo(dev, args, filp);
>>           break;
>>       case AMDXDNA_BO_DEV:
>> -        abo = amdxdna_drm_alloc_dev_bo(dev, args, filp);
>> -        break;
>> -    case AMDXDNA_BO_CMD:
>> -        abo = amdxdna_drm_create_cmd_bo(dev, args, filp);
>> +        abo = amdxdna_drm_create_dev_bo(dev, args, filp);
>>           break;
>>       default:
>>           return -EINVAL;
>> @@ -838,8 +834,8 @@ int amdxdna_drm_create_bo_ioctl(struct drm_device 
>> *dev, void *data, struct drm_f
>>       }
>>         XDNA_DBG(xdna, "BO hdl %d type %d userptr 0x%llx xdna_addr 
>> 0x%llx size 0x%lx",
>> -         args->handle, args->type, abo->mem.userptr,
>> -         abo->mem.dev_addr, abo->mem.size);
>> +         args->handle, args->type, amdxdna_gem_uva(abo),
>> +         amdxdna_gem_dev_addr(abo), abo->mem.size);
>>   put_obj:
>>       /* Dereference object reference. Handle holds it now. */
>>       drm_gem_object_put(to_gobj(abo));
>> @@ -890,38 +886,19 @@ void amdxdna_gem_unpin(struct amdxdna_gem_obj 
>> *abo)
>>   struct amdxdna_gem_obj *amdxdna_gem_get_obj(struct amdxdna_client 
>> *client,
>>                           u32 bo_hdl, u8 bo_type)
>>   {
>> -    struct amdxdna_dev *xdna = client->xdna;
>>       struct amdxdna_gem_obj *abo;
>>       struct drm_gem_object *gobj;
>> -    int ret;
>>         gobj = drm_gem_object_lookup(client->filp, bo_hdl);
>>       if (!gobj) {
>> -        XDNA_DBG(xdna, "Can not find bo %d", bo_hdl);
>> +        XDNA_DBG(client->xdna, "Can not find bo %d", bo_hdl);
>>           return NULL;
>>       }
>>         abo = to_xdna_obj(gobj);
>> -    if (bo_type != AMDXDNA_BO_INVALID && abo->type != bo_type)
>> -        goto put_obj;
>> -
>> -    if (bo_type != AMDXDNA_BO_CMD || abo->mem.kva)
>> +    if (bo_type == AMDXDNA_BO_INVALID || abo->type == bo_type)
>>           return abo;
>>   -    if (abo->mem.size > SZ_32K) {
>> -        XDNA_ERR(xdna, "Cmd bo is too big %ld", abo->mem.size);
>> -        goto put_obj;
>> -    }
>> -
>> -    ret = amdxdna_gem_obj_vmap(abo, &abo->mem.kva);
>> -    if (ret) {
>> -        XDNA_ERR(xdna, "Vmap cmd bo failed, ret %d", ret);
>> -        goto put_obj;
>> -    }
>> -
>> -    return abo;
>> -
>> -put_obj:
>>       drm_gem_object_put(gobj);
>>       return NULL;
>>   }
>> @@ -944,11 +921,8 @@ int amdxdna_drm_get_bo_info_ioctl(struct 
>> drm_device *dev, void *data, struct drm
>>       }
>>         abo = to_xdna_obj(gobj);
>> -    args->vaddr = abo->mem.userptr;
>> -    if (abo->mem.dev_addr != AMDXDNA_INVALID_ADDR)
>> -        args->xdna_addr = abo->mem.dev_addr;
>> -    else
>> -        args->xdna_addr = abo->mem.dma_addr;
>> +    args->vaddr = amdxdna_gem_uva(abo);
>> +    args->xdna_addr = amdxdna_gem_dev_addr(abo);
>>         if (abo->type != AMDXDNA_BO_DEV)
>>           args->map_offset = drm_vma_node_offset_addr(&gobj->vma_node);
>> @@ -993,8 +967,8 @@ int amdxdna_drm_sync_bo_ioctl(struct drm_device 
>> *dev,
>>         if (is_import_bo(abo))
>>           drm_clflush_sg(abo->base.sgt);
>> -    else if (abo->mem.kva)
>> -        drm_clflush_virt_range(abo->mem.kva + args->offset, 
>> args->size);
>> +    else if (amdxdna_gem_vmap(abo))
>> +        drm_clflush_virt_range(amdxdna_gem_vmap(abo) + args->offset, 
>> args->size);
>>       else if (abo->base.pages)
>>           drm_clflush_pages(abo->base.pages, gobj->size >> PAGE_SHIFT);
>>       else
>> diff --git a/drivers/accel/amdxdna/amdxdna_gem.h 
>> b/drivers/accel/amdxdna/amdxdna_gem.h
>> index fbeb622e7cf9..a77d9344f8a4 100644
>> --- a/drivers/accel/amdxdna/amdxdna_gem.h
>> +++ b/drivers/accel/amdxdna/amdxdna_gem.h
>> @@ -24,15 +24,16 @@ struct amdxdna_umap {
>>   };
>>     struct amdxdna_mem {
>> -    u64                userptr;
>>       void                *kva;
>> -    u64                dev_addr;
>>       u64                dma_addr;
>>       size_t                size;
>> -    struct page            **pages;
>> -    u32                nr_pages;
>>       struct list_head        umap_list;
>>       bool                map_invalid;
>> +    /*
>> +     * Cache the first mmap uva as PASID addr, which can be accessed 
>> by driver
>> +     * without taking notifier_lock.
>> +     */
>> +    u64                uva;
>>   };
>>     struct amdxdna_gem_obj {
>> @@ -40,11 +41,10 @@ struct amdxdna_gem_obj {
>>       struct amdxdna_client        *client;
>>       u8                type;
>>       bool                pinned;
>> -    struct mutex            lock; /* Protects: pinned */
>> +    struct mutex            lock; /* Protects: pinned, mem.kva */
>>       struct amdxdna_mem        mem;
>> -    u32                ref;
>>   -    /* Below members is uninitialized when needed */
>> +    /* Below members are initialized when needed */
>>       struct drm_mm            mm; /* For AMDXDNA_BO_DEV_HEAP */
>>       struct drm_mm_node        mm_node; /* For AMDXDNA_BO_DEV */
>>       u32                assigned_hwctx;
>> @@ -67,27 +67,29 @@ static inline void amdxdna_gem_put_obj(struct 
>> amdxdna_gem_obj *abo)
>>       drm_gem_object_put(to_gobj(abo));
>>   }
>>   +void *amdxdna_gem_vmap(struct amdxdna_gem_obj *abo);
>> +u64 amdxdna_gem_uva(struct amdxdna_gem_obj *abo);
>> +u64 amdxdna_gem_dev_addr(struct amdxdna_gem_obj *abo);
>> +
>>   static inline u64 amdxdna_dev_bo_offset(struct amdxdna_gem_obj *abo)
>>   {
>> -    return abo->mem.dev_addr - abo->client->dev_heap->mem.dev_addr;
>> +    return amdxdna_gem_dev_addr(abo) - 
>> amdxdna_gem_dev_addr(abo->client->dev_heap);
>>   }
>>   -static inline u64 amdxdna_obj_dma_addr(struct amdxdna_client *client,
>> -                       struct amdxdna_gem_obj *abo)
>> +static inline u64 amdxdna_obj_dma_addr(struct amdxdna_gem_obj *abo)
>>   {
>> -    return amdxdna_pasid_on(client) ? abo->mem.userptr : 
>> abo->mem.dma_addr;
>> +    return amdxdna_pasid_on(abo->client) ? amdxdna_gem_uva(abo) : 
>> abo->mem.dma_addr;
>>   }
>>     void amdxdna_umap_put(struct amdxdna_umap *mapp);
>>     struct drm_gem_object *
>> -amdxdna_gem_create_object_cb(struct drm_device *dev, size_t size);
>> +amdxdna_gem_create_shmem_object_cb(struct drm_device *dev, size_t 
>> size);
>>   struct drm_gem_object *
>>   amdxdna_gem_prime_import(struct drm_device *dev, struct dma_buf 
>> *dma_buf);
>>   struct amdxdna_gem_obj *
>> -amdxdna_drm_alloc_dev_bo(struct drm_device *dev,
>> -             struct amdxdna_drm_create_bo *args,
>> -             struct drm_file *filp);
>> +amdxdna_drm_create_dev_bo(struct drm_device *dev,
>> +              struct amdxdna_drm_create_bo *args, struct drm_file 
>> *filp);
>>     int amdxdna_gem_pin_nolock(struct amdxdna_gem_obj *abo);
>>   int amdxdna_gem_pin(struct amdxdna_gem_obj *abo);
>> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c 
>> b/drivers/accel/amdxdna/amdxdna_pci_drv.c
>> index 5143b8c9b92b..d83be00daf2b 100644
>> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
>> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
>> @@ -245,7 +245,7 @@ const struct drm_driver amdxdna_drm_drv = {
>>       .ioctls = amdxdna_drm_ioctls,
>>       .num_ioctls = ARRAY_SIZE(amdxdna_drm_ioctls),
>>   -    .gem_create_object = amdxdna_gem_create_object_cb,
>> +    .gem_create_object = amdxdna_gem_create_shmem_object_cb,
>>       .gem_prime_import = amdxdna_gem_prime_import,
>>   };
>>   diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c 
>> b/drivers/accel/amdxdna/amdxdna_ubuf.c
>> index fb71d6e3f44d..fb999aa25318 100644
>> --- a/drivers/accel/amdxdna/amdxdna_ubuf.c
>> +++ b/drivers/accel/amdxdna/amdxdna_ubuf.c
>> @@ -17,7 +17,6 @@
>>   struct amdxdna_ubuf_priv {
>>       struct page **pages;
>>       u64 nr_pages;
>> -    enum amdxdna_ubuf_flag flags;
>>       struct mm_struct *mm;
>>   };
>>   @@ -37,11 +36,9 @@ static struct sg_table *amdxdna_ubuf_map(struct 
>> dma_buf_attachment *attach,
>>       if (ret)
>>           goto err_free_sg;
>>   -    if (ubuf->flags & AMDXDNA_UBUF_FLAG_MAP_DMA) {
>> -        ret = dma_map_sgtable(attach->dev, sg, direction, 0);
>> -        if (ret)
>> -            goto err_free_table;
>> -    }
>> +    ret = dma_map_sgtable(attach->dev, sg, direction, 0);
>> +    if (ret)
>> +        goto err_free_table;
>>         return sg;
>>   @@ -56,11 +53,7 @@ static void amdxdna_ubuf_unmap(struct 
>> dma_buf_attachment *attach,
>>                      struct sg_table *sg,
>>                      enum dma_data_direction direction)
>>   {
>> -    struct amdxdna_ubuf_priv *ubuf = attach->dmabuf->priv;
>> -
>> -    if (ubuf->flags & AMDXDNA_UBUF_FLAG_MAP_DMA)
>> -        dma_unmap_sgtable(attach->dev, sg, direction, 0);
>> -
>> +    dma_unmap_sgtable(attach->dev, sg, direction, 0);
>>       sg_free_table(sg);
>>       kfree(sg);
>>   }
>> @@ -133,7 +126,6 @@ static const struct dma_buf_ops 
>> amdxdna_ubuf_dmabuf_ops = {
>>   };
>>     struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>> -                 enum amdxdna_ubuf_flag flags,
>>                    u32 num_entries, void __user *va_entries)
>>   {
>>       struct amdxdna_dev *xdna = to_xdna_dev(dev);
>> @@ -152,7 +144,6 @@ struct dma_buf *amdxdna_get_ubuf(struct 
>> drm_device *dev,
>>       if (!ubuf)
>>           return ERR_PTR(-ENOMEM);
>>   -    ubuf->flags = flags;
>>       ubuf->mm = current->mm;
>>       mmgrab(ubuf->mm);
>>   diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.h 
>> b/drivers/accel/amdxdna/amdxdna_ubuf.h
>> index e5cb3bdb3ec9..8900a6dc4371 100644
>> --- a/drivers/accel/amdxdna/amdxdna_ubuf.h
>> +++ b/drivers/accel/amdxdna/amdxdna_ubuf.h
>> @@ -8,12 +8,7 @@
>>   #include <drm/drm_device.h>
>>   #include <linux/dma-buf.h>
>>   -enum amdxdna_ubuf_flag {
>> -    AMDXDNA_UBUF_FLAG_MAP_DMA = 1,
>> -};
>> -
>>   struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>> -                 enum amdxdna_ubuf_flag flags,
>>                    u32 num_entries, void __user *va_entries);
>>     #endif /* _AMDXDNA_UBUF_H_ */
>> diff --git a/include/uapi/drm/amdxdna_accel.h 
>> b/include/uapi/drm/amdxdna_accel.h
>> index 5bd13f4435f5..d3a7b2aedb35 100644
>> --- a/include/uapi/drm/amdxdna_accel.h
>> +++ b/include/uapi/drm/amdxdna_accel.h
>> @@ -156,10 +156,11 @@ struct amdxdna_drm_config_hwctx {
>>     enum amdxdna_bo_type {
>>       AMDXDNA_BO_INVALID = 0,
>> -    AMDXDNA_BO_SHMEM,
>> -    AMDXDNA_BO_DEV_HEAP,
>> -    AMDXDNA_BO_DEV,
>> -    AMDXDNA_BO_CMD,
>> +    AMDXDNA_BO_SHMEM = 1,
>> +    AMDXDNA_BO_SHARE = 1,
>
> This is pretty weird to have an enum with two values that are the 
> same. Is it really intended?

Yes, it is intended. It is for backward compatibility. I will add a comment.


Lizhi

>
>> +    AMDXDNA_BO_DEV_HEAP = 2,
>> +    AMDXDNA_BO_DEV = 3,
>> +    AMDXDNA_BO_CMD = 4,
>>   };
>>     /**
>
