Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C8DCA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 20:56:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5CBE10E66D;
	Mon, 12 Oct 2026 20:56:16 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012023.outbound.protection.outlook.com
 [40.93.195.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3BE310E66D
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 20:56:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RTdGJUXt2/gu2QdTi6OIG+juB4izThPO297cpPCiYAz7VYdBbyRCPawxS92LmZpb7vhNPXso2rpa6qf0hohSD+hTXW8GL3YDRGPdkXtlE62+GyeqFo1cARlNigaV/bn0kOUfIgGlvDvudE6ozh4qvB3q7Dh+QY1mG6Dkpm7Kt2WtMDWl2xuP3al6S0+9zZLfiAgbW+cVaAeXc63lpa3NT6IgWAjmttsqStaN4SUDjsn8AyFy82k7LS9GzR123KobMJqrpaj8PFrEVKuzvCgowafF7/iF7K+EbuKP+WVui5ZOy6hvK6mrXNutODdetGPSHxJHA9qbW+kEgP6v4f9RCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tURL7ySnrJuA4INdVd1fQZOpE/dV/duzl1seVBUrmEo=;
 b=IvRpu3xDcEOZtIgPWmnNmYRsfAm+l0W9NKAH2LmKFFAUn6ErpxXe2R1L9Nir4FbFUYr1/85QWdT3kQOjpbrs7V41JKVdd7N4MVQZEv7OQfTJgfCP28vWiy0skdEisanvsiCwx/mHu6rcfWKek5ZmlbiyibwShwPqz25yhLhsqCo2cDZslanxOQf/VPH9+W6dYXCGn56KazspAmns9RAZF03Oj3a+dvs3izi8hr1ALTJNqB5dvKDWS/c4LMseytVaQmMt/7F4lWcG8lIcwdjiqibRYHZYTGc4+YKsXLkvXyUdrijr9gLxr5pTUbl7hal0GK3BXktxDDRTeGcj2xPWCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tURL7ySnrJuA4INdVd1fQZOpE/dV/duzl1seVBUrmEo=;
 b=lyirX5C2GwhmXywPUy2/dTBfnh1R1IRLGRZcJI73MybEiJQNUCZEMwGKVHg71k97u4RgZMvH4MPhbvDBl6Igg17rwK119lQf2lNURsCH1uuU1OX01QrT6Q5Xveltl7fdI1swMOTO4NpSzZ/faJjBXrnQ26NA/HFMcA6xZZZc8iI=
Received: from SJ0PR03CA0140.namprd03.prod.outlook.com (2603:10b6:a03:33c::25)
 by SA1PR12MB5613.namprd12.prod.outlook.com (2603:10b6:806:22b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 20:56:06 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::12) by SJ0PR03CA0140.outlook.office365.com
 (2603:10b6:a03:33c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Mon, 12
 Oct 2026 20:56:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 12 Oct 2026 20:56:05 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 12 Oct
 2026 15:55:58 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 12 Oct 2026 15:55:57 -0500
Message-ID: <d16aa986-2f98-97c4-fad9-5fca23f4bc95@amd.com>
Date: Mon, 12 Oct 2026 13:55:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V4 06/19] accel/amdxdna: Add AIE version query to
 aie4_get_info
Content-Language: en-US
To: David Zhang <yidong.zhang@amd.com>, <quic_jhugo@quicinc.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <sonal.santan@amd.com>, <mario.limonciello@amd.com>, Hayden Laccabue
 <hayden.laccabue@amd.com>
References: <yidong.zhang@amd.com>
 <20261009225343.3079074-1-yidong.zhang@amd.com>
 <20261009225343.3079074-7-yidong.zhang@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20261009225343.3079074-7-yidong.zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|SA1PR12MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f6fdffa-5a64-4f4e-ff0d-08df28a33bb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|56012099006|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: sZuis0YerRiQ7SUUD9WmrmqibkiG2CGD8R01tIcCydQ+LJ6zeaQ+ThFfDjyTdoihj7pnfiywgs4101WJ/AFPHTdgysabkYNHLIiI26fJlk9wVd3O+KJ7EApigMa0nGJZUeCK9t50XcHxGyFElJyHskUEkyLP1X/kt1VQzLoJcCIjJDJywLMnDXdjddJRfVF7oo/Qh0jFUaue7gxcCssS6qc+ZPDxPTCnPSzyQXzW6ve0apNHhLt062yCaTOiSCivmI/YvoyBoMPPUy7eD/AUeCFXf1Gyoo1aICUmKCyj1AoXDJkPK+2/VdDiCb3Qr136lkbDiauqGOPRB1ZzkfQ5yvitESs5ffnmheEuJEeOAwmmAH/a/ho3yqLcc+WTB9O0OS844g/6k14UMgOK7BHEaiqlwQbe7c0vPSJMsjmN+hbD2vFs1uMdB25wbP/FruJnvVXm5FzKZf0ci0YsL/WtemEHb1M18bwRQW4nXx6fMPiseMTe+OoRizGUc8n/qF7j5dYYFd+g8pdbg9pazFR+1P0Qmg9TPcwBLnsSmX2FUoGF6K3+qFiqhut79Hl2+VPNnOVtdQf4A10tq0C75HIgut5ftHubCPc+s+zwmrk4Qmr49Iz0BN9CM/cXm3bsKGNwApSSwo68p+wYEzoELSqkBBkYrklc3jxwsjY8Wihc5LucAODU/JqfrxKfNik3KLmZ+Q1aUZ75eXYXmi0PgcY5vQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: m+IinEec/zNOJalo7lw7kYlZhKF5z16FyeCSikbdFfqKUr6ge+mOHg12L8nlw9E4qPqLyEIUecZbnxq9f2Vg7wUtTxvXGZx0kAe9ZzhYXwMqjFUGjiLkXHrzR/NlD+mspcfYy2zaykOBV23Xm8/pp5YfzPdyOzOSHhTRGXwDujGAUlzJG1AHzTaK1IHCZF8ppgv7YLy/T97UkqIKLfXHZniJMqo1v9qVuLmcaK+/sf6U+hZAflYG4+w/yJi55E9Ird5D+2cYyov+QpWoX4oPPGd1pmluLrYUmHOAkBWycNPhvKzKTsWRbOt47iSZObzofPTUxGZgeTm9uiDgLlZNNR3u0q1ckrQ8iHfkYijB2cMPDYMwQ3r9oRE9qWyepDGTFKSIzDXn+l0ZekKS5fl7cZt2TYm8uSgVMjR6NrNC2qUxG0NiPUD91BZCcNnh4GzJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 20:56:05.5164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6fdffa-5a64-4f4e-ff0d-08df28a33bb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5613
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
> Add AIE version query via DRM_AMDXDNA_GET_INFO. The NPU firmware
> version query already existed internally; it is now also exposed
> through this ioctl alongside the new AIE version query.
>
> These versions are mandatory once released, the firmware management
> interfaces must support those queries in their stable version.
> Propagating any failure to abort device initialization is intentional.
>
> Co-developed-by: Hayden Laccabue <hayden.laccabue@amd.com>
> Signed-off-by: Hayden Laccabue <hayden.laccabue@amd.com>
> Signed-off-by: David Zhang <yidong.zhang@amd.com>
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>   drivers/accel/amdxdna/aie4_message.c  | 20 ++++++++++++++++++++
>   drivers/accel/amdxdna/aie4_msg_priv.h | 11 +++++++++++
>   drivers/accel/amdxdna/aie4_pci.c      | 10 ++++++++++
>   drivers/accel/amdxdna/aie4_pci.h      |  2 ++
>   4 files changed, 43 insertions(+)
>
> diff --git a/drivers/accel/amdxdna/aie4_message.c b/drivers/accel/amdxdna/aie4_message.c
> index f67aa8ba943c..c83f81a0e65b 100644
> --- a/drivers/accel/amdxdna/aie4_message.c
> +++ b/drivers/accel/amdxdna/aie4_message.c
> @@ -75,6 +75,26 @@ int aie4_query_aie_metadata(struct amdxdna_dev_hdl *ndev,
>   	return 0;
>   }
>   
> +int aie4_query_aie_version(struct amdxdna_dev_hdl *ndev,
> +			   struct amdxdna_drm_query_aie_version *version)
> +{
> +	DECLARE_AIE_MSG(aie4_msg_aie4_version_info, AIE4_MSG_OP_AIE_VERSION_INFO);
> +	struct amdxdna_dev *xdna = ndev->aie.xdna;
> +	int ret;
> +
> +	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
> +	if (ret)
> +		return ret;
> +
> +	XDNA_DBG(xdna, "Query AIE version - major: %u minor: %u",
> +		 resp.major, resp.minor);
> +
> +	version->major = resp.major;
> +	version->minor = resp.minor;
> +
> +	return 0;
> +}
> +
>   int aie4_query_npu_firmware_version(struct amdxdna_dev_hdl *ndev,
>   				    struct amdxdna_drm_query_firmware_version *fw_version)
>   {
> diff --git a/drivers/accel/amdxdna/aie4_msg_priv.h b/drivers/accel/amdxdna/aie4_msg_priv.h
> index b9f7c61f36e3..81842fa1d6ce 100644
> --- a/drivers/accel/amdxdna/aie4_msg_priv.h
> +++ b/drivers/accel/amdxdna/aie4_msg_priv.h
> @@ -22,6 +22,7 @@ enum aie4_msg_opcode {
>   	AIE4_MSG_OP_CREATE_HW_CONTEXT                = 0x30003,
>   	AIE4_MSG_OP_DESTROY_HW_CONTEXT               = 0x30004,
>   	AIE4_MSG_OP_AIE_TILE_INFO                    = 0x30006,
> +	AIE4_MSG_OP_AIE_VERSION_INFO                 = 0x30007,
>   
>   	AIE4_MSG_OP_ATTACH_WORK_BUFFER               = 0x40001,
>   };
> @@ -160,6 +161,16 @@ struct aie4_msg_aie4_tile_info_resp {
>   	struct aie4_tile_info info;
>   } __packed;
>   
> +struct aie4_msg_aie4_version_info_req {
> +	__u32 resvd;
> +} __packed;
> +
> +struct aie4_msg_aie4_version_info_resp {
> +	enum aie4_msg_status status;
> +	__u16 major;
> +	__u16 minor;
> +} __packed;
> +
>   struct aie4_msg_query_cert_firmware_version_req {
>   	__u32 resvd;
>   } __packed;
> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
> index 1eeb1cb73b27..1cbd1665a28f 100644
> --- a/drivers/accel/amdxdna/aie4_pci.c
> +++ b/drivers/accel/amdxdna/aie4_pci.c
> @@ -289,6 +289,10 @@ static int aie4_query(struct amdxdna_dev_hdl *ndev)
>   	if (ret)
>   		return ret;
>   
> +	ret = aie4_query_aie_version(ndev, &ndev->aie.version);
> +	if (ret)
> +		return ret;
> +
>   	ret = aie4_query_aie_metadata(ndev, &ndev->aie.metadata);
>   	if (ret)
>   		return ret;
> @@ -595,6 +599,12 @@ static int aie4_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_i
>   	case DRM_AMDXDNA_QUERY_AIE_METADATA:
>   		ret = amdxdna_get_metadata(&ndev->aie, client, args);
>   		break;
> +	case DRM_AMDXDNA_QUERY_AIE_VERSION:
> +		ret = amdxdna_get_aie_version(client, args, &ndev->aie.version);
> +		break;
> +	case DRM_AMDXDNA_QUERY_FIRMWARE_VERSION:
> +		ret = amdxdna_get_firmware_version(client, args, &xdna->fw_ver);
> +		break;
>   	default:
>   		XDNA_ERR(xdna, "Not supported request parameter %u", args->param);
>   		ret = -EOPNOTSUPP;
> diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
> index 940e67347d74..5ae5e8427a3b 100644
> --- a/drivers/accel/amdxdna/aie4_pci.h
> +++ b/drivers/accel/amdxdna/aie4_pci.h
> @@ -69,6 +69,8 @@ enum aie4_fw_feature {
>   /* aie4_message.c */
>   int aie4_query_aie_metadata(struct amdxdna_dev_hdl *ndev,
>   			    struct amdxdna_drm_query_aie_metadata *metadata);
> +int aie4_query_aie_version(struct amdxdna_dev_hdl *ndev,
> +			   struct amdxdna_drm_query_aie_version *version);
>   int aie4_suspend_fw(struct amdxdna_dev_hdl *ndev);
>   int aie4_attach_work_buffer(struct amdxdna_dev_hdl *ndev);
>   int aie4_query_npu_firmware_version(struct amdxdna_dev_hdl *ndev,
