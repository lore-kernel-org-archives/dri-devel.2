Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5634BF53D90
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 19:57:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6364010E3E9;
	Mon, 16 Mar 2026 19:57:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1Pjy+ZB3";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010027.outbound.protection.outlook.com [52.101.61.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBD6210E3E2
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 19:57:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ch1dR/VEEoFCdxrkMPbPV5Bb0xO2qvVHBuSFtN3QFBXldiebR7w0r6kLos/dJFYr4yebnwkpyLNhmQLsuOAKKShGJWgm+eGrLmTu2UBJEZt0Wy0pM6cyAM+QI++ucx71szczPIJZfUUR8xINfRrnQ0fSl2VKMDqnRkB/+i4IL2279umeEpCAIyEitU7T5yo4TYu98a9W2H8qZt7OJxutAdmbnGm5yKUY3j03+0XtpxDEkCTk6MnN1KIKRnBMGVmnAvcoi3VN1FiqnY3t31MQgwKXUtwLGAvI2MqUkD/2FHeZaXWPBao8cFIeiynik9+iewhjhTvCgcxF3liqeFBD0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ej6z2yUNGtWCSHTzFcGRyc796sPwfsJeY67tndG6Uc=;
 b=GmfjxnvQe5ebIMVj3wBdSB/wuIFRkrX8U1i3BNlzKehRRhjeC4FyzJaBS/Yz20LUo9qcLhTLvuvyAetsjvIpHIJp/fbSg1NWpP5NXJ5lZsV+gH/4j/DTOJJ2Tpqm3wXBm/DOJzQbvJd2Tan8yRLoN8l4KahGGmXvuaa0aMAn9Wz/G/yknmY16aLFbDiUyzQFDh0+8zA7FN/1fGYZH4XQsK80RmEWvX2f+0oRpDXtxOocCzl4v3pkQ6MWMb+BTW7hCgRsT323CAK6QLmnWqSNMu9ohL+bqJvIqcfRHWGZkGf/BYBHa+HuWP2qXZFcWDScCcDlVBLtzjKwnySRonjmGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ej6z2yUNGtWCSHTzFcGRyc796sPwfsJeY67tndG6Uc=;
 b=1Pjy+ZB3cUb2d65ZBBDD3kq5N6AcuKNx0dag0KqUr4xOSv/9NWvNmVeXdgP7bG/3CucA0+UjmeKmo8U6YrLhMXhVQOgS+Qvb7IwlrVkKeNglQVIEme8pVpFK/jxNIFllWrA/34vPHbZSrdHRuG05qS6slc6+o8ChjeZO8aqnnNY=
Received: from SJ0PR13CA0126.namprd13.prod.outlook.com (2603:10b6:a03:2c6::11)
 by IA1PR12MB6603.namprd12.prod.outlook.com (2603:10b6:208:3a1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 19:57:14 +0000
Received: from CO1PEPF00012E83.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::e) by SJ0PR13CA0126.outlook.office365.com
 (2603:10b6:a03:2c6::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Mon,
 16 Mar 2026 19:57:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E83.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 19:57:14 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 16 Mar
 2026 14:57:11 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Mar
 2026 14:57:11 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 16 Mar 2026 14:57:10 -0500
Message-ID: <48c3dc71-8162-1045-989f-5d5c6dea5cd1@amd.com>
Date: Mon, 16 Mar 2026 12:57:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2] accel/amdxdna: Add debug prints for command submission
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <maciej.falkowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <max.zhen@amd.com>, <sonal.santan@amd.com>
References: <20260316175642.1451749-1-lizhi.hou@amd.com>
 <1d2c1de6-3c2a-4c7e-b7a4-e3fbd5b8fdcb@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <1d2c1de6-3c2a-4c7e-b7a4-e3fbd5b8fdcb@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E83:EE_|IA1PR12MB6603:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aaaf5c5-3ebc-46b5-fdd7-08de83963814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9JCxUxDYEXAwKZFQp1vOLudEnfQFIuUo2iD+EaUnKc3hu2/pFSXKYfcyhUridJX0swxa7MnqdCaOIC0j8pvF/1yLyawc6OM6v0CuWddhOIekF17K5nB3VFqsCI6CWuC1CdngwTB0XMm2SvigCC5tfte7ae7NcOOHjNiuJ8LYoaD4fWSdIN1W6suyPNBB1E/GK/1phSOoZ1JEvm7fZ/50ShHJYCipieyYmqH8mkBBBiA4MUoYJF8x9Ghx+2AOFHCNavUOAf4fBekTj1Np68oDUL8m62xa7GyAxtJVv1WtUBbZeYY0W8dE8tRWA99rmwB7Pdckrnm4WlcMfM/z7IH0ls4uV0gtsCvqIM7g2L6tku5k6tVsfNFCoJftUJ6+SbjrexqVCx0IZJgcmRsjOXSzCYXTc/f3+oY/o5E/H4pkbciOWF+CFdcmmUcr2TwTkc4woKC2szKnenTLr372M/QO2GJPMAj8DH/7Uf3SuTZh4VJrMoIuGp8FeV3et7wO/VT0RvpVQ0ydVX2rEvtBQVy89bahPSiz/YMgEg2gzeGOfk30IZe2SaykbTrZNKuJ16EPTdp5r6DRALNQ6kZWQoMBFbSMlMoyUdoPSOK6Epa1lUbebtHqao2a9bSCn9ZfTFJfU2DbKtKQBFfc45wyODrHX0Nwu+Q5u5lGSQqtZcZ+I97PXqjW0L7wPVjE4KCwMZgQso6GZ9abu9jnCmvD0oK3RcwYWWWQbVtg/WnXfE3IBmK+YkV5m71I+v7GtePPs5UjuAffb8oG8IwOWHU2f5CdQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xosraP8FubfqeUN5JVtC0Mx2UkYiJvFRYNtwsJiaGfnBdlrtBK7wSSvLV0tAOTZOCpiyU5eiYRBS7D03d+d/5Egy3Sxb80aJRXmmKhOwi9zrIMSRFvZbjjFXFfN2QpLdp2iQwh8AtL00KS7OIw0LZL0nN0HPCOwSaDO60TXXulOlE35ZA6LItjQfHvlmqtCXYqvVI6p37lQmVfKb3E5uk9HrW+9iYy+ukBmU7q8oHjAfMVBW5e+pCvoAc9dwnnNSSSEiyXnpQvpgzmWVV85UmR8NpivacjqCexXoUVPaFM8hU2SAm1r9j17ATxVh47zEqbZx5d+nFTLpCsUVha+mIGw4aSQC9yxWFcunqjz3gDRPsUXYJm0GB+sXFfZ+udAdbkrmGNH6U5Hc78IvpDRxA16OyxzlO9+ODFaSbzzQA1QvhGvIWimH3FFi43ZmyxxN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 19:57:14.1092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aaaf5c5-3ebc-46b5-fdd7-08de83963814
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E83.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6603
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

On 3/16/26 11:02, Mario Limonciello wrote:
>
>
> On 3/16/26 12:56, Lizhi Hou wrote:
>> Add debug prints to help diagnose issues with incoming command 
>> submissions.
>>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>
>> ---
>>   drivers/accel/amdxdna/aie2_message.c | 34 ++++++++++++++++++++++++----
>>   1 file changed, 29 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/aie2_message.c 
>> b/drivers/accel/amdxdna/aie2_message.c
>> index b764c7e8816a..4ec591306854 100644
>> --- a/drivers/accel/amdxdna/aie2_message.c
>> +++ b/drivers/accel/amdxdna/aie2_message.c
>> @@ -1002,7 +1002,7 @@ int aie2_cmdlist_multi_execbuf(struct 
>> amdxdna_hwctx *hwctx,
>>       struct amdxdna_cmd_chain *payload;
>>       struct xdna_mailbox_msg msg;
>>       union exec_chain_req req;
>> -    u32 payload_len;
>> +    u32 payload_len, ccnt;
>>       u32 offset = 0;
>>       size_t size;
>>       int ret;
>> @@ -1011,12 +1011,24 @@ int aie2_cmdlist_multi_execbuf(struct 
>> amdxdna_hwctx *hwctx,
>>         op = amdxdna_cmd_get_op(cmd_abo);
>>       payload = amdxdna_cmd_get_payload(cmd_abo, &payload_len);
>> -    if (op != ERT_CMD_CHAIN || !payload ||
>> -        payload_len < struct_size(payload, data, 
>> payload->command_count))
>> +    if (op != ERT_CMD_CHAIN) {
>> +        XDNA_DBG(xdna, "Invalid op code %d", op);
>>           return -EINVAL;
>> +    }
>> +
>> +    if (!payload) {
>> +        XDNA_DBG(xdna, "Failed to get command payload");
>> +        return -EINVAL;
>> +    }
>> +
>> +    ccnt = payload->command_count;
>> +    if (payload_len < struct_size(payload, data, ccnt)) {
>> +        XDNA_DBG(xdna, "Invalid command count %d", ccnt);
>> +        return -EINVAL;
>> +    }
>>         op = ERT_INVALID_CMD;
>> -    for (i = 0; i < payload->command_count; i++) {
>> +    for (i = 0; i < ccnt; i++) {
>>           u32 boh = (u32)(payload->data[i]);
>>           struct amdxdna_gem_obj *abo;
>>   @@ -1035,19 +1047,26 @@ int aie2_cmdlist_multi_execbuf(struct 
>> amdxdna_hwctx *hwctx,
>>             offset += size;
>>       }
>> +
>> +    XDNA_DBG(xdna, "Total %d commands:", ccnt);
>> +    print_hex_dump_debug("cmdbufs: ", DUMP_PREFIX_OFFSET, 16, 4,
>> +                 cmdbuf_abo->mem.kva, offset, false);
>> +
>>       msg.opcode = EXEC_MSG_OPS(xdna)->get_chain_msg_op(op);
>>       if (msg.opcode == MSG_OP_MAX_OPCODE)
>>           return -EOPNOTSUPP;
>>         /* The offset is the accumulated total size of the cmd buffer */
>>       EXEC_MSG_OPS(xdna)->init_chain_req(&req, cmdbuf_abo->mem.dev_addr,
>> -                       offset, payload->command_count);
>> +                       offset, ccnt);
>>       drm_clflush_virt_range(cmdbuf_abo->mem.kva, offset);
>>         msg.handle = job;
>>       msg.notify_cb = notify_cb;
>>       msg.send_data = (u8 *)&req;
>>       msg.send_size = sizeof(req);
>> +    print_hex_dump_debug("cmdlist msg: ", DUMP_PREFIX_OFFSET, 16, 4,
>> +                 &req, msg.send_size, false);
>>       ret = xdna_mailbox_send_msg(chann, &msg, TX_TIMEOUT);
>>       if (ret) {
>>           XDNA_ERR(xdna, "Send message failed");
>> @@ -1076,6 +1095,9 @@ int aie2_cmdlist_single_execbuf(struct 
>> amdxdna_hwctx *hwctx,
>>       if (ret)
>>           return ret;
>>   +    print_hex_dump_debug("cmdbuf: ", DUMP_PREFIX_OFFSET, 16, 4,
>> +                 cmdbuf_abo->mem.kva, size, false);
>> +
>>       msg.opcode = EXEC_MSG_OPS(xdna)->get_chain_msg_op(op);
>>       if (msg.opcode == MSG_OP_MAX_OPCODE)
>>           return -EOPNOTSUPP;
>> @@ -1088,6 +1110,8 @@ int aie2_cmdlist_single_execbuf(struct 
>> amdxdna_hwctx *hwctx,
>>       msg.notify_cb = notify_cb;
>>       msg.send_data = (u8 *)&req;
>>       msg.send_size = sizeof(req);
>> +    print_hex_dump_debug("cmdlist msg: ", DUMP_PREFIX_OFFSET, 16, 4,
>> +                 &req, msg.send_size, false);
>>       ret = xdna_mailbox_send_msg(chann, &msg, TX_TIMEOUT);
>>       if (ret) {
>>           XDNA_ERR(hwctx->client->xdna, "Send message failed");
>
