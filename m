Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353E3C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 14:56:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9850110F617;
	Thu, 24 Sep 2026 14:56:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1z86t+I+";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011046.outbound.protection.outlook.com [52.101.62.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FAE610F615;
 Thu, 24 Sep 2026 14:56:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxkyFvJhrUGsBlaD7f9JJIUk/CmC+HNqlnUu37AEbjjCH3T2PjhwKabCvlCG9dFXmLOJtnA4Q18FHflK5L3H6710OCDlpwhDumy1gRiGh8OlDppCx20U4CD0bK6MYqeOMQ8MuZZ3eg7Bhyo0W7KMW1yQzwkInmiUnuH2OkcijqVbedVbJn/Pq/QEAiPBPQ+Jz13gzf1tHouq4I1BUQRFmecGRZOGrvmPKdtcXx99P3IVAGct0qX96zFe46NzQ8RxST0cLoNYe5kDubPh9yedwh5kUofdbhjI8h9jjrBpVgnaoK2+SRwoyZ4BMDB0NnLzv6+Sm6UxjekTObRU7GET8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvmUOLf5A3LULM9AWDZwAL5nOKJgC3euoyGl30GUGoo=;
 b=e3otRpKQA2leVkt7h/xPs2Gv3nbRqWTKkht2bGjys8gHX7KuiBPfAn1sWcXdLGqXqAxYKuVkPPxDYbrVjCvZONBJRydYM6JjjGoZ6/soHtFs1QPGh+S8kCay1+urHb4h7ui7BWUZopYjtP9JQUFCZ9NnWqf7gP2UzT8XRkPIWGTivUkAjyC6Z4PF2MmPDnBZynZeKKikIJJqCJF6QPb+a31TVX74/O7R/p46hVYfofxF+DQ82j/gEXuPTq4Eu53sU7jgER5QvmXGWGG91czTFWTDxIa+fqwhbubIBvtoT9hry7x/MwYlakcQJYWT9cyJMgjNdaeCTb7uLLDwoKry4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvmUOLf5A3LULM9AWDZwAL5nOKJgC3euoyGl30GUGoo=;
 b=1z86t+I+DFWMNX5FU22Pz8K+qjpC7akt7Baq1CJ24Tm5c6yESozdsQIBU6LpuzD1wmIPTSbF1i/z+kjz2AxDVp7lpk8k/JJL5JVA9S588qftq+/CgGBBB52c0hNa8/u2+sKJ7y5dz/aBYspqtq1QbI/2/x25hZCRHRnHjqB1zzk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA0PR12MB4397.namprd12.prod.outlook.com (2603:10b6:806:93::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 14:55:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 14:55:55 +0000
Message-ID: <9c2ce6d3-46ea-4a69-a227-a5431c3447a6@amd.com>
Date: Thu, 24 Sep 2026 16:55:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/gmc_v8_0: restore the FB location after a
 re-POST
To: =?UTF-8?Q?Francisco_Beltr=C3=A1n_Millal=C3=A9n?=
 <fbeltranmillalen@gmail.com>, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260924132952.25054-1-fbeltranmillalen@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260924132952.25054-1-fbeltranmillalen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0221.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA0PR12MB4397:EE_
X-MS-Office365-Filtering-Correlation-Id: a8290052-41df-4d01-cd73-08df1a4bef95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|11063799006|56012099006|5023799004|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: s1q6mjcu9E+oOt0YU7FgfpTOUk8w8nPhjM7fj45bRbYzRcoPJ73aiVM68U7vYMT8jg3x8M/wkR67DVQl1Yp3vjuyznEVLyLOkJTpPNqJ8ezdNuZJ9RgayeWxQ3GlkbhPRsOw8rJwkwCUEu+CbQvnnJh9sdB1e6E0/C3eatbhKSPmqg9PmVvUwq18/GOXT8bX2fPSbVqlEsvQeTErygC3EzVu7r1cZ9G+biD/+r/cyj6jHgKYxXfcevQWxF0Jc+VJB+5FlX7P5Dmqsvo9ofPBbJQ1IW5pPyHAj9kMK1mCzloCesSZjfnDJXQZZzvmyVGIwLk3oKVQaibaQiR+dKgHXc/ekHll5ofyrvU17R8uJ2iu+v23X0X4r+NkOnn8tm8NOatawNoGGxeavYQTc6FOOmeXdUuW3ll+DijHs9N/vttILaryHjIm1pcSD4qhPOvsUOaE1XJ3RD54x0LXilRmBkWpd7zir+aPK27N+ouoIN1FfGjSs5WgrUDF4lRrehe9cCpjUCfCka00ahKdDXp9IRNPlZf4zjEYzBcfZdq4PH+MFs/lVNn+OTd4Cf6IpnMX9YLVy/k3UfxhyEDGAIUPug5lsSNZqyy2oONTawpFsec+eof3kxPlmpi+FG2W1DgoBFPoTsDJnLXI7fHIDjdoR41pHGUn487AxSCZVhNQJLk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(11063799006)(56012099006)(5023799004)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cCtLVnFGVFBST0I2SHFGOHFVOHhHOWsrMmVTSTVxUnIvSE9zTjMxMVRPMnFo?=
 =?utf-8?B?NmdFZDJFVXFHdmlUdTUxWmpaVmp4aGRBVUwwSWszMXU1QUdGOHNiM2xSTHJl?=
 =?utf-8?B?MkhjODFlR1FOREIzeTloVWV5ZCtTUFg1cXhQaVZvbHFyUE9tc2M0MWh4UEp3?=
 =?utf-8?B?OXdPcURiOXpGRnk4b2o0UUp2LzlUMDZHUXFyZzBTRmtNcTVONnV3TmxqYmNr?=
 =?utf-8?B?UHBvVS9NbVFlTER0aVlYQkI2Z0MxMFNYRFo4LzVidC9zeWpheU5GdTVjQ0hY?=
 =?utf-8?B?Q1lRbUZ5ZER4WWhBcHhtc2RoWDBxK1czRitOK0hoQWY2UjhVWS9vejk0NUpx?=
 =?utf-8?B?eU4xMFQvNVRRWU40TEFDdmIvUDFiUngydjBoUnpjVnJPQzEvQ09BeUV3akZF?=
 =?utf-8?B?cHpnYzUyTGhXTnlRTkhLVzhvejRXWDRhWlBnYjRjOUFnbG5USUtzNE1JN3NW?=
 =?utf-8?B?Vjh4QXFCK3F1M0RWeVdaR2tOSTNmaUZUdm9tUHMwVnppa3FqUVdWWkxCT3NW?=
 =?utf-8?B?dkMvOXYxRllJbFVIZ0ROYXJGQThuZXhROENXZVVFRDFsUno0OHN4WXNKMUQ0?=
 =?utf-8?B?R0VJSUMzNW9veTlsb2Z3ZWhqclBlVzR5V1l2L21YeGZoeXFxYkxVMDNha01E?=
 =?utf-8?B?N0N1a1VSa3Z2bjRhamM5ODFuLzY2NEZtbEF3emJ3NUpHcFM0M0wvcnZNQXc1?=
 =?utf-8?B?YzFOOUpYTFg5VHV1c2NyN1o3THRnbUdMVU10bGVTMzlLVzZWTUJEaHRmZlBa?=
 =?utf-8?B?eFJ0ZUUxWnU1WENuQXI5Z2ZBYkJPWVVDbnhoVUd5dHcrV1l6M1VsdFRUS1Vs?=
 =?utf-8?B?Qk1pYVBOQldsdnBMQzFUNzRWU3QzMFBWMmxodWF5K3ozSDBGUHRTSVcxOUtX?=
 =?utf-8?B?UkJUSlR6MVB4V1NibzI4TGlHU28vZTY2NGo0Vk5Dd3cvWlhHZnJDbkR5UEho?=
 =?utf-8?B?NXI3SXhYSmtzaWJlZTFJWmFwV3Jld0NBTW5rWmFJRjlFRWxQd2ZKMnBJai8y?=
 =?utf-8?B?NVhPNDdvcm1RV3RyaFRJYVJPdlA4dzNaNEFtK2xXblgwc2pVaWsvV3c1N0pO?=
 =?utf-8?B?K1IxWEt5bW1mWXZzT29xSEVMUXc3Z1ZoZW1rTFo1ZjdkdFRSV01wZU5iYzRq?=
 =?utf-8?B?REpjYXVnZGxSMnVVWW8zUlU0MmNVVkU2RmdvUzMvaC9QVTlDeG54a3R5UmRz?=
 =?utf-8?B?RDNKR3hXSERXeGJkTVNVSXpWcURmSmRQVGt1SFY1Q0R2ZmVnb1h4QVJxRnhv?=
 =?utf-8?B?N055T0JiNzYvYzlYcTlpZUdGKzF1Vm13OEpjSDh2c0pFbnowT3B4TGRqdDd5?=
 =?utf-8?B?Nk4wdmhrUlRXeUVYODZBRlZLTzBrNzIvSmRGQVUwMmYrTXJSYjMxYUFDUjdn?=
 =?utf-8?B?dXdPTHJ2Rm9hZmVWVytZQXpob1YrTVZTYmsxYkw2cEQrT3BrM3Y5OVJCd0pl?=
 =?utf-8?B?bWNEZWtVbFdtTWwxNXg2K0lJNGp6cHNBVGFWdDR1UUwzM0NLYmIzTmt4amVu?=
 =?utf-8?B?d2tMZUdKbWlJVDVxRnY0WGNqeThSUW9kcDlDcEFtN2w1Q2tibWdBWlp5eE0v?=
 =?utf-8?B?bVR5OCtoblRyQmJRYVlDc2xSbTErU1BPUFQwcFUzQnhtNHNBb1VkMGJyS2xv?=
 =?utf-8?B?WXRiZFpmaUlBckl6RGk1T0wwMzcwNGRUbmhKejI4cTVwak5qSjdzK0g4Ylk1?=
 =?utf-8?B?eXVJc0dvanpVamsxNnNBNk56RjcybWdNZmlGOStHbHdMOGdBVXpJSkpIVS9I?=
 =?utf-8?B?RkhiSStoZUx1QjJpL0lpOW5uRnF5QjVucFl5L1NqN1duUWhoWXhvM1hKZURM?=
 =?utf-8?B?NVVwVjVETFNkb2hzL2E0eStxalF4RURTalorTlZJQTBpdzA4b01kWEpQUXhR?=
 =?utf-8?B?dWpkVUdtOWl2VnRUSFRIUTFaUlZFYkc4Z1RsMUpVOXBObEd4bUZBZ0RERmtI?=
 =?utf-8?B?TnNNa042Q3dJOXcraUVnRjlvNmQzaytxYXVsOEowdGgrS2RZSmJrQ0VkU0lr?=
 =?utf-8?B?TlBqQXVCOHd0ajJEMDNRQkZhN0VjN0RuL0t3TG1xZjQ1eW5KUkR4N3Jiblhi?=
 =?utf-8?B?MVdVNnorSlJsV2RlZW5DUDRaZ0tndkpQM28zUjhXWDlKaVVwUGlvbmFvajNt?=
 =?utf-8?B?ZlY1QTRzbGFpbWFIY2NkdjBJY2gzbFRqZXlmM3gzVVBXUmlVUlUyKzB0dFk1?=
 =?utf-8?B?aTBQNi9MWWc2VTNPR1ByYW96LzVVNW5HZm8vbVREQXVtS1lOVTkvYmdPVVN6?=
 =?utf-8?B?b0xVZmdmT3d1Sng5YzRyNnlsMjdLbzlldXlVelVTSDIvcVZtdDVEdmM4TmNj?=
 =?utf-8?Q?u4ifagz2Qnb3sYESek?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8290052-41df-4d01-cd73-08df1a4bef95
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 14:55:55.6636 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTSNkJGezcba/HG+ectZHkxpZtKMEfvhlAEHO649xijWCFuM7jzmMEyTklrcxG2M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4397
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

On 9/24/26 15:29, Francisco Beltrán Millalén wrote:
> On a MacBookPro14,3 (Radeon Pro 560, POLARIS11) amdgpu has never recovered
> from an ASIC reset: five attempts recorded, zero successes.  Since suspend
> to RAM goes through a reset, S3 fails the same way, and as the internal
> panel hangs off the AMD GPU the machine comes back blind.
> 
> The failure looks like VRAM going write-only-dead: writes are silently
> dropped while reads still work, the driver reports success at every step,
> and then it hands the SMU a pointer to a table that was never written:
> 
>   amdgpu_device_asic_init()  -> 0          (reports success)
>   gmc_v8_0_hw_init()         -> 0          (reports success)
>   memcpy_toio()                             (write silently discarded)
>   send_msg(0x251, ...)                      (SMU parses garbage)
>   smu7_check_fw_load_finish() -> -EINVAL -> black screen
> 
> It is not VRAM dying.  It is the framebuffer moving.
> 
> On this machine the Apple firmware places VRAM at MC address 0 on a cold
> boot, and gmc_v8_0_vram_gtt_location() reads MC_VM_FB_LOCATION once, at
> init, to derive vram_start.  A re-POST -- which is what an ASIC reset and
> an S3 resume both trigger -- lets the VBIOS put the framebuffer back at
> its own default instead, 0xf400_0000 here:
> 
>   cold boot:   MC_VM_FB_LOCATION = 0x007f0000
>   after reset: MC_VM_FB_LOCATION = 0xf47ff400

Mhm, interesting I'm really wondering where those values come from.

> 
> gmc_v8_0_mc_program() programs the system aperture from the stale
> vram_start, but only writes MC_VM_FB_LOCATION and HDP_NONSURFACE_BASE
> under SR-IOV; on bare metal it trusts whatever the VBIOS left behind.
> While the MC is still in pass-through everything appears to work, so the
> mismatch goes unnoticed.  Then gmc_v8_0_gart_enable() sets ENABLE_L1_TLB,
> SYSTEM_ACCESS_MODE=3 and ENABLE_ADVANCED_DRIVER_MODEL, the MC starts
> checking the system aperture, and every access lands outside it -- which
> is why reads return data written before the reset, from a different
> physical place than the writes are going to.
> 
> Write the framebuffer location back when it does not match the one the
> driver is working with, which is what the SR-IOV path already does.  The
> comparison keeps this a no-op on machines where the VBIOS restores the
> same location, so nothing changes for them.

That is still a rather bad idea for multiple reasons.

You often run into suspend/resume and random memory corruption issues when stuff like that is done and we never fully implemented blocking VRAM access during a runtime ASIC reset.

I think the more defensive approach is to do an ASIC reset on driver load and use the values the AtomBIOS init function comes up with.

@Alex what's your take here?

Regards,
Christian.

> 
> This runs after the VGA aperture has been locked out and with the display
> suspended, so the MC does not need to be stopped; only CPU access through
> the BAR could land while the FB and HDP bases disagree, so BIF_FB_EN is
> cleared around the update and re-enabled below.
> 
> With this the GPU survives resets and S3: the machine has since completed
> twelve suspend/resume cycles in a single boot without a failure, and the
> restore is visible on each resume:
> 
>   amdgpu 0000:01:00.0: amdgpu: FB location 0xf47ff400 does not match
>   vram_start, restoring 0x007f0000
> 
> To be precise about what those cycles prove: the kernel they were run on
> also carries unrelated local patches for this machine's Thunderbolt
> controller, which fails separately.  This patch is the one that brings the
> display back -- without it the GPU never recovered from a reset at all.
> 
> Tested on 6.18.49 on a MacBookPro14,3.  I have no other smu7 hardware, so
> this is only known to matter on machines whose firmware boots the GPU at a
> different framebuffer location than the VBIOS default; elsewhere the new
> branch does nothing.
> 
> Signed-off-by: Francisco Beltrán Millalén <fbeltranmillalen@gmail.com>
> ---
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -472,14 +472,42 @@
>         WREG32(mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR,
>                adev->mem_scratch.gpu_addr >> 12);
> 
> +       tmp = ((adev->gmc.vram_end >> 24) & 0xFFFF) << 16;
> +       tmp |= ((adev->gmc.vram_start >> 24) & 0xFFFF);
> +
>         if (amdgpu_sriov_vf(adev)) {
> -               tmp = ((adev->gmc.vram_end >> 24) & 0xFFFF) << 16;
> -               tmp |= ((adev->gmc.vram_start >> 24) & 0xFFFF);
>                 WREG32(mmMC_VM_FB_LOCATION, tmp);
>                 /* XXX double check these! */
>                 WREG32(mmHDP_NONSURFACE_BASE, (adev->gmc.vram_start >> 8));
>                 WREG32(mmHDP_NONSURFACE_INFO, (2 << 7) | (1 << 30));
>                 WREG32(mmHDP_NONSURFACE_SIZE, 0x3FFFFFFF);
> +       } else {
> +               u32 fb_loc = RREG32(mmMC_VM_FB_LOCATION);
> +
> +               /*
> +                * On bare metal vram_start is the FB base found at init (see
> +                * gmc_v8_0_vram_gtt_location()).  Normally the VBIOS put it
> +                * there and a later re-POST puts it back in the same place.
> +                * On MacBookPros with switchable graphics VRAM is at 0 at boot
> +                * instead, and a re-POST (S3 resume, ASIC reset) moves it to
> +                * the VBIOS default, away from the addresses the driver
> +                * already uses.  Move it back.
> +                *
> +                * This only happens after a re-POST: the display is suspended
> +                * and the VGA aperture has been locked out above, so there is
> +                * no need to stop the MC.  Only CPU access through the BAR
> +                * could land while the FB and HDP bases disagree, so block it
> +                * here; BIF_FB_EN is enabled again below.
> +                */
> +               if (REG_GET_FIELD(fb_loc, MC_VM_FB_LOCATION, FB_BASE) !=
> +                   REG_GET_FIELD(tmp, MC_VM_FB_LOCATION, FB_BASE)) {
> +                       dev_info(adev->dev,
> +                                "FB location 0x%08x does not match vram_start, restoring 0x%08x\n",
> +                                fb_loc, tmp);
> +                       WREG32(mmBIF_FB_EN, 0);
> +                       WREG32(mmMC_VM_FB_LOCATION, tmp);
> +                       WREG32(mmHDP_NONSURFACE_BASE, (adev->gmc.vram_start >> 8));
> +               }
>         }
> 
>         WREG32(mmMC_VM_AGP_BASE, 0);

