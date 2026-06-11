Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E4ACD98C7
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 16:53:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAF1710F047;
	Thu, 11 Jun 2026 16:53:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ieDSEpsX";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010005.outbound.protection.outlook.com [52.101.85.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6220C10F02D
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 16:53:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Es9N0E5aFYz7HbmsAO8roxGXSHi9p1hbmn7bA1JlA/e6949v/egGQgzQkvVkoV+enj11bJjdrFvQxY9MNDBXcIDIVvNG6hUbFnAPw+6Q7JxRUgjc2KgbfI/gk9HjSPDJuHBUkzwczn7fKJvE6jt8gc0tRKk8JNBZJ6UyfpHc/yvFWrerGRlal/yVA04tNTR4Y7g3SQnLz99ptBo5+RPTL6bTM/Q/oxnhfbs+Hw+3TKt7qnETQdIbYWjZAj6MiwHbFiakwdcXkRvDhuEevDaep8BlLPCiIm61SsElJi0+MYkxofLH862SRfctAAo0lHuz8GXxalk/4fNZgTlXihs/8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPXR8tGRkCsS1uL1R00I6W0wOpK8CJYlIZQO5amw3Tg=;
 b=Y6qAARjl8kNXoDBYlP8QRhXrZIgQnyJMN55K1k+LzlhtWqWoE1pMOBw9bpjBN4PAqwovRZWgkAlgcarUZWgNFj2Xcc3vKpyDARQa+M+gBFTifbHxayb4H7GPzWn8bZ7lV0XSzInkLeCs8RofMy+G/dAqpXtYvThh9X9RHt5BWVap9ZVpwnnCQuukg6dLBbNL/vfP6wBQHGr68h5nItYQjelayIHCQ3wdjTMasevq1EUae7V3Wzu/mS4+zu8oKWAX96nMiZUotfFzwUgOXd7KPzSUHnufZh94/LN5c3i8QudWqUy29pJlHhrcNLAiJK2Op75lfXfAjnQAs3fLc/p9MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPXR8tGRkCsS1uL1R00I6W0wOpK8CJYlIZQO5amw3Tg=;
 b=ieDSEpsXAlA4oh3nYLoR7c6EANZzm1NHskOZz5NPMdxQSkTsrYlfphTzt0kvfJqWhc8vX3cY1B4O4aniKLVpC9AftLfjv/D8bwk6RIoXCPGEWPTwulfPbCdSk8SqLxW+sPI5imZPtA9tyEF8OGlb6V18SXH85AxSNpxQru/rThA=
Received: from PH8PR21CA0001.namprd21.prod.outlook.com (2603:10b6:510:2ce::25)
 by IA0PR12MB8207.namprd12.prod.outlook.com (2603:10b6:208:401::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Thu, 11 Jun
 2026 16:53:38 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:510:2ce:cafe::3d) by PH8PR21CA0001.outlook.office365.com
 (2603:10b6:510:2ce::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.5 via Frontend Transport; Thu, 11
 Jun 2026 16:53:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 16:53:37 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 11:53:36 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 11:53:36 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 11 Jun 2026 11:53:36 -0500
Message-ID: <a02306aa-0470-d4e9-db7f-0f5c08b728b8@amd.com>
Date: Thu, 11 Jun 2026 09:53:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Fix mm_struct reference leak in
 aie2_populate_range()
Content-Language: en-US
To: Mario Limonciello <superm1@kernel.org>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <max.zhen@amd.com>, <sonal.santan@amd.com>
References: <20260610151127.2994185-1-lizhi.hou@amd.com>
 <621cc992-5de2-455b-a488-f89ed2a9a91a@kernel.org>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <621cc992-5de2-455b-a488-f89ed2a9a91a@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|IA0PR12MB8207:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b968d4d-d2d2-4912-34e7-08dec7d9fb6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Twuz/q6JTSlzpk3VMtSIDwdICsOATjB2hJHty8bVC9ZX2jKYjzelLXbXOQEqtjxp3ARC1IGmJ2smDzGAkcIO45rgRtenJaLr4Rl4EbRT8j3EtQ+G/JyeYnGZ2w7igmPe0VEk02x+b+fdycN8oTIGjlt3GLCErq9L/6LNo0JFOAcdbCUaU8BGRjQ8LVLZhwCbtRcTzmx/97GDVGtUTEUnLqz2DGQmqmYc0yFbvSf6cyI5kaChTowhHWKvzkPCBZXh+QvQ3yVxxIpPh2ivi6ZMNLBb8/a9xrhkjabO61wYviqUH20GnWmEWtapsqQqLoBRmWea4ZqKvFFVumo5ELfOT8MtowKCjcKNtXiP8Mt2a4lChdr2PZGBoQXGXpE0nZSJj/ANMF/T6ypkqqvh3L21X3MCKvJ9JtSLmpIMwiDXF0pd6zYHayNlv/OiHe/KE1+j1Scj1F+OJQ8JI3ctJkT/Xg9+eceBOH0yWsO5ZIwKMwT17Vw8al+Z6vQrhxIwe2YTQjFbw+BqdVfviA/UlqsMiNUqmhAaFaYtf0iFevIE8a93UsX7QsUPTxwfFrUB1VrhBw3jIMpXqKJ7sxgN0BwyQeEy8VdHIbbhw96JLwG88/fW0er3DxDhZxExMM3MJmDKlYSfLoEVuO7N/K4n5lUDwgn21jnkv4Jrijr2TIopgQbW1sb3PKYDK9AwwwPU8b6LChdPtanS7N+tpVCCyuijrAai4OsyABN04DD0C0K/rzg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wMzBiHQ4avsOeDtDH1Lm4H3y0xtMUbSe1M9Qer/wxm81y2+FopLVZU9l5Ujd0kyAgya64lAnPl/OYuzJrcKLu4s3wrWIICV18ofI/3HZu1lDI8paTzXm3UpQuvEYpa0INwbpOJCZswUpEdelPs0mc/P2bWiWEWMf6bR1d679I5eL8KTPfh05YiZ54gsQKBhMnGbDLIqBh2T2A0j8R4AtHXDUCq1T45d+7VAWsrCNdqNXeO/9wywWJx5uDjuYZtlkXHrOXC3zWQuVCScMrp/x3jrNcSmAA42NCrhrAU6HOcnXYQMb23CeTZnyRs56G1UFj89AR4Qqlz8m6T/UTGFIOiwG2HIVmWqO31uOJMAdxj3WaCWW88prxYBK+Rtu1wryhocMPv34mUeN6sYtWZnL05zRlcaWvosIcMfgvhUcdP54X5cQdEEnGerSSPNrlnmD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 16:53:37.2314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b968d4d-d2d2-4912-34e7-08dec7d9fb6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8207
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

On 6/10/26 08:18, Mario Limonciello wrote:
>
>
> On 6/10/26 10:11, Lizhi Hou wrote:
>> aie2_populate_range() jumps back to the again label without calling
>> mmput(mm), leaking a reference to the mm_struct.
>>
>> Add the missing mmput() before jumping to again.
>>
>> Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> ---
>>   drivers/accel/amdxdna/aie2_ctx.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/accel/amdxdna/aie2_ctx.c 
>> b/drivers/accel/amdxdna/aie2_ctx.c
>> index 3e21e2dabe82..e0f30dbe0238 100644
>> --- a/drivers/accel/amdxdna/aie2_ctx.c
>> +++ b/drivers/accel/amdxdna/aie2_ctx.c
>> @@ -1041,6 +1041,7 @@ static int aie2_populate_range(struct 
>> amdxdna_gem_obj *abo)
>>             if (ret == -EBUSY) {
>>               amdxdna_umap_put(mapp);
>> +            mmput(mm);
>>               goto again;
>>           }
>>   @@ -1051,11 +1052,13 @@ static int aie2_populate_range(struct 
>> amdxdna_gem_obj *abo)
>>       if (mmu_interval_read_retry(&mapp->notifier, 
>> mapp->range.notifier_seq)) {
>>           up_write(&xdna->notifier_lock);
>>           amdxdna_umap_put(mapp);
>> +        mmput(mm);
>>           goto again;
>>       }
>>       mapp->invalid = false;
>>       up_write(&xdna->notifier_lock);
>>       amdxdna_umap_put(mapp);
>> +    mmput(mm);
>>       goto again;
>>     put_mm:
>
