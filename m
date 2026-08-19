Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899BFC5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 17:39:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA19E10E81B;
	Wed, 19 Aug 2026 17:39:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GMNhQuKW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F322010E81B
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 17:39:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1F85D6136F;
 Wed, 19 Aug 2026 17:39:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57531F000E9;
 Wed, 19 Aug 2026 17:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787161179;
 bh=ypIkeMy/Aem5Rv/Y107pvwNkjkKjFRLV4Utcqap6L+g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GMNhQuKWTq7ptN4dG1uSgFW0Lhi7/qI9Nkn4fznegvf/hdcQVN3M40FX6nNWNcEPm
 Xb1f3UIQDmZSgSAx3PwAVgglQrYYXeHAmElZUS6zuA5X/gHgBZl8RDTM5dLDkXMYaW
 cO1OHzSk8i4a4cKR/tykzm69OF8CqebxDoURHYxNqiVqrliX/wxPATQEso0JO/XEY+
 UBBSHBWdrPLNSazMeYogTWs6JOBAytxScJc3XU4DDv0J6Qod08YKbRFvRMltwFhZ95
 GuoUhojeXcDb4CWsg4/neo48W95gJtknJB9sS1nQtwqF/fbP/ILJTv6YYVSZOtOF2Y
 qrg2W6hzhurzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] gpu: nova-core: fix barrier usage in GSP->CPU
 messaging path
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260819-rust-barrier-v3-2-d5b7bd7e6624@garyguo.net>
References: <20260819-rust-barrier-v3-0-d5b7bd7e6624@garyguo.net>
 <20260819-rust-barrier-v3-2-d5b7bd7e6624@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 17:39:39 +0000
Message-Id: <20260819173939.A57531F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Early returns in message parsing skip advancing the CPU read point=
er, permanently wedging the command queue.
--

--- Patch [2]: [PATCH v3 2/2] gpu: nova-core: fix barrier usage in GSP->CPU=
 messaging path ---
commit fab176fb9e47452c5f023d1bbf02cec260583fbf
Author: Gary Guo <gary@garyguo.net>

gpu: nova-core: fix barrier usage in GSP->CPU messaging path

In the GSP->CPU messaging path, the code reads the write pointer from GSP,
reads the response and advances the read pointer.

A LOAD->LOAD ordering is required after the write pointer read and the data
read. Add it as this is currently missing.

A LOAD->STORE ordering is required after the data read and the advance of
read pointer. Currently a Rust `SeqCst` barrier is used, which roughly maps
to `smp_mb(Full)`; this however does not order DMA operations (notably on
ARM, the generate barrier orders inner shareable and not outer shareable,
which is ordered by `dma_mb`). This ordering does not need to be in between
read pointer read and write, because it's for ordering between the ring
buffer data and the pointer; the RMW operation does not internally need a
barrier (nor it has to be atomic, as CPU pointers are updated by CPU only),
so move it to before the RMW sequence for clarity.

Signed-off-by: Gary Guo <gary@garyguo.net>

> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> index 70674d2d0f77e..9fe393da6b10c 100644
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs

[ ... ]

> @@ -436,12 +434,11 @@ fn cpu_read_ptr(&self) -> u32 {
> =20
>      // Informs the GSP that it can send `elem_count` new pages into the =
message queue.
>      fn advance_cpu_read_ptr(&mut self, elem_count: u32) {
> +        // ORDERING: LOAD->STORE ordering needed to order `cpu_read_ptr`=
 write after data read.
> +        dma_mb(Full);
> +
>          let rx =3D io_project!(self.0, .cpuq.rx);
>          let rptr =3D MsgqRxHeader::read_ptr(rx).wrapping_add(elem_count)=
 % MSGQ_NUM_PAGES;
> -
> -        // Ensure read pointer is properly ordered.
> -        fence(Ordering::SeqCst);
> -
>          MsgqRxHeader::set_read_ptr(rx, rptr)
>      }

[Severity: High]
This isn't a bug introduced by this patch, but does CmdqInner::receive_msg()
skip advancing the CPU read pointer on parsing errors?

Looking at CmdqInner::receive_msg(), if the GSP sends a message with an
unrecognized function code or a truncated prefix, do the `?` operators
cause an early return?

drivers/gpu/nova-core/gsp/cmdq.rs:CmdqInner::receive_msg() {
        let message =3D self.wait_for_msg(timeout)?;
        let function =3D message.header.function().map_err(|_| EINVAL)?;

        // Extract the message. Store the result as we want to advance the =
read pointer even in
        // case of failure.
        let result =3D if function =3D=3D M::FUNCTION {
            let (cmd, contents_1) =3D M::Message::from_bytes_prefix(message=
.contents.0).ok_or(EIO)?;
        ...

If an early return happens here, self.gsp_mem.advance_cpu_read_ptr() at the=
 end
of the function is never called, despite the explicit comment's intent.

Will the unhandled message remain at the head of the queue, causing
subsequent calls to continually read the same bad message and fail again,
permanently wedging the message queue?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-rust-barri=
er-v3-0-d5b7bd7e6624@garyguo.net?part=3D2
