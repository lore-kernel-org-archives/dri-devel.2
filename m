Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 908E3CD37AA
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 21:23:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFB4710F276;
	Thu,  7 May 2026 21:23:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="htImcJli";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010017.outbound.protection.outlook.com
 [40.93.198.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D0F910F276
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 21:23:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEHMcNnObETb7bHFPsEbV3ZdR5nbrPXT8ivYeTkO8O2ae9y7ZomzypQ2ztTc/NM8kgDKAD5PD6vZywdoB07l9uJzHz4ChXj0TTyLjVb+WcaD0KNgtNzqZInMXw42+PD7Ux27PimzKlVyfM/nFKXmqgydo1qwBfzWiy7sl6MEJMbFrlAYP4ss4GFC58dYPPEdU8iHTT0/ELxvRzYKje+ZyiiQ3CGw7K60HZcdCc2NWsTyFu60KSUReZItF+zSCndBaXfgEjgq5T/OYJ9i8Ix3XUfnD4j9OOSuQ5fdY9+98rgldUQwgI/1wSYoIN7pS6KSnCKcksO3kH0AYpJI7Nkjdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjX9+tuWJwn7fGszc/+ut5JM/BFFrNds7z5WN1W0xrs=;
 b=lCyNLEYfmtCAuwSzeoLXD02B/YdUSs/Tnwnh7ZIGP42pwOz+2P6I7bHAQ/uKCvKQzgf41QA9tdYjMOumIFmN3AXOY/iYmoPSu83b4ZcPKlTqJKRA7QmLoiNtIkfdOUafZqdepmley8cERSKseYoYmZPEx4OlIRRc4VYxDb4fTpPejPjo9hbDmecpEuxebLi0a7uoQFcEgFyD3M2cGKcYUU9j/+vO7ycKB54NqGTpXJTi9Rewb7EH8RMP9Z9JTrRbZ4FXK/7VzqPd1Og0KA7gZduetCONP60YevUT/tV7K4Q7Y8fCfBI7QTVMGBvzAbhfvwX1kliD4fpPekWxu6MQ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjX9+tuWJwn7fGszc/+ut5JM/BFFrNds7z5WN1W0xrs=;
 b=htImcJlijyUTXVQLuo2IOnEq7tJe5ZALjmQ6OR2Ejvn6QsEV0MqCrWidZ200ZixYDboO+0aWAUL/8hP5I9upaWmBc/I3Iv1+PQ70aW0BAHzwRaS8D4h2oBKCyTfarDsi948l447xMh9gSlTMNJBM5slJVPQrN/RN9+5X4R8WecA=
Received: from BN9PR03CA0433.namprd03.prod.outlook.com (2603:10b6:408:113::18)
 by SJ0PR12MB6734.namprd12.prod.outlook.com (2603:10b6:a03:478::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Thu, 7 May
 2026 21:23:09 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:408:113:cafe::74) by BN9PR03CA0433.outlook.office365.com
 (2603:10b6:408:113::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.16 via Frontend Transport; Thu,
 7 May 2026 21:23:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.1 via Frontend Transport; Thu, 7 May 2026 21:23:08 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 7 May
 2026 16:23:08 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 7 May
 2026 14:23:08 -0700
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 7 May 2026 16:23:07 -0500
Message-ID: <73364760-c053-6be0-20a6-3ed549114797@amd.com>
Date: Thu, 7 May 2026 14:23:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Fix clflush buffer size
Content-Language: en-US
To: Mario Limonciello <superm1@kernel.org>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <max.zhen@amd.com>, <sonal.santan@amd.com>
References: <20260507040207.178111-1-lizhi.hou@amd.com>
 <88330822-679b-497a-a2a1-93e0176cf022@kernel.org>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <88330822-679b-497a-a2a1-93e0176cf022@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|SJ0PR12MB6734:EE_
X-MS-Office365-Filtering-Correlation-Id: e2eb68a9-d55a-4319-0b76-08deac7ed5bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: FjzCNU0ncQ4NFxvsz1kSZWZLKOx6nI173CI6RgZdnWMi3vYfeqtkwOPOl8TU3PoNyvcklM5VVCoGeFcCVw+y5BWi8ayOXw2vaV1Q4KesiPEozE4xC1MJeoacpIK5iI5f24my5mS+jkMUOxgw135+6XEBJ1kP2qBdvohjEnZq6y2usqtB6LvsbWceRiu3Smzxv2Ql6J7ArYpnEHKcOYv6yvaO5sWsoIGGElWlyjXeGY5XzMHXogzX/UeUJgZF/3J/Ktdt6OeY0Vnk6ztUc84yBh62d1jn709CJsbCDfJ/R9zq973LgkEVcskVio2ajecbIP0scXkIfzulpQMbS3l5MdlpgG5KtGCHH+e965nzVRcdCfENTKfI1blxbqUPTdeBRjggHqC0Wn6fgp55mH26zo4/U3TcrwsVz1EAhnMZL2/JWWN5VUuDhWGhy0OwDxQilW/ALAcvJTMMcrbBch+AF3b9n0WGdEFYe66y6z7VV22r27t1tja00UawgMNKhvcXrCHnre66uo6vqdrSBKxzban+hafMTjTEgA43vbCJa7NIzJ5yTCop+yQdlhcS9xG2qI1sWR/CcG70RKVpu3Cv4cryVPNC98OM7XDP0VFQF+tP9fmAhK3Ib26kX8icgne0+jnRDAv/KHCOE59aPQpW/dgqsDvHttmE4eRahcEFbiPX5ag7/ODTTaS7lCBDwuI5hLbH62a1eKGON9l6ojDZnJaNKSvJpa/jU7149LIarfM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VlsYXTh01JXJZavKB0xid28CJFT5iNHf0F0D1IwRpcdWqQcf/wIE6LriKgQPyNpevJ9Cm6MwAoFNpmHZDlneDVo/DECwFgrDNEAlRCzOsl94+Eda4lXRzd7dPHJBhaF70TbhQp1EJ3Z3UjMBZzLSTuJEaKinMKWpP4QzWrOvWdFyZWA6J670kLyv0d7vJPJPSxrFXS27GPOCPOnJ6hmO6Z9osAA6Zd4hD9HnLr2FaxePhwLSE1xrTU/gl4yhJxcpRRoL1DQ9YFeon89s0ZldxYfzyTH7VRiBtrOkWxsX2lTWrgy7H4amAE24ZEUIv4lpeJQCtnNomWVE7AqRbTDsO/Rb820Fbc9J3rUa0v9UehRhuy10f5q5AmoNOIdzPIanMy5ULI8+1eWPPNXZopmZoiLz8Go117vVHjDgg3MMLpSJTs5w8F1hITNftHoJvH/C
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 21:23:08.4457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2eb68a9-d55a-4319-0b76-08deac7ed5bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6734
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

On 5/7/26 09:55, Mario Limonciello wrote:
>
>
> On 5/6/26 23:02, Lizhi Hou wrote:
>> The firmware is told the buffer is req.buf_size bytes. It may read/write
>> the entire region. If the CPU only flushes a subset, the remaining cache
>> lines could contain stale data, causing the device to see garbage.
>>
>> Fixes: 6e87001fe19f ("accel/amdxdna: Adjust size for copy_to_user()")
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> ---
>>   drivers/accel/amdxdna/aie2_message.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/aie2_message.c 
>> b/drivers/accel/amdxdna/aie2_message.c
>> index 6e98af7b74db..a012e7e935ad 100644
>> --- a/drivers/accel/amdxdna/aie2_message.c
>> +++ b/drivers/accel/amdxdna/aie2_message.c
>> @@ -390,7 +390,7 @@ int aie2_query_status(struct amdxdna_dev_hdl 
>> *ndev, char __user *buf,
>>       req.num_cols = hweight32(aie_bitmap);
>>       req.aie_bitmap = aie_bitmap;
>>   -    drm_clflush_virt_range(buff_addr, size); /* device can access */
>> +    drm_clflush_virt_range(buff_addr, req.dump_buff_size); /* device 
>> can access */
>>       ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
>>       if (ret) {
>>           XDNA_ERR(xdna, "Error during NPU query, status %d", ret);
>> @@ -442,7 +442,7 @@ int aie2_query_telemetry(struct amdxdna_dev_hdl 
>> *ndev,
>>       req.buf_size = buf_sz;
>>       req.type = header->type;
>>   -    drm_clflush_virt_range(addr, size); /* device can access */
>> +    drm_clflush_virt_range(addr, req.buf_size); /* device can access */
>>       ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
>>       if (ret) {
>>           XDNA_ERR(xdna, "Query telemetry failed, status %d", ret);
>> @@ -1186,7 +1186,7 @@ int aie2_query_app_health(struct 
>> amdxdna_dev_hdl *ndev, u32 context_id,
>>       req.context_id = context_id;
>>       req.buf_size = buf_size;
>>   -    drm_clflush_virt_range(buf, sizeof(*report));
>> +    drm_clflush_virt_range(buf, req.buf_size);
>>       ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
>>       if (ret) {
>>           XDNA_ERR(xdna, "Get app health failed, ret %d status 0x%x", 
>> ret, resp.status);
>
