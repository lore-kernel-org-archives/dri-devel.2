Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC4ECD13D3
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 20:43:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ADE010F457;
	Thu, 30 Apr 2026 20:43:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bJLSDmdv";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011019.outbound.protection.outlook.com [52.101.52.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A7EA10E46B;
 Thu, 30 Apr 2026 20:43:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u43ml3BGNH9IPaIOwMYD8MzpQ9zhMGiP2y44jzACBNMIGfjj9Q+MWwD3VN5kYYplu3uHwJV6+P0t+Kp1nQxVfUWKdawjILTjC8uEfCXOFUb2syt88i3+GhXSV6lI+NeY6XWg0BQSYvX9j4S2feujCffhgRKFmorgbSFfAGPZZqBeocqnw943b0eh6qy8B0sOz8/gD16KF3HfgH5UEJ2s0XlmUoai/yIfuYvMD444McUqAZjjCfapbiyoWfbFvH3LFun87kX4fTe8w4Ogt/5vCVBoELrv79C1kBaTFEPYEoKrQkQApzWRs8bX9bCXi44cb/MEG01TQBDm/Ofw4dLXlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+iMGA6YdB4VobDOf7V/zzuVf0JivzJ/0UuuEPMtMeM=;
 b=MfhgWMU7lWFq9QsO20doVHAMKmSeE3yQuIgwI+aCQnbPH+SrbUO93/skuaMGiCLlbRqmR6EdBDj/iyJSpODsHPK3dIDjRXFqHZLGnBuNuEoYRPI7nAHXtk90tLCm3q/xUAWCBUETV2mJBmJY0SCVzFqrCBf3ZcMPGMglm0KGWY0gUscRPV4+p2V3p1K0Qtmy4TdTp93oWoHP5uemdkTpbePxpl5oam5HCpVZ3MhjEKSRhhPt672RbkIl5cfV5SBGcRa9Qh6PHESPRJQTCnADp+xZ+xgaYEue5dp5+21k6Imrl+Wbr7QReQ5CIgryUZ7KCnxDQV7Z0BssGbAe9uCgww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+iMGA6YdB4VobDOf7V/zzuVf0JivzJ/0UuuEPMtMeM=;
 b=bJLSDmdvkGPKW1zfOxuC55qg6qvz6E5GHPVz31GedjP8Z1EKIJYpZYOQUNgmQDL5akjqWJRxyLgNL3jHkcg9U63GyeDWWg5rQkRZ41gELYNWvBrQN5LgifKmgmCG1mZewKhyFIdNLcl9FuYm7RubcYGH1guJaEbyJ8uzJJc1YXw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 by SJ0PR12MB5633.namprd12.prod.outlook.com (2603:10b6:a03:428::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 20:43:46 +0000
Received: from BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe]) by BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe%5]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 20:43:46 +0000
Message-ID: <49b02260-27fa-4a59-a644-79a93f2b6dfe@amd.com>
Date: Thu, 30 Apr 2026 16:43:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 7/9] drm/amd/display: Use GAMCOR for first TF if
 CSC is used
To: Alex Hung <alex.hung@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
References: <20260330153451.99472-1-harry.wentland@amd.com>
 <20260330153451.99472-8-harry.wentland@amd.com>
 <92964f38-2691-4795-a064-de67301ffc6d@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <92964f38-2691-4795-a064-de67301ffc6d@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT2PR01CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::35) To BL1PR12MB5126.namprd12.prod.outlook.com
 (2603:10b6:208:312::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:EE_|SJ0PR12MB5633:EE_
X-MS-Office365-Filtering-Correlation-Id: cbb7f138-0085-400c-51df-08dea6f92c9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: HOMmMjwjqtEzyCNL4NIqKwR7FcLAt1eiYjFpSYQAZVttIdlgaMumLIXLY8Ca0Kc8KN8iHUT8JIO1CH7w56ANHCDKohnhCMFXr3bUmIy3yJJBVXd5OEdQU2Y7a9gORZreXC1PLwAemZbaCYg7fNZU643xjyHH7R8q4hjLr5In7EKNMYMf/LqqhLC4D8kEe71upC7Rd8yIXdaSvy+y2wmRPcDVK3LY4wr77wdFFnVsGabpTaU7H92Qb9tDeqK+FwNjSwr1t3OMMzl3Ibrh4EV+DdF29vguoTBJ5DeoGKkTZon/2dSzThPbLh7Zw2nRGtZpnzkMv46kFYCF8q9IMgh8qiWt48mdm0QpuPeKn1KaF7HWvvzNAxUKpqQLcyQ+tYQLh2Py/NMynGCjf9tg/IQfAkFjswQ3ElCg37HBWjr5C6oenH79RT6Wsb8995xVVZWb2v994fYrBBTk6I3QlLWq1W2VrfqhFFlyH8D5RT6s58PQXPuoLKjcURriqjYeKmgZSfNX0xFlVH3nA8QdUuT+6XiWfScVRJIqnCHtf2WTp5jDXYV9TVuAgYBys7mrzvtLI+i3gR82+jdGyB+nbrwDkXJs0RqQY7qa6LlHfeFOl+wvgx3T3nl7bZC3JkPoq11XF1nLQGS9j/hcuXbMqWWEU2bVVIyOBF0tPNqCy8PE4C7BV3Ah+Ddb6uLQK2OOMok8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHRQVGJWYUhUZXFRYVl3WklWN05Uak0xRWxRK2FCUjJYMjlLaityZUtYaGFJ?=
 =?utf-8?B?a0xmRGV4ekpiMlViTzJBZUxtQS9rRERLRmkyWDN2QUtzR0VLRnN4NVlQNXQr?=
 =?utf-8?B?SWFvdmFLOUw5Ry95NXF1QVdkcnVtelgwejZDU3N6YVZTZjBSem1WUWttNnNQ?=
 =?utf-8?B?Z2c2dnJNUGZUYWR6ZVF6azhLTGs3VGtTNVViL1hRdEFVS3lhNWE0UDByOExX?=
 =?utf-8?B?bzgwT29nNW9zbGgvblBPTVpCd28yWThBb2s3SC9DMXcvVnUvYVVVaUFKSEtJ?=
 =?utf-8?B?TUN2dkYvQkdDaGw4U2ZXeGl2eVFhYzNYTUw4RzBjTktPdUVkbWFFSDI0VlI4?=
 =?utf-8?B?TkVvS2xVMndEaXV2YnJ5ZUpBU3NCbU9WNTF6em82eG1hb3dIZkJzaU4rOWhm?=
 =?utf-8?B?NFRjMjVzQ1Q2eUI5eWlSTllJcnI3Ym1HNlVwTEJSd1M4ck8ycXJ1VmthaE9C?=
 =?utf-8?B?KzBtU2w0TG4xcHUzU3krMjErSEh4NXlISWlsdzhwS2tRZkhrTWgvWjlZRklI?=
 =?utf-8?B?Q25MRVJveTNoWldJT1c4eXY4L3lsOC9CZGxPcUcyRWQ1UzQ2bjN1dWtoYSs3?=
 =?utf-8?B?NXZBcXFmdkhNUzgvUENNbmVYS3hNV2EvVHFFMEx5U3EzcXRKUVBTOFVMeU9R?=
 =?utf-8?B?WG1xdlRTeGZFR1ZuS3FCNmliaTUxTXpZaXI0WWgzb3BpK2cxUy9DRXZGL29K?=
 =?utf-8?B?N1RsT00rVDl6TDZhM1l1OGFRN0g3MnRQS1Vpc3ZTL3FWL0UxalhRdkpGcTNi?=
 =?utf-8?B?Qnp5S3FuVzhYdlJBUS90emkvaTVLRlJ0U0d4YkIyYUk2N2RsL3RXQmxRckFh?=
 =?utf-8?B?TDZwZS9TdGFYVFVGeHRsa3ViUVJUaVB3SXZ4Z3B4MlRFc3c3SGtRaDhqZjhD?=
 =?utf-8?B?ZVN0aCt1RkFJUnlsY25hSlNYQ3lxa0pCV0V6TnFVYnh2Wlp4SDc4WUdzdmhk?=
 =?utf-8?B?Qkw0OFBENSsvK2FXY2NBT3Q0T2IyanI2cnpQQzN2azB1ckt1WVBMeFkrTUNz?=
 =?utf-8?B?cVhkOXg3TlZBWldxMGhVY2EzTng1YTNqeXhwU1VUeVJKVU4rVFRlSlF0RXcw?=
 =?utf-8?B?NTI5R05PUGxlb3Bpdnl1Zi9NR1pDdnNKbFhxVzArUzRUT3Zhem5wUlQ5ZHdW?=
 =?utf-8?B?UjR0eCtja1NYSU81ZkxqNm1TRk5oV1dtLzZWNWFyclhuWVRZa2FFODhrU3Rt?=
 =?utf-8?B?YXN2N0NncmVSRk1JNStDT3lKRUUzWXgzSlg1Vy9GWFg3ZmpIMGpUWG5iaWxF?=
 =?utf-8?B?R3RyMStCbExQYmdpQUpPeFJqZEUzL3h3U0pvZWdHeWhBb2tXVzNuSVpvT1pp?=
 =?utf-8?B?eWpkMDNCVCsxOFZ6NWVSd2IxOHdycXNUZ3orTjBRU3JnTDZFTWFKOUdUMEFj?=
 =?utf-8?B?Vi9ORmF6T2FSWVordHZ5dDN6U2Q1S0VvTlp2ZjVpZnZhY1hPMjd5dWxyeDkz?=
 =?utf-8?B?Z1daV01KOEU0b0E4bUQ2ZEE5RlNNelZIN3VhN3lISUNueEV5QVl4QW95L0J3?=
 =?utf-8?B?RkxSNnJGZExRcUdwTUtibTVoeGdhSHgzbDRjY3Rza0tSMWJCSFFzUG5mbFlp?=
 =?utf-8?B?aHRSWlEyTjlUbDhVUDVLaWFmY2pnenRWeVpCMXJqZFpzaGlYK3ExQm5KQTRy?=
 =?utf-8?B?ZnZIZUlDUHhuczRPMjZhem9SSDZuRFRxcjFpMTlrMCs3bnU2MDBSVG1YY2Vk?=
 =?utf-8?B?T0FzeEo2d1J1Q0orQVZ6cWVlV0NYaWlyZ25RRXZ1dVdEQnVEVTBzUVJUVmVn?=
 =?utf-8?B?aHdqT2J0TjdhUkNSeG1oQzFxK0tVQURFMWl5ZVZ2WUJUOHlIak15Q0dLSkFh?=
 =?utf-8?B?ZEdjVlVaUGx1MGdFMUlhbFlscU9ZeFJHWDBsS2VJRVR0Z3ZjU29jaEhQS1VF?=
 =?utf-8?B?YlNDOXBMVUNoa2xiQTdNQVJTM1R4QmYyWjZQV04xRTVKNS8yd0Q0Qk5XOFBp?=
 =?utf-8?B?cmJ4OGxNdlpNSWFZQlp4U0VLdWNJTzBoM3ArSTcrYWsxKytlYnUvQWFtZURQ?=
 =?utf-8?B?SnhsdlkxV01sVzZISnBEOG8vNzhQTU5ybEhkM2EwTEhHWUZyWkJjUWN1V0ph?=
 =?utf-8?B?Z1V1aEpvTkxOVXJHYXBZNm1kSzhUTDZCa3Y3bTlHNk5rekVGWDhNbnpZUFBP?=
 =?utf-8?B?M2tyRzJCWDEwQjdpQnZNQ2xKSTRkbnlkS1BMbURvK1lRbm5DM3owbDJ0MzJ1?=
 =?utf-8?B?YVBtM3FQYkNYL21UbUZhNzVLUTNueTlQUHlURms4UUpJUmhiTjBkTEFteml2?=
 =?utf-8?B?dllMNTYyZCtHeVQvd1BGTWJwYnI0emdUL1pnRk95R0RXc2tsOVNYcGowSG45?=
 =?utf-8?B?Y0VPcXZrUktXcEN1ZjhwRjNLcW5YQXp1Wi9FVFVHYXBjTkZUYWV0UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb7f138-0085-400c-51df-08dea6f92c9e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 20:43:46.0217 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sg/dMbA7s6H3cVY6JoKcCtdLqfMw5g4yQ3R5aI4KQXT2RDd6arD24m+KZ3W4cwtDjx46Upl0AP36WRUB15/b5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5633
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



On 2026-04-21 17:08, Alex Hung wrote:
> 
> 
> On 3/30/26 09:34, Harry Wentland wrote:
>> For subsampled formats we need to use GAMCOR instead of
>> the DEGAM block. The color module can create a LUT for
>> that if we set map_user_ramp to true. So do that when
>> we have subsampled formats.
>>
>> Co-developed by Claude Sonnet 4.5.
> 
> This should be updated to "Assisted-by Claude:claude-Sonnet-4.5"
> 
>>
>> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
>> ---
>>   .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 34 ++++++++++++++++++-
>>   1 file changed, 33 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
>> index d5b4190e635c..6403dfe4ee10 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
>> @@ -1471,6 +1471,8 @@ __set_colorop_in_tf_1d_curve(struct dc_plane_state *dc_plane_state,
>>       struct dc_transfer_func *tf = &dc_plane_state->in_transfer_func;
>>       struct drm_colorop *colorop = colorop_state->colorop;
>>       struct drm_device *drm = colorop->dev;
>> +    struct dc_color_caps *color_caps = NULL;
>> +    bool is_subsampled_format;
>>         if (colorop->type != DRM_COLOROP_1D_CURVE)
>>           return -EINVAL;
>> @@ -1486,9 +1488,39 @@ __set_colorop_in_tf_1d_curve(struct dc_plane_state *dc_plane_state,
>>         drm_dbg(drm, "Degamma colorop with ID: %d\n", colorop->base.id);
>>   -    tf->type = TF_TYPE_PREDEFINED;
> 
> 
> Setting tf-type is moved to the below if-else branch, but both set tf->type = TF_TYPE_PREDEFINED. Is this done intentionally to improve readability or for other purposes?
> 

Good catch. I should've noticed this senseless change
by the LLM. I'll also clean up the comments for v3.

Harry

>> +    /* Check if format requires post-scale color processing (subsampled formats) */
>> +    is_subsampled_format = (dc_plane_state->format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN &&
>> +                dc_plane_state->format < SURFACE_PIXEL_FORMAT_SUBSAMPLE_END);
>> +
>>       tf->tf = amdgpu_colorop_tf_to_dc_tf(colorop_state->curve_1d_type);
>>   +    if (is_subsampled_format) {
>> +        /*
>> +         * For subsampled formats (P010, NV12), we need color processing
>> +         * to happen AFTER scaling (to expand UV channels first).
>> +         * Convert predefined TF to PWL so DC will use GAMCOR (post-scale)
>> +         * instead of PRE_DEGAM (pre-scale).
>> +         *
>> +         * IMPORTANT: We must pass map_user_ramp=true to force PWL conversion.
>> +         * Without it, mod_color_calculate_degamma_params() returns early for
>> +         * SRGB/Linear TFs without converting to TF_TYPE_DISTRIBUTED_POINTS.
>> +         */
>> +        tf->type = TF_TYPE_PREDEFINED;
>> +
>> +        if (dc_plane_state->ctx && dc_plane_state->ctx->dc)
>> +            color_caps = &dc_plane_state->ctx->dc->caps.color;
>> +
>> +        if (!mod_color_calculate_degamma_params(color_caps, tf, NULL, true)) {
>> +            drm_err(drm, "Failed to calculate degamma params for subsampled format\n");
>> +            return -EINVAL;
>> +        }
>> +
>> +        /* mod_color_calculate_degamma_params sets tf->type to TF_TYPE_DISTRIBUTED_POINTS */
>> +    } else {
>> +        /* For non-subsampled formats (RGB, XR30), use predefined ROM LUT (PRE_DEGAM) */
>> +        tf->type = TF_TYPE_PREDEFINED;
>> +    }
>> +
>>       return 0;
>>   }
>>   
> 

