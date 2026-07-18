Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A29C4451C
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 14:40:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 173D610E526;
	Sat, 18 Jul 2026 14:40:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QGjMFasm";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6722810E526
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 14:40:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 16AA3413AB;
 Sat, 18 Jul 2026 14:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFF41F000E9;
 Sat, 18 Jul 2026 14:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784385628;
 bh=5CNf4wV7O4oCFsUcvnouEqLB/WDCMAkiKmXaJOE89Xc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QGjMFasmP/HNGsKyiVud7NPOKYbeuep3PVRZZGTdr+PZ/Ff8FdqaAUXDBocDil+5q
 CaRn51FDRWhTGx4fQU6D+12gfluBUwO6vVUMroBHlz0/BwNa3zgXvzWI1uhRpWJzq0
 AH4T1ezFZAYmS6TmgL/rXY8PKlg8ojz+IHTjauW2GAh3cglImHYusJPZvoNOMQu30L
 eKMWNLbP4K3s72BS9c4RhrKfkSjbqvGBKERznG5wIge/WnP9gXVMjBVJTaKlp0P1UH
 CNMFB8vyIJxbBjFs83x91ivI7MYOomHvgcRWt3uvx7wk3EjPnEsRZpjW80FR76yYLX
 qiagoMTqXTfFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 2/3] samples: rust: add Rust serial device bus
 sample device driver
To: "Markus Probst" <markus.probst@posteo.de>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260718-rust_serdev-v15-2-208ed2e6ec15@posteo.de>
References: <20260718-rust_serdev-v15-0-208ed2e6ec15@posteo.de>
 <20260718-rust_serdev-v15-2-208ed2e6ec15@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 14:40:27 +0000
Message-Id: <20260718144027.BCFF41F000E9@smtp.kernel.org>
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
- [Medium] Incorrect device tree property used for serial baud rate configu=
ration.
--

--- Patch [2]: [PATCH v15 2/3] samples: rust: add Rust serial device bus sa=
mple device driver ---
commit 7885024c6abc3e1d37bf3499dc357753c532b4d5
Author: Markus Probst <markus.probst@posteo.de>

samples: rust: add Rust serial device bus sample device driver

This commit adds a sample Rust serial device bus device driver illustrating
the usage of the serial device bus abstractions. The driver probes through
either a match of device or driver name, or a match within the OF ID table.

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

[Severity: Medium]
Does this use the correct device tree property for the serial baud rate?

Standard serial device nodes typically use current-speed rather than
baudrate. If baudrate is queried, will the driver fail to read the
configured rate from standard nodes and silently fall back to the 115200
default?=20

Since this is a sample driver, would it be better to query current-speed so
it serves as a correct template for new developers?

> +                    .unwrap_or(115200),
> +            )
> +            .is_err()
> +        {
> +            return Err(EINVAL);
> +        }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718-rust_serde=
v-v15-0-208ed2e6ec15@posteo.de?part=3D2
