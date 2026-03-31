Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CB91061B2B
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 02:45:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2986310E1D0;
	Tue, 31 Mar 2026 02:45:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jjpCb+0d";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012071.outbound.protection.outlook.com
 [40.107.200.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 819D110E1D0
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 02:45:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ex9Q5idkdKCowRcYhnlVjhPbqHSAkwNBzIINdUiMGNnruTB6VVDEMOYh7HelGqiLIswpDrD+BVxccJ99g9pfUSVNpSif90PLBYvBh5lf7E3/q/JG7TjN6SWxUXAjnF8eC4njU0FBuo1QHoE43qeb5EbkvmHYlut3jHe723cfDqaQkgsKhS0dMqG292GCx8e5fHvoilYMhfQCKYkldo2Q1WbQQwz8QTFFhlWm6xM8DAq9Udcy/KKhtV4C0USvLbyOqtIhUIcTvV6NIO6uregofXcl7JA0fFlnT5qoHzLVT1UakU7K27jEyDsyxsEaM8mXHpXYSTDw2TEhq9qi74ebYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6H6dw0dDg2lWw7VlCu9adg9NCcbhOTuO60LMZ8jqZo=;
 b=mGcYo/86p+LbXXSYTS/uiwMnvk+kbOu2e1svTwFEpVv17r17WVm9OiW0VqgKpe4fZKTQBtHt56ytgUCupkwg+nklJ0by7VNAlSZGsMVhrx7RNXbzbTjmLCj3PF/oIZNx9dnOpDbuZ/T92w0/76FM4DXqr1PpG71m411wXTyOn/WaL75Nn/Ykd86bynRHhJ/BGi1ILCFoYehNW5QH4UR3yPMXOQXUa2Ta/EHdn6rpbOuP433qirO0AfSg/j4ZWY5+6EqsAdnlR0ygK3LQTmJWqUxfeMyJfcq3PMWjXoOsunT/1qj92Swarfa7zF1KBFlnMTuyfc+/nkega9MEDunImA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6H6dw0dDg2lWw7VlCu9adg9NCcbhOTuO60LMZ8jqZo=;
 b=jjpCb+0dHCAfqsp6BWTzOU8EfmRLT7PZGLHbSoip/uGiLzh+lGC9/VoMCQXKo4svauJDhK0VBh3PbJ+K/UfWSwv+xbtgmgBM5ZmP8j4XNJQIinDct6UmT/wsqyglfWMgnJah+s9CJbIEGFXlFnQ0zhGjjV3Zy1sMp8nmpMtH7Uo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by DM4PR12MB8449.namprd12.prod.outlook.com (2603:10b6:8:17f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 02:45:44 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 02:45:43 +0000
Message-ID: <0d5d0bdf-3a2a-4217-9552-1cd56210cbb2@amd.com>
Date: Mon, 30 Mar 2026 21:45:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 4/6] accel/amdxdna: Add AIE4 firmware loading
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 maciej.falkowski@linux.intel.com
Cc: David Zhang <yidong.zhang@amd.com>, linux-kernel@vger.kernel.org,
 max.zhen@amd.com, sonal.santan@amd.com,
 Hayden Laccabue <Hayden.Laccabue@amd.com>
References: <20260330163705.3153647-1-lizhi.hou@amd.com>
 <20260330163705.3153647-5-lizhi.hou@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260330163705.3153647-5-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN1PR14CA0023.namprd14.prod.outlook.com
 (2603:10b6:408:e3::28) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|DM4PR12MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: 9183f59f-9b8b-4141-f1da-08de8ecf9a97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 0DwXPGwJuJqrV5cy9zl77Y+47IAK+OGznew+f75dTyJyIiNik+B7+xwBqyJZsBjyqpBImjzTkI3MxbUQdRmfgkw3a2m9P48F0Q6Mm0ds1e6qjBdO4ER/5PFkwoNi6WuuoBjgsFS6ZgCnmBe9x1hcrmXKfq/f4p80SsngR3v0IFws0NMVcmu/iMZ3VuSbknKGitKNPOyk4OQRqr6Xb5AJILJ64Vr3sK54/Q5FbS86p3ug7RPCcVGMNdU/ffTSs3hoTtcl8di1Q5YN+Xl2sKbdVU62JpuiaECzSVtFgl2rIlHX+f+xQz6I+KJTpUF7nP0bJjk2XxjpF26SrPDm3KPKL/TePf/bcagIxMQ33MmaByeCbquhLJXySOqPDUaMe+8qVVtlPWUuctgh+/2oFgJehLWaLzLkukpGI14orOy6P1NnAzdbHhwd/6WsNnLfZ477CcNFMoqGAy947RsbaAnjDdy4hEtvpxRDi66teaydNGk+nSKjF4hdWGGpO/j7K5EQQ/l7Vkdwx2hZaG+KtmydmlqfVmSF3Ue/EWsKO6t8znaGITqqqqZk+CF3CRbpDQ6untKiHRImPDdiiJj03lZkksZVGExsFFWAFFYGiW9Zxt/SIFRczapHkGssnI8f8laF5G4U7Sl9/QOYTEYN9m0+3mjih+zgcQyU2l09ZRjXIx/nCKHO3EWqNarYzOkW9Jsu10g2FTi88LTKqD+4ijozez5+/2crDt+txBeprtgkRMI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzZoZkY1Z1BJdllKMUlTL1VuWU5udnhuems0ZE9tcGNGZ0xDN3F1WjVyK3pV?=
 =?utf-8?B?MkpDVERpWTYzNmJ0RitoR2xWVGo2WWs4dkZaMVd3Zm45ZkI3RUlNNnlDU0Nq?=
 =?utf-8?B?QzgvZEI2VVR6cVlBVFhOMXU2Yi85TTdZZmtjYnkzU0M5b3FZQjNPRXJXVEVG?=
 =?utf-8?B?VFJjV21TTlptN1VxbmhzRmRudXp2cWVSa3M1eW13d3dzZDB3TExQSmNaU2Rn?=
 =?utf-8?B?eDh2Y3N4TkJoZjhjeVNuYmcwM05ieEFudDkxQWtId3VGeTNickpMVjl5d1F6?=
 =?utf-8?B?aElvRnlMamUyZ0pmM2dlOFJLdDdFVVk2ckh5MlpNaWRmczA0ZkY5THdRb3Jh?=
 =?utf-8?B?SHBpR2xHM0pyZzAvUStwaDFtZGZqeVZMdjdjcVY5Uko5cGNsUGIwc2Y1dVRn?=
 =?utf-8?B?ekVSSEs4RFhpc240SDNjQWVia3BLRHg3TXRaOXpZS2lxRFYzclcrYmEzL0h3?=
 =?utf-8?B?ZHNvbXduMlJSUWhMUnZpVG5wSUd0bmFockV4R1c2SVF6dW0yZEhNaHpicjl3?=
 =?utf-8?B?VWFYN05QeE1EYlJLTHBnTkFHeUt6eWhCSHBLNHVQSzVJb0hUbjBuMGc3ZjlJ?=
 =?utf-8?B?Z3JqUEhhWm5Sdk5IaXJUd1F5ZnEzWGJhTmZZeWsrSjRCRVE3RFVPWWhnb1J0?=
 =?utf-8?B?amZxWVZiK1lGcDBwcXRaNDIyVjJCM1VsM0hIaVdjeGM4S0VWQzRzb2V5TDJZ?=
 =?utf-8?B?YTJ1ZHBDd0lRajdtaGc5QUF3QXpzd0ZTZ0xldTQ1YjZIZG5UL29Ia2pycXpx?=
 =?utf-8?B?czRkNXFFcUk3VjdyS01BS3ZvOXRtQ2QrL280NVlmUUEwS3VNczBJVzFrQysw?=
 =?utf-8?B?MEJOemQ2S3RHYWh1KzIzZWpoeFZZRDJhZmF6TEdvRG5xVlNHdmtFNjZVSy9G?=
 =?utf-8?B?VU1lMVRSN09zeU9VWmIyMFhpU0lwMFppZ0RGWm5leUtsbldjY3NPVFh5NlRO?=
 =?utf-8?B?WVJld29BenZXbUw3S1U2SS9vVm9rRCsyZ3UvNFNOYUZ3dTFMRktvbEZjK29I?=
 =?utf-8?B?UkhsSmdHZWVlS3dKY0lDSWxoaDI3V090NHBSZ1VkYUlRSjlYUFJhaUh2Y1Nk?=
 =?utf-8?B?MjNsbTY2aytxMVI2MlJGNWdLYlAxU2VNMmFNRFNJZ2N0MDhKZFNUT3NSbjdV?=
 =?utf-8?B?SDFtNzBjVjN5dGFmbDRsYkxQNjQ3WDBOeDhidEdKVnAvMC92U3FDemhXRjdE?=
 =?utf-8?B?Q3M1MHdESU1FczlsK09IdmxabWZKUFBuM21kb0xZdk5DV2ovckgxb0dhTjJN?=
 =?utf-8?B?b2U1enZ4S0RqNlRGaVFHMWIrYkR0cnFxQ21BZWZsQjljRnZTQ1YwWlNPdlFs?=
 =?utf-8?B?L2plb1d1UnFDTUpWUTRTY1pwMjQzUGVwOUo1RnhVSXEyY3lXN3A0STRpRCtQ?=
 =?utf-8?B?ZEJ2bFVzTWpYWkRkakdEQ2JJTld1b0pJMWxTOHg2M210akQ3M2tYb1VFd1lD?=
 =?utf-8?B?WGlFTEluUjRlVVAxWENiQlZGL0tCVUNPQktFNWNXZzl5Q0JjUFpyRmpsRElz?=
 =?utf-8?B?ZVJ1cDdzQjkvSDlldEo5RFhuZzdzeXNZMG1EMHZkcE53NG45cWNzU2YrdGtE?=
 =?utf-8?B?NU00NVdZempoQnZoZTVTMEJjTzFFQWNReW0vVXZFckFxSmphbzRlMldSU3Rv?=
 =?utf-8?B?NTFXekJGRkhRUHBiWi82WHZaLys0bGgxZVZWcnArK0lJTVFxS05mY1M0cFBx?=
 =?utf-8?B?MitFRm1JbDZoaC9PM1JUK1Z5NlF1bjUxcUpqZHZpZ1ZOVVl2NEVFVUxWdkFq?=
 =?utf-8?B?Tjk4MXhQU3VCb29kMlBhZlk5NmR3NGNodzBJZm8xNTdsd0VnK1pIcU1Fd25E?=
 =?utf-8?B?M1dIRG11cGlIMWNzbVN4ZjF3a2c1Z0J5TzJhRHJ4dFF4RENLbXRqL0JUTHRn?=
 =?utf-8?B?YzZzU3pRT3dTQVhSYTdUQVl1aXdacnRHMWdEQjZscm5rVVF1b3BZZWZ0ZnVs?=
 =?utf-8?B?UGhCZXAyZUI0ZHZ6ZjlQcUkzdVZMdnUxVGxhVkk0UmF6ZG8wRTNMT0RGSmpx?=
 =?utf-8?B?eG4yQnhCYlgzRVRuaUd0eEQ3QitTdTBZWVFYd3BkYW9CU0lDYVAxRmZ1WEJO?=
 =?utf-8?B?MU9aamUvdkZ6eUlRT05hNWNrZ29LVWVWQzNxR3p4NTkyU3kxVHptbnZoMlhW?=
 =?utf-8?B?bUJUaU51WVN4aGJqd1NXa0xZNXdwQWpPYmd1cGRSNmY0VTdreWVOb25oQ1lC?=
 =?utf-8?B?RTd4TmFYOTlva2xMeGRnVkt4aVBZZDBkQ1J4Zm5OZDlrb21jZVliZUtBSWpN?=
 =?utf-8?B?UXZlZnMvZ09qdjVpdFg4Q2IyaFBiaGhia2NaNnNIWWVMTmNudTNzRUlmeXpq?=
 =?utf-8?Q?nyKWWJlYKC9JtplaVT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9183f59f-9b8b-4141-f1da-08de8ecf9a97
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 02:45:43.7808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8etuCIqw00mlQCveqD2c9miRepkJ8IS1DDvbOsDII2T7zhig31nzOkq4uOXtjl/f00Ijc1l9qzwtY7rFAQn/bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8449
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



On 3/30/26 11:37, Lizhi Hou wrote:
> From: David Zhang <yidong.zhang@amd.com>
> 
> Add support for loading AIE4 firmware through the common PSP
> interfaces.
> 
> Compared to AIE2, AIE4 introduces an additional CERT firmware image.
> aiem_psp_create() performs CERT setup when the CERT image size is
> non-zero.
> 
> Co-developed-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
> Signed-off-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
> Signed-off-by: David Zhang <yidong.zhang@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>   drivers/accel/amdxdna/aie.h       |   4 +
>   drivers/accel/amdxdna/aie2_pci.c  |   2 +
>   drivers/accel/amdxdna/aie4_pci.c  | 109 ++++++++++++++++++++++-
>   drivers/accel/amdxdna/aie4_pci.h  |   4 +
>   drivers/accel/amdxdna/aie_psp.c   | 141 +++++++++++++++++++++++-------
>   drivers/accel/amdxdna/npu3_regs.c |  23 +++++
>   6 files changed, 247 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/aie.h b/drivers/accel/amdxdna/aie.h
> index 124c0f7e9ca0..423ed34af9ee 100644
> --- a/drivers/accel/amdxdna/aie.h
> +++ b/drivers/accel/amdxdna/aie.h
> @@ -57,7 +57,11 @@ struct aie_bar_off_pair {
>   struct psp_config {
>   	const void		*fw_buf;
>   	u32			fw_size;
> +	const void              *certfw_buf;
> +	u32                     certfw_size;
>   	void __iomem		*psp_regs[PSP_MAX_REGS];
> +	u32			arg2_mask;
> +	u32			notify_val;
>   };
>   
>   /* aie.c */
> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
> index e4b7893bd429..0489e668cd73 100644
> --- a/drivers/accel/amdxdna/aie2_pci.c
> +++ b/drivers/accel/amdxdna/aie2_pci.c
> @@ -549,6 +549,8 @@ static int aie2_init(struct amdxdna_dev *xdna)
>   
>   	psp_conf.fw_size = fw->size;
>   	psp_conf.fw_buf = fw->data;
> +	psp_conf.arg2_mask = GENMASK(23, 0);
> +	psp_conf.notify_val = 1;
>   	for (i = 0; i < PSP_MAX_REGS; i++)
>   		psp_conf.psp_regs[i] = tbl[PSP_REG_BAR(ndev, i)] + PSP_REG_OFF(ndev, i);
>   	ndev->aie.psp_hdl = aiem_psp_create(&xdna->ddev, &psp_conf);
> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
> index 0f360c1ccebd..e7993b315996 100644
> --- a/drivers/accel/amdxdna/aie4_pci.c
> +++ b/drivers/accel/amdxdna/aie4_pci.c
> @@ -6,11 +6,15 @@
>   #include <drm/amdxdna_accel.h>
>   #include <drm/drm_managed.h>
>   #include <drm/drm_print.h>
> +#include <linux/firmware.h>
> +#include <linux/sizes.h>
>   
>   #include "aie4_pci.h"
>   #include "amdxdna_pci_drv.h"
>   
> -#define NO_IOHUB	0
> +#define NO_IOHUB		0
> +#define CERTFW_MAX_SIZE         (SZ_32K + SZ_256)
> +#define PSP_NOTIFY_INTR		0xD007BE11
>   
>   /*
>    * The management mailbox channel is allocated by firmware.
> @@ -207,13 +211,12 @@ static int aie4_mailbox_init(struct amdxdna_dev *xdna)
>   
>   static void aie4_fw_unload(struct amdxdna_dev_hdl *ndev)
>   {
> -	/* TODO */
> +	aie_psp_stop(ndev->aie.psp_hdl);
>   }
>   
>   static int aie4_fw_load(struct amdxdna_dev_hdl *ndev)
>   {
> -	/* TODO */
> -	return 0;
> +	return aie_psp_start(ndev->aie.psp_hdl);
>   }
>   
>   static int aie4_hw_start(struct amdxdna_dev *xdna)
> @@ -261,11 +264,98 @@ static void aie4_hw_stop(struct amdxdna_dev *xdna)
>   	aie4_fw_unload(ndev);
>   }
>   
> +static int aie4_request_firmware(struct amdxdna_dev_hdl *ndev,
> +				 const struct firmware **npufw,
> +				 const struct firmware **certfw)
> +{
> +	struct amdxdna_dev *xdna = ndev->aie.xdna;
> +	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
> +	char fw_name[128];
> +	int ret;
> +
> +	ret = snprintf(fw_name, sizeof(fw_name), "amdnpu/%04x_%02x/%s",
> +		       pdev->device, pdev->revision, ndev->priv->npufw_path);
> +	if (ret >= sizeof(fw_name)) {
> +		XDNA_ERR(xdna, "npu firmware path is truncated");
> +		return -EINVAL;
> +	}
> +
> +	ret = request_firmware(npufw, fw_name, &pdev->dev);
> +	if (ret) {
> +		XDNA_ERR(xdna, "failed to request_firmware %s, ret %d", fw_name, ret);
> +		return ret;
> +	}
> +
> +	ret = snprintf(fw_name, sizeof(fw_name), "amdnpu/%04x_%02x/%s",
> +		       pdev->device, pdev->revision, ndev->priv->certfw_path);
> +	if (ret >= sizeof(fw_name)) {
> +		XDNA_ERR(xdna, "cert firmware path is truncated");
> +		ret = -EINVAL;
> +		goto release_npufw;
> +	}
> +
> +	ret = request_firmware(certfw, fw_name, &pdev->dev);
> +	if (ret) {
> +		XDNA_ERR(xdna, "failed to request_firmware %s, ret %d", fw_name, ret);
> +		goto release_npufw;
> +	}
> +
> +	if ((*certfw)->size > CERTFW_MAX_SIZE) {
> +		XDNA_ERR(xdna, "CERTFW over maximum size of 32 KB + 256 B");
> +		ret = -EINVAL;
> +		goto release_certfw;
> +	}

Should there be a similar size check for NPU FW?  Not sure why it would 
only be done for Cert FW.

> +
> +	return 0;
> +
> +release_certfw:
> +	release_firmware(*certfw);
> +release_npufw:
> +	release_firmware(*npufw);
> +
> +	return ret;
> +}
> +
> +static void aie4_release_firmware(struct amdxdna_dev_hdl *ndev,
> +				  const struct firmware *npufw,
> +				  const struct firmware *certfw)
> +{
> +	release_firmware(certfw);
> +	release_firmware(npufw);
> +}
> +
> +static int aie4_prepare_firmware(struct amdxdna_dev_hdl *ndev,
> +				 const struct firmware *npufw,
> +				 const struct firmware *certfw,
> +				 void __iomem *tbl[PCI_NUM_RESOURCES])
> +{
> +	struct amdxdna_dev *xdna = ndev->aie.xdna;
> +	struct psp_config psp_conf;
> +	int i;
> +
> +	psp_conf.fw_size = npufw->size;
> +	psp_conf.fw_buf = npufw->data;
> +	psp_conf.certfw_size = certfw->size;
> +	psp_conf.certfw_buf = certfw->data;
> +	psp_conf.arg2_mask = ~0;
> +	psp_conf.notify_val = PSP_NOTIFY_INTR;
> +	for (i = 0; i < PSP_MAX_REGS; i++)
> +		psp_conf.psp_regs[i] = tbl[PSP_REG_BAR(ndev, i)] + PSP_REG_OFF(ndev, i);
> +	ndev->aie.psp_hdl = aiem_psp_create(&xdna->ddev, &psp_conf);
> +	if (!ndev->aie.psp_hdl) {
> +		XDNA_ERR(xdna, "failed to create psp");
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
>   static int aie4_pcidev_init(struct amdxdna_dev_hdl *ndev)
>   {
>   	struct amdxdna_dev *xdna = ndev->aie.xdna;
>   	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
>   	void __iomem *tbl[PCI_NUM_RESOURCES] = {0};
> +	const struct firmware *npufw, *certfw;
>   	unsigned long bars = 0;
>   	int ret, i;
>   
> @@ -282,6 +372,8 @@ static int aie4_pcidev_init(struct amdxdna_dev_hdl *ndev)
>   		return ret;
>   	}
>   
> +	for (i = 0; i < PSP_MAX_REGS; i++)
> +		set_bit(PSP_REG_BAR(ndev, i), &bars);
>   	set_bit(xdna->dev_info->mbox_bar, &bars);
>   	set_bit(xdna->dev_info->sram_bar, &bars);
>   
> @@ -300,6 +392,15 @@ static int aie4_pcidev_init(struct amdxdna_dev_hdl *ndev)
>   
>   	pci_set_master(pdev);
>   
> +	ret = aie4_request_firmware(ndev, &npufw, &certfw);
> +	if (ret)
> +		goto clear_master;
> +
> +	ret = aie4_prepare_firmware(ndev, npufw, certfw, tbl);
> +	aie4_release_firmware(ndev, npufw, certfw);
> +	if (ret)
> +		goto clear_master;
> +
>   	ret = aie4_irq_init(xdna);
>   	if (ret)
>   		goto clear_master;
> diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
> index f3810a969431..ee388ccf7196 100644
> --- a/drivers/accel/amdxdna/aie4_pci.h
> +++ b/drivers/accel/amdxdna/aie4_pci.h
> @@ -14,9 +14,13 @@
>   #include "amdxdna_mailbox.h"
>   
>   struct amdxdna_dev_priv {
> +	const char              *npufw_path;
> +	const char              *certfw_path;
>   	u32			mbox_bar;
>   	u32			mbox_rbuf_bar;
>   	u64			mbox_info_off;
> +
> +	struct aie_bar_off_pair	psp_regs_off[PSP_MAX_REGS];
>   };
>   
>   struct amdxdna_dev_hdl {
> diff --git a/drivers/accel/amdxdna/aie_psp.c b/drivers/accel/amdxdna/aie_psp.c
> index 8743b812a449..458dca7cc5a0 100644
> --- a/drivers/accel/amdxdna/aie_psp.c
> +++ b/drivers/accel/amdxdna/aie_psp.c
> @@ -18,6 +18,7 @@
>   #define PSP_VALIDATE		1
>   #define PSP_START		2
>   #define PSP_RELEASE_TMR		3
> +#define PSP_VALIDATE_CERT       4
>   
>   /* PSP special arguments */
>   #define PSP_START_COPY_FW	1
> @@ -27,10 +28,20 @@
>   #define PSP_ERROR_BAD_STATE	0xFFFF0007
>   
>   #define PSP_FW_ALIGN		0x10000
> +#define PSP_CFW_ALIGN           0x8000
>   #define PSP_POLL_INTERVAL	20000	/* us */
>   #define PSP_POLL_TIMEOUT	1000000	/* us */
>   
> -#define PSP_REG(p, reg) ((p)->psp_regs[reg])
> +#define PSP_REG(p, reg) ((p)->conf.psp_regs[reg])
> +#define PSP_SET_CMD(psp, reg_vals, cmd, arg0, arg1, arg2)		\
> +({									\
> +	u32 *_regs = reg_vals;						\
> +	u32 _cmd = cmd;							\
> +	_regs[0] = _cmd;						\
> +	_regs[1] = arg0;						\
> +	_regs[2] = arg1;						\
> +	_regs[3] = ((arg2) | ((_cmd) << 24)) & (psp)->conf.arg2_mask;	\
> +})
>   

For AIE4, arg2_mask is set to ~0 (0xFFFFFFFF), which means the full
32-bit value including cmd<<24 is preserved.

If arg2 uses bits 24-31, the OR operation could corrupt the cmd field. 
For example:

   arg2 = 0x02000000 (32MB firmware size, bit 25 set)
   cmd = 1 (PSP_VALIDATE)
   _regs[3] = (0x02000000 | 0x01000000) & 0xFFFFFFFF
            = 0x03000000

This puts cmd=3 instead of cmd=1 in bits 24-31, while the size field
in bits 0-23 becomes 0 instead of the intended value.

Should arg2 be masked before the OR to ensure it only uses bits 0-23?

   _regs[3] = ((arg2 & 0x00FFFFFF) | (_cmd << 24)) & (psp)->conf.arg2_mask;

This would prevent arg2 from corrupting the cmd field on AIE4 while
maintaining backward compatibility with AIE2 (which masks out the cmd
bits anyway).


>   struct psp_device {
>   	struct drm_device	*ddev;
> @@ -38,7 +49,9 @@ struct psp_device {
>   	u32			fw_buf_sz;
>   	u64			fw_paddr;
>   	void			*fw_buffer;
> -	void __iomem		*psp_regs[PSP_MAX_REGS];
> +	u32                     certfw_buf_sz;
> +	u64                     certfw_paddr;
> +	void                    *certfw_buffer;
>   };
>   
>   static int psp_exec(struct psp_device *psp, u32 *reg_vals)
> @@ -47,13 +60,22 @@ static int psp_exec(struct psp_device *psp, u32 *reg_vals)
>   	int ret, i;
>   	u32 ready;
>   
> +	/* Check for PSP ready before any write */
> +	ret = readx_poll_timeout(readl, PSP_REG(psp, PSP_STATUS_REG), ready,
> +				 FIELD_GET(PSP_STATUS_READY, ready),
> +				 PSP_POLL_INTERVAL, PSP_POLL_TIMEOUT);
> +	if (ret) {
> +		drm_err(psp->ddev, "PSP is not ready, ret 0x%x", ret);
> +		return ret;
> +	}
> +
>   	/* Write command and argument registers */
>   	for (i = 0; i < PSP_NUM_IN_REGS; i++)
>   		writel(reg_vals[i], PSP_REG(psp, i));
>   
>   	/* clear and set PSP INTR register to kick off */
>   	writel(0, PSP_REG(psp, PSP_INTR_REG));
> -	writel(1, PSP_REG(psp, PSP_INTR_REG));
> +	writel(psp->conf.notify_val, PSP_REG(psp, PSP_INTR_REG));
>   
>   	/* PSP should be busy. Wait for ready, so we know task is done. */
>   	ret = readx_poll_timeout(readl, PSP_REG(psp, PSP_STATUS_REG), ready,
> @@ -90,69 +112,124 @@ int aie_psp_waitmode_poll(struct psp_device *psp)
>   
>   void aie_psp_stop(struct psp_device *psp)
>   {
> -	u32 reg_vals[PSP_NUM_IN_REGS] = { PSP_RELEASE_TMR, };
> +	u32 reg_vals[PSP_NUM_IN_REGS];
>   	int ret;
>   
> +	PSP_SET_CMD(psp, reg_vals, PSP_RELEASE_TMR, 0, 0, 0);
> +
>   	ret = psp_exec(psp, reg_vals);
>   	if (ret)
>   		drm_err(psp->ddev, "release tmr failed, ret %d", ret);
>   }
>   
> -int aie_psp_start(struct psp_device *psp)
> +static int psp_validate_fw(struct psp_device *psp, u8 cmd, u64 paddr, u32 buf_sz)
>   {
>   	u32 reg_vals[PSP_NUM_IN_REGS];
>   	int ret;
>   
> -	reg_vals[0] = PSP_VALIDATE;
> -	reg_vals[1] = lower_32_bits(psp->fw_paddr);
> -	reg_vals[2] = upper_32_bits(psp->fw_paddr);
> -	reg_vals[3] = psp->fw_buf_sz;
> +	PSP_SET_CMD(psp, reg_vals, cmd, lower_32_bits(paddr),
> +		    upper_32_bits(paddr), buf_sz);
>   
>   	ret = psp_exec(psp, reg_vals);
> -	if (ret) {
> +	if (ret)
>   		drm_err(psp->ddev, "failed to validate fw, ret %d", ret);
> -		return ret;
> -	}
>   
> -	memset(reg_vals, 0, sizeof(reg_vals));
> -	reg_vals[0] = PSP_START;
> -	reg_vals[1] = PSP_START_COPY_FW;
> +	return ret;
> +}
> +
> +static int psp_start(struct psp_device *psp)
> +{
> +	u32 reg_vals[PSP_NUM_IN_REGS];
> +	int ret;
> +
> +	PSP_SET_CMD(psp, reg_vals, PSP_START, PSP_START_COPY_FW, 0, 0);
> +
>   	ret = psp_exec(psp, reg_vals);
> -	if (ret) {
> +	if (ret)
>   		drm_err(psp->ddev, "failed to start fw, ret %d", ret);
> +
> +	return ret;
> +}
> +
> +int aie_psp_start(struct psp_device *psp)
> +{
> +	int ret;
> +
> +	ret = psp_validate_fw(psp, PSP_VALIDATE,
> +			      psp->fw_paddr, psp->fw_buf_sz);
> +	if (ret)
>   		return ret;
> -	}
>   
> -	return 0;
> +	if (!psp->certfw_buf_sz)
> +		goto psp_start;
> +
> +	ret = psp_validate_fw(psp, PSP_VALIDATE_CERT,
> +			      psp->certfw_paddr, psp->certfw_buf_sz);
> +	if (ret)
> +		return ret;
> +psp_start:
> +	return psp_start(psp);
> +}
> +
> +/*
> + * PSP requires host physical address to load firmware.
> + * Allocate a buffer, obtain its physical address, align, and copy data in.
> + */
> +static void *psp_alloc_fw_buf(struct psp_device *psp, const void *fw_data,
> +			      u32 fw_size, u32 align, u32 *buf_sz,
> +			      u64 *paddr)
> +{
> +	u32 alloc_sz;
> +	void *buffer;
> +	u64 offset;
> +
> +	*buf_sz = ALIGN(fw_size, align);
> +	alloc_sz = *buf_sz + align;
> +
> +	buffer = drmm_kmalloc(psp->ddev, alloc_sz, GFP_KERNEL);
> +	if (!buffer)
> +		return NULL;
> +
> +	*paddr = virt_to_phys(buffer);
> +	offset = ALIGN(*paddr, align) - *paddr;
> +	*paddr += offset;
> +	memcpy(buffer + offset, fw_data, fw_size);
> +
> +	return buffer;
>   }
>   

Two comments:

1) Can the integer overflow check be added here? If fw_size is very large
(close to UINT_MAX), ALIGN(fw_size, align) could overflow:

   fw_size = 0xFFFF0000 (4GB - 64KB)
   align = 0x10000 (64KB)
   *buf_sz = ALIGN(0xFFFF0000, 0x10000) = 0x0 (overflow)
   alloc_sz = 0x0 + 0x10000 = 0x10000

2) virt_to_phys() on drmm_kmalloc() allocated memory assumes
physical contiguity. Not sure size of this FW.

For allocations larger than a few MB, kmalloc may
not provide physically contiguous pages. Would dma_alloc_coherent() be
more appropriate.

>   struct psp_device *aiem_psp_create(struct drm_device *ddev, struct psp_config *conf)
>   {
>   	struct psp_device *psp;
> -	u64 offset;
>   
>   	psp = drmm_kzalloc(ddev, sizeof(*psp), GFP_KERNEL);
>   	if (!psp)
>   		return NULL;
>   
>   	psp->ddev = ddev;
> -	memcpy(psp->psp_regs, conf->psp_regs, sizeof(psp->psp_regs));
> +	psp->fw_buffer = psp_alloc_fw_buf(psp, conf->fw_buf, conf->fw_size,
> +					  PSP_FW_ALIGN, &psp->fw_buf_sz,
> +					  &psp->fw_paddr);
> +	if (!psp->fw_buffer)
> +		return NULL;
> +
> +	if (!conf->certfw_size) {
> +		drm_dbg(ddev, "no cert fw");
> +		goto done;
> +	}
>   
> -	psp->fw_buf_sz = ALIGN(conf->fw_size, PSP_FW_ALIGN);
> -	psp->fw_buffer = drmm_kmalloc(ddev, psp->fw_buf_sz + PSP_FW_ALIGN, GFP_KERNEL);
> -	if (!psp->fw_buffer) {
> -		drm_err(ddev, "no memory for fw buffer");
> +	/* CERT firmware */
> +	psp->certfw_buffer = psp_alloc_fw_buf(psp, conf->certfw_buf,
> +					      conf->certfw_size, PSP_CFW_ALIGN,
> +					      &psp->certfw_buf_sz,
> +					      &psp->certfw_paddr);
> +	if (!psp->certfw_buffer) {
> +		drm_err(ddev, "no memory for cert fw buffer");
>   		return NULL;
>   	}
>   
> -	/*
> -	 * AMD Platform Security Processor(PSP) requires host physical
> -	 * address to load NPU firmware.
> -	 */
> -	psp->fw_paddr = virt_to_phys(psp->fw_buffer);
> -	offset = ALIGN(psp->fw_paddr, PSP_FW_ALIGN) - psp->fw_paddr;
> -	psp->fw_paddr += offset;
> -	memcpy(psp->fw_buffer + offset, conf->fw_buf, conf->fw_size);
> +done:
> +	memcpy(&psp->conf, conf, sizeof(psp->conf));
>   
>   	return psp;
>   }
> diff --git a/drivers/accel/amdxdna/npu3_regs.c b/drivers/accel/amdxdna/npu3_regs.c
> index f6e20f4858db..fb2bd60b8f00 100644
> --- a/drivers/accel/amdxdna/npu3_regs.c
> +++ b/drivers/accel/amdxdna/npu3_regs.c
> @@ -16,6 +16,15 @@
>   
>   /* PCIe BAR Index for NPU3 */
>   #define NPU3_REG_BAR_INDEX	0
> +#define NPU3_PSP_BAR_INDEX      4
> +
> +#define MMNPU_APERTURE3_BASE    0x3810000
> +#define NPU3_PSP_BAR_BASE       MMNPU_APERTURE3_BASE
> +
> +#define MPASP_C2PMSG_123_ALT_1  0x3810AEC
> +#define MPASP_C2PMSG_156_ALT_1  0x3810B70
> +#define MPASP_C2PMSG_157_ALT_1  0x3810B74
> +#define MPASP_C2PMSG_73_ALT_1   0x3810A24
>   
>   static const struct amdxdna_fw_feature_tbl npu3_fw_feature_table[] = {
>   	{ .major = 5, .min_minor = 10 },
> @@ -23,14 +32,28 @@ static const struct amdxdna_fw_feature_tbl npu3_fw_feature_table[] = {
>   };
>   
>   static const struct amdxdna_dev_priv npu3_dev_priv = {
> +	.npufw_path             = "npu.dev.sbin",
> +	.certfw_path            = "cert.dev.sbin",
>   	.mbox_bar		= NPU3_MBOX_BAR,
>   	.mbox_rbuf_bar		= NPU3_MBOX_BUFFER_BAR,
>   	.mbox_info_off		= NPU3_MBOX_INFO_OFF,
> +	.psp_regs_off   = {
> +		DEFINE_BAR_OFFSET(PSP_CMD_REG,    NPU3_PSP, MPASP_C2PMSG_123_ALT_1),
> +		DEFINE_BAR_OFFSET(PSP_ARG0_REG,   NPU3_PSP, MPASP_C2PMSG_156_ALT_1),
> +		DEFINE_BAR_OFFSET(PSP_ARG1_REG,   NPU3_PSP, MPASP_C2PMSG_157_ALT_1),
> +		DEFINE_BAR_OFFSET(PSP_ARG2_REG,   NPU3_PSP, MPASP_C2PMSG_123_ALT_1),
> +		DEFINE_BAR_OFFSET(PSP_INTR_REG,   NPU3_PSP, MPASP_C2PMSG_73_ALT_1),
> +		DEFINE_BAR_OFFSET(PSP_STATUS_REG, NPU3_PSP, MPASP_C2PMSG_123_ALT_1),
> +		DEFINE_BAR_OFFSET(PSP_RESP_REG,   NPU3_PSP, MPASP_C2PMSG_156_ALT_1),
> +		/* npu3 doesn't use 8th pwaitmode register */
> +	},
> +
>   };
>   
>   const struct amdxdna_dev_info dev_npu3_pf_info = {
>   	.mbox_bar		= NPU3_MBOX_BAR,
>   	.sram_bar		= NPU3_MBOX_BUFFER_BAR,
> +	.psp_bar                = NPU3_PSP_BAR_INDEX,
>   	.vbnv			= "RyzenAI-npu3-pf",
>   	.device_type		= AMDXDNA_DEV_TYPE_PF,
>   	.dev_priv		= &npu3_dev_priv,

