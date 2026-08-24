Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3BA1C5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 16:39:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE0F310E579;
	Mon, 24 Aug 2026 16:39:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bcPySvxd";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011028.outbound.protection.outlook.com [52.101.57.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21A5E10E158
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 16:39:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L78GzXJ95SmA1m0SbBbhMp+YVu8/qlB71EQQ2oIwe7syFGZPFRYi2jCAZZicpanlnk07GjP+2vHUZ5ejnJR/5s+JDIs08EvCJAum+Wl3eXyxrpQlCi3mQqck4XX4g80dN9SxYJIf/9SpP/QPx/4f5PxStcCSHVNdNy9wouEp65plvDEo/+8aVutzSl7mI90nsH1KbzBEcN9K7wJ3wtYwXOf4Ap3t5bgh6ouhXpobmYlawYpqksyYmGxE0hG6WbR5K1Wa0abzAboAOe2BLdTGOmvc/JBLRH1eGGyVmLpqWHKqBcx4niGMHzbiBNG4u51X3RwpdxJ52THdN6moFH5nRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tv3pw5kgnhE2EBLJ+/BIRunwzm+G4E75LXgi471J6Y=;
 b=fXRlNUQzkVxlYleLWTPUcsRVioXQZEo0KzjzpdAMHgWac2fe+9NboT1HYxnIdtJDXmWOnx2gBQuZciWw9TJBp6M6X9Bp/qCk9WuqC0MZ2EhXTp9pHuEBPH3dqhpIQOwwMb820ivlj5mzWrFvn/P32GeNWfaO1pKOi3fTdeA6N1DyCqv7DiN/MnB+1oUqcuBshqoPAqQ2DWJDy04Sck0zwWY+ZA3NztxDMro4q80hC3cwCXF8OAnHaUr/6cyFts70N0drHcgloIHRkL8lHIDgdsP6+ZG9HfJdTkgjptYGBPR7m3e71CPLXgPwpK6ibTVi/oYFdeoWq/wn4s36x/KekA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tv3pw5kgnhE2EBLJ+/BIRunwzm+G4E75LXgi471J6Y=;
 b=bcPySvxd2CED3SY8yrkM5pNuxkpJeLqI5rSjcSaDDchw6gX1Lb2fVOpZ8f65PvSW9PMSVIWvAJMRO9u9misntRpISJRgUE/cLSYUi9rk5EZuLZJyiqgtTupAmRIJ8joDll99AexxCU410tQwYZMwoePLD7swZ1NPr7+uT2aVm1E=
Received: from CH5PR04CA0022.namprd04.prod.outlook.com (2603:10b6:610:1f4::19)
 by PH8PR12MB7135.namprd12.prod.outlook.com (2603:10b6:510:22c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 16:39:52 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::3c) by CH5PR04CA0022.outlook.office365.com
 (2603:10b6:610:1f4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 16:39:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 16:39:50 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 11:39:48 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 11:39:48 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 11:39:47 -0500
Message-ID: <545b0402-18cd-7a2e-3be2-8fd2335fae98@amd.com>
Date: Mon, 24 Aug 2026 09:39:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Remove __counted_by from struct
 amdxdna_cmd_chain
Content-Language: en-US
To: Max Zhen <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20260821033543.1839719-1-lizhi.hou@amd.com>
 <7ce13e6d-0da6-4d6c-a05b-3ad5e67499f4@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <7ce13e6d-0da6-4d6c-a05b-3ad5e67499f4@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|PH8PR12MB7135:EE_
X-MS-Office365-Filtering-Correlation-Id: 04fc5076-1b65-4a74-a95e-08df01fe5180
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|6133799003|22082099003|18002099003|11063799006|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 8YcG5wuOG4qJXbXMYwe+ZsKwltXp/rX9A2tBXLufKDnjKTHAuPKQtbT8tLeIdE5Lk9qxy9UOfvRTNS/jI9B7q7tdZgceyboI/dxOwPTKAh2t7LRbjLtzjZMkR2xST1BPmWTWMCIBEyXKw/CxXh/xasgrXfDJF2YNlPARs59xLRLKVAT/cdVNmo9sBLiC2WhBP8e+ZSSZ8kpRcniYcUI83fCHiU+T/VTWr/BXIuoHgdsDMOzzuXL5eW+JbcXPsWqCcg6ZJkn834knpj5jD+S5cpmXA39CTFLw1WSAO8npaQmf/vhzgQzEopXjPWIX1iZ0ZImiJwjeX1Y9Uk9YB+/R/Z60pxTfCCt/YSBf+q3yZOGRkLJ89n+OntwiBanNryJvz8ozkgMhv0UJzVGIf570C5a2z1z/lXIDnPdp1HIUK9Yaand6EcrUgbqHsKeBTKVG5MEa5+L2jyvnpVUBcB5MxKCS1PQiouFWLRsT9SqsmpXot91aFszLXStMwV6M9SS8CMk0aRxHCuR6WXGOGdmMd6Q1SGN1prT6HP+8SEQONFq6b6zGr8AT7KaTUGlL1ggqsrP6hgnyidCGOiB//uWS4HqjXcvHTMWlJa4rrFa8oKtGA5fLztp2CINVPbmjmjrE+JiRbvhaSE2Q8yFvy0jlHymF8JKAo4GBGxHpvU4zXeXTtnNRTiB6xFnjrqoIHJkP7iiOHxBJmz4kr3LADDx09g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xn2jrtlm/DdVaRyKiPCfszfcDWes2W0USIPntWQeQvIIgk/iON9yqcqgagu6oXV1bB0oIJ7DA/dig8HDxPR/Q80ngC27ZE5bn4bL9uyByK20tPOqPNFe9erdVJCCrkusdnwnFuTQFcKXhjVH7fvs4B9magM9WtayeUXFMPuJsy/9GctcytLd15W37ZdLjX8qznbLyJxpyTSxQGByNGHGOTo1ykahqdmDcgkqyGXVDiG9FiI5qgDsgG5n+hwXcHxaqOlF3sGSTtW6rVVBWXT8/dB1ZzpYoTefcfhHlRmnyUlmMHMIG4UmrCGBUyseOn5W7j4GjYpETb6EyXmSX72DQGbzVgKBjwZx/1S3aNkRzhdLzxeCBESAJscdMrxWlKR0Sv5sEmWNypdM3DneQHE9Ay5sbKI4GHI6ZVNsV73EFudwHVEoOMRSxwVIJK8kYmU9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 16:39:50.9821 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04fc5076-1b65-4a74-a95e-08df01fe5180
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7135
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

Applied to drm-misc-fixes.

On 8/21/26 10:50, Max Zhen wrote:
>
>
> On 8/20/2026 Thu 20:35, Lizhi Hou wrote:
>> struct amdxdna_cmd_chain contains a flexible array annotated with
>> __counted_by(command_count). Since the structure is stored in shared
>> AMDXDNA_BO_SHARE memory, userspace can modify command_count 
>> concurrently.
>> If command_count is changed to zero, the bounds check generated from
>> __counted_by may fail and trigger a kernel panic.
>>
>> Remove __counted_by to avoid relying on the userspace-controlled
>> command_count for the flexible array bounds check.
>>
>> Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviewed-by: Max Zhen <max.zhen@amd.com>
>> ---
>>   drivers/accel/amdxdna/amdxdna_ctx.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h 
>> b/drivers/accel/amdxdna/amdxdna_ctx.h
>> index e6155f4b5db0..010538cb05a3 100644
>> --- a/drivers/accel/amdxdna/amdxdna_ctx.h
>> +++ b/drivers/accel/amdxdna/amdxdna_ctx.h
>> @@ -56,7 +56,7 @@ struct amdxdna_cmd_chain {
>>       u32 submit_index;
>>       u32 error_index;
>>       u32 reserved[3];
>> -    u64 data[] __counted_by(command_count);
>> +    u64 data[];
>>   };
>>     /*
>
