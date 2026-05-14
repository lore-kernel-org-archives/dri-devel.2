Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE3FCD37AC
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 18:24:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0DCC10E304;
	Thu, 14 May 2026 18:24:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f8aof3im";
	dkim-atps=neutral
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com
 [74.125.224.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAC5810E304
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 18:24:07 +0000 (UTC)
Received: by mail-yx1-f46.google.com with SMTP id
 956f58d0204a3-65dd9b25829so4797990d50.3
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 11:24:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778783047; cv=none;
 d=google.com; s=arc-20240605;
 b=gQrR+7FGfxfAzBdcRGXYk5DO8CTj7YcuzbefGh455jihaiD65ftFxRgO9JR1Dg6pxu
 SRVXFt1zabtxftwi5Fgb6wBgmmpuWaxaKXV0k6pFVHpEdtTzZio5nIVyzoQ6eyVHxVz8
 Bn5EGY5fFwIRpv0CBoluGB7BuScu5VLRuo2HetRyETzF5PDrXoykgv6RzMcn7YCug/wK
 0nfxx+ShHWWLANeuPiIx0jr6iU7eea8yJl6zLSf24M4MKZZWTsKrVEcX7QGzcJVHApBo
 sQRilemG0kkqi4hBvgBtQIxyIWkuqG1IORRCETRaUXvYc0dLjqKJ5BM/s0iDG/R0wHyg
 49rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PBR7fsLisJgUG1XY+0ZPkiM5XuKRe9INIYxO9y9PY40=;
 fh=aOa45C8prV/Qgx3/4IphzjvDPnwHLq65WMTKNzJY/2k=;
 b=DK+FImsSqn/DJgKSc1GI/FHjPbUscF7e7z5J7FFfvv82q1APdVkjgkskq92HFmdSdu
 s7UTTB++GP51pWWbYlrkmNrYNQ+rexutNO3qtuj7bKUSHq6YWphJx+aZhU0XYdArm2uG
 ZKeUPjRT34zy4d83WwWIaR1Mr5FDJlymHNQf0VZH+Hb5PZU5glCgJlGd15JPeVlofyCE
 C8CjoJbzS/0J1WLoFj0GQ3Nsagyrtj3+7XZikkQz0UM6r3dKUq/sYz1MF3qLU2TzqLyw
 pBHmClfmkiQXH/kfHTZR1UNwXHcYzIF1Kgf5jC4uLhEYrNBLRfHRb8FncRxNeXj2UDq0
 /hYQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778783047; x=1779387847; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PBR7fsLisJgUG1XY+0ZPkiM5XuKRe9INIYxO9y9PY40=;
 b=f8aof3imdiWuMDOR9FUudOiv14TSThhSUD5T4+kWtnthFUIwVlsOpCGOizEQRnIpmi
 HjRM8UHGLZXXpfPJ9/6uw4txuCSVOMBdOk8O2jUamAO6AtlI5GZTIZNJQA1wecmJ3dzz
 uzBKbnAlJmh6spvvI1C2c+szaZWCAmhvZNodFp7i4Ndukov2y5lKkGjbN+l0Srp4lReR
 CjQHTx6lc9bvF+rNJYTT1isjfxhutpxjzXAVw8ShKfoyuuje5r/v+bkl5UACFxx4kBCK
 oYhR8Kp9rn3otlhc2lh3Ep7fzjv5PnEReaRaeCjC+2WpW3zhLEpuBGzM8UOijk/9yGwU
 bCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778783047; x=1779387847;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PBR7fsLisJgUG1XY+0ZPkiM5XuKRe9INIYxO9y9PY40=;
 b=GeNGgIugHazHHuXFd+sx7J0FJVsK19wO5n+9/gtl66iyDVmKIoOOp05If7id86N/eC
 0pSnQN/4bwODoDM1sFMSxrWR37jFI6Z9lgKFqbc8+QSNjnCIfCmBenWgWFsIldPj8O6h
 5VQmSolfcsZ2x4R0Af6S5yIiM542yEBU4aupyXgFaiP4fS702nZWL3Bxo9o9DxD+oNwO
 Hlbtp9eEI+SSQH46THvYyToWnuOqXElID7mENoTZrq6HvdTnIgDiI8z7niJ2DPXV4m8m
 B8hRm3U6sOvIf5xY+k0GRpXG+tOeHTXfJLZ8qPvNgY8mfrDBbRn+WlhkCQSaL9PZPSt8
 rr1g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/dwDA4xNkohGe2ipnpibedmP6nNVprQkNlw40LdESiI0YWbhYcNiR0y/xrgXget42KPISu5ToA2X8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyypngFJEgbqbY0ERTYhp5K5PpNTFmx63J9ikWeLKHV83BBiAXx
 8edrqx71OnO1Foio2/V0AlASU8e6PK4agezGywwHWr2Mwltq6c2BuhkvTW17tG6uZJdQHYgzD9A
 HgEGqolWm7/FMxQpJzGcJQSjGAEGwm3w=
X-Gm-Gg: Acq92OEVQFO6VZFs+AqcdZjNduU/EYWBOF4Mqwee43cCTTO8RJaUUvxIu41t+eR3SR4
 82h3PTfIYHKfvehZIGmroH2H5pGO1aBAgnnsDjXttRufvQoEAeAMs+ZoleWEJdwQACJUDQTwb0F
 prgN++ki4ViIKLavn+9EF6gkK8G04s6YC+A74M9FnToLuOGC0dVVqKEGlmGVm0d+ukEKxy0XsNw
 Cm27dJRHYQWaiTubFtfqbqMS4RQUn05yPCSVgoimIJ/uwTul8WHFa8Rsc317PBkFMaU9YSKdhaV
 IoE5c2tbkSxIvbEKgBOeEuzNipl8QmIHfswo15+mqpz+ZDHOTRvovg/8FJPVgKPugXiLt0zHSdV
 JjmyOdsZQ
X-Received: by 2002:a05:690c:112:b0:7bd:7e01:8d89 with SMTP id
 00721157ae682-7c95b824705mr4431567b3.24.1778783046617; Thu, 14 May 2026
 11:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260513-panthor-guard-refactor-v1-0-f2d8c15a97ce@collabora.com>
 <20260513-panthor-guard-refactor-v1-2-f2d8c15a97ce@collabora.com>
In-Reply-To: <20260513-panthor-guard-refactor-v1-2-f2d8c15a97ce@collabora.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Thu, 14 May 2026 11:23:55 -0700
X-Gm-Features: AVHnY4IvIwW933CTc4ZbukSnI54Tqb3-T6psAY7x90fXnGSxacMBnoW5RGKAorw
Message-ID: <CAPaKu7QmB8s0J60O2Bpqn9P9Xi0mKH_8Xog_843AHa8wfEBNjA@mail.gmail.com>
Subject: Re: [PATCH 2/6] dma-resv: Define guards for context-less dma_resv
 locks
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Wed, May 13, 2026 at 10:09=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> When used without a context, dma_resv are no different from regular
> locks. Define guards so we can use the guard-syntactic sugars for
> explicit/implicit scoped locks.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> ---
>  include/linux/dma-resv.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/linux/dma-resv.h b/include/linux/dma-resv.h
> index c5ab6fd9ebe8..e559b1811ca3 100644
> --- a/include/linux/dma-resv.h
> +++ b/include/linux/dma-resv.h
> @@ -40,6 +40,7 @@
>  #define _LINUX_RESERVATION_H
>
>  #include <linux/ww_mutex.h>
> +#include <linux/cleanup.h>
>  #include <linux/dma-fence.h>
>  #include <linux/slab.h>
>  #include <linux/seqlock.h>
> @@ -484,4 +485,8 @@ void dma_resv_set_deadline(struct dma_resv *obj, enum=
 dma_resv_usage usage,
>  bool dma_resv_test_signaled(struct dma_resv *obj, enum dma_resv_usage us=
age);
>  void dma_resv_describe(struct dma_resv *obj, struct seq_file *seq);
>
> +DEFINE_GUARD(dma_resv, struct dma_resv *, dma_resv_lock(_T, NULL), dma_r=
esv_unlock(_T));
> +DEFINE_GUARD_COND(dma_resv, _intr, dma_resv_lock_interruptible(_T, NULL)=
, !_RET);
> +DEFINE_GUARD_COND(dma_resv, _try, dma_resv_trylock(_T));
> +
>  #endif /* _LINUX_RESERVATION_H */
>
> --
> 2.54.0
>
