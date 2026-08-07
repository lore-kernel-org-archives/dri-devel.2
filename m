Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D795C5AC80
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 20:07:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7013E10E44E;
	Fri,  7 Aug 2026 20:07:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="Zney+X1+";
	dkim-atps=neutral
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com
 [157.90.84.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36AB488C4C;
 Fri,  7 Aug 2026 20:07:21 +0000 (UTC)
Received: from wsembach-tuxedo.buero.augsburg.tuxedo.de
 (host-212-18-30-247.customer.m-online.net [212.18.30.247])
 (Authenticated sender: wse@tuxedocomputers.com)
 by mail.tuxedocomputers.com (Postfix) with ESMTPA id 31CDF2FC0049;
 Fri,  7 Aug 2026 22:07:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
 s=default; t=1786133239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=92z7e6+vfZcMyJwAWZmIBOL5/EXTZgvHjPTNDym0thU=;
 b=Zney+X1+wxXYHv1GRhSBleITJyRuXtpYSkqNo7osqNe0LVsyP4fGBgaGqAVxiSWQYAPd/Y
 iWsevXszrCvb0XjuRuMDatLE83twB8cyo+Ma4q109OejMg1mhNNpARSbDDsULK9XfjI2Oj
 fNXFHWjaQzHCX42Dc9HNqTsG6RCbrZU=
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
Subject: [PATCH v4 0/1] drm/i915/display: Add quirk to force backlight type on
 some TUXEDO devices
Date: Fri,  7 Aug 2026 22:04:29 +0200
Message-ID: <20260807200709.464343-1-wse@tuxedocomputers.com>
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

Since the proposed general fix, fixed the backlight on TUXEDO devices, but
broke it on other ones:
- https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/15679#note_3581777
- https://lore.kernel.org/all/20260515155340.1000997-1-suraj.kandpal@intel.com/
I'm back here again proposing the fix via a quirk.

I therefore rebased
https://lore.kernel.org/all/20260121223944.1104951-1-wse@tuxedocomputers.com/
to cleanly apply on current drm-tip.

V1->V2: Switch from dmis trings to PCI-IDs
V2->V3: Rebase onto current drm-tip
V3->V4: Better commit message and added comment in code

Werner Sembach (1):
  drm/i915/display: Add quirk to force backlight type on some TUXEDO
    devices

 .../drm/i915/display/intel_dp_aux_backlight.c | 22 ++++++++++++++++-
 drivers/gpu/drm/i915/display/intel_quirks.c   | 24 +++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_quirks.h   |  1 +
 3 files changed, 46 insertions(+), 1 deletion(-)


base-commit: 665722ddd6884c57624bd82d7ab886cf11a7b6f8
-- 
2.43.0

