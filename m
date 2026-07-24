Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15BEC531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 10:13:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12D5D10F349;
	Fri, 24 Jul 2026 10:13:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Io3uIUW7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2A5110F349
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 10:13:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BBFBA600AD;
 Fri, 24 Jul 2026 10:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE171F00A3E;
 Fri, 24 Jul 2026 10:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784888020;
 bh=ltkQubDNiWoE5txDd8/6t2qPd1LT3LiwdriZgzKyyl4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Io3uIUW7sNm6JtLbO/2Km/UlXHpGwMT0PBquclUZQH3qoYzMwWhW7vt3tVnHbfhbp
 aBLj/4inB+lpmZqAZQgujeX1ejEwdUmPzEroYWKZhdVTy5hq3f6NFlHlHL6H0NswH5
 7SLRjSLtSdI8kuaPb7oIMo+dBG3anCOzP2K4bNSGRXDSMg9NXZd0HUGGi2m76qWYIh
 q0D/4hIwUcBjz/Do00/043QwXWlofEgBekT71ZDWVlw4JGjaab1O/cSoodtV+Rb4YT
 EOYG3RiMXUTYb2vvNrDaqWBYKubH9mbD242mr/WvT1UzxuUxJDV0lyy72EKF0UFNKH
 35bycfHQEXjcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 2/4] drm/doc: Document DRM_WEDGE_RECOVERY_COLD_RESET
 recovery method
To: "Mallesh Koujalagi" <mallesh.koujalagi@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260724100302.706685-8-mallesh.koujalagi@intel.com>
References: <20260724100302.706685-6-mallesh.koujalagi@intel.com>
 <20260724100302.706685-8-mallesh.koujalagi@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 10:13:39 +0000
Message-Id: <20260724101340.3EE171F00A3E@smtp.kernel.org>
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
- [Medium] The cold-reset recovery script fails to find the hotplug slot fo=
r standard single-endpoint PCIe GPUs because it starts its search at the pa=
rent bridge, skipping the device itself.
--

--- Patch [2]: [PATCH v12 2/4] drm/doc: Document DRM_WEDGE_RECOVERY_COLD_RE=
SET recovery method ---
commit 40a35f3de596a4e78fa7c7c9f9433ec0c0f1b456
Author: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
drm/doc: Document DRM_WEDGE_RECOVERY_COLD_RESET recovery method

This commit adds documentation for the new "cold-reset" wedge recovery
method. It updates the expectations table and provides an example udev
rule and recovery script to perform a cold reset by removing the device,
toggling slot power, and rescanning the PCI bus.

> diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.=
rst
> index 93df92c4ac8cf..52255247a6db9 100644
> --- a/Documentation/gpu/drm-uapi.rst
> +++ b/Documentation/gpu/drm-uapi.rst
[ ... ]
> @@ -530,6 +542,77 @@ Recovery script::
>      echo -n $DEVICE > $DRIVER/unbind
>      echo -n $DEVICE > $DRIVER/bind
> =20
> +Example - cold-reset
> +--------------------
> +
> +Udev rule::
> +
> +    SUBSYSTEM=3D=3D"drm", ENV{WEDGED}=3D=3D"cold-reset", DEVPATH=3D=3D"*=
/drm/card[0-9]", \
> +    RUN+=3D"/path/to/cold-reset.sh $env{DEVPATH}"
> +
> +Recovery script::
> +
> +    #!/bin/sh
> +    die() { echo "ERROR: $*" >&2; exit 1; }
> +
> +    [ -n "$1" ] || die "Usage: $0 <device-path>"
> +
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

[Severity: Medium]
Will this fail to find the hotplug slot for standard single-endpoint PCIe G=
PUs?

By initializing walk with dirname here, the script appears to start its sea=
rch
at the parent bridge, skipping the device itself. Since the device's own
address typically matches the hotplug slot address, this skips checking the
device's slot and will result in no hotplug slot being found for single
endpoint devices.

> +
> +    while true; do
> +        ancestor=3D$(basename "$walk")
> +        case "$ancestor" in pci*) break ;; esac  # reached the virtual b=
us root

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724100302.7066=
85-6-mallesh.koujalagi@intel.com?part=3D2
