Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D75AC55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 09:47:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E42A10F1EA;
	Fri, 31 Jul 2026 09:47:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="C8Zu3uTA";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 46B4810F1EA
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 09:47:02 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC22A22C8
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 02:46:57 -0700 (PDT)
Received: from [10.2.11.34] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 769493F7B4
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 02:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1785491221; bh=ccChqReEDgw5UPdvI4L+3rV6R6Lvk61q2uTBG7TteDo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=C8Zu3uTAI/G7atplumpn3vHPxshIGllFDMQcQYlLkJ4v+Rt4lvNw+cDajUi6slhmt
 JJDnrxU4swnJzUWsGRKtxLRjlMya3/9OhKPFemUPjAj9J14Z0/bmHopBAjoxxIuMXH
 JfLubH0g2Nb2Oyov3D0XriAPWKRB7sO/UawR+dB4=
Date: Fri, 31 Jul 2026 10:46:53 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 14/60] drm/hdlcd: Convert to atomic_create_state
Message-ID: <amxvDd2FNVcElJIw@e142607>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
 <20260709-drm-no-more-plane-reset-v1-14-302d986fe5f0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-14-302d986fe5f0@kernel.org>
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

On Thu, Jul 09, 2026 at 01:50:40PM +0200, Maxime Ripard wrote:

[snip]

Sorry for the delay in reviewing this, it got lost in the holiday mist of emails.

> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
> Cc: liviu.dudau@arm.com
> ---
>  drivers/gpu/drm/arm/hdlcd_crtc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
> index 8565749a3e48..e026b9834547 100644
> --- a/drivers/gpu/drm/arm/hdlcd_crtc.c
> +++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
> @@ -295,11 +295,11 @@ static const struct drm_plane_helper_funcs hdlcd_plane_helper_funcs = {
>  };
>  
>  static const struct drm_plane_funcs hdlcd_plane_funcs = {
>  	.update_plane		= drm_atomic_helper_update_plane,
>  	.disable_plane		= drm_atomic_helper_disable_plane,
> -	.reset			= drm_atomic_helper_plane_reset,
> +	.atomic_create_state = drm_atomic_helper_plane_create_state,
>  	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
>  	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
>  };
>  
>  static struct drm_plane *hdlcd_plane_init(struct drm_device *drm)
> 
> -- 
> 2.54.0
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
