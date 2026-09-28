Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28033CA5FA3
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 18:40:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B79710EB91;
	Mon, 28 Sep 2026 18:40:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NDocX+Zy";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012027.outbound.protection.outlook.com
 [40.93.195.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 990B110E974
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 18:40:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=msUDWPESh4/OKhq3f2/qe4xl8hjIrrZlUXPHiQP7qfh40w/i3aL6dSYMAKedZRV8RnHLF91PAPNUHsyk9KAGwfmi8HuBhqjjz2pes4Lg0rHqVjkUL2Y51LjmH2m2uyhn60+gpJhrPYPyXiBktjJqPfZm752DC/9y396pCp1uBIgXj1fjslnEEQ0NLR+34QjC/evXa2N1Hlsi/nuqWwDY+kGyIQolP7ZdF7X/X0Ro/HI5ZxVT+aIikwvIhPJyFckTqFAK+FkPYZPRqRDTs8Z32BZnbe4tUc4C7bTRyAGfrVCj/0tyEWgFFwkO5CDFZjsWz4uZHLMQalRu5slCeWXqPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5XFdMKcLyjXB9YR3XSdDsZj4WK/z+oCalloeCecPWc=;
 b=KHVeKEiAZX8bLyQGsfb2ruI/U9P8tjec5tVRjFH5GzawD6iI3iUCn8egQN2I27zDktuPB5KGJz+0KlgOQg3YHNO3esHmOlL6llV86Zu10w4hNWVRs3oyw1IxXqqk6eX5HxG+JI+GrjJKf4P6JWqLNPBZ2Cjfl6M4pmtGPGvdxRR+X8y2gAuucMPNSIXiCp9ffohIOcge/RUuLZ/QdLqDm3SUPo4t+t3K3QK9G3KHrgbWJ0mN9cbj3bs8dD8mOh031CfgCuLmxz8B6KqfohN3UTihQbeNTrRdF8FS0TlbMwika4gpaX1zk7B6D8J0og4m3E9kCk4rXgQNOgDsT8qLqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5XFdMKcLyjXB9YR3XSdDsZj4WK/z+oCalloeCecPWc=;
 b=NDocX+ZytC+Y4GYX8TNeCXkbxnoHrNA/bShyAOFX9REN4W9NXslJTblBkamo069bivSbvfZx9FYKP6eEltfjA2+s6NWov/4UgpGh44PGOCh8BSTIj+qlLBrls3yqVbnhUOWcJuQ7Jte2t00h3AaCtFRx818sTQNWeWnw9RHHmeY=
Received: from CH2PR08CA0018.namprd08.prod.outlook.com (2603:10b6:610:5a::28)
 by BL4PR12MB9483.namprd12.prod.outlook.com (2603:10b6:208:590::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 18:39:56 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::3c) by CH2PR08CA0018.outlook.office365.com
 (2603:10b6:610:5a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.23 via Frontend Transport; Mon,
 28 Sep 2026 18:39:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 18:39:56 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 13:39:54 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 28 Sep 2026 13:39:53 -0500
Message-ID: <5b554c06-9f3c-b89e-5cdf-3673156dad5d@amd.com>
Date: Mon, 28 Sep 2026 11:39:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V0 07/21] accel/amdxdna: Add get and set power_mode for
 AIE4
Content-Language: en-US
To: David Zhang <yidong.zhang@amd.com>, <quic_jhugo@quicinc.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <sonal.santan@amd.com>, <mario.limonciello@amd.com>, Hayden Laccabue
 <hayden.laccabue@amd.com>, Soham Donwalkar <soham.donwalkar@amd.com>
References: <yidong.zhang@amd.com>
 <20260926013448.3840921-1-yidong.zhang@amd.com>
 <20260926013448.3840921-8-yidong.zhang@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260926013448.3840921-8-yidong.zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|BL4PR12MB9483:EE_
X-MS-Office365-Filtering-Correlation-Id: aa482208-2976-486c-afa9-08df1d8fe484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|11063799006|10067099003|4143699003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: +xsZB6wiMkMVJwl51DtMqS6PtBf6IVLLvuUIXduHyfyW1h9bVP5Wyzk9XnMybPAExbck8KcmRs+Rri6PS8woTIgQwBX2E1QErjIniTyQscI/raRCd7s9qE6F6aEFr4/peWK08RPxBofdt+GaZQ97ugRM1zkUIL4fKnmRYnk3lCaM3vjeTODsupwl71hbFm5Ia3W13sLq3doAP4UcOmD31HET6/W48nl35+yDWQ5wCbvP4joxbyAJCsjgKtdMYCFglOPKBXGIvP7MNYyt/1NHjBqCata0jZcr3ZB7P89vTAzAJvY60gpRzxLr++OIxSo+2u+6yMHIHQCGb2D4/KWVZ6MvwfLpBtT4uZ2sDAhb9eZ3gNCYdy0sCU+RbwffVndzS3loaj63crsm5Hqepzl1WQCIuxbfxZtZfHfCRSWhsZMYR9TY7AlxFsbN0aiKCjMmW693V5uxNQDCMD+YaoBrmMvphkD0GKDOr4MAZegekyadUxKbmq1UUAWAbjgpGFGnBVDi8frtSH6GmYbL6b5dXyiaTi8Ebg683ZxtLHhplzr7ORyuaB1Wo5bU7myEAWV9YCajlKH7D0kAEKXHRB1zgjhn1gCAXt5NLfmb8AgY+TNM6tAjw8cRONsWqQozWHs4T2TJ4nTG6EleU+fDpvg4WN+sezQ4Y/d4q+ZgHRtRCNDztlRtCJTsjNObYdd5S5ZASXznu9ghdKGRdMF8eGO1Uw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(11063799006)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uP8GJ2xnOn1VqSsYCyUqExKybWIJe2nv6dt8dWj0t5NB9ofQ2cT5gV20oB2RcHcMyVBx+rRY+AbMvoysc4/UfLOQmUsTA/1rMOwOZfmy3/xiVR0Q7VejeOtxlaUuNbvfvjyo8z0rf4Jcmd+DRlynHtBb3T+0eH2fMf5ZvrQuEB9mKxtwzbfcp2ItPvSGv/OfwE+tc/5H0Jtu9p7/8f65K9Kf+2IQ92X78DcvVpyybv/YZ/tjYyXhhekZIS0UuKxP29/JPIFuyBtJsBtoFYH9fEv8XUhZhWHdEOq3uDoxs9r5qE9SByIJHG3+FnEXe73WMsXhoUk+wVh30rg4GTYHMCm/f0AZzaIjIc5owdypuW6LokTfvN0HLAsn17eQ7NBH6CDYlLCw19X+3vT8LYntwcb3+CcWpZCFeF0+9TFq3m9M723NfH70FQ3yyYJQEfio
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 18:39:56.0590 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa482208-2976-486c-afa9-08df1d8fe484
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9483
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


On 9/25/26 18:34, David Zhang wrote:
> Add power mode support for AIE4 devices via DRM_AMDXDNA_GET_INFO and
> DRM_AMDXDNA_SET_STATE:
> - Add AIE4_MSG_OP_POWER_OVERRIDE mailbox message definitions and
>    aie4_msg_set_power_mode() helper to send power mode commands to firmware.
> - Support DRM_AMDXDNA_GET_POWER_MODE in aie4_get_info() to return the
>    cached device power mode.
> - Implement aie4_set_power_mode() and aie4_set_state() to validate user
>    input, send the override command to firmware, and cache the mode in
>    ndev->pw_mode.
> - Wire .set_aie_state into aie4_vf_ops and aie4_classic_ops.
>
> Co-developed-by: Hayden Laccabue <hayden.laccabue@amd.com>
> Signed-off-by: Hayden Laccabue <hayden.laccabue@amd.com>
> Co-developed-by: Soham Donwalkar <soham.donwalkar@amd.com>
> Signed-off-by: Soham Donwalkar <soham.donwalkar@amd.com>
> Signed-off-by: David Zhang <yidong.zhang@amd.com>
> ---
>   drivers/accel/amdxdna/aie4_message.c  | 14 +++++
>   drivers/accel/amdxdna/aie4_msg_priv.h |  9 +++
>   drivers/accel/amdxdna/aie4_pci.c      | 88 +++++++++++++++++++++++++++
>   drivers/accel/amdxdna/aie4_pci.h      |  3 +
>   4 files changed, 114 insertions(+)
>
> diff --git a/drivers/accel/amdxdna/aie4_message.c b/drivers/accel/amdxdna/aie4_message.c
> index 17cc335f0656..a7025995d0e0 100644
> --- a/drivers/accel/amdxdna/aie4_message.c
> +++ b/drivers/accel/amdxdna/aie4_message.c
> @@ -156,3 +156,17 @@ int aie4_attach_work_buffer(struct amdxdna_dev_hdl *ndev)
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
> +		return ret;
> +
> +	return 0;
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
> index aea3edd51b4f..3a063d3ffa94 100644
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
> @@ -15,6 +16,7 @@
>   #include "amdxdna_mailbox.h"
>   #include "amdxdna_mailbox_helper.h"
>   #include "amdxdna_pci_drv.h"
> +#include "amdxdna_pm.h"
>   
>   #define NO_IOHUB		0
>   #define PSP_NOTIFY_INTR		0xD007BE11
> @@ -528,6 +530,7 @@ static int aie4m_pcidev_init(struct amdxdna_dev *xdna)
>   
>   	ndev->priv = xdna->dev_info->dev_priv;
>   	ndev->aie.xdna = xdna;
> +	ndev->pw_mode = POWER_MODE_DEFAULT;
>   	xdna->dev_handle = ndev;
>   
>   	xa_init_flags(&ndev->cert_comp_xa, XA_FLAGS_ALLOC);
> @@ -582,6 +585,24 @@ static int aie4m_pcidev_init(struct amdxdna_dev *xdna)
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
> @@ -598,6 +619,9 @@ static int aie4_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_i
>   	case DRM_AMDXDNA_QUERY_FIRMWARE_VERSION:
>   		ret = amdxdna_get_firmware_version(client, args, &xdna->fw_ver);
>   		break;
> +	case DRM_AMDXDNA_GET_POWER_MODE:
> +		ret = aie4_get_power_mode(client, args);
> +		break;
>   	default:
>   		XDNA_ERR(xdna, "Not supported request parameter %u", args->param);
>   		ret = -EOPNOTSUPP;
> @@ -608,6 +632,68 @@ static int aie4_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_i
>   	return ret;
>   }
>   
> +static int aie4_set_power_mode(struct amdxdna_client *client,
> +			       struct amdxdna_drm_set_state *args)
> +{
> +	struct amdxdna_drm_set_power_mode power_state;
> +	struct amdxdna_dev *xdna = client->xdna;
> +	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
> +	u8 power_mode;
> +	int ret;
> +
> +	if (copy_from_user(&power_state, u64_to_user_ptr(args->buffer),
> +			   sizeof(power_state))) {

It is better to respect buffer_size.

buf_sz = min(u32, args->buffer_size, sizeof(power_state));

copy_from_user(...., buf_sz);


Lizhi

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
> @@ -730,6 +816,7 @@ const struct amdxdna_dev_ops aie4_vf_ops = {
>   	.hwctx_fini		= aie4_hwctx_fini,
>   	.cmd_wait		= aie4_cmd_wait,
>   	.get_aie_info		= aie4_get_info,
> +	.set_aie_state		= aie4_set_state,
>   };
>   
>   const struct amdxdna_dev_ops aie4_classic_ops = {
> @@ -739,4 +826,5 @@ const struct amdxdna_dev_ops aie4_classic_ops = {
>   	.hwctx_fini		= aie4_hwctx_fini,
>   	.cmd_wait		= aie4_cmd_wait,
>   	.get_aie_info		= aie4_get_info,
> +	.set_aie_state		= aie4_set_state,
>   };
> diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
> index 5ae5e8427a3b..98b637279257 100644
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
