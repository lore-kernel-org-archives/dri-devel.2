Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95F8C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 17:25:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A65A10E442;
	Thu, 24 Sep 2026 17:25:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fQj2YWZl";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010008.outbound.protection.outlook.com [52.101.46.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 204EA10E2D1;
 Thu, 24 Sep 2026 17:25:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flMJVU+1DqLCcKOGlefNB+bzW0UZolWgfbrGT5QarxEog/kch7TfZMCrrYr3N5L+kz51ZkdmUQc/WpKm+7p6ZAwqC79Ri2vhW2f2h8nDg0ZnNbnR224jBJeCXX1veo3SQP/EAiF/XPQ2A14txmGke7b/+nvANUq/uih3TO6CZTpS/CqZ+kvvvo7pFMEe+irYSJOGSAqEOWPKSOVsSt34z7OAHNl6dtN33LDjHhWYYmYxawNAxm/dz3VCRse45YNGY+lTQ2rnNrrVaJLmMQkHSfK4dl96rt8TMWaFGHhuMaTv1J3LSzcS0U2LgxpBw1xAENGOedbOOwvliwXiBLwDyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1koGBfnaMmVCwmDShiN+XLj2B/AGr00sT8UX27xMdI=;
 b=TbjDPZWlNLD8NFVnAlQfooRPzW6oqXI0H7S39P24kDShc3INbsj5/sS+Ew7lEl9j6waSXF/FdSz8itOvZSBvLfTN9GMf4c3Dd9nSj2DXBfrWjkD9jdYLMaI5NXEccjNOW02wbjcXigzcNZtg5/L0L86tDVjvoxHYiaeUIPT0LmggvFdBJ1fMmYXoHre2hCj5h3Dzp2Wppp3a+Q7yDgpiO9Dg2ON2We00dNAMDvEA7shyoFEcW5Yj8arM9GA4KEjPPPs3+dLB2g/WBoZ5pyVVNZDmXKKLF4KvX5ik8YbfyOrJhSWsxbTwmZA8HK+TceDgfhQzY+CJoRDqQDBV+vr9HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=mailbox.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1koGBfnaMmVCwmDShiN+XLj2B/AGr00sT8UX27xMdI=;
 b=fQj2YWZloEajFBiL7tEOEq+XZ2+H0eSQXYg7sNmm+Ji3a3pGNevVBSMPXWpMYV32orMfB0tgMp34LzwTb3pu2z8W7t1S4cfBtVge23HTPMbeT8Bx/R59ov6nL4AqDvtPNvQYw/J/5V3ZtZitGFQLXgpZPYliBfP3AkzbkwQZ+IA=
Received: from BN9PR03CA0780.namprd03.prod.outlook.com (2603:10b6:408:13a::35)
 by CH3PR12MB7738.namprd12.prod.outlook.com (2603:10b6:610:14e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 17:25:32 +0000
Received: from BN1PEPF00018546.namprd05.prod.outlook.com
 (2603:10b6:408:13a:cafe::73) by BN9PR03CA0780.outlook.office365.com
 (2603:10b6:408:13a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.17 via Frontend Transport; Thu,
 24 Sep 2026 17:25:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00018546.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 17:25:31 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 12:25:31 -0500
Received: from [10.254.92.96] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 24 Sep 2026 12:25:30 -0500
Message-ID: <c5548cd7-c00f-49be-b031-c331bca4eefd@amd.com>
Date: Thu, 24 Sep 2026 13:25:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix stale replay_events after mod_power
 stream removal
To: Simon Polack <spolack+git@mailbox.org>, Harry Wentland
 <harry.wentland@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, Ray Wu
 <ray.wu@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
References: <20260917104234.18858-1-spolack+git@mailbox.org>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20260917104234.18858-1-spolack+git@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018546:EE_|CH3PR12MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: 458e3c5a-bbc3-4cee-dcaf-08df1a60d609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|42112799006|376014|82310400026|36860700016|23010399003|56012099006|10067099003|5023799004|11063799006|6133799003|22082099003|18002099003|3023799007|13003099007;
X-Microsoft-Antispam-Message-Info: eQdtP4rEv7OdZPenrP2+SW2wBYFcnreIcppVQFWM6lfQpP5QwnpUrSgz5m3r1uDZskAHjTR/Nqhu8jQPYTKsu5Sl72oFqQZBA6O8kJN8bV7oF1h1n2xntn8AiG3dowbfqc5GN+rM45i1tH1JdJsBkMDYSfKrv8aBqnSBVrcp8qyZV2Hx19ySMmEAIHyZu+uASs+9jIHX6NvSkFZQD+VZrfL4tdeGJsu7jFXYCfihTRs/VUflyOjsoqJB3b8j3dHXFNgnbyC+yU4bp/kTrjXHwdIJmJnNYPr5TpkfvcoFBhlI1CqBB34C5YRZciUnGnEL7dGgjAZM62tbconRFH8s6PRPK8TvVrpgaisypVHLJPF27oLlTM94k3Bhqow+W8/i6YEZwxq28m6c+BXtdkoGqU6XrVNVsJMfFLneUd7eIFKS/IsBOqlZLe95uJou1aMsd9WcjoxlbnZhV3A3AlkcOuimnBWVme8WJkWxlsCvjpi0bq3qyJf5xsM6reg+9olKsKbw5RE5ep58zTlnKX//Bu6L3aS+ipQGaW7cyetRQv0K48DNG7je34aTFP/MixVYMsjz+0sty51cDmLs284w7zqB2vwd/1HOd6ZcE+HgB9JzMBSy3HzOi93JBy+hbIWD5dA/BXXWcfGpsGiNq6yngera3b/k7ft2QLcn6C0q+JwQRljqR42ZS+Brp2w9I3M2OBfk1e+WZvQkBxSqODECRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(42112799006)(376014)(82310400026)(36860700016)(23010399003)(56012099006)(10067099003)(5023799004)(11063799006)(6133799003)(22082099003)(18002099003)(3023799007)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nC3HOcO+KsEFbixVFdlVsN/d63Zk8ekS+RaHRx1ICGeG8oVOsSdVTgQ6RLIRWSlrC55ARugl9oPPE3s59Zg2C7fSGm/4RsApBH3HIigt/Byx8EO2iXUog7PBN2TKvCF/KbGUblj2OXVAjj7A/q4JUM6Q9VO7U+dpkATsZMau1eue3tEfktPv8AN+NcbsevQHX1nu1gJcpQFu3bhyMFIZcHwAM9ZDzUvUoMV2VBeWomhiOXDCOnfJezg3W/RlUpDwORr35SbbXqATUchHK+xfBbtP6iGg16WdHg1RONMgK0jaIP535QCl3icab8skRA9qgmJtwJ3NhQ4QyufB47qJW6XHY1B37CbafBPMWaa2/3Drh8qTseno9UXInq45/aNY8s8U5AoPlRGDJm2luNz4HLnaaRQpaksD1ZCPMEGAf/z7aCT542bMmBMoShuxQTOl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 17:25:31.9631 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 458e3c5a-bbc3-4cee-dcaf-08df1a60d609
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018546.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7738
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



On 2026-09-17 06:42, Simon Polack wrote:
> [Some people who received this message don't often get email from spolack+git@mailbox.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> [Why]
> mod_power_remove_stream() shifts the remaining power_entity slots down
> but does not move replay_events, and mod_power_add_stream() does not
> initialize it. replay_events therefore stay bound to the map slot
> instead of the stream.
> 
> When several streams are disabled in one atomic commit,
> amdgpu_dm_mod_power_update_streams() removes them one after another.
> The eDP stream can then be looked up in a slot whose stale
> replay_events already have replay_event_hw_programming set, so
> amdgpu_dm_replay_set_event() returns early ("already in desired state")
> without calling mod_power_set_replay_event(). Replay is not disabled
> before the eDP panel is powered off. After DPMS on, the sink reports
> neither replay state nor frame lock (DPCD 0x378 = 0x00, no error bits),
> so the HPD IRQ recovery does not trigger and the panel stays black
> until a full modeset.
> 
> Seen with an eDP panel using FreeSync Replay plus two DP-MST displays:
> DPMS off/on of all outputs leaves eDP black, while DPMS of eDP alone
> works. Doing an eDP-only DPMS first makes the next all-output DPMS
> fail reliably.
> 
> [How]
> Shift replay_events together with the PSR cached fields in
> mod_power_remove_stream() and initialize it to replay_event_vsync in
> mod_power_add_stream(), matching the psr_event_vsync initial value used
> for PSR (both vsync events are driven together by
> amdgpu_dm_crtc_set_static_screen_optimze()).
> 
> Tested on 7.3.0-rc3 (238650ef6c7c): the reproducer above now recovers
> reliably, and Replay still engages when the screen is idle.
> 
> The issue was debugged with help from an AI assistant (Claude), which
> analysed ftrace/kprobe traces and the driver source, pointed to the
> missing replay_events handling and suggested this change. I collected
> the traces and built and tested the fix on the affected hardware.
> 
> Fixes: 4cef2ac4c795 ("drm/amd/display: Introduce power module on Linux")
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Simon Polack <spolack+git@mailbox.org>

Reviewed-by: Leo Li <sunpeng.li@amd.com>

Thanks!
> ---
> Based on v7.3-rc3 (238650ef6c7c), where it was tested; also applies to
> amd-staging-drm-next.
> 
> This does not address why stale replay_events can reach the eDP slot
> with replay_event_hw_programming already set in the first place; with
> per-stream bookkeeping that state is consistent again. Traces
> (kprobes/fprobes on the Replay path, eDP-only vs. all-output DPMS) and
> DPCD dumps are available on request.
> 
>  drivers/gpu/drm/amd/display/modules/power/power.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/modules/power/power.c b/drivers/gpu/drm/amd/display/modules/power/power.c
> index 2f9690e65ca9..d900be8cb5fc 100644
> --- a/drivers/gpu/drm/amd/display/modules/power/power.c
> +++ b/drivers/gpu/drm/amd/display/modules/power/power.c
> @@ -328,6 +328,7 @@ bool mod_power_add_stream(struct mod_power *mod_power,
>                 core_power->map[core_power->num_entities].psr_enabled = 0;
>                 core_power->map[core_power->num_entities].psr_events = psr_event_vsync;
>                 core_power->map[core_power->num_entities].psr_power_opt = 0;
> +               core_power->map[core_power->num_entities].replay_events = replay_event_vsync;
>                 core_power->num_entities++;
>                 return true;
>         }
> @@ -387,6 +388,7 @@ bool mod_power_remove_stream(struct mod_power *mod_power,
>                 core_power->map[i].psr_enabled = core_power->map[i + 1].psr_enabled;
>                 core_power->map[i].psr_events = core_power->map[i + 1].psr_events;
>                 core_power->map[i].psr_power_opt = core_power->map[i + 1].psr_power_opt;
> +               core_power->map[i].replay_events = core_power->map[i + 1].replay_events;
> 
>                 memcpy(core_power->map[i].psr_context, core_power->map[i + 1].psr_context, sizeof(struct mod_power_psr_context));
>                 memset(core_power->map[i + 1].psr_context, 0, sizeof(struct mod_power_psr_context));
> 
> base-commit: 238650ef6c7c7cca08e032527329424c9fbd70e5
> --
> 2.55.0

