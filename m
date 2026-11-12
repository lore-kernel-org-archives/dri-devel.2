Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5092E606A323
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 02:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=TVOdt7p5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CBB010E048;
	Thu, 12 Nov 2026 02:52:34 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011036.outbound.protection.outlook.com [52.101.57.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4296810E048;
 Thu, 12 Nov 2026 02:52:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IvJ5xVCTGjPQtcQW/Coo2dPDJK7oJzrmt/bhWl71lV7HqJ3MLVSPcGbOjy1V9e4EtcXbRjaS/YDXlq6eip6Rbt2yzTjD9R3YgyuMHeDiIiWIBVlFUUdDIYvTmwPQSsPokbSw6fTxw9DnJiW8e9gYwZBp/8XmC67ysFYmI+GTNWe6IWeSJ7YEN6rU5NtE0Ma17wtqVs08TpRTi4vV9RiJburRLsVRZb5NIlEPJsj+AQqpB6Cw4W6JouXlhnynbcpvil7mA/xXgXuJYT9l7cfzmPcsyo9FPFRGffVBIisRrznOhJjAf+OH+WBifPtQTjus8fGaBcAk1bQoyFrE/DHpWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4yBRRzXb0pmE+QNaKSN4tAgczHo3rzcuy4XSXO6CYA=;
 b=snTm6WaxLMXZY0fnj5EtnlJT73rEWT7C8dFjP1fWPVCstRuCnDaLQ0RUOC0epkGhgzhGBVDte6ie/5/NX2Eww9mBt3Ck+3YG1p549a8Ob6RILiG2kpEAGg/7tMl5jmy2gUBCaab20nJj9a7xZYG3KTe5zHpVyMfN7CnsXvb6QlNiZwbfGhLlIzKjQPz8YrTwNbjWP5j2hMWAZeYM/pJjTdA8gIYwXrlWebQCEPV4bG+c5n5weSSbLTSfDbZYYqPGwnl1fLimBd1kK1M4X1Ga6rl0Jt1PplC6CynsZbxUKYCADxfwk8eM193emg0J+R2w21Vq4OlkYsodSZoectuEpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4yBRRzXb0pmE+QNaKSN4tAgczHo3rzcuy4XSXO6CYA=;
 b=TVOdt7p5kQ0LtwLeeLpvSiofrOHXt4f3EChQuwPXH3dMGnWSPBKLnMQiKnEDcUx7z9ssOUpQsFB73NT5+G5JhxK3YaeHI1wQ/4a2DK+xBLAt3b41ofs3g1F+QwNmxncHucXakLbUq2ab+WGqcNw7TQhy5KS9RdHrzvP6jLuuZPw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB449095.namprd12.prod.outlook.com (2603:10b6:8:4fe::22)
 by CH2PR12MB4295.namprd12.prod.outlook.com (2603:10b6:610:a7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 12 Nov
 2026 02:52:25 +0000
Received: from DSVPR12MB449095.namprd12.prod.outlook.com
 ([fe80::76a6:7a4f:a0a5:18c0]) by DSVPR12MB449095.namprd12.prod.outlook.com
 ([fe80::76a6:7a4f:a0a5:18c0%4]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 02:52:25 +0000
Message-ID: <df5654a1-f048-4023-9a73-fa8a316a1de4@amd.com>
Date: Wed, 11 Nov 2026 21:52:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 5/5] drm/amdgpu: keep reading the vblank counter in
 IRQ context during reset
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
 Harry.Wentland@amd.com, Sunpeng.Li@amd.com, tzimmermann@suse.de,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, James Lin <pinglei.lin@amd.com>
References: <20261111085534.514957-1-Prike.Liang@amd.com>
 <20261111085534.514957-5-Prike.Liang@amd.com>
Content-Language: en-US
From: vitaly prosyak <vprosyak@amd.com>
In-Reply-To: <20261111085534.514957-5-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0100.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::33) To DSVPR12MB449095.namprd12.prod.outlook.com
 (2603:10b6:8:4fe::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB449095:EE_|CH2PR12MB4295:EE_
X-MS-Office365-Filtering-Correlation-Id: ad8aba29-250e-4566-750d-08df4067fb40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|261102123227099003|261028144727099003|56012099006|4143699003|261021123027099003|261026121527099003|261009223027099003|10067099003|261022115727099003|11063799006|261022105027099003|261026140227099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: jYcJgKKC4l8XuNzJ6By99wiKqLcTgCB/hppq7WSy4o8JiqfKjJ8LtSmRreBvP6QRGds0+KTDT0btmEGcqFbSL1qSH28U5geEBp8NuuFcXLy8vp3eokDMzCoptbyQAr0BpUwMoOntWO26Jhmv675Jw95LL1GqMU/PXMZ3vDUEnRa6iAHWpGx/Uu9pWrrq7EYToGravXOlfC0Ik+Gdhbu1MPjIXMcsrfRM8fzQK/xkv1xWTlXkR/Zfmw9/fOLrlJdPqT0FieJxx9BP8U3grep4/5S9JLSzFsEI5q+vXJuxt6eFaJxWzB/cR7Ci5juc2g5wvgDr8Xp8Cvt16RwopWchYkPODTTpUaNzNC6aF6uce5tJDcyAn8xH2c92uYW/gh/ZdwHfputpg3Z2ZhBrIK5sdubYzcaw6S+irqkNTNkbZiIhyG94v+BKxMX89P171W1kx7iG2XxwjIcqhwMMVaOFVFnkgnY28PKDDIwTP4vjbrDxii3n8VG5fHORFWG6016CrcCitIZjVJrCPcHozjJickOpApPF4Z84wNNKRXJxmGZeM6cpxy6U4IbIv6gB3JOZYIURF6YFtuem7OS9crJxodX6z3zjQ5OhLlMD45TkSckjIKCKQj1H/lrChJ6AkK3oN4EtpaAm3jYabn2pwXGSZRYVDXRBY0NCPv6QKAcIigE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DSVPR12MB449095.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(261102123227099003)(261028144727099003)(56012099006)(4143699003)(261021123027099003)(261026121527099003)(261009223027099003)(10067099003)(261022115727099003)(11063799006)(261022105027099003)(261026140227099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1J3WFZLVjFrOTNTZkdkOE1EU0UrVkdsODZRMnNjMGFmRU1qMmVRaUpYbUFo?=
 =?utf-8?B?aE9iTjNvRTNsSW5zTHJiZm5OWHJGK2Q5ZXplNnNnMHBTL25ONVZUdk1rMFF3?=
 =?utf-8?B?UzQySFpHQmJ0dkhLZS9KRGhleHQxNXJKMU96ZEw2SFVnV2J2Q0dxM3RWRmV5?=
 =?utf-8?B?M1dMVmZkVXB4cFRnUlJPaHp0WXV5RHpPQmhIaytCdk9EZjBnSUFzVGVRRkIw?=
 =?utf-8?B?cWhXNFJEVVdRMEVlZnpQYnBWMktOOFFnRnl4bHJFcjJ5ZjQxaDBTQUNGSjJO?=
 =?utf-8?B?Nk85blpsck92a1JHb0FRYW5DY2E5NzU0VlF4S1FFam42amx0MnQ0MnhmaDk4?=
 =?utf-8?B?YSs5MTM5QkJpMXg4d092NVZOa0toeGVzUy9ycllJWjA1ZUNnKzdzUVJEZ0p4?=
 =?utf-8?B?azREQ0pick4vWUxRMWkrYURXRzhVeFQ5ZmgrRXNubm5raDcrSWE3L3JoWFpy?=
 =?utf-8?B?Mi9pQ1hXREV3RVJ2clJRaXF3NHh6aVQwQ1JFWjRIWnRCYlJsdUJnbzRyRXpR?=
 =?utf-8?B?ZXRmUWhpTW5mOXJ6eGlra2VYL1ovVFVWNnIyWVJrSHV3Qm9MKzZRUnljdDZW?=
 =?utf-8?B?SmEzT1hYdFcwQjl3NjViSVBGeHVvNkR0SzIybHFUZm5WODc2NjlXRTNITnRv?=
 =?utf-8?B?c2RYV3J5U2pDOTJUTlhyQkZZQkFDdS9kSk1RVzZFbXgyeHg4c1F1V1dkNXVJ?=
 =?utf-8?B?VFdOSzgweU1ScXRNellHTzNCYWEzL3dBL0QzcEQ2WG1vSDVqVVdWVjV0Q0Ex?=
 =?utf-8?B?WnVMUUxyaDUyVU1HZTk0d0M5YWZuVVhDS1czZjBtRlBrNVFiZXNHN09SVmk4?=
 =?utf-8?B?cnBkQzJGZERtbUY0bG1BZHhGS2Iwa28rWk0vS3owTlp0dE42cEsvNHNhcEpq?=
 =?utf-8?B?NXJBRERrZi9JR2NGU2dFdmx2U2x3RlFBbDdvNnNDblpvN3VpbjRlL2xGV3M5?=
 =?utf-8?B?RURXRFh2UEtQdC8xNldYMVJKdlFWYkJMamRFcW85Rno0Y0hMV01hbmxXeW1X?=
 =?utf-8?B?aHlYQk00WWoyNk94L0Q1MDlQMTUyVFF1S0dCMWhVSTNvVlJYWU5DUlRjV3lL?=
 =?utf-8?B?Mzg4ZTRzZ0xBSlFQZ1BFRDg3RFFUMWlZamllVlU1d3VncFRHaXN6Q3pWaTNv?=
 =?utf-8?B?WWFvMFQzYksydk4zNWpvcCtvNHZ1SEdpYjdndjZHU1ExNDNDQXJ0TzRHT3Bo?=
 =?utf-8?B?S0NEMGtDcCtXNUsxOWcxbGJ2ZnZjdlpHcWlXS1laU1dvdUpWbHNsbjRiM25x?=
 =?utf-8?B?MnhTb2g4eGJJdGU5M284cEpsV2FqOURxYld5SDJwWVRsQWkyOEExb2FJZmxP?=
 =?utf-8?B?ejRlQ0FiMG5EYkJhVTN6Y0VKcG91THBkUHVtNmk0OGdZaEtFT1VOK0Y1QjY0?=
 =?utf-8?B?andudnNFL0dCZkJUU1RFUElqTGxYRzRBekwxUmgxdzNZc1RLckVUa1dNMlp3?=
 =?utf-8?B?OStyejRHWWlZc1RnOVQ1UVpWNlEvVVdPTHZDU2drQXhWMEFRVUhBSnBrN0Jz?=
 =?utf-8?B?UEhMOFVRTlpKNGJlbGZadUN5VUF0L0RrK1J2U3RXbCtvb1RRUmVBOStTZnd6?=
 =?utf-8?B?dG1FZjNQUEJvMVdDL3I1S0ExME1BU1ducDE4MHZydExla3dJSFBjK2l0WU1k?=
 =?utf-8?B?YjlGay9xUjBvUE1sTStEZ2tKMW5iUGxZWmhFeXE3aGZyU3E0V1BCUzg4NlMr?=
 =?utf-8?B?NlA2bmhpd0FEMEswYmI5anVEVEJ6VEQ4RmMzcFJMRkpRUU9zaml0VGZ5SmxO?=
 =?utf-8?B?Z3pUZkZBb2xmeHlBY01lMktTaEZDdDc0UDRGTXI3a242c2ErMnFBeDI2STd3?=
 =?utf-8?B?SFJPdUs2QWRQN2ZoUmh1OGUrYko4SnZldmhqaWFQR3R3aXZFTnhVY0gvY3lK?=
 =?utf-8?B?RHZWS0hEN0xwQzRya2JLL0ltbHpzSmZkOVJCek9OSkZDVGJsUTFVQmdSakdU?=
 =?utf-8?B?bytZL0t5S2tBT056VE11L3BXQzlLVHJXdThpczg0OFRmYlNwU2pxR2xnUVdD?=
 =?utf-8?B?UWdURWpROHRiYWQ0aW4vakNLaUhnL3d3NS8zU1QrR29NSjRhMk9ydkxCcWtL?=
 =?utf-8?B?VkZyaUN3SFFrU2VFZm9aVC9NZnAvaWdQc0pLcUNZZnR6Yk9McEFFdWRWbW9z?=
 =?utf-8?B?ejZWdWZQcE5JNGhERjl5dFR0aU5sSWZ5Sk45UnZRWFRZanpraW1FVmZGK0Jz?=
 =?utf-8?B?N3JKVnR2NkszSnliL2owMExNc3VhZFRraXFlbUZ2ODBVa3ZxaDNhZVZwa0xr?=
 =?utf-8?B?QUZmMElmMHJQQi9GQnFRai9SOGV6eGNiaUN1U2FkOVB4dHRiaEFlRXdWY3dt?=
 =?utf-8?B?SEV5VjA3aGREdGx4WVRVVm1ZcHZuaFFKMEcxNUE4bGxSTVhlL0RvQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8aba29-250e-4566-750d-08df4067fb40
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB449095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 02:52:25.2172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EmHVegXnKz1pTk4+A8/Btun1FU5EG3myROgXOeSldaCHlQ6NpVcoPXaANsKzCN/MdalAXcZAdyzkNahYT+f/+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4295
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

Hi Prike,

Thanks for the fix. Would !in_hardirq() be better than in_task() here?

The vblank-disable timer also reaches this callback via
vblank_disable_fn() -> drm_vblank_disable_and_save() ->
drm_update_vblank_count(). In softirq context, in_task() is false,
so the proposed check also bypasses the reset semaphore for timer reads.
Using !in_hardirq() would protect that path while preserving the hard-IRQ
bypass.

What do you think?

Thanks, Vitaly

On 2026-11-11 03:55, Prike Liang wrote:
> amdgpu_get_vblank_counter_kms() returns the cached vblank->last instead
> of reading the hardware counter whenever it can't take
> reset_domain->sem for reading. The vblank interrupt reads the counter
> through the same callback via drm_crtc_handle_vblank(), so once GPU
> recovery holds the semaphore for writing, every vblank interrupt sees
> diff == 0 and the DRM vblank count stops advancing. The CRTCs keep
> scanning out until dm_suspend() turns vblank off and stops the streams,
> though, which only happens after the rest of the recovery preparation.
>
> Vblank waits in that window don't see a vblank anymore. They only end
> when dm_suspend() turns vblank off, or after a second with the
> "vblank wait timed out" warning if that takes longer. The fbdev damage
> worker is likely to be waiting already, because recovery prints
> "GPU reset begin!" right before it takes the semaphore.
>
> Vblank interrupts only arrive while a CRTC is scanning out, so the
> interrupt path can read the hardware counter.
> amdgpu_device_skip_hw_access() likewise only checks the reset semaphore
> in task context. Only back off in task context, so the interrupt path
> keeps the count moving until DM turns vblank off.
>
> Fixes: f2bc71d16e73 ("drm/amdgpu: serialize vblank counter reads against GPU reset")
> Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
> Cc: James Lin <pinglei.lin@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Assisted-by: Copilot:claude-opus-5.5
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 14a72a406d37..06e539c4c3ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1692,6 +1692,7 @@ u32 amdgpu_get_vblank_counter_kms(struct drm_crtc *crtc)
>  	struct drm_device *dev = crtc->dev;
>  	unsigned int pipe = crtc->index;
>  	struct amdgpu_device *adev = drm_to_adev(dev);
> +	bool locked = false;
>  	int vpos, hpos, stat;
>  	u32 count;
>  
> @@ -1699,9 +1700,26 @@ u32 amdgpu_get_vblank_counter_kms(struct drm_crtc *crtc)
>  		DRM_ERROR("Invalid crtc %u\n", pipe);
>  		return -EINVAL;
>  	}
> -	if (!down_read_trylock(&adev->reset_domain->sem))
> -		return drm_crtc_vblank_count(crtc);
>  
> +	/*
> +	 * A GPU reset is in progress and the display hardware cannot be read
> +	 * safely. Return the hardware counter value DRM already cached rather
> +	 * than the software vblank count: the core feeds this callback's
> +	 * result back into vblank->last, and a software count lives in a
> +	 * different numeric domain, which later trips
> +	 * drm_WARN_ON_ONCE(cur_vblank != vblank->last) in
> +	 * drm_update_vblank_count().
> +	 *
> +	 * Only task context has to back off. Vblank interrupts only arrive
> +	 * while a CRTC is scanning out, so the interrupt path can read the
> +	 * hardware, and it has to keep counting: vblank waits that already
> +	 * sleep when a reset takes the semaphore never complete otherwise.
> +	 */
> +	if (in_task()) {
> +		if (!down_read_trylock(&adev->reset_domain->sem))
> +			return drm_crtc_vblank_crtc(crtc)->last;
> +		locked = true;
> +	}
>  
>  	/* The hw increments its frame counter at start of vsync, not at start
>  	 * of vblank, as is required by DRM core vblank counter handling.
> @@ -1747,7 +1765,8 @@ u32 amdgpu_get_vblank_counter_kms(struct drm_crtc *crtc)
>  		DRM_DEBUG_VBL("NULL mode info! Returned count may be wrong.\n");
>  	}
>  
> -	up_read(&adev->reset_domain->sem);
> +	if (locked)
> +		up_read(&adev->reset_domain->sem);
>  	return count;
>  }
>  
