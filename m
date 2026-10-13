Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDDECC6B12
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 18:45:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D10310E9AE;
	Tue, 13 Oct 2026 18:45:50 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013063.outbound.protection.outlook.com
 [40.107.201.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C40210E9AE
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 18:45:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IumqyPmXBHWiyGGBA9LGfxwVlwzmVLdeyWIid/WMiKzJQ6DNzr9L028sUOSJYJvZWiBV4qDVG+xuPXEbP2eLFdu6MIZrhNuBLsqh9+FAdZRFg1V3vn9s/3VcyAZwRj9t2Xkq5oZX2hXPEAW7Aah6oZeAMq3HnzxsMNHOKiXDyI3ZgxKqqCkWyFgCjFOqMVNDZD4gDvTa7glBrh7LqzAgiajR2QZKu10pp13Ehm8MnONkx31y4qKbu4rTdbOCq1w2HSNsUaI7vLEs51DGT+DbSrcDj1N5g8ZUGAXomLeMlVhZW+rdufrQAjn3oQMVYhO/XYiD8yx9/tIJBLSE1eM7RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPxxAFySWsQ4woajGa1KggZ2hDc7+jP0BOcpnFcPjvc=;
 b=GmeqN2yqPPS4o0Ti191m9zhIpm9SbBj4TzyCbqL9I9w8JenJ8FAH+Ig/vsO4y5HARRAYC2E1upywLBhqe+Qbmz1MtUSFD0LsuVLVQ6PxM8AtazFYHko9GxXXIaphpL3GmVu6+3YHBtrDrO7pFHMViVkrVK8645a+nYoaCwKNoi9xKR3priwJ5BhaaUixYLzIYKQR52o4dGcQS+rHjt5GGoUVQullYOvfEgdrbwtbB/uk6Y2ys0uceZzrbxS+fcCkwh6yhrC646SsDUTXDvt5OjhzZMZhWlQ+4P8RiDBM1f9rtcDrt19mMFupcJwMelkcNzo66haSc09EtcKurm3LHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPxxAFySWsQ4woajGa1KggZ2hDc7+jP0BOcpnFcPjvc=;
 b=aWnQWBpV+70xRcnj+Nl0j9jGVDsbLv4zV6zKAWw+2hROlJrqiieHzdIOPAM4sU+4ROVRyRlhxPe2YyuLrhPMULggN6oIcW8NX77bzL2pIR/GiGQ1NDfoj6Tmrys0hlgRAgNxygkR81bHyPNtcn8uFvm4jO5UW4koDDbO0yfO/ZU=
Received: from PH7PR03CA0017.namprd03.prod.outlook.com (2603:10b6:510:339::32)
 by CHAPR12MB999250.namprd12.prod.outlook.com (2603:10b6:610:300::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 18:45:38 +0000
Received: from CY7PEPF000000F2.namprd05.prod.outlook.com
 (2603:10b6:510:339:cafe::36) by PH7PR03CA0017.outlook.office365.com
 (2603:10b6:510:339::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 18:45:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY7PEPF000000F2.mail.protection.outlook.com (10.167.247.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 18:45:37 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 13:45:31 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 13:45:30 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 13:45:30 -0500
Message-ID: <ccabdb48-f7a6-d6ce-d148-b4e2827aec17@amd.com>
Date: Tue, 13 Oct 2026 11:45:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V4 14/19] accel/amdxdna: Move HMM invalidate wait into
 common GEM code
Content-Language: en-US
To: David Zhang <yidong.zhang@amd.com>, <quic_jhugo@quicinc.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <sonal.santan@amd.com>, <mario.limonciello@amd.com>, Hayden Laccabue
 <Hayden.Laccabue@amd.com>
References: <yidong.zhang@amd.com>
 <20261009225343.3079074-1-yidong.zhang@amd.com>
 <20261009225343.3079074-15-yidong.zhang@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20261009225343.3079074-15-yidong.zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F2:EE_|CHAPR12MB999250:EE_
X-MS-Office365-Filtering-Correlation-Id: 87376da9-c593-4312-6d30-08df295a2c13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|10067099003|18002099003|22082099003|11063799006|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: SJydw9CEMS6+QUyHJ8FNH+jZo9m3L3uxEVXl4s4WZM6D0QG8AbA1RIoTiTNk4zD2/bdQXNRn7IYdoAq1/rE09FtguiWEaQop7pTG0Je3K+sS8j1cTN2ypf0nhLAAQEPNZ/dFwBjzpboiJdtMwm5zJ5pqrXWEuTE6XvlsXJDYPTO8GPQlDM3wsCV7wNRJDIOhK6UmdWu8eglv0W92dk6M7ssgoPS/LtXFt4x+6bC4kK3yf/NYq4I5qQ026nhvgT4IFOSM1SZxBSRgwgYAn50Phv6333DR5HtsZ8XrWxUwLTvrEW6TOrReKpwAD7r7WHjF6noTGkfR04v38TbXB5rcEFty29pY1hQ0tnJZWSP0RErTvkjwn2Ck7+q0KDARlsjCINLZIHg7BMjjKD2JP6a4ru5kzRIJxv1akYFIOWSyMiF8YHD9tx2nruNm90hbiCfAlXK/rHAnVYtQKTY3OHh2zlY6jjjzSlHuhDqNt2nSmj5DnbUyuon0052wd9PllH6wW1viAr0fzollqwVl/ozKTEv1kbYMwQV0KawvYkXtDZDB3D8JTohIZ3AX9m/4262fO9MucJQIUOnMTBoz8OBij4vjZgGf+kulwcKHlDZBHhD4zCjAhRRKUDVyHO9yYQk+86jH4db0Xly77lfBJb9t03pzN73DaVcpDz2HN/5/MDlQc6wFUjOLlUfL4zzo6Od4ABEM64UNp1SQZ97IpFx8oQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(10067099003)(18002099003)(22082099003)(11063799006)(261009223027099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nqC+Ba+EE/XbR0mPEPfmX9wWZR79FQR0u86HUovrhS5tyikTG+nKeoEmaLLvJm26ikA+FfrUM4wEhtjVqeGwM1lzEzIirOz8iHCCSPTSimawz+4Cs/gF7OIVTZi6umJuevj306EKr1dcOAQs4M88Pz3ud6sQX/bCL1Py8yOUtrKjmC4y6oN3actoUmG0jHjAIevB4pYe2H/Fn418gYeiBaKM3PBamlkmqTILZqh/D4ulSCWkgJ389m5VkZmX3uzDOOk/SU3OEGInk4N6fMlZYKNtq++MhfknBO4TJgoxjRijxsMI6UtEZRSy/L9fC1NNU2eCJmjJgqO/VHbkindAslD88EYY588JK5qBbGbK3eLFJGcYGP8K1uoLc0KvauBxEJsv6A70wOxOfhKDv8o386qisE0BF7Wcsbhd7KyfpgCQ4oC0AuSVuK6rEkFQbNig
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 18:45:37.2279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87376da9-c593-4312-6d30-08df295a2c13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY7PEPF000000F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999250
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


On 10/9/26 15:53, David Zhang wrote:
> When a user mapping of a BO is invalidated, the driver must wait for
> the BO's reservation fences before the pages are released. AIE2 does
> this in aie2_hmm_invalidate() through the .hmm_invalidate callback,
> and AIE4 needs the same wait.
>
> Do the wait directly in amdxdna_hmm_invalidate() in amdxdna_gem.c and
> remove the .hmm_invalidate callback and aie2_hmm_invalidate(). Devices
> that do not attach fences to user BOs return from the wait at once.
>
> Make the wait uninterruptible. With an interruptible wait, a pending
> signal, such as SIGKILL during process exit, ends the wait early and
> the pages can be freed while the NPU may still access them.

This is a bug fix. Please add "Fixes" tag and change the title to 
reflect the fix.

Lizhi

>
> Co-developed-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
> Signed-off-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
> Signed-off-by: David Zhang <yidong.zhang@amd.com>
> ---
>   drivers/accel/amdxdna/aie2_ctx.c        | 15 ---------------
>   drivers/accel/amdxdna/aie2_pci.c        |  1 -
>   drivers/accel/amdxdna/aie2_pci.h        |  1 -
>   drivers/accel/amdxdna/amdxdna_gem.c     | 14 ++++++++++++--
>   drivers/accel/amdxdna/amdxdna_pci_drv.h |  1 -
>   5 files changed, 12 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
> index d927c8c9d557..8c1b29964f8f 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -1277,21 +1277,6 @@ int aie2_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job,
>   	return ret;
>   }
>   
> -void aie2_hmm_invalidate(struct amdxdna_gem_obj *abo,
> -			 unsigned long cur_seq)
> -{
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
> -}
> -
>   int aie2_hwctx_heap_expand(struct amdxdna_hwctx *hwctx,
>   			   struct amdxdna_gem_obj *heap)
>   {
> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
> index 1b029d33a24b..690ad035463c 100644
> --- a/drivers/accel/amdxdna/aie2_pci.c
> +++ b/drivers/accel/amdxdna/aie2_pci.c
> @@ -1228,7 +1228,6 @@ const struct amdxdna_dev_ops aie2_ops = {
>   	.hwctx_config = aie2_hwctx_config,
>   	.hwctx_sync_debug_bo = aie2_hwctx_sync_debug_bo,
>   	.cmd_submit = aie2_cmd_submit,
> -	.hmm_invalidate = aie2_hmm_invalidate,
>   	.get_array = aie2_get_array,
>   	.get_dev_revision = aie2_get_dev_rev,
>   	.hwctx_heap_expand = aie2_hwctx_heap_expand,
> diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
> index 709e7545c65f..13391275df31 100644
> --- a/drivers/accel/amdxdna/aie2_pci.h
> +++ b/drivers/accel/amdxdna/aie2_pci.h
> @@ -272,7 +272,6 @@ int aie2_hwctx_sync_debug_bo(struct amdxdna_hwctx *hwctx, u32 debug_bo_hdl);
>   void aie2_hwctx_suspend(struct amdxdna_client *client);
>   int aie2_hwctx_resume(struct amdxdna_client *client);
>   int aie2_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job, u64 *seq);
> -void aie2_hmm_invalidate(struct amdxdna_gem_obj *abo, unsigned long cur_seq);
>   int aie2_hwctx_heap_expand(struct amdxdna_hwctx *hwctx, struct amdxdna_gem_obj *heap);
>   
>   #endif /* _AIE2_PCI_H_ */
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index f4832337ec31..e1b72cef51bd 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -12,6 +12,7 @@
>   #include <drm/gpu_scheduler.h>
>   #include <linux/dma-buf.h>
>   #include <linux/dma-direct.h>
> +#include <linux/dma-resv.h>
>   #include <linux/iosys-map.h>
>   #include <linux/pagemap.h>
>   #include <linux/swap.h>
> @@ -232,6 +233,7 @@ static bool amdxdna_hmm_invalidate(struct mmu_interval_notifier *mni,
>   	struct amdxdna_umap *mapp = container_of(mni, struct amdxdna_umap, notifier);
>   	struct amdxdna_gem_obj *abo = mapp->abo;
>   	struct amdxdna_dev *xdna;
> +	long ret;
>   
>   	if (!mmu_notifier_range_blockable(range))
>   		return false;
> @@ -249,8 +251,16 @@ static bool amdxdna_hmm_invalidate(struct mmu_interval_notifier *mni,
>   	mmu_interval_set_seq(&mapp->notifier, cur_seq);
>   	up_write(&xdna->notifier_lock);
>   
> -	if (xdna->dev_info->ops->hmm_invalidate)
> -		xdna->dev_info->ops->hmm_invalidate(abo, cur_seq);
> +	/*
> +	 * Wait uninterruptibly. Returning early on a signal would let the
> +	 * pages be freed while the NPU may still access them. This relies
> +	 * on job fences signaling in finite time; job timeout detection
> +	 * and recovery (TDR) for AIE4 will be added in a separate change.
> +	 */
> +	ret = dma_resv_wait_timeout(to_gobj(abo)->resv, DMA_RESV_USAGE_BOOKKEEP,
> +				    false, MAX_SCHEDULE_TIMEOUT);
> +	if (!ret)
> +		XDNA_ERR(xdna, "Failed to wait for bo, ret %ld", ret);
>   
>   	if (range->event == MMU_NOTIFY_UNMAP) {
>   		down_write(&xdna->notifier_lock);
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
> index 11f46ec738d7..2a1d6b33363c 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
> @@ -63,7 +63,6 @@ struct amdxdna_dev_ops {
>   	int (*hwctx_config)(struct amdxdna_hwctx *hwctx, u32 type, u64 value, void *buf, u32 size);
>   	int (*hwctx_sync_debug_bo)(struct amdxdna_hwctx *hwctx, u32 debug_bo_hdl);
>   	int (*hwctx_heap_expand)(struct amdxdna_hwctx *hwctx, struct amdxdna_gem_obj *heap);
> -	void (*hmm_invalidate)(struct amdxdna_gem_obj *abo, unsigned long cur_seq);
>   	int (*cmd_submit)(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job, u64 *seq);
>   	int (*cmd_wait)(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout);
>   	int (*get_aie_info)(struct amdxdna_client *client, struct amdxdna_drm_get_info *args);
