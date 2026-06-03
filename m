Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB1E7CD6E6A
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 09:00:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A676113C66;
	Wed,  3 Jun 2026 09:00:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="CSwxv78H";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A1FB113C6E;
 Wed,  3 Jun 2026 09:00:34 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 6F850C62216;
 Wed,  3 Jun 2026 09:00:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 8E2B05FD24;
 Wed,  3 Jun 2026 09:00:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 819EC10888413; 
 Wed,  3 Jun 2026 11:00:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1780477229; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=7Ps8c5Pf/q4KonzIzGtVuavWdKey0/RYtJqxkkHgYGE=;
 b=CSwxv78HfY6ST3O/alIYSifZe4N40KbAE3LXpQ8APQkvfgfR5BVLlrC38t4B4jPnspJhyu
 ZWmjvNYZ0991xzLE6T7ZEH3iRx/7FeW1n0vk5dZ0/SQD8C+bXUF6iVVs10bAPG5vKp92/C
 9YiEhDWbQQm+aKS1vyEiskHx1Of7JEB0F/ge9Qnd3LUZYGHqYi6Dk+uJzdn/2D0torHUP9
 UFUJiEq+CTvXezu+z1HGsRO9jNjLWAUDKrJ+FX0KAAgCgSGy98xMLaZgn2tHwy29iAWm7E
 cTDyMhBvO+8+2ggTqEyDQ9ikNQmvkBAwqiFPbWgBEAF0GBNaTmOFTxFOH7tg2g==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH 0/3] drm/i915: Fix double cleanup in error paths
Date: Wed, 03 Jun 2026 10:59:51 +0200
Message-Id: <20260603-fix_i915-v1-0-7479ff64e705@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAftH2oC/yXM3wpAMBQH4FdZ59pqtiy8iqSZg+NitCGlvbvh8
 uv354aAnjBAzW7weFKg1SXkGQM7GzchpyEZpJBaaKH4SFdHVV7wwqqhtKLSWhpI9c1jyr6rpv0
 djn5Bu797iPEBpzmSw2wAAAA=
X-Change-ID: 20260603-fix_i915-5c3d8c09662a
To: Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Chris Wilson <chris@chris-wilson.co.uk>, 
 Eric Anholt <eric@anholt.net>, Dave Airlie <airlied@redhat.com>, 
 Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Mark Yacoub <markyacoub@google.com>, Sean Paul <seanpaul@google.com>, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Simona Vetter <simona.vetter@ffwll.ch>, 
 Kory Maincent <kory.maincent@bootlin.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.0
X-Last-TLS-Session-Version: TLSv1.3
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

Several error paths in the i915 driver incorrectly invoke cleanup
functions multiple times, potentially causing double-free errors.
This series corrects these paths to ensure cleanup is performed
only once.

Testing note: Only the DisplayPort fix has been hardware tested due
to lack of available hardware for the other components.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Kory Maincent (3):
      drm/i915/display/intel_sdvo: Fix double connector destroy in error paths
      drm/i915/display/intel_lvds: Drop redundant manual cleanup on init failure
      drm/i915/display/intel_dp: Drop redundant intel_dp_aux_fini() on init failure

 drivers/gpu/drm/i915/display/intel_dp.c   |  4 +---
 drivers/gpu/drm/i915/display/intel_lvds.c | 14 ++++----------
 drivers/gpu/drm/i915/display/intel_sdvo.c | 16 ++++------------
 3 files changed, 9 insertions(+), 25 deletions(-)
---
base-commit: e1696f1fc99dc0ff761a012230587b23dec064fb
change-id: 20260603-fix_i915-5c3d8c09662a

Best regards,
--  
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

