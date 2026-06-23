Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E63ECDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:06:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60C6A10EA38;
	Tue, 23 Jun 2026 20:06:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L3sZjjtB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB1F110EA38
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:06:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 34A5460129;
 Tue, 23 Jun 2026 20:06:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78AB1F000E9;
 Tue, 23 Jun 2026 20:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782245207;
 bh=vKIcj9WERCuqJ6NC6ZfJMXj/HSD8KgvCZYzvfBT8rFU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=L3sZjjtBFR4niODyOIx867HiNNHrf46IXRY3L95chu/KgwgOsLe6FdAWef6JD+vXW
 h6wMYkGuHcl0UB5GIIS77SQYt5nysMtoEpPnIxHjKRJ2YJWO+zq/3hHs0d3sh67yxy
 5cWozU0DcO0YWso+JCt4zuFkl7ACLvjkv/z2MKB++zOxJR8x9WXLhSf3Mzitt+i/C3
 K2vWenriqCMZkhn4JZhDWLoVLDtBjkZ3Y5GO8ZlH7uu88UmtoxBIFIB4iah6hXFSaM
 jh02Ii8+UDYRDdcCpVR35wJHJ1OPmbDeeC+pFe5tZbjvJLGNT9hQOOtxM1GgkMJAtv
 29dfu7jME2q2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/13] gpu: nova-core: fsp: try to enforce exclusive
 access to FSP channel
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo
 Krummrich" <dakr@kernel.org>
In-Reply-To: <20260615-blackwell-fixes-v1-3-f2853e49ff7d@nvidia.com>
References: <20260615-blackwell-fixes-v1-3-f2853e49ff7d@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 20:06:47 +0000
Message-Id: <20260623200647.A78AB1F000E9@smtp.kernel.org>
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
- [High] Polling queue pointers to attempt mutual exclusion between the ker=
nel and GSP creates a Time-of-Check to Time-of-Use (TOCTOU) race condition =
and incorrectly identifies active processing windows as idle.

Pre-existing issues:
- [High] `send_msg` does not validate that the packet length is within the =
FSP EMEM channel boundaries before writing.
- [High] `QUEUE_TAIL` is written before `QUEUE_HEAD` is reset, potentially =
exposing an invalid queue state to the FSP.
--

commit cbbcd901d8b26aba0c2ec257efff6284b3bf260b
Author: Eliot Courtney <ecourtney@nvidia.com>

gpu: nova-core: fsp: try to enforce exclusive access to FSP channel
   =20
Currently, send_msg assumes that the channel to FSP is free to write
into. But, it might not be. Both the kernel driver and GSP communicate
with FSP. The way they should attempt to keep exclusive access to this
channel to FSP is by making sure they don't try to start writing if
there's pending data until the full round trip has finished.

> diff --git a/drivers/gpu/nova-core/falcon/fsp.rs b/drivers/gpu/nova-core/=
falcon/fsp.rs
> index 21eaa8e261ce6..cdb476894e1ad 100644
> --- a/drivers/gpu/nova-core/falcon/fsp.rs
> +++ b/drivers/gpu/nova-core/falcon/fsp.rs

[ ... ]

> @@ -133,6 +153,9 @@ pub(crate) fn send_msg(&mut self, bar: Bar0<'_>, pack=
et: &[u8]) -> Result {
>              return Err(EINVAL);
>          }
> =20
> +        // Try to make sure we have exclusive access to the FSP at this =
point.
> +        self.wait_until_ready(bar)?;
> +
>          self.write_emem(bar, packet)?;

[Severity: High]
Does this introduce a time-of-check to time-of-use (TOCTOU) race condition?

The kernel and the GSP run asynchronously.

This lockless software polling approach does not appear to provide strict
mutual exclusion between the two processors.

Could both evaluate the idle condition (qhead =3D=3D qtail && mhead =3D=3D =
mtail)
simultaneously in wait_until_ready() and subsequently write to the shared
FSP EMEM channel at the same time, leading to hardware message corruption?

[Severity: High]
This isn't a bug introduced by this patch, but does this write operation la=
ck
a bounds check against the FSP EMEM channel capacity?

There does not appear to be a check ensuring that packet.len() is within
FSP_EMEM_CHANNEL_0_SIZE (1024 bytes).

If a caller submits a larger packet, could write_emem() overwrite adjacent
hardware memory and potentially corrupt secure boot data or other channel
states?

> =20
>          // Update queue pointers. TAIL points at the last DWORD written.
>          let tail_offset =3D u32::try_from(packet.len() - 4).map_err(|_| =
EINVAL)?;
>          bar.write(
>              Array::at(0),
>              regs::NV_PFSP_QUEUE_TAIL::zeroed().with_address(tail_offset),
>          );
>          bar.write(
>              Array::at(0),
>              regs::NV_PFSP_QUEUE_HEAD::zeroed().with_address(0),
>          );

[Severity: High]
This is a pre-existing issue, but does writing QUEUE_TAIL before resetting
QUEUE_HEAD expose an invalid queue state to the hardware?

If QUEUE_HEAD contains a non-zero value from a previous transaction, writing
QUEUE_TAIL first could cause the hardware to briefly observe a state where
TAIL < HEAD.

Because the queue is not circular, could this trigger an immediate hardware
processing error before the kernel updates QUEUE_HEAD to 0?

> =20
>          Ok(())
>      }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615-blackwell-=
fixes-v1-0-f2853e49ff7d@nvidia.com?part=3D3
