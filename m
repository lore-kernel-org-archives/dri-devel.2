Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAEFF588CA
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 14:03:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7608D10E667;
	Mon, 20 Apr 2026 14:03:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=live.com header.i=@live.com header.b="vINKcF1h";
	dkim-atps=neutral
Received: from PNYPR01CU001.outbound.protection.outlook.com
 (mail-centralindiaazolkn19010012.outbound.protection.outlook.com
 [52.103.68.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 103E010E665
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 14:03:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eH/8wCI/BXAbVKACFWfSllgDAMfAGtFUuyijJmqNSDEHpfCvwObMKCYqT/l0gSWioBWpyaj9pk+MHYaFtWw5thh4XiaAOxrR5BvqnmoLqgBZnmb84a1SeyGcidk8ML4O7jdbMj8u+7m0DBBGZ1l+5urznV/9g9Tf5F0WfbOdVxPpT2vt+EeiYashgbL4s03dBhGhOX19VQI9GVTwbiVPklyRLhl+lu2dGvJjUQVs+/V8zVcQls7auvcaLQ8i3BatE7KUGSmy2PANE5HrdWdGNv+SlhNRaXgshog2OqsMKtmq61CmFuSq89jh6s1t1A7IGMHSPaW4AiCgFqPht/V+8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srRo1c8dyCNKpplB84drZEyyTl6bULD6jUVA7fcT70w=;
 b=LZAt8I98fRdmX2AaT/Bf0sb9ocLoTxYrziX8KjAtEOdu0av6tHFAVkBIvkSgZF6DJl48+TImdA0ewXFHNUbJjFYXZ6BPH7Xfqp9qgzM8+Trlu71g/2XUdaWoP82UbeZz2S8iFjvp3XOSZo7kKRaF6ib8YqpqxjqtOACnf/58xxkLVf5cAj9EabcaxOZBLODKhSuLNbtc4x7ZKq16LwPNUOJjFtWxNOertovZTM0a9muTEvUZyRGcC7RVOwp7PNl9zbquk7tmjDxUfNQgONoc6+upMC4ImEnen4EnYTeB5y5ixT9SidojGysMSI06URvhC000Atyeos6snqGHbtcIsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srRo1c8dyCNKpplB84drZEyyTl6bULD6jUVA7fcT70w=;
 b=vINKcF1hnoESKcJPstrbhQrGQ7Y5L+JCPensQwn6mLmMHIS1xSGIBVHxFdz1VGzLLc6QQTNQMbnvUWP6vdC+fyvk6fQ3c6nmylGMBEzAqeBIYCRjDNLQMf8BdgyT8+6WjpPRAa58H6jWBlXdbzrMN2qHq2tmS6ZXfQYcG0AsDE17dbcFZ1Dq4Io/NF+kr3M3XOznv67YEmEQSZAdE4SjCo/aMLvH88hRu9NLkJWE3mAFg+qi+6vVAHDITnxwQ+jqN61tPzdRVpQr3mOMbaxDvYekZLqJXHqSE84GztTmRFzzHiscNocYArNLIZWbtJhuhsl43Cc3LClnJY3x4VRbjg==
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18) by PN2PR01MB9508.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:fc::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 14:03:05 +0000
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295]) by MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 14:03:05 +0000
Message-ID: <MAUPR01MB11546C128E9DFF1905B3EA4A7B82F2@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 20 Apr 2026 19:33:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/appletbdrm: Use kvzalloc for big allocations
To: Sasha Finkelstein <k@chaosmail.tech>, Aun-Ali Zaidi <admin@kodeit.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 soopyc <cassie@soopy.moe>
References: <20260420-x86-tb-vmalloc-v1-1-7757ff657223@chaosmail.tech>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <20260420-x86-tb-vmalloc-v1-1-7757ff657223@chaosmail.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::35) To MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18)
X-Microsoft-Original-Message-ID: <13aca4f9-153d-4577-af15-2df77a03ca01@live.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAUPR01MB11546:EE_|PN2PR01MB9508:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b5c617f-0b32-48a7-cc66-08de9ee58b37
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799012|8060799015|41001999006|12121999013|23021999003|15080799012|39105399006|25031999004|461199028|5072599009|6090799003|40105399003|53005399003|440099028|3412199025|10035399007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGZmNVhwRTV6NE9oZzU0dEdxTnhXdFdDS1BiT3VKYmxNb3hJYWdEN0QvSVBo?=
 =?utf-8?B?UU43T3I1MkpoTU5MbXJYdk9HdkxaakJvTEcyeGNqR2VQUWFwdXUwRGVqaWl4?=
 =?utf-8?B?bTFGQURzNXVSWW1KaXBQbjlJbnBqSWRma3FxLzYxcWJuaW5kcXYzNFlBMWQ0?=
 =?utf-8?B?bC9VaE5sSDhsa080NTlod1FPWlFqblBjZm1IaklVYmFDa2tHTTdaV01TTzBz?=
 =?utf-8?B?bmE1WUY1YWlHQzY5KzNJY3J6OHdDUFZtS0hqK0o3Y2VNZjVVdi90bEtaNUZi?=
 =?utf-8?B?cWVubUJ2YjloL2VNMUwrcGp4MXJmeEFZRnJqQk1HaVJmMzJmamdhTkJEN2ky?=
 =?utf-8?B?SG9pY1F5SDNsc1dTZ3RKYWRIb0VoV3poU2wybHhTVVNpRGlrMVBCLy9XSnJv?=
 =?utf-8?B?Z1RtSXVLNGc3cjNlaDNHV2VBQnREUTVET3U1TkZNZ3pLUHhXcjE3dTVMdEdI?=
 =?utf-8?B?U29iMlExaG5wVTB3Ni9xZmpaQmFOMEtXQU5tK0pLdXE4MHU4Q3o2c3VVSmU4?=
 =?utf-8?B?UTVtTXFYallMUzdXNGpibktIMlhvMEJtSXN5M0t3Mi9LYkpTeCthTkZiZ004?=
 =?utf-8?B?MWFGRVlDcVFXQk5uRDBoWXhaUExNM2lXdmYzc2JYdFk2aW45S0daRnpHc2lO?=
 =?utf-8?B?STR5SWFNYkVmd0FENkh4VEJGMjA1UEx0M0tDRmhhaHk3SWFZanZwYTU1YU1T?=
 =?utf-8?B?WEJPWUlKL0xUMGFRRzEvdGlwaWxtU3FmVFdpSEhNQ1M4L2xDdmlhdzJDM014?=
 =?utf-8?B?N09yeFhWWThaVUtLOWwvU2tRWkRaRGwwR1A1NHRJbmQ0TFpPYVo3Rll2OTBV?=
 =?utf-8?B?V09IQWRpUFVoQzQxNEFnRXcyU3Q5aG1OSllXSFBzL21ydVIvSFRVM3JaLzlL?=
 =?utf-8?B?bythMXg0K1NuWUFDOGFMMVlFczc4YytOUVI2RVc5UTdEQ09keVIxWHdxSURq?=
 =?utf-8?B?c1NJc3lsd3FXV1dueVVHUE1rNGllWWtwVlJiSzJGTGhwQlI2UE15UkxYQ0xp?=
 =?utf-8?B?V0FYZi9QTDFZNnBJKzM4QUdaMzFKQUxMekNabnJtQ0M0b0RtUFJwN1d2WjFt?=
 =?utf-8?B?QWE1dk1yTFZEVlc1OU5sQUlqWUNsRHhtZzBiQjQ5dHJTb0FsUHpMSWVnaEQ1?=
 =?utf-8?B?c2tzcmNERndzUHJlZWZrRThlczZLNFpQSzlmaTF6RDI5bTMwREV1SmphalFS?=
 =?utf-8?B?Vll4Q2VnN255NnhtcFpmNlowNXlOaktWc0t6TC9nbFM5V29BeEhFWHVoa3hT?=
 =?utf-8?B?ckVUTUU0czJCZ3QxTkFUdWJlQUM5dUxOZU85SEptQVFCVVREVnBqM0hZZ1ds?=
 =?utf-8?B?QkhiNUdIVGpBSHkwUW5KcFdnOEN3OVBYeDFQY0JrWjlLajcyb0dEMTlLeVZt?=
 =?utf-8?Q?uQHxBA1VHrEOlhkFMSEafguBFRYRGN6c=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjArUVFVMjViRTJ0MUlkazQzQ2wzRXlDNWxBQXNFWFFXcXcvVU5peC9WSnhv?=
 =?utf-8?B?VDBPS0VnaWdYa2h0MlpwaUxIR0I0b09jdjBHMHF2eFNOdHprTEZTNTQ3R2Jw?=
 =?utf-8?B?aVlHR1RGMDRnWVE3b0N1TXE0NjJJT1RlTzJtWDZJYng0Mi9YUjNiNnpseExh?=
 =?utf-8?B?WnBKU1U4WGJxQ0I4UncrV0hBRll0NGZ2aFFoRUNpKzQ4c3dMcW5Pc3pnWGxO?=
 =?utf-8?B?cmRObysvVzZVSVZ4K3FQS1JwMUFuUDlGc1M0Zm1nM3Jmd2xvd01OblNrbk8x?=
 =?utf-8?B?SHV1bVp6bndVVHhCbVhTTkp6V09GRktTcVlqYkFOYXhiRlBGcC80MDJqdFhL?=
 =?utf-8?B?ZW1UYU5ZVHE4SUlvUEQwNW42VXlSNFp1NWFQY2h4NnZ4WEJrMmhBaWJBd1ls?=
 =?utf-8?B?RXAwRHFnaXJZdS8vRHgya1l3TjlJTHhEWnFJYzZjOElkdC9LemtjUHBPVlBU?=
 =?utf-8?B?a3hvUG4rUEVZWXIrZGZOZTNFN0hHSUk2N3NNL0lDanBiaUtWWTlzdFNtdzRO?=
 =?utf-8?B?SXpYK2lwK1hIY1FsNzZnbUloenBBQjhubXQ4ZkhjaEhSMm5FUW51N1dBYkZI?=
 =?utf-8?B?dVJkMThLOFR1OUF0ZHhFdmZDbFpsK2lPSzI3S1JLRWRaNXNhaks1YUkwMEdw?=
 =?utf-8?B?MFhlYm9NblROYS9QQ2pmTUt3Wi9TS1g0UHdOYjFJNFovVm1yTjZTcGptTC9K?=
 =?utf-8?B?ZUV4V05Rd3JFVEhzNWxTZUt3QnJLVUhSZ3FEZmdOUlNTR2ttWjRWOCtrWG51?=
 =?utf-8?B?Mmtac09kRUg4T1Q1M203VEZrbWtlcy8zcWY3c0szMHBNZXptM3JoSVVhRFNw?=
 =?utf-8?B?SE16Mlh3eHpHbXF5Zkk4NTVPUGJtMFR4Unp3eitCdWF0YWNsa3I4bXpSSmNO?=
 =?utf-8?B?UmEvSFFMNlZOd2RVR3BFbDJIT01QVEk3L3VzWkt6V2o1eTg1blBJWnYwZkFj?=
 =?utf-8?B?WVBZTmxRbDRXUXo2ZTdVcEpCMElwcTF6UnF6UXMvTkMyd2lmc0htaFE5OFBR?=
 =?utf-8?B?MlFpYnE4aXFQbDlqczJtb0RMZ25vTWxTWGRGYWdCYzFHS2VYZjlFMElIUFJC?=
 =?utf-8?B?ek5IV1ZsVXkrcnlsK3NMQ1pFcHB0bTAxM2xJekFWVlVJVVhBUVFDbE9oVVRr?=
 =?utf-8?B?elh5ZVpxcWw2V0RwemREeTI4RWZCZHJOaVc4eXBmeWhjRDdiNFhvZk04Y3V1?=
 =?utf-8?B?ajZCb2ZkNUhQUTFWT1QvbFR4Ukt0SkhDTFAwNitGdElYRkZna2tBbWk4bGQw?=
 =?utf-8?B?RzdDdzh6Zi9uaDJRNmpZWXhTczRuMytxM0k2U1JUU1dIR2ZUMHg0VHN3ekt4?=
 =?utf-8?B?Q0xYTVI0MFVQdzFaQzd1aXFXRHNKMlEvWGNVTWx3dXp0K2tsSGhncnQ2ZHla?=
 =?utf-8?B?R2JSMFNWTGhaUjl3cVYrbkp3UGN5SHR2b1Fna2JoRXh4UEVPaXZzL1I3RHB0?=
 =?utf-8?B?ZDNwd2dWVjlOK1VjVm9FNFo3Q3k1VTgwUGZOYWFlOUlndzM1Yi9obkhKSnRq?=
 =?utf-8?B?b1Q5MW9IeEQ2M0R1MEQ4eDF3OGhVTHdzbHZubzltbXdRWU1uN01NOXR5dHpt?=
 =?utf-8?B?ZVBIUHBWVXR1aGF4all0L2xVQk5wZDZGaFhza3J1ZjBidjQ1YmJaK09SaGU4?=
 =?utf-8?B?RjFKZldBMnJaN1F6R2VxWEVZcVJ2U01wQ0NVNDJUQUpCNFdYTUFPOCtDT0Ix?=
 =?utf-8?B?TmYvTlhtcExQZ0xKLzNmNm1reWR3THIwUTY2ZlpVck5EOW9xVE1LMXBXdVoy?=
 =?utf-8?B?RTNTSFFjaTFaKzlJMlRFY2VHZWVHZXVId2UwVkRZQWd2REtmZ041ODR6R3c4?=
 =?utf-8?B?Y3pFb1ZWenJoejVCc1hpN1ptOEQ4WXN3WW9qS3Y4QVNqYlpvODQvY2hvbjZv?=
 =?utf-8?B?RDY1emdWbGpzVmNkSk9KOXJmanlUVFgreEVJbW9PQkhNSDhhSG9uQWFGeTFs?=
 =?utf-8?Q?00Qv9u91O283YGl//corEKOGzbkhko5d?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-63b91.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b5c617f-0b32-48a7-cc66-08de9ee58b37
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 14:03:05.5712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9508
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

Thanks for the fix!

Reviewed-by: Aditya Garg <gargaditya08@live.com>

On 4/20/26 17:47, Sasha Finkelstein wrote:
> This driver is attached to a ~2000x80 screen, which is a lot more than
> a single page. This causes out of memory errors in some rare cases.
> 
> Reported-by: soopyc <cassie@soopy.moe>
> Closes: https://github.com/t2linux/fedora/issues/51
> Signed-off-by: Sasha Finkelstein <k@chaosmail.tech>
> ---
>   drivers/gpu/drm/tiny/appletbdrm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tiny/appletbdrm.c b/drivers/gpu/drm/tiny/appletbdrm.c
> index 3bae91d7eefe..278bb23fe4c8 100644
> --- a/drivers/gpu/drm/tiny/appletbdrm.c
> +++ b/drivers/gpu/drm/tiny/appletbdrm.c
> @@ -353,7 +353,7 @@ static int appletbdrm_primary_plane_helper_atomic_check(struct drm_plane *plane,
>   		       frames_size +
>   		       sizeof(struct appletbdrm_fb_request_footer), 16);
>   
> -	appletbdrm_state->request = kzalloc(request_size, GFP_KERNEL);
> +	appletbdrm_state->request = kvzalloc(request_size, GFP_KERNEL);
>   
>   	if (!appletbdrm_state->request)
>   		return -ENOMEM;
> @@ -543,7 +543,7 @@ static void appletbdrm_primary_plane_destroy_state(struct drm_plane *plane,
>   {
>   	struct appletbdrm_plane_state *appletbdrm_state = to_appletbdrm_plane_state(state);
>   
> -	kfree(appletbdrm_state->request);
> +	kvfree(appletbdrm_state->request);
>   	kfree(appletbdrm_state->response);
>   
>   	__drm_gem_destroy_shadow_plane_state(&appletbdrm_state->base);
> 
> ---
> base-commit: c1f49dea2b8f335813d3b348fd39117fb8efb428
> change-id: 20260420-x86-tb-vmalloc-4c94d5eaeeae
> 
> Best regards,
> --
> Sasha Finkelstein <k@chaosmail.tech>
> 

