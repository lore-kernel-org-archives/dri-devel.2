Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40ACC5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 10:48:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BFF410E20E;
	Wed, 26 Aug 2026 10:48:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="AO7NMPGH";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFC6510E20E;
 Wed, 26 Aug 2026 10:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:From:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=AU40YXILyGoSjuYqr16V6R5BV3c8R6xD9HIogrb1R7I=; b=AO7NMPGHQ23ezwIvpQYHKPMUKY
 vCr40kYSNJoXVASDmT1I7eKMQDEGoZwYEwlrbA6j1E517xc2KYd6JKUu7zQtriP2DyNChCUMdgEi9
 klHaggaSbifABDHGxKZDFjUeOVsGyZ78f5G6eKkjBueFmE0nYe1yxXuCm2VBwwJKfjUt1F6EqYnYS
 gn5/TEGM9XT4UzKKGlXdN1PqJTGnzs8/u5VLcJucyt6dk21x5lgQiBoSdMbBn299sj3P3g2Au3Tm6
 GORxMqB/LyV7EviVHWgUwH+RQt9+t/WsWH+tHjO/9VvhCw0c+bnQoQ5QSeaGw5oFkh2dmxoHWAhsN
 V++V+9KA==;
Received: from 154.red-79-147-121.dynamicip.rima-tde.net ([79.147.121.154]
 helo=[192.168.1.206]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wzBAU-009V34-Om; Wed, 26 Aug 2026 12:47:42 +0200
Message-ID: <87731760-4394-42bb-893a-8d91f1dd10e9@igalia.com>
Date: Wed, 26 Aug 2026 12:47:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] drm/amd/display: advertise PIXEL_NONE and PREMULTI
 blend mode for DCE
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 daniels@collabora.com, harry.wentland@amd.com,
 leandro.ribeiro@collabora.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, pekka.paalanen@collabora.com, simona@ffwll.ch,
 siqueira@igalia.com, sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Alex Hung <alex.hung@amd.com>, Daniel Wheeler <Daniel.Wheeler@amd.com>,
 kernel-dev@igalia.com, Lyude Paul <lyude@redhat.com>,
 =?UTF-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?= <viktor_jaegerskuepper@freenet.de>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260826104143.39077-1-mwen@igalia.com>
 <20260826104143.39077-4-mwen@igalia.com>
Content-Language: en-US
In-Reply-To: <20260826104143.39077-4-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 26/08/2026 12:37, Melissa Wen wrote:
> DCE can support PREMULTI and COVERAGE blend mode depending on its
> generation, however current driver implementation either doesn't expose
> more than primary and cursor plane, or doesn't program registers for any
> blend mode other than PIXEL_NONE. To fix the missing-blend-mode-prop
> warning according to current DCE plane caps, create blend mode property
> with PIXEL_NONE and PREMULTI for primary planes. As long as the
> background is black and there is no overlay plane, PIXEL_NONE and
> PREMULTI are equivalent, and PREMULTI has been the mandatory/default
> mode for years, so keep it to avoid regressions.
>
> Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
> Tested-by: Viktor Jägersküpper <viktor_jaegerskuepper@freenet.de>
> Tested-by: Dan Wheeler <daniel.wheeler@amd.com> #v3
> Reviewed-by: Alex Hung <alex.hung@amd.com> #v3
> Reviewed-by: Leandro Ribeiro <leandro.ribeiro@collabora.com> #v2

Hi,

Only this patch changed in this v4, and it was only tested by Viktor.
As r-b tags came from previous version, can I get an ack/r-b to this one 
too?

Thanks,

Melissa

> Signed-off-by: Melissa Wen <mwen@igalia.com>
>
> ---
> v3:
> - fix indentation (Alex H)
> v4:
> - add PREMULTI to avoid regression (reported by Viktor)
> ---
>   .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 24 +++++++++++++------
>   1 file changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index ab9bbe8ca333..402f0d333150 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -1923,14 +1923,24 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
>   	if (res)
>   		return res;
>   
> -	/* TODO: Check which blend modes are supported in DCE-generation
> -	 * planes, i.e. DC_PLANE_TYPE_DCE_RGB/UNDERLAY and expose blend mode
> -	 * property accordingly.
> +	/* Blend mode support varies on DCE generations according to HW caps
> +	 * and number of planes per CRTC. However, as current driver
> +	 * implementation only creates one primary and one cursor plane per
> +	 * CRTC for DCE (overlay is only created if
> +	 * DC_PLANE_TYPE_DCN_UNIVERSAL), the primary plane blend mode is
> +	 * ignored across DCE versions. Keep PREMULTI to avoid uAPI
> +	 * regressions: it was the default/mandatory mode for many years and,
> +	 * with no overlay plane, primary composes on top of a black
> +	 * background, where PREMULTI and PIXEL_NONE are equivalent.
>   	 */
> -	if ((plane->type == DRM_PLANE_TYPE_OVERLAY ||
> -	     plane->type == DRM_PLANE_TYPE_PRIMARY) &&
> -	    plane_cap && plane_cap->per_pixel_alpha &&
> -	    plane_cap->type == DC_PLANE_TYPE_DCN_UNIVERSAL) {
> +	if (plane_cap && plane_cap->type != DC_PLANE_TYPE_DCN_UNIVERSAL) {
> +		unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
> +					  BIT(DRM_MODE_BLEND_PREMULTI);
> +
> +		drm_plane_create_blend_mode_property(plane, blend_caps);
> +	} else if ((plane->type == DRM_PLANE_TYPE_OVERLAY ||
> +		    plane->type == DRM_PLANE_TYPE_PRIMARY) &&
> +		   plane_cap && plane_cap->per_pixel_alpha) {
>   		unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
>   					  BIT(DRM_MODE_BLEND_PREMULTI) |
>   					  BIT(DRM_MODE_BLEND_COVERAGE);

