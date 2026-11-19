Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DF9606A339
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 09:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Pl5xOMlv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB44F10ECE4;
	Thu, 19 Nov 2026 09:11:50 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010031.outbound.protection.outlook.com
 [40.93.198.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37B2F1121CC;
 Thu, 19 Nov 2026 09:11:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jioUZq+MymyRO/4w/dntZZ3m66xItnBa+vPFWnaqWTAuDYzOdzwj7z48S06ETt9Rt5o0INOv9aqXxD7gB8r/ScH1Xsv/v+sT5CNnWwp+ZWXTkTPxzYzMKigNtPYaK52vsanRxZB7p8S6A3GQTb50hLqZwlNlVOixRUGMOTvntnf7pJo/wHAj+V8NzZmefhMKq7vNie5Z4pWm85Ps6cNDRw/FQMR3wy11+pmRf8owBy2LCnyek/EulnUu8jCMvg3/TlmWnlTPPcZiHA/79Fp+LHY0FDMKBRhVvOySvV+Ij2fQjCJSXFO6kCmM8gn+J+x+V4QiQByPGKp6NF2BgizZkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlswnoiqp/qxi8rYatXaN8bKUOygSYsB8FgthYauyQs=;
 b=LyV6XgbeImNRZ/7txf5+1h0kuyVzCI9gBdGSblDex1yYLZWsEOKfKZtXehNqeklfPe15UQO/VYfbkRoTb7CuZo+5Fuk8lOp/YQDPuOfKflRUVdn/BEb4V/IIy4JP3fkbRCr6WRLB7uvG+d0vccoeOxOqhhF+iHC9lMe/XOSkPBoE9rRCut8C2zVgKM6THGq5RPQwzIxGIyGriwavL0nuCm9W4yeVMm7mjeuNtX1GRs97cfa7BYxXardMBpzQzIlfScKwsCS11SlFrhni1v64/7RG8/ZdxMEEUXtxlFmQ4hjOVm//ZRkfyqc9n4hW0WGgozg7ME565x0gl2QIbTAB+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlswnoiqp/qxi8rYatXaN8bKUOygSYsB8FgthYauyQs=;
 b=Pl5xOMlvX2WJl5j3qDu+IbbGTeAh7ZI3lT6tKxLQokPA4H7ffg0wZidLDu20b8R0jv/Iyr+hy8slgiP8I7l9bxMCOiYKX+3cp0Hm7iqpXCjiMaR3tDcWfQU2UrVJbdbN08UdiQtgAMrPD1oM3QZmCck4eMBP1fzly+V9fWVGhL4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8701.namprd12.prod.outlook.com (2603:10b6:930:bf::6)
 by DS0PR12MB9324.namprd12.prod.outlook.com (2603:10b6:8:1b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 09:11:40 +0000
Received: from CYYPR12MB8701.namprd12.prod.outlook.com
 ([fe80::2d1d:d718:e022:2e18]) by CYYPR12MB8701.namprd12.prod.outlook.com
 ([fe80::2d1d:d718:e022:2e18%5]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 09:11:40 +0000
Message-ID: <356085da-41e4-4f73-ae9d-806ff13df236@amd.com>
Date: Thu, 19 Nov 2026 17:11:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Store the AMD VSDB version for DP sinks
 without Replay
To: Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Cooper Morgan <ext-github@cwooper.dev>,
 =?UTF-8?Q?Eren_=C3=96zen?= <erenozen@protonmail.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 oystersuki <oss@oysterdaisuki.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261119032758.3857304-1-Wayne.Lin@amd.com>
Content-Language: en-US
From: "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
In-Reply-To: <20261119032758.3857304-1-Wayne.Lin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0059.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::12) To CYYPR12MB8701.namprd12.prod.outlook.com
 (2603:10b6:930:bf::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8701:EE_|DS0PR12MB9324:EE_
X-MS-Office365-Filtering-Correlation-Id: abec1cf8-8ac8-4ef7-67d5-08df461d1f27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|11063799006|56012099006|261102123227099003|261021121427099003|261022105027099003|261026140227099003|261021123027099003|261028144727099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: gR6koBlTWkGv6LHVhpFY8ZI20gX0zZQKKVmTjBnzZ5JH3z9DJQS3ZdX7tuEKXqf2uBTXwk6vgPSQUfGGByKup7H9NpZ8GjdJL7468BmFTwCEotUOtaDYh5UNkmo+MualLaHbFX6X1pJIJOZleawWPTDPXWJ188n5m7o24ViPtW2N0EEYEG3p0qrOxfLd7bc/APf/y6wLk6qt46FFFzbBxuandLSBBxJ07HVSckv+NQqFp7KRWXDw5TSX+G4LoknAYMyYTQN77AzXByPSJxpZpC7fccfhPAjO+V111LeTiuVZC5wFDVJ3pD0wIuQ0qvAOEkocK79NBj04wrSwIqgZnsa8SGn0xVymkw1rsPOJLuGkika846QO1iw8izCtbbdTMdexO9AzIGyAeiYxbTIiQQtHfDfRImGrWjOkZ7meoAi5VCDfNlcdlRlHnHMnZFue8OzIGurrhi87DhWHU0QQ2TimJUjookebVBl2FLi7Aggl1hxHnLiUHeBOKwrQA/M/2x7NXz/I/xg0HMhbWuPEXXg5JNx7bhZC92+vLc/hN5KjiMKySwLBySPGjz/Fyf5eisIHsz+DjUk6k7UPocLLStPwdObWylgtri5VqkhSE2pZRsqpS6zq78uDKST4M/fn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR12MB8701.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(11063799006)(56012099006)(261102123227099003)(261021121427099003)(261022105027099003)(261026140227099003)(261021123027099003)(261028144727099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dC9kdzlqTjl5M3B3VzcxcEdoN0FXVkJYYXJQcFVTY1hZWEdQREpGbDJiUUdp?=
 =?utf-8?B?QThzcUNkcTBZSjhXVC9SU215bEhHZzAxRitNY01RWHRvbE1KL2FtOTVWbmx3?=
 =?utf-8?B?SCsrWlZCakloZEFDRnMxNnlSbEY3Mk5QbzVkMnRQaG9XWUxLWkpsMG53VEZX?=
 =?utf-8?B?T3JLN0ZVVjRpMkJZei94SWVUWEUxMWZiMXBWTGJ6ek05MXphdFJnNythT2xi?=
 =?utf-8?B?b2lmUXR0dmpRNE11ZTFvblI5anNTbXN1M1ptQ2R4OFFmSFZHU2FYOWp2K1Yy?=
 =?utf-8?B?aW16SituTFpsYWpobzlJSTY5djlXVnZuTVNVKzU0QjVaVTF6SjdxaHR0VXYz?=
 =?utf-8?B?T2pXOVFoM3FUbTlpazNidjloc0FrS3BPWURUNkl6YlRZbzhPNGhHMTJTNzhK?=
 =?utf-8?B?M01kWk5sWi9iSXI0NzllL3JXY09tQ2NOMjJoQjhrNFo2TGl3VjZWL2lPbjJN?=
 =?utf-8?B?K0lMQVZhNFI3cG0wQXdPZFNZNVBZNWhndnNCb2pWOUVCV1NZUXRIWTFsRHoy?=
 =?utf-8?B?djByTVBKSlZIalhkZldEL2xNb0YvZU9haTQ3bUx5RDh3NFhBK0Y4d3hZbVpK?=
 =?utf-8?B?cVY5QWZrK0pJbTFNenJuRlR2MVBhMXpUTWtuejV1WlJLaVNZcU4wQ2o3VVVZ?=
 =?utf-8?B?eS9UUUpqNWFmSFpPTUt6d3U5YXdaYXJoeGtURGZlSGtmODZ1VEN3NXVESmFj?=
 =?utf-8?B?Qzd0Mml2YjAvN0Uxcm9KQ2Q4MHZhQzRsemM1THk1TlYwRityeExSS1NBbEZk?=
 =?utf-8?B?anhNVkI0K2FmVXpEbndVVnJMM2k4MUQ1dU9DeWozNnFTNTBvSzRwb3BOWlF0?=
 =?utf-8?B?bENKNDEvOGNFUTJUdkhLWExvZ3J4bWF5ekdNbENvOUcyNzVGS2xtR2RwS2kv?=
 =?utf-8?B?TGVveUdkNG9UY284cFVDVC83S0M4b3VhUCtiU2ZXenBiQ0ZxajFuU3U2bmMy?=
 =?utf-8?B?bVNpODc0L29pcDdxQldzSDVNaEtNYmpucWdid2VKQXRVUnNNV0VsNFdJT0ZW?=
 =?utf-8?B?TE1ZZmJ2aTlXcTNsOWdPUk1BM2RxdUh1WWRDZ1d6RlBjQ2F4c0x4emhEVm5U?=
 =?utf-8?B?SFlMZVUrMlNFb1BFa05CcDZHU3FoSForTldrUy9ONW9ieGJLUG00TGRSYTNh?=
 =?utf-8?B?ell6QmlsWHNGcWg4VHcyOTBTNVJjWm9aNW8yNkhUR3FHQ2VIVi9LNXFyN0pu?=
 =?utf-8?B?ak5zOUVoY2RwdmVHbW5KNkNRaHltakVMTFNDd3VpUTNzWW5LbktCM1c4NEpy?=
 =?utf-8?B?THRMaFo0NEwvdTlhYmVnbHBscnZOek1TbGtVYVlJVU1UTjF3RElwanQ5WFJw?=
 =?utf-8?B?SU9MY3QyelZ2ZEZxdkdJN1lUdU02REtqcFMwUFZ4azZuYnIxYXlwTHRFY0d6?=
 =?utf-8?B?Uy9icnBxVWc5TzFVLy9YbVdCNVpyMGtDS3VtL0tRNkdsZWFFWDB0d1RJM2R1?=
 =?utf-8?B?Q0xvd1hTazN3Y1d6Ti84K1kxTnFpeUxCWFRIRTBRYzgrMkMrU3BTZU9jdmdI?=
 =?utf-8?B?TmRXckRtV3RaOThQaFFJY3gxTUJ5RjgzSVN4NC9kOXlMdHJ1MjhTZUpmdDcy?=
 =?utf-8?B?ZHVhU09wNVA4SVlQZ056RW10bklBVzBRZEFGZmRuL1hIdDgvayt3TjQyc2lS?=
 =?utf-8?B?TlRlQmJ5bkpnNVJKUlIybEkvVnhxRHFqRFVVOVRxMEF1TnVyc0FKM3ZSbmxJ?=
 =?utf-8?B?ODdGNmVFalZHNzJmSUgzT1lLQnpoZXVHM0FwNEk2WUgvbnZPK2lXdmlVb3px?=
 =?utf-8?B?MHNDUGY1VDhPTkVENjRRdldpLzRFZDFYb3NzeE5pQXJLR3Y5aVExWkpaaGRI?=
 =?utf-8?B?eXpVdE5PaUZBQ3VVdndxUloyVURTMCt0dC9GM3VtU0haN2VsR3lIZ1JPOWhx?=
 =?utf-8?B?TmFiRnFENlFxSDl5NzRlek9ESDhSSjdSNC9NVzFiaU5xWHlVRE5jMlhYdlV0?=
 =?utf-8?B?eU9UTWoyNUpvdUF0M25GWCt4cktrZ3JLWlhMcC9veVZXeEp4ajV3SXhjUytY?=
 =?utf-8?B?UVVId0pVNS9iOCtXc21rUHYxcGRWWEJ5OHgwRy8xY0tFTE1SUlhkMnkxWUFB?=
 =?utf-8?B?Z3hJMm92ajdjcWZwQmRvZHBwdnkwMHo5MCtKOGZEbUVqR25uNVZ6S3daanpr?=
 =?utf-8?B?aWp0UzRNaDk0TjI4MDNTRnluN0NKRi8zazNNWEhaeWpRcVRMOURnT1pZSlBP?=
 =?utf-8?B?a3g1aEtlQis5STcyVGliRFl3M2xHbDVoVGFmQTUzNTBzZDl4RjZhTFlrZmww?=
 =?utf-8?B?UFFCbWJBbnhVN1poV1RtaUIxTDRvdjA1OWFtZWpIa01vSmYvNTRIWjVHMUh0?=
 =?utf-8?B?YkZlSHdqRE1vV3ZwMjJkWHZ3Y01KbHZadzBWTXBDMGlwRXlUeXhzQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abec1cf8-8ac8-4ef7-67d5-08df461d1f27
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8701.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 09:11:40.3912 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: low1V/cbMV3wZ5wxlM7luXLf3QSKcmPN2/YX/qmCVjUDPg9L8rPkUvvsBr77jPldxI4YcMEbJooMhtAeGY/aXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9324
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


On 11/19/2026 11:27 AM, Wayne Lin wrote:
> Store amd_vsdb_version for every DP and eDP sink after get_amd_vsdb(),
> not only when Replay is advertised. Without this, a native DP sink
> above 255 Hz with AMD VSDB v3 and no Replay keeps version 0.
> amdgpu_dm_update_freesync_state_on_stream() then sends the v1
> infopacket and truncates the rate to eight bits. A later EDID without
> the VSDB still writes 0. Replay still sets replay_mode and the eDP
> adaptive-sync type.
>
> Cooper Morgan's patch already contained this hunk in
> amdgpu_dm_connector.c. The hunk was left out when the patch was
> applied. This follow-up puts that hunk back.
>
> Fixes: ae60ec4dcfc4 ("drm/amd/display: Use FreeSync v3 infopacket for sinks above 255 Hz")
> Reported-by: Eren Özen <erenozen@protonmail.com>
> Link: https://lore.kernel.org/amd-gfx/20261113010529.11514-3-ext-github@cwooper.dev/
> Cc: Cooper Morgan <ext-github@cwooper.dev>
> Cc: Eren Özen <erenozen@protonmail.com>
> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>


> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index 1bc8547d5777..41fc641b1b60 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -3928,10 +3928,10 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
>   		}
>   
>   		get_amd_vsdb(amdgpu_dm_connector, &vsdb_info);
> +		amdgpu_dm_connector->vsdb_info.amd_vsdb_version = vsdb_info.amd_vsdb_version;
>   
>   		if (vsdb_info.replay_mode) {
>   			amdgpu_dm_connector->vsdb_info.replay_mode = vsdb_info.replay_mode;
> -			amdgpu_dm_connector->vsdb_info.amd_vsdb_version = vsdb_info.amd_vsdb_version;
>   			amdgpu_dm_connector->as_type = ADAPTIVE_SYNC_TYPE_EDP;
>   		}
>   
