Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF54C3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 18:37:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED6DD10E18B;
	Wed, 14 Oct 2026 18:37:11 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012063.outbound.protection.outlook.com [52.101.43.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04D7610E18B
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 18:37:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRsjXhdtlamz0USv9gpFN4RE17t6GUTt9WExEa42qTVMcg0Nr549kxdrC8n81S7gfXmbVnjfKMuzVRsvyX3NauI5rtUAtV5qGKtHNN2aqUAM1dunqE/zBL1wKmXiVdDHi69y3VKPX7MBFMGBcJYM/cpEUlRCIj9BjlMG+BewzlXpNFZ/5Cih/0OZw+TsGZthEyMY7dlWLPV334Vs5S21JVL2ZjYigYItLjve+rf8trIW0eo3wKi9r7jUqQSNBcka/vTZwmYeFlcQs0CO7/BeMECMsDyAbmL7BfyuJaEP87KFjGHgTT6ARn1xtuNBT4pYtlxkmh05oyymiilEtLwRSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyMfqintm8aj2Sui2MH/QR2TVt+KD2frPLFxGIglsQQ=;
 b=nPlPbPA/xBzg1kMOMiDPt9NZmHfk1Y1fhHLF8k15/8nzGWiWQjk2UnjfDAU9V9WaO1DMc/BrskNrD3fh33tVwOSWGJRjeudUBKQPJhRGHsZqsZIaCvw84qjsw7SwJ+ejclIvbv56/J+MZJyIng56Ph3LN4cC2waM5nqv4te+YuorBdS4L0oomh8ZZLymwwu2/j0olwuvtr2XX3OHyo6NB/IQqTJ64ACiK2/qTw6HQKIeTcGXUN7c42c9lUIFIuGrttO971+pZGNric36oBMppB88y4R4RQii4TyBM1hb1DoYbUF+4/8WX2P8vJ18oJrZKOYyi5ehGpoZTjofMvAXGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyMfqintm8aj2Sui2MH/QR2TVt+KD2frPLFxGIglsQQ=;
 b=sJ/xq4/ijpw4XGUjLbFfPpK722bawFCcLFHcY96r1ruY9NkmKcXX+rI2+mH+h4fIKCADqh0eJ4w6Z1v1YoGP+pRIeFajl7YPDUnCNwEI6+xVXwkZWiqnUawq/5k+xLth9IC7Cab3sapT9tEGcuSeUzhQbMaO0dcYlLjtPG/OHEE=
Received: from PH7P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::8)
 by MW6PR12MB8705.namprd12.prod.outlook.com (2603:10b6:303:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Wed, 14 Oct
 2026 18:36:50 +0000
Received: from CY8PEPF00000057.namprd21.prod.outlook.com
 (2603:10b6:510:32a:cafe::ac) by PH7P221CA0014.outlook.office365.com
 (2603:10b6:510:32a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 14
 Oct 2026 18:36:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY8PEPF00000057.mail.protection.outlook.com (10.167.247.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.0 via Frontend Transport; Wed, 14 Oct 2026 18:36:47 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 13:36:40 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 14 Oct 2026 13:36:39 -0500
Message-ID: <ebcf212e-fadf-8661-565e-bb7b63afc46a@amd.com>
Date: Wed, 14 Oct 2026 11:36:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V4 19/19] accel/amdxdna: Implement runtime suspend and
 resume support
Content-Language: en-US
To: David Zhang <yidong.zhang@amd.com>, <quic_jhugo@quicinc.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <sonal.santan@amd.com>, <mario.limonciello@amd.com>
References: <yidong.zhang@amd.com>
 <20261009225343.3079074-1-yidong.zhang@amd.com>
 <20261009225343.3079074-20-yidong.zhang@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20261009225343.3079074-20-yidong.zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF00000057:EE_|MW6PR12MB8705:EE_
X-MS-Office365-Filtering-Correlation-Id: e0fc15f1-3b82-4b4b-e81d-08df2a221a86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|261009223327099003|56012099006|10067099003|11063799006|4143699003|261009220027099003|261009223027099003|22082099003|18002099003|261009221227099003|261009221727099003;
X-Microsoft-Antispam-Message-Info: 0KTxrWhcnxTZPds2IRVdOBDwcKIiBH3UGA1yru0WCgoZzbL/6nliArmp9sEQBrOiuq1izRFPD4i67t/wLcOrAFeMrilVxVG2oxdEm7+B4+VC1lzt9Ilw0V2zb5cvy2zjsahedvt3uqbIpyGp1rebOcLMZL4SxdCDh1sOVIACRoIHBVuHNzMudwlb+bOtmQ4oMmbnubrr6YUdWWp4tHB4bdleD2muOP0QoCuB1ayPmeOfpkd5oIkVE22Vu/P3ayjO40F9fbgxkFlEBCLaGjMsZBauh+/7gMUHOcDC2Vy+k1GMO8fsoT/iY/XNy3Pg91jEXqTzBmTuFhOiIH+7RKyKE11SBf0wfmRIHjnkfdei4SuTwVMWWRjAl9L6jxtvYvewtOUIcQVriw4839tCSDPSdtNy+lqKpbr9OX6v1F+52HKEc/5N49Sy7xi9noswp4TdMX/2Ps7Cap9kngd/dxVGbtL8p2qr3GvWHSTnraJKqOsBvU28xg5XbJnTlhlayScnyhMEHNoPU3/881wedsvoVBZNZlvpe381HCulDMxf/y4+JbQTwq2Fdn7Rx3m95gUsg3AteUH269+cPgb0IBtgCIaYtrhF7UUVRqCrV9YL3YhZzeXK6izLQY8TfWjO9LCv7p1izNIba169SU8n1WDfH5DgjUc5/cgaSYXC56TNl6AXzwdBUvFybHjTTOkMLZbfeG20iDmVE4Cpo1rmXZ7zkQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(261009223327099003)(56012099006)(10067099003)(11063799006)(4143699003)(261009220027099003)(261009223027099003)(22082099003)(18002099003)(261009221227099003)(261009221727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nEk/OvZd7Z3C9T/fGYDG/CwZmSSBRYBodtjL6DOWI+kX19Qs5Jnx+ut8MqFJDINE/bZ94dFjADidICNQfM4or/O2PIriCjNH7GWXkJiMKCjQ34qUqxtNH6dMUHja17I6KJvZM2kkVNJTOHrfZbpotWfwFbPnnhuqWALnaS+n/+zw6NfIPGHCTMO3QWu5EpGBWwRtT4M9UW3yM74DRnwUChkpkQIQrRVCTKbMpJ1SMvyhG5NU1XpiQR16RxVpFrj26vKKO9xXLVnHh2qVClaEngTY01DjJeie5/WCv9MaZudAm3ZNa7aa2a3ha2pPdt7jeV3+kRrKJ79OPth8VMi5qqac3/UogPMobb+0Z30yeK/4XLz2wtNcsCl1smeUkFemp5hzNfxrSWhGCz22cNWS3rSgB3gYTlxYHkkn/A3TlFGWYTE+n+DTzLtUZoH//zWn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 18:36:47.1313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0fc15f1-3b82-4b4b-e81d-08df2a221a86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY8PEPF00000057.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8705
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
> Add runtime suspend/resume for the AIE4 classic device by using its
> system suspend/resume handlers.
>
> Runtime suspend returns -EBUSY for a device without runtime_suspend,
> so the PM core keeps it active instead of entering an error state.
>
> A context suspended by runtime PM makes the command wait return
> -EAGAIN. Resume the device in the wait ioctl and wait again, so a
> command wait does not fail because of power management.
>
> Wrap .driver.pm and the AIE4 PM callbacks with pm_ptr(), so they are
> discarded when CONFIG_PM is disabled.
>
> Signed-off-by: David Zhang <yidong.zhang@amd.com>
> ---
>   drivers/accel/amdxdna/aie2_pci.c        |  2 ++
>   drivers/accel/amdxdna/aie4_ctx.c        | 10 +++++-
>   drivers/accel/amdxdna/aie4_pci.c        |  4 +++
>   drivers/accel/amdxdna/amdxdna_ctx.c     | 47 ++++++++++++++++++-------
>   drivers/accel/amdxdna/amdxdna_pci_drv.c |  4 +--
>   drivers/accel/amdxdna/amdxdna_pci_drv.h |  2 ++
>   drivers/accel/amdxdna/amdxdna_pm.c      | 34 ++++++++++++++++++
>   drivers/accel/amdxdna/amdxdna_pm.h      |  2 ++
>   8 files changed, 90 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
> index 690ad035463c..a3866e8933e6 100644
> --- a/drivers/accel/amdxdna/aie2_pci.c
> +++ b/drivers/accel/amdxdna/aie2_pci.c
> @@ -1221,6 +1221,8 @@ const struct amdxdna_dev_ops aie2_ops = {
>   	.fini = aie2_fini,
>   	.resume = aie2_hw_resume,
>   	.suspend = aie2_hw_suspend,
> +	.runtime_resume = aie2_hw_resume,
> +	.runtime_suspend = aie2_hw_suspend,
>   	.get_aie_info = aie2_get_info,
>   	.set_aie_state = aie2_set_state,
>   	.hwctx_init = aie2_hwctx_init,
> diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie4_ctx.c
> index a2b6b0fa2934..a3f0a69b93b7 100644
> --- a/drivers/accel/amdxdna/aie4_ctx.c
> +++ b/drivers/accel/amdxdna/aie4_ctx.c
> @@ -22,6 +22,7 @@
>   #include "amdxdna_mailbox.h"
>   #include "amdxdna_mailbox_helper.h"
>   #include "amdxdna_pci_drv.h"
> +#include "amdxdna_pm.h"
>   
>   #define CTX_INVALID_ID			(~0U)
>   #define CTX_INVALID_DOORBELL		AMDXDNA_INVALID_DOORBELL_OFFSET
> @@ -377,10 +378,14 @@ int aie4_hwctx_init(struct amdxdna_hwctx *hwctx)
>   	if (ret)
>   		goto destroy_lock;
>   
> -	ret = aie4_hwctx_create(hwctx);
> +	ret = amdxdna_pm_resume_get_locked(xdna);
>   	if (ret)
>   		goto umq_fini;
>   
> +	ret = aie4_hwctx_create(hwctx);
> +	if (ret)
> +		goto suspend_put;
> +
>   	priv->job_work_q = alloc_ordered_workqueue("aie4_job_%d_%d", 0,
>   						   client->pid, hwctx->fw_ctx_id);
>   	if (!priv->job_work_q) {
> @@ -388,12 +393,15 @@ int aie4_hwctx_init(struct amdxdna_hwctx *hwctx)
>   		ret = -ENOMEM;
>   		goto destroy_ctx;
>   	}
> +	amdxdna_pm_suspend_put(xdna);
>   
>   	XDNA_DBG(xdna, "hwctx %d.%d init completed", client->pid, hwctx->fw_ctx_id);
>   	return 0;
>   
>   destroy_ctx:
>   	aie4_hwctx_destroy(hwctx, AIE4_HWCTX_NORMAL);
> +suspend_put:
> +	amdxdna_pm_suspend_put(xdna);
>   umq_fini:
>   	aie4_hwctx_umq_fini(hwctx);
>   destroy_lock:
> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
> index 70a052ab5f77..60140c3927a2 100644
> --- a/drivers/accel/amdxdna/aie4_pci.c
> +++ b/drivers/accel/amdxdna/aie4_pci.c
> @@ -1041,6 +1041,7 @@ static int aie4_classic_init(struct amdxdna_dev *xdna)
>   	if (ret)
>   		goto free_work_buf;
>   
> +	amdxdna_pm_init(xdna);
>   	return 0;
>   
>   free_work_buf:
> @@ -1064,6 +1065,7 @@ static void aie4_vf_fini(struct amdxdna_dev *xdna)
>   
>   static void aie4_classic_fini(struct amdxdna_dev *xdna)
>   {
> +	amdxdna_pm_fini(xdna);
>   	aie4_classic_hw_stop(xdna->dev_handle);
>   	aie4_free_fw_log_buffer(xdna->dev_handle);
>   	aie4_free_work_buffer(xdna->dev_handle);
> @@ -1408,4 +1410,6 @@ const struct amdxdna_dev_ops aie4_classic_ops = {
>   	.set_aie_state		= aie4_set_state,
>   	.resume			= pm_ptr(aie4_classic_resume),
>   	.suspend		= pm_ptr(aie4_classic_suspend),
> +	.runtime_resume		= pm_ptr(aie4_classic_resume),
> +	.runtime_suspend	= pm_ptr(aie4_classic_suspend),
>   };
> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
> index 608b86fe8f6b..f4004630dc1b 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
> @@ -761,13 +761,32 @@ int amdxdna_drm_submit_cmd_ioctl(struct drm_device *dev, void *data, struct drm_
>   	return -EINVAL;
>   }
>   
> +static int amdxdna_hwctx_wait_cmd(struct amdxdna_client *client,
> +				  struct amdxdna_drm_wait_cmd *args)
> +{
> +	struct amdxdna_dev *xdna = client->xdna;
> +	struct amdxdna_hwctx *hwctx;
> +	int ret, idx;
> +
> +	idx = srcu_read_lock(&client->hwctx_srcu);
> +	hwctx = xa_load(&client->hwctx_xa, args->hwctx);
> +	if (!hwctx) {
> +		XDNA_DBG(xdna, "PID %d failed to get ctx %d", client->pid, args->hwctx);
> +		ret = -EINVAL;
> +	} else {
> +		ret = xdna->dev_info->ops->cmd_wait(hwctx, args->seq, args->timeout);
> +	}
> +	srcu_read_unlock(&client->hwctx_srcu, idx);
> +
> +	return ret;
> +}
> +
>   int amdxdna_drm_wait_cmd_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   {
>   	struct amdxdna_client *client = filp->driver_priv;
>   	struct amdxdna_dev *xdna = to_xdna_dev(dev);
>   	struct amdxdna_drm_wait_cmd *args = data;
> -	struct amdxdna_hwctx *hwctx;
> -	int ret, idx;
> +	int ret;
>   
>   	XDNA_DBG(xdna, "PID %d ctx %d timeout set %d ms for cmd %llu",
>   		 client->pid, args->hwctx, args->timeout, args->seq);
> @@ -775,22 +794,26 @@ int amdxdna_drm_wait_cmd_ioctl(struct drm_device *dev, void *data, struct drm_fi
>   	if (!xdna->dev_info->ops->cmd_wait)
>   		return -EOPNOTSUPP;
>   
> -	idx = srcu_read_lock(&client->hwctx_srcu);
> -	hwctx = xa_load(&client->hwctx_xa, args->hwctx);
> -	if (!hwctx) {
> -		XDNA_DBG(xdna, "PID %d failed to get ctx %d", client->pid, args->hwctx);
> -		ret = -EINVAL;
> -		goto unlock_ctx_srcu;
> +	ret = amdxdna_hwctx_wait_cmd(client, args);
> +	if (ret == -EAGAIN) {
> +		/*
> +		 * Suspended by power management before the command completed.
> +		 * Resume the device, which reconnects the context, and wait
> +		 * again. Take the PM reference outside hwctx_srcu: runtime
> +		 * resume takes dev_lock, which hwctx destroy holds across
> +		 * synchronize_srcu().
> +		 */
> +		ret = amdxdna_pm_resume_get(xdna);
> +		if (ret)
> +			return ret;
> +		ret = amdxdna_hwctx_wait_cmd(client, args);
> +		amdxdna_pm_suspend_put(xdna);
>   	}
>   
> -	ret = xdna->dev_info->ops->cmd_wait(hwctx, args->seq, args->timeout);
> -
>   	XDNA_DBG(xdna, "PID %d ctx %d cmd %lld wait finished, ret %d",
>   		 client->pid, args->hwctx, args->seq, ret);
>   
>   	trace_amdxdna_debug_point(current->comm, args->seq, "job returned to user");
>   
> -unlock_ctx_srcu:
> -	srcu_read_unlock(&client->hwctx_srcu, idx);
>   	return ret;
>   }
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> index f5f7831c4e80..cb78f145ffa1 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> @@ -465,7 +465,7 @@ static void amdxdna_remove(struct pci_dev *pdev)
>   
>   static const struct dev_pm_ops amdxdna_pm_ops = {
>   	SYSTEM_SLEEP_PM_OPS(amdxdna_pm_suspend, amdxdna_pm_resume)
> -	RUNTIME_PM_OPS(amdxdna_pm_suspend, amdxdna_pm_resume, NULL)
> +	RUNTIME_PM_OPS(amdxdna_pm_runtime_suspend, amdxdna_pm_runtime_resume, NULL)
>   };
>   
>   static int amdxdna_sriov_configure(struct pci_dev *pdev, int num_vfs)
> @@ -484,7 +484,7 @@ static struct pci_driver amdxdna_pci_driver = {
>   	.id_table = pci_ids,
>   	.probe = amdxdna_probe,
>   	.remove = amdxdna_remove,
> -	.driver.pm = &amdxdna_pm_ops,
> +	.driver.pm = pm_ptr(&amdxdna_pm_ops),
>   	.sriov_configure = amdxdna_sriov_configure,
>   };
>   
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
> index 505477b4a292..4d047cf3d981 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
> @@ -57,6 +57,8 @@ struct amdxdna_dev_ops {
>   	void (*debugfs_init)(struct amdxdna_dev *xdna);
>   	int (*resume)(struct amdxdna_dev *xdna);
>   	int (*suspend)(struct amdxdna_dev *xdna);
> +	int (*runtime_resume)(struct amdxdna_dev *xdna);
> +	int (*runtime_suspend)(struct amdxdna_dev *xdna);
>   	int (*sriov_configure)(struct amdxdna_dev *xdna, int num_vfs);
>   	int (*hwctx_init)(struct amdxdna_hwctx *hwctx);
>   	void (*hwctx_stop)(struct amdxdna_hwctx *hwctx);
> diff --git a/drivers/accel/amdxdna/amdxdna_pm.c b/drivers/accel/amdxdna/amdxdna_pm.c
> index b1fafddd7ad5..7d7bc965342d 100644
> --- a/drivers/accel/amdxdna/amdxdna_pm.c
> +++ b/drivers/accel/amdxdna/amdxdna_pm.c
> @@ -37,11 +37,40 @@ int amdxdna_pm_resume(struct device *dev)
>   	return ret;
>   }
>   
> +int amdxdna_pm_runtime_suspend(struct device *dev)
> +{
> +	struct amdxdna_dev *xdna = to_xdna_dev(dev_get_drvdata(dev));
> +	int ret = -EBUSY;
> +
> +	guard(mutex)(&xdna->dev_lock);
> +	if (xdna->dev_info->ops->runtime_suspend)
> +		ret = xdna->dev_info->ops->runtime_suspend(xdna);
> +
> +	XDNA_DBG(xdna, "Runtime suspend done ret %d", ret);
> +	return ret;
> +}
> +
> +int amdxdna_pm_runtime_resume(struct device *dev)
> +{
> +	struct amdxdna_dev *xdna = to_xdna_dev(dev_get_drvdata(dev));
> +	int ret = -EOPNOTSUPP;
> +
> +	guard(mutex)(&xdna->dev_lock);
> +	if (xdna->dev_info->ops->runtime_resume)
> +		ret = xdna->dev_info->ops->runtime_resume(xdna);
> +
> +	XDNA_DBG(xdna, "Runtime resume done ret %d", ret);
> +	return ret;
> +}
> +
>   int amdxdna_pm_resume_get(struct amdxdna_dev *xdna)
>   {
>   	struct device *dev = xdna->ddev.dev;
>   	int ret;
>   
> +	if (!pm_runtime_enabled(dev))
> +		return 0;
> +
>   	ret = pm_runtime_resume_and_get(dev);
>   	if (ret) {
>   		XDNA_ERR(xdna, "Resume failed: %d", ret);
> @@ -55,6 +84,10 @@ void amdxdna_pm_suspend_put(struct amdxdna_dev *xdna)
>   {
>   	struct device *dev = xdna->ddev.dev;
>   
> +	if (!pm_runtime_enabled(dev))
> +		return;
> +
> +	pm_runtime_mark_last_busy(dev);
This should be removed. mark_last_busy is called by put_autosuspend.
>   	pm_runtime_put_autosuspend(dev);
>   }
>   
> @@ -66,6 +99,7 @@ void amdxdna_pm_init(struct amdxdna_dev *xdna)
>   	pm_runtime_set_autosuspend_delay(dev, AMDXDNA_AUTOSUSPEND_DELAY);
>   	pm_runtime_use_autosuspend(dev);
>   	pm_runtime_allow(dev);
> +	pm_runtime_mark_last_busy(dev);

This should be removed.

Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>

>   	pm_runtime_put_autosuspend(dev);
>   }
>   
> diff --git a/drivers/accel/amdxdna/amdxdna_pm.h b/drivers/accel/amdxdna/amdxdna_pm.h
> index 3d26b973e0e3..02beef6448f1 100644
> --- a/drivers/accel/amdxdna/amdxdna_pm.h
> +++ b/drivers/accel/amdxdna/amdxdna_pm.h
> @@ -10,6 +10,8 @@
>   
>   int amdxdna_pm_suspend(struct device *dev);
>   int amdxdna_pm_resume(struct device  *dev);
> +int amdxdna_pm_runtime_suspend(struct device *dev);
> +int amdxdna_pm_runtime_resume(struct device *dev);
>   int amdxdna_pm_resume_get(struct amdxdna_dev *xdna);
>   void amdxdna_pm_suspend_put(struct amdxdna_dev *xdna);
>   void amdxdna_pm_init(struct amdxdna_dev *xdna);
