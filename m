Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B3B10A1E62
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 10:35:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAEE810E1F2;
	Thu, 26 Mar 2026 10:35:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="l4hAFNSf";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57D7010E220;
 Thu, 26 Mar 2026 10:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1774521306;
 bh=48PPiZK0H+dGBKkYs4yREpgo3KxkqWw/SNIYavvOeSc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=l4hAFNSfoAhNPDRkMGBRyvaTclouGju3MiUvSzkCIC+RZ6vFqjNwL472zSiOTwiH7
 5Kue1uAmY1n1wrVhH+fAlZTOtXPBzGaZ/yvsw7WbOIAKH0S9i2g779mIvy7+KHKeK7
 8fabpINTEVcCghdiS/fYJbuXTbigs4gzHeVfZ7rytXpPhuMOIfYffRufNtu8FHF+sV
 oXR0dpp/OkAnQ6Wu+NRcoJ/EZHHteHUs/K6EMifMY5HMQchSgHx7u/yRi/75eXPPjA
 1kHYsX4dMyvK4g1Y5g7xYXKBtPXJlMCoUiPgr8gEXb8IJvvMmN69X57pkHF0Ri/JBa
 4wyCw4Jb+mfJg==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 32C5E17E47E6;
 Thu, 26 Mar 2026 11:35:06 +0100 (CET)
Date: Thu, 26 Mar 2026 11:35:01 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang
 <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, Marijn Suijten
 <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] drm/msm/shrinker: Fix can_block() logic
Message-ID: <20260326113501.0e88741b@fedora>
In-Reply-To: <20260325184106.1259528-1-robin.clark@oss.qualcomm.com>
References: <20260325184106.1259528-1-robin.clark@oss.qualcomm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 25 Mar 2026 11:41:05 -0700
Rob Clark <robin.clark@oss.qualcomm.com> wrote:

> The intention here was to allow blocking if DIRECT_RECLAIM or if called
> from kswapd and KSWAPD_RECLAIM is set.
> 
> Reported by Claude code review: https://lore.gitlab.freedesktop.org/drm-ai-reviews/review-patch9-20260309151119.290217-10-boris.brezillon@collabora.com/ on a panthor patch which had copied similar logic.
> 
> Reported-by: Boris Brezillon <boris.brezillon@collabora.com>
> Fixes: 7860d720a84c ("drm/msm: Fix build break with recent mm tree")
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/msm/msm_gem_shrinker.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c b/drivers/gpu/drm/msm/msm_gem_shrinker.c
> index 1039e3c0a47b..31fa51a44f86 100644
> --- a/drivers/gpu/drm/msm/msm_gem_shrinker.c
> +++ b/drivers/gpu/drm/msm/msm_gem_shrinker.c
> @@ -26,9 +26,8 @@ static bool can_swap(void)
>  
>  static bool can_block(struct shrink_control *sc)
>  {
> -	if (!(sc->gfp_mask & __GFP_DIRECT_RECLAIM))
> -		return false;
> -	return current_is_kswapd() || (sc->gfp_mask & __GFP_RECLAIM);
> +	return (sc->gfp_mask & __GFP_DIRECT_RECLAIM) ||
> +	       (current_is_kswapd() && (sc->gfp_mask & __GFP_KSWAPD_RECLAIM));
>  }
>  
>  static unsigned long

