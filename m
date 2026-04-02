Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F37D6AAEC
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 17:38:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D321210E3F0;
	Thu,  2 Apr 2026 17:38:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gemyily8";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011019.outbound.protection.outlook.com [52.101.52.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6554010E0AD
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 17:38:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQVInIDBw453c+3KdbI0k+H5K9pvIIxN4ZIyL9JyksoylpkesogDB9ghGlII0EXt9lFV0Y4PGeE8Bsms9WhacABjrWlo2+i6ddClWk5fOYbaOB5qjIdlYBimhaFhKEw4B8OAgqAF7FbE7C82++ODja9qEniMecOaiB5Kasen+KArRkbNDYTs+agPecrffWksKYd7aUl6vA7eLZ26nDMEyQmCAn5cxkOUMOFkIBLD2prlyotBVfWsBlKL/Wf+T5PdCpn7mOs4fCUt9TTYQDtwF1rPqWfxpgIK1nFxzxzq55uha4iqYzUnnrzgjshZ2cTFT7NaAWTrdodFpWTFaDzwxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgeXkH05UpsMv+J+WSj6TBhHDku0fUx9T+o98w70apU=;
 b=QEuTeXr1Th8t72c765A2DjNcuOMBbmO+zb7ja3a7rJ9SxgbT9j1ewHbbZkf1/FCThkZurK6gxsJAwDmgXb54D2Syh85+gv9kdv9syOEzr6SzRp/GBko8R6awbJXiHnzxkjeGA/n7Q9nc4qvGsM5voKFwXuSgVwBd640jU2/E3Mna9bYmZBMlKJWOstHBLAIiwNQ+UtmDFpLCz62i7AKd/0Fbadga17eZRi0gxzLIxR6eFz9o3JQAEo6J0QKdFkROAV9aYwXZKYL7t4gOou4sBcvfAM1ybXuDDvbtYQaxJSgdplMvVN4Fu68WosxXENBJ8qy2nvNLlpXl9Kbxyvl4Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgeXkH05UpsMv+J+WSj6TBhHDku0fUx9T+o98w70apU=;
 b=gemyily89TZS1u8zyrF4XVyuSQhokZvCIqcdsFcukUFzmIUdMP2bxZw1YeLnkO6AEpR/QM/H+AqQDc5KJXppMyzDrvjM2jeM3aM329ssLlGxSkxL7t7zcjUEG9oDt+SqRSSwjCTerLcRHykMCzTqYuqzUAh49gWXLXZec5S+0yo=
Received: from CY5P221CA0112.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:1f::32)
 by CY5PR12MB6345.namprd12.prod.outlook.com (2603:10b6:930:22::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 17:37:55 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:930:1f:cafe::e3) by CY5P221CA0112.outlook.office365.com
 (2603:10b6:930:1f::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.20 via Frontend Transport; Thu,
 2 Apr 2026 17:37:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 17:37:54 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 12:37:47 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 10:37:45 -0700
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Apr 2026 12:37:45 -0500
Message-ID: <c4bb58a7-3174-4e3f-2f67-0f09d7087d34@amd.com>
Date: Thu, 2 Apr 2026 10:37:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Adjust size for copy_to_user()
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <maciej.falkowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <max.zhen@amd.com>, <sonal.santan@amd.com>
References: <20260402171441.3525556-1-lizhi.hou@amd.com>
 <ee3f4041-dc0d-4c4f-b8b7-fdfbda97014f@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <ee3f4041-dc0d-4c4f-b8b7-fdfbda97014f@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|CY5PR12MB6345:EE_
X-MS-Office365-Filtering-Correlation-Id: 15427c77-27f2-4e1a-57b3-08de90de928f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: Z9N0k13PUbJ/j2MnGb+iJOb2lp2oQOw8KKts9Pqi9qcSMFcZlr0wv8xlCho8LS6t+Q4mLVbjnL8IRRex5Ff14RR7R5jdwoTU7F3egI6IBdIAs0M5p9eNzsS/wmu2T2/ViMHRQbnC5P87mbRWDnBcytTFKEf/Z9gOevmgt7NVomFK9GlT1Uu4do6EZlYPf5dN6Drw4RX3e86sI743JIxyrNvV0u23EGKSErK66RCYCSFJ+YIN+gkVYYpMP1aasCvVbflm++tyXmGlM+20LkV5tqIM/HkX6uYILgfUkFLdt2x2SbaZiYyc06gSy3Apc25stJNN+4BG4hlJF5Zoaav3vytuvtrhbwM9eUQoII4oMWiAZqOJaIwJpesGI13UseDUdIanHD7reCOmw5j01CV63jD9RqnDzvYk68MNuY37f8LG511rAu9f8FViFPsjqdZcK96NqJfvuQXspWM0G2+AtH93E+qOV2BtjV+F6HtZ2My0aFaBoiQDMj5kulpTUmYT9Sg8wKkLWeB42sCt1k1k30TqAmOYPNc1Zi2wYqILXGFFX62dQOb78kWdwW5CrfihX3Hkf292UMTPKV/OXaywP9yDKo+Q7hcFFU4cpYzfZVgRD7i6tVZpjkFrVPPkSmnSXGML6xV7+GBynQM7Fxra6QMDN0YSex6WFwuoaKt83d8xHlspNMr7r1HR+hTRp2R3hcsbwMIqdTTp5KvfwppstTd+/IMKACG81GM1sDDZWn3oZcCFA5fLo8BENxCdjgXMdXMmWmuZoH9eB7VHdxiqCQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kCs59a90Fo04sN7Le6fBv7F4bpk8MWGEuKvv+5bhFsVR6dmNNiiMtQ6WIIqtbyDgkQdnAAM36IZNK9O6x7oiWOfK0C+2h20WEFwvsukIwK9I62zJQDsWj1eKWvOExnEGJxkN4T8+C4zspDEwEc8IpHs2swFUKbHtoTEGMy+0Xdk3abWjflMFTs18Jdu+/hc72vTBs8NyK1D6/dkbP10XWXdC/819fActXKaVSuqBHCLZ1hLUJ7s2lhrkbNGts2/voDTDAH6Ej80yP/CUGLtLW94kfM+yjSnDgeXt9nw1Uzb2K1oywMB1mRV3fcBEvyRQ1S9ofc1m4KimlCJApcJIpJkmwpSibSL9ZwnwGV5DobceQXhlomoGq8K7gLwqEPxkxyWfK/+n0Ti5kJ6L4njJBHDcv0+lnV1b4fB4ZiCzJtcp49i0gq3n9m+/b4e+wBnx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 17:37:54.8401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15427c77-27f2-4e1a-57b3-08de90de928f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6345
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


On 4/2/26 10:19, Mario Limonciello wrote:
> On 4/2/26 12:14 PM, Lizhi Hou wrote:
>> The amount of data returned to user space should be limited by the 
>> buffer
>> size provided by the application. If the buffer is smaller than the data
>> size, return only the portion that fits instead of failing.
>>
>
> Prolly should have a fixes tag for this I'd think.

Ok, wasn't sure if this needs a fixes tag. I will add one.

Lizhi

>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>> ---
>>   drivers/accel/amdxdna/aie2_error.c   |  5 ++-
>>   drivers/accel/amdxdna/aie2_message.c | 20 ++++++----
>>   drivers/accel/amdxdna/aie2_pci.c     | 59 ++++++++++++++++------------
>>   3 files changed, 50 insertions(+), 34 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/aie2_error.c 
>> b/drivers/accel/amdxdna/aie2_error.c
>> index 9d20e956c020..70007b4363cd 100644
>> --- a/drivers/accel/amdxdna/aie2_error.c
>> +++ b/drivers/accel/amdxdna/aie2_error.c
>> @@ -406,8 +406,11 @@ int aie2_get_array_async_error(struct 
>> amdxdna_dev_hdl *ndev, struct amdxdna_drm_
>>         drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
>>   +    if (!args->num_element)
>> +        return -EINVAL;
>> +
>>       args->num_element = 1;
>> -    args->element_size = sizeof(ndev->last_async_err);
>> +    args->element_size = min(args->element_size, 
>> sizeof(ndev->last_async_err));
>>       if (copy_to_user(u64_to_user_ptr(args->buffer),
>>                &ndev->last_async_err, args->element_size))
>>           return -EFAULT;
>> diff --git a/drivers/accel/amdxdna/aie2_message.c 
>> b/drivers/accel/amdxdna/aie2_message.c
>> index e5e7da7a8f40..e52dc7ea9fc7 100644
>> --- a/drivers/accel/amdxdna/aie2_message.c
>> +++ b/drivers/accel/amdxdna/aie2_message.c
>> @@ -369,12 +369,13 @@ int aie2_query_status(struct amdxdna_dev_hdl 
>> *ndev, char __user *buf,
>>   {
>>       DECLARE_AIE_MSG(aie_column_info, MSG_OP_QUERY_COL_STATUS);
>>       struct amdxdna_dev *xdna = ndev->aie.xdna;
>> -    u32 buf_sz = size, aie_bitmap = 0;
>> +    u32 buf_sz, aie_bitmap = 0;
>>       struct amdxdna_client *client;
>>       dma_addr_t dma_addr;
>>       u8 *buff_addr;
>>       int ret;
>>   +    buf_sz = ndev->metadata.cols * ndev->metadata.size;
>>       buff_addr = aie2_alloc_msg_buffer(ndev, &buf_sz, &dma_addr);
>>       if (IS_ERR(buff_addr))
>>           return PTR_ERR(buff_addr);
>> @@ -398,13 +399,14 @@ int aie2_query_status(struct amdxdna_dev_hdl 
>> *ndev, char __user *buf,
>>         XDNA_DBG(xdna, "Query NPU status completed");
>>   -    if (size < resp.size) {
>> +    if (buf_sz < resp.size) {
>>           ret = -EINVAL;
>> -        XDNA_ERR(xdna, "Bad buffer size. Available: %u. Needs: %u", 
>> size, resp.size);
>> +        XDNA_ERR(xdna, "Bad buffer size. Available: %u. Needs: %u", 
>> buf_sz, resp.size);
>>           goto fail;
>>       }
>>   -    if (copy_to_user(buf, buff_addr, resp.size)) {
>> +    size = min(size, resp.size);
>> +    if (copy_to_user(buf, buff_addr, size)) {
>>           ret = -EFAULT;
>>           XDNA_ERR(xdna, "Failed to copy NPU status to user space");
>>           goto fail;
>> @@ -424,13 +426,14 @@ int aie2_query_telemetry(struct amdxdna_dev_hdl 
>> *ndev,
>>       DECLARE_AIE_MSG(get_telemetry, MSG_OP_GET_TELEMETRY);
>>       struct amdxdna_dev *xdna = ndev->aie.xdna;
>>       dma_addr_t dma_addr;
>> -    u32 buf_sz = size;
>> +    u32 buf_sz;
>>       u8 *addr;
>>       int ret;
>>         if (header->type >= MAX_TELEMETRY_TYPE)
>>           return -EINVAL;
>>   +    buf_sz = min(size, SZ_4M);
>>       addr = aie2_alloc_msg_buffer(ndev, &buf_sz, &dma_addr);
>>       if (IS_ERR(addr))
>>           return PTR_ERR(addr);
>> @@ -446,13 +449,14 @@ int aie2_query_telemetry(struct amdxdna_dev_hdl 
>> *ndev,
>>           goto free_buf;
>>       }
>>   -    if (size < resp.size) {
>> +    if (buf_sz < resp.size) {
>>           ret = -EINVAL;
>> -        XDNA_ERR(xdna, "Bad buffer size. Available: %u. Needs: %u", 
>> size, resp.size);
>> +        XDNA_ERR(xdna, "Bad buffer size. Available: %u. Needs: %u", 
>> buf_sz, resp.size);
>>           goto free_buf;
>>       }
>>   -    if (copy_to_user(buf, addr, resp.size)) {
>> +    size = min(size, resp.size);
>> +    if (copy_to_user(buf, addr, size)) {
>>           ret = -EFAULT;
>>           XDNA_ERR(xdna, "Failed to copy telemetry to user space");
>>           goto free_buf;
>> diff --git a/drivers/accel/amdxdna/aie2_pci.c 
>> b/drivers/accel/amdxdna/aie2_pci.c
>> index 164e188ba501..041cbc8cd7e5 100644
>> --- a/drivers/accel/amdxdna/aie2_pci.c
>> +++ b/drivers/accel/amdxdna/aie2_pci.c
>> @@ -620,23 +620,19 @@ static void aie2_fini(struct amdxdna_dev *xdna)
>>   static int aie2_get_aie_status(struct amdxdna_client *client,
>>                      struct amdxdna_drm_get_info *args)
>>   {
>> -    struct amdxdna_drm_query_aie_status status;
>> +    struct amdxdna_drm_query_aie_status status = {};
>>       struct amdxdna_dev *xdna = client->xdna;
>>       struct amdxdna_dev_hdl *ndev;
>> +    u32 buf_sz;
>>       int ret;
>>         ndev = xdna->dev_handle;
>> -    if (copy_from_user(&status, u64_to_user_ptr(args->buffer), 
>> sizeof(status))) {
>> +    buf_sz = min(args->buffer_size, sizeof(status));
>> +    if (copy_from_user(&status, u64_to_user_ptr(args->buffer), 
>> buf_sz)) {
>>           XDNA_ERR(xdna, "Failed to copy AIE request into kernel");
>>           return -EFAULT;
>>       }
>>   -    if (ndev->metadata.cols * ndev->metadata.size < 
>> status.buffer_size) {
>> -        XDNA_ERR(xdna, "Invalid buffer size. Given Size: %u. Need 
>> Size: %u.",
>> -             status.buffer_size, ndev->metadata.cols * 
>> ndev->metadata.size);
>> -        return -EINVAL;
>> -    }
>> -
>>       ret = aie2_query_status(ndev, u64_to_user_ptr(status.buffer),
>>                   status.buffer_size, &status.cols_filled);
>>       if (ret) {
>> @@ -644,7 +640,7 @@ static int aie2_get_aie_status(struct 
>> amdxdna_client *client,
>>           return ret;
>>       }
>>   -    if (copy_to_user(u64_to_user_ptr(args->buffer), &status, 
>> sizeof(status))) {
>> +    if (copy_to_user(u64_to_user_ptr(args->buffer), &status, buf_sz)) {
>>           XDNA_ERR(xdna, "Failed to copy AIE request info to user 
>> space");
>>           return -EFAULT;
>>       }
>> @@ -659,6 +655,7 @@ static int aie2_get_aie_metadata(struct 
>> amdxdna_client *client,
>>       struct amdxdna_dev *xdna = client->xdna;
>>       struct amdxdna_dev_hdl *ndev;
>>       int ret = 0;
>> +    u32 buf_sz;
>>         ndev = xdna->dev_handle;
>>       meta = kzalloc_obj(*meta);
>> @@ -690,7 +687,8 @@ static int aie2_get_aie_metadata(struct 
>> amdxdna_client *client,
>>       meta->shim.lock_count = ndev->metadata.shim.lock_count;
>>       meta->shim.event_reg_count = ndev->metadata.shim.event_reg_count;
>>   -    if (copy_to_user(u64_to_user_ptr(args->buffer), meta, 
>> sizeof(*meta)))
>> +    buf_sz = min(args->buffer_size, sizeof(*meta));
>> +    if (copy_to_user(u64_to_user_ptr(args->buffer), meta, buf_sz))
>>           ret = -EFAULT;
>>         kfree(meta);
>> @@ -703,12 +701,14 @@ static int aie2_get_aie_version(struct 
>> amdxdna_client *client,
>>       struct amdxdna_drm_query_aie_version version;
>>       struct amdxdna_dev *xdna = client->xdna;
>>       struct amdxdna_dev_hdl *ndev;
>> +    u32 buf_sz;
>>         ndev = xdna->dev_handle;
>>       version.major = ndev->version.major;
>>       version.minor = ndev->version.minor;
>>   -    if (copy_to_user(u64_to_user_ptr(args->buffer), &version, 
>> sizeof(version)))
>> +    buf_sz = min(args->buffer_size, sizeof(version));
>> +    if (copy_to_user(u64_to_user_ptr(args->buffer), &version, buf_sz))
>>           return -EFAULT;
>>         return 0;
>> @@ -719,13 +719,15 @@ static int aie2_get_firmware_version(struct 
>> amdxdna_client *client,
>>   {
>>       struct amdxdna_drm_query_firmware_version version;
>>       struct amdxdna_dev *xdna = client->xdna;
>> +    u32 buf_sz;
>>         version.major = xdna->fw_ver.major;
>>       version.minor = xdna->fw_ver.minor;
>>       version.patch = xdna->fw_ver.sub;
>>       version.build = xdna->fw_ver.build;
>>   -    if (copy_to_user(u64_to_user_ptr(args->buffer), &version, 
>> sizeof(version)))
>> +    buf_sz = min(args->buffer_size, sizeof(version));
>> +    if (copy_to_user(u64_to_user_ptr(args->buffer), &version, buf_sz))
>>           return -EFAULT;
>>         return 0;
>> @@ -737,11 +739,13 @@ static int aie2_get_power_mode(struct 
>> amdxdna_client *client,
>>       struct amdxdna_drm_get_power_mode mode = {};
>>       struct amdxdna_dev *xdna = client->xdna;
>>       struct amdxdna_dev_hdl *ndev;
>> +    u32 buf_sz;
>>         ndev = xdna->dev_handle;
>>       mode.power_mode = ndev->pw_mode;
>>   -    if (copy_to_user(u64_to_user_ptr(args->buffer), &mode, 
>> sizeof(mode)))
>> +    buf_sz = min(args->buffer_size, sizeof(mode));
>> +    if (copy_to_user(u64_to_user_ptr(args->buffer), &mode, buf_sz))
>>           return -EFAULT;
>>         return 0;
>> @@ -754,6 +758,7 @@ static int aie2_get_clock_metadata(struct 
>> amdxdna_client *client,
>>       struct amdxdna_dev *xdna = client->xdna;
>>       struct amdxdna_dev_hdl *ndev;
>>       int ret = 0;
>> +    u32 buf_sz;
>>         ndev = xdna->dev_handle;
>>       clock = kzalloc_obj(*clock);
>> @@ -766,7 +771,8 @@ static int aie2_get_clock_metadata(struct 
>> amdxdna_client *client,
>>       snprintf(clock->h_clock.name, sizeof(clock->h_clock.name), "H 
>> Clock");
>>       clock->h_clock.freq_mhz = ndev->hclk_freq;
>>   -    if (copy_to_user(u64_to_user_ptr(args->buffer), clock, 
>> sizeof(*clock)))
>> +    buf_sz = min(args->buffer_size, sizeof(*clock));
>> +    if (copy_to_user(u64_to_user_ptr(args->buffer), clock, buf_sz))
>>           ret = -EFAULT;
>>         kfree(clock);
>> @@ -792,12 +798,14 @@ static int aie2_get_sensors(struct 
>> amdxdna_client *client,
>>       scnprintf(sensor.label, sizeof(sensor.label), "Total Power");
>>       scnprintf(sensor.units, sizeof(sensor.units), "mW");
>>   +    if (args->buffer_size < sizeof(sensor))
>> +        goto out;
>> +
>>       if (copy_to_user(u64_to_user_ptr(args->buffer), &sensor, 
>> sizeof(sensor)))
>>           return -EFAULT;
>>   +    args->buffer_size -= sizeof(sensor);
>>       sensors_count++;
>> -    if (args->buffer_size <= sensors_count * sizeof(sensor))
>> -        goto out;
>>         for (i = 0; i < min_t(u32, ndev->total_col, 8); i++) {
>>           memset(&sensor, 0, sizeof(sensor));
>> @@ -807,13 +815,15 @@ static int aie2_get_sensors(struct 
>> amdxdna_client *client,
>>           scnprintf(sensor.label, sizeof(sensor.label), "Column %d 
>> Utilization", i);
>>           scnprintf(sensor.units, sizeof(sensor.units), "%%");
>>   +        if (args->buffer_size < sizeof(sensor))
>> +            goto out;
>> +
>>           if (copy_to_user(u64_to_user_ptr(args->buffer) + 
>> sensors_count * sizeof(sensor),
>>                    &sensor, sizeof(sensor)))
>>               return -EFAULT;
>>   +        args->buffer_size -= sizeof(sensor);
>>           sensors_count++;
>> -        if (args->buffer_size <= sensors_count * sizeof(sensor))
>> -            goto out;
>>       }
>>     out:
>> @@ -909,6 +919,7 @@ static int aie2_query_resource_info(struct 
>> amdxdna_client *client,
>>       const struct amdxdna_dev_priv *priv;
>>       struct amdxdna_dev_hdl *ndev;
>>       struct amdxdna_dev *xdna;
>> +    u32 buf_sz;
>>         xdna = client->xdna;
>>       ndev = xdna->dev_handle;
>> @@ -920,7 +931,8 @@ static int aie2_query_resource_info(struct 
>> amdxdna_client *client,
>>       res_info.npu_tops_curr = ndev->curr_tops;
>>       res_info.npu_task_curr = ndev->hwctx_num;
>>   -    if (copy_to_user(u64_to_user_ptr(args->buffer), &res_info, 
>> sizeof(res_info)))
>> +    buf_sz = min(args->buffer_size, sizeof(res_info));
>> +    if (copy_to_user(u64_to_user_ptr(args->buffer), &res_info, buf_sz))
>>           return -EFAULT;
>>         return 0;
>> @@ -956,12 +968,7 @@ static int aie2_get_telemetry(struct 
>> amdxdna_client *client,
>>           XDNA_ERR(xdna, "Invalid buffer size");
>>           return -EINVAL;
>>       }
>> -
>>       telemetry_data_sz = args->buffer_size - header_sz;
>> -    if (telemetry_data_sz > SZ_4M) {
>> -        XDNA_ERR(xdna, "Buffer size is too big, %d", 
>> telemetry_data_sz);
>> -        return -EINVAL;
>> -    }
>>         header = kzalloc(header_sz, GFP_KERNEL);
>>       if (!header)
>> @@ -1002,6 +1009,7 @@ static int aie2_get_preempt_state(struct 
>> amdxdna_client *client,
>>       struct amdxdna_drm_attribute_state state = {};
>>       struct amdxdna_dev *xdna = client->xdna;
>>       struct amdxdna_dev_hdl *ndev;
>> +    u32 buf_sz;
>>         ndev = xdna->dev_handle;
>>       if (args->param == DRM_AMDXDNA_GET_FORCE_PREEMPT_STATE)
>> @@ -1009,7 +1017,8 @@ static int aie2_get_preempt_state(struct 
>> amdxdna_client *client,
>>       else if (args->param == 
>> DRM_AMDXDNA_GET_FRAME_BOUNDARY_PREEMPT_STATE)
>>           state.state = ndev->frame_boundary_preempt;
>>   -    if (copy_to_user(u64_to_user_ptr(args->buffer), &state, 
>> sizeof(state)))
>> +    buf_sz = min(args->buffer_size, sizeof(state));
>> +    if (copy_to_user(u64_to_user_ptr(args->buffer), &state, buf_sz))
>>           return -EFAULT;
>>         return 0;
>
