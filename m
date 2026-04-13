Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E19BF34C64
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 16:43:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E627910E4D5;
	Mon, 13 Apr 2026 16:43:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zuF/Q4XT";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011057.outbound.protection.outlook.com [52.101.57.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61E0510E4D5
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 16:43:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pTppNu9DZfO0e/iKe3MgiIFFzmKHTuEPRXKXXSIR+NPYu1JXMJ4RJKfOg4nrITzt4YoM63ZBo4nmVFQ3zHyEzam4d9qpe/4aYcvP3RN4qydyVrPaRYS8TPlzmZIBcTAa3cuLZgdS8YwJA/yD5E/uJJbzlbGNtG+TDCVxQ+aIa4es6I6JN3t2WjZw31E1yz+V8oKOBjG9d+XwbdgDNftKGU06AsTqhFiHtDiTehpmR7BtStml9AWJvW6udwBx0hwBkFroBbV1Qnrw4zQbYWl4jyPavwYdbLCc1sZ63ua8yd2AwhepgeabBgqBgkrUAQvAy64QDgJ8Oi++A7Cc4yfyjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oa5uNx6jyXu4kxAUe/gK8LzwbJLkUEwqnLefUPIv2eg=;
 b=BQPM7RxpsvjZCuN/0Qp5nIAVUfs/uiXh9tyTrJs3qAfq5OMy6Xbfvqr5VbX/MyfYW4HqjStxiH5WiuASBQiBikrFq4igqBwxC80EtXxS2LA6QT1C4fh2mXmbYy/nyjFVQUzfzo972+OmSSGY1EypH9Rt0Cb/k1AeKB/pvRG6uhig8+VlpVUt3zWJVRWlX+8ZqeykfYoRCXjAs+tB/1/BQyAxrZcge4iwxTj/O3TjdGUnPLA4tNkdi+tzn8YaOOlr1hQDoZt/BSNFlADsrA+cmLeFe4I7wu0xE02bgDeOk4SNumJXZOUFF8Yc6OpC4SQ5zsc9bBUjeGr6LdFvpb3G6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oa5uNx6jyXu4kxAUe/gK8LzwbJLkUEwqnLefUPIv2eg=;
 b=zuF/Q4XTAaycajCPPxlR9e9131bIIi0QFAtD/eENesvGhIvfle8mdYtqELV70oDiIRN59c6W7MVnv1Qw1IzxxSb1R77ipN9T6Nh2TQJAUIxvJb7wTiRsRWEbl8qIBZvWtWzSsv6HENpkZko1cKDvy57bSiMw8ED/diD7eHqSqio=
Received: from CH0P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::14)
 by DM3PR12MB9350.namprd12.prod.outlook.com (2603:10b6:8:1ae::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 16:43:43 +0000
Received: from DM2PEPF00003FC8.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::fe) by CH0P223CA0004.outlook.office365.com
 (2603:10b6:610:116::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 16:43:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM2PEPF00003FC8.mail.protection.outlook.com (10.167.23.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 16:43:42 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 11:43:33 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 13 Apr 2026 11:43:32 -0500
Message-ID: <754973ae-4d33-c072-0916-e33217b05212@amd.com>
Date: Mon, 13 Apr 2026 09:43:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Read real-time clock frequencies
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <maciej.falkowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <max.zhen@amd.com>, <sonal.santan@amd.com>
References: <20260406220526.4027917-1-lizhi.hou@amd.com>
 <3abd1526-7991-4bfb-b772-3a695b5e1b59@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <3abd1526-7991-4bfb-b772-3a695b5e1b59@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC8:EE_|DM3PR12MB9350:EE_
X-MS-Office365-Filtering-Correlation-Id: ebeaa9b7-e7b7-4f3a-16d6-08de997bd295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: Sn/32E7rU3PElEpK/hfNk7/it7DQwRIXx+LZ0HcobsOYeKLQ0UMAdJKoqxEDoYxTC/1VgbooGUt1ulr9bnAp5RO1Qm1Cjy9iYVP8BOIkCKHrDmMPmkldhtqykY/ImPrnJADgNIA80hllbLbQ/AeRz93e6eD8NfKf9VjCgdfWw4Pz64ZU9hG6iQ76pK5uDitnm1/FvHweQatWT3WZSWSaO1nKGUpL4JagTonp+1meO7ftpZ9C6ZN2RyeBVNTxAktkDdhR87rlhMqBIZ6S1GKNUIbTxvUrOkimbB16oNRk5qs9ILaWt+3KFNfB9WhdZvYBGkEMFSxUD5tcVPXoxfv8yNeZW635xr1a66bCwaahoYmFFnH+GPW0j5h2wDZA4qrlASdQUVIbfgMvn4Pl4lkzBet7VSr+UAqnCsDGY7tHjDM36a05K3j3uh8xRQqYv7K9TNr72n3voAdZnFLIZAUyoB6xNUsGXl7uBSZiMf/FxlhnvvpiNMMpgajg36ncU8XnVKXa0V9FZS9djXW5ENfy83AzerL8pEiK7ojCKpIsdhOl40ubUXtF/2jXjrrQMmajhld0zfSDd3yAW9QW0C5pgopB43yEqX965Fu8WcNXC96qwtcuo2Oi7n8Bh8ifoJIXvNb5mXWZbgtAHlah7eqeSV/M+T8/athIW1caia0bLh/NlBRqUsvMr+EOS5bll0o1lh4fs8361wC81E8sJvptD9KPqZzYlAv3z+SgWF1V7ffN0BuFl+0Hz8uXWCO2SDOcN+gLhF078UccUEARCeIUKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AHET/6KowBHhpF7eUDDACNWG4ytDLy4DkWCn5dKjg15OJh157NAlHPo90X6CQtP8D/b6wj8zGeo2aJE4XjskEJ9Xzn4y3syX/l/IC+Gw2s8BbmEkCwUhj5HEMcBHJpRkknsn+ofNjHdiq4piacGfJDbtUQukMvv+833tYGgbhyJQ3NrYoDOQRAsviOAEmuQ0UXyoj6IvT0rKz3p0yKEisPN4plaI3UBCkVooPBwNJ04ZPwh8WmrCof9gQTqPiweUgzGKWs/C2vaA+Dz4Y8pVU9XptDiSMrUnlC8h5qzp27ZSKQ6hTvGqu+X6OPlaOno0tLsKHy9ASIoueuSv3E7pkdNf6yKO7NRB5Xb4UCr3DogKziUm1qwHOFE9+XLjsLnH08bsECuL3fB4a+D8IRQqC2FiHBInpk/EmXhtHBXWhVDrQ5WLeiFzbUlgD0wZdB4z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 16:43:42.5412 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebeaa9b7-e7b7-4f3a-16d6-08de997bd295
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9350
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

Applied to drm-misc-next

On 4/10/26 20:33, Mario Limonciello wrote:
>
>
> On 4/6/26 17:05, Lizhi Hou wrote:
>> Add support for reading real-time clock frequencies through the PMF
>> interface.
>>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> ---
>>   drivers/accel/amdxdna/aie2_pci.c  |  4 +++-
>>   drivers/accel/amdxdna/aie2_pci.h  | 12 ++++++++--
>>   drivers/accel/amdxdna/aie2_pm.c   |  6 ++---
>>   drivers/accel/amdxdna/npu1_regs.c |  2 +-
>>   drivers/accel/amdxdna/npu4_regs.c | 39 +++++++++++++++++++++----------
>>   drivers/accel/amdxdna/npu5_regs.c |  4 +---
>>   drivers/accel/amdxdna/npu6_regs.c |  4 +---
>>   7 files changed, 46 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/aie2_pci.c 
>> b/drivers/accel/amdxdna/aie2_pci.c
>> index 041cbc8cd7e5..c9c23c889c78 100644
>> --- a/drivers/accel/amdxdna/aie2_pci.c
>> +++ b/drivers/accel/amdxdna/aie2_pci.c
>> @@ -284,7 +284,7 @@ static struct xrs_action_ops aie2_xrs_actions = {
>>     static void aie2_smu_fini(struct amdxdna_dev_hdl *ndev)
>>   {
>> -    ndev->priv->hw_ops.set_dpm(ndev, 0);
>> +    ndev->priv->hw_ops->set_dpm(ndev, 0);
>>       aie_smu_fini(ndev->aie.smu_hdl);
>>   }
>>   @@ -765,6 +765,7 @@ static int aie2_get_clock_metadata(struct 
>> amdxdna_client *client,
>>       if (!clock)
>>           return -ENOMEM;
>>   +    aie2_update_counters(ndev);
>>       snprintf(clock->mp_npu_clock.name, 
>> sizeof(clock->mp_npu_clock.name),
>>            "MP-NPU Clock");
>>       clock->mp_npu_clock.freq_mhz = ndev->npuclk_freq;
>> @@ -925,6 +926,7 @@ static int aie2_query_resource_info(struct 
>> amdxdna_client *client,
>>       ndev = xdna->dev_handle;
>>       priv = ndev->priv;
>>   +    aie2_update_counters(ndev);
>>       res_info.npu_clk_max = 
>> priv->dpm_clk_tbl[ndev->max_dpm_level].hclk;
>>       res_info.npu_tops_max = ndev->max_tops;
>>       res_info.npu_task_max = priv->hwctx_limit;
>> diff --git a/drivers/accel/amdxdna/aie2_pci.h 
>> b/drivers/accel/amdxdna/aie2_pci.h
>> index 7c308672b5fe..77ba125e4d72 100644
>> --- a/drivers/accel/amdxdna/aie2_pci.h
>> +++ b/drivers/accel/amdxdna/aie2_pci.h
>> @@ -201,8 +201,16 @@ struct amdxdna_dev_hdl {
>>     struct aie2_hw_ops {
>>       int (*set_dpm)(struct amdxdna_dev_hdl *ndev, u32 dpm_level);
>> +    int (*update_counters)(struct amdxdna_dev_hdl *ndev);
>>   };
>>   +#define aie2_update_counters(ndev)                \
>> +({                                \
>> +    typeof(ndev) _ndev = ndev;                \
>> +    if (_ndev->priv->hw_ops->update_counters)        \
>> + _ndev->priv->hw_ops->update_counters(_ndev);    \
>> +})
>> +
>>   enum aie2_fw_feature {
>>       AIE2_NPU_COMMAND,
>>       AIE2_PREEMPT,
>> @@ -229,7 +237,7 @@ struct amdxdna_dev_priv {
>>       struct aie_bar_off_pair        sram_offs[SRAM_MAX_INDEX];
>>       struct aie_bar_off_pair        psp_regs_off[PSP_MAX_REGS];
>>       struct aie_bar_off_pair        smu_regs_off[SMU_MAX_REGS];
>> -    struct aie2_hw_ops        hw_ops;
>> +    const struct aie2_hw_ops    *hw_ops;
>>   };
>>     extern const struct amdxdna_dev_ops aie2_ops;
>> @@ -243,7 +251,7 @@ extern const struct dpm_clk_freq 
>> npu4_dpm_clk_table[];
>>   extern const struct rt_config npu1_default_rt_cfg[];
>>   extern const struct rt_config npu4_default_rt_cfg[];
>>   extern const struct amdxdna_fw_feature_tbl npu4_fw_feature_table[];
>> -int npu4_set_dpm(struct amdxdna_dev_hdl *ndev, u32 dpm_level);
>> +extern const struct aie2_hw_ops npu4_hw_ops;
>>     /* aie2_pm.c */
>>   int aie2_pm_init(struct amdxdna_dev_hdl *ndev);
>> diff --git a/drivers/accel/amdxdna/aie2_pm.c 
>> b/drivers/accel/amdxdna/aie2_pm.c
>> index 5ec6728d04fd..786d688bd82c 100644
>> --- a/drivers/accel/amdxdna/aie2_pm.c
>> +++ b/drivers/accel/amdxdna/aie2_pm.c
>> @@ -35,7 +35,7 @@ int aie2_pm_set_dpm(struct amdxdna_dev_hdl *ndev, 
>> u32 dpm_level)
>>       if (ret)
>>           return ret;
>>   -    ret = ndev->priv->hw_ops.set_dpm(ndev, dpm_level);
>> +    ret = ndev->priv->hw_ops->set_dpm(ndev, dpm_level);
>>       if (!ret)
>>           ndev->dpm_level = dpm_level;
>>       amdxdna_pm_suspend_put(ndev->aie.xdna);
>> @@ -49,7 +49,7 @@ int aie2_pm_init(struct amdxdna_dev_hdl *ndev)
>>         if (ndev->dev_status != AIE2_DEV_UNINIT) {
>>           /* Resume device */
>> -        ret = ndev->priv->hw_ops.set_dpm(ndev, ndev->dpm_level);
>> +        ret = ndev->priv->hw_ops->set_dpm(ndev, ndev->dpm_level);
>>           if (ret)
>>               return ret;
>>   @@ -64,7 +64,7 @@ int aie2_pm_init(struct amdxdna_dev_hdl *ndev)
>>           ndev->max_dpm_level++;
>>       ndev->max_dpm_level--;
>>   -    ret = ndev->priv->hw_ops.set_dpm(ndev, ndev->max_dpm_level);
>> +    ret = ndev->priv->hw_ops->set_dpm(ndev, ndev->max_dpm_level);
>>       if (ret)
>>           return ret;
>>       ndev->dpm_level = ndev->max_dpm_level;
>> diff --git a/drivers/accel/amdxdna/npu1_regs.c 
>> b/drivers/accel/amdxdna/npu1_regs.c
>> index a83e44f378ad..f1141a65e64d 100644
>> --- a/drivers/accel/amdxdna/npu1_regs.c
>> +++ b/drivers/accel/amdxdna/npu1_regs.c
>> @@ -122,7 +122,7 @@ static const struct amdxdna_dev_priv 
>> npu1_dev_priv = {
>>           DEFINE_BAR_OFFSET(SMU_RESP_REG, NPU1_SMU, MPNPU_PUB_SCRATCH6),
>>           DEFINE_BAR_OFFSET(SMU_OUT_REG,  NPU1_SMU, MPNPU_PUB_SCRATCH7),
>>       },
>> -    .hw_ops        = {
>> +    .hw_ops        = &(const struct aie2_hw_ops) {
>>           .set_dpm = npu1_set_dpm,
>>       },
>>   };
>> diff --git a/drivers/accel/amdxdna/npu4_regs.c 
>> b/drivers/accel/amdxdna/npu4_regs.c
>> index 5d68171f4ec2..a3b6df56abd0 100644
>> --- a/drivers/accel/amdxdna/npu4_regs.c
>> +++ b/drivers/accel/amdxdna/npu4_regs.c
>> @@ -6,6 +6,7 @@
>>   #include <drm/amdxdna_accel.h>
>>   #include <drm/drm_device.h>
>>   #include <drm/gpu_scheduler.h>
>> +#include <linux/amd-pmf-io.h>
>>   #include <linux/bits.h>
>>   #include <linux/sizes.h>
>>   @@ -63,12 +64,7 @@
>>   #define NPU4_SMU_BAR_BASE    MMNPU_APERTURE4_BASE
>>   #define NPU4_SRAM_BAR_BASE    MMNPU_APERTURE1_BASE
>>   -#define NPU4_DPM_TOPS(ndev, dpm_level) \
>> -({ \
>> -    typeof(ndev) _ndev = ndev; \
>> -    (4096 * (_ndev)->total_col * \
>> -     (_ndev)->priv->dpm_clk_tbl[dpm_level].hclk / 1000000); \
>> -})
>> +#define NPU4_DPM_TOPS(ndev, hclk) (4096 * (ndev)->total_col * (hclk) 
>> / 1000000)
>>     const struct rt_config npu4_default_rt_cfg[] = {
>>       { 5, 1, AIE2_RT_CFG_INIT }, /* PDI APP LOAD MODE */
>> @@ -105,7 +101,7 @@ const struct amdxdna_fw_feature_tbl 
>> npu4_fw_feature_table[] = {
>>       { 0 }
>>   };
>>   -int npu4_set_dpm(struct amdxdna_dev_hdl *ndev, u32 dpm_level)
>> +static int npu4_set_dpm(struct amdxdna_dev_hdl *ndev, u32 dpm_level)
>>   {
>>       int ret;
>>   @@ -115,8 +111,8 @@ int npu4_set_dpm(struct amdxdna_dev_hdl *ndev, 
>> u32 dpm_level)
>>         ndev->npuclk_freq = ndev->priv->dpm_clk_tbl[dpm_level].npuclk;
>>       ndev->hclk_freq = ndev->priv->dpm_clk_tbl[dpm_level].hclk;
>> -    ndev->max_tops = NPU4_DPM_TOPS(ndev, ndev->max_dpm_level);
>> -    ndev->curr_tops = NPU4_DPM_TOPS(ndev, dpm_level);
>> +    ndev->max_tops = NPU4_DPM_TOPS(ndev, 
>> ndev->priv->dpm_clk_tbl[ndev->max_dpm_level].hclk);
>> +    ndev->curr_tops = NPU4_DPM_TOPS(ndev, ndev->hclk_freq);
>>         XDNA_DBG(ndev->aie.xdna, "MP-NPU clock %d, H clock %d\n",
>>            ndev->npuclk_freq, ndev->hclk_freq);
>> @@ -124,6 +120,27 @@ int npu4_set_dpm(struct amdxdna_dev_hdl *ndev, 
>> u32 dpm_level)
>>       return 0;
>>   }
>>   +static int npu4_update_counters(struct amdxdna_dev_hdl *ndev)
>> +{
>> +    struct amd_pmf_npu_metrics npu_metrics;
>> +    int ret;
>> +
>> +    ret = AIE2_GET_PMF_NPU_METRICS(&npu_metrics);
>> +    if (ret)
>> +        return ret;
>> +
>> +    ndev->npuclk_freq = npu_metrics.mpnpuclk_freq;
>> +    ndev->hclk_freq = npu_metrics.npuclk_freq;
>> +    ndev->curr_tops = NPU4_DPM_TOPS(ndev, ndev->hclk_freq);
>> +
>> +    return 0;
>> +}
>> +
>> +const struct aie2_hw_ops npu4_hw_ops = {
>> +    .set_dpm = npu4_set_dpm,
>> +    .update_counters = npu4_update_counters,
>> +};
>> +
>>   static const struct amdxdna_dev_priv npu4_dev_priv = {
>>       .fw_path        = "amdnpu/17f0_10/",
>>       .rt_config    = npu4_default_rt_cfg,
>> @@ -154,9 +171,7 @@ static const struct amdxdna_dev_priv 
>> npu4_dev_priv = {
>>           DEFINE_BAR_OFFSET(SMU_RESP_REG, NPU4_SMU, MP1_C2PMSG_61),
>>           DEFINE_BAR_OFFSET(SMU_OUT_REG,  NPU4_SMU, MP1_C2PMSG_60),
>>       },
>> -    .hw_ops        = {
>> -        .set_dpm = npu4_set_dpm,
>> -    },
>> +    .hw_ops        = &npu4_hw_ops
>>   };
>>     const struct amdxdna_dev_info dev_npu4_info = {
>> diff --git a/drivers/accel/amdxdna/npu5_regs.c 
>> b/drivers/accel/amdxdna/npu5_regs.c
>> index 98ee8780f3f5..6d4596b9e61e 100644
>> --- a/drivers/accel/amdxdna/npu5_regs.c
>> +++ b/drivers/accel/amdxdna/npu5_regs.c
>> @@ -92,9 +92,7 @@ static const struct amdxdna_dev_priv npu5_dev_priv = {
>>           DEFINE_BAR_OFFSET(SMU_RESP_REG, NPU5_SMU, MP1_C2PMSG_61),
>>           DEFINE_BAR_OFFSET(SMU_OUT_REG,  NPU5_SMU, MP1_C2PMSG_60),
>>       },
>> -    .hw_ops        = {
>> -        .set_dpm = npu4_set_dpm,
>> -    },
>> +    .hw_ops        = &npu4_hw_ops
>>   };
>>     const struct amdxdna_dev_info dev_npu5_info = {
>> diff --git a/drivers/accel/amdxdna/npu6_regs.c 
>> b/drivers/accel/amdxdna/npu6_regs.c
>> index 31400cca5ec4..76181345b6d1 100644
>> --- a/drivers/accel/amdxdna/npu6_regs.c
>> +++ b/drivers/accel/amdxdna/npu6_regs.c
>> @@ -92,9 +92,7 @@ static const struct amdxdna_dev_priv npu6_dev_priv = {
>>           DEFINE_BAR_OFFSET(SMU_RESP_REG, NPU6_SMU, MP1_C2PMSG_61),
>>           DEFINE_BAR_OFFSET(SMU_OUT_REG,  NPU6_SMU, MP1_C2PMSG_60),
>>       },
>> -    .hw_ops         = {
>> -        .set_dpm = npu4_set_dpm,
>> -    },
>> +    .hw_ops         = &npu4_hw_ops
>>     };
>
