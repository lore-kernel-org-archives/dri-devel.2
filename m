Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0562C606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 09:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4gkxC1kB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BCF110E5D1;
	Wed,  4 Nov 2026 09:31:26 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010025.outbound.protection.outlook.com [52.101.46.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 437B910E34A;
 Wed,  4 Nov 2026 09:31:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YUKTi3U48b/9FgMFWaOasVWRupO+v4t80uTKybW2wnw0c6//rwOEWXw4gmxDpCuRbpfPHAlBKOn9FLbOBAFkDo/t9YhDEb1YQHi4LqAx5czBHpbIsaWx/9j9/M9lKecLzq2Pv/d8VLyZmOD8Nya/G5TUmPrw7Iu4ofQfni3R0lmGe8oNHarEU/GBrlh2XlND7NxLLgDBTWmIZ6HRDE2bNze+3m9CpvFR+012aUQCsw3CpJdf5eS/ZDd53w7pphR/YJI3fT+skShwnmcS8T4I/Mg+t9o82HaRDRrbNe8gXY/L2Ssv1BP8fFPFWh3gf+4UamQm6hfn2GSxm1psxQx4LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVf955T5phSZ8jA9I3XDgsNPQGBLbJKyj9T8ESNfbYc=;
 b=Rl6PlaqXMvbExt3riSGloiJC3tKCIFndA0TyhAli9cabMAyW4QNVwvlSaB/HWyDpvKI19o6NdWExgyHBIIJeS9nZvYSWd1JQu+Z9rTUmR9FWQ+lZeQ+j/nuG09KdDaaVWKt9JlfOnxccENxOCEUOtTJexJ8T0tzMxS3ns22ICGDOXMJtY3y+euq3wDJ0AzXTs1rSoWuWuHQ0MF2vg1oDSpgRZih5b0elWKFDNHLarJMLzk9LHfXe0xpK/dRcixVgTYWREsnfl/U0fF6Rv4hhGs1N9XweZWvPskgjg83m+M9cs42fleVjxckJrWZnd3KH8K6DLdLV97tW1U85EvWP4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVf955T5phSZ8jA9I3XDgsNPQGBLbJKyj9T8ESNfbYc=;
 b=4gkxC1kBj6mZDiAvsBPk3Q3Mc2veJqcv/EsSzxiWsbdTRdxBcvlqSzeQewC9k3Xu5UO5r6M4g2lyfeYZUwPHOJbtcMk+ja7+ImVZP1XnTmyGJt9ryQJRijtxAZUAT5v5+z5mrCy8W25L7cljc4Mruz1taFcYw9xuDmPO0DTx2a8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CHAPR12MB999225.namprd12.prod.outlook.com
 (2603:10b6:610:2fe::11) by DS2PR12MB9639.namprd12.prod.outlook.com
 (2603:10b6:8:27a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 09:31:16 +0000
Received: from CHAPR12MB999225.namprd12.prod.outlook.com
 ([fe80::a4c2:82c3:da88:c585]) by CHAPR12MB999225.namprd12.prod.outlook.com
 ([fe80::a4c2:82c3:da88:c585%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 09:31:15 +0000
Message-ID: <3f79f22f-a8e9-4fd4-ab78-2403d38b1292@amd.com>
Date: Wed, 4 Nov 2026 17:31:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Don't require DMUB PSR caps before DCN
 3.0
To: Hugo Sales <hugo@hsal.es>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Chenyu Chen <chen-yu.chen@amd.com>, Alex Hung <alex.hung@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261029171219.2842014-1-hugo@hsal.es>
Content-Language: en-US
From: Ray Wu <ray.wu@amd.com>
In-Reply-To: <20261029171219.2842014-1-hugo@hsal.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0036.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:7::8)
 To CHAPR12MB999225.namprd12.prod.outlook.com
 (2603:10b6:610:2fe::11)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHAPR12MB999225:EE_|DS2PR12MB9639:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d6c9672-ab69-46a5-1c9c-08df3a565f6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|261028144727099003|261026121527099003|261026140227099003|261009223027099003|261022075727099003|261022105027099003|261102123227099003|261021123027099003|261021121427099003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: R217E85dKG8C8LwSOiJEmY9hqZMIcE04UOurLamK4k1DwB3Z5WbAZ9E6bWv08GVhJzSMUCdlYumYk2Kg16u5vrt04YZ7Wx/QLgC9zHXvupjA7DmeLx8eQ5FIPGSbH6Zt2b4n78R6G/sI+8Ro7aH0VmAxDns3PX5X3wmyg9ZwnpSf/6gwT234BriWZ9koSvMbegSWfwsjPfYOzYDd/LdIMNR6ZciClhX+8rrZC4Ex6ERlnXkYffzalZ6EFq0VhEkpK2ZuZF+V7txy7wFBa3FPtnpNsozO3Zt4jHrillVc9BxuMaVIIZdVYEMyVAa1WXFNZv9oLFXLL5gfVyfSKOV6zHRSe4FQ5dp68majdnwQEFl6GpfSYJP/kvJukESIMPmOFU5qpCQWJrGrn/nPG/pSvnc7OQ4ZbqbRRjhNLJcNnAio757OBsLI65PN31KwFx3B3j7p8VPfosEb9HDbba83xoRFwzaozOVLPKDnhhOq7vdx1wycRFWEED8a8H0gK9S1OXr21w/FbkNX4G7W3slQ0HRxLgfQc/OE+khUg7ewAFxDAwdcNa+IXx7H7sIc2h2aFlCgEzXXi891B0czz+9rjzIC1fZcFyO72k+jmdiTW0pFzl/abzDLfPx5OnRypd3b
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHAPR12MB999225.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261028144727099003)(261026121527099003)(261026140227099003)(261009223027099003)(261022075727099003)(261022105027099003)(261102123227099003)(261021123027099003)(261021121427099003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjBKUlp5UFpmczFxcmdUL1ZoY1NUcVZ2elh2dW8zUXcxcnJvMCtQekF0eE1H?=
 =?utf-8?B?TFJDUWp4YnlaTVAvWi84YnQ5Tlo0cnBDempnWE9PWVl6RVRaK0Q2M1lWWFFq?=
 =?utf-8?B?dWh2WTFONEhHWjM3Ti9pVlhvbFQvWWU1M2s3bTlSMEtBVmxpcHBpSDBZei9O?=
 =?utf-8?B?aHFBdjEyZHRPbHJnaHpQUGFhNC9TekpycHMzRGNzT2JvOW5MdjlJT0VYQzdL?=
 =?utf-8?B?S253LzBsdWhLNGNxTk11d2R1Tk9kaUFtbU0zb1U3aWlVMDVoYWlNaFk4dm5r?=
 =?utf-8?B?VXhaZUNxWmpQdnRtdEFRekE0TUN4TXZ1MWFxbXJvaWh4eGxGdkFaUjEzV1NS?=
 =?utf-8?B?L2psSEVGS1E2L25vcjFaL2ZSOFl0UWNOVVY0TXNza1kzUW1OS2xoamU0YVNT?=
 =?utf-8?B?S1RBTDVJcXlYZ2phTDR3VnVqc0hyeGpYNFVOZXhuN29qYlcrQ0pZbkh3cHd2?=
 =?utf-8?B?eFpPN0E0L1ptdFhRejV0L0tsVnNNZW9kMUx2OWVkbStOM1owZzZpdHVQK3Zj?=
 =?utf-8?B?V2RobURlK0ErMEt2cFVyMlpNTUNNczN4NEtXbGNpYWNLYnN3Rzdab3BkNEdt?=
 =?utf-8?B?WThBaXFJMlgwUi9heFZJeGxEbnI3UVlrcm1wTDRoOWF0TStXTm0veU9FaGtm?=
 =?utf-8?B?TUxzTmNvTTEybXpUcTUrRzlRVHB2M20vZlNwN1hicXVXaDNCWEt1RDhSY3Fu?=
 =?utf-8?B?b1pOM1NCYnYyU2JmYVRVeWtNUk9Xekd3RWhZSjJBMnlSWXNLZlpkOHl6MUtK?=
 =?utf-8?B?QVhzeWxiUmFpeWxoZDExYUVzK3FobnpwQy9UcU5zNDJ0MEUrRVowYjUzRHky?=
 =?utf-8?B?NityelFDRklrZmdCVzlwT29IWXVsNmdkZzBiMGYydnVqN0dXaVFWQ1dGM2dD?=
 =?utf-8?B?RnFrS3BFS09hc0FkWElDT2w5T3lFNTJpaUpXRWN3UjUwaitvQWNrb1ZaR09G?=
 =?utf-8?B?VWo0ZFpROWFRSFFUNlhnajkyRHgwMVJuVWlHWCtlaHRWK005UFQ1S1ZuUlQx?=
 =?utf-8?B?SXNWcHJRNzdYdHdsQjJlcXFENXI0U2txcC9YV29IOHFWc1JrOXhvRXlGKzNP?=
 =?utf-8?B?YkltdEs4aFlPWkFWT1BPWVZheHpzSUozU0owYTVRd05IWTU4Z0s4c2Y0eE0z?=
 =?utf-8?B?eHRQS0pWaUoybUo5NHlnbEpGWnJoVDhCSTVrSk9hSWMwaWswanB4QjlNL1dM?=
 =?utf-8?B?RUxOTHpvYTNTOUpvaFJMcUJmVHJXRzZGdjRoSzhvOGxQZDhLWlpFS2xnYkFV?=
 =?utf-8?B?czU4OEdjTFRUdERycWhUWmUwNkhBcnRiV2VrbGIzbm5xQUlFQ0hhTnVBRjcw?=
 =?utf-8?B?amFtVEVMZU54TWJtVkxycGF1cUF2VGh3U0N4UnFnbkY5aFFUWnVieTlUVHM4?=
 =?utf-8?B?dVpIRi9zSUpBVjBxZGltWGhIcHB0aEpHS2JhbVV0aWd4MHFLSEh1UTJvdk8x?=
 =?utf-8?B?UklTT2RJVC9KOTRaOVkyNmFiVHpXYS91RDI3L2dSRXRMUmJNTytEMjJOUFNi?=
 =?utf-8?B?UmhCUkxhREdPa01FcXA0QUtJdkt5YTNtd2JqdXdIOHE5enRXMGhXYkZaT3RR?=
 =?utf-8?B?amoxcmpvK1o2WGZIWXk5RzU2OEsyakhwRmUxdXhHR2hDSS9NSE44cjV5S0pw?=
 =?utf-8?B?QzZlSHpiRXdkNXZDbkhMbFIyTWR4S3BJZVRtUlFYUkpYS2U5TEJVaHNvRUI0?=
 =?utf-8?B?NWJ6NWVBQnhBV2t6R3pHRFIwS25qeUxJaTZrekw4VXkrRENpMVIrSWdQa1d0?=
 =?utf-8?B?RElLWmQydFFrWXhSanVxYVBIdEszMTdQa01hKzdEWWJkODVXV3hLbnc2TndW?=
 =?utf-8?B?R1hjZFZDbWdkSGU4VVV4OU1rQ3AwQyt2b2xGQkYwM3hESVh4Zys3QlR4Qzk5?=
 =?utf-8?B?YTV1NjJEVmdUbk9mV2dKUlNlYkhXa1BRUW1FZFpsanQ5Y1I2RTlZRGluSlpO?=
 =?utf-8?B?d3gzeUJXU2pnTnZNb1Q3R1dvSjdFWkZLUE1qcjBsQjA4VDZLdnFPRE1VZVlp?=
 =?utf-8?B?cVFCVTZCRll2MUhqNE9tV0hhT3pBcnJEN25YazNNZ2EwUXhOWEEzK2Rqelda?=
 =?utf-8?B?aVA2NnpwaFdZakwzZ1drWU0zUE1CY29jRjBKRHZ1akc1dzdpRVBaU3MvYm9M?=
 =?utf-8?B?L2NWajlCeGptcnNzUWRyNmlaeVZJQW5IN3N6SEtkZHhWOUNlNDl4R3dXTVg2?=
 =?utf-8?B?a20zQUtrMXBTWE5pM1FzUDRjclZQdWpqaDg2UndFVmt4ZmJPS0QxTytIM2VK?=
 =?utf-8?B?citkdkhKSUVoMnord0tuTk4vU1p4bUZsQUlKYzVjdmZxNEo0cHpWWjBjMzJ4?=
 =?utf-8?B?UWprQUQ0R25VMUJHbENoNmJWZmNFUWUwRGphYnV3TThCNCt3UCtQQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6c9672-ab69-46a5-1c9c-08df3a565f6d
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999225.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 09:31:15.5151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tPa0TV8j5IV5v/eKsYGcO9AneetV+GjkxcavqaVO6L6cyUt/UGcyAJv1QhA/v/jjjcob0ARlsrZEGSTWFBnr7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9639
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

We already have a similar fix internally that is planned for an upcoming DC release:

commit: drm/amd/display: Allow DC_PSR_MASK to enable PSR without DMUB PSR cap

Could you give it a try and see if it resolves the issue?

Thanks,
Ray


On 10/30/2026 1:12 AM, Hugo Sales wrote:
> Commit 3c108046e1d6 ("drm/amd/display: Add power module on Linux") made
> amdgpu_dm_set_psr_caps() return false unless dc->caps.dmub_caps.psr is
> set. DC fills dmub_caps from dc_dmub_srv_query_caps_cmd(), which only
> the DCN 3.0 and later hwseq init calls. On DCN 2.x the flag stays false,
> so DC_PSR_MASK in amdgpu.dcfeaturemask, the documented way to turn PSR
> on there, no longer does anything
>
> On a Cezanne laptop (DCN 2.1, DMUB firmware 0x0101002B) with
> amdgpu.dcfeaturemask=0xa, dmesg shows
> "eDP-1: PSR support 0, DC PSR ver -1, sink PSR ver 1 DPCD caps 0x0",
> although DC created a dmub_psr for the ASIC
>
> Sending the caps query on DCN 2.1 too doesn't help. That firmware
> answers it without error but reports psr as 0, and with the check
> skipped it runs PSR 1 fine: psr_state reaches 6 on an idle screen
>
> Keep the check only from DCN 3.0 on, where every ASIC with a DMUB PSR
> engine queries the caps. DCN 3.01 skips the query, but it has no PSR
> engine either. Before that commit no ASIC needed dmub_caps.psr.
> edp_setup_psr() already returns false when the ASIC has neither a DMCU
> nor a DMUB PSR engine
>
> This needs "drm/amd/display: Take every stream out of self-refresh
> before a modeset" first. Without it, turning off or unplugging an
> external display while the eDP is in PSR hangs DMUB on DCN 2.1
>
> Fixes: 3c108046e1d6 ("drm/amd/display: Add power module on Linux")
> Signed-off-by: Hugo Sales <hugo@hsal.es>
> ---
> Depends on:
>
>    https://lore.kernel.org/r/20261029165420.2255749-1-hugo@hsal.es
>
> Firmware 0x0101002B answers QUERY_FEATURE_CAPS with psr = 0 but still
> runs PSR 1 without trouble. Is that field just not filled in by the DCN
> 2.1 firmware, and is there a version from which it can be trusted? If
> so, I can check the caps there as well
>
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |  8 ++++-
>   .../amdgpu_dm/tests/amdgpu_dm_psr_test.c      | 35 +++++++++++++++++++
>   2 files changed, 42 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
> index dbad0a6d3a2b4..be95433624674 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
> @@ -111,7 +111,13 @@ bool amdgpu_dm_set_psr_caps(struct dc_link *link, struct amdgpu_dm_connector *ac
>   	/* Reset psr version first */
>   	link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
>   
> -	if (!dc->caps.dmub_caps.psr)
> +	/*
> +	 * Only DCN 3.0 and later ASICs with a DMUB PSR engine query the DMUB
> +	 * feature caps. Older ASICs drive PSR through DMCU or DMUB without
> +	 * that query, and edp_setup_psr() already bails out when neither
> +	 * engine exists
> +	 */
> +	if (dc->ctx->dce_version >= DCN_VERSION_3_0 && !dc->caps.dmub_caps.psr)
>   		return false;
>   
>   	if (!(link->connector_signal & SIGNAL_TYPE_EDP))
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_psr_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_psr_test.c
> index 0a484ea7c0e8e..4d23b1234921c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_psr_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_psr_test.c
> @@ -239,6 +239,39 @@ static void dm_test_set_psr_caps_no_dmub_psr(struct kunit *test)
>   			DC_PSR_VERSION_UNSUPPORTED);
>   }
>   
> +/**
> + * dm_test_set_psr_caps_pre_dcn30() - DMUB caps are not required before DCN 3.0.
> + * @test: KUnit test context.
> + */
> +static void dm_test_set_psr_caps_pre_dcn30(struct kunit *test)
> +{
> +	struct dc_link *link = alloc_test_psr_caps_link(test);
> +	struct amdgpu_dm_connector *aconnector = alloc_test_aconnector(test);
> +
> +	link->ctx->dce_version = DCN_VERSION_2_1;
> +	link->ctx->dc->caps.dmub_caps.psr = false;
> +
> +	KUNIT_EXPECT_TRUE(test, amdgpu_dm_set_psr_caps(link, aconnector));
> +	KUNIT_EXPECT_EQ(test, link->psr_settings.psr_version, DC_PSR_VERSION_1);
> +}
> +
> +/**
> + * dm_test_set_psr_caps_dcn30_no_dmub_psr() - DCN 3.0 requires DMUB caps.
> + * @test: KUnit test context.
> + */
> +static void dm_test_set_psr_caps_dcn30_no_dmub_psr(struct kunit *test)
> +{
> +	struct dc_link *link = alloc_test_psr_caps_link(test);
> +	struct amdgpu_dm_connector *aconnector = alloc_test_aconnector(test);
> +
> +	link->ctx->dce_version = DCN_VERSION_3_0;
> +	link->ctx->dc->caps.dmub_caps.psr = false;
> +
> +	KUNIT_EXPECT_FALSE(test, amdgpu_dm_set_psr_caps(link, aconnector));
> +	KUNIT_EXPECT_EQ(test, link->psr_settings.psr_version,
> +			DC_PSR_VERSION_UNSUPPORTED);
> +}
> +
>   /**
>    * dm_test_set_psr_caps_non_edp() - Only eDP links can enable PSR.
>    * @test: KUnit test context.
> @@ -712,6 +745,8 @@ static struct kunit_case dm_psr_test_cases[] = {
>   	KUNIT_CASE(dm_test_set_psr_caps_null_link),
>   	KUNIT_CASE(dm_test_set_psr_caps_null_connector),
>   	KUNIT_CASE(dm_test_set_psr_caps_no_dmub_psr),
> +	KUNIT_CASE(dm_test_set_psr_caps_pre_dcn30),
> +	KUNIT_CASE(dm_test_set_psr_caps_dcn30_no_dmub_psr),
>   	KUNIT_CASE(dm_test_set_psr_caps_non_edp),
>   	KUNIT_CASE(dm_test_set_psr_caps_disconnected),
>   	KUNIT_CASE(dm_test_set_psr_caps_no_dpcd_psr),
>
> base-commit: ba496bb837882eb1af58f41572fc289e46c77b8c
> prerequisite-message-id: <20261029165420.2255749-1-hugo@hsal.es>
