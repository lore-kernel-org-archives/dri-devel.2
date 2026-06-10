Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9117CD8CB2
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:37:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DA8A10E8CE;
	Wed, 10 Jun 2026 16:37:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cKd8fjHz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5797C10E8CE
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 16:37:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 778F7601F4;
 Wed, 10 Jun 2026 16:37:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248F21F00898;
 Wed, 10 Jun 2026 16:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781109462;
 bh=Bf/3EEORsEQ7k/iqQRvECPje6PEBA1iDrxlQJu4KlNU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cKd8fjHzW9+ad3WY5NDyCO2zRUjyWLiShU4eCqQ/1+RFX/3N9o2Y5xXv0HmvsCKm6
 BuZxBr8my42DfHzpfP3tSbNVrdD30dbajx6Jfz9m7XlOJkO2I+cRBsI8QO0ZzDJacK
 /uIagsWx6FA4av/B/xiScuPLK3LLMDHb1tQ8OvlUF8O+LEL6Gcx0/EG0yk7sustkYW
 V/5SI19AXdhM+6bITWr7GYk2HmfqRskcusT0xcPC6rnvw47UhFWWBkvTkiN1D8YDPa
 6a8aq4+So/0BpMoAKlveasT0lipK5zuzFigCVpZfjGk6w6a7N3gOtWGjgvKuJ/1JNt
 P6ITGSbzqUlbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 3/4] rust: faux: Allow retrieving a bound Device
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260610162433.923550-4-lyude@redhat.com>
References: <20260610162433.923550-4-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 16:37:41 +0000
Message-Id: <20260610163742.248F21F00898@smtp.kernel.org>
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
- [Low] The newly added invariant comment incorrectly states the faux devic=
e is 'bound to a device' instead of 'bound to a driver'.
- [Low] Missing `// INVARIANT:` comment justification for the newly added t=
ype invariant in the constructor `Registration::new()`.
--

commit 4f6cdb361b5df7689eb3f97b5d9628c28576af9e
Author: Lyude Paul <lyude@redhat.com>

rust: faux: Allow retrieving a bound Device

This commit allows retrieving a Bound device context from a faux::Registrat=
ion
by implementing AsRef<device::Device<device::Bound>>. It also adds a new ty=
pe
invariant stating that the Registration object proves the device is bound.

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
This isn't a bug, but should this say "bound to a driver" instead of "bound=
 to
a device"? A faux device is bound to a driver, not another device.

[Severity: Low]
Since a new invariant was added here, does Registration::new() need an upda=
ted
// INVARIANT: comment to justify it?

According to the subsystem guidelines, when a struct with an # Invariants
section is constructed, there must be a corresponding // INVARIANT: comment.
The current constructor only justifies the first invariant:

rust/kernel/faux.rs:Registration::new() {
    ...
        // The above function will return either a valid device, or NULL on=
 failure
        // INVARIANT: The device will remain registered until faux_device_d=
estroy() is called, which
        // happens in our Drop implementation.
        Ok(Self(NonNull::new(dev).ok_or(ENODEV)?))
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610162433.9235=
50-1-lyude@redhat.com?part=3D3
