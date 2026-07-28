Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3008CC54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 07:24:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D98610EAC1;
	Wed, 29 Jul 2026 07:24:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kemnade.info header.i=@kemnade.info header.b="L2k8LVx+";
	dkim-atps=neutral
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E57810EAC1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 07:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=In-Reply-To:References:Subject:Cc:To:From:
 Reply-To:Content-ID:Content-Description;
 bh=psW064IlC0vFDRsVkw4/kjQpCROVNjpBK1z0U0x10jc=; t=1785309836; x=1786519436; 
 b=L2k8LVx+c5O//slaBWql3VumW1nREd3qpU868/JejF9nlcEEuqF+AzwSSxtZZyARAkMhr0e3gZk
 k6JoCLuJdUZRAB77GEGEhKOYUoCKVc4YvCgrQRgIEJ48LdCPzUZNw93+28w3ABW3tVk71eA9D+aW0
 JfQRnNVD+ZMBtxtDfghVG6NdU8KwFbhlX5xYVVZrkHzksgk9/LLT9suQUIvWKJ5e+V8/MfsEPwPTJ
 LMOoEW5AcajgjYrMMdSwj8WdY0Ge6ZALjLfxDXcK32dOj6E/6FxRUgKdnYQbDbcq0miJ+n0b45hd0
 51cb4CG8t8lDN7nSZG1RyUDJQ080Sqf5gQQw==;
Date: Tue, 28 Jul 2026 20:43:21 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2] drm/omap: dsi: do not copy isr table
Message-ID: <amj4SaekGK6yfmM8@akepd>
References: <20260702-dsi-uaf-v2-1-dbb4aa0f0b8e@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702-dsi-uaf-v2-1-dbb4aa0f0b8e@kemnade.info>
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

On Thu, Jul 02, 2026 at 05:27:11PM +0200, Andreas Kemnade wrote:
> To te able to unregister stuff from isrs, the corresponding table was
> copied.  Nobody seems to unregister stuff that way, so it does not help.
> But there are stack-allocated objects passed to these isrs giving chances
> of UAF of these objects if irqs are unregistered while they are handled,
> so better do not copy that table.
> 
> Fixes: 4ae2ddddf44cd ("OMAP: DSS2: DSI: Add ISR support")
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

a friendly ping... the corresponding fix in the old fb code already was
accepted.

Regards,
Andreas

> ---
> If this gets backported, it should be re-checked that
> no isr unregisters itself in older kernel versions`.
> ---
> Changes in v2:
> - remove variable definition (Sashiko)
> - Link to v1: https://patch.msgid.link/20260629-dsi-uaf-v1-1-a5e894f4e4d1@kemnade.info
> 
> To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> To: Maxime Ripard <mripard@kernel.org>
> To: Thomas Zimmermann <tzimmermann@suse.de>
> To: David Airlie <airlied@gmail.com>
> To: Simona Vetter <simona@ffwll.ch>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/gpu/drm/omapdrm/dss/dsi.c | 7 +------
>  drivers/gpu/drm/omapdrm/dss/dsi.h | 2 --
>  2 files changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
> index 27fe7bca9e2c..70cfb779d6ae 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
> @@ -455,15 +455,10 @@ static irqreturn_t omap_dsi_irq_handler(int irq, void *arg)
>  		timer_delete(&dsi->te_timer);
>  #endif
>  
> -	/* make a copy and unlock, so that isrs can unregister
> -	 * themselves */
> -	memcpy(&dsi->isr_tables_copy, &dsi->isr_tables,
> -		sizeof(dsi->isr_tables));
> +	dsi_handle_isrs(&dsi->isr_tables, irqstatus, vcstatus, ciostatus);
>  
>  	spin_unlock(&dsi->irq_lock);
>  
> -	dsi_handle_isrs(&dsi->isr_tables_copy, irqstatus, vcstatus, ciostatus);
> -
>  	dsi_handle_irq_errors(dsi, irqstatus, vcstatus, ciostatus);
>  
>  	dsi_collect_irq_stats(dsi, irqstatus, vcstatus, ciostatus);
> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.h b/drivers/gpu/drm/omapdrm/dss/dsi.h
> index 601707c0ecc4..2b25247ea893 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dsi.h
> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.h
> @@ -379,8 +379,6 @@ struct dsi_data {
>  
>  	spinlock_t irq_lock;
>  	struct dsi_isr_tables isr_tables;
> -	/* space for a copy used by the interrupt handler */
> -	struct dsi_isr_tables isr_tables_copy;
>  
>  	int update_vc;
>  #ifdef DSI_PERF_MEASURE
> 
> ---
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> change-id: 20260629-dsi-uaf-71bfbf3553bf
> 
> Best regards,
> --  
> Andreas Kemnade <andreas@kemnade.info>
> 
> 
