Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A511FEC0EB
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 17:36:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9437C10E512;
	Tue, 24 Mar 2026 17:36:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="MvQJwWpF";
	dkim-atps=neutral
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75A5C10E512
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 17:36:36 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-509062d829dso40031cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 10:36:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774373795; cv=none;
 d=google.com; s=arc-20240605;
 b=Pw+wfjdEZNa351f8QaXpSgwYtYY1N6QhrvniP0EI5vbxz/NrIMVppYSkKAC81G5xSZ
 h/gj+C3UPXzWoaCDAbuPELZEBJ8x6Oi13oaq+PNtl4aD2dPe8DBgTC07KjzrbSWK0E5I
 8zu98uyzVKug4TIpQISSCeFJMfbDG/2G2YOsdGIFQR25Urmkg9GK7lMti7SDKZniXnZK
 45G6NkuYMHnnMD9bOOKm0/qZgSbGhTCg8z9ppxuGJKZjfb6JWLGJ5YIYyOFIKE3rGiTX
 jaBrcYIsaIFye4AjZseWS+RsBuIsLBrXnWIAXH/N6Kxt+joj1Nzugn9wqX3iyRju3Irx
 6fIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=T7cRZZnHlvElmV5E4d+ARimoSvXKMR3JQuoEi7NRgdM=;
 fh=r1v7aGuHSfJ17ZzDrPv+a8E053DQUEvU3PraKNxJ6tU=;
 b=GDZdk6wAtUV8Q1DiYli76sLFC4+DMbxr0TISCVFAgY/n37UaLm+ViiECfX+qJWRR9i
 pdWvOgn+Bo4QtfITO8L0qJ6bAB7HkbSbUU0BF1CLeS26A2Z90Ql60iN67DVnB8sH/6Bd
 MoiLCPBEO4qLIGekcrPXQvhKTxihfMqdkwNEhuZJAUCu2N51ycUcIpPm86Pl1EdMspcU
 oLqWtTJDW9siBX1YyejgxqlqWcWv8D8v/KnduwO8Hkh5dKgqVPOaZ3oqcImEqPWOvITc
 Yz9gis30z7trk3nLpE5JZ5B+cA+C84Yw5mevDPKPA2XBnDHnVDbIuOSUGoO0i48QyH14
 M4rQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1774373795; x=1774978595;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T7cRZZnHlvElmV5E4d+ARimoSvXKMR3JQuoEi7NRgdM=;
 b=MvQJwWpFCPh3nzSELv+IquKcL/9SXYm9zglQo9Bo+Jzi4v2sWNJNbW1M6/KBA2/xy9
 hhXu24E3vNW9CLgu7PNaaTAxoWg6Ow+IbRcDPdK+d5j2U567LcltXL7SUJpyqH7PEExq
 VrS2KYdkgLuC1RMQv64lDgtLlrzEcU1XyBibjODMIVGuq09luNOvClVtVjlduXySLsRh
 0o+LD25Ja/3agJk9IT+aIjkFx3qDq5p/nujyjWBX2O6NYWloVjQRkhLT67J0+D0AArJY
 Yeia+4FVudejBXyRS440Xn/rFW84k3PJJLg3V4vD9nH8WG5UelBfc4f+vhpyZWMm1KPb
 TWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774373795; x=1774978595;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T7cRZZnHlvElmV5E4d+ARimoSvXKMR3JQuoEi7NRgdM=;
 b=lyw2QHgJoMudaTNH/+ccMCSSmUpaov0SFgeiIJXw8XXtXeA539xS8847kWCtCx83TK
 vlAgrey0mJYClm78fcjDlszI3MrPBB4yIpGm84BAgqArQDEm2WwAvcKAdKNz9YmK0PNc
 OxD6WtE/v28xxSCSg8wDN7QjVnpuMv8dkZTN5ISQ8QVid75feSeuoLp15Pv6JUHMV6fo
 E5ZwREKLK9oj2E50ZyZCHVJ8bofU7nIw+RdyPEYhi+noqGPjAOqZ3LJ5OEe+6gyXYAlG
 1PwxW3/ieAGhzBn53qGj7+iud1fHwvEb6gXFqpH+HpB7ddQmUUFk6tq823zgbdm4YuFH
 jCgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5szvyL2vGR7HKR2FSMvafALD5mITkO20XsmnLY04Uo1gi343aoCY+kvtbg+XktnjDzJSp8E7IQCg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxdbGnHTYBhrQ3zWjW3WUsMIvQ0lfxlaW+yODappFgzqLwTefUa
 MQiRBELNDqwvEourJtqMBjzu/EYDKeSNb8WZbJaDegPsBtib9UWdel9OtxThAGE4+S0yoxk5YNN
 /QS7SbowSrDx3VFN+gJ8M+A9bfzIvrjTG6PSGaTsg
X-Gm-Gg: ATEYQzzDnIpyYtl8YwpStzU0sX7ourOUuGf5CKRP6e4t0o5VGaUUpbwp6UdM+RS1D9a
 Z8uPp7TtU2JkN/Iax6fDYo5bq8ijqJ2VA+FrSvIwzIrBT7PBPqjQ26uuRa5nlprrjPTjzl/09PD
 C52j+gAMkz/jVuZefFfj9JITMU1q64YCiGI/w64qf+X6qLUG8XTPqtby3mK8jqf3E2sgacAK0u/
 PZBWolD+OY7K+n0LuoAOk51RfZGnxx6m6lTs7aVa+BxSxxcwuJrElYT/Nl0+mtpW0w+eE2agHBO
 b//ZoYKtbcpjt07t/Kq9ONrivxyWPIGgqOsTmYU=
X-Received: by 2002:ac8:5a41:0:b0:508:fd42:fd05 with SMTP id
 d75a77b69052e-50b823fa2ddmr354431cf.15.1774373794536; Tue, 24 Mar 2026
 10:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260305123641.164164-1-jiri@resnulli.us>
 <ablV_f_l7wD2m63E@google.com> <20260324120057.GC8437@ziepe.ca>
 <CAFgf54qoFhvVR2yfROGaTJmLcjuLACswVFv=trqgJwGb_DB3zA@mail.gmail.com>
 <20260324122416.GD8437@ziepe.ca>
In-Reply-To: <20260324122416.GD8437@ziepe.ca>
From: Mostafa Saleh <smostafa@google.com>
Date: Tue, 24 Mar 2026 17:36:23 +0000
X-Gm-Features: AaiRm51PAsNGUjv3vtee5YHklYnd6tfPfqFJtrYrMATN4cWFgoB-kqA4e1zQENQ
Message-ID: <CAFgf54qwA2D1Xa4rnruJ4Nfp5BsB=T_pB3hzz9HBjh22TL17uA@mail.gmail.com>
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

On Tue, Mar 24, 2026 at 12:24=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Tue, Mar 24, 2026 at 12:14:36PM +0000, Mostafa Saleh wrote:
> > On Tue, Mar 24, 2026 at 12:01=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca>=
 wrote:
> > >
> > > On Tue, Mar 17, 2026 at 01:24:13PM +0000, Mostafa Saleh wrote:
> > >
> > > > On the other hand, for restricted-dma, the memory decryption is dee=
p
> > > > in the DMA direct memory allocation and the DMA API callers (for ex
> > > > virtio drivers) are clueless about it and can=E2=80=99t pass any at=
trs.
> > > > My proposal was specific to restricted-dma and won=E2=80=99t work f=
or your case.
> > >
> > > How is this any different from CC?
> > >
> > > If the device cannot dma to "encrypted" memory, whatever that means
> > > for you, then the DMA API:
> > >  - Makes dma alloc coherent return "decrypted" memory, and the built
> > >    in mapping of coherent memory knows about this
> > >  - Makes dma_map_xxx use SWIOTLB to bounce to decrypted memory
> > >
> > > There is no need for something like virtio drivers to be aware of
> > > any of this.
> > >
> > > On the other hand if the driver deliberately allocates decrypted
> > > memory without using DMA API alloc coherent then it knows it did it
> > > and can pass the flag to map it.
> > >
> >
> > The problem is that the DMA API currently gets confused by this; it
> > can end up double decrypting the memory or using the wrong functions
> > as mentioned in [1]
>
> I fully belive there are bugs, but the API design is sound. If you use
> the coherent allocations from the DMA API then it knows decryption has
> happened when it generates a dma_addr_t and there should be no issue.
>
> Now, if drivers are using the DMA API wrong, like trying to double map
> coherent allocations then they are broken. I also would not be
> surprised to find cases like this.
>

But it's not about drivers in that case, it's about many places
(SWIOTLB and DMA-direct) calling set_memory_decrypted() without clear
ownership so in some cases they step on each other's toes, and I don't
think that will get simpler with yet another caller in this series

I am fine with the API design you mentioned, but I believe that it
needs clear documentation specifying who is responsible for
decryption. The code should provide wrappers checking for these cases
instead of having is_swiotlb_for_alloc() and force_dma_unencrypted()
everywhere in DMA-direct.

Thanks,
Mostafa

> Jason
