Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87316606A31C
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 01:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=e28VnbUM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABD1C10E056;
	Sat, 31 Oct 2026 01:44:44 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011022.outbound.protection.outlook.com [40.107.208.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 794CE10E056;
 Sat, 31 Oct 2026 01:44:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQTDFYMIHIBZuMLyii5m8ZVmKTF4cxJnQOJNE/5Lp10QWB9rWoxsUFLnviK+dF6L6P0AkFuhVpCRjDQmEHcZFLJyDbiACiMXtl1GUYFbmDpYV+z1Yao506kKV1VnM81noaWqOSP9T9cIST/V1AT29KwOIJh/cErGeeXjro8yxYzG5tW8+031j4sZJgPBZgaBBZoS5V1Me9YSjXPiasan7t/0pzYM+2VW6UC04TpqBrnSnP1yxxuBYOVBKTWEVbFim89NvcHK9dx4qAPxFzzyfUGU5Dma3QTaJCl/ghwnblYHTVOuWTYrp8mmwGG7M3fBpIHC6kBTtFEzjOJdKAE/2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7ZVhX3j+0gnWO0XJy19rVkgDwm7sHELrK17kvif1S8=;
 b=eu2r3uf4FrsSV864TXw9arNzBAkkKmo1Lkcv7hXNAJpbG5L6U1uU1rsKw7+q7SUcaDF4rJGVgsxsa6KW+77uuX7XV0T7geSAVUBC6k6zHsd30s9VmmAIKvB+MLcQkRS3nWl1EPtwPXzAV9g1XygkBiCbG75MkZBLcQFeKl9XNf64f9STvQQ/5W3Qt57TwIMSPkB66nk1H3+yI/mumoNXwffm48lXCE71yTNqkt5OupFHfnSkD705KledljWUd4RS1OtFjxoAwWkyhe8XO6e4/k0xKasCFnwqom1zww5P9RyZMKPDyOA8JpMFBhnq9VDTGwP7SYHqsEkVfzDvq3+50g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7ZVhX3j+0gnWO0XJy19rVkgDwm7sHELrK17kvif1S8=;
 b=e28VnbUMhoFa/ZyX3uin8sjQHSQpvDJ7k28exvgh2l0Rbq7PsWcNlZGWyu3grHBGqOtC8iDL+T32bMb4TUvW0Arc6HrIz0yvLxURR/cjdekme+MGnxgPmHulphPiZfhOTh72R2pG1nk1UJqhxZm5tcPxAQpy8LQ3B1N0SpgL3eI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY0PR12MB226969.namprd12.prod.outlook.com
 (2603:10b6:930:130::18) by BY5PR12MB4052.namprd12.prod.outlook.com
 (2603:10b6:a03:209::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Sat, 31 Oct
 2026 01:44:34 +0000
Received: from CY0PR12MB226969.namprd12.prod.outlook.com
 ([fe80::f47a:5d4e:f3d5:5b26]) by CY0PR12MB226969.namprd12.prod.outlook.com
 ([fe80::f47a:5d4e:f3d5:5b26%4]) with mapi id 15.21.0569.009; Sat, 31 Oct 2026
 01:44:34 +0000
Message-ID: <94b0ea91-3fe6-4458-b0c1-14d487a11352@amd.com>
Date: Fri, 30 Oct 2026 19:44:31 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix NULL deref in
 dcn401_update_clocks_update_dtb_dto
To: Roman Demidov <roman.demidov.nn@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dillon Varone <dillon.varone@amd.com>,
 Gaghik Khachatrian <gaghik.khachatrian@amd.com>,
 James Lin <pinglei.lin@amd.com>, Austin Zheng <austin.zheng@amd.com>,
 Bhuvanachandra Pinninti <BhuvanaChandra.Pinninti@amd.com>,
 Kees Cook <kees@kernel.org>, Wenjing Liu <wenjing.liu@amd.com>,
 Alvin Lee <alvin.lee2@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20261019072938.10074-1-roman.demidov.nn@gmail.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20261019072938.10074-1-roman.demidov.nn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:303:16d::16) To CY0PR12MB226969.namprd12.prod.outlook.com
 (2603:10b6:930:130::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY0PR12MB226969:EE_|BY5PR12MB4052:EE_
X-MS-Office365-Filtering-Correlation-Id: febe698b-3884-4da2-d718-08df36f083d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|11063799006|56012099006|261009223027099003|10067099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261022105027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wNaqds2NguV7VBOBL6R4Wydd3n81MQVvW2VhGXZodN5/6hX3xLlikpWEYaM8K5BNI5rFsdqQZX1EsCm05FbNq1N+FnwHVJnHRZwXhu8GskO+3bGs7drKxv+f6qlu2TrNRIAwQHR+gTk+2yhQuNPnMEhPeHf1z1ySg+ZINfpdpLCaVozlS7l4Xe0tGfOigFXjDPsgcLOarUfRFOTs7p+al928aBgZI3neimevphc42in5728A4JeCF+mkvfxT/5eE3n/9ZW1Bk4ZOdXnJqogQJReGD/iy0vNqoAFM96vTu5BdHYMIi/XNY8vUn0xfxinAg+YmebzaIZDZWAQ1mvP4MalHTROEkoR9RQVOftWpuZfXi6BEoVaD3hxtqZeA/1Oautbyn6BdKJMkqM0gZ+yXwIdHIs5jd7kOi6nQdLepQK80Eh/CdGI/ijTxDMwzjZPkj+zVd78eDrawXR0Ew2Gp33gezObsjBLDJp6eR0lCSpYVrr5lRolfaSTimg5/W4G2SpHPFun3rVEFl+sEfmtqkLHYdLQBdDcDwrkdeD9XNuUIPOeJWM4gmmOPZZwnUBFLvimUO8GKUvNNSWzOugMKcOkYBYJE6XDNDh7VVWicMEpB1CL+e49ufwEE36ARAZiMq/2F+yRYfbaXr9iYWPtDeeBv1ncgFTF3JamGKH4twIE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY0PR12MB226969.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(11063799006)(56012099006)(261009223027099003)(10067099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022105027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RW85VlZkMCtIdXhSQ0s4anJkTDk4WVkrNnNFWGpxMGxjVWRVZmRSbTFTL0pY?=
 =?utf-8?B?aWVwajc2WUkyVXA5SzB4WHJkbVpFYlQ3VW02MzJFL3RZNFA5YTJPUTdhZS9l?=
 =?utf-8?B?Rm1xaWtsK0Z1cXVMeStSU0NUZDNoaGVIN0t6SkxrS3V1ZHpGckhoNjhtay93?=
 =?utf-8?B?Uzdreml6WkJleTZLMDZ0WDUwVjd2cmg2a0hneHhoKzdoVmlKdUJoaTRuN2o5?=
 =?utf-8?B?RzVoaHZOZGZOM0ZOdGZKcVp0bUhqRlVwR2tudk5nVW1BMHhKY1BiUStlc2M1?=
 =?utf-8?B?NHFac2cxZ2E1ZzFXWjBNcmxOVXV4eUdqei8waUFLOUdmZWtncFBnWlJ2UVdi?=
 =?utf-8?B?ZFluYWxxalNoTUlHOEFOL0hoc1RBaExyUnBEM3ZOaDg3TXhEaHZPeTVDK3dX?=
 =?utf-8?B?T2U4b3Y1MXdyZUYwT0JJT3lxaUhWQ1pGem5ZZW1Jc0RTL1phU0hjalZWMXQ5?=
 =?utf-8?B?cEU1NlZ5emc3bkNuMlIrZlNtOFVRQmFyVSs2NWx2aU5hOWIwY01Vcnl5YmtZ?=
 =?utf-8?B?MlcvYjJEN0paRURWQ0R4bnNnbkpxNmM1eVU0OWpsalBDeG1jaVVqOElhMUhS?=
 =?utf-8?B?a2dDVmpzS1UzMS9HK3c2N09TNGx4YjZGekhzVmdqejlvdkpRcmdPaDBnMmsr?=
 =?utf-8?B?WDJ2ODlrRHkyUGhXN1hJdDJvajZ6Z2hGUUtxM2F6UG1oaHNUbDZYTUErSW85?=
 =?utf-8?B?emRnaEhGSVFsL1ZNY1J6cEtsNHdOYVZMUXQ4Tm40S09MUXE1NDJhS2wxR21E?=
 =?utf-8?B?M3RXajlQNUdRdWZhdGtPQnJQNWZHN0xIczA1SlZPNDU5SjhqdEIzUnFDREhv?=
 =?utf-8?B?ZGgyWjExcVR0dEVFekMrbkxFK0J3ZFJ4UHN6NnpRZTgxZmFJRWJDdFdXYTZ5?=
 =?utf-8?B?YnpoSzFkT2tHTEllUDVYK2pvV2VpaS92czVUNElTQUF2M0owQU1mVzFqdXk1?=
 =?utf-8?B?alVYdEpQeGxBNlhJYis2RCs2T2dyZnJIcnhCc2VJSUduM0Jld2RGcVVXUExp?=
 =?utf-8?B?aktYTHFMeVY0bkRVbUJOckw1RnJncmdJa2NBWXlsVC9hNVJPc0cwWEtBSUZD?=
 =?utf-8?B?aWszQVIzNDQ5Tm1HTjgyRk14cEdvUUVOSHpKZEhWaHJXdjJ1K2VYeVRWNWZq?=
 =?utf-8?B?cXgxQ2tUZCsrV1A5WUxBcXJJdWRCQ2NkT3ZZSHljcitiSk40RktjYi9RZ0xW?=
 =?utf-8?B?OVJQdVY2VHpvSWI1bDZnemFvdXpRanJxSkFra0FtK1B0WjAzbE1IYjJHbU9C?=
 =?utf-8?B?elh3Z1Y5Z1FSMEwvb291ZzZ5OTNpay9MVU80ZG5MT1FqcTY3Vjd2UzNGR3BY?=
 =?utf-8?B?UmRmMjB1cVRhYVJybGhHU1VLY1crV1I0OThXbHA0VXp3OTlKWGRaRnh0ckNK?=
 =?utf-8?B?UUxMZllGejlpQXVsQmlvUGhpVTdKTTB1S0lSY3NlMlVsNHA1VGhiVHFqSFZx?=
 =?utf-8?B?aHA3djNCVTN3VGp0ZGVmYXpFbzV2L1NtNG52eFNxOXFId2pJdGhOQkdlMzhV?=
 =?utf-8?B?bkkremFjVlhLakY4Q2JieWtSaVpmejl3ZjhHWE1jYkNSWjRIUHFscEhRellS?=
 =?utf-8?B?d0VhVWFRS2tiR25jVFAwanlzazZZOFI1SWFjYmYzeXV1UWUrcWMzNVlsU2x5?=
 =?utf-8?B?Y3M3R3pOVEJaMzVVV1dsa0tlaUxjZnd2TXp0WlZOcThob2JNZHdibCs0UlFQ?=
 =?utf-8?B?eGhEUjlRdVU3RGxXS1FoQXNoNmxQVmtpZkluVHlmZ0FmRXZLUXpNY01ZWTlL?=
 =?utf-8?B?L01iVnJLK01mSnRWTk11c0s0N041TTFUWXBiUXBDWWpTNm5MNTdXajFoQWtF?=
 =?utf-8?B?bGxIT3J0Q2UyclgwdWcyTUZBYk1hbHV0WW9SMDhrV3Q1UnMvYlU4cy9aUHlx?=
 =?utf-8?B?djEyTGtseU9qNGJLUHh5dzZ1bVdOVUxTSTgwNW1pMWtWd1ZLbklKK29Td0kr?=
 =?utf-8?B?QUpzWFlNNmUvZ3cyK0MrM25VN1A2R0tEUkQ3WDhhU1Vrb1JOakhoTDNaN2c1?=
 =?utf-8?B?YWZaMWhJbUIwNUMrZWNqdndmbDcrdU03UVFyWUFZUzl1Z2g5Qm82VFpFL09W?=
 =?utf-8?B?Zm5jQ1lKVG9LNHFkT3M0ZE1tcGc1QWg0SGZ6NDk5Q2ZzbDVhQTZtWjQ4OGw4?=
 =?utf-8?B?b0dlWllxRnN2bi9TOEkzekxuSk1MZm9XcWRZWXFhd3VPUzFmdUFZVldYOERP?=
 =?utf-8?B?dGtQR2IvSVJ6T1B4QWpxcmlrTTdaeWNWaUozSGtUWFVldDAvaWhFek9SeVJx?=
 =?utf-8?B?Q2UxdnU3WHMyTkZDcWZRaHY4V0FKNVo0VzI2WTNrWWpZamJCSGRkTEUwVWJP?=
 =?utf-8?Q?ryzrjoO+n4qsRfWUfc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: febe698b-3884-4da2-d718-08df36f083d4
X-MS-Exchange-CrossTenant-AuthSource: CY0PR12MB226969.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 01:44:34.2813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yWzUWSj5AR2tMhQkgqqoclT2WqvjiASW9JRLJB2K6uewpvdZj6Oy2gEMjFHmecK2IG/Z1Izxqi7bPwh3drOAyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4052
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 10/19/26 01:29, Roman Demidov wrote:
> [Why]
> resource_get_otg_master_for_stream() can return NULL if no OTG master pipe
> is found for a given stream. The current code dereferences this pointer
> without a NULL check. This may lead to a possible NULL pointer
> dereference.
> 
> [How]
> Add an explicit NULL check and skip the stream if the OTG master is not
> found. This is similar to dcn60_update_clocks_update_dtb_dto().
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: b6d508533fa1 ("drm/amd/display: fix a crash when clock source is reference for non otg master pipe")
> Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
> ---
>   drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
> index 6ee3da89d058..135eeef68ac4 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
> @@ -538,6 +538,9 @@ static void dcn401_update_clocks_update_dtb_dto(struct clk_mgr_internal *clk_mgr
>   		otg_master = resource_get_otg_master_for_stream(
>   				&context->res_ctx, context->streams[i]);
>   		ASSERT(otg_master);
> +		if (!otg_master)
> +			continue;
> +
>   		ASSERT(otg_master->clock_source);
>   		ASSERT(otg_master->clock_source->funcs->program_pix_clk);
>   		ASSERT(otg_master->stream_res.pix_clk_params.controller_id >= CONTROLLER_ID_D0);

