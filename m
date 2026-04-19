Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5FFEA71A1
	for <dri-devel@archiver.kernel.org>; Sun, 19 Apr 2026 18:13:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22F4B10E004;
	Sun, 19 Apr 2026 18:13:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XTNk57yh";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013035.outbound.protection.outlook.com
 [40.93.201.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92EBC10E004
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 18:13:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmAIUFfbEgE7nY1LBV2h7uKG992MO67FNu/WEjIZBBbSKmAgh7t2buneRD/WDv4OZ68BqjceKOoyh2TotKF9XYMsWybDCnQDePa0yLMIsZs0eQ56UOHVAdOOnK8bjj41iijlMsZgCNW4hDbUbsDQGXWBciSp8s9RyLD1+r2GITkK4no80CXgt47Mpa6GbcFowM3TP4eyO53PI2r4JzTxKKGvS08Hp/RbVwMmZtBYR2C4IvDMPIHWcZ587QzH3G5h7pdUYZ8sdUanMCUx6o2BSUfbn4jp80SI8wz7xjaj8OWiFMj4STOxJX6lrW/uliQyYfbp9ZQLysz1jtBYfXxBFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qAxfRQatEc2oys23MD4hMFmBmHa2oqG7wtVsjYu3j6U=;
 b=W9J2Kc/tdLD7faKMsZNjz03g+jxFiWmZMV2sC2timNm3BBSZrUOr08gjFvUBp2Yb3sWu5tfYsoQH/nn5NhJoXqKB+jANn5Gvd3Lq6S2eXVf2z+3vLZLIwtgyhghgx30HDmIC3mc6vkDXUObbV/uRKyzl1mVCDbdqHPxrlpNYBMtXFDriOFpT7hYKjc0jf0fZgRhs+qfLv85OuI93M9yMZdnB0Gf8Yj09qsdgBhaO+r/hl7DK/9v/iV8JM6xmUHVKvtBN42qCvDNdddD+j5V01xsDnjLdo2XErFPtT57+KXzLQsIKlDcXTYeQj+QC33Ea46fmzC5GnYuE6Fr1cih4cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAxfRQatEc2oys23MD4hMFmBmHa2oqG7wtVsjYu3j6U=;
 b=XTNk57yhsibF9HOuaqtw0fCRWlnmQRWrEm8/Tet1TUOKvvqPQLehhVRO9TzER94liFx1CdbdE+39NyCQV27/+26eh997aMJ/EwxiiEOlCB1imBZVNrcyJToI6PrjKlF5VoOoa7ImND+7ZNbgciMz0xrP7g2yej4XxzxUG80+a/o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by PH7PR12MB6465.namprd12.prod.outlook.com (2603:10b6:510:1f7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Sun, 19 Apr
 2026 18:13:23 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9846.007; Sun, 19 Apr 2026
 18:13:22 +0000
Message-ID: <c1f17602-76ba-4fb9-a08c-5bfb68edb031@amd.com>
Date: Sun, 19 Apr 2026 13:13:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Add carveout memory support for
 non-IOMMU systems
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 maciej.falkowski@linux.intel.com
Cc: Max Zhen <max.zhen@amd.com>, linux-kernel@vger.kernel.org,
 sonal.santan@amd.com
References: <20260417210621.1173841-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260417210621.1173841-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:408:141::30) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|PH7PR12MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: 70a4fa14-1381-43df-2510-08de9e3f57a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: RvbnN3vNQL0QjeAhK8lsMfOXaGpMN6mNDKCiGCfloFhV9kRO39Vv1w+f3f9QH8NoQ4adgJd1s/8gLGUEAImqTgfc9sYWJBzKnienLuXnXdB2hJTHQRvQW9NM/ezH0ztiq/0dA3s2fW3b33WB4rUv4R3NrQt5S1RFu+kstl+jmcZAEsgb2V4ixR9CFClAQqESFbTN7+NLIqbgu3S0hIzB66v0c4GwdBE6q/VEkzBEt+OkLmdBGaWUhK1ItJl/KTZ/SIdIWgiW2LnOZp1Cw3Rbi3EMsLud5C7BGgmUQAsJfXmuWMK5zFfKCsWipI/3zGEsRMg+N0SEsrPhkqBNQDaVfDuH+IcN0SJvIbiqdrkugciUFwqb7FymxDCnId7UifoXFJbLFTE/knxTMJPDKOZDoLvfaA/QOy+RVTSi5rFCucNudQ5wpBOZivtYpDk5QW03rbnYpGtgfc6l76WpX89lcg9TpkgTC7yPfDHYSvB9fHERV+9WlZR9t8Ms4TqlvRbZfvWMNuij54ndxNVu5AD5eBPXnETUKSub81gRdt5+8Lud+w7farhMd7Ywt186BCg5whwW9HN59K0IdJCPsAah3gs3oJILdhuKd9K+Wbq8Na0Xj7Zm0tIP5cKYj0Xr4GVQhsDB0T3KeyZ2VcrCEWiszecaZdoI1NUUYS077DBD8SvJ8lGo6zjx9Wi/SEsnLxJ4TaK66KjDSTxbYQZvGFvj9gBJSm2KNw+h6rXorELme7A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXNhZTFpQjkzWnFyVWU2OTZTZHZpRnJaNXpxUEIycHNoSlU0dit5L3l5SGtt?=
 =?utf-8?B?K3N4T3g3dWpJeU8ySDd6YjFhTUV5aG1NckFYK3BmUEFhMWxxdWF5Zi9nUEh2?=
 =?utf-8?B?anRGbHhqOE5ob3hvQkZHVzhNVWZxMThsUGRKbUpnblJiZG9YUnRJa1dPRklF?=
 =?utf-8?B?VnFWN1hxak0wZ1NXdkd2eE1vOHFMMVVmQTk3VXBPN2xoTXVacUVVREI3MmYv?=
 =?utf-8?B?akloNWZYUGJPK0s4YzNWdUxuc1FSSkhkcGFZS2dqbnRxcldqeUh1TmU1ZXhO?=
 =?utf-8?B?ZUpLWTh5NUp6VGZUNWVLUXc4cTVFTUxUZ0M3aGpaOUJGQUlpa0JQRnlLd2wv?=
 =?utf-8?B?OUdVWkMxeUVYanNMR1dZL2JCVHJOTWl2WnhCQllGaDMzcHV0L3pLS09CL05L?=
 =?utf-8?B?eFJzaEFQRllCTjA0M3d2ZUNkU0RzeVlXcVdsYktFUXdlb0c0bEIxMTlacU5K?=
 =?utf-8?B?dEJRVTRLOUR0SURlL3V1NXU5cWZrRWFuY3EzWis2SWdPRFVxdUYvcmVXc3dm?=
 =?utf-8?B?c3VKRUpLUVBSaWQyWWpPQ09LSVBsOWhTSjZTWUYrVitwUWZBM3hWZjRNMnlz?=
 =?utf-8?B?YU9lUlFNTWswZEJCb3k4WTBFZHpGR2ZhWHhBcVJtRVJlTWZBR2RhMk1yeWxG?=
 =?utf-8?B?ZWxtdVp5eWphZXpNeFBkVnVzTldrMlBCeG5VV1hHS25SSDdzMys5L0F3NHY5?=
 =?utf-8?B?MTErYk9JcFR0RWFkUmlwT1E3TlRZRS80cWZKbzM1dDJEbTEzNDZUZ29zd21L?=
 =?utf-8?B?T2V5RzhqZHhnZ3ZiNXBzYUtqNXZLUytLa3RGemlPYlVPS3hqMUQ4OCs2aEYy?=
 =?utf-8?B?eWk3eE9GY2lZTllEeG9ERnY3bmxJTTg2M25KWVU0Z3lySmlxbWRUdHI0VXdr?=
 =?utf-8?B?NHUvc3BqOEpvYW9ZcDdzMDE4MEtEN253M3lJeEo4NU02TnphV09KTTRMVzVs?=
 =?utf-8?B?YnpYMEMvc2ZrdWwyMnpjejBBcVVWQUFsNDl3NG1PNnd1RkYxOVNPd3YvRDhJ?=
 =?utf-8?B?dXU5a21GWXBaYTFuS21BRU05cFVLb0NqR01USkxmTkNEeFVaeG5zV3pwUStD?=
 =?utf-8?B?RzNkNlEzR1lvWjVLSDhtYzN3T1lZcy9udGF2Y2dEeW1kSFlseVpTdzZra2ZS?=
 =?utf-8?B?R0ZHYlZNZGl0bldCc3M0a3V2Vm9IaUI2djFwOFRjSmVRT3JvOGtpaTNMeklS?=
 =?utf-8?B?NjBaRFB4YlFRMzVmakZUeW83KzVobXE1cHZUTGF1OWJpTkc2QUtBQkV1QnFB?=
 =?utf-8?B?SVVkQzQ2WjVnbkMySUp2bkx5NklzamlYY2trbHhJTkF5eDNTVUt0Y1YyUHRu?=
 =?utf-8?B?SHZiSVlaaFFNM1V1YUFQOFU2b0o0bERXeWNHWWtLQmdkZUpadTMxcHVZVEhR?=
 =?utf-8?B?U3FYb05VQnJlMUdHdkQ3cVpZaHBYcFdGaVdkR1l5RU9GSWgvVENNM2xsT0o3?=
 =?utf-8?B?NnE0dXpVSUlOWDJKWGpaRGJKV1ZwODZMT1lQTVBrVFN0MktHNXJzalF0VnF3?=
 =?utf-8?B?ZkUvWG9senN5WkJQNTBiU0FBbXlyZmFCWlQ0WnVxblBsUzBBOFg1L2hFUTgz?=
 =?utf-8?B?N05UUEExSzFqNjBnbkpuRDRXWXBnRjJDbGxHQjZSL2FqV1Q3SzlkNHNvdWVN?=
 =?utf-8?B?K2xQQVVoTTJibXBTNkw4SmhvQkRGckNiYk5la204aURxbnpPNkRFYVdhb2Vv?=
 =?utf-8?B?TW5Qb0ZDOU5VZkw4bmtPN3RrV2twWStxRGh2V1llb2gxNFU4OU5RTGkvTktv?=
 =?utf-8?B?bmpjd3pYWUNLMjJFZCtNQnJ5WVBpWVA3N2FuMnlsTFpqYzZUMWowcjhJK1ZR?=
 =?utf-8?B?ZlBmZDdzdmx6Mm9rS1A4SzRNOXpMZVh5cjI5VUVZSVFmWUNvSExvMnQyWU80?=
 =?utf-8?B?UStrQjU5T3VKaXNaSllCSC9VbktuM3NIckpPVWhWc0xrMU9BbU5xU2NTaDRC?=
 =?utf-8?B?NW1iUUU4QmhTdEdkdmVRYk44dC9TNUdDUWR6K3FsYldRNXB5R1dFZnJQTWEw?=
 =?utf-8?B?Q2hYZlF6R0szSDg2VHlUNHNqd2JvTlZHQ3lvaHFDVEd3OWpGanAwN0lVQk82?=
 =?utf-8?B?R0toUEFTMjdVU2RKTU9LczhmREdIdGtaNFVGK2JBeC9EMXVITGVpeEdRemJH?=
 =?utf-8?B?a0pmR0NyajJxc3BtbHl1M0RsZXp4K3dXQzV2alAzbVdGR2xUdm1tVkVBY0Y3?=
 =?utf-8?B?S0dscmJnTHR2dGxxNXNhVEZsMVJ3dExCL2wrNkxHSTcrM2tiQkp6RkdhRFBD?=
 =?utf-8?B?eTVwUVBhZUovaHllUHpUMHB2aTNLYjRabmVwZi8xcFFMa2UxTW52N2ZhTGhL?=
 =?utf-8?Q?TNp4ywqyprZpJg6D9m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a4fa14-1381-43df-2510-08de9e3f57a7
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2026 18:13:22.6914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZRgc7Yn5EXpYJ5eNDA6SqxQoBf9P8ntr5TrqN/D/rT1ZGLYmlmzWu6hEDAjbv270U2129i+W1i7G1VI7p8Q6KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6465
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



On 4/17/26 16:06, Lizhi Hou wrote:
> From: Max Zhen <max.zhen@amd.com>
> 
> Add support for allocating buffers from reserved carveout memory when
> IOMMU is not available. This is useful during debugging or bring-up.
> 
> In this configuration, the device uses physical addresses and does
> not support scatter-gather lists, requiring physically contiguous
> buffers.
> 
> Implement carveout-backed allocation and integrate it into buffer
> management to support operation in physical address mode.

Running with IOMMU disabled is unlikely to be a common production 
scenario.  At first I was thinking this is OK, but considering Greg's 
strong comments about driver specific module parameters I /wonder/ if 
this should be gated behind a kconfig option to be used at bringup?

The Kconfig option could be something like XDNA_CARVEOUT and default to 
0.  Then it can be set to any value necessary for debugging.

You could go a step further and only let XDNA_CARVEOUT do the 
reservation when IOMMU wasn't found.

> 
> Signed-off-by: Max Zhen <max.zhen@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>   drivers/accel/amdxdna/Makefile          |   1 +
>   drivers/accel/amdxdna/amdxdna_cbuf.c    | 249 ++++++++++++++++++++++++
>   drivers/accel/amdxdna/amdxdna_cbuf.h    |  16 ++
>   drivers/accel/amdxdna/amdxdna_gem.c     |  95 +++++++--
>   drivers/accel/amdxdna/amdxdna_iommu.c   |  77 +++++---
>   drivers/accel/amdxdna/amdxdna_pci_drv.c |  91 ++++++---
>   drivers/accel/amdxdna/amdxdna_pci_drv.h |   4 +-
>   7 files changed, 454 insertions(+), 79 deletions(-)
>   create mode 100644 drivers/accel/amdxdna/amdxdna_cbuf.c
>   create mode 100644 drivers/accel/amdxdna/amdxdna_cbuf.h
> 
> diff --git a/drivers/accel/amdxdna/Makefile b/drivers/accel/amdxdna/Makefile
> index 79369e497540..a055aea36971 100644
> --- a/drivers/accel/amdxdna/Makefile
> +++ b/drivers/accel/amdxdna/Makefile
> @@ -12,6 +12,7 @@ amdxdna-y := \
>   	aie2_solver.o \
>   	aie4_message.o \
>   	aie4_pci.o \
> +	amdxdna_cbuf.o \
>   	amdxdna_ctx.o \
>   	amdxdna_gem.o \
>   	amdxdna_iommu.o \
> diff --git a/drivers/accel/amdxdna/amdxdna_cbuf.c b/drivers/accel/amdxdna/amdxdna_cbuf.c
> new file mode 100644
> index 000000000000..4a556199a461
> --- /dev/null
> +++ b/drivers/accel/amdxdna/amdxdna_cbuf.c
> @@ -0,0 +1,249 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026, Advanced Micro Devices, Inc.
> + */
> +
> +#include <drm/drm_mm.h>
> +#include <drm/drm_prime.h>
> +
> +#include "amdxdna_cbuf.h"
> +#include "amdxdna_pci_drv.h"
> +
> +/*
> + * This is a platform debug/bringup feature.
> + *
> + * Carveout memory is a chunk of memory which is physically contiguous and
> + * is reserved during early boot time. There is only one chunk of such memory
> + * per system. Once available, all BOs accessible from device should be
> + * allocated from this memory.
> + */
> +u64 carveout_addr;
> +module_param(carveout_addr, ullong, 0400);
> +MODULE_PARM_DESC(carveout_addr, "Physical memory address for reserved memory chunk");
> +
> +u64 carveout_size;
> +module_param(carveout_size, ullong, 0400);
> +MODULE_PARM_DESC(carveout_size, "Physical memory size for reserved memory chunk");
> +
> +struct amdxdna_carveout {
> +	struct drm_mm	mm;
> +	struct mutex	lock; /* protect mm */
> +} carveout;
> +
> +bool amdxdna_use_carveout(void)
> +{
> +	return !!carveout_size;
> +}
> +
> +void amdxdna_carveout_init(void)
> +{
> +	if (!amdxdna_use_carveout())
> +		return;
> +	mutex_init(&carveout.lock);
> +	drm_mm_init(&carveout.mm, carveout_addr, carveout_size);
> +	pr_info("Use carveout mem, addr=0x%llx, size=0x%llx\n", carveout_addr, carveout_size);
> +}
> +
> +void amdxdna_carveout_fini(void)
> +{
> +	if (!amdxdna_use_carveout())
> +		return;
> +	drm_mm_takedown(&carveout.mm);
> +	mutex_destroy(&carveout.lock);
> +}
> +
> +struct amdxdna_cbuf_priv {
> +	struct drm_mm_node node;
> +};
> +
> +static struct sg_table *amdxdna_cbuf_map(struct dma_buf_attachment *attach,
> +					 enum dma_data_direction direction)
> +{
> +	struct amdxdna_cbuf_priv *cbuf = attach->dmabuf->priv;
> +	struct device *dev = attach->dev;
> +	struct scatterlist *sgl, *sg;
> +	int ret, n_entries, i;
> +	struct sg_table *sgt;
> +	dma_addr_t dma_addr;
> +	size_t dma_size;
> +	size_t max_seg;
> +
> +	sgt = kzalloc_obj(*sgt);
> +	if (!sgt)
> +		return ERR_PTR(-ENOMEM);
> +
> +	max_seg = min_t(size_t, UINT_MAX, dma_max_mapping_size(dev));
> +	n_entries = (cbuf->node.size + max_seg - 1) / max_seg;
> +	sgl = kzalloc_objs(*sg, n_entries);
> +	if (!sgl) {
> +		ret = -ENOMEM;
> +		goto free_sgt;
> +	}
> +	sg_init_table(sgl, n_entries);
> +	sgt->orig_nents = n_entries;
> +	sgt->nents = n_entries;
> +	sgt->sgl = sgl;
> +
> +	dma_size = cbuf->node.size;
> +	dma_addr = dma_map_resource(dev, cbuf->node.start, dma_size,
> +				    direction, DMA_ATTR_SKIP_CPU_SYNC);
> +	ret = dma_mapping_error(dev, dma_addr);
> +	if (ret) {
> +		pr_err("Failed to dma_map_resource carveout dma buf, ret %d\n", ret);
> +		goto free_sgl;
> +	}
> +
> +	for_each_sgtable_dma_sg(sgt, sg, i) {
> +		size_t len = min_t(size_t, max_seg, dma_size);
> +
> +		sg_dma_address(sg) = dma_addr;
> +		sg_dma_len(sg) = len;
> +		dma_addr += len;
> +		dma_size -= len;
> +	}
> +
> +	return sgt;
> +
> +free_sgl:
> +	kfree(sgl);
> +free_sgt:
> +	kfree(sgt);
> +	return ERR_PTR(ret);
> +}
> +
> +static void amdxdna_cbuf_unmap(struct dma_buf_attachment *attach,
> +			       struct sg_table *sgt,
> +			       enum dma_data_direction direction)
> +{
> +	dma_unmap_resource(attach->dev, sg_dma_address(sgt->sgl),
> +			   drm_prime_get_contiguous_size(sgt), direction,
> +			   DMA_ATTR_SKIP_CPU_SYNC);
> +	sg_free_table(sgt);
> +	kfree(sgt);
> +}
> +
> +static void amdxdna_cbuf_release(struct dma_buf *dbuf)
> +{
> +	struct amdxdna_cbuf_priv *cbuf = dbuf->priv;
> +
> +	mutex_lock(&carveout.lock);
> +	drm_mm_remove_node(&cbuf->node);
> +	mutex_unlock(&carveout.lock);
> +
> +	kfree(cbuf);
> +}
> +
> +static vm_fault_t amdxdna_cbuf_vm_fault(struct vm_fault *vmf)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	struct amdxdna_cbuf_priv *cbuf;
> +	unsigned long pfn;
> +	pgoff_t pgoff;
> +
> +	cbuf = vma->vm_private_data;
> +	pgoff = (vmf->address - vma->vm_start) >> PAGE_SHIFT;
> +	pfn = (cbuf->node.start >> PAGE_SHIFT) + pgoff;
> +
> +	return vmf_insert_pfn(vma, vmf->address, pfn);
> +}
> +
> +static const struct vm_operations_struct amdxdna_cbuf_vm_ops = {
> +	.fault = amdxdna_cbuf_vm_fault,
> +};
> +
> +static int amdxdna_cbuf_mmap(struct dma_buf *dbuf, struct vm_area_struct *vma)
> +{
> +	struct amdxdna_cbuf_priv *cbuf = dbuf->priv;
> +
> +	vma->vm_ops = &amdxdna_cbuf_vm_ops;
> +	vma->vm_private_data = cbuf;
> +	vm_flags_set(vma, VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
> +
> +	return 0;
> +}
> +
> +static int amdxdna_cbuf_vmap(struct dma_buf *dbuf, struct iosys_map *map)
> +{
> +	struct amdxdna_cbuf_priv *cbuf = dbuf->priv;
> +	void *kva;
> +
> +	kva = memremap(cbuf->node.start, cbuf->node.size, MEMREMAP_WB);
> +	if (!kva) {
> +		pr_err("Failed to vmap carveout dma buf\n");
> +		return -ENOMEM;
> +	}
> +
> +	iosys_map_set_vaddr(map, kva);
> +	return 0;
> +}
> +
> +static void amdxdna_cbuf_vunmap(struct dma_buf *dbuf, struct iosys_map *map)
> +{
> +	memunmap(map->vaddr);
> +}
> +
> +static const struct dma_buf_ops amdxdna_cbuf_dmabuf_ops = {
> +	.map_dma_buf = amdxdna_cbuf_map,
> +	.unmap_dma_buf = amdxdna_cbuf_unmap,
> +	.release = amdxdna_cbuf_release,
> +	.mmap = amdxdna_cbuf_mmap,
> +	.vmap = amdxdna_cbuf_vmap,
> +	.vunmap = amdxdna_cbuf_vunmap,
> +};
> +
> +static int amdxdna_cbuf_clear(struct dma_buf *dbuf)
> +{
> +	struct iosys_map vmap = IOSYS_MAP_INIT_VADDR(NULL);
> +
> +	dma_buf_vmap(dbuf, &vmap);
> +	if (!vmap.vaddr)
> +		return -EFAULT;
> +
> +	memset(vmap.vaddr, 0, dbuf->size);
> +	dma_buf_vunmap(dbuf, &vmap);
> +
> +	return 0;
> +}
> +
> +struct dma_buf *amdxdna_get_cbuf(struct drm_device *dev, size_t size, u64 alignment)
> +{
> +	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> +	struct amdxdna_cbuf_priv *cbuf;
> +	struct dma_buf *dbuf;
> +	int ret;
> +
> +	cbuf = kzalloc_obj(*cbuf);
> +	if (!cbuf)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mutex_lock(&carveout.lock);
> +	ret = drm_mm_insert_node_generic(&carveout.mm, &cbuf->node, size,
> +					 alignment, 0, DRM_MM_INSERT_BEST);
> +	mutex_unlock(&carveout.lock);
> +	if (ret)
> +		goto free_cbuf;
> +
> +	exp_info.size = size;
> +	exp_info.ops = &amdxdna_cbuf_dmabuf_ops;
> +	exp_info.priv = cbuf;
> +	exp_info.flags = O_RDWR;
> +	dbuf = dma_buf_export(&exp_info);
> +	if (IS_ERR(dbuf)) {
> +		ret = PTR_ERR(dbuf);
> +		goto remove_node;
> +	}
> +
> +	ret = amdxdna_cbuf_clear(dbuf);
> +	if (ret) {
> +		dma_buf_put(dbuf);
> +		goto out;
> +	}
> +	return dbuf;
> +
> +remove_node:
> +	drm_mm_remove_node(&cbuf->node);
> +free_cbuf:
> +	kfree(cbuf);
> +out:
> +	return ERR_PTR(ret);
> +}
> diff --git a/drivers/accel/amdxdna/amdxdna_cbuf.h b/drivers/accel/amdxdna/amdxdna_cbuf.h
> new file mode 100644
> index 000000000000..15e189ce779e
> --- /dev/null
> +++ b/drivers/accel/amdxdna/amdxdna_cbuf.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2026, Advanced Micro Devices, Inc.
> + */
> +#ifndef _AMDXDNA_CBUF_H_
> +#define _AMDXDNA_CBUF_H_
> +
> +#include <drm/drm_device.h>
> +#include <linux/dma-buf.h>
> +
> +bool amdxdna_use_carveout(void);
> +void amdxdna_carveout_init(void);
> +void amdxdna_carveout_fini(void);
> +struct dma_buf *amdxdna_get_cbuf(struct drm_device *dev, size_t size, u64 alignment);
> +
> +#endif
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index 238ee244d4a6..905514ec183c 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -16,6 +16,7 @@
>   #include <linux/pagemap.h>
>   #include <linux/vmalloc.h>
>   
> +#include "amdxdna_cbuf.h"
>   #include "amdxdna_ctx.h"
>   #include "amdxdna_gem.h"
>   #include "amdxdna_pci_drv.h"
> @@ -516,10 +517,6 @@ static void amdxdna_imported_obj_free(struct amdxdna_gem_obj *abo)
>   static inline bool
>   amdxdna_gem_skip_bo_usage(struct amdxdna_gem_obj *abo)
>   {
> -	/* Do not count imported BOs since the buffer is not allocated by us. */
> -	if (is_import_bo(abo))
> -		return true;
> -
>   	/* Already counted as part of HEAP BO */
>   	if (abo->type == AMDXDNA_BO_DEV)
>   		return true;
> @@ -571,9 +568,7 @@ static void amdxdna_gem_obj_free(struct drm_gem_object *gobj)
>   	if (abo->type == AMDXDNA_BO_DEV_HEAP)
>   		drm_mm_takedown(&abo->mm);
>   
> -	if (amdxdna_iova_on(xdna))
> -		amdxdna_iommu_unmap_bo(xdna, abo);
> -
> +	amdxdna_dma_unmap_bo(xdna, abo);
>   	amdxdna_gem_vunmap(abo);
>   	mutex_destroy(&abo->lock);
>   
> @@ -591,18 +586,20 @@ static int amdxdna_gem_obj_open(struct drm_gem_object *gobj, struct drm_file *fi
>   
>   	guard(mutex)(&abo->lock);
>   	abo->open_ref++;
> +	if (abo->open_ref > 1)
> +		return 0;
>   
> -	if (abo->open_ref == 1) {
> -		/* Attached to the client when first opened by it. */
> -		abo->client = filp->driver_priv;
> -		amdxdna_gem_add_bo_usage(abo);
> -	}
> -	if (amdxdna_iova_on(xdna)) {
> -		ret = amdxdna_iommu_map_bo(xdna, abo);
> +	/* Attached to the client when first opened by it. */
> +	abo->client = filp->driver_priv;
> +
> +	/* No need to set up dma addr mapping in PASID mode. */
> +	if (!amdxdna_pasid_on(abo->client)) {
> +		ret = amdxdna_dma_map_bo(xdna, abo);
>   		if (ret)
>   			return ret;
>   	}
>   
> +	amdxdna_gem_add_bo_usage(abo);
>   	return 0;
>   }
>   
> @@ -620,6 +617,39 @@ static void amdxdna_gem_obj_close(struct drm_gem_object *gobj, struct drm_file *
>   	}
>   }
>   
> +static int amdxdna_gem_obj_vmap(struct drm_gem_object *obj, struct iosys_map *map)
> +{
> +	struct amdxdna_gem_obj *abo = to_xdna_obj(obj);
> +	int ret;
> +
> +	iosys_map_clear(map);
> +
> +	dma_resv_assert_held(obj->resv);
> +
> +	if (is_import_bo(abo))
> +		ret = dma_buf_vmap(abo->dma_buf, map);
> +	else
> +		ret = drm_gem_shmem_object_vmap(obj, map);
> +	if (ret)
> +		return ret;
> +	if (!map->vaddr)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static void amdxdna_gem_obj_vunmap(struct drm_gem_object *obj, struct iosys_map *map)
> +{
> +	struct amdxdna_gem_obj *abo = to_xdna_obj(obj);
> +
> +	dma_resv_assert_held(obj->resv);
> +
> +	if (is_import_bo(abo))
> +		dma_buf_vunmap(abo->dma_buf, map);
> +	else
> +		drm_gem_shmem_object_vunmap(obj, map);
> +}
> +
>   static int amdxdna_gem_dev_obj_vmap(struct drm_gem_object *obj, struct iosys_map *map)
>   {
>   	struct amdxdna_gem_obj *abo = to_xdna_obj(obj);
> @@ -645,8 +675,8 @@ static const struct drm_gem_object_funcs amdxdna_gem_shmem_funcs = {
>   	.pin = drm_gem_shmem_object_pin,
>   	.unpin = drm_gem_shmem_object_unpin,
>   	.get_sg_table = drm_gem_shmem_object_get_sg_table,
> -	.vmap = drm_gem_shmem_object_vmap,
> -	.vunmap = drm_gem_shmem_object_vunmap,
> +	.vmap = amdxdna_gem_obj_vmap,
> +	.vunmap = amdxdna_gem_obj_vunmap,
>   	.mmap = amdxdna_gem_obj_mmap,
>   	.vm_ops = &drm_gem_shmem_vm_ops,
>   	.export = amdxdna_gem_prime_export,
> @@ -714,6 +744,36 @@ amdxdna_gem_create_ubuf_object(struct drm_device *dev, struct amdxdna_drm_create
>   	return to_xdna_obj(gobj);
>   }
>   
> +static struct amdxdna_gem_obj *
> +amdxdna_gem_create_cbuf_object(struct drm_device *dev, struct amdxdna_drm_create_bo *args)
> +{
> +	struct amdxdna_dev *xdna = to_xdna_dev(dev);
> +	size_t size = PAGE_ALIGN(args->size);
> +	struct drm_gem_object *gobj;
> +	struct amdxdna_gem_obj *ret;
> +	struct dma_buf *dma_buf;
> +	u64 align;
> +
> +	if (!size) {
> +		XDNA_ERR(xdna, "Invalid BO size 0x%llx", args->size);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	align = (args->type == AMDXDNA_BO_DEV_HEAP) ?  xdna->dev_info->dev_mem_size : 0;
> +	dma_buf = amdxdna_get_cbuf(dev, size, align);
> +	if (IS_ERR(dma_buf))
> +		return ERR_CAST(dma_buf);
> +
> +	gobj = amdxdna_gem_prime_import(dev, dma_buf);
> +	if (IS_ERR(gobj))
> +		ret = ERR_CAST(gobj);
> +	else
> +		ret = to_xdna_obj(gobj);
> +
> +	dma_buf_put(dma_buf);
> +	return ret;
> +}
> +
>   struct drm_gem_object *
>   amdxdna_gem_prime_import(struct drm_device *dev, struct dma_buf *dma_buf)
>   {
> @@ -769,6 +829,8 @@ amdxdna_drm_create_share_bo(struct drm_device *dev,
>   
>   	if (args->vaddr)
>   		abo = amdxdna_gem_create_ubuf_object(dev, args);
> +	else if (amdxdna_use_carveout())
> +		abo = amdxdna_gem_create_cbuf_object(dev, args);
>   	else
>   		abo = amdxdna_gem_create_shmem_object(dev, args);
>   	if (IS_ERR(abo))
> @@ -884,7 +946,6 @@ int amdxdna_drm_create_bo_ioctl(struct drm_device *dev, void *data, struct drm_f
>   		 args->type, args->vaddr, args->size, args->flags);
>   	switch (args->type) {
>   	case AMDXDNA_BO_CMD:
> -		fallthrough;
>   	case AMDXDNA_BO_SHARE:
>   		abo = amdxdna_drm_create_share_bo(dev, args, filp);
>   		break;
> diff --git a/drivers/accel/amdxdna/amdxdna_iommu.c b/drivers/accel/amdxdna/amdxdna_iommu.c
> index 5a9f06183487..eff00131d0f8 100644
> --- a/drivers/accel/amdxdna/amdxdna_iommu.c
> +++ b/drivers/accel/amdxdna/amdxdna_iommu.c
> @@ -35,14 +35,15 @@ static struct iova *amdxdna_iommu_alloc_iova(struct amdxdna_dev *xdna,
>   	return iova;
>   }
>   
> -int amdxdna_iommu_map_bo(struct amdxdna_dev *xdna, struct amdxdna_gem_obj *abo)
> +int amdxdna_dma_map_bo(struct amdxdna_dev *xdna, struct amdxdna_gem_obj *abo)
>   {
> +	unsigned long contig_sz;
>   	struct sg_table *sgt;
>   	dma_addr_t dma_addr;
>   	struct iova *iova;
>   	ssize_t size;
>   
> -	if (abo->type != AMDXDNA_BO_DEV_HEAP && abo->type != AMDXDNA_BO_SHMEM)
> +	if (abo->type != AMDXDNA_BO_DEV_HEAP && abo->type != AMDXDNA_BO_SHARE)
>   		return 0;
>   
>   	sgt = drm_gem_shmem_get_pages_sgt(&abo->base);
> @@ -51,47 +52,63 @@ int amdxdna_iommu_map_bo(struct amdxdna_dev *xdna, struct amdxdna_gem_obj *abo)
>   		return PTR_ERR(sgt);
>   	}
>   
> -	if (!sgt->orig_nents || !sg_page(sgt->sgl)) {
> -		XDNA_ERR(xdna, "sgl is zero length or not page backed");
> +	if (!sgt->orig_nents) {
> +		XDNA_ERR(xdna, "sgl is zero length");
>   		return -EOPNOTSUPP;
>   	}
>   
> -	iova = amdxdna_iommu_alloc_iova(xdna, abo->mem.size, &dma_addr,
> -					(abo->type == AMDXDNA_BO_DEV_HEAP));
> -	if (IS_ERR(iova)) {
> -		XDNA_ERR(xdna, "Alloc iova failed, ret %ld", PTR_ERR(iova));
> -		return PTR_ERR(iova);
> +	if (amdxdna_iova_on(xdna)) {
> +		if (!sg_page(sgt->sgl)) {
> +			XDNA_ERR(xdna, "sgl is not page backed");
> +			return -EOPNOTSUPP;
> +		}
> +
> +		iova = amdxdna_iommu_alloc_iova(xdna, abo->mem.size, &dma_addr,
> +						(abo->type == AMDXDNA_BO_DEV_HEAP));
> +		if (IS_ERR(iova)) {
> +			XDNA_ERR(xdna, "Alloc iova failed, ret %ld", PTR_ERR(iova));
> +			return PTR_ERR(iova);
> +		}
> +
> +		size = iommu_map_sgtable(xdna->domain, dma_addr, sgt,
> +					 IOMMU_READ | IOMMU_WRITE);
> +		if (size < 0) {
> +			XDNA_ERR(xdna, "iommu_map_sgtable failed: %zd", size);
> +			__free_iova(&xdna->iovad, iova);
> +			return size;
> +		}
> +		if (size < abo->mem.size) {
> +			iommu_unmap(xdna->domain, dma_addr, size);
> +			__free_iova(&xdna->iovad, iova);
> +			return -ENXIO;
> +		}
> +		abo->mem.dma_addr = dma_addr;
> +	} else {
> +		/* Device doesn't support scatter/gather list, fail non-contiguous mapping. */
> +		contig_sz = drm_prime_get_contiguous_size(sgt);
> +		if (contig_sz < abo->mem.size) {
> +			XDNA_ERR(xdna,
> +				 "noncontiguous dma addr, contig size:%ld, expected size:%ld",
> +				 contig_sz, abo->mem.size);
> +			return -EINVAL;
> +		}
> +		abo->mem.dma_addr = sg_dma_address(sgt->sgl);
>   	}
> -
> -	size = iommu_map_sgtable(xdna->domain, dma_addr, sgt,
> -				 IOMMU_READ | IOMMU_WRITE);
> -	if (size < 0) {
> -		XDNA_ERR(xdna, "iommu_map_sgtable failed: %zd", size);
> -		__free_iova(&xdna->iovad, iova);
> -		return size;
> -	}
> -
> -	if (size < abo->mem.size) {
> -		iommu_unmap(xdna->domain, dma_addr, size);
> -		__free_iova(&xdna->iovad, iova);
> -		return -ENXIO;
> -	}
> -
> -	abo->mem.dma_addr = dma_addr;
> -
>   	return 0;
>   }
>   
> -void amdxdna_iommu_unmap_bo(struct amdxdna_dev *xdna, struct amdxdna_gem_obj *abo)
> +void amdxdna_dma_unmap_bo(struct amdxdna_dev *xdna, struct amdxdna_gem_obj *abo)
>   {
>   	size_t size;
>   
>   	if (abo->mem.dma_addr == AMDXDNA_INVALID_ADDR)
>   		return;
>   
> -	size = iova_align(&xdna->iovad, abo->mem.size);
> -	iommu_unmap(xdna->domain, abo->mem.dma_addr, size);
> -	free_iova(&xdna->iovad, iova_pfn(&xdna->iovad, abo->mem.dma_addr));
> +	if (amdxdna_iova_on(xdna)) {
> +		size = iova_align(&xdna->iovad, abo->mem.size);
> +		iommu_unmap(xdna->domain, abo->mem.dma_addr, size);
> +		free_iova(&xdna->iovad, iova_pfn(&xdna->iovad, abo->mem.dma_addr));
> +	}
>   	abo->mem.dma_addr = AMDXDNA_INVALID_ADDR;
>   }
>   
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> index 21eddfc538d0..b8c5dbc12489 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> @@ -14,6 +14,7 @@
>   #include <linux/iommu.h>
>   #include <linux/pci.h>
>   
> +#include "amdxdna_cbuf.h"
>   #include "amdxdna_ctx.h"
>   #include "amdxdna_gem.h"
>   #include "amdxdna_pci_drv.h"
> @@ -67,11 +68,40 @@ static const struct amdxdna_device_id amdxdna_ids[] = {
>   	{0}
>   };
>   
> +static int amdxdna_sva_init(struct amdxdna_client *client)
> +{
> +	struct amdxdna_dev *xdna = client->xdna;
> +
> +	client->sva = iommu_sva_bind_device(xdna->ddev.dev, client->mm);
> +	if (IS_ERR(client->sva)) {
> +		XDNA_ERR(xdna, "SVA bind device failed, ret %ld", PTR_ERR(client->sva));
> +		return PTR_ERR(client->sva);
> +	}
> +
> +	client->pasid = iommu_sva_get_pasid(client->sva);
> +	if (client->pasid == IOMMU_PASID_INVALID) {
> +		iommu_sva_unbind_device(client->sva);
> +		XDNA_ERR(xdna, "SVA get pasid failed");
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static void amdxdna_sva_fini(struct amdxdna_client *client)
> +{
> +	if (IS_ERR_OR_NULL(client->sva))
> +		return;
> +
> +	iommu_sva_unbind_device(client->sva);
> +	client->sva = NULL;
> +	client->pasid = IOMMU_PASID_INVALID;
> +}
> +
>   static int amdxdna_drm_open(struct drm_device *ddev, struct drm_file *filp)
>   {
>   	struct amdxdna_dev *xdna = to_xdna_dev(ddev);
>   	struct amdxdna_client *client;
> -	int ret;
>   
>   	client = kzalloc_obj(*client);
>   	if (!client)
> @@ -80,22 +110,13 @@ static int amdxdna_drm_open(struct drm_device *ddev, struct drm_file *filp)
>   	client->pid = pid_nr(rcu_access_pointer(filp->pid));
>   	client->xdna = xdna;
>   	client->pasid = IOMMU_PASID_INVALID;
> +	client->mm = current->mm;
>   
>   	if (!amdxdna_iova_on(xdna)) {
> -		client->sva = iommu_sva_bind_device(xdna->ddev.dev, current->mm);
> -		if (IS_ERR(client->sva)) {
> -			ret = PTR_ERR(client->sva);
> -			XDNA_ERR(xdna, "SVA bind device failed, ret %d", ret);
> -			goto failed;
> -		}
> -		client->pasid = iommu_sva_get_pasid(client->sva);
> -		if (client->pasid == IOMMU_PASID_INVALID) {
> -			XDNA_ERR(xdna, "SVA get pasid failed");
> -			ret = -ENODEV;
> -			goto unbind_sva;
> -		}
> +		/* No need to fail open since user may use pa + carveout later. */
> +		if (amdxdna_sva_init(client))
> +			XDNA_WARN(xdna, "PASID not available for pid %d", client->pid);
>   	}
> -	client->mm = current->mm;
>   	mmgrab(client->mm);
>   	init_srcu_struct(&client->hwctx_srcu);
>   	xa_init_flags(&client->hwctx_xa, XA_FLAGS_ALLOC);
> @@ -110,14 +131,6 @@ static int amdxdna_drm_open(struct drm_device *ddev, struct drm_file *filp)
>   
>   	XDNA_DBG(xdna, "pid %d opened", client->pid);
>   	return 0;
> -
> -unbind_sva:
> -	if (!IS_ERR_OR_NULL(client->sva))
> -		iommu_sva_unbind_device(client->sva);
> -failed:
> -	kfree(client);
> -
> -	return ret;
>   }
>   
>   static void amdxdna_client_cleanup(struct amdxdna_client *client)
> @@ -131,11 +144,8 @@ static void amdxdna_client_cleanup(struct amdxdna_client *client)
>   		drm_gem_object_put(to_gobj(client->dev_heap));
>   
>   	mutex_destroy(&client->mm_lock);
> -
> -	if (!IS_ERR_OR_NULL(client->sva))
> -		iommu_sva_unbind_device(client->sva);
>   	mmdrop(client->mm);
> -
> +	amdxdna_sva_fini(client);
>   	kfree(client);
>   }
>   
> @@ -242,15 +252,17 @@ static void amdxdna_show_fdinfo(struct drm_printer *p, struct drm_file *filp)
>   
>   	/*
>   	 * Note for driver specific BO memory usage stat.
> -	 * Total memory alloc = amdxdna-internal-alloc + amdxdna-external-alloc
> +	 * Total memory in use = amdxdna-internal-alloc + amdxdna-external-alloc, which
> +	 * includes both imported and created BOs. To avoid double counts, it includes
> +	 * HEAP BO, but not DEV BO. DEV BO is counted by amdxdna-heap-alloc.
>   	 */
>   	drm_fdinfo_print_size(p, drv_name, "heap", "alloc", heap_usage);
>   	drm_fdinfo_print_size(p, drv_name, "internal", "alloc", internal_usage);
>   	drm_fdinfo_print_size(p, drv_name, "external", "alloc", external_usage);
>   	/*
>   	 * Note for DRM standard BO memory stat.
> -	 * drm-total-memory counts both DEV BO and HEAP BO
> -	 * drm-shared-memory counts BO imported
> +	 * drm-total-memory counts both DEV BO and HEAP BO. The DEV BO size is double counted.
> +	 * drm-shared-memory counts BO shared with other processes/devices.
>   	 */
>   	drm_show_memory_stats(p, filp);
>   }
> @@ -420,7 +432,26 @@ static struct pci_driver amdxdna_pci_driver = {
>   	.sriov_configure = amdxdna_sriov_configure,
>   };
>   
> -module_pci_driver(amdxdna_pci_driver);
> +static int __init amdxdna_mod_init(void)
> +{
> +	int ret;
> +
> +	amdxdna_carveout_init();
> +	ret = pci_register_driver(&amdxdna_pci_driver);
> +	if (ret)
> +		amdxdna_carveout_fini();
> +
> +	return ret;
> +}
> +
> +static void __exit amdxdna_mod_exit(void)
> +{
> +	pci_unregister_driver(&amdxdna_pci_driver);
> +	amdxdna_carveout_fini();
> +}
> +
> +module_init(amdxdna_mod_init);
> +module_exit(amdxdna_mod_exit);
>   
>   MODULE_LICENSE("GPL");
>   MODULE_IMPORT_NS("AMD_PMF");
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
> index bdd0dc83f92e..07bd38281452 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
> @@ -172,11 +172,11 @@ void amdxdna_sysfs_fini(struct amdxdna_dev *xdna);
>   
>   int amdxdna_iommu_init(struct amdxdna_dev *xdna);
>   void amdxdna_iommu_fini(struct amdxdna_dev *xdna);
> -int amdxdna_iommu_map_bo(struct amdxdna_dev *xdna, struct amdxdna_gem_obj *abo);
> -void amdxdna_iommu_unmap_bo(struct amdxdna_dev *xdna, struct amdxdna_gem_obj *abo);
>   void *amdxdna_iommu_alloc(struct amdxdna_dev *xdna, size_t size, dma_addr_t *dma_addr);
>   void amdxdna_iommu_free(struct amdxdna_dev *xdna, size_t size,
>   			void *cpu_addr, dma_addr_t dma_addr);
> +int amdxdna_dma_map_bo(struct amdxdna_dev *xdna, struct amdxdna_gem_obj *abo);
> +void amdxdna_dma_unmap_bo(struct amdxdna_dev *xdna, struct amdxdna_gem_obj *abo);
>   
>   static inline bool amdxdna_iova_on(struct amdxdna_dev *xdna)
>   {

