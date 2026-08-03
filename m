Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B223CC55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 13:58:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 144AB10E43A;
	Mon,  3 Aug 2026 13:58:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kZOTiWL8";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010011.outbound.protection.outlook.com [52.101.46.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EC2C10E43A;
 Mon,  3 Aug 2026 13:58:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPKv38J+pBfmOWetfo7xpfor8b4Moz0CQoBh58jPiR8EgnV518mloCcu3AxCZwaBet3EeXtvAfGuj7MqR4CtG6m/EYs23kM71XHp/+byGDjboTm2Ak/WzELe2JPKZCwF0HHJh7XN38wSKyKJu6kWln6NUHS01kHocsqhGpk7GAgjNPa+5lK/bYCBmnmanVDe7R30HdtxnZgvOLZ2ipySEEHGlBDX9ZutV834zMN01MuAmfILK27twUcNidITvJOaU//l5Kk6amzMbbb0oCaFWodF3OT1fQbA/GAeyJuyBaxxXfUziUyT47V9wEsKcAJRqT6SSEu6jV85BsBMA9FqCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hy+z3jcShTI1guMGkbEPhi7jQtf1zmlEvaK07/0uq/M=;
 b=w71AVm9C9JchYpMVQWLRM+chCP2s1nLGi4xVQQVtlsuqv9j2fQOP1xMRXr0DNjqifUnqGaa6OPMHtHWKZd+cZx0IVnYBQkp2u9yuEWBG+fRI+1Bg/tcS66WwgGk80Az54TVVXrUSnbg2qte7um9luc6HYQB2daY59I+QTWO3ns+35mk7U7eivV5OVFJEdJBq4vEWO/IVSvZlcWVk6V0EcZ9xgvSdzOVfQ1UDF4O1kXksTi6I8YGixc5ScCqQ2kvxoyfUV2EL7nhyUjVOBD27aCf7gal8gVpY+JF6kutEKz8aNL8RZd3coH6IBVLAf0nkojBOjjEwwHqH8dSt0Qo+zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hy+z3jcShTI1guMGkbEPhi7jQtf1zmlEvaK07/0uq/M=;
 b=kZOTiWL85x7+RWkTJ1PFLbJa367WhTXOgWmUIFfJXL8yuw0JFB0qYeMCjp3Zn0tFSQFJEZ2iXRjDJNCwNGhCwbUZ9VzaLNj7Hsac3nFYOSNrUixmYDPPnyHmIV0mJgvXmWCgYaTZwkyyRdOOkfrgcZyVkBEV9RoY9DwI7Qch4MY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4249.namprd12.prod.outlook.com (2603:10b6:5:223::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 13:58:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 13:58:28 +0000
Message-ID: <2ef4fe44-1588-4e12-9ee1-98f5ad7de37a@amd.com>
Date: Mon, 3 Aug 2026 15:58:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix use-after-free in amdgpu_vram_mgr_fini()
 on init failure
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, Sashiko-bot <sashiko-bot@kernel.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
References: <20260722095201.658119-1-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260722095201.658119-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4249:EE_
X-MS-Office365-Filtering-Correlation-Id: 03ddcb49-a6ca-4e4f-6307-08def1674b4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|5023799004|56012099006|11063799006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: j+YvHrSRjBCOmhDzqNNEe5AnPx1lSUJQIGLezH8UEcqdRAqMbrYTWwKENAZruMKN6mL0MximoYnvrM8neLSOLc++tq8SlxtkaN/78gNsDXzXUjcFJwBQ2cT0GyWGKrZjurgnovYaplLwjdAnB+AxG3cN3D8eCAl8yGE4dxx9Kn7HUSMPi1pmMEwc9LJ3AtD9dWT29x4o6JL4qDrFFpVXBcwPs/9WFb401nBK6g2S1aTTQ9leGEDt30wczH8osL9Ti+AutRzB3tJ5QO2NWiy6C1x+i7VuC6qkq6QCCSOSpjO7nwctjK80G9zHhX22skp/WbT0azITi9753o4ISs8SI9f6BGTkPwnEgjJ6zYKBgNS+HDKmt6x5D3bFEjOLt4YqkNKzBCcnCoUMgENSEzIP+Z2b8iBpdZv49ePlE9RulSehQVInEDOPlmOp14ALe3yeKf++FaH+D6NQecanYphYPam62IexA6ddDUdXNLd0yVhDPwh28/tVRm62oqeM6oDVSbfJ3xyg+S54eUdFIDWUbvCfx3Q052Fvh6Udo8LvLhYRnkBFolJhBSnI76XHx99R/JkTo+5/qPRyz7XaVZ1rbRO8HlBfe1wDw9OX/GYPqEM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(5023799004)(56012099006)(11063799006)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czhXcDB1c3NIY1l5MkF5Wklad2w5b0pBTzVnS3J4L0s0YlA0b3o1WmkwcEYy?=
 =?utf-8?B?ZjF4T1owMjA4MWxUTm5xUjZTQithSlB4K1VHbEp2OEdyQWdQc0xyMzI5dEVI?=
 =?utf-8?B?NHJYU0NoN1JOdWhVSkZCcml2VVloVGsrb1ljMDFzdUZUcTVaVVpucXJuNWla?=
 =?utf-8?B?ekNLb1ZTbXZCY2VWZnRyVFpRc0gzZnhiYjBWcVlIK1lKWjhNSVd6alRReUZO?=
 =?utf-8?B?V2l6aXE3ajcybFlFYkh6NnJ0by9SbWlsZW56NzJNMGpnek43cC84Z3B0bG8y?=
 =?utf-8?B?amZ2MjRWejc3ZE42M0JUcXpYMXBBUmplcjgwc0dyMm02Ulk0N29QQnQ3VzFu?=
 =?utf-8?B?MEJ4ODUyZ0RQQk5QRUFHS2R2ZkJYdloxV1RVQnlkYWJrejV5ZUxrSkNPWllh?=
 =?utf-8?B?azBnYTZUSjN4bDJPc29TNkU1ZUUra0NoYi9HbjE1WkMyWFVxYzN6MmZ6VjFI?=
 =?utf-8?B?QUE3RFlkWFVUVEJqdUhXdzV4MzlWL3BxcGltVjFYVnNGLzRRalhCM2Y3MDl6?=
 =?utf-8?B?M1RjVUN3Wk1WMHNEK0xoZ0JSWjVGSXRvc1NvQ2JmalY3c043MGs5aUtidUlj?=
 =?utf-8?B?OUtHZzduSERMbEttUGRWZGRGK3dDK2NKWExtbmRkNzNNeTFQb0VDWVUyTmdv?=
 =?utf-8?B?WnhsaXlMT3VPVDVpVWM3eHJjazhKaEx3MnludnBxYnJLeWhLaFI1ZzA3Q1Bu?=
 =?utf-8?B?VXlqVjg2cGVFeHA3OERYTStjeW9GalBoMFc4YkF6Um5IQWI1RlFZaTBPWGVr?=
 =?utf-8?B?Rnc1R2JIVGxyaDdKZ3FKa01BS2M0NWRFQUlFMDBnQmFUVGdQMlZaWHF0bEpL?=
 =?utf-8?B?RG8zaTYrSG5rY0J0THlCWlNCZkhMS1BBRnlIaFU3S2ppVFdmUDRqeWZCdmFR?=
 =?utf-8?B?VklrQkQ5cGVJSy9mem9jSXRYTWR5WUEyRUJvSWtjYVBhSjdBZUZ0OFZkTmpr?=
 =?utf-8?B?amJ1M0cxc25xdklUUXdtOE92bDhEUEJHRlc1MW52U1ZWWFRVcFI5a1J3Y3h0?=
 =?utf-8?B?K0FNSE1KWGFSa2NjMmFTaCtURVVHMnZ6bU1Uc09ieHRwRDhPaHMybkpsdEIr?=
 =?utf-8?B?Q2Zvbm1IeVY1bWxrQWt6QWV1Q0RvL0g1dUFJRGtNS1NZMzhvZGdwNjBvVTEr?=
 =?utf-8?B?UXoycU5CN1lyUFNFbXVlTkM5b01CdnlyaENCVHZnbUhYV1FuVXpMV3BYMzBi?=
 =?utf-8?B?b1BZdFVZdFd5bGxOeDR1RFJIa3U2SndEOUdrQ0tMWmlWN0N5TkRTV1dmck1y?=
 =?utf-8?B?Qm5aWUlTSHEzaVBHQjZrNmFoam9wRXk2M1lDcHowSDloQ3pscW1GVTZzR1h4?=
 =?utf-8?B?ZzdubEJISkxsZTZrcUJ5QWh1SmVEaVNIVGVlU0duRVlIV09vTW05eGVPRVZj?=
 =?utf-8?B?Slk2eWs0Y0hBdnp3Z2lVRFNFMFZJMjU0cTRhckFTYnFZeUdPN1dBVHZibUl3?=
 =?utf-8?B?SG1JbUpJSzRQa3l6VlNYeGFvZzNiQi9lMXFPV284cDlxeWQrOHhwTXU4TVds?=
 =?utf-8?B?QWhvMXlodktDUVdSaWlmVFpMbWo4R0lqcUl5aGw5L3puNkhibmdvZ0FCMjRK?=
 =?utf-8?B?WmhLSGJ5NE5ER2g4Z1JiYldOenFjaFJOSXVRMWZkMnNOWlRlWW1uQlhZZUVJ?=
 =?utf-8?B?Qms2WFBXaTB1b3NSa1JCazdmR3VnMjJXOXpTTXlGUG1HWUpKakwrZy9uV0I4?=
 =?utf-8?B?WFhBT1FvaytmeVJHbmxjZDNoeGhmMDcxWDFHZE0vV2pGMGQvaXJseStmbHc0?=
 =?utf-8?B?UlAwNWh0dUxzQ3dFVHpPLzFmM21DL1o0Ny9YL283K3pwSEpMMEtzNVl2L05Q?=
 =?utf-8?B?enBBb2d0NExGVTdXT1hHd2dqZW9Wb0pmeWE4K2pZZTJxRUhKa2FtOG5BcnNv?=
 =?utf-8?B?N1crRjFpTDF6Rll2UzNhU1AxVzR0RUwyWnh3NnFFQWZKVEZCeEFlcUxLNlgr?=
 =?utf-8?B?VGFHWXJCemdEVThFTGg1YWxkU25uVzlSRzVoWGM0UFNwOVBHUEcvN2pRdnVE?=
 =?utf-8?B?cjg4aS9oc0Q1anJTemdMK1NsdjRsWUVpdXRrN0lrMFBlYlRnSjdGSm5hQ3hr?=
 =?utf-8?B?MUNSRlA2Uktjc1ZWNE9zZjR6M1FKOHpqWWpEbTBpRUNmT0c0ZXpYY2JEcm4w?=
 =?utf-8?B?L0FRd2lBakR2bmJkR21oTHZkM05XSGdsUVp6YjNpUHBMMnZEMFEwSFVJaDNR?=
 =?utf-8?B?YVZoYXIzMEI1a1UzbTdJNGRza1EzeDR0Q2ZHOVNDRWRFTU5iY1NBRzU2dGMy?=
 =?utf-8?B?dElmZUNIcVpScmsyY2J2d3FmQm1jNHA2aXNVbkJWQkFpaVVrQmoweFYyQm1E?=
 =?utf-8?Q?3V015gGaWgzm2ifYqa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ddcb49-a6ca-4e4f-6307-08def1674b4d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 13:58:28.3838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HCO7V04aTNGbDR7DbjCxRGijDaFcvprJFvGfTUXVT49T6jOEsSoKuzMC87b6GWE1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4249
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

On 7/22/26 11:52, Arunpravin Paneer Selvam wrote:
> adev->mman.initialized is set to true before amdgpu_vram_mgr_init() is
> called, so any failure in amdgpu_vram_mgr_init() still leads to the full
> teardown path amdgpu_ttm_fini() -> amdgpu_vram_mgr_fini() ->
> gpu_buddy_fini() being run.
> 
> When gpu_buddy_init() fails, it frees its partial allocations but leaves
> mgr->mm.free_trees, mgr->mm.roots and the scoreboards as dangling
> pointers. gpu_buddy_fini() then unconditionally dereferences these
> (iterating mm->roots, kfree(mm->free_trees[i]), mm->used_scoreboard[i]),
> resulting in a double-free / use-after-free and a kernel panic during
> probe error handling.
> 
> The manager is only marked as used as the final step of a fully
> successful amdgpu_vram_mgr_init(), i.e. after gpu_buddy_init() has
> succeeded, and nothing in between can fail. Use that state to guard the
> buddy teardown so gpu_buddy_fini() is only called when the buddy
> allocator was actually initialized.
> 
> Reported-by: Sashiko-bot <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260611173301.17473-1-thomas.hellstrom@linux.intel.com?part=1
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Assisted-by: GitHub_Copilot:claude-opus-4.8
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 2a241a5b12c42..38529a904deb6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -954,6 +954,9 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev)
>  	struct ttm_resource_manager *man = &mgr->manager;
>  	int ret;
>  	struct amdgpu_vram_reservation *rsv, *temp;
> +	bool was_used;
> +
> +	was_used = ttm_resource_manager_used(man);

The used flag indicates if TTM can use this allocation back end but doesn't indicates if initialization was successfully or not.

So that approach here is clearly not correct.

Regards,
Christian.

>  
>  	ttm_resource_manager_set_used(man, false);
>  
> @@ -969,7 +972,7 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev)
>  		gpu_buddy_free_list(&mgr->mm, &rsv->allocated, 0);
>  		kfree(rsv);
>  	}
> -	if (!adev->gmc.is_app_apu)
> +	if (!adev->gmc.is_app_apu && was_used)
>  		gpu_buddy_fini(&mgr->mm);
>  	mutex_unlock(&mgr->lock);
>  

