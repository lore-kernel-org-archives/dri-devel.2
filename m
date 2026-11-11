Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9351A60A260D
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fWHvoXGA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAC0A10F91D;
	Wed, 11 Nov 2026 08:06:00 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B9E010F91D
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:05:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7C5754099F;
 Wed, 11 Nov 2026 08:05:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729C01F00A05;
 Wed, 11 Nov 2026 08:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794384354;
 bh=jwObVC/mvexbREQ1uAgKavk9FT5aQB2RrfBQjYiY2kU=;
 h=In-Reply-To:References:Subject:From:To:Cc:Date;
 b=fWHvoXGA9uxV8RUS6OuY+mCGi/lkhCTBTYEeU3ghs2/agxnPTiJTyj3Q/PVMYhczJ
 kIJWZsrMTFwDZ9VKRRSQjMuGydqU1VMK84FdHjhYHTU/TF0ZHLfdK6EcHdnCFobzMQ
 CMa0ZEiNAFqaRUspbSM6LEZneI3sNBxc1e7yqmLaLccdViUokEaMLbk3J0mRyl1a9O
 t+inMJn9rrHh3TDyHnICLjiCSGvdQqI7YpC9gIwFddULTBcDxGm1AUrtm8kjWvjca1
 ENL5pm8up/Vbw4idTI3CrHWyMalEqq8BFvtSOJN540EIlH63GpkKAdP6/7A7+LshgH
 14USs/FZnm4UQ==
Content-Type: multipart/mixed; boundary="===============8814559659898024532=="
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <5f4ff580aef8f7a6be0c0f1c320916596da0e7d72e15424c72bf7142fc7654cb@mail.kernel.org>
In-Reply-To: <20261110125106.2935677-1-k.chen@smail.nju.edu.cn>
References: <20261110125106.2935677-1-k.chen@smail.nju.edu.cn>
Subject: Re: [PATCH] bpf: make dmabuf iterator stay drained after NULL
From: bot+bpf-ci@kernel.org
To: k.chen@smail.nju.edu.cn, yonghong.song@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, sumit.semwal@linaro.org,
 christian.koenig@amd.com, phasta@kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, yonghong.song@linux.dev, mason@kernel.org,
 ihor.solodrai@linux.dev
Date: Wed, 11 Nov 2026 08:05:53 +0000 (UTC)
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
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8814559659898024532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: make dmabuf iterator stay drained after NULL

TL;DR: Nit only: the new comment in bpf_iter_dmabuf_next() describes the
pre-patch restart behavior, not the code it sits on; the review suggests
rewording it to explain why the sentinel exists.

> diff --git a/kernel/bpf/dmabuf_iter.c b/kernel/bpf/dmabuf_iter.c
> --- a/kernel/bpf/dmabuf_iter.c
> +++ b/kernel/bpf/dmabuf_iter.c

[ ... ]

> @@ -173,11 +180,25 @@ __bpf_kfunc struct dma_buf *bpf_iter_dmabuf_next(struct bpf_iter_dmabuf *it)
>  {
>  	struct bpf_iter_dmabuf_kern *kit = (void *)it;
>  
> +	/*
> +	 * The verifier assumes that an iterator which returned NULL keeps
> +	 * returning NULL (see process_iter_next_call()).  Without this check
> +	 * the NULL left by the last dma_buf_iter_next() would be interpreted
> +	 * as "not started" and the iteration would restart from the list head.
> +	 */
> +	if (kit->dmabuf == DMABUF_ITER_DONE)
> +		return NULL;
> +
>  	if (kit->dmabuf)
>  		kit->dmabuf = dma_buf_iter_next(kit->dmabuf);
>  	else
>  		kit->dmabuf = dma_buf_iter_begin();
>  
> +	if (!kit->dmabuf) {
> +		kit->dmabuf = DMABUF_ITER_DONE;
> +		return NULL;
> +	}
> +

This isn't a bug, but is the second sentence of the comment above
describing the pre-patch behavior rather than the code it sits on?

With this patch no NULL is ever left in kit->dmabuf, since the block
above replaces it with DMABUF_ITER_DONE:

    if (!kit->dmabuf) {
            kit->dmabuf = DMABUF_ITER_DONE;
            return NULL;
    }

If only the "if (kit->dmabuf == DMABUF_ITER_DONE)" check were removed, the
iteration would not restart from the list head.  The sentinel would take
the "if (kit->dmabuf)" branch and be passed to
dma_buf_iter_next((struct dma_buf *)1).

The restart described is the bug being fixed, which is already in the
changelog.  Could the comment instead say why the sentinel exists, for
example: once begin()/next() returns NULL, park the iterator at
DMABUF_ITER_DONE so it is not mistaken for a fresh (NULL) iterator, and
keep returning NULL as process_iter_next_call() requires?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42982427559
--===============8814559659898024532==--
