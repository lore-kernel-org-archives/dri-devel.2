Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4833BC4451B
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 13:44:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC84510E582;
	Sat, 18 Jul 2026 13:44:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="erS2P8uE";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9130010E09F
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 13:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:From:Reply-To;
 bh=5QDfNZm1SXpMVAuKQU8dpNv+D9LyOGLaJq6QARVtgZE=; b=erS2P8uEke/kebul6dSxSrqngg
 kHlD536UCHeZbotMKKqxmbmhEidEjLka8v8x0o2GVqZIV0qjAq+OxKtuZjlaRMjdtS1l6dzmCZkGH
 TBmTXXFwhTo1G3XCjlLOF+1DnNPOjoqG5PzIb45crKT9pMO2UtSgCQ2jh7koerCP7jzBK7kbFwLi7
 PGHWq7qWSlWz0ItjiFPQA5dZm9FIUlU5mP35zSbPhuaxeoDQYlghBlgH7U78+/rxIL62ZIuVl8Wgf
 FM9p70RLQUhd6M1dz8OW4pXbqadyHxPZ/opeIUvWRV4B/HsPsn9yWY2eKMW9yDV1tc278pXCviST1
 aFuiNp4g==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wl5LP-00HSXW-3P; Sat, 18 Jul 2026 15:44:43 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH 0/2] drm/v3d: Idle AXI transactions before cutting the
 clock on suspend
Date: Sat, 18 Jul 2026 10:44:35 -0300
Message-Id: <20260718-v3d-pm-axi-transactions-v1-0-4ecd7729ed70@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MMQqAMAxA0atIZgOtghWvIg6xpprBKo2IULy7x
 fEP72dQTsIKQ5Uh8S0qRyxh6wr8RnFllKU0NKbpjLMO73bBc0d6BK9EUclfhSiSn/tgbLBd30L
 RZ+Igz38ep/f9AFncPrBpAAAA
X-Change-ID: 20260717-v3d-pm-axi-transactions-acb8f01f1683
To: Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1692; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=Fi8QIOb9K7bYcIqrYFmODak2CJg/CGA7R9SGbJYNntc=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqW4NINgRN/ThA4nwJf313ygU8rffh1qaNGpScd
 RrQm0PJ8V+JATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaluDSAAKCRA/8w6Kdoj6
 qtHrCADKrXm3vJDM/n6EuzMDQanqtVSZRuA3i91EV+cUQvxpHLyUDF4EJrD4ddy+du/+1/hl3Ld
 oNHLCbs7Fzx998K7o9NTnD8U4lZvK3rlsyq7QojkhfAkOshHY9qoXFbb8PAQTH/+szhVEhA8GXg
 WrcU/M+PfU3h8GCrk1g49axXwcu1YB7JB7PEeJJC0e/lShOpvhaaQvPidP1U5oczEfEfLj0ac8O
 fgJJ/aDJOEnfxaKYhVgRdlh7TUgP+OSm5Y6LEfcpXzhePL2KXjTHgBDNyHAfCDU3xrWlFVE2sEq
 3RRXv5MEjscYB+r/JIqqZqRLEztXmkV1Ab0x20WMxKAdSA/+
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

This series fixes a GPU hang seen on the first job submitted after a
runtime PM resume [1][2]. v3d_power_suspend() disables the GPU clock
without first quiescing the memory interface (AXI), so if the core still
has outstanding transactions in flight the hardware freezes
mid-transaction. That corrupted state survives the power cycle and surfaces
on resume as a GPU hang with an L2T "pte invalid" MMU fault.

The driver already implements the hardware's safe-powerdown sequence
(v3d_idle_axi(), plus v3d_idle_gca() on pre-4.1 HW), but the runtime PM
support added later never invoked it on powerdown.

Patch 1 fixes the GMP register access used by that sequence: on V3D 7.x
the GMP moved out of the per-core block into the hub register region, so
v3d_idle_axi() was touching the wrong registers. It comes first so the
sequence is correct on 7.x before patch 2 starts relying on it.

Patch 2 runs the safe-powerdown sequence in v3d_power_suspend(), while the
core is still powered, letting outstanding reads/writes drain before the
clock is disabled.

[1] https://github.com/raspberrypi/linux/issues/7443
[2] https://github.com/raspberrypi/linux/issues/7488

Best regards,
- Maíra

---
Maíra Canal (2):
      drm/v3d: Reach the GMP through the hub registers on V3D 7.x
      drm/v3d: Idle AXI transactions before disabling the clock on suspend

 drivers/gpu/drm/v3d/v3d_drv.h   |  2 ++
 drivers/gpu/drm/v3d/v3d_gem.c   | 16 ++++++++++++++--
 drivers/gpu/drm/v3d/v3d_power.c |  7 +++++++
 3 files changed, 23 insertions(+), 2 deletions(-)
---
base-commit: b0a652436b892eb9a036a031b33099dca036faaa
change-id: 20260717-v3d-pm-axi-transactions-acb8f01f1683

