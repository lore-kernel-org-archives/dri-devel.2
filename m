Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C48CCC6B19
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 17:02:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB0C410E3DE;
	Tue, 13 Oct 2026 17:02:36 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012025.outbound.protection.outlook.com [52.101.48.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 158E610E0FE
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 17:02:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0QWSKseyQY7g4uanQz/pJtNi5mjwr9IFUYz3mWzuuHo5wm447+M3R7OiDgFwXrkBgL8T5eS8wTpZ7J48ti9tUHhAJ+EQK3I4OIbfwqBBDJA3xoq5rmuTFSXOr6qyf/tVaWpGITrvW0tcmonPBr4ZM9Hd56mEAEu69y3uR94CZZcN7069j755SAJ01FXk6+ib4miE+kOMuwp01/V8nFotPHrncP/+zeqmTaIYiHa63ZbY9wg+toLhG6NRewtMsgVGLBX/FSbgcmTWgR7/wGHIyaht1bUBtcwKSZHNx6kvwJfjPLW05u6FJEZtwUMgbd6i2+Bs6mM/zgbKaJM+Uw/cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkz1cITzTCDFp5cit+obmNcc3zxZueI6dSoCPkUELcE=;
 b=nBmf/j0AEMIGBDZHBDGEi2qHpRvqUzL51hQ9ZrjmVacCRaDI+EAqkkvM6I59nk+ldvilDseBb5DC4Ve4NEJbVt/YZFF2+jY8q0uy1jYEOptqCHONTteVO7Nz1zY80F7Rqld+d10NruNyF4BXQQV57GM75/antSD5yHiv+Q4rcwSM3cDlUYQP0tTVg5adW1LigOIqAZcEr9UpZDjj2RagdldmBqe0k1NlXNaz57DFfNEJCWpoBgUMnyzblyXr6D3Vz0VItCyNiT6xAFwg6e7xvRn5KTX3Nd/4rtS0EyySFzZT39VLBOzpY5ySdLNPe2BzElaS0We4wgAM+xnPlW2rMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=amd.com; 
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkz1cITzTCDFp5cit+obmNcc3zxZueI6dSoCPkUELcE=;
 b=d6BrB2B0dZAS9v58/DlYqyJfi0iVbsgwoKeIcRFywx0ulYtXvFGjSiwl+N6gb/yzLFPdn6khCoPArShNo5PIc4reJkoclh+DfO5n96CYaCkMukesstAhqItHScUNtBhAWGVReiHWMuWAdPCS4Xtc0oghSGRBCXrXxk3Tzr2M9Z8=
Received: from BL1PR13CA0348.namprd13.prod.outlook.com (2603:10b6:208:2c6::23)
 by CH1PR12MB9718.namprd12.prod.outlook.com (2603:10b6:610:2b2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 17:02:26 +0000
Received: from MN1PEPF000793FE.namprd05.prod.outlook.com
 (2603:10b6:208:2c6:cafe::92) by BL1PR13CA0348.outlook.office365.com
 (2603:10b6:208:2c6::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.18 via Frontend Transport; Tue,
 13 Oct 2026 17:02:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=temperror
 (sender IP is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF000793FE.mail.protection.outlook.com (10.167.249.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 17:02:26 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 12:02:20 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 12:02:20 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 12:02:19 -0500
Message-ID: <9a73a766-55f6-386f-0ec2-2ca3f4a987db@amd.com>
Date: Tue, 13 Oct 2026 10:02:24 -0700
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
X-MS-TrafficTypeDiagnostic: MN1PEPF000793FE:EE_|CH1PR12MB9718:EE_
X-MS-Office365-Filtering-Correlation-Id: 70c0b82e-ac05-4ba5-0077-08df294bc1e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|261009223027099003|11063799006|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 9+Tck8HcTdL649ghbfVs42BZ2GUN6z07STlNyIuwGg4qjWM7XU43BTay+1AZxxpt3WJfSzAv1QdNYxQivmyzWgWoDUenZwM//iFZS98s7d5WogmMcyuxgLXTBKNZOOrOXXdgT/PF+wSQC4q06Mhk7GbdyNArmpmWWh1bbSqbnyHQKz0XhqKWyAFfsQIfqaBguOQGn0LY0l5WcSRLAszyLp/BJs1/GqWVAFRcAEkk0pFmYg9xv5dm+UAPrKEe4HNn4Bv/6DfyZD2+c+uw1DVPA5EoYR13yOUzEWNgM6wMiZ/5O689l3WoZuaJQvUJabZw41pgqPwYT8oDm/Riz+Rg9y8xVONja1KYMrI9W2JA7v2vbkIzMYfIC7sBnvEZvyXd05YFtQg75TwdT58bxbVsQ4EQR8JhPXLYkR99kqLHPBWl6PQI+d8uSvfnFxVH55uKWf8k7+EoJcP0jp/gR3ZSLqRsHi9KTLRavMcoD0RA2s3m27aZr9IkaLNCTBiBYHoBuCH5Cn3aR/N9ig2CpS88VrVMTXzltFGIsQrbKskucDelN/RJe+Cex+SXZelWWk4/ruQXPbGzHc9dRh7ADmwwA54x7wO5dZeq7MxfK40cyRVXy8hBF++ch9C3VD+OJtWJnpdntnMuH/ITH+4pDMa8/crLkcnQYsuIRq4/NhOvTAKXhjgyyARk5afZ0QeAEiWhrnMY+rz0HU4xIztzywZrRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(261009223027099003)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ie10xbys1pH9TmOPqi8uIQ7gM+V9psIgx6Tx6R3Tzf9VbY3rs8mm3XCqRAeRzf/5pyeWZtwXJfwIFutBgcAyGjy2LgRjRLk6V8+ApgR3JD+6e0Zx7ZJF8f/hrKgE+Iyczpz6q4MaRn8Hr05S0F9A16tAyAu4avvBeHiAwVahQTRF0umrhu1o69RYkgXgC+/cAd4JCHT+swe6iWTt78MoVWDcMxB8xChBPfqgATony+LWVf2T3CtLPZkhpqylVUf3xO1Y9XSsRRpGLt2vtziuRih00hhvg+j6qUHM2dtV7bx9Fcyexg2AsyztXDxxlyM5I9Lk6c6rKeP6Ta8KpGWhr9G+6+UMdqq9xj16eHNnJ+uQWTOp7I1VrMAVl0fly0hiDrl9lVoGPmOaPLz0CuV7WZmEfA3DyXDsKXPgh6WeNLewJYWGx2hFYCcAjJ72Ng4x
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 17:02:26.1561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c0b82e-ac05-4ba5-0077-08df294bc1e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF000793FE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9718
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

It should be "drm-engine-npu" key here. I will change it when I merge.

Lizhi

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
>   };
>   
>   #define amdxdna_for_each_hwctx(client, hwctx_id, entry)		\
