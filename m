Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F865CC6B39
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:46:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8271410E181;
	Thu, 15 Oct 2026 15:45:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 074ED10E181
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:45:52 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BFD31516
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:45:48 -0700 (PDT)
Received: from [10.2.11.34] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 5EAC33F7B4
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792079151; bh=tddroFQZdKdt9Op1tskX7PdYh0ELTa7P1aXSDrGgbQk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BjiAJZ0Gtot5qt7TzGpeCZdH5IHA2nGvQU8dJfQl2morZKYJOSkj+E7JrhH6ElUlA
 eMIKe6vzEH3tltHk4elm6cmFztXqH2Sz+1VTO6vPrlaFCNQ1qqqGVhi5Zd+c2gCJJB
 Ho/MJG7eGihH4UUg4qwX7pKegTeR3gGc8AiSfGxs=
Date: Thu, 15 Oct 2026 16:45:44 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 67/75] drm/malidp: Convert to atomic_create_state
Message-ID: <atD1KLUA2LQ4wGyA@e142607>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-67-586c9c026823@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-67-586c9c026823@kernel.org>
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

On Wed, Oct 14, 2026 at 07:27:30PM +0200, Maxime Ripard wrote:
> The malidp writeback connector reset implementation creates a custom
> state subclass, but only initializes a pristine state without resetting
> any hardware. This is equivalent to what atomic_create_state expects.
> Convert to it.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> ---
>  drivers/gpu/drm/arm/malidp_mw.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
> index f8be65119e3b..edd924ba722d 100644
> --- a/drivers/gpu/drm/arm/malidp_mw.c
> +++ b/drivers/gpu/drm/arm/malidp_mw.c
> @@ -62,22 +62,22 @@ malidp_mw_connector_mode_valid(struct drm_connector *connector,
>  static const struct drm_connector_helper_funcs malidp_mw_connector_helper_funcs = {
>  	.get_modes = malidp_mw_connector_get_modes,
>  	.mode_valid = malidp_mw_connector_mode_valid,
>  };
>  
> -static void malidp_mw_connector_reset(struct drm_connector *connector)
> +static struct drm_connector_state *
> +malidp_mw_connector_create_state(struct drm_connector *connector)
>  {
> -	struct malidp_mw_connector_state *mw_state = kzalloc_obj(*mw_state);
> +	struct malidp_mw_connector_state *mw_state;
>  
> -	if (connector->state)
> -		__drm_atomic_helper_connector_destroy_state(connector->state);
> +	mw_state = kzalloc_obj(*mw_state);
> +	if (!mw_state)
> +		return ERR_PTR(-ENOMEM);
>  
> -	kfree(connector->state);
> -	connector->state = NULL;
> +	__drm_atomic_helper_connector_state_init(&mw_state->base, connector);
>  
> -	if (mw_state)
> -		__drm_atomic_helper_connector_reset(connector, &mw_state->base);
> +	return &mw_state->base;
>  }
>  
>  static enum drm_connector_status
>  malidp_mw_connector_detect(struct drm_connector *connector, bool force)
>  {
> @@ -109,11 +109,11 @@ malidp_mw_connector_duplicate_state(struct drm_connector *connector)
>  
>  	return &mw_state->base;
>  }
>  
>  static const struct drm_connector_funcs malidp_mw_connector_funcs = {
> -	.reset = malidp_mw_connector_reset,
> +	.atomic_create_state = malidp_mw_connector_create_state,
>  	.detect = malidp_mw_connector_detect,
>  	.fill_modes = drm_helper_probe_single_connector_modes,
>  	.destroy = malidp_mw_connector_destroy,
>  	.atomic_duplicate_state = malidp_mw_connector_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
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
