Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51918606A88B
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 10:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Rq9zWNFm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D11D1124A0;
	Fri, 13 Nov 2026 10:06:04 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67CDC112481
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 10:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794564357;
 bh=P43MkHAOPRyb7oE/61ejrj/2m7wH0ZiP/q5aYWffMco=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Rq9zWNFm8PPHZVAxYcvxmC4Zv5KbP9FNqJK9dsCUYmRgN2jZQB7voEG22+pbCXctr
 jDLZ9H9CDHnPkfkVN7BISlvZCNmwFE0MUDweh/MgNnD5XXWikqRosETec1PkD+VDPa
 Bsfjn0GxfeV/2n23vs+DnV1Rqg7e6f01kqgFRa4pBSiCMeh5hnDY8moz1WJGdZAwvr
 kswNch6ZElbuCDvIzB5BDmZFmsxoBT6ALyeCBw0iVGdabKEnhb3KGfsCMGydjwE4wU
 Uvz1RzNdvXWw1q1Vghdatf2se4m7149SDcimNuULc/M6UgSUuthTBLJ5/Vprht6OSG
 4smksaLWTwYlw==
Received: from fedora1.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A8CC017E0A27;
 Fri, 13 Nov 2026 11:05:56 +0100 (CET)
Date: Fri, 13 Nov 2026 11:05:52 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Tuo Li <islituo@gmail.com>
Cc: steven.price@arm.com, liviu.dudau@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Fix NULL pointer dereference in sync
 signal cleanup
Message-ID: <20261113110552.034cec24@fedora1.home>
In-Reply-To: <20261113094456.5000-1-islituo@gmail.com>
References: <20261113094456.5000-1-islituo@gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 13 Nov 2026 17:44:56 +0800
Tuo Li <islituo@gmail.com> wrote:

> In panthor_submit_ctx_add_sync_signal(), drm_syncobj_find() may return
> NULL. The function then jumps to err_free_sig_sync, where
> panthor_sync_signal_free() unconditionally calls drm_syncobj_put() on
> the NULL pointer, causing a NULL pointer dereference.
> 
> Check sig_sync->syncobj before calling drm_syncobj_put() to avoid the
> NULL pointer dereference.

I really wish we had consistent behavior on those _put() helpers. Most
of them check for NULL before calling kref_put(), but some don't,
unfortunately...

> 
> Fixes: 4bdca1150792 ("drm/panthor: Add the driver frontend block")
> Signed-off-by: Tuo Li <islituo@gmail.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

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

