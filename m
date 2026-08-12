Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF3DC5CFDB
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 23:12:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7220389B46;
	Wed, 12 Aug 2026 23:12:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r3483Yp2";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012069.outbound.protection.outlook.com [52.101.48.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D367389B46
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 23:12:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8KxQGJ6DQywUsuDp+LO5l3s6VhgTgyJgGdCusih7+IzG5lBkQhmBT0/KlXQyrFdWHaXiY7/5bVcwRKveaRAE5utVcuXtGoCv77IHD/w5acW/sMG7thydvom6iawEgNjlRf4icTG4tfR4Qdsn/xqkz9DNGuHF8G+YQNNIghia6PhMvF1ibzlIqF6xscRtgQG+LpYIGQbY+M0gVVzO29FTUAxgwGcafsudn7Dh/cORoMQ2Selmha0Y9rpS8PMWDlGhNcON6Qb91K15aF3sLa9kkONWr4HI5Qa7ZFURVEomkv4No0X7/urUjrjtn0zSdW3kWZznolcxXO8asghOkHnkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+mrYGpe+SzmeyL48yFMZV3gtIdh072I87lKh/1MavM=;
 b=Se+yqzopjmMzfM9/Cyuns9ejDJm9ZG0HRQFwkdr6ybBcvZaXCxc3m3JSpicWArkT6P7KT0ZCgi3TJeZ0Gbt5Zre29xoHFwYTkiJtFYzizutT+vd5SROSaJRyaJh+9qkiMMLFXGKMunht1i+NWMjDU8PNY4In8AsfgIZoq8QMZzASsDQO8Q+J4TJP/GmF2hQORJwcYbG3qc1EY4d1HYBfL87kPaqtFxZ/APRncpsNIQ3rOGxkEhzcDX5y3vjGgpP0G0c9MocH41N8byNo66rtvm++hRcnjDCMXXId5Yq1hUwkxkro3w5cC8WK/hSK4UmTmOQwgohfP4OBXhCURWkcew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+mrYGpe+SzmeyL48yFMZV3gtIdh072I87lKh/1MavM=;
 b=r3483Yp20gFcyXyKyPuMQCyNYQsBSv6K+kQbN+vUcRlP9uBYi8s6hkxqKfUpkZvEOyTNW9JHedGlkI3ifrtv/O6kpGTyON+jDh4yBafEg/YgvEd99s2/VEJMYCWjIEgusXA+LwW3yRpbGsyAUrFwJ+4ApmIwg+rUDYwLMIDSO4w=
Received: from SA0PR11CA0068.namprd11.prod.outlook.com (2603:10b6:806:d2::13)
 by PH7PR12MB5901.namprd12.prod.outlook.com (2603:10b6:510:1d5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 23:12:20 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:d2:cafe::80) by SA0PR11CA0068.outlook.office365.com
 (2603:10b6:806:d2::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Wed,
 12 Aug 2026 23:12:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Wed, 12 Aug 2026 23:12:19 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 18:12:19 -0500
Received: from [172.19.68.47] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Wed, 12 Aug 2026 18:12:18 -0500
Message-ID: <eac16341-1a1c-40b7-a2bd-e6e60cc31300@amd.com>
Date: Wed, 12 Aug 2026 16:12:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Fix unexpected wait when flushing
 notifier_wq
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20260812214403.817307-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Max Zhen <max.zhen@amd.com>
In-Reply-To: <20260812214403.817307-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|PH7PR12MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: a0cd5498-fb7d-46b9-1ee4-08def8c7289a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: nLeQiSUu+V7xhSDZAUEDtJNv64WE8dsxcDj7ToU/o6JwQ16m6MZPRCgo0WO4ZGSY9sN++UTbtzPVykb96iy66qoDQPlekB5XLfuhLJAhY6gjwthRoYTgEW5/wZp7uKiZ13CKey/OESFqZWCLUDHKZJN6y/xWxIXodT5aiIY/QO07lKUG8Ca+t+0g1UONvMrxOgsO7OecBZo8DEf7RyObnaKg2PO3rKe3uNYRZVFZsR/TdXjf3lYSTbDWjONg3awyjBglIcCFwa2LNOBiixWw9N8uR8/p5qhnv1E9z4/NUiEuGZH+kDMkJRWPP2Cj5E1ho6aXuXivmhjxC3GAMI35aNLzPGqqieJPKW7d9bDa/2PvKCmp2HOqfCA9rrxoH619uH4to0RlpdziG5CqbDf3n5NYRMspUqsVaXHXSDN7A6Ys5kkSzCWQ4c2Z81Dq7H/ktdoW3WGu5QBgSD0Em54OBmZXL7hcivFQbt+blvdMgOtGeGmCrjE1+AzZMGMsZrDAEAi8Sr9Be6VTtyZS51DymznBQ4UUhCQGTvMHn0cGpkNWZmgkncFW4nq9ezkvn5ooR+KBJeiTIkbAX/+d2YdLc+XYtDpvct/JgHYsOOjxDw6lT7vtRH2N+O1poGzbvmPcq0g1lOgjejoii2/CCaDf4xCg/XY8MWxcwvDfP6h8eRKsUIplkHibrwRWPBUHy7ZuYWYmxwIHwXwSQpQuVXxBTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EtqZCla3IpHBCx8wMk2rkFnNv1OmVP/dJIcS6ynop/bJ6y8Vsl1f5lrbMlQjSOa8SBQP0wRz9zNVvl4ZRc8jAVJVvg/Wks0+5um41O+BLCXyrllTbFyLgOetqwrIenUmN/1c61X71nQwRTNU7Oei8ZWZyRMXqeGyP3htjHp4xJomi+AZI+DAlZ5Q4TGZB9QiFYmwHwE4BzAFFqs2E8q5DZlOyNrxU3OW+fJyN5zdgf1eqkn4Ad3qlLGt3pyL3TqXBnBQJVcX/oEHDcNnRrHTkq89F9+QaEpn7jn/tZKyck3yghUBCoirThrP0Gu1qbJ59qtwCODXA50rDFo58VWhc6N7FMdgz9zUBfAriTokX3pLwGURCtIGEqbsGkPtQFvDraxE+ZOmE9wnwk/WdEamW0+9wa35boij/Ol/SZLqF/hjo7nmG/Qc7rZphjNaCMBT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 23:12:19.6194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0cd5498-fb7d-46b9-1ee4-08def8c7289a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5901
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



On 8/12/2026 Wed 14:44, Lizhi Hou wrote:
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
>   drivers/accel/amdxdna/amdxdna_gem.c | 60 +++++++++++++++++++----------
>   drivers/accel/amdxdna/amdxdna_gem.h |  1 +
>   2 files changed, 41 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index 1c63eff0a4a8..d6aa862e2d5b 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -301,33 +301,40 @@ static void amdxdna_hmm_unregister(struct amdxdna_gem_obj *abo,
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
> @@ -341,6 +348,20 @@ static void amdxdna_hmm_unreg_work(struct work_struct *work)
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
> @@ -643,8 +664,7 @@ static void amdxdna_gem_obj_free(struct drm_gem_object *gobj)
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

