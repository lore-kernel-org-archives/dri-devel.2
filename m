Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B36C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 17:20:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9605C10E302;
	Tue, 21 Jul 2026 17:20:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="CqOvPwkC";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3A6810E302
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 17:20:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784654408; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gu6ypIdUo0m4p90s4NY7H+kIqE2m5CND7YhlbmrAvW28qySeF5m4AWM/AYvWUkqmEyJlznfcwsqA7y2rqi27TLKoIh23ge1Md0N0AFQlXjTJy81KlpJKXXpDKZD4D9z3OlCLhQVVa3R3vWKaEREgUz3/x31UyoaXncL7YbLmW28=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784654408;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=3IFTtKqOr9leQrMbDlhMJR+aZYBToo/sh601db/ZS5U=; 
 b=X9pK5YR6QT8x8U+84ifZ/h9w/Jud3SDfSTkrGVD8JKTBT5bV89IyzTJJNRubfax0OZTsdBX0hdxPRkXG0KGJ3WkyXCsK45Xl1MFsgXz1H0GTTFmAORFXU4cyV3ONiYqPHm5psU2C4/wcwQHYnqGpcnE5eNzN28F0GL2WJgd2Fkg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784654408; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=3IFTtKqOr9leQrMbDlhMJR+aZYBToo/sh601db/ZS5U=;
 b=CqOvPwkC+3euNMX/W2/7R+ji0ldRIXABPKlzdiP7Os9QTR9Apsoup3RTNXzPVNTa
 szcctUg8R0ZE9nrMl5H3YTvdUUtNn7eVF00A8ZLRxQAtjw9uliaW+OXwhG8S0MDVN1S
 VB0aa/OQ+Gn4NipmT+MPVCwyrB5otDk3Fn9lEI2g=
Received: by mx.zohomail.com with SMTPS id 1784654406804295.1237993084542;
 Tue, 21 Jul 2026 10:20:06 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v7 5/7] drm/tyr: add a kernel buffer object
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260713-fw-boot-b4-v7-5-afd8dc1494dd@collabora.com>
Date: Tue, 21 Jul 2026 14:19:48 -0300
Cc: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, boris.brezillon@collabora.com,
 samitolvanen@google.com, work@onurozkan.dev, acourbot@nvidia.com,
 lyude@redhat.com, laura.nao@collabora.com, beata.michalska@arm.com,
 alvin.sun@linux.dev, steven.price@arm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <2F098DC1-22C5-43DF-A178-F5AA823DCE4C@collabora.com>
References: <20260713-fw-boot-b4-v7-0-afd8dc1494dd@collabora.com>
 <20260713-fw-boot-b4-v7-5-afd8dc1494dd@collabora.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
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



> On 14 Jul 2026, at 00:18, Deborah Brouwer =
<deborah.brouwer@collabora.com> wrote:
>=20
> Introduce a buffer object type (KernelBo) for internal driver =
allocations
> that are managed by the kernel rather than userspace.
>=20
> KernelBo wraps a GEM shmem object and automatically handles GPU =
virtual
> address space mapping during creation and unmapping on drop. This =
provides
> a safe and convenient way for the driver to both allocate and clean up
> internal buffers for kernel-managed resources.
>=20
> Co-developed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> ---
> drivers/gpu/drm/tyr/gem.rs | 101 =
+++++++++++++++++++++++++++++++++++++++++++--
> 1 file changed, 97 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs
> index c28be61a01bb..47a05a33388e 100644
> --- a/drivers/gpu/drm/tyr/gem.rs
> +++ b/drivers/gpu/drm/tyr/gem.rs
> @@ -4,18 +4,29 @@
> //! This module provides buffer object (BO) management functionality =
using
> //! DRM's GEM subsystem with shmem backing.
>=20
> +use core::ops::Range;
> +
> use kernel::{
>     drm::gem::{
>         self,
>         shmem, //
>     },
>     prelude::*,
> -    sync::aref::ARef, //
> +    sync::{
> +        aref::ARef,
> +        Arc, //
> +    }, //
> };
>=20
> -use crate::driver::{
> -    TyrDrmDevice,
> -    TyrDrmDriver, //
> +use crate::{
> +    driver::{
> +        TyrDrmDevice,
> +        TyrDrmDriver, //
> +    },
> +    vm::{
> +        Vm,
> +        VmMapFlags, //
> +    },
> };
>=20
> /// Tyr's DriverObject type for GEM objects.
> @@ -56,3 +67,85 @@ pub(crate) fn new_dummy_object(ddev: &TyrDrmDevice) =
-> Result<ARef<Bo>> {
>=20
>     Ok(bo)
> }
> +
> +/// Specifies how to choose a GPU virtual address for a [`KernelBo`].
> +/// An automatic VA allocation strategy will be added in the future.
> +pub(crate) enum KernelBoVaAlloc {
> +    /// Explicit VA address specified by the caller.
> +    #[expect(dead_code)]
> +    Explicit(u64),
> +}
> +
> +/// A kernel-owned buffer object with automatic GPU virtual address =
mapping.
> +///
> +/// This structure represents a buffer object that is created and =
managed entirely
> +/// by the kernel driver, as opposed to userspace-created GEM =
objects. It combines
> +/// a GEM object with automatic GPU virtual address (VA) space =
mapping and cleanup.
> +///
> +/// When dropped, the buffer is automatically unmapped from the GPU =
VA space.
> +pub(crate) struct KernelBo<'bound> {
> +    /// The underlying GEM buffer object.
> +    #[expect(dead_code)]
> +    pub(crate) bo: ARef<Bo>,

Can we make this private?

> +    /// The GPU VM this buffer is mapped into.
> +    vm: Arc<Vm<'bound>>,
> +    /// The GPU VA range occupied by this buffer.
> +    va_range: Range<u64>,
> +}
> +
> +impl<'bound> KernelBo<'bound> {
> +    /// Creates a new kernel-owned buffer object and maps it into GPU =
VA space.
> +    ///
> +    /// This function allocates a new shmem-backed GEM object and =
immediately maps
> +    /// it into the specified GPU virtual memory space. The mapping =
is automatically
> +    /// cleaned up when the [`KernelBo`] is dropped.
> +    #[expect(dead_code)]
> +    pub(crate) fn new(
> +        ddev: &TyrDrmDevice,
> +        vm: Arc<Vm<'bound>>,
> +        size: u64,
> +        va_alloc: KernelBoVaAlloc,
> +        flags: VmMapFlags,
> +    ) -> Result<Self> {
> +        if size =3D=3D 0 {
> +            pr_err!("Cannot create KernelBo with size 0\n");
> +            return Err(EINVAL);
> +        }
> +
> +        let KernelBoVaAlloc::Explicit(va) =3D va_alloc;
> +
> +        let bo =3D Bo::new(
> +            ddev,
> +            size as usize,

As a general rule, let=E2=80=99s try our best to reduce the number of =
`as` casts. Let=E2=80=99s go with
usize::try_from

> +            shmem::ObjectConfig {
> +                map_wc: true,
> +                parent_resv_obj: None,
> +            },
> +            BoCreateArgs { flags: 0 },
> +        )?;
> +
> +        vm.map_bo_range(&bo, 0, size, va, flags)?;
> +
> +        Ok(KernelBo {
> +            bo,
> +            vm,
> +            va_range: va..(va + size),
> +        })
> +    }
> +}
> +
> +impl Drop for KernelBo<'_> {
> +    fn drop(&mut self) {
> +        let va =3D self.va_range.start;
> +        let size =3D self.va_range.end - self.va_range.start;
> +
> +        if let Err(e) =3D self.vm.unmap_range(va, size) {
> +            pr_err!(
> +                "Failed to unmap KernelBo range {:#x}..{:#x}: =
{:?}\n",
> +                self.va_range.start,
> +                self.va_range.end,
> +                e
> +            );
> +        }
> +    }
> +}
>=20
> --=20
> 2.54.0
>=20

