Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48999CDE009
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 19:16:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A46E610E254;
	Thu, 25 Jun 2026 19:16:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mEujgvv7";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012035.outbound.protection.outlook.com [52.101.43.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B63710E247;
 Thu, 25 Jun 2026 19:15:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVmDX6rG5y647IHi1pzBo1hKieO9idpwT7f2wpn0bITFg7rNxg7ZpwHEEN3v6vFZq5+/5Aj2h7STxMv60icIwjU4lrmKmustgzknsnuCyWsc9s5+2207SRplo+2orxv5Gf44z3pf6/xmNU2Wu4lhoBp3PUIsnfuKQ9jX2XfTD3bCwaW7KKwBs5HhSrlFh8isjCmzdA0JIYkSluQSzDxzwsykex9aBCJyva1VQgAilWk8oTayjX3FvzjXasaHV/W9NGPQ5EVXtorn7S/zpLxx6+CluHTHvig/d7x1fY7e1WLvfdBAaKiCDnK1vAi4vofdbkm/q37k7UY6mJcd4gpRag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ES07sq1WBgWXcQvBiVoPybOiUblrWgl3f03Zfs+MRzs=;
 b=qf37Psf6sJfb8uoY+4dAylrvfl5B08gGUXskIr2wNZvlX2HbxTqwwX6wsFX0Jw2gLC51RR2iC3DVNp1f4Ao5OU8q4VB47PiYJUzbw6efyKteQlDySizqCi3Q4EZc4iMgPagB0GOci6mbaDVT8wRcGA5CAmOGps190o2bFxkNwkT21xQTCSkiTKhTrA9PsGe3+KqlomPDc/3PdPaN6aVPBS0z2zCrmdXAtHLRCcPbyULY4prhhFTNg7bO8CQxtsx01eVIMnP/OLQMc1n64AnQTnvDYmgH8lSkz3GHDR1re+sVhmLrn8Td2f2ZId7FLv6dWgW1eqdrDNItwlrtVL40uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ES07sq1WBgWXcQvBiVoPybOiUblrWgl3f03Zfs+MRzs=;
 b=mEujgvv7/0mAgoOD6xkvvdTWvVWSaHrxRdD7/OvmCZUL9LURXI55bxEmRwQ94TtfC/P5m+4twr2lSdjPwCEEwUV1ugM3gkdR5fdXFIXE3LIwmlvC9qO4OIpzZbqYLiNwDOlJFmJd40dFQhAOZtfLBJQyrQt1rktc1f/7OkUtT9w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB7526.namprd12.prod.outlook.com (2603:10b6:8:112::20)
 by PH7PR12MB8106.namprd12.prod.outlook.com (2603:10b6:510:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 19:15:54 +0000
Received: from DM4PR12MB7526.namprd12.prod.outlook.com
 ([fe80::2fa8:813a:3ec7:1f8d]) by DM4PR12MB7526.namprd12.prod.outlook.com
 ([fe80::2fa8:813a:3ec7:1f8d%4]) with mapi id 15.21.0159.016; Thu, 25 Jun 2026
 19:15:54 +0000
Message-ID: <928d4c2a-d8b7-43d7-995e-a3e6996d2952@amd.com>
Date: Thu, 25 Jun 2026 15:15:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] drm/amd/display: extend HPD debounce filter to
 DisplayPort SST
To: Nick Haghiri <nick@haghiri.net>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260625150439.330875-1-nick@haghiri.net>
Content-Language: en-US
From: Ivan Lipski <ivlipski@amd.com>
Organization: AMD Inc.
In-Reply-To: <20260625150439.330875-1-nick@haghiri.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0080.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::15) To DM4PR12MB7526.namprd12.prod.outlook.com
 (2603:10b6:8:112::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB7526:EE_|PH7PR12MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: ce590e77-61f5-48a1-b874-08ded2ee2d5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|3023799007|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 2XWTmKozP8MQWvFOmcLm/hC2dA/OOOtQx9COI1MY1qshAxD8DPTnVJ60d9lgRhnOctQAUjPl4ShTMxtTP2SEVQAcbQo4t+gT+EKNQPJOOsr4drdaVXGnHgE3T7N/UpuI7R0MOw7fGO58zQGpkUvCqCgNqXDXXhlVQoAcJTY9pJ06IcxRJVwkW+LGlSu392O835WbYrUMZ1hfynmzsn9eBYi8qDHwMEfUQiQ/D6frt/M94lu7Zp4VKFQHORBfP4YK3APp6gFqpI1WrBqj1McYQDbHHbKOLdo6Fy9Vl5Jqr7r5c83f8Zyd16DUOJjBBagYgmb3YIYZ/nMH5BJCnktqeixECPGmJaqDi1R/pvKqW+PU+a9XIc3X4BqNRO+a6Mjy3jGbEGeIOVu2JPC8OMiaV/iCLFceXNtctqJBiJZ5igq5kdoq7ufwYru202gOXQUI2WQOiD9QTa3GAcomjaNTGoJBQZX3koXMsgAE3VD0am+aNOdrJXxN+lv74AgfgZM0XK+C234yJ2gapwjxgVLEhLu8hr1IApinVOoysoVbuBXap5/KAqL9CShkAvzgHDc/vAhm39CVoXM5SgnnsW3GcgSqojeKyRL3N5v2C/fyVam+tKgPDK8lcPBCr1Uhe4VW7b+H0Wo0NJr94jDiVjKTxm7ANVS8yTeAnIKjwEJibKo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB7526.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(3023799007)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejBUWW1xMWtnMTh5dlQ2TGI4dEVucEhQTncxTmRxeFNJS1ZWNmY3LzZIYnhr?=
 =?utf-8?B?THM4cENuV1R6b0p6OVoycnd6R2RJMFlRTWlIMTVvd1pFcUgvcXg1TTlDdnZ1?=
 =?utf-8?B?ZzNMM3ZzU3dBRkx5RzNHSW5kTzZIRktvRGdDVnJUbGVIYjZoRUMvRWp2WlNU?=
 =?utf-8?B?SzJXN1RQU1NGajJEeWhuVVpybzZuNldrRzN6cFNJdFR3K28zYWxrMmw0MFYz?=
 =?utf-8?B?UjF0aFZFR1VsVXVQeDBzZlIzSUZqTThDQ09XK0JsRGNzb3BnTW4wZWxMS2ha?=
 =?utf-8?B?MU1DeHVwSTNlOFo1RUpzV1VsdHpLZEVzNHhhMmRSY2VNUzYyUVJ4eDBDbTJn?=
 =?utf-8?B?b1VzNUNoS04ralVsV0ZDUVJBSUt4Ky9MSyttaVo5ZCtpZWU3cWM1UWtROGx3?=
 =?utf-8?B?dktXa2xCckE2QjdZMHY2d1Yzbng4VUk1eEozV1RiTElaTU5JVklnNlRMNXZB?=
 =?utf-8?B?aDlFTzRvR3NNTkNFVVdaVkpjd2RHNW5ZY21VMHpjTGZqd0huYlFEcCsyQ2hq?=
 =?utf-8?B?SEZtRXRRS2RrNkJ4TmVmQTl0MHNjanVkL1JyRnY1eVBhelF1S1NZOFZvY1V0?=
 =?utf-8?B?a0ZCV3VreURyQXNsWUZxVEgrekhNcXVudnM2OGQ4N1ErYUo0UTFZSXlDS1dX?=
 =?utf-8?B?TkFCcU1jS0Myam1ZTXgzQkhTV08wam1SWXpURGVjWFpTY2drM0ZWWmZRbEQr?=
 =?utf-8?B?UGpqT1gzWDhnbnFhTUVuOXNDU0JIMkIyc1ZNbG02VTU0MUxTdWdYVUhpbzl3?=
 =?utf-8?B?NXdPZ01qME11MHJNcDAvNWt3Z1lBMERNMXJmd2JBT25SRW9TRnR0ZE1hT2xk?=
 =?utf-8?B?emRBQkpUNEhIR212QlorMytQZjlQMUtjY1p2WW03Sno3WUluQ2I4NFFzZUQ3?=
 =?utf-8?B?cG1TU2p3eU1Oajc1QThwU0FxM3U0V0E5UzVHMzRwZFV4TVlkTlhZcnI3Smk3?=
 =?utf-8?B?MWhJd2JZZFpxNGFxdHBYcER2bDBWaUZqblcva0xUMStzcTR6KzNqTHZrUDhq?=
 =?utf-8?B?SG5hZk9ra082MHVPUHUwKy85L3BrQTJGd3R0RTFxVmJrdVh0SDlXdzNSUmhy?=
 =?utf-8?B?TjJEdkJReVUxTmh4dTExUXJ4dENzMUZEN3VMNVI3ZHgxaWlBT2NWODc3Uldk?=
 =?utf-8?B?YUQ1dVRGa0U3VDFWWUpsRGEzVTNpTGtMcUo3MkUzTGJkTFEyMDRuM0I1ZXdz?=
 =?utf-8?B?MzVEcGdYcCtMVE5XU0xxeGhCQm5oNUNGbVhGNzF3RTNsalg1L0psejJlQlhz?=
 =?utf-8?B?d2c0N2Y2Z0U4SmFod0lIWnBJVGczMGVNaGxkN2dRS3hPVzBnZ0hWajFETGww?=
 =?utf-8?B?R0VZSkNWbDFEWlpGSjZhQ28vNXY3VGhNbmIrTnFxK0MwbVhZdkFvNG45b2V3?=
 =?utf-8?B?TStza25tdmgrbG5DWTVqbVAzMW5JRkUyS20xSThrQndleFVtT0hOQkQ4c1Zz?=
 =?utf-8?B?djMzUGpFanFMMmwyVXN5L2JxK21CSFVVbFFaV3l1NlEvOTZGMXVPaG5LODhm?=
 =?utf-8?B?ZWg0QjBheUhHNDRvQmJPT2NNUk5YMzRzSytDUTk1bGtHVEp6RUNEZSszTE9q?=
 =?utf-8?B?aVN1Z3JIdU1tVjAyTHZZcGJ5MnBvWG5nMm5zWm1OdmVQMG5xTXZCWGlZekt4?=
 =?utf-8?B?SXJWM2d5ZFU1bHd1aXRZREJmZVEwWVlCNmxxb0ZLaFZwTHlrdUEyVEZwb21j?=
 =?utf-8?B?SkVDQ0MyYktjeHZRZ2xxYlNZL0Ira2tSSU44VEIvdldtNnJ4V1YwUTl1c1Qv?=
 =?utf-8?B?NU5udWJsLy9CdDVocHdJYW5OYjNNdWZwWUtoU0g0SEczVVBQaWVab3Vtblc0?=
 =?utf-8?B?enpOaFFWU3B4U2RMQTZ6bEFEbEUrd0NUWWpQZ00wR09hOWFieWJST2w5V3cv?=
 =?utf-8?B?RHNVN0E2c1BYTitWMEtUTFBmMHhGM29RWk1rRDZLcVFqeXlYVDJrekVITkR3?=
 =?utf-8?B?d1l4MmRRdU5kbGZmSjZxamJMTHgzZ1ZYRVJzb2p6dEY2Y1FNZkl2ZWo5VzlZ?=
 =?utf-8?B?RjNYb0xmWjlpVjBCVk9kazkxN01iMWFQVnlUTDFDQjc2aFVVMGlZKzliZUdE?=
 =?utf-8?B?SVl2R0wrR2hYZk43b1dZcGpid0hjUmlYWE0ydkt1cjZiNXNBZFF1ZXFXYjlU?=
 =?utf-8?B?bVJBdUxTVzg5aTNWaTJpWFBWUkVKTnVkMjZJS0hkaytJVmphTk5kWkhOMVF6?=
 =?utf-8?B?aGZudUFGUko1cS9rVjdJUTBjVUNTQ2VuWU1rSTEyYzl5N3lKUXNvWTB5amh6?=
 =?utf-8?B?NUZEMzg3cmJHb05jci9OMGhFc0VDb0cyVUFnN3dMcGlOTCt2RDlQTjhBTHY5?=
 =?utf-8?B?aUliWUJodk5aNkF5RHpIbW56L0RwVHBFSlhNYmd2TmdEQ2swekZ4dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce590e77-61f5-48a1-b874-08ded2ee2d5e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7526.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 19:15:54.0573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3M2OwsW4Td+jUW4oBrKXivojg3CIP8EgHkq3mwdqpsoCe/Kw48gxcmCCSJeymCw9bVXs+AB6oF5wDZMuCfk8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8106
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


On 6/25/26 11:04, Nick Haghiri wrote:
> [You don't often get email from nick@haghiri.net. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Commit c97da4785b3b ("drm/amd/display: Add an HPD filter for HDMI") and
> commit 6a681cd90345 ("drm/amd/display: Add an hdmi_hpd_debounce_delay_ms
> module") added a filter that, on an HDMI disconnect, waits
> hdmi_hpd_debounce_delay_ms and suppresses the hotplug if the sink comes
> back with an unchanged EDID, instead of churning userspace.
>
> DisplayPort SST sinks show the same pattern: some monitors briefly drop
> and re-assert HPD when they enter deep sleep after DPMS-off. On the DP
> path that toggle is forwarded as a real hotplug, so the compositor
> re-probes and re-enables the output and the panel can never stay powered
> off while connected.
>
> Extend the existing filter to DisplayPort SST behind a new
> dp_hpd_debounce_delay_ms module parameter (default 0/off, mirroring the
> HDMI knob). eDP and MST are excluded; are_sinks_equal() and the debounce
> work are reused unchanged.
>
> Signed-off-by: Nick Haghiri <nick@haghiri.net>
> ---
>
> RFC notes / open questions (below the --- so they stay out of the commit):
>
> - Near-mechanical port of the HDMI filter to DisplayPort SST. I run it
>    daily on an RX 9070 XT (RDNA4) driving an MSI MPG 274U over DP, which
>    briefly drops and re-asserts HPD on DPMS-off and otherwise keeps the
>    panel from staying asleep; dp_hpd_debounce_delay_ms=1500 fixes it.
> - The DP path reuses the existing debounce work and ->hdmi_prev_sink, so
>    those names are now a little misleading. Happy to rename them to a
>    generic hpd_* if you'd prefer.
> - I added a separate dp_hpd_debounce_delay_ms knob to mirror the HDMI
>    one; folding both into a single hpd_debounce_delay_ms applied by signal
>    type would work too. Let me know which you'd rather have.

Hey Nick, thank you for this patch.

I don't think I've encountered a situation when a monitor with DP can 
wake a system up from DPMS, so that's interesting. What distro and 
desktop environment are you using? I'd like to reproduce this issue and 
help with it.

I think generalizing the hpd_debounce_delay for both DP and HDMI would 
be better. Maybe we can also enable hpd_debounce_delay by default 
for monitors, that are known to have this issue, using apply_edid_quirks


>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 12 +++++++++
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  6 +++++
>   .../display/amdgpu_dm/amdgpu_dm_connector.c   | 20 ++++++++-------
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 25 ++++++++++++-------
>   5 files changed, 46 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index e2d4be3c1..c085a6cc1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -271,6 +271,7 @@ extern int amdgpu_user_queue;
>   extern int amdgpu_ptl;
>
>   extern uint amdgpu_hdmi_hpd_debounce_delay_ms;
> +extern uint amdgpu_dp_hpd_debounce_delay_ms;
>
>   #define AMDGPU_SG_THRESHOLD                    (256*1024*1024)
>   #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS         3000
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 65f2de86f..78df53b8c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -246,6 +246,7 @@ int amdgpu_umsch_mm_fwlog;
>   int amdgpu_rebar = -1; /* auto */
>   int amdgpu_user_queue = -1;
>   uint amdgpu_hdmi_hpd_debounce_delay_ms;
> +uint amdgpu_dp_hpd_debounce_delay_ms;
>   int amdgpu_ptl = -1; /* auto */
>
>   DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
> @@ -1113,6 +1114,17 @@ module_param_named(user_queue, amdgpu_user_queue, int, 0444);
>   MODULE_PARM_DESC(hdmi_hpd_debounce_delay_ms, "HDMI HPD disconnect debounce delay in milliseconds (0 to disable (by default), 1500 is common)");
>   module_param_named(hdmi_hpd_debounce_delay_ms, amdgpu_hdmi_hpd_debounce_delay_ms, uint, 0644);
>
> +/*
> + * DOC: dp_hpd_debounce_delay_ms (uint)
> + * DisplayPort SST HPD disconnect debounce delay in milliseconds.
> + *
> + * Used to filter short disconnect->reconnect HPD toggles some DisplayPort SST
> + * sinks generate while entering/leaving power save. Set to 0 to disable by
> + * default. eDP and MST are not affected.
> + */
> +MODULE_PARM_DESC(dp_hpd_debounce_delay_ms, "DisplayPort SST HPD disconnect debounce delay in milliseconds (0 to disable (by default), 1500 is common)");
> +module_param_named(dp_hpd_debounce_delay_ms, amdgpu_dp_hpd_debounce_delay_ms, uint, 0644);
> +
>   /**
>    * DOC: ptl (int)
>    * Enable PTL feature at boot time. Possible values:
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 2f4a56741..abc17f547 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -64,6 +64,11 @@ enum amd_vsdb_panel_type {
>    * Maximum HDMI HPD debounce delay in milliseconds
>    */
>   #define AMDGPU_DM_MAX_HDMI_HPD_DEBOUNCE_MS 5000
> +
> +/*
> + * Maximum DisplayPort SST HPD debounce delay in milliseconds
> + */
> +#define AMDGPU_DM_MAX_DP_HPD_DEBOUNCE_MS 5000
>   /*
>   #include "include/amdgpu_dal_power_if.h"
>   #include "amdgpu_dm_irq.h"
> @@ -875,6 +880,7 @@ struct amdgpu_dm_connector {
>
>          /* HDMI HPD debounce support */
>          unsigned int hdmi_hpd_debounce_delay_ms;
> +       unsigned int dp_hpd_debounce_delay_ms;
>          struct delayed_work hdmi_hpd_debounce_work;
>          struct dc_sink *hdmi_prev_sink;
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index 6143cdcf2..c79a8ada8 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -1747,8 +1747,8 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
>          if (aconnector->mst_mgr.dev)
>                  drm_dp_mst_topology_mgr_destroy(&aconnector->mst_mgr);
>
> -       /* Cancel and flush any pending HDMI HPD debounce work */
> -       if (aconnector->hdmi_hpd_debounce_delay_ms) {
> +       /* Cancel and flush any pending HPD debounce work */
> +       if (aconnector->hdmi_hpd_debounce_delay_ms || aconnector->dp_hpd_debounce_delay_ms) {
>                  cancel_delayed_work_sync(&aconnector->hdmi_hpd_debounce_work);
>                  if (aconnector->hdmi_prev_sink) {
>                          dc_sink_release(aconnector->hdmi_prev_sink);
> @@ -2829,16 +2829,18 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
>          mutex_init(&aconnector->handle_mst_msg_ready);
>
>          /*
> -        * If HDMI HPD debounce delay is set, use the minimum between selected
> -        * value and AMDGPU_DM_MAX_HDMI_HPD_DEBOUNCE_MS
> +        * If an HPD debounce delay is set, clamp each signal's delay to its
> +        * maximum. The debounce work and cached sink are shared by both the
> +        * HDMI and DisplayPort SST paths.
>           */
> -       if (amdgpu_hdmi_hpd_debounce_delay_ms) {
> -               aconnector->hdmi_hpd_debounce_delay_ms = min(amdgpu_hdmi_hpd_debounce_delay_ms,
> -                                                            AMDGPU_DM_MAX_HDMI_HPD_DEBOUNCE_MS);
> +       aconnector->hdmi_hpd_debounce_delay_ms = amdgpu_hdmi_hpd_debounce_delay_ms ?
> +               min(amdgpu_hdmi_hpd_debounce_delay_ms, AMDGPU_DM_MAX_HDMI_HPD_DEBOUNCE_MS) : 0;
> +       aconnector->dp_hpd_debounce_delay_ms = amdgpu_dp_hpd_debounce_delay_ms ?
> +               min(amdgpu_dp_hpd_debounce_delay_ms, AMDGPU_DM_MAX_DP_HPD_DEBOUNCE_MS) : 0;
> +
> +       if (aconnector->hdmi_hpd_debounce_delay_ms || aconnector->dp_hpd_debounce_delay_ms) {
>                  INIT_DELAYED_WORK(&aconnector->hdmi_hpd_debounce_work, amdgpu_dm_hdmi_hpd_debounce_work);
>                  aconnector->hdmi_prev_sink = NULL;
> -       } else {
> -               aconnector->hdmi_hpd_debounce_delay_ms = 0;
>          }
>
>          dm->hdmi_frl_status_polling_delay_ms = 200;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> index 85711a2f2..2a732d19b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> @@ -1302,6 +1302,7 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector,
>          struct dc *dc = aconnector->dc_link->ctx->dc;
>          bool ret = false;
>          bool debounce_required = false;
> +       unsigned int debounce_delay_ms = 0;
>
>          if (adev->dm.disable_hpd_irq)
>                  return;
> @@ -1325,10 +1326,16 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector,
>                  drm_err(adev_to_drm(adev), "KMS: Failed to detect connector\n");
>
>          /*
> -        * Check for HDMI disconnect with debounce enabled.
> +        * Check for an HDMI or DisplayPort SST disconnect with debounce
> +        * enabled. eDP and MST are intentionally excluded.
>           */
> -       debounce_required = (aconnector->hdmi_hpd_debounce_delay_ms > 0 &&
> -                             dc_is_hdmi_signal(aconnector->dc_link->connector_signal) &&
> +       if (dc_is_hdmi_signal(aconnector->dc_link->connector_signal))
> +               debounce_delay_ms = aconnector->hdmi_hpd_debounce_delay_ms;
> +       else if (aconnector->dc_link->connector_signal == SIGNAL_TYPE_DISPLAY_PORT &&
> +                aconnector->dc_link->type != dc_connection_mst_branch)
> +               debounce_delay_ms = aconnector->dp_hpd_debounce_delay_ms;
> +
> +       debounce_required = (debounce_delay_ms > 0 &&
>                                new_connection_type == dc_connection_none &&
>                                aconnector->dc_link->local_sink != NULL);
>
> @@ -1344,12 +1351,12 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector,
>                          drm_kms_helper_connector_hotplug_event(connector);
>          } else if (debounce_required) {
>                  /*
> -                * HDMI disconnect detected - schedule delayed work instead of
> +                * Disconnect detected - schedule delayed work instead of
>                   * processing immediately. This allows us to coalesce spurious
> -                * HDMI signals from physical unplugs.
> +                * HDMI/DP HPD signals from physical unplugs.
>                   */
> -               drm_dbg_kms(dev, "HDMI HPD: Disconnect detected, scheduling debounce work (%u ms)\n",
> -                           aconnector->hdmi_hpd_debounce_delay_ms);
> +               drm_dbg_kms(dev, "HPD: Disconnect detected, scheduling debounce work (%u ms)\n",
> +                           debounce_delay_ms);
>
>                  /* Cache the current sink for later comparison */
>                  if (aconnector->hdmi_prev_sink)
> @@ -1361,8 +1368,8 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector,
>                  /* Schedule delayed detection. */
>                  if (mod_delayed_work(system_percpu_wq,
>                                   &aconnector->hdmi_hpd_debounce_work,
> -                                msecs_to_jiffies(aconnector->hdmi_hpd_debounce_delay_ms)))
> -                       drm_dbg_kms(dev, "HDMI HPD: Re-scheduled debounce work\n");
> +                                msecs_to_jiffies(debounce_delay_ms)))
> +                       drm_dbg_kms(dev, "HPD: Re-scheduled debounce work\n");
>
>          } else {
>
> --
> 2.54.0
>
-- 
Thanks,
Ivan Lipski

