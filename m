Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C53ACCA46C
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 17:04:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96AF610E047;
	Fri, 16 Oct 2026 17:04:23 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013029.outbound.protection.outlook.com
 [40.107.201.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10FDD10E151
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 17:04:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7TMz71zGJW1OfOSIQcAwCKi6g6azJmTXoeTFhjvPCpVlTGt8kPA4mlbyWdB/D6riaDPVGtG7kucxxIgUPiqw67+x+WafuE/YO58oQJSmW1zXU5mZxKu0cBfNeOTq1AZpnhOOnf8RMipTDLiNY+hZgohJqqfOWo7UOL4IkuDXOm2LtvUsFG2rLWNH6EOZm1wHqQMk5Y3MR/mKljSV+1Swh3BOunzp9v+kGeAIXITwAs8LiQNbtvc1tpSqfubmgqlK4554X7Y6lLpmAXw5fZ2PcnAUrgCWV8H5+hwcgk8yvvhye744tGSJblWONyiKpw0URt4tpY/U3cx47t8S0utZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=maKfvq/cfkLMXlp89MKwtMMap6cctVSestuzM8wOnVA=;
 b=glj0BLeX+T7ICp5qD88J9KzmvJ5/hJAYHv/evp7/xpyBDVogNJjGLn8WBLueZtP2SARel2u9sj+xUrd0N1j4VACXhUSd+qqvZo/lrUtDH/l9Z8ev3w4NyM4rjNFe6RKthCPcYxz+My8iuQ4+1NIT85nG/lxKqTFfWpcqTIedqPoOGo0sYJm4b6gEnsFYx64sMn9hyYiXH5MEVYUFvTO4fSOxJd2QCsRsZuXVhzEENCC6hHOzRv5m2f3ovpowsQ6hW9mdH/CfIVjkxMUCrHiyyMjpWIBzit/cVqTPghuNHfAyI5RO3mHxkytVz4HouCZx5zwlLFlaRdsT9sKnaqIjmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maKfvq/cfkLMXlp89MKwtMMap6cctVSestuzM8wOnVA=;
 b=qtqrJPSAq8yE2ZR1D8LpU8d6SWfEgJsg1nxSQV40adzRs3zbkauyQWL01KMIDysJ12MSS1EpX5TvLLhwmd4nbcwNqNmUfusYjmzrEV/AaSfBtBApMJtWOt4sAi+ZFwv8t6G3SnSQLJyFI523ONGF5V0XDwegBe9qy1pDoaPlJ3g=
Received: from MW4PR03CA0055.namprd03.prod.outlook.com (2603:10b6:303:8e::30)
 by CH3PR12MB8235.namprd12.prod.outlook.com (2603:10b6:610:120::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 17:04:10 +0000
Received: from SJ1PEPF000037AB.namprd03.prod.outlook.com
 (2603:10b6:303:8e:cafe::95) by MW4PR03CA0055.outlook.office365.com
 (2603:10b6:303:8e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 17:04:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037AB.mail.protection.outlook.com (10.167.244.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 17:04:10 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 12:04:03 -0500
Received: from [172.19.68.100] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 16 Oct 2026 12:04:02 -0500
Message-ID: <db7515cc-8549-4ce2-9c83-9d20e6776150@amd.com>
Date: Fri, 16 Oct 2026 10:04:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: wait uninterruptibly for jobs in the
 HMM invalidate callback
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>,
 <yidong.zhang@amd.com>
CC: Matthew Brost <matthew.brost@intel.com>
References: <20261015183248.3414119-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Max Zhen <max.zhen@amd.com>
In-Reply-To: <20261015183248.3414119-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AB:EE_|CH3PR12MB8235:EE_
X-MS-Office365-Filtering-Correlation-Id: 26ddcb89-4301-475e-63b1-08df2ba77f37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: CRM94/Va28JK5h0bzNEkE3vuWHE2ZHTCF9b/T4ClhFOC9e3EN07iiPClG95yPPdWmyYlxGn7+4Gbqo84C0m4icqiOpwcCx8WwI5TCoX00/nmROfoLl0J+axLmAl2r69WRLwSi5ye2Q1YJvPT8Beh9skE/CKujqqk/et6PHLnudLsHpMaFxhseonOija1j0bbDxpc7MA6qN7+EStP4lF7/T9/4NpONIde+kggCBV4ENGXC/RRlCOt2YHNb3WHmx290y0bw6dS2Ltc6pRBI2fs8w8fjTsasMzha8crefP2H5auBByrtHKIbMvLWl/sojjFg1U7dNk+UublkgAid4m4ic24iIrOQLVQmgSLvwMwU7kruAbuvqly67rldvDiD+j8siBgpmpxuvs9dH4g4NdOJ3YmPHw3JgotH5D2R065Jrm9zriVAZ7IMXr+Y0XgdhgB35VQYi0tYVC4e7nYtG20sTVx2JG6dNROGSNU/5uTTT1JWEDSHtUlqoyDk9VVq+6/jQJaTgKgN/t9YsQ9ftIm8X4YqQ8xQGJokcHXMHvAmtCX8NzIBZGZ0k5Lo0O3DiRbqEvmZ4zqZLnZpPtpRNvTASnMXrKNuC5HyF7iovXDwR+pDztTbbLbkHjADfFG97LdWvbPBV10BoePViv15vhdC2lDGtsIqt5g2tvP1fHTS6qebphZYO0eCGmo6yJRD9W9wuvWzfPJ5Vvn1/6frKs0aA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: O9/RAaQI6qoxFkzCaaVYU9AlHEJ0zuvOlQe+tAU/4jdhtqNvyGP+1Ug3M65W+lGRA4157ft2tiRTKX9qjxknEB049Qn8rHZLMWslSqp2w2AruigrMHk5CK05ZWaxokJzJ77RsIIrb0kVYaaP1J64NAym/VVRwbdFrWjjxxHvZHaBpTZo07IK5qpGGcvjbDzgXEpSkNINhl3L9gmPDAe0XJG4YTeo+cnrXZy099U9oEH8h84zak2aI21kkmi/MZ4WOjLMVD99U9K3PEFFOK279Ygty6ADvuhldK2FB3RQdAMd2oZ6TTpxyVbHvx1E1LQv7L4LPVF343kBkgWmO9ZpMHqcuHoY4jB2X9AO71P3gwgT7k9qnnLUibzCen0EHmmhklp4lAnMT+YYHAUwNRq7sK/T9LoQdhgfxZYIeM0vFBI6CGXt4a/Me5Kjb42fa3gO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 17:04:10.2751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ddcb89-4301-475e-63b1-08df2ba77f37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8235
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



On 10/15/2026 Thu 11:32, Lizhi Hou wrote:
> From: Matthew Brost <matthew.brost@intel.com>
> 
> aie2_hmm_invalidate() waits for the jobs using a BO before the CPU pages
> behind it are released, but does so interruptibly. When the task
> triggering the invalidation has a signal pending the wait returns
> -ERESTARTSYS immediately, the notifier completes and the pages can be
> freed or migrated while the device is still accessing them through the
> PASID.
> 
> An MMU notifier cannot fail a blockable invalidation, so wait
> uninterruptibly. With MAX_SCHEDULE_TIMEOUT an uninterruptible wait
> cannot time out either, so drop the now dead error handling.
> 
> Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
> Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Max Zhen <max.zhen@amd.com>
> ---
>   drivers/accel/amdxdna/aie2_ctx.c | 16 ++++++----------
>   1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
> index 9c6b7353cbe9..84ab8a55b7ab 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -1286,16 +1286,12 @@ int aie2_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job,
>   void aie2_hmm_invalidate(struct amdxdna_gem_obj *abo,
>   			 unsigned long cur_seq)
>   {
> -	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
> -	struct drm_gem_object *gobj = to_gobj(abo);
> -	long ret;
> -
> -	ret = dma_resv_wait_timeout(gobj->resv, DMA_RESV_USAGE_BOOKKEEP,
> -				    true, MAX_SCHEDULE_TIMEOUT);
> -	if (!ret)
> -		XDNA_ERR(xdna, "Failed to wait for bo, ret %ld", ret);
> -	else if (ret == -ERESTARTSYS)
> -		XDNA_DBG(xdna, "Wait for bo interrupted by signal");
> +	/*
> +	 * The pages must not be released while the device may still access
> +	 * them, so this wait must be neither interruptible nor time limited.
> +	 */
> +	dma_resv_wait_timeout(to_gobj(abo)->resv, DMA_RESV_USAGE_BOOKKEEP,
> +			      false, MAX_SCHEDULE_TIMEOUT);
>   }
>   
>   int aie2_hwctx_heap_expand(struct amdxdna_hwctx *hwctx,

