Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D64606A323
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 19:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=H/QfoIdn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C77F410E6BA;
	Thu, 12 Nov 2026 19:41:58 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010045.outbound.protection.outlook.com [52.101.56.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFB9310E4AF;
 Thu, 12 Nov 2026 19:41:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hewdIU2egz2yDvEkzM+1QaCreHKULQcCOpQyShRGdc7lG6JoFBWEbMf0+VIyDbwNDGh0ykjYITDrfzDwKbfINKclMbnC2x7fzh0TcTBbxwuTxrNYgyggWgPWHrxNOYShFMnNNJIG9Udy07Y0WHtYMwu0arkGGrVgNrHF5QMwAcKt3JACgeL72cP1JbnN9ZcFOFuNiTv/YS98EXKBU8SJ0BpP62AoE/3dX5rEkzN1W7nTt69ivayzLRCDHzrzUOzornZlMxou/iqC/cVg5nkh2MwQKWBt/dLq5jGehV5Y1ejw+K0kVWt3HxUBlJ067zMieprva0nGS4TUHLLjE0cFWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3YTA6/Gcp0AIKPyMcdwclSYeqk+p5Y0h8dSa1BZ1uw=;
 b=EMAWf9rjZ8ES3umWnp/gTkL+rICWER9i8KIRPtLcwssdeFdTzMrH0l82Ndv8Ebu4yu/xcSMYsAskDDvnnH1ka+ro54wGskTG47CRX0zcqayXsiIRUMeghz04wRYBrH/qoDv91+qUS5Anbpibbw62X0Iw0Q8IpAQUUwArJasEyyCUqh+VlvAb2a4Rq6tJ/3zMhYhk34UNNEcAIKp3uZbG3DuUNsgGYAYaeotMEa5grMn2/NuOSXc6CaXLoGdC7+Du2Z3uq5DwRflWEbKdIZf/qy9rt8Zof7QYNFkvbM2ZBBl9ldRPvjW844iC+HevF2Vk5cYU4ahIsmLa/X5dgoPVsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3YTA6/Gcp0AIKPyMcdwclSYeqk+p5Y0h8dSa1BZ1uw=;
 b=H/QfoIdnCqHH+W5CKNIxaWRoyUItrZNNmDhZoQPyo1xyRq8jVcPT3IHCFoXalU7HCVuk9NXN9k7icoNpmvPm8VncS2qrZpMfazJnOm9ZxTwUu0SuH/JGjl4FrKcPcLz6ak0VxcCQlzjM1PuH6NB19UAjjlXzxRr90ROkjwQXXGY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA6PR12MB893085.namprd12.prod.outlook.com
 (2603:10b6:208:601::18) by DS0PR12MB9059.namprd12.prod.outlook.com
 (2603:10b6:8:c5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 19:41:45 +0000
Received: from IA6PR12MB893085.namprd12.prod.outlook.com
 ([fe80::3f4e:1f38:3db2:270a]) by IA6PR12MB893085.namprd12.prod.outlook.com
 ([fe80::3f4e:1f38:3db2:270a%5]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 19:41:45 +0000
Message-ID: <3179d0b2-cbfa-4f09-9e24-363210718fb3@amd.com>
Date: Thu, 12 Nov 2026 14:41:36 -0500
User-Agent: Mozilla Thunderbird
From: Harry Wentland <harry.wentland@amd.com>
Subject: Re: [PATCH 19/19] drm/amd/display: Replace dc_get_caps with
 purpose-built capability queries
To: airlied@redhat.com
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Austin Zheng <austin.zheng@amd.com>,
 Jun Lei <jun.lei@amd.com>, Kenneth Feng <kenneth.feng@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20261112-amdgpu-dc-cleanup-v1-0-0fae41718ad2@redhat.com>
 <20261112-amdgpu-dc-cleanup-v1-19-0fae41718ad2@redhat.com>
Content-Language: en-US
In-Reply-To: <20261112-amdgpu-dc-cleanup-v1-19-0fae41718ad2@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0322.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::11) To IA6PR12MB893085.namprd12.prod.outlook.com
 (2603:10b6:208:601::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA6PR12MB893085:EE_|DS0PR12MB9059:EE_
X-MS-Office365-Filtering-Correlation-Id: 2674d62f-6c52-468e-7bf6-08df40f4fbce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|261026121527099003|261009223027099003|10067099003|261028144727099003|261026140227099003|261021123027099003|261022113327099003|261102123227099003|261022105027099003|261021121427099003|261022075727099003|56012099006|4143699003|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Nzv0XmuR5lrABBDATflFc1v9NL0scuvH/WTjYR5MKI24PLaFY2SyMMY314SUutyx0CIHsJf+mqvw818UnIB5wd9aGL/3woqBVdZ+Jx7fRPr3RvwIJul5OYSK833nUOrKFY0kJZajtUkBAIb3JayDQI8qvpMsGall36p9SU468pgjq4QIE13RpMRseSEvO3GG3xrVWdCkaEF3Kip3BMDoPTiaFmmdfPX6DYKg/xqH1G2c/0aIzTXEZdG5HLFVUlfTs1cqf+37rCQI9G20dMTb4isUDAo9s9JTESNEytc7lkCH3VzH93YSAjEGAVDFEbpkCuhN6Xag8QnlxGNXMC9pqLKs1d/l70rkhbdLVXMTeZZWwB72oU2qqrmZaBspxzuFQEVR9td8exr+AsU1HXYAeT2hw4JxQL3miskBGY9YWCZnZEpuoTWlpoAMWfTveLSOnMaDfdemfDKRTH83pxoGhZtN9w21zkzJ2bH1hmc2l8cOdz/WrkSimMCWuXTzqZSu3UN8/b3laMf+FogOCdmPOSHmqdhM6XCPFviZifaU3KYbyEyycfFAxsX+YjrvVOer8w/UtZJL2FHrY7MnDlf492XDeeRXdtZv0+KP7avGv478u+K43am6O/bPyU5QsKXeSacNFqs/R/8x+FYcC34xhYBIs5yvGiNHe95UJhemzfc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA6PR12MB893085.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(261026121527099003)(261009223027099003)(10067099003)(261028144727099003)(261026140227099003)(261021123027099003)(261022113327099003)(261102123227099003)(261022105027099003)(261021121427099003)(261022075727099003)(56012099006)(4143699003)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTJEM1lhMVlEL3EzOUxwdFRFbHdNQS9FUmtuQW1nS0o3RlpoWm9xWVdZNmtI?=
 =?utf-8?B?WWd3OVRSd1RKQTQ0Q2J1L3J3bjhXVWptYUZlWGY5elEzOHdtMW9aOStlTEFk?=
 =?utf-8?B?cXc4WDZ1VStqT1BrWEx0T0NETVo4eDlXYjJiNGtLZVF2MndqNnk1TVhiZmpn?=
 =?utf-8?B?QmJvYnFhM2VGREtXZGExZS9uRUcwaVhWdTZxUkNqL0l0RDJEWHQ4WXRqN2JT?=
 =?utf-8?B?c2JBWHB5cHQ5RFp6QjdFWjFTdlU0cE1NZjhWQ1NvOGt5UWl2UjNMeDJJRFdU?=
 =?utf-8?B?RnlydjlIczNYd2tWMnZxUW1tNjFuNW53bm5PZGx2bDR4b1pVbnlxSWJOQTdZ?=
 =?utf-8?B?QWM0MlIyNElLejBjVmZ5emV1ZThlYXpuMzZwbDRwUytndnVKWkptQjhyUDdr?=
 =?utf-8?B?UWFMNG1JK2VzNE5vQVc5b3dEUSt4cHFJams3NFc1S3diREFTcVNEa3JaOXRu?=
 =?utf-8?B?Tnp2SmIyb0svbnlFaVZ2RHhMd3M0SnRTRndvb1YyV3lqK1REanVOczczRmlC?=
 =?utf-8?B?emhZbDFmZEZ1K1g2c2xKbGJvNlNaV1dOeDdJTHorMGQ3VUU0SFkvczR3UWVH?=
 =?utf-8?B?dyt2WGsyVktxTEpvTndVT2lZN2tNYStIS0FmVmwwZEgzQkRZSjU5SHhTNmtN?=
 =?utf-8?B?K1M1WVhIL0dWZ1BzMmVtZUhKOHphdjA1cGdra2sxTWJrOHV4REtJNkhqRGdj?=
 =?utf-8?B?c3U2KzMzem1KRDZId3hWVlptWVBFeEkvekxXOERiVkFYaEJNemxFUW1qYUNO?=
 =?utf-8?B?QmU3R2N5VmRIbnI5Q09kU0pQanZXQnViUG1jb2N0c3ZNaERzM3p2TTJxaVhR?=
 =?utf-8?B?R3JoS3BSWStQZmpNekp6aTZkSjlwRVQ4bHl3YlRKaGFKUkMwOHpqSWdwOWdm?=
 =?utf-8?B?WE5WS1gyRDc2MHNZaDZ0djlqa2N0ajg4cVpJdGQ1SmhMQWYydGFDN0dtanc5?=
 =?utf-8?B?UkYwcS9GdnVGSzhEM0tZUkFxWGovbGRoL2RXWGFJZFZ0MHEzRW96ZVZLaUdw?=
 =?utf-8?B?dTB6cFJJQkVaOWVmd2VLQlpoMzVucnkyMElaS0M0NW84ZFRFT0tsY0FtaVdr?=
 =?utf-8?B?SXBxSHBEcXRCcmVDRVdPaWVlM0UvaGIrYUNkNFMyTjQ3VEFtK01neG1SdmVR?=
 =?utf-8?B?MGs1TUFBclBPUnUxWkwzdms0KzNSem1YazhseDNjVEJxdURUei9ldi9HeVgz?=
 =?utf-8?B?ckx2d00yUXI0NG43aWRVVmpJNUNrVHJSaU9OdlZCQ3hFRmZHamdRSmgwRXlR?=
 =?utf-8?B?RTdTaHpTdGI4T1JRWHN6dXVvbVQ3ZTE0cHhzU2dZa3NuU0tCWmxTcnh1bC9N?=
 =?utf-8?B?NjhRazZza0h6M2FDYlorc2w3MXNzVFVuVGNYS0ZxeEFNWGRXMm1oVTQrangw?=
 =?utf-8?B?UFNmdEh6RXdrNEo0NE95TWh0R2Jsdm1kSlE1MnJCdXNlRE1pRCtHM205WGN2?=
 =?utf-8?B?elBXcWRlZWRZL3FNVHNsMzhLNXdjSFhXblNUSXNpVzMzM2wrSXcvRml1U3ZW?=
 =?utf-8?B?aEFua3B4WmpEdW1PZmloQlY3Q3hPWTdKSE9qcFhDUTk2d3g1Q3VZOWVUM0tB?=
 =?utf-8?B?Wi80Q1VhU2w1bkZlV0tFMWZjbjdZK3lXQW11bFNZb0NiY1FOZGg4N293b0hM?=
 =?utf-8?B?SXdYcHF3NG1COEU3YVFKT0ozNFdsVm1MMFN6WUlUNVJOQkN6cW91djJaSlE4?=
 =?utf-8?B?cXh5bzl3YVIzejV5OXM1Z2ZPWlNmanZoZGhNa2kwZEZsTU1vUVNUejdaa3JD?=
 =?utf-8?B?ZURXNU5QUUhyS3NVazJIUHJMNFc2cjIwWXhyR3ZwSnlqc1Bnc25qUkdrKzh1?=
 =?utf-8?B?S0czOVIzK21TRnZteGNuVXQ2clF6cGhTL3NMVmlOT3gvaExZMDlvdWoxbUhH?=
 =?utf-8?B?TmRmYTkvbTVmLyt0L1Z3d09TZVdBMzdBanJwYmZRSVpOcHdPS20wUE5leEZ0?=
 =?utf-8?B?RkV5TFE3Nk1hMk94QkkwWUhLNi9jbTI4RmdscVg1dW9BSWdUNkVrQVNUYjRY?=
 =?utf-8?B?VG1Ob2RKckswTWVEcGVIOWdBeVpvSzZvTGtJcXhyd0NWNWZ0K211WnJuak1Z?=
 =?utf-8?B?aVRHSHhiUHVsVWNzY1VabEw3Z2Z2T1htdzROalV0ZzJxSExEWlR2K24yU0dQ?=
 =?utf-8?B?VW1DaGpwcENBVHZtaTVZSkszU0xZQ0RabFFVV1JLUEQ1K05zMnpyaWdMQlNl?=
 =?utf-8?B?ZGFiWkpSbjNESU82R3Fvc05VTEM4QWU3aUJTYWtYWlI4SWt1OGsrYUlNMjA4?=
 =?utf-8?B?bUV2QWYxek1wNDE5NDJaTDFSTHdHckxOQ2NSa0pJcHQ2cXhCYWZ0dmVPQWEw?=
 =?utf-8?B?TjREd2xFMng2cXJnakdhbW5lQk8vY2pXMm1zUWVYRlpLamhQYjdnUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2674d62f-6c52-468e-7bf6-08df40f4fbce
X-MS-Exchange-CrossTenant-AuthSource: IA6PR12MB893085.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 19:41:45.1882 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QSrEm7tXgisrlTGAm1Ew7hCGfUSQLBFXVKqR2AgIknOwkFqmtH9JpCIq751mWtvhtW+BSL4r+9QNGJ0yslnF+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9059
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

On 11/11/26 20:43, Dave Airlie via B4 Relay wrote:
> From: Dave Airlie <airlied@redhat.com>
>
> Split the caps view accessor into per-capability queries so DM and the
> DAL modules no longer read through struct dc_caps:
>
> - scalar getters for is_apu, ips/dmcub support, max links/streams/
>   planes/slave planes/cursor size/v_total, vtotal_limited_by_fp2,
>   i2c speed, PCON/DSC/fused-io support, SubVP processing delay and
>   MALL size
> - dc_dmub_supports_psr()/dc_dmub_supports_aux_backlight() for the
>   DMUB capability bits
> - dc_get_color_caps() copies out the color pipeline capabilities
> - dc_get_plane_caps() returns the static plane capability array
>
> The KUnit tests keep installing fake capabilities through the
> dc_test_caps() view of their own fake DC.
>
> No production code outside the dc directory reads struct dc members
> through a caps view anymore.
>
> Part of making the struct dc sub-structures opaque outside DC.
>
> Signed-off-by: Dave Airlie <airlied@redhat.com>
> ---

<snip>

>  
>  unsigned int dc_get_disable_ips(const struct dc *dc)
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc.h b/drivers/gpu/drm/amd/display/dc/inc/dc.h
> index 31baba820f6c..7a49f2ee1d77 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/dc.h
> @@ -2351,8 +2351,38 @@ struct dc_context *dc_get_ctx(const struct dc *dc);
>  /* The ASIC display engine version. */
>  enum dce_version dc_get_dce_version(const struct dc *dc);
>  
> -/* Capabilities detected at dc_create() time. Read-only. */
> -const struct dc_caps *dc_get_caps(const struct dc *dc);
> +/*
> + * Capabilities detected at dc_create() time. Read-only; prefer the
> + * purpose-built queries below over reaching into the caps structure.
> + */
> +bool dc_is_apu(const struct dc *dc);
> +bool dc_get_ips_support(const struct dc *dc);
> +bool dc_get_dmcub_support(const struct dc *dc);
> +unsigned int dc_get_max_links(const struct dc *dc);
> +unsigned int dc_get_max_streams(const struct dc *dc);
> +unsigned int dc_get_max_planes(const struct dc *dc);
> +unsigned int dc_get_max_slave_planes(const struct dc *dc);
> +unsigned int dc_get_max_cursor_size(const struct dc *dc);
> +unsigned int dc_get_max_v_total(const struct dc *dc);
> +bool dc_get_vtotal_limited_by_fp2(const struct dc *dc);
> +unsigned int dc_get_i2c_speed_in_khz(const struct dc *dc);
> +bool dc_get_dp_hdmi21_pcon_support(const struct dc *dc);
> +bool dc_get_edp_dsc_support(const struct dc *dc);
> +bool dc_get_fused_io_support(const struct dc *dc);
> +unsigned int dc_get_subvp_fw_processing_delay_us(const struct dc *dc);
> +unsigned int dc_get_mall_size_total(const struct dc *dc);
> +bool dc_dmub_supports_psr(const struct dc *dc);
> +bool dc_dmub_supports_aux_backlight(const struct dc *dc);
> +
> +/* Copy out the color pipeline capabilities. */
> +void dc_get_color_caps(const struct dc *dc, struct dc_color_caps *caps);
> +
> +/*
> + * Return the static plane capability array and its entry count.
> + * Valid until the DC is destroyed.
> + */
> +const struct dc_plane_cap *dc_get_plane_caps(const struct dc *dc,
> +		unsigned int *count);
>  

This creates some API bloat.

What about creating a new public struct header and throwing dc_caps
(or a subset of it) in there?

The intent to decouple how DC stores and reports caps is valid.

Harry
