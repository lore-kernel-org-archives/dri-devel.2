Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C11ACA5FA7
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 18:41:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7916B10F030;
	Tue, 29 Sep 2026 18:41:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x8Jwacbi";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010054.outbound.protection.outlook.com [52.101.46.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F0BC10E1CA
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 18:41:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K0Bqd3IarvfRoCvaIe2vVWcg0npDT6vZZQ7/x3eMH9dp/2usAlBPiiPoMsG4VlesMpqP8hs1kKm/nKFtZWugCWUW+yuK/XtRJIKLPhV5mHFdydd30gMejhxB22/sroWJ/LsPQDmVmiet4nUzkdeEB7OgMLqo0jR8oapCRJZi8YNTZQXtzMAa9s9rgt0M1pVqYQj5kt8rhL2PVo8vaMdSk8MPxgQ59ze7Rpn0UAVFpYonXtfzBnhNvrUaCp/oiOMz9LRxg02aWAT1Bjd2//1YoOWDEQRNcUjkIKuuRV+8m77GNVCiWpvW86Dtl6fl971IkWA5Aww060cYaV4M7LNINw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rF/7IAqdtXs5RvA0WeK45UzVzHqVHfJk1FJPjxczHY=;
 b=nE/Zh2A2NS+oAsyvLGpxwDDHdlAlMNsNFGVEGHdHJckpVQnqU8JsJp6c5Q8JFRoauH6XH9Ug/x8VT3V2ST5zgveI1++Qt029B+LlAf1640IC67AAa944eJVjJM/+SUBDdQQP7cG8xK1VmgYOBKiy9n9TOTXCWKBO66Stgfk+EDLUTC29tW0AA1RbkWwSdLbi25Qau0rxVggSVa1gOTk4XvwlNh9ogNyDXtuinJaRLp47ek2FHCVZGvQLagLO4eiFJxNCnVDX9z3nqv5PiGz07ls296xrD8J2o5No4tw9HLEagmaRMyZYH75c8fzpuAKGag5tWso12VCKA7IB83cfJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rF/7IAqdtXs5RvA0WeK45UzVzHqVHfJk1FJPjxczHY=;
 b=x8JwacbimBc10tvbgJ/XDodd5Zeo71p7XkuwCTtYlLFqEDDXD/Xr7UQd1vVkHYZMOcmPuilecjpRbpXlYyeTu+sLe+kXw5/S4zP1BFHwt6KYJCiPkNLIleKRemgBO+eVYlNfBY0ZpLCKCykj1ARKGWE0FYHQgOge53At3Q89m+w=
Received: from BN0PR03CA0022.namprd03.prod.outlook.com (2603:10b6:408:e6::27)
 by CH3PR12MB363094.namprd12.prod.outlook.com (2603:10b6:610:360::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 18:41:39 +0000
Received: from BN2PEPF0000A892.namprd04.prod.outlook.com
 (2603:10b6:408:e6:cafe::76) by BN0PR03CA0022.outlook.office365.com
 (2603:10b6:408:e6::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Tue,
 29 Sep 2026 18:41:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A892.mail.protection.outlook.com (10.167.248.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 18:41:39 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 13:41:38 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 13:41:38 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 29 Sep 2026 13:41:37 -0500
Message-ID: <9238f183-2850-0e39-f029-ccd8284299e1@amd.com>
Date: Tue, 29 Sep 2026 11:41:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2] accel/amdxdna: Add support for AIE2 revision 9
Content-Language: en-US
To: Mario Limonciello <superm1@kernel.org>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20260929181459.928468-1-lizhi.hou@amd.com>
 <aee76270-590d-4d2b-93ca-23e56bc3f482@kernel.org>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <aee76270-590d-4d2b-93ca-23e56bc3f482@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A892:EE_|CH3PR12MB363094:EE_
X-MS-Office365-Filtering-Correlation-Id: 9765c33a-1e58-4578-fff2-08df1e594c7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: k+yimO/qv3m0PaBGJYU34pdiL0PLdScbPBzKwAhadRRfTt/O5K6yNQ3eEHWpRAvtxFo2atcpZCz6zBCuZyuokjT9Chdp2cUzujZd9zE4JVN6y8zS8fBeHQW4TXZ2tmixkx60h+G2I7Npo3QGjGJKIw7p8C/PDBiH76ponX1ZXVHOCOWrvcH6CTS1kzhbtk7oe00p8Fhja83MFJrRjArECBzxSrPZacCZa0OVWbDSes1vHsmcpvOtuVnBnctCiahudwGu12fRNks4dHt0IFTORP5hSFnu3rr7sazxk9YdDrRMHtbsE4rTCSAkrnakW0IAlX38KzGXxbvwSmctsmovYRx8XO67IWz9/kBn6jL3znwu6qDqfyvc7wWNWZSxmTY0hKPWtMfC3gPVeHrEILggY42DPjiv2o9E4pijQn1Fm2Z68nZznhLLQkdZjwRcYRhmT4NHM0KC3S1uMdc9GtCF+o5y+2jY5eWUuBMvx5A+Xdqu+f2B0fuddKzK7YhGx8f3FgNQv6L/WE2c6m/lr5g4FtERPrNXyiInPaa9Y+Lszp05ZoTYMkVUYK87vKBT0HNEUHfy24PGZIaB4GwvozBrdsGbQVk055NEtfuvnI0v6BCZ55oxVzCzp5PBv44CYjRFoHQ09iRF0cdZKFApyRXIL3837mfQTPjqxKQFX8zCg8Nif71Xf0EGk7W6F6KPMcSiL6lYV842ofaVZ6URKsJ1Zg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WbYpWxy9LfrKBX+90+ieUneBbHEMtfUEWbYQg6iObzU4+hU1S07aMDbMSSAsybFNcVBP2K7ffvEEMK9QaDRl+WENEi11b7Pti/TBkfj12KyNDJH3OZKvkvLhf6a+yZ50/HlqwIxGvQpiWBRZ2IyixygBax7MMpn+qSmWRgTmOqjpahyPUyeuNdDAydfJx7OPUwmDVTRTVDseVnT+AtiMWMIlC/av+pPmVdl8YPVEhhhdbpjcXY7xoyyJw4aoMmHF4lklu4IZC68HsoBR1KAlCkuiL3TQ15lYyca31ljyRTejK0OBv2gKZLIBN7KNRzGCjJXpnIcJhkzZDbjgakr4e2/jW/rPTqcAZZf0audmiIJC3t2UsAZzgQ1JcFyFSdc8sQdAo+Z/FH8T+ZF8qo3d1MMOF3ElH9Vq4gMSLjdv0xwDoEGHQ3AEm+5TcyF2Ks7r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 18:41:39.3838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9765c33a-1e58-4578-fff2-08df1e594c7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A892.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB363094
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

On 9/29/26 11:24, Mario Limonciello wrote:
>
>
> On 9/29/26 13:14, Lizhi Hou wrote:
>> aie2_get_dev_revision() fails to recognize AIE2 revision 9 hardware.
>> Add AIE2_DEV_REVISION_GRGH to the list of supported AIE2 revisions.
>>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>> ---
>> V2:
>>    Fix sashiko comment: add the revision string.
>>
>>   drivers/accel/amdxdna/aie2_msg_priv.h | 1 +
>>   drivers/accel/amdxdna/npu4_regs.c     | 1 +
>>   2 files changed, 2 insertions(+)
>>
>> diff --git a/drivers/accel/amdxdna/aie2_msg_priv.h 
>> b/drivers/accel/amdxdna/aie2_msg_priv.h
>> index fd65a4236d49..8ed2b5701dcc 100644
>> --- a/drivers/accel/amdxdna/aie2_msg_priv.h
>> +++ b/drivers/accel/amdxdna/aie2_msg_priv.h
>> @@ -530,6 +530,7 @@ enum aie2_dev_revision {
>>       AIE2_DEV_REVISION_GPT1,
>>       AIE2_DEV_REVISION_GPT2,
>>       AIE2_DEV_REVISION_GPT3,
>> +    AIE2_DEV_REVISION_GRGH,
>>       AIE2_DEV_REVISION_UNKN,
>>   };
>>   diff --git a/drivers/accel/amdxdna/npu4_regs.c 
>> b/drivers/accel/amdxdna/npu4_regs.c
>> index 15a161384625..c9648c8032ec 100644
>> --- a/drivers/accel/amdxdna/npu4_regs.c
>> +++ b/drivers/accel/amdxdna/npu4_regs.c
>> @@ -153,6 +153,7 @@ const struct amdxdna_rev_vbnv npu4_rev_vbnv_tbl[] 
>> = {
>>       { AIE2_DEV_REVISION_GPT1, "NPU Gorgon Point 1" },
>>       { AIE2_DEV_REVISION_GPT2, "NPU Gorgon Point 2" },
>>       { AIE2_DEV_REVISION_GPT3, "NPU Gorgon Point 3" },
>> +    { AIE2_DEV_REVISION_GRGH, "NPU Gorgon Halo" },
>>       { 0 }
>>   };
>
