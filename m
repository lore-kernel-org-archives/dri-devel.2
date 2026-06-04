Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD9CCD6E6E
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 19:40:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4284F11A296;
	Thu,  4 Jun 2026 19:40:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iw8f/6Gl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5A7C1129A1
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 19:40:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8CEF24081D;
 Thu,  4 Jun 2026 19:40:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1061F00898;
 Thu,  4 Jun 2026 19:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780602000;
 bh=JUZGVwwj4HQZStIJDtddQfc5ylHGqjVREYOjtLPaXRg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iw8f/6GlvMuFSLrZJ89zyVjBcqd9EsmTKjn+ytycT7Ij5oWhuvkaR/itO7ELGTYyD
 vzYdVKbTQpzBl+T7H/52KMq68K3GEKqktO2PkhjLPQFLaCkr5J0b1oG4VjuvLsGEaB
 EN6VsXXtI//a2UtPEFTKdJL/CLex4VED0Gq/6GGXsz22hCQ+mQgnAvT37Dvb2FuLht
 UjjTxMpUgDLfovIMIvjM85lZBX0bPTpMVO1M7cfFkZ0OQliuechBC7bvHLqCbsBkVz
 pVWTED0GLdDZ6K2QpKXVu2Rar+ZYsve4YNPp0Kckbx4LdMuC1AYiqfoIy68+XNFoX0
 VWsITjHIAyNyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 3/4] rust: faux: Allow retrieving a bound Device
To: "Lyude Paul" <lyude@redhat.com>
Cc: linux-media@vger.kernel.org, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260604192740.659240-4-lyude@redhat.com>
References: <20260604192740.659240-4-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 19:39:59 +0000
Message-Id: <20260604194000.3F1061F00898@smtp.kernel.org>
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
- [Low] The `Registration` struct's `# Invariants` documentation was update=
d with a new invariant, but the `// INVARIANT:` comment in the `Registratio=
n::new` constructor was not updated to explain why this new invariant is sa=
tisfied.
- [Low] Typo in the new type invariant comment: it incorrectly states the o=
bject is 'bound to a device' instead of 'bound to a driver'.
--

commit d541fc9c1199eb4e3a390c6348b6b03f9492aacc
Author: Lyude Paul <lyude@redhat.com>

rust: faux: Allow retrieving a bound Device

This commit updates faux::Registration to implement AsRef for a bound
device instead of a generic device. It also adds a new invariant to the
Registration struct to document that the object is proof of a driver being
bound to the device.

> diff --git a/rust/kernel/faux.rs b/rust/kernel/faux.rs
> index 43b4974f48cd2..20ab638885354 100644
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
This isn't a bug, but there appears to be a typo here. The commit message
states that the Registration object is proof that "a driver is bound to the
device". Should this invariant say it is bound to a "driver" instead of
a "device"?

[Severity: Low]
Since a new invariant was added to the documentation here, does the
// INVARIANT: comment in Registration::new() also need to be updated to
explain why this new invariant is satisfied?

Currently, the comment in Registration::new() only explains the first
invariant:

    // INVARIANT: The device will remain registered until faux_device_destr=
oy()
    // is called, which happens in our Drop implementation.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604192740.6592=
40-1-lyude@redhat.com?part=3D3
