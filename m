Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74AC4CD98F2
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 15:07:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B88DD10E4B5;
	Thu, 18 Jun 2026 15:07:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ohUhMkbL";
	dkim-atps=neutral
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54CC510E4B5
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 15:07:41 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-bec450b950dso147464266b.2
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 08:07:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781795260; cv=none;
 d=google.com; s=arc-20240605;
 b=fnU2EZkm4UA8Sw87IhOH3SKmrhpP6ilFWdUe8ApK30/Sv8xlKEVFL6ObANZtalh5iw
 CyynrTsTHXpp+SxqaX1ZNwdPp+br+MSX9xMJs33QRw3c47tQOP+vCiX9AqfR96jkFkxT
 w6s9h+3HeW3Idve0G6Nt8RWDbRSOEjtcBGr66YqMGkM5h4MUIOcdaHT2toqJNDAHs79F
 AyPwGI4uAusfUUD/Bw/JeAe4mkKTN2cqDy/I7K1FDKB7OsDcJirUGc47O88tY1SVjwsg
 o6Yhy0TDFt6PQRuei1qadoEcStTIyjCUjH1C1vsY1RwGhSKaXo7GuLxnN2wA4l8LnYHW
 U1CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NYfGyus+VhVBHeY1TmmYU+r9XB2t30QhuWaxH/6OPAg=;
 fh=DOu4rAJ/C4ZmbaYNuovm/2mvaqdVvrCTGn8lezTYLKI=;
 b=MVA9rq9hknM+g+nd/8cDE422v2O1uTdCerd71oTcypFlSoZviqe5QrevMnuVBFCwxd
 Pk7zn8aCCKVf57o0bMljQz2tRWEtTJ7VzwPPYE9tD3AQUzFCMzddJvB6XzKvgb4tvb7H
 6vkF5at2XOPvKujXTtlcvLt10ibL9MQ9IHHvVlgZY//sT9ketSYEckdzJ9m3Ips4RsDt
 VGowf/D3t6A+H9fdKS2DGlnuWlBHMD9XPUWR7g9XV0cY5Hc+Gqc8j1aeYizppBKrCKB4
 j210eVHcVoDiXeNXNVLSpuBO4fLxG4awUBIHWeoDWr0fVg+m/PGrtRrGWnc8MJNjDUex
 VroA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781795260; x=1782400060; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NYfGyus+VhVBHeY1TmmYU+r9XB2t30QhuWaxH/6OPAg=;
 b=ohUhMkbLWMmanSSQ5JrHaiCic12SAZYG/g65eSwOvaBfVbIGQ9uKskpKg2fVazOcPE
 BPdoA3ZuT8xrsIOop+XRJmetedCQKsv9chjsb0Nh4zohn2wDStF+Omt9e63rI83iwBAo
 JYnRySDUJl6f4cKhy6Gtic1s012n6c1NUy25q80D3d3MZDRbN97pT9e++6TB+l5GlGiO
 X9xr7BzjYOIYAMj+YIXnC+mGc6xukVqvHnyiOaIts5bglZN28emztABXlCm9M5wDXywz
 LD5M+GeFnvWN23rJWZAtuBDNnBrHlG5ywEiDJeUOPriixQVokDy0wMdkkzXkYPkI97T9
 151A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781795260; x=1782400060;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NYfGyus+VhVBHeY1TmmYU+r9XB2t30QhuWaxH/6OPAg=;
 b=BOJPsBuAUXnI+AeWv6RPlFl3iH0jsT8p1iJCzQwJ10pUQtwlfm499qIsbq6KETSL1O
 j13JSFD8SYgMg/DL/tWwomGO/5Z65P/TIiNmDPZHqaNqpEhqqCiWtPliSJ1tmKYoCKmC
 Rc0V5SPvgQtOGCA2s/4U25Qa5yo9kGMJ2YimC6vQXFIP6cpx9xYLZIkr5Ppgtq1iBDpW
 Zlraa+SMS0VAwRVw2MVjiduiVd1V3T4j8h7q7x1rSpogWbuqKhBTjGSgf40QvPdiE1ns
 JAZQmF/cQLr9Hlq8m6X7zn5KPiVZl/otRIkBIRJw/aRc5hlIh2Bp7AblzU2k+gNZjmBy
 ofhA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+BX6WqcOy0Rh08fo9jvQjKQyGMGwQVYNvt7CrLaRUJ84HT47lbcm7F9oe+ntBxg+eM5zKPUbVrxAI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxXtIOMqJ6qa5mR6baFDy2IG4+ddJuZpr5weDGbYhPBNaz6BM/6
 tSgKgmSjEHz0hlxds2FTuNd/77fWVqf1rJpps5mAQp1+8halvgb4NzoJLd5CuFDDVCHGcjoRrus
 4eaBtGBqQv3W+2tzlkG5rCNQmA9WDUcFpQcx3lS27gQ==
X-Gm-Gg: AfdE7cnoZeRDpYzc6KrZCppLhvmu6G1WUaCkAqdCVV1wtusLLzVaCSpdaS+UaIjgH6M
 0kiLJvsFi4VsRAxWg/e5bWHOxMlrg8ilt67+FxRZxyPWIp8/ly62H0pAS+vnMYMXQoO+9nbmm3Q
 5bdE3PmQc4ORJP5q7p4yg7cykKFOBB7l//L3Xj2hBqszmxyHF16ruwy2XRajqdrbZ8AyASIgaCl
 SZiLfMPDB1eXRO/2Tt6JVNivqjau3/vKhhEIyLGxPeLux0bizoz7SbK0H90l4JLARG/cfSF927Z
 aYkSp9EAILt3WONXxj8CFMi0sA==
X-Received: by 2002:a17:907:98c:b0:bfe:ed06:565f with SMTP id
 a640c23a62f3a-c05d2ebb73cmr565480566b.52.1781795259736; Thu, 18 Jun 2026
 08:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260618132628.3811068-2-phasta@kernel.org>
 <20260618132628.3811068-6-phasta@kernel.org>
 <923343e7-1f11-4e29-8278-917fc65c75eb@amd.com>
In-Reply-To: <923343e7-1f11-4e29-8278-917fc65c75eb@amd.com>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Thu, 18 Jun 2026 20:37:28 +0530
X-Gm-Features: AVVi8CdVSitERASSjLlXjGMzf8QWomu8u5eVZoymDD14ZtOhmnelZ1EXdDXW5pQ
Message-ID: <CAO_48GGKOGMr5bexkW3+d9AsF=RYkZeaU6+nWgnaJxzXVLft2Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] MAINTAINERS: Add entry for Rust dma-buf
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Philipp Stanner <phasta@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexandre Courbot <acourbot@nvidia.com>, 
 Asahi Lina <lina+kernel@asahilina.net>, Matthew Maurer <mmaurer@google.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>,
 Burak Emir <bqe@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Krishna Ketan Rai <prafulrai522@gmail.com>, 
 Tamir Duberstein <tamird@kernel.org>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Eliot Courtney <ecourtney@nvidia.com>, Mirko Adzic <adzicmirko97@gmail.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Shankari Anand <shankari.ak0208@gmail.com>, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org
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

On Thu, 18 Jun 2026 at 19:00, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> On 6/18/26 15:26, Philipp Stanner wrote:
> > Rust does now have abstractions for dma_fence. These abstractions are
> > quite complicated and require expertise with both the C and the Rust
> > side. Therefore, using the existing entry also for maintenance of the
> > Rust code appears reasonable.
> >
> > Philipp volunteers to help maintain the dma_fence abstractions. Add a
> > corresponding MAINTAINERS entry.
> >
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
fwiw,
Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
>
> > ---
> >  MAINTAINERS | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 4ae6919454c3..8b03eb2c578a 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -7535,6 +7535,7 @@ F:      fs/dlm/
> >  DMA BUFFER SHARING FRAMEWORK
> >  M:   Sumit Semwal <sumit.semwal@linaro.org>
> >  M:   Christian K=C3=B6nig <christian.koenig@amd.com>
> > +M:   Philipp Stanner <phasta@kernel.org>
> >  L:   linux-media@vger.kernel.org
> >  L:   dri-devel@lists.freedesktop.org
> >  L:   linaro-mm-sig@lists.linaro.org (moderated for non-subscribers)
> > @@ -7548,6 +7549,8 @@ F:      include/linux/dma-buf.h
> >  F:   include/linux/dma-buf/
> >  F:   include/linux/dma-resv.h
> >  F:   rust/helpers/dma-resv.c
> > +F:   rust/helpers/dma_fence.c
> > +F:   rust/kernel/dma_buf/
> >  K:   \bdma_(?:buf|fence|resv)\b
> >
> >  DMA GENERIC OFFLOAD ENGINE SUBSYSTEM
>


Best,
Sumit.
