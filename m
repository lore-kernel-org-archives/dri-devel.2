Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBB3C5DF70
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:06:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BC3810E2F9;
	Sun, 16 Aug 2026 14:06:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="hdeUW5Ek";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8FA489226
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 14:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:From:Reply-To;
 bh=6U+o+LtByJrl528SG+t8HUNDNoQonun4hjUClgQ20+A=; b=hdeUW5EkSbGSgYO3JiAViGaGrC
 BNGthEErlBOewtNFYcBGxwo8QZLFy8dU0+XCH8WEVAOsFACT0N4D8xTA+Oe5xd8m5jCHGSC8ry/6u
 IDnSKTSm38ph4M7xqC6hm4yKywduZb5UIIGMZJ7ezGzY7GVAW+bLEBrpJlv5/QdlVm6CindxRrWck
 a62amdxfglGpESQhOlSuWPW89lyLyGEcVbv7IXPeQDkgExEGgZA6yWegjCuqW7KesYyoq+DgqdYqh
 SQzgxkdXmFmTma3krC2gnA6K8xBZ7jtBSh8R/z0jQ7vr6Js4e+0CI0SaLZJdDxVP12W7vxRxGnghH
 t6eFaHfA==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wvbUj-002tuI-O1; Sun, 16 Aug 2026 16:05:50 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH 0/4] drm/vc4: Reset the V3D block through the reset controller
Date: Sun, 16 Aug 2026 11:05:39 -0300
Message-Id: <20260816-vc4-reset-control-v1-0-896444373716@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MwQpAQBRG4VfRXbvFkPAqsmDmxy3N6I6k5N1Nl
 t/inIciVBCpzx5SXBIl+IQyz8huk1/B4pLJFKYp2tLwZWtWRJxsgz817GydWyrM7dSho9QdikX
 u/zmM7/sBVsH7F2MAAAA=
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
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2340; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=fCR0DhMM/c4JoZx1VI8ywyO79TCxSceFBK4cwUgoVk0=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqgcO4kEdNiHpKBu/9hcn2xxZAN+OUwb/oj6Ase
 5eS9azUrwyJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaoHDuAAKCRA/8w6Kdoj6
 qpNSB/41kda5XFtrP1Y7QQRulv5vHOaUp+qWemo/JFfnlmpCmF8MPtaqIzatSvXrtvJwIkoty0U
 z3LPRMIrEL1WUFZz7PUcFon6XP2LVeciB2ODQoUCXAW7NdV/O4hYgjyuOBgQIRZthAcCxlYAzhT
 lIyqwQA4jGAPJit422r/YQ5VaceaL5Bqjt/4Sj+bSw1YKoWFmtFOjsHo12o10hKJYzsLKr4L74e
 FXaiA0+QMv9t4IN0LPs3K7qGztzTMxO/67+ILY+8jdsp+2CGGeyjlJDcLk+FyVRuJBQ3ey39cg7
 lyf2ryMNUG3WCJWDj4ld0xZucAgdNed47yi0TFGOCCnkaMkS
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
removal on its own. It can be dropped from the series if it turns out
to be contentious.

This series was tested on the Raspberry Pi 3B and 3B+.

Best regards,
- Maíra

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
base-commit: 09b47186a4164f3aaa3591313f80794443117342
change-id: 20260812-vc4-reset-control-cddf3eb8a9e9

