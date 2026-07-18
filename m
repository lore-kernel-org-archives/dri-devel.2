Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7689C4451C
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 15:54:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2506610E0AC;
	Sat, 18 Jul 2026 15:54:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dX3KD2DB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48CF410E0AC
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 15:54:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E87E34114B;
 Sat, 18 Jul 2026 15:54:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE091F000E9;
 Sat, 18 Jul 2026 15:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784390077;
 bh=pJ62uPYgEg5A1QSdI6geJp8lW3sg5QkKloGZzKSs9Cs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dX3KD2DB29zWd1rem1P76BR6wIQerzdvYJXwHnmEsFtRBup/ZhShbCywQ0b7aXQAk
 oD/uMk1N8wng22/wBgl36pSWbNswhN3bwzaSnmU/GOrt2KwheXXk+m4mpryXle2X56
 LODFRir7/DSb7XYpZWDC4cJwN72T1CIkBpvYdvSDwMGIDgxgAunWgCYE3w5h84Uw7q
 rmSl8b8+liyJkjGiE8RKc5l5xunbpadKGjOf99OdOnOuwjnOvF4PobduUGJtUy9XPq
 SI1Gh6id9Cdb7vPK8OQxlF99Yfb2aMrYfEQSNLqyHZici8wSKAxMwnABeiA76fy1iT
 nKOqQDYxL2xHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 2/3] samples: rust: add Rust serial device bus
 sample device driver
To: "Markus Probst" <markus.probst@posteo.de>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260718-rust_serdev-v16-2-5809384d2e1b@posteo.de>
References: <20260718-rust_serdev-v16-0-5809384d2e1b@posteo.de>
 <20260718-rust_serdev-v16-2-5809384d2e1b@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 15:54:37 +0000
Message-Id: <20260718155437.9BE091F000E9@smtp.kernel.org>
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
- [High] Race condition causing Use-After-Free and NULL pointer dereference=
 in `receive_buf_callback` during device unbind or probe failure.
- [Medium] Missing `write_wakeup` hook in serdev abstraction causes driver =
stalls on transmit buffer full.
--

--- Patch [2]: [PATCH v16 2/3] samples: rust: add Rust serial device bus sa=
mple device driver ---
commit 55560927fe62016a13f3a51d6f3e3f813e10db57
Author: Markus Probst <markus.probst@posteo.de>

samples: rust: add Rust serial device bus sample device driver
   =20
Add a sample Rust serial device bus device driver illustrating the usage
of the serial device bus abstractions.

> diff --git a/samples/rust/rust_driver_serdev.rs b/samples/rust/rust_drive=
r_serdev.rs
> new file mode 100644
> index 0000000000000..a12b1412db30c
> --- /dev/null
> +++ b/samples/rust/rust_driver_serdev.rs
[ ... ]
> +    fn receive<'bound>(
> +        sdev: &'bound serdev::Device<Bound>,
> +        _this: Pin<&Self>,
> +        data: &[u8],
> +    ) -> usize {
> +        sdev.write(data).unwrap_or_default() as usize

[Severity: Medium]
Will this driver stall on a full transmit buffer?

If the transmit buffer fills up, sdev.write() returns a short count, which =
the
driver propagates back to the TTY core.

The TTY core responds by pausing further receive operations until space bec=
omes
available.=20

Since the Rust serdev abstraction hardcodes write_wakeup to
bindings::serdev_device_write_wakeup (which only wakes up synchronous write=
s via
write_all):

rust/kernel/serdev.rs:Adapter::OPS {
    ...
    write_wakeup: Some(bindings::serdev_device_write_wakeup),
    ...
}

the driver cannot hook write_wakeup to be notified when transmit space beco=
mes
available.

As a result, the driver never resumes the TTY receive path, causing a perma=
nent
stall until a new byte physically arrives to re-trigger the receive workque=
ue.

> +    }
> +}
> +
> +impl Drop for SampleDriver {
> +    fn drop(&mut self) {
> +        dev_dbg!(
> +            self.sdev.as_ref(),
> +            "Remove Rust Serial device bus device driver sample.\n"
> +        );
> +    }
> +}

[Severity: High]
Does the serdev abstraction have a use-after-free or NULL pointer dereferen=
ce
race condition during device unbind or probe failure?

During device unbind, the driver core invokes post_unbind_callback, which c=
alls
drvdata_obtain to take ownership of the driver data, setting drvdata to NUL=
L:

rust/kernel/device.rs:drvdata_obtain() {
    ...
    unsafe { bindings::dev_set_drvdata(self.as_raw(), core::ptr::null_mut()=
) };
    ...
}

It then drops PrivateData, which closes the device:

rust/kernel/serdev.rs:PinnedDrop for PrivateData {
    ...
    unsafe { bindings::serdev_device_close(self.sdev.as_raw()) };
    ...
}

Because the device is closed only at the end of the drop routine, the TTY p=
ort
remains active while drvdata is NULL and while PrivateData is being freed.

If data arrives on the UART during this window, the TTY layer concurrently
invokes receive_buf_callback, which borrows drvdata:

rust/kernel/serdev.rs:receive_buf_callback() {
    ...
    let private_data =3D unsafe { sdev.as_ref().drvdata_borrow::<PrivateDat=
a<'_, T>>() };
    ...
}

rust/kernel/device.rs:drvdata_borrow() {
    ...
    unsafe { Pin::<KBox<T>>::borrow(ptr.cast()) }
    ...
}

This will either dereference the NULL drvdata pointer, or if it already read
the pointer before drvdata_obtain, it will access PrivateData after it has =
been
freed when attempting to lock active.

The same race exists in the probe error path where ScopeGuard drops Private=
Data
before the device is closed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718-rust_serde=
v-v16-0-5809384d2e1b@posteo.de?part=3D2
