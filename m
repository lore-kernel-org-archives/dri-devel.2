Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640611061B32
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 11:25:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02B3010EC74;
	Tue, 31 Mar 2026 11:25:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NJ3R/+qw";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011013.outbound.protection.outlook.com
 [40.93.194.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E89CB10EC74;
 Tue, 31 Mar 2026 11:25:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ORoRVCyQQnWxBRF2XXBk8u5t+8qJWfmFfSY63ETxa6O7wMrJKkIrk4LoU5zDpjgIAx0iQJSdIOG2A+COrkJtIZP51LhvFL5GL+SbwRzx9UrQp1vHUa23h7VnqXMu76bQR9wQXzYlfXdiM5iRADhHlejROjZQoqTK288lySIvVKGNEVd3nWceGxEIpMH3ffqKB+L1Af5nVjQq3ESBgIa0xhTahvV6cB6At98vNiJVayjWcohqqF6cvs7TNHN2K5+bRwBogxM865fs0FY8CPNGqXLjyZSbuMfr1Hd4si8+8oyk6WLe4hZjqNjZ0kXc+NAXfnmmL8hNjo/N2gaOMGeUfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DanmF/d+ccHw40VxcqCGVqX00R31aGJtnbw4MSZfo8c=;
 b=CrCva+g47vkmzSQb9fGXC5BXksLWTPQXyGZld3ZnGHpVe0TGkMu0w7CRv98gYT12Tg1h052rsEpHbgXHYJXcrUrecxJdktDKztOat9H8n5fY4R0Sx7e/H1hvAFa1YMi6pe2mPyp31kn7qG2c8VQHX4OR0dOM4RXtN9kmvYGNDWfidIR6+SbROBJQnug1sTPj1p49nevO+LZ14wBIn5Xq8jnnBmFXrVva2ZKr7QDMu1AkQeyGRs4ukdunhbZVYuz+kdmSY6V0GVCw8Zo4FXMX/SDjw7O4vXBbJDFqiasZpBsu7pI1JOja+tETQHdy00GdSoKFt/ObjUQcqJ5DP6c9Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DanmF/d+ccHw40VxcqCGVqX00R31aGJtnbw4MSZfo8c=;
 b=NJ3R/+qwoMIhP91fDi/ML1y/YB1WxLxSYcgRyIWEAnX25lCMGNfvraeV3PGdrNlgMfHPe339+yFHjzKSIxLiYaMYbSiqh1J+iLQMk8esnnaFI+BdGToZwxkCsJypXC6ye7tZZuZ0zQaQ83WDDprput/mD3qJTNt5NfVbe5dQQ8M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6446.namprd12.prod.outlook.com (2603:10b6:8:be::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.16; Tue, 31 Mar 2026 11:24:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 11:24:57 +0000
Message-ID: <01989c65-1e1e-4f78-ac88-a1c76961b3c3@amd.com>
Date: Tue, 31 Mar 2026 13:24:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: deduplicate register access and helper
 routines
To: Gabriel Almeida <gabrielsousa230@gmail.com>, alexander.deucher@amd.com,
 airlied@gmail.com, simona@ffwll.ch
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260330224503.548284-1-gabrielsousa230@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260330224503.548284-1-gabrielsousa230@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P221CA0037.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:5b5::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: e4b9e5fe-abf2-4fe8-ab47-08de8f1823cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: HKpqACI/Dgu6Ph5bo8rzOhRp1rRA16kqz8dCEzqHvTD0nHm+fd3h6+KZEdkxZUQ5uJB+K6e847SefiflMJDu/DvV80Zlb3H527Ixzxcosjwh9IrQuRmJeoBSdEjYXYVNw8u1+9Z+NQE3iiK5bUVshEIAF6Q9hQhAvXXNOuERizeVBm/TpgHKYsRf91wY+Jsg/p1WecpWKtFlemfbFtOHSdcnWbD9joZ5a8HyC8lvugAd1qWXT32h69do3KQ/fRSurVkVUkhH2oeRgbwrxu7kTYC8bjNuyhTaCB0vvtFbZsV9fiiMbBjHYwWyaRoKlHX7e13B7RCQhJOSDG/c0nM1PuX2Fn1i39CN5gSnA9Ha/EU+eBcJ7JWNmPLHXPCsKpSeFt0KUbQnpKJaXBGdLGXwNh30o+ps8UbXv5+Bo3k2ATM2cxWJNrJYCWlHQbmNc1J3p4ueXg1utVogf7PJkHmhMVm+xZi04xhJ/ehq53p7m4oEwj4YCwb6lpt6wueXRcXrFapp5WkT+c7HNUzozwRATKgFwfyw20ucInP12VHxKHzMkcZ1MyHFob+wGgjyDPid1E9AGjF7b1P8u9zOIlhZPYJ4jnw7xzoWEiQftTqhGPZbDakmZi2KmvB9JlW9Gop6wYLxX/Zgd4HY8WCWCFgINh3SMzb49d769JjRFOnYQ5Gi9w5ObsTnwxELzQaZv/K6UgVSK76vHOEesoZVfGVX9UFN3s/lqtyB0AN9122df0Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFBkZGhSZUQxVWlEdlJhR1ptT0hNN0hmK2RlbE5ISTVzSGFnZ2srUTdWTjZP?=
 =?utf-8?B?NlFvdkR4M01SMXUyT0tNYU05ZHVNNmd5WWgyUWFBVUo2YU0vQi93c2Z2VUIv?=
 =?utf-8?B?UTZxbjdwYklxcFVybDh5TEVFcjdDRjZQaG4rd2ZXems3ejdrTk1qbWVWVUtK?=
 =?utf-8?B?eXlveHVoK3UzVWhxeDgyQW9tL01Lbi9ENUlJOUdJMjA2SEhmdlBwa3dPMmRS?=
 =?utf-8?B?QnJKYVhpcEFOWE5YS21XTjQ3RVJqcW9saHA5MFlPbEFXMjB6aUdrdDhvaTV4?=
 =?utf-8?B?aHk4T2FVTUJhMkhwVjVudEdIQ04zbmRVY3YvS3MyL0VSN1Vtc2FINHhyc2k4?=
 =?utf-8?B?RGc1THgwVTNHQ3Q4VnpMdHVrTGJKS2NrMUwyY043djZOSXMrQlltK0IrcGVY?=
 =?utf-8?B?NkFGbGZZczhFV1FVYVErWTgrcjM3VjJmTGVaaWRnUTBFcXRVQXF4OXBhRTVh?=
 =?utf-8?B?NWRTajMzSnFrUHNwd1ZxL2JBMWg2eUhXaTBJdnVTbFl1VDh6Y09JclhlLzZT?=
 =?utf-8?B?QXkyaGVwR1NlamtqWThzeUhnNURNdk51TWRRL0FDN2JHS2I5YjlDakxiSlRy?=
 =?utf-8?B?KytoTFhUc2ErZzdzc1YzSlBFYm1na1ZvalJJRmUwWXd0UFVDNE53dHZRU0hi?=
 =?utf-8?B?ZWhqelA0eVdORVZ2UlFjVStsdnNud3puaXZjY3ZhVGhwcGo1ZGt0Yjd4Z2NE?=
 =?utf-8?B?UThOelRiOWdYcXVuTi9xOFRJd1ZPQkNNWEVjd3pzb3RiOXNTM25SMGFFbDNl?=
 =?utf-8?B?RmF6aHBDa3R0QTBlQWoyV3ZHMzFYWTIxSnB6c3ZrUnRiQjNsNmRpSFduTlBk?=
 =?utf-8?B?RTgwREJ4amdpQTcrdGEzdzVib1ZKUVd5M0txZTFaR21aczJzQjVHNU1XQkZF?=
 =?utf-8?B?d3NWM2Q1eGtOZldGS2dzWTM1U1dNZVB1ZVFORkpqQkdkK2lpdHpSbEdreC9x?=
 =?utf-8?B?SGM1YXdBVDdZbFpJTy8rMHRKUkJ2bmRwQy9rV3Z2WCsxNDhtSWF0ekxxNWUv?=
 =?utf-8?B?cjVSZkhUV2xyY0NXR21PVlE3UzJnZGYyOWF4bU9JRTVtaE5aZVM2b2xwc0M5?=
 =?utf-8?B?VTdtN0xkK1NlaWg0U3Z4QVZuWEhkSHhyU1V5cG9yVEdBRDdJS004RFUyWVhJ?=
 =?utf-8?B?bjNGNWZsUGhYSmJDZ0FmNk11Ykcrc1VoWjBlSDJMdHVwaE1hN2plUTBGdmRR?=
 =?utf-8?B?YmtldjhzbUhwSnZzd1dLd1FCS3l3R0ROblYwU25CQ3llZXpYYjd4MlRJTVlj?=
 =?utf-8?B?WVhSQXNEMnY3K3FMcUxiU2pQY3lmNDBuRVVHMUxHVmJ4VDArbzA4RzU4dDJP?=
 =?utf-8?B?QlVpc1dWazJjS3E1M0RVOEg2RVdPNUo2eE1YRzlNM3FNVHJVMndtOWN4dmR0?=
 =?utf-8?B?bGMvZzdaeWtQOWNKTnZqOGpRSktJS3Qzc2QzcnNDUE1oRkxPdEhBU21XaE5D?=
 =?utf-8?B?MGxyd0ZmMjdNZzhiNTFOUkw3cE1EdlNVdjk2WjROcnhlMlpBOHJqZk0rNEVO?=
 =?utf-8?B?NmJqcjM5Wk9sbjlGbEFMTXdBMzU5K2djS1NUczYwekorNEQ1TUt4eU9Vanlm?=
 =?utf-8?B?UG9ISmxZSHJlQjlZTnN4TG05R3BYVWdjVHZUYUt4RUxlOVMyV1dZcDZFYW9W?=
 =?utf-8?B?SzJhTWp6NGFuT29QQ0NuRnkwWXZWWkthdGlvdUNxb1lTRWZpR3JoaWpaR0RJ?=
 =?utf-8?B?U2RVUXEyUGVVeGRpdnFWTnE1ZzlTZzdDTzNoSzJSRG5NaDJaWDJFekR6MlIv?=
 =?utf-8?B?c2E0aHRYenlYYXJDL3hobTNhNis0Qi9JSDlEeFM5WlBrS3VNcGJhdHB6c0xH?=
 =?utf-8?B?MWlLNmlhL1JiVmFrUHdUYmZycHl1b3BTdFp6ajliWFJ3QThQKzg1azI1OTFl?=
 =?utf-8?B?dWxGZ25YZTJYS1ZianZxSHJUQXA0SFlsb1VnVm9vOUxNZkJmRzduUkJ6T0Vl?=
 =?utf-8?B?SWxEYlc0eUltR1U3QnZxcCtBUGw0UlIvdHRzNzNudUMvY0JvZXg1ajEyTFFq?=
 =?utf-8?B?SHVqOXJISzBoYUdpM3R2VGRLVFdBdWl2MXRVaGpDS00xRGZnNVZFTFNUWUdv?=
 =?utf-8?B?M3JBZC96RDJoK041VlZ6RndqRUwxQS9hTkJyQUhKOTdKVVp5anZnQXNLcXdw?=
 =?utf-8?B?VzlibEJYdUQxdFBQOTJKME1yNk9FbVoxalR1NTZIWUIvUHBrOTlKYjNvS00r?=
 =?utf-8?B?RmQvOUFWUmhhbVRkZDhQZTVCRjlMWW5sbW5QNWNuL2VQaC9WTkh1RUZRUkEx?=
 =?utf-8?B?dEV1RGlWOVJjK2cvOTZLRUxUa0lQeDY5U2RRWGllaW11WkxNTzVFeWlVNnJV?=
 =?utf-8?Q?M/DIguOSLiDP3Oj+5t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b9e5fe-abf2-4fe8-ab47-08de8f1823cd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 11:24:57.8384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EXbyPcwQSSUzlQc6yfVuYL1s8xLxY0MRoEKN3Aub2UtTjx1vPJROlo+ba2lEvdSS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6446
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

On 3/31/26 00:45, Gabriel Almeida wrote:
> Some helper functions are implemented multiple times with identical
> logic across different source files.

And that is at least sometimes completely intentional.

Background is that different headers are included which define macros with different values for each HW generation.

> 
> Extract these implementations into a shared helper file
> (amdgpu_common.c) and update existing code to reuse them.

Please don't when they are functional identical then move them a layer up instead of messing up the backends.

Regards,
Christian.

> 
> This simplifies the codebase and avoids duplication without
> changing behavior.
> 
> No functional changes intended.
> 
> Signed-off-by: Gabriel Almeida <gabrielsousa230@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile        |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_common.c | 42 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_common.h | 12 +++++++
>  drivers/gpu/drm/amd/amdgpu/nv.c            | 38 +++-----------------
>  drivers/gpu/drm/amd/amdgpu/soc15.c         | 31 ++--------------
>  drivers/gpu/drm/amd/amdgpu/soc21.c         | 38 +++-----------------
>  drivers/gpu/drm/amd/amdgpu/soc24.c         | 29 ++-------------
>  drivers/gpu/drm/amd/amdgpu/soc_v1_0.c      | 21 ++---------
>  8 files changed, 72 insertions(+), 141 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_common.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_common.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 6a7e9bfec..84cce03d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -69,6 +69,8 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
>         amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \
>         amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o
> 
> +amdgpu-y += amdgpu_common.o
> +
>  amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
> 
>  amdgpu-$(CONFIG_PERF_EVENTS) += amdgpu_pmu.o
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_common.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_common.c
> new file mode 100644
> index 000000000..34ade6f63
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_common.c
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/module.h>
> +
> +#include "amdgpu.h"
> +#include "amdgpu_common.h"
> +#include "mxgpu_nv.h"
> +
> +uint32_t read_indexed_register(struct amdgpu_device *adev,
> +                              u32 se_num, u32 sh_num, u32 reg_offset)
> +{
> +       uint32_t val;
> +
> +       mutex_lock(&adev->grbm_idx_mutex);
> +       if (se_num != 0xffffffff || sh_num != 0xffffffff)
> +               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
> +
> +       val = RREG32(reg_offset);
> +
> +       if (se_num != 0xffffffff || sh_num != 0xffffffff)
> +               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
> +       mutex_unlock(&adev->grbm_idx_mutex);
> +       return val;
> +}
> +
> +void program_aspm(struct amdgpu_device *adev)
> +{
> +       if (!amdgpu_device_should_use_aspm(adev))
> +               return;
> +
> +       if (adev->nbio.funcs->program_aspm)
> +               adev->nbio.funcs->program_aspm(adev);
> +}
> +
> +int common_sw_init(struct amdgpu_ip_block *ip_block)
> +{
> +       struct amdgpu_device *adev = ip_block->adev;
> +
> +       if (amdgpu_sriov_vf(adev))
> +               xgpu_nv_mailbox_add_irq_id(adev);
> +
> +       return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_common.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_common.h
> new file mode 100644
> index 000000000..314b3506b
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_common.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __AMDGPU_COMMON_H__
> +#define __AMDGPU_COMMON_H__
> +
> +uint32_t read_indexed_register(struct amdgpu_device *adev,
> +                              u32 se_num, u32 sh_num, u32 reg_offset);
> +
> +void program_aspm(struct amdgpu_device *adev);
> +
> +int common_sw_init(struct amdgpu_ip_block *ip_block);
> +
> +#endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 7ce1a1b95..cf8052c73 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -29,6 +29,7 @@
> 
>  #include "amdgpu.h"
>  #include "amdgpu_atombios.h"
> +#include "amdgpu_common.h"
>  #include "amdgpu_ih.h"
>  #include "amdgpu_uvd.h"
>  #include "amdgpu_vce.h"
> @@ -354,29 +355,13 @@ static struct soc15_allowed_register_entry nv_allowed_read_registers[] = {
>         { SOC15_REG_ENTRY(GC, 0, mmGB_ADDR_CONFIG)},
>  };
> 
> -static uint32_t nv_read_indexed_register(struct amdgpu_device *adev, u32 se_num,
> -                                        u32 sh_num, u32 reg_offset)
> -{
> -       uint32_t val;
> -
> -       mutex_lock(&adev->grbm_idx_mutex);
> -       if (se_num != 0xffffffff || sh_num != 0xffffffff)
> -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
> -
> -       val = RREG32(reg_offset);
> -
> -       if (se_num != 0xffffffff || sh_num != 0xffffffff)
> -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
> -       mutex_unlock(&adev->grbm_idx_mutex);
> -       return val;
> -}
> 
>  static uint32_t nv_get_register_value(struct amdgpu_device *adev,
>                                       bool indexed, u32 se_num,
>                                       u32 sh_num, u32 reg_offset)
>  {
>         if (indexed) {
> -               return nv_read_indexed_register(adev, se_num, sh_num, reg_offset);
> +               return read_indexed_register(adev, se_num, sh_num, reg_offset);
>         } else {
>                 if (reg_offset == SOC15_REG_OFFSET(GC, 0, mmGB_ADDR_CONFIG))
>                         return adev->gfx.config.gb_addr_config;
> @@ -511,16 +496,6 @@ static int nv_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk)
>         return 0;
>  }
> 
> -static void nv_program_aspm(struct amdgpu_device *adev)
> -{
> -       if (!amdgpu_device_should_use_aspm(adev))
> -               return;
> -
> -       if (adev->nbio.funcs->program_aspm)
> -               adev->nbio.funcs->program_aspm(adev);
> -
> -}
> -
>  const struct amdgpu_ip_block_version nv_common_ip_block = {
>         .type = AMD_IP_BLOCK_TYPE_COMMON,
>         .major = 1,
> @@ -965,12 +940,7 @@ static int nv_common_late_init(struct amdgpu_ip_block *ip_block)
> 
>  static int nv_common_sw_init(struct amdgpu_ip_block *ip_block)
>  {
> -       struct amdgpu_device *adev = ip_block->adev;
> -
> -       if (amdgpu_sriov_vf(adev))
> -               xgpu_nv_mailbox_add_irq_id(adev);
> -
> -       return 0;
> +       return common_sw_init(ip_block);
>  }
> 
>  static int nv_common_hw_init(struct amdgpu_ip_block *ip_block)
> @@ -984,7 +954,7 @@ static int nv_common_hw_init(struct amdgpu_ip_block *ip_block)
>                 adev->nbio.funcs->apply_l1_link_width_reconfig_wa(adev);
> 
>         /* enable aspm */
> -       nv_program_aspm(adev);
> +       program_aspm(adev);
>         /* setup nbio registers */
>         adev->nbio.funcs->init_registers(adev);
>         /* remap HDP registers to a hole in mmio space,
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index b456e4541..a6b91363d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -28,6 +28,7 @@
>  #include <drm/amdgpu_drm.h>
> 
>  #include "amdgpu.h"
> +#include "amdgpu_common.h"
>  #include "amdgpu_ih.h"
>  #include "amdgpu_uvd.h"
>  #include "amdgpu_vce.h"
> @@ -401,29 +402,12 @@ static struct soc15_allowed_register_entry soc15_allowed_read_registers[] = {
>         { SOC15_REG_ENTRY(GC, 0, mmDB_DEBUG2)},
>  };
> 
> -static uint32_t soc15_read_indexed_register(struct amdgpu_device *adev, u32 se_num,
> -                                        u32 sh_num, u32 reg_offset)
> -{
> -       uint32_t val;
> -
> -       mutex_lock(&adev->grbm_idx_mutex);
> -       if (se_num != 0xffffffff || sh_num != 0xffffffff)
> -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
> -
> -       val = RREG32(reg_offset);
> -
> -       if (se_num != 0xffffffff || sh_num != 0xffffffff)
> -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
> -       mutex_unlock(&adev->grbm_idx_mutex);
> -       return val;
> -}
> -
>  static uint32_t soc15_get_register_value(struct amdgpu_device *adev,
>                                          bool indexed, u32 se_num,
>                                          u32 sh_num, u32 reg_offset)
>  {
>         if (indexed) {
> -               return soc15_read_indexed_register(adev, se_num, sh_num, reg_offset);
> +               return read_indexed_register(adev, se_num, sh_num, reg_offset);
>         } else {
>                 if (reg_offset == SOC15_REG_OFFSET(GC, 0, mmGB_ADDR_CONFIG))
>                         return adev->gfx.config.gb_addr_config;
> @@ -695,15 +679,6 @@ static int soc15_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk
>         return 0;
>  }
> 
> -static void soc15_program_aspm(struct amdgpu_device *adev)
> -{
> -       if (!amdgpu_device_should_use_aspm(adev))
> -               return;
> -
> -       if (adev->nbio.funcs->program_aspm)
> -               adev->nbio.funcs->program_aspm(adev);
> -}
> -
>  const struct amdgpu_ip_block_version vega10_common_ip_block =
>  {
>         .type = AMD_IP_BLOCK_TYPE_COMMON,
> @@ -1284,7 +1259,7 @@ static int soc15_common_hw_init(struct amdgpu_ip_block *ip_block)
>         struct amdgpu_device *adev = ip_block->adev;
> 
>         /* enable aspm */
> -       soc15_program_aspm(adev);
> +       program_aspm(adev);
>         /* setup nbio registers */
>         adev->nbio.funcs->init_registers(adev);
>         /* remap HDP registers to a hole in mmio space,
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index fbd1d97f3..586d62202 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -27,6 +27,7 @@
> 
>  #include "amdgpu.h"
>  #include "amdgpu_atombios.h"
> +#include "amdgpu_common.h"
>  #include "amdgpu_ih.h"
>  #include "amdgpu_uvd.h"
>  #include "amdgpu_vce.h"
> @@ -306,29 +307,12 @@ static struct soc15_allowed_register_entry soc21_allowed_read_registers[] = {
>         { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
>  };
> 
> -static uint32_t soc21_read_indexed_register(struct amdgpu_device *adev, u32 se_num,
> -                                        u32 sh_num, u32 reg_offset)
> -{
> -       uint32_t val;
> -
> -       mutex_lock(&adev->grbm_idx_mutex);
> -       if (se_num != 0xffffffff || sh_num != 0xffffffff)
> -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
> -
> -       val = RREG32(reg_offset);
> -
> -       if (se_num != 0xffffffff || sh_num != 0xffffffff)
> -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
> -       mutex_unlock(&adev->grbm_idx_mutex);
> -       return val;
> -}
> -
>  static uint32_t soc21_get_register_value(struct amdgpu_device *adev,
>                                       bool indexed, u32 se_num,
>                                       u32 sh_num, u32 reg_offset)
>  {
>         if (indexed) {
> -               return soc21_read_indexed_register(adev, se_num, sh_num, reg_offset);
> +               return read_indexed_register(adev, se_num, sh_num, reg_offset);
>         } else {
>                 if (reg_offset == SOC15_REG_OFFSET(GC, 0, regGB_ADDR_CONFIG) && adev->gfx.config.gb_addr_config)
>                         return adev->gfx.config.gb_addr_config;
> @@ -470,15 +454,6 @@ static int soc21_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk
>         return 0;
>  }
> 
> -static void soc21_program_aspm(struct amdgpu_device *adev)
> -{
> -       if (!amdgpu_device_should_use_aspm(adev))
> -               return;
> -
> -       if (adev->nbio.funcs->program_aspm)
> -               adev->nbio.funcs->program_aspm(adev);
> -}
> -
>  const struct amdgpu_ip_block_version soc21_common_ip_block = {
>         .type = AMD_IP_BLOCK_TYPE_COMMON,
>         .major = 1,
> @@ -912,12 +887,7 @@ static int soc21_common_late_init(struct amdgpu_ip_block *ip_block)
> 
>  static int soc21_common_sw_init(struct amdgpu_ip_block *ip_block)
>  {
> -       struct amdgpu_device *adev = ip_block->adev;
> -
> -       if (amdgpu_sriov_vf(adev))
> -               xgpu_nv_mailbox_add_irq_id(adev);
> -
> -       return 0;
> +       return common_sw_init(ip_block);
>  }
> 
>  static int soc21_common_hw_init(struct amdgpu_ip_block *ip_block)
> @@ -925,7 +895,7 @@ static int soc21_common_hw_init(struct amdgpu_ip_block *ip_block)
>         struct amdgpu_device *adev = ip_block->adev;
> 
>         /* enable aspm */
> -       soc21_program_aspm(adev);
> +       program_aspm(adev);
>         /* setup nbio registers */
>         adev->nbio.funcs->init_registers(adev);
>         /* remap HDP registers to a hole in mmio space,
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
> index d1adf19a5..f9341c0e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
> @@ -26,6 +26,7 @@
>  #include <linux/pci.h>
> 
>  #include "amdgpu.h"
> +#include "amdgpu_common.h"
>  #include "amdgpu_ih.h"
>  #include "amdgpu_uvd.h"
>  #include "amdgpu_vce.h"
> @@ -132,31 +133,12 @@ static struct soc15_allowed_register_entry soc24_allowed_read_registers[] = {
>         { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
>  };
> 
> -static uint32_t soc24_read_indexed_register(struct amdgpu_device *adev,
> -                                           u32 se_num,
> -                                           u32 sh_num,
> -                                           u32 reg_offset)
> -{
> -       uint32_t val;
> -
> -       mutex_lock(&adev->grbm_idx_mutex);
> -       if (se_num != 0xffffffff || sh_num != 0xffffffff)
> -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
> -
> -       val = RREG32(reg_offset);
> -
> -       if (se_num != 0xffffffff || sh_num != 0xffffffff)
> -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
> -       mutex_unlock(&adev->grbm_idx_mutex);
> -       return val;
> -}
> -
>  static uint32_t soc24_get_register_value(struct amdgpu_device *adev,
>                                          bool indexed, u32 se_num,
>                                          u32 sh_num, u32 reg_offset)
>  {
>         if (indexed) {
> -               return soc24_read_indexed_register(adev, se_num, sh_num, reg_offset);
> +               return read_indexed_register(adev, se_num, sh_num, reg_offset);
>         } else {
>                 if (reg_offset == SOC15_REG_OFFSET(GC, 0, regGB_ADDR_CONFIG) &&
>                     adev->gfx.config.gb_addr_config)
> @@ -455,12 +437,7 @@ static int soc24_common_late_init(struct amdgpu_ip_block *ip_block)
> 
>  static int soc24_common_sw_init(struct amdgpu_ip_block *ip_block)
>  {
> -       struct amdgpu_device *adev = ip_block->adev;
> -
> -       if (amdgpu_sriov_vf(adev))
> -               xgpu_nv_mailbox_add_irq_id(adev);
> -
> -       return 0;
> +       return common_sw_init(ip_block);
>  }
> 
>  static int soc24_common_hw_init(struct amdgpu_ip_block *ip_block)
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> index 709b1669b..2f77fb0b6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> @@ -21,6 +21,7 @@
>   *
>   */
>  #include "amdgpu.h"
> +#include "amdgpu_common.h"
>  #include "soc15.h"
>  #include "soc15_common.h"
>  #include "soc_v1_0.h"
> @@ -184,31 +185,13 @@ static struct soc15_allowed_register_entry soc_v1_0_allowed_read_registers[] = {
>         { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG_1) },
>  };
> 
> -static uint32_t soc_v1_0_read_indexed_register(struct amdgpu_device *adev,
> -                                              u32 se_num,
> -                                              u32 sh_num,
> -                                              u32 reg_offset)
> -{
> -       uint32_t val;
> -
> -       mutex_lock(&adev->grbm_idx_mutex);
> -       if (se_num != 0xffffffff || sh_num != 0xffffffff)
> -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
> -
> -       val = RREG32(reg_offset);
> -
> -       if (se_num != 0xffffffff || sh_num != 0xffffffff)
> -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
> -       mutex_unlock(&adev->grbm_idx_mutex);
> -       return val;
> -}
> 
>  static uint32_t soc_v1_0_get_register_value(struct amdgpu_device *adev,
>                                             bool indexed, u32 se_num,
>                                             u32 sh_num, u32 reg_offset)
>  {
>         if (indexed) {
> -               return soc_v1_0_read_indexed_register(adev, se_num, sh_num, reg_offset);
> +               return read_indexed_register(adev, se_num, sh_num, reg_offset);
>         } else {
>                 if (reg_offset == SOC15_REG_OFFSET(GC, 0, regGB_ADDR_CONFIG_1) &&
>                     adev->gfx.config.gb_addr_config)
> --
> 2.43.0
> 

