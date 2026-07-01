Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A87C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 06:30:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43C0610EDCF;
	Wed,  1 Jul 2026 06:30:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eaqCiZi0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9770C10EDDB
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 06:30:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5D36943829;
 Wed,  1 Jul 2026 06:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154741F000E9;
 Wed,  1 Jul 2026 06:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782887452;
 bh=hpLpFB5nyp3U+NOpXyCwZcfhYtvAgRYs0WuvhJRE7OY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eaqCiZi0KtcGot81bqO8cLfYlL9luzK7gq0/B+x1wK8L3hxJywhhTcyNZlF5xSIiz
 QJuVKIzA6EDm8fI7scsDdv0Fas9PFJLwmWkVYyqadF/t3JapZGPSfocdsxiuw0SYUD
 ypCZOFQ1IwSxCFCoCiIgdzD8rAL1p2Bud2sN87xna0pfJTlgqBqt68o0Re0kN0mlXV
 Vkvdk4wc9JJxB5AxtYgOQ12cIj1btbg0x2ZKy4e11xyumL5ZkFYgMN2rFGgAa6eu3o
 CfYkmymk5HkCLHyzJ2f5d/I9DnVS4UG5b5FgXSv/DirGByOQqaW+CdLhlBZhl4HG3N
 udJXWQ/BspzvQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/2] Documentation: accel: Add NPAC client driver
 documentation
To: "Jaspinder Budhal" <j-budhal@ti.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260701062505.1091840-2-j-budhal@ti.com>
References: <20260701062505.1091840-1-j-budhal@ti.com>
 <20260701062505.1091840-2-j-budhal@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 06:30:51 +0000
Message-Id: <20260701063052.154741F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The proposed design violates kernel architecture by bypassing the =
standard networking stack and misusing the compute accelerator (accel/DRM) =
subsystem for network packet processing and ACL offloads.
- [Low] Usage of deprecated, non-inclusive terminology ('blacklisted').
- [Low] Grammatical error in the documentation regarding command pluralizat=
ion.
--

commit 76a459f24739ffcc1e2f6fc248380fee0d5af75f
Author: Jaspinder Budhal <j-budhal@ti.com>

Documentation: accel: Add NPAC client driver documentation

This commit adds documentation for the Texas Instruments NPAC (Network Pack=
et
ACcelerator) client driver. It details the accelerator's purpose of offload=
ing
network packet processing tasks like ACL rule enforcement. The documentation
also outlines its userspace interface and RPMsg communication model.

> diff --git a/Documentation/accel/npac.rst b/Documentation/accel/npac.rst
> new file mode 100644
> index 0000000000000..fba6ddd0cfd2c
> --- /dev/null
> +++ b/Documentation/accel/npac.rst
[ ... ]
> +When the NPAC host driver announces the NPAC RPMsg service endpoint, the
> +RPMsg core matches the announced service against the registered NPAC cli=
ent
> +driver and invokes the driver probe callback.
> +
> +Offload command received from userspace are formatted into RPMsgs and se=
nt

[Severity: Low]
This isn't a bug, but there is a grammatical error here. Should "command" be
pluralized to "commands" to match the plural verb "are"?

> +to the NPAC Host Driver.
> +
> +NPAC Host Driver responses are received through RPMsg callbacks.
> +
> +ACL Rule Offload
> +----------------
> +
> +ACL (Access Control List) rules are packet filtering policies that defin=
e how
> +network traffic should be handled =E2=80=94 for example, dropping packet=
s from a
> +blacklisted source IP or allowing traffic only from trusted MAC addresse=
s.

[Severity: Low]
This isn't a bug, but the Linux kernel coding style guidelines recommend us=
ing
inclusive terminology. Could "blacklisted" be replaced with "blocklisted" or
"denylisted"?

[ ... ]
> +IOCTL Commands
> +~~~~~~~~~~~~~~
> +
> +DRM_IOCTL_NPAC_ACL_ADD_RULE
> +
> +  This IOCTL allows userspace to add an ACL rule to the accelerator. The

[Severity: High]
Does this UAPI design bypass the established Linux networking subsystem APIs
for packet filtering?

The accel subsystem is generally intended for generic compute, ML, and AI
workloads. Introducing a custom UAPI for network packet filtering via
/dev/accel/accel* and DRM_IOCTL_NPAC_ACL_ADD_RULE bypasses standard
interfaces like tc-flower (via ndo_setup_tc) or netfilter hardware offload.

This custom interface would prevent standard networking utilities such as tc
or nftables from managing these ACLs, and it removes the standard software
fallback path. Should this driver integrate with the standard networking st=
ack
instead of implementing custom DRM IOCTLs?

> +  call will forward the rule to the NPAC host driver for hardware progra=
mming.
> +  The NPAC Host Driver is responsible for validating the rule and applyi=
ng it to
> +  the NPAC hardware.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701062505.1091=
840-1-j-budhal@ti.com?part=3D1
