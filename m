Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD889606A33B
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=epsE4sgY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB89210EB10;
	Mon, 16 Nov 2026 08:59:55 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010030.outbound.protection.outlook.com
 [40.93.198.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7852F10ED1E;
 Mon, 16 Nov 2026 08:58:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksgBYKB+YjvJHnGj7I/exvv2VERaTpRRq1RWrZ9iVC0aPewPfEq0plcl+2cByu/FBO/ZVAJn43vnu7s7D8SNGn1M+5gw0GqParHVpgdF2OYvMg9IZcArqMDy68wyhiyVk3M8SbihT0X4DOhQiu4aXY5ANYBRE5dy4I+nRUwa4e4mcRR6J7TWplc5U+tg9X8kAuyo+945vZKMFes5mLzV3YOmBFPpQTIR/TamgHF8lzZNE7tZViInVbzZcnUolXhIjtLua5QdbTl8ctgvqxxUdGpBJ0f6Yti4oSXN3UQF8gyeGGJPmbdnjaesPTkjvuNmBTgeEXGfVlbfRYVmuIJ0pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RMRIrCVbnEQ/MBzvvSJdgIMuKRaCA+bsrEqy1Co/p8=;
 b=yxSjxTUfQANr1D7rr2nbqO09QqHA/pvF2Dt3NqdGQCeHYbb4hKui1s53ZMzOp1d02OMdobpQ8T0RCK/nmvS0kbjOU6pEJ+8gHmKd5s7BKJutNoc7aGfFa0pz4vgi2zxgyJrK1Nbg0SZrkxJpP+CMgz52cVac/RN9ssC1uACHg6GkfED2b+OqQJKmoEr4BLL/ampE+d8ukoY2+UXaA2agVmYQlGBVi5eNe5P7DGm/R7YlwqkiV9yuViWk/XzAIy+2Ikgz08SsSe2yA7eE1HjSytbHj1nAmYgs9sYVBuy2VZa9e5dCXm1jwD2pXKBkS+Uxz9arC5HeM8ywwkLgiXktzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RMRIrCVbnEQ/MBzvvSJdgIMuKRaCA+bsrEqy1Co/p8=;
 b=epsE4sgYpJLqrAADpK+3LUrHgAExxfKLykSllJ+IkFmx3V606ZDVDkLxtQ+cc1SmpxS+dUBTMpVk0ygUom1GcpFxPYvexJzlnl0sdJFwQOrgUsmhHLTiHbMSeH6yjJUf217/9rYOaKbWlj7YdJnAGcnMGmCEU1WbXYd2H0iFmLM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6132.namprd12.prod.outlook.com (2603:10b6:930:24::8)
 by LV0PR12MB392693.namprd12.prod.outlook.com (2603:10b6:408:608::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 08:58:55 +0000
Received: from CY5PR12MB6132.namprd12.prod.outlook.com
 ([fe80::d9ab:4258:a9ef:b8cd]) by CY5PR12MB6132.namprd12.prod.outlook.com
 ([fe80::d9ab:4258:a9ef:b8cd%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 08:58:55 +0000
Message-ID: <085c307e-8671-4ac4-8bd4-b7e42fb69ae7@amd.com>
Date: Mon, 16 Nov 2026 16:58:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] drm/amd/display: Leave self-refresh before an ABM
 level update
To: hugo@hsal.es, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Roman Li <Roman.Li@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261113-amdgpu-psr-abm-update-next-v2-0-27ce790856ea@hsal.es>
Content-Language: en-US
From: "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>
In-Reply-To: <20261113-amdgpu-psr-abm-update-next-v2-0-27ce790856ea@hsal.es>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0031.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:7::9)
 To CY5PR12MB6132.namprd12.prod.outlook.com
 (2603:10b6:930:24::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6132:EE_|LV0PR12MB392693:EE_
X-MS-Office365-Filtering-Correlation-Id: f6981028-6542-410f-4b02-08df43bfd7f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|6133799003|261009223027099003|56012099006|11063799006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261022105027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: 9tRr1XGLAdSxUgHzMfPNP1aj0jR+TKk6lN+WVclxv0g6QpoPVq+AovoerBfADm+egzJ3YGwhRGtdto6AXMG4l41df3TH9y2hfBpTbqYQkSpEN8oE55CtMcP2v2PjiPJ64CNbrByjMH16AEaFxjwWWOP4tlzoW7CXpUt4fyzOjwD2zLf55FrokZZDeQj3mSCcdKMHsozatRUT4YXt//Kww1MOK+HRccdZiMzi9l0GHWWUmxRuw4zxHLliCHZE7MAUx4T0gwYWWICar9mG7D+woIwtn0d06iHcJ+OS9JFinOmHvGIf1HiWFIhCzAtTDGqQ2WhbNgIqJPAkHu13G2wqf3wLAtVbxwDab2421r96vKO4HO9a+Pmobe2L0vDssNiK29Nqll7qEABgmOfLPEJ8gv0QDUnEGYuNlFzK5UTJx8pNXq8Elwl5hK4/YXTw/F84w6c3N957RcjhymXoKAMdzQzATyLormqUOkjC0fQD1Ro4oSrFGPwxdn5IUKvytXVJ8jONY8ZMIuwstSE99gBLdJnXJQsxvVpoFpTEBn7PiNDOoiiXyjM7jNnZziyXGYfo/bZjY8BjA3nG9n5aPnuVUPFvmJVHZ7AG3fdckSrq+ig=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6132.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(6133799003)(261009223027099003)(56012099006)(11063799006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261022105027099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlQyNkprenVsV0hqbUZ5eTVLNHJENVd1QllsRC9lMWI1Y2VFdVdmNlFQRHNk?=
 =?utf-8?B?WUc2bUJBK1gxQXRjUW5HRmI0L0VCYlVSWTZEQytwNEE1bTZXRy8yV0QxL0ZG?=
 =?utf-8?B?T09Ydmc2MGNSWU5kYk9FdXFMNXBaNXpzTFhzMnBrSU5kaEI4bjZjZDZ5eG5h?=
 =?utf-8?B?eWk1cGVIU1lub3VZN1RDeEQwU2xJTVpYK1RTc1g0VkpGWXlhKzNhY2V0b2dT?=
 =?utf-8?B?U2hOSWV3czI1NGlXOWlKVzhhU0RjcG4xSDNGQmdySmNvOXQ3dWNDSVhEY09l?=
 =?utf-8?B?MkcxdXdLdXFMcU9POXpMdEN1RU5QSlhHekJmb0pDdjExMEFuWUVQS1B0U0t5?=
 =?utf-8?B?b2FvQUxjYWlyM3BOdHhEWlNEZWxyeG9YeEJ6ZTBQNFE4TERzbnRxeHNVUWdv?=
 =?utf-8?B?N2k2Ly9MaEhnQTFQK2lDR0pORmV0Wmc5d29VTWthTy9QT1RzRWJyM1ZFcUVC?=
 =?utf-8?B?UWxjTVdWRW9rOG8rTEdtSEhUR1g3UlN5MTJOZTg3a1licDFBOWZ3RUVVRlRy?=
 =?utf-8?B?N00wclp4QU9KcUtTdzkreVNIUDNHTmtHcnQyOHllc2ZmWnJvOHFLMUlrQnBp?=
 =?utf-8?B?L1VoWUo1WFNIWWxrTVFkb3Z5bS9Yazc1M1JLcDZ6RWwzeGg5R3BZa3JnTGpv?=
 =?utf-8?B?VEU4UzRTRmhEWkQwU21GWjJmLzIvbmk4dGJEeUdUMm1IZGxwc0w3QmtvSWZQ?=
 =?utf-8?B?SlZqajVpTStjeVg1WWpJZnc4b2tsRVpYc2NPUGIrZmdLNEEwQWlTSjU0VUJE?=
 =?utf-8?B?bEJvWC9JOVJzc2JLRUZJZzZOQlRhNUpTSm10cDhJME1VbVEvTk1ONnFGUVhM?=
 =?utf-8?B?cXQ5MXhWT1VlNW05WUkrY1BUWEFibTFVOTVpK1kzb3IxZXpLanVDSk1kZGVP?=
 =?utf-8?B?a2tjK1NvdTNlcis0c0FKWEdVUXA3WHJmL1hGYlMzTjdLcmlmRlpHM0RvdkpG?=
 =?utf-8?B?SUFKTEYvYnR2eXdyNEMxZ1h6NjA1NWFORG14elNEdis0WldDU0Y1OWFweVRs?=
 =?utf-8?B?QmJ2ZnNiTlFZT2JNL1hDOHl4M01LZWRzNFlNMVRsc0JnOGNJV0V1T1lpem1V?=
 =?utf-8?B?bW5seFdwelAyUW92djNXbUV3cmlkWVEzY3RrMSs3Qmo4RlozdTFzRkVyVjNT?=
 =?utf-8?B?My9RbWhpaGZRQW95QXhFemNhZzVlTHE1V0NBdFdsTVhZVjZXWXRNakJ4cW53?=
 =?utf-8?B?NGQ2eXIvSXIveUJlZ1pIUkY3cmZvY25rN2NXTXFGZEgyNHN3bmtIUTNhWm56?=
 =?utf-8?B?dWVLMitFZnNsN0hCQnhUSDBGc0loaHAwMTVpVXRmTE02R1VDMHVyU0Mxdm80?=
 =?utf-8?B?K0JHaGJiVjFYSUJLdW5WSXAxTEJLdkFTVUl6ME9vVnVMZTNTY0dkdE44MHg3?=
 =?utf-8?B?Y2xaWjI1SkxKSkNVZWMrNWF0cEVqclpmdEU2elNJQUQ3RUdWdkRXeVNjaGFu?=
 =?utf-8?B?ZUduQVlWM3N5M25EWDBYQ2UxcWJnU09aL3JVakxEbzV3R3R0UjFSMTB6Wnda?=
 =?utf-8?B?ZUFCYWR3dE1oOU9ETngveFhZVTZKaXBWMFFOdU10VVZ2RTE5S005UEo3L200?=
 =?utf-8?B?OUdoNUlHTGZ5WlcxYnlHL0JqSnQ4dlNCQ3dWZ2RBU3VwTkd6VElnLzBWUEpZ?=
 =?utf-8?B?QXcyMEFoTm9QbUpQSWpaeDdVWjlXa3lUZHdmdXFxRGF0ZW13NFJtbzUwbUll?=
 =?utf-8?B?SVAwTFlKR2tVMExVcTJQNDZ1cytvbkJTQlNaLzhNZ3owYVlnak5ydGtaN1pF?=
 =?utf-8?B?UW9wRTJVcXcraFhiZnlucTJpR1lqNHVlbWE3RDBZVG5tSXFWQitUYkZwM0Y3?=
 =?utf-8?B?dlcxSlRVcTg1enB0QnFYVktKcjlYZHVNWENQeUZTeUF0eFJ2aHp6VTRqZVVE?=
 =?utf-8?B?a0pXNm5uYWhWZGY2dkpWZko3VFo3bzBUTS96SDlmS0ZQamVSTno3ZHR5WEFX?=
 =?utf-8?B?eHlROGNxWTI5VnJIMUpxdnZBT202Wmd2eXJtOGdiSTBzaEZTSGhxRlRFTEhZ?=
 =?utf-8?B?dXFpMmZuMUV3KzY0Z0R0dWlpS0F6UyswMHJvSU05NTJEK0JqRHZGL05MTXo5?=
 =?utf-8?B?MjZReW9jUHBNV0J6dklhWXF5UnhRREErSzZRQkZxVnBZbkw0OGJFSVNFZ1lW?=
 =?utf-8?B?dGx2L1Bnek5mdUJNTWJka2lvSEdHM3hYbGNCb1EvWVlyK3VRMUZwNGYvSDFh?=
 =?utf-8?B?YSttd0RvenVVcDNMVGFFbjRjRUJNZUsrY1pNd3M3TUlWSDlqOHJhUCs3eGhB?=
 =?utf-8?B?TGF1L2YxQWZETmgvdHRiMEJRZGxJS3BSc0RGQTIwbjJ4OCtwVEhoZW5iRk5B?=
 =?utf-8?B?dUdvY2tyTEVpSnMzTDBtaFdTRnRQMjJrWEphbU5HZ0xaNHhlSGpBUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6981028-6542-410f-4b02-08df43bfd7f0
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6132.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 08:58:55.3425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ott+dpdstFe0hF1/h6zirjWnFGHTI22bIPwdTAOkrMOc1Eq4vEkrDGo/CyFqvpTOMEDPDY1uq74x3x7edM57sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB392693
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

Thanks for v2.

For the series:
Reviewed-by: Chenyu Chen <chen-yu.chen@amd.com>

On 11/14/2026 3:40 AM, Hugo Sales via B4 Relay wrote:
> [Some people who received this message don't often get email from devnull+hugo.hsal.es@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Writing panel_power_savings while the eDP is in PSR hangs DMUB on a
> Cezanne laptop (DCN 2.1). An ABM level change on its own is a fast
> update, so the new level reaches DMUB with the panel still in
> self-refresh. Chenyu Chen confirmed the same on Renoir
> 
> Patch 1 adds helpers that tell whether a PSR or Replay event is already
> set on a stream. Patch 2 is the fix. It sets the PSR and Replay
> hw_programming events around the DC update that carries the new level,
> and clears only the events it set. An event that a full update, a
> modeset or a PSR SU dirty rect change set stays set, for that code to
> clear. Patch 3 stops amdgpu_dm_commit_planes() from sending the same
> level again after the connector update loop sent it, so one level change
> leaves self-refresh once
> 
> "drm/amd/display: Don't force a modeset when the ABM level changes" [1]
> sends property changes down this fast path, so it needs this series first
> 
> HDR metadata may have the same problem. When the HDR static metadata
> changes while HDR stays on, the commit is a fast update too, and the
> connector loop in amdgpu_dm_atomic_commit_tail() sends the new HDR
> infopacket to DC with the panel still in self-refresh. I have no panel
> with HDR and PSR or Replay to try it on, and the VRR and AVI infopackets
> already reach DC the same way. Does an infopacket update in self-refresh
> need the same pause?
> 
> v2:
> - Clear the events right after the DC update, under dc_lock, instead of
>   on the next fast commit (Chenyu)
> - Only clear the events this update set, so an event that a full
>   update, a modeset or a dirty rect change set in the same commit stays
>   set
> - Add amdgpu_dm_psr_event_is_set() and amdgpu_dm_replay_event_is_set(),
>   with KUnit tests
> - Send a changed level once per commit, so it leaves self-refresh once
> 
> v1: https://lore.kernel.org/r/20261031130002.2335615-1-hugo@hsal.es
> 
> [1] https://lore.kernel.org/r/20261102-abm-sysfs-commit-v1-2-e5addfd9539a@hsal.es
> 
> ---
> Hugo Sales (3):
>       drm/amd/display: Add helpers to check PSR and Replay events
>       drm/amd/display: Leave self-refresh before an ABM level update
>       drm/amd/display: Send a changed ABM level once per commit
> 
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  83 +++++++++++++++--
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c  |  24 +++++
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h  |   2 +
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c   |  25 +++++
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_replay.h   |   3 +
>  .../display/amdgpu_dm/tests/amdgpu_dm_psr_test.c   |  60 ++++++++++++
>  .../amdgpu_dm/tests/amdgpu_dm_replay_test.c        | 102 +++++++++++++++------
>  7 files changed, 263 insertions(+), 36 deletions(-)
> ---
> base-commit: ba496bb837882eb1af58f41572fc289e46c77b8c
> change-id: 20261113-amdgpu-psr-abm-update-next-de20bc23b12c
> 
> Best regards,
> --
> Hugo Sales <hugo@hsal.es>
> 
> 

