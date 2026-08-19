Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E5EC5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 17:39:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 643C710E586;
	Wed, 19 Aug 2026 17:39:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hbX4jVUn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9904010E586
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 17:39:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 48AE343CBE;
 Wed, 19 Aug 2026 17:39:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5CEA1F000E9;
 Wed, 19 Aug 2026 17:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787161179;
 bh=iN+hiM+3JMDjP2NfDW+7Ol9SfU4AO+AYnVcz05YGMrw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hbX4jVUn7imvgKGh0rvciSSVCcZH2rrJ654jg/+q0UXhFU39kpnLK6qvjA8OUorhN
 MfpY5LTeia6IDog6vN1dO3ZeKrJqGhTe4CPXOylGxm7L8itTwalzpeUhO2geTmXEWB
 HKxdNKsrTMQEFs44K8HIpjAy/mBH80vgJ4SLXnAr0kaTFrw92lFuv9FUWJ0QI9UOwM
 nXb8FDpe4RC2qP3xxzblJs/7TeRmo9Gn2iVqPGaAuuERt6d1iNg18Sh7WslYc4fyKs
 KpEj1YoZKvAhjOuj4dKJirHUk6KsUPIoOjheEW5GCizDtlcf85dp8whBJBRswztfhi
 d/pXPxXRNXlPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] gpu: nova-core: fix barrier usage in CPU->GSP
 messaging path
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260819-rust-barrier-v3-1-d5b7bd7e6624@garyguo.net>
References: <20260819-rust-barrier-v3-0-d5b7bd7e6624@garyguo.net>
 <20260819-rust-barrier-v3-1-d5b7bd7e6624@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 17:39:38 +0000
Message-Id: <20260819173938.E5CEA1F000E9@smtp.kernel.org>
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
- [High] Missing LOAD->LOAD DMA memory barrier in the GSP->CPU receive path=
, risking stale data reads.
- [High] Use of CPU-centric `fence(Ordering::SeqCst)` instead of a DMA barr=
ier in `advance_cpu_read_ptr`.
--

--- Patch [1]: [PATCH v3 1/2] gpu: nova-core: fix barrier usage in CPU->GSP=
 messaging path ---
commit 4ff1d5624b6cb01f484147f0e0780dbdb7b0b09e
Author: Gary Guo <gary@garyguo.net>

gpu: nova-core: fix barrier usage in CPU->GSP messaging path

In the CPU->GSP messaging path, the code reads the read pointer from GSP,
writes the command, advances the write pointer, and then notifies the GSP.
This commit adds a load-to-store ordering, and moves a store-to-store
ordering to occur before the write pointer advance.

> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> index 6da728201281b..70674d2d0f77e 100644
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
[ ... ]
> @@ -450,9 +459,6 @@ fn advance_cpu_write_ptr(&mut self, elem_count: u32) {
>          let tx =3D io_project!(self.0, .cpuq.tx);
>          let wptr =3D MsgqTxHeader::write_ptr(tx).wrapping_add(elem_count=
) % MSGQ_NUM_PAGES;
>          MsgqTxHeader::set_write_ptr(tx, wptr);
> -
> -        // Ensure all command data is visible before triggering the GSP =
read.
> -        fence(Ordering::SeqCst);
>      }
>  }

[Severity: High]
This is a pre-existing issue, but I noticed there might be a missing
load-to-load DMA memory barrier in the GSP to CPU receive path.

When the driver receives a message via wait_for_msg(), it polls the GSP
write pointer by calling driver_read_area(), which reads the pointer using
io_read!. After the pointer indicates new data is available, the CPU direct=
ly
reads the message payload without any intervening memory barrier:

drivers/gpu/nova-core/gsp/cmdq.rs:driver_read_area() {
    ...
        let tx =3D self.gsp_write_ptr();
        let rx =3D self.cpu_read_ptr();

        // Pointer to the first entry of the GSP message queue.
        let data =3D ptr::project!(self.0.as_ptr(), .gspq.msgq.data[build: =
0]);

        let (tail_end, wrap_end) =3D if rx <=3D tx {
    ...
}

drivers/gpu/nova-core/gsp/cmdq.rs:wait_for_msg() {
    ...
        )
        .map(|(slice_1, slice_2)| (slice_1.as_flattened(), slice_2.as_flatt=
ened()))?;

        // Extract the GspMsgElement.
        let (header, slice_1) =3D GspMsgElement::from_bytes_prefix(slice_1)=
.ok_or(EIO)?;
    ...
}

On weakly-ordered architectures, can the CPU speculatively execute the payl=
oad
data reads from the coherent DMA buffer before the read of the updated write
pointer has completed? Does this require a read-to-read DMA barrier (e.g.,
dma_mb(Read)) after reading the write pointer and before accessing the
payload?

[Severity: High]
This is also a pre-existing issue, but since the patch removes a CPU-centric
fence above, I noticed that advance_cpu_read_ptr() still uses one where a D=
MA
barrier might be required:

drivers/gpu/nova-core/gsp/cmdq.rs:advance_cpu_read_ptr() {
    ...
        let rptr =3D MsgqRxHeader::read_ptr(rx).wrapping_add(elem_count) % =
MSGQ_NUM_PAGES;

        // Ensure read pointer is properly ordered.
        fence(Ordering::SeqCst);

        MsgqRxHeader::set_read_ptr(rx, rptr)
    ...
}

In Rust, fence(Ordering::SeqCst) only provides an SMP-domain barrier. Since
the queue is in coherent DMA memory shared with a device, could the GSP
observe the advanced read pointer and overwrite the message payload while t=
he
CPU is still reading it?

Should this use an Outer Shareable DMA barrier (like dma_mb(Full)) instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-rust-barri=
er-v3-0-d5b7bd7e6624@garyguo.net?part=3D1
