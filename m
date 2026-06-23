Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8CFCDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 21:12:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0656810ECC9;
	Tue, 23 Jun 2026 21:12:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GBaZnHxt";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3C1A10ECC9
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 21:11:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8CF7143332;
 Tue, 23 Jun 2026 21:11:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB131F000E9;
 Tue, 23 Jun 2026 21:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782249118;
 bh=JO571RD5CiFzZtlEhXzGzTNX36hZ3vHw609NYWPAILw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GBaZnHxt2Ya4C49fvapbDw88bUcX92EjSojOLKEu3kHPsDIc1SjdmRGHxn3e++1xD
 BxdpXU9n5Gl9H7dbMzNqJYoWdtl1+rXLXtS5ZRI1Biay9helEuo8FMv17tz/d/fxWb
 8OLxK1fCjTrgegAtZ3W7uqecxg1YKpDxT0zz2XwxFXRap4dXaS2fr2QLvlVxWfuTHg
 VNLKyMTHG9VpVV/q+3brDSHRdheloYRM4DuBbjXCycqHiNG4tXGr9QHxWLBxJvXDD0
 qE8GqyKz1ODWokhDMYHAEXdo2W1lhPRsU9ShN+Tum1zvCLa2s0a1eW/IN0HSFaK9zz
 bJcbW57rsxUwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/6] drm/doc: Document DRM_WEDGE_RECOVERY_COLD_RESET
 recovery method
To: "Mallesh Koujalagi" <mallesh.koujalagi@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260622131458.144873-11-mallesh.koujalagi@intel.com>
References: <20260622131458.144873-8-mallesh.koujalagi@intel.com>
 <20260622131458.144873-11-mallesh.koujalagi@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 21:11:57 +0000
Message-Id: <20260623211158.4CB131F000E9@smtp.kernel.org>
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
- [Medium] The example recovery script fails to find the power control slot=
 for directly connected PCI devices due to starting its sysfs traversal one=
 level too high.
- [Low] The new table row for `cold-reset` exceeds the column width defined=
 by the reStructuredText table underlines, which will cause a 'Malformed ta=
ble' warning and break documentation builds.
--

commit affb0b839cc810c897bbc60a895efd262a86bba0
Author: Mallesh Koujalagi <mallesh.koujalagi@intel.com>

drm/doc: Document DRM_WEDGE_RECOVERY_COLD_RESET recovery method

This patch documents the WEDGED=3Dcold-reset recovery method, which is
used when a device requires a complete power cycle to recover from
an error condition. It also adds an example userspace recovery script.

> diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.=
rst
> index 93df92c4ac8cf..43cdac65d04f0 100644
> --- a/Documentation/gpu/drm-uapi.rst
> +++ b/Documentation/gpu/drm-uapi.rst
[ ... ]
> @@ -441,6 +441,7 @@ following expectations.
>      rebind          unbind + bind driver
>      bus-reset       unbind + bus reset/re-enumeration + bind
>      vendor-specific vendor specific recovery method
> +    cold-reset      remove device + slot power cycle + rescan
>      unknown         consumer policy
>      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

[Severity: Low]
Will this exceed the column width defined by the reStructuredText table
underlines?

The Sphinx docutils parser treats table underlines as strict column width
boundaries. The second column's underline is 40 characters long, but the
new text 'remove device + slot power cycle + rescan' is 41 characters.

This usually causes a malformed table warning which can break kernel
documentation builds that treat warnings as errors.

[ ... ]
> @@ -530,6 +542,77 @@ Recovery script::
[ ... ]
> +    PCI_DEVS=3D/sys/bus/pci/devices
> +    PCI_SLOTS=3D/sys/bus/pci/slots
> +
> +    syspath=3D$(readlink -f "/sys/$1/device" 2>/dev/null || readlink -f =
"/sys/$1" 2>/dev/null)
> +    [ -n "$syspath" ] || die "cannot resolve sysfs path for: $1"
> +
> +    dev=3D$(basename "$syspath")
> +    [ -e "$PCI_DEVS/$dev" ] || die "not a PCI device: $dev"
> +    echo "device : $dev"
> +
> +    slot=3D""
> +    walk=3D$(dirname "$(readlink -f "$PCI_DEVS/$dev")")
> +
> +    while true; do
> +        ancestor=3D$(basename "$walk")

[Severity: Medium]
Does using dirname here skip the device's own sysfs path, causing the script
to compare the parent bridge's address to the slot's child address?

When the script executes, it initializes walk using dirname, which skips the
target device. It compares the parent bridge's address against the slot
address attribute.

However, hotplug slot address attributes contain the address of the child
(the device plugged into the slot), not the parent bridge. This could cause
the script to fail to find the power control slot for directly connected PCI
devices and abort with a 'no hotplug slot' error.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622131458.1448=
73-8-mallesh.koujalagi@intel.com?part=3D3
