Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D9EC61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:58:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B5E610E323;
	Wed, 26 Aug 2026 16:58:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eVv1sBQA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 783A610E322
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 16:58:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4386E40D68;
 Wed, 26 Aug 2026 16:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0494E1F00A3A;
 Wed, 26 Aug 2026 16:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787763536;
 bh=LLv5ZyrSPQUzSePEUOB8eyEVQQaOnBDV2ezBKxFfIjQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eVv1sBQAyuT0y6kd92H2hQWUOnE4Ck3esg6T+7ComPS7IcxXll+6SMB3WjSe0Fhdq
 16/cU0XTtwvPpLdyRN/O9rQJTGCO+8Ilyv/om2/DTrHcEdmOgv1Gecw1ZEVzivyGXI
 6RKO8omTzkPreqkkrn/AowltxB7V9k1CzAuuJZciHrJNVTmoGPd06rnpRLp1CP9H1T
 xB3i8ma0koqV+u6AWVvcNqAorizBZ8OMWc+X0o1tHc7fMS8P+Kl+CnJpD4odmDnAwD
 1yEBZ9eU+zOKg3scRmX9/J60N4P4xXCbPd1VjQe7Hs0S+gU6WjoRaY29oe2dMLt2op
 myI+mw3QgtzOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/13] drm/vino: read the dock's firmware version,
 and update it over DFU
To: "Mike Lothian" <mike@fireburn.co.uk>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260826163913.7052-11-mike@fireburn.co.uk>
References: <20260826163913.7052-1-mike@fireburn.co.uk>
 <20260826163913.7052-11-mike@fireburn.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 16:58:55 +0000
Message-Id: <20260826165856.0494E1F00A3A@smtp.kernel.org>
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
- [High] The automatic update path in `update_if_newer` fails to verify tha=
t the firmware package matches the dock's hardware family, allowing a misma=
tched firmware file to permanently brick the dock.
- [Medium] Infinite update loop and data race due to a single shared non-at=
omic rate-limit slot (`UPDATE_ATTEMPTS`).
--

commit 872c2fc3f8d6d143ff1f9c6026fbab419e5a21e3
Author: Mike Lothian <mike@fireburn.co.uk>
Subject: drm/vino: read the dock's firmware version, and update it over DFU

A DisplayLink dock does not advance bcdDevice when its firmware changes. Th=
is
patch adds parsers for the dock's identity descriptor and shipped firmware
package, and applies updates automatically over USB DFU if the packaged
version is strictly newer. It also provides a manual upload interface.

> diff --git a/drivers/gpu/drm/vino/firmware.rs b/drivers/gpu/drm/vino/firm=
ware.rs
> new file mode 100644
> index 0000000000000..13c9cff55ae48
> --- /dev/null
> +++ b/drivers/gpu/drm/vino/firmware.rs
[ ... ]
> +fn claim_update_attempt(dev: &Device) -> bool {
> +    let key =3D attempt_key(dev);
> +    let slot =3D UPDATE_ATTEMPTS.load(Ordering::Acquire);
> +    let count =3D if slot & ATTEMPT_KEY_MASK =3D=3D key {
> +        slot as u32
> +    } else {
> +        0
> +    };
> +    if count >=3D MAX_UPDATE_ATTEMPTS {
> +        return false;
> +    }
> +    UPDATE_ATTEMPTS.store(key | u64::from(count + 1), Ordering::Release);
     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Medium]
Could this non-atomic read-modify-write on the shared global UPDATE_ATTEMPTS
variable cause an infinite update loop?

If two docks are connected that require an update, and both fail to apply it
successfully, they might re-enumerate and probe continuously. Because
claim_update_attempt() loads and then stores on a single global slot, it lo=
oks
like the two docks might continuously evict each other's attempt counts.

This could prevent either dock from reaching MAX_UPDATE_ATTEMPTS to break
the loop, which might lead to constant USB bus resets and flash memory wear=
-out.

Similarly, clear_update_attempts() performs a non-atomic check-and-clear
that might race with this logic and clear another device's freshly recorded
attempts:

    if UPDATE_ATTEMPTS.load(Ordering::Acquire) & ATTEMPT_KEY_MASK =3D=3D ke=
y {
        UPDATE_ATTEMPTS.store(0, Ordering::Release);
    }

[ ... ]
> +pub(crate) fn update_if_newer(
> +    io: &usb::Io<'_>,
> +    dev: &Device,
> +    identity: &Identity,
> +    iface: u16,
> +    force: bool,
> +) -> Result {
[ ... ]
> +    let Some(packaged) =3D package_version(fw.data()) else {
> +        dev_warn!(dev, "{} carries no version tag; ignoring it\n", name);
> +        return Ok(());
> +    };
> +    if packaged <=3D identity.version && !force {
> +        clear_update_attempts(dev);
> +        vino_dev_debug!(dev, "firmware is current ({} offers {})\n", nam=
e, packaged);
> +        return Ok(());
> +    }
[ ... ]
> +    dev_info!(
> +        dev,
> +        "updating dock firmware {} -> {}{}\n",
> +        identity.version,
> +        packaged,
> +        if force { " (forced)" } else { "" }
> +    );
> +    flash(io, iface, fw.data())
       ^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Should this automatic update path verify that the firmware package matches
the dock's hardware family before flashing?

The manual upload path (Upload::prepare) uses package_family(image) and
refuses to flash if the family does not match the hardware. However,
update_if_newer() only checks the version and relies on the filename.

If a mismatched firmware file is inadvertently placed in /lib/firmware/vino=
/,
it appears this would silently flash the incompatible image and permanently
render the dock unusable, circumventing the safety check implemented for
manual uploads.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826163913.7052=
-1-mike@fireburn.co.uk?part=3D10
