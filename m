Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F314C531F8
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 16:01:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E231E10E5AC;
	Thu, 23 Jul 2026 16:01:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="vz0H/jsM";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 342D210E5AC
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 16:01:55 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-38dc69c74b8so779976a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 09:01:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784822514; cv=none;
 d=google.com; s=arc-20260327;
 b=M4eMuO/kwAFrdRdlFt88IpuIQ12iQrviw+iSO9npVas5GuG4isOs2/M46I51nL2KS5
 7L8sxIhGfx5TXU5Zonr25iEMYEbogNulNsuYhdjHeKmOCdNNKMaeDnZ8W+PCPzEox1zL
 BaFo9BG7rRjRnIKtWTp7cQqtFmsmTAR9bZHwPu6ykDRFV6tcIZXfS83HImoJsG9MDSsu
 0WjirEDXvv3AyRi63CTP9vIxUiyb5a95VxHGvDRuuhdc3nR2hLSn4NuxUwDOB7nD4+a+
 rWGEPlucPIrPDCzbJ82fjDktBFMgS3Dx9I+P/yt9Vird7JciN/CvkUmhChfp5TRxO428
 EmpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date
 :mime-version:references:in-reply-to:from:dkim-signature;
 bh=SzUUVckqYsDvAqBaHY0hD3E/5RcsItKvUC4bmUYmzx0=;
 fh=JpSG7F4xgM+SEjQT1SQb16AaFdZrxMugJins2XDxmTc=;
 b=Na7y0mpjrI81H3GNXWCCYmAH7C84gPHlLIctejxyXKhBWbNemvnDbWuf1rzKDCRcZO
 AEtZQZHem41kcNS3aMiD7yLCUpW0Wq8sNvP3nq5OBZLrCV+VzZpmc9U4bURLPFXqDEQK
 4/U+Ic4RDM9DZ8G0FK8Izd4snr6fWfrYhXKp8bS7HORfftFUa7nOo6rIRLOo1xEToTQi
 2eWqCo2wajmbMXICyamd++D6s/uaw1IK/NIabhlZXZ5rRtgP8Ix8ka9Ky0S+X8/d1vOO
 8xQhR34z3h3VuHfb7h5dr2hzxKjVtL9UCoczKNpM+8m6tcAZ6YO+wg9J+DanOKnlv7F/
 lcuw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1784822514; x=1785427314;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:mime-version:references:in-reply-to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SzUUVckqYsDvAqBaHY0hD3E/5RcsItKvUC4bmUYmzx0=;
 b=vz0H/jsMPdt1G9YrnLccbdDQRQzAc7fX8Msb3KnzC/IxRJGzYuySasJ3OuEUnC+6ss
 YTc3zfmKtB11ZiD7c4zqZ8z6RSVhooV5myjLwF5r8qBY8lnPSjC25bodx+tUNXUuRFsL
 e6GWHjebya5ES0pZwE7LLAZMikaiSxJR7srhXMrFLNBVb2qr7C+WWVMqaPVTFQB7hv7h
 B6T6Fnbp3J5ktCcxUAHzu1COQJwudY3ALpAol6UPoP335K8KR/dw6DVJlvTgHuvEgDNF
 jz4nCrqBSQqhV//bPbGj+T2EZBO1ZJNXJMoT1xpU9QU7twgPA+NMCVo9Yh4n599HLpLG
 bQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784822514; x=1785427314;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:mime-version:references:in-reply-to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SzUUVckqYsDvAqBaHY0hD3E/5RcsItKvUC4bmUYmzx0=;
 b=c5DW1TLxfTMNGq7+hiGeQKVZZDZ/LiPN/rquBGWFwRoGZi3HIkZCwf4+ZMOSVOqbkm
 A+OTjCLFVTdyraXb4k2/YFPxUdYp14OQxhHZVQoaqNeE1t1/ZRa0YAp6/DKPa8AuPDcO
 p1N7Vmkg8Poh1EZBhQybJWfirIuT7J4zIaOzesuRNmqFUI0shQrFB6AplTob3dpsFMvZ
 ZKrXg3QO64mcGxGcmhJCXYRXUc9rl2WRiZ/BS4MFWgmT/JHKrckuMX5HuWSqBl8nETbK
 TrOeBBPkmKBjpWIEpWLZ6X9pwY9c2cLqpqNl41vV173IPc03N0W5GxehhPvk3RG+ySkI
 4TbA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoS8hN3X0f4RfJeVGKaTxeJ+IGnej3W7rtrbhSs8NauMdWYNHouFpR86qiIIcAWoNHlejMfNMJIrq8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzSQGME3dBhoRN8n57LtK1EDXKGCCXOyr5tPw1hqdMqVeX0Rb4/
 oOREmV/342PQhDX7bWyXWtguyKxxonT0ZTEY45ImJGtcHyaI4l+9Q0ONrCmhy59gL71PtfQwiwC
 zCt3bjw3IZLaR78V8JD57c9CcmUnqlHZAcH+6PwNX
X-Gm-Gg: AR+sD13SMfCeaRuFVxckdqvsMEu5Fudd6i80NuxhYfevTzb37wUUVqk9kN7wd/iv9P0
 878IS4rIZFHj/ecQYQPdgY9k8RdkHf71chE0c0CJ1+OyPe++tKccak6pE/XkWsB4RjDjZYWM/Jf
 ihZSngtemkUizIYo3XPCALnf11hb19mrPaG2n+PNrb6V4ymdV5hGErnYR4qCVI39VRjB5bAOA7w
 g8qCOINrNhXALT3ciFctYv4LX20rJkaRXplgcbmZEzdy4rb202+q+bJbeA48IaOQ4lEOAWlwR+7
 QM4Sv/A2QtvDwgLX5Bz4W5+342wuQVTbxtennJN/tksXd7OF
X-Received: by 2002:a17:90b:4b49:b0:38e:4482:ab14 with SMTP id
 98e67ed59e1d1-38ec6a83858mr3735973a91.32.1784822512910; Thu, 23 Jul 2026
 09:01:52 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 23 Jul 2026 09:01:51 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 23 Jul 2026 09:01:51 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <1dc299af6b795a40c8887b3d84f915024f6446a9.camel@infradead.org>
References: <20260720111259.122911-1-dwmw2@infradead.org>
 <CAEvNRgG-K2HOJoMmdMSH0gEuLNhgX2tqUAakoRqEx6noNyU3vg@mail.gmail.com>
 <1dc299af6b795a40c8887b3d84f915024f6446a9.camel@infradead.org>
MIME-Version: 1.0
Date: Thu, 23 Jul 2026 09:01:51 -0700
X-Gm-Features: AUfX_myTsSnhFM4SYFjmYfmScbccXbA1Oof3z74v9KJmENsO0cIiQ5ipcuK-Wcg
Message-ID: <CAEvNRgEWOnZqiXMijZqggEi1hm14HxZ++9GpDRXUHqoE4UD6Bg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/11] KVM: Allow alternative providers of
 guest_memfd backed by PFNMAP memory
To: David Woodhouse <dwmw2@infradead.org>,
 Sean Christopherson <seanjc@google.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
 Xu Yilun <yilun.xu@linux.intel.com>
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

> On Wed, 2026-07-22 at 17:24 -0700, Ackerley Tng wrote:
>> David Woodhouse <dwmw2@infradead.org> writes:
>>
>> > For dedicated hosting environments, there are a few reasons to prefer
>> > using external PFNMAP memory for guests, rather than kernel-managed
>> > memory:
>> >
>> > =C2=A0=E2=80=A2 No struct page overheads
>> >
>> > =C2=A0=E2=80=A2 Easily managed in 1GiB pages (or larger chunks); no fr=
agmentation/THP
>> >
>> > =C2=A0=E2=80=A2 Faster kexec/KHO live update (every millisecond spent =
faffing around
>> > =C2=A0=C2=A0 with memory management is an extra millisecond of steal t=
ime taken
>> > =C2=A0=C2=A0 from guests)
>> >
>>
>> Also, no need to split/merge pages when converting from private to
>> shared if the host mappings can't depend on the refcounts in struct
>> pages :).
>>
>> > Today, there is only one implementation of guest_memfd: the internal
>> > shmem-based page cache in virt/kvm/guest_memfd.c. This series allows
>> > for other code to provide "a guest_memfd". This is an early path-
>> > finding proof of concept tested with AMD SEV-SNP as well as non-CoCo
>> > guests on x86 and arm64. I'm planning to build a memory-based file
>> > system which gives files for both guest_memfd as well as memory-based
>> > storage to allow things like userspace VM and orchestrator state
>> > to be passed over KHO/kexec.
>> >
>>
>> Thanks for raising this, good to know that there is more interest!
>>
>> Vishal and I have been working on guest_memfd with HugeTLB for a while
>> now. I'll be restarting upstream work on HugeTLB after the conversions
>> series merges.
>>
>> Vishal, Frank and I brought up having guest_memfd with HugeTLB with
>> VM_PFNMAP mappings at a guest_memfd biweekly meeting a while ago. The
>> consensus was that guest_memfd HugeTLB must support GUP and so VM_PFNMAP
>> can't be the only way that guest_memfd supports HugeTLB.
>>
>> Your proposal is true non-page-struct memory, which has been on the
>> discussion guest_memfd biweekly discussion backlog for a while
>> now. Google is definitely also interested in this.
>>
>> Frank also described some use cases [1] other than HugeTLB and the
>> regular PAGE_SIZE pages from the buddy that is currently supported.
>>
>> I submitted a proposal for LPC 2026 to discuss the interface. What I had
>> in mind was to have the KVM_GUEST_MEMFD_CREATE ioctl take a "template"
>> fd. guest_memfd will then read off what it needs from the "template" fd
>> (ops, like you have here), and the "template" fd could be VFIO [2] or
>> HugeTLB.
>>
>> You have a provider_fd =3D open("/dev/gmem_provider"), how about passing
>> that provider_fd to guest_memfd, where /dev/gmem_provider could
>> represent the page-less memory, like:
>>
>> =C2=A0 ioctl(kvm_fd, KVM_GUEST_MEMFD_CREATE, provider_fd);
>>
>> It would be cool if the fallback could be set up flexibly, like:
>>
>> =C2=A0 ioctl(kvm_fd, KVM_GUEST_MEMFD_CREATE,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [provider_fd, fallback_provid=
er_fd, ...]);
>>
>> I think guest_memfd should be the wrapper around other memory providers
>> because then the CoCo shared/private logic and special page table
>> handling for both host and stage 2 page tables is centralized in
>> guest_memfd, and also, KVM doesn't have to understand other, different
>> kinds of fds other than guest_memfd.
>
> Yeah. My approach was to make those "other kinds of fds" essentially
> the same =E2=80=94 they are "a guest_memfd", and KVM didn't have to under=
stand
> anything else (after a little bit of rework to have the generic ops so
> that other code can create its own guest_memfds). As opposed to the
> approach in Xu Yilun's TDISP series, which did teach KVM about a new
> kind of memslot.
>
> Likewise, I used dma-buf so that IOMMUFD didn't have to understand
> anything new either.
>
> I like your approach, inverting the wrapping of guest_memfd/dma-buf.
> The provider then gives a plain dma-buf (not associated with any KVM as
> it is in my current code). Userspace can use that *directly* with the
> IOMMU,

A wrinkle we will have to iron out is kind of the opposite problem, to
make sure that while guest_memfd thinks a range of offsets (PAGE_SIZE or
larger) is CoCo-private, the PFNs in that range must not be mapped
anywhere else in the host, or IOMMU.

One of the options I was thinking of was to seal off the template fd,
perhaps with an inode flag like S_IMMUTABLE, but not even allow reads,
and unlike S_IMMUTABLE, the (new) flag must not be changeable by
userspace.

Another option would be to just close the template fd so it'll not be
used, and the PFNs behind that template fd would just be completely in
guest_memfd ownership.

All non-guest_memfd paths to access the PFNs must be closed off, or
perhaps more precisely, any path that is not checked for
CoCo-shared/private status before building page table entries must be
closed off.

For CoCo-shared memory as tracked by guest_memfd (or non-CoCo, which
would use SHARED), the PFNs can still be mmap()-ed and actually set up
in userspace page tables.

Then, to use CoCo-shared memory for IO, IOMMUFD would also have to take
the guest_memfd (which IOMMUFD probably has to do, for CoCo-private
memory for Confidential IO, since CoCo-private memory can't be mapped to
userspace). Perhaps through IOMMU_IOAS_MAP_FILE?

In the process of mapping, IOMMUFD would tell guest_memfd "I have some
of your PFNs mapped.", and when guest_memfd gets a private->shared
conversion request, guest_memfd would get IOMMUFD to drop the
mappings. (perhaps some kind of MMU notifier setup)

Do you plan to use this for non-CoCo?

> and passes it to your KVM_GUEST_MEMFD_CREATE in order to get a
> guest_memfd for use with a given KVM. I think a lot of the warts in my
> series fall away if we do it that way round.
>
> I'll have a go at reworking it that way round... and see what different
> warts it ends up with. The interesting part will be getting actual PFNs
> out of the dma-buf (which is already under active discussion).
>

If we go with the above, IOMMUFD would get PFNs from guest_memfd instead
of dma-buf.

> I'm not sure I understand the 'fallback provider' part. If one provider
> doesn't have a page for a given address, KVM would iterate over them
> all until it finds one that does?

If each provider provides a .get_pfn() op, guest_memfd's
kvm_gmem_get_pfn() would try the first provider's .get_pfn() and if that
errors out, try the next one.

guest_memfd today uses a standard struct address_space to track the
pages that it owns. guest_memfd will have to use something else that can
track both pages and PFNs, and probably which provider it came from.

The more you probe me, the more complicated it's sounding. :) Still
worth pursuing if it's good to have though.

> Is that about falling back from one
> THP pool to another? Is this something that the generic KVM code needs
> to know about, or could it be handled *within* a provider, which can
> chain to the next pool if it can't find a page?

Handling that within a provider could be nice too, so instead of
guest_memfd trying .get_pfn()s in series, the provider will try a
hard-coded pair/list of PFN sources and then deal with the complexity
on behalf guest_memfd?

The flipside is for every combination of providers, the owner of the
virtualization service would have to maintain a custom kernel module for
the managing pages?

Maybe the flipside isn't too bad, actually, to provide more flexibility.

> Wouldn't we want that
> done transparently for both KVM and IOMMU consumers?
>
>>
>> [1] https://lore.kernel.org/all/CAPTztWajm_JLpp9BjRcX=3Dh72r25ELrXeGkOXV=
achybBxLJGS=3Dg@mail.gmail.com/
>> [2] https://lore.kernel.org/all/CAEvNRgFpJWQ5M5sQhGpQUV3GbBq9N+MQhhaxdxa=
=3DD8ky94SCsw@mail.gmail.com/
>>
>> > This series lifts guest_memfd's operations into a small ops struct and
>> > converts KVM's own gmem to use it, so it becomes one implementation
>> > among peers rather than the only game in town.=C2=A0 It also adapts th=
e
>> > SEV-SNP fast paths to page-less operation, plumbs iommufd to map a
>> > guest_memfd-backing dma-buf as CPU RAM (not MMIO), and adds the
>> > provider->KVM revocation primitive that makes overcommit-style reclaim
>> > possible.
>> >
>> > It's largely AI-built at the moment. My main design concerns are aroun=
d
>> > how we tell that a given file is "a guest_memfd", and how we plug into
>> > IOMMUFD. Presenting a dma-buf was the less intrusive choice because th=
at
>> > path already has support for taking pages away, but I'm less convinced
>> > that it's the cleaner choice in the long term.
>> >
>>
>> IIUC from this series, you're creating a dmabuf fd out of a guest_memfd,
>> what does "taking pages away" mean, in this case, from where/who?
>
> Taken away from the guest. Ballooning pages out, either for traditional
> memory overcommit, or for the models where a guest donates some of its
> pages to the system to run a "child" which is properly isolated from
> the guest.
>
> The physical page is reclaimed and needs to be taken out of the KVM and
> IOMMU stage2 mappings.

Will the VMM be doing a PUNCH_HOLE on the dma-buf fd or guest_memfd to
actually reclaim the page, or do you have something else in mind?

> If KVM wants to touch it again it must call the
> provider to get a new PFN for that range. This is roughly equivalent to
> the MMU notifier path on userspace VMAs in the normal memslot case.
> IOMMUFD has no equivalent of that for userspace addresses =E2=80=94
> IOMMU_IOAS_MAP pins the pages so they *can't* go away, which is why I
> used dma-buf for the IOMMUFD interface.
>
> I've actually been fleshing out the overcommit path a bit more,
> experimenting with adding async-pf support to guest_memfd in
> https://git.infradead.org/?p=3Dusers/dwmw2/linux.git;a=3Dcommitdiff;h=3D8=
94dd0fcb34
> (the sample provider just pretends its pages are slow to populate, so
> the guest gets to run something else while a "reclaimed" page comes
> back).
