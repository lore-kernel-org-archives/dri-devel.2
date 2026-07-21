Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4DBC44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 15:17:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC83610EA64;
	Tue, 21 Jul 2026 15:17:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="p1xGMlbR";
	dkim-atps=neutral
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com
 [209.85.167.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26E0510EA64
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 15:17:49 +0000 (UTC)
Received: by mail-oi1-f177.google.com with SMTP id
 5614622812f47-495c49f8eccso5385989b6e.3
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 08:17:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784647068; cv=none;
 d=google.com; s=arc-20260327;
 b=TrGnkHyS69SS6k7yx4FeYKLI/EwlFiDVlE7KacYp4Kt72NbeqyV/71RQHOEfuyIjmz
 h/LKYsH1dE5MsJhlrJWA7J9EgzmfRdROka4Udip0VXmEY+OOJBnQ0jbR9XPZpzsYw4J/
 3d2X9BAw3hkyAdJ0swPXwXOHJZWaqIUc7FXrj4OFR4KurII0cVbhO3yndUKbzUPjiE0j
 8x5TOWJ9ykmHXak9dBKKbL4kUl38SQpy9Q6vPvekHR2SKf6PmRcD+GciFwRHFAgctPXJ
 dXw8VSqh8H4w+zJdLTZ+Ot32Ww+atmTU03IwtO2NmPXXKF9iyGi7M6RhZzNRdMwTzlqE
 7fRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PMoHz0UZ2YFtSigDv9V4lPoZ67yQ64GXiacPhsl7yN8=;
 fh=enIpyKX7F30sjEs6Iy6N22lrkmY3oHTCjVN6OJ1jYHw=;
 b=PBRU2oBKCynnGL5eGpW+PooNGf7oA7ueFefGnw0nu/eZgQ5KAxQmF6fx4YJW48MIto
 K5pJ3AIzQpikEXe1PuIqbVNHeE+gJLUhVvVsDgW2TyZ0zyFlh/1Qst7n8GDsem4KFQdW
 jXM0BD5x58vYCRenfkSNE2jeGIA2hp65c4Fv3KCp8wJnTKJjzg84DIjsfVgKY4OdIVgP
 415OKcEZQsZX8e+eB53j8fctDy2BtmHYwqmWHOPvAVX0mUHM9fgil4VeNrnaD0YyafPj
 RHxFneN0DHZ+KML+D0/2dNtZrxQPVgXpofTAihFIQqs5o3nMNUdWqc4aoSaGC1+ItYRM
 W4Ow==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784647068; x=1785251868; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PMoHz0UZ2YFtSigDv9V4lPoZ67yQ64GXiacPhsl7yN8=;
 b=p1xGMlbR4RJJ9PBqs4L+pLdMM5snQ/YCijLwnQwSIW2wer856tLnnMJyDcH12Ym9Jk
 uYPSTFfsDWjHs/yATmMnZs2lFzAZX3kBTxTAn5FjsWr2kg6LovnMGUZpFRC2Oy3wiRuY
 n7xQq9G8KtXxitj42Tgb6O5dReKoV+15myDf/xObz96VLTz6Bp6CJNijLZRdIqw2+JD3
 mF0Wds9mAKTvMcFJD+u0w5ceM7TEm2tFi8i7kEp2/Dt7r5dYKig3RuE2odcXomQkyWvb
 RNmAsRsbKfRPQ1S8HJsn1pBHf8dhyL+/ESHheD8oVSi1xS2WUazmnxjaEqtPD1xVA7oz
 jNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784647068; x=1785251868;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PMoHz0UZ2YFtSigDv9V4lPoZ67yQ64GXiacPhsl7yN8=;
 b=I/lynlBgfb5xLYwZ3ei0J7psGSHmOahcvC1RBJ68TJq1oiS1j51JBN495YB4BWmfhv
 CssKzrLUEP4ORUvYKyoVKQ9Y+qV5qdPbIW+eswiRf81rqScpfRzJOXUCAtEYiR7UsCJv
 brN3vozZylOLQqYTZRQjDWGilO/3+TJ+azvq60wD6FT/W/bm8yFeiHwxM7kWq/HupAsC
 jd3ZKjJ34qh1iN2/dt9+Zh+BqXF5FOMUlLq0fEmaM6jA5W7xdkEtCqFGo+x7oZLpg11Q
 0/UcMmRINmaAgXAdqDJ40n8IEol3FUcpj+U2G8lhOfjgyCnPFuA3ofAlfSPzLhFqUImf
 r+Tw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq1nWlHX/ZSnD+UvEUDuej7P4KLFm42aUlId/9SY228gW8pfghaAEv4rJ3EzIIn0F7h2RDUGi+UtZc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyCqv2QqwxNqy6SgRBZysUmW5uxm5q3LNqUl+zSaDMONn0Ffzw6
 Q3QWH5SDxeK9hwlZzeL+HGDxHRPyyK/bgAHBLW80DUlnGtqLbgUmWVdrxSipHQH5x7VTqcNCMfR
 N0wMzl4s0iDeIFv9VsRBPLZcAm456nH8=
X-Gm-Gg: AfdE7ckTpQT5PDIVZU5X6ICVIxoIW90hO6/W9sZGVYiCJvG34yLb46shPwcPhqz4hkv
 sKnRbKay2jTMud5KFJIxHcHmOd4AprfiIC6ceEYeSs8xcbI+J1miXxyNJFtnSwcdFqHVkvy4YUv
 6axpLFdX448sGwhvgnquM2k4XDhG2cBRKoB+1rgTWx2IWaRFZmpDGSQtVIgw3RCpQEuHPGETE51
 lVoACLJnt8jjZhSnLXuek9yYGUFQFXudCvTiicqf4L2B14Ai1xMZxPbKWA9fi4=
X-Received: by 2002:a05:6808:f8f:b0:495:f519:70f1 with SMTP id
 5614622812f47-4a4d05655bamr11557394b6e.31.1784647067874; Tue, 21 Jul 2026
 08:17:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260719175857.4071636-1-ap420073@gmail.com>
 <CAHS8izMocev_0TtAsUr9BqCm6sH2DBh-bPK4DfZYNEAb_d2G6w@mail.gmail.com>
In-Reply-To: <CAHS8izMocev_0TtAsUr9BqCm6sH2DBh-bPK4DfZYNEAb_d2G6w@mail.gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Wed, 22 Jul 2026 00:17:36 +0900
X-Gm-Features: AUfX_mz2BhMqLPLPvuogKcIXppoGgoP6WsP21eb7KRTuGc6qaIlknUYcLS2hihA
Message-ID: <CAMArcTXoUyPm1j1HW7xHRbRCLryvmJQVhJGBpGJ2c65mbxs5QQ@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 00/13] net: knod: in-kernel network offload
 device
To: Mina Almasry <almasrymina@google.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Alexei Starovoitov <ast@kernel.org>, 
 amd-gfx@lists.freedesktop.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Andrii Nakryiko <andrii@kernel.org>, Bill Wendling <morbo@google.com>,
 bpf@vger.kernel.org, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, David Airlie <airlied@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, 
 dri-devel@lists.freedesktop.org, Eduard Zingerman <eddyz87@gmail.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Eric Dumazet <edumazet@google.com>, 
 Felix Kuehling <Felix.Kuehling@amd.com>, Hoyeon Lee <hoyeon.rhee@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>,
 Justin Stitt <justinstitt@google.com>, 
 Kees Cook <kees@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Leon Romanovsky <leon@kernel.org>, 
 linaro-mm-sig@lists.linaro.org, linux-hardening@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-rdma@vger.kernel.org, llvm@lists.linux.dev, 
 Mark Bloch <mbloch@nvidia.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
 Michael Chan <michael.chan@broadcom.com>, Nathan Chancellor <nathan@kernel.org>,
 netdev@vger.kernel.org, 
 Nick Desaulniers <ndesaulniers@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Saeed Mahameed <saeedm@nvidia.com>, 
 Shuah Khan <shuah@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Simon Horman <horms@kernel.org>, 
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Tariq Toukan <tariqt@nvidia.com>, 
 Yonghong Song <yonghong.song@linux.dev>
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

On Tue, Jul 21, 2026 at 4:18=E2=80=AFAM Mina Almasry <almasrymina@google.co=
m> wrote:
>

Hi Mina,
Thanks a lot for your review!

> On Sun, Jul 19, 2026 at 11:01=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> =
wrote:
> >
> > knod (in-kernel network offload device) drives a GPU directly from the
> > Linux kernel - with no userspace GPU runtime such as CUDA or ROCm, and
> > no userspace component in the data path - to accelerate packet
> > processing.
> >
> > The kernel itself allocates the GPU's queues, JIT-compiles the
> > per-packet program to GPU machine code, and dispatches it; the NIC DMAs
> > received packets straight into GPU memory and the GPU returns a verdict=
.
> > The GPU is programmed like any other in-kernel offload, not through a
> > userspace framework, so existing XDP programs and IPsec SAs can be
> > offloaded to it transparently.
> >
> > The design and motivation were presented at Linux Plumbers Conference
> > 2025:
> >
> >   https://lpc.events/event/19/contributions/2267/
> >
> > Motivation
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Line-rate packet processing that does non-trivial per-packet work - an
> > XDP program doing L4 load balancing, or IPsec crypto - is bound by the
> > host CPU: each core handles one packet at a time, so scaling means
> > spending more cores. A GPU is the opposite shape - thousands of lanes
> > running the same small program over many packets at once (SIMT) - which
> > happens to match the per-packet-program model of XDP.
> >
> > knod moves that per-packet compute off the host CPU and onto a GPU. The
> > NIC DMAs received packets directly into GPU memory, the GPU runs the
> > program across a batch of packets in parallel, and only the result
> > comes back: a verdict for every packet, plus the packet itself for the
> > ones destined to the host. The CPU no longer pays the per-packet
> > program cost, and throughput scales with GPU occupancy rather than core
> > count.
> >
> > Crucially this happens entirely inside the kernel. GPU packet processin=
g
> > today generally launches work from a userspace GPU runtime (CUDA and
> > friends) and keeps that runtime in the data path; knod instead builds
> > the GPU queues, compiles the program, and dispatches it from the kernel=
,
> > so it plugs into existing offload paths (XDP, xfrm) with nothing to
> > install or keep running in userspace.
> >
>
> TBH I found this motivation weak, especially since IIUC you're asking
> for almost ~50K lines of code to be merged to the kernel. My thinking
> is that (a) it's true that Native XDP takes up CPU cores, but
> HW-offload XDP already exists and takes up no CPU. (b) with AI, GPUs
> are very expensive and the work they're doing is critical, so you're
> unlikely to buy a GPU and use it for knod-offloaded XDP; you'd
> probably buy a cheaper smart-NIC? And in the cases where you do have a
> GPU, it's likely your system's money-maker, and you probably want to
> offload work from the GPU, not to your GPU.
>

Thanks, these are fair concerns.

For a system where the GPU is already fully utilized, a SmartNIC may
indeed be the better target for XDP offload. We are not arguing that
GPU offload is always cheaper or more efficient.

The goal of KNOD is to provide an upstream path for using programmable
accelerators already available in the system for kernel networking.
Hardware XDP offload exists, but the available functionality is tied to
the NIC, its firmware, and the features maintained by the vendor.
KNOD instead aims to provide an execution layer that can be extended
in the kernel community. XDP is the first workload used to validate
this layer, rather than the intended limit of KNOD.

> But as far as I can tell there should be much more interesting
> applications for what you're doing rather than offloading XDP. Like
> wouldn't you with this feature be able to implement ML collectively
> like all-to-all/all-reduce/all-gather as purely XDP programs offloaded
> to the GPU? If you have that implemented and can positively compare
> performance to RoCE or RDMA that would be a much more interesting use
> case IMO.
>

I agree that this is a promising direction, and collective communication
could be a good fit for this model. At least for all-reduce, however,
BPF/XDP does not currently support the required floating-point
operations. If that support is discussed and added by the BPF community,
this would be an interesting use case to explore with KNOD and evaluate
against RoCE or RDMA.

> > Model
> > =3D=3D=3D=3D=3D
> >
> > knod binds two endpoints through a third object:
> >
> >   - a NIC-side netdev, registered by the NIC driver;
> >   - an accelerator (the GPU), registered by a provider built into the
> >     GPU driver;
> >   - an offload device, created on attach, that connects them and owns
> >     the per-queue data-path state.
> >
> > The accelerator ops are feature-agnostic, so different per-packet
> > programs plug in behind one interface. This series ships two features
> > to show the framework is not tied to a single use case (the accel-type
> > uAPI also reserves "dpu" for future non-GPU backends):
> >
> >   - BPF:   an XDP program attached in offload mode is JIT-compiled from
> >            eBPF to an AMD GCN shader and executed on the GPU.
> >   - IPsec: RX ESP full-packet decrypt on the GPU (proof of concept,
> >            see below).
> >
> > Data path
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > For a NIC RX queue bound to an accelerator, a received packet flows as
> > follows:
> >
> >   1. Attach reconfigures the NIC's page_pool so its pages come from GPU
> >      memory, exported as a dma-buf and plugged in through the devmem
> >      memory provider. The NIC therefore DMAs the packet straight into
> >      GPU memory - there is no host-side copy on RX.
> >
> >   2. Instead of building an skb and entering the stack, the NIC's NAPI
> >      pushes a small descriptor (memory ref + offset + length) onto a
> >      per-queue lock-free SPSC ring shared with the GPU.
> >
> >   3. A persistent GPU worker drains descriptors and runs the active
> >      feature's shader over a batch of packets in parallel - one
> >      workgroup per packet - then writes a per-packet verdict back onto
> >      the ring: PASS, DROP or TX.
> >
> >   4. Back on the NIC NAPI, each verdict is applied:
> >        - DROP: the GPU page is recycled to the pool;
> >        - TX:   the packet is sent back out the NIC directly from GPU
> >                memory (XDP_TX), with no host round-trip;
> >        - PASS: the packet is copied out of GPU memory into a host
> >                delivery page by the GPU's DMA engine (async SDMA),
> >                wrapped as an skb, and handed to the normal stack.
> >
> > So only PASS packets ever touch host memory, and even then the copy is
> > done by the GPU, not the CPU.
> >
> > The control plane is a generic netlink family ("knod") for
> > attach/detach, accelerator/NIC inventory, and per-accelerator feature
> > selection, with notifications on bind/unbind.
> >
> > Code layout
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > knod separates into a subsystem-neutral core and a GPU-specific
> > provider; nothing in the core knows about GPUs. Roughly:
> >
> >   - core + control plane + NIC drivers   net/, kernel/bpf/       (~4.4k=
)
> >   - GPU provider (queues, JIT, shaders)  drivers/gpu/drm/amd/    (~39k)
> >
>
> Since the changes are so large, I would break this work into many
> series, the first which only supports a very minimal set of work
> (which I would guess would be XDP_DROP and XDP_TX), and then follow up
> with another series which adds XDP_PASS support, and then IPSec, etc.
>

That makes sense. We will split the work and start with the minimum
functionality needed to demonstrate the architecture, likely XDP_DROP
and XDP_TX. XDP_PASS, IPsec, and the remaining functionality can follow
in separate series.

Thanks a lot!
Taehee Yoo

> --
> Thanks,
> Mina
