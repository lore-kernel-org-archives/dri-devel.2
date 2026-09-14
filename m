Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60685C88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 18:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6882D10F119;
	Mon, 14 Sep 2026 18:26:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Br6gnzXt";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011062.outbound.protection.outlook.com [40.107.208.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE7A010F119
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 18:25:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2vevqPdLqdzQIH+BX6wUiLUiWLbLGQ7blbXXaeH712yWkX5O83KbXFxODO3mX96oub+qlIPZ3CnYINERhqem3tYGzVNu7eHkD0zEKFdQ3hkVdtSLqv/JqntN/p3M6iuDmRCfAwjgd++mwlVh31Cx7sQ03h+aDgU3UOvw+qKd3/eRLA8RN4ztK/LO03116XLmTCw3RwMbNuAbcGOUPiq1sf9SP8DajqEy1UdsukZw1JXtA7wyi0u4hKbhdh120A4CrOW677whfMA7We2HTJn+YNptW+LKYCeOcGaSJcAdIm8FVW60zsX6rikaUtu2aVd18v1sRauri42oAMbuBrrEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/+lZ07oMq4kj/XFUC2SSs5bFJPNCG9LezM8XZQGCrQ=;
 b=Yn3/gsBh+TqCJ8wjPSKdACuG3MnT10qTEtewDbCi69rDz4nm0/yXQbfihIeMyHlMY3oFYxdKGnSTmsKHQDmMxopmb/UPPVX6lZ3hOQeT5OZyzqh7dckXw0ju3rheD6nCxfrsyIcUEPzVkuEBjI43Bwi5fCdD7o2blXSIhsTH9h9tWqBhOTH2AuhIntiUz82pGHpiovNy6SrTjCeU+UwlJBLiC9VkteXpERAL8PJ+dDvoVYE+mgBuRzD2LLLgbwWigBfUvTvD1ZxoMN7GOSmmp6HBYIIO6dYN+Ptf1clc0R1jTiF99FcsrqdUdXy2mkaW4DiuFESLX+MTbaHgeHhrQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/+lZ07oMq4kj/XFUC2SSs5bFJPNCG9LezM8XZQGCrQ=;
 b=Br6gnzXt2WBF6d4tJ4YR6jpi+++feG+JQX1bQq1Vz+tygf2cDhKj1/VettEwqMJETyRpWcDn5VhnKp/Idl3JICu8OpT/X3+mBQbs0Wrz2UGBrfCNIRFr6mfNOhoahqArTviWeagvXCh6WBRUhVi/Ra4AqEy0Tr84HDOfRkaDKb0=
Received: from BN9PR03CA0716.namprd03.prod.outlook.com (2603:10b6:408:ef::31)
 by DM4PR12MB7599.namprd12.prod.outlook.com (2603:10b6:8:109::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 18:25:54 +0000
Received: from BN3PEPF00022BCF.namprd03.prod.outlook.com
 (2603:10b6:408:ef:cafe::27) by BN9PR03CA0716.outlook.office365.com
 (2603:10b6:408:ef::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 18:25:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BCF.mail.protection.outlook.com (10.167.248.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 18:25:53 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 13:25:53 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 13:25:53 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 14 Sep 2026 13:25:52 -0500
Message-ID: <7e7c456d-fe38-caa4-0a82-cf4ebfafd72a@amd.com>
Date: Mon, 14 Sep 2026 11:25:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/4] accel/amdxdna: harden command BO payload validation
Content-Language: en-US
To: Eva Crystal <0xiviel@gmail.com>, Min Ma <mamin506@gmail.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20260912081012.2274075-1-0xiviel@gmail.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260912081012.2274075-1-0xiviel@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BCF:EE_|DM4PR12MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: d389e86a-3788-4f79-bb41-08df128d9caa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: SmxLoF9KCLUO8Mjj82xQHgq9g4MXkg/001ouDFYaJzSd6Jj+M82qPBpY9vNZgqD663L3WTW9hqG8byMZ4UxxA+R6IBk6khr76EjOLuExi8kQvlnstDhWAiwLu9NWLj0V3HW1WbsiMcQR2dOVB+54krW8k2df7mrLwXQYuaZSh1gP2XkReKX2OZlCGHvhco6pMrxMuPdJBzqcOVAcJQskBdNF8EKFIezCJj2bbxFHpXTA5cYEwtHlHv8nOyrQL0bw74N3p2jV1PzSjaKcC0bIYx5LMa6Rh5y3PRGU23Ze0ka4GYcQmQomNbVe5CF7vg0jpCLgDMssxb9YUaKEIFSMihWUuWah8eWG8MmYxST7gn5OXBdJCyc69bo7u+eZ3aBxUhqqE3etmUTJfdGTMXVL2ILx5+UHcu+N+Dl/la7a36H1A9rePU+Lu8f4gMNY26EWukKcmtQvJCS9HlguYfIC8eiPSexXOdRxXjD27LogqmgCaJDSBwKyKdyZvPPdECsQMK9/VXk1k40LKpY/qGnufSmDqe2DEH4OUdFxOH9Q7EtjQfiF+x7TaULWNoZmXHQI+a4+05Tr/7OFmK/KbsX6mJUEf361p2LPwe9zi1vGbZpaDtEVbRXnvOqRwmIvDXY1OCgzkWqsQK/oRZy0RpkaAGzVr9Xoe2TQ9okyobr/6oDdEoxgf514UKkUF3zOHQglzoyG6JgheypqB3P7rnNY1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lGThb5t498LoekuFNYrY6ORvvrpSnb5GenDQVeAdki8tU0pCffR6Ud/8RRmDwUlkaYIVrb8JyEring40dBA6VOBfNE5UE4YbzJgjIaEGsmXVFlWefn1Le2Y1kdkjh6UiJFYCZpv4skQ7fRFrSmxF62bbINjdDW4+dPE4VWza1IecMovVLZRyvTbXug71AjIlwRUgunfsBC/No89KSdlUny0VoloYr3XleyanhEc5gzvsRApHKmQZPMGor9F+2UoJgI2nSNreJEbEz0Ut1ZsdUZQbXeI8CtMgiNOBZtrsth5sDu2dN2Mn3LwOjc38tG8GVBb1pHMrsObScgXatOA6RjS2y6Qhamz6k+4faAa2sJ1aF3d5JxoHbE0qPTcbnFZ76Cnh9q/yHaKVu+urBB2xeB7uOvS9YPOff1W2b+7nkz0RX+3UluOJMgfAMPOSSd0d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 18:25:53.7579 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d389e86a-3788-4f79-bb41-08df128d9caa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BCF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7599
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


On 9/12/26 01:10, Eva Crystal wrote:
> These came out of a read of the command submission path in
> drivers/accel/amdxdna.
>
> Where to spend review attention: patch 3 is a real fix - a leaked GEM
> reference on an error path. Patches 1, 2 and 4 are hardening. I could
> not reach any of those three, and each commit message says so in as many
> words and explains what currently prevents it. I would rather be plain
> about that up front than have you read three messages looking for a bug
> that is not there.
>
> What the three have in common is that a check on user-controlled data is
> either skipped, or holds only because of a property established
> somewhere else - an allocator that page-aligns, vmap() refusing a
> zero-page mapping, or the integer promotion rules. Those properties hold
> today. They are not local to the code that depends on them, and two of
> the three sit next to siblings that already carry the explicit check.

I will run some tests against these three.

Thanks,

Lizhi

>
>    Patch 1 makes amdxdna_cmd_get_payload()'s bounds check unconditional.
>            It is currently inside "if (size)", so a caller passing NULL
>            gets an unvalidated pointer into the command BO. The single
>            NULL caller is safe because command BOs are always
>            PAGE_ALIGN()ed.  [hardening]
>
>    Patch 2 gives the error-path memset()/memcpy() in
>            amdxdna_cmd_set_error() a floor. The length is
>            "abo->mem.size - sizeof(*cmd)" with no check that mem.size is
>            at least 4. A zero-sized BO is creatable, but cannot be
>            vmap()ed, so it is rejected a few lines earlier.  [hardening]
>
>    Patch 3 is an actual bug fix: the -ENOMEM path in
>            amdxdna_cmd_set_error() returns without dropping the reference
>            amdxdna_gem_get_obj() took on the chained command BO. Small
>            leak on a rare path, but a leak.  [fix]
>
>    Patch 4 adds the explicit short-length and NULL tests to
>            aie2_init_exec_dpu_req() and aie2_init_exec_cu_req(). The
>            length test is currently performed by subtracting a size_t
>            from a u32 and relying on the result being evaluated in
>            64-bit, so that a short command underflows to a value larger
>            than the destination. The slot-filling siblings in the same
>            file (aie2_cmdlist_fill_dpu() and friends) already have the
>            explicit "cmd_len < sizeof(*sn)" test; these two do not.
>            [hardening]
>
> No behavioural change is intended anywhere except patch 3. Every input
> the new tests reject is already rejected today.
>
> Based on v7.1.5. Compile-tested as an out-of-tree build against 7.1.5
> headers, no new warnings.
>
> Not runtime-tested, and I want to be explicit about that rather than
> leave it implied. I have the hardware - a Strix Point NPU, 1022:17f0,
> running npu_7.sbin 1.1.2.64 - and I am happy to run whatever you would
> like on it and report back. I did not want to send results I had not
> actually produced.
>
> I have deliberately not added Fixes: tags. I worked from release
> tarballs rather than a git tree and could not verify the introducing
> commits; someone with the history should add them if these are taken.
>
> Eva Crystal (4):
>    accel/amdxdna: validate the command payload regardless of the size argument
>    accel/amdxdna: bound the command error payload length
>    accel/amdxdna: release the chained command BO when vmap fails
>    accel/amdxdna: check the command payload before using it in the exec requests
>
>   drivers/accel/amdxdna/aie2_message.c |  5 +++--
>   drivers/accel/amdxdna/amdxdna_ctx.c  | 39 ++++++++++++++++++++++----------
>   2 files changed, 30 insertions(+), 14 deletions(-)
>
