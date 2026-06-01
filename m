Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2283ECD6E55
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 15:19:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57EE71134AF;
	Mon,  1 Jun 2026 15:19:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YvgtSgCp";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010021.outbound.protection.outlook.com [52.101.46.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A09E71134A6
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 15:19:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y7gUwFF3KVxg8RDbCf0c8xO+W99nIqUyG5HQ4H7n5WgRAv1yG3rWq+QZyav7t8fNvyeni/9K1ZTWXobt1iX8PWeG3O14NlalwsOQwuxofo5ejlrpOoQn9IGe3vzt0ubXYVdRkpaIYHjFUZzHoeCmDaqLYySaJbPQuHAtnIhjLbNHrBCpG/4JUvINZDBPxsuM29L2tD/WVG2I9wjUwFWLxJWlDoHrMZBZZGOkx/Gqeu7Mu5SfcMXpcudiDT9efBBOCH53swl5W2Q2UQWRuPxlLh0n1DokP2irq8AKQ1hxAW1s5nkEB2Zi2CWUgia/9k6XJSrRTw6V7q4svB8/XhzMeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ee5ga6A5MkUwXW25nwRod/eoXVkNUm/Ah2pUZ3GswLs=;
 b=MqAfGL9Kdnj6uBgKKbiajdojzwnUSrvodzY9MH2emPXa8Si8xEY9gFzutH1FUvUAeMRdmPaVMk985tiUMwinLV4YzQvUjYpqObQJFEaVyzRy5jvWsEYQFkPBr1ISEVA1/KwBfVZs5f7SYmcbT+jLlUCgWrXhymqDCMx4ulGwYEcUUiLvHT2JUxk70kjcXA46x21bXJjwFbZA+5hNGEuoHOBi5otjKyxoR3+J5iwRp3OErx+LBP7/Yj1nJb2z6niZtidUcYm/rWgVSUOtKtuHfmjheVJjclehTiQMv4ZqawKNrrayJlKP0suzUdEWxx7bDDtQ4tfKfK3oJFPPiHEPqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ee5ga6A5MkUwXW25nwRod/eoXVkNUm/Ah2pUZ3GswLs=;
 b=YvgtSgCp9M9L5Fzl2q3uIKWl7FMzKfYV8Skl38lq7tjQy1dirlEdCQd7d8Gn5hEztJH9UzrcjOoJ1Hc0LMhyAmm+J9+J92Jpg8by3F8P8ELG4AWHhrGZCfpHIe5KZ0kSiDGuC1dkxiEAS+OpG4xyWbfrqwFTaqwP7/FckYxvjB8=
Received: from BY3PR05CA0002.namprd05.prod.outlook.com (2603:10b6:a03:254::7)
 by IA1PR12MB6409.namprd12.prod.outlook.com (2603:10b6:208:38b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Mon, 1 Jun 2026
 15:18:57 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::79) by BY3PR05CA0002.outlook.office365.com
 (2603:10b6:a03:254::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.6 via Frontend Transport; Mon, 1
 Jun 2026 15:18:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 15:18:56 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 10:18:56 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 08:18:56 -0700
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 10:18:55 -0500
Message-ID: <f8cce943-4f7b-04e9-8596-fc652ad22398@amd.com>
Date: Mon, 1 Jun 2026 08:18:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Remove drv_cmd tracing from job free
 callback
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <max.zhen@amd.com>, <sonal.santan@amd.com>
References: <20260529152837.1973405-1-lizhi.hou@amd.com>
 <dd84217b-d0b0-42b0-b822-cb897b6f71a8@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <dd84217b-d0b0-42b0-b822-cb897b6f71a8@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|IA1PR12MB6409:EE_
X-MS-Office365-Filtering-Correlation-Id: 77410f03-8def-4953-9fb8-08debff11980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2KGtDoQJaT9SssNh88U6oEtdKkCrp//ncL6ZkvCYTVKsBhO9IL+lSOE94eK9M4FqjTwiaFYyRcg7esvSPP/EgO1c7ZfZ6TFJqAQOCFWwi9mZbRssKvk+nUuuyzEGX9YEq44YyHqREHhzqtaGlwHqsT8ICZOol19BP7OsQ5ze4Qsdv2LZzrK80dvKlU7WdAmufcCX3xeG1ZmYPOjfVroF2NgyHJx9+jBbrTNFJwW31ljsS6XllyPHOxlyQDLJ5PEEN529I/havCb37LuFRoUGVStb7VHF8bzRpOtW8US/jFCGDFbYT4tdNEWOrlQbUr+H/RUiS3I2TjHWv1bQ2Ca/IqXRGDvZci5+3AunPDMZRVWCmMvNi7stjkKxyuRzbvwRYW02CTpTYpBXmJk5ha2b0QsFIE40Ik46cL4KstmVCdjcgqyQ0PwAwtOZbU+PBrZy3wop3eRXFLNwFtgl6LzRpGr7P1ANuQHw7OzVjOjZkHm8UqxjFoaOE6sJ9CsmLy1c51yk7thtfuyz4ILrvsqbmqlTxxv6Cle50vQGGRthRvpoLXFa93eBTreCoRQBmyZwTola3yejwTGIAAg2HhwZl6bBhvuHAr3ExNcBQWDOsDe9TRAAi8ABeZB3+oOmizUnI0+43CRQLbEK/pI6vzpUk1CVUj3iy35tZoUBAZGNjfqXa1E0MOPOBtyy7eGv5NPipOExT3ndrEo9WubVg6qElEpU9uEBG/YEY5T5Umg/wH4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iXUvUYtccUxEN/bqjBun4Ja0nUz6akV7vvS1vm6jIr2SzVSHA3f8xD2WdRnEHKab7QdGepTOFYE8ovZ9mWyV24dokrQs8LeBZBY953ixYA0QRyY1IbTPc5AtsPWwbdf5xOb/l8PuCMznz9zIK8oxzKkMs4/YLlwJBuQY4jtiT4RfBpifa452IL0Z0y9TE6zmkncnxrZsI/2HaI0uUWYxwC5ExbGCd7VJ9/+fAAWpVfHjeaFYs3ZQZtaDPJF/vOoh/5lYqDaFuYfEfbtawkmSwVUCPr62YgWtr9LgGqkJ85tRO9VZIsd3DfD5HFewbs3pTFSJ8h581gG+lungPywHIIZhwMADYeghIvOTOB/uOdXZGFklR4cIicxHn2KARqi4MuqQ6Ufpcz7B7WJEbfg3nVxdcyWUWcxvxXFMTybuiiPw0HAgMKwRPIw5FgmEdw/0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 15:18:56.7725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77410f03-8def-4953-9fb8-08debff11980
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6409
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


On 5/31/26 07:18, Mario Limonciello wrote:
>
>
> On 5/29/26 17:28, Lizhi Hou wrote:
>> aie2_sched_job_free() accesses job->drv_cmd for tracing purposes. 
>> However,
>> job->drv_cmd is owned by the caller and may already have been freed when
>> the job free callback runs, leading to a potential use-after-free.
>>
>> Remove the job->drv_cmd access from aie2_sched_job_free().
>>
>> Fixes: 8711eb2dde2e ("accel/amdxdna: Improve tracing for job 
>> lifecycle and mailbox RX worker")
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>> ---
>>   drivers/accel/amdxdna/aie2_ctx.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/accel/amdxdna/aie2_ctx.c 
>> b/drivers/accel/amdxdna/aie2_ctx.c
>> index 658a5fb1fda6..2ad343728782 100644
>> --- a/drivers/accel/amdxdna/aie2_ctx.c
>> +++ b/drivers/accel/amdxdna/aie2_ctx.c
>> @@ -437,8 +437,9 @@ static void aie2_sched_job_free(struct 
>> drm_sched_job *sched_job)
>>       struct amdxdna_sched_job *job = drm_job_to_xdna_job(sched_job);
>>       struct amdxdna_hwctx *hwctx = job->hwctx;
>>   +    /* job->drv_cmd could be freed, so use DEFAULT_IO */
>>       trace_xdna_job(sched_job, hwctx->name, "job free",
>> -               job->seq, job->drv_cmd ? job->drv_cmd->opcode : 
>> DEFAULT_IO);
>> +               job->seq, DEFAULT_IO);
>
> Could this still be a race with dov->drv_cmd being valid when the 
> first part of the expression is evaluated (job->drv_cmd) but invalid 
> when job->drv_cmd->opcode is accessed?

When aie2_sched_job_free() is called, the job->drv_cmd could already be 
freed. So it should never access job->drv_cmd at all. The entire 
expression "job->drv_cmd ? job->drv_cmd->opcode :  DEFAULT_IO" is removed.

Lizhi

>
>>       if (!job->job_done)
>>           up(&hwctx->priv->job_sem);
>
