Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F77606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 19:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AsOR1txZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 330E310E945;
	Thu,  5 Nov 2026 19:19:36 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011058.outbound.protection.outlook.com [40.107.208.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32EB810E945
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 19:19:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVrZWnll1OU0TU0ff7bQKBzBvKvDsNs83SC7gJyRdiTyerW4EbaktoPbEr2bmNZk+2qJXjHD0mR1JaDuSJCLKwULAGUbQWhFY60IIXf5x2ejmFpavHIdruvrbb249yX5BK59wrqU9UxiOwIJRHX0H/JwoI+hcqaycCnuylzaWmiEgCe+FTLewfUX6nlkLB9G8W5QKqsZ/Ha8tEMovlf5kr6nJBSHSAsRXMuvgZb4vZO5s7UJYSXlm2PIE+ZcbcUc8Un6nr69Kn6dXgxVg2gY0U2I/gn7y9YvGz7oA3Atp9oP/aGVIIAo2DuVrHGopdckAkLprGzGKrgFKQLU3VEYpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mg6GRFb7XpPnLmfzS6KlYBFo9QRY5X7i8gfKios3UsA=;
 b=Ke3M/snpWuRFecv1l4dKqEh0oRZlznLz98LXg+tdIUG2VrgDqN+WP2xDabndfzCajCuYaX8ASLua/YL0m+XAhy81wFf2Mq1rihiZGyOGPyI+YnVKTBPV3TNU0Wsd1kAio37KavLV6SmMOexf9QK+FTPUUoIUHbVN58h8/lrbbSh3LMTyWrLyob1LA2hLXlFHBaNf4lax3APg5IHRvgBwCbe3K7Jkm0LZABbUNoo2CezqeYCcEq3ooL1uk+BBqhjF0tmIjADO6P77TbCY5VcVjixYUSoujBF1pHzJRjtrmFZcvz+noJUc7dZlK5XfYepiPcrlSNbcstnVo163Yf2tZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mg6GRFb7XpPnLmfzS6KlYBFo9QRY5X7i8gfKios3UsA=;
 b=AsOR1txZ6h+wAIz3RXMxGvT13wro4hfN+cxVbFBoEbc3bBj9c1rjmsdZG9MlZVsVvQpiv6pYmqUvTq0Z2Mg8nmzIKbqnT1LFEyY3L41w6kcJFJTDHeCyfC4/qKOkZvn7UDcNAjopZbom4edrjgyqqxdDRbT9kwLjYIUIVxJflRU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB9062.namprd12.prod.outlook.com (2603:10b6:208:3aa::14)
 by SA3PR12MB9197.namprd12.prod.outlook.com (2603:10b6:806:39e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 19:19:25 +0000
Received: from IA1PR12MB9062.namprd12.prod.outlook.com
 ([fe80::28c6:3cbd:6e97:5257]) by IA1PR12MB9062.namprd12.prod.outlook.com
 ([fe80::28c6:3cbd:6e97:5257%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 19:19:24 +0000
Message-ID: <2cf0906c-9766-4e3c-bfd0-3390263f5390@amd.com>
Date: Thu, 5 Nov 2026 11:19:16 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel/amdxdna: Load the aie4 firmware variant the PSP
 reports
To: Mario Limonciello <mario.limonciello@amd.com>,
 Lizhi Hou <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261105-superm1-lms-npu-v2-1-ad6704226d47@amd.com>
Content-Language: en-US
From: "Zhang, Yidong (David)" <yidong.zhang@amd.com>
In-Reply-To: <20261105-superm1-lms-npu-v2-1-ad6704226d47@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::15) To IA1PR12MB9062.namprd12.prod.outlook.com
 (2603:10b6:208:3aa::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9062:EE_|SA3PR12MB9197:EE_
X-MS-Office365-Filtering-Correlation-Id: 947f8978-0c18-4f1f-29d6-08df3b71b39a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|10067099003|18002099003|22082099003|11063799006|56012099006|261022105027099003|261102123227099003|261028144727099003|261022115727099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|261009223027099003|261022075727099003|260925021911599003|260925021311599003|260925022911599003;
X-Microsoft-Antispam-Message-Info: D2LzecyyK6o/944np4v+Rik8RlWF8aBSAd7QSao9jZDA55Me8ibUU9OSV6/eGhPUIl689TIsxLNs+JVSZt8IjJE9AklVR+BbCBl67E9XL3jEpa4PXMwe4jXrmn10xMdKBs7nH2THY/FAauFOrzs2ZfqyAU3q7KCjdoqG3QGoO9r0PKpt+d0qNq4bYl9eWyVB6SkrWB8XFhkPtQyRJzWL8AiUrOHjTfeG1bDXCUkyAJyp3bkxhhZGccKdAD/qOVLUQgNyc0MqFf7j+LkeKnePccFmlCOVz7Q4khk42ArlEiGXpR6suo4qaOsByARXSZzA3v04KaCZ6WnZ8KHLxX3Nti2zIPNujkoJJZ4CGhxO9euCmBWNvxDHR35NcOI8Dowm2iIn5uSJ5/tYWbpSSq2xHYLWEmN/fAyBYCcBBlT967LmRDCxM3MpV7+uIKfh5nvk7Y2ORsF0nWT5j9yRzC7KuEvdURNrNFXuSO0880gCHwyiwcJLHkJhSIBCtQiiziTOXyPlWX7v5mcy4Bu6kkn24ocyC/OHVteICLqpKUNRDDD14s8/OrImK4JpSi/A8KsMp8ZBsJMa+lz0doPFSBJtaQunIiWs8otp1uNJqr4FE/xpHSwuoJCLTLSTxYWiRL+/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB9062.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006)(261022105027099003)(261102123227099003)(261028144727099003)(261022115727099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261009223027099003)(261022075727099003)(260925021911599003)(260925021311599003)(260925022911599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFlhTlUzT1ErUWhoSjRtUEllb0h2c3FWT3p3RjRUNjRvaFdaWXhXdFpCcmRi?=
 =?utf-8?B?S2NRemZjK0xhcHQ4OWtYSnY5MFRTMHVwaU1BRXlES2xFM2RidlZ1TEhmUVd0?=
 =?utf-8?B?dFlhK0VXeC8rNVFSTDhibEp5K2dNYXQwUWhseWdyWEkyUGxlRVZqa0NRQUQw?=
 =?utf-8?B?UmludzlHQ20zbTVWekxPZXVldHJaM09MTVlRNHY0QVk3Q2pHZkU2cUhvNUFw?=
 =?utf-8?B?MVJ2RW5pdHJvQmV1UytxcDVxazhMMmVWNFY5SksxM2hUVmtxazFvbzVPTXRI?=
 =?utf-8?B?WE5yS0ZvZEVFYWhGbGpaRzhycWthTm5zOWVtUFVSOGU1c3dLR3NIcFpKVkxs?=
 =?utf-8?B?M29lNkFtOUtxaGlPMlYvWGJsdXcrN3VEaTY3dFhRL2h1YUVIR3FTck9LQUlF?=
 =?utf-8?B?elNVUjcxR3lxOW92V3RRQzh4T2w1K3VpNWpudjJhQkEyaDRhUWV2VldYVklW?=
 =?utf-8?B?ZkVxRC9vYlhqVi9ZRXNKNUcwSU54eHlBblhYVGZ5bkFaV012Q0VUSmdlbGxt?=
 =?utf-8?B?ZFBBcHlZczlBRFprRDZFMnpjQW5TN2dtZnhKbUgvdmRWZnQ4UGZxelZTeXAz?=
 =?utf-8?B?cHVxWFNVclFpenkwMWc3b3NmZ1ViNTRRVEZiMUEvUWNpU2RYWUdSZ2g3R2Nx?=
 =?utf-8?B?NzkxMDhsQUdzVW9Ma1JoU2tBMnhycGl4VnA4bVQxb2daa3JsRjZkVDlVclhO?=
 =?utf-8?B?djF4eHpYS09ydStwbVcvMWoyRllSMDNuZVZmbkZlVWR6VGlIVFFZakVXTU5a?=
 =?utf-8?B?OEt6cTJLaTBuK3lwL1h6WjhwNC92ZzJ6M3VwaFpzWlhVMnNCT0xJWnR5a09I?=
 =?utf-8?B?ejFGU1NiMk5rbkhrNmNjQXFuT3UyemovTDJUWDd6aEl2RlRrUWpGeGl5NjVU?=
 =?utf-8?B?VTNvQ09EcjZFaHoyakdUdUExMXBkUnB0amJpaUEzdUdpYXlJRjIwbTg4R0Jt?=
 =?utf-8?B?dlRpRDBpUlB5TUQ4YjN2b3JRa2RXUmtrZCtsK3E4SFExSzVETktTSmFNY1VZ?=
 =?utf-8?B?clpPTWhQNXRUMng3QnVkV0d6QndVcFNuTzBDakswcW4xYnBUdVIwT05HWWoy?=
 =?utf-8?B?YlNQZGE1WEJlY2trR1FyL0gyWU82NkxORHMySGlNb2p2TnFYZlBJaEhUcU5t?=
 =?utf-8?B?SUJWeUZjb2RWeS9WOWQzaHB2ZHVkSFdPT1I1YWR0eGhaQUl5cWtLd1dLc1Q3?=
 =?utf-8?B?b2JMa1RuZEN5dkFLT3FSS1o0TXZ6N09WRjUwMDMzRUwvcFB0ZFJuRXhNeXpn?=
 =?utf-8?B?dGtUQ1BDM1pEd1B2VWNHUDIwR25La1M0RHc2aEM0amZ4eFJjMW9Mb0FYeldB?=
 =?utf-8?B?Q0JmWGR3UWIvNlJYQWxKUVo3MllUNng1L2VGaCtaOTl3Rks1ME1mU0Exa1dq?=
 =?utf-8?B?b20zZ0VKKzJrU0Rab0VQRzRmR3hjR0JkZGpTNis4Q3lhS0d1elNtME1BK1ZM?=
 =?utf-8?B?UzVlRnUyeDQ1MENmSmVqc09QVXRkWXBTVTd6Z1h3Z2JYQm9Ld0Fpem8wZGFG?=
 =?utf-8?B?TWVQZmZJeXp2UlRDSFV3L3ZVOHpaUWVQU09oS1RnZ01iV1ArQmhnWmlDZDJh?=
 =?utf-8?B?SDYwVEp2cVUvS3QxSmtBVExmNStsUDMwOGoxMDVhak04MktQaGtURWJ3UjZu?=
 =?utf-8?B?VzREZU9pVlBMcXdwaHMvVkQyT1Vyb21FaTRnNXYzS3BYVXpGYVV6M2xGRS9Y?=
 =?utf-8?B?ZGVaaEwzS29qOWM4eWhqb3hvZzJZOFMvNEd4WVJaMFNUb3U0NVNSekYyeGRx?=
 =?utf-8?B?Nzk1dHp3VTZ0Y2Y0bE5vS0dIcU9KUklLRGkwelFBSUhMYzh4SEtmbHlGY3d1?=
 =?utf-8?B?OU0zc3d5QitENnNjbDliTHFnVExjcFN4cno4UWlzVlloTzdTZGxrVGVBdkRI?=
 =?utf-8?B?SlVqZEd1VEw5a3h6MXlJeW9iVXJsQUFxUXMyQk5YTFpFQkpSdTNVTmJ3dEZz?=
 =?utf-8?B?aTdYcEFNTHc4azdaT2ViSHY3T2VwNVF4WFJOTWtya29PMm9VaUs5OVJadmRz?=
 =?utf-8?B?a3BTaHY0SzdRNlNNSit4WGpiMWlCTUFDT1ZmVFBBbTkwVHM4YmNJWXhoZ09L?=
 =?utf-8?B?RFIzRlBqRmUxUG5DS1Z2WVA4alM1emJMN2pmLzJHM1JKWENSdVA0U3hSblQr?=
 =?utf-8?B?TzdUYlg1Q0dLaFhwamxhL3N0anQ3VndYVFdVejNhR1NqTGhtZlFnMlZRTXpl?=
 =?utf-8?B?QzhSTFh4VTAxYyt4SnpPSHZBbXVQTHQ3d3YyVzBWclFNUEJzaEgvUnI1eXJz?=
 =?utf-8?B?RFNDV2s0WnlRMkk2Y2xIYWw4SFc5dTg3cnpkbTEvVXg0a1hqWDJ3R3NaOXdv?=
 =?utf-8?B?dStsRW80MlhJU25RUEdQV0dCUDFPNURmZkZrcUJQMUxmdDFleXZLQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 947f8978-0c18-4f1f-29d6-08df3b71b39a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9062.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 19:19:24.2730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N44sSty50+yUtyjbuTe4mD+6qgoI7S3S4OXtwlxqLRQmTx1J8V4ERBKdS7nPJkzzFHCeU+0k14VyX6QpI9P34Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9197
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/5/2026 7:51 AM, Mario Limonciello wrote:
> Some Platforms ship BIOS with either a default or an alternative trust
> authority. The PSP validates the NPU firmware, so it must be signed with
> the matching scheme. Firmware for the alternative scheme is named with
> an "_l" suffix before the extension. A preproduction part needs firmware
> of its own, named with a "_p" suffix.
>
> The PSP reports the signing type in bit 6 of C2PMSG_63, and in bit 28
> whether this is a preproduction part. A preproduction part that also
> reports the alternative scheme is not expected, so warn about it and
> use the default firmware.
>
> Add MODULE_FIRMWARE() entries for the "_l" variants of the npu and cert
> images of the aie4 devices so that initramfs generators include them.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> Changes in v2:
> - Initialize val in aie4_psp_fw_variant() so a failed SMN read can't leave
>    it uninitialized
> - Only read the PSP firmware variant after the npufw/certfw path check, so
>    VFs (which have no firmware paths) skip the SMN access
> - Drop the redundant all-ones check, amd_smn_read() already returns -ENODEV
> - Link to v1: https://patch.msgid.link/20261104-superm1-lms-npu-v1-1-dbffcc5abc23@amd.com
> ---
>   drivers/accel/amdxdna/Kconfig           |   1 +
>   drivers/accel/amdxdna/aie4_pci.c        | 162 ++++++++++++++++++++++++++------
>   drivers/accel/amdxdna/amdxdna_pci_drv.c |   8 ++
>   3 files changed, 141 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/Kconfig b/drivers/accel/amdxdna/Kconfig
> index eddff490b4f75..cd17a89cf4146 100644
> --- a/drivers/accel/amdxdna/Kconfig
> +++ b/drivers/accel/amdxdna/Kconfig
> @@ -6,6 +6,7 @@ config DRM_ACCEL_AMDXDNA
>   	depends on DRM_ACCEL
>   	depends on PCI && HAS_IOMEM
>   	depends on X86_64
> +	depends on AMD_NODE
>   	depends on AMD_PMF || !AMD_PMF
>   	select DRM_SCHED
>   	select DRM_GEM_SHMEM_HELPER
> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
> index 02dcb2f813d45..26c6162893760 100644
> --- a/drivers/accel/amdxdna/aie4_pci.c
> +++ b/drivers/accel/amdxdna/aie4_pci.c
> @@ -11,6 +11,8 @@
>   #include <linux/debugfs.h>
>   #include <linux/firmware.h>
>   #include <linux/sizes.h>
> +#include <linux/string.h>
> +#include <asm/amd/node.h>
>   
>   #include "aie.h"
>   #include "aie4_msg_priv.h"
> @@ -558,46 +560,124 @@ static void aie4_classic_hw_stop(struct amdxdna_dev_hdl *ndev)
>   	aie4_fw_stop(ndev);
>   }
>   
> -static int aie4_request_firmware(struct amdxdna_dev_hdl *ndev,
> -				 const struct firmware **npufw,
> -				 const struct firmware **certfw)
> +/*
> + * PSP C2PMSG_63 (SMN) bit 6: 0 = default firmware signing, 1 = alternative
> + * PSP C2PMSG_63 (SMN) bit 28: 0 = production part, 1 = preproduction part
> + */
> +#define AIE4_PSP_C2PMSG_63_SMN_ADDR	0x38109fc
> +#define AIE4_PSP_FW_SIGN_ALT		BIT(6)
> +#define AIE4_PSP_FW_PREPROD		BIT(28)
> +
> +enum aie4_fw_variant {
> +	AIE4_FW_DEFAULT,
> +	AIE4_FW_ALT,		/* "_l" images */
> +	AIE4_FW_PREPROD,	/* "_p" images */
> +};
> +
> +/*
> + * The PSP only trusts firmware signed with the scheme the platform firmware
> + * uses and a preproduction part needs firmware of its own. Reading which one is
> + * in use is optional and only used as a hint for which images to try first:
> + * anything but a clear answer is treated as default.
> + */
> +static enum aie4_fw_variant aie4_psp_fw_variant(struct amdxdna_dev *xdna)
>   {
> -	struct amdxdna_dev *xdna = ndev->aie.xdna;
> -	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
> -	char fw_name[128];
> +	u32 val = 0;
>   	int ret;
>   
> -	ret = snprintf(fw_name, sizeof(fw_name), "amdnpu/%04x_%02x/%s",
> -		       pdev->device, pdev->revision, ndev->priv->npufw_path);
> -	if (ret >= sizeof(fw_name)) {
> -		XDNA_ERR(xdna, "npu firmware path is truncated");
> -		return -EINVAL;
> +	ret = amd_smn_read(0, AIE4_PSP_C2PMSG_63_SMN_ADDR, &val);
> +	if (ret) {
> +		XDNA_DBG(xdna, "PSP firmware variant not available, ret %d", ret);
> +		return AIE4_FW_DEFAULT;
>   	}
>   
> -	ret = request_firmware(npufw, fw_name, &pdev->dev);
> -	if (ret) {
> -		XDNA_ERR(xdna, "failed to request_firmware %s, ret %d", fw_name, ret);
> -		return ret;
> +	if ((val & AIE4_PSP_FW_SIGN_ALT) && (val & AIE4_PSP_FW_PREPROD)) {
> +		XDNA_WARN(xdna,
> +			  "Preproduction part with alternative signing, using default firmware");
> +		return AIE4_FW_DEFAULT;
>   	}
>   
> -	ret = snprintf(fw_name, sizeof(fw_name), "amdnpu/%04x_%02x/%s",
> -		       pdev->device, pdev->revision, ndev->priv->certfw_path);
> -	if (ret >= sizeof(fw_name)) {
> -		XDNA_ERR(xdna, "cert firmware path is truncated");
> -		ret = -EINVAL;
> -		goto release_npufw;
> +	if (val & AIE4_PSP_FW_PREPROD)
> +		return AIE4_FW_PREPROD;
> +
> +	return (val & AIE4_PSP_FW_SIGN_ALT) ? AIE4_FW_ALT : AIE4_FW_DEFAULT;
> +}
> +
> +/*
> + * Images for the other variants have a suffix before the ".sbin" extension.
> + * Returns -ENOENT if @path has no such variant.
> + */
> +static int aie4_fw_name(struct amdxdna_dev *xdna, char *name, size_t size,
> +			const char *path, enum aie4_fw_variant variant)
> +{
> +	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
> +	const char *suffix;
> +	size_t len, base;
> +	int ret;
> +
> +	ret = snprintf(name, size, "amdnpu/%04x_%02x/%s",
> +		       pdev->device, pdev->revision, path);
> +	if (ret >= size) {
> +		XDNA_ERR(xdna, "firmware path %s is truncated", path);
> +		return -EINVAL;
>   	}
>   
> -	ret = request_firmware(certfw, fw_name, &pdev->dev);
> -	if (ret) {
> -		XDNA_ERR(xdna, "failed to request_firmware %s, ret %d", fw_name, ret);
> -		goto release_npufw;
> +	switch (variant) {
> +	case AIE4_FW_ALT:
> +		suffix = "_l.sbin";
> +		break;
> +	case AIE4_FW_PREPROD:
> +		suffix = "_p.sbin";
> +		break;
> +	default:
> +		return 0;
>   	}
>   
> +	len = ret;
> +	if (len < strlen(".sbin") || strcmp(name + len - strlen(".sbin"), ".sbin"))
> +		return -ENOENT;
> +
> +	base = len - strlen(".sbin");
> +	if (strscpy(name + base, suffix, size - base) < 0)
> +		return -EOVERFLOW;
> +
>   	return 0;
> +}
> +
> +static int aie4_request_one(struct amdxdna_dev_hdl *ndev, const struct firmware **fw,
> +			    const char *path, enum aie4_fw_variant variant)
> +{
> +	struct amdxdna_dev *xdna = ndev->aie.xdna;
> +	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
> +	char name[128];
> +	int ret;
> +
> +	ret = aie4_fw_name(xdna, name, sizeof(name), path, variant);
> +	if (ret)
> +		return ret;
>   
> -release_npufw:
> -	release_firmware(*npufw);
> +	ret = firmware_request_nowarn(fw, name, &pdev->dev);
> +	if (ret)
> +		XDNA_DBG(xdna, "firmware %s not loaded, ret %d", name, ret);
> +
> +	return ret;
> +}
> +
> +/* The NPU and cert images are validated together, so both use the same variant */
> +static int aie4_request_firmware(struct amdxdna_dev_hdl *ndev,
> +				 const struct firmware **npufw,
> +				 const struct firmware **certfw,
> +				 enum aie4_fw_variant variant)
> +{
> +	int ret;
> +
> +	ret = aie4_request_one(ndev, npufw, ndev->priv->npufw_path, variant);
> +	if (ret)
> +		return ret;
> +
> +	ret = aie4_request_one(ndev, certfw, ndev->priv->certfw_path, variant);
> +	if (ret)
> +		release_firmware(*npufw);
>   
>   	return ret;
>   }
> @@ -645,18 +725,40 @@ static int aie4_prepare_firmware(struct amdxdna_dev_hdl *ndev,
>   	return 0;
>   }
>   
> +/*
> + * The firmware can only be started once. It is the PSP that decides whether it
> + * accepts the images, and it does that when the firmware is started, so there
> + * is no trying a variant and falling back. Pick the variant that the PSP
> + * reported (the default one if it can't be read) and use the others only if
> + * its images are missing.
> + */
>   static int aie4_load_fw(struct amdxdna_dev_hdl *ndev,
>   			void __iomem *tbl[PCI_NUM_RESOURCES])
>   {
> +	struct amdxdna_dev *xdna = ndev->aie.xdna;
>   	const struct firmware *npufw, *certfw;
> -	int ret;
> +	enum aie4_fw_variant order[3], hint;
> +	int i, n = 0, ret = -ENOENT;
>   
>   	if (!ndev->priv->npufw_path && !ndev->priv->certfw_path)
>   		return 0;
>   
> -	ret = aie4_request_firmware(ndev, &npufw, &certfw);
> -	if (ret)
> +	hint = aie4_psp_fw_variant(xdna);
> +	order[n++] = hint;
> +	if (hint != AIE4_FW_DEFAULT)
> +		order[n++] = AIE4_FW_DEFAULT;
> +	if (hint != AIE4_FW_ALT)
> +		order[n++] = AIE4_FW_ALT;
> +
> +	for (i = 0; i < n; i++) {
> +		ret = aie4_request_firmware(ndev, &npufw, &certfw, order[i]);
> +		if (!ret)
> +			break;
> +	}
> +	if (ret) {
> +		XDNA_ERR(xdna, "failed to load firmware, ret %d", ret);
>   		return ret;
> +	}
>   
>   	ret = aie4_prepare_firmware(ndev, npufw, certfw, tbl);
>   	aie4_release_firmware(ndev, npufw, certfw);
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> index f233eb70a2957..dab8603e2381f 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> @@ -37,6 +37,14 @@ MODULE_FIRMWARE("amdnpu/17f1_13/npu.sbin");
>   MODULE_FIRMWARE("amdnpu/17f1_13/cert.sbin");
>   MODULE_FIRMWARE("amdnpu/17f2_13/npu.sbin");
>   MODULE_FIRMWARE("amdnpu/17f2_13/cert.sbin");
> +MODULE_FIRMWARE("amdnpu/17f1_10/npu_l.sbin");
> +MODULE_FIRMWARE("amdnpu/17f1_10/cert_l.sbin");
> +MODULE_FIRMWARE("amdnpu/17f2_10/npu_l.sbin");
> +MODULE_FIRMWARE("amdnpu/17f2_10/cert_l.sbin");
> +MODULE_FIRMWARE("amdnpu/17f1_13/npu_l.sbin");
> +MODULE_FIRMWARE("amdnpu/17f1_13/cert_l.sbin");
> +MODULE_FIRMWARE("amdnpu/17f2_13/npu_l.sbin");
> +MODULE_FIRMWARE("amdnpu/17f2_13/cert_l.sbin");


I tested against both _l, _p and default sbins. All passed.

Reviewed-by: David Zhang <yidong.zhang@amd.com>

Tested-by: David Zhang <yidong.zhang@amd.com>

/David

>   
>   /*
>    * 0.0: Initial version
>
> ---
> base-commit: e32e83a6c5ec031a7f59d4794113d8484b220254
> change-id: 20261104-superm1-lms-npu-6bc3bbe38c29
>
> Best regards,
> --
> Mario Limonciello <mario.limonciello@amd.com>
