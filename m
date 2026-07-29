Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D918C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:01:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE40F10E056;
	Wed, 29 Jul 2026 12:01:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ObQoS+MZ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEA5910E056
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 12:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785326500; x=1816862500;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=ceOXpoIpiwJFwP/F5894rbmyD4kwfBu7kgsQ3cIcRNg=;
 b=ObQoS+MZge4Tay/HNzmGQVY7KxXBJ3s5pRMjYqgVjVYVnCSIIDycAK73
 GQFiMGIOQ8bIMlvHC5kOhUN5ghWe+MzzuQPSbawDRihaxkpzlYt3rOse3
 C5P2E87hhsOYhSSnEmtG4oXusKQhBjYmBOwD/WItjCu5r/jL+T6R6gthv
 8S/EJyLvPyJDkcffVWjuwx49ox8cdL3UU/pHZlcmhtwmzQtxK9NGoMTz7
 wVESus5VJLTY771TiLYxBlvQAmdJ2MfxU8XPkz2mvZccp6njCneTVSlqr
 Q0wk/ZFbwO1lniWB+8XzuLVwJIcVrdkSAuaO5wUaYnsy9PVvJau86Ia7u A==;
X-CSE-ConnectionGUID: WhKgOm5URIOWh06Cunu8DQ==
X-CSE-MsgGUID: zDKoaBIYQi2rK+/4n5O30Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="88468552"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; d="scan'208";a="88468552"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2026 05:01:39 -0700
X-CSE-ConnectionGUID: prVlmAEuRyG0jnZKUCNGvQ==
X-CSE-MsgGUID: nGhksWSzSjWhliuLYI7pRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; d="scan'208";a="257321916"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost)
 ([10.245.244.212])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2026 05:01:36 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: oushixiong1025@163.com, Jocelyn Falempe <jfalempe@redhat.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
Subject: Re: [PATCH v2] drm/log: Fix division by zero when scale module
 parameter is 0
In-Reply-To: <20260729105840.865696-1-oushixiong1025@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260729105840.865696-1-oushixiong1025@163.com>
Date: Wed, 29 Jul 2026 15:01:34 +0300
Message-ID: <e9da715ceabaa1dea51ee8bd90aef2ca7409dd0d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Wed, 29 Jul 2026, oushixiong1025@163.com wrote:
> From: Shixiong Ou <oushixiong@kylinos.cn>
>
> The scale module parameter can be set to 0 via kernel command line or
> sysfs. When scale is 0, scaled_font_h and scaled_font_w become 0,
> causing a division by zero in the rows/columns calculation.
>
> Introduce a drm_log_scale() helper that returns scale ?: 1, and use it
> at all read sites. This avoids a race that a setter-based clamp would
> have between param_set_uint() and the subsequent check, where another
> CPU could observe scale == 0.
>
> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
> ---
> v1->v2:
>    Introduce a drm_log_scale() helper.
>
>  drivers/gpu/drm/clients/drm_log.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/clients/drm_log.c b/drivers/gpu/drm/clients/drm_log.c
> index 294b3be1a6b3..9522c1344123 100644
> --- a/drivers/gpu/drm/clients/drm_log.c
> +++ b/drivers/gpu/drm/clients/drm_log.c
> @@ -29,6 +29,11 @@ static unsigned int scale = 1;
>  module_param(scale, uint, 0444);
>  MODULE_PARM_DESC(scale, "Integer scaling factor for drm_log, default is 1");
>  
> +static inline unsigned int drm_log_scale(void)

Please don't use "inline" in .c files. The compiler will know better
what to do.

BR,
Jani.

> +{
> +	return scale ?: 1;
> +}
> +
>  /**
>   * DOC: overview
>   *
> @@ -76,13 +81,13 @@ static void drm_log_blit(struct iosys_map *dst, unsigned int dst_pitch,
>  {
>  	switch (px_width) {
>  	case 2:
> -		drm_draw_blit16(dst, dst_pitch, src, src_pitch, height, width, scale, color);
> +		drm_draw_blit16(dst, dst_pitch, src, src_pitch, height, width, drm_log_scale(), color);
>  		break;
>  	case 3:
> -		drm_draw_blit24(dst, dst_pitch, src, src_pitch, height, width, scale, color);
> +		drm_draw_blit24(dst, dst_pitch, src, src_pitch, height, width, drm_log_scale(), color);
>  		break;
>  	case 4:
> -		drm_draw_blit32(dst, dst_pitch, src, src_pitch, height, width, scale, color);
> +		drm_draw_blit32(dst, dst_pitch, src, src_pitch, height, width, drm_log_scale(), color);
>  		break;
>  	default:
>  		WARN_ONCE(1, "Can't blit with pixel width %d\n", px_width);
> @@ -216,8 +221,8 @@ static int drm_log_setup_modeset(struct drm_client_dev *client,
>  		return -ENOMEM;
>  	}
>  	mode_set->fb = scanout->buffer->fb;
> -	scanout->scaled_font_h = scanout->font->height * scale;
> -	scanout->scaled_font_w = scanout->font->width * scale;
> +	scanout->scaled_font_h = scanout->font->height * drm_log_scale();
> +	scanout->scaled_font_w = scanout->font->width * drm_log_scale();
>  	scanout->rows = height / scanout->scaled_font_h;
>  	scanout->columns = width / scanout->scaled_font_w;
>  	scanout->front_color = drm_draw_color_from_xrgb8888(0xffffff, format);

-- 
Jani Nikula, Intel
