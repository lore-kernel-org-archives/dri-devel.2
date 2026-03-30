Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B6210F3DCD
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 14:24:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FFF510E44E;
	Mon, 30 Mar 2026 14:24:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fUZesUOK";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BCAF10E1EE
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 14:24:31 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fktmX2Tb7z9vX4;
 Mon, 30 Mar 2026 16:24:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1774880668; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yRZrkJZfwCu3+U3xhoIwwpL0ahkoftQ4XU/qKrUSNFA=;
 b=fUZesUOKY9ern9a97mGszkiQ1ENAhkAH8U5WBSghIKRP5uhjngxGx9Zn3QPzd8D0d5YBYz
 aVbiYfZWFDvTLO1o95999RMOc1NMv+UtdaGhAh74JBq6/MJA+B4hTXy1LBPfjxQo9bgg/S
 zZveYF5JuYc/OYbrh/NdAbBpvTEAMp/qsQebfRvwawDngLTa+FjkPF2vnNYAMXviQbidt8
 SSVSmZ6J5KoxBABam2EhI5EA1M7flctjIxqSscTxEEzg3vRjuSYvu+cr6Nz1T7/izUlVbJ
 MA7F3Uu89jfqLdA0yyAhDHgrOfbjeY4C6vYXKCXeYp2GxyApncMLHjbNo3S/xg==
Message-ID: <ec5f5cacb36a05780485b3ee1cc1e6be36de549e.camel@mailbox.org>
Subject: Re: [PATCH] dma-fence: Move signalling tracepoint to before ops detach
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Philipp Stanner <phasta@kernel.org>, Boris
 Brezillon <boris.brezillon@collabora.com>, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org
Date: Mon, 30 Mar 2026 16:24:23 +0200
In-Reply-To: <20260330133623.17704-1-tvrtko.ursulin@igalia.com>
References: <20260330133623.17704-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 498873b17976b2fdcdb
X-MBO-RS-META: ncjtjt6wa9q5o941ouswkd3y3dkh5x6o
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
Reply-To: phasta@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

IMO the title should state that this fixes a NULL ptr deref, since that's v=
ery significant.

On Mon, 2026-03-30 at 14:36 +0100, Tvrtko Ursulin wrote:
> Move the signalling tracepoint to before fence->ops are reset otherwise
> tracepoint will dereference a null pointer.

Can't fully follow; you're talking about the fence ops detachment for
signaled fences?

>=20
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Fixes: 541c8f2468b9 ("dma-buf: detach fence ops on signal v3")
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Philipp Stanner <phasta@kernel.org>
> Cc: Boris Brezillon <boris.brezillon@collabora.com>
> Cc: linux-media@vger.kernel.org
> Cc: linaro-mm-sig@lists.linaro.org
> ---
> =C2=A0drivers/dma-buf/dma-fence.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index 1826ba73094c..1c1eaecaf1b0 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -363,6 +363,8 @@ void dma_fence_signal_timestamp_locked(struct dma_fen=
ce *fence,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &fence->flags)))
> =C2=A0		return;
> =C2=A0
> +	trace_dma_fence_signaled(fence);
> +

If it's about touching the ops, the decisive action would be the
IS_SIGNALED flag, wouldn't it? So trace_dma_fence_signaleld() should be
above the flag test?


P.

> =C2=A0	/*
> =C2=A0	 * When neither a release nor a wait operation is specified set th=
e ops
> =C2=A0	 * pointer to NULL to allow the fence structure to become independ=
ent
> @@ -377,7 +379,6 @@ void dma_fence_signal_timestamp_locked(struct dma_fen=
ce *fence,
> =C2=A0
> =C2=A0	fence->timestamp =3D timestamp;
> =C2=A0	set_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags);
> -	trace_dma_fence_signaled(fence);
> =C2=A0
> =C2=A0	list_for_each_entry_safe(cur, tmp, &cb_list, node) {
> =C2=A0		INIT_LIST_HEAD(&cur->node);

