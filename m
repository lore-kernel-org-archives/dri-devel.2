Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDC6C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6C1C10E3DB;
	Tue,  7 Jul 2026 07:58:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jt0/YaW6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F99710E3DB
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:58:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3A3AC4123D;
 Tue,  7 Jul 2026 07:58:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7201F000E9;
 Tue,  7 Jul 2026 07:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783411103;
 bh=ABD4sigIn7BxE3BopX343uDxRqZe3on1S8NLoRZ7Cxs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jt0/YaW6dFNyg/ajEn1epRha1uwtixXF5WqSI4jr/Wv7dE7J7aL0TtkdnjHaoHwhr
 afL0gz7lJv1zCcKqS7ZMPrIRIixFnfJZbHj5JA8DUtijRMBbkdaxru5Z7+1uYKkFiK
 3H+uJ2sF8z1jmQtZpuOUmvXCfnl/HXZfHgQY0zwxDijmo/xXQZxyEubkXDUHWU5+w4
 PACja46qX9oica21pVTet1iYVgNrOPVw/DvgDDwCvoGXGF8oEH5E9Hoak+rBG+TMh0
 LU0DmkG7ZycuAAIKHa1/MquKUFhydA5yzw6JVICkLUoZj8mT/ZLucM0Q1Wp99BtSgm
 /cBV14CVsFzsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/13] gpu: nova-core: gsp: sequencer: do not store
 sequence into GspSequencer
To: "Alexandre Courbot" <acourbot@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, ojeda@kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260707-nova-bootcontext-v5-2-ecad9346387f@nvidia.com>
References: <20260707-nova-bootcontext-v5-0-ecad9346387f@nvidia.com>
 <20260707-nova-bootcontext-v5-2-ecad9346387f@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:58:22 +0000
Message-Id: <20260707075822.CE7201F000E9@smtp.kernel.org>
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
- [High] Command parsing errors silently terminate execution while reportin=
g success.
- [High] Truncated commands are executed with zeroed payloads instead of fa=
iling.
- [High] `seq_info.cmd_index` is improperly used as the total command count.
--

--- Patch [2]: [PATCH v5 02/13] gpu: nova-core: gsp: sequencer: do not stor=
e sequence into GspSequencer ---
commit b9f8dfb196e815ccff55e396434b9fbb45c0cc05
Author: Alexandre Courbot <acourbot@nvidia.com>

gpu: nova-core: gsp: sequencer: do not store sequence into GspSequencer

Moves the sequence out of the GspSequencer struct to avoid borrow-checker
limitations. Iterator creation is moved to GspSeqIter::new so it no longer
borrows the entire GspSequencer.

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

[Severity: High]
This is a pre-existing issue, but does this incorrectly use the DWord size
as the command count?

If seq.cmd_index represents the buffer length in DWords, assigning it to
total_cmds breaks the iteration bounds check.

In GspSeqIter::next(), cmds_processed is incremented by 1 per command,
which means the condition cmds_processed >=3D total_cmds won't trigger at
the actual end of valid commands.

Could this cause the iterator to parse and execute padding bytes as
commands?

> +            cmds_processed: 0,
> +            dev,
> +        }
> +    }
> +}

[ ... ]

> @@ -363,14 +358,14 @@ pub(crate) fn run(
> =20
>          dev_dbg!(sequencer.dev, "Running CPU Sequencer commands\n");
> =20
> -        for cmd_result in sequencer.iter() {
> +        for cmd_result in GspSeqIter::new(&seq_info, sequencer.dev) {

[Severity: High]
This is a pre-existing issue, but is it possible for truncated commands to
be parsed and executed with zeroed payloads?

Looking at GspSeqIter::next(), if the remaining buffer is smaller than
CMD_SIZE, it appears to zero-pad the data into a buffer of size CMD_SIZE
before passing it to GspSeqCmd::new():

    let cmd_result =3D GspSeqCmd::new(&buffer, self.dev);

Inside GspSeqCmd::new(), the safety check uses data.len():

    if data.len() < size {
        dev_err!(dev, "Data is not enough for command\n");
        return Err(EINVAL);
    }

Since the padded buffer length is always exactly CMD_SIZE, this check might
act as dead code. Does this mean truncated commands would succeed using the
zero padding as their payload rather than failing with an error?

[Severity: High]
This is another pre-existing issue, but does command parsing silently
terminate on errors while reporting success to the caller?

In GspSeqIter::next(), when parsing fails, the error closure logs the
failure but returns None:

    cmd_result.map_or_else(
        |_err| {
            dev_err!(self.dev, "Error parsing command at offset {}\n", offs=
et);
            None
        },

Since None signals normal iterator termination, this loop in
GspSequencer::run() will exit cleanly and return Ok(()) without triggering
an error.

Could this leave the hardware sequence incomplete while the driver
incorrectly assumes the boot sequence succeeded?

>              match cmd_result {
>                  Ok(cmd) =3D> cmd.run(&sequencer)?,
>                  Err(e) =3D> {
>                      dev_err!(
>                          sequencer.dev,
>                          "Error running command at index {}\n",
> -                        sequencer.seq_info.cmd_index
> +                        seq_info.cmd_index
>                      );
>                      return Err(e);
>                  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-nova-bootc=
ontext-v5-0-ecad9346387f@nvidia.com?part=3D2
