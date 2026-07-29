Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB363C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 08:23:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24E4210E0AE;
	Wed, 29 Jul 2026 08:23:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="n5+cS/MQ";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A38A310E0AE
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 08:23:28 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id D113819C;
 Wed, 29 Jul 2026 10:22:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1785313340;
 bh=e8PJfKrLrCG9U8WWK4qTGA5AcNgKgTa7lLIOwkt5u2Y=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=n5+cS/MQMafsM+2y43ydIVKYbUyFsEr/yd+cly5bsbqGbwDwAy7vyMsEVgbLCOP9v
 wI7IX/nPLChgDeIZqrN21GPZfzioF7L02tgKsHroEbqQ8k4zzQ1v4383QKfCEfd5NL
 zn6/sG2Ohafc4/8DEXDsx6l7BOKpniTmQQHWi0AU=
Message-ID: <d8d897b2-9108-4286-9859-54edcc2a8259@ideasonboard.com>
Date: Wed, 29 Jul 2026 11:23:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/omap: dsi: do not copy isr table
To: Andreas Kemnade <andreas@kemnade.info>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20260702-dsi-uaf-v2-1-dbb4aa0f0b8e@kemnade.info>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20260702-dsi-uaf-v2-1-dbb4aa0f0b8e@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi,

On 02/07/2026 18:27, Andreas Kemnade wrote:
> To te able to unregister stuff from isrs, the corresponding table was
> copied.  Nobody seems to unregister stuff that way, so it does not help.
> But there are stack-allocated objects passed to these isrs giving chances
> of UAF of these objects if irqs are unregistered while they are handled,
> so better do not copy that table.
> 
> Fixes: 4ae2ddddf44cd ("OMAP: DSS2: DSI: Add ISR support")
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> If this gets backported, it should be re-checked that
> no isr unregisters itself in older kernel versions`.
> ---
> Changes in v2:
> - remove variable definition (Sashiko)
> - Link to v1: https://patch.msgid.link/20260629-dsi-uaf-v1-1-a5e894f4e4d1@kemnade.info

Looks good to me, applying to drm-misc-next.

  Tomi

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
>   drivers/gpu/drm/omapdrm/dss/dsi.c | 7 +------
>   drivers/gpu/drm/omapdrm/dss/dsi.h | 2 --
>   2 files changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
> index 27fe7bca9e2c..70cfb779d6ae 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
> @@ -455,15 +455,10 @@ static irqreturn_t omap_dsi_irq_handler(int irq, void *arg)
>   		timer_delete(&dsi->te_timer);
>   #endif
>   
> -	/* make a copy and unlock, so that isrs can unregister
> -	 * themselves */
> -	memcpy(&dsi->isr_tables_copy, &dsi->isr_tables,
> -		sizeof(dsi->isr_tables));
> +	dsi_handle_isrs(&dsi->isr_tables, irqstatus, vcstatus, ciostatus);
>   
>   	spin_unlock(&dsi->irq_lock);
>   
> -	dsi_handle_isrs(&dsi->isr_tables_copy, irqstatus, vcstatus, ciostatus);
> -
>   	dsi_handle_irq_errors(dsi, irqstatus, vcstatus, ciostatus);
>   
>   	dsi_collect_irq_stats(dsi, irqstatus, vcstatus, ciostatus);
> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.h b/drivers/gpu/drm/omapdrm/dss/dsi.h
> index 601707c0ecc4..2b25247ea893 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dsi.h
> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.h
> @@ -379,8 +379,6 @@ struct dsi_data {
>   
>   	spinlock_t irq_lock;
>   	struct dsi_isr_tables isr_tables;
> -	/* space for a copy used by the interrupt handler */
> -	struct dsi_isr_tables isr_tables_copy;
>   
>   	int update_vc;
>   #ifdef DSI_PERF_MEASURE
> 
> ---
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> change-id: 20260629-dsi-uaf-71bfbf3553bf
> 
> Best regards,
> --
> Andreas Kemnade <andreas@kemnade.info>
> 

