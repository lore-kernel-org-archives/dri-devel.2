Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38499CA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 01:35:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70B9110E7A8;
	Tue, 29 Sep 2026 01:35:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cCyVJDwz";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012041.outbound.protection.outlook.com [52.101.48.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 827DD10E534;
 Tue, 29 Sep 2026 01:35:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wH+p+9BfHmEENw4zfDhmQL+kbvNoDdLYX8hpeXiA6BNB6WtnVvGyMr9vNDXl4G54O7zehuRBgFMqARhYULulVnTIK8wmi8C0Hyzwod031500poFmEGBQkVjbzhT4iQou6dUTKKW+D9PMLOw2SSuhMUEao2iTTGxe6T0pwFvIMSLYd1dp+Y1GB5FU0iVuxrkJ5QnJfGVyjhlqiEvKMdLHyQavVhZE575jogQU7QRA1FyW+Xl0btzMKZ3U6nJgZdXnzkjP650pGcBJ4v8/lP3FWIBOftrwDf8xJuG4PCfD3C6mO3+K2hCeZbthBd5jEMentwWeI48a7M97F3UdA3FtCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58thUTr1TfraDnTYMSfiJGBoRksnF06GzOzV2SKTmJ4=;
 b=rAf6Ue0aMCpO7GIoO/dSSJ18kvAsoy+Rake3JBDB7IVS6V1auz8nKGEiiKVUPljjgnSI8uLagqtCAC163NKda6o53DN0ltThLB4clrCI8pMZ3GgXaIoX4byWg7uXDkDca4k5n1PofvUrFZIz3RFfdlk4ve9mbmb6wYqqYK9eg8u/LdBYiWZhCl5h52rN7Q2I4vf1yUMUkgfesu36nf8awZlAxiMQKy/hWfw9MTMpwSeXOZK4aworwj/XBJ1xFBONUCFF4RBM0U4z9SKiA9Tdc0VaI9Ypy1Wz2fCPxY8H1W0u40ucyqYBL4FG+PjvLvfCydulMb4p4JHNV9Rn9qE4ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58thUTr1TfraDnTYMSfiJGBoRksnF06GzOzV2SKTmJ4=;
 b=cCyVJDwz4TQjU7EqbcMhJiP6IfpYHwFrltZpIwvnymU1HaGBN9SNrs/ZQhhXKz3Gz8zPMcpHibwHxcmftzUNUr2aWS8E4ruQgZZMnjKwj/jBa7GExTWAi9NFWVoMi0bOtkmcCZDmmlUPEkcTmX/dJWEcAq9bbyBkXkpkJ3R0nWE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CHAPR12MB999225.namprd12.prod.outlook.com
 (2603:10b6:610:2fe::11) by DS7PR12MB5813.namprd12.prod.outlook.com
 (2603:10b6:8:75::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 01:35:06 +0000
Received: from CHAPR12MB999225.namprd12.prod.outlook.com
 ([fe80::a4c2:82c3:da88:c585]) by CHAPR12MB999225.namprd12.prod.outlook.com
 ([fe80::a4c2:82c3:da88:c585%3]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 01:35:06 +0000
Message-ID: <392ba6d1-1ff8-4ba0-8b71-d794336cf4e9@amd.com>
Date: Tue, 29 Sep 2026 09:35:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/2] drm/amd/display: Use linear backlight curve in
 power module
To: Matthew Schwartz <matthew.schwartz@linux.dev>,
 "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <20260916191102.1195881-1-matthew.schwartz@linux.dev>
Content-Language: en-US
From: Ray Wu <ray.wu@amd.com>
In-Reply-To: <20260916191102.1195881-1-matthew.schwartz@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0358.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::9) To CHAPR12MB999225.namprd12.prod.outlook.com
 (2603:10b6:610:2fe::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHAPR12MB999225:EE_|DS7PR12MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d18537c-df48-4d24-a821-08df1dc9e3f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: qPi4xmYIjgKCNJ2hMMMkMAzjsePUS0jsHa9Ra+uw9Ig5rgK97B4q1x8xNHU8zBi3IH7/PXDm5FXrHvbZ9zSpstMQcxHIdvdTxcb2fwda4u5gPvH2ypGPIku8ZiN0ffK6FHa9Hq2vqMZn83Qgb87WEenwWS54+QflmzFz41vRVv7LK0CvHfAWMuAklDl8Rbns88s4QnGfjHHEb+UlEs3UDvMHPJ4qU9mdKttTgsrI4FN408M9K9jjedVGVEPJyTjg67GVqrtK9DZ6Dz/bel4NsNWd4MXjiKuj9xOcmHnn17Og96+7b8P2zNTfT2eXrKPrWyKdPLKSQKKZVoFxHswv7hDuJ/vXmlKD1aa1bNsuln8g3Cb8AkL6D6MnCVwQxEi7g+k2IIxY57ZvZXi0QtYTOrKr2BqFAshUAMBeUdf6NzRhkdV2vmxDVbGPEjzAoSzoiMMGiySuQjI2FYjnTIzP3uQk5LpZCs/Mz2hG6sfWyvZsTst3GJ5BtWdbfOJz6boYhAg7TPwoMZL2FSTYColaZAPJarq3Pp176/ibYD2dWPcUuo6g1UjLAAXTVN4jQbGVU0WKwtVZACtLHi4Ysq1iFXIle/dJa+YmyqLze9Vm1C/dlUQXSSB1ROCAx+TDKFgRZY/1bAGzi5kSHkMl91moEK4hJlVIIrHSpCXT7SiSDoI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHAPR12MB999225.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkQydHZXTlZyeGkxYkVRYnhQcXJxOXVKMWNEeE93a1QzM0RUTUx5SWZvaVNY?=
 =?utf-8?B?Vno1R3YvM3hZUVFPR1NLck5wUmJvVXJlZlA0czNIcmlKZzFIOC9LWUcyOGNh?=
 =?utf-8?B?dU5lSDR2TEJSOEZvbzVMYkt6UmFhR3Z5ZGV2cGozeTFKYVBjVFZYQ2k5cGpN?=
 =?utf-8?B?RkFuamhNYmdEN1ZCeUdVRjhocS85WWFBUDcxT05pV3RJS0kwMHpEWE9OQjdT?=
 =?utf-8?B?MEtGeEJXSG5UT2w1WVJKZUxwTVB2Y012amwrcjRTNWRacDE4eEl1SEx5SDZD?=
 =?utf-8?B?amYyQnl4dGNCWjlwSmpuZmx3SjZGemF6WjZwN3FoRXRNMmg1MXd0WXF1RlJT?=
 =?utf-8?B?d2sveXVqYVNyQ0FBbU1TL2R6akR6NlNzaTRoVFplOVNGYmZQbXlQOWM0eEpa?=
 =?utf-8?B?M0EyZlQvQ2xqV0t3VzMra0o5Wmd6WWhVUHlxREpXNlJ0eHExaXhFQjFVYnVp?=
 =?utf-8?B?cGtrQWtrQ3FHc3hLT0hRQjMycERFV3cvSklzWmY2R2ZkRDljYnRyMEFNd1Bq?=
 =?utf-8?B?dkQ0Z3JiSUhPWlFUdmJTWWRoM1JWNFRXeFF5a3orMHkrSEptalhORXg5LzFV?=
 =?utf-8?B?M1ZNMy9SdXBTcVNYTkRHQnhWQVV1UVpuRjkxNExNYWorNE1JaTZaS2czQlFk?=
 =?utf-8?B?ZjNQZWVGTjF1bXVJdGo3Uk9FZDFWQTFHVU1NVFpCU3duU1VFdGY2NThuMkNl?=
 =?utf-8?B?Z1VWUmpIUTBZUyt5NDR3dGo3M2hGNFZrN2ZMTkErbjJUZHVkNXlCKzZCUS9L?=
 =?utf-8?B?enBrSlJudnU3cE1zcWdTcFVBM2h3ekdscEd5NGVzTzFZRTVza0Z3YTU4K1Vj?=
 =?utf-8?B?YXQwS255NEtwMUFwN2c1MEZwZTRKcjM2bWk3aVpqSjd2YlYySUkxZ2djVXlS?=
 =?utf-8?B?SzFPVHdTRXBkMDYvWmFFWlgzSnFtdVJBQ2VJS2lEYk9nTW9BNzBtVnVHRUFq?=
 =?utf-8?B?cllUWVJaSHRLOTl6VFhOMVN0TUlXM1Q2ckxJZ00rTlhBMTFIWUVqd2k3NHdH?=
 =?utf-8?B?U0pJVktiSlhaS2txczlENkdFM0R1cjdYSWFBTFBJSXJaMGdRazBXbkxaVTMz?=
 =?utf-8?B?Z1RzWk5ZeXp5Yllvc3cxVVJhTnhlUitTUERxMnlQZG5LQSt0YmVnQXBtczVl?=
 =?utf-8?B?MXFSRHdJdVhpY2ovMEhlaHh0eEpFVlhoanFCZkRWUERBWDVWa20rSGk3LzRW?=
 =?utf-8?B?bmNQVDdOcW5SQzFWVTA4MUE0c05TaUVsaGYzVjNzTmxkT0l3WGRtODhUblo1?=
 =?utf-8?B?U0tnQmlteUsvSVIxLzMxVXpTMDZmeWQ5M3VVTXpQeHhmQjAyTTRBZ0pDbG1C?=
 =?utf-8?B?akZNNHptSGszamxqaTdhUHJ1bWpjTHk2dnU0elFBdWdWY3k5RXo0dU43cW5w?=
 =?utf-8?B?cmV6TVJmd2FQQWpLQXZ5VDlSaVgvVWxEb2g5K3FFb0tENC94UDdOSElCNkxO?=
 =?utf-8?B?bUsveEczbWRoa2FlSHZQeHZzOWZOU1JONjkwVS9RME5TUVJuWTUxTlE5cHZp?=
 =?utf-8?B?WUNvekJuV3pvZSt5b0VpaVc2UHJMeEgzZWxSWU15SktWMWVQbVZZTkRSQUNL?=
 =?utf-8?B?b0J3L3MxYlBPMXNOZTZGeklCVkFzVnVsclBUMmZ2SlRiVHNTNWR3eVh0QytL?=
 =?utf-8?B?TElUR0NrVjNDMW1vaDhVQXY2TGpTZndPTVJPZUQ5MmI0dXBQcURTbDhCV2tG?=
 =?utf-8?B?TlZoajcvR2NwbzE4enk5ZkI2ZTN5YmlwSm85a3RHVnVTUHhHTytSMzZIKy9Y?=
 =?utf-8?B?dmRZb0FRMnYzcWtlYmRsM3FkaFIrNTVtcm1FTFk1VFNyVXFvNHVoU2hCbDlN?=
 =?utf-8?B?TU82OFJuK3N4bXo4UXZNMEYrSnJENnozYldGeFdIN3hsem5FWUhqWGpwc0wz?=
 =?utf-8?B?Nk9xTmdSLzkvOWJId2RvakFhUkxUSjFieFpxbEtjYmFNOXo3V2ZZeW10WW5E?=
 =?utf-8?B?SXdEbHFhNEVuR1REdGVXYUROTVdpRFFtTHlKWHYzMVpkc0doR2d5R0IxSVdM?=
 =?utf-8?B?RXNJZk56ZlhkYytxMkJqVXMyUmo3MnlxazJ2NjM1cFlsRDJKN0VDUTd5Ynho?=
 =?utf-8?B?bytRTU03U085V0x1Y1BZeDRiOU05cHZKY1J6QnVOR2dlWEdmTUdISkNjbG9K?=
 =?utf-8?B?b1dGLzQ0dHpsdUdzZ2RwMUJBMjZOMVJWK1Brc29nNU5nb0ZHaUNZVk1TTk1N?=
 =?utf-8?B?Nk5JdUh1TFRsYkMvaXZhaEVnNEFGYTk2R0MwSmZVWUFrMTZzNzZUOUd3d3JC?=
 =?utf-8?B?OTZkNUNiL0Ewc2R1ZFNnbk9aY1M0WGdEQ01hRnNVcFlrT0poZGUyNWtob2NN?=
 =?utf-8?B?M2loWDB6NWtLL0FRYW5MMFR2QldVcGpjUUpMNy9xQ2VQWWlIOHg1Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d18537c-df48-4d24-a821-08df1dc9e3f6
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999225.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 01:35:06.2599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLy81Qf8ihGUsxgI5cFvhRHHj2a+DWGXc8zh+trdkoB3AUoYp0ZMpObDfSWWkBi3kcfG/MPk/cGxDb9/mkxC9w==
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

We have a similar change has already been merged into asdn DC 3.2.400 
release.
     commit: drm/amd/display: map PWM brightness through custom 
backlight curve

Could you give it a try? If you still see any other issues, please feel 
free to send an updated patch.
Thanks!

On 9/17/2026 3:11 AM, Matthew Schwartz wrote:
> amdgpu_dm already applies the ATIF custom brightness curve in
> convert_custom_brightness() before handing the level to the power
> module. The power module then builds its own percent to PWM LUT from
> the same ATIF data in initialize_backlight_caps() and applies the curve
> a second time. On the Lenovo Legion Go S this maps the bottom 40% of the
> brightness range to under 12% PWM, where the panel no longer visibly
> changes.
>
> Tell the power module to use its linear curve so the PWM is a straight
> rescale of the level DM computed, matching the behavior before the power
> module took over backlight programming.
>
> Fixes: 3c108046e1d6 ("drm/amd/display: Add power module on Linux")
> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index ca795cda8084..63acefc0acfb 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -455,7 +455,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_init_power_module(struct amdgpu_display_manager *
>   			!(amdgpu_dc_feature_mask & DC_DISABLE_FRACTIONAL_PWM_MASK);
>   		init_data[i].use_custom_backlight_caps = false;
>   		init_data[i].custom_backlight_caps_config_no = 0;
> -		init_data[i].use_linear_backlight_curve = false;
> +		init_data[i].use_linear_backlight_curve = true;
>   		init_data[i].def_varibright_enable = 0;
>   		init_data[i].varibright_level = 0;
>   		/*
