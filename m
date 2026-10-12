Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF61DCA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 22:58:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37C2410E680;
	Mon, 12 Oct 2026 22:58:25 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011027.outbound.protection.outlook.com [40.107.208.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D24A10E680
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 22:58:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8CTKbTvdnNhsJdwDTPsoDQLJbl1td6TtbB0q4HWNdN2jtmqutn1+fOzzWrpjRCbiOdGG3/9XO78XgkVUScX0ZuLA5FEP2KopjmwEra5YJr/fCcXROd9o0Vy+uVO8oZmxAwjELu1RAfhg44jcYgAlKlh3g57yxCTqu+DPLUrXauJeR31/05C8bw0nQtFnrU3KtS/fvOe6FOGNdoZTFV+7JF7LUEH6kneOjzL+jkaOOluj/N9zNG8MlLY/eyZdHufbWqnnU1Nl8T6gAeICHj3quhKHvp9wRX7ro35m1vIPXmS+6o/DvuglCVH8obA05+pN/pNu8i/rCuhJz3yZ3g0sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/77Bn8zAMYV6liqHbm2CGRsKNeMqgVTj1C9O5SJszCQ=;
 b=LxDRAVFxCsU/TX8duuvk8pCp0F1fS1sBQC7Bi7nTtp02rgFBKrhmpTIKXiOGJCLSlFbWMSGnKoXwo02u3yv1zZ7c7IypJrDfAVeh5sHKvI0GYakN7SttfmxHjuuc7kJ5UAV8Dt3mKB40aGVqWpdhsHeeD+oJtYuANO7RKyHXjHp5QZ2l75uYFOxr9rRbEvbxkVYJkptSpWDzvhBbAnS9EljgqZuQe517KTtXbZeDTHoKc3IlMyYpWU/R0fx4r8AHDyFAphBeSvWJpvqbI21WV0cXDH7OODyRLXwfTgwDV2zUbkzFKI87EcjXPVmAhbfzPnKFyqj0rJ+aTOHoVJVX/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/77Bn8zAMYV6liqHbm2CGRsKNeMqgVTj1C9O5SJszCQ=;
 b=FPwhqDnV7SsbqJ8yZcgTzV7o9INeb/9qoujeZkQ4Cmj4SjF2qz9J23qaEf0wp77PmnjFEcXWDR2QFmeOmLCOJmOA8itlzEYZsyAkc9yFwSLM2YUsu+q0e/5JK4UQFVrmVGF/W7vhHNK4dpAA9m7nwl7UShR7ao7gd4xMRhN0Whc=
Received: from DS1P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:8:44e::7) by
 IA1PR12MB8311.namprd12.prod.outlook.com (2603:10b6:208:3fa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Mon, 12 Oct
 2026 22:58:11 +0000
Received: from CY8PEPF0000005C.namprd21.prod.outlook.com
 (2603:10b6:8:44e:cafe::a7) by DS1P223CA0026.outlook.office365.com
 (2603:10b6:8:44e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 12
 Oct 2026 22:58:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY8PEPF0000005C.mail.protection.outlook.com (10.167.247.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.0 via Frontend Transport; Mon, 12 Oct 2026 22:58:10 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 12 Oct
 2026 17:58:04 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 12 Oct 2026 17:58:04 -0500
Message-ID: <16fedb09-2815-f678-ffff-a2d407959fda@amd.com>
Date: Mon, 12 Oct 2026 15:58:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V4 08/19] accel/amdxdna: Add clock, DPM frequency, and
 resource info queries for AIE4
Content-Language: en-US
To: David Zhang <yidong.zhang@amd.com>, <quic_jhugo@quicinc.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <sonal.santan@amd.com>, <mario.limonciello@amd.com>, Soham Donwalkar
 <soham.donwalkar@amd.com>
References: <yidong.zhang@amd.com>
 <20261009225343.3079074-1-yidong.zhang@amd.com>
 <20261009225343.3079074-9-yidong.zhang@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20261009225343.3079074-9-yidong.zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF0000005C:EE_|IA1PR12MB8311:EE_
X-MS-Office365-Filtering-Correlation-Id: e56f54a3-1431-4278-b5ff-08df28b449cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|3023799007|6133799003|22082099003|10067099003|18002099003|4143699003|56012099006|261009223027099003|11063799006;
X-Microsoft-Antispam-Message-Info: f+O2Fh7s3BrjdJ94B05LnLR2ynwvfaDLCq3kIz+H10iELevgxhQfdL35J60ICNPdmlYsxR+1xacnSpdvI02uMjGr4LcloTSoOz8kkYmAKQYmAj4d9rnKXyOnHXvz3KButcRWoxbTfToZzU7CORwfl0zdx6Wf0qQSizcUG6+YBeuJsTzuJ8kQdiQfSkAN0EBsGOkJEFobi8yTPiH4C6730G9i4s4FyclgcnHkSkSI28NtdMKtYzPUUi8q85Kx8tjQLGjk39v07oKei1k2E6kpstpnY0I8zHLG7qz24Z0592iUIgvp5zsV3S6w1bmBzQ3sqPIZ+pj4ZA8TGJXFM+fQGN8u0Dv7IfY7LZu819ONTGCeWkEjrOKnYGhOH8hIE4WNVJIz6Exhdkfx7EOqeXb+nWaQE+XzrRLjdX78wQDf9+5PE23lke83GT1OznQzVkT+z8dqK1OYMBzF4GGxgJV9G9SsfoY6tIMOaRZguPWsPNI4jcMMIQpxR6RfsnY7CVemq+45ybTKvrWB2XV5YYg2GbB2QcILHvOf9ptg5bgAicXLpyUuTT+RNl49l9RkSAl/edM0IMmQYmE5b1icpPrxU5e2GCiLgkNvu6rgHKlSdn8EVRFuZime7vZbZOIlA2zayjYqN4BnxxelXq+x/sQGSfXkLkxN2KvBOSBYhwUjk99eTpmcbZFH9IAELr4DOFhjarp0wig7yNv5my8ZaLeVoQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(3023799007)(6133799003)(22082099003)(10067099003)(18002099003)(4143699003)(56012099006)(261009223027099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tL5njS4mljho8LYCpnaO8JljnZZCuJcULaBvZflc9MQd/ZJFPHwZr/I0Bu3gWFhZv9XJfX2vhYXNT+xKqsM9dMVFm8TKS1dGlFpnypqW3hrFON/qXCI4X9dJ+/N9O8rghNP7yytm04plmgIi5EZWhcYGfVaQLFAs5WjiXQtc+LrrxOYTvGl7licvyB/NsAoTiwBSqInG8ptvEOqtxryEx4bjrp7ig7Im+HVQCabpBQftcvi26hdEqicN6nNag4NUeLfssyauQEgQTLMZmDWmTdFCEpA/kDs3/VQKby6UhoiWyPEkWdop1+vbkpyB/Hcvwi9QQXyOEC3d9MruMx+9cCs1LMdbNLFBzrORQojNtaSA6bpMQLXaQmy/kuoAhnI6KOLFpOcF3mgFgYcM0onxMXueAnSQVIhKsipUoxpPgcyq/nwi2R2FeY82AXHOtZWL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 22:58:10.6448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e56f54a3-1431-4278-b5ff-08df28b449cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY8PEPF0000005C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8311
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
> Add support for querying clock metadata, DPM frequency table, and
> hardware resource information for AIE4/NPU3 devices:
> - Move struct dpm_clk_freq and common clock/TOPS counters into struct
>    aie_device.
> - Add NPU3 DPM clock table, DPM control, and counter updates by querying
>    active DPM levels via AIE4_MSG_OP_GET_CURRENT_DPM_LEVEL.
> - Query AIE4 DPM frequency table from firmware via
>    AIE4_MSG_OP_GET_DPM_FREQ_TABLE.
>
> Co-developed-by: Soham Donwalkar <soham.donwalkar@amd.com>
> Signed-off-by: Soham Donwalkar <soham.donwalkar@amd.com>
> Signed-off-by: David Zhang <yidong.zhang@amd.com>
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>   drivers/accel/amdxdna/aie.h           | 36 +++++++++++
>   drivers/accel/amdxdna/aie2_pci.c      | 14 ++---
>   drivers/accel/amdxdna/aie2_pci.h      | 35 +----------
>   drivers/accel/amdxdna/aie2_pm.c       | 10 +--
>   drivers/accel/amdxdna/aie4_message.c  | 88 +++++++++++++++++++++++++++
>   drivers/accel/amdxdna/aie4_msg_priv.h | 31 ++++++++++
>   drivers/accel/amdxdna/aie4_pci.c      | 82 ++++++++++++++++++++++++-
>   drivers/accel/amdxdna/aie4_pci.h      | 12 ++++
>   drivers/accel/amdxdna/npu1_regs.c     | 19 +++---
>   drivers/accel/amdxdna/npu3_regs.c     | 78 ++++++++++++++++++++++++
>   drivers/accel/amdxdna/npu4_regs.c     | 30 ++++-----
>   11 files changed, 367 insertions(+), 68 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/aie.h b/drivers/accel/amdxdna/aie.h
> index 229b3cfa2361..a7276c25844f 100644
> --- a/drivers/accel/amdxdna/aie.h
> +++ b/drivers/accel/amdxdna/aie.h
> @@ -30,8 +30,44 @@ struct aie_device {
>   
>   	struct amdxdna_drm_query_aie_version version;
>   	struct amdxdna_drm_query_aie_metadata metadata;
> +
> +	u32 clk_gating;
> +	u32 npuclk_freq;
> +	u32 hclk_freq;
> +	u32 max_tops;
> +	u32 curr_tops;
> +};
> +
> +struct aie_hw_ops {
> +	int (*set_dpm)(struct aie_device *aie, u32 dpm_level);
> +	int (*update_counters)(struct aie_device *aie);
>   };
>   
> +#define aie_update_counters(ndev)					\
> +({									\
> +	typeof(ndev) _ndev = ndev;					\
> +	if ((_ndev)->priv->hw_ops && (_ndev)->priv->hw_ops->update_counters) \
> +		(_ndev)->priv->hw_ops->update_counters(&(_ndev)->aie);	\
> +})
> +
> +struct dpm_clk_freq {
> +	u32	npuclk;
> +	u32	hclk;
> +};
> +
> +#include <linux/amd-pmf-io.h>
> +
> +#if IS_ENABLED(CONFIG_AMD_PMF)
> +#define AIE_GET_PMF_NPU_METRICS(metrics) amd_pmf_get_npu_data(metrics)
> +#else
> +#define AIE_GET_PMF_NPU_METRICS(metrics)				\
> +({									\
> +	typeof(metrics) _m = metrics;					\
> +	memset(_m, 0xff, sizeof(*_m));					\
> +	(-EOPNOTSUPP);							\
> +})
> +#endif
> +
>   #define DECLARE_AIE_MSG(name, op) \
>   	DECLARE_XDNA_MSG_COMMON(name, op, -1)
>   #define AIE_FEATURE_ON(aie, feature) test_bit(feature, &(aie)->feature_mask)
> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
> index 6fa79698f9d8..1b029d33a24b 100644
> --- a/drivers/accel/amdxdna/aie2_pci.c
> +++ b/drivers/accel/amdxdna/aie2_pci.c
> @@ -296,7 +296,7 @@ static struct xrs_action_ops aie2_xrs_actions = {
>   
>   static void aie2_smu_fini(struct amdxdna_dev_hdl *ndev)
>   {
> -	ndev->priv->hw_ops->set_dpm(ndev, 0);
> +	ndev->priv->hw_ops->set_dpm(&ndev->aie, 0);
>   	aie_smu_fini(ndev->aie.smu_hdl);
>   }
>   
> @@ -718,12 +718,12 @@ static int aie2_get_clock_metadata(struct amdxdna_client *client,
>   	if (!clock)
>   		return -ENOMEM;
>   
> -	aie2_update_counters(ndev);
> +	aie_update_counters(ndev);
>   	snprintf(clock->mp_npu_clock.name, sizeof(clock->mp_npu_clock.name),
>   		 "MP-NPU Clock");
> -	clock->mp_npu_clock.freq_mhz = ndev->npuclk_freq;
> +	clock->mp_npu_clock.freq_mhz = ndev->aie.npuclk_freq;
>   	snprintf(clock->h_clock.name, sizeof(clock->h_clock.name), "H Clock");
> -	clock->h_clock.freq_mhz = ndev->hclk_freq;
> +	clock->h_clock.freq_mhz = ndev->aie.hclk_freq;
>   
>   	buf_sz = min(args->buffer_size, sizeof(*clock));
>   	if (copy_to_user(u64_to_user_ptr(args->buffer), clock, buf_sz))
> @@ -879,11 +879,11 @@ static int aie2_query_resource_info(struct amdxdna_client *client,
>   	ndev = xdna->dev_handle;
>   	priv = ndev->priv;
>   
> -	aie2_update_counters(ndev);
> +	aie_update_counters(ndev);
>   	res_info.npu_clk_max = priv->dpm_clk_tbl[ndev->max_dpm_level].hclk;
> -	res_info.npu_tops_max = ndev->max_tops;
> +	res_info.npu_tops_max = ndev->aie.max_tops;
>   	res_info.npu_task_max = priv->hwctx_limit;
> -	res_info.npu_tops_curr = ndev->curr_tops;
> +	res_info.npu_tops_curr = ndev->aie.curr_tops;
>   	res_info.npu_task_curr = ndev->hwctx_num;
>   
>   	buf_sz = min(args->buffer_size, sizeof(res_info));
> diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
> index b31f73082c17..709e7545c65f 100644
> --- a/drivers/accel/amdxdna/aie2_pci.h
> +++ b/drivers/accel/amdxdna/aie2_pci.h
> @@ -40,8 +40,8 @@
>   	pci_resource_len(NDEV2PDEV(_ndev), (_ndev)->aie.xdna->dev_info->mbox_bar); \
>   })
>   
> +#define AIE2_GET_PMF_NPU_METRICS(metrics) AIE_GET_PMF_NPU_METRICS(metrics)
>   #if IS_ENABLED(CONFIG_AMD_PMF)
> -#define AIE2_GET_PMF_NPU_METRICS(metrics) amd_pmf_get_npu_data(metrics)
>   #define AIE2_GET_PMF_NPU_DATA(field, val)				\
>   ({									\
>   	struct amd_pmf_npu_metrics _npu_metrics;			\
> @@ -52,13 +52,6 @@
>   	(_ret);								\
>   })
>   #else
> -#define AIE2_GET_PMF_NPU_METRICS(metrics)				\
> -({									\
> -	typeof(metrics) _m = metrics;					\
> -	memset(_m, 0xff, sizeof(*_m));					\
> -	(-EOPNOTSUPP);							\
> -})
> -
>   #define SENSOR_DEFAULT_npu_power	U32_MAX
>   #define AIE2_GET_PMF_NPU_DATA(field, val)				\
>   ({									\
> @@ -91,11 +84,6 @@ struct rt_config {
>   	unsigned long feature_mask;
>   };
>   
> -struct dpm_clk_freq {
> -	u32	npuclk;
> -	u32	hclk;
> -};
> -
>   /*
>    * Define the maximum number of pending commands in a hardware context.
>    * Must be power of 2!
> @@ -158,11 +146,6 @@ struct amdxdna_dev_hdl {
>   	u32				dpm_level;
>   	u32				dft_dpm_level;
>   	u32				max_dpm_level;
> -	u32				clk_gating;
> -	u32				npuclk_freq;
> -	u32				hclk_freq;
> -	u32				max_tops;
> -	u32				curr_tops;
>   	u32				force_preempt_enabled;
>   	u32				frame_boundary_preempt;
>   
> @@ -177,18 +160,6 @@ struct amdxdna_dev_hdl {
>   	unsigned long			last_signal_ts;
>   };
>   
> -struct aie2_hw_ops {
> -	int (*set_dpm)(struct amdxdna_dev_hdl *ndev, u32 dpm_level);
> -	int (*update_counters)(struct amdxdna_dev_hdl *ndev);
> -};
> -
> -#define aie2_update_counters(ndev)				\
> -({								\
> -	typeof(ndev) _ndev = ndev;				\
> -	if (_ndev->priv->hw_ops->update_counters)		\
> -		_ndev->priv->hw_ops->update_counters(_ndev);	\
> -})
> -
>   enum aie2_fw_feature {
>   	AIE2_NPU_COMMAND,
>   	AIE2_PREEMPT,
> @@ -219,7 +190,7 @@ struct amdxdna_dev_priv {
>   	struct aie_bar_off_pair		sram_offs[SRAM_MAX_INDEX];
>   	struct aie_bar_off_pair		psp_regs_off[PSP_MAX_REGS];
>   	struct aie_bar_off_pair		smu_regs_off[SMU_MAX_REGS];
> -	const struct aie2_hw_ops	*hw_ops;
> +	const struct aie_hw_ops		*hw_ops;
>   };
>   
>   extern const struct amdxdna_dev_ops aie2_ops;
> @@ -234,7 +205,7 @@ extern const struct rt_config npu1_default_rt_cfg[];
>   extern const struct rt_config npu4_default_rt_cfg[];
>   extern const struct amdxdna_fw_feature_tbl npu4_fw_feature_table[];
>   extern const struct amdxdna_rev_vbnv npu4_rev_vbnv_tbl[];
> -extern const struct aie2_hw_ops npu4_hw_ops;
> +extern const struct aie_hw_ops npu4_hw_ops;
>   
>   /* aie2_pm.c */
>   int aie2_pm_init(struct amdxdna_dev_hdl *ndev);
> diff --git a/drivers/accel/amdxdna/aie2_pm.c b/drivers/accel/amdxdna/aie2_pm.c
> index 4fe6030d2c41..f4ced7b67c25 100644
> --- a/drivers/accel/amdxdna/aie2_pm.c
> +++ b/drivers/accel/amdxdna/aie2_pm.c
> @@ -23,7 +23,7 @@ static int aie2_pm_set_clk_gating(struct amdxdna_dev_hdl *ndev, u32 val)
>   	if (ret)
>   		return ret;
>   
> -	ndev->clk_gating = val;
> +	ndev->aie.clk_gating = val;
>   	return 0;
>   }
>   
> @@ -35,7 +35,7 @@ int aie2_pm_set_dpm(struct amdxdna_dev_hdl *ndev, u32 dpm_level)
>   	if (ret)
>   		return ret;
>   
> -	ret = ndev->priv->hw_ops->set_dpm(ndev, dpm_level);
> +	ret = ndev->priv->hw_ops->set_dpm(&ndev->aie, dpm_level);
>   	if (!ret)
>   		ndev->dpm_level = dpm_level;
>   	amdxdna_pm_suspend_put(ndev->aie.xdna);
> @@ -49,11 +49,11 @@ int aie2_pm_init(struct amdxdna_dev_hdl *ndev)
>   
>   	if (ndev->dev_status != AIE2_DEV_UNINIT) {
>   		/* Resume device */
> -		ret = ndev->priv->hw_ops->set_dpm(ndev, ndev->dpm_level);
> +		ret = ndev->priv->hw_ops->set_dpm(&ndev->aie, ndev->dpm_level);
>   		if (ret)
>   			return ret;
>   
> -		ret = aie2_pm_set_clk_gating(ndev, ndev->clk_gating);
> +		ret = aie2_pm_set_clk_gating(ndev, ndev->aie.clk_gating);
>   		if (ret)
>   			return ret;
>   
> @@ -64,7 +64,7 @@ int aie2_pm_init(struct amdxdna_dev_hdl *ndev)
>   		ndev->max_dpm_level++;
>   	ndev->max_dpm_level--;
>   
> -	ret = ndev->priv->hw_ops->set_dpm(ndev, ndev->max_dpm_level);
> +	ret = ndev->priv->hw_ops->set_dpm(&ndev->aie, ndev->max_dpm_level);
>   	if (ret)
>   		return ret;
>   	ndev->dpm_level = ndev->max_dpm_level;
> diff --git a/drivers/accel/amdxdna/aie4_message.c b/drivers/accel/amdxdna/aie4_message.c
> index 8d1cad50cbab..263e23aff69f 100644
> --- a/drivers/accel/amdxdna/aie4_message.c
> +++ b/drivers/accel/amdxdna/aie4_message.c
> @@ -141,6 +141,94 @@ int aie4_query_cert_firmware_version(struct amdxdna_dev_hdl *ndev,
>   	return 0;
>   }
>   
> +int aie4_init_dpm_freq_table(struct amdxdna_dev_hdl *ndev)
> +{
> +	DECLARE_AIE_MSG(aie4_msg_get_dpm_freq_table, AIE4_MSG_OP_GET_DPM_FREQ_TABLE);
> +	struct amdxdna_dev *xdna = ndev->aie.xdna;
> +	u32 aie_levels, npu_levels, i;
> +	int ret;
> +
> +	for (i = 0; i < AIE4_MAX_DPM_LEVEL_COUNT && ndev->priv->dpm_clk_tbl &&
> +	     ndev->priv->dpm_clk_tbl[i].hclk; i++)
> +		ndev->dpm_clk_tbl[i] = ndev->priv->dpm_clk_tbl[i];
> +	ndev->max_aieclk_level = i ? i - 1 : 0;
> +	ndev->max_npuhclk_level = i ? i - 1 : 0;
> +
> +	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
> +	if (ret) {
> +		XDNA_WARN(xdna, "Get DPM freq table failed, ret %d status 0x%x",
> +			  ret, resp.status);
> +		return ret;
> +	}
> +
> +	aie_levels = resp.aieclk_table.num_levels;
> +	npu_levels = resp.npuhclk_table.num_levels;
> +
> +	if (!aie_levels || !npu_levels ||
> +	    aie_levels > AIE4_MAX_DPM_LEVEL_COUNT ||
> +	    npu_levels > AIE4_MAX_DPM_LEVEL_COUNT) {
> +		XDNA_ERR(xdna, "invalid dpm levels, aieclk: %u, npuhclk: %u",
> +			 aie_levels, npu_levels);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < aie_levels; i++) {
> +		if (!resp.aieclk_table.values[i]) {
> +			XDNA_ERR(xdna, "invalid dpm aieclk frequency 0 at level %u", i);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	for (i = 0; i < npu_levels; i++) {
> +		if (!resp.npuhclk_table.values[i]) {
> +			XDNA_ERR(xdna, "invalid dpm npuhclk frequency 0 at level %u", i);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	memset(ndev->dpm_clk_tbl, 0, sizeof(ndev->dpm_clk_tbl));
> +	for (i = 0; i < aie_levels; i++)
> +		ndev->dpm_clk_tbl[i].npuclk = resp.aieclk_table.values[i];
> +
> +	for (i = 0; i < npu_levels; i++)
> +		ndev->dpm_clk_tbl[i].hclk = resp.npuhclk_table.values[i];
> +
> +	ndev->max_aieclk_level = aie_levels - 1;
> +	ndev->max_npuhclk_level = npu_levels - 1;
> +
> +	return 0;
> +}
> +
> +int aie4_query_dpm_level(struct amdxdna_dev_hdl *ndev,
> +			 u32 *aieclk_dpm_level, u32 *npuhclk_dpm_level)
> +{
> +	DECLARE_AIE_MSG(aie4_msg_get_dpm_level, AIE4_MSG_OP_GET_CURRENT_DPM_LEVEL);
> +	struct amdxdna_dev *xdna = ndev->aie.xdna;
> +	int ret;
> +
> +	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Validate against ndev->max_aieclk_level and ndev->max_npuhclk_level
> +	 * to ensure reported levels index into populated entries in dpm_clk_tbl.
> +	 */
> +	if (resp.aieclk_dpm_level > ndev->max_aieclk_level ||
> +	    resp.npuhclk_dpm_level > ndev->max_npuhclk_level) {
> +		XDNA_ERR(xdna,
> +			 "invalid dpm level, aie: %u/%u, npu: %u/%u",
> +			 resp.aieclk_dpm_level, ndev->max_aieclk_level,
> +			 resp.npuhclk_dpm_level, ndev->max_npuhclk_level);
> +		return -EINVAL;
> +	}
> +
> +	*aieclk_dpm_level = resp.aieclk_dpm_level;
> +	*npuhclk_dpm_level = resp.npuhclk_dpm_level;
> +
> +	return 0;
> +}
> +
>   int aie4_attach_work_buffer(struct amdxdna_dev_hdl *ndev)
>   {
>   	DECLARE_AIE_MSG(aie4_msg_attach_work_buffer, AIE4_MSG_OP_ATTACH_WORK_BUFFER);
> diff --git a/drivers/accel/amdxdna/aie4_msg_priv.h b/drivers/accel/amdxdna/aie4_msg_priv.h
> index 4c06792df1bd..fe78df9e23c8 100644
> --- a/drivers/accel/amdxdna/aie4_msg_priv.h
> +++ b/drivers/accel/amdxdna/aie4_msg_priv.h
> @@ -24,6 +24,8 @@ enum aie4_msg_opcode {
>   	AIE4_MSG_OP_AIE_TILE_INFO                    = 0x30006,
>   	AIE4_MSG_OP_AIE_VERSION_INFO                 = 0x30007,
>   	AIE4_MSG_OP_POWER_OVERRIDE                   = 0x3000B,
> +	AIE4_MSG_OP_GET_DPM_FREQ_TABLE               = 0x30012,
> +	AIE4_MSG_OP_GET_CURRENT_DPM_LEVEL            = 0x30013,
>   
>   	AIE4_MSG_OP_ATTACH_WORK_BUFFER               = 0x40001,
>   };
> @@ -196,6 +198,35 @@ struct aie4_msg_power_override_resp {
>   	enum aie4_msg_status status;
>   } __packed;
>   
> +#define AIE4_MAX_DPM_LEVEL_COUNT	10
> +
> +struct aie4_dpm_table {
> +	__u32 num_levels;
> +	__u32 values[AIE4_MAX_DPM_LEVEL_COUNT];
> +} __packed;
> +
> +/* AIE4_MSG_OP_GET_DPM_FREQ_TABLE */
> +struct aie4_msg_get_dpm_freq_table_req {
> +	__u32 rsvd;
> +} __packed;
> +
> +struct aie4_msg_get_dpm_freq_table_resp {
> +	enum aie4_msg_status status;
> +	struct aie4_dpm_table aieclk_table;
> +	struct aie4_dpm_table npuhclk_table;
> +} __packed;
> +
> +/* AIE4_MSG_OP_GET_CURRENT_DPM_LEVEL */
> +struct aie4_msg_get_dpm_level_req {
> +	__u32 rsvd;
> +} __packed;
> +
> +struct aie4_msg_get_dpm_level_resp {
> +	enum aie4_msg_status status;
> +	__u32 aieclk_dpm_level;
> +	__u32 npuhclk_dpm_level;
> +} __packed;
> +
>   #define AIE4_WORK_BUFFER_MIN_SIZE      SZ_4M
>   
>   struct aie4_msg_attach_work_buffer_req {
> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
> index 6eacdc026ec7..5593dfb6c7ed 100644
> --- a/drivers/accel/amdxdna/aie4_pci.c
> +++ b/drivers/accel/amdxdna/aie4_pci.c
> @@ -299,6 +299,17 @@ static int aie4_query(struct amdxdna_dev_hdl *ndev)
>   	if (ret)
>   		return ret;
>   
> +	ndev->total_col = min_t(u32, AIE4_TOTAL_COLUMN, ndev->aie.metadata.cols);
> +
> +	ret = aie4_init_dpm_freq_table(ndev);
> +	if (ret) {
> +		if (ret == -ETIME)
> +			return ret;
> +		/* if query dpm from fw failed, using default value */
> +		if (ndev->priv->hw_ops && ndev->priv->hw_ops->set_dpm)
> +			(void)ndev->priv->hw_ops->set_dpm(&ndev->aie, 0);
> +	}
> +
>   	return 0;
>   }
>   
> @@ -635,11 +646,71 @@ static int aie4_get_power_mode(struct amdxdna_client *client,
>   	return 0;
>   }
>   
> +static int aie4_query_clock_metadata(struct amdxdna_client *client,
> +				     struct amdxdna_drm_get_info *args)
> +{
> +	struct amdxdna_drm_query_clock_metadata *clock;
> +	struct amdxdna_dev *xdna = client->xdna;
> +	struct amdxdna_dev_hdl *ndev;
> +	int ret = 0;
> +	u32 buf_sz;
> +
> +	ndev = xdna->dev_handle;
> +	clock = kzalloc_obj(*clock);
> +	if (!clock)
> +		return -ENOMEM;
> +
> +	aie_update_counters(ndev);
> +	snprintf(clock->mp_npu_clock.name, sizeof(clock->mp_npu_clock.name),
> +		 "MP-NPU Clock");
> +	clock->mp_npu_clock.freq_mhz = ndev->aie.npuclk_freq;
> +	snprintf(clock->h_clock.name, sizeof(clock->h_clock.name), "H Clock");
> +	clock->h_clock.freq_mhz = ndev->aie.hclk_freq;
> +
> +	buf_sz = min_t(u32, args->buffer_size, sizeof(*clock));
> +	if (copy_to_user(u64_to_user_ptr(args->buffer), clock, buf_sz))
> +		ret = -EFAULT;
> +
> +	kfree(clock);
> +	return ret;
> +}
> +
> +static int aie4_query_resource_info(struct amdxdna_client *client,
> +				    struct amdxdna_drm_get_info *args)
> +{
> +	struct amdxdna_drm_get_resource_info res_info = {};
> +	struct amdxdna_dev_hdl *ndev;
> +	struct amdxdna_dev *xdna;
> +	u32 buf_sz;
> +
> +	xdna = client->xdna;
> +	ndev = xdna->dev_handle;
> +
> +	aie_update_counters(ndev);
> +	res_info.npu_clk_max = ndev->dpm_clk_tbl[ndev->max_npuhclk_level].hclk;
> +	res_info.npu_tops_max = ndev->aie.max_tops;
> +	res_info.npu_tops_curr = ndev->aie.curr_tops;
> +	/* Context accounting is populated in later patches in the series. */
> +
> +	buf_sz = min_t(u32, args->buffer_size, sizeof(res_info));
> +	if (copy_to_user(u64_to_user_ptr(args->buffer), &res_info, buf_sz))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
>   static int aie4_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_info *args)
>   {
>   	struct amdxdna_dev *xdna = client->xdna;
>   	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
> -	int ret;
> +	int ret, idx;
> +
> +	if (!drm_dev_enter(&xdna->ddev, &idx))
> +		return -ENODEV;
> +
> +	ret = amdxdna_pm_resume_get_locked(xdna);
> +	if (ret)
> +		goto dev_exit;
>   
>   	switch (args->param) {
>   	case DRM_AMDXDNA_QUERY_AIE_METADATA:
> @@ -648,19 +719,28 @@ static int aie4_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_i
>   	case DRM_AMDXDNA_QUERY_AIE_VERSION:
>   		ret = amdxdna_get_aie_version(client, args, &ndev->aie.version);
>   		break;
> +	case DRM_AMDXDNA_QUERY_CLOCK_METADATA:
> +		ret = aie4_query_clock_metadata(client, args);
> +		break;
>   	case DRM_AMDXDNA_QUERY_FIRMWARE_VERSION:
>   		ret = amdxdna_get_firmware_version(client, args, &xdna->fw_ver);
>   		break;
>   	case DRM_AMDXDNA_GET_POWER_MODE:
>   		ret = aie4_get_power_mode(client, args);
>   		break;
> +	case DRM_AMDXDNA_QUERY_RESOURCE_INFO:
> +		ret = aie4_query_resource_info(client, args);
> +		break;
>   	default:
>   		XDNA_ERR(xdna, "Not supported request parameter %u", args->param);
>   		ret = -EOPNOTSUPP;
>   	}
>   
> +	amdxdna_pm_suspend_put(xdna);
>   	XDNA_DBG(xdna, "Got param %d", args->param);
>   
> +dev_exit:
> +	drm_dev_exit(idx);
>   	return ret;
>   }
>   
> diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
> index fd2c50dc8080..6e9e7f874a44 100644
> --- a/drivers/accel/amdxdna/aie4_pci.h
> +++ b/drivers/accel/amdxdna/aie4_pci.h
> @@ -11,6 +11,7 @@
>   #include <linux/pci.h>
>   
>   #include "aie.h"
> +#include "aie4_msg_priv.h"
>   #include "amdxdna_mailbox.h"
>   
>   struct cert_comp {
> @@ -40,6 +41,9 @@ struct amdxdna_dev_priv {
>   
>   	struct aie_bar_off_pair	psp_regs_off[PSP_MAX_REGS];
>   	struct aie_bar_off_pair	smu_regs_off[SMU_MAX_REGS];
> +
> +	const struct dpm_clk_freq	*dpm_clk_tbl;
> +	const struct aie_hw_ops		*hw_ops;
>   };
>   
>   struct amdxdna_dev_hdl {
> @@ -50,6 +54,11 @@ struct amdxdna_dev_hdl {
>   
>   	struct mailbox			*mbox;
>   	u32				partition_id;
> +	u32				total_col;
> +	u32				max_aieclk_level;
> +	u32				max_npuhclk_level;
> +
> +	struct dpm_clk_freq		dpm_clk_tbl[AIE4_MAX_DPM_LEVEL_COUNT];
>   
>   	struct xarray                   cert_comp_xa; /* device level indexed by msix id */
>   	struct mutex                    cert_comp_lock; /* protects cert_comp operations*/
> @@ -79,6 +88,9 @@ int aie4_query_npu_firmware_version(struct amdxdna_dev_hdl *ndev,
>   				    struct amdxdna_drm_query_firmware_version *fw_version);
>   int aie4_query_cert_firmware_version(struct amdxdna_dev_hdl *ndev,
>   				     struct amdxdna_drm_query_firmware_version *cert_version);
> +int aie4_init_dpm_freq_table(struct amdxdna_dev_hdl *ndev);
> +int aie4_query_dpm_level(struct amdxdna_dev_hdl *ndev,
> +			 u32 *aieclk_dpm_level, u32 *npuhclk_dpm_level);
>   int aie4_msg_set_power_mode(struct amdxdna_dev_hdl *ndev, u8 power_mode);
>   u32 aie4_msg_pasid(struct amdxdna_client *client);
>   
> diff --git a/drivers/accel/amdxdna/npu1_regs.c b/drivers/accel/amdxdna/npu1_regs.c
> index ca779674017a..b4a0ede636f0 100644
> --- a/drivers/accel/amdxdna/npu1_regs.c
> +++ b/drivers/accel/amdxdna/npu1_regs.c
> @@ -71,24 +71,25 @@ static const struct amdxdna_fw_feature_tbl npu1_fw_feature_table[] = {
>   	{ 0 }
>   };
>   
> -static int npu1_set_dpm(struct amdxdna_dev_hdl *ndev, u32 dpm_level)
> +static int npu1_set_dpm(struct aie_device *aie, u32 dpm_level)
>   {
> +	struct amdxdna_dev_hdl *ndev = aie->xdna->dev_handle;
>   	u32 npuclk, hclk;
>   	int ret;
>   
>   	npuclk = ndev->priv->dpm_clk_tbl[dpm_level].npuclk;
>   	hclk = ndev->priv->dpm_clk_tbl[dpm_level].hclk;
> -	ret = aie_smu_set_clocks(ndev->aie.smu_hdl, &npuclk, &hclk);
> +	ret = aie_smu_set_clocks(aie->smu_hdl, &npuclk, &hclk);
>   	if (ret)
>   		return ret;
>   
> -	ndev->npuclk_freq = npuclk;
> -	ndev->hclk_freq = hclk;
> -	ndev->max_tops = 2 * ndev->total_col;
> -	ndev->curr_tops = ndev->max_tops * hclk / 1028;
> +	aie->npuclk_freq = npuclk;
> +	aie->hclk_freq = hclk;
> +	aie->max_tops = 2 * ndev->total_col;
> +	aie->curr_tops = aie->max_tops * hclk / 1028;
>   
> -	XDNA_DBG(ndev->aie.xdna, "MP-NPU clock %d, H clock %d\n",
> -		 ndev->npuclk_freq, ndev->hclk_freq);
> +	XDNA_DBG(aie->xdna, "MP-NPU clock %d, H clock %d\n",
> +		 aie->npuclk_freq, aie->hclk_freq);
>   	return 0;
>   }
>   
> @@ -123,7 +124,7 @@ static const struct amdxdna_dev_priv npu1_dev_priv = {
>   		DEFINE_BAR_OFFSET(SMU_RESP_REG, NPU1_SMU, MPNPU_PUB_SCRATCH6),
>   		DEFINE_BAR_OFFSET(SMU_OUT_REG,  NPU1_SMU, MPNPU_PUB_SCRATCH7),
>   	},
> -	.hw_ops		= &(const struct aie2_hw_ops) {
> +	.hw_ops		= &(const struct aie_hw_ops) {
>   		.set_dpm = npu1_set_dpm,
>   	},
>   };
> diff --git a/drivers/accel/amdxdna/npu3_regs.c b/drivers/accel/amdxdna/npu3_regs.c
> index c82433d62901..cff99ddd3a55 100644
> --- a/drivers/accel/amdxdna/npu3_regs.c
> +++ b/drivers/accel/amdxdna/npu3_regs.c
> @@ -37,6 +37,8 @@
>   #define MP1_C2PMSG_61_ALT_1     0x3B109F4
>   #define MP1_C2PMSG_60_ALT_1     0x3B109F0
>   
> +#define NPU3_DPM_TOPS(ndev, hclk) (4096 * (ndev)->total_col * (hclk) / 1000000)
> +
>   static const struct amdxdna_fw_feature_tbl npu3_fw_feature_table[] = {
>   	{ .major = 6, .min_minor = 0 },
>   	{ 0 }
> @@ -47,9 +49,82 @@ static const struct amdxdna_fw_feature_tbl npu3_cert_feature_table[] = {
>   	{ 0 }
>   };
>   
> +static const struct dpm_clk_freq npu3_dpm_clk_table[] = {
> +	{  400,  400 },
> +	{  960,  576 },
> +	{ 1108,  576 },
> +	{ 1200,  847 },
> +	{ 1200, 1200 },
> +	{ 1200, 1200 },
> +	{ 1200, 1200 },
> +	{ 1200, 1200 },
> +	{ 0 }
> +};
> +
> +static int npu3_set_dpm(struct aie_device *aie, u32 dpm_level)
> +{
> +	struct amdxdna_dev_hdl *ndev = aie->xdna->dev_handle;
> +	u32 aie_lvl, npu_lvl;
> +
> +	if (dpm_level > max(ndev->max_aieclk_level, ndev->max_npuhclk_level)) {
> +		XDNA_ERR(aie->xdna, "Invalid dpm level %u (max aie %u, npu %u)",
> +			 dpm_level, ndev->max_aieclk_level, ndev->max_npuhclk_level);
> +		return -EINVAL;
> +	}
> +
> +	aie_lvl = min(dpm_level, ndev->max_aieclk_level);
> +	npu_lvl = min(dpm_level, ndev->max_npuhclk_level);
> +
> +	aie->npuclk_freq = ndev->dpm_clk_tbl[aie_lvl].npuclk;
> +	aie->hclk_freq = ndev->dpm_clk_tbl[npu_lvl].hclk;
> +	aie->max_tops = NPU3_DPM_TOPS(ndev, ndev->dpm_clk_tbl[ndev->max_npuhclk_level].hclk);
> +	aie->curr_tops = NPU3_DPM_TOPS(ndev, aie->hclk_freq);
> +
> +	XDNA_DBG(aie->xdna, "MP-NPU clock %d, H clock %d\n",
> +		 aie->npuclk_freq, aie->hclk_freq);
> +
> +	return 0;
> +}
> +
> +static int npu3_update_counters(struct aie_device *aie)
> +{
> +	struct amdxdna_dev_hdl *ndev = aie->xdna->dev_handle;
> +	u32 aieclk_level, npuhclk_level;
> +	int ret;
> +
> +	/* Use firmware DPM table or pre-defined table, never mixed. */
> +	ret = aie4_query_dpm_level(ndev, &aieclk_level, &npuhclk_level);
> +	if (ret) {
> +		XDNA_WARN(aie->xdna, "Failed to get DPM level from fw: %d", ret);
> +		return ret;
> +	}
> +
> +	if (aieclk_level > ndev->max_aieclk_level ||
> +	    npuhclk_level > ndev->max_npuhclk_level) {
> +		XDNA_ERR(aie->xdna, "DPM level exceeds max: aie %u/%u, npu %u/%u",
> +			 aieclk_level, ndev->max_aieclk_level,
> +			 npuhclk_level, ndev->max_npuhclk_level);
> +		return -EINVAL;
> +	}
> +
> +	aie->npuclk_freq = ndev->dpm_clk_tbl[aieclk_level].npuclk;
> +	aie->hclk_freq = ndev->dpm_clk_tbl[npuhclk_level].hclk;
> +	aie->max_tops = NPU3_DPM_TOPS(ndev,
> +				      ndev->dpm_clk_tbl[ndev->max_npuhclk_level].hclk);
> +	aie->curr_tops = NPU3_DPM_TOPS(ndev, aie->hclk_freq);
> +
> +	return 0;
> +}
> +
> +static const struct aie_hw_ops npu3_hw_ops = {
> +	.set_dpm = npu3_set_dpm,
> +	.update_counters = npu3_update_counters,
> +};
> +
>   static const struct amdxdna_dev_priv npu3_dev_priv = {
>   	.npufw_path             = "npu.sbin",
>   	.certfw_path            = "cert.sbin",
> +	.dpm_clk_tbl		= npu3_dpm_clk_table,
>   	.mbox_bar		= NPU3_MBOX_BAR,
>   	.mbox_rbuf_bar		= NPU3_MBOX_BUFFER_BAR,
>   	.mbox_info_off		= NPU3_MBOX_INFO_OFF,
> @@ -71,14 +146,17 @@ static const struct amdxdna_dev_priv npu3_dev_priv = {
>   		DEFINE_BAR_OFFSET(SMU_RESP_REG, NPU3_SMU, MP1_C2PMSG_60_ALT_1),
>   		DEFINE_BAR_OFFSET(SMU_OUT_REG,  NPU3_SMU, MP1_C2PMSG_61_ALT_1),
>   	},
> +	.hw_ops			= &npu3_hw_ops,
>   };
>   
>   static const struct amdxdna_dev_priv npu3_dev_vf_priv = {
>   	/* vf device does not load firmware */
> +	.dpm_clk_tbl		= npu3_dpm_clk_table,
>   	.mbox_bar		= NPU3_MBOX_BAR,
>   	.mbox_rbuf_bar		= NPU3_MBOX_BUFFER_BAR,
>   	.mbox_info_off		= NPU3_MBOX_INFO_OFF,
>   	/* vf device does not have smu and psp */
> +	.hw_ops			= &npu3_hw_ops,
>   };
>   
>   const struct amdxdna_dev_info dev_npu3_pf_info = {
> diff --git a/drivers/accel/amdxdna/npu4_regs.c b/drivers/accel/amdxdna/npu4_regs.c
> index c9648c8032ec..624c1babdff8 100644
> --- a/drivers/accel/amdxdna/npu4_regs.c
> +++ b/drivers/accel/amdxdna/npu4_regs.c
> @@ -104,42 +104,44 @@ const struct amdxdna_fw_feature_tbl npu4_fw_feature_table[] = {
>   	{ 0 }
>   };
>   
> -static int npu4_set_dpm(struct amdxdna_dev_hdl *ndev, u32 dpm_level)
> +static int npu4_set_dpm(struct aie_device *aie, u32 dpm_level)
>   {
> +	struct amdxdna_dev_hdl *ndev = aie->xdna->dev_handle;
>   	int ret;
>   
> -	ret = aie_smu_set_dpm(ndev->aie.smu_hdl, dpm_level);
> +	ret = aie_smu_set_dpm(aie->smu_hdl, dpm_level);
>   	if (ret)
>   		return ret;
>   
> -	ndev->npuclk_freq = ndev->priv->dpm_clk_tbl[dpm_level].npuclk;
> -	ndev->hclk_freq = ndev->priv->dpm_clk_tbl[dpm_level].hclk;
> -	ndev->max_tops = NPU4_DPM_TOPS(ndev, ndev->priv->dpm_clk_tbl[ndev->max_dpm_level].hclk);
> -	ndev->curr_tops = NPU4_DPM_TOPS(ndev, ndev->hclk_freq);
> +	aie->npuclk_freq = ndev->priv->dpm_clk_tbl[dpm_level].npuclk;
> +	aie->hclk_freq = ndev->priv->dpm_clk_tbl[dpm_level].hclk;
> +	aie->max_tops = NPU4_DPM_TOPS(ndev, ndev->priv->dpm_clk_tbl[ndev->max_dpm_level].hclk);
> +	aie->curr_tops = NPU4_DPM_TOPS(ndev, aie->hclk_freq);
>   
> -	XDNA_DBG(ndev->aie.xdna, "MP-NPU clock %d, H clock %d\n",
> -		 ndev->npuclk_freq, ndev->hclk_freq);
> +	XDNA_DBG(aie->xdna, "MP-NPU clock %d, H clock %d\n",
> +		 aie->npuclk_freq, aie->hclk_freq);
>   
>   	return 0;
>   }
>   
> -static int npu4_update_counters(struct amdxdna_dev_hdl *ndev)
> +static int npu4_update_counters(struct aie_device *aie)
>   {
> +	struct amdxdna_dev_hdl *ndev = aie->xdna->dev_handle;
>   	struct amd_pmf_npu_metrics npu_metrics;
>   	int ret;
>   
> -	ret = AIE2_GET_PMF_NPU_METRICS(&npu_metrics);
> +	ret = AIE_GET_PMF_NPU_METRICS(&npu_metrics);
>   	if (ret)
>   		return ret;
>   
> -	ndev->npuclk_freq = npu_metrics.mpnpuclk_freq;
> -	ndev->hclk_freq = npu_metrics.npuclk_freq;
> -	ndev->curr_tops = NPU4_DPM_TOPS(ndev, ndev->hclk_freq);
> +	aie->npuclk_freq = npu_metrics.mpnpuclk_freq;
> +	aie->hclk_freq = npu_metrics.npuclk_freq;
> +	aie->curr_tops = NPU4_DPM_TOPS(ndev, aie->hclk_freq);
>   
>   	return 0;
>   }
>   
> -const struct aie2_hw_ops npu4_hw_ops = {
> +const struct aie_hw_ops npu4_hw_ops = {
>   	.set_dpm = npu4_set_dpm,
>   	.update_counters = npu4_update_counters,
>   };
