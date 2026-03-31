Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987F0FF60FF
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 10:55:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3A1D10E8C8;
	Tue, 31 Mar 2026 10:55:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LloatH64";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012071.outbound.protection.outlook.com
 [40.93.195.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B83B310E8B9;
 Tue, 31 Mar 2026 10:55:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=txUNOOxldx/9lMVYlOGPes4kdR52M9giQa3kTem6svYWl8LrxKKdVBTayVyAS9+EWSbL4p6iXFXMBqPbviWcplYm5c+WVBPtCbhcg6G3lfqSHCUaCtoAPqvv2amTLBVvKkC7X0Ci6tTTjmHlcC+P5FKsH56ShZysWW7KyWRETElMeOOpLnr2NejnHKikl1smQsFddzBktIukiB7eJaEPnU46QSAg/crQ8JsCN3UjP6+5Klyg8tYCgdfzFs7n6QtickLf27GgxNRepdbubXQB37j7VYF/1CH3M7ndtQyxQbDMUwfZMYezedJwZ92URLunyYpflptI97fkogJIHgIgyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dil8ObYGiFZ2e0mfJatMNvLCI23vfFMOqjW9Grge4SY=;
 b=upRJjnXb5TxbKwti0aVcXHJGaSIItomK9jKS7+cYQa7qzUKSKSDlWADWrFRfTEYrMrvvnclSCERcap1nQVLtySAyx470ENOOjMCtJh5JRPAA87zqYM0qSW5lozA4/gf5H1asVjsNn0oERbUmBIivnEAZF7TZZ7pdtPD6bMWvgqSqPWMfOui9buZ5yekX6TRvkdYBxYLlYW1K8ggU3cG9g7E4A6cM6mvhi9GgJtTu2K18YpK0JSSBE/EpLclx+971JZwVGYZ2U1wpQab67ie0SKsWDz61QaMc96vGgAMR7paf5THFeIagzY6INw8HvvuNUD32+1HHW/pJwmovUd+uTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dil8ObYGiFZ2e0mfJatMNvLCI23vfFMOqjW9Grge4SY=;
 b=LloatH64JQnZEURDV/2latN/sYMD6SaQMlKtnqXV3vtsNipVxlLzHAe+ogMjPty+eaaFhmb1CmLR98AY383SkveF/txfhJ0DYUFZki1tFrlcb8R3567TjuCoX4ID9wkIvdwKLFE1sHpBetpfJ4oIYHxATR0PkAWfCRPVZ+JNIMY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA0PR12MB4367.namprd12.prod.outlook.com (2603:10b6:806:94::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 31 Mar
 2026 10:55:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 10:55:27 +0000
Message-ID: <1cecbd19-de1e-414d-98d0-ce3fec3987da@amd.com>
Date: Tue, 31 Mar 2026 12:55:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 6.12 3/9] drm/amd/display: Disable fastboot on DCE 6
 too
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 stable@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, "Pan, Xinhui"
 <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Bin Lan <bin.lan.cn@windriver.com>,
 He Zhe <zhe.he@windriver.com>, Vitaly Prosyak <vitaly.prosyak@amd.com>,
 Alex Hung <alex.hung@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <Mario.Limonciello@amd.com>, Ray Wu <ray.wu@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Roman Li <Roman.Li@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 Mauro Rossi <issor.oruam@gmail.com>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260326234716.16723-1-rosenp@gmail.com>
 <2312151.9o76ZdvQCi@timur-hyperion>
 <6b15401c-1fdf-4d3b-84aa-dfc47f430895@amd.com>
 <7351746.9J7NaK4W3v@timur-hyperion>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <7351746.9J7NaK4W3v@timur-hyperion>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:208:335::26) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA0PR12MB4367:EE_
X-MS-Office365-Filtering-Correlation-Id: 4097b818-7797-475d-4f54-08de8f14049b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: AufwEavuA7CHZwaXO2Ld+TG8pM6R8FH0VOYZSqpz2jC04ylT3x3JkvOK5Mee9Fa7m1Q4MTfPNAuz+36jImGeI9RpcvBanR/dVX1qjbY0BIexyzlpwvT1ly2A2MsMRj1ZarXZBbbQ88s6NsPMh7+eNdxIK0WaVHDWZpR1kh6Uvcs6krvtnwOKk/QhkKjdGKfcPL/1IDI72xX8t0eb6YsL8qxm3MAsioUsXxm3l92K5RtqVoG+4k/E6mLkgPx4piv3/JqqflXqOPpkpP6kadVrhnEvLowkcJmqI4rlWCPTQI4J8pCoOCGtxeDuhQCjCxVGPc2kM7V2bzgcSjb77cleubNyK8/Ru5ga7qohI8f7uqtqJUZV+agGmCJFokYk9FgL3NuvgruvgDBDImEGvmx9MbJdiE42mw9eWff0eouHBOYwEX8BBtaQK6zyn/aUZy2YTOqoIW0r7Kkq1JtRIfQOMS39QMfgibWH0amQ8/OKoguQe4q1usY81/yhEq9cVSW2YPBUx2UKXGt/ZBUvt2T1vjacom0IbhQjlkj7gqBjvqFQAd1VxbvqtIYDUS/1OOYsWTF8MVOWS+hdTTo1BlixPutb3O15PaEG2s3nsiv1u/XIfqs0r73czWTmZQqJHF1UEjefzG4Ve9A5ArDVnwA9jmCRX1YeEMCRhOez20jOzdTg4IrviMCsfaW75U4O6RD9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk96R1NGbjJ1MDZWUm5tdytDRzVJY3NTclNaNmFjOUVzN3hYajR5NnNtWnFG?=
 =?utf-8?B?STI0Ulo5VVdHVzR0NHZOaVZOMjFrdzIyY3B5K0RiZkUwMDNnNjBKa1FzU0FS?=
 =?utf-8?B?Y0RyalRCV2k5QWEzZnU2Zlp4MFB4WnZ1N2Jmcmo3RzJYcC9EV0F4cE0yZWt3?=
 =?utf-8?B?MzB2bFphV0s0bUtIbEZzSENrOHJkUHZVZGsxZmpLK0FEVk00TlVhWjJKM0JK?=
 =?utf-8?B?cDlEc04xVDFNSEFuSktCUGxZNGJqbElSQitMc0JLQ25DQllJaXM1Z2lHcmIy?=
 =?utf-8?B?OTg0M2k0aUFGcE5WUkZ5cEdLa2lBZ2l0YkFWRjM1M1ZoT092K2krMWNnQUhh?=
 =?utf-8?B?R2lkY2JEZXFYa1FCU3ZBTW81M0Rkd0kvbmhHaVpuZW1rczNjd2dPaUJRWktN?=
 =?utf-8?B?R3RRb1dnaUl2YmV6bG5FZDdrM3FnRVBsZnhJQ1pqbysxZTJVMmowSndxRnM5?=
 =?utf-8?B?alZzRG1tUVMvMEVmdmhvUGFaZk12bUVSTHdrSXdoZytvYkRSTGU2R0R5TkpJ?=
 =?utf-8?B?MTZkNGtUeEovTEd4dDFFR2poVXZSdnBSYklNVUhVSHE2bzJLSzNSenkzTEQ0?=
 =?utf-8?B?TnhHS0NxQ2NYMEdWNzEwSHBCb3VJTjFmTURNUU9Hd0hNdzZBdXJDZTR1QXd0?=
 =?utf-8?B?QzhmOWFYWG1CZHhlRzMrK0lRK2lta2M1RlZQUWQyT0dUK0JZSy9BRWtsMTIv?=
 =?utf-8?B?cTZXUE0zN2RqemhzZEJLYXpGcUhlbWsyR3dMSTUxbnpWaHJrQ2xGRUFmVFRV?=
 =?utf-8?B?NTJsYXN3RG5FVElYVTJLbHZVV25JOHp4RVZrNTgxai9DMVluaU1xcGtqTXJa?=
 =?utf-8?B?YUtUZlFoWlNnVmNjOS9qampJM3NURHFIMTRPeEJwQk5XTGtGZ3QwS3dHYkYy?=
 =?utf-8?B?Q1hHYnErRU1BSnhtNkEvNG4vbjAwSjRPS0dyblc2VWNSSnNnMHhtVGVHZnFu?=
 =?utf-8?B?NFZZMDhxaUhiTDFzUTB4REVFNWpKVmxFS29SYzJrTXAvRW9hZC8yQjNZOCtF?=
 =?utf-8?B?SEZaWm5ZaWVRR1RZUkNiM3RJNW9oNW1VU2ZTWklQcUFzM2xnNTJCYkNnQ3JN?=
 =?utf-8?B?bUg3c0F5czhsL3A2TkZnTUFMbnVrbEpQbGl1MlpZTWcxMEFmTlR4ZHVtVUU4?=
 =?utf-8?B?eFVQdkxoV2h0Vjc2a3pVRHc2Ymt5WEpZVEdMRjFiUkxaNlZJRXVFcERSbFJ3?=
 =?utf-8?B?WDVFZ0RkNHl5ZzR2RWZlb2tyd0x0bnptUnJueVBaZVc3TERwMU81ZkxDQWdm?=
 =?utf-8?B?dFNmRHE2V0l4WDZyeGUyMmpDSkhlMVNiYWdHZWZQZlpVdXg0N2JwVjRqZnV4?=
 =?utf-8?B?S2JMbWd0SHNNcFdLWmlQenhhUE1zYk9ocXM3Yk01R0lVNGMxRG1ORnMzOUJ3?=
 =?utf-8?B?YjhEbXJoLzlDd1RFRXdFeXJGSlBjV21Rbk9HTFZrSUU4cGZHMFZqWjlvYnVp?=
 =?utf-8?B?VVI4TnVvdStPRzBIUVVWaWt0eEN1c0ZUY295bUJXSm5EbmtPbnF6dXRaT2Nt?=
 =?utf-8?B?TzhKNm1VNXUvTnFaRlZTVmtiT1hrOUVLNHphZEhwaU1QMjd4OFZHUDhhck5O?=
 =?utf-8?B?TTgwK2JrWDYzVkFtTnloYXBqblFVYi9iTlVvODRSQ05CUHVEWEQyb2dLTDFu?=
 =?utf-8?B?RFRpK2dORC8xeHRqNlIvemtlMkQ1emswajR2bVZwOXNqdnVJZmZ4b0ZMMkNV?=
 =?utf-8?B?b1dWazVBNVZ3V3ltdk5URU91ZUhGTDJtc2pDWUN3NG1ueWNod2ltQnpWTEFF?=
 =?utf-8?B?SFRJeTltVlE5VlNEcGZPMUhaenR3NWVRRmVGdWRIeXAwVEEzeldzRyt6akRV?=
 =?utf-8?B?ZlRVY3VMaXN5a2Y1YWN0ZkI1VjdIc0FSbFZLcVoydWFwdzI1dnI1Q2JWRTk2?=
 =?utf-8?B?dnZrM1d0YUhRMlFuOE5LNDh2TmxPcnAvMkF2YzJIZG9YMDJOTG1RNzZuU2VM?=
 =?utf-8?B?OFdIZ1ptSVlidVpnajVqWEE5VGlHOHBrUVhaMjFyc1gzcVkrdG5vQ1Z5Q0ZP?=
 =?utf-8?B?S2duS01FUGR4cGxQMDJzaFNGbUNmMzZ3OEFqRk1rNUVWR2Zhclp0N0ErcXRj?=
 =?utf-8?B?aGRaaEluWW5TaG5EV3BxTHNDMDFSeXMrbFNWRTdtUHY3ZUpZczhXWVJDaTlh?=
 =?utf-8?B?cEl2T3FIZXZDTFgxSjlFa2ZOQkxlZDhIVWFwTmF2am96ZmRLSVZQVDRETUl6?=
 =?utf-8?B?YUJ4NkVsQWJEdXJjNmt4ZzBxWk5PZk1OdVNMNGMyTHcyOUZrNXdWQjZxVGow?=
 =?utf-8?B?NThDWExqREJvbzUzRkhZWDB1VFZYTE9YTmtMeEJVRC9JVFJ2Y1V0RnNpVVFw?=
 =?utf-8?Q?6xNRjWM8q6dFdGWRdF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4097b818-7797-475d-4f54-08de8f14049b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 10:55:27.4844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DgG7wMtbQd9ZRMa7hqf+ukHJthpDz+G8ePiGGcqiSOQ0KjqBWO6MfHbbq8Nh0WNm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4367
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

On 3/30/26 16:21, Timur Kristóf wrote:
> On Monday, March 30, 2026 3:55:55 PM Central European Summer Time Christian 
> König wrote:
>> On 3/30/26 15:16, Timur Kristóf wrote:
>>> On Friday, March 27, 2026 12:47:10 AM Central European Summer Time Rosen
>>> Penev> 
>>> wrote:
>>>> From: Timur Kristóf <timur.kristof@gmail.com>
>>>>
>>>> [ Upstream commit 7495962cbceb967e095233a5673ea71f3bcdee7e ]
>>>>
>>>> It already didn't work on DCE 8,
>>>> so there is no reason to assume it would on DCE 6.
>>>>
>>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>>> Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
>>>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>>>> Reviewed-by: Alex Hung <alex.hung@amd.com>
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>>>
>>> This patch is incorrect and should not be backported.
>>>
>>> (Note that the error is already fixed upstream. For stable kernels IMO
>>> it's
>>> best to drop this one.)
>>
>> Is there some alternative which needs to be backported or should the old
>> kernel just work out of the box because we never enabled some feature
>> there?
>>
>> Apart from that the patch set looks good to me.
>>
> 
> This patch had a typo and does the opposite of what it should, ie. it disables 
> eDP fastboot on DCE10 and newer instead of disabling it on DCE8 and older.
> 
> The upstream fix is here:
> https://lists.freedesktop.org/archives/amd-gfx/2026-February/138577.html
> which disables eDP fastboot on DCE10 and older.

Thanks for the info.

@Rosen Penev can you either drop this patch here or send both this patch together with the fix for backporting?

With that done feel free to add Acked-by: Christian König <christian.koenig@amd.com> to the series.

Thanks for taking care of this,
Christian.

> 
>>
>>>> ---
>>>>
>>>>  drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 6 ++----
>>>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
>>>> b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c index
>>>> df69e0cebf78..7dc99c85b8ea 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
>>>> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
>>>> @@ -1910,10 +1910,8 @@ void dce110_enable_accelerated_mode(struct dc *dc,
>>>> struct dc_state *context)
>>>>
>>>>  	get_edp_streams(context, edp_streams, &edp_stream_num);
>>>>
>>>> -	// Check fastboot support, disable on DCE8 because of blank
>>>
>>> screens
>>>
>>>> -	if (edp_num && edp_stream_num && dc->ctx->dce_version !=
>>>
>>> DCE_VERSION_8_0
>>>
>>>> && -		    dc->ctx->dce_version != DCE_VERSION_8_1 &&
>>>> -		    dc->ctx->dce_version != DCE_VERSION_8_3) {
>>>> +	/* Check fastboot support, disable on DCE 6-8 because of blank
>>>
>>> screens */
>>>
>>>> +	if (edp_num && edp_stream_num && dc->ctx->dce_version <
>>>
>>> DCE_VERSION_10_0)
>>>
>>>> { for (i = 0; i < edp_num; i++) {
>>>>
>>>>  			edp_link = edp_links[i];
>>>>  			if (edp_link != edp_streams[0]->link)
> 
> 
> 
> 

