Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F59CA5FE6
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:50:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53D4310EAAA;
	Sun,  4 Oct 2026 16:50:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dCMKylm5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BF5210EAAA
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 16:50:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2583E42B14;
 Sun,  4 Oct 2026 16:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF0D1F000FF;
 Sun,  4 Oct 2026 16:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791132656;
 bh=91Y2GiYRfZm3zYM7GHdrGRZS+Ui5eJ/8VPfFHxi+JjI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dCMKylm5KREkHfQNqBKtcdDStkBrXLbNgXlsffc7LyvjOCpE0yCp79VsqDkp0x/4z
 sXCDHt+pXG4YMF/fVVFVLcIajLmhyWEXHJlxkid07IPL1VTQoG9jgtt1/nb0Sojcx6
 9bBQdApZ8ldWaG1RF0EDedoKG/9G0AHIaC7vWt9eNE0loo9Q8oq7TgvVapDZrGL68v
 +UOyt4KwjZl4JR1ogxGP5cvyxh7iypTNy44bEhEiXlwp2YJtADrmtOzqNNn5ox9GOW
 2y54jmNh9iVMmKX6W49E4/+W0/FteJyly8WKCiopeevbkgoVLnX0YunXST/wxNdJn4
 aJYErQria7Okg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] mfd: aat2870: Convert to use OF bindings
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: robh@kernel.org, lee@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org, mfd@lists.linux.dev,
 linux-leds@vger.kernel.org
In-Reply-To: <20261004164121.193514-3-clamor95@gmail.com>
References: <20261004164121.193514-1-clamor95@gmail.com>
 <20261004164121.193514-3-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 16:50:55 +0000
Message-Id: <20261004165055.8DF0D1F000FF@smtp.kernel.org>
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
- [High] regulator: UAF and memory leak due to shared static array in of_re=
gulator_match
- [Medium] video: backlight: functional regression when led-max-microamp is=
 missing
- [Low] video: backlight: incompatible pointer type in device_property_read=
_u32
--

commit 084e352aa2d7fee86a0e56df75d5d10cdd400379
Author: Svyatoslav Ryhel <clamor95@gmail.com>
Subject: mfd: aat2870: Convert to use OF bindings

This patch converts the AAT2870 driver to use OF bindings, replacing the
MFD registration API with of_platform_populate() and adding dedicated
compatible strings for its sub-devices. It also updates the regulator and
backlight child drivers to parse properties directly from the device tree
and removes redundant platform data.

In drivers/regulator/aat2870-regulator.c around line 133, there is a static
array defined for aat2870_regulator_matches. Later in aat2870_regulator_pro=
be()
around line 171, this shared static array is passed directly to
of_regulator_match().

[Severity: High]
Could passing this shared static array to of_regulator_match() cause a
use-after-free or memory leak if multiple AAT2870 devices are probed?
of_regulator_match() actively mutates the passed array to store device nodes
and binds its lifetime to the device via devres. If a second device probes,
it would overwrite the array, leaking the first device's nodes. Upon unbind,
devres would drop references to whatever nodes are currently in the array,
potentially causing a double-free or use-after-free for the remaining
references.

In drivers/video/backlight/aat2870_bl.c around line 141 in aat2870_bl_probe=
(),
the code calls device_property_read_u32() to read led-max-microamp into
aat2870_bl->max_current.

[Severity: Low]
Does this trigger an incompatible pointer types compiler warning?
aat2870_bl->max_current is declared as an int, but device_property_read_u32=
()
expects a u32 pointer.

Also in drivers/video/backlight/aat2870_bl.c around line 141, the max_curre=
nt
value is read via device_property_read_u32() without prior initialization.

[Severity: Medium]
Will the backlight permanently disable itself if the led-max-microamp prope=
rty
is omitted from the device tree? If the property is missing, max_current
remains 0. Passing 0 into clamp(0, 450, 27900) returns 450. When 450 is
divided by AAT2870_CURRENT_STEP (which is 900), the result evaluates to 0.
Since the brightness calculation multiplies by max_current, this appears to
leave the backlight permanently disabled under these conditions.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004164121.1935=
14-1-clamor95@gmail.com?part=3D2
