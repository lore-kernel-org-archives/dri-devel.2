Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA87109024D
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 16:10:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A484C10E111;
	Thu, 19 Mar 2026 16:10:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xKiBi/5P";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013040.outbound.protection.outlook.com
 [40.107.201.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBD7F10E111
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 16:10:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZ1b9azeNc6RPabVvnPWZ01ou+bhj4k61o9sRH0JKxn7rDNKdPJhR+wtSpzpO/2JxnrGGsosJElJe9VbrJOeBa6TreqIYpmIZ/+in8YTzfdQEuZ1KYHMlBxmQCq+RveP9zC0vrJkkWDoKxm3rG0h+cjnSnqvdU3MDfpuWr2cgICdSdDVdG/hASJlVMpWr5CUXp3ALcMfIautczYLRdXLw+ltM5NE/OgCTg+IXYJdDpxmYuIU/6EQAAVOzaXGNSEpZb+SK8+MnIYOOdNun3cAP+lkUxg09aOEJ2BrVmBe2IHM4vtIFRQfHbnuyHKLGa5hjTcn9JsAKMI6v4LJ+H0rwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3aWYGBHxL8cLyf597Sh3A5MYBrwaAwjQoUBrlie/tEw=;
 b=r9Y/lSLXC2yAFqWplZicvO1qDUp05ZKa0L+CDy7gVvfGa1fiWdRWIlRnwgF0prpZO8MWc8/nDRUjkrBeY+DvIiskI6DUikIl+XQPnYf6G2li4tUQSeEFxlnv5Sq5CQpULjtrsL1qR3nVVFgMjhOEje/hFmc5rdGQCQB51BYFcgHnpBD5jDsxm55dU4bvwguTx+LQS4u7273dFq5Or4yz4RzIOzNbJXNcDLL3EQmJC/Zv6bYEaePmr12CHKJlINZ1gs56HSnZwRedYt4lBqHA+ruCQPbLuLduvQSdFZOB4z3B8ztJVBXqFYqfQZNsjDIbwdawxbMntrMH0/1pBkfaWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3aWYGBHxL8cLyf597Sh3A5MYBrwaAwjQoUBrlie/tEw=;
 b=xKiBi/5PJlfA7x7M+OZfWt9f1TT2BlARHmxa7IqdpHEoU0ehMItOGLy88N9U5wYKjKsJEQDCzixO4eBEyUdmhvZAN2euJBiJFSEU0KYDBTod7ed0hZtuZ5kGlR9flpb7rPSXyBaMZ4inCNKx7ZwiECBcWLHooAhIM/1sFgeAaDY=
Received: from PH7P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::6)
 by MW4PR12MB7484.namprd12.prod.outlook.com (2603:10b6:303:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 16:10:38 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:510:338:cafe::20) by PH7P223CA0008.outlook.office365.com
 (2603:10b6:510:338::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Thu,
 19 Mar 2026 16:10:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 16:10:37 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Mar
 2026 11:10:35 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Mar
 2026 09:01:19 -0700
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 19 Mar 2026 11:01:18 -0500
Message-ID: <9fbf9419-1ddd-9a05-8dff-1686011b9b3e@amd.com>
Date: Thu, 19 Mar 2026 09:01:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] accel/ivpu: Perform engine reset instead of device
 recovery on TDR
Content-Language: en-US
To: Karol Wachowski <karol.wachowski@linux.intel.com>,
 <dri-devel@lists.freedesktop.org>
CC: <oded.gabbay@gmail.com>, <jeff.hugo@oss.qualcomm.com>,
 <maciej.falkowski@linux.intel.com>, <andrzej.kacprowski@linux.intel.com>
References: <20260318093927.4080303-1-karol.wachowski@linux.intel.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260318093927.4080303-1-karol.wachowski@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|MW4PR12MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: 77663807-ac69-4ed3-8164-08de85d20ef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|22082099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info: EmqMjncv55qpmBP+WFqXWdbla8TeVl571WhQPi5SF6nVnOWe9l5l/B0DyMJuVrBLJ7ZAAmgjUIzODOqt6wnWMqQd7cAz/asLXHhDxDWWsSi6e6cObwHEbye7XmDz4QSe+bHG0b8Y71TJD4QMx19OovHhydixfo1haWQ/ydmyZtx32OQIZZnbAtc4PjifXSxyg6ho4ntdfs6kZs73tjiEMCUJ371zi0mCy3TjKYkVwFj8I7kwJ0NKxPQ0UQb39UjCWMFls8VvShO791iO9+LR3+tIkQVJ1YVSEIDmDvva6AginDx2EMBmd5oTf9S+sQn2Ek66TPXKUJRx1gBNR2cfasl6QTwn6imKW1eXD7qnRuLYEu9RdBWov88EiIsvV82EOpFRYyK1nfPnO0IbSe4lPAGLsnGDrcr9Va5q8kwX/Sd91ud3FZWka7IzsHSB1GxTqVFMcAVoTP4faCBA7LJbleQ/6srbYcHz69IogRuEFzFcW+ektsZEWeZC47sojyaTxDMWnZNRbfrY0Mo+8hmdh8jje6lHOn1ijPoSNuAmacPZqRSEeIihMhoLXOByE6k1QGhDcBCdw3jkKzxX7OxsvNkqGr2aU04Ge0oY/mOijDKiyfyVcKkbCN5sdTKheoUD71ayy7MhnINvSLxh6OQ4G7qsBBrHtI4ODOAfxUzyPk5pQew0aOL24jFWUMnkKj5PNT7U6MNQvS5FxDxDkyLtfic5wQj61YvOOoL+2udSpDSXrkLn1KZb3y9GoDrRSDxTcqI7giQilgX5xpKAzeKraQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(56012099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IjAHLH/CGl+nZVmv1nFV0tuyqPxZpu9JR0Mu/ExWHIMvUGYQIUN/0BT4xnCrkarva3/1q16AiS1O8yiNNE9+71aWHZ7VyGLdcQFCJt4cug96zHarCb/OfMDcOerWZVidq7LN6bGF037fBOH+ZkNoHI6NrZc9uSEBUiqIEk7qeRj5C0euIk9KeKob4Gg3XubIhMbauFa46c78ORBA9f54segp9AUdH3nB8ZDKANvt7HbCxSPEphLVSBjcz6CnuBPRg7qeJnyhrX46vAlR2kVKqBlOtBmWeTE1U+x9z3IBiYsgK9jK10YIb8aSRTM7O5D1xDAJEEuNE2CL6XjCzfuaPQ1YpDTauPwipV+tT2YQbgEtXdC/VfFrnRAo5f9n7noLxHlg/WO8fVmuB9h7FPBB8Yd5J5xhooiBhkX+7gUqHW/an/vC9GJqZzzhGyGhpM8n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 16:10:37.2785 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77663807-ac69-4ed3-8164-08de85d20ef3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7484
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

Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>

On 3/18/26 02:39, Karol Wachowski wrote:
> Replace full device recovery on TDR timeout with per-context abort,
> allowing individual context handling instead of resetting the entire
> device.
>
> Extend ivpu_jsm_reset_engine() to return the list of contexts impacted
> by the engine reset and use that information to abort only the affected
> contexts.
>
> Only check for potentially faulty contexts when the engine reset was not
> triggered by an MMU fault or a job completion error status. This prevents
> misidentifying non-guilty contexts that happened to be running at the
> time of the fault.
>
> Trigger full device recovery if no contexts were marked by engine reset
> if triggered by job completion timeout, as there is no way to identify
> guilty one.
>
> Add engine reset counter to debugfs for engine resets bookkeeping
> for debugging/testing purposes.
>
> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
> ---
>   drivers/accel/ivpu/ivpu_debugfs.c | 14 +++++++--
>   drivers/accel/ivpu/ivpu_drv.c     |  1 +
>   drivers/accel/ivpu/ivpu_drv.h     |  3 +-
>   drivers/accel/ivpu/ivpu_job.c     | 50 +++++++++++++++++++++++++++++--
>   drivers/accel/ivpu/ivpu_jsm_msg.c | 19 +++++++++---
>   drivers/accel/ivpu/ivpu_jsm_msg.h |  3 +-
>   drivers/accel/ivpu/ivpu_mmu.c     |  3 +-
>   drivers/accel/ivpu/ivpu_pm.c      | 15 ++++++----
>   drivers/accel/ivpu/ivpu_pm.h      |  1 +
>   9 files changed, 92 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/accel/ivpu/ivpu_debugfs.c b/drivers/accel/ivpu/ivpu_debugfs.c
> index a09f54fc4302..189dbe94cf14 100644
> --- a/drivers/accel/ivpu/ivpu_debugfs.c
> +++ b/drivers/accel/ivpu/ivpu_debugfs.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /*
> - * Copyright (C) 2020-2024 Intel Corporation
> + * Copyright (C) 2020-2026 Intel Corporation
>    */
>   
>   #include <linux/debugfs.h>
> @@ -127,6 +127,14 @@ static int firewall_irq_counter_show(struct seq_file *s, void *v)
>   	return 0;
>   }
>   
> +static int engine_reset_counter_show(struct seq_file *s, void *v)
> +{
> +	struct ivpu_device *vdev = seq_to_ivpu(s);
> +
> +	seq_printf(s, "%d\n", atomic_read(&vdev->pm->engine_reset_counter));
> +	return 0;
> +}
> +
>   static const struct drm_debugfs_info vdev_debugfs_list[] = {
>   	{"bo_list", bo_list_show, 0},
>   	{"fw_name", fw_name_show, 0},
> @@ -137,6 +145,7 @@ static const struct drm_debugfs_info vdev_debugfs_list[] = {
>   	{"reset_counter", reset_counter_show, 0},
>   	{"reset_pending", reset_pending_show, 0},
>   	{"firewall_irq_counter", firewall_irq_counter_show, 0},
> +	{"engine_reset_counter", engine_reset_counter_show, 0},
>   };
>   
>   static int dvfs_mode_get(void *data, u64 *dvfs_mode)
> @@ -352,8 +361,9 @@ static const struct file_operations ivpu_force_recovery_fops = {
>   static int ivpu_reset_engine_fn(void *data, u64 val)
>   {
>   	struct ivpu_device *vdev = (struct ivpu_device *)data;
> +	struct vpu_jsm_msg resp;
>   
> -	return ivpu_jsm_reset_engine(vdev, (u32)val);
> +	return ivpu_jsm_reset_engine(vdev, (u32)val, &resp);
>   }
>   
>   DEFINE_DEBUGFS_ATTRIBUTE(ivpu_reset_engine_fops, NULL, ivpu_reset_engine_fn, "0x%02llx\n");
> diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
> index dd3a486df5f1..2801378e3e19 100644
> --- a/drivers/accel/ivpu/ivpu_drv.c
> +++ b/drivers/accel/ivpu/ivpu_drv.c
> @@ -665,6 +665,7 @@ static int ivpu_dev_init(struct ivpu_device *vdev)
>   	vdev->context_xa_limit.max = IVPU_USER_CONTEXT_MAX_SSID;
>   	atomic64_set(&vdev->unique_id_counter, 0);
>   	atomic_set(&vdev->job_timeout_counter, 0);
> +	atomic_set(&vdev->faults_detected, 0);
>   	xa_init_flags(&vdev->context_xa, XA_FLAGS_ALLOC | XA_FLAGS_LOCK_IRQ);
>   	xa_init_flags(&vdev->submitted_jobs_xa, XA_FLAGS_ALLOC1);
>   	xa_init_flags(&vdev->db_xa, XA_FLAGS_ALLOC1);
> diff --git a/drivers/accel/ivpu/ivpu_drv.h b/drivers/accel/ivpu/ivpu_drv.h
> index 6378e23e0c97..b739738c4566 100644
> --- a/drivers/accel/ivpu/ivpu_drv.h
> +++ b/drivers/accel/ivpu/ivpu_drv.h
> @@ -1,6 +1,6 @@
>   /* SPDX-License-Identifier: GPL-2.0-only */
>   /*
> - * Copyright (C) 2020-2025 Intel Corporation
> + * Copyright (C) 2020-2026 Intel Corporation
>    */
>   
>   #ifndef __IVPU_DRV_H__
> @@ -168,6 +168,7 @@ struct ivpu_device {
>   	struct xarray submitted_jobs_xa;
>   	struct ivpu_ipc_consumer job_done_consumer;
>   	atomic_t job_timeout_counter;
> +	atomic_t faults_detected;
>   
>   	atomic64_t unique_id_counter;
>   
> diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
> index f0154dfa6ddc..521931d1f7fc 100644
> --- a/drivers/accel/ivpu/ivpu_job.c
> +++ b/drivers/accel/ivpu/ivpu_job.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /*
> - * Copyright (C) 2020-2025 Intel Corporation
> + * Copyright (C) 2020-2026 Intel Corporation
>    */
>   
>   #include <drm/drm_file.h>
> @@ -607,6 +607,7 @@ bool ivpu_job_handle_engine_error(struct ivpu_device *vdev, u32 job_id, u32 job_
>   		 * status and ensure both are handled in the same way
>   		 */
>   		job->file_priv->has_mmu_faults = true;
> +		atomic_set(&vdev->faults_detected, 1);
>   		queue_work(system_percpu_wq, &vdev->context_abort_work);
>   		return true;
>   	}
> @@ -1115,6 +1116,51 @@ void ivpu_job_done_consumer_fini(struct ivpu_device *vdev)
>   	ivpu_ipc_consumer_del(vdev, &vdev->job_done_consumer);
>   }
>   
> +static int reset_engine_and_mark_faulty_contexts(struct ivpu_device *vdev)
> +{
> +	u32 num_impacted_contexts;
> +	struct vpu_jsm_msg resp;
> +	int ret;
> +	u32 i;
> +
> +	ret = ivpu_jsm_reset_engine(vdev, 0, &resp);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * If faults are detected, ignore guilty contexts from engine reset as NPU may not be stuck
> +	 * and could return currently running good context and faulty contexts are already marked
> +	 */
> +	if (atomic_cmpxchg(&vdev->faults_detected, 1, 0) == 1)
> +		return 0;
> +
> +	num_impacted_contexts = resp.payload.engine_reset_done.num_impacted_contexts;
> +
> +	ivpu_warn_ratelimited(vdev, "Engine reset performed, impacted contexts: %u\n",
> +			      num_impacted_contexts);
> +
> +	if (!in_range(num_impacted_contexts, 1, VPU_MAX_ENGINE_RESET_IMPACTED_CONTEXTS - 1)) {
> +		ivpu_pm_trigger_recovery(vdev, "Cannot determine guilty contexts");
> +		return -EIO;
> +	}
> +
> +	/* No faults detected, NPU likely got stuck. Mark returned contexts as guilty */
> +	guard(mutex)(&vdev->context_list_lock);
> +
> +	for (i = 0; i < num_impacted_contexts; i++) {
> +		u32 ssid = resp.payload.engine_reset_done.impacted_contexts[i].host_ssid;
> +		struct ivpu_file_priv *file_priv = xa_load(&vdev->context_xa, ssid);
> +
> +		if (file_priv) {
> +			mutex_lock(&file_priv->lock);
> +			file_priv->has_mmu_faults = true;
> +			mutex_unlock(&file_priv->lock);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>   void ivpu_context_abort_work_fn(struct work_struct *work)
>   {
>   	struct ivpu_device *vdev = container_of(work, struct ivpu_device, context_abort_work);
> @@ -1127,7 +1173,7 @@ void ivpu_context_abort_work_fn(struct work_struct *work)
>   		return;
>   
>   	if (vdev->fw->sched_mode == VPU_SCHEDULING_MODE_HW)
> -		if (ivpu_jsm_reset_engine(vdev, 0))
> +		if (reset_engine_and_mark_faulty_contexts(vdev))
>   			goto runtime_put;
>   
>   	mutex_lock(&vdev->context_list_lock);
> diff --git a/drivers/accel/ivpu/ivpu_jsm_msg.c b/drivers/accel/ivpu/ivpu_jsm_msg.c
> index 0256b2dfefc1..07b1d6f615a9 100644
> --- a/drivers/accel/ivpu/ivpu_jsm_msg.c
> +++ b/drivers/accel/ivpu/ivpu_jsm_msg.c
> @@ -151,10 +151,9 @@ int ivpu_jsm_get_heartbeat(struct ivpu_device *vdev, u32 engine, u64 *heartbeat)
>   	return ret;
>   }
>   
> -int ivpu_jsm_reset_engine(struct ivpu_device *vdev, u32 engine)
> +int ivpu_jsm_reset_engine(struct ivpu_device *vdev, u32 engine, struct vpu_jsm_msg *resp)
>   {
>   	struct vpu_jsm_msg req = { .type = VPU_JSM_MSG_ENGINE_RESET };
> -	struct vpu_jsm_msg resp;
>   	int ret;
>   
>   	if (engine != VPU_ENGINE_COMPUTE)
> @@ -162,14 +161,17 @@ int ivpu_jsm_reset_engine(struct ivpu_device *vdev, u32 engine)
>   
>   	req.payload.engine_reset.engine_idx = engine;
>   
> -	ret = ivpu_ipc_send_receive(vdev, &req, VPU_JSM_MSG_ENGINE_RESET_DONE, &resp,
> +	ret = ivpu_ipc_send_receive(vdev, &req, VPU_JSM_MSG_ENGINE_RESET_DONE, resp,
>   				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm);
>   	if (ret) {
>   		ivpu_err_ratelimited(vdev, "Failed to reset engine %d: %d\n", engine, ret);
>   		ivpu_pm_trigger_recovery(vdev, "Engine reset failed");
> +		return ret;
>   	}
>   
> -	return ret;
> +	atomic_inc(&vdev->pm->engine_reset_counter);
> +
> +	return 0;
>   }
>   
>   int ivpu_jsm_preempt_engine(struct ivpu_device *vdev, u32 engine, u32 preempt_id)
> @@ -554,6 +556,15 @@ int ivpu_jsm_dct_disable(struct ivpu_device *vdev)
>   }
>   
>   int ivpu_jsm_state_dump(struct ivpu_device *vdev)
> +{
> +	struct vpu_jsm_msg req = { .type = VPU_JSM_MSG_STATE_DUMP };
> +	struct vpu_jsm_msg resp;
> +
> +	return ivpu_ipc_send_receive_internal(vdev, &req, VPU_JSM_MSG_STATE_DUMP_RSP, &resp,
> +					      VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm);
> +}
> +
> +int ivpu_jsm_state_dump_no_reply(struct ivpu_device *vdev)
>   {
>   	struct vpu_jsm_msg req = { .type = VPU_JSM_MSG_STATE_DUMP };
>   
> diff --git a/drivers/accel/ivpu/ivpu_jsm_msg.h b/drivers/accel/ivpu/ivpu_jsm_msg.h
> index 9e84d3526a14..a74f5a0b0d93 100644
> --- a/drivers/accel/ivpu/ivpu_jsm_msg.h
> +++ b/drivers/accel/ivpu/ivpu_jsm_msg.h
> @@ -14,7 +14,7 @@ int ivpu_jsm_register_db(struct ivpu_device *vdev, u32 ctx_id, u32 db_id,
>   			 u64 jobq_base, u32 jobq_size);
>   int ivpu_jsm_unregister_db(struct ivpu_device *vdev, u32 db_id);
>   int ivpu_jsm_get_heartbeat(struct ivpu_device *vdev, u32 engine, u64 *heartbeat);
> -int ivpu_jsm_reset_engine(struct ivpu_device *vdev, u32 engine);
> +int ivpu_jsm_reset_engine(struct ivpu_device *vdev, u32 engine, struct vpu_jsm_msg *response);
>   int ivpu_jsm_preempt_engine(struct ivpu_device *vdev, u32 engine, u32 preempt_id);
>   int ivpu_jsm_dyndbg_control(struct ivpu_device *vdev, char *command, size_t size);
>   int ivpu_jsm_trace_get_capability(struct ivpu_device *vdev, u32 *trace_destination_mask,
> @@ -44,5 +44,6 @@ int ivpu_jsm_metric_streamer_info(struct ivpu_device *vdev, u64 metric_group_mas
>   int ivpu_jsm_dct_enable(struct ivpu_device *vdev, u32 active_us, u32 inactive_us);
>   int ivpu_jsm_dct_disable(struct ivpu_device *vdev);
>   int ivpu_jsm_state_dump(struct ivpu_device *vdev);
> +int ivpu_jsm_state_dump_no_reply(struct ivpu_device *vdev);
>   
>   #endif
> diff --git a/drivers/accel/ivpu/ivpu_mmu.c b/drivers/accel/ivpu/ivpu_mmu.c
> index e1baf6b64935..41efd8985fa6 100644
> --- a/drivers/accel/ivpu/ivpu_mmu.c
> +++ b/drivers/accel/ivpu/ivpu_mmu.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /*
> - * Copyright (C) 2020-2024 Intel Corporation
> + * Copyright (C) 2020-2026 Intel Corporation
>    */
>   
>   #include <linux/circ_buf.h>
> @@ -964,6 +964,7 @@ void ivpu_mmu_irq_evtq_handler(struct ivpu_device *vdev)
>   		file_priv = xa_load(&vdev->context_xa, ssid);
>   		if (file_priv) {
>   			if (!READ_ONCE(file_priv->has_mmu_faults)) {
> +				atomic_set(&vdev->faults_detected, 1);
>   				ivpu_mmu_dump_event(vdev, event);
>   				WRITE_ONCE(file_priv->has_mmu_faults, true);
>   			}
> diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
> index d20144a21e09..83da9b297f37 100644
> --- a/drivers/accel/ivpu/ivpu_pm.c
> +++ b/drivers/accel/ivpu/ivpu_pm.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /*
> - * Copyright (C) 2020-2024 Intel Corporation
> + * Copyright (C) 2020-2026 Intel Corporation
>    */
>   
>   #include <linux/highmem.h>
> @@ -166,7 +166,7 @@ static void ivpu_pm_recovery_work(struct work_struct *work)
>   	ivpu_pm_reset_begin(vdev);
>   
>   	if (!pm_runtime_status_suspended(vdev->drm.dev)) {
> -		ivpu_jsm_state_dump(vdev);
> +		ivpu_jsm_state_dump_no_reply(vdev);
>   		ivpu_dev_coredump(vdev);
>   		ivpu_suspend(vdev);
>   	}
> @@ -205,23 +205,25 @@ static void ivpu_job_timeout_work(struct work_struct *work)
>   
>   	if (ivpu_jsm_get_heartbeat(vdev, 0, &heartbeat) || heartbeat <= vdev->fw->last_heartbeat) {
>   		ivpu_err(vdev, "Job timeout detected, heartbeat not progressed\n");
> -		goto recovery;
> +		goto abort;
>   	}
>   
>   	inference_max_retries = DIV_ROUND_UP(inference_timeout_ms, timeout_ms);
>   	if (atomic_fetch_inc(&vdev->job_timeout_counter) >= inference_max_retries) {
>   		ivpu_err(vdev, "Job timeout detected, heartbeat limit (%lld) exceeded\n",
>   			 inference_max_retries);
> -		goto recovery;
> +		goto abort;
>   	}
>   
>   	vdev->fw->last_heartbeat = heartbeat;
>   	ivpu_start_job_timeout_detection(vdev);
>   	return;
>   
> -recovery:
> +abort:
>   	atomic_set(&vdev->job_timeout_counter, 0);
> -	ivpu_pm_trigger_recovery(vdev, "TDR");
> +	ivpu_jsm_state_dump(vdev);
> +	ivpu_dev_coredump(vdev);
> +	queue_work(system_percpu_wq, &vdev->context_abort_work);
>   }
>   
>   void ivpu_start_job_timeout_detection(struct ivpu_device *vdev)
> @@ -404,6 +406,7 @@ void ivpu_pm_init(struct ivpu_device *vdev)
>   	init_rwsem(&pm->reset_lock);
>   	atomic_set(&pm->reset_pending, 0);
>   	atomic_set(&pm->reset_counter, 0);
> +	atomic_set(&pm->engine_reset_counter, 0);
>   
>   	INIT_WORK(&pm->recovery_work, ivpu_pm_recovery_work);
>   	INIT_DELAYED_WORK(&pm->job_timeout_work, ivpu_job_timeout_work);
> diff --git a/drivers/accel/ivpu/ivpu_pm.h b/drivers/accel/ivpu/ivpu_pm.h
> index 00f2a01e3df6..2f07bb0b43be 100644
> --- a/drivers/accel/ivpu/ivpu_pm.h
> +++ b/drivers/accel/ivpu/ivpu_pm.h
> @@ -18,6 +18,7 @@ struct ivpu_pm_info {
>   	struct rw_semaphore reset_lock;
>   	atomic_t reset_counter;
>   	atomic_t reset_pending;
> +	atomic_t engine_reset_counter;
>   	u8 dct_active_percent;
>   };
>   
