Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332F4C624D4
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 18:51:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F17410E4F7;
	Wed,  2 Sep 2026 18:51:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VY+a6cTX";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011071.outbound.protection.outlook.com [52.101.52.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1001710E4F7
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 18:51:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNvCOsgWQcLIogVZfDSNDQ2C0plyfOgV9cUy5moEBbnxvvVnakLp3RISosvVqXKLb5k5B/noDUOaiGjMzVTPUA80dIxsDVL/E+48DQfruJekp9doLuRK2EAoL/4BJt94hvrm0ZIAhuIbsZ9NSaNg3htTASCp8U9hZjqv+rWb0Ck/zF4Z70cdVf6k31x29vzhyf1DEI6ktnExntYHosrf0O+8D8Le23lq5B0PfausG15kKbUrofVPfrxc0YgZb5CPdaMGCmA2Vjz1NjNPMTbky2Z07euY8+J7SFmgYEjmGFYIfs3pJLN0ZvRtMlXjPynXN2Ywww8Aoa1jY+96ImAXUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+VgFkljH204LYJRuT/iU1mclivebSO04UH6ETouKA4=;
 b=NEYx9vZQ3ocdSGTkf+DP68+ox5JENT6+AoY6iI82Su81w03ZVxGsJ7DlDdCaon72HEK2UFUaQbgc1GubDz0nh9iX5E2y0kjGqg4IcoGgATcgMLag2HpE1LRE3mvbvJJ2kcU8AmAYgHGnPdd7P5LUDjNTGspwAVhKT4BIWAx9G8iYHAslViXC5sfRlYypu+0fPD7jEtXpnGizPtLgaS72Ne+F1n1UJjoloQkav59Ttc1UKL9av9gDantREmFuOwKGzGAkZU2biHwdLhaPBIXLq2y8gkuUxN2zSVlRKuYq2+ib4R+ECvr1rWaBBfWKKNzxgRc/O8jHqSQgrQ8Z1dYdpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+VgFkljH204LYJRuT/iU1mclivebSO04UH6ETouKA4=;
 b=VY+a6cTXuQa7YXlQvCiwKbOYTXPKJdrgn0QGQJtLzwIYezWl0u6QRCNJSKVGmAtuEur0vGLiUQP77v50UHJgxVUY3VJBbqiktIuCSsMHu8lQizvjR4kIVCpH9iMueKOXb89b4i6BL1aURHwgEIWC48FP629QiawyC2JdLZ88uAU=
Received: from SJ0PR05CA0054.namprd05.prod.outlook.com (2603:10b6:a03:33f::29)
 by IA0PPF04DCE520E.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bc5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 18:51:12 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::1b) by SJ0PR05CA0054.outlook.office365.com
 (2603:10b6:a03:33f::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 18:51:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 18:51:09 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 13:51:09 -0500
Received: from [172.19.68.62] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 13:51:08 -0500
Message-ID: <83104024-65dc-4289-afe5-6892844dc344@amd.com>
Date: Wed, 2 Sep 2026 11:51:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 2/2] accel/amdxdna: Fix potential deadlock in BO open
 and close callbacks
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20260902180955.3999242-1-lizhi.hou@amd.com>
 <20260902180955.3999242-2-lizhi.hou@amd.com>
Content-Language: en-US
From: Max Zhen <max.zhen@amd.com>
In-Reply-To: <20260902180955.3999242-2-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|IA0PPF04DCE520E:EE_
X-MS-Office365-Filtering-Correlation-Id: c4c011d6-e8e2-4bf3-c3b6-08df09232746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|10067099003|56012099006|11063799006|22082099003|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info: 2vMSK+2k9gKAGtJMq4UFdtyMpilz4D4iqvEde6GVmFOeAj9Hmt3nwMQ6EhF8lwz4s7+ugICfa9tBMDaJ9RHKNAu86mXHPuhVyNk4CiYqX5bNtC70JKJzikn71LQV83xqjBKn7vIs2O0CHuERVgDzNLQMEOomxwUf/9mXShYaAWpoJiFkcQhJu0ng6lmOaydMfqBaGrryu5jb8/vWNlL6TdSYE4JuEWzJk9n2FW43xpPWzk/622F8Nmx5HUVBq9N6/wcmz+rvqvE58UgtozC+gGr26xkY1uLoegKu/eYwc/VKcae9hQsNLFHeaVgsYk/gsMkHOtw3DsXfXpJHGHMW6nhjAZ9vacEgk2mPNjE5+zcW4R7MznrEnQVJxINeaqNUtfB1wJqmWBFOnMjinympYJwm37VdcVxjYb/qN/obaOale245J6Gy2Y+ZzKFJ118vaPma1qTw4eoxKA1bqHLJA7iHNJQHXOS3TCGznjX+9uINWiUCyskGXwv5mDp7NppBT82uVR5A5cCk62UNtLTvze85w7FgWxEb1m/EXrx6xYML333z3J6KKO3gsbuMTT1XjOA9DzIWs9I/RGmAOp1DOwFROMsN9LCWcpuNRhWepeYL8ZMsZNR+YuA0hdViud84PZ/gZl6SLdHFGWmgdgA3EpaUxRxNbC6QesTh4Y/72WeiPMHrjXEXjmQ974gZTs2UV3X1FpbIRw9tVNztxzoR7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(22082099003)(4143699003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CupTSh4ltwLVIU9B+owz3gY3nL1+OVsldg3pA5NMfJlxRHgGqs4+mzbprzwI/shOI692I8KTBWIX9GP8fmCctGcejU+1K8jqJswN6bQM7WcY0TUzhDJ8WiBkR/UEpNcEg2Q3X7+sCW4lJwsEsi31JoFd7LyJvwuK3AMYm4Ecao0uE2/5UTgH0ebaghmBk0+sk+pq7tmmtadUZuVPSaTN4BanCU6G7aza+vDk5bgwjlmRr+4/LuXYmTmTPZulwzDSMDrwj+uQfiVG0HMccF2Hf4R/ZkEw9857kRpphOaj3PWO+R1FlTl/UKd/0PupCw7QNAIDLhaiDzEUzw97gXx+9s6rTrDjxikDXsdFwogOE1gT09WGo2p/XKUr4Y9NUcwxOwYK1b8HKZvUlTlfcWK8/HuEmc74tWBxwfkIT2yXmF6Lf4ptrnGzIBYk/xPqsqUK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 18:51:09.6078 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c011d6-e8e2-4bf3-c3b6-08df09232746
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF04DCE520E
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



On 9/2/2026 Wed 11:09, Lizhi Hou wrote:
> In amdxdna_gem_obj_open(), abo->lock is held when calling
> amdxdna_gem_add_bo_usage(), which then acquires client->mm_lock.
> 
> However, the heap update path may acquire these locks in the reverse
> order, creating a potential deadlock.
> 
> Fix this by saving the client pointer locally before acquiring abo->lock,
> and releasing abo->lock before calling amdxdna_gem_add_bo_usage().
> 
> Apply the same change to amdxdna_gem_obj_close().
> 
> Fixes: 1f513a3ec3a9 ("accel/amdxdna: Add per-process BO memory usage query support")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Max Zhen <max.zhen@amd.com>
> ---
>   drivers/accel/amdxdna/amdxdna_gem.c | 34 +++++++++++++++++++----------
>   1 file changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index 1353393194e2..0d165b66c1fc 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -641,10 +641,8 @@ amdxdna_gem_skip_bo_usage(struct amdxdna_gem_obj *abo)
>   }
>   
>   static void
> -amdxdna_gem_add_bo_usage(struct amdxdna_gem_obj *abo)
> +amdxdna_gem_add_bo_usage(struct amdxdna_client *client, struct amdxdna_gem_obj *abo)
>   {
> -	struct amdxdna_client *client = abo->client;
> -
>   	if (amdxdna_gem_skip_bo_usage(abo))
>   		return;
>   
> @@ -656,10 +654,8 @@ amdxdna_gem_add_bo_usage(struct amdxdna_gem_obj *abo)
>   }
>   
>   static void
> -amdxdna_gem_del_bo_usage(struct amdxdna_gem_obj *abo)
> +amdxdna_gem_del_bo_usage(struct amdxdna_client *client, struct amdxdna_gem_obj *abo)
>   {
> -	struct amdxdna_client *client = abo->client;
> -
>   	if (amdxdna_gem_skip_bo_usage(abo))
>   		return;
>   
> @@ -694,14 +690,20 @@ static int amdxdna_gem_obj_open(struct drm_gem_object *gobj, struct drm_file *fi
>   {
>   	struct amdxdna_dev *xdna = to_xdna_dev(gobj->dev);
>   	struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
> +	struct amdxdna_client *client;
>   	int ret;
>   
> -	guard(mutex)(&abo->lock);
> -	if (abo->open_ref > 0 && filp->driver_priv != abo->client)
> +	mutex_lock(&abo->lock);
> +	if (abo->open_ref > 0 && filp->driver_priv != abo->client) {
> +		mutex_unlock(&abo->lock);
>   		return -EPERM;
> +	}
> +
>   	abo->open_ref++;
> -	if (abo->open_ref > 1)
> +	if (abo->open_ref > 1) {
> +		mutex_unlock(&abo->lock);
>   		return 0;
> +	}
>   
>   	/* Attached to the client when first opened by it. */
>   	abo->client = filp->driver_priv;
> @@ -712,26 +714,34 @@ static int amdxdna_gem_obj_open(struct drm_gem_object *gobj, struct drm_file *fi
>   		if (ret) {
>   			abo->open_ref--;
>   			abo->client = NULL;
> +			mutex_unlock(&abo->lock);
>   			return ret;
>   		}
>   	}
> +	client = abo->client;
> +	mutex_unlock(&abo->lock);
>   
> -	amdxdna_gem_add_bo_usage(abo);
> +	amdxdna_gem_add_bo_usage(client, abo);
>   	return 0;
>   }
>   
>   static void amdxdna_gem_obj_close(struct drm_gem_object *gobj, struct drm_file *filp)
>   {
>   	struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
> +	struct amdxdna_client *client = NULL;
>   
> -	guard(mutex)(&abo->lock);
> +	mutex_lock(&abo->lock);
>   	abo->open_ref--;
>   
>   	if (abo->open_ref == 0) {
> -		amdxdna_gem_del_bo_usage(abo);
>   		/* Detach from the client when last closed by it. */
> +		client = abo->client;
>   		abo->client = NULL;
>   	}
> +	mutex_unlock(&abo->lock);
> +
> +	if (client)
> +		amdxdna_gem_del_bo_usage(client, abo);
>   }
>   
>   static int amdxdna_gem_obj_vmap(struct drm_gem_object *obj, struct iosys_map *map)

