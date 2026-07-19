Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441F7C4451B
	for <dri-devel@archiver.kernel.org>; Sun, 19 Jul 2026 22:29:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8477310E03E;
	Sun, 19 Jul 2026 22:29:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VHl2fAXO";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010033.outbound.protection.outlook.com [52.101.56.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5185A10E03E
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 22:29:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PE20gdZPZ5ru9xAEUE0Eph6WHc0/vL+7viECMtdCMJ4kDIMS1MsxuLtzqKO/VsOjI+nlu+cE3sq+u3R9RuE2B26nz22wRE6GCfzfX5HhdW7t5Xm6fULa48z11+/vi3vQ37NjBiRrliZqccM8fiYR6TmrhV5wrCN3oQF4xROfUZkH9yDlsz5c3EkZb1Hzkecf6eXMjgHhYqMauKA83wgB2wwoKns9PVEiel8omgjGdsHY4ElVsceTeriVM3JBtKvzvH6aLyPkA4sWRPOCpJdgu0AqXn/Zu8wmgK45/wZVXZKqMXovrRHBwhscqhvWzzdRGAtBoVLFyduXKhr2Xvm31w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxcYRgipW9Dw5l+YVHwa4z2+c4TyWB87p5wqI+iK6M0=;
 b=WGRkYcUb+efJr0nf4hAzb5Ua7z2uGx3kaNKSq8RM4GNrwiffyUyGbp/vM0ixZSQxZWW7hNofuxCdJXPuxh8YZqbjAPF6sXbLHNBMVhuq+EkSUkVa2PJsRHqg+aG1dH16LiLTooizfpLhvDYjICBs3WYTGOWegrBRBVMB1Lnj2jbogJA8KIKt6ezRlaPqFzhPa0ip9K32UMDZ3UT6OfmdYuFEfFx5rZFqvzIk+y+M1xt5Lh5MeaiuNbW2kfd1C+8ubqXz0v8NlJvzvxJCc5pr3UPadYAsySbRb5BrZm/oHJQj9AcQJJzdPzq4amwWFYxxu+9+h1mCHGJwImF8Jiol/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxcYRgipW9Dw5l+YVHwa4z2+c4TyWB87p5wqI+iK6M0=;
 b=VHl2fAXOICft3kpAU4zPfpi8Yb9aNyMhMXKkbr2GILNotBXxhYrlB7mNvpCy1zAJQDP3R6HxcinVrmLFzwyfheiaJvDZdaPNTWTd+NeYsQVTztAM4Cn+3f365MnJC2eG2MbWtMoeAi7KQGgNbINQ0teWbk/x38/PWItdm9kmK38=
Received: from SJ0PR03CA0162.namprd03.prod.outlook.com (2603:10b6:a03:338::17)
 by MN0PR12MB6270.namprd12.prod.outlook.com (2603:10b6:208:3c2::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Sun, 19 Jul
 2026 22:29:50 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::2f) by SJ0PR03CA0162.outlook.office365.com
 (2603:10b6:a03:338::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.16 via Frontend Transport; Sun,
 19 Jul 2026 22:29:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Sun, 19 Jul 2026 22:29:50 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 19 Jul
 2026 17:29:49 -0500
Received: from [10.252.50.43] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Sun, 19 Jul 2026 17:29:48 -0500
Message-ID: <5ed0acbc-ec50-4055-9e03-cc4aa730c293@amd.com>
Date: Sun, 19 Jul 2026 15:29:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Fix command timeout race
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: Wendy Liang <wendy.liang@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>
References: <20260718083409.1825940-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Max Zhen <max.zhen@amd.com>
In-Reply-To: <20260718083409.1825940-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|MN0PR12MB6270:EE_
X-MS-Office365-Filtering-Correlation-Id: fb4cf310-d722-4d45-a2ca-08dee5e53f4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|22082099003|18002099003|3023799007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: WjzLYBPILbzBZTWzkrrClNhs55nncMYtAeRVj/MNmGzqHNvGo/CHB6o3ZIm1jveujQseo778m2pGh4/q6UBF8hQXHLlu9s1nhX4hM16mhvkam4ZMIllqFs1bqWjcAs3zgVIgB8qEBqIxAsUelOBgjBV7BkDD/zttIBKTS9JXX62HBDX1m7q05UwtCl4gDByUZrO0lnr9SlY2Hq6gdNfWvrHtYOdSpD86ri9MaAdTSa8rea3AJKXWtOIriXCSrcTjKx7OBOlpceApq0XTPz1k6dzesWL+KC5t1eztkLHaUq1TgPVsRxw71e4gTQzwgqVkdMgZ3Ej+kmywB7nu03WG0CG28BiSKCzU91AADSMo0oPondMLqpXnqlzNqivQYg/p4fdQ9OB4kaxHHWhhiHibJ5Oku88SDU5iv2t8oAGUINa0N2dklFhcVAMj2pLXOAyZnJbMyXbl9yHWy/NNb3GuDr0wR+6Ez9+ndg0spfnSVcZanEiMZSR+B5phIrMHsbHih/HpcevPfqKv71N69vuqHUb6GdV0yI1mCrOQa62qgHjjnyxXCsU+xGiI4iSi6sqxXTvTfXF+O8il5Uzhu4ToGnN0YpH4y/8z2oCg2jxEDHcaxKoqzzBJ/tPn8QDKN7D9LKgpiBdxSiulyv5YGRhdCRDBQzQaeC145h75F9hBBs/S9XgIf4ANQmP6gzwigkSq5DmIJ7piQEaI63cfnVAhww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(3023799007)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oRUVW996d2nsAg1N6e0p+AjdsiiSLTNGJtIwmg8vmvy/uBOwn2l1PfDRAVL7ns6mI/mvbbJlqxWDpIP7sKOM70hBCRZPcDIWSemKxb7N17rl2F0b4k/k0EQ0VsuP2Qs0XZEKU+59/TyiA10TAxMecnJ7+zWhcMCud6pUPpD4BShRYw8twwgBibxWl0pxemei9Z8M29kmZDr2P6ATJHGJWpNBpALNfmLqkwH/G47B/X+x5CXFal3MowBXKZoPzy0dVanWatmRPGqsl7tDBK7GlDHr1d3Ok+Uxcw7PERBpmi76GL0TR6d8b+KN0/ooMYfoQaLqZOk8RrnxZVBgdbTUKxcbsDCSuii5NP7MA4Vn39+0UFsQZ/s7vN1XNYK6zKeiMMXiNXUityqT0SvwBbskYik927wdBe1l52F3jfGIs0bbdMi/9EhSJJExbgWHOY2t
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2026 22:29:50.4038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb4cf310-d722-4d45-a2ca-08dee5e53f4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6270
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



On 7/18/2026 Sat 01:34, Lizhi Hou wrote:
> From: Wendy Liang <wendy.liang@amd.com>
> 
> When two commands enter aie2_sched_job_timedout() concurrently, both
> check the timeout detection state. The first scheduler thread observes
> tdr_status as SIGNALED and updates it to WAIT. The second thread then
> observes the updated state instead of the original SIGNALED state, which
> may cause the command timeout to be handled incorrectly.
> 
> Replace tdr_status with last_signal_ts, which records the timestamp of
> the last driver signal. Timeout detection now only reads
> last_signal_ts and never modifies it, allowing multiple serialized
> detect() calls under dev_lock to evaluate the same signal timestamp
> independently. If there is not any new job scheduled or completed
> within tdr_timeout_ms, the command will timeout.
> 
> Fixes: 9022f010977f ("accel/amdxdna: Check for device hang on job timeout")
> Signed-off-by: Wendy Liang <wendy.liang@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Max Zhen <max.zhen@amd.com>
> ---
>   drivers/accel/amdxdna/aie2_ctx.c | 22 +++++++++++++++-------
>   drivers/accel/amdxdna/aie2_pci.c |  1 +
>   drivers/accel/amdxdna/aie2_pci.h |  7 +------
>   3 files changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
> index 101f324ee178..94dfee7263bd 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -43,20 +43,22 @@ struct aie2_ctx_health {
>   
>   static inline void aie2_tdr_signal(struct amdxdna_dev *xdna)
>   {
> -	WRITE_ONCE(xdna->dev_handle->tdr_status, AIE2_TDR_SIGNALED);
> +	WRITE_ONCE(xdna->dev_handle->last_signal_ts, jiffies);
>   }
>   
>   static bool aie2_tdr_detect(struct amdxdna_dev *xdna)
>   {
>   	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
> +	unsigned long last = READ_ONCE(ndev->last_signal_ts);
>   
> -	if (READ_ONCE(ndev->tdr_status) == AIE2_TDR_WAIT) {
> -		XDNA_ERR(xdna, "TDR timeout detected");
> -		return true;
> -	}
> +	if (!tdr_timeout_ms)
> +		return false;
> +
> +	if (!time_after(jiffies, last + msecs_to_jiffies(tdr_timeout_ms)))
> +		return false;
>   
> -	WRITE_ONCE(ndev->tdr_status, AIE2_TDR_WAIT);
> -	return false;
> +	XDNA_ERR(xdna, "TDR timeout detected");
> +	return true;
>   }
>   
>   static void aie2_cmd_release(struct kref *ref)
> @@ -434,6 +436,12 @@ aie2_sched_job_run(struct drm_sched_job *sched_job)
>   		mmput(job->mm);
>   		fence = ERR_PTR(ret);
>   	} else {
> +		/*
> +		 * Command is successfully posted to hardware, update the
> +		 * tdr timestamp. The total pending commands are limited.
> +		 * So there will not be a case that driver keeps posting
> +		 * commands without getting any hardware respond.
> +		 */
>   		aie2_tdr_signal(hwctx->client->xdna);
>   	}
>   	trace_xdna_job(sched_job, hwctx->name, "sent to device",
> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
> index 22f66c7f534d..daec1f6b4907 100644
> --- a/drivers/accel/amdxdna/aie2_pci.c
> +++ b/drivers/accel/amdxdna/aie2_pci.c
> @@ -420,6 +420,7 @@ static int aie2_hw_start(struct amdxdna_dev *xdna)
>   		goto stop_fw;
>   	}
>   
> +	WRITE_ONCE(ndev->last_signal_ts, jiffies);
>   	ndev->dev_status = AIE2_DEV_START;
>   
>   	return 0;
> diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
> index 77648cc548b6..ea1dac106400 100644
> --- a/drivers/accel/amdxdna/aie2_pci.h
> +++ b/drivers/accel/amdxdna/aie2_pci.h
> @@ -143,11 +143,6 @@ struct aie2_exec_msg_ops {
>   	u32 (*get_chain_msg_op)(u32 cmd_op);
>   };
>   
> -enum aie2_tdr_status {
> -	AIE2_TDR_WAIT,
> -	AIE2_TDR_SIGNALED,
> -};
> -
>   struct amdxdna_dev_hdl {
>   	struct aie_device		aie;
>   	const struct amdxdna_dev_priv	*priv;
> @@ -179,7 +174,7 @@ struct amdxdna_dev_hdl {
>   	u32				hwctx_num;
>   
>   	struct amdxdna_async_error	last_async_err;
> -	enum aie2_tdr_status		tdr_status;
> +	unsigned long			last_signal_ts;
>   };
>   
>   struct aie2_hw_ops {

