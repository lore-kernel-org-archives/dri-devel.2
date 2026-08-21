Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A61C5DF7D
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 19:49:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1663710E20B;
	Fri, 21 Aug 2026 19:49:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BC988adE";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013061.outbound.protection.outlook.com
 [40.93.196.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE5B110E20B
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 19:49:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O/FSVD0Pw1KuxT5mQSv1iEr4Zq+T/MuoFj8sly2vNDXMAnLgJFDqjpjn14wseoGjXlMtUNdFHQ+RpH/t8qbtG1IOQYpi7pqj8XyqD/fxAE/CA1hZTgG6HtPlu2uPoq+iWGE1POKzheyt1gtVV11D5Qljn/8/PFKTyFFJJBxAjF5Lh2YAlvP1TXauhTLoA/ZAx/cJJXxsim446GRMQFyMBhezFtZjK1oabzwhtKwOS41wF+0gzslGbOQMZxN5HWoD1pkfAd61wDPJ125tNvi54p77ei2cIyb78GcG8lXd+AI35VYGy7JcGoOYqLXtjhFsCY9mh8+EomRFKjKp3fvYKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIcdbOdKADXM9adLrBZZ83AUjj+8/aJaslLq+lmJq5Y=;
 b=g8e1C1j2RU1WFK993XtEb/Sr6uQigpR6whw08kN4DQB9Jz/TNNar+EddT4uOnOcy+9Ooq7inj0lsliVgiqtz7btdgySD63cBEqS4XW7rs7zPeabOBlNIiCJQz5oKMwVGBbx6nAsWi6NvxPac0EFpOiHxq9Y4BJjBxuqtiV+ghy1gtfFRA/62bNEeOkyhua36MUysLfE2fZ6UoEn4eFsvlOmuHTU+nAGHQXrUzrSiq5jjTKEYvnFzrjk/xMjmvvrzVC2UuZsJLhC3ie6vQxmmygk0BeUeHQhoIsxwhgwwZRPlj+aNfzYODmfYsX7xxPsQ5AQBq+q2PC4JJkrFcl4mxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIcdbOdKADXM9adLrBZZ83AUjj+8/aJaslLq+lmJq5Y=;
 b=BC988adEBDDRKQDmri0OaDezneu+8McG1suA9f03wMFZd6EbJvV7JEfhgVXui2r0pg48N1r0yf2/lt7QVSiUPwr9QnCbTnms5Aa0mWynU1boMV8oUcQ98yMzwJzmMYDUZZMmBM3dPykY+UV1bHX2sUzUl7hefxmiK9dZDK9/WG0=
Received: from BL1P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::26)
 by PH7PR12MB7257.namprd12.prod.outlook.com (2603:10b6:510:205::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 17:50:30 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:2c7:cafe::17) by BL1P222CA0021.outlook.office365.com
 (2603:10b6:208:2c7::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 17:50:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 17:50:29 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 12:50:29 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 12:50:29 -0500
Received: from [172.19.69.26] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 12:50:28 -0500
Message-ID: <4f0522e1-283f-4153-bbf7-2fa2c8b25b27@amd.com>
Date: Fri, 21 Aug 2026 10:50:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] accel/amdxdna: Fix unexpected wait when flushing
 notifier_wq
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20260813205016.941743-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Max Zhen <max.zhen@amd.com>
In-Reply-To: <20260813205016.941743-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|PH7PR12MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: c7004b70-e064-4b28-78f7-08deffacb0d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: BsoGJJ3koE9ZWK69ccMVnZQiEBkyVFkP1t1DbW+bjMMDBLgfZ0L3o98Gnf/S2x+uJnosGrgpzfJWxnsK64B85TYkfadZ1lZHjAsBq2/mv55yh2pmVgcXYf5VDouR7zYBa6SSlDVExCmaTUJ3LjGO70EnSBM8JEKYnEBulZpVYxmtnoNUujSLNDVKIBq/2wnFESwPmMbOAX9bn9xeWbFjrjIvvnoGS67M/bRu8O3gfT9xGCNY7eOd+0zW+OfccAV7MYQOho0Vnp2Lhs4feTg+cfGhilQsJtdNbLpikJva1KWSO2x+e/YwgNHKOG2G7cjcUW6xSXjSM6SwWA04VcyqrfOeJUdYoHMwWLPq0c2DLmy0V76eMSpibwl/cAlpWB3WLBM26CZgEMQFYuLk+jSzvuk9+dBvIn001o4fWLQX7RtHG5X8ouCq7TmiOBWaEh0d5XT5xgZ7H2pnvM803Tw4g3WW7ZqSuPKrzzlS1GBIj9gaLw4ghn/XPnIIJ+AIzt8oOVgU9ZSgvx+IF9H4er33wqwKxovRNDW2s0/MYRX2EFrcvFvn7sVRIOuIq6AxF3QfsU6DdTOIUcwtthu3tmXFuKAaDdXDoDk4AAVC/VK+8/o66sD4ta1pwgy90UgY2AEnWgd+oEjYx7sAbjYouz/eszw9ZCEi8R6O0bJRMvlB8MSgeQI17zNeX2PRzpYokFnLxfj35GLoqILx99tmvMXK7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kJWMEwd4QLSU4ndMuDWnhZk06xEYSSogw9cvSCMwBxWo+bKmBGIjdqceK7ou58JeiFCAiUSUwJxNwZjsAW0XQDSl+RVB4Z+u/N+YB+33uUIgNHVQoyiV5Q0ibBlKDBxJP8SbLFbGwPStZzzPiIE7fPScl6A1P6jFNElLPGS8a81WT0bmEodnXKhzUrTDKM1Lr6t8CdrcTMoorQZugoicyfebtHy18V64tM3WnSTOSs6/wiRlQrkvgQvm9LXfCf2b9iUAGIa547TJzo9SWz4KH6J0toIL/XvMquzYctD0pKCb+gHaVhZy3OZ3oOqsK2R7LVw6r4bMQlPbMH90pY53its3VGUQgewCx6sP3y6EPiR431pvDFJUPsYbRIpfVZYc/rcC+J8wbT0cJG+5z6yt1Zj1shtpdnBYbhisjSYxztXbbFzhK/26a8WviRy2H0Je
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 17:50:29.9042 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7004b70-e064-4b28-78f7-08deffacb0d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7257
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



On 8/13/2026 Thu 13:50, Lizhi Hou wrote:
> In amdxdna_gem_obj_free(), flush_workqueue(xdna->notifier_wq) waits for
> all pending work items on the device-global notifier workqueue, rather
> than only the work items associated with the BO being freed.
> 
> If another BO has a pending hmm_unreg_work, freeing an unrelated BO can
> be unnecessarily blocked until that work completes.
> 
> mmu_interval_notifier_remove() is deferred to a workqueue because it
> cannot be called from the MMU notifier callback itself. The BO free path
> is not a notifier callback, so call mmu_interval_notifier_remove()
> directly there and avoid the workqueue.
> 
> Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Max Zhen <max.zhen@amd.com>
> ---
> V2:
>    Fix sashiko comment.
> 
>   drivers/accel/amdxdna/amdxdna_gem.c | 69 +++++++++++++++++++----------
>   drivers/accel/amdxdna/amdxdna_gem.h |  1 +
>   2 files changed, 47 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index 1c63eff0a4a8..1c17122d1327 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -253,13 +253,16 @@ static bool amdxdna_hmm_invalidate(struct mmu_interval_notifier *mni,
>   	struct amdxdna_gem_obj *abo = mapp->abo;
>   	struct amdxdna_dev *xdna;
>   
> +	if (!mmu_notifier_range_blockable(range))
> +		return false;
> +
> +	if (mapp->unmapped)
> +		return true;
> +
>   	xdna = to_xdna_dev(to_gobj(abo)->dev);
>   	XDNA_DBG(xdna, "Invalidating range 0x%lx, 0x%lx, type %d",
>   		 mapp->range.start, mapp->range.end, abo->type);
>   
> -	if (!mmu_notifier_range_blockable(range))
> -		return false;
> -
>   	down_write(&xdna->notifier_lock);
>   	abo->mem.map_invalid = true;
>   	mapp->invalid = true;
> @@ -301,33 +304,40 @@ static void amdxdna_hmm_unregister(struct amdxdna_gem_obj *abo,
>   
>   	down_write(&xdna->notifier_lock);
>   	list_for_each_entry(mapp, &abo->mem.umap_list, node) {
> -		if (!vma || compare_range(mapp, vma->vm_mm, vma->vm_start, vma->vm_end)) {
> -			if (!mapp->unmapped) {
> -				queue_work(xdna->notifier_wq, &mapp->hmm_unreg_work);
> -				mapp->unmapped = true;
> -			}
> -			if (vma)
> -				break;
> -		}
> +		if (!compare_range(mapp, vma->vm_mm, vma->vm_start, vma->vm_end))
> +			continue;
> +
> +		queue_work(xdna->notifier_wq, &mapp->hmm_unreg_work);
> +		mapp->unmapped = true;
>   	}
>   	up_write(&xdna->notifier_lock);
>   }
>   
> -static void amdxdna_umap_release(struct kref *ref)
> +static void amdxdna_hmm_unregister_all(struct amdxdna_gem_obj *abo)
>   {
> -	struct amdxdna_umap *mapp = container_of(ref, struct amdxdna_umap, refcnt);
> -	struct amdxdna_gem_obj *abo = mapp->abo;
> -	struct amdxdna_dev *xdna;
> -
> -	mmu_interval_notifier_remove(&mapp->notifier);
> +	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
> +	struct amdxdna_umap *mapp, *tmp;
> +	LIST_HEAD(dead);
>   
> -	xdna = to_xdna_dev(to_gobj(mapp->abo)->dev);
>   	down_write(&xdna->notifier_lock);
> -	list_del(&mapp->node);
> -	if (list_empty(&abo->mem.umap_list))
> -		abo->mem.uva = AMDXDNA_INVALID_ADDR;
> +	list_for_each_entry_safe(mapp, tmp, &abo->mem.umap_list, node) {
> +		mapp->unmapped = true;
> +		mapp->cleanup = true;
> +		list_move(&mapp->node, &dead);
> +	}
>   	up_write(&xdna->notifier_lock);
>   
> +	list_for_each_entry_safe(mapp, tmp, &dead, node) {
> +		cancel_work_sync(&mapp->hmm_unreg_work);
> +		amdxdna_umap_put(mapp);
> +	}
> +}
> +
> +static void amdxdna_umap_release(struct kref *ref)
> +{
> +	struct amdxdna_umap *mapp = container_of(ref, struct amdxdna_umap, refcnt);
> +
> +	mmu_interval_notifier_remove(&mapp->notifier);
>   	kvfree(mapp->range.hmm_pfns);
>   	kfree(mapp);
>   }
> @@ -341,6 +351,20 @@ static void amdxdna_hmm_unreg_work(struct work_struct *work)
>   {
>   	struct amdxdna_umap *mapp = container_of(work, struct amdxdna_umap,
>   						 hmm_unreg_work);
> +	struct amdxdna_gem_obj *abo = mapp->abo;
> +	struct amdxdna_dev *xdna;
> +
> +	xdna = to_xdna_dev(to_gobj(mapp->abo)->dev);
> +	down_write(&xdna->notifier_lock);
> +	if (mapp->cleanup) {
> +		up_write(&xdna->notifier_lock);
> +		return;
> +	}
> +
> +	list_del(&mapp->node);
> +	if (list_empty(&abo->mem.umap_list))
> +		abo->mem.uva = AMDXDNA_INVALID_ADDR;
> +	up_write(&xdna->notifier_lock);
>   
>   	amdxdna_umap_put(mapp);
>   }
> @@ -643,8 +667,7 @@ static void amdxdna_gem_obj_free(struct drm_gem_object *gobj)
>   	struct amdxdna_dev *xdna = to_xdna_dev(gobj->dev);
>   	struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
>   
> -	amdxdna_hmm_unregister(abo, NULL);
> -	flush_workqueue(xdna->notifier_wq);
> +	amdxdna_hmm_unregister_all(abo);
>   
>   	if (abo->pinned)
>   		amdxdna_gem_unpin(abo);
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.h b/drivers/accel/amdxdna/amdxdna_gem.h
> index 1e90e32bf3cd..fb033ced1045 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.h
> +++ b/drivers/accel/amdxdna/amdxdna_gem.h
> @@ -20,6 +20,7 @@ struct amdxdna_umap {
>   	struct kref			refcnt;
>   	bool				invalid;
>   	bool				unmapped;
> +	bool				cleanup;
>   };
>   
>   struct amdxdna_mem {

