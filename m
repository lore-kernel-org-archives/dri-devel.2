Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D4BCD8CA7
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:10:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BEC910E186;
	Tue,  9 Jun 2026 08:10:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="E9D7aoIT";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010056.outbound.protection.outlook.com [52.101.46.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC06310E186
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 08:10:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rAfuNrINNGWk7nZ1XShPizBpw2R5wEoV9e8VS0Wime1cVh5cdMXSLIg1Mi/tPaJDVwpyExSExXTWChovRKizq4oiIZ+Nudf0dBlIPbBlqZtCw5RbcceqenMJ5kEef4kM0OK60QWRFB1iB2tY04AjLQsSgwLP0Y077YwRBFhPPzj2rhcaY/h0X7eZbPvalcOmiY3xr61FNqs150dN+E+wBEOcvH2hZoBrHoS4f0MfVs2z9K6Fnd4i01lvdz/PZ+9qwFiVovxUuHh+YqRNrAL7lQVJJNQk81OPSe50nyaIUd7DCxnm8mwNJ4PXdiOnx4RHMG0LfaamMsxMnMGbRfgJZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnHIUGJ0L5YQfz59V4b9YSstzdHlHE42W90kxXzW99s=;
 b=iEIF4gAn/icXm7PKg8UQeQoxeByqR9LlVJXV/lv8kLtUyRZBmwkgyDaJGvnyig+/Hjg2p4TLGmOX8/gZzTl/cBvFXwvPngHvlTSV/bSJ3zl0NgKz1u63Pet/MWj1c4/lIRMlexOvPfyDAMpiaoHMAL9VaYLs31y4pCYpjA05khzUUZ6uqQo9dSHnBtl7dOi9WuNh1sv9tZ9GyR3MqDCVHvuRNWlJLuiX5PdpUcMpV2sN7r3kWMSRTl+/wS8gcCtfqBdi63Tqe/dWsKAjRAcHMuzPTyA+Nc2mJZOIRjukJLzPoxZRFdVF8XZDDOxkDLzS8fm+pXkim3Bq5Hj2JkXtBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnHIUGJ0L5YQfz59V4b9YSstzdHlHE42W90kxXzW99s=;
 b=E9D7aoIT6THqZGbLfak2KnTcrW6l4TrgXgUoTE/EKKAQP9/fZboxTaJKwNgAic1WWxVqebnKoxW4mGYzWA2AbPVVdkyW4X7S7vkuSPkkC/In1bdG6ZBbtt3bA/WG+SqSmhLIZpgnWdsZK/Sib6YwOlZcBCu8ITTsNN5LLCWOtXJxqcO+u7JiDb8FdX0MEYWfIy83m7PkURSeujRKOtWVky0U0J8OzyFdqfgCjjFpMmtU3APbp3frNZ3Wuru85+NI929XyYrks9iNfxNa1vBg/sw4BifZgTYCO2BfP3xr05nMojd0zoCgqHUQCnephWIKNzMI9xZV/HdaddedEl2aBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MW6PR12MB8900.namprd12.prod.outlook.com (2603:10b6:303:244::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 08:10:27 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0092.010; Tue, 9 Jun 2026
 08:10:26 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Tue, 09 Jun 2026 17:09:22 +0900
Subject: [PATCH 6/6] gpu: host1x: Annotate intentional syncpoint
 wrap-around
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-b4-host1x-small-fixes-a-v1-6-7c1131c0b3ad@nvidia.com>
References: <20260609-b4-host1x-small-fixes-a-v1-0-7c1131c0b3ad@nvidia.com>
In-Reply-To: <20260609-b4-host1x-small-fixes-a-v1-0-7c1131c0b3ad@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: OS7PR01CA0287.jpnprd01.prod.outlook.com
 (2603:1096:604:25a::18) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MW6PR12MB8900:EE_
X-MS-Office365-Filtering-Correlation-Id: 8217e4ee-f4f9-4919-d0a5-08dec5fe904e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|6133799003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: GEeX60XhbP2TSXb/ldQcOvHFaH0gNjQHXTy597IsKlafqDxsQKvCZfm7RNxyG4h2Hr/Ew+XpSHuJ+PBo4Dbn2jdTeIhB7oWeyBlJIvIpiNcY7V/tvYlDnREOipWUevGYRzcJnqyrlhZAMPuVOgslRuKuEwImiE0fvVN7hajUHKEkTCxpuCX+5fp4L0iTdO9tQpjP00ZT4dXurTz4rmJWFtdT8iqC6d7N7mdbpoi2Zt81ktYZaQ5cU+7/hSYWhlhscI47R1+OxCvIUA+0MeJl9q9xApPNUFEnqtQFjPVatGzp3uhBvowm3NF40Y3wYYJcQi3VWt/CwVLNg5NQ9+0dIL2nRZKi/n2BrEbcaG7KMIIk96mHAO0u3wbDyxLnigUdyx+iqBWyTSiQI/V52f6rOCwLLY6HjwbqaFE5zoJ0Tuz0jQef8gKgKCD6yuZhJWzb68cfmVaOdGXr0HMMdMGQknRlGqdXlSn2uaB5OMLfH7PIJpJmBCGl+L1RlSrBTBfao0OH7hy+1DWCqe6zjXnAkE01fo+kTmVu7QLFYh/lDBmkcieJBE+ELtWMwTGcGXwhBgcG0oq0mu/I3VVK6LLtv1CsQxVhGPOlvGinuDIskjf333yQKpzDgm4FMVHBP6aPQ1Ve2f4xKf4Hj7IlX3Zn4lhUi6IrBEBIOELm0Ofcitt7Bqn/CgAHb8lOLGbW57aR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGxCYzJ6SGJnL3ZGNTZ3a1pqNlRtQXltUEdSQkRDYUpnMU1LQmVMZXoySGl4?=
 =?utf-8?B?V3owYkp2UWVNbHl1OFpQSjV2cCtlRVdtVTVTRXUzZlBaZmtUb1JrQm1MbHNJ?=
 =?utf-8?B?bmo0UW1uTE02bU0vTkVGZ0tGbWtWRjhwU1FuOStaQjRrRklGYWdyK0hBQ0NM?=
 =?utf-8?B?NjN0NFowdVpiT0dQajQ2ZjJLbFc5MmlkNk5GQjBMVER2TnVuMHdNMVdLNHRv?=
 =?utf-8?B?L2t1a0pZQjg5Q2NFTjl6R0tsbC80elZLYUY2MjRqYVRwQS84Zm9WaGtnWHRp?=
 =?utf-8?B?TEQwUEhsdkVIMkhDWXhqdmdIa0lLV2JsNUFiMjNuMWNzN0NQTG9KRFRCMSt0?=
 =?utf-8?B?UWdvVTRGY040YnNyNDAycmxtZ1Z5UEtIVWRuTGZXeWVSM0JldDZhNzVwc2VR?=
 =?utf-8?B?OGg5S0YyeXNOZURvejNPK1FITWxQNW5EeDBpL1BDRWZvWUdrRGdSbXB4WDNp?=
 =?utf-8?B?KzNHNWhIMFRUUEpKSmQxeXpRSUFQbGF1RDkxWE9MWjNIUXhEaXhEWG9RVHg2?=
 =?utf-8?B?UUxFdmxqYWNXY2FXb0dqdWc3MUdIV285bFArQndTaE9EQURXZ1c0R0c5cFUz?=
 =?utf-8?B?eG9Bb0Q2UER5ZnYyY1ZBYU15SnRoV1ovdTJXaG8wOWlNRDBSejNRZ0VQc0cy?=
 =?utf-8?B?TTlVLzVYNmV4ZENvQVVFZmhVT0FCYyt2SDg0SGs5emlpZnA1eU1NaHZzYlRC?=
 =?utf-8?B?dVJoem0ySWpGOWtERUVSVWp5WXEyRm9MY0F6dTFhenEvcThSV2VqbGxTN3I3?=
 =?utf-8?B?dVNCZE1sRlRPR2xVN2xMT2Y0SDA3a2Zhd1UzTEZSSlp4azFXTzVBcWcrYllx?=
 =?utf-8?B?MHBGN0t1SllUaXBRQzRmUkt4Uzg1bVJ5RnBKb2tQeWdmUjVFVmRoU1lLUUgx?=
 =?utf-8?B?Y2NoUUNYNEVzbVUvTjJKcEt0SkRoa1Z3UjJLbXZMSXNZbTFKTHJqa1N2bTJh?=
 =?utf-8?B?ZS9UbGVJQ0VNYzNWSk1SZ1pVdDFNUklQdnBGcGJCc1hmNmVpb1lUUVRneVNB?=
 =?utf-8?B?WWxJeWpwOVFPQWJERWVaelV3UURLaXNVd2hHR0dJdll0SjZZU0RvZXliMndh?=
 =?utf-8?B?ckdHb0hCVTJxcWFjeEhRd3hvaE9KMVQ5Qk5KTUNaenlPRE94NElHY0FnaTZl?=
 =?utf-8?B?M2VzelpZQlpiZ3Vpb285UFM0bGtETWxCRXAvWVlWb25yM0JDVHhVUnc0eGFU?=
 =?utf-8?B?QTZpWWl4aTNhSXcrSkJrVXFtdUt3aEVNUDU5S3VoQmJRdkJ4R21VdzFSYTdD?=
 =?utf-8?B?RXVBdUUydFlabkVxNEdLWTVjUTF1MHByQVhmOVNlSFI4RXV5R202Vnd5ZE8z?=
 =?utf-8?B?MDdwYjNMSjRGdTZYYVNxTjE0bmRQUk5NMk9iZFF1M2FHT0IyRzFNejBwYzQ4?=
 =?utf-8?B?UUpkUzArNkNQQXVzdmttUWpJY3lHbHdGMHZxWHBCVUY5RXgrV3dWZG1KcHBP?=
 =?utf-8?B?ekVQdXo5VkpOUzdPM2lCekduUHpUT2dTd3NpS3ZmT3FKa0ZvMTFoNkM1TE9j?=
 =?utf-8?B?TnU2eit1OHhxVG40a2o0bkMwUzVQbTVNVmgyazRwSWI1Q2l3Y0NKWlZ3di9Q?=
 =?utf-8?B?Rm9KSDNJbmtHMlVXcTQ2TWhuVG1hcDJsMGJsWVNET285Nittd2ZxL1grci81?=
 =?utf-8?B?alFuUk9PaXM1blFWNUtIMGU3MHF5QkpOZGFUMkR1aE83OGpyNmxsTFlFOXBv?=
 =?utf-8?B?WDl4K0FKNG4vUTRMMHRaQ2xWUnJCeElQRzllYkVMd3hKMWF2T2ZyRHBkcE9W?=
 =?utf-8?B?TUFUWVhUVmtRRmQ1WlJlekRqZG9qVVVQOVNOSHdSU3NmRC8zV1p6dW5HOGtZ?=
 =?utf-8?B?Q0dBckFzYmFIaFZ4cDd2ZFFOdU5VQmZFeXdFR0xpU1J0VXVxaDd2dUFpdTAw?=
 =?utf-8?B?bHo5Q0xqR2R4N0pORmY1WUlsSWhiT1F1dEVYWGRLR3hqM0ZFZXF5QWpQelNj?=
 =?utf-8?B?VFZMOUU3SG94KzFXaXlrbWlmdnROdVkvU2FnVDNDR0Nqd1BFVTkwQkR5MndN?=
 =?utf-8?B?cnJmeFZNZXpKT1hDV21NTGJweGxqME5yRURpOWN3NDFUeUZwWVpLSFhmVTYw?=
 =?utf-8?B?MVhlRlRwR1RRT1dxUG5FN1loclZDeGQxSVBBV0sxTGJtcHFUcHFrcWRvbjBO?=
 =?utf-8?B?RHhoUUxhdjVsSXV1ZVFyMmg2QklGbGdqZGZ2aWF4Rk9rdE90WGtIVUFrNFNv?=
 =?utf-8?B?dVowdGJyK2ovVEVMV2NqenhvWTZZUzgyMHJQSDNDYVhtRjBXaC90anFFTFV0?=
 =?utf-8?B?TGhQeXNVNjhhZDYwRHEwM0t5bkt2RW1nU2o4YndKd0NUVC9SMU5GR3Vwa1hj?=
 =?utf-8?B?TTN5c25aeXdqb1NCWUkraThjbTlyS3hURUpaL2tmWlRZQ0E5d1dYN1hpeG92?=
 =?utf-8?Q?kqC4tT2V8LAaD5oFCJZFTRdEoikiwywZRsq21tK2tcuHm?=
X-MS-Exchange-AntiSpam-MessageData-1: dkQywl8JqVn0AQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8217e4ee-f4f9-4919-d0a5-08dec5fe904e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 08:10:26.8507 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFi9Gqr8COTiQT0NxP9gqDXFD4dn3P5DirAKJc4Svrd/FfzUB+GA27z3BVMipBJNssEEOVspZ+6E+0tfa8AszA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8900
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

Host1x syncpoints are 32-bit counters that roll over by design.
To make that explicit in the code, use wrapping_* functions whenever
arithmetic is done on syncpoint values.

Atomic operations cannot be updated but a comment is added.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/host1x/cdma.c          |  3 ++-
 drivers/gpu/host1x/hw/channel_hw.c | 10 +++++++---
 drivers/gpu/host1x/intr.c          |  5 +++--
 drivers/gpu/host1x/syncpt.c        |  7 ++++++-
 drivers/gpu/host1x/syncpt.h        |  3 ++-
 5 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/host1x/cdma.c b/drivers/gpu/host1x/cdma.c
index ba2e572567c0..f6d3db2c8c39 100644
--- a/drivers/gpu/host1x/cdma.c
+++ b/drivers/gpu/host1x/cdma.c
@@ -13,6 +13,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/kfifo.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 #include <trace/events/host1x.h>
 
@@ -419,7 +420,7 @@ void host1x_cdma_update_sync_queue(struct host1x_cdma *cdma,
 		/* won't need a timeout when replayed */
 		job->timeout = 0;
 
-		syncpt_incrs = job->syncpt_end - syncpt_val;
+		syncpt_incrs = wrapping_sub(u32, job->syncpt_end, syncpt_val);
 		dev_dbg(dev, "%s: CPU incr (%d)\n", __func__, syncpt_incrs);
 
 		host1x_job_dump(dev, job);
diff --git a/drivers/gpu/host1x/hw/channel_hw.c b/drivers/gpu/host1x/hw/channel_hw.c
index 9dda73199889..a8251ec0810c 100644
--- a/drivers/gpu/host1x/hw/channel_hw.c
+++ b/drivers/gpu/host1x/hw/channel_hw.c
@@ -7,6 +7,7 @@
 
 #include <linux/host1x.h>
 #include <linux/iommu.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 
 #include <trace/events/host1x.h>
@@ -120,7 +121,8 @@ static void submit_gathers(struct host1x_job *job, struct host1x_job_cmd *cmds,
 
 		if (cmd->is_wait) {
 			if (cmd->wait.relative)
-				threshold = job_syncpt_base + cmd->wait.threshold;
+				threshold = wrapping_add(u32, job_syncpt_base,
+							 cmd->wait.threshold);
 			else
 				threshold = cmd->wait.threshold;
 
@@ -259,7 +261,8 @@ static void channel_program_cdma(struct host1x_job *job)
 
 	/* Submit work. */
 	job->syncpt_end = host1x_syncpt_incr_max(sp, job->syncpt_incrs);
-	submit_gathers(job, job->cmds + i, job->num_cmds - i, job->syncpt_end - job->syncpt_incrs);
+	submit_gathers(job, job->cmds + i, job->num_cmds - i,
+		       wrapping_sub(u32, job->syncpt_end, job->syncpt_incrs));
 
 	/* Before releasing MLOCK, ensure engine is idle again. */
 	fence = host1x_syncpt_incr_max(sp, 1);
@@ -297,7 +300,8 @@ static void channel_program_cdma(struct host1x_job *job)
 
 	job->syncpt_end = host1x_syncpt_incr_max(sp, job->syncpt_incrs);
 
-	submit_gathers(job, job->cmds, job->num_cmds, job->syncpt_end - job->syncpt_incrs);
+	submit_gathers(job, job->cmds, job->num_cmds,
+		       wrapping_sub(u32, job->syncpt_end, job->syncpt_incrs));
 #endif
 }
 
diff --git a/drivers/gpu/host1x/intr.c b/drivers/gpu/host1x/intr.c
index f77a678949e9..f9fd8a471e60 100644
--- a/drivers/gpu/host1x/intr.c
+++ b/drivers/gpu/host1x/intr.c
@@ -7,6 +7,7 @@
 
 #include <linux/clk.h>
 #include <linux/interrupt.h>
+#include <linux/overflow.h>
 #include "dev.h"
 #include "fence.h"
 #include "intr.h"
@@ -17,7 +18,7 @@ static void host1x_intr_add_fence_to_list(struct host1x_fence_list *list,
 	struct host1x_syncpt_fence *fence_in_list;
 
 	list_for_each_entry_reverse(fence_in_list, &list->list, list) {
-		if ((s32)(fence_in_list->threshold - fence->threshold) <= 0) {
+		if ((s32)wrapping_sub(u32, fence_in_list->threshold, fence->threshold) <= 0) {
 			/* Fence in list is before us, we can insert here */
 			list_add(&fence->list, &fence_in_list->list);
 			return;
@@ -83,7 +84,7 @@ void host1x_intr_handle_interrupt(struct host1x *host, unsigned int id)
 	spin_lock(&sp->fences.lock);
 
 	list_for_each_entry_safe(fence, tmp, &sp->fences.list, list) {
-		if (((value - fence->threshold) & 0x80000000U) != 0U) {
+		if ((wrapping_sub(u32, value, fence->threshold) & 0x80000000U) != 0U) {
 			/* Fence is not yet expired, we are done */
 			break;
 		}
diff --git a/drivers/gpu/host1x/syncpt.c b/drivers/gpu/host1x/syncpt.c
index acc7d82e0585..9ac4f0c80728 100644
--- a/drivers/gpu/host1x/syncpt.c
+++ b/drivers/gpu/host1x/syncpt.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/dma-fence.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 
 #include <trace/events/host1x.h>
@@ -126,6 +127,10 @@ EXPORT_SYMBOL(host1x_syncpt_id);
  */
 u32 host1x_syncpt_incr_max(struct host1x_syncpt *sp, u32 incrs)
 {
+	/*
+	 * Syncpoint values are intended to be modulo 2^32, so overflow
+	 * here is intended.
+	 */
 	return (u32)atomic_add_return(incrs, &sp->max_val);
 }
 EXPORT_SYMBOL(host1x_syncpt_incr_max);
@@ -274,7 +279,7 @@ bool host1x_syncpt_is_expired(struct host1x_syncpt *sp, u32 thresh)
 
 	current_val = (u32)atomic_read(&sp->min_val);
 
-	return ((current_val - thresh) & 0x80000000U) == 0U;
+	return (wrapping_sub(u32, current_val, thresh) & 0x80000000U) == 0U;
 }
 
 int host1x_syncpt_init(struct host1x *host)
diff --git a/drivers/gpu/host1x/syncpt.h b/drivers/gpu/host1x/syncpt.h
index 4c3f3b2f0e9c..9eff42efc445 100644
--- a/drivers/gpu/host1x/syncpt.h
+++ b/drivers/gpu/host1x/syncpt.h
@@ -12,6 +12,7 @@
 #include <linux/host1x.h>
 #include <linux/kernel.h>
 #include <linux/kref.h>
+#include <linux/overflow.h>
 #include <linux/sched.h>
 
 #include "fence.h"
@@ -77,7 +78,7 @@ static inline bool host1x_syncpt_check_max(struct host1x_syncpt *sp, u32 real)
 	if (sp->client_managed)
 		return true;
 	max = host1x_syncpt_read_max(sp);
-	return (s32)(max - real) >= 0;
+	return (s32)wrapping_sub(u32, max, real) >= 0;
 }
 
 /* Return true if sync point is client managed. */

-- 
2.53.0

