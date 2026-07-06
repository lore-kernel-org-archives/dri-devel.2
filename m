Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD662C43602
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:07:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2455110E974;
	Mon,  6 Jul 2026 13:07:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="YslEi+dT";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A29110E974
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 13:07:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1783343253; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=IE14LecyLTUD2lB/rBI/sQhw9JBIkK+/rC9JEiYegJEji4MhbEKA/hjc5n77dQrUvSPeRvymwPEJmld5wm7FOvD4Z+MlulH0VRCNHUttb7gdHb0W1/JgtEHiA5g9WCk39Cz7J24S2HmN5LvOyjwHyF5xPr+OMpGYaR8Rdi24IjU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783343253;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=FMhFvIHqiFILIt2aMFGo+C0rD75x3q8QTjXzqy1UcXQ=; 
 b=gdbWFRB9Z+gyfIwYta2iE7fxgB47WxzAO1LCZyiTWCZxU5GxbP7baazddwpnBDwm7bnmjzWoh25cBtw5RpMHV99koLtDXT1Rg0LZdYdZOE+MNSIBYnYq99n6jgbCWswzdG8qhf64vSjjBmcUOVYrXfJZJWi6AF84RJguwy5643I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783343253; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
 bh=FMhFvIHqiFILIt2aMFGo+C0rD75x3q8QTjXzqy1UcXQ=;
 b=YslEi+dTSX0IlNbI9il2u9Yi6zXml0wF5x/6fFpVl/9w/1+CIhvK0D3QKNV4ggM3
 e2bmLV/Fi1c9IljRZ+VVdC05nYbHDTOlvoeOqRZxftJp4lsyB2VmX1L6rZsrJZR4U7h
 /xC6OafhWGrHde+rcf35M+tBLJj6KgPnljltiYEc=
Received: by mx.zohomail.com with SMTPS id 1783343250580972.9098538800296;
 Mon, 6 Jul 2026 06:07:30 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v5 0/5] rust / dma_buf: Add abstractions for dma_fence
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260703073141.3962604-2-phasta@kernel.org>
Date: Mon, 6 Jul 2026 10:07:10 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Asahi Lina <lina+kernel@asahilina.net>, Burak Emir <bqe@google.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Krishna Ketan Rai <prafulrai522@gmail.com>,
 Tamir Duberstein <tamird@kernel.org>, Mirko Adzic <adzicmirko97@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Shankari Anand <shankari.ak0208@gmail.com>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B9872CAD-C4F4-40C6-86FF-26559732419F@collabora.com>
References: <20260703073141.3962604-2-phasta@kernel.org>
To: Philipp Stanner <phasta@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External
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



> On 3 Jul 2026, at 04:31, Philipp Stanner <phasta@kernel.org> wrote:
>=20
> Changes since v4:
>  - Fix an uninitialized memory bug for FenceCbRegistration with
>    ManuallyDrop.
>  - Return FenceCtx as impl PinInit
>  - Make FenceCtx return an impl PinInit<T, Error> (Danilo)
>  - Reformat some comments
>  - Adjust the docu for rcu_barrier(), so that it matches the C side's
>    docu and our docu for rcu::synchronize_rcu().
>=20
> Changes since v3:
>  - Add a FIXME for an encountered Rust compiler bug. (Gary)
>  - Add new Rust files also to DRM drivers & common infrastructure
>    MAINTAINERS file. (Danilo)
>  - Reposition ECANCELED error code. (Miguel)
>  - Replace refcounted FenceCtx in DriverFenceData with a reference =
plus
>    life time. (Boris)
>  - Re-add rcu_barrier() patch, since we now can use it for dropping =
the
>    fence context. (Danilo)
>  - Add forgotten R-b from Alice, and Acks for MAINTAINERS from
>    Christian and Sumit.
>=20
> Changes since v2:
>  - Don't drop DriverFenceData as a whole, but only the members we
>    really want to drop. Gives more robustness. (Gary).
>  - Break apart large pin_init_from_closure(). (Danilo, Onur)
>  - Remove rcu_barrier() and synchronize_rcu() from FenceCtx::drop().
>    FenceCtx might drop in atomic context, where you must not perform
>    those operations. With the current way C dma_fence is designed, the
>    driver must wait for a grace period manually until it unloads.
>  - Repair the DriverFenceBorrow implementation, properly injecting a
>    life time into it. (Danilo)
>  - Fix memory layout bug for rcu_head. (Onur)
>  - Drop RCU patches, since this series doesn't need them anymore.
>=20
> Changes since v1:
>  - Remove unnecessary mutable references (Alice)
>  - Split up unsafe comments where possible (Danilo)
>  - Remove PhantomData + implement FenceCtx ops trait (Boris)
>  - Consistently call FenceCtx generic data `T`. FenceDataType is
>    derived from that. (Boris)
>  - Add abstractions for call_rcu() and synchronize_rcu() (Danilo)
>  - Add ECANCELED error code in Rust (Alice)
>  - Remove the rcu_barrier() from FenceCtx::drop() =E2=80=93 because we =
now use
>    call_rcu(), there can be no UAF access to the FenceCtx anymore. In
>    any case, it is illegal to use either call_rcu() or
>    synchronize_rcu() in FenceCtx::drop(), because our new
>    drop_driver_fence_data() can run in atomic context and might put =
the
>    last fence_ctx reference.
>    So we now only have to guard against module unload, which it seems
>    either the driver or Rust driver-core / module unload =
infrastructure
>    must solve.
>  - Minor formatting etc. changes
>  - Add C helpers to MAINTAINERS. (Danilo)
>  - Ensure that `Fence::is_signaled()` is fully synchronized, i.e., all
>    callbacks really have run. See [1] and [2]. (Myself, Christian
>    K=C3=B6nig)
>=20
> Changes since the RFCs:
>  - Include support for ForeignOwnable for ARef, so that a Fence can be
>    stuffed into an XArray et al. (Code by Danilo)
>  - Implement ForeignOwnable (with new borrow type) for DriverFence, so
>    that it can be stuffed into an XArray.
>  - Include the rcu::RcuBox data type to defer dropping data with RCU
>    (Cody by Alice)
>  - Port DmaFence to RcuBox to make UAF bugs through later, new =
dma_fence
>    callbacks (backend_ops) impossible.
>  - Force users to pass their fence data in an RcuBox (or have it not
>    need drop()) through a Sealed trait.
>  - Document the rules for the user's DriverFence::data's drop
>    implementation very clearly (deadlock danger).
>  - rustfmt, Clippy.
>  - Various style suggestions, safety comments, etc. (=C3=96nur)
>  - Add __rust_helper prefix to helper functions. (=C3=96nur)
>=20
> Changes in RFC v3:
>  - Omit JobQueue patches for now
>  - Completely redesign the memory layout: Instead of a Fence
>    refcounting a DriverFence, both now live in the same allocation to
>    allow for future support the dma_fence backend_ops callbacks which
>    need to do container_of. (mostly Boris's feedback)
>  - Allow for pre-allocating fences to avoid deadlocks when submitting
>    jobs to a GPU. (Boris)
>  - Simultaneously, allow for pre-preparing fence callback objects, so
>    the driver can allocate them when it sees fit. (code largely stolen
>    and inspired by Daniel).
>  - Signal fences on drop, ensure synchronization.
>  - Force users to set an error code when signalling.
>  - Write more documentation
>  - A ton of minor other changes.
>=20
>=20
> [1] =
https://lore.kernel.org/dri-devel/20260608142436.265820-2-phasta@kernel.or=
g/
> [2] =
https://lore.kernel.org/dri-devel/20260612104251.2264707-2-phasta@kernel.o=
rg/
>=20
>=20
> Alright, so since the last RFCs did not reveal significant design
> issues, I decided to transition this series to a v1 and hope that we =
can
> get it upstream.
>=20
> This now includes code for more common infrastructure that dma_fence
> needs, contributed by Danilo and Alice.
>=20
> ---
>=20
> Old cover letter for RFC:
>=20
> So, this is the spiritual successor of the first / second RFC [1]. v2
> also contained code for drm::JobQueue, but mostly to show how the =
fence
> code would be used. JobQueue is under heavy rework right now, so I =
don't
> want to bother your eyes with it. The docstring examples should show =
how
> Rust fences are supposed to be used, though.
>=20
> This v3 contains a huge amount of highly valuable feedback from a
> variety of people, notably Boris, but also from Alice, Gary and =
Danilo.
>=20
> There are some TODOs open (a better trait for fence backend_ops and =
RCU
> support), but my hope is that this effort is now finally approaching =
its
> end.
>=20
> I would greatly appreciate feedback and especially more information
> about what might be missing to make this usable, which is obviously
> where Daniel's and Boris's feedback will be valuable once more.
>=20
> Please regard this patch just as what it's titled: an RFC, to discuss =
a
> bit more and to inform a broader community about what the current =
state
> is and where this is heading at.
>=20
> Many regards,
> Philipp
>=20
> [1] =
https://lore.kernel.org/rust-for-linux/20260203081403.68733-2-phasta@kerne=
l.org/
>=20
> Danilo Krummrich (1):
>  rust: types: implement ForeignOwnable for ARef<T>
>=20
> Philipp Stanner (4):
>  rust: error: Add ECANCELED error code
>  rust: sync: Add abstraction for rcu_barrier()
>  rust: Add dma_fence abstractions
>  MAINTAINERS: Add entry for Rust dma-buf
>=20
> MAINTAINERS                      |   5 +
> rust/bindings/bindings_helper.h  |   1 +
> rust/helpers/dma_fence.c         |  48 ++
> rust/helpers/helpers.c           |   1 +
> rust/kernel/dma_buf/dma_fence.rs | 894 +++++++++++++++++++++++++++++++
> rust/kernel/dma_buf/mod.rs       |  14 +
> rust/kernel/error.rs             |   1 +
> rust/kernel/lib.rs               |   1 +
> rust/kernel/sync/aref.rs         |  40 ++
> rust/kernel/sync/rcu.rs          |  20 +
> 10 files changed, 1025 insertions(+)
> create mode 100644 rust/helpers/dma_fence.c
> create mode 100644 rust/kernel/dma_buf/dma_fence.rs
> create mode 100644 rust/kernel/dma_buf/mod.rs
>=20
>=20
> base-commit: a73a398a68ca9b9e5116a617562471f16b8310c4
> --=20
> 2.54.0
>=20

This works on Tyr :)

For the whole series:

Tested-by: Daniel Almeida <daniel.almeida@collabora.com>=
