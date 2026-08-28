Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51391C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 05:49:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD02810F258;
	Fri, 28 Aug 2026 05:49:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KCRQ21/s";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C290B10F25C
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 05:49:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2DFD160A57;
 Fri, 28 Aug 2026 05:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 936DD1F000E9;
 Fri, 28 Aug 2026 05:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787896157;
 bh=gXqKDGy6bhxeRNNKuC8EXfkl2bPMYEYW4a1ZTgdsxkg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KCRQ21/s0SkUyB8lIQ0q3LnqujPyTp5FJGo2x+4zya/mMIJ8HNU8EFG4YF5ziNYE4
 zZg2oNH1qhvvognO5mN7DsrpAIO1L/QcbYYiNiJMrav/28DBrhJyA4LrbkTVYFBYA3
 uy2HkqZJom7XUniFH1gMrU1vOiFT/E+lgHLfZhu1Cjl9D8D+spyvOg81eCSuEh+H0/
 zJEKZp8kt8hDLWbuN1eJjLOx4onIEyTfMr4UBreHntJob0QuR34i4tiNeajFcafe0g
 TK6h8QZY2zLd7ousl9y6Oa3uBJYTigg7RwjUcVL2KMrijviXLJvtFEGaLl3o1y8OeD
 CfP3E1TMnmMgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] gpu: nova-core: use FromSafeCast wherever possible
To: "Alexandre Courbot" <acourbot@nvidia.com>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org,
 ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>
In-Reply-To: <20260828-nova_num-v1-2-e21f17ba4127@nvidia.com>
References: <20260828-nova_num-v1-0-e21f17ba4127@nvidia.com>
 <20260828-nova_num-v1-2-e21f17ba4127@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 05:49:17 +0000
Message-Id: <20260828054917.936DD1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing DMA write memory barrier before updating the GSP command q=
ueue write pointer.
- [High] Missing DMA read memory barrier after reading the GSP message queu=
e write pointer.
--

commit 899e3ba6af7f4cc7e2c28b0f4f3f73db18de1f16
Author: Alexandre Courbot <acourbot@nvidia.com>

gpu: nova-core: use FromSafeCast wherever possible

Replaces various *_as_* casting functions with FromSafeCast in
non-const contexts to simplify conversions.

> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> index f85fde09aa6e3..658d0a9b2cfb2 100644
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs

[ ... ]

> @@ -343,10 +346,10 @@ fn driver_write_area_size(&self) -> usize {
>          unsafe {
>              (
>                  core::slice::from_raw_parts(
> -                    data.add(casts::u32_as_usize(rx)),
> -                    casts::u32_as_usize(tail_end - rx),
> +                    data.add(usize::from_safe_cast(rx)),
> +                    usize::from_safe_cast(tail_end - rx),
>                  ),
> -                core::slice::from_raw_parts(data, casts::u32_as_usize(wr=
ap_end)),
> +                core::slice::from_raw_parts(data, usize::from_safe_cast(=
wrap_end)),
>              )
>          }
>      }

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing this
file I noticed a potential memory barrier issue in advance_cpu_write_ptr():

>     fn advance_cpu_write_ptr(&mut self, elem_count: u32) {
>         let tx =3D io_project!(self.0, .cpuq.tx);
>         let wptr =3D MsgqTxHeader::write_ptr(tx).wrapping_add(elem_count)=
 % MSGQ_NUM_PAGES;
>         MsgqTxHeader::set_write_ptr(tx, wptr);
>=20
>         // Ensure all command data is visible before triggering the GSP r=
ead.
>         fence(Ordering::SeqCst);
>     }

Because there is no memory barrier between the payload writes (done prior
to calling this function) and the write pointer volatile write in
MsgqTxHeader::set_write_ptr(), the CPU can reorder them.

If the GSP observes the updated write pointer before the payload writes
are globally visible, could it read stale command data?

[Severity: High]
This is also a pre-existing issue, but is there a missing read memory
barrier after reading the message queue write pointer in wait_for_msg()?

>     fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
>         // Wait for a message to arrive from the GSP.
>         let (slice_1, slice_2) =3D read_poll_timeout(
>             || Ok(self.gsp_mem.driver_read_area()),
>             |driver_area| !driver_area.0.is_empty(),
>             Delta::from_millis(1),
>             timeout,
>         )
>         .map(|(slice_1, slice_2)| (slice_1.as_flattened(), slice_2.as_fla=
ttened()))?;
>=20
>         // Extract the `GspMsgElement`.
>         let (header, slice_1) =3D GspMsgElement::from_bytes_prefix(slice_=
1).ok_or(EIO)?;

When polling for a new message, read_poll_timeout repeatedly evaluates
driver_read_area(), which performs a volatile read of the GSP write
pointer.

Once a new message is indicated, the payload memory slices are immediately
accessed.

Since there is no read memory barrier between the volatile read of the
write pointer and the payload access, could modern CPUs speculatively
execute the data loads before the write pointer read completes, causing
the driver to read stale payload data?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-nova_num-v=
1-0-e21f17ba4127@nvidia.com?part=3D2
