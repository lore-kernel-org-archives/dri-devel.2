Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7EFC43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:19:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0E4810E080;
	Mon, 29 Jun 2026 14:19:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jpJOfaby";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88EE610E080
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:19:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EDB6A60008;
 Mon, 29 Jun 2026 14:19:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF431F000E9;
 Mon, 29 Jun 2026 14:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782742768;
 bh=3M1ZOtpb3KUNau1xP5eMih5R7bWacZfvXOVdY3mlcoI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jpJOfabyYvnNKkrPWgdM4EAa48ctArGqlWNy4NdpPpglonZE9zB9trc981hBQPF57
 OzUB/E9PEJ0vTJDm6Qz/NfkM04t98RFFXKuMXcJWsc00+4/cFK6iPrw1TF+wSlFyeW
 6dxgJXYZZICuX8g1rWgTV76Qo64wQrbW8VqoIu88r9Q0aPYfh0NQVEIi97qY92GlFd
 rGlbFOH/y53R4BsS2WuZHjBnjBg2/C6RkOuaO0wz9xjA9vRm15ZXKgjLTmToRf8vPB
 TwtDmaoq26lj6w2sHm3F5L6WC4vEV+Uhl0PrxCDV40QoCpFBkQ9RBj8niPX1kJ0qqF
 DOe+3gGzppr3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/13] gpu: nova-core: gsp: sequencer: do not store
 sequence into GspSequencer
To: "Alexandre Courbot" <acourbot@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>,
 ojeda@kernel.org
In-Reply-To: <20260629-nova-bootcontext-v4-2-5539d8469590@nvidia.com>
References: <20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com>
 <20260629-nova-bootcontext-v4-2-5539d8469590@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 14:19:27 +0000
Message-Id: <20260629141928.6BF431F000E9@smtp.kernel.org>
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
- [High] The sequencer iterator silently terminates upon encountering a com=
mand parsing error, causing the boot sequence to falsely report success.
- [High] Truncated commands at the end of the sequence buffer are silently =
executed with zero-padded payloads instead of failing.
--

commit ffd1618690514804f608d22ee8574e39be09904e
Author: Alexandre Courbot <acourbot@nvidia.com>

gpu: nova-core: gsp: sequencer: do not store sequence into GspSequencer

The sequence is currently stored in the `GspSequencer` even though its
lifetime is limited to `GspSequencer::run`. This object-oriented design
does not play well with the borrow-checker, as `GspSequencer::iter`
borrows a reference to the `GspSequencer`, which makes it difficult to
introduce mutable references in `GspBootContext`, as we want to do in
order to make the `Falcon` references mutable.

Thus, store the sequence locally in `GspSequencer::run`, and move
iterator creation to `GspSeqIter::new` so it no longer needs to borrow
the whole `GspSequencer`.

> diff --git a/drivers/gpu/nova-core/gsp/sequencer.rs b/drivers/gpu/nova-co=
re/gsp/sequencer.rs
> index f55205bd61f35..ddce32cc4e308 100644
> --- a/drivers/gpu/nova-core/gsp/sequencer.rs
> +++ b/drivers/gpu/nova-core/gsp/sequencer.rs

[ ... ]

> @@ -281,6 +279,18 @@ pub(crate) struct GspSeqIter<'a> {
>      dev: &'a device::Device,
>  }
> =20
> +impl<'a> GspSeqIter<'a> {
> +    fn new(seq: &'a GspSequence, dev: &'a device::Device) -> Self {
> +        Self {
> +            cmd_data: &seq.cmd_data,
> +            current_offset: 0,
> +            total_cmds: seq.cmd_index,
> +            cmds_processed: 0,
> +            dev,
> +        }
> +    }
> +}
> +
>  impl<'a> Iterator for GspSeqIter<'a> {
>      type Item =3D Result<GspSeqCmd>;
> =20
> @@ -322,20 +332,6 @@ fn next(&mut self) -> Option<Self::Item> {
>      }
>  }
> =20
> -impl<'a> GspSequencer<'a> {
> -    fn iter(&self) -> GspSeqIter<'_> {
> -        let cmd_data =3D &self.seq_info.cmd_data[..];
> -
> -        GspSeqIter {
> -            cmd_data,
> -            current_offset: 0,
> -            total_cmds: self.seq_info.cmd_index,
> -            cmds_processed: 0,
> -            dev: self.dev,
> -        }
> -    }
> -}
> -

[Severity: High]
This isn't a bug introduced by this patch, but while looking at
GspSeqIter::next() I noticed that it silently terminates on parsing errors:

drivers/gpu/nova-core/gsp/sequencer.rs:GspSeqIter::next() {
    ...
    let cmd_result =3D GspSeqCmd::new(&buffer, self.dev);

    cmd_result.map_or_else(
        |_err| {
            dev_err!(self.dev, "Error parsing command at offset {}\n", offs=
et);
            None
        },
    ...
}

If firmware sends invalid data and GspSeqCmd::new() returns an error, the
iterator returns None instead of propagating the error. This silently stops
the iterator loop, causing the remaining hardware initialization commands
to be skipped while GspSequencer::run() falsely reports success.

Can this leave the GPU in an uninitialized state and cause system hangs or
memory corruption?

[Severity: High]
This is a pre-existing issue, but I also noticed a potential bounds checking
bypass when GspSeqIter::next() processes truncated commands at the end of t=
he
sequence buffer:

drivers/gpu/nova-core/gsp/sequencer.rs:GspSeqIter::next() {
    ...
    let mut buffer =3D [0u8; CMD_SIZE];
    let copy_len =3D if offset + CMD_SIZE <=3D self.cmd_data.len() {
        CMD_SIZE
    } else {
        self.cmd_data.len() - offset
    };
    buffer[..copy_len].copy_from_slice(&self.cmd_data[offset..offset + copy=
_len]);
    let cmd_result =3D GspSeqCmd::new(&buffer, self.dev);
    ...
}

When copy_len is less than CMD_SIZE, the data is copied into the zero-padded
buffer and passed to GspSeqCmd::new() as a full CMD_SIZE slice.

Inside GspSeqCmd::new():

drivers/gpu/nova-core/gsp/sequencer.rs:GspSeqCmd::new() {
    ...
    if data.len() < size {
        dev_err!(dev, "Data is not enough for command\n");
        return Err(EINVAL);
    }
    ...
}

Since data.len() is always evaluated as the full buffer length (CMD_SIZE),
this check always passes, neutralizing the intended length validation.

Does this execute truncated firmware commands with zeroed payloads instead =
of
failing, potentially causing unintended hardware actions or state corruptio=
n?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-nova-bootc=
ontext-v4-0-5539d8469590@nvidia.com?part=3D2
