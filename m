Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C3DDC88E77
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 20:54:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8099410E24B;
	Tue, 15 Sep 2026 20:54:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="pT//JWk4";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 316F910E1DE
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 20:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:From:Reply-To;
 bh=9A9zYbaJuUaZRgug8ZrC3s7r23JlUWaHGhxsMFd04OM=; b=pT//JWk4CYULM4N92ZYdKf5he0
 MiiO1JnHcatr6HpFTzc2qk+6ygvH8xWbjEf7HARV/jCxTT0yoRTPRnwKgfVs2qzdK675HtmFSAc6I
 mc0yoPFCQr1lwxHA0kFC4sGG0Ck3P6+2kxca+HDiSI/aQU6Nw/nk1rovfeSdHPdFYeExKfdOEgWvC
 8YQ6aLs2MLixN7oPWidKPXmao7SkjlYOm3GyZUVtjOPFjFOO76eLF1HpK8I94EjH3lUoRSOAKsYXY
 tnI843YISGp92vGzKMqIAO7NgCj5olK5Va68FFqhzjwz1QSg7sRDo5uiXFrrCoV4JJV50KKwTfdnH
 GRuPdBiA==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x6a7p-002dV8-UU; Tue, 15 Sep 2026 22:51:33 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH v2 0/4] drm/vc4: Reset the V3D block through the reset
 controller
Date: Tue, 15 Sep 2026 17:51:23 -0300
Message-Id: <20260915-vc4-reset-control-v2-0-cb3a25b07822@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQqDMBBFryKz7hQTQzRd9R7FRRpHHbBJSSS0i
 HdvKnTX5Xvw398gUWRKcKk2iJQ5cfAF5KkCN1s/EfJQGGQtdd0JidkpjJRoRRf8GsOCbhjGhu6
 dNWSg7J6RRn4dzVtfeOa0hvg+LrL42l9N/6llgTV2RiulmrZphb7yZBe2Zxce0O/7/gG+fI+xs
 wAAAA==
X-Change-ID: 20260812-vc4-reset-control-cddf3eb8a9e9
To: Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Stefan Wahren <wahrenst@gmx.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2509; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=NVdYQfItPJA0XXyEY3cnbJQtw+fh/ydqIH++dJRvtb8=;
 b=owGbwMvMwMVo/5mvq6zj1yrG02pJDFkr11/w51+myJ2++dRT3lDlV3d/n5xrFDU9xk5x+ypGL
 pt3ryS/dzIaszAwcjHIiimy/HgSW8soVs6uuaz8IswgViaQKQxcnAIwEaFM9r+y345kM750aW4P
 rtsf2ZQint7BeoHh28K9O5+6F7UqPvLuL9A7EhnW8Ndl/bLeD0ydOxUu8Z5hP13xpDbOJvZBQtf
 0H6+0HD7t7ljUzC5bE/ohPWDLm0cLth/XYzYStZUwmfeJVWTO04W7o30j8rNcd3yeUZT+wjFhcQ
 lbmJ28qXWDYLJXtXeewJMK65s3J7IrWqT96486dt5/t1M038RXZbb24i55WtGP7UrfzNb4fb5ZY
 GVjMsvxlUnd8e+tX+zduIXn+a3evmtr9sgfnsDpURodEPCk9HiOlI1sM79V0w4Bvt3bNPKzHRX9
 BW5dEvbqzLyTGa4dESlg9FfEM7zFIfpB+4cfbT92h1UDAA==
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

vc4_reset() recovers a hung GPU by dropping the runtime PM usage count to
zero so that the V3D power domain goes down, and then taking it again.
Forcing the count to zero only works if the driver knows exactly how many
references it holds, which is why vc4 unconventionaly wraps every
pm_runtime_get_sync() call in a private refcount and mutex, making the
code cumbersome.

The BCM2835 PM block has exposed a reset line for the V3D block since
commit 670c672608a1 ("soc: bcm: bcm2835-pm: Add support for power domains
under a new binding."), added for exactly this reason, but vc4 never
picked it up. This series switches vc4 over to it and drops the private
refcount, leaving vc4_v3d_pm_get/put() as plain runtime PM wrappers.

The reset line is optional, so device trees that do not describe one keep
working: they get the driver-side recovery in vc4_irq_reset() while the
hardware is left untouched. Of the two in-tree platforms,

  1. BCM2835 gains the property in PATCH 4.
  2. Cygnus has no V3D power domain to begin with, so the power-cycle
     only ever gated its clock there.

PATCH 1 is an independent cleanup. "brcm,vc4-v3d" was never documented
and was never used by any in-tree device tree, so it is a candidate for
removal on its own.

This series was tested on the Raspberry Pi 3B and 3B+.

Best regards,
- Maíra

---
v1 -> v2: https://lore.kernel.org/r/20260816-vc4-reset-control-v1-0-896444373716@igalia.com

- [1/4, 2/4, 3/4, 4/4] Add R-b and A-b tags from Krzysztof, Florian, and
  Stefan.
- [2/4] Rewrite commit message (Stefan, Krzysztof)

---
Maíra Canal (4):
      drm/vc4: Drop the undocumented brcm,vc4-v3d compatible
      dt-bindings: display: bcm2835-v3d: Add an optional reset line
      drm/vc4: Use the reset controller to recover from a GPU hang
      ARM: dts: bcm2835: Add the V3D reset line

 .../bindings/display/brcm,bcm2835-v3d.yaml         |  3 ++
 arch/arm/boot/dts/broadcom/bcm2835-common.dtsi     |  1 +
 drivers/gpu/drm/vc4/vc4_drv.c                      |  1 -
 drivers/gpu/drm/vc4/vc4_drv.h                      | 13 ++++---
 drivers/gpu/drm/vc4/vc4_gem.c                      | 40 +++++++++++++---------
 drivers/gpu/drm/vc4/vc4_irq.c                      |  7 ++--
 drivers/gpu/drm/vc4/vc4_v3d.c                      | 37 +++++++-------------
 7 files changed, 51 insertions(+), 51 deletions(-)
---
base-commit: 5363e01e4ff03a204cab85292b89cf90c2d1b101
change-id: 20260812-vc4-reset-control-cddf3eb8a9e9

