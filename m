Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93AC4C9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:59:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0033910F1B6;
	Wed, 23 Sep 2026 20:59:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DFxH/S8x";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010069.outbound.protection.outlook.com [52.101.56.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4C9310F1C3
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 20:59:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mY8ZaCW4XBgjnQ4eROVqTSUTy67M7hILLh5oZ4JGP89a0T3cUUtQ+4XgfiwhOkiVd+iJmULvKGfr+Ev+X8r9A6YTGuxLZG1EXE9+yH+gaCvDnMBuYP9ZP5AjlGmYjemZ66bME0rj/PmfYqlAyH3jc8XHdlXZ+MoDCguiNIjh2WXyQ7qvZfCXlFicM1C1ZsaulKhf11MXaVr8S/zzmSAzCzdjO35nrcjNzzM7EMShDjzXRI2oaPwkQDSwW9bNzhaJHj3CppicAw3NY8iPn03Ho16atswZhjRkeLnLq+M5twSTBJgL9qrwFAmNIULejQekrsTQMrpoqs7fUZyAekh1yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0/xX99xAM+k2mEavhymmW30FKmT2Wum7HMP+5aTOZw=;
 b=fq9e8PKqsTGIFiqQy99HpHfWZ42ynvyIHdL059ZgEsNl5jJLfPth4NfQXaOMVkrumTUC44tQEAo4aeYxiOrNLEhz9Z4/QmX5DqEuldSlGvmcgRdMtL9q/pBLJD/uDvykKQX3qO+OD7ruYpA3L8yq9C5Ecj3HcBRz0cVWjneBZtgl9zepkmlmDweI22xnpzR49WymFiiMQmgD+oSe1uv1fzTRcMbT7IHqFEDs4f9KWVL3vRfWrWVb+6anFZStTT8GE0vXaEC+k5Is9B8XlrqGggIobbJUmnRxN8VThryDl52EV36/BEwhF9BGBUzMHqj2mvr6A06wmDlQGK1yuQjALA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0/xX99xAM+k2mEavhymmW30FKmT2Wum7HMP+5aTOZw=;
 b=DFxH/S8x3LLnbBDdslgeCWxzZy3peBtOg6TGFjYUGoY76fYX4lDMaye5/jlSHQ6Z0BT9iInTFIMZ6vmdFE+bVdfPZaI9PkJJbFL6RxfbNmYby6d2aSFVnOQjQ9XdSUeN3gUJaHBigUxnUtuknNuST5J/6Q30Iqcw3gQbdSEmW+0=
Received: from PH7PR13CA0018.namprd13.prod.outlook.com (2603:10b6:510:174::22)
 by SJ0PR12MB6942.namprd12.prod.outlook.com (2603:10b6:a03:449::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 20:58:54 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:510:174:cafe::1d) by PH7PR13CA0018.outlook.office365.com
 (2603:10b6:510:174::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 20:58:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 20:58:54 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 15:58:48 -0500
Received: from [172.19.68.121] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 15:58:48 -0500
Message-ID: <a570abe2-4da7-4a0f-8c7f-4c227ac924cd@amd.com>
Date: Wed, 23 Sep 2026 13:58:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Preallocate hardware context schedulers
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>, Jonghyuk Kim
 <malhyuk97@gmail.com>
References: <20260923200501.281208-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Max Zhen <max.zhen@amd.com>
In-Reply-To: <20260923200501.281208-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|SJ0PR12MB6942:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ea0b275-5e7e-476f-5d3d-08df19b57a52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|13003099007|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: nc6RxxRTLi3p8odE94dYEfw7vHE/huB4yuVObHXfuNL8ekPDC8EXwljHYJuzvPJACLgBYiGVVQkxi/uSn2Yz1Q5XmLaawZmwbQTK5roXQtIEdNfcZuGJ/3a1TFeJKTJb7xYdIhhVxy6Mp6F+FE1BKqON8rZmeRqx2/4oXYgs5lSA7nISSPhKQyW3mCk7YxlTgooAaKGT+f5wmEvyTdx3iCCFeXTdYcbzooSISAuS/hbJV5g0AtfBiGHC5E2hsxszY1oi/KQxW7bhVla9x78DyMLZEpg636l+YSZVW4gGV3biZJv54xvXLW5Y9POFl4KKawaeMa0YEtKgE/FhcHUrvFXa67nB3UPvZsqKa6+0lbjtCr1cg913VATJ2CmJ8Pj+FwmMkpkEtGki4xhFi8/lc+iWd3H7JiBig2BCN3x5LHMXF9J4fmoZDcpKmqSBoiAuPKfmxNamKeyg7+KTeuiP/OKbQhDuHkHKx3FpPOxiVjadwbgB7D+3JTumexa80MCKicFUkyLrVYR5XpBYp04JP6ZUtOc/D4TQx0uREvKlaFnUEYFnb/QRYyWo412UMd2qvIkTUyim2O8NDbkcnG1+nZ3K3UyK/F87pj2vCC9PklvhRmPIDsp1BAJHFvYuweksN7OQ55U97LEs8xLV9zxGoYmUvQ9sgy4yY8WDzsGimO4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(13003099007)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VqTM9+TwqbaiSoJNvJvf4ev3d6Gzi2S7h3ySkPn4oIaV/DOZCerlWwxLXQDaEamkuMwOCDHN20CR0lVPoenF2PHzlu8rmh6vGGnJYYJibEryzAAYuhP/gT5XRQRrzb8FDL0iT/tyltXrBJANemwDeGUOOEkiR5Uxqq+J40RxS+VCju+YRY0VEll3jLvTN6FLIXGvsCFLPgr6dJWa28ke4shcs8We6nLcSQ0w38QGfU72vOa9iLivtUG+ZMcDjeFH+dRxp4ZuiKKQlr9+V/Lymnq6yqRivLGZ+914PhL+Bna8vc6ONpfj/JI01Yv+/Le81qtZaywVDabbnfnWmS6omi6EFa0/XmlRy0Ahl3Cq7w97Lew/yOPRePYhxwlSX2GcpJPiWKiXWYxBOQ+ZnCbRuLzS/JEuOH+XtWKDHg9zG+cvmrKHysZdgIY7h1pwQvme
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 20:58:54.1177 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea0b275-5e7e-476f-5d3d-08df19b57a52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6942
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



On 9/23/2026 Wed 13:05, Lizhi Hou wrote:
> The hardware context scheduler fence is exposed through
> drm_syncobj_add_point(). After a hardware context is destroyed,
> userspace can still call drm_sched_fence_get_timeline_name() on the
> fence through SYNC_IOC_FILE_INFO. This results in a use-after-free
> when accessing fence->sched->name.
> 
> Preallocate hardware context schedulers and free them during device
> teardown instead. A destroyed hardware context no longer frees its
> scheduler, ensuring that the scheduler remains valid while its fences
> are still accessible.
> 
> Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
> Reported-by: Jonghyuk Kim(MalHyuk) <malhyuk97@gmail.com>
> Link: https://lore.kernel.org/dri-devel/20260902012712.880520-1-malhyuk97@gmail.com/
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Max Zhen <max.zhen@amd.com>
> ---
>   drivers/accel/amdxdna/aie2_ctx.c | 117 +++++++++++++++++++++++--------
>   drivers/accel/amdxdna/aie2_pci.c |  15 +++-
>   drivers/accel/amdxdna/aie2_pci.h |   6 +-
>   3 files changed, 105 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
> index 164441e43940..d927c8c9d557 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -7,6 +7,7 @@
>   #include <drm/drm_device.h>
>   #include <drm/drm_gem.h>
>   #include <drm/drm_gem_shmem_helper.h>
> +#include <drm/drm_managed.h>
>   #include <drm/drm_print.h>
>   #include <drm/drm_syncobj.h>
>   #include <linux/hmm.h>
> @@ -99,9 +100,9 @@ static void aie2_job_put(struct amdxdna_sched_job *job)
>   static void aie2_hwctx_stop(struct amdxdna_dev *xdna, struct amdxdna_hwctx *hwctx,
>   			    struct drm_sched_job *bad_job)
>   {
> -	drm_sched_stop(&hwctx->priv->sched, bad_job);
> +	drm_sched_stop(hwctx->priv->sched, bad_job);
>   	aie2_destroy_context(xdna->dev_handle, hwctx);
> -	drm_sched_start(&hwctx->priv->sched, 0);
> +	drm_sched_start(hwctx->priv->sched, 0);
>   }
>   
>   static int aie2_hwctx_restart(struct amdxdna_dev *xdna, struct amdxdna_hwctx *hwctx)
> @@ -659,10 +660,19 @@ static void aie2_ctx_syncobj_destroy(struct amdxdna_hwctx *hwctx)
>   	drm_syncobj_put(hwctx->priv->syncobj);
>   }
>   
> -int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
> +void aie2_hwctx_sched_fini(struct amdxdna_dev_hdl *ndev)
>   {
> -	struct amdxdna_client *client = hwctx->client;
> -	struct amdxdna_dev *xdna = client->xdna;
> +	int i;
> +
> +	for (i = 0; i < ndev->priv->hwctx_limit; i++)
> +		drm_sched_fini(&ndev->hwctx_sched[i]);
> +
> +	ida_destroy(&ndev->hwctx_sched_ida);
> +}
> +
> +int aie2_hwctx_sched_init(struct amdxdna_dev_hdl *ndev)
> +{
> +	struct amdxdna_dev *xdna = ndev->aie.xdna;
>   	const struct drm_sched_init_args args = {
>   		.ops = &sched_ops,
>   		.num_rqs = DRM_SCHED_PRIORITY_COUNT,
> @@ -673,7 +683,55 @@ int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
>   		.name = "amdxdna_js",
>   		.dev = xdna->ddev.dev,
>   	};
> -	struct drm_gpu_scheduler *sched;
> +	int i, ret;
> +
> +	ndev->hwctx_sched = drmm_kcalloc(&xdna->ddev, ndev->priv->hwctx_limit,
> +					 sizeof(*ndev->hwctx_sched), GFP_KERNEL);
> +	if (!ndev->hwctx_sched)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < ndev->priv->hwctx_limit; i++) {
> +		ret = drm_sched_init(&ndev->hwctx_sched[i], &args);
> +		if (ret) {
> +			XDNA_ERR(xdna, "Failed to init DRM scheduler. ret %d", ret);
> +			goto fini_sched;
> +		}
> +	}
> +
> +	ida_init(&ndev->hwctx_sched_ida);
> +
> +	return 0;
> +
> +fini_sched:
> +	while (--i >= 0)
> +		drm_sched_fini(&ndev->hwctx_sched[i]);
> +
> +	return ret;
> +}
> +
> +static struct drm_gpu_scheduler *aie2_hwctx_sched_alloc(struct amdxdna_dev_hdl *ndev)
> +{
> +	int ret;
> +
> +	ret = ida_alloc_range(&ndev->hwctx_sched_ida, 0,
> +			      ndev->priv->hwctx_limit - 1, GFP_KERNEL);
> +	if (ret < 0)
> +		return ERR_PTR(ret);
> +
> +	return &ndev->hwctx_sched[ret];
> +}
> +
> +static void aie2_hwctx_sched_free(struct amdxdna_dev_hdl *ndev,
> +				  struct drm_gpu_scheduler *sched)
> +{
> +	ida_free(&ndev->hwctx_sched_ida, sched - ndev->hwctx_sched);
> +}
> +
> +int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
> +{
> +	struct amdxdna_client *client = hwctx->client;
> +	struct amdxdna_dev *xdna = client->xdna;
> +	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
>   	struct amdxdna_hwctx_priv *priv;
>   	struct amdxdna_gem_obj *heap;
>   	int i, ret;
> @@ -683,13 +741,26 @@ int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
>   		return -ENOMEM;
>   	hwctx->priv = priv;
>   
> +	priv->sched = aie2_hwctx_sched_alloc(ndev);
> +	if (IS_ERR(priv->sched)) {
> +		ret = PTR_ERR(priv->sched);
> +		goto free_priv;
> +	}
> +
> +	ret = drm_sched_entity_init(&priv->entity, DRM_SCHED_PRIORITY_NORMAL,
> +				    &priv->sched, 1, NULL);
> +	if (ret) {
> +		XDNA_ERR(xdna, "Failed to initial sched entity. ret %d", ret);
> +		goto free_sched;
> +	}
> +
>   	mutex_lock(&client->mm_lock);
>   	heap = xa_load(&client->dev_heap_xa, 0);
>   	if (!heap) {
>   		XDNA_ERR(xdna, "The client dev heap object not exist");
>   		mutex_unlock(&client->mm_lock);
>   		ret = -ENOENT;
> -		goto free_priv;
> +		goto free_entity;
>   	}
>   	drm_gem_object_get(to_gobj(heap));
>   	mutex_unlock(&client->mm_lock);
> @@ -722,30 +793,16 @@ int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
>   		priv->cmd_buf[i] = abo;
>   	}
>   
> -	sched = &priv->sched;
>   	mutex_init(&priv->io_lock);
>   
>   	fs_reclaim_acquire(GFP_KERNEL);
>   	might_lock(&priv->io_lock);
>   	fs_reclaim_release(GFP_KERNEL);
>   
> -	ret = drm_sched_init(sched, &args);
> -	if (ret) {
> -		XDNA_ERR(xdna, "Failed to init DRM scheduler. ret %d", ret);
> -		goto free_cmd_bufs;
> -	}
> -
> -	ret = drm_sched_entity_init(&priv->entity, DRM_SCHED_PRIORITY_NORMAL,
> -				    &sched, 1, NULL);
> -	if (ret) {
> -		XDNA_ERR(xdna, "Failed to initial sched entiry. ret %d", ret);
> -		goto free_sched;
> -	}
> -
>   	ret = aie2_hwctx_col_list(hwctx);
>   	if (ret) {
>   		XDNA_ERR(xdna, "Create col list failed, ret %d", ret);
> -		goto free_entity;
> +		goto free_cmd_bufs;
>   	}
>   
>   	ret = amdxdna_pm_resume_get_locked(xdna);
> @@ -791,10 +848,6 @@ int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
>   	amdxdna_pm_suspend_put(xdna);
>   free_col_list:
>   	kfree(hwctx->col_list);
> -free_entity:
> -	drm_sched_entity_destroy(&priv->entity);
> -free_sched:
> -	drm_sched_fini(&priv->sched);
>   free_cmd_bufs:
>   	for (i = 0; i < ARRAY_SIZE(priv->cmd_buf); i++) {
>   		if (!priv->cmd_buf[i])
> @@ -805,6 +858,10 @@ int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
>   	amdxdna_gem_unpin(heap);
>   put_heap:
>   	drm_gem_object_put(to_gobj(heap));
> +free_entity:
> +	drm_sched_entity_destroy(&priv->entity);
> +free_sched:
> +	aie2_hwctx_sched_free(ndev, priv->sched);
>   free_priv:
>   	kfree(priv);
>   	return ret;
> @@ -812,18 +869,20 @@ int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
>   
>   void aie2_hwctx_fini(struct amdxdna_hwctx *hwctx)
>   {
> +	struct amdxdna_dev_hdl *ndev;
>   	struct amdxdna_dev *xdna;
>   	int idx;
>   
>   	xdna = hwctx->client->xdna;
> +	ndev = xdna->dev_handle;
>   
>   	XDNA_DBG(xdna, "%s sequence number %lld", hwctx->name, hwctx->priv->seq);
>   	aie2_hwctx_wait_for_idle(hwctx);
>   
>   	/* Request fw to destroy hwctx and cancel the rest pending requests */
> -	drm_sched_stop(&hwctx->priv->sched, NULL);
> +	drm_sched_stop(hwctx->priv->sched, NULL);
>   	aie2_release_resource(hwctx);
> -	drm_sched_start(&hwctx->priv->sched, 0);
> +	drm_sched_start(hwctx->priv->sched, 0);
>   
>   	mutex_unlock(&xdna->dev_lock);
>   	drm_sched_entity_destroy(&hwctx->priv->entity);
> @@ -834,7 +893,7 @@ void aie2_hwctx_fini(struct amdxdna_hwctx *hwctx)
>   		   atomic64_read(&hwctx->job_free_cnt));
>   	mutex_lock(&xdna->dev_lock);
>   
> -	drm_sched_fini(&hwctx->priv->sched);
> +	aie2_hwctx_sched_free(ndev, hwctx->priv->sched);
>   	aie2_ctx_syncobj_destroy(hwctx);
>   
>   	for (idx = 0; idx < ARRAY_SIZE(hwctx->priv->cmd_buf); idx++) {
> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
> index daec1f6b4907..7a4314ca843b 100644
> --- a/drivers/accel/amdxdna/aie2_pci.c
> +++ b/drivers/accel/amdxdna/aie2_pci.c
> @@ -503,10 +503,16 @@ static int aie2_init(struct amdxdna_dev *xdna)
>   	ndev->priv = xdna->dev_info->dev_priv;
>   	ndev->aie.xdna = xdna;
>   
> +	ret = aie2_hwctx_sched_init(ndev);
> +	if (ret)
> +		return ret;
> +
>   	for (i = 0; i < ARRAY_SIZE(npu_fw); i++) {
>   		fw_full_path = kasprintf(GFP_KERNEL, "%s%s", ndev->priv->fw_path, npu_fw[i]);
> -		if (!fw_full_path)
> -			return -ENOMEM;
> +		if (!fw_full_path) {
> +			ret = -ENOMEM;
> +			goto free_hwctx_sched;
> +		}
>   
>   		ret = firmware_request_nowarn(&fw, fw_full_path, &pdev->dev);
>   		kfree(fw_full_path);
> @@ -519,7 +525,7 @@ static int aie2_init(struct amdxdna_dev *xdna)
>   	if (ret) {
>   		XDNA_ERR(xdna, "failed to request_firmware %s, ret %d",
>   			 ndev->priv->fw_path, ret);
> -		return ret;
> +		goto free_hwctx_sched;
>   	}
>   
>   	ret = pcim_enable_device(pdev);
> @@ -623,6 +629,8 @@ static int aie2_init(struct amdxdna_dev *xdna)
>   	aie2_hw_stop(xdna);
>   release_fw:
>   	release_firmware(fw);
> +free_hwctx_sched:
> +	aie2_hwctx_sched_fini(ndev);
>   
>   	return ret;
>   }
> @@ -631,6 +639,7 @@ static void aie2_fini(struct amdxdna_dev *xdna)
>   {
>   	amdxdna_pm_fini(xdna);
>   	aie2_hw_stop(xdna);
> +	aie2_hwctx_sched_fini(xdna->dev_handle);
>   }
>   
>   static int aie2_get_aie_status(struct amdxdna_client *client,
> diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
> index ea1dac106400..2c7019bd26b5 100644
> --- a/drivers/accel/amdxdna/aie2_pci.h
> +++ b/drivers/accel/amdxdna/aie2_pci.h
> @@ -107,7 +107,7 @@ struct amdxdna_hwctx_priv {
>   	struct amdxdna_gem_obj		*heap;
>   	void				*mbox_chann;
>   
> -	struct drm_gpu_scheduler	sched;
> +	struct drm_gpu_scheduler	*sched;
>   	struct drm_sched_entity		entity;
>   
>   	struct mutex			io_lock; /* protect seq and cmd order */
> @@ -152,6 +152,8 @@ struct amdxdna_dev_hdl {
>   	u32				total_col;
>   	struct amdxdna_drm_query_aie_version version;
>   	struct aie2_exec_msg_ops	*exec_msg_ops;
> +	struct drm_gpu_scheduler	*hwctx_sched;
> +	struct ida			hwctx_sched_ida;
>   
>   	/* power management and clock*/
>   	enum amdxdna_power_mode_type	pw_mode;
> @@ -294,6 +296,8 @@ int aie2_update_prop_time_quota(struct amdxdna_dev_hdl *ndev, u32 us);
>   /* aie2_hwctx.c */
>   int aie2_hwctx_init(struct amdxdna_hwctx *hwctx);
>   void aie2_hwctx_fini(struct amdxdna_hwctx *hwctx);
> +int aie2_hwctx_sched_init(struct amdxdna_dev_hdl *ndev);
> +void aie2_hwctx_sched_fini(struct amdxdna_dev_hdl *ndev);
>   int aie2_hwctx_config(struct amdxdna_hwctx *hwctx, u32 type, u64 value, void *buf, u32 size);
>   int aie2_hwctx_sync_debug_bo(struct amdxdna_hwctx *hwctx, u32 debug_bo_hdl);
>   void aie2_hwctx_suspend(struct amdxdna_client *client);

