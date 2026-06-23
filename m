Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A02FCDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:46:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F72110ECAE;
	Tue, 23 Jun 2026 20:46:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="miEJMMv8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78F1710ECAC
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:46:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EFEED600AB;
 Tue, 23 Jun 2026 20:46:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671C31F000E9;
 Tue, 23 Jun 2026 20:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782247602;
 bh=jZRP45wH9RaJ44iagACI6c3TdoA1mcRD/Qfa2OgMY+E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=miEJMMv8uiH8LU9XlaV8HU4/aB7moOiJkoq4oSShFYymVjvpAyDpqSDh8neQvRmcZ
 88ce/lUbkRbAVRMkeDbHq4tgdIGDq6KowLRpwPY6rRWL1uJyABF52HtAIegm0SXDGa
 MKmk6SQf7izVZ9Hr8MieBxE5qJmcyw1WOd8Sa7/5+s+nbZdZEvhNmh0s6H6lThdKyJ
 Rylw8QUs4T/rOp9v5xyBouA+71LFquk579WihlW6sNKnJqr0mTjsULgEId6bDrXDE2
 xgXoXfC3o/9wzzXhQMud9rEW/kJmxGnAMaf7BMZb5ayTk7M8cIBUaMOTQeY3R3pWPd
 ivmoGyXU+YeqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/13] gpu: nova-core: gsp: sequencer: do not store
 sequence into GspSequencer
To: "Alexandre Courbot" <acourbot@nvidia.com>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org,
 "Danilo Krummrich" <dakr@kernel.org>
In-Reply-To: <20260622-nova-bootcontext-v2-2-0ddeafc06f5d@nvidia.com>
References: <20260622-nova-bootcontext-v2-0-0ddeafc06f5d@nvidia.com>
 <20260622-nova-bootcontext-v2-2-0ddeafc06f5d@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 20:46:42 +0000
Message-Id: <20260623204642.671C31F000E9@smtp.kernel.org>
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
- [High] This problem wasn't introduced by this patch, but the iterator sil=
ently terminates on command parsing errors, causing the GSP boot sequence t=
o incorrectly report success instead of aborting.
--

commit 67a42d6a50b9bd7a1977aebced3e9453d53bb90e
Author: Alexandre Courbot <acourbot@nvidia.com>

gpu: nova-core: gsp: sequencer: do not store sequence into GspSequencer

This commit refactors the GSP sequencer by moving the command sequence
data out of the GspSequencer struct and instead passing it directly when
creating the iterator. This resolves borrow-checker limitations and allows
for future mutable borrows within the boot context.

> diff --git a/drivers/gpu/nova-core/gsp/sequencer.rs b/drivers/gpu/nova-co=
re/gsp/sequencer.rs
> index 0da3c35318866..b5e049f76c282 100644
> --- a/drivers/gpu/nova-core/gsp/sequencer.rs
> +++ b/drivers/gpu/nova-core/gsp/sequencer.rs

[ ... ]

> @@ -355,7 +351,6 @@ pub(crate) fn run(
>          };
> =20
>          let sequencer =3D GspSequencer {
> -            seq_info,
>              bar: ctx.bar,
>              sec2_falcon: ctx.sec2_falcon,
>              gsp_falcon: ctx.gsp_falcon,
> @@ -366,14 +361,14 @@ pub(crate) fn run(
> =20
>          dev_dbg!(sequencer.dev, "Running CPU Sequencer commands\n");
> =20
> -        for cmd_result in sequencer.iter() {
> +        for cmd_result in GspSeqIter::new(&seq_info, sequencer.dev) {

[Severity: High]
This isn't a bug introduced by this patch, but doesn't the iterator
silently terminate on command parsing errors, causing the GSP boot sequence
to incorrectly report success instead of aborting?

Looking at GspSeqIter::next(), when a command fails to parse, the error
is swallowed and translated to None:

drivers/gpu/nova-core/gsp/sequencer.rs:GspSeqIter::next() {
    ...
    cmd_result.map_or_else(
        |_err| {
            dev_err!(self.dev, "Error parsing command at offset {}\n", offs=
et);
            None
        },
    ...
}

Returning None signals normal exhaustion of the iterator. This causes the
loop here in GspSequencer::run() to cleanly exit without ever hitting the
Err(e) match arm below.

Consequently, GspSequencer::run() will incorrectly log success and return
Ok(()), completely masking the hardware initialization failure and leaving
the hardware in a malformed state.

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622-nova-bootc=
ontext-v2-0-0ddeafc06f5d@nvidia.com?part=3D2
