Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62BA0C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:13:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B92FB10EDF3;
	Tue,  7 Jul 2026 15:13:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LKgCc8KG";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012066.outbound.protection.outlook.com [52.101.48.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5048B10EDF3
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:13:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSjHB+CtknsgeOMW6gVTXzxFnMmTgvdQbCA7ZKTDQFm/uN4NhdZ89DkZN6oh/+fdsBB+xQOc2hQpi4lUIfkHph5HaL8WP2pqxxFWDjfMbpPQ9hyg7VmMR8V8R2Mvo3ZmbCx6leX9iW9kcivX5sHXFkV9BStShbvra5IgiJseqqpB0lePgW3w3cyxTcc3yJsDVFaJ+5TzboHVGoCSD/XkyCLnwV++jHsolZml8liFqzr3gnt0QEYF+oCxjD+wRI70OB3RouQ0zaaZCKDv+LyUeb07WGo3gEpwYCHvPjFY5/RK9JQwfdceidgxIpH9NRQuCSI8tuoS1aYDQK24US8O+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuiVhENiUe3y/Fq6E90ZBs3C48m7Dkk4GybXsnwJa0k=;
 b=cuBqNSc+ONpe4y4q5PrNlDQedHqjdCFLvWRi1A+PsKHa4uScDQEaZkt17FfNoBe8Zl0SPXhGvRIo07sPnDJ0nabCBiLL1Gw1UgeV3chKbPWnaYdBq+G+yAiGVwZVrb8sA8IB/uksFW5eGP7MuuOTEOeUOVvFYXAd2UKCFd4P2iYfIO/LpGR5s4kmGHYqpLZpEWF8fgUWsgJNz6nxCwHJdxnjtm2xBuEVuqQEYdXoJgv8x1cUfggIfE52NssuqnXWg9nN85glKZ9mJwW3J7daEsir5fPglSQiWlXw+c5SUnCO4xSqOCcJat+yaCChvBn5bDRY6sQE4mQH1LlsaNz6vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuiVhENiUe3y/Fq6E90ZBs3C48m7Dkk4GybXsnwJa0k=;
 b=LKgCc8KGmEWSZWb8c1KVxdhfU9JL98Dpl2GtaKEXZUoaw9rgO/8we4SfDB17M88GBBei3Qzf2vSwXSlP8NhBnfn4HvA5CWLC8gpAhOVaU9hp7esrJHrDEsNf9wB6UTKHHGN4zdn2Vc899bR35xvOJ5IPFf2RXB5mxpXSAkd9U0A=
Received: from BL1PR13CA0101.namprd13.prod.outlook.com (2603:10b6:208:2b9::16)
 by IA1PR12MB9061.namprd12.prod.outlook.com (2603:10b6:208:3ab::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Tue, 7 Jul
 2026 15:13:06 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::33) by BL1PR13CA0101.outlook.office365.com
 (2603:10b6:208:2b9::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 15:13:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 15:13:06 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 10:12:56 -0500
Received: from [172.19.70.117] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 10:12:55 -0500
Message-ID: <5cbef92d-485d-49a9-ba51-001c959e0b28@amd.com>
Date: Tue, 7 Jul 2026 08:12:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Fix deadlock on debug BO command timeout
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20260707055732.479103-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Max Zhen <max.zhen@amd.com>
In-Reply-To: <20260707055732.479103-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|IA1PR12MB9061:EE_
X-MS-Office365-Filtering-Correlation-Id: 70e18733-3e6a-409e-0ce2-08dedc3a3f46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|5023799004|56012099006|22082099003|11063799006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: N2XeOqkcd3ocORXhV9eV/Awbqj9uZfc8SFXp4OWqtcC06TFcPPxLbO9B0Cu5J6x7KuIdgkUINtH9qmcGLUXT09h5snJy0sPDtIJZd4Q4eJWIF2Fv38cUAK2+Qr/h1AuVQi7/ywrBKN8gZY0oRtbVd7I8egTGTKFec5a1Cjum4jQdz93/E2WaTe8upLg0tMW24U+8zy20JtG+l/1oD/8ztKFOvjIz3ToDI84IbBZdZ9bfzuI/dS5CIkD+DMVmi4i93qX2A/sn/JMmycw4C4nJXsOkmlkO9/ySc+0jOazVN1z7ZYD0wkH3N/ptNWwIvXc6kOnIWyqEDXkLWW/exQ7b8Y6rcteuKLnIkrygeXOXF/Npun1oQuuhx7irooPSQPFBCiVC2e1yCNdEZo4MCFlMpqmnPmZTmxzeTYniDLQD8LQVgvHGZK5DciYxVRaVoYe1q0/sb53EIyVI2Q5et1hycEC90zaRlu8irg9b0gzMEMAiyu4U9oSgaweAWw9V0wCRKnGxyF6u82WIarCSzpb4OclzTcB4gIeX+8GIx3BsCzzVg4CiMsNKsIqMmAg81N4tLEN1c3KaQy1rnZZEVcjkPcBueoDeOAiHTUCj53df6lICc+nTpRcb07ZqLOIhASPn4lT/XVElCUp7i7i6HcMZANgBDLT0RnF8BMAvdxxodtmB9LSz+JtOfjA02EH8mAWTzI++qVC42vYOdQDsOAthqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(5023799004)(56012099006)(22082099003)(11063799006)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gWdhIl0OPn9CU//T5NMGt+q7uddz7DmqxzOsBjBaYMhDl8DFGqClEd3K4qR9zIhOISBscn/XSKseAvUeTGlsKaT8v22gMQthdiCFyw862yYZm6z8iXvKdZFcQPuzFWQvEt0XGO1ahN86kv+thHZc9hYLzabD6seGjbjpXfacYkPkFM+EVrxNCpn3X95fVTN/kgVTfuhPDfzzavYIjV0kciGWoNZrYBtOCXOuEsBRwC8HOiGy+KAafqwfXtlABpm7MjibX0+DIxLRikwZzNz8/uPdsbxCf4z9dilnpuvlg/YRE4S6HIy0klSnEKK9KcM/bJV3hFc/CS1bnKwveHQ7wsE82X+u92hbFlpa+iEE8XZHeOK0vNUK+MQvAA744nG9IVBSvn5eb9VVSU4Et+TFqwRagqTNonMI5i7/zPaGp1MmB7IDEltVp9bMcPWxzHbD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 15:13:06.0513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e18733-3e6a-409e-0ce2-08dedc3a3f46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9061
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



On 7/6/2026 Mon 22:57, Lizhi Hou wrote:
> Both amdxdna_hwctx_sync_debug_bo() and amdxdna_drm_config_hwctx_ioctl()
> hold xdna->dev_lock while invoking backend operations. If the hardware
> hangs, aie2_cmd_wait() blocks waiting for a firmware response. When the
> DRM scheduler timeout expires, aie2_sched_job_timedout() is invoked to
> reset the hardware. However, the timeout handler also attempts to acquire
> dev_lock, resulting in a deadlock.
> 
> Avoid this by releasing dev_lock before waiting for the firmware
> response and reacquiring it after the wait completes. This allows the
> timeout handler to proceed with device recovery when a debug BO command
> times out.
> 
> Fixes: 7ea046838021 ("accel/amdxdna: Support firmware debug buffer")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Max Zhen <max.zhen@amd.com>
> ---
>   drivers/accel/amdxdna/aie2_ctx.c    | 5 ++++-
>   drivers/accel/amdxdna/amdxdna_ctx.c | 6 ++++++
>   2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
> index 7bf635634e64..30ccb8d5e23d 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -900,13 +900,16 @@ static int aie2_hwctx_cu_config(struct amdxdna_hwctx *hwctx, void *buf, u32 size
>   static void aie2_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq)
>   {
>   	struct dma_fence *out_fence = aie2_cmd_get_out_fence(hwctx, seq);
> +	struct amdxdna_dev *xdna = hwctx->client->xdna;
>   
>   	if (!out_fence) {
> -		XDNA_ERR(hwctx->client->xdna, "Failed to get fence");
> +		XDNA_ERR(xdna, "Failed to get fence");
>   		return;
>   	}
>   
> +	mutex_unlock(&xdna->dev_lock);
>   	dma_fence_wait_timeout(out_fence, false, MAX_SCHEDULE_TIMEOUT);
> +	mutex_lock(&xdna->dev_lock);
>   	dma_fence_put(out_fence);
>   }
>   
> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
> index 67a2abcf173e..9ae19393e488 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
> @@ -310,6 +310,7 @@ int amdxdna_drm_destroy_hwctx_ioctl(struct drm_device *dev, void *data, struct d
>   	if (!drm_dev_enter(dev, &idx))
>   		return -ENODEV;
>   
> +	mutex_lock(&xdna->client_lock);
>   	mutex_lock(&xdna->dev_lock);
>   	hwctx = xa_erase(&client->hwctx_xa, args->handle);
>   	if (!hwctx) {
> @@ -328,6 +329,7 @@ int amdxdna_drm_destroy_hwctx_ioctl(struct drm_device *dev, void *data, struct d
>   	XDNA_DBG(xdna, "PID %d destroyed HW context %d", client->pid, args->handle);
>   out:
>   	mutex_unlock(&xdna->dev_lock);
> +	mutex_unlock(&xdna->client_lock);
>   	drm_dev_exit(idx);
>   	return ret;
>   }
> @@ -388,6 +390,7 @@ int amdxdna_drm_config_hwctx_ioctl(struct drm_device *dev, void *data, struct dr
>   		goto free_buf;
>   	}
>   
> +	mutex_lock(&xdna->client_lock);
>   	mutex_lock(&xdna->dev_lock);
>   	hwctx = xa_load(&client->hwctx_xa, args->handle);
>   	if (!hwctx) {
> @@ -400,6 +403,7 @@ int amdxdna_drm_config_hwctx_ioctl(struct drm_device *dev, void *data, struct dr
>   
>   unlock:
>   	mutex_unlock(&xdna->dev_lock);
> +	mutex_unlock(&xdna->client_lock);
>   	amdxdna_pm_suspend_put(xdna);
>   free_buf:
>   	kfree(buf);
> @@ -428,6 +432,7 @@ int amdxdna_hwctx_sync_debug_bo(struct amdxdna_client *client, u32 debug_bo_hdl)
>   	}
>   
>   	abo = to_xdna_obj(gobj);
> +	mutex_lock(&xdna->client_lock);
>   	mutex_lock(&xdna->dev_lock);
>   	hwctx = xa_load(&client->hwctx_xa, abo->assigned_hwctx);
>   	if (!hwctx) {
> @@ -439,6 +444,7 @@ int amdxdna_hwctx_sync_debug_bo(struct amdxdna_client *client, u32 debug_bo_hdl)
>   
>   unlock:
>   	mutex_unlock(&xdna->dev_lock);
> +	mutex_unlock(&xdna->client_lock);
>   	amdxdna_pm_suspend_put(xdna);
>   put_obj:
>   	drm_gem_object_put(gobj);

