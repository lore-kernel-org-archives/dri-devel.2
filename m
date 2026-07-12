Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA7EC43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 17:19:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C228010E263;
	Sun, 12 Jul 2026 17:19:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Y8LwNcQ8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A56410E263
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 17:19:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 27B556004E;
 Sun, 12 Jul 2026 17:19:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE161F000E9;
 Sun, 12 Jul 2026 17:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783876782;
 bh=WNsCohQvhqbRnLbbpThe6J9qx5rvj2smYaJCjoRDvwk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Y8LwNcQ8kTi4MUjvLHjJasdOZvmCF26AkUO+Q4ipmmadZy61icSv3C0INMo0lfs3Z
 k59hi16N0zxbqEpEtA0oiWQ92Wi+afeA4x8Lwf6k00vubsYqN5Xf6W33TSdqYkU5SJ
 5TvsH87KePBiEQt9dvSQJj88u1+2cJZnNL9hrp9oLNPEuO+8uOnftJljOYXFqHFKzU
 q7opnhpWJEhCWUbA/qUtV/md3uAA3XS1YJb/T1aGHHPPX6zDQtB/pAwbu68CTyDmYf
 efeVHuze0BOX7wQ1HJJoyFSEILK0GetpUoWbGBYNak8npt9dn+1nfX38oxvkE/SEOI
 F3ajP6AOOzZuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 2/3] samples: rust: add Rust serial device bus
 sample device driver
To: "Markus Probst" <markus.probst@posteo.de>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260712-rust_serdev-v13-2-2c4060bc8e30@posteo.de>
References: <20260712-rust_serdev-v13-0-2c4060bc8e30@posteo.de>
 <20260712-rust_serdev-v13-2-2c4060bc8e30@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 17:19:41 +0000
Message-Id: <20260712171942.5CE161F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] The `receive` callback issues an unbounded blocking write (`serdev=
::Timeout::Max`), which can stall the TTY receive worker indefinitely and c=
ause kernel hangs during module unload.
- [High] The serdev abstraction's `remove_callback` fails to drop the drive=
r's private data, leaking memory and leaving the device open, which leads t=
o a null-pointer dereference in the receive workqueue.
- [Medium] The driver attempts to read a non-standard "baudrate" property i=
nstead of the standard "current-speed" property.
- [Medium] The driver's probe function will fail on many valid hardware pla=
tforms because it rejects inexact baud rates.
- [Low] The commit message falsely claims the driver supports device/driver=
 name matching and omits mention of ACPI support.
--

--- Patch [2]: [PATCH v13 2/3] samples: rust: add Rust serial device bus sa=
mple device driver ---
commit 44e3438d1218c2205d779354d11c50718f82dc2f
Author: Markus Probst <markus.probst@posteo.de>

samples: rust: add Rust serial device bus sample device driver

Add a sample Rust serial device bus device driver illustrating the usage
of the serial device bus abstractions.

> This drivers probes through either a match of device / driver name or a
> match within the OF ID table.

[Severity: Low]
This isn't a bug, but the commit message inaccurately describes the bus mat=
ching
behavior.

serdev_device_match() exclusively checks ACPI and OF ID tables and does not
fall back to device/driver name matching. The implemented ACPI matching is =
also
omitted from the description.

Could the commit message be updated to accurately reflect the supported
matching mechanisms?

> diff --git a/samples/rust/rust_driver_serdev.rs b/samples/rust/rust_drive=
r_serdev.rs
> new file mode 100644
> index 0000000000000..824affbf65936
> --- /dev/null
> +++ b/samples/rust/rust_driver_serdev.rs
[ ... ]
> +    fn probe<'bound>(
> +        sdev: &'bound serdev::Device<Core<'_>>,
> +        _info: Option<&'bound Self::IdInfo>,
> +    ) -> impl PinInit<Self, Error> + 'bound {
> +        let dev =3D sdev.as_ref();
> +
> +        dev_dbg!(dev, "Probe Rust Serial device bus device driver sample=
.\n");
> +
> +        if sdev
> +            .set_baudrate(
> +                dev.fwnode()
> +                    .and_then(|fwnode| fwnode.property_read(c"baudrate")=
.optional())

[Severity: Medium]
Will this fail to read the configured speed from standard device trees?

The driver attempts to read a non-standard "baudrate" property instead of t=
he
standard "current-speed" property. This causes a silent fallback to the 115=
200
default.

Should this use the standard "current-speed" property instead?

> +                    .unwrap_or(115200),
> +            )
> +            .is_err()

[Severity: Medium]
Does strictly rejecting any Err with EINVAL cause the driver to fail probe =
when
an inexact baud rate is achieved?

The bindings::serdev_device_set_baudrate() function returns the actual
configured speed. The Rust set_baudrate() abstraction returns Err(actual_sp=
eed)
if the hardware cannot exactly match the requested speed due to clock divid=
ers.

> +        {
> +            return Err(EINVAL);
> +        }
> +        sdev.set_flow_control(false);
> +        sdev.set_parity(serdev::Parity::None)?;
> +
> +        Ok(Self { sdev: sdev.into() })
> +    }
> +
> +    fn receive<'bound>(
> +        sdev: &'bound serdev::Device<Bound>,
> +        _this: Pin<&Self>,
> +        data: &[u8],
> +    ) -> usize {
> +        let _ =3D sdev.write_all(data, serdev::Timeout::Max);

[Severity: High]
Can this unbounded blocking write stall the TTY receive worker indefinitely?

The receive() callback executes in the TTY RX workqueue. serdev::Timeout::M=
ax
maps to a 0 timeout in serdev_device_write(), which waits indefinitely. If =
the
hardware TX buffer fills up due to a slow remote device or flow control, the
worker thread will block forever.

This deadlock of the TTY RX worker leads to an unkillable task and system h=
ang
when cancel_work_sync() is called during module unload.

> +        data.len()
> +    }
> +}

Additionally, I noticed an issue in the underlying serdev abstraction code =
in
rust/kernel/serdev.rs:

[Severity: High]
Does Adapter::remove_callback() in rust/kernel/serdev.rs fail to drop the
driver's private data during unbind?

During device unbind, remove_callback() uses drvdata_borrow() instead of
drvdata_obtain(). This fails to take ownership of the KBox<PrivateData>,
leaking the memory.

Because PrivateData::drop never runs, bindings::serdev_device_close() is ne=
ver
called. The C driver core then resets dev->driver_data to NULL. Because the
device is still open, incoming serial data triggers receive_buf_callback(),
which calls drvdata_borrow() on the now-NULL drvdata pointer, causing a pan=
ic
when locking the mutex.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712-rust_serde=
v-v13-0-2c4060bc8e30@posteo.de?part=3D2
