Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896FCCA5FFC
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 15:49:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B957810E009;
	Tue,  6 Oct 2026 15:49:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LnFFPKhQ";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013066.outbound.protection.outlook.com
 [40.93.196.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 833F010E009
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 15:49:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZqsfevHKphS465Ggox5krTpxznyVOHHx1890SHTvHkg1sTSDMJWCSEj58/+VuofRXBvHPVQ97s+FBWA/PU37SM3aoJRYv8pdzkn+RKF7v1MMQcQMlg4OmpcBDXzj/Mk0TW3DOm8po5eSNfdE7SSeg6IxO4yc+lPHapUmWB+S2Iz8kt1OgAJGk1vFUQRfe4cFQeCuKDvIx/hqHxTw0E65ze4wxuxwcmGtYfCQ/ayf6bTeSophueKH/OdxKX8fFeTSG/BVuRf5GMfjXe/MgKZrcM3SCab77MxJUuMit+VTjWFDnq/v9yvx089LD2t7wWdRIyWuITOIAZt6aj8Ub6kisg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0iqvHaXH7p7MT62/pHe5xHDcBoJGQr86Ik6yyHCQ0UA=;
 b=IeSDsUqL66PjbAl1Qp62G4JAi9l7aIy3PrxqbFF2t6plryDnbXE5/ZX2nl9CybNMPbLxdiwBx/Vbw+EIZVqyBpX78XxG1DIclw2FWsILlZ7z4rflkpxP5/FHC2xyaqNliR8kCgjSRuiuct9bsMaVrYy7190U56qsOF6xuCjVISPh4oe6XDblmt5AkJtqH94ZkA47Cz8ZAuMUhXT+9PKNdct16HNVo9xrEADeY8gfpDXoa5PeVlWaC3f9i5f77/TxlWUVOAc8b6pr7IJlpOFOtkQGdxunlvcEG9C4L2Tji+5S/mw8k5xIXeWIyvODG7nuUec6PLDXjMk2R9bSZ+YERA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iqvHaXH7p7MT62/pHe5xHDcBoJGQr86Ik6yyHCQ0UA=;
 b=LnFFPKhQG00j5IKk/fwjVo/NBgH1T5wIGaUCmpTprVJlQh8ubLNvbFarot74TEsa/rVdvCx3nJt28wgdQji8IQbH7b2ygtfM9AW4f27IM3BtJ2xqIaDNvTk+MzBcTzfXy9RsiaVkjZ9WPC8isDjA5eAscU2vRuijBygWt4uX7aY=
Received: from MN0P223CA0020.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::11)
 by CH3PR12MB8660.namprd12.prod.outlook.com (2603:10b6:610:177::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Tue, 6 Oct
 2026 15:49:26 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:208:52b:cafe::55) by MN0P223CA0020.outlook.office365.com
 (2603:10b6:208:52b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 15:49:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 15:49:25 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 10:49:22 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 10:49:22 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 6 Oct 2026 10:49:21 -0500
Message-ID: <139f3c76-48ba-c53b-8c44-291331921d44@amd.com>
Date: Tue, 6 Oct 2026 08:49:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2] accel/amdxdna: eliminate GFP_KERNEL allocation from
 mailbox send path
Content-Language: en-US
To: Max Zhen <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20261002161122.1350075-1-max.zhen@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20261002161122.1350075-1-max.zhen@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|CH3PR12MB8660:EE_
X-MS-Office365-Filtering-Correlation-Id: 27b8828b-7b99-41fe-b80e-08df23c16604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|56012099006|10067099003|260925021311599003|11063799006|260925022911599003|5023799004|260925021911599003|3023799007|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: CfCVnO52fhNLZpCat23RdkLlEONApCAg0YrLbHsamaVpFWMggdsvlNgGqQCeRBEtartkW6CZa1TigfROwYGhiYPiWiJ4YdmoLlQ+Fi9LR0j6KWBcwVEwialv+06fW3KxnQypJ2I0SZseyN1dOiAaXnYH6q/n+6RYuqw3HQ4VYjspt9v0b8aMQpym1sZ0uPF3o4XQXRsu6eo8+lf4GpSdYtrbRV0ITLzbqKlDBD1Oq0XC8css8sI01RhgvTCcpJh1qCyHXdwJ/7eSkfmPYN8UgqIWlwECYDwUUnw/gE47+FIidhpy3suKMUh3AHgMl9FuZFFMP2L6vZyDoPzz4enm0R/1kaPbRz9F94je5QbYwoer3UOpmMs8nnrF+gADKhnmix1j3WIA0NK1u/xsagC3ryiLWHd0qK+Ws8yN/zG317g+8R4081IejB5gyyHWnauEbZbJKaqufRqF2SZOJ87q6vb3+YOgac0zyvnLbNwPqHgJMGp0RaxjlBEB1oQChPQ7AFoZ7mrCtsLVY+Gq/wcU8EreNbXyWSosP9LPq0nAwnAC3X5i5NmpjFaqR+PPfC99mQCxDzeAf11YrFFO4bSGFuxfuIDC23WXcSpwcJfqV9GEofO3L2uQu/t+xfLyumSoCt8G1Vlb/sJbJ3BzbjmSZsRSCnSyRgJYRKXOC1nqdH/ipQM79jv0Vgf37HtVVFHNCxraAQR/ybe+C1e/TqJ1rQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(56012099006)(10067099003)(260925021311599003)(11063799006)(260925022911599003)(5023799004)(260925021911599003)(3023799007)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Rm7JkYmtNisRUqGWL8eF32XNxN840eEeOKc+7fAimEUG2XmEOHvECtc0jVtH8/gH8Yi/v+HokzOYAo5i+ee01hV5MS+SZmNXUWKsQLxeKYzwTeaOt3M2Gqr6Ig3C37e0bk1wcd1mjLktslnvMBITS6qyF8I6984k1Fpf89rr1XQ/wFZKBB0mh54P3L6SX2Nj7MoMYJgrv4JKYF0npjh55zSTba+7QOvw/AhB7iWxVvCOwa0UCf8leoBJh03J7gikU5GgdVEkIOFfAZWul7ulXRZGauSg4OAp8iQ+ur9/2cfOCY6w63MPWj1kRnEC5YgqFUkGWTyqWf3pjjsIH2DHfTLT092ubDR+dl3gGC1HCvdEk2bTsQ1glb0Edz0Gd9fBZb1SBLECHR9E06HbIww0tc9MnzOXmSJ8lKu8tytCpUYiuyeDey1glmbyFUnT3na/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 15:49:25.6070 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b8828b-7b99-41fe-b80e-08df23c16604
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8660
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


On 10/2/26 09:11, Max Zhen wrote:
> Replace the per-message kzalloc() with a pre-allocated pool of N slots.
> Each slot is rb_size bytes which is the combined size of the mailbox_msg
> metadata and the package payload must not exceed rb_size. No dynamic
> allocation is needed in the send hot path.
>
> msg_id encodes the slot index as (slot | MAGIC_VAL), allowing O(1)
> lookup on response. A bool busy field tracks slot occupancy; it is set
> after the memset() that initialises the slot so the flag is not zeroed
> out, and cleared in mailbox_msg_done() before invoking the callback so
> the slot is available for reuse by the time the callback returns.
>
> mailbox_msg_done() is introduced as a helper that saves the callback
> pointer, clears busy via smp_store_release(), then invokes the callback.
> The release barrier ensures the loads of notify_cb and handle complete
> before busy is cleared. Without it, a concurrent sender could overwrite
> those fields after observing busy == false. mailbox_acquire_msgid() uses
> smp_load_acquire() on busy to pair with the release store. Callers hold
> a per-channel mutex, so only one sender runs at a time and no atomic
> slot claim is needed.
>
> NULL notify_cb is handled inside mailbox_msg_done() so fire-and-forget
> sends (e.g. aie2_config_cu with no callback) are correctly tracked as
> in-flight until the response arrives.
>
> The management channel slot count and async event pool size both use a
> static AMDXDNA_MAX_ASYNC_EVENT_BUFS of 4. The channel must be
> initialised before total_col is known from firmware, so the value
> cannot be derived from ndev. Both counts must stay equal. The channel
> is sized AMDXDNA_MAX_ASYNC_EVENT_BUFS + 1 (one extra for other
> management commands), so the pool cannot exceed that.
>
> Signed-off-by: Max Zhen <max.zhen@amd.com>
> ---
> V2:
>    Removed tx timeout check entirely for simplicity. When sending
>    command, only wait if no enough space in ring buffer.
>
>   drivers/accel/amdxdna/aie2_error.c            |   9 +-
>   drivers/accel/amdxdna/aie2_message.c          |  18 +-
>   drivers/accel/amdxdna/aie2_pci.c              |  15 +-
>   drivers/accel/amdxdna/aie2_pci.h              |   2 +-
>   drivers/accel/amdxdna/aie4_pci.c              |   8 +-
>   drivers/accel/amdxdna/amdxdna_error.h         |  10 +
>   drivers/accel/amdxdna/amdxdna_mailbox.c       | 207 ++++++++++++------
>   drivers/accel/amdxdna/amdxdna_mailbox.h       |   9 +-
>   .../accel/amdxdna/amdxdna_mailbox_helper.c    |   2 +-
>   .../accel/amdxdna/amdxdna_mailbox_helper.h    |   1 -
>   10 files changed, 194 insertions(+), 87 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/aie2_error.c b/drivers/accel/amdxdna/aie2_error.c
> index babdac0157ab..8516574e33eb 100644
> --- a/drivers/accel/amdxdna/aie2_error.c
> +++ b/drivers/accel/amdxdna/aie2_error.c
> @@ -343,15 +343,14 @@ void aie2_error_async_events_free(struct amdxdna_dev_hdl *ndev)
>   	kfree(events);
>   }
>   
> -int aie2_error_async_events_alloc(struct amdxdna_dev_hdl *ndev)
> +int aie2_error_async_events_alloc(struct amdxdna_dev_hdl *ndev, u32 num_events)
>   {
>   	struct amdxdna_dev *xdna = ndev->aie.xdna;
> -	u32 total_col = ndev->total_col;
> -	u32 total_size = ASYNC_BUF_SIZE * total_col;
> +	u32 total_size = ASYNC_BUF_SIZE * num_events;
>   	struct async_events *events;
>   	int i, ret;
>   
> -	events = kzalloc_flex(*events, event, total_col);
> +	events = kzalloc_flex(*events, event, num_events);
>   	if (!events)
>   		return -ENOMEM;
>   
> @@ -361,7 +360,7 @@ int aie2_error_async_events_alloc(struct amdxdna_dev_hdl *ndev)
>   		goto free_events;
>   	}
>   	events->size = total_size;
> -	events->event_cnt = total_col;
> +	events->event_cnt = num_events;
>   
>   	events->wq = alloc_ordered_workqueue("async_wq", 0);
>   	if (!events->wq) {
> diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
> index bae0cc4c3580..d95a18af9b09 100644
> --- a/drivers/accel/amdxdna/aie2_message.c
> +++ b/drivers/accel/amdxdna/aie2_message.c
> @@ -261,8 +261,9 @@ int aie2_create_context(struct amdxdna_dev_hdl *ndev, struct amdxdna_hwctx *hwct
>   		goto del_ctx_req;
>   	}
>   
> +	/* +1 for the config_cu message that can be in-flight concurrently */
>   	ret = xdna_mailbox_start_channel(hwctx->priv->mbox_chann, &x2i, &i2x,
> -					 intr_reg, ret);
> +					 intr_reg, ret, HWCTX_MAX_CMDS + 1);
>   	if (ret) {
>   		XDNA_ERR(xdna, "Not able to create channel");
>   		ret = -EINVAL;
> @@ -486,7 +487,7 @@ int aie2_register_asyn_event_msg(struct amdxdna_dev_hdl *ndev, dma_addr_t addr,
>   	req.buf_size = size;
>   
>   	XDNA_DBG(ndev->aie.xdna, "Register addr 0x%llx size 0x%x", addr, size);
> -	return xdna_mailbox_send_msg(ndev->aie.mgmt_chann, &msg, TX_TIMEOUT);
> +	return xdna_mailbox_send_msg(ndev->aie.mgmt_chann, &msg);
>   }
>   
>   int aie2_config_cu(struct amdxdna_hwctx *hwctx,
> @@ -545,7 +546,8 @@ int aie2_config_cu(struct amdxdna_hwctx *hwctx,
>   	msg.handle = hwctx;
>   	msg.opcode = MSG_OP_CONFIG_CU;
>   	msg.notify_cb = notify_cb;
> -	return xdna_mailbox_send_msg(chann, &msg, TX_TIMEOUT);
> +
> +	return xdna_mailbox_send_msg(chann, &msg);
>   }
>   
>   static int aie2_init_exec_cu_req(struct amdxdna_gem_obj *cmd_bo, void *req,
> @@ -950,7 +952,7 @@ int aie2_execbuf(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job,
>   	print_hex_dump_debug("cmd: ", DUMP_PREFIX_OFFSET, 16, 4, &req,
>   			     0x40, false);
>   
> -	ret = xdna_mailbox_send_msg(chann, &msg, TX_TIMEOUT);
> +	ret = xdna_mailbox_send_msg(chann, &msg);
>   	if (ret) {
>   		XDNA_ERR(xdna, "Send message failed");
>   		return ret;
> @@ -1039,7 +1041,7 @@ int aie2_cmdlist_multi_execbuf(struct amdxdna_hwctx *hwctx,
>   	msg.send_size = sizeof(req);
>   	print_hex_dump_debug("cmdlist msg: ", DUMP_PREFIX_OFFSET, 16, 4,
>   			     &req, msg.send_size, false);
> -	ret = xdna_mailbox_send_msg(chann, &msg, TX_TIMEOUT);
> +	ret = xdna_mailbox_send_msg(chann, &msg);
>   	if (ret) {
>   		XDNA_ERR(xdna, "Send message failed");
>   		return ret;
> @@ -1086,7 +1088,7 @@ int aie2_cmdlist_single_execbuf(struct amdxdna_hwctx *hwctx,
>   	msg.send_size = sizeof(req);
>   	print_hex_dump_debug("cmdlist msg: ", DUMP_PREFIX_OFFSET, 16, 4,
>   			     &req, msg.send_size, false);
> -	ret = xdna_mailbox_send_msg(chann, &msg, TX_TIMEOUT);
> +	ret = xdna_mailbox_send_msg(chann, &msg);
>   	if (ret) {
>   		XDNA_ERR(hwctx->client->xdna, "Send message failed");
>   		return ret;
> @@ -1122,7 +1124,7 @@ int aie2_sync_bo(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job,
>   	msg.send_size = sizeof(req);
>   	msg.opcode = MSG_OP_SYNC_BO;
>   
> -	ret = xdna_mailbox_send_msg(chann, &msg, TX_TIMEOUT);
> +	ret = xdna_mailbox_send_msg(chann, &msg);
>   	if (ret) {
>   		XDNA_ERR(xdna, "Send message failed");
>   		return ret;
> @@ -1157,7 +1159,7 @@ int aie2_config_debug_bo(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *
>   	msg.send_size = sizeof(req);
>   	msg.opcode = MSG_OP_CONFIG_DEBUG_BO;
>   
> -	return xdna_mailbox_send_msg(chann, &msg, TX_TIMEOUT);
> +	return xdna_mailbox_send_msg(chann, &msg);
>   }
>   
>   int aie2_query_app_health(struct amdxdna_dev_hdl *ndev, u32 context_id,
> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
> index f90435e1f65e..6f09ea2ed0cc 100644
> --- a/drivers/accel/amdxdna/aie2_pci.c
> +++ b/drivers/accel/amdxdna/aie2_pci.c
> @@ -24,6 +24,7 @@
>   #include "aie2_pci.h"
>   #include "aie2_solver.h"
>   #include "amdxdna_ctx.h"
> +#include "amdxdna_error.h"
>   #include "amdxdna_gem.h"
>   #include "amdxdna_mailbox.h"
>   #include "amdxdna_pci_drv.h"
> @@ -386,11 +387,21 @@ static int aie2_hw_start(struct amdxdna_dev *xdna)
>   	}
>   
>   	xdna_mailbox_intr_reg = ndev->aie.mgmt_i2x.mb_head_ptr_reg + 4;
> +	/*
> +	 * At most AMDXDNA_MAX_ASYNC_EVENT_BUFS async event messages plus one
> +	 * management command can be unresponded. The async slots stay busy
> +	 * until firmware reports an error. Every management command holds
> +	 * dev_lock across aie_send_mgmt_msg_wait(), and the response clears
> +	 * the slot before that wait returns, so a second ioctl blocks on
> +	 * dev_lock rather than observing -ENOBUFS. Async re-registration
> +	 * takes the same lock after the RX path has freed its slot.
> +	 */
>   	ret = xdna_mailbox_start_channel(ndev->aie.mgmt_chann,
>   					 &ndev->aie.mgmt_x2i,
>   					 &ndev->aie.mgmt_i2x,
>   					 xdna_mailbox_intr_reg,
> -					 mgmt_mb_irq);
> +					 mgmt_mb_irq,
> +					 AMDXDNA_MAX_ASYNC_EVENT_BUFS + 1);
>   	if (ret) {
>   		XDNA_ERR(xdna, "failed to start management mailbox channel");
>   		ret = -EINVAL;
> @@ -415,7 +426,7 @@ static int aie2_hw_start(struct amdxdna_dev *xdna)
>   		goto stop_fw;
>   	}
>   
> -	ret = aie2_error_async_events_alloc(ndev);
> +	ret = aie2_error_async_events_alloc(ndev, AMDXDNA_MAX_ASYNC_EVENT_BUFS);
>   	if (ret) {
>   		XDNA_ERR(xdna, "Allocate async events failed, ret %d", ret);
>   		goto stop_fw;
> diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
> index 0c8dd6510292..709e7545c65f 100644
> --- a/drivers/accel/amdxdna/aie2_pci.h
> +++ b/drivers/accel/amdxdna/aie2_pci.h
> @@ -213,7 +213,7 @@ int aie2_pm_set_mode(struct amdxdna_dev_hdl *ndev, enum amdxdna_power_mode_type
>   int aie2_pm_set_dpm(struct amdxdna_dev_hdl *ndev, u32 dpm_level);
>   
>   /* aie2_error.c */
> -int aie2_error_async_events_alloc(struct amdxdna_dev_hdl *ndev);
> +int aie2_error_async_events_alloc(struct amdxdna_dev_hdl *ndev, u32 num_events);
>   void aie2_error_async_events_free(struct amdxdna_dev_hdl *ndev);
>   int aie2_error_async_msg_thread(void *data);
>   int aie2_get_array_async_error(struct amdxdna_dev_hdl *ndev,
> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
> index 480bd64b0020..27c0acfa5687 100644
> --- a/drivers/accel/amdxdna/aie4_pci.c
> +++ b/drivers/accel/amdxdna/aie4_pci.c
> @@ -16,6 +16,7 @@
>   #include "aie4_msg_priv.h"
>   #include "amdxdna_ctx.h"
>   #include "aie4_pci.h"
> +#include "amdxdna_error.h"
>   #include "amdxdna_mailbox.h"
>   #include "amdxdna_mailbox_helper.h"
>   #include "amdxdna_pci_drv.h"
> @@ -262,11 +263,16 @@ static int aie4_mailbox_start(struct amdxdna_dev *xdna,
>   		goto free_channel;
>   	}
>   
> +	/*
> +	 * At any given time, at most AMDXDNA_MAX_ASYNC_EVENT_BUFS async event
> +	 * messages plus 1 other management command can be unresponded.
> +	 */
>   	ret = xdna_mailbox_start_channel(ndev->aie.mgmt_chann,
>   					 &ndev->aie.mgmt_x2i,
>   					 &ndev->aie.mgmt_i2x,
>   					 NO_IOHUB,
> -					 mgmt_mb_irq);
> +					 mgmt_mb_irq,
> +					 AMDXDNA_MAX_ASYNC_EVENT_BUFS + 1);
>   	if (ret) {
>   		XDNA_ERR(xdna, "failed to start management mailbox channel");
>   		ret = -EINVAL;
> diff --git a/drivers/accel/amdxdna/amdxdna_error.h b/drivers/accel/amdxdna/amdxdna_error.h
> index c51de86ec12b..326d7153b17d 100644
> --- a/drivers/accel/amdxdna/amdxdna_error.h
> +++ b/drivers/accel/amdxdna/amdxdna_error.h
> @@ -56,4 +56,14 @@ enum amdxdna_error_module {
>   	(FIELD_PREP(AMDXDNA_EXTRA_ERR_COL_MASK, col) |			\
>   	 FIELD_PREP(AMDXDNA_EXTRA_ERR_ROW_MASK, row))
>   
> +/*
> + * Maximum number of async event buffers. This value is used in two places:
> + * (1) to size the management mailbox channel, which must happen before
> + * total_col is known from firmware; (2) to allocate the async event pool,
> + * which runs after total_col is known. Both counts must match. The channel
> + * is sized AMDXDNA_MAX_ASYNC_EVENT_BUFS + 1 (one extra for other management
> + * commands), so the pool cannot exceed AMDXDNA_MAX_ASYNC_EVENT_BUFS slots.
> + */
> +#define AMDXDNA_MAX_ASYNC_EVENT_BUFS	4
> +
>   #endif /* _AMDXDNA_ERROR_H_ */
> diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/amdxdna/amdxdna_mailbox.c
> index 05c3786de135..946bd9702c59 100644
> --- a/drivers/accel/amdxdna/amdxdna_mailbox.c
> +++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
> @@ -9,7 +9,6 @@
>   #include <linux/interrupt.h>
>   #include <linux/iopoll.h>
>   #include <linux/slab.h>
> -#include <linux/xarray.h>
>   
>   #define CREATE_TRACE_POINTS
>   #include <trace/events/amdxdna.h>
> @@ -35,9 +34,12 @@
>   		      (_chann)->msix_irq, ##args); \
>   })
>   
> +#define MSG_BUF_SZ(chann)					\
> +	(mailbox_get_ringbuf_size(chann, CHAN_RES_X2I) +	\
> +	 sizeof(struct mailbox_msg))
> +
>   #define MAGIC_VAL			0x1D000000U
>   #define MAGIC_VAL_MASK			0xFF000000
> -#define MAX_MSG_ID_ENTRIES		256
>   #define MSG_RX_TIMER			200 /* milliseconds */
>   #define MAILBOX_NAME			"xdna_mailbox"
>   
> @@ -57,8 +59,6 @@ struct mailbox_channel {
>   	struct xdna_mailbox_chann_res	res[CHAN_RES_NUM];
>   	int				msix_irq;
>   	u32				iohub_int_addr;
> -	struct xarray			chan_xa;
> -	u32				next_msgid;
>   	u32				x2i_tail;
>   
>   	/* Received msg related fields */
> @@ -66,6 +66,12 @@ struct mailbox_channel {
>   	struct work_struct		rx_work;
>   	u32				i2x_head;
>   	bool				bad_state;
> +
> +	/* Pre-allocated message buffer pool */
> +	void				*msg_buf;
> +	u32				msg_buf_num;
> +	u32				next_slot; /* next slot index to try for allocation */
> +	struct mutex			lock;
>   };
>   
>   #define MSG_BODY_SZ		GENMASK(10, 0)
> @@ -90,12 +96,36 @@ struct mailbox_pkg {
>   #define TOMBSTONE		0xDEADFACE
>   
>   struct mailbox_msg {
> +	bool			busy;
>   	void			*handle;
>   	int			(*notify_cb)(void *handle, void __iomem *data, size_t size);
>   	size_t			pkg_size; /* package size in bytes */
>   	struct mailbox_pkg	pkg;
>   };
>   
> +/*
> + * Clear busy before invoking the callback so that a new submission can
> + * reuse the slot immediately - by the time notify_cb returns, the caller
> + * may already have submitted a new job that needs this slot.
> + *
> + * notify_cb and handle are cached in locals first. smp_store_release()
> + * ensures those loads complete before busy is cleared - without it the
> + * compiler or CPU could sink the loads past the store, letting a
> + * concurrent sender overwrite notify_cb/handle before we read them.
> + * Paired with smp_load_acquire() in mailbox_acquire_msgid().
> + */
> +static int mailbox_msg_done(struct mailbox_msg *mb_msg, void __iomem *data, size_t size)
> +{
> +	int (*notify_cb)(void *, void __iomem *, size_t) = mb_msg->notify_cb;
> +	void *handle = mb_msg->handle;
> +
> +	/* Pairs with smp_load_acquire() in mailbox_acquire_msgid(). */
> +	smp_store_release(&mb_msg->busy, false);
> +	if (notify_cb)
> +		return notify_cb(handle, data, size);
> +	return 0;
> +}
> +
>   static void mailbox_reg_write(struct mailbox_channel *mb_chann, u32 mbox_reg, u32 data)
>   {
>   	struct xdna_mailbox_res *mb_res = &mb_chann->mb->res;
> @@ -161,38 +191,57 @@ static inline int mailbox_validate_msgid(int msg_id)
>   	return (msg_id & MAGIC_VAL_MASK) == MAGIC_VAL;
>   }
>   
> -static int mailbox_acquire_msgid(struct mailbox_channel *mb_chann, struct mailbox_msg *mb_msg)
> +static struct mailbox_msg *mailbox_msg_ptr(struct mailbox_channel *mb_chann, u32 slot)
>   {
> -	u32 msg_id;
> -	int ret;
> +	return mb_chann->msg_buf + slot * MSG_BUF_SZ(mb_chann);
> +}
>   
> -	ret = xa_alloc_cyclic_irq(&mb_chann->chan_xa, &msg_id, mb_msg,
> -				  XA_LIMIT(0, MAX_MSG_ID_ENTRIES - 1),
> -				  &mb_chann->next_msgid, GFP_NOWAIT);
> -	if (ret < 0)
> -		return ret;
> +static int mailbox_acquire_msgid(struct mailbox_channel *mb_chann)
> +{
> +	struct mailbox_msg *mb_msg;
> +	u32 slot;
> +	u32 i;
>   
>   	/*
> -	 * Add MAGIC_VAL to the higher bits.
> +	 * msg_id = slot | MAGIC_VAL. Scan slots starting from next_slot.
> +	 * smp_load_acquire() pairs with smp_store_release() in mailbox_msg_done()
> +	 * to ensure that once we observe busy == false, notify_cb and handle are
> +	 * also visible as their post-completion values before we overwrite them.
>   	 */
> -	msg_id |= MAGIC_VAL;
> -	return msg_id;
> -}
> +	for (i = 0; i < mb_chann->msg_buf_num; i++) {
> +		slot = (mb_chann->next_slot + i) % mb_chann->msg_buf_num;
> +		mb_msg = mailbox_msg_ptr(mb_chann, slot);
> +		/* Pairs with smp_store_release() in mailbox_msg_done(). */
> +		if (!smp_load_acquire(&mb_msg->busy)) {
> +			mb_chann->next_slot = (slot + 1) % mb_chann->msg_buf_num;
> +			return slot | MAGIC_VAL;
> +		}
> +	}
>   
> -static void mailbox_release_msgid(struct mailbox_channel *mb_chann, int msg_id)
> -{
> -	msg_id &= ~MAGIC_VAL_MASK;
> -	xa_erase_irq(&mb_chann->chan_xa, msg_id);
> +	return -ENOBUFS;
>   }
>   
> -static void mailbox_release_msg(struct mailbox_channel *mb_chann,
> -				struct mailbox_msg *mb_msg)
> +static struct mailbox_msg *mailbox_get_msg_buf(struct mailbox_channel *mb_chann,
> +					       size_t msg_size)
>   {
> -	MB_DBG(mb_chann, "msg_id 0x%x msg opcode 0x%x",
> -	       mb_msg->pkg.header.id, mb_msg->pkg.header.opcode);
> -	if (mb_msg->notify_cb)
> -		mb_msg->notify_cb(mb_msg->handle, NULL, 0);
> -	kfree(mb_msg);
> +	struct mailbox_msg *mb_msg;
> +	int msg_id;
> +	u32 slot;
> +
> +	/* msg_id = slot | MAGIC_VAL */
> +	msg_id = mailbox_acquire_msgid(mb_chann);
> +	if (msg_id < 0) {
> +		MB_ERR(mb_chann, "No free message slot");
> +		return NULL;
> +	}
> +
> +	slot = msg_id & ~MAGIC_VAL_MASK;
> +	mb_msg = mailbox_msg_ptr(mb_chann, slot);
> +	memset(mb_msg, 0, msg_size + sizeof(*mb_msg));
> +	mb_msg->busy = true;
> +	mb_msg->pkg.header.id = msg_id;
> +
> +	return mb_msg;
>   }
>   
>   static int
> @@ -224,7 +273,7 @@ mailbox_send_msg(struct mailbox_channel *mb_chann, struct mailbox_msg *mb_msg)
>   	if (tail < head && tmp_tail >= head) {
>   		ret = read_poll_timeout(mailbox_get_headptr, head,
>   					tmp_tail < head || tail >= head,
> -					1, 100, false, mb_chann, CHAN_RES_X2I);
> +					1, 2000000, false, mb_chann, CHAN_RES_X2I);
>   		if (ret)
>   			return ret;
>   
> @@ -248,8 +297,9 @@ mailbox_get_resp(struct mailbox_channel *mb_chann, struct xdna_msg_header *heade
>   		 void __iomem *data)
>   {
>   	struct mailbox_msg *mb_msg;
> -	int msg_id;
>   	int ret = 0;
> +	int msg_id;
> +	u32 slot;
>   
>   	msg_id = header->id;
>   	if (!mailbox_validate_msgid(msg_id)) {
> @@ -257,22 +307,32 @@ mailbox_get_resp(struct mailbox_channel *mb_chann, struct xdna_msg_header *heade
>   		return -EINVAL;
>   	}
>   
> -	msg_id &= ~MAGIC_VAL_MASK;
> -	mb_msg = xa_erase_irq(&mb_chann->chan_xa, msg_id);
> -	if (!mb_msg) {
> -		MB_ERR(mb_chann, "Cannot find msg 0x%x", msg_id);
> +	slot = msg_id & ~MAGIC_VAL_MASK;
> +	if (unlikely(slot >= mb_chann->msg_buf_num)) {
> +		MB_ERR(mb_chann, "Invalid msg_id 0x%x", msg_id);
>   		return -EINVAL;
>   	}
> +	mb_msg = mailbox_msg_ptr(mb_chann, slot);
>   
>   	MB_DBG(mb_chann, "opcode 0x%x size %d id 0x%x",
>   	       header->opcode, header->total_size, header->id);
> -	if (mb_msg->notify_cb) {
> -		ret = mb_msg->notify_cb(mb_msg->handle, data, header->total_size);
> -		if (unlikely(ret))
> -			MB_ERR(mb_chann, "Message callback ret %d", ret);
> +
> +	/*
> +	 * msg_id is slot | MAGIC_VAL and is reused as soon as the slot is
> +	 * freed. The management firmware protocol guarantees exactly one
> +	 * response for each request, so a response cannot refer to a previous
> +	 * user of a reused slot. Keep the busy check as a defensive guard
> +	 * against an unexpected response for an idle slot.
> +	 */
> +	if (unlikely(!mb_msg->busy)) {
> +		MB_WARN_ONCE(mb_chann, "Unexpected response for idle slot 0x%x", msg_id);
> +		return 0;
>   	}
>   
> -	kfree(mb_msg);
> +	ret = mailbox_msg_done(mb_msg, data, header->total_size);
> +	if (unlikely(ret))
> +		MB_ERR(mb_chann, "Message callback ret %d", ret);
> +
>   	return ret;
>   }
>   
> @@ -399,7 +459,7 @@ static void mailbox_rx_worker(struct work_struct *rx_work)
>   }
>   
>   int xdna_mailbox_send_msg(struct mailbox_channel *mb_chann,
> -			  const struct xdna_mailbox_msg *msg, u64 tx_timeout)
> +			  const struct xdna_mailbox_msg *msg)
>   {
>   	struct xdna_msg_header *header;
>   	struct mailbox_msg *mb_msg;
> @@ -428,9 +488,12 @@ int xdna_mailbox_send_msg(struct mailbox_channel *mb_chann,
>   		return -EPIPE;
>   	}
>   
> -	mb_msg = kzalloc(sizeof(*mb_msg) + pkg_size, GFP_KERNEL);
> -	if (!mb_msg)
> -		return -ENOMEM;
> +	mutex_lock(&mb_chann->lock);
> +	mb_msg = mailbox_get_msg_buf(mb_chann, pkg_size);
> +	if (!mb_msg) {
> +		mutex_unlock(&mb_chann->lock);
> +		return -ENOBUFS;
> +	}
>   
>   	mb_msg->handle = msg->handle;
>   	mb_msg->notify_cb = msg->notify_cb;
> @@ -447,28 +510,18 @@ int xdna_mailbox_send_msg(struct mailbox_channel *mb_chann,
>   	header->opcode = msg->opcode;
>   	memcpy(mb_msg->pkg.payload, msg->send_data, msg->send_size);
>   
> -	ret = mailbox_acquire_msgid(mb_chann, mb_msg);
> -	if (unlikely(ret < 0)) {
> -		MB_ERR(mb_chann, "mailbox_acquire_msgid failed");
> -		goto msg_id_failed;
> -	}
> -	header->id = ret;
> -
>   	MB_DBG(mb_chann, "opcode 0x%x size %d id 0x%x",
>   	       header->opcode, header->total_size, header->id);
>   
>   	ret = mailbox_send_msg(mb_chann, mb_msg);
>   	if (ret) {
>   		MB_DBG(mb_chann, "Error in mailbox send msg, ret %d", ret);
> -		goto release_id;
> +		mb_msg->busy = false;
> +		mutex_unlock(&mb_chann->lock);
> +		return ret;
>   	}
> +	mutex_unlock(&mb_chann->lock);
>   
> -	return 0;
> -
> -release_id:
> -	mailbox_release_msgid(mb_chann, header->id);
> -msg_id_failed:
> -	kfree(mb_msg);
>   	return ret;
>   }
>   
> @@ -487,6 +540,7 @@ struct mailbox_channel *xdna_mailbox_alloc_channel(struct mailbox *mb)
>   		goto free_chann;
>   	}
>   	mb_chann->mb = mb;
> +	mutex_init(&mb_chann->lock);
>   
>   	return mb_chann;
>   
> @@ -500,7 +554,9 @@ void xdna_mailbox_free_channel(struct mailbox_channel *mb_chann)
>   	if (!mb_chann)
>   		return;
>   
> +	kfree(mb_chann->msg_buf);
>   	destroy_workqueue(mb_chann->work_q);
> +	mutex_destroy(&mb_chann->lock);
>   	kfree(mb_chann);
>   }
>   
> @@ -509,7 +565,7 @@ xdna_mailbox_start_channel(struct mailbox_channel *mb_chann,
>   			   const struct xdna_mailbox_chann_res *x2i,
>   			   const struct xdna_mailbox_chann_res *i2x,
>   			   u32 iohub_int_addr,
> -			   int mb_irq)
> +			   int mb_irq, u32 n_msg)
>   {
>   	int ret;
>   
> @@ -523,7 +579,16 @@ xdna_mailbox_start_channel(struct mailbox_channel *mb_chann,
>   	memcpy(&mb_chann->res[CHAN_RES_X2I], x2i, sizeof(*x2i));
>   	memcpy(&mb_chann->res[CHAN_RES_I2X], i2x, sizeof(*i2x));
>   
> -	xa_init_flags(&mb_chann->chan_xa, XA_FLAGS_ALLOC | XA_FLAGS_LOCK_IRQ);
> +	/*
> +	 * msg_buf is a flat array of n_msg slots, separate from the hardware
> +	 * ring buffer. Each slot is rb_size bytes - the combined size of the
> +	 * mailbox_msg metadata and the package payload must not exceed rb_size.
> +	 */
> +	mb_chann->msg_buf = kcalloc(n_msg, MSG_BUF_SZ(mb_chann), GFP_KERNEL);
> +	if (!mb_chann->msg_buf)
> +		return -ENOMEM;
> +
> +	mb_chann->msg_buf_num = n_msg;
>   	mb_chann->x2i_tail = mailbox_get_tailptr(mb_chann, CHAN_RES_X2I);
>   	mb_chann->i2x_head = mailbox_get_headptr(mb_chann, CHAN_RES_I2X);
>   
> @@ -531,6 +596,8 @@ xdna_mailbox_start_channel(struct mailbox_channel *mb_chann,
>   	ret = request_irq(mb_irq, mailbox_irq_handler, 0, MAILBOX_NAME, mb_chann);
>   	if (ret) {
>   		MB_ERR(mb_chann, "Failed to request irq %d ret %d", mb_irq, ret);
> +		kfree(mb_chann->msg_buf);
> +		mb_chann->msg_buf = NULL;
>   		return ret;
>   	}
>   
> @@ -544,7 +611,7 @@ xdna_mailbox_start_channel(struct mailbox_channel *mb_chann,
>   void xdna_mailbox_stop_channel(struct mailbox_channel *mb_chann)
>   {
>   	struct mailbox_msg *mb_msg;
> -	unsigned long msg_id;
> +	u32 i;
>   
>   	if (!mb_chann)
>   		return;
> @@ -555,12 +622,22 @@ void xdna_mailbox_stop_channel(struct mailbox_channel *mb_chann)
>   	/* Cancel RX work and wait for it to finish */
>   	drain_workqueue(mb_chann->work_q);
>   
> -	/* We can clean up and release resources */
> -	xa_for_each_start(&mb_chann->chan_xa, msg_id, mb_msg, mb_chann->next_msgid)
> -		mailbox_release_msg(mb_chann, mb_msg);
> -	xa_for_each_range(&mb_chann->chan_xa, msg_id, mb_msg, 0, mb_chann->next_msgid - 1)
> -		mailbox_release_msg(mb_chann, mb_msg);
> -	xa_destroy(&mb_chann->chan_xa);
> +	/* Release any in-flight messages in the pool
> +	 *
> +	 * Drain in submission order: next_slot points to the slot after
> +	 * the most recently assigned one, so start from next_slot and
> +	 * wrap around so callbacks fire oldest-first.
> +	 */
> +	for (i = 0; i < mb_chann->msg_buf_num; i++) {
> +		u32 slot = (mb_chann->next_slot + i) % mb_chann->msg_buf_num;
> +
> +		mb_msg = mailbox_msg_ptr(mb_chann, slot);
> +		if (!mb_msg->busy)
> +			continue;
> +		MB_DBG(mb_chann, "msg_id 0x%x msg opcode 0x%x",
> +		       mb_msg->pkg.header.id, mb_msg->pkg.header.opcode);
> +		mailbox_msg_done(mb_msg, NULL, 0);
> +	}
>   
>   	MB_DBG(mb_chann, "Mailbox channel stopped, irq: %d", mb_chann->msix_irq);
>   }
> diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.h b/drivers/accel/amdxdna/amdxdna_mailbox.h
> index 2908404303ae..7f4a40b4230b 100644
> --- a/drivers/accel/amdxdna/amdxdna_mailbox.h
> +++ b/drivers/accel/amdxdna/amdxdna_mailbox.h
> @@ -88,6 +88,10 @@ struct mailbox_channel *xdna_mailbox_alloc_channel(struct mailbox *mb);
>    * @i2x: firmware to host mailbox resources
>    * @xdna_mailbox_intr_reg: register addr of MSI-X interrupt
>    * @mb_irq: Linux IRQ number associated with mailbox MSI-X interrupt vector index
> + * @n_msg: number of message slots to pre-allocate; must be non-zero for
> + *         the PCI transport (the platform transport ignores this argument).
> + *         Each slot is rb_size bytes. The caller must ensure at most n_msg
> + *         messages are in flight at any time.
>    *
>    * Return: If success, return a handle of mailbox channel. Otherwise, return NULL.
>    */
> @@ -96,7 +100,7 @@ xdna_mailbox_start_channel(struct mailbox_channel *mb_chann,
>   			   const struct xdna_mailbox_chann_res *x2i,
>   			   const struct xdna_mailbox_chann_res *i2x,
>   			   u32 xdna_mailbox_intr_reg,
> -			   int mb_irq);
> +			   int mb_irq, u32 n_msg);
>   
>   /*
>    * xdna_mailbox_free_channel() -- free mailbox channel
> @@ -117,11 +121,10 @@ void xdna_mailbox_stop_channel(struct mailbox_channel *mailbox_chann);
>    *
>    * @mailbox_chann: Mailbox channel handle
>    * @msg: message struct for message information
> - * @tx_timeout: the timeout value for sending the message in ms.
>    *
>    * Return: If success return 0, otherwise, return error code
>    */
>   int xdna_mailbox_send_msg(struct mailbox_channel *mailbox_chann,
> -			  const struct xdna_mailbox_msg *msg, u64 tx_timeout);
> +			  const struct xdna_mailbox_msg *msg);
>   
>   #endif /* _AIE_MAILBOX_ */
> diff --git a/drivers/accel/amdxdna/amdxdna_mailbox_helper.c b/drivers/accel/amdxdna/amdxdna_mailbox_helper.c
> index 6d0c24513476..ee33a34852f0 100644
> --- a/drivers/accel/amdxdna/amdxdna_mailbox_helper.c
> +++ b/drivers/accel/amdxdna/amdxdna_mailbox_helper.c
> @@ -44,7 +44,7 @@ int xdna_send_msg_wait(struct amdxdna_dev *xdna, struct mailbox_channel *chann,
>   	struct xdna_notify *hdl = msg->handle;
>   	int ret;
>   
> -	ret = xdna_mailbox_send_msg(chann, msg, TX_TIMEOUT);
> +	ret = xdna_mailbox_send_msg(chann, msg);
>   	if (ret) {
>   		XDNA_ERR(xdna, "Send message failed, ret %d", ret);
>   		return ret;
> diff --git a/drivers/accel/amdxdna/amdxdna_mailbox_helper.h b/drivers/accel/amdxdna/amdxdna_mailbox_helper.h
> index 556c712cad0a..11924d38f2fe 100644
> --- a/drivers/accel/amdxdna/amdxdna_mailbox_helper.h
> +++ b/drivers/accel/amdxdna/amdxdna_mailbox_helper.h
> @@ -6,7 +6,6 @@
>   #ifndef _AMDXDNA_MAILBOX_HELPER_H
>   #define _AMDXDNA_MAILBOX_HELPER_H
>   
> -#define TX_TIMEOUT 2000 /* milliseconds */
>   #define RX_TIMEOUT 5000 /* milliseconds */
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>   
>   struct amdxdna_dev;
