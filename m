Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3744C43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:21:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88D0F10E097;
	Thu,  2 Jul 2026 07:21:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="ClW4kagO";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B20C510E097;
 Thu,  2 Jul 2026 07:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1782976882;
 bh=SUeYEWvwLNnE6mZVedeWtrDvYb9EDhTCTdkSZZ3MxL8=;
 h=From:To:Cc:Subject:Date:From;
 b=ClW4kagOm7dguxmAIsr5/D3pZMzLdfOXap7nsRSH9wYntl9yAx0JJ5BpYfmUazdU1
 oUjI2/9mMSNEXm9n2KTORJfH7a2hTZnMgXIiIANeBS6HZ5q/1iO3t6kkNvka+zFZxl
 ZxYLYgOWRfXbRc5MP095ls94Ugy9pS3jlPD6PCo4PWgFg0QxSmn3j2zH7magUtL9pX
 1JWgHvDLhhns0lziYLvXAz1cvP5fyZwk8/3wkUrircqPmlBq1fxR2cs6+CKOa20W2+
 OJS2AdPc20dpQ6g6qFYvfsCoIStVUssX3qqvqj5gNENKfpRGHhpphoFdnIrBXFhunD
 wC9vRonQ+AALg==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-xe@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [PATCH 00/10] drm/intel/display: Changes required to make vblank
 evasion PREEMPT_RT safe.
Date: Thu,  2 Jul 2026 09:21:43 +0200
Message-ID: <20260702072154.171324-1-dev@lankhorst.se>
X-Mailer: git-send-email 2.53.0
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

CONFIG_PREEMPT_RT requires code to be as deterministic as possible,
and codes with interrupts disabled cannot use spinlocks.

In order to handle this correctly, we ensure any locking requirements
are handled before disabling interrupts, and only start locking again
after interrupts are re-enabled and timing sensitive path completed.

This also has the benefit of making the vblank evasion code more
deterministic; without locking there's much less jitter.

Previously, we scheduled vblank work on completion.
This is now handled by scheduling the vblank in advance, only arming
it upon completion without locks.

Maarten Lankhorst (9):
  drm/vblank_work: Add methods to schedule vblank_work in 2 stages
  drm/vblank: Add a 2-stage version of drm_crtc_arm_vblank_event
  drm/intel/display: Make intel_crtc_arm_vblank_event static
  drm/intel/display: Convert vblank event handling to 2-stage arming
  drm/i915/display: Move vblank put until after critical section
  drm/i915/display: Remove locking from intel_vblank_evade critical
    section
  drm/i915/display: Handle vlv dsi workaround in scanline_in_safe_range
    too
  drm/i915/display: Make get_vblank_counter use intel_de_read_fw()
  drm/i915/display: Do not take uncore lock in i915_get_vblank_counter

Mike Galbraith (1):
  drm/i915: Use preempt_disable/enable_rt() where recommended

 drivers/gpu/drm/drm_vblank.c                  |  64 +++++++++-
 drivers/gpu/drm/drm_vblank_work.c             | 110 +++++++++++++----
 drivers/gpu/drm/i915/display/intel_crtc.c     |  86 ++++++-------
 drivers/gpu/drm/i915/display/intel_crtc.h     |   1 -
 drivers/gpu/drm/i915/display/intel_cursor.c   |   8 +-
 drivers/gpu/drm/i915/display/intel_de.h       |   8 ++
 drivers/gpu/drm/i915/display/intel_vblank.c   | 115 ++++++++++--------
 drivers/gpu/drm/i915/display/intel_vblank.h   |   1 +
 drivers/gpu/drm/i915/intel_uncore.h           |  26 ++--
 .../drm/xe/compat-i915-headers/intel_uncore.h |   7 ++
 include/drm/drm_vblank.h                      |  14 ++-
 include/drm/drm_vblank_work.h                 |  12 ++
 12 files changed, 324 insertions(+), 128 deletions(-)

-- 
2.53.0

