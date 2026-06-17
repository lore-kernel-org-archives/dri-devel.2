Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B941CD98F0
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 20:11:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B85BB10EB17;
	Wed, 17 Jun 2026 20:11:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SEhUY0MM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B7A910EB17
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 20:11:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 40B406001D;
 Wed, 17 Jun 2026 20:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15811F000E9;
 Wed, 17 Jun 2026 20:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781727101;
 bh=GeFClqHtPeE87RoRgzwcL0VeOoz4c8HKst/sDSdfV9k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SEhUY0MM9mJxuzC/92SfL55OvRXiRmi+lc0nk0BTfo25seQPl5gkmpk3Lxiwhsod9
 /xr9Fl6FROwhMh+lcMUWMJyZHhSI0QblCzpe7EMadEcWxVakBOFXx9GPqUakMmgRAP
 GM0IwbnSCc+Tx0JYVdpc+k2u40B3cXlxZ5nMbKJXP7mWOYVBRVZyO+ur0ux95R667M
 lDnwf/GL2fF47YnqKY5zCyagvEzS2Gn8q78M2eupSQlH6d7eDYOUc7WLXAoOXte81B
 JT4dRk9qBCDqTx42mpnCWJ96oB6IB2rHrfAHmceXG4VgZ8dfHI9jkc9RBtAymkkfaU
 zrMkB9u0GKMyQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/7] drm/vino: add DisplayLink DL3 dock skeleton and
 plaintext bring-up
To: "Mike Lothian" <mike@fireburn.co.uk>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260617151249.2937-2-mike@fireburn.co.uk>
References: <20260617151249.2937-1-mike@fireburn.co.uk>
 <20260617151249.2937-2-mike@fireburn.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 20:11:40 +0000
Message-Id: <20260617201140.C15811F000E9@smtp.kernel.org>
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
- [High] The driver enqueues a `BringUp` work item to the system workqueue =
but does not save a handle to it, making it impossible to cancel during `di=
sconnect()`.
- [Medium] Overly restrictive Kconfig dependency (`depends on USB =3D y`) p=
revents building the driver as a module when the USB subsystem is modular.
--

commit c4faf8ad941311cd06fad312c6e36a39253115df
Author: Mike Lothian <mike@fireburn.co.uk>

drm/vino: add DisplayLink DL3 dock skeleton and plaintext bring-up

Adds a clean-room, in-kernel Rust DRM driver for DisplayLink DL3 USB docks
(Dell Universal Dock D6000). This first patch registers a usb::Driver, binds
the control interface, and runs the plaintext connect handshake on a
workqueue.

> diff --git a/drivers/gpu/drm/vino/Kconfig b/drivers/gpu/drm/vino/Kconfig
> new file mode 100644
> index 0000000000000..234ce92736e43
> --- /dev/null
> +++ b/drivers/gpu/drm/vino/Kconfig
> @@ -0,0 +1,21 @@
> +# SPDX-License-Identifier: GPL-2.0
> +config DRM_VINO
> +	tristate "DisplayLink DL3 (Vino) open driver"
> +	depends on USB =3D y

[Severity: Medium]
Does this strict dependency prevent the driver from being built as a module
on standard distribution kernels?

Using "depends on USB" instead of "depends on USB =3D y" would allow this
module to be compiled when the USB subsystem is also built as a module.

[ ... ]
> diff --git a/drivers/gpu/drm/vino/vino.rs b/drivers/gpu/drm/vino/vino.rs
> new file mode 100644
> index 0000000000000..79f446041b648
> --- /dev/null
> +++ b/drivers/gpu/drm/vino/vino.rs
[ ... ]
> +        let intf_ref: ARef<usb::Interface> =3D intf.into();
> +        match BringUp::new(intf_ref.clone()) {
> +            Ok(work) =3D> {
> +                let _ =3D workqueue::system().enqueue(work);

[Severity: High]
Does this code leak the enqueued work item handle?

Because the returned handle isn't stored in the driver's struct, it becomes
impossible to cancel this work item later during device disconnection.

> +                dev_info!(cdev, "vino: bring-up queued on system workque=
ue\n");
> +            }
> +            Err(e) =3D> dev_info!(cdev, "vino: failed to queue bring-up =
({e:?}) -- WIP\n"),
> +        }
> +
> +        Ok(Self { _intf: intf_ref })
> +    }
> +
> +    fn disconnect<'bound>(intf: &'bound usb::Interface<Core<'_>>, _data:=
 Pin<&Self>) {
> +        let dev: &device::Device<Core<'_>> =3D intf.as_ref();
> +        dev_info!(dev, "vino: D6000 disconnected\n");
> +    }

[Severity: High]
Can this lead to a use-after-free panic if the module is unloaded while the
work item is still pending?

Since the work item isn't flushed or canceled here in disconnect(), the
workqueue might attempt to execute the work item's run function after the
module's code segment has been unmapped.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617151249.2937=
-1-mike@fireburn.co.uk?part=3D1
