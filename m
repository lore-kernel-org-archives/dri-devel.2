Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB0AC5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 23:16:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7B7310EE2E;
	Wed, 26 Aug 2026 23:16:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AkkgA3QM";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011063.outbound.protection.outlook.com [40.107.208.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7102710EE2D
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 23:16:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+YOAcbUQSivnbI+Al+kRn+2OfwmBx6bQbGjaquLf2mMVGmbbHW7we6/cE3Sv7+3oCgqYVEXm2H6YaA8KawucQ3rgN8SA45dd4gngwh0PgkWhKL5EV6UDd+73MShzQv9WUcWLfZdk6BgCGEmrV2NuLmhdQCoqY2b4dV438WYR66f6xFl1fuCeG9S8ralJTvkYSQ8wEAesMjyBs1aCinsZlwZLlgHz307ybalQMz4SI0HB+S2MBWvvXv4vF3NdcCTsNMMD88kt+ufmR4lVcusClcZcpZcr5qHjnrk+zkklhFtuPZGh7p4Op8UJbF5KOQPE65Mvx7c8iljsaENjXkx0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvSj62IHuZtWVFuDBf6N0tRRj/dt873Jc2o6CWSM4Ko=;
 b=AI6m0CAAMm8q8Kvu6f81f441dTILOl//lBIKMJ3+12IMMu+KykkU7bQfeiAZ57rsETcKiUD53KVbeAiHgNXAbROFz81VOn0jHY8RSI3JzCZzRVeGVUSEAUAX9UXGkYq/Oz4Oq3kcCKD0Bw3xfQnEehQZrtjJmUD2Vig/HxcB5w5MWsBvVIBjXwt9cWZEhDYyIp9mDhMfhhtoVD2OS8Hn9YzAMu6e8hfQwEwfBy89dqPdi5WvM+U1F/o9Vsl7QCy8vit/TZvQ4HjVUyCAu4cJWKVe8dBeX9VcMgYv041rcYkmL4dMO0+YXXad2pfKKSF+qtw+IxKhnAuxve36ipoIvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=kaitmazov.com smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvSj62IHuZtWVFuDBf6N0tRRj/dt873Jc2o6CWSM4Ko=;
 b=AkkgA3QM/0DlsUEnttTYqtP514ptsL/yo497FWgwn0k5/8MueVS5sjhalPTWl3W7jJ7KcPtnEoL5eEhHUTzw4bcThbLNKywoP0m4JcHPP7jmH3SSBjOEQKsf8ZPFn268e/nnwazC0LeUnlnUfSTdGRDD2nb+N4Q4faEeR+wCg2o=
Received: from DM6PR02CA0145.namprd02.prod.outlook.com (2603:10b6:5:332::12)
 by DS0PR12MB7970.namprd12.prod.outlook.com (2603:10b6:8:149::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Wed, 26 Aug
 2026 23:16:23 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:332:cafe::58) by DM6PR02CA0145.outlook.office365.com
 (2603:10b6:5:332::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.8 via Frontend Transport; Wed, 26
 Aug 2026 23:16:23 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb08.amd.com (149.199.90.133) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:16:23 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:16:22 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:16:22 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Wed, 26 Aug 2026 18:16:21 -0500
Message-ID: <e67eebfc-9b32-115b-e605-09db03b06119@amd.com>
Date: Wed, 26 Aug 2026 16:16:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] accel/amdxdna: use READ_ONCE/WRITE_ONCE on the
 command header
Content-Language: en-US
To: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>, Min Ma <mamin506@gmail.com>, 
 Oded Gabbay <ogabbay@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20260826143036.100089-1-taimuraz@kaitmazov.com>
 <20260826153121.133507-1-taimuraz@kaitmazov.com>
 <20260826153121.133507-3-taimuraz@kaitmazov.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260826153121.133507-3-taimuraz@kaitmazov.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|DS0PR12MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ee21c61-06de-4737-df9d-08df03c80b84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1u92Z7ou+SogNEdlUk5AdHh3ATLQRbGRQeusM9qzfNHJ/Kpy0+Zbbh99EhOCPPLRZHNULr/B7XrBJZ5/ebTot2oKobUFif/ABVBKm40siy3EMh2MVoxsdFs8SEPzPrkp7HSI4IjZ3624PrbH0oV7Qp0RsYvsAvnlbUy8ztobXVeeEOekMJSklOqYc1yiGXGpKMc6YluRdCHK9H0Mb2Q2dSzxTKAT8kWLFB0tS/7Q8CAU/CmjKxi6+ya46IcEyLrapWSMGKeKqizHeOLSDAs0vrAzkKOn7eJYWoD0f9lJplxX+DocAU01AwzgUECwNkXzz7PKovbffivbHgH3sCEaDGoSKK7b3WcqfjqvH0UuTX8zDki3rqFKp0k2491pgO+DJyTKue5DzxMAhs0P6d1r6A1f27S+RH6IdqEGzlj2mfGaRPXbyqKd+h67YfCwDHfP7mZ3afnY87las6UTz7Vv7PlydtcOihXTUokr7Wi1bCyo1XCrJsb1BKvsQYsO09Vr07U87geeSwmvibM5wOY4k8SoXYIE7hcXFbgeKZaRlPABk/f1jy6Hs2dPwM/PglAsEZ76lOjIiqSgaSdPLje/Epmmy915jb+bwunReOniIx6IHQ+PmOpuR9r05y29EQLHwT53HcAtHU8ikW+fqteUknf5Kekak2BWpm+0PQd40tnmSJWm8JX6OsStZgM3bfj1ZKcekmD3HVHX1YwE0XHzzA==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1Xreh010D+CovrCj3w2o+QInlR9ToZFr425yVlxR6OqAPeMfe3bq/wRcX/mDcfrX/gnY39P82qHdRn7Dn9xEtt+P3DHu6EcY7qvf78jy1DCO/9iBNtvYSHsMkWW9PRC8/gxknjnEJSFo+XrFj+L36izyCqv34xAZQk91JNg5HeyXyJ5JNipv6KI/vi47aW1JwO950LnWxJ1k0nof1lkcuRzMwYuNmiT+Q8mMsCJSevyEJZZHZfyLD/YihQCQm6I6aTIaP7KjcnrI/umgMb8TQUpWaaipxTKxtnSN1aW/Ndm6GK9riQteQt/nINzV9xxIMHLT10UG3WQMZQVfdIA4tmi7VDetLkkaZJ9VLK4PmReWVojWh72g/Lfn380U8I+OHR8rsw7inzSvkhyAK+KmqcoDIAvdkhtew87KmcAh3+/ajlN+Y0vZfMvrNbAkABPp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:16:23.0357 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee21c61-06de-4737-df9d-08df03c80b84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7970
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
> struct amdxdna_cmd::header packs STATE, OPCODE, COUNT and EXTRA_CU_MASK
> into one u32 that lives in a BO user space keeps mapped. The driver
> re-reads it on every accessor call and read-modify-writes STATE in place,
> with plain accesses that let the compiler split or refetch either side.
>
> Annotate them, as the UMQ ring indices already are. This does not make
> the update atomic against user space, it only stops the compiler from
> making it worse.

The user space should not change the BO content after the command is 
submitted. Otherwise, the command could fail.

In another word, driver/hardware treat this as invalid command. It is ok 
as long as kernel/firmware does not crash. So the bad user application 
only messes up itself.


Thanks,

Lizhi

>
> Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
> ---
>   drivers/accel/amdxdna/amdxdna_ctx.c | 14 +++++++++-----
>   drivers/accel/amdxdna/amdxdna_ctx.h | 11 +++++++----
>   2 files changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
> index 9f44e3918bc1..148ae51db0f1 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
> @@ -123,9 +123,10 @@ void *amdxdna_cmd_get_payload(struct amdxdna_gem_obj *abo, u32 *size)
>   	if (amdxdna_cmd_get_op(abo) == ERT_CMD_CHAIN)
>   		num_masks = 0;
>   	else
> -		num_masks = 1 + FIELD_GET(AMDXDNA_CMD_EXTRA_CU_MASK, cmd->header);
> +		num_masks = 1 + FIELD_GET(AMDXDNA_CMD_EXTRA_CU_MASK,
> +					  READ_ONCE(cmd->header));
>   
> -	count = FIELD_GET(AMDXDNA_CMD_COUNT, cmd->header);
> +	count = FIELD_GET(AMDXDNA_CMD_COUNT, READ_ONCE(cmd->header));
>   	if (unlikely(count <= num_masks ||
>   		     count * sizeof(u32) +
>   		     offsetof(struct amdxdna_cmd, data[0]) >
> @@ -173,7 +174,7 @@ u32 amdxdna_cmd_get_cu_idx(struct amdxdna_gem_obj *abo)
>   	if (amdxdna_cmd_get_op(abo) == ERT_CMD_CHAIN)
>   		return INVALID_CU_IDX;
>   
> -	num_masks = 1 + FIELD_GET(AMDXDNA_CMD_EXTRA_CU_MASK, cmd->header);
> +	num_masks = 1 + FIELD_GET(AMDXDNA_CMD_EXTRA_CU_MASK, READ_ONCE(cmd->header));
>   	cu_mask = cmd->data;
>   	for (i = 0; i < num_masks; i++) {
>   		if (cu_mask[i])
> @@ -191,12 +192,15 @@ int amdxdna_cmd_set_error(struct amdxdna_gem_obj *abo,
>   	struct amdxdna_client *client = job->hwctx->client;
>   	struct amdxdna_cmd *cmd = amdxdna_gem_vmap(abo);
>   	struct amdxdna_cmd_chain *cc = NULL;
> +	u32 header;
>   
>   	if (!cmd)
>   		return -ENOMEM;
>   
> -	cmd->header &= ~AMDXDNA_CMD_STATE;
> -	cmd->header |= FIELD_PREP(AMDXDNA_CMD_STATE, error_state);
> +	header = READ_ONCE(cmd->header);
> +	header &= ~AMDXDNA_CMD_STATE;
> +	header |= FIELD_PREP(AMDXDNA_CMD_STATE, error_state);
> +	WRITE_ONCE(cmd->header, header);
>   
>   	if (amdxdna_cmd_get_op(abo) == ERT_CMD_CHAIN) {
>   		u32 ccnt;
> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h b/drivers/accel/amdxdna/amdxdna_ctx.h
> index f6529d512217..48e1fcfd818f 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.h
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.h
> @@ -169,19 +169,22 @@ amdxdna_cmd_get_op(struct amdxdna_gem_obj *abo)
>   	if (!cmd)
>   		return ERT_INVALID_CMD;
>   
> -	return FIELD_GET(AMDXDNA_CMD_OPCODE, cmd->header);
> +	return FIELD_GET(AMDXDNA_CMD_OPCODE, READ_ONCE(cmd->header));
>   }
>   
>   static inline void
>   amdxdna_cmd_set_state(struct amdxdna_gem_obj *abo, enum ert_cmd_state s)
>   {
>   	struct amdxdna_cmd *cmd = amdxdna_gem_vmap(abo);
> +	u32 header;
>   
>   	if (!cmd)
>   		return;
>   
> -	cmd->header &= ~AMDXDNA_CMD_STATE;
> -	cmd->header |= FIELD_PREP(AMDXDNA_CMD_STATE, s);
> +	header = READ_ONCE(cmd->header);
> +	header &= ~AMDXDNA_CMD_STATE;
> +	header |= FIELD_PREP(AMDXDNA_CMD_STATE, s);
> +	WRITE_ONCE(cmd->header, header);
>   }
>   
>   static inline enum ert_cmd_state
> @@ -192,7 +195,7 @@ amdxdna_cmd_get_state(struct amdxdna_gem_obj *abo)
>   	if (!cmd)
>   		return ERT_CMD_STATE_INVALID;
>   
> -	return FIELD_GET(AMDXDNA_CMD_STATE, cmd->header);
> +	return FIELD_GET(AMDXDNA_CMD_STATE, READ_ONCE(cmd->header));
>   }
>   
>   void *amdxdna_cmd_get_payload(struct amdxdna_gem_obj *abo, u32 *size);
