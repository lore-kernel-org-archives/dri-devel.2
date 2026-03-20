Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC8B109193F
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 12:54:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDD2310EAEE;
	Fri, 20 Mar 2026 12:54:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TfvvPfLJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 068AD10EAE8
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 12:54:29 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 93B4F4385A;
 Fri, 20 Mar 2026 12:54:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1619BC4CEF7;
 Fri, 20 Mar 2026 12:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774011268;
 bh=+M6qcQrMb3yqvBwU3Vq6wlNdSf3DZj0nu/V7zE51IKk=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
 b=TfvvPfLJjL+91s91n2gRFMntA85eHYefdoW3jBKajyP1eFnWU/jycj8tPkKg3/sOa
 OSSDkg/C2oGpFfdTpD+pdVWQIH7ImJRTCD8xpP88IHXTjxKpuJDdJ7o0NSgiVJ3mHd
 bOMMqp2fV9EtNbizJ/03wAzKKT+KqxoEqS0ZqaO7tmgJDdc7/J4Io9s9VPy5pX8j+z
 yrAveyY3cI4vqLL0w9cuA1tSs94nKm94cmHeoRwACFwspsCfkC4J2fJ3nPrw3CxEJs
 BKNaYcEnIjzPCkNGe1Cqd2dgJXfCnwMpktP0NiqM7oOBhUkGs0iF9tTzSPFfiHB70e
 h8CvC44/MWUXQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Mar 2026 13:54:24 +0100
Message-Id: <DH7MIC1ECKRZ.1YN5T4ATB7A2T@kernel.org>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Alistair Popple" <apopple@nvidia.com>,
 "John Hubbard" <jhubbard@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] gpu: nova-core: gsp: fix undefined behavior in command
 queue code
References: <20260319-cmdq-ub-fix-v1-1-0f9f6e8f3ce3@nvidia.com>
In-Reply-To: <20260319-cmdq-ub-fix-v1-1-0f9f6e8f3ce3@nvidia.com>
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

On Thu Mar 19, 2026 at 6:36 AM CET, Alexandre Courbot wrote:
> `driver_read_area` and `driver_write_area` are internal methods that
> return slices containing the area of the command queue buffer that the
> driver has exclusive read of write access, respectively.
>
> While their returned value is correct and safe to use, internally they
> temporarily create a reference to the whole command-buffer slice,
> including GSP-owned regions. These regions can change without notice,
> and thus creating a slice to them is undefined behavior.
>
> Fix this by replacing the slice logic with pointer arithmetic and
> creating slices to valid regions only. It relies on unsafe code, but
> should be mostly replaced by `IoView` and `IoSlice` once they land.
>
> Fixes: 75f6b1de8133 ("gpu: nova-core: gsp: Add GSP command queue bindings=
 and handling")
> Suggested-by: Danilo Krummrich <dakr@kernel.org>

Should be Reported-by:.

> Link: https://lore.kernel.org/all/DH47AVPEKN06.3BERUSJIB4M1R@kernel.org/

Should be Closes:.

> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  drivers/gpu/nova-core/gsp/cmdq.rs | 135 ++++++++++++++++++++++++++++----=
------
>  1 file changed, 100 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> index d36a62ba1c60..4200e7986774 100644
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
> @@ -251,38 +251,77 @@ fn new(dev: &device::Device<device::Bound>) -> Resu=
lt<Self> {
>      /// As the message queue is a circular buffer, the region may be dis=
contiguous in memory. In
>      /// that case the second slice will have a non-zero length.
>      fn driver_write_area(&mut self) -> (&mut [[u8; GSP_PAGE_SIZE]], &mut=
 [[u8; GSP_PAGE_SIZE]]) {
> -        let tx =3D self.cpu_write_ptr() as usize;
> -        let rx =3D self.gsp_read_ptr() as usize;
> +        let tx =3D num::u32_as_usize(self.cpu_write_ptr());
> +        let rx =3D num::u32_as_usize(self.gsp_read_ptr());
> +        // Number of pages between `tx` and the end of the command queue=
.
> +        // PANIC: Per the invariant of `cpu_write_ptr`, `tx < MSGQ_NUM_P=
AGES`.
> +        let after_tx_len =3D num::u32_as_usize(MSGQ_NUM_PAGES) - tx;
> =20
> +        // Pointer to the start of the CPU message queue.
> +        //
>          // SAFETY:
> -        // - The `CoherentAllocation` contains exactly one object.
> -        // - We will only access the driver-owned part of the shared mem=
ory.
> -        // - Per the safety statement of the function, no concurrent acc=
ess will be performed.
> -        let gsp_mem =3D &mut unsafe { self.0.as_slice_mut(0, 1) }.unwrap=
()[0];
> -        // PANIC: per the invariant of `cpu_write_ptr`, `tx` is `< MSGQ_=
NUM_PAGES`.
> -        let (before_tx, after_tx) =3D gsp_mem.cpuq.msgq.data.split_at_mu=
t(tx);
> +        // - `self.0` contains exactly one element.
> +        // - `cpuq.msgq.data[0]` is within the bounds of that element.
> +        let data =3D unsafe { &raw mut (*self.0.start_ptr_mut()).cpuq.ms=
gq.data[0] };
> =20
> -        // The area starting at `tx` and ending at `rx - 2` modulo MSGQ_=
NUM_PAGES, inclusive,
> -        // belongs to the driver for writing.
> +        // Safety/Panic comments to be referenced by the code below.
> +        //
> +        // SAFETY[1]:
> +        // - `data` points to an array of `MSGQ_NUM_PAGES` elements.
> +        // - The area starting at `tx` and ending at `rx - 2` modulo `MS=
GQ_NUM_PAGES`,
> +        //   inclusive, belongs to the driver for writing and is not acc=
essed concurrently by
> +        //   the GSP.
> +        // - `tx + after_tx_len` =3D=3D `MSGQ_NUM_PAGES`.
> +        //
> +        // PANIC[1]:
> +        // - Per the invariant of `cpu_write_ptr`, `tx < MSGQ_NUM_PAGES`=
.
> +        // - Per the invariant of `gsp_read_ptr`, `rx < MSGQ_NUM_PAGES`.

I didn't do the math, but can't we just calculate the offset values in the =
below
if-else-if-else blocks and call from_raw_parts_mut() once with the safety
comment above? I think that'd be much cleaner. Similar for
driver_write_area_size().

>          if rx =3D=3D 0 {
> -            // Since `rx` is zero, leave an empty slot at end of the buf=
fer.
> -            let last =3D after_tx.len() - 1;
> -            (&mut after_tx[..last], &mut [])
> +            (
> +                // SAFETY: See SAFETY[1].
> +                unsafe {
> +                    core::slice::from_raw_parts_mut(
> +                        data.add(tx),
> +                        // Since `rx` is zero, leave an empty slot at en=
d of the buffer.
> +                        // PANIC: See PANIC[1].
> +                        after_tx_len - 1,
> +                    )
> +                },
> +                &mut [],
> +            )
>          } else if rx <=3D tx {
>              // The area is discontiguous and we leave an empty slot befo=
re `rx`.
> -            // PANIC:
> -            // - The index `rx - 1` is non-negative because `rx !=3D 0` =
in this branch.
> -            // - The index does not exceed `before_tx.len()` (which equa=
ls `tx`) because
> -            //   `rx <=3D tx` in this branch.
> -            (after_tx, &mut before_tx[..(rx - 1)])
> +            (
> +                // SAFETY: See SAFETY[1].
> +                unsafe { core::slice::from_raw_parts_mut(data.add(tx), a=
fter_tx_len) },
> +                // SAFETY: See SAFETY[1].
> +                unsafe {
> +                    core::slice::from_raw_parts_mut(
> +                        data,
> +                        // Leave one empty slot before `rx`.
> +                        // PANIC:
> +                        // - See PANIC[1].
> +                        // - `rx - 1` is non-negative because `rx !=3D 0=
` in this branch.
> +                        rx - 1,
> +                    )
> +                },
> +            )
>          } else {
>              // The area is contiguous and we leave an empty slot before =
`rx`.
> -            // PANIC:
> -            // - The index `rx - tx - 1` is non-negative because `rx > t=
x` in this branch.
> -            // - The index does not exceed `after_tx.len()` (which is `M=
SGQ_NUM_PAGES - tx`)
> -            //   because `rx < MSGQ_NUM_PAGES` by the `gsp_read_ptr` inv=
ariant.
> -            (&mut after_tx[..(rx - tx - 1)], &mut [])
> +            (
> +                // SAFETY: See SAFETY[1].
> +                unsafe {
> +                    core::slice::from_raw_parts_mut(
> +                        data.add(tx),
> +                        // PANIC:
> +                        // - See PANIC[1].
> +                        // - `rx - tx - 1` is non-negative because `rx >=
 tx` in this branch.
> +                        rx - tx - 1,
> +                    )
> +                },
> +                &mut [],
> +            )
>          }
>      }
> =20
> @@ -308,24 +347,50 @@ fn driver_write_area_size(&self) -> usize {
>          let tx =3D self.gsp_write_ptr() as usize;
>          let rx =3D self.cpu_read_ptr() as usize;
> =20
> +        // Pointer to the start of the GSP message queue.
> +        //
>          // SAFETY:
> -        // - The `CoherentAllocation` contains exactly one object.
> -        // - We will only access the driver-owned part of the shared mem=
ory.
> -        // - Per the safety statement of the function, no concurrent acc=
ess will be performed.
> -        let gsp_mem =3D &unsafe { self.0.as_slice(0, 1) }.unwrap()[0];
> -        let data =3D &gsp_mem.gspq.msgq.data;
> +        // - `self.0` contains exactly one element.
> +        // - `gspq.msgq.data[0]` is within the bounds of that element.
> +        let data =3D unsafe { &raw const (*self.0.start_ptr()).gspq.msgq=
.data[0] };
> +
> +        // Safety/Panic comments to be referenced by the code below.
> +        //
> +        // SAFETY[1]:
> +        // - `data` points to an array of `MSGQ_NUM_PAGES` elements.
> +        // - The area starting at `rx` and ending at `tx - 1` modulo `MS=
GQ_NUM_PAGES`,
> +        //   inclusive, belongs to the driver for reading and is not acc=
essed concurrently by
> +        //   the GSP.
> +        //
> +        // PANIC[1]:
> +        // - Per the invariant of `cpu_read_ptr`, `rx < MSGQ_NUM_PAGES`.
> +        // - Per the invariant of `gsp_write_ptr`, `tx < MSGQ_NUM_PAGES`=
.
> =20
> -        // The area starting at `rx` and ending at `tx - 1` modulo MSGQ_=
NUM_PAGES, inclusive,
> -        // belongs to the driver for reading.
> -        // PANIC:
> -        // - per the invariant of `cpu_read_ptr`, `rx < MSGQ_NUM_PAGES`
> -        // - per the invariant of `gsp_write_ptr`, `tx < MSGQ_NUM_PAGES`
>          if rx <=3D tx {
>              // The area is contiguous.
> -            (&data[rx..tx], &[])
> +            (
> +                // SAFETY: See SAFETY[1].
> +                // PANIC:
> +                // - See PANIC[1].
> +                // - Per the branch test, `rx <=3D tx`.
> +                unsafe { core::slice::from_raw_parts(data.add(rx), tx - =
rx) },
> +                &[],
> +            )
>          } else {
>              // The area is discontiguous.
> -            (&data[rx..], &data[..tx])
> +            (
> +                // SAFETY: See SAFETY[1].
> +                // PANIC: See PANIC[1].
> +                unsafe {
> +                    core::slice::from_raw_parts(
> +                        data.add(rx),
> +                        num::u32_as_usize(MSGQ_NUM_PAGES) - rx,
> +                    )
> +                },
> +                // SAFETY: See SAFETY[1].
> +                // PANIC: See PANIC[1].
> +                unsafe { core::slice::from_raw_parts(data, tx) },
> +            )
>          }
>      }
> =20
>
> ---
> base-commit: a19457958c3018783881c4416f272cd594f13049
> change-id: 20260319-cmdq-ub-fix-d57b09a745b9
>
> Best regards,
> --=20
> Alexandre Courbot <acourbot@nvidia.com>

