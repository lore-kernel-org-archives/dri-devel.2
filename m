Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55080606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 10:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2OIuXqXj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B933410FAB2;
	Wed,  4 Nov 2026 10:03:17 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012000.outbound.protection.outlook.com [52.101.43.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9C6410E88B;
 Wed,  4 Nov 2026 10:03:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ApM/PMMLp1ou6LCRhQx/fgBoIaZLAjtFgMuNCNE2/CORLpPwiy799hdrFV7T1bnnLntkfRhNcXXrkyBu0AT1dkduqczmmoKtH7xOkiTS7T6OXcaSbxcpIC6lL0dl+UtAtSeidrLeAOwTBI8bdlEihXPWdMHwbfeElBd70Extj4OqnojZmisjjFmipQ1sKGnakH1aEpCGVio0LeEDE49aPXuuWkglS5Mmsm9tyru7MSF9EgtoRfKd9c99tf2QhTWCIZbaZrYl+44Il28pIVFkeoyqEQ6reMUinyT9w5aJCkU9kxCj6gOX+9QrWd/kpBBBXWC/IpNN8LP+BPV8NuJI5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=759lyBRHyJwWW/XpyScVjIlVDOvBHGyKMJeyox8+jRA=;
 b=R6UMN7SgxISYP0aq7z5P6mbaOKqqNipJaX5CEramFhOjZ2U/gWbX+QNrxlB7bBJtM68krFwni5CN2V7Hu5yV9I8r6cVmtCNlQl+tptJEDkLKDkxzP+6kaATYFm3RqlJ0NC2zODlk49HHKbebfg/kW6sXBe62YZu+8uTfjGFs8Qc5fDGvAd0tdwU07eMrY8n5OYD2nAXStploSgaiC1zyeWu85h+DEaEkFvCvOky1fJmHMmKWt1GQqd4G3fhEIZBkGftdVUC8kjubk8dQTVBX0nx382fXOWoDF3LNTLS4gPx5Fg06wwF1VD8X+TipnN77m4+t1sBTxhI7gEa7HlfGVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=759lyBRHyJwWW/XpyScVjIlVDOvBHGyKMJeyox8+jRA=;
 b=2OIuXqXjlJlUe4zA8wVleDSwcimT7QmzH8K5/4R3ivQRhjHEAKS8vugWEg3GrcpKAQ2+gadR4/r3AkDVefHqb6fzlKQJaQqJ+yClrWw5KY8TOrmNme6KZ2xBjjvV2sTAMA9wEti+DsLOMNPtXg0kvdN/4+pSusfHi1+8Ddi1RmU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CHAPR12MB999225.namprd12.prod.outlook.com
 (2603:10b6:610:2fe::11) by IA1PR12MB6529.namprd12.prod.outlook.com
 (2603:10b6:208:3a6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 10:03:08 +0000
Received: from CHAPR12MB999225.namprd12.prod.outlook.com
 ([fe80::a4c2:82c3:da88:c585]) by CHAPR12MB999225.namprd12.prod.outlook.com
 ([fe80::a4c2:82c3:da88:c585%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 10:03:08 +0000
Message-ID: <91239ec8-4260-4d37-a5f2-50deb912d180@amd.com>
Date: Wed, 4 Nov 2026 18:03:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Take every stream out of self-refresh
 before a modeset
To: Hugo Sales <hugo@hsal.es>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Chenyu Chen <chen-yu.chen@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 Roman Li <Roman.Li@amd.com>, Alex Hung <alex.hung@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261029165420.2255749-1-hugo@hsal.es>
Content-Language: en-US
From: Ray Wu <ray.wu@amd.com>
In-Reply-To: <20261029165420.2255749-1-hugo@hsal.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0045.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:7::6)
 To CHAPR12MB999225.namprd12.prod.outlook.com
 (2603:10b6:610:2fe::11)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHAPR12MB999225:EE_|IA1PR12MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: 16f0fb21-800f-44ba-bd40-08df3a5ad35b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|18002099003|3023799007|22082099003|261009223027099003|261022075727099003|261102123227099003|261022105027099003|261021121427099003|11063799006|10067099003|261028144727099003|261026140227099003|261102130727099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: 9Y/aCUNrqVwZpH9y9YE5SG5gCF3fNbsN1AnGLZ4961Zvjwpx/2bQ/Mn3VQl71/45K4eSY0N64SQmZqmqXbfcs44p2lWPFfvTQEmA8088pgmz5XGw3+DR7D6hNNKYvgdYbGZ/WQ1ks8RDOPF363UIoUXqMYQNWZUVFFEYTTLsb54++JhwiTM7YZL/zPgbYlSRRY6z1ss8QFoxTrXsC5xiKrFRLoG+St/KixM79Ensf1+gTYHo7fSoTyPqHXo5yDz48xbEkIoeFC6hjfdn1H0vgkSJltrD0Y6GFvmbReiIIqq+F6Fogz9jrvfjgAMtFNXiC2LJsATRfds9CTtGql15I/dTrtT3YC5dvAi0W6Br6aqG0Gbti6Q7R8ou17m7R5BAfffvx4D+SsNlTOhfcxv+BPflQY6o8iPSWkIx11O788ikm3aSaovSXKJDlbQR2H4Koo7PXsmmXawsjWSKgevissWcoPTc0w8eyie4oT27TXpOWZwGufTGRJ77C1zsXIY5QcdhvxWEzOYdwg2/hs1eVfdYenoRJnAhTZeUzNijeLVxGsAYXdxtOV0ejqkt37ziUq8Bg1NX2eFkw6l94lxpcLKLwwgYuakGu+BDUWVLOxaTf1wWO/3rSMOQagmLpzPxQnV+JlHeI9cbaf1M4EXHECQLbsjO5KysDG+rPQlC4dg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHAPR12MB999225.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(18002099003)(3023799007)(22082099003)(261009223027099003)(261022075727099003)(261102123227099003)(261022105027099003)(261021121427099003)(11063799006)(10067099003)(261028144727099003)(261026140227099003)(261102130727099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHlkTFdkd2lzL3RObGtuSGNNOG9iTXVEVHYrcDVzVUNrQy9qQWs1ZG9HNHov?=
 =?utf-8?B?TXloa1E5OGZtWTFyZUl5MklSU0o4Sk42Z2F6c1ZEdW4zQ01MT3NnVHlZeitu?=
 =?utf-8?B?UlRJd25PZGpMYnhWVE5xbW1vS2NNM1c5YWE1NlZlTGd5eklXa01qM3NMUzhY?=
 =?utf-8?B?ZnVVUTgzTEZYellYUExsY2RlNkkwVzY5Um1CYlJWMlRPMzIzaVFDdU84R3Fa?=
 =?utf-8?B?OEl6OXhUQ1pKY3R6ZUxKSVlQdC9ZcysyblR2SDQ3YW10dS92SlQxMWZ5a0xF?=
 =?utf-8?B?WFZXOGJRZHh6VTdZb1lWTHZnT3h4LzNOMlBQNXNEUC9jQXlsalJUa2QyQS9k?=
 =?utf-8?B?cW5Oa00wS0wvYjZvMWJESFhPY2hET293b2xpUzdheFNlMnEwSXQ2NWtmY1Ur?=
 =?utf-8?B?aFByak5YaW1ycFBGTVpvOUZEMGNGQlRrb1JlMkV1WnExTnAyNGNSTkNLaGlF?=
 =?utf-8?B?SW5OcGtNT1JYRGFvcjZxRmFmYTZ3TExweCtNVi9IV3A4TzZQRWV1OGppZ0ZZ?=
 =?utf-8?B?TDVZajY2dkUwdWhaa3ZWTjdjSG1TK1RsaGxlRzRJVUxIT0gyeEtCNld1MkVD?=
 =?utf-8?B?cDh6Q1grMmwvaG9KWGU3dG5pM2VSWDJxOWVGeFNqV0t0ZTNyZEp2b2lKeUtD?=
 =?utf-8?B?UzVpMmo4RVY5V2JOc2NqbjYyb0Q1WnoyZWRxQS93azZaR1l6RUpNQkVWSExi?=
 =?utf-8?B?eWxPOFZXcnhadzZuRTlnTkxYZ0hQOWtpYXhOUVhqdDArVk53dUdoQ1Z0RTUx?=
 =?utf-8?B?MCtKUzZFenkwTSsvcTgrYTJLQ05lRlJGcTBGc3JnallsUC83aER3VmVYS2Vs?=
 =?utf-8?B?Mm9ES2FJcVlYOGJxSmdCTEQzS0RJMUJNcDgyWTkvSms0bXVhdjRubFlrSFpu?=
 =?utf-8?B?N3dYOGEweUNtcXBnNlEzZmdoYmZjQlA5eFU0ZFpRbS9EeWwvdUlJRnFrbUJk?=
 =?utf-8?B?SHB5aSttT3V5NHJibFV5VE5vUnNXeklUT2tFUUJzNy9IREh5ZjQ0Mkt0QzFL?=
 =?utf-8?B?QjRvYTgxMEh0YkhCNVczWTdpNVk3UXgxT3drVzFUVGRROHVpbWpQeUF0alll?=
 =?utf-8?B?dGRudkw3djFTSzh5VlZvOGRWekRzNXE2T2F2cjVSUU1LQUpMd2FhNTc2Skw4?=
 =?utf-8?B?MmowVkJEMk95YXhSVjNyY2s5SmpqNnROb1JvdFltMG5JTlFDaU1PaVluTjFr?=
 =?utf-8?B?cU9DbmxLVTdDakFMVGh3eFhUeGNHY05DeGl0SXN5bXJML3hSVXlUaHFmVzRl?=
 =?utf-8?B?YUtaazhCWmhpQ1doSFRQeUdsZGNwaWM0VVlvd1VYd09mM0g4MXFkU2JMZ1gz?=
 =?utf-8?B?YXZwQnVBUjRSM1htV0k3RVU0eFBaTXZnM1dweDhRSkdFZDJsTVpFTE1wSE9x?=
 =?utf-8?B?UWJEMnhVZTB4UWtscDJWc0o5QkxZUUhiZFkvOWZyNWFVK2VrV25xaTNrNFpR?=
 =?utf-8?B?aVNnd2hxVVhUS1kra2thL3VWMXdBTzh2aWhHQTRWWm92emMrYkdmSWRCSjBn?=
 =?utf-8?B?NzNsNVdsYTJwYVFuNXd5V1RCWmlKbUFrbnY3eG9MdnpRbVVZTXNzWjBzTWht?=
 =?utf-8?B?RFpGRm90czdnSVhkalhWUGdtTFc1aWRFSCtQc01iczdZeW1lcFIvRG9TcmtI?=
 =?utf-8?B?WUZHaHRtU01XcUMrRVdzcTRsSHkvZThKQ0lxT2IwMUczL3ZsRjl0QXF3d0oz?=
 =?utf-8?B?OVJCcXRtYThFOUtYd0Z4blVPeUVHSzhSQlhmSzJUUGNkaW93YkFtcUtRU0Yw?=
 =?utf-8?B?WGhoTUZjWjU4bDBVNWZrRENKVFJxamV5NjVFcllScFMzajducStBSm82SkJu?=
 =?utf-8?B?NDZ3MmZaQ1k2aHNXWk91anF4NWZoaFdXeUxSc2tjUkkycHFVWTRaUFRxZ1hs?=
 =?utf-8?B?b3QwMUpncTdodW82Rk42R2Vpc0JZaWxleCswSVRTNUxvR2twdzRobERwcU5I?=
 =?utf-8?B?ZmNOYjIwMnVma3g2Y1I5SnN2blROUk94SDh6Z3lwRHMwTWIzOWpMN3F4blc0?=
 =?utf-8?B?czJ2bHdKQU9TSjRHckdJS2tmaTBmMFBXK3h6aS9XQm9QVFVGNllZRnFhQnZL?=
 =?utf-8?B?OGVpQjRNVFFVOGU2c3hwSVZpRWtUdHpTdjdiYi9NR3h0aWs5YnJKU2ZyQ3hY?=
 =?utf-8?B?Z0M5d0R1alZ3WS9VZ3RlYUkzdHhtNU42bmR2STNLeGJiN1pkT09LRStpS25G?=
 =?utf-8?B?Sk1DL2Zvdy9ZbDRNRW9pREMrOUhqYWREc0c0c0tHOFB4a2VoVDU2MEsxTGdS?=
 =?utf-8?B?Y2pSZ0lrcEE4VlNCcTJjU200SnFUd2tSUmFGeUVuQXhIaTRJT0NEMUJzZjZo?=
 =?utf-8?B?eENIYU03ejdQOEJlSy8xOFFMSE0vVHdZSFc2blJ2TFFMc1d4VENvUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f0fb21-800f-44ba-bd40-08df3a5ad35b
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999225.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 10:03:08.0011 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0VxfWOTkY9a43IAf0JijXcNGi/ls6hmUTxjD9zXV2NKP8vRFmbXwjvUfNZm6UaF/M0XvwAmc3iE5v629ZS9i7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6529
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

Reviewed-by: Ray Wu <ray.wu@amd.com>

On 10/30/2026 12:54 AM, Hugo Sales wrote:
> Commit 3c108046e1d6 ("drm/amd/display: Add power module on Linux")
> dropped amdgpu_dm_psr_disable_all() and amdgpu_dm_replay_disable_all()
> from amdgpu_dm_commit_streams(). Since then, a modeset only disables
> self-refresh on the CRTCs in the commit, so an eDP on another CRTC stays
> in PSR through dc_commit_streams()
>
> Commit 6ee90e88b976 ("drm/amd/display: PSR eDP p-state warning occurs
> intermittently after unplug DP") added that disable-all for this very
> case. With it gone, turning off or unplugging an HDMI monitor while the
> eDP is in PSR hangs DMUB on a Cezanne laptop (DCN 2.1), on the first
> try:
>
>    dc_dmub_srv_log_diagnostic_data: DMCUB error
>    Error queueing DMUB command: status=2
>
> The eDP then stays frozen until a GPU reset
>
> Do the same through the power module's events. When a CRTC that is or
> was active needs a modeset, raise the PSR and Replay pause events on
> every stream mod_power tracks and wait for self-refresh to exit, before
> amdgpu_dm_mod_power_update_streams() changes the stream set. Clear them
> on the commit's streams after amdgpu_dm_mod_power_setup_streams(), since
> enabling a stream clears psr_feature_enabled until then. Use
> psr_event_pause and replay_event_pause rather than the hw_programming
> events, which a fast update on the eDP can clear in
> amdgpu_dm_enable_self_refresh() while the modeset is still running
>
> Fixes: 3c108046e1d6 ("drm/amd/display: Add power module on Linux")
> Signed-off-by: Hugo Sales <hugo@hsal.es>
> ---
> Tested on an ASUS ROG Flow X13 (Cezanne, DMUB 0x0101002B) with PSR 1 on
> the eDP. That's the only hardware I have, and PSR there needs
> DC_PSR_MASK and "drm/amd/display: Don't require DMUB PSR caps before
> DCN 3.0", which I'm sending next. With this patch, 50 HDMI unplugs in a
> row with the eDP in PSR went through without a DMUB error. The same
> kernel without it hung on the first
>
> Ray, Leo: 3c108046e1d6 doesn't say whether leaving the other CRTCs in
> self-refresh was intended. If newer DMUB firmware copes with an external
> link going away during PSR, I can limit this to DCN 2.1
>
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 101 ++++++++++++++++++
>   1 file changed, 101 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index dfbc384fbbdb4..54eee9e2393fa 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4443,6 +4443,105 @@ STATIC_IFN_KUNIT void dm_clear_writeback(struct amdgpu_display_manager *dm,
>   }
>   EXPORT_IF_KUNIT(dm_clear_writeback);
>   
> +static bool amdgpu_dm_self_refresh_pause_needed(struct drm_atomic_commit *state)
> +{
> +	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> +	struct drm_crtc *crtc;
> +	int i;
> +
> +	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i)
> +		if (drm_atomic_crtc_needs_modeset(new_crtc_state) &&
> +		    (old_crtc_state->active || new_crtc_state->active))
> +			return true;
> +
> +	return false;
> +}
> +
> +static bool amdgpu_dm_is_new_modeset_stream(struct drm_atomic_commit *state,
> +					    const struct dc_stream_state *stream)
> +{
> +	struct drm_crtc_state *new_crtc_state;
> +	struct drm_crtc *crtc;
> +	int i;
> +
> +	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i)
> +		if (drm_atomic_crtc_needs_modeset(new_crtc_state) &&
> +		    to_dm_crtc_state(new_crtc_state)->stream == stream)
> +			return true;
> +
> +	return false;
> +}
> +
> +/*
> + * A modeset CRTC may have no PSR or Replay, such as an HDMI output being
> + * turned off, while an eDP on another CRTC is still in self-refresh. Pause
> + * self-refresh on every stream mod_power tracks before
> + * amdgpu_dm_mod_power_update_streams() changes the set: the old streams of
> + * the CRTCs in the commit and the unchanged streams of the new state.
> + * Unlike hw_programming, which a fast update on another CRTC clears, the
> + * pause holds until amdgpu_dm_resume_self_refresh()
> + */
> +static void amdgpu_dm_pause_self_refresh(struct drm_atomic_commit *state,
> +					 struct amdgpu_display_manager *dm,
> +					 struct dc_state *dc_state)
> +{
> +	struct drm_crtc_state *old_crtc_state;
> +	struct dc_stream_state *stream;
> +	struct drm_crtc *crtc;
> +	int i;
> +
> +	if (!amdgpu_dm_self_refresh_pause_needed(state))
> +		return;
> +
> +	guard(mutex)(&dm->dc_lock);
> +	dc_exit_ips_for_hw_access(dm->dc);
> +
> +	for_each_old_crtc_in_state(state, crtc, old_crtc_state, i) {
> +		stream = to_dm_crtc_state(old_crtc_state)->stream;
> +		if (!old_crtc_state->active || !stream)
> +			continue;
> +
> +		amdgpu_dm_psr_set_event(dm, stream, true, psr_event_pause, true);
> +		amdgpu_dm_replay_set_event(dm, stream, true, replay_event_pause, true);
> +	}
> +
> +	for (i = 0; i < dc_state->stream_count; i++) {
> +		stream = dc_state->streams[i];
> +		if (amdgpu_dm_is_new_modeset_stream(state, stream))
> +			continue;
> +
> +		amdgpu_dm_psr_set_event(dm, stream, true, psr_event_pause, true);
> +		amdgpu_dm_replay_set_event(dm, stream, true, replay_event_pause, true);
> +	}
> +}
> +
> +/*
> + * Ends amdgpu_dm_pause_self_refresh() on the streams of the commit, which
> + * mod_power tracks from amdgpu_dm_mod_power_update_streams() on, even if
> + * dc_commit_streams() failed. mod_power keeps events across
> + * mod_power_replace_stream(), so the replaced streams carry the pause too.
> + * Runs after amdgpu_dm_mod_power_setup_streams(), since enabling a stream
> + * clears psr_feature_enabled and replay_feature_enabled on its link until
> + * then, and the set_event helpers skip a link without them
> + */
> +static void amdgpu_dm_resume_self_refresh(struct drm_atomic_commit *state,
> +					  struct amdgpu_display_manager *dm,
> +					  struct dc_state *dc_state)
> +{
> +	int i;
> +
> +	if (!dc_state || !amdgpu_dm_self_refresh_pause_needed(state))
> +		return;
> +
> +	guard(mutex)(&dm->dc_lock);
> +	for (i = 0; i < dc_state->stream_count; i++) {
> +		amdgpu_dm_psr_set_event(dm, dc_state->streams[i], false,
> +					psr_event_pause, false);
> +		amdgpu_dm_replay_set_event(dm, dc_state->streams[i], false,
> +					   replay_event_pause, false);
> +	}
> +}
> +
>   /**
>    * amdgpu_dm_mod_power_update_streams - update mod_power stream state
>    * @state: the drm atomic state
> @@ -4627,6 +4726,7 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_commit *state,
>   		acrtc->wb_enabled = false;
>   	}
>   
> +	amdgpu_dm_pause_self_refresh(state, dm, dc_state);
>   	amdgpu_dm_mod_power_update_streams(state, dm);
>   
>   	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
> @@ -5370,6 +5470,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
>   	}
>   
>   	amdgpu_dm_mod_power_setup_streams(state, dm);
> +	amdgpu_dm_resume_self_refresh(state, dm, dc_state);
>   
>   	for_each_new_crtc_in_state(state, crtc, new_crtc_state, j)
>   		if (new_crtc_state->async_flip)
>
> base-commit: ba496bb837882eb1af58f41572fc289e46c77b8c
