Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BABC5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:32:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 670C110E533;
	Wed, 26 Aug 2026 21:32:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wxLL2yq0";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011029.outbound.protection.outlook.com [52.101.52.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81A7610E533
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 21:32:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGkAzN7ni7Y0ILqTseiAsQKdwXlDLJxDSoOGm6JA+0OgC6zTeC1CxWyaunjSJ1aIF4FWdyYAu42GiZjZzvXxH9D7pZTsApDyKuYq0pQb2EyBahbi4AEJw4mJ0DVmo3brgvqJHDuS7QYxEKLy/C2Kbkn5cgznElceMxDBxMNBN3aWn2h9p7G6hg1Baan1/Wn1rvrnmwrWIPU6upTVbIwevwVCZMH71Ly49dkwIACChKOEu4Qf4ojYanrUYp6vdm5bYKduPzOHKkgRNeKv/CMc8/FAxL3hdFJx+Iw7iudZ3keHwr2ns3U6Z/kJMAR7vqER+f4ja8ULxRVicRwXLlaKBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBZk7+f98P0qQHKmVxiGq4fQan4Uj/KDECggQksYB3c=;
 b=hkqWrHU7Pl5/JwL77jfVQ/7pjzMncpdcU8NgB3P3t2M7nXpy+OQJ6OyxaGfqscgO+tGEg101WFn4rTo0gaRmAXZmZRFmA/Uj+MNZywzRy52fawx01pxrqnhJiaqVoTtD1PXvXELXJCT6BAERKj2S+snaQv0CMQKGxPyAy+raEK2xvQPaW8/vCuJ7vnip3CxTfvvzGK2uxsWgM452sW+/C4i25pBvSkcMo873NtOsU6KJi/jTDk4CW5OUoYGOWXZGE36aaxDqGGknb1d8U73m2nFS6b6Zttmdcg2t+CcsvOxujZBysh1gVk84C4tJ03m2oo9zNrBG4HWBUhr/Bik85A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=kaitmazov.com smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBZk7+f98P0qQHKmVxiGq4fQan4Uj/KDECggQksYB3c=;
 b=wxLL2yq03HTOBjDbyOqrSjOI7AtPLN8LnGE/0Diap4YZkbdBJzAxiezKbkPcc70GRBWh3S/uvDLzPSqQZTB2bPoEzLrP/xDWe/RbtjtbZpqRUPGLRDOyZxC3pZSsaVDoxMqfllOkQv34kRoe7Z0A0n4wh/3ZppRmb4v1Xat9wTw=
Received: from CH0PR03CA0385.namprd03.prod.outlook.com (2603:10b6:610:119::20)
 by DM4PR12MB6398.namprd12.prod.outlook.com (2603:10b6:8:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 21:32:06 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:610:119:cafe::4c) by CH0PR03CA0385.outlook.office365.com
 (2603:10b6:610:119::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 21:32:06 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Wed, 26 Aug 2026 21:32:05 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 16:32:05 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Wed, 26 Aug 2026 16:32:04 -0500
Message-ID: <a203be1c-d28d-c33e-0a94-da725ec2d5aa@amd.com>
Date: Wed, 26 Aug 2026 14:32:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] accel/amdxdna: check the command chain payload
 before using it
Content-Language: en-US
To: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>, Min Ma <mamin506@gmail.com>, 
 Oded Gabbay <ogabbay@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20260826143036.100089-1-taimuraz@kaitmazov.com>
 <20260826153121.133507-1-taimuraz@kaitmazov.com>
 <20260826153121.133507-2-taimuraz@kaitmazov.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260826153121.133507-2-taimuraz@kaitmazov.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|DM4PR12MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: e62816ea-9b96-4844-f720-08df03b97a05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|56012099006|10067099003|18002099003|22082099003|4143699003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: VN+/Y62xdmAzqnLqjjM3euZPwqOAWDxh7Dk8nyZoIt3YPEw0tWT8i+hPx1bPr00CrGwZYNfLyql+Wn9DMHvIi3tqRsA1RLgNA7NCt1s2aevI8sR05cor49VywvwBs1wrpLg5wyPGR5n1jgUJ1EGEgNhtePL69KpUcWyczuhGkSzOcnMqGlUx7xyRf7uIlbqYquSxTnjHWWIIKxVT4LlNkRoJLRbCIodNIzyloPOEoJEO6Y99t/7d41hGfxdj0JpY/yInMuNTepE/q/X9vLVpjsWrm9K5M9SuQPs6MVzeYpPHvEGMwZjqCWaj0OCe03HrqHrJ5IRn7H3qEuE9uutKHL031vASthoRMQLOV+KUN+i4nyST/Ty5TfEVcf8jE7qt9sW1gnbq8T1quL9IeVmirdkX8sHkf8h27PujnvEhzBOSNgKigeMDknEo8gN7VVFlciNPIXx3kenDOofBtTbJ+1bCDcCUf7PkZgjlVbj74Y2H9KG8pozhMDA9kCal0e9eSEtwLjBcLTn8Zh7UdrhN1Hdou4gNm/VQDBfgGy9CPDS4e8B+XNn2kPQvguirwgx8aJWy4YsigR0ArXmgt9h1fdE/idSEIY5Jac+yqhm6OFoXRV8xtIYNEwyf6mbR5Iip4mbsGH0DVILasXJD1U1MxfxRFlrwkx4cW8ZMEBCHP3/ygfrgnb735eYLLFT4R5lAs6zm3Tpq8huzs138rJs+Iw==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(56012099006)(10067099003)(18002099003)(22082099003)(4143699003)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zr65L0Wyn0GS+Xc2JW5P3sILAqy7s2xmMa/+J+haPypUbh+oL76LFkUT/f5WX368RyspP3fqrS16hEEEf/7mSlHZRyAwvHvMjWA+F9/o91bYtQQVwfcgssnltLhtRuiscBCFR6i+7Ml63YR1D3KazgE+UDDO6AvjrPhMnTsxeofEdd2nPpkJHB9QbMhT2okzWdjEnq2pqe2jes1Xd0niO2ySA3IBvSBtJ5boDgdzFBP3IwPI0qin3xBm0IstNL+1zGB1RWKdrJPwyN/YVRIyZgNktt8FykKcbpdSheWeTh89KdFrGXzZ+D+xdqSrt8dt7AZdUbHuo2iA9Oo/U68lBPZAag2yWe/2w3uzd+hLpAx5yK/vtfjiiwejemrWIMWC8MQ6ICrAZJirm3qhg9mlOHbkRT2iE4EOxEzXayaD/8/D5y/g1/l2vEjEcFHW4QFn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 21:32:05.9550 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e62816ea-9b96-4844-f720-08df03b97a05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6398
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


On 8/26/26 08:31, Taimuraz Kaitmazov wrote:
> amdxdna_cmd_get_payload() only bounds-checks the payload when a size
> pointer is passed, so its two callers get different guarantees from one
> function. amdxdna_cmd_set_error() takes the unchecked form and then reads
> cc->command_count and cc->data[0], neither of which has been shown to
> lie inside the BO.

AMDXDNA_CMD_EXTRA_CU_MASK is 2 bits. So cc->command_count and 
cc->data[0] will be in the BO scope.

This is IO path. I would change it only when there is a real issue.


Thanks,

Lizhi

>
> Make the size mandatory and add amdxdna_cmd_get_chain(), which returns
> the chain only once the declared command count is known to fit.
>
> Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
> ---
>   drivers/accel/amdxdna/amdxdna_ctx.c | 51 ++++++++++++++++++++++-------
>   drivers/accel/amdxdna/amdxdna_ctx.h |  2 ++
>   2 files changed, 41 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
> index 855da8c79a1c..9f44e3918bc1 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
> @@ -125,20 +125,42 @@ void *amdxdna_cmd_get_payload(struct amdxdna_gem_obj *abo, u32 *size)
>   	else
>   		num_masks = 1 + FIELD_GET(AMDXDNA_CMD_EXTRA_CU_MASK, cmd->header);
>   
> -	if (size) {
> -		count = FIELD_GET(AMDXDNA_CMD_COUNT, cmd->header);
> -		if (unlikely(count <= num_masks ||
> -			     count * sizeof(u32) +
> -			     offsetof(struct amdxdna_cmd, data[0]) >
> -			     abo->mem.size)) {
> -			*size = 0;
> -			return NULL;
> -		}
> -		*size = (count - num_masks) * sizeof(u32);
> +	count = FIELD_GET(AMDXDNA_CMD_COUNT, cmd->header);
> +	if (unlikely(count <= num_masks ||
> +		     count * sizeof(u32) +
> +		     offsetof(struct amdxdna_cmd, data[0]) >
> +		     abo->mem.size)) {
> +		*size = 0;
> +		return NULL;
>   	}
> +	*size = (count - num_masks) * sizeof(u32);
> +
>   	return &cmd->data[num_masks];
>   }
>   
> +/*
> + * Returns the chain payload of @abo, with @count set to a command count that
> + * has been checked to fit. The chain fields live in a BO user space keeps
> + * mapped, so nothing may read them without going through here.
> + */
> +struct amdxdna_cmd_chain *
> +amdxdna_cmd_get_chain(struct amdxdna_gem_obj *abo, u32 *count)
> +{
> +	struct amdxdna_cmd_chain *cc;
> +	u32 len, ccnt;
> +
> +	cc = amdxdna_cmd_get_payload(abo, &len);
> +	if (!cc || len < sizeof(*cc))
> +		return NULL;
> +
> +	ccnt = READ_ONCE(cc->command_count);
> +	if (len < struct_size(cc, data, ccnt))
> +		return NULL;
> +
> +	*count = ccnt;
> +	return cc;
> +}
> +
>   u32 amdxdna_cmd_get_cu_idx(struct amdxdna_gem_obj *abo)
>   {
>   	struct amdxdna_cmd *cmd = amdxdna_gem_vmap(abo);
> @@ -177,8 +199,13 @@ int amdxdna_cmd_set_error(struct amdxdna_gem_obj *abo,
>   	cmd->header |= FIELD_PREP(AMDXDNA_CMD_STATE, error_state);
>   
>   	if (amdxdna_cmd_get_op(abo) == ERT_CMD_CHAIN) {
> -		cc = amdxdna_cmd_get_payload(abo, NULL);
> -		cc->error_index = (cmd_idx < cc->command_count) ? cmd_idx : 0;
> +		u32 ccnt;
> +
> +		cc = amdxdna_cmd_get_chain(abo, &ccnt);
> +		if (!cc || !ccnt)
> +			return -EINVAL;
> +
> +		cc->error_index = (cmd_idx < ccnt) ? cmd_idx : 0;
>   		abo = amdxdna_gem_get_obj(client, cc->data[0], AMDXDNA_BO_SHARE);
>   		if (!abo)
>   			return -EINVAL;
> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h b/drivers/accel/amdxdna/amdxdna_ctx.h
> index b6bef3af7dab..f6529d512217 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.h
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.h
> @@ -196,6 +196,8 @@ amdxdna_cmd_get_state(struct amdxdna_gem_obj *abo)
>   }
>   
>   void *amdxdna_cmd_get_payload(struct amdxdna_gem_obj *abo, u32 *size);
> +struct amdxdna_cmd_chain *
> +amdxdna_cmd_get_chain(struct amdxdna_gem_obj *abo, u32 *count);
>   u32 amdxdna_cmd_get_cu_idx(struct amdxdna_gem_obj *abo);
>   int amdxdna_cmd_set_error(struct amdxdna_gem_obj *abo,
>   			  struct amdxdna_sched_job *job, u32 cmd_idx,
