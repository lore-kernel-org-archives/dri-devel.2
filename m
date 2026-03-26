Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F79110A88E0
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 16:11:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C538810EB33;
	Thu, 26 Mar 2026 16:11:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3A7V/5my";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 931DC10EB33
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 16:11:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jr8eUck0cQE+qPiCfzND33q7AmdFqwWcqLn/dCHmAMInKTiPglONshgfwmNsMaCmAZmcraXQhlVXbtrQvzQiUL5wOAvgcZtcRzYHFuO/jPIGrfX+XD656EpMG7ZOKhSeBk/RhkxIEK6guvDo+2gmsGvfLc/coA0oJBknlDw4jWGgppO3CvrSnehMU/W+NwUBEJi/1tLidaq4fdLH3ApxJntFJdueT0231YsKqkeZdKgk9BPZ438BhW45r4iAyX9gfBdloS71wgHvF297mjfjqmFPfqNqJFJJ/pqKZYyoajvipF3utW6jiSq1+ZPCfO4aW7du3miIVpAgSEeAA/If7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtrrafyslPgSkT82bneUip/s7FU+6zVJnZIUkGry+4U=;
 b=L4dHgvw6ohL6yHsVsx0OEAULEHQ2Zt5On+iuoMn9lpQrPn4GitnrGjtOw1OJlJq89z/1aA7d8riJIfSwFTOrYKjGTWEB86Oe7+XibkL+UNflNPsGH24uqSwpoLxUDRgZ0iuvJZ/x5hf7IjjFakhlvFF0+tIivjPsOL2w3t8grEapYUAExfESJoAE7FMzqQ1j9DjvcDriOUqZtGThYTZmaW0jzU1sjbGwI5D3P8VXUGBet8iMLpSLnWuQf9OazBAed8uqLIv+TYFa3CqZ1xfTWdYCyG4yCZS9H3fi72SIWj75ctBKiDQ5iOvjPPYYIs2Lcpx+eCLwEIfCKjY1LznDfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtrrafyslPgSkT82bneUip/s7FU+6zVJnZIUkGry+4U=;
 b=3A7V/5myJn1evw2557Jf33dC/BEDQmC7xnriiO7HyRmDpPy2v4rY/Pen0cTNSF89iP69exGpVEG/wqPSSDxjB899o7Mlj9DbpgBQWbJadvXV76IspIcQDPFu8DMTrAL57y+QWGtQ2vG/xwRZAasUQa8gunfafEugJmoYu2cBmRc=
Received: from PH8PR02CA0047.namprd02.prod.outlook.com (2603:10b6:510:2da::8)
 by LV5PR12MB9827.namprd12.prod.outlook.com (2603:10b6:408:305::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 16:11:43 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:510:2da:cafe::25) by PH8PR02CA0047.outlook.office365.com
 (2603:10b6:510:2da::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Thu,
 26 Mar 2026 16:11:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 16:11:42 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 11:11:41 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 26 Mar 2026 11:11:40 -0500
Message-ID: <6b0c8417-91a2-01d6-1298-18800a40b581@amd.com>
Date: Thu, 26 Mar 2026 09:11:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Fix leak when pinning ubuf pages
Content-Language: en-US
To: Mario Limonciello <superm1@kernel.org>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <maciej.falkowski@linux.intel.com>
CC: Max Zhen <max.zhen@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>
References: <20260326010642.2596525-1-lizhi.hou@amd.com>
 <b1333a9f-1034-4e3d-a1bd-b6e1348a9f87@kernel.org>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <b1333a9f-1034-4e3d-a1bd-b6e1348a9f87@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|LV5PR12MB9827:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c3b5b8d-ad6b-417a-686d-08de8b525e87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: fr1O1NT2dXuy/FDsoa7XD8aW2hkhukUr6QCerO0zd0UOyePnw4jgCfPUK2oG2hM0OJOpRPl6sq2rFM4jjrPfiQ8HRHNZ2xgnThcgyqjR5Nk55Ew/cwDGM/mygDTNXU9WCtOYYlJAQaSMzOESl1KFSw7vtXdqxfdiGhqL1+A2rKrgBl9dvc6cHPleJt7kd9GDre0y3QLs1TJU6tIAY9crEV4PIshvkaJIsHmmRKTCPB1uUIfPclTpr3Qd3z8HNJ+mxNWnSoHBeuMXft3puF4kbJI9NRLB30ZFQurOeQqBrsjlcsWJ4pIp5/Dp++NGH4SRUWNyO7VSeKMXkXm5jLrpmLGYFJueQ/n6NWqtqL+vxbjfZ3aAFgTTUuhYP/BG6E+dRsp3RiE3NlMFuBPtXX/uRCD3avsMQfeV1+vZCC5gkloY2K+0unf1dWh2GQbEc9Y7gtf5I3gWXQNd9qv/moUlLFyUnCjlVavRtXD3TP/+j4P2Cxv4l2pBi6l+sH1AHqgJi8UAoEx1scfZTOUYU7YMNQYPttPvZAnj53BxvozFQv0qTVKc0Dm/biaABBKoO0FRRL0vdSCEhA2icj11czzNC4bcxp48qJnEgUOQU0lal/LHhf6aZWQYjM0SycMYXzmjdlnOs3uXkgnpwPSTYXVD9407+IKwAOwOIsz4I72CYyJIAmRmOPQDcRZItyfpc3UzeMR5dyBayavyk0P2AEBEY2VbG6PMGigTKW2BrptbypWnGqqXWUvOCF0hAmmLXiWeT6R7bzcz0MLddcQgxYiYhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jnu74BGI46unkAha/8jenPzvjwXz6yF/Y+/VWbqDmrcjE+T8B4FArs6IeJQXuokDoIrRwDSFWeV4rJXCi5mpC+flzDpbwTdpCoESr0G58BM7y04KHFMcRwADJswIoNTjom6nZOzlFVAYllCiYoyfNnk4Gbz0lWjrI2i6MY1aoS53QvKd3bWRSua5CZfr1qla9XbZefPHB/vmeG1hHN7F1i4SudQ1BeMvhG4lUl4sqHpKJnl6Tp1TQ0NYr/LIoK6di3yfq972E0l8gMujV7kgpZNZQwq1q21cXYXd55lhfzWwe7EgfJqCkN+VkcFd8P4RO8OcBRhRj/Ij44ykzso0Z1covVQVoaitnMD88wYa22IdqCoh+bIhqhcGOt78TXogrukNqoKVlYGc0Z4lG9oDK3UQ/KWwUbR3xdG7S1ca5VJ1sImZ3OujrXi7OvKb9GH7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 16:11:42.1818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3b5b8d-ad6b-417a-686d-08de8b525e87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9827
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

On 3/25/26 19:31, Mario Limonciello wrote:
>
>
> On 3/25/26 20:06, Lizhi Hou wrote:
>> From: Max Zhen <max.zhen@amd.com>
>>
>> When pin_user_pages_fast() returns fewer pages than requested, the pages
>> that were successfully pinned are not released, leading to a leak.
>>
>> Fix this by unpinning any partially pinned pages before returning 
>> failure.
>>
>> Fixes: bd72d4acda10 ("accel/amdxdna: Support user space allocated 
>> buffer")
>> Signed-off-by: Max Zhen <max.zhen@amd.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> ---
>>   drivers/accel/amdxdna/amdxdna_ubuf.c | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c 
>> b/drivers/accel/amdxdna/amdxdna_ubuf.c
>> index fb999aa25318..4c0647057759 100644
>> --- a/drivers/accel/amdxdna/amdxdna_ubuf.c
>> +++ b/drivers/accel/amdxdna/amdxdna_ubuf.c
>> @@ -196,13 +196,17 @@ struct dma_buf *amdxdna_get_ubuf(struct 
>> drm_device *dev,
>>           ret = pin_user_pages_fast(va_ent[i].vaddr, npages,
>>                         FOLL_WRITE | FOLL_LONGTERM,
>>                         &ubuf->pages[start]);
>> -        if (ret < 0 || ret != npages) {
>> -            ret = -ENOMEM;
>> +        if (ret >= 0) {
>> +            start += ret;
>> +            if (ret != npages) {
>> +                XDNA_ERR(xdna, "Partially pinned pages %d/%u", ret, 
>> npages);
>> +                ret = -ENOMEM;
>> +                goto destroy_pages;
>> +            }
>> +        } else {
>>               XDNA_ERR(xdna, "Failed to pin pages ret %d", ret);
>>               goto destroy_pages;
>>           }
>> -
>> -        start += ret;
>>       }
>>         exp_info.ops = &amdxdna_ubuf_dmabuf_ops;
>
