Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74382606A32D
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 21:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lT+o72K6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A64751124C4;
	Thu,  5 Nov 2026 21:45:48 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011001.outbound.protection.outlook.com [40.107.208.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC1071124C0;
 Thu,  5 Nov 2026 21:45:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIQ8maOM2XYQMdEkeuULnFIGOXcI5LXZ10+/YNhgdMg01a6BS9o2KnGgCWRhq0DHdjlJE3OI2OEuxwUlEfjgHbB5moinLouq55+cGBYVDceB2xbw/nuhsNxEL2Mc3FF1nEAk7MEa4ZWtFp7LIypkotFDTugnmgbDpfwf/fcOQFQLCkjrz+/iF549w/5+8QwdcoNIv62JaTVhB/7vLKWok+/taGG7g5XNxiHs6PMGs25YdpwnyyolImQm/ZT1AvhR+pJhTW8yTJZuIWXrL3hG/6EfBxx5cza4ZJGuMkM2Y6llLNrBaIzpkaA6aN27flhEM3uNVy7vgDRYTsKB5yUPFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0+3v4W6wkQWh5QYh+XIp7YzkS3NRvXW9BklPZYqiA4=;
 b=R74SegB233dtR2ObHaf2IW/g2Za7/k+hwdDS8TAgDZnbGQ4/GEWebhYtweQ0c8WODECKtB0+wftTmDfWuncI1L5rCgyXDuktUAjp2iCv+La+nrM1eRnGfylZ6sv57MDT4OEE3OpXphQvNWnjeN+1zV5QCSMXQhbyYBAOYOc4NnRQT+omB2u7Xr7u9llAM7CjcEDhBuIGXIMpZjAWIsTjgBN0o/1111AeSq6nzMi+m5mxPiiHaj0JXV4Bjo74GUhcHIo8yrddVxBWm6WhTNYSbEGCcP2CjBScsnYe8OMNYLthZlD/W0hRuu9T/uWjoef4ecZuAeOtEAfL35lDspNVLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0+3v4W6wkQWh5QYh+XIp7YzkS3NRvXW9BklPZYqiA4=;
 b=lT+o72K6Qs6lzJ2WKAmf/jRBHNXHn7rEaoDl0ZC5jfF/H9m8zYWhWNe03qqrYQ5Y/qXAUsVi7QfqI4dZwErZ5JZdn15jZBxnKzSdjIqGa1CpWIVPBzLYWypAVu4YpPymYM3iHHif/MH8C89jLFo7ErabFVIr/bNiOEnz9L4sN60=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB8705.namprd12.prod.outlook.com (2603:10b6:303:24c::18)
 by DM4PR12MB5724.namprd12.prod.outlook.com (2603:10b6:8:5f::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.10; Thu, 5 Nov 2026 21:45:35 +0000
Received: from MW6PR12MB8705.namprd12.prod.outlook.com
 ([fe80::e75b:745c:ed13:f321]) by MW6PR12MB8705.namprd12.prod.outlook.com
 ([fe80::e75b:745c:ed13:f321%4]) with mapi id 15.21.0592.007; Thu, 5 Nov 2026
 21:45:35 +0000
Message-ID: <7aec0ed4-1a4d-446b-8971-580770e3de09@amd.com>
Date: Thu, 5 Nov 2026 15:45:32 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: use atomic commit for panel power savings
To: shivamkalra98@zohomail.in, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, David Weber <weber.aulendorf@gmail.com>,
 Wayne Lin <Wayne.Lin@amd.com>
References: <20261031-abm-sysfs-atomic-v1-1-a99068f3b49c@zohomail.in>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20261031-abm-sysfs-atomic-v1-1-a99068f3b49c@zohomail.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::19) To MW6PR12MB8705.namprd12.prod.outlook.com
 (2603:10b6:303:24c::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8705:EE_|DM4PR12MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f69ee0d-0dda-430f-72dd-08df3b861f67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|921020|261022075727099003|261022113327099003|261022105027099003|56012099006|5023799004|11063799006|261026140227099003|261009223027099003|261021121427099003|261026121527099003|261009221227099003|261021123027099003|261102130727099003|261102123227099003|261028144727099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: s0kDjY6yYW786Yw7L5VKex4yILHFhVSf+9j99hCxtfFbCtVMi5yaR0ylrenixtR7RROibtk3vbcRgjvtc+naD4sjlXprZQV8ODHOsLlqwGqwgJSsI/CJj7fzWYOyCvK5QQyBedkjasLCpEtdjBxF9MeKYCW7HAOCxoHkiCDM08BcXj8TOTDMt5NtM8/YqBicb9UsTp0sWGdb1Rkxo+eS7o0ZsOxLJ8FwCkhddSInGFjDWgBQg7gE7JTIYvkQ3Awgv88IJrj52kqqOQgmlRAJqvdlH7tYZ049R7D9Pc7CwHKRrOB6BEs/09GJBdsZQTTSZ/b1FIm7qjXeNhAF6RcUf52QJO02m+SmN2S/RX4EuQAtWhDqQ36MtY+f+Vs3U2ChW0msL/3uCp0QrOoc9KbsFhixoMcGW9WRWdo+ZsgLUFR/b/fHltuh77AvfzHKBuuTEefuWupmlMX1Je1bMlK1klvM7f3RRmw2dGieChIloBKutnkuTJ2PSLJKw2XyVwa9Qvcvo5n1KZQGB2AgrEwMavvzzh/vwJqXbo2OoMJRyc3mzNvXZ8+LNgTrsdcIz8LvnN6R9zKz4aZ73ZixLzEuHTFG/ZvlzWL1MOd0s9d+PLu//5xafzn+/sxKmjgaWI72vvV+VHmiv1LI2TC5cr3hOsIN59wRP1w4CxCaihsmw3Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8705.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(921020)(261022075727099003)(261022113327099003)(261022105027099003)(56012099006)(5023799004)(11063799006)(261026140227099003)(261009223027099003)(261021121427099003)(261026121527099003)(261009221227099003)(261021123027099003)(261102130727099003)(261102123227099003)(261028144727099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmlxalRUemE3cy9DemJXRVRBT1RwaTJUbmU3Qnh6ZEdNNnlDR1R3a2xlRkRI?=
 =?utf-8?B?WGN4Tlp6WGVHNlNNVXF6cGh5ejdFTE9pUTlOMEtTSWhvRm1Qa3JheTBnbXND?=
 =?utf-8?B?VnpEWmE5OVkyd0t1Q3NtaTVTNmNvS0Z4aEVLVGhrT2VOVnNQdXM1QUJJcFgr?=
 =?utf-8?B?WGtQdHowSkx5UGhsalVGVDd4WFZWTzRCMnpwUjJvS3UvUHhacnVlekpWSFN1?=
 =?utf-8?B?clFaSmpjVW85a0Q2NmttekJMOWdHZzlOODMwSFF6ZDNGOGlPNldJUTdFNnRJ?=
 =?utf-8?B?OHpmY1hQU2RxUStpNjgwMWtjSnd0dVFUYkFGazFZYllCM2FUZXpmaVcyYzM0?=
 =?utf-8?B?WlF5WldCMDVhSUErYWYwbEN1cUdwVzR4ek9KVjhGRE04QnlZMjRVVHRvWkRM?=
 =?utf-8?B?WTRUd2pqdGN3eEttbThTMDhZNExjRHp6N2VrVTNreTc3cEgyeHJ3ekNOV3ZG?=
 =?utf-8?B?cWlaUUNEZk42eFQ5RG1hQWMvbjdROG5MWEhGZmFtNWUyTjhjZGxZdjdLZHpz?=
 =?utf-8?B?elYyWk8vdWpHcE5vZ0s5U3FkRE4rRExGOWRNUTRBZVZINWhSV3VHR0VETGVP?=
 =?utf-8?B?STVXdnBHaDhEVm5UQU1SbGRuakNSSStteG9EUkkzZTc4c3EvV2xwYlBPa0dv?=
 =?utf-8?B?RGR3YWNFalZpVjFZaVJsYmJRWVRLYlR4STI2b2lQNk1RRFdRalRzWDBQVjRY?=
 =?utf-8?B?MkQrT0kwbFRXaUJLZlg4cmtNa043THkzVnJlcDJDUVdNeHp6QVpnNFVuRjB0?=
 =?utf-8?B?SzdGVm8zOERUZERleEI5VXBaOHF4WkFaYTdQR2xESW0vRFgweWl4SGh5c2NP?=
 =?utf-8?B?TWdzaXRWTzZTYzlmSXpzWE4xV0hLOEZlYVBZcW9KWkhHQkgwZE1DREF2Z3lW?=
 =?utf-8?B?YU82dGxPcWlmSW1URjNpaitYQnUvWkEvTVUwM3dmYzNnWXdRZTY2ZzRBN1ZN?=
 =?utf-8?B?R08ySERUTkkxSldTRURjZGpjRklnTUZXdVNpV01RSXZ1eXpWNlpUVFpnNkRX?=
 =?utf-8?B?SW9RWG5nRm9LWmVtMlE4S2dRY0MrSDRaWTlqSVNzZzBmQitvc3ZuaE1ya2cy?=
 =?utf-8?B?ZUxHbUJiWTFFMXVpRUx2aXZpMjdYeU9IZ2RiNE9GMDFpMXpJVm1FdXRNaElt?=
 =?utf-8?B?REN5ZlJXb29tQjIzYVBRYWYzYlR6M0RhQ2xXV0J1MVkwVG8xMi9WVUN5aTlo?=
 =?utf-8?B?TFhGbVo2N0xWS1V3WmRoMHFaV0ZyOWVzSWl5QnErN1hPbVgvRFhoTldRQ25S?=
 =?utf-8?B?VzFwWFFaOVFXY0NXSk9IVzlaeU42T3VpSmUxL0RUUVlueHJXNThlVks4UXVL?=
 =?utf-8?B?ZVpSTFZJV05CMDMwK2RIR0FxVjhIbGhta1ZOa3IzSkNoSnZuMWhIZ2hsL1JI?=
 =?utf-8?B?azZyUjMveHFPdXEvZXkrdzJTczB0MDVOeDFFRmUxbVRHNGl3NzBnb0tmNUpa?=
 =?utf-8?B?WitZSVRiOGxuN2ZBaGE2bHV0RC9zcVA5dTYrWWVLOHB2SmZBVUNncWlGSFhW?=
 =?utf-8?B?cGJiSE81clMwcGEvQVJ5cFU2T2swL0ZIQlBJK2lVM2tCYVR2OUZWZXVlTFZr?=
 =?utf-8?B?QitzODMvWUJHWEtIdGhmbjNReW5MNmZHSFd4WkwzOWpiNSthVDlKL2hoTVB1?=
 =?utf-8?B?SDM0akd2UklGeWxJa0NtUytUU3gwY1Y2TVdnZTNTeThickxjVTJmZjBnSHVC?=
 =?utf-8?B?RkJaazdyQXFYT25Ndjd2UFNFN3lzc0gzQWw0bWpWbUd3cFIzem5EaGFBeWF1?=
 =?utf-8?B?RTI2dzZCUWJ6R0k2MkZZSDg2bC9qOVpTb241TlFGeTdteGRpdGtPdHBCR2xx?=
 =?utf-8?B?MllJWGtxSHByR1o4Rmk5TzlybFF1UkN5Q1U0VUpzQnNjeFg4TjJQdEgrcGlo?=
 =?utf-8?B?RWF2ZHJpa2VGS0VXYmdZdjB3ZGdjeGY3VHQ4SndLczhiT0NWcSt2Y2pFVzN5?=
 =?utf-8?B?Zms0UjVjUEQrY0dEemVWTHgrcStxSG1jOG9uV0p4NWk1UWdKc1p5T0F3dVJj?=
 =?utf-8?B?S1RCWi94OWFkOGhHSWtZd0FVUHRLL0pHZ2EzcG5Hb2VCSUx0dUlweERnZ2Jn?=
 =?utf-8?B?dVMyTnVlaUYyL3pmYjVOZm8zM0xYRXhaWGhxTDBlTHRaWmI0SDBBRGJqakl3?=
 =?utf-8?B?SmZhOXZTTzV2M013c0pNOVhGbzEyUVEvRHR6Z2JYdDBmdkNMb091dVBZNGls?=
 =?utf-8?B?NktWM21XR25reXpUc0E2c3ZaM1lsOFgrTW1aQk9KQTRkT0ZYaDJmSWJSQXVV?=
 =?utf-8?B?TVpUNlhCeGp5OUFRdlBHNDZMc1RKT0hwZVNiK3JFa3JUR3dLM1RzM1F4VktJ?=
 =?utf-8?Q?ahAML7J//Alhmm/FIa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f69ee0d-0dda-430f-72dd-08df3b861f67
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 21:45:35.1986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: py0ek8+JYhm5wpocZafJr8mLB921MRA+hGDrF9oIouAQgtVGT5OUc0gFYhdxHg8c2q0r75cp/h2LTQ6P9R7L1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5724
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



On 10/30/26 15:58, Shivam Kalra via B4 Relay wrote:
> [Some people who received this message don't often get email from devnull+shivamkalra98.zohomail.in@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> From: Shivam Kalra <shivamkalra98@zohomail.in>
> 
> panel_power_savings_store() mutates connector->state directly and sends a
> hotplug event. This bypasses atomic commit handling, so the new ABM level
> is only applied when userspace happens to perform another modeset, and it
> races with concurrent commits.
> 
> Build an atomic state, set the level on the connector state and commit it.
> If the connector is not attached to a CRTC, keep the level in the current
> state so the next modeset picks it up, as before.
> 
> A previous attempt to avoid the modeset by calling into DMUB directly was
> reverted because it broke the abm_gradual IGT test (8d20a066fa9b,
> 95aaa207e9ef). This version instead uses the normal atomic stream update
> path.
> 
> Expose the atomic state update helper for KUnit and extend the tests to
> cover the atomic update and the inactive sysfs path.
> 
> Fixes: 63d0b87213a0 ("drm/amd/display: add panel_power_savings sysfs entry to eDP connectors")
> Signed-off-by: Shivam Kalra <shivamkalra98@zohomail.in>
> ---
> Note: This patch works standalone (applying ABM changes via a modeset), and
> pairs cleanly with David Weber's unmerged series [1] ("drm/amd/display: Skip
> connector updates without a stream" and "drm/amd/display: Avoid modeset for
> ABM changes") to allow non-modeset ABM updates via the stream update path.
> 

Hi Shivam,

Thanks for the patch. Moving this to an atomic commit is the right 
direction, but as it stands every write still ends in a full modeset.

In amdgpu_dm_atomic_check(), any abm_level difference between the old 
and new connector state sets new_crtc_state->connectors_changed = true. 
That makes drm_atomic_crtc_needs_modeset() true, and commit_tail skips 
the abm_changed / stream_update.abm_level fast path. Users would see a 
blank/flicker on the eDP panel on every power-profile change.

Could you try keeping drm_atomic_get_crtc_state() and setting 
connectors_changed only for scaling? ABM would then go through the 
existing stream update with no modeset, like David's [PATCH 2/2] 
drm/amd/display: Avoid modeset for ABM changes - 
https://lore.kernel.org/amd-gfx/20260813112634.11455-3-weber.aulendorf@gmail.com/

Please run IGT amd_abm, including abm_gradual, before v2.

Also see inline comments.

> [1] https://lore.kernel.org/amd-gfx/20260813112634.11455-1-weber.aulendorf@gmail.com/
> 
> Testing:
> - KUnit: the amdgpu_dm_backlight suite passes on amd-staging-drm-next
>    (75/75 tests passed), covering the new atomic update and inactive sysfs
>    tests.
> - Hardware: tested on a 7.1.13-based kernel backport alongside [1]. Before
>    the patch, the store called drm_kms_helper_hotplug_event(), produced two
>    HOTPLUG=1 uevents (triggering 36 GetConnector probes / 20.8 ms stall in
>    Xorg), and the backlight PWM sweep stayed flat at 6998 for levels 0..4.
>    With the patch, ftrace shows panel_power_savings_store() ->
>    drm_atomic_commit() -> amdgpu_dm_atomic_commit_tail() ->
>    dc_update_planes_and_stream() -> dmub_abm_set_level_ex(), with no hotplug
>    event or connector reprobe. The PWM sweep tracks the requested level
>    (11130, 8304, 5782, 3815 and 2782 target for levels 0..4; 75% target
>    reduction at level 4, 73.8% measured).
> ---
>   .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    | 85 ++++++++++++++++---
>   .../amd/display/amdgpu_dm/amdgpu_dm_backlight.h    |  3 +
>   .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     | 95 +++++++++++++++++++++-
>   3 files changed, 172 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> index 27546febf90d..f8d797324319 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> @@ -712,6 +712,31 @@ ssize_t panel_power_savings_show(struct device *device,
>   }
>   EXPORT_IF_KUNIT(panel_power_savings_show);
> 
> +static int
> +panel_power_savings_set_level(struct dm_connector_state *dm_conn_state, long val)
> +{
> +       if (dm_conn_state->abm_sysfs_forbidden)
> +               return -EBUSY;
> +
> +       dm_conn_state->abm_level = val ?: ABM_LEVEL_IMMEDIATE_DISABLE;
> +
> +       return 0;
> +}
> +
> +STATIC_IFN_KUNIT int
> +panel_power_savings_update_state(struct drm_atomic_commit *state,
> +                                struct drm_connector *connector, long val)
> +{
> +       struct drm_connector_state *conn_state;
> +
> +       conn_state = drm_atomic_get_connector_state(state, connector);
> +       if (IS_ERR(conn_state))
> +               return PTR_ERR(conn_state);
> +
> +       return panel_power_savings_set_level(to_dm_connector_state(conn_state), val);
> +}
> +EXPORT_IF_KUNIT(panel_power_savings_update_state);
> +
>   STATIC_IFN_KUNIT
>   ssize_t panel_power_savings_store(struct device *device,
>                                   struct device_attribute *attr,
> @@ -719,6 +744,9 @@ ssize_t panel_power_savings_store(struct device *device,
>   {
>          struct drm_connector *connector = dev_get_drvdata(device);
>          struct drm_device *dev = connector->dev;
> +       struct drm_modeset_acquire_ctx ctx;
> +       struct drm_connector_state *conn_state;
> +       struct drm_atomic_commit *state;
>          long val;
>          int ret;
> 
> @@ -730,20 +758,57 @@ ssize_t panel_power_savings_store(struct device *device,
>          if (val < 0 || val > 4)
>                  return -EINVAL;
> 
> -       drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
> -       if (to_dm_connector_state(connector->state)->abm_sysfs_forbidden)
> -               ret = -EBUSY;
> -       else
> -               to_dm_connector_state(connector->state)->abm_level = val ?:
> -                       ABM_LEVEL_IMMEDIATE_DISABLE;
> -       drm_modeset_unlock(&dev->mode_config.connection_mutex);
> +       drm_modeset_acquire_init(&ctx, 0);

Please use drm_modeset_acquire_init(&ctx, 
DRM_MODESET_ACQUIRE_INTERRUPTIBLE). With 0, the sysfs write can't be 
interrupted while it waits for the modeset locks.

> +       state = drm_atomic_commit_alloc(dev);
> +       if (!state) {
> +               ret = -ENOMEM;
> +               goto out_ctx;
> +       }
> +       state->acquire_ctx = &ctx;
> 
> +retry:
> +       ret = panel_power_savings_update_state(state, connector, val);

nitpick - panel_power_savings_update_state is used once; it can be 
folded here.

> +       if (ret == -EDEADLK)
> +               goto backoff;
>          if (ret)
> -               return ret;
> +               goto out_state;
> +
> +       conn_state = drm_atomic_get_new_connector_state(state, connector);

drm_atomic_get_new_connector_state() only reads back that same slot as 
in panel_power_savings_update_state, so the below check is likely not needed

> +       if (!conn_state) {
> +               ret = -EINVAL;
> +               goto out_state;
> +       }


> +
> +       /*
> +        * Without a CRTC there is no stream to update and nothing to commit.
> +        * Keep the level in the current state so the next modeset picks it
> +        * up, matching the behavior of the sysfs interface.
> +        */
> +       if (!conn_state->crtc) {
> +               to_dm_connector_state(connector->state)->abm_level =
> +                       to_dm_connector_state(conn_state)->abm_level;
> +               goto out_state;
> +       }
> +
> +       ret = drm_atomic_commit(state);
> +       if (ret == -EDEADLK)
> +               goto backoff;
> +
> +out_state:
> +       drm_atomic_commit_put(state);
> +out_ctx:
> +       drm_modeset_drop_locks(&ctx);
> +       drm_modeset_acquire_fini(&ctx);
> +
> +       return ret ? ret : count;
> 
> -       drm_kms_helper_hotplug_event(dev);
> +backoff:
> +       drm_atomic_commit_clear(state);
> +       ret = drm_modeset_backoff(&ctx);
> +       if (!ret)
> +               goto retry;
> 
> -       return count;
> +       goto out_state;
>   }
>   EXPORT_IF_KUNIT(panel_power_savings_store);
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
> index 9ad888d3ae7b..d92ec0789f15 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
> @@ -34,6 +34,7 @@ struct device;
>   struct device_attribute;
>   struct drm_connector;
>   struct attribute_group;
> +struct drm_atomic_commit;
> 
>   #define AMDGPU_DM_DEFAULT_MIN_BACKLIGHT 12
>   #define AMDGPU_DM_DEFAULT_MAX_BACKLIGHT 255
> @@ -65,6 +66,8 @@ ssize_t panel_power_savings_show(struct device *device,
>   ssize_t panel_power_savings_store(struct device *device,
>                                   struct device_attribute *attr,
>                                   const char *buf, size_t count);
> +int panel_power_savings_update_state(struct drm_atomic_commit *state,
> +                                    struct drm_connector *connector, long val);
>   int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
>                           unsigned int *min, unsigned int *max);
>   void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
> index c6d15fb8ad98..a482261e85d2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
> @@ -514,6 +514,37 @@ static void dm_test_register_backlight_device_success(struct kunit *test)
>                          adev->dm.backlight_dev[0]), 0);
>   }
> 
> +static struct drm_connector_state *
> +dm_test_panel_power_savings_duplicate_state(struct drm_connector *connector)
> +{
> +       struct dm_connector_state *state;
> +
> +       state = kmemdup(to_dm_connector_state(connector->state),
> +                       sizeof(*state), GFP_KERNEL);
> +       if (!state)
> +               return NULL;
> +
> +       __drm_atomic_helper_connector_duplicate_state(connector, &state->base);
> +
> +       return &state->base;
> +}
> +
> +static void
> +dm_test_panel_power_savings_destroy_state(struct drm_connector *connector,
> +                                         struct drm_connector_state *state)
> +{
> +       __drm_atomic_helper_connector_destroy_state(state);
> +       kfree(to_dm_connector_state(state));
> +}
> +
> +static const struct drm_connector_funcs dm_test_panel_power_savings_connector_funcs = {
> +       .atomic_duplicate_state = dm_test_panel_power_savings_duplicate_state,
> +       .atomic_destroy_state = dm_test_panel_power_savings_destroy_state,
> +};
> +
> +static const struct drm_mode_config_funcs dm_test_panel_power_savings_mode_funcs = {
> +};
> +
>   static struct drm_connector *setup_panel_power_savings_connector(struct kunit *test,
>                                                           struct device **device_out,
>                                                           struct dm_connector_state **state_out)
> @@ -527,6 +558,7 @@ static struct drm_connector *setup_panel_power_savings_connector(struct kunit *t
>          adev = dm_kunit_alloc_adev(test);
>          ret = drmm_mode_config_init(&adev->ddev);
>          KUNIT_ASSERT_EQ(test, ret, 0);
> +       adev->ddev.mode_config.funcs = &dm_test_panel_power_savings_mode_funcs;
> 
>          connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
>          device = kunit_kzalloc(test, sizeof(*device), GFP_KERNEL);
> @@ -536,7 +568,11 @@ static struct drm_connector *setup_panel_power_savings_connector(struct kunit *t
>          KUNIT_ASSERT_NOT_NULL(test, state);
> 
>          connector->dev = &adev->ddev;
> +       connector->funcs = &dm_test_panel_power_savings_connector_funcs;
> +       connector->index = 0;
> +       kref_init(&connector->base.refcount);
>          connector->state = &state->base;
> +       state->base.connector = connector;
>          dev_set_drvdata(device, connector);
>          *device_out = device;
>          *state_out = state;
> @@ -614,10 +650,40 @@ static void dm_test_panel_power_savings_store_sets_disable(struct kunit *test)
>          setup_panel_power_savings_connector(test, &device, &state);
> 
>          KUNIT_EXPECT_EQ(test, panel_power_savings_store(device, NULL, "0", count),
> -                        (ssize_t)count);
> +                       (ssize_t)count);
>          KUNIT_EXPECT_EQ(test, state->abm_level, ABM_LEVEL_IMMEDIATE_DISABLE);
>   }
> 
> +static void dm_test_panel_power_savings_update_state_sets_disable(struct kunit *test)
> +{
> +       struct drm_modeset_acquire_ctx ctx;
> +       struct drm_connector_state *conn_state;
> +       struct drm_atomic_commit *atomic;
> +       struct dm_connector_state *state;
> +       struct drm_connector *connector;
> +       struct device *device;
> +       int ret;
> +
> +       connector = setup_panel_power_savings_connector(test, &device, &state);
> +       atomic = drm_atomic_commit_alloc(connector->dev);
> +       KUNIT_ASSERT_NOT_NULL(test, atomic);
> +
> +       drm_modeset_acquire_init(&ctx, 0);
> +       atomic->acquire_ctx = &ctx;
> +
> +       ret = panel_power_savings_update_state(atomic, connector, 0);
> +       KUNIT_EXPECT_EQ(test, ret, 0);
> +
> +       conn_state = drm_atomic_get_new_connector_state(atomic, connector);
> +       KUNIT_ASSERT_NOT_NULL(test, conn_state);
> +       KUNIT_EXPECT_EQ(test, to_dm_connector_state(conn_state)->abm_level,
> +                       ABM_LEVEL_IMMEDIATE_DISABLE);
> +
> +       drm_atomic_commit_put(atomic);
> +       drm_modeset_drop_locks(&ctx);
> +       drm_modeset_acquire_fini(&ctx);
> +}
> +
>   /**
>    * dm_test_panel_power_savings_store_forbidden - Test forbidden update
>    * @test: The KUnit test context
> @@ -633,6 +699,31 @@ static void dm_test_panel_power_savings_store_forbidden(struct kunit *test)
>          KUNIT_EXPECT_EQ(test, panel_power_savings_store(device, NULL, "1", 1), -EBUSY);
>   }
> 
> +static void dm_test_panel_power_savings_update_state_forbidden(struct kunit *test)
> +{
> +       struct drm_modeset_acquire_ctx ctx;
> +       struct drm_atomic_commit *atomic;
> +       struct dm_connector_state *state;
> +       struct drm_connector *connector;
> +       struct device *device;
> +       int ret;
> +
> +       connector = setup_panel_power_savings_connector(test, &device, &state);
> +       state->abm_sysfs_forbidden = true;
> +       atomic = drm_atomic_commit_alloc(connector->dev);
> +       KUNIT_ASSERT_NOT_NULL(test, atomic);
> +
> +       drm_modeset_acquire_init(&ctx, 0);
> +       atomic->acquire_ctx = &ctx;
> +
> +       ret = panel_power_savings_update_state(atomic, connector, 1);
> +       KUNIT_EXPECT_EQ(test, ret, -EBUSY);
> +
> +       drm_atomic_commit_put(atomic);
> +       drm_modeset_drop_locks(&ctx);
> +       drm_modeset_acquire_fini(&ctx);
> +}
> +
>   /**
>    * dm_test_panel_power_savings_store_rejects_invalid_text - Test parse failure
>    * @test: The KUnit test context
> @@ -1939,6 +2030,8 @@ static struct kunit_case dm_backlight_test_cases[] = {
>          KUNIT_CASE(dm_test_panel_power_savings_show_reports_level),
>          KUNIT_CASE(dm_test_panel_power_savings_store_sets_disable),
>          KUNIT_CASE(dm_test_panel_power_savings_store_forbidden),
> +       KUNIT_CASE(dm_test_panel_power_savings_update_state_sets_disable),
> +       KUNIT_CASE(dm_test_panel_power_savings_update_state_forbidden),
>          KUNIT_CASE(dm_test_panel_power_savings_store_rejects_invalid_text),
>          KUNIT_CASE(dm_test_panel_power_savings_store_rejects_out_of_range),
>          /* amdgpu_dm_backlight_get_device_index */
> 
> ---
> base-commit: ba496bb837882eb1af58f41572fc289e46c77b8c
> change-id: 20261031-abm-sysfs-atomic-c79505f63a2e
> 
> Best regards,
> --
> Shivam Kalra <shivamkalra98@zohomail.in>

