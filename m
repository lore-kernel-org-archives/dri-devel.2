Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3D9107637C
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 13:34:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05D6E10E47B;
	Wed,  1 Apr 2026 13:34:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OUfsQbR7";
	dkim-atps=neutral
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9259310E47B
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 13:34:55 +0000 (UTC)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-128bae6a35aso266836c88.1
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 06:34:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775050495; cv=none;
 d=google.com; s=arc-20240605;
 b=hPu84wylWKI2raYNJcUyqzCEgfU3Z3qKoYDx4J2cMKmkLlYf6OyBFpxUgdFXyyWWok
 YwhbX3C5ioqEL0w+OA2uNcZ0ahIzL/tu62DieEXZmEOxYz681FStkyH211a3Y/B0phBE
 XN0ibvKzo4nt5J6+Dsk7pVUKL70vIaY23pcqL1mAW5gO+gwu+aa3z5ln/8FTn+Z0qMtP
 +jScL9OZhoe91qdlLnh7+npDiR1AUCwisQscLBo3h1IEVbYHl440gaI201ND98mDMSxL
 CXF7Y1MsHu0NYf7JoDyVgnc6NG+i+x64I/1J3Tv1/w0U3zKNso4d4ItqCMNNJjJmyAAG
 Mn3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eLfBNRbSl1W6d33tZWXwxSJsOwniWi9VQ/dTIyU4S4o=;
 fh=j8Wqpla8zdJdpfxdaHmFJUBcGtCxh0XBmZnqSlcXeGM=;
 b=XWUq+jBQnrJM8f7n6lbw1JoSLRA6tfF6klE8iQnV/867/gLtOlM0M/eQUudAqDdMID
 3MrJkqPKd2chhbxDNQH+3yQPDexOXMC8ZwcGj0aVzi0c3JWRak0JIjLcH0MfFzLi/veG
 C0IS9IlIuGYeULzRKQJCKNp2nM2naLn2N59E8qCzJ2+UzkaZXPnFgS1fPKOT5nUQQGe0
 /qVOfwpxsl/gp/4BW/wHb6m3g/eXyo0YnNT058ipKajWxbWqfwRK97NWqVGF4jyo1qbS
 t/BqVlcOWP+jTXzxtG/4cGYm41jOs/aJSCF95FoPsCo1DQxUsuG9/PXgOnZDIM/B7kaX
 JGsA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775050495; x=1775655295; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eLfBNRbSl1W6d33tZWXwxSJsOwniWi9VQ/dTIyU4S4o=;
 b=OUfsQbR7syCKJ+PRM1E99dVfMqtY7qYX2IDY2J9LwXV4BUdK5soL+piuUOP1Jff6Bu
 NZRBAwhrQ14efMTbaX144Z8hucS5uLocZSKPWKuXIJ4hF5NAm2FY3RREGfA+1cuscf8D
 YYm0IldwEqXK/oyzE2aIsqc2XsCpbZ9Q3YSz/lv+9ENwx4Hepm1SLnanXGTCZ//qbXTy
 uEgBkEolzz+cgs+wN4O+P66NZ9fgwj5hbJ85XUevSOOno1xROXNHo2WMQu7NnYMsZTUq
 u+v6054rtjx3gco3RNaUJ5AOLBxUFKcNdffkGujydKsaon+6xkvNGjvg4ELlg9HMVO7d
 o/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775050495; x=1775655295;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eLfBNRbSl1W6d33tZWXwxSJsOwniWi9VQ/dTIyU4S4o=;
 b=qcYOO4KBOSWqoHonPYeG4d/jcMqmxXdQAwe1+4ohgd5Zrc50ZwgTZGqae6sWKBBy/2
 C4kGd/J8kj6WbeNkDWrRbsZFg9BCDrQ5ig0L1Pie8AgkosYlQkKFHSzxwmjONwfzqPsv
 wgyaobMzln11ATiNvqW2idM4PmtCSO/bVcWlGI6F52Ij2der3QGhmt0VQFjXBzwUlE5N
 LYhe8nQBv/oPxEHXnOS0bvyy+sS8bhAVXpmEOkxYS6nz/UCXx9nkmtPW1iRgMaabkAHy
 APzq/5pMzXIoqeG2sPc/mLQqlrPyUvZ+eh0eC0BMorbQmisg7/agpiEDErdjcYwOytck
 JfGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdLGFDVKiNJwOU3IlzHGB44VEdBl99vdHm9pwYvV7rl88GELE4pBIKgyxFZJZR62LtrPdCG37kX0A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxwD4EwCkwDEiZhoWdmeXhG9SR3zkQHEm3ESxtTWydlF5jKUBQP
 UayelvWEsef7OlBE3guxVjVks3SkPLPVCoSMDyJ5Scf+YAqjLaq1sgtXe3s4GVLseWCdyAfjQsk
 MHboMi/q7NRzPyMsJajCK3kEM+6zR3NY=
X-Gm-Gg: ATEYQzxm2zkHIjx4MWXRHhtHVTuIEUwzfbT2JwMttzqDeepFuV9LXpNGNoCizFBVtPU
 UZGaKsSqm7qGAXqQf1qHf3yqmEZi+U5eE8qkv533rqeErzy/KJ6dD+gZ+L0jnSZksSntnI3SLoa
 3MGdqZGPHWqO69NaQSRjrHNBJuPKavE7ohinUSYW+VY8KKmSKGvT4sryywv+AEgEGfSMTtRF68m
 mari6FiiHMjvCokMfr298WAmnF2z5z+8GNn1e4t9kf4S8VJyEOQjWelVFumP84pkNzoldkSpfLA
 9O01GfFhsECwEA9b0GIL+2slP3TuloAvrc606zP5zeZYIVWWiX50RhOG0ez6J1ps+xHcRk9wyIm
 MS4sP
X-Received: by 2002:a05:7022:f102:b0:122:8d:39d8 with SMTP id
 a92af1059eb24-12be65ef768mr812956c88.6.1775050494670; Wed, 01 Apr 2026
 06:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260401113911.593661-1-mikhail.v.gavrilov@gmail.com>
In-Reply-To: <20260401113911.593661-1-mikhail.v.gavrilov@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 1 Apr 2026 09:34:43 -0400
X-Gm-Features: AQROBzDM4v695EYwPKTDGmz6KMhv1DQeuqsvqsHzrCsiA4CXWIs1f39e3GLleS0
Message-ID: <CADnq5_MGEpvyoSLe8=k+n=59B3Qx0=e6aeZTOyxMNbPqF9vaLw@mail.gmail.com>
Subject: Re: [PATCH v4] drm/amdgpu: use IRQ-safe xarray API for PASID
 management
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 lijo.lazar@amd.com, Eric Huang <jinhuieric.huang@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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

On Wed, Apr 1, 2026 at 7:39=E2=80=AFAM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> xa_alloc_cyclic() and xa_erase() use plain xa_lock()/xa_unlock()
> regardless of XA_FLAGS_LOCK_IRQ =E2=80=94 the flag only affects lockdep
> annotations, not runtime locking.
>
> Switch amdgpu_pasid_alloc() to xa_alloc_cyclic_irq() which uses
> xa_lock_irq/xa_unlock_irq internally.
>
> For amdgpu_pasid_free(), use explicit xa_lock_irqsave/__xa_erase/
> xa_unlock_irqrestore since this function can be called from hardirq
> context via amdgpu_pasid_free_cb, where xa_erase_irq()'s
> xa_lock_irq/xa_unlock_irq would prematurely re-enable interrupts.
>
> Fixes: a3c0ee978e16 ("drm/amdgpu: replace PASID IDR with XArray")
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

Applied and squashed into the original patch.

Thanks!

Alex

> ---
>
> v4: Move comment to kerneldoc, add Reviewed-by. (Christian K=C3=B6nig)
> v3: Shortened comment per Christian K=C3=B6nig.
>     https://lore.kernel.org/all/20260401120055.46498-1-mikhail.v.gavrilov=
@gmail.com/
> v2: Use xa_lock_irqsave/__xa_erase/xa_unlock_irqrestore for
>     amdgpu_pasid_free() instead of xa_erase_irq(). (Christian K=C3=B6nig)
>     https://lore.kernel.org/all/20260401104859.36990-1-mikhail.v.gavrilov=
@gmail.com/
> v1: https://lore.kernel.org/all/20260401073632.101796-1-mikhail.v.gavrilo=
v@gmail.com/
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ids.c
> index a6ac3b4ce0df..684f40fce73f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -68,7 +68,7 @@ int amdgpu_pasid_alloc(unsigned int bits)
>         if (bits =3D=3D 0)
>                 return -EINVAL;
>
> -       r =3D xa_alloc_cyclic(&amdgpu_pasid_xa, &pasid, xa_mk_value(0),
> +       r =3D xa_alloc_cyclic_irq(&amdgpu_pasid_xa, &pasid, xa_mk_value(0=
),
>                             XA_LIMIT(1, (1U << bits) - 1),
>                             &amdgpu_pasid_xa_next, GFP_KERNEL);
>         if (r < 0)
> @@ -81,11 +81,18 @@ int amdgpu_pasid_alloc(unsigned int bits)
>  /**
>   * amdgpu_pasid_free - Free a PASID
>   * @pasid: PASID to free
> + *
> + * Called in IRQ context.
>   */
>  void amdgpu_pasid_free(u32 pasid)
>  {
> +       unsigned long flags;
> +
>         trace_amdgpu_pasid_freed(pasid);
> -       xa_erase(&amdgpu_pasid_xa, pasid);
> +
> +       xa_lock_irqsave(&amdgpu_pasid_xa, flags);
> +       __xa_erase(&amdgpu_pasid_xa, pasid);
> +       xa_unlock_irqrestore(&amdgpu_pasid_xa, flags);
>  }
>
>  static void amdgpu_pasid_free_cb(struct dma_fence *fence,
> --
> 2.53.0
>
