Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AEBCD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 07:55:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FE1D10E633;
	Wed, 27 May 2026 07:55:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="lzbgDWoD";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E56810E633;
 Wed, 27 May 2026 07:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2+QN22N9qdDPpgXew48ifaukLEDPIuwAqAK3Xk9HCcA=; b=lzbgDWoDNzEpA+YAhso7Vd1VaG
 KxRiaEPkCGQ/BnIocapN/oWeqpB8ly/PHNB7oWm7hju+v3ZK+Se7BM6xfiGhAeVlfq/vrRRMqtjXI
 KsmD1HuAscae8eIoYLkg/qjFTFS1niVQDyoyQWimRXiddCmSPs9nxnz2ev/QV41TWBDXM6wtG7RMH
 eP8yGty4OD18FQAKc9Op3VyjMQc5bLnUS00ojbDolZiKKoAhy3r6yh3YqiAmfwYNhSooIdJwMBq8h
 it06/+HnL/q35R6XYakM8bBhPstvOFtC8Uf6i0wzCqzehcLWNf+W+1zMGIHAQ+gMyAXcXYY7Jw9wn
 IznInetA==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wS977-008no5-Gh; Wed, 27 May 2026 09:55:41 +0200
Date: Wed, 27 May 2026 08:55:40 +0100
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
Message-ID: <ahajfPMJE_qKzig5@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Latest round of fixes for the -rc week.

One fix to address an use-after-free in the DG2 TTM integration under
heavy eviction and the rest are in the display area: A workaround for xe
enabling aux interrupts too late, fix for incomplete HDR pre-CSC LUT
programming, consistent disabling of DC states when Panel Replay is
supported and finally a fix for DC6 DC_OFF power state mismatch after
enabling vblanks.

Regards,

Tvrtko

drm-intel-fixes-2026-05-27:
- Fix potential UAF in TTM object purge (Janusz Krzysztofik)
- Use polling when irqs are unavailable [aux] (Michał Grzelak)
- Fix HDR pre-CSC LUT programming loop [color] (Pranay Samala)
- Block DC states on vblank enable when Panel Replay supported [psr] (Jouni Högander)
- Use DC_OFF wake reference to block DC6 on vblank enable [psr] (Jouni Högander)
The following changes since commit e7ae89a0c97ce2b68b0983cd01eda67cf373517d:

  Linux 7.1-rc5 (2026-05-24 13:48:06 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/i915/kernel.git tags/drm-intel-fixes-2026-05-27

for you to fetch changes up to 3549a9649dc7c5fc586ab12f675279283cdcb2a7:

  drm/i915/psr: Use DC_OFF wake reference to block DC6 on vblank enable (2026-05-26 09:31:48 +0100)

----------------------------------------------------------------
- Fix potential UAF in TTM object purge (Janusz Krzysztofik)
- Use polling when irqs are unavailable [aux] (Michał Grzelak)
- Fix HDR pre-CSC LUT programming loop [color] (Pranay Samala)
- Block DC states on vblank enable when Panel Replay supported [psr] (Jouni Högander)
- Use DC_OFF wake reference to block DC6 on vblank enable [psr] (Jouni Högander)

----------------------------------------------------------------
Janusz Krzysztofik (1):
      drm/i915: Fix potential UAF in TTM object purge

Jouni Högander (2):
      drm/i915/psr: Block DC states on vblank enable when Panel Replay supported
      drm/i915/psr: Use DC_OFF wake reference to block DC6 on vblank enable

Michał Grzelak (1):
      drm/i915/aux: use polling when irqs are unavailable

Pranay Samala (1):
      drm/i915/color: Fix HDR pre-CSC LUT programming loop

 drivers/gpu/drm/i915/display/intel_color.c         |  2 +-
 drivers/gpu/drm/i915/display/intel_display_core.h  |  1 +
 drivers/gpu/drm/i915/display/intel_display_irq.c   |  8 +++++--
 drivers/gpu/drm/i915/display/intel_display_types.h |  2 ++
 drivers/gpu/drm/i915/display/intel_dp_aux.c        | 20 ++++++++++++----
 drivers/gpu/drm/i915/display/intel_psr.c           | 25 ++++++++-----------
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c            | 28 ++++++++++++----------
 7 files changed, 52 insertions(+), 34 deletions(-)
