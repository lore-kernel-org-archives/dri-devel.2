Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF84606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 02:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BXNIb3xJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C1D410E1B3;
	Sat, 31 Oct 2026 02:28:10 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010069.outbound.protection.outlook.com [52.101.85.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8ADE10E0F7;
 Sat, 31 Oct 2026 02:28:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ro+iu97ZyvPGjlySGsZBKEqnBmMrI4UTpu0Cdw9mfSgOoL/FOk8du+xN23acevveytlBJsQMi9ctR4Tg04bRHnRGrfYefkfAJ6zW8Q4bYcBaO3JgvU9O7sefogh/uFzrPtaX5QysE6Y1709KBDcptnn0WLmVdE8RNqYDN5+zQBVZjY22UlEYKq+ZoxCDiNiFUN2we9mwUlWr4rUFHXWQJJ8lYZHPo3qQo4bIYdSsvi+hk5DgwNCUaJfh6OJ7PFPiYdlJ8LpENs1Eeq4npfyOd5n+cGJqENtel+e/6NFIY+/xamIbG/G8tF3+28kDQtgg23kguAI7LDEVvGPh6TRXlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBAFTjMNDOp/3Va4sfRdvFC1k5I/fiPYK9tUAzCqcd4=;
 b=O1M0DXtI9Jyu/2UUyYO/uib2BnrdIv3kqJpUTxxqcgKt3vctPmPZX+IGzD8u0cpVkWoZqvPorzYN/CC2yozczEYY0ZbrccbQDsknkkFrrI1U/AO0aJtORZ5u/nuoxjHPt/ZRhqjoCo/olrE98zGhGR5PY091FJjYSqXvwlCbynVp0YLcg0oHOg2s48W+NdwHrLxJbT6r7aqb0KpOIlMFEB8ExWskkAX3a3iqDpQonel3cAZCIzJXtXClNU6P3ofe4pfHsiLilBgVG3PTDc2o4H3JB1A+HUKmQkcPyaex/jUgpwxU7ZX5sYOciXTJ9lM96vrSwvHmsDt44QTjiXjnqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBAFTjMNDOp/3Va4sfRdvFC1k5I/fiPYK9tUAzCqcd4=;
 b=BXNIb3xJ4ZFUiKUSfiYEa/3ZDtIcrYqAT5VTI5aZOOmwlS9QvcJ2s8AsBFELtyK7yr+HLAhEUq7t4zJTTSJxn743EWfp5MaxsMTSwInu8OL7B69DuQQe8HfczifS6d0NDlaDCY+xBGCccMUpryp9mEQkvOnjcTqeCUJ5vtWQvUI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY0PR12MB226969.namprd12.prod.outlook.com
 (2603:10b6:930:130::18) by BY5PR12MB4066.namprd12.prod.outlook.com
 (2603:10b6:a03:207::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Sat, 31 Oct
 2026 02:28:00 +0000
Received: from CY0PR12MB226969.namprd12.prod.outlook.com
 ([fe80::f47a:5d4e:f3d5:5b26]) by CY0PR12MB226969.namprd12.prod.outlook.com
 ([fe80::f47a:5d4e:f3d5:5b26%4]) with mapi id 15.21.0569.009; Sat, 31 Oct 2026
 02:28:00 +0000
Message-ID: <af7c26a9-b557-429e-979f-5fb6c7acf589@amd.com>
Date: Fri, 30 Oct 2026 20:27:58 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: set allow_freesync before validating
 a new stream
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Alvin Lee <Alvin.Lee2@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Josh Kasten <jkasten@gmail.com>
References: <20261026073345.297491-1-mikhail.v.gavrilov@gmail.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20261026073345.297491-1-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0004.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::9) To CY0PR12MB226969.namprd12.prod.outlook.com
 (2603:10b6:930:130::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY0PR12MB226969:EE_|BY5PR12MB4066:EE_
X-MS-Office365-Filtering-Correlation-Id: 37ae3a47-e8a2-4f0c-6cb3-08df36f69519
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|11063799006|6133799003|261028144727099003|261009223027099003|261022075727099003|261022105027099003|56012099006|261021121427099003|261026140227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: l4rHRqBfkmtk3mNyJIH+LjxdYdfBHABchYYYZ7b01mw4BDK0SElipkp/5+o8w9NMZARvQWGnVv/+NVa6L1I74A6g67gHB7KOKOkarwERcaREYDqZkCqx+8oky/HMXYYclO8VN+fLrdMNPzEGoSrMfV27H2ok7D5SFe98T7p2AwqTohVzM3ha180ilNz3Q/ihoK+OKwLJPEjnvGsDSjNLzm6uXDRbk/X7AnP9ZBkuO9M2e1kFOQmPQ8ggkcAtw5oyUe2HVE9WGRgoosLX3nIe0Upb4EhQsogT5ym6TEJyDs4WnvtizImdGvHDXxnQnrjpgtcy8f8A/NDBew0yb3Lf79cyjBlSJ9sy/kgckhPMf89ikD+c+30pB3Zh71aNZNdpF4jp7y/IZ++vRcNMU+C+rAd8FY0PjVYit3g40ZsCefsLFyIoDSD6g/GWzM2KcLogjPeLFDwp9XCC3iJdgvg9KmtasktXJ7kGqd5Xp5Urej5LwtL4bN1ASTgWVaV4q7tkXJmZn2/tGXlWZf/gXi7UwvWtfZSZyvz2Mw2aZGN7OHI+MsU9dJNmZ9+cmmB5gvNkJBinfZWDh5jdzxOaDXBkthQ4PupK41bcITcGu/b/vgY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY0PR12MB226969.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(11063799006)(6133799003)(261028144727099003)(261009223027099003)(261022075727099003)(261022105027099003)(56012099006)(261021121427099003)(261026140227099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmNiVDRtZU0wcnpIa3lmclNyeVB5VEQ5RVNiMzlDaWRaS0tramsvYUp6ekxU?=
 =?utf-8?B?c2JabkpUZ29DaURJTmZoeGlJNjN5RjV6ZVduV2tvanJaWkpmeCt0MkhhTzZq?=
 =?utf-8?B?QlRCcmd5eVloVEdWRngvN2JRcDJEUVpRSmt2L2xGWURsckJPSFRVV1lvN2JY?=
 =?utf-8?B?UnZhalpJZmhUSnFuWDFvQzhCOVpSM1luOHNJK3hKQXZ5K2hKVmdNY1lwVytX?=
 =?utf-8?B?NnBEZXZjamVMNnYrNW5QdWhWemRxaHlENjh0TmpJa2ZlYTVBM2FxTXc3OVhl?=
 =?utf-8?B?NkVIUFhkZ0RNcGVIZTdGcEE5ZDk3RXhGRGVpclVoV0tzSkk5ckE0dU9CRTU2?=
 =?utf-8?B?YjAyK1ZyUnhhTkVSNExQU0VWMzlFeS9QZDB3YXI0bVlNaE83d21TTVFjbVd2?=
 =?utf-8?B?cE9uYkxFVHE0Z3NJM0ZmMzFERE9zRHZ5ZHEvekFzQllrWE5GYzR1Z3pxVGho?=
 =?utf-8?B?Q2o2YThRT29XOCtnQUo5VldrKzRoSk93enc1VGJqTUxPU0FyWTFiZHl3d3N6?=
 =?utf-8?B?WnhMWHBVRU5Iem1nQzBYekEzTmh0Szd3bytPMnA3bVdQcGwwRTY1VmZGL0Z2?=
 =?utf-8?B?UDZJNU1YeEhFVExZaFhFU20rZzg0aEh1ZWpNbGdlS2JianNBaTZiN1hBdVp1?=
 =?utf-8?B?NzVHbjhHeUtzazRoMXloOWxDaCthbWxROS9od2xJVVVNSy9Wc3FvSXc5ZmZI?=
 =?utf-8?B?WDdUc1k1bGFiNE9rYXo2aHNVYktqWWhXWVVZb1MxUDc4MlU3TE5XSUlIMGR0?=
 =?utf-8?B?NW5jWStQaXRTdkloNGdZdk90NzFEZnpYRkFwL1lGc0ZLK29SSXc1T2RaUzli?=
 =?utf-8?B?eElHaWp3MlByOEVPQXppRmE1VitYUWl6SmZxQWtrR0VYT1hvd3RmdlE1SlJX?=
 =?utf-8?B?elUwcGhFVTdhOTczdUxqRENmTTYyYnY0VmUza1ZhWlRTczdnWmFHNGNBWGVk?=
 =?utf-8?B?aHlueFdzNmtjWlNNSDVFYUNIOGxQZVcyem9lenZLNW9HWjJzNzU1Z2NNbFhW?=
 =?utf-8?B?Y3AraHlPdVd2V1V4NURjaHh3VXlVT0ZybFF3eU83d05OY1dnVWZ1WjZYRWUx?=
 =?utf-8?B?MHVtNzhGOWNwV3B0NkFSMm9yTXcvT20yYmZkQ3BCR1VUNWlsSFhLaFZORFZj?=
 =?utf-8?B?dVVJNnlxaTVuV1ZMd0tOMzlWOUtRR2FWM0FkSEdHYzhDUysyalpibTB5NXpR?=
 =?utf-8?B?dGloQlpuS3RLcEpjTGhpdDA0WmpYWmplQ3lGbmhrTEVCYnhWQTcyek5INmtx?=
 =?utf-8?B?Y1FRZkYzZnI0Wm8vZjVERlZXUENlSS8wZklqT3FTNTl5eXpTOUJ5MERxQ1pn?=
 =?utf-8?B?dXlyR2pPUnArd2c0K1AwQTMzTnFLT29kY0ZabEZtblZVeGZnTU5pbXpzeGR2?=
 =?utf-8?B?SUdlY1FobVNWSGNDN015Ykk0N25QMnV4SEozR05rdG1JN3laUDNSbitTVFp6?=
 =?utf-8?B?enFvMXMvVzhhUy9rNVFseU41UzFpcUo2YWp1a3VyQThscWVPRnZGQmlRYU9w?=
 =?utf-8?B?L2hBV0xDZmpsV3NsYkY4M2s1Nm12RXlkbkNhQ1lnRnNtbHd6RkhJVFZoODhi?=
 =?utf-8?B?R0pMMzdVbGcwWC9oY3lubkNQM1g4bjVSbS85RjhzTWdTU0d1d3hvZ0hKazJC?=
 =?utf-8?B?TElaSzFURHR6bk5Qa3RzdFpKcEFEVVg1K0h1QU9WQUl1Y212a1hDL1ZQbzB3?=
 =?utf-8?B?eGthRkE5dkF3bGpGVjFEODU4TUcxVUg5Wno4MGprVXdwbGZpUHFVQzY1clJu?=
 =?utf-8?B?MGVQNjIxNmhiQmdYQ20rUEprUVYrOG5IdHl1WkVVT2lKaWgrOXp4Z1JpTy9x?=
 =?utf-8?B?Z2YvRUw0cDVJZDAvL1hIeWQ2MFJSMEludzRpS2wzSTFxK1d3Z0l6OENZejZQ?=
 =?utf-8?B?SG43alRTaEtyaWlhYjV5WjdaMmF3c2dTUU95WWNyMjhKb01NWjQvTUhTYjZE?=
 =?utf-8?B?UGlna1RyNUMxcmdXN29CRTBEZ3VuQ1Buc2U2ektjcEJZYkRUUDM1cVdMMEsy?=
 =?utf-8?B?VFl1NFpobm1YRURhRkY0ZDQ2RnVwNFl6ek5jUHVzaWtGRlYvOElZVVNyMzFj?=
 =?utf-8?B?K1N3bFowd3FlQ0FrZ0RNaE5lei9NNWFwZk9XN1FpSlBvbnVSNG1uMUhlazlL?=
 =?utf-8?B?WVRaWHpSQ3RrcW1Id3NGdG9uazBTWERlZGV1NVFRRm9wNE9Cc3N6Sm1sM0Yv?=
 =?utf-8?B?eUR4SHk3aGMyYXhLZEtnSUFzaVRISmJETG1DY0xSUXBnOTEzd01YcEFyenhu?=
 =?utf-8?B?MHcxcGszTTVObUR2Yk5Mc1l3UEIwRm1SdHR5WGFJczhWSHFWeWhvdTh1QjVH?=
 =?utf-8?Q?i5+Yi58+pjKu26+J90?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ae3a47-e8a2-4f0c-6cb3-08df36f69519
X-MS-Exchange-CrossTenant-AuthSource: CY0PR12MB226969.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 02:28:00.2556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yIBSmXgeW6YuTnd3QZ9UuZ3/5wBw08p+bu6mBeVqV2YNyE4gMiI4ELlkMyr4FBC62vMY3xtA0zmjfiGFAig+FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4066
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 10/26/26 01:33, Mikhail Gavrilov wrote:
> After resume from S3, DC enables SubVP on a single FreeSync display at
> a high refresh rate, although dcn32_allow_subvp_high_refresh_rate() is
> meant to keep SubVP off that configuration ("For single display cases,
> freesync must be disabled").  On an RX 7900 XTX driving a FreeSync TV
> at 3840x2160@120, amdgpu_dm_capabilities reports sub-viewport disabled
> after boot and enabled after "rtcwake -m mem", and the memory clock
> starts switching.  It stays that way until a later commit re-validates
> the state; a CRTC gamma change (toggling Night Light) turns SubVP off
> again.
> 
> The policy reads dc_stream_state::allow_freesync while the new state
> is validated, but amdgpu_dm sets that field only in
> amdgpu_dm_update_freesync_state_on_stream(), on the first flip after
> the commit.  A stream created by a modeset is therefore validated as
> if FreeSync were off.  On resume, dm_destroy_cached_state() drops the
> streams and forces a modeset, so the resumed state is validated
> without FreeSync.
> 
> Set allow_freesync in amdgpu_dm_get_freesync_config_for_crtc(), which
> atomic check calls for every active CRTC and which already writes
> ignore_msa_timing_param to the stream.  It uses vrr_supported, the
> condition the flip-time value is derived from.  With this change the
> same TV keeps SubVP disabled across "rtcwake -m mem".
> 
> On this machine SubVP is also what exposes the single-frame scanout
> corruption reported in the thread linked below, so the FreeSync
> setting stopped working as a workaround after every suspend.
> 
> Fixes: 87f0c16e0eeb ("drm/amd/display: Enable SubVP for high refresh rate displays")
> Link: https://lore.kernel.org/all/20260829010525.29935-1-mikhail.v.gavrilov@gmail.com/
> Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5714#note_3736349
> Tested-by: Josh Kasten <jkasten@gmail.com>
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> ---
> v2:
>   - Rebased onto amd-staging-drm-next, where vrr_supported also depends
>     on vrr_timing_valid, so v1 no longer applied there.  No functional
>     change.
>   - Added Tested-by from Josh Kasten, who ran v2 on next-20261023 (the
>     file is the same there as in amd-staging-drm-next) and saw SubVP
>     stay disabled across rtcwake with FreeSync enabled.
>   
> v1: https://lore.kernel.org/all/20261018221726.27259-1-mikhail.v.gavrilov@gmail.com/
> 
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c    | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
> index 386ba88c57c6..936a899aef00 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
> @@ -170,6 +170,14 @@ void amdgpu_dm_get_freesync_config_for_crtc(
>   					vrefresh <= aconnector->max_vfreq &&
>   					vrr_timing_valid;
>   
> +	/*
> +	 * DC reads allow_freesync while validating the new state, for example
> +	 * to keep SubVP off a single FreeSync display, but it is otherwise set
> +	 * only on the first flip after the commit.  Set it here, so that a
> +	 * stream created by this commit is not validated without it.
> +	 */
> +	new_crtc_state->stream->allow_freesync = new_crtc_state->vrr_supported;
> +
>   	if (new_crtc_state->vrr_supported) {
>   		new_crtc_state->stream->ignore_msa_timing_param = true;
>   		fs_vid_mode = new_crtc_state->freesync_config.state == VRR_STATE_ACTIVE_FIXED;

