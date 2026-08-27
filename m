Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68025C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 09:09:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 886CB10E3B8;
	Thu, 27 Aug 2026 09:09:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FtZnkbl5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D3B810E33A
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 09:09:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ADBD3600D0;
 Thu, 27 Aug 2026 09:09:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B8F1F000E9;
 Thu, 27 Aug 2026 09:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787821781;
 bh=IpDSC/7wBzOyHkJ2sel6QQruxNxKDxHREvH9ybzZS14=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FtZnkbl5tnxBCFdsiix9N7GJo9kg3bf4TO1nFdvI98ofQrCjG72u6gxCGxaVzbpiC
 vKb5Yciy5xhwGDr3XC5/vLYrBLlmPeLsIhXqd/Eg7gb1i9cDD+iON9zBEFmqGC9seF
 Regimg12VIZt/M1/KtthgOUAXtcDbF9SasE4WZ2+xobZ4PhBXUmZ50yGsphexiwF4q
 RzD55Z1gKZFtvxDvc9wqSyI7vZPuJNReFn2ESPowmXNxuTvQO+xtMS831y3uCKtC6b
 1OqZY2FhHuMu5HNwIEGUTuvA2xn0Lvl0ic3AJAIYyCBvhAhOUa5V56vmeEzeP0IG5d
 0JpXM0W1wlVpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/10] gpu: nova-core: mm: Add support to use PRAMIN
 windows to write to VRAM
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>
In-Reply-To: <20260827-pramin-split-v3-6-24b24d7afc52@nvidia.com>
References: <20260827-pramin-split-v3-0-24b24d7afc52@nvidia.com>
 <20260827-pramin-split-v3-6-24b24d7afc52@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 09:09:40 +0000
Message-Id: <20260827090941.15B8F1F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Low] Compilation fails unconditionally because `kernel::io::register::Of=
fsetLoc` is missing from the kernel tree.
- [Low] The `io_project!` macro is invoked with unbracketed projection spec=
ifications, causing a compilation error.
- [Low] The `Drop` implementation for `PraminAccess` will fail to compile w=
ith a zero-sized type due to a const assertion failure in `cast::<u8>()`.
--

commit da741ebe3207f602c3f762361899c60fcf5605a3
Author: Joel Fernandes <joelagnelf@nvidia.com>

gpu: nova-core: mm: Add support to use PRAMIN windows to write to VRAM

This commit adds a Pramin manager to handle direct CPU read/write to VRAM
via PRAMIN apertures. It returns an MMIO view of VRAM and handles repositio=
ning
and alignment of the window.

> diff --git a/drivers/gpu/nova-core/mm/pramin.rs b/drivers/gpu/nova-core/m=
m/pramin.rs
> new file mode 100644
> index 0000000000000..20be3fc471ba3
> --- /dev/null
> +++ b/drivers/gpu/nova-core/mm/pramin.rs
> @@ -0,0 +1,178 @@
[ ... ]
> +use kernel::{
> +    io::{
> +        io_project,
> +        register,
> +        register::OffsetLoc,

[Severity: Low]
Does this code build? kernel::io::register::OffsetLoc appears to be missing
from the kernel tree.

> +        Io,
> +        Mmio, //
> +    },
[ ... ]
> +impl<T> Drop for PraminAccess<'_, T>
> +where
> +    T: FromBytes + IntoBytes,
> +{
> +    fn drop(&mut self) {
> +        // Insert an ordering point after previous writes through this w=
indow.
> +        self.view.cast::<u8>().read_val();

[Severity: Low]
Will this fail to compile if PraminAccess is instantiated with a zero-sized
type? Mmio::cast::<u8>() statically asserts that
size_of::<u8>() <=3D T::MIN_SIZE, which evaluates to 1 <=3D 0 for ZSTs and =
fails
during monomorphization.

> +    }
> +}
> +
> +impl<'gpu> Pramin<'gpu> {
[ ... ]
> +    pub(super) fn new(
> +        bar: Bar0<'gpu>,
> +        chipset: Chipset,
> +        vram_range: Range<VramAddress>,
> +    ) -> Result<Self> {
> +        let hal =3D hal::mm_hal(chipset);
> +        let window =3D io_project!(bar, build: PRAMIN);

[Severity: Low]
Is this macro syntax correct? The io_project! macro expects bracketed
syntax for array and offset projections. Should this be [build: PRAMIN]?

> +        let base =3D vram_range.start.align_down(Self::BASE_ALIGN);
[ ... ]
> +    pub(super) fn window_at<'a, T>(
> +        &'a mut self,
> +        vram_addr: VramAddress,
> +    ) -> Result<PraminAccess<'a, T>>
> +    where
> +        T: FromBytes + IntoBytes,
> +    {
> +        let offset =3D self.window_offset(vram_addr, size_of::<T>())?;
> +        let view =3D io_project!(self.window, try: OffsetLoc::new(offset=
));

[Severity: Low]
Does this also require bracketed macro syntax, like
[try: OffsetLoc::new(offset)]? Also, as noted above, OffsetLoc is missing
from the kernel tree.

> +
> +        Ok(PraminAccess { view })
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-pramin-spl=
it-v3-0-24b24d7afc52@nvidia.com?part=3D6
