Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5033C44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 21:18:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E5ED10F16C;
	Wed, 15 Jul 2026 21:18:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YXUTWx4V";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C1F510F16C
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 21:18:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B5BF46001D;
 Wed, 15 Jul 2026 21:18:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FC91F000E9;
 Wed, 15 Jul 2026 21:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784150285;
 bh=8fyVFWEqwMqr6M9QCbQ4DwBrZz9sCVMK25CzJB5p8B4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YXUTWx4Vo4AxHZmcSKxXDLPvFDqpWkmBk/5aO4C4a0RDtnSuB8adahfV1PIMeLjuG
 LFMwOzkkZ6utXVBxiakt4+pk3vFjNRLdMj4tNJyM9nXXLTryPEdwZq7FtpJFubceGh
 wRyFDZ9DJusPlvCHBRlfNyqrZ+uBSo0cYlkfFXIosXeHrRkMaoO1pqg8rEmU9Br1IA
 HADU4LQNokY1XRuwLBvn4DXdDYg2NXMIieCmXZbsCuOhkz4xMI8YehE9TZnwMOq3EN
 g0Vym+xeG5s6GexfwlkqjlpIrfDao5QIAvE9D2cHpe/4YyefH4Yl3EhcA4bTddd1C6
 vdoIbakvj3sKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 2/3] samples: rust: add Rust serial device bus
 sample device driver
To: "Markus Probst" <markus.probst@posteo.de>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260715-rust_serdev-v14-2-b4ed5c93606f@posteo.de>
References: <20260715-rust_serdev-v14-0-b4ed5c93606f@posteo.de>
 <20260715-rust_serdev-v14-2-b4ed5c93606f@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 21:18:04 +0000
Message-Id: <20260715211804.82FC91F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The `remove_callback` function in the Rust `serdev` abstraction fa=
ils to free the driver's private data (`PrivateData`), leading to a memory =
leak when the device is unbound.
- [Medium] The `receive` callback returns the number of bytes written to th=
e Tx buffer rather than the number of bytes consumed from the Rx buffer, wh=
ich can permanently stall the TTY Rx path.
- [Low] The driver queries the non-standard device tree property `baudrate`=
 instead of the standard `current-speed` to configure the serial speed.
- [Low] The driver registers an ACPI ID table but this behavior is entirely=
 omitted from the commit message.
--

--- Patch [2]: [PATCH v14 2/3] samples: rust: add Rust serial device bus sa=
mple device driver ---
commit 119f675ea28625315fe04a8ca0cdd59f9d0f26bc
Author: Markus Probst <markus.probst@posteo.de>

samples: rust: add Rust serial device bus sample device driver
   =20
Add a sample Rust serial device bus device driver illustrating the usage
of the serial device bus abstractions.

> This drivers probes through either a match of device / driver name or a
> match within the OF ID table.

[Severity: Low]
Does this description omit the ACPI ID table?

Looking at ACPI_TABLE in rust_driver_serdev.rs, the driver also registers an
ACPI ID table for matching:

kernel::acpi_device_table!(
    ACPI_TABLE,
    MODULE_ACPI_TABLE,
    <SampleDriver as serdev::Driver>::IdInfo,
    [(acpi::DeviceId::new(c"LNUXBEEF"), ())]
);

Could the commit message be updated to mention the ACPI matching behavior as
well?

> diff --git a/samples/rust/rust_driver_serdev.rs b/samples/rust/rust_drive=
r_serdev.rs
> new file mode 100644
> index 0000000000000..a12b1412db30c
> --- /dev/null
> +++ b/samples/rust/rust_driver_serdev.rs
> @@ -0,0 +1,90 @@
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

[Severity: Low]
Does this code use an incorrect, non-standard device tree property?

It looks like it queries c"baudrate" instead of the standard c"current-spee=
d"
property, which could cause it to fail to configure the speed on platforms
compliant with standard bindings.

> +                    .unwrap_or(115200),
> +            )
> +            .is_err()
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
> +        sdev.write(data).unwrap_or_default() as usize

[Severity: Medium]
Could this permanently stall the TTY Rx path?

The receive callback appears to return the number of bytes written to the
Tx buffer rather than the number of bytes consumed from the Rx buffer.

If the Tx buffer is full, sdev.write() returns 0, and the TTY layer will
stop pushing data. Without a mechanism to wake up the Rx path when Tx space
becomes available, does this permanently stall the receiver?

> +    }
> +}

I also noticed an issue in rust/kernel/serdev.rs during driver unbind:

rust/kernel/serdev.rs:remove_callback() {
    ...
    let private_data =3D unsafe { sdev.as_ref().drvdata_borrow::<PrivateDat=
a<'_, T>>() };

    // SAFETY: No one has exclusive access to private_data.driver.
    let data =3D unsafe { &*private_data.driver.get() };
    ...
    T::unbind(sdev, data_pinned);
}

[Severity: High]
Does this code leak the driver's private data?

The remove_callback() function appears to fail to free PrivateData because =
it
uses drvdata_borrow() instead of drvdata_obtain() on the teardown path, whi=
ch
would take ownership back and allow the driver data allocation to be dropped
when the device is unbound.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715-rust_serde=
v-v14-0-b4ed5c93606f@posteo.de?part=3D2
