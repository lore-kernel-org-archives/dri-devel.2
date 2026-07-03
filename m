Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E99C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:19:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB46410F61D;
	Fri,  3 Jul 2026 03:19:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dsLJ42ZU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 157FC10F61D
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 03:19:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6C9AA60210;
 Fri,  3 Jul 2026 03:19:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5A41F000E9;
 Fri,  3 Jul 2026 03:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783048741;
 bh=AVYJ+9EddV4MU4txBt0IqBtccUUWSBC37KeWlCMcgtQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dsLJ42ZU876ynw4VCva6cjmfrTwEWJrz/l4CQ5SIheWWPQ8mEqgrHTEcEk6dqc0/4
 ituaLGHfgjVE4fVsGaNwdARRL+ZG+Gl6V7rOrV7mrWwjYdC6Cnpb20leiEuZSxF3Mj
 iywcTv92aBbpJLGdfgYhnOK0xw4uSvKlrCck3UqmQL1IsLyfjKFf8jacIF5DOtH8qr
 8KlcZ3VtL0BQTzBgjQnmYpszrnNmY9U1UxWgki2ARzAzoY5amYb1ptG7WZBgZZhzpe
 YxO9sX9BEIYnDrw04UeSLIsGOL4cgXGwMlNdem5ReoZ81HFNL+5wItpm62BLEE/V77
 RBWPdnfnylIrg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 06/10] drm/vino: add the DisplayLink DL3 dock driver
To: "Mike Lothian" <mike@fireburn.co.uk>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260703030217.2886-7-mike@fireburn.co.uk>
References: <20260617151249.2937-1-mike@fireburn.co.uk>
 <20260703030217.2886-1-mike@fireburn.co.uk>
 <20260703030217.2886-7-mike@fireburn.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 03:18:59 +0000
Message-Id: <20260703031900.9C5A41F000E9@smtp.kernel.org>
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
- [High] Using global static variables for per-device state breaks support =
for multiple connected devices and causes state collisions.
- [High] Bypassing the Rust workqueue abstractions to call the raw C `cance=
l_work_sync` leaks the `Arc` reference transferred to the workqueue.
- [Medium] The async IN queue for the EP84 status endpoint is incorrectly c=
onfigured with an OUT endpoint address (`0x04`), causing the queue creation=
 to fail.
--

commit d6f1e7eb7413b3d79af598de7aa00c7613895253
Author: Mike Lothian <mike@fireburn.co.uk>
drm/vino: add the DisplayLink DL3 dock driver

This commit adds a new open-source Rust driver for DisplayLink DL3 USB dock=
s,
including the Dell D6000. It introduces the USB bulk and control transfer
handshake, HDCP 2.2 control plane, and registers a DRM/KMS device.

> diff --git a/drivers/gpu/drm/vino/vino.rs b/drivers/gpu/drm/vino/vino.rs
> new file mode 100644
> index 0000000000000..eb4378a747c35
> --- /dev/null
> +++ b/drivers/gpu/drm/vino/vino.rs
> @@ -0,0 +1,2617 @@
> +// SPDX-License-Identifier: GPL-2.0

[ ... ]

> +/// Set once the dock has actually engaged the CP cipher (`wsub=3D0x45` =
acks > 0). EP08 video is
> +/// gated on it: pushing frames at a dock whose CP channel is dead makes=
 it fault and USB-reset.
> +/// NOTE: with the current CP-engagement wall (see the file header) this=
 is never set on real
> +/// hardware -- the dock runs the whole plaintext handshake but never en=
gages the encrypted CP.
> +static CP_ENGAGED: core::sync::atomic::AtomicBool =3D core::sync::atomic=
::AtomicBool::new(false);
> +
> +/// One-shot: clear-halt + prime the video endpoints before the first li=
ve-scanout EP08 write.
> +static EP08_SCANOUT_PRIMED: core::sync::atomic::AtomicBool =3D
> +    core::sync::atomic::AtomicBool::new(false);
> +
> +/// Select the live scanout codec. `false` (default) =3D the RLE/mode-2 =
path (`video::Encoder`),
> +/// which is what the dock currently runs and which the dock NAKs pre-CP=
 anyway. `true` =3D the
> +/// byte-exact Vino WHT **colour** codec (`video::wht::colour_frame_ep08=
`), the bandwidth-efficient
> +/// DLM-quality path. Kept a compile-time flag (default off) so the RLE =
path stays the live default
> +/// and the switch is testable independently the moment the CP wall fall=
s; the WHT path needs a
> +/// 64x16-aligned mode and falls back to RLE otherwise (see `docs/VIDEO-=
TODO.md`).
> +const EP08_WHT_CODEC: bool =3D false;
> +
> +/// Consecutive failed live-scanout frames, for log rate-limiting. Until=
 CP engages, the dock
> +/// NAKs every EP08 write (EPROTO), so without this every compositor pag=
eflip would spam dmesg.
> +static SCANOUT_FAILS: core::sync::atomic::AtomicU64 =3D core::sync::atom=
ic::AtomicU64::new(0);
> +
> +/// Pageflip throttle: number of upcoming pageflips to skip before the n=
ext scanout attempt
> +/// (a backoff while the dock NAKs). A single successful frame clears it.
> +static SCANOUT_SKIP: core::sync::atomic::AtomicU64 =3D core::sync::atomi=
c::AtomicU64::new(0);
> +
> +/// Set once the bring-up work item finishes (AKE/CP attempt done). `det=
ect` only connects the
> +/// live-scanout connector AFTER this, so a compositor enabling the outp=
ut cannot start EP08
> +/// scanout on top of the still-running AKE on the same USB device.
> +static BRINGUP_COMPLETE: core::sync::atomic::AtomicBool =3D
> +    core::sync::atomic::AtomicBool::new(false);

[Severity: High]
Does this code support multiple connected devices? It looks like these
global static variables are used to track per-device state. If multiple
DisplayLink D6000 docks are connected, won't they race on these shared flags
during initialization and operation? For instance, one device completing
bring-up could incorrectly flag all devices as ready via BRINGUP_COMPLETE.

[ ... ]

> +        // Open the persistent async EP84 IN reader BEFORE the arm marke=
r and msg0, so
> +        // `EP84_QUEUE_DEPTH` IN transfers are already posted when the d=
ock pushes its post-arm
> +        // reply (DLM's libusb always-pending-IN behaviour). Draining EP=
84 concurrently stops the
> +        // dock's IN FIFO filling and NAKing our OUT (the sync-bulk dead=
lock that produced a 100 ms
> +        // msg0 NAK). RAII: dropping the queue at function exit kills+fr=
ees the URBs.
> +        let mut ep84_q =3D match dev.bulk_in_queue(0x04, EP84_QUEUE_DEPT=
H, EP84_BUF) {

[Severity: Medium]
Is the endpoint address correct here in VinoDriver::send_cp_setup()? It loo=
ks
like it's opening an IN queue for endpoint 0x84 but passes 0x04 instead.
Since 0x04 is missing the USB_DIR_IN bit (0x80), won't the queue creation
fail and force the driver to fall back to the synchronous bulk_recv mode?

[ ... ]

> +    fn disconnect<'bound>(intf: &'bound usb::Interface<Core<'_>>, data: =
Pin<&Self>) {
> +        let dev: &device::Device<Core<'_>> =3D intf.as_ref();
> +        // Flush the deferred bring-up before the interface is unbound: =
`cancel_work_sync`
> +        // dequeues it if pending and blocks until it returns if already=
 running, so no
> +        // USB I/O races the unbind (see the `Interface::as_bound` contr=
act in
> +        // `BringUp::run`). Safe to call when the work already finished =
or never ran.
> +        if let Some(work) =3D data.bringup.as_ref() {
> +            // SAFETY: `work.work` is a live `Work` field of a pinned, r=
efcounted `BringUp`;
> +            // `raw_get` yields its valid `work_struct`, which `cancel_w=
ork_sync` only reads
> +            // and synchronises against. The `Arc` keeps the allocation =
alive across the call.
> +            unsafe {
> +                let wptr =3D Work::raw_get(core::ptr::addr_of!(work.work=
));
> +                bindings::cancel_work_sync(wptr);
> +            }
> +        }

[Severity: High]
Does this direct call to bindings::cancel_work_sync() in
VinoDriver::disconnect() leak the Arc reference transferred to the
workqueue? Since the Rust workqueue enqueue consumes an Arc<BringUp>
that is usually dropped when the callback executes, bypassing the Rust
abstractions to cancel the work means the callback won't run, leaving
the Arc without a mechanism to drop it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703030217.2886=
-1-mike@fireburn.co.uk?part=3D6
