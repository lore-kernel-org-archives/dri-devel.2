Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2899CC6B19
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 16:44:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2006310E0EA;
	Tue, 13 Oct 2026 16:44:51 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013027.outbound.protection.outlook.com
 [40.93.196.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 894C410E0EA
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 16:44:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUMx04NLCJLpVuKRe60K/rj7t9pXn/ZV+RVDU+cPb7bAj4WK91Xb77dbx59TT+ctnAIi8OspMY2tHomONWBYjJ7/0bzorAybhKKemUifCqNC6duatjIlvZVYTPqDyhGLXp1JmFr8TSwF2PIh5NhN8Its0Qyox7hbIdRIMRg0xIJE8FCTt6EJx9LHXJwZzielqQXso04txJrkWYAQT/iRG6Zt0GimSWc/Iz6coj7eU314Opv0BA2h4Sgl8OIRkTFtuMZifuv2ZNrfXa7KyfEY4b61HoQeVFggiC0Fj1Td7koeB/0DGVe9y8sDihrgSDbu8RYj4+LC2BhIbsAxwCwBEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdhSWgUjKYK7U0SNRLV4AneqffJmZmtZmIFEh8PTroM=;
 b=yO18+JUDHuFqmU+GqOtz7hJ5uKouCIJc4OR3QBduSGi6qlItQEyOrGZy4MYiSM/zrM2z2oOfBM9sVUT1kFPNAvOQvOieE5bxa/NQe82L24nyJ3s7HrMzeh+j1gRTdcYxmdgmjD1aRovej+IW504GYAwfHZAb7cYOa+G9qxjbGm+MSkQ16Smz6Xc77Uvovo43TMsT0Ctb6L8lZ3n03lelYVAbkVJ1XHQcD4YbxvVz/ym40UEdApCZwW7y72uWEYliBSNOEpNwUN9kYQ3xZXw9V7c5pSjw/PW5p8KwJu3Ym5lWclWxu//bSjJ14wwkHQXpbbd7ui9U+Z42k561FJ8Gyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdhSWgUjKYK7U0SNRLV4AneqffJmZmtZmIFEh8PTroM=;
 b=aPowO1pFsLkisZkb+3EnLlL0sj2UE8rOq40Ri+9+8P2o8y778SE+rqThidTI+gOlbFGA8He/aJv+5stnPfxn/tEZWQ+JhuvfugQg7SmtO+b0CYcpxmyQqcjtmRSstLXEg0HI8e8rPrw8N4cWybu08L0tWYIPkz+RyQzAVsIa2xY=
Received: from CP4P284CA0006.BRAP284.PROD.OUTLOOK.COM (2603:10d6:103:128::6)
 by DM3PR12MB9435.namprd12.prod.outlook.com (2603:10b6:0:40::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.15; Tue, 13 Oct 2026 16:44:38 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10d6:103:128:cafe::1c) by CP4P284CA0006.outlook.office365.com
 (2603:10d6:103:128::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 16:44:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 16:44:34 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 11:44:27 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 11:44:27 -0500
Message-ID: <fe43a826-968b-b739-0b6f-4fdca3e4f5e5@amd.com>
Date: Tue, 13 Oct 2026 09:44:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Expose NPU device busy time via DRM
 fdinfo
Content-Language: en-US
To: Max Zhen <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20261012180808.2548697-1-max.zhen@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20261012180808.2548697-1-max.zhen@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|DM3PR12MB9435:EE_
X-MS-Office365-Filtering-Correlation-Id: 306222b1-bd90-4c8c-a784-08df2949431d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|6133799003|22082099003|10067099003|18002099003|3023799007|11063799006|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: ECbWSjjJz9akJT18fVc9NwDkMLStC7h/G3IGX1ynB6VnqhNYLBKIP0+WTXoHuqJnrehn40wsIHe//mBPG6Q5hD1zR1Rcj4NeRoT/BX3SXAOPm5WFY69O9KapjmitPxGl+hEoUlkf4D9xnexuBT770V2dFFnEI/GRoWJG1Hy+aWkzKRaD+MDCHptkVmCfNJqewiHCsli7Sm5k0jmQeD1zhJzDyxQYSHQw0oPK2bjPB4Jz/tMXPEIc0LFN+VnPYaNzEO1rW8wICFaInHFw60Y8BY5oqyib+hG+6H2R701FWdcz6f+p3BZ4kPcpF32J16hEbvNMMEpdJ81QfA74n3JHb9jIBPDbW3VwKN+g3wdHCXu624HsWDewW5AS/k/v81S2J9xYIWFtGsP52EsvnR62tzSF0VPzhBH5tqY1avS718/Zl1HMaES1FrQ1CDm5rVMpp5gVeZXPdQ/S2I8GeCvYNL1PGDU44zBN38bw/EfBfqkGjhe/s62zfqCXUCbR+k4TCo6fVjOqR9kBvV9/hgJt62WtsBfAAxxFRogR9bjLwqptncmZ9x56MgeznNnfPfRAbrtKyW0PEk7FXnEMjFfysr3LTI3K+1q3RXyp0jRjIdF607OYGsz6QP4gFSmvjjHIJOpOpt1yOhesR13TV5g55YPmW/tfAOA8Yl854jYrRa6WpmzwNitRumvbkG5FYcxD0NOFjzr1hnNbub52BZd9qA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(6133799003)(22082099003)(10067099003)(18002099003)(3023799007)(11063799006)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SPjmS8lXo55sXsKha+/f9SStOlo0b1DBvi7LfzGjoRmpHog048P9baMu6acNbHOcdYoMB1FQqHm8QFCuaFF36tJNkZfGP0aHmh6FtJcLd0Nlf4D8D1k7HQ0y9T+v7fcvFDpeOdrEXI0jTRc+Kd5yGEgbbKYvYR57hW3U0kpXN/Zh5z6pSY2IIGz5H9DBfiW87AO9UEkZQ42Z5RD2HjbeeyCmnI7S7NaXPvvZwFYLNCpKOw5RLSRVLr9Lq0+3g2g16pEngX6zkdThvEBX7+UKiqJ4rHAW1yTbCJZnKHOKvpDhUpqJ0o7SwkVI3WqjH79d5mpGy6CfKPd8baV9/Pg3LYxrstwiNoKiW1ZQ61NMVJINuCVvrWkvwc7/iegtFvNtRjPuwQGzDB/28T4YDjUY3IUJnTgdVSyyrds3f/Is7fCWKIqNySSNoaMzvdk1LD3z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 16:44:34.4845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 306222b1-bd90-4c8c-a784-08df2949431d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9435
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


On 10/12/26 11:08, Max Zhen wrote:
> Expose NPU device engine busy time through DRM fdinfo to enable
> standardized userspace monitoring and profiling.
>
> Add support for reporting per-engine busy time in nanoseconds
> via fdinfo using the "drm-engine-<driver-name>" key. The value
> reflects the accumulated NPU device execution time for a given
> process, allowing userspace tools to observe NPU device
> utilization without driver-specific ioctls.
>
> Signed-off-by: Max Zhen <max.zhen@amd.com>
> ---
>   Documentation/accel/amdxdna/amdnpu.rst  |  1 +
>   drivers/accel/amdxdna/aie.c             | 39 +++++++++++++++++++++++++
>   drivers/accel/amdxdna/aie.h             |  4 +++
>   drivers/accel/amdxdna/aie2_ctx.c        |  6 ++++
>   drivers/accel/amdxdna/amdxdna_pci_drv.c |  6 ++++
>   drivers/accel/amdxdna/amdxdna_pci_drv.h |  9 ++++++
>   6 files changed, 65 insertions(+)
>
> diff --git a/Documentation/accel/amdxdna/amdnpu.rst b/Documentation/accel/amdxdna/amdnpu.rst
> index 064973bf4893..d72af1b51ccf 100644
> --- a/Documentation/accel/amdxdna/amdnpu.rst
> +++ b/Documentation/accel/amdxdna/amdnpu.rst
> @@ -289,6 +289,7 @@ Example of the output showing the implemented key value pairs:
>           drm-driver:	amdxdna_accel_driver
>           drm-client-id:	3219
>           drm-pdev:	0000:c5:00.1
> +        drm-engine-npu: 14003870 ns
>           amdxdna_accel_driver-heap-alloc:	60 KiB
>           amdxdna_accel_driver-internal-alloc:	67588 KiB
>           amdxdna_accel_driver-external-alloc:	0
> diff --git a/drivers/accel/amdxdna/aie.c b/drivers/accel/amdxdna/aie.c
> index dd6f36f222c7..bf8eb66baab8 100644
> --- a/drivers/accel/amdxdna/aie.c
> +++ b/drivers/accel/amdxdna/aie.c
> @@ -118,6 +118,45 @@ void amdxdna_vbnv_init(struct amdxdna_dev *xdna)
>   	amdxdna_update_vbnv(xdna, info->rev_vbnv_tbl, rev);
>   }
>   
> +void amdxdna_io_stats_job_start(struct amdxdna_client *client)
> +{
> +	int depth;
> +
> +	guard(spinlock)(&client->io_stats.lock);
> +
> +	depth = client->io_stats.job_depth++;
> +	if (!depth)
> +		client->io_stats.start_time = ktime_get_ns();
> +}
> +
> +void amdxdna_io_stats_job_done(struct amdxdna_client *client)
> +{
> +	u64 busy_ns;
> +	int depth;
> +
> +	guard(spinlock)(&client->io_stats.lock);
> +
> +	depth = --client->io_stats.job_depth;
> +	if (!depth) {
> +		busy_ns = ktime_get_ns() - client->io_stats.start_time;
> +		client->io_stats.start_time = 0;
> +		client->io_stats.busy_time += busy_ns;
> +	}
> +}
> +
> +u64 amdxdna_io_stats_busy_time_ns(struct amdxdna_client *client)
> +{
> +	u64 busy_ns;
> +
> +	guard(spinlock)(&client->io_stats.lock);
> +
> +	busy_ns = client->io_stats.busy_time;
> +	if (client->io_stats.job_depth)
> +		busy_ns += ktime_get_ns() - client->io_stats.start_time;
> +
> +	return busy_ns;
> +}
> +
>   int amdxdna_get_metadata(struct aie_device *aie,
>   			 struct amdxdna_client *client,
>   			 struct amdxdna_drm_get_info *args)
> diff --git a/drivers/accel/amdxdna/aie.h b/drivers/accel/amdxdna/aie.h
> index 0483d582b7f8..1fc5ddfe696a 100644
> --- a/drivers/accel/amdxdna/aie.h
> +++ b/drivers/accel/amdxdna/aie.h
> @@ -117,4 +117,8 @@ void aie_smu_fini(struct smu_device *smu);
>   int aie_smu_set_clocks(struct smu_device *smu, u32 *npuclk, u32 *hclk);
>   int aie_smu_set_dpm(struct smu_device *smu, u32 dpm_level);
>   
> +void amdxdna_io_stats_job_start(struct amdxdna_client *client);
> +void amdxdna_io_stats_job_done(struct amdxdna_client *client);
> +u64 amdxdna_io_stats_busy_time_ns(struct amdxdna_client *client);
> +
>   #endif /* _AIE_H_ */
> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
> index d927c8c9d557..9c6b7353cbe9 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -290,6 +290,7 @@ aie2_sched_resp_handler(void *handle, void __iomem *data, size_t size)
>   	int ret = 0;
>   	u32 status;
>   
> +	amdxdna_io_stats_job_done(job->hwctx->client);
>   	cmd_abo = job->cmd_bo;
>   
>   	if (unlikely(job->job_timeout)) {
> @@ -322,6 +323,8 @@ aie2_sched_drvcmd_resp_handler(void *handle, void __iomem *data, size_t size)
>   	struct amdxdna_sched_job *job = handle;
>   	int ret = 0;
>   
> +	amdxdna_io_stats_job_done(job->hwctx->client);
> +
>   	if (unlikely(!data || size != sizeof(u32))) {
>   		job->drv_cmd->result = U32_MAX;
>   		ret = -EINVAL;
> @@ -344,6 +347,7 @@ aie2_sched_cmdlist_resp_handler(void *handle, void __iomem *data, size_t size)
>   	u32 cmd_status;
>   	int ret = 0;
>   
> +	amdxdna_io_stats_job_done(job->hwctx->client);
>   	cmd_abo = job->cmd_bo;
>   
>   	if (unlikely(job->job_timeout)) {
> @@ -405,6 +409,7 @@ aie2_sched_job_run(struct drm_sched_job *sched_job)
>   	kref_get(&job->refcnt);
>   	fence = dma_fence_get(job->fence);
>   
> +	amdxdna_io_stats_job_start(job->hwctx->client);
>   	if (job->drv_cmd) {
>   		switch (job->drv_cmd->opcode) {
>   		case SYNC_DEBUG_BO:
> @@ -432,6 +437,7 @@ aie2_sched_job_run(struct drm_sched_job *sched_job)
>   
>   out:
>   	if (ret) {
> +		amdxdna_io_stats_job_done(job->hwctx->client);
>   		dma_fence_put(job->fence);
>   		aie2_job_put(job);
>   		mmput(job->mm);
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> index bb339e641416..67a02d6b7f97 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> @@ -14,6 +14,7 @@
>   #include <linux/iommu.h>
>   #include <linux/pci.h>
>   
> +#include "aie.h"
>   #include "amdxdna_cbuf.h"
>   #include "amdxdna_ctx.h"
>   #include "amdxdna_debugfs.h"
> @@ -151,6 +152,8 @@ static int amdxdna_drm_open(struct drm_device *ddev, struct drm_file *filp)
>   	filp->driver_priv = client;
>   	client->filp = filp;
>   
> +	spin_lock_init(&client->io_stats.lock);
> +
>   	XDNA_DBG(xdna, "pid %d opened", client->pid);
>   	return 0;
>   
> @@ -287,6 +290,9 @@ static void amdxdna_show_fdinfo(struct drm_printer *p, struct drm_file *filp)
>   	size_t heap_usage, external_usage, internal_usage;
>   	char *drv_name = filp->minor->dev->driver->name;
>   
> +	drm_printf(p, "drm-engine-npu:\t%llu ns\n",
> +		   amdxdna_io_stats_busy_time_ns(client));
> +
>   	mutex_lock(&client->mm_lock);
>   
>   	heap_usage = client->heap_usage;
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
> index a997d27a504d..510356a31532 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
> @@ -143,6 +143,13 @@ struct amdxdna_device_id {
>   	const struct amdxdna_dev_info *dev_info;
>   };
>   
> +struct amdxdna_io_stats {
> +	spinlock_t			lock; /* protect io stats */
> +	int				job_depth;
> +	u64				start_time;
> +	u64				busy_time;
> +};
> +
>   /*
>    * struct amdxdna_client - amdxdna client
>    * A per fd data structure for managing context and other user process stuffs.
> @@ -169,6 +176,8 @@ struct amdxdna_client {
>   	size_t				heap_usage;
>   	size_t				total_bo_usage;
>   	size_t				total_int_bo_usage;
> +
> +	struct amdxdna_io_stats		io_stats;
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>   };
>   
>   #define amdxdna_for_each_hwctx(client, hwctx_id, entry)		\
