Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC82F42105
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 18:06:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E819710E182;
	Wed, 15 Apr 2026 18:06:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZjKjch1Z";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010033.outbound.protection.outlook.com [52.101.85.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B00C10E182
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 18:06:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKGkJisveSdI4qgXS0hZIA+q3ddV3Vg4dWNiRxWEIuV8Jm/MYnEQB7I2PHOwIaBoeNr4MT68c0o/wxaav7Xb6R8It8uIaPsELfw0BtzqJC+3FX4ufRuTmz5WmQzr+6rzmTsffIVMD+cXj8SnJHaqV9BA0m4QiqBsk5O8oIgm6LTz/24h6wrTOJxWVW/d2pnUkx+BCybmUoe1gjGwm+79qvWXnWnfJzBS5B1lwYYpfRisfvmDf6cMDp1xbl9j4XG90wiA7vL6SmhIxTUMyBp94TIDzRHpacUGbh2X/azSvmMjY23DdiM46L7H4hR3wVPeSRItgZ1Re06gE7FVzlkg3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=993ep3w6EEPxb7ERrBLxnFB0EqOHB0B5AabTlqFWykM=;
 b=iTzf/hTgIoMqpuQ/91F37di0Inib6yYZdE76WWtTEyw2P/QJdH2cQh3RlUEjtXHd3QzkD/nmI+ds+dES8Ad/j9EMU77jTMtehEObMZ5//VFsOdHVF3foCTAKEvrTisYbvV8rEH9MsPAkp7hcK8cniMTlnRyJ491jdGF5XFkW/5osx4Lzr0hLILTpNTFGuX8v8pFvxtNgiarRenKSf9a6HykR9+ZQO+OmTAaVuzclV5r8+Kkbuw2eUzJhptW3Yl+YIO+dYefzjidlA2M5vcZOTgeX5fepduWa9awgpNqd7oMwrcgXS2P1vGzM8+JUBvYIe5NPZSNqFY1eO9ANp/57RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=993ep3w6EEPxb7ERrBLxnFB0EqOHB0B5AabTlqFWykM=;
 b=ZjKjch1ZKYfDfwtfpzCw0D2nVOF7ugR210Uc8D+Uxty7O2s0mmcBWW2T3aRpDo1O5DH9BPbRLMylL/aU+8NHA6UXpDuMUeinvFbY3ZndF55T7lUlPORfYhRoo92Dw3dFeC8Y3muXsGo3WpdDF4ZV+AcNayAtcKg2nHQ/h6Z0kjw=
Received: from CH0PR13CA0058.namprd13.prod.outlook.com (2603:10b6:610:b2::33)
 by LV3PR12MB9409.namprd12.prod.outlook.com (2603:10b6:408:21d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 18:06:15 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::c7) by CH0PR13CA0058.outlook.office365.com
 (2603:10b6:610:b2::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Wed,
 15 Apr 2026 18:06:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 18:06:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 15 Apr
 2026 13:06:15 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 15 Apr
 2026 13:06:14 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 15 Apr 2026 13:06:14 -0500
Message-ID: <8ff49387-fc36-3415-8f84-3c83d6cef05d@amd.com>
Date: Wed, 15 Apr 2026 11:06:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Fix fatal_error_info layout in firmware
 interface
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <maciej.falkowski@linux.intel.com>
CC: Max Zhen <max.zhen@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>
References: <20260414165625.788853-1-lizhi.hou@amd.com>
 <19e31c05-4ae4-448f-a9fa-7961230a2349@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <19e31c05-4ae4-448f-a9fa-7961230a2349@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|LV3PR12MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: 61551c1e-412f-4324-65c3-08de9b19af99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 1p8bH8UKnE/QZDCwf4FSvrMPdgJFUc4KXYucI96div6/Ed4H9Y/+JqkXHPe9tStCsGHjbxvNlBzrg0WLkbb3VV/gkyuE+Op8uBSscf1gfWMf0DxQubwvvllFPjq73XUIY/aj81MH01Y3Co0G3J8JB9X0n6CsBvdtc37c0FrJjQPVVGW7dq8Bxw2DLTg5ey8NjbGJci6dl7lcnhOFzJfDY2aD4rwRPI6ofLsrfJ6EQSMmzoME0fqOIfr/dZhUR/pBHT1Ie+CtLv5kKSRY682Qen79W2RysXS7zwTvCwKJp65zKH6nn5ys3+uzaXv0OImip/55TKHeMnmFMV19O94OET42Ch3OuDmPhfvU6KTGVt2VXEmmiabD9V3jPzwddqjahuJd8VYKTEBpmPI15t/qz6UmUhBX4sTbxZh8Xsd/LwuYuBHj0HfY2FFDBLkl4kCxzDR/TQc2N33WLyCnBSB8fhuP2AzFo3mQBW60X0xlJyKXHndAs8SbqbLYEf6NcK4zKLsI5ZKtolFUhuNd7shdSujf1PaLAXzNcRZrwu+dS3nl768M5/3vsE1PI6+7UGSy7FjLV9Jk9H4r6YlJ7ms6XWNQWq7cw/e3tRvcf70mUi+1jGjazPo8Se12N3tN51FGyK8FGN9H5mMIe35RI04ZqM6hCWnRS+BxcM4/Y5tSm3aiP1qtPI//aMea98wB9UO0jlD/z9G1K0bOGk3sObM7JYUvhxS7k6rar7usw+6yhqSnZUXL1HC0Ks16ZJts3eSJY1Ne5816woaP7dcPm7LNKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mXAZx8MEHqBQ77B2O1nWQMRN4G+G9YcGFEPk+YnpHip87ufloha6vfwsow3NZRvzjSsyRRAduSk+Vxs06twad3mjHsv1q9zzpabMR8JDYmSrDDw/nFl/1QXmZOoJF02KHOR3DQxTEsJKnJ0O3+A7gyOzkXxzRa0hmV51l3GsQSZlOtEBFmQBGnTJnJjq7e2y96uIWzGDzfJyuQTRc/0/wkqzsQVWnIqidH0g/4GdG/vWYpHQIgboKaRCmmv/+Mz169NyMKoMxYCLZ2HaPi+otIlD+KddV2XS0/GVkZ4O+o6v/FKDr6ZZnIJUdiaSJ33rRA7i2M2yUDhAW7zGt09CjfKZwAbkKdZbRa0DWzDGG+p/CRgJxrq4pydSZeZcErYN15XqNhSRJ9rUM9qtiVPYfITLhnhvKZxsqb61zyUWphQo2emrWG6iHAAFmXGiufjC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 18:06:15.5415 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61551c1e-412f-4324-65c3-08de9b19af99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9409
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

On 4/14/26 09:59, Mario Limonciello wrote:
>
>
> On 4/14/26 11:56, Lizhi Hou wrote:
>> From: Max Zhen <max.zhen@amd.com>
>>
>> Adjust struct fatal_error_info to match the expected driver/firmware
>> interface layout.
>>
>> The structure is used to retrieve debug information from firmware when
>> a command becomes stuck on the device. The reserved field currently
>> uses 128 u32 entries, which makes the structure larger than intended
>> and causes the layout to no longer match the firmware definition.
>>
>> Reduce the reserved array size from 128 to 127 entries so the
>> structure matches the expected interface format.
>>
>> Fixes: 25854131c04a ("accel/amdxdna: Support retrieving hardware 
>> context debug information")
>> Signed-off-by: Max Zhen <max.zhen@amd.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>
>> ---
>>   drivers/accel/amdxdna/aie2_msg_priv.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/accel/amdxdna/aie2_msg_priv.h 
>> b/drivers/accel/amdxdna/aie2_msg_priv.h
>> index fc2e99510980..b10552c627ee 100644
>> --- a/drivers/accel/amdxdna/aie2_msg_priv.h
>> +++ b/drivers/accel/amdxdna/aie2_msg_priv.h
>> @@ -461,7 +461,7 @@ struct fatal_error_info {
>>       __u32 exception_pc;       /* Program Counter at the time of the 
>> exception */
>>       __u32 app_module;         /* Error module name */
>>       __u32 task_index;         /* Index of the task in which the 
>> error occurred */
>> -    __u32 reserved[128];
>> +    __u32 reserved[127];
>>   };
>>     struct app_health_report {
>
