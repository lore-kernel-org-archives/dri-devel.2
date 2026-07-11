Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8802C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 01:57:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F348510E286;
	Sat, 11 Jul 2026 01:57:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="k4zEEJ/I";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 758C210E286
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 01:57:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1783735041; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YOOXsfWNurUB7U6xaTiLZN2mdbXZ6J7cxNrFmFPPvaQUF5og/+/OxV31HD5GdxpQYvNXBXZx4Efgoyh4D77eX/FOA4ssZUksQTJPPQ52gxJ92lWti691BQ+b96oUBtZBFy8BwK/U5i7EQ/I7PrtSY0KlkSVVlmRUft8BqrjLw50=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783735041;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=a3swyPTykbuD+CwqZCknMVLw1USPNnXvjXdGLga/u/8=; 
 b=XctaSMeg28CHEj9Me6/xGVG6QXL8T6g+sGyTcdIeWP1hCKwMIKerzdEDoo9kwBIXIYPucDZoIzn0Q4XCrPjT3b80D7F+DdbdFQEn2QHSd1mdXAx7sfl3Sr/4RoIGbjOvuGk+2NIhHHOAGpaazDKkxcJ/0EbuezUZSCqZfjKKqGA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783735041; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
 bh=a3swyPTykbuD+CwqZCknMVLw1USPNnXvjXdGLga/u/8=;
 b=k4zEEJ/IwKT0fkBVSqVH69yP5lFTtbQolmmH/7VSP3YcVqYDKv5jFPklMr/jtrko
 C73mXfJJn1tGi4T53bxKbK80MQKBqKm1Grw8qGA+bHWdbPJpzONOT8arCqfOgB9I5c8
 PvLsocRoJB1gRZIhAZoQeSt05nnqBDWnT0br3xfw=
Received: by mx.zohomail.com with SMTPS id 1783735040661684.9698758517445;
 Fri, 10 Jul 2026 18:57:20 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 16/20] rust: io: add `read_val` and `write_val`
 functions on `Io`
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260706-io_projection-v6-16-72cd5d055d54@garyguo.net>
Date: Fri, 10 Jul 2026 22:56:59 -0300
Cc: Alice Ryhl <aliceryhl@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Michal Wilczynski <m.wilczynski@samsung.com>,
 =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5D0DCE0B-2F9D-4B12-9C1E-3FB6EC61129A@collabora.com>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-16-72cd5d055d54@garyguo.net>
To: Gary Guo <gary@garyguo.net>
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



> On 6 Jul 2026, at 09:44, Gary Guo <gary@garyguo.net> wrote:
>=20
> Provide `read_val` and `write_val` that allow I/O views to be accessed =
when
> they're narrowed down to just views of primitives.
>=20
> This is used to provide `io_read!` and `io_write!` macros, which are
> generalized version of current `dma_read!` and `dma_write!` macro that =
work
> for all types that implement `Io`.
>=20
> Note though `io_read!` and `io_write!` only works if backend =
implements
> `IoCapable` for the type; which is typically only implemented for
> atomically accessible primitives. `dma_read!` and `dma_write!` =
currently
> supports them via `read_volatile` and `write_volatile`; this can be
> undesirable for aggregates as LLVM may turn them to multiple =
instructions
> to access parts and re-assemble, even if they could be combined to a =
single
> instruction. Thus, `io_read!()` and `io_write!()` does not fully =
replace
> `dma_read!()` and `dma_write!()` in this scenario. The ability to
> read/write aggregates (when atomicity is of no concern) is better =
served
> with copying primitives (e.g. memcpy_{from,to}io).
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
> rust/kernel/io.rs | 106 =
++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 106 insertions(+)
>=20
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index 78c6ae2a0db8..c423125870b7 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -398,6 +398,50 @@ fn try_cast<U>(self) -> Result<<Self::Backend as =
IoBackend>::View<'a, U>>
>         Ok(unsafe { Self::Backend::project_view(view, ptr.cast()) })
>     }
>=20
> +    /// Read a value from I/O.
> +    ///
> +    /// This only works for primitives supported by the I/O backend.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```no_run
> +    /// # use kernel::io::*;
> +    /// # fn test_read_val(mmio: Mmio<'_, u32>) {
> +    /// // let mmio: Mmio<'_, u32>;
> +    /// let val: u32 =3D mmio.read_val();
> +    /// # }
> +    /// ```
> +    #[inline]
> +    fn read_val(self) -> Self::Target
> +    where
> +        Self::Backend: IoCapable<Self::Target>,
> +        Self::Target: Sized,
> +    {
> +        Self::Backend::io_read(self.as_view())
> +    }
> +
> +    /// Write a value to I/O.
> +    ///
> +    /// This only works for primitives supported by the I/O backend.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```no_run
> +    /// # use kernel::io::*;
> +    /// # fn test_write_val(mmio: Mmio<'_, u32>) {
> +    /// // let mmio: Mmio<'_, u32>;
> +    /// mmio.write_val(1u32);
> +    /// # }
> +    /// ```
> +    #[inline]
> +    fn write_val(self, value: Self::Target)
> +    where
> +        Self::Backend: IoCapable<Self::Target>,
> +        Self::Target: Sized,
> +    {
> +        Self::Backend::io_write(self.as_view(), value)
> +    }
> +
>     /// Fallible 8-bit read with runtime bounds check.
>     #[inline(always)]
>     fn try_read8(self, offset: usize) -> Result<u8>
> @@ -1229,3 +1273,65 @@ macro_rules! io_project {
> }
> #[doc(inline)]
> pub use crate::io_project;
> +
> +/// Read from I/O memory.
> +///
> +/// The syntax is of form `io_read!(io, proj)` where `io` is an =
expression to a type that
> +/// implements [`Io`] and `proj` is a [projection =
specification](kernel::ptr::project!).
> +///
> +/// # Examples
> +///
> +/// ```
> +/// #[repr(C)]
> +/// struct MyStruct { field: u32, }
> +///
> +/// # fn test(mmio: kernel::io::Mmio<'_, [MyStruct]>) -> Result {
> +/// // let mmio: Mmio<'_, [MyStruct]>;
> +/// let field: u32 =3D kernel::io::io_read!(mmio, [try: 2].field);
> +/// # Ok::<(), Error>(()) }
> +/// ```
> +#[macro_export]
> +#[doc(hidden)]
> +macro_rules! io_read {
> +    ($io:expr, $($proj:tt)*) =3D> {
> +        $crate::io::Io::read_val($crate::io_project!($io, $($proj)*))
> +    };
> +}
> +#[doc(inline)]
> +pub use crate::io_read;
> +
> +/// Writes to I/O memory.
> +///
> +/// The syntax is of form `io_write!(io, proj, val)` where `io` is an =
expression to a type that
> +/// implements [`Io`] and `proj` is a [projection =
specification](kernel::ptr::project!),
> +/// and `val` is the value to be written to the projected location.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// #[repr(C)]
> +/// struct MyStruct { field: u32, }
> +///
> +/// # fn test(mmio: kernel::io::Mmio<'_, [MyStruct]>) -> Result {
> +/// // let mmio: Mmio<'_, [MyStruct]>;
> +/// kernel::io::io_write!(mmio, [try: 2].field, 10);
> +/// # Ok::<(), Error>(()) }
> +/// ```
> +#[macro_export]
> +#[doc(hidden)]
> +macro_rules! io_write {
> +    (@parse [$io:expr] [$($proj:tt)*] [, $val:expr]) =3D> {
> +        $crate::io::Io::write_val($crate::io_project!($io, =
$($proj)*), $val)
> +    };
> +    (@parse [$io:expr] [$($proj:tt)*] [.$field:tt $($rest:tt)*]) =3D> =
{
> +        $crate::io_write!(@parse [$io] [$($proj)* .$field] =
[$($rest)*])
> +    };
> +    (@parse [$io:expr] [$($proj:tt)*] [[$flavor:ident: $index:expr] =
$($rest:tt)*]) =3D> {
> +        $crate::io_write!(@parse [$io] [$($proj)* [$flavor: $index]] =
[$($rest)*])
> +    };
> +    ($io:expr, $($rest:tt)*) =3D> {
> +        $crate::io_write!(@parse [$io] [] [$($rest)*])
> +    };
> +}
> +#[doc(inline)]
> +pub use crate::io_write;
>=20
> --=20
> 2.54.0
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

