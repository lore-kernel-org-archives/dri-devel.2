Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9EC5F94CBE
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 22:53:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D583610E22D;
	Wed, 22 Apr 2026 22:53:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="UlSkP8yL";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC10510E22D
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 22:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776898381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LNEiiKAr8tGgxUxPcWc2lJsVUeALFhcpoNoEGS7JOyc=;
 b=UlSkP8yLGSSqGxDJ1XOe9SuMcKE4g22tQT5kqxy7BE0VmRNR4Mn4xrHua2iVx1UeqNeAYa
 KTh9qC02BTWPomaLemDqSLtstti6gCMOQ9R/t5bcBq+OWZ5UGgD5fZiE5byG62oLpb4NaC
 22FeXr+/kbZ4XBtbhTE0llx3n4aPLlE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-6ITuTzfmNN2AmrMvyZauDQ-1; Wed, 22 Apr 2026 18:53:00 -0400
X-MC-Unique: 6ITuTzfmNN2AmrMvyZauDQ-1
X-Mimecast-MFC-AGG-ID: 6ITuTzfmNN2AmrMvyZauDQ_1776898379
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50da31af14cso164779991cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 15:52:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776898379; x=1777503179;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mDXm7aAVELWsp3pvLIzbso12bneOyuVrRAMZreDRWg0=;
 b=XOEDzsN3slvPG6ZXUCNu67ZXGxI8/ifZEm615YbiP/Oj+L8po8YmPqYGky/b7WuWTf
 FCIHc8IJjR9yF0kA9dCf7/A+XKkjHchuV7yLgBkLjuydfWjdFgcYanOiZHgwo6AYiaJy
 kVYDD2UYLe8TiCJWFi+FOgRYYPAO7cRKIw0r+tRxmRnLmCLxFvJDSvZiU1t3bZuxFq1i
 jciVt9+SJDexG2IP5PgIC7Wdv+nYJIx1loZAUEMHzUeG7CxiXITQMs1bIqYFVYnaFmKF
 F+/fhi5CvbgknAaDC27wnDtEFUktLIWlWNgq8ARM8fAqgZKxInZUlKeGWDdw2YaHLCbd
 7nag==
X-Forwarded-Encrypted: i=1;
 AFNElJ/o6FVu42ygs3Hbrqr/KmEL+q7jfqNx/lUjceEZL5Zo+sg2nOvRmohTvJF4PbAp+V+aeh0hbLMwhmc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxGRX7DaJbfbbHP0Xsd96/MiLFG6eCYgqs/wwGD35pXgWm21mLe
 ZNBgIPNxM/7Wr+jMWEjy5ga3eCrOqdjabIW9SD6UV9GdbKdXvGxi/fL5KnyRPglQmr5pD51TMnY
 /EPS/6dNqae8nOFyZSPWg+sfBtKtce9gpTWgMFMFtNpZUpHj4JcKrryqRrk9WB1T2gp2lHw==
X-Gm-Gg: AeBDietz5zYuKQla3d1kBbtqc/mjTk7umYy+vT6JngvBEQen6wKPG1tM7pVWUwBqOLW
 DLMyq+YLIq3RvchsjwAOl4vyWzSHN2dRfPfp+6tsVwSm0xcbyhVgU3asfFjF7ZGW8TkOpo0xZOQ
 4x1FlrAKLGNYvgukFE5sj4e0eBfkK2GsCvgmukQyKPYiUlAJQ0TEb4v3D1PaCoYL3MxOiQrX5sy
 DjnvB9NdMehO4pP/hMRIOKuCvhRBdlnCyt67yz4BF70s1aJ6kCKNLOZM9sZ5AUirfqyOnpQiaFE
 T+Cpxx2pBpMbkWpBvb69JDXDhZpx+iJR84JeZ/L+dpU3KH4B3mDDCj1IHe8gOL6NDhdku8jBkdn
 ORxbMdkuJusbbK3PkgvSB97E5m0Iy
X-Received: by 2002:a05:622a:4086:b0:50b:2876:586 with SMTP id
 d75a77b69052e-50e36820d3emr367722091cf.5.1776898379373; 
 Wed, 22 Apr 2026 15:52:59 -0700 (PDT)
X-Received: by 2002:a05:622a:4086:b0:50b:2876:586 with SMTP id
 d75a77b69052e-50e36820d3emr367721591cf.5.1776898378914; 
 Wed, 22 Apr 2026 15:52:58 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e394c1fddsm151910251cf.30.2026.04.22.15.52.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 15:52:58 -0700 (PDT)
Message-ID: <1b2d926b919471fd3fbaf5b79d47e1110f6c4797.camel@redhat.com>
Subject: Re: [PATCH v12 2/5] drm/gem/shmem: Introduce
 __drm_gem_shmem_free_sgt_locked()
From: lyude@redhat.com
To: nouveau@lists.freedesktop.org, Gary Guo <gary@garyguo.net>, Daniel
 Almeida	 <daniel.almeida@collabora.com>, rust-for-linux@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>, dri-devel@lists.freedesktop.org
Cc: Matthew Maurer <mmaurer@google.com>, FUJITA Tomonori	
 <fujita.tomonori@gmail.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 christian.koenig@amd.com, Asahi Lina <lina@asahilina.net>, Miguel Ojeda	
 <ojeda@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Simona Vetter
 <simona@ffwll.ch>, Alice Ryhl <aliceryhl@google.com>, Boqun Feng	
 <boqun@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Krishna Ketan
 Rai	 <prafulrai522@gmail.com>, linux-media@vger.kernel.org, Shankari Anand	
 <shankari.ak0208@gmail.com>, David Airlie <airlied@gmail.com>, Benno Lossin
 <lossin@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
 linaro-mm-sig@lists.linaro.org, Asahi Lina <lina+kernel@asahilina.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@vger.kernel.org
Date: Wed, 22 Apr 2026 18:52:57 -0400
In-Reply-To: <20260421235346.672794-3-lyude@redhat.com>
References: <20260421235346.672794-1-lyude@redhat.com>
 <20260421235346.672794-3-lyude@redhat.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xS5EQgvCw0aK-fI_y0gKyAx78yIi3zNptixts8Au4x0_1776898379
X-Mimecast-Originator: redhat.com
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

On Tue, 2026-04-21 at 19:52 -0400, Lyude Paul wrote:
> +/**
> + * __drm_gem_shmem_release_sgt_locked - Unpin and DMA unmap pages,
> and release the
> + * cached scatter/gather table for an shmem GEM object.

It appears that I misnamed the function in this somehow still, so I
will make note of this and make sure that it gets fixed in the next
respin of this series

> + * @shmem: shmem GEM object
> + *
> + * If the passed shmem object has an active scatter/gather table for
> driver
> + * usage, this function will unmap it and release the memory
> associated with it.
> + * It is the responsibility of the caller to ensure it holds the
> dma_resv_lock
> + * for this object.
> + *
> + * Drivers should not need to call this function themselves, it is
> mainly
> + * intended for usage in the Rust shmem bindings.
> + */
> +void __drm_gem_shmem_free_sgt_locked(struct drm_gem_shmem_object
> *shmem)
> +{
> +=09dma_resv_assert_held(shmem->base.resv);
> +
> +=09dma_unmap_sgtable(shmem->base.dev->dev, shmem->sgt,
> DMA_BIDIRECTIONAL, 0);
> +=09sg_free_table(shmem->sgt);
> +=09kfree(shmem->sgt);
> +=09shmem->sgt =3D NULL;
> +}
> +EXPORT_SYMBOL_GPL(__drm_gem_shmem_free_sgt_locked);

