Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C81D9CD6E57
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 16:52:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35BEE11211F;
	Wed,  3 Jun 2026 16:52:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BtzUGiLO";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011037.outbound.protection.outlook.com
 [40.93.194.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7074F11211F
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 16:52:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xjod56X8bjPiV0PnMyhmoGVgMn1iyfy+EKMICrLiJsmTdeN5uH4OGG+79gWwixtY4CKyOoofuKM1fjK+J/eq5BR4jkIszI35gU54Y5TfUAc1l8SYFculmT92iA6yLocobc5TPA0trpHqCkJEKYjLCmAAarh/Jugav5xcgch6V+jZloIfMAt65DWR2j55iIT/fJSRlID6riFLTadJ8DYz4ETdsau3dFkrf3XXK+ArtkDNhSbT24KugYXVFwI8QD+R/Z3FLsWs4JStDm0ORs1oUuZF15UPzuomtNjATBgRfTOroE9A8fTtVc6ocOSRrq5G5SMBroXtKl0LbEJZpBhZ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGczZD+It3LXM2xwbGaPxyubQ6IPzgYUVdQbRtScvUo=;
 b=QN3yY43rGTQlF2fjNlE203tZPFX0plDwHPqZ+jUFETM3ptZqniuLwjLAtTX3kDob6sbFrjmsRaFeqHAwNxlJOHbQX6ni7q3dMnV9Z+aKifpltmAy0GAm+lhrF5/xVHYPQUc6vU+00phZwmnQBSzjslaJ7bj8fxMqesnvrWcMbk8QqujsnKCokGI7pD6Uvk+QhA4gnfqu7WD1eKEaWaG1vQTA83BF1zxds2w8/kzulVWB4GNARfsVwhdEEiEoltkvElKAEYVbH8JoD0eOQ8G8jC/uHUhRyFGSSxBITwv+Sf44VBISesNX1oYwPjXqZrtmE4jdtZ86oC52yEmi81FSIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.dev smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGczZD+It3LXM2xwbGaPxyubQ6IPzgYUVdQbRtScvUo=;
 b=BtzUGiLOTs8ymDrYOaEyM51onmFNCgwJVWbOBWQcGf0g5SHl35XLxOgPmupkdU6SPYX1/HFrKOYvl8GWasdZScHJYRd/xlFTyR5LDOAmxlPASb64ZA123giJsdVoySJltWmDQTsffl+ke4Pr5MiBtLPIwbcmylXdh+QiuLmU39I=
Received: from DSSP221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:3d5::10) by
 DS0PR12MB8455.namprd12.prod.outlook.com (2603:10b6:8:158::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.16; Wed, 3 Jun 2026 16:52:22 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:8:3d5:cafe::1d) by DSSP221CA0005.outlook.office365.com
 (2603:10b6:8:3d5::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 16:52:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 16:52:21 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 11:52:21 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 3 Jun 2026 11:52:21 -0500
Message-ID: <cd920aab-40a8-aa57-e33b-67c01cca6f91@amd.com>
Date: Wed, 3 Jun 2026 09:52:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] accel/amdxdna: fix error code being silently
 swallowed in hwctx status queries
Content-Language: en-US
To: Jackie Liu <liu.yun@linux.dev>, <mamin506@gmail.com>
CC: <dri-devel@lists.freedesktop.org>
References: <20260603013543.94835-1-liu.yun@linux.dev>
 <20260603013543.94835-2-liu.yun@linux.dev>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260603013543.94835-2-liu.yun@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|DS0PR12MB8455:EE_
X-MS-Office365-Filtering-Correlation-Id: d6eb29cf-f0c0-4114-f9a7-08dec1907b32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|56012099006|18002099003|22082099003|6133799003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: CpU2tzt/vhCuvzyGI6zVHKY0WK1ajlSmq7HvFRxbUv8DWpGRa4Jxy340uw8RyrUbHh1YenwATdfBmxEML7RRjRmjsBpY7cHNPa8Soal2OAgjjDjJTQzC4y8ArJpHO1hasfMocObtAx08O80DgUksyBlvYsReBGNidHsvWO8VmRIdk7DuffOHlcjSh9EN2G4+8ZdYUAyyrje8W/dJ4V+cCaFrmcLnj8qQy9Ea2Mx19dPXEEvlK40qrstxyGPB1ng7GuR2TxJNwLOBlFdywep0B0EU636BRFiBot/4u12u0a820HjjW5tALoYM3G/hXWTIxBDwxFw9L0bkcSvJpgf/hzog2dXwzPgGGVAGB7UJ/bRByXGoNvlX83ZsOkdO+fPudAluUi99pKF98XYr9P5WL8ZKjBgZd9TUfwnW5xkTcQ1apAO1bhXDZEmJbzjCshwn2/1s/9wGyPAAP3BvtpHnzvaoNR0jziycX5uymxaz+AQIAhDhyzmAfqJiV7XacgrB5g0lVg0KmSTAtjhR7YrSoMtRRj79JAEljOS9+HEtojIjg8f9piStpEHzB66YblDpS9ppLvlQqC4orTD3ZGJKwXy+rEzyDU94romLptH/c0yEVZ6dFNJadL3R43J0tUN+qFyrNz55CVZ+WDJ8yGw9Yu/aUtO7v+9qvEKCHZbNCquPSm4RnN7z0dMiOZv7CE0EhiBPI2FnpicBE5ts/vXDHWO78++p53XDa5GjGo/Itxg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(56012099006)(18002099003)(22082099003)(6133799003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vMhzWasyCkvtUOsyZMCpTf2hIqmKxoUb2PJYz22ozKkk/i2qlQyTSuwNLl+/3rWO4NJkL+01YkTSvDTKkfabxmyjuh8wVV7ges8T7MJKrrYFijX2UJyVxgC2cKDOPhpqiiWPcl5NvuUqC5k8Sc/7PiGdGV/T5e/UCZjrR0ODnwTTqgqM8exH3pYFF0LaYA/yK/StG0R/p0t7yjlTdniIVuPNAjVD/hPGrpYR/sfTA2BluEqGieEPbtozvwQ9mQjG/laX0nZV8XGEx7mIxMUyZsM87Xf6yuSxQ69snBO0pEsGy+C4eZLUJE4hLQ/KocDGJUBXuCWhJzfOkzduBDqZR2rMJz2uOFsKRtVnkjlSb52bfPqPi7F/Pg5+M0GkXwKdAKnVAGRwULUkHaLw0bIAc/nIBXH7CuuXh9h14/6bdBhQJNjAsoKnMFO571Sjrp51
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 16:52:21.8717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6eb29cf-f0c0-4114-f9a7-08dec1907b32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8455
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


On 6/2/26 18:35, Jackie Liu wrote:
> From: Jackie Liu <liuyun01@kylinos.cn>
>
> Both aie2_get_hwctx_status() and aie2_query_ctx_status_array() iterate
> over hardware contexts calling amdxdna_hwctx_walk() with a callback
> that can fail with -ENOMEM (allocation failure) or -EFAULT
> (copy_to_user failure). When the walk fails, the loop correctly breaks
> but the functions always return 0 to userspace, swallowing the error.
>
> This means userspace receives no indication that the data may be
> incomplete or that the operation failed. Save the error code and
> return it to properly propagate failures to userspace.
>
> Fixes: 81233d5419cf ("accel/amdxdna: Fix uninitialized return value")

The retrieving information can be partially done. The amount of valid 
results is indicated by the returned buffer_size, element_size, and 
num_element fields. Thus, 0 is returned. So user space will not consider 
this is a broken error and still get the partial results.

Lizhi

> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>   drivers/accel/amdxdna/aie2_pci.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
> index 4500b9ccb02e..0ff87fafd049 100644
> --- a/drivers/accel/amdxdna/aie2_pci.c
> +++ b/drivers/accel/amdxdna/aie2_pci.c
> @@ -908,7 +908,7 @@ static int aie2_get_hwctx_status(struct amdxdna_client *client,
>   	struct amdxdna_drm_get_array array_args;
>   	struct amdxdna_dev *xdna = client->xdna;
>   	struct amdxdna_client *tmp_client;
> -	int ret;
> +	int ret = 0;
>   
>   	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
>   
> @@ -923,7 +923,7 @@ static int aie2_get_hwctx_status(struct amdxdna_client *client,
>   	}
>   
>   	args->buffer_size -= (u32)(array_args.buffer - args->buffer);
> -	return 0;
> +	return ret;
>   }
>   
>   static int aie2_query_resource_info(struct amdxdna_client *client,
> @@ -1105,7 +1105,7 @@ static int aie2_query_ctx_status_array(struct amdxdna_client *client,
>   	struct amdxdna_drm_get_array array_args;
>   	struct amdxdna_dev *xdna = client->xdna;
>   	struct amdxdna_client *tmp_client;
> -	int ret;
> +	int ret = 0;
>   
>   	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
>   
> @@ -1131,7 +1131,7 @@ static int aie2_query_ctx_status_array(struct amdxdna_client *client,
>   	args->num_element = (u32)((array_args.buffer - args->buffer) /
>   				  args->element_size);
>   
> -	return 0;
> +	return ret;
>   }
>   
>   static int aie2_get_array(struct amdxdna_client *client,
