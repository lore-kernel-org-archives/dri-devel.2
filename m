Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBC3CD98C5
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:49:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0363010E14B;
	Tue,  9 Jun 2026 15:49:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XIj/fVrF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CAF710E14B
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 15:49:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6632C4001A;
 Tue,  9 Jun 2026 15:49:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9911F00893;
 Tue,  9 Jun 2026 15:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781020194;
 bh=g1hpQTBaxPAGBs420FKPxuEagqz9araSXwGyFFSZ6wo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XIj/fVrF12A2k7YlCKnFfXw37ria1LK0CYHfHpNx5tKauv6rjhCPWV7P2T8rNy+CJ
 ZPrxfuNejGR0gCjsk8sUjNahZN+cgeDBrQ7ZY1+dnG4Fk5ms9oeOkDac7Tr+mZgeea
 eDjlbrO8V5Y4dh4v/3Aq1pP6kKYNpMKGto+HfExjlf6jnyBfMfh2QOiAb2JtHhqIpN
 6N8WryrxfS6lqqHR1+yibQ7XzHE54r2Z4z/Ovs9wqI5uyqqNyTVbndwQ948rWNdnml
 6BFa/dA0FBio8ZkUzqpkqQ630780GRRa80++CW/+3WEs5NUzrZvd2scDxmCCN3LIv/
 AzBFB+X+SDBuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] gpu: nova-core: fix barrier usage in GSP->CPU
 messaging path
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260609-rust-barrier-v2-4-30fcc48e1cd0@garyguo.net>
References: <20260609-rust-barrier-v2-4-30fcc48e1cd0@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 15:49:53 +0000
Message-Id: <20260609154954.0E9911F00893@smtp.kernel.org>
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
- [High] Early returns in `receive_msg` skip advancing the GSP read pointer=
, leading to a permanently stalled command queue.
- [High] CPU->GSP messaging path relies on a fragile control dependency for=
 memory ordering instead of an explicit DMA barrier.
--

commit 4410cc89c9104f4a90dab2676e5da7ce4fd1a204
Author: Gary Guo <gary@garyguo.net>

gpu: nova-core: fix barrier usage in GSP->CPU messaging path

This commit replaces the Rust SeqCst barrier with explicit dma_mb(Read) and
dma_mb(Full) barriers in the GSP->CPU messaging path. The SeqCst barrier do=
es
not correctly order DMA operations on architectures like ARM, so using the
proper dma_mb() ensures correct LOAD->LOAD and LOAD->STORE ordering.

> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> index 94c2790d943d0..229d49a670779 100644
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs

[ ... ]

> @@ -339,6 +341,9 @@ fn driver_write_area_size(&self) -> usize {
>              (MSGQ_NUM_PAGES, tx)
>          };
> =20
> +        // ORDERING: Ensure data load is ordered after load of GSP write=
 pointer.
> +        dma_mb(Read);
> +

[Severity: High]
This is a pre-existing issue, but since we are updating memory barriers her=
e,
does the CPU->GSP messaging path in driver_write_area() also need an explic=
it
barrier instead of relying on a fragile control dependency?

drivers/gpu/nova-core/gsp/cmdq.rs:driver_write_area() {
    ...
        let (tail_end, wrap_end) =3D if rx =3D=3D 0 {
            ...
        } else if rx <=3D tx {
            ...
        } else {
            ...
        };

        // ORDERING: control dependency provides necessary LOAD->STORE orde=
ring.
        // dma_mb(Full) may be used here if we don't want to rely on contro=
l dependency.
    ...
}

Relying on control dependencies for DMA memory ordering is unsafe in Rust,
as the compiler does not guarantee preserving them and may optimize away
branches (e.g., using conditional selects like csel on ARM64).

Control dependencies also do not emit architectural barriers (like dmb osh
on ARM64), which are necessary to order memory accesses across the system
interconnect for device memory.

If the CPU's store to the command buffer is observed by the GSP before the
CPU's load of rx, could the CPU overwrite data the GSP has not yet consumed?

Should an explicit dma_mb(Full) be added here to guarantee LOAD->STORE
ordering?

>          // SAFETY:
>          // - `data` was created from a valid pointer, and `rx` and `tx` =
are in the
>          //   `0..MSGQ_NUM_PAGES` range per the invariants of `gsp_write_=
ptr` and `cpu_read_ptr`,

[ ... ]

> @@ -436,6 +441,9 @@ fn cpu_read_ptr(&self) -> u32 {
> =20
>      // Informs the GSP that it can send `elem_count` new pages into the =
message queue.
>      fn advance_cpu_read_ptr(&mut self, elem_count: u32) {
> +        // ORDERING: Ensure read pointer is properly ordered with a LOAD=
->STORE ordering.
> +        dma_mb(Full);
> +
>          super::fw::gsp_mem::advance_cpu_read_ptr(&self.0, elem_count)
>      }

[Severity: High]
This is a pre-existing issue, but looking at how advance_cpu_read_ptr()
is used, do the early returns in receive_msg() skip advancing the GSP read
pointer?

drivers/gpu/nova-core/gsp/cmdq.rs:receive_msg() {
    ...
        let function =3D message.header.function().map_err(|_| EINVAL)?;

        // Extract the message. Store the result as we want to advance the =
read pointer even in
        // case of failure.
        let result =3D if function =3D=3D M::FUNCTION {
            let (cmd, contents_1) =3D M::Message::from_bytes_prefix(message=
.contents.0).ok_or(EIO)?;
    ...
        // Advance the read pointer past this message.
        self.gsp_mem.advance_cpu_read_ptr(...);
    ...
}

The comments note that the result is stored to ensure the read pointer is
advanced even on failure. However, the use of the ? operator on
message.header.function() and M::Message::from_bytes_prefix() causes an
immediate return.

If an early return happens here, will subsequent polls read the exact same
malformed message?

Could this cause repeated failures and a permanently stalled command queue?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-rust-barri=
er-v2-0-30fcc48e1cd0@garyguo.net?part=3D4
