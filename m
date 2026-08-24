Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788AEC5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 10:48:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D05B710E0BA;
	Mon, 24 Aug 2026 10:48:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="XqAbGTZc";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id D9E7710E0BA
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 10:48:08 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58703176C
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 03:48:04 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 E7C8F3F85F
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 03:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1787568488; bh=ERmw4UMgzsxGFVJL/g1MYgt1DC2p52531zrkXeC94gI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XqAbGTZcSJNjYgAvjZfVy9MMlzWLm9+8TYC+A4iQ/XKJue3s0tW40AOvpeIb7fmMR
 4EVSrULDINrNV8tvfW5V2wNbvldSGn/FwPEM8iMR30zVsKeeZF5SiUgbb7kmRTSc3b
 ZRMs+KoAhZ01slTYxh5i5uTwnEvjxPR281WmcfL4=
Date: Mon, 24 Aug 2026 11:48:01 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 03/70] drm/arm: hdlcd: Switch to
 drm_atomic_helper_crtc_create_state
Message-ID: <aowhYXk6jS_Q4Xd0@e142607>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
 <20260821-drm-no-more-crtc-reset-v1-3-fb793475c05a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-3-fb793475c05a@kernel.org>
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

On Fri, Aug 21, 2026 at 04:38:39PM +0200, Maxime Ripard wrote:
> The hdlcd crtc implementation uses the deprecated
> drm_atomic_helper_crtc_reset() as its reset hook.
> 
> Switch to drm_atomic_helper_crtc_create_state() instead.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> ---
>  drivers/gpu/drm/arm/hdlcd_crtc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
> index 8565749a3e48..e394464efbb4 100644
> --- a/drivers/gpu/drm/arm/hdlcd_crtc.c
> +++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
> @@ -65,11 +65,11 @@ static void hdlcd_crtc_disable_vblank(struct drm_crtc *crtc)
>  
>  static const struct drm_crtc_funcs hdlcd_crtc_funcs = {
>  	.destroy = hdlcd_crtc_cleanup,
>  	.set_config = drm_atomic_helper_set_config,
>  	.page_flip = drm_atomic_helper_page_flip,
> -	.reset = drm_atomic_helper_crtc_reset,
> +	.atomic_create_state = drm_atomic_helper_crtc_create_state,
>  	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
>  	.enable_vblank = hdlcd_crtc_enable_vblank,
>  	.disable_vblank = hdlcd_crtc_disable_vblank,
>  };
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
