Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC23AC44520
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 21:51:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D24410E1C8;
	Mon, 20 Jul 2026 21:51:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="vsgycYX7";
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90A4B10E1C8
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 21:51:09 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-c9e30214d8fso7552621a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 14:51:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784584269; cv=none;
 d=google.com; s=arc-20260327;
 b=JYjse3QXNOmIaAQsU+RNeGXn6osxyF+VrRS+WXtwA8iWMTqw+CYvUMPRzP0nRpQnNN
 QQhpgE1ipXsFDZztWRhcDClG2fsIdD6CAs7cgCoJcp0SKMgRryhbX3TNW1RS929cqFst
 BdoO3si8TApMXx1J1KLC0k9TC1or3B18EqI62Bdri6fJQhBi722qmWOXG9+NjIUBFoV+
 SsEsFSswb+itd1jXSghi4cLw5ntXMJOaRphN8aaE3BvsyLQ9EZENVFjtMN5VYtVHqtXv
 wHhY81Q2Nu84pioSwvqNpk30vW9XvTqwcNef/QOTwaeNWT/o09ys6vKBm7r+gngvI41s
 U8+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bdKI9817I2WeOtdz9Fsw1SXm2Wjzy1v2qUyVdVHNzDU=;
 fh=oTNtwhNhScpVx5TQ2RGScBFkv5tk5fFKAKChkeLFmAs=;
 b=PcqTWHskzMFLJaFKMmsJoiQkMfBhHaPw4CkT2KGcE0agXi8zfnfsb0tbBXamOYq8cw
 4BuzTdlVVgTDi3hnu0EdM6RQBmyQL2klmbFp/aewQ0MX3pL3F+GJFiJR7r5OZUe5ALva
 Wk1csXBCXqrkeWHt5vKvmaiZF2EVX4Gt63xT2bhmsQR6i5uuD1VuAhajZ3F5hMR5tAcB
 YfyQJhrYSF66++E5XLNsD9A+DTq1VDqlXq99ExwZRdSSb8hykfom+yHS+l1quCPXqME4
 nfa1rmYIASXzZ4snP/sswOXgdhHfZz/BZgcpjV2uOADtXoa0j5fVMKeLJhcmkgvYgTOm
 LaIQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1784584269; x=1785189069;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bdKI9817I2WeOtdz9Fsw1SXm2Wjzy1v2qUyVdVHNzDU=;
 b=vsgycYX7O5QP8NxNUHagaAbV8mPNi1EnZhbn75lsxMA1KCc4w95dvERkjkEFg9TxH0
 gKX2vkRDAmfhKquMZHoAKU6sh0uY8YzmuLEfkEd0cSzh7FpB05+uKlkxVzm2LngVdIiM
 3VNT6hAD2gFRnooRQ7he0Mjy41Xok24wfRj9p0k2zsmofRYpRBY6LFPs3R/juDQSodi5
 1g4krvp8vXCzwxJLjITYvdqUJUDLeT2OZOGUos14H1xYm1bnA8inioc0kgeTWOaaSlr5
 beAPYkserJ8Q9kldnFcY+lpCRR5jdPXiXQ+qA7GXm0kcpmtHzRYwahheyvQ8TiwTndHH
 SoVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784584269; x=1785189069;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bdKI9817I2WeOtdz9Fsw1SXm2Wjzy1v2qUyVdVHNzDU=;
 b=JdBH8iKaRkiYwUV68XAL16ZcogUwQ3lSEcmJ8TD94Gvw8SZS6Vs7dvHjeaDhBLGIGq
 KKAmQc+cYWU5as5H4kyiaoYoEJs5+ZSrpxHHaplSBqoqH/R4aZCMBV3HmpgETUvS3KZB
 1j93cov5B8DAvhbuBOct/mgzJINwtUPwNJ03A5qUZQaTb2Ezcv1H9Z10Jz6eGCSqgnUf
 MO/jOTgCR2pNpf10dfKdfnWjYHvTg9l7dLGh7ouGdo3EPhMmAMex6//0drUCT/BqpDgP
 Juu5yKKymHAPjTc4zcaizkbrgUAc0mpvaruT8PJSMsXOWkJ2ALyYgCYWb+1OGXI/mdyN
 cXUg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqdxVtKedVPPpF81L2x8xfoifXvGsLiMGyYD55J5y5go5vuRQEX5idmHLKUV2B//iDfDFF2y8AMHDA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxDQyMZ4ORXb8sv4WGjBObLidH1jG06UXXEdfkKxvz6nQdJ+JJu
 qdBXltRKv7aCT1je8Zk5xAlLql/p4KwUAqOfyIFpJfttW1EPIbup5btIAzPWHEKxfGZIhgR/qvA
 QkkVcH2Qt23yuTDkbvFsJj3vWd12TOvLa0RjdPdAf
X-Gm-Gg: AfdE7clENVBofJ0qJNmwU2KiD/MucpzPZ6XRZf7P6SyD+E7oSzqmFahC/nqBiBySFAn
 PVOcAxN1fJ+8WUpJrWFq3PAnpN3Sh1i1WQ6OBvEzpTVhdC9TqKv9hCuGbqwJC4T1dcksuyQQRq1
 I2wPC0QiWpkZQyOjJ2Q9WxNmB0ZriNfkWiPEhjmCvywnwZXjipnokZN9hHu1CUxdMPQ6/y2jD6A
 G/t+VezjQLaiCAtM6o2SdDjfc2IgPz23kOdYCK94LqUWSSG4BLMW4SdxqGW1tSLJo+oDJaDZnYh
 ZdvxL54=
X-Received: by 2002:a05:6a21:b94:b0:3bc:5284:5445 with SMTP id
 adf61e73a8af0-3c3ad7d7fc8mr17622851637.21.1784584268526; Mon, 20 Jul 2026
 14:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260715174737.15287-1-matt@ozlabs.org>
 <CALzav=fH7N+ionUnELqw5ZaGrPmgp_w6kxoCtoY8fMmZY_S4zw@mail.gmail.com>
 <65ba06e7-4c54-437d-9fbd-632c0468f66d@ozlabs.org>
 <allLypOmtbnPrgbw@google.com>
 <cc59a80f-afcc-4b2d-8e78-20f74c6b6871@ozlabs.org>
In-Reply-To: <cc59a80f-afcc-4b2d-8e78-20f74c6b6871@ozlabs.org>
From: David Matlack <dmatlack@google.com>
Date: Mon, 20 Jul 2026 14:50:41 -0700
X-Gm-Features: AUfX_mwkLBrmrzOblowqnnWuP3v7QICLsI9pjWJDYOH2ogP4CV4E0O_pKuQFz1Y
Message-ID: <CALzav=cGtmkBBpfUA8nP7AQ3azB_Hn7_8jJL=J+E+h61CpOFrw@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] vfio/pci: Add mmap() for DMABUFs
To: Matt Evans <matt@ozlabs.org>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, 
 Kevin Tian <kevin.tian@intel.com>, Pranjal Shrivastava <praan@google.com>, 
 Longfang Liu <liulongfang@huawei.com>, Mahmoud Adam <mngyadam@amazon.de>, 
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 kvm@vger.kernel.org, linux-pci@vger.kernel.org
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

On Fri, Jul 17, 2026 at 10:12=E2=80=AFAM Matt Evans <matt@ozlabs.org> wrote=
:
>
> Hi David,
>
> On 16/07/2026 22:23, David Matlack wrote:
> > On 2026-07-16 03:51 PM, Matt Evans wrote:
> >> Hi David,
> >>
> >> On 15/07/2026 19:12, David Matlack wrote:
> >>> On Wed, Jul 15, 2026 at 10:47=E2=80=AFAM Matt Evans <matt@ozlabs.org>=
 wrote:
> >>>
> >>>> This is based on v7.2-rc3.
> >>>>
> >>>> These commits are on GitHub for easier browsing, along with
> >>>> "[RFC ONLY] selftests: vfio: Add standalone vfio_dmabuf_mmap_test":
> >>>>
> >>>> https://github.com/metamev/linux/compare/v7.2-rc3...dev/mev/vfio-dma=
buf-mmap-v5
> >>>
> >>> It'd be great to have this test upstream. I'm happy to review it when
> >>> you're ready. Looks like it just needs to be redone to use the VFIO
> >>> selftests library and kselftests harness. AI could probably do the
> >>> conversion pretty quick :)
> >>
> >> For sure, I'd intended to catch up with you on best approach here. :)
> >>
> >> Aside from the organic structure of the test (the open-coded VFIO
> >> device/group setup/init needs to go), the main issue is that it relies
> >> on a hacked/out of tree QEMU "EDU++" device with a second larger BAR
> >> (containing freely read-writable memory).  A subset of tests run with
> >> the in-tree EDU device, but coverage is too low.
> >>
> >> The desirable properties are:
> >>
> >>  - Having a BAR that is pure memory (all locations present, writable
> >> without disruptive side-effects) so that mapping aliases can be
> >> constructed and detected.  This is good to test things like non-zero
> >> vm_pgoffs and VA space presentation of physically-discontiguous DMABUF=
s.
> >>
> >>  - BAR >> hugepage size so we can eyeball huge mappings work (or bette=
r,
> >>  mechanically test for them).  At least 32MB would tick this box for 4=
K,
> >> 16K page systems.
> >>
> >>  - Something QEMU supports*, so one can run the test in a VM/TCG syste=
m.
> >>
> >> There were some real device models in QEMU that could be used this way=
,
> >> but needed a fair bit of setup;  I didn't want to rathole
> >> vfio_dmabuf_mmap_test on including a ton of device-specific code for
> >> some video card or similar.
> >>
> >> I'll dig more for a simple target that provides these properties --
> >> obviously it would be better to point this test at an off-the-shelf
> >> device (including silicon!).  And, proposing EDU extensions to the QEM=
U
> >> folks may be useful (there're uses for a better EDU in other contexts =
too).
> >>
> >> Since this test uses MMIO for a specific [class of] function, my first
> >> thought is it should be another VFIO driver-type test sibling of
> >> vfio_pci_driver_test.  For example, we could extend the driver-type
> >> tests' backend struct vfio_pci_driver_ops for functions capable of
> >> providing a Big Memory BAR, like QEMU EDU++.  EDU can also memcpy, so
> >> could also support vfio_pci_driver_test.
> >>
> >> The spirit of the device backends hiding setup of a complex device is
> >> handy, and it's plausible that several backends could provide this "bi=
g
> >> memory BAR" service.  What do you think, any concerns with extending
> >> vfio_pci_driver_ops like that?
> >
> > I wouldn't recommend leveraging the driver framework unless absolutely
> > necessary. It makes the test harder to run.
> >
> > The biggest issue I see with the proposed properties is being able to
> > treat the BAR as memory. That obviously will depend on the device and
> > may require device-specific setup. If we decide that treating the BAR a=
s
> > memory is truly required then using the driver framework is the way to
> > go. But I'm hoping we can avoid that requirement.
> >
> > Instead, I think you can get pretty far by inspecting /proc/pid/pagemap
> > to determine if the mmap() set things up correctly, without actually
> > accessing the BAR. You can use /proc/pid/pagemap to look up the PFN and
> > PAGEMAP_SCAN to detect huge pages.
>
> Hmm, possible, although that's quite a different test at that point.  I
> agree never touching the device has advantages, but it's harder to test
> certain things if we _never_ do MMIO.  The mitigation effort to get
> coverage may not be the right tradeoff vs easier running.  I can think
> of some "easy" VFIO bugs that would be challenging to properly verify in
> userspace (e.g. PFNs all having some undesired offset).  The current
> test method is harder to fool per unit effort in writing it.
>
> Though, I will have a think about this no-touch flavour of test.
>
> What were you picturing regarding populating the VMA PTEs in order to
> inspect the result via /proc/pid/pagemap, whilst still upholding the
> principle of not touching the device?  For example,
> madvise(MADV_POPULATE_WRITE) won't work on the VFIO BAR regions because
> they're VM_PFNMAP/VM_IO.

You're right it looks like it's not possible to fault in the VMA
without reading or writing to the mapping. We could use reads, but I'm
not sure that's safe for all devices.

> > With that requirement gone, then all you really need is a device with a
> > large enough BAR. And even that it not a hard requirement. I'm sure
> > there are plenty of test cases that could work with smaller BARs. The
> > few tests that want to exercise huge mappings can inspect the device BA=
R
> > sizes first, and if they're all too small, SKIP() the test.
> >
> > If you structure the test this way, then it's easy for the test to be
> > used. It can be run against any device for the basic functional
> > coverage, and can be run against a device with a larger BAR for full
> > coverage of huge mappings.
> >
> > Does QEMU emulate any devices that have 32MB or larger BARs?
>
> Yep, looks like `-device pci-testdev,membar=3D64M,membar-backed=3Don` or
> even `-device bochs-display,vgamem=3D64M` would be suitable.
>
> So I'll also try moving the existing test over to one of these to at
> least remove the EDU++ device dependency.  (bochs-display has >1 BAR,
> and some MMIO regs which are nice for a quick kick-the-tyres access test.=
)

This seems like a good compromise.

I would suggest making the test as device-agnostic as possible so
other devices can be more easily added in the future. For example, add
a helper function to detect known "pure memory" BARs, so all
device-specific detection and setup logic can live there. We can put
that in the test .c file for now and move it to the library
if-and-when another test wants to use it. It probably makes sense to
merge this with the driver framework but I think I need to see more of
what's involved to really make a call.
