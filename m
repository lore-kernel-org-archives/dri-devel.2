Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F8BF30283
	for <dri-devel@archiver.kernel.org>; Sun, 15 Mar 2026 23:28:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B7AB10E12A;
	Sun, 15 Mar 2026 23:28:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=lechnology.com header.i=@lechnology.com header.b="D4WIPEnD";
	dkim-atps=neutral
Received: from galaxy.gendns.com (galaxy.gendns.com [66.235.175.158])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE3B810E12A
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Mar 2026 23:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pcM5v8qgScAXXcksEZyHroBWaxVivVkemYhu89WOQPw=; b=D4WIPEnDd6dmcp/J+lArcix1wY
 OqIuYGG401lcoHsDcXYc8z3HdzKvjIi1rVrkzLLqBJXwoVYB5vilCXDWH9KTKlALBYRkCgEVXdQ8p
 4jdmvXAiJ6n2dW/O0LVh0CXJFLo6rLu1wQgTg7ABId7JjFAXSGN0Oh/mRKiNvghVidH2JP0b/ybQg
 3+2vKaLgp3pGkfJ3F+ajno/ibo3kOOhEAnLvkdPlDa7i0LtwI5V+Mpt64ZGJ31zyHkzw3jwiWj2Yp
 hQuIZ7ygsxhrpLW8xL86Cuvfi8X22PV549t9tpfHLgW0GI3xnwf5z/wrVg+wDl8o4nQsinBpsDPKH
 NgU8woSw==;
Received: from ip98-183-112-25.ok.ok.cox.net ([98.183.112.25]:43072
 helo=[192.168.1.142])
 by galaxy.gendns.com with essmtpa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.99.1) (envelope-from <david@lechnology.com>)
 id 1w1usc-00000006gnY-1jpH; Sun, 15 Mar 2026 19:28:17 -0400
Message-ID: <7c5fcdca-eb77-4a7c-82e2-92bd46ddd275@lechnology.com>
Date: Sun, 15 Mar 2026 18:28:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/16] drm/mipi-dbi: Provide callbacks for atomic
 interfaces
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 lanzano.alex@gmail.com, kamlesh.gurudasani@gmail.com,
 architanant5@gmail.com, wens@kernel.org, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, simona@ffwll.ch, airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org
References: <20260311101438.365997-1-tzimmermann@suse.de>
 <20260311101438.365997-4-tzimmermann@suse.de>
Content-Language: en-US
From: David Lechner <david@lechnology.com>
Autocrypt: addr=david@lechnology.com; keydata=
 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
In-Reply-To: <20260311101438.365997-4-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - galaxy.gendns.com
X-AntiAbuse: Original Domain - lists.freedesktop.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: galaxy.gendns.com: authenticated_id:
 davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: galaxy.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

On 3/11/26 5:10 AM, Thomas Zimmermann wrote:
> Refactor the existing simple-display callbacks such that they invoke
> helpers compatible with regular atomic modesetting. Allows for adding
> mipi-dbi drives that do not require simple-display helpers. Provide
> initializer macro for elements of the regular modesetting pipeline.
> 
> As the new helpers are DRM functions, add the drm_ prefix. Mipi-dbi
> interfaces currently lack this.
> 


No documentation comment for this one?

> +int drm_mipi_dbi_plane_helper_atomic_check(struct drm_plane *plane,
> +					   struct drm_atomic_state *state)
> +{
> +	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
> +	struct drm_crtc_state *new_crtc_state;

Should this be intialized to NULL?

> +	int ret;
> +
> +	if (new_plane_state->crtc)
> +		new_crtc_state = drm_atomic_get_new_crtc_state(state, new_plane_state->crtc);
> +
> +	ret = drm_atomic_helper_check_plane_state(new_plane_state, new_crtc_state,

This is passing possibily unintialized new_crtc_state to
drm_atomic_helper_check_plane_state().

> +						  DRM_PLANE_NO_SCALING,
> +						  DRM_PLANE_NO_SCALING,
> +						  false, false);
> +	if (ret)
> +		return ret;
> +	else if (!new_plane_state->visible)
> +		return 0;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_mipi_dbi_plane_helper_atomic_check);
> +


No documentation comment for this one?

> +int drm_mipi_dbi_crtc_helper_atomic_check(struct drm_crtc *crtc, struct drm_atomic_state *state)
> +{
> +	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
> +	int ret;
> +
> +	if (!crtc_state->enable)
> +		goto out;
> +
> +	ret = drm_atomic_helper_check_crtc_primary_plane(crtc_state);
> +	if (ret)
> +		return ret;
> +
> +out:
> +	return drm_atomic_add_affected_planes(state, crtc);
> +}
> +EXPORT_SYMBOL(drm_mipi_dbi_crtc_helper_atomic_check);
> +


This is public now, so documentation comment?

> -static int mipi_dbi_connector_get_modes(struct drm_connector *connector)
> +int drm_mipi_dbi_connector_helper_get_modes(struct drm_connector *connector)
>  {
>  	struct mipi_dbi_dev *dbidev = drm_to_mipi_dbi_dev(connector->dev);
>  
>  	return drm_connector_helper_get_modes_fixed(connector, &dbidev->mode);
>  }
> +EXPORT_SYMBOL(drm_mipi_dbi_connector_helper_get_modes);
>  
>  static const struct drm_connector_helper_funcs mipi_dbi_connector_hfuncs = {
> -	.get_modes = mipi_dbi_connector_get_modes,
> +	DRM_MIPI_DBI_CONNECTOR_HELPER_FUNCS,
>  };
>  
>  static const struct drm_connector_funcs mipi_dbi_connector_funcs = {
> -	.reset = drm_atomic_helper_connector_reset,
> -	.fill_modes = drm_helper_probe_single_connector_modes,
> +	DRM_MIPI_DBI_CONNECTOR_FUNCS,
>  	.destroy = drm_connector_cleanup,
> -	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> -	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>  };
>  
>  static int mipi_dbi_rotate_mode(struct drm_display_mode *mode,
> @@ -540,18 +617,15 @@ static int mipi_dbi_rotate_mode(struct drm_display_mode *mode,
>  }
>  
>  static const struct drm_mode_config_helper_funcs mipi_dbi_mode_config_helper_funcs = {
> -	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
> +	DRM_MIPI_DBI_MODE_CONFIG_HELPER_FUNCS,
>  };
>  
>  static const struct drm_mode_config_funcs mipi_dbi_mode_config_funcs = {
> -	.fb_create = drm_gem_fb_create_with_dirty,
> -	.atomic_check = drm_atomic_helper_check,
> -	.atomic_commit = drm_atomic_helper_commit,
> +	DRM_MIPI_DBI_MODE_CONFIG_FUNCS,
>  };
>  
>  static const uint32_t mipi_dbi_formats[] = {
> -	DRM_FORMAT_RGB565,
> -	DRM_FORMAT_XRGB8888,
> +	DRM_MIPI_DBI_PLANE_FORMATS,
>  };

Why adding these macros? They are only used once, so it seems like it
just makes the code harder to read (one more place you have to jump to).

Maybe this is common style in drm or something?

>  
>  /**
> @@ -633,8 +707,7 @@ int mipi_dbi_dev_init_with_formats(struct mipi_dbi_dev *dbidev,
>  				   unsigned int rotation, size_t tx_buf_size)
>  {
>  	static const uint64_t modifiers[] = {
> -		DRM_FORMAT_MOD_LINEAR,
> -		DRM_FORMAT_MOD_INVALID
> +		DRM_MIPI_DBI_PLANE_FORMAT_MODIFIERS,
>  	};
>  	struct drm_device *drm = &dbidev->drm;
>  	int ret;
