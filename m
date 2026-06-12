Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D99E8CD98CF
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 20:14:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34A0A10EB4A;
	Fri, 12 Jun 2026 20:14:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FfWLrYTI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA95810EB4A
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 20:14:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 96E3F406D9;
 Fri, 12 Jun 2026 20:14:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DEFB1F00A3A;
 Fri, 12 Jun 2026 20:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781295268;
 bh=Q1WgzzWtae49IzVg/1puhgls6sVjv6vHzuGqYisHvV8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FfWLrYTITFCP7YE40z3mvuA14Nv2BVmZw5Vye2aOMVxJfUEGQRBCZmV9oTA1VgJue
 ZCwGg9SH/OIwqBWW97JbJhFqFe2G9T32oCorfQHRzrURpITD8SYjGpfofpE17hhLRL
 /2zKDnm5FJ2+FaUlrAvxCU3Qa9eg27b3LH8DalzNSJFmC61sMuASCxMKXBFBWACt6p
 EvpPE1MbVvd9+pmjXoyMOFWBqJiX6xdpVkPnEwGUih98iZYs7ykGoM9Mk7zb/JhuHx
 XL4rgyN2Zq4WXX4JLCD1gMoA3hvwku2+mLt+ErGkzjVeh6obvKke1n1tTNsnsUNe9m
 btmrRCaOqVcOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 3/4] rust: faux: Allow retrieving a bound Device
To: "Lyude Paul" <lyude@redhat.com>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260612194436.585385-4-lyude@redhat.com>
References: <20260612194436.585385-4-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 20:14:27 +0000
Message-Id: <20260612201428.3DEFB1F00A3A@smtp.kernel.org>
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
- [Low] Missing `// INVARIANT:` comment in `Registration::new` to justify t=
he newly added struct invariant.
- [Low] Documentation typo: states the object is 'bound to a device' instea=
d of 'bound to a driver'.
--

commit 53b3c6bd4c01a202375ed187c918196f25a37895
Author: Lyude Paul <lyude@redhat.com>

rust: faux: Allow retrieving a bound Device

This commit updates faux::Registration to implement AsRef for a
device::Device<device::Bound>. It relies on the registration object being
proof that a driver is bound to the device.

> diff --git a/rust/kernel/faux.rs b/rust/kernel/faux.rs
> index 43b4974f48cd2..36c92ae2943c0 100644
> --- a/rust/kernel/faux.rs
> +++ b/rust/kernel/faux.rs
> @@ -25,7 +25,8 @@
>  ///
>  /// # Invariants
>  ///
> -/// `self.0` always holds a valid pointer to an initialized and register=
ed [`struct faux_device`].
> +/// - `self.0` always holds a valid pointer to an initialized and regist=
ered [`struct faux_device`].
> +/// - This object is proof that the object described by this `Registrati=
on` is bound to a device.

[Severity: Low]
This isn't a bug, but there appears to be a typo in the documentation. The
invariant states the object is bound to a "device", but the commit message
and the code (device::Device<device::Bound>) indicate it should be bound
to a "driver". Should this be updated to say "bound to a driver"?

[Severity: Low]
This isn't a bug, but since a new invariant was added here, does it need to
be explicitly justified when the struct is constructed?

According to the subsystem guidelines, constructing a struct with an
# Invariants section requires an // INVARIANT: comment explaining why the
invariants are satisfied.

Looking at Registration::new():

    // The above function will return either a valid device, or NULL on fai=
lure
    // INVARIANT: The device will remain registered until faux_device_destr=
oy() is called, which
    // happens in our Drop implementation.
    Ok(Self(NonNull::new(dev).ok_or(ENODEV)?))

Could we add a comment here justifying the new invariant about the driver
being bound?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612194436.5853=
85-1-lyude@redhat.com?part=3D3
