Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F96AC55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 07:20:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72AD710E1EA;
	Wed,  5 Aug 2026 07:20:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Y2VpHSWP";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25DD010E1EA
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 07:20:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BE21A407F6;
 Wed,  5 Aug 2026 07:20:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779E21F000E9;
 Wed,  5 Aug 2026 07:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785914450;
 bh=SEK8KUoX+/nCwmjlEB1n5zjYubkh5kiqbxTD1gVfhpA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Y2VpHSWPeWN7RMlCBtemNicqCOTXuXsT/VlJn2wM6tRVPehdGk25lmmER/8L/TPiq
 wNe+cqCrW/1Pwjbx/jio7KbcWyX4tNPrII77RO+nX5KDG55HATtLrnY51eBgUPcrjE
 kTiIYQxlOdVDTyOSYIcWTO7MVMCHgD1R5PN31CoXqt0IRBxq7BgjtOPxUvUxl06Npf
 7zhuVciY9GHG3Wx66tWziErtdk3xaF9Zr4feLRkongVC/2Vd7yjMdCXdDpoqz4Dp3Q
 iWjMOliMuhKA0U75RZEd47O2UUqmo1yZDbCFmjl+onmfQijk0RcxTPhO42nHeJ6fzZ
 StAcwDSqfj0Cg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 2/4] drm/doc: Document DRM_WEDGE_RECOVERY_COLD_RESET
 recovery method
To: "Mallesh Koujalagi" <mallesh.koujalagi@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260805071152.1225416-8-mallesh.koujalagi@intel.com>
References: <20260805071152.1225416-6-mallesh.koujalagi@intel.com>
 <20260805071152.1225416-8-mallesh.koujalagi@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 07:20:50 +0000
Message-Id: <20260805072050.779E21F000E9@smtp.kernel.org>
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
- [Medium] The example `cold-reset.sh` script fails to find native PCIe hot=
plug (pciehp) slots for directly attached devices because it initializes it=
s topology traversal with the parent directory of the device, skipping the =
device's own PCI address which is what actually matches the hotplug slot's =
`address` attribute.
--

--- Patch [2]: [PATCH v13 2/4] drm/doc: Document DRM_WEDGE_RECOVERY_COLD_RE=
SET recovery method ---
commit ae4802bfe15243552790a2e115f55653f35d380a
Author: Mallesh Koujalagi <mallesh.koujalagi@intel.com>

drm/doc: Document DRM_WEDGE_RECOVERY_COLD_RESET recovery method

This commit adds documentation for the WEDGED=3Dcold-reset recovery method
in the DRM subsystem. It explains the consumer expectations and provides
an example udev rule alongside a recovery script for cycling PCIe slot powe=
r.

> diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.=
rst
> index 93df92c4ac8cf..52255247a6db9 100644
> --- a/Documentation/gpu/drm-uapi.rst
> +++ b/Documentation/gpu/drm-uapi.rst
[ ... ]
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
[ ... ]
> +    dev=3D$(basename "$syspath")
> +    [ -e "$PCI_DEVS/$dev" ] || die "not a PCI device: $dev"
> +    echo "device : $dev"
> +
> +    slot=3D""
> +    walk=3D$(dirname "$(readlink -f "$PCI_DEVS/$dev")")

[Severity: Medium]
Does this topology traversal intentionally skip the device's own PCI addres=
s?

By initializing walk with the parent directory via dirname, it appears the
script will miss the device itself when checking for matching hotplug slot
addresses in the loop below. This seems like it could cause the script to f=
ail
to find native PCIe hotplug slots for directly attached devices, leading to=
 a
"no hotplug slot with power control found" error when users try to run it.

> +
> +    while true; do
> +        ancestor=3D$(basename "$walk")
> +        case "$ancestor" in pci*) break ;; esac  # reached the virtual b=
us root
> +
> +        ancestor_nofn=3D${ancestor%.*}  # strip function: 0000:03:01.0 -=
> 0000:03:01
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805071152.1225=
416-6-mallesh.koujalagi@intel.com?part=3D2
