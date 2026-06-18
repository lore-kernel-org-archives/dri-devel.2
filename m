Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC59CD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 08:03:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E741310F1D9;
	Thu, 18 Jun 2026 08:03:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RoYAjtws";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010031.outbound.protection.outlook.com [52.101.85.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DBAA10F1D9;
 Thu, 18 Jun 2026 08:03:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLlabZricZBWfIoLRAhIRt1Oz9MrvvMy2pLH2vby27MifGHXROAoGJS9SdkJoIrGtzZgFyJHijkbf+6uQkq5hdPPIngy4HAHzts7TMtpR+QXz9JKGf2CwFT5k8GE+D5gnL5DWDVjfFP3GnnhwlzFjcKoWLEqQCubl8nlkw9cD5WiNBerUIkgWyknJyyq+V8XwS7PNeOnto68BJHzkd87+06aKRR5moxDouLwklqkp7RJarBtFzBq8tedYt82ypprn5KU9ZlNZkQnhIt9T7Nh1OuP6eVWexuO0Kkbs5+m0U/9YeoQA4xBN/CGTrC4jt0cKVg0tTvgsrG2HAog7pdtuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUHPt1aJrzOPMy31GHR8a9Q2gjcoPBe4bs1YYgeDyv8=;
 b=HXZN1F6ensrx7kSyARg17RtU4i/XPlZDf7eIM+giciYwsCbZvAHPsc41LjoGuFphutfFiAaVSi9gBnj8IKWvWKwum+sI9XXr1lbZZpgOKIHN0zypHlaCLaWyLgl3xpCoc69D8xcaXSdbDcz0q88qXIoBon9w/tSld3lm/Z4iitR8ZxPFaJlY8TpATjxo7iEPjHhRYqZ0wgbZDRLsOkX1M+tRulxr97lWXsBc0DmXwCjQspLgkdfxJ2LLkAoHHEvG7kV7kLTiY1SLcoWHJz81gZzbLxYazmEDoT1OFYehWLBjMEKp23Bkeladq0VBtDwmp5WkdAvWk4ike+/Rlcsulw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUHPt1aJrzOPMy31GHR8a9Q2gjcoPBe4bs1YYgeDyv8=;
 b=RoYAjtwseelARq6jerQTV0l0vQiUTw+AQthEedxj8+vjZlOw500IpV+65eGvl7YrQ7uyTgYatbfnHZLB+V7LUGTuCwbWoPGnK3NwfF6wKeywLzrszh1Kaek9gtR9NA7+xAXcRuJoqHqB3v8F0HYTNFXdVqB/JBWvKvaR3adDaZU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA4PR12MB9762.namprd12.prod.outlook.com (2603:10b6:208:5d3::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 08:03:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 08:03:24 +0000
Message-ID: <cbc54f68-b0bd-40ad-b5e7-ed8157128417@amd.com>
Date: Thu, 18 Jun 2026 10:03:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: do not enter fs_reclaim under notifier_lock
 in lockdep training
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260618055216.56191-1-mikhail.v.gavrilov@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260618055216.56191-1-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0408.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::23) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA4PR12MB9762:EE_
X-MS-Office365-Filtering-Correlation-Id: 211c7608-8e8a-49cd-92d1-08decd101226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: PmlpGTPj9mpp+KrDGcH/e3GsjGtLCBDTNf7aCaigissmf42/Ex9KBb7oxEy0F1YmASppOG78/Cw7XwEdszYNrzW1oGaZkvNbXcRrO2wg/T3b2Mkxo00elN8prNqeC2zusyD2J0TiPiEW/nCLxP3GPzPWHqWTT1zx/oMCQVqNOi+QQdOjyC66aYYcj4w7T5JVn1VMJcAUSRP+hHOkouXI2CTBFvacpV5Ad4eHmwHWZsQw1YxggB4yVqej4Dkgc+3HSzVjIgpVWGFngbdsX2Ke/uwEPWbUmf+M1j9y6AjNsz0uzpcNQW86LxwsWhDoYoSwAV3RDG0NLcM942ztptdm9M6yDIdk+Yzrm7hJ6PpPgl2UPq/ErSqXFWfoBiL4/dVR8ZSBYYZik+Eb8S/9sksUm/kDIUFd3UdhfYrmxJHGUv2Cmi+gSR9ONjX43gt2kmlIzhQawLNLIWm8Y9A8MhE3Q1o/qfuFPDWjLfUVLv6YOAiaJLjS7sdISEQSms/OID3CwlTmGGtk4pO58vlHray3qN4S7uOi+3MOoTVAZfdBpSytC1SJdl6WbKUawnOkJ56nQJRaZNyiOSvdcnB19g6nRlgWJJQYQfHbveeMafjdRleXm37qErpZPxhdV6OqW8BKvIbz4lg3VQQM9Ot4yVA8M4gaI6MynpROdxukGDQtSC4YEzqhk7EpOKkbFrhhauzo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0ZpOXpnNjdGSERGR2NtVzBTUy94NlRFVEMyeDJuelpmdndWRWkzMi9CVnFs?=
 =?utf-8?B?L3FNZmN4TkhmOEYrZ2FxV3ZtZjZnWUE0S2FISWRUSEkvK3JIbTUwV2p0Z3R3?=
 =?utf-8?B?Z0ZGMWR3WUN2SllmZ1NFR0xZU1N0djdCbVZZQ2FWaklGYW5JNjRDUkNIdDZ2?=
 =?utf-8?B?U0w3MFlreFhRcnZIbXhCdVJNRCtGaDRxMGt3T0VCOS9CdTkzanp3Wnk4Nnhx?=
 =?utf-8?B?aWZ6Z09PT1BRNS9XM2J1MGJGQ0drSm02ZTFuY3hFc3B6Y2xJdjhyNXFyUHg3?=
 =?utf-8?B?TmRUcjMxdG9zVW9wbGErbUd2cW9tUVU3WDRwMDhMWXFSeVgySmtHei9ESDhH?=
 =?utf-8?B?bzBiVEZxRHYvTEw4SytwQVVYMFUwUFduajB0UFFEVndrc1ByU2J5UWZ5KzZS?=
 =?utf-8?B?akFXb3B5WjRhZnNwV2hZNlBuVVoxTkV1ZUxBVFRXcUdnYnZCKzNrbE9PdS9V?=
 =?utf-8?B?VGtzYzhnTlRsaWdNZEhjRkxHZVVxWnVReFY4bm9jaWFpelpRQWdQcDNWNUtx?=
 =?utf-8?B?eWlsZ3Bub2RCbDdKOTk3VUloK1JYeHRmcW5MaHBncThtWTVlUXV5K0d1bnhZ?=
 =?utf-8?B?cnJWRDJZOWxWR1U2REJKNk5vMkhhdTFmc2p6dmVCdW5sb3JVeVhmR0NqaDRP?=
 =?utf-8?B?cDhvYUNNaXdKYUkxZlRieVczY1lEeTJlNU1jQWsvZDZmTnJCc0NSaWt3MmNs?=
 =?utf-8?B?aWhvbDNGUW9QOFN6TEdmSm9WSEErdXJxSXZEV2xQRW1sTVhEd2ZDajlxVVhK?=
 =?utf-8?B?d1FCU2ZSajB1R2I2TjVXQnlFSXErL3d5OHYyQXJwVHlmZ0hKbGFKZzNaNUM3?=
 =?utf-8?B?VVk3eFdTeEUwbUR3dlVwdkRGR1lDQktCYkxwU3Y3c2NjZ3dqVUdhSjRtbG1p?=
 =?utf-8?B?M3Z0ZGhvOUROT2NrTGN1ck5lc0oxMU5MUy9ZaisxV1graWVjNUZpR3dGN2xN?=
 =?utf-8?B?OTh4c3NoS2RLY0RyVjRxYlBwWHJIRjlhdVl4TDdzdldGYVVMR1k0dWdhdStL?=
 =?utf-8?B?YU9JWjdEemFna3B1dEFWTitlWDFEVXY3QlBuazYvMlRHMVZsb2JRc3hzVGUy?=
 =?utf-8?B?dzhvVlQwNVNDVkJMeG5obGFiak8vTXJUcEV0UFJCWGRkS2V3Y05jZW5JTml6?=
 =?utf-8?B?K09MS3ozZUVkVVYzT0I2aHlFRzYyQ3FNYWZ5WDNaRkJ5dUFuUVoxalNNaXM3?=
 =?utf-8?B?YkpzQ2gyeG5rZnFscW82Y3R3Z2g1THRCSGdCS2hOUE5YWmhVTUM2TnlQUCtr?=
 =?utf-8?B?Y3pMZTEyQlVNWStKVCtVSzJZNGNoUVhJbWszdm84bS8yNkFVbTJLaXlyT0do?=
 =?utf-8?B?TVhnOWYxNUNvK3JhaEd5RjJVR3gvZmFCUVp2MHo4U2M2UThDRnNpRlFrUmpK?=
 =?utf-8?B?dy9TQWxrNk1yaXB2ZjBJTnd2ZS9ieTg3SG5KV01GWnE4UGVHVU4rQUYwcEcy?=
 =?utf-8?B?MG1GdHNCUnNlRXRIUzUraE5NMW9mQ0JhYXVLM2srUVlmYklmZm43aDZ5MFgx?=
 =?utf-8?B?MGlpSTVmYlU1dlVaSmZkVk9oTHYrbUZqZ1QzU1RvODVkRDNFTlU0REdjWkc2?=
 =?utf-8?B?TTUrWTNMdmx4dTJKWU5sRGlyVll5cHJtQ040M0hQWHd5WUZXRmhBM2JMaGRa?=
 =?utf-8?B?Mm9nbHZJR01EUmxDUGl4ekQzL1Q2aTVxbHhKZGtyUjhpTDFqUzFXbm9wT1hS?=
 =?utf-8?B?RmJuRFp4dWVrcnZWcjhTMGM5a3B1aUZ2dlJhUy9rdHpLNDFPZ2gzcTQrQVFH?=
 =?utf-8?B?bzhJZHhtQk5wdUdsL2VvY2lyY2RqZjVLL1V3ZmNZY0xodDRzS1hPa3VnOWd0?=
 =?utf-8?B?eG1OaHQvdjhaa2FCZXY4U1JxQ0EyeC90c1BaV0NuemRpSm1BaDlkb2M5SmZz?=
 =?utf-8?B?QkdOMDg4ME1PYVNDWXVSdjRZbk9xRkhJVkFocEdPTzFhaklqcDNmS0QzUk10?=
 =?utf-8?B?WCtRcHExeUJJNjhaRVNLYjBSM05DaU56SHdxVWNIaEROdk45b29QSzhySUNj?=
 =?utf-8?B?RThRS2ZEODEyWGF0Q1I2VnUvSitiV2VTN2Z1ZDJhRzRUOS9FQmFReTN3VEtq?=
 =?utf-8?B?MTlLTVhjb3FlZ21adXpoNDQ2VU5FSXc5Y0FnN01pZERQakFiOE5UL0RERDUx?=
 =?utf-8?B?VFR3bDlMVDd1Z0FaWEtxTHJ1QS9weHpaT0M3WDVSUnlDdzViTVhGT2pmRW5x?=
 =?utf-8?B?WWRyaEdueUI5Q1E3aG1TWHpxTkhBU1Y1YTNzc1NMNkF2YlZuVi9iaE53Q2NV?=
 =?utf-8?B?bWpCeTZ1YmFoYXhvQ1o3M0Y2UlBoNTVVSlkyVHFZV2krejVZbFd3Rk81M1ds?=
 =?utf-8?Q?IPIJunkDOiy7NsIzKS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 211c7608-8e8a-49cd-92d1-08decd101226
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 08:03:24.2038 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKyGajLsiLsRKVMlWRtiHA6rGaZnEZelAgL+1LSH0w9D3om9fekevjrBVdMrQ8YE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9762
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

On 6/18/26 07:52, Mikhail Gavrilov wrote:
> amdgpu_lockdep_init() trains lockdep on the driver lock ordering by
> taking a chain of dummy locks in order and calling fs_reclaim_acquire()
> in the middle of it. The fs_reclaim_acquire()/fs_reclaim_release() pair
> is placed while notifier_lock (amdgpu_notifier_lock_key) is held, which
> teaches lockdep that it is legal to enter memory reclaim with the MMU
> notifier lock held:
> 
>   notifier_lock -> vram_lock -> reset_domain->sem -> reset_lock ->
>   fs_reclaim
> 
> notifier_lock is, however, acquired from the MMU notifier invalidate
> callback amdgpu_hmm_invalidate_gfx(), which mm/ runs from inside memory
> reclaim via __mmu_notifier_invalidate_range_start(). That establishes
> the mandatory reverse ordering:
> 
>   fs_reclaim -> mmu_notifier_invalidate_range_start -> notifier_lock
> 
> The two together form a cycle. It stays dormant until reclaim first
> unmaps a page covered by an amdgpu userptr interval notifier, at which
> point kswapd closes the loop and lockdep reports a false circular
> locking dependency:
> 
>   WARNING: possible circular locking dependency detected
>   kswapd0/268 is trying to acquire lock:
>    (&amdgpu_notifier_lock_key){+.+.}, at: amdgpu_hmm_invalidate_gfx
>   but task is already holding lock:
>    (mmu_notifier_invalidate_range_start){+.+.}, at: try_to_unmap_one
> 
> A lock that is taken inside an MMU notifier callback must never be held
> across a reclaiming allocation, so the fs_reclaim annotation does not
> belong inside the notifier_lock region. Drop it. The remaining chain
> still teaches the intended lock nesting.
> 
> Fixes: 1d0f5838b126 ("drm/amdgpu: Add lockdep annotations for lock ordering validation")
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
> index d5d71fd7c70d..eeb3b5007f80 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
> @@ -150,12 +150,6 @@ int amdgpu_lockdep_init(void)
>  	/* Level 6: Reset control lock */
>  	mutex_lock(&reset_ctl.reset_lock);
>  
> -	/*
> -	 * Mark potential memory reclaim boundary.
> -	 * GPU operations might trigger memory allocation/reclaim.
> -	 */
> -	fs_reclaim_acquire(GFP_KERNEL);
> -

This shouldn't be removed, but instead moved outside the notifier lock.

The notifier lock and vram_lock are also in incorrect order.

@Vitaly can you take care of fixing that? Thanks in advance.

Amdgpus VM eviction lock needs to be handled here as well, but has another ordering bug with fs_reclaim_acquire().

Patches to fix that are pending on the amdgpu mailing list, but I need to find time to work on them.

Thanks for the report,
Christian.

>  	/* Level 7: SRBM register access */
>  	mutex_lock(&srbm_mutex);
>  
> @@ -175,8 +169,6 @@ int amdgpu_lockdep_init(void)
>  	mutex_unlock(&grbm_idx_mutex);
>  	mutex_unlock(&srbm_mutex);
>  
> -	fs_reclaim_release(GFP_KERNEL);
> -
>  	mutex_unlock(&reset_ctl.reset_lock);
>  	up_read(&reset_domain->sem);
>  	mutex_unlock(&vram_lock);

