Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C14A1CD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 09:23:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2326410E68B;
	Mon, 18 May 2026 09:23:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AUL+Ch09";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012066.outbound.protection.outlook.com [40.107.209.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3AE310E68B;
 Mon, 18 May 2026 09:23:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQjl/Q8X/ERh8qYF7ztatbJ7LyQYEQ7gB62K5pRau4BKJfQDVDII9NuwR8Um87XzFpfCheP0gjNFuzcf4VQUzV0yU7YJ+tXhUt4cs2I7hYmuqqojgG5egwh0lDL4gIYpUVxPjXxb5OSeJhPaT/EkV1JHbr+Om5D6D71W/hV54Snaq8uwdHHLMBwg25WlgTrAyo/fyCNL/R7YVVy7GhB0SsXyIR3KV1tn72/5WzNYionfD7dzZHo2n84hbU8OVApP00re6D3uUDv8f1DHoWixVs+GWJtW4E3VGfsxWJwmmGvtQZWLG91YH4uvtPTTN1zy5U6szJaJpVIrJZozKKbkBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LvGWWumqbQIKtNXJYshrWWpD+ON43itv5k/0wgwrxck=;
 b=JY7blQpkFeTUa6+deWDlqwri0UlGtAYyDKSGph693mYuW0Uq0jjmYDSIbQL/U/OpWpag2R+xJu5EyZORdiNKro2XMgtv1WNktrzCk5kOfRJy62S6yNfSnlAQ5sGmZ4dYqlThmcwhKbZ6NM7+mC8NSnrbTAMb9zZRri1O8qm4+hYCtlbY8JCAiyIcNPLcSeIWDJC6DdE34cshOMKj8A2PH6V4bgRivxb1gskQfG/ATmo9YhCb378TR+ftopuBGKKLcqR1zz99syawPD7oK5gqW4hsliDkQLgUFwZxA+n1oUxntyB4xMHpJ/cnZaQKI/GRRAcXA1PbKT2M51LG8+wOmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvGWWumqbQIKtNXJYshrWWpD+ON43itv5k/0wgwrxck=;
 b=AUL+Ch09iXN5IJYjeOQkQRvmiwiGum7DC7Toun9xEd30rlYHosFu6kG84t+p5yFkGjD0ZpKEzuu+Cy1f3hEz75+S2Y6s6BO19vKbmh/4ZOivDokCUybueJVEa/SH07FQBN8VMvGjy+TMWT5ruTn7xkXnfZmI6TpzJjABOdL7FUc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8353.namprd12.prod.outlook.com (2603:10b6:610:12c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Mon, 18 May
 2026 09:23:47 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 09:23:47 +0000
Message-ID: <ed2f24ae-fd36-4b0d-954d-8a863f82fe7f@amd.com>
Date: Mon, 18 May 2026 11:23:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: clamp user gartsize against device capacity
To: Ahmed Elmetwally <en22ue@gmail.com>, alexander.deucher@amd.com
Cc: airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260514194937.35649-1-en22ue@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260514194937.35649-1-en22ue@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0283.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8353:EE_
X-MS-Office365-Filtering-Correlation-Id: 2910a486-8bf8-4eb1-3764-08deb4bf2a27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|11063799003|22082099003|56012099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info: dEMFciESK8o6n/94O1TIvZslgs+wVPjVJ0KkUaLPNcR1pSqDybBka4FJiy4Cep6dZ0E6SHbSYwnmDUNUaSm2flRAaJmuzm7feFbNwi7bp3lTQ0/0/zK5bUWLWOCi/rRXVj82sM97gtVYR1DqltyYBtOjpFZqwUvt2iNYbcqR0smFCTHtf+1AcPsnRLdWiy9+DyLm9NqqwjkI1b2KNNIkAS1Gjr06QW72Cr4yQM7o1MTn62x6/ZTCM54YQ0K9tLxPOsYh4zp7cAJ5mr3WDn0TZHqgDp5IILGpY5ktShY5KYbStC85P4jQSnDBdQUmHvbdfnYMmUsMMvdpxn8hvEW2qiMMeMzjpuY1cCJ+UDHs6qfR605Pj1Rjix1FojXoAFc1+HBJiOBnp8Nd7iehr/Qw4NF3Iqarz2xSMnmcuFhvUb0u155fuhc4jqF+9XybCAzAnmyu/GQbe712rS1g1Qnm3tQwpfnCrIG50ditAwbuHB3OWYV106pbbeHJCHlyym40nP6FpwhNxILi66skBkpY8XzAB/3xGSM9VkrlhDlANgWZ8RJw5OGHfLJFeBQ4pZzjomFpdGgO5qO3/HlzBj2il3S1HI+aJ4CJTxsjzfO39Bb4hMcH6fbUGfGh8hc0F2dVoMXLbzhs5im5z/aAdpVWNlYTUJsLkrZjPyoES5P1PZxYI0/7O1iwCvbRW2s9xNAG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(11063799003)(22082099003)(56012099003)(18002099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1NPeFFGaFVyb3F6dVUvOXNHVWd6Y2lpdGY2N3VOWFhrVWdwcjg2NGYxM0Nu?=
 =?utf-8?B?V0dsWVFuZktSM3NwTCtyYXJvYTZ2b2ljSlB0OS93MXMzN1A3MDlVWk52cWs2?=
 =?utf-8?B?SGZNMmQ3TVdIV09vN003TjJPUGsvOVpsbVRTUUJjZDk3LzJMTkJsNDRCRjRh?=
 =?utf-8?B?eHNLSTZEdGtyb0Yrbi9oQmpxMTU5ZHd4NlpieENLN2xWT215ZXgxNWdROXA3?=
 =?utf-8?B?SGkybEsybXd0alhlbFZKOXorRG5sYWE1blIyd1B4MVJIemdpSXN0VUJBS25l?=
 =?utf-8?B?cXZ6QTZYRDNaOENnT3lPL0Q0aCtCRlArNmNhemR2RGZJdEliN2ZONDJDeEk4?=
 =?utf-8?B?QnF3bjMzaXFYN3ppTnNtWnVnTVJQbmRPTURCaXNTUXFMbGFMQk1GSHprUW94?=
 =?utf-8?B?QzR2N2h4SUQ3eWFCdmFaWEwwMlA1dTVrb2h2cnE5KzBnYU1SQm5zM3ZCZ2d2?=
 =?utf-8?B?WVNDZGF5ZnJodlhpYm9ucWl5aUJrTFhFdkhWSFl6ODVnTUt1TGczdTRsTUs3?=
 =?utf-8?B?OTllWElQeDRtQ25uSkZvR0QvT1B5RlpXUDRBUkpVaXZBdXZ1TkUyK2RRYy83?=
 =?utf-8?B?VGc3SVpoWVpUY1RRd1Jxb1hmUzdDYmR3ZzdDbVdEb2UxREZpamtiK0QxOE1h?=
 =?utf-8?B?NWtQaUNuWWxrcGxpWUVkbUUxcFZoNGlkSUg0Tm8yMGtRK3JQd3h2NFprV0s1?=
 =?utf-8?B?bHVxM0VpSDc2MVRES3hVeVhrcHphamxYTzI3QkJybWVDLzVGZjdPYjBKdklU?=
 =?utf-8?B?cHBHei9QU2Q4U0hOejRDRC8zK3ZBNEpUSjlZOWpTYVBuQjkvRFpWc2JIOC9U?=
 =?utf-8?B?Yk15Y0RVaUJtaWF5MVlmakpRV20zc0FkWFBVZWhhNC9WOWJqZ1NuVzlPYjU2?=
 =?utf-8?B?RGVzbVNza005NkgxbVZVRkRxY3djRjVCeHUwUi8rSGRZZzVoMnQ3djJJNm9s?=
 =?utf-8?B?R0tTUjBJUU1JK2xuMnJ4VEwyMk5pOS9EQUQwd1JOR3h0ODN4NURqK01yc3Rv?=
 =?utf-8?B?SFJLaU5ZaFo3NForQlRvc2VadnJKOEw3NUVia1dVQ3Y3T0l4SEZybU9Qck16?=
 =?utf-8?B?ZXBpdHNFNzUvRTByVjd3MnRqS3FQbnBvRGNlc0FtRFpyMWF5SlAxR21oV1p2?=
 =?utf-8?B?TVN1NW5MSnZkT2F1cHhtVVpLWW95eEZpTW9PZHBwTkN6bjN1R1Rka2QyTlVM?=
 =?utf-8?B?SzFKTGZYcklpcXpGN0dFZUoyemVpcWJmdFJWTVZPYVF4VFRsYkN4cWhuWUg4?=
 =?utf-8?B?c2pjSlI0NEhDYjlVTjczaEpoYmZ0YUdGbE5mcTFCMTA3cUlFTEhFRTl3dnpM?=
 =?utf-8?B?MVpndDROanZGb25lOTBUNWNpZkZuMEJCT1MxclVxbElNTStiY3B0bDJBUk9Q?=
 =?utf-8?B?dTY5bG5PTDJmbVdQTEpFOWdLeTN5ZWdvc0Vvdzg0YjA3WWpRQTU5TWNxazRK?=
 =?utf-8?B?eVFvRDIxL3lmaWJrSTRIWFJpK1lHOStQMjJ0a0twRlV6Z1FrcTNzV0ttTHpk?=
 =?utf-8?B?a2NkODJNVjZtVkdETjdwaE85YkdJYjZaYnh5RkZXSXRoczJGY0d3MjljREpN?=
 =?utf-8?B?WCtIZWhnbS81MjJUTjZSa0Y0YkpwMUtYVEVVQ0ZvUFEzYmRlTVZqaWJvamhC?=
 =?utf-8?B?T2ZubHNPY241UW13dHBvYWh0blN3TmkyOVdGUlhYSDY1eXFIdFZHNUQxT2pO?=
 =?utf-8?B?SG9DZ3BYWWozYm90akNjUlpYTmQrMHRzZVVZZ0hyTDd1VkpEam1kVGNnZ0JN?=
 =?utf-8?B?bG8vL01kdUgySjJWYXhNanpvSFUvY1VVQlhTUnpINlgyazRNYWt0Y3V6UXNU?=
 =?utf-8?B?dlNqMzdXN09KWXRRcEUrcTg4OXBodWRSdmovaE5DV3h6bEl6OWpkbUJtSHBN?=
 =?utf-8?B?ekY1WWFXYWd6YVR4Nk9aUG0zazBFRnBmVHE2M1J4Z2txaTFERk54TG56NkxM?=
 =?utf-8?B?ajNMZGM2bG1UR2V3Sm93TGdyWFhZbXlqU1B4MS9zTTlXOVNVdXF2d0xPVzJm?=
 =?utf-8?B?aGhtc29MenRxd2Ftci9CK2ZROFNBMUgvdDRDQlJ6S1N6QmlPdVVpRzl2R0pJ?=
 =?utf-8?B?bHVxVEZVSnBCTVk1VmJmZ1NYSG4xakxRbUltd1V3ZmVtNnlCcXRwcU5YdUoz?=
 =?utf-8?B?OEtheUJQS3B1UGRXVGt1N2hSWHVacDh5RjNsT0FyRWV5RzRJQ0haam4rZEo2?=
 =?utf-8?B?Kzg2bVpWTUtaTUk5djUwMEx4ajRHbkdSMzgvdGdIK3FkaHJNbEJMMERJNEcx?=
 =?utf-8?B?elRNTGtVUXpWSlN3R24rcE1xK0w3aldjVXVQM3p2L20zcWVvTlZ4MUF4Nm1X?=
 =?utf-8?Q?ihx7ASoiq9IMCnKwhT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2910a486-8bf8-4eb1-3764-08deb4bf2a27
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 09:23:47.4123 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rCs8SSW3BOMEzEBApzhCm4CRWRxdqGJ/r6rKdtdJOopYEMWatovvaOqyQuFw1iX9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8353
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

On 5/14/26 21:49, Ahmed Elmetwally wrote:
> When the user-supplied amdgpu.gartsize= module parameter requests a GART
> aperture so large that the resulting page-table BO cannot be allocated
> from VRAM, gmc_v11_0_sw_init() aborts with -ENOMEM during the kernel BO
> pin in amdgpu_gart_table_vram_alloc(), which fails amdgpu probe entirely
> and leaves the device without a /dev/dri node.

Yeah that's the expected behavior.

> 
> The GART page table is 8 bytes per AMDGPU_GPU_PAGE_SIZE-sized page,
> i.e. table_size = gart_size / 512. The table BO is allocated from real
> VRAM. On small-VRAM SoCs (APUs with stolen VRAM -- Strix Halo at ~1 GiB
> is the case at hand) a user-supplied gartsize that produces a table BO
> larger than what can be pinned in VRAM is silently accepted today and
> only fails far downstream.
> 
> Reproducer on Strix Halo (gfx1151, 1 GiB stolen VRAM):
> 
>   /etc/modprobe.d/amdgpu-tuning.conf:
>     options amdgpu gartsize=262144     # 256 GiB -> 512 MiB page table
> 
>   dmesg:
>     amdgpu: [gmc_v11_0]*ERROR* GART aperture is needed by the driver but
>             no memory has been pinned for it ...
>     amdgpu 0000:c6:00.0: amdgpu: SW IP initialize failed
>     amdgpu 0000:c6:00.0: amdgpu: sw_init of IP block <gmc_v11_0> failed -12
> 
> Recovery requires booting with amdgpu.gartsize=N on the kernel command
> line -- i.e. the user must already know the cause, from rescue media,
> with the GPU offline.
> 
> The user-supplied gartsize is a tuning hint,

Nope it is a parameter we use for testing. End users have absolutely no business changing that.

> not a correctness
> requirement. Compute the maximum sensible value such that the page-table
> BO fits within real_vram_size / 8 (leaves 7/8 of VRAM for everything
> else), and if the user value exceeds it, log a warning and fall back to
> the per-IP auto default. With this patch the same modprobe.d entry
> above produces:
> 
>   amdgpu 0000:c6:00.0: amdgpu: amdgpu.gartsize=262144 MiB exceeds device
>     capacity (real_vram=1024 MiB, max sensible=65536 MiB); clamping to
>     default 512 MiB
> 
> and the device probes normally.
> 
> The helper lives in amdgpu_gmc.c so the other gmc_v*_0 backends can
> adopt it in follow-up patches; this patch only wires gmc_v11_0 because
> that is where the failure was observed.

Well if you shoot into your own foot it is supposed to hurt.

When the end user gives incorrect or nonsense module parameters the driver should clearly not override them, but gracefully fail to load.

Otherwise we loose part of the testing functionality those module parameters provide.

So clear NAK to that patch here.

Regards,
Christian.

> 
> Signed-off-by: Ahmed Elmetwally <en22ue@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 47 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  2 +
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  |  6 +---
>  3 files changed, 50 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -330,6 +330,53 @@ void amdgpu_gmc_gart_location(struct amdgpu_device *adev,
>         dev_info(adev->dev, "GART: %lluM 0x%016llX - 0x%016llX\n",
>                         mc->gart_size >> 20, mc->gart_start, mc->gart_end);
>  }
> +
> +/**
> + * amdgpu_gmc_validate_gart_size - clamp amdgpu.gartsize against VRAM capacity
> + *
> + * @adev:        amdgpu device (real_vram_size must already be populated)
> + * @user_mb:     value of the amdgpu_gart_size module parameter (MiB),
> + *               or -1 for auto
> + * @default_mb:  per-IP auto default in MiB
> + *
> + * The GART page table is allocated from VRAM and sized as
> + * gart_size / AMDGPU_GPU_PAGE_SIZE * sizeof(u64). A typoed or mis-pasted
> + * amdgpu.gartsize value (e.g. 262144 MiB on a 1 GiB-VRAM APU) produces a
> + * page-table BO that cannot be pinned, aborting GPU probe. Cap the page
> + * table at 1/8 of real VRAM, warn, and fall back to the auto default.
> + * Returns gart_size in bytes.
> + */
> +u64 amdgpu_gmc_validate_gart_size(struct amdgpu_device *adev,
> +                                 int user_mb, u32 default_mb)
> +{
> +       u64 want_bytes, max_bytes;
> +
> +       if (user_mb == -1)
> +               return (u64)default_mb << 20;
> +
> +       want_bytes = (u64)user_mb << 20;
> +
> +       /*
> +        * page-table BO bytes = gart_bytes / AMDGPU_GPU_PAGE_SIZE * 8
> +        * Constraint: page-table BO <= real_vram_size / 8
> +        *   gart_bytes <= (real_vram_size / 8) * (AMDGPU_GPU_PAGE_SIZE / 8)
> +        */
> +       max_bytes = (adev->gmc.real_vram_size / 8) *
> +                   (AMDGPU_GPU_PAGE_SIZE / 8);
> +
> +       if (want_bytes > max_bytes) {
> +               dev_warn(adev->dev,
> +                        "amdgpu.gartsize=%u MiB exceeds device capacity "
> +                        "(real_vram=%llu MiB, max sensible=%llu MiB); "
> +                        "clamping to default %u MiB\n",
> +                        user_mb,
> +                        adev->gmc.real_vram_size >> 20,
> +                        max_bytes >> 20,
> +                        default_mb);
> +               return (u64)default_mb << 20;
> +       }
> +
> +       return want_bytes;
> +}
> 
>  /**
>   * amdgpu_gmc_agp_location - try to find AGP location
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -416,6 +416,8 @@ void amdgpu_gmc_vram_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
>  void amdgpu_gmc_gart_location(struct amdgpu_device *adev,
>                               struct amdgpu_gmc *mc,
>                               enum amdgpu_gart_placement gart_placement);
> +u64 amdgpu_gmc_validate_gart_size(struct amdgpu_device *adev,
> +                                 int user_mb, u32 default_mb);
>  void amdgpu_gmc_agp_location(struct amdgpu_device *adev,
>                              struct amdgpu_gmc *mc);
>  void amdgpu_gmc_set_agp_default(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -708,11 +708,7 @@ static int gmc_v11_0_mc_init(struct amdgpu_device *adev)
>         if (adev->gmc.visible_vram_size > adev->gmc.real_vram_size)
>                 adev->gmc.visible_vram_size = adev->gmc.real_vram_size;
> 
> -       /* set the gart size */
> -       if (amdgpu_gart_size == -1)
> -               adev->gmc.gart_size = 512ULL << 20;
> -       else
> -               adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
> +       adev->gmc.gart_size = amdgpu_gmc_validate_gart_size(adev,
> +                               amdgpu_gart_size, 512);
> 
>         gmc_v11_0_vram_gtt_location(adev, &adev->gmc);
> 
> --
> 2.45.0

