Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18CDEE8537A
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 15:50:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B9BB10F28F;
	Fri,  3 Apr 2026 15:50:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MkU8dHcA";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010034.outbound.protection.outlook.com [52.101.201.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67C7A10F28F
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 15:50:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSLQ8z2tKnj6g5YENnVWqjoZKzgEcECjfJYw99P55MDC+QGxu+8osqgM4hQE9NQWaDUerJc5v5OzNmmmLvRI84RMBDDB47bpoOpgR930aQEeC9GeY9xRTPiC824rtGOvonCRhHLBiOFg3q4jzjRxgdvFb4neb+t+ChojX0nKrYH7KCSrcWi2xyDULF4nLePLL7YyKI71ddIYdJ28eqwvfUzsgNyF/5/pFNvycs9RzKeZUI0VhLyG43lRFFpBYR2rJMyvYsc7FaQrArOwXIHerXsvPQKVeGt9O6HPlFAs+OvDkltci2LpwSXyIvzzUM9gxzBGgTjp9avCSxsKJRTzgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3fI8nkebFrPOVh+NkfLGONKbxDhOGi8uprqfQuupt0=;
 b=WuXHTt+oiN42MKbFe0QXgBsHkJgSPHBYexI8AU6G5ccuOiZliD6NQhlv/V+bK2kKKvN0BR9lGXzneixpoYaWvRV80uS7aaUKy//brEdrf7em0bsWSc+bztHxA0QBn23o+gKPximxmno91S0Zlnw9JuQEhpZmtJWmc6Fv0bI/RbiqyMyzmACXyGBSmitXgwIBIRIHO0pvfGZwIivFbaO3ZwtpeE8WhfTdMSql9aGUBYNo1X1GIHhkwY58XJ7hEASrzAbopFN2wb5jDtoXZmMxPJZB0bdRgAYaEaQ/SAOw5kaZqs5cXabBETXyudd245jKdlyE1OlHxWL+WrMw7t+kQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3fI8nkebFrPOVh+NkfLGONKbxDhOGi8uprqfQuupt0=;
 b=MkU8dHcAkfBKOfD3eFadlkR5RRWa3BAIZl4LYGgt8FRfQCD7t1YHef4QqjsIIMPBk6Ml/nNeo7Yzuk00vsQN07Iyf9mlMiJLqCMqd9jw0ngzKjgSTWVPTFGQDJR3pNhLAvheCXIB9b8qhz9rCx3Y7UmRKCX8+dOjgvdkOjUCDLw=
Received: from MN2PR11CA0028.namprd11.prod.outlook.com (2603:10b6:208:23b::33)
 by CH3PR12MB9023.namprd12.prod.outlook.com (2603:10b6:610:17b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 3 Apr
 2026 15:50:22 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:23b:cafe::a) by MN2PR11CA0028.outlook.office365.com
 (2603:10b6:208:23b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.34 via Frontend Transport; Fri,
 3 Apr 2026 15:50:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 3 Apr 2026 15:50:22 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 3 Apr
 2026 10:50:21 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 3 Apr 2026 10:50:21 -0500
Message-ID: <474ea416-ddde-88ed-1751-9960dcaef5a2@amd.com>
Date: Fri, 3 Apr 2026 08:50:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2] accel/amdxdna: Adjust size for copy_to_user()
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <maciej.falkowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <max.zhen@amd.com>, <sonal.santan@amd.com>
References: <20260402174148.3527757-1-lizhi.hou@amd.com>
 <ec41932c-79b9-4301-a66f-e1a50ede017c@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <ec41932c-79b9-4301-a66f-e1a50ede017c@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|CH3PR12MB9023:EE_
X-MS-Office365-Filtering-Correlation-Id: 78a3eeb6-1b50-46d0-bb4d-08de9198b6c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: YECoJIMEcl6FdYXN/SV8cSIKFol/hNHglr0GYgswMJ97aTZPMIE5D+irM3pmGKR1trgffc5lvu6ML/QKeG1NL7AYjzVbt/Ettq8ERr4jKqo8SZpYKMnuqhElMBwQDPqvCdu3JOUxTcPLWrwNreCCh/W1W4Q3A2ndhEtZgDgQvZFAmGdtGJgyXMmp0JEtFXDDRA/ZxUpTGIU54G3jN/mwWVW3U10SdGhxrXrnuV2UTFFRO3IaS+TLs3lDzSeyw/e1hTJWV4vZsOuctP5CyVy478M2VlbYHsN+XAuvuGnDRAYhwuDtNFTdNNxnhy87jfz6ekgwyQAbmSxkx4KInU1kQIe7NpkpzOKG4OMJimtxEoOyR4tT7fo5MaBeEhNmIvgFcqi7fUEhBm3J0oy1haAI/6k+3MajD7tgQGiNoNcq9LEaS8Skhdm7N21YBnicfbhVCiB6esAKI4qI42gJoylDmJcqJogVZjoG6K2bVcmnCsawqoNQo+MVKP4zk5iNFc/+euHLq7vL/mMyUTOtNu2Pf2Dy+sPMvfiFQlZJgTtIokCU9jvfFPJoJ4a+iCgmVkwjULhlJtUUElHF/Nkgd1vFpTcQCVUOgV7Jo5EkQy7vYl1LxnEvHjZQgNfn6lNGZJk8IbeRTf+HDMd2ZTKpeLgHPe47w6bktHhEFVzztrXAmktFysB9m2OR0SU71MIpp/F3wQd/2TTB2RhoCLokG3knZEX0a+QCEVppJzpEnH9qGF1NxbgezdZSbfV44wqtUIa0lMHMhDxO5kcUM4Lh9DpJMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 66h/JpvburzfGznJF1jyFnJS0DnAL0MMZ7KYlRfsCHOttmwOEIxiQi4Icu+1mzbqt0DPqHBpG3QPFouaxLvo+kH37PqrEEtYBTbF66bw0WcHeOSjqsnDDOc1TL08x2AhpRPEqCxmZnJ1GqCQlq92vWbQAJrT0ymix5E8+H2xZgQKEbhNYcfULr5ZygPYtxHopSjpSHSqyBLomd0/foz7GpnKPQXEX6bwbO7YG+E+TF7ZSDXSd0d9a/B8fI87PeeBTGa+T4VSSc1zReahWplXE+Y/TBI0XylMLW/+CrhCZY1y6Iv1/hcZZJT5I79RhRhbAAVOMNZLEw6D+JMTV9dqOIM+P95ooKijaMuLFZq3B3F62djpBe37FB13n5vkiHGAsbBDne/AqX6CJ+v8F+RnGiWYbIMmL6JAHwEr49t+qaawef6BvMg7VrQ7M8uo5gvO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 15:50:22.0281 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a3eeb6-1b50-46d0-bb4d-08de9198b6c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9023
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


On 4/2/26 14:06, Mario Limonciello wrote:
> On 4/2/26 12:41 PM, Lizhi Hou wrote:
>> The amount of data returned to user space should be limited by the 
>> buffer
>> size provided by the application. If the buffer is smaller than the data
>> size, return only the portion that fits instead of failing.
>>
>> Fixes: 850d71f6bf4c ("accel/amdxdna: Add query functions")
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
>
> I don't really follow.  Why check if args->num_element is 0 and then 
> set it to 1?  Does the check actually make sense?  Just set it to one 
> and ignore what's there before.

args->num_element is used as both user input and output argument.

As a input argument, it means the max number of element user expected. 
Expecting 0 element doe not make sense, thus -EINVAL is returned.

As a output argument, driver fills actual number of element being 
returned. One element is returned for getting async error case.

>
> If it's for protecting args like a NULL args->buffer, wouldn't it make 
> more sense to check for that?
>
>> -    args->element_size = sizeof(ndev->last_async_err);
>> +    args->element_size = min(args->element_size, 
>> sizeof(ndev->last_async_err));
>
> As this comes from userspace, couldn't it end up being clamped if 
> userspace sends a smaller buffer?  Is that intended?

Yes, it is possible user sends smaller buffer. In this case, driver 
fills partial of its data. This is intended.


>
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
>
> Don't you want to respect /check the size of the caller immediately?  
> It seems odd to hardcode it here at allocation time.

ndev->metadata.cols * ndev->metadata.size is from firmware but not user 
space. So it does not need to check.


Thanks,

Lizhi

>
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
