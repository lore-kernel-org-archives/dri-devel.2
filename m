Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F371DC5DF94
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 21:48:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0283310E376;
	Fri, 21 Aug 2026 21:48:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UsC414QT";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010051.outbound.protection.outlook.com [52.101.201.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6733510E376;
 Fri, 21 Aug 2026 21:48:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iov8lC3vVfzRjcP+r8nxsIpkNjE/z8xX/XjkeIUdw+jGbkONgoJJwXfADJQ9+44qTcEgooCFavq58Ysw6KhsiHxBa6OSr4y7/6kyO1IQ9c8PRVzd6dJon1ax6Q5O/JB40KENgrWKUL3SKQHQIxtGnNGEmIKoLKFdhJwIUbHz2zz/Lk0rl67fZ1oE1okIzSHw9feLqu5YH//7mDGjIo+eFZOJM7T86D6TskUafbE7w8U9WfcAWcxUNGy/YIdOpb9HfPiFfkWlUz6+Sr18zI4NLcsfAiMfh6fGSqjF6+pOhRsb58dPgwKhgNiX8umzH4hKbLJOUUmCL/pLqU8bHyySpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRbj2Up0i0DnKvg8sAAhirD3y1PXB2lc3TAfusSE9zg=;
 b=SElVwONw9QTadRapz8QbL6AbR44XfnoscN9fakXz6aPwmp+DnW1F9a4rrRjyMqwQKM9ip7uzS7TSYORJrsWBP/3iD1PdEGBYIJZ3KtDUTC0UCp0akGyvzaNPmvo/XHwz3GMaEE6pmPwplRc59gNkbu2gTaPNdPYnvVGuJtgspomwrZcacQwr3gROKFQG+ycQvYEBSDWJXhZbbrN5tJ6Ud9uRiRw0WWuzk/frbYpaDhCmXgfSby0vSq6SL6icRoTeWz3/RQb2tYkkCI5yJJT7+gxGPdbDQfhqyew5O4WWlWdMUT3sEVrL81Qt/sz1/CBLZdAcv53q+VN4aB6GDVbzhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRbj2Up0i0DnKvg8sAAhirD3y1PXB2lc3TAfusSE9zg=;
 b=UsC414QTlMw8fXFA0PFl8dov/AfkyEsjGPqhRfsY7DV5C/fGsOGFnOGd+lSsqjdfifG/0nx4i1GVDDZleympE5Mqaj2n0OTwfSg5sds/1fl3grv+io4SWgJlTHuc9w6hGYkMsp7w2gGvC9ZpCpalM3kiGftGMy08Eff4BaoxXM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by CH3PR12MB8970.namprd12.prod.outlook.com (2603:10b6:610:176::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 21:48:00 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 21:48:00 +0000
Message-ID: <b7e30ad6-87bd-42da-8853-1580a439893a@amd.com>
Date: Fri, 21 Aug 2026 15:47:57 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] drm/amd/display: fix missing blend-mode-prop
 warning for DCN
To: Melissa Wen <mwen@igalia.com>, airlied@gmail.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, daniels@collabora.com,
 harry.wentland@amd.com, leandro.ribeiro@collabora.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 pekka.paalanen@collabora.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Daniel Wheeler <Daniel.Wheeler@amd.com>, kernel-dev@igalia.com,
 Lyude Paul <lyude@redhat.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260813143605.106104-1-mwen@igalia.com>
 <20260813143605.106104-3-mwen@igalia.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260813143605.106104-3-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0158.namprd04.prod.outlook.com
 (2603:10b6:303:85::13) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|CH3PR12MB8970:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c10b718-0feb-4a15-7194-08deffcdde71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|7416014|1800799024|6133799003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: WCIj+6OjxhgVissiBcroZio0v/3s8XDa1gUlZFHUMI1uqK2QkajXOLiTHrbMuYI9zhQ4cUt/TB4oHdrm8sCsF6+2aK5D3gI/cSAOW7VTwBBxsXunE9XEcL5518b2sR/jdPgpdzYFFJvS2ihTo2oEV6U7HLznQkrbrpbzDKJNYb5EO22ac1GtJiYgkjVIG34gMp3G+onf6fq5psFJqZsI4MMXQYN30vrCm16H8bGAnVd8cSo5NEtdpY6a+7zuRsYowpBT7KO9EODpldK3/qyz4lvz9UDL+KKlvTK3I10GTyZ7rw1pauCDGlQL2djj9+59vWGu4rN1f6brDRjkzgNIcw2FXe11laqCBTAAAdEbhZY6JriJMushaX9ICKOF93rUa+JOW5fC69dYjKbjTvzU3NtZf1+0g645aqbPHYMKl5/FvBP34tagY+JOt5peRgn7J/+iTXiFzJoqx5J4o/vRqG7d0/alSwX4bLuDYUy2OCtbXriMpNnptKII9+F9Y+iYvmTY7vNOUMSp9a1sUNvDls7iJ5iszPLuXLECLZPA+bTeWqhaAK2ntkKJGPrDh48iFIHOYC7k5BXUmI6dxutdudqagYvYO+ib5DIUvpNidItw0WCFeRRs44qU8ThWN3JVCjUWDjI4sAnQYSU9btDsZZNYcQWQGKMXPxH+dlAraxcJKFuFZPRzgMndtAP14NT5otp2ttJEdaYBGxQMK1KUVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZS9ZM01DcHJ6cExLRFoyaS9KVGdFRDE2Qy96bUpjbm9IV2RtdlgvRkhGaEFN?=
 =?utf-8?B?OHprVytuK20reldwcjV4ajhDWUNoWENxamxza1NJR2dmYm8yMGw1bmNGWHRo?=
 =?utf-8?B?KzVCYXVldVg3bnNZZDJJcVhUR2xWcXdxS3NRSDBaZ2dWQW9xTThIZnRqUkc3?=
 =?utf-8?B?MXNWLzBwd3RIckhnbUpQNCtQbGhUTFZ0eGlDQkRvQ0pYQlNoNVd4SnpmaVpU?=
 =?utf-8?B?VEwwZWUxR3l3WkhETnkzaEJOVGRHaFJIeDJSeW9kc090dHg4dVFpbk5pbGVZ?=
 =?utf-8?B?MUphcDZ1SjdQRVY2a29uRzRMZUc3ZEVldFBrVGc0ckdHNlhzVGswcGEwdkwr?=
 =?utf-8?B?ZEVaT1hBRW9GVTdnbllheHBYaWF4dkN3VzRjK0dNNWp1ZUVoclR6a0FKN1h4?=
 =?utf-8?B?KzBTcTBEbk5DbEkvcnJsSTR3TUloU3JDZmhUeWl5dHg4SFhUb2FLd2FBRjk2?=
 =?utf-8?B?WGtUM1NSWWVaM3YzdmFKd2xkK2JzVlRKb1RYVkJJUXBxODRJaXFQdHJ2NHQ4?=
 =?utf-8?B?aVNTR3FtMUpoSmN6MitBemhteUpob0tIWlQ3SERYdjIwTW9CWVpPYW81djFm?=
 =?utf-8?B?UTQzMWxQazFwMUVXaXY1U296SThFcmR4Zml0THlRb2NKSmFtdjVuc2VobVAw?=
 =?utf-8?B?WjB0TVAxWndNZmFPZlk0VllwY2dnT0F6WHkwOHFkU1M0OWlsT1o3U0JSQjJU?=
 =?utf-8?B?S1NxekZVdzhycG1wTkJFZ0w3bTA0RjJhVGVlUHBBY3FqeWZ4Q0tZRTdMT3Yx?=
 =?utf-8?B?cnUxYjJxKy9sZFplUlFJNC83dGVrK2ExU0Q2bTg4ZXM5Z0xGZG1acVNKTkJJ?=
 =?utf-8?B?ZXVRd28wLzU2aWlyRzkrVU1OZjFYK3NjcWdmeEdPYkU3dEJsTVh5TE9KR2M1?=
 =?utf-8?B?eHhrUWQ2S2R1ejE3UEFabS91RnhtS0J0SHozTGZ5cjNJVU9MNlJQcjF3N1E5?=
 =?utf-8?B?VEJ3Y0wyeHU1ZUJkM3Jzb2pHMy9EUG5ydndja2RkbEpuNWM5MFBmWCtuSDZQ?=
 =?utf-8?B?aXYvSDF3Tnp4VGxCRDgxU2hJV0NEdXQvWWRIaUw1cDlqL1lSN0xucHUvcHlr?=
 =?utf-8?B?a3o3b0UrUjJRNVhEK0ZMNEYrV2pLb1hnMmRnVGdXTi9qWkZFaVcyMEFKR1hn?=
 =?utf-8?B?UlhVbGh3Wi95VnFHV1NSYlk5WGFTYkE2d0llalVNa28vVFBGYXBMV3pVMmhv?=
 =?utf-8?B?Z0t4bnJwNFBYZjVvUE90eVkwU3R1ZkZaK2hGRWY4UmJCUFRHd3I3TkVqWklQ?=
 =?utf-8?B?bjZGdmV6Z3ZzcWpneEZBZDNwY01wK0VZb2VSbHdLdTJYamZBMk1PQndHN0Fw?=
 =?utf-8?B?TjcwY2p6SGFPckRPcVlUVlVxZFNNeHZITGFlOUZPYzFMUS9pMHFRTStpT1Bi?=
 =?utf-8?B?V2NNNmJJbmozNHo4MDRHUWhnSks5aDZGM0FzTlByRU9iWjFUcjlQQjRKUzBK?=
 =?utf-8?B?RlBEeUk3alIzaDY5Si9hWCtPbUFFbzFYS3FDaTM1L0FENjZEOFkyR0pmNnQx?=
 =?utf-8?B?YWo0a05SRTlDdkhLcHNEcWdQTjBDS2lIeVZCbTZxc2MyKyt4ZWdEdy8wdmIv?=
 =?utf-8?B?RDR3QkgxYi9FWkdsK0YxTjFRbGJQRHAwdHlRWmxBY3BFdnRwNGltUWdZUmRV?=
 =?utf-8?B?cVd0dVliYW5LWFhRbUloU2dVQkdFSFVBV2YwWmxGdUJlcTlESDZDK0tCRmcv?=
 =?utf-8?B?ZXRHdmlvS1FrQ1d6MzBuSE5SQzhiY0FEL25vN1JTZ0xXb2hHdVRFNjB2dHV2?=
 =?utf-8?B?RjRzL0d2aHZhaXFUTUtwQXhndGNid0hLVEFNanQyY0Y5SVN5WDNDUnYyeE5R?=
 =?utf-8?B?Wjk5Q1RNTzkwWjh2NVlPQU9PTzdIcFNUR29Xa1hoeHF2ZHlXaVM1ZENHdnFI?=
 =?utf-8?B?R2piUHpHYUI2aFRSdWM1cS9ROUwwcmlBSjExMkpZcEtiNFVaMmJnOFN5all2?=
 =?utf-8?B?aSs3elFISGN1R2gyOFFWYnVMeExKQ0ZDTUlsU1IreWdlN3RINXA5c1dKTWdw?=
 =?utf-8?B?QlEzUm9LMWVNUXBGMks5N252VmpKKzNqZ1lCb1ZIdkJuUllKdE5WVWQ2bXJC?=
 =?utf-8?B?R1lldVozU2tSbDFHaEtIdVZPZTJualJYMm42VW5kRGdhd1JsRk9hZDIvOEEv?=
 =?utf-8?B?S2JjelVJZjR0OTdvWHUvTkQ3QVp5SjJ3a1cvOEp6cGUxQlI2SEpoSGE0UTdP?=
 =?utf-8?B?RXJtRXB6ZFA0Uk0zWVF4ZjhOcE1ESEhmR3pvelNlV3lVbFhXWnM0N1EwQkR3?=
 =?utf-8?B?bGI5U3A2MS9NTXI4MHN6MG1IV0U2SmtSWDJDWEI3dE4wcTY3aUljSDZCTUtr?=
 =?utf-8?B?K0ozbmtQNmlKN3ZyRTRBbkUxQlhSR1hjNVoxVEpxWk5LUmEwS3pwUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c10b718-0feb-4a15-7194-08deffcdde71
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 21:48:00.1008 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NVRuvSbpQiNP/4uez3GQnjiEWltCersHsmKotQTDbUBEPdl1/gLbY7Wl5WRVk0ntH1WmPiyw9fLqQiiSCPTfNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8970
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 8/13/26 08:30, Melissa Wen wrote:
> validate_blend_mode_for_alpha_formats() warns when a plane supports
> formats with alpha but doesn't expose the blend mode property. Fix this
> by adding the same overlay plane blend modes to primary plane, since
> they are all universal planes in DCN-generation. Cursor planes support
> ARGB8888 format and CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA is set by
> default (other color formats are not implemented), so only expose
> support to PREMULTI, which is the default blend mode on DRM.
> 
> Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
> Reviewed-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> 
> ---
> v3:
> - keep primary planes w/o alpha property
> - re-order if-conditions for readability
> ---
>   .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 21 ++++++++++++++++---
>   1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 1b564cfe2120..ab9bbe8ca333 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -1923,16 +1923,31 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
>   	if (res)
>   		return res;
>   
> -	if (plane->type == DRM_PLANE_TYPE_OVERLAY &&
> -	    plane_cap && plane_cap->per_pixel_alpha) {
> +	/* TODO: Check which blend modes are supported in DCE-generation
> +	 * planes, i.e. DC_PLANE_TYPE_DCE_RGB/UNDERLAY and expose blend mode
> +	 * property accordingly.
> +	 */
> +	if ((plane->type == DRM_PLANE_TYPE_OVERLAY ||
> +	     plane->type == DRM_PLANE_TYPE_PRIMARY) &&
> +	    plane_cap && plane_cap->per_pixel_alpha &&
> +	    plane_cap->type == DC_PLANE_TYPE_DCN_UNIVERSAL) {
>   		unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
>   					  BIT(DRM_MODE_BLEND_PREMULTI) |
>   					  BIT(DRM_MODE_BLEND_COVERAGE);
>   
> -		drm_plane_create_alpha_property(plane);
>   		drm_plane_create_blend_mode_property(plane, blend_caps);
> +
> +		if (plane->type == DRM_PLANE_TYPE_OVERLAY)
> +			drm_plane_create_alpha_property(plane);
>   	}
>   
> +	/* Cursor color format is set to CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA
> +	 * by default, so only advertise DRM_MODE_BLEND_PREMULTI blend mode for
> +	 * this type of plane.
> +	 */
> +	if (plane->type == DRM_PLANE_TYPE_CURSOR)
> +		drm_plane_create_blend_mode_property(plane, BIT(DRM_MODE_BLEND_PREMULTI));
> +
>   	if (plane->type == DRM_PLANE_TYPE_PRIMARY) {
>   		/*
>   		 * Allow OVERLAY planes to be used as underlays by assigning an

