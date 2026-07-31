Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF29C5516F
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 13:10:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1678F10F252;
	Fri, 31 Jul 2026 13:10:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="bFXbcDgd";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2538910F24F
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 13:10:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785503398; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Cq+zrzQoz00J2wlNPrXBe4dHSshzxf7DJsXSzdyM1dhrzXiOXivQ9GnF95OQuUyb6VSxXRzJ2QFWADOA3wb5XMjSjD6kZOx7xaK9lj/Yfgdw50yq1bLoZ+oPcRkpD+VfwRp+bQi35nM3q0NfeYJpm+ob2JqZWUUO8mCEGE87MUw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785503398;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=gGSgysdGBniHJR9h7AGR/IccbsptGQN5ulgBb8yos5g=; 
 b=fVK/MdqbhBPuyKWj797w54MesVOIEs/S3U1uK5zwJCWBA89OZVsUkvE3WoVHfMbBWc3cyM//vQApFuo66puuxwHx7ufaNAqycTlo2VSYaFepASKn7+tFIX6L3NXA8yWTXxNvEbB56mNNn/sfyVygEFqPNkwl1zchdCQY2Dofmag=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785503397; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=gGSgysdGBniHJR9h7AGR/IccbsptGQN5ulgBb8yos5g=;
 b=bFXbcDgdz+ZI1krxPJZfO4Rt2IgTzmjuIGQwkE7gE3R8u//X5q5H/Oap3o+hx8J+
 zgs5pXBl99TvR/Mx+Qs0Rgo1wM4yDBHEMXydCkxC/jpejI2yGP2kTCsTWIZ9c/Lmz5X
 CMWCAGghBmzri88XJ1WytKJkkBcO6gODE1w0OIaY=
Received: by mx.zohomail.com with SMTPS id 1785503396790153.8585271194745;
 Fri, 31 Jul 2026 06:09:56 -0700 (PDT)
Date: Fri, 31 Jul 2026 06:09:55 -0700
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, laura.nao@collabora.com,
 samitolvanen@google.com, lyude@redhat.com, beata.michalska@arm.com,
 boris.brezillon@collabora.com, steven.price@arm.com, alvin.sun@linux.dev
Subject: Re: [PATCH v10 4/7] drm/tyr: add GPU virtual memory (VM) support
Message-ID: <amyeozYr_SZC5FbY@um790>
References: <20260728-fw-boot-b4-v10-0-9187aefa3f2f@collabora.com>
 <20260728-fw-boot-b4-v10-4-9187aefa3f2f@collabora.com>
 <CAH5fLgjDoWT09Kdp0Jtg=XtmWVdnUM71yT_TsQG+TX1RJ6GqaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgjDoWT09Kdp0Jtg=XtmWVdnUM71yT_TsQG+TX1RJ6GqaQ@mail.gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/285.486.37
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

On Thu, Jul 30, 2026 at 04:40:36PM +0200, Alice Ryhl wrote:
> On Tue, Jul 28, 2026 at 8:39 PM Deborah Brouwer
> <deborah.brouwer@collabora.com> wrote:
> >
> > From: Boris Brezillon <boris.brezillon@collabora.com>
> >
> > Add GPU virtual address space management using the DRM GPUVM framework.
> > Each virtual memory (VM) space is backed by ARM64 LPAE Stage 1 page tables
> > and can be mapped into hardware address space (AS) slots for GPU execution.
> >
> > The implementation provides memory isolation and virtual address
> > allocation. VMs support mapping GEM buffer objects with configurable
> > protection flags (readonly, noexec, uncached) and handle both 4KB and 2MB
> > page sizes. A new_dummy_object() helper is provided to create a dummy GEM
> > object for use as a GPUVM root.
> >
> > The vm module integrates with the MMU for address space activation and
> > provides map/unmap/remap operations with page table synchronization.
> >
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Co-developed-by: Daniel Almeida <daniel.almeida@collabora.com>
> > Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> > Co-developed-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> > Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> 
> There's a 32-bit build failure :(
> 
> error[E0308]: mismatched types
>    --> /home/runner/work/linux/linux/linux/drivers/gpu/drm/tyr/vm.rs:873:17
>     |
> 871 |             pt.map_pages(
>     |                --------- arguments to this method are incorrect
> 872 |                 curr_iova,
> 873 |                 curr_paddr,
>     |                 ^^^^^^^^^^ expected `u32`, found `u64`
>     |
> note: method defined here
>    --> /home/runner/work/linux/linux/linux/rust/kernel/iommu/pgtable.rs:152:19
>     |
> 152 |     pub unsafe fn map_pages(
>     |                   ^^^^^^^^^
> help: you can convert a `u64` to a `u32` and panic if the converted
> value doesn't fit
>     |
> 873 |                 curr_paddr.try_into().unwrap(),
>     |                           ++++++++++++++++++++

Alice, I see you fixed it in drm-rust-next by casting curr_paddr to
PhysAddr, thank you. I must have added this 32 bit regression trying to
double check all of the sizes.

