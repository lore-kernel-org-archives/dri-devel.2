Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297DDC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:47:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8189510E598;
	Mon, 13 Jul 2026 08:47:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dqR2K7lv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA44D10E598
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 08:47:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8B33B432D2;
 Mon, 13 Jul 2026 08:47:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DBCA1F000E9;
 Mon, 13 Jul 2026 08:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783932463;
 bh=YOiWsVYePENIgmiWgGcFF0+UMyuKNwYIHdZl5PwSyTE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dqR2K7lvHusjyFfYN5xFRfZTaIaOze5UKJQhuczky9xmvhEiM2tcIsPGvuqHBMxna
 5cmJy2EGJ/JTrTpbhvS2UQLgJQww7a6IDmynTone05ouX3B41qRlEi6aX6IjZ4inPh
 LJ/WaYTV0nFXsN+EKcTCm2lFMsWZGmL4ELYE+/N2FXPpslHloJcVCefKevYUfi73we
 oQJQfgrh4ZuclXd6J+0SJHSWI8ZgjexB8oZbSBYeBPkh858ASshLkAjuDZhs1/4ejP
 Y+W/JS51/aPc/r9Ni4WOjQxsWG8QzKTbPDgQjjdWaeRAu9SI9ET0UBPEMZtyuyvkc7
 pdrHRB69fZ97w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 3/4] drm/doc: Document DRM_WEDGE_RECOVERY_COLD_RESET
 recovery method
To: "Mallesh Koujalagi" <mallesh.koujalagi@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260713083939.251872-9-mallesh.koujalagi@intel.com>
References: <20260713083939.251872-6-mallesh.koujalagi@intel.com>
 <20260713083939.251872-9-mallesh.koujalagi@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 08:47:42 +0000
Message-Id: <20260713084743.4DBCA1F000E9@smtp.kernel.org>
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
- [Medium] Missing udev rule line continuation causes the example recovery =
script to execute for every system uevent.
--

--- Patch [3]: [PATCH v10 3/4] drm/doc: Document DRM_WEDGE_RECOVERY_COLD_RE=
SET recovery method ---
commit 38af50f95ad4b618e8f2b464d3185bfdd320b4f3
Author: Mallesh Koujalagi <mallesh.koujalagi@intel.com>

drm/doc: Document DRM_WEDGE_RECOVERY_COLD_RESET recovery method
   =20
This commit documents the cold-reset recovery method for devices that encou=
nter
unrecoverable errors. It provides an example udev rule and shell script to
handle cutting and restoring power to the PCIe slot.

> diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.=
rst
> index 93df92c4ac8cf..43294a10738e6 100644
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
/drm/card[0-9]",
> +    RUN+=3D"/path/to/cold-reset.sh $env{DEVPATH}"

[Severity: Medium]
Since udev rules are line-based, does missing a line continuation character
(\) here cause the second line to be parsed as a standalone, unconditional
rule?

If an administrator copies this example verbatim, it appears that
cold-reset.sh might be executed for every single system uevent. While the
script exits early for non-PCI devices, spawning a shell script for every
uevent (add, remove, change, etc.) could cause severe system performance
degradation and boot delays.

> +
> +Recovery script::
> +
> +    #!/bin/sh
> +    die() { echo "ERROR: $*" >&2; exit 1; }
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713083939.2518=
72-6-mallesh.koujalagi@intel.com?part=3D3
