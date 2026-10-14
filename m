Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B621CCC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 18:24:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B39D10E1C6;
	Wed, 14 Oct 2026 18:24:53 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010046.outbound.protection.outlook.com [52.101.201.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3A6B10E1C6
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 18:24:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wdj9SHjT3zYY8/7ecSyQhw0UfbFlGPgZS+0KCQEn4wwjhNdUUosq13ls7lAAXXT5D2UdB5+xn0e5VZ5JEiAoq927wQOQdtaoYgm15ovWsnPMSmM4LEBaHeAjzgh5sWfFfXv8cpaAjQD2hQH1Bnc3qexnd2/qs/26gM5Y/8nQYRICcGw6kOpStN2rlBP+W4i8U8DLISJTmOA2HdNJpc7kwg8PsbMD4NmManQAxgryS1CPhT0cabH9g7865HOXTrAfFRP7wZJHOqwHDjxi+ZdnbOJOq0ITeP7Ag3x9CNrTQ13/2u6Tadrax9hmocwaOHR4j0KhpF5ugX3QZNsHC6IasA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vb6oRmlg6RtKi84iWEQ221OmMWXX87v53d4iAE8OcIo=;
 b=JkEh2qDT9cQzWas2IQehi5emsQW9sAD8dPnTzFkcV5ln34BQpfPWfKv+r3oYLDe+tXK40zTIjBM8Fk7KXGNQXLshY9pZiTqKQhjU9zQdv9GrMVJ2Ozc9/Um6XU9It9fZzw8CEpI5B7ASVJ3+rulZVNr/Fhe6ayeWLTlD8GufdzwmDTPyCTF6YtTPQ6TQquL+6a+kHZEIieuEh0OEZ0PxgcKDlRKAjK9Ui2bZVYKB7HfSLWbyO//Ndav2s5erKGMLfiIzw5Xv7NVx3Au850M2pT3op2bNQeF4YVMjDhunkDRwx0674hVkZh0PSZfh1/ACODwI4bEkvI39W0J9Mk+gvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vb6oRmlg6RtKi84iWEQ221OmMWXX87v53d4iAE8OcIo=;
 b=qVE1XTic6E0coauPxP6UxYXDreZaHLRpaWp5Rh1mQPYojmjFQ7L6OZ14Ub+rRx+EYvvo/TPrymcke+jktKUTH3J/zINwy6T3GfjU8Z75/bDAxqofXpS36HgNR3eDwj/j84//wsSBvFhXXUqasYIL+//jQdI2mQhS8EkBM1y4ubI=
Received: from SJ0PR05CA0022.namprd05.prod.outlook.com (2603:10b6:a03:33b::27)
 by SJ2PR12MB8846.namprd12.prod.outlook.com (2603:10b6:a03:549::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 18:24:40 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a03:33b:cafe::aa) by SJ0PR05CA0022.outlook.office365.com
 (2603:10b6:a03:33b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 14
 Oct 2026 18:24:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 18:24:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 13:24:33 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 13:24:32 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 14 Oct 2026 13:24:32 -0500
Message-ID: <058e556d-0dfb-1654-9905-c59279b8c3cb@amd.com>
Date: Wed, 14 Oct 2026 11:24:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V4 17/19] accel/amdxdna: Enable AIE4 firmware logging to
 DRAM
Content-Language: en-US
To: David Zhang <yidong.zhang@amd.com>, <quic_jhugo@quicinc.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <sonal.santan@amd.com>, <mario.limonciello@amd.com>
References: <yidong.zhang@amd.com>
 <20261009225343.3079074-1-yidong.zhang@amd.com>
 <20261009225343.3079074-18-yidong.zhang@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20261009225343.3079074-18-yidong.zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|SJ2PR12MB8846:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a797a23-6c2a-4c9d-fde9-08df2a2068f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|11063799006|56012099006|4143699003|261009223027099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: RnTAvrsjaG17B4fR0ILkexK0+jfOlEHtfnqHspdMryx7Hh7phq7El16NZIUlcvRNGT89l0DrGKb4S8lVWL5MAMgdbfEciFYv+XGBEi/iyFZcpBqf8KvANtXbUR2b9Mj/BUxWh+j6znZiHmcMj4TsdF6qAaoBPRm9fHNHT0wewjS9cxIGmARfUSA9DgEXIRS6x70tVZtcsQ8kmsBWMacl8LWOw51qS0YzHQh6RDYBdWVrv9/ZOPklkRnrsHucNHHx5MuYxBgqMTgEXOL/psTKINNP8xG7G3VD0E0FzTBlwvZf5YFz1MW2JVqfCakRJHg2w/7JdNyCP8nlGq20AHpoHDIM/umlMJF7OP3WD2zeMYDwPJWVbbLDYoF2Y6vojVPRafjFoVaYLp4i+EbPL9MGfSs+4BiR7ER3ZnjQffh7vlqGgrXvNmfA8/IaVt0q9tFlK0hBw+EaxlBeAzdeJIKvddiyTx/l22tmY1E9CwmY/ElkiICgs23kQrRaqKEpi03XWKSP37gj5SVsa8T9QXTKeidIjB058OkUNfeH9bcaTk3NLz748xbRW5DepkMeh8Qi6mrpTakpwqFWvenkwxpuQatu+mS4LimWSGb0LCXHkipN1BTsixS7IbTKhSVC4NT2sSO38s9Ovt6YMYLpY1AjnxSbnxLaQJ7VdhEa1G62GBDROR+q2qYjNBVNCTMabYn6q+LIPfL98xKVMg7DDIRzIA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(11063799006)(56012099006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aCyQfcsRkn16BD13IeyAVQ9rCLL5R49DfXhPhWfmMGdmWTOMxGOnC6VMrX/tEGLhqiwaXJ2rAGH0Yhv7KOorWy8Q0B40TQC30I4NI3d2lJ1L8hrZ4LD+nim55xou773+GvLWxWC+1LJAvo6UVAPNBs56me5jvLMUTgLWSis5V0Jbv+ZOeyid5MWeJLQfpeoK7awGwySdFn7qeSa4t1zdNek7KcdES69Xewh4l674iW/3JXKJcGk2ZezU2mBDAzgRn7d6v5luzldLzF7BuESNn+k9ZSlHaW7QjIf8zes7HWBR3I3SbbMAE5iLU8sTVCw8/BEeAas0UgRqOGhHYGp1llleCwSCLboJ/5xCm/XP9HyLkVuNNfLE5kcOeFwPz4GF15ypkCv2C4+cSghV+eq8hJL8SNm5b55+8gxU0c81kATnLkoSc/Xzsjkwc0ktSHP3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 18:24:39.6716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a797a23-6c2a-4c9d-fde9-08df2a2068f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8846
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
> Allocate a DRAM buffer for firmware logging, and also set the log level
> to less verbose. This will give the best performance numbers.
>
> Signed-off-by: David Zhang <yidong.zhang@amd.com>
> ---
>   drivers/accel/amdxdna/aie4_message.c  | 20 ++++++++++
>   drivers/accel/amdxdna/aie4_msg_priv.h | 24 ++++++++++++
>   drivers/accel/amdxdna/aie4_pci.c      | 53 +++++++++++++++++++++++++++
>   drivers/accel/amdxdna/aie4_pci.h      |  5 +++
>   4 files changed, 102 insertions(+)
>
> diff --git a/drivers/accel/amdxdna/aie4_message.c b/drivers/accel/amdxdna/aie4_message.c
> index 2820cfb6f9ed..96ccc28e5360 100644
> --- a/drivers/accel/amdxdna/aie4_message.c
> +++ b/drivers/accel/amdxdna/aie4_message.c
> @@ -247,6 +247,26 @@ int aie4_attach_work_buffer(struct amdxdna_dev_hdl *ndev)
>   	return ret;
>   }
>   
> +int aie4_start_fw_log(struct amdxdna_dev_hdl *ndev, u32 level)
> +{
> +	DECLARE_AIE_MSG(aie4_msg_start_fw_log, AIE4_MSG_OP_START_FW_LOG);
> +	struct amdxdna_dev *xdna = ndev->aie.xdna;
> +	int ret;
> +
> +	req.buff_addr = ndev->fw_log_buf_addr;
> +	req.buff_size = ndev->fw_log_buf_size;
> +	req.log_level = level;
> +
> +	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
> +	if (ret)
> +		XDNA_WARN(xdna, "Failed to start fw log, ret %d", ret);
> +	else
> +		XDNA_DBG(xdna, "Started fw log, level %u size 0x%x",
> +			 level, ndev->fw_log_buf_size);
> +
> +	return ret;
> +}
> +
>   int aie4_msg_set_power_mode(struct amdxdna_dev_hdl *ndev, u8 power_mode)
>   {
>   	DECLARE_AIE_MSG(aie4_msg_power_override, AIE4_MSG_OP_POWER_OVERRIDE);
> diff --git a/drivers/accel/amdxdna/aie4_msg_priv.h b/drivers/accel/amdxdna/aie4_msg_priv.h
> index 636bf8d04c76..566f6abc9e2d 100644
> --- a/drivers/accel/amdxdna/aie4_msg_priv.h
> +++ b/drivers/accel/amdxdna/aie4_msg_priv.h
> @@ -29,6 +29,7 @@ enum aie4_msg_opcode {
>   	AIE4_MSG_OP_GET_CURRENT_DPM_LEVEL            = 0x30013,
>   
>   	AIE4_MSG_OP_ATTACH_WORK_BUFFER               = 0x40001,
> +	AIE4_MSG_OP_START_FW_LOG                     = 0x40003,
>   };
>   
>   enum aie4_msg_status {
> @@ -263,4 +264,27 @@ struct aie4_msg_attach_work_buffer_resp {
>   	enum aie4_msg_status status;
>   } __packed;
>   
> +/* Dynamic firmware log levels. */
> +enum aie4_fw_log_level {
> +	AIE4_FW_LOG_LEVEL_OFF,
> +	AIE4_FW_LOG_LEVEL_ERR,
> +	AIE4_FW_LOG_LEVEL_WRN,
> +	AIE4_FW_LOG_LEVEL_INF,
> +	AIE4_FW_LOG_LEVEL_DBG,
> +	AIE4_FW_LOG_LEVEL_MAX,
> +};
> +
> +#define AIE4_FW_LOG_BUF_SIZE      SZ_1M
> +
> +struct aie4_msg_start_fw_log_req {
> +	__u64 buff_addr;
> +	__u32 buff_size;
> +	__u32 log_level;
> +	__u32 reserved;
> +} __packed;
> +
> +struct aie4_msg_start_fw_log_resp {
> +	enum aie4_msg_status status;
> +} __packed;
> +
>   #endif /* _AIE4_MSG_PRIV_H_ */
> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
> index 7f4238f76bc2..e09d24d85cdf 100644
> --- a/drivers/accel/amdxdna/aie4_pci.c
> +++ b/drivers/accel/amdxdna/aie4_pci.c
> @@ -383,6 +383,16 @@ static int aie4_config_fw(struct amdxdna_dev_hdl *ndev)
>   	if (ret == -ETIME)
>   		return ret;
>   
> +	/*
> +	 * Give the firmware high performance DRAM to log into with less
> +	 * verbose level.
> +	 */
> +	if (ndev->fw_log_buf) {
> +		ret = aie4_start_fw_log(ndev, AIE4_FW_LOG_LEVEL_ERR);
> +		if (ret == -ETIME)
> +			return ret;
> +	}
> +
>   	return 0;
>   }
>   
> @@ -941,6 +951,41 @@ static void aie4_free_work_buffer(struct amdxdna_dev_hdl *ndev)
>   	ndev->work_buf = NULL;
>   }
>   
> +/*
> + * Firmware logging is best effort: a device that cannot spare the buffer still
> + * runs, it just does not log. Never fail hw start or probe on this.
> + */
> +static void aie4_alloc_fw_log_buffer(struct amdxdna_dev_hdl *ndev)
> +{
> +	struct amdxdna_dev *xdna = ndev->aie.xdna;
> +	u32 buf_size = AIE4_FW_LOG_BUF_SIZE;
> +
> +	ndev->fw_log_buf = amdxdna_alloc_msg_buffer(xdna, &buf_size,
> +						    &ndev->fw_log_buf_addr);
> +	if (IS_ERR(ndev->fw_log_buf)) {
> +		XDNA_WARN(xdna, "Failed to alloc fw log buffer, size 0x%x",
> +			  AIE4_FW_LOG_BUF_SIZE);
> +		ndev->fw_log_buf = NULL;
> +		return;
> +	}
> +
> +	ndev->fw_log_buf_size = buf_size;
> +	XDNA_DBG(xdna, "FW log buffer allocated: size 0x%x", buf_size);
> +}
> +
> +/* Free logging buffer after firmware execution has stopped. */
> +static void aie4_free_fw_log_buffer(struct amdxdna_dev_hdl *ndev)
> +{
> +	struct amdxdna_dev *xdna = ndev->aie.xdna;
> +
> +	if (!ndev->fw_log_buf)
> +		return;
> +
> +	amdxdna_free_msg_buffer(xdna, ndev->fw_log_buf_size, ndev->fw_log_buf,
> +				ndev->fw_log_buf_addr);
> +	ndev->fw_log_buf = NULL;
> +}
> +
>   static int aie4_pf_init(struct amdxdna_dev *xdna)
>   {
>   	int ret;
> @@ -953,6 +998,8 @@ static int aie4_pf_init(struct amdxdna_dev *xdna)
>   	if (ret)
>   		return ret;
>   
> +	aie4_alloc_fw_log_buffer(xdna->dev_handle);
> +
>   	ret = aie4_pf_hw_start(xdna->dev_handle);
>   	if (ret)
>   		goto free_work_buf;
> @@ -960,6 +1007,7 @@ static int aie4_pf_init(struct amdxdna_dev *xdna)
>   	return 0;
>   
>   free_work_buf:
> +	aie4_free_fw_log_buffer(xdna->dev_handle);
>   	aie4_free_work_buffer(xdna->dev_handle);
>   	return ret;
>   }
> @@ -987,6 +1035,8 @@ static int aie4_classic_init(struct amdxdna_dev *xdna)
>   	if (ret)
>   		return ret;
>   
> +	aie4_alloc_fw_log_buffer(xdna->dev_handle);
> +
>   	ret = aie4_classic_hw_start(xdna->dev_handle);
>   	if (ret)
>   		goto free_work_buf;
> @@ -994,6 +1044,7 @@ static int aie4_classic_init(struct amdxdna_dev *xdna)
>   	return 0;
>   
>   free_work_buf:
> +	aie4_free_fw_log_buffer(xdna->dev_handle);
>   	aie4_free_work_buffer(xdna->dev_handle);
>   	return ret;
>   }
> @@ -1002,6 +1053,7 @@ static void aie4_pf_fini(struct amdxdna_dev *xdna)
>   {
>   	aie4_sriov_stop(xdna->dev_handle);
>   	aie4_pf_hw_stop(xdna->dev_handle);
> +	aie4_free_fw_log_buffer(xdna->dev_handle);
>   	aie4_free_work_buffer(xdna->dev_handle);
>   }
>   
> @@ -1013,6 +1065,7 @@ static void aie4_vf_fini(struct amdxdna_dev *xdna)
>   static void aie4_classic_fini(struct amdxdna_dev *xdna)
>   {
>   	aie4_classic_hw_stop(xdna->dev_handle);
> +	aie4_free_fw_log_buffer(xdna->dev_handle);
>   	aie4_free_work_buffer(xdna->dev_handle);
>   }
>   
> diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
> index da5aa57bc43f..4b7367af7cf1 100644
> --- a/drivers/accel/amdxdna/aie4_pci.h
> +++ b/drivers/accel/amdxdna/aie4_pci.h
> @@ -105,6 +105,10 @@ struct amdxdna_dev_hdl {
>   	dma_addr_t			work_buf_addr;
>   	u32				work_buf_size;
>   
> +	void				*fw_log_buf;
> +	dma_addr_t			fw_log_buf_addr;
> +	u32				fw_log_buf_size;
> +
>   	u8				pw_mode;
>   
>   	/* Context switch hysteresis timeout in microseconds. */
> @@ -125,6 +129,7 @@ int aie4_query_aie_version(struct amdxdna_dev_hdl *ndev,
>   			   struct amdxdna_drm_query_aie_version *version);
>   int aie4_suspend_fw(struct amdxdna_dev_hdl *ndev);
>   int aie4_attach_work_buffer(struct amdxdna_dev_hdl *ndev);
> +int aie4_start_fw_log(struct amdxdna_dev_hdl *ndev, u32 level);
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>   int aie4_query_npu_firmware_version(struct amdxdna_dev_hdl *ndev,
>   				    struct amdxdna_drm_query_firmware_version *fw_version);
>   int aie4_query_cert_firmware_version(struct amdxdna_dev_hdl *ndev,
