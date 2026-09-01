Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E78C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 16:31:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1320010ED97;
	Tue,  1 Sep 2026 16:31:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d9Nmr7Nv";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010037.outbound.protection.outlook.com [52.101.61.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CE3810ED97
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 16:31:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vhnjQb17HIXEcnPjY89y2pIHcyh1j/UP26aSyMhlkcojDFzKvXiuNtW5+EvEyHk+PUwE+nJY6cNadlmrTAFGr7FIxfHDkFuNjmaNKiGnulSHi4IObojg5OjV3ntdZnm5QC32pO6jYNNUUwuQqnnNmZ59PQhrwx653TTKBESfBduaLZlRmJVCnH9lVyizRcIUnHeLGVmcruWIl/h3W8DKnnxEE07DqRMCFkdiAmtUMjQ1ZkooWYa8OXRHCm8/0cbFBGCNiTq+53N/ml/YdXbGk24WZCEf+yNfdfipyrWvzJwy5Tkvkc89CoCllTf3jc4Xk5RDlyByyhDADtahty1b7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXWpDtRV/I0lL+Q9CIcvM/RA6xOfYN1//HfCyJoRaZY=;
 b=IZJnsUk+kDwQG62wpYJCzQOG+mnAZiOPY3IoBMKQZe92+b2/hL7GpAu9TlnNVggrEljlj7pyhAoLZDeidQ/fvnGTw5zV5QcpPAt8fYXIXaA+u2f35mXDOLEvMvRSRanRgkXQPoJWqdSmUDLrbTKlN0q+EV1F8a8kBhD/zRKw4cAJMUOlar00SwTPvyrZbZ1r7htxYHerI09tPtD56j/asqmcN+809om9+EjzR0wExS6bweG0KOYjg0PkwT16B+wISWvjVaa7iGp9C4acXKHdXeqAKcuvLsFSzBOntaNVioOlRxBD79dr7n81SwlIsWt75ECJsy0yw9aQxGhRdNX+Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXWpDtRV/I0lL+Q9CIcvM/RA6xOfYN1//HfCyJoRaZY=;
 b=d9Nmr7NvdEvFlklK+fIJpbe3NjhS2Aw4pVMTrw/CW7BxQm/i/t505Yq7zY/vzS/Bp5g52xJWJi0cliWnebVrd3hxo/naz2//Vnhi3YxJS/zkEOJHEXWBPJJVjKOvu8Bb1l2enUbhZ2VOsvH/GROeyvL6uH+9WV5knJe+NUNzzLw=
Received: from BN0PR04CA0163.namprd04.prod.outlook.com (2603:10b6:408:eb::18)
 by BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 16:31:50 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:408:eb:cafe::58) by BN0PR04CA0163.outlook.office365.com
 (2603:10b6:408:eb::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 16:31:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 16:31:49 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 11:31:49 -0500
Received: from [172.19.68.62] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 11:31:48 -0500
Message-ID: <d458136e-624b-40e3-9d21-779dff8e42b9@amd.com>
Date: Tue, 1 Sep 2026 09:31:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Fix possible use-after-free when
 freeing device BO
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20260901160129.3812405-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Max Zhen <max.zhen@amd.com>
In-Reply-To: <20260901160129.3812405-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|BL4PR12MB9482:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e06fa5a-9e01-4f1c-26ec-08df084685f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: WVR9xmdcjibjE0S9Q4xhwikuOBWhRYU1mURlojQM5biaWLT7XywJPY7vvuckgxusGX2Ev56iu/VVxZqoUuP6UKdFepxAdcJCOrSswGVV2B5ck4ojbFPZLI77u3ig9Z0lR2rs6DjW9odRTBMnq/EXjoMbpmFUcNSx4y+eN8BivzTt65VFL6V5hdGwv9pw59ZH+nVRbG52d4dRASw9is36WSIHu7DRkwa1SnomrU3J03t72gWT9eweZoGg1LXwtKHLS/z4S0vKxevtv0iV/cLT2UiNGHf/8jXbV0UMVy/wcDXYAv99Nngi5ifgo5LGpq15zQYmiILkEpE1ti4i3aCbWKYId4c998/yhlKmhMZ7ffI7JwAjRZVE4cUsXqlhjIw6AItyp5O8EoJtIzPSKvY1trR88/WlTXM5XXFvc4myh+D5m/Ye31ABRm02DSF4BOU/e5tpthxcr2i+AlzS3iGhS+SNfM+qdn/if/6dvi1HCw/SsKf0HXG4aUzJiTmlnl8+SmNHaJ1ofZk2SadA7pkufRTN+6t5eLwGccSB5O93XM0/V4+BeHHuOYpJpGy95CYtM1GKhc01Z40uzYfrw3ZEiPuCd0PiLIi0unz/wAlcRlRhZRk+WUpB2w8p97H4vbjam65PqR+23vTFlbo0L3z+rBuT115u4QqXnx76WTZ+TmBdP63QIyIhtLZyg5irsyo7C4EH1pCop6c86nw9/O1JQA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BByQUgJ/VaPkV2DzS6ZEOIzSXkjIgZ4lP7KDdelgE5Rqxq+aab1/Dor9OlXeqQ4ZPOouZB1K3gBz4FICuK2WnfjAV7VGV3mGKVt/nZ+v1kvwQrs4Xq/VF6fvem4IUABPXhV3SXdcm+WX4tdNBUkl78H7aX/kmJ647gG40Y1Q65Q5TjpJxA5U5PaAV0/D+9EhGRn2cBFJdG5Y9CAqU8UroYQ6SZ7Pv9UGBS3qdODCmoKd9RqCZN33+WQQbVUZNtPNlr6/1AvQHiMKm/Y9zjIW+CBDRQxd2kSaElnRMjeBe3/7UGXhF4I6wme+P1xDDfDAofNaWTthDDkQFtXUBCP7+m+/tkoG+ct80dDTgfbb9ARCG36kvsvG/U7qrJ/1zd0mlYB+Mpo2qHstaLN+kLyYfLvwlbYAyYsfBIbuj1WvCd+kFs1yinVV/Dnmpmoj+qhF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 16:31:49.7402 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e06fa5a-9e01-4f1c-26ec-08df084685f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9482
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



On 9/1/2026 Tue 09:01, Lizhi Hou wrote:
> When the DRM file descriptor is closed, amdxdna_client_cleanup() frees
> the client structure. If device BOs are still alive, freeing them may
> access abo->client and result in a use-after-free.
> 
> Move amdxdna_gem_heap_free(), which accesses abo->client, before clearing
> abo->client in the BO close callback. Also track the heap BOs referenced
> by device BOs so they can be accessed without dereferencing abo->client.
> 
> Fixes: dbc8fd7a03cb ("accel/amdxdna: Add expandable device heap
> support")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Max Zhen <max.zhen@amd.com>
> ---
>   drivers/accel/amdxdna/aie2_ctx.c    |   9 +-
>   drivers/accel/amdxdna/amdxdna_gem.c | 128 ++++++++++++++++++++--------
>   drivers/accel/amdxdna/amdxdna_gem.h |   4 +-
>   3 files changed, 104 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
> index baf9a8b90a4d..164441e43940 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -799,6 +799,7 @@ int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
>   	for (i = 0; i < ARRAY_SIZE(priv->cmd_buf); i++) {
>   		if (!priv->cmd_buf[i])
>   			continue;
> +		amdxdna_gem_heap_free(client, priv->cmd_buf[i]);
>   		drm_gem_object_put(to_gobj(priv->cmd_buf[i]));
>   	}
>   	amdxdna_gem_unpin(heap);
> @@ -836,8 +837,14 @@ void aie2_hwctx_fini(struct amdxdna_hwctx *hwctx)
>   	drm_sched_fini(&hwctx->priv->sched);
>   	aie2_ctx_syncobj_destroy(hwctx);
>   
> -	for (idx = 0; idx < ARRAY_SIZE(hwctx->priv->cmd_buf); idx++)
> +	for (idx = 0; idx < ARRAY_SIZE(hwctx->priv->cmd_buf); idx++) {
> +		/*
> +		 * The open/close will never be called for driver allocated
> +		 * dev bo. Call amdxdna_gem_heap_free explicitly.
> +		 */
> +		amdxdna_gem_heap_free(hwctx->client, hwctx->priv->cmd_buf[idx]);
>   		drm_gem_object_put(to_gobj(hwctx->priv->cmd_buf[idx]));
> +	}
>   	amdxdna_gem_unpin(hwctx->priv->heap);
>   	drm_gem_object_put(to_gobj(hwctx->priv->heap));
>   
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index b089ee76b647..476649685e5a 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -37,6 +37,7 @@ amdxdna_init_dev_bo(struct amdxdna_gem_obj *dev_bo)
>   	struct amdxdna_gem_obj *heap;
>   	u64 heap_addr, exp_heap_uva;
>   	u32 heap_id;
> +	int ret;
>   
>   	if (xa_empty(&client->dev_heap_xa)) {
>   		XDNA_DBG(xdna, "Empty heap xa");
> @@ -58,24 +59,32 @@ amdxdna_init_dev_bo(struct amdxdna_gem_obj *dev_bo)
>   	heap = xa_load(&client->dev_heap_xa, heap_id);
>   	exp_heap_uva = amdxdna_gem_uva(heap);
>   	heap_addr = amdxdna_gem_dev_addr(heap);
> -	dev_bo->heap_start_id = heap_id;
>   	dev_bo->mem.uva = dev_bo->mm_node.start - heap_addr + exp_heap_uva;
>   
>   	for (; heap_id < client->dev_heap_nid; heap_id++) {
>   		heap = xa_load(&client->dev_heap_xa, heap_id);
>   		if (!heap) {
>   			XDNA_ERR(xdna, "Failed to load heap %d", heap_id);
> -			return -EINVAL;
> +			ret = -EINVAL;
> +			goto cleanup_heap_xa;
>   		}
>   		heap_addr = amdxdna_gem_uva(heap);
>   		if (heap_addr == AMDXDNA_INVALID_ADDR) {
>   			XDNA_ERR(xdna, "Heap %d is not mapped", heap_id);
> -			return -EAGAIN;
> +			ret = -EAGAIN;
> +			goto cleanup_heap_xa;
>   		}
>   
>   		if (heap_addr != exp_heap_uva) {
>   			XDNA_ERR(xdna, "Heap %d uva is not contiguous", heap_id);
> -			return -EINVAL;
> +			ret = -EINVAL;
> +			goto cleanup_heap_xa;
> +		}
> +
> +		ret = xa_insert(&dev_bo->heap_xa, heap_id, heap, GFP_KERNEL);
> +		if (ret) {
> +			ret = -ENOMEM;
> +			goto cleanup_heap_xa;
>   		}
>   
>   		if (heap->dev_addr + heap->mem.size >=
> @@ -87,12 +96,15 @@ amdxdna_init_dev_bo(struct amdxdna_gem_obj *dev_bo)
>   
>   	if (heap_id == client->dev_heap_nid) {
>   		XDNA_DBG(xdna, "Can not find heap end");
> -		return -EAGAIN;
> +		ret = -EAGAIN;
> +		goto cleanup_heap_xa;
>   	}
>   
> -	dev_bo->heap_end_id = heap_id;
> -
>   	return 0;
> +
> +cleanup_heap_xa:
> +	xa_destroy(&dev_bo->heap_xa);
> +	return ret;
>   }
>   
>   static int
> @@ -132,8 +144,7 @@ amdxdna_gem_heap_alloc(struct amdxdna_gem_obj *abo)
>   	}
>   
>   	client->heap_usage += mem->size;
> -	xa_for_each_range(&client->dev_heap_xa, heap_id, heap,
> -			  abo->heap_start_id, abo->heap_end_id)
> +	xa_for_each(&abo->heap_xa, heap_id, heap)
>   		drm_gem_object_get(to_gobj(heap));
>   
>   unlock_out:
> @@ -142,22 +153,13 @@ amdxdna_gem_heap_alloc(struct amdxdna_gem_obj *abo)
>   	return ret;
>   }
>   
> -static void
> -amdxdna_gem_heap_free(struct amdxdna_gem_obj *abo)
> +void amdxdna_gem_heap_free(struct amdxdna_client *client, struct amdxdna_gem_obj *abo)
>   {
> -	struct amdxdna_client *client = abo->client;
> -	struct amdxdna_gem_obj *heap;
> -	unsigned long heap_id;
> -
>   	mutex_lock(&client->mm_lock);
>   
>   	drm_mm_remove_node(&abo->mm_node);
>   	client->heap_usage -= abo->mem.size;
>   
> -	xa_for_each_range(&client->dev_heap_xa, heap_id, heap,
> -			  abo->heap_start_id, abo->heap_end_id)
> -		drm_gem_object_put(to_gobj(heap));
> -
>   	mutex_unlock(&client->mm_lock);
>   }
>   
> @@ -180,6 +182,7 @@ amdxdna_gem_create_obj(struct drm_device *dev, size_t size)
>   	abo->open_ref = 0;
>   	abo->internal = false;
>   	INIT_LIST_HEAD(&abo->mem.umap_list);
> +	xa_init_flags(&abo->heap_xa, XA_FLAGS_ALLOC);
>   
>   	return abo;
>   }
> @@ -449,13 +452,18 @@ static void amdxdna_gem_dev_obj_free(struct drm_gem_object *gobj)
>   {
>   	struct amdxdna_dev *xdna = to_xdna_dev(gobj->dev);
>   	struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
> +	struct amdxdna_gem_obj *heap;
> +	unsigned long heap_id;
>   
>   	XDNA_DBG(xdna, "BO type %d xdna_addr 0x%llx", abo->type, amdxdna_gem_dev_addr(abo));
>   	if (abo->pinned)
>   		amdxdna_gem_unpin(abo);
>   
>   	amdxdna_gem_vunmap(abo);
> -	amdxdna_gem_heap_free(abo);
> +	xa_for_each(&abo->heap_xa, heap_id, heap)
> +		drm_gem_object_put(to_gobj(heap));
> +	xa_destroy(&abo->heap_xa);
> +
>   	drm_gem_object_release(gobj);
>   	amdxdna_gem_destroy_obj(abo);
>   }
> @@ -757,19 +765,72 @@ static void amdxdna_gem_obj_vunmap(struct drm_gem_object *obj, struct iosys_map
>   		drm_gem_shmem_object_vunmap(obj, map);
>   }
>   
> +static int amdxdna_gem_dev_obj_open(struct drm_gem_object *gobj, struct drm_file *filp)
> +{
> +	struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
> +
> +	guard(mutex)(&abo->lock);
> +	if (filp->driver_priv != abo->client)
> +		return -EPERM;
> +	abo->open_ref++;
> +
> +	return 0;
> +}
> +
> +static void amdxdna_gem_dev_obj_close(struct drm_gem_object *gobj, struct drm_file *filp)
> +{
> +	struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
> +	struct amdxdna_client *client = NULL;
> +
> +	mutex_lock(&abo->lock);
> +	abo->open_ref--;
> +
> +	/*
> +	 * Freeing the heap allocation here, when the handle is closed, is
> +	 * intentional.  DEV BOs are carved out of a per-client drm_mm heap;
> +	 * any subsequent allocation that lands on the same device address will
> +	 * also belong to the same client.  If the user closes the handle while
> +	 * a job is still in flight the only consequence is self-inflicted
> +	 * corruption within their own context -- it cannot affect other
> +	 * processes.  The GEM reference held by the in-flight job keeps the
> +	 * amdxdna_gem_obj struct alive until the job completes; it does not
> +	 * prevent the device address from being reclaimed by the allocator.
> +	 *
> +	 * Cross-process handle creation for DEV BOs is rejected in
> +	 * amdxdna_gem_dev_obj_open(), which prevents the following UAF:
> +	 * if a second process shared the handle via GEM flink and the
> +	 * original creator exited (freeing client), the importer would later
> +	 * reach open_ref == 0 here and call amdxdna_gem_heap_free() with a
> +	 * dangling abo->client pointer.  Because cross-process opens are
> +	 * rejected, the process arriving here is always the owning client,
> +	 * which is still alive.  abo->client is nulled out afterwards so that
> +	 * any code path running on a lingering GEM reference (e.g. an
> +	 * in-flight job) cannot silently dereference a stale pointer.
> +	 */
> +	if (abo->open_ref == 0) {
> +		client = abo->client;
> +		abo->client = NULL;
> +	}
> +	mutex_unlock(&abo->lock);
> +
> +	if (client)
> +		amdxdna_gem_heap_free(client, abo);
> +}
> +
>   static int amdxdna_gem_dev_obj_vmap(struct drm_gem_object *obj, struct iosys_map *map)
>   {
>   	struct amdxdna_gem_obj *abo = to_xdna_obj(obj);
>   	struct amdxdna_gem_obj *heap;
> +	unsigned long index = 0;
>   	void *base;
>   	u64 offset;
>   
> -	/* vmap dev bo which is across more than 1 heap is not allowed */
> -	if (abo->heap_start_id != abo->heap_end_id)
> +	heap = xa_find(&abo->heap_xa, &index, ULONG_MAX, XA_PRESENT);
> +	if (!heap)
>   		return -ENOMEM;
>   
> -	heap = xa_load(&abo->client->dev_heap_xa, abo->heap_start_id);
> -	if (!heap)
> +	/* vmap dev bo which is across more than 1 heap is not allowed */
> +	if (xa_find_after(&abo->heap_xa, &index, ULONG_MAX, XA_PRESENT))
>   		return -ENOMEM;
>   
>   	base = amdxdna_gem_vmap(heap);
> @@ -788,6 +849,8 @@ static struct dma_buf *amdxdna_gem_dev_obj_export(struct drm_gem_object *gobj, i
>   
>   static const struct drm_gem_object_funcs amdxdna_gem_dev_obj_funcs = {
>   	.free = amdxdna_gem_dev_obj_free,
> +	.open = amdxdna_gem_dev_obj_open,
> +	.close = amdxdna_gem_dev_obj_close,
>   	.vmap = amdxdna_gem_dev_obj_vmap,
>   	.export = amdxdna_gem_dev_obj_export,
>   };
> @@ -1126,6 +1189,8 @@ int amdxdna_drm_create_bo_ioctl(struct drm_device *dev, void *data, struct drm_f
>   		 args->handle, args->type, amdxdna_gem_uva(abo),
>   		 amdxdna_gem_dev_addr(abo), abo->mem.size);
>   put_obj:
> +	if (ret && abo->type == AMDXDNA_BO_DEV)
> +		amdxdna_gem_heap_free(client, abo);
>   	/* Dereference object reference. Handle holds it now. */
>   	drm_gem_object_put(to_gobj(abo));
>   	return ret;
> @@ -1159,7 +1224,6 @@ static void amdxdna_bo_unpin(struct amdxdna_gem_obj *abo)
>   
>   int amdxdna_gem_pin_nolock(struct amdxdna_gem_obj *abo)
>   {
> -	struct amdxdna_client *client = abo->client;
>   	struct amdxdna_gem_obj *heap;
>   	unsigned long heap_id, last = ULONG_MAX;
>   	int ret = 0;
> @@ -1167,17 +1231,15 @@ int amdxdna_gem_pin_nolock(struct amdxdna_gem_obj *abo)
>   	if (abo->type != AMDXDNA_BO_DEV)
>   		return amdxdna_bo_pin(abo);
>   
> -	xa_for_each_range(&client->dev_heap_xa, heap_id, heap,
> -			  abo->heap_start_id, abo->heap_end_id) {
> +	xa_for_each(&abo->heap_xa, heap_id, heap) {
>   		ret = amdxdna_bo_pin(heap);
>   		if (ret)
>   			break;
>   		last = heap_id;
>   	}
>   
> -	if (ret && last <= abo->heap_end_id) {
> -		xa_for_each_range(&client->dev_heap_xa, heap_id, heap,
> -				  abo->heap_start_id, last)
> +	if (ret && last != ULONG_MAX) {
> +		xa_for_each_range(&abo->heap_xa, heap_id, heap, 0, last)
>   			amdxdna_bo_unpin(heap);
>   	}
>   
> @@ -1202,8 +1264,7 @@ void amdxdna_gem_unpin(struct amdxdna_gem_obj *abo)
>   		struct amdxdna_gem_obj *heap;
>   		unsigned long heap_id;
>   
> -		xa_for_each_range(&abo->client->dev_heap_xa, heap_id, heap,
> -				  abo->heap_start_id, abo->heap_end_id)
> +		xa_for_each(&abo->heap_xa, heap_id, heap)
>   			amdxdna_bo_unpin(heap);
>   	} else {
>   		amdxdna_bo_unpin(abo);
> @@ -1319,8 +1380,7 @@ int amdxdna_drm_sync_bo_ioctl(struct drm_device *dev,
>   		u64 flush_start = bo_start + args->offset;
>   		u64 flush_end = flush_start + args->size;
>   
> -		xa_for_each_range(&client->dev_heap_xa, heap_id, heap,
> -				  abo->heap_start_id, abo->heap_end_id) {
> +		xa_for_each(&abo->heap_xa, heap_id, heap) {
>   			u64 heap_start = amdxdna_gem_dev_addr(heap);
>   			u64 heap_end = heap_start + heap->mem.size;
>   			u64 start = max(flush_start, heap_start);
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.h b/drivers/accel/amdxdna/amdxdna_gem.h
> index fb033ced1045..5dfefdcf1356 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.h
> +++ b/drivers/accel/amdxdna/amdxdna_gem.h
> @@ -47,8 +47,7 @@ struct amdxdna_gem_obj {
>   
>   	/* Below members are initialized when needed */
>   	struct drm_mm_node		mm_node; /* For AMDXDNA_BO_DEV */
> -	u32				heap_start_id;
> -	u32				heap_end_id;
> +	struct xarray			heap_xa;
>   	u64				dev_addr; /* For heap bo */
>   	u32				assigned_hwctx;
>   	struct dma_buf			*dma_buf;
> @@ -105,6 +104,7 @@ static inline u64 amdxdna_obj_dma_addr(struct amdxdna_gem_obj *abo)
>   }
>   
>   void amdxdna_umap_put(struct amdxdna_umap *mapp);
> +void amdxdna_gem_heap_free(struct amdxdna_client *client, struct amdxdna_gem_obj *abo);
>   
>   struct drm_gem_object *
>   amdxdna_gem_create_shmem_object_cb(struct drm_device *dev, size_t size);

