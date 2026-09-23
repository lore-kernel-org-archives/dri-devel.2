Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2B9C9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:42:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B82B10F19F;
	Wed, 23 Sep 2026 20:42:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="gK9GgW7F";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71BDD10F19F
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 20:42:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790196154; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=J8Qty4xuAwmy9p1FDA6M4MKIbduEQW68wW5K4RMKvg8qAeHjvbdt6gLa560gn5SKk1/3ODoSz+B2LiVShTnEffY774x4pasKBFCtCaWX0DMMZzQRqYxO27sWZqCxf6F3iNts4KA0msRVm/K5Umrv+AasYLLUCBFALEgb3a3u9os=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790196154;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=xo7cgqIIFuStSgCn4luUGcQPHzo3wUQwdn1Qq+BTVqQ=; 
 b=VBP0PCfW+ucS19AZr6VA2IULlPDugAlAIpeQwf0OWzJJEfklrHFGXPKce+yFKmMbUa4yoOjafYG8YkUU5dykK4KC2vX+B+Y/3fCU9SRlk1waiQeEQw4fUQ5LqUr8loaVKY01yAFrKHztVNX79a+vqpFBuXel2u7bS92KclvLlLw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790196154; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=xo7cgqIIFuStSgCn4luUGcQPHzo3wUQwdn1Qq+BTVqQ=;
 b=gK9GgW7FLv0FVaPmeWXVOMiQb9TTQjskMlrMhkP8EZyo/jX1CKGHWQ0N4vnJzwr2
 8I0KBZ0v6hseD7/Xhwd52EoxDtpeeUnNiz14hQfR+09smb7Gc+miE9elMMzw7lsXhGQ
 pCmhQUJi9rL9Nfsfu8+xvXlvBOBhewEkTfu6U2ZM=
Received: by smtp.zohomail.com with SMTPS id 1790196153019663.532298405788;
 Wed, 23 Sep 2026 13:42:33 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH 4/9] drm/tyr: add McuVa and claim-checked MappedBo views
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260915-tyr-interfaces-v1-4-5d28f1f75aca@collabora.com>
Date: Wed, 23 Sep 2026 17:42:13 -0300
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Thomas Gleixner <tglx@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org,
 kernel@collabora.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <C027787C-A04B-40AC-B0EF-62F0BBC156F9@collabora.com>
References: <20260915-tyr-interfaces-v1-0-5d28f1f75aca@collabora.com>
 <20260915-tyr-interfaces-v1-4-5d28f1f75aca@collabora.com>
To: Laura Nao <laura.nao@collabora.com>
X-Mailer: Apple Mail (2.3901.100.1.1.11)
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

Hi Laura,

It=E2=80=99s been a while since I wrote this, and I now see this could =
use some
improvements.

I think the first problem is that this conflates "MappedBo" with "the =
MappedBo
backing the shared region". As soon as we try to add more users, this =
will be a
problem. I propose that we split this into two types that build upon =
each other:

a) a generic layer MappedBo, which remains roughly as-is:

gem.rs:

pub(crate) struct MappedBo<'drm> {
  vmap: shmem::VMapOwned<BoData>,
  bo: KernelBo<'drm>,
}

impl<'drm> MappedBo<'drm> {
  // pub(crate) API:

  // no Arc, McuMappedBo has to hold it by value, otherwise a second =
holder
  // could write around the claims.
  fn new(bo: KernelBo<'drm>) -> Result<Self>
  fn va_range(...) -> ...
  fn vmap(...) -> ...
}

impl Deref for MappedBo<'_> { type Target =3D Bo ... }


b) A MCU-specific BO type with the claims + offset logic:

fw/mcu_bo.rs:

pub(super) struct McuVa(...) + related McuVa impls.

#[pin_data]
pub(super) struct McuMappedBo<'drm> {
  bo: MappedBo<'drm>, // private, no accessor

  #[pin]
  claims: Mutex<KVec<Range<u64>>>
}

impl<'drm> McuMappedBo<'drm> {
  // pub super API

  // builds its own MappedBo, checks the 32-bit range before allocating =
and
  // copies the section data from the fw binary before any view can =
exist.
  new(ddev, mcu_vm: Arc<Vm<'drm>>, va: McuVa, size: u64, flags: =
VmMapFlags,
      data: &[u8]) -> Result<impl PinInit<Self,Error>> {...}

  // views borrow: &'a self instead of self: &Arc<Self>
  fn try_view<'a>(&'a self, va: McuVa, len: u64, reach: u64)
      -> Result<McuView<'a>>
  fn try_view_mut<'a>(&'a self, va: McuVa, len: u64, reach: u64)
      -> Result<McuViewMut<'a>>
}

c) Views get renamed to McuView, McuViewMut:

#[derive(Clone)]
pub(super) struct McuView<'a> {
  vmap: &'a VMapOwned<BoData>,
  base: u64,
  range: Range<u64>,
  reach: u64, // <=E2=80=94=E2=80=94=E2=80=94=E2=80=94 Store this
}

pub(super) struct McuViewMut<'a> {
  view: McuView<'a>,
  claims: &'a Mutex<KVec<Range<u64>>>,
}

impl<'a> Deref for McuViewMut<'a> {
  type Target =3D McuView<'a>;
  fn deref(&self) -> &Self::Target {
    &self.view
  }
}

impl Drop for McuViewMut<'_> {
  // return claim here.
}


>=20
> +// SAFETY: `MappedBo` may move between threads: the CPU mapping's =
address is
> +// valid from any thread; `KernelBo`'s teardown (GPU unmap through =
`Arc<Vm>`
> +// and the GEM object release) goes through thread-safe C APIs; and =
the only
> +// interior mutability (`claims`) is mutex-protected.
> +unsafe impl Send for MappedBo<'_> {}
> +// SAFETY: `&MappedBo` exposes the mutex-protected claims table, the =
`Deref`
> +// surface to the GEM object (thread-safe C APIs), and the mapping =
itself,
> +// whose contents are only ever accessed through volatile operations. =
The
> +// memory is shared with the MCU by design, so concurrent access is =
part of
> +// the model rather than a race the type system must rule out.
> +unsafe impl Sync for MappedBo<'_> {}


I don=E2=80=99t think we need a manual implementation here.

The rest of the patch looks good to me.

=E2=80=94 Daniel


