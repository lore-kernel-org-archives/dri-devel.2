Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B85CA9ED2
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 21:30:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3B2810F3A4;
	Mon, 12 Oct 2026 21:30:07 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011057.outbound.protection.outlook.com [52.101.62.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C86010E6A0
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 21:30:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZZ0CQPViKa9jOrY8ZEp6jUbWD3sBVCco8bST8aZZjYhS75osLvLKxvZn6DpBUE0ePCDzU4fb240iHBuEa3BLeQ2UXPcjl6lN7M2tH6+aq5kHUV4tG1DN9vHCCRU/QK+AT29Vof9WrGahn3Km6kbkVGnbxSTxOf857RSliRsd8dqWIASIFMu/HeHi1Jpw/B4YVRqQwq0gpL7FGAEtlZqIA9pRF1tY4gG5Tw12zicPhq2sCMmzJ+Gw+jQtx5LJ+olZidzchMIUvjIK4Nt9waZV95OnhVU8gKYeV+pKtDYAVEZWkCuQO44puds8aEyCOkEmRAnMS+H1QlOyS0aMJt/ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7RQzCQ1aLvBlwfDwLaP7GFrwAuF8hqIeat42jSbJM8=;
 b=Zmjc2kGzaMIKVpW5Ova1T/cM6jFF+iHpnLmImq1qo4LDiZbKZNLpm1OQtlzjuBESUKyhVsuTZMrari8AJyF8F9oQOyVFsrM9AWyExnNLm30eaQIgC1TRhOlaHP9KvkeyRK0SscIXcPLQCbm72jyXl7alNcUalRu1xC+giMH2xq9VThSuGQ7KjIKtZlc5MNOIhyVa98DFE2j3COvT1/inxGZq3lF4kVlo3NygGlph/uWc5p4qZU/043jXO2BeeCd5afMb97+3bCECx8x1LXg64snV2GG1Z4SY/91M0WPLl8QNsay3K3CQrh11fSt3SHjMAeJAWBB3sXWsGm/UzUYN3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7RQzCQ1aLvBlwfDwLaP7GFrwAuF8hqIeat42jSbJM8=;
 b=azMwLm1Hl5mpj4YFRaYow4KCMq9rg0Sx8jJr5VJPcLNjX12t0MKlv1bSirF0txFe71QD7rUWbRq49C1kvo2YOztsUQX5QuCS/TIT3slKlnasY/fO8YWmyjNudtuex3l4LvEXt614yXt9sbNEbMN3Q11FNGGYk9JfxezUy+m0SyQ=
Received: from BY1P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::8)
 by MW4PR12MB7029.namprd12.prod.outlook.com (2603:10b6:303:1eb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 21:29:21 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::6c) by BY1P220CA0018.outlook.office365.com
 (2603:10b6:a03:5c3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 12
 Oct 2026 21:29:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 12 Oct 2026 21:29:20 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 12 Oct
 2026 16:29:14 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 12 Oct 2026 16:29:13 -0500
Message-ID: <2de6caa2-bcdc-107d-53d7-80f270512812@amd.com>
Date: Mon, 12 Oct 2026 14:29:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V4 07/19] accel/amdxdna: Add get and set power_mode for
 AIE4
Content-Language: en-US
To: David Zhang <yidong.zhang@amd.com>, <quic_jhugo@quicinc.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <sonal.santan@amd.com>, <mario.limonciello@amd.com>, Soham Donwalkar
 <soham.donwalkar@amd.com>, Nishad Saraf <nishad.saraf@amd.com>
References: <yidong.zhang@amd.com>
 <20261009225343.3079074-1-yidong.zhang@amd.com>
 <20261009225343.3079074-8-yidong.zhang@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20261009225343.3079074-8-yidong.zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|MW4PR12MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: 27ebd31d-1517-449c-2e5b-08df28a7e0eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|56012099006|11063799006|4143699003|261009223027099003|10067099003|22082099003|18092099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: zt/bsNG6EFLXdpz9L/ADa/U9uFuKnz6lX7cU3gDeBHuRR7PtJOcPfxxiCUb1GjtSjR8FK5f01OcDfCLXBK9C6Wkw6vhXE5/X7m8SwxOAPEK1FREL5qO0S0aqzKaWeXVR/tZQRlvUg/qYE/937+MFHdjkoEWHosyaxiFbqbUTKzPSoiSmJq9NVTAugyoe3FnsoRjm3Uum9nrADb5LdaUvbATqzcgEqQBsY4o1CHW0Ew+Pt+Xp62A3MIYXEtUbu4WxWahUpd2cB4WGBAQ+ddQuDQxI0ec71g1Q6c1oaEIkbupqovloMHmu36yMUTTVVCXdm5hbDjzfyMSwTnQnktwsTtqp5lqkU6xw5+ypeO65L82K7hFOaEo9CL3PDf5mST9ZTxjbHv1VwuC3KWymsgAZnxz9KsQfeDU0aZlcgWWUdWl75ymQ6zV6+cGw0gmFGhbGi7JwSXH9AsPHZT6y804bbJScxnrQJqKrriQv1soFtkBb+FDuXlnMyQTB59qcNlhZAjmDgd0XgtEosWoRDEj27hd5wZNa5U44QAelSNmHuuphzavdgkF1houmwZQ5QWCAwPaWOfTdJ2165aJu9BBnoX4GT7cCqd2D1TeqNWzODOYVg7bRCkdRVzXPTrFCgrgepWnnarS8N6KS+4TPPiCAIB/SWVj1CxsRCPT80A4iMsrow2TC/DCb3lwgID9Yx74Nl0v0V+iSG8Bfd2RQj6uorQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18092099006)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4MHMf8ztjEtJ+o+TJIiaI2cRuAR2ypAyr6swzNym83VQCDqMqqWbfsYcbKAANUHI/IB111S/euRTzZcgcb28a4tMQJ8sOWk7+wjJ751u1/2pBuj21P/DZWlX+PkkgFJNTIRxJq0Iw/e+EXfoIA9XbDgNchB7EEZxfYvslWyaZ0LxpSx53Lk/THZISm6uveR/K07KilxNiQrhDWQzVfuf1xIjVHf+C4d1fA9nVcRypzcPYhcPhouuz99LYyVngq86ppdpGziNUed/pdooZEztVlmG6YZBuabvDZhcMetbzwfd8LDxjsR2WOgqCoGJJUKvn2sLAOmfmBGJTFhwp6KnPGzoqHeocBk8kNAQSzfg0gb5Nv25wmtcicZ5vUWm3OrkBXwmdpMYRFJLTjpHrcZxxASZ+kUD/T74SRhqHZep5wy4QjFcFihnkDeQn4qoE/qO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 21:29:20.7270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ebd31d-1517-449c-2e5b-08df28a7e0eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7029
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
> Add power mode support for AIE4 devices via DRM_AMDXDNA_GET_INFO and
> DRM_AMDXDNA_SET_STATE:
> - Add AIE4_MSG_OP_POWER_OVERRIDE mailbox support
> - Add DRM_AMDXDNA_GET_POWER_MODE support
> - Implement aie4_set_power_mode() and wire .set_aie_state
>
> Firmware boots in POWER_MODE_DEFAULT after a reload, so re-send the
> cached user power mode override whenever the hardware starts via
> aie4_restore_power_mode(). On a fresh probe, pw_mode is
> POWER_MODE_DEFAULT.
>
> Co-developed-by: Soham Donwalkar <soham.donwalkar@amd.com>
> Signed-off-by: Soham Donwalkar <soham.donwalkar@amd.com>
> Co-developed-by: Nishad Saraf <nishad.saraf@amd.com>
> Signed-off-by: Nishad Saraf <nishad.saraf@amd.com>
> Signed-off-by: David Zhang <yidong.zhang@amd.com>
> ---
>   drivers/accel/amdxdna/aie4_message.c  |  17 ++++
>   drivers/accel/amdxdna/aie4_msg_priv.h |   9 ++
>   drivers/accel/amdxdna/aie4_pci.c      | 116 ++++++++++++++++++++++++++
>   drivers/accel/amdxdna/aie4_pci.h      |   6 ++
>   4 files changed, 148 insertions(+)
>
> diff --git a/drivers/accel/amdxdna/aie4_message.c b/drivers/accel/amdxdna/aie4_message.c
> index c83f81a0e65b..8d1cad50cbab 100644
> --- a/drivers/accel/amdxdna/aie4_message.c
> +++ b/drivers/accel/amdxdna/aie4_message.c
> @@ -158,3 +158,20 @@ int aie4_attach_work_buffer(struct amdxdna_dev_hdl *ndev)
>   
>   	return ret;
>   }
> +
> +int aie4_msg_set_power_mode(struct amdxdna_dev_hdl *ndev, u8 power_mode)
> +{
> +	DECLARE_AIE_MSG(aie4_msg_power_override, AIE4_MSG_OP_POWER_OVERRIDE);
> +	int ret;
> +
> +	req.power_mode = power_mode;
> +
> +	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
> +	if (ret)
> +		XDNA_WARN(ndev->aie.xdna,

Should be XDNA_ERR().

Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>

> +			  "Failed to set power mode %u, ret %d", (u32)power_mode, ret);
> +	else
> +		XDNA_DBG(ndev->aie.xdna, "Power mode set to %u", (u32)power_mode);
> +
> +	return ret;
> +}
> diff --git a/drivers/accel/amdxdna/aie4_msg_priv.h b/drivers/accel/amdxdna/aie4_msg_priv.h
> index 81842fa1d6ce..4c06792df1bd 100644
> --- a/drivers/accel/amdxdna/aie4_msg_priv.h
> +++ b/drivers/accel/amdxdna/aie4_msg_priv.h
> @@ -23,6 +23,7 @@ enum aie4_msg_opcode {
>   	AIE4_MSG_OP_DESTROY_HW_CONTEXT               = 0x30004,
>   	AIE4_MSG_OP_AIE_TILE_INFO                    = 0x30006,
>   	AIE4_MSG_OP_AIE_VERSION_INFO                 = 0x30007,
> +	AIE4_MSG_OP_POWER_OVERRIDE                   = 0x3000B,
>   
>   	AIE4_MSG_OP_ATTACH_WORK_BUFFER               = 0x40001,
>   };
> @@ -187,6 +188,14 @@ struct aie4_msg_query_cert_firmware_version_resp {
>   	__u16 host_queue_minor;
>   } __packed;
>   
> +struct aie4_msg_power_override_req {
> +	__u32 power_mode;
> +} __packed;
> +
> +struct aie4_msg_power_override_resp {
> +	enum aie4_msg_status status;
> +} __packed;
> +
>   #define AIE4_WORK_BUFFER_MIN_SIZE      SZ_4M
>   
>   struct aie4_msg_attach_work_buffer_req {
> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
> index 1cbd1665a28f..6eacdc026ec7 100644
> --- a/drivers/accel/amdxdna/aie4_pci.c
> +++ b/drivers/accel/amdxdna/aie4_pci.c
> @@ -4,6 +4,7 @@
>    */
>   
>   #include <drm/amdxdna_accel.h>
> +#include <drm/drm_drv.h>
>   #include <drm/drm_managed.h>
>   #include <drm/drm_print.h>
>   #include <linux/firmware.h>
> @@ -16,6 +17,7 @@
>   #include "amdxdna_mailbox.h"
>   #include "amdxdna_mailbox_helper.h"
>   #include "amdxdna_pci_drv.h"
> +#include "amdxdna_pm.h"
>   
>   #define NO_IOHUB		0
>   #define PSP_NOTIFY_INTR		0xD007BE11
> @@ -300,6 +302,15 @@ static int aie4_query(struct amdxdna_dev_hdl *ndev)
>   	return 0;
>   }
>   
> +/* Restore cached power mode override across hardware start. */
> +int aie4_restore_power_mode(struct amdxdna_dev_hdl *ndev)
> +{
> +	if (ndev->pw_mode == POWER_MODE_DEFAULT)
> +		return 0;
> +
> +	return aie4_msg_set_power_mode(ndev, ndev->pw_mode);
> +}
> +
>   static int aie4_pf_hw_start(struct amdxdna_dev_hdl *ndev)
>   {
>   	int ret;
> @@ -316,6 +327,10 @@ static int aie4_pf_hw_start(struct amdxdna_dev_hdl *ndev)
>   	if (ret)
>   		goto mbox_fini;
>   
> +	ret = aie4_restore_power_mode(ndev);
> +	if (ret)
> +		goto mbox_fini;
> +
>   	return 0;
>   
>   mbox_fini:
> @@ -353,8 +368,14 @@ static int aie4_vf_hw_start(struct amdxdna_dev_hdl *ndev)
>   	if (ret)
>   		goto mailbox_fini;
>   
> +	ret = aie4_restore_power_mode(ndev);
> +	if (ret)
> +		goto partition_fini;
> +
>   	return 0;
>   
> +partition_fini:
> +	aie4_partition_fini(ndev);
>   mailbox_fini:
>   	aie4_mailbox_fini(ndev);
>   	return ret;
> @@ -394,8 +415,14 @@ static int aie4_classic_hw_start(struct amdxdna_dev_hdl *ndev)
>   	if (ret)
>   		goto mailbox_fini;
>   
> +	ret = aie4_restore_power_mode(ndev);
> +	if (ret)
> +		goto partition_fini;
> +
>   	return 0;
>   
> +partition_fini:
> +	aie4_partition_fini(ndev);
>   mailbox_fini:
>   	aie4_mailbox_fini(ndev);
>   stop_fw:
> @@ -535,6 +562,7 @@ static int aie4m_pcidev_init(struct amdxdna_dev *xdna)
>   
>   	ndev->priv = xdna->dev_info->dev_priv;
>   	ndev->aie.xdna = xdna;
> +	ndev->pw_mode = POWER_MODE_DEFAULT;
>   	xdna->dev_handle = ndev;
>   
>   	xa_init_flags(&ndev->cert_comp_xa, XA_FLAGS_ALLOC);
> @@ -589,6 +617,24 @@ static int aie4m_pcidev_init(struct amdxdna_dev *xdna)
>   	return 0;
>   }
>   
> +static int aie4_get_power_mode(struct amdxdna_client *client,
> +			       struct amdxdna_drm_get_info *args)
> +{
> +	struct amdxdna_drm_get_power_mode mode = {};
> +	struct amdxdna_dev *xdna = client->xdna;
> +	struct amdxdna_dev_hdl *ndev;
> +	u32 buf_sz;
> +
> +	ndev = xdna->dev_handle;
> +	mode.power_mode = ndev->pw_mode;
> +
> +	buf_sz = min_t(u32, args->buffer_size, sizeof(mode));
> +	if (copy_to_user(u64_to_user_ptr(args->buffer), &mode, buf_sz))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
>   static int aie4_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_info *args)
>   {
>   	struct amdxdna_dev *xdna = client->xdna;
> @@ -605,6 +651,9 @@ static int aie4_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_i
>   	case DRM_AMDXDNA_QUERY_FIRMWARE_VERSION:
>   		ret = amdxdna_get_firmware_version(client, args, &xdna->fw_ver);
>   		break;
> +	case DRM_AMDXDNA_GET_POWER_MODE:
> +		ret = aie4_get_power_mode(client, args);
> +		break;
>   	default:
>   		XDNA_ERR(xdna, "Not supported request parameter %u", args->param);
>   		ret = -EOPNOTSUPP;
> @@ -615,6 +664,71 @@ static int aie4_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_i
>   	return ret;
>   }
>   
> +static int aie4_set_power_mode(struct amdxdna_client *client,
> +			       struct amdxdna_drm_set_state *args)
> +{
> +	struct amdxdna_drm_set_power_mode power_state = { 0 };
> +	struct amdxdna_dev *xdna = client->xdna;
> +	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
> +	u8 power_mode;
> +	int ret;
> +
> +	if (args->buffer_size < sizeof(power_state))
> +		return -EINVAL;
> +
> +	if (copy_from_user(&power_state, u64_to_user_ptr(args->buffer),
> +			   sizeof(power_state))) {
> +		XDNA_ERR(xdna, "Failed to copy power mode request into kernel");
> +		return -EFAULT;
> +	}
> +
> +	if (XDNA_MBZ_DBG(xdna, power_state.pad, sizeof(power_state.pad)))
> +		return -EINVAL;
> +
> +	power_mode = power_state.power_mode;
> +	if (power_mode > POWER_MODE_TURBO) {
> +		XDNA_ERR(xdna, "Invalid power mode %d", power_mode);
> +		return -EINVAL;
> +	}
> +
> +	ret = aie4_msg_set_power_mode(xdna->dev_handle, power_mode);
> +	if (ret)
> +		return ret;
> +
> +	ndev->pw_mode = power_mode;
> +	return 0;
> +}
> +
> +static int aie4_set_state(struct amdxdna_client *client,
> +			  struct amdxdna_drm_set_state *args)
> +{
> +	struct amdxdna_dev *xdna = client->xdna;
> +	int ret, idx;
> +
> +	if (!drm_dev_enter(&xdna->ddev, &idx))
> +		return -ENODEV;
> +
> +	ret = amdxdna_pm_resume_get_locked(xdna);
> +	if (ret)
> +		goto dev_exit;
> +
> +	switch (args->param) {
> +	case DRM_AMDXDNA_SET_POWER_MODE:
> +		ret = aie4_set_power_mode(client, args);
> +		break;
> +	default:
> +		XDNA_ERR(xdna, "Not supported request parameter %u", args->param);
> +		ret = -EOPNOTSUPP;
> +		break;
> +	}
> +
> +	amdxdna_pm_suspend_put(xdna);
> +
> +dev_exit:
> +	drm_dev_exit(idx);
> +	return ret;
> +}
> +
>   static int aie4_alloc_work_buffer(struct amdxdna_dev_hdl *ndev)
>   {
>   	struct amdxdna_dev *xdna = ndev->aie.xdna;
> @@ -737,6 +851,7 @@ const struct amdxdna_dev_ops aie4_vf_ops = {
>   	.hwctx_fini		= aie4_hwctx_fini,
>   	.cmd_wait		= aie4_cmd_wait,
>   	.get_aie_info		= aie4_get_info,
> +	.set_aie_state		= aie4_set_state,
>   };
>   
>   const struct amdxdna_dev_ops aie4_classic_ops = {
> @@ -746,4 +861,5 @@ const struct amdxdna_dev_ops aie4_classic_ops = {
>   	.hwctx_fini		= aie4_hwctx_fini,
>   	.cmd_wait		= aie4_cmd_wait,
>   	.get_aie_info		= aie4_get_info,
> +	.set_aie_state		= aie4_set_state,
>   };
> diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
> index 5ae5e8427a3b..fd2c50dc8080 100644
> --- a/drivers/accel/amdxdna/aie4_pci.h
> +++ b/drivers/accel/amdxdna/aie4_pci.h
> @@ -58,6 +58,8 @@ struct amdxdna_dev_hdl {
>   	dma_addr_t			work_buf_addr;
>   	u32				work_buf_size;
>   
> +	u8				pw_mode;
> +
>   	struct amdxdna_drm_query_firmware_version cert_version;
>   };
>   
> @@ -77,6 +79,7 @@ int aie4_query_npu_firmware_version(struct amdxdna_dev_hdl *ndev,
>   				    struct amdxdna_drm_query_firmware_version *fw_version);
>   int aie4_query_cert_firmware_version(struct amdxdna_dev_hdl *ndev,
>   				     struct amdxdna_drm_query_firmware_version *cert_version);
> +int aie4_msg_set_power_mode(struct amdxdna_dev_hdl *ndev, u8 power_mode);
>   u32 aie4_msg_pasid(struct amdxdna_client *client);
>   
>   /* aie4_ctx.c */
> @@ -84,6 +87,9 @@ int aie4_hwctx_init(struct amdxdna_hwctx *hwctx);
>   void aie4_hwctx_fini(struct amdxdna_hwctx *hwctx);
>   int aie4_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout);
>   
> +/* aie4_pci.c */
> +int aie4_restore_power_mode(struct amdxdna_dev_hdl *ndev);
> +
>   /* aie4_sriov.c */
>   #if IS_ENABLED(CONFIG_PCI_IOV)
>   int aie4_sriov_configure(struct amdxdna_dev *xdna, int num_vfs);
