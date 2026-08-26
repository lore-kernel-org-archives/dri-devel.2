Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3BBCC5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 23:43:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB74010EE1E;
	Wed, 26 Aug 2026 23:43:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IpvXchEe";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010036.outbound.protection.outlook.com
 [40.93.198.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1D7E10EE1E
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 23:43:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ah1uccOmtqme3YQVQrYfYRn/3Vv9rzTMHsyzznjxcyp0fIQTK6cqIJEejJMS18zpIRVhwSib0j2fJbIe/YYZFGfpVX1TQ/t/vy6lmTJZXDLHIro8GYJkO5OV5rtX0RNJv+sjgUS8tBSHbZ5DXp9eH0Wl2rjutAN/yvVc4E8/pD14Dvy6adGQt+RjgppV1gmRzIe0n6DetoLWkGDdfSw0J2urXSaXVJTzztLv5tPLmIVFTQlVNXvc2hK4AzNXefVTraYnU3uTV2Dg7P/okh36wMzAJaRk+MP0gpmgYSaCK49Ovnwprs42LM4TN5ZTZyjlw4ynFrJw/5EqZZmCjUAvnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=negefsq3n/CCIYYmlXfAwis0SAFuolerph9KBNGmRo8=;
 b=ymiVk3mAvNs3+MaSuGiXAI3BBeJMlXtfgHh+DscTQHTrJhgKl8JROyhbkohp0mxHNyXzTcJYtPxX2FSreDMeaxJ5uY8MMnwHh8gnKmL5Br4tzvB+13kw9a/thCDM4qO33qChZJ0pEJbl5d9YV6xpx4y/u7OyZkpKzYisWxu3jvWEGeugkhd7cqfhVkRwr6R3NU+39BG+nymHPPLXdan+z1BL3vhGjwYMJWj7DoyFuLXHVmBsjIIGoWoDABg56lPj1I1l/+DPsVAA5KWoKHFmLcLzOz46STnLpgmLYcexh3G2jQerpHtGMN80Hr+ArRhq5FY+5B9vPKFoVJo5P63LfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=kaitmazov.com smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=negefsq3n/CCIYYmlXfAwis0SAFuolerph9KBNGmRo8=;
 b=IpvXchEeSuXU6pvQAT33HMTtuiXu0JHL0+qKE0rQz7uRCZP3tL6rUw0hC/pKC9uN9y2UZb2MHKb9Xv+ZMtNytTDJ2z4s2lHq9GPt3uTtz1PR8sbWUcDOurABPXo/ZUZIfjDnA8gU7AhAf7EGzRP8UjuyANurzwYJUc3FSlr1tpk=
Received: from DS3P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:45e::6) by
 SAWPR12MB999115.namprd12.prod.outlook.com (2603:10b6:806:4e3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 23:43:29 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:8:45e:cafe::31) by DS3P221CA0001.outlook.office365.com
 (2603:10b6:8:45e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 23:43:29 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb08.amd.com (149.199.90.133) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:43:29 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:43:28 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Wed, 26 Aug 2026 18:43:28 -0500
Message-ID: <a1ba2664-b7ec-cb50-98e0-f14e766d93b0@amd.com>
Date: Wed, 26 Aug 2026 16:43:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] accel/amdxdna: Invalidate the payload of the command that
 failed
Content-Language: en-US
To: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>, Min Ma <mamin506@gmail.com>, 
 Oded Gabbay <ogabbay@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20260826222735.672227-1-taimuraz@kaitmazov.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260826222735.672227-1-taimuraz@kaitmazov.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|SAWPR12MB999115:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a6b536d-6e06-4603-1b77-08df03cbd4ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: NjJIeT1PpJ41f8LV786VPGoEGJq68+ZvKtqES1QJzk81u4FR9scV6CcEqvtYKmkN7/3mCxNwaT9ioSK1Q+TC5Bf+qJdDh/T9/FFi5AR3vmqMOFeTBOYMbYQOgR5dGY4tZoLtacF6eszIduGYH8c3tjXbU3Gm5J1kBUNvilfwWPUXW3Df4gw1CinoKpHUCB9fjrlIP5v2on9AWwvDG2kN+sOiACu0Ew6b+1MN7JjLG6ey0qZmGIY/yC2QbTqR7jkc5xE3o7GEa7WqUIN8p95bITx7UaNEqFAOKa9qhOvZcHlJkrBzKXw3yPA13Ct/3ZQS5K/mMN/Ms0akFXS6SbFRiUa3KmoNoF+Yz1g1y54XShS/RzryKIloB72pmmCU9egJco4veFBh8ZxecNentfMnVNnMnwHEyYUVreIowXzIydkRkDt/TpUoTteDiQnWPn6i1xuj9ZEuzFCqHPSSvZ4kT95ufH7T1QyH5IWeJQuNhJVFjcJ/Wf0E6ujS8eQGpuLeqdhcdxXMbMSdq4IBwm/GGcyINGCkAOUeHfnJE2u/UXprapAtSH330BL5l87ydZ67Buq1nvArG24rpSQLySeN60JHZEiorAT/+Vu+qnxAmmi7rGblZZSljCD4ti4a01hgLb9kTX3P0nhHeabKOYtGZQ6uwZ2PCHLEnxJfASCCzVOUKqEBAcgWV+uDh6eVn9UMzLDQTM8zCUARGa85YD8RTg==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2z1vuTL1KZIUKw7eDP8nrvc/CjtA2Feg5LAFhQ4gXn7V/YP9+l9GdY8U4KdDcgCJTPD+iT9xPTjJlP/zkzszrG79dkCrx9PAVkTiGAAlKYCTF9eG//W1iAFTkJquBOxtf4LSOuXJLP38RtrjI4UXc9zwK+nmUHVDrpM4vRpQfd420S29VD8nash7x/55pJ1yN9gZmZiazGdMoIvxnDJx7abJhnsRw+1kSUnkR+TOyFKMGSsucwSwmNW5nT7vwf9arFGqFKcw10dLzVuZkbAmkvIQVQdtJ1+FSItck1lX6KM2XYTi8Ttao1nh1iLx/rdT1R3R9lADLKVtPRW6uvnuzUfjFiiWgKc2ZMY/sjqkATdB0c/Ih3OcNW4Q2bU4mCB72q2wvZOpea7KCO6gWYuVSThC3nIDg8IvS3TrEQLvjXtCnG88d1ymFRdLb3nHLqYl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:43:29.2273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a6b536d-6e06-4603-1b77-08df03cbd4ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999115
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


On 8/26/26 15:27, Taimuraz Kaitmazov wrote:
> amdxdna_cmd_set_error() computes the failing command's index into
> cc->error_index and then looks up cc->data[0], so the 0xff fill and the
> err_data land on the first command of the chain no matter which one failed.
> Commit 89ff45359abb ("accel/amdxdna: Fill invalid payload for failed
> command") added the index and that lookup together, and describes the fill
> as being for the failed command.
>
> So a chain that fails at a later index leaves that command's payload
> untouched, which is what the fill exists to prevent, and overwrites the
> payload of one that completed. XRT reads the failing command by
> error_index, so on the timeout path the err_data lands where it does not
> look.

User modifies command buffer after submitting it is not supported. In 
this case, it is ok as long as kernel/firmware does not crash.

Lizhi

>
> Use the index for the lookup. Keep it in a local: the chain lives in a BO
> user space keeps mapped and can rewrite between the store and the load.
> The index itself is firmware supplied and bounded by the command count
> aie2_cmdlist_multi_execbuf() validated at submit.
>
> Fixes: 89ff45359abb ("accel/amdxdna: Fill invalid payload for failed command")
> Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
> ---
>   drivers/accel/amdxdna/amdxdna_ctx.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
> index 888e857ec558..976c1ad864d7 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
> @@ -177,9 +177,12 @@ int amdxdna_cmd_set_error(struct amdxdna_gem_obj *abo,
>   	cmd->header |= FIELD_PREP(AMDXDNA_CMD_STATE, error_state);
>   
>   	if (amdxdna_cmd_get_op(abo) == ERT_CMD_CHAIN) {
> +		u32 err_idx;
> +
>   		cc = amdxdna_cmd_get_payload(abo, NULL);
> -		cc->error_index = (cmd_idx < cc->command_count) ? cmd_idx : 0;
> -		abo = amdxdna_gem_get_obj(client, cc->data[0], AMDXDNA_BO_SHARE);
> +		err_idx = (cmd_idx < cc->command_count) ? cmd_idx : 0;
> +		cc->error_index = err_idx;
> +		abo = amdxdna_gem_get_obj(client, cc->data[err_idx], AMDXDNA_BO_SHARE);
>   		if (!abo)
>   			return -EINVAL;
>   		cmd = amdxdna_gem_vmap(abo);
