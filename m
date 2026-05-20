Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB590CD5BAB
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 07:22:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 182BB10EF38;
	Wed, 20 May 2026 07:22:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="IPmUtgCZ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3526F10E0BC;
 Wed, 20 May 2026 07:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ziNkFX9leOffqkRMb/0gGdCV0ESeCrpswBpqxD9acBs=; b=IPmUtgCZCRVJP7aGS0jTIQl591
 0eQyzAtbE5yzvXOXU8CacydiqJda/xT8I914HLSmUu2nPTCJ8H6Qkw+anTMpcXd8OulccCNJQLOJg
 iX/7O+f/FH+FjWCe+NGoi3WGT8ArtS7iUZpd7vYNk2Ah+41iqxF0JFUvmvO67kr0emPsn73yVqHOP
 XbCoaN3hSVC7+o620k5+eLOdsDHycZvfOBAsNbZPuNHCowt81flouuwqnwILSTFHyMpkJtjA6Doqv
 ki7ALYI/8pet6ouCK0ADnsx/leaxd4QvfcuoLENHCXr0BuElABWeZtmLFLkTyM0jInP8IS5xVfO4B
 88ChxhVQ==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wPbFx-003hET-WB; Wed, 20 May 2026 09:22:18 +0200
Date: Wed, 20 May 2026 08:22:16 +0100
From: Tvrtko Ursulin <tursulin@igalia.com>
To: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dim-tools@lists.freedesktop.org
Subject: [PULL] drm-intel-fixes
Message-ID: <ag1hKBRKwwv9JOMW@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
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


Hi Dave, Sima,

A few display fixes for the current rc week. Fix for joiner color pipeline
selection to respect userspace input, fixing of target_rr in Adaptive Sync
SDP, and implementing some hardware workarounds for DPCD when SDP on prior
line is used.

Tvrtko

drm-intel-fixes-2026-05-20:
- Fix joiner color pipeline selection [display] (Chaitanya Kumar Borah)
- Fix readback for target_rr in Adaptive Sync SDP [dp] (Ankit Nautiyal)
- Apply Intel DPCD workaround when SDP on prior line used [psr] (Jouni Högander)
The following changes since commit 5200f5f493f79f14bbdc349e402a40dfb32f23c8:

  Linux 7.1-rc4 (2026-05-17 13:59:58 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/i915/kernel.git tags/drm-intel-fixes-2026-05-20

for you to fetch changes up to 4703049f768fc1c1caac754134118bee1a3af189:

  drm/i915/psr: Apply Intel DPCD workaround when SDP on prior line used (2026-05-19 08:03:17 +0100)

----------------------------------------------------------------
- Fix joiner color pipeline selection [display] (Chaitanya Kumar Borah)
- Fix readback for target_rr in Adaptive Sync SDP [dp] (Ankit Nautiyal)
- Apply Intel DPCD workaround when SDP on prior line used [psr] (Jouni Högander)

----------------------------------------------------------------
Ankit Nautiyal (1):
      drm/i915/dp: Fix readback for target_rr in Adaptive Sync SDP

Chaitanya Kumar Borah (1):
      drm/i915/display: Copy color pipeline from plane in the primary joiner pipe

Jouni Högander (3):
      drm/i915/psr: Add defininitions for INTEL_WA_REGISTER_CAPS DPCD register
      drm/i915/psr: Read Intel DPCD workaround register
      drm/i915/psr: Apply Intel DPCD workaround when SDP on prior line used

 drivers/gpu/drm/i915/display/intel_display_types.h |  1 +
 drivers/gpu/drm/i915/display/intel_dp.c            |  2 +-
 drivers/gpu/drm/i915/display/intel_dpcd.h          | 15 ++++++++
 drivers/gpu/drm/i915/display/intel_plane.c         |  2 +-
 drivers/gpu/drm/i915/display/intel_psr.c           | 44 +++++++++++++++++++---
 5 files changed, 57 insertions(+), 7 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/display/intel_dpcd.h
