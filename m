Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86002CA5FAD
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 01:37:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C18B210E534;
	Tue, 29 Sep 2026 01:37:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YJkLfU6x";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012006.outbound.protection.outlook.com
 [40.93.195.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6660A10E534;
 Tue, 29 Sep 2026 01:37:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=faVt/tKJxvkvaaAyeSpb8PBFhzb0Ehm0fntrg/zjzX3y31eIn9A2g69JFBi5Ym6uYIVh9BxLrv/kQOUktqyME9QWxGmBT3nEmDNho/LtZ8lEEJu68RpaBGkDPwwByloTsYQvAn55ijcPJFAQXIifD9MDfH/tPH08e60vymweOT+4yfBAZce8Pnpf7pfdS5m6ZWBcT6MMBs7E12HPzNli1fNge9+/LuHIQhSD2dj4YhIHayFZvJ4jz7tZToWCwdJyCzU1UAVaL5Ncz/ziCh0631X2Bqy9Onnm8yyZYELnoDppYtV2V9/BWVsW8nao33+HWMtXPmJTYQJljGu+dZHuYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmdkqeoDyNSDzB31vA4sXTK62gE9gkoW3BWzHM9iHNs=;
 b=bPlA1ckPCNUMxQPJeWD2YNuv6+U/POlW4WHm+QcUCI3zSNAx5Lg0PcTu6wm5R31Pa86IyoBaE4onkof/MMCARZKfTJAnW+ZCjVR36bPKIsx9Gbj8ey6hazY69Q77/gPh62T1h0+eHMtAiIf5wU/hvo9TmjXXdcMAC4CkrbihnNN/+WKMK18KB75I3RJgn0SJa3IgZmdEncsWukjq6sYpR5tHbI6WBu6OIAyuLSbOer4iBtnXMD9EyxORS0YIDH0kvUiFr5xe+gte+T7ZuPIHW1e1xABPgtqfUm0tXwDHZe0Ssq4DFjYvuYLu3xXwf7c3pDkOh1GuZ7RAvRN1xPPn+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmdkqeoDyNSDzB31vA4sXTK62gE9gkoW3BWzHM9iHNs=;
 b=YJkLfU6xnQ7pDDQQiiWz4LB13sLN4UvK3AUzEXsJ8sjevlzjAIXhmHYn30EFV+e30NTQzvw/pg8Og0weahVxN4UNciUdig+cR/kFLNMW3ryrMMjzTaB9EMT8KVefxEPaZqyXL12YWPBW5dmfuJqNxup/dsyN1KkVYmu+TUe3zNk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CHAPR12MB999225.namprd12.prod.outlook.com
 (2603:10b6:610:2fe::11) by DS7PR12MB5813.namprd12.prod.outlook.com
 (2603:10b6:8:75::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 01:37:20 +0000
Received: from CHAPR12MB999225.namprd12.prod.outlook.com
 ([fe80::a4c2:82c3:da88:c585]) by CHAPR12MB999225.namprd12.prod.outlook.com
 ([fe80::a4c2:82c3:da88:c585%3]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 01:37:20 +0000
Message-ID: <cfba3d1e-5311-434e-be7e-d11523901565@amd.com>
Date: Tue, 29 Sep 2026 09:37:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 2/2] drm/amd/display: Keep backlight precision in
 millipercent
To: Matthew Schwartz <matthew.schwartz@linux.dev>,
 "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <20260916191102.1195881-1-matthew.schwartz@linux.dev>
 <20260916191102.1195881-2-matthew.schwartz@linux.dev>
Content-Language: en-US
From: Ray Wu <ray.wu@amd.com>
In-Reply-To: <20260916191102.1195881-2-matthew.schwartz@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0347.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::7) To CHAPR12MB999225.namprd12.prod.outlook.com
 (2603:10b6:610:2fe::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHAPR12MB999225:EE_|DS7PR12MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: 11ee0dc3-6862-4d1d-7c38-08df1dca342f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: v/UgWW/C6zl0TKvbGTXUsvj5kX7iW9en9O5+ecANGzcD5Pulp8yCiW8PoGB5RWHBgVRMdG/Zfy2mcuO0oh63+DWNpMMwjPoH5U3ZdpLpli4URoC7VcWp1RiKE7bYpXtpiLkOMFBBE4TRcPiDxXBawfQ7VLaqmXXXij62u2lr2oLsBPUy1F64KSKy+Hd3WECpGOjyqgpKqKgZ/mE7JDqml6WYYAa2fSc1xuyaGqpJnmqMC2C/QMDu8Cc1loWD1DBPqhk04sJk1W9kWwtE9XJpiYd/wQaWZtgRPPsqB1B72myhFbrn70YokswixtGE6T50th5OTEHjMLKrMzEHe4pGrkfSllv1hx3+5d8NTmxGzFeLRdWg6OxyPru6+s4dB5QojRbeY6pJnyALFlKCxthfeKiQArp7cAArDr0iGdjTxp2DYRMtFj9675LkTdlHqeZ3SWGwSBX09TcMVovSzKPg53Cs40UhWBcUpnS4pkhp7+PFY75zFGbZ+6AxjiYickFJA/gpzh3DORXxlttVM9vFRwqDCjMkcnSWpwwgt1WmpGyWP/s2VvI/mlVN9nlT+7g2/dEw7Ki2g4ZZJUpzMV8vahqYMMp4mMWrSJt4Ndfxs15CeTtSFqhR6+O7pOqS3lcJZ+OBYxsMCxjsC4AsLyAO/CTAdL3CpSMYfMKp4d5hxkI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHAPR12MB999225.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0FzSjFHV0NnVGdGRkdEclZqRm1XUjNqa25ZMU9rYVlEcE44MG1CcFRpNWE0?=
 =?utf-8?B?Z3ZwUERpeE1FQjZqRjlvWmErYVVrTXZDSjJMSGZMOHJ0RzI2cGo0aGIvVGNw?=
 =?utf-8?B?WE1JaW1HaTVRaHFLd0htWVZ3RklNNzJxbCsxY1FtaTJ3UVYxSkRZdU9YZDNM?=
 =?utf-8?B?aHpZaHhOb0lPRE1CTXFKMGVub05SeVY2VzlWdDBFY3Y1a0dNMWs4ditBdDBi?=
 =?utf-8?B?amRFcURTazJOU21Pb2c3TkFFa2hhSVYxSFM0emk2dmVXMXN2MXN5Rkc1cmwy?=
 =?utf-8?B?ZHBPdXVqM3JxbzdiLzBRbkl6cXhqMkdJWUxsc2RsWG92NmZIbWkvQ1FVakNU?=
 =?utf-8?B?YXRDSTk3MTJmajhPNE94SCtjSVdqVnRRNVlnV2VEdEpNdytJR0VOT243aGZh?=
 =?utf-8?B?SndIcVY3bGlONUF6WjAwSjZBS3RwR0hTL1F4M09sUVdKYjk3UmRpY1VpTU9o?=
 =?utf-8?B?VHdmckVUakRwK0ZWQldtQWI4eTFtNDRlRlNxWFBGZGN5YUdsaVdjOFNIanV3?=
 =?utf-8?B?bmlNbGQ2QkdQYlNXV3MxRmlGRGk1T3VHeU0zL3dMWnQzaStDSkRLZGJHTC9s?=
 =?utf-8?B?VXN4WU5GR2ZCV01QY2Nkd1dmaWJsaEV0MDZoZEF1enJnN1V5RGNRbW4yL3Y3?=
 =?utf-8?B?VFZzYTdNN090Vm9PQWZMZnFVZEVoc3dXWW5rRWk3TG1JNW1vY09RQVQ2N2d6?=
 =?utf-8?B?ZzZja085aUNTZG1yMGpmcTVDRE1DTHBWKzJtbGpZWTFNMXd2Y1ljTFB2K1JF?=
 =?utf-8?B?Vks1bHJ2aHZNYXF3eGFnM1drZzVZa1BlVEJtVDF1eCs1QlhIak5TeEZtclF1?=
 =?utf-8?B?YnVaT2JXYlR3VllPYitTcS84TmtzT3VQV2E3a3I1U21RRWloRW01TWZWWDV2?=
 =?utf-8?B?Y0dlU00xMHMySTlqRzd2NFIvSnk4d0VrUjdMUk9nMnhTWmFwNjFJS2xXMzFV?=
 =?utf-8?B?YTA5V2JGQTBEckgxdWcwcHhaNndvMGZhV21EbC9IVjNRQVQ0MERTOUFHYnVN?=
 =?utf-8?B?dWNTWk5JUWcycVpJbk55SDVpUDNqeUNSVXR3NDJPR3l4MVFqVkNVaGFpWjZn?=
 =?utf-8?B?SjlmVXdZN2VWVmdWOVUvSUdxeVBwZVc1dnlBVzhBcEJuWGtrSFd2c3FBRHNw?=
 =?utf-8?B?MWF5QTVkVXF5S1lha1RtMDVkd21wT1U0NXJueFVOVXJtUmhFRlZndE5iNWYy?=
 =?utf-8?B?YXR3YW0wQjJXNHQ3K0sxMzJBREQ0NnVKUTFpTXB1a3BmVzd5T1ByTWQ4MnZt?=
 =?utf-8?B?RjBMWGxKNi9WckNDakx1NkpYdVl4VFAyUWdjQk1iMlJrYlhRR1YzbjlvVFJL?=
 =?utf-8?B?SEZUdkhvZGFBR0J4cElNRXNCdWtXZmNzQlIrZ2ZqMjhoQkx4M1JOclpWbzBr?=
 =?utf-8?B?SlpUNWhaQmlDWmxScjdLa1NPU2Q5ZWR6VHNDb1ZkeW9DYUVZZlVrYTE3bHdF?=
 =?utf-8?B?dHJhRndtMDJOOHhiQ0piVnluRUJPa2FDOWo3cU5CdVhmeC9DWkVORGxqVUQx?=
 =?utf-8?B?UTdremdJZCtreUU3eFFVaDhtT0xvSzYyVlBKY0F0V2JzL2tvb2Y2eTR4NWVv?=
 =?utf-8?B?QWRUK2RsMlp4OGJucldITWN3R0FkS3hRTmRsa3dud1V3UVFEWHc4RGhPNmgx?=
 =?utf-8?B?MXJTS1MvVmx4N05lNnJoYVp0czkrN1VrK1YwazBuZXJVZDg3WHQ1cUR3ZTUx?=
 =?utf-8?B?c3p1K2J0Zit4M0RWbklteFZEdDdEbXdCeUZRVm5PcStiN29DdG1rWk1BNnk0?=
 =?utf-8?B?WS9lYWh4OVdpNjUwUU9zdEF1L0Q0b3RkZXdaQUhnbm1ra3IyNmZkNGZ1SXUy?=
 =?utf-8?B?eEh0am1KK2lkMFplaGdqclVjSXNtK2VodWY3RzJmSy8yc2xySlhPMG5FTUVr?=
 =?utf-8?B?Yjg5WW1KKzhycms0Skd4K0dxNVkrM0pOWUVIdzhGR0JDY3V4bUpWUFNFMXZj?=
 =?utf-8?B?bWt0bDdrUG8rbDVRakpydmsyVlArUUVSenhiV2xjczB1S2lzVHcybE1kM0Ni?=
 =?utf-8?B?QWlDeTdkamJ6b1E4NGlEb3ZzUTdXOEVIV0FpQ2NlTHFCMkxxVmVDR2gxbmly?=
 =?utf-8?B?VlFaUUd3SkozSEIxVlNkK3E2UFBNRjhrM0Rxd1RqeG5YQXR6VEJuVkEwRndX?=
 =?utf-8?B?aFd1aVA2eC90NXdFV3FJUmsyMW14Q3p0U2pTWkFaQ3NEbUwydHVJV2x5Tkd5?=
 =?utf-8?B?K1M5MFNhMmdHb2RGdnJua0ZURUw2SktXbTVDWnlkdlZSeEtNZGp1eCtDYlVO?=
 =?utf-8?B?QmtJT3JjSGJ0YlZwMndYZHhUdDRIQXBCU2Z0bHN5R2U0V2VSSUpnQ0pSOWRG?=
 =?utf-8?B?QlJzanp0YWZ2NXRzWFZ2aUYydURCSjN4anhma2paWU5xSmdaUlV5QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ee0dc3-6862-4d1d-7c38-08df1dca342f
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999225.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 01:37:20.8298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sbIi5ZdCviHIYWv9BhifmcU0I5tkhQF5fLAjTv+wUgUIInBi01CmHRwmPhbDrWaXSLhYfvnC6OOrLrRLSAAToQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5813
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

Hi Mathew,

Same as your other patch, a similar change has already been merged into 
asdn DC 3.2.400 release.
     commit: drm/amd/display: map PWM brightness through custom 
backlight curve

Please give it a try, and if you still see any other issues, feel free 
to send an updated patch.

Thanks,
Ray

On 9/17/2026 3:11 AM, Matthew Schwartz wrote:
> The power module takes the backlight level in millipercent, but DM
> rounds the 16-bit level to a whole percent before multiplying by 1000,
> collapsing the range to 101 steps. It also divides the absolute level,
> which already includes the panel minimum, by the min to max span, so
> panels with a nonzero minimum PWM overshoot the top of the range.
>
> Scale the offset from the minimum to millipercent directly so the full
> resolution reaches the power module and the minimum is only added once.
>
> Fixes: 3c108046e1d6 ("drm/amd/display: Add power module on Linux")
> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> index 45e1732a5b04..079277d47b3f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> @@ -326,7 +326,8 @@ void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
>   	} else {
>   		/* power module uses millipercent */
>   		get_brightness_range(caps, &min, &max);
> -		brightness = DIV_ROUND_CLOSEST(brightness * 100, (max - min)) * 1000;
> +		brightness = DIV_ROUND_CLOSEST_ULL((u64)(brightness - min) * 100000,
> +						   max - min);
>   		rc = mod_power_set_backlight_percent(dm->power_module, stream,
>   						     brightness, 0, false);
>   	}
