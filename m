Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E71C44512
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 15:27:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D367110F33B;
	Thu, 16 Jul 2026 15:27:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eosWzq6F";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012046.outbound.protection.outlook.com [52.101.48.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C370510F33B
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 15:27:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rnHD0y3JsUSRMkuqxOz2PFxGMrRaXqzY/QI6xplJnNcgff3pHOBPQmoFznNZvPUt0DrZBEXjdgq29PPXZA7ijhWfgCqKZnr2QUykGkOd+sxZ6gf50LsVO/p/kKUDZui7fssK5fUCFcWPAva69DudCRra5B25jzq83pfF5ZvCYBX8zWEsxYWuYnxrwEwxywbkZJarFYnMH+2jpM2Zjjf69j0/E2jB74b0kZmy4SVQnoU2MFNZ9rWfSrV7AlJ7MHNACcRegmhLmlsYYmHLcAif2rHaZh4JwhWqVCmoEW9qzOsEfvo9L2vhBl2NwlV3+0LrbMStwmi3jjbe9CxzlHVDCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgNyOevqUSm7K/yBTYnKiQUl218dJ8dhXGPh1IK6SXk=;
 b=Np+Icuj2UUQTxmEfneynvWfNgS2Xu15i6HW/xhLwsDHIpqdtYgTmiR4bnYnR20QCmF3Drs0y1Cw4G1hWDhu3MduH9AekOW5pRSSb8SpcDPSdRy4EHqQAJbHJeHnegeF8Bv1fQ/lOO1y7PK//zebumPCsPSug5V8kMIHEOnFwVj1O3uIXgbyJ+/KudFXErkjLY4E9E8pYAKZpvpzLt7DA/+yzfHsL6dXwktvnE55+Qk8PINpeQE8w4QZi/rNrJkzjLF0YCaPR99cRoDaKQsj6nae4aKgUGqGr0B+izIyPCpigAT5zxGQBEWc3V09AehFDj1b5UWdaET9sgp5SmLUo9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgNyOevqUSm7K/yBTYnKiQUl218dJ8dhXGPh1IK6SXk=;
 b=eosWzq6FhZm9sDIPBDuVPujPfk2ByRAqvkQ8lxHyjOUBgNUv9dZ20Da8xaTF3ickPz2eGI6GS6oc+b36JKGq8UYVP+1wAGetKtbdUogv6FOFFOnNBuIfs8Cq/5McsAQ3fstlypUkM78dU0qLwqfkGMstHZlT6CHV/erzhroQtX8=
Received: from BLAPR05CA0001.namprd05.prod.outlook.com (2603:10b6:208:36e::6)
 by CH3PR12MB9432.namprd12.prod.outlook.com (2603:10b6:610:1c7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 15:27:18 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:208:36e:cafe::6f) by BLAPR05CA0001.outlook.office365.com
 (2603:10b6:208:36e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.4 via Frontend Transport; Thu, 16
 Jul 2026 15:27:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Thu, 16 Jul 2026 15:27:17 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 16 Jul
 2026 10:27:10 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 16 Jul
 2026 08:27:10 -0700
Received: from [172.19.68.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 16 Jul 2026 10:27:09 -0500
Message-ID: <e2d84f97-ab96-46ae-8639-54aeabc822ad@amd.com>
Date: Thu, 16 Jul 2026 08:27:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Fix use-after-free of mm_struct in job
 scheduler
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20260716151305.1595780-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Max Zhen <max.zhen@amd.com>
In-Reply-To: <20260716151305.1595780-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|CH3PR12MB9432:EE_
X-MS-Office365-Filtering-Correlation-Id: 247325b2-e7af-460a-1d9e-08dee34eb8b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: PgfrtC8J1N/9XzHDghkWQZKHReBrAwRwz1/GQq0PgUNxBJxV/NYT3S7AGxglXvCLaEkg4RxFdE4pLlQ56etqKz89tj3y1mn6/Rj7aKQKNHTfHiMwkBoqz24mFdaOHXrgI2TL2LT1bU5nTmtu59LJSGNsVeqPwdyx0eqjBkhnI0+FLbcuk2ORgHdcH3N9v7w5VDA368QGadsn0EK31LQezn4bACQd6CUXFBWMEtP6FtVJPMGI6LDRD8ck5+RwKRahNeHd0J4JKMOhP0RszmpLbnNhPEPfkiZvoPFGdYy1+3cWATQx5pHoCjhX8VBhV8drMaBUb0gui/8ex0jUsNa+BC0V8ZDtJEOLOBVfIlEvE2mRC1e3S7L0PhvtSkN3CtbeRxNySvwbp4TCvyTm/6ZGbyfbWmYcNeQPDjAjvpwD2djTj9Wc+yM66lhq2QDPoF8KFDPr8tx9XdtyYspLA26u3gdkrzYKBy6XnTHzhcjSFQz+4NwBVytzrrzgtk4V38/DYfo7Zrd2BlEHRP9157YRFJJlwvowhgjH4h2Y5FTbavF8D93BhCVmTSk+VbfUVp5iDp5e64KMNY69ytj/fpJP3fMpjy1G4MPb1zdaRqQUNjgBQIaqBs32mnY8uEcs+2lz6CMTYpZznY1JVBV+jJdgoHBwM5sdvNbUBjyQXI1LSha5QE1Y7/5agSZ9LLCKnGET/h/Cx6VlukMm9++lcjL/6A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vP6BlmMgJ4Pd9YOo7c4huvJunuVW0YW9Lh9HyuoXHxcGDbNWU/m8bKovtmDl6Oa3qYYazAkBCQoqVocEZefqfqHH80Mm84qUL7rQWV3cqZfP38HNE/dK2cNrXuDGRCCDj+u5oF6BiINQhjMN5TzAJrPC+Hw6jIeAxOinDVXaDFoZC2pTppNUwehQSjGpHH4TplAiwZWpR7k1yIR2Zg8ezjmwimxT6dfrOw/ddfHpN7DvbQThVafPurk8xCbUctGziEXA91PDXFpRJGDv3jthZwNG+liKeUra8MZ58ds6JrubT63n+DRvkzrtrEjgjV5txU5M8MD/u2fDR9aqete8i9GTURQ9Pf3C/5Ikjkunnk+/6x/sH3CJ0HRWn7CzWyzg4Mgt2PYGALcCvkbgndXz3RRdEhW9GKF8g4uSjoAlU93j0m2qYze6+H/D+biwqBdk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 15:27:17.8396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 247325b2-e7af-460a-1d9e-08dee34eb8b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9432
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



On 7/16/2026 Thu 08:13, Lizhi Hou wrote:
> amdxdna_cmd_submit() stores current->mm in job->mm without holding any
> reference. aie2_sched_job_run() later access job->mm from the DRM
> scheduler worker thread. With only a raw pointer and no structural
> reference, the mm_struct can be freed before the scheduler runs the job.
> 
> Fix this by calling mmgrab() to hold a structural mm_count reference for
> the lifetime of the job, paired with mmdrop() in every cleanup path.
> 
> Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Max Zhen <max.zhen@amd.com>
> ---
>   drivers/accel/amdxdna/amdxdna_ctx.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
> index bdbd3db12a6c..31a414c3f0d9 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
> @@ -577,6 +577,7 @@ void amdxdna_sched_job_cleanup(struct amdxdna_sched_job *job)
>   	amdxdna_arg_bos_put(job);
>   	amdxdna_gem_put_obj(job->cmd_bo);
>   	dma_fence_put(job->fence);
> +	mmdrop(job->mm);
>   }
>   
>   int amdxdna_cmd_submit(struct amdxdna_client *client,
> @@ -642,6 +643,7 @@ int amdxdna_cmd_submit(struct amdxdna_client *client,
>   
>   	job->hwctx = hwctx;
>   	job->mm = current->mm;
> +	mmgrab(job->mm);
>   
>   	job->fence = amdxdna_fence_create(hwctx);
>   	if (!job->fence) {
> @@ -676,6 +678,8 @@ int amdxdna_cmd_submit(struct amdxdna_client *client,
>   cmd_put:
>   	amdxdna_gem_put_obj(job->cmd_bo);
>   free_job:
> +	if (job->mm)
> +		mmdrop(job->mm);
>   	kfree(job);
>   	return ret;
>   }

