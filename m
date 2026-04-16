Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C52F8D76E
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 19:22:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0769210E16B;
	Thu, 16 Apr 2026 19:22:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RJPiWnJ1";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013062.outbound.protection.outlook.com
 [40.93.196.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29BB510E16B;
 Thu, 16 Apr 2026 19:22:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0wJ2zyWJirHpd12NGK3SADkx4zfbdr0e9121y9m6d4fXlEjAK7B+Itk0kAX3IGaLWScsysUROoT+Qwx7nIW/Y8SfVDd7LMjKWyTGf1RGgTkSxmumGftrOe2QKrD8qXGC0XYtZWLboqcqXmCojWzKL0clYJ6OR9Lh7/BkQz8fXQfdF7FtCEIkPdzSJX8+gZY5oOjLA+pWqaQkVnZWakKhWOB4X0DkK3uJLQToMFS8+cdn5FkTFpXCmjgw+pOm+NvPBfVa4TN9SbTYTynNBapuZ9j6yl1coHp7w+i6neTMVJ0Iv9o7EX5QID1GK0QwDlk4TWhpgefqnekRqtTRQT4gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KItRsuzEVE7PvrJuLdM/ZkZNUlrU7dZFoalnaL53smY=;
 b=YWbWNuIRuqjm9k/lVxImkubO4+9yZdWo8d94c7BFxyY9lyr406EWNFgOR8hZ03GgD+UyShzErbCssoLSfr2w1lP099W08QeuNXD0n+z8VFpwTZRO+WcoCF+qh/zR3S0UvlNZxZlF3v+FyjM7rwDb4I1URaGsDgEAVy63ZvWTjg77wtqguLlOlKuhdIkXYZNL8EY4s0/vBu6uyikC7yukxuMQ/mQt/jShHlis0ReWuyYm3o6y9lfH939j8ACfmnD4PhMSmf1V9X9FYlLpXbjvXyMWB7VPew3kKSTx5K6JdXgBKswbyTWHNTaiTKmAdlMyNGB68RS0fu6sfFbOxtgY1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KItRsuzEVE7PvrJuLdM/ZkZNUlrU7dZFoalnaL53smY=;
 b=RJPiWnJ1jJSRCvTAtrnka49+99pmNtr/YuT1OJRuAGlX4zUTRCmSw0XhVGjQKOKh+OQKy85tBZMWTN0xLDEzxC+ARnuFygTNr/WZrI8zC1dUvhgqoS8fJoz31KaT3DR92G12r8/SRt2HjhI/weXXP3mG3CEcL6pa+cYyuic52G8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5213.namprd12.prod.outlook.com (2603:10b6:5:394::16)
 by SN7PR12MB6767.namprd12.prod.outlook.com (2603:10b6:806:269::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 19:22:42 +0000
Received: from DM4PR12MB5213.namprd12.prod.outlook.com
 ([fe80::5d60:577:358f:89c4]) by DM4PR12MB5213.namprd12.prod.outlook.com
 ([fe80::5d60:577:358f:89c4%6]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 19:22:42 +0000
Message-ID: <c030e9fc-d88e-47f9-afd7-9a4a0a53f4d3@amd.com>
Date: Thu, 16 Apr 2026 15:22:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/amd/display: use a separate helper to translate
 degamma curves
To: Melissa Wen <mwen@igalia.com>, airlied@gmail.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, harry.wentland@amd.com,
 simona@ffwll.ch, siqueira@igalia.com, sunpeng.li@amd.com
Cc: Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
 "Dr . David Alan Gilbert" <linux@treblig.org>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Alex Hung
 <alex.hung@amd.com>, Aurabindo Pillai <Aurabindo.Pillai@amd.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>, pekka.paalanen@collabora.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com
References: <20260414220237.184289-1-mwen@igalia.com>
 <20260414220237.184289-3-mwen@igalia.com>
Content-Language: en-US
From: "Kovac, Krunoslav" <kkovac@amd.com>
In-Reply-To: <20260414220237.184289-3-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::28) To DM4PR12MB5213.namprd12.prod.outlook.com
 (2603:10b6:5:394::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5213:EE_|SN7PR12MB6767:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b267f2b-9bf6-4db7-e1c0-08de9bed87a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: E4ThOcKgJJ4ZRkRRqSBX4WsJ0EsyPTu2z4h0iDkfAMWLtrIFDCLL1LoJYN03ppAtEm538PpM5dIa/oOtmwfN1tgBiKGDUdEkGQk8Q24xSf45VjQWAYR+a8EUk2V2CBlp87kGoGRzMR7aMiV9OxF/ZZiHlzn/ru9jG7VmGIFUc9CWQ7/O4PnwRSMQWaCAIsmSyM6LLa8zvt6vSfyWZigmqDz+cW2VInqQ53+E6Wi3W+8LMQNg8uRSDbytn/czSPm7dJ5o5REJZ9Mdx+mx1aqvfklR4oz/Cl8AEE0c8Y6bhQfwXTFwTgfu3Faty9AnfikWn5LKdDE8ZpXKc3OtDc6g2lyK7k5c0Yv/+exw6olWLloerAK8Gt56tsozD8NwvQGBT03PLEexWsE4UUQVMWvVuMirot+LJtlenJr1AGqo1BE/3fQ2VftyRSCMMVl6OsSRQMFZ8dKzIudSRGgj3vHtA39CaPmpXJelyJchWaYDfEme4G9EHRwxnyNGN9BH7A10cueuPO4rzbuu0Ve+xoFg2IqMbKjjBGjLBOuwRxtHQ3orl0QvYdtS7/cz+wd9S/Ni0NpZ7aM3i728dgaRVAAc5zCYFXEy2/HxHkD+AyHTy9jQtWUVOzKJGu09VzXzaCKP5QNGKwFCP6aManp1Yd/8MG9kccihTlg681zo3PKJgHjMifYoJDY7GDxP8UO1PjXQS0AaYSA9PC9EczTU9FgW6izAHO3xPMHjUNVHqH6zVxU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5213.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2JvSmMreUhxRTI4UzNzWEJjZWhyakdiMXczMUtHczN5OUVaS0xGTDhSS3Br?=
 =?utf-8?B?eVhOUEV1NzVaOEFIbjM4ckZKMHJvbzlJazIyNlJDank2dkNDdnpiZFpraGFh?=
 =?utf-8?B?Yk9RdiswRDVCUHZybTBCc0VZV2hJdG52VUJRRVhEWWRsZzlPNy8wY0VJVTdJ?=
 =?utf-8?B?czhaRkdXZ3JCQWl4ODRGOTRvSUw5ZFhZbkl5OFpZY0lvWWNyZWJJQnZBdG4r?=
 =?utf-8?B?SnVCb0VxbnA1WjlwMlBPVlhQNU43VzBDbmE3MEdoRU4zUWY1UFd0eEo5VW9I?=
 =?utf-8?B?S3RIakxIU3BSem14Y1UyWHZOOWJNdDdMYS9kR2tCRzhialVsNXY1WE51akwv?=
 =?utf-8?B?UW1yMDQyN3NxVjdJeWY5a3RCNC94Y2Y0TURNRFVYc1Q0dzVaQ2NqZE1tMWQw?=
 =?utf-8?B?cURCTkVZZTRvZ3pjTzIyMVUyRnFDTjlva2d3UkJRRjQwWUEwY3BEVWpHRnBz?=
 =?utf-8?B?eVYwdU15d20rKzQ0WUY0bTAxejVQQzVNUzg0QWM0ZmZoRkhjZS94ekF0Lzdp?=
 =?utf-8?B?RCtkT09YWXRGTXV0dkxsb21pTlFlSm9kVldGeXJ4Q2cwK3ptNUlEZkEvUWJM?=
 =?utf-8?B?WE54WFVYekN3RDhjajg5WEdPTUYrWDV1N0I3cFdocnR4T0ZRWmRKY2lYNG5r?=
 =?utf-8?B?VEx6ZGlUNTRzOVZHa2FNaDAyU0VLdzFCcEtaZ08zNzRRZXB6dHl3NFJVTXIx?=
 =?utf-8?B?dGlTZ01YdkFPTU5nRVRHNTNWR2pTVWZGbzRGQU1VTHU1WXhudmYxdVE1NU1T?=
 =?utf-8?B?VUNoUEYxYWEvODJHcml3RGtGRVpWTmxDMlZHb1VCaHgzZkhsMXJwdWxuYVNU?=
 =?utf-8?B?eUtrNE9LSng5clJyL3ovQ0VvUW9QZlVuazFxbUlBTDVHRGRCblhEZXkyZUNP?=
 =?utf-8?B?Z0RFRTFhR0hpL25nVHBRejJpUkgxS0oyMXVsSmVOWkx0aWJHMjlmNENFRGg0?=
 =?utf-8?B?TWs2d0dEa2NlZ05jWGFBWnM1TDVpOWtaaGh2c1BaNGdlZzJxQW11WWFjcjRk?=
 =?utf-8?B?MGFTTG1ubk5xWU0yVWZ2bW1Pb2t1OXpzRkV5RkVCM1VsTjBML0szOTJHYUtZ?=
 =?utf-8?B?ckJ0bkpFS2VZQVdwUkFZaUk4VC9telE5VkhzMlhOa3pScGJzYktIN1lWM21y?=
 =?utf-8?B?ODNKNUx1MFA4VXg1QjZReGxjeTVJZzQvNWNCdmh4MGsyREV6WW5KSCtxamZK?=
 =?utf-8?B?UEhaNUNPYmwyc2hIODVwSFJnM2lhNDJmNmVMSW9ZY3JMb1V2eWZ6WG0rOFhJ?=
 =?utf-8?B?RE1aTWk2MEZVL0hBZzBzL0grWWY4dHdVL29ucG0yNGJSbnNVUGpCQjhUVU8x?=
 =?utf-8?B?RzJCL1ZFV2hJSXY0N21MQ2lxS3k0RDNwWEErNy9QZitJWGhrTy9tdE44R0Q1?=
 =?utf-8?B?VjVmZ3l1MDY4STZFWmZCMFd4RnF4M1ExYjNpdkdjcFBubExrMTFaRFVwVy96?=
 =?utf-8?B?aWpxZWhKUFE3bDRiQnBORXhaNlhjSjNBbHpGNW9VeDNxWlQ5cGFIRzFaZDFt?=
 =?utf-8?B?QTROblF5Y2FuL1NlRlowMkwwY0gzYmYzdHNOYnZIR28zcTRXRnRXQTJwMEZQ?=
 =?utf-8?B?ekhiMlRyL2ZCOXBDWkVGeVB1eHo4bFRscHZ4SWpkd2ZYREpYODVWK1prYWl3?=
 =?utf-8?B?V0ZwTGxocTJNMitCcEVtcWNFYlJ6Nzd5SzF4anVLRStvSE12Tit4allDL1Vt?=
 =?utf-8?B?QjUxb2VDamZteHIvSmtidVFraHlkQlNaejFkZHdaQndscjdtd3AwZ29TTjh2?=
 =?utf-8?B?ZkJNVG1VZ01aU1RGQVV4T2JCY0M0ODdYeGpUT0JoSkRiNHljcE41a25KWUJs?=
 =?utf-8?B?ZHlOSFFPNktzMmxjaVJ0NWhOTzlVOHRFc3lwV2R1bU14SFhtR0c4dkMvWnVt?=
 =?utf-8?B?cEFNV2dBc2hJN3ljZzNydVJudUQyb1JhaVBvU0pQYUtNaVhGV000TCtvWUtw?=
 =?utf-8?B?SUpyNTA5dkJjN0U2TUhHejhwTUwxZmZMNGNRcitaUWMvRTdQZlBWUUo4TU9S?=
 =?utf-8?B?WTF2b2Y3ckVBQVdzSzl1TjA0SlluZ2FtMFZrOTN2Qnkva2o4U3p2TFRsYm03?=
 =?utf-8?B?UDFMUW1hallGejVUL0lBR1g1eEY4R1U1QmJsaWNabEFhY0tTc3RlRHBvNDhw?=
 =?utf-8?B?elJNblJXQWUvVHRzcEVkTTVNS3NFZmdxK05qMmIrS3lXTW5wcWxuRzIzM1Vo?=
 =?utf-8?B?d1JZa1FUT3czNnNTaFdvaG55TnlRUVJEQVFnQnZrTG0rczlzOStpT0RUeXFJ?=
 =?utf-8?B?Y3UvSkpRVUUxRkJqNzAyQ1FYS01GaWYxTGxsaWdHenBXeE5aVFA0bUhjNFN6?=
 =?utf-8?Q?VeqMx0Nh2HWo93rPkK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b267f2b-9bf6-4db7-e1c0-08de9bed87a0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5213.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 19:22:42.4914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bkyflKcN/eL3SD2/wduBx+4qIH33C/4wRfBDIz5h8I7Fn7ukpNxa2hfWhmvoJm05
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6767
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

Thanks Melissa for following up.
I like the changes themselves, just some clarifications.
We do have a LUT with predefined HW curve, but it has some limitations: it cannot be used with subsampled 4:2:0/4:2:2 formats and it affects the linearity of color space in which HW scaler operates. In your case, we use the LUT after tone mapping in 3D LUT; that LUT doesn't have predefined curve. So it's not uncommon that we need to program our own degamma.

The motivation for the new segment distribution is best explained with an 8-bit sRGB case. Input has 256 possible values and HW LUTs have 256 points. Ideally in this case we'd use the LUT as basically plain indexing with no interpolation. The new distribution accomplishes this, it aligns 256 HW points with 256 possible inputs. Due to float representations of input, it's not aligned perfectly, but LERP-ing between two HW entries where input is always within small epsilon from one of entries doesn't materially change things.

On 4/14/2026 17:55, Melissa Wen wrote:
> In newer DCN families, there is no hw predefined curves. So, when
> setting predefined TFs to gamm_corr, shaper, blend and regamma, the
> driver resorts to the color modules and program those predefined curves
> using LUTs. The driver is using the same LUT segmentation when
> translating EOTF and inverse EOTF to hw points by using the same color
> management helper to translate curve to hw points, however, LUT
> representing EOTF may not follow the same region/segment distributions
> of inverse EOTF. This is causing banding on blend when PQ predefined
> curve is set. Use different helpers when linearizing and delinearizing.
> This is the first step to fix banding but already mitigates the issue by
> increase the number of points per segment from 8 to 16.
> 
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
>   .../gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c    | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
> index b45ceb570a5c..17d54aadb5e1 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
> @@ -493,9 +493,8 @@ bool dcn32_set_mcm_luts(
>   	if (plane_state->blend_tf.type == TF_TYPE_HWPWL)
>   		lut_params = &plane_state->blend_tf.pwl;
>   	else if (plane_state->blend_tf.type == TF_TYPE_DISTRIBUTED_POINTS) {
> -		result = cm3_helper_translate_curve_to_hw_format(plane_state->ctx,
> -								 &plane_state->blend_tf,
> -								 &dpp_base->regamma_params, false);
> +		result = cm3_helper_translate_curve_to_degamma_hw_format(&plane_state->blend_tf,
> +									 &dpp_base->regamma_params);
>   		if (!result)
>   			return result;
>   
> @@ -551,9 +550,8 @@ bool dcn32_set_input_transfer_func(struct dc *dc,
>   	if (plane_state->in_transfer_func.type == TF_TYPE_HWPWL)
>   		params = &plane_state->in_transfer_func.pwl;
>   	else if (plane_state->in_transfer_func.type == TF_TYPE_DISTRIBUTED_POINTS &&
> -		cm3_helper_translate_curve_to_hw_format(plane_state->ctx,
> -							&plane_state->in_transfer_func,
> -							&dpp_base->degamma_params, false))
> +		cm3_helper_translate_curve_to_degamma_hw_format(&plane_state->in_transfer_func,
> +								&dpp_base->degamma_params))
>   		params = &dpp_base->degamma_params;
>   
>   	dpp_base->funcs->dpp_program_gamcor_lut(dpp_base, params);

