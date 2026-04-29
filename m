Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4AFCFF8867
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 08:11:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28F2F10E2EE;
	Wed, 29 Apr 2026 08:11:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="KHe3L3D2";
	dkim-atps=neutral
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com
 [209.85.221.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71E9810E2EE
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 08:11:32 +0000 (UTC)
Received: by mail-wr1-f74.google.com with SMTP id
 ffacd0b85a97d-4411a2c034fso7920961f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 01:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777450291; x=1778055091;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=5lr17Jge9GgkiGKrAiGt8x+/cqgjgJIF0Kac8aOzuZk=;
 b=KHe3L3D2H+r5Ih4NfuV/tvCSk5l53oaaVylZERi6n3rR3Dsa8KavAuNmlvPMs1QIn2
 4ZgAv2WECGHL/slYSG3tgSlKB3Bp+NbMtrIVdxEkDTnPKZRsiACVuBAP5isWxX2Qlcob
 l/SI2gB4kdMnbdp51q2E1VYEWYqupFRmxWz7bCfpNRtFW2tASAP73agHA2HteXFEIGCd
 f7k9aL/wOVBsBBDxq6N4goYD4wepuSf5955YZTNpfz2bVrigLrR0SrQ8X+pHab3j0aB1
 9iJ6mVxIm/4F0k0NBuhTX8D9aFFpA2CI5m4c90UWjrh9s02Qw8zj65LzKdZeOLAs+Xlx
 teMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777450291; x=1778055091;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5lr17Jge9GgkiGKrAiGt8x+/cqgjgJIF0Kac8aOzuZk=;
 b=TKgPaaJlfrbnC9LtSyxgeLSPwXWJrK41cx0ruNNrqnQsiAP3HlvDK8ArX5ZwDLLmon
 Gk6Ht7kF3JLWw3pFRH8u2sd5ovjuU1yPkqcJ64Rt+ld1eGUb9B7IO8YaGq2SSUfMs/3r
 fKvrwGBzrcI2e5b6YfzSJC3s8qdOQQI//mIuhTgBajyx6ZUO3zAf0pxn5aoApEh9oPuL
 m2pgTERZeTCDcmih4DilUeDa6qNcm96ckV728K0OO9qh0lRhQyceTbMH7pbebCKPmqdV
 3nKGzm3avymwTHf70bCHVAv4181RHbR97VqbgcJcymG4pEkZ9TVHgOe8GMsE7lrKETcg
 qh9A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ELTGHU3Z1MmQktISZPRI7v9sX4/9KPj2rSUKxzRQA5SyF0L0jkZUK6OCC2tBOV+Ufhm8uRWrsCaU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz9vKuyjG4W78myjxz2pQ1me3PuOPKx7gQx/sK1pptUgAx66e7I
 aphtlVQIe9nNWjexXACNnySI1PLZPFkR+EM3sm4RcybXELIB7ihVpL//5+cxiCqvaqN/4pgYrmF
 9y9ZmBVVHhlqreuIE3Q==
X-Received: from wrhm3.prod.google.com ([2002:a05:6000:1803:b0:43f:e56f:629b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:186d:b0:43b:3d02:7806 with SMTP id
 ffacd0b85a97d-446494ea007mr11517494f8f.28.1777450290684; 
 Wed, 29 Apr 2026 01:11:30 -0700 (PDT)
Date: Wed, 29 Apr 2026 08:11:29 +0000
In-Reply-To: <20260428190605.3355690-4-lyude@redhat.com>
Mime-Version: 1.0
References: <20260428190605.3355690-1-lyude@redhat.com>
 <20260428190605.3355690-4-lyude@redhat.com>
Message-ID: <afG9MTFxCbKE8OOZ@google.com>
Subject: Re: [PATCH v13 3/5] rust: drm: gem/shmem: Add DmaResvGuard helper
From: Alice Ryhl <aliceryhl@google.com>
To: Lyude Paul <lyude@redhat.com>
Cc: nouveau@lists.freedesktop.org, Gary Guo <gary@garyguo.net>, 
 Daniel Almeida <daniel.almeida@collabora.com>, rust-for-linux@vger.kernel.org, 
 Danilo Krummrich <dakr@kernel.org>, dri-devel@lists.freedesktop.org, 
 Matthew Maurer <mmaurer@google.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, christian.koenig@amd.com, 
 Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Boqun Feng <boqun@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Krishna Ketan Rai <prafulrai522@gmail.com>, 
 linux-media@vger.kernel.org, Shankari Anand <shankari.ak0208@gmail.com>, 
 Benno Lossin <lossin@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
 linaro-mm-sig@lists.linaro.org, Asahi Lina <lina+kernel@asahilina.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
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

On Tue, Apr 28, 2026 at 03:03:43PM -0400, Lyude Paul wrote:
> Just a temporary holdover to make locking/unlocking the dma_resv lock much
> easier.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Co-authored-by: Alexandre Courbot <acourbot@nvidia.com>

Needs Alexandre's SoB.

> +/// Private helper-type for holding the `dma_resv` object for a GEM shmem object.
> +///
> +/// When this is dropped, the `dma_resv` lock is dropped as well.
> +///
> +// TODO: This should be replace with a WwMutex equivalent once we have such bindings in the kernel.
> +struct DmaResvGuard<'a, T: DriverObject>(&'a Object<T>);

We will also need this in GPUVM, so I don't think it needs to be private
to shmem.

Alice
