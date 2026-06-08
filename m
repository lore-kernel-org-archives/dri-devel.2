Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F74CD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:01:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5775810E192;
	Mon,  8 Jun 2026 15:01:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="kc57xW//";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3A5B10E192
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 15:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1780930876;
 bh=NKP9ir8/NAmHYlfm0hZw49b1a56R0gaCRSmdEw7uKwM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=kc57xW//jOAjV5tuRDn8U8tFSaYIM/zTPEsaCHQ1C3AU+FLwTjmyr3XOaQYVykrwX
 DSkKGxc2MNi51e/UOzHxzEcVPrjHst0e4OQidxoRkkyjbGil4EZJ4GS92ouGk1VEu1
 HX7iqzNvIKrmRTfKcDmQjGuYlfxGpsfMj7Jgkuld5IeC/Lt6gOUw7Gr9guTWeRUGK9
 jq/VUR/3dLlfmG3TIwORPR2pFMWacfCXh0Q9t9So/8BkHrR0OQ2v7/Udx2v0ODQlaK
 A73AhGvOLzf+kN5ctc7qOdgACC4E9Oh1lKou7/lgOSg6D6QRFwcfX09izXpdzQH8IZ
 W6fCzm2dRf/yQ==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id D66CB17E0979;
 Mon,  8 Jun 2026 17:01:15 +0200 (CEST)
Date: Mon, 8 Jun 2026 17:01:12 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Philipp Stanner <phasta@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Alice Ryhl <aliceryhl@google.com>, Daniel
 Almeida <dwlsalmeida@gmail.com>, Gary Guo <gary@garyguo.net>, Tvrtko
 Ursulin <tvrtko.ursulin@igalia.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Danilo
 Krummrich <dakr@kernel.org>
Subject: Re: [RFC PATCH] dma-fence: Fix races of fence callbacks versus
 destructors by locking
Message-ID: <20260608170112.24fd92df@fedora-2.home>
In-Reply-To: <20260608142436.265820-2-phasta@kernel.org>
References: <20260608142436.265820-2-phasta@kernel.org>
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

On Mon,  8 Jun 2026 16:24:37 +0200
Philipp Stanner <phasta@kernel.org> wrote:

> @@ -1020,11 +1024,20 @@ EXPORT_SYMBOL(dma_fence_wait_any_timeout);
>  void dma_fence_set_deadline(struct dma_fence *fence, ktime_t deadline)
>  {
>  	const struct dma_fence_ops *ops;
> +	unsigned long flags;
>  
>  	rcu_read_lock();
>  	ops = rcu_dereference(fence->ops);
> -	if (ops && ops->set_deadline && !dma_fence_is_signaled(fence))
> +	if (!ops || !ops->set_deadline) {
> +		rcu_read_unlock();
> +		return;
> +	}
> +
> +	dma_fence_lock_irqsave(fence, flags);
> +	if (!dma_fence_is_signaled_locked(fence))
>  		ops->set_deadline(fence, deadline);

You can't take the fence lock around ->set_deadline(), otherwise you'll
deadlock here [1] or here [2].

> +
> +	dma_fence_unlock_irqrestore(fence, flags);
>  	rcu_read_unlock();
>  }


[1]https://elixir.bootlin.com/linux/v7.0.11/source/drivers/dma-buf/sw_sync.c#L182
[2]https://elixir.bootlin.com/linux/v7.0.11/source/drivers/gpu/drm/msm/msm_fence.c#L139
