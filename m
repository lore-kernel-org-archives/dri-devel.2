Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81E6C44532
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 00:25:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC56510E4F2;
	Thu, 23 Jul 2026 00:25:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="l6e2hnh8";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C66210E4F2
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 00:25:00 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-382ef647e20so54055a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 17:25:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784766300; cv=none;
 d=google.com; s=arc-20260327;
 b=d4Z9tUt26qsjfn0HecGjk1i1tNPjNxehuIa+JjlsaEbHzlcobYRrBNOSCzdf2PEBB0
 qTz4x/k1g3Ol02xOgJY3FcURJokybEzLKHL0wxBOfMjm/aB7eG8/yUaOhHF81UVrPqsj
 gRrQYMjyXIu41KI2U82j6JY5+ptQ/jTjk8Xp8eblUmD9iWUAmDsi0N2kue7+bWd4NRiB
 J5pbZNFdkisZX9g1xFm+GenTEmSelh+SRzkss+bvqpU7Yr8RoieeRiGGMomuC48oqHYw
 AUEJ/a55gbQxhQ/eLscgf+ScPqRkzmtHDeWmtcLcGdycYft72uKj2w+vIyKNdybHa74g
 Qyqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date
 :mime-version:references:in-reply-to:from:dkim-signature;
 bh=QK6NTIZ7U7u2uxukmeUbpT6BYUSoQRmwBsUnN+HFDzo=;
 fh=5ab483C2SSjNAd0P/Ct3Qoxz9e8qKSs9NIUblt5DTUU=;
 b=YQyGAdN0W27j6tHWFx11ZbDUlq74vmPq379ddXfueHB8Rpo1Iyf/7GK/13v/irzLmG
 ImBUdNKSImmvLZBsg6eVHVQ98S26cEfxMExgsUrofFtpPBmEGHS4BcYgnIJuGL2HwG/0
 RTe7Rg7LJKjJlErP6V8zZRTxBQcNvCb2veTxNtx306Oq/f6GyH5cldWN2XTfDI7snLQs
 9CZf32h4EVbGoA0fp+zGhD2VfLfWNEe5NKKiuv7JPXhXZeedIsntc6Rk9iVV5LWEGC7z
 IinfvCIh6/ByCRHDzaUd6T/mrl95IO3+NJLwRsXMbxCExxi8yVdWq0juUPXJb7dYrpUl
 teSw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1784766300; x=1785371100;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:mime-version:references:in-reply-to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QK6NTIZ7U7u2uxukmeUbpT6BYUSoQRmwBsUnN+HFDzo=;
 b=l6e2hnh8PKji1A9dlZvEeL5xgErf264AZzCXadYEdv14FOER8uQ3vBJp/x9qeMF7sP
 XZ4G9gdV6EwGGPQ7B3abt7wEt0Ao1vTHNtpIDELcojrK+rVaxnLRA2TekPRwn3OdNSlX
 V+BO2U1FYp2y230mgaxzJV4PvO21RIGuoE72bwWO2KFyBxvtUEO8k2WxaHtoKsD1/mXp
 YMKO+logFRm/WDhd6HjIz4SvE4HdyKyEZk2cnQgI0toTpHcvGkf/oz/e2LNQeu2GVUU1
 05vXIY7T28aFPtemTpgmVrDjN60s2D05BegciC48zk0EUk6jGuIQ1XwUx1kBdB4N/oW8
 BK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784766300; x=1785371100;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:mime-version:references:in-reply-to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QK6NTIZ7U7u2uxukmeUbpT6BYUSoQRmwBsUnN+HFDzo=;
 b=YMKqbseqOlvaXlObuUTmCuy4IPk3by550vu0pA5h1N869gOH98LFW86cMQqdSy556G
 FMtJTwPfAbZetoF8sjiMXWObN7yXLZWvRQE9lYUn933jlhMxL7qSohgnkzBbkPyEKTGd
 JMBsldaGPAb/SLcavsBSUnb5ipr46ocsd3m2Za6/fxB3AznD34+aYWtnDOhZDK5Mq5rz
 zQjJQx1pmYrkHf+sikNQzQakSGi3bLmNGRgkl6VjKgZWoTdpS7b8dsbQ1wBZss2BorqM
 QCyUqH2/tHSRH1BlQCjZr+xuZ5CIhE1xQmWzhod5rYVF9pcxx8lAeGpuAJcw7FCK0ps6
 RaYA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rov3ITO+NOxo7/Xdti/g5Pwi7Y5U7dArMOIh16CcLgCsSlVhBLV9sD/gkAYQ62+lxxitU1CsDE8utg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz/INXi97rbvd/5cVdaUSsEmByL3ck7/QwebXYrEDs/K1blRQjo
 6NiYs0KkQcqcIJL62N81tkG6u2gOAeLq0i5oUm9x/XVV1iKnUuWWujSEES53EB5NWjDXfoVWfoA
 x6VR/xYjCOwMoG1Sua/Qq2QwuR2NPDSwWr42wPe8E
X-Gm-Gg: AR+sD10vB4EtOGdVXbxx19cQqEmTd8s4fURbVRk35yJesuevkvIh4/VrI48HeU92ZoF
 uEYpH5V2jgIF60iDHOXaW+S5NspPMrXNBRoEH4o3oeu4lPEFNdOpoNp3sWeY2p2zSlbKiYPlktc
 W3JFp2/u1ZNqOqzepC60QhWZ8u/vRb72zVRKF9JqjYq/KNtLL5jd6WSQ55GibMm1PiC7aZThYl9
 ECsXWhprExOcTtf631Tgd/qv96ll/gooJ7DJKMtvNx2Y5sKiF24Gllc4PQj5EktH7RBaF3qvm0G
 SxKzjviC6YJIOc65DUCYXIREgiCxt2uv6nqnfrR82hDIIAlB
X-Received: by 2002:a17:90b:4c10:b0:381:5bd6:eb19 with SMTP id
 98e67ed59e1d1-38ec652509dmr815476a91.18.1784766299151; Wed, 22 Jul 2026
 17:24:59 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Jul 2026 17:24:58 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Jul 2026 17:24:58 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260720111259.122911-1-dwmw2@infradead.org>
References: <20260720111259.122911-1-dwmw2@infradead.org>
MIME-Version: 1.0
Date: Wed, 22 Jul 2026 17:24:58 -0700
X-Gm-Features: AUfX_mwUpcRZcR396JGdaH8WFVBtAEhVFxsR1fJihR2mu_ygz-fygFCraN7fXhg
Message-ID: <CAEvNRgG-K2HOJoMmdMSH0gEuLNhgX2tqUAakoRqEx6noNyU3vg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/11] KVM: Allow alternative providers of
 guest_memfd backed by PFNMAP memory
To: David Woodhouse <dwmw2@infradead.org>,
 Sean Christopherson <seanjc@google.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, 
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Tom Lendacky <thomas.lendacky@amd.com>, Tycho Andersen <tycho@kernel.org>,
 Kees Cook <kees@kernel.org>, 
 Ashish Kalra <ashish.kalra@amd.com>, Connor Williamson <connordw@amazon.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Zhou Yuhang <zhouyuhang@kylinos.cn>,
 Zi Li <zi.li@linux.dev>, Dan Williams <djbw@kernel.org>,
 Eric Biggers <ebiggers@kernel.org>, 
 Colin Ian King <colin.i.king@gmail.com>, connordw@amazon.co.uk, graf@amazon.de,
 fgriffo@amazon.co.uk
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

David Woodhouse <dwmw2@infradead.org> writes:

> For dedicated hosting environments, there are a few reasons to prefer
> using external PFNMAP memory for guests, rather than kernel-managed
> memory:
>
>  =E2=80=A2 No struct page overheads
>
>  =E2=80=A2 Easily managed in 1GiB pages (or larger chunks); no fragmentat=
ion/THP
>
>  =E2=80=A2 Faster kexec/KHO live update (every millisecond spent faffing =
around
>    with memory management is an extra millisecond of steal time taken
>    from guests)
>

Also, no need to split/merge pages when converting from private to
shared if the host mappings can't depend on the refcounts in struct
pages :).

> Today, there is only one implementation of guest_memfd: the internal
> shmem-based page cache in virt/kvm/guest_memfd.c. This series allows
> for other code to provide "a guest_memfd". This is an early path-
> finding proof of concept tested with AMD SEV-SNP as well as non-CoCo
> guests on x86 and arm64. I'm planning to build a memory-based file
> system which gives files for both guest_memfd as well as memory-based
> storage to allow things like userspace VM and orchestrator state
> to be passed over KHO/kexec.
>

Thanks for raising this, good to know that there is more interest!

Vishal and I have been working on guest_memfd with HugeTLB for a while
now. I'll be restarting upstream work on HugeTLB after the conversions
series merges.

Vishal, Frank and I brought up having guest_memfd with HugeTLB with
VM_PFNMAP mappings at a guest_memfd biweekly meeting a while ago. The
consensus was that guest_memfd HugeTLB must support GUP and so VM_PFNMAP
can't be the only way that guest_memfd supports HugeTLB.

Your proposal is true non-page-struct memory, which has been on the
discussion guest_memfd biweekly discussion backlog for a while
now. Google is definitely also interested in this.

Frank also described some use cases [1] other than HugeTLB and the
regular PAGE_SIZE pages from the buddy that is currently supported.

I submitted a proposal for LPC 2026 to discuss the interface. What I had
in mind was to have the KVM_GUEST_MEMFD_CREATE ioctl take a "template"
fd. guest_memfd will then read off what it needs from the "template" fd
(ops, like you have here), and the "template" fd could be VFIO [2] or
HugeTLB.

You have a provider_fd =3D open("/dev/gmem_provider"), how about passing
that provider_fd to guest_memfd, where /dev/gmem_provider could
represent the page-less memory, like:

  ioctl(kvm_fd, KVM_GUEST_MEMFD_CREATE, provider_fd);

It would be cool if the fallback could be set up flexibly, like:

  ioctl(kvm_fd, KVM_GUEST_MEMFD_CREATE,
        [provider_fd, fallback_provider_fd, ...]);

I think guest_memfd should be the wrapper around other memory providers
because then the CoCo shared/private logic and special page table
handling for both host and stage 2 page tables is centralized in
guest_memfd, and also, KVM doesn't have to understand other, different
kinds of fds other than guest_memfd.

[1] https://lore.kernel.org/all/CAPTztWajm_JLpp9BjRcX=3Dh72r25ELrXeGkOXVach=
ybBxLJGS=3Dg@mail.gmail.com/
[2] https://lore.kernel.org/all/CAEvNRgFpJWQ5M5sQhGpQUV3GbBq9N+MQhhaxdxa=3D=
D8ky94SCsw@mail.gmail.com/

> This series lifts guest_memfd's operations into a small ops struct and
> converts KVM's own gmem to use it, so it becomes one implementation
> among peers rather than the only game in town.  It also adapts the
> SEV-SNP fast paths to page-less operation, plumbs iommufd to map a
> guest_memfd-backing dma-buf as CPU RAM (not MMIO), and adds the
> provider->KVM revocation primitive that makes overcommit-style reclaim
> possible.
>
> It's largely AI-built at the moment. My main design concerns are around
> how we tell that a given file is "a guest_memfd", and how we plug into
> IOMMUFD. Presenting a dma-buf was the less intrusive choice because that
> path already has support for taking pages away, but I'm less convinced
> that it's the cleaner choice in the long term.
>

IIUC from this series, you're creating a dmabuf fd out of a guest_memfd,
what does "taking pages away" mean, in this case, from where/who?

>
> [...snip...]
>
