Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45092C61DC2
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 14:36:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FF5E897F0;
	Tue, 25 Aug 2026 14:35:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=freenet.de header.i=@freenet.de header.b="NJheOVRS";
	dkim-atps=neutral
Received: from mout.freenet.de (mout.freenet.de [194.97.212.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93C2D10E1A3;
 Mon, 24 Aug 2026 20:39:15 +0000 (UTC)
Received: from [2001:748:400:1319::3] (helo=sub1.mail.fnrz.de)
 by mout3.mail.fnrz.de with esmtpa (ID viktor.jaegerskuepper@freenet.de) (port
 25) (Exim 4.98.2 #2) id 1wybRb-00000007EXf-03MU;
 Mon, 24 Aug 2026 22:38:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de; 
 s=mjaymdexmjqk;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=VYuWLxrTN9mqycqZQt+0wjL8tNpdsGRiN2+kzS0f1Ng=; b=NJheOVRS+ehToV7FuLmpmHIukY
 mG54kMou5L0i7UeB9OmDetQ85dgdJ1lApsOj9QnqhCpSeD/i21PzGDF6KeHya9nUKS+UZI8WOhgMQ
 lKYlpI0OhTvolaeOC6rQlBsurfn5TaizoFloIpT0FV2zRak4lBWhBZxYFaaET2d4YE5Jn5fLyVqQ8
 0Inl67QhUIzwOV2n4oS+olFxorI+gq3qU423ImP4MeDH7GyF37kCJmEn594JvzhMIQCT7CovcfyK3
 G8jWgt2AZh0o/KjWzmjwwrhttualpECKTPkmLDgjF97Yj9ZiJ7Qv8FIggKlnY3f7rGTajyEOp9ugT
 yL5RrZKA==;
Authentication-Results: freenet.de;
 iprev=fail smtp.remote-ip=2a02:8071:a85:f020:af10:fa7d:f150:7bea;
 auth=pass (PLAIN) smtp.auth=viktor.jaegerskuepper@freenet.de
Received: from [2a02:8071:a85:f020:af10:fa7d:f150:7bea] (port=44604
 helo=[127.0.0.1])
 by sub1.mail.fnrz.de with esmtpsa (ID viktor.jaegerskuepper@freenet.de)
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (port 465) (Exim
 4.98.2 #2) id 1wybRa-00000003XFV-3Vsm;
 Mon, 24 Aug 2026 22:38:58 +0200
Message-ID: <512414f0-ca55-435e-8ca3-7dbf48d0c114@freenet.de>
Date: Mon, 24 Aug 2026 22:38:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] drm/amd/display: advertise PIXEL_NONE as blend
 mode for DCE generations
Content-Language: en-US
To: Melissa Wen <mwen@igalia.com>, airlied@gmail.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, daniels@collabora.com,
 harry.wentland@amd.com, leandro.ribeiro@collabora.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 pekka.paalanen@collabora.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Alex Hung <alex.hung@amd.com>, Daniel Wheeler <Daniel.Wheeler@amd.com>,
 kernel-dev@igalia.com, Lyude Paul <lyude@redhat.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 =?UTF-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?= <viktor_jaegerskuepper@freenet.de>
References: <20260813143605.106104-1-mwen@igalia.com>
 <20260813143605.106104-4-mwen@igalia.com>
From: =?UTF-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?=
 <viktor_jaegerskuepper@freenet.de>
In-Reply-To: <20260813143605.106104-4-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-FN-MUUID: 17876039385B92237C2C08O
X-Scan-TS: Mon, 24 Aug 2026 22:38:58 +0200
X-Mailman-Approved-At: Tue, 25 Aug 2026 14:35:48 +0000
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

[ Adding Timur ]

On 8/13/26 16:30, Melissa Wen wrote:
> DCE can support PREMULTI and COVERAGE blend mode depending on its
> generation, however current driver implementation either doesn't expose
> more than primary and cursor plane, or doesn't program registers for any
> blend mode other than PIXEL_NONE. To fix the missing-blend-mode-prop
> warning according to current DCE plane caps, create blend mode property
> with PIXEL_NONE only for primary planes, instead of the DRM default
> PREMULTI.
> 
> Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
> Reviewed-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> 
> ---
> v3:
> - fix indentation (Alex H)
> ---
>  .../amd/display/amdgpu_dm/amdgpu_dm_plane.c    | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index ab9bbe8ca333..3b5b6943b67d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -1923,14 +1923,18 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
>  	if (res)
>  		return res;
>  
> -	/* TODO: Check which blend modes are supported in DCE-generation
> -	 * planes, i.e. DC_PLANE_TYPE_DCE_RGB/UNDERLAY and expose blend mode
> -	 * property accordingly.
> +	/* Blend mode support varies on DCE generations according to HW caps
> +	 * and number of planes per CRTC. However, as current driver
> +	 * implementation only creates one primary and one cursor plane per
> +	 * CRTC for DCE (overlay is only created if
> +	 * DC_PLANE_TYPE_DCN_UNIVERSAL), the primary plane blend mode ends up
> +	 * being always PIXEL_NONE across DCE versions.
>  	 */
> -	if ((plane->type == DRM_PLANE_TYPE_OVERLAY ||
> -	     plane->type == DRM_PLANE_TYPE_PRIMARY) &&
> -	    plane_cap && plane_cap->per_pixel_alpha &&
> -	    plane_cap->type == DC_PLANE_TYPE_DCN_UNIVERSAL) {
> +	if (plane_cap && plane_cap->type != DC_PLANE_TYPE_DCN_UNIVERSAL) {
> +		drm_plane_create_blend_mode_property(plane, BIT(DRM_MODE_BLEND_PIXEL_NONE));
> +	} else if ((plane->type == DRM_PLANE_TYPE_OVERLAY ||
> +		    plane->type == DRM_PLANE_TYPE_PRIMARY) &&
> +		   plane_cap && plane_cap->per_pixel_alpha) {
>  		unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
>  					  BIT(DRM_MODE_BLEND_PREMULTI) |
>  					  BIT(DRM_MODE_BLEND_COVERAGE);

With this patch applied to the mainline kernel, my display freezes when
Kwin is started (either by SDDM or by launching a KDE Plasma session).
GDM and Gnome work fine. The journal doesn't have much information, it's
mainly this:

kwin_wayland[8402]: Applying output configuration failed!

and after that several KDE processes with:

<kde_process>[xxxx]: There are no outputs - creating placeholder screen

Any idea how I can debug this further? Maybe ask the KDE developers?

With only the first two patches of this series applied, Kwin works as
before, but I get the warnings of course.

Viktor
