Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F17FAC5CFCF
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 12:29:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C32B10F2F1;
	Thu, 13 Aug 2026 12:29:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W5dLrlZH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C81F110F2F1;
 Thu, 13 Aug 2026 12:29:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 66A7443966;
 Thu, 13 Aug 2026 12:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB281F000E9;
 Thu, 13 Aug 2026 12:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786624146;
 bh=IOOblpo1ZXGFIGAJGynFGEfp0P/z53ccBYSefFndUlA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=W5dLrlZHDBwgTxj8hnBhhyEORMTWKv1rSzpqC/OpTyqszPrJApbXit4Gi+2g6qc5W
 fBUe9rUnU760x/XWjdELWM86sJpR/HzRzAL68D31q3TYRtBWIrXgUrsC1r6ZbSpPnz
 7AaE0jhO8fP7W2Qos9KLPyYMrz/Dlx1yMhuKKosDaHTjwfGJ6BeBG/uceM6pV0rQ8P
 KUemA49Ro77DQPsIvUs3rzMHSMHdX24/c/YucxLVRhQ0v1yvjMWy9ZBUpx0B9ev6zj
 Zvn934l4wdv8jeCpJOiMJBjTytaiCR+mMvD3p19PIw5RiTulgQCLJa0EVreFIh+8uo
 nNGHXoSen46ew==
Date: Thu, 13 Aug 2026 14:29:03 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Sebastian Brzezinka <sebastian.brzezinka@intel.com>
Cc: dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com, 
 andi.shyti@linux.intel.com, krzysztof.karas@intel.com,
 krzysztof.niemiec@intel.com, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/fb-helper: guard against NULL fb_helper->funcs in
 restore path
Message-ID: <an24WzpcR-wcIdNP@zenone.zhora.eu>
References: <e1957da52fcdd1d88a285553d36e12a0362a8258.1784196681.git.sebastian.brzezinka@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1957da52fcdd1d88a285553d36e12a0362a8258.1784196681.git.sebastian.brzezinka@intel.com>
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

Ping, Maarten, can you please check this patch?

Thanks,
Andi

On Thu, Jul 16, 2026 at 12:14:33PM +0200, Sebastian Brzezinka wrote:
> When a driver's fbdev probe callback fails before assigning
> fb_helper->funcs (e.g. i915's intel_fbdev_driver_fbdev_probe() bailing
> out early on a DMA/GGTT pin failure), the fbdev client stays registered
> with fb_helper->funcs == NULL. Any later restore, such as on drm fd close
> via drm_client_dev_restore() -> drm_fbdev_client_restore(), reaches
> __drm_fb_helper_restore_fbdev_mode_unlocked() and unconditionally
> dereferences fb_helper->funcs->fb_restore, causing a NULL pointer
> dereference.
> 
> Guard the fb_restore call with a NULL check on fb_helper->funcs.
> 
> Fixes: 2ef5754c9649 ("drm/i915/display: fbdev: Move custom restore code to new callback")
> Signed-off-by: Sebastian Brzezinka <sebastian.brzezinka@intel.com>
> ---
>  drivers/gpu/drm/drm_fb_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index 7b11a582f8ec..77ae9bd5ef3d 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -146,7 +146,7 @@ __drm_fb_helper_restore_fbdev_mode_unlocked(struct drm_fb_helper *fb_helper,
>  	if (do_delayed)
>  		drm_fb_helper_hotplug_event(fb_helper);
>  
> -	if (fb_helper->funcs->fb_restore)
> +	if (fb_helper->funcs && fb_helper->funcs->fb_restore)
>  		fb_helper->funcs->fb_restore(fb_helper);
>  
>  	return ret;
> -- 
> 2.53.0
> 
