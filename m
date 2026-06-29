Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24252C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:41:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E99D10E776;
	Mon, 29 Jun 2026 08:41:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Wja8IEen";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADF2F10E04A
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782722476;
 bh=tmVYMQLt6w66eKgeMnRYtDFyZlz9JTeXyaU4pBlZwO4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Wja8IEenS+49sHofjDn58Z2mmMXgQ0UGP4Xy+VAT6HtfYogNC3vjzjVSW6w+ubSFD
 X/FOKiHUU8JM5qyFEA8ylxQANgiPQJdBGVld6lxNz652ueAMTtUhexR5HT7HbR9cu0
 LeBAAXsXcUC5tAETWzVc6ygHBav2izO7OmwlXYn4DFP2c+xhoMPqttDv2yim2uQOtk
 vezEbp6jWQOx4C8aZXuCJxxHWZDaLYT0s/vl9EPzv9AGhffYYo53fyvp4h4a3Y/2L7
 B0TKpWTdG/Xh5T5HE4pTbDdod3muymIr1S7Ae/i9QqLOKZYCksQ1RMDLWF6JA6MYvA
 a/zHXOWnc8PJQ==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id B45E217E0246;
 Mon, 29 Jun 2026 10:41:15 +0200 (CEST)
Date: Mon, 29 Jun 2026 10:41:12 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Philipp Stanner <phasta@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>, Danilo Krummrich
 <dakr@kernel.org>, Gary Guo <gary@garyguo.net>, "Paul E . McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun@kernel.org>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] dma-buf: dma-fence: Fix potential NULL pointer
 dereference
Message-ID: <20260629104112.72d58bf5@fedora-2.home>
In-Reply-To: <20260629075636.2513214-2-phasta@kernel.org>
References: <20260629075636.2513214-2-phasta@kernel.org>
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

On Mon, 29 Jun 2026 09:56:37 +0200
Philipp Stanner <phasta@kernel.org> wrote:

> The commit mentioned in the fixes tag below introduced a mechanism
> through which fence producers can fully decouple from fence consumers.
> This, desirable, mechanism is based on the fence's signaled-bit as the
> "decoupling point".
> 
> A sophisticated interaction between RCU and atomic instructions attempts
> to ensure that fence consumers can still interact with fence producers
> through the dma_fence_ops (callback pointers into the producer).
> 
> This is the desired behavior: to check for decoupling, the signaled-bit
> is first checked. If it's not yet signaled, RCU ensures that the ops
> pointer cannot yet be NULL.
> 
> Hereby, dma_fence_signal_timestamp_locked() first sets the signaled-bit,
> and then sets the ops pointer to NULL. Readers first load the ops
> pointer, and then check through the signaled-bit whether the pointer can
> legally be accessed.
> 
> These set and load operations could occur out of order on weakly ordered
> platforms. This problem can be solved very elegantly by using the ops
> pointer itself as the synchronization point. The pointer is either NULL,
> or cannot become NULL while it is being used thanks to RCU.
> 
> Replace the signaled-bit check in dma_fence_timeline_name() and
> dma_fence_driver_name().
> 
> Cc: stable@vger.kernel.org
> Fixes: f4cc3ab824d6 ("dma-buf: protected fence ops by RCU v8")
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
> Changes since v1:
>   - Use ops pointer instead of memory barriers. (Christian)
>   - Rephrase commit message.
> ---
>  drivers/dma-buf/dma-fence.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index c7ea1e75d38a..0a025dfdf131 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -1170,7 +1170,7 @@ const char __rcu *dma_fence_driver_name(struct dma_fence *fence)
>  
>  	/* RCU protection is required for safe access to returned string */
>  	ops = rcu_dereference(fence->ops);
> -	if (!dma_fence_test_signaled_flag(fence))
> +	if (ops)
>  		return (const char __rcu *)ops->get_driver_name(fence);
>  	else
>  		return (const char __rcu *)"detached-driver";
> @@ -1203,7 +1203,7 @@ const char __rcu *dma_fence_timeline_name(struct dma_fence *fence)
>  
>  	/* RCU protection is required for safe access to returned string */
>  	ops = rcu_dereference(fence->ops);
> -	if (!dma_fence_test_signaled_flag(fence))
> +	if (ops)
>  		return (const char __rcu *)ops->get_driver_name(fence);
>  	else
>  		return (const char __rcu *)"signaled-timeline";
> 
> base-commit: cdeb2ccd993ed8647adbbda2c3b103aa717fd6f7

