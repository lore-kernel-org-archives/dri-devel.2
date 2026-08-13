Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BAEC5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 06:17:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 174CF10E4D2;
	Thu, 13 Aug 2026 06:17:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bM7Yvj62";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012032.outbound.protection.outlook.com [52.101.48.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F83110E4D2
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 06:17:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJVrF+Eff9bVH3rchFrTiUvwIF9NrjYUu4S35P9L9zZSwuFdxDFdinFgf9gOJg6l5PMYZJ0WIMHp8hvesIUE0+DpkGpbUkT6Hu6E3N82V4qxScDWry7M3NUmVg1NQp3uMeMC8LKJFSrXWzAJQ7s2lQ6xkOaNhzShhV1Eo01aoxQM0d9Cv4ewe+S9B34R1dTY2qlhiNBYI3bRvPj/GAP39eRzrJs2crC7hkfVMboiCIzl5K6pe4pKPFrW/ScLejQZTU+XXAJFfQnOn9z9EMqDCUgZ64D8gUnI898kWxBfTbYoNWCCtD+h4nfqnq3qvwBwCGw03UIgy6jQW0QgfTwsSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiVuMtEORWzDWY7Otus7lkwRzxurIc0Bz4vz68qYVt8=;
 b=yOAVbhCtlf6KvMRbNZOF3a/HDhmNnYZCBdY/aq1BLzDXdUSMqvdMMPYt6gjhgOiE1hF/o5puOpN4K5j26hY675/SFfdLyd479ngzAXDcWIk72VslCmTBqWbIcf49iNXTfhhcgypY+bKfLD+D9d2qT4+YvYzKSEW8LS8ylx5rexKQnlU1MPeHGjVGb+ubS519IoGB9j9LGyOtu3bcBKK/rDcm5ftP182LsPmIt+RAqDlI4u3Seq6BRUzbmWX+oq1ksc2MaiCnTxQaoWBBGcDTXj4SjEUd57oIxVxJFmyWZ8fg2gYpc2BwgIe+Zu6RrLARJ3gbFYbap8jMv1b3UHlBdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiVuMtEORWzDWY7Otus7lkwRzxurIc0Bz4vz68qYVt8=;
 b=bM7Yvj62ARn5PJzwrXMAOiEw7Fny0AM1ZYv0SmD91+/On6icxuXX7dlfBvfGW70LqyNhWTxSEu901V73I5QlO4BdJQeS6ikfDnz9B45g6EgE/C8XDs+bzCtA4fEptupcHR8zXkVM+HO++F21/ygiOKbrc5QKDeWa1z2DDu6BE/Q=
Received: from BL1PR13CA0161.namprd13.prod.outlook.com (2603:10b6:208:2bd::16)
 by CH0PR12MB8549.namprd12.prod.outlook.com (2603:10b6:610:182::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 06:17:23 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::42) by BL1PR13CA0161.outlook.office365.com
 (2603:10b6:208:2bd::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.11 via Frontend Transport; Thu,
 13 Aug 2026 06:17:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 06:17:23 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 01:17:21 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 01:17:21 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Thu, 13 Aug 2026 01:17:20 -0500
Message-ID: <b9cd6526-adaf-8058-55dd-b19a56b0dbcc@amd.com>
Date: Wed, 12 Aug 2026 23:17:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Skip unmapped range in
 aie2_populate_range()
Content-Language: en-US
To: Max Zhen <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20260812205628.810816-1-lizhi.hou@amd.com>
 <8f4457fd-ef92-4783-b8d5-b4bb1f61de04@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <8f4457fd-ef92-4783-b8d5-b4bb1f61de04@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|CH0PR12MB8549:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dc5ead9-9301-40dc-e5c8-08def9028a2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: LIdelp7UCIQya1Q3PPcvVV8JEnADIsmGu3/7ntiz/OCqHwVrx29lLlNcgBLOmDrW/+3weFwBZNB/ofPFjIQdQwsIEcK4tYlRUUltxlppgwDVjB9KQqkKLewNr9hJKr+v16upgVJPHgMeUi5KfiAiUUK75FD0eRezZDCErFG2ECktk2j4vudlcyCN0vxzw3gxDDT/0HiOqWw+roHPpYk0WkDgKJmsqECCBitKC1ld3z4WMrUGidcJt2Wf+MXJFOIbbsUq4jdpJ0cwPMD41shFfL7nmrJR0v146yQZuowykOHMHoyvrr5y2NYWL+ctiPMZaT4+CEIkfPqaAY314IcP1hmB9HdVHtyYIdceJ1reV8KubRveZ8NtnYJDyzLKTXdSTsSUYx19g3KbQ7lhsM0s5NJSkBQ8t4WSebmn8diyYrb98FWyUHqaIYQep9uY91dqkok/Tnk6yf4EnlOXF8L/8HSytEMRsYFGv9Wx7KqdbHdbMymgNPcI5b7p7bqIdObzgrrCZbp3h/MFETESrOcLN4DdSu/nGhF86UVqZgThuSDbcmqzogiALcDcosaixCkb7NgtPxv31MzYqg2cF8/Hr5D9sXRgO6m9foV5RgyQCgK0Qzs8EvkBWttEksZ0je4M0YGU3L6Cs3Swz4te1OCZop8uxzLJqHlnMuCGNLqrwG4RV3CMWdzh2vTIdg5qgBPBJXws6A52MBxM+TP5cPhDbg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6fNJugSGVdZuEPMUTZVYAPyzkiJo5bfJAcjf/Az0Fztxy9xzyWWuKpHzNlipb0IKWk7KjsscfJ4VlDmp9UHYRHI80FZdraFZ6LVLcLyt8pY9mzIRRze85eqJ+ogyqUi8rhhap7VfNhgKdy9GueF15Ap93NAlqHHOddlxMfam1OLWZYY6ZvUT2Gr8I2uAVO9JFdgURAJLSBVtCU7x1h3TsIcJT7Am2sezWoENbcAPh0b4CDRUqEd89YfJ2QmJp/fflBXY85DFLpH07OxjVf1ZNk5iJPJ9XKepQAlGoASggVWibhplQHr4kdI7cpsILDDMO8l+inVDM2FQ+sMLxrkyQ1/GIFXRsdLHW1C2xHphK+Y+6Wc4x9jNkMzv//+/tuZ4xZmHAPsR2txPWQaS5mJJZMAy9WmZfgLPNlv1Xy2JDuCcRBd8BgV/TpdMBuRZ7Qjp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 06:17:23.6070 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc5ead9-9301-40dc-e5c8-08def9028a2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8549
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

On 8/12/26 14:26, Max Zhen wrote:
>
>
> On 8/12/2026 Wed 13:56, Lizhi Hou wrote:
>> aie2_populate_range() incorrectly failed jobs for BOs with multiple
>> mmaps: if the unmapped entry appeared first in umap_list, the loop would
>> pick it up, call hmm_range_fault() on a gone VMA, and return -EFAULT
>> without ever trying the remaining valid mapps.
>>
>> Fix it by skipping unmapped entries. After the loop, if the map list is
>> empty or all maps are valid, map_invalid can be cleared normally.
>>
>> Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviewed-by: Max Zhen <max.zhen@amd.com>
>> ---
>>   drivers/accel/amdxdna/aie2_ctx.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/accel/amdxdna/aie2_ctx.c 
>> b/drivers/accel/amdxdna/aie2_ctx.c
>> index 4b3a62aa8798..8d9c283f606a 100644
>> --- a/drivers/accel/amdxdna/aie2_ctx.c
>> +++ b/drivers/accel/amdxdna/aie2_ctx.c
>> @@ -1052,6 +1052,16 @@ static int aie2_populate_range(struct 
>> amdxdna_gem_obj *abo)
>>       found = false;
>>       down_write(&xdna->notifier_lock);
>>       list_for_each_entry(mapp, &abo->mem.umap_list, node) {
>> +        /*
>> +         * Skip entries that have already been unmapped.
>> +         *
>> +         * If userspace unmaps the address and later submits I/O using
>> +         * it, the IOMMU will reject the access and report a fault.
>> +         * Ignore such entries here.
>> +         */
>> +        if (mapp->unmapped)
>> +            continue;
>> +
>>           if (mapp->invalid && kref_get_unless_zero(&mapp->refcnt)) {
>>               found = true;
>>               break;
>> @@ -1059,6 +1069,12 @@ static int aie2_populate_range(struct 
>> amdxdna_gem_obj *abo)
>>       }
>>         if (!found) {
>> +        /*
>> +         * This also covers the case where all mappings have been
>> +         * removed. There are no invalid mappings left to process.
>> +         * Any subsequent I/O using the unmapped address will be
>> +         * rejected by the IOMMU.
>> +         */
>>           abo->mem.map_invalid = false;
>>           up_write(&xdna->notifier_lock);
>>           return 0;
>
