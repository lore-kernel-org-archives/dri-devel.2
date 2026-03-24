Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39254E9A777
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 12:14:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8142F10E65C;
	Tue, 24 Mar 2026 12:14:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="gMtkVQXB";
	dkim-atps=neutral
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A06E510E65C
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 12:14:49 +0000 (UTC)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-50b6c45781aso664761cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 05:14:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774354488; cv=none;
 d=google.com; s=arc-20240605;
 b=SveB3k218IH2IpdkyQKCPI49VvaZS+BixYmmBkQMUsl4kuTN9hS+5ezlzFHfY09HmD
 LiaBWtj5gIlzZVsfNfj5znrfnEpfHy9gV+r5cnmGiX1twfTyJs9p3S46Ni2iRJ9tDRwB
 48NWMwj8Yt7XIERd3JpbTnX/Lo2YQzLs4KAKYbLafDv4BrI6oxLHIu+VNA+0dR6zntHu
 65ZyC8a3onJOmPRdFFiumLfLFVJMgSFZqYCBQC4mJXvfBH2X83iPEt2XvxFdAxp1Ypa7
 Z2+bi950yE95UqEC9r9VOZjBUpllwYlISXm0IClkkyzG0OREyBFLFiJkG54fuqK90tD+
 8UKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=38JEbVN9/czZUHowiTyQJJi+NFgr4A1LQF8NnXOZQbo=;
 fh=EMeO+ZLMj0UyHoakAI0gNfah3T9CVgw1mcXziouqjBE=;
 b=gXW3xSBGTdG2nw+2KhCFc5fGlX9GQ58Pb1KDA41lyQk6vLiXitY1ODxy0BNOhq5D0Y
 1/uOxAj3cqWc3ZJp9ySKOQAjj7EIfFKicKTZwipJ6L19CZcun2YZkWUc0jZbOWHOZn0o
 iAN6z2wfClLsb6trAhRSaDFxaH97ZVFQhN7IcA9oRWoSuWemkUXYlI7DMEi9J9gL8LIs
 zvtQzzmrngVQiT8qmuboIz09nFM5qsptC50Hrv3ib5cLGWcmFo+BHbhHXo6ENwAJ64LL
 9c1gKaAApPUTcEr94S2DYWpam8mCbWRDqOan7oUv+6P3D/yVp06p+NHRwrNJRQjHlAqw
 ABlQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1774354488; x=1774959288;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=38JEbVN9/czZUHowiTyQJJi+NFgr4A1LQF8NnXOZQbo=;
 b=gMtkVQXB44fiVcWHTCfGMkO7En+GfJP2F48dlW1QFByRPbs9n8m7i0X0dO4x0Jlmrd
 GkgrHf4xWPPeEz1OwtQEGGXbtqSZAbf3Ca2OzhL6enYG5oXSWKN4wq/jMCkNDtPz9e3O
 Bi7AEXXJWUkS6fNNCD/NPRVF8G+Avcsev7YhRABbekJVSSb5pagykXJ/GYWhq/77ah/j
 oJVBDTl3pF22DtzMHWx7LmMvwCdduYVuyY2aPe8/dZ5g3oNnHj5oIw2bljXhOnDyl5Lp
 vOL3bescp3FyX2x9/aaqe86rVdMPtlpy825Xve02Zd7XN9fQpRjSFJw+IKm/oN+IXrJL
 RkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774354488; x=1774959288;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=38JEbVN9/czZUHowiTyQJJi+NFgr4A1LQF8NnXOZQbo=;
 b=f5JOLYR03uBTs2VeSvC4okBM9NJiiE+QYDAkab4dFsx9NPzD0WRUt4nr/1ZRA/vx+t
 tKA4qk0LGrqH849hSAZm0rKYiOE1uqdfssfOJLIPeyvCcTGcqsXDGJumHJihEWgWWMze
 EkvCH9kq1TIl9z3meHCU/K/830mqo01+b36NNPobDgCAFlaFBA7vYp8qXaRVh3JvRWKG
 Ke2oNYHyM2xkM3bXokMZ6ddKdOBvYoPKP7g90Fne6wcjSFYPDD1Um/F50EVDGJCDUo+J
 cBcjynxrxJFOqUshYqMdMryvpvmfxfCqLREX8jpD1CGK6OJqut3C6w2E0yFAgCMHadky
 47cQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrHPrb7gt5fXjG7uQUnanGUjbOtAu81Z7RjLfeajL67QHzq9h3VFW4+xw1p/fLNqBCX4iWL3NNizE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw0eVZ8g83qPB/Z+wYM9mBCg3ZxzWgmnuyKiAGm4nbfDvUdC/qX
 nit7i36OOewnQ5g3oxA6BNOzGf1iAKwuna3wjWyJVNfNMtz52165Twl2NbYmXMt/JNjWJ6c+Ok5
 IK6R8u8coyo5AgA2VplMTIzXOgD6BwsRvax5k2x0k
X-Gm-Gg: ATEYQzwi5Qq+LjdSpVUwjSdrQRjupU02oA8qDJWB/94jM5dnmLZHq/3Q7Jf1xd7bpP6
 cwFD1FM2r3AhuSU8mLdk6sLv+UbHFlhem8aBCNCcDwi+KP+U3pM+GsBbi8yicstgAhHP56mYBJe
 2iDqPlVZxYF+W+kX3CLttHyICdVPxjO8G2AEOfmQY2qqqinCRRLgWP4NzsESpVYCVqGfSRrbSxB
 HpHue8pmugDD73/CsgChrQKXLYVO0XeQTRXwCtmATq/oqj77hIBa7Yscv+sYaFDUSwfyNknTbM4
 TLucc2DogQafNkyNVyxuWrF3SUQomlK2rPJfkMK5
X-Received: by 2002:a05:622a:514e:b0:501:3b94:bcae with SMTP id
 d75a77b69052e-50b6fbd1411mr15608601cf.8.1774354488033; Tue, 24 Mar 2026
 05:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260305123641.164164-1-jiri@resnulli.us>
 <ablV_f_l7wD2m63E@google.com> <20260324120057.GC8437@ziepe.ca>
In-Reply-To: <20260324120057.GC8437@ziepe.ca>
From: Mostafa Saleh <smostafa@google.com>
Date: Tue, 24 Mar 2026 12:14:36 +0000
X-Gm-Features: AQROBzDTh0ODj4C3lU1UM-hZHPuBDyd64_bmAvFt0-7PB-OKq8PhbYOrLNqJZ2s
Message-ID: <CAFgf54qoFhvVR2yfROGaTJmLcjuLACswVFv=trqgJwGb_DB3zA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/2] dma-buf: heaps: system: add an option to
 allocate explicitly decrypted memory
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jiri Pirko <jiri@resnulli.us>, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev, 
 linux-media@vger.kernel.org, sumit.semwal@linaro.org, 
 benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com, 
 tjmercier@google.com, christian.koenig@amd.com, m.szyprowski@samsung.com, 
 robin.murphy@arm.com, leon@kernel.org, sean.anderson@linux.dev, 
 ptesarik@suse.com, catalin.marinas@arm.com, aneesh.kumar@kernel.org, 
 suzuki.poulose@arm.com, steven.price@arm.com, thomas.lendacky@amd.com, 
 john.allen@amd.com, ashish.kalra@amd.com, suravee.suthikulpanit@amd.com, 
 linux-coco@lists.linux.dev
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

On Tue, Mar 24, 2026 at 12:01=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Tue, Mar 17, 2026 at 01:24:13PM +0000, Mostafa Saleh wrote:
>
> > On the other hand, for restricted-dma, the memory decryption is deep
> > in the DMA direct memory allocation and the DMA API callers (for ex
> > virtio drivers) are clueless about it and can=E2=80=99t pass any attrs.
> > My proposal was specific to restricted-dma and won=E2=80=99t work for y=
our case.
>
> How is this any different from CC?
>
> If the device cannot dma to "encrypted" memory, whatever that means
> for you, then the DMA API:
>  - Makes dma alloc coherent return "decrypted" memory, and the built
>    in mapping of coherent memory knows about this
>  - Makes dma_map_xxx use SWIOTLB to bounce to decrypted memory
>
> There is no need for something like virtio drivers to be aware of
> any of this.
>
> On the other hand if the driver deliberately allocates decrypted
> memory without using DMA API alloc coherent then it knows it did it
> and can pass the flag to map it.
>

The problem is that the DMA API currently gets confused by this; it
can end up double decrypting the memory or using the wrong functions
as mentioned in [1]
In addition to the complexity it adds to the already complicated DMA
code. I don't have a strong opinion on how to solve this, but I
believe we need clear boundaries (and wrappers) for cases where memory
encryption is expected as it is starting to spill into the kernel.

[1] https://lore.kernel.org/all/20260305170335.963568-1-smostafa@google.com=
/

Thanks,
Mostafa


> > I am wondering if the kernel should have a more solid, unified method
> > for identifying already-decrypted memory instead. Perhaps we need a
> > way for the DMA API to natively recognize the encryption state of a
> > physical page (working alongside force_dma_unencrypted(dev)), rather
> > than relying on caller-provided attributes?
>
> Definately not, we do not want the DMA API inspecting things like
> this.
>
> Jason
