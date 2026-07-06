Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01BAAC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:34:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40C4210E28E;
	Mon,  6 Jul 2026 22:34:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zT+e6to9";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012006.outbound.protection.outlook.com [52.101.43.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D100710E28E
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 22:34:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gi8ORCLytWsdE46DtIXVEDeYPOoaJ1gCYDzDWEDpXrlXrbD41duGitItI0zo2O2bhLWT++07RiA9cx41/zN/QbMGZkQxriNr3JTc5CvcfuBOGbK6jFEENtQ7Xo5Udi09oTO281DNBvVHcZShS6HkbMAzMqjCvkWrcQEzkDTjrZvdwLfwcU3LXmEzvQzbF+Np4QePLzzvRgn9DDT50UL6MB0ltokTLMfedf3NzMyYqAslu7xgaBfhXkwN/YnR3VncZ4rGiG42kYkxHVr6pTtWgCLmJn4/4kbaesg1WL+RQW5mmZHP2PvswzYuDfgrDWusdPh5ug4+tze8Vm7CdqYOZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFKInBh13Gaw/EOSO9vhfpDJFg8bsTjwT/6iUAy/w9c=;
 b=e6P+Ktmi0K0HDXU1PaL2KCCmKP2cr8wDgNfCHMVIkS6K9W9ejbQ+uZjiwFtNGOS6Fiv/cJZtcKFuVNIEW2dPLHwXu3KmLrOE+lgnuWDTCZrk3YIsOuT0yOwDgpNfehwjmVQgIQ96E3bJDAqtoOOTQfKZLksJi1Y10dwIXpCE8s8kycLX5jGn/O/PsdUFH9QRwM6A2rGqmf+mPImJt9KqgmuHR3KlidICkGvgt/5ygD10EGG2Nq72vbdTuVPePe1nIrgNra5reNEtI3fC2zP/mITL7Bq+W2wAwolmN5be80b4eTBa43nL//XjiYeFA73aDjrN7HRoXMiUobR3U3KqJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFKInBh13Gaw/EOSO9vhfpDJFg8bsTjwT/6iUAy/w9c=;
 b=zT+e6to9fyIdwHLFV57Y3tQwqOEWJMBCMDF1LuiBEJT7XLSgpoFf/DXRNQ1596sJxx0+mYhX1RcBIVqw5nFpElpuseSee37GHa4zO7zfPhUXnt0NfTsyLSC4tCWn5bSZ0QIilwL9WBbdjQRkx2q0jERK4eDprvFs8FOA0H7PnXE=
Received: from DM6PR06CA0096.namprd06.prod.outlook.com (2603:10b6:5:336::29)
 by PH0PR12MB7094.namprd12.prod.outlook.com (2603:10b6:510:21d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 22:34:40 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:336:cafe::52) by DM6PR06CA0096.outlook.office365.com
 (2603:10b6:5:336::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 22:34:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 22:34:39 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 17:34:38 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 15:34:38 -0700
Received: from [172.19.70.117] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 6 Jul 2026 17:34:38 -0500
Message-ID: <ff4847cb-90ce-48fb-bb3a-bdffe8ccdf72@amd.com>
Date: Mon, 6 Jul 2026 15:34:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] accel/amdxdna: Prevent PM resume deadlock in
 hwctx_sync_debug_bo()
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <shuvampandey1@gmail.com>,
 <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20260616212429.3620645-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Max Zhen <max.zhen@amd.com>
In-Reply-To: <20260616212429.3620645-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|PH0PR12MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b9b052c-a649-4b87-a781-08dedbaec40f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|56012099006|5023799004|11063799006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: B36bvqtmW+soJo4n0i2BzRLnIPM4uAEK461PAPWtoLcqUZaUBR3svdQJtk3I2rZ/6rA8vAmxpXpoQ3bHr4RVaJPdSYCO6f/ZxlFvfybXQwPHEvwlfYo3w/xnZbPfVOHc78V8DEe70QVwnSIs2Aw/HmpKbeAHqiiUXKwcKndnWhs7ock+f3FLmb5uaW+K9mhsgy82hfHLkj6QDMNybEoV4CpCFdOiy4DHLKPZxLiXgjwDTTSzPR5wrA6OZyOcDukoOFOKTQdiJzxlq/DUUuFq03Ogp0xriRrAaIjWFCuAP9EI9SOfg5Vn0VQWgJaFHGDU7+SKJDhdQJvcJ2hDBmyP5NflKKDel9OhFcqSAgsdsY5fXSb73f1BO/m2WJj2Yb64eul4lL+7T8t39rCIuy42sXYAMooBUy9eF8e2TJhTks/EW0yorRy3rK080v+A4o41bVy8Ln+nztqtU3BN7nXm3IuD5eXBIdCE4JQxE2Fx3fCQA6P4/RDccJcbmq2CvzbW65gfgqksctTXdBMLXMcBK5ZTwrUXZHzkDvYqH4Nah6e2VhZevcOjT+ldtSNUrEpzhW3gYLBFBP8IZTog4/9Yy18qCAZlryjbUlS33DMK0pqH1BiuAGZSLsN5HFI4WS/4rOq0e1lPaUu3XVq+w1VTgZbZQGLr5y3Shk1/tLLdO0VIYDpSugkcxfmaJTsV/5wi15cGAebNlhGJhTjCtxaEYA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(56012099006)(5023799004)(11063799006)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sojLJWhKAkQUlX2VLyP342WYkpZUJUkgDyX+A2qARDK4tH9YPKlQOX0H/J3dYg33EsO1lesRhxkMr9gHO7CpvJajIlU/7C+S76XoR1HOvM2d/q1APrA/plFI9DViQnj89oN72Gw4+gwQ0X8XwpwqDYE4/6Hf3MlwRpem6qeBZRaOFZ6D7HGimNriB8KR4VR+unRpmzEgUZRSEc6krCJEHVrZb0rBR3qkiifYq99Q/OztsVGIJa5PvE9u9PhBIl7UungbFif2Golzi8HgvFQYcawWXlz7vYbHrv5U18pWDRjx9dC4ulz1ERLDhC1uR+2Q582K47HUxuQnNTApg7PspQD1cQwEW/KbA9w+zZqOJbbXBuIZqipD/b8sEDGbWlXzoI0KnEFMI2ov6UF9Wqz7b02tXfB/S4w0UTItYWf5h2XeNfELv+qc5qGLIeHaX+Ng
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 22:34:39.2584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9b052c-a649-4b87-a781-08dedbaec40f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7094
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



On 6/16/2026 Tue 14:24, Lizhi Hou wrote:
> amdxdna_hwctx_sync_debug_bo() invokes the hardware hwctx_sync_debug_bo()
> callback while holding xdna->dev_lock.
> 
> The callback may call amdxdna_cmd_submit(), which in turn calls
> amdxdna_pm_resume_get(). If the device is suspended,
> amdxdna_pm_resume_get() may synchronously execute amdxdna_pm_resume(),
> which also acquires xdna->dev_lock, resulting in a deadlock.
> 
> Avoid the deadlock by calling amdxdna_pm_resume_get() before holding
> xdna->dev_lock in both amdxdna_hwctx_sync_debug_bo() and
> amdxdna_drm_config_hwctx_ioctl()
> 
> Fixes: 7ea046838021 ("accel/amdxdna: Support firmware debug buffer")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>

Reviewed-by: Max Zhen <max.zhen@amd.com>

> ---
> V2:
>    Fix jumping forward over the guard(mutex) declaration.
> V3:
>    Fix the same in amdxdna_drm_config_hwctx_ioctl().
> 
>   drivers/accel/amdxdna/amdxdna_ctx.c | 26 ++++++++++++++++++++++----
>   1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
> index ff6c3e8e5a15..2ab4443e7094 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
> @@ -356,16 +356,25 @@ int amdxdna_drm_config_hwctx_ioctl(struct drm_device *dev, void *data, struct dr
>   		return -EINVAL;
>   	}
>   
> -	guard(mutex)(&xdna->dev_lock);
> +	ret = amdxdna_pm_resume_get(xdna);
> +	if (ret) {
> +		XDNA_ERR(xdna, "Resume failed, ret %d", ret);
> +		goto free_buf;
> +	}
> +
> +	mutex_lock(&xdna->dev_lock);
>   	hwctx = xa_load(&client->hwctx_xa, args->handle);
>   	if (!hwctx) {
>   		XDNA_DBG(xdna, "PID %d failed to get hwctx %d", client->pid, args->handle);
>   		ret = -EINVAL;
> -		goto free_buf;
> +		goto unlock;
>   	}
>   
>   	ret = xdna->dev_info->ops->hwctx_config(hwctx, args->param_type, val, buf, buf_size);
>   
> +unlock:
> +	mutex_unlock(&xdna->dev_lock);
> +	amdxdna_pm_suspend_put(xdna);
>   free_buf:
>   	kfree(buf);
>   	return ret;
> @@ -386,16 +395,25 @@ int amdxdna_hwctx_sync_debug_bo(struct amdxdna_client *client, u32 debug_bo_hdl)
>   	if (!gobj)
>   		return -EINVAL;
>   
> +	ret = amdxdna_pm_resume_get(xdna);
> +	if (ret) {
> +		XDNA_ERR(xdna, "Resume failed, ret %d", ret);
> +		goto put_obj;
> +	}
> +
>   	abo = to_xdna_obj(gobj);
> -	guard(mutex)(&xdna->dev_lock);
> +	mutex_lock(&xdna->dev_lock);
>   	hwctx = xa_load(&client->hwctx_xa, abo->assigned_hwctx);
>   	if (!hwctx) {
>   		ret = -EINVAL;
> -		goto put_obj;
> +		goto unlock;
>   	}
>   
>   	ret = xdna->dev_info->ops->hwctx_sync_debug_bo(hwctx, debug_bo_hdl);
>   
> +unlock:
> +	mutex_unlock(&xdna->dev_lock);
> +	amdxdna_pm_suspend_put(xdna);
>   put_obj:
>   	drm_gem_object_put(gobj);
>   	return ret;

