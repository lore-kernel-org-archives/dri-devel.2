Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78F9CD6E79
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 18:41:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0496110F8A2;
	Mon,  8 Jun 2026 18:41:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Mp1e6MaU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1822810F8A2
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 18:41:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E8B6F43AC5;
 Mon,  8 Jun 2026 18:41:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B421F00899;
 Mon,  8 Jun 2026 18:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780944107;
 bh=fCLzcfOY9PYRjSsxQIjOzXHIWil3fCWwDCJG4OiGLZU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Mp1e6MaUYmmwt772AA0PDgiEMA7uAOTbAYiMmQzs1hjN8bT8CHm/zd8z2dPJ0Gvkb
 JEl18JbZe+RfOWuEWLMsvKwHtpKqtLxmXSiePSSBfq5so/UNFC8/LFXhbBQGhPoPGx
 aim7M2O4ZPhMZo8dbfgwN3mMPl5L7Suzcd26Ovc8m9yeiE4Djq8mavRgOaQWaal9LR
 kQdafvewUFjwl2W/k2Nsk6/d8nN6fD1/ZBVtiuGumilwXI10yVtVaUZv5SuRlH6xWu
 iclzpDexCQY9wZF4emi73+sAw4a3LyJyFv1X/WB2aTZLHGJkrNeTnSK3LOmo8/raXY
 gpMnw6FhHNQvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 3/4] rust: faux: Allow retrieving a bound Device
To: "Lyude Paul" <lyude@redhat.com>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260608183057.2001376-4-lyude@redhat.com>
References: <20260608183057.2001376-4-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 18:41:47 +0000
Message-Id: <20260608184147.A5B421F00899@smtp.kernel.org>
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
- [Low] Missing invariant justification and typographical error in newly ad=
ded type invariant.
--

commit c766343de61d0beee77e4a7b0e0b4da2f1f15d4d
Author: Lyude Paul <lyude@redhat.com>

rust: faux: Allow retrieving a bound Device

This commit modifies the Registration object to allow retrieving a bound
Device, implementing AsRef for the Bound device context. It also updates the
struct invariants to document that the registration serves as proof that
the device is bound.

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
Does this documentation contain a typographical error? In the Linux device
model, a device binds to a driver.

Additionally, since a new type invariant is added here, does the constructor
need an updated invariant justification?

Looking at Registration::new(), the comment only justifies the first
invariant:

    // INVARIANT: The device will remain registered until
    // faux_device_destroy() is called, which happens in our Drop
    // implementation.
    Ok(Self(NonNull::new(dev).ok_or(ENODEV)?))

Should this comment be updated to explain why the new invariant holds, such
as explaining that the driver handles binding implicitly during
registration?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608183057.2001=
376-1-lyude@redhat.com?part=3D3
