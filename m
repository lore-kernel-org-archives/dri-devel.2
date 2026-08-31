Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B2F1C61DFD
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 20:38:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82BD910EAEE;
	Mon, 31 Aug 2026 20:38:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YnafyvRi";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013068.outbound.protection.outlook.com
 [40.107.201.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03C4210EAEE;
 Mon, 31 Aug 2026 20:38:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=or0gt6R5lANH1Q66KDqxs3QGVyY4q0197CtGJrJ3lGsM+d6medZnCpok8kay4CAdVRtQUI/GNX88NiYfQmG1L5VtRcO2/rHBKFUH9GHVKKgUjM1hNfXHQXfVrIROBwAmCctmHtQGrzeFCN/X/2c/Iv992iISLDJW7XmGxgtJw625f+kcsHqunBM9w90NNH3RcHIYGiF4XNfPzMrPJ+OH1rlkRbAZz7gCRTLwogpjt2cbWhJGGezJErhmugmk/lpubYC2gj+yqeAIMPLmkMh7hggpbhNSMvByIEzUNn4wqRy/mW/Fbe4l+KKni5DStZSZbCHwzrEdB+SSXi8r3DYdzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiBLbDYuOddXr8BPQj1XByb5doocaLWPpHCBpF7zqxQ=;
 b=l2CugGPv2xKOJktBywhPc/ID5J7jY3MbdK1X2Fu0eMKoNbP0ssgsUQTdg6uePau/p4L3tnMR7N7bSxUezHMq1ojQoabM5HwYH0WCs56avf5TKfYZR5JsUt6aqoYwJGx4cX/nCYv2LD7LvoQZJ9s2WS/14wl7hDF6uGtPMRhcxe7n7L0ZrP4Jr/R+8kiq7SWoSfxs4XgjfOpgfQ2aNQJuZmBZ4bPFuqcvAzBTxq8DzzVcOKEswnLVbsdByr8dlYIOUoX5y+vl1UM0S0li0jdDWdMaV5yVLJNCJ8DIg40j5j4qEXUjvtJxXZJL/m2vRa3PdX06RVKB0rl61cAtTpq/1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiBLbDYuOddXr8BPQj1XByb5doocaLWPpHCBpF7zqxQ=;
 b=YnafyvRiROOytFGHkdklyM1m6/3o4J57N2biSqJj0XSPd2oqiJo44XdyUnuG9FPEMluWTUIXm5wIhV8iEmK/Pl6IEl1SJuUlAHWhTyJzYwl1ynO37xBn0d06sMep5CRnsEsADTj/LRTwx1rAsyHmLapQPT3IedqruD0hn+8LvQc=
Received: from BL1PR13CA0384.namprd13.prod.outlook.com (2603:10b6:208:2c0::29)
 by PH7PR12MB6737.namprd12.prod.outlook.com (2603:10b6:510:1a8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 20:38:06 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:2c0:cafe::9b) by BL1PR13CA0384.outlook.office365.com
 (2603:10b6:208:2c0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.9 via Frontend Transport; Mon, 31
 Aug 2026 20:38:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.0 via Frontend Transport; Mon, 31 Aug 2026 20:38:04 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 15:38:04 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 15:38:03 -0500
Message-ID: <44919809-5a71-70b9-84dc-1c4cac3eac46@amd.com>
Date: Mon, 31 Aug 2026 13:38:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] accel/amdxdna: fix NULL deref and GEM object leak in
 error paths
Content-Language: en-US
To: Deniz Aydogan <denizaydogan1902@gmail.com>, <amd-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20260829080016.10002-1-denizaydogan1902@gmail.com>
 <20260829085644.38103-1-denizaydogan1902@gmail.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260829085644.38103-1-denizaydogan1902@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|PH7PR12MB6737:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ecb6f82-523b-4135-36f7-08df079fc1f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|10067099003|3023799007|18002099003|22082099003|56012099006|11063799006|4143699003|13003099007;
X-Microsoft-Antispam-Message-Info: ZUx5j65QqhDMIayjDEs+TFb47N25wCvXthgivExsk4ROUAvlF3z+SwZXBdW9HxETUEgzvIfalTwhg13DzXTYERN4EUNUmKJBJFUUKlvS7ECu0C04cp0FRvIlM46qLa0h6sHZB0tDN3X/SZwuKuLQz9fXQ37wYZxcgBaeILisA6ylvYX0TIzMHsAAnh6sTehH01NCKDOx+qHo6ZR2/zhL4ishrNXXN6pZhBFVVgYisGGyzdataUtMkJXg80vR8xdlphjc3TaQsvrvu1Ht3FTew3w0Og7ZAKVLwSd/8xk0Nh6j9Jks8Lxy55ge5NHz32P5DilaBGrVVkdASIa2uwlJncWl7hYLf7tA2P7LrtRa/fELxIElg5INdxRUXBEqMjvaiFd8eFTmfMDtXyDHNqpheuHf4dR52trS21mDYFRg54t6YV7AVfGkdyfNYmf/XbVCQnfufZIZu11/dUJweshHri7PC28glH/M8nKp3KUyzI9/axSpI9oCIz4d3MZTC6ZkJGR2hagfk+6s1F7BtVfVXXr+Kt1zWFqW8fBThOrqP85h4lqK/UqNwzWiglmsXzjzlqbF8S2gf5smbauStf3elk5o4xQUrTv1Cfs649841TPuLNzy+GkTRsZjXHDB61sZO+DcOxg3tXQk/q/kKW95R+XUFVBqv0RgEL9hZbDgrlrM6PRkxWPiZehacp2+5qGr4CFRwdZCw/mNLTuS2TKfhA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(10067099003)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ymvl/Nv2EZ9PSi4/cX6So594ZXCVQYdTn/0BpGsg+p97o3iuUFvGXpjIUHM9XcjnpF2/5vMYE0S5eY+Q6S/UMr1YngkkcEYIRg7e7YtdfjRa5SEiyiaPBL1jA3jwx8ZfWHQOJu4aRd5LuiQTGVx0v+iAobz5+7nioxtANMoBt3erl3sry2FI8xwjqja4u1k4cslHJS9E11TQZLuSlImzkJOMPi+MIxeHoi2uDHfXFRGbXOOtw6/qo3HO1Hyi5eoTyB/QlxSaag6QJbcpMt62W9wL9GdS4H4hyfyFW+3kI9Al37e6KM2iKhsmXlP5Kp6BloHs0Cx75MMj5fmRa9Rx116hCttw/0s4tYGqIjZ5bMosgoJulBqblOdEKYpNf50hjo3tSqQ3/k14zcoD/56IxgqlhdGezNTQk8d8aUXfWdWWapm+mZYzVN5RXIjvE7UM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 20:38:04.4744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ecb6f82-523b-4135-36f7-08df079fc1f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6737
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


On 8/29/26 01:56, Deniz Aydogan wrote:
> amdxdna_cmd_submit() does not set job->cmd_bo for internal driver
> commands that pass AMDXDNA_INVALID_BO_HANDLE. When such a job hits
> an error or completes normally, both the submit error path and
> amdxdna_sched_job_cleanup() call amdxdna_gem_put_obj(job->cmd_bo)
> unconditionally, dereferencing NULL.
>
> Separately, amdxdna_cmd_set_error() acquires a GEM reference via
> amdxdna_gem_get_obj() when handling a chained command, but leaks it
> when the subsequent amdxdna_gem_vmap() returns NULL.
>
> Guard all three amdxdna_gem_put_obj(job->cmd_bo) call sites with a
> NULL check and release the GEM reference on vmap failure.
>
> Fixes: 3ba13f5e7180 ("Merge tag 'devicetree-fixes-for-7.3-1'")
> Signed-off-by: Deniz Aydogan <denizaydogan1902@gmail.com>
> ---
>   drivers/accel/amdxdna/amdxdna_ctx.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
> index 31a414c3f..a806702ec 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
> @@ -183,8 +183,10 @@ int amdxdna_cmd_set_error(struct amdxdna_gem_obj *abo,
>   		if (!abo)
>   			return -EINVAL;
>   		cmd = amdxdna_gem_vmap(abo);
> -		if (!cmd)
> +		if (!cmd) {
> +			amdxdna_gem_put_obj(abo);
>   			return -ENOMEM;
This is fixed by: 
https://lore.kernel.org/all/17811ffc-f33b-b3ac-865b-18138239e0dd@amd.com/
> +		}
>   	}
>   
>   	memset(cmd->data, 0xff, abo->mem.size - sizeof(*cmd));
> @@ -575,7 +577,8 @@ void amdxdna_sched_job_cleanup(struct amdxdna_sched_job *job)
>   	trace_amdxdna_debug_point(job->hwctx->name, job->seq, "job release");
>   	amdxdna_pm_suspend_put(job->hwctx->client->xdna);
>   	amdxdna_arg_bos_put(job);
> -	amdxdna_gem_put_obj(job->cmd_bo);
> +	if (job->cmd_bo)
> +		amdxdna_gem_put_obj(job->cmd_bo);

The current code will not crash because drm_gem_object_put will check 
the if the obj pointer is NULL.

And I agree it is more robuster to check job->cmd_bo. Could you remove 
the "Fixes" tag and previous leak fix?

Thanks

Lizhi

>   	dma_fence_put(job->fence);
>   	mmdrop(job->mm);
>   }
> @@ -676,7 +679,8 @@ int amdxdna_cmd_submit(struct amdxdna_client *client,
>   put_bos:
>   	amdxdna_arg_bos_put(job);
>   cmd_put:
> -	amdxdna_gem_put_obj(job->cmd_bo);
> +	if (job->cmd_bo)
> +		amdxdna_gem_put_obj(job->cmd_bo);
>   free_job:
>   	if (job->mm)
>   		mmdrop(job->mm);
