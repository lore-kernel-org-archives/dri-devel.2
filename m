Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0883CDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:24:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DEC510EC93;
	Tue, 23 Jun 2026 20:24:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CkqvahlI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29F7D10EC93
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:24:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5C09660008;
 Tue, 23 Jun 2026 20:24:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CECC51F000E9;
 Tue, 23 Jun 2026 20:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782246260;
 bh=bccnjkky99zRnx2MagdHgHZShTE1Dq259J3eI7xY9dM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CkqvahlIXTaUzyOTP6KqOQtx8S6jaC4u/0z12CsD64pLZj5E8N5E008K53WI+4NrI
 3KAY1LwDM6yXSugaog0n3ptEOpgeCMe7+ensmnZTKOhV1sR4By0xSrbuiTcf/F1ZUP
 9y2NadeI9lXzvGtb4poSQUW5R7svP5/vtGYKt1xWl75lJ2iN/qzB0WUZBgP6QLgVMa
 jTafw0qwcDvw49sbgYv2R7pPyGHyGRpATecWWKOpJlRKD2uEJ35rRCEM2dHgTfyXyO
 398b0Fo7F3wnLBz6AiSHQY8DU2bKeknAOd39bkWN+0JCS9cG8PCll3IdkQIbwWyKQR
 K1XHuVDm6iXIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] gpu: nova-core: falcon: Move PFSP register
To: "Antonin Malzieu Ridolfi via B4 Relay" <devnull+dev.nanonej.com@kernel.org>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org,
 "Danilo Krummrich" <dakr@kernel.org>
In-Reply-To: <20260617-nova-core-regs-split-v1-5-4c7dc4450ea7@nanonej.com>
References: <20260617-nova-core-regs-split-v1-0-4c7dc4450ea7@nanonej.com>
 <20260617-nova-core-regs-split-v1-5-4c7dc4450ea7@nanonej.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 20:24:19 +0000
Message-Id: <20260623202419.CECC51F000E9@smtp.kernel.org>
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

New issues:
- [Low] The commit modifies import statements without migrating them to the=
 kernel's vertical import style.

Pre-existing issues:
- [High] FSP queue registers are defined as arrays of 8 elements without a =
`stride` parameter, defaulting to a 4-byte stride which silently overlaps w=
ith adjacent registers.
- [High] Unbounded allocation in `recv_msg` based on untrusted hardware inp=
ut can trigger an Out-of-Memory (OOM) condition or kernel panic.
--

commit 2170d35504c32c252c52eca31b351aad8e873b56
Author: Antonin Malzieu Ridolfi <dev@nanonej.com>

gpu: nova-core: falcon: Move PFSP register

This patch moves the PFSP register definitions into the falcon module and
updates the registers' visibility.

> diff --git a/drivers/gpu/nova-core/falcon/fsp.rs b/drivers/gpu/nova-core/=
falcon/fsp.rs
> index 52cdb84ef0e80..547843e6483c6 100644
> --- a/drivers/gpu/nova-core/falcon/fsp.rs
> +++ b/drivers/gpu/nova-core/falcon/fsp.rs
> @@ -26,10 +26,10 @@
>          Falcon,
>          FalconEngine,
>          PFalcon2Base,
> -        PFalconBase, //
> +        PFalconBase,
> +        regs, //
>      },
> -    num,
> -    regs, //
> +    num, //
>  };

[Severity: Low]
Does this import block need to be updated to match the kernel vertical impo=
rt
style? The Rust subsystem coding guidelines require flattening nested impor=
ts
when they are modified.

[ ... ]

> diff --git a/drivers/gpu/nova-core/falcon/regs.rs b/drivers/gpu/nova-core=
/falcon/regs.rs
> index 4d4e69b235fc6..81530abfb54c3 100644
> --- a/drivers/gpu/nova-core/falcon/regs.rs
> +++ b/drivers/gpu/nova-core/falcon/regs.rs

[ ... ]

> +register! {
> +    pub(super) NV_PFSP_QUEUE_HEAD(u32)[8] @ 0x008f2c00 {
> +        31:0    address =3D> u32;
> +    }
> +
> +    pub(super) NV_PFSP_QUEUE_TAIL(u32)[8] @ 0x008f2c04 {
> +        31:0    address =3D> u32;
> +    }

[Severity: High]
This is a pre-existing issue, but does NV_PFSP_QUEUE_HEAD need a stride
parameter?

Since the elements are 4 bytes, omitting the stride defaults it to 4 bytes.
This would place index 1 of NV_PFSP_QUEUE_HEAD at 0x008f2c04, which overlaps
with NV_PFSP_QUEUE_TAIL.=20

Should this be defined as [8, stride =3D 8] to prevent accessing the wrong
register for indices > 0?

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but is there an unbounded
allocation risk in recv_msg()?

Looking at fsp.rs, poll_msgq() derives the message size directly from
the hardware MMIO registers without bounds checking:

tail.saturating_sub(head).saturating_add(4)

This untrusted size is then used to allocate kernel memory:

drivers/gpu/nova-core/falcon/fsp.rs:recv_msg() {
    ...
    let mut buffer =3D KVec::<u8>::new();
    buffer.resize(msg_size, 0, GFP_KERNEL)?;
    ...
}

Could a compromised or misbehaving FSP firmware provide a massive message
size, exhausting kernel memory and triggering an OOM condition?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-nova-core-=
regs-split-v1-0-4c7dc4450ea7@nanonej.com?part=3D5
