Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593AF606A89C
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 22:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ttGeHoyb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A8E410E358;
	Fri, 13 Nov 2026 22:28:00 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010037.outbound.protection.outlook.com
 [52.101.193.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8E9110E1C6;
 Fri, 13 Nov 2026 22:27:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YoCttBzSC9UB2A4w2UWpSN3x8/wz9KwrSU5rz2bWyUSRDhVEeLsthxw0ou9T1Qu1mH6dY9xCqVo5Fn0lngQSCIbaXucU4Vk+iNsd8hfy/oAS7RqofuateMdxAhydbnyCI0zycZ9gdCgWzr5lb4EMBJfqBEGjU6WgAgGyq8o83P9dP0wsfOuhqesdwS8OuRSt0PrRs+lXgM89kkH7GWbO4W69oUJv8W6JwZXz2dc8vdNaobMEW2MAuJvrnu7+2MRxS6pK17RwBx4K1I7He/CcDjtBBtYikCnsXhyu/JcS3X5rhGHtsFuwntggEnMkBtIOIHqVWJ+19dtwd9vcsTFuVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbuPc0OoAZ7ponEmKQKwRM1Aj93AVVBpwHllhPZs6NY=;
 b=ilLH+GuxgGtC24sKToAKMyMqndZSvEdFsBrRHSD8tKTbwsYpkgxrPPAr3SIKFhyCgJP7gxrQOglPZv2q0oOiagEQhqi8Pfdt68VMDMrE5d7Hjc8mkNMARa7eSNKk2ewwIETAJMDtvu9XgUE1zBrAN287J8eA8QeFMipJbsKLmOb7eGMRjN3xBRBd1Lxk7qOi4lvW/agwpLx3t0fqYltutr0X4wUONngYbaQROM4now9U5jLySVyIvBEZkYtRWJEgklYXJdINLVOgjUvsb6K7LBEK+xqF/EvGtwgdHZwOLNEWyIfZsBD71QMSy29dV9R2eIaIa/ls9kn6eGN1wG6VaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbuPc0OoAZ7ponEmKQKwRM1Aj93AVVBpwHllhPZs6NY=;
 b=ttGeHoybh12BWixcAMXorFi3xkvpuv7qzQCOZhgPO7dnmsufA8E6B8frU7S66z+Tmq5PZXGXyBylJ1v0eRCV97VLoUaEZsewiKxFfu97NHRoahRd3gokFsFxlrh3VjbRSgQjBsz6TisTQzt9PP3FyUx7UlRzx/Z2nrAMcAiVrDw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPF18A985A10.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::645) by PH7PR12MB8014.namprd12.prod.outlook.com
 (2603:10b6:510:27c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 22:27:40 +0000
Received: from DS5PPF18A985A10.namprd12.prod.outlook.com
 ([fe80::dd24:2a58:c0d0:b183]) by DS5PPF18A985A10.namprd12.prod.outlook.com
 ([fe80::dd24:2a58:c0d0:b183%6]) with mapi id 15.21.0615.007; Fri, 13 Nov 2026
 22:27:38 +0000
Message-ID: <65222154-22bf-4f31-a050-b7c0f0c99284@amd.com>
Date: Fri, 13 Nov 2026 17:27:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Hold the VRR vblank reference only on
 active CRTCs
To: Hugo Sales <hugo@hsal.es>, harry.wentland@amd.com, sunpeng.li@amd.com,
 siqueira@igalia.com, alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
Cc: alex.hung@amd.com, mario.kleiner.de@gmail.com,
 nicholas.kazlauskas@amd.com, ray.wu@amd.com, bhawanpreet.lakha@amd.com,
 chiahsuan.chung@amd.com, jerry.zuo@amd.com, Aric.Cyr@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261031143351.3222033-1-hugo@hsal.es>
Content-Language: en-US
From: Ivan Lipski <ivan.lipski@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261031143351.3222033-1-hugo@hsal.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0085.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::16) To DS5PPF18A985A10.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::645)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPF18A985A10:EE_|PH7PR12MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: deb46995-8ef2-438a-079a-08df41d552f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|11063799006|56012099006|261021135927099003|261021123027099003|261021121427099003|261022105027099003|261009223027099003|261102123227099003|261026140227099003|261028144727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TI7l+EmD8eluMldjdwSbhWLPDbs+z6VvXnd7y/uObywkWkrZ/fIxhIY8C3QMFjlqYT0G3Fyl17OV3IGeYzNqkX+j6djbKHPEq55f1HzIh/y8SJxwnxfElQSrLdjDX0rgdSyHfepWneWnOu7LGQ7e4loVPk4ZL36sCfjFiGufCg17VBXDrhdHwMwn1QYbafPQ4RyXXVKzKpHcY1Uhos09z7ym5r6tU2gsOfVL4UtyIQeZasnBcwxp38EFZ65goSEFesEgeaBbG4Vgpn9WZu+3qzDU1fwPFrPwAAOggNMmOmgpqBIzHn+YO3iegByU9HxhhmHUqnwtTATg9jyOdw43c7EK9jEex/tDrY0jtYqdepHjVofRyHVvqDyBkLqL/EX8DXmyr2tL/DS3ePY1qmim/Tn0GheaBuFKYCn/lfqludu6+onG6h+/TJX5Lgg+BpqVnPRU9G+L7ov4Njk+OHys0PsdpZGstDfUjP3xBjYBJElhRrq+UM4LWrxLy+uHQvC6k9vjDWL6rTmiZedLyCpF4DJeJdREp8VF3cVVtAooyQa4bRJr0pt5sUDmLP0VwZR3vo/VtkjyWxTH3O/lu8WKd+AdelrH6wMTyzWgjGnxhbxmCuJKsxRqse55RS3XaYRDjXUW65IY6V0jZyhhjfGwRc0HD2fsQspKNgSd+0/m2ms=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPF18A985A10.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(261021135927099003)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(261102123227099003)(261026140227099003)(261028144727099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWlCdTZLSHF4bklDdGpIYm5Da2pxNEJzTmVHcDVIV1cxT1d2MWp3QW90WEFt?=
 =?utf-8?B?bTVOTUNBVmVwU2w4Rms4eU5lVG91THBvQ01kUGJwaTc2Rm9tL3pUUDRtam9N?=
 =?utf-8?B?WW1teVA1RHJ1NjZxRGlBTkd1a2k1TWJSMmhLYy9qR3pFQ2FkV0pNZ05XRjFu?=
 =?utf-8?B?dDZqd1VMdWIrNUZpdTJ0clRDaHlzMk54WGVzR3BtNlF1Y2N2NnFIbUlLdFBT?=
 =?utf-8?B?S3JXSjRyMVlXRWlhWjEyNjkvWFpnY2doNnpQU1h6Lys5Q3VRZllrRThhd2tp?=
 =?utf-8?B?MkpVR3BRaEhXS1N5R3k2K0YwM09lcjVHdmYyOEFZN2dnUU9tNzZiMFk0cjVq?=
 =?utf-8?B?V1BBWEg1NjdYNFRHa3VFRk1XeWgyZk5YaUVVOUZxMU5XU241RTNBNjZKdFVT?=
 =?utf-8?B?RlhmQzRzMUZ6bzBTa2FpQmFBck9CME8zd1pNcWZaa29GNk5pbFVEL2xwQTBZ?=
 =?utf-8?B?cmh0STZSTkJTK2dTY0dVTEgwMXlGL1ZNUmNEaVd2VmVHN2FIOWhVMHBuZ25s?=
 =?utf-8?B?OWRVY21JRE5pS1RGV1RmTndWc3hjTXg5bFc1YUpZWkFvclJyWUQySUVmN3lF?=
 =?utf-8?B?VnFIaHUxbERPNmhScHNOMU5ITkYrVjltbXRzeXRXOUxkRWlnSWxDL3AweU1L?=
 =?utf-8?B?Tlk4eGtqbGNXRG1hTWdJTk5JeEFsbm1rTktmamZWdVdBSzhXOG15UGlpa2Nw?=
 =?utf-8?B?RmFyYlA5dmtURzhHRGgwNklZeFNWSXI0dE8rNXV6OHFYang1MTNNL1JPQmdD?=
 =?utf-8?B?SXZuR0dMSU5oamhudWt5VWk3UGtObDJPNHQ1M0VTOXd5dFhCc0xhK2NGMm5x?=
 =?utf-8?B?aXZEZ1ZaZTlINzlQeXhKQjM1QjlSWFlWMjhpWjdLNEFpRUFnYTBlMW5DdE5K?=
 =?utf-8?B?T1RsRWRTQWgyRHkxZXhpT3YzL0R4REl3TW90aE1MUVlWNkthT2NQU3FOSGxH?=
 =?utf-8?B?bHdBczZWK2VSSi81S25xR29qTFQ4TW1ZamxQTnVFbmVjN1p1NWk2cXJkZ1N1?=
 =?utf-8?B?WkcvTWJjZ2RobXdkcEtBeVFTalZXSUl2TFlDeXYyeVQvRjNTWGd4ZkUzSjR2?=
 =?utf-8?B?blRYMmZnTHMzUGxQQTZGU251MnppME9VMEpUblExUGxOdmN6L29TUy80K0g0?=
 =?utf-8?B?dFRQazNDOXQyQW1ualNSMEx3MVpVNi93ZFNJd2EvR2o2M1E2L1c0UEQ4dVhF?=
 =?utf-8?B?cnZPK3RsVEt1M0JoaUMrTnZIczBlek5MVXJ2NWc3RGkwc0FRZXJxK0VZM0oy?=
 =?utf-8?B?L0tkVkI1bWZ0Vml6ZVorRm15V0NWNG03akNVUjRucEpheXJSdDFxMUswTUcr?=
 =?utf-8?B?dGhJVE1TdytueVFlVXNoUjQxWFAybytFU0krN1VON1cxZUdneHZoY1lxTkhH?=
 =?utf-8?B?akRFMk8zYWhwYktpVmZXcXdvTmZQbjNhRkRNNGJWQkpzc0twVDdCdGp0cnJK?=
 =?utf-8?B?KzB2VUFGMXMrZGVKVERIWGlrV1BPTmFNaDVUeHFzcWNaeDc3eURtVkI1aUNB?=
 =?utf-8?B?cDBTMTlrVU1IVlN3d25MYXhKMEFZWGFwNENHQUYrWXlyRkZodzVRSnZGMmdS?=
 =?utf-8?B?eUJQWnNDU3BTTTBnOFNrdHFTY2tRZGtZNzNxQXhxOGtuOVNOVXZ5YVQwL0hZ?=
 =?utf-8?B?Qmh6Y0NKV0lETXZNRFZ1aHdmZE05NWZqN3N1eldlY0ZtTmlMREc0VFhYVWtC?=
 =?utf-8?B?YmlZS0JyclI2cnZKTWMvOEJnYlZHU1FrMGtoWTloOVRXZFIwYkhkZEpLTGdU?=
 =?utf-8?B?a0hwTFExa1Q3UzViK0VyL3R6SXFXZnBZd0VROTBYWWtpSi9SYjNTdnFZUVJh?=
 =?utf-8?B?Tit6S25sV0lSUjVjQzU3d0R0V3gvSDI0bGN4MWVicUd4MnNka25lZithdkE0?=
 =?utf-8?B?SDAxdkRHdVpNUHA1ZGwwTG1EWmJROWhKOGxXNHkzTW5VeFRZd1VoeXdvUTh2?=
 =?utf-8?B?UWMwc0JYZ2lORWdmVThNL29EY1piUE1WY1pZSldSS0ZOcm55YkMxRENDL201?=
 =?utf-8?B?QW9CU0x0OVpMYzJuRklsYjNOTjdXTEhvNGVmTU1JMTJtWU1XeHdsbDB3U0xZ?=
 =?utf-8?B?M2hoVzI5Qmo5RGVZL0lxaGlrWGRILytVd1VGbm51SnpRMGJEUmU3ZW5lV01O?=
 =?utf-8?B?bFh0bThRM3JCREE5V2ZvOFlpZitmSkpGME9KR04zcFZUVzRwMU5sSVhMS0dN?=
 =?utf-8?B?S3VzNFE5RXJsa0xkMGs4NndEUi9TaCtQTll5eHJqWGszb0oxWnFQVy9DM2li?=
 =?utf-8?B?cjI4UmNpb0U1dE5XbSttUjhPV3FSWVMyRW8wZUhyNnJIQjJHMjh5c3ZPbkth?=
 =?utf-8?B?blZ6cU16Y0xFb3N1QVh0QklkNTFkWTRuWVNlaUxKMkdNY0cvc3RLdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: deb46995-8ef2-438a-079a-08df41d552f3
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF18A985A10.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 22:27:38.7258 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I07yKZuM8IeBhDfGlbzjMhjId3CaU2BJOm9RE+3WuAFmRz1ITsC4uyju2v9L4YoomGJB7drFFrXQm9YpU6wpSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8014
X-OriginatorOrg: amd.com
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



On 10/31/26 10:33, Hugo Sales wrote:
> amdgpu_dm_handle_vrr_transition() takes a vblank reference when a CRTC
> state turns VRR on and drops it when a later state turns it off. It only
> looks at freesync_config.state, and disabling a CRTC keeps that state,
> so a suspend or DPMS off with VRR active keeps the reference
> 
> On resume, drm_atomic_helper_resume() first calls drm_mode_config_reset(),
> which swaps the CRTC state for a zeroed one. The restored state then goes
> from VRR_STATE_UNSUPPORTED to active and takes a second reference, and
> the first is never dropped. The vblank irq stays on for good, so the CRTC
> never idles and PSR is never entered
> 
> A VRR change on a disabled CRTC can't take the reference at all, since
> vblank is off there and drm_crtc_vblank_get() fails with a WARN
> 
> On a Cezanne laptop with VRR always on, each suspend added one to the
> eDP CRTC's vblank refcount, and it stayed at 1 rather than 0 after VRR
> was turned off again
> 
> Treat VRR as active for the reference only while the CRTC is active too.
> Disabling the CRTC then drops it and enabling it takes it again, which
> balances suspend, resume and DPMS, and the get only happens once
> manage_dm_interrupts() has turned vblank on
> 
> Fixes: 66b0c973d7f7 ("drm/amd/display: Prevent vblank irq disable while VRR is active. (v3)")
> Signed-off-by: Hugo Sales <hugo@hsal.es>

Reviewed-by: Ivan Lipski <ivan.lipski@amd.com>

> ---
> 
> Tested on an ASUS ROG Flow X13 (GV301QH, Cezanne, DCN 2.1) with VRR
> set to always on in Hyprland. bpftrace on drm_handle_vblank showed the eDP
> CRTC's vblank refcount go up by one on every suspend before this patch.
> With it, the refcount reads the same before and after a systemctl
> suspend, and drops to 0 once VRR is turned off
> 
> dm_test_handle_vrr_transition_round_trip now sets base.active on both
> states, since an inactive CRTC no longer takes the reference. The
> three new cases cover the CRTC turning off and on with VRR left on
> 
> amdgpu_dm KUnit on amd-staging-drm-next (ba496bb83788) passes apart
> from dm_mst_test_dsc_link_bpp_between_limits and the two
> dm_test_crtc_enable_vblank_ips_restore cases, which fail or panic in
> drm_vblank_restore() without this patch as well
> 
>   .../display/amdgpu_dm/amdgpu_dm_freesync.c    | 12 ++-
>   .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c | 98 +++++++++++++++++++
>   2 files changed, 108 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
> index 386ba88c57c6a..ee8a11f62a0d3 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
> @@ -414,8 +414,16 @@ void amdgpu_dm_handle_vrr_transition(struct amdgpu_display_manager *dm,
>   				     struct dm_crtc_state *new_state)
>   {
>   	struct amdgpu_device *adev = dm->adev;
> -	bool old_vrr_active = amdgpu_dm_crtc_vrr_active(old_state);
> -	bool new_vrr_active = amdgpu_dm_crtc_vrr_active(new_state);
> +	/*
> +	 * A disabled CRTC keeps its freesync state, but drm_crtc_vblank_get()
> +	 * fails there because vblank is off. Hold the reference only while
> +	 * the CRTC is active as well, which also covers resume, where the
> +	 * reset state lost track of the reference taken before suspend
> +	 */
> +	bool old_vrr_active = old_state->base.active &&
> +			      amdgpu_dm_crtc_vrr_active(old_state);
> +	bool new_vrr_active = new_state->base.active &&
> +			      amdgpu_dm_crtc_vrr_active(new_state);
>   
>   	/* Only DCE gates vupdate on VRR, keep it enabled for DCN */
>   	bool vrr_gates_vupdate = amdgpu_ip_version(adev, DCE_HWIP, 0) == 0;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
> index 710cdc7f40bf8..3268bdb1043ba 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
> @@ -855,8 +855,10 @@ static void dm_test_handle_vrr_transition_round_trip(struct kunit *test)
>   	mutex_init(&adev->dm.dc_lock);
>   
>   	old_state.base.crtc = &acrtc->base;
> +	old_state.base.active = true;
>   	old_state.stream = stream;
>   	new_state.base.crtc = &acrtc->base;
> +	new_state.base.active = true;
>   	new_state.stream = stream;
>   	new_state.freesync_config.state = VRR_STATE_ACTIVE_VARIABLE;
>   
> @@ -867,6 +869,99 @@ static void dm_test_handle_vrr_transition_round_trip(struct kunit *test)
>   	KUNIT_EXPECT_EQ(test, atomic_read(&vblank->refcount), 0);
>   }
>   
> +/*
> + * Runs a transition on a CRTC whose vblank is on with two references held,
> + * so a get or put never has to enable or disable it, and returns the
> + * refcount afterwards
> + */
> +static int dm_test_vrr_transition_refcount(struct kunit *test,
> +					   bool old_active, enum mod_vrr_state old_vrr,
> +					   bool new_active, enum mod_vrr_state new_vrr)
> +{
> +	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
> +	struct amdgpu_display_manager *dm = dm_kunit_alloc_dm(test);
> +	struct dm_crtc_state *old_state, *new_state;
> +	struct drm_crtc *crtc;
> +	int refcount;
> +
> +	KUNIT_ASSERT_EQ(test, drm_vblank_init(&adev->ddev, 1), 0);
> +	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(2, 1, 0);
> +	dm->adev = adev;
> +	mutex_init(&dm->dc_lock);
> +
> +	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, crtc);
> +	crtc->dev = &adev->ddev;
> +
> +	old_state = kunit_kzalloc(test, sizeof(*old_state), GFP_KERNEL);
> +	new_state = kunit_kzalloc(test, sizeof(*new_state), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, old_state);
> +	KUNIT_ASSERT_NOT_NULL(test, new_state);
> +	old_state->base.crtc = crtc;
> +	old_state->base.active = old_active;
> +	old_state->freesync_config.state = old_vrr;
> +	new_state->base.crtc = crtc;
> +	new_state->base.active = new_active;
> +	new_state->freesync_config.state = new_vrr;
> +
> +	adev->ddev.vblank[0].enabled = true;
> +	atomic_set(&adev->ddev.vblank[0].refcount, 2);
> +
> +	amdgpu_dm_handle_vrr_transition(dm, old_state, new_state);
> +	refcount = atomic_read(&adev->ddev.vblank[0].refcount);
> +
> +	/* drm_vblank_init_release() warns if vblank is still enabled */
> +	adev->ddev.vblank[0].enabled = false;
> +	atomic_set(&adev->ddev.vblank[0].refcount, 0);
> +
> +	return refcount;
> +}
> +
> +/**
> + * dm_test_vrr_transition_crtc_off_drops_ref - Test disabling the CRTC drops the ref
> + * @test: The KUnit test context
> + *
> + * Disabling the CRTC keeps the freesync state, as on suspend or DPMS off.
> + * The reference must still be dropped, since resume restores the state from
> + * a reset one and takes a new reference
> + */
> +static void dm_test_vrr_transition_crtc_off_drops_ref(struct kunit *test)
> +{
> +	KUNIT_EXPECT_EQ(test,
> +			dm_test_vrr_transition_refcount(test, true, VRR_STATE_ACTIVE_VARIABLE,
> +							false, VRR_STATE_ACTIVE_VARIABLE),
> +			1);
> +}
> +
> +/**
> + * dm_test_vrr_transition_crtc_on_takes_ref - Test enabling the CRTC takes the ref
> + * @test: The KUnit test context
> + *
> + * Covers resume, where the old state is a reset one, and DPMS on
> + */
> +static void dm_test_vrr_transition_crtc_on_takes_ref(struct kunit *test)
> +{
> +	KUNIT_EXPECT_EQ(test,
> +			dm_test_vrr_transition_refcount(test, false, VRR_STATE_UNSUPPORTED,
> +							true, VRR_STATE_ACTIVE_VARIABLE),
> +			3);
> +}
> +
> +/**
> + * dm_test_vrr_transition_crtc_off_keeps_ref - Test no ref change while off
> + * @test: The KUnit test context
> + *
> + * A disabled CRTC has vblank off, so a VRR change there must neither take
> + * nor drop a reference
> + */
> +static void dm_test_vrr_transition_crtc_off_keeps_ref(struct kunit *test)
> +{
> +	KUNIT_EXPECT_EQ(test,
> +			dm_test_vrr_transition_refcount(test, false, VRR_STATE_UNSUPPORTED,
> +							false, VRR_STATE_ACTIVE_VARIABLE),
> +			2);
> +}
> +
>   static struct kunit_case amdgpu_dm_freesync_tests[] = {
>   	/* amdgpu_dm_is_timing_unchanged_for_freesync */
>   	KUNIT_CASE(dm_test_timing_unchanged_null_args),
> @@ -910,6 +1005,9 @@ static struct kunit_case amdgpu_dm_freesync_tests[] = {
>   	/* amdgpu_dm_handle_vrr_transition */
>   	KUNIT_CASE(dm_test_handle_vrr_transition_inactive),
>   	KUNIT_CASE(dm_test_handle_vrr_transition_round_trip),
> +	KUNIT_CASE(dm_test_vrr_transition_crtc_off_drops_ref),
> +	KUNIT_CASE(dm_test_vrr_transition_crtc_on_takes_ref),
> +	KUNIT_CASE(dm_test_vrr_transition_crtc_off_keeps_ref),
>   	{}
>   };
>   

-- 
Thanks,
Ivan Lipski

