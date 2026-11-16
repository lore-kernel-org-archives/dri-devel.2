Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3D0606A32F
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 12:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=QiPGF9LM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A9F410F046;
	Mon, 16 Nov 2026 12:43:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 05A1310F050
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 12:43:30 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87E411713
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 04:43:26 -0800 (PST)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 4CA7D3F632
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 04:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794833009; bh=dg7j36cEkL6YwieU84eZURhUe2r7Iw1mLinaBzUPWbM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QiPGF9LM2BOOFe8k2GgptyM6YyXH7BndLCrdwmP8Mb7s9dz3Xtr//+85WyZWelYJP
 UMQWa8pKlob+rVM5ATQewnOlD9y9Sj4E5cBPph1ufIs4thHrgLAKXH8ys58btLia3V
 E4SXsJm3pGsRAZM+RllOj/dt/qe7fBWjNtrQIgok=
Date: Mon, 16 Nov 2026 12:43:19 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Tuo Li <islituo@gmail.com>
Cc: boris.brezillon@collabora.com, steven.price@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Fix NULL pointer dereference in sync signal
 cleanup
Message-ID: <avr6Z-LoyfKvDH0U@e142607>
References: <20261113094456.5000-1-islituo@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261113094456.5000-1-islituo@gmail.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13, 2026 at 05:44:56PM +0800, Tuo Li wrote:
> In panthor_submit_ctx_add_sync_signal(), drm_syncobj_find() may return
> NULL. The function then jumps to err_free_sig_sync, where
> panthor_sync_signal_free() unconditionally calls drm_syncobj_put() on
> the NULL pointer, causing a NULL pointer dereference.
> 
> Check sig_sync->syncobj before calling drm_syncobj_put() to avoid the
> NULL pointer dereference.
> 
> Fixes: 4bdca1150792 ("drm/panthor: Add the driver frontend block")
> Signed-off-by: Tuo Li <islituo@gmail.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_drv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index dc8d0191aef4..8d73956530a8 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -364,7 +364,9 @@ panthor_sync_signal_free(struct panthor_sync_signal *sig_sync)
>  	if (!sig_sync)
>  		return;
>  
> -	drm_syncobj_put(sig_sync->syncobj);
> +	if (sig_sync->syncobj)
> +		drm_syncobj_put(sig_sync->syncobj);
> +
>  	dma_fence_chain_free(sig_sync->chain);
>  	dma_fence_put(sig_sync->fence);
>  	kfree(sig_sync);
> -- 
> 2.43.0
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
