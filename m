Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70CF606A321
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 01:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KlzAoJXq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46EE910E8BB;
	Sat, 31 Oct 2026 01:45:01 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 269A110E8BB
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 01:44:55 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a20d7a8984so10025e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 18:44:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793411093; cv=none;
 d=google.com; s=arc-20260327;
 b=U2IyeiWAxko5wbAZkgl9Q33yAMh0APJi4FA4u/XmXeuTjydXvxU+8whqBHDXRrJiqD
 LZnslLuN4WZ2CNvLZtRGELS8BFplcReFK7BVWmO1Y+zESzNzfTtQTvFymTQn+taeN+Qj
 feOyYM82x0soozFZ/LjPA2jH/EcS138cPGCips4zesU9J0FrEaIfYaiXRj8oqv3+3jph
 6dzBzB8yQS6sNgkCScoDtiOam02+caUtPM58OETECn1Z9pDGcXFqTFAI7Ejoz0jDT53y
 i1f728gq2Tc9oBc2QYcqpYKadt7qttJXFiuTI7KzU0JnQnLpFRHV4gxGbTcOUleQ23kN
 nRpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6DRdlfcgy+vOtjFUomjk9wUyOs/aRXJNwlIvfhUtZTw=;
 fh=DyxpMPiv9ztym3412LPH0nCC1UI3PTUl6Sypi4KtzqU=;
 b=VnmykCgJVjwY8cGUcNNEo0Az1cwuOLgIvnqLuuG8JJy1xURvIQYkUz3X8CbhnFBZ7y
 toqgCwQEMxaLy1EuJSJqi8I0wIXjfyqbYcLzr6UN3PwSiwCfvHXc211oDMp1yQLktzAJ
 JPqpAY5i9/BhOxJGrFuaLt1lTfvXgXfKTzv+4YZJGiIaPrw0AXnf3f1JBfaXiOE8Mws3
 bi+7CYgKxl/YamfzMtWGY4q9lbgwmx+tNDbXVX1UQxa93baZAoYvWfitlyaIqsimhJwg
 L7o/4AmI+Y0EvYJhaku5W0gujmUNuxWBKPgllOLQAHymlt+L0oWvNpARbFnvsHY0cuN6
 GjrQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793411093; x=1794015893;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6DRdlfcgy+vOtjFUomjk9wUyOs/aRXJNwlIvfhUtZTw=;
 b=KlzAoJXqjb4iXOdQZDItzULodq6QHxWMYUy6AkjqXQ4G1DJnGNBWI2PSXFPB7mESKa
 nEjns1MrAEeWR0o6gLQ8MIDyOFglpYPj462yPhuvmW2jj/cp1MxCl5EGTmFqeqz5KEXt
 0Y2LyiT30GkjGI2t9cXAPx1E/Uo8IfXnV3WhR+mWFqort4++RYJlD13TIw9l/DzP4q7G
 MulCQqEogiRLF08SbUe3UWx4SB8fVNDB66t3KL8iBFxdz4t55CEu5f5CqzDQ9uyaYzKr
 EFFKESY5wkaJqoPm+kG0XvvxSmwsAY2O0Rz3XZza/Zgp6m2EH3ThTCaLd6MJhNXV4Lbn
 qqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793411093; x=1794015893;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6DRdlfcgy+vOtjFUomjk9wUyOs/aRXJNwlIvfhUtZTw=;
 b=yjrc/z/vQGiTLUiwguAYzQPE9WYnYT6CGClarcB24/PUmgvB1Fa9esCLyBiVhlKrA5
 ydQe5pTWv5vK77LAzLnlnCUoq1daDCknOY3/uCPG4mYQ3QqG07Mp4A7izk2iqgkBdo/6
 KDjUe8sc0WepxgLZkYqQDb+thcAXYtXO5qC85YgriElkf8W6uNIqvmouldB5oDj8c3R8
 vyYYxKZlv3eIEcne4dHcSpKYC93hEhhvPRaAJvaZ++A4AalN4qWoVby6s0gEqJQ5rxPv
 SQFVzIG5AnUGzUSioC/rpFCCMT1LmBPSRojB8y6c+1zTUYleUDlQ2xQm+g9xmfm10xPj
 hdzA==
X-Forwarded-Encrypted: i=1;
 AKwUvBza+xB1uTZQ4VrXvEuUBbidGc+hlELxhr4INfHmOHOpDqEk6X9hxnGIxkC72Y2YPfkQmlnq+fNQdmE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKOJYG6ahWMS+gZhcXqaeAuz5MbaT3r/QRgrkLEGit0nP8TNGb6
 taZ2hsiiFhkNX6qu3Yjg7PKpjKRPxPZxNFPhRjjd2RVitCxL+vSr1BmG/xoKr8t20dttSSzqLuX
 TNLQn2cvNdogrKpZRnDh5rgW0zIVKVG4BIL+rHBZP
X-Gm-Gg: AYBFou3yu5KEtNqvg8Wo4xICUz8U8ZTjG2mZrTH4kWWZYCyQMNdRi+k/+SG38tMc4Uu
 XZX9PGK7Skug/DyNblZ8BFEbS8U1xeIIvG68TsDzPbCPzzSHoLcimP6LyV7Q36q07yrfT8DU9ek
 fAO9dTymtyRel7W2s/nH65Qm6Hs1LPMPUyzH3EV1mVy3HKAk9DodAX94GNE4tLcBLvPPtIBFMix
 fRC54D9/uKkk/N7uTqD6+Ze3i1PkEp9D1scJsEGXO46YyyWsYuS++uys0Da2P/cd9Kiof3VRuGj
 JY6+teId39mjiDtU/AJ+z6QORyxB6zpEH76eW294FMj8vO6EZYWeX3LpVUQka2B0LnNCHi/P364
 kGOAoUPzKglVr5bszLVg6iTGMfnyJjThq/OmHz/U0zl1MYA611aimMu0mB+xl/MSI0ivG
X-Received: by 2002:a05:600c:a183:b0:4a2:ba3:236e with SMTP id
 5b1f17b1804b1-4aab73beeffmr1795465e9.14.1793411093182; Fri, 30 Oct 2026
 18:44:53 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <18e3697ad6321d35.3137322e32332e3235332e313736.e98e6.0000sendgmr@google.com>
In-Reply-To: <18e3697ad6321d35.3137322e32332e3235332e313736.e98e6.0000sendgmr@google.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 30 Oct 2026 18:44:41 -0700
X-Gm-Features: AclHuK_pX8cbPFC7CZhySlOC0JMrDf_CX2tXJ-CkUmaeXv5SLhTNx2Dk4KoCGew
Message-ID: <CABdmKX0YRmr0ovk7teNQdXdLmC2LKruT59EQarpDMFcxoOFcQg@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: system_heap: Reject private mappings in
 system_heap_mmap()
To: Chris Wiseman <chriswiseman@google.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: John Stultz <jstultz@google.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Brian Starkey <Brian.Starkey@arm.com>, Philipp Stanner <phasta@kernel.org>,
 linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 1:44=E2=80=AFPM Chris Wiseman <chriswiseman@google.=
com> wrote:
>
> When commit 381295758792 ("dma-buf: system_heap: Rework system heap to
> use sgtables instead of pagelists") stopped using heap_helpers.c and
> added a custom system_heap_mmap(), the check rejecting private mappings
> was dropped.
>
> Other exporters and buffer allocators reject private or copy-on-write
> mappings in their mmap handlers: cma_heap_mmap() and mmap_udmabuf()
> check that VM_SHARED or VM_MAYSHARE is set, and drm_gem_shmem_mmap()
> and ttm_bo_mmap_obj() reject vma_is_cow_mapping(vma).
>
> However, system_heap_mmap() omits this check and calls remap_pfn_range()
> even when userspace requests MAP_PRIVATE with PROT_WRITE. As a result,
> subsequent CPU writes to a MAP_PRIVATE mapping of a system heap buffer
> fault into do_wp_page() -> wp_page_copy(), silently allocating private
> anonymous copy-on-write pages whose writes never reach the underlying
> system heap buffer pages.
>
> Reject non-shared mappings in system_heap_mmap() with -EINVAL to match
> cma_heap_mmap() and mmap_udmabuf().
>
> Fixes: 381295758792 ("dma-buf: system_heap: Rework system heap to use sgt=
ables instead of pagelists")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Wiseman <chriswiseman@google.com>

Reviewed-by: T.J. Mercier <tjmercier@google.com>

I wonder if we should have this in dma_buf_mmap_internal() though. Any
thoughts Sumit or Christian?
