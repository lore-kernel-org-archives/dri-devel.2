Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B62C5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 16:40:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3728510E57D;
	Mon, 24 Aug 2026 16:40:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wn8k7d1U";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011044.outbound.protection.outlook.com
 [40.93.194.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CA8410E57D
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 16:40:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kFPbG6qap8JifCM2TILVeHJ+VhSMyxxHDVmjLolE5Dm4cZTZXqqXebyhEEMpTHcC3tAkhg6UMrMBUZGzZ7fihfodQ+Gwh1HoLt6kcBpZV6cjxO69lMN+I9S++t6sDp9oaZpEx2UZ2KWrCUPc/IQXh0zO2gLtkz3H0KYHrbGvWixdP7xKValm0YrWvWxG7vNQO0yru6WLVp07KkyEcFKyE4mGMtcOrUF0FvAsRUYYebhigORhdbPd7RnLUWbAIPz41KQZ5zGs53xDN6ZxhlpnF1HO5QUG/KUbPwfVy8J4vsDsmHRBufAFjTJMgYWKQkzJiCsNNk6Qm7Y3HSQ4DmpyRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/m9WpubZlDqMxdvqOGpYyWaOjJv5ZTiwTNZPaaS3D4k=;
 b=DYTvMwZblatfOyNV7p0BdmneT1+b+BfSSAwrdbvcJX5QKgunMYnKmX9igDbqAiEt5zZeER/ojQz46DHEPbkBwQr+i/+25TfxTWPTrG/BCULik+7MeY79UJbfn2auJaMk4eKEax8XdnZgucDx2nxx7gzeir1PvW4q2D7Ioj1yc2KOaixad42g7cj+DqqD5XpT+CTZG+VLtjGpZXtny1c2ia6rGvex+KR8Opi366tMWdtZE93rTMDf2AEaZnruV5lDx6iNgjv6naR2CZRG0Cf4yJfRYbmaH/xMeX0ZOp2awIm44YGhDU3Lbiln5xskZJQjc0RS5f7dc/AuUkxom2CTMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kaitmazov.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/m9WpubZlDqMxdvqOGpYyWaOjJv5ZTiwTNZPaaS3D4k=;
 b=Wn8k7d1UIU0W6Z7ldxjSkTJuD/tGAchPffy/aXEk4dOqn9tp5AZnfK5I79F7OJ6uz6UEb5FzwyUt5KFVctONgwJ7KudGdjdiTASDkj9TD5EaVuj9lsF+LgZp8+y9stPqJf0skLbTLK59sPNAukAL00GKj2gxuZlE7DvcnkNwtm4=
Received: from CH0PR04CA0092.namprd04.prod.outlook.com (2603:10b6:610:75::7)
 by PH7PR12MB6860.namprd12.prod.outlook.com (2603:10b6:510:1b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Mon, 24 Aug
 2026 16:40:21 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::19) by CH0PR04CA0092.outlook.office365.com
 (2603:10b6:610:75::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 16:40:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 16:40:21 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 11:40:20 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 11:40:20 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 11:40:20 -0500
Message-ID: <17811ffc-f33b-b3ac-865b-18138239e0dd@amd.com>
Date: Mon, 24 Aug 2026 09:40:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] accel/amdxdna: put the chained BO when its mapping fails
Content-Language: en-US
From: Lizhi Hou <lizhi.hou@amd.com>
To: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>, Min Ma <mamin506@gmail.com>, 
 Oded Gabbay <ogabbay@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20260819230852.287751-1-taimuraz@kaitmazov.com>
 <d359981d-710b-dc52-9741-39cd5ed884a1@amd.com>
In-Reply-To: <d359981d-710b-dc52-9741-39cd5ed884a1@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|PH7PR12MB6860:EE_
X-MS-Office365-Filtering-Correlation-Id: c8d15abf-9764-4464-4b70-08df01fe6379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|18002099003|22082099003|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: ng7VCyxGWMg9wXOdPFP582VLr2kwVx6MpEaYCGCgoH30XjRytSUf4KG9YxnVCW4DfdssuPrirEBhGYqQAv6Du6YHKQVEV3GFdDjfAPuJ99q+wFJmN+lWvUyt4rxC8OnIlxTvqXYkVO8vj3M9xcqZFjHkIrxOxnfkhxeaZ9kGyUzR8+d6J2WmeA38kRbdDxdxSGMOlyJA5b+P/ccaCwLvZpFHNQnUZrs1SK+oBqzkFRS5J9A09WVpVnA5nV39NX49DNeZESE1ycnauN2t0nDJ9IudBYdsTLq4I0BHtROMBYTb+mWYr1BvsSLbvR7pjiW7xyskGEPG3owkiAeDyvu7HdMJ+LzJoQKUAmXFYaHnj5rCqX8beMHnGkdz+rwcZUTmQ+1cIhoKU49Fp9cDxK7RX4NWvYRusu+XCLk77kNnPKlIHl3bDIR6RCtHcAgTsq96fitgYuzC0HJgXatAC3PrShWrD4meOAj9PSY9NSoWqwN3uXuA/Y9ROT98zyayIJi4uotWq4C2zDtId/K+65sOUYusqqDFStKjhubd+xmqLp1FMC4Z0/GejnYsmiHMYE8hQK52xSfxUDolI0r9knwEzKdQQwCWAnZkW67pFjh+SCBdf3sFQ9oZXz3EPTno3IhlhIzhx0VRbMo1c409srTrISLwHBs+uXlxyYB0j0YoAo7im0HCD1JyAG4DeAoySoeSoH8uDeqa8oQNdADahpuvAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hy/GFCWado9tD1bQPCt1kVXGQhSNp26Qq487uiRLrP3vonPxsGHlvD5WWNxcS/rFNlAoGdf1VTNXHEQseRP29Sc9p7yRlVwABl2DY/rWWFV7npPNbtjqQM0WFssIxoshnWYqsYy6ao7iCYUmpOyeYAAszx4kPm4jhoTuoN9WVCg5LwRxNsfkdwFC112th4hqdyCo0Lh8kkbTdPR11meBgGoxVsnkPDAldGJbfEe+ljekA8eryU2h+VZhIiTYrOWr+cuYfEfrYyiT8CLhXeqh9AJmyvP5U2qDMCj0Kh5tynfgGlaUCqKRG6g/UxOYxG7yC86rw5CVRkbdXZlMWlQUSioRmdtHpDrGvMTMdtcscswudE7xDZCrm1oAjgpVTX1eLloXaa11IcVMIv2W0VXzKu5L6ITCGxNvgFEsxUxpm3QBs1XdVx/ECo1RJC22R16K
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 16:40:21.1498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d15abf-9764-4464-4b70-08df01fe6379
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6860
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

On 8/21/26 08:39, Lizhi Hou wrote:
>
> On 8/19/26 16:08, Taimuraz Kaitmazov wrote:
>> amdxdna_cmd_set_error() looks up the first BO of a command chain, which
>> takes a reference, and drops it at the end of the function. The 
>> mapping of
>> that BO is established in between, and the failure path returns 
>> without the
>> put, so the reference is leaked.
>>
>> Ordinary use does not reach it. The chain has been submitted before 
>> any of
>> this runs, so aie2_cmdlist_fill_slot() has already called
>> amdxdna_cmd_get_op() on that BO and amdxdna_gem_vmap() has cached its
>> address. What makes it reachable is that the BO is resolved again by
>> handle here, and the handle is userspace's to recycle: closing it after
>> submission and importing a dma-buf whose exporter implements no vmap 
>> onto
>> the same id leaves amdxdna_gem_get_obj() returning an object this cannot
>> map, since prime_import() types every import AMDXDNA_BO_SHARE.
>>
>> Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
>> ---
>>   drivers/accel/amdxdna/amdxdna_ctx.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c 
>> b/drivers/accel/amdxdna/amdxdna_ctx.c
>> index 855da8c79a1c..4e4a9cf5c327 100644
>> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
>> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
>> @@ -183,8 +183,10 @@ int amdxdna_cmd_set_error(struct amdxdna_gem_obj 
>> *abo,
>>           if (!abo)
>>               return -EINVAL;
>>           cmd = amdxdna_gem_vmap(abo);
>> -        if (!cmd)
>> +        if (!cmd) {
>> +            amdxdna_gem_put_obj(abo);
>>               return -ENOMEM;
>> +        }
>
> Thanks for the fix. I will add 'Fixes' tag when I merge.
>
> Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>
>
> Lizhi
>
>>       }
>>         memset(cmd->data, 0xff, abo->mem.size - sizeof(*cmd));
