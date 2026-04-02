Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3789CC6B36
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 08:53:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C78410F1BB;
	Thu,  2 Apr 2026 08:53:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H31fYFHy";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013035.outbound.protection.outlook.com
 [40.93.201.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A81A10F1BB
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 08:53:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sg+gTAxwnv6RMJiO9Rlk+TT/a5umkrtN2ELUW2CtaMynTXWBHY9mBhiixh8EJLToEQKz0I4jzvuTwwvRh3OW/fLVIh5uEkg+8kOZIEyWhMniFJusJHQ1laI1WlEeww8RtpzRTLDsXJezTOFHq9A4Z2YMYZgG8CoIZ5gptaMY4oGFLp1r9cZILY211eQRKxyG814I7lw4kgRFaIMPRrShrENbAAa36NZF2IVXcvfIUpk1uZly5uG5I/TwPmTEKBld5gv9UefJg9hH4dLaNpHgOrHYfrIPE5LImaQpk9K4BkbkpWfQpXEVjuSDTE5I/wsGSjBW9YQj1NxSCD4NPUrf0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mdOcQCPiycgqDKqq0tu1BAXsh05p7h8sYV35sPyGt8=;
 b=JV7Xj1Hv2/W3/vt/yeRnDipIUnCRkCAruwzWhPuPiDK5vN7W/ajhJU3jNFMheJ80gU52sIV9zzRnD4NzwaV3VKwkG7KHFoX8GAvDClZyyfPwEI4CsIooaQqnuLcMSCDzKCWAWDppl8dFSLehWn/h8KI2qE7K2BKZr73tO4uErHON8QKPOF+ZLJ06c3+i7wg7AUmtxV2qvU52iCAO9FlcLyELer5kxGaMfwti5uVfrHxSEAUakXqnCy/ZTRrJJ6FAZT9mkmeg2YVSO8PcIiNU84GrYMOZEJCLp/L8KC3Da1ECDykDubL9+SSeBhpVYGzCbUjldx1vyi6qdf2EnReLBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mdOcQCPiycgqDKqq0tu1BAXsh05p7h8sYV35sPyGt8=;
 b=H31fYFHyZF058dVhEUjDOkXEbwJG5p1Uk2z/HG/0RfrEPDoyRz9gy73Bkn0yxTT+fcHJJ4vEzGMwrXXokRZ0rnDLT9WCaDjmioXTxDHoBxGteuNwT8Vv9dB84xZ0i+PYM04Z6K/yHzxfPL1teS+3z5iACIWA25HGBDqqFiv0xgk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB8809.namprd12.prod.outlook.com (2603:10b6:806:31f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Thu, 2 Apr
 2026 08:53:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 08:53:12 +0000
Message-ID: <42bd47fb-c5f6-4adb-aec3-c4037a075e81@amd.com>
Date: Thu, 2 Apr 2026 10:53:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/doc: document DRM_IOCTL_SYNCOBJ_EVENTFD
To: Simon Ser <contact@emersion.fr>, dri-devel@lists.freedesktop.org
Cc: Simona Vetter <simona@ffwll.ch>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Daniel Stone <daniel@fooishbar.org>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
References: <20260327171812.128290-1-contact@emersion.fr>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260327171812.128290-1-contact@emersion.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0321.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::26) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB8809:EE_
X-MS-Office365-Filtering-Correlation-Id: 082c8fe8-ef53-4454-6a05-08de9095457c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: HDoI4ZGRcLQFVlcYvYXX66wbep97/7M/uV6DF4mn6exvd/LG8H0857ePxMrnFCcfcKWd8sTAIZP+aa6ZY6eHkcJf4pA+zIOi+Gpt+WoSHKKkA5KhQ9gCxKS4fJXWCZFl3tvY54MYwv4ANmX2vk8BDmS1o4Eon4AEJ4BJ8wfr5OXOEyN+L/yOvwKwKnUXUXZL0a56LtAJxGDCg2j97jjh0+WYlI+Iie5rWlOpM32YJJSGlVI5U7vzFwIuSb6w0gOVzNU/Orf6anWmQTF7X3eDoVJaqHbKdCfaUjodVLwV4i257bQp33Fsyes4PNmXBRaHQW87UIjFZ+MqYyyoDAPOOfq4VziaGK/xUQRsUU5K7sfXJvWWtQ3SW2faL7AusI3tu7+ci/cOqBlMk8ExgK9qYaEglPgiG6Q87yss2EkcgTYbhl5TTc1RYVWa0BnBFmYlhdNjunrPjkN28TYHQGRBcxMZnygvuhEaLTsC+nqvrq2iNkwvQFreOqcERt/VND1Rg3fi8i6+LuS+y9DZGLWb2MHzKAqX6g7J05oLduZoFWlSrPglMTKWUfldlOdKavLwvClT7y3gCwu+gcccaJXmXZlu49U2bTcEAuDU87IYbR+kHh60dHFhEXtT8KTpM1U5Y2lGVStbvtMAFYDkXMY+z//ujaUH2bTPPSNgKUb9XD0Yv6TEd5Q9n9us1HBWeE2N6X2j8+i2DkVCiHJNTNzNjV8MFE3yJDczZ8ylS66KssQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnFGTTE5c0FpdlQvZ1lwRHl0cFRhRkp2cEh5NUNJUkcxNCtmY29zb0MwZU1r?=
 =?utf-8?B?QXlQLzR6UlpLaGdCazl4dEMrbFBUU0lPeTh6VFNiVFR1ZVRlc3doMjZvUTEz?=
 =?utf-8?B?a2R6ZXhyRWZGRThYRWtvQUI2OVNDZkxHcC9Cdnk4WXVMaDVSaEVFWVRjbGs3?=
 =?utf-8?B?S0lHY1VNeUhjOEd5bzJYeWRqZUNGMWR4V2EwS3hPa1JzR05PQmtHUUM1d3RB?=
 =?utf-8?B?M0RhUzNXdUc4ZEdxUUlmNFNFbjdjbjJYNnR2amR4STRIdDFMR0lRUTVhL21C?=
 =?utf-8?B?WWJ2cldyMEd4V3BoelpSQWlHVGptM0x6MkwzZG52dENDSU53R2Y1Y1R0WjBX?=
 =?utf-8?B?N1VYUmIzU0dzRWw3V3lWMXBRTXEvdEpVc2NEd3NkQVo5SW5Cd1RINHVyMVEy?=
 =?utf-8?B?S2p6eHlSOTA5d014ZUJvdDQzU3llZ3ZQbE9BdDQ4ZitIZ3JJYWgxNFkxMk14?=
 =?utf-8?B?b1Z0dGNlQ3k1Z0U1YTY4SWtUaEhEZERMK1o4QlVPTE53TDA4SVRGd0I4cVdr?=
 =?utf-8?B?NXV5QU9DMGtEcXJQNWtYSDlkRGNjNGJRblQ5OU1hRlp3Z3h3UERnUDUzWCts?=
 =?utf-8?B?SUNDTU4rZkZEeWhBT1ZhL1FJOWpPS2dyQzRyUGlCN2hrdndGc3ZqbmxaUG5K?=
 =?utf-8?B?RUpNODJjb0Y1M3EweDVLdGs4UnB2bWVDVEZpOUpOSERpRzU0azRRTDBmVThB?=
 =?utf-8?B?YXFnWlRaeEdwcENZZWJKQUlJNlJoNDVWd1FWK3ZyVTlMTDNNMU90MVRnQ3Vv?=
 =?utf-8?B?cHpwdG9Zc2pXR3hCdDM2Qk42QWRPZTJRU1oxdXI4REJ2Zi84VncwS2tlRHZL?=
 =?utf-8?B?bmcyWlNGODJ5amxQejhUcHVaWmR1TUpPRXpjRTZ4UGNVSEJVRVh6S0hmSnp3?=
 =?utf-8?B?YmNPa2hkN1VOWXFsT0J5NUFvWmVQOWF6Rzl2TUVVcE9LcENZR0NNMjFxbGQ0?=
 =?utf-8?B?VE5raFNDU0tUb2d4YjA2L1VRQUlnK2xHZXJkNUxTWVZ3ZzFsNHpmQkI5dDRn?=
 =?utf-8?B?dXZQWmNNZlg4RS9wbjRmdXJObGxUN3lRRS9SN0Z1K0RURmJqUHlYRzJWL1h4?=
 =?utf-8?B?Y3FiTng3clZCOHNtWTFld1V5bGZMemFuKzRnVXlNY1NUNVdKUnI1Smpvd0V4?=
 =?utf-8?B?MCtMODFJb1lSSE91U0lvUEtmUjJXQ2psdld4SzQwNVFFQllFQXlUNmRxTytW?=
 =?utf-8?B?ek56T0RWUVhZM2ljK1lvVXdKcFdMNzltczIyM2dlQmpsbnJmejR4RFRlYmR2?=
 =?utf-8?B?YVNSNW1Odi9MUXdrOGFjSzRBTjJaZGlEdGRqa0V0RFJPWnVyeC9nM3FSMm5o?=
 =?utf-8?B?ZlRLUHF1RjNXaStJSzJVNzIxTEVWMnNvS3N3RkdDczVwVmdwUEQ0NjRxT05N?=
 =?utf-8?B?RzBXL3BCQUVsTnRYQytGMzlOMko3NWUvTS9rVFczK3Nzd3RCcWFwQzZGaUVP?=
 =?utf-8?B?RUY0cnpSUmRzQUxiN29pelFRMWc3bG9hZWhQZTZ6Vks0UG5ha0NxRGdsdEZJ?=
 =?utf-8?B?L2NTMHVySGl1TUZRdE5mSXhzMjZQZiswZUhyeHoxKzhyT1VseTg2UTRWY0Fv?=
 =?utf-8?B?R3ZnQ2RMclp4U3p4MXlQcXVPYXhmRk1uYUYwditsK21hNjNvZyt4T2pRWmdG?=
 =?utf-8?B?dFBncTZvNTN1cTVGbnExQXZtNW1BWmJVZ1IxbVM3djZEbC9hVnV5NXFkTVAr?=
 =?utf-8?B?YkJyczJSZVAzL1VtbW5aMCthUUZ5RjVudnc1RTcwYjA0cXFuT01FY29XRkd6?=
 =?utf-8?B?L2V6UlhYY2ZCZE9ETWY1RXFFQXBhZ2c3SWplOTU1UFJtazMyZW5LTmZjeGhF?=
 =?utf-8?B?ODNwWjk2dDc1SzFrYlVvSUlITFRzc3RQQ1VvYUsxT3grb3BYSjNaeFhDVzFQ?=
 =?utf-8?B?blkvQlE5MTJrOVV5VytFYWxNRTZCQkw5WlZtS0ZJWDdidGxOaDJPNnZraTh0?=
 =?utf-8?B?ZXRKWGpUc0oxMFpLY1k4d0RwM1pvcFlvNHFoTVJjMDc4N3NkUFB3OTFGWjdL?=
 =?utf-8?B?QXViV0VzZlFGOHZGeGVYbWNLV1pPaVhVb2dHVzBuMloxdWRuUG1NaXQ4dERH?=
 =?utf-8?B?eFBjaUZLMTV6cE1nSlQwZzUxSnVWZnpqdWhWL0JqbXlNNXhMaDlmTTh0cnVF?=
 =?utf-8?B?Y3RPakUxNlM4QnFCTXlkdVJDc2pIdmxxVDJvOGc1b212U2Y1Q0FkUi9OWXQ4?=
 =?utf-8?B?eUZrZGRJN245S3gzU0tqNE81Q01jMXo2dUM2V0ZOcW9tNDJsQ2lILzVQN0s5?=
 =?utf-8?B?NDR4eHhkVXhaRGtmYlhIQ1NPTjIwbzY5OU55RFpodnZEcW9ic3JwQmwxMmkv?=
 =?utf-8?Q?mxheGxUKDuFg316Fk3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 082c8fe8-ef53-4454-6a05-08de9095457c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 08:53:12.6129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MjKF8PfrylKakcux7uystEYRs5G4Kgl1/deXJHW1G2gSlMT6Qy1O6CgEuftsIueX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8809
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

On 3/27/26 18:18, Simon Ser wrote:
> struct drm_syncobj_eventfd was documented, but
> DRM_IOCTL_SYNCOBJ_EVENTFD was not. This prevents references to this
> define from being properly linkified in docs.
> 
> Signed-off-by: Simon Ser <contact@emersion.fr>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Pekka Paalanen <pekka.paalanen@collabora.com>
> Cc: Daniel Stone <daniel@fooishbar.org>
> Cc: Michel Dänzer <michel.daenzer@mailbox.org>
> Cc: Christian König <christian.koenig@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  include/uapi/drm/drm.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
> index 27cc159c1d27..495462e44a17 100644
> --- a/include/uapi/drm/drm.h
> +++ b/include/uapi/drm/drm.h
> @@ -1323,6 +1323,13 @@ extern "C" {
>   */
>  #define DRM_IOCTL_MODE_GETFB2		DRM_IOWR(0xCE, struct drm_mode_fb_cmd2)
>  
> +/**
> + * DRM_IOCTL_SYNCOBJ_EVENTFD - Register an eventfd to be signalled by a syncobj.
> + *
> + * This can be used to integrate a syncobj in an event loop.
> + *
> + * The IOCTL argument is a struct drm_syncobj_eventfd.
> + */
>  #define DRM_IOCTL_SYNCOBJ_EVENTFD	DRM_IOWR(0xCF, struct drm_syncobj_eventfd)
>  
>  /**

