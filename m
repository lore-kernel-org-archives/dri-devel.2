Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28DF5C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:22:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7625D10E93E;
	Mon, 29 Jun 2026 14:22:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YWh0cIpf";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E04F10E93E
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:22:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1457643AE4;
 Mon, 29 Jun 2026 14:22:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B368F1F00A3A;
 Mon, 29 Jun 2026 14:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782742969;
 bh=7HP7n/cd4lQpLhqSxGcOiQrxoMWKgp3W7yFlnpavk+M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YWh0cIpfegryCfOU+BriOYgAS1hdIZi36WeRbDI5RToQPLcTOYvp2KuyO7CphXMR1
 I3ZGQ4MTo1Im/9Wbi16Uu/ckpodprHh1ixV9Pt0ahgOGW/G89vL3tvOLMbZbGRMPpb
 g7KnE23Zg0h6e/AMWw6wPzFiCBwavrxbrU+uyaxuVGzY52Q/f4jj9AT/7m91Sm6B94
 tP9Q0WhPHliWR3Ml7O1oP1bFhhCfxAYbQEWXI8+vAV0nNTdk9YPpXs7B7I8U3PQ8S+
 BXTdPXrSSYkX/rsi/DEhEGsgG4Qp8oEEEMfJTL7OaTQ1txoFhd29t9Be7sbIN3cx1X
 Nsbj+IChMdThQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/13] gpu: nova-core: gsp: sequencer: use
 GspBootContext
To: "Alexandre Courbot" <acourbot@nvidia.com>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org,
 "Danilo Krummrich" <dakr@kernel.org>
In-Reply-To: <20260629-nova-bootcontext-v4-1-5539d8469590@nvidia.com>
References: <20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com>
 <20260629-nova-bootcontext-v4-1-5539d8469590@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 14:22:48 +0000
Message-Id: <20260629142248.B368F1F00A3A@smtp.kernel.org>
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

Pre-existing issues:
- [High] Incorrect loop bounds check causes RPC message padding bytes to be=
 executed as hardware sequencer commands (e.g., unintended RegWrite to addr=
ess 0).
- [High] Fixed-size zero-padded buffer bypasses length checks for truncated=
 commands, leading to execution of zeroed out-of-bounds payloads.
- [High] Unaligned stack array passed to `FromBytes::from_bytes` may cause =
spurious parsing failures and abort the GSP boot process depending on compi=
ler stack layout.
--

commit c264aea160f8cb747324a1d5a568d1e3a869623a
Author: Alexandre Courbot <acourbot@nvidia.com>

gpu: nova-core: gsp: sequencer: use GspBootContext

`GspBootContext` contains all the resources currently carried by
`GspSequencerParams`, so replace the latter with the former for better
integration with the boot process and less code.

> diff --git a/drivers/gpu/nova-core/gsp/sequencer.rs b/drivers/gpu/nova-co=
re/gsp/sequencer.rs
> index 13983d42b12bc..f55205bd61f35 100644
> --- a/drivers/gpu/nova-core/gsp/sequencer.rs
> +++ b/drivers/gpu/nova-core/gsp/sequencer.rs

[ ... ]

> @@ -335,24 +336,13 @@ fn iter(&self) -> GspSeqIter<'_> {
>      }
>  }

[Severity: High]
This is a pre-existing issue, but does this bounds check in GspSeqIter::nex=
t()
fail to prevent processing alignment padding bytes?

In drivers/gpu/nova-core/gsp/sequencer.rs:GspSeqIter::new(), total_cmds is
initialized using the length in DWORDs rather than the command count:

    GspSeqIter {
        ...
        total_cmds: self.seq_info.cmd_index,
        ...
    }

Then in GspSeqIter::next(), the loop bounds check compares commands process=
ed
against this DWORD count:

    if self.cmds_processed >=3D self.total_cmds ||
       self.current_offset >=3D self.cmd_data.len() {
        return None;
    }

If the message buffer contains RPC alignment padding (e.g., trailing zeros),
could cmds_processed fail to reach total_cmds, causing these zeros to be
incorrectly parsed as hardware sequencer commands (where opcode 0 is RegWri=
te
to address 0)?

[Severity: High]
This is a pre-existing issue, but does passing a zero-padded buffer bypass
the length check for truncated commands?

In drivers/gpu/nova-core/gsp/sequencer.rs:GspSeqIter::next(), a truncated
command is copied into a fixed 24-byte zero-initialized array, and a slice
covering the entire array is passed to GspSeqCmd::new():

    let mut buffer =3D [0u8; CMD_SIZE];
    ...
    buffer[..copy_len].copy_from_slice(
        &self.cmd_data[offset..offset + copy_len]
    );
    let cmd_result =3D GspSeqCmd::new(&buffer, self.dev);

Inside GspSeqCmd::new(), the length check evaluates data.len(), which will
always be 24 regardless of copy_len:

    if data.len() < size {
        dev_err!(dev, "Data is not enough for command\n");
        return Err(EINVAL);
    }

Could this allow execution of malformed, zero-padded hardware commands?

[Severity: High]
This is a pre-existing issue, but can the unaligned stack array passed to
FromBytes::from_bytes() cause spurious parsing failures?

In drivers/gpu/nova-core/gsp/sequencer.rs:GspSeqIter::next(), buffer is bac=
ked
by a u8 array which only guarantees 1-byte alignment:

    let mut buffer =3D [0u8; CMD_SIZE];

When this buffer is passed to GspSeqCmd::new() and then to
SequencerBufferCmd::from_bytes():

    let fw_cmd =3D fw::SequencerBufferCmd::from_bytes(data).ok_or(EINVAL)?;

If the compiler places the array at a misaligned address on the stack, could
from_bytes() (which expects 4-byte alignment for u32 fields) fail silently =
and
abort the GSP boot process?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-nova-bootc=
ontext-v4-0-5539d8469590@nvidia.com?part=3D1
