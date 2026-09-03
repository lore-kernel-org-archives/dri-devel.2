Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38F7C624D4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 17:09:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D205B10F693;
	Thu,  3 Sep 2026 17:09:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pvb9llKp";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010036.outbound.protection.outlook.com [52.101.46.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 212F510E442;
 Thu,  3 Sep 2026 17:09:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9gcGXfYzdCqJ2kymo413hVSN35SwO2dPKR/HGNu6Fn0HwyJbqS/4X/GS4pJGSqd+zqL7214fg575mLtHDFEBCAE+wE6aNZPZHQF7iWyEs410kpDrEOY5SEgD/eGDjfHRMSBB5pDKGbhrN4DmNAl8J9X/z563SAN2uKhh5ap5TB/QX2lpCVYKMJGwRXLgdLmxxD8MGpR+LCs2oyxUtIxtA2FEqRFJRSEK8kY5rU9BJwRusak08Ma645PxpY5zRgJdcjNjn1zmyUK6i8TJNAzqXXsT+H0KsyCJ4y09Ae7FSvGKUwPuVoNrX9Nn6iOV2FMql2Gl62SCSBLosSrmoSo4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ocMp67l6CnSrFMOlhP00UCFy08XbsoTZUJNI992mG1s=;
 b=d78rEeqZcHNHfQ5EevFhy0UEOFnJ/BGW47zJUMxk0mq925D4o2gFm9VqbSDYPVxt7Trva7Q6IW41GGrde68bSxoxlQCk8YMTFrzVDNEYrYU5np8kEVPPrr6HaPk97VuRxdhDpEXy9CTwXYH06+FRjIi5XvIPrQtrxFLQP8Sh+tiZREqudG+89TwptwD36XCJwaStEElscgq63Zz5qs2yorgF6tT+Qvj45/PBCwALnRzaXz8LPgF9fodr6U4kgutpMkJKkr1xl9jq8MjbhJa8a4FHFUJpSAveSXZpJ8/IsU2X8W5de6AOEQCNa9WQyWVv1Y4LCVyYkFM3S7xOQ9tetw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocMp67l6CnSrFMOlhP00UCFy08XbsoTZUJNI992mG1s=;
 b=pvb9llKpcURl9646iLcMtSO8wf6oiYk77q4oqKzPovSmALGxwyLNBFcuV3mhfIILa0+19OpwSrQxTz5X4rVYs5cXF2GNUjrny0bVCdhawDMTle0sZWIHsZ9yiojbBO/y5083GsiWFgYagw1P7U5kEbBpmLPIjjMegWbZ5RMJ7ZA=
Received: from SJ0PR05CA0061.namprd05.prod.outlook.com (2603:10b6:a03:332::6)
 by DS0PR12MB8573.namprd12.prod.outlook.com (2603:10b6:8:162::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 17:08:56 +0000
Received: from MWH0EPF000C6192.namprd02.prod.outlook.com
 (2603:10b6:a03:332:cafe::51) by SJ0PR05CA0061.outlook.office365.com
 (2603:10b6:a03:332::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Thu, 3
 Sep 2026 17:08:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6192.mail.protection.outlook.com (10.167.249.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 3 Sep 2026 17:08:54 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 3 Sep
 2026 12:08:54 -0500
Received: from [10.254.92.26] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Thu, 3 Sep 2026 12:08:53 -0500
Message-ID: <8ac6b948-027d-4bbe-a64b-dfab3a858921@amd.com>
Date: Thu, 3 Sep 2026 13:08:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: fix MALL hysteresis timer underflow at
 high refresh rates
To: Francis Marlou Pacaro <pacaro.francis.marlou.n@gmail.com>,
 <amd-gfx@lists.freedesktop.org>
CC: <harry.wentland@amd.com>, <siqueira@igalia.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <dri-devel@lists.freedesktop.org>
References: <20260903055952.62906-1-pacaro.francis.marlou.n@gmail.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20260903055952.62906-1-pacaro.francis.marlou.n@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6192:EE_|DS0PR12MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b31c296-6668-4b59-baad-08df09de0915
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|42112799006|82310400026|1800799024|376014|13003099007|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 3m4CQD+1m6M4THhQf4Z7dGino9pGk1dcv3RkXAS8VlLVrFBdPVqeAQd4mR/Hk/7aEvSoc35TtgzAMRwtZPxIqaOwK25dMDCqMLDAvgmoqLXNS1BBEBWvwZ8tevZ0k7v7NOL6/QR0LSdcJ1+9Sa47Di8fzgcjYn5lTthcS8ni+4IXW5Un0OGU8zg4IGcGmWL0bHzl+t2Rh4vdQcBfkzdpB7Dn+mFMkQv3xD7gQT85JqpHeyPcWdHc5SM4RCV1Fwg5HQnsYvlpi06VTagBUVEsCyTEhEcQLNy9Nt8zvu++4QoWrGrmlLdltEuSck2RYXWo4iChyfF7ShL/9G88OLQM3iB7op6AktIN/YXndQV9a++VRi56byfTz7nBDHd9lMVIm9MuNvyLJybPon4ETB50nTf7pP9Dfsd+Zhhk+4k9m64TNdrJEHPOD2PyHnuAajctj/6WgcLlt1ZRXrQmB431B+T9ndawpAyH5ObTwDcTyRcrMSY5VkGQ6RIDL4wi/kdpxlHcm8WohdQGbAae2vqBRjLWwa+JB7SnylQ5OHXx6cxylQQhz3NJZZcF/zLcouHbZsC1p6oHAU6dYXJ6ZeHp61PRnMZNUuGOY57jemyA+nWIeqVvRb3YEXCYHe23nOZWY0u+kMw0Wppxql1wUvGgwQqW8oxoS9OyK23wy/EywlD86X0d5H5TdbTV8ohMeG6BEmDHHy2OKQ4LCymka2GXgw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(42112799006)(82310400026)(1800799024)(376014)(13003099007)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DyFhHcfq8bPBhSb2Vsa5uZBCV8xcfnGmwbK1/nk1kCk16OfGh3ZuHCf082Ey+nGixLd4eGkKf0dVx6ntNhCmTT1sbHErfSgm7XTqTIuotR+QaG699A57b3UIA8QcRb5UotC54hfwHiDzJPWPXt5iu5P3dN349GXf3FGu+7Auhy2lX98XVX2CL1biUBsyvHCWb6l/JTYfBLLa2Zuov5LkDkIlRrzboq5PPUCMmZzwLcyYNgTf9A2B/4wY9SyyHrZH+7RYZv2qZwWIzfHT5Al9vf4itd6oLzhgPv5/qPPmIyNbp9Z22jvCVvJ794umtPusRtOmupUYImx8sXOJHKs+mBwft89bXKLIovHk/KyYETCyxU/Z0dVtYDPG8ptkJe3EuwYkFLecQimqoZXNbuhhE7Dwc7oe4vBwNEaX+LL7SPPXDEYMg5KbI+kM5M1xw65X
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 17:08:54.8317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b31c296-6668-4b59-baad-08df09de0915
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6192.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8573
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



On 2026-09-03 01:59, Francis Marlou Pacaro wrote:
> [You don't often get email from pacaro.francis.marlou.n@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> dcn30_apply_idle_power_optimizations() derives the MALL frame cache
> hysteresis timer with
> 
>         tmr_delay = (uint32_t)(div_u64(..., denom) - 64LL);
> 
> div_u64() returns a u64, so when the quotient is smaller than 64 the
> subtraction wraps instead of going negative and tmr_delay ends up huge.
> The loop that follows tries to squeeze it into the 6 bit register field
> by doubling denom, but that only makes the quotient smaller, so tmr_delay
> can never converge.  tmr_scale is bumped past 3 and the function gives up
> with
> 
>         /* Delay exceeds range of hysteresis timer */
>         ASSERT(false);
> 
> even though the requested delay is too *short* to encode, not too long.
> 
> With mall_additional_timer_percent left at its default of 0, the quotient
> drops below 64 once the refresh rate used for the calculation goes above
> ~243 Hz.  Every DCN 3.0 display above that loses MALL static screen
> entirely and splats a WARN once per boot.  Reproduced on Navi 23
> (RX 6600) driving 1920x1080, resetting /sys/kernel/debug/clear_warn_once
> between modes:
> 
>         refresh   MALL       ASSERT
>         144 Hz    enabled    no
>         240 Hz    enabled    no
>         280 Hz    skipped    yes
>         360 Hz    skipped    yes
> 
> Commit 3bb68cec4db8 ("drm/amd/display: Add Overflow check to skip MALL")
> already covered the other end of the range, where a large stutter period
> makes the delay too long to encode.  Cover the short end by clamping to
> 0, which selects the shortest hysteresis the register can express,
> 65.28us * 64 = ~4.18ms.  That is marginally longer than what the formula
> asks for at these refresh rates, and erring long is the safe direction:
> it only delays MALL entry, it can never enter early.
> 
> The numerator does not change between iterations, only denom does, so
> compute it once and keep both call sites inside 100 columns.
> 
> The genuinely out of range case at very low refresh rates still reaches
> the ASSERT, which is where it belongs.
> 
> Fixes: 52f2e83e2fe5 ("drm/amdgpu/display: add MALL support (v2)")
> Signed-off-by: Francis Marlou Pacaro <pacaro.francis.marlou.n@gmail.com>
> ---
> Compile tested only: vanilla v7.2.2 built with clang 22.1.8 on x86_64
> using a CachyOS .config, full amdgpu module, no new warnings.  The WARN
> reproduction described above was observed on unpatched 6.18.48 and
> 7.2.2; I have not yet booted a kernel with this patch applied.
> 
>  .../gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
> @@ -1064,10 +1064,12 @@
>                                  */
>                                 unsigned int denom = refresh_hz * 6528;
>                                 unsigned int stutter_period = dc->current_state->perf_params.stutter_period_us;
> +                               u64 num = (1000000LL + 2 * stutter_period * refresh_hz) *
> +                                       (100LL + dc->debug.mall_additional_timer_percent);
> +                               u64 tmr_ticks;
> 
> -                               tmr_delay = (uint32_t)(div_u64(((1000000LL + 2 * stutter_period * refresh_hz) *
> -                                               (100LL + dc->debug.mall_additional_timer_percent) + denom - 1),
> -                                               denom) - 64LL);
> +                               tmr_ticks = div_u64(num + denom - 1, denom);
> +                               tmr_delay = tmr_ticks > 64 ? (u32)(tmr_ticks - 64) : 0;

Thanks for the patch, the 0 clamp makes sense to me.
Only change: s/u64/uint64_t/ to follow DC convention.

With that,
Reviewed-by: Leo Li <sunpeng.li@amd.com>

- Leo

> 
>                                 /* In some cases the stutter period is really big (tiny modes) in these
>                                  * cases MALL cant be enabled, So skip these cases to avoid a ASSERT()
> @@ -1089,9 +1091,8 @@
>                                         }
> 
>                                         denom *= 2;
> -                                       tmr_delay = (uint32_t)(div_u64(((1000000LL + 2 * stutter_period * refresh_hz) *
> -                                                       (100LL + dc->debug.mall_additional_timer_percent) + denom - 1),
> -                                                       denom) - 64LL);
> +                                       tmr_ticks = div_u64(num + denom - 1, denom);
> +                                       tmr_delay = tmr_ticks > 64 ? (u32)(tmr_ticks - 64) : 0;
>                                 }
> 
>                                 /* Copy HW cursor */
> --
> 2.51.0
> 

