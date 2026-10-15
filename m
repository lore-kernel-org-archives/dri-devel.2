Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5EF4CC6B39
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:45:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B30310F0C8;
	Thu, 15 Oct 2026 15:45:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id CC2CF10E304
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:45:30 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6A6914BF
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:45:26 -0700 (PDT)
Received: from [10.2.11.34] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 DAD213F7B4
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792079130; bh=8O5mShGPkrQqVkgbOsRebQH+q/jK164C/a2bHn6YCO4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CFI+aWQz/uqMCaIV0jpi5vOPYqf0ZTVQxTV2hclZl0+Haov9QhV25ka/S1XNVydP5
 c7ghmGMDpy0xQ2Gp223jyrFmFgr72p9IIGcVHabBt149tL85Ei1qJTtodNKX7JhRLc
 YZvLMFIpuE7h2bW/BUd4AD2QZHlELDDJzijRbN9o=
Date: Thu, 15 Oct 2026 16:45:23 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 05/75] drm/arm: komeda: Switch to
 drm_atomic_helper_connector_create_state
Message-ID: <atD1E7BAkTVo10fr@e142607>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-5-586c9c026823@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-5-586c9c026823@kernel.org>
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

On Wed, Oct 14, 2026 at 07:26:28PM +0200, Maxime Ripard wrote:
> The arm: komeda connector implementation uses the deprecated
> drm_atomic_helper_connector_reset() as its reset hook.
> 
> Switch to drm_atomic_helper_connector_create_state() instead.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> index 4872253a2449..f394971c0edb 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> @@ -126,11 +126,11 @@ static void komeda_wb_connector_destroy(struct drm_connector *connector)
>  	drm_connector_cleanup(connector);
>  	kfree(to_kconn(to_wb_conn(connector)));
>  }
>  
>  static const struct drm_connector_funcs komeda_wb_connector_funcs = {
> -	.reset			= drm_atomic_helper_connector_reset,
> +	.atomic_create_state	= drm_atomic_helper_connector_create_state,
>  	.detect			= komeda_wb_connector_detect,
>  	.fill_modes		= komeda_wb_connector_fill_modes,
>  	.destroy		= komeda_wb_connector_destroy,
>  	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
>  	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
> 
> -- 
> 2.55.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
