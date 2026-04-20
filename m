Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61EDF557F0
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 09:13:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A5C510E136;
	Mon, 20 Apr 2026 09:13:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GC7dT96O";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011005.outbound.protection.outlook.com [52.101.52.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57B8E10E136;
 Mon, 20 Apr 2026 09:13:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5V78eccWVF6bn7h+BzJulf8+coXk2wmWoKV6gZE9Z1GtVEXzuCbzme8Wu9ZJv5Y4h145zH5ltrnz6YD5vlaTanBaJFNxPwy7OevPlrUrD3mNZEV5SuTtuD+xQL9GNiLCFm9OFWOiBJSc2SaIdHgZ4pWq18EVHE05hESrcGVu5H95ir97tLxA0DeoaXbPGKuav4PWnU6OIAn2+pBZJvdYlQWGk23Civi2zpGBB/iXw+Yfo7tPF9Z427OZYe5Z3pcU9Ol+P4HvkyYIlH7l7cBicC6ytPQyN7ln4/erCjPScZacHqJWEq9QvIkfTddLUcunqnKW8IO5PZZoz4OfxXo4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mIG2ysnDoxNtrlhfKwxh5Byl1dejGuELSzAvmDb/fE=;
 b=l+jiPrpxTH65YmeJMCwGY6CHKzNmhz+vk8L1s4X9lXWotX7fkWM826FdyINkjFeMWO6i1cVbSH7QObl4nZOZ15l/8+gN9Qu2BCVTCzGCE9rGPLeLl0PP3/lro/fIjrPsCZwHO00htvW1kiywacOXcxs+v3sv7Ijk/QdpsSoN8Rm2xSp005JtuPOxMvm0raOgwpmJyVcrxOboJvT+MR2EsxG0C5NUrh97QCPkOnpElrGovAgUQ2IjFNS6DEYT27MeHhL2oVyau0P38jtUkFQIOUsYztMvr707kzg/w0A8ly5LPf7nGfg3MpWwmRVJeum8HVNkZI0rD0nM8MWPlus1hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mIG2ysnDoxNtrlhfKwxh5Byl1dejGuELSzAvmDb/fE=;
 b=GC7dT96Oq/yzhEWr+zLKg1rFjxi+zPvbaUd4DUVK4PhuZn5LvPXjbz9P+DQDkM7p7Q4TSTmq8pTo28OtSKbUvJf2wrKPESn0VpBteoxUMEigdnptyIFMBd/EPar3cgICvSwWs5Fl4BzVfMb12SjdcvN791tZal/MEY1bQnkuOco=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by IA0PR12MB7604.namprd12.prod.outlook.com (2603:10b6:208:438::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 09:13:52 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68%5]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 09:13:52 +0000
Message-ID: <43120d24-2b69-4038-9540-dc204c75a14d@amd.com>
Date: Mon, 20 Apr 2026 11:13:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: allow unprivileged read of GC_THROTTLE_STATUS
To: mjgajda@gmail.com, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, dri-devel@lists.freedesktop.org
References: <20260417213221.937722-1-mjgajda@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260417213221.937722-1-mjgajda@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::7) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|IA0PR12MB7604:EE_
X-MS-Office365-Filtering-Correlation-Id: c23ce9b3-cbb0-47cc-f94c-08de9ebd23b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: zoLi6ZyQKquHT1inS51QgZRJUB7DLh29C1neOKGZz0U9V+IjNKIPxktuGmphkojWIabY4UD1zSxD447iMr6DLLNI94u+UmahMwbBh4edEJ2YAOwGPiP0Q+iBjOXVqT7TkBYELpK9lR/oKyG2Ha44ChKrYrnYxQXyV0r97ZYFORydQjRTBmcsEQAbI3Eh3CPj4e1IEsDxmBT9nXE7iwpoSSxoK/fvE17fei0ySY2SvPOM5nIzMP1mZvfJ3QP+vNC+NzMu4LYYITe/bUFCWnG5zKtFLbn04w1cYcn3XiNT11KJrTaDvfj4L1b6AmSCYd4akf7efUOwRn9qSLPuV3LMEm/r6/nR7sKDypecAYo0SVN7c0f6+kx9Uhlqs1EdSt4TAm9C7GasfX5eORgoizkwh8ZhzVM9oAZnC6rpAgel83lkOGvei7vcgmfcXxtujbRXujDHWYW+1i8Guu7uDcrHsG9pgf7CD9lScDO/6+AJ4Q7Ieo0J6C9mzIbIeZF9nmhzBSRxg6tUYJLrk0qxd1m3VFS+5eZ5wiC2m0SZCLDuUYH8MnIxk4UDo1UXeCzRe74BZUBL5TAovCj9XFB4HoGVHsu/j19Zc7xj2YR9EhYqtglhTEja2pPjlESMKrWZNlkB+/9b5GuzNEZ0KU6CxLsnQ6TbbJHWlzV/56NL/togNDmxdodNx6c6zWo5Sx7mdO6xdc7junMynPK+VPCzsXPjbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWxRT2wzMVVaenZxQ0lzeEZIdFZzS01IL05jOFFHZGNRMDJkQm1FMGJ2aUtv?=
 =?utf-8?B?aUJHRnlyejB5MmprQnBKbmpxNjZFbUhrZmVmRythcGRvanpEcFU3aVd2clB4?=
 =?utf-8?B?MmltS1ZMaWVod01Zck9iS2hUV1FFbjl4Qk4xRDBwY2dtQ29BSHBjUUo5eEVi?=
 =?utf-8?B?a1lzalR6aHNmNnVGNWYxQVpiV3dEVUpJVDRqdmlnSnlGaEhaTWN6V0ZnUDVB?=
 =?utf-8?B?cXlFYi8xa1NKQVVMZFF4M2ZvTkdBVjJ4SlpCYWR2bDNWZHNEQS9IVEE1M0Nu?=
 =?utf-8?B?Ty9rWDJHdEIzbmdBVnQ1cmJFU2NuVjJWS25LNmJxK0lpandRbyt5ZTh5empi?=
 =?utf-8?B?VmUvT2Q1ekhpMXkycjFRaEptM2RoRmdCRFR0WmpWbWo2azhtV3FNcDNkRmRu?=
 =?utf-8?B?cVNLMUNvOEhmaFIvQ0lqbWZGdnM2WkFURUNJRnY1ZHJNRXNCZG5MTWpVM1VD?=
 =?utf-8?B?TE1mYXJXR3RKK2pYYTJ0UDJhd3A3ZDBTWlBHMUEzZTU3QW1qa2ROUFBnSzZs?=
 =?utf-8?B?MjluM3Z4NWtndHRoUlg0TkFzSXY0WXhUSkt2anl6d2RjenZ3SStSK2tPRzB4?=
 =?utf-8?B?em9OWlpJeDVramdQejJudWRvSVNuRHNoakNwc3BwNjA5OWs0ekw1a3F3K3Bu?=
 =?utf-8?B?M0dPdHRoUVlVQ28ySlk2bGlDNUxxY2lCTzdQNmphSlhDbmZuS0Y2U3BYK3k5?=
 =?utf-8?B?T3RrNFduNnBJMTBZNlArYm4wWE1zZ3huYjhyWUM0eWU4elJGQzhaNm9WbWlz?=
 =?utf-8?B?azI4eDA2SjV2VlhWb3JVaCtiV1B6SWF5N0trZ3hwU0FMRFRlUU9nZTRmbzBx?=
 =?utf-8?B?eXJaYUV3Nk1EN2srRTVDbEpsWXJJbWhoQnVxTGUzMFRHMFh5VTlZbTVmbmg3?=
 =?utf-8?B?NGhwUllzV3hhYVVjVlorYWNkeU0xcXhsYVVKTXkveVJWZDNnUDFraGJoUDdy?=
 =?utf-8?B?eGQ1byt6Y2xUS1JsTGlGM0ZZUTNmNkpiU2hiVm9KNm1yOGdJSzRaQTNCRitJ?=
 =?utf-8?B?RVhYSXJYQzBHeG56NnowYXlEQ3pVbGsxUWo5ZEZPZVZ6RjhheW5OQXNmaWc3?=
 =?utf-8?B?aU1aT0VDOHNUM1lwczNQYXVaL2NWaG91OVdrWEI1QlN3YUFGWmJhTWRrTVZ5?=
 =?utf-8?B?Y0FmQktzQ0YyL1VUVkxMZkp1emhMRE9QaEgvbW1sNlNVdVo5NEw2d0kwQzUw?=
 =?utf-8?B?c1htRzFNRnFIOXBsdEErVzlJMU5ScHBHSE9SRDFvZ0dxZTkzaXJvU3l3Tysr?=
 =?utf-8?B?Q0wxVVdxT1lqYVNySzhaN3RQaUJKc0J2cC9uTktvSCtrMXd2UVE0TVc2b25R?=
 =?utf-8?B?MTlBUVR5emU2bVk5cGxaQkZmMHJPeFAzSk52WFI4VXd0ay85bFZMeGNKTzMx?=
 =?utf-8?B?MUVCcmJNTEdUNHBROW5oR1hSeGhiVVROWVJjTjBpZFh2NHliYXZFZ2poWUdO?=
 =?utf-8?B?ZWprSG1BQmZ0bkUrcGdLL1BXQWxQVDc5V1lpMHIrc3NKQW00OVhxalQzcjI3?=
 =?utf-8?B?aVFQUDE4dVg5aXlSNFR5Rm92bXJpVTgzMHFmVHZ0MzlXaXVHZnpxUjZqMWxB?=
 =?utf-8?B?VGZzSTByUElOelZDZmVaUDMrTUJOMkZWMlkyZ05YT0RFdjlRY3FpVVdtZkFY?=
 =?utf-8?B?NGNlUzVOK0xXNmRxZlZaL3JMYmxnZjZEZlo4YzVXRmlEYmhiSWgzMVltVUVP?=
 =?utf-8?B?SVBMMWcwYnB3V1VBVVZNd0huMVhsR0NBd3F1ZnQzNHE0allLRFcwcUY5UEF5?=
 =?utf-8?B?KzZPTjlCbE9ML2xOUEViVnFDWkxqYnV2c212NUI1ZzNrZk1lMGNZVzVBL1Vh?=
 =?utf-8?B?WkJDRmNJR3ZzdEZYWmJZZzBsVWVDczlSNStxandNNGp5RkZoNUo2THRKM2xC?=
 =?utf-8?B?Q3VBUExuNzdLaThZN1pNQkZXRDBvSm9YWENoL2dnbDZpRXlXWWVwb21IWUor?=
 =?utf-8?B?RkpFUjczMW9tUmVNK0Rjb0ZqN0pGb3BmT2N4K0dJaGVzMncxbWEzeU96UkFt?=
 =?utf-8?B?bnVWakJPRHFLbTEvZUJMRnNVa0N5S21va3BGOTA3b3Y0OEE3ZzlEUGxleWtL?=
 =?utf-8?B?QkYyWWpKaG1zSnZ5YzV5citRQTVLQUJOaUpqUU4xQStPY0ZKaW1nV0oweXFw?=
 =?utf-8?B?M0NzdkRTZVFGNVErcUZjaXRXVVV3UG5nWk5lMzErVjR3K0xsNUswS3p0dnJV?=
 =?utf-8?B?UGZZM0ZCaFZqTGtta1A5OHg4UEJYbU1vNlhnbGpFUlRITVB5UDNrMmptV0Fk?=
 =?utf-8?B?c01EcXFrOEJrRE94SGdBKzNnQ0tqSGNvc0RTb1AvQ3BpOThuTy9zcjB2TzV0?=
 =?utf-8?Q?PnM3PmBSGJgK80p9++?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c23ce9b3-cbb0-47cc-f94c-08de9ebd23b9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 09:13:52.1311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FxvOtutWrIM5kSSAeCNhqJDPQXXrWhSSH6e2L79yTSA8P5i6mATAo98tU6ReINBx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7604
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

On 4/17/26 23:32, mjgajda@gmail.com wrote:
> From: "M. Gajda" <mjgajda@gmail.com>
> 
> GC_THROTTLE_STATUS is a read-only hardware status register present on all
> RDNA GPU generations (GFX10/11/12).  It reports the state of the GFX
> thermal throttle finite state machine:
> 
>   FSM_STATE    [3:0]  non-zero = GPU currently being throttled
>   PATTERN_INDEX [9:4]  active throttle duty-cycle pattern

Mhm, according to AMDs internal register documentation that one is not available everywhere.

My educated guess is that there is actually some SMU function you should call to get this information.


> The register is never written by the driver.  No side-effects occur on
> read.

Oh that is not correct at all. Reads can have tons of side effects all the way to a spontaneous system reboot!

> Add it to the per-ASIC allowed_read_registers[] tables so that
> unprivileged userspace can query it via the AMDGPU_INFO_READ_MMR_REG ioctl
> (libdrm: amdgpu_read_mm_registers(3)).
> 
> This enables monitoring tools such as radeontop to display GPU thermal
> throttle status without root privileges -- information of the same
> sensitivity class as GPU temperature, which is already exposed via the
> AMDGPU_INFO_SENSOR_GPU_TEMP sensor ioctl.

Yeah, but that one asks the DPM functions to talk to the SMU to get the requested data.

That is clearly something completely different.

Regards,
Christian.

> 
> Register offsets per generation:
>   GFX10 (RDNA 1/2): mmGC_THROTTLE_STATUS  0x2032  BASE_IDX 0
>   GFX11 (RDNA 3):  regGC_THROTTLE_STATUS  0x1b0a  BASE_IDX 1
>   GFX12 (RDNA 4):  regGC_THROTTLE_STATUS  0x1b1c  BASE_IDX 1
> 
> Source: drivers/gpu/drm/amd/include/asic_reg/gc/
>   gc_10_3_0_{offset,sh_mask}.h, gc_11_0_0_{offset,sh_mask}.h,
>   gc_12_0_0_{offset,sh_mask}.h
> 
> Public ISA documentation:
>   RDNA 1: https://developer.amd.com/wp-content/resources/RDNA_Shader_ISA.pdf
>   RDNA 2: https://www.amd.com/content/dam/amd/en/documents/radeon-tech-docs/instruction-set-architectures/rdna2-shader-instruction-set-architecture.pdf
>   RDNA 3: https://docs.amd.com/v/u/en-US/rdna3-shader-instruction-set-architecture
>   RDNA 4: https://docs.amd.com/v/u/en-US/rdna4-instruction-set-architecture
> 
> Signed-off-by: M. Gajda <mjgajda@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/nv.c    | 6 ++++++
>  drivers/gpu/drm/amd/amdgpu/soc21.c | 6 ++++++
>  drivers/gpu/drm/amd/amdgpu/soc24.c | 6 ++++++
>  3 files changed, 18 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 7ce1a1b95..80594c793 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -352,6 +352,12 @@ static struct soc15_allowed_register_entry nv_allowed_read_registers[] = {
>         { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_STALLED_STAT1)},
>         { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_STATUS)},
>         { SOC15_REG_ENTRY(GC, 0, mmGB_ADDR_CONFIG)},
> +       /*
> +        * GC_THROTTLE_STATUS (offset 0x2032): read-only thermal throttle FSM.
> +        * FSM_STATE [3:0] != 0 indicates the GPU is currently being throttled.
> +        * Defined in gc_10_3_0_offset.h / gc_10_3_0_sh_mask.h
> +        */
> +       { SOC15_REG_ENTRY(GC, 0, mmGC_THROTTLE_STATUS)},
>  };
> 
>  static uint32_t nv_read_indexed_register(struct amdgpu_device *adev, u32 se_num,
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index fbd1d97f3..8c2472bd0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -304,6 +304,12 @@ static struct soc15_allowed_register_entry soc21_allowed_read_registers[] = {
>         { SOC15_REG_ENTRY(GC, 0, regCP_CPC_STALLED_STAT1)},
>         { SOC15_REG_ENTRY(GC, 0, regCP_CPC_STATUS)},
>         { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
> +       /*
> +        * GC_THROTTLE_STATUS (offset 0x1b0a): read-only thermal throttle FSM.
> +        * FSM_STATE [3:0] != 0 indicates the GPU is currently being throttled.
> +        * Defined in gc_11_0_0_offset.h / gc_11_0_0_sh_mask.h
> +        */
> +       { SOC15_REG_ENTRY(GC, 0, regGC_THROTTLE_STATUS)},
>  };
> 
>  static uint32_t soc21_read_indexed_register(struct amdgpu_device *adev, u32 se_num,
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
> index d1adf19a5..617ee0a4d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
> @@ -130,6 +130,12 @@ static struct soc15_allowed_register_entry soc24_allowed_read_registers[] = {
>         { SOC15_REG_ENTRY(GC, 0, regCP_CPC_STALLED_STAT1)},
>         { SOC15_REG_ENTRY(GC, 0, regCP_CPC_STATUS)},
>         { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
> +       /*
> +        * GC_THROTTLE_STATUS (offset 0x1b1c): read-only thermal throttle FSM.
> +        * FSM_STATE [3:0] != 0 indicates the GPU is currently being throttled.
> +        * Defined in gc_12_0_0_offset.h / gc_12_0_0_sh_mask.h
> +        */
> +       { SOC15_REG_ENTRY(GC, 0, regGC_THROTTLE_STATUS)},
>  };
> 
>  static uint32_t soc24_read_indexed_register(struct amdgpu_device *adev,
> --
> 2.51.0
> 

