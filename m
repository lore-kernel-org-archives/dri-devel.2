Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BEBC624CE
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 01:13:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1196C10E09D;
	Tue,  1 Sep 2026 01:13:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QDZmoIBL";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010024.outbound.protection.outlook.com [52.101.85.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 738A810E067;
 Tue,  1 Sep 2026 01:13:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hvC1vIWXeLUnujxFs6BK9OQfQHqmnGCgb3bFGSZVexI9lqS4IIF+nzgSGKMO9B7SzuOiM4ZjBXB8wULlNg44K4ize0xRnaBtsAK0nY/S0XlsljdMd5Rc169ljnARAixeArImh74W2q7M4a0ItDgUhj1psc7N7lI+K5WqFz3FSKYejJWX934gcM0xh3s+dNw7PCeWbVzH7StXwLTvAlGV5KU/82yxC+L+Q6ThaLSY6TlJzsETHOnuDrHRhmXn1jWXlL81i8gdJ//Dl7HB/YOoNtIQVe9KdQKY3EV2E+LnbGqyHcxMa4YzYVW30lRWkKR9gpWPdS+UlDZ08h63TciTVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xh5PHmH+CnPz+krg7zzKESp9BkZbWcircyrYvdoOTQ8=;
 b=H+8oBdQ9JdAxKKe4yhEFvLmqGP0Z6vL906+TF9fbx3qd7mbJxOc3UmehuJsNu6h95umxOW+2aS0UdYIEDCjrqz5uX6d2xAwpOHUsCyD5qEPrI+sY4odhog1pmxUxi4Xx21AaXCxLMAFFde0pncqv+t0gg/gVJfuYAmxkToNOZ17IPmDNVpdEZpSfEpmk5OKYoIYem60O9ONtNRJgXLoL7BTfk45XJt4KXvLuFAcgrYdUTlKmGHWhkSAm7imljflBr+SkmAxv903KvYZfq86GAlRipjm1q9u7f7YRzuDCBsuVKu3xIHuTOBr1T8nfyEbyEulfgSsJ4+m5j788BY27Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xh5PHmH+CnPz+krg7zzKESp9BkZbWcircyrYvdoOTQ8=;
 b=QDZmoIBL/NJ3BPwInxIELzjrCbnwSPI/zQ8lhfM9vC9SXg3vLk4PF1/wr/qGgy8QXosj495wJ/kuzbh3uoLfxCgB144SWKntEMoktilzsvL+bncORbSYM9uWFYI+3sF0eWuGaxA0R7dyV0U4hPqxkdGobqtL3+Vg4QjDMhbVRho=
Received: from CH5P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::9)
 by DM4PR12MB6542.namprd12.prod.outlook.com (2603:10b6:8:89::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Tue, 1 Sep 2026 01:13:27 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::39) by CH5P220CA0015.outlook.office365.com
 (2603:10b6:610:1ef::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 01:13:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 01:13:26 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 20:13:26 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 20:13:26 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 20:13:25 -0500
Message-ID: <0b43b082-4947-3e96-ac20-0a5443e8a4c1@amd.com>
Date: Mon, 31 Aug 2026 18:13:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] accel/amdxdna: fix race condition in mailbox send path
Content-Language: en-US
To: Deniz Aydogan <denizaydogan1902@gmail.com>, <amd-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20260828221641.10034-1-denizaydogan1902@gmail.com>
 <20260829075303.7457-1-denizaydogan1902@gmail.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260829075303.7457-1-denizaydogan1902@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|DM4PR12MB6542:EE_
X-MS-Office365-Filtering-Correlation-Id: f4a27099-0a56-4f12-35ae-08df07c63a06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|5023799004|4143699003|10067099003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 0t/XNSX+TAFlJEALe1nGFzEX7Fmh8v2LwGlfd4HlSmFOsZfLPNUH4Bn9pHwp9AkQkPsuOPJXbNm5RhW74HLhb7EPV2KaUrJzHk6GHoQmNmbkw1Xa7hLOMewn/sUz8sZAID2hmVPKLZLJlJRbNoAEixX9ah4zMdZitnCf2tR7+gDqsvZAJDFjkFMb17din2yNK2C3xoizhKx/qgYf8ce61/0LE6rt/maKrDsYRYUC6bGWgAhEDQjPPc1BWrsV66Z5Ha2k+o18oMzsi20nSsebABa9KHvZO6k6PN1uxBP4ES8Oz1Uw8i6ukHZ3dwy5mJYNsxDfX7d3oLoKqpWDQO/qe1S112RNIGOW3G/3bRPESMh1CuEnhp6KKhPsOerdwOYSD/kQlXANLecspjGYk5/pYZ7tvzPRFxPL/N0C6daiW1ot486KmSwpdzT9ll6kecaf4jIi3cbvpOGOnXqGVpsSp5pBVBO+OKbKXbJHylhKS6N1DLR+tkwPIRksKhaxbhWqLtepr5+4Am2kMOJb+w0cCSv9a11kQKT9pQ8iWquGNW2atk76ah2+g0LViLP/ioRtqLYr60NvDUZkwzQ/t+4Jg1du7iKwqP2laX9pcZcH6snk1mpe94GyCYG6WyLPwVd8Z3H/4JX7qKWkJ5mgF18Mj5nqYmDefLl26QDte1ZWyCj0+MXRP8otv5tLrBiW0N2d
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(5023799004)(4143699003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eoqZLQ3LBMbryJ8CjG2RSlPKPRy9DTmp4MU0TKaM4VhydjfgLGUwy+dHITUPRtP2r7rTi3YTuxvobnLmLsphcRBIVkqumBtfzcm0AWKYPQksrxjJESn4W4Gnd/yRc7de0ofhddT12A+V+XzDGs7EiGwh9raYllTi+Qme2bOj9VswMaV4PZJUwTAYWf7M2S1rkoHy/mCebgdvE7DcVo/JsbwV1L++dicUaZV6gxnyxey1Cxp/3ZixaEW2Ripabs1lGWxhJVAEGsFFddNSmsqAl9EaQUdEKfVh2uOoOrGSFItg/z7KgVIYya339+zz/lkn7+FysdJHfHLuZIK/q5wxXtI4vNiWQfSSJI+bKQ/FcUwCCQhBqQv/NElRa4+PCdsuAvBdBSxTuf2okBE+SoWbFbY0tRiW7Yf1OHKC5izLBhuCeI31TvodgTbITiZhN7HT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 01:13:26.7770 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a27099-0a56-4f12-35ae-08df07c63a06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6542
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


On 8/29/26 00:53, Deniz Aydogan wrote:
> mailbox_send_msg() reads and updates x2i_tail without any
> synchronization. The DRM scheduler and ioctl paths can call
> xdna_mailbox_send_msg() concurrently on the same channel, which
> allows two threads to read the same tail value and corrupt the
> hardware ring buffer.

Is this trying to address the sashiko comment?

The config cu ioctl should not concurrently running with commands 
(submitting by DRM scheduler). If this happens, it indicates a bug in 
user space. And the commands submitted to the same hwctx (mailbox 
channel) could fail. The incorrect application may mess up itself and it 
would not impact other processes.

Thanks,

Lizhi

>
> Add a mutex to serialize the entire send path. A mutex is used
> rather than a spinlock because the existing code calls
> read_poll_timeout() with a non-zero sleep, which can reschedule.
>
> Fixes: 3ba13f5e7180 ("Merge tag 'devicetree-fixes-for-7.3-1'")
> Signed-off-by: Deniz Aydogan <denizaydogan1902@gmail.com>
> ---
>   drivers/accel/amdxdna/amdxdna_mailbox.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/amdxdna/amdxdna_mailbox.c
> index 271617347..8338f03bd 100644
> --- a/drivers/accel/amdxdna/amdxdna_mailbox.c
> +++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
> @@ -8,6 +8,7 @@
>   #include <linux/bitfield.h>
>   #include <linux/interrupt.h>
>   #include <linux/iopoll.h>
> +#include <linux/mutex.h>
>   #include <linux/slab.h>
>   #include <linux/xarray.h>
>   
> @@ -60,6 +61,7 @@ struct mailbox_channel {
>   	struct xarray			chan_xa;
>   	u32				next_msgid;
>   	u32				x2i_tail;
> +	struct mutex			lock;
>   
>   	/* Received msg related fields */
>   	struct workqueue_struct		*work_q;
> @@ -205,6 +207,7 @@ mailbox_send_msg(struct mailbox_channel *mb_chann, struct mailbox_msg *mb_msg)
>   	u32 tmp_tail;
>   	int ret;
>   
> +	mutex_lock(&mb_chann->lock);
>   	head = mailbox_get_headptr(mb_chann, CHAN_RES_X2I);
>   	tail = mb_chann->x2i_tail;
>   	ringbuf_size = mailbox_get_ringbuf_size(mb_chann, CHAN_RES_X2I) - sizeof(u32);
> @@ -225,8 +228,10 @@ mailbox_send_msg(struct mailbox_channel *mb_chann, struct mailbox_msg *mb_msg)
>   		ret = read_poll_timeout(mailbox_get_headptr, head,
>   					tmp_tail < head || tail >= head,
>   					1, 100, false, mb_chann, CHAN_RES_X2I);
> -		if (ret)
> +		if (ret) {
> +			mutex_unlock(&mb_chann->lock);
>   			return ret;
> +		}
>   
>   		if (tail >= head)
>   			goto check_again;
> @@ -240,6 +245,7 @@ mailbox_send_msg(struct mailbox_channel *mb_chann, struct mailbox_msg *mb_msg)
>   			    mb_msg->pkg.header.opcode,
>   			    mb_msg->pkg.header.id);
>   
> +	mutex_unlock(&mb_chann->lock);
>   	return 0;
>   }
>   
> @@ -487,6 +493,7 @@ struct mailbox_channel *xdna_mailbox_alloc_channel(struct mailbox *mb)
>   		goto free_chann;
>   	}
>   	mb_chann->mb = mb;
> +	mutex_init(&mb_chann->lock);
>   
>   	return mb_chann;
>   
