Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D121CD3436
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 10:33:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55AFE10E54A;
	Wed,  6 May 2026 10:33:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="dHhX2DDE";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26EFA10E1AC
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 10:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778063599;
 bh=M5o+/YaupNYZyxmeKf2QjXgCKV0qcMjr7DPzv7F8Sv0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=dHhX2DDEb+wKn+xBlaCHlq6jRa1HZj+2R0vY7hAlUA+C+Zoap/YG7alIUX6QF2JuH
 iGWo984ywb6LITJ7cafk4pbvn2DS/7wUBPMhH0nXlMzQqSjx/ELpj6PTtYAsCFnprr
 gHgGF7r77Z50yxDgoF7V15ATETV17WYz10R+IypMMoEHxmYpyVhUW9244GtR4aZMrr
 px8CHnxYwp40tbLvffOrKczuvdf6qie1oISR6ZEtvS5p0MbMQKQPIaTW3bZYPYkoSG
 N1SjfcJWB9w5YQr31HrOSqFKu4oT6y4u7ppxfzDwvm3pdxYZGHcoyntDpuvIYjP6BP
 Jn9toahZwrSNw==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 64F3617E1227;
 Wed,  6 May 2026 12:33:18 +0200 (CEST)
Date: Wed, 6 May 2026 12:33:14 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Ketil Johnsen <ketil.johnsen@arm.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Sumit
 Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard
 <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>,
 John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Daniel Almeida
 <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Florent Tomasin <florent.tomasin@arm.com>
Subject: Re: [PATCH 5/8] drm/panthor: Minor scheduler refactoring
Message-ID: <20260506123314.0f1c01cb@fedora>
In-Reply-To: <20260505140516.1372388-6-ketil.johnsen@arm.com>
References: <20260505140516.1372388-1-ketil.johnsen@arm.com>
 <20260505140516.1372388-6-ketil.johnsen@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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

On Tue,  5 May 2026 16:05:11 +0200
Ketil Johnsen <ketil.johnsen@arm.com> wrote:

> From: Florent Tomasin <florent.tomasin@arm.com>
> 
> Refactor parts of the group scheduling logic into new helper functions.
> This will simplify addition of the protected mode feature.
> 
> Remove redundant assignments of csg_slot.
> 
> Signed-off-by: Florent Tomasin <florent.tomasin@arm.com>
> Co-developed-by: Ketil Johnsen <ketil.johnsen@arm.com>
> Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>
> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 135 +++++++++++++++---------
>  1 file changed, 86 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 5ee386338005c..987072bd867c4 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -1934,6 +1934,12 @@ static void csgs_upd_ctx_init(struct panthor_csg_slots_upd_ctx *ctx)
>  	memset(ctx, 0, sizeof(*ctx));
>  }
>  
> +static void csgs_upd_ctx_ring_doorbell(struct panthor_csg_slots_upd_ctx *ctx,
> +				       u32 csg_id)
> +{
> +	ctx->update_mask |= BIT(csg_id);
> +}
> +
>  static void csgs_upd_ctx_queue_reqs(struct panthor_device *ptdev,
>  				    struct panthor_csg_slots_upd_ctx *ctx,
>  				    u32 csg_id, u32 value, u32 mask)
> @@ -1944,7 +1950,8 @@ static void csgs_upd_ctx_queue_reqs(struct panthor_device *ptdev,
>  
>  	ctx->requests[csg_id].value = (ctx->requests[csg_id].value & ~mask) | (value & mask);
>  	ctx->requests[csg_id].mask |= mask;
> -	ctx->update_mask |= BIT(csg_id);
> +
> +	csgs_upd_ctx_ring_doorbell(ctx, csg_id);
>  }
>  
>  static int csgs_upd_ctx_apply_locked(struct panthor_device *ptdev,
> @@ -1961,8 +1968,12 @@ static int csgs_upd_ctx_apply_locked(struct panthor_device *ptdev,
>  	while (update_slots) {
>  		struct panthor_fw_csg_iface *csg_iface;
>  		u32 csg_id = ffs(update_slots) - 1;
> +		u32 req_mask = ctx->requests[csg_id].mask;
>  
>  		update_slots &= ~BIT(csg_id);
> +		if (!req_mask)
> +			continue;

Looks like something that should be in patch 7, where you update the
doorbell_req register, and then call csgs_upd_ctx_ring_doorbell(),
meaning req_mask can be zero. The other option would be to teach
panthor_csg_slots_upd_ctx about CS doorbells, and let
csgs_upd_ctx_apply_locked() toggle the doorbell_req.

> +
>  		csg_iface = panthor_fw_get_csg_iface(ptdev, csg_id);
>  		panthor_fw_update_reqs(csg_iface, req,
>  				       ctx->requests[csg_id].value,
> @@ -1979,6 +1990,9 @@ static int csgs_upd_ctx_apply_locked(struct panthor_device *ptdev,
>  		int ret;
>  
>  		update_slots &= ~BIT(csg_id);
> +		if (!req_mask)
> +			continue;
> +
>  		csg_iface = panthor_fw_get_csg_iface(ptdev, csg_id);
>  
>  		ret = panthor_fw_csg_wait_acks(ptdev, csg_id, req_mask, &acked, 100);
