Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0A9606A335
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 21:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wS6RBO1l
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEAA610E3E8;
	Tue, 17 Nov 2026 21:54:54 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013005.outbound.protection.outlook.com
 [40.93.196.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48A9310E3E8
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 21:54:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOPkivaCmEkUjm+0WuNK3RkbuHWGSasSrv1bm9YZq4n3Z9CsYFRYc+YLJ5c8wN7or0YZzNRUgVcsgkNxGEFWUVtXU9Vp117gHqdoOKgumG+qYk1dv2nPAEWWmxQbk3efhbXImmfF/oWObtULfktYD4JisuBEflz2jkSyRydqpR09zRFHMz+mfj1rArchyDvy4algR4SIxxLH0KsRnS1OUakHux772p5KEHx6jCOr6tPFc9Y5mqVfA8pC84eyKn4+mpZCpIuYQHhizXXWqrGqJtIUKjWCrcUR7pMkVSSt/jb8uT+Ne9s7PQnJQyUZCjYBeHkmemrVGdlfqgbzZOQY1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSB96axw2nia3omU8A4btCyY/rz+zGPdNKIVns9aoyE=;
 b=QP2HB+ow/L4W+ovy4znopRX/iG4y76MrIQ+JQ4yTt6aMxdeaQUqrpiCbE78pjVs5S+uq1O5jO3t1C6buKhOeuShAoN21RFZ5rt9OnJ88UhdA3bKe0LNBDH3RX0MIJVYvP6ujx/gxv2td+zP8Mq4TlrVIMaTGHNcQHnQ18GnWbKKWPyFFHcwUE7iyG3/blM+EhUG/3LSSpcafn3s3Uy3RXKgdBIfJ3JDFIS1Sl4VPC4XC1Osze4XeKQ1+OdWkigJUktti27xChs8iDZSY2S7nh/b528tG5AzCr/tLA+F/oQUyvByfc+LI1sGLVvUOPzMeTm5EvTsBBoCtqMsfYcWtfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSB96axw2nia3omU8A4btCyY/rz+zGPdNKIVns9aoyE=;
 b=wS6RBO1lpogg3svjwjcthtt9PeUtckH1NDwSy9RvPshgY5j7qWRJ19AGe8Web1ooHR0Iv9WQdRQwNXNgf7qkCd4czTuMDQ2lv+0LNm9PzgzdOuoXpx0l7yY+3cdvSQSfhE//X9gs3g1N2KdiX9G3KwwcU+3/MxCTHdP5pUHqrCQ=
Received: from CH2PR14CA0055.namprd14.prod.outlook.com (2603:10b6:610:56::35)
 by PH7PR12MB5687.namprd12.prod.outlook.com (2603:10b6:510:13e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 21:54:33 +0000
Received: from CH01EPF000BE940.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::39) by CH2PR14CA0055.outlook.office365.com
 (2603:10b6:610:56::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 21:54:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE940.mail.protection.outlook.com (10.167.244.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 21:54:33 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 15:54:32 -0600
Received: from [172.19.68.164] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 15:54:31 -0600
Message-ID: <093a14fc-48c9-43e4-8618-c6ec6f00f5cd@amd.com>
Date: Tue, 17 Nov 2026 13:54:26 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] accel/amdxdna: Detect a driver command without
 firmware response
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20261117212733.172074-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Max Zhen <max.zhen@amd.com>
In-Reply-To: <20261117212733.172074-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE940:EE_|PH7PR12MB5687:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f983657-9f98-4df6-0ab0-08df44f55d2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|11063799006|56012099006|261026140227099003|261028144727099003|10067099003|261021123027099003|261022075727099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZQ0pW/k1y5a3ZkKh0/Ae+hENtpIXDo80e+keybAuBwqfAOCE7JzlxTYv0adouBolmDpcXNJ4uj7epVjjITMUamke1oqjarRrCAa10TxMoctqNcPKjRuuM8fxEJF6H3wN1fsY161bq/ulzjqEL8kc5nbzr2afpXq3WqhUEaKCoOFZvZnXSGenFTaXN82UN3WhIiWmxH9n7BAILWGnlzmOxRgMPGR8cya2+Sssd7bEbesP8fOtQR9pIZjRUzmtJDdNAnCXVabgngnSSn9v72pMTqbRhLdFShcyvutXdyGGxVdhvCSWh0p6+NSQiDki1+rFNY8z8sN40n03JrNX5um13tYeKNtGm6UiU4Pgn/3Awv4jydgE3N5nU3V0OqlEKyZ0W2qlUQ/AKyL57weH+PB5Hra9QM1krEIa4BsmpzyQAc5s9jrMED/vMJK5bOcj9qdrLlr8CZMS53gEY+sAkVqd4mdwQv0XUIQW0nBg5K1cWKwKUTk31GS0bboH7whH+x7oxl9Ye8guhlYSLfT91pVApJ1Bx9IINMgj25ZK9AABfZwt0N2rlrRrdF1szmJHzwxGsJJxbl5I++wOgadTrcx4+scJrq5MjHhMK++HRyTRBNcvMSViNc77udHc3A+HaNb74mt8vEsxpXLTJDCpyJ79xGRgYMoXQlbJONTiz7yricFsm/UI5qI+5B39OqBTb1egkSpW99wz5HxsSGRt3/0L7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(11063799006)(56012099006)(261026140227099003)(261028144727099003)(10067099003)(261021123027099003)(261022075727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RfiHpSnPWsIoKU5CMc35oOO67fnbOPPp20ziYCAfWit0mueYB/bXkZ3it4GcGEQVX6j8fLkZgY6Moj2bTleUi9vdGTz6pUFKGPI2lIKBjDlaWwqORk9hlv7hdn5FcAdzW90on6wpNjJYJc7eWzhCKxu4fmzmFoTA+105W9l9H0SE7SVbub85ibgB7NM6ffy3V36nqC/UO91v4qusgAJu8THHwQZAUbTu35aEjlbKrFzAVJsmuDmWLfA/N7apXIqyNsXekQjJx6JaCmds3Y0miDbN/JSjQUXjs32EftlEH8rNb1chvmL/1MxfiKWINstY6eCu0R4IZsK1c5Bop2/lZrhuQBgqYGH73sHdFfCaD3tGQCKEbmQb24ed2OHSN0E0CtpXgdUdHXS6V74OMB1z+g5WCbmyrjLBJI4EdCZRh+lXHsD11vwD89/HDFkr8CKy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 21:54:33.0023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f983657-9f98-4df6-0ab0-08df44f55d2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE940.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5687
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/17/2026 Tue 13:27, Lizhi Hou wrote:
> aie2_hwctx_cfg_debug_bo() and aie2_hwctx_sync_debug_bo() decide success
> solely from cmd->result.
> 
> cmd->result is only written by aie2_sched_drvcmd_resp_handler(), which
> runs when firmware responds. If the job fails before it reaches
> firmware, for example aie2_sync_bo() or aie2_config_debug_bo() fail to
> send the mailbox message, no response handler runs. cmd is zero
> allocated, so cmd->result stays 0 and the caller treats the failed
> command as successful. aie2_hwctx_cfg_debug_bo() then goes on to update
> abo->assigned_hwctx, leaving it out of sync with firmware.
> 
> Set cmd->result to U32_MAX before submitting, so a command which gets
> no response is reported as a failure.
> 
> Fixes: 7ea046838021 ("accel/amdxdna: Support firmware debug buffer")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Max Zhen <max.zhen@amd.com>
> ---
> V2:
>     Use a simplier fix to address sashiko comment.
> 
>   drivers/accel/amdxdna/aie2_ctx.c    | 12 +++++++++---
>   drivers/accel/amdxdna/amdxdna_ctx.h |  5 +++++
>   2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
> index 11f5421e497aa..32458d05635f9 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -989,10 +989,14 @@ static void aie2_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq)
>   	struct dma_fence *out_fence = aie2_cmd_get_out_fence(hwctx, seq);
>   	struct amdxdna_dev *xdna = hwctx->client->xdna;
>   
> -	if (!out_fence) {
> -		XDNA_ERR(xdna, "Failed to get fence");
> +	/*
> +	 * No fence to wait for. Either seq has already signaled and a later
> +	 * point pruned it out of the timeline chain, or the syncobj was
> +	 * reset. Neither means the command failed, so leave the verdict to
> +	 * the caller, which inspects cmd->result.
> +	 */
> +	if (!out_fence)
>   		return;
> -	}
>   
>   	mutex_unlock(&xdna->dev_lock);
>   	dma_fence_wait_timeout(out_fence, false, MAX_SCHEDULE_TIMEOUT);
> @@ -1022,6 +1026,7 @@ static int aie2_hwctx_cfg_debug_bo(struct amdxdna_hwctx *hwctx, u32 bo_hdl,
>   		goto put_obj;
>   	}
>   	kref_init(&cmd->refcnt);
> +	cmd->result = U32_MAX;
>   
>   	if (attach) {
>   		if (abo->assigned_hwctx != AMDXDNA_INVALID_CTX_HANDLE) {
> @@ -1095,6 +1100,7 @@ int aie2_hwctx_sync_debug_bo(struct amdxdna_hwctx *hwctx, u32 debug_bo_hdl)
>   	if (!cmd)
>   		return -ENOMEM;
>   	kref_init(&cmd->refcnt);
> +	cmd->result = U32_MAX;
>   
>   	cmd->opcode = SYNC_DEBUG_BO;
>   	ret = amdxdna_cmd_submit(client, cmd, AMDXDNA_INVALID_BO_HANDLE,
> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h b/drivers/accel/amdxdna/amdxdna_ctx.h
> index 2e6b300d652f8..bf248d3f16ed1 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.h
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.h
> @@ -145,6 +145,11 @@ enum amdxdna_job_opcode {
>   
>   struct amdxdna_drv_cmd {
>   	enum amdxdna_job_opcode	opcode;
> +	/*
> +	 * Written by the firmware response handler only. Set it to U32_MAX
> +	 * before submitting, so a job which never reaches firmware, and thus
> +	 * gets no response, is not mistaken for a successful command.
> +	 */
>   	u32			result;
>   	struct kref		refcnt;
>   };

