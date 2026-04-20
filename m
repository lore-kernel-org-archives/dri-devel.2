Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B080F327B2
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:10:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16FE310EB86;
	Tue, 21 Apr 2026 07:09:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=interstellar.eu header.i=@interstellar.eu header.b="fGXYTsrm";
	dkim-atps=neutral
Received: from mail-244102.protonmail.ch (mail-244102.protonmail.ch
 [109.224.244.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF01010E6DD
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 16:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interstellar.eu;
 s=protonmail; t=1776701051; x=1776960251;
 bh=EHD+jNGmtCIwewdl2slSqoZLTvzslQVmqjzLxGpvjH8=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=fGXYTsrmNcjgrAt9o9YXSIxZ3IEHaB82H7BSSoqNGns7HAbtkskRbOYlItfiWA6zD
 fHxIuGcEZHhmaajLBAY5dhwuLePD2p/e2X7FPmJu1HhmcyPIngoirZNf4ruGiENa4y
 biE60iqbRNxMzIzSyqLwcn9wgAN5y9r/o8R++np6RlVlhK/Gxz/9I2hDeHJOUatETZ
 mFTeaDZOTpn5/pH6oddAgbDmnaOXq7nbM6KBlLwu3dvkOa24iTJFPdRgm4UryYXTiZ
 T1ZMnRf4kf6gWlqcaG+hRVmYZsQEPOaB9rCroSawwIbd+ALjWGezrOUhr/Wpnd2z7R
 8ropNTyJGLixg==
Date: Mon, 20 Apr 2026 16:04:02 +0000
To: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
From: Francesco Orro <ncesco@interstellar.eu>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>
Subject: DP routing from iGPU to discrete Barlow Ridge TB5 on HP ZBook Fury G1i
Message-ID: <pCmilDgt3Xijjdzu7H1d30dzm8IJbXFnle3yQ5nSR1Pj-snchn5xNpcq9Gb7hlh5bnsA3Efnm9cOR_VKi9RyxcRJxHlrqTW7WRPG36UgY5Q=@interstellar.eu>
Feedback-ID: 1431670:user:proton
X-Pm-Message-ID: a6fec4719cc597c7f6e7f78b765ddbf4c1ff23ad
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 21 Apr 2026 07:09:47 +0000
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi,

Setup:
  HP ZBook Fury G1i 16 inch, BIOS X96 01.03.04
  Intel Arrow Lake-HX + Nvidia RTX PRO 1000 Blackwell (hybrid graphics)
  Kernel 6.19.13

The laptop exposes Thunderbolt 5 on both the integrated MTL iTBT (right
USB-C, domain0, 00:0d.2) and a discrete Intel Barlow Ridge (left USB-C,
domain1, 00:06.1 -> 05:00.0).

- Right port: i915 drives a DP tunnel over the iTBT host without issues.
- Left port: no i915 connector ever sees the external monitor. The TB
  driver allocates a DP tunnel on demand but DPRX reads time out, no DP
  source is feeding the Barlow DP_IN adapter.
- With nvidia-drm.modeset=3D1, a DP-MST connector on the Nvidia DRM device
  sees the monitor via the left port (EDID readable, modes negotiated).
  The path Nvidia -> Barlow DP_IN is functional.

Current hypothesis: on this board the discrete Barlow Ridge DP_IN is
either hardwired to a Nvidia output or behind a firmware-programmed mux
that BIOS latches to Nvidia at POST and is not exposed to the OS. i915
would therefore have no path to drive the left ports, by design.

Tests done that did not surface an OS-visible lever:
- i2cdetect across all SMBus/i801 busses: no DP mux/retimer at plausible
  addresses (0x60-0x7F).
- DSDT/SSDT dump (iasl -d): no Device/Method referring to DP routing,
  DPMUX, retimer programming, or dock display source selection.
- HP WMI + /sys/devices/virtual/firmware-attributes/hp-bioscfg attribute
  enumeration: nothing switching dock display source. "Graphics"
  attribute only offers Hybrid/Discrete.
- PCI config dump of Barlow Ridge: standard USB4 NHI, no vendor-specific
  capability hinting at source selection.
- acpi.no_usb4_osc kernel param (locally patched) to opt out of OSC USB4
  native support: no change in i915 visibility of the dock.

Is there any known way to route an Intel DDI output to a PCIe-attached
Barlow Ridge DP_IN adapter, or is this strictly a design where the dGPU
is the only valid DP source for the discrete TB controller on this class
of HP workstations?

Happy to share the DSDT dump, lspci -vvv, full dmesg, or run any test.

Regards,
Francesco Orro
