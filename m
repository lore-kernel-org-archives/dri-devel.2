Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9CEBC56201
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 20:07:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CDA310EB8D;
	Tue,  4 Aug 2026 20:07:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="qVvCF+Xg";
	dkim-atps=neutral
X-Greylist: delayed 403 seconds by postgrey-1.36 at gabe;
 Tue, 04 Aug 2026 20:07:10 UTC
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com
 [157.90.84.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61FAB10E881;
 Tue,  4 Aug 2026 20:07:10 +0000 (UTC)
Received: from wsembach-tuxedo.fritz.box (i5C75F579.versanet.de
 [92.117.245.121]) (Authenticated sender: wse@tuxedocomputers.com)
 by mail.tuxedocomputers.com (Postfix) with ESMTPA id 5C3E82FC0077;
 Tue,  4 Aug 2026 22:00:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
 s=default; t=1785873625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6LGJOIOEyjxvEXrEkaD3r+D7BiPhA55b01fl4ZX667g=;
 b=qVvCF+XgS5aX4oEjMF44Hflr86Zpv9xV3YMpZNxCJn6mFV10tRq6IucMWnIO24M/BW8h97
 J4IGfLss6CIEI+QH3bi4ZUXxEW5azRoA1vskyvjZBa56dNoD4/EyKMBklkwfgroI2E4Ghg
 6A4MTDIe5u/LGk1WqrPN7KhJNq3bhCE=
Authentication-Results: mail.tuxedocomputers.com;
 auth=pass smtp.auth=wse@tuxedocomputers.com
 smtp.mailfrom=wse@tuxedocomputers.com
From: Werner Sembach <wse@tuxedocomputers.com>
To: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net, airlied@gmail.com,
 simona@ffwll.ch
Cc: wse@tuxedocomputers.com, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/1] drm/i915/display: Add quirk to force backlight type on
 some TUXEDO devices
Date: Tue,  4 Aug 2026 21:52:46 +0200
Message-ID: <20260804200021.171947-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Since the proposed general fix, fixed the backlight on TUXEDO devices but
broke it on toher ones:
- https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/15679#note_3581777
- https://lore.kernel.org/all/20260515155340.1000997-1-suraj.kandpal@intel.com/
I'm back here again proposing the fix via quirk.

I therefore rebased
https://lore.kernel.org/all/20260121223944.1104951-1-wse@tuxedocomputers.com/
to cleanly apply on current drm-tip.

V1-V2: Switch from dmis trings to PCI-IDs
V2-V3: Rebase onto current drm-tip

Werner Sembach (1):
  drm/i915/display: Add quirk to force backlight type on some TUXEDO
    devices

 .../drm/i915/display/intel_dp_aux_backlight.c |  9 ++++++-
 drivers/gpu/drm/i915/display/intel_quirks.c   | 24 +++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_quirks.h   |  1 +
 3 files changed, 33 insertions(+), 1 deletion(-)


base-commit: 814bd7de7f09446c4b9401eecb8b30c3285af78b
-- 
2.43.0

