Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A217C5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 20:04:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6487210E8A1;
	Wed, 26 Aug 2026 20:04:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XayR9xPw";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010046.outbound.protection.outlook.com [52.101.56.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49F4510E8A1
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 20:04:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YxtASuBkQp6OIsloy1xyNMSf+Fz+HhP0yqZxtWoBxabn/AZibn1Ecpag4/LslYKxVVCRhvCsah6f+qTbrHug6yKfHfWF5n4UbCTgQOa9IDX1H5+5SUlLGYRxxdfVxRjZi5dpxhjjz25/OeiWQcwMEgltph2/BsT3LjalNicD7lLaIr/KWqD28I/+wrgp1LfrZn006//+Vu6JG+ZDU/MPSHBFqmtw/SFuQsxTcCGOxsWnr4ZdVpO0fSPqabEfcwPf6T28jurfRXvTBCUZnW+nGxLPdA146LLgB/808aW3k4ojg0aA/mWctnbHroY4PvI9Z5LjdIdhg5lCshzNR54pgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCQfqjzttg40eCX74zvbJBobQ6rD0ksaKQz0slEjfhw=;
 b=mx9rGS61APcRAydDtsyS+uuvjnOd5Z4sgFRJS27biZBnZSYPex+O+MndrQ1G8MwDFdQXZ/9JgN5E3mUUIEG55/zj4brYNjyNYbTF9wrzJIuzURmCyCwhj476S/l8bZhADJemGXI89vJgWnYh4V+cuZcDenSo5tSaddo22cMBYu59RbbF+RUNv9YjP45nwshXdgKXtyYQh7KYQlpr2VMrL+tZlCNk2H26DScVLz6r8ks3+4HVGBDbKZ5u8ce7mE5whuZ3+1hsTQBDJktVW7Un+avU0W8aDBf8zyCa3ABrg5foumtihX7Hj6at02qUjdblnr9yIRNYT6dIZ0EIYLq54g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=kaitmazov.com smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCQfqjzttg40eCX74zvbJBobQ6rD0ksaKQz0slEjfhw=;
 b=XayR9xPw9P+hHN6GN2fTLCagjJxKVra4vK6bqdbhTVNtT5QFs+LO4AiWJ+NosiPHjzk8ytvSPWNKLpx3wRsQedl3QRx9iUctd85freFj1lqGDrKhD0HL9uKsdNXl4qaOgy3Acz28iiS8Icf4Q8hRjMp3C4814KKRvRPw2GT0JgM=
Received: from IA4P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:559::17)
 by PH7PR12MB6763.namprd12.prod.outlook.com (2603:10b6:510:1ad::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 20:04:46 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:208:559:cafe::54) by IA4P221CA0007.outlook.office365.com
 (2603:10b6:208:559::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 20:04:45 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 20:04:45 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 15:04:45 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 15:04:45 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Wed, 26 Aug 2026 15:04:44 -0500
Message-ID: <fffd0a2c-9cc8-247e-578c-7ddbdf4ee881@amd.com>
Date: Wed, 26 Aug 2026 13:04:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] accel/amdxdna: make the debug BO command wait
 interruptible
Content-Language: en-US
To: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>, Min Ma <mamin506@gmail.com>, 
 Oded Gabbay <ogabbay@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <b7e8caf7-18de-fcbb-ee42-1b49b67b5eef@amd.com>
 <20260826184503.282106-1-taimuraz@kaitmazov.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260826184503.282106-1-taimuraz@kaitmazov.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|PH7PR12MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: cbd8c8ef-958f-4565-0a8a-08df03ad4671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|7136999003|10067099003|18002099003|22082099003|4143699003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: lFME0PyFaubRnc5YLz/jBHAdqSXHEQfOHNzeWCdPthF4hqCgChUy7TO+b4TGzfJVkKQqFiNxjbsiTp9CyaVZyi7N3jqKnhiJzdevwIIlHW/jFrtMwDF6OOWROiVFc0l7yhbRxE2PVOr5KRTgrZjbWj+iDAg+xXcUMxVSV/S+noxXR0U+ys2na5r/z/2XHzN2GYASw+N/FvRTUyC28USlfhnCTXud6TUyN00bZyAyNGKq0uuKhCOycONKM3FvwOWM7dDvdWoIRNebyBjGFbEXfl9jmxzOak/eWznzi+QX3QZkmKCKJRBLzCvcYpYqTN7iWU8Frj+qckAb9e+Eh6kGuRlTvKnOE+0uydcGrEpUuYC0PpeySs3NPxkhweEMiFN0IM2a4Cc4vaJzTvttFgB/2Da0WwkF63JeUtp/Fku3bPHfeN6XgqfJFhJoZjUChvLkhe64BkXKqfWQ/+rmSGATQwzv5mZoNhIgzoHzSySAE6r1t4edNqniqaF8JtB8x8zi+50vhO0OUJ2vHzw2ff7VbZY5ihcJhoyd6LeKEv9WuVva+ysb9wGA2aaTs5eRB62TnT1cfg4WlIiF2VyYWukztOd67011V0FeTdO6vGQmlHvC3MN4gFivh2yUrtxgmuqZELNGODrUmVvwMDn+6MhmQ27CG4AxWlozVGQ69Vs1Ovw4NkeTWWteQkkQaxStPJZR4sh2Rb2BRh4B3GrGIi5FAA==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(7136999003)(10067099003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: napxcwg1vgRFv5lPnLodoFsiHvyypTBs2+aFynFcxOhObe6c5VeS200WXXLsbPKkQhsPsSBXcge5Z5j+/XzqtpwhrYZ10nwAvdmsUpaos8Yn/QdVTrvI4L/zM0mVv9vP2+yBSYJlkgHRi8WQv0FckwZIX4se4X7lRRNwtPsb7fSVJpMwJ2BArq8Vr8DEGxKvA1RflaGjI0R2rR4FbU8Lk9vB+GJKf6DJ3gxGpjFRtscU3h8lAsj2zmQVclWxHbgm679DY2ODJYkDIBolS0skVxWV3sFolt/MjcbaDtYhvd3UmM9JeIJEGZzuHrUsmH/ZyepVfUuZNPv3APN0LlFV4UvAUkUVx4TYUHcvvVfh7WypKI+WJMHCuwzi1O7q8yPtSbEFS6ncgrsTgf1keIJwBhWcL7hkAcwiitZ6eeC6wNWDqNkH70fLus5ePirXzmgi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 20:04:45.4178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd8c8ef-958f-4565-0a8a-08df03ad4671
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6763
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


On 8/26/26 11:45, Taimuraz Kaitmazov wrote:
> aie2_cmd_wait() waits uninterruptibly and without a timeout. Commit
> c8d2530791cb ("accel/amdxdna: Fix deadlock on debug BO command timeout")
> drops dev_lock around that wait, but the callers still hold client_lock,
> and that one is device wide. So while a debug BO command is outstanding,
> nobody can open the device, nobody can close their DRM file and exit, and
> the module cannot be unloaded.

That is expected. It relies on the 2 seconds timeout to remove the 
context, kill the job and return. Exiting earlier and allowing other 
operations like open/close/remove module while firmware is dealing with 
command may cause other issues. And It should never happen that the 
command runs more than 2 seconds unless a firmware/hardware issue.

>
> Normally the scheduler timeout ends it: tdr_timeout_ms defaults to 2000.
> But with tdr_timeout_ms=0 there is no scheduler timeout at all, the wait
> never ends, and since it is uninterruptible you cannot even kill the
> stuck task to get client_lock back.

tdr_timeout_ms is used for debugging. User should never change it.

Lizhi

>
> So wait interruptibly and pass the result up. I return -EINTR and not
> -ERESTARTSYS on purpose: the command is still in flight, and a restarted
> ioctl would just submit a second one.
>
> If the wait is interrupted we do not know what firmware did, so
> aie2_hwctx_cfg_debug_bo() cannot tell whether the BO got attached. It
> records it as attached, because DETACH is refused for a BO that is not
> assigned to the context, and the other way round would leave a BO
> attached in firmware with no way to detach it. aie2_hwctx_sync_debug_bo()
> does not touch that state, so it needs nothing here.
>
> Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
> ---
> v2:
> - Rebased onto drm-misc-fixes, as you asked. v1 was against
>    drm-misc-next, which does not carry that commit, so the deadlock
>    reasoning in its message is gone. Please also disregard my follow-up
>    question on the v1 thread: it asked which of two shapes you would
>    prefer, and one of them was what you had already done.
> - Return -EINTR instead of -ERESTARTSYS.
> - Record the debug BO as attached when the wait is interrupted.
> - Leave the !out_fence path returning success as before, so this patch
>    changes only the wait.
>
>   drivers/accel/amdxdna/aie2_ctx.c | 33 +++++++++++++++++++++++++++-----
>   1 file changed, 28 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
> index b713a57b3a3b..175fceea5c8f 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -908,20 +908,30 @@ static int aie2_hwctx_cu_config(struct amdxdna_hwctx *hwctx, void *buf, u32 size
>   	return ret;
>   }
>   
> -static void aie2_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq)
> +static int aie2_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq)
>   {
>   	struct dma_fence *out_fence = aie2_cmd_get_out_fence(hwctx, seq);
>   	struct amdxdna_dev *xdna = hwctx->client->xdna;
> +	long ret;
>   
>   	if (!out_fence) {
>   		XDNA_ERR(xdna, "Failed to get fence");
> -		return;
> +		return 0;
>   	}
>   
>   	mutex_unlock(&xdna->dev_lock);
> -	dma_fence_wait_timeout(out_fence, false, MAX_SCHEDULE_TIMEOUT);
> +	ret = dma_fence_wait_timeout(out_fence, true, MAX_SCHEDULE_TIMEOUT);
>   	mutex_lock(&xdna->dev_lock);
>   	dma_fence_put(out_fence);
> +
> +	/*
> +	 * The command is still in flight. If the ioctl were restarted it
> +	 * would submit a second one.
> +	 */
> +	if (ret == -ERESTARTSYS)
> +		return -EINTR;
> +
> +	return ret < 0 ? ret : 0;
>   }
>   
>   static int aie2_hwctx_cfg_debug_bo(struct amdxdna_hwctx *hwctx, u32 bo_hdl,
> @@ -968,7 +978,17 @@ static int aie2_hwctx_cfg_debug_bo(struct amdxdna_hwctx *hwctx, u32 bo_hdl,
>   		goto put_cmd;
>   	}
>   
> -	aie2_cmd_wait(hwctx, seq);
> +	ret = aie2_cmd_wait(hwctx, seq);
> +	if (ret) {
> +		/*
> +		 * The command may still attach the BO. Record it as attached,
> +		 * or DETACH will refuse it and there is no way back.
> +		 */
> +		if (attach)
> +			abo->assigned_hwctx = hwctx->id;
> +		goto put_cmd;
> +	}
> +
>   	if (cmd->result) {
>   		XDNA_ERR(xdna, "Response failure 0x%x", cmd->result);
>   		ret = -EINVAL;
> @@ -1028,7 +1048,10 @@ int aie2_hwctx_sync_debug_bo(struct amdxdna_hwctx *hwctx, u32 debug_bo_hdl)
>   		goto put_cmd;
>   	}
>   
> -	aie2_cmd_wait(hwctx, seq);
> +	ret = aie2_cmd_wait(hwctx, seq);
> +	if (ret)
> +		goto put_cmd;
> +
>   	if (cmd->result) {
>   		XDNA_ERR(xdna, "Response failure 0x%x", cmd->result);
>   		ret = -EINVAL;
