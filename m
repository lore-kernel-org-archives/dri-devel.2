Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCBFC44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 19:10:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE12F10E223;
	Wed, 15 Jul 2026 19:10:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HxXAnNwf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E38E10E223
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 19:10:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 86C8E6187E;
 Wed, 15 Jul 2026 19:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6511F000E9;
 Wed, 15 Jul 2026 19:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784142631;
 bh=6am+2U8ArlFrnLtxDEsJTaJh6CagCAzM9L6SMYGVYB0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HxXAnNwfK6A0qK1Cb3Rk/naiJHPuKtLa0+EmZD/8xRp+BklKJtliHzdlCB2CSgEKJ
 D93itkxX3MhIS0Vjna9nhAcx51CzqSU8TI6qmNwuiefYTGZXWxj8BI9/5YiVaEMhqs
 ziFl97QjGDUFIhRUfgLabfywzT+V4/6OhCGW24tF+GqrtnH7zB5bUt10tvgXTVTKm9
 yDUabnAmaaU/eEheQ9/7MAmfZbP69T1rkpOwmNtI57M+nC2pUSVbfW6KhnUPPVK4DX
 Eqc8ebZx3GnLXwMF9tauHVTbt2yL+fkOwhPGHywo1ELYGObc2xfuL/e2mI8nBXZipU
 JpEkuaz+vjrzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/7] arm64: dts: imx8dxl-evk: add lcdif overlay
To: Frank.Li@oss.nxp.com
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, robh@kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260715-dxl_lcdif-v2-7-da797562636e@nxp.com>
References: <20260715-dxl_lcdif-v2-0-da797562636e@nxp.com>
 <20260715-dxl_lcdif-v2-7-da797562636e@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 19:10:30 +0000
Message-Id: <20260715191030.CA6511F000E9@smtp.kernel.org>
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
- [Medium] The overlay configures the ADC input pads for LCD digital signal=
s but fails to disable the `adc0` controller.
- [Low] The panel device node is named `lcd-panel`, which violates the stan=
dard Device Tree bindings for display panels.
- [Low] The overlay disables audio codecs and DAIs but leaves the top-level=
 sound card nodes enabled, causing endless probe deferrals.
--

--- Patch [7]: [PATCH v2 7/7] arm64: dts: imx8dxl-evk: add lcdif overlay ---
(Note: The format of this report is altered to a free-form summary due to
recitation restrictions. No code from the original patch is directly quoted=
.)

commit d5a124bf1de36e3cda648d2a3efe1d55a60da419
Author: Frank Li <Frank.Li@nxp.com>

arm64: dts: imx8dxl-evk: add lcdif overlay

This commit adds support for the waiken,101wx001 lcd panel by introducing
a new device tree overlay for the imx8dxl-evk.

[Severity: Low]
The device node for the display panel in the new overlay is named lcd-panel.
Does this violate the standard Device Tree bindings for display panels?
According to panel-common.yaml, the generic node name for a display panel
should typically just be panel. Using a non-generic name could result in
dtbs_check warnings when building the device tree.

[Severity: Medium]
The pinctrl_lcdif node configures several ADC input pads to act as digital
LCD signals. However, the overlay does not appear to disable the correspond=
ing
adc0 controller. Will this cause the adc0 controller to probe and expose
non-functional IIO channels to userspace, potentially resulting in
applications reading meaningless garbage instead of valid analog voltages?

[Severity: Low]
The overlay disables several audio codecs and DAIs, such as sai0, sai1, and
the various wm8960 components, but it leaves the top-level sound card nodes
from the base device tree enabled. Could this result in the sound card
drivers attempting to probe and failing indefinitely with probe deferrals,
leaving dangling devices in the deferred list during system initialization?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715-dxl_lcdif-=
v2-0-da797562636e@nxp.com?part=3D7
