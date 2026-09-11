Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C92C79FA1
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 03:40:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7567610E349;
	Fri, 11 Sep 2026 03:40:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="iRf0DHUs";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D09110E349
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 03:40:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789098005; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Ta6zu2fc0qS2ErdZgHFnBqeIjnasf4qWEsCwaIDd6Ke/QOYQbKjlpvrhgFg+P+DwCnA0A5IlGfRkaIIqoQcn7nEMU7tgsOJlv96jlQRIOJLncSWHAjP3OYwggQrZzD2rRcqH5Z0H06PPzhF8NnTtvM5rqCaMyn0LA1nB9dCo2As=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789098005;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=0hz3/O7B3VlFSRb61b+q5p5wd1rLXmu/lFixD+jG6E8=; 
 b=jyZFXjyGWwpeqHYRg6Bi49dRGFVwfahK8R48W4SH6KodWAZSsYmdMuqaCuaxvFOr7ZPev7/7pW4VEVs3FTrn+q+UGZTh/p7ZXJRNFdn3UaiWj/4vpQqReoBrv0Cehg5J+aKrexf5yee//55sXNe6P5o/OWvl1l5GHkIyN179GPg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789098005; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=0hz3/O7B3VlFSRb61b+q5p5wd1rLXmu/lFixD+jG6E8=;
 b=iRf0DHUspaXZiOyoZyE1RIlrfJESddgskOy9ceoo/kaJeMhKDt5TStXxClU0+ynx
 ShuCpQGlfY7KkAVN0wCg0d0+I0xiyEtKn44R4Nq8TlBkmoMrrxS1H2XF2mA5m62CNGQ
 ua5790ADr8CwLeiXF9cqhp8DxuvUWyt3m+SvWhIE=
Received: by mx.zohomail.com with SMTPS id 178909800478477.50082698209769;
 Thu, 10 Sep 2026 20:40:04 -0700 (PDT)
Date: Fri, 11 Sep 2026 04:40:01 +0100
From: Adrian Larumbe <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Chris Diamand <chris.diamand@arm.com>, Akash Goel <akash.goel@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 13/18] drm/panthor: Complain if the SOFT_RESET fails
Message-ID: <aqNsLgZRLw_el4h4@sobremesa>
References: <20260826-panthor-unplug-fixes-v4-0-982cc8f4234b@collabora.com>
 <20260826-panthor-unplug-fixes-v4-13-982cc8f4234b@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260826-panthor-unplug-fixes-v4-13-982cc8f4234b@collabora.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/289.74.40
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

On 26.08.2026 16:56, Boris Brezillon wrote:
> We rely on a functioning SOFT_RESET to avoid HW UAFs when the GPU was
> in a state where AS commands were no longer accepted. If we silently
> ignore RESET failures, we're just pretending to be safe while exposing
> ourselves to the very UAFs we were trying to avoid. On the other hand,
> there's basically nothing we can do if both the SOFT_RESET and the
> AS_COMMAND(UNMAPPED) fail, so do what we do best: complain loudly and
> taint the kernel with a WARN_ON().
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_hw.h | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
> index 4531c1239cb6..f13fd7b335c1 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.h
> +++ b/drivers/gpu/drm/panthor/panthor_hw.h
> @@ -41,9 +41,17 @@ int panthor_hw_init(struct panthor_device *ptdev);
>  int panthor_hw_power_status_register(void);
>  void panthor_hw_power_status_unregister(void);
>  
> -static inline int panthor_hw_soft_reset(struct panthor_device *ptdev)
> +static inline void
> +panthor_hw_soft_reset(struct panthor_device *ptdev)
>  {
> -	return ptdev->hw->ops.soft_reset(ptdev);
> +	/* We're relying on the SOFT_RESET to reset the MMU block if some AS
> +	 * were stuck for some reason. Failing to reset the MMU/L2 means we're
> +	 * exposing ourselves to HW UAFs. On the other hand, there's basically
> +	 * nothing we can do if both the SOFT_RESET and
> +	 * the AS_COMMAND(UNMAPPED) fail, so do what we do best: complain loudly
> +	 * and taint the kernel.
> +	 */
> +	drm_WARN_ON(&ptdev->base, ptdev->hw->ops.soft_reset(ptdev));

I think you forgot to include drm/drm_print.h, although Sashiko probably picked up on this.

On top of that, I wonder if failure to soft reset should be carried up the call stack and
eventually lead to an early unplug, just like you do when panthor_fw_post_reset() fails.

>  }
>  
>  static inline int panthor_hw_l2_power_on(struct panthor_device *ptdev)
> 
> -- 
> 2.55.0


Adrian Larumbe
