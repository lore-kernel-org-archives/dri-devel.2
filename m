Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A836DC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 17:13:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1068910EE65;
	Tue,  7 Jul 2026 17:13:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AMYHc61s";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013014.outbound.protection.outlook.com
 [40.93.196.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1679510EE65
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 17:13:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJPz1hHJ13NLT9POXe8dEYSt65vAQCLqZnwjZgw3OqvJJuEAl9NJt4jDoBIOu2AjscLpA7Ipjv7tmKgvbBfifuF5KZV0zIjDbMLRn8W8+u0SsDxUZt2ufkeZpi66xfi9IDs8tcEraCteD3MoWB0cNTHmxoZWtc+N5vgCFpCRwmtBB3x3oZ8pfpJg7ww4ExedXGLFEx4PBVFEeA3up1nFkbRhxbTvaTgNVcwjs1kCKqxGwzYVx/lCDun8A2a2WqvHZ4UTuoHmeIiTDK+oJeczOs+gpHz+sxXMQM2k5RyMCg809V3v4s13cVd3Rm1m8W1RB57wYtFZU4yPjeSPXnuHcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SAv6XS05mstY1Ch+RTENt78Y08JYATQ6NHvrqz9aLY=;
 b=lOMBa2EY7d/ixoyh8zaZDp2FL49NLwXZCYPbGTdtbiYYWzYJsLMcGSEa+sxfonbBDvjYHy2GL341r09ZqbIbnDzOf9iwtkXL1eOqvRxvJutXePQtqOPyMAKhzlMDy/liOycIOAfHTn0XHb8r16WsZERCRUXTENCaElCmUStsEF/JAuLNtQCYXJU2b9e7cveGVJ+1ZQAdQH9FOkY+2qZXCskL6WJRbufMlCvEdTs4n5lDTd3tmnWUmqvnRtb55jYC+N4SUIucCbcHX6p6c3EG92RI6tXoP4gvTCHfGl4GX/s0OBhnM6IAI48MG0qAqV5yij4ZS5N/fuaGWh2bI2g5Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SAv6XS05mstY1Ch+RTENt78Y08JYATQ6NHvrqz9aLY=;
 b=AMYHc61stgZU0x9bkMK1/wf/Nppdcel3jkureTMBL3kt9o3yjndunrngnY1rXDAg1algfMXFlSnDWkkUTwY0Jr2jb/H+ARrMbrX8fmmzRJop7eUJtLZkyuge2Uu8sLaVpwebG/bhj2AVFY6zM8cVI8VSDIyqBkGNkXfi7PgZSvk=
Received: from SJ0PR13CA0202.namprd13.prod.outlook.com (2603:10b6:a03:2c3::27)
 by DS2PR12MB9663.namprd12.prod.outlook.com (2603:10b6:8:27a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 7 Jul
 2026 17:13:50 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::89) by SJ0PR13CA0202.outlook.office365.com
 (2603:10b6:a03:2c3::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 17:13:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 17:13:50 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 12:13:47 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 12:13:46 -0500
Message-ID: <aa73100a-c507-8297-c6f7-5d8750c28f80@amd.com>
Date: Tue, 7 Jul 2026 10:13:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Fix potential amdxdna_umap lifetime race
Content-Language: en-US
To: Max Zhen <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20260706221228.434099-1-lizhi.hou@amd.com>
 <1b123fd9-12e5-4ca0-9328-97144af00f66@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <1b123fd9-12e5-4ca0-9328-97144af00f66@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|DS2PR12MB9663:EE_
X-MS-Office365-Filtering-Correlation-Id: db6755fb-44fb-4c75-3920-08dedc4b1d4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ankrHFGwYvr9fwZMG+zE6thIVDvJ6bPUi3FYx6l7ku1nVVcqQhrj1y/tkkB02Iau1O6lyQivnu7UjT2mI7z5klp5YafLUzKl/myPzghMVlnDds3shlx5hgsaRzSCnv4KjFRoUiK/wvIX+ef+ubR6jTpYsaGR3S+61O6FagBaSdZrPpHe5jS2O0XSBLyalXkdy9qCpjNlRi0PnEy5q532tweEnPGprH72oTa3LewdPlPMtBSKSR7XAwFkiR6kJRQ1GUtP7CQWAYwQyXhtuKlgvS4+DB2qBvwmuU27oSLlJDQ2ARYsbXPgM0cqlezvJu2GWeZGVT2yiz+v0/ESpK3dd/OkqGqYp0bwuNSpKibDmqRylk+SyacjQjqh+5D2dIgHkYL992gqgCla2ew/w6edlFZAPJFMgUmNNXVLxDZL9CcippXRxTmbeBwMvhDe63xSKEAsjoI69UQy7a27UUHwmW8yqAGass7tFKtqN1ZmMzXHcigWzUyeHeWbZGUhCr18iK/3bZn+JejyFV+xW2EJJalmYimGrH7K8p3oNJWN0dgp6/A/CwvmgJSsyJ3WGjOYcf73xrRL+d5sAFlmye0QcavdTgPMgWLT30V7b9OUc+j2pnIUKLJcPdNLzLUVgCuoqSsK042bbLX4YpVhaUbnxuZhFvkiJAk++zvjYQsuRUXPzKgqAlfkf6bD7FJdHHsjahk+7joHxS1r5zsYq3cMpg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9DE2gI22hrRUHfQY7d/2QcHaxEE75EYvncPNIQiygUtACKnzTU4pDOZ19/xBqWn2ALCLJ2igMrh6NrkTQH7vjsHV9Oy8VpXyWzcRZKvoAzEAb4KSNlim4Hhir3ls2lI0QLbl24b1F1fhiekgy1d6aM43TEca6FiZ/l/IsAag0JoVrbH+B3x+fvZm6sZe90tAg835MS5uCohxMd2TkzzsivHmO+ZrJhH/LG36X2oQo6CkWGXv+2OycjYF3B1D1D10ajB2PE2yhqcR89fZDXUevTgl4LrX6YqmOipCo1rA4vt0Y379e7VaHx4jKSidv6D7oOU6nUfuAlKu4LPgK7rhuiqDJ+qzaj1a0HtCgj9mhPcXeK+mHCjBKQojT6OZzJk3SuZ0iTfQAepIqq6mYK+xvSfviWK2X8vXgG3FGAnAXNQaEUfI0oupkQZXjxRh/Bh4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 17:13:50.4233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db6755fb-44fb-4c75-3920-08dedc4b1d4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9663
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

On 7/7/26 08:35, Max Zhen wrote:
>
>
> On 7/6/2026 Mon 15:12, Lizhi Hou wrote:
>> amdxdna_umap_release() calls the blocking mmu_interval_notifier_remove()
>> before removing the object from abo->mem.umap_list. If
>> aie2_populate_range() runs concurrently, it may obtain a reference to an
>> amdxdna_umap that is being released, leading to a potential 
>> use-after-free.
>>
>> Use refcount_inc_not_zero() in aie2_populate_range() when acquiring a
>> reference. If the reference count has already dropped to zero, release
>> is in progress and the entry is skipped.
>>
>> Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviewed-by: Max Zhen <max.zhen@amd.com>
>
> The patch description mentioned refcount_inc_not_zero(), but the real 
> fix calls kref_get_unless_zero() which is a wrapper of 
> refcount_inc_not_zero(). It might be better to fix the description to 
> match the fix in the code.
>
> Thanks,
> Max
>> ---
>>   drivers/accel/amdxdna/aie2_ctx.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/aie2_ctx.c 
>> b/drivers/accel/amdxdna/aie2_ctx.c
>> index 408ff7e2a272..7bf635634e64 100644
>> --- a/drivers/accel/amdxdna/aie2_ctx.c
>> +++ b/drivers/accel/amdxdna/aie2_ctx.c
>> @@ -1039,7 +1039,7 @@ static int aie2_populate_range(struct 
>> amdxdna_gem_obj *abo)
>>       found = false;
>>       down_write(&xdna->notifier_lock);
>>       list_for_each_entry(mapp, &abo->mem.umap_list, node) {
>> -        if (mapp->invalid) {
>> +        if (mapp->invalid && kref_get_unless_zero(&mapp->refcnt)) {
>>               found = true;
>>               break;
>>           }
>> @@ -1050,7 +1050,7 @@ static int aie2_populate_range(struct 
>> amdxdna_gem_obj *abo)
>>           up_write(&xdna->notifier_lock);
>>           return 0;
>>       }
>> -    kref_get(&mapp->refcnt);
>> +
>>       up_write(&xdna->notifier_lock);
>>         mm = mapp->notifier.mm;
>
