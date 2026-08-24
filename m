Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39369C5DF9C
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 16:41:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 876D110E57A;
	Mon, 24 Aug 2026 16:41:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t1qus+2s";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011021.outbound.protection.outlook.com [52.101.57.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FD5088D18
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 16:41:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oU3x4B+TqrWaQfHXUt8d3OWU7pYJNFF/2pZ5wA2SJLhNnIu1xpqgBtiN2Y6MQSIPyhrYHgxgckZ7aFhDfjahl3ih5dhWDytMWzhiFpr2NPIrf6ga0vvgPbMx2/eejj/yA17UOj3uorHjxn1OF2aHUeQ4K2p1WWcuFhBe5snHqBtIdzkRVEFiOvHRLlmvt4ymgt2qSUdWTlHvBT67lxr57LiosonPezbcKvBu9hbGzaPuqDmrbrdiru6Vj3ZjaVyrDbUWChSykAIdWOOvyyLD3PSstZmiLWJ4zlLGsJSyDHCCItXmacdvPaa2ksPq7C367X+EGbgBPN+O7DFx/bT5RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxFeIwruXxc+/YVKnFXgvtZDcjQkEjgGspmXUu1YGu8=;
 b=vpGvHXQXFpZFx+bB8zrO5Mt7Mv1Ogzpsz7TheCkn5U6e8R20oygt9iNwHOBMakf2sXpC5DN7rt4BOkZfclWzwxK/CRL+QZenWPwA5V7b2QLbHpLAIFSa1y4/QqRwrN8HguZw9PNDX7T5l+aaI4S/wObcikoItNvNCrCElIqSgT1ZgdtALmNvATnsbam8lnKm0RVLjT/0KNRiMRnwHBHdtF0FjlxU0Yz3UInjDiVpvKC4d8IR7Am8clL3VNAh5Zm750MR04Ro8XDprSrFytT0RpJWX0uo4yw7gmY9PVyIgmdVID2pfbNbNxFaojuXctELEh20vn5+/l8Z2G7aeaByZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kaitmazov.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxFeIwruXxc+/YVKnFXgvtZDcjQkEjgGspmXUu1YGu8=;
 b=t1qus+2sRWsDmz5CeKUGM7k9xXMdk3ko8dqg1pp+bI9VeajGGielmmkRMVjcyoDHQNMA5X/C4G+6f1f20W/mWL5fIA1r3RbUqmXFs1sZsb/xDKJMFIsS0L6gB/Lx+ZgI+1IV//EusDbm3HvrXPl/wwDJLv7PLCQGcCL9eiRQ+Ng=
Received: from SJ2PR07CA0022.namprd07.prod.outlook.com (2603:10b6:a03:505::24)
 by PH0PR12MB5605.namprd12.prod.outlook.com (2603:10b6:510:129::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 16:40:55 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::46) by SJ2PR07CA0022.outlook.office365.com
 (2603:10b6:a03:505::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 16:40:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 16:40:55 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 11:40:55 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 11:40:54 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 11:40:54 -0500
Message-ID: <c66806ab-9944-0524-c36a-688dc0f05641@amd.com>
Date: Mon, 24 Aug 2026 09:40:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] accel/amdxdna: reject a command chain that carries no
 commands
Content-Language: en-US
From: Lizhi Hou <lizhi.hou@amd.com>
To: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>, <mamin506@gmail.com>,
 <ogabbay@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20260818000019.369366-1-taimuraz@kaitmazov.com>
 <21089f21-ba36-69eb-2b9c-642fb0ab1498@amd.com>
In-Reply-To: <21089f21-ba36-69eb-2b9c-642fb0ab1498@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|PH0PR12MB5605:EE_
X-MS-Office365-Filtering-Correlation-Id: c39925ca-4d36-4e3f-e455-08df01fe77e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|18002099003|22082099003|11063799006|56012099006|3023799007|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: MUjSZ2cFKqMQTFMZDUIsc+9e6kljWjIOWsrCiMn9761Ym1h1I2d7DqYY7Ax+tdT8w///vl1rMP/mjkunYyAraQwFprB1npbGOE/GEZcTCUqyIRWkfQXTTRhj1zWHdn+TNTAdXTIf+XBqzpalKO1juVkmE7x6JykDEsiOB/QzYg7oX2HaokNA6scs5mem9kPieb/x0ixsoDbznhlVeqafVhih283NHPkwvcosS1zaZCVDGR1Mmqv805qDSW/MAWcXYilYvnYxKwgS5wPfA7JsSZ8z/6VBmvMWnqkD6iNkg+IH478lQljlU7Rb4GXc9Rm9v0o8YYOFVa2Ag4wemOKQy91tOMXgww9C/OIWi0KINFO7WMJFU6coYPnZPiduXXmr6wtxnKDXt49+QC/d4v7jtCq0H1sFPGpMNGdvAW7r/nDSRwoe0tQs9MT+l7bo52VKFjsZcMH2huDGPxT/Jt3lL79eWnItBR3BHn/jCxjzYesYtPTHAKV9Pc6tg3Ody2i305a6lTAX6Krn9r26j5rAbezOarJqlnlLeZkx3TkNmQZRKrtcuqwkZNuzLckE1KmSLk5OXDXjK36sGm7bu65kRoi1clwpiuaZPtZHLxK3yrjEUEIfPLr5E2n/fo1aNSP/nzKGi2I4j+/rh58gI8rMKiW7ZlRj9bdqudDSaViB4nFdsPw+4LUaIL9vT7IrqS01L1Sx2O3rhdH9Dd6uEc84Ig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(3023799007)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MiMA5TJdXybJzaG8wVucBcZdFwEhrROD0MFG62PSD0aTsHoIPyCbrBPm6YFIjcI2F64I0IWBDUCpFjLgIWopWEcrVLmhJUfs3baEmxgd5ra++8Pm4IZVJuxmMtLZKz5vam781GeoAzwDdzUDrEWyZzZZHbVawl59ONVPwH9tafDXrqe9SjbCwJ6dhp0ANbqLwmikdTVzdXI0EdMxnw/YYD/m0nA81DS953NLeAgUwwVu/aBav14ZpZtEwI+6rFOk1VIAmaomkcGDxE8/3/vr/KLU5alHMxuLZ9K91VPsr2GgS69xOiMWUlHOn6q4hDAZuYvBHB2aaNTo+Xu+VCkrmiY1s1B/MKjfV0mrY0WNPmHqH6cz50HEdMWUSwFsiwk1oJ2SxorgRfCON+GheOopuEAq6J4H7VT4X2u0GZ5dVViolCZmdt3zkOqXby48zueM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 16:40:55.3788 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c39925ca-4d36-4e3f-e455-08df01fe77e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5605
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

On 8/21/26 10:46, Lizhi Hou wrote:
>
> On 8/17/26 17:00, Taimuraz Kaitmazov wrote:
>> A chain whose command_count is zero passes the payload length check,
>> because struct_size(payload, data, 0) is just the header. The fill loop
>> then does not run, so offset stays zero and the request is submitted 
>> with
>> a zero-length buffer.
>>
>> On firmware without AIE2_NPU_COMMAND that ends at the opcode check, 
>> since
>> op is still ERT_INVALID_CMD and aie2_get_chain_msg_op() answers
>> MSG_OP_MAX_OPCODE. aie2_get_npu_chain_msg_op() answers
>> MSG_OP_CHAIN_EXEC_NPU whatever it is given, so there the submission
>> continues to drm_clflush_virt_range(cmd_buf, 0), which reads the byte
>> before the buffer and faults on the vmap guard page. EXEC_CMD is
>> reachable by any process that can open the render node.
>>
>> Reject the request instead.
>>
>> Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
>> ---
>> drm_clflush_virt_range() faulting on an empty range is a core 
>> problem, and a
>> patch for it is on the list separately. This rejects the request in 
>> the driver
>> regardless, since a chain carrying no commands is not something to 
>> submit.
>>
>>   drivers/accel/amdxdna/aie2_message.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/accel/amdxdna/aie2_message.c 
>> b/drivers/accel/amdxdna/aie2_message.c
>> index dfe0fbdf066d..b4c49259a1a2 100644
>> --- a/drivers/accel/amdxdna/aie2_message.c
>> +++ b/drivers/accel/amdxdna/aie2_message.c
>> @@ -994,7 +994,7 @@ int aie2_cmdlist_multi_execbuf(struct 
>> amdxdna_hwctx *hwctx,
>>       }
>>         ccnt = payload->command_count;
>> -    if (payload_len < struct_size(payload, data, ccnt)) {
>> +    if (!ccnt || payload_len < struct_size(payload, data, ccnt)) {
>
> Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>
> I will add a Fixes tag when I merge it.
>
> Thanks,
>
> Lizhi
>
>>           XDNA_DBG(xdna, "Invalid command count %d", ccnt);
>>           return -EINVAL;
>>       }
