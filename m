Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5816606A32C
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 11:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=h+9MEZBB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0F1210E306;
	Fri,  6 Nov 2026 11:29:46 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011046.outbound.protection.outlook.com
 [40.93.194.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 468E410E49E;
 Fri,  6 Nov 2026 11:29:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LVorNOAX3ha9EM4T493U4Ux2Ly07SEEJoOuNJ9Z3D2H2CRPOnhr6voC4v46TX3987m5cQT4QWCnndnk/ySrac0dB38K90IbhO6zp/QrHLfwA08G88Z85uaLKBX7NTw7zStIRfd0fjbjVeO0g2/aMIbTa7HtUzGNJD7oL6ZbPRsTUfm7iVa+HhNarZWzSayF6ZrSccEYLCEYOXDDajwh6LQD7uQNcy5JYNJdu2n1fd0YwebxfmY3gE551qbIKNZhzzJapO8xgQbr9exxBzHe6CONCCnU/EETCpvTis2ONXdUdotDrT5dRiJ3gBdPd6CT3DR1RtRolbX3qreQ3xS51qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9UXl/kTvvZA91WTgQdTTTs6+/hxYzsJR7vRHLbNU4g=;
 b=vqum5/QQIbdpFZOoqpTiyaNeNd+0WJH291nlCU81sBcJ8VFTREiHAzZEVoJkwnYO1ayzz+KJnXjetWPiYYE+f42y466W1stdw0r+ugwURX0RgeSIqZpjssUcV0Nr6mBxybJ6B9D4WzT1u4NhiRHQQGg8ufD2qnBqFcyJ8UhbzHhls5GXDU5jokPKP/SP2FkYnKzE6oNSJni9rzQWHYBvhUlMIlsF6AtVM3WACaqZtbyJz5331JkjhokO8o0ZscUfuBrLhz8Q9hvWn0pAjJEFzH6dyJw+YRJAYg//Q2ataJTAeQv2CD3tsH/ZR4SkV+EjG0XIpK3fEkHI5Tjvo0VxAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9UXl/kTvvZA91WTgQdTTTs6+/hxYzsJR7vRHLbNU4g=;
 b=h+9MEZBB/1637bwnxHgrxK/Q+1Y+cYP9lZSYPQ29nTuCax7Hnu92A9TU6cnJiVGZTPbcgDjdWLX28uE3BdIVwBqpgsp7pU8gZQjo3XD5Vi43XpTp/8hAX09GvH8peBQlBIWEjjEOxoAt03FXPjGcjpuYDf1XVEWyMTlaHMIJvNI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6132.namprd12.prod.outlook.com (2603:10b6:930:24::8)
 by PH0PR12MB7792.namprd12.prod.outlook.com (2603:10b6:510:281::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 11:29:35 +0000
Received: from CY5PR12MB6132.namprd12.prod.outlook.com
 ([fe80::d9ab:4258:a9ef:b8cd]) by CY5PR12MB6132.namprd12.prod.outlook.com
 ([fe80::d9ab:4258:a9ef:b8cd%6]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 11:29:34 +0000
Message-ID: <82f96eef-bcfd-49e9-a222-be12a45645c6@amd.com>
Date: Fri, 6 Nov 2026 19:29:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Leave self-refresh before an ABM level
 update
To: Hugo Sales <hugo@hsal.es>, harry.wentland@amd.com, sunpeng.li@amd.com,
 siqueira@igalia.com, alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
Cc: ray.wu@amd.com, Roman.Li@amd.com, nicholas.kazlauskas@amd.com,
 alex.hung@amd.com, bhawanpreet.lakha@amd.com, ivan.lipski@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261031130002.2335615-1-hugo@hsal.es>
Content-Language: en-US
From: "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>
In-Reply-To: <20261031130002.2335615-1-hugo@hsal.es>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0038.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::11) To CY5PR12MB6132.namprd12.prod.outlook.com
 (2603:10b6:930:24::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6132:EE_|PH0PR12MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: d4ecd36e-c721-47cc-66fb-08df3bf93b3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|11063799006|56012099006|261022105027099003|261022075727099003|261021121427099003|261009223027099003|261102123227099003|261026140227099003|261026121527099003|261028144727099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: sWiXab0xbI3qCxwU8fsTjnEPZ5GL3UPrrJk3BhSH8stJeLb6OOlBZzIgazSGw/tgkLmarkg4yPENd6zNRAhUmHifjn31+v6jTHttEWUDfH9nAZHVWO6yUHcqV+yOZgRJXU78IEi5/hXqBa3E13N1q+Vo67lwRzkeCOJrfYsSAqDYFOhHnK1QKVU9QkWPQ0lMe35ZBOTo9qBakTficzVcwEQqN5jfB3FqKOCj6eLsdf/JpzcDbFjDYxKYcFgzifEPnStHdbLdaadilek/YMw11XZoY594Z/SitqFgzrHnH9fkOYF9k1F95E8m0Hhy+ex/3NRpSfqq+gsPrg3dGLv+laFY7aLxUvBauDQilGAPMWJjE3nJFlkzZLBuKq9c25VjrqW5mgaplsdDq5D49v9jBa+pWFYrLltFToOCIYMSl0WkvR5fcyP1i4lI8zrli4Hq3orUtiNEkPaHoaOBxWINejElJuZLAvCE321dXGYhgwLaeIwQQvq8CzgiJatA1gZ6AuZEUXVi1HIlieNS+tRoKZF4BUucnpFJau3RlsHYQB0jSj8IH5IC7vhHw6RTunD8EPJzjWooWu2svsfaX19yjNfYpy5O3WiUCaLPLZH4+WuGApKJRS97GC1G8zGa5o1Q
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6132.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261021121427099003)(261009223027099003)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rkp5MDE0M3dJVmhXZzlHdDZFa0lzQ2d4NEdGdXBtNThJVWVtMk1TTWt2anFo?=
 =?utf-8?B?QVlJUGxDdlpGWTdYdStmaXhXV29JYXAzWHoxN3dLVytzT201TmhaOWcwZkN4?=
 =?utf-8?B?ZnRqQ05vemhkeWlHNFJlY0lvalNZT1Azd3Nzb3ZQaEp0Y1R5MHpYV0dldjVJ?=
 =?utf-8?B?VTVFRVZQUE93d1FleVpBRi82V3IwT3lHSElaWHhhbmNHWGV4YmxGZm1QSGNq?=
 =?utf-8?B?Zis1WDhJTHNYWlk4MHVRbkxlc2NxVVc2UEhwa1ZOczJQM0JtTUdHODVpTnZT?=
 =?utf-8?B?a01PU1k1aG5jZmsvRFdyZzhwbmZWNXAvVzRPQnF6cllZZGlnaHozUUZsOUFk?=
 =?utf-8?B?Vm9BNEk5eGpxZU1mSW1CTFphSzhOOWlBK0pQZmNJOC9lcUdpV3d3VTB2d0xh?=
 =?utf-8?B?R1N0QnppT2p1Zm0vNGdxZlRrRmVXeU1CRzlvL0VwajVWM3VhUXR1aERuakl5?=
 =?utf-8?B?MHVnNXBLOTUxNzl1YjJZbHRqNlNKTlFKZTE1L3BzdlZCeDVsYzZqb2RGNEVM?=
 =?utf-8?B?ZVprMzhnaUtuYS80QmQ5TDZKcFZlanFQZWdKdm9RS3NWaWhoczgwZUVkMlp4?=
 =?utf-8?B?LzJwK01Danpud2NPUlJkd0xDbWtEOUUwNjBSRkNtVHZFelpKbUN2d3hIcDJP?=
 =?utf-8?B?cVZ1SHRWYXdXQ0poaUJJZGVRK3VGOEd2cUVBSHJZTWp3S0Q5R2NKOS9JdktU?=
 =?utf-8?B?V2grTzRuTDNzRmsvM3VocC9XYytjMDZmWjdOMURsMlZPbkY5ZWFwUzhZc29Y?=
 =?utf-8?B?UEZteVpWcWhNRkdmaVVJYnV5U25XMEU3ZFgwNkdIWFJIQWFRb2cxTTNyS28x?=
 =?utf-8?B?RG5tb0RCekNBNmUwZ0dWQ0VjNS9BZzhhUHkwQ2NSMzFYWTBkNGRrc05qdmlN?=
 =?utf-8?B?dU04bkhyODZkZXkxSnQrR2tGUlpEZmhzRzNDU1NXeThqU05TRGc0UHcxTDdz?=
 =?utf-8?B?akpzbzYzQkVzaitzTG4zOUdDK0wzU1cwRDVMbXRhR002WEdZdmlzL1EydzRW?=
 =?utf-8?B?c1VLTk5RRjVxY1kzL1phZW5MVEluWFVZY2pUa1Q5eHdENHNSb1J0NmQyMXJs?=
 =?utf-8?B?TnpQRTBrbDlTeGlFWWduZU0wcDlDa3JKVFA4cUJubjd2cmswcHJzSVFERmgx?=
 =?utf-8?B?d3QwcDYrL01LR0t3S2hDcWxnNDVHTy81alkvbE9EYmJoUjlhRGpPMnNyVW1H?=
 =?utf-8?B?UWFsaUtXMXZHYk0wOXEwQnArUEM1YzVMcnBaY29VWm1UczcvazNLcVpNVUQ5?=
 =?utf-8?B?ZEdVSTcraFk3Tnhaam9IWWxjT1FhUGt6by9GZE5GUjBVM2puUlRmWXdoQ0dW?=
 =?utf-8?B?SHpUZFpNMnNJek5CU0U4NFh5MGFoMmYzeWovaWdBZnJ5cHplVEg3RHVkVVF5?=
 =?utf-8?B?OGNGWXJlYU8zeCtNOGJlNkMxbnVMd0JMbDRjTmtxUklQdWsxakRWV2pLem5s?=
 =?utf-8?B?MzVrNEczUGxqQmpTU1pjMjVGWEErRXFjUGYvMlk2Mkw2Wnc1VFE3Z3lXMWVp?=
 =?utf-8?B?eDl4RFdRUUVZeTdSL1l2NVdkcGJxMGttYUV2TlU5YWprOXdBc0w1VkdBVTNL?=
 =?utf-8?B?MnJlSGpRcjEySUUyc3FYVnRmckE5Q0J6eEovMGQ0dFBLL1pvb085QlJNTlJr?=
 =?utf-8?B?bjhMU3NqQ2pZN3F6YUFFbnFTOTR4czcwVDM3bjc5STFmWnI2NlBmenpKWWln?=
 =?utf-8?B?VGxFd2QyWDRpbnNrSFJuN0JhaTY4ZXhyVWpkaEhDTXU5NXNaZTRRaDhMc2w2?=
 =?utf-8?B?bmVlWlRNZlJsYjB2UlRCVUljUWFjbHd6d2t2Q28zMnQ2aVRtVTZ0YlJoQThX?=
 =?utf-8?B?ejVwTkYrZDRRYkpZTHZLaFFDSWxvdW5UbHJXZmpFem14STR0SlVKcHdncTZE?=
 =?utf-8?B?RndSWGZGWEUwenFaaDhjcVU1cTVHK2RKRldQS2NxRFJ2dEZjZ2hEbFA1K2JJ?=
 =?utf-8?B?cEs2MGMyMEdBUkdYeDZqdHpzRTA1RVdJNmE2NGdXRmVXb0FhbmxjRGxRTHRj?=
 =?utf-8?B?S1JYRHBOdE1qRnlCdE5hVlVIdzZQQUhYSVlwNGZ4WVlaN3FYNktYeDkraEIx?=
 =?utf-8?B?T09xZDU5VkxZRllsd2ZibjJXQnN6UHJoUTBMOVFmV2xac1ZoOUc4QkJZQllr?=
 =?utf-8?B?SDh6T3l3bkFGVDNUckZCdTJweVJ5UktJbjBhQk1wNWRjUkp4dnJodFUySWxE?=
 =?utf-8?B?bk13SDNOeGVrT1c5VWlML3VwTDRuK0o2c1hBRVo5S0srYjdDcXcyZUVtNm80?=
 =?utf-8?B?VlYvR3ZqQ01uMTZ6RXFsNzlrS0Q1Z1NKZlkwbWJKSTBLZjl3UEkzcnFqdkJ1?=
 =?utf-8?Q?Dd0jxGdPdQxSyrKEMT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ecd36e-c721-47cc-66fb-08df3bf93b3c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6132.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 11:29:34.0836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pr/qJpDHR68YorZG57mtMO/2lfuSfwHq81ekTKq395qHZeAxHZNRYbbKKzFait/135TXnY+SAbiEydSjQbsu/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7792
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



On 10/31/2026 9:00 PM, Hugo Sales wrote:
> Writing panel_power_savings while the eDP is in PSR hangs DMUB on a
> Cezanne laptop (DCN 2.1)

Hi Hugo,

Thanks for the patch. We've seen the same DMCUB hang on Renoir
(DCN 2.1) when an ABM level is sent with PSR still active, so taking
the panel out of self-refresh before the update is needed.

> 
> An abm_level change on its own is a fast update, so the commit skips
> amdgpu_dm_commit_streams() and the self-refresh pause in it. The ABM
> level then reaches DMUB through amdgpu_dm_commit_planes(), or through the
> connector update loop in amdgpu_dm_atomic_commit_tail(), with the panel
> still in self-refresh
> 
> Raise the PSR and Replay hw_programming events before both updates. As
> with a backlight change, the events stay set until the next plane commit
> clears them in amdgpu_dm_enable_self_refresh()

The problem is leaving them set. amdgpu_dm_enable_self_refresh() only
clears hw_programming on a later fast update. A panel_power_savings
write on an idle desktop isn't followed by any commit, so PSR stays off
until the compositor commits for an unrelated reason. That costs PSR
residency on every ASIC that uses these events, not only DCN 2.1.

I reproduced this on Strix (DCN 3.5) with this patch and 177461: after
a write on an idle desktop, PSR didn't come back until an unrelated
commit. With the events cleared right after the DC update, PSR came
back by itself.
Could you clear the events right after the update, still under
dc_lock? Something like:
	update_planes_and_stream_adapter(dm->dc, ...);
	if (bundle->stream_update.abm_level) {
		amdgpu_dm_psr_set_event(dm, acrtc_state->stream, false,
			psr_event_hw_programming, false);
		amdgpu_dm_replay_set_event(dm, acrtc_state->stream, false,
			replay_event_hw_programming, false);
	}
and the same after dc_update_planes_and_stream() in the connector loop
of amdgpu_dm_atomic_commit_tail() when abm_changed.

Since only DCN 2.1 shows the hang, could you rerun your steps on the
GV301QH with that change? The case I'd most like confirmed is PSR
re-entering while the ABM ramp is still running, for example 0 to 4
and then leaving the screen idle.

Also, 177461 2/5 stops forcing the modeset for property changes, which
sends those down the same fast path. This patch needs to land before
2/5, so it would help to say so in 2/5, or to carry both in one series.

Regards,
Chenyu

> 
> Fixes: 8c322309e48e ("drm/amd/display: Enable PSR")
> Signed-off-by: Hugo Sales <hugo@hsal.es>
> ---
> Tested on an ASUS ROG Flow X13 (GV301QH, Cezanne, DCN 2.1, PSR1 eDP)
> with PSR turned on through amdgpu.dcfeaturemask=0xa and "drm/amd/display:
> Don't require DMUB PSR caps before DCN 3.0" [1], which DCN 2.1 needs for
> PSR to come up at all, but, as far as I can tell, the same bug would
> manifest on other DMUB versions that use PSR and ABM
> 
> On 7.3 without this patch, writing 3 to panel_power_savings while
> psr_state reads 6 makes DMUB fail within a second. The log fills with
> "DMCUB error - collecting diagnostic data" and the panel shows vertical
> lines. amdgpu doesn't attempt a GPU reset, and the errors go on until a
> reboot
> 
> With the fix, I let psr_state reach 6 before each of these steps:
> 
> - turn ABM on, from level 0 to 3
> - change the level, from 4 to 1
> - turn ABM off, from 1 to 0, which takes the immediate disable path
> - switch power-profiles-daemon to balanced and back to power-saver,
>   which sets a new level each time
> 
> None of them logged a DMCUB error. Both kernels had [2] applied as well
> 
> Commit 8c322309e48e ("drm/amd/display: Enable PSR") only paused PSR for
> full updates. The power module events used here came with commit
> 3c108046e1d6 ("drm/amd/display: Add power module on Linux"), so a
> backport before that needs another way to leave PSR
> 
> An HDR static metadata change while HDR stays on is a fast update too,
> and the connector loop sends the new infopacket with the panel in
> self-refresh. I have no panel with HDR and PSR or Replay to try it on,
> and the VRR and AVI infopackets already go out the same way. Does an
> infoframe update in self-refresh need the same pause?
> 
> [1] https://lore.kernel.org/r/20261029171219.2842014-1-hugo@hsal.es
> [2] https://lore.kernel.org/r/20261029165420.2255749-1-hugo@hsal.es
> 
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index dfbc384fbbdb4..0b40e860734a0 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4224,6 +4224,19 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
>  			amdgpu_dm_replay_set_event(dm, acrtc_state->stream, true,
>  				replay_event_immediate_flip, true);
>  		}
> +		/*
> +		 * An ABM change alone is a fast update, which skips the
> +		 * self-refresh pause in amdgpu_dm_commit_streams(). As with a
> +		 * backlight change, amdgpu_dm_enable_self_refresh() clears the
> +		 * event
> +		 */
> +		if (bundle->stream_update.abm_level) {
> +			dc_exit_ips_for_hw_access(dm->dc);
> +			amdgpu_dm_psr_set_event(dm, acrtc_state->stream, true,
> +				psr_event_hw_programming, true);
> +			amdgpu_dm_replay_set_event(dm, acrtc_state->stream, true,
> +				replay_event_hw_programming, true);
> +		}
>  		update_planes_and_stream_adapter(dm->dc,
>  					 planes_count,
>  					 acrtc_state->stream,
> @@ -5280,6 +5293,12 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
>  
>  		mutex_lock(&dm->dc_lock);
>  		dc_exit_ips_for_hw_access(dm->dc);
> +		if (abm_changed) {
> +			amdgpu_dm_psr_set_event(dm, dm_new_crtc_state->stream, true,
> +				psr_event_hw_programming, true);
> +			amdgpu_dm_replay_set_event(dm, dm_new_crtc_state->stream, true,
> +				replay_event_hw_programming, true);
> +		}
>  		dc_update_planes_and_stream(dm->dc,
>  					    dummy_updates,
>  					    status->plane_count,

