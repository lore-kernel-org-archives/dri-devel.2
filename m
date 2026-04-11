Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753DCF45A12
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 03:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B89E310E167;
	Sat, 11 Apr 2026 03:33:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WKvgi6si";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011033.outbound.protection.outlook.com [40.107.208.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD69010E167
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 03:33:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e5TVX2hIuqG2ctDuh8/aj+pljuGdceWZkGfBxm6E44xwSMRfH0iu7s6FqrWzJZshUZcpior9sibGAFGiwPDdiBJtwpPgBhDT2kx3v0sAeqFz65GR5TKKISqDxWRFCHkby5WMrvS0L+cSAJ3gbAl+Zv2FsuUGpnZrUMK0wwS7S9kMtX482mCVUFjf1ygT6LB/0feCA+Mll/+6IXvGO+pQdrvEJz6WWhs0ezBE8RqT5I6XqcIq40F1/d6678EjBCftfX3U1LaRFFBXCWyhfMnlQ0UmFc9a/xniJN5BRRIvsC2WaRE1BUUD9FpJKQreMGKCEs/ShQySpZ1IwuK0u07o+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hL0WOBy+2vkIHcy4TAjIsD0ito86qVUahVmZtTVC4F4=;
 b=CXRBBBgvXIrjz8ASFV9ne78FxLjuTMNEt2ae7fOsl7REfDRsiVYnM3n5X4VUwLAscKZ7mpSA+E6u0+7NpHVJORmCNcvV6jD5+bjNi9JVJD+q1aJX6qPT6BM9+bn4zOqOTc/t9FHzXrIyy7uM6A+Np/x0bOgl7ecV40L8UFZoHngxXpDuF6yXmLRnBanoXjyb+0MHzxEKa7jPVnCviT0YpV69G6hGQjGQi6Zr2ddKbdf/D+epe8zlnSGqL+tt8OwQkJXaSEp/7oiRYpAcbZh3dhtYTgMduAqygwHlR+xW2Sp9lOT+Apglfi0QbaSSBD8QAtBTiiPIrAvt77m8snqHpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hL0WOBy+2vkIHcy4TAjIsD0ito86qVUahVmZtTVC4F4=;
 b=WKvgi6siHkaY3/qRiYvFfbVj0ixbe2GwD7LnuVCypTdXfVKv23JpeCoY8+lbMVHM+DG44omrUU13kdghOpDU8qhdb4efUX5Jd9gkIR8h+raNMAjMjCkbTn7n66k2OIyO8g/iFUKOma9aMXOMaYRtAYGcVT6PjzRN6VuckkZJ0J4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by DM4PR12MB6304.namprd12.prod.outlook.com (2603:10b6:8:a2::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.46; Sat, 11 Apr 2026 03:33:49 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9769.041; Sat, 11 Apr 2026
 03:33:49 +0000
Message-ID: <3abd1526-7991-4bfb-b772-3a695b5e1b59@amd.com>
Date: Fri, 10 Apr 2026 22:33:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Read real-time clock frequencies
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 maciej.falkowski@linux.intel.com
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com
References: <20260406220526.4027917-1-lizhi.hou@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260406220526.4027917-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0012.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::17) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|DM4PR12MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: dab2ec4d-5324-4f79-8ce1-08de977b2514
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: esWUGpMM7GLs7iBP9MDNquWiyZvVAFz5JC05x5CrgYIaYD91V1Sv9CHFN999eQoG1JqqReMPvYw7QfzmWcJMQoO/GIBfRnT0ak+naoQ+t2H8/LNZNifdRp21cQZyv55tqJssuKf7mQl9hM18bHHn4g4fEldNQpsO60qPOptQ44lCmrqAgT6bvzGHzluTGi8gdcUVSuYhGP2ja3Ke8G2yUjcojWmHUlQU2J+zxIMf010mYhDWeRgkXUHXP/2UWD48H1pYOWmlznLaaHj/aoJsyF6GfvKiku3AagdDubwYV5PWL1sLUnev98HM/jGoFxzzRKpAXySV3p23KF4DTF+9pWO5dP8uL4L5p5j9KM4nObUd4ft5bQYcfplESokH4lOD0jCGZeHoAOY07+cW1bpcC80kD5zKfXCi7KxpwgpFoDHab2euxfb5+1vlt5goK5MllpwBdipppb2KuPWVcbQaBr0Zob5tDbnGGvgTs7BAF5a4HKHxnUdS6bIwOW8ejnedwTP348hsxp3hXkDj8BRluhEUHH8Oli4PvmxsPBMluYwzjOvCn71h/teg10cr4PPr2qo0axPZMklKq40lbAfroolMBw96jit7m+8KoF7DFO3/gpXa/JSjrcIQZfvRvrXYs+xppF/tMdHjFVhkB8laz3WLkDJCv1yP4I25DpBwIPODdbV4ORseolnM6VZH91EeklZuQmcRCCHAp0Ft7mQZDHaA7Qt3UYbhjVPFAL43es8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVUxKzhaSHFlWjhaajJhSllJdllWMzhtU1g2ejBwV2laVFJBZjBBc2xUbG4x?=
 =?utf-8?B?SWRRMGhwUzQyeTJ6ZTI5QVlKUVRkeDFqdFVES1B4ZklobUN0WUdVb3hXWVBZ?=
 =?utf-8?B?d1djZG5JbEJ2RkdhWUU3eHJtSEZidGU3WGl5UjNLUW5tRTVXRHlIMmNWaHpN?=
 =?utf-8?B?S3AwL0ltMGJXaFVBb3lZOE1WaDNhbktMOXVSNWZZbm5UTUlGS3dPNHRMNnpJ?=
 =?utf-8?B?WENmdkVCK0Z5dytwejQrU000UXl3alNzOHRVb3dTUHJpZS9WdUxrU1ZwWDdy?=
 =?utf-8?B?TmdiNjhDTWpURXQvRU1FajNNZmF1K1ZPQjVDcTUxQ0o3a2w4UFA3RzJjcmVw?=
 =?utf-8?B?eFFVT0VMaW9CUFArZ2pBcU5xTVQ5bDBWSUMyQVZ6cjBUNjBwQ3JIYk5uckMv?=
 =?utf-8?B?VVZTdSt0M0N3Q1I1eVp6ZklkWnNxVkVTQ1p3ajk2VXlTckE4MGxCV0NsMGlW?=
 =?utf-8?B?YW5UUnpseTVRam1oeFFMdUpYTklMWUx3TWZlYk5qRkNKUmhtVE90U3VxMEpu?=
 =?utf-8?B?NVpjVnpWVE9FMTRxd1d4VnBkcWNsOFg0WFE2U1kxdWlTUFdOY0I0bnMwblk2?=
 =?utf-8?B?TE1ET3JQd01WUHdPZlRxQ3J4YkdFUms2aXpPQjUyTTlQb2hEcG5MUnU2S1dT?=
 =?utf-8?B?T2llZVNXUTFGVHd3cG44RmUyN1dhcXF0TSsxQXNuekQ2eGF6WXl4Tk5seVVI?=
 =?utf-8?B?aUN6Z0hzZmhuWXg3ZFdiK3doYnRQOE8vVWhzNDdSM2VHc1JmMDhUWEFJMHhN?=
 =?utf-8?B?UEpWUEZiaXhjYWJYWm5BRVhkbmdKaHBKaVQveVkxRlZXNk9yWEZqZjMzSllW?=
 =?utf-8?B?VCtuNWtxVUMwVE1VM3YyM09NV2VWc3pUdGs1dUNCY1hucTE2UENMR3dmYjNu?=
 =?utf-8?B?eUUzZU54ZWNQU2VIR2VxcHNKRHdFcGF0eDFTMWowbkFuQ29GaHU4dGNyUXZk?=
 =?utf-8?B?dXhrc2ZyM1hFMkN5T1FJWlk2dXRyZENZWW8wcGhGdGRnTzNmOWRvWjVib3J6?=
 =?utf-8?B?Yi9sckIxUFBoK3NSa3ZuZzVUbnZObXpIbHhkem42UXRFYlJmVlU1aFRhbW5w?=
 =?utf-8?B?NkpsOG5Ga0tvdUxmRTRaYW1Rcys5N3Z2QTRacWQxbDUzWjNZNzJDSjgwZmpn?=
 =?utf-8?B?RnFRNDFvZkppRVBWYXc1S0E5WnQ0djBtMFlzdzRhL0xqYUwveFlSZTBObVV5?=
 =?utf-8?B?a0tpa3IzeFBGRVQ2RzJtY3BZREk5K1RyR01ZclIzZ2cyTTJLVFQ5dE1JNElp?=
 =?utf-8?B?dXZKSWJoYlh6aHFtc2RyRGgyMjlkUzI1cnlHVTVBVmZtWGdpSHZ2Tjk0UDg3?=
 =?utf-8?B?L285Qzljb1FUL2NLbUZuZC96bFJjNEVwR2pEeElRQmdTRnFBbDV4V2JSbkV0?=
 =?utf-8?B?OWdzLzQ1dStPNW1yMlhEUzNpOHoza2NOeDlCcnJrdlB3R293Mkl6V3FqSHUx?=
 =?utf-8?B?dm9tck9wanp2OUtDQVV0RGlRMXgwbkQxN2YwdXl4K1NIOXZseUdvREF2VHJr?=
 =?utf-8?B?d3YwMElmWVlTYWtORURvQllVSXBnZFB4bjRxQUJNV2kvemxEU3hSRWRmRzNv?=
 =?utf-8?B?MzJGWnRGR0tmYU1EN1AycFBFeTJmZVhLZUl0a0VMeUt4WWxDOEVKY2pMTDhF?=
 =?utf-8?B?aktGSGxFZEhheWJYSW51R1NGcmVPUldQc0dPV3FwNktUZGpQbzJUeWxvV2Y1?=
 =?utf-8?B?b0dNN2hFWGJ3TnZtVVRZcEg2OVpOeFVuTkJDSHZOMWc3bHdRUkh3OWlVc1Zk?=
 =?utf-8?B?ZlJMUS9Seks2M3NXOHJOOGpaeU5sLzZhL2ZueHFYMGd2eTV5bW1WbDhxY29s?=
 =?utf-8?B?bHJYOGZOd3d5dXNTUG9Nc3RVbVlNamIwK1hnNG52RzJ4anV1b1NkQU5iamJv?=
 =?utf-8?B?d05ZZndJaEIvUmdQeUVKZy9aRkdwcFJTcDZtWUNrQUJmRXJkMGE0SjAybUdZ?=
 =?utf-8?B?Ti9wMzdQL001NnNtT2Y2Y0xRcXZaejFHK1dqaFpRdWZ2dFVHd0dISXNyU0Z3?=
 =?utf-8?B?UXBmTHYwQnhJa3Q4MGh5ZUduUDN5U2gwcXlLU1ZjNUlCZHd2VHAvUlJxT2dy?=
 =?utf-8?B?TVQzTjZkbzlZNUZrYU5DTlVzUHNaU0JrRHNGNHkrTGd3NnBTeVR0cnovNFhZ?=
 =?utf-8?B?M3ZpVU54WVo2VFFvekhzc0ZHUXJSN2hrMHN5SEFpbzV1QzF5UjMrSnRuanVC?=
 =?utf-8?B?UmRUZmxaWWhUTTQ3K2JLeWpaZ2FiMTh6SWdqaGVMcGlJb1M4VG16ZW1CT2dt?=
 =?utf-8?B?SythQVlzVWpuVDFwQ2VtSGxVdHhXcno4VWlCc0RhNHNMc1RwM0phOHhESStO?=
 =?utf-8?Q?Pb013/CcZe4pQpoPX2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dab2ec4d-5324-4f79-8ce1-08de977b2514
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2026 03:33:49.4129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cVZ2sHsUfa+rPwN+ecHCep9OnADgyAOg46HAz3GTwppD+awhBoKeShjxg9GEsmdnsqppMfHF7jU7uhnGxTFDdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6304
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



On 4/6/26 17:05, Lizhi Hou wrote:
> Add support for reading real-time clock frequencies through the PMF
> interface.
> 
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/accel/amdxdna/aie2_pci.c  |  4 +++-
>   drivers/accel/amdxdna/aie2_pci.h  | 12 ++++++++--
>   drivers/accel/amdxdna/aie2_pm.c   |  6 ++---
>   drivers/accel/amdxdna/npu1_regs.c |  2 +-
>   drivers/accel/amdxdna/npu4_regs.c | 39 +++++++++++++++++++++----------
>   drivers/accel/amdxdna/npu5_regs.c |  4 +---
>   drivers/accel/amdxdna/npu6_regs.c |  4 +---
>   7 files changed, 46 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
> index 041cbc8cd7e5..c9c23c889c78 100644
> --- a/drivers/accel/amdxdna/aie2_pci.c
> +++ b/drivers/accel/amdxdna/aie2_pci.c
> @@ -284,7 +284,7 @@ static struct xrs_action_ops aie2_xrs_actions = {
>   
>   static void aie2_smu_fini(struct amdxdna_dev_hdl *ndev)
>   {
> -	ndev->priv->hw_ops.set_dpm(ndev, 0);
> +	ndev->priv->hw_ops->set_dpm(ndev, 0);
>   	aie_smu_fini(ndev->aie.smu_hdl);
>   }
>   
> @@ -765,6 +765,7 @@ static int aie2_get_clock_metadata(struct amdxdna_client *client,
>   	if (!clock)
>   		return -ENOMEM;
>   
> +	aie2_update_counters(ndev);
>   	snprintf(clock->mp_npu_clock.name, sizeof(clock->mp_npu_clock.name),
>   		 "MP-NPU Clock");
>   	clock->mp_npu_clock.freq_mhz = ndev->npuclk_freq;
> @@ -925,6 +926,7 @@ static int aie2_query_resource_info(struct amdxdna_client *client,
>   	ndev = xdna->dev_handle;
>   	priv = ndev->priv;
>   
> +	aie2_update_counters(ndev);
>   	res_info.npu_clk_max = priv->dpm_clk_tbl[ndev->max_dpm_level].hclk;
>   	res_info.npu_tops_max = ndev->max_tops;
>   	res_info.npu_task_max = priv->hwctx_limit;
> diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
> index 7c308672b5fe..77ba125e4d72 100644
> --- a/drivers/accel/amdxdna/aie2_pci.h
> +++ b/drivers/accel/amdxdna/aie2_pci.h
> @@ -201,8 +201,16 @@ struct amdxdna_dev_hdl {
>   
>   struct aie2_hw_ops {
>   	int (*set_dpm)(struct amdxdna_dev_hdl *ndev, u32 dpm_level);
> +	int (*update_counters)(struct amdxdna_dev_hdl *ndev);
>   };
>   
> +#define aie2_update_counters(ndev)				\
> +({								\
> +	typeof(ndev) _ndev = ndev;				\
> +	if (_ndev->priv->hw_ops->update_counters)		\
> +		_ndev->priv->hw_ops->update_counters(_ndev);	\
> +})
> +
>   enum aie2_fw_feature {
>   	AIE2_NPU_COMMAND,
>   	AIE2_PREEMPT,
> @@ -229,7 +237,7 @@ struct amdxdna_dev_priv {
>   	struct aie_bar_off_pair		sram_offs[SRAM_MAX_INDEX];
>   	struct aie_bar_off_pair		psp_regs_off[PSP_MAX_REGS];
>   	struct aie_bar_off_pair		smu_regs_off[SMU_MAX_REGS];
> -	struct aie2_hw_ops		hw_ops;
> +	const struct aie2_hw_ops	*hw_ops;
>   };
>   
>   extern const struct amdxdna_dev_ops aie2_ops;
> @@ -243,7 +251,7 @@ extern const struct dpm_clk_freq npu4_dpm_clk_table[];
>   extern const struct rt_config npu1_default_rt_cfg[];
>   extern const struct rt_config npu4_default_rt_cfg[];
>   extern const struct amdxdna_fw_feature_tbl npu4_fw_feature_table[];
> -int npu4_set_dpm(struct amdxdna_dev_hdl *ndev, u32 dpm_level);
> +extern const struct aie2_hw_ops npu4_hw_ops;
>   
>   /* aie2_pm.c */
>   int aie2_pm_init(struct amdxdna_dev_hdl *ndev);
> diff --git a/drivers/accel/amdxdna/aie2_pm.c b/drivers/accel/amdxdna/aie2_pm.c
> index 5ec6728d04fd..786d688bd82c 100644
> --- a/drivers/accel/amdxdna/aie2_pm.c
> +++ b/drivers/accel/amdxdna/aie2_pm.c
> @@ -35,7 +35,7 @@ int aie2_pm_set_dpm(struct amdxdna_dev_hdl *ndev, u32 dpm_level)
>   	if (ret)
>   		return ret;
>   
> -	ret = ndev->priv->hw_ops.set_dpm(ndev, dpm_level);
> +	ret = ndev->priv->hw_ops->set_dpm(ndev, dpm_level);
>   	if (!ret)
>   		ndev->dpm_level = dpm_level;
>   	amdxdna_pm_suspend_put(ndev->aie.xdna);
> @@ -49,7 +49,7 @@ int aie2_pm_init(struct amdxdna_dev_hdl *ndev)
>   
>   	if (ndev->dev_status != AIE2_DEV_UNINIT) {
>   		/* Resume device */
> -		ret = ndev->priv->hw_ops.set_dpm(ndev, ndev->dpm_level);
> +		ret = ndev->priv->hw_ops->set_dpm(ndev, ndev->dpm_level);
>   		if (ret)
>   			return ret;
>   
> @@ -64,7 +64,7 @@ int aie2_pm_init(struct amdxdna_dev_hdl *ndev)
>   		ndev->max_dpm_level++;
>   	ndev->max_dpm_level--;
>   
> -	ret = ndev->priv->hw_ops.set_dpm(ndev, ndev->max_dpm_level);
> +	ret = ndev->priv->hw_ops->set_dpm(ndev, ndev->max_dpm_level);
>   	if (ret)
>   		return ret;
>   	ndev->dpm_level = ndev->max_dpm_level;
> diff --git a/drivers/accel/amdxdna/npu1_regs.c b/drivers/accel/amdxdna/npu1_regs.c
> index a83e44f378ad..f1141a65e64d 100644
> --- a/drivers/accel/amdxdna/npu1_regs.c
> +++ b/drivers/accel/amdxdna/npu1_regs.c
> @@ -122,7 +122,7 @@ static const struct amdxdna_dev_priv npu1_dev_priv = {
>   		DEFINE_BAR_OFFSET(SMU_RESP_REG, NPU1_SMU, MPNPU_PUB_SCRATCH6),
>   		DEFINE_BAR_OFFSET(SMU_OUT_REG,  NPU1_SMU, MPNPU_PUB_SCRATCH7),
>   	},
> -	.hw_ops		= {
> +	.hw_ops		= &(const struct aie2_hw_ops) {
>   		.set_dpm = npu1_set_dpm,
>   	},
>   };
> diff --git a/drivers/accel/amdxdna/npu4_regs.c b/drivers/accel/amdxdna/npu4_regs.c
> index 5d68171f4ec2..a3b6df56abd0 100644
> --- a/drivers/accel/amdxdna/npu4_regs.c
> +++ b/drivers/accel/amdxdna/npu4_regs.c
> @@ -6,6 +6,7 @@
>   #include <drm/amdxdna_accel.h>
>   #include <drm/drm_device.h>
>   #include <drm/gpu_scheduler.h>
> +#include <linux/amd-pmf-io.h>
>   #include <linux/bits.h>
>   #include <linux/sizes.h>
>   
> @@ -63,12 +64,7 @@
>   #define NPU4_SMU_BAR_BASE	MMNPU_APERTURE4_BASE
>   #define NPU4_SRAM_BAR_BASE	MMNPU_APERTURE1_BASE
>   
> -#define NPU4_DPM_TOPS(ndev, dpm_level) \
> -({ \
> -	typeof(ndev) _ndev = ndev; \
> -	(4096 * (_ndev)->total_col * \
> -	 (_ndev)->priv->dpm_clk_tbl[dpm_level].hclk / 1000000); \
> -})
> +#define NPU4_DPM_TOPS(ndev, hclk) (4096 * (ndev)->total_col * (hclk) / 1000000)
>   
>   const struct rt_config npu4_default_rt_cfg[] = {
>   	{ 5, 1, AIE2_RT_CFG_INIT }, /* PDI APP LOAD MODE */
> @@ -105,7 +101,7 @@ const struct amdxdna_fw_feature_tbl npu4_fw_feature_table[] = {
>   	{ 0 }
>   };
>   
> -int npu4_set_dpm(struct amdxdna_dev_hdl *ndev, u32 dpm_level)
> +static int npu4_set_dpm(struct amdxdna_dev_hdl *ndev, u32 dpm_level)
>   {
>   	int ret;
>   
> @@ -115,8 +111,8 @@ int npu4_set_dpm(struct amdxdna_dev_hdl *ndev, u32 dpm_level)
>   
>   	ndev->npuclk_freq = ndev->priv->dpm_clk_tbl[dpm_level].npuclk;
>   	ndev->hclk_freq = ndev->priv->dpm_clk_tbl[dpm_level].hclk;
> -	ndev->max_tops = NPU4_DPM_TOPS(ndev, ndev->max_dpm_level);
> -	ndev->curr_tops = NPU4_DPM_TOPS(ndev, dpm_level);
> +	ndev->max_tops = NPU4_DPM_TOPS(ndev, ndev->priv->dpm_clk_tbl[ndev->max_dpm_level].hclk);
> +	ndev->curr_tops = NPU4_DPM_TOPS(ndev, ndev->hclk_freq);
>   
>   	XDNA_DBG(ndev->aie.xdna, "MP-NPU clock %d, H clock %d\n",
>   		 ndev->npuclk_freq, ndev->hclk_freq);
> @@ -124,6 +120,27 @@ int npu4_set_dpm(struct amdxdna_dev_hdl *ndev, u32 dpm_level)
>   	return 0;
>   }
>   
> +static int npu4_update_counters(struct amdxdna_dev_hdl *ndev)
> +{
> +	struct amd_pmf_npu_metrics npu_metrics;
> +	int ret;
> +
> +	ret = AIE2_GET_PMF_NPU_METRICS(&npu_metrics);
> +	if (ret)
> +		return ret;
> +
> +	ndev->npuclk_freq = npu_metrics.mpnpuclk_freq;
> +	ndev->hclk_freq = npu_metrics.npuclk_freq;
> +	ndev->curr_tops = NPU4_DPM_TOPS(ndev, ndev->hclk_freq);
> +
> +	return 0;
> +}
> +
> +const struct aie2_hw_ops npu4_hw_ops = {
> +	.set_dpm = npu4_set_dpm,
> +	.update_counters = npu4_update_counters,
> +};
> +
>   static const struct amdxdna_dev_priv npu4_dev_priv = {
>   	.fw_path        = "amdnpu/17f0_10/",
>   	.rt_config	= npu4_default_rt_cfg,
> @@ -154,9 +171,7 @@ static const struct amdxdna_dev_priv npu4_dev_priv = {
>   		DEFINE_BAR_OFFSET(SMU_RESP_REG, NPU4_SMU, MP1_C2PMSG_61),
>   		DEFINE_BAR_OFFSET(SMU_OUT_REG,  NPU4_SMU, MP1_C2PMSG_60),
>   	},
> -	.hw_ops		= {
> -		.set_dpm = npu4_set_dpm,
> -	},
> +	.hw_ops		= &npu4_hw_ops
>   };
>   
>   const struct amdxdna_dev_info dev_npu4_info = {
> diff --git a/drivers/accel/amdxdna/npu5_regs.c b/drivers/accel/amdxdna/npu5_regs.c
> index 98ee8780f3f5..6d4596b9e61e 100644
> --- a/drivers/accel/amdxdna/npu5_regs.c
> +++ b/drivers/accel/amdxdna/npu5_regs.c
> @@ -92,9 +92,7 @@ static const struct amdxdna_dev_priv npu5_dev_priv = {
>   		DEFINE_BAR_OFFSET(SMU_RESP_REG, NPU5_SMU, MP1_C2PMSG_61),
>   		DEFINE_BAR_OFFSET(SMU_OUT_REG,  NPU5_SMU, MP1_C2PMSG_60),
>   	},
> -	.hw_ops		= {
> -		.set_dpm = npu4_set_dpm,
> -	},
> +	.hw_ops		= &npu4_hw_ops
>   };
>   
>   const struct amdxdna_dev_info dev_npu5_info = {
> diff --git a/drivers/accel/amdxdna/npu6_regs.c b/drivers/accel/amdxdna/npu6_regs.c
> index 31400cca5ec4..76181345b6d1 100644
> --- a/drivers/accel/amdxdna/npu6_regs.c
> +++ b/drivers/accel/amdxdna/npu6_regs.c
> @@ -92,9 +92,7 @@ static const struct amdxdna_dev_priv npu6_dev_priv = {
>   		DEFINE_BAR_OFFSET(SMU_RESP_REG, NPU6_SMU, MP1_C2PMSG_61),
>   		DEFINE_BAR_OFFSET(SMU_OUT_REG,  NPU6_SMU, MP1_C2PMSG_60),
>   	},
> -	.hw_ops         = {
> -		.set_dpm = npu4_set_dpm,
> -	},
> +	.hw_ops         = &npu4_hw_ops
>   
>   };
>   

