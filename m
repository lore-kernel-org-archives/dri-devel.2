Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B57FF60D8
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 07:49:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A143010E175;
	Tue, 31 Mar 2026 07:49:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Lg2A+cAQ";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1B5E10E175
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 07:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1774943389;
 bh=LaeQPMcIQimdwej9sn0zSQ45Z5DVj1wYw17CvwPXfDs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Lg2A+cAQKcXa7S5/O329V33nbxIKn+z3BybTFk3IRdqxsQ6gy3eMPS/LlUs9br9a1
 CkqKWZAKCM5iN2+J6dv63qLNiG8YHNsM70PsRFLTZFmHl2SEtbDLVS0L2ujFEElxmB
 pRuhIZ3wLBJokjXFnF7JGHYcj3waCEcGWMV7VyakM4pBRLt1faCSJezv9foyasiTVV
 s2mC6kJBYx37RHozWgl5ODl+XH3qBpJ/uMc1llpgDb5c+fXvx50GLQwmXcHw4zVa2H
 JNf2+53TPnBseGhDeTBKrQzhLF0bmhUjBWE24L6GbkE4DftXvqd319Pl7bIKjZPLMb
 SrR5lszs0Puyw==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 15E4617E3B54;
 Tue, 31 Mar 2026 09:49:49 +0200 (CEST)
Date: Tue, 31 Mar 2026 09:49:44 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com, Christian
 =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Philipp Stanner
 <phasta@kernel.org>, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH] dma-fence: Move signalling tracepoint to before ops detach
Message-ID: <20260331094944.772833c0@fedora>
In-Reply-To: <20260330133623.17704-1-tvrtko.ursulin@igalia.com>
References: <20260330133623.17704-1-tvrtko.ursulin@igalia.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Mon, 30 Mar 2026 14:36:23 +0100
Tvrtko Ursulin <tvrtko.ursulin@igalia.com> wrote:

> Move the signalling tracepoint to before fence->ops are reset otherwise
> tracepoint will dereference a null pointer.

I suspect other trace points are impacted too
(trace_dma_fence_destroy() is, at the very least).

>=20
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Fixes: 541c8f2468b9 ("dma-buf: detach fence ops on signal v3")
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Philipp Stanner <phasta@kernel.org>
> Cc: Boris Brezillon <boris.brezillon@collabora.com>
> Cc: linux-media@vger.kernel.org
> Cc: linaro-mm-sig@lists.linaro.org
> ---
>  drivers/dma-buf/dma-fence.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index 1826ba73094c..1c1eaecaf1b0 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -363,6 +363,8 @@ void dma_fence_signal_timestamp_locked(struct dma_fen=
ce *fence,
>  				      &fence->flags)))
>  		return;
> =20
> +	trace_dma_fence_signaled(fence);
> +
>  	/*
>  	 * When neither a release nor a wait operation is specified set the ops
>  	 * pointer to NULL to allow the fence structure to become independent
> @@ -377,7 +379,6 @@ void dma_fence_signal_timestamp_locked(struct dma_fen=
ce *fence,
> =20
>  	fence->timestamp =3D timestamp;
>  	set_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags);
> -	trace_dma_fence_signaled(fence);
> =20
>  	list_for_each_entry_safe(cur, tmp, &cb_list, node) {
>  		INIT_LIST_HEAD(&cur->node);

