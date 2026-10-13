Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4901ACC6B1A
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 18:42:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DB3210E941;
	Tue, 13 Oct 2026 18:42:37 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011030.outbound.protection.outlook.com [52.101.52.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5299D10E941
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 18:42:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQQ9oyfdENySFAHtY+7Kigu0aL2sXpAV2arBJ7AvZM2a3GiANbOrAUjL4kvkw6W2IayE5es2lbhm8uCEhw2OdE2Wt3NE3YU0KjG1/FDqefv0LnQy09/Nw3PnQyjx+lx1DfU8fs9EdX6TMG1jupptopjvHFMOvsiQsTuph1eg/rn7l9cFny9auQ85MiR7md2dTVA2Ra3M7KQrMf7akD/sA88bZcB+2tCYRSEIOqmLozRv0zbaNyhVJkdl3mO8RosmK8X6u1QisdPVLaS5R2IpeP54yzaicp7jFiArkKN5+MshMko7j6N6bE+oOmTPAZG84siI+txHg3Ih1K41MkCA5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=et+NGpExgoWoLboybR8syyDsmu1SJ7toMnioKoAQGx0=;
 b=pRuCr7KnfH092mMNfkyTuzPbnxTtraPmwBKFMXCmk+3Gz2i0Ol5QsAZWdRWBllUNhN8yk/+5XntQbNs9MWKkrzpVOx3uRYFvciZtywWXE9Ar972S5eNp7HjjqJ6onhJw9rsbbRMw36exwD98S6geJHMT3jylxztoS5+ai63bj08K9oRvgowJm2cPP7XE6XkFE2MlBJZOp4c0LC3IBdIvPAHjKdSiGbbTCTq6PYakZKOw7reO6QYUMBDpWJX4R6P5JxYzJoXsor3QO1dp4Tdfn3EnyVsjVb+oKgSIiYPiNaHn7sQNSROh6ZQFQOU45xWQ8+lpTqKy/P1uxitHFw++Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=et+NGpExgoWoLboybR8syyDsmu1SJ7toMnioKoAQGx0=;
 b=htUYVkgmqtkE0XwuLlNoPec0tUv3Ck8Ulur24YTKCtHFFmBoQ+RpR19vN1bMm2Bl2NldOQMyJVbaroq6A0iDX/tqVdIZ8gqdVDJlenGUnZiCTsHNKaQZnYowPCiS+xz6WRmUCk8ETxlfDlUYHf7k3r0Nb+B0vZO+LwR2LOmP8LU=
Received: from DS1P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:242::13) by
 SA1PR12MB6701.namprd12.prod.outlook.com (2603:10b6:806:251::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.19; Tue, 13 Oct
 2026 18:42:22 +0000
Received: from DS1PEPF0005344D.namprd04.prod.outlook.com
 (2603:10b6:8:242:cafe::6d) by DS1P221CA0018.outlook.office365.com
 (2603:10b6:8:242::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 18:42:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0005344D.mail.protection.outlook.com (10.167.23.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 18:42:22 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 13:42:16 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 13:42:15 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 13:42:15 -0500
Message-ID: <c4f32f14-07ab-d369-a05f-bec7d8869124@amd.com>
Date: Tue, 13 Oct 2026 11:42:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V4 13/19] accel/amdxdna: Prepare for AIE4 command
 submission
Content-Language: en-US
To: David Zhang <yidong.zhang@amd.com>, <quic_jhugo@quicinc.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <sonal.santan@amd.com>, <mario.limonciello@amd.com>, Wendy Liang
 <wendy.liang@amd.com>
References: <yidong.zhang@amd.com>
 <20261009225343.3079074-1-yidong.zhang@amd.com>
 <20261009225343.3079074-14-yidong.zhang@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20261009225343.3079074-14-yidong.zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0005344D:EE_|SA1PR12MB6701:EE_
X-MS-Office365-Filtering-Correlation-Id: 64457991-07a9-4b95-0e63-08df2959b7bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|11063799006|261009223027099003|56012099006|4143699003|5023799004|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: d0C7SPT+kgTeuAiccUVhRtdPyBB+OG0Mwb9xSdT2ELj/G2m7gexofZe4NKKJE2ConAM1neTH+Jxd1M2Upf5w7fRfifyWw4Ut41lp0+sAEIYhTXfFdeBQaO75ivAwRcPmDLukNEl3l7OoF0+1mnAAwJ92Fc+k5jj9RZeTOH5vG9GHtZqNaEt8O9EIQ5W/2+dUOXoDPq0b4M83Q1YUMz9yNSIj8M7bfWTgekmeqQk+qmCKkknKjhnYkjtI6j1OwmisZqndswzyFRlChmZsWpF1+/ay/N4wx9zPmfN3E0hmFLYHXi5n3OAdVlG17ikFHCpHr01rdeuFvHWh2Hzcdp0+45ZojwXISBDdLgY9A/rIFo/6LwWSJYyf7HffqmOj3RNtDcgeeeEzMz4Q2k6q8A9oJKhHb9ipTv4muBYispF21uT717MI25FGrnhZYrea4nW+kcqVpdLXdGSfRQiDnQYD/zxEmF0YqXJxv+v4Zn8CPxl2GiomtfusJytVijase87g27AWxlGwA90D5FzV1rbvesE26XPC99mAGJ/Pb+mbsJjLfvmcUO/V+f63KC/+FuVhrLahwkiLIeFztwzz2/7hGJhCLjUbxck9mSsF/QWObxJ9pPPT3VP04ePi//ceoPgsimVgH2RJfWCN+54yJE/wvu3bwwZJsvq09j0zn6eWd2nt96AkENrjpqUxWIwJ4SLnoU3o7vczaWSfpvSVgi/w8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(11063799006)(261009223027099003)(56012099006)(4143699003)(5023799004)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EZtc7zyKyctn0iluQcyG0YmH0tAY8fDCaV7GGtyloryWAD6DDddyFdNqUh4b1o6yzXCMs/RV2p7rau78xc/BUIaBPAGGbws/XxHLGcDcjLn0l1Owxj44uuOAX3yAiDzUxVv7N8Wru9C13QWYEgJAmWlKCpsyl8ABlNKDAMGp+sgiy/6WKHLmBzgxX1BZV0uyAJcsHilkJBJbx0qrfKczUGi0AcnyRxery/Wjq18GcYgED91vvhfcowP9mGdUFHaYmyZELmP3/3+vknmn5eSzu5YKSrCrOw/TNZ5SIIoLp/Lh5gmTv2cq95gSPYOPvjGJL0O9crhT4w+BCYWTThEIKEt5rlCK86ngf+wieSqPVvrYWd3cFahmfocF63jF7ai/wvntKd9UqdObRgpWjiqBVFyYId9ZGoEJK4L9kjB04M5cypgsrbhyCE2SEQmY2PQX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 18:42:22.0792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64457991-07a9-4b95-0e63-08df2959b7bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0005344D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6701
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


On 10/9/26 15:53, David Zhang wrote:
> Prepare the data structures and completion wait helpers required for
> AIE4 command submission:
> - Define struct amdxdna_cmd_start_dpu in amdxdna_ctx.h for the
>    ERT_START_DPU payload.
> - Extend union amdxdna_job_priv with an aie4 member for queue list
>    linkage and job state tracking.
> - Implement smp_rmb() ordering and non-sleeping retry in
>    get_read_index(), returning zero (no completion) when the sample
>    is still invalid after the retry.
> - Add cmd_done_or_unlinked() to wake on completion or on asynchronous
>    device disconnect and reset, detected via check_cert_comp_linked(),
>    and record completion, so aie4_cmd_wait() does not re-read state
>    that can change after the wait.
>
> read_index is written by firmware to host memory, so the wait path
> handles these cases:
> - A torn or invalid read_index is never reported as a completion.
> - -EAGAIN is returned only when the context is disconnected before
>    completion is seen; the command state and fence are not affected.
> - Completion is recorded inside the wait condition, so a context
>    unlinked and relinked during the wait cannot report a false
>    completion.
>
> Co-developed-by: Max Zhen <max.zhen@amd.com>
> Signed-off-by: Max Zhen <max.zhen@amd.com>
> Co-developed-by: Wendy Liang <wendy.liang@amd.com>
> Signed-off-by: Wendy Liang <wendy.liang@amd.com>
> Signed-off-by: David Zhang <yidong.zhang@amd.com>
> ---
>   drivers/accel/amdxdna/aie4_ctx.c    | 73 ++++++++++++++++++++---------
>   drivers/accel/amdxdna/amdxdna_ctx.h | 20 ++++++++
>   2 files changed, 71 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie4_ctx.c
> index 767ba6ecbfc6..bb126fbae10d 100644
> --- a/drivers/accel/amdxdna/aie4_ctx.c
> +++ b/drivers/accel/amdxdna/aie4_ctx.c
> @@ -399,56 +399,85 @@ static inline bool valid_queue_index(u64 read, u64 write, u32 capacity)
>   
>   static u64 get_read_index(struct amdxdna_hwctx *hwctx)
>   {
> -	u64 wi = READ_ONCE(*hwctx->priv->umq_write_index);
> -	u64 ri = READ_ONCE(*hwctx->priv->umq_read_index);
> +	struct amdxdna_hwctx_priv *priv = hwctx->priv;
>   	struct amdxdna_dev *xdna = hwctx->client->xdna;
> +	u64 ri, wi;
> +
> +	/* Sample read_index before write_index to guarantee wi >= ri. */
> +	ri = READ_ONCE(*priv->umq_read_index);
> +	/* Order the read_index sample before the write_index sample. */
> +	smp_rmb();
> +	wi = READ_ONCE(priv->write_index);
>   
> -	/*
> -	 * CERT cannot update read index as uint64 atomically. Driver may read
> -	 * half-updated read index when it has bits in high 32bit. In case read
> -	 * index is not valid, wait for some time and retry once. It should
> -	 * allow CERT to complete the read index update.
> -	 */
> +	/* Non-atomic 64-bit counter update by CERT; re-sample once if invalid. */
>   	if (!valid_queue_index(ri, wi, CTX_MAX_CMDS)) {
> -		XDNA_WARN(xdna, "Invalid index, ri %llu, wi %llu", ri, wi);
> -		usleep_range(100, 200);
> -		ri = READ_ONCE(*hwctx->priv->umq_read_index);
> +		ri = READ_ONCE(*priv->umq_read_index);
> +		/* Order the read_index sample before the write_index sample. */
> +		smp_rmb();
> +		wi = READ_ONCE(priv->write_index);
>   		if (!valid_queue_index(ri, wi, CTX_MAX_CMDS)) {
> -			XDNA_ERR(xdna, "Invalid index after retry, ri %llu, wi %llu", ri, wi);
> -			ri = 0;
> +			/* 0 <= any seq: callers always treat it as "not done" and retry. */
> +			XDNA_DBG(xdna, "Invalid index, ri %llu, wi %llu", ri, wi);
> +			return 0;
>   		}
>   	}
>   
>   	return ri;
>   }
>   
> -static inline bool check_cmd_done(struct amdxdna_hwctx *hwctx, u64 seq)
> +/* Verify cert_comp remains linked to detect disconnect or reset. */
> +static bool check_cert_comp_linked(struct amdxdna_hwctx *hwctx, struct cert_comp *comp)
>   {
> -	u64 read_idx = get_read_index(hwctx);
> +	/* READ_ONCE pairs with the link/unlink WRITE_ONCE. */
> +	return comp == READ_ONCE(hwctx->priv->cert_comp);
> +}
>   
> -	return read_idx > seq;
> +/*
> + * Lockless wait condition: wake on completion or disconnect. Record
> + * completion, so callers do not re-read state that can change after the
> + * wait.
> + */
> +static inline bool cmd_done_or_unlinked(struct amdxdna_hwctx *hwctx, u64 seq,
> +					struct cert_comp *comp, bool *done)
> +{
> +	*done = get_read_index(hwctx) > seq;
> +	return *done || !check_cert_comp_linked(hwctx, comp);
>   }
>   
> +/*
> + * Return 0 once seq completed, or -EAGAIN if the context is disconnected
> + * before seq completed.
> + */
>   int aie4_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout)
>   {
>   	unsigned long wait_jifs = MAX_SCHEDULE_TIMEOUT;
>   	struct cert_comp *cert_comp = aie4_get_cert_comp(hwctx);
> +	bool done = false;
>   	long ret;
>   
> -	if (!cert_comp)
> +	if (!cert_comp) {
> +		/* Not connected: read_index in host memory is still valid. */
> +		if (get_read_index(hwctx) > seq)
> +			return 0;
>   		return -EAGAIN;
> +	}
>   
>   	if (timeout)
>   		wait_jifs = msecs_to_jiffies(timeout);
>   
>   	ret = wait_event_interruptible_timeout(cert_comp->waitq,
> -					       (check_cmd_done(hwctx, seq)),
> +					       cmd_done_or_unlinked(hwctx, seq, cert_comp,
> +								    &done),
>   					       wait_jifs);
> +	aie4_put_cert_comp(cert_comp);
>   
> +	if (ret < 0)
> +		return ret;
> +	if (done)
> +		return 0;
>   	if (!ret)
> -		ret = -ETIME;
> -
> -	aie4_put_cert_comp(cert_comp);
> +		return -ETIME;
>   
> -	return ret <= 0 ? ret : 0;
> +	/* Woken by disconnect before seq completed. */
> +	return -EAGAIN;
>   }
> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h b/drivers/accel/amdxdna/amdxdna_ctx.h
> index 9bbc3db4ebde..b3677851d1c5 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.h
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.h
> @@ -48,6 +48,18 @@ struct amdxdna_cmd_start_npu {
>   	u32 prop_args[];  /* properties and regular kernel arguments */
>   };
>   
> +/*
> + * struct amdxdna_cmd_start_dpu - interpretation of data payload for
> + * ERT_START_DPU in amdxdna_cmd.
> + */
> +struct amdxdna_cmd_start_dpu {
> +	u64 dtrace_buffer;		/* dtrace buffer address 2 words */
> +	u64 instruction_buffer;		/* buffer address 2 words */
> +	u32 instruction_buffer_size;	/* size of buffer in bytes */
> +	u16 uc_index;			/* microblaze controller index */
> +	u16 chained;			/* number of following amdxdna_cmd_start_dpu elements */
> +};
> +
>   /*
>    * Interpretation of the beginning of data payload for ERT_CMD_CHAIN in
>    * amdxdna_cmd. The rest of the payload in amdxdna_cmd is cmd BO handles.
> @@ -138,8 +150,14 @@ struct amdxdna_drv_cmd {
>   };
>   
>   struct app_health_report;
> +
>   union amdxdna_job_priv {
>   	struct app_health_report *aie2_health;
> +	/* aie4 kernel submission: queue linkage + job state */
> +	struct {
> +		struct list_head	list;
> +		u32			state;
> +	} aie4;
>   };
>   
>   struct amdxdna_sched_job {
> @@ -162,6 +180,8 @@ struct amdxdna_sched_job {
>   };
>   
>   #define aie2_job_health priv.aie2_health
> +#define aie4_job_list	priv.aie4.list
> +#define aie4_job_state	priv.aie4.state
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>   
>   static inline u32
>   amdxdna_cmd_get_op(struct amdxdna_gem_obj *abo)
