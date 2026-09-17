Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B43C88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 18:23:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F48F10F04A;
	Thu, 17 Sep 2026 18:23:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bSY9LnnG";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011018.outbound.protection.outlook.com [40.107.208.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8575910F04A
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 18:23:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQ2bkuui3/xs+cZnuG6jbdJQV8WAZtCFvbwSN+DfLtMA9NQl8JRU7ksJxF86qtATOG1QKZqOW+ZuqI00LLdSLhgwMoEY0MNlFcKBSz8kvcreupKfW4BW2SIt9l8ih0jBHIdaFSRruBRmNvkP2S44UZpzOQJ1ZeezmiNXdIOPDzFbI+vcso0miTXUXbokDpHkCpVMjVW9JFpskmOrOkeZlYAaiF4faRCJc8DhLtHwfx4pl2cbA15U8uJIwWvOyHZriwJAxmjGT1xPR5ELPoBh0GSKpRn3h6B4tsiXFOi9Bzz5BizCGApZsukv3vZ2PE85gf+OJ3/cmg9JZfcYtzVBgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jrvncvpaE1RLxv99LQCk2oEvos2fQKoE+F/FWHjoOY=;
 b=g+ki/+6VW5cL+csq6cuOu/dnLiXI3jGHISza3PQ69Rg11LYbApmTf5PbnuuB9aC1AW7sS1w+v2v3qauJ6CHxNlXjzr8pUABqqlzfOq7eC+QSmU+WDixtJlxAhpXu4TiTNNw44BmVoNTPYZMZuBANNy9mBgJViEyHEAoq9jDEiu3y8nIzTWR9fh3AnKBYoKXRsup2ttKEgmKTFiiwTrWk208ti0QrAM1Xkh/Dl0p67x4bfdzRFz1I08AFu20/kPCKTfIT5RdYdorRdZEalJm80YnGU2nd3nRt3++xH0MCiDLL1jzDXAroF7OA63qYrAqOtfcIJbBs1wyEbj4/i7H/Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jrvncvpaE1RLxv99LQCk2oEvos2fQKoE+F/FWHjoOY=;
 b=bSY9LnnGC5GnwCiMPpXp5ff2u9FWFPTprx5L0FQnodqaCU8D3wYzzun9ugsanQ1nOedAjQelHrsW9urfc8yRuB448Kf8gfrZPfj8sw96C/d7JfHVQ47rVm+B0Zrb1rabEXdjD/a5MLjqd037OooS34nsMYOfFK77xFPbnBr9qYA=
Received: from SJ0PR03CA0087.namprd03.prod.outlook.com (2603:10b6:a03:331::32)
 by SA5PPFCAFD069B8.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Thu, 17 Sep
 2026 18:23:09 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::89) by SJ0PR03CA0087.outlook.office365.com
 (2603:10b6:a03:331::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 18:23:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 18:23:08 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 13:23:08 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 13:23:07 -0500
Received: from [172.19.69.116] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 17 Sep 2026 13:23:07 -0500
Message-ID: <599748e0-e3e8-4dd4-9d04-000aed2d2cdb@amd.com>
Date: Thu, 17 Sep 2026 11:23:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Fix race between unmap and free BO
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>, <dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20260917154824.1872220-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Max Zhen <max.zhen@amd.com>
In-Reply-To: <20260917154824.1872220-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|SA5PPFCAFD069B8:EE_
X-MS-Office365-Filtering-Correlation-Id: e8a86c84-1f2e-4b22-cb2e-08df14e8b9b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|6133799003|10067099003|18002099003|56012099006|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: Dc/rANAbG3Lcgvkz0k0d1+yGactTqtrHqorUbnk85ljrhFbBO9jQ211bgPMVyjFnPqqXTTSKQ/+er5VrX/B+asW490B4THVcEWTPDDiwm2yHQpqLCdfzoP24Aoa1WLxdaPBc7yDcRHkEky174fChhD8tyfuA7j1xGC0VNlGpfzavENk8vCclOeTznlHCkRBOqAN8OYDMWbGAr3sEW93kZZ4tO4VFUv8WfMJm7WKnLsGTJ/EEvdg4TVBrg4AqdorrYHe46p1LOnARPgXkxpSUIo7cXGFRAKjz8HAwMCNYT9W+bkwGcmultUFdYS+I/POBlzeZ9mMXAgATZQhOzPWFQVjdlbRSJ3jogPEz2IJr36zk8gVwgq/IDr13seK/hpniaa6ETQWVnTQD9osZRD4+pqdotDXGSUHD39EooDxT9JPHfQJquDTB5sxByvFjfENuE2r9/vJj4sR1emFtrX657GZDE/0ZmVhpaww9jGo9IlT3OR+gNLjaQ1tJLoLLu856B6fOrwZnBShfZtYvGFvJxCTJ1/jYD8ZvHRUuqNcgNSygtqUL59R5ajhNNdELF3RmlumO5bbahFiNrl0Tbk3+KngNHj6YQl/8j7pXPdhqi7zWBOYhBgOoyIS6ZERyrsC98OCtA1nKA8yrpKmwwRYIuq/LnJ7m7XR46XB65nxJ6qMMrcMNb4n6zudhh0+YRU1FDJULWOQawHuzcK2jV8RKWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(6133799003)(10067099003)(18002099003)(56012099006)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: t0dLdumOsMIijlwJhjUbthiboSR7URXN0RIGszvRxsAwa9woMqb5KRkurBTN6ed1WA69EuBiXvnltS278Z/8GvubYcZlROwZ6SrUyjzxpvhbKnCH+k0tecbDlCBPO+caGnRafs+C9Ugq27POaWRq+781cA4l8e9acILMIYi9iHyGDfEJJHIXKfarbXxv+2nwPKgV7ov2zErkwe+cwigUVaYsFSrJmyeaT0ayDMfqlphltbVrLiXXsjQLWeJx5x0eMz3/7wLjzPBXAUe6KjL+xUHCByWwqWcFrPUfYyVcAh8BFCf/iH9iXOs89xLAkgpEmQBGvT3oirqoxhhxkw9IkEGTfGwQUypRL8OGpbrsYcVNg116O+6oKM1Y2CEPC/ehO9HX3ypxHck4wcYclYZVakdhb8KSLuuzXzbkGTE8ccxlg+N+xG8Uc4ibjxKLULRp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 18:23:08.9116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a86c84-1f2e-4b22-cb2e-08df14e8b9b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFCAFD069B8
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



On 9/17/2026 Thu 08:48, Lizhi Hou wrote:
> A userspace process can concurrently trigger an unmap, which queues
> hmm_unreg_work, and free BO. If amdxdna_hmm_unreg_work() executes
> list_del(&mapp->node) and is preempted before calling amdxdna_umap_put(),
> amdxdna_hmm_unregister_all() can fail to find the mapping in the list
> and return without calling cancel_work_sync(). This allows object
> destruction to proceed while the worker still holds a pointer to the BO
> in the umap structure.
> 
> Moving the work item from struct amdxdna_umap to struct amdxdna_gem_obj.
> The worker no longer holds a pointer to an individual mapping, so there
> is no longer a window where the umap has been unlinked from umap_list but
> work is still pending against it. The work item now lives in the BO
> itself, so use a single cancel_work_sync() in the free path to drain the
> work.
> 
> Fixes: 445d20910429 ("accel/amdxdna: Fix unexpected wait when flushing notifier_wq")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Max Zhen <max.zhen@amd.com>
> ---
>   drivers/accel/amdxdna/amdxdna_gem.c | 95 +++++++++++++----------------
>   drivers/accel/amdxdna/amdxdna_gem.h |  3 +-
>   2 files changed, 42 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index e861db6f9369..398d0a58b53a 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -164,30 +164,6 @@ void amdxdna_gem_heap_free(struct amdxdna_client *client, struct amdxdna_gem_obj
>   	mutex_unlock(&client->mm_lock);
>   }
>   
> -static struct amdxdna_gem_obj *
> -amdxdna_gem_create_obj(struct drm_device *dev, size_t size)
> -{
> -	struct amdxdna_gem_obj *abo;
> -
> -	abo = kzalloc_obj(*abo);
> -	if (!abo)
> -		return ERR_PTR(-ENOMEM);
> -
> -	abo->pinned = false;
> -	abo->assigned_hwctx = AMDXDNA_INVALID_CTX_HANDLE;
> -	mutex_init(&abo->lock);
> -
> -	abo->mem.dma_addr = AMDXDNA_INVALID_ADDR;
> -	abo->mem.uva = AMDXDNA_INVALID_ADDR;
> -	abo->mem.size = size;
> -	abo->open_ref = 0;
> -	abo->internal = false;
> -	INIT_LIST_HEAD(&abo->mem.umap_list);
> -	xa_init_flags(&abo->heap_xa, XA_FLAGS_ALLOC);
> -
> -	return abo;
> -}
> -
>   static void
>   amdxdna_gem_destroy_obj(struct amdxdna_gem_obj *abo)
>   {
> @@ -278,10 +254,8 @@ static bool amdxdna_hmm_invalidate(struct mmu_interval_notifier *mni,
>   
>   	if (range->event == MMU_NOTIFY_UNMAP) {
>   		down_write(&xdna->notifier_lock);
> -		if (!mapp->unmapped) {
> -			queue_work(xdna->notifier_wq, &mapp->hmm_unreg_work);
> -			mapp->unmapped = true;
> -		}
> +		mapp->unmapped = true;
> +		queue_work(xdna->notifier_wq, &abo->hmm_unreg_work);
>   		up_write(&xdna->notifier_lock);
>   	}
>   
> @@ -311,13 +285,13 @@ static void amdxdna_hmm_unregister(struct amdxdna_gem_obj *abo,
>   		if (!compare_range(mapp, vma->vm_mm, vma->vm_start, vma->vm_end))
>   			continue;
>   
> -		queue_work(xdna->notifier_wq, &mapp->hmm_unreg_work);
>   		mapp->unmapped = true;
> +		queue_work(xdna->notifier_wq, &abo->hmm_unreg_work);
>   	}
>   	up_write(&xdna->notifier_lock);
>   }
>   
> -static void amdxdna_hmm_unregister_all(struct amdxdna_gem_obj *abo)
> +static void amdxdna_hmm_unreg_umaps(struct amdxdna_gem_obj *abo, bool force)
>   {
>   	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
>   	struct amdxdna_umap *mapp, *tmp;
> @@ -325,16 +299,18 @@ static void amdxdna_hmm_unregister_all(struct amdxdna_gem_obj *abo)
>   
>   	down_write(&xdna->notifier_lock);
>   	list_for_each_entry_safe(mapp, tmp, &abo->mem.umap_list, node) {
> +		if (!force && !mapp->unmapped)
> +			continue;
> +
>   		mapp->unmapped = true;
> -		mapp->cleanup = true;
>   		list_move(&mapp->node, &dead);
>   	}
> +	if (list_empty(&abo->mem.umap_list))
> +		abo->mem.uva = AMDXDNA_INVALID_ADDR;
>   	up_write(&xdna->notifier_lock);
>   
> -	list_for_each_entry_safe(mapp, tmp, &dead, node) {
> -		cancel_work_sync(&mapp->hmm_unreg_work);
> +	list_for_each_entry_safe(mapp, tmp, &dead, node)
>   		amdxdna_umap_put(mapp);
> -	}
>   }
>   
>   static void amdxdna_umap_release(struct kref *ref)
> @@ -353,24 +329,10 @@ void amdxdna_umap_put(struct amdxdna_umap *mapp)
>   
>   static void amdxdna_hmm_unreg_work(struct work_struct *work)
>   {
> -	struct amdxdna_umap *mapp = container_of(work, struct amdxdna_umap,
> -						 hmm_unreg_work);
> -	struct amdxdna_gem_obj *abo = mapp->abo;
> -	struct amdxdna_dev *xdna;
> +	struct amdxdna_gem_obj *abo = container_of(work, struct amdxdna_gem_obj,
> +						   hmm_unreg_work);
>   
> -	xdna = to_xdna_dev(to_gobj(mapp->abo)->dev);
> -	down_write(&xdna->notifier_lock);
> -	if (mapp->cleanup) {
> -		up_write(&xdna->notifier_lock);
> -		return;
> -	}
> -
> -	list_del(&mapp->node);
> -	if (list_empty(&abo->mem.umap_list))
> -		abo->mem.uva = AMDXDNA_INVALID_ADDR;
> -	up_write(&xdna->notifier_lock);
> -
> -	amdxdna_umap_put(mapp);
> +	amdxdna_hmm_unreg_umaps(abo, false);
>   }
>   
>   static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
> @@ -422,8 +384,6 @@ static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
>   	mapp->abo = abo;
>   	kref_init(&mapp->refcnt);
>   
> -	INIT_WORK(&mapp->hmm_unreg_work, amdxdna_hmm_unreg_work);
> -
>   	ret = mmu_interval_notifier_insert_locked(&mapp->notifier,
>   						  current->mm,
>   						  addr,
> @@ -449,6 +409,31 @@ static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
>   	return ret;
>   }
>   
> +static struct amdxdna_gem_obj *
> +amdxdna_gem_create_obj(struct drm_device *dev, size_t size)
> +{
> +	struct amdxdna_gem_obj *abo;
> +
> +	abo = kzalloc_obj(*abo);
> +	if (!abo)
> +		return ERR_PTR(-ENOMEM);
> +
> +	abo->pinned = false;
> +	abo->assigned_hwctx = AMDXDNA_INVALID_CTX_HANDLE;
> +	mutex_init(&abo->lock);
> +
> +	abo->mem.dma_addr = AMDXDNA_INVALID_ADDR;
> +	abo->mem.uva = AMDXDNA_INVALID_ADDR;
> +	abo->mem.size = size;
> +	abo->open_ref = 0;
> +	abo->internal = false;
> +	INIT_LIST_HEAD(&abo->mem.umap_list);
> +	xa_init_flags(&abo->heap_xa, XA_FLAGS_ALLOC);
> +	INIT_WORK(&abo->hmm_unreg_work, amdxdna_hmm_unreg_work);
> +
> +	return abo;
> +}
> +
>   static void amdxdna_gem_dev_obj_free(struct drm_gem_object *gobj)
>   {
>   	struct amdxdna_dev *xdna = to_xdna_dev(gobj->dev);
> @@ -756,7 +741,9 @@ static void amdxdna_gem_obj_free(struct drm_gem_object *gobj)
>   	struct amdxdna_dev *xdna = to_xdna_dev(gobj->dev);
>   	struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
>   
> -	amdxdna_hmm_unregister_all(abo);
> +	/* No notifier survives this, so no new work can be queued. */
> +	amdxdna_hmm_unreg_umaps(abo, true);
> +	cancel_work_sync(&abo->hmm_unreg_work);
>   
>   	if (abo->pinned)
>   		amdxdna_gem_unpin(abo);
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.h b/drivers/accel/amdxdna/amdxdna_gem.h
> index 5dfefdcf1356..9b4aa21a37c9 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.h
> +++ b/drivers/accel/amdxdna/amdxdna_gem.h
> @@ -14,13 +14,11 @@
>   struct amdxdna_umap {
>   	struct mmu_interval_notifier	notifier;
>   	struct hmm_range		range;
> -	struct work_struct		hmm_unreg_work;
>   	struct amdxdna_gem_obj		*abo;
>   	struct list_head		node;
>   	struct kref			refcnt;
>   	bool				invalid;
>   	bool				unmapped;
> -	bool				cleanup;
>   };
>   
>   struct amdxdna_mem {
> @@ -44,6 +42,7 @@ struct amdxdna_gem_obj {
>   	struct mutex			lock; /* Protects: pinned, mem.kva, open_ref */
>   	struct amdxdna_mem		mem;
>   	int				open_ref;
> +	struct work_struct		hmm_unreg_work;
>   
>   	/* Below members are initialized when needed */
>   	struct drm_mm_node		mm_node; /* For AMDXDNA_BO_DEV */

