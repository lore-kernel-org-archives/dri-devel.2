Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A9B2C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:18:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AF3E10EE05;
	Tue,  7 Jul 2026 15:18:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v4xtFFkq";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012048.outbound.protection.outlook.com
 [40.93.195.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0055010EE02
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:18:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4JZ9paOF7mZCsiknFJBOZs5Qygh0ZmWftWL3LG9kuk/CQC09ZsT7umWFHAp53XhANRiF+YXoB6Whf7piaSURakM/iDvWXOUZAJc/UzZssQjHubge/Axkof4s6suxMtYrfo9il80o66nULRTuwzhy7yMXHYOrTXGD/k1BL1kNqqNClTzzWksQLlUEsWJ1LsRzRGoeLUT8DXouue0+0Kv5326MlVPpPhsP7wBU6pdCW7ozSfyI/JuTxv+zzBz/V+4j6KZTMkdcnuqonV1zZmzj66Znxm/H1YYy///HoVvMK9qFoU8yHJwmy5yYAUybIym9KO535QRv20Tg0tmaio2TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmBAFt9EbiFK6dZi8AzJkWlXdmFt/qXw+zNXLy4RPr8=;
 b=dLRO9f1M+bkNqAGLBNsAUMB6lC95/hHz6yvm00RjuVuAxmA02KYj9ehPkBwJ0GNO8upC9QeXS8S3lMCxj43SpnMEZt3PsBt08Mv7cYa4bjvK+xxLEhfdc168VZPOGWkkKZVzCYhw0bX9W6RkzhTHApAnB1bf61HcSpypda1gsm6FzwfRNIZbW+uKvOaQxygDvH1SVrO+I+aLmgQ/rNPMXBsRneby9v0y7NIYIa0D9k7PgnlOqbuezKvtfCVPMpJlc2yoTdc4NFCIv+pBIW2Ku+H7bYvLUHfnc4clv00H39zNJxWRmqGDxIRe/2qgrP6gcEejaOTFC4UTf9m6lsmEEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmBAFt9EbiFK6dZi8AzJkWlXdmFt/qXw+zNXLy4RPr8=;
 b=v4xtFFkqIF3YG+204o1ySIOCl3VnnPxWFIS8KXiTHmv+qps70L1h9F6Q3r2IKwiZ40tMfUd2O7GyJnJ1rhT/b9rKE2p/ie1vJuyejNqiWL4eSwZ+6U89hA4cQw56JbSNxgC3OqRY1COG3bpHADK1OGaubboC3KjgjtZfHFa+f5I=
Received: from PH7P220CA0153.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::15)
 by BL3PR12MB6404.namprd12.prod.outlook.com (2603:10b6:208:3b4::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 15:18:19 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:510:33b:cafe::4b) by PH7P220CA0153.outlook.office365.com
 (2603:10b6:510:33b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 15:18:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 15:18:18 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 10:18:17 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 08:18:17 -0700
Received: from [172.19.70.117] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 10:18:17 -0500
Message-ID: <afc73e8a-5948-417b-92d7-b4ae492c9072@amd.com>
Date: Tue, 7 Jul 2026 08:18:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Fix hardware context race in
 amdxdna_update_heap()
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20260707055818.479165-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Max Zhen <max.zhen@amd.com>
In-Reply-To: <20260707055818.479165-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|BL3PR12MB6404:EE_
X-MS-Office365-Filtering-Correlation-Id: 924d6088-eb56-4605-5507-08dedc3af964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: fWvgcvB4DgH2KmVOf9xQL1CsBCb5YDbHVKWEbcAYgjcBlmt2eFlu2ANfXwBRHiX1q+b4HJGSkZ6UtYKkVyRyaBrLUQDvss8cmDP1UNVO56sU2tK4pcY3Q6mj7QuCFSmHEH3rQVN9armYYHi8scB0grdaZOeqOpR0VqjFwq6tq1hYikm8AORniewMnkLBMiBYhb1kemNdoPwJEb2sMkgWTGxrsLJhgAbCZJ/3c9caV3FuEI+N5YvcuX7jy2ZEjErG3SZ8oKGImntXNZPVcaWbJEfRkApAdCEAdE5HbCYfibqFA0gsrNpcGPLbx0IoHCy3+97C9YhKTkal/GTKqU6dfoibvDuwihNdjTXy0A6C6PkqXH+BnAHqfmXFpmvpTVCa7hyuvxB3E3I2kO0AYoGNN4d5e4OGWV2yWAeqTON0P8LMaciB46uJnVxlrUKraA1O4V+uDly1hmQikst5eHRQrQVdedl6QzodpfAjJqCrgYc94yw+R7wbwAoPY/vxup3tz+/S1hSFmAmuqB7gund+d/GQUDMev0x2/vX8VqB/d4T9PG8oT2P5p2XfJBKPLe3bWy9nUYvuI+/KKZ5vIzamALNlM/eQp+LQH5A2N75ZvbZdXqT3jNwhprz+YzhR54L6WLC/lzfVeBBLaAgJVxA3ctdJT8zOeRLrX0bof3ycNRK8+zYLh6NJdKK5letTQmQHtakRKoB5Z1UGdW49fdBaAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SNcs5WnJLqUDZ308gWfCEuGBk2hDCq7rmwyi8qtWogwcvt5BcMw+uqDv2kxdlue7ZI9o5tG2k8OC+zquordMoizNUJdoJEdo+oB2tIUJj3XdfCVLH34MbQsLr5CLLILzqZHHtD9ZwzXp+dPTl3KR7Ac73MCAui9ZBX2W2+P8vGmXuLZnPWmOWNTUyNTSW9uLLYxel4CxdCiOrvz4f24jmw2fKVYmc3q+hj7jzexzcXz3gRDILt8pjhMtOcYXqsInNn2hOd5lsnfq+Z6ypDl+nsKy6+8WfUy/LlrivrqVRNI56rsakqnsa7iEr+y59iC7fgCis8n5KtOtWU9Bk2m6xcWISGuj3JGe0JVRTwWgL3IZ8+8vECH83AqWMCsDlUCWbWuqTKNYF13XWuZoCikQ4RkpsrHnIFDRRuZFYDWP/0m6mQYI4tn5o8qsGox3bojm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 15:18:18.2896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 924d6088-eb56-4605-5507-08dedc3af964
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6404
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



On 7/6/2026 Mon 22:58, Lizhi Hou wrote:
> amdxdna_update_heap() iterates over hardware contexts while holding
> xdna->dev_lock. During the iteration, amdxdna_pm_resume_get_locked() may
> temporarily release and reacquire the lock, allowing hardware contexts to
> be modified concurrently.
> 
> Fix the race by calling amdxdna_pm_resume_get_locked() before
> iterating over hardware contexts.
> 
> Fixes: dbc8fd7a03cb ("accel/amdxdna: Add expandable device heap support")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Max Zhen <max.zhen@amd.com>
> ---
>   drivers/accel/amdxdna/aie2_ctx.c    |  6 ------
>   drivers/accel/amdxdna/amdxdna_ctx.c | 24 +++++++++++++++---------
>   2 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
> index 30ccb8d5e23d..101f324ee178 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -1222,10 +1222,6 @@ int aie2_hwctx_heap_expand(struct amdxdna_hwctx *hwctx,
>   	u64 addr;
>   	int ret;
>   
> -	ret = amdxdna_pm_resume_get_locked(xdna);
> -	if (ret)
> -		return ret;
> -
>   	addr = amdxdna_obj_dma_addr(heap);
>   	ret = aie2_add_host_buf(xdna->dev_handle, hwctx->fw_ctx_id,
>   				addr, heap->mem.size);
> @@ -1234,7 +1230,5 @@ int aie2_hwctx_heap_expand(struct amdxdna_hwctx *hwctx,
>   			 hwctx->name, heap->mem.size, ret);
>   	}
>   
> -	amdxdna_pm_suspend_put(xdna);
> -
>   	return ret;
>   }
> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
> index 9ae19393e488..8f8df9d04ec5 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
> @@ -472,9 +472,7 @@ static int amdxdna_hwctx_expand_heap(struct amdxdna_hwctx *hwctx)
>   			break;
>   		}
>   
> -		mutex_unlock(&client->mm_lock);
>   		ret = xdna->dev_info->ops->hwctx_heap_expand(hwctx, heap);
> -		mutex_lock(&client->mm_lock);
>   		if (ret) {
>   			amdxdna_gem_unpin(heap);
>   			drm_gem_object_put(to_gobj(heap));
> @@ -493,18 +491,26 @@ int amdxdna_update_heap(struct amdxdna_client *client, struct amdxdna_hwctx *hwc
>   	unsigned long hwctx_id;
>   	int ret;
>   
> -	guard(mutex)(&client->mm_lock);
> +	ret = amdxdna_pm_resume_get_locked(client->xdna);
> +	if (ret)
> +		return ret;
>   
> -	if (hwctx)
> -		return amdxdna_hwctx_expand_heap(hwctx);
> +	mutex_lock(&client->mm_lock);
>   
> -	amdxdna_for_each_hwctx(client, hwctx_id, hwctx) {
> +	if (hwctx) {
>   		ret = amdxdna_hwctx_expand_heap(hwctx);
> -		if (ret)
> -			return ret;
> +	} else {
> +		amdxdna_for_each_hwctx(client, hwctx_id, hwctx) {
> +			ret = amdxdna_hwctx_expand_heap(hwctx);
> +			if (ret)
> +				break;
> +		}
>   	}
> +	mutex_unlock(&client->mm_lock);
>   
> -	return 0;
> +	amdxdna_pm_suspend_put(client->xdna);
> +
> +	return ret;
>   }
>   
>   static void

